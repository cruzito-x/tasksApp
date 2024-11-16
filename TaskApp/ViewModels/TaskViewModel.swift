import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published private var tasks: [Task] = []
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func addTask(title: String) {
        let newTask = Task(title: title)
        tasks.append(newTask)
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
    
    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
    }
}
