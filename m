Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0B66B118
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 13:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjAOM6p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 07:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjAOM6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 07:58:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1847A12582
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 04:58:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuEUellg+cbzBCgdOuu6UviZ7CL7Pwha7yYD5CgXiy06qtLj2SM4PtC2MH/2hYNBWd0SHjojKAdg4fD++wZzN8Z5FFKhIkR87yyzshfssv+HgDULPOe3Aa0uPhs9ltAp8aPbUPVkSVj0h7Qnqzkwn2LX98lFls6oWaTqIVebmRRusBZ4Lzvo7jUy/vjxQzdLAb2LSw+BvoK7FjXNB7jkez+ScCDjAARpNMr5eGkFuIFqPSq1qhW5PDjlM7F1P5sA51jRq1ZYXCzAAy+h1GvEyCR2QnJSP9X8P/4rUNg4hvKTmRaZ7cT7rdmQ8KSqk8XcPt3ysb2/dx2jBCELADKbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBzvByxbZTTt7MajI2nwD/ZIz7StfMdlgAvPxqlp+5E=;
 b=KDXYNhqRs1/tNAqZPDOG2BQnhJ5zyzguQBxm+8Qk5xkFKHFMTBaejaBM5+h1AlSSxypI+RD87Gh9L98Ont5N1kEY17HUTcTatQmlyqDCkp6+A1+0+hrI3IfEWdNK3YQ3+xFZNE8IkGvpPX7wgEr5cuut7EZS2TLHnOLlijsI44pMAz5CgL29sPCycLNT7H7b+rhxf4BdlB5Myi+OsnnenmPgpxIMPYdbH+/zh6GhpkQUIgzFKLVR2hGSV9MTZw7kuiFS8NAH4gIkfTVm5hmtSV1QK2kJXrVt+nEItSdwQ799u48wtrkU4HBC2XqyJADkRtyJZV0/mtOGmkHNZwxFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBzvByxbZTTt7MajI2nwD/ZIz7StfMdlgAvPxqlp+5E=;
 b=rDADmvhIvXf72Mnv03tBS8vvKMc5bC5I0XDTW+Ki8oiVrI9iND7/C4apyCTdsrd+Fr+/VZPiBMIyKXegfM/AqhY+6nqROyLhF5gSp2dE4pTt+5siQlGfVm7Ih5/pHdiBIUaPuft7fCc8OtvJnRGW3dgkqBAeSQFYe7HExQjzng69D9Us2GM3bQeLutmvbM8WbgtTgDlI12z2Dxx+Rq7q1C4WKepkPbvfZRQmv8nBODWNYvG5C/VgWAqpFpoI0kc2N1rIg/aQQGbb8/pfxO09nsZz184CoSvwzrAvFz2vnOHq4SN8OITpQ2S3LJjrcpyHfj2PIi5JrNi7ps8M6fMyeg==
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by CY8PR12MB8411.namprd12.prod.outlook.com (2603:10b6:930:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sun, 15 Jan
 2023 12:58:41 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::fd) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 12:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 12:58:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 04:58:34 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 04:58:33 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 04:58:31 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 4/6] RDMA/mlx5: Introduce mlx5r_cache_rb_key
Date:   Sun, 15 Jan 2023 14:58:17 +0200
Message-ID: <20230115125819.15034-5-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115125819.15034-1-michaelgur@nvidia.com>
References: <20230115125819.15034-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT040:EE_|CY8PR12MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b63234-2155-4ea6-aa3c-08daf6f83a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fG4u7fDAUxvUqF/758O3N+xMsCFqRSQ+w4liAEOxTuZyFP2xGw1IArDcZ2XFGisdKp6E9a1555Ogm17zCFMmGmP76ldYibKS9+XlC9OU5JdAEt31Y7jOBOEqeSYpHQWChivpV1OUIbOF62miJiz2OxGKhVYPckO4rEzDKaU60saH+cBY8ly/1Ji9VgWa/I3mjphMqn17FuyJoss8oIuUjKPC7WCQ2eJj7Qn7Fz9LIBgdvv89nMZJ1t/SwjTyohl5qZhEYteILWq5SNxWKuuV2XtyulSVDiq6BpjcJFAMaDuvByp6VBbWkhBS1NDldGUsq0RHVZuNfLseBSL3ixjweEozg+sxRXBikuWtCcQg5pptb7dZLwLOVVsWnBe/3Bo1ZQvriTI6TwbhDrndaBWEKz65rIFCA9419LccNRAXMLfNCFr82ludSPJTMsr2chBMYVsnVoSvYmbiXglwiz+iBEH1vWscGmyeS++D9GyRZvVtwodemlrVksJEMcTkKYWCBG5T4sKMoF3w44LHDe34619Z8GmgradqGvNVJUfbzgoq5/g3mVV9rQaPbX7etmQsSKKeeBHveXTnDWt4x600h1npEbOGMk5MSUKIPCctNGTN3VoRs4uCo6RWV4BfjomroNYVdNy+cmfeRtlHupGdxOkDZwdTpUZ8jdXg9JqeImi6kUZhj0KI8p3sKiyb9fHNM1MwX1Epu0Grq/DwM3+Rv4G40rXQolxBJ35RlUozTZY=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(7636003)(356005)(40460700003)(36756003)(40480700001)(82310400005)(86362001)(316002)(70206006)(70586007)(8676002)(4326008)(26005)(336012)(186003)(478600001)(54906003)(1076003)(110136005)(7696005)(2616005)(36860700001)(8936002)(426003)(47076005)(41300700001)(107886003)(83380400001)(6666004)(5660300002)(30864003)(2906002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 12:58:41.1574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b63234-2155-4ea6-aa3c-08daf6f83a0b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8411
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Switch from using the mkey order to using the new struct as the key to
the RB tree of cache entries.
The key is all the mkey properties that UMR operations can't modify.
Using this key to define the cache entries and to search and create
cache mkeys.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Change-Id: I30d75a2404804d8c5259c27d0b256b17c1d3c24d
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  27 ++--
 drivers/infiniband/hw/mlx5/mr.c      | 228 +++++++++++++++++++--------
 drivers/infiniband/hw/mlx5/odp.c     |  30 ++--
 3 files changed, 201 insertions(+), 84 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index eec16db2d536..d560d6cbbe9b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -617,6 +617,13 @@ enum mlx5_mkey_type {
 	MLX5_MKEY_INDIRECT_DEVX,
 };
 
+struct mlx5r_cache_rb_key {
+	u8 ats:1;
+	unsigned int access_mode;
+	unsigned int access_flags;
+	unsigned int ndescs;
+};
+
 struct mlx5_ib_mkey {
 	u32 key;
 	enum mlx5_mkey_type type;
@@ -737,11 +744,9 @@ struct mlx5_cache_ent {
 	unsigned long		reserved;
 
 	char                    name[4];
-	u32                     order;
-	u32			access_mode;
-	unsigned int		ndescs;
 
 	struct rb_node		node;
+	struct mlx5r_cache_rb_key rb_key;
 
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
@@ -1320,14 +1325,13 @@ int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
 struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      int order);
+					      struct mlx5r_cache_rb_key rb_key,
+					      bool persistent_entry);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags);
+				       int access_flags, int access_mode,
+				       int ndescs);
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc_order(struct mlx5_ib_dev *dev, u32 order,
-					     int access_flags);
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
 struct ib_wq *mlx5_ib_create_wq(struct ib_pd *pd,
@@ -1350,7 +1354,7 @@ int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent);
+int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev);
 void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 			   struct mlx5_ib_mr *mr, int flags);
 
@@ -1369,7 +1373,10 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
-static inline void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent) {}
+static inline int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev)
+{
+	return NULL;
+}
 static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 					 struct mlx5_ib_mr *mr, int flags) {}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5cc618db277f..7924953b9bd0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -292,11 +292,13 @@ static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
 	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2, (ent->access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, access_mode_1_0, ent->rb_key.access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2,
+		(ent->rb_key.access_mode >> 2) & 0x7);
 
 	MLX5_SET(mkc, mkc, translations_octword_size,
-		 get_mkc_octo_size(ent->access_mode, ent->ndescs));
+		 get_mkc_octo_size(ent->rb_key.access_mode,
+				   ent->rb_key.ndescs));
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 }
 
@@ -594,8 +596,8 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 			if (err != -EAGAIN) {
 				mlx5_ib_warn(
 					dev,
-					"command failed order %d, err %d\n",
-					ent->order, err);
+					"add keys command failed, err %d\n",
+					err);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(1000));
 			}
@@ -641,22 +643,49 @@ static void delayed_cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
+static int cache_ent_key_cmp(struct mlx5r_cache_rb_key key1,
+			     struct mlx5r_cache_rb_key key2)
+{
+	int res;
+
+	res = key1.ats - key2.ats;
+	if (res)
+		return res;
+
+	res = key1.access_mode - key2.access_mode;
+	if (res)
+		return res;
+
+	res = key1.access_flags - key2.access_flags;
+	if (res)
+		return res;
+
+	/*
+	 * keep ndescs the last in the compare table since the find function
+	 * searches for an exact match on all properties and only closest
+	 * match in size.
+	 */
+	return key1.ndescs - key2.ndescs;
+}
+
 static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 				 struct mlx5_cache_ent *ent)
 {
 	struct rb_node **new = &cache->rb_root.rb_node, *parent = NULL;
 	struct mlx5_cache_ent *cur;
+	int cmp;
 
 	mutex_lock(&cache->rb_lock);
 	/* Figure out where to put new node */
 	while (*new) {
 		cur = rb_entry(*new, struct mlx5_cache_ent, node);
 		parent = *new;
-		if (ent->order < cur->order)
+		cmp = cache_ent_key_cmp(cur->rb_key, ent->rb_key);
+		if (cmp > 0)
 			new = &((*new)->rb_left);
-		if (ent->order > cur->order)
+		if (cmp < 0)
 			new = &((*new)->rb_right);
-		if (ent->order == cur->order) {
+		if (cmp == 0) {
 			mutex_unlock(&cache->rb_lock);
 			return -EEXIST;
 		}
@@ -670,40 +699,45 @@ static int mlx5_cache_ent_insert(struct mlx5_mkey_cache *cache,
 	return 0;
 }
 
-static struct mlx5_cache_ent *mkey_cache_ent_from_order(struct mlx5_ib_dev *dev,
-							unsigned int order)
+static struct mlx5_cache_ent *
+mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
+			   struct mlx5r_cache_rb_key rb_key)
 {
 	struct rb_node *node = dev->cache.rb_root.rb_node;
 	struct mlx5_cache_ent *cur, *smallest = NULL;
+	int cmp;
 
 	/*
 	 * Find the smallest ent with order >= requested_order.
 	 */
 	while (node) {
 		cur = rb_entry(node, struct mlx5_cache_ent, node);
-		if (cur->order > order) {
+		cmp = cache_ent_key_cmp(cur->rb_key, rb_key);
+		if (cmp > 0) {
 			smallest = cur;
 			node = node->rb_left;
 		}
-		if (cur->order < order)
+		if (cmp < 0)
 			node = node->rb_right;
-		if (cur->order == order)
+		if (cmp == 0)
 			return cur;
 	}
 
-	return smallest;
+	return (smallest &&
+		smallest->rb_key.access_mode == rb_key.access_mode &&
+		smallest->rb_key.access_flags == rb_key.access_flags &&
+		smallest->rb_key.ats == rb_key.ats) ?
+		       smallest :
+		       NULL;
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags)
+static struct mlx5_ib_mr *_mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
+					struct mlx5_cache_ent *ent,
+					int access_flags)
 {
 	struct mlx5_ib_mr *mr;
 	int err;
 
-	if (!mlx5r_umr_can_reconfig(dev, 0, access_flags))
-		return ERR_PTR(-EOPNOTSUPP);
-
 	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
@@ -734,12 +768,44 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	return mr;
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc_order(struct mlx5_ib_dev *dev,
-					     u32 order, int access_flags)
+static int get_unchangeable_access_flags(struct mlx5_ib_dev *dev,
+					 int access_flags)
 {
-	struct mlx5_cache_ent *ent = mkey_cache_ent_from_order(dev, order);
+	int ret = 0;
 
-	return mlx5_mr_cache_alloc(dev, ent, access_flags);
+	if ((access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	    MLX5_CAP_GEN(dev->mdev, atomic) &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
+		ret |= IB_ACCESS_REMOTE_ATOMIC;
+
+	if ((access_flags & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
+		ret |= IB_ACCESS_RELAXED_ORDERING;
+
+	if ((access_flags & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+		ret |= IB_ACCESS_RELAXED_ORDERING;
+
+	return ret;
+}
+
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
+				       int access_flags, int access_mode,
+				       int ndescs)
+{
+	struct mlx5r_cache_rb_key rb_key = {
+		.ndescs = ndescs,
+		.access_mode = access_mode,
+		.access_flags = get_unchangeable_access_flags(dev, access_flags)
+	};
+	struct mlx5_cache_ent *ent = mkey_cache_ent_from_rb_key(dev, rb_key);
+
+	if (!ent)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	return _mlx5_mr_cache_alloc(dev, ent, access_flags);
 }
 
 static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
@@ -766,28 +832,32 @@ static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 	dev->cache.fs_root = NULL;
 }
 
+static void mlx5_mkey_cache_debugfs_add_ent(struct mlx5_ib_dev *dev,
+					    struct mlx5_cache_ent *ent)
+{
+	int order = order_base_2(ent->rb_key.ndescs);
+	struct dentry *dir;
+
+	if (ent->rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
+		order = MLX5_IMR_KSM_CACHE_ENTRY + 2;
+
+	sprintf(ent->name, "%d", order);
+	dir = debugfs_create_dir(ent->name, dev->cache.fs_root);
+	debugfs_create_file("size", 0600, dir, ent, &size_fops);
+	debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
+	debugfs_create_ulong("cur", 0400, dir, &ent->stored);
+	debugfs_create_u32("miss", 0600, dir, &ent->miss);
+}
+
 static void mlx5_mkey_cache_debugfs_init(struct mlx5_ib_dev *dev)
 {
+	struct dentry *dbg_root = mlx5_debugfs_get_dev_root(dev->mdev);
 	struct mlx5_mkey_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
-	struct dentry *dir;
-	int i;
 
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
 
-	dir = mlx5_debugfs_get_dev_root(dev->mdev);
-	cache->fs_root = debugfs_create_dir("mr_cache", dir);
-
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = mkey_cache_ent_from_order(dev, i);
-		sprintf(ent->name, "%d", ent->order);
-		dir = debugfs_create_dir(ent->name, cache->fs_root);
-		debugfs_create_file("size", 0600, dir, ent, &size_fops);
-		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
-		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
-		debugfs_create_u32("miss", 0600, dir, &ent->miss);
-	}
+	cache->fs_root = debugfs_create_dir("mr_cache", dbg_root);
 }
 
 static void delay_time_func(struct timer_list *t)
@@ -798,9 +868,11 @@ static void delay_time_func(struct timer_list *t)
 }
 
 struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
-					      int order)
+					      struct mlx5r_cache_rb_key rb_key,
+					      bool persistent_entry)
 {
 	struct mlx5_cache_ent *ent;
+	int order;
 	int ret;
 
 	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
@@ -808,7 +880,7 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 		return ERR_PTR(-ENOMEM);
 
 	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
-	ent->order = order;
+	ent->rb_key = rb_key;
 	ent->dev = dev;
 
 	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
@@ -818,13 +890,36 @@ struct mlx5_cache_ent *mlx5r_cache_create_ent(struct mlx5_ib_dev *dev,
 		kfree(ent);
 		return ERR_PTR(ret);
 	}
+
+	if (persistent_entry) {
+		if (rb_key.access_mode == MLX5_MKC_ACCESS_MODE_KSM)
+			order = MLX5_IMR_KSM_CACHE_ENTRY;
+		else
+			order = order_base_2(rb_key.ndescs) - 2;
+
+		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
+		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
+		    mlx5r_umr_can_load_pas(dev, 0))
+			ent->limit = dev->mdev->profile.mr_cache[order].limit;
+		else
+			ent->limit = 0;
+
+		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
+	}
+
 	return ent;
 }
 
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
+	struct rb_root *root = &dev->cache.rb_root;
+	struct mlx5r_cache_rb_key rb_key = {
+		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
+	};
 	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+	int ret;
 	int i;
 
 	mutex_init(&dev->slow_path_mutex);
@@ -838,33 +933,32 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
-	for (i = 0; i < MAX_MKEY_CACHE_ENTRIES; i++) {
-		ent = mlx5r_cache_create_ent(dev, i);
-
-		if (i > MKEY_CACHE_LAST_STD_ENTRY) {
-			mlx5_odp_init_mkey_cache_entry(ent);
-			continue;
+	mlx5_mkey_cache_debugfs_init(dev);
+	for (i = 0; i <= mkey_cache_max_order(dev); i++) {
+		rb_key.ndescs = 1 << (i + 2);
+		ent = mlx5r_cache_create_ent(dev, rb_key, true);
+		if (IS_ERR(ent)) {
+			ret = PTR_ERR(ent);
+			goto err;
 		}
+	}
 
-		if (ent->order > mkey_cache_max_order(dev))
-			continue;
+	ret = mlx5_odp_init_mkey_cache(dev);
+	if (ret)
+		goto err;
 
-		ent->ndescs = 1 << ent->order;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
-		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
-		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
-		    mlx5r_umr_can_load_pas(dev, 0))
-			ent->limit = dev->mdev->profile.mr_cache[i].limit;
-		else
-			ent->limit = 0;
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		queue_adjust_cache_locked(ent);
 		xa_unlock_irq(&ent->mkeys);
 	}
 
-	mlx5_mkey_cache_debugfs_init(dev);
-
 	return 0;
+
+err:
+	mlx5_ib_warn(dev, "failed to create mkey cache entry\n");
+	return ret;
 }
 
 int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
@@ -965,7 +1059,7 @@ static int get_octo_len(u64 addr, u64 len, int page_shift)
 static int mkey_cache_max_order(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
-		return MKEY_CACHE_LAST_STD_ENTRY + 2;
+		return MKEY_CACHE_LAST_STD_ENTRY;
 	return MLX5_MAX_UMR_SHIFT;
 }
 
@@ -995,6 +1089,9 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 					     struct ib_umem *umem, u64 iova,
 					     int access_flags)
 {
+	struct mlx5r_cache_rb_key rb_key = {
+		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
+	};
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
@@ -1007,8 +1104,11 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 						     0, iova);
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
-	ent = mkey_cache_ent_from_order(
-		dev, order_base_2(ib_umem_num_dma_blocks(umem, page_size)));
+
+	rb_key.ndescs = ib_umem_num_dma_blocks(umem, page_size);
+	rb_key.ats = mlx5_umem_needs_ats(dev, umem, access_flags);
+	rb_key.access_flags = get_unchangeable_access_flags(dev, access_flags);
+	ent = mkey_cache_ent_from_rb_key(dev, rb_key);
 	/*
 	 * Matches access in alloc_cache_mr(). If the MR can't come from the
 	 * cache then synchronously create an uncached one.
@@ -1022,7 +1122,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 		return mr;
 	}
 
-	mr = mlx5_mr_cache_alloc(dev, ent, access_flags);
+	mr = _mlx5_mr_cache_alloc(dev, ent, access_flags);
 	if (IS_ERR(mr))
 		return mr;
 
@@ -1451,7 +1551,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
 	if (WARN_ON(!*page_size))
 		return false;
-	return (1ULL << mr->mmkey.cache_ent->order) >=
+	return (mr->mmkey.cache_ent->rb_key.ndescs) >=
 	       ib_umem_num_dma_blocks(new_umem, *page_size);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 71c3c611e10a..c51d6c9a4c87 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -405,7 +405,6 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 						unsigned long idx)
 {
-	int order = order_base_2(MLX5_IMR_MTT_ENTRIES);
 	struct mlx5_ib_dev *dev = mr_to_mdev(imr);
 	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
@@ -418,8 +417,9 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	BUILD_BUG_ON(order > MKEY_CACHE_LAST_STD_ENTRY);
-	mr = mlx5_mr_cache_alloc_order(dev, order, imr->access_flags);
+	mr = mlx5_mr_cache_alloc(dev, imr->access_flags,
+				 MLX5_MKC_ACCESS_MODE_MTT,
+				 MLX5_IMR_MTT_ENTRIES);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
 		return mr;
@@ -493,8 +493,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = mlx5_mr_cache_alloc_order(dev, MLX5_IMR_KSM_CACHE_ENTRY,
-					access_flags);
+	imr = mlx5_mr_cache_alloc(dev, access_flags, MLX5_MKC_ACCESS_MODE_KSM,
+				  mlx5_imr_ksm_entries);
 	if (IS_ERR(imr)) {
 		ib_umem_odp_release(umem_odp);
 		return imr;
@@ -1587,12 +1587,22 @@ mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	return err;
 }
 
-void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
+int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev)
 {
-	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
-		return;
-	ent->ndescs = mlx5_imr_ksm_entries;
-	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
+	struct mlx5r_cache_rb_key rb_key = {
+		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
+		.ndescs = mlx5_imr_ksm_entries,
+	};
+	struct mlx5_cache_ent *ent;
+
+	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
+		return 0;
+
+	ent = mlx5r_cache_create_ent(dev, rb_key, true);
+	if (IS_ERR(ent))
+		return PTR_ERR(ent);
+
+	return 0;
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
-- 
2.17.2

