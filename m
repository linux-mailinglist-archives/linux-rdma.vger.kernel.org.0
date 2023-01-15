Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF01D66B119
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 13:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjAOM6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 07:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjAOM6o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 07:58:44 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2212583
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 04:58:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FcRf3gUOnHLt7XkowvmchDBBNVXAjlEa3AeUPqjdbX9ugKCW84qLXDVBs/kTSeWRbT0Aj8Alpjpmn8okFPLWIzziA2Kp2iKxuVB6mu4TSaVFk90l2pJ6Z/qAqZCLQT0PfhfGyBDFS4kfRLEfqVxT9ixyV6X74sHg/KuW3E5FOqcfJHV8ECdX7pjqfOoflm5XVY2cOv8R1q6bzFULC00kvgwvq6rDX3pUjAn+XI+NnPAqVwDnU6uyXWq3PlojVct8CAh983bDTsCj9z6KdwBhUOj49a2E3aYQIedCwnWWF9skaTlI75B8TFzcE0ySz2ei1NtQC1DLnTYFs3Hyb/83KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mX5njaTIkrWE1vz37Mp8CK0TXNcqiexUnKO6n47fEUs=;
 b=CFhP+FtaXG/xq2KjLYl3ZsFb6VLoXtF5uwmM9uRDbX04d4fcVwi4sD/WLNisOdeDqnJIis92htdnIxlGTp8cCq8g0H2SgxaziG7fPG6CqNmyb598YIpwe42PVOnXqobbFUas8gr5oq5LP+wFlLUsbVj7hNOnf9/9uyuSQbmhirMdl3Z2Aqlqzq6LZ9nm31beO+G/QdVMSYtaj16Qa/bADIvJtNuEaaLryn3/gPbua1cfKsYKz9yLfkNGrOfTldRtC9YmVez56cQYhOGx21rZ9XgvikL4jglZZx1B5qTCf0ck/vpd2KubMvcy9XORA+1R6lBhrWZ0xKw6XKVWnx2YAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mX5njaTIkrWE1vz37Mp8CK0TXNcqiexUnKO6n47fEUs=;
 b=Wju6b8kCRJcGEIIA/QWi6orAIUudrdpHaxVO4SWEBjNyavp0ooKlg7nBQk2w/oKJkV+rQ70rrZwiNJsFZrottXaW4aT698HDHvkCN9U4GouOh1Yjev9SmVKCZjz59CkD3yzcrM5lUyHL4BInbphQzqeZUWscSWBRwrBq/EVK9ckpBggBk6AGU7s87bP46HrxhJsJFvq5mv+asTmJ1SRkFMGjwWi4h+ZeHXUkfHHz+Lq3/dxia7VbjgQVeBJrvZIPFsMQi6f0s1QGvCqGoNaQLYxr8H26WZkt9lFj392+6cucLkqn+Q7gOMNbt2tGWHpt5OolDRZWI1AiOQqIl+2QTg==
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 12:58:42 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::de) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 12:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Sun, 15 Jan 2023 12:58:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 04:58:36 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 04:58:35 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 04:58:34 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v3 rdma-next 5/6] RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
Date:   Sun, 15 Jan 2023 14:58:18 +0200
Message-ID: <20230115125819.15034-6-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115125819.15034-1-michaelgur@nvidia.com>
References: <20230115125819.15034-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 0034f737-1647-4766-db19-08daf6f83a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8aO7L+bRWU9DDVPzgb6m97AJz2mzaV/Nq78ytYrLzI7S9FdlssAsCDdcK+N2cCCiQgVBIkR1PnybnLsO1762J8icsUeuW1YHKMaE4OYTBlyXJweh+FVJ+Y7t4qVpJCYwao/jF+J/UUswu9N9Ip+qFxsDEOma6a0/bIyM07qDdtrp2+6PDUNXyUTYAIyx/jdZ1zHAIIBBL3wJxxyBkhsLOYmHUKtm6N7G7+t0uzKRSH7MSHjpzSvabsbA5kOujGK+sMU2c9p2glglBs3odop2L4fLjbGkmWkpPX54Jxg0oYiZ6DUHWWwK5sYOETtiVCbahXkO4BZMFCDUtRiZkgpP1b6CQMvgl/kQPabxBpkYhKyyNOCJCcot2LQG8tpMFhBUgcQIXwatVv4kAaaiPleryEGZooDXLXQq7OMcBWz+EWkyFYEz6kFTwZwNb1n5F2er13MCbqgyqjbJbU8rzocrRwTaHW2sd6jQZ37B/Vw01RGYFypfJ7g1jGoLMmklgad16cYGxUrmxJMSNkfBeAwVHJUzVwN0+GVh4vfek/0aPGDWpEiyF1OIFatyKtHTkl5Gjw/B9QNiJepIoj9k6ibCkI4yLZ6nVC42vLqr1vWrf0Q3MdTXZv3kv3cA5YAfcTaVYCl435B+2IXk0hpMNP/vg21vTF7K7IvJTy/8+/w3r1z923t4ZFLYf5fQRibXip2YI+y5S5to2TdVknOc8F9e8IxWkKkmNeHkvhQFqK2Zaw=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(41300700001)(7636003)(83380400001)(86362001)(426003)(47076005)(82310400005)(36756003)(40460700003)(82740400003)(356005)(2906002)(40480700001)(36860700001)(26005)(478600001)(186003)(7696005)(70206006)(4326008)(8676002)(336012)(107886003)(316002)(110136005)(54906003)(1076003)(2616005)(6666004)(70586007)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 12:58:41.9536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0034f737-1647-4766-db19-08daf6f83a95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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
Change-Id: I453176214c36af7f6cfa7491e613651bfb2100e5
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

