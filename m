Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9FC67BFF0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 23:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjAYW25 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 17:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjAYW24 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 17:28:56 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91A560C9A
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 14:28:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2tZ5vWViXEGXPKOXIz59LWetP+FIEWlXj4r6pFaLb3UL5v97ajZlpT+csr79/R/yEUTnQ8CDKH/AGd6XByT+VZBR5pMbpKJoDSyg1GtFSwT6gxMEknJ2rSBEpaPtmAi+JEGHLzF77i1Ax3o4oLrQbtKIvnpMmrxKNMcfGjsFKWM31eaG1LVSoE3xku3pLSle1w5BjIewC7PzsOq94+1WbC37YqgyNeih6r1kExWQmCk2uCf32J9msNW844GGYse8yBnP2ZbMkwPl82UlUe2pBBP1jZtVqQUwKgRPxY/h2i+/0hC43zeGAdJAZwCJwnoxXuG8nYuyYYzu1cM/xshKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5KPti2PEQGxJTtjE9VaaDOiynK8ByR/OFWsMStXdMo=;
 b=nG+zFvfaPdZlHyX0E/4vxIVnfjzBnR3Ir/vhXjLLH0qAuq49mDbioXkZLovYDzA/lDw6UfRccgIzf8SSLbHN0MMo+NfzbRozmB2kFRjPaahQCAkjjkpRHtORWeuRkmwd0KVjHycQj8DY/rMd4RNLwINjupWXTySpyeIlVbNBjeQFDVogyZF9Ajn5B/hA91fp5f3Lv1l7CBNCIKEh0Ns87y4TCH7GfJkgt5dmccXirpi880LU5lmGI4ShEevVsClSUuGTIoSwUabCssmBx1707RUNVlvnS+9fHm4qxk/1e4KW6MqMN0K6beu8yGQuE+beLssxCSIR9ClJ1Gwz2ruiYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5KPti2PEQGxJTtjE9VaaDOiynK8ByR/OFWsMStXdMo=;
 b=TbtQIW4l+0CWhDdL+tB9lU+/2Dr/kixOlcXZyu6do7WDm7maO2M3wLJDpNocZWgVlYBbm4YzqOSBkPdWHzzB2npyCJ+vN57jWAHr5JDrz/M8GKthLTT5VfKK9qoIfpp32j/QXK1j+5Cm0/CFa4U6i1EsSHLfTjc2NCebYGxiYckIF0bWaTKlOc242qgw7WEzuT6PoHCQU+abb6t65QsoZBjk6vQoL0BxN1LnT9JR01qpbcJko7QGveci01aTbkWI5chqObaDARToTdlhPQYjRhJ3wzyhE+XNp9Yd0M0RL7zOmpHQ4K9rRe9u1BgKB/B4qXqMzuF9K616Z1QR1gFtMg==
Received: from DS7PR03CA0129.namprd03.prod.outlook.com (2603:10b6:5:3b4::14)
 by BY5PR12MB5016.namprd12.prod.outlook.com (2603:10b6:a03:1c5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:28:44 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::1c) by DS7PR03CA0129.outlook.office365.com
 (2603:10b6:5:3b4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Wed, 25 Jan 2023 22:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 22:28:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 14:28:34 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 14:28:34 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 14:28:32 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v5 rdma-next 5/6] RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
Date:   Thu, 26 Jan 2023 00:28:06 +0200
Message-ID: <20230125222807.6921-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230125222807.6921-1-michaelgur@nvidia.com>
References: <20230125222807.6921-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|BY5PR12MB5016:EE_
X-MS-Office365-Filtering-Correlation-Id: ec424dab-606a-4a50-c809-08daff238499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U2U7U4nrdFFmW5HpXmB/vM1CzPWREEzW8BTxxf957J41+5mx6OkyP7U/R0itN1SzDMSAfghHW0I4M+HJw2942/cHJf+J4upawkp0hMg04WbHQUXY+hKjF1TBL+KGHJ33hPh+VDngUMIQi6RFo+Ab5ad6dU3MKXy7L6vrrvTFbHRwRcvunDxhH+Hf6Kd5cl0vOwK38tEtYm0kgCMf8WN4U9MzFould+0nkk+O7GP+4UW4/N9LQe9fwERL+Y4NL9qbXLSmRrJXALx1zqfZrnPTXDMOk+9EeM3DAaInPLVrgy56Qm5q9kb839Osbe7ZjdHjer4UPKtS0rLZNDesi+Zv6xAOWiFtXdAwL2913zUAw+7vwh05e/ffPG/G6DoPAFtoqfMdnsIU4LJOIIGweIemNgwFI7PiFwmU+MLxvisXCmSEenIlYbC8zVQl2DaMDQSFFybSFJKuVrmSKJnWztz0mDfFYwNyd02HjN9Hg12sv2WCZzl5nmXca9jDizq9kBdf6XvA5xN2paDJGrjKzbtyYCWzWpR7Ypt5sfJHK3KeHyEarbu2hj9ixAroIukBOYnPIlpyO5iDMQQ2eq5qAvAw4MaZU4FrUD6EactcnpNLQNmWPmnsunLaTn/YOQn0G0pQZaXHcb0y+9+ZdYRteSrSRffPNbheT7YGWNr2m9mC9qIdd4erT93ymCjgbpgQDb+d
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199018)(36840700001)(46966006)(86362001)(70586007)(70206006)(40480700001)(83380400001)(36860700001)(8936002)(82740400003)(47076005)(41300700001)(7636003)(2906002)(5660300002)(82310400005)(4326008)(54906003)(426003)(107886003)(36756003)(8676002)(316002)(356005)(478600001)(336012)(1076003)(2616005)(26005)(6666004)(7696005)(186003)(110136005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:28:43.8549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec424dab-606a-4a50-c809-08daff238499
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5016
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +
 drivers/infiniband/hw/mlx5/mr.c      | 55 +++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d560d6cbbe9b..6e0c0a931d78 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -630,6 +630,8 @@ struct mlx5_ib_mkey {
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
+	/* User Mkey must hold either a rb_key or a cache_ent. */
+	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
 };
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 7924953b9bd0..25e80529edd8 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1110,15 +1110,14 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
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
 
@@ -1209,6 +1208,7 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 		goto err_2;
 	}
 	mr->mmkey.type = MLX5_MKEY_MR;
+	mr->mmkey.ndescs = get_octo_len(iova, umem->length, mr->page_shift);
 	mr->umem = umem;
 	set_mr_fields(dev, mr, umem->length, access_flags, iova);
 	kvfree(in);
@@ -1746,6 +1746,40 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
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
@@ -1791,16 +1825,11 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
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

