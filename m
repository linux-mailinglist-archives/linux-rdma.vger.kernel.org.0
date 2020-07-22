Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96A622999A
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGVN4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 09:56:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39370 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732429AbgGVN4f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 09:56:35 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with SMTP; 22 Jul 2020 16:56:30 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06MDuTPn026773;
        Wed, 22 Jul 2020 16:56:30 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     sagi@grimberg.me, yaminf@mellanox.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, leon@kernel.org, bvanassche@acm.org
Cc:     israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 2/3] IB/isert: use new shared CQ mechanism
Date:   Wed, 22 Jul 2020 16:56:28 +0300
Message-Id: <20200722135629.49467-2-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722135629.49467-1-maxg@mellanox.com>
References: <20200722135629.49467-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

Has the driver use shared CQs provided by the rdma core driver.
Because this provides similar functionality to iser_comp it has been
removed. Now there is no reason to allocate very large CQs when the driver
is loaded while gaining the advantage of shared CQs. Previously when a
single connection was opened a CQ was opened for every core with enough
space for eight connections, this is a very large overhead that in most
cases will not be utilized.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 169 ++++++--------------------------
 drivers/infiniband/ulp/isert/ib_isert.h |  18 +---
 2 files changed, 34 insertions(+), 153 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index b7df38e..4e9307b 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -24,13 +24,6 @@
 
 #include "ib_isert.h"
 
-#define	ISERT_MAX_CONN		8
-#define ISER_MAX_RX_CQ_LEN	(ISERT_QP_MAX_RECV_DTOS * ISERT_MAX_CONN)
-#define ISER_MAX_TX_CQ_LEN \
-	((ISERT_QP_MAX_REQ_DTOS + ISCSI_DEF_XMIT_CMDS_MAX) * ISERT_MAX_CONN)
-#define ISER_MAX_CQ_LEN		(ISER_MAX_RX_CQ_LEN + ISER_MAX_TX_CQ_LEN + \
-				 ISERT_MAX_CONN)
-
 static int isert_debug_level;
 module_param_named(debug_level, isert_debug_level, int, 0644);
 MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0 (default:0)");
@@ -82,50 +75,29 @@
 	}
 }
 
-static struct isert_comp *
-isert_comp_get(struct isert_conn *isert_conn)
-{
-	struct isert_device *device = isert_conn->device;
-	struct isert_comp *comp;
-	int i, min = 0;
-
-	mutex_lock(&device_list_mutex);
-	for (i = 0; i < device->comps_used; i++)
-		if (device->comps[i].active_qps <
-		    device->comps[min].active_qps)
-			min = i;
-	comp = &device->comps[min];
-	comp->active_qps++;
-	mutex_unlock(&device_list_mutex);
-
-	isert_info("conn %p, using comp %p min_index: %d\n",
-		   isert_conn, comp, min);
-
-	return comp;
-}
-
-static void
-isert_comp_put(struct isert_comp *comp)
-{
-	mutex_lock(&device_list_mutex);
-	comp->active_qps--;
-	mutex_unlock(&device_list_mutex);
-}
-
 static struct ib_qp *
 isert_create_qp(struct isert_conn *isert_conn,
-		struct isert_comp *comp,
 		struct rdma_cm_id *cma_id)
 {
+	u32 cq_size = ISERT_QP_MAX_REQ_DTOS + ISERT_QP_MAX_RECV_DTOS + 2;
 	struct isert_device *device = isert_conn->device;
+	struct ib_device *ib_dev = device->ib_device;
 	struct ib_qp_init_attr attr;
 	int ret;
 
+	isert_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1, IB_POLL_WORKQUEUE);
+	if (IS_ERR(isert_conn->cq)) {
+		isert_err("Unable to allocate cq\n");
+		ret = PTR_ERR(isert_conn->cq);
+		return ERR_PTR(ret);
+	}
+	isert_conn->cq_size = cq_size;
+
 	memset(&attr, 0, sizeof(struct ib_qp_init_attr));
 	attr.event_handler = isert_qp_event_callback;
 	attr.qp_context = isert_conn;
-	attr.send_cq = comp->cq;
-	attr.recv_cq = comp->cq;
+	attr.send_cq = isert_conn->cq;
+	attr.recv_cq = isert_conn->cq;
 	attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
 	attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
 	attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX;
@@ -139,6 +111,8 @@
 	ret = rdma_create_qp(cma_id, device->pd, &attr);
 	if (ret) {
 		isert_err("rdma_create_qp failed for cma_id %d\n", ret);
+		ib_cq_pool_put(isert_conn->cq, isert_conn->cq_size);
+
 		return ERR_PTR(ret);
 	}
 
@@ -146,25 +120,6 @@
 }
 
 static int
-isert_conn_setup_qp(struct isert_conn *isert_conn, struct rdma_cm_id *cma_id)
-{
-	struct isert_comp *comp;
-	int ret;
-
-	comp = isert_comp_get(isert_conn);
-	isert_conn->qp = isert_create_qp(isert_conn, comp, cma_id);
-	if (IS_ERR(isert_conn->qp)) {
-		ret = PTR_ERR(isert_conn->qp);
-		goto err;
-	}
-
-	return 0;
-err:
-	isert_comp_put(comp);
-	return ret;
-}
-
-static int
 isert_alloc_rx_descriptors(struct isert_conn *isert_conn)
 {
 	struct isert_device *device = isert_conn->device;
@@ -231,61 +186,6 @@
 	isert_conn->rx_descs = NULL;
 }
 
-static void
-isert_free_comps(struct isert_device *device)
-{
-	int i;
-
-	for (i = 0; i < device->comps_used; i++) {
-		struct isert_comp *comp = &device->comps[i];
-
-		if (comp->cq)
-			ib_free_cq(comp->cq);
-	}
-	kfree(device->comps);
-}
-
-static int
-isert_alloc_comps(struct isert_device *device)
-{
-	int i, max_cqe, ret = 0;
-
-	device->comps_used = min(ISERT_MAX_CQ, min_t(int, num_online_cpus(),
-				 device->ib_device->num_comp_vectors));
-
-	isert_info("Using %d CQs, %s supports %d vectors support "
-		   "pi_capable %d\n",
-		   device->comps_used, dev_name(&device->ib_device->dev),
-		   device->ib_device->num_comp_vectors,
-		   device->pi_capable);
-
-	device->comps = kcalloc(device->comps_used, sizeof(struct isert_comp),
-				GFP_KERNEL);
-	if (!device->comps)
-		return -ENOMEM;
-
-	max_cqe = min(ISER_MAX_CQ_LEN, device->ib_device->attrs.max_cqe);
-
-	for (i = 0; i < device->comps_used; i++) {
-		struct isert_comp *comp = &device->comps[i];
-
-		comp->device = device;
-		comp->cq = ib_alloc_cq(device->ib_device, comp, max_cqe, i,
-				IB_POLL_WORKQUEUE);
-		if (IS_ERR(comp->cq)) {
-			isert_err("Unable to allocate cq\n");
-			ret = PTR_ERR(comp->cq);
-			comp->cq = NULL;
-			goto out_cq;
-		}
-	}
-
-	return 0;
-out_cq:
-	isert_free_comps(device);
-	return ret;
-}
-
 static int
 isert_create_device_ib_res(struct isert_device *device)
 {
@@ -296,16 +196,12 @@
 		  ib_dev->attrs.max_send_sge, ib_dev->attrs.max_recv_sge);
 	isert_dbg("devattr->max_sge_rd: %d\n", ib_dev->attrs.max_sge_rd);
 
-	ret = isert_alloc_comps(device);
-	if (ret)
-		goto out;
-
 	device->pd = ib_alloc_pd(ib_dev, 0);
 	if (IS_ERR(device->pd)) {
 		ret = PTR_ERR(device->pd);
 		isert_err("failed to allocate pd, device %p, ret=%d\n",
 			  device, ret);
-		goto out_cq;
+		return ret;
 	}
 
 	/* Check signature cap */
@@ -313,13 +209,6 @@
 			     IB_DEVICE_INTEGRITY_HANDOVER ? true : false;
 
 	return 0;
-
-out_cq:
-	isert_free_comps(device);
-out:
-	if (ret > 0)
-		ret = -EINVAL;
-	return ret;
 }
 
 static void
@@ -328,7 +217,6 @@
 	isert_info("device %p\n", device);
 
 	ib_dealloc_pd(device->pd);
-	isert_free_comps(device);
 }
 
 static void
@@ -490,6 +378,13 @@
 	}
 }
 
+static void
+isert_destroy_qp(struct isert_conn *isert_conn)
+{
+	ib_destroy_qp(isert_conn->qp);
+	ib_cq_pool_put(isert_conn->cq, isert_conn->cq_size);
+}
+
 static int
 isert_connect_request(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
 {
@@ -530,17 +425,19 @@
 
 	isert_set_nego_params(isert_conn, &event->param.conn);
 
-	ret = isert_conn_setup_qp(isert_conn, cma_id);
-	if (ret)
+	isert_conn->qp = isert_create_qp(isert_conn, cma_id);
+	if (IS_ERR(isert_conn->qp)) {
+		ret = PTR_ERR(isert_conn->qp);
 		goto out_conn_dev;
+	}
 
 	ret = isert_login_post_recv(isert_conn);
 	if (ret)
-		goto out_conn_dev;
+		goto out_destroy_qp;
 
 	ret = isert_rdma_accept(isert_conn);
 	if (ret)
-		goto out_conn_dev;
+		goto out_destroy_qp;
 
 	mutex_lock(&isert_np->mutex);
 	list_add_tail(&isert_conn->node, &isert_np->accepted);
@@ -548,6 +445,8 @@
 
 	return 0;
 
+out_destroy_qp:
+	isert_destroy_qp(isert_conn);
 out_conn_dev:
 	isert_device_put(device);
 out_rsp_dma_map:
@@ -572,12 +471,8 @@
 	    !isert_conn->dev_removed)
 		rdma_destroy_id(isert_conn->cm_id);
 
-	if (isert_conn->qp) {
-		struct isert_comp *comp = isert_conn->qp->recv_cq->cq_context;
-
-		isert_comp_put(comp);
-		ib_destroy_qp(isert_conn->qp);
-	}
+	if (isert_conn->qp)
+		isert_destroy_qp(isert_conn);
 
 	if (isert_conn->login_req_buf)
 		isert_free_login_buf(isert_conn);
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 3b296ba..efe755f 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -155,6 +155,8 @@ struct isert_conn {
 	struct iser_tx_desc	login_tx_desc;
 	struct rdma_cm_id	*cm_id;
 	struct ib_qp		*qp;
+	struct ib_cq		*cq;
+	u32			cq_size;
 	struct isert_device	*device;
 	struct mutex		mutex;
 	struct kref		kref;
@@ -165,22 +167,6 @@ struct isert_conn {
 	bool			dev_removed;
 };
 
-#define ISERT_MAX_CQ 64
-
-/**
- * struct isert_comp - iSER completion context
- *
- * @device:     pointer to device handle
- * @cq:         completion queue
- * @active_qps: Number of active QPs attached
- *              to completion context
- */
-struct isert_comp {
-	struct isert_device     *device;
-	struct ib_cq		*cq;
-	int                      active_qps;
-};
-
 struct isert_device {
 	bool			pi_capable;
 	int			refcount;
-- 
1.8.3.1

