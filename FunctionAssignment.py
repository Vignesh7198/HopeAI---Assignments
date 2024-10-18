class MultipleFunctions:
    def subfields():
        print("Sub-fields in AI are:")
        li = ["Machine Learning", "Neural Networks", "Vision", "Robotics", "Speech Processing", "Natural Language Processing"]
        for lis in li:
            print(lis)
            
    def OddEven():
        num = int(input("Enter a number: "))
        if num % 2 == 0:
            print(f"{num} is an Even number")
        else:
            print(f"{num} is an Odd number")          
   
    def Elegible():
        gender = input("Your Gender: ").lower()
        age = int(input("Your Age: "))
        if gender == "male":
            if age < 21:
                print("Not Eligible")
            else:
                print("Eligible")
        elif gender == "female":
            if age < 18:
                print("Not Eligible")
            else:
                print("Eligible")
        else:
            print("Enter either male or female")
            
    def percentage():
        total = 0
        for i in range(5):
            total += int(input(f"Subject {i + 1}: "))

        print(f"Total : {total}")
        print(f"Percentage : {total / 5}")

    def triangle():
        height = int(input("Height: "))
        breadth = int(input("Breadth: "))
        area = (height * breadth) / 2
        print("Area formula: (Height * Breadth) / 2")
        print(f"Area of Triangle: {area}")
        
        height1 = int(input("Height1: "))
        height2 = int(input("Height2: "))
        breadth = int(input("Breadth: "))
        perimeter = height1 + height2 + breadth
        print("Perimeter formula: Height1 + Height2 + Breadth")
        print(f"Perimeter of Triangle: {perimeter}")
