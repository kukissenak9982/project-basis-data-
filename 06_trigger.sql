-- =====================================================================
-- 06_trigger.sql
-- SISTEM BENGKEL KENDARAAN
-- TRIGGER
-- Dialek : MySQL 8.0
-- =====================================================================

USE bengkel_kendaraan_db;

-- ---------------------------------------------------------------------
-- TRIGGER: trg_kurangi_stok_sparepart
-- Tujuan :
--   Setiap kali ada baris baru masuk ke tabel detail_sparepart
--   (artinya mekanik memakai sparepart untuk suatu transaksi servis),
--   stok sparepart yang bersangkutan di tabel sparepart akan otomatis
--   berkurang sebanyak jumlah yang dipakai. Admin tidak perlu lagi
--   mengurangi stok secara manual satu per satu, sehingga data stok
--   selalu sinkron dengan apa yang benar-benar terpakai.
--
--   Trigger ini juga menjaga supaya stok tidak boleh sampai minus,
--   dengan cara membatalkan transaksi (SIGNAL error) apabila stok
--   yang tersedia tidak cukup untuk memenuhi permintaan.
-- ---------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_kurangi_stok_sparepart;

DELIMITER $$

CREATE TRIGGER trg_kurangi_stok_sparepart
BEFORE INSERT ON detail_sparepart
FOR EACH ROW
BEGIN
    DECLARE v_stok_tersedia INT;

    -- Ambil stok sparepart yang akan dipakai
    SELECT stok INTO v_stok_tersedia
    FROM sparepart
    WHERE id_sparepart = NEW.id_sparepart;

    -- Jika stok tidak cukup, batalkan insert dengan pesan error
    IF v_stok_tersedia < NEW.jumlah THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stok sparepart tidak cukup untuk memenuhi permintaan ini.';
    END IF;

    -- Kurangi stok sparepart sesuai jumlah yang dipakai
    UPDATE sparepart
    SET stok = stok - NEW.jumlah
    WHERE id_sparepart = NEW.id_sparepart;
END$$

DELIMITER ;

-- ---------------------------------------------------------------------
-- CONTOH PENGUJIAN TRIGGER
-- ---------------------------------------------------------------------
-- Cek stok sebelum insert
-- SELECT id_sparepart, nama_sparepart, stok FROM sparepart WHERE id_sparepart = 'PRT001';

-- Tambahkan pemakaian sparepart baru (akan memicu trigger di atas)
-- INSERT INTO detail_sparepart (id_detail_sparepart, id_transaksi, id_sparepart, jumlah, harga_satuan, subtotal)
-- VALUES ('DSP031', 'TR001', 'PRT001', 2, 95000, 190000);

-- Cek stok sesudah insert, harus berkurang 2 dari nilai semula
-- SELECT id_sparepart, nama_sparepart, stok FROM sparepart WHERE id_sparepart = 'PRT001';

-- =====================================================================
-- SELESAI 06_trigger.sql
-- =====================================================================
