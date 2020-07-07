Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D219216AFD
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGGLDE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 07:03:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGGLDE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 07:03:04 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385C2206DF;
        Tue,  7 Jul 2020 11:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594119784;
        bh=MlS3F7bb9TzBjJMm+Ts2aAKb2sXu7KXfDfzIVr+RR3c=;
        h=From:To:Cc:Subject:Date:From;
        b=KcS+iJkteyG+dF7Z9mz+ByUXv1B+JhoM7MihUC9ESQgx219ifgAFn5OvKIBLFnTBI
         LB8GZ+Au7K+vHPlp28bJ5wDdSMPNtkB2GeLND1EfTo3fdWsiLO0Ysfk6fFzv2v9y95
         GVNAZG2rnFyrFW2C1fuXVDavVoHlnkBwM6h7Os6c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Daria Velikovsky <daria@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Init dest_type when create flow
Date:   Tue,  7 Jul 2020 14:02:59 +0300
Message-Id: <20200707110259.882276-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Daria Velikovsky <daria@mellanox.com>

When using action drop dest_type was never assigned to any value.
Add initialization of dest_type to -1 since 0 is valid.

Fixes: f29de9eee782 ("RDMA/mlx5: Add support for drop action in DV steering")
Signed-off-by: Daria Velikovsky <daria@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Based on
https://lore.kernel.org/lkml/20200702081809.423482-1-leon@kernel.org
---
 drivers/infiniband/hw/mlx5/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 0d8abb7c3cdf..1a7e6226f11a 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1903,7 +1903,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_CREATE_FLOW)(
 	struct mlx5_flow_context flow_context = {.flow_tag =
 		MLX5_FS_DEFAULT_FLOW_TAG};
 	u32 *offset_attr, offset = 0, counter_id = 0;
-	int dest_id, dest_type, inlen, len, ret, i;
+	int dest_id, dest_type = -1, inlen, len, ret, i;
 	struct mlx5_ib_flow_handler *flow_handler;
 	struct mlx5_ib_flow_matcher *fs_matcher;
 	struct ib_uobject **arr_flow_actions;
--
2.26.2

