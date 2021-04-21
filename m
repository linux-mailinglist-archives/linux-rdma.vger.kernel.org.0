Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD998366A03
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 13:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhDULl3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 07:41:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237781AbhDULl3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 07:41:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51B4D61448;
        Wed, 21 Apr 2021 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619005256;
        bh=AfPdKD1beGQZkxuCvTfAb2r/G6kQJug33QvZY1WTP84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hz81SYol1YXDQxe8lr2WhaQ2YFW3pyFWjPJHYQ6qr+AaCYWDDBjOTiz96844aJAwp
         qzJhsVoT62ss6rL4WVGJcbQWhbM6iusO/0WxDySdQj1Lvpq6Zhl6EJMLT10AK/Iq/n
         I0rOd96t1v10tPZ8eUMWMrGM/7lEmJk9A3/qwXhiB3ioY/zabahgm7dZ0Mc454pJ74
         65qxzbdyZcuYuWTSC7HkE0HfmXEnFBz+V77chnppoH51PvhbqHg5/La75XerN/1U+b
         jNJ7fL2jpW9efULpYTCHLtyQUZy/eRw35JXDl2TbykTad7Zb3vAfoMRpsXzV/UVtLi
         IRkHh7mj0fHAA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 4/9] IB/cm: Tidy remaining cm_msg free paths
Date:   Wed, 21 Apr 2021 14:40:34 +0300
Message-Id: <901cbc6554280835b040dac51afdf840d0e8e4a2.1619004798.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619004798.git.leonro@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
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
2.30.2

