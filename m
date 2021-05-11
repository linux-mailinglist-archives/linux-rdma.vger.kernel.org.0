Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC537A21F
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 10:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhEKIcr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 04:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230514AbhEKIcj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 04:32:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB3A661937;
        Tue, 11 May 2021 08:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721402;
        bh=TJJ0HlA7YmggpHRXsCnvz+1yfDn4QnGmIyklAHsRH28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SR4kuCBtUtJd1wGRlKO3KgjlN3SHxPylPXqd/67fISvkDICZbOEbaFBIXZOBmug6N
         al8OZwYz7E0YrapmerDmu1CYVvXA+euN36U0CSLu6aq9o1+ThOt4/YvAF1Me+TbZWG
         N/W4FLi5EOnyym2fljxpZRljnI8Hwl3k4ltt3xD7vGjzgjTrg3fveesZJQ/LdD9ytO
         oZtX6oTBcj8AwbWs28MRZqSdcoWHZR6ps3N9vxTfAVfP9Kk42igyTqXOuALoZJzEBx
         FqTK9Jddg45mw+/ugIxL41rFlrWyE+Q0HQg4z2Chwn9xic4O4ZvP5K98Jl5hsyR0Bq
         bPjaHrSxGSR/A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v3 7/8] IB/cm: Improve the calling of cm_init_av_for_lap and cm_init_av_by_path
Date:   Tue, 11 May 2021 11:22:11 +0300
Message-Id: <7adea3d5550d59b25feaea3a3e175c0918df2997.1620720467.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620720467.git.leonro@nvidia.com>
References: <cover.1620720467.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

The cm_init_av_for_lap() and cm_init_av_by_path() function calls have
the following issues:
1. Both of them might sleep and should not be called under spinlock.
2. The access of cm_id_priv->av should be under cm_id_priv->lock, which
   means it cann't be initialized directly.

This patch splits the calling of 2 functions into two parts: first one
initializes an AV outside of the spinlock, the second one copies AV to
cm_id_priv->av under spinlock.

Fixes: e1444b5a163e ("IB/cm: Fix automatic path migration support")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 105 +++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 2d62c90f9790..2e4658795e8e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -440,30 +440,12 @@ static void cm_set_private_data(struct cm_id_private *cm_id_priv,
 	cm_id_priv->private_data_len = private_data_len;
 }
 
-static int cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
-			      struct ib_grh *grh, struct cm_av *av)
+static void cm_init_av_for_lap(struct cm_port *port, struct ib_wc *wc,
+			       struct rdma_ah_attr *ah_attr, struct cm_av *av)
 {
-	struct rdma_ah_attr new_ah_attr;
-	int ret;
-
 	av->port = port;
 	av->pkey_index = wc->pkey_index;
-
-	/*
-	 * av->ah_attr might be initialized based on past wc during incoming
-	 * connect request or while sending out connect request. So initialize
-	 * a new ah_attr on stack. If initialization fails, old ah_attr is
-	 * used for sending any responses. If initialization is successful,
-	 * than new ah_attr is used by overwriting old one.
-	 */
-	ret = ib_init_ah_attr_from_wc(port->cm_dev->ib_device,
-				      port->port_num, wc,
-				      grh, &new_ah_attr);
-	if (ret)
-		return ret;
-
-	rdma_move_ah_attr(&av->ah_attr, &new_ah_attr);
-	return 0;
+	rdma_move_ah_attr(&av->ah_attr, ah_attr);
 }
 
 static int cm_init_av_for_response(struct cm_port *port, struct ib_wc *wc,
@@ -557,6 +539,20 @@ static int cm_init_av_by_path(struct sa_path_rec *path,
 	return 0;
 }
 
+/* Move av created by cm_init_av_by_path(), so av.dgid is not moved */
+static void cm_move_av_from_path(struct cm_av *dest, struct cm_av *src)
+{
+	dest->port = src->port;
+	dest->pkey_index = src->pkey_index;
+	rdma_move_ah_attr(&dest->ah_attr, &src->ah_attr);
+	dest->timeout = src->timeout;
+}
+
+static void cm_destroy_av(struct cm_av *av)
+{
+	rdma_destroy_ah_attr(&av->ah_attr);
+}
+
 static u32 cm_local_id(__be32 local_id)
 {
 	return (__force u32) (local_id ^ cm.random_id_operand);
@@ -1146,8 +1142,8 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	while ((work = cm_dequeue_work(cm_id_priv)) != NULL)
 		cm_free_work(work);
 
-	rdma_destroy_ah_attr(&cm_id_priv->av.ah_attr);
-	rdma_destroy_ah_attr(&cm_id_priv->alt_av.ah_attr);
+	cm_destroy_av(&cm_id_priv->av);
+	cm_destroy_av(&cm_id_priv->alt_av);
 	kfree(cm_id_priv->private_data);
 	kfree_rcu(cm_id_priv, rcu);
 }
@@ -1471,6 +1467,7 @@ static int cm_validate_req_param(struct ib_cm_req_param *param)
 int ib_send_cm_req(struct ib_cm_id *cm_id,
 		   struct ib_cm_req_param *param)
 {
+	struct cm_av av = {}, alt_av = {};
 	struct cm_id_private *cm_id_priv;
 	struct ib_mad_send_buf *msg;
 	struct cm_req_msg *req_msg;
@@ -1486,8 +1483,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_IDLE || WARN_ON(cm_id_priv->timewait_info)) {
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 
@@ -1496,18 +1492,20 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	if (IS_ERR(cm_id_priv->timewait_info)) {
 		ret = PTR_ERR(cm_id_priv->timewait_info);
 		cm_id_priv->timewait_info = NULL;
-		goto out;
+		return ret;
 	}
 
 	ret = cm_init_av_by_path(param->primary_path,
-				 param->ppath_sgid_attr, &cm_id_priv->av);
+				 param->ppath_sgid_attr, &av);
 	if (ret)
-		goto out;
+		return ret;
 	if (param->alternate_path) {
 		ret = cm_init_av_by_path(param->alternate_path, NULL,
-					 &cm_id_priv->alt_av);
-		if (ret)
-			goto out;
+					 &alt_av);
+		if (ret) {
+			cm_destroy_av(&av);
+			return ret;
+		}
 	}
 	cm_id->service_id = param->service_id;
 	cm_id->service_mask = ~cpu_to_be64(0);
@@ -1524,6 +1522,11 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->qp_type = param->qp_type;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
+
+	cm_move_av_from_path(&cm_id_priv->av, &av);
+	if (param->alternate_path)
+		cm_move_av_from_path(&cm_id_priv->alt_av, &alt_av);
+
 	msg = cm_alloc_priv_msg(cm_id_priv);
 	if (IS_ERR(msg)) {
 		ret = PTR_ERR(msg);
@@ -1551,7 +1554,6 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_free_priv_msg(msg);
 out_unlock:
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-out:
 	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_req);
@@ -3264,6 +3266,8 @@ static int cm_lap_handler(struct cm_work *work)
 	struct cm_lap_msg *lap_msg;
 	struct ib_cm_lap_event_param *param;
 	struct ib_mad_send_buf *msg = NULL;
+	struct rdma_ah_attr ah_attr;
+	struct cm_av alt_av = {};
 	int ret;
 
 	/* Currently Alternate path messages are not supported for
@@ -3292,7 +3296,25 @@ static int cm_lap_handler(struct cm_work *work)
 	work->cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_LAP_PRIVATE_DATA, lap_msg);
 
+	ret = ib_init_ah_attr_from_wc(work->port->cm_dev->ib_device,
+				      work->port->port_num,
+				      work->mad_recv_wc->wc,
+				      work->mad_recv_wc->recv_buf.grh,
+				      &ah_attr);
+	if (ret)
+		goto deref;
+
+	ret = cm_init_av_by_path(param->alternate_path, NULL, &alt_av);
+	if (ret) {
+		rdma_destroy_ah_attr(&ah_attr);
+		return -EINVAL;
+	}
+
 	spin_lock_irq(&cm_id_priv->lock);
+	cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
+			   &ah_attr, &cm_id_priv->av);
+	cm_move_av_from_path(&cm_id_priv->alt_av, &alt_av);
+
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
 		goto unlock;
 
@@ -3326,17 +3348,6 @@ static int cm_lap_handler(struct cm_work *work)
 		goto unlock;
 	}
 
-	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
-				 work->mad_recv_wc->recv_buf.grh,
-				 &cm_id_priv->av);
-	if (ret)
-		goto unlock;
-
-	ret = cm_init_av_by_path(param->alternate_path, NULL,
-				 &cm_id_priv->alt_av);
-	if (ret)
-		goto unlock;
-
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
 	cm_queue_work_unlock(cm_id_priv, work);
@@ -3443,6 +3454,7 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 {
 	struct cm_id_private *cm_id_priv;
 	struct ib_mad_send_buf *msg;
+	struct cm_av av = {};
 	unsigned long flags;
 	int ret;
 
@@ -3451,17 +3463,16 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 		return -EINVAL;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	ret = cm_init_av_by_path(param->path, param->sgid_attr,
-				 &cm_id_priv->av);
+	ret = cm_init_av_by_path(param->path, param->sgid_attr, &av);
 	if (ret)
 		return ret;
 
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	cm_move_av_from_path(&cm_id_priv->av, &av);
 	cm_id->service_id = param->service_id;
 	cm_id->service_mask = ~cpu_to_be64(0);
 	cm_id_priv->timeout_ms = param->timeout_ms;
 	cm_id_priv->max_cm_retries = param->max_cm_retries;
-
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_IDLE) {
 		ret = -EINVAL;
 		goto out_unlock;
-- 
2.31.1

