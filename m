Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEAA75B27F3
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Sep 2022 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIHUzD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 8 Sep 2022 16:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIHUys (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 8 Sep 2022 16:54:48 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BBD2AE31
        for <linux-rdma@vger.kernel.org>; Thu,  8 Sep 2022 13:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eP0Aj/IjSrZcJtZNtTzbwzLvl/wLS77RdSJ3W4vFIdGmdOrAeP5w2+dQjIZr8LtSZ2Vykk35bWod7P/5ZqTUrdZP45BfB25JsEEWxv4JxeA3HssZnxqfvMgdBreHfJtnxuB3DSZ50Glsc2OBfukavsNmmg2yQ9PdDTxHAQUbefJY7eMrU8QmPIyGv3IvxIVGZl1hjOtzXdAXhTqkBYe4qkg+VdQ1gzbAmMn+p19MeAtCM48XfV6UpXrFEao33lDvpIy5cP2x9SOTtFNuh7Y1bO6Nvm27kN0zDg5b242ETfiHY2jl8uUyDnsSMW32mG+fPDjL4aQ6+FHbSnGk4jZq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhMaAAD7rYszdI14wqYtl66nULy2WvdHxs6BcbK+RC0=;
 b=I05+9hUNaf6dLc9WaRY8iOomfXjlJdCaB+Fz2avp+T8UFdTrEPsZW7//5Vd7aR+Bu20nxovO+axwm4UDJuhW63jMj9hDKN++q1dECsdXi9IgFrCjOnurGF3q2wEyKzniUg5va6xJ0XpGW/guF1C2EYPWqfbSw0iT+FSe3xtg6BGg3k2k2gVXoEHbj6ETrrh1WdXiS/Ss//ix/+XY4caFT7xgl5d0r5m5FKk8Te4izIxMqBQoMHLDdIEgG/g/4nPrSNMvG9DRr8kTRZhcg7yceWURNGv00fvEFVqJVbyFUQ8bKpK50mh0Sn5g+nLLyJxXBpnDZrzv3mJV0V2+TdFLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhMaAAD7rYszdI14wqYtl66nULy2WvdHxs6BcbK+RC0=;
 b=fous6R00vgs1TXgGWZ5dKcLgKVPQ1ivCWLt9bdlbqBw88rthnFExQMc8a/7Q7WFrDKLAeIBTXeDQRj3EcvypdeJhqHfQz0nD5ZdCG5l0yrUSc0lg1+fwd0tiqyLLtfmtX5tsmaP7CNDFLR3gOBy7MtPv6C9FKR/9193lthbct2ruUHbR/ZF/QFUuO8/Zb84LfKtgrwgPrwAHgnH/dH8TRKDPTIOIoo7WIfPaupWygsrnYW+ruJrE2VcO4RG7t2tmBucd3GdjfWDvncwlBRjYwtz1sGKWv7KacQKRxaMJJnR7tPJDk1ogwbLg4rY6T5O9auuIBCwndJ2FFUZPCk73OQ==
Received: from CY5PR17CA0020.namprd17.prod.outlook.com (2603:10b6:930:17::32)
 by BL1PR12MB5109.namprd12.prod.outlook.com (2603:10b6:208:309::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 20:54:45 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:17:cafe::f3) by CY5PR17CA0020.outlook.office365.com
 (2603:10b6:930:17::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 20:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.10 via Frontend Transport; Thu, 8 Sep 2022 20:54:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Thu, 8 Sep
 2022 20:54:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 8 Sep 2022
 13:54:44 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.29 via Frontend Transport; Thu, 8 Sep
 2022 13:54:41 -0700
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>
CC:     <maorg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <saeedm@nvidia.com>, Aharon Landau <aharonl@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 1/8] RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
Date:   Thu, 8 Sep 2022 23:54:14 +0300
Message-ID: <20220908205421.210048-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220908205421.210048-1-michaelgur@nvidia.com>
References: <20220908205421.210048-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|BL1PR12MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: d02bfcae-e15d-4dbf-93da-08da91dc5c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TU0WH1MoehUOBOOI1LJff+KAtLipGhIo/jvI8h7f2qGlFjHa1h2tGvVk8mAxN+fxnJwwmzgOLz3hwcbm+tc2/8p4/5N+GXU7EEolsTctZUu8WHezYp4MkFsStDQRPqaet4SrsDsbiYQ5zCO5ONWK1F50hlcCGWoCWSRTlxiHG96cnNB84QwecJWyERC8Lt7AUqYJKtC5uZKggfJrzwBishKsox4vTRVZx22qnej/6IT+LdKYXtE66aKP/FaZaZGh9AXC2uJw6Sm2lDZmsm04Seqa8zdTnyqULb9PSAwvbZ8rGPB7u2/T+vmuGdsQFZlpTmWBkXT9V1CEQ+tIFnvR8GDIRVgtPxBtMyBOYECZPYlEXOkmGnN0yybjLoH3gsnebGatdPwD7VwG1/QonfS9EWTbS8NnayA8jWCreOvknnb+63K5KuokjIjjOdrTgTPekUL5mVGWQGcltxUUwswqgvUWQ6Mv8PTAKlnaDqd46TQI0pH51wIGHyP2AJOvjCm8Hisd8LQ7b+IqACJk/40S9IYLQuUuT+7QIGSp3RY4W5WVU8/NUOR/HmKSNvMWWAm0kvHOKq/WppkDdYxUWnh+dYG2GZUImsdkguXS+nvZXXqezDW8VHmxaDWIYmR7mu32/v1ZVzlWjhxFRC6kOZm/qnkdl6I8SOTe6wVvbJAqKu6q8rwhyHkbhD3P3jtxIIB6tFmm+oQSyQU1iCfG+I7CtcnSKc1Te7WJrE4o9ctqWx/kkBap35/vhJX3WQ9bZWPZ31mH2A/n26Dbn+ugJDbXSABiuk6uls3ib7ArZV9rtu4=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(46966006)(36840700001)(40470700004)(26005)(8676002)(70586007)(7696005)(4326008)(478600001)(70206006)(83380400001)(5660300002)(336012)(186003)(40460700003)(2906002)(6666004)(107886003)(1076003)(426003)(47076005)(2616005)(8936002)(86362001)(40480700001)(41300700001)(36756003)(82310400005)(81166007)(82740400003)(316002)(54906003)(6636002)(36860700001)(110136005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 20:54:45.2098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02bfcae-e15d-4dbf-93da-08da91dc5c49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Page size can be changed using UMR. Therefore, don't treat it as a cache
entry property.
Removing it from struct mlx5_cache_ent.
All cache mkeys will be created with default PAGE_SHIFT, and updated
with the needed page_shift using UMR when passing them to a user.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 1 -
 drivers/infiniband/hw/mlx5/mr.c      | 3 +--
 drivers/infiniband/hw/mlx5/odp.c     | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2e2ad3918385..d260132d8f45 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -734,7 +734,6 @@ struct mlx5_cache_ent {
 	char                    name[4];
 	u32                     order;
 	u32			access_mode;
-	u32			page;
 	unsigned int		ndescs;
 
 	u8 disabled:1;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index bfec9bc3cdd8..d8bdba0056a1 100644
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
index bc97958818bb..e9a29adef7dc 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1595,14 +1595,12 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
 
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

