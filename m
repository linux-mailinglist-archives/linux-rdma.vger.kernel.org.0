Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2EC4E86BB
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Mar 2022 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiC0H5k (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Mar 2022 03:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiC0H5i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 27 Mar 2022 03:57:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729DD2
        for <linux-rdma@vger.kernel.org>; Sun, 27 Mar 2022 00:56:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39374B80BAA
        for <linux-rdma@vger.kernel.org>; Sun, 27 Mar 2022 07:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786D9C340EC;
        Sun, 27 Mar 2022 07:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648367758;
        bh=XN4g2Sxxsq6w09a2Og/3Oktz3XHX0uhKTvkrBHZ5xUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6fDXVdMoxKu1GJgjWuwKi/jJdPuDZFPsAMz73+3OnAinVLQYJLmXRO70Y+9ne0SE
         d+QN53vaIfYCJZfuC8VhHXMLyXc69Zzo4lC0Ys5FCyAmVcshGyPAypo01xoLqjOTIj
         lwj6m9WYgwS76q11csrNxgIn+gkPvyxx/FX0YxNoBiFkj9CgQYEy9dSbzhCV4X2U2D
         IFvM+g1mPALGcV/7IkVxcv3fidA3lOUkQdZa3T6rWgjJcQYn7ehBTP3etLbdoRMCSG
         1DL6xgDLW77LHPZvyYkva3K8LUR5ho43WkyWg6qgu1+72t+amBtqb5EcoALXWfBmA6
         6Fo5EEI+WJGfA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc 2/3] RDMA/mlx5: Add a missing update of cache->last_add
Date:   Sun, 27 Mar 2022 10:55:47 +0300
Message-Id: <ba629c8461261ca0e6430ec01dcdcbf50bc6f7b6.1648366974.git.leonro@nvidia.com>
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

Update cache->last_add when returning an MR to the cache so that the
cache work won't remove it.

Fixes: b9358bdbc713 ("RDMA/mlx5: Fix locking in MR cache work queue")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4a01a0ad7c90..1eef74b952b6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -614,6 +614,7 @@ static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 
+	WRITE_ONCE(dev->cache.last_add, jiffies);
 	spin_lock_irq(&ent->lock);
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
-- 
2.35.1

