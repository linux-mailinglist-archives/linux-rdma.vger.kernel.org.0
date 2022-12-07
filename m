Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6896455EA
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 09:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLGI6w (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 03:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiLGI6l (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 03:58:41 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDEBD9B
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 00:58:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewGje6cSNYi4DB9uAVCGxhoCHmRrTpTclodLZFnkYC0wWagqQCSpCRqZtG1FH2+zKnlNDPa6INrBzmqjDNLF7+BYNCnNBMYwsZ2vLg37iRY0j0lV1vnNJsQuzd9QeMIastS7jtzAAHMt01BYK46My/Zi1i4LP01wOlw9oA/ACh2u1qnfTYRtyiutWf0jXxrUG9uQU6Om6UAr5T8FtSHH8m4gMVCPsLpKnkME1JjnHQmVkwAWeo7HqXk9BEe8OUUtg1VELNtkeqvCOQPsET02B2WUjSVyWQRpFM7fKq8RUesSWLCqaWqCLyRwoMgZ0kUfYRT17xBSK3NhJxSDWYawRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8AYhbZ7rNEIlJSqg0nRCvIcCLz/wJsIC2fqoDRVwU8=;
 b=ZePSEkD5ATNJYRRWT2rnhSuSATaCwm9K4MXkjrGsvegqs5NX3kQNXSDLKjUcqLAd2iDVrY4m0sg83eRp3o4RR9wPFA9QCBHx75Mzafu7FPAg6KU2rNwIf96nrqQ2KiJzGfIT2m5pNgTKOTMqNSXW5yciOqP4PWhwrxuAEnn+M//aO/Og0spSu2FflZalgH8YVCj11NhivxnTyLYKgpJdgbtIR8hBvz0OqpIVTYWdZXx2fPkqGduhf0P9oNAdo3Ja9x7mrPlbyRqSQQBQBoYGjrJdZsshisNJv0Bp7bO/VCpuQU9axlhA+OhS8am9yL/bKKfCTxtYL99TTNTifHG1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8AYhbZ7rNEIlJSqg0nRCvIcCLz/wJsIC2fqoDRVwU8=;
 b=Jk6Zicudhpb29d8J/gJWAedes9aShTFx8P6NwmtSXKcYV/W0CPBwNhPBAYlcOVvrw8P4pmz6AE5DQ3PTm9N1AtWqO7nPeKtyZ46QLFDRa7xkaiXHE5z+wSDCY9XrXtJ5G93ePyyKGV/F4URNMH1YgSSfH+ShGrqeyZHToleJmoH00UqYcju5Bn+caiH2gtQK9nw2VQUhD+0UmN9TjtXCbGJlpAPaJQArG+PiLH6JCh1u1gixK5LaUwhS1azQp+olk1RKKw/8QFGnfGTtZF9V0MNOhgfo2hvRSIrZ3/98Neq7nVOMQhNEQ+8dT3sHfAMxfoU287gnuXvnihIFsR0aBQ==
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 08:58:38 +0000
Received: from DS1PEPF0000E630.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::2e) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 08:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E630.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 08:58:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:24 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 7 Dec
 2022 00:58:22 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 6/6] RDMA/mlx5: Add work to remove temporary entries from the cache
Date:   Wed, 7 Dec 2022 10:57:52 +0200
Message-ID: <20221207085752.82458-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221207085752.82458-1-michaelgur@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E630:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 9021ad21-ed2e-4570-846b-08dad8313b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dC8cpv8ZkBeqelrgPI8MIZ9oe6bYqhihdxKHkRM169FyZgBz5gpoQrBCmkYv+WMG0KPeBR8FJnFQ2mwRmiaoBsQaMuKFK2CBoGbNGiNB0S1A6WQ7YXIEeOVA53EburxrK8Fx/lT5kzUpveU6LxnGAZZBPTNu853XxHzBR9nb2LOgGpbwb+f0zisSx5Qw0lWHBa3O8JeDYBY5TGtDaWllbdi9lPOZhPuZTAYC0miQ8/HFhantZ77z9hATGLdhQ9eGHDqRSz3Kqqjopla2o3Y85nHRK4twzIuGs1srDnjCHDqJIyw5HoO/PRJ/vA9daQRf0T+Kvs9P9P0fu02OwJkJoNe/wgcMN7YJ2KREctq+09CZ8ZWmg8QAmaH9AZocYPq2KDmVt+wUUvxwjKWf5kXvFIRtCx+suB3LwISc/f19a6occH8gxE1AvskYVTSXNuYhwh/S2AHBhO7+hz0ktYxdQdtQyRftbjTyhumWf5gA+Es3ty4+0qAWuB7esDRD5CtdGlrLx1+Ti0XY/FP9KRDrFq6v3ndZYa9Fm4FMSD7yWEbF14UXEYaVdDMS0X9q6SLF78ByVdw1WaFWpdatUemm1FQYDkIEnJb1egyS3rlxeZ3d1Axf56MnZudNG6Q0vsBNbGsuDS8O0Ah8A+/JHy/GAIb5VGGiDaEn/y2GnZO818Sih2iTLA8NrAhVu/jOvJaqomzjQT/DcKawtJ7Aw33xj5itKW2vfVTddodFPSSwk5w=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2906002)(36860700001)(83380400001)(82310400005)(40480700001)(36756003)(40460700003)(70206006)(1076003)(70586007)(41300700001)(336012)(186003)(86362001)(356005)(7636003)(26005)(110136005)(82740400003)(4326008)(2616005)(6666004)(47076005)(5660300002)(8936002)(8676002)(54906003)(316002)(426003)(107886003)(478600001)(7696005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:58:38.7076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9021ad21-ed2e-4570-846b-08dad8313b71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E630.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  8 ++-
 drivers/infiniband/hw/mlx5/mr.c      | 93 ++++++++++++++++++++++------
 drivers/infiniband/hw/mlx5/odp.c     |  2 +-
 3 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 8f0faa6bc9b5..86893fc145ba 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -754,6 +754,7 @@ struct mlx5_cache_ent {
 	struct rb_node		node;
 	struct mlx5r_cache_rb_key rb_key;
 
+	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
 
@@ -787,6 +788,7 @@ struct mlx5_mkey_cache {
 	struct mutex		rb_lock;
 	struct dentry		*fs_root;
 	unsigned long		last_add;
+	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
@@ -1330,9 +1332,9 @@ void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
-struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      struct mlx5r_cache_rb_key rb_key,
-					      bool debugfs);
+struct mlx5_cache_ent *
+mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
+			      struct mlx5r_cache_rb_key rb_key, bool debugfs);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       int access_flags, int access_mode,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2e984d436ad5..5645ce351f59 100644
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
@@ -670,7 +679,6 @@ static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 	struct mlx5_cache_ent *cur;
 	int cmp;
 
-	mutex_lock(&cache->rb_lock);
 	/* Figure out where to put new node */
 	while (*new) {
 		cur = rb_entry(*new, struct mlx5_cache_ent, node);
@@ -690,7 +698,6 @@ static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 	rb_link_node(&ent->node, parent, new);
 	rb_insert_color(&ent->node, &cache->rb_root);
 
-	mutex_unlock(&cache->rb_lock);
 	return 0;
 }
 
@@ -861,9 +868,9 @@ static void delay_time_func(struct timer_list *t)
 	WRITE_ONCE(dev->fill_delay, 0);
 }
 
-struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      struct mlx5r_cache_rb_key rb_key,
-					      bool debugfs)
+struct mlx5_cache_ent *
+mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
+			      struct mlx5r_cache_rb_key rb_key, bool debugfs)
 {
 	struct mlx5_cache_ent *ent;
 	int ret;
@@ -878,6 +885,7 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 	ent->rb_key.access_flags = rb_key.access_flags;
 	ent->rb_key.ndescs = rb_key.ndescs;
 	ent->dev = dev;
+	ent->is_tmp = !debugfs;
 
 	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
 
@@ -890,9 +898,43 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 	if (debugfs)
 		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
 
+	if (ent->is_tmp)
+		mod_delayed_work(ent->dev->cache.wq,
+				 &ent->dev->cache.remove_ent_dwork,
+				 msecs_to_jiffies(30 * 1000));
+
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
 	struct mlx5r_cache_rb_key rb_key = {
@@ -905,6 +947,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.rb_lock);
 	dev->cache.rb_root = RB_ROOT;
+	INIT_DELAYED_WORK(&dev->cache.remove_ent_dwork, remove_ent_work_func);
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -918,6 +961,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		if (i > mkey_cache_max_order(dev))
 			continue;
 
+		mutex_lock(&cache->rb_lock);
 		if (i == MLX5_IMR_KSM_CACHE_ENTRY) {
 			ent = mlx5_odp_init_mkey_cache_entry(dev);
 			if (!ent)
@@ -925,8 +969,9 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		}
 		else {
 			rb_key.ndescs = 1 << (i + 2);
-			ent = mlx5r_cache_create_ent(dev, rb_key, true);
+			ent = mlx5r_cache_create_ent_locked(dev, rb_key, true);
 		}
+		mutex_unlock(&cache->rb_lock);
 
 		if (IS_ERR(ent)) {
 			mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
@@ -956,6 +1001,7 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	if (!dev->cache.wq)
 		return 0;
 
+	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.rb_lock);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
@@ -1737,33 +1783,42 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
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
index 90de87ba3b96..b36b5afbc53c 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1600,7 +1600,7 @@ struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
 	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
 		return NULL;
 
-	return mlx5r_cache_create_ent(dev, rb_key, true);
+	return mlx5r_cache_create_ent_locked(dev, rb_key, true);
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
-- 
2.17.2

