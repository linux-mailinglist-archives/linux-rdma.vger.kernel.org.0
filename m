Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE838763A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348410AbhERKPP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 06:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242072AbhERKPP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 06:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA85360BD3;
        Tue, 18 May 2021 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621332837;
        bh=IqDH4vdVUMgzvIbN6g+Y4cX4AiGT3hpmx+38vDl6Gug=;
        h=From:To:Cc:Subject:Date:From;
        b=fVccqNUWIE+4M1Zoox0dygTkdiQ0iZOEcg1AohbcAUMdYYuDOy0izNWAaq8bGXJR5
         lrOfbJjGRAUhnMl8t0MTkLHwkoop8Vr+l4UDpWOGSYnHSW6EJLkJlBVLdKP5etXBLm
         Jf03MLNGtWm4BnocO0Vq61P3JsYfD1ma3NlcEFLCx19Q02FfEMwc9+N8ThvgGfVqnp
         DrmrqLDf6+Kg9q+pEIJXpUauhn2pUwDNRIzvfjAuuH9Lu0lqy2VRdZzooDgxmMRwAd
         AMSx8/z+fjHfWIFL6j9jQ+bcxSWDNZsy9M/9TvmTDuptSwe1A2d9+amS9rriYpZXxV
         amoBYbIjVDT4g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc] RDMA/core: Sanitize WQ state received from the userspace
Date:   Tue, 18 May 2021 13:13:51 +0300
Message-Id: <932f87b48c07278730c3c760b3a707d6a984b524.1621332736.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The mlx4 and mlx5 implemented differently the WQ input checks.
Instead of duplicating mlx4 logic in the mlx5, let's prepare
the input in the central place.

Fixes: f213c0527210 ("IB/uverbs: Add WQ support")
Reported-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/uverbs_cmd.c | 22 ++++++++++++++++++++--
 drivers/infiniband/hw/mlx4/qp.c      |  9 ++-------
 drivers/infiniband/hw/mlx5/qp.c      |  6 ++----
 3 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4f890bff80f8..8e80bd01a096 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3084,12 +3084,30 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
 	if (!wq)
 		return -EINVAL;
 
-	wq_attr.curr_wq_state = cmd.curr_wq_state;
-	wq_attr.wq_state = cmd.wq_state;
 	if (cmd.attr_mask & IB_WQ_FLAGS) {
 		wq_attr.flags = cmd.flags;
 		wq_attr.flags_mask = cmd.flags_mask;
 	}
+
+	if (cmd.attr_mask & IB_WQ_CUR_STATE) {
+		if (cmd.curr_wq_state < IB_WQS_RESET ||
+		    cmd.curr_wq_state > IB_WQS_ERR)
+			return -EINVAL;
+
+		wq_attr.curr_wq_state = cmd.curr_wq_state;
+	} else {
+		wq_attr.curr_wq_state = wq->state;
+	}
+
+	if (cmd.attr_mask & IB_WQ_STATE) {
+		if (cmd.wq_state < IB_WQS_RESET || cmd.wq_state > IB_WQS_ERR)
+			return -EINVAL;
+
+		wq_attr.wq_state = cmd.wq_state;
+	} else {
+		wq_attr.wq_state = wq_attr.curr_wq_state;
+	}
+
 	ret = wq->device->ops.modify_wq(wq, &wq_attr, cmd.attr_mask,
 					&attrs->driver_udata);
 	rdma_lookup_put_uobject(&wq->uobject->uevent.uobject,
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 92ddbcc00eb2..2ae22bf50016 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4251,13 +4251,8 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
 	if (wq_attr_mask & IB_WQ_FLAGS)
 		return -EOPNOTSUPP;
 
-	cur_state = wq_attr_mask & IB_WQ_CUR_STATE ? wq_attr->curr_wq_state :
-						     ibwq->state;
-	new_state = wq_attr_mask & IB_WQ_STATE ? wq_attr->wq_state : cur_state;
-
-	if (cur_state  < IB_WQS_RESET || cur_state  > IB_WQS_ERR ||
-	    new_state < IB_WQS_RESET || new_state > IB_WQS_ERR)
-		return -EINVAL;
+	cur_state = wq_attr->curr_wq_state;
+	new_state = wq_attr->wq_state;
 
 	if ((new_state == IB_WQS_RDY) && (cur_state == IB_WQS_ERR))
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index d984b451c379..becd250388af 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -5483,10 +5483,8 @@ int mlx5_ib_modify_wq(struct ib_wq *wq, struct ib_wq_attr *wq_attr,
 
 	rqc = MLX5_ADDR_OF(modify_rq_in, in, ctx);
 
-	curr_wq_state = (wq_attr_mask & IB_WQ_CUR_STATE) ?
-		wq_attr->curr_wq_state : wq->state;
-	wq_state = (wq_attr_mask & IB_WQ_STATE) ?
-		wq_attr->wq_state : curr_wq_state;
+	curr_wq_state = wq_attr->curr_wq_state;
+	wq_state = wq_attr->wq_state;
 	if (curr_wq_state == IB_WQS_ERR)
 		curr_wq_state = MLX5_RQC_STATE_ERR;
 	if (wq_state == IB_WQS_ERR)
-- 
2.31.1

