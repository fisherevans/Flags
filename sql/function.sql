-- getUserById
select user.*
  from user
 where id = ?;

 -- getUserByUsername
select user.*
  from user
 where username = ?;

 -- getUserByEmail
select user.*
  from user
 where email = ?;

-- isUserAvalable
select username
  from user
 where username = ?
    or email = ?;

-- registerUser
insert into user
  (email, username, password_hash, create_ip, create_date, verify_code, verified, public_profile)
  VALUES
  (?, ?, ?, ? , now(), ?, 0, 0);

-- verifyUser
update user
   set verified = 1
 where username = ?;

-- isLockedOut
select username
  from user
 where username = ?
   and failed_attempts >= ?
   and last_failed_date <= ?;

-- isValidLogin
select username
  from user
 where username = ?
   and password_hash = ?;

-- loginFailed
update user
   set failed_attempts = failed_attempts + 1,
       last_failed_date = now(),
       last_failed_ip ?
 where username = ?;

-- clearFailedLogins
update user
  set failed_attempts = 0,
      last_failed_date = null,
      last_failed_ip = null
 where username = ?;

