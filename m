Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E950038795E
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 14:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhERM7s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 08:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231321AbhERM7q (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 08:59:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E1C161209;
        Tue, 18 May 2021 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621342707;
        bh=LQFd09DPHFoiTAJ6RyTPtmww1669WUG99d7WakSDwvE=;
        h=From:To:Cc:Subject:Date:From;
        b=VrL9blY5J0hugASdnBFG7pupWqUqDZQr/bKsLCSVbmKwlyCBosRVUWAiX90DAnN2O
         RQZgonP0vJcbyG0L/iugU+J+QsgKFwwHRHwv+x4POv7WP50clcUX4Q/gOmV1voxDcY
         ipjhsCeXM5Io4YuOzRi02EzTDLO9H2QXUNMpI3lNcT+7CZNO4qZmFOkcqaqQYEPygF
         +T8sYJqPGu/ukJ8Fe8el2UbM6LUyqG9UitdaA8aLTATlOEsZJ+HuHFcbXvm+GVlYW5
         4Ci9ACD0sESdR7modiucrDNo+OcBEMPrkQK+fu879Z1jSrxk2R+vvnWV3egy/CLOrR
         vcXaz2s8BSucQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-rc v1] RDMA/core: Sanitize WQ state received from the userspace
Date:   Tue, 18 May 2021 15:58:21 +0300
Message-Id: <0433d8013ed3a2ffdd145244651a5edb2afbd75b.1621342527.git.leonro@nvidia.com>
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
Changelog:
v1:
 * Removed IB_WQS_RESET state checks because it is zero and wq states
   declared as u32, so can't be less than IB_WQS_RESET.
v0: https://lore.kernel.org/lkml/932f87b48c07278730c3c760b3a707d6a984b524.1621332736.git.leonro@nvidia.com
---
 drivers/infiniband/core/uverbs_cmd.c | 21 +++++++++++++++++++--
 drivers/infiniband/hw/mlx4/qp.c      |  9 ++-------
 drivers/infiniband/hw/mlx5/qp.c      |  6 ++----
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
index 4f890bff80f8..c6f53d894411 100644
--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -3084,12 +3084,29 @@ static int ib_uverbs_ex_modify_wq(struct uverbs_attr_bundle *attrs)
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
+		if (cmd.curr_wq_state > IB_WQS_ERR)
+			return -EINVAL;
+
+		wq_attr.curr_wq_state = cmd.curr_wq_state;
+	} else {
+		wq_attr.curr_wq_state = wq->state;
+	}
+
+	if (cmd.attr_mask & IB_WQ_STATE) {
+		if (cmd.wq_state > IB_WQS_ERR)
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

