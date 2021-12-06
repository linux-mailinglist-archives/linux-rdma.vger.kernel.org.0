Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFDFE46921C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240133AbhLFJPr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 04:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240225AbhLFJPH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 04:15:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DBDC061D5E;
        Mon,  6 Dec 2021 01:11:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8423061201;
        Mon,  6 Dec 2021 09:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F808C341C1;
        Mon,  6 Dec 2021 09:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638781890;
        bh=8TsImOLRohqnFnX8431SrjVMlBAzbqlMb24Ad03f/sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWya6ww7v/DCDUvuWILBgEYV2oNJ1watDfs7DWbyvUmA6tZahwKF+1CJiZ6B1Jj/N
         cLFHuQLhkoWBlaN1gx49zR6JwRtfeuWOruuEAJxpiRFOA+EIH//ZVrGYkM1c3UTyLe
         e0Qx7UlRm2nc4hhrg/ok8pDp7zqnbNwdcnwIu98B+svdBTyL1LPVbe1GC6Tt4FweMe
         JUisuPXv0NMmXR3WA2+uzX1REpdrmXleJQJCRxbOJo78yQ9owTADegidbuHQsZzFOc
         nhrg10fMzVpQAkMlSSwagjtuudjAlSJmMQuBcgLFUkpyR+j69vX60gtJdCAaLZcEJ7
         wk5DQ10Lnhv2Q==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/7] RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()
Date:   Mon,  6 Dec 2021 11:10:50 +0200
Message-Id: <4a0bd57e590ca64b06289a37277707982d5d3b94.1638781506.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638781506.git.leonro@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

The mkc is the key for the mkey cache, hence, created in each attempt to
get a cache mkey, while pcie_relaxed_ordering_enabled() is called during
the setting of the mkc, but used only for cases where IB_ACCESS_RELAXED_ORDERING
is set.

pcie_relaxed_ordering_enabled() is an expensive call (26 us). Reorder the
code so the driver will call it only when it is needed.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6000acbedc73..ca6faf599cd3 100644
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

