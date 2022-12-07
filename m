Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735DC6455E5
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 09:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLGI6r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 03:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLGI6f (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 03:58:35 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE2C0B
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 00:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSlCtxH1zcrFYOIW+CLkyDa/UJmDA0yBn7pVLf8ROFc2NL/Aw89boFV7DQgHU8dE7Qt4O4Tmsw6IomVJYUN3NC4BfljrwpJa4zS2TezhJAkym7y0m+Q2oaHjHDGw8EJw/0I0JX1roFGL3xS1Ii0Ufj3n/gi8nbf7LqAyuOTEa5ADeIv5DVA+MC+o6UcAGj1tuiYVUYBjP/tIYJ413MNyHp6YIH3c3JssyHo99x9wQCIR8m6XVA4rTO6aOc3KTQ5rnQpJxIowjy59J5OVfwFWTWLn/BmJYliXFIQvAg57tjvE+LAUbBTRiABl8CW9v7oj5FWN6Diy7c+kekDTHOl/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pcbK4uiJNOSsv6OiQBXXPogJv5CwRKvFknP1IITVdU=;
 b=kjJ86exnR5UQDZZLewIYUyzJ1iSKfZwJ8q6bx2IEuJ4FTIXjhhp0Msuoy81e+6Hdm4M8XDWyVteMoWrasz4o2+Z5afhQvcctMDluK4ATl5taLVf0KJzoleOJWDALY6rs/UdsRwddQEEnBJWgXCm0wXvmS8m2FAwzRy/JNFelVDC8RRqbIsQHdUMvteSvcRiBofLpnEiC860h1f9/ZAgMOh/AoizJoyRZhGd/yoS/Pa5uM7aMT5G8ZpcbYfAoZHYBNEcr4nUdzoUq5HcFZ58GD3+VbtABPL95wsy/q7fXdONpOIFMEkR154G5bSFeOZZar9V2Nv/q1qowbvUwZb7KHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4pcbK4uiJNOSsv6OiQBXXPogJv5CwRKvFknP1IITVdU=;
 b=Go7RYN1W/rUnYZ4e/IM2Tz2BBxGTiBWVlMvuLUxvwnMM11yemQLso8FjxuJq+rnXlr4QqRfIWKtIkeiK24DV8DlpYf/1nqwr7yWxSHi9j/AYOmEaEJvL9r9Ssa1rB0EP1sGeqOx+mgdp8EWgsdybtuhadgyhJK80UscgRfUsRr5jQwdr/n6GfT9ifvVhX7Wx0c3C0BRJ9aT/9E+Ll9oP/fCJENqigv2lYTzDDV+vZwY1kWGpleMa8NjW/QKe1JuJBjsfXPuFBzcIqRJ8+nCJTyQTrU9V82LkOgl9IqXBaCPPoqDUzdXuity57B8FwgxOMatzmoo2QM+nZGQ8cOWHFg==
Received: from DM6PR07CA0059.namprd07.prod.outlook.com (2603:10b6:5:74::36) by
 DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 08:58:32 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::bf) by DM6PR07CA0059.outlook.office365.com
 (2603:10b6:5:74::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 08:58:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 08:58:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:16 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 7 Dec
 2022 00:58:14 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 3/6] RDMA/mlx5: Change the cache structure to RB-tree
Date:   Wed, 7 Dec 2022 10:57:49 +0200
Message-ID: <20221207085752.82458-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221207085752.82458-1-michaelgur@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 887f6268-0302-4930-f002-08dad8313780
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5uLBM//AjT716+L04mzqGkWa4ChT0KM6jPDZVIdp0KOv8/FwZNpMujvXOFn3bpb60MnnGA036C14+g8yDJuXEFLN/YPtG+NMP+SpQUlLopSaGfUlGdgjro1ii8zofpk3TD9AroaQEUJdEmVq9egTS7fikNlLwhanOg9KbZnJmZByM1kBYfjzbZx7KtOBIR5AX+PjEWqI7fyBHHvOkJhrYB3d/2bbvhEh1FNw39rL+vP43XXoN7HoKe4dU+eGK9stQzEGy/HfhnBU1C1noLbjuDIMULgG1ja6zzs/oDLppP4Me2PPtziG1Ih3U1H+U0YNya1Ym6F+PR1/HDcZRoj5iEQUCJ/VFyH8mRB8Xtsxbk0cXpEa9CzvUxA3vz8b/BgYQMRQgQZWYHElIdh0bUHEU0GoVzRQE/Eld2snAk61mqrrzc4dXDv3/jkSOQKlHA1fif6AwYKj/cnWDbPQKbEpCG9Kcj2RBHyVo2L58mn6YRpNX7z8HssAl/LD4Q9S6ju2K0dAO+pg7G2i4c4/gsUAaFpesdySaS/DifDHaBoWE62AQGnezgRaqhZc0sF7rgNsfp7OoD60pC1nwn/qr6gHePcjwCOGrnnmmCoDOGvt1r22mqXLkStnp8k3io3S+IUnxSJXt5PtbL7uBWL6Eft4yhEXltsgeF75Jq1QpjYra4cWmCa2d5LkJgKrEOzEPKYGMML+OsYjEFj6RTxnC0i6n9IR4kPZCHsMih76r96LiDI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(83380400001)(36860700001)(356005)(7636003)(4326008)(86362001)(30864003)(40460700003)(2906002)(8936002)(316002)(40480700001)(8676002)(107886003)(26005)(5660300002)(6666004)(7696005)(82310400005)(1076003)(70586007)(2616005)(110136005)(47076005)(426003)(41300700001)(70206006)(336012)(186003)(54906003)(478600001)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:58:32.1134
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 887f6268-0302-4930-f002-08dad8313780
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, the cache structure is a static linear array. Therefore, his
size is limited to the number of entries in it and is not expandable.
The entries are dedicated to mkeys of size 2^x and no
access_flags. Mkeys with different properties are not cacheable.

In this patch, we change the cache structure to an RB-tree.
This will allow to extend the cache to support more entries with
different mkey properties.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  13 ++-
 drivers/infiniband/hw/mlx5/mr.c      | 160 ++++++++++++++++++++-------
 drivers/infiniband/hw/mlx5/odp.c     |   8 +-
 3 files changed, 133 insertions(+), 48 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 8d985f792367..10e22fb01e1b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -741,6 +741,8 @@ struct mlx5_cache_ent {
 	u32			access_mode;
 	unsigned int		ndescs;
 
+	struct rb_node		node;
+
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
 
@@ -770,8 +772,9 @@ struct mlx5r_async_create_mkey {
 
 struct mlx5_mkey_cache {
 	struct workqueue_struct *wq;
-	struct mlx5_cache_ent	ent[MAX_MKEY_CACHE_ENTRIES];
-	struct dentry		*root;
+	struct rb_root		rb_root;
+	struct mutex		rb_lock;
+	struct dentry		*fs_root;
 	unsigned long		last_add;
 };
 
@@ -1316,11 +1319,15 @@ void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
+struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
+					      int order);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       struct mlx5_cache_ent *ent,
 				       int access_flags);
 
+struct mlx5_ib_mr *mlx5_mr_cache_alloc_order(struct mlx5_ib_dev *dev, u32 order,
+					     int access_flags);
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
 struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
@@ -1362,7 +1369,7 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
-static inline void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}
+void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}
 static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 					 struct mlx5_ib_mr *mr, int flags) {}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 29ad674a9bcd..f35022067769 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -515,18 +515,22 @@ static const struct file_operations limit_fops = {
 
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
 
@@ -637,6 +641,59 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
+static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
+				 struct mlx5_cache_ent *ent)
+{
+	struct rb_node **new = &cache->rb_root.rb_node, *parent = NULL;
+	struct mlx5_cache_ent *cur;
+
+	mutex_lock(&cache->rb_lock);
+	/* Figure out where to put new node */
+	while (*new) {
+		cur = rb_entry(*new, struct mlx5_cache_ent, node);
+		parent = *new;
+		if (ent->order < cur->order)
+			new = &((*new)->rb_left);
+		if (ent->order > cur->order)
+			new = &((*new)->rb_right);
+		if (ent->order == cur->order) {
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
+static struct mlx5_cache_ent *mkey_cache_ent_from_order(struct mlx5_ib_dev *dev,
+							unsigned int order)
+{
+	struct rb_node *node = dev->cache.rb_root.rb_node;
+	struct mlx5_cache_ent *cur, *smallest = NULL;
+
+	/*
+	 * Find the smallest ent with order >= requested_order.
+	 */
+	while (node) {
+		cur = rb_entry(node, struct mlx5_cache_ent, node);
+		if (cur->order > order) {
+			smallest = cur;
+			node = node->rb_left;
+		}
+		if (cur->order < order)
+			node = node->rb_right;
+		if (cur->order == order)
+			return cur;
+	}
+
+	return smallest;
+}
+
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       struct mlx5_cache_ent *ent,
 				       int access_flags)
@@ -677,10 +734,16 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	return mr;
 }
 
-static void clean_keys(struct mlx5_ib_dev *dev, int c)
+struct mlx5_ib_mr *mlx5_mr_cache_alloc_order(struct mlx5_ib_dev *dev,
+					     u32 order, int access_flags)
+{
+	struct mlx5_cache_ent *ent = mkey_cache_ent_from_order(dev, order);
+
+	return mlx5_mr_cache_alloc(dev, ent, access_flags);
+}
+
+static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 {
-	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent = &cache->ent[c];
 	u32 mkey;
 
 	cancel_delayed_work(&ent->dwork);
@@ -699,8 +762,8 @@ static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
 
-	debugfs_remove_recursive(dev->cache.root);
-	dev->cache.root = NULL;
+	debugfs_remove_recursive(dev->cache.fs_root);
+	dev->cache.fs_root = NULL;
 }
 
 static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
@@ -713,12 +776,13 @@ static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
 
-	cache->root = debugfs_create_dir("mr_cache", mlx5_debugfs_get_dev_root(dev->mdev));
+	dir = mlx5_debugfs_get_dev_root(dev->mdev);
+	cache->fs_root = debugfs_create_dir("mr_cache", dir);
 
 	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
+		ent = mkey_cache_ent_from_order(dev, i);
 		sprintf(ent->name, "%d", ent->order);
-		dir = debugfs_create_dir(ent->name, cache->root);
+		dir = debugfs_create_dir(ent->name, cache->fs_root);
 		debugfs_create_file("size", 0600, dir, ent, &size_fops);
 		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
 		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
@@ -733,6 +797,30 @@ static void delay_time_func(struct timer_list *t)
 	WRITE_ONCE(dev->fill_delay, 0);
 }
 
+struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
+					      int order)
+{
+	struct mlx5_cache_ent *ent;
+	int ret;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
+	ent->order = order;
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
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
@@ -740,6 +828,8 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	int i;
 
 	mutex_init(&dev->slow_path_mutex);
+	mutex_init(&dev->cache.rb_lock);
+	dev->cache.rb_root = RB_ROOT;
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -749,13 +839,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
 	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
-		xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
-		ent->order = i + 2;
-		ent->dev = dev;
-		ent->limit = 0;
-
-		INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
+		ent = mlx5r_cache_create_ent(dev, i);
 
 		if (i > MKEY_CACHE_LAST_STD_ENTRY) {
 			mlx5_odp_init_mkey_cache_entry(ent);
@@ -785,14 +869,16 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 
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
@@ -802,8 +888,15 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
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
@@ -876,19 +969,6 @@ static int mkey_cache_max_order(struct mlx5_ib_dev *dev)
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
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 71b733fcac37..c41e091618ce 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -419,8 +419,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[order],
-				 imr->access_flags);
+	mr = mlx5_mr_cache_alloc_order(dev, order, imr->access_flags);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
 		return mr;
@@ -494,9 +493,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = mlx5_mr_cache_alloc(dev,
-				  &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY],
-				  access_flags);
+	imr = mlx5_mr_cache_alloc_order(dev, MLX5_IMR_KSM_CACHE_ENTRY,
+					access_flags);
 	if (IS_ERR(imr)) {
 		ib_umem_odp_release(umem_odp);
 		return imr;
-- 
2.17.2

