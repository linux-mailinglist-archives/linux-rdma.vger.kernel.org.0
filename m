Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD666B113
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 13:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjAOM6g (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 07:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAOM6c (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 07:58:32 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E98B10A90
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 04:58:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtArInQzXkQfSKI5fw3dQFaV5gx4DgY+ZkTyW0wJYOtcdtDATnGQKIgha+4jhpk5qeAX7pUmC6Liv80Gt5U+WacQKJGGkExNHCdBI6YUCiG31cWMXRbdNWCNBX2ySjoiyTkYrQJmaOICnKw4V/0OY7ZC7oagk2d7oP3hPw+q3aYfynprcCsPcvhmwmWzBBHUEUwy7jKmrDbkFFX3URl30ullqfUIYsvuS8dTSL9n1CljnVvsWQ4eJjpSyvtjf/Pr8QRRJ6uvZhsJtV94VmS7z2xFgwPlKQcDTb2zn8pacz/KoygTLpWSinm3J4PncdEYYM5ucpYEY19JRgq6wFsX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TO/WvqZmz5Hi+nBLiQbD8NKYwtBwDUokf0Zm5rX+yTA=;
 b=m344sATKhhaIgU5aENP0QpMaNq7sbxJsrUNcsQL5cfN3BraaRXo3c0gyJFRUG0Nw/v8vAxYRRze50Sz1U6IL/q0CaQNzlSNRtpfKFTvHixBtPju/P+Xph5ZIruiNvyyZbIQcDwz2v4QVY7aUeTjkERnt5uOW3r3MRWnTlqSh4gCJuYEUFFGkT0NhO3PdmIByJqiCijg2uUmUH0ibtVpkxLLeaINHTl5TxLjf1p5RKEMt/7NUsgHi3IJa2ILrEGNe2KEbw08w2yOiMYdX8i+4kssqjYSMBQGBCh9liyhzQdiE7wHscdbKxPOj3dsCy7fg/MaUZc7gDaAQuz3mUDIFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TO/WvqZmz5Hi+nBLiQbD8NKYwtBwDUokf0Zm5rX+yTA=;
 b=HAWX6DuA1jFcGwscadJn6rt4LRfsU+Aybm7MSeUaUWxQKGq3oppL4fxJqwlgZYmw0t2OJThWFD+LPBWxpPRHspKY+G0Y8RBF3Ipwj+euzPXuQHDD+ByKBwslQS8rK5B9YXUndSkDGMtTjR0gSCHgay05EG5zeNXn6vdBE1BO29dGI0Z6BzM1y97dRyynHPo2srG8hfVm2YgtmUc/vd1TZhA7q4lBnAdYGJa0XN/4V9Q18iwzoaQJdYp/JVFif7e6YZzhlCKHlqEyaav4wJGpCJdcwYvZ9mt7d//pPbE56oz+FUeRX8UfvG3cdx8C+T/HBqYAdpXMnLUKC5jNFEpYsA==
Received: from MW4PR03CA0287.namprd03.prod.outlook.com (2603:10b6:303:b5::22)
 by PH7PR12MB8122.namprd12.prod.outlook.com (2603:10b6:510:2b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Sun, 15 Jan
 2023 12:58:30 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::5) by MW4PR03CA0287.outlook.office365.com
 (2603:10b6:303:b5::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 12:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 12:58:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 04:58:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 04:58:27 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 04:58:25 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v3 rdma-next 1/6] RDMA/mlx5: Don't keep umrable 'page_shift' in cache entries
Date:   Sun, 15 Jan 2023 14:58:14 +0200
Message-ID: <20230115125819.15034-2-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115125819.15034-1-michaelgur@nvidia.com>
References: <20230115125819.15034-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT066:EE_|PH7PR12MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: c4d89393-d580-455d-4393-08daf6f832fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urdrNQESzuw2KNDGB/hMAGITj61EjI8rHw4/ZIb/3bbXNwxEeL6K/6tkuNaGgcgU8e0LfRdicbItAjmWIgcxySAMzqjsAaNnGJ1roCd0HJNKza6p7mFyNNkA5rOngUlc+CxRA2iZpIzWemOdaAlAEdGSOPWXbmxCzKP0SDZ8tdNlagivvpMcGbZHnL3LbIlIzKIaFd93f1icBGJS4RZ1VTUncLOTS1BzkQTWeRqM0PDMY0Ci8FUyTpSBu5ART9gv/y/x/eCEuB1E8yxY6aAavjqIX6kOmu1YrvhsJteKs+iu421m2QssbzpJD9TyPQm75QoyKsWdhwHS2Zze0p6p1Bj3P+u5KxsQoIJdYo4P53rJqKe54KWXyA8ysD0aQm+d0lB6VqtyK4J0ZPJpmMl4JfxAM95U9kSXbUEBDSGN+c9SiManMn6tdU3lNQ/F/Cl46YC4q6AL8khlCiagkP3JoVHn3wSFeC00/XcURKoYYcKchbJwfBWEWHdZrSpeHiK2Arl4+jtOiUQx0oow0BzSLQTwWbIdWu1vsPxS0v/vRz3sE/jIKY6sVU03Y82Ns6aAQs7zrlyQSGRp+159t18In+bvtmwZxt2NnXe8dvL/HsmxLMq8unsQgqLLarXf32BmZQfIPcUMv9pm1hrPqBi9+YWB9gs2j3qxqUA6e0jJN0LiT0vnAanhWPgzEOGUqquX9lLJP+R7xKDdr/TEdQKCGlT7REDZpNweZgbOMoyBAic=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(426003)(478600001)(82740400003)(7636003)(41300700001)(356005)(47076005)(1076003)(316002)(54906003)(110136005)(40460700003)(2616005)(86362001)(26005)(40480700001)(336012)(186003)(70586007)(7696005)(70206006)(82310400005)(5660300002)(107886003)(36756003)(36860700001)(2906002)(6666004)(8676002)(83380400001)(4326008)(8936002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 12:58:29.2968
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d89393-d580-455d-4393-08daf6f832fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8122
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

Issue: 2404431
Change-Id: I0e6cd6dd4eb1ef99d3373f98ef519d54a7bd568e
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

