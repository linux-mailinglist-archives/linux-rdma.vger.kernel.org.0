Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9BB585E1E
	for <lists+linux-rdma@lfdr.de>; Sun, 31 Jul 2022 10:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiGaI0q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 31 Jul 2022 04:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaI0q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 31 Jul 2022 04:26:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A67CE0C0
        for <linux-rdma@vger.kernel.org>; Sun, 31 Jul 2022 01:26:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC19BB80D17
        for <linux-rdma@vger.kernel.org>; Sun, 31 Jul 2022 08:26:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFEDC433D7;
        Sun, 31 Jul 2022 08:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659256002;
        bh=6cN0cQ++MWo/3EvpmYdJYZ9hdjUqZRvXnJM91Er36gY=;
        h=From:To:Cc:Subject:Date:From;
        b=jYk99ITkPyPmyb6NkCLDOnYGis1qnZiunR0EDinFL3buXluzERG0d/UlUoqfHTkwT
         BdG2GE6e8+lA7tm6NqFvN18wiwuNemXv++231KtUdfkukVcMkQJFFkJgvlS5LQ9n+y
         FzWFpXMk3o7xrRDs4pB/LH2Sv/lYvGhBO21b+LCSsxMJuH3nVcMccfXAw8IDDFIPs1
         HellvP7YUAxo07/oURj4n+jQ8VPZ9CLIIEoXNrmZHvSMMrBh5HWw/+FHuVOuZFJs3W
         LB+G49CeeiQpf3ny+EXcf/ZUk7ZXzdCoJNaK9P4jorinUqs19cT70Ma8puH/C22UvN
         VYSccwJ7/+9Pw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Don't compare mkey tags in DEVX indirect mkey
Date:   Sun, 31 Jul 2022 11:26:36 +0300
Message-Id: <3d669aacea85a3a15c3b3b953b3eaba3f80ef9be.1659255945.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

According to the ib spec:
If the CI supports the Base Memory Management Extensions defined in this
specification, the L_Key format must consist of:
24 bit index in the most significant bits of the R_Key, and
8 bit key in the least significant bits of the R_Key
Through a successful Allocate L_Key verb invocation, the CI must let the
consumer own the key portion of the returned R_Key

Therefore, when creating a mkey using DEVX, the consumer is allowed to
change the key part. The kernel should compare only the index part of a
R_Key to determine equality with another R_Key.

Adding capability in order not to break backward compatibility.

Fixes: 534fd7aac56a ("IB/mlx5: Manage indirection mkey upon DEVX flow for ODP")
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 3 +++
 drivers/infiniband/hw/mlx5/odp.c  | 3 ++-
 include/uapi/rdma/mlx5-abi.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index fc94a1b25485..a7d88713dfdd 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1826,6 +1826,9 @@ static int set_ucontext_resp(struct ib_ucontext *uctx,
 	if (MLX5_CAP_GEN(dev->mdev, drain_sigerr))
 		resp->comp_mask |= MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_SQD2RTS;
 
+	resp->comp_mask |=
+		MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_MKEY_UPDATE_TAG;
+
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e305bf1dc6c2..901a8b030236 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -795,7 +795,8 @@ static bool mkey_is_eq(struct mlx5_ib_mkey *mmkey, u32 key)
 {
 	if (!mmkey)
 		return false;
-	if (mmkey->type == MLX5_MKEY_MW)
+	if (mmkey->type == MLX5_MKEY_MW ||
+	    mmkey->type == MLX5_MKEY_INDIRECT_DEVX)
 		return mlx5_base_mkey(mmkey->key) == mlx5_base_mkey(key);
 	return mmkey->key == key;
 }
diff --git a/include/uapi/rdma/mlx5-abi.h b/include/uapi/rdma/mlx5-abi.h
index 86be4a92b67b..a96b7d2770e1 100644
--- a/include/uapi/rdma/mlx5-abi.h
+++ b/include/uapi/rdma/mlx5-abi.h
@@ -104,6 +104,7 @@ enum mlx5_ib_alloc_ucontext_resp_mask {
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_ECE               = 1UL << 2,
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_SQD2RTS           = 1UL << 3,
 	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_REAL_TIME_TS	   = 1UL << 4,
+	MLX5_IB_ALLOC_UCONTEXT_RESP_MASK_MKEY_UPDATE_TAG   = 1UL << 5,
 };
 
 enum mlx5_user_cmds_supp_uhw {
-- 
2.37.1

