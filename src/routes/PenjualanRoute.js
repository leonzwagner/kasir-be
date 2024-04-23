import express from "express";

import {
  cDetail,
  gDetail
} from "../controllers/Penjualan.js";

const router = express.Router();

router.get("/kasir/details", gDetail);
router.get("/kasir/product/:id");
router.post("/kasir/detail", cDetail);
router.patch("/kasir/product/:id");
router.delete("/kasir/product/:id");

export default router;
