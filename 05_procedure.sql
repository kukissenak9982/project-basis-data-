-- =====================================================================
-- 05_procedure.sql
-- SISTEM BENGKEL KENDARAAN
-- STORED PROCEDURE
-- Dialek : MySQL 8.0
-- =====================================================================

USE bengkel_kendaraan_db;

-- ---------------------------------------------------------------------
-- PROCEDURE: sp_proses_pembayaran_servis
-- Tujuan :
--   Mengotomatiskan proses "tutup transaksi" pada saat pelanggan
--   membayar servis kendaraannya. Satu procedure ini akan:
--     1. Menghitung ulang total biaya transaksi dari seluruh
--        detail_jasa + detail_sparepart yang sudah tercatat
--        (supaya total_biaya selalu akurat, tidak mengandalkan
--         input manual admin yang bisa salah ketik).
--     2. Meng-update total_biaya & status_servis pada
--        transaksi_servis menjadi 'Selesai'.
--     3. Membuat baris baru pada tabel pembayaran sesuai metode
--        bayar yang dipilih pelanggan.
--   Procedure ini juga dilengkapi penanganan error sederhana
--   apabila id_transaksi tidak ditemukan atau transaksi tersebut
--   sudah pernah dibayar sebelumnya.
-- ---------------------------------------------------------------------
DROP PROCEDURE IF EXISTS sp_proses_pembayaran_servis;

DELIMITER $$

CREATE PROCEDURE sp_proses_pembayaran_servis (
    IN  p_id_transaksi   CHAR(6),
    IN  p_metode_bayar   VARCHAR(20),
    IN  p_tanggal_bayar  DATE,
    OUT p_total_terbayar DECIMAL(14,2)
)
BEGIN
    DECLARE v_total_jasa       DECIMAL(14,2) DEFAULT 0;
    DECLARE v_total_sparepart  DECIMAL(14,2) DEFAULT 0;
    DECLARE v_total_akhir      DECIMAL(14,2) DEFAULT 0;
    DECLARE v_cek_transaksi    INT DEFAULT 0;
    DECLARE v_cek_pembayaran   INT DEFAULT 0;
    DECLARE v_id_pembayaran_baru CHAR(6);

    -- Validasi 1: pastikan id_transaksi memang ada di transaksi_servis
    SELECT COUNT(*) INTO v_cek_transaksi
    FROM transaksi_servis
    WHERE id_transaksi = p_id_transaksi;

    IF v_cek_transaksi = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaksi tidak ditemukan, periksa kembali id_transaksi.';
    END IF;

    -- Validasi 2: pastikan transaksi belum pernah dibayar
    SELECT COUNT(*) INTO v_cek_pembayaran
    FROM pembayaran
    WHERE id_transaksi = p_id_transaksi;

    IF v_cek_pembayaran > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaksi ini sudah memiliki riwayat pembayaran.';
    END IF;

    -- Langkah 1: hitung ulang total dari detail_jasa
    SELECT COALESCE(SUM(subtotal), 0) INTO v_total_jasa
    FROM detail_jasa
    WHERE id_transaksi = p_id_transaksi;

    -- Langkah 2: hitung ulang total dari detail_sparepart
    SELECT COALESCE(SUM(subtotal), 0) INTO v_total_sparepart
    FROM detail_sparepart
    WHERE id_transaksi = p_id_transaksi;

    SET v_total_akhir = v_total_jasa + v_total_sparepart;

    -- Langkah 3: update total_biaya & status_servis pada transaksi_servis
    UPDATE transaksi_servis
    SET total_biaya   = v_total_akhir,
        status_servis = 'Selesai'
    WHERE id_transaksi = p_id_transaksi;

    -- Langkah 4: buat id_pembayaran baru secara otomatis (format BYxxx)
    SELECT CONCAT('BY', LPAD(
                (SELECT COUNT(*) FROM pembayaran) + 1, 3, '0'))
    INTO v_id_pembayaran_baru;

    -- Langkah 5: catat pembayaran
    INSERT INTO pembayaran (id_pembayaran, id_transaksi, tanggal_bayar, total_bayar, metode_bayar)
    VALUES (v_id_pembayaran_baru, p_id_transaksi, p_tanggal_bayar, v_total_akhir, p_metode_bayar);

    -- Kembalikan total yang berhasil dibayar ke pemanggil procedure
    SET p_total_terbayar = v_total_akhir;

END$$

DELIMITER ;

-- ---------------------------------------------------------------------
-- CONTOH PEMANGGILAN PROCEDURE
-- (gunakan transaksi yang BELUM ada di tabel pembayaran, contoh TR021
--  apabila ditambahkan kemudian; di sini ditunjukkan polanya saja)
-- ---------------------------------------------------------------------
-- CALL sp_proses_pembayaran_servis('TR021', 'QRIS', '2024-08-15', @total);
-- SELECT @total AS total_yang_dibayarkan;

-- =====================================================================
-- SELESAI 05_procedure.sql
-- =====================================================================
