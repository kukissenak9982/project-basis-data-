-- =====================================================================
-- 03_query.sql
-- SISTEM BENGKEL KENDARAAN
-- Kumpulan Query SELECT (sederhana, JOIN, subquery/CTE, agregasi)
-- Dialek : MySQL 8.0
-- =====================================================================

USE bengkel_kendaraan_db;

-- =====================================================================
-- QUERY SEDERHANA (1-3)
-- =====================================================================

-- Query 1: Menampilkan semua mekanik dengan status 'Aktif', diurutkan
-- berdasarkan spesialisasi.
SELECT id_mekanik, nama_mekanik, spesialisasi, no_hp, status
FROM mekanik
WHERE status = 'Aktif'
ORDER BY spesialisasi ASC;

-- Query 2: Menampilkan sparepart yang stoknya menipis (di bawah 20 unit),
-- supaya admin bisa segera melakukan pembelian ulang ke supplier.
SELECT id_sparepart, nama_sparepart, harga, stok
FROM sparepart
WHERE stok < 20
ORDER BY stok ASC;

-- Query 3: Menampilkan daftar kendaraan merk Honda beserta tahun dan warnanya.
SELECT id_kendaraan, nomor_polisi, merk, tipe, tahun, warna
FROM kendaraan
WHERE merk = 'Honda'
ORDER BY tahun DESC;

-- =====================================================================
-- QUERY DENGAN JOIN (4-7), minimal melibatkan 3 tabel
-- =====================================================================

-- Query 4: Menampilkan riwayat servis lengkap: nama pelanggan, plat nomor
-- kendaraan, nama mekanik yang menangani, dan tanggal servis.
-- (melibatkan 4 tabel: transaksi_servis, kendaraan, pelanggan, mekanik)
SELECT
    t.id_transaksi,
    p.nama_pelanggan,
    k.nomor_polisi,
    k.merk,
    k.tipe,
    m.nama_mekanik,
    t.tanggal_servis,
    t.status_servis,
    t.total_biaya
FROM transaksi_servis t
JOIN kendaraan  k ON t.id_kendaraan = k.id_kendaraan
JOIN pelanggan  p ON k.id_pelanggan = p.id_pelanggan
JOIN mekanik    m ON t.id_mekanik   = m.id_mekanik
ORDER BY t.tanggal_servis;

-- Query 5: Menampilkan detail jasa apa saja yang dikerjakan pada setiap
-- transaksi, lengkap dengan nama jasa dan subtotalnya.
-- (melibatkan 3 tabel: detail_jasa, jasa_servis, transaksi_servis)
SELECT
    dj.id_transaksi,
    t.tanggal_servis,
    js.nama_jasa,
    dj.subtotal
FROM detail_jasa dj
JOIN jasa_servis      js ON dj.id_jasa = js.id_jasa
JOIN transaksi_servis t  ON dj.id_transaksi = t.id_transaksi
ORDER BY dj.id_transaksi;

-- Query 6: Menampilkan sparepart yang dipakai di setiap transaksi beserta
-- nama supplier asal sparepart tersebut.
-- (melibatkan 3 tabel: detail_sparepart, sparepart, supplier)
SELECT
    ds.id_transaksi,
    sp.nama_sparepart,
    ds.jumlah,
    ds.harga_satuan,
    ds.subtotal,
    sup.nama_supplier
FROM detail_sparepart ds
JOIN sparepart sp  ON ds.id_sparepart = sp.id_sparepart
JOIN supplier  sup ON sp.id_supplier  = sup.id_supplier
ORDER BY ds.id_transaksi;

-- Query 7: Menampilkan rekap pembayaran setiap transaksi, lengkap dengan
-- nama pelanggan dan nama admin yang menangani transaksi tersebut.
-- (melibatkan 4 tabel: pembayaran, transaksi_servis, kendaraan, pelanggan, admin)
SELECT
    pb.id_pembayaran,
    p.nama_pelanggan,
    a.nama_admin,
    pb.tanggal_bayar,
    pb.metode_bayar,
    pb.total_bayar
FROM pembayaran pb
JOIN transaksi_servis t ON pb.id_transaksi = t.id_transaksi
JOIN kendaraan k         ON t.id_kendaraan  = k.id_kendaraan
JOIN pelanggan p         ON k.id_pelanggan  = p.id_pelanggan
JOIN admin a             ON t.id_admin      = a.id_admin
ORDER BY pb.tanggal_bayar;

-- =====================================================================
-- QUERY DENGAN SUBQUERY / CTE (8-9)
-- =====================================================================

-- Query 8: Menampilkan pelanggan yang total biaya servisnya di atas
-- rata-rata seluruh transaksi (subquery pada klausa WHERE).
SELECT
    p.nama_pelanggan,
    k.nomor_polisi,
    t.id_transaksi,
    t.total_biaya
FROM transaksi_servis t
JOIN kendaraan k ON t.id_kendaraan = k.id_kendaraan
JOIN pelanggan p ON k.id_pelanggan = p.id_pelanggan
WHERE t.total_biaya > (
    SELECT AVG(total_biaya) FROM transaksi_servis
)
ORDER BY t.total_biaya DESC;

-- Query 9: Menggunakan CTE (WITH) untuk menghitung total pemakaian
-- sparepart per transaksi, lalu menampilkan transaksi yang nilai
-- pemakaian sparepart-nya lebih besar dari nilai jasa yang dikerjakan.
WITH total_part AS (
    SELECT id_transaksi, SUM(subtotal) AS total_sparepart
    FROM detail_sparepart
    GROUP BY id_transaksi
),
total_jasa AS (
    SELECT id_transaksi, SUM(subtotal) AS total_jasa
    FROM detail_jasa
    GROUP BY id_transaksi
)
SELECT
    tj.id_transaksi,
    tj.total_jasa,
    COALESCE(tp.total_sparepart, 0) AS total_sparepart
FROM total_jasa tj
LEFT JOIN total_part tp ON tj.id_transaksi = tp.id_transaksi
WHERE COALESCE(tp.total_sparepart, 0) > tj.total_jasa
ORDER BY tj.id_transaksi;

-- =====================================================================
-- QUERY AGREGAT + GROUP BY + HAVING (10)
-- =====================================================================

-- Query 10: Menampilkan mekanik yang sudah menangani lebih dari 1
-- transaksi servis, beserta total transaksi yang ditangani dan total
-- pendapatan yang dihasilkan dari pekerjaannya.
SELECT
    m.id_mekanik,
    m.nama_mekanik,
    m.spesialisasi,
    COUNT(t.id_transaksi)      AS jumlah_transaksi,
    SUM(t.total_biaya)         AS total_pendapatan
FROM mekanik m
JOIN transaksi_servis t ON m.id_mekanik = t.id_mekanik
GROUP BY m.id_mekanik, m.nama_mekanik, m.spesialisasi
HAVING COUNT(t.id_transaksi) > 1
ORDER BY total_pendapatan DESC;

-- =====================================================================
-- QUERY TAMBAHAN (bonus, melengkapi analisis sistem)
-- =====================================================================

-- Query 11: Menampilkan 5 sparepart paling sering dipakai (terlaris)
-- beserta total kuantitas dan total omzet dari sparepart tersebut.
SELECT
    sp.nama_sparepart,
    SUM(ds.jumlah)              AS total_terjual,
    SUM(ds.subtotal)            AS total_omzet
FROM detail_sparepart ds
JOIN sparepart sp ON ds.id_sparepart = sp.id_sparepart
GROUP BY sp.nama_sparepart
ORDER BY total_terjual DESC
LIMIT 5;

-- Query 12: Menampilkan total belanja bengkel ke setiap supplier
-- (akumulasi dari tabel pembelian_sparepart) beserta status pembayarannya.
SELECT
    sup.nama_supplier,
    COUNT(pb.id_pembelian)   AS jumlah_transaksi_beli,
    SUM(pb.total_pembelian)  AS total_belanja,
    SUM(CASE WHEN pb.status_pembayaran = 'Belum Lunas' THEN 1 ELSE 0 END) AS jumlah_belum_lunas
FROM pembelian_sparepart pb
JOIN supplier sup ON pb.id_supplier = sup.id_supplier
GROUP BY sup.nama_supplier
ORDER BY total_belanja DESC;

-- =====================================================================
-- SELESAI 03_query.sql
-- =====================================================================
