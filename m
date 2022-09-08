Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702EB5B27F7
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiIHUzS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiIHUzL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:55:11 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3921501B2
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:54:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CY5oPKw4FDeKGKsJNmtF97W88DDfiL0RFEmYxsuh/96O5Fk3yv18dIHUG6OabfYibT2isfLmlvQllaZvOD6VM7pruMei29MZf+lrTgBxyVtTGy9OWQpbw8V5KfblPLah1kW0pnrDFhehbE1GZUzhlXuZTh2zVV0qRqohqyCWIFhWyySoCgpTiDMxGiGlNZCs0fS1yyei/2nJQd+LXQQSIjzG5zeOh2scRnuThnjezYhVaR2juwX43c9bau/0xiSrGktC86rTB50tQmqJArLFZK5AqHKLnGP/WfVnM7lKqhH6QVeN4RmQyBz1z6KmSNEWZXI8so7mwEHVNkchgy8+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUKUjwZpYf8tVKLjYGvULc3L3VJYe+CeBScW1KffA7Q=;
 b=RNwku7Tc3z7Kslx+XgcX+YdQXo4mSZKv7iWAAUcJjV0npQ1Oo1p+cHGcAIF54Ys/RypNzlLFVG4l5rPdwoRmulFuYyqSbWmUnw7kcyq6FaUCmKzLNHqY0AUUh1AI8JYTIHNsF49B91+u/j5W7v0+NE1KP/TwZHqEwL9yFt8x1VYOHJDUvNVWFTSE0ZbzwpJILb0gVVoJI0u1Nx+N2zxpjgZod1554VL5H+6Gxn3DvA1EeHzq/CcCF3etRxfyALGg6iZxGbZ+im8iPrYuHMpe3f6+/VwqoXh/Bobd9g3UegcQTR+kcxFdEaXl0grkJmMn0iyrZtT/a4r0GiUxMdc11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUKUjwZpYf8tVKLjYGvULc3L3VJYe+CeBScW1KffA7Q=;
 b=CAlVdkrW3i6/dqtFEbCcpdDZAO60j7XKJG1crwRmMxq06nYwjPqScbZv99lcuswBF+/LoISEx2Qwafb8CtbWL1QcMo5bzGHSZeAVEK1FpikiCCAtadR3rUDsgMPMBQutzQWX36Y85YrJPlNqaK9rXUglkVqBWxfD5WIq+ZO7lxYIs+GXzQQLi1NMEmsGKFxiwu49A55KbeSmI2rSMZ5v16N50pEcvuG1TGWLPaRziSGDjopBWw9mfNvU32I9OAiJFH6zT0Z16Hbz/rbsRwYMy2u30td3gLyWp6LlB0y6o9GV379ppwjly6ByCDZhC7Dn13RQb0u9Zni5sCLmDgPs1w==
Received: from BN9PR03CA0070.namprd03.prod.outlook.com (2603:10b6:408:fc::15)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 20:54:57 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::37) by BN9PR03CA0070.outlook.office365.com
 (2603:10b6:408:fc::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Thu, 8 Sep 2022 20:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 20:54:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:54:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:54 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:52 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 5/8] RDMA/mlx5: Introduce mlx5r_cache_rb_key
Date:   Thu, 8 Sep 2022 23:54:18 +0300
Message-ID: <20220908205421.210048-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e00798-48a1-4c0e-eff9-08da91dc62cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KfXcFPu40c0pas5mfYrP3Z/lvXUVNAmNBnA202R775u1PjMfQcBNCyPGF+LGKTdcpGaoSJROuCfNIGos30oJJhwDtULfeMr2ilShjNjOH0KrZ+25W+8Q8d9zN8k0Jcw3rymjljRqeY5va18XeJKq42PLhCcdwmLIczUvLpakvhPFK6V2RY2WpZIG7E3oTIa9xmsRhQvL0xESy713SsHepCmR6s47+OnRG/gzAWKJHCAencTGFNSMXC4bLmASMCmX+5b2P5urYd0mWHIVYRKB4A5ZdFIprf1Yf/kkOgv4xA/KfkGEAJrKsajqa+ztGXzNNhPE3zoBudirVXgYJ6tQ40NGWUUCXJg0bTFKy/RIf3qfhqEdZEuWkGJxISSqZ/fXCAafo9j/S+vlVTyHLAOau6ogWOXqg6eZm81CR3kzasMr0uw/njFNf7vo/2Dm0rhLTg0zWveIOSPlLTgtFJPS7Bw114bHoEIIb+FYVhRA+5H2oIhRPY6BdbRpjZjXVXzstVDGOtgCF1XRbKTb1UBTC9UDzsQiZB4nX3cYnzaFOIgQgHDIHNMiv+MxJVb55s7d/vzc/eOqRXSaZyMq1dLUO4J4Dz1RdrPZcFcgKvPONhJdjQuAAxpinU8hKEO1TAAIVqAGvCFsSlJB5fIBDja5RQG0r/oSJ61PIEwi1oxscfI2bG7rxnUstqxekX1txDnfWnIY7U+4rpOmECran3sCEGGAR/LcK7Zadjs3MXvQ8L0QmRnk1CT21WuKRqgR99t8ca0fH77TJyQ1xfvNyPsxL7RMhDYdtnjnw779taP//S08DhrY9lsW5lWySXkEmrpv
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(40470700004)(36860700001)(5660300002)(8936002)(81166007)(2906002)(356005)(40460700003)(82740400003)(41300700001)(336012)(478600001)(26005)(6666004)(82310400005)(7696005)(6636002)(110136005)(316002)(54906003)(107886003)(70586007)(70206006)(83380400001)(40480700001)(4326008)(8676002)(2616005)(1076003)(426003)(186003)(47076005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:54:56.0473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e00798-48a1-4c0e-eff9-08da91dc62cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
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

In the next patch, I will change the cache structure to an RB tree.
Introducing the key of the tree.
The key is the mkey properties that UMR operations can't modify.
Using this key to define the cache entries and to search and create
cache mkeys.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 14 +++++-
 drivers/infiniband/hw/mlx5/mr.c      | 73 +++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/odp.c     |  8 ++-
 3 files changed, 69 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index cb8006b854e0..5b57b2a24b47 100644
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
@@ -731,10 +741,10 @@ struct mlx5_cache_ent {
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
index ea8634cafa9c..bb3d5a766cb8 100644
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

