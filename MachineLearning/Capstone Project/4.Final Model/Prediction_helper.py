def help_to_predict(model):
    import pandas as pd
    dataset = pd.read_csv("PreAnxiety.csv")
    x=dataset.iloc[0:,0:7]
    import pandas as pd
    dataset = pd.read_csv("PreAnxiety.csv")
    x=dataset.iloc[0:,0:7]
    entered_age = int(input("Enter your Age: "))
    age=""
    if(entered_age<18):
        age="Below 18"
    elif entered_age<=22:
        age="18-22"
    elif entered_age<=26:
        age="23-26"
    elif entered_age<=30:
        age="27-30"
    else:
        age="Above 30"
        
    entered_gender = input("Gender (male/female/m/f): ").lower()[0:1]
    
    if "m" in entered_gender:
        gender="Male"
    elif "f" in entered_gender:
        gender="Female"
    else:
        gender="Prefer not to say"
    
    for i,value in enumerate(x["3. University"].unique()):
        print(f"Enter: {i+1} for {value}")
        
    university = int(input("Enter Here:"))-1
    selected_university = ""
    for i,value in enumerate(x["3. University"].unique()):
        if(university==i):
            selected_university=value
            break;
    for i,value in enumerate(x["4. Department"].unique()):
        print(f"Enter: {i+1} for {value}")
        
    department = int(input("Enter Here:"))-1
    
    selected_department = ""
    for i,value in enumerate(x["4. Department"].unique()):
        if(department==i):
            selected_department=value
            break;
    
    for i,value in enumerate(x["5. Academic Year"].unique()):
        print(f"Enter: {i+1} for {value}")
    
    academic_year = int(input("Enter Here:"))-1
    
    selected_academic_year = ""
    for i,value in enumerate(x["5. Academic Year"].unique()):
        if(academic_year==i):
            selected_academic_year=value
            break;
        
    for i,value in enumerate(x["6. Current CGPA"].unique()):
        print(f"Enter: {i+1} for {value}")
    
    current_cgpa = int(input("Enter Here:"))-1
    selected_current_cgpa = ""
    for i,value in enumerate(x["6. Current CGPA"].unique()):
        if(current_cgpa==i):
            selected_current_cgpa=value
            break;
        
    for i,value in enumerate(x["7. Did you receive a waiver or scholarship at your university?"].unique()):
    
        print(f"Enter: {i+1} for {value}")
    
    entered_scholarship = int(input("Enter Here:"))-1
    
    selected_scholarship = ""
    for i,value in enumerate(x["7. Did you receive a waiver or scholarship at your university?"].unique()):
        if(entered_scholarship==i):
            selected_scholarship=value
            break;

    print(f"You're Age:{entered_age}, You are grouped under the age group: {age}")
    print(f"You're Gender:{gender}")  
    print(f"You're Selected University:{selected_university}")
    print(f"You're Selected Department:{selected_department}")  
    print(f"You're Selected Academic Year:{selected_academic_year}")
    print(f"You're CGPA:{current_cgpa}, You are grouped under the CGPA group: {selected_current_cgpa}")
    print(f"You're Scholarship Status:{selected_scholarship}")
    
    user_inputs =[age,gender,selected_university,selected_department,selected_academic_year,selected_current_cgpa,selected_scholarship]
    
    
    selected_features=[]
    with open("./../4.Final Model/SelectedFeatures.txt","r") as file:
        for line in file:
            selected_features.append(line.strip("\n"))
            
    inputfeatures = [0 for i in selected_features]
    for i in user_inputs:
        for index,j in enumerate(selected_features):
            if j.endswith(i):
                if j.split("_")[-1] == i:
                    inputfeatures[index] = 1
                    
    return "Less Anxious" if model.predict([inputfeatures])==0 else "More Anxious"
    
    
    
    
    
    
    
    
    
    
    