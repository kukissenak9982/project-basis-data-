-- =====================================================================
-- 04_view.sql
-- SISTEM BENGKEL KENDARAAN
-- VIEW
-- Dialek : MySQL 8.0
-- =====================================================================

USE bengkel_kendaraan_db;

-- ---------------------------------------------------------------------
-- VIEW 1: v_invoice_servis
-- Tujuan : Menyederhanakan tampilan "invoice" / nota servis sehingga
--          admin atau kasir tidak perlu menulis ulang JOIN 5 tabel
--          setiap kali ingin mencetak struk untuk pelanggan.
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW v_invoice_servis AS
SELECT
    t.id_transaksi,
    t.tanggal_servis,
    p.nama_pelanggan,
    p.no_hp           AS hp_pelanggan,
    k.nomor_polisi,
    k.merk,
    k.tipe,
    m.nama_mekanik,
    a.nama_admin,
    t.status_servis,
    t.total_biaya,
    pb.metode_bayar,
    pb.tanggal_bayar
FROM transaksi_servis t
JOIN kendaraan  k  ON t.id_kendaraan = k.id_kendaraan
JOIN pelanggan  p  ON k.id_pelanggan = p.id_pelanggan
JOIN mekanik    m  ON t.id_mekanik   = m.id_mekanik
JOIN admin      a  ON t.id_admin     = a.id_admin
LEFT JOIN pembayaran pb ON t.id_transaksi = pb.id_transaksi;

-- Contoh pemakaian:
-- SELECT * FROM v_invoice_servis WHERE id_transaksi = 'TR007';

-- ---------------------------------------------------------------------
-- VIEW 2: v_stok_sparepart_kritis
-- Tujuan : Memantau sparepart yang stoknya sudah menipis (di bawah 15
--          unit) sekaligus menampilkan nama dan kontak supplier-nya,
--          supaya admin gudang bisa langsung menghubungi supplier
--          yang tepat untuk melakukan pembelian ulang (re-stock).
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW v_stok_sparepart_kritis AS
SELECT
    sp.id_sparepart,
    sp.nama_sparepart,
    sp.stok,
    sp.harga,
    sup.nama_supplier,
    sup.no_hp   AS hp_supplier
FROM sparepart sp
JOIN supplier sup ON sp.id_supplier = sup.id_supplier
WHERE sp.stok < 15;

-- Contoh pemakaian:
-- SELECT * FROM v_stok_sparepart_kritis ORDER BY stok ASC;

-- =====================================================================
-- SELESAI 04_view.sql
-- =====================================================================
