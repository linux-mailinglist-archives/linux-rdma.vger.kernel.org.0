Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949526455E7
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 09:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiLGI6s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 03:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiLGI6k (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 03:58:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC6CCE
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 00:58:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I68Z8u0hKf0nMUskPPaJSj8mfrXc8C4zK2XBxjYeNQgG9ooJnFCRkgSA8kHmrXtj1zSx7kyYuLT2bBLoIN/D7bgB1KCj7B6PKpbusUqCffj3+KKgtezdDVgRO7+bfgPsVsTybuUQrMDYNW0CfiqYy/xXz6L0oLHcG1I79FUgp3vTcDEHMJ5lYQV6LtEm1iIJXddB1b5/Jz56Q7rosrQyIKAF0Y5gYaJFvVPECYCGZFA5mf6rkv7jhZ/PSQy+U64h0Yop4TMcfR+GkImG9JGHWBwmPkFEVE1JSjtzBkz0vIqEP+sgwD1cIMJ03xrvE6Gb4SQU2ZPPO1HmsYhf3EGjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wku0cnl8GL3EDgsLCg26a2nwECSUm82b8QybH1gF9A=;
 b=VfhTDyNpbCYxswOz4vefWzx/sCRBFg346yEDeckkldnnYjwR/JPuCPa8uT3G3nVYCNb9A0yew0BoQDeTjh+SHfMiRgfwvXnsRwvxDxpsK+aAqMt9sZst6LhyuEIAJXHhKDN+n0Pt0UUJfMwWB2urqikrzhD+c16i8y5GgLIFMr1Xkmn28YceFxrSavS2NnrHt/BeJ1Kt0/mCkzg+HUctbwgYbUs4YN5KAz4xVYkoBJwohG2ScSaXyvW8TWsO9xwY+SjrlrW9UHWujN5rOafYqubhhNSqZ3WOC8h7L7eriwXoCCOLgxZfuifqPewP33Fd1DwolGy9+ZU3mPxFKHFbHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wku0cnl8GL3EDgsLCg26a2nwECSUm82b8QybH1gF9A=;
 b=dWf0OiTf/1v7pSpJ3f8PzAKlcslOF3BA7WSv/Dwp9ngNqabicWUzetLSC6+8Gwfm8tmK/gJeNoVecQIS1qcqmTc8ba3PXapOOu5NdP5gTdmPxMB/k4Dn9mz2ULkqdT2DVFStUT0f/qoLjBYVyimZvHRbvbtjw2hmkc8s7bfJx0BGHS1hVliHI7r10+/Jqojet/0oQqXZx4O8goqSDYIn42l3etOJfTrUR1Bwr1JzJJZjLgAlJqc8yh8xciQKU2tRRi4n03wn79Vix5oOr5QrPzzDCf3q/gbqKswcton8MuLxTfUrS3+a98EmPOcMlPjDF2nK9BycZoQ8h7fkieZcPQ==
Received: from DM6PR07CA0046.namprd07.prod.outlook.com (2603:10b6:5:74::23) by
 SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 08:58:36 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::ca) by DM6PR07CA0046.outlook.office365.com
 (2603:10b6:5:74::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 08:58:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 08:58:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:22 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:22 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 7 Dec
 2022 00:58:20 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 5/6] RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
Date:   Wed, 7 Dec 2022 10:57:51 +0200
Message-ID: <20221207085752.82458-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221207085752.82458-1-michaelgur@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a5fbfa5-2c75-4308-bc5e-08dad8313a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ExakRdn1DuWHqDqYHnZichKWxjNWSWxW/RQhy9s1yXxU+7KADfe835RykDZOtbmMoMn5rDnLJUAto5MELYl7jwfTxf+uH2uOdBQpreVO7sFSJ78ora6SaaRROIK8fY5zODjYhLZG7yTaVR1ZEHX6sa8AZvlRE/mbiMnEMf9xqFXWBFR/zm5D6THJm1+X9Tm4iIjsyletguegbcDL0CHJF2QHPpDI4Gl9mwATkBT8pyfxAFyV4TfhjeEgPPx+RiYqYRiyvLU6ji/dvAjTDKhv7My1KECrxYAgvDi3TJAzd+w/DniF2b5sZy63vxNyt3rXdHybwkzxmsxUvvOSbrFVJdoLi6jrtaBFAXwJjfp6ptoU19YnFSg+NOasHN0xtCnwOS01VUU14slJGZYgmtop7yck/TwSS3iZeQH1ImJZK9FZW6leu5UiGxKwPvAwu8H8wcBQxixk2T9y3ybkKc87wRPVcaAyR2IiZH0fL13jZf9x4PgNDAGEjiyzOta0PkR7uJ9G/lCrmsFFdgc27pRO6Tm/ha3B/AH8GRkxfEiGhlubJJ1vAZwf9eI/pXIvYwNMX8P6xbV9vGik641v1c3vXeTxj7wWzMRMwEGpVBxNisKMOrsyeOpoXg7FDmuakGdoe9nQEQjk3+Dyz0mgqa5kde78RimUgTdOJj6CgTjzjVrbFsiZgec7UHi/2KQ+mPqvks4+P8Rtm4NDsr1DTPu5FLyGtTep9faQDN0x32qpaX8=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(336012)(1076003)(186003)(316002)(478600001)(110136005)(54906003)(82310400005)(40480700001)(7636003)(356005)(82740400003)(40460700003)(86362001)(36756003)(107886003)(426003)(83380400001)(26005)(7696005)(47076005)(6666004)(2616005)(5660300002)(41300700001)(36860700001)(4326008)(2906002)(70586007)(70206006)(8676002)(8936002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:58:36.4572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5fbfa5-2c75-4308-bc5e-08dad8313a17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, when dereging an MR, if the mkey doesn't belong to a cache
entry, it will be destroyed.
As a result, the restart of applications with many non-cached mkeys is
not efficient since all the mkeys are destroyed and then recreated.
This process takes a long time (for 100,000 MRs, it is ~20 seconds for
dereg and ~28 seconds for re-reg).

To shorten the restart runtime, insert all cacheable mkeys to the cache.
If there is no fitting entry to the mkey properties, create a temporary
entry that fits it.

After a predetermined timeout, the cache entries will shrink to the
initial high limit.

The mkeys will still be in the cache when consuming them again after an
application restart. Therefore, the registration will be much faster
(for 100,000 MRs, it is ~4 seconds for dereg and ~5 seconds for re-reg).

The temporary cache entries created to store the non-cache mkeys are not
exposed through sysfs like the default cache entries.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 24 ++++++------
 drivers/infiniband/hw/mlx5/mr.c      | 55 +++++++++++++++++++++-------
 2 files changed, 55 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index be6d9ec5b127..8f0faa6bc9b5 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -617,12 +617,25 @@ enum mlx5_mkey_type {
 	MLX5_MKEY_INDIRECT_DEVX,
 };
 
+struct mlx5r_cache_rb_key {
+	u8 ats:1;
+	unsigned int access_mode;
+	unsigned int access_flags;
+	/*
+	 * keep ndescs as the last member so entries with about the same ndescs
+	 * will be close in the tree
+	 */
+	unsigned int ndescs;
+};
+
 struct mlx5_ib_mkey {
 	u32 key;
 	enum mlx5_mkey_type type;
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
+	/* User Mkey must hold either a cache_key or a cache_ent. */
+	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
 };
 
@@ -731,17 +744,6 @@ struct umr_common {
 	unsigned int state;
 };
 
-struct mlx5r_cache_rb_key {
-	u8 ats:1;
-	unsigned int access_mode;
-	unsigned int access_flags;
-	/*
-	 * keep ndescs as the last member so entries with about the same ndescs
-	 * will be close in the tree
-	 */
-	unsigned int ndescs;
-};
-
 struct mlx5_cache_ent {
 	struct xarray		mkeys;
 	unsigned long		stored;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 6531e38ef4ec..2e984d436ad5 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1096,15 +1096,14 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	rb_key.access_flags = get_unchangeable_access_flags(dev, access_flags);
 	ent = mkey_cache_ent_from_rb_key(dev, rb_key);
 	/*
-	 * Matches access in alloc_cache_mr(). If the MR can't come from the
-	 * cache then synchronously create an uncached one.
+	 * If the MR can't come from the cache then synchronously create an uncached
+	 * one.
 	 */
-	if (!ent || ent->limit == 0 ||
-	    !mlx5r_umr_can_reconfig(dev, 0, access_flags) ||
-	    mlx5_umem_needs_ats(dev, umem, access_flags)) {
+	if (!ent) {
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
 		mutex_unlock(&dev->slow_path_mutex);
+		mr->mmkey.rb_key = rb_key;
 		return mr;
 	}
 
@@ -1195,6 +1194,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 		goto err_2;
 	}
 	mr->mmkey.type = MLX5_MKEY_MR;
+	mr->mmkey.ndescs = get_octo_len(iova, umem->length, mr->page_shift);
 	mr->umem = umem;
 	set_mr_fields(dev, mr, umem->length, access_flags, iova);
 	kvfree(in);
@@ -1732,6 +1732,40 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }
 
+static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
+				    struct mlx5_ib_mr *mr)
+{
+	struct mlx5_mkey_cache *cache = &dev->cache;
+	struct mlx5_cache_ent *ent;
+
+	if (mr->mmkey.cache_ent) {
+		xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
+		mr->mmkey.cache_ent->in_use--;
+		xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
+		goto end;
+	}
+
+	mutex_lock(&cache->rb_lock);
+	ent = mkey_cache_ent_from_rb_key(dev, mr->mmkey.rb_key);
+	mutex_unlock(&cache->rb_lock);
+	if (ent) {
+		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
+			mr->mmkey.cache_ent = ent;
+			goto end;
+		}
+	}
+
+	ent = mlx5r_cache_create_ent(dev, mr->mmkey.rb_key, false);
+	if (IS_ERR(ent))
+		return PTR_ERR(ent);
+
+	mr->mmkey.cache_ent = ent;
+
+end:
+	return push_mkey(mr->mmkey.cache_ent, false,
+			 xa_mk_value(mr->mmkey.key));
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -1777,16 +1811,11 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	/* Stop DMA */
-	if (mr->mmkey.cache_ent) {
-		xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
-		mr->mmkey.cache_ent->in_use--;
-		xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
-
+	if (mr->umem && mlx5r_umr_can_load_pas(dev, mr->umem->length))
 		if (mlx5r_umr_revoke_mr(mr) ||
-		    push_mkey(mr->mmkey.cache_ent, false,
-			      xa_mk_value(mr->mmkey.key)))
+		    cache_ent_find_and_store(dev, mr))
 			mr->mmkey.cache_ent = NULL;
-	}
+
 	if (!mr->mmkey.cache_ent) {
 		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
 		if (rc)
-- 
2.17.2

