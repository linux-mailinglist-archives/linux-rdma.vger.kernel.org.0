Return-Path: <linux-rdma+bounces-6200-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBD69E1E40
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 14:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12621286CD1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 13:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2771F130E;
	Tue,  3 Dec 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4Pq/9FR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3324F1F130D
	for <linux-rdma@vger.kernel.org>; Tue,  3 Dec 2024 13:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233965; cv=none; b=K0JQC5kTIoJQjrX3T3NdD4hhUSJZSQQ4CLBNse5SRW7CPoqVgK7Bqr4wjExZazgPVKO18S11McGmrQko1slJjCaoMx7qINRmWuGUQ0Nn2uzPkkvugrClXZDVFkNkQ3u1GmEYYLcTcvoAMVWPG85hoHNiMsiFWXuV77ixCbPiJGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233965; c=relaxed/simple;
	bh=vnc+rnhaHHzPgpDZnrmLNuG5NfWVJjfLpQ/Esp0FkHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqniJQDsghD6qvTW9cnSEfa3Dnl3ESS1xelDwmbZMmgXvmYq891Te5ZWpKNSeDwbPvxqEnEnl8ADT9UjKl/uhRc/NsNdtNH7StwTI2kX3MPmWrIhFadZJBVY2stCL+Lu5uqJfcePZhSPotn2GZwuj1isGDlJOoXGPTCEY0k5BfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4Pq/9FR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E25AC4CED6;
	Tue,  3 Dec 2024 13:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733233964;
	bh=vnc+rnhaHHzPgpDZnrmLNuG5NfWVJjfLpQ/Esp0FkHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G4Pq/9FRzL4l2eR8CtJBXei/jXyy8dbsTVMB/qq7OLZiZ77IEObXhc01u6kL63dkU
	 CrxmXiCtI9AoTjREjXXX0zL/hr7GVEcgkHYgwHrh/DK2iwDGaql089lmomKYvz2kbo
	 P7zG9EzKwNO4W2IBvKJAYjopXNxZEPLpGzP0XjdnMCN/TS9YnmdYhc0SB2oPIyZjou
	 J8xi647csXnDjiYg6RR12b2342DGsZMZanOvujDj77mipz8SuAgZEnCQpyrzlv0Oei
	 qS7++70COZJN87FT+unbdtEC7TbV2dEj3Do+DxIWId2mFMXfWFXGTSdkT1FDkBYSE3
	 DzFonYk6DhzBQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Or Har-Toov <ohartoov@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maher Sanalla <msanalla@nvidia.com>
Subject: [PATCH rdma-next 2/3] IB/mad: Remove unnecessary done list by utilizing MAD states
Date: Tue,  3 Dec 2024 15:52:22 +0200
Message-ID: <8f746ee2eac86138b1051908b95a21fdff24af6c.1733233636.git.leonro@nvidia.com>
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

Remove the done list, which has become unnecessary with the
introduction of the `state` parameter.

Previously, the done list was used to ensure that MADs removed from
the wait list would still be in some list, preventing failures in
the call to `list_del` in `ib_mad_complete_send_wr`. However, with the
new state management, we can mark a MAD as done when it is completed
and simply not delete those MADs.

Removing the done list eliminates unnecessary memory usage and
simplifies the code.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/mad.c      | 13 ++++++-------
 drivers/infiniband/core/mad_priv.h |  1 -
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 9b101f91ca3e..e16bc396f6bc 100644
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
@@ -1772,13 +1771,11 @@ ib_find_send_mad(const struct ib_mad_agent_private *mad_agent_priv,
 void ib_mark_mad_done(struct ib_mad_send_wr_private *mad_send_wr)
 {
 	mad_send_wr->timeout = 0;
-	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP) {
+	list_del(&mad_send_wr->agent_list);
+	if (mad_send_wr->state == IB_MAD_STATE_WAIT_RESP)
 		mad_send_wr->state = IB_MAD_STATE_DONE;
-		list_move_tail(&mad_send_wr->agent_list,
-			      &mad_send_wr->mad_agent_priv->done_list);
-	} else {
+	else
 		mad_send_wr->state = IB_MAD_STATE_EARLY_RESP;
-	}
 }
 
 static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
@@ -2249,7 +2246,9 @@ void ib_mad_complete_send_wr(struct ib_mad_send_wr_private *mad_send_wr,
 	}
 
 	/* Remove send from MAD agent and notify client of completion */
-	list_del(&mad_send_wr->agent_list);
+	if (mad_send_wr->state == IB_MAD_STATE_SEND_START)
+		list_del(&mad_send_wr->agent_list);
+
 	adjust_timeout(mad_agent_priv);
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
 
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index cc2de81ea6f6..4af63c1664c2 100644
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
-- 
2.47.0


