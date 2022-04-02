import Foundation

public struct Constants {
    public static let PROFILE_VIEW_CELL = "ProfileViewCell"
    public static let DATE_PATTERN = "dd/MM/yyyy HH:mm aa"
    
    public struct NotificationCenter {
        public static let SIGN_UP = "signUp"
        public static let SAVE_PROFILE = "saveProfile"
    }
    
    public struct Navigation {
        public static let GO_TO_SIGN_UP = "goToSignUp"
        public static let GO_TO_ADD_EDIT_PROFILE = "goToAddEditProfile"
    }
    
    public struct ViewControllers {
        public static let MAIN_LIST_NAVIGATION_CONTROLLER = "MainListNavigationController"
        public static let SIGN_IN_NAVIGATION_CONTROLLER = "SignInNavigationController"
        public static let ADD_EDIT_PROFILE_VIEW_CONTROLLER = "AddEditProfileViewController"
    }
}
