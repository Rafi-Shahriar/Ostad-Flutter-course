// Assignment: OOP in Dart
// Includes Task 1, Task 2, and Task 3

// --------------------
// Task 1: Book Class
// --------------------
class Book {
  Book({required this.title, required this.author, required this.price});

  String title;
  String author;
  double price;

  double getDiscountedPrice(double discountPercentage) {
    return (price - ((price * discountPercentage) / 100));
  }

  void displayInformation({required double discountPercentage}) {
    print("\n--- Book Information ---");
    print("Title: ${title}");
    print("Author: ${author}");
    print("Original Price: \$${price}");
    print("Discounted Price: \$${getDiscountedPrice(discountPercentage)}");
  }
}

// --------------------
// Task 2: Employee Inheritance
// --------------------
class Employee {
  Employee({required this.name, required this.salary});

  String name;
  int salary;

  void displayInformation() {
    print("\n--- Employee Information ---");
    print("Name: ${name}");
    print("Salary: \$${salary}");
  }
}

class Manager extends Employee {
  Manager({required String name, required int salary, required this.department})
    : super(name: name, salary: salary);

  String department;

  @override
  void displayInformation() {
    super.displayInformation();
    print("Department: ${department}");
  }
}

class Developer extends Employee {
  Developer({
    required String name,
    required int salary,
    required this.programmingLanguage,
  }) : super(name: name, salary: salary);

  String programmingLanguage;

  @override
  void displayInformation() {
    super.displayInformation();
    print("Programming Language: ${programmingLanguage}");
  }
}

// --------------------
// Task 3: Abstract Class Appliance
// --------------------
abstract class Appliance {
  void turnOn();
  void turnOff();
}

class Fan extends Appliance {
  @override
  void turnOn() {
    print("\n--- Fan Status ---");
    print("Fan is now running.");
  }

  @override
  void turnOff() {
    print("\n--- Fan Status ---");
    print("Fan has now stopped.");
  }
}

class Light extends Appliance {
  @override
  void turnOn() {
    print("\n--- Light Status ---");
    print("Light is switched on.");
  }

  @override
  void turnOff() {
    print("\n--- Light Status ---");
    print("Light is switched off.");
  }
}

// --------------------
// Main Function
// --------------------
void main() {
  // Task 1 Demo
  Book book1 = Book(
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    price: 15.99,
  );
  Book book2 = Book(title: "1984", author: "George Orwell", price: 12.49);

  book1.displayInformation(discountPercentage: 10);
  book2.displayInformation(discountPercentage: 15);

  // Task 2 Demo
  Manager manager = Manager(name: "Alice", salary: 90000, department: "Sales");
  Developer developer = Developer(
    name: "Bob",
    salary: 80000,
    programmingLanguage: "Dart",
  );

  manager.displayInformation();
  developer.displayInformation();

  // Task 3 Demo
  Fan fan = Fan();
  Light light = Light();

  fan.turnOn();
  fan.turnOff();

  light.turnOn();
  light.turnOff();
}
