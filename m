Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C941E61F8B1
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbiKGQPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiKGQPQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3519FB48B
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr7TXi2dBvCVEv42IU2zOzj/3V1YtZf/vt+tnolfLIh3nwO7NClnZJWDc79Q7wg3gGX5/r85N+a0v2EzMmiGr53JS5Vdfn/1sMEI6e/fQIFLgWkrJtqngV+h26r+ttTZxGsi+vqNHaorLWnPBTE53QAfrFU6PYQ7qzvQkrOJgYX4jsj6/G5SKTB9r4j8uhRvEgot7FwoHfXv+9T9LGLEq9fp9rsBlaV2hvsBbNJH08E/P5sFuGmgJlTvFKs2UgzQ/PDyx3EUUDf6zp+wVypQ7hQl2bp3eh8tKcA3nLPG98/t/s9abIWmlUYQ69Uzqz1sVnK+ICyAATZuCwj/VpT1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04Nm7OrzAcL/CD/gEDxOkjTgj43WyMSTk4jirbzT46c=;
 b=DQSRUWgkdPG5wNPqf5k3dCW1YTh7NkDJKIrPtvyViIuq9MUb8BcrbUM5eh2FelkqbFI3L7L6TepZGEcG6L/9S4xBVXwwpsADyqNg5sJXrbgiTWLBOl7CsmtgQCV4ZmjVf2MlGSZXextBoTBFMcFFrvZ1dT/gmMIiqgfz/v9iM3pN7gq2IMYXCL/6LImw5sEDe/1qMELJnY/e868dSPBBdafJEE7pWdwPeaoYwFCIvbNK9HZ1/3L9tL6GWEdaw/OouoobJWTtknWsjR+YAUyGBx5U+eiJawjmtm71Nb+dChCY7sb3PdqusRJ7bSP0MLvynCL/GxiiR/bNnxLoVeJMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04Nm7OrzAcL/CD/gEDxOkjTgj43WyMSTk4jirbzT46c=;
 b=kpbP1L/eCqO29KAVu9f8McsJYOx4Azuh4o9GH0slnN6pKZQsmQ4M7ONayNIiOk93UvgFr76q43iuLH3Jx7hNkKCE2avkIexYxu5RMzUCYeKDkbRQzFtH8oOYB9kw3/22L+wOX5Gy4nR2J43pqQLtBpkY9R1r8T3TZeZKVXqcBOALMl5UgbVpxjPo6pHKy/voSBY3OkNgXIUtr4AC+w/2OA5cSky7h2f+2j1x3HXiurhQTeq60MIr8ubBKTqg1fvsSgNssAZp3uXbJ7Qix0pZ48C2ybmjWE6cogUpCQmJ+2bVIlgtzZah5WD8bMtgNvKOgskaDLqKcVv0EmBqynS9yw==
Received: from DM6PR10CA0002.namprd10.prod.outlook.com (2603:10b6:5:60::15) by
 PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:15:12 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::af) by DM6PR10CA0002.outlook.office365.com
 (2603:10b6:5:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:15:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:15:03 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:15:01 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 5/8] RDMA/mlx5: Introduce mlx5r_cache_rb_key
Date:   Mon, 7 Nov 2022 18:14:46 +0200
Message-ID: <20221107161449.5611-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: d209da53-27e4-4290-b067-08dac0db3f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FmRbbhyPq08JzidSzf6kgMqUslQMMmOJsK7MexYn1qucwPgrwdpPT2GwEm8h7dZDApcWohRJXNSfQZHpJldwiicIomIGndMAPCVklL2eaF9iFMOHXf3S5STEDZhOlny9x4GSe217oi2+Z0gDD9G9POg/TQhXf/z6usbT80PZ4LtBrJ7LOOrVDxGLQj/82ink6xTl3TFNLpepEODCyCjdFpKq8IHS2/s/XQhmqjPD3W+iumrdZQk2I5ZSaYE8Bo0Y5iU5Uh4kxaVFl2IXhnqcwhxLdigtjoR6D/aEtwSppY306nKUgYElg7WUFLUryziIPzWedL4A13P0wq+ce/rppq2OvEA+dLfbtQWszX1UTzybODmsvTek8UUYV9j6ZQ3tEOt0kINlR+KEiV546sDnQnLQYkJ6oAjz4jL5+BKzVJyFXvDSL5nQSR4/obNwDdyYruVmGVe/o4MR3J/fcnjTpiCO0J9OtsO9mBc/eGv00FDgM31dPqbn29eFkXncvutxjura9I4cEsrU9RzXanefTqMNvtWySQjdXBMnSqz0nV4SCS1TH0WSoy6Zge1hT7DRhFEf1Oi/wHalECmoGMeiYY84zx9A5APoiwbvIXjCcEuuzaVPviJMiGsnw2HLQImwtpw1fNNnQ4eU9FORu7nbuW9R62+li1a/iFeR9EPv1LltR7KsHraPRXrI21EU6J4YkEje/MLOTWVUiTQ4JST38bF3jopdkuyAqsomc9TgxIwOC9h3vs1ijmWJsZDkaESq+AqM3U+wRIBaCSrbZxDlzrc7Yjk1DyUfLH1lTOvvTc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(46966006)(36840700001)(40470700004)(336012)(107886003)(426003)(2616005)(26005)(6666004)(186003)(1076003)(47076005)(7696005)(36860700001)(83380400001)(2906002)(40460700003)(40480700001)(82310400005)(110136005)(54906003)(478600001)(41300700001)(5660300002)(8936002)(4326008)(70586007)(316002)(70206006)(8676002)(36756003)(82740400003)(356005)(7636003)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:12.2363
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d209da53-27e4-4290-b067-08dac0db3f9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

In the next patch, I will change the cache structure to an RB tree.
Introducing the key of the tree.
The key is all the mkey properties that UMR operations can't modify.
Using this key to define the cache entries and to search and create
cache mkeys.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 14 +++++-
 drivers/infiniband/hw/mlx5/mr.c      | 73 +++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/odp.c     |  8 ++-
 3 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 84d3b917c33e..939ec3759eba 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -613,6 +613,16 @@ enum mlx5_mkey_type {
 	MLX5_MKEY_INDIRECT_DEVX,
 };
 
+struct mlx5r_cache_rb_key {
+	unsigned int access_mode;
+	unsigned int access_flags;
+	/*
+	 * keep ndescs as the last member so entries with about the same ndescs
+	 * will be close in the tree
+	 */
+	unsigned int ndescs;
+};
+
 struct mlx5_ib_mkey {
 	u32 key;
 	enum mlx5_mkey_type type;
@@ -732,10 +742,10 @@ struct mlx5_cache_ent {
 	unsigned long		stored;
 	unsigned long		reserved;
 
+	struct mlx5r_cache_rb_key rb_key;
+
 	char                    name[4];
 	u32                     order;
-	u32			access_mode;
-	unsigned int		ndescs;
 
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index fe5567c57897..e7a3d4fa52d0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -287,18 +287,18 @@ static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
 	return ret;
 }
 
-static void set_cache_mkc(struct mlx5_ib_dev *dev, u8 access_mode,
-			  unsigned int access_flags, unsigned int ndescs,
-			  void *mkc)
+static void set_cache_mkc(struct mlx5_ib_dev *dev,
+			  struct mlx5r_cache_rb_key rb_key, void *mkc)
 {
-	set_mkc_access_pd_addr_fields(mkc, access_flags, 0, dev->umrc.pd);
+	set_mkc_access_pd_addr_fields(mkc, rb_key.access_flags, 0,
+				      dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, access_mode_1_0, rb_key.access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (rb_key.access_mode >> 2) & 0x7);
 
 	MLX5_SET(mkc, mkc, translations_octword_size,
-		 get_mkc_octo_size(access_mode, ndescs));
+		 get_mkc_octo_size(rb_key.access_mode, rb_key.ndescs));
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 }
 
@@ -317,7 +317,7 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 			return -ENOMEM;
 		mkc = MLX5_ADDR_OF(create_mkey_in, async_create->in,
 				   memory_key_mkey_entry);
-		set_cache_mkc(ent->dev, ent->access_mode, 0, ent->ndescs, mkc);
+		set_cache_mkc(ent->dev, ent->rb_key, mkc);
 		async_create->ent = ent;
 
 		err = push_mkey(ent, true, NULL);
@@ -343,8 +343,8 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 }
 
 /* Synchronously create a cacheable mkey */
-static int create_cache_mkey(struct mlx5_ib_dev *dev, u8 access_mode,
-			     unsigned int access_flags, unsigned int ndescs,
+static int create_cache_mkey(struct mlx5_ib_dev *dev,
+			     struct mlx5r_cache_rb_key rb_key,
 			     struct mlx5_ib_mkey *mkey)
 {
 	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
@@ -356,7 +356,7 @@ static int create_cache_mkey(struct mlx5_ib_dev *dev, u8 access_mode,
 	if (!in)
 		return -ENOMEM;
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	set_cache_mkc(dev, access_mode, access_flags, ndescs, mkc);
+	set_cache_mkc(dev, rb_key, mkc);
 
 	err = mlx5_ib_create_mkey(dev, mkey, in, inlen);
 	kfree(in);
@@ -647,7 +647,7 @@ static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 	}
 
 	mr->mmkey.key = pop_stored_mkey(ent);
-	mr->mmkey.ndescs = ent->ndescs;
+	mr->mmkey.ndescs = ent->rb_key.ndescs;
 	mr->mmkey.cache_ent = ent;
 	queue_adjust_cache_locked(ent);
 	ent->in_use++;
@@ -668,29 +668,57 @@ static struct mlx5_cache_ent *mkey_cache_ent_from_order(struct mlx5_ib_dev *dev,
 	return &cache->ent[order];
 }
 
-static bool mlx5_cache_get_mkey(struct mlx5_ib_dev *dev, u8 access_mode,
-				u8 access_flags, unsigned int ndescs,
+static bool mlx5_cache_get_mkey(struct mlx5_ib_dev *dev,
+				struct mlx5r_cache_rb_key rb_key,
 				struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent;
 
-	if (!mlx5r_umr_can_reconfig(dev, 0, access_flags))
+	if (!mlx5r_umr_can_reconfig(dev, 0, rb_key.access_flags))
 		return false;
 
-	if (access_mode == MLX5_MKC_ACCESS_MODE_KSM)
+	if (rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
 		ent = &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY];
 
-	ent = mkey_cache_ent_from_order(dev, order_base_2(ndescs));
+	ent = mkey_cache_ent_from_order(dev, order_base_2(rb_key.ndescs));
 	if (!ent)
 		return false;
 
 	return mlx5_ent_get_mkey(ent, mr);
 }
 
+static int get_uchangeable_access_flags(struct mlx5_ib_dev *dev,
+					int access_flags)
+{
+	int ret = 0;
+
+	if ((access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	    MLX5_CAP_GEN(dev->mdev, atomic) &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
+		ret |= IB_ACCESS_REMOTE_ATOMIC;
+
+	if ((access_flags & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
+		ret |= IB_ACCESS_RELAXED_ORDERING;
+
+	if ((access_flags & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+		ret |= IB_ACCESS_RELAXED_ORDERING;
+
+	return ret;
+}
+
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 				       unsigned int access_flags,
 				       unsigned int ndescs)
 {
+	struct mlx5r_cache_rb_key rb_key = {
+		.access_mode = access_mode,
+		.access_flags = get_uchangeable_access_flags(dev, access_flags),
+		.ndescs = ndescs
+	};
 	struct mlx5_ib_mr *mr;
 	int err;
 
@@ -698,13 +726,12 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	if (!mlx5_cache_get_mkey(dev, access_mode, access_flags, ndescs, mr)) {
+	if (!mlx5_cache_get_mkey(dev, rb_key, mr)) {
 		/*
 		 * Didn't find an mkey in cache.
 		 * Create an mkey with the exact needed size.
 		 */
-		err = create_cache_mkey(dev, access_mode, access_flags, ndescs,
-					&mr->mmkey);
+		err = create_cache_mkey(dev, rb_key, &mr->mmkey);
 		if (err) {
 			kfree(mr);
 			return ERR_PTR(err);
@@ -774,6 +801,8 @@ static void delay_time_func(struct timer_list *t)
 
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
+	struct mlx5r_cache_rb_key rb_key = { .access_mode =
+						    MLX5_MKC_ACCESS_MODE_MTT };
 	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
 	int i;
@@ -804,8 +833,8 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		if (ent->order > mkey_cache_max_order(dev))
 			continue;
 
-		ent->ndescs = 1 << ent->order;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
+		rb_key.ndescs = 1 << ent->order;
+		ent->rb_key = rb_key;
 		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
 		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
 		    mlx5r_umr_can_load_pas(dev, 0))
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 137143da5959..90339edddfed 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1589,10 +1589,14 @@ mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 
 void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
 {
+	struct mlx5r_cache_rb_key rb_key = {
+		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
+		.ndescs = mlx5_imr_ksm_entries
+	};
+
 	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
 		return;
-	ent->ndescs = mlx5_imr_ksm_entries;
-	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
+	ent->rb_key = rb_key;
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
-- 
2.17.2

