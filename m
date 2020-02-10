Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D28DE1579E7
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgBJNS7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 08:18:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:31793 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731063AbgBJNS7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 08:18:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 05:18:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="280633743"
Received: from sedona.ch.intel.com ([10.2.136.157])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2020 05:18:58 -0800
Received: from awfm-01.aw.intel.com (awfm-01.aw.intel.com [10.228.212.213])
        by sedona.ch.intel.com (8.14.3/8.14.3/Standard MailSET/Hub) with ESMTP id 01ADIwI4008042;
        Mon, 10 Feb 2020 06:18:58 -0700
Received: from awfm-01.aw.intel.com (localhost [127.0.0.1])
        by awfm-01.aw.intel.com (8.14.7/8.14.7) with ESMTP id 01ADIu72088356;
        Mon, 10 Feb 2020 08:18:56 -0500
Subject: [PATCH for-next 08/16] IB/hfi1: Rename num_vnic_contexts as
 num_netdev_contexts
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
To:     jgg@ziepe.ca, dledford@redhat.com
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>,
        Dennis Dalessandro <dennis.alessandro@intel.com>,
        linux-rdma@vger.kernel.org, Kaike Wan <kaike.wan@intel.com>,
        Sadanand Warrier <sadanand.warrier@intel.com>
Date:   Mon, 10 Feb 2020 08:18:56 -0500
Message-ID: <20200210131856.87776.86479.stgit@awfm-01.aw.intel.com>
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

Rename num_vnic_contexts as num_ndetdev_contexts since VNIC and ipoib
will share the same set of receive contexts.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Dennis Dalessandro <dennis.alessandro@intel.com>
Signed-off-by: Sadanand Warrier <sadanand.warrier@intel.com>
Signed-off-by: Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
---
 drivers/infiniband/hw/hfi1/chip.c      |   24 ++++++++++++------------
 drivers/infiniband/hw/hfi1/hfi.h       |    4 ++--
 drivers/infiniband/hw/hfi1/msix.c      |    4 ++--
 drivers/infiniband/hw/hfi1/vnic_main.c |    8 ++++----
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/chip.c b/drivers/infiniband/hw/hfi1/chip.c
index be1fb29..07eec35 100644
--- a/drivers/infiniband/hw/hfi1/chip.c
+++ b/drivers/infiniband/hw/hfi1/chip.c
@@ -13347,12 +13347,12 @@ static int set_up_interrupts(struct hfi1_devdata *dd)
  *                             in array of contexts
  *	freectxts  - number of free user contexts
  *	num_send_contexts - number of PIO send contexts being used
- *	num_vnic_contexts - number of contexts reserved for VNIC
+ *	num_netdev_contexts - number of contexts reserved for netdev
  */
 static int set_up_context_variables(struct hfi1_devdata *dd)
 {
 	unsigned long num_kernel_contexts;
-	u16 num_vnic_contexts = HFI1_NUM_VNIC_CTXT;
+	u16 num_netdev_contexts = HFI1_NUM_VNIC_CTXT;
 	int total_contexts;
 	int ret;
 	unsigned ngroups;
@@ -13391,11 +13391,11 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 	}
 
 	/* Accommodate VNIC contexts if possible */
-	if ((num_kernel_contexts + num_vnic_contexts) > rcv_contexts) {
+	if ((num_kernel_contexts + num_netdev_contexts) > rcv_contexts) {
 		dd_dev_err(dd, "No receive contexts available for VNIC\n");
-		num_vnic_contexts = 0;
+		num_netdev_contexts = 0;
 	}
-	total_contexts = num_kernel_contexts + num_vnic_contexts;
+	total_contexts = num_kernel_contexts + num_netdev_contexts;
 
 	/*
 	 * User contexts:
@@ -13422,15 +13422,15 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 	 * The RMT entries are currently allocated as shown below:
 	 * 1. QOS (0 to 128 entries);
 	 * 2. FECN (num_kernel_context - 1 + num_user_contexts +
-	 *    num_vnic_contexts);
-	 * 3. VNIC (num_vnic_contexts).
-	 * It should be noted that FECN oversubscribe num_vnic_contexts
-	 * entries of RMT because both VNIC and PSM could allocate any receive
+	 *    num_netdev_contexts);
+	 * 3. netdev (num_netdev_contexts).
+	 * It should be noted that FECN oversubscribe num_netdev_contexts
+	 * entries of RMT because both netdev and PSM could allocate any receive
 	 * context between dd->first_dyn_alloc_text and dd->num_rcv_contexts,
 	 * and PSM FECN must reserve an RMT entry for each possible PSM receive
 	 * context.
 	 */
-	rmt_count = qos_rmt_entries(dd, NULL, NULL) + (num_vnic_contexts * 2);
+	rmt_count = qos_rmt_entries(dd, NULL, NULL) + (num_netdev_contexts * 2);
 	if (HFI1_CAP_IS_KSET(TID_RDMA))
 		rmt_count += num_kernel_contexts - 1;
 	if (rmt_count + n_usr_ctxts > NUM_MAP_ENTRIES) {
@@ -13449,7 +13449,7 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 	dd->num_rcv_contexts = total_contexts;
 	dd->n_krcv_queues = num_kernel_contexts;
 	dd->first_dyn_alloc_ctxt = num_kernel_contexts;
-	dd->num_vnic_contexts = num_vnic_contexts;
+	dd->num_netdev_contexts = num_netdev_contexts;
 	dd->num_user_contexts = n_usr_ctxts;
 	dd->freectxts = n_usr_ctxts;
 	dd_dev_info(dd,
@@ -13457,7 +13457,7 @@ static int set_up_context_variables(struct hfi1_devdata *dd)
 		    rcv_contexts,
 		    (int)dd->num_rcv_contexts,
 		    (int)dd->n_krcv_queues,
-		    dd->num_vnic_contexts,
+		    dd->num_netdev_contexts,
 		    dd->num_user_contexts);
 
 	/*
diff --git a/drivers/infiniband/hw/hfi1/hfi.h b/drivers/infiniband/hw/hfi1/hfi.h
index 5a7fa5a..2ff3904 100644
--- a/drivers/infiniband/hw/hfi1/hfi.h
+++ b/drivers/infiniband/hw/hfi1/hfi.h
@@ -1167,8 +1167,8 @@ struct hfi1_devdata {
 	u64 z_send_schedule;
 
 	u64 __percpu *send_schedule;
-	/* number of reserved contexts for VNIC usage */
-	u16 num_vnic_contexts;
+	/* number of reserved contexts for netdev usage */
+	u16 num_netdev_contexts;
 	/* number of receive contexts in use by the driver */
 	u32 num_rcv_contexts;
 	/* number of pio send contexts in use by the driver */
diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index db82db4..7574f2b 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 /*
- * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2018 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -69,7 +69,7 @@ int msix_initialize(struct hfi1_devdata *dd)
 	 *	one for each VNIC context
 	 *      ...any new IRQs should be added here.
 	 */
-	total = 1 + dd->num_sdma + dd->n_krcv_queues + dd->num_vnic_contexts;
+	total = 1 + dd->num_sdma + dd->n_krcv_queues + dd->num_netdev_contexts;
 
 	if (total >= CCE_NUM_MSIX_VECTORS)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/hfi1/vnic_main.c b/drivers/infiniband/hw/hfi1/vnic_main.c
index 6b14581..db7624c 100644
--- a/drivers/infiniband/hw/hfi1/vnic_main.c
+++ b/drivers/infiniband/hw/hfi1/vnic_main.c
@@ -1,5 +1,5 @@
 /*
- * Copyright(c) 2017 - 2018 Intel Corporation.
+ * Copyright(c) 2017 - 2020 Intel Corporation.
  *
  * This file is provided under a dual BSD/GPLv2 license.  When using or
  * redistributing this file, you may do so under either license.
@@ -804,7 +804,7 @@ struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
 	struct rdma_netdev *rn;
 	int i, size, rc;
 
-	if (!dd->num_vnic_contexts)
+	if (!dd->num_netdev_contexts)
 		return ERR_PTR(-ENOMEM);
 
 	if (!port_num || (port_num > dd->num_pports))
@@ -815,7 +815,7 @@ struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
 
 	size = sizeof(struct opa_vnic_rdma_netdev) + sizeof(*vinfo);
 	netdev = alloc_netdev_mqs(size, name, name_assign_type, setup,
-				  dd->num_sdma, dd->num_vnic_contexts);
+				  dd->num_sdma, dd->num_netdev_contexts);
 	if (!netdev)
 		return ERR_PTR(-ENOMEM);
 
@@ -823,7 +823,7 @@ struct net_device *hfi1_vnic_alloc_rn(struct ib_device *device,
 	vinfo = opa_vnic_dev_priv(netdev);
 	vinfo->dd = dd;
 	vinfo->num_tx_q = dd->num_sdma;
-	vinfo->num_rx_q = dd->num_vnic_contexts;
+	vinfo->num_rx_q = dd->num_netdev_contexts;
 	vinfo->netdev = netdev;
 	rn->free_rdma_netdev = hfi1_vnic_free_rn;
 	rn->set_id = hfi1_vnic_set_vesw_id;

