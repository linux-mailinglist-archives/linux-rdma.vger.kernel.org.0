Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFCC61F8B4
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiKGQPd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiKGQPY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:24 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005B2271B
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmtrrzgMkMs2FVfBXqHpneBeG//VwsveOm+iuWTcB3CSL1L9yEXvNUKCKNfxvkcg5IMTK2AcAOAbgxX7yEJ+/sBPZLBw8bat3bdERxSsZeH6l0j+rjc4lecXTzqrpwYRUV3hq9UTanyVKC7hQAdQwN1am5BxsZ7TykUWMYmVu//vqBtwHEVIx2VV4k4KeSmxe+DqWx28SmVsXg/eoFh3TLUmpHHwOEtcOqK9t6kkk7WR2Fc8iFz8HSkwCnQx5xv/r+10SbBbj8PMq4S2YSqGWydipfEVIR9kKRp106tXCmGwE+n3zhEN7H34O28SSCP9SLxiJocdxJl6tyjTauvr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwveOi1M2EVEa1DDa8BHDjWgyVGcCfx1MrrP+v+Od/4=;
 b=n9EPsxRmKqjwg2ef0fxTHuVQ+ZTxQpfUgz8fHcL45YAamVvu5wM7WQgVB2XAlFfro7pDZSvgQ3wFnjvzsap6uqENbgjJ5GhnBB5RGYR/AeLfImKHjj9ii+ufxsOap1F/qE8sdS+7wC7KROydaQMD3xq53zkH8L7+nLvwVsdmTmGKYuCqU2pu0I1lXvNZ7C4crfoeNvRsxofFgWPmxpk16b+FrOr4TEkKQsr0+18rqJEEyiYD5Nx2eP/WmhSbzn1lJq1v+s9uJPalhpsqxNjb4vOTJczrJ9cWbTA4xMTGxPM94Jp5bGXIgTJLHwIn2U+8LZkNxJVAoUA4yZtTAIq4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwveOi1M2EVEa1DDa8BHDjWgyVGcCfx1MrrP+v+Od/4=;
 b=RSVz7sP0C7siX1qOfULdrbdNADSt8SfoIsSqOWief8IrOdBeCxJjWruIM+J4chwoKsP8GBR2sEFhh2lPtaOjvh9wDRlNVvYQY3X6/461EIx23yb9r8EsSnrtUU45dVJjlqR2CLIgYolujUzT4bF4PgvOa8fi+kKqXvPt3/GJq1AJYSEk1JuNW5zFB7F2a2xx0QvOpITTHMkEaJxHyHOsYyiXI5LPY8AE+brJgxgOUcXVX/tvGIEeo5J9pnDw2GUi7Hds/4pQDjZ8/CFKyBkhAgVjatJSaoV4Kw0aWQV/pXilVbWdo6XiIyM/w3D2e7IrTa+lrkSj3gjn49vKyRtJSA==
Received: from DM6PR08CA0059.namprd08.prod.outlook.com (2603:10b6:5:1e0::33)
 by SJ1PR12MB6122.namprd12.prod.outlook.com (2603:10b6:a03:45b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:15:19 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::cc) by DM6PR08CA0059.outlook.office365.com
 (2603:10b6:5:1e0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:19 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:15:07 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:15:06 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:15:05 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 7/8] RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow
Date:   Mon, 7 Nov 2022 18:14:48 +0200
Message-ID: <20221107161449.5611-8-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|SJ1PR12MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: c772dde4-00b6-4c42-34ee-08dac0db43d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f97bRAnHvg8ot4oA5Oo27lZ6sMFDaihnBUZhIB0a7+TZyyEqWy/IZBTN6wUeLzvcYjCkje6XQhz8/38IqzmyR/gxE8oyIe88HuE7rqkfxNAoxaKAk/qHpj3mWMXbU7TlWPW4SIkOlgMan85ieQerK5SdhW/rj/CY0i5xGd5Je2fcWgRkUun6tp/1MJ7T6o+W/jhX4WWuknr+Gm3bcGez0oCTu3PgHhLqrUDHdfVCDPZ68ejKwu80lLxU3nsnUDzLcTD9dMamiagcwaAqtDYRTSKBzycfRkUyUv5ri+mJYcPia4Z6IwFwSokuNjzD6Cbg7+EsVG4jgFL9BB2jRpnCdaQPYsiysfFa9yjuFnof+0OCyDt15jG+d0W/AlxUhrVQu3wJ43UIjrl6suAeTXug1LmpG/54qNUyIJasFiWpbQfhLP3Ssbjnj4ade9IPvYg8D+fKmllbRD7YXN6ZBDOxn2GwrUwDw/jrKK97B+VqXVeHJclSyr8s8XFtMumNGMLF0wzf44z2CAVzhAUMr4jqyqFQuZlR5BioDhE3kbGH/8BGgTs21IS+CZFB4zpFYKHp1Dig2rbY/NmNCbSvAX3x4MOZV8i6ghBxI+cwM5+jMfLUryavi9DtnjXFhiiJipJkkKAKZl/3uvsvLN/vtaYCxNrolkdh8BAhbfVjUx+KAY5z8gEx6J683ot3sVsubLsv4CAgPMkejAmUO5UHKPEZYsV8dOdCYubza84eonBkSJKhzPI+fAaJ5gRmvjGEtV3NXrg4TYRzKip3qF8c3MtgNUyiSxoydMRgvMle/iV/+ek=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(36756003)(7636003)(82740400003)(40460700003)(40480700001)(8936002)(2906002)(107886003)(26005)(2616005)(1076003)(186003)(426003)(336012)(7696005)(47076005)(6666004)(83380400001)(36860700001)(110136005)(54906003)(356005)(82310400005)(5660300002)(70206006)(70586007)(316002)(478600001)(4326008)(41300700001)(8676002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:19.3382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c772dde4-00b6-4c42-34ee-08dac0db43d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6122
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

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 ++
 drivers/infiniband/hw/mlx5/mr.c      | 48 +++++++++++++++++++++++-----
 2 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0bf2511fdfe4..dafd4c34a968 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -629,6 +629,8 @@ struct mlx5_ib_mkey {
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
+	/* User Mkey must hold either a cache_key or a cache_ent. */
+	struct mlx5r_cache_rb_key rb_key;
 	struct mlx5_cache_ent *cache_ent;
 };
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index df3e551ad7cd..78d0bc10b821 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -826,6 +826,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, u8 access_mode,
 			return ERR_PTR(err);
 		}
 		mr->mmkey.ndescs = ndescs;
+		mr->mmkey.rb_key = rb_key;
 	}
 	mr->mmkey.type = MLX5_MKEY_MR;
 	init_waitqueue_head(&mr->mmkey.wait);
@@ -1738,6 +1739,42 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }
 
+static int cache_ent_find_and_store(struct mlx5_ib_dev *dev,
+				    struct mlx5_ib_mr *mr)
+{
+	struct mlx5_mkey_cache *cache = &dev->cache;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+
+	if (mr->mmkey.cache_ent) {
+		xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
+		mr->mmkey.cache_ent->in_use--;
+		xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
+		goto end;
+	}
+
+	mutex_lock(&cache->rb_lock);
+	node = mlx5_cache_find_smallest_ent(&dev->cache, mr->mmkey.rb_key);
+	mutex_unlock(&cache->rb_lock);
+	if (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		if (ent->rb_key.ndescs == mr->mmkey.rb_key.ndescs) {
+			mr->mmkey.cache_ent = ent;
+			goto end;
+		}
+	}
+
+	ent = mlx5r_cache_create_ent(dev, mr->mmkey.rb_key);
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
@@ -1783,16 +1820,11 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
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

