-module(insert).
-include("init_db.hrl").
-export([read_sender_file/0,read_cause_file/0,read_receiver_file/0]).

insert_sender([]) ->
	io:format("Insertion of Sender List completed.~n");
	
insert_sender([S|T]) ->
	io:format("Inserting ~p ~p ~p ~p ~n",[S#sender.s_id,S#sender.s_name,S#sender.s_balance,S#sender.loc_id]),
	F=fun()->
			mnesia:write(S)
		end,
	RV=mnesia:transaction(F),
	case RV of
		{aborted,_} -> io:format("Something Wrong in insert_sender!~n");		% 
		{_,_} -> 	io:format("~p ~n",[RV]), 
					insert_sender(T)
	end.
	
insert_receiver([]) ->
	io:format("Insertion of Receiver List completed.~n");
	
insert_receiver([S|T]) ->
	io:format("Inserting ~p ~p ~p ~p ~n",[S#receiver.r_id,S#receiver.r_name,S#receiver.r_balance,S#receiver.loc_id]),
	F=fun()->
			mnesia:write(S)
		end,
	RV=mnesia:transaction(F),
	case RV of
		{aborted,_} -> io:format("Something Wrong in insert_receiver!~n");		% 
		{_,_} -> 	io:format("~p ~n",[RV]), 
					insert_receiver(T)
	end.

insert_cause([]) ->	
	io:format("Insertion of Cause List completed.~n");
	
insert_cause([S|T]) ->	
	io:format("Inserting ~p ~p ~n",[S#cause.c_id,S#cause.c_name]),
	F=fun()->
			mnesia:write(S)
		end,
	RV=mnesia:transaction(F),
	case RV of
		{aborted,_} -> io:format("Something Wrong in insert_cause!~n");		% 
		{_,_} -> 	io:format("~p ~n",[RV]), 
					insert_cause(T)
	end.
	
read_sender_file() ->
	{ok,L}=file:consult("sender.lst"),
	insert_sender(L).

read_cause_file() ->
	{ok,L}=file:consult("cause.lst"),
	insert_cause(L).
	
read_receiver_file() ->
	{ok,L}=file:consult("receiver.lst"),
	insert_receiver(L).
	
subscribe(R_id,C_id) ->
		
