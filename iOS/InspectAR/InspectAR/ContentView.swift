//
//  ContentView.swift
//  InspectAR
//
//  Created by Yu Ho Kwok on 23/11/2022.
//

import SwiftUI
import PhotosUI

struct Inspection : Identifiable, Hashable {
    var id : String = UUID().uuidString
    var name : String
    var image : String = "vendor"
    var officer : String = "David Shum"
    var date : String = "2022-10-12"
    var status : String = "Completed"
    var isComplete : Bool = true
}

struct ContentView: View {
    
    @State var arCode = 0
    //, Inspection(name: "CSWCSS Vendor Machine")
    @State var inspections = [Inspection(name: "IVE(ST) Statue", image: "ive", officer: "Sunny Ha", date: "2022-04-18", status: "Commented")]
    var completed = [Inspection(name: "228 Princess Road", image: "road", officer: "Chun Wong", date: "2022-09-01"),
                     Inspection(name: "IVE(CW) Room 427A", image: "427a", officer: "Sunny Ha", date: "2022-03-22"),
                     Inspection(name: "Carlton Mall Dinsor Project", image: "dino", officer: "Jack Tsoi", date: "2022-02-16")]
    
    @State private var showingAlert = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil

    @State private var showingSheet = false
    
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading) {
                
                
                
                Spacer()
                Text("417 Technology & Inspection Co. Ltd")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(10)
                
                List {
                    
                    Section {
                        ForEach (0..<inspections.count, id:\.self) {
                            i in
                            
                            Button(action: {
                                
                                if inspections[i].status == "Loading" {
                                    inspections[i].status = "Under Inspection"
                                } else {
                                    if inspections.count == 1 {
                                        arCode = 1
                                        print("arCode is 0")
                                        showingSheet = true
                                        print("showing Sheet is true")
                                    } else {
                                        arCode = i
                                        print("arCode is 0")
                                        showingSheet = true
                                        print("showing Sheet is true")
                                    }
                                }
                            }, label: {
                                HStack {
                                    
                                    Image(inspections[i].image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    VStack (alignment: .leading) {
                                        Text("\(inspections[i].name)")
                                        Text("Officer \(inspections[i].officer)").font(.footnote)
                                            .foregroundColor(.gray.opacity(0.5))
                                        Text("Date: \(inspections[i].date)").font(.footnote)
                                            .foregroundColor(.gray.opacity(0.5))
                                        Text("\(inspections[i].status)").font(.footnote)
                                            .foregroundColor(.orange)
                                    }
                                    
                                    
                                }
                            })
                        }
                    } header: {
                        Text("On going inspections")
                    }
                    
                    Section {
                        ForEach (0..<completed.count, id:\.self) {
                            i in
                            
                            let inspection = completed[i]
                            
                            Button(action: {
                                arCode = 10 + i
                                print("arCode is 1")
                                showingSheet = true
                                print("showing Sheet is true")
                                
                            }, label: {
                                HStack {

                                    Image(inspection.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                    VStack (alignment: .leading) {
                                        Text("\(inspection.name)")
                                        Text("Officer \(inspection.officer)").font(.footnote)
                                            .foregroundColor(.gray.opacity(0.5))
                                        Text("Date: \(inspection.date)").font(.footnote)
                                            .foregroundColor(.gray.opacity(0.5))
                                        Text("\(inspection.status)").font(.footnote)
                                            .foregroundColor(.green)
                                    }
                                    
                                    
                                }
                            })
                            
                        }
                    } header: {
                        Text("Completed Inspections")
                    }
                }
            }
 
            .navigationTitle("Projects")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing,
                            content: {
                    
                    HStack {
                        
                        Button( action: {
                            
                        }, label: {
                            Image(systemName: "video")
                        })
                        
                        PhotosPicker(
                            selection: $selectedItem,
                            matching: .videos,
                            photoLibrary: .shared()) {
                                Image(systemName: "rectangle.stack.badge.plus")
                            }
                            .onChange(of: selectedItem) { newItem in
                                
                                if inspections.count  == 1{
                                    let ins = Inspection(name: "CSWCSS Vendor Machine", image: "vendor", officer: "Chun Wong", date: "2022-11-23", status: "Loading")
                                    //self.inspections.append(ins)
                                    self.inspections.insert(ins, at: 0)
                                    
                                    Task {
                                        // Retrieve selected asset in the form of Data
                                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                            selectedImageData = data
                                        }
                                    }
                                }
                            }
                        
                    }
                })
            })
        }
        .sheet(isPresented: $showingSheet) {
            LearnARView(arCode: $arCode)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





//if let selectedImageData,
//   let uiImage = UIImage(data: selectedImageData) {
//    Image(uiImage: uiImage)
//        .resizable()
//        .scaledToFit()
//        .frame(width: 250, height: 250)
//}
