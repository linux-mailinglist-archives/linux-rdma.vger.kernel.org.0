Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F84C1579FF
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgBJNTg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:19:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:5417 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729838AbgBJNTf (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:19:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:19:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="312746761"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2020 05:19:34 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADJXHZ008100;
        Mon, 10 Feb 2020 06:19:33 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADJQRe088408;
        Mon, 10 Feb 2020 08:19:26 -0500
Subject: [PATCH for-next 11/16] IB/hfi1: Add rx functions for dummy netdev
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>
Date:   Mon, 10 Feb 2020 08:19:26 -0500
Message-ID: <20200210131925.87776.58068.stgit@awfm-01.aw.intel.com>
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

This patch adds the rx functions for the dummy netdev:
- Functions to allocate/free the dummy netdev.
- Functions to allocate/free receiving contexts for the netdev.
- Functions to initialize/de-initialize the receive queue.
- Functions to enable/disable the receive queue.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/ipoib.h      |    3 
 drivers/infiniband/hw/hfi1/ipoib_main.c |   30 ++-
 drivers/infiniband/hw/hfi1/ipoib_rx.c   |   16 +
 drivers/infiniband/hw/hfi1/netdev.h     |    6 +
 drivers/infiniband/hw/hfi1/netdev_rx.c  |  361 +++++++++++++++++++++++++++++++
 5 files changed, 414 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index ca00f6c..185c9b0 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -154,6 +154,9 @@ int hfi1_ipoib_send_dma(struct net_device *dev,
 int hfi1_ipoib_txreq_init(struct hfi1_ipoib_dev_priv *priv);
 void hfi1_ipoib_txreq_deinit(struct hfi1_ipoib_dev_priv *priv);
 
+int hfi1_ipoib_rxq_init(struct net_device *dev);
+void hfi1_ipoib_rxq_deinit(struct net_device *dev);
+
 void hfi1_ipoib_napi_tx_enable(struct net_device *dev);
 void hfi1_ipoib_napi_tx_disable(struct net_device *dev);
 
diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
index 304a5ac..014351e 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_main.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -19,16 +19,31 @@ static u32 qpn_from_mac(u8 *mac_arr)
 static int hfi1_ipoib_dev_init(struct net_device *dev)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+	int ret;
 
 	priv->netstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
 
-	return priv->netdev_ops->ndo_init(dev);
+	ret = priv->netdev_ops->ndo_init(dev);
+	if (ret)
+		return ret;
+
+	ret = hfi1_netdev_add_data(priv->dd,
+				   qpn_from_mac(priv->netdev->dev_addr),
+				   dev);
+	if (ret < 0) {
+		priv->netdev_ops->ndo_uninit(dev);
+		return ret;
+	}
+
+	return 0;
 }
 
 static void hfi1_ipoib_dev_uninit(struct net_device *dev)
 {
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 
+	hfi1_netdev_remove_data(priv->dd, qpn_from_mac(priv->netdev->dev_addr));
+
 	priv->netdev_ops->ndo_uninit(dev);
 }
 
@@ -55,6 +70,7 @@ static int hfi1_ipoib_dev_open(struct net_device *dev)
 		priv->qp = qp;
 		rcu_read_unlock();
 
+		hfi1_netdev_enable_queues(priv->dd);
 		hfi1_ipoib_napi_tx_enable(dev);
 	}
 
@@ -69,6 +85,7 @@ static int hfi1_ipoib_dev_stop(struct net_device *dev)
 		return 0;
 
 	hfi1_ipoib_napi_tx_disable(dev);
+	hfi1_netdev_disable_queues(priv->dd);
 
 	rvt_put_qp(priv->qp);
 	priv->qp = NULL;
@@ -195,6 +212,7 @@ static void hfi1_ipoib_netdev_dtor(struct net_device *dev)
 	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
 
 	hfi1_ipoib_txreq_deinit(priv);
+	hfi1_ipoib_rxq_deinit(priv->netdev);
 
 	free_percpu(priv->netstats);
 }
@@ -252,6 +270,13 @@ static int hfi1_ipoib_setup_rn(struct ib_device *device,
 		return rc;
 	}
 
+	rc = hfi1_ipoib_rxq_init(netdev);
+	if (rc) {
+		dd_dev_err(dd, "IPoIB netdev RX init - failed(%d)\n", rc);
+		hfi1_ipoib_free_rdma_netdev(netdev);
+		return rc;
+	}
+
 	netdev->priv_destructor = hfi1_ipoib_netdev_dtor;
 	netdev->needs_free_netdev = true;
 
@@ -268,7 +293,7 @@ int hfi1_ipoib_rn_get_params(struct ib_device *device,
 	if (type != RDMA_NETDEV_IPOIB)
 		return -EOPNOTSUPP;
 
-	if (!HFI1_CAP_IS_KSET(AIP))
+	if (!HFI1_CAP_IS_KSET(AIP) || !dd->num_netdev_contexts)
 		return -EOPNOTSUPP;
 
 	if (!port_num || port_num > dd->num_pports)
@@ -276,6 +301,7 @@ int hfi1_ipoib_rn_get_params(struct ib_device *device,
 
 	params->sizeof_priv = sizeof(struct hfi1_ipoib_rdma_netdev);
 	params->txqs = dd->num_sdma;
+	params->rxqs = dd->num_netdev_contexts;
 	params->param = NULL;
 	params->initialize_rdma_netdev = hfi1_ipoib_setup_rn;
 
diff --git a/drivers/infiniband/hw/hfi1/ipoib_rx.c b/drivers/infiniband/hw/hfi1/ipoib_rx.c
index 2485663..606ac69 100644
--- a/drivers/infiniband/hw/hfi1/ipoib_rx.c
+++ b/drivers/infiniband/hw/hfi1/ipoib_rx.c
@@ -69,3 +69,19 @@ struct sk_buff *hfi1_ipoib_prepare_skb(struct hfi1_netdev_rxq *rxq,
 
 	return skb;
 }
+
+int hfi1_ipoib_rxq_init(struct net_device *netdev)
+{
+	struct hfi1_ipoib_dev_priv *ipoib_priv = hfi1_ipoib_priv(netdev);
+	struct hfi1_devdata *dd = ipoib_priv->dd;
+
+	return hfi1_netdev_rx_init(dd);
+}
+
+void hfi1_ipoib_rxq_deinit(struct net_device *netdev)
+{
+	struct hfi1_ipoib_dev_priv *ipoib_priv = hfi1_ipoib_priv(netdev);
+	struct hfi1_devdata *dd = ipoib_priv->dd;
+
+	hfi1_netdev_rx_destroy(dd);
+}
diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
index 6740ec3..edb936f 100644
--- a/drivers/infiniband/hw/hfi1/netdev.h
+++ b/drivers/infiniband/hw/hfi1/netdev.h
@@ -82,6 +82,12 @@ struct hfi1_ctxtdata *hfi1_netdev_get_ctxt(struct hfi1_devdata *dd, int ctxt)
 	return priv->rxq[ctxt].rcd;
 }
 
+void hfi1_netdev_enable_queues(struct hfi1_devdata *dd);
+void hfi1_netdev_disable_queues(struct hfi1_devdata *dd);
+int hfi1_netdev_rx_init(struct hfi1_devdata *dd);
+int hfi1_netdev_rx_destroy(struct hfi1_devdata *dd);
+int hfi1_netdev_alloc(struct hfi1_devdata *dd);
+void hfi1_netdev_free(struct hfi1_devdata *dd);
 int hfi1_netdev_add_data(struct hfi1_devdata *dd, int id, void *data);
 void *hfi1_netdev_remove_data(struct hfi1_devdata *dd, int id);
 void *hfi1_netdev_get_data(struct hfi1_devdata *dd, int id);
diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
index 19597e0..95e8c98 100644
--- a/drivers/infiniband/hw/hfi1/netdev_rx.c
+++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
@@ -17,6 +17,367 @@
 #include <linux/etherdevice.h>
 #include <rdma/ib_verbs.h>
 
+static int hfi1_netdev_setup_ctxt(struct hfi1_netdev_priv *priv,
+				  struct hfi1_ctxtdata *uctxt)
+{
+	unsigned int rcvctrl_ops;
+	struct hfi1_devdata *dd = priv->dd;
+	int ret;
+
+	uctxt->rhf_rcv_function_map = netdev_rhf_rcv_functions;
+	uctxt->do_interrupt = &handle_receive_interrupt_napi_sp;
+
+	/* Now allocate the RcvHdr queue and eager buffers. */
+	ret = hfi1_create_rcvhdrq(dd, uctxt);
+	if (ret)
+		goto done;
+
+	ret = hfi1_setup_eagerbufs(uctxt);
+	if (ret)
+		goto done;
+
+	clear_rcvhdrtail(uctxt);
+
+	rcvctrl_ops = HFI1_RCVCTRL_CTXT_DIS;
+	rcvctrl_ops |= HFI1_RCVCTRL_INTRAVAIL_DIS;
+
+	if (!HFI1_CAP_KGET_MASK(uctxt->flags, MULTI_PKT_EGR))
+		rcvctrl_ops |= HFI1_RCVCTRL_ONE_PKT_EGR_ENB;
+	if (HFI1_CAP_KGET_MASK(uctxt->flags, NODROP_EGR_FULL))
+		rcvctrl_ops |= HFI1_RCVCTRL_NO_EGR_DROP_ENB;
+	if (HFI1_CAP_KGET_MASK(uctxt->flags, NODROP_RHQ_FULL))
+		rcvctrl_ops |= HFI1_RCVCTRL_NO_RHQ_DROP_ENB;
+	if (HFI1_CAP_KGET_MASK(uctxt->flags, DMA_RTAIL))
+		rcvctrl_ops |= HFI1_RCVCTRL_TAILUPD_ENB;
+
+	hfi1_rcvctrl(uctxt->dd, rcvctrl_ops, uctxt);
+done:
+	return ret;
+}
+
+static int hfi1_netdev_allocate_ctxt(struct hfi1_devdata *dd,
+				     struct hfi1_ctxtdata **ctxt)
+{
+	struct hfi1_ctxtdata *uctxt;
+	int ret;
+
+	if (dd->flags & HFI1_FROZEN)
+		return -EIO;
+
+	ret = hfi1_create_ctxtdata(dd->pport, dd->node, &uctxt);
+	if (ret < 0) {
+		dd_dev_err(dd, "Unable to create ctxtdata, failing open\n");
+		return -ENOMEM;
+	}
+
+	uctxt->flags = HFI1_CAP_KGET(MULTI_PKT_EGR) |
+		HFI1_CAP_KGET(NODROP_RHQ_FULL) |
+		HFI1_CAP_KGET(NODROP_EGR_FULL) |
+		HFI1_CAP_KGET(DMA_RTAIL);
+	/* Netdev contexts are always NO_RDMA_RTAIL */
+	uctxt->fast_handler = handle_receive_interrupt_napi_fp;
+	uctxt->slow_handler = handle_receive_interrupt_napi_sp;
+	hfi1_set_seq_cnt(uctxt, 1);
+	uctxt->is_vnic = true;
+
+	hfi1_stats.sps_ctxts++;
+
+	dd_dev_info(dd, "created netdev context %d\n", uctxt->ctxt);
+	*ctxt = uctxt;
+
+	return 0;
+}
+
+static void hfi1_netdev_deallocate_ctxt(struct hfi1_devdata *dd,
+					struct hfi1_ctxtdata *uctxt)
+{
+	flush_wc();
+
+	/*
+	 * Disable receive context and interrupt available, reset all
+	 * RcvCtxtCtrl bits to default values.
+	 */
+	hfi1_rcvctrl(dd, HFI1_RCVCTRL_CTXT_DIS |
+		     HFI1_RCVCTRL_TIDFLOW_DIS |
+		     HFI1_RCVCTRL_INTRAVAIL_DIS |
+		     HFI1_RCVCTRL_ONE_PKT_EGR_DIS |
+		     HFI1_RCVCTRL_NO_RHQ_DROP_DIS |
+		     HFI1_RCVCTRL_NO_EGR_DROP_DIS, uctxt);
+
+	if (uctxt->msix_intr != CCE_NUM_MSIX_VECTORS)
+		msix_free_irq(dd, uctxt->msix_intr);
+
+	uctxt->msix_intr = CCE_NUM_MSIX_VECTORS;
+	uctxt->event_flags = 0;
+
+	hfi1_clear_tids(uctxt);
+	hfi1_clear_ctxt_pkey(dd, uctxt);
+
+	hfi1_stats.sps_ctxts--;
+
+	hfi1_free_ctxt(uctxt);
+}
+
+static int hfi1_netdev_allot_ctxt(struct hfi1_netdev_priv *priv,
+				  struct hfi1_ctxtdata **ctxt)
+{
+	int rc;
+	struct hfi1_devdata *dd = priv->dd;
+
+	rc = hfi1_netdev_allocate_ctxt(dd, ctxt);
+	if (rc) {
+		dd_dev_err(dd, "netdev ctxt alloc failed %d\n", rc);
+		return rc;
+	}
+
+	rc = hfi1_netdev_setup_ctxt(priv, *ctxt);
+	if (rc) {
+		dd_dev_err(dd, "netdev ctxt setup failed %d\n", rc);
+		hfi1_netdev_deallocate_ctxt(dd, *ctxt);
+		*ctxt = NULL;
+	}
+
+	return rc;
+}
+
+static int hfi1_netdev_rxq_init(struct net_device *dev)
+{
+	int i;
+	int rc;
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dev);
+	struct hfi1_devdata *dd = priv->dd;
+
+	priv->num_rx_q = dd->num_netdev_contexts;
+	priv->rxq = kcalloc_node(priv->num_rx_q, sizeof(struct hfi1_netdev_rxq),
+				 GFP_KERNEL, dd->node);
+
+	if (!priv->rxq) {
+		dd_dev_err(dd, "Unable to allocate netdev queue data\n");
+		return (-ENOMEM);
+	}
+
+	for (i = 0; i < priv->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+
+		rc = hfi1_netdev_allot_ctxt(priv, &rxq->rcd);
+		if (rc)
+			goto bail_context_irq_failure;
+
+		hfi1_rcd_get(rxq->rcd);
+		rxq->priv = priv;
+		rxq->rcd->napi = &rxq->napi;
+		dd_dev_info(dd, "Setting rcv queue %d napi to context %d\n",
+			    i, rxq->rcd->ctxt);
+		/*
+		 * Disable BUSY_POLL on this NAPI as this is not supported
+		 * right now.
+		 */
+		set_bit(NAPI_STATE_NO_BUSY_POLL, &rxq->napi.state);
+		netif_napi_add(dev, &rxq->napi, hfi1_netdev_rx_napi, 64);
+		rc = msix_netdev_request_rcd_irq(rxq->rcd);
+		if (rc)
+			goto bail_context_irq_failure;
+	}
+
+	return 0;
+
+bail_context_irq_failure:
+	dd_dev_err(dd, "Unable to allot receive context\n");
+	for (; i >= 0; i--) {
+		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+
+		if (rxq->rcd) {
+			hfi1_netdev_deallocate_ctxt(dd, rxq->rcd);
+			hfi1_rcd_put(rxq->rcd);
+			rxq->rcd = NULL;
+		}
+	}
+	kfree(priv->rxq);
+	priv->rxq = NULL;
+
+	return rc;
+}
+
+static void hfi1_netdev_rxq_deinit(struct net_device *dev)
+{
+	int i;
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dev);
+	struct hfi1_devdata *dd = priv->dd;
+
+	for (i = 0; i < priv->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+
+		netif_napi_del(&rxq->napi);
+		hfi1_netdev_deallocate_ctxt(dd, rxq->rcd);
+		hfi1_rcd_put(rxq->rcd);
+		rxq->rcd = NULL;
+	}
+
+	kfree(priv->rxq);
+	priv->rxq = NULL;
+	priv->num_rx_q = 0;
+}
+
+static void enable_queues(struct hfi1_netdev_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+
+		dd_dev_info(priv->dd, "enabling queue %d on context %d\n", i,
+			    rxq->rcd->ctxt);
+		napi_enable(&rxq->napi);
+		hfi1_rcvctrl(priv->dd,
+			     HFI1_RCVCTRL_CTXT_ENB | HFI1_RCVCTRL_INTRAVAIL_ENB,
+			     rxq->rcd);
+	}
+}
+
+static void disable_queues(struct hfi1_netdev_priv *priv)
+{
+	int i;
+
+	msix_vnic_synchronize_irq(priv->dd);
+
+	for (i = 0; i < priv->num_rx_q; i++) {
+		struct hfi1_netdev_rxq *rxq = &priv->rxq[i];
+
+		dd_dev_info(priv->dd, "disabling queue %d on context %d\n", i,
+			    rxq->rcd->ctxt);
+
+		/* wait for napi if it was scheduled */
+		hfi1_rcvctrl(priv->dd,
+			     HFI1_RCVCTRL_CTXT_DIS | HFI1_RCVCTRL_INTRAVAIL_DIS,
+			     rxq->rcd);
+		napi_synchronize(&rxq->napi);
+		napi_disable(&rxq->napi);
+	}
+}
+
+/**
+ * hfi1_netdev_rx_init - Incrememnts netdevs counter. When called first time,
+ * it allocates receive queue data and calls netif_napi_add
+ * for each queue.
+ *
+ * @dd: hfi1 dev data
+ */
+int hfi1_netdev_rx_init(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+	int res;
+
+	if (atomic_fetch_inc(&priv->netdevs))
+		return 0;
+
+	mutex_lock(&hfi1_mutex);
+	init_dummy_netdev(dd->dummy_netdev);
+	res = hfi1_netdev_rxq_init(dd->dummy_netdev);
+	mutex_unlock(&hfi1_mutex);
+	return res;
+}
+
+/**
+ * hfi1_netdev_rx_destroy - Decrements netdevs counter, when it reaches 0
+ * napi is deleted and receive queses memory is freed.
+ *
+ * @dd: hfi1 dev data
+ */
+int hfi1_netdev_rx_destroy(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv = hfi1_netdev_priv(dd->dummy_netdev);
+
+	/* destroy the RX queues only if it is the last netdev going away */
+	if (atomic_fetch_add_unless(&priv->netdevs, -1, 0) == 1) {
+		mutex_lock(&hfi1_mutex);
+		hfi1_netdev_rxq_deinit(dd->dummy_netdev);
+		mutex_unlock(&hfi1_mutex);
+	}
+
+	return 0;
+}
+
+/**
+ * hfi1_netdev_alloc - Allocates netdev and private data. It is required
+ * because RMT index and MSI-X interrupt can be set only
+ * during driver initialization.
+ *
+ * @dd: hfi1 dev data
+ */
+int hfi1_netdev_alloc(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv;
+	const int netdev_size = sizeof(*dd->dummy_netdev) +
+		sizeof(struct hfi1_netdev_priv);
+
+	dd_dev_info(dd, "allocating netdev size %d\n", netdev_size);
+	dd->dummy_netdev = kcalloc_node(1, netdev_size, GFP_KERNEL, dd->node);
+
+	if (!dd->dummy_netdev)
+		return -ENOMEM;
+
+	priv = hfi1_netdev_priv(dd->dummy_netdev);
+	priv->dd = dd;
+	xa_init(&priv->dev_tbl);
+	atomic_set(&priv->enabled, 0);
+	atomic_set(&priv->netdevs, 0);
+
+	return 0;
+}
+
+void hfi1_netdev_free(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv;
+
+	if (dd->dummy_netdev) {
+		priv = hfi1_netdev_priv(dd->dummy_netdev);
+		dd_dev_info(dd, "hfi1 netdev freed\n");
+		kfree(dd->dummy_netdev);
+		dd->dummy_netdev = NULL;
+	}
+}
+
+/**
+ * hfi1_netdev_enable_queues - This is napi enable function.
+ * It enables napi objects associated with queues.
+ * When at least one device has called it it increments atomic counter.
+ * Disable function decrements counter and when it is 0,
+ * calls napi_disable for every queue.
+ *
+ * @dd: hfi1 dev data
+ */
+void hfi1_netdev_enable_queues(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv;
+
+	if (!dd->dummy_netdev)
+		return;
+
+	priv = hfi1_netdev_priv(dd->dummy_netdev);
+	if (atomic_fetch_inc(&priv->enabled))
+		return;
+
+	mutex_lock(&hfi1_mutex);
+	enable_queues(priv);
+	mutex_unlock(&hfi1_mutex);
+}
+
+void hfi1_netdev_disable_queues(struct hfi1_devdata *dd)
+{
+	struct hfi1_netdev_priv *priv;
+
+	if (!dd->dummy_netdev)
+		return;
+
+	priv = hfi1_netdev_priv(dd->dummy_netdev);
+	if (atomic_dec_if_positive(&priv->enabled))
+		return;
+
+	mutex_lock(&hfi1_mutex);
+	disable_queues(priv);
+	mutex_unlock(&hfi1_mutex);
+}
+
 /**
  * hfi1_netdev_add_data - Registers data with unique identifier
  * to be requested later this is needed for VNIC and IPoIB VLANs

