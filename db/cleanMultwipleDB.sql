DELETE FROM  main.logs;
ALTER SEQUENCE main.logs_id_seq RESTART WITH 1;

DELETE FROM main.user_group;
ALTER SEQUENCE main.user_group_id_seq RESTART WITH 1;

DELETE FROM  main.user_tokens;
ALTER SEQUENCE main.user_tokens_id_seq RESTART WITH 1;

DELETE FROM main.login_tokens;
ALTER SEQUENCE main.login_tokens_id_seq RESTART WITH 1;

DELETE FROM main.actions;
ALTER SEQUENCE main.actions_id_seq RESTART WITH 1;

DELETE FROM main.feeds;
ALTER SEQUENCE main.feeds_id_seq RESTART WITH 1;
