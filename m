Return-Path: <linux-rdma+bounces-6198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7593A9E1E3F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351B2286DF8
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF751F12E3;
	Tue,  3 Dec 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2DxtKh5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A72D1F428D
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233956; cv=none; b=U+jqrv+V+cKje4SoUpCoIrnCfzgIui65JtI6roibAIS1e6rESDihL3J7BnZs2UGlrPR15nLyB2RAfd6XU4CKnbfTYlS3oFmbfwu88O3fU1zyXqASZ74DBKkuQ0vW9/AysAWH71VKVJ9ly626x+0mhp9bHnBnUdlHxxvu/+p8y/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233956; c=relaxed/simple;
	bh=qdu+lJ2t9U1QfT25byKfVqwO3HADgk7NtGQMnVfZLF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QR9LM0F35X365XZTBJ2kU1vAQtKQyGKjPNbapavJHdPCHYApB4MBF2JwQjaEL9I9FjTdl/2oNc6hv8IrZK0kff5gEpp4mFdC5S5nnzGj5UuCDiBF0ujwYLQ/mcKilivARePQx9AIilpDNsOaOTE8QEL7r5+Xf6pfW7p2bKnuIHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2DxtKh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA06CC4CED6;
	Tue,  3 Dec 2024 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233956;
	bh=qdu+lJ2t9U1QfT25byKfVqwO3HADgk7NtGQMnVfZLF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J2DxtKh5UwfSro0dsI8/tAUphkSjTmJlY/ZyKUibffzDydMmfm9ii2thBYRsBxwhI
	 /RiSuoUZXDOjazYyfxGlmZP+WohuoblBhrIQ53IJwJdMf27UN7kwz42jONP3m0jGdx
	 6nKFp3LF0kaGmxdfSuxB6QHncZ/eOpkX+b0hFdPpNGROP4iZ8/8pRDGlX9OTSpZZ2f
	 rOLf7pt+BYp+ShG/c971JDrLG/PcLM0rsSfP5NaapCy4iMY12HgyiMEkYA+xzebnDj
	 3ohT8Rex4YPfypJ6WS3TzMZ3DDFbpmoKl6ZftBhV78c1LDdUUYqsX0bRCCQjBAaC93
	 q8DfheL4HqOuA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 1/3] IB/mad: Replace MAD's refcount with a state machine
Date: Tue,  3 Dec 2024 15:52:21 +0200
Message-ID: <b6b991b75a7d8cce465a6c917ef0db1c264165bd.1733233636.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1733233636.git.leonro@nvidia.com>
References: <cover.1733233636.git.leonro@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Or Har-Toov <ohartoov@nvidia.com>

Replace the refcount mechanism with a 'state' field to track the status
of MADs send work requests (WRs). The state machine better represents
the stages in the MAD lifecycle, specifically indicating whether the
MAD is waiting for a response or a completion.

The existing refcount only takes two values:
 * 1 - MAD is waiting either for completion or for response.
 * 2 - MAD is waiting for both response and completion. Also when a
   response was received before a completion notification.

The current state transitions are not clearly visible, and developers
needs to infer the state from the refcount's value, which is
error-prone and difficult to follow.

Thus, replace with a state machine as the following:
 * IB_MAD_STATE_SEND_START - MAD was sent to the QP and is waiting
   for completion notification
 * IB_MAD_STATE_WAIT_RESP - MAD send completed successfully, waiting
   for a response
 * IB_MAD_STATE_EARLY_RESP - Response came early, before send
   completion notification
 * IB_MAD_STATE_DONE - MAD processing completed

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 44 ++++++++++++++----------------
 drivers/infiniband/core/mad_priv.h | 10 ++++++-
 drivers/infiniband/core/mad_rmpp.c |  7 ++---
 3 files changed, 33 insertions(+), 28 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 1fd54d5c4dd8..9b101f91ca3e 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1118,8 +1118,7 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		mad_send_wr->max_retries = send_buf->retries;
 		mad_send_wr->retries_left = send_buf->retries;
 		send_buf->retries = 0;
-		/* Reference for work request to QP + response */
-		mad_send_wr->refcount = 1 + (mad_send_wr->timeout > 0);
+		mad_send_wr->state = IB_MAD_STATE_SEND_START;
 		mad_send_wr->status = IB_WC_SUCCESS;
 
 		/* Reference MAD agent until send completes */
@@ -1773,9 +1772,13 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	mad_send_wr->timeout = 0;
-	if (mad_send_wr->refcount == 1)
+	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP) {
+		mad_send_wr->state = IB_MAD_STATE_DONE;
 		list_move_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->done_list);
+	} else {
+		mad_send_wr->state = IB_MAD_STATE_EARLY_RESP;
+	}
 }
 
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
@@ -2195,6 +2198,7 @@ static void wait_for_response(struct ib_mad_send_wr_private *mad_send_wr)
 		list_item = &mad_agent_priv->wait_list;
 	}
 
+	mad_send_wr->state = IB_MAD_STATE_WAIT_RESP;
 	list_add(&mad_send_wr->agent_list, list_item);
 
 	/* Reschedule a work item if we have a shorter timeout */
@@ -2222,6 +2226,11 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 
 	mad_agent_priv = mad_send_wr->mad_agent_priv;
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
+	if (mad_send_wr->state == IB_MAD_STATE_EARLY_RESP) {
+		mad_send_wr->state = IB_MAD_STATE_DONE;
+		goto done;
+	}
+
 	if (ib_mad_kernel_rmpp_agent(&mad_agent_priv->agent)) {
 		ret = ib_process_rmpp_send_wc(mad_send_wr, mad_send_wc);
 		if (ret == IB_RMPP_RESULT_CONSUMED)
@@ -2232,14 +2241,10 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	if (mad_send_wc->status != IB_WC_SUCCESS &&
 	    mad_send_wr->status == IB_WC_SUCCESS) {
 		mad_send_wr->status = mad_send_wc->status;
-		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
-	}
-
-	if (--mad_send_wr->refcount > 0) {
-		if (mad_send_wr->refcount == 1 && mad_send_wr->timeout &&
-		    mad_send_wr->status == IB_WC_SUCCESS) {
-			wait_for_response(mad_send_wr);
-		}
+	} else if (mad_send_wr->status == IB_WC_SUCCESS &&
+		   mad_send_wr->timeout &&
+		   mad_send_wr->state == IB_MAD_STATE_SEND_START) {
+		wait_for_response(mad_send_wr);
 		goto done;
 	}
 
@@ -2407,12 +2412,9 @@ static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
 
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	list_for_each_entry_safe(mad_send_wr, temp_mad_send_wr,
-				 &mad_agent_priv->send_list, agent_list) {
-		if (mad_send_wr->status == IB_WC_SUCCESS) {
+				 &mad_agent_priv->send_list, agent_list)
+		if (mad_send_wr->status == IB_WC_SUCCESS)
 			mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
-			mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
-		}
-	}
 
 	/* Empty wait list to prevent receives from finding a request */
 	list_splice_init(&mad_agent_priv->wait_list, &cancel_list);
@@ -2459,7 +2461,6 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
 	unsigned long flags;
-	int active;
 
 	if (!send_buf)
 		return -EINVAL;
@@ -2473,14 +2474,11 @@ int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 		return -EINVAL;
 	}
 
-	active = (!mad_send_wr->timeout || mad_send_wr->refcount > 1);
-	if (!timeout_ms) {
+	if (!timeout_ms)
 		mad_send_wr->status = IB_WC_WR_FLUSH_ERR;
-		mad_send_wr->refcount -= (mad_send_wr->timeout > 0);
-	}
 
 	mad_send_wr->send_buf.timeout_ms = timeout_ms;
-	if (active)
+	if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
 		mad_send_wr->timeout = msecs_to_jiffies(timeout_ms);
 	else
 		ib_reset_mad_timeout(mad_send_wr, timeout_ms);
@@ -2607,7 +2605,7 @@ static int retry_send(struct ib_mad_send_wr_private *mad_send_wr)
 		ret = ib_send_mad(mad_send_wr);
 
 	if (!ret) {
-		mad_send_wr->refcount++;
+		mad_send_wr->state = IB_MAD_STATE_SEND_START;
 		list_add_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->send_list);
 	}
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 1b7445a6f671..cc2de81ea6f6 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -118,6 +118,13 @@ struct ib_mad_snoop_private {
 	struct completion comp;
 };
 
+enum ib_mad_state {
+	IB_MAD_STATE_SEND_START,
+	IB_MAD_STATE_WAIT_RESP,
+	IB_MAD_STATE_EARLY_RESP,
+	IB_MAD_STATE_DONE
+};
+
 struct ib_mad_send_wr_private {
 	struct ib_mad_list_head mad_list;
 	struct list_head agent_list;
@@ -132,7 +139,6 @@ struct ib_mad_send_wr_private {
 	int max_retries;
 	int retries_left;
 	int retry;
-	int refcount;
 	enum ib_wc_status status;
 
 	/* RMPP control */
@@ -143,6 +149,8 @@ struct ib_mad_send_wr_private {
 	int seg_num;
 	int newwin;
 	int pad;
+
+	enum ib_mad_state state;
 };
 
 struct ib_mad_local_private {
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 8af0619a39cd..dff264e9bb68 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -717,13 +717,13 @@ static void process_rmpp_ack(struct ib_mad_agent_private *agent,
 			ib_mad_complete_send_wr(mad_send_wr, &wc);
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
@@ -731,7 +731,7 @@ static void process_rmpp_ack(struct ib_mad_agent_private *agent,
 		if (ret)
 			goto out;
 
-		mad_send_wr->refcount++;
+		mad_send_wr->state = IB_MAD_STATE_SEND_START;
 		list_move_tail(&mad_send_wr->agent_list,
 			      &mad_send_wr->mad_agent_priv->send_list);
 	}
@@ -890,7 +890,6 @@ int ib_send_rmpp_mad(struct ib_mad_send_wr_private *mad_send_wr)
 	mad_send_wr->newwin = init_newwin(mad_send_wr);
 
 	/* We need to wait for the final ACK even if there isn't a response */
-	mad_send_wr->refcount += (mad_send_wr->timeout == 0);
 	ret = send_next_seg(mad_send_wr);
 	if (!ret)
 		return IB_RMPP_RESULT_CONSUMED;
-- 
2.47.0


