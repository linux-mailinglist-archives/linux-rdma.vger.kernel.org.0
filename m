Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C556455EB
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 09:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLGI64 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 03:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiLGI6n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 03:58:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED72CC
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 00:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eiq4gXD6PTkoECe21F3doeSY2SLmydpw3pdujP78vKA3PO2f6Dj6ZokY3RyUYJpVkf664dK+9WsvwBVdOoloIIIlbuU/RkUYLWxy0o3ZYOBt7X6+9709h03MYfCli5YapYIJ0we97DEzAL7DtsOlGazOBrrPXlkMp128IXsGoGbDhif53WJCvQmWbIU6rXOP4JOHh7eqMj80TAiOBS25jHLp7Xi6kc2LI1DiuW8DmWhX7U0fAjvopWAZgRECEpo43uJhKgO3uV1Wsogf2UKQLohnIRTxJbiqKZ2z05QyHakL/oY9sFTzoBQCUjdVV3CnhA3UrCwOB0UcPEWt7Nt+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8t6uT1+v8k0WUsMk3dONwnJ8KECIwh4O+/Yy9JyBrK4=;
 b=YGm7PKrwNdQ4H2hesOn1OZBSZgtm2KO+jgcKxPVHJxCBRidu+d4wkg35SM0bb615s2vT1anT0IN9SDPEvbZ5rr7ivN9Pn65E92JrHNiTn7D7Xz+dXubupBNUnww0X0xosMb5BR0LkgMwA+9Hc8duM38wyqHozY1xGqbO91WsOF1zlUKD1XtJp55hJszSkjwRLSmHOEQVmh61Uap2AqCjxJ9aQC0gYkMrW6Xse2a5gzkK8KnMNhk7eR86HGqOgY+4Vey4DrvYtKfNW1aBgqommdwzSRCx+Uih23rZR8gyXPDbhwc1WFR8vxCmID17gxqGzk89B77yewXYewTnAAiqEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8t6uT1+v8k0WUsMk3dONwnJ8KECIwh4O+/Yy9JyBrK4=;
 b=Xgh8xZvkSkydv8Bg/Vl4DFNB9MMsN16HnCk1rZwlBsXIvU5nSlWO6VNQfhXVrbVLl8olsJ50ycqQZR1doIiSOKI3CNqs52hRFOI57YWgS/CszpD7JnUYvOKA/ywMMUARtHHK3zgFKhWN+2YmVc9+ibAneLQ2E4IhyfZw6/GXOTa+IanXRFkBSMxLs/H1hF1H7p8e8igeGyj7QjyyATsUu1pOAJjl2zntjcG4NFMUqK6q1FqrrrusojqZRHGYpnP5qZV79SS8BvN2HlAb47LJpDPqOox5oYMhgciCVhF2FJyg3gB3fAqE/6x9B/yws/+SjkTD0aYTGl0gFIkkzwbEVg==
Received: from BN9PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:fb::13)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 08:58:39 +0000
Received: from BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::df) by BN9PR03CA0038.outlook.office365.com
 (2603:10b6:408:fb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 08:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT094.mail.protection.outlook.com (10.13.176.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.15 via Frontend Transport; Wed, 7 Dec 2022 08:58:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:20 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:19 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 7 Dec
 2022 00:58:17 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 4/6] RDMA/mlx5: Introduce mlx5r_cache_rb_key
Date:   Wed, 7 Dec 2022 10:57:50 +0200
Message-ID: <20221207085752.82458-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221207085752.82458-1-michaelgur@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT094:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adafad4-e29f-43ea-bde6-08dad8313ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74pvs+3Zd2CCONGsbjeV6LwrVoFiJY/IrGx32O9rSwAwe6LhabeB/lZDVQ/R+8lB61JL97+xkKKby0QBjDo2cpQBvHuUVysjSEnWU49iFmOE5Du9c5Tx7Oq5qwGt1oCbwhS9FEjiW2ohyJC7roLxv26anuKV/ImQI4W3is/f0hLXl/zBMZ41mU9eM5sucrMrHft8RpXNUBqxPJV7GvaMoX7bYIc7IWFb+5tTrMtBws4uocyZEQQWt4ubAphfoq5eIU6VOXh0TDZF1idYNTyKFDCaxbbdlr//KTdEh+BkG56Q54tggn41n3+GlboorTCvPVe5n63Nw/WCURnOKEac0hUrJU0N3wE4sDuwunOoQzTKnJUgBxuJjIMUWlCwmCioQJDR2+LPy6eIQHjNlV0mDCf9mE63ZfW3ryTTa4njkvjH+xrUXLeBeC465Aeagufx3D/8DhnOx5qNQ/5vKKBjpl4TVt1Wqa/J/u2fwPp2aCl0kJ8lnzxfFjhge3/qHJqYPh++l5v5ADFInefa2ymH21morqvXeiE5QsuNpiDZ4yetnjnaTZm2EuV6wVOgOgpPXCf1EJJBKw9VxqoHWH9doN/rqwwXmZawBzMsX2P4MYgkVe7lYJBevzFfNIV2MtY9geU90uRhI/lm6lQc8AcJ8mSwkq/wqxnS+h0VnQ99zVtAquiZtevxr57GIcentbE3mmvx2hGJgQ9ME2uMZ76wzs1vX2JvaLgc8cdGfVCmMrU=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(83380400001)(82310400005)(40480700001)(36756003)(40460700003)(70206006)(1076003)(70586007)(41300700001)(336012)(186003)(86362001)(356005)(7636003)(26005)(110136005)(82740400003)(4326008)(2616005)(6666004)(47076005)(5660300002)(30864003)(8936002)(8676002)(54906003)(316002)(426003)(107886003)(478600001)(7696005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:58:39.0095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adafad4-e29f-43ea-bde6-08dad8313ba6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Switch from using the mkey order to using the new struct as the key to
the RB tree of cache entries.
The key is all the mkey properties that UMR operations can't modify.
Using this key to define the cache entries and to search and create
cache mkeys.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  32 +++--
 drivers/infiniband/hw/mlx5/mr.c      | 196 +++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/odp.c     |  26 ++--
 3 files changed, 180 insertions(+), 74 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 10e22fb01e1b..d795e9fc2c2f 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -731,17 +731,26 @@ struct umr_common {
 	unsigned int state;
 };
 
+struct mlx5r_cache_rb_key {
+	u8 ats:1;
+	unsigned int access_mode;
+	unsigned int access_flags;
+	/*
+	 * keep ndescs as the last member so entries with about the same ndescs
+	 * will be close in the tree
+	 */
+	unsigned int ndescs;
+};
+
 struct mlx5_cache_ent {
 	struct xarray		mkeys;
 	unsigned long		stored;
 	unsigned long		reserved;
 
 	char                    name[4];
-	u32                     order;
-	u32			access_mode;
-	unsigned int		ndescs;
 
 	struct rb_node		node;
+	struct mlx5r_cache_rb_key rb_key;
 
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
@@ -1320,14 +1329,13 @@ int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
 struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      int order);
+					      struct mlx5r_cache_rb_key rb_key,
+					      bool debugfs);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags);
+				       int access_flags, int access_mode,
+				       int ndescs);
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc_order(struct mlx5_ib_dev *dev, u32 order,
-					     int access_flags);
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
 struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
@@ -1350,7 +1358,7 @@ int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent);
+struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev);
 void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 			   struct mlx5_ib_mr *mr, int flags);
 
@@ -1369,7 +1377,11 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}
+static inline struct mlx5_cache_ent *
+mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
+{
+	return NULL;
+}
 static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 					 struct mlx5_ib_mr *mr, int flags) {}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index f35022067769..6531e38ef4ec 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -292,11 +292,13 @@ static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
 	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2, (ent->access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, access_mode_1_0, ent->rb_key.access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2,
+		(ent->rb_key.access_mode >> 2) & 0x7);
 
 	MLX5_SET(mkc, mkc, translations_octword_size,
-		 get_mkc_octo_size(ent->access_mode, ent->ndescs));
+		 get_mkc_octo_size(ent->rb_key.access_mode,
+				   ent->rb_key.ndescs));
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 }
 
@@ -594,8 +596,8 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 			if (err != -EAGAIN) {
 				mlx5_ib_warn(
 					dev,
-					"command failed order %d, err %d\n",
-					ent->order, err);
+					"add keys command failed, err %d\n",
+					err);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(1000));
 			}
@@ -641,22 +643,44 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
+static int cache_ent_key_cmp(struct mlx5r_cache_rb_key key1,
+			     struct mlx5r_cache_rb_key key2)
+{
+	int res;
+
+	res = key1.ats - key2.ats;
+	if (res)
+		return res;
+
+	res = key1.access_mode - key2.access_mode;
+	if (res)
+		return res;
+
+	res = key1.access_flags - key2.access_flags;
+	if (res)
+		return res;
+
+	return key1.ndescs - key2.ndescs;
+}
+
 static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 				 struct mlx5_cache_ent *ent)
 {
 	struct rb_node **new = &cache->rb_root.rb_node, *parent = NULL;
 	struct mlx5_cache_ent *cur;
+	int cmp;
 
 	mutex_lock(&cache->rb_lock);
 	/* Figure out where to put new node */
 	while (*new) {
 		cur = rb_entry(*new, struct mlx5_cache_ent, node);
 		parent = *new;
-		if (ent->order < cur->order)
+		cmp = cache_ent_key_cmp(cur->rb_key, ent->rb_key);
+		if (cmp > 0)
 			new = &((*new)->rb_left);
-		if (ent->order > cur->order)
+		if (cmp < 0)
 			new = &((*new)->rb_right);
-		if (ent->order == cur->order) {
+		if (cmp == 0) {
 			mutex_unlock(&cache->rb_lock);
 			return -EEXIST;
 		}
@@ -670,40 +694,45 @@ static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 	return 0;
 }
 
-static struct mlx5_cache_ent *mkey_cache_ent_from_order(struct mlx5_ib_dev *dev,
-							unsigned int order)
+static struct mlx5_cache_ent *
+mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
+			   struct mlx5r_cache_rb_key rb_key)
 {
 	struct rb_node *node = dev->cache.rb_root.rb_node;
 	struct mlx5_cache_ent *cur, *smallest = NULL;
+	int cmp;
 
 	/*
 	 * Find the smallest ent with order >= requested_order.
 	 */
 	while (node) {
 		cur = rb_entry(node, struct mlx5_cache_ent, node);
-		if (cur->order > order) {
+		cmp = cache_ent_key_cmp(cur->rb_key, rb_key);
+		if (cmp > 0) {
 			smallest = cur;
 			node = node->rb_left;
 		}
-		if (cur->order < order)
+		if (cmp < 0)
 			node = node->rb_right;
-		if (cur->order == order)
+		if (cmp == 0)
 			return cur;
 	}
 
-	return smallest;
+	return (smallest &&
+		smallest->rb_key.access_mode == rb_key.access_mode &&
+		smallest->rb_key.access_flags == rb_key.access_flags &&
+		smallest->rb_key.ats == rb_key.ats) ?
+		       smallest :
+		       NULL;
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags)
+static struct mlx5_ib_mr *_mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
+					struct mlx5_cache_ent *ent,
+					int access_flags)
 {
 	struct mlx5_ib_mr *mr;
 	int err;
 
-	if (!mlx5r_umr_can_reconfig(dev, 0, access_flags))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
@@ -734,12 +763,43 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	return mr;
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc_order(struct mlx5_ib_dev *dev,
-					     u32 order, int access_flags)
+static int get_unchangeable_access_flags(struct mlx5_ib_dev *dev,
+					 int access_flags)
 {
-	struct mlx5_cache_ent *ent = mkey_cache_ent_from_order(dev, order);
+	int ret = 0;
+
+	if ((access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	    MLX5_CAP_GEN(dev->mdev, atomic) &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
+		ret |= IB_ACCESS_REMOTE_ATOMIC;
 
-	return mlx5_mr_cache_alloc(dev, ent, access_flags);
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
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
+				       int access_flags, int access_mode,
+				       int ndescs)
+{
+	struct mlx5r_cache_rb_key rb_key = {
+		.ndescs = ndescs,
+		.access_mode = access_mode,
+		.access_flags = get_unchangeable_access_flags(dev, access_flags)
+	};
+	struct mlx5_cache_ent *ent = mkey_cache_ent_from_rb_key(dev, rb_key);
+	if (!ent)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return _mlx5_mr_cache_alloc(dev, ent, access_flags);
 }
 
 static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
@@ -766,28 +826,32 @@ static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 	dev->cache.fs_root = NULL;
 }
 
+static void mlx5_mkey_cache_debugfs_add_ent(struct mlx5_ib_dev *dev,
+					    struct mlx5_cache_ent *ent)
+{
+	int order = order_base_2(ent->rb_key.ndescs);
+	struct dentry *dir;
+
+	if (ent->rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
+		order = MLX5_IMR_KSM_CACHE_ENTRY + 2;
+
+	sprintf(ent->name, "%d", order);
+	dir = debugfs_create_dir(ent->name, dev->cache.fs_root);
+	debugfs_create_file("size", 0600, dir, ent, &size_fops);
+	debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
+	debugfs_create_ulong("cur", 0400, dir, &ent->stored);
+	debugfs_create_u32("miss", 0600, dir, &ent->miss);
+}
+
 static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
 {
+	struct dentry *dbg_root = mlx5_debugfs_get_dev_root(dev->mdev);
 	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
-	struct dentry *dir;
-	int i;
 
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
 
-	dir = mlx5_debugfs_get_dev_root(dev->mdev);
-	cache->fs_root = debugfs_create_dir("mr_cache", dir);
-
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = mkey_cache_ent_from_order(dev, i);
-		sprintf(ent->name, "%d", ent->order);
-		dir = debugfs_create_dir(ent->name, cache->fs_root);
-		debugfs_create_file("size", 0600, dir, ent, &size_fops);
-		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
-		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
-		debugfs_create_u32("miss", 0600, dir, &ent->miss);
-	}
+	cache->fs_root = debugfs_create_dir("mr_cache", dbg_root);
 }
 
 static void delay_time_func(struct timer_list *t)
@@ -798,7 +862,8 @@ static void delay_time_func(struct timer_list *t)
 }
 
 struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      int order)
+					      struct mlx5r_cache_rb_key rb_key,
+					      bool debugfs)
 {
 	struct mlx5_cache_ent *ent;
 	int ret;
@@ -808,7 +873,10 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 		return ERR_PTR(-ENOMEM);
 
 	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
-	ent->order = order;
+	ent->rb_key.ats = rb_key.ats;
+	ent->rb_key.access_mode = rb_key.access_mode;
+	ent->rb_key.access_flags = rb_key.access_flags;
+	ent->rb_key.ndescs = rb_key.ndescs;
 	ent->dev = dev;
 
 	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
@@ -818,11 +886,18 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 		kfree(ent);
 		return ERR_PTR(ret);
 	}
+
+	if (debugfs)
+		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
+
 	return ent;
 }
 
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
+	struct mlx5r_cache_rb_key rb_key = {
+		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
+	};
 	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
 	int i;
@@ -838,19 +913,26 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
+	mlx5_mkey_cache_debugfs_init(dev);
 	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = mlx5r_cache_create_ent(dev, i);
-
-		if (i > MKEY_CACHE_LAST_STD_ENTRY) {
-			mlx5_odp_init_mkey_cache_entry(ent);
+		if (i > mkey_cache_max_order(dev))
 			continue;
+
+		if (i == MLX5_IMR_KSM_CACHE_ENTRY) {
+			ent = mlx5_odp_init_mkey_cache_entry(dev);
+			if (!ent)
+				continue;
+		}
+		else {
+			rb_key.ndescs = 1 << (i + 2);
+			ent = mlx5r_cache_create_ent(dev, rb_key, true);
 		}
 
-		if (ent->order > mkey_cache_max_order(dev))
-			continue;
+		if (IS_ERR(ent)) {
+			mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
+			return PTR_ERR(ent);
+		}
 
-		ent->ndescs = 1 << ent->order;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
 		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
 		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
 		    mlx5r_umr_can_load_pas(dev, 0))
@@ -862,8 +944,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		xa_unlock_irq(&ent->mkeys);
 	}
 
-	mlx5_mkey_cache_debugfs_init(dev);
-
 	return 0;
 }
 
@@ -995,6 +1075,9 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 					     struct ib_umem *umem, u64 iova,
 					     int access_flags)
 {
+	struct mlx5r_cache_rb_key rb_key = {
+		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
+	};
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
@@ -1007,8 +1090,11 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 						     0, iova);
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
-	ent = mkey_cache_ent_from_order(
-		dev, order_base_2(ib_umem_num_dma_blocks(umem, page_size)));
+
+	rb_key.ndescs = ib_umem_num_dma_blocks(umem, page_size);
+	rb_key.ats = mlx5_umem_needs_ats(dev, umem, access_flags);
+	rb_key.access_flags = get_unchangeable_access_flags(dev, access_flags);
+	ent = mkey_cache_ent_from_rb_key(dev, rb_key);
 	/*
 	 * Matches access in alloc_cache_mr(). If the MR can't come from the
 	 * cache then synchronously create an uncached one.
@@ -1022,7 +1108,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		return mr;
 	}
 
-	mr = mlx5_mr_cache_alloc(dev, ent, access_flags);
+	mr = _mlx5_mr_cache_alloc(dev, ent, access_flags);
 	if (IS_ERR(mr))
 		return mr;
 
@@ -1451,7 +1537,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
 	if (WARN_ON(!*page_size))
 		return false;
-	return (1ULL << mr->mmkey.cache_ent->order) >=
+	return (mr->mmkey.cache_ent->rb_key.ndescs) >=
 	       ib_umem_num_dma_blocks(new_umem, *page_size);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index c41e091618ce..90de87ba3b96 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -406,7 +406,6 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 						unsigned long idx)
 {
-	int order = order_base_2(MLX5_IMR_MTT_ENTRIES);
 	struct mlx5_ib_dev *dev = mr_to_mdev(imr);
 	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
@@ -419,7 +418,9 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	mr = mlx5_mr_cache_alloc_order(dev, order, imr->access_flags);
+	mr = mlx5_mr_cache_alloc(dev, imr->access_flags,
+				 MLX5_MKC_ACCESS_MODE_MTT,
+				 MLX5_IMR_MTT_ENTRIES);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
 		return mr;
@@ -493,8 +494,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = mlx5_mr_cache_alloc_order(dev, MLX5_IMR_KSM_CACHE_ENTRY,
-					access_flags);
+	imr = mlx5_mr_cache_alloc(dev, access_flags, MLX5_MKC_ACCESS_MODE_KSM,
+				  mlx5_imr_ksm_entries);
 	if (IS_ERR(imr)) {
 		ib_umem_odp_release(umem_odp);
 		return imr;
@@ -1587,12 +1588,19 @@ mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	return err;
 }
 
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
+struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
 {
-	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
-		return;
-	ent->ndescs = mlx5_imr_ksm_entries;
-	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
+	struct mlx5r_cache_rb_key rb_key = {
+		.ats = 0,
+		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
+		.access_flags = 0,
+		.ndescs = mlx5_imr_ksm_entries,
+	};
+
+	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
+		return NULL;
+
+	return mlx5r_cache_create_ent(dev, rb_key, true);
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
-- 
2.17.2

