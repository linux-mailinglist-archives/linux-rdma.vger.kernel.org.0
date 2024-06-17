Return-Path: <linux-rdma+bounces-3216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2551290B46E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FE621C217C5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFF713C909;
	Mon, 17 Jun 2024 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q1DqKb2w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2055.outbound.protection.outlook.com [40.107.102.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA013C835;
	Mon, 17 Jun 2024 15:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636897; cv=fail; b=F1z3PG9v9Bar/6CYFf7OdSKE+JjhKexVlSeYZ3Y9pi2I55ZD7DmxecWKHbnXQxjbQSdGCGexa5S2/GkAxWdTARW8Sgeu7gjzFGXhjeLuzjCvI+PvCCZc6gxiUDP2Bljufa254sMnU0d2zIREKVDnfYRB9WBzvwwQoA++kp/ErdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636897; c=relaxed/simple;
	bh=fXevU3hdj0JvO+58iWTjO4mWUEeF/0S08VrGg74MY1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=H/8iPQpILikxfsGr9dZ/3NEn11khk1hzcQZ2N3jr0b2ehCTKXOLKBG/ZkJhcgAAyujmNz1F7P0JsQ/itsEhGK7t+xYfC8TLGT6XexyNnJSCRE6wYicsixJU3NKe83lLpN6kO+0hhdaqMVosK3AoTppGPYr+JTSNhs1M9zVTrGmg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1DqKb2w; arc=fail smtp.client-ip=40.107.102.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgMbU8Qm3E0WrBEXmk/1UBhg+y3flMMlbsW4Uurs4bDwkGGdJfWYUJiaI776dX2iat80JfCxTjA/MInkVOsP47U0r8oZ4Lt1QMsoY3lZohZ5262CY8/FkId2gCfq5tpI8uOo1pJUZ0fwYR5gyx/0bngzY5uatEBqkBhs/5Z84eaSjiD6MSOSwlJ3yU3SLLZexBG2TSMPqVMfI/qII7/+gIxVlL8Xi1wYIjpDSJypiecmpUa7FxzalnREg9PCST3JhkLVTb7w7ihY93ShWlYb/RpnwS5hQqyQzjXunsHPeVNJhrVXk9bA5YOpz4AkZLiY4aYj185f4pMlaUyBKi8hhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1GgYmuetoGlnCnxjBm2rDm9Az0PPDqZMoSL4OCPk2Y=;
 b=WVW96CrriNpdEWvBdfv57YprsynlNGWrKOXUoK4AHfHfDdNYwrBggPM75WawhWjg5b/iUKkDvN7vJs5248UKeitfo0DsGacQHvUQKIDCUuKXFlSoXt4+IXIXPnJCsNGOKIeRDwS5v39y+954Qy7rooSXXHEY6L8IMPh8c+7vhN5KAf53nC2DT7pxMHk9Z5G/c35mCto03aZu3OIaulrf4zcMk4X82+dlzDj429ar2zNNY6XGCKt00HOBB+degjgntRNQeOhZBZcAcuiDHsvyYG5SMRzM9d3snD9EjtdggTlmdOoAoURcww6fKq0xpmfp1M5ElU2vK2I8YzyYOF0peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1GgYmuetoGlnCnxjBm2rDm9Az0PPDqZMoSL4OCPk2Y=;
 b=Q1DqKb2wDbu15JVFMeT+xzaVI+s0g7dRn5yBYN5y07zTihoFiOG7tlI+Vm7A4oGyHu+4LWlH4dqy0/KUy+WmwxBrtjO/yLQQg7oIL3LXRhhWNXb/Zi9vk7QSJFdQ/FM/mH+QIAhNbn0CR3viVTEw2RF2h1OP1pK+p+tYneNtBRNCHzKfZtdYpK7dAVLPt50mVpRxZ1fIQwi2qhsnu7J26yBBib3OtC+K8xbLDdG2nEkJmMYMb0VToKTq0L3iAlLv6cyNeuUkVN1mz+lG29GDLPVr6njXWCmhPVQ89hwmRLaZM6SjwndKXqVo8Dw+sfNsLlxWArChSZq1u482F2DdGg==
Received: from SN7PR04CA0081.namprd04.prod.outlook.com (2603:10b6:806:121::26)
 by MW6PR12MB8833.namprd12.prod.outlook.com (2603:10b6:303:23f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:08:07 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::b4) by SN7PR04CA0081.outlook.office365.com
 (2603:10b6:806:121::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:07:56 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:07:55 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:07:52 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:36 +0300
Subject: [PATCH vhost 02/23] vdpa/mlx5: Make setup/teardown_vq_resources()
 symmetrical
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-2-8c0483f0ca2a@nvidia.com>
References: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
In-Reply-To: <20240617-stage-vdpa-vq-precreate-v1-0-8c0483f0ca2a@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?utf-8?q?Eugenio_P=C3=A9rez?=
	<eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu
	<si-wei.liu@oracle.com>
CC: <virtualization@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
X-Mailer: b4 0.13.0
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MW6PR12MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: f376fee9-d15c-4477-8cac-08dc8edf4b58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|7416011|82310400023|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGRyRmQySW1hS0pqanlnQ3k0UEdBUXpYb0FQZElDZ0NlRTV0aU96TEhlYWdQ?=
 =?utf-8?B?ZzZKSGF4UnIvVUtxcFptaXFia3BnRzJXTkpnRFZBZlg5UURTVS9tZmRmTXV5?=
 =?utf-8?B?Y21vRnhwcnhnRkZ1TUhzUE1PTEp0YWZSM2lkQzBDaStPMEtuY2JBUHVvNDYv?=
 =?utf-8?B?ZytldnlhRURaZTFDem0vRVlhSnpnRGNNTGlQV1pldVJVdmExQUQyaWk2UUk5?=
 =?utf-8?B?WmI1VnZNcDc0V0JKV3RNazNUTjVNNDI2OFp5WFczQlowT3NkRzJTQXJzdVVJ?=
 =?utf-8?B?aTNzeGVkYjZPN0k1WlA3TW9xaVVEQmNBVGliblQrdGsxQ3VBc1BrdmlOZ1RI?=
 =?utf-8?B?eWEyVjV5OUNXQW9WbFFtaDJlL0RNRlVERTVyU3lPZHV3bytZZkoxOER0cXQy?=
 =?utf-8?B?S0RpZHQ5UDBtUi8vOEFOc2JFYjlxSHRRdG1oN0J0Z2lSRHlIQm1iOXUzSVNm?=
 =?utf-8?B?M1VZK0lVK2R6ZHpVNG9yNzM4V1J6elUwTVhleHZSRFcrRjdWVlpvV3BqVE1r?=
 =?utf-8?B?bC91ZTZaTHBDMXcrMkNIOFBTaGU2WWJSTi9rclJUbHg4WHRJUlJtbmNJMmFh?=
 =?utf-8?B?WWVDTG95TG5iN29rck82OXFSc3RYV2pnQUdzZkt0WW9aSWJUVVdMVDJiUXZj?=
 =?utf-8?B?WGlyYXRBQlBRZ3FMQmI3S3h4N2xyN3dvdU5uUjdnem9CbkM2bVVqTDZtZ3Rt?=
 =?utf-8?B?MnhZcFVUT0xLVUcvcERLeW51WTRMemZWUHVpeHlXNWcyMVowQ05mK1J0NTI1?=
 =?utf-8?B?cDdQUDZVaHE3a2hpVkozckREMFpMSFlRNEV4bzlPUUlMOTNvQlZxc0Q2c2Ja?=
 =?utf-8?B?Y2lLdGlOWm5yMi8zaTFOL0hta1RyNTFRbE9WYVQ2T0x6QmRzcmVITHhhaUUr?=
 =?utf-8?B?WElkR1pJcEUxakNiWDFBeVlCMTFNNjRCTEZBT1M5WitiTDFDUDZJY2Q1N1gv?=
 =?utf-8?B?WlNzTGlYVGp6U2xES3o1Y0dQMDQxbXBrSjV4b29nSEVzeVEybGdGaWExSFFn?=
 =?utf-8?B?MERFbWlkYStTNHUyaVYrTy9iMXBjOXRFU3NNbFBuUUlLRnh4SGZmRG1tdUsy?=
 =?utf-8?B?NDFKQktGSE9XalJ4bjVzdFZoNUJ5QmxTeWRNa2NMYVMzMGZraXhoSzFuU3A0?=
 =?utf-8?B?dlZwT0ZJVTNEa3dyN1VEeWttQWdZMGYzQ1QzSEVwQ0FBa0JVMVh6SlJtTVJh?=
 =?utf-8?B?NFptYnZIeFBqdUZjUnVFS1FKWXVCNFdiVWxxVkQveEJBenF6SlRSOS9peTBj?=
 =?utf-8?B?VnZYOFpYWHl5eTVOTyt3bU8ycElBK3RlQzVTbUFYOHN2cUplQlQxVU1tK0lw?=
 =?utf-8?B?TVQ4MStHcjBwdWFmaVpjOUl6NjFERUZHR1pwYmIvTXVlU0hqZkFDS0tSOUx2?=
 =?utf-8?B?SU12NWVYRlpESFoxVVFBL0h1eDhXR2E2Mk92SWZSSmFBNXd3TnE2dEFxY3hG?=
 =?utf-8?B?RUFvbTNkcERxdkVVeE1MY1dvSitBY2VMUDdVSm5NT2h4aFV5c1ZaTUREYkxG?=
 =?utf-8?B?WndvR2dGTEM0ZEpDd3YwdjlrdGY4ZHcwWHZWc1ozZWFUVGxDWEROdWVseWlG?=
 =?utf-8?B?cG15TnZ2SDlLV01HbHo5VEN5QWRnb3JzcHpSMSt2QllzbC9lN1BwL3pZeWVt?=
 =?utf-8?B?Q0ZyMi9aRTI2eVJBNmp5MHFjWldqdjFXQkdZVnZUQ3Q0K2FselFUb1RWeGdQ?=
 =?utf-8?B?YzBmbzRGb0p6SjYwek04MUFnemRRaWVmTDcwd05Tb0lMejIvTGoydnkvVXQ5?=
 =?utf-8?B?U1FzaHIwR1k4QjgxV01LbVdNdW95ZWQzbDR1dWpvaGZoMEIwU1lEUk9pK3RP?=
 =?utf-8?B?dTI3VkFLRzIrYWRLZ2RPTXJyYzJqZW1SM0pRUDVESVMxNENoZXhJU1E3MXR5?=
 =?utf-8?B?Y3lscU1XMktiR29WSVpQRHp5SjZtT2VtWTJxSXc3dGdJWGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(7416011)(82310400023)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:07.1307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f376fee9-d15c-4477-8cac-08dc8edf4b58
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8833

... by changing the setup_vq_resources() parameter.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 3422da0e344b..1ad281cbc541 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -146,7 +146,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 
 static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void init_mvqs(struct mlx5_vdpa_net *ndev);
-static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev);
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
 static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
@@ -2862,7 +2862,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	if (teardown) {
 		restore_channels_info(ndev);
-		err = setup_vq_resources(mvdev);
+		err = setup_vq_resources(ndev);
 		if (err)
 			return err;
 	}
@@ -2873,9 +2873,9 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 }
 
 /* reslock must be held for this function */
-static int setup_vq_resources(struct mlx5_vdpa_dev *mvdev)
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
 {
-	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
+	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	int err;
 
 	WARN_ON(!rwsem_is_locked(&ndev->reslock));
@@ -2997,7 +2997,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
-			err = setup_vq_resources(mvdev);
+			err = setup_vq_resources(ndev);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
 				goto err_driver;

-- 
2.45.1


