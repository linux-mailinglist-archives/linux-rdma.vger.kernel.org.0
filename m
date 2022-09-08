Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384AE5B27FA
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIHUz2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIHUzR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:55:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2051.outbound.protection.outlook.com [40.107.244.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5714E5E655
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwtOinlDrop3Z+OQ8TjmYrsUD50fuOmDo3jvwpT5knOtDKmeIBwUzEowoQXx3URjShwfxCf3oK6PGzE1Tg2GHGbdsP5VVt2rRlDemPM+NjCl1SdJ9hrPzM8KXeygqPyRYCrnaemAmiZqXox5/O9KF8VaQwYhuGEZ764YHh6UCQ1DyejYCPg1XEr9GrjcJ9FS82d1wZuCo9x3Or9Y0MrdqxELNiBfxkGOyD/GqQVhzcuOm+wcA2JsaHWSjeYegBi6GfS01xaws0giwuPEHU5wBdvjAFVXNzA0QrkV/Pk+wruz9cvMedZn8WevBFYtBKFiHVTCKGPIUZwO9748my8YbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb1OaGtKE3ekaaE0pwbFZ52Odtqi8OkU4PGJdyJLmRI=;
 b=mylrnoot6wyVUS1F9smjGpmCbeznGK/Ve/lp5yc404FlnSU90P4kkxMW0lpMLoa5lWNnlXjM7HzbQDdu43vIEoicEeiR/q9QThon6UYNh7dFhS/ZZr+prt/dnBdqr7uS+GuNNpzAvwRTCZYBA9l81x2YGRGRgUX1QBw5rVj17PkWFGrSdFiAU6KdEs4pcy8ebf2t3N2vYku5gH+XwYX9NJFk31TU1sGYYVOJt9cFvgMpQArDwvJzxf7nS+cuTbq43LeYlI3EKs6lP+Ju0h1Q/NbxXE+o6Ln6aoZ6EfBz+MgGx1OBC/sesslnbUKejuCjUQnByMcRTTu97rvYaxtyBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb1OaGtKE3ekaaE0pwbFZ52Odtqi8OkU4PGJdyJLmRI=;
 b=dxajTsNOQoormsEGl2LfCnSdPYMIE8M0H701l79buSIOVL2LyjwuoHthLUN86bnktOpuO4SeiV1p+M88Ttunlpo0dbc9KkIiPtLa9Soft8m2yZ9FkXqzrlDogVT5CDHIwu/IylRoKi8CeR2huYCsXNLNr8qkHEgyGI1tKRI4gBG7F7oTBjNJv/9XXL9zOGNX18jwHcORcR/u4S5q9tBQGdFoiNhj8bsINoYrTejSzhBNqeWiABfS3VleoZZDFEtXoLWa8Y5nUIE5TtTg3IBhUnf0YgkU7UiZtIwPYpKIob2HsUCpYcC/RuScLyodxMkv7/mj3fzZJG80mcbsIevMkg==
Received: from BN1PR13CA0009.namprd13.prod.outlook.com (2603:10b6:408:e2::14)
 by CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 20:55:02 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::27) by BN1PR13CA0009.outlook.office365.com
 (2603:10b6:408:e2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 20:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 20:55:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:55:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:59 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:57 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 7/8] RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
Date:   Thu, 8 Sep 2022 23:54:20 +0300
Message-ID: <20220908205421.210048-8-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|CH3PR12MB7548:EE_
X-MS-Office365-Filtering-Correlation-Id: ecfc9ba8-d0f9-4b29-99f7-08da91dc662c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XcFNcizkaNFIABd4V0t4nqLz7ga9cajlcQPjFZhw90zkeBLlwGZSx5gpiO4OO9XK+PciwV2CtLT2fuZGaHs5HM1zMDieC7udRdrSVjAgmVI6TzffMYYe7iB89RhdYoBWx5aqskElQeWMylp5uTsar50QcLMbI3d4vuM95kXgApgo3IcTbDoCf+KliYvlV7VPfeGwSGnR/6Cet2ZUa7tjLgbXBxQQFXmubDmAh7u3SW56P7OCCxwDSw3joex+K6JmSvK2jaGwB+pES4NTchqARdHYTqaDcP+GOMuSfr5f3R9r59mhEOTltOQcVLt2YyNevzsV8dKPoUIIwpaqGKz8XmlgaZiF+/Ihh0jjvDmy7HH7Ey+A2un2Ze7mgzyAiJGBA2d1N12YYJ1w0Hk8lVZ5+6AutcPsq9fJZ8Jd/qJI6PdawzyNVOlFgtaUeUnXc8mwtaY9tPzL/+6qiXB+QDlGSYOXWAKsHa/m0pu+LGzEjsQ7ZA4IY/z1LKNfTLPBNdAk9Ex40E93YS8jp8A4Fi+UWKIZuJPMIhtzSzDEqRfHVm6ZDkraiQuv8TB1nVK5Nib9xcbwCL/dTYWsw4S6ampXJH0QMOVKQHaYUYzgrVFLlUxsndSCMYwtJciOpsUCbsB5++CAmADlfn1WP6iOHM+kfpP3FdCbvVTAV2YNOjj63X9CXrUFxS9wIcFI/idkw/GrKoMlRTQjPF9+zl+X1401uNObWKvJcQZTAMra4uTy12raCKWSZUAf0vVXaQfBiOHApwRQWwyJ62ieD4XxrOa2DBRTApg7q5inVdQtDHL19STheGBkKIOc6b7AXrxyZWwl
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(6666004)(47076005)(82310400005)(426003)(36756003)(26005)(7696005)(336012)(82740400003)(1076003)(107886003)(5660300002)(186003)(83380400001)(36860700001)(2906002)(2616005)(8936002)(4326008)(70206006)(70586007)(8676002)(41300700001)(40480700001)(478600001)(40460700003)(81166007)(356005)(6636002)(110136005)(54906003)(316002)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:55:01.7347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfc9ba8-d0f9-4b29-99f7-08da91dc662c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Currently, when dereging an MR, if the mkey doesn't belong to a cache
entry, it will be destroyed.
As a result, the restart of applications with many non-cached mkeys is
not efficient since all the mkeys are destroyed and then recreated.
This process takes a long time (for 100,000 MRs, it is ~20 seconds for
dereg and ~28 seconds for re-reg).

To shorten the restart runtime, insert all cacheable mkeys to the cache.
If there is no fitting entry to the mkey properties, create a temporary
entry that fits it.

After a predetermined timeout, the cache entries will shrink to the
initial high limit.

The mkeys will still be in the cache when consuming them again after an
application restart. Therefore, the registration will be much faster
(for 100,000 MRs, it is ~4 seconds for dereg and ~5 seconds for re-reg).

The temporary cache entries created to store the non-cache mkeys are not
exposed through sysfs like the default cache entries.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 drivers/infiniband/hw/mlx5/mr.c      | 48 +++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 7fd3b47190b1..109e3d666264 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -629,6 +629,8 @@ struct mlx5_ib_mkey {
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
+	/* User Mkey must hold either a cache_key or a cache_ent. */
+	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
 };
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6977d0cbbe6f..1e7b3c2d71a7 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -812,6 +812,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 			return ERR_PTR(err);
 		}
 		mr->mmkey.ndescs = ndescs;
+		mr->mmkey.rb_key = rb_key;
 	}
 	mr->mmkey.type = MLX5_MKEY_MR;
 	init_waitqueue_head(&mr->mmkey.wait);
@@ -1723,6 +1724,42 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }
 
+static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
+				    struct mlx5_ib_mr *mr)
+{
+	struct mlx5_mkey_cache *cache = &dev->cache;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+
+	if (mr->mmkey.cache_ent) {
+		xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
+		mr->mmkey.cache_ent->in_use--;
+		xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
+		goto end;
+	}
+
+	mutex_lock(&cache->rb_lock);
+	node = mlx5_cache_find_smallest_ent(&dev->cache, mr->mmkey.rb_key);
+	mutex_unlock(&cache->rb_lock);
+	if (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
+			mr->mmkey.cache_ent = ent;
+			goto end;
+		}
+	}
+
+	ent = mlx5r_cache_create_ent(dev, mr->mmkey.rb_key);
+	if (IS_ERR(ent))
+		return PTR_ERR(ent);
+
+	mr->mmkey.cache_ent = ent;
+
+end:
+	return push_mkey(mr->mmkey.cache_ent, false,
+			 xa_mk_value(mr->mmkey.key));
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -1768,16 +1805,11 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	/* Stop DMA */
-	if (mr->mmkey.cache_ent) {
-		xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
-		mr->mmkey.cache_ent->in_use--;
-		xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
-
+	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
 		if (mlx5r_umr_revoke_mr(mr) ||
-		    push_mkey(mr->mmkey.cache_ent, false,
-			      xa_mk_value(mr->mmkey.key)))
+		    cache_ent_find_and_store(dev, mr))
 			mr->mmkey.cache_ent = NULL;
-	}
+
 	if (!mr->mmkey.cache_ent) {
 		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
 		if (rc)
-- 
2.17.2

