String searchAnimeQuery(){
  return """ 
      query (\$search: String!, \$page: Int!, \$perPage: Int!) {
    Page (page: \$page, perPage: \$perPage) {
        pageInfo {
            total
            currentPage
            lastPage
            hasNextPage
            perPage
        }
        media (type: ANIME, search: \$search) {
            id
            title {
                romaji
                english
                native
            }
            description
            type
            episodes
            genres
            format
            bannerImage
    }
  }
}
    """;
}