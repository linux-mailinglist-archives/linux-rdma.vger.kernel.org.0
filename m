Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B535202A1F
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgFUKru (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 06:47:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKru (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 06:47:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146A5248CA;
        Sun, 21 Jun 2020 10:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592736469;
        bh=2CWH18vQ4kMec0FyCxPpyV4msffY4Dkyuusv7jra5LA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZfGHNzON6UaDNHbkio/5oDarq90C40+q+BWBU58zT2yWSHvPDBWDdrnrCFjXyJTGk
         UD3DqS6fvt3KlTeMdNm+SEUvEYCfkgMi3vUeE6WcYqnuv68eshLf7A+ACriGO9wYY8
         PkPB8jdQXUpkF7Z4eXaTu2DF6nNh3J83mmLMCPCE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Shay Drory <shayd@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 3/4] IB/mad: Refactor atomics API to refcount API
Date:   Sun, 21 Jun 2020 13:47:37 +0300
Message-Id: <20200621104738.54850-4-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200621104738.54850-1-leon@kernel.org>
References: <20200621104738.54850-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@mellanox.com>

Refcount API provides better safety than atomics API.
Therefore, refactor atomic functions to refcount functions.

Signed-off-by: Shay Drory <shayd@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad.c      | 16 ++++++++--------
 drivers/infiniband/core/mad_priv.h |  2 +-
 drivers/infiniband/core/mad_rmpp.c | 10 +++++-----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 46f36acb6a44..239ec5c49721 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -402,7 +402,7 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
 	INIT_DELAYED_WORK(&mad_agent_priv->timed_work, timeout_sends);
 	INIT_LIST_HEAD(&mad_agent_priv->local_list);
 	INIT_WORK(&mad_agent_priv->local_work, local_completions);
-	atomic_set(&mad_agent_priv->refcount, 1);
+	refcount_set(&mad_agent_priv->refcount, 1);
 	init_completion(&mad_agent_priv->comp);
 
 	ret2 = ib_mad_agent_security_setup(&mad_agent_priv->agent, qp_type);
@@ -484,7 +484,7 @@ EXPORT_SYMBOL(ib_register_mad_agent);
 
 static inline void deref_mad_agent(struct ib_mad_agent_private *mad_agent_priv)
 {
-	if (atomic_dec_and_test(&mad_agent_priv->refcount))
+	if (refcount_dec_and_test(&mad_agent_priv->refcount))
 		complete(&mad_agent_priv->comp);
 }
 
@@ -718,7 +718,7 @@ static int handle_outgoing_dr_smp(struct ib_mad_agent_private *mad_agent_priv,
 			 * Reference MAD agent until receive
 			 * side of local completion handled
 			 */
-			atomic_inc(&mad_agent_priv->refcount);
+			refcount_inc(&mad_agent_priv->refcount);
 		} else
 			kfree(mad_priv);
 		break;
@@ -758,7 +758,7 @@ static int handle_outgoing_dr_smp(struct ib_mad_agent_private *mad_agent_priv,
 		local->return_wc_byte_len = mad_size;
 	}
 	/* Reference MAD agent until send side of local completion handled */
-	atomic_inc(&mad_agent_priv->refcount);
+	refcount_inc(&mad_agent_priv->refcount);
 	/* Queue local completion to local list */
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	list_add_tail(&local->completion_list, &mad_agent_priv->local_list);
@@ -916,7 +916,7 @@ struct ib_mad_send_buf * ib_create_send_mad(struct ib_mad_agent *mad_agent,
 	}
 
 	mad_send_wr->send_buf.mad_agent = mad_agent;
-	atomic_inc(&mad_agent_priv->refcount);
+	refcount_inc(&mad_agent_priv->refcount);
 	return &mad_send_wr->send_buf;
 }
 EXPORT_SYMBOL(ib_create_send_mad);
@@ -1131,7 +1131,7 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 		mad_send_wr->status = IB_WC_SUCCESS;
 
 		/* Reference MAD agent until send completes */
-		atomic_inc(&mad_agent_priv->refcount);
+		refcount_inc(&mad_agent_priv->refcount);
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
 		list_add_tail(&mad_send_wr->agent_list,
 			      &mad_agent_priv->send_list);
@@ -1554,7 +1554,7 @@ find_mad_agent(struct ib_mad_port_private *port_priv,
 		hi_tid = be64_to_cpu(mad_hdr->tid) >> 32;
 		rcu_read_lock();
 		mad_agent = xa_load(&ib_mad_clients, hi_tid);
-		if (mad_agent && !atomic_inc_not_zero(&mad_agent->refcount))
+		if (mad_agent && !refcount_inc_not_zero(&mad_agent->refcount))
 			mad_agent = NULL;
 		rcu_read_unlock();
 	} else {
@@ -1606,7 +1606,7 @@ find_mad_agent(struct ib_mad_port_private *port_priv,
 			}
 		}
 		if (mad_agent)
-			atomic_inc(&mad_agent->refcount);
+			refcount_inc(&mad_agent->refcount);
 out:
 		spin_unlock_irqrestore(&port_priv->reg_lock, flags);
 	}
diff --git a/drivers/infiniband/core/mad_priv.h b/drivers/infiniband/core/mad_priv.h
index 403d8673a2f9..4aa16b35dad0 100644
--- a/drivers/infiniband/core/mad_priv.h
+++ b/drivers/infiniband/core/mad_priv.h
@@ -103,7 +103,7 @@ struct ib_mad_agent_private {
 	struct work_struct local_work;
 	struct list_head rmpp_list;
 
-	atomic_t refcount;
+	refcount_t refcount;
 	union {
 		struct completion comp;
 		struct rcu_head rcu;
diff --git a/drivers/infiniband/core/mad_rmpp.c b/drivers/infiniband/core/mad_rmpp.c
index 5ec57abc0849..1bc9dfecae70 100644
--- a/drivers/infiniband/core/mad_rmpp.c
+++ b/drivers/infiniband/core/mad_rmpp.c
@@ -52,7 +52,7 @@ struct mad_rmpp_recv {
 	struct completion comp;
 	enum rmpp_state state;
 	spinlock_t lock;
-	atomic_t refcount;
+	refcount_t refcount;
 
 	struct ib_ah *ah;
 	struct ib_mad_recv_wc *rmpp_wc;
@@ -73,7 +73,7 @@ struct mad_rmpp_recv {
 
 static inline void deref_rmpp_recv(struct mad_rmpp_recv *rmpp_recv)
 {
-	if (atomic_dec_and_test(&rmpp_recv->refcount))
+	if (refcount_dec_and_test(&rmpp_recv->refcount))
 		complete(&rmpp_recv->comp);
 }
 
@@ -305,7 +305,7 @@ create_rmpp_recv(struct ib_mad_agent_private *agent,
 	INIT_DELAYED_WORK(&rmpp_recv->cleanup_work, recv_cleanup_handler);
 	spin_lock_init(&rmpp_recv->lock);
 	rmpp_recv->state = RMPP_STATE_ACTIVE;
-	atomic_set(&rmpp_recv->refcount, 1);
+	refcount_set(&rmpp_recv->refcount, 1);
 
 	rmpp_recv->rmpp_wc = mad_recv_wc;
 	rmpp_recv->cur_seg_buf = &mad_recv_wc->recv_buf;
@@ -357,7 +357,7 @@ acquire_rmpp_recv(struct ib_mad_agent_private *agent,
 	spin_lock_irqsave(&agent->lock, flags);
 	rmpp_recv = find_rmpp_recv(agent, mad_recv_wc);
 	if (rmpp_recv)
-		atomic_inc(&rmpp_recv->refcount);
+		refcount_inc(&rmpp_recv->refcount);
 	spin_unlock_irqrestore(&agent->lock, flags);
 	return rmpp_recv;
 }
@@ -553,7 +553,7 @@ start_rmpp(struct ib_mad_agent_private *agent,
 		destroy_rmpp_recv(rmpp_recv);
 		return continue_rmpp(agent, mad_recv_wc);
 	}
-	atomic_inc(&rmpp_recv->refcount);
+	refcount_inc(&rmpp_recv->refcount);
 
 	if (get_last_flag(&mad_recv_wc->recv_buf)) {
 		rmpp_recv->state = RMPP_STATE_COMPLETE;
-- 
2.26.2

