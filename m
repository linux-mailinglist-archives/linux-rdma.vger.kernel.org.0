Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3AD6455E3
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLGI6r (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 03:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLGI6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 03:58:34 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F4BC06
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 00:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuqvvDi7R+emMztrP5bEBDTLvg23I+pvYoPKhcmdStoE4DqQGVFQhRhWGwr8SwQYWm4bgFO76Tfx3E6Wav0PjeHjVz84huOde9yaPoivcUvzpKMBXF3+iu40Cp+Mj9p/xTtBMBqCfvQGrqp0128mc8XL6okNOPKAhnX6my8FABm17nUsidqM2r/GWAjLuF0LFp7640RngnA2MXhFRlgxBOT3MF9kBAz3+ENTWYfhhfKIXRfaiL577wkbozViiN2YkpkJpzxZtTqlT3fmnazRa5gA9Spv8vFd9Mii5dKdnpxojT5vNi7wmlkq5Q6nbJuKmfWubHki+Ji4sKQ7E9U4Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b3e9zYdd2IirhV0LKMjRpFuc4X3qoYv6xTJY95yEjo=;
 b=QU2FrzOy9LAZdY5WRyrit9x8arZFnZfSMxaYIDaJ1C5ADg+ZHz7Ol3DdWN1rtpWrAlUrPnrd3K6c1q69q3lgDyxmpYkR08JFfuYOiFyEgEF9zdb/u9aQmcJOGmVjTJgc9Je8Aat0OT//wyONPNa+pmVfY6+Q34otAN5zbkXiksh/e4alCHabioCl/gaUOhsaTnep2PT59xBzm/F1xxNY2/026dAjF6fiqGYo290+zJGRgf3DIcm0Q3Wv6QT16BiwWfVC3kA1C64Qz5dKeuohqYkZYpI88PMHHpePYtPW8VtmFyWMhwjXm06YeErFrR91rwuaj6qgrJlm1g+r4IMImA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b3e9zYdd2IirhV0LKMjRpFuc4X3qoYv6xTJY95yEjo=;
 b=hHSs+adYsaXEaVaO53tJ8rRMXmzZHikdvAAIjp5cU4nlfFfaQfht27l4AJ8F68/1F1quyPPMM1fzeURoEXBwxYt2PZKiBrCkcC1H67Uqv+uMVaN2RktiKYcIy6EshGMfwa9PLbuoMLf6VVsMnWQB6jlVbQ8f7dLdtseYy1jgs8SW9344Me9osEuoGqgbM+JAV4m8sfgQPXBji3YcyFa7rNcZoMSVXUck2pziT9g916E2WB4ptE/AOFjfyuSkGFoxHWytwcOyZRX1B0lIgNZUdbFq4WozidymsvRVu1lJQJphVRUHoldlfnFfym1I5W7b30uj2hQsaIjfZnlRA40nqw==
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 08:58:31 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::ad) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 08:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5901.14 via Frontend Transport; Wed, 7 Dec 2022 08:58:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:10 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 7 Dec
 2022 00:58:08 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, Aharon Landau <aharonl@nvidia.com>
Subject: [PATCH v2 rdma-next 1/6] RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
Date:   Wed, 7 Dec 2022 10:57:47 +0200
Message-ID: <20221207085752.82458-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221207085752.82458-1-michaelgur@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f02d1d0-ebb9-477e-8fa4-08dad83136e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAPY6w2eIwbXpGf7/AeHUsb/e84Jd5fIXmIDKI4Vcw7X1tcyrlG8ATkav1+XhB7ADMVC1zXW2EljnLSUe3XcL5AJy/Yg7XZQK2Z7up9w4oMX/g1cPSjaPf6ARpLcUpSU9VMZ2FstXkNZLH/qWqAsp9sRmtic1N/CFzYfxX8/Dw9kkTASIpUfb4UV3fCUKg1uwIuWZlnAsIZ4r7Tp6Lwhcd0M8yqt26t6Bdhs9nj9Qffahm2KKBcEFs8DGjjN98Xn/Ba9GP5I/yhDRWrUlyZQxNU7BOT89A1qjWdWr6QI8oK9q66wZ21knno0gl4uSDTuvorFhXtc8srIp5o/ooAmPOrEcfC4DYnPvT/pvsImbZcKXpbhQsKW4/GiuxqqPQSMx/+juFkDGdO8IeXLLcEWDcxPPQflCDdsDYuD4NpTlxBrCoH9SAmFykk8Qd4GvSRCQ8qzijj1j1MsRQYK4lElJI02pgpzx5HIhZXRCrdit2zRJZ64EQoCWfe/pdPeQyJl2UV8eF4wbz0cSjVFpyFpn718zVHbdOeCxmI3jwa1Mutz1YEQFqbdrewJ643ZvX9fAh1T/emwuee/7Oqkpe/i0WvPPn0Fap4tFO2IQilZSV/ZGQe8urMyE2/llf2Ke7pSkyifoowLARK59ekPq1hkAz+0iqQ2YuUJtn+vhiDtWCxQSmuW3w3Ox4T3KvQNNJA71U8diqgTaqpVn/+ftO/ukWsGAKVDro1MuO247nYYcXA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(5660300002)(7636003)(356005)(8936002)(86362001)(40460700003)(4326008)(41300700001)(2906002)(36860700001)(83380400001)(70206006)(54906003)(316002)(70586007)(8676002)(110136005)(2616005)(82740400003)(40480700001)(82310400005)(6666004)(186003)(107886003)(426003)(47076005)(26005)(478600001)(7696005)(336012)(1076003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:58:31.0588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f02d1d0-ebb9-477e-8fa4-08dad83136e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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

