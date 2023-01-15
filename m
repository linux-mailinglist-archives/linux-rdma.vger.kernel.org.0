Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B11966B117
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 13:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjAOM6i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 07:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjAOM6h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 07:58:37 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10B10AB5
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 04:58:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maGCwK7wZqweYL4tvtAPpWW4e+ErAqDBpMSqLSyQHOGDYjuzNf5u84+VM93PcB/F6BgYgi9p1MMNDCm+7cCEl+hXYu5Jp1IMb2ZJ5clNyk7QZLWIOoc2DvdCESE50YeiVMgVRmhEca7OzmwaZMtUFNjkEhFHLL3z+otvdJBEvGVm9QNq1wa5n/OwoKk3ZWD8yMq5yHkqUnMbqF2KFJw4Qx5e/KyZbdKqsieTGJKaPIfUhqdWaw4lOXG8Qo2AQe0OI01ymd0l+RLUTaSX0hv6MUblmsHXvkY8gOB/VRct/0/Ofe6vqc/DCyqOyxVdvJJIyeaGvuc0tbDL5HfdJyLnbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUesdKKbTncYfIQpUexXLBu26X8TYxq1AJPQI06kYlU=;
 b=g0ig8CSrSz+xhEfWZRisjSTyadX29OQkbIiIQ1ZMoQrHdtoPGp/sLh8C1KYM2fMG4R3mRGfUc6Z8fAcgDkAmz7/idXjlGRthI+yp8NuO94ryivth4yMqNT0JwwXpI/Bp7SeLviYE6M24W9SudckU03+aIVpiTbRTjXRfaBGjvrJuGVoAWTH4Jmov9hslGn3g7doZcHFuPY8CYjkYOUOAy6nDysq9aXNfIsQAuGIuPt+0x+XpSm9hOp/auLTMCnRSbq3VpMKmP5MIDFdeIPL9M2+UQ2Ov3nJ8OjSiOZxzGTXGoVDMRHyhhFDQ/WEmt+aNOj8CwZ+mMTXit/CrI8poRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUesdKKbTncYfIQpUexXLBu26X8TYxq1AJPQI06kYlU=;
 b=uIWlkVr2AYcb7duvan3FEQVWhNB+5r3Bq4TLFMMIHmCni8W5dx1FCW3MZag6TCum7nePJppbHFWEBjoCQbEmmCYm2ogs0D6BQA01fBDO+ppwwAtc3/J45ui70r/UBMOR3MoMQr58eaOyBQFwsgY/2LYYtEt/4Lj0Om4YGTbYGCpD0Oaliz5zStHhRzzripxPB1YyQbbKk/86KhED6DZEwELiWMRCqqK8gWT5wyamYXSfjUDpzA2krvif1HK86tKGShPgDx9FKTB/K9etrDjieKkG/tHaOPIlU+H4QEg7fxiiUP683gcSFFJp73q/rKZgFbTeqkh7ZQUy4pnOeB13ew==
Received: from BL1P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::7)
 by DS0PR12MB7748.namprd12.prod.outlook.com (2603:10b6:8:130::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Sun, 15 Jan
 2023 12:58:35 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::bc) by BL1P221CA0020.outlook.office365.com
 (2603:10b6:208:2c5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Sun, 15 Jan 2023 12:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.11 via Frontend Transport; Sun, 15 Jan 2023 12:58:35 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 04:58:29 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 04:58:29 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 04:58:27 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v3 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache entry
Date:   Sun, 15 Jan 2023 14:58:15 +0200
Message-ID: <20230115125819.15034-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115125819.15034-1-michaelgur@nvidia.com>
References: <20230115125819.15034-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|DS0PR12MB7748:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9a0ac4-d690-4b2a-b8cf-08daf6f83688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJ83bfJz58m+jPn6xfXdSvQMBoaGgu4W+lxCA3fPZRoyXKvQ04WGqh0qMDvEL9CM1QXxz1SREkpaGTKRGqyf8/KQs9ldM24H0FVI+hioMbsKUjvq631ZtNpOcq+1WhcTaQlNSq0COFmMr/TYU7HedJ5f+hInzFIommhoSQwo+Wm3CaBmNbTwwUd9sWf4r/4mkMp68xraI6QIqYEvDHJUiGYkYXOBp30CpY+0eEftB1/XgsFrIMAWyFTvZHfN/iwS54bwPQVf6xFp/U75oyrMpZQxMzflElbugbYjcoZ2PM4UxKFbOdLRCkxPd7qauxrRXUxxk+iYQvSV9B/xsZ0Kr2f76xPMXNYjyy+FIzqXjqEuq98Rc7RDFU9LfYCaplUjSI9jfQErQWa16tELQC/grJH8JRFaInqqh6oKlJHVRsbH3ofGXAMNOdjKKg9WcvxJTmrCgkCIoofpK+mFPLfb7KyNRMkRYen94kUq/aDNmOatVkcv9WKBlud8b38aON+1/1Il3Dd32HkQsIwoP73mn+qCm3KFO32UOwVHYdID+4Idtu27WDTavz53qTwh3LPfk0+HwcZZm9y8/rnKPYsR6GkJTCJRAYH2ugbnONMskP14ZrkEOmQ8vVxPd2acVk0rNKr/gGE4rdO3Ekm+d+kmfLgCWesJLGbhxBIn+gkb9U5Kw/dRrjmp8RJrbd9dkqB6J2tLVxdXXDF1vb0dRZbdWBhwmhhVc2kROPtxt1g0Sl0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(356005)(2906002)(7636003)(86362001)(5660300002)(8936002)(40460700003)(82310400005)(41300700001)(40480700001)(36860700001)(47076005)(426003)(83380400001)(82740400003)(54906003)(110136005)(478600001)(8676002)(316002)(7696005)(336012)(6666004)(2616005)(4326008)(107886003)(70586007)(1076003)(186003)(70206006)(26005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 12:58:35.1723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9a0ac4-d690-4b2a-b8cf-08daf6f83688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7748
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

Explicit ODP mkey doesn't have unique properties. It shares the same
properties as the order 18 cache entry. There is no need to devote a special
entry for that.

Issue: 2404431
Change-Id: Iedc9a56d1161b0ef24311151107c05a8c76c3518
Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 20 +++++---------------
 include/linux/mlx5/driver.h      |  1 -
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 8a78580a2a72..72044f8ec883 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -405,6 +405,7 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 						unsigned long idx)
 {
+	int order = order_base_2(MLX5_IMR_MTT_ENTRIES);
 	struct mlx5_ib_dev *dev = mr_to_mdev(imr);
 	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
@@ -417,7 +418,8 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[MLX5_IMR_MTT_CACHE_ENTRY],
+	BUILD_BUG_ON(order > MKEY_CACHE_LAST_STD_ENTRY);
+	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[order],
 				 imr->access_flags);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
@@ -1591,20 +1593,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
 {
 	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
 		return;
-
-	switch (ent->order - 2) {
-	case MLX5_IMR_MTT_CACHE_ENTRY:
-		ent->ndescs = MLX5_IMR_MTT_ENTRIES;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
-		ent->limit = 0;
-		break;
-
-	case MLX5_IMR_KSM_CACHE_ENTRY:
-		ent->ndescs = mlx5_imr_ksm_entries;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
-		ent->limit = 0;
-		break;
-	}
+	ent->ndescs = mlx5_imr_ksm_entries;
+	ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
 }
 
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index d476255c9a3f..f79c20d50eb4 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -734,7 +734,6 @@ enum {
 
 enum {
 	MKEY_CACHE_LAST_STD_ENTRY = 20,
-	MLX5_IMR_MTT_CACHE_ENTRY,
 	MLX5_IMR_KSM_CACHE_ENTRY,
 	MAX_MKEY_CACHE_ENTRIES
 };
-- 
2.17.2

