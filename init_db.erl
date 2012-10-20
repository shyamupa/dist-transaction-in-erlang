-module(init_db).
-include_lib("stdlib/include/qlc.hrl").
-include("init_db.hrl").
-export([init/0]).
init() ->
	mnesia:create_table(sender,[{attributes,record_info(fields, sender)}]),
	mnesia:create_table(receiver,[{attributes,record_info(fields, receiver)}]),
	mnesia:create_table(cause,[{attributes,record_info(fields, cause)}]),
	mnesia:create_table(subscriber,[{type, bag},{attributes,record_info(fields,subscriber)}]),
	mnesia:create_table(t_table,[{type, bag},{attributes, record_info(fields, t_table)}]).
