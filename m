Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A64375216
	for <lists+linux-rdma@lfdr.de>; Thu,  6 May 2021 12:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhEFKOY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 May 2021 06:14:24 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41858 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhEFKOY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 May 2021 06:14:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UXyQ2MH_1620296003;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UXyQ2MH_1620296003)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 May 2021 18:13:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     leon@kernel.org
Cc:     dledford@redhat.com, jgg@ziepe.ca, nathan@kernel.org,
        ndesaulniers@google.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] RDMA/mlx5: Remove redundant assignment to ret
Date:   Thu,  6 May 2021 18:13:21 +0800
Message-Id: <1620296001-120406-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Variable 'ret' is set to the rerurn value of function
mlx5_mr_cache_alloc() but this value is never read as it is
overwritten with a new value later on, hence it is a redundant
assignment and can be removed

Clean up the following clang-analyzer warning:

drivers/infiniband/hw/mlx5/odp.c:421:2: warning: Value stored to 'ret'
is never read [clang-analyzer-deadcode.DeadStores]

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 782b2af..87fa0b2 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -418,7 +418,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	ret = mr = mlx5_mr_cache_alloc(
+	mr = mlx5_mr_cache_alloc(
 		mr_to_mdev(imr), MLX5_IMR_MTT_CACHE_ENTRY, imr->access_flags);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
-- 
1.8.3.1

