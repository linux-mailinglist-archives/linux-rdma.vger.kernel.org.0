Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07D4B76A5
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbiBOR4R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242778AbiBOR4N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:56:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B122110076B;
        Tue, 15 Feb 2022 09:56:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F2761662;
        Tue, 15 Feb 2022 17:56:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F9FC340EB;
        Tue, 15 Feb 2022 17:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644947761;
        bh=RW6YVaDJUsS8JVaYPBST0uEeqYkZIjQuU58SCjwO1rE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FkZ40rmL/bfiR2tDJxFdqEQG1gJMEL2JxCy404T8NX9D7ABZCxBkzehromlbioZ6c
         RI2TDyvJcQ4PKIHmT6yBKKUkZP71O97i6YQe66ihRQDpNXQtQDTqoeMTz1NIS7PVg9
         SX1qH8/gOYP20ZxBZUA9Ht121pUWOOEG7OEoYBKPGEiMys8n6mJTsQ7+oRTZ/i+Eky
         RrD8OPAnVYripqAgpGbY9UVTTsKLgikBxvM+ZoCZ5dxhArqtOucPBG3ILgxhOVlXN1
         AL9glzgO8JBZHUelsISQob5Q1bOXdIAbbIRZ32s/ISsO1EPxmD0weCENWb1YFvmsQy
         B/Qh1rSP5acjg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 4/5] RDMA/mlx5: Store ndescs instead of the translation table size
Date:   Tue, 15 Feb 2022 19:55:32 +0200
Message-Id: <e9dbfaa1f279793a6bd28ee5a31cb4f0f0d70f05.1644947594.git.leonro@nvidia.com>
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

Currently, ent->xlt stores the translation table size. This data should
not be stored in the cache entry but be written directly to the mailbox.
Store ndescs instead, and deduce the translation table size from it
according to the access mode.
Later in the series, ent->ndescs will help to search for entries.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 25 ++++++++++++++++++++++---
 drivers/infiniband/hw/mlx5/odp.c     |  8 ++------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 751d02bc755b..4f04bb55c4c6 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -763,9 +763,9 @@ struct mlx5_cache_ent {
 
 	char                    name[4];
 	u32                     order;
-	u32			xlt;
 	u32			access_mode;
 	u32			page;
+	unsigned int		ndescs;
 
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 0c1dc13b4c45..eb14ea4bcbba 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -176,6 +176,25 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 	spin_unlock_irqrestore(&ent->lock, flags);
 }
 
+static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
+{
+	int ret = 0;
+
+	switch (access_mode) {
+	case MLX5_MKC_ACCESS_MODE_MTT:
+		ret = DIV_ROUND_UP(ndescs, MLX5_IB_UMR_OCTOWORD /
+						   sizeof(struct mlx5_mtt));
+		break;
+	case MLX5_MKC_ACCESS_MODE_KSM:
+		ret = DIV_ROUND_UP(ndescs, MLX5_IB_UMR_OCTOWORD /
+						   sizeof(struct mlx5_klm));
+		break;
+	default:
+		WARN_ON(1);
+	}
+	return ret;
+}
+
 static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 {
 	struct mlx5_ib_mr *mr;
@@ -191,7 +210,8 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
 	MLX5_SET(mkc, mkc, access_mode_4_2, (ent->access_mode >> 2) & 0x7);
 
-	MLX5_SET(mkc, mkc, translations_octword_size, ent->xlt);
+	MLX5_SET(mkc, mkc, translations_octword_size,
+		 get_mkc_octo_size(ent->access_mode, ent->ndescs));
 	MLX5_SET(mkc, mkc, log_page_size, ent->page);
 	return mr;
 }
@@ -701,8 +721,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 			continue;
 
 		ent->page = PAGE_SHIFT;
-		ent->xlt = (1 << ent->order) * sizeof(struct mlx5_mtt) /
-			   MLX5_IB_UMR_OCTOWORD;
+		ent->ndescs = 1 << ent->order;
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
 		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
 		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f834c9590c51..41c964a45f89 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1598,18 +1598,14 @@ void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent)
 	switch (ent->order - 2) {
 	case MLX5_IMR_MTT_CACHE_ENTRY:
 		ent->page = PAGE_SHIFT;
-		ent->xlt = MLX5_IMR_MTT_ENTRIES *
-			   sizeof(struct mlx5_mtt) /
-			   MLX5_IB_UMR_OCTOWORD;
+		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
 		ent->limit = 0;
 		break;
 
 	case MLX5_IMR_KSM_CACHE_ENTRY:
 		ent->page = MLX5_KSM_PAGE_SHIFT;
-		ent->xlt = mlx5_imr_ksm_entries *
-			   sizeof(struct mlx5_klm) /
-			   MLX5_IB_UMR_OCTOWORD;
+		ent->ndescs = mlx5_imr_ksm_entries;
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
 		ent->limit = 0;
 		break;
-- 
2.35.1

