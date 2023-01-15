Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6268666B149
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Jan 2023 14:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjAONfP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 15 Jan 2023 08:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjAONfO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 15 Jan 2023 08:35:14 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4991351E
        for <linux-rdma@vger.kernel.org>; Sun, 15 Jan 2023 05:35:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glhIcqCmiq2gDGnc7Mq8oYp5hb1kct0jWMU6rGYkUKuz02tP5WpDOlAxzNMb9B/zts2MwtmPIoLepi6TF4/b++hU6fbZU3Q9xEuKD4LjN94cWUwkZmWcKDO0LEWQQIHzn6PJs6PWK7/PBJjDI93Muc/sjzIy+ak33XhwqAdLwx6Y9/BbDFVf0P1si7+TotJB/qG8G4Iob9yrlpXameQn3vzGCXky5JszbmlwGsjmKW67Ww4ussRGXfVbHCZ3801SxR0bkhZacf4lV6j5ZAZrCm420LJ2VXjOD+9CXnpNriVW02POl/Gav+aOd/rRKgZYQd9Fopgt3wfNaXVFiu/wnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU8UT9PI5jyWXV1A7uWLZ9IvU+n52aoi3hK7y+FduRE=;
 b=DlITQcf54iMqm5yMv15xPSn8eidFtc4KouALxlTUtnCxqmZUY4Cm3KCWmoMLp1DLUxHdUE2xRHrArKMzefw1MA+GB5Jw0DnnDFMEKUZ/hYLwGDb83Rhpy/gCCIX4Y4zbhMziwt+um6EiflrqdKf+BYKANg9aZphNZpTQPqihTtOHTqiqtaldcPutLmNZb5h14kzGIX+PclRN7VRjIWeNflMLu6JuNELS/zdu9WGQi5Se48l196CA8nuQcyTpZX0tctOGnyJEaq1MWYpRUbTMXVTFXHnpMJbBUx8Melf9YakTLVYj3QSrZp3sGbut1H3QVCLmB/Hz31EOI9mV5U3oQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU8UT9PI5jyWXV1A7uWLZ9IvU+n52aoi3hK7y+FduRE=;
 b=IsKVNPWyWcz/e06MbOjHmZXxjmIs8qO+xXR/sph6aq+Y9lU5jLSUbQ3kdemjVMTdUY0M+WsC96/sYeEl2WeZdhtIguUSmIdu3NCTm0FHusrRdEWaUFPwxLDdZP/uQZYmQyGblu91qeW607gstG8bJoKH7XAa9BTxSmFZp7hT9YaMgM3yCYG0RDhQDYEEpkJtsXI2I+IJygW8LtLHd6lkzes4xbOYxLmdhGdYx2syHqLBXBkFfMzUIBeRPzoESvSY9TrxU45jsA2nQhVFfkPBKPqJW9g1UH5c/edT4PVwZrv8MqNyblF2koGFmAPDhEpGd8uFkwTz9V0PhEONwraRkQ==
Received: from MW4PR04CA0377.namprd04.prod.outlook.com (2603:10b6:303:81::22)
 by DM4PR12MB5343.namprd12.prod.outlook.com (2603:10b6:5:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Sun, 15 Jan
 2023 13:35:12 +0000
Received: from CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::88) by MW4PR04CA0377.outlook.office365.com
 (2603:10b6:303:81::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 13:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT109.mail.protection.outlook.com (10.13.174.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 13:35:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:04 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 05:35:03 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.36 via Frontend Transport; Sun, 15 Jan
 2023 05:35:02 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v4 rdma-next 2/6] RDMA/mlx5: Remove explicit ODP cache entry
Date:   Sun, 15 Jan 2023 15:34:50 +0200
Message-ID: <20230115133454.29000-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230115133454.29000-1-michaelgur@nvidia.com>
References: <20230115133454.29000-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT109:EE_|DM4PR12MB5343:EE_
X-MS-Office365-Filtering-Correlation-Id: 5830464c-5950-4b44-9a29-08daf6fd53c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ggm63duP9XQFurjOYxXsQwbCJMnRQjXQqSDF4f0FbyrsI1AkMXUcaS17EZle06PMQpMT+ZN5otZreKnrbFLFH1k2pgPd1FTZksp33FVUaV+xMSPJmTxuZsbTzk8LjNTOmIoIgCd5tuhtogVqbfW25G7MP+slH4bqYH065rdZYiai+f4lHm9L03aXk4Npokv/yu+faOynWlHSarQZOZp/8t8HgItZSoypUKMJFCe5zn3ag+4s01q/b0xYe/0Q/OVEIDbw3Jv9nZ3EsuQTHGIlzKnsKBOOZEQW83Mi1fUh2SCT7EAobWT/kXSYhPMBvLgxsLYE6DCo3QdV/xJZqhlBrHQDWpCepizIHMdnz5yZdKTjTWLvjDuOzADoHRYEi4EuFuHurZkWbh2dhxn+/S5yAKNptJNGPqc9ysjYzUgERqbBa0fsJfZFVNFzWu6euJvK6teXLqORrCr2fZt4+/skD+kENRm2tEma9Bi8G7W/CZCieseG+wZy7GDY4xwf2+AaKGVZZwr4neKXBUNcX2BGMIZGeQP8S9VCt/fgJQGQJH6dvIU9zqDtOHuPPJ56b/pcjUFXuvESKqTyMnjFISKTHXqmNRDVM23WfMHjmadc289tt00xaDPhC6z09xFpxdirL10KZxxS9wrZGKlEUsBlekOeXucy+xTzhEowEOpgY//G/4FVoTmbJ2duzDw8t4W2c2k/vS+m3o286T85qfxjyBM8T7wqmRUBl85nkHh1jQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(8936002)(8676002)(86362001)(83380400001)(70206006)(70586007)(4326008)(336012)(36756003)(316002)(110136005)(54906003)(41300700001)(1076003)(2616005)(40460700003)(7696005)(82310400005)(26005)(186003)(7636003)(82740400003)(356005)(36860700001)(47076005)(426003)(478600001)(6666004)(40480700001)(107886003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 13:35:11.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5830464c-5950-4b44-9a29-08daf6fd53c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5343
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

