class UrlsApi {
static String baseimageUrl = 'http://192.168.193.85:8080/';

static String baseUrl="http://192.168.193.85:8080/api/";
static String verifyUserApi= "${baseUrl}verify";
static String verifyArtistApi= "${baseUrl}artist/verify";
static String CertificateApi= "${baseUrl}certificates/store/";

static String ArticleComplaintApi= "${baseUrl}complaints/";

static String registerArtistApi= "${baseUrl}artist/register";
static String loginArtistApi= "${baseUrl}artist/login";
static String registerUserApi= "${baseUrl}user/register";
static String loginUserApi= "${baseUrl}user/login";

static String homeApi= "${baseUrl}home/";
static String paintingDetailsApi= "${baseUrl}paintings/show/";

static String articlesCommentsApi= "${baseUrl}articles/comments/";
static String paintingsCommentsApi= "${baseUrl}paintings/comments/";

static String paintingsArtistApi= "${baseUrl}paintings/store";
static String paintingsListApi= "${baseUrl}paintings/artist/show/";
static String deletepaintingApi= "${baseUrl}paintings/delete/";
static String updatepaintingApi= "${baseUrl}paintings/update/";


static String ArticlesApi= "${baseUrl}articlesPage/";
static String ArticleDetailsApi= "${baseUrl}articles/show/";
static String AddArticleApi= "${baseUrl}articles/store/";
static String DeleteArticleApi= "${baseUrl}articles/delete/";
static String UpdateArticleApi= "${baseUrl}articles/update/";
static String ArtistArticleApi= "${baseUrl}articles/artist/show/";

static String AddGalleryApi= "${baseUrl}archive/store";
static String getAllGalleryApi= "${baseUrl}archive/show/all";
static String getGalleryDetailsApi= "${baseUrl}showArchiveWorks/";

static String AddLikePaintingApi= "${baseUrl}paintings/interactions/";
static String AddLikeArticleApi= "${baseUrl}articles/interactions/";
static String AddFavouriteApi= "${baseUrl}favourite/";


static String SearchApi= "${baseUrl}";


}
