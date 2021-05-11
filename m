Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF44037A217
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhEKIcm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 04:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhEKIci (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 04:32:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB4366192E;
        Tue, 11 May 2021 08:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721364;
        bh=2nP8Ko0C7D3HKZqDrCRhXV8tFaTyj6Sttgh/p6V3Y1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aA3eskYcZpLvniUFME+bvpf8n01C2PF74ExE3kUFlP6v98cm7R3C8AyvYehDNBoBb
         QxbMSWSCi2H4uwc/WKKk6x5x4k1WV1ba8T2SLPLWb2JVSpPZbBC2VNHYEwYBmFJtTg
         CApiiLGv7RftT0M/ybQVoh+lCtBt7e/A8QzRWVBC8qgrFwbIl7R+DTakivKE8Q8U4c
         XpRwavQ0ljXHBhS3OguLPtzXdnib46ABgA5gaJ9ZfUfesvEwWgw6xNIgk3ZQURy+lp
         20QfPGxs3hAC3seLsAg3ZEWXaMb8UaEAwLHVWQO5vO5mJKwtlvRkhP+rdvQCeW+qV+
         nz/jtlfMBSs8Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v3 1/8] IB/cm: Pair cm_alloc_response_msg() with a cm_free_response_msg()
Date:   Tue, 11 May 2021 11:22:05 +0300
Message-Id: <598e654b67ebdfaa52c6659113d360fabec7a5e8.1620720467.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620720467.git.leonro@nvidia.com>
References: <cover.1620720467.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This is not a functional change, but it helps make the purpose of all the
cm_free_msg() calls clearer. In this case a response msg has a NULL
context[0], and is never placed in cm_id_priv->msg.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0ead0d223154..6e20ba5d32e1 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -413,7 +413,7 @@ static int cm_alloc_response_msg(struct cm_port *port,
 
 	ret = cm_create_response_msg_ah(port, mad_recv_wc, m);
 	if (ret) {
-		cm_free_msg(m);
+		ib_free_send_mad(m);
 		return ret;
 	}
 
@@ -421,6 +421,13 @@ static int cm_alloc_response_msg(struct cm_port *port,
 	return 0;
 }
 
+static void cm_free_response_msg(struct ib_mad_send_buf *msg)
+{
+	if (msg->ah)
+		rdma_destroy_ah(msg->ah, 0);
+	ib_free_send_mad(msg);
+}
+
 static void *cm_copy_private_data(const void *private_data, u8 private_data_len)
 {
 	void *data;
@@ -1569,16 +1576,16 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
 	if (ret) {
+		cm_free_msg(cm_id_priv->msg);
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		goto error2;
+		goto out;
 	}
 	BUG_ON(cm_id->state != IB_CM_IDLE);
 	cm_id->state = IB_CM_REQ_SENT;
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return 0;
-
-error2:	cm_free_msg(cm_id_priv->msg);
-out:	return ret;
+out:
+	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_req);
 
@@ -1618,7 +1625,7 @@ static int cm_issue_rej(struct cm_port *port,
 		IBA_GET(CM_REJ_REMOTE_COMM_ID, rcv_msg));
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
-		cm_free_msg(msg);
+		cm_free_response_msg(msg);
 
 	return ret;
 }
@@ -1974,7 +1981,7 @@ static void cm_dup_req_handler(struct cm_work *work,
 	return;
 
 unlock:	spin_unlock_irq(&cm_id_priv->lock);
-free:	cm_free_msg(msg);
+free:	cm_free_response_msg(msg);
 }
 
 static struct cm_id_private *cm_match_req(struct cm_work *work,
@@ -2453,7 +2460,7 @@ static void cm_dup_rep_handler(struct cm_work *work)
 	goto deref;
 
 unlock:	spin_unlock_irq(&cm_id_priv->lock);
-free:	cm_free_msg(msg);
+free:	cm_free_response_msg(msg);
 deref:	cm_deref_id(cm_id_priv);
 }
 
@@ -2794,7 +2801,7 @@ static int cm_issue_drep(struct cm_port *port,
 		IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
-		cm_free_msg(msg);
+		cm_free_response_msg(msg);
 
 	return ret;
 }
@@ -2853,7 +2860,7 @@ static int cm_dreq_handler(struct cm_work *work)
 
 		if (cm_create_response_msg_ah(work->port, work->mad_recv_wc, msg) ||
 		    ib_post_send_mad(msg, NULL))
-			cm_free_msg(msg);
+			cm_free_response_msg(msg);
 		goto deref;
 	case IB_CM_DREQ_RCVD:
 		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
@@ -3343,7 +3350,7 @@ static int cm_lap_handler(struct cm_work *work)
 
 		if (cm_create_response_msg_ah(work->port, work->mad_recv_wc, msg) ||
 		    ib_post_send_mad(msg, NULL))
-			cm_free_msg(msg);
+			cm_free_response_msg(msg);
 		goto deref;
 	case IB_CM_LAP_RCVD:
 		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
-- 
2.31.1

