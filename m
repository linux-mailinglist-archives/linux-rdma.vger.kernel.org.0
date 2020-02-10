Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D191579DE
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJNSm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:18:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:31776 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728931AbgBJNSl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:18:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:18:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="312746518"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by orsmga001.jf.intel.com with ESMTP; 10 Feb 2020 05:18:40 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADIdlT008033;
        Mon, 10 Feb 2020 06:18:39 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADIbBx088313;
        Mon, 10 Feb 2020 08:18:37 -0500
Subject: [PATCH for-next 05/16] IB/{rdmavt,
 hfi1}: Implement creation of accelerated UD QPs
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        Gary Leshner <Gary.S.Leshner@intel.com>,
        Kaike Wan <kaike.wan@intel.com>
Date:   Mon, 10 Feb 2020 08:18:37 -0500
Message-ID: <20200210131837.87776.21649.stgit@awfm-01.aw.intel.com>
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

From: Gary Leshner <Gary.S.Leshner@intel.com>

Adds capability to create a qpn to be recognized as an accelerated
UD QP for ipoib.

This is accomplished by reserving 0x81 in byte[0] of the qpn as the
prefix for these qp types and reserving qpns between 0x810000 and
0x81ffff.

The hfi1 capability mask already contained a flag for the VNIC netdev.
This has been renamed and extended to include both VNIC and ipoib.

The rvt code to allocate qps now recognizes this flag and sets 0x81
into byte[0] of the qpn.

The code to allocate qpns is modified to reset the qpn numbering when it
is detected that a value is located in byte[0] for a UD QP and it is a
qpn being requested for net dev use. If it is a regular UD QP then it is
allowable to have bits set in byte[0] of the qpn and provide the
previously normal behavior.

The code to free the qpn now checks for the AIP prefix value of 0x81 and
removes it from the qpn before being freed so that the lower 16 bit
number can be reused.

This patch requires minor changes in the IB core and ipoib to facilitate
the creation of accelerated UP QPs.

Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Gary Leshner <Gary.S.Leshner@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/verbs.c         |    2 +-
 drivers/infiniband/sw/rdmavt/qp.c          |   24 +++++++++++++++++++-----
 drivers/infiniband/ulp/ipoib/ipoib_verbs.c |    3 +++
 include/rdma/ib_verbs.h                    |    4 ++--
 include/rdma/opa_vnic.h                    |    4 ++--
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/verbs.c b/drivers/infiniband/hw/hfi1/verbs.c
index 2bddc28..8061e93 100644
--- a/drivers/infiniband/hw/hfi1/verbs.c
+++ b/drivers/infiniband/hw/hfi1/verbs.c
@@ -1340,7 +1340,7 @@ static void hfi1_fill_device_attr(struct hfi1_devdata *dd)
 			IB_DEVICE_SYS_IMAGE_GUID | IB_DEVICE_RC_RNR_NAK_GEN |
 			IB_DEVICE_PORT_ACTIVE_EVENT | IB_DEVICE_SRQ_RESIZE |
 			IB_DEVICE_MEM_MGT_EXTENSIONS |
-			IB_DEVICE_RDMA_NETDEV_OPA_VNIC;
+			IB_DEVICE_RDMA_NETDEV_OPA;
 	rdi->dparms.props.page_size_cap = PAGE_SIZE;
 	rdi->dparms.props.vendor_id = dd->oui1 << 16 | dd->oui2 << 8 | dd->oui3;
 	rdi->dparms.props.vendor_part_id = dd->pcidev->device;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 7858d49..b59729f 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2016 - 2019 Intel Corporation.
+ * Copyright(c) 2016 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -525,15 +525,18 @@ static inline unsigned mk_qpn(struct rvt_qpn_table *qpt,
  * @rdi: rvt device info structure
  * @qpt: queue pair number table pointer
  * @port_num: IB port number, 1 based, comes from core
+ * @exclude_prefix: prefix of special queue pair number being allocated
  *
  * Return: The queue pair number
  */
 static int alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
-		     enum ib_qp_type type, u8 port_num)
+		     enum ib_qp_type type, u8 port_num, u8 exclude_prefix)
 {
 	u32 i, offset, max_scan, qpn;
 	struct rvt_qpn_map *map;
 	u32 ret;
+	u32 max_qpn = exclude_prefix == RVT_AIP_QP_PREFIX ?
+		RVT_AIP_QPN_MAX : RVT_QPN_MAX;
 
 	if (rdi->driver_f.alloc_qpn)
 		return rdi->driver_f.alloc_qpn(rdi, qpt, type, port_num);
@@ -553,7 +556,7 @@ static int alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
 	}
 
 	qpn = qpt->last + qpt->incr;
-	if (qpn >= RVT_QPN_MAX)
+	if (qpn >= max_qpn)
 		qpn = qpt->incr | ((qpt->last & 1) ^ 1);
 	/* offset carries bit 0 */
 	offset = qpn & RVT_BITS_PER_PAGE_MASK;
@@ -987,6 +990,9 @@ static void rvt_free_qpn(struct rvt_qpn_table *qpt, u32 qpn)
 {
 	struct rvt_qpn_map *map;
 
+	if ((qpn & RVT_AIP_QP_PREFIX_MASK) == RVT_AIP_QP_BASE)
+		qpn &= RVT_AIP_QP_SUFFIX;
+
 	map = qpt->map + (qpn & RVT_QPN_MASK) / RVT_BITS_PER_PAGE;
 	if (map->page)
 		clear_bit(qpn & RVT_BITS_PER_PAGE_MASK, map->page);
@@ -1074,13 +1080,15 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	struct rvt_dev_info *rdi = ib_to_rvt(ibpd->device);
 	void *priv = NULL;
 	size_t sqsize;
+	u8 exclude_prefix = 0;
 
 	if (!rdi)
 		return ERR_PTR(-EINVAL);
 
 	if (init_attr->cap.max_send_sge > rdi->dparms.props.max_send_sge ||
 	    init_attr->cap.max_send_wr > rdi->dparms.props.max_qp_wr ||
-	    init_attr->create_flags)
+	    (init_attr->create_flags &&
+	     init_attr->create_flags != IB_QP_CREATE_NETDEV_USE))
 		return ERR_PTR(-EINVAL);
 
 	/* Check receive queue parameters if no SRQ is specified. */
@@ -1199,14 +1207,20 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 			goto bail_driver_priv;
 		}
 
+		if (init_attr->create_flags & IB_QP_CREATE_NETDEV_USE)
+			exclude_prefix = RVT_AIP_QP_PREFIX;
+
 		err = alloc_qpn(rdi, &rdi->qp_dev->qpn_table,
 				init_attr->qp_type,
-				init_attr->port_num);
+				init_attr->port_num,
+				exclude_prefix);
 		if (err < 0) {
 			ret = ERR_PTR(err);
 			goto bail_rq_wq;
 		}
 		qp->ibqp.qp_num = err;
+		if (init_attr->create_flags & IB_QP_CREATE_NETDEV_USE)
+			qp->ibqp.qp_num |= RVT_AIP_QP_BASE;
 		qp->port_num = init_attr->port_num;
 		rvt_init_qp(rdi, qp, init_attr->qp_type);
 		if (rdi->driver_f.qp_priv_init) {
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
index b69304d..587252f 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_verbs.c
@@ -206,6 +206,9 @@ int ipoib_transport_dev_init(struct net_device *dev, struct ib_device *ca)
 	if (priv->hca_caps & IB_DEVICE_MANAGED_FLOW_STEERING)
 		init_attr.create_flags |= IB_QP_CREATE_NETIF_QP;
 
+	if (priv->hca_caps & IB_DEVICE_RDMA_NETDEV_OPA)
+		init_attr.create_flags |= IB_QP_CREATE_NETDEV_USE;
+
 	priv->qp = ib_create_qp(priv->pd, &init_attr);
 	if (IS_ERR(priv->qp)) {
 		pr_warn("%s: failed to create QP\n", ca->name);
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9abe2c8..8b805ab3 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -305,7 +305,7 @@ enum ib_device_cap_flags {
 	IB_DEVICE_VIRTUAL_FUNCTION		= (1ULL << 33),
 	/* Deprecated. Please use IB_RAW_PACKET_CAP_SCATTER_FCS. */
 	IB_DEVICE_RAW_SCATTER_FCS		= (1ULL << 34),
-	IB_DEVICE_RDMA_NETDEV_OPA_VNIC		= (1ULL << 35),
+	IB_DEVICE_RDMA_NETDEV_OPA		= (1ULL << 35),
 	/* The device supports padding incoming writes to cacheline. */
 	IB_DEVICE_PCI_WRITE_END_PADDING		= (1ULL << 36),
 	IB_DEVICE_ALLOW_USER_UNREG		= (1ULL << 37),
@@ -1111,7 +1111,7 @@ enum ib_qp_create_flags {
 	IB_QP_CREATE_MANAGED_RECV               = 1 << 4,
 	IB_QP_CREATE_NETIF_QP			= 1 << 5,
 	IB_QP_CREATE_INTEGRITY_EN		= 1 << 6,
-	/* FREE					= 1 << 7, */
+	IB_QP_CREATE_NETDEV_USE			= 1 << 7,
 	IB_QP_CREATE_SCATTER_FCS		= 1 << 8,
 	IB_QP_CREATE_CVLAN_STRIPPING		= 1 << 9,
 	IB_QP_CREATE_SOURCE_QPN			= 1 << 10,
diff --git a/include/rdma/opa_vnic.h b/include/rdma/opa_vnic.h
index 0c07a70..02e6d28 100644
--- a/include/rdma/opa_vnic.h
+++ b/include/rdma/opa_vnic.h
@@ -1,7 +1,7 @@
 #ifndef _OPA_VNIC_H
 #define _OPA_VNIC_H
 /*
- * Copyright(c) 2017 Intel Corporation.
+ * Copyright(c) 2017 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -132,7 +132,7 @@ struct opa_vnic_stats {
 static inline bool rdma_cap_opa_vnic(struct ib_device *device)
 {
 	return !!(device->attrs.device_cap_flags &
-		  IB_DEVICE_RDMA_NETDEV_OPA_VNIC);
+		  IB_DEVICE_RDMA_NETDEV_OPA);
 }
 
 #endif /* _OPA_VNIC_H */

