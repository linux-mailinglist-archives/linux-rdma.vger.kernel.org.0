Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD4A66B11A
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbjAOM6u (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 07:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjAOM6s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 07:58:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F61259D
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 04:58:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXfoq/VvkQN5WHYUF6lzQEJ+PPDv9GFKsp1pJW3EPTefi/MlnOFqVIObggNSb49+bitaNum/lfg6UldS/cIU6PUn+Ze9ZBIr4Uo+x9RJyKSIGXWcz2ljuZ37bJFvA8k/q7v3yND945SMQDUtCrsPwwICfoQh816Lk9eGQdRss9oJiyB4Jjf+6qollCiK8K0AjLdtXllpIJCeH0ULUjT5kxNpF8A/6rh/ZjqRhB+WAyFj3J0wdcN6y9M0iUYfnj6aYdixKMpH3OnPXuZp+UNn/28wgXZu82S/nZz//Er/KYlP8KWNLRbyJZq/aSuPohzPe7LhK9IoMzm9jRlyJemfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1lKnolIlnlkH1/XoksQrc0sffUpzSqqSyozR5Womk0=;
 b=nSq7suiShci0/7C/Mm+uMr9mdoiHXJ6cfFWSKclr1Y084XA0LORayBtUMp53QXQN4JnpaZ6wq6dAN1dEic9KLXQWvvDOTSp2Iqg8uuaneO3o5uzCTd8zplWfaLl5BfELSwEH0CxOQHveN7/6JVBR0lHym8gBa4Q9bnblH3BPGN81myDcPoyp7CCME9PkEyR6S+ckMGXONtjoNITbricEz8rykj67k7jwUIGj3NKlSkEs8eZZ3RhReyynLDCN1dkaCloVGkjS1ecStHwDIvSSMiHxFPc5AYNa8Sc8U7XZVa6VVwuFhOVAi1WZJGl+3H/tLSZAvJemPtUQd57S+d+mDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1lKnolIlnlkH1/XoksQrc0sffUpzSqqSyozR5Womk0=;
 b=H6/GV84DrV7vSiz64yAtdvFKPxwL/unigRWgcQ6liTFMVJ9WUULxwrlOYXXMCyN7Pzsaa4BqmbY0UCkVQ1On4NE9X7Il2vJBJknDjZu1/eph1utEMZJ1pG2Hce13D3E4YY11Atkhs0VcVXwtdU/qLn0a+hhh2c/UPnB6qkbvs61KlaDiPL27rxFEhFEdsmNr9BJMHXN6voxcgadhZzKjBM5W2nRM+pIRmLNRmouXY8Px9zcd08sUvvP90bGkIfZwPUwcf7FE2FDkrQGJrieZAnpV0QcH5cKCLgy5z+b1pBPLbDZHbfIYXuH/ohIb+kOyjKapDU8Wt86cuPhjvBLzvw==
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Sun, 15 Jan
 2023 12:58:45 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::c) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 12:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 12:58:45 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 04:58:38 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 04:58:37 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 04:58:36 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 6/6] RDMA/mlx5: Add work to remove temporary entries from the cache
Date:   Sun, 15 Jan 2023 14:58:19 +0200
Message-ID: <20230115125819.15034-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115125819.15034-1-michaelgur@nvidia.com>
References: <20230115125819.15034-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 98767717-a97d-4cd5-468f-08daf6f83c69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ycE/l3fLf7N0OIuMS3fhYsUkVfLYh9UpAwWcjQVuxavKkS5eeFm/BzUfBQoLI8hs7vgqA0kex6iqy/VRPQZor9WaL5PVlS+EcAwNyrAnbMQwcteBulhAc3CcCoS0Nmr6ns4uaGPggEhu5tjmULM91okye7bVvGIT+FFBzWR6AEMLmq91OWFPdvCiF/Rhvk3+VfHmqRejkDsrJIDgsmsOsIaivYumoEcplgZj7B7YVzu/aux91MgP8gtmh44e68YhtXW28rpBQCSg+qC7gHIeJE1NQZ5+w6VbLzTA5QmTXxRqGbuKhg8uI9l30SWPFWP6JIpj9pj6R0LdkrJyCN/LqmcMkXYpgA6XZjHljQxSyl68KRue+SpTWF1BmFe5/2EYBLYMElXIdvNS7TfA3/fbMIJaQ7rLKV5iuGhMd8ahMYupPL8HZJUXYZk7+bL7k0G9lExPAfY1sShkd6+ZrWqNkPi+A9GbRDoKriiS3PWDRsJ7CTLMJra6GDhI/DwCSOSdh5GELoFd7jbR8tPvf+pZKty7cMoC6fstxL1+ojVZZC4vJz+TnFBod9asx3HhvoWlrDd2FyQpZSZduG2NBI2j3rU0ldUELb/xjCfoOhenXVhmy2vNu3bKoridNT0jW6kgOmO1k3i7Grb6s98BDuPhgJNDP8ubAjJO51b8QtlnEbrN7UJy5903N3iU+CKDPgoOwQ50tOVkjLEQo+eJLjRhfne6VU8DJaDNpFqYX3Pa28=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(356005)(86362001)(8936002)(8676002)(4326008)(70586007)(70206006)(2906002)(5660300002)(36860700001)(82740400003)(7636003)(83380400001)(40460700003)(478600001)(7696005)(316002)(54906003)(110136005)(6666004)(40480700001)(82310400005)(41300700001)(2616005)(1076003)(47076005)(107886003)(426003)(336012)(26005)(186003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 12:58:45.1263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98767717-a97d-4cd5-468f-08daf6f83c69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
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
Change-Id: I39249384d5a1ed87cf206ca902968cdd321689d1
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

