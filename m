Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469B374324F
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 03:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjF3Bmn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 21:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjF3Bml (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 21:42:41 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6092730DF;
        Thu, 29 Jun 2023 18:42:40 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QsdNW4fcwzqSqY;
        Fri, 30 Jun 2023 09:42:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 09:42:38 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>
CC:     <saeedm@nvidia.com>, <leon@kernel.org>, <lkayal@nvidia.com>,
        <tariqt@nvidia.com>, <gal@nvidia.com>, <rrameshbabu@nvidia.com>,
        <vadfed@meta.com>, <ayal@nvidia.com>, <eranbe@nvidia.com>,
        <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <shaozhengchao@huawei.com>
Subject: [PATCH net,v2 1/2] net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create
Date:   Fri, 30 Jun 2023 09:49:02 +0800
Message-ID: <20230630014903.1082615-2-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630014903.1082615-1-shaozhengchao@huawei.com>
References: <20230630014903.1082615-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The memory pointed to by the fs->any pointer is not freed in the error
path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
Fix by freeing the memory in the error path, thereby making the error path
identical to mlx5e_fs_tt_redirect_any_destroy().

Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
v2: update the 'any' member reference in fs to NULL before free fs_any
---
 drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
index 03cb79adf912..be83ad9db82a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
@@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 	err = fs_any_create_table(fs);
 	if (err)
-		return err;
+		goto err_free_any;
 
 	err = fs_any_enable(fs);
 	if (err)
@@ -606,8 +606,8 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
 
 err_destroy_table:
 	fs_any_destroy_table(fs_any);
-
-	kfree(fs_any);
+err_free_any:
 	mlx5e_fs_set_any(fs, NULL);
+	kfree(fs_any);
 	return err;
 }
-- 
2.34.1

