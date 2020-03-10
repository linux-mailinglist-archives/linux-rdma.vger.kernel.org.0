Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26CE317F37B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCJJ0P (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0P (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:15 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE0124684;
        Tue, 10 Mar 2020 09:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832374;
        bh=clxEI/xQCbNuQ6sqMFPPA7vS4nKxkYt3Cp6tpwU82N0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4Uhw2hRsEatIfodV46W0tuRy5rAmVMeUUuod57RnXtPucslKP8oN2FsZY8mz8X4b
         /32gM3+ZWIjNTT8rxZwOCv14lAnd++xNYlOhfj9eDKP9vpPDXPM7026Jsv/Da1IWqL
         TnMo+eWM9AcpuZ0WzkDk/W1uaqIO7bxhlRQpbzsA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 04/15] RDMA/cm: Make the destroy_id flow more robust
Date:   Tue, 10 Mar 2020 11:25:34 +0200
Message-Id: <20200310092545.251365-5-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310092545.251365-1-leon@kernel.org>
References: <20200310092545.251365-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Too much of the destruction is very carefully sensitive to the state
and various other things. Move more code to the unconditional path and
add several WARN_ONs to check consistency.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 0e7d2363df88..51e6cebb606e 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -829,6 +829,8 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 	cm_id_priv->id.context = context;
 	cm_id_priv->id.remote_cm_qpn = 1;
 
+	RB_CLEAR_NODE(&cm_id_priv->service_node);
+	RB_CLEAR_NODE(&cm_id_priv->sidr_id_node);
 	spin_lock_init(&cm_id_priv->lock);
 	init_completion(&cm_id_priv->comp);
 	INIT_LIST_HEAD(&cm_id_priv->work_list);
@@ -986,11 +988,13 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		spin_lock_irq(&cm.lock);
 		if (--cm_id_priv->listen_sharecount > 0) {
 			/* The id is still shared. */
+			WARN_ON(refcount_read(&cm_id_priv->refcount) == 1);
 			cm_deref_id(cm_id_priv);
 			spin_unlock_irq(&cm.lock);
 			return;
 		}
 		rb_erase(&cm_id_priv->service_node, &cm.listen_service_table);
+		RB_CLEAR_NODE(&cm_id_priv->service_node);
 		spin_unlock_irq(&cm.lock);
 		break;
 	case IB_CM_SIDR_REQ_SENT:
@@ -1001,11 +1005,6 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	case IB_CM_SIDR_REQ_RCVD:
 		spin_unlock_irq(&cm_id_priv->lock);
 		cm_reject_sidr_req(cm_id_priv, IB_SIDR_REJECT);
-		spin_lock_irq(&cm.lock);
-		if (!RB_EMPTY_NODE(&cm_id_priv->sidr_id_node))
-			rb_erase(&cm_id_priv->sidr_id_node,
-				 &cm.remote_sidr_table);
-		spin_unlock_irq(&cm.lock);
 		break;
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -1072,6 +1071,10 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	if (!list_empty(&cm_id_priv->prim_list) &&
 	    (!cm_id_priv->prim_send_port_not_ready))
 		list_del(&cm_id_priv->prim_list);
+	WARN_ON(cm_id_priv->listen_sharecount);
+	WARN_ON(!RB_EMPTY_NODE(&cm_id_priv->service_node));
+	if (!RB_EMPTY_NODE(&cm_id_priv->sidr_id_node))
+		rb_erase(&cm_id_priv->sidr_id_node, &cm.remote_sidr_table);
 	spin_unlock(&cm.lock);
 	spin_unlock_irq(&cm_id_priv->lock);
 
-- 
2.24.1

