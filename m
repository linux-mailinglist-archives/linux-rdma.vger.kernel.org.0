Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 126178E704
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbfHOIjE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIjE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:39:04 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18B6722387;
        Thu, 15 Aug 2019 08:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858343;
        bh=gYf3bGM86R4wtOatMCeGBxL9boNuI414yitstzMODLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6KlZRo8n2QzjSRjvyLudLmYJgvrJm5NiP4Ms/2LH9sSGsp3vP8VnrtHwTm/ToHvn
         NULNcF0/BDH+SZ8/gGPmiG1SGmJuLKbOsvJut428BgfLGZvaAV19L84yMQ6TZYFC93
         L1sMG7zENcLQkzSBNirnS8peQmhY5mKjWk1HpzVg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 7/8] IB/mlx5: Fix MR re-registration flow to use UMR properly
Date:   Thu, 15 Aug 2019 11:38:33 +0300
Message-Id: <20190815083834.9245-8-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

The UMR WQE in the MR re-registration flow requires that
modify_atomic and modify_entity_size capabilities are enabled.
Therefore, check that the these capabilities are present before going to
umr flow and go through slow path if not.

Fixes: c8d75a980fab ("IB/mlx5: Respect new UMR capabilities")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Guy Levi <guyle@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8bce65c03b84..3401f5f6792e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1446,7 +1446,8 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			goto err;
 	}
 
-	if (flags & IB_MR_REREG_TRANS && !use_umr_mtt_update(mr, addr, len)) {
+	if (!mlx5_ib_can_use_umr(dev, true) ||
+	    (flags & IB_MR_REREG_TRANS && !use_umr_mtt_update(mr, addr, len))) {
 		/*
 		 * UMR can't be used - MKey needs to be replaced.
 		 */
-- 
2.20.1

