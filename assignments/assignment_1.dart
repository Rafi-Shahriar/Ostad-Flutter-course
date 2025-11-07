import 'dart:io';

void main() {
  // Initialize data structures
  List<Map<String, dynamic>> students = [];
  Set<int> usedIds = {};

  // Infinite loop - exits only when user chooses option 7
  while (true) {
    // Display Menu
    print('\n========================================');
    print('    STUDENT MANAGEMENT SYSTEM');
    print('========================================');
    print('1. Add Students');
    print('2. Display All Students (Sorted)');
    print('3. Update Student Information');
    print('4. Delete Student Information');
    print('5. Display Highest and Lowest Marks');
    print('6. Total Number of Students');
    print('7. Exit');
    print('========================================');
    stdout.write('Enter your choice (1-7): ');

    // Get user choice with validation
    var input = stdin.readLineSync() ?? '';
    int? choice = int.tryParse(input);

    if (choice == null) {
      print('\nInvalid input! Please enter a number between 1-7.');
      continue;
    }

    // Switch statement for menu operations
    switch (choice) {
      case 1:
        // ========== ADD STUDENTS ==========
        print('\n========== ADD STUDENTS ==========');

        // Get number of students to add
        int studentCount;
        while (true) {
          stdout.write('How many students do you want to add? ');
          var countInput = stdin.readLineSync() ?? '';
          int? tempCount = int.tryParse(countInput);

          if (tempCount == null || tempCount <= 0) {
            print('Please enter a valid positive number.');
          } else {
            studentCount = tempCount;
            break;
          }
        }

        // Loop for each student
        for (int i = 1; i <= studentCount; i++) {
          print('\n--- Student $i of $studentCount ---');

          // ===== GET STUDENT ID =====
          int studentId = 0;
          bool skipStudent = false;

          while (true) {
            stdout.write('Enter Student ID: ');
            var idInput = stdin.readLineSync() ?? '';
            int? tempId = int.tryParse(idInput);

            if (tempId == null || tempId <= 0) {
              print('Invalid ID! Please enter a positive number.');
              continue;
            }

            // Check if ID already exists
            if (usedIds.contains(tempId)) {
              print('Student ID $tempId already exists!');
              print('Choose an option:');
              print('1. Enter another student ID');
              print('2. Skip this student');
              stdout.write('Enter choice (1 or 2): ');

              var duplicateChoice = stdin.readLineSync() ?? '';
              int? dupChoice = int.tryParse(duplicateChoice);

              if (dupChoice == 2) {
                print('Skipping this student...');
                skipStudent = true;
                break; // Exit the while loop
              } else if (dupChoice == 1) {
                // Loop continues, ask for ID again
                continue;
              } else {
                print('Invalid choice. Please enter ID again.');
                continue;
              }
            } else {
              // ID is unique and valid
              studentId = tempId;
              break; // Exit the while loop
            }
          }

          // If user chose to skip, continue to next student
          if (skipStudent) {
            continue;
          }

          // ===== GET STUDENT NAME =====
          String studentName = '';
          while (true) {
            stdout.write('Enter Student Name: ');
            var nameInput = stdin.readLineSync() ?? '';

            if (nameInput.trim().isEmpty) {
              print('Name cannot be empty!');
            } else {
              studentName = nameInput.trim();
              break;
            }
          }

          // ===== GET STUDENT SCORE =====
          num studentScore = 0;

          while (true) {
            stdout.write('Enter Student Score (0-100): ');
            var scoreInput = stdin.readLineSync() ?? '';
            num? tempScore = num.tryParse(scoreInput);

            if (tempScore == null) {
              print('Invalid score! Please enter a number.');
            } else if (tempScore < 0 || tempScore > 100) {
              print('Score must be between 0 and 100!');
            } else {
              studentScore = tempScore;
              break; // Valid score, exit loop
            }
          }

          // ===== CALCULATE GRADE =====
          String grade;

          if (studentScore >= 97) {
            grade = 'A+';
          } else if (studentScore >= 90) {
            grade = 'A';
          } else if (studentScore >= 85) {
            grade = 'A-';
          } else if (studentScore >= 80) {
            grade = 'B+';
          } else if (studentScore >= 75) {
            grade = 'B';
          } else if (studentScore >= 70) {
            grade = 'B-';
          } else if (studentScore >= 65) {
            grade = 'C+';
          } else if (studentScore >= 60) {
            grade = 'C';
          } else if (studentScore >= 57) {
            grade = 'C-';
          } else if (studentScore >= 55) {
            grade = 'D+';
          } else if (studentScore >= 52) {
            grade = 'D';
          } else if (studentScore >= 50) {
            grade = 'D-';
          } else {
            grade = 'F';
          }

          // ===== ADD STUDENT TO LIST AND SET =====
          students.add({
            'id': studentId,
            'name': studentName,
            'score': studentScore,
            'grade': grade,
          });

          usedIds.add(studentId);

          print('Student added successfully!');
          print(
            '   ID: $studentId | Name: $studentName | Score: $studentScore | Grade: $grade',
          );
        }

        print('\nAll students added successfully!');
        break;

      case 2:
        // ========== DISPLAY ALL STUDENTS (SORTED) ==========
        print('\n========== ALL STUDENTS (SORTED BY SCORE) ==========');

        // Check if there are any students
        if (students.isEmpty) {
          print('No students to display! Please add students first.');
          break;
        }

        // Create a copy of the students list
        List<Map<String, dynamic>> sortedStudents = [];
        for (int i = 0; i < students.length; i++) {
          sortedStudents.add(students[i]);
        }

        // Bubble Sort - Descending order by score
        for (int i = 0; i < sortedStudents.length - 1; i++) {
          for (int j = 0; j < sortedStudents.length - i - 1; j++) {
            if (sortedStudents[j]['score'] < sortedStudents[j + 1]['score']) {
              // Swap
              var temp = sortedStudents[j];
              sortedStudents[j] = sortedStudents[j + 1];
              sortedStudents[j + 1] = temp;
            }
          }
        }

        // Display sorted students
        print('\n${'=' * 60}');
        print('Rank | ID     | Name                | Score  | Grade');
        print('${'=' * 60}');

        for (int i = 0; i < sortedStudents.length; i++) {
          int rank = i + 1;
          int id = sortedStudents[i]['id'];
          String name = sortedStudents[i]['name'];
          num score = sortedStudents[i]['score'];
          String grade = sortedStudents[i]['grade'];

          // Format name to fit in column (max 20 characters)
          String displayName = name.length > 20
              ? name.substring(0, 17) + '...'
              : name;

          print(
            '${rank.toString().padLeft(4)} | ${id.toString().padLeft(6)} | ${displayName.padRight(19)} | ${score.toString().padLeft(6)} | $grade',
          );
        }

        print('${'=' * 60}');
        print('Total Students: ${sortedStudents.length}');
        print('${'=' * 60}');
        break;

      case 3:
        // ========== UPDATE STUDENT INFORMATION ==========
        print('\n========== UPDATE STUDENT INFORMATION ==========');

        // Check if there are any students
        if (students.isEmpty) {
          print('No students to update! Please add students first.');
          break;
        }

        // ===== GET STUDENT ID TO UPDATE =====
        int studentIndex = -1;
        bool skipUpdate = false;

        while (true) {
          stdout.write('Enter Student ID to update: ');
          var idInput = stdin.readLineSync() ?? '';
          int? searchId = int.tryParse(idInput);

          if (searchId == null) {
            print('Invalid ID! Please enter a number.');
            continue;
          }

          // Search for student with this ID
          bool found = false;
          for (int i = 0; i < students.length; i++) {
            if (students[i]['id'] == searchId) {
              studentIndex = i;
              found = true;
              break;
            }
          }

          if (found) {
            // Student found, show current info
            print('\nStudent found!');
            print('   ID: ${students[studentIndex]['id']}');
            print('   Name: ${students[studentIndex]['name']}');
            print('   Score: ${students[studentIndex]['score']}');
            print('   Grade: ${students[studentIndex]['grade']}');
            break; // Exit the search loop
          } else {
            // Student not found
            print('Student ID $searchId does not exist!');
            print('Choose an option:');
            print('1. Enter another ID');
            print('2. Skip update');
            stdout.write('Enter choice (1 or 2): ');

            var notFoundChoice = stdin.readLineSync() ?? '';
            int? choice = int.tryParse(notFoundChoice);

            if (choice == 2) {
              print('Skipping update...');
              skipUpdate = true;
              break; // Exit the search loop
            } else if (choice == 1) {
              // Continue loop to ask for ID again
              continue;
            } else {
              print('Invalid choice. Please try again.');
              continue;
            }
          }
        }

        // If user chose to skip, go back to main menu
        if (skipUpdate) {
          break;
        }

        // ===== CHOOSE WHAT TO UPDATE =====
        print('\nWhat would you like to update?');
        print('1. ID');
        print('2. Name');
        print('3. Score');
        stdout.write('Enter choice (1-3): ');

        var updateChoice = stdin.readLineSync() ?? '';
        int? updateOption = int.tryParse(updateChoice);

        if (updateOption == 1) {
          // ===== UPDATE ID =====
          print('\n--- Update Student ID ---');
          int oldId = students[studentIndex]['id'];
          print('Current ID: $oldId');

          while (true) {
            stdout.write('Enter new ID: ');
            var newIdInput = stdin.readLineSync() ?? '';
            int? newId = int.tryParse(newIdInput);

            if (newId == null || newId <= 0) {
              print('Invalid ID! Please enter a positive number.');
              continue;
            }

            // Check if new ID is same as old ID
            if (newId == oldId) {
              print('New ID is same as current ID. No changes made.');
              break;
            }

            // Check if new ID already exists
            if (usedIds.contains(newId)) {
              print('Student ID $newId already exists!');
              print('Choose an option:');
              print('1. Enter another ID');
              print('2. Skip update');
              stdout.write('Enter choice (1 or 2): ');

              var duplicateChoice = stdin.readLineSync() ?? '';
              int? dupChoice = int.tryParse(duplicateChoice);

              if (dupChoice == 2) {
                print('Skipping ID update...');
                break;
              } else if (dupChoice == 1) {
                continue;
              } else {
                print('Invalid choice. Please enter ID again.');
                continue;
              }
            } else {
              // Valid new ID - update both Set and Map
              usedIds.remove(oldId);
              usedIds.add(newId);
              students[studentIndex]['id'] = newId;

              print('ID updated successfully!');
              print('   Old ID: $oldId → New ID: $newId');
              break;
            }
          }
        } else if (updateOption == 2) {
          // ===== UPDATE NAME =====
          print('\n--- Update Student Name ---');
          print('Current Name: ${students[studentIndex]['name']}');

          while (true) {
            stdout.write('Enter new name: ');
            var newName = stdin.readLineSync() ?? '';

            if (newName.trim().isEmpty) {
              print('Name cannot be empty!');
            } else {
              students[studentIndex]['name'] = newName.trim();
              print('Name updated successfully!');
              print('   New Name: ${newName.trim()}');
              break;
            }
          }
        } else if (updateOption == 3) {
          // ===== UPDATE SCORE =====
          print('\n--- Update Student Score ---');
          print(
            'Current Score: ${students[studentIndex]['score']} (${students[studentIndex]['grade']})',
          );

          num newScore = 0;
          while (true) {
            stdout.write('Enter new score (0-100): ');
            var scoreInput = stdin.readLineSync() ?? '';
            num? tempScore = num.tryParse(scoreInput);

            if (tempScore == null) {
              print('Invalid score! Please enter a number.');
            } else if (tempScore < 0 || tempScore > 100) {
              print('Score must be between 0 and 100!');
            } else {
              newScore = tempScore;
              break;
            }
          }

          // Recalculate grade based on new score
          String newGrade;
          if (newScore >= 97) {
            newGrade = 'A+';
          } else if (newScore >= 90) {
            newGrade = 'A';
          } else if (newScore >= 85) {
            newGrade = 'A-';
          } else if (newScore >= 80) {
            newGrade = 'B+';
          } else if (newScore >= 75) {
            newGrade = 'B';
          } else if (newScore >= 70) {
            newGrade = 'B-';
          } else if (newScore >= 65) {
            newGrade = 'C+';
          } else if (newScore >= 60) {
            newGrade = 'C';
          } else if (newScore >= 57) {
            newGrade = 'C-';
          } else if (newScore >= 55) {
            newGrade = 'D+';
          } else if (newScore >= 52) {
            newGrade = 'D';
          } else if (newScore >= 50) {
            newGrade = 'D-';
          } else {
            newGrade = 'F';
          }

          // Update both score and grade
          students[studentIndex]['score'] = newScore;
          students[studentIndex]['grade'] = newGrade;

          print('Score updated successfully!');
          print('   New Score: $newScore');
          print('   New Grade: $newGrade');
        } else {
          print('Invalid choice! Update cancelled.');
        }

        break;

      case 4:
        // ========== DELETE STUDENT INFORMATION ==========
        print('\n========== DELETE STUDENT INFORMATION ==========');

        // Check if there are any students
        if (students.isEmpty) {
          print('No students to delete! Please add students first.');
          break;
        }

        // ===== GET STUDENT ID TO DELETE =====
        int studentIndex = -1;
        bool skipDelete = false;

        while (true) {
          stdout.write('Enter Student ID to delete: ');
          var idInput = stdin.readLineSync() ?? '';
          int? searchId = int.tryParse(idInput);

          if (searchId == null) {
            print('Invalid ID! Please enter a number.');
            continue;
          }

          // Search for student with this ID
          bool found = false;
          for (int i = 0; i < students.length; i++) {
            if (students[i]['id'] == searchId) {
              studentIndex = i;
              found = true;
              break;
            }
          }

          if (found) {
            // Student found, proceed to confirmation
            break;
          } else {
            // Student not found
            print('Student ID $searchId does not exist!');
            print('Choose an option:');
            print('1. Enter another ID');
            print('2. Skip delete');
            stdout.write('Enter choice (1 or 2): ');

            var notFoundChoice = stdin.readLineSync() ?? '';
            int? choice = int.tryParse(notFoundChoice);

            if (choice == 2) {
              print('⏭️  Skipping delete...');
              skipDelete = true;
              break;
            } else if (choice == 1) {
              // Continue loop to ask for ID again
              continue;
            } else {
              print('Invalid choice. Please try again.');
              continue;
            }
          }
        }

        // If user chose to skip, go back to main menu
        if (skipDelete) {
          break;
        }

        // ===== CONFIRMATION =====
        print('\nAre you sure you want to delete this student?');
        print('\nStudent Information:');
        print('   ID: ${students[studentIndex]['id']}');
        print('   Name: ${students[studentIndex]['name']}');
        print('   Score: ${students[studentIndex]['score']}');
        print('   Grade: ${students[studentIndex]['grade']}');
        print('\n1. Yes, delete this student');
        print('2. No, cancel');
        stdout.write('Enter choice (1 or 2): ');

        var confirmChoice = stdin.readLineSync() ?? '';
        int? confirmation = int.tryParse(confirmChoice);

        if (confirmation == 1) {
          // Delete student
          int deletedId = students[studentIndex]['id'];
          String deletedName = students[studentIndex]['name'];

          // Remove from Set
          usedIds.remove(deletedId);

          // Remove from List
          students.removeAt(studentIndex);

          print('\nStudent deleted successfully!');
          print('   Deleted: $deletedName (ID: $deletedId)');
        } else if (confirmation == 2) {
          print('\nDelete cancelled. Student not deleted.');
        } else {
          print('\nInvalid choice. Delete cancelled.');
        }

        break;

      case 5:
        // ========== DISPLAY HIGHEST AND LOWEST MARKS ==========
        print('\n========== HIGHEST AND LOWEST MARKS ==========');

        // Check if there are any students
        if (students.isEmpty) {
          print('No students to display! Please add students first.');
          break;
        }

        // Initialize with first student's index (0)
        int highest = 0;
        int lowest = 0;

        // Iterate through the list to find highest and lowest
        for (int i = 1; i < students.length; i++) {
          // Check if current score is higher than highest
          if (students[i]['score'] > students[highest]['score']) {
            highest = i;
          }

          // Check if current score is lower than lowest
          if (students[i]['score'] < students[lowest]['score']) {
            lowest = i;
          }
        }

        // Display highest score student
        print('\nHIGHEST SCORE:');
        print('${'=' * 50}');
        print('   ID: ${students[highest]['id']}');
        print('   Name: ${students[highest]['name']}');
        print('   Score: ${students[highest]['score']}');
        print('   Grade: ${students[highest]['grade']}');
        print('${'=' * 50}');

        // Display lowest score student
        print('\nLOWEST SCORE:');
        print('${'=' * 50}');
        print('   ID: ${students[lowest]['id']}');
        print('   Name: ${students[lowest]['name']}');
        print('   Score: ${students[lowest]['score']}');
        print('   Grade: ${students[lowest]['grade']}');
        print('${'=' * 50}');

        break;

      case 6:
        // ========== TOTAL NUMBER OF STUDENTS ==========
        print('\n========== TOTAL NUMBER OF STUDENTS ==========');
        print('${'=' * 50}');
        print('   Total Students: ${students.length}');
        print('${'=' * 50}');
        break;

      case 7:
        print('\n========================================');
        print('   Thank you for using the system!');
        print('   Exiting...');
        print('========================================');
        return;

      default:
        print('\nInvalid choice! Please enter a number between 1-7.');
    }
  }
}
