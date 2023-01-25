Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7F467BFED
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Jan 2023 23:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjAYW2p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Jan 2023 17:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjAYW2o (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Jan 2023 17:28:44 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6D35EF96
        for <linux-rdma@vger.kernel.org>; Wed, 25 Jan 2023 14:28:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjezzqsgTxDuqi1tQGKjBYlJ00goBW9SOX3ubcSnkqIRr2/nPFQXecnUf5gA61etziJlDTaE1s/ybqVc3zDANXSCJmIxRQpUDeq3ExIoVbixmMcuyVQkJp4+JF4FdJWQrBbPzREAiNum0AHir++WNAa5R4cJTg7+TZsBKadi17GK5o0PvmgGCnouLFnRRcfVUpKT+ZU2dlmoYYsodMv0YCqI3t5G+XEiez4ZyCwkmqsSxORqzO06nmwWuzbHVgf0JgvXaelgkJn+axHMTCkT70vmoa0kxxY3pm7XrhY9zJaEtA9XTO4etXKS9QX0qsoiV/rCDKjj0AiMLSAYThb6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEIKtvNPepHCugz55+xbLTDEDLyl/ELUQBsOTN8aS2A=;
 b=iDhby50PYOZ7KhljYaxc9ZrZu1YY62WArvHKi++/JXJPMoOX6XbkiZUKOW4oQNCFDMHlmei02WKCxrvmlB/3CAXtQ8Y6TCXFS7ZV4mSE+AstL1q9UTPEFv8S7I1PFDbXlbaGVKc96/T+x4dXravwdWprGsm7uW4Ec/6qWlbyebCtm6gPj6IQRLGWCFjfdbjoO13l97y8S2eIIP2yXer83cBUsmwZvUoL+h3lVdQy6XB6QXiypzojVHKx3TAu5O5JBvtYwex62gIFYFh5qOTWRoA6V7hMFaav0sRkV4KhOJNXsKI0+r3A8wQJ9qg3kCBx3j6IcKGE97GH+hZ+TUJl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEIKtvNPepHCugz55+xbLTDEDLyl/ELUQBsOTN8aS2A=;
 b=a+X724g+KmMsWJOq8hcQcGJ4b/BELq03dCuuGIIR1Z2uj9g8ttItCwdbsl/Bab0R76tVrri1C2RGOx+JZk/yEeM8LQyyCQc24ZSxqhn5A9rYkDRMsSL7QJyAOr6oS+sMjItzm/fbEbLj/wOQ+w8VYXTV7IlhW5JjHAoGqXoUMN9Csn8COqwJIz91Kxy/UqALEPKU9EQVsFUPPPMdXzxkLaGmYhHbPjytD0OyF56TfgqrK06MQeJzWlAvBha8G1A+fLIXoSuxqcvIFp0+eFUx5vve2c83fcn8LWlWQqc4NG+2cjJKmphppPoIO1ufpzSJ2B7ghMacX0GBXa68DHH3cQ==
Received: from DM6PR12CA0009.namprd12.prod.outlook.com (2603:10b6:5:1c0::22)
 by IA1PR12MB7566.namprd12.prod.outlook.com (2603:10b6:208:42e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.21; Wed, 25 Jan
 2023 22:28:39 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::94) by DM6PR12CA0009.outlook.office365.com
 (2603:10b6:5:1c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17 via Frontend
 Transport; Wed, 25 Jan 2023 22:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.21 via Frontend Transport; Wed, 25 Jan 2023 22:28:39 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 14:28:28 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Wed, 25 Jan 2023 14:28:27 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 25 Jan 2023 14:28:26 -0800
From:   Michael Guralnik <michaelgur@nvidia.com>
To:     <jgg@nvidia.com>, <leonro@nvidia.com>, <linux-rdma@vger.kernel.org>
CC:     <maorg@nvidia.com>, <aharonl@nvidia.com>
Subject: [PATCH v5 rdma-next 2/6] RDMA/mlx5: Remove implicit ODP cache entry
Date:   Thu, 26 Jan 2023 00:28:03 +0200
Message-ID: <20230125222807.6921-3-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20230125222807.6921-1-michaelgur@nvidia.com>
References: <20230125222807.6921-1-michaelgur@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT062:EE_|IA1PR12MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: b03fe9ba-9443-433c-ca46-08daff2381fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ndCdnbOYXegylRHR1CaahY9lJAKsmRYUk9Ff8zVZzjTZ+ZzbmGbAqsZ7zmrikVduwOtgjvnNLrGnEa/nn9uVT28FbMD12wo2AkPuAgCdBdS0JvjIXDMJGbhsyY9+iwlWX9iFB+uUg6NlCTyQjRkTrZBWPg4o5gO5ghXujAs9k072GIxNbDalhGi3Efsos28JT1qS3BzPanALEptnKvGR/DTmVEXDloaO6EOHLwfzniROHyHqPWZq4KqZo+ekko2v7l/kTSPjXbKfD0bMrODEa51NCI47nLaFQJPodZ7YYTfquxeYnDoY3C2tiKtXzqiKeI5ffEKMz3zop1XJ5UaMX5G4O+qgKwivwC2R+xRvTfC48ZBeiiUYjhkRrquA0IF0fAgKatvUL2wFwqucFrPLuicpRAuJaVt/VKkl3X24yDlPhMmXaqwI4+k5syK0mJZa/grRNKcq73ByPgZkFrNixOxA26JEidBysCc/SofxSoGLYiUk6DceFafujqkY8vKRvWURK88HW+Gi2r1iFhrXyjAGC8+LUUl6bZ5iJuw5ef5U6+t/wjitD2tAlZDUVSV9M9VPCC7HWjCygJ6rwCtW3JrzT5fW0bdrKrSizeGPfgDo24261ngup6Us1dYLc/XuOdWQ2JtQaPPkji/2ATcKYATHIzP6/V8qZZgTQ9aJ1BttGh6P4m2PalkQLqYbGhNps+Qlb8HqqePDMJFghcADQ6fR5TMOOWB6eQ8pCaVf+jI=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(82310400005)(86362001)(40460700003)(40480700001)(36756003)(356005)(36860700001)(7636003)(54906003)(82740400003)(110136005)(2906002)(41300700001)(70586007)(4326008)(8936002)(70206006)(8676002)(5660300002)(186003)(26005)(1076003)(2616005)(316002)(7696005)(426003)(83380400001)(107886003)(6666004)(478600001)(336012)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:28:39.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b03fe9ba-9443-433c-ca46-08daff2381fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7566
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

Implicit ODP mkey doesn't have unique properties. It shares the same
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

