Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F77867BFEF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 23:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236291AbjAYW25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 17:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjAYW24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 17:28:56 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CF160C8C
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 14:28:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOF0HzOcTqF59eHVvStrQAwxUmrcHvcwmzT4tGPtFc7WuTAOjwWFSTsZcSHiOEBGtDMIg5uaiXqS/Ug3SXnN15LF8U3dxFCgXGoCiFaDBOcrrl/ZdlG34Kb9skX1C5bIyrvR+ZCaoWdl+Z1/B7lZELEPH6RDm6tcAFcbp4pvTbFB7U9+IHz7dY+wFn+n0HgUYachYzoM3NuyOCO8RvuA39PJuetYk/SqpVHynRJ8yz1TF24p+oEFGY8f7d9KYSQ5/U6Y7zQmq4QhLa759Bnf+K6I1j5NHqPeUsgJsrf9AayLFB+BvfaQRS1Hyp/yL7vT8GuUEJx4gZhRIGBYLRTIEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi07oQN5AvVlqoLxBtWnbc13FmiFxvmLK8MHguzYtnc=;
 b=lMwacXtTH7ADXmaue0R5BVVBS2z9ftSKBVUnNq6gianKEi7RLGWTWtAMWN3xgCz1F5yZjaEvRD+w4DSmcPRyCaM1VJejGOf0BcalCWSqBK6YynE1VXWWLM77ddDYPF8nC7yysy95hEUG6qHtwtrZHiFetz0EBBtel37tzhOfHMLqN7/xmx5fJ27q2++ZZnXkvFMTvTBWJuecn1UtYiQKVx1EOBmc4bSd+Yen+aIg3AgzrUH7SwTAfgJW4MMGfWJuNsfnPkDIMT9dHbvSvYuPbp634r/xY2F3Emsw5CTDReZJASwTcrkN2ybc9Uc8lwcPMANnniRZoyS6NiwqLGiA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi07oQN5AvVlqoLxBtWnbc13FmiFxvmLK8MHguzYtnc=;
 b=ji/X/05IsQ0FAK4FcF0EC8QH40GuXUbqpaD94qqlN5gCoXY4hyo8Ye4oBt7KOo9vCrXf+eOVdPhm+Ux60IrkNj++DkeztuhiEOHtj0YBGwHxgSPOK0rkJhhtT6ZeB0kRD2WNWcj5Bey9EhSeRdkJ798Ro5vmTkyMJKrHWWl7WBu8R72i6uuFklnBGdF4o+Qe12e6iqdRUIfJ9dZvI93YeOL3MCqVE72XLd6R8ESA5vJBEp7xASsOKZY9EHAOO24HDIjwHaDnYtd2bRK016MBvzBKvuNVztHoNnR8yCCwML77mJSmQH+khZ7xfYpSue+hFDNRCeFnXBRkXpgrXYkluA==
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by IA1PR12MB6483.namprd12.prod.outlook.com (2603:10b6:208:3a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:28:43 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::3) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 22:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 22:28:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 14:28:30 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 14:28:30 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 14:28:28 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v5 rdma-next 3/6] RDMA/mlx5: Change the cache structure to an RB-tree
Date:   Thu, 26 Jan 2023 00:28:04 +0200
Message-ID: <20230125222807.6921-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230125222807.6921-1-michaelgur@nvidia.com>
References: <20230125222807.6921-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|IA1PR12MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: f14398e5-ec86-402e-7506-08daff2383c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAUec+2gYCdlPFER1oCanIUaQwSq3I6kmQK1+Icfr8dhQfrUa1HL7t9Q+VVKJRV6NcnjGQQzrWKFgVigcD76skbUEjqCClGyWquINAt/B9E8GnFaKcsw6wei2+Esv7I+qBe9BfHz0YPo+6fpxD+JjbdLqFVM2GhhVTFbvuy0f4KjFfHZ6iTnuCF1zmxJPp3QdM9vmkzDoCxgbexKYdLo+k6uk+pTBJpEZu9GU9GXJs5dxEarfOmPfbKz3MCcCpG27qOyciXPWBwqtsiRnQfEXO2EcN5hEyhyhJhK7AQFyFHsGxPArXzFQrNKYv2kIhc/LGvCA+9MZm/OkY1uEYaAiyilw2NyG6/lC3dqJjH1VihxKCSw3rIMdV7Zoet2UK12C5363fuOwHOwEJrqdCqeavGEJmHbe7IT9ekt8NxfyvLTO9qsVdV+Vht0LfgMVIlBzbC3fgXHU6LCggAQZ7K0pPl87NHjFyCAxsbPodYft4RSIbmCjq9lpErO3CY/EDUWvh84efKR+H5TzXHQFFSMZO4HQSc5GedLqOfv/HykD5ggGb1Ql0HhJNNRivUFTgNPtnO8R7cJd3wFE3eHyAzhS33a4uwrh+TZkdDrm4JIH8KlBt9u1HsGBjGWOu59caRVKqhNEK+xdkhrHubzV+GpUKYk7Nk0n4saTcqXDoZZpfj+c10JbkHeCNkrZUh+4EBnkmN9rNROARmfLAVN6COFFq3F2eGtET6i2X5NcaEJ/LE=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(26005)(426003)(336012)(478600001)(2616005)(54906003)(8676002)(186003)(107886003)(47076005)(1076003)(70206006)(70586007)(110136005)(36756003)(356005)(7696005)(30864003)(2906002)(82740400003)(86362001)(41300700001)(7636003)(5660300002)(40480700001)(6666004)(316002)(40460700003)(4326008)(8936002)(82310400005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:28:42.5037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f14398e5-ec86-402e-7506-08daff2383c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6483
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

