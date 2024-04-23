-- CreateTable
CREATE TABLE `detailpenjualan` (
    `DetailD` INTEGER NOT NULL AUTO_INCREMENT,
    `PenjualanID` INTEGER NOT NULL,
    `ProdukID` INTEGER NOT NULL,
    `JumlahProduk` INTEGER NOT NULL,
    `SubTotal` DECIMAL(10, 2) NOT NULL,

    INDEX `PenjualanID`(`PenjualanID`),
    INDEX `ProdukID`(`ProdukID`),
    PRIMARY KEY (`DetailD`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `pelanggan` (
    `PelangganID` INTEGER NOT NULL AUTO_INCREMENT,
    `NamaPelanggan` VARCHAR(255) NOT NULL,
    `Alamat` TEXT NOT NULL,
    `NomorTelpon` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`PelangganID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `penjualan` (
    `PenjualanID` INTEGER NOT NULL AUTO_INCREMENT,
    `TanggalPenjualan` DATE NOT NULL,
    `TotalHarga` DECIMAL(10, 2) NOT NULL,
    `PelangganID` INTEGER NOT NULL,

    INDEX `PelangganID`(`PelangganID`),
    PRIMARY KEY (`PenjualanID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produk` (
    `ProdukID` INTEGER NOT NULL AUTO_INCREMENT,
    `NamaProduk` VARCHAR(255) NOT NULL,
    `Harga` DECIMAL(10, 2) NOT NULL,
    `Stok` INTEGER NOT NULL,

    PRIMARY KEY (`ProdukID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user` (
    `UserID` INTEGER NOT NULL AUTO_INCREMENT,
    `Nama` VARCHAR(255) NOT NULL,
    `Username` VARCHAR(255) NOT NULL,
    `Password` VARCHAR(255) NOT NULL,
    `Role` ENUM('admin', 'petugas') NOT NULL,

    PRIMARY KEY (`UserID`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `detailpenjualan` ADD CONSTRAINT `detailpenjualan_ibfk_1` FOREIGN KEY (`ProdukID`) REFERENCES `produk`(`ProdukID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `detailpenjualan` ADD CONSTRAINT `detailpenjualan_ibfk_2` FOREIGN KEY (`PenjualanID`) REFERENCES `penjualan`(`PenjualanID`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `penjualan` ADD CONSTRAINT `penjualan_ibfk_1` FOREIGN KEY (`PelangganID`) REFERENCES `pelanggan`(`PelangganID`) ON DELETE CASCADE ON UPDATE CASCADE;
