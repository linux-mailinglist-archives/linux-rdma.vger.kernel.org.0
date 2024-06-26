Return-Path: <linux-rdma+bounces-3498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A71917DCD
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05A81F25C83
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51DD17CA06;
	Wed, 26 Jun 2024 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RLjc3Vtz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408017839B;
	Wed, 26 Jun 2024 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397634; cv=fail; b=RiWmjc/Sb7A1CwZK+RGDGLBGR5g3TVLcmyK8rcbgpBvBv8a/38qrCsLdUnoFmdNjqyc/hXdhLrtQZMxg35GRIkMRdwYkPhrREE3X4CWrWDg/sh3h0LNXsJ8K2G/OZfQIADLFfaxYP9nB4Qz9wPwyVZB+5TwSCzwjH8EnDaZg3Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397634; c=relaxed/simple;
	bh=C2tPCh8FQBXNjckfu2hkFRSK8vMqBuVV3Aw2VkupURs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RnAbG6McWIzktFToTpENIdT8NpqaV3E1qQxrB2Knk+9g1oDWvTk/GRfU4ObTw1K5SC+gRSO8I5yxGUICnqCk6bXN+rWqxFan5ute7aQ2elWPDaB/fMbulgz8BuZKeCcJkcJgtytIlkgNVfIB2sMx9X6BnUPptVtBN+s1lB2P/64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLjc3Vtz; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9k5nFv5m+Vl93mcE+PoEHJiooD9JZ+0rQrKuCsnwe1SKxfqTVzh7thVSAWnAG0XNIXuU+tZK3EH2IDNa484YS+kK6nMq/SZHRADT512bPctA6A60jij243ZGLkmOTJfampYa6Totw9/U4xRC/a6IlZHAflMFsRS8exIbRs0x7rXXcchGy8qjBvGJTLcISrLZlaBtDUKdS88bYTAK/MDLiJ8ave4+nMhX1jYCe1qjgkk12boVIgrklyonayYRLMIuQTXnGKOMpbJYS+8Fvy/hMrOECObV1ZDIFQC6kzhMGNfsSlsQCzRSXNPlSgCZy0TFoyV3IrQKKz2FNPFZe9Oeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjqnAAoM/3WBJeJ1KiveeCW3YMFotXJX4AxpcMxRD7w=;
 b=VlCnUph+0kT0ZNuPJrjZYGwY0vXBqg1OrXDcCqoDTi3/XV3pztu4wWrLrEO0vSNikMx41rGNlccAcLfvaWb3vOdiSpdR+kGv2ByO233yuHeadsVKkRHEZ4DWvwMyHpHHeNi0K5y6rym5qc827AUdPN5NuiIFaykYRUYvdenFA7aBsvnP/Zt0UfOKGOmJJdGOPw4id38lTz9zxN9t0woDMAJKDhPLOcOeU235ceI71wYSLKXmTKRgbb8sP+rYko0ErBm/lUurUi7fOBifCWNi0KzTqK0rW7LUi4FBNeKcSj5kCajyYXLPJBWYjq2m0NNFpZS71ccuFFa1M4M3g/f1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjqnAAoM/3WBJeJ1KiveeCW3YMFotXJX4AxpcMxRD7w=;
 b=RLjc3VtzwyK2hTzmwev3o2VRu7uiZ52/r9rxg8XAlvT0buUghWUPIp6odzI50jLpfakhp92i1advCHZLifwUxgRL7GbtMP734B/LhQkCUu9a7XaNAR5vMUl6TSOsg56sjbI84146p+oT1kerXJF4MM8shyuWUqOteGMK26mKUeiq8uS6jweKJ/Sr0bmmmsJUAeLK6NzQ9mnut1Ts/uH+aJW+Trh7U8wqzuhH2gsvLXfNBjum0V8pwK+856GJco8rjT8H6vu0/6F3KUSTBOiuvjVypOA3OdERSF0EEm576kxwMGEJv0HRd+o2aNKpT4V3tlrJ4SSxKAdpZXXagZye8g==
Received: from MW3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:303:2b::11)
 by SJ2PR12MB9190.namprd12.prod.outlook.com (2603:10b6:a03:554::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Wed, 26 Jun
 2024 10:27:09 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:303:2b:cafe::41) by MW3PR05CA0006.outlook.office365.com
 (2603:10b6:303:2b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:51 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:26:47 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:37 +0300
Subject: [PATCH vhost v2 01/24] vdpa/mlx5: Clarify meaning thorough
 function rename
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-1-560c491078df@nvidia.com>
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Cosmin Ratiu
	<cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ2PR12MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 935bdde2-4d71-4c42-1e46-08dc95ca88db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUEwWjhWb2JUQTV4VDh1QVV4V09UUXluMW1xUWNUUFQvcFNybFIxdVVKQ2lz?=
 =?utf-8?B?U2dVY3RIbWpmRHBiczhqb0l4Z3VCR1EvUXhUYXpKTU9kMTNNSDNCaURtK0gr?=
 =?utf-8?B?NXBNTjIyZXhmTFk1VU1TbjVnemwrdkdPb0RrRW1hYTZEaUJYbW9XRjNJQTVh?=
 =?utf-8?B?RGQ3M2lMTXl1eTQ5bUZFUjlOUE82U2dWVVNCL1paV0ZmSWU2UWh6eVJhZ05N?=
 =?utf-8?B?OGlKaW16L1M4ZnNnQ0hrSEs1NjFsQWwwOVZIWDNESGZ0NERzSjdqc0NxVmVz?=
 =?utf-8?B?MVlVcGNSZ0tlWnBEWjRuRmFCY2dzTFFWYjlBMlo0dks1ZFJUUmZGWStzalVQ?=
 =?utf-8?B?QTNqVmtsU1kvZGFQZjFwM2pFUUlRUU5qMFdsVlFMUEYwbVpqYkh0TkZxUnY5?=
 =?utf-8?B?VVc4bFJCYWtUVTFGZmhNTHAyaDY2OXVobS9FRUkzeGFPN0tJYlhoNWJRdVBK?=
 =?utf-8?B?d0I1OVBKbW01TWNRN0ZtMHFhazJKWkVWRFcybzF2VmNYRm14RHV5L2R1cGQ3?=
 =?utf-8?B?WThtN2Y0azV6ZnRlNXVQNFZYSmR0NkRRL2NmTkhoNExoVjR3UlZuVGZVRFE1?=
 =?utf-8?B?aGVyVlU1cHRqNWpoeXcvbW1oYVBlNGVMYjg1eTZiNmZicGk1VkJ5T0tJOW0w?=
 =?utf-8?B?dWlNVmErT2hyUXQ0NmlvVmlhYWtVQW1jb0x0RjVnTDRKa0Q3WnZDV3dBa2F3?=
 =?utf-8?B?R2FWUVJ3Q2t2Y1ZBLy81YWk4NDdGQWJtU3FNL3VlMGJWT012ZW54OGUxSU1Y?=
 =?utf-8?B?UWg0bzk1UmJyblllaVV3cWphakppWlFubENNTUQxcUdkM3RhOGZHUGRKbC9M?=
 =?utf-8?B?aUM1Y3pLUjFNcFo4V25ORmtyR0VjNDE3UFY5UkMyUXVZOEplOWNya1ZmRlBY?=
 =?utf-8?B?c1ZIYVUxcUsxeHJtaCtJVGJaVVBhVyt5Rlg3cUdSdXNaVHlMYk5RT1ZLbXNN?=
 =?utf-8?B?N1lPN2c2V1FNYVk4cld6ZTBTUTVTeDhVQXFWV2c0MDlzMUVMdC91cGd2WjJ3?=
 =?utf-8?B?dEhCZ1hnNHBhaGFYZGx2Y3dkeEdiYVVKeGRlcjZPRnozeGg4bVJiNDVQdHRk?=
 =?utf-8?B?KzNzaDNibDUyZUhkVnpqakMyQmYzbzN3dEx3RUhqR3UvaWx0WE9FZklYRHZ0?=
 =?utf-8?B?N2EvYVkwRHFNMW9CRTZxUDBzUWdDd1NHd3U5TUlQMWlrSEpyN1ZCckNUQ2pZ?=
 =?utf-8?B?WnY4djF3MnBnMTkvTHdERnlDTG9acnZZLzJkdUtKQmVScVBBTjJ0UG9EbkFD?=
 =?utf-8?B?MnByWHhydlpGT0haMzVsWVEzYklBeUNCdWVLZStYcmJwelV0QS9JK1JBZXdF?=
 =?utf-8?B?NzdXK0FjRms1VU5ERjBHTkdLTnY0azk3bEc5d0RNMkpUMWRNSVVTVUtnNGNE?=
 =?utf-8?B?UHpTMDFYcVlBa01MNFlSYzRsN3ZITVdIOG1JdEVWVGtRZXR0TFlsbXdxcmFw?=
 =?utf-8?B?UGpEeDlvZFJoekVXaW9Vd2hadXNUS3ErNUticG14WmVFQkMwSEpnWCs2eWkw?=
 =?utf-8?B?dnZ3eTA5b3k3eWtHK0pOZTJiVHp5alExUWV3ZlpIcjRhV1lSaEFnU2xCNXUw?=
 =?utf-8?B?ZlNkbFI0QU1LUERralROR21BWkVMa3U1UE1BVVUvMEcyZ1c2KzBHN3FPYy9X?=
 =?utf-8?B?SmZRWHJ5cC9nRWo3Zlo4T2VYS0QyTjlUQ3lKcEZSZjhiRmFYQjhZMzd6bmo5?=
 =?utf-8?B?OVowNHBlRTl5VFhhZ2VtVVJxeVEyTkdzUTNhL0ROV25wZTh1WGZiUWR0MThK?=
 =?utf-8?B?QjlNeFNFZ0pKdDJOQ1ZtQ3pEVk5XQjFKR1Vkcjh6M1lHMGpPUkFIN3UvaUZL?=
 =?utf-8?B?SEJZc2oyOXMwRmVLcnFXdDZhckk5dU5ZdjBFbGZabTgyN21mdGVNM24zVTI3?=
 =?utf-8?B?UmFCcFlNaUV2RjFSc002QmVoWjBUVmQycFhzczF6MGwrYWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:09.0511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935bdde2-4d71-4c42-1e46-08dc95ca88db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9190

setup_driver()/teardown_driver() are a bit vague. These functions are
used for virtqueue resources.

Same for alloc_resources()/teardown_resources(): they represent fixed
resources that are meant to exist during the device lifetime.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ecfc16151d61..3422da0e344b 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -144,10 +144,10 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 	return idx <= mvdev->max_idx;
 }
 
-static void free_resources(struct mlx5_vdpa_net *ndev);
+static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void init_mvqs(struct mlx5_vdpa_net *ndev);
-static int setup_driver(struct mlx5_vdpa_dev *mvdev);
-static void teardown_driver(struct mlx5_vdpa_net *ndev);
+static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev);
+static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
 
@@ -2848,7 +2848,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 		if (err)
 			return err;
 
-		teardown_driver(ndev);
+		teardown_vq_resources(ndev);
 	}
 
 	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
@@ -2862,7 +2862,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	if (teardown) {
 		restore_channels_info(ndev);
-		err = setup_driver(mvdev);
+		err = setup_vq_resources(mvdev);
 		if (err)
 			return err;
 	}
@@ -2873,7 +2873,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 }
 
 /* reslock must be held for this function */
-static int setup_driver(struct mlx5_vdpa_dev *mvdev)
+static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
@@ -2931,7 +2931,7 @@ static int setup_driver(struct mlx5_vdpa_dev *mvdev)
 }
 
 /* reslock must be held for this function */
-static void teardown_driver(struct mlx5_vdpa_net *ndev)
+static void teardown_vq_resources(struct mlx5_vdpa_net *ndev)
 {
 
 	WARN_ON(!rwsem_is_locked(&ndev->reslock));
@@ -2997,7 +2997,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
-			err = setup_driver(mvdev);
+			err = setup_vq_resources(mvdev);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
 				goto err_driver;
@@ -3040,7 +3040,7 @@ static int mlx5_vdpa_compat_reset(struct vdpa_device *vdev, u32 flags)
 
 	down_write(&ndev->reslock);
 	unregister_link_notifier(ndev);
-	teardown_driver(ndev);
+	teardown_vq_resources(ndev);
 	clear_vqs_ready(ndev);
 	if (flags & VDPA_RESET_F_CLEAN_MAP)
 		mlx5_vdpa_destroy_mr_resources(&ndev->mvdev);
@@ -3197,7 +3197,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
 
 	ndev = to_mlx5_vdpa_ndev(mvdev);
 
-	free_resources(ndev);
+	free_fixed_resources(ndev);
 	mlx5_vdpa_destroy_mr_resources(mvdev);
 	if (!is_zero_ether_addr(ndev->config.mac)) {
 		pfmdev = pci_get_drvdata(pci_physfn(mvdev->mdev->pdev));
@@ -3467,7 +3467,7 @@ static int query_mtu(struct mlx5_core_dev *mdev, u16 *mtu)
 	return 0;
 }
 
-static int alloc_resources(struct mlx5_vdpa_net *ndev)
+static int alloc_fixed_resources(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_vdpa_net_resources *res = &ndev->res;
 	int err;
@@ -3494,7 +3494,7 @@ static int alloc_resources(struct mlx5_vdpa_net *ndev)
 	return err;
 }
 
-static void free_resources(struct mlx5_vdpa_net *ndev)
+static void free_fixed_resources(struct mlx5_vdpa_net *ndev)
 {
 	struct mlx5_vdpa_net_resources *res = &ndev->res;
 
@@ -3735,7 +3735,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 			goto err_res;
 	}
 
-	err = alloc_resources(ndev);
+	err = alloc_fixed_resources(ndev);
 	if (err)
 		goto err_mr;
 
@@ -3758,7 +3758,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 err_reg:
 	destroy_workqueue(mvdev->wq);
 err_res2:
-	free_resources(ndev);
+	free_fixed_resources(ndev);
 err_mr:
 	mlx5_vdpa_destroy_mr_resources(mvdev);
 err_res:

-- 
2.45.1


