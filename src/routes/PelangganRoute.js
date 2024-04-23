import express from "express";

import {
  cPelanggan, 
  dPelanggan, 
  gPelanggan,
  gPelangganByParams,
  uPelanggan
} from "../controllers/Pelanggan.js";
import { verifyUser } from "../middleware/Auth.js";

const router = express.Router();

router.get("/kasir/customers",verifyUser, gPelanggan);
router.get("/kasir/customer/:id",verifyUser, gPelangganByParams);
router.post("/kasir/customer",verifyUser ,cPelanggan);
router.patch("/kasir/customer/:id",verifyUser ,uPelanggan);
router.delete("/kasir/customer/:id",verifyUser ,dPelanggan);

export default router;
