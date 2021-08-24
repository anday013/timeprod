//
//  AddTask.swift
//  TimePad
//
//  Created by Anday on 22.07.21.
//

import SwiftUI
import BottomSheet

struct AddTaskScreenView: View {
    @StateObject var vm: AddTaskViewModel = AddTaskViewModel()
    @EnvironmentObject var tasksVM: TasksEnvironmentViewModel
    var columns: [GridItem] = [
        GridItem(.fixed(Size.computeWidth(50))),
        GridItem(.fixed(Size.computeWidth(50))),
        GridItem(.fixed(Size.computeWidth(50)))
    ]
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        for _ in 1...(Int(UIScreen.main.bounds.width / Size.computeWidth(50))-4){
            columns.append(GridItem(.fixed(Size.computeWidth(50))))
        }
    }
    var body: some View {
        VStack {
            Form {
                topSection.blur(radius: vm.showMinutePicker ? 20 : 0)
                
                durationSection
                
                descriptionSection.blur(radius: vm.showMinutePicker ? 20 : 0)
                
                
                submitButtonSection.blur(radius: vm.showMinutePicker ? 20 : 0)
                
            }
            .bottomSheet(isPresented: $vm.showIconPicker, height: UIScreen.main.bounds.height / 2) {
                bottomSheetView
            }
        }
    }
    
    func addSelectedTag(tag: Tag) {
        if vm.selectedTags.count < 2 {
            vm.selectedTags.append(tag)
        }
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddTaskScreenView()
                    .navigationTitle("New Task 🔖")
            }
            
            NavigationView {
                AddTaskScreenView()
                    .navigationTitle("New Task 🔖")
                    .preferredColorScheme(.dark)
            }
        }.environmentObject(TasksEnvironmentViewModel())
    }
}

extension AddTaskScreenView {
    private var topSection: some View {
        Section {
            TextField("Title", text: $vm.title)
                .font(.title2)
                .disableAutocorrection(true)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(vm.isTitleValid ? Color.clear : Color.red, lineWidth: 2).background(Color.theme.accent)
                )
                .padding(.bottom, 8)
            
            
            
            
            DatePicker("Date", selection: $vm.date, in: Date()...)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                .background(Color.theme.accent.cornerRadius(12))
                .accentColor(Color.theme.gradientPurple)
            
            
        }
        .listRowInsets(EdgeInsets())
        .background(Color(UIColor.systemBackground))
    }
    
    
    private var durationSection: some View {
        Section(
            header: Text("Duration")
                .bold()
                .font(.title3)
        ){
            
            CircularMinutePickerView(minutes: $vm.durationMinutes, showPicker: $vm.showMinutePicker)
                .overlay(validationDurationBorder)
                .padding(.bottom, 8)
            
            
            TimeStepperView(title: "Hours", value: $vm.durationHours, lowerBound: 0, upperBound: 24).blur(radius: vm.showMinutePicker ? 20 : 0)
                .overlay(validationDurationBorder)
            
            
            
        }
        .listRowInsets(EdgeInsets())
        .background(Color(UIColor.systemBackground))
    }
    
    private var descriptionSection: some View {
        Section(
            header: Text("Description")
                .bold()
                .font(.title3)
        ){
            
            Button(action: {
                vm.showIconPicker.toggle()
            }, label: {
                HStack {
                    Text("Icon")
                        .font(.title2)
                    Spacer()
                    IconView(icon: vm.selectedIcon)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundColor(.primary)
                }
            })
            .padding()
            .background(Color.theme.accent.cornerRadius(12))
            .foregroundColor(Color.primary)
            .padding(.bottom, 8)
            
            
            VStack {
                HStack {
                    Text("Select Tags")
                    Spacer()
                    ForEach(vm.selectedTags, id: \.id) { tag in
                        TagView(tag: tag)
                            .onTapGesture {
                                guard let index = vm.selectedTags.firstIndex(where: {$0.id == tag.id}) else {return}
                                vm.selectedTags.remove(at: index)
                            }
                    }
                }
                Circle().frame(height: 1)
                    .background(Color.theme.gradientPurple)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(tasksVM.tags
                                    .filter({ t in
                                        return (vm.selectedTags.first(where: {$0.id == t.id}) == nil)
                                    }), id: \.id)
                        { tag in
                            TagView(tag: tag)
                                .onTapGesture(perform: {addSelectedTag(tag: tag)})
                        }
                    }
                }
            }
            .font(.title2)
            .padding()
            .background(Color.theme.accent.cornerRadius(12))
            .padding(.bottom, 8)
        }
        .listRowInsets(EdgeInsets())
        .background(Color(UIColor.systemBackground))
    }
    
    
    private var bottomSheetView: some View {
        VStack {
            Text("Choose an icon...")
                .bold()
                .font(.title2)
            
            LazyVGrid(columns: columns, content: {
                ForEach(tasksVM.icons, id: \.id) { icon in
                    Button(action: {
                        vm.selectedIcon = icon
                        vm.showIconPicker.toggle()
                    }, label: {
                        IconView(icon: icon)
                    })
                }
            })
            
            Spacer()
        }
    }
    
    private var submitButtonSection: some View {
        Section {
            MainButtonView(action: {
                vm.submitForm(tasksVM: tasksVM)
            }, label: "Create")
            
        }.accentColor(Color.theme.accent)
    }
    
    private var validationDurationBorder: some View {
        RoundedRectangle(cornerRadius: 12, style: .continuous).stroke(vm.isDurationValid ? Color.clear : Color.red, lineWidth: 2)
    }
}


