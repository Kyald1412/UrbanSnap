
 ## Develop Agreements
 ====================
 
 1. Code convention
 2. Function
 3. Class & Extension
 4. Assets
 5. Bright/Dark Mode?
 6. Commit style
 7. Third party libraries
 8. Unit Testing
 9. App device & orientation
 10. Folder and structure
 11. Continuous Development
 12. Code conflict resolution
 13. Git management
 ====================


1. Code Convention
    let testing = ""
    let Testing = ""

2. Function
    //Max lines (Over 50 is dangerous, so break down)
    func testFunction(){
        
    }

    //Parameters (If >3 param)
    func testFunctionParameter(
        a: String,
        b: Int,
        c: Bool,
        d: [String]
    ) -> Bool {
        return true
    }


3. Class & Extension

    // First character should be Capital
    class FirstController : UIViewController {
        
    }

    //Use when delegate methods is required to separate from another class functions
    extension FirstController : UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }

4. Assets

    // Add color to Color.xcassets
    // Add images/icons to Assets.xcassets
    // Images/Icons should have 3 different size
    // Run swiftgen after any changes to assets

5. Bright/Dark
    
    // Define in Color.xcassets

6. Commit style
    
    // Commit files every fix/function added
    // Explain shortly and clear in message
    // Multiple fix/function added in one commit is not good

7. Third party lib

    // Use SPM if needed
    // No Overkill library

8. Unit Testing
    
    // Test every logic / function?
    // Do we need this for now?

9. App device & orientation

    // Portrait only
    
    
10.  Folder and Structure

    \ Diabestie
        - Application  
          For application scope code, such as initializing sdk.
          
        - Presentation
          Store logic and controller here (breakdown each feature with folder)
          
        - Resources
          Store assets, images, colors, sounds, fonts, and scenes here
          
        - Core
          For database usage
          
        - Helpers
          Store global variables/constant here and external libraries
          
        - Supporting Files
          Additional files will be stored here, such as localization file.

11. Continuous *Deplyoment*
    - Need an apple developer program enrollment
    - We will use testflight for app deployment
    - We wll use AppCenter for Continuous deployment
    
12. Code conflict resoultion
    - Avoid editing 1 scene with multiple person at one time.
    - In XCode press View -> Show Code Review
    
13.  Git management
    - 
