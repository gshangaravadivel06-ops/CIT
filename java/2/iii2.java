public class iii2 {

    // Base class
    static class Employee {
        protected String name;
        protected double salary;

        public Employee(String name, double salary) {
            this.name = name;
            this.salary = salary;
        }

        public void work() {
            System.out.println(name + " is working.");
        }

        public double getSalary() {
            return salary;
        }
    }

    // Subclass
    static class HRManager extends Employee {

        public HRManager(String name, double salary) {
            super(name, salary);
        }

        // Override work() method
        @Override
        public void work() {
            System.out.println(name + " is managing HR-related tasks.");
        }

        // New method
        public void addEmployee(String newEmployeeName) {
            System.out.println(name + " added new employee: " + newEmployeeName);
        }
    }

    // Main method
    public static void main(String[] args) {
        Employee generalEmployee = new Employee("John Doe", 50000);
        HRManager hr = new HRManager("Sarah Smith", 70000);

        // Call methods on Employee
        generalEmployee.work();
        System.out.println("Salary: $" + generalEmployee.getSalary());

        // Call methods on HRManager
        hr.work(); // overridden method
        System.out.println("Salary: $" + hr.getSalary());
        hr.addEmployee("Emily Clark"); // new method
    }
}
