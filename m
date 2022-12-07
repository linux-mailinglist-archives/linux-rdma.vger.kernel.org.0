Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0316455E2
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Dec 2022 09:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLGI6q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 7 Dec 2022 03:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGI6e (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 7 Dec 2022 03:58:34 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6344CBFA
        for <linux-rdma@vger.kernel.org>; Wed,  7 Dec 2022 00:58:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3MwaJa/mO7Uv6/2ch0wsSvs0SCzyOldQzJnzCy9YH9XoZ8+qhsKkBlo+YtiLV81D38cIG579ELcWCjCypCPjMhg7wTTw65wvCzjbWhDYnFM2B3KIHy8/4x3mXnjrJkyCcp4bsofGJeBZPcSJup6TnKOWwmuzc/tTqxoyyukRTfy6BGelphfbXl+HeYQKxWb2QQk2jsiI5u1OYzjtsDlfIqY4Z153jhDmzcmZ67HHB0x7puhCzYmaMj1iwPEqWgRNAS37w4I8qa8lsBumDTV4/GTQWIq3CDyYtnTURMwWG1xiAi14wQthwwp3yy9ojKvYi2k4VHWyZZbzBCMj+TyrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Adlln60Pq1La/Zm8emJxl0lXcBXdl2DTvA8GkDwGcY=;
 b=nMJV75L727X4S67zWFMNY/xFrqNDDUaP2bzADkTMGM5F3gLUc350ZFkNnYHm6p4VaKpbStPsdL+mL0FdrdAPBESCqTMkhpsTheHMvwtIiJG7gVwaplzgKif77vDSj2FstIj8+FUlLEXEUHYE8shDa4iVTxXZxAnxCPIdvghGF+9oU/saZh/YWmDgOvBQMSt/RXC+EKAJDZRomMMtqV+l/TNZe7+SNMbur8eSw2PZtBEObQsNxKzbq/gNlY1sa7X3hPn2F7BnFBTE33l368IsZOql6e148GfSil3TKhKRn6dYgNvh4+dwSJR679RsqLetCLK0gGavA/p5rL3ZLdpmpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Adlln60Pq1La/Zm8emJxl0lXcBXdl2DTvA8GkDwGcY=;
 b=hcVHKXa2syZl1CazJvnJoJdCfHxGI4g2/NNhVrnjZQInzXg/i/evGQU/YvwlSMQFjpHweSf4amve+ga8d9yhkc9K9F85dGX+wWNaaYzKV8oPg33kZp+fk/SXtRi7vfc6lS1q6LrNnDeonTziAv64xZAgq3j5p3R7zb4DJm8KHsBDG+ANE7FqKBgcTpnsFKAm2S8dTWf7YSl9fQfYXDna8cu7peLyfI6gYjPYVYjRkPQoe5BWTshz47iGwfNEy+O4drY3vCbFBniOdNGgh27/hDpIeE4CFbkyw+iZFW71tOGz2LU3SHgUnEE/F/6H8WuoxEYcerYy2nidhldBlLOWyA==
Received: from DM6PR07CA0072.namprd07.prod.outlook.com (2603:10b6:5:74::49) by
 BN9PR12MB5196.namprd12.prod.outlook.com (2603:10b6:408:11d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 08:58:30 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::22) by DM6PR07CA0072.outlook.office365.com
 (2603:10b6:5:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 08:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 08:58:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:14 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 7 Dec 2022
 00:58:14 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Wed, 7 Dec
 2022 00:58:11 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, Aharon Landau <aharonl@nvidia.com>
Subject: [PATCH v2 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache entry
Date:   Wed, 7 Dec 2022 10:57:48 +0200
Message-ID: <20221207085752.82458-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20221207085752.82458-1-michaelgur@nvidia.com>
References: <20221207085752.82458-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|BN9PR12MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a92c79c-44fd-4362-2906-08dad8313614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIMr1BeEo5dXTUKgj1sq7kHrYUmqvY6p+gJwjynkZA12sAcvfdjBgYB8DVPVqMHTkS5DHkBj/fS19Cyl2q2YFxJlKjV7noCjy+vot20gY06/gPIIUyllkwIXg2WkB4AwE1B8QL0R5ugMZChl4omXQs+aEE6QAtE+6hIRwOBPD8rAyoR85FAo1uSXSO8TQeuldHdbI6tPUQCa/xm5lCB9zGsPPxTBcqtKin/zq/J6DQH1KHrOVlqJFKGXoaH0B8NpJ6vx9YXLq3EVwUqFMddPH2fLaowbCpfof5l5AZ2XrdyMOgUssIuZcqSP91emkPGOsNNkLwlKhXHXAsInr0bQ7yzUHcuQSmkbh1pDO8HgJ6Gm4EBBSfJNwqkYpnp8TFA34LeqiWAC2JQY4bmlJRXud9PfDLTIpDCeqro5T3uWciXyxp9ol0n/uF+Og04CysdtjVYvoGW6O0cyzRMRDo8MdhFJ/Bk1z0dJMJVweMc/X11gEw/ThyS1bv4LgfmMFA+Lrduq3ednN/FgEjwbWV30Yz0jegevbA52I3Bup0mEP6pSXrWR2j+KZ6gQSEIBQIWf1eZuVDqN48n4+VW9tyhy/UtUiymR07FKkkKT5HjVDYMneBqjdp07fC5wijw6KFD0UIJBgwkoqE9z8k87T7aupz2K9Ozw/piSdoR486g8NJ0aiz3janavwhHccpvhW0TDRCJ8v7Us1O6SwiBQyqGGLhkOidsmb84SVw9Usnte2GI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199015)(46966006)(36840700001)(40470700004)(426003)(47076005)(40460700003)(7696005)(86362001)(478600001)(36756003)(336012)(40480700001)(83380400001)(36860700001)(186003)(2616005)(356005)(1076003)(82310400005)(5660300002)(41300700001)(4326008)(107886003)(26005)(6666004)(8936002)(82740400003)(316002)(54906003)(7636003)(70206006)(8676002)(70586007)(2906002)(110136005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 08:58:29.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a92c79c-44fd-4362-2906-08dad8313614
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5196
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
 drivers/infiniband/hw/mlx5/odp.c | 19 ++++---------------
 include/linux/mlx5/driver.h      |  1 -
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e9a29adef7dc..71b733fcac37 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -406,6 +406,7 @@ static void mlx5_ib_page_fault_resume(struct mlx5_ib_dev *dev,
 static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 						unsigned long idx)
 {
+	int order = order_base_2(MLX5_IMR_MTT_ENTRIES);
 	struct mlx5_ib_dev *dev = mr_to_mdev(imr);
 	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
@@ -418,7 +419,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[MLX5_IMR_MTT_CACHE_ENTRY],
+	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[order],
 				 imr->access_flags);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
@@ -1592,20 +1593,8 @@ void mlx5_odp_init_mkey_cache_entry(struct mlx5_cache_ent *ent)
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
index af2ceb4160bc..cdf6ed25778e 100644
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

