Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC431579EE
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgBJNTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:19:11 -0500
Received: from mga18.intel.com ([134.134.136.126]:22201 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729443AbgBJNTG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:19:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:19:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="221552513"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 05:19:05 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADJ4JD008048;
        Mon, 10 Feb 2020 06:19:04 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADJ2Bq088370;
        Mon, 10 Feb 2020 08:19:03 -0500
Subject: [PATCH for-next 09/16] IB/hfi1: Add functions to receive
 accelerated ipoib packets
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>
Date:   Mon, 10 Feb 2020 08:19:02 -0500
Message-ID: <20200210131902.87776.93016.stgit@awfm-01.aw.intel.com>
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

Ipoib netdev will share receive contexts with existing VNIC netdev.
To achieve that, a dummy netdev is allocated with hfi1_devdata to
own the receive contexts, and ipoib and VNIC netdevs will be put
on top of it. Each receive context is associated with a single
NAPI object.

This patch adds the functions to receive incoming packets for
accelerated ipoib.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/Makefile    |    2 +
 drivers/infiniband/hw/hfi1/driver.c    |   92 ++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/hfi.h       |    5 +-
 drivers/infiniband/hw/hfi1/ipoib.h     |   18 ++++++
 drivers/infiniband/hw/hfi1/ipoib_rx.c  |   71 +++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/netdev.h    |   90 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi1/netdev_rx.c |   76 ++++++++++++++++++++++++++
 7 files changed, 352 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi1/ipoib_rx.c
 create mode 100644 drivers/infiniband/hw/hfi1/netdev.h
 create mode 100644 drivers/infiniband/hw/hfi1/netdev_rx.c

diff --git a/drivers/infiniband/hw/hfi1/Makefile b/drivers/infiniband/hw/hfi1/Makefile
index 0b25713..2e89ec1 100644
--- a/drivers/infiniband/hw/hfi1/Makefile
+++ b/drivers/infiniband/hw/hfi1/Makefile
@@ -23,10 +23,12 @@ hfi1-y := \
 	intr.o \
 	iowait.o \
 	ipoib_main.o \
+	ipoib_rx.o \
 	ipoib_tx.o \
 	mad.o \
 	mmu_rb.o \
 	msix.o \
+	netdev_rx.o \
 	opfn.o \
 	pcie.o \
 	pio.o \
diff --git a/drivers/infiniband/hw/hfi1/driver.c b/drivers/infiniband/hw/hfi1/driver.c
index 049d15b..c5ed6ed 100644
--- a/drivers/infiniband/hw/hfi1/driver.c
+++ b/drivers/infiniband/hw/hfi1/driver.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2015-2018 Intel Corporation.
+ * Copyright(c) 2015-2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -54,6 +54,7 @@
 #include <linux/module.h>
 #include <linux/prefetch.h>
 #include <rdma/ib_verbs.h>
+#include <linux/etherdevice.h>
 
 #include "hfi.h"
 #include "trace.h"
@@ -63,6 +64,9 @@
 #include "vnic.h"
 #include "fault.h"
 
+#include "ipoib.h"
+#include "netdev.h"
+
 #undef pr_fmt
 #define pr_fmt(fmt) DRIVER_NAME ": " fmt
 
@@ -1550,6 +1554,81 @@ void handle_eflags(struct hfi1_packet *packet)
 		show_eflags_errs(packet);
 }
 
+static void hfi1_ipoib_ib_rcv(struct hfi1_packet *packet)
+{
+	struct hfi1_ibport *ibp;
+	struct net_device *netdev;
+	struct hfi1_ctxtdata *rcd = packet->rcd;
+	struct napi_struct *napi = rcd->napi;
+	struct sk_buff *skb;
+	struct hfi1_netdev_rxq *rxq = container_of(napi,
+			struct hfi1_netdev_rxq, napi);
+	u32 extra_bytes;
+	u32 tlen, qpnum;
+	bool do_work, do_cnp;
+	struct hfi1_ipoib_dev_priv *priv;
+
+	trace_hfi1_rcvhdr(packet);
+
+	hfi1_setup_ib_header(packet);
+
+	packet->ohdr = &((struct ib_header *)packet->hdr)->u.oth;
+	packet->grh = NULL;
+
+	if (unlikely(rhf_err_flags(packet->rhf))) {
+		handle_eflags(packet);
+		return;
+	}
+
+	qpnum = ib_bth_get_qpn(packet->ohdr);
+	netdev = hfi1_netdev_get_data(rcd->dd, qpnum);
+	if (!netdev)
+		goto drop_no_nd;
+
+	trace_input_ibhdr(rcd->dd, packet, !!(rhf_dc_info(packet->rhf)));
+
+	/* handle congestion notifications */
+	do_work = hfi1_may_ecn(packet);
+	if (unlikely(do_work)) {
+		do_cnp = (packet->opcode != IB_OPCODE_CNP);
+		(void)hfi1_process_ecn_slowpath(hfi1_ipoib_priv(netdev)->qp,
+						 packet, do_cnp);
+	}
+
+	/*
+	 * We have split point after last byte of DETH
+	 * lets strip padding and CRC and ICRC.
+	 * tlen is whole packet len so we need to
+	 * subtract header size as well.
+	 */
+	tlen = packet->tlen;
+	extra_bytes = ib_bth_get_pad(packet->ohdr) + (SIZE_OF_CRC << 2) +
+			packet->hlen;
+	if (unlikely(tlen < extra_bytes))
+		goto drop;
+
+	tlen -= extra_bytes;
+
+	skb = hfi1_ipoib_prepare_skb(rxq, tlen, packet->ebuf);
+	if (unlikely(!skb))
+		goto drop;
+
+	priv = hfi1_ipoib_priv(netdev);
+	hfi1_ipoib_update_rx_netstats(priv, 1, skb->len);
+
+	skb->dev = netdev;
+	skb->pkt_type = PACKET_HOST;
+	netif_receive_skb(skb);
+
+	return;
+
+drop:
+	++netdev->stats.rx_dropped;
+drop_no_nd:
+	ibp = rcd_to_iport(packet->rcd);
+	++ibp->rvp.n_pkt_drops;
+}
+
 /*
  * The following functions are called by the interrupt handler. They are type
  * specific handlers for each packet type.
@@ -1757,3 +1836,14 @@ void seqfile_dump_rcd(struct seq_file *s, struct hfi1_ctxtdata *rcd)
 	[RHF_RCV_TYPE_INVALID6] = process_receive_invalid,
 	[RHF_RCV_TYPE_INVALID7] = process_receive_invalid,
 };
+
+const rhf_rcv_function_ptr netdev_rhf_rcv_functions[] = {
+	[RHF_RCV_TYPE_EXPECTED] = process_receive_invalid,
+	[RHF_RCV_TYPE_EAGER] = process_receive_invalid,
+	[RHF_RCV_TYPE_IB] = hfi1_ipoib_ib_rcv,
+	[RHF_RCV_TYPE_ERROR] = process_receive_error,
+	[RHF_RCV_TYPE_BYPASS] = hfi1_vnic_bypass_rcv,
+	[RHF_RCV_TYPE_INVALID5] = process_receive_invalid,
+	[RHF_RCV_TYPE_INVALID6] = process_receive_invalid,
+	[RHF_RCV_TYPE_INVALID7] = process_receive_invalid,
+};
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 2ff3904..5798688 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -233,6 +233,8 @@ struct hfi1_ctxtdata {
 	intr_handler fast_handler;
 	/** slow handler */
 	intr_handler slow_handler;
+	/* napi pointer assiociated with netdev */
+	struct napi_struct *napi;
 	/* verbs rx_stats per rcd */
 	struct hfi1_opcode_stats_perctx *opstats;
 	/* clear interrupt mask */
@@ -985,7 +987,7 @@ typedef void (*hfi1_make_req)(struct rvt_qp *qp,
 			      struct hfi1_pkt_state *ps,
 			      struct rvt_swqe *wqe);
 extern const rhf_rcv_function_ptr normal_rhf_rcv_functions[];
-
+extern const rhf_rcv_function_ptr netdev_rhf_rcv_functions[];
 
 /* return values for the RHF receive functions */
 #define RHF_RCV_CONTINUE  0	/* keep going */
@@ -1419,6 +1421,7 @@ struct hfi1_devdata {
 	struct hfi1_vnic_data vnic;
 	/* Lock to protect IRQ SRC register access */
 	spinlock_t irq_src_lock;
+	struct net_device *dummy_netdev;
 
 	/* Keeps track of IPoIB RSM rule users */
 	atomic_t ipoib_rsm_usr_num;
diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index c2e63ca..ca00f6c 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -22,6 +22,7 @@
 
 #include "hfi.h"
 #include "iowait.h"
+#include "netdev.h"
 
 #include <rdma/ib_verbs.h>
 
@@ -29,6 +30,7 @@
 
 #define HFI1_IPOIB_TXREQ_NAME_LEN   32
 
+#define HFI1_IPOIB_PSEUDO_LEN 20
 #define HFI1_IPOIB_ENCAP_LEN 4
 
 struct hfi1_ipoib_dev_priv;
@@ -119,6 +121,19 @@ struct hfi1_ipoib_rdma_netdev {
 }
 
 static inline void
+hfi1_ipoib_update_rx_netstats(struct hfi1_ipoib_dev_priv *priv,
+			      u64 packets,
+			      u64 bytes)
+{
+	struct pcpu_sw_netstats *netstats = this_cpu_ptr(priv->netstats);
+
+	u64_stats_update_begin(&netstats->syncp);
+	netstats->rx_packets += packets;
+	netstats->rx_bytes += bytes;
+	u64_stats_update_end(&netstats->syncp);
+}
+
+static inline void
 hfi1_ipoib_update_tx_netstats(struct hfi1_ipoib_dev_priv *priv,
 			      u64 packets,
 			      u64 bytes)
@@ -142,6 +157,9 @@ int hfi1_ipoib_send_dma(struct net_device *dev,
 void hfi1_ipoib_napi_tx_enable(struct net_device *dev);
 void hfi1_ipoib_napi_tx_disable(struct net_device *dev);
 
+struct sk_buff *hfi1_ipoib_prepare_skb(struct hfi1_netdev_rxq *rxq,
+				       int size, void *data);
+
 int hfi1_ipoib_rn_get_params(struct ib_device *device,
 			     u8 port_num,
 			     enum rdma_netdev_t type,
diff --git a/drivers/infiniband/hw/hfi1/ipoib_rx.c b/drivers/infiniband/hw/hfi1/ipoib_rx.c
new file mode 100644
index 0000000..2485663
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/ipoib_rx.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ *
+ */
+
+#include "netdev.h"
+#include "ipoib.h"
+
+#define HFI1_IPOIB_SKB_PAD ((NET_SKB_PAD) + (NET_IP_ALIGN))
+
+static void copy_ipoib_buf(struct sk_buff *skb, void *data, int size)
+{
+	void *dst_data;
+
+	skb_checksum_none_assert(skb);
+	skb->protocol = *((__be16 *)data);
+
+	dst_data = skb_put(skb, size);
+	memcpy(dst_data, data, size);
+	skb->mac_header = HFI1_IPOIB_PSEUDO_LEN;
+	skb_pull(skb, HFI1_IPOIB_ENCAP_LEN);
+}
+
+static struct sk_buff *prepare_frag_skb(struct napi_struct *napi, int size)
+{
+	struct sk_buff *skb;
+	int skb_size = SKB_DATA_ALIGN(size + HFI1_IPOIB_SKB_PAD);
+	void *frag;
+
+	skb_size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	skb_size = SKB_DATA_ALIGN(skb_size);
+	frag = napi_alloc_frag(skb_size);
+
+	if (unlikely(!frag))
+		return napi_alloc_skb(napi, size);
+
+	skb = build_skb(frag, skb_size);
+
+	if (unlikely(!skb)) {
+		skb_free_frag(frag);
+		return NULL;
+	}
+
+	skb_reserve(skb, HFI1_IPOIB_SKB_PAD);
+	return skb;
+}
+
+struct sk_buff *hfi1_ipoib_prepare_skb(struct hfi1_netdev_rxq *rxq,
+				       int size, void *data)
+{
+	struct napi_struct *napi = &rxq->napi;
+	int skb_size = size + HFI1_IPOIB_ENCAP_LEN;
+	struct sk_buff *skb;
+
+	/*
+	 * For smaller(4k + skb overhead) allocations we will go using
+	 * napi cache. Otherwise we will try to use napi frag cache.
+	 */
+	if (size <= SKB_WITH_OVERHEAD(PAGE_SIZE))
+		skb = napi_alloc_skb(napi, skb_size);
+	else
+		skb = prepare_frag_skb(napi, skb_size);
+
+	if (unlikely(!skb))
+		return NULL;
+
+	copy_ipoib_buf(skb, data, size);
+
+	return skb;
+}
diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
new file mode 100644
index 0000000..8992dfe
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ *
+ */
+
+#ifndef HFI1_NETDEV_H
+#define HFI1_NETDEV_H
+
+#include "hfi.h"
+
+#include <linux/netdevice.h>
+#include <linux/xarray.h>
+
+/**
+ * struct hfi1_netdev_rxq - Receive Queue for HFI
+ * dummy netdev. Both IPoIB and VNIC netdevices will be working on
+ * top of this device.
+ * @napi: napi object
+ * @priv: ptr to netdev_priv
+ * @rcd:  ptr to receive context data
+ */
+struct hfi1_netdev_rxq {
+	struct napi_struct napi;
+	struct hfi1_netdev_priv *priv;
+	struct hfi1_ctxtdata *rcd;
+};
+
+/*
+ * Number of netdev contexts used. Ensure it is less than or equal to
+ * max queues supported by VNIC (HFI1_VNIC_MAX_QUEUE).
+ */
+#define HFI1_MAX_NETDEV_CTXTS   8
+
+/* Number of NETDEV RSM entries */
+#define NUM_NETDEV_MAP_ENTRIES HFI1_MAX_NETDEV_CTXTS
+
+/**
+ * struct hfi1_netdev_priv: data required to setup and run HFI netdev.
+ * @dd:		hfi1_devdata
+ * @rxq:	pointer to dummy netdev receive queues.
+ * @num_rx_q:	number of receive queues
+ * @rmt_index:	first free index in RMT Array
+ * @msix_start: first free MSI-X interrupt vector.
+ * @dev_tbl:	netdev table for unique identifier VNIC and IPoIb VLANs.
+ * @enabled:	atomic counter of netdevs enabling receive queues.
+ *		When 0 NAPI will be disabled.
+ * @netdevs:	atomic counter of netdevs using dummy netdev.
+ *		When 0 receive queues will be freed.
+ */
+struct hfi1_netdev_priv {
+	struct hfi1_devdata *dd;
+	struct hfi1_netdev_rxq *rxq;
+	int num_rx_q;
+	int rmt_start;
+	struct xarray dev_tbl;
+	/* count of enabled napi polls */
+	atomic_t enabled;
+	/* count of netdevs on top */
+	atomic_t netdevs;
+};
+
+static inline
+struct hfi1_netdev_priv *hfi1_netdev_priv(struct net_device *dev)
+{
+	return (struct hfi1_netdev_priv *)&dev[1];
+}
+
+static inline
+int hfi1_netdev_ctxt_count(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	return priv->num_rx_q;
+}
+
+static inline
+struct hfi1_ctxtdata *hfi1_netdev_get_ctxt(struct hfi1_devdata *dd, int ctxt)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	return priv->rxq[ctxt].rcd;
+}
+
+int hfi1_netdev_add_data(struct hfi1_devdata *dd, int id, void *data);
+void *hfi1_netdev_remove_data(struct hfi1_devdata *dd, int id);
+void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id);
+void *hfi1_netdev_get_first_data(struct hfi1_devdata *dd, int *start_id);
+
+#endif /* HFI1_NETDEV_H */
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
new file mode 100644
index 0000000..19597e0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ *
+ */
+
+/*
+ * This file contains HFI1 support for netdev RX functionality
+ */
+
+#include "sdma.h"
+#include "verbs.h"
+#include "netdev.h"
+#include "hfi.h"
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <rdma/ib_verbs.h>
+
+/**
+ * hfi1_netdev_add_data - Registers data with unique identifier
+ * to be requested later this is needed for VNIC and IPoIB VLANs
+ * implementations.
+ * This call is protected by mutex idr_lock.
+ *
+ * @dd: hfi1 dev data
+ * @id: requested integer id up to INT_MAX
+ * @data: data to be associated with index
+ */
+int hfi1_netdev_add_data(struct hfi1_devdata *dd, int id, void *data)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	return xa_insert(&priv->dev_tbl, id, data, GFP_NOWAIT);
+}
+
+/**
+ * hfi1_netdev_remove_data - Removes data with previously given id.
+ * Returns the reference to removed entry.
+ *
+ * @dd: hfi1 dev data
+ * @id: requested integer id up to INT_MAX
+ */
+void *hfi1_netdev_remove_data(struct hfi1_devdata *dd, int id)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	return xa_erase(&priv->dev_tbl, id);
+}
+
+/**
+ * hfi1_netdev_get_data - Gets data with given id
+ *
+ * @dd: hfi1 dev data
+ * @id: requested integer id up to INT_MAX
+ */
+void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	return xa_load(&priv->dev_tbl, id);
+}
+
+/**
+ * hfi1_netdev_get_first_dat - Gets first entry with greater or equal id.
+ *
+ * @dd: hfi1 dev data
+ * @id: requested integer id up to INT_MAX
+ */
+void *hfi1_netdev_get_first_data(struct hfi1_devdata *dd, int *start_id)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	return xa_find(&priv->dev_tbl, (unsigned long *)start_id, ULONG_MAX,
+		       XA_PRESENT);
+}

