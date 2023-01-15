Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8D66B148
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjAONfJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 08:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjAONfI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 08:35:08 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176213519
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 05:35:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhVHbOLKNWAH4kkLndb3nDVcjrczr1mruP6rKP/aGoDkohV37zBOvzMIi+4kqKEFbpIWqebw9UnA5KrlGG8NJrGeNPOgl6qMhWVqodK0R3eL8UlpjiE2bGK1X25e7oJzSwhXlLp3C9g7ybwC34N/VMGNuSi2VlZC1OOshx08By7cxaRMkJjxNMfTYBk0nGhLoTzrVzRIbG/rYl4HMLaZprwLOUvKHVXlGEGQc+1HAcBt8ezSZTKpebFNGSrxlpNcNrg0dNFgTtRKLJv2ZtTM+pSunn9D48V6YDHXFaGIwiPRGdRKb3RGcn6jo9l9GDiF1NomnArE+wvd94njUtkghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ43Z7y/dO9WeR1Ijn6mm3VnrVyLIz0mXYHvufCMB6w=;
 b=S/ZUiT4QcJeFbLDLZ+c4LhOu2Gdw5b95BbqHNG14BzBazXP9Fqx5keFwuoZYb+bjAfnomagyjfk+jgFDN2V9DXEanQWH2HussmHcE6KWhYGKhvk3ufmg4SAh0KW+hOKSMJAzvju7x6Ae6VJZUQP1tlYyTEZbmlPlUagcHEIi5wok0amHnfymq0eRvverggIF6jYemYkVYvUO4dYTrZk92wtRAQo+vTnAhmc3yWAn/Fx/l0Cp6meocXcS9zrMP4cvoW/GA6i4h/HNzOZrALreVJhssYXw1jjs7vnZO1YGBIbAI67lZ7b46S7RpR5YGdCkfD4AY9LM3w+3p72rPJ79GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ43Z7y/dO9WeR1Ijn6mm3VnrVyLIz0mXYHvufCMB6w=;
 b=ZlwDtVQfGQZLmraT6MyL5VVmmmPuve1ruOXKmG5IWCbuKmTE8nlOp5Ls+Gc9ukvPvKd6M5mpNOI0RgvJExZTo1p2R2rQK33n/kU2hqsP/tDnBi5xxNiTkWfnV2xJ+Z8OoUKB3Vmxs2K9eZWYYcwSqLCDtt0my6qAuMtmayw905GvDJixATXD6YQvl4a871sywAIeYIVWIROCG6dSONPdQeRtpGBBSgvmSSFPguU5O5Ij+/WTHHrTtExBUmMHWcNheXA/PD+e8iyUdd2wqohjXhz7yf5Ej2O4ege/vpojkXH5BXQ8Z8rnL9X7/J/S/NXtcUTh5tFiEdBL4ykrzR5oTA==
Received: from MW4PR04CA0390.namprd04.prod.outlook.com (2603:10b6:303:81::35)
 by IA0PR12MB8256.namprd12.prod.outlook.com (2603:10b6:208:407::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 15 Jan
 2023 13:35:06 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::5c) by MW4PR04CA0390.outlook.office365.com
 (2603:10b6:303:81::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 13:35:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 13:35:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:02 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:01 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 15 Jan
 2023 05:35:00 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v4 rdma-next 1/6] RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
Date:   Sun, 15 Jan 2023 15:34:49 +0200
Message-ID: <20230115133454.29000-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115133454.29000-1-michaelgur@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|IA0PR12MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5fc887-307b-49dc-d45c-08daf6fd5023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/DB9yZPC8M+QlZPN8BNIGVfmBWUklYGCiQFMsiieeS7PK3tR7nhB3YqdxmdLhacy76NZz0Vh6qbzN4W3zOw3rqBkCNnaVE3bFs/K0ApcWjZ4t8N8M1l2Ew2t9zffTIkHOZ/ocdQanomG53fVJVEhVt43OfBy69GY1hFB4QuXmfmD7jlvXlmldnGtWCDTKT8zQvFJej9K4BQRlchyFWqbgYKPWDkYNGy/6ZkUWlyH6Hkr/PYu3LucuYnUyOq9wMkkonDSCpY4ffy7rue+tdt2vvhsRqwHtVOxZxxi9+jm6wkZbBV7Hwh8VgDOzbSmzfgliw8LfB0q8R1qbbmBDl/MAMVu+FMnkNLie+MNiEH+0WcDdaDr9LI/m+3R7IQfDUL50MpUfnH9Nez+WLSVGhvCP0Sn6TIwDMd1ET1x8k9FPxmUrlLSNoc1mt54kiJw/Mz6p7GhHqbeGLHQy8xdqTKbePkpjMLGGzgUDA2uUsT0/Tr1I+Nzb2djFbreG0fj4xykR5kAB5iTjEnB/pcNYyLhGGJrf+VjDdKhKpJvAzcTIPFJczcyJ9bZDsZzregJ7HX99g7+lJiw+obzAm1UWcc3efBTTkRaGC0y25olZWb3UVRh0XxWRN3GIDzZh89zK+FQtrxU2RoukAaLaDDpjdyd8vLLfo7flFIjtzF1puCJi5O5zoH7UnY6hGRIF4dKtyDt+eofzPpyF2jpk1b7Jb/ce28FnCxpCJoqxHJ9PiTmw8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(8936002)(82740400003)(26005)(2906002)(41300700001)(426003)(5660300002)(4326008)(8676002)(70586007)(316002)(70206006)(356005)(110136005)(7636003)(54906003)(7696005)(2616005)(47076005)(40480700001)(336012)(40460700003)(86362001)(186003)(478600001)(83380400001)(107886003)(36756003)(1076003)(36860700001)(6666004)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 13:35:05.6468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5fc887-307b-49dc-d45c-08daf6fd5023
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8256
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

mkc.log_page_size can be changed using UMR. Therefore, don't treat it as
a cache entry property.
Removing it from struct mlx5_cache_ent.
All cache mkeys will be created with default PAGE_SHIFT, and updated
with the needed page_shift using UMR when passing them to a user.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 1 -
 drivers/infiniband/hw/mlx5/mr.c      | 3 +--
 drivers/infiniband/hw/mlx5/odp.c     | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 8b91babdd4c0..8d985f792367 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -739,7 +739,6 @@ struct mlx5_cache_ent {
 	char                    name[4];
 	u32                     order;
 	u32			access_mode;
-	u32			page;
 	unsigned int		ndescs;
 
 	u8 disabled:1;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 053fe946e45a..356c99d7ec9a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -297,7 +297,7 @@ static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
 
 	MLX5_SET(mkc, mkc, translations_octword_size,
 		 get_mkc_octo_size(ent->access_mode, ent->ndescs));
-	MLX5_SET(mkc, mkc, log_page_size, ent->page);
+	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
 }
 
 /* Asynchronously schedule new MRs to be populated in the cache. */
@@ -765,7 +765,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 		if (ent->order > mkey_cache_max_order(dev))
 			continue;
 
-		ent->page = PAGE_SHIFT;
 		ent->ndescs = 1 << ent->order;
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
 		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e6e021af6aa9..8a78580a2a72 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1594,14 +1594,12 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
 
 	switch (ent->order - 2) {
 	case MLX5_IMR_MTT_CACHE_ENTRY:
-		ent->page = PAGE_SHIFT;
 		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
 		ent->limit = 0;
 		break;
 
 	case MLX5_IMR_KSM_CACHE_ENTRY:
-		ent->page = MLX5_KSM_PAGE_SHIFT;
 		ent->ndescs = mlx5_imr_ksm_entries;
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
 		ent->limit = 0;
-- 
2.17.2

