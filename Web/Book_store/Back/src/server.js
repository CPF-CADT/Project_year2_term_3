import express, { json } from "express";
import cors from "cors";
import userRoutes from "./routes/UserRoutes.js";
import customerRoutes from "./routes/CustomerRoutes.js";
import vendorRoutes from "./routes/vendorRoutes.js";
const app = express();
app.use(cors());
app.use(json());
app.use("/api/user",userRoutes);
app.use("/api/customer",customerRoutes);
app.use("/api/vendor",vendorRoutes);
const PORT = 3000;
app.listen(PORT,()=>{
     console.log(`Server running on http://localhost:${PORT}`);
});