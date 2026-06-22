-- =====================================================================
-- 01_ddl.sql
-- SISTEM BENGKEL KENDARAAN
-- Data Definition Language (DDL)
-- Dialek   : MySQL 8.0
-- Berisi   : CREATE DATABASE, CREATE TABLE, PRIMARY KEY, FOREIGN KEY,
--            NOT NULL, UNIQUE, CHECK, INDEX
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. MEMBUAT DATABASE
-- ---------------------------------------------------------------------
DROP DATABASE IF EXISTS bengkel_kendaraan_db;
CREATE DATABASE bengkel_kendaraan_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE bengkel_kendaraan_db;

-- ---------------------------------------------------------------------
-- 2. TABEL INDUK (tidak punya FK / FK ke tabel induk lain)
-- ---------------------------------------------------------------------

-- 2.1 PELANGGAN
CREATE TABLE pelanggan (
    id_pelanggan    CHAR(5)         NOT NULL,
    nama_pelanggan  VARCHAR(100)    NOT NULL,
    alamat          VARCHAR(150)    NOT NULL,
    no_hp           VARCHAR(15)     NOT NULL,
    email           VARCHAR(100)    NULL,
    CONSTRAINT pk_pelanggan PRIMARY KEY (id_pelanggan),
    CONSTRAINT uq_pelanggan_hp UNIQUE (no_hp),
    CONSTRAINT uq_pelanggan_email UNIQUE (email)
) ENGINE=InnoDB;

-- 2.2 MEKANIK
CREATE TABLE mekanik (
    id_mekanik      CHAR(5)         NOT NULL,
    nama_mekanik    VARCHAR(100)    NOT NULL,
    no_hp           VARCHAR(15)     NOT NULL,
    alamat          VARCHAR(150)    NULL,
    spesialisasi    VARCHAR(50)     NOT NULL,
    status          VARCHAR(15)     NOT NULL DEFAULT 'Aktif',
    CONSTRAINT pk_mekanik PRIMARY KEY (id_mekanik),
    CONSTRAINT uq_mekanik_hp UNIQUE (no_hp),
    CONSTRAINT chk_mekanik_status CHECK (status IN ('Aktif','Cuti','Tidak Aktif'))
) ENGINE=InnoDB;

-- 2.3 ADMIN
CREATE TABLE admin (
    id_admin        CHAR(5)         NOT NULL,
    nama_admin      VARCHAR(100)    NOT NULL,
    username        VARCHAR(30)     NOT NULL,
    password        VARCHAR(255)    NOT NULL,
    nomor_hp        VARCHAR(15)     NOT NULL,
    CONSTRAINT pk_admin PRIMARY KEY (id_admin),
    CONSTRAINT uq_admin_username UNIQUE (username),
    CONSTRAINT uq_admin_hp UNIQUE (nomor_hp)
) ENGINE=InnoDB;

-- 2.4 SUPPLIER
CREATE TABLE supplier (
    id_supplier     CHAR(5)         NOT NULL,
    nama_supplier   VARCHAR(100)    NOT NULL,
    alamat          VARCHAR(150)    NOT NULL,
    no_hp           VARCHAR(15)     NOT NULL,
    email           VARCHAR(100)    NULL,
    CONSTRAINT pk_supplier PRIMARY KEY (id_supplier),
    CONSTRAINT uq_supplier_hp UNIQUE (no_hp),
    CONSTRAINT uq_supplier_email UNIQUE (email)
) ENGINE=InnoDB;

-- 2.5 JASA_SERVIS (master daftar jasa)
CREATE TABLE jasa_servis (
    id_jasa         CHAR(5)         NOT NULL,
    nama_jasa       VARCHAR(100)    NOT NULL,
    harga_jasa      DECIMAL(12,2)   NOT NULL,
    durasi_servis   INT             NOT NULL COMMENT 'durasi dalam menit',
    deskripsi_jasa  VARCHAR(255)    NULL,
    CONSTRAINT pk_jasa_servis PRIMARY KEY (id_jasa),
    CONSTRAINT uq_jasa_nama UNIQUE (nama_jasa),
    CONSTRAINT chk_jasa_harga CHECK (harga_jasa >= 0),
    CONSTRAINT chk_jasa_durasi CHECK (durasi_servis > 0)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 3. TABEL YANG BERGANTUNG PADA TABEL INDUK (FK level 1)
-- ---------------------------------------------------------------------

-- 3.1 KENDARAAN (FK -> pelanggan)
CREATE TABLE kendaraan (
    id_kendaraan    CHAR(5)         NOT NULL,
    id_pelanggan    CHAR(5)         NOT NULL,
    nomor_polisi    VARCHAR(15)     NOT NULL,
    merk            VARCHAR(50)     NOT NULL,
    tipe            VARCHAR(50)     NOT NULL,
    tahun           SMALLINT        NOT NULL,
    warna           VARCHAR(20)     NOT NULL,
    CONSTRAINT pk_kendaraan PRIMARY KEY (id_kendaraan),
    CONSTRAINT uq_kendaraan_polisi UNIQUE (nomor_polisi),
    CONSTRAINT fk_kendaraan_pelanggan FOREIGN KEY (id_pelanggan)
        REFERENCES pelanggan (id_pelanggan)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_kendaraan_tahun CHECK (tahun BETWEEN 1980 AND 2030)
) ENGINE=InnoDB;

-- 3.2 SPAREPART (FK -> supplier)
CREATE TABLE sparepart (
    id_sparepart    CHAR(6)         NOT NULL,
    id_supplier     CHAR(5)         NOT NULL,
    nama_sparepart  VARCHAR(100)    NOT NULL,
    harga           DECIMAL(12,2)   NOT NULL,
    stok            INT             NOT NULL DEFAULT 0,
    CONSTRAINT pk_sparepart PRIMARY KEY (id_sparepart),
    CONSTRAINT fk_sparepart_supplier FOREIGN KEY (id_supplier)
        REFERENCES supplier (id_supplier)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_sparepart_harga CHECK (harga >= 0),
    CONSTRAINT chk_sparepart_stok CHECK (stok >= 0)
) ENGINE=InnoDB;

-- 3.3 PEMBELIAN_SPAREPART (FK -> supplier)
CREATE TABLE pembelian_sparepart (
    id_pembelian        CHAR(6)         NOT NULL,
    id_supplier         CHAR(5)         NOT NULL,
    tanggal_pembelian    DATE            NOT NULL,
    total_pembelian      DECIMAL(14,2)   NOT NULL,
    metode_pembayaran    VARCHAR(20)     NOT NULL,
    status_pembayaran    VARCHAR(15)     NOT NULL DEFAULT 'Lunas',
    CONSTRAINT pk_pembelian_sparepart PRIMARY KEY (id_pembelian),
    CONSTRAINT fk_pembelian_supplier FOREIGN KEY (id_supplier)
        REFERENCES supplier (id_supplier)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_pembelian_total CHECK (total_pembelian >= 0),
    CONSTRAINT chk_pembelian_metode CHECK (metode_pembayaran IN ('Tunai','Transfer','Debit','Kredit')),
    CONSTRAINT chk_pembelian_status CHECK (status_pembayaran IN ('Lunas','Belum Lunas'))
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 4. TABEL TRANSAKSI (FK ke beberapa tabel induk sekaligus)
-- ---------------------------------------------------------------------

-- 4.1 TRANSAKSI_SERVIS (FK -> kendaraan, mekanik, admin)
CREATE TABLE transaksi_servis (
    id_transaksi        CHAR(6)         NOT NULL,
    id_kendaraan         CHAR(5)         NOT NULL,
    id_mekanik           CHAR(5)         NOT NULL,
    id_admin             CHAR(5)         NOT NULL,
    tanggal_servis        DATE            NOT NULL,
    keluhan_pelanggan     VARCHAR(255)    NULL,
    status_servis         VARCHAR(15)     NOT NULL DEFAULT 'Proses',
    total_biaya           DECIMAL(14,2)   NOT NULL DEFAULT 0,
    CONSTRAINT pk_transaksi_servis PRIMARY KEY (id_transaksi),
    CONSTRAINT fk_transaksi_kendaraan FOREIGN KEY (id_kendaraan)
        REFERENCES kendaraan (id_kendaraan)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_transaksi_mekanik FOREIGN KEY (id_mekanik)
        REFERENCES mekanik (id_mekanik)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_transaksi_admin FOREIGN KEY (id_admin)
        REFERENCES admin (id_admin)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_transaksi_total CHECK (total_biaya >= 0),
    CONSTRAINT chk_transaksi_status CHECK (status_servis IN ('Proses','Selesai','Dibatalkan'))
) ENGINE=InnoDB;

-- 4.2 DETAIL_JASA (FK -> transaksi_servis, jasa_servis)
CREATE TABLE detail_jasa (
    id_detail_servis    CHAR(6)         NOT NULL,
    id_transaksi         CHAR(6)         NOT NULL,
    id_jasa               CHAR(5)         NOT NULL,
    subtotal              DECIMAL(12,2)   NOT NULL,
    CONSTRAINT pk_detail_jasa PRIMARY KEY (id_detail_servis),
    CONSTRAINT fk_detailjasa_transaksi FOREIGN KEY (id_transaksi)
        REFERENCES transaksi_servis (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_detailjasa_jasa FOREIGN KEY (id_jasa)
        REFERENCES jasa_servis (id_jasa)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_detailjasa_subtotal CHECK (subtotal >= 0)
) ENGINE=InnoDB;

-- 4.3 DETAIL_SPAREPART (FK -> transaksi_servis, sparepart)
CREATE TABLE detail_sparepart (
    id_detail_sparepart  CHAR(6)         NOT NULL,
    id_transaksi          CHAR(6)         NOT NULL,
    id_sparepart           CHAR(6)         NOT NULL,
    jumlah                 INT             NOT NULL,
    harga_satuan           DECIMAL(12,2)   NOT NULL,
    subtotal               DECIMAL(12,2)   NOT NULL,
    CONSTRAINT pk_detail_sparepart PRIMARY KEY (id_detail_sparepart),
    CONSTRAINT fk_detailsparepart_transaksi FOREIGN KEY (id_transaksi)
        REFERENCES transaksi_servis (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_detailsparepart_sparepart FOREIGN KEY (id_sparepart)
        REFERENCES sparepart (id_sparepart)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_detailsparepart_jumlah CHECK (jumlah > 0),
    CONSTRAINT chk_detailsparepart_harga CHECK (harga_satuan >= 0),
    CONSTRAINT chk_detailsparepart_subtotal CHECK (subtotal >= 0)
) ENGINE=InnoDB;

-- 4.4 PEMBAYARAN (FK -> transaksi_servis, relasi 1-ke-1)
CREATE TABLE pembayaran (
    id_pembayaran    CHAR(6)         NOT NULL,
    id_transaksi      CHAR(6)         NOT NULL,
    tanggal_bayar      DATE            NOT NULL,
    total_bayar        DECIMAL(14,2)   NOT NULL,
    metode_bayar       VARCHAR(20)     NOT NULL,
    CONSTRAINT pk_pembayaran PRIMARY KEY (id_pembayaran),
    CONSTRAINT uq_pembayaran_transaksi UNIQUE (id_transaksi),
    CONSTRAINT fk_pembayaran_transaksi FOREIGN KEY (id_transaksi)
        REFERENCES transaksi_servis (id_transaksi)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT chk_pembayaran_total CHECK (total_bayar >= 0),
    CONSTRAINT chk_pembayaran_metode CHECK (metode_bayar IN ('Tunai','Debit','Transfer','Kredit','QRIS'))
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 5. INDEX TAMBAHAN UNTUK MEMPERCEPAT QUERY
--    (PK & UNIQUE otomatis sudah ada index, ini index tambahan
--     untuk kolom FK dan kolom yang sering dipakai WHERE / JOIN)
-- ---------------------------------------------------------------------
CREATE INDEX idx_kendaraan_pelanggan        ON kendaraan (id_pelanggan);
CREATE INDEX idx_sparepart_supplier         ON sparepart (id_supplier);
CREATE INDEX idx_pembelian_supplier         ON pembelian_sparepart (id_supplier);
CREATE INDEX idx_transaksi_kendaraan        ON transaksi_servis (id_kendaraan);
CREATE INDEX idx_transaksi_mekanik          ON transaksi_servis (id_mekanik);
CREATE INDEX idx_transaksi_admin            ON transaksi_servis (id_admin);
CREATE INDEX idx_transaksi_tanggal          ON transaksi_servis (tanggal_servis);
CREATE INDEX idx_detailjasa_transaksi       ON detail_jasa (id_transaksi);
CREATE INDEX idx_detailjasa_jasa            ON detail_jasa (id_jasa);
CREATE INDEX idx_detailsparepart_transaksi  ON detail_sparepart (id_transaksi);
CREATE INDEX idx_detailsparepart_sparepart  ON detail_sparepart (id_sparepart);
CREATE INDEX idx_pelanggan_nama             ON pelanggan (nama_pelanggan);

-- =====================================================================
-- SELESAI 01_ddl.sql
-- =====================================================================
