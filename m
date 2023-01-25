Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5D867BFEC
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 23:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236300AbjAYW2m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 17:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbjAYW2i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 17:28:38 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D2760C91
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 14:28:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dII+70nNAMVHONbsUDNoBvaE+UWEvJUNjkNE3ad6fOqTR0rdvyec+HXFEYXo5cXIBOKoL6oknsBabq1LZ/dS8rEj4h5GQqUqb7ITvbJx7ELj6cdNn+su0V/+YMNmBCeYIFDYZYgsu4hazAMrfiQ3ZorZeAphzVRgbu6DQcIySggATh9drEVMM5z1ZzcgmVcn79qRdqZP81CRoeJReqzAt46NGm0WAXeOwpkc5J/FSWu28JsMKc7n+rZ2MFfnhSTzoSlu0JlrLX1puXIpaIi14jPBKjCCKuNMcdPmA6B5Hoquu0SnRqow/gW9s1fh8HTXayQmh96xaTReJ9Js8tu3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJ43Z7y/dO9WeR1Ijn6mm3VnrVyLIz0mXYHvufCMB6w=;
 b=XMyb4zDtviEheYulxcip74FWJfl5mbXp9cSPml+aD0udjxEs+BBd1QX7uG+ShX1elspbH+j8DJDCQvHHe6ISa9la4SsaBTkFFIGBTFABEw2NoN50liEyLh0CvJEEZ+4mrWmcAESRXtI9fSUpnbyzQUErtMly6HTbuvrTa0z21t89SlltgBCLyijD4INHq07YhjsSSN+xTv222qB+hVNlxSSHTFE+6KICSf4sDUWE/CpvV9V1CbN2Bhh90Ms14zvef2e/9F/ac3x8VNf2B5ZgN7U1pyZB11ZSz+1hwdC9hIkd/BrYYEsUvRz70XufGIsRXMZIYMP0LyMO0GqY2rKqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ43Z7y/dO9WeR1Ijn6mm3VnrVyLIz0mXYHvufCMB6w=;
 b=YWlu5KwPz3tSoQkOdua2ulkQwONUQimxnZQy9q+fkI4LttB3G01nJCnUjT04g9NBNTo9Qf9E0RmGtdFAH2/tvpucQoC+Bu2h5NTQYFZITy/hnUat6YWYRxEM08/BB3QQy313w+VwuWId6ruexBys2byNr9MmhsHAchTeB36HsOjTC+wQunEy6QofTRwMHRDm+k1XiX2O2/KzgA6Z2Yh5JrxRkrWY0tlESG2Uf8OCHbZhASlQGrtusDiIx9LVzIZr62b6cMgVFi0HGxXsa4mYknlHIoghLMATtOl+yKBrTDeUliXnvsyLDl3+OIp4brIX3exQ1iY9A4BUSiDiFtbgLg==
Received: from MW4P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::32)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Wed, 25 Jan
 2023 22:28:35 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::38) by MW4P221CA0027.outlook.office365.com
 (2603:10b6:303:8b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21 via Frontend
 Transport; Wed, 25 Jan 2023 22:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 22:28:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 14:28:26 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 14:28:25 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 14:28:24 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v5 rdma-next 1/6] RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
Date:   Thu, 26 Jan 2023 00:28:02 +0200
Message-ID: <20230125222807.6921-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230125222807.6921-1-michaelgur@nvidia.com>
References: <20230125222807.6921-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT011:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf0e953-d3d5-4280-18f5-08daff237f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E11vIdUrfzDT10GhgQWuVdo48HLOa5uW8hXLiRJzdhr27DF5bTyE6Dpvth4/GoQR3m1Lb9p5ZwVjTKrloco+Qa6xCw3dXzuPezzRr7R2AyhYy5pOLRuw/FSumwo2JsIgwmEJZwNXKK2nvcbpxOB84YFebshWCEdSQaE3UnDFZD+1FI8nNFW4fwflB9LYC/uzwFbuuXrHA8VtLsqE2QFWY2+/K48KzDZuN3mWNJiDkyrfB2NhHOGggEQj0BzkBt071MKDeJig7YzFa4RIXo89nL8hGH/7rQRZeyFSTQtBdAxnyEIsHs8Uz+mWiRII+XIBLf1XjWhAqmylZN4/R5RZonr3LBqCqpTujt+fTKvdlcDA96CU/LWNCPV0zNTof07HrFqWIAOfDTRA/2rLPT/0zRuORqGpi8THQHPOsvDIKvM5rzahjIbnkk1XioYxjFdBhe7E76qZzea7bXPP45NB35raCYUQ3DtYoVJRqpuNT26EUChROXtdy70hkyGMHFuKcVMwSfH65fSRaN+rSmlmqFODvea4jQjs0OjA97474Wj2xMmIpzonwGOtn3JGafBrV0SVm50EZgS6K+JirZspDduvjcKP1UuKX2uhNGjS70q4yFkNTLyA3YzdjbataZ7o4eThjN1/k/mmrx8darpxAB5FXQ2q6O9iA5Prp71u4Znkx8hMWrgMrX6a53OnkGlNukFgOnxoOlN35Al52ed3HxcWi31K8/K2p16M6JJEnpM=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(1076003)(316002)(40460700003)(336012)(86362001)(36756003)(40480700001)(54906003)(83380400001)(70586007)(70206006)(7636003)(82740400003)(8936002)(426003)(36860700001)(41300700001)(5660300002)(110136005)(2906002)(47076005)(107886003)(4326008)(26005)(478600001)(356005)(8676002)(6666004)(7696005)(2616005)(186003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:28:35.4235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf0e953-d3d5-4280-18f5-08daff237f8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

