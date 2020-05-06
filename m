Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C71C6A55
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2020 09:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgEFHrS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 May 2020 03:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgEFHrS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 6 May 2020 03:47:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C980B20714;
        Wed,  6 May 2020 07:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588751237;
        bh=87Mh+49etAT7Tl6p7VaYNSf+G/Av/GojkaJo2d9d/lM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z6NT6N7/Ck4ydnDnjKLWoChpHnpPUjigdVa5c5NGIh53GJYJyQeCBP3ZKO6RgVKd+
         5Hi/B1ol34eVYDlfAl6wIKwxGyGHOGOaL4xb/ikjtsylGf07MTTEH0GKVycaq5WbzW
         u7/gz3m6eDEhOgRSRznjqftuxZ7F3s8aJjyiULfs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 04/10] RDMA/cm: Pull duplicated code into cm_queue_work_unlock()
Date:   Wed,  6 May 2020 10:46:55 +0300
Message-Id: <20200506074701.9775-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200506074701.9775-1-leon@kernel.org>
References: <20200506074701.9775-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

While unlocking a spinlock held by the caller is a disturbing pattern,
this extensively duplicated code is even worse. Pull all the duplicates
into a function and explain the purpose of the algorithm.

The on creation side call in cm_req_handler() which is different has been
micro-optimized on the basis that the work_count == -1 during creation,
remove that and just use the normal function.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 146 +++++++++++------------------------
 1 file changed, 44 insertions(+), 102 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 439055c463fa..e7c20c44a361 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -83,8 +83,11 @@ const char *__attribute_const__ ibcm_reject_msg(int reason)
 EXPORT_SYMBOL(ibcm_reject_msg);
 
 struct cm_id_private;
+struct cm_work;
 static int cm_add_one(struct ib_device *device);
 static void cm_remove_one(struct ib_device *device, void *client_data);
+static void cm_process_work(struct cm_id_private *cm_id_priv,
+			    struct cm_work *work);
 static int cm_send_sidr_rep_locked(struct cm_id_private *cm_id_priv,
 				   struct ib_cm_sidr_rep_param *param);
 static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
@@ -911,6 +914,35 @@ static void cm_free_work(struct cm_work *work)
 	kfree(work);
 }
 
+static void cm_queue_work_unlock(struct cm_id_private *cm_id_priv,
+				 struct cm_work *work)
+{
+	bool immediate;
+
+	/*
+	 * To deliver the event to the user callback we have the drop the
+	 * spinlock, however, we need to ensure that the user callback is single
+	 * threaded and receives events in the temporal order. If there are
+	 * already events being processed then thread new events onto a list,
+	 * the thread currently processing will pick them up.
+	 */
+	immediate = atomic_inc_and_test(&cm_id_priv->work_count);
+	if (!immediate) {
+		list_add_tail(&work->list, &cm_id_priv->work_list);
+		/*
+		 * This routine always consumes incoming reference. Once queued
+		 * to the work_list then a reference is held by the thread
+		 * currently running cm_process_work() and this reference is not
+		 * needed.
+		 */
+		cm_deref_id(cm_id_priv);
+	}
+	spin_unlock_irq(&cm_id_priv->lock);
+
+	if (immediate)
+		cm_process_work(cm_id_priv, work);
+}
+
 static inline int cm_convert_to_ms(int iba_time)
 {
 	/* approximate conversion to ms from 4.096us x 2^iba_time */
@@ -2159,9 +2191,7 @@ static int cm_req_handler(struct cm_work *work)
 
 	/* Refcount belongs to the event, pairs with cm_process_work() */
 	refcount_inc(&cm_id_priv->refcount);
-	atomic_inc(&cm_id_priv->work_count);
-	spin_unlock_irq(&cm_id_priv->lock);
-	cm_process_work(cm_id_priv, work);
+	cm_queue_work_unlock(cm_id_priv, work);
 	/*
 	 * Since this ID was just created and was not made visible to other MAD
 	 * handlers until the cm_finalize_id() above we know that the
@@ -2519,15 +2549,7 @@ static int cm_rep_handler(struct cm_work *work)
 				       cm_id_priv->alt_av.timeout - 1);
 
 	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 
 error:
@@ -2538,7 +2560,6 @@ static int cm_rep_handler(struct cm_work *work)
 static int cm_establish_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
-	int ret;
 
 	/* See comment in cm_establish about lookup. */
 	cm_id_priv = cm_acquire_id(work->local_id, work->remote_id);
@@ -2552,15 +2573,7 @@ static int cm_establish_handler(struct cm_work *work)
 	}
 
 	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
 	cm_deref_id(cm_id_priv);
@@ -2571,7 +2584,6 @@ static int cm_rtu_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_rtu_msg *rtu_msg;
-	int ret;
 
 	rtu_msg = (struct cm_rtu_msg *)work->mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
@@ -2594,15 +2606,7 @@ static int cm_rtu_handler(struct cm_work *work)
 	cm_id_priv->id.state = IB_CM_ESTABLISHED;
 
 	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
 	cm_deref_id(cm_id_priv);
@@ -2795,7 +2799,6 @@ static int cm_dreq_handler(struct cm_work *work)
 	struct cm_id_private *cm_id_priv;
 	struct cm_dreq_msg *dreq_msg;
 	struct ib_mad_send_buf *msg = NULL;
-	int ret;
 
 	dreq_msg = (struct cm_dreq_msg *)work->mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
@@ -2860,15 +2863,7 @@ static int cm_dreq_handler(struct cm_work *work)
 	}
 	cm_id_priv->id.state = IB_CM_DREQ_RCVD;
 	cm_id_priv->tid = dreq_msg->hdr.tid;
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 
 unlock:	spin_unlock_irq(&cm_id_priv->lock);
@@ -2880,7 +2875,6 @@ static int cm_drep_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_drep_msg *drep_msg;
-	int ret;
 
 	drep_msg = (struct cm_drep_msg *)work->mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_id(
@@ -2901,15 +2895,7 @@ static int cm_drep_handler(struct cm_work *work)
 	cm_enter_timewait(cm_id_priv);
 
 	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
 	cm_deref_id(cm_id_priv);
@@ -3037,7 +3023,6 @@ static int cm_rej_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_rej_msg *rej_msg;
-	int ret;
 
 	rej_msg = (struct cm_rej_msg *)work->mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_rejected_id(rej_msg);
@@ -3086,15 +3071,7 @@ static int cm_rej_handler(struct cm_work *work)
 		goto out;
 	}
 
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
 	cm_deref_id(cm_id_priv);
@@ -3204,7 +3181,7 @@ static int cm_mra_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_mra_msg *mra_msg;
-	int timeout, ret;
+	int timeout;
 
 	mra_msg = (struct cm_mra_msg *)work->mad_recv_wc->recv_buf.mad;
 	cm_id_priv = cm_acquire_mraed_id(mra_msg);
@@ -3264,15 +3241,7 @@ static int cm_mra_handler(struct cm_work *work)
 
 	cm_id_priv->msg->context[1] = (void *) (unsigned long)
 				      cm_id_priv->id.state;
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
 	spin_unlock_irq(&cm_id_priv->lock);
@@ -3407,15 +3376,7 @@ static int cm_lap_handler(struct cm_work *work)
 
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 
 unlock:	spin_unlock_irq(&cm_id_priv->lock);
@@ -3427,7 +3388,6 @@ static int cm_apr_handler(struct cm_work *work)
 {
 	struct cm_id_private *cm_id_priv;
 	struct cm_apr_msg *apr_msg;
-	int ret;
 
 	/* Currently Alternate path messages are not supported for
 	 * RoCE link layer.
@@ -3462,16 +3422,7 @@ static int cm_apr_handler(struct cm_work *work)
 	cm_id_priv->id.lap_state = IB_CM_LAP_IDLE;
 	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
 	cm_id_priv->msg = NULL;
-
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
 	cm_deref_id(cm_id_priv);
@@ -3482,7 +3433,6 @@ static int cm_timewait_handler(struct cm_work *work)
 {
 	struct cm_timewait_info *timewait_info;
 	struct cm_id_private *cm_id_priv;
-	int ret;
 
 	timewait_info = container_of(work, struct cm_timewait_info, work);
 	spin_lock_irq(&cm.lock);
@@ -3501,15 +3451,7 @@ static int cm_timewait_handler(struct cm_work *work)
 		goto out;
 	}
 	cm_id_priv->id.state = IB_CM_IDLE;
-	ret = atomic_inc_and_test(&cm_id_priv->work_count);
-	if (!ret)
-		list_add_tail(&work->list, &cm_id_priv->work_list);
-	spin_unlock_irq(&cm_id_priv->lock);
-
-	if (ret)
-		cm_process_work(cm_id_priv, work);
-	else
-		cm_deref_id(cm_id_priv);
+	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
 	cm_deref_id(cm_id_priv);
-- 
2.26.2

