Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8625E7837D6
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 04:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjHVCUh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Aug 2023 22:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjHVCUe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Aug 2023 22:20:34 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24513186;
        Mon, 21 Aug 2023 19:20:32 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVCdz4jRjzNn9R;
        Tue, 22 Aug 2023 10:16:55 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 10:20:29 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <saeedm@nvidia.com>, <leon@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <davem@davemloft.net>, <maciej.fijalkowski@intel.com>,
        <michal.simek@amd.com>, <netdev@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 1/2] net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Tue, 22 Aug 2023 10:14:54 +0800
Message-ID: <20230822021455.205101-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use the standard error pointer macro to shorten the code and simplify.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 934b0d5ce1b3..777d311d44ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -1283,9 +1283,7 @@ static int mlx5e_create_inner_ttc_table(struct mlx5e_flow_steering *fs,
 	mlx5e_set_inner_ttc_params(fs, rx_res, &ttc_params);
 	fs->inner_ttc = mlx5_create_inner_ttc_table(fs->mdev,
 						    &ttc_params);
-	if (IS_ERR(fs->inner_ttc))
-		return PTR_ERR(fs->inner_ttc);
-	return 0;
+	return PTR_ERR_OR_ZERO(fs->inner_ttc);
 }
 
 int mlx5e_create_ttc_table(struct mlx5e_flow_steering *fs,
@@ -1295,9 +1293,7 @@ int mlx5e_create_ttc_table(struct mlx5e_flow_steering *fs,
 
 	mlx5e_set_ttc_params(fs, rx_res, &ttc_params, true);
 	fs->ttc = mlx5_create_ttc_table(fs->mdev, &ttc_params);
-	if (IS_ERR(fs->ttc))
-		return PTR_ERR(fs->ttc);
-	return 0;
+	return PTR_ERR_OR_ZERO(fs->ttc);
 }
 
 int mlx5e_create_flow_steering(struct mlx5e_flow_steering *fs,
-- 
2.25.1

