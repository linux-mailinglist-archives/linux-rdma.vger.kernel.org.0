Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EF25B27F5
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiIHUzE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiIHUyw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:54:52 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FC0402FB
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:54:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOy7RajHUn6LYKTMcoK6wNRF+anUbGvZm5TazH5dzY90sKp9CxzwLv9Yz4i9ShKRaeX3Lz8sNYIN1AKEJfnkVYTrIz97SvUchoU/BadKu+JoFLYG+f210rt4WTo0SNQ8rvddBgEMgJ2VuwZiRmzkVK2GQMwFNmBROP1xLUqAu9Dn29KRfl2xNPR4aT4Wp3GYwFVyNzoPc8ja/SvOot9NZ2vp+CJ4/K1pk77aN+DI/BhU95L2TTzHvMmoqe/FrsN/H72wrnjX3Bz433MjGHpbtjr3z3CYbUCO/aJa2EcMIG5ARVNsBTOSBJyFCdkNMYzjBe6ZNrj6ceMi9dvGAS/rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkxKrHqOtrKcVsqu4nUFtoevAkrxm+76jOkJBUeX49k=;
 b=jOdh7t9HM7bsZ5irE2WxPYR+hKbIDRxd+nDD2HurHhVPxtzxZFYSs0FCZH1bESNQHIadHm7SNet81Jnegm7jpPgw75aF2QfdD2YG6ZOZqF1UnIbCCZ5XKzcIR34wLl1vJwyBQB/S30w8AF1wnp/13EmfRPxfaJRWcNuvpH45KT0ynMD87wEwLG3LHCaztixmU8Wfqj9TKxoSu9HboYj34CNw1UcEYP93Sc9QZ/QexjNsSPSZ2AAHXrFrWXHQuYxoLisl8cleoFd/RK5v98E3iVO8Ai5pyA2h1mcyvredxqwnF9nqjmDHl5rGHEnJpGJx5H/1U1OQBAGnWVIf0Gr6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkxKrHqOtrKcVsqu4nUFtoevAkrxm+76jOkJBUeX49k=;
 b=Lv0htTngherzCM4WGKzXRue0OXagvebH6t4e6qIsPP4w94duXQgIHl8+7jBvsRlUOBhK7Ma74OIC0GO2B7KB9jweinWjEyv7gRRqWMu7i+l0GTOSkeadgw7m2JvUNVX9KDDZjEGkRxZAci2LztyxXeWwSPTMsJAWFYzlHUaGTZrgk+DjUotInaxcYqSaHbRxZCrPOug71K4U7trZ0pg43ZT8V/rz0b9g0NR2mj/y0/4ZyQb6c8sMVUBHqF/EuHxc9p1TVulLeaJ3tC3UIUuMMCQIgaVapOyv0iR6HjhRRSPsu1rHW5KJ+Noahky5trIHd0rI9WfYrDrqiB3qaYkufA==
Received: from BN9PR03CA0359.namprd03.prod.outlook.com (2603:10b6:408:f6::34)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 8 Sep
 2022 20:54:48 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::85) by BN9PR03CA0359.outlook.office365.com
 (2603:10b6:408:f6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 20:54:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 20:54:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:54:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:46 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:44 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 2/8] RDMA/mlx5: Generalize mlx5_cache_cache_mr() to fit all cacheable mkeys
Date:   Thu, 8 Sep 2022 23:54:15 +0300
Message-ID: <20220908205421.210048-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1fa2c9-17a9-4a64-67fd-08da91dc5e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ec1DvvcrXroWXtS1Q2FD5Ql4qKpiXt911VG6CSpkshX0FJr8aWJFuXjslzOwFhKBwGj4ycrhDBBwgY4X/OaN7nmZyWJu9vmy4914QqWHhnry04mxDsogbJnoHbfkuM1d3kNnjkuP/xFhRw9svlcHU+16n6OaVxIUdVUTEcrkTKDCMHlX9s0ZbdQRzewx5ZqcELjg5uBe7I/gmoNHRByaBmvW8nylNAMPtxvADbXKHRNBQOD3JvA/kYHWvf1HWYXJiA5+lX5DEwvmtPcFsyru/+hGEIU2ZcU5C+f9hwTd9SHtGVXX+YZuEJSGUoupwngtqN72RIKYDrgMHz13wPO4BRfjZ1FG20mYDlWp4E4KSQ4JPuRoFk1SVrrbIOUc6VjXv37aqQXUlkOK7ME1RecXYM/yCf5mwNTRQHjaOuGEuROwEXv0V+hpND+agvTvwLxKJVMAEn+Yz2FLA1qsmEl53ks8uJ3d42hMgbqSU2upKv/ePihVuX5u5evBVEUFO6uoVV6OsLITv3oWCQuodSkCvxPEa6b2v006wW5l30Yar/9wjKKxH11OMfVQRIXu6UQdD0OUj6lFraC3uM4Wehp8bT8Q6C9N53KM7Mh2ZSHhdNIIxdYcQ5LBVWDIeERgDJNfsts7EkGXPMuW5vZ1ab+a+FIfhZpEgyn2dXQeaLMa96uZP0rAHfkEGF7reg/WuUUFUrUJ8Ki+jer6IpuFEzn5MNjy5fp0MtHk3v53HWhXCj3SqMYV75DIaVvsP18AS8LVmZWVB/B3T4bAMA69ryGatNWJuLFRqk+RgA5yXbp6DvY=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(40460700003)(41300700001)(70206006)(478600001)(4326008)(8676002)(110136005)(6636002)(316002)(70586007)(54906003)(86362001)(47076005)(107886003)(83380400001)(36860700001)(82740400003)(1076003)(81166007)(6666004)(2616005)(26005)(336012)(426003)(186003)(356005)(7696005)(36756003)(2906002)(8936002)(82310400005)(40480700001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:54:48.1795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1fa2c9-17a9-4a64-67fd-08da91dc5e1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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

All the mkeys that can use UMR, can be cached.
Instead of using reg_create() for mkeys that are not available in the
cache, generalize mlx5_cache_cache_mr() to fit all cacheable mkeys.
When a specific mkey request can not be satisfied by the available cache
mkeys, synchronously create an mkey with the requested properties.

On the following patches, I will introduce a mechanism to cache all
cacheable mkeys upon dereging the MR.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   6 +-
 drivers/infiniband/hw/mlx5/mr.c      | 146 +++++++++++++++------------
 drivers/infiniband/hw/mlx5/odp.c     |   9 +-
 3 files changed, 87 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d260132d8f45..cb8006b854e0 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1312,9 +1312,9 @@ int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
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
index d8bdba0056a1..b8529f73b306 100644
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
@@ -927,21 +951,11 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
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
-	    !mlx5r_umr_can_reconfig(dev, 0, access_flags)) {
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

