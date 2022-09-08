Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2461B5B27F8
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiIHUzU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiIHUzO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:55:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3688354CAB
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:55:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnNLNQlFLlNfuhagZyFmWTrO8WyRNZqZwoomn5vw2W/4zU/vQRMYosbdnEfxf9XMlCZIQG42Zd9aTk9vhaEC6V7L0iC6zwe46J/MIPBKbIU8tADr/j4SgdE395aQabLKDV8wBe3Coq64Rf/lj4jV3jRc3ClrBne1+J60bA8F1DpJzmVZmTh3gtKZpufV0blncxy2TaGqMZsyYK4PTbnLiXdybCJlENmUYhQ7rWyRTRTpy4AYA/izrHXhx6VxTDPSmO4PnMPcxIIXBGPriAKwXbHl6054enVpWhWPQrf+vaLCtheoYxF0W7i0OEGLvXl5ZLNaDcTHJOx5mKV4++YXsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPJaqAD33bFzb1aTKAJo2Lp0/CM4i4GMU5+eSHRbml0=;
 b=RulGiHWKxI8jyb6aQXLyQbkZsjJork6XK94p0f6hmO7FuJgBFMXXUpKZpiD8/yhvf4bhjy4U3ruCEEx56gN/fVZF3RE9/BTZkIDzDn7LMAwcdj/4zRaW5i4IkLKV83AP6Sf6q7jYfe+G9SfM1jY7FiJCqxmMV4FD0Se0bX7cGYg7Yckz/1pJDPTcWnmW1wNbz8auJY4iiOkkNUmbh7t1jsM6SsweA0fj1edj84dKXXGBqBXkIxSRWjkbr+Z149CjURkOS6ABmDCmD7X1IIGbBApXN/EiO2yGNxsDMpyStIZr16DJH0qMZLFlsadZi/gTOGCrpvF14qkPsAEdqa4bow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rPJaqAD33bFzb1aTKAJo2Lp0/CM4i4GMU5+eSHRbml0=;
 b=QYhfyPFAJsMuNqowQcNE8XMJhhtPVfgqEVyz0iACVNjd8CDpOGT1BXGyNJuNYDrwTknv1NTDaN4DY+/LgFdv6p5oJbz3cQfmXUPZBeVO6MDqWFm59o6RBuibyLqUq+hfgjL1gzlFQxqB8pnm+mo0GnF07V+/vwwQ4OnR2gPYowlSqSbBT82FOjrAktI7szAienw67aBhjUXSQLsyxR7/0ZsAkIAvwvWjMoCkIkghJ75MS5H609CZ2MoFMagDDsHSt4fDXNgs8gdJG9dv6q4YyHIcHy2vw36NIydBfL490dZxLpP+Dufy7Y6VCLKnEdnPZMsgyAEWNBAl4NjBFM7prw==
Received: from BN9PR03CA0203.namprd03.prod.outlook.com (2603:10b6:408:f9::28)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 20:54:59 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::ec) by BN9PR03CA0203.outlook.office365.com
 (2603:10b6:408:f9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 20:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.10 via Frontend Transport; Thu, 8 Sep 2022 20:54:58 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:54:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:57 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:55 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 6/8] RDMA/mlx5: Change the cache structure to an RB-tree
Date:   Thu, 8 Sep 2022 23:54:19 +0300
Message-ID: <20220908205421.210048-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: 41643f33-f6d5-48d6-6159-08da91dc6461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9+iG43m5Q/4XcWjjwoLkRXNQBzR+dFmDL1InppbLbSEvD+HPSNZ97nFqI+YI1WLcecXgdyZnA3eovsyZsFhSp2cGElEx2FvM2dVk5QG2FmK15Re4PI/Vi9e4Ic+KGxagQFdNXbzLkARVbxmHervlG2Uy+2U7aEEoZXUq8e+4hhyjQ3o/4PoMqNUjAgyfHasVgBrVy75RXKLoTw1gR/Y73Of7/sC+RqMzJNHZI2/rM3NX7H5ioDQyGJ7m/eO+5rd7ZI5pj8XpworwOOx9wC1vIuIs4N+bhx1FXYABk/f6F86X52fGSZRwjcLMCx/rt3+JIYM5PKH/aud59CJbUh8jJmdJwnhreYduHMARep94AJueHNFlmOUVDLvnfxyLg1Lbckaq9Jn8oNZ6aak28FNO548yFrGEtexk1VuSpcwXtZQO/I+MA4I89T1Fkj2QndvdsbKVyhDEANRQSikNqQECXWg9aSRiFZC+vzKwtciN39mG8vZlUicw0mNIkyFaq0i9gEBcHzLsKlEoSerfXWm7mockkRQyo+dOkfcnsEK3Sngw6Zq9JTwiU6gJ//xv6/pYmd5mRxZmQQPTIYOR4LhR4YdOeH1oRejiGrkv+nIv6qd/R0ERtgBHugQPy1ku+I1RxIa4NqrJtii6JBtCsddke1uUteFxJkhKijIfnYcrAW9dUtbb13ACTzay8LHlH54aE+CrCiGBC/ntGTNogSjPrVukJC5HAlzPSVtpA1ZZUzRjTFXOAr6H2z/sdNmwiHBhKe7/9qhQBjvU4DiVypA8k8FBuAsJdJHSbRG+tVP1ZU=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(39860400002)(376002)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(82310400005)(107886003)(8676002)(40480700001)(83380400001)(110136005)(54906003)(7696005)(6666004)(6636002)(316002)(26005)(36756003)(478600001)(8936002)(30864003)(86362001)(5660300002)(2906002)(4326008)(81166007)(70586007)(356005)(70206006)(82740400003)(2616005)(36860700001)(336012)(47076005)(426003)(186003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:54:58.7095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41643f33-f6d5-48d6-6159-08da91dc6461
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
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

Currently, the cache structure is a static linear array. Therefore, its
size is limited to the number of entries in it and is not expandable on
run-time.
The entries are dedicated to mkeys of size 2^x and no
access_flags. Mkeys with different properties are not cacheable.

In this patch, we change the cache structure to an RB-tree.
By this, we enable caching all user mkeys that can use umr.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  17 +-
 drivers/infiniband/hw/mlx5/mr.c      | 293 +++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/odp.c     |   9 +-
 3 files changed, 223 insertions(+), 96 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 5b57b2a24b47..7fd3b47190b1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -741,10 +741,10 @@ struct mlx5_cache_ent {
 	unsigned long		stored;
 	unsigned long		reserved;
 
+	struct rb_node		node;
 	struct mlx5r_cache_rb_key rb_key;
 
 	char                    name[4];
-	u32                     order;
 
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
@@ -775,8 +775,9 @@ struct mlx5r_async_create_mkey {
 
 struct mlx5_mkey_cache {
 	struct workqueue_struct *wq;
-	struct mlx5_cache_ent	ent[MAX_MKEY_CACHE_ENTRIES];
-	struct dentry		*root;
+	struct rb_root		rb_root;
+	struct mutex		rb_lock;
+	struct dentry		*fs_root;
 	unsigned long		last_add;
 };
 
@@ -1321,6 +1322,8 @@ void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
+struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
+					      struct mlx5r_cache_rb_key rb_key);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 				       unsigned int access_flags,
@@ -1348,7 +1351,7 @@ int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent);
+struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev);
 void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 			   struct mlx5_ib_mr *mr, int flags);
 
@@ -1367,7 +1370,11 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
-static inline void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}
+static inline struct mlx5_cache_ent *
+mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
+{
+	return NULL;
+}
 static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 					 struct mlx5_ib_mr *mr, int flags) {}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bb3d5a766cb8..6977d0cbbe6f 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -514,18 +514,22 @@ static const struct file_operations limit_fops = {
 
 static bool someone_adding(struct mlx5_mkey_cache *cache)
 {
-	unsigned int i;
-
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		struct mlx5_cache_ent *ent = &cache->ent[i];
-		bool ret;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+	bool ret;
 
+	mutex_lock(&cache->rb_lock);
+	for (node = rb_first(&cache->rb_root); node; node = rb_next(node)) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		ret = ent->stored < ent->limit;
 		xa_unlock_irq(&ent->mkeys);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&cache->rb_lock);
 			return true;
+		}
 	}
+	mutex_unlock(&cache->rb_lock);
 	return false;
 }
 
@@ -589,8 +593,8 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 			if (err != -EAGAIN) {
 				mlx5_ib_warn(
 					dev,
-					"command failed order %d, err %d\n",
-					ent->order, err);
+					"command failed order %s, err %d\n",
+					ent->name, err);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(1000));
 			}
@@ -636,6 +640,72 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
+static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
+				 struct mlx5_cache_ent *ent)
+{
+	struct rb_node **new = &cache->rb_root.rb_node, *parent = NULL;
+	struct mlx5_cache_ent *cur;
+	int cmp;
+
+	mutex_lock(&cache->rb_lock);
+	/* Figure out where to put new node */
+	while (*new) {
+		cur = rb_entry(*new, struct mlx5_cache_ent, node);
+		parent = *new;
+		cmp = memcmp(&ent->rb_key, &cur->rb_key,
+			     sizeof(struct mlx5r_cache_rb_key));
+		if (cmp < 0)
+			new = &((*new)->rb_left);
+		if (cmp > 0)
+			new = &((*new)->rb_right);
+		if (cmp == 0) {
+			mutex_unlock(&cache->rb_lock);
+			return -EEXIST;
+		}
+	}
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&ent->node, parent, new);
+	rb_insert_color(&ent->node, &cache->rb_root);
+
+	mutex_unlock(&cache->rb_lock);
+	return 0;
+}
+
+static struct rb_node *
+mlx5_cache_find_smallest_ent(struct mlx5_mkey_cache *cache,
+			     struct mlx5r_cache_rb_key rb_key)
+{
+	struct rb_node *node = cache->rb_root.rb_node;
+	struct mlx5_cache_ent *cur, *smallest = NULL;
+	int cmp;
+
+	/*
+	 * Find the smallest ent with ent.rb_key >= rb_key.
+	 */
+	while (node) {
+		cur = rb_entry(node, struct mlx5_cache_ent, node);
+
+		cmp = memcmp(&rb_key, &cur->rb_key,
+			     sizeof(struct mlx5r_cache_rb_key));
+		if (cmp < 0) {
+			/* cur.rb_key > rb_key */
+			smallest = cur;
+			node = node->rb_left;
+		}
+		if (cmp > 0)
+			node = node->rb_right;
+		if (cmp == 0)
+			return &cur->node;
+	}
+
+	return (smallest &&
+		smallest->rb_key.access_mode == rb_key.access_mode &&
+		smallest->rb_key.access_flags == rb_key.access_flags) ?
+		       &smallest->node :
+		       NULL;
+}
+
 static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 {
 	xa_lock_irq(&ent->mkeys);
@@ -655,36 +725,41 @@ static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 	return true;
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
 static bool mlx5_cache_get_mkey(struct mlx5_ib_dev *dev,
 				struct mlx5r_cache_rb_key rb_key,
 				struct mlx5_ib_mr *mr)
 {
+	struct mlx5_mkey_cache *cache = &dev->cache;
+	unsigned int order, upper_bound;
 	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
 
-	if (!mlx5r_umr_can_reconfig(dev, 0, rb_key.access_flags))
-		return false;
+	order = order_base_2(rb_key.ndescs) > 2 ?
+			order_base_2(rb_key.ndescs) : 2;
+	upper_bound = 1 << order;
+
+	/*
+	 * Find the smallest node within the range with available mkeys.
+	 */
+	mutex_lock(&cache->rb_lock);
+	node = mlx5_cache_find_smallest_ent(cache, rb_key);
+	while (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		if (ent->rb_key.access_mode != rb_key.access_mode ||
+		    ent->rb_key.access_flags != rb_key.access_flags ||
+		    ent->rb_key.ndescs > upper_bound)
+			break;
 
-	if (rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
-		ent = &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY];
+		if (mlx5_ent_get_mkey(ent, mr)) {
+			mutex_unlock(&cache->rb_lock);
+			return true;
+		}
 
-	ent = mkey_cache_ent_from_order(dev, order_base_2(rb_key.ndescs));
-	if (!ent)
-		return false;
+		node = rb_next(node);
+	}
+	mutex_unlock(&cache->rb_lock);
 
-	return mlx5_ent_get_mkey(ent, mr);
+	return false;
 }
 
 static int get_uchangeable_access_flags(struct mlx5_ib_dev *dev,
@@ -743,10 +818,8 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 	return mr;
 }
 
-static void clean_keys(struct mlx5_ib_dev *dev, int c)
+static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 {
-	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent = &cache->ent[c];
 	u32 mkey;
 
 	cancel_delayed_work(&ent->dwork);
@@ -765,26 +838,19 @@ static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
 
-	debugfs_remove_recursive(dev->cache.root);
-	dev->cache.root = NULL;
+	debugfs_remove_recursive(dev->cache.fs_root);
+	dev->cache.fs_root = NULL;
 }
 
-static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
+static void mlx5_cache_ent_debugfs_init(struct mlx5_ib_dev *dev,
+					struct mlx5_cache_ent *ent, int order)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
 	struct dentry *dir;
-	int i;
 
-	if (!mlx5_debugfs_root || dev->is_rep)
-		return;
-
-	cache->root = debugfs_create_dir("mr_cache", mlx5_debugfs_get_dev_root(dev->mdev));
-
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
-		sprintf(ent->name, "%d", ent->order);
-		dir = debugfs_create_dir(ent->name, cache->root);
+	if (cache->fs_root) {
+		sprintf(ent->name, "%d", order);
+		dir = debugfs_create_dir(ent->name, cache->fs_root);
 		debugfs_create_file("size", 0600, dir, ent, &size_fops);
 		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
 		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
@@ -799,68 +865,114 @@ static void delay_time_func(struct timer_list *t)
 	WRITE_ONCE(dev->fill_delay, 0);
 }
 
-int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
+struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
+					      struct mlx5r_cache_rb_key rb_key)
+{
+	struct mlx5_cache_ent *ent;
+	int ret;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
+	ent->rb_key = rb_key;
+	ent->dev = dev;
+
+	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
+
+	ret = mlx5_cache_ent_insert(&dev->cache, ent);
+	if (ret) {
+		kfree(ent);
+		return ERR_PTR(ret);
+	}
+	return ent;
+}
+
+static int mlx5_cache_init_default_entries(struct mlx5_ib_dev *dev)
 {
 	struct mlx5r_cache_rb_key rb_key = { .access_mode =
 						    MLX5_MKC_ACCESS_MODE_MTT };
 	struct mlx5_mkey_cache *cache = &dev->cache;
+	bool can_use_cache, need_cache;
 	struct mlx5_cache_ent *ent;
-	int i;
+	int order;
+
+	if (mlx5_debugfs_root && !dev->is_rep)
+		cache->fs_root = debugfs_create_dir(
+			"mr_cache", mlx5_debugfs_get_dev_root(dev->mdev));
+
+	can_use_cache = !dev->is_rep && mlx5r_umr_can_load_pas(dev, 0);
+	need_cache = (dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
+		     mlx5_core_is_pf(dev->mdev);
+
+	for (order = 2; order <= MKEY_CACHE_LAST_STD_ENTRY + 2; order++) {
+		rb_key.ndescs = 1 << order;
+		ent = mlx5r_cache_create_ent(dev, rb_key);
+		if (IS_ERR(ent))
+			return PTR_ERR(ent);
+
+		mlx5_cache_ent_debugfs_init(dev, ent, order);
+
+		if (can_use_cache && need_cache &&
+		    order <= mkey_cache_max_order(dev)) {
+			ent->limit =
+				dev->mdev->profile.mr_cache[order - 2].limit;
+			xa_lock_irq(&ent->mkeys);
+			queue_adjust_cache_locked(ent);
+			xa_unlock_irq(&ent->mkeys);
+		}
+	}
+
+	ent = mlx5_odp_init_mkey_cache_entry(dev);
+	if (ent) {
+		if (IS_ERR(ent))
+			return PTR_ERR(ent);
+
+		mlx5_cache_ent_debugfs_init(dev, ent,
+					    MLX5_IMR_KSM_CACHE_ENTRY + 2);
+	}
+
+	return 0;
+}
+
+int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
+{
+	int err;
 
 	mutex_init(&dev->slow_path_mutex);
-	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
-	if (!cache->wq) {
+	mutex_init(&dev->cache.rb_lock);
+	dev->cache.rb_root = RB_ROOT;
+	dev->cache.wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
+	if (!dev->cache.wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
 		return -ENOMEM;
 	}
 
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
-		xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
-		ent->order = i + 2;
-		ent->dev = dev;
-		ent->limit = 0;
-
-		INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
-
-		if (i > MKEY_CACHE_LAST_STD_ENTRY) {
-			mlx5_odp_init_mkey_cache_entry(ent);
-			continue;
-		}
-
-		if (ent->order > mkey_cache_max_order(dev))
-			continue;
-
-		rb_key.ndescs = 1 << ent->order;
-		ent->rb_key = rb_key;
-		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
-		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
-		    mlx5r_umr_can_load_pas(dev, 0))
-			ent->limit = dev->mdev->profile.mr_cache[i].limit;
-		else
-			ent->limit = 0;
-		xa_lock_irq(&ent->mkeys);
-		queue_adjust_cache_locked(ent);
-		xa_unlock_irq(&ent->mkeys);
-	}
-
-	mlx5_mkey_cache_debugfs_init(dev);
+	err = mlx5_cache_init_default_entries(dev);
+	if (err)
+		goto err;
 
 	return 0;
+err:
+	mlx5_mkey_cache_cleanup(dev);
+	return err;
 }
 
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 {
-	unsigned int i;
+	struct rb_root *root = &dev->cache.rb_root;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
 
 	if (!dev->cache.wq)
 		return 0;
 
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		struct mlx5_cache_ent *ent = &dev->cache.ent[i];
-
+	mutex_lock(&dev->cache.rb_lock);
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		ent->disabled = true;
 		xa_unlock_irq(&ent->mkeys);
@@ -870,8 +982,15 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_mkey_cache_debugfs_cleanup(dev);
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++)
-		clean_keys(dev, i);
+	node = rb_first(root);
+	while (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		node = rb_next(node);
+		clean_keys(dev, ent);
+		rb_erase(&ent->node, root);
+		kfree(ent);
+	}
+	mutex_unlock(&dev->cache.rb_lock);
 
 	destroy_workqueue(dev->cache.wq);
 	del_timer_sync(&dev->delay_timer);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 90339edddfed..b29ec4e0d8ff 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1587,16 +1587,17 @@ mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	return err;
 }
 
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
+struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
 {
 	struct mlx5r_cache_rb_key rb_key = {
 		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
 		.ndescs = mlx5_imr_ksm_entries
 	};
 
-	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
-		return;
-	ent->rb_key = rb_key;
+	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
+		return NULL;
+
+	return mlx5r_cache_create_ent(dev, rb_key);
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
-- 
2.17.2

