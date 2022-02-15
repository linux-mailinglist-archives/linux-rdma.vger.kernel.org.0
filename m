Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8984B759C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Feb 2022 21:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242756AbiBOR4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Feb 2022 12:56:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiBORz7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Feb 2022 12:55:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912BFEB34;
        Tue, 15 Feb 2022 09:55:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34FCA6162D;
        Tue, 15 Feb 2022 17:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5208C340EB;
        Tue, 15 Feb 2022 17:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644947748;
        bh=95yl+3bn4ytIYbgPinAuCqCDGSlINtcctUoKV8AnqtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QBVM6sHazPeWgLGdU25yEkEXS3LoJC29hec5yBLl1IoKfiBXfWTON105bx0T9xErB
         3REKHGxnYTfEiPd+hxMkwRtjFjpQEluiF8VMwlwRsErOyPE7JCrRh5hUwnkE6/69Ay
         zH2hXRScJUolNCaTtjD9fesrxINvN+w1Q0jCYip55ERLhPYMk/SYf0+n+c6TXU3uMM
         1JffmSS7eAR4UH5QixORm9Ew0tZHnLHepMPeR4bYWbNxI21Sm7KFsbLS6Z003LmIst
         5AjwFj/8O9F+X1BtiHx8icxfKNrQEZ7mGO3YW8eRM1QUXSxnKBxb60ZasMbJKpvuYl
         syzmMYz6plN/w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 2/5] RDMA/mlx5: Fix the flow of a miss in the allocation of a cache ODP MR
Date:   Tue, 15 Feb 2022 19:55:30 +0200
Message-Id: <09503e295276dcacc92cb1d8aef1ad0961c99dc1.1644947594.git.leonro@nvidia.com>
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

When an ODP MR cache entry is empty and trying to allocate it, increment
the ent->miss counter and call to queue_adjust_cache_locked() to verify
the entry is balanced.

Fixes: aad719dcf379 ("RDMA/mlx5: Allow MRs to be created in the cache synchronously")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index cd14d1b9dc1d..bce3cb6af524 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -577,6 +577,8 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	ent = &cache->ent[entry];
 	spin_lock_irq(&ent->lock);
 	if (list_empty(&ent->head)) {
+		queue_adjust_cache_locked(ent);
+		ent->miss++;
 		spin_unlock_irq(&ent->lock);
 		mr = create_cache_mr(ent);
 		if (IS_ERR(mr))
-- 
2.35.1

