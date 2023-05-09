Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86766FD0D4
	for <lists+linux-rdma@lfdr.de>; Tue,  9 May 2023 23:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbjEIVU3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 9 May 2023 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjEIVUE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 9 May 2023 17:20:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3FE5589;
        Tue,  9 May 2023 14:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92FB163719;
        Tue,  9 May 2023 21:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4BAC433EF;
        Tue,  9 May 2023 21:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667194;
        bh=nzkn9exyJRt/FbFrP6FZTZwelwkUHu8d/wJ+9bG7uOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cY1n61FtEO/15aHs+NEZ4Pve4ailt2ue0IdUo8W1rFj4VcOb2WdlLqW3URwMNr360
         ccR46MVnCYMbLExDatIqxHkhd6bN5okYBw24VgHpNdKsW3PhLX7Fj+RKTITidJuwPW
         Xw19Ips8SlSFF4ujMxnjIzKG9QmxZ+63FtnRfK0mljYBmEKS81XWVllcHxybt19so5
         yS9zfeInMuTu1+uHoLX26HdoReep92PMB2jpE8D6R4eHAYa13fKUpGrmmXHt0JwJF6
         MAR6w9dmZJ9EVkKuU/KGVcRgwubDwdV43A1Th5v95fP359ulQ083Drg8gCXLL8/Guz
         w0vMTeZbwgjlw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Avihai Horon <avihaih@nvidia.com>, Shay Drory <shayd@nvidia.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>, saeedm@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, tariqt@nvidia.com, maxtram95@gmail.com,
        gal@nvidia.com, afaris@nvidia.com, dtatulea@nvidia.com,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 16/18] RDMA/mlx5: Remove pcie_relaxed_ordering_enabled() check for RO write
Date:   Tue,  9 May 2023 17:19:24 -0400
Message-Id: <20230509211928.21010-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211928.21010-1-sashal@kernel.org>
References: <20230509211928.21010-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

[ Upstream commit ed4b0661cce119870edb1994fd06c9cbc1dc05c3 ]

pcie_relaxed_ordering_enabled() check was added to avoid a syndrome when
creating a MKey with relaxed ordering (RO) enabled when the driver's
relaxed_ordering_{read,write} HCA capabilities are out of sync with FW.

While this can happen with relaxed_ordering_read, it can't happen with
relaxed_ordering_write as it's set if the device supports RO write,
regardless of RO in PCI config space, and thus can't change during
runtime.

Therefore, drop the pcie_relaxed_ordering_enabled() check for
relaxed_ordering_write while keeping it for relaxed_ordering_read.
Doing so will also allow the usage of RO write in VFs and VMs (where RO
in PCI config space is not reported/emulated properly).

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Link: https://lore.kernel.org/r/7e8f55e31572c1702d69cae015a395d3a824a38a.1681131553.git.leon@kernel.org
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/mr.c                     | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 3 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 67356f5152616..bd0a818ba1cd8 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -67,11 +67,11 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 	MLX5_SET(mkc, mkc, lw, !!(acc & IB_ACCESS_LOCAL_WRITE));
 	MLX5_SET(mkc, mkc, lr, 1);
 
-	if ((acc & IB_ACCESS_RELAXED_ORDERING) &&
-	    pcie_relaxed_ordering_enabled(dev->mdev->pdev)) {
+	if (acc & IB_ACCESS_RELAXED_ORDERING) {
 		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
 			MLX5_SET(mkc, mkc, relaxed_ordering_write, 1);
-		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
+		if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+		    pcie_relaxed_ordering_enabled(dev->mdev->pdev))
 			MLX5_SET(mkc, mkc, relaxed_ordering_read, 1);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index a21bd1179477b..d840a59aec88a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -867,8 +867,7 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *params)
 {
 	bool lro_en = params->packet_merge.type == MLX5E_PACKET_MERGE_LRO;
-	bool ro = pcie_relaxed_ordering_enabled(mdev->pdev) &&
-		MLX5_CAP_GEN(mdev, relaxed_ordering_write);
+	bool ro = MLX5_CAP_GEN(mdev, relaxed_ordering_write);
 
 	return ro && lro_en ?
 		MLX5_WQ_END_PAD_MODE_NONE : MLX5_WQ_END_PAD_MODE_ALIGN;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 4c9a3210600c2..993af4c12d909 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -44,7 +44,7 @@ void mlx5e_mkey_set_relaxed_ordering(struct mlx5_core_dev *mdev, void *mkc)
 	bool ro_read = MLX5_CAP_GEN(mdev, relaxed_ordering_read);
 
 	MLX5_SET(mkc, mkc, relaxed_ordering_read, ro_pci_enable && ro_read);
-	MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_pci_enable && ro_write);
+	MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_write);
 }
 
 int mlx5e_create_mkey(struct mlx5_core_dev *mdev, u32 pdn, u32 *mkey)
-- 
2.39.2

