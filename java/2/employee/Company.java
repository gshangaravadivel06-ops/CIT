public class Company {

    // Base class
    static abstract class Employee {
        protected String name;
        protected String address;
        protected double salary;
        protected String jobTitle;

        public Employee(String name, String address, double salary, String jobTitle) {
            this.name = name;
            this.address = address;
            this.salary = salary;
            this.jobTitle = jobTitle;
        }

        public abstract double calculateBonus();
        public abstract void generatePerformanceReport();
        public abstract void manageProjects();
    }

    // Subclass: Manager
    static class Manager extends Employee {
        public Manager(String name, String address, double salary) {
            super(name, address, salary, "Manager");
        }

        @Override
        public double calculateBonus() {
            return salary * 0.20;
        }

        @Override
        public void generatePerformanceReport() {
            System.out.println(jobTitle + " " + name + " generated team performance report.");
        }

        @Override
        public void manageProjects() {
            System.out.println(jobTitle + " " + name + " is overseeing multiple company projects.");
        }
    }

    // Subclass: Developer
    static class Developer extends Employee {
        public Developer(String name, String address, double salary) {
            super(name, address, salary, "Developer");
        }

        @Override
        public double calculateBonus() {
            return salary * 0.15;
        }

        @Override
        public void generatePerformanceReport() {
            System.out.println(jobTitle + " " + name + " submitted monthly code performance report.");
        }

        @Override
        public void manageProjects() {
            System.out.println(jobTitle + " " + name + " is working on backend and frontend modules.");
        }
    }

    // Subclass: Programmer
    static class Programmer extends Employee {
        public Programmer(String name, String address, double salary) {
            super(name, address, salary, "Programmer");
        }

        @Override
        public double calculateBonus() {
            return salary * 0.10;
        }

        @Override
        public void generatePerformanceReport() {
            System.out.println(jobTitle + " " + name + " submitted debugging and feature updates report.");
        }

        @Override
        public void manageProjects() {
            System.out.println(jobTitle + " " + name + " is handling small-scale projects individually.");
        }
    }

    // Main method
    public static void main(String[] args) {
        Employee manager = new Manager("Alice Johnson", "123 Main St", 90000);
        Employee developer = new Developer("Bob Smith", "456 Oak St", 75000);
        Employee programmer = new Programmer("Charlie Davis", "789 Pine St", 60000);

        Employee[] employees = {manager, developer, programmer};

        for (Employee emp : employees) {
            System.out.println("\n--- " + emp.jobTitle + " ---");
            System.out.println("Name: " + emp.name);
            System.out.println("Address: " + emp.address);
            System.out.println("Salary: $" + emp.salary);
            System.out.println("Bonus: $" + emp.calculateBonus());
            emp.generatePerformanceReport();
            emp.manageProjects();
        }
    }
}
