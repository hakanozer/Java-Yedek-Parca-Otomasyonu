package admin.gorevli;

import com.yedekparca.Common;
import com.yedekparca.MYSQLDB;
import java.awt.GraphicsConfiguration;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.DefaultComboBoxModel;
import javax.swing.DefaultListModel;
import javax.swing.JOptionPane;
import javax.swing.table.DefaultTableModel;

public class Satis extends javax.swing.JFrame {

    public Satis() {
        initComponents();
        fncKategoriGetir();
        fncMusteriGetir();
    }

    public Satis(GraphicsConfiguration gc) {
        super(gc);
    }

    DefaultListModel<String> lmKategori = new DefaultListModel<>();
    ArrayList<Integer> alKategori = new ArrayList<>();

    public void fncKategoriGetir() {
        alKategori.clear();
        try {
            ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proKategoriGetir");
            while (rs.next()) {
                lmKategori.addElement(rs.getString("kadi"));
                alKategori.add(rs.getInt("kid"));
            }
//            System.out.println("Kategori Id Listesi : " + alKategori);
            listKategori.setModel(lmKategori);
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    DefaultListModel<String> lmUrun = new DefaultListModel<>();
    ArrayList<Integer> alUrun = new ArrayList<>();
    ArrayList<Integer> alStok = new ArrayList<>();
    ArrayList<Integer> alParti = new ArrayList<>();

    public void fncUrunGetir() {
        lmUrun.removeAllElements();
        alUrun.clear();
        alStok.clear();
        alParti.clear();
        try {
            ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proUrunGetir('" + alKategori.get(listKategori.getSelectedIndex()) + "')");
            while (rs.next()) {
                lmUrun.addElement(rs.getString("ubaslik") + " / " + rs.getString("sadet") + " adet / " + rs.getString("sfiyat") + " TL");
                alUrun.add(rs.getInt("uid"));
                alStok.add(rs.getInt("sid"));
                alParti.add(rs.getInt("pid"));
            }

//            System.out.println("Ürün Id Listesi : " + alUrun);
            listUrun.setModel(lmUrun);
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    DefaultComboBoxModel<String> cbmMusteri = new DefaultComboBoxModel<>();
    ArrayList<Integer> alMusteri = new ArrayList<>();

    public void fncMusteriGetir() {
        alMusteri.clear();
        cbMusteri.removeAllItems();
        try {
            ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proMusteriGetir");
            while (rs.next()) {
                cbmMusteri.addElement(rs.getString("madi") + " " + rs.getString("msoyadi"));
                alMusteri.add(rs.getInt("mid"));
            }
//            System.out.println("Müsteri Id Listesi : " + alMusteri);
            cbMusteri.setModel(cbmMusteri);
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //bir ürüne ait (birim fiyat * adet) değişkenidir.
    double urunToplamFiyat = 0;

    public void fncStokFiyatGetir() {
        urunToplamFiyat = 0;
        cbStok.setEnabled(true);
        try {
//            System.out.println(alStok);
            ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proStokFiyatGetir('" + alStok.get(listUrun.getSelectedIndex()) + "')");
            if (rs.next()) {
                lblStok.setText(rs.getString("sadet"));
                lblBirimFiyat.setText(rs.getString("sfiyat"));
                cbStok.removeAllItems();
                for (int i = 1; i <= Integer.valueOf(rs.getString("sadet")); i++) {
                    cbStok.addItem(String.valueOf(i));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //referans kodu olarak datenow kullandım.
    LocalDateTime dateNow = null;
    int sonEklenenData = 0;

    public void fncSepeteEkle() {
        if (dateNow == null) {
            dateNow = LocalDateTime.now();
        }
        try {
            String sorgu = "CALL proSepetEkle(" + alUrun.get(listUrun.getSelectedIndex()) + "," + cbStok.getSelectedItem() + ",'" + dateNow + "'," + lblUrunToplamFiyat.getText() + " , " + alParti.get(listUrun.getSelectedIndex()) + " )";
            int sonuc = new MYSQLDB().baglan().executeUpdate(sorgu);
            sonEklenenData = listUrun.getSelectedIndex();
            
        } catch (SQLException ex) {
           
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    
   
    
    
    ArrayList<Integer> alSepet = new ArrayList<>();
    ArrayList<Double> alSepetToplamFiyat = new ArrayList<>();
    ArrayList<Integer> alSepetStokId = new ArrayList<>();
    ArrayList<Integer> alSepetUrunId = new ArrayList<>();
    ArrayList<Integer> alSepetPartiId = new ArrayList<>();

    
    public void fncSepetGetir() {
        DefaultTableModel dtmSepet = new DefaultTableModel();
        //dtmSepet.addColumn("Id");
        //dtmSepet.addColumn("Referans No");
        dtmSepet.addColumn("Ürün Adı");
        dtmSepet.addColumn("Adet");
        dtmSepet.addColumn("Fiyat");
        alSepetToplamFiyat.clear();
        alSepet.clear();
        alSepetStokId.clear();
        try {
            ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proSepetGetir('" + dateNow + "')");
            while (rs.next()) {
                dtmSepet.addRow(new String[]{rs.getString("ubaslik"), rs.getString("adet"), rs.getString("fiyat")});
                alSepetToplamFiyat.add(rs.getDouble("fiyat"));
                alSepet.add(rs.getInt("seid"));
                alSepetStokId.add(rs.getInt("sid"));
                alSepetUrunId.add(rs.getInt("uid"));
                alSepetPartiId.add(rs.getInt("pid"));
                lblReferansKodu.setText("Referans Kodu : " + rs.getString("refkodu"));
            }
            tblSepet.setModel(dtmSepet);
            if (tblSepet.getRowCount() > 0) {
                btnUrunSil.setEnabled(true);
                btnSiparisTamamla.setEnabled(true);
                cbMusteri.setEnabled(true);
            } else {
                btnUrunSil.setEnabled(false);
                btnSiparisTamamla.setEnabled(false);
                cbMusteri.setEnabled(false);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void fncSepetToplam() {
        try {
            ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proSepetToplamFiyatGetir('" + dateNow + "')");
            if (rs.next()) {
                lblSepetToplam.setText(rs.getString("SUM(fiyat)"));
            }
            else{
                lblSepetToplam.setText("--");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void fncSepetSil() {
        try {
            int sonuc = new MYSQLDB().baglan().executeUpdate("CALL proSepetUrunDus("+ alSepetUrunId.get(tblSepet.getSelectedRow()) +", "+alSepetPartiId.get(tblSepet.getSelectedRow())+" )");
            if (sonuc > 0) {
                JOptionPane.showMessageDialog(this, "Silme Başarılı");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void fncSiparisOlustur() {
        try {
            int sonuc = new MYSQLDB().baglan().executeUpdate("CALL proSiparisOlustur('" + dateNow + "', " + lblSepetToplam.getText() + ", " + alMusteri.get(cbMusteri.getSelectedIndex()) + ", " + Common.aid + ")");
            if (sonuc > 0) {
                JOptionPane.showMessageDialog(this, "Sipariş Başarılı");
                // siparis tamamlandığında sepetteki ilgili ürünler için satıldı değeri 1 yapılır.
                new MYSQLDB().baglan().executeUpdate("CALL proSatildimi('" + dateNow + "')");
            }
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void fncUrunAra() {
        lmUrun.removeAllElements();
        alUrun.clear();
        alStok.clear();
        alParti.clear();
        try {
            ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proUrunAra(" + alKategori.get(listKategori.getSelectedIndex()) + ",'" + txtUrunAra.getText().trim() + "')");
            while (rs.next()) {
                lmUrun.addElement(rs.getString("ubaslik") + " / " + rs.getString("sadet") + " adet / " + rs.getString("sfiyat") + " TL");
                alUrun.add(rs.getInt("uid"));
                alStok.add(rs.getInt("sid"));
                alParti.add(rs.getInt("pid"));
            }
//            System.out.println("Ürün Id Listesi : " + alUrun);
            listUrun.setModel(lmUrun);
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // bu fonksiyon ürün sepete eklendiğinde stokdan geçici olarak ürün adedi düşürmek için.
    public void fncStokdanDus() {
        try {
            new MYSQLDB().baglan().executeUpdate("CALL proStokDus(" + alStok.get(listUrun.getSelectedIndex()) + "," + cbStok.getSelectedItem() + ")");
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // bu fonksiyon ürün sepetten silindiğinde stoğu artırır.
    public void fncStokArtir() {
        try {
            new MYSQLDB().baglan().executeUpdate("CALL proStokEkle(" + alSepetStokId.get(tblSepet.getSelectedRow()) + "," + tblSepet.getValueAt(tblSepet.getSelectedRow(), 1) + ")");
        } catch (SQLException ex) {
            Logger.getLogger(Satis.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        listKategori = new javax.swing.JList<String>();
        jScrollPane2 = new javax.swing.JScrollPane();
        listUrun = new javax.swing.JList<String>();
        txtUrunAra = new javax.swing.JTextField();
        lblStok = new javax.swing.JLabel();
        lblBirimFiyat = new javax.swing.JLabel();
        btnSepeteEkle = new javax.swing.JButton();
        lblUrunToplamFiyat = new javax.swing.JLabel();
        cbStok = new javax.swing.JComboBox<String>();
        jPanel2 = new javax.swing.JPanel();
        jScrollPane3 = new javax.swing.JScrollPane();
        tblSepet = new javax.swing.JTable();
        lblSepetToplam = new javax.swing.JLabel();
        cbMusteri = new javax.swing.JComboBox<String>();
        btnSiparisTamamla = new javax.swing.JButton();
        btnUrunSil = new javax.swing.JButton();
        lblReferansKodu = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DO_NOTHING_ON_CLOSE);
        setTitle("Satış Yönetimi");
        setResizable(false);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowClosing(java.awt.event.WindowEvent evt) {
                formWindowClosing(evt);
            }
            public void windowClosed(java.awt.event.WindowEvent evt) {
                formWindowClosed(evt);
            }
        });

        jPanel1.setBorder(javax.swing.BorderFactory.createTitledBorder("Ürün Seçimi"));

        listKategori.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Kategori Seçimi", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.TOP));
        listKategori.setModel(new javax.swing.AbstractListModel() {
            String[] strings = { "Item 1", "Item 2", "Item 3", "Item 4", "Item 5" };
            public int getSize() { return strings.length; }
            public Object getElementAt(int i) { return strings[i]; }
        });
        listKategori.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseReleased(java.awt.event.MouseEvent evt) {
                listKategoriMouseReleased(evt);
            }
        });
        jScrollPane1.setViewportView(listKategori);

        listUrun.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Ürün Seçimi", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.TOP));
        listUrun.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseReleased(java.awt.event.MouseEvent evt) {
                listUrunMouseReleased(evt);
            }
        });
        jScrollPane2.setViewportView(listUrun);

        txtUrunAra.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyReleased(java.awt.event.KeyEvent evt) {
                txtUrunAraKeyReleased(evt);
            }
        });

        lblStok.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        lblStok.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblStok.setText("--");
        lblStok.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Stok", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.TOP));

        lblBirimFiyat.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        lblBirimFiyat.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblBirimFiyat.setText("--");
        lblBirimFiyat.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Fiyat / Adet", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.TOP));

        btnSepeteEkle.setIcon(new javax.swing.ImageIcon(getClass().getResource("/media/Save-icon.png"))); // NOI18N
        btnSepeteEkle.setText("Sepete Ekle");
        btnSepeteEkle.setEnabled(false);
        btnSepeteEkle.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSepeteEkleActionPerformed(evt);
            }
        });

        lblUrunToplamFiyat.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        lblUrunToplamFiyat.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblUrunToplamFiyat.setText("--");
        lblUrunToplamFiyat.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Toplam Fiyat", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.TOP));

        cbStok.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Adet Seçiniz", javax.swing.border.TitledBorder.LEFT, javax.swing.border.TitledBorder.TOP));
        cbStok.setEnabled(false);
        cbStok.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cbStokİtemStateChanged(evt);
            }
        });
        cbStok.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mousePressed(java.awt.event.MouseEvent evt) {
                cbStokMousePressed(evt);
            }
            public void mouseReleased(java.awt.event.MouseEvent evt) {
                cbStokMouseReleased(evt);
            }
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                cbStokMouseClicked(evt);
            }
        });
        cbStok.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cbStokActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(cbStok, javax.swing.GroupLayout.PREFERRED_SIZE, 131, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(lblUrunToplamFiyat, javax.swing.GroupLayout.PREFERRED_SIZE, 266, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(17, 17, 17)
                        .addComponent(btnSepeteEkle, javax.swing.GroupLayout.DEFAULT_SIZE, 110, Short.MAX_VALUE))
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 134, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(txtUrunAra)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 274, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(lblBirimFiyat, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .addComponent(lblStok, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))))
                .addContainerGap())
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jScrollPane1)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addComponent(txtUrunAra, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(jPanel1Layout.createSequentialGroup()
                                .addComponent(lblStok, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addGap(18, 18, 18)
                                .addComponent(lblBirimFiyat))
                            .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnSepeteEkle, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(jPanel1Layout.createSequentialGroup()
                        .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(lblUrunToplamFiyat, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addComponent(cbStok))
                        .addGap(0, 3, Short.MAX_VALUE)))
                .addContainerGap())
        );

        jPanel2.setBorder(javax.swing.BorderFactory.createTitledBorder("Sepet"));

        tblSepet.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "Ürün", "Adet", "Fiyat"
            }
        ));
        jScrollPane3.setViewportView(tblSepet);

        lblSepetToplam.setFont(new java.awt.Font("Arial", 1, 24)); // NOI18N
        lblSepetToplam.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        lblSepetToplam.setText("--");
        lblSepetToplam.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Sepet Toplamı", javax.swing.border.TitledBorder.CENTER, javax.swing.border.TitledBorder.TOP));

        cbMusteri.setModel(new javax.swing.DefaultComboBoxModel(new String[] { "Şirket İçi", "Ali", "Veli", "Hasan", "Ayşe" }));
        cbMusteri.setBorder(javax.swing.BorderFactory.createTitledBorder(null, "Müşteri Seçiniz", javax.swing.border.TitledBorder.LEFT, javax.swing.border.TitledBorder.TOP));
        cbMusteri.setEnabled(false);
        cbMusteri.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cbMusteriActionPerformed(evt);
            }
        });

        btnSiparisTamamla.setIcon(new javax.swing.ImageIcon(getClass().getResource("/media/Save-icon.png"))); // NOI18N
        btnSiparisTamamla.setText("Siparişi Tamamla");
        btnSiparisTamamla.setEnabled(false);
        btnSiparisTamamla.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnSiparisTamamlaActionPerformed(evt);
            }
        });

        btnUrunSil.setIcon(new javax.swing.ImageIcon(getClass().getResource("/media/delete.png"))); // NOI18N
        btnUrunSil.setText("Sil");
        btnUrunSil.setEnabled(false);
        btnUrunSil.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnUrunSilActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jScrollPane3)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addComponent(lblSepetToplam, javax.swing.GroupLayout.PREFERRED_SIZE, 150, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(cbMusteri, javax.swing.GroupLayout.PREFERRED_SIZE, 178, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addGap(18, 18, 18)
                        .addComponent(btnSiparisTamamla, javax.swing.GroupLayout.DEFAULT_SIZE, 178, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addGap(11, 11, 11)
                        .addComponent(lblReferansKodu)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnUrunSil)))
                .addContainerGap())
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel2Layout.createSequentialGroup()
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnUrunSil)
                    .addComponent(lblReferansKodu))
                .addGap(9, 9, 9)
                .addComponent(jScrollPane3, javax.swing.GroupLayout.PREFERRED_SIZE, 109, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(jPanel2Layout.createSequentialGroup()
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(lblSepetToplam, javax.swing.GroupLayout.PREFERRED_SIZE, 47, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(cbMusteri, javax.swing.GroupLayout.Alignment.TRAILING, javax.swing.GroupLayout.PREFERRED_SIZE, 47, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel2Layout.createSequentialGroup()
                        .addGap(12, 12, 12)
                        .addComponent(btnSiparisTamamla, javax.swing.GroupLayout.PREFERRED_SIZE, 46, javax.swing.GroupLayout.PREFERRED_SIZE))))
        );

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
        setLocationRelativeTo(null);
    }// </editor-fold>//GEN-END:initComponents

    private void listKategoriMouseReleased(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_listKategoriMouseReleased
        txtUrunAra.setText("");
        lblStok.setText("--");
        lblBirimFiyat.setText("--");
        lblUrunToplamFiyat.setText("--");
        cbStok.setEnabled(false);
        btnSepeteEkle.setEnabled(false);
        fncUrunGetir();

    }//GEN-LAST:event_listKategoriMouseReleased

    private void listUrunMouseReleased(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_listUrunMouseReleased
        fncStokFiyatGetir();
        if ("0".equals(lblStok.getText())) {
            cbStok.setEnabled(false);
            btnSepeteEkle.setEnabled(false);
        } else {
            cbStok.setEnabled(true);
            btnSepeteEkle.setEnabled(true);
        }
    }//GEN-LAST:event_listUrunMouseReleased

    private void cbStokİtemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cbStokİtemStateChanged
        
    }//GEN-LAST:event_cbStokİtemStateChanged

    private void cbStokMouseReleased(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_cbStokMouseReleased

    }//GEN-LAST:event_cbStokMouseReleased

    private void cbStokMousePressed(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_cbStokMousePressed

    }//GEN-LAST:event_cbStokMousePressed

    private void cbStokActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cbStokActionPerformed
        if (!(cbStok.getItemCount() == 0)) {
            urunToplamFiyat = Integer.valueOf((String) cbStok.getSelectedItem()) * Double.valueOf(lblBirimFiyat.getText());
            lblUrunToplamFiyat.setText(String.valueOf(urunToplamFiyat));
        } else {
            lblUrunToplamFiyat.setText("--");
        }
    }//GEN-LAST:event_cbStokActionPerformed

    private void cbStokMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_cbStokMouseClicked

    }//GEN-LAST:event_cbStokMouseClicked

    private void btnSepeteEkleActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSepeteEkleActionPerformed
        fncSepeteEkle();
        fncStokdanDus();
        fncStokFiyatGetir();
        fncUrunGetir();
        fncSepetGetir();
        fncSepetToplam();
        listUrun.setSelectedIndex(sonEklenenData);
    }//GEN-LAST:event_btnSepeteEkleActionPerformed

    private void cbMusteriActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cbMusteriActionPerformed

    }//GEN-LAST:event_cbMusteriActionPerformed

    private void btnUrunSilActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnUrunSilActionPerformed
        fncStokArtir();
        fncSepetSil();
        fncSepetGetir();
        fncUrunGetir();
        fncSepetToplam();
        listUrun.setSelectedIndex(sonEklenenData);
        fncStokFiyatGetir();
    }//GEN-LAST:event_btnUrunSilActionPerformed

    private void btnSiparisTamamlaActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnSiparisTamamlaActionPerformed
        fncSiparisOlustur();
        lblReferansKodu.setText("");
        lblSepetToplam.setText("--");
        dateNow = null;
        fncSepetGetir();
    }//GEN-LAST:event_btnSiparisTamamlaActionPerformed

    private void txtUrunAraKeyReleased(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_txtUrunAraKeyReleased
        lblStok.setText("--");
        lblBirimFiyat.setText("--");
        lblUrunToplamFiyat.setText("--");
        cbStok.setEnabled(false);
        btnSepeteEkle.setEnabled(false);
        fncUrunAra();
    }//GEN-LAST:event_txtUrunAraKeyReleased

    private void formWindowClosed(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosed

    }//GEN-LAST:event_formWindowClosed

    private void formWindowClosing(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowClosing
//        System.out.println("tblSepet.getRowCount() : " + tblSepet.getRowCount());
        if (tblSepet.getRowCount() > 0) {
            int cevap = JOptionPane.showConfirmDialog(this, "Sepette ürün var çıkış yapmak istediğinize emin misiniz?", "Çıkış", 0);
//            System.out.println("cevap : " + cevap);
            if (cevap == 0) {
                try {
                    ResultSet rs = new MYSQLDB().baglan().executeQuery("CALL proSepetGetir('" + dateNow + "')");
                     
                    while (rs.next()) {
                        int sonuc = new MYSQLDB().baglan().executeUpdate("CALL proStokEkle(" + rs.getInt("sid") + ", "+ rs.getInt("adet")+")");
                    }
                } catch (Exception e) {
                }
                this.setVisible(false);
            } else if (cevap == 1) {
                this.setVisible(true);
            }
        } else if (tblSepet.getRowCount() == 0) {
            this.setVisible(false);
        }
    }//GEN-LAST:event_formWindowClosing

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Satis.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Satis.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Satis.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Satis.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Satis().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnSepeteEkle;
    private javax.swing.JButton btnSiparisTamamla;
    private javax.swing.JButton btnUrunSil;
    private javax.swing.JComboBox<String> cbMusteri;
    private javax.swing.JComboBox<String> cbStok;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JScrollPane jScrollPane3;
    private javax.swing.JLabel lblBirimFiyat;
    private javax.swing.JLabel lblReferansKodu;
    private javax.swing.JLabel lblSepetToplam;
    private javax.swing.JLabel lblStok;
    private javax.swing.JLabel lblUrunToplamFiyat;
    private javax.swing.JList<String> listKategori;
    private javax.swing.JList<String> listUrun;
    private javax.swing.JTable tblSepet;
    private javax.swing.JTextField txtUrunAra;
    // End of variables declaration//GEN-END:variables

}
