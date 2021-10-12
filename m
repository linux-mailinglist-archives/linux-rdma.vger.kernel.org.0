Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCB429EA0
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Oct 2021 09:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhJLHau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Oct 2021 03:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232500AbhJLHau (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 12 Oct 2021 03:30:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 134AE6108F;
        Tue, 12 Oct 2021 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634023728;
        bh=Vw7yAdNZuRR+JFWTGL++rcQPXKi75JyotcQgHBK2vwA=;
        h=From:To:Cc:Subject:Date:From;
        b=uiw/+oWlg31bGKYZ5oSDe1VgAZdxyySq/aEDShR4JJcQbsmH21exUhnp7QulfXCIh
         t1zUvv7kwCn+qEzf9VdeGDZhD0zi+MWA0nmv4LWb0PEuyONBr/JetoP7phJFFLRrPz
         eGnkey3mbf9j5DNcDy0JCA6pxL9KMZhtLFexyuJjl0Z7YZ9B/226HM86ik1Kxoykdf
         HyE60Jf1G5Suwn3QRcHFqw3PYAQe1hYPepjjSgguLBT7c4Hr9rMESVL3x0a2mPbpkR
         1aotArCFrHNTaNtlo+5BcYylfLQtl5U/aqGzYh0di1y69bAykFGAIUV17ZScuD8WYg
         AowJ6puYX3YXQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx4: Return missed an error if device doesn't support steering
Date:   Tue, 12 Oct 2021 10:28:43 +0300
Message-Id: <91c61f6e60eb0240f8bbc321fda7a1d2986dd03c.1634023677.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The error flow fixed in this patch is not possible because all kernel
users of create QP interface check that device supports steering before
set IB_QP_CREATE_NETIF_QP flag.

Fixes: c1c98501121e ("IB/mlx4: Add support for steerable IB UD QPs")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx4/qp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/qp.c
index 8662f462e2a5..3a1a4ac9dd33 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1099,8 +1099,10 @@ static int create_qp_common(struct ib_pd *pd, struct ib_qp_init_attr *init_attr,
 			if (dev->steering_support ==
 			    MLX4_STEERING_MODE_DEVICE_MANAGED)
 				qp->flags |= MLX4_IB_QP_NETIF;
-			else
+			else {
+				err = -EINVAL;
 				goto err;
+			}
 		}
 
 		err = set_kernel_sq_size(dev, &init_attr->cap, qp_type, qp);
-- 
2.31.1

