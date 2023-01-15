Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17AB66B14A
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 14:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAONfV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 08:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjAONfU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 08:35:20 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9786C13524
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 05:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lsqjtef1SQFQoXmXG2GORg1qzFsdPrwikR2GOf6Bliff9LIZZ8ZWS9LBzKr+KpBPltughAHkCAC9+STplTFb8AN6E85d0JeSF6AvQeGZkxSYYHvldC1wcX+k1INfgXOuqBAWS+aAnYFy8o/+dc+vqYWpl9ZxpODwCc0TXKxGinD6rDywa+02v21sJd80ClcNLETIFK61mTBRCbnlH1/UzhKdmS0+FexfT1+PAmzw9idCf8/b7HLOsgvkNWYt8REwGBR+jch2S3jth2JBOSu9EMCMf5K/AmLIRYiodS8v43AhjdE+c5NOoYu5lPtCqQL2XruL52VqSx5bbO3sZas1aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi07oQN5AvVlqoLxBtWnbc13FmiFxvmLK8MHguzYtnc=;
 b=MZoxJp6hG/3FBjuBlKaCjxQx2d3yfSRBLu5iUnN5tqNXOSxQeaVvam1udOuzNfshZ3geluAJ1zrlXb3KqCLBLGq7RnQL5EleN7hf6EOR/mt2TL05vNiJAg4xMqNazRE5bz5cMOqcwnppzOWUlUEv7X4YwFkGuZqqWlC6lVnZu2WT7iNkXmY1hvoBljdrldJbJe0R7157lQ1vgKtdkPO/9dxFjhWF82D+X2DBRL5c8Ec7ionFJbm4ELus/MDrW4yqaDTSbdenKEEm07PYKtUZYFFx7+1dH7fIlXbgYpFWn39Xh8Z+Rjgqbscvqdc267qXychRoeYCv3/2f9689jiW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi07oQN5AvVlqoLxBtWnbc13FmiFxvmLK8MHguzYtnc=;
 b=YwkchYNvbtnTwxbjUu1XgA7bMkOqPFw60AHvQp8kR48QvV6O4YnOXhv0dFrMxJt3sSCpAVBCo0IPqtUvUKJexpppYUTaRfMXddUNOanzo0K0pAno+g9O415spyqylyQkmI3fg+d9y85LN0OAxkz54byFUndkgd3Psav+zleGJKhlbFMmkeKbOgOyQ0ZXb/Y/Oa/GScTA7LmCl92fvlRnPM3seA//WR27P2KHdPjgo/cd4y4wUm1OLU1bsAivNV06ljmGoI1PBCb/aGChqu0Pmg//ET62cyiEQksbRW+dG8smg91JLGlkp7U5zf6M6N+SbdBSneyXy6SywPWY6vlPUQ==
Received: from MW4PR03CA0309.namprd03.prod.outlook.com (2603:10b6:303:dd::14)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 13:35:15 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::1b) by MW4PR03CA0309.outlook.office365.com
 (2603:10b6:303:dd::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 13:35:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 13:35:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:06 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:06 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 15 Jan
 2023 05:35:04 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v4 rdma-next 3/6] RDMA/mlx5: Change the cache structure to an RB-tree
Date:   Sun, 15 Jan 2023 15:34:51 +0200
Message-ID: <20230115133454.29000-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115133454.29000-1-michaelgur@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0b6bd4-99b6-40de-2745-08daf6fd55d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ccq8+MXSZJMgqUR8hISH0PE121yCbU8v7x2ziCim5aVmyEVl4uE77VGlSoRoyJdr3hVMmQV7/Ry5ZCdqch0nB40o1tzklFu5ll7YuvroH/bMimP47mp5TCKxEBS0bG2b10hADGyK0db2w61Jm/sRHEnzN6l1BI++jKCNHTkx7N4bf4wPNnZJMchHCbSJRiCVBl4SLvVeQA5c997F3mb8uOvoaGrMsJsIRI6XFTljEAUVMHjKYfchovJhYGfxzPmWhXJ+NsYONn/prtD8dfEKKzXavFtQMpj1KY+Zr5ZAd9aa5Ebe0EveTQTiy1DpDXl+s1C0zM1iMEWzZ3N7HdN7EfBfUAe/TSl0xyJYCPoFdvJAfbXuFbJaTlzA/0q/rBvm/AEY1UGQCIiHok1NgeGi1wtgAB6z4xpMaffFYgGeylQ5tnvOlJGPnyYtDCa/xK76FnrtTW4I7q0FrBe4lFWSOAvJwXGyaBT0pHx6KVpxkxXjFvmYnppZYAqi14M3IwRyQAPAP5zdobZS6qU4+SP7fM2crg2H+Jv/6d39X7+bhxXfqvMWYafK4K9M6ct5hmzjPHdcb5fAp1npXwFXUqCXzzczLOKfuREtLNo3BTOPf/kRaq7WPz8okgf3lpdYRwRQ19fSCYhJEhCKK14l7lxsRUsFzMCHz8yUVLYpAw8bggN3SITR6B2nOfD5oi/U2j4
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39850400004)(396003)(136003)(376002)(451199015)(46966006)(36840700001)(426003)(83380400001)(47076005)(36860700001)(82740400003)(7636003)(86362001)(356005)(2906002)(30864003)(40480700001)(41300700001)(5660300002)(82310400005)(8936002)(8676002)(478600001)(1076003)(70206006)(26005)(186003)(336012)(316002)(7696005)(6666004)(2616005)(70586007)(4326008)(107886003)(110136005)(54906003)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 13:35:15.1884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0b6bd4-99b6-40de-2745-08daf6fd55d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +-
 drivers/infiniband/hw/mlx5/mr.c      | 160 ++++++++++++++++++++-------
 drivers/infiniband/hw/mlx5/odp.c     |   8 +-
 3 files changed, 132 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 8d985f792367..eec16db2d536 100644
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
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 356c99d7ec9a..5cc618db277f 100644
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
index 72044f8ec883..71c3c611e10a 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -419,8 +419,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		return ERR_CAST(odp);
 
 	BUILD_BUG_ON(order > MKEY_CACHE_LAST_STD_ENTRY);
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

