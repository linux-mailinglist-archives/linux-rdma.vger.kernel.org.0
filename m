Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B803F37A21D
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 10:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhEKIcq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 04:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230497AbhEKIcj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 04:32:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97ECF61939;
        Tue, 11 May 2021 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620721387;
        bh=L3SmULuPSgKX3gl3jsr8CT000rQQvi51E9jdxl6RL08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fv6M3J3toL2iLBZSaKMGS7dOGqmKe0v9zP3kLoEEfY5COPM1Pv5DMmcfxpOpipv8M
         LPOaqg+UOatBG12cWDJhIpJLlDFzMDLPy2pBOmHkOW552GngSVNH2uYmgBMZiHe5te
         cFqEA2FLyj/JdvKmtAG7nS0Yy7MAzXhDKVzLlrps30FRPymIHkzl/Gf3JjAVR3cCq+
         vw7S46Lx9ZIC4WvztTt4eRhOnPTwbR0I72rvVD+LYl1e2QotIxPnZUnv37Cz4vKAI4
         RS/9eQCcTkQmoCN9XcW0rPxuDx02jvSHR88O5C+XC7q83kdFfvcv48sWbv5luh/hL0
         eWaoC1rYD9nzg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v3 4/8] IB/cm: Tidy remaining cm_msg free paths
Date:   Tue, 11 May 2021 11:22:08 +0300
Message-Id: <07c079c8cab2c1276aeac4d8e925591b28e4d37c.1620720467.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620720467.git.leonro@nvidia.com>
References: <cover.1620720467.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Now that all the free paths are explicit cm_free_msg() will only be called
for msgs's allocated with cm_alloc_msg(), so we can assume the context is
set. Place it after the allocation function it is paired with for clarity.

Also remove a bogus NULL assignment in one place after a cancel. This does
nothing other than disable completions to become events, but changing the
state already did that.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 8dbc39ea4612..1f0bc31ca0e2 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -367,6 +367,16 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	return ERR_PTR(ret);
 }
 
+static void cm_free_msg(struct ib_mad_send_buf *msg)
+{
+	struct cm_id_private *cm_id_priv = msg->context[0];
+
+	if (msg->ah)
+		rdma_destroy_ah(msg->ah, 0);
+	cm_deref_id(cm_id_priv);
+	ib_free_send_mad(msg);
+}
+
 static struct ib_mad_send_buf *
 cm_alloc_priv_msg(struct cm_id_private *cm_id_priv)
 {
@@ -420,15 +430,6 @@ static int cm_create_response_msg_ah(struct cm_port *port,
 	return 0;
 }
 
-static void cm_free_msg(struct ib_mad_send_buf *msg)
-{
-	if (msg->ah)
-		rdma_destroy_ah(msg->ah, 0);
-	if (msg->context[0])
-		cm_deref_id(msg->context[0]);
-	ib_free_send_mad(msg);
-}
-
 static int cm_alloc_response_msg(struct cm_port *port,
 				 struct ib_mad_recv_wc *mad_recv_wc,
 				 struct ib_mad_send_buf **msg)
@@ -3455,7 +3456,6 @@ static int cm_apr_handler(struct cm_work *work)
 	}
 	cm_id_priv->id.lap_state = IB_CM_LAP_IDLE;
 	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-	cm_id_priv->msg = NULL;
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
-- 
2.31.1

