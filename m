Return-Path: <linux-rdma+bounces-6885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC3A041A0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 15:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8645A7A2A05
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A181F890E;
	Tue,  7 Jan 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJxz8o5B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1098A1F3D5F
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258550; cv=none; b=koO3Yz/H5TUYNuwHW5GHv3ngKLueJcFfgiwMmyZRTHz72tSkxCbznQwBWVMP/3Liw3iIms4jaUyUj22AAoxcXYjdUyHoIpAerAOJDQsloW+po5byf+Hd4MV3FqODYMJjz1g35CiSxjDBNeqLZJrie9BdUNxAXPMiAhV7AjY8dzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258550; c=relaxed/simple;
	bh=xvtlO/FOgTO7pfIpwBhdLl7SKKHSM4hMBWMWfQMHGQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4E08+SQAfZTYKTvFd7bRgmTtWFKv8zwXyvdRSJeyYX2VkF1uteDZZmjoFv9nWT0v2vqAWcSsm+HxmyKNM9RtMyc6WB+9h6se+wm3/rC2UwysOjenphjegMOikajQp2AGMhLavITEkObThIlwm8PqhA0nJVYNGfwCUE6qn6GlnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJxz8o5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DE9C4CEDF;
	Tue,  7 Jan 2025 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736258549;
	bh=xvtlO/FOgTO7pfIpwBhdLl7SKKHSM4hMBWMWfQMHGQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJxz8o5BYhMPt60ZzKDNPtFVR4Qgf0Pu1i3dsAZKBKeV330lqoouCFw0LVMFTVv5w
	 SAh3yEpIc5Qt83+FDQzXpaG5VkkLX0+jCpeTFE4X2G9JLAjvlQQGdK5CGWQ8XIGuNt
	 +qnhPBXSNbDNNZ0KvL8yLEgRyqeXlTP9sEhpRLStVGBixZpc0tmLigNxihbV6SzmUM
	 1ASZbotvrr2X0a0rlYVkCPiMPQc+5LCrO4FRqxv96i8KGXfzAmZFGFsqLb1+1W9Yde
	 k1Q84G/ca2dP410Zzv3HYHqeRaVRiRPAneYLZEIeyNM2bJsC0QAu9JknUCULWS87tJ
	 XTPW8QfKY/vRQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next v1 1/2] IB/mad: Add state machine to MAD layer
Date: Tue,  7 Jan 2025 16:02:12 +0200
Message-ID: <bf1d3e6c5eceb452a4fa4f6d08ea6b5220ab5cc9.1736258116.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736258116.git.leonro@nvidia.com>
References: <cover.1736258116.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Replace the use of refcount, timeout and status with a 'state'
field to track the status of MADs send work requests (WRs).
The state machine better represents the stages in the MAD lifecycle,
specifically indicating whether the MAD is waiting for a completion,
waiting for a response, was canceld or is done.

The existing refcount only takes two values:
1 : MAD is waiting either for completion or for response.
2 : MAD is waiting for both response and completion. Also when a
     response was received before a completion notification.
The status field represents if the MAD was canceled at some point
in the flow.
The timeout is used to represent if a response was received.

The current state transitions are not clearly visible, and developers
needs to infer the state from the refcount's, timeout's or status's
value, which is error-prone and difficult to follow.

Thus, replace with a state machine as the following:
- 'IB_MAD_STATE_SEND_START': MAD was sent to the QP and is waiting for
   completion notification in send list
- 'IB_MAD_STATE_WAIT_RESP': MAD send completed successfully, waiting for
  a response in wait list
- 'IB_MAD_STATE_EARLY_RESP': Response came early, before send
   completion notification, MAD is in the send list
- 'IB_MAD_STATE_CANCELED': MAD was canceled while in send or wait list
- 'IB_MAD_STATE_DONE': MAD processing completed, MAD is in no list

Adding the state machine also make it possible to remove the double
call for ib_mad_complete_send_wr in case of an early response and the
use of a done list in case of a regular response.

While at it, define a helper to clear error MADs which will handle
freeing MADs that timed out or have been cancelled.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 250 +++++++++++++++++++----------
 drivers/infiniband/core/mad_priv.h |  49 +++++-
 drivers/infiniband/core/mad_rmpp.c |  41 +++--
 3 files changed, 233 insertions(+), 107 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 1fd54d5c4dd8b..49da1d246f72a 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -391,7 +391,6 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	spin_lock_init(&mad_agent_priv->lock);
 	INIT_LIST_HEAD(&mad_agent_priv->send_list);
 	INIT_LIST_HEAD(&mad_agent_priv->wait_list);
-	INIT_LIST_HEAD(&mad_agent_priv->done_list);
 	INIT_LIST_HEAD(&mad_agent_priv->rmpp_list);
 	INIT_DELAYED_WORK(&mad_agent_priv->timed_work, timeout_sends);
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
@@ -1055,6 +1054,98 @@ int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
 	return ret;
 }
 
+static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
+		       struct ib_mad_agent_private *mad_agent_priv)
+{
+	if (!mad_send_wr->state) {
+		list_add_tail(&mad_send_wr->agent_list,
+			      &mad_agent_priv->send_list);
+	} else {
+		EXPECT_MAD_STATE(mad_send_wr, IB_MAD_STATE_WAIT_RESP);
+		list_move_tail(&mad_send_wr->agent_list,
+			       &mad_agent_priv->send_list);
+	}
+}
+
+static void handle_wait_state(struct ib_mad_send_wr_private *mad_send_wr,
+		       struct ib_mad_agent_private *mad_agent_priv)
+{
+	struct ib_mad_send_wr_private *temp_mad_send_wr;
+	struct list_head *list_item;
+	unsigned long delay;
+
+	EXPECT_MAD_STATE3(mad_send_wr, IB_MAD_STATE_SEND_START,
+			  IB_MAD_STATE_WAIT_RESP, IB_MAD_STATE_CANCELED);
+	list_del_init(&mad_send_wr->agent_list);
+
+	delay = mad_send_wr->timeout;
+	mad_send_wr->timeout += jiffies;
+
+	if (delay) {
+		list_for_each_prev(list_item,
+				   &mad_agent_priv->wait_list) {
+			temp_mad_send_wr = list_entry(
+				list_item,
+				struct ib_mad_send_wr_private,
+				agent_list);
+			if (time_after(mad_send_wr->timeout,
+				       temp_mad_send_wr->timeout))
+				break;
+		}
+	} else {
+		list_item = &mad_agent_priv->wait_list;
+	}
+
+	list_add(&mad_send_wr->agent_list, list_item);
+}
+
+static void handle_early_resp_state(struct ib_mad_send_wr_private *mad_send_wr,
+			    struct ib_mad_agent_private *mad_agent_priv)
+{
+	EXPECT_MAD_STATE(mad_send_wr, IB_MAD_STATE_SEND_START);
+}
+
+static void handle_canceled_state(struct ib_mad_send_wr_private *mad_send_wr,
+			 struct ib_mad_agent_private *mad_agent_priv)
+{
+	NOT_EXPECT_MAD_STATE(mad_send_wr, IB_MAD_STATE_DONE);
+}
+
+static void handle_done_state(struct ib_mad_send_wr_private *mad_send_wr,
+		       struct ib_mad_agent_private *mad_agent_priv)
+{
+	list_del_init(&mad_send_wr->agent_list);
+}
+
+void change_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
+			     enum ib_mad_state new_state)
+{
+	struct ib_mad_agent_private *mad_agent_priv =
+		mad_send_wr->mad_agent_priv;
+
+	switch (new_state) {
+	case IB_MAD_STATE_SEND_START:
+		handle_send_state(mad_send_wr, mad_agent_priv);
+		break;
+	case IB_MAD_STATE_WAIT_RESP:
+		handle_wait_state(mad_send_wr, mad_agent_priv);
+		if (mad_send_wr->state == IB_MAD_STATE_CANCELED)
+			return;
+		break;
+	case IB_MAD_STATE_EARLY_RESP:
+		handle_early_resp_state(mad_send_wr, mad_agent_priv);
+		break;
+	case IB_MAD_STATE_CANCELED:
+		handle_canceled_state(mad_send_wr, mad_agent_priv);
+		break;
+	case IB_MAD_STATE_DONE:
+		handle_done_state(mad_send_wr, mad_agent_priv);
+		break;
+	}
+
+	mad_send_wr->state = new_state;
+}
+
 /*
  * ib_post_send_mad - Posts MAD(s) to the send queue of the QP associated
  *  with the registered client
@@ -1118,15 +1209,12 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		mad_send_wr->max_retries = send_buf->retries;
 		mad_send_wr->retries_left = send_buf->retries;
 		send_buf->retries = 0;
-		/* Reference for work request to QP + response */
-		mad_send_wr->refcount = 1 + (mad_send_wr->timeout > 0);
-		mad_send_wr->status = IB_WC_SUCCESS;
+		mad_send_wr->state = 0;
 
 		/* Reference MAD agent until send completes */
 		refcount_inc(&mad_agent_priv->refcount);
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		list_add_tail(&mad_send_wr->agent_list,
-			      &mad_agent_priv->send_list);
+		change_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 		if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {
@@ -1138,7 +1226,7 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		if (ret < 0) {
 			/* Fail send request */
 			spin_lock_irqsave(&mad_agent_priv->lock, flags);
-			list_del(&mad_send_wr->agent_list);
+			change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 			deref_mad_agent(mad_agent_priv);
 			goto error;
@@ -1746,7 +1834,7 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 		     */
 		    (is_direct(mad_hdr->mgmt_class) ||
 		     rcv_has_same_gid(mad_agent_priv, wr, wc)))
-			return (wr->status == IB_WC_SUCCESS) ? wr : NULL;
+			return (wr->state != IB_MAD_STATE_CANCELED) ? wr : NULL;
 	}
 
 	/*
@@ -1765,7 +1853,7 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 		    (is_direct(mad_hdr->mgmt_class) ||
 		     rcv_has_same_gid(mad_agent_priv, wr, wc)))
 			/* Verify request has not been canceled */
-			return (wr->status == IB_WC_SUCCESS) ? wr : NULL;
+			return (wr->state != IB_MAD_STATE_CANCELED) ? wr : NULL;
 	}
 	return NULL;
 }
@@ -1773,9 +1861,10 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	mad_send_wr->timeout = 0;
-	if (mad_send_wr->refcount == 1)
-		list_move_tail(&mad_send_wr->agent_list,
-			      &mad_send_wr->mad_agent_priv->done_list);
+	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
+		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
+	else
+		change_mad_state(mad_send_wr, IB_MAD_STATE_EARLY_RESP);
 }
 
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
@@ -1784,6 +1873,7 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_send_wc mad_send_wc;
 	unsigned long flags;
+	bool is_mad_done;
 	int ret;
 
 	INIT_LIST_HEAD(&mad_recv_wc->rmpp_list);
@@ -1832,6 +1922,7 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 			}
 		} else {
 			ib_mark_mad_done(mad_send_wr);
+			is_mad_done = (mad_send_wr->state == IB_MAD_STATE_DONE);
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 			/* Defined behavior is to complete response before request */
@@ -1841,10 +1932,13 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 					mad_recv_wc);
 			deref_mad_agent(mad_agent_priv);
 
-			mad_send_wc.status = IB_WC_SUCCESS;
-			mad_send_wc.vendor_err = 0;
-			mad_send_wc.send_buf = &mad_send_wr->send_buf;
-			ib_mad_complete_send_wr(mad_send_wr, &mad_send_wc);
+			if (is_mad_done) {
+				mad_send_wc.status = IB_WC_SUCCESS;
+				mad_send_wc.vendor_err = 0;
+				mad_send_wc.send_buf = &mad_send_wr->send_buf;
+				ib_mad_complete_send_wr(mad_send_wr,
+							&mad_send_wc);
+			}
 		}
 	} else {
 		mad_agent_priv->agent.recv_handler(&mad_agent_priv->agent, NULL,
@@ -2172,30 +2266,11 @@ static void adjust_timeout(struct ib_mad_agent_private *mad_agent_priv)
 static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
-	struct ib_mad_send_wr_private *temp_mad_send_wr;
-	struct list_head *list_item;
 	unsigned long delay;
 
 	mad_agent_priv = mad_send_wr->mad_agent_priv;
-	list_del(&mad_send_wr->agent_list);
-
 	delay = mad_send_wr->timeout;
-	mad_send_wr->timeout += jiffies;
-
-	if (delay) {
-		list_for_each_prev(list_item, &mad_agent_priv->wait_list) {
-			temp_mad_send_wr = list_entry(list_item,
-						struct ib_mad_send_wr_private,
-						agent_list);
-			if (time_after(mad_send_wr->timeout,
-				       temp_mad_send_wr->timeout))
-				break;
-		}
-	} else {
-		list_item = &mad_agent_priv->wait_list;
-	}
-
-	list_add(&mad_send_wr->agent_list, list_item);
+	change_mad_state(mad_send_wr, IB_MAD_STATE_WAIT_RESP);
 
 	/* Reschedule a work item if we have a shorter timeout */
 	if (mad_agent_priv->wait_list.next == &mad_send_wr->agent_list)
@@ -2229,27 +2304,20 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	} else
 		ret = IB_RMPP_RESULT_UNHANDLED;
 
-	if (mad_send_wc->status != IB_WC_SUCCESS &&
-	    mad_send_wr->status == IB_WC_SUCCESS) {
-		mad_send_wr->status = mad_send_wc->status;
-		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
-	}
-
-	if (--mad_send_wr->refcount > 0) {
-		if (mad_send_wr->refcount == 1 && mad_send_wr->timeout &&
-		    mad_send_wr->status == IB_WC_SUCCESS) {
-			wait_for_response(mad_send_wr);
-		}
+	if (mad_send_wr->state == IB_MAD_STATE_CANCELED)
+		mad_send_wc->status = IB_WC_WR_FLUSH_ERR;
+	else if (mad_send_wr->state == IB_MAD_STATE_SEND_START &&
+		 mad_send_wr->timeout) {
+		wait_for_response(mad_send_wr);
 		goto done;
 	}
 
 	/* Remove send from MAD agent and notify client of completion */
-	list_del(&mad_send_wr->agent_list);
+	if (mad_send_wr->state != IB_MAD_STATE_DONE)
+		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-	if (mad_send_wr->status != IB_WC_SUCCESS)
-		mad_send_wc->status = mad_send_wr->status;
 	if (ret == IB_RMPP_RESULT_INTERNAL)
 		ib_rmpp_send_handler(mad_send_wc);
 	else
@@ -2407,12 +2475,8 @@ static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
 
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
-				 &mad_agent_priv->send_list, agent_list) {
-		if (mad_send_wr->status == IB_WC_SUCCESS) {
-			mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
-			mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
-		}
-	}
+				 &mad_agent_priv->send_list, agent_list)
+		change_mad_state(mad_send_wr, IB_MAD_STATE_CANCELED);
 
 	/* Empty wait list to prevent receives from finding a request */
 	list_splice_init(&mad_agent_priv->wait_list, &cancel_list);
@@ -2468,16 +2532,15 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 				      struct ib_mad_agent_private, agent);
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	mad_send_wr = find_send_wr(mad_agent_priv, send_buf);
-	if (!mad_send_wr || mad_send_wr->status != IB_WC_SUCCESS) {
+	if (!mad_send_wr || mad_send_wr->state == IB_MAD_STATE_CANCELED) {
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 		return -EINVAL;
 	}
 
-	active = (!mad_send_wr->timeout || mad_send_wr->refcount > 1);
-	if (!timeout_ms) {
-		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
-		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
-	}
+	active = (mad_send_wr->state == IB_MAD_STATE_SEND_START ||
+		  mad_send_wr->state == IB_MAD_STATE_EARLY_RESP);
+	if (!timeout_ms)
+		change_mad_state(mad_send_wr, IB_MAD_STATE_CANCELED);
 
 	mad_send_wr->send_buf.timeout_ms = timeout_ms;
 	if (active)
@@ -2606,26 +2669,43 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 	} else
 		ret = ib_send_mad(mad_send_wr);
 
-	if (!ret) {
-		mad_send_wr->refcount++;
-		list_add_tail(&mad_send_wr->agent_list,
-			      &mad_send_wr->mad_agent_priv->send_list);
-	}
+	if (!ret)
+		change_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
+
 	return ret;
 }
 
-static void timeout_sends(struct work_struct *work)
+static void clear_mad_error_list(struct list_head *list,
+				 enum ib_wc_status wc_status,
+				 struct ib_mad_agent_private *mad_agent_priv)
 {
 	struct ib_mad_send_wr_private *mad_send_wr, *n;
-	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wc mad_send_wc;
-	struct list_head local_list;
+
+	mad_send_wc.status = wc_status;
+	mad_send_wc.vendor_err = 0;
+
+	list_for_each_entry_safe(mad_send_wr, n, list, agent_list) {
+		mad_send_wc.send_buf = &mad_send_wr->send_buf;
+		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
+						   &mad_send_wc);
+		deref_mad_agent(mad_agent_priv);
+	}
+}
+
+static void timeout_sends(struct work_struct *work)
+{
+	struct ib_mad_send_wr_private *mad_send_wr;
+	struct ib_mad_agent_private *mad_agent_priv;
+	struct list_head timeout_list;
+	struct list_head cancel_list;
+	struct list_head *list_item;
 	unsigned long flags, delay;
 
 	mad_agent_priv = container_of(work, struct ib_mad_agent_private,
 				      timed_work.work);
-	mad_send_wc.vendor_err = 0;
-	INIT_LIST_HEAD(&local_list);
+	INIT_LIST_HEAD(&timeout_list);
+	INIT_LIST_HEAD(&cancel_list);
 
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	while (!list_empty(&mad_agent_priv->wait_list)) {
@@ -2643,25 +2723,21 @@ static void timeout_sends(struct work_struct *work)
 			break;
 		}
 
-		list_del_init(&mad_send_wr->agent_list);
-		if (mad_send_wr->status == IB_WC_SUCCESS &&
-		    !retry_send(mad_send_wr))
+		if (mad_send_wr->state == IB_MAD_STATE_CANCELED)
+			list_item = &cancel_list;
+		else if (retry_send(mad_send_wr))
+			list_item = &timeout_list;
+		else
 			continue;
 
-		list_add_tail(&mad_send_wr->agent_list, &local_list);
+		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
+		list_add_tail(&mad_send_wr->agent_list, list_item);
 	}
-	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
-	list_for_each_entry_safe(mad_send_wr, n, &local_list, agent_list) {
-		if (mad_send_wr->status == IB_WC_SUCCESS)
-			mad_send_wc.status = IB_WC_RESP_TIMEOUT_ERR;
-		else
-			mad_send_wc.status = mad_send_wr->status;
-		mad_send_wc.send_buf = &mad_send_wr->send_buf;
-		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
-						   &mad_send_wc);
-		deref_mad_agent(mad_agent_priv);
-	}
+	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
+	clear_mad_error_list(&timeout_list, IB_WC_RESP_TIMEOUT_ERR,
+			     mad_agent_priv);
+	clear_mad_error_list(&cancel_list, IB_WC_WR_FLUSH_ERR, mad_agent_priv);
 }
 
 /*
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 1b7445a6f6714..bfcf0a62fdd65 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -96,7 +96,6 @@ struct ib_mad_agent_private {
 	spinlock_t lock;
 	struct list_head send_list;
 	struct list_head wait_list;
-	struct list_head done_list;
 	struct delayed_work timed_work;
 	unsigned long timeout;
 	struct list_head local_list;
@@ -118,6 +117,47 @@ struct ib_mad_snoop_private {
 	struct completion comp;
 };
 
+enum ib_mad_state {
+	/*
+	 * MAD was sent to the QP and is waiting for completion
+	 * notification in send list.
+	 */
+	IB_MAD_STATE_SEND_START = 1,
+	/*
+	 * MAD send completed successfully, waiting for a response
+	 * in wait list.
+	 */
+	IB_MAD_STATE_WAIT_RESP,
+	/*
+	 * Response came early, before send completion notification,
+	 * in send list.
+	 */
+	IB_MAD_STATE_EARLY_RESP,
+	/* MAD was canceled while in wait or send list */
+	IB_MAD_STATE_CANCELED,
+	/* MAD processing completed, MAD in no list */
+	IB_MAD_STATE_DONE
+};
+
+#define EXPECT_MAD_STATE(mad_send_wr, expected_state)                  \
+	{                                                              \
+		if (IS_ENABLED(CONFIG_LOCKDEP))                        \
+			WARN_ON(mad_send_wr->state != expected_state); \
+	}
+#define EXPECT_MAD_STATE3(mad_send_wr, expected_state1, expected_state2, \
+			  expected_state3)                               \
+	{                                                                \
+		if (IS_ENABLED(CONFIG_LOCKDEP))                          \
+			WARN_ON(mad_send_wr->state != expected_state1 && \
+				mad_send_wr->state != expected_state2 && \
+				mad_send_wr->state != expected_state3);  \
+	}
+#define NOT_EXPECT_MAD_STATE(mad_send_wr, wrong_state)              \
+	{                                                           \
+		if (IS_ENABLED(CONFIG_LOCKDEP))                     \
+			WARN_ON(mad_send_wr->state == wrong_state); \
+	}
+
 struct ib_mad_send_wr_private {
 	struct ib_mad_list_head mad_list;
 	struct list_head agent_list;
@@ -132,8 +172,6 @@ struct ib_mad_send_wr_private {
 	int max_retries;
 	int retries_left;
 	int retry;
-	int refcount;
-	enum ib_wc_status status;
 
 	/* RMPP control */
 	struct list_head rmpp_list;
@@ -143,6 +181,8 @@ struct ib_mad_send_wr_private {
 	int seg_num;
 	int newwin;
 	int pad;
+
+	enum ib_mad_state state;
 };
 
 struct ib_mad_local_private {
@@ -222,4 +262,7 @@ void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr);
 void ib_reset_mad_timeout(struct ib_mad_send_wr_private *mad_send_wr,
 			  unsigned long timeout_ms);
 
+void change_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
+		      enum ib_mad_state new_state);
+
 #endif	/* __IB_MAD_PRIV_H__ */
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 8af0619a39cda..a33842eac2215 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -608,16 +608,20 @@ static void abort_send(struct ib_mad_agent_private *agent,
 		goto out;	/* Unmatched send */
 
 	if ((mad_send_wr->last_ack == mad_send_wr->send_buf.seg_count) ||
-	    (!mad_send_wr->timeout) || (mad_send_wr->status != IB_WC_SUCCESS))
+	    (!mad_send_wr->timeout) ||
+	    (mad_send_wr->state == IB_MAD_STATE_CANCELED))
 		goto out;	/* Send is already done */
 
 	ib_mark_mad_done(mad_send_wr);
+	if (mad_send_wr->state == IB_MAD_STATE_DONE) {
+		spin_unlock_irqrestore(&agent->lock, flags);
+		wc.status = IB_WC_REM_ABORT_ERR;
+		wc.vendor_err = rmpp_status;
+		wc.send_buf = &mad_send_wr->send_buf;
+		ib_mad_complete_send_wr(mad_send_wr, &wc);
+		return;
+	}
 	spin_unlock_irqrestore(&agent->lock, flags);
-
-	wc.status = IB_WC_REM_ABORT_ERR;
-	wc.vendor_err = rmpp_status;
-	wc.send_buf = &mad_send_wr->send_buf;
-	ib_mad_complete_send_wr(mad_send_wr, &wc);
 	return;
 out:
 	spin_unlock_irqrestore(&agent->lock, flags);
@@ -684,7 +688,8 @@ static void process_rmpp_ack(struct ib_mad_agent_private *agent,
 	}
 
 	if ((mad_send_wr->last_ack == mad_send_wr->send_buf.seg_count) ||
-	    (!mad_send_wr->timeout) || (mad_send_wr->status != IB_WC_SUCCESS))
+	    (!mad_send_wr->timeout) ||
+	    (mad_send_wr->state == IB_MAD_STATE_CANCELED))
 		goto out;	/* Send is already done */
 
 	if (seg_num > mad_send_wr->send_buf.seg_count ||
@@ -709,21 +714,24 @@ static void process_rmpp_ack(struct ib_mad_agent_private *agent,
 			struct ib_mad_send_wc wc;
 
 			ib_mark_mad_done(mad_send_wr);
+			if (mad_send_wr->state == IB_MAD_STATE_DONE) {
+				spin_unlock_irqrestore(&agent->lock, flags);
+				wc.status = IB_WC_SUCCESS;
+				wc.vendor_err = 0;
+				wc.send_buf = &mad_send_wr->send_buf;
+				ib_mad_complete_send_wr(mad_send_wr, &wc);
+				return;
+			}
 			spin_unlock_irqrestore(&agent->lock, flags);
-
-			wc.status = IB_WC_SUCCESS;
-			wc.vendor_err = 0;
-			wc.send_buf = &mad_send_wr->send_buf;
-			ib_mad_complete_send_wr(mad_send_wr, &wc);
 			return;
 		}
-		if (mad_send_wr->refcount == 1)
+		if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
 			ib_reset_mad_timeout(mad_send_wr,
 					     mad_send_wr->send_buf.timeout_ms);
 		spin_unlock_irqrestore(&agent->lock, flags);
 		ack_ds_ack(agent, mad_recv_wc);
 		return;
-	} else if (mad_send_wr->refcount == 1 &&
+	} else if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP &&
 		   mad_send_wr->seg_num < mad_send_wr->newwin &&
 		   mad_send_wr->seg_num < mad_send_wr->send_buf.seg_count) {
 		/* Send failure will just result in a timeout/retry */
@@ -731,7 +739,7 @@ static void process_rmpp_ack(struct ib_mad_agent_private *agent,
 		if (ret)
 			goto out;
 
-		mad_send_wr->refcount++;
+		change_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
 		list_move_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->send_list);
 	}
@@ -890,7 +898,6 @@ int ib_send_rmpp_mad(struct ib_mad_send_wr_private *mad_send_wr)
 	mad_send_wr->newwin = init_newwin(mad_send_wr);
 
 	/* We need to wait for the final ACK even if there isn't a response */
-	mad_send_wr->refcount += (mad_send_wr->timeout == 0);
 	ret = send_next_seg(mad_send_wr);
 	if (!ret)
 		return IB_RMPP_RESULT_CONSUMED;
@@ -912,7 +919,7 @@ int ib_process_rmpp_send_wc(struct ib_mad_send_wr_private *mad_send_wr,
 		return IB_RMPP_RESULT_INTERNAL;	 /* ACK, STOP, or ABORT */
 
 	if (mad_send_wc->status != IB_WC_SUCCESS ||
-	    mad_send_wr->status != IB_WC_SUCCESS)
+	    mad_send_wr->state == IB_MAD_STATE_CANCELED)
 		return IB_RMPP_RESULT_PROCESSED; /* Canceled or send error */
 
 	if (!mad_send_wr->timeout)
-- 
2.47.1


