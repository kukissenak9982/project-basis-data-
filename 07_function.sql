-- =====================================================================
-- 07_function.sql
-- SISTEM BENGKEL KENDARAAN
-- FUNCTION
-- Dialek : MySQL 8.0
-- =====================================================================

USE bengkel_kendaraan_db;

-- ---------------------------------------------------------------------
-- FUNCTION: fn_hitung_total_biaya_servis
-- Tujuan :
--   Menghitung total biaya sebuah transaksi servis dengan cara
--   menjumlahkan seluruh subtotal pada detail_jasa dan seluruh
--   subtotal pada detail_sparepart untuk id_transaksi yang diberikan.
--   Function ini berguna untuk:
--     - Menampilkan estimasi biaya secara real-time di aplikasi kasir
--       sebelum transaksi ditutup/dibayar.
--     - Dipakai ulang di banyak query atau report tanpa perlu menulis
--       ulang logika SUM + JOIN setiap saat.
-- ---------------------------------------------------------------------
DROP FUNCTION IF EXISTS fn_hitung_total_biaya_servis;

DELIMITER $$

CREATE FUNCTION fn_hitung_total_biaya_servis (p_id_transaksi CHAR(6))
RETURNS DECIMAL(14,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total_jasa      DECIMAL(14,2) DEFAULT 0;
    DECLARE v_total_sparepart DECIMAL(14,2) DEFAULT 0;
    DECLARE v_total_akhir     DECIMAL(14,2) DEFAULT 0;

    SELECT COALESCE(SUM(subtotal), 0) INTO v_total_jasa
    FROM detail_jasa
    WHERE id_transaksi = p_id_transaksi;

    SELECT COALESCE(SUM(subtotal), 0) INTO v_total_sparepart
    FROM detail_sparepart
    WHERE id_transaksi = p_id_transaksi;

    SET v_total_akhir = v_total_jasa + v_total_sparepart;

    RETURN v_total_akhir;
END$$

DELIMITER ;

-- ---------------------------------------------------------------------
-- CONTOH PEMAKAIAN FUNCTION
-- ---------------------------------------------------------------------
-- 1. Dipakai langsung di SELECT untuk satu transaksi:
-- SELECT fn_hitung_total_biaya_servis('TR007') AS estimasi_total;

-- 2. Dipakai untuk membandingkan dengan total_biaya yang tersimpan,
--    supaya admin bisa mengecek apakah ada selisih/kesalahan input:
-- SELECT
--     id_transaksi,
--     total_biaya AS total_tersimpan,
--     fn_hitung_total_biaya_servis(id_transaksi) AS total_hasil_hitung
-- FROM transaksi_servis;

-- =====================================================================
-- SELESAI 07_function.sql
-- =====================================================================
