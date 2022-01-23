Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D05497407
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Jan 2022 19:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiAWSA5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Jan 2022 13:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiAWSA4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Jan 2022 13:00:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5AC06173B;
        Sun, 23 Jan 2022 10:00:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 681B860FE3;
        Sun, 23 Jan 2022 18:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8FCC340E2;
        Sun, 23 Jan 2022 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642960854;
        bh=nO2zeXruYEjMNZf71m/0JLH6eqS4OxaXWEs62L1cIvA=;
        h=From:To:Cc:Subject:Date:From;
        b=dU7pB+Y9JhNW3C8sx6sdaNYcd0H8OvaWGKoA1NAHfypoyVLhcevTL4SnPy6uTR2RP
         oNKlobQfqI6i4lPKqlwNLnxB8CvsYnfdHxYcPmTExnAZhLGy5Rmyrw5TuhTPYtWaNY
         o3eEsRiu8eqNc8i58P3BBD4GK+eEs57deu/+OK5mYc0hu9ITYk9bwcjCPzR4KLe3WX
         1R3a7pyM2h1B7N1qjBx04PsROTCmFSpQhNuWWDRHMSup19d6EWdQvFATACDRuekOYl
         5/nVjBXhB2MC5SKuyT5DBUyvp8lPGD1cgSP+TlRMHy4z34kT5EHuFQRCSQc1nlUb2b
         Ic/N11CoEVh7w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Delete get_num_static_uars function
Date:   Sun, 23 Jan 2022 20:00:48 +0200
Message-Id: <11d78568c3c6ba588ee8465e0d10d96145fc825c.1642960830.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

There is no need to keep get_num_static_uars in the headers file
as it is not shared and used only once.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 6 ------
 drivers/infiniband/hw/mlx5/qp.c      | 3 ++-
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 357bcf4e305d..104acd986c66 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1526,12 +1526,6 @@ static inline int get_uars_per_sys_page(struct mlx5_ib_dev *dev, bool lib_suppor
 				MLX5_UARS_IN_PAGE : 1;
 }
 
-static inline int get_num_static_uars(struct mlx5_ib_dev *dev,
-				      struct mlx5_bfreg_info *bfregi)
-{
-	return get_uars_per_sys_page(dev, bfregi->lib_uar_4k) * bfregi->num_static_sys_pages;
-}
-
 extern void *xlt_emergency_page;
 
 int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index bf0a0ef380d4..4f325a844c93 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -615,7 +615,8 @@ enum {
 
 static int max_bfregs(struct mlx5_ib_dev *dev, struct mlx5_bfreg_info *bfregi)
 {
-	return get_num_static_uars(dev, bfregi) * MLX5_NON_FP_BFREGS_PER_UAR;
+	return get_uars_per_sys_page(dev, bfregi->lib_uar_4k) *
+	       bfregi->num_static_sys_pages * MLX5_NON_FP_BFREGS_PER_UAR;
 }
 
 static int num_med_bfreg(struct mlx5_ib_dev *dev,
-- 
2.34.1

