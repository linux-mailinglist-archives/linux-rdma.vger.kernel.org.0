Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F1761F8B0
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232459AbiKGQPJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbiKGQPH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:07 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580DD6466
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SW+EwAH0IjXvlj29Us8rZYp/7qCWfojoqm0NoWYQyehgSv8PZWvqdYGlQr1MA4209Kq+LlO8Gf5La6EOzZexfvOdTre0mgxUGapwsyowtMbri8rfHNzFQI11FO3R5DGKh9o1Ip87N6E5m0W53fXAPFg0jXuNp+5dV+UrqjV7+4Dr0c4/QoelnEK6S2fAx0Waebc1c/yHiaqPH1ydM4Uo0yYeSdK0PVL096/isksTRJADLazgONh2OuLTkzniWFyHuszdEbH3fuS0+Xt0IVGb/wsw94oqzbo+Hb70rY87Cm/eSV/5mAtxeAL5EV1vh1doqce5owVbwdSxLGS5C94Yrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br0kq16L5UgO2GAGNxVdLvrn0t0X4FBPdIwRgi4wteQ=;
 b=OMm/6N40oa/K17a7LpFr/LfcmFYzCh/TaUmumoj1BEjmhw6gTIOZ1HegQ0a7ogm7gAsE2+4jXw9UxfyqQnvF+FIb14cw1mAKjuYZ2ewyMdELR4moxEflr5XK0vgLMKBthQ1mAIrQo3ut+yyyzKJGR3SjGjZmIxfpq1TeTvUUmdM/4X0DxAf1nIMGzc7rxlFz9794Phcnezb3C+YoI37QJUeqTGUWLGIbfWTk19NUXwUUCa7QSHkdHKa1cFl0R9Vy8GEclAZ4b9SiEvbYSM2kMYEu5hPWJFz06apxw8BhOzIF56UOOLRFEC9mDB+Z/+KsJlw5YskWHRiyRW13sO+R+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br0kq16L5UgO2GAGNxVdLvrn0t0X4FBPdIwRgi4wteQ=;
 b=TLqZDcbv2wFTTw4+Nqz7yXxP1dNjfqBQakkGzAM1V3UMFRjfL6oPpKapcVQGodGRoTLO1nDOgqhuRYTAz25f7xp576Uhc9yOdMalCo2g/9f0p3ZnV52QL/Ra+uCH1FjfxlYAFoeMU31V096zKiwgsiKu0Nb4w5zExq9v+Ro2+OQDGCMf3Jf3i29a5UWDkmyZNqOtoK164ukhyho2JTt61alBqS68woskmvClewpuTCkGq57ERzG99Z1X4KuvhzY6XFscRZHdUVfkWq9x534t/WsxizPA4kxM8AFX13L5RFxqtQCC9AZDLFSk/K2pFtDgc+X88rQ8P8T9ciupStcVRw==
Received: from DM6PR06CA0013.namprd06.prod.outlook.com (2603:10b6:5:120::26)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 16:15:01 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::1d) by DM6PR06CA0013.outlook.office365.com
 (2603:10b6:5:120::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:14:57 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:14:57 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:14:55 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 2/8] RDMA/mlx5: Generalize mlx5_cache_cache_mr() to fit all cacheable mkeys
Date:   Mon, 7 Nov 2022 18:14:43 +0200
Message-ID: <20221107161449.5611-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f365f3-c9bb-44c2-fcaa-08dac0db38c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e3KusM7mj9a+k9kWYywLvNd6qv10DHcpNgzTCq1+8q1CwWxsyVof7hF3pECAhD49m12nVcm7Svy62b8JsdH5lJUFVFaHnHh1POi4siIhT5iAlo9aSRwIB0Emi7pfhecIdh8YGxKA9ocb8Z3FUltlgKK3XSh/S/hvazomqryYAeEy6pqh1m8arY1WDYrNEcTQhhB4mBpgNAPNRJgRehWOwvoNznuSI4VfdJzXWRXGVm25JY7skrahNLrERjBxB14dPAMxhntsJ1tDbsDgy1vZOGNgsC2XO48julkO7cu0ym1mAd664RbC+Jd4oTVhf5bskG8Ax5Q/fxd4HkTvSw2at61ZbGv6H4boNiwpXGYnZfNRidFTvRkfF+I5vyXQGQ4Sk1nQnOUyT52Bl2bQe0Doz0uXQDuZhcRga98cLhTDi0s/6uL8wSnQbvL/HpVgKWLOm9Bs71kBfD3x7JTkLvevD3Ib5YJWxYFWF0SoPtcIF/Z3QrvRO6owg2fM0eTgOehMVd+ZsPYhw5HM5btzGQbnIQtnO5aoxpknMCyoDRV+d1QcBctaYqwrKMMGL8+xFMXTb+1KwCe3k7qx6p9kqpS120i6QrxGvZwBdcIkRS8ohdG39R//3W36EWMyJcudS0m72FQdBsCOS5rcitTFvptB/kn2jGh4iNyOVqYEMeD1yAo/FiZJC/lZwA4HNxUnxCQ0sjfnUj3tC1xkFnDJzX73VG8MEATeX37+ouy6Uzizai8oS1nU/CqBg/lnTclrg8Rfk7QZzIIICNsyYg31gMlilJY285NlveGAap+3ZbBwB6o=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(7636003)(478600001)(8936002)(26005)(82740400003)(86362001)(36860700001)(82310400005)(41300700001)(107886003)(426003)(186003)(1076003)(47076005)(7696005)(356005)(2616005)(336012)(40460700003)(70206006)(70586007)(4326008)(2906002)(316002)(5660300002)(83380400001)(8676002)(54906003)(6666004)(110136005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:00.7498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f365f3-c9bb-44c2-fcaa-08dac0db38c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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

All the mkeys that can use UMR, can be cached.
Generalize the flow so that creation of all mkeys that can be cached
will go through to the cache instead of reg_create().
This will allow us to to extend the cache in following patches to
support additional non-default cache entries.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +-
 drivers/infiniband/hw/mlx5/mr.c      | 147 +++++++++++++++------------
 drivers/infiniband/hw/mlx5/odp.c     |   9 +-
 3 files changed, 87 insertions(+), 75 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ac948bb3cfe1..84d3b917c33e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1313,9 +1313,9 @@ int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags);
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
+				       unsigned int access_flags,
+				       unsigned int ndescs);
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 29ad674a9bcd..8ff10944ff16 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -287,16 +287,18 @@ static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
 	return ret;
 }
 
-static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
+static void set_cache_mkc(struct mlx5_ib_dev *dev, u8 access_mode,
+			  unsigned int access_flags, unsigned int ndescs,
+			  void *mkc)
 {
-	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
+	set_mkc_access_pd_addr_fields(mkc, access_flags, 0, dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2, (ent->access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, access_mode_1_0, access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
 
 	MLX5_SET(mkc, mkc, translations_octword_size,
-		 get_mkc_octo_size(ent->access_mode, ent->ndescs));
+		 get_mkc_octo_size(access_mode, ndescs));
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 }
 
@@ -315,7 +317,7 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 			return -ENOMEM;
 		mkc = MLX5_ADDR_OF(create_mkey_in, async_create->in,
 				   memory_key_mkey_entry);
-		set_cache_mkc(ent, mkc);
+		set_cache_mkc(ent->dev, ent->access_mode, 0, ent->ndescs, mkc);
 		async_create->ent = ent;
 
 		err = push_mkey(ent, true, NULL);
@@ -340,8 +342,10 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 	return err;
 }
 
-/* Synchronously create a MR in the cache */
-static int create_cache_mkey(struct mlx5_cache_ent *ent, u32 *mkey)
+/* Synchronously create a cacheable mkey */
+static int create_cache_mkey(struct mlx5_ib_dev *dev, u8 access_mode,
+			     unsigned int access_flags, unsigned int ndescs,
+			     struct mlx5_ib_mkey *mkey)
 {
 	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	void *mkc;
@@ -352,14 +356,9 @@ static int create_cache_mkey(struct mlx5_cache_ent *ent, u32 *mkey)
 	if (!in)
 		return -ENOMEM;
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	set_cache_mkc(ent, mkc);
-
-	err = mlx5_core_create_mkey(ent->dev->mdev, mkey, in, inlen);
-	if (err)
-		goto free_in;
+	set_cache_mkc(dev, access_mode, access_flags, ndescs, mkc);
 
-	WRITE_ONCE(ent->dev->cache.last_add, jiffies);
-free_in:
+	err = mlx5_ib_create_mkey(dev, mkey, in, inlen);
 	kfree(in);
 	return err;
 }
@@ -637,41 +636,80 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags)
+static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 {
-	struct mlx5_ib_mr *mr;
-	int err;
+	xa_lock_irq(&ent->mkeys);
+	if (!ent->stored) {
+		queue_adjust_cache_locked(ent);
+		ent->miss++;
+		xa_unlock_irq(&ent->mkeys);
+		return false;
+	}
+
+	mr->mmkey.key = pop_stored_mkey(ent);
+	mr->mmkey.ndescs = ent->ndescs;
+	mr->mmkey.cache_ent = ent;
+	queue_adjust_cache_locked(ent);
+	ent->in_use++;
+	xa_unlock_irq(&ent->mkeys);
+	return true;
+}
+
+static struct mlx5_cache_ent *mkey_cache_ent_from_order(struct mlx5_ib_dev *dev,
+							unsigned int order)
+{
+	struct mlx5_mkey_cache *cache = &dev->cache;
+
+	if (order < cache->ent[0].order)
+		return &cache->ent[0];
+	order = order - cache->ent[0].order;
+	if (order > MKEY_CACHE_LAST_STD_ENTRY)
+		return NULL;
+	return &cache->ent[order];
+}
+
+static bool mlx5_cache_get_mkey(struct mlx5_ib_dev *dev, u8 access_mode,
+				u8 access_flags, unsigned int ndescs,
+				struct mlx5_ib_mr *mr)
+{
+	struct mlx5_cache_ent *ent;
 
 	if (!mlx5r_umr_can_reconfig(dev, 0, access_flags))
-		return ERR_PTR(-EOPNOTSUPP);
+		return false;
+
+	if (access_mode == MLX5_MKC_ACCESS_MODE_KSM)
+		ent = &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY];
+
+	ent = mkey_cache_ent_from_order(dev, order_base_2(ndescs));
+	if (!ent)
+		return false;
+
+	return mlx5_ent_get_mkey(ent, mr);
+}
+
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
+				       unsigned int access_flags,
+				       unsigned int ndescs)
+{
+	struct mlx5_ib_mr *mr;
+	int err;
 
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
-	xa_lock_irq(&ent->mkeys);
-	ent->in_use++;
-
-	if (!ent->stored) {
-		queue_adjust_cache_locked(ent);
-		ent->miss++;
-		xa_unlock_irq(&ent->mkeys);
-		err = create_cache_mkey(ent, &mr->mmkey.key);
+	if (!mlx5_cache_get_mkey(dev, access_mode, access_flags, ndescs, mr)) {
+		/*
+		 * Didn't find an mkey in cache.
+		 * Create an mkey with the exact needed size.
+		 */
+		err = create_cache_mkey(dev, access_mode, access_flags, ndescs,
+					&mr->mmkey);
 		if (err) {
-			xa_lock_irq(&ent->mkeys);
-			ent->in_use--;
-			xa_unlock_irq(&ent->mkeys);
 			kfree(mr);
 			return ERR_PTR(err);
 		}
-	} else {
-		mr->mmkey.key = pop_stored_mkey(ent);
-		queue_adjust_cache_locked(ent);
-		xa_unlock_irq(&ent->mkeys);
 	}
-	mr->mmkey.cache_ent = ent;
 	mr->mmkey.type = MLX5_MKEY_MR;
 	init_waitqueue_head(&mr->mmkey.wait);
 	return mr;
@@ -876,19 +914,6 @@ static int mkey_cache_max_order(struct mlx5_ib_dev *dev)
 	return MLX5_MAX_UMR_SHIFT;
 }
 
-static struct mlx5_cache_ent *mkey_cache_ent_from_order(struct mlx5_ib_dev *dev,
-							unsigned int order)
-{
-	struct mlx5_mkey_cache *cache = &dev->cache;
-
-	if (order < cache->ent[0].order)
-		return &cache->ent[0];
-	order = order - cache->ent[0].order;
-	if (order > MKEY_CACHE_LAST_STD_ENTRY)
-		return NULL;
-	return &cache->ent[order];
-}
-
 static void set_mr_fields(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 			  u64 length, int access_flags, u64 iova)
 {
@@ -916,9 +941,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 					     int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_cache_ent *ent;
+	unsigned int page_size, ndescs;
 	struct mlx5_ib_mr *mr;
-	unsigned int page_size;
 
 	if (umem->is_dmabuf)
 		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
@@ -927,22 +951,11 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 						     0, iova);
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
-	ent = mkey_cache_ent_from_order(
-		dev, order_base_2(ib_umem_num_dma_blocks(umem, page_size)));
-	/*
-	 * Matches access in alloc_cache_mr(). If the MR can't come from the
-	 * cache then synchronously create an uncached one.
-	 */
-	if (!ent || ent->limit == 0 ||
-	    !mlx5r_umr_can_reconfig(dev, 0, access_flags) ||
-	    mlx5_umem_needs_ats(dev, umem, access_flags)) {
-		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
-		mutex_unlock(&dev->slow_path_mutex);
-		return mr;
-	}
 
-	mr = mlx5_mr_cache_alloc(dev, ent, access_flags);
+	ndescs = ib_umem_num_dma_blocks(umem, page_size);
+
+	mr = mlx5_mr_cache_alloc(dev, MLX5_MKC_ACCESS_MODE_MTT,
+				 access_flags, ndescs);
 	if (IS_ERR(mr))
 		return mr;
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e9a29adef7dc..f7c9eeaa8e79 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -418,8 +418,8 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[MLX5_IMR_MTT_CACHE_ENTRY],
-				 imr->access_flags);
+	mr = mlx5_mr_cache_alloc(dev, MLX5_MKC_ACCESS_MODE_MTT,
+				 imr->access_flags, MLX5_IMR_MTT_ENTRIES);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
 		return mr;
@@ -493,9 +493,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = mlx5_mr_cache_alloc(dev,
-				  &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY],
-				  access_flags);
+	imr = mlx5_mr_cache_alloc(dev, MLX5_MKC_ACCESS_MODE_KSM, access_flags,
+				  mlx5_imr_ksm_entries);
 	if (IS_ERR(imr)) {
 		ib_umem_odp_release(umem_odp);
 		return imr;
-- 
2.17.2

