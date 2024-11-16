import SwiftUI

struct TaskListView: View {
    @StateObject private var viewModel = TaskViewModel() // Usar StateObject aquí
    @State private var newTaskTitle: String = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Nueva tarea", text: $newTaskTitle)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addNewTask) {
                        Text("Agregar")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()

                List {
                    ForEach(viewModel.getTasks().indices, id: \.self) { index in
                        let task = viewModel.getTasks()[index]
                        HStack {
                            Text(task.title)
                                .strikethrough(task.isCompleted, color: .gray)
                            Spacer()
                            Button(action: {
                                viewModel.toggleTaskCompletion(at: index)
                            }) {
                                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(task.isCompleted ? .green : .gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteTask)
                }
                .navigationTitle("Lista de Tareas")
            }
        }
    }

    private func addNewTask() {
        guard !newTaskTitle.isEmpty else { return }
        viewModel.addTask(title: newTaskTitle)
        newTaskTitle = ""  // Limpiar el campo de texto
    }

    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            viewModel.deleteTask(at: index)
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
