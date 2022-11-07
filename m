Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A881961F8B3
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiKGQPU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiKGQPS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:18 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBD61572D
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAKmrflfUHbVqZ1rIVTuc7i+Jgf0VXLARMJQHW7p0+rq0e1QXgJsFaeFR5bBsRTABbeRzahqhMNLsDvjfylrKUB4bt9gru6l3znEJP15XBjQ/JK+vkXAMKOCi+zZq1Ir3fr9xs5Zj4PLMnbyqXAU/4IeJo6V83yCo6WcPd+2NRNnlGTteNHOify7mbO4lG7lvcYfTnO5s8+8o+AtNAz8fAB9Hsuy0XDyr6jOB3Q3B5VYYniEpaJ9MeJFYA6sNQ50nM804yOr6BLrWMILWB68/V2pTDktAEmybQNvVJP3mL0ypkFJmGEkfVKGixvNMQmefVuBQ6XkxDsGDTYmRmvuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wm4TiMf/sAYn0CFpzz9S3Fd13nxZc1cz+81Z2ZPJ7aE=;
 b=lEU2B3mJFAG3bCh+16BYk8VY+yd038+q3h3FuclmbMWSFTBctTWW6JTKYRBKAQxOUNJEGQP4rWLkMDdGfc+Tr4ZA5fQ/4Qqmw1pkaDShBdVYcsiBAGUwAVosajsPuHZa9P19vj5aHE0rxK0DxTUGIARIIpSrk+6E2tj5kxYaZtKbB7PboegZ7Zd7ig+wvzX4Guk0lz04P4BUQzYU19qcKD7sjP7ZnKIIyu9T7TpZB6VlYED/5RjiWMG+98590JTo7sICKuOKrABZl9jK8hG0/n5xvByu6hoj+Ftw3l1sCr77BCdxMkaBlwDR6+gwipamVPJtcqSS4jPQPyB7SfgEqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wm4TiMf/sAYn0CFpzz9S3Fd13nxZc1cz+81Z2ZPJ7aE=;
 b=SfT9voRgUVcxz/P1kaaRWPBmPk3R/9paYIpkTvKPmdXD7S6rfF3gjcpodBT61Icp3zIDI/fqWBTIEx0gsnK+wvYe0x9vgggsAzwwU7MmGms85GIhvwBk8PAa2mPpJdt5bS0YL6nrpU/zNc1EMk4b2zseMuGAHNGASAlVXbDYmEo0vSlAfFsHFVy/IuEQlrpIH/MkG9IR5OuaQ+8AG3+wdsZ8oQTEPcCV8MM9IluR20xV0vILu4tw48HrcljJPy85lfKSF6RRhhZLE+wGaoXQ81V5MECc1uMJoBpECDKDJgB4baG1McGadFpjWo3YSJ7mcfE1nnhz00Ytku8g6Ah0MQ==
Received: from DS7PR06CA0053.namprd06.prod.outlook.com (2603:10b6:8:54::8) by
 CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 16:15:14 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::9d) by DS7PR06CA0053.outlook.office365.com
 (2603:10b6:8:54::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:15:05 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:15:05 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:15:03 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 6/8] RDMA/mlx5: Change the cache structure to an RB-tree
Date:   Mon, 7 Nov 2022 18:14:47 +0200
Message-ID: <20221107161449.5611-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4d1ff9-f8b7-4856-40a1-08dac0db40c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgMCOZCaxqmAIJReJ8Hk83pAscyriVvjNp2JMV+4a8Y6CgmYfDc9cPz07R+mekqqwkv1eb9mcmqokBnw+8lJlZCtwEzcbteSh6YgtWrQj3tZDg0PDYJhFSVwbX7PwLpLBhVIJM5k5H1fJFqhsutabw2d/qnrM+y88ea4XTVm8MXh3VoHwYgrI+b0AWtSv7A3uHxouhj/cfFDU6P0jPvDZyOVOcxuKQpzXQIYtMtugMXwF/fwYXXKfEqzBFlLgWnSNuNUp+Y4VGWbU4pU+wVkViqEC6tiIVHwb5sJBbv6l0CS5txRt8USdu4R2yS2p2M7K4XCjGZY5McDz3uA6J48yBobD5UZz/f2pJN1+76tWK3mqg4IiWLUI25KKE9x6hCqQaLcldYDU/oenEcFTMgHot9/V4It+arsFP8nUo1hZ2sPeP5EHxflf+0KBrERcLHxDjoED17aObFxGUSnr85fezTc/DxCip01gQifMQR9AqlOlGo2qr5Iu3d25iuenn++DVIH4VnB0LLtPO2nlRHuLy4JRmxwRXRXabtwR5JgHz9YaSvG3PTH1WbgXstFEFm87EvLpAV2+3Vrmf7JO67Sd9db/xM8BVbdeTFk4OmziMr5g3+V01HZcu2rE9GIQ0f1JoWErgDx2Gp+k8ZFjKmmq5AwMB+5Mr5nmUL0e3TqxvjJFwdULLSy+CzhqV8Ay5sX9zuqZfAn5pD3ugA2G5LccSbKz3W3ORmDYWxNM0xmEeXnTP0YcwhhAfokHYEyfySAhyA16t0ifdP5HJftMM9wzyfGYvGkhMukhLqijYSOOZE=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(54906003)(8676002)(41300700001)(110136005)(478600001)(36860700001)(4326008)(5660300002)(8936002)(70586007)(70206006)(83380400001)(7636003)(356005)(40480700001)(86362001)(7696005)(107886003)(82740400003)(6666004)(2616005)(186003)(1076003)(40460700003)(426003)(30864003)(26005)(47076005)(316002)(336012)(82310400005)(36756003)(2906002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:14.1652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4d1ff9-f8b7-4856-40a1-08dac0db40c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642
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

Currently, the cache structure is a static linear array. Therefore, his
size is limited to the number of entries in it and is not expandable.
The entries are dedicated to mkeys of size 2^x and no
access_flags. Mkeys with different properties are not cacheable.

In this patch, we change the cache structure to an RB-tree.
By this, we enable caching all user mkeys that can use umr.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  17 +-
 drivers/infiniband/hw/mlx5/mr.c      | 307 +++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/odp.c     |   9 +-
 3 files changed, 237 insertions(+), 96 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 939ec3759eba..0bf2511fdfe4 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -742,10 +742,10 @@ struct mlx5_cache_ent {
 	unsigned long		stored;
 	unsigned long		reserved;
 
+	struct rb_node		node;
 	struct mlx5r_cache_rb_key rb_key;
 
 	char                    name[4];
-	u32                     order;
 
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
@@ -776,8 +776,9 @@ struct mlx5r_async_create_mkey {
 
 struct mlx5_mkey_cache {
 	struct workqueue_struct *wq;
-	struct mlx5_cache_ent	ent[MAX_MKEY_CACHE_ENTRIES];
-	struct dentry		*root;
+	struct rb_root		rb_root;
+	struct mutex		rb_lock;
+	struct dentry		*fs_root;
 	unsigned long		last_add;
 };
 
@@ -1322,6 +1323,8 @@ void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
+struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
+					      struct mlx5r_cache_rb_key rb_key);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 				       unsigned int access_flags,
@@ -1349,7 +1352,7 @@ int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent);
+struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev);
 void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 			   struct mlx5_ib_mr *mr, int flags);
 
@@ -1368,7 +1371,11 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
-static inline void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}
+static inline struct mlx5_cache_ent *
+mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
+{
+	return NULL;
+}
 static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 					 struct mlx5_ib_mr *mr, int flags) {}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index e7a3d4fa52d0..df3e551ad7cd 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -514,18 +514,22 @@ static const struct file_operations limit_fops = {
 
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
 
@@ -589,8 +593,8 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 			if (err != -EAGAIN) {
 				mlx5_ib_warn(
 					dev,
-					"command failed order %d, err %d\n",
-					ent->order, err);
+					"command failed order %s, err %d\n",
+					ent->name, err);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(1000));
 			}
@@ -636,6 +640,86 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
+static int cache_rb_key_cmp(struct mlx5r_cache_rb_key cur,
+			    struct mlx5r_cache_rb_key lookup)
+{
+	int ret;
+
+	ret = cur.access_mode - lookup.access_mode;
+	if (ret)
+		return ret;
+
+	ret = cur.access_flags - lookup.access_flags;
+	if (ret)
+		return ret;
+
+	return cur.ndescs - lookup.ndescs;
+}
+
+static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
+				 struct mlx5_cache_ent *ent)
+{
+	struct rb_node **new = &cache->rb_root.rb_node, *parent = NULL;
+	struct mlx5_cache_ent *cur;
+	int cmp;
+
+	mutex_lock(&cache->rb_lock);
+	/* Figure out where to put new node */
+	while (*new) {
+		cur = rb_entry(*new, struct mlx5_cache_ent, node);
+		parent = *new;
+		cmp = cache_rb_key_cmp(ent->rb_key, cur->rb_key);
+		if (cmp < 0)
+			new = &((*new)->rb_left);
+		if (cmp > 0)
+			new = &((*new)->rb_right);
+		if (cmp == 0) {
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
+static struct rb_node *
+mlx5_cache_find_smallest_ent(struct mlx5_mkey_cache *cache,
+			     struct mlx5r_cache_rb_key rb_key)
+{
+	struct rb_node *node = cache->rb_root.rb_node;
+	struct mlx5_cache_ent *cur, *smallest = NULL;
+	int cmp;
+
+	/*
+	 * Find the smallest ent with ent.rb_key >= rb_key.
+	 */
+	while (node) {
+		cur = rb_entry(node, struct mlx5_cache_ent, node);
+
+		cmp = cache_rb_key_cmp(rb_key, cur->rb_key);
+		if (cmp < 0) {
+			/* cur.rb_key > rb_key */
+			smallest = cur;
+			node = node->rb_left;
+		}
+		if (cmp > 0)
+			node = node->rb_right;
+		if (cmp == 0)
+			return &cur->node;
+	}
+
+	return (smallest &&
+		smallest->rb_key.access_mode == rb_key.access_mode &&
+		smallest->rb_key.access_flags == rb_key.access_flags) ?
+		       &smallest->node :
+		       NULL;
+}
+
 static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 {
 	xa_lock_irq(&ent->mkeys);
@@ -655,36 +739,41 @@ static bool mlx5_ent_get_mkey(struct mlx5_cache_ent *ent, struct mlx5_ib_mr *mr)
 	return true;
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
 static bool mlx5_cache_get_mkey(struct mlx5_ib_dev *dev,
 				struct mlx5r_cache_rb_key rb_key,
 				struct mlx5_ib_mr *mr)
 {
+	struct mlx5_mkey_cache *cache = &dev->cache;
+	unsigned int order, upper_bound;
 	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
 
-	if (!mlx5r_umr_can_reconfig(dev, 0, rb_key.access_flags))
-		return false;
+	order = order_base_2(rb_key.ndescs) > 2 ?
+			order_base_2(rb_key.ndescs) : 2;
+	upper_bound = 1 << order;
 
-	if (rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
-		ent = &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY];
+	/*
+	 * Find the smallest node within the range with available mkeys.
+	 */
+	mutex_lock(&cache->rb_lock);
+	node = mlx5_cache_find_smallest_ent(cache, rb_key);
+	while (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		if (ent->rb_key.access_mode != rb_key.access_mode ||
+		    ent->rb_key.access_flags != rb_key.access_flags ||
+		    ent->rb_key.ndescs > upper_bound)
+			break;
 
-	ent = mkey_cache_ent_from_order(dev, order_base_2(rb_key.ndescs));
-	if (!ent)
-		return false;
+		if (mlx5_ent_get_mkey(ent, mr)) {
+			mutex_unlock(&cache->rb_lock);
+			return true;
+		}
 
-	return mlx5_ent_get_mkey(ent, mr);
+		node = rb_next(node);
+	}
+	mutex_unlock(&cache->rb_lock);
+
+	return false;
 }
 
 static int get_uchangeable_access_flags(struct mlx5_ib_dev *dev,
@@ -743,10 +832,8 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 	return mr;
 }
 
-static void clean_keys(struct mlx5_ib_dev *dev, int c)
+static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 {
-	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent = &cache->ent[c];
 	u32 mkey;
 
 	cancel_delayed_work(&ent->dwork);
@@ -765,26 +852,19 @@ static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
 
-	debugfs_remove_recursive(dev->cache.root);
-	dev->cache.root = NULL;
+	debugfs_remove_recursive(dev->cache.fs_root);
+	dev->cache.fs_root = NULL;
 }
 
-static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
+static void mlx5_cache_ent_debugfs_init(struct mlx5_ib_dev *dev,
+					struct mlx5_cache_ent *ent, int order)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
 	struct dentry *dir;
-	int i;
 
-	if (!mlx5_debugfs_root || dev->is_rep)
-		return;
-
-	cache->root = debugfs_create_dir("mr_cache", mlx5_debugfs_get_dev_root(dev->mdev));
-
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
-		sprintf(ent->name, "%d", ent->order);
-		dir = debugfs_create_dir(ent->name, cache->root);
+	if (cache->fs_root) {
+		sprintf(ent->name, "%d", order);
+		dir = debugfs_create_dir(ent->name, cache->fs_root);
 		debugfs_create_file("size", 0600, dir, ent, &size_fops);
 		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
 		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
@@ -799,68 +879,114 @@ static void delay_time_func(struct timer_list *t)
 	WRITE_ONCE(dev->fill_delay, 0);
 }
 
-int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
+struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
+					      struct mlx5r_cache_rb_key rb_key)
+{
+	struct mlx5_cache_ent *ent;
+	int ret;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
+	ent->rb_key = rb_key;
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
+static int mlx5_cache_init_default_entries(struct mlx5_ib_dev *dev)
 {
 	struct mlx5r_cache_rb_key rb_key = { .access_mode =
 						    MLX5_MKC_ACCESS_MODE_MTT };
 	struct mlx5_mkey_cache *cache = &dev->cache;
+	bool can_use_cache, need_cache;
 	struct mlx5_cache_ent *ent;
-	int i;
+	int order;
+
+	if (mlx5_debugfs_root && !dev->is_rep)
+		cache->fs_root = debugfs_create_dir(
+			"mr_cache", mlx5_debugfs_get_dev_root(dev->mdev));
+
+	can_use_cache = !dev->is_rep && mlx5r_umr_can_load_pas(dev, 0);
+	need_cache = (dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
+		     mlx5_core_is_pf(dev->mdev);
+
+	for (order = 2; order <= MKEY_CACHE_LAST_STD_ENTRY + 2; order++) {
+		rb_key.ndescs = 1 << order;
+		ent = mlx5r_cache_create_ent(dev, rb_key);
+		if (IS_ERR(ent))
+			return PTR_ERR(ent);
+
+		mlx5_cache_ent_debugfs_init(dev, ent, order);
+
+		if (can_use_cache && need_cache &&
+		    order <= mkey_cache_max_order(dev)) {
+			ent->limit =
+				dev->mdev->profile.mr_cache[order - 2].limit;
+			xa_lock_irq(&ent->mkeys);
+			queue_adjust_cache_locked(ent);
+			xa_unlock_irq(&ent->mkeys);
+		}
+	}
+
+	ent = mlx5_odp_init_mkey_cache_entry(dev);
+	if (ent) {
+		if (IS_ERR(ent))
+			return PTR_ERR(ent);
+
+		mlx5_cache_ent_debugfs_init(dev, ent,
+					    MLX5_IMR_KSM_CACHE_ENTRY + 2);
+	}
+
+	return 0;
+}
+
+int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
+{
+	int err;
 
 	mutex_init(&dev->slow_path_mutex);
-	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
-	if (!cache->wq) {
+	mutex_init(&dev->cache.rb_lock);
+	dev->cache.rb_root = RB_ROOT;
+	dev->cache.wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
+	if (!dev->cache.wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
 		return -ENOMEM;
 	}
 
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
-		xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
-		ent->order = i + 2;
-		ent->dev = dev;
-		ent->limit = 0;
-
-		INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
-
-		if (i > MKEY_CACHE_LAST_STD_ENTRY) {
-			mlx5_odp_init_mkey_cache_entry(ent);
-			continue;
-		}
-
-		if (ent->order > mkey_cache_max_order(dev))
-			continue;
-
-		rb_key.ndescs = 1 << ent->order;
-		ent->rb_key = rb_key;
-		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
-		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
-		    mlx5r_umr_can_load_pas(dev, 0))
-			ent->limit = dev->mdev->profile.mr_cache[i].limit;
-		else
-			ent->limit = 0;
-		xa_lock_irq(&ent->mkeys);
-		queue_adjust_cache_locked(ent);
-		xa_unlock_irq(&ent->mkeys);
-	}
-
-	mlx5_mkey_cache_debugfs_init(dev);
+	err = mlx5_cache_init_default_entries(dev);
+	if (err)
+		goto err;
 
 	return 0;
+err:
+	mlx5_mkey_cache_cleanup(dev);
+	return err;
 }
 
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
@@ -870,8 +996,15 @@ int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
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
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 90339edddfed..b29ec4e0d8ff 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1587,16 +1587,17 @@ mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	return err;
 }
 
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
+struct mlx5_cache_ent *mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
 {
 	struct mlx5r_cache_rb_key rb_key = {
 		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
 		.ndescs = mlx5_imr_ksm_entries
 	};
 
-	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
-		return;
-	ent->rb_key = rb_key;
+	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
+		return NULL;
+
+	return mlx5r_cache_create_ent(dev, rb_key);
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
-- 
2.17.2

