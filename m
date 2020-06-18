Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9391FF074
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2020 13:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgFRLZX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Jun 2020 07:25:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbgFRLZV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Jun 2020 07:25:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E49720663;
        Thu, 18 Jun 2020 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592479521;
        bh=707sVmx0s5sjEkKRli2t2n9PWrs6S8hfMhcTE0f2riw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9WuNCuukhQnLapuBiEWZH/LYGaDO9x8Gzn58mfjCj0GgdQfnv2FIFf08j6osjcrf
         PJtZggZUdV/hxVsXfPE0ihHFwHsObnJE+BS6StXQwD0wc88IHMR5e8RSyN3TYlFEvb
         maGt8ZWKhcyol4oyFT60/ZQ5HLeAdHPCwiAOTfyI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-rc 2/2] RDMA/mlx5: Fix remote gid value in query QP
Date:   Thu, 18 Jun 2020 14:25:07 +0300
Message-Id: <20200618112507.3453496-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200618112507.3453496-1-leon@kernel.org>
References: <20200618112507.3453496-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@mellanox.com>

Remote gid is not copied to the right address. Fix it by using
rdma_ah_set_dgid_raw to copy the remote gid value from the QP
context on query QP.

Fixes: 70bd7fb87625 ("RDMA/mlx5: Remove manually crafted QP context the query call")
Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 0e42c50373d9..9b8012e941b8 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4374,8 +4374,7 @@ static void to_rdma_ah_attr(struct mlx5_ib_dev *ibdev,
 				MLX5_GET(ads, path, src_addr_index),
 				MLX5_GET(ads, path, hop_limit),
 				MLX5_GET(ads, path, tclass));
-		memcpy(ah_attr, MLX5_ADDR_OF(ads, path, rgid_rip),
-		       MLX5_FLD_SZ_BYTES(ads, rgid_rip));
+		rdma_ah_set_dgid_raw(ah_attr, MLX5_ADDR_OF(ads, path, rgid_rip));
 	}
 }
 
-- 
2.26.2

