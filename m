Return-Path: <linux-rdma+bounces-11754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1804AED994
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 12:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A93783AF24C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 10:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332D25A655;
	Mon, 30 Jun 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JElkPPUm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639012580FB
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 10:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751278628; cv=none; b=nrDmgEbKJ4JQJ0j5GxQ/n9L0BQhByMTGvYmHFNAL6MVHgbiRdEpOBzU8oZwPuHH3GyAAycDElxQe94MzxfOolQtU2Po0/KLL9M+FaTDWHdOlSxEbfg2JcbHnzaQhLJjT5L9tiLtp7tLlGGPN8QF4WL/dfQUHukrnu+Wn0kYtaZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751278628; c=relaxed/simple;
	bh=q3m6T9Bkjn1REErUPulIE9Jwm7IUv7ZXVxRtwV0u5Pc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJd7jeyrkZKXnAfSuzo59/6dknBPhUrGcINDqeY0fYTN6xAF1Kjllfvgyz2BtqklkyNGxhOwLjp+HXo5FrtAXoyGXa5V27hswvMskYWgfj2hhF61UtyOiRgOESeR6jVi485CtkU6jwQn+g4Ma113DIvGda+UCy3r7oYqwa+z0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JElkPPUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA90C4CEE3;
	Mon, 30 Jun 2025 10:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751278628;
	bh=q3m6T9Bkjn1REErUPulIE9Jwm7IUv7ZXVxRtwV0u5Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JElkPPUmy6autXjvYt4WgYt3Tx6YYTYuVQUFghBqoacKKTRj+p22iafg77PRUTmxQ
	 itBKrlFX++XjP+eS+liMAaXODfCdckG6skyoiD6vMf2PQuk79QorephqqqtqoimWgf
	 l3u3gLiAz2A8ygb4tWpuU6u+RP0rO7jYVcD+Q6sxSHLnXLLNee5bEyQCO/5+gL4D6X
	 bJkQw+eUyP4j4bQ7WCpEGCugY46iJScra5Pt8OWY4uMJyJCQGkJa8vo3qkM0bkybXk
	 35fM+xgvEEgpDYRhphWfYmkWPgfDYlR9FqovByhTP/XzG52bkHYT+/isMpJLfejE7Q
	 27zCKKfTqCelg==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: [PATCH rdma-next v2 1/3] IB/mad: Add state machine to MAD layer
Date: Mon, 30 Jun 2025 13:16:42 +0300
Message-ID: <48e6ae8689dc7bb8b4ba6e5ec562e1b018db88a8.1751278420.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751278420.git.leon@kernel.org>
References: <cover.1751278420.git.leon@kernel.org>
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
- 'IB_MAD_STATE_INIT': MAD is in the making and is not yet in any list
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
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 271 ++++++++++++++++++-----------
 drivers/infiniband/core/mad_priv.h |  58 +++++-
 drivers/infiniband/core/mad_rmpp.c |  41 +++--
 3 files changed, 250 insertions(+), 120 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 73f3a0b9a54b..eb2d63dff638 100644
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
@@ -1055,6 +1054,100 @@ int ib_send_mad(struct ib_mad_send_wr_private *mad_send_wr)
 	return ret;
 }
 
+static void handle_send_state(struct ib_mad_send_wr_private *mad_send_wr,
+		       struct ib_mad_agent_private *mad_agent_priv)
+{
+	if (mad_send_wr->state == IB_MAD_STATE_INIT) {
+		list_add_tail(&mad_send_wr->agent_list,
+			      &mad_agent_priv->send_list);
+	} else {
+		expect_mad_state(mad_send_wr, IB_MAD_STATE_WAIT_RESP);
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
+	expect_mad_state3(mad_send_wr, IB_MAD_STATE_SEND_START,
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
+	expect_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
+}
+
+static void handle_canceled_state(struct ib_mad_send_wr_private *mad_send_wr,
+			 struct ib_mad_agent_private *mad_agent_priv)
+{
+	not_expect_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
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
+	case IB_MAD_STATE_INIT:
+		break;
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
@@ -1118,15 +1211,12 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		mad_send_wr->max_retries = send_buf->retries;
 		mad_send_wr->retries_left = send_buf->retries;
 		send_buf->retries = 0;
-		/* Reference for work request to QP + response */
-		mad_send_wr->refcount = 1 + (mad_send_wr->timeout > 0);
-		mad_send_wr->status = IB_WC_SUCCESS;
+		change_mad_state(mad_send_wr, IB_MAD_STATE_INIT);
 
 		/* Reference MAD agent until send completes */
 		refcount_inc(&mad_agent_priv->refcount);
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		list_add_tail(&mad_send_wr->agent_list,
-			      &mad_agent_priv->send_list);
+		change_mad_state(mad_send_wr, IB_MAD_STATE_SEND_START);
 		spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 		if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {
@@ -1138,7 +1228,7 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		if (ret < 0) {
 			/* Fail send request */
 			spin_lock_irqsave(&mad_agent_priv->lock, flags);
-			list_del(&mad_send_wr->agent_list);
+			change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 			deref_mad_agent(mad_agent_priv);
 			goto error;
@@ -1746,7 +1836,7 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 		     */
 		    (is_direct(mad_hdr->mgmt_class) ||
 		     rcv_has_same_gid(mad_agent_priv, wr, wc)))
-			return (wr->status == IB_WC_SUCCESS) ? wr : NULL;
+			return (wr->state != IB_MAD_STATE_CANCELED) ? wr : NULL;
 	}
 
 	/*
@@ -1765,7 +1855,7 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 		    (is_direct(mad_hdr->mgmt_class) ||
 		     rcv_has_same_gid(mad_agent_priv, wr, wc)))
 			/* Verify request has not been canceled */
-			return (wr->status == IB_WC_SUCCESS) ? wr : NULL;
+			return (wr->state != IB_MAD_STATE_CANCELED) ? wr : NULL;
 	}
 	return NULL;
 }
@@ -1773,9 +1863,10 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
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
@@ -1784,6 +1875,7 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_send_wc mad_send_wc;
 	unsigned long flags;
+	bool is_mad_done;
 	int ret;
 
 	INIT_LIST_HEAD(&mad_recv_wc->rmpp_list);
@@ -1832,6 +1924,7 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 			}
 		} else {
 			ib_mark_mad_done(mad_send_wr);
+			is_mad_done = (mad_send_wr->state == IB_MAD_STATE_DONE);
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 			/* Defined behavior is to complete response before request */
@@ -1841,10 +1934,13 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
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
@@ -2172,30 +2268,11 @@ static void adjust_timeout(struct ib_mad_agent_private *mad_agent_priv)
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
@@ -2229,27 +2306,20 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
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
@@ -2396,40 +2466,47 @@ static bool ib_mad_send_error(struct ib_mad_port_private *port_priv,
 	return true;
 }
 
+static void clear_mad_error_list(struct list_head *list,
+				 enum ib_wc_status wc_status,
+				 struct ib_mad_agent_private *mad_agent_priv)
+{
+	struct ib_mad_send_wr_private *mad_send_wr, *n;
+	struct ib_mad_send_wc mad_send_wc;
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
 static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
 {
 	unsigned long flags;
 	struct ib_mad_send_wr_private *mad_send_wr, *temp_mad_send_wr;
-	struct ib_mad_send_wc mad_send_wc;
 	struct list_head cancel_list;
 
 	INIT_LIST_HEAD(&cancel_list);
 
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
-	list_splice_init(&mad_agent_priv->wait_list, &cancel_list);
+	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
+				 &mad_agent_priv->wait_list, agent_list) {
+		change_mad_state(mad_send_wr, IB_MAD_STATE_DONE);
+		list_add_tail(&mad_send_wr->agent_list, &cancel_list);
+	}
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
 	/* Report all cancelled requests */
-	mad_send_wc.status = IB_WC_WR_FLUSH_ERR;
-	mad_send_wc.vendor_err = 0;
-
-	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
-				 &cancel_list, agent_list) {
-		mad_send_wc.send_buf = &mad_send_wr->send_buf;
-		list_del(&mad_send_wr->agent_list);
-		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
-						   &mad_send_wc);
-		deref_mad_agent(mad_agent_priv);
-	}
+	clear_mad_error_list(&cancel_list, IB_WC_WR_FLUSH_ERR, mad_agent_priv);
 }
 
 static struct ib_mad_send_wr_private*
@@ -2468,16 +2545,15 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
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
@@ -2606,26 +2682,25 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
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
 
 static void timeout_sends(struct work_struct *work)
 {
-	struct ib_mad_send_wr_private *mad_send_wr, *n;
+	struct ib_mad_send_wr_private *mad_send_wr;
 	struct ib_mad_agent_private *mad_agent_priv;
-	struct ib_mad_send_wc mad_send_wc;
-	struct list_head local_list;
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
@@ -2643,25 +2718,21 @@ static void timeout_sends(struct work_struct *work)
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
index 1b7445a6f671..3534be20496d 100644
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
@@ -118,6 +117,30 @@ struct ib_mad_snoop_private {
 	struct completion comp;
 };
 
+enum ib_mad_state {
+	/* MAD is in the making and is not yet in any list */
+	IB_MAD_STATE_INIT,
+	/*
+	 * MAD was sent to the QP and is waiting for completion
+	 * notification in send list.
+	 */
+	IB_MAD_STATE_SEND_START,
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
 struct ib_mad_send_wr_private {
 	struct ib_mad_list_head mad_list;
 	struct list_head agent_list;
@@ -132,8 +155,6 @@ struct ib_mad_send_wr_private {
 	int max_retries;
 	int retries_left;
 	int retry;
-	int refcount;
-	enum ib_wc_status status;
 
 	/* RMPP control */
 	struct list_head rmpp_list;
@@ -143,8 +164,36 @@ struct ib_mad_send_wr_private {
 	int seg_num;
 	int newwin;
 	int pad;
+
+	enum ib_mad_state state;
 };
 
+static inline void expect_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
+				    enum ib_mad_state expected_state)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		WARN_ON(mad_send_wr->state != expected_state);
+}
+
+static inline void expect_mad_state3(struct ib_mad_send_wr_private *mad_send_wr,
+				     enum ib_mad_state expected_state1,
+				     enum ib_mad_state expected_state2,
+				     enum ib_mad_state expected_state3)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		WARN_ON(mad_send_wr->state != expected_state1 &&
+			mad_send_wr->state != expected_state2 &&
+			mad_send_wr->state != expected_state3);
+}
+
+static inline void
+not_expect_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
+		     enum ib_mad_state wrong_state)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP))
+		WARN_ON(mad_send_wr->state == wrong_state);
+}
+
 struct ib_mad_local_private {
 	struct list_head completion_list;
 	struct ib_mad_private *mad_priv;
@@ -222,4 +271,7 @@ void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr);
 void ib_reset_mad_timeout(struct ib_mad_send_wr_private *mad_send_wr,
 			  unsigned long timeout_ms);
 
+void change_mad_state(struct ib_mad_send_wr_private *mad_send_wr,
+		      enum ib_mad_state new_state);
+
 #endif	/* __IB_MAD_PRIV_H__ */
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index b4b10e8a6495..1c5e0eaf1c94 100644
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
2.50.0


