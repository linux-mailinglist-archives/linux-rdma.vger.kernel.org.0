Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C4961F8AE
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Nov 2022 17:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiKGQPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Nov 2022 11:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiKGQPD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Nov 2022 11:15:03 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B0A65E3
        for <linux-rdma@vger.kernel.org>; Mon,  7 Nov 2022 08:15:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsTYjGiYs7MsYU9EFBD/TOGuEOD3ZiVEGvCtpnl/6vQiGoyp8c59SMMqCzYAyxFKMGdGAf2LP7wEJHzTqNmRn5q2b1hUk5Q25oVpACyIqUEg0wtRMgEAOWz70W3/HkHc6GNBG9k3g75Ge8MFYmD6eaglNz4QK3sOqTOopMT/AfiJ44Oj4y/5UYGELjpmyBtloY87H7uBEwUHv51Yi+rekcA5EBY2T4JO+z7d2Iv+xOaL/uwqMvvetyB6KJO4nlGGebaxqVx/39aPnaSnWmtArBYyxQro4py+afzsxFnh5SzCgdju511QRCOFnB8aX5g1jnGDc640a4CV/UkPLRdPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvJW13wlajFFs0c8KichCn6x5YvOhm2H97SxGYFFQIU=;
 b=MgKvKlSC1P5cNSyXg3doY3yzRMp49VECqEv5iJIxsQ9T+MHVSwuAZbYA5YP5V68acU5otn3TFGYttYWEirdhtVVdWfl36TdQKTovgLA89okbMb2JNB6zaZ/l3t0owU+Vs057vq6vOEYGe3/Jl/Khrvk18OMPf4tWUVwNw5qGKkSP8LLbPp8/nHqFYRL845EBSRq9shBjuoeUiiOwRrsE27apsdQJIFBp8XgiQ0lo6DQln5gtQwWL2BsaiPpQMX26ADhu9G1rGup1bv9Me71ziQmRnXUd0XC2IsxwZaXfgF1L7EMBhZj0gXjN9YoQpH+zLa6Iuys8XqLS4caU2CGYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvJW13wlajFFs0c8KichCn6x5YvOhm2H97SxGYFFQIU=;
 b=XqAV9Znag325zqUZHrTD4IxQPFTcnFQFaXZAuf4/PK8Aez/DQ2DJRUsDl8CyyY0hpD48SBez4NT4GKStfn6YAsj+11Q72eWz7HdibUy+5PSbgagcnKF1Hn+OsP9/OhgdL3B86L4DflqGiVr7AVudTOYqBndGeISFL8W5k12oz1/ydRCMpcsOUy68w3IWsvPXg2tNDYqCnszFlE/QRXjX1Hiku1BGAcrbR2omc30Z9WtSRhtkVwAo7HpH6J9WxXY5ageJV7WNhGpkAsPILED2Iq6+g4ZVH4hiI2qxXBZVh5AfX9E11ajFKpiBe7FqdvTwxQYsxarp7OZ+dNRKHiyYLQ==
Received: from DM6PR08CA0019.namprd08.prod.outlook.com (2603:10b6:5:80::32) by
 SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 16:15:01 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::32) by DM6PR08CA0019.outlook.office365.com
 (2603:10b6:5:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Mon, 7 Nov 2022 16:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 16:15:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 7 Nov 2022
 08:14:55 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 7 Nov 2022 08:14:55 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 7 Nov 2022 08:14:54 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v1 rdma-next 1/8] RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
Date:   Mon, 7 Nov 2022 18:14:42 +0200
Message-ID: <20221107161449.5611-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20221107161449.5611-1-michaelgur@nvidia.com>
References: <20221107161449.5611-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: fa00a968-808b-4203-a9d3-08dac0db38ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXHkOJ5DJejoMX9vEguScHGwJ2hlk2Mb4jQzYGgoxB8P1cfpwLGmh9qxIHTiZUF1FqSsaNkusfQxGtmqRHu4HvEuUCcH+z9D80AgisekJ9vAzbZ09boDMLDZ4lirhpoC2TIRPZL0svSXa3LSG6skTWXTHTr9oFijVhrbIIjIAkW+GtISFO1Pzmzn+ImbeKp+f0BX2k+beC6HqNSGa11ZtA8B0Gcuqsx+TY/yAg2CDI9Akf4OKDQV6YiHVZMaf6OQ7+yYRw0obRbaUYVD4cwRO02oxHIPFS4UoPUO6CMsIT/VSyGdrY5RwLJ0uMbG6qRHUPPH9NHQasjnRIlGLgUp25U1G4ve6Mm4/B6P+b/ezQDfO1Zf8Lizuam8nCJNocvccMJSwF22/vkpsYf1dJlyulGARfxdiuQpb2GI3orM5QaTMDhDOBPHOA5xaBqxEdbDdk+uG6XpZ1ZEmGmutKIVLNyK1NXawOpMjLa0mNJuNFBpMQunTJ+wXPuDEV/+2cm7hnueb4xC9OqYBezdqDR8GWt5YUiOI6WhScbrI7DGqidARoSSNh86Vdzkdz7mMKd6BK64Pcg/fqC3V/jf5UC8QckrxhG2l2iY2cb9laHJQ8iuSa5vYo5SY+EKPf2phtdVp0V7RSuPQN4MJF4r9dIM+xoF9HoOLBhOGBQrDwok6v43SFA8YDGh2ZxEHb5w561ROoqv93vkEVJAq5MwJThQrkOK0oyLKsyefKpSOeCflKTFXLpt5PK0Tq5EuMK958S6JwfVgDBeeLtnuK1+6FljeEPg3y4/ivAjuvJyGr6mTZA=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(2616005)(47076005)(426003)(1076003)(186003)(336012)(107886003)(7696005)(6666004)(26005)(36860700001)(83380400001)(2906002)(40480700001)(40460700003)(8676002)(82310400005)(110136005)(478600001)(316002)(54906003)(41300700001)(5660300002)(8936002)(4326008)(70586007)(70206006)(36756003)(7636003)(356005)(82740400003)(86362001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 16:15:01.0410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa00a968-808b-4203-a9d3-08dac0db38ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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
index 4a7f7064bd0e..ac948bb3cfe1 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -735,7 +735,6 @@ struct mlx5_cache_ent {
 	char                    name[4];
 	u32                     order;
 	u32			access_mode;
-	u32			page;
 	unsigned int		ndescs;
 
 	u8 disabled:1;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 410cc5fd2523..29ad674a9bcd 100644
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

