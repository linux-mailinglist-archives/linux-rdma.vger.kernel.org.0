Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2BA687828
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Feb 2023 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjBBJDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Feb 2023 04:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjBBJDX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Feb 2023 04:03:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B8854563
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 01:03:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A9806192B
        for <linux-rdma@vger.kernel.org>; Thu,  2 Feb 2023 09:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E41C433EF;
        Thu,  2 Feb 2023 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675328596;
        bh=BLv0X8oB0G+4RyZ/NzLQim9FuHxKh/daMoqV0NvAgDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/qPpeg69LrS1nlgJ+AZ/fGoB3W9JnoSxjhO9T3HpXrf8fhFE5j3e+KpmyBZ/80WM
         DcMTR1K0tOFvBLGZPa3QSZDmDNlPnVzHt1GYiObzf/bvnjioeo52BXg/PWLnQ1+hif
         RiXbrYxCfB7hNdyvC8AVEe6jr6Svn4x/s3WJQLPwSMY96vgAmA6IELu5bGZbBc+XaG
         jsLExdCVz73GvYNOMUbAIB5AtjFQ/nIhoORybHBC7FirmPJ5jMomO36p7nYLvMHv9X
         fDJVSqcJbc+dTTxUdwaMPKFRJZUP97ftiTHGIybPwJ3aCG6cvsBUbX3uq4Do4PchjF
         XVO3YhdQSp4cA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/2] RDMA/mlx5: Fix MR cache debugfs in switchdev mode
Date:   Thu,  2 Feb 2023 11:03:06 +0200
Message-Id: <482a78c54acbcfa1742a0e06a452546428900ffa.1675328463.git.leon@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675328463.git.leon@kernel.org>
References: <cover.1675328463.git.leon@kernel.org>
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

From: Leon Romanovsky <leonro@nvidia.com>

Block MR cache debugfs creation while in switchdev mode and add missing
debugfs cleanup in error path.

This change fixes the following debugfs errors:

 bond0: (slave enp8s0f1): Enslaving as a backup interface with an up link
 mlx5_core 0000:08:00.0: lag map: port 1:1 port 2:1
 mlx5_core 0000:08:00.0: shared_fdb:1 mode:queue_affinity
 mlx5_core 0000:08:00.0: Operation mode is single FDB
 debugfs: Directory '2' with parent '/' already present!
...
 debugfs: Directory '22' with parent '/' already present!

Fixes: 73d09b2fe833 ("RDMA/mlx5: Introduce mlx5r_cache_rb_key")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3a9a787184fc..3f410eef58e4 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -848,6 +848,9 @@ static void mlx5_mkey_cache_debugfs_add_ent(struct mlx5_ib_dev *dev,
 	int order = order_base_2(ent->rb_key.ndescs);
 	struct dentry *dir;
 
+	if (!mlx5_debugfs_root || dev->is_rep)
+		return;
+
 	if (ent->rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
 		order = MLX5_IMR_KSM_CACHE_ENTRY + 2;
 
@@ -1006,6 +1009,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 
 err:
 	mutex_unlock(&cache->rb_lock);
+	mlx5_mkey_cache_debugfs_cleanup(dev);
 	mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
 	return ret;
 }
-- 
2.39.1

