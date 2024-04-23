/*
  Warnings:

  - The primary key for the `pelanggan` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `Alamat` on the `pelanggan` table. All the data in the column will be lost.
  - You are about to drop the column `NamaPelanggan` on the `pelanggan` table. All the data in the column will be lost.
  - You are about to drop the column `NomorTelpon` on the `pelanggan` table. All the data in the column will be lost.
  - You are about to drop the column `PelangganID` on the `pelanggan` table. All the data in the column will be lost.
  - The primary key for the `penjualan` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `PelangganID` on the `penjualan` table. All the data in the column will be lost.
  - You are about to drop the column `PenjualanID` on the `penjualan` table. All the data in the column will be lost.
  - You are about to drop the column `TanggalPenjualan` on the `penjualan` table. All the data in the column will be lost.
  - You are about to drop the column `TotalHarga` on the `penjualan` table. All the data in the column will be lost.
  - You are about to drop the `detailpenjualan` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `produk` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `ALAMAT` to the `pelanggan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ID_PELANGGAN` to the `pelanggan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `NAMA_PELANGGAN` to the `pelanggan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `NOMOR_TELEPON` to the `pelanggan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ID_PELANGGAN` to the `penjualan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ID_PENGGUNA` to the `penjualan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ID_PENJUALAN` to the `penjualan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `KETERANGAN` to the `penjualan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `METODE_PEMBAYARAN` to the `penjualan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `POTONGAN` to the `penjualan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `TANGGAL` to the `penjualan` table without a default value. This is not possible if the table is not empty.
  - Added the required column `TOTAL_PENJUALAN` to the `penjualan` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `detailpenjualan` DROP FOREIGN KEY `detailpenjualan_ibfk_1`;

-- DropForeignKey
ALTER TABLE `detailpenjualan` DROP FOREIGN KEY `detailpenjualan_ibfk_2`;

-- DropForeignKey
ALTER TABLE `penjualan` DROP FOREIGN KEY `penjualan_ibfk_1`;

-- AlterTable
ALTER TABLE `pelanggan` DROP PRIMARY KEY,
    DROP COLUMN `Alamat`,
    DROP COLUMN `NamaPelanggan`,
    DROP COLUMN `NomorTelpon`,
    DROP COLUMN `PelangganID`,
    ADD COLUMN `ALAMAT` VARCHAR(250) NOT NULL,
    ADD COLUMN `ID_PELANGGAN` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `NAMA_PELANGGAN` VARCHAR(50) NOT NULL,
    ADD COLUMN `NOMOR_TELEPON` VARCHAR(50) NOT NULL,
    ADD PRIMARY KEY (`ID_PELANGGAN`);

-- AlterTable
ALTER TABLE `penjualan` DROP PRIMARY KEY,
    DROP COLUMN `PelangganID`,
    DROP COLUMN `PenjualanID`,
    DROP COLUMN `TanggalPenjualan`,
    DROP COLUMN `TotalHarga`,
    ADD COLUMN `ID_PELANGGAN` INTEGER NOT NULL,
    ADD COLUMN `ID_PENGGUNA` INTEGER NOT NULL,
    ADD COLUMN `ID_PENJUALAN` INTEGER NOT NULL,
    ADD COLUMN `KETERANGAN` VARCHAR(250) NOT NULL,
    ADD COLUMN `METODE_PEMBAYARAN` VARCHAR(50) NOT NULL,
    ADD COLUMN `POTONGAN` DOUBLE NOT NULL,
    ADD COLUMN `TANGGAL` DATETIME(0) NOT NULL,
    ADD COLUMN `TOTAL_PENJUALAN` DOUBLE NOT NULL,
    ADD PRIMARY KEY (`ID_PENJUALAN`);

-- DropTable
DROP TABLE `detailpenjualan`;

-- DropTable
DROP TABLE `produk`;

-- DropTable
DROP TABLE `user`;

-- CreateTable
CREATE TABLE `barang` (
    `ID_BARANG` INTEGER NOT NULL AUTO_INCREMENT,
    `NAMA_BARANG` VARCHAR(250) NOT NULL,
    `KATEGORI` VARCHAR(100) NOT NULL,
    `SATUAN` VARCHAR(100) NOT NULL,
    `HARGA_BELI` DOUBLE NOT NULL,
    `HARGA_JUAL` DOUBLE NOT NULL,
    `STOK` DOUBLE NOT NULL,
    `KETERANGAN` VARCHAR(250) NOT NULL,
    `BARCODE` VARCHAR(250) NOT NULL,

    PRIMARY KEY (`ID_BARANG`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pemasok` (
    `ID_PEMASOK` INTEGER NOT NULL AUTO_INCREMENT,
    `NAMA_PEMASOK` VARCHAR(50) NOT NULL,
    `ALAMAT` VARCHAR(250) NOT NULL,
    `NOMOR_TELEPON` VARCHAR(50) NOT NULL,

    PRIMARY KEY (`ID_PEMASOK`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pembelian` (
    `ID_PEMBELIAN` INTEGER NOT NULL AUTO_INCREMENT,
    `TANGGAL` DATETIME(0) NOT NULL,
    `TOTAL_PEMBELIAN` DOUBLE NOT NULL,
    `POTONGAN` DOUBLE NOT NULL,
    `METODE_PEMBAYARAN` VARCHAR(50) NOT NULL,
    `KETERANGAN` VARCHAR(250) NOT NULL,
    `ID_PENGGUNA` INTEGER NOT NULL,
    `ID_PEMASOK` INTEGER NOT NULL,

    INDEX `index1`(`ID_PEMASOK`),
    INDEX `index2`(`ID_PENGGUNA`),
    PRIMARY KEY (`ID_PEMBELIAN`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pembelian_detil` (
    `ID_PEMBELIAN` INTEGER NOT NULL,
    `ID_BARANG` INTEGER NOT NULL,
    `HARGA_SATUAN` DOUBLE NOT NULL,
    `JUMLAH` DOUBLE NOT NULL,
    `TOTAL_HARGA` DOUBLE NOT NULL,

    INDEX `index1`(`ID_PEMBELIAN`),
    INDEX `index2`(`ID_BARANG`),
    PRIMARY KEY (`ID_PEMBELIAN`, `ID_BARANG`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pengguna` (
    `ID_PENGGUNA` INTEGER NOT NULL AUTO_INCREMENT,
    `NAMA_PENGGUNA` VARCHAR(50) NOT NULL,
    `ALAMAT` VARCHAR(250) NOT NULL,
    `NOMOR_TELEPON` VARCHAR(50) NOT NULL,
    `USERNAME` VARCHAR(100) NOT NULL,
    `PASSWORD` VARCHAR(100) NOT NULL,
    `HAK_AKSES` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`ID_PENGGUNA`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `penjualan_detil` (
    `ID_PENJUALAN` INTEGER NOT NULL,
    `ID_BARANG` INTEGER NOT NULL,
    `HARGA_SATUAN` DOUBLE NOT NULL,
    `JUMLAH` DOUBLE NOT NULL,
    `TOTAL_HARGA` DOUBLE NOT NULL,

    INDEX `index1`(`ID_PENJUALAN`),
    INDEX `index2`(`ID_BARANG`),
    PRIMARY KEY (`ID_PENJUALAN`, `ID_BARANG`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE INDEX `index1` ON `penjualan`(`ID_PENGGUNA`);

-- CreateIndex
CREATE INDEX `index2` ON `penjualan`(`ID_PELANGGAN`);

-- AddForeignKey
ALTER TABLE `pembelian` ADD CONSTRAINT `cid1` FOREIGN KEY (`ID_PEMASOK`) REFERENCES `pemasok`(`ID_PEMASOK`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pembelian` ADD CONSTRAINT `cid2` FOREIGN KEY (`ID_PENGGUNA`) REFERENCES `pengguna`(`ID_PENGGUNA`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pembelian_detil` ADD CONSTRAINT `cid7` FOREIGN KEY (`ID_BARANG`) REFERENCES `barang`(`ID_BARANG`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `pembelian_detil` ADD CONSTRAINT `cid8` FOREIGN KEY (`ID_PEMBELIAN`) REFERENCES `pembelian`(`ID_PEMBELIAN`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penjualan` ADD CONSTRAINT `cid3` FOREIGN KEY (`ID_PENGGUNA`) REFERENCES `pengguna`(`ID_PENGGUNA`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penjualan` ADD CONSTRAINT `cid4` FOREIGN KEY (`ID_PENJUALAN`) REFERENCES `pelanggan`(`ID_PELANGGAN`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penjualan_detil` ADD CONSTRAINT `cid5` FOREIGN KEY (`ID_PENJUALAN`) REFERENCES `penjualan`(`ID_PENJUALAN`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `penjualan_detil` ADD CONSTRAINT `cid6` FOREIGN KEY (`ID_BARANG`) REFERENCES `barang`(`ID_BARANG`) ON DELETE NO ACTION ON UPDATE NO ACTION;
