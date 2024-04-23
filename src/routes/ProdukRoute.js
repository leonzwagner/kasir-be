import express from "express";

import {
  gProduk,
  gProdukByParams,
  cProduk,
  cmProduk,
  uProduk,
  dProduk,
} from "../controllers/Produk.js";

import { verifyUser, adminOnly } from "../middleware/Auth.js";

const router = express.Router();

router.get("/kasir/products",verifyUser ,gProduk);
router.get("/kasir/product/:id",verifyUser ,gProdukByParams);
router.post("/kasir/product",verifyUser, cProduk);
router.post("/kasir/products",verifyUser, cmProduk);
router.patch("/kasir/product/:id",verifyUser, uProduk);
router.delete("/kasir/product/:id",verifyUser, dProduk);

export default router;
