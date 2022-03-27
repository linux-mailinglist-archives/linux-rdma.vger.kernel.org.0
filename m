Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301754E86BD
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Mar 2022 09:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiC0H5q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Mar 2022 03:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiC0H5p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Mar 2022 03:57:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF963D2
        for <linux-rdma@vger.kernel.org>; Sun, 27 Mar 2022 00:56:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7E97B80CC9
        for <linux-rdma@vger.kernel.org>; Sun, 27 Mar 2022 07:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9324C340EC;
        Sun, 27 Mar 2022 07:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648367765;
        bh=MPGsw+DG33IwDM8iKgBmxMH5V5e939YsNdnUfwLNqjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=trqhVjGuNgkvaxf8m2LHZOWmsH2xkjIctIvn/oiW0b1jkLpum98CJ0UrsP3/XMsob
         2wP0Eqe7tdqiOPeLe5Bm19IiMoVhrIwuipzVo8v/ul5eOmMALICzUOYmNrTI9QTQzQ
         +tfcT8NvsO2nhvsObhw2NNtJNiYHIBM66k3D5GTzT2EhxCcqXhe5Y+YI+QsGuLm/G/
         Tl62+/d6UXdUm4wOaU95VkgstWqIQwTdmvVnCY02zE5xhvK8+YS99deTYB+xyZdNd1
         HzC9Vw1TZtMpU7vycBlRG+iwGcdb/rXw9s82E8x7bmkp8QaQzkS1TXI+jh458Reph8
         QHQuTCR7lwYxQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc 1/3] RDMA/mlx5: Don't remove cache MRs when a delay is needed
Date:   Sun, 27 Mar 2022 10:55:46 +0300
Message-Id: <73c3fef51ee2bb50ae240306472d9562ba05916f.1648366974.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648366974.git.leonro@nvidia.com>
References: <cover.1648366974.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Don't remove MRs from the cache if need to delay the removal.

Fixes: b9358bdbc713 ("RDMA/mlx5: Fix locking in MR cache work queue")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8a87a2f074e4..4a01a0ad7c90 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -562,9 +562,10 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		spin_lock_irq(&ent->lock);
 		if (ent->disabled)
 			goto out;
-		if (need_delay)
+		if (need_delay) {
 			queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
-		remove_cache_mr_locked(ent);
+			goto out;
+		}
 		queue_adjust_cache_locked(ent);
 	}
 out:
-- 
2.35.1

