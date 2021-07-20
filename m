Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6524D3CF5F0
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jul 2021 10:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbhGTHg7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jul 2021 03:36:59 -0400
Received: from mail-mw2nam12on2073.outbound.protection.outlook.com ([40.107.244.73]:31969
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234021AbhGTHg5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Jul 2021 03:36:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNMYQ0Z7zCKXzRSekq9YyW5pmeV7wDK344cM3Wu5lP6SNnRlXtELXNy5wqBKseAT1qTegup/FXHipradHoxNPWnFnExMOgVjWHsvvBe2bZ1Hd1QIAcuB5FWr99PYKZsY+tknEkXdOvLI4xSi1iQRweoWP+7FEVO7OCGJ74tPuvM4p4YbRXQxgTJNL7diA9i+f7eOfce4m+NceP2nYNWd+0dIh16TR847rD3PpC5DEo9t4GRjTmEMhIXtyAzq9IgU7ACMCrm4tsGYZTcE9nbwXt6+ztUSPA3Y2FMunzLCzD39zYVnk0/CfOTCz+1acnN7foUbqSUtnhtgLergy4FUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYlL6uBq7c5XlH6RDYHEFmBiUsKKVJUvjlE6AFGAIHI=;
 b=GO/hCIFQrIbqvHxg6vJ9cXnYqgGft22SOimKcSYlHpDEMKInvzcSiqa5DA0rpITVr2KAceuNsLbWq2otOYfS2clff0nPTVKTTHWToDapPq1FJ116AehZiOmZEoUcNULfgh5NUNunESieNfyHRaAKUy7RA02gLFNIM3OZh9cfJdVGJYGilhiHrodojhe4aWjWNsKkR3sEt4hBP4VENoOHMiDbK3VFonB1TsXF0sAkHRfqoBSNLNCwrm+4Pn4czkFHrOnEYSJ76dgm2vY+P61LHo2rd4EHrG54Xz6bonWuFWJD9j9990su4SHkctU5nXnWWa8VY9HI5w6ITwgFxeE6lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYlL6uBq7c5XlH6RDYHEFmBiUsKKVJUvjlE6AFGAIHI=;
 b=djMjy5xw4MaKd0xJAEKTPawX+giMQw3Mia0NMQuMg4g3FMHXjk+f/nYm1CTlMc/I3bD0POoBW9skNqW6pwQP/M3qnbKsjNV8irz8mWWtKllVHylQKfmoixIGw/EqBv/jJ+CfAW3w4nK25yR0sdh8fL4IsFB14JXiCEPGhWBt0SLxnr9vUktFdotGmv0wbjKwsgdoD4LDIsNtvqsR+YV+FQzndiDMNjIJKgwOUiHRrrXq8V13vO2b5tDh4FXPhxjHTVdU7ppeMU82xpzh8aHINt9WUKdpojCF/iSVAaBoRrDVCOb/Xwaf5y/91ieE/ricjJp6MpFulI4wICplCyPcOA==
Received: from BN9PR03CA0010.namprd03.prod.outlook.com (2603:10b6:408:fa::15)
 by BY5PR12MB3812.namprd12.prod.outlook.com (2603:10b6:a03:1a7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Tue, 20 Jul
 2021 08:17:34 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::74) by BN9PR03CA0010.outlook.office365.com
 (2603:10b6:408:fa::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Tue, 20 Jul 2021 08:17:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Tue, 20 Jul 2021 08:17:34 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Jul
 2021 08:17:33 +0000
Received: from vdi.nvidia.com (172.20.187.5) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 01:17:31 -0700
From:   Yishai Hadas <yishaih@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <jgg@nvidia.com>, <yishaih@nvidia.com>, <maorg@nvidia.com>,
        <markzhang@nvidia.com>, <edwards@nvidia.com>
Subject: [PATCH rdma-core 03/27] mlx5: Enable debug functionality for vfio
Date:   Tue, 20 Jul 2021 11:16:23 +0300
Message-ID: <20210720081647.1980-4-yishaih@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210720081647.1980-1-yishaih@nvidia.com>
References: <20210720081647.1980-1-yishaih@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c739bf-dd4f-46a2-f487-08d94b56d413
X-MS-TrafficTypeDiagnostic: BY5PR12MB3812:
X-Microsoft-Antispam-PRVS: <BY5PR12MB38127EC233B99F76D7CF81EDC3E29@BY5PR12MB3812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:233;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wj3flIpvxQJ2rrusr00WxHi7PVwjUS7vOGp3ELN4CH64JKTkLC3i35rH1SZ+ZtiJzZV4kVHhIMYCBI8W9q2GDGZgYHTqvQg7QijAgWd+8qB/6zCyYKXsXXbWmGK9SP0SSxBMXJ7/ddl3hpcS2E7FUn4/0oYg3CmWOh6vFWK7gPQhbwXc71pwhe/gbw/mw7gMElaN3CjcTYNxxwq6bs4t7iS4XLLql9tiRRGUXnad5UY4FGSfzUNzAyCOunaKOpG+6SkbKvAbzT7kOyoEiZWtPu/rvfjYYqSfBBT/43Mxa1hvphTEOTCJPlqFXuZr2aXUAUIKHcHV1CHvsuIvzLbfpePrapEDsSGBnCqd+I13JYzB1qJBNdkjSMGLne9xRLkZmCukeWgi2/YG/s+OHlVLSc+JSZER49iv5shuyOEJKYOLfYMYD7ZdMdKXMCeoHuzLOvFvBw6NZE9wYBhyLXW2YctgokzhndKIvilZVIWYmRm9Gf36W7uIgJsaVaKFmY4plXpj6SR+wjNOTjRRvs3VxrhIR3b7rWDRB2TsIe6G9Se5NamXPx3/T4W6RqIupFWvjyLo/q/V1Zz1nYRlOfHcEviAOXxIcUMoN8e662HECmbqST8CRu1o+YAY5n0wAYLsnIf2H3fqGh9LLlvxXbxPFPM5OKDmTcWETLOUQW7FHppLSSSrZHrl85lDdQmNjNjTCrvysxHp5CNE6jcs+IgaBg==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(46966006)(36840700001)(8676002)(6666004)(4326008)(83380400001)(36756003)(7636003)(107886003)(356005)(70586007)(70206006)(8936002)(5660300002)(82740400003)(82310400003)(426003)(336012)(478600001)(2906002)(47076005)(6916009)(2616005)(7696005)(186003)(54906003)(36906005)(316002)(36860700001)(86362001)(1076003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 08:17:34.5285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c739bf-dd4f-46a2-f487-08d94b56d413
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3812
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Usage will be in next patches.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
---
 providers/mlx5/mlx5.c | 28 ++++++++++++++--------------
 providers/mlx5/mlx5.h |  4 ++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/providers/mlx5/mlx5.c b/providers/mlx5/mlx5.c
index 46d7748..1abaa8c 100644
--- a/providers/mlx5/mlx5.c
+++ b/providers/mlx5/mlx5.c
@@ -583,7 +583,7 @@ static int get_total_uuars(int page_size)
 	return size;
 }
 
-static void open_debug_file(struct mlx5_context *ctx)
+void mlx5_open_debug_file(FILE **dbg_fp)
 {
 	char *env;
 	FILE *default_dbg_fp = NULL;
@@ -594,25 +594,25 @@ static void open_debug_file(struct mlx5_context *ctx)
 
 	env = getenv("MLX5_DEBUG_FILE");
 	if (!env) {
-		ctx->dbg_fp = default_dbg_fp;
+		*dbg_fp = default_dbg_fp;
 		return;
 	}
 
-	ctx->dbg_fp = fopen(env, "aw+");
-	if (!ctx->dbg_fp) {
-		ctx->dbg_fp = default_dbg_fp;
-		mlx5_err(ctx->dbg_fp, "Failed opening debug file %s\n", env);
+	*dbg_fp = fopen(env, "aw+");
+	if (!*dbg_fp) {
+		*dbg_fp = default_dbg_fp;
+		mlx5_err(*dbg_fp, "Failed opening debug file %s\n", env);
 		return;
 	}
 }
 
-static void close_debug_file(struct mlx5_context *ctx)
+void mlx5_close_debug_file(FILE *dbg_fp)
 {
-	if (ctx->dbg_fp && ctx->dbg_fp != stderr)
-		fclose(ctx->dbg_fp);
+	if (dbg_fp && dbg_fp != stderr)
+		fclose(dbg_fp);
 }
 
-static void set_debug_mask(void)
+void mlx5_set_debug_mask(void)
 {
 	char *env;
 
@@ -2036,7 +2036,7 @@ static int get_uar_info(struct mlx5_device *mdev,
 
 static void mlx5_uninit_context(struct mlx5_context *context)
 {
-	close_debug_file(context);
+	mlx5_close_debug_file(context->dbg_fp);
 
 	verbs_uninit_context(&context->ibv_ctx);
 	free(context);
@@ -2056,8 +2056,8 @@ static struct mlx5_context *mlx5_init_context(struct ibv_device *ibdev,
 	if (!context)
 		return NULL;
 
-	open_debug_file(context);
-	set_debug_mask();
+	mlx5_open_debug_file(&context->dbg_fp);
+	mlx5_set_debug_mask();
 	set_freeze_on_error();
 	if (gethostname(context->hostname, sizeof(context->hostname)))
 		strcpy(context->hostname, "host_unknown");
@@ -2377,7 +2377,7 @@ static void mlx5_free_context(struct ibv_context *ibctx)
 		       page_size);
 	if (context->clock_info_page)
 		munmap((void *)context->clock_info_page, page_size);
-	close_debug_file(context);
+	mlx5_close_debug_file(context->dbg_fp);
 	clean_dyn_uars(ibctx);
 	reserved_qpn_blks_free(context);
 
diff --git a/providers/mlx5/mlx5.h b/providers/mlx5/mlx5.h
index 3862007..7436bc8 100644
--- a/providers/mlx5/mlx5.h
+++ b/providers/mlx5/mlx5.h
@@ -992,6 +992,10 @@ static inline struct mlx5_flow *to_mflow(struct ibv_flow *flow_id)
 
 bool is_mlx5_dev(struct ibv_device *device);
 
+void mlx5_open_debug_file(FILE **dbg_fp);
+void mlx5_close_debug_file(FILE *dbg_fp);
+void mlx5_set_debug_mask(void);
+
 int mlx5_alloc_buf(struct mlx5_buf *buf, size_t size, int page_size);
 void mlx5_free_buf(struct mlx5_buf *buf);
 int mlx5_alloc_buf_contig(struct mlx5_context *mctx, struct mlx5_buf *buf,
-- 
1.8.3.1

