import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:the_app/api/conf/AnimeResponseGraphqlModel.dart';
import 'package:the_app/api/conf/GraphQLConfiguration.dart';
import 'package:the_app/api/query.dart';


class AnimeService{

  GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

  searchAnime(String nome, int page, int perPage) async{
    GraphQLClient _client = graphQLConfiguration.clientToQuery();
    QueryResult response = await _client.query(
      QueryOptions(
        documentNode: gql(searchAnimeQuery()),
        variables: {
          'search': nome,
          'page': page,
          'perPage': perPage
        }
      ),
    );

    List<AnimeGraphqlModel> aniList;

    if(!response.hasException){
      AnimeResponseGraphqlModel  responseModel = AnimeResponseGraphqlModel.fromJson(response.data);
      return aniList.addAll(responseModel.data.page.media);
    }
    return aniList;
    //return result;
  }

}