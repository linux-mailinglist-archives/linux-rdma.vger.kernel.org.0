Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D06366A09
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 13:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237751AbhDULlu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 07:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237575AbhDULlu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 07:41:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5D9461445;
        Wed, 21 Apr 2021 11:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619005277;
        bh=t88LAHSNGv9oNKqAsvDaSAp6ikG+l2nZVXrpk+a7wJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CV+R41qyYNAwqpAjCoLL1vHpJln9WjFxv72yvTH/85cXs5pToBUcY7uTUMkatic05
         JnQrusoKURcyny8oG5a4O7cwGnY4LH5ITatsQGXnupioxnrRO4L5Eulbf2u7mddtYc
         +fXjYv14k83vMsPVxrO2EMyvD7ZtEgHGoWhWrlAhJiMfkInHfnMuq6fVO8Bm+KfFjl
         vX9a3GEO8RRgRrDjfGM8JjDXO3e/0cB299w/XLU/e4K/z4XuGmVEP2zxTLD2Ppet6k
         QOfMDUy0IBgNERbMIXxz7F8hx9g54DddFvsbLjDUQAWTyFaY32rcXOuKKn33GESIbN
         tB8QLQnW6iqZQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 9/9] IB/cm: Initialize av before aquire the spin lock in cm_lap_handler
Date:   Wed, 21 Apr 2021 14:40:39 +0300
Message-Id: <b9e7450ec77df754f6e68e5a2c0eccb816eec2ab.1619004798.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619004798.git.leonro@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

Both cm_init_av_for_lap and cm_init_av_by_path and might sleep and should
not be called within a spin_lock.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 28eb8a5ee54e..3feff999a5e0 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -3400,6 +3400,17 @@ static int cm_lap_handler(struct cm_work *work)
 	work->cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_LAP_PRIVATE_DATA, lap_msg);
 
+	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
+				 work->mad_recv_wc->recv_buf.grh,
+				 cm_id_priv);
+	if (ret)
+		goto deref;
+
+	ret = cm_init_av_by_path(param->alternate_path, NULL,
+				 cm_id_priv, false);
+	if (ret)
+		goto deref;
+
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
 		goto unlock;
@@ -3434,17 +3445,6 @@ static int cm_lap_handler(struct cm_work *work)
 		goto unlock;
 	}
 
-	ret = cm_init_av_for_lap(work->port, work->mad_recv_wc->wc,
-				 work->mad_recv_wc->recv_buf.grh,
-				 cm_id_priv);
-	if (ret)
-		goto unlock;
-
-	ret = cm_init_av_by_path(param->alternate_path, NULL,
-				 cm_id_priv, false);
-	if (ret)
-		goto unlock;
-
 	cm_id_priv->id.lap_state = IB_CM_LAP_RCVD;
 	cm_id_priv->tid = lap_msg->hdr.tid;
 	cm_queue_work_unlock(cm_id_priv, work);
-- 
2.30.2

