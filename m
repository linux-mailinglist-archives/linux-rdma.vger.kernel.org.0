Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F731398672
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 12:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhFBK30 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 06:29:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232653AbhFBK3Q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 06:29:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B45016138C;
        Wed,  2 Jun 2021 10:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622629653;
        bh=L3SmULuPSgKX3gl3jsr8CT000rQQvi51E9jdxl6RL08=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vPS+2jyg1kbmDadPZB1b9QL4jm4Q/6iq0bCzptlE39BBjk6xhPtsGLPtTAgHM/H19
         p/0x8TciwgO1CSttCy/Yk1nIoJD3COOs9cAgPxzal5FpndnkgvWZLqxi4TXxc48BmC
         CilW8suYOIgcUjI+zkK+g+EoXHy/2HJBKi45DfnBoDfpz+gJz0LQLDVYIFd2fw13Vv
         aHwcs4tkivXZlPeWTdAYxok5vej8k3s806MT8Z/72l6+cznl+JWXQNecFSNpSXEHLJ
         BIDZzMWI87o0psAtLSsrC5IaC+jNBDbkNXW5iZM8jvQebdzpdfUnlQZ/Ot7T3Jojw1
         5rR87BArWmk1w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mark Zhang <markzhang@nvidia.com>,
        Roland Dreier <rolandd@cisco.com>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v4 4/8] IB/cm: Tidy remaining cm_msg free paths
Date:   Wed,  2 Jun 2021 13:27:04 +0300
Message-Id: <082fd3552be0d1a2c19b1c4cefb5f3f0e3e68e82.1622629024.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622629024.git.leonro@nvidia.com>
References: <cover.1622629024.git.leonro@nvidia.com>
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

