Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28967BFF3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 23:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbjAYW3C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 17:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjAYW3B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 17:29:01 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7943260CA2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 14:28:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yow+YnmIi/VHGQDFEM+WQLpJV1TckyAxcBDWZ9EoTSABAjI7r3oRNQo1VaqmdpaLM6YQX6AgmA8/ivEDV/LuNXTsGB2b5uiIm+L8MP86usv2VcUmEVYfSUf9fmGxCeA10CBdF9JnDtkA0xte1+JvPlNBW/itvGQ/540+y04ayVB+inG/vch2x6qTrSC5r7YQi4hXm1vFaLc9m4cyqQrSbkzbB25w4Z+rofOl9UhR5uDr0wGd4H49QVlvBBc6Tv8ynsGkkR2UnyFjiOx5RITxEc7jDb4TIbpyfMcg7Zq4b42GQLWB7jHzIO1EgIkIk/C4c9aUFV9p7aDrQiqFtQ9c4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTm1/zCCH1a0sY5imL+Qm7pbVaUi+1hGQ9oGPcBzfA4=;
 b=OHlC5HeEs5S3VROfUwDWAaemvi1X1PsS8b9aTuYJg4EpfnhZGhUy58Cur965Z2PLmLB8lW7sIFLgjGX1H8e0JKuZwM5TnBCgjjAlNu1NhaFgsItMG+nm799XOjyv3bdPlwq0uas1QWsUSYtnzX1+4zG+/fbAEyOE6Lz84EBKCxBBYmOVQeHppJNPuKph5INMO4GxaFrTlwjYz/92YCh7qjF6Av+ziDuG9J2Sbcra5IY61MSeUXP/lQLjO4Gr54WECOTJ6FhGBzAwBnkn3HbF6bKvW78ALUDYDnm5rO/PJltL03ajHFWiHR905WPE74WJGWAXoHx2yJzU6+lprOPRJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTm1/zCCH1a0sY5imL+Qm7pbVaUi+1hGQ9oGPcBzfA4=;
 b=qMR7xdIxKxz6AfxmvDrPYwYcQfgW6K9Q3FtrOwEC3HkQgJ7TvKpm1XwvrvaipKFcZGcbLcLn65wFvkmhOuQwsAgaAnJqtVKaShIwwze71tHDCPBdstWyB1C2QZnyS6im8AzPqoHBQt4H6+PPynsU26yQGCwOL/hNVpLTUKxyhGwUMszwGGjiBqRuenEylZg17dnTaaD4xc85UjUdgzwYb1M19S1D9alVTrmSS4pvr2SurPm8IS6wuBrw6RealjmY7doPbbUYbddXjeHf2Xh7reO4Sbva4WBczqAB3H7gfGCmEOMGscn9+lHANvkEr+ELM2rTdgEGOAikHgRs16t1Aw==
Received: from MW4PR03CA0177.namprd03.prod.outlook.com (2603:10b6:303:8d::32)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:28:46 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::b3) by MW4PR03CA0177.outlook.office365.com
 (2603:10b6:303:8d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Wed, 25 Jan 2023 22:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 22:28:46 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 14:28:37 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 14:28:36 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 14:28:35 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v5 rdma-next 6/6] RDMA/mlx5: Add work to remove temporary entries from the cache
Date:   Thu, 26 Jan 2023 00:28:07 +0200
Message-ID: <20230125222807.6921-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230125222807.6921-1-michaelgur@nvidia.com>
References: <20230125222807.6921-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|SN7PR12MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 4866f858-9699-49a4-f107-08daff2385ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pb3MdmV1wm8w5iVJKvXJvELPV0vkQmxM5MG08ECKdCDK1z/S7+j40zBB6YbBbzNqLB8oqNqJdOJcdNJ+H91TdascVuV3sqAhR3435ofrFLhEax5jWH6lMEbdtcO+MirQtvi3hIvWYauPcPP4qFj2EPBJLMT9SDiMZN8CwjI8VOPliqzCkaKJRcZerqyrE08NjUvdjkR8X8uwYda8EkgCBdVBzImDAXbJ2PFypZfwjI3SWzjlDBZqOXMUty3l0xUNTzW01O8dZ/ldrQ+rJxIwEj58UmNGAKCFfb2zPItZC2iBny9ysBDXhRrcLLJh2o1SWTGd3s+Sh8beiENQOfTHd5nzfn4uksczBc/m9m9hNZG5MGs2TY08BUPFKuV3Sm15CwMEi0c8p/OH/dAurqyPNqiuzwUdvKhwuxyyVqsU8wNw2ZGT1LCpZkamOatw6YJj9Uy7ZVBbbmwQvI6Tb4IyKzQtwsrbI1EXoDcHGhKROqVWEN7/jjxvq1tzc0RRlrDbcP4hszHBeDfdJHFQksYOsSXmasG2Rj0PRF2AdMoPF9coHJz4A5qJQdxojIH0+W54giUOvg8UcXBQHVeY8vBY4YrhNBETw5Rg5DqZtscA6+W5cnYvno2oyx/sjfmNps8aPR3gaqG2qgRBppqr5Z8xbFgmleTx+qI0w2xOIGUaZPfYuq1B8ccFQTKJ6koGQ8VYiWAaTxYWQADXNSOlUSSKBII9wnYQvF9tusl373BfXyc=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(36840700001)(40470700004)(46966006)(54906003)(110136005)(2906002)(7696005)(36756003)(70206006)(316002)(5660300002)(41300700001)(36860700001)(2616005)(40480700001)(8936002)(82740400003)(356005)(7636003)(4326008)(70586007)(83380400001)(336012)(47076005)(82310400005)(426003)(40460700003)(86362001)(186003)(8676002)(478600001)(26005)(6666004)(1076003)(107886003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:28:46.1441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4866f858-9699-49a4-f107-08daff2385ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The non-cache mkeys are stored in the cache only to shorten restarting
application time. Don't store them longer than needed.

Configure cache entries that store non-cache MRs as temporary entries.
If 30 seconds have passed and no user reclaimed the temporarily cached
mkeys, an asynchronous work will destroy the mkeys entries.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 ++-
 drivers/infiniband/hw/mlx5/mr.c      | 94 ++++++++++++++++++++++------
 drivers/infiniband/hw/mlx5/odp.c     |  2 +-
 3 files changed, 82 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 6e0c0a931d78..8e22bb7d4c35 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -750,6 +750,7 @@ struct mlx5_cache_ent {
 	struct rb_node		node;
 	struct mlx5r_cache_rb_key rb_key;
 
+	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
 
@@ -783,6 +784,7 @@ struct mlx5_mkey_cache {
 	struct mutex		rb_lock;
 	struct dentry		*fs_root;
 	unsigned long		last_add;
+	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
@@ -1326,9 +1328,10 @@ void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
-struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      struct mlx5r_cache_rb_key rb_key,
-					      bool persistent_entry);
+struct mlx5_cache_ent *
+mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
+			      struct mlx5r_cache_rb_key rb_key,
+			      bool persistent_entry);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       int access_flags, int access_mode,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 25e80529edd8..37f435cdcb52 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -140,19 +140,16 @@ static void create_mkey_warn(struct mlx5_ib_dev *dev, int status, void *out)
 	mlx5_cmd_out_err(dev->mdev, MLX5_CMD_OP_CREATE_MKEY, 0, out);
 }
 
-
-static int push_mkey(struct mlx5_cache_ent *ent, bool limit_pendings,
-		     void *to_store)
+static int push_mkey_locked(struct mlx5_cache_ent *ent, bool limit_pendings,
+			    void *to_store)
 {
 	XA_STATE(xas, &ent->mkeys, 0);
 	void *curr;
 
-	xa_lock_irq(&ent->mkeys);
 	if (limit_pendings &&
-	    (ent->reserved - ent->stored) > MAX_PENDING_REG_MR) {
-		xa_unlock_irq(&ent->mkeys);
+	    (ent->reserved - ent->stored) > MAX_PENDING_REG_MR)
 		return -EAGAIN;
-	}
+
 	while (1) {
 		/*
 		 * This is cmpxchg (NULL, XA_ZERO_ENTRY) however this version
@@ -191,6 +188,7 @@ static int push_mkey(struct mlx5_cache_ent *ent, bool limit_pendings,
 			break;
 		xa_lock_irq(&ent->mkeys);
 	}
+	xa_lock_irq(&ent->mkeys);
 	if (xas_error(&xas))
 		return xas_error(&xas);
 	if (WARN_ON(curr))
@@ -198,6 +196,17 @@ static int push_mkey(struct mlx5_cache_ent *ent, bool limit_pendings,
 	return 0;
 }
 
+static int push_mkey(struct mlx5_cache_ent *ent, bool limit_pendings,
+		     void *to_store)
+{
+	int ret;
+
+	xa_lock_irq(&ent->mkeys);
+	ret = push_mkey_locked(ent, limit_pendings, to_store);
+	xa_unlock_irq(&ent->mkeys);
+	return ret;
+}
+
 static void undo_push_reserve_mkey(struct mlx5_cache_ent *ent)
 {
 	void *old;
@@ -545,7 +554,7 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 {
 	lockdep_assert_held(&ent->mkeys.xa_lock);
 
-	if (ent->disabled || READ_ONCE(ent->dev->fill_delay))
+	if (ent->disabled || READ_ONCE(ent->dev->fill_delay) || ent->is_tmp)
 		return;
 	if (ent->stored < ent->limit) {
 		ent->fill_to_high_water = true;
@@ -675,7 +684,6 @@ static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 	struct mlx5_cache_ent *cur;
 	int cmp;
 
-	mutex_lock(&cache->rb_lock);
 	/* Figure out where to put new node */
 	while (*new) {
 		cur = rb_entry(*new, struct mlx5_cache_ent, node);
@@ -695,7 +703,6 @@ static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 	rb_link_node(&ent->node, parent, new);
 	rb_insert_color(&ent->node, &cache->rb_root);
 
-	mutex_unlock(&cache->rb_lock);
 	return 0;
 }
 
@@ -867,9 +874,10 @@ static void delay_time_func(struct timer_list *t)
 	WRITE_ONCE(dev->fill_delay, 0);
 }
 
-struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      struct mlx5r_cache_rb_key rb_key,
-					      bool persistent_entry)
+struct mlx5_cache_ent *
+mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
+			      struct mlx5r_cache_rb_key rb_key,
+			      bool persistent_entry)
 {
 	struct mlx5_cache_ent *ent;
 	int order;
@@ -882,6 +890,7 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
 	ent->rb_key = rb_key;
 	ent->dev = dev;
+	ent->is_tmp = !persistent_entry;
 
 	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
 
@@ -906,10 +915,43 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 
 		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
 	}
+	else
+		mod_delayed_work(ent->dev->cache.wq,
+				 &ent->dev->cache.remove_ent_dwork,
+				 msecs_to_jiffies(30 * 1000));
 
 	return ent;
 }
 
+static void remove_ent_work_func(struct work_struct *work)
+{
+	struct mlx5_mkey_cache *cache;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *cur;
+
+	cache = container_of(work, struct mlx5_mkey_cache,
+			     remove_ent_dwork.work);
+	mutex_lock(&cache->rb_lock);
+	cur = rb_last(&cache->rb_root);
+	while (cur) {
+		ent = rb_entry(cur, struct mlx5_cache_ent, node);
+		cur = rb_prev(cur);
+		mutex_unlock(&cache->rb_lock);
+
+		xa_lock_irq(&ent->mkeys);
+		if (!ent->is_tmp) {
+			xa_unlock_irq(&ent->mkeys);
+			mutex_lock(&cache->rb_lock);
+			continue;
+		}
+		xa_unlock_irq(&ent->mkeys);
+
+		clean_keys(ent->dev, ent);
+		mutex_lock(&cache->rb_lock);
+	}
+	mutex_unlock(&cache->rb_lock);
+}
+
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
@@ -925,6 +967,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.rb_lock);
 	dev->cache.rb_root = RB_ROOT;
+	INIT_DELAYED_WORK(&dev->cache.remove_ent_dwork, remove_ent_work_func);
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -934,9 +977,10 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
 	mlx5_mkey_cache_debugfs_init(dev);
+	mutex_lock(&cache->rb_lock);
 	for (i = 0; i <= mkey_cache_max_order(dev); i++) {
 		rb_key.ndescs = 1 << (i + 2);
-		ent = mlx5r_cache_create_ent(dev, rb_key, true);
+		ent = mlx5r_cache_create_ent_locked(dev, rb_key, true);
 		if (IS_ERR(ent)) {
 			ret = PTR_ERR(ent);
 			goto err;
@@ -947,6 +991,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	if (ret)
 		goto err;
 
+	mutex_unlock(&cache->rb_lock);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
@@ -957,6 +1002,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	return 0;
 
 err:
+	mutex_unlock(&cache->rb_lock);
 	mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
 	return ret;
 }
@@ -970,6 +1016,7 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	if (!dev->cache.wq)
 		return 0;
 
+	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.rb_lock);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
@@ -1751,33 +1798,42 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
+	int ret;
 
 	if (mr->mmkey.cache_ent) {
 		xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
 		mr->mmkey.cache_ent->in_use--;
-		xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
 		goto end;
 	}
 
 	mutex_lock(&cache->rb_lock);
 	ent = mkey_cache_ent_from_rb_key(dev, mr->mmkey.rb_key);
-	mutex_unlock(&cache->rb_lock);
 	if (ent) {
 		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
+			if (ent->disabled) {
+				mutex_unlock(&cache->rb_lock);
+				return -EOPNOTSUPP;
+			}
 			mr->mmkey.cache_ent = ent;
+			xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
+			mutex_unlock(&cache->rb_lock);
 			goto end;
 		}
 	}
 
-	ent = mlx5r_cache_create_ent(dev, mr->mmkey.rb_key, false);
+	ent = mlx5r_cache_create_ent_locked(dev, mr->mmkey.rb_key, false);
+	mutex_unlock(&cache->rb_lock);
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
 	mr->mmkey.cache_ent = ent;
+	xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
 
 end:
-	return push_mkey(mr->mmkey.cache_ent, false,
-			 xa_mk_value(mr->mmkey.key));
+	ret = push_mkey_locked(mr->mmkey.cache_ent, false,
+			       xa_mk_value(mr->mmkey.key));
+	xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
+	return ret;
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index c51d6c9a4c87..6f447095218f 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1598,7 +1598,7 @@ int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev)
 	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
 		return 0;
 
-	ent = mlx5r_cache_create_ent(dev, rb_key, true);
+	ent = mlx5r_cache_create_ent_locked(dev, rb_key, true);
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
-- 
2.17.2

