Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0AAD1F3A
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 06:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbfJJEJC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 00:09:02 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33442 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfJJEJC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 10 Oct 2019 00:09:02 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so3031760pfl.0;
        Wed, 09 Oct 2019 21:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:user-agent:date:from:to:cc:cc:subject:references
         :mime-version:content-disposition;
        bh=e1g0EnZLzjoERtQRi2ji4dhU4QLpN3NQZz20YRsSfgk=;
        b=XPGxJjVjpyw0pDHJ4+PZyUGwGR23+byRVQFlngVNUJBHqW6P9pt9TbNYrxMvPAHy4q
         8qW42OokBxKlG/gLhv16pnSGEnv0QAjbtwrsmBO4gvCHg09sQ0esCiX1ue5GEy9YnZsD
         75EsyKKW/PiZL7B2OBV4/yIYThJ2zeqtHVSndgPfIuZYKnoIZan4nBH2rBtRsUke126N
         CpHMrUv0YuNL4f8gdJqmXnaNl1vRRQ3ZFA3fe6iuvRl7H6e1YdFQpHGl4rp6rcvXas3C
         PLqyrtmKgACSaherHhiu28BPve7LYxditWFsVQvOg2t9fVjceh2Lw7jJ8z45n93psOlg
         Bwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:user-agent:date:from:to:cc:cc:subject
         :references:mime-version:content-disposition;
        bh=e1g0EnZLzjoERtQRi2ji4dhU4QLpN3NQZz20YRsSfgk=;
        b=mWDl+y8+vZNbT3GjJoierNPrGe24obzrUrX3yL3p6ZLIIlt5nZbDA4lsHrFaXcPiEx
         lz7hL9spgsAsnB+w3c96GcMtyTwaG2d0hBVpMQVG4q/W5GDqt1c9oaNpopD3gR30alF5
         gY8aRA4Qidxy8Fr/W/oHJVz0E/l5QMARODa4ojuC9J77zqE99c0LAm+Ge4dIDo6UjGKF
         QWMeQQP2SgEsegFtCNvwjOwXsuZHUuic8L5I5qmugjjoS3ZLGgFrc++D4qKsYt5/faga
         JIoUoOCtTOtOqMx5ziW5ylasmiQkbMw84iTVMWBDJLlQ05OwPsz2S0A8HT12hdnHO05W
         Cy+g==
X-Gm-Message-State: APjAAAX6VAX00tUMPTdyCQoPca4gkJsZKgTxoAYS0SdFUjkmrIgL/zHZ
        XknABw15Q/HKNGiA5HjGYXRG6cHU
X-Google-Smtp-Source: APXvYqyb5rWkYSG4AaLxi4i2JC/45QhV0bMSjd2lehLxYzGX/nPU6L7D6FGCZLRFr2hO5ciLZ59/mg==
X-Received: by 2002:a63:5f86:: with SMTP id t128mr8347566pgb.341.1570680541136;
        Wed, 09 Oct 2019 21:09:01 -0700 (PDT)
Received: from localhost ([2601:1c0:6280:3f0::9ef4])
        by smtp.gmail.com with ESMTPSA id q128sm3884429pga.24.2019.10.09.21.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 21:09:00 -0700 (PDT)
Message-Id: <20191010035239.890311169@gmail.com>
User-Agent: quilt/0.65
Date:   Wed, 09 Oct 2019 20:52:44 -0700
From:   rd.dunlab@gmail.com
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 05/12] infiniband: fix ulp/opa_vnic/opa_vnic_encap.h kernel-doc notation
References: <20191010035239.532908118@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=010-iband-opa-vnic-encaphdr.patch
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make reserved struct fields "private:" so that they don't need to
be added to the kernel-doc notation. This removes 24 warnings.

Remove "[]" in one struct field description to that kernel-doc
won't be confused.

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:148: warning: Function parameter or member 'rsvd0' not described in 'opa_vesw_info' [5 rsvd members]

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:205: warning: Function parameter or member 'rsvd0' not described in 'opa_per_veswport_info' [4 rsvd members]

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:342: warning: Function parameter or member 'reserved' not described in 'opa_veswport_summary_counters'

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:394: warning: Function parameter or member 'rsvd0' not described in 'opa_veswport_error_counters' [10 rsvd members]

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:460: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad'

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:485: warning: Function parameter or member 'reserved' not described in 'opa_vnic_notice_attr'

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:500: warning: Function parameter or member 'reserved' not described in 'opa_vnic_vema_mad_trap'

../drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:263: warning: Function parameter or member 'tbl_entries' not described in 'opa_veswport_mactable'

Signed-off-by: Randy Dunlap <rd.dunlab@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-doc@vger.kernel.org
---
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h |   42 ++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

--- linux-next-20191009.orig/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+++ linux-next-20191009/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
@@ -129,21 +129,31 @@ struct opa_vesw_info {
 	__be16  fabric_id;
 	__be16  vesw_id;
 
+	/* private: */
 	u8      rsvd0[6];
+	/* public: */
 	__be16  def_port_mask;
 
+	/* private: */
 	u8      rsvd1[2];
+	/* public: */
 	__be16  pkey;
 
+	/* private: */
 	u8      rsvd2[4];
+	/* public: */
 	__be32  u_mcast_dlid;
 	__be32  u_ucast_dlid[OPA_VESW_MAX_NUM_DEF_PORT];
 
 	__be32  rc;
 
+	/* private: */
 	u8      rsvd3[56];
+	/* public: */
 	__be16  eth_mtu;
+	/* private: */
 	u8      rsvd4[2];
+	/* public: */
 } __packed;
 
 /**
@@ -172,7 +182,9 @@ struct opa_per_veswport_info {
 	__be32  port_num;
 
 	u8      eth_link_status;
+	/* private: */
 	u8      rsvd0[3];
+	/* public: */
 
 	u8      base_mac_addr[ETH_ALEN];
 	u8      config_state;
@@ -181,7 +193,9 @@ struct opa_per_veswport_info {
 	__be16  max_mac_tbl_ent;
 	__be16  max_smac_ent;
 	__be32  mac_tbl_digest;
+	/* private: */
 	u8      rsvd1[4];
+	/* public: */
 
 	__be32  encap_slid;
 
@@ -195,12 +209,16 @@ struct opa_per_veswport_info {
 	u8      non_vlan_sc_mc;
 	u8      non_vlan_vl_mc;
 
+	/* private: */
 	u8      rsvd2[48];
+	/* public: */
 
 	__be16  uc_macs_gen_count;
 	__be16  mc_macs_gen_count;
 
+	/* private: */
 	u8      rsvd3[8];
+	/* public: */
 } __packed;
 
 /**
@@ -239,7 +257,7 @@ struct opa_veswport_mactable_entry {
  * @offset: mac table starting offset
  * @num_entries: Number of entries to get or set
  * @mac_tbl_digest: mac table digest
- * @tbl_entries[]: Array of table entries
+ * @tbl_entries: Array of table entries
  *
  * The EM sends down this structure in a MAD indicating
  * the starting offset in the forwarding table that this
@@ -337,7 +355,9 @@ struct opa_veswport_summary_counters {
 	__be64  rx_1024_1518;
 	__be64  rx_1519_max;
 
+	/* private: */
 	__be64  reserved[16];
+	/* public: */
 } __packed;
 
 /**
@@ -368,28 +388,42 @@ struct opa_veswport_error_counters {
 	__be64  tx_errors;
 	__be64  rx_errors;
 
+	/* private: */
 	__be64  rsvd0;
+	/* public: */
 	__be64  tx_smac_filt;
+	/* private: */
 	__be64  rsvd1;
 	__be64  rsvd2;
 	__be64  rsvd3;
+	/* public: */
 	__be64  tx_dlid_zero;
+	/* private: */
 	__be64  rsvd4;
+	/* public: */
 	__be64  tx_logic;
+	/* private: */
 	__be64  rsvd5;
+	/* public: */
 	__be64  tx_drop_state;
 
 	__be64  rx_bad_veswid;
+	/* private: */
 	__be64  rsvd6;
+	/* public: */
 	__be64  rx_runt;
 	__be64  rx_oversize;
+	/* private: */
 	__be64  rsvd7;
+	/* public: */
 	__be64  rx_eth_down;
 	__be64  rx_drop_state;
 	__be64  rx_logic;
+	/* private: */
 	__be64  rsvd8;
 
 	__be64  rsvd9[16];
+	/* public: */
 } __packed;
 
 /**
@@ -453,7 +487,9 @@ struct opa_veswport_iface_macs {
 struct opa_vnic_vema_mad {
 	struct ib_mad_hdr  mad_hdr;
 	struct ib_rmpp_hdr rmpp_hdr;
+	/* private: */
 	u8                 reserved;
+	/* public: */
 	u8                 oui[3];
 	u8                 data[OPA_VNIC_EMA_DATA];
 };
@@ -478,7 +514,9 @@ struct opa_vnic_notice_attr {
 	__be16 trap_num;
 	__be16 toggle_count;
 	__be32 issuer_lid;
+	/* private: */
 	__be32 reserved;
+	/* public: */
 	u8     issuer_gid[16];
 	u8     raw_data[64];
 } __packed;
@@ -493,7 +531,9 @@ struct opa_vnic_notice_attr {
 struct opa_vnic_vema_mad_trap {
 	struct ib_mad_hdr            mad_hdr;
 	struct ib_rmpp_hdr           rmpp_hdr;
+	/* private: */
 	u8                           reserved;
+	/* public: */
 	u8                           oui[3];
 	struct opa_vnic_notice_attr  notice;
 };


