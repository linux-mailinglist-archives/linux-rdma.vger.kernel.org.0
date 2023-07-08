Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D03674BC7E
	for <lists+linux-rdma@lfdr.de>; Sat,  8 Jul 2023 09:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjGHHHJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 8 Jul 2023 03:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGHHHI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 8 Jul 2023 03:07:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26B12107;
        Sat,  8 Jul 2023 00:07:07 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QyhBz2YgtzqTdX;
        Sat,  8 Jul 2023 15:06:35 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 8 Jul
 2023 15:07:03 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <saeedm@nvidia.com>, <leon@kernel.org>, <tariqt@nvidia.com>,
        <lkayal@nvidia.co>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net] net/mlx5: fix potential memory leak in mlx5e_init_rep_rx
Date:   Sat, 8 Jul 2023 15:13:07 +0800
Message-ID: <20230708071307.149100-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The memory pointed to by the priv->rx_res pointer is not freed in the error
path of mlx5e_init_rep_rx, which can lead to a memory leak. Fix by freeing
the memory in the error path, thereby making the error path identical to
mlx5e_cleanup_rep_rx().

Fixes: af8bbf730068 ("net/mlx5e: Convert mlx5e_flow_steering member of mlx5e_priv to pointer")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 965a8261c99b..06f4d3480ce0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1012,7 +1012,7 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	err = mlx5e_open_drop_rq(priv, &priv->drop_rq);
 	if (err) {
 		mlx5_core_err(mdev, "open drop rq failed, %d\n", err);
-		return err;
+		goto err_rx_res_free;
 	}
 
 	err = mlx5e_rx_res_init(priv->rx_res, priv->mdev, 0,
@@ -1046,6 +1046,7 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	mlx5e_rx_res_destroy(priv->rx_res);
 err_close_drop_rq:
 	mlx5e_close_drop_rq(&priv->drop_rq);
+err_rx_res_free:
 	mlx5e_rx_res_free(priv->rx_res);
 	priv->rx_res = NULL;
 err_free_fs:
-- 
2.34.1

