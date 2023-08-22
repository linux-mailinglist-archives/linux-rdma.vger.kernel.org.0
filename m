Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4137839DF
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Aug 2023 08:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjHVGXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Aug 2023 02:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjHVGXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Aug 2023 02:23:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAA3187;
        Mon, 21 Aug 2023 23:23:32 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RVK2x75YjzLp7P;
        Tue, 22 Aug 2023 14:20:25 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 14:23:29 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH net-next] net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Tue, 22 Aug 2023 14:23:12 +0800
Message-ID: <20230822062312.3982963-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Return PTR_ERR_OR_ZERO() instead of return 0 or PTR_ERR() to
simplify code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c        |  8 ++------
 drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c | 10 ++--------
 2 files changed, 4 insertions(+), 14 deletions(-)

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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
index 7d9bbb494d95..101b3bb90863 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/port_sel.c
@@ -507,10 +507,7 @@ static int mlx5_lag_create_ttc_table(struct mlx5_lag *ldev)
 
 	mlx5_lag_set_outer_ttc_params(ldev, &ttc_params);
 	port_sel->outer.ttc = mlx5_create_ttc_table(dev, &ttc_params);
-	if (IS_ERR(port_sel->outer.ttc))
-		return PTR_ERR(port_sel->outer.ttc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(port_sel->outer.ttc);
 }
 
 static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
@@ -521,10 +518,7 @@ static int mlx5_lag_create_inner_ttc_table(struct mlx5_lag *ldev)
 
 	mlx5_lag_set_inner_ttc_params(ldev, &ttc_params);
 	port_sel->inner.ttc = mlx5_create_inner_ttc_table(dev, &ttc_params);
-	if (IS_ERR(port_sel->inner.ttc))
-		return PTR_ERR(port_sel->inner.ttc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(port_sel->inner.ttc);
 }
 
 int mlx5_lag_port_sel_create(struct mlx5_lag *ldev,
-- 
2.34.1

