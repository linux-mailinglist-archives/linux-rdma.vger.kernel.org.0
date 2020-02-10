Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 616431579E6
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgBJNS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:18:57 -0500
Received: from mga14.intel.com ([192.55.52.115]:48073 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbgBJNSr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:18:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:18:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="347044087"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by fmsmga001.fm.intel.com with ESMTP; 10 Feb 2020 05:18:46 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADIk5E008036;
        Mon, 10 Feb 2020 06:18:46 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADIiqu088327;
        Mon, 10 Feb 2020 08:18:44 -0500
Subject: [PATCH for-next 06/16] IB/hfi1: RSM rules for AIP
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:18:44 -0500
Message-ID: <20200210131844.87776.83118.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
References: <20200210131223.87776.21339.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>

This is implementation of RSM rule for AIP packets.
AIP rule will use rule RSM2 and will match standard
Infiniband packet containg BTH (LNH==BTH) and
having Dest QPN prefixed with value 0x81. Spread between
receive contexts will be done using source QPN bits.

VNIC and AIP will share receive contexts, so their rules
will point to the same RMT entries and their shared
code is moved to separate functions.
If any of the rules is active RMT mapping will be skipped
for latter.

Changed function hfi1_vnic_is_rsm_full to be more general
and moved it from main header to chip.c.

Changed the order of RSM rules because AIP rule as
more specific one is needed to be placed before more
general QOS rule. Rules are occupying two last RSM
registers.

Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c |  171 ++++++++++++++++++++++++++++---------
 drivers/infiniband/hw/hfi1/chip.h |    4 +
 drivers/infiniband/hw/hfi1/hfi.h  |    8 +-
 drivers/infiniband/hw/hfi1/init.c |    4 +
 4 files changed, 137 insertions(+), 50 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index c08bf81..be1fb29 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -124,13 +124,15 @@ struct flag_table {
 
 /*
  * RSM instance allocation
- *   0 - Verbs
- *   1 - User Fecn Handling
- *   2 - Vnic
+ *   0 - User Fecn Handling
+ *   1 - Vnic
+ *   2 - AIP
+ *   3 - Verbs
  */
-#define RSM_INS_VERBS             0
-#define RSM_INS_FECN              1
-#define RSM_INS_VNIC              2
+#define RSM_INS_FECN              0
+#define RSM_INS_VNIC              1
+#define RSM_INS_AIP               2
+#define RSM_INS_VERBS             3
 
 /* Bit offset into the GUID which carries HFI id information */
 #define GUID_HFI_INDEX_SHIFT     39
@@ -171,6 +173,25 @@ struct flag_table {
 /* QPN[m+n:1] QW 1, OFFSET 1 */
 #define QPN_SELECT_OFFSET      ((1ull << QW_SHIFT) | (1ull))
 
+/* RSM fields for AIP */
+/* LRH.BTH above is reused for this rule */
+
+/* BTH.DESTQP: QW 1, OFFSET 16 for match */
+#define BTH_DESTQP_QW           1ull
+#define BTH_DESTQP_BIT_OFFSET   16ull
+#define BTH_DESTQP_OFFSET(off) ((BTH_DESTQP_QW << QW_SHIFT) | (off))
+#define BTH_DESTQP_MATCH_OFFSET BTH_DESTQP_OFFSET(BTH_DESTQP_BIT_OFFSET)
+#define BTH_DESTQP_MASK         0xFFull
+#define BTH_DESTQP_VALUE        0x81ull
+
+/* DETH.SQPN: QW 1 Offset 56 for select */
+/* We use 8 most significant Soure QPN bits as entropy fpr AIP */
+#define DETH_AIP_SQPN_QW 3ull
+#define DETH_AIP_SQPN_BIT_OFFSET 56ull
+#define DETH_AIP_SQPN_OFFSET(off) ((DETH_AIP_SQPN_QW << QW_SHIFT) | (off))
+#define DETH_AIP_SQPN_SELECT_OFFSET \
+	DETH_AIP_SQPN_OFFSET(DETH_AIP_SQPN_BIT_OFFSET)
+
 /* RSM fields for Vnic */
 /* L2_TYPE: QW 0, OFFSET 61 - for match */
 #define L2_TYPE_QW             0ull
@@ -14236,6 +14257,12 @@ static void complete_rsm_map_table(struct hfi1_devdata *dd,
 	}
 }
 
+/* Is a receive side mapping rule */
+static bool has_rsm_rule(struct hfi1_devdata *dd, u8 rule_index)
+{
+	return read_csr(dd, RCV_RSM_CFG + (8 * rule_index)) != 0;
+}
+
 /*
  * Add a receive side mapping rule.
  */
@@ -14472,39 +14499,49 @@ static void init_fecn_handling(struct hfi1_devdata *dd,
 	rmt->used += total_cnt;
 }
 
-/* Initialize RSM for VNIC */
-void hfi1_init_vnic_rsm(struct hfi1_devdata *dd)
+static inline bool hfi1_is_rmt_full(int start, int spare)
+{
+	return (start + spare) > NUM_MAP_ENTRIES;
+}
+
+static bool hfi1_netdev_update_rmt(struct hfi1_devdata *dd)
 {
 	u8 i, j;
 	u8 ctx_id = 0;
 	u64 reg;
 	u32 regoff;
-	struct rsm_rule_data rrd;
+	int rmt_start = dd->vnic.rmt_start;
 
-	if (hfi1_vnic_is_rsm_full(dd, NUM_VNIC_MAP_ENTRIES)) {
-		dd_dev_err(dd, "Vnic RSM disabled, rmt entries used = %d\n",
-			   dd->vnic.rmt_start);
-		return;
+	/* We already have contexts mapped in RMT */
+	if (has_rsm_rule(dd, RSM_INS_VNIC) || has_rsm_rule(dd, RSM_INS_AIP)) {
+		dd_dev_info(dd, "Contexts are already mapped in RMT\n");
+		return true;
+	}
+
+	if (hfi1_is_rmt_full(rmt_start, NUM_VNIC_MAP_ENTRIES)) {
+		dd_dev_err(dd, "Not enought RMT entries used = %d\n",
+			   rmt_start);
+		return false;
 	}
 
-	dev_dbg(&(dd)->pcidev->dev, "Vnic rsm start = %d, end %d\n",
-		dd->vnic.rmt_start,
-		dd->vnic.rmt_start + NUM_VNIC_MAP_ENTRIES);
+	dev_dbg(&(dd)->pcidev->dev, "RMT start = %d, end %d\n",
+		rmt_start,
+		rmt_start + NUM_VNIC_MAP_ENTRIES);
 
 	/* Update RSM mapping table, 32 regs, 256 entries - 1 ctx per byte */
-	regoff = RCV_RSM_MAP_TABLE + (dd->vnic.rmt_start / 8) * 8;
+	regoff = RCV_RSM_MAP_TABLE + (rmt_start / 8) * 8;
 	reg = read_csr(dd, regoff);
 	for (i = 0; i < NUM_VNIC_MAP_ENTRIES; i++) {
-		/* Update map register with vnic context */
-		j = (dd->vnic.rmt_start + i) % 8;
+		/* Update map register with netdev context */
+		j = (rmt_start + i) % 8;
 		reg &= ~(0xffllu << (j * 8));
 		reg |= (u64)dd->vnic.ctxt[ctx_id++]->ctxt << (j * 8);
-		/* Wrap up vnic ctx index */
+		/* Wrap up netdev ctx index */
 		ctx_id %= dd->vnic.num_ctxt;
 		/* Write back map register */
 		if (j == 7 || ((i + 1) == NUM_VNIC_MAP_ENTRIES)) {
 			dev_dbg(&(dd)->pcidev->dev,
-				"Vnic rsm map reg[%d] =0x%llx\n",
+				"RMT[%d] =0x%llx\n",
 				regoff - RCV_RSM_MAP_TABLE, reg);
 
 			write_csr(dd, regoff, reg);
@@ -14514,35 +14551,83 @@ void hfi1_init_vnic_rsm(struct hfi1_devdata *dd)
 		}
 	}
 
-	/* Add rule for vnic */
-	rrd.offset = dd->vnic.rmt_start;
-	rrd.pkt_type = 4;
-	/* Match 16B packets */
-	rrd.field1_off = L2_TYPE_MATCH_OFFSET;
-	rrd.mask1 = L2_TYPE_MASK;
-	rrd.value1 = L2_16B_VALUE;
-	/* Match ETH L4 packets */
-	rrd.field2_off = L4_TYPE_MATCH_OFFSET;
-	rrd.mask2 = L4_16B_TYPE_MASK;
-	rrd.value2 = L4_16B_ETH_VALUE;
-	/* Calc context from veswid and entropy */
-	rrd.index1_off = L4_16B_HDR_VESWID_OFFSET;
-	rrd.index1_width = ilog2(NUM_VNIC_MAP_ENTRIES);
-	rrd.index2_off = L2_16B_ENTROPY_OFFSET;
-	rrd.index2_width = ilog2(NUM_VNIC_MAP_ENTRIES);
-	add_rsm_rule(dd, RSM_INS_VNIC, &rrd);
-
-	/* Enable RSM if not already enabled */
+	return true;
+}
+
+static void hfi1_enable_rsm_rule(struct hfi1_devdata *dd,
+				 int rule, struct rsm_rule_data *rrd)
+{
+	if (!hfi1_netdev_update_rmt(dd)) {
+		dd_dev_err(dd, "Failed to update RMT for RSM%d rule\n", rule);
+		return;
+	}
+
+	add_rsm_rule(dd, rule, rrd);
 	add_rcvctrl(dd, RCV_CTRL_RCV_RSM_ENABLE_SMASK);
 }
 
+void hfi1_init_aip_rsm(struct hfi1_devdata *dd)
+{
+	/*
+	 * go through with the initialisation only if this rule actually doesn't
+	 * exist yet
+	 */
+	if (atomic_fetch_inc(&dd->ipoib_rsm_usr_num) == 0) {
+		struct rsm_rule_data rrd = {
+			.offset = dd->vnic.rmt_start,
+			.pkt_type = IB_PACKET_TYPE,
+			.field1_off = LRH_BTH_MATCH_OFFSET,
+			.mask1 = LRH_BTH_MASK,
+			.value1 = LRH_BTH_VALUE,
+			.field2_off = BTH_DESTQP_MATCH_OFFSET,
+			.mask2 = BTH_DESTQP_MASK,
+			.value2 = BTH_DESTQP_VALUE,
+			.index1_off = DETH_AIP_SQPN_SELECT_OFFSET +
+					ilog2(NUM_VNIC_MAP_ENTRIES),
+			.index1_width = ilog2(NUM_VNIC_MAP_ENTRIES),
+			.index2_off = DETH_AIP_SQPN_SELECT_OFFSET,
+			.index2_width = ilog2(NUM_VNIC_MAP_ENTRIES)
+		};
+
+		hfi1_enable_rsm_rule(dd, RSM_INS_AIP, &rrd);
+	}
+}
+
+/* Initialize RSM for VNIC */
+void hfi1_init_vnic_rsm(struct hfi1_devdata *dd)
+{
+	struct rsm_rule_data rrd = {
+		/* Add rule for vnic */
+		.offset = dd->vnic.rmt_start,
+		.pkt_type = 4,
+		/* Match 16B packets */
+		.field1_off = L2_TYPE_MATCH_OFFSET,
+		.mask1 = L2_TYPE_MASK,
+		.value1 = L2_16B_VALUE,
+		/* Match ETH L4 packets */
+		.field2_off = L4_TYPE_MATCH_OFFSET,
+		.mask2 = L4_16B_TYPE_MASK,
+		.value2 = L4_16B_ETH_VALUE,
+		/* Calc context from veswid and entropy */
+		.index1_off = L4_16B_HDR_VESWID_OFFSET,
+		.index1_width = ilog2(NUM_VNIC_MAP_ENTRIES),
+		.index2_off = L2_16B_ENTROPY_OFFSET,
+		.index2_width = ilog2(NUM_VNIC_MAP_ENTRIES)
+	};
+
+	hfi1_enable_rsm_rule(dd, RSM_INS_VNIC, &rrd);
+}
+
 void hfi1_deinit_vnic_rsm(struct hfi1_devdata *dd)
 {
 	clear_rsm_rule(dd, RSM_INS_VNIC);
+}
 
-	/* Disable RSM if used only by vnic */
-	if (dd->vnic.rmt_start == 0)
-		clear_rcvctrl(dd, RCV_CTRL_RCV_RSM_ENABLE_SMASK);
+void hfi1_deinit_aip_rsm(struct hfi1_devdata *dd)
+{
+	/* only actually clear the rule if it's the last user asking to do so */
+	if (atomic_fetch_add_unless(&dd->ipoib_rsm_usr_num, -1, 0) == 1)
+		clear_rsm_rule(dd, RSM_INS_AIP);
 }
 
 static int init_rxe(struct hfi1_devdata *dd)
diff --git a/drivers/infiniband/hw/hfi1/chip.h b/drivers/infiniband/hw/hfi1/chip.h
index 7255092..b10e0bf 100644
--- a/drivers/infiniband/hw/hfi1/chip.h
+++ b/drivers/infiniband/hw/hfi1/chip.h
@@ -1,7 +1,7 @@
 #ifndef _CHIP_H
 #define _CHIP_H
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -1455,6 +1455,8 @@ int hfi1_set_ctxt_pkey(struct hfi1_devdata *dd, struct hfi1_ctxtdata *ctxt,
 void remap_sdma_interrupts(struct hfi1_devdata *dd, int engine, int msix_intr);
 void reset_interrupts(struct hfi1_devdata *dd);
 u8 hfi1_get_qp_map(struct hfi1_devdata *dd, u8 idx);
+void hfi1_init_aip_rsm(struct hfi1_devdata *dd);
+void hfi1_deinit_aip_rsm(struct hfi1_devdata *dd);
 
 /*
  * Interrupt source table.
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 92fceb5..5a7fa5a 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1419,12 +1419,10 @@ struct hfi1_devdata {
 	struct hfi1_vnic_data vnic;
 	/* Lock to protect IRQ SRC register access */
 	spinlock_t irq_src_lock;
-};
 
-static inline bool hfi1_vnic_is_rsm_full(struct hfi1_devdata *dd, int spare)
-{
-	return (dd->vnic.rmt_start + spare) > NUM_MAP_ENTRIES;
-}
+	/* Keeps track of IPoIB RSM rule users */
+	atomic_t ipoib_rsm_usr_num;
+};
 
 /* 8051 firmware version helper */
 #define dc8051_ver(a, b, c) ((a) << 16 | (b) << 8 | (c))
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index e3acda7..a4a1b3a 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -1333,6 +1333,8 @@ static struct hfi1_devdata *hfi1_alloc_devdata(struct pci_dev *pdev,
 		goto bail;
 	}
 
+	atomic_set(&dd->ipoib_rsm_usr_num, 0);
+
 	kobject_init(&dd->kobj, &hfi1_devdata_type);
 	return dd;
 

