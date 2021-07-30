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
        print("INIT: ADD TASK SCREEN")
    }
    var body: some View {
        VStack {
            Form {
                
                Section {
                    TextField("Title", text: $vm.title)
                        .font(.title2)
                        .padding()
                        .background(Color.theme.accent.cornerRadius(12))
                        .padding(.bottom, 8)
                    
                    
                    
                    DatePicker("Date", selection: $vm.date, in: Date()..., displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.theme.accent.cornerRadius(12))
                        .accentColor(Color.theme.gradientPurple)
                    
                    
                }
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))
                
                
                Section(
                    header: Text("Duration")
                        .bold()
                        .font(.title3)
                ){
                    
                    CircularMinutePickerView(minutes: $vm.durationMinutes)
                    .padding(.bottom, 8)
                    
                
                    
                    TimeStepperView(title: "Hours", value: $vm.durationHours, lowerBound: 0, upperBound: 24)
                    
                    
                    
                }
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))
                
                
                
                
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
                    
                    NavigationLink(
                        destination: MultipleSelectionList(items: tasksVM.tags, selections: $vm.selectedTags, limit: 2).navigationTitle("Select Tags"),
                        label: {
                            HStack {
                                Text("Tags")
                                Spacer()
                                ForEach(vm.selectedTags, id: \.id) { tag in
                                    TagView(tag: tag)
                                }
                            }
                        }
                    )
                    .font(.title2)
                    .padding()
                    .background(Color.theme.accent.cornerRadius(12))
                    .padding(.bottom, 8)
                }
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemBackground))
                
                
                
                Section {
                    MainButtonView(action: {
                        tasksVM.addTask(vm.generateTaks())
                    }, label: "Create")
                }
                
            }
            .bottomSheet(isPresented: $vm.showIconPicker, height: UIScreen.main.bounds.height / 2) {
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
        }
    }
}

struct AddTask_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            NavigationView {
//
//            MultipleSelectionList(items: TasksEnvironmentViewModel().tags, selections: .constant([]), limit: 2)
//                .navigationTitle("Select Tags")
//            }
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



struct MultipleSelectionList: View {
    var items: [Tag]
    @Binding var selections: [Tag]
    
    var columns: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width / 4) - 5)),
        GridItem(.fixed((UIScreen.main.bounds.width / 4) - 5)),
        GridItem(.fixed((UIScreen.main.bounds.width / 4) - 5)),
        GridItem(.fixed((UIScreen.main.bounds.width / 4) - 5))
    ]
    var limit: Int
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(self.items, id: \.id) { item in
                    MultipleSelectionRow(tag: item, isSelected: isSelectedTag(selectedTags: self.selections, tag: item)) {
                        onSelect(item: item)
                    }
                }
            }
            Spacer()
        }
    }
    
    func isSelectedTag(selectedTags: [Tag], tag: Tag) -> Bool {
        return selectedTags.contains { tagItem in
            return (tagItem.id == tag.id)
        }
    }
    
    func onSelect(item: Tag) {
        if isSelectedTag(selectedTags: self.selections, tag: item) {
            self.selections.removeAll(where: { $0.id == item.id })
        }
        else if(self.selections.count < limit){
            self.selections.append(item)
        }
        else {
            return
        }
    }
}

struct MultipleSelectionRow: View {
    var tag: Tag
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                TagView(tag: tag)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

