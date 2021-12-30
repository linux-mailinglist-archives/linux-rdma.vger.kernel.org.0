Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DD8481BAE
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbhL3LXs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbhL3LXo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:23:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8340BC061574;
        Thu, 30 Dec 2021 03:23:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 244826167E;
        Thu, 30 Dec 2021 11:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2952C36AEA;
        Thu, 30 Dec 2021 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863423;
        bh=Jh6qCe/dAFhpxkqRJ0cJO14fGA2lUW/FT/5AYvDZkFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FyjzyPI7X8/hASs7Z8ZGi2y+WsjCYdYJtQM6WKPqfojtmWEqC85Ix3b2k+uvsbhoJ
         ufNBV2AWh4eqCxqY2xhfwV2YwquAvTU3FjkaZBr8jrHyIJ0gFH9cQAv7Z8dzMfyN96
         Muj9nAvG+qwcKh23E/CsKOk95jbTxf1wwT50242o6llRG+P03VO52+NvB7qNW2z+yO
         M543B4t2VTSn8GILiVkGKBYz9kq/OXDFkpDeXR7tXm4ft4mQayZ77ydD5Qok1mTSZT
         ZzC7H5ysFczMBfP65HbchR5v/GL81m+7vZz7IRF3fZzH0PZyAbnlefc1Ev5RmT72Df
         xlDQW1gDoD3uQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 4/7] RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()
Date:   Thu, 30 Dec 2021 13:23:21 +0200
Message-Id: <f5ba262e35b93de0e128946a6a2773775fd4fae7.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640862842.git.leonro@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

The mkc is the key for the mkey cache, hence, created in each attempt to
get a cache mkey, while pcie_relaxed_ordering_enabled() is called during
the setting of the mkc, but used only for cases where
IB_ACCESS_RELAXED_ORDERING is set.

pcie_relaxed_ordering_enabled() is an expensive call (26 us). Reorder the
code so the driver will call it only when it is needed.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 204c37a37421..182bdd537e43 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -68,7 +68,6 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 					  struct ib_pd *pd)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
 
 	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
 	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
@@ -76,12 +75,13 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
 	MLX5_SET(mkc, mkc, lr, 1);
 
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
-		MLX5_SET(mkc, mkc, relaxed_ordering_write,
-			 (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
-	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
-		MLX5_SET(mkc, mkc, relaxed_ordering_read,
-			 (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
+	if ((acc & IB_ACCESS_RELAXED_ORDERING) &&
+	    pcie_relaxed_ordering_enabled(dev->mdev->pdev)) {
+		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
+			MLX5_SET(mkc, mkc, relaxed_ordering_write, 1);
+		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
+			MLX5_SET(mkc, mkc, relaxed_ordering_read, 1);
+	}
 
 	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
 	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-- 
2.33.1

