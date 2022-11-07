Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4E61F8B5
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiKGQPe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiKGQPY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09401FCFB
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTODt3Eh1qL1QtpGK3YMWTZgLHzuqrzAOu7E4zp8l3tBVYubyMqXk4fcaoCOIOfp+t3ErfZM89yTnjxncXi9bW0O7PfOSYprZ+9g7ZKT1ByVmLAs3NWmjUFTBc2iQMCZRsN/9Wfsuriz3UpncFPrrMO3l4wK9y3UOC2ZNtQcppECau6lFdRM1LxccT7ameXbHjzCbMxrwCoRmEB+0d32hYDNH5/evJzO64DISlGPcUKVwjU2mFrbD7JUt/3tZ2ofKy4B8bwrprGPLrewh1r1JyIGevnniIeO9Xx4lu7Al0cEfL3CreJQK0LArjqVxfuyLauyo/k/5x9abPEbyqMlOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8PAvcIWAMprzh2/fEatQN7wj2WBggGKUgU/XHFyECE=;
 b=TgnGKyV9CKpyJL8Q+Ik78yDGLf8lCmimVwLCZETsYrsmsRizjJz0VKpGfrJgKjHY9zhln7sWCl286OEa5rrSdE813Cxj3Z1ZAkVRIwzmMLeqMYTGSnWmO/V3O/Qk16/sFy5Xi4dBeFIzxyEzY8En4ohtGe20B4YSbIJQ27QwRWxgvoISxJZuomqgmxF9llD4xWhSPco0KbkoMUs1jTwHLFOxpddZQL36JfZOthcbcaOjTm9jJryxyvi0GF+UpikBDYsDaSCiUdB762G2l2V5seHrhmWuG20iUbgw0CWQVe9nICkYEmWjsEnF00VJps4xauiChsujnA1h5nHV0SDe8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8PAvcIWAMprzh2/fEatQN7wj2WBggGKUgU/XHFyECE=;
 b=boBOYjYjswsTBgdieX3rEuQTaqMbKtpiaS7WyThYw3WHkJ9lrxJoHpmBSs5YXQ36cgUu88DOkgiD5uh/IFHkaGenwMaljd5P4s/9h8K9+j/OiaetmRZgCvZs2h5HGrN0Wb1LRVQCVFHUazQoDr8kofsIQnDdzFS62Tnm8Dqjynzc19fGtpd2rWN8Hw6EkrHFoQ6/1zC61yh6mmwxlkp1cG0ZHjn0YYlQ503dKnMrMhrsdH4k78LulBuauS99/QmKlIBpPEYsVnU5P7HJjlhX6nk2Ogif86Ijejf4qsvk89vMg8f9bvWt31ijALZangCVaRyZXO6E6/Dt3F08ZWWvlg==
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by CH0PR12MB5074.namprd12.prod.outlook.com (2603:10b6:610:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:15:22 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::9b) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:15:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:15:08 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:15:07 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 8/8] RDMA/mlx5: Add work to remove temporary entries from the cache
Date:   Mon, 7 Nov 2022 18:14:49 +0200
Message-ID: <20221107161449.5611-9-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT049:EE_|CH0PR12MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d448d6-2f27-46fe-6595-08dac0db456e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLrGDSFK2xTdjf3kutNdq2NFsDyfwihIDtDw1A1OViias5jHoed0s9y4oSSSbqa6ttmbq5++DLmi8ZOJ4j1Tk6QS29CN9pPH/HgMCWpQOrEMe4RY80fT9Zdaao9IXhBzIQR8KJv6+imc486WeY/LoryA2Lmu/SW731xDGKLsPnn5TEn+WRFAcZVpgcJ4775z5kG8aeQy8ahsxdNyAw6UvFva1+W/pAPAcLt/I+ubNbuTVs7mG6FghRYwhPb0r1ARkJYFgkL5+9EUx/mXKwMex98rM5/7+DlTyBRmAgT8D9HMQAq4P1yHrMBIoyCQbZuNhIOcQRwZqrgcshVU+n5uj2cOLui31AzIxHiv23Z7UTor60P4xNng6a0LGbn236GO70q309J6yI3M+uSazK51byO5hugxfelevuiNGJeya8uGHWgwt7k0eAkSjnQf6KRfmuA+XxTKkVxKzlzBaR6h8wXa1u2cq/qwT5FkXNJMiDT9TVNpMva8ACV+ygJxntoiREOcmIab2M7GGTkspM6yzMRSO/shXaJj7fnSc4cvOt/upa0sLu1pKWKMsn7Dv8XIzURY6pYercLOIDpTJOR3KtCuKLC35kmiHh45Vsu4rAGZjXTjTKjCFeJEcZiNM16XJuz0/udtt9F0yJgAECrr7JxwJmQgCqDkIAZTxqAzCBL4zjOZ1U2ad+rCjU01ciFytiH0L3I+cUmYF0cSBjiWfEPSOOiUGCoXK6bHbxdlF4qi01i+Q1pJCjrEG3wJmEl+MoHrfFsZCaXpHhLyqlTW2Mdt/qD/Evt01R4+GEUfiBc=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(82740400003)(7636003)(356005)(40460700003)(40480700001)(5660300002)(110136005)(7696005)(107886003)(6666004)(1076003)(2616005)(83380400001)(186003)(26005)(336012)(426003)(47076005)(36860700001)(2906002)(70586007)(70206006)(54906003)(478600001)(82310400005)(41300700001)(8936002)(8676002)(4326008)(316002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:22.0174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d448d6-2f27-46fe-6595-08dac0db456e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5074
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +
 drivers/infiniband/hw/mlx5/mr.c      | 95 ++++++++++++++++++++++++----
 2 files changed, 83 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index dafd4c34a968..0a72d8e766b8 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -749,6 +749,7 @@ struct mlx5_cache_ent {
 
 	char                    name[4];
 
+	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
 
@@ -782,6 +783,7 @@ struct mlx5_mkey_cache {
 	struct mutex		rb_lock;
 	struct dentry		*fs_root;
 	unsigned long		last_add;
+	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 78d0bc10b821..d920a3f7803c 100644
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
@@ -732,9 +742,18 @@ static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 
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
@@ -904,6 +923,38 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
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
@@ -958,6 +1009,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.rb_lock);
 	dev->cache.rb_root = RB_ROOT;
+	INIT_DELAYED_WORK(&dev->cache.remove_ent_dwork, remove_ent_work_func);
 	dev->cache.wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!dev->cache.wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -985,6 +1037,7 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 	if (!dev->cache.wq)
 		return 0;
 
+	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.rb_lock);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
@@ -1745,34 +1798,48 @@ static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
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

