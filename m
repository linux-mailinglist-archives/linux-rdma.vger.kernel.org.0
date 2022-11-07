Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA88761F8AF
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiKGQPI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiKGQPH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:07 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A579D2737
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6dy78Zh5BE0z/hmTXt/96dJ9aE2yLIVdN2zpm4z6U6/g+6uSH0YrDcZ9xjjuDUJnUe7uquoyLFgr0lboS0kUVn04Y/XNhmh4Z9zfJdyA5tSn6vWvhx4JguuQg3wsy1hQ0fsqYN0wffCDqioqjw0clcv8y0fdJyeBGrQSes1Jyt0A9wrg35W1u2XEWtEOwGulWdvGGevAveWw7AqUxKFGT4UzedoYBnxbUDM+ZmBXJDe0Hv7A9PW4iGBwLUGdBp86Ht54Y4gHqGPMy4dIAPR20zDYsMpj4UNE7MMQAuMfmnWZAkxjmE2szYP3N7isbXOz7ZtLwSiqlsY39U06h5L0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZwWeRDh+jRV/9MGXPBY0mEL+YbAyqUIYblFR78ssNk=;
 b=QbDBJpQZJny8edtjiSmrSC5Sn7R9rILU50pHLGOYpjfkNNUp+gZXUNPwJKchG17ReF8Z30ZMhKc4zzXwf4UmwAFFxh/h7eJcgR51ONFC1qn1OO7TdGrFcnGQB9E9+s0I65czJWSKdDDpohdr184Mk4PBYCnybOwwnSSvZp5J1LhGzYmfmTzS+sRxraxqTRsfc4mw0KWe1nffRvMpbybiIVO5osuB2RiHxiOMDIln5F7OArjL7S8wwjUdRk31nJOHJDd2lzMmRXQTpE87lQDemnyu4QZ8le9IeWWwAr78e0pkt2kO+wR5rQisJ1CCn1gREvHU6xTNu2lEOvp0wI6PkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZwWeRDh+jRV/9MGXPBY0mEL+YbAyqUIYblFR78ssNk=;
 b=N4aGqKGcbrXyr1u87FmiMKV/Pl888vLEiikTM/1kr2DGJ90H77MxP4eLBPsPU6Eau93xk19bc619fPT7EXIqhMHLWwOhasj7C71baQFiBbwue2doX2BV/onD3hwWUTRaguPtLBCKh8C4U5d9B5siR9y7V4OMwvOUI8JDZbPGIW2VQDbO2MTyA82So0hOLlW71maCWoZXgJmAVk5NEfnDb8m/lyS6oYlgkINva1W9Wva9PvB1OOQn5asE2jboDK5HsOuIA72BPhS8nWrSPP0XOMQFh4v2ZNV52qCEILAuWnDX8b1//snzbf5B6+0OmDjUoF6H0SmqG/Fd+YE0hYdB4g==
Received: from DM6PR06CA0015.namprd06.prod.outlook.com (2603:10b6:5:120::28)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 16:15:04 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::a0) by DM6PR06CA0015.outlook.office365.com
 (2603:10b6:5:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:14:59 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:14:59 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:14:57 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 3/8] RDMA/mlx5: Remove explicit ODP cache entry
Date:   Mon, 7 Nov 2022 18:14:44 +0200
Message-ID: <20221107161449.5611-4-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT018:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: f74bd1a0-a7ac-4e03-575f-08dac0db3a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5iPFdWaQBrzWbEYH/pG5vA3bSl+YJAshP7L4Fd5COO70otrhEIljD329BxbvvtM+EpBdEHEPjqxw+VPdiiTEJn9dSrWbVjUeKYc7R8DXfGcPUiHWVtLjsl1WQF87OZYNbxBZzxOER5/U8tGAp9+7X5/rIDoikmBEKNFDhmncFpm1fnwhRUupALIF1i7kFFRZjW1p1azAWtSk/vmHWT6sgj/ZFmhQt+LJ8gvaMmv+ertOV3wc7qSuM4HPzLyn7T06UGNfvGbXs+0829BL0sHIxp2ogPcTuleW0pR8WgMx0HA1b9DtwbYDFdUhqLTOh+3yHDSTvXMrfdaoNP+SxK0PMEMOZxxDmJ8090r9uFE5DSwlT2vOlKzXpBGs1iHIie/w7SkGh1lzAsOVjzuLgu/0Kw0x17iapo1X8OaToTHDQO2Pd7uc/k01sGqfZJvbPCCLkC6G3xwjDDP4XNt9cNRTlqA/IQ+eRuaDiwQ727Ww97wA397cy2mww4hRkOTorqABoLpiLc8zytXKeMNkIsKtzR/jkhH1BxhL6cQ7apP7rG++3hEl113PKRAQtmBUWTIl/YA8VUpFVNYldo4FD5dBCAcOPLjJmUbuUeMaNRpdMsaU25kinNfr1tQp4NZSF0XUaxNy5n4FREMOXJn4gaUmnuGuWoNv10R4PbtP3oHYj5IuCqQGLEJ5sNiRQJswsHQBfp8VP3DKimviwCksqJZBZ++/WBcZ9VB0OK0otDZ/CZXVk5arL2hhlYbG68QpCppIHqafwmeITU1jG4OvaUUuTeV0Bsdh7MbTawGglpQzVP8=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(5660300002)(2906002)(36756003)(6666004)(7696005)(107886003)(82740400003)(70206006)(70586007)(8676002)(4326008)(36860700001)(316002)(54906003)(110136005)(7636003)(86362001)(356005)(83380400001)(41300700001)(40480700001)(336012)(26005)(40460700003)(8936002)(426003)(47076005)(1076003)(186003)(2616005)(478600001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:03.5621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74bd1a0-a7ac-4e03-575f-08dac0db3a6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
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

Explicit ODP mkey doesn't have unique properties. There is no need to
devote to it a special entry. Removing it.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 16 ++--------------
 include/linux/mlx5/driver.h      |  1 -
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f7c9eeaa8e79..137143da5959 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1591,20 +1591,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
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
index a12929bc31b2..bc13143f1a87 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -736,7 +736,6 @@ enum {
 
 enum {
 	MKEY_CACHE_LAST_STD_ENTRY = 20,
-	MLX5_IMR_MTT_CACHE_ENTRY,
 	MLX5_IMR_KSM_CACHE_ENTRY,
 	MAX_MKEY_CACHE_ENTRIES
 };
-- 
2.17.2

