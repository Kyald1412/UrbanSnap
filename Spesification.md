# App Spesification

    Home
    - Add new diary
    - Blood sugar level average (today)
    - Food nutrition average (today)
    - Drug intake (today)
    
    Add Diary
        Food Nutrition
        1. Select Category
        2. Select Meal Information
        3. Pick Food 
        4. Save
        
        Blood Sugar Level
        1. Select Category
        2. Select Time Information
        3. Select sugar level
        4. Select Threshold
        5. Save
        
        Drug Intake
        1. Select Category
        2. Select Time Information (?)
        3. Input drugs name and current/total intake
        4. Save
    
    Detail (Chart)
    - Show Chart based on selected date
    - Show Weekly Date
    
    Today's Activity
    - Show Weekly Date
    - Show list of activities based on date
    
    History
    - Show list of selected activity based on selected date
    
    Additional Question
    - Blood sugar threshold ask everytime or set in the first place?
    - Can user change the date when add diary?
    
    
    

# Tech Spesification

    Calendar
    - Weekly (Not native)
    - Monthly (Can be native)

    Chart
    - Column Ranged Bar
    
    Picker
    - Time Picker
    - Picker view (Popup/Modal/Inline)
    - Date (Popup/Modal)
    - Stepper (Native/Custom)
    
    App flow
    - Navigation
    - Life Cycle
    - Navigation Bar
    
    Presentation
    - UIViewController
    - Presentation Style
    - Modality
    - Static Tableview
    - Dynamic Tableview
    - SearchBar
    
    Core
    - Database (CoreData)
    - Json Parsing
    - Model
    - Repository


# Database Spesification

    Categories [Could be used dummy/static data]
    - id
    - category_type
    - category_name
    
    Category Info
    - id
    - category_id
    - category_info
    
    Diary
    - id
    - date
    - time
    - category_id (fk)
    - category_info_id (fk)

    Diary Nutrition
    - id
    - diary_id (fk)
    - food_id (fk)
    
    Diary Blood Sugar
    - id
    - diary_id (fk)
    - bloog_sugar
    
    Diary Drug Intake
    - id
    - diary_id (fk)
    - drug_name
    - drug_current_intake
    - drug_total_intake
    
    Food
    - id
    - food_name
    - food_weight
    - sugar
    - calorie
    - nutritions //Not required for now
    
    User
    - Name
    
    // -------- //
    Nutritions
    - id
    - food_id (fk)
    - nutrition_name
    - nutrition_value
    - nutrition_unit
    - nutrition_calorie
    // -------- //


# Alarm/Notify Spesification

    Categories [Could be used dummy/static data]
