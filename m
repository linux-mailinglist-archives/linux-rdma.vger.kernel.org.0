Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FBA1CDFF1
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgEKQGN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:06:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:4995 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730594AbgEKQGN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:06:13 -0400
IronPort-SDR: V2lfBvQVOb3KcqAISpQbUNCsKdfLdGUgSPbAtyVehr2jFp3NjK2eoAgIxgCP5A1vb6FZW+F5On
 b1xyxY+WI/OQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 09:05:57 -0700
IronPort-SDR: PMq0JK+Tuudxkr+3oyriRZFJOgnf+66aMu4ubegxat81QGD9WDU7PHSGK7tFfBQmh5NWUcVgGq
 WuFsrxX0LkhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,380,1583222400"; 
   d="scan'208";a="436745465"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga005.jf.intel.com with ESMTP; 11 May 2020 09:05:57 -0700
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 04BG5uZg061660;
        Mon, 11 May 2020 09:05:56 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 04BG5scu174071;
        Mon, 11 May 2020 12:05:54 -0400
Subject: [PATCH v3 for-next 03/16] IB/hfi1: Add the transmit side of a
 datagram ipoib RDMA netdev
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 11 May 2020 12:05:54 -0400
Message-ID: <20200511160554.173205.1369.stgit@awfm-01.aw.intel.com>
In-Reply-To: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
References: <20200511155337.173205.77558.stgit@awfm-01.aw.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Gary Leshner <Gary.S.Leshner@intel.com>

This implements the transmit side of the multiple transmit queue RDMA
netdev used to accelerate ipoib.  The receive side remains the ipoib
internal implementation.

The init/unint/open/stop netdev operations are saved off and called by the
versions within the hfi1 netdev in order to initialize the connected mode
resources present in ipoib thus allowing us to switch modes between
datagram and connected.

The datagram queue pair instantiated by the ipoib ulp is used by this
implementation for its queue pair number and to register with multicast.

The above queue pair is not used on transmit other than its qpn as the
verbs layer is skipped and packets are directly submitted to the sdma
engines.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/Makefile     |    1 
 drivers/infiniband/hw/hfi1/ipoib.h      |    5 +
 drivers/infiniband/hw/hfi1/ipoib_main.c |  283 +++++++++++++++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi1/ipoib_main.c

diff --git a/drivers/infiniband/hw/hfi1/Makefile b/drivers/infiniband/hw/hfi1/Makefile
index 09ef0b8..0b25713 100644
--- a/drivers/infiniband/hw/hfi1/Makefile
+++ b/drivers/infiniband/hw/hfi1/Makefile
@@ -22,6 +22,7 @@ hfi1-y := \
 	init.o \
 	intr.o \
 	iowait.o \
+	ipoib_main.o \
 	ipoib_tx.o \
 	mad.o \
 	mmu_rb.o \
diff --git a/drivers/infiniband/hw/hfi1/ipoib.h b/drivers/infiniband/hw/hfi1/ipoib.h
index 2b541ab..c2e63ca 100644
--- a/drivers/infiniband/hw/hfi1/ipoib.h
+++ b/drivers/infiniband/hw/hfi1/ipoib.h
@@ -142,4 +142,9 @@ int hfi1_ipoib_send_dma(struct net_device *dev,
 void hfi1_ipoib_napi_tx_enable(struct net_device *dev);
 void hfi1_ipoib_napi_tx_disable(struct net_device *dev);
 
+int hfi1_ipoib_rn_get_params(struct ib_device *device,
+			     u8 port_num,
+			     enum rdma_netdev_t type,
+			     struct rdma_netdev_alloc_params *params);
+
 #endif /* _IPOIB_H */
diff --git a/drivers/infiniband/hw/hfi1/ipoib_main.c b/drivers/infiniband/hw/hfi1/ipoib_main.c
new file mode 100644
index 0000000..304a5ac
--- /dev/null
+++ b/drivers/infiniband/hw/hfi1/ipoib_main.c
@@ -0,0 +1,283 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ *
+ */
+
+/*
+ * This file contains HFI1 support for ipoib functionality
+ */
+
+#include "ipoib.h"
+#include "hfi.h"
+
+static u32 qpn_from_mac(u8 *mac_arr)
+{
+	return (u32)mac_arr[1] << 16 | mac_arr[2] << 8 | mac_arr[3];
+}
+
+static int hfi1_ipoib_dev_init(struct net_device *dev)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+
+	priv->netstats = netdev_alloc_pcpu_stats(struct pcpu_sw_netstats);
+
+	return priv->netdev_ops->ndo_init(dev);
+}
+
+static void hfi1_ipoib_dev_uninit(struct net_device *dev)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+
+	priv->netdev_ops->ndo_uninit(dev);
+}
+
+static int hfi1_ipoib_dev_open(struct net_device *dev)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+	int ret;
+
+	ret = priv->netdev_ops->ndo_open(dev);
+	if (!ret) {
+		struct hfi1_ibport *ibp = to_iport(priv->device,
+						   priv->port_num);
+		struct rvt_qp *qp;
+		u32 qpn = qpn_from_mac(priv->netdev->dev_addr);
+
+		rcu_read_lock();
+		qp = rvt_lookup_qpn(ib_to_rvt(priv->device), &ibp->rvp, qpn);
+		if (!qp) {
+			rcu_read_unlock();
+			priv->netdev_ops->ndo_stop(dev);
+			return -EINVAL;
+		}
+		rvt_get_qp(qp);
+		priv->qp = qp;
+		rcu_read_unlock();
+
+		hfi1_ipoib_napi_tx_enable(dev);
+	}
+
+	return ret;
+}
+
+static int hfi1_ipoib_dev_stop(struct net_device *dev)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+
+	if (!priv->qp)
+		return 0;
+
+	hfi1_ipoib_napi_tx_disable(dev);
+
+	rvt_put_qp(priv->qp);
+	priv->qp = NULL;
+
+	return priv->netdev_ops->ndo_stop(dev);
+}
+
+static void hfi1_ipoib_dev_get_stats64(struct net_device *dev,
+				       struct rtnl_link_stats64 *storage)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+	u64 rx_packets = 0ull;
+	u64 rx_bytes = 0ull;
+	u64 tx_packets = 0ull;
+	u64 tx_bytes = 0ull;
+	int i;
+
+	netdev_stats_to_stats64(storage, &dev->stats);
+
+	for_each_possible_cpu(i) {
+		const struct pcpu_sw_netstats *stats;
+		unsigned int start;
+		u64 trx_packets;
+		u64 trx_bytes;
+		u64 ttx_packets;
+		u64 ttx_bytes;
+
+		stats = per_cpu_ptr(priv->netstats, i);
+		do {
+			start = u64_stats_fetch_begin_irq(&stats->syncp);
+			trx_packets = stats->rx_packets;
+			trx_bytes = stats->rx_bytes;
+			ttx_packets = stats->tx_packets;
+			ttx_bytes = stats->tx_bytes;
+		} while (u64_stats_fetch_retry_irq(&stats->syncp, start));
+
+		rx_packets += trx_packets;
+		rx_bytes += trx_bytes;
+		tx_packets += ttx_packets;
+		tx_bytes += ttx_bytes;
+	}
+
+	storage->rx_packets += rx_packets;
+	storage->rx_bytes += rx_bytes;
+	storage->tx_packets += tx_packets;
+	storage->tx_bytes += tx_bytes;
+}
+
+static const struct net_device_ops hfi1_ipoib_netdev_ops = {
+	.ndo_init         = hfi1_ipoib_dev_init,
+	.ndo_uninit       = hfi1_ipoib_dev_uninit,
+	.ndo_open         = hfi1_ipoib_dev_open,
+	.ndo_stop         = hfi1_ipoib_dev_stop,
+	.ndo_get_stats64  = hfi1_ipoib_dev_get_stats64,
+};
+
+static int hfi1_ipoib_send(struct net_device *dev,
+			   struct sk_buff *skb,
+			   struct ib_ah *address,
+			   u32 dqpn)
+{
+	return hfi1_ipoib_send_dma(dev, skb, address, dqpn);
+}
+
+static int hfi1_ipoib_mcast_attach(struct net_device *dev,
+				   struct ib_device *device,
+				   union ib_gid *mgid,
+				   u16 mlid,
+				   int set_qkey,
+				   u32 qkey)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+	u32 qpn = (u32)qpn_from_mac(priv->netdev->dev_addr);
+	struct hfi1_ibport *ibp = to_iport(priv->device, priv->port_num);
+	struct rvt_qp *qp;
+	int ret = -EINVAL;
+
+	rcu_read_lock();
+
+	qp = rvt_lookup_qpn(ib_to_rvt(priv->device), &ibp->rvp, qpn);
+	if (qp) {
+		rvt_get_qp(qp);
+		rcu_read_unlock();
+		if (set_qkey)
+			priv->qkey = qkey;
+
+		/* attach QP to multicast group */
+		ret = ib_attach_mcast(&qp->ibqp, mgid, mlid);
+		rvt_put_qp(qp);
+	} else {
+		rcu_read_unlock();
+	}
+
+	return ret;
+}
+
+static int hfi1_ipoib_mcast_detach(struct net_device *dev,
+				   struct ib_device *device,
+				   union ib_gid *mgid,
+				   u16 mlid)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+	u32 qpn = (u32)qpn_from_mac(priv->netdev->dev_addr);
+	struct hfi1_ibport *ibp = to_iport(priv->device, priv->port_num);
+	struct rvt_qp *qp;
+	int ret = -EINVAL;
+
+	rcu_read_lock();
+
+	qp = rvt_lookup_qpn(ib_to_rvt(priv->device), &ibp->rvp, qpn);
+	if (qp) {
+		rvt_get_qp(qp);
+		rcu_read_unlock();
+		ret = ib_detach_mcast(&qp->ibqp, mgid, mlid);
+		rvt_put_qp(qp);
+	} else {
+		rcu_read_unlock();
+	}
+	return ret;
+}
+
+static void hfi1_ipoib_netdev_dtor(struct net_device *dev)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+
+	hfi1_ipoib_txreq_deinit(priv);
+
+	free_percpu(priv->netstats);
+}
+
+static void hfi1_ipoib_free_rdma_netdev(struct net_device *dev)
+{
+	hfi1_ipoib_netdev_dtor(dev);
+	free_netdev(dev);
+}
+
+static void hfi1_ipoib_set_id(struct net_device *dev, int id)
+{
+	struct hfi1_ipoib_dev_priv *priv = hfi1_ipoib_priv(dev);
+
+	priv->pkey_index = (u16)id;
+	ib_query_pkey(priv->device,
+		      priv->port_num,
+		      priv->pkey_index,
+		      &priv->pkey);
+}
+
+static int hfi1_ipoib_setup_rn(struct ib_device *device,
+			       u8 port_num,
+			       struct net_device *netdev,
+			       void *param)
+{
+	struct hfi1_devdata *dd = dd_from_ibdev(device);
+	struct rdma_netdev *rn = netdev_priv(netdev);
+	struct hfi1_ipoib_dev_priv *priv;
+	int rc;
+
+	rn->send = hfi1_ipoib_send;
+	rn->attach_mcast = hfi1_ipoib_mcast_attach;
+	rn->detach_mcast = hfi1_ipoib_mcast_detach;
+	rn->set_id = hfi1_ipoib_set_id;
+	rn->hca = device;
+	rn->port_num = port_num;
+	rn->mtu = netdev->mtu;
+
+	priv = hfi1_ipoib_priv(netdev);
+	priv->dd = dd;
+	priv->netdev = netdev;
+	priv->device = device;
+	priv->port_num = port_num;
+	priv->netdev_ops = netdev->netdev_ops;
+
+	netdev->netdev_ops = &hfi1_ipoib_netdev_ops;
+
+	ib_query_pkey(device, port_num, priv->pkey_index, &priv->pkey);
+
+	rc = hfi1_ipoib_txreq_init(priv);
+	if (rc) {
+		dd_dev_err(dd, "IPoIB netdev TX init - failed(%d)\n", rc);
+		hfi1_ipoib_free_rdma_netdev(netdev);
+		return rc;
+	}
+
+	netdev->priv_destructor = hfi1_ipoib_netdev_dtor;
+	netdev->needs_free_netdev = true;
+
+	return 0;
+}
+
+int hfi1_ipoib_rn_get_params(struct ib_device *device,
+			     u8 port_num,
+			     enum rdma_netdev_t type,
+			     struct rdma_netdev_alloc_params *params)
+{
+	struct hfi1_devdata *dd = dd_from_ibdev(device);
+
+	if (type != RDMA_NETDEV_IPOIB)
+		return -EOPNOTSUPP;
+
+	if (!HFI1_CAP_IS_KSET(AIP))
+		return -EOPNOTSUPP;
+
+	if (!port_num || port_num > dd->num_pports)
+		return -EINVAL;
+
+	params->sizeof_priv = sizeof(struct hfi1_ipoib_rdma_netdev);
+	params->txqs = dd->num_sdma;
+	params->param = NULL;
+	params->initialize_rdma_netdev = hfi1_ipoib_setup_rn;
+
+	return 0;
+}

