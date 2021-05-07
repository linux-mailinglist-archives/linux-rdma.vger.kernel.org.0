Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B41B37639D
	for <lists+linux-rdma@lfdr.de>; Fri,  7 May 2021 12:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhEGKYt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 May 2021 06:24:49 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:40418 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236084AbhEGKYT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 May 2021 06:24:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UY2Duau_1620382963;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UY2Duau_1620382963)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 May 2021 18:22:50 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     yishaih@nvidia.com
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] RDMA/mlx4: Remove unnessesary check in mlx4_ib_modify_wq()
Date:   Fri,  7 May 2021 18:22:41 +0800
Message-Id: <1620382961-69701-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

cur_state and new_state are enums and when GCC considers
them as unsigned, the conditions are never met.

Clean up the following smatch warning:

drivers/infiniband/hw/mlx4/qp.c:4258 mlx4_ib_modify_wq() warn: unsigned
'cur_state' is never less than zero.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 92ddbcc..162aa59 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -4255,8 +4255,7 @@ int mlx4_ib_modify_wq(struct ib_wq *ibwq, struct ib_wq_attr *wq_attr,
 						     ibwq->state;
 	new_state = wq_attr_mask & IB_WQ_STATE ? wq_attr->wq_state : cur_state;
 
-	if (cur_state  < IB_WQS_RESET || cur_state  > IB_WQS_ERR ||
-	    new_state < IB_WQS_RESET || new_state > IB_WQS_ERR)
+	if (cur_state > IB_WQS_ERR || new_state > IB_WQS_ERR)
 		return -EINVAL;
 
 	if ((new_state == IB_WQS_RDY) && (cur_state == IB_WQS_ERR))
-- 
1.8.3.1

