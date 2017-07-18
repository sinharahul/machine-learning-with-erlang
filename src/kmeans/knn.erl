%%%-------------------------------------------------------------------
%%% @author rahulsinha
%%% @copyright (C) 2016, <COMPANY>
%%% @doc
%%% Implement  a K means classifier .
%%% @end
%%% Created : 16. Jul 2016 6:40 PM
%%%-------------------------------------------------------------------
-module(knn).
-author("rahulsinha").
-compile(export_all).

createdataset()->
   Group=[ [1.0,1.1], [1.0,1.0] , [0,0],  [0,0.1]] ,
   Labels =["A","A","B","B"],
   {Group,Labels}.

index_of(Item, List) -> index_of(Item, List, 0).

index_of(_, [], _)  -> not_found;
index_of(Item, [Item|_], Index) -> Index;
index_of(Item, [_|Tl], Index) -> index_of(Item, Tl, Index+1).

classify(X,DataSet,Labels,K)->
  DataSetSize=length(DataSet),
  [A,B]=X,
  DiffList=[[A-X,B-Y]||[X,Y]<-DataSet],
  SqDiffMat=lists:map(fun(X)->
                       [C,D]=X,
                        [C*C,D*D]
                      end,
                      DiffList),
  SqDistances=lists:map(fun(X)->
                          [E,F]=X,
                          E+F
                        end,
                         SqDiffMat),
  Distances=lists:map(fun(X)->math:sqrt(X)end,SqDistances),
  SortedDistances=lists:sort(Distances),
  SortedDistanceIndices= [index_of(X,Distances)|| X<- SortedDistances],
  [lists:nth(Item+1,Labels)||Item<-SortedDistanceIndices].
%%["B","B","A","A"]
%% Return [{"B",2},{"A",2}]
occur(List)->occur(List,[{}]).
occur([A|T],[{}])-> occur(T,{A,1});
occur([A|T],[{A,N}|Tail])-> occur(T,[{A,N+1}|Tail]);
occur([A|T],List)-> occur(T,[List|{A,1}]);
occur([],T)-> T.


