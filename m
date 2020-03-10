Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4BF317F377
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgCJJ0G (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:06 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2350D2467F;
        Tue, 10 Mar 2020 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832365;
        bh=w8hwOdwCNHXfWwl9hKbcGtp2SVBnWZtgOmVyqxKdtCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wmpdy/mXjNjClO3zh0LZhvnKYcTf21ctrLNJB78cdDBM3mLYSQcaEfcxTrBcyAYFi
         NsciDXRrUAlJc0XKSMrCWMT8CdtNqDU5Wk+srDYl5UeR/cEsG0Jn22O1pa9zvODQq4
         piwuST0rCoUdP99Dk9HCmodfIVeImyFlna4SBBAc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Daniel Jurgens <danielj@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 06/15] RDMA/cm: Read id.state under lock when doing pr_debug()
Date:   Tue, 10 Mar 2020 11:25:36 +0200
Message-Id: <20200310092545.251365-7-leon@kernel.org>
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

The lock should not be dropped before doing the pr_debug() print as it is
accessing data protected by the lock, such as id.state.

Fixes: 119bf81793ea ("IB/cm: Add debug prints to ib_cm")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 051a546b8e7b..f50b56302500 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -2421,13 +2421,13 @@ static int cm_rep_handler(struct cm_work *work)
 	case IB_CM_MRA_REQ_RCVD:
 		break;
 	default:
-		spin_unlock_irq(&cm_id_priv->lock);
 		ret = -EINVAL;
 		pr_debug(
 			"%s: cm_id_priv->id.state: %d, local_comm_id %d, remote_comm_id %d\n",
 			__func__, cm_id_priv->id.state,
 			IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
 			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
+		spin_unlock_irq(&cm_id_priv->lock);
 		goto error;
 	}
 
@@ -2693,10 +2693,10 @@ int ib_send_cm_drep(struct ib_cm_id *cm_id,
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	if (cm_id->state != IB_CM_DREQ_RCVD) {
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		kfree(data);
 		pr_debug("%s: local_id %d, cm_idcm_id->state(%d) != IB_CM_DREQ_RCVD\n",
 			 __func__, be32_to_cpu(cm_id->local_id), cm_id->state);
+		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		kfree(data);
 		return -EINVAL;
 	}
 
@@ -3032,10 +3032,10 @@ static int cm_rej_handler(struct cm_work *work)
 		}
 		/* fall through */
 	default:
-		spin_unlock_irq(&cm_id_priv->lock);
 		pr_debug("%s: local_id %d, cm_id_priv->id.state: %d\n",
 			 __func__, be32_to_cpu(cm_id_priv->id.local_id),
 			 cm_id_priv->id.state);
+		spin_unlock_irq(&cm_id_priv->lock);
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.24.1

