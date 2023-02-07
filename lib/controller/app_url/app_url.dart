

class AppUrl{
  //static const  baseUrl ="http://localhost:8090/";
  static const  baseUrl ="https://api.apilayer.com/";
  static const  user ="user/";
  static const  file ="file/";
  static const  groups ="groups/";
  static const  currency ="currency_data/";

  ///currency
  static const  convertCurrency ="${baseUrl}${currency}convert";
  static const  timeframeCurrency ="${baseUrl}${currency}timeframe";
  ///user
  static const  getUser ="${baseUrl}${user}getUser";
  static const  login ="${baseUrl}${user}login";
  static const  register ="${baseUrl}${user}register";
  static const  logout ="${baseUrl}${user}logout";
  static const  load ="${baseUrl}${user}load";
  static const  getAllUser ="${baseUrl}${user}get-all";
  ///groups
  static const  addUserGroup ="${baseUrl}${groups}add_user_group";
  static const  getGroupPublic ="$baseUrl${groups}get_group_public";
  static const  createGroup ="${baseUrl}${groups}create_group";
  static const  editGroup ="${baseUrl}${groups}edit_group";
  static const  deleteGroup ="${baseUrl}${groups}delete_group";
  static const  deleteUserGroup ="${baseUrl}${groups}delete_user_group";
  static const  getGroupPrivate ="${baseUrl}${groups}get_group_private";
  static const  getUserGroup ="${baseUrl}${groups}get_user_group";
  ///file
  static const  createFile ="${baseUrl}${file}create_file";
  static const  editFile ="${baseUrl}${file}edit_file";
  static const  deleteFile ="${baseUrl}${file}delete_file";
  static const  getFileListGroup ="${baseUrl}${file}get_file_list_group";
  static const  getFileListGroupSearch ="${baseUrl}${file}get_file_list_group_search";
  static const  getReportsFile ="${baseUrl}${file}get_reports_file";
  static const  chickOutFiles ="${baseUrl}${file}chickOut_files";
  static const  chickInFiles ="${baseUrl}${file}chickIn_files";


  static const  baseUrlImage ="http://order-book.chi-team.com";
  static const  baseUrl1 ="http://order-book.chi-team.com/api";
  static const  updateProfile ="${baseUrl}user/update";
  static const  deleteProfile ="${baseUrl}user/deleteMyAccount";


}