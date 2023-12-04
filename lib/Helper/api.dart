class HttpUrl {
  // static const String base = 'http://154.26.130.251:302/';
  // static const String base = 'http://154.26.130.251:188/';
  // static const String base ='https://stupefied-mirzakhani.154-26-130-251.plesk.page/';
  static const String base ='https://catchyfiveapi.appxes-erp.in/';

  static const int org = 3;

  static String sendOtp = '${base}SendOTP/SendOTP';

  static String ExitingEmaiRegister = '${base}B2CCustomerRegister/GetbyEmail?';

  static String createCustomerRegister = '${base}B2CCustomerRegister/Create';

  static String verifyOtp = '${base}SendOTP/VerifyOTP';

  static String login = '${base}B2CCustomerRegister/CustomerLogin';

  static String banner = '${base}B2CBannerImage/GetAll?';

  static String getAllCategory = '${base}Category/GetAll?';

  static String getAllSubCategory = '${base}SubCategory/GetbyCategoryCode?';

  static String getAllSubSubCategory =
      '${base}SubCategoryLevel2/GetbySubCategoryCode?';

  static String getAllProductsByCode = '${base}Product/GetAllWithImage?';

  static String salesOrder = '${base}B2CCustomerOrder/Create';

  static String getOrder = '${base}B2CCustomerOrder/GetHeaderSearch?';

  static String getTaxDetails = "${base}Tax/Getbycode?";

  static String pagination =
      "${base}Product/GetAll?OrganizationId=${HttpUrl.org}rg&pageNo=1&pageSize=10";

  static String getAllProduct = "${base}Product/GetAllWithImage?";

  static String getAllProductcode = "${base}Product/Getbycode?";

  static String b2CCustomerOrderGetHeaderSearch =
      "${base}B2CCustomerOrder/GetHeaderSearch?";

  static String b2CCustomerOrderGetByCode =
      "${base}B2CCustomerOrder/Getbycode?";

  static String b2CCustomerRegisterEditProfilePassword =
      "${base}B2CCustomerRegister/EditProfilePassword";

  static String b2CCustomerRegisterEditProfile =
      "${base}B2CCustomerRegister/EditProfile";

  static String b2CCustomerRegisterPostalApi =
      "https://developers.onemap.sg/commonapi/search?";

  static String b2CCustomerDeliveryAddressGetAll =
      "${base}B2CCustomerDeliveryAddress/GetAll?";

  static String b2CCustomerDeliveryAddressCreate =
      "${base}B2CCustomerDeliveryAddress/Create";

  static String b2CCustomerFavGetWishList =
      "${base}B2CCustomerWishList/GetByCustomer?";

  static String b2CCustomerFavCreateWishList =
      "${base}B2CCustomerWishList/Create";

  static String b2CCustomerUnFavCreateWishList = "${base}B2CCustomerWishList/Remove?";

  static String removeDeliveryAddress = "${base}B2CCustomerDeliveryAddress/Remove";
}
