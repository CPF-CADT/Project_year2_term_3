import { pool } from "../utils/database.js";

export async function sign_up(User) {
  const { name, email, phoneNumber, password } = User;
  const [result] = await pool.query(
    "insert into Person (name,email,phoneNumber,password) values (?,?,?,?)",
    [name, email, phoneNumber, password]
  );
  return { id: result.insertId, ...User };
}
export async function login(User) {
  const { email, password } = User;
  const [rows] = await pool.query(
    "select * from Person where email = ? and password =?",
    [email, password]
  );
  if (rows.length > 0) {
    return rows[0];
  } else {
    return null;
  }
}
export async function getUserProfileDetail(id) {
  const [rows] = await pool.query("select * from Person where id =?", [id]);
  if (rows.length > 0) {
    return rows[0];
  } else {
    return null;
  }
}
export async function Updateprofile(id,User) {
  const {  name, email, phoneNumber, password, profilePicUrl } = User;
  const [result] = await pool.query(
    "Update person set name=?,email=?,phoneNumber=?,password=?,profilePicUrl=? where id =?",
    [name, email, phoneNumber, password, profilePicUrl, id]
  );
  if (result.affectedRows === 0) {
    console.log("error update");
    return null;
  }
  const [rows] = await pool.query("select * from person where id =?", [id]);
  return rows[0];
}
