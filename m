Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCB4B78C0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:52:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242796AbiBOR4L (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:56:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242806AbiBOR4K (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:56:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8841017F8;
        Tue, 15 Feb 2022 09:55:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C706E61662;
        Tue, 15 Feb 2022 17:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344A4C340F6;
        Tue, 15 Feb 2022 17:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644947757;
        bh=DpghstMLiYzSupNnVlCnqIFT1M0QQYu4EYFnyOaiqFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMmP/7lOBcdj9y9ZI3b0y/if9iL66syjYvw6dNeCqQfgeScrktPjmRtJhOxIgBDqM
         hl4yUlifp40Ul/jlO6adpwfm9iXOWEivu6bSVupQKMlMHPRg7h9IS32lrejPnCyCpH
         s+L7vbkJ4Ey7URogKH7J3p4VQvIqm8H1PtNBhiQXDzAAeRlBDL9HAR6+wE4ls/rF77
         sGgdeeaYnrcZQUy+0wJWo++kGUYjttxu5jDBgMcphA94mXiOEQArklru7kZ2AyfFR+
         IIBfnYm1IH9OBqHHJrn+Xf8qaiitVEzDz20jiPm6b9ga+olCXrlMa8yLFapta1mGDB
         sU7/bNYhlGwlA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 5/5] RDMA/mlx5: Reorder calls to pcie_relaxed_ordering_enabled()
Date:   Tue, 15 Feb 2022 19:55:33 +0200
Message-Id: <684be1366cb1d4f05aa3e78986205e4bc410443a.1644947594.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644947594.git.leonro@nvidia.com>
References: <cover.1644947594.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index eb14ea4bcbba..eab7921eb91f 100644
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
2.35.1

