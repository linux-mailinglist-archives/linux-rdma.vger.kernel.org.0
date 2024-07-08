Return-Path: <linux-rdma+bounces-3722-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287DF92A1D2
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05811F2263F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C54180624;
	Mon,  8 Jul 2024 12:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BkjgGAbS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168E6EB56;
	Mon,  8 Jul 2024 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440104; cv=fail; b=pzCQJOK5pMuVfRpsJiUWTP/KkZAG0kRy4dlNQSk9Zv2p5uI+UteGmBWlF/GYBCpxQjk5Kp26Kjnqdcvyy3KTPIfB1OnwCHpGL3uBp8w6Scj8VI25zpF1c8NGJKUnSXUTIMvZCLLxx2+ORjnewyGH+CjvQfIHHOsBMKmNhVv1Jc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440104; c=relaxed/simple;
	bh=IqeLVexVBlX9F1rF2WSaF+uD1fvYZxPdsQ60WnFj6bU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=oSLwPVcEobOIdhKRLHpalltyPf+pNGUfqTDqjjC7bQKUFZtFEe5QT+SuWonbKOZGH1tw2Yjx1VOUFAzklU9VU0DoON0QDHJqfdYGMPeM5QspwF6ZX/jWpXu/YP6WcWrYINzfG2FN2ooSRjHnJA0vhyoGk19P0bbfWqvbUrBG8yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BkjgGAbS; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjO2dJH6Upj4WgbhOExE3X7Wnz/CHp1pWJ0LTYtoa6fQrzsQOkKpDKbG9qmBHlMs9EmC1R4xCRumAPFKt7Em3cUBWRZqNsJ01X0Tq8wbP1XStXCDiOF9aiwdDE+oW2W1W4hEbJM3DeX2WCISsld83FLx/DR60FvJLSBr75F5njiUcJP302wOiZ4ngK0+rDM0zXqYsFyuRTlTDkp71no+bQzi3U71kRTJWMhqgRfJggpPY4/ixhOlcIZ5o7dLJBcmfqvvNHp7Q/Emt9mSuorxgY8QteoN6lP4Xxi1NFgwfxQGZDstLzHEk7Ef3sxZQrhVEY4uz3SLghFEzDGla0Qe1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfCxGhgeAMmGsKMCKIQFjGTMsYwr/Q+ANHCkhluJ9ec=;
 b=ES923z47//M7IWo6GMpjCFnz8hk+BPQ/V5nBddEwfs8MKqoOvZ7JUfJnLG3UiNdDqA8wJB3jgjXvTBMkWDQcvum5Mhy5ZowO3wlF/vPo8eFjtnZcKbBcw4gL9MbggEA8/TVXe/7IsBzYYtRpuKxXbop71EiUkWguromSZ3aEnAWQkorcR+IEr7x7Q3GrVPzByMeOQZxJ9cHVJ4W2QRfelntvqXO5g9Urj45iR3PWISUoPxrtYGqUt3zeWj0AwaXN5mNfCApmuZykl7LctUwoLRxUPMHmedJ+1rYVOg36Z7Grug6l8hKwq/U959LiJDOtk+dUznuNbqTyPdijx2GI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfCxGhgeAMmGsKMCKIQFjGTMsYwr/Q+ANHCkhluJ9ec=;
 b=BkjgGAbS8MYrtD4irzPQ7Yw5GabCtiClXe2IP9sv05X8eiTMbhq/4LB7lDjuJwhnxRwDN8uGLTSXxThj4i7LoqKPSetXjCrS8JCdh4EL82bRAYPosEK+LbeoGO743dlDXBxclGPHxy34UlpdDm4qPm75AL7wUgHhE3pO442xvEXhRBdXRJoIVNDAQwG4+FXRw+3GrQUAoSsFHrdS5JpZKxKOAJM/4U02/Rmkf7qSKx8lrpqv95ST9ywF7zW6OM9argXyfciCTmBEFR0z7USNJPUcazY2Jr6fwS/5JqdyK4S642zM+lH6m2za5rPLKYypszRY3El3m4Lr/jYyyqCE0Q==
Received: from BL0PR05CA0014.namprd05.prod.outlook.com (2603:10b6:208:91::24)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 12:01:37 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::c) by BL0PR05CA0014.outlook.office365.com
 (2603:10b6:208:91::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Mon, 8 Jul 2024 12:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:04 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:03 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:00 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:25 +0300
Subject: [PATCH vhost v3 01/24] vdpa/mlx5: Clarify meaning thorough
 function rename
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-1-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a9e13f-9f5d-4eac-64e5-08dc9f45b83f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUdFR2RHandJTjZBdmtrWnFRcEtqQWJQQUtOREk0ejEvQisyUXJKektkYTF0?=
 =?utf-8?B?VkE1Mkg3UkdtWGRVbVc4aFFvZ2xGeTZXQm13Wml1NnIwdW1nSnVUeVBoVFFX?=
 =?utf-8?B?ZVZENEd2MHhHbUh1NlV0cUx3ZW1iZ1N6UUZJR01wWHc4WXFpRHZlQ0JVbVlC?=
 =?utf-8?B?anVqQXV2V0JFMm1PVnQrem1GYjJqYmZjelVGUVl2V2xOTHdhMWZMNDdCTklR?=
 =?utf-8?B?T25jS3Nhak1WejZlQ3dpVG9aQmt0NlBVVkM1TEs0VGdDYVY1Unplck9IYTY1?=
 =?utf-8?B?ZWdPVzFCd1lFVkFGY0VjQ21NWTdZSnUzVnJhY0R1Sy9WdlFFbURWSXZ4NzFq?=
 =?utf-8?B?U0pZekxSZitDRlAxZnAvbkdyRTVpYm82OCs2WkxnMXJreU5lMmRqRDMyL2Q1?=
 =?utf-8?B?QnRrZUdRMTFONTJFMlFYTEFUbzJ0ZnVsNFF3bVNyZTVObld1bTE2Sldad0xC?=
 =?utf-8?B?dnRjWXAwZm1rM0NHbS83T3h1RjBuMmtTRGtWTitqazgxS3kwVG1ieUVjdFhO?=
 =?utf-8?B?SXhYNVlNZTBXR2MrWnk1SzhTd2w5WjJSTTUweE95RHV2Q0RKSkVRVDJNWUZx?=
 =?utf-8?B?blg1QUJZQVZtTjBjaGU5YXZ0Y25WMmFxdnRieUE3bTZEVHdPTXpUOWErb0ZP?=
 =?utf-8?B?MkxwTlhmNnhzYVFCUUszZVdlUUk1cEVGUDRaTWtIS3IyVlVYeFVpbUNPdjZ0?=
 =?utf-8?B?ZHFjOXVhS05aSW5hdGE1M2svdVlja2lGSm9VOFBwNTZRdzFtZXRWRGthZ0ZQ?=
 =?utf-8?B?OHcrQzZjckRtVVJ0Y0VNNENDVVQrbytRWWNxdzlwTkVnNGxyemRBMmplQ3Y4?=
 =?utf-8?B?YlNMaXpvUXFaMmQ2NEt0VHBhdjIxbk5PaFYwd1ZQL1hXczR2Q0ZRNWczOXd0?=
 =?utf-8?B?S3h5Z0xrMDNTeVdsRXFBNlBYcDJ0U25sOTR6VG9HdFE5RitsRi8xb0NVZkFD?=
 =?utf-8?B?SkwrNmk0LzliYko1amxjeTArUkdVeEsvdDY4TzUza1p3dlFHdjVKRmFva3RO?=
 =?utf-8?B?b2t0R3pDNGkxNW1zNDk4MkFXdUxvbFE4THFBeklLUDVLLzBOZ3BiVFFCd2w2?=
 =?utf-8?B?eUMzd0lYOWFkRHBzSHdTWHNVZXFTeU9XNTBzbVh5NmVMNTdQMTAzYTZLNWhh?=
 =?utf-8?B?Nm5tcHI1UXVEZml4UnF1aDVLTCs4YlJiVzRPQy9UQUFjWEw5eDRJUGZaV0dr?=
 =?utf-8?B?c3M2K2h6OHk2QzZFdisyZStYb01NTlAxMDlSWHdBa2luQ1YvakV3SFlPbU8r?=
 =?utf-8?B?SHBhQzFCRDRHcEJBTDRrbXFGSDBsRG9tU0hNa1BsdVY5T3hOcjdaMUIxajg0?=
 =?utf-8?B?SnR6U3JmSDlSMktWN1d6L3paZm83SGJ3cStLTTRoVEsvRUVrM21aZDRlMjNO?=
 =?utf-8?B?MzdwTExYV2ZqOUE0WWdVQWhQR1dlZ0VNeitLTHBOTlhCMnFlLzNyNTRjN1V5?=
 =?utf-8?B?OWVJMkthOUFxYVdEZVhnbzBqdllCWGg1MTkxbmRKMGtIclp3SjBodDhMcHBp?=
 =?utf-8?B?YjlUTHZQaDh0cEtUUVkrZURBeHZJZTNITjRFT3E1UmhpUE5saUhQMGx2Tnpa?=
 =?utf-8?B?d2daNUpyMnRrbHNNNVl3c3paVlFsK0ZtWnpoTHJyRmtLK3huV3M4cGU0am14?=
 =?utf-8?B?clMzUGczc2o4ZHF5ZndxTkNMS3dGWXprNmRySEdLMEVLb0c2SW5oUi9nSXh4?=
 =?utf-8?B?Qzh5MEhRMUN0czE0VWVuYkl0UytjRUQxbFJITUY2b3hQTUhkS2RxcjRCOGow?=
 =?utf-8?B?Q3VkZmw5VnhOTGgyVzgyM1gzNTY2RmtOQ0pUd0RRZi9YTE8ybnpIc01WbUFO?=
 =?utf-8?B?bVlKcHowVjNEbE5HKzVMSis4bGpHaWhuTFNBT1RqTHd4TUlmY2FkKzRBOUlz?=
 =?utf-8?B?c3Mwd2VJcWdzT0RFTDBYekZzalh6ZG1NcmhPWDB5dGwrRXdWZURub0NRRVBB?=
 =?utf-8?Q?uOfpQcG0GWjRXKtc9yRu1ZpUXh3+YPZV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:37.0458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a9e13f-9f5d-4eac-64e5-08dc9f45b83f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365

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
2.45.2


