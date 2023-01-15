Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0535266B14D
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 14:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjAONf2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 08:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjAONf0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 08:35:26 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C513523
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 05:35:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yae+/xZNuFqCfzUxPoKsQ2CtIvvWfYp5SOk+SEyxTk0nZX+3XOyfAZntPY1D86M3iLi/t+N4hdpT86O1ylVgry4/N4rBKaTOsN+gQeQCYWXXO+w4lsCRjzzYOMgi+Zn/bj+Bhv9chJmVlZ8DZZDm43TXa/87/sh43O06knuvRN4LnXeN+P6Pvp0XAJp2+utOtyFEThr5Rp52toXSc31cisoU8uDoE46nFcYvBEXVhcod+IML33dS3q6v87eUZY3t96uNVd9s8CtD8NkSLYEIaYhfgUh9ajBTmFL1fqAY5UwiImBEY5xQQXiXue2rSAQsdekPm7UrgBPr6XOWfuD9sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTm1/zCCH1a0sY5imL+Qm7pbVaUi+1hGQ9oGPcBzfA4=;
 b=DvKU+iM/IPTo8SeeTeuvA64zCPQw4QGvMct+eOzoZaaAcpmqQXYu3fO2ZhbD9QIlC9aKXqFdbHVze11hxHoIUalDX9BMsufJ4PafLs/ZNyu7dJrMB/VSgY0RppJEmFWI2yPe0HuJMootJhNzvpnuneU7MuX3OSEJ0razdsRH69vVcPN4jV254SmPGj8xP6OLkt2BHV+Ti6pGvUK/RLJd/btItrx5HWDtVaupG2cs3ZIx181731lDjwIeC6yCv06uq7nyaikwi7D6xzWkCYPp14rYr70oKcxQIaZBpMuWkiuJ/85i96z8ite/ogVHnN8otZkdgnDPlCqL+dMruQQ44w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTm1/zCCH1a0sY5imL+Qm7pbVaUi+1hGQ9oGPcBzfA4=;
 b=nuVpmtz7VAAVGqRiLGA5+Eem7nH4hvr79K8v/sZQFQecv/yPOHsaZdEE+S8iYCPWkz4n6jR7hi0iAmcFfWaaHML16Khd4WK60idLgXczjSQQNKuhVuQ6ZRKJ0Cyu7/7nS4KOsp6iadr4NbJJnDRB6sYR8msvm5Q5srDLd8U8nqBuhBif5Uu1UBnrL3gy91iL4GREVb8c6eS9LosrnCVex2LcYRdDC0577COX5YJqTHZhX6E+cMgR1i/YwXKIIX9DoRcYrTkX+UuKCK5907DbdKOlITDbtFkbru9fETm+Xbrb1Ftw5SO7WS7f9Ooh7/6E/8wClyhyOqL5MKB+lh8cgQ==
Received: from MW4PR03CA0308.namprd03.prod.outlook.com (2603:10b6:303:dd::13)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sun, 15 Jan
 2023 13:35:21 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::b4) by MW4PR03CA0308.outlook.office365.com
 (2603:10b6:303:dd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 13:35:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 13:35:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:13 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:13 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 15 Jan
 2023 05:35:11 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v4 rdma-next 6/6] RDMA/mlx5: Add work to remove temporary entries from the cache
Date:   Sun, 15 Jan 2023 15:34:54 +0200
Message-ID: <20230115133454.29000-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115133454.29000-1-michaelgur@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: c27ad9e5-02de-47e1-0155-08daf6fd594d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfGfEIF8SgX0pJXr4LjsfsjIL+vapkEaLkCxFEZ2nBxdRr9kO3y3SseyP5lpwi2dTCG8E5+8cBlGWqKZWv9kmbX2uAedIqwYh1P4faojOIV7yRTubprVvpW9SnV5elF9cvAwBJalD6FTdZulZ4+Q/9LB11qYvw4iaCfQ5jE1Ad8t5BGf0PNHGB3Zm9PdDE1fLbbBHF2QBIQjYPXg17K5X6xqgJUAfD4t/+AD6hZh9yE+fWgrLJENEY7+bQFTdjRJ+knFilnxwfYV42eHvZYCfxcqB2t0LJjxWCnjCco4YxDMoYTftuIPU5fFKGsFSdjSLCrUQOfJhNpZah4Uw++nFBYo521b2pJrfGV425weRlneFh79jL0hKkgKdPTLxPgH2IcHZkBD9Ru8/6Xm6rSt+HvU+ygcPVnA1w5rWDhdilTHrXTxX7kiecvN0ZQMeXoRF7pu/pHRg4j1IWzsWLNdvnZQaShQuBlEgvM5lvAVd3YfS55vbQXoji5NpwtDUvWja6L9xVeNNrDb4Guj2KGe7nSEri4PQ6C8O5Og0N+Xu720Bqa6VqG37+865idVwmaGvjy0MAMilGa98Veu71IdkpFP5m3xEhzLuqRMmxxi1x61jOxnkidyGNIjBTbZcsjw7WizF9ff1Ug0u9Q80PMRntlpB8nYA+z3kAi26bb1NuY/+pfk+HpQPvO5N8QPpiEO
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39850400004)(346002)(376002)(451199015)(36840700001)(46966006)(82740400003)(36860700001)(7636003)(83380400001)(86362001)(356005)(8676002)(2906002)(5660300002)(4326008)(70586007)(70206006)(8936002)(41300700001)(82310400005)(40480700001)(186003)(26005)(2616005)(47076005)(107886003)(426003)(336012)(1076003)(6666004)(316002)(54906003)(110136005)(478600001)(7696005)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 13:35:21.0161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c27ad9e5-02de-47e1-0155-08daf6fd594d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

