Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D07091901BF
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Mar 2020 00:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgCWXPr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Mar 2020 19:15:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:17967 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCWXPr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 23 Mar 2020 19:15:47 -0400
IronPort-SDR: G/917WpkAnOL6do+2Bg8/6G2IfXlXtN3brrIQ6n9nHopxh/xH1I7jUU3mMBjyEKkvSrmTFATXW
 RQs2fyr5I0bw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 16:15:46 -0700
IronPort-SDR: vEzyPa4boqE+gEO5a/Aa01rYI4edkgDuYCadSNmcAeQNZU9f59U8eHTu8CNPowJnapMp6NaTT6
 kPSctleqixRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="249791001"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga006.jf.intel.com with ESMTP; 23 Mar 2020 16:15:45 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 02NNFier014093;
        Mon, 23 Mar 2020 16:15:45 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 02NNFhCK064510;
        Mon, 23 Mar 2020 19:15:43 -0400
Subject: [PATCH v2 for-next 12/16] IB/hfi1: Activate the dummy netdev
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Date:   Mon, 23 Mar 2020 19:15:43 -0400
Message-ID: <20200323231543.64035.48868.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
References: <20200323231152.64035.19274.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>

As described in earlier patches, ipoib netdev will share receive
contexts with existing VNIC netdev through a dummy netdev. The
following changes are made to achieve that:
- Set up netdev receive contexts after user contexts. A function is
  added to count the available netdev receive contexts.
- Add functions to set/get receive map table free index.
- Rename NUM_VNIC_MAP_ENTRIES as NUM_NETDEV_MAP_ENTRIES.
- Let the dummy netdev own the receive contexts instead of VNIC.
- Allocate the dummy netdev when the hfi1 device is added and free it
  when the device is removed.
- Initialize AIP RSM rules when the IpoIb rxq is initialized and
  remove the rules when it is de-initialized.
- Convert VNIC to use the dummy netdev.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c      |   73 ++++---
 drivers/infiniband/hw/hfi1/driver.c    |   18 --
 drivers/infiniband/hw/hfi1/hfi.h       |   14 -
 drivers/infiniband/hw/hfi1/init.c      |    9 -
 drivers/infiniband/hw/hfi1/ipoib_rx.c  |   10 +
 drivers/infiniband/hw/hfi1/msix.c      |   12 +
 drivers/infiniband/hw/hfi1/msix.h      |    2 
 drivers/infiniband/hw/hfi1/netdev.h    |   19 ++
 drivers/infiniband/hw/hfi1/netdev_rx.c |   46 +++++
 drivers/infiniband/hw/hfi1/vnic.h      |    5 -
 drivers/infiniband/hw/hfi1/vnic_main.c |  312 +++++---------------------------
 11 files changed, 178 insertions(+), 342 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index 2117612..7f35b9e 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -13396,8 +13396,7 @@ static int set_up_interrupts(struct hfi1_devdata *dd)
 static int set_up_context_variables(struct hfi1_devdata *dd)
 {
 	unsigned long num_kernel_contexts;
-	u16 num_netdev_contexts = HFI1_NUM_VNIC_CTXT;
-	int total_contexts;
+	u16 num_netdev_contexts;
 	int ret;
 	unsigned ngroups;
 	int rmt_count;
@@ -13434,13 +13433,6 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 		num_kernel_contexts = send_contexts - num_vls - 1;
 	}
 
-	/* Accommodate VNIC contexts if possible */
-	if ((num_kernel_contexts + num_netdev_contexts) > rcv_contexts) {
-		dd_dev_err(dd, "No receive contexts available for VNIC\n");
-		num_netdev_contexts = 0;
-	}
-	total_contexts = num_kernel_contexts + num_netdev_contexts;
-
 	/*
 	 * User contexts:
 	 *	- default to 1 user context per real (non-HT) CPU core if
@@ -13453,15 +13445,19 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 	/*
 	 * Adjust the counts given a global max.
 	 */
-	if (total_contexts + n_usr_ctxts > rcv_contexts) {
+	if (num_kernel_contexts + n_usr_ctxts > rcv_contexts) {
 		dd_dev_err(dd,
-			   "Reducing # user receive contexts to: %d, from %u\n",
-			   rcv_contexts - total_contexts,
+			   "Reducing # user receive contexts to: %u, from %u\n",
+			   (u32)(rcv_contexts - num_kernel_contexts),
 			   n_usr_ctxts);
 		/* recalculate */
-		n_usr_ctxts = rcv_contexts - total_contexts;
+		n_usr_ctxts = rcv_contexts - num_kernel_contexts;
 	}
 
+	num_netdev_contexts =
+		hfi1_num_netdev_contexts(dd, rcv_contexts -
+					 (num_kernel_contexts + n_usr_ctxts),
+					 &node_affinity.real_cpu_mask);
 	/*
 	 * The RMT entries are currently allocated as shown below:
 	 * 1. QOS (0 to 128 entries);
@@ -13487,17 +13483,16 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 		n_usr_ctxts = user_rmt_reduced;
 	}
 
-	total_contexts += n_usr_ctxts;
-
-	/* the first N are kernel contexts, the rest are user/vnic contexts */
-	dd->num_rcv_contexts = total_contexts;
+	/* the first N are kernel contexts, the rest are user/netdev contexts */
+	dd->num_rcv_contexts =
+		num_kernel_contexts + n_usr_ctxts + num_netdev_contexts;
 	dd->n_krcv_queues = num_kernel_contexts;
 	dd->first_dyn_alloc_ctxt = num_kernel_contexts;
 	dd->num_netdev_contexts = num_netdev_contexts;
 	dd->num_user_contexts = n_usr_ctxts;
 	dd->freectxts = n_usr_ctxts;
 	dd_dev_info(dd,
-		    "rcv contexts: chip %d, used %d (kernel %d, vnic %u, user %u)\n",
+		    "rcv contexts: chip %d, used %d (kernel %d, netdev %u, user %u)\n",
 		    rcv_contexts,
 		    (int)dd->num_rcv_contexts,
 		    (int)dd->n_krcv_queues,
@@ -14554,7 +14549,8 @@ static bool hfi1_netdev_update_rmt(struct hfi1_devdata *dd)
 	u8 ctx_id = 0;
 	u64 reg;
 	u32 regoff;
-	int rmt_start = dd->vnic.rmt_start;
+	int rmt_start = hfi1_netdev_get_free_rmt_idx(dd);
+	int ctxt_count = hfi1_netdev_ctxt_count(dd);
 
 	/* We already have contexts mapped in RMT */
 	if (has_rsm_rule(dd, RSM_INS_VNIC) || has_rsm_rule(dd, RSM_INS_AIP)) {
@@ -14562,7 +14558,7 @@ static bool hfi1_netdev_update_rmt(struct hfi1_devdata *dd)
 		return true;
 	}
 
-	if (hfi1_is_rmt_full(rmt_start, NUM_VNIC_MAP_ENTRIES)) {
+	if (hfi1_is_rmt_full(rmt_start, NUM_NETDEV_MAP_ENTRIES)) {
 		dd_dev_err(dd, "Not enought RMT entries used = %d\n",
 			   rmt_start);
 		return false;
@@ -14570,27 +14566,27 @@ static bool hfi1_netdev_update_rmt(struct hfi1_devdata *dd)
 
 	dev_dbg(&(dd)->pcidev->dev, "RMT start = %d, end %d\n",
 		rmt_start,
-		rmt_start + NUM_VNIC_MAP_ENTRIES);
+		rmt_start + NUM_NETDEV_MAP_ENTRIES);
 
 	/* Update RSM mapping table, 32 regs, 256 entries - 1 ctx per byte */
 	regoff = RCV_RSM_MAP_TABLE + (rmt_start / 8) * 8;
 	reg = read_csr(dd, regoff);
-	for (i = 0; i < NUM_VNIC_MAP_ENTRIES; i++) {
+	for (i = 0; i < NUM_NETDEV_MAP_ENTRIES; i++) {
 		/* Update map register with netdev context */
 		j = (rmt_start + i) % 8;
 		reg &= ~(0xffllu << (j * 8));
-		reg |= (u64)dd->vnic.ctxt[ctx_id++]->ctxt << (j * 8);
+		reg |= (u64)hfi1_netdev_get_ctxt(dd, ctx_id++)->ctxt << (j * 8);
 		/* Wrap up netdev ctx index */
-		ctx_id %= dd->vnic.num_ctxt;
+		ctx_id %= ctxt_count;
 		/* Write back map register */
-		if (j == 7 || ((i + 1) == NUM_VNIC_MAP_ENTRIES)) {
+		if (j == 7 || ((i + 1) == NUM_NETDEV_MAP_ENTRIES)) {
 			dev_dbg(&(dd)->pcidev->dev,
 				"RMT[%d] =0x%llx\n",
 				regoff - RCV_RSM_MAP_TABLE, reg);
 
 			write_csr(dd, regoff, reg);
 			regoff += 8;
-			if (i < (NUM_VNIC_MAP_ENTRIES - 1))
+			if (i < (NUM_NETDEV_MAP_ENTRIES - 1))
 				reg = read_csr(dd, regoff);
 		}
 	}
@@ -14617,8 +14613,9 @@ void hfi1_init_aip_rsm(struct hfi1_devdata *dd)
 	 * exist yet
 	 */
 	if (atomic_fetch_inc(&dd->ipoib_rsm_usr_num) == 0) {
+		int rmt_start = hfi1_netdev_get_free_rmt_idx(dd);
 		struct rsm_rule_data rrd = {
-			.offset = dd->vnic.rmt_start,
+			.offset = rmt_start,
 			.pkt_type = IB_PACKET_TYPE,
 			.field1_off = LRH_BTH_MATCH_OFFSET,
 			.mask1 = LRH_BTH_MASK,
@@ -14627,10 +14624,10 @@ void hfi1_init_aip_rsm(struct hfi1_devdata *dd)
 			.mask2 = BTH_DESTQP_MASK,
 			.value2 = BTH_DESTQP_VALUE,
 			.index1_off = DETH_AIP_SQPN_SELECT_OFFSET +
-					ilog2(NUM_VNIC_MAP_ENTRIES),
-			.index1_width = ilog2(NUM_VNIC_MAP_ENTRIES),
+					ilog2(NUM_NETDEV_MAP_ENTRIES),
+			.index1_width = ilog2(NUM_NETDEV_MAP_ENTRIES),
 			.index2_off = DETH_AIP_SQPN_SELECT_OFFSET,
-			.index2_width = ilog2(NUM_VNIC_MAP_ENTRIES)
+			.index2_width = ilog2(NUM_NETDEV_MAP_ENTRIES)
 		};
 
 		hfi1_enable_rsm_rule(dd, RSM_INS_AIP, &rrd);
@@ -14640,9 +14637,10 @@ void hfi1_init_aip_rsm(struct hfi1_devdata *dd)
 /* Initialize RSM for VNIC */
 void hfi1_init_vnic_rsm(struct hfi1_devdata *dd)
 {
+	int rmt_start = hfi1_netdev_get_free_rmt_idx(dd);
 	struct rsm_rule_data rrd = {
 		/* Add rule for vnic */
-		.offset = dd->vnic.rmt_start,
+		.offset = rmt_start,
 		.pkt_type = 4,
 		/* Match 16B packets */
 		.field1_off = L2_TYPE_MATCH_OFFSET,
@@ -14654,9 +14652,9 @@ void hfi1_init_vnic_rsm(struct hfi1_devdata *dd)
 		.value2 = L4_16B_ETH_VALUE,
 		/* Calc context from veswid and entropy */
 		.index1_off = L4_16B_HDR_VESWID_OFFSET,
-		.index1_width = ilog2(NUM_VNIC_MAP_ENTRIES),
+		.index1_width = ilog2(NUM_NETDEV_MAP_ENTRIES),
 		.index2_off = L2_16B_ENTROPY_OFFSET,
-		.index2_width = ilog2(NUM_VNIC_MAP_ENTRIES)
+		.index2_width = ilog2(NUM_NETDEV_MAP_ENTRIES)
 	};
 
 	hfi1_enable_rsm_rule(dd, RSM_INS_VNIC, &rrd);
@@ -14690,8 +14688,8 @@ static int init_rxe(struct hfi1_devdata *dd)
 	init_qos(dd, rmt);
 	init_fecn_handling(dd, rmt);
 	complete_rsm_map_table(dd, rmt);
-	/* record number of used rsm map entries for vnic */
-	dd->vnic.rmt_start = rmt->used;
+	/* record number of used rsm map entries for netdev */
+	hfi1_netdev_set_free_rmt_idx(dd, rmt->used);
 	kfree(rmt);
 
 	/*
@@ -15245,6 +15243,10 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 		 (dd->revision >> CCE_REVISION_SW_SHIFT)
 		    & CCE_REVISION_SW_MASK);
 
+	/* alloc netdev data */
+	if (hfi1_netdev_alloc(dd))
+		goto bail_cleanup;
+
 	ret = set_up_context_variables(dd);
 	if (ret)
 		goto bail_cleanup;
@@ -15345,6 +15347,7 @@ int hfi1_init_dd(struct hfi1_devdata *dd)
 	hfi1_comp_vectors_clean_up(dd);
 	msix_clean_up_interrupts(dd);
 bail_cleanup:
+	hfi1_netdev_free(dd);
 	hfi1_pcie_ddcleanup(dd);
 bail_free:
 	hfi1_free_devdata(dd);
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index d89fc8f..60ff6de 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1771,28 +1771,10 @@ static void process_receive_ib(struct hfi1_packet *packet)
 	hfi1_ib_rcv(packet);
 }
 
-static inline bool hfi1_is_vnic_packet(struct hfi1_packet *packet)
-{
-	/* Packet received in VNIC context via RSM */
-	if (packet->rcd->is_vnic)
-		return true;
-
-	if ((hfi1_16B_get_l2(packet->ebuf) == OPA_16B_L2_TYPE) &&
-	    (hfi1_16B_get_l4(packet->ebuf) == OPA_16B_L4_ETHR))
-		return true;
-
-	return false;
-}
-
 static void process_receive_bypass(struct hfi1_packet *packet)
 {
 	struct hfi1_devdata *dd = packet->rcd->dd;
 
-	if (hfi1_is_vnic_packet(packet)) {
-		hfi1_vnic_bypass_rcv(packet);
-		return;
-	}
-
 	if (hfi1_setup_bypass_packet(packet))
 		return;
 
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 986d8c3..b4c6bff 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1047,23 +1047,10 @@ struct hfi1_asic_data {
 #define NUM_MAP_ENTRIES	 256
 #define NUM_MAP_REGS      32
 
-/*
- * Number of VNIC contexts used. Ensure it is less than or equal to
- * max queues supported by VNIC (HFI1_VNIC_MAX_QUEUE).
- */
-#define HFI1_NUM_VNIC_CTXT   8
-
-/* Number of VNIC RSM entries */
-#define NUM_VNIC_MAP_ENTRIES 8
-
 /* Virtual NIC information */
 struct hfi1_vnic_data {
-	struct hfi1_ctxtdata *ctxt[HFI1_NUM_VNIC_CTXT];
 	struct kmem_cache *txreq_cache;
-	struct xarray vesws;
 	u8 num_vports;
-	u8 rmt_start;
-	u8 num_ctxt;
 };
 
 struct hfi1_vnic_vport_info;
@@ -1419,6 +1406,7 @@ struct hfi1_devdata {
 	struct hfi1_vnic_data vnic;
 	/* Lock to protect IRQ SRC register access */
 	spinlock_t irq_src_lock;
+	int vnic_num_vports;
 	struct net_device *dummy_netdev;
 
 	/* Keeps track of IPoIB RSM rule users */
diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1/init.c
index 64279d0..5eed436 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -69,6 +69,7 @@
 #include "affinity.h"
 #include "vnic.h"
 #include "exp_rcv.h"
+#include "netdev.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) DRIVER_NAME ": " fmt
@@ -1665,9 +1666,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* do the generic initialization */
 	initfail = hfi1_init(dd, 0);
 
-	/* setup vnic */
-	hfi1_vnic_setup(dd);
-
 	ret = hfi1_register_ib_device(dd);
 
 	/*
@@ -1706,7 +1704,6 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 			hfi1_device_remove(dd);
 		if (!ret)
 			hfi1_unregister_ib_device(dd);
-		hfi1_vnic_cleanup(dd);
 		postinit_cleanup(dd);
 		if (initfail)
 			ret = initfail;
@@ -1751,8 +1748,8 @@ static void remove_one(struct pci_dev *pdev)
 	/* unregister from IB core */
 	hfi1_unregister_ib_device(dd);
 
-	/* cleanup vnic */
-	hfi1_vnic_cleanup(dd);
+	/* free netdev data */
+	hfi1_netdev_free(dd);
 
 	/*
 	 * Disable the IB link, disable interrupts on the device,
diff --git a/drivers/infiniband/hw/hfi1/ipoib_rx.c b/drivers/infiniband/hw/hfi1/ipoib_rx.c
index 606ac69..3afa754 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_rx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_rx.c
@@ -74,8 +74,15 @@ int hfi1_ipoib_rxq_init(struct net_device *netdev)
 {
 	struct hfi1_ipoib_dev_priv *ipoib_priv = hfi1_ipoib_priv(netdev);
 	struct hfi1_devdata *dd = ipoib_priv->dd;
+	int ret;
 
-	return hfi1_netdev_rx_init(dd);
+	ret = hfi1_netdev_rx_init(dd);
+	if (ret)
+		return ret;
+
+	hfi1_init_aip_rsm(dd);
+
+	return ret;
 }
 
 void hfi1_ipoib_rxq_deinit(struct net_device *netdev)
@@ -83,5 +90,6 @@ void hfi1_ipoib_rxq_deinit(struct net_device *netdev)
 	struct hfi1_ipoib_dev_priv *ipoib_priv = hfi1_ipoib_priv(netdev);
 	struct hfi1_devdata *dd = ipoib_priv->dd;
 
+	hfi1_deinit_aip_rsm(dd);
 	hfi1_netdev_rx_destroy(dd);
 }
diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index 7559875e..d61ee85 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -172,7 +172,8 @@ static int msix_request_rcd_irq_common(struct hfi1_ctxtdata *rcd,
 				       const char *name)
 {
 	int nr = msix_request_irq(rcd->dd, rcd, handler, thread,
-				  IRQ_RCVCTXT, name);
+				  rcd->is_vnic ? IRQ_NETDEVCTXT : IRQ_RCVCTXT,
+				  name);
 	if (nr < 0)
 		return nr;
 
@@ -371,15 +372,16 @@ void msix_clean_up_interrupts(struct hfi1_devdata *dd)
 }
 
 /**
- * msix_vnic_syncrhonize_irq() - Vnic IRQ synchronize
+ * msix_netdev_syncrhonize_irq() - netdev IRQ synchronize
  * @dd: valid devdata
  */
-void msix_vnic_synchronize_irq(struct hfi1_devdata *dd)
+void msix_netdev_synchronize_irq(struct hfi1_devdata *dd)
 {
 	int i;
+	int ctxt_count = hfi1_netdev_ctxt_count(dd);
 
-	for (i = 0; i < dd->vnic.num_ctxt; i++) {
-		struct hfi1_ctxtdata *rcd = dd->vnic.ctxt[i];
+	for (i = 0; i < ctxt_count; i++) {
+		struct hfi1_ctxtdata *rcd = hfi1_netdev_get_ctxt(dd, i);
 		struct hfi1_msix_entry *me;
 
 		me = &dd->msix_info.msix_entries[rcd->msix_intr];
diff --git a/drivers/infiniband/hw/hfi1/msix.h b/drivers/infiniband/hw/hfi1/msix.h
index 42fab94..e63e944 100644
--- a/drivers/infiniband/hw/hfi1/msix.h
+++ b/drivers/infiniband/hw/hfi1/msix.h
@@ -60,7 +60,7 @@
 void msix_free_irq(struct hfi1_devdata *dd, u8 msix_intr);
 
 /* Netdev interface */
-void msix_vnic_synchronize_irq(struct hfi1_devdata *dd);
+void msix_netdev_synchronize_irq(struct hfi1_devdata *dd);
 int msix_netdev_request_rcd_irq(struct hfi1_ctxtdata *rcd);
 
 #endif
diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
index edb936f..947543a 100644
--- a/drivers/infiniband/hw/hfi1/netdev.h
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -82,6 +82,25 @@ struct hfi1_ctxtdata *hfi1_netdev_get_ctxt(struct hfi1_devdata *dd, int ctxt)
 	return priv->rxq[ctxt].rcd;
 }
 
+static inline
+int hfi1_netdev_get_free_rmt_idx(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	return priv->rmt_start;
+}
+
+static inline
+void hfi1_netdev_set_free_rmt_idx(struct hfi1_devdata *dd, int rmt_idx)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	priv->rmt_start = rmt_idx;
+}
+
+u32 hfi1_num_netdev_contexts(struct hfi1_devdata *dd, u32 available_contexts,
+			     struct cpumask *cpu_mask);
+
 void hfi1_netdev_enable_queues(struct hfi1_devdata *dd);
 void hfi1_netdev_disable_queues(struct hfi1_devdata *dd);
 int hfi1_netdev_rx_init(struct hfi1_devdata *dd);
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 124e4e8..58af6a4 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -140,6 +140,50 @@ static int hfi1_netdev_allot_ctxt(struct hfi1_netdev_priv *priv,
 	return rc;
 }
 
+/**
+ * hfi1_num_netdev_contexts - Count of netdev recv contexts to use.
+ * @dd: device on which to allocate netdev contexts
+ * @available_contexts: count of available receive contexts
+ * @cpu_mask: mask of possible cpus to include for contexts
+ *
+ * Return: count of physical cores on a node or the remaining available recv
+ * contexts for netdev recv context usage up to the maximum of
+ * HFI1_MAX_NETDEV_CTXTS.
+ * A value of 0 can be returned when acceleration is explicitly turned off,
+ * a memory allocation error occurs or when there are no available contexts.
+ *
+ */
+u32 hfi1_num_netdev_contexts(struct hfi1_devdata *dd, u32 available_contexts,
+			     struct cpumask *cpu_mask)
+{
+	cpumask_var_t node_cpu_mask;
+	unsigned int available_cpus;
+
+	if (!HFI1_CAP_IS_KSET(AIP))
+		return 0;
+
+	/* Always give user contexts priority over netdev contexts */
+	if (available_contexts == 0) {
+		dd_dev_info(dd, "No receive contexts available for netdevs.\n");
+		return 0;
+	}
+
+	if (!zalloc_cpumask_var(&node_cpu_mask, GFP_KERNEL)) {
+		dd_dev_err(dd, "Unable to allocate cpu_mask for netdevs.\n");
+		return 0;
+	}
+
+	cpumask_and(node_cpu_mask, cpu_mask,
+		    cpumask_of_node(pcibus_to_node(dd->pcidev->bus)));
+
+	available_cpus = cpumask_weight(node_cpu_mask);
+
+	free_cpumask_var(node_cpu_mask);
+
+	return min3(available_cpus, available_contexts,
+		    (u32)HFI1_MAX_NETDEV_CTXTS);
+}
+
 static int hfi1_netdev_rxq_init(struct net_device *dev)
 {
 	int i;
@@ -238,7 +282,7 @@ static void disable_queues(struct hfi1_netdev_priv *priv)
 {
 	int i;
 
-	msix_vnic_synchronize_irq(priv->dd);
+	msix_netdev_synchronize_irq(priv->dd);
 
 	for (i = 0; i < priv->num_rx_q; i++) {
 		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
diff --git a/drivers/infiniband/hw/hfi1/vnic.h b/drivers/infiniband/hw/hfi1/vnic.h
index 5ae7815..66150a13 100644
--- a/drivers/infiniband/hw/hfi1/vnic.h
+++ b/drivers/infiniband/hw/hfi1/vnic.h
@@ -1,7 +1,7 @@
 #ifndef _HFI1_VNIC_H
 #define _HFI1_VNIC_H
 /*
- * Copyright(c) 2017 Intel Corporation.
+ * Copyright(c) 2017 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -69,6 +69,7 @@
 #define HFI1_VNIC_SC_SHIFT      4
 
 #define HFI1_VNIC_MAX_QUEUE 16
+#define HFI1_NUM_VNIC_CTXT 8
 
 /**
  * struct hfi1_vnic_sdma - VNIC per Tx ring SDMA information
@@ -104,7 +105,6 @@ struct hfi1_vnic_rx_queue {
 	struct hfi1_vnic_vport_info *vinfo;
 	struct net_device           *netdev;
 	struct napi_struct           napi;
-	struct sk_buff_head          skbq;
 };
 
 /**
@@ -146,7 +146,6 @@ struct hfi1_vnic_vport_info {
 
 /* vnic hfi1 internal functions */
 void hfi1_vnic_setup(struct hfi1_devdata *dd);
-void hfi1_vnic_cleanup(struct hfi1_devdata *dd);
 int hfi1_vnic_txreq_init(struct hfi1_devdata *dd);
 void hfi1_vnic_txreq_deinit(struct hfi1_devdata *dd);
 
diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index db7624c..b183c56 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -53,6 +53,7 @@
 #include <linux/if_vlan.h>
 
 #include "vnic.h"
+#include "netdev.h"
 
 #define HFI_TX_TIMEOUT_MS 1000
 
@@ -62,114 +63,6 @@
 
 static DEFINE_SPINLOCK(vport_cntr_lock);
 
-static int setup_vnic_ctxt(struct hfi1_devdata *dd, struct hfi1_ctxtdata *uctxt)
-{
-	unsigned int rcvctrl_ops = 0;
-	int ret;
-
-	uctxt->do_interrupt = &handle_receive_interrupt;
-
-	/* Now allocate the RcvHdr queue and eager buffers. */
-	ret = hfi1_create_rcvhdrq(dd, uctxt);
-	if (ret)
-		goto done;
-
-	ret = hfi1_setup_eagerbufs(uctxt);
-	if (ret)
-		goto done;
-
-	if (hfi1_rcvhdrtail_kvaddr(uctxt))
-		clear_rcvhdrtail(uctxt);
-
-	rcvctrl_ops = HFI1_RCVCTRL_CTXT_ENB;
-	rcvctrl_ops |= HFI1_RCVCTRL_INTRAVAIL_ENB;
-
-	if (!HFI1_CAP_KGET_MASK(uctxt->flags, MULTI_PKT_EGR))
-		rcvctrl_ops |= HFI1_RCVCTRL_ONE_PKT_EGR_ENB;
-	if (HFI1_CAP_KGET_MASK(uctxt->flags, NODROP_EGR_FULL))
-		rcvctrl_ops |= HFI1_RCVCTRL_NO_EGR_DROP_ENB;
-	if (HFI1_CAP_KGET_MASK(uctxt->flags, NODROP_RHQ_FULL))
-		rcvctrl_ops |= HFI1_RCVCTRL_NO_RHQ_DROP_ENB;
-	if (HFI1_CAP_KGET_MASK(uctxt->flags, DMA_RTAIL))
-		rcvctrl_ops |= HFI1_RCVCTRL_TAILUPD_ENB;
-
-	hfi1_rcvctrl(uctxt->dd, rcvctrl_ops, uctxt);
-done:
-	return ret;
-}
-
-static int allocate_vnic_ctxt(struct hfi1_devdata *dd,
-			      struct hfi1_ctxtdata **vnic_ctxt)
-{
-	struct hfi1_ctxtdata *uctxt;
-	int ret;
-
-	if (dd->flags & HFI1_FROZEN)
-		return -EIO;
-
-	ret = hfi1_create_ctxtdata(dd->pport, dd->node, &uctxt);
-	if (ret < 0) {
-		dd_dev_err(dd, "Unable to create ctxtdata, failing open\n");
-		return -ENOMEM;
-	}
-
-	uctxt->flags = HFI1_CAP_KGET(MULTI_PKT_EGR) |
-			HFI1_CAP_KGET(NODROP_RHQ_FULL) |
-			HFI1_CAP_KGET(NODROP_EGR_FULL) |
-			HFI1_CAP_KGET(DMA_RTAIL);
-	uctxt->seq_cnt = 1;
-	uctxt->is_vnic = true;
-
-	msix_request_rcd_irq(uctxt);
-
-	hfi1_stats.sps_ctxts++;
-	dd_dev_dbg(dd, "created vnic context %d\n", uctxt->ctxt);
-	*vnic_ctxt = uctxt;
-
-	return 0;
-}
-
-static void deallocate_vnic_ctxt(struct hfi1_devdata *dd,
-				 struct hfi1_ctxtdata *uctxt)
-{
-	dd_dev_dbg(dd, "closing vnic context %d\n", uctxt->ctxt);
-	flush_wc();
-
-	/*
-	 * Disable receive context and interrupt available, reset all
-	 * RcvCtxtCtrl bits to default values.
-	 */
-	hfi1_rcvctrl(dd, HFI1_RCVCTRL_CTXT_DIS |
-		     HFI1_RCVCTRL_TIDFLOW_DIS |
-		     HFI1_RCVCTRL_INTRAVAIL_DIS |
-		     HFI1_RCVCTRL_ONE_PKT_EGR_DIS |
-		     HFI1_RCVCTRL_NO_RHQ_DROP_DIS |
-		     HFI1_RCVCTRL_NO_EGR_DROP_DIS, uctxt);
-
-	/* msix_intr will always be > 0, only clean up if this is true */
-	if (uctxt->msix_intr)
-		msix_free_irq(dd, uctxt->msix_intr);
-
-	uctxt->event_flags = 0;
-
-	hfi1_clear_tids(uctxt);
-	hfi1_clear_ctxt_pkey(dd, uctxt);
-
-	hfi1_stats.sps_ctxts--;
-
-	hfi1_free_ctxt(uctxt);
-}
-
-void hfi1_vnic_setup(struct hfi1_devdata *dd)
-{
-	xa_init(&dd->vnic.vesws);
-}
-
-void hfi1_vnic_cleanup(struct hfi1_devdata *dd)
-{
-	WARN_ON(!xa_empty(&dd->vnic.vesws));
-}
-
 #define SUM_GRP_COUNTERS(stats, qstats, x_grp) do {            \
 		u64 *src64, *dst64;                            \
 		for (src64 = &qstats->x_grp.unicast,           \
@@ -179,6 +72,9 @@ void hfi1_vnic_cleanup(struct hfi1_devdata *dd)
 		}                                              \
 	} while (0)
 
+#define VNIC_MASK (0xFF)
+#define VNIC_ID(val) ((1ull << 24) | ((val) & VNIC_MASK))
+
 /* hfi1_vnic_update_stats - update statistics */
 static void hfi1_vnic_update_stats(struct hfi1_vnic_vport_info *vinfo,
 				   struct opa_vnic_stats *stats)
@@ -454,71 +350,25 @@ static inline int hfi1_vnic_decap_skb(struct hfi1_vnic_rx_queue *rxq,
 	return rc;
 }
 
-static inline struct sk_buff *hfi1_vnic_get_skb(struct hfi1_vnic_rx_queue *rxq)
+static struct hfi1_vnic_vport_info *get_vnic_port(struct hfi1_devdata *dd,
+						  int vesw_id)
 {
-	unsigned char *pad_info;
-	struct sk_buff *skb;
-
-	skb = skb_dequeue(&rxq->skbq);
-	if (unlikely(!skb))
-		return NULL;
+	int vnic_id = VNIC_ID(vesw_id);
 
-	/* remove tail padding and icrc */
-	pad_info = skb->data + skb->len - 1;
-	skb_trim(skb, (skb->len - OPA_VNIC_ICRC_TAIL_LEN -
-		       ((*pad_info) & 0x7)));
-
-	return skb;
+	return hfi1_netdev_get_data(dd, vnic_id);
 }
 
-/* hfi1_vnic_handle_rx - handle skb receive */
-static void hfi1_vnic_handle_rx(struct hfi1_vnic_rx_queue *rxq,
-				int *work_done, int work_to_do)
+static struct hfi1_vnic_vport_info *get_first_vnic_port(struct hfi1_devdata *dd)
 {
-	struct hfi1_vnic_vport_info *vinfo = rxq->vinfo;
-	struct sk_buff *skb;
-	int rc;
-
-	while (1) {
-		if (*work_done >= work_to_do)
-			break;
-
-		skb = hfi1_vnic_get_skb(rxq);
-		if (unlikely(!skb))
-			break;
-
-		rc = hfi1_vnic_decap_skb(rxq, skb);
-		/* update rx counters */
-		hfi1_vnic_update_rx_counters(vinfo, rxq->idx, skb, rc);
-		if (unlikely(rc)) {
-			dev_kfree_skb_any(skb);
-			continue;
-		}
-
-		skb_checksum_none_assert(skb);
-		skb->protocol = eth_type_trans(skb, rxq->netdev);
-
-		napi_gro_receive(&rxq->napi, skb);
-		(*work_done)++;
-	}
-}
-
-/* hfi1_vnic_napi - napi receive polling callback function */
-static int hfi1_vnic_napi(struct napi_struct *napi, int budget)
-{
-	struct hfi1_vnic_rx_queue *rxq = container_of(napi,
-					      struct hfi1_vnic_rx_queue, napi);
-	struct hfi1_vnic_vport_info *vinfo = rxq->vinfo;
-	int work_done = 0;
+	struct hfi1_vnic_vport_info *vinfo;
+	int next_id = VNIC_ID(0);
 
-	v_dbg("napi %d budget %d\n", rxq->idx, budget);
-	hfi1_vnic_handle_rx(rxq, &work_done, budget);
+	vinfo = hfi1_netdev_get_first_data(dd, &next_id);
 
-	v_dbg("napi %d work_done %d\n", rxq->idx, work_done);
-	if (work_done < budget)
-		napi_complete(napi);
+	if (next_id > VNIC_ID(VNIC_MASK))
+		return NULL;
 
-	return work_done;
+	return vinfo;
 }
 
 void hfi1_vnic_bypass_rcv(struct hfi1_packet *packet)
@@ -527,13 +377,14 @@ void hfi1_vnic_bypass_rcv(struct hfi1_packet *packet)
 	struct hfi1_vnic_vport_info *vinfo = NULL;
 	struct hfi1_vnic_rx_queue *rxq;
 	struct sk_buff *skb;
-	int l4_type, vesw_id = -1;
+	int l4_type, vesw_id = -1, rc;
 	u8 q_idx;
+	unsigned char *pad_info;
 
 	l4_type = hfi1_16B_get_l4(packet->ebuf);
 	if (likely(l4_type == OPA_16B_L4_ETHR)) {
 		vesw_id = HFI1_VNIC_GET_VESWID(packet->ebuf);
-		vinfo = xa_load(&dd->vnic.vesws, vesw_id);
+		vinfo = get_vnic_port(dd, vesw_id);
 
 		/*
 		 * In case of invalid vesw id, count the error on
@@ -541,10 +392,8 @@ void hfi1_vnic_bypass_rcv(struct hfi1_packet *packet)
 		 */
 		if (unlikely(!vinfo)) {
 			struct hfi1_vnic_vport_info *vinfo_tmp;
-			unsigned long index = 0;
 
-			vinfo_tmp = xa_find(&dd->vnic.vesws, &index, ULONG_MAX,
-					XA_PRESENT);
+			vinfo_tmp = get_first_vnic_port(dd);
 			if (vinfo_tmp) {
 				spin_lock(&vport_cntr_lock);
 				vinfo_tmp->stats[0].netstats.rx_nohandler++;
@@ -563,12 +412,6 @@ void hfi1_vnic_bypass_rcv(struct hfi1_packet *packet)
 	rxq = &vinfo->rxq[q_idx];
 	if (unlikely(!netif_oper_up(vinfo->netdev))) {
 		vinfo->stats[q_idx].rx_drop_state++;
-		skb_queue_purge(&rxq->skbq);
-		return;
-	}
-
-	if (unlikely(skb_queue_len(&rxq->skbq) > HFI1_VNIC_RCV_Q_SIZE)) {
-		vinfo->stats[q_idx].netstats.rx_fifo_errors++;
 		return;
 	}
 
@@ -580,34 +423,41 @@ void hfi1_vnic_bypass_rcv(struct hfi1_packet *packet)
 
 	memcpy(skb->data, packet->ebuf, packet->tlen);
 	skb_put(skb, packet->tlen);
-	skb_queue_tail(&rxq->skbq, skb);
 
-	if (napi_schedule_prep(&rxq->napi)) {
-		v_dbg("napi %d scheduling\n", q_idx);
-		__napi_schedule(&rxq->napi);
+	pad_info = skb->data + skb->len - 1;
+	skb_trim(skb, (skb->len - OPA_VNIC_ICRC_TAIL_LEN -
+		       ((*pad_info) & 0x7)));
+
+	rc = hfi1_vnic_decap_skb(rxq, skb);
+
+	/* update rx counters */
+	hfi1_vnic_update_rx_counters(vinfo, rxq->idx, skb, rc);
+	if (unlikely(rc)) {
+		dev_kfree_skb_any(skb);
+		return;
 	}
+
+	skb_checksum_none_assert(skb);
+	skb->protocol = eth_type_trans(skb, rxq->netdev);
+
+	napi_gro_receive(&rxq->napi, skb);
 }
 
 static int hfi1_vnic_up(struct hfi1_vnic_vport_info *vinfo)
 {
 	struct hfi1_devdata *dd = vinfo->dd;
 	struct net_device *netdev = vinfo->netdev;
-	int i, rc;
+	int rc;
 
 	/* ensure virtual eth switch id is valid */
 	if (!vinfo->vesw_id)
 		return -EINVAL;
 
-	rc = xa_insert(&dd->vnic.vesws, vinfo->vesw_id, vinfo, GFP_KERNEL);
+	rc = hfi1_netdev_add_data(dd, VNIC_ID(vinfo->vesw_id), vinfo);
 	if (rc < 0)
 		return rc;
 
-	for (i = 0; i < vinfo->num_rx_q; i++) {
-		struct hfi1_vnic_rx_queue *rxq = &vinfo->rxq[i];
-
-		skb_queue_head_init(&rxq->skbq);
-		napi_enable(&rxq->napi);
-	}
+	hfi1_netdev_rx_init(dd);
 
 	netif_carrier_on(netdev);
 	netif_tx_start_all_queues(netdev);
@@ -619,23 +469,13 @@ static int hfi1_vnic_up(struct hfi1_vnic_vport_info *vinfo)
 static void hfi1_vnic_down(struct hfi1_vnic_vport_info *vinfo)
 {
 	struct hfi1_devdata *dd = vinfo->dd;
-	u8 i;
 
 	clear_bit(HFI1_VNIC_UP, &vinfo->flags);
 	netif_carrier_off(vinfo->netdev);
 	netif_tx_disable(vinfo->netdev);
-	xa_erase(&dd->vnic.vesws, vinfo->vesw_id);
+	hfi1_netdev_remove_data(dd, VNIC_ID(vinfo->vesw_id));
 
-	/* ensure irqs see the change */
-	msix_vnic_synchronize_irq(dd);
-
-	/* remove unread skbs */
-	for (i = 0; i < vinfo->num_rx_q; i++) {
-		struct hfi1_vnic_rx_queue *rxq = &vinfo->rxq[i];
-
-		napi_disable(&rxq->napi);
-		skb_queue_purge(&rxq->skbq);
-	}
+	hfi1_netdev_rx_destroy(dd);
 }
 
 static int hfi1_netdev_open(struct net_device *netdev)
@@ -660,70 +500,30 @@ static int hfi1_netdev_close(struct net_device *netdev)
 	return 0;
 }
 
-static int hfi1_vnic_allot_ctxt(struct hfi1_devdata *dd,
-				struct hfi1_ctxtdata **vnic_ctxt)
-{
-	int rc;
-
-	rc = allocate_vnic_ctxt(dd, vnic_ctxt);
-	if (rc) {
-		dd_dev_err(dd, "vnic ctxt alloc failed %d\n", rc);
-		return rc;
-	}
-
-	rc = setup_vnic_ctxt(dd, *vnic_ctxt);
-	if (rc) {
-		dd_dev_err(dd, "vnic ctxt setup failed %d\n", rc);
-		deallocate_vnic_ctxt(dd, *vnic_ctxt);
-		*vnic_ctxt = NULL;
-	}
-
-	return rc;
-}
-
 static int hfi1_vnic_init(struct hfi1_vnic_vport_info *vinfo)
 {
 	struct hfi1_devdata *dd = vinfo->dd;
-	int i, rc = 0;
+	int rc = 0;
 
 	mutex_lock(&hfi1_mutex);
-	if (!dd->vnic.num_vports) {
+	if (!dd->vnic_num_vports) {
 		rc = hfi1_vnic_txreq_init(dd);
 		if (rc)
 			goto txreq_fail;
 	}
 
-	for (i = dd->vnic.num_ctxt; i < vinfo->num_rx_q; i++) {
-		rc = hfi1_vnic_allot_ctxt(dd, &dd->vnic.ctxt[i]);
-		if (rc)
-			break;
-		hfi1_rcd_get(dd->vnic.ctxt[i]);
-		dd->vnic.ctxt[i]->vnic_q_idx = i;
-	}
-
-	if (i < vinfo->num_rx_q) {
-		/*
-		 * If required amount of contexts is not
-		 * allocated successfully then remaining contexts
-		 * are released.
-		 */
-		while (i-- > dd->vnic.num_ctxt) {
-			deallocate_vnic_ctxt(dd, dd->vnic.ctxt[i]);
-			hfi1_rcd_put(dd->vnic.ctxt[i]);
-			dd->vnic.ctxt[i] = NULL;
-		}
+	if (hfi1_netdev_rx_init(dd)) {
+		dd_dev_err(dd, "Unable to initialize netdev contexts\n");
 		goto alloc_fail;
 	}
 
-	if (dd->vnic.num_ctxt != i) {
-		dd->vnic.num_ctxt = i;
-		hfi1_init_vnic_rsm(dd);
-	}
+	hfi1_init_vnic_rsm(dd);
 
-	dd->vnic.num_vports++;
+	dd->vnic_num_vports++;
 	hfi1_vnic_sdma_init(vinfo);
+
 alloc_fail:
-	if (!dd->vnic.num_vports)
+	if (!dd->vnic_num_vports)
 		hfi1_vnic_txreq_deinit(dd);
 txreq_fail:
 	mutex_unlock(&hfi1_mutex);
@@ -733,20 +533,14 @@ static int hfi1_vnic_init(struct hfi1_vnic_vport_info *vinfo)
 static void hfi1_vnic_deinit(struct hfi1_vnic_vport_info *vinfo)
 {
 	struct hfi1_devdata *dd = vinfo->dd;
-	int i;
 
 	mutex_lock(&hfi1_mutex);
-	if (--dd->vnic.num_vports == 0) {
-		for (i = 0; i < dd->vnic.num_ctxt; i++) {
-			deallocate_vnic_ctxt(dd, dd->vnic.ctxt[i]);
-			hfi1_rcd_put(dd->vnic.ctxt[i]);
-			dd->vnic.ctxt[i] = NULL;
-		}
+	if (--dd->vnic_num_vports == 0) {
 		hfi1_deinit_vnic_rsm(dd);
-		dd->vnic.num_ctxt = 0;
 		hfi1_vnic_txreq_deinit(dd);
 	}
 	mutex_unlock(&hfi1_mutex);
+	hfi1_netdev_rx_destroy(dd);
 }
 
 static void hfi1_vnic_set_vesw_id(struct net_device *netdev, int id)
@@ -815,14 +609,15 @@ struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
 
 	size = sizeof(struct opa_vnic_rdma_netdev) + sizeof(*vinfo);
 	netdev = alloc_netdev_mqs(size, name, name_assign_type, setup,
-				  dd->num_sdma, dd->num_netdev_contexts);
+				  chip_sdma_engines(dd),
+				  dd->num_netdev_contexts);
 	if (!netdev)
 		return ERR_PTR(-ENOMEM);
 
 	rn = netdev_priv(netdev);
 	vinfo = opa_vnic_dev_priv(netdev);
 	vinfo->dd = dd;
-	vinfo->num_tx_q = dd->num_sdma;
+	vinfo->num_tx_q = chip_sdma_engines(dd);
 	vinfo->num_rx_q = dd->num_netdev_contexts;
 	vinfo->netdev = netdev;
 	rn->free_rdma_netdev = hfi1_vnic_free_rn;
@@ -841,7 +636,6 @@ struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
 		rxq->idx = i;
 		rxq->vinfo = vinfo;
 		rxq->netdev = netdev;
-		netif_napi_add(netdev, &rxq->napi, hfi1_vnic_napi, 64);
 	}
 
 	rc = hfi1_vnic_init(vinfo);

