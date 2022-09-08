Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1B25B27FD
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIHUzl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIHUzW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:55:22 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897572862
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MjO3NepJPdsb51w5M+rOLGOh7LBTsotR7CuCgbh2tKse0+oDUlSfrHlrLSSWzC9vnOD9jMybG24FIekV6GHOrZxzwr1vIrwg2e+Zr6DZ0VNf0dnKCq0pz1QyrdijUi+U+cHai4mtkn0oOjSsDsW42+uFgC4cS3uAToJZn52vFwcJYzVczR6naTn8GpXFI7nh736jg6EHCyaDlY0cTdzHfok9oXCCz0iNMIhDqscQ807o1UT0C7k0uUAX8nMok6+lrWt/aldoT1H8f6pfwBOSjtfD3OfbrBhadtgVMkLQUMVcxYVHPCnRAYNVey1OGTSleNkZNDD6Pu5eu56h2wquLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KNQ1eJUQu0VzRVZ3xgODWrtzEFaGEthXTorONP/6Vs=;
 b=NV5B8SqxLVzKiC/7wA281Hkmo8lqPi1bA2XqcaP+CJBK3Pzvz/DaB523yWBPXtxXUeb6Ih6X6otfegmOUad6Lqv/zkCU1ViQGI4BWnJ07FqN7slLZAn0B2X94r2GnbnQ7Gww74EyxQCRn0nEb/X/LfEy5YWyXo99aB0bMLgjejYbXcvO56jt8ojZSkq1nk0eiZv9Yk1yTI0kYP4nG7IQ5CtLleU3GOTs2VNFaZptTz3aazBIn4GfNPH5mGWI9dC/h0apjk+U3Dqr6M5vz/XLSornckzrxSq14f/9h5nk+m2iQZPJtMPXadLVFKq6fXaA7+NHyX+NhObLiXXAEBAC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6KNQ1eJUQu0VzRVZ3xgODWrtzEFaGEthXTorONP/6Vs=;
 b=aV7oTgY/uPEt2DmGCtPSlQru2/vMueThspAzfeDT+SI0Hu8MkMdD4Zcv9AZUBPdQ6jozZBZ+GmR++W+cuYHcLD7RdqF+3TmdUenO+KspYv6xW4iekKIK11CroNegwtT9MzYBxyUk0F/A6QvKu5jirL/BCjuSGi5HhEqDFh6TeNRIak/53LFqzh+n6PRgMu7psb8cVnIkQJTs98rqeKQ/xfHCpPQmDmxLYA+yVNljaw7doaEAHMbq8rqBVFINfVFBmXvLYSqoQHXEkrwLqUzXBkXQxVHSb4KibIPoTVFm9/53WPbhtpMVCJz7SVyCZ+2Kdwht+mo1yl2PpHD3SfGVug==
Received: from MN2PR19CA0057.namprd19.prod.outlook.com (2603:10b6:208:19b::34)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Thu, 8 Sep
 2022 20:55:07 +0000
Received: from BL02EPF0000C406.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::5d) by MN2PR19CA0057.outlook.office365.com
 (2603:10b6:208:19b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 20:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 BL02EPF0000C406.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.11 via Frontend Transport; Thu, 8 Sep 2022 20:55:06 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:55:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:55:02 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:55:00 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 8/8] RDMA/mlx5: Add work to remove temporary entries from the cache
Date:   Thu, 8 Sep 2022 23:54:21 +0300
Message-ID: <20220908205421.210048-9-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C406:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e3d3930-380d-4f48-97cf-08da91dc693c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ywDq0h6vIC4/Db3gR8cESqVQHBwpeEYjG+c6KkrcllCq6QjYknqmA9QTQS/2GhtSnWGykwMI+svom4ZZR+3O2vJ8L9agtvmAMkfI28o1tHVDJpgzOgreD+Jg7bAJnqlh+pgN0OWMhRoWTMLsKVDzAOdqYhbf8bFVC/bl4R3+lyaHIwWzlT7hHZ/7V8w+nchmar2fM5nKJPkb23LoxUj/oNbcycjpiNpr3NIj7UxoQrwbzPki7wdhL3RdpSPBy8SW3Hpa0U8UAhj9ExYM3Ww641/jyFM1fr2Xis98z9TxL1hF6+MnQth0neMz5yITsZ5c94Hngmqaf8ZFz1Dnwi3V+vHWgARuhUYORPbZHxfB7KN02JJ8h1NVA/emn2ejCLRIMWMo3R6BQpnJ97NPvskeFqemwP/OVFWlH0JnDIQ5pKClVYnZ5xGGS7/rtlJkreplXHGs9T6ihYV2XELjatlQmzgLL6zVe6Bnt6IG0MvYwdKs/2JYWCAdBxB6tN6/xkZ+V8VLYE84QkQGkCmBk6qb5YKedwQbtjU6D1316KdsE18fBECiKln+QOhABiub+b2Akb+El3V1LlKQQZ/g7Mr6n5i6w1R3cR08SrowaRZ/TEAUp7uuCVnmkKX7Is50/sqI0l3iyxBSUjRofchbObqSqvXhuWD+lEvFhnXb3thFFOFptnamlTj9AIEOC8cV0TJrXHhsR2Znm9kBXHiE5hBjj5RtP8H/+c3gyKZd/ZlPLiMi6eONe+f02kGOdBuiUTkNEdRcwJ8MgSggzPzTJOU+WFum18MtsTApUFbqkAe1+wruoJyGkIVB9HPXd+SGW+m1
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(426003)(2616005)(1076003)(8936002)(40480700001)(5660300002)(186003)(7696005)(36756003)(478600001)(86362001)(47076005)(107886003)(336012)(26005)(6666004)(41300700001)(110136005)(81166007)(36860700001)(356005)(83380400001)(8676002)(82740400003)(54906003)(316002)(4326008)(70206006)(2906002)(82310400005)(40460700003)(70586007)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:55:06.8882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e3d3930-380d-4f48-97cf-08da91dc693c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C406.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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

The non-cache mkeys are stored in the cache only to shorten restarting
application time. Don't store them longer than needed.

Configure cache entries that store non-cache MR as temporary entries.
If 30 seconds have passed and no user reclaimed the temporarily cached
mkeys, an asynchronous work will destroy the mkeys and the temporary
entries.

When allocating an mkey from a temporary entry, don't keep a pointer to
the entry, as it might be destroyed.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +
 drivers/infiniband/hw/mlx5/mr.c      | 95 ++++++++++++++++++++++++----
 2 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 109e3d666264..c1e1e3be6e84 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -748,6 +748,7 @@ struct mlx5_cache_ent {
 
 	char                    name[4];
 
+	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
 
@@ -781,6 +782,7 @@ struct mlx5_mkey_cache {
 	struct mutex		rb_lock;
 	struct dentry		*fs_root;
 	unsigned long		last_add;
+	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 1e7b3c2d71a7..c5100b5dcf30 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -141,18 +141,16 @@ static void create_mkey_warn(struct mlx5_ib_dev *dev, int status, void *out)
 }
 
 
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
@@ -191,6 +189,7 @@ static int push_mkey(struct mlx5_cache_ent *ent, bool limit_pendings,
 			break;
 		xa_lock_irq(&ent->mkeys);
 	}
+	xa_lock_irq(&ent->mkeys);
 	if (xas_error(&xas))
 		return xas_error(&xas);
 	if (WARN_ON(curr))
@@ -198,6 +197,17 @@ static int push_mkey(struct mlx5_cache_ent *ent, bool limit_pendings,
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
@@ -542,7 +552,7 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 {
 	lockdep_assert_held(&ent->mkeys.xa_lock);
 
-	if (ent->disabled || READ_ONCE(ent->dev->fill_delay))
+	if (ent->disabled || READ_ONCE(ent->dev->fill_delay) || ent->is_tmp)
 		return;
 	if (ent->stored < ent->limit) {
 		ent->fill_to_high_water = true;
@@ -718,9 +728,18 @@ static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 
 	mr->mmkey.key = pop_stored_mkey(ent);
 	mr->mmkey.ndescs = ent->rb_key.ndescs;
-	mr->mmkey.cache_ent = ent;
-	queue_adjust_cache_locked(ent);
-	ent->in_use++;
+	if (!ent->is_tmp) {
+		mr->mmkey.cache_ent = ent;
+		queue_adjust_cache_locked(ent);
+		ent->in_use++;
+
+	} else {
+		mr->mmkey.rb_key = ent->rb_key;
+		mod_delayed_work(ent->dev->cache.wq,
+				 &ent->dev->cache.remove_ent_dwork,
+				 msecs_to_jiffies(30 * 1000));
+	}
+
 	xa_unlock_irq(&ent->mkeys);
 	return true;
 }
@@ -890,6 +909,38 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
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
+		ent->disabled = true;
+		xa_unlock_irq(&ent->mkeys);
+
+		clean_keys(ent->dev, ent);
+		mutex_lock(&cache->rb_lock);
+		rb_erase(&ent->node, &cache->rb_root);
+		kfree(ent);
+	}
+	mutex_unlock(&cache->rb_lock);
+}
+
 static int mlx5_cache_init_default_entries(struct mlx5_ib_dev *dev)
 {
 	struct mlx5r_cache_rb_key rb_key = { .access_mode =
@@ -944,6 +995,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.rb_lock);
 	dev->cache.rb_root = RB_ROOT;
+	INIT_DELAYED_WORK(&dev->cache.remove_ent_dwork, remove_ent_work_func);
 	dev->cache.wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!dev->cache.wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -971,6 +1023,7 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	if (!dev->cache.wq)
 		return 0;
 
+	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.rb_lock);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
@@ -1730,34 +1783,48 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
 	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
 	struct rb_node *node;
+	int ret;
 
 	if (mr->mmkey.cache_ent) {
 		xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
 		mr->mmkey.cache_ent->in_use--;
-		xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
 		goto end;
 	}
 
 	mutex_lock(&cache->rb_lock);
+	mod_delayed_work(cache->wq, &cache->remove_ent_dwork,
+			 msecs_to_jiffies(30 * 1000));
 	node = mlx5_cache_find_smallest_ent(&dev->cache, mr->mmkey.rb_key);
-	mutex_unlock(&cache->rb_lock);
 	if (node) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
+			if (ent->disabled) {
+				mutex_unlock(&cache->rb_lock);
+				return -EOPNOTSUPP;
+			}
+
 			mr->mmkey.cache_ent = ent;
+			xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
+			mutex_unlock(&cache->rb_lock);
 			goto end;
 		}
 	}
+	mutex_unlock(&cache->rb_lock);
 
 	ent = mlx5r_cache_create_ent(dev, mr->mmkey.rb_key);
 	if (IS_ERR(ent))
 		return PTR_ERR(ent);
 
 	mr->mmkey.cache_ent = ent;
+	xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
+	ent->is_tmp = true;
 
 end:
-	return push_mkey(mr->mmkey.cache_ent, false,
-			 xa_mk_value(mr->mmkey.key));
+	ret = push_mkey_locked(mr->mmkey.cache_ent, false,
+			       xa_mk_value(mr->mmkey.key));
+	xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
+	return ret;
+
 }
 
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
-- 
2.17.2

