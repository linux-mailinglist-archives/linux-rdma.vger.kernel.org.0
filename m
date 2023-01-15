Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20766B14C
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 14:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjAONfY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 08:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjAONfW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 08:35:22 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B31351D
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 05:35:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy5O5CbOJAyMLq7MzNNWVfnj1iqF+XNBzwtGKvkdNgCI4eg5dr637V1z7AkX4TejuDbUDag3IM7NiJFNgZSWelSbVV1NWyGxEwzoJFcDWRM4//8ozoHL9r5EoM5zqfcZjSHxA86E3ks3uS0eQ7mJaj1ylI6yefrMFo7gO+TXcNExAHOTEMoaVeRWJ9mRtuX3CrFMXPElzN6AGx7yNAhqrSiOo6dmbC1PccBSHSlg0Hgpm8VWoyqKlW9fpNhQACvOBfAz1d0Vmrk0i9GXiuZLnwOaOiMlIUTQrDExlDwgdlWj8ehTX+cNvHtyhXSKFTROCC0IiSkF49gqSugBlTfddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5KPti2PEQGxJTtjE9VaaDOiynK8ByR/OFWsMStXdMo=;
 b=G0qSefvkhRV3GzE1dr8QXsa9jcXwD7bKV5A1ffi96rTQbkxEzn65F9VGpWwJ4UQqNgdXKmnEUWHlTlKmqqW3LBaC33ShmApHQSFb6E3URJmzyF+lYVpbPxWcVXBxHiIZYvBEveG5Udney7PIqyKIx5Sh7TudELjHNVtp1YHn/1KZ2sSPXQFjMmPh6TYlw8YgUvVdIA2/+qLXLf5vIp5lc2iO1EWtwZ1jgVebH4zNOe2qfznaXgzov+U2awOjIewA2z+G+GE0YwEutjGBfImhtp0pAV7a/whmZUCrhtHIUGFHgrNBiCnBBmy0yghIw28lbsq3wvzJoP4B739sIibpWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5KPti2PEQGxJTtjE9VaaDOiynK8ByR/OFWsMStXdMo=;
 b=gz2Ae3Rp4NqWpxlC/0GoVcz788naIv61WzX7eVczjBNdVT39URq320OPfK3f3bh7DcsOp/uEjwgqTHLkBc+tMyxaQ94BycSCOaIX9nx7T9zjlcboHcKaw8yWtfXIH8O6s4VIcOt92rmtukXldtBdSjjNZ0LxvqQsTtwxLZ8jwFN1cb+SjClBoalQXFmqOiXo/vqGpmNZigGaxkSgmdNledmyQlrVY8v9nSEITI0aRELoRkV5CeFgy9xUP3BWSKCsQNJL8ouwcyM5qpUAsB/kxBefE82UgV4jF3IZf1/Oz6envAEXF4nu6ARehkfjwJTX5Sv86oa9q6WyQETQfehIbQ==
Received: from MW4PR03CA0310.namprd03.prod.outlook.com (2603:10b6:303:dd::15)
 by DS0PR12MB7630.namprd12.prod.outlook.com (2603:10b6:8:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 15 Jan
 2023 13:35:19 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::4e) by MW4PR03CA0310.outlook.office365.com
 (2603:10b6:303:dd::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 13:35:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 13:35:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:11 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:10 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 15 Jan
 2023 05:35:09 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v4 rdma-next 5/6] RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
Date:   Sun, 15 Jan 2023 15:34:53 +0200
Message-ID: <20230115133454.29000-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115133454.29000-1-michaelgur@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|DS0PR12MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: c09f1a7a-c281-4ec5-6343-08daf6fd5825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VRuPdNCxuJZ/mOzaUkFc+larzWMsJno4sKiuRdF6+jtO/vvzwu8mSB4YxBo6SnhvhLNYMHMpmIj+rEB/59pv5W1nJljW0Nk4blgObdCBu5X4fPPIrCKmQE2c08e/h9APD1d+fhGdxC/QzbhCc9oEKJ1/a/fZNEn4Ll85Nx52149C3W4cm5W3yPp3+JDDH1IgMOjrbPBmXg7+ArcdR2j0DcDLxX13AeV7bRvVAHE7S7BfZDuO8YoPr8E8WN4rLeo95vj7miKws3h37wk2v/FQNREkSYGD1Iv3pzM6DXAGdJ55CwNMpsjfYJfRBVfwqf8SGq5n61Us38Ece6KZKVCvOW2mg9cMV20yD5HHSYMpxJOrKTJrQPEUeuRS9m4do2OKSbdxeN4gu8xIBBRwPaZUuhsjj0oMNqp2yvbfPYZbzSot+Ici11+USVAu5fUYYsKUtyScVrnEApMeQPcyI02Hi8pHhWU6lLVVihakX9BW0Lb6J8ixcacqQRgSQj/KESIi0NNM143nN7ZbE/F3QFVOQXKLAe4B8xeSS5c/VpJOexP/pBpgGRYz9nDFyXryBRjq2HYasmsu4IzleG50754eIKFGLufehUqhJq1rMvVSPQR9LdvW9ZAyd3WOmfObJzixUSx1tXzLLWJLuz6G/HgyctAfeoieixq47ZxslL2llr7YSBA0huxBmhVDXXQGjnIasdqrz8oUiClFMXWwPIfIFFAY1GauyIORek4S9lDMxAM=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(86362001)(36860700001)(8676002)(54906003)(41300700001)(83380400001)(70586007)(110136005)(40460700003)(4326008)(70206006)(7636003)(82740400003)(356005)(7696005)(47076005)(6666004)(478600001)(107886003)(186003)(26005)(8936002)(2906002)(426003)(316002)(1076003)(82310400005)(5660300002)(2616005)(336012)(40480700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 13:35:19.0788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c09f1a7a-c281-4ec5-6343-08daf6fd5825
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7630
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

