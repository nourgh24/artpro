class SreverConfig {
  //  عنوان السيرفر
  static const domainNameServer = 'http://192.168.193.85:8080';
  static const domainNameServerforImage = 'http://192.168.193.85:8080/';

  // تعريف ال api s
  // static const showAllArtist = '/api/show/artists/list';
  // //need id
  // static const showoneArtist = '/api/show/artist/';
  static const changeFollowFromArtist = ' /api/artist/changeFromArtist/follow/';
  static const changeFollowFromUser = ' /api/artist/change/follow/';
  static const artistProfileServer = '/api/artist/profile';
  static const userProfileServer = ' /api/user/profile';

  // static const login = ' ...../api/auth/login.....';
}
// why static // so i can reach from anywhere
