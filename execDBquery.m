function DB_data = execDBquery(conn,SQLQuery)


%   execDBquery. Execute database SQL query, return data obtained.
%	
%	DB_Data = execDBquery(conn,SQLQuery)
%
%   Inputs:
%
%       conn:		Matlab database connection object
%		SQLQuery:	SQL query to be used to retrieve data
%
%   Outputs:
%
%       DB_data:	Data returned from database, in format specified
%					in conn object.
%	
%
%   Other m-files required:    None
%   Subfunctions required:     None
%   MAT-files required:        None
%    
%   See also: database


%	Author:			Arnab Gupta
%					Ph.D. Candidate, Virginia Tech.
%					Blacksburg, VA.
%	Website:		http://arnabocean.com
%	Repository		http://bitbucket.org/arnabocean
%	Email:			arnab@arnabocean.com
%
%	Version:		1.0
%	Last Revised:	16 Dec 2013
%
%	Changelog:
%


cur = exec(conn,SQLQuery); 
cur = fetch(cur);
DB_data = cur.data;

clearvars -except DB_data