import { Router} from "express";
import { sign_up ,login} from "../controllers/controllers.js";
const user = Router();
user.post("/sign-up",sign_up);
user.post ("/login",login);
export default user;