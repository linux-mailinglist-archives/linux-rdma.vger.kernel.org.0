Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E47A7878
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 12:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjITKCN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 06:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234128AbjITKCN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 06:02:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579C8F
        for <linux-rdma@vger.kernel.org>; Wed, 20 Sep 2023 03:02:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86CCC433C8;
        Wed, 20 Sep 2023 10:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695204127;
        bh=jgVQ93NpuWMwRx5GVnfG3qgPoHneMr9tOzhXZoR8NZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNpB2EvdgTDA2oPP+cLxq69CUUEay0+NUTO/S+i5zJ3+qzXoL9RSL51xiPXS1kV2w
         sw7q/VBzCcsnlRhSKYZAQzFZGBaGeIvA5TELW4YA7umpcwQ+zbzHplAKy1ESSfkYfB
         m32cS07I6bcT1C39UnMchV1Tn1GH9lZ/WjtTNMU3KzIKyqLODDcyezMZKY42gqLUYu
         UWWJRlvoRNvd86bzIIwmWgYcjykv2pWyF9Sk46XLsXDuhu6TuWGftyEUyZsvaT16jP
         vAyzfCMh84jP7DGQ+m8weML4a7JSU6j6b0s8Je0RkufZJ1siUMiDnW3+ynvUO5y3FY
         4BMymDWH8/Ohg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michael Guralnik <michaelgur@nvidia.com>,
        Edward Srouji <edwards@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-rc 1/3] RDMA/mlx5: Fix assigning access flags to cache mkeys
Date:   Wed, 20 Sep 2023 13:01:54 +0300
Message-ID: <8a802700b82def3ace3f77cd7a9ad9d734af87e7.1695203958.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695203958.git.leonro@nvidia.com>
References: <cover.1695203958.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@nvidia.com>

After the change to use dynamic cache structure, new cache entries
can be added and the mkey allocation can no longer assume that all
mkeys created for the cache have access_flags equal to zero.

Example of a flow that exposes the issue:
A user registers MR with RO on a HCA that cannot UMR RO and the mkey is
created outside of the cache. When the user deregisters the MR, a new
cache entry is created to store mkeys with RO.

Later, the user registers 2 MRs with RO. The first MR is reused from the
new cache entry. When we try to get the second mkey from the cache we see
the entry is empty so we go to the MR cache mkey allocation flow which
would have allocated a mkey with no access flags, resulting the user getting
a MR without RO.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5d3cc225be29..4a1e78e394e5 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -239,7 +239,8 @@ static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
 
 static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
 {
-	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
+	set_mkc_access_pd_addr_fields(mkc, ent->rb_key.access_flags, 0,
+				      ent->dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 	MLX5_SET(mkc, mkc, access_mode_1_0, ent->rb_key.access_mode & 0x3);
-- 
2.41.0

