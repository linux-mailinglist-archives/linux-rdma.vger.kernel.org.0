Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A607A202A21
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Jun 2020 12:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgFUKr6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Jun 2020 06:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729732AbgFUKr5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 21 Jun 2020 06:47:57 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D1CD248CA;
        Sun, 21 Jun 2020 10:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592736477;
        bh=fMi3QJmf/R4TUvHvzpCeIJq/KhbU/lAZXJTsQzHsSz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SSIHNiTtMtNsiPFZ2AZCDMRdAp3ApaAcVS/Y3ESXdnlWgDDXQy5ohCh3V0RCDm7C/
         JWJ2JMm3HxZ5VEn2uVpYz8ICEOfQEcDQuiV86mTxeh8q6bY2yfhuTUjiUphwR5LlT7
         QBXfXMf4NBSofaTILH2+JhBuN2Ut6JgGhdXY0eg0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Shay Drory <shayd@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 2/4] IB/mad: Issue complete whenever decrements agent refcount
Date:   Sun, 21 Jun 2020 13:47:36 +0300
Message-Id: <20200621104738.54850-3-leon@kernel.org>
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

Replace calls of atomic_dec to mad_agent_priv->refcount with calls
to deref_mad_agent in order to issue complete.

Signed-off-by: Shay Drory <shayd@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/mad.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 2da889f9b6b3..46f36acb6a44 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1148,7 +1148,7 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
 			spin_lock_irqsave(&mad_agent_priv->lock, flags);
 			list_del(&mad_send_wr->agent_list);
 			spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
-			atomic_dec(&mad_agent_priv->refcount);
+			deref_mad_agent(mad_agent_priv);
 			goto error;
 		}
 	}
@@ -1831,7 +1831,7 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 				mad_agent_priv->agent.recv_handler(
 						&mad_agent_priv->agent, NULL,
 						mad_recv_wc);
-				atomic_dec(&mad_agent_priv->refcount);
+				deref_mad_agent(mad_agent_priv);
 			} else {
 				/* not user rmpp, revert to normal behavior and
 				 * drop the mad */
@@ -1848,7 +1848,7 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 					&mad_agent_priv->agent,
 					&mad_send_wr->send_buf,
 					mad_recv_wc);
-			atomic_dec(&mad_agent_priv->refcount);
+			deref_mad_agent(mad_agent_priv);

 			mad_send_wc.status = IB_WC_SUCCESS;
 			mad_send_wc.vendor_err = 0;
@@ -2438,7 +2438,7 @@ static void cancel_mads(struct ib_mad_agent_private *mad_agent_priv)
 		list_del(&mad_send_wr->agent_list);
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   &mad_send_wc);
-		atomic_dec(&mad_agent_priv->refcount);
+		deref_mad_agent(mad_agent_priv);
 	}
 }

@@ -2572,7 +2572,7 @@ static void local_completions(struct work_struct *work)
 						&local->mad_send_wr->send_buf,
 						&local->mad_priv->header.recv_wc);
 			spin_lock_irqsave(&recv_mad_agent->lock, flags);
-			atomic_dec(&recv_mad_agent->refcount);
+			deref_mad_agent(recv_mad_agent);
 			spin_unlock_irqrestore(&recv_mad_agent->lock, flags);
 		}

@@ -2585,7 +2585,7 @@ static void local_completions(struct work_struct *work)
 						   &mad_send_wc);

 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
-		atomic_dec(&mad_agent_priv->refcount);
+		deref_mad_agent(mad_agent_priv);
 		if (free_mad)
 			kfree(local->mad_priv);
 		kfree(local);
@@ -2671,7 +2671,7 @@ static void timeout_sends(struct work_struct *work)
 		mad_agent_priv->agent.send_handler(&mad_agent_priv->agent,
 						   &mad_send_wc);

-		atomic_dec(&mad_agent_priv->refcount);
+		deref_mad_agent(mad_agent_priv);
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	}
 	spin_unlock_irqrestore(&mad_agent_priv->lock, flags);
--
2.26.2

