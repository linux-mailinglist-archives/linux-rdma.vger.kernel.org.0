Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377C3229999
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jul 2020 15:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGVN4f (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jul 2020 09:56:35 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39369 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727867AbgGVN4e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jul 2020 09:56:34 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with SMTP; 22 Jul 2020 16:56:30 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06MDuTPm026773;
        Wed, 22 Jul 2020 16:56:29 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     sagi@grimberg.me, yaminf@mellanox.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, leon@kernel.org, bvanassche@acm.org
Cc:     israelr@mellanox.com, oren@mellanox.com, jgg@mellanox.com,
        idanb@mellanox.com, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/3] IB/iser: use new shared CQ mechanism
Date:   Wed, 22 Jul 2020 16:56:27 +0300
Message-Id: <20200722135629.49467-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
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
is loaded while gaining the advantage of shared CQs.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Acked-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.h |  23 ++-----
 drivers/infiniband/ulp/iser/iser_verbs.c | 112 +++++++------------------------
 2 files changed, 29 insertions(+), 106 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 1d77c7f..fddcb88 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -300,18 +300,6 @@ struct iser_login_desc {
 struct iscsi_iser_task;
 
 /**
- * struct iser_comp - iSER completion context
- *
- * @cq:         completion queue
- * @active_qps: Number of active QPs attached
- *              to completion context
- */
-struct iser_comp {
-	struct ib_cq		*cq;
-	int                      active_qps;
-};
-
-/**
  * struct iser_device - iSER device handle
  *
  * @ib_device:     RDMA device
@@ -320,9 +308,6 @@ struct iser_comp {
  * @event_handler: IB events handle routine
  * @ig_list:	   entry in devices list
  * @refcount:      Reference counter, dominated by open iser connections
- * @comps_used:    Number of completion contexts used, Min between online
- *                 cpus and device max completion vectors
- * @comps:         Dinamically allocated array of completion handlers
  */
 struct iser_device {
 	struct ib_device             *ib_device;
@@ -330,8 +315,6 @@ struct iser_device {
 	struct ib_event_handler      event_handler;
 	struct list_head             ig_list;
 	int                          refcount;
-	int			     comps_used;
-	struct iser_comp	     *comps;
 };
 
 /**
@@ -380,11 +363,12 @@ struct iser_fr_pool {
  *
  * @cma_id:              rdma_cm connection maneger handle
  * @qp:                  Connection Queue-pair
+ * @cq:                  Connection completion queue
+ * @cq_size:             The number of max outstanding completions
  * @post_recv_buf_count: post receive counter
  * @sig_count:           send work request signal count
  * @rx_wr:               receive work request for batch posts
  * @device:              reference to iser device
- * @comp:                iser completion context
  * @fr_pool:             connection fast registration poool
  * @pi_support:          Indicate device T10-PI support
  * @reg_cqe:             completion handler
@@ -392,11 +376,12 @@ struct iser_fr_pool {
 struct ib_conn {
 	struct rdma_cm_id           *cma_id;
 	struct ib_qp	            *qp;
+	struct ib_cq		    *cq;
+	u32			    cq_size;
 	int                          post_recv_buf_count;
 	u8                           sig_count;
 	struct ib_recv_wr	     rx_wr[ISER_MIN_POSTED_RX];
 	struct iser_device          *device;
-	struct iser_comp	    *comp;
 	struct iser_fr_pool          fr_pool;
 	bool			     pi_support;
 	struct ib_cqe		     reg_cqe;
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index c1f44c4..699e075 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -68,59 +68,23 @@ static void iser_event_handler(struct ib_event_handler *handler,
 static int iser_create_device_ib_res(struct iser_device *device)
 {
 	struct ib_device *ib_dev = device->ib_device;
-	int i, max_cqe;
 
 	if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_MEM_MGT_EXTENSIONS)) {
 		iser_err("IB device does not support memory registrations\n");
 		return -1;
 	}
 
-	device->comps_used = min_t(int, num_online_cpus(),
-				 ib_dev->num_comp_vectors);
-
-	device->comps = kcalloc(device->comps_used, sizeof(*device->comps),
-				GFP_KERNEL);
-	if (!device->comps)
-		goto comps_err;
-
-	max_cqe = min(ISER_MAX_CQ_LEN, ib_dev->attrs.max_cqe);
-
-	iser_info("using %d CQs, device %s supports %d vectors max_cqe %d\n",
-		  device->comps_used, dev_name(&ib_dev->dev),
-		  ib_dev->num_comp_vectors, max_cqe);
-
 	device->pd = ib_alloc_pd(ib_dev,
 		iser_always_reg ? 0 : IB_PD_UNSAFE_GLOBAL_RKEY);
 	if (IS_ERR(device->pd))
 		goto pd_err;
 
-	for (i = 0; i < device->comps_used; i++) {
-		struct iser_comp *comp = &device->comps[i];
-
-		comp->cq = ib_alloc_cq(ib_dev, comp, max_cqe, i,
-				       IB_POLL_SOFTIRQ);
-		if (IS_ERR(comp->cq)) {
-			comp->cq = NULL;
-			goto cq_err;
-		}
-	}
-
 	INIT_IB_EVENT_HANDLER(&device->event_handler, ib_dev,
 			      iser_event_handler);
 	ib_register_event_handler(&device->event_handler);
 	return 0;
 
-cq_err:
-	for (i = 0; i < device->comps_used; i++) {
-		struct iser_comp *comp = &device->comps[i];
-
-		if (comp->cq)
-			ib_free_cq(comp->cq);
-	}
-	ib_dealloc_pd(device->pd);
 pd_err:
-	kfree(device->comps);
-comps_err:
 	iser_err("failed to allocate an IB resource\n");
 	return -1;
 }
@@ -131,20 +95,9 @@ static int iser_create_device_ib_res(struct iser_device *device)
  */
 static void iser_free_device_ib_res(struct iser_device *device)
 {
-	int i;
-
-	for (i = 0; i < device->comps_used; i++) {
-		struct iser_comp *comp = &device->comps[i];
-
-		ib_free_cq(comp->cq);
-		comp->cq = NULL;
-	}
-
 	ib_unregister_event_handler(&device->event_handler);
 	ib_dealloc_pd(device->pd);
 
-	kfree(device->comps);
-	device->comps = NULL;
 	device->pd = NULL;
 }
 
@@ -287,70 +240,57 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 	struct ib_device	*ib_dev;
 	struct ib_qp_init_attr	init_attr;
 	int			ret = -ENOMEM;
-	int index, min_index = 0;
+	unsigned int max_send_wr, cq_size;
 
 	BUG_ON(ib_conn->device == NULL);
 
 	device = ib_conn->device;
 	ib_dev = device->ib_device;
 
-	memset(&init_attr, 0, sizeof init_attr);
+	if (ib_conn->pi_support)
+		max_send_wr = ISER_QP_SIG_MAX_REQ_DTOS + 1;
+	else
+		max_send_wr = ISER_QP_MAX_REQ_DTOS + 1;
+	max_send_wr = min_t(unsigned int, max_send_wr,
+			    (unsigned int)ib_dev->attrs.max_qp_wr);
 
-	mutex_lock(&ig.connlist_mutex);
-	/* select the CQ with the minimal number of usages */
-	for (index = 0; index < device->comps_used; index++) {
-		if (device->comps[index].active_qps <
-		    device->comps[min_index].active_qps)
-			min_index = index;
+	cq_size = max_send_wr + ISER_QP_MAX_RECV_DTOS;
+	ib_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1, IB_POLL_SOFTIRQ);
+	if (IS_ERR(ib_conn->cq)) {
+		ret = PTR_ERR(ib_conn->cq);
+		goto cq_err;
 	}
-	ib_conn->comp = &device->comps[min_index];
-	ib_conn->comp->active_qps++;
-	mutex_unlock(&ig.connlist_mutex);
-	iser_info("cq index %d used for ib_conn %p\n", min_index, ib_conn);
+	ib_conn->cq_size = cq_size;
+
+	memset(&init_attr, 0, sizeof(init_attr));
 
 	init_attr.event_handler = iser_qp_event_callback;
 	init_attr.qp_context	= (void *)ib_conn;
-	init_attr.send_cq	= ib_conn->comp->cq;
-	init_attr.recv_cq	= ib_conn->comp->cq;
+	init_attr.send_cq	= ib_conn->cq;
+	init_attr.recv_cq	= ib_conn->cq;
 	init_attr.cap.max_recv_wr  = ISER_QP_MAX_RECV_DTOS;
 	init_attr.cap.max_send_sge = 2;
 	init_attr.cap.max_recv_sge = 1;
 	init_attr.sq_sig_type	= IB_SIGNAL_REQ_WR;
 	init_attr.qp_type	= IB_QPT_RC;
-	if (ib_conn->pi_support) {
-		init_attr.cap.max_send_wr = ISER_QP_SIG_MAX_REQ_DTOS + 1;
+	init_attr.cap.max_send_wr = max_send_wr;
+	if (ib_conn->pi_support)
 		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
-		iser_conn->max_cmds =
-			ISER_GET_MAX_XMIT_CMDS(ISER_QP_SIG_MAX_REQ_DTOS);
-	} else {
-		if (ib_dev->attrs.max_qp_wr > ISER_QP_MAX_REQ_DTOS) {
-			init_attr.cap.max_send_wr  = ISER_QP_MAX_REQ_DTOS + 1;
-			iser_conn->max_cmds =
-				ISER_GET_MAX_XMIT_CMDS(ISER_QP_MAX_REQ_DTOS);
-		} else {
-			init_attr.cap.max_send_wr = ib_dev->attrs.max_qp_wr;
-			iser_conn->max_cmds =
-				ISER_GET_MAX_XMIT_CMDS(ib_dev->attrs.max_qp_wr);
-			iser_dbg("device %s supports max_send_wr %d\n",
-				 dev_name(&device->ib_device->dev),
-				 ib_dev->attrs.max_qp_wr);
-		}
-	}
+	iser_conn->max_cmds = ISER_GET_MAX_XMIT_CMDS(max_send_wr - 1);
 
 	ret = rdma_create_qp(ib_conn->cma_id, device->pd, &init_attr);
 	if (ret)
 		goto out_err;
 
 	ib_conn->qp = ib_conn->cma_id->qp;
-	iser_info("setting conn %p cma_id %p qp %p\n",
+	iser_info("setting conn %p cma_id %p qp %p max_send_wr %d\n",
 		  ib_conn, ib_conn->cma_id,
-		  ib_conn->cma_id->qp);
+		  ib_conn->cma_id->qp, max_send_wr);
 	return ret;
 
 out_err:
-	mutex_lock(&ig.connlist_mutex);
-	ib_conn->comp->active_qps--;
-	mutex_unlock(&ig.connlist_mutex);
+	ib_cq_pool_put(ib_conn->cq, ib_conn->cq_size);
+cq_err:
 	iser_err("unable to alloc mem or create resource, err %d\n", ret);
 
 	return ret;
@@ -462,10 +402,8 @@ static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
 		  iser_conn, ib_conn->cma_id, ib_conn->qp);
 
 	if (ib_conn->qp != NULL) {
-		mutex_lock(&ig.connlist_mutex);
-		ib_conn->comp->active_qps--;
-		mutex_unlock(&ig.connlist_mutex);
 		rdma_destroy_qp(ib_conn->cma_id);
+		ib_cq_pool_put(ib_conn->cq, ib_conn->cq_size);
 		ib_conn->qp = NULL;
 	}
 
-- 
1.8.3.1

