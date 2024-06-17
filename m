Return-Path: <linux-rdma+bounces-3215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC4790B466
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E34C1C21F70
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB413C3CF;
	Mon, 17 Jun 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DuXnVcKS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7213BAC7;
	Mon, 17 Jun 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636891; cv=fail; b=VwW5VLnwwncdJKArOXrymFPuoFW1NRQ0yKTeLYtR4cqfbKp5N78TN2ClIY++niYyya5slD7/yXw7ULxQQXZsdE0smZt8iKzElSzDe/BQ+j+QC72HjEOQFDwcWbiU5ifgb0r0Io66eO+76/SG12Ld/cpaNDeMSzJfZQerLJOTfoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636891; c=relaxed/simple;
	bh=YWdhJgogBZI9hePemvn1Lv93bSWJFDFmtJy2ruKz+28=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KaL39wbf8nEvGp22JVnjHY4zzjqbvlTRnM2dHST/nRmGWK0Q1ZDHs6/GxsSjiUnAI8YKlx0mgw0TRWh3/0C2ZVMcPR1V3EUA2F4xvkqQEy42ykoHaer2Zp1a1BHp8Yc2V9oers7byjMnttl6lif4jXzcmFKL2y+/+zgeguv6j8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DuXnVcKS; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibhFDyjnqn7DdbdbyILsc7MlD4zxD6tsQRdZGBV+ZAhl2mYa/xWGFzdXLxwQOQANdCAEaHhezDzi1Yhu0EMPzgJ2sw2Hv+U+F2bgbG2Kv0hGUr/hhvEwVwa8SIOms9ZvWCZp/y9A7o5NdhazNr1g6wk5cj92kc/LGT+qKqF+SMMFGIy4STXeS11ofgQSdxUopneETkKBH6R8J0kLVz64ZxwvQuNCAxN8IqORvMgigwOQhnD8kbLmTUM1QnyTfpFyNClaS4z6qG0PglKG8B9SK2DogUCJSeXAQykwOb1R+rqhbQ0QYsQZ0hEIXNmSmGsfMdmkz7zvM1F0RnBAF7bUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AW/zOzgsWivt9tbXI0sBGufp4GGJC4bV3kHqhuwyAY0=;
 b=HIefbuEvC53AnRPh57TXltE3mJbjVAqRem8egGarUvSvJsxbFrF0up2zg2XzN2JumQXe24KbriitPYPPxF1XJ3fZd0SsCzjG0po8e8q2bEDSdJWG3M9TMUbqKS8HCXxIVBq1ZdGGQ+qsRDKYIRcb+gH+ow9ocEVGE+CtpyFOLMLjUy9U/5bHwy1oabS78Ad1XavsrzHa/m3tBD9fZT74kI7saJLbS9stXmN2GSoKO0XKJzS2kur82KuDN6UrGREHKmPgM0Cr4Fsnyw7lH5qlAbxgJksE+Q2c3dtV5n3izX3LXRRBHmPtyh3RQJhBdh7qegslBBbHujdD0qi4Ar56OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AW/zOzgsWivt9tbXI0sBGufp4GGJC4bV3kHqhuwyAY0=;
 b=DuXnVcKSITHKXYnPRhjuwpfg8Ech61VxaXPxV48PptJySN+2KkdWvasH3o/bvtLfG8Rw3rnNV9fl5YUIZG2ut8FHsCf/IJNDOWulmLdK/ckS9fIMP0PDb6hXczJtBKPeVkMEu+n+nWS4/xo9SnWQc7/fBfxAypf6uar1yG+WPiHHA9TTq8q+HPrczXjSHurAwfuz8c3Me6WLUSRpyUmsd88OVzCvMsUfAMKBK9gS4pH0uDLGqyP9pUVbn0hRN1aPrxSflDlEBZUp9KkXwtUGF562efUBhsbDXEEOJssz5lNrg3sQ9LX7ldpetI+Mpo/CpW4Z7rJJitNHeVm8jCEhkQ==
Received: from SA9PR13CA0144.namprd13.prod.outlook.com (2603:10b6:806:27::29)
 by SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.29; Mon, 17 Jun
 2024 15:08:04 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::ba) by SA9PR13CA0144.outlook.office365.com
 (2603:10b6:806:27::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:07:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:07:52 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:07:48 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:35 +0300
Subject: [PATCH vhost 01/23] vdpa/mlx5: Clarify meaning thorough function
 rename
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-1-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7de5ca-bbb6-4364-f778-08dc8edf499d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UERpK2JHT2F2Yk5yU3dLYllQNkJML0wwaTg4V2NVU09ZM3U2RkpISkE3RWtE?=
 =?utf-8?B?TEMvK1owM3dDaEdzT21RVktGOUVMMFJrNGhXVEdaUVJDb05IdWRBbDFCbFRL?=
 =?utf-8?B?UUoveVpVdkNIZTRxdFpkb3QwMUxoYUYxMlB6NjR5TldRamtVNGUwYlp1cFNJ?=
 =?utf-8?B?ZU52cW0vY2dZUFl6S3AwRFFPZ0FET0NCUkFrUHlQQ3gwOVlVOVJscjhkMkxD?=
 =?utf-8?B?SDN4dGZVcXZ1elp4cmxVTVhsbEJaZW1vQ2pkSFJISnZVTlVzeklVRFZYWW8w?=
 =?utf-8?B?UTMrQmpLUTRqdVFPNWFtaHNXTTFIeUZLaTRoTURQeEV1YTFNTjZhSjN5SGdy?=
 =?utf-8?B?d2NSdnZtZUlkeFVZZ2xzY20yTEZ2KzFyNVpyNURNZVFhSWlWWWpBQ3N0alRn?=
 =?utf-8?B?bUw3SWlyZFVMNE9uZCtyZHFTbEZMUWIydmMxVDNJaTczUDM0YmpCdVR2S0xS?=
 =?utf-8?B?c0FuWWlSZCtKREg1YUdjbFl6ck56SGVaTjM3N1NTTmhyaWdHNUg5elA1c05B?=
 =?utf-8?B?bzRVK3BQSGFkZXprV1RZLzg2MkRDQ3VzdlBLVGZ5OVdVSGtLM3hmWjA2dEZJ?=
 =?utf-8?B?ZEdJdDJBdUN1YzZPL1hLaVo4bG1MYnVmMGlQWVdJUGVrOUxST25xeUl0cllD?=
 =?utf-8?B?ZmJMTGh0WHhTRHJKSnByWVVKZWprREE5ZmpOekNrS1hnWVQ1cXJIWHMyWUV2?=
 =?utf-8?B?WDA0Rk9EWUEvNXJKWDlXOXdjaGQ4N0I0YzdYaFcvVXdvVDI2ZmJIK0hYNVpJ?=
 =?utf-8?B?UGlSdmRzNFl1RERiZExKcUVpRmR2alJyb2RTSDRlMndGRmJwcFFOeUxXaGM1?=
 =?utf-8?B?ZnBLZGszMFNFNVU1SVV1SUlQTTNhUmg2UGllOW1ja0Z6cDQreTlUdXlZU2dz?=
 =?utf-8?B?KzRmb052TUdYQ2JTbnBFK282U05VWmExd0RDcDR3SmFZODQwY0JXVzVYMjgx?=
 =?utf-8?B?QTYzTEs1SE1POSs1RzFqeDlINDlIS2ZjeVZ2Ky8zOVpSbUwwMlFmQUZtY0Jw?=
 =?utf-8?B?OXFpMkU1eVlyTEV2S1lBSkJkYmFEVFlQSVJPdVcwS1YyeHd4b243SElvQ2gv?=
 =?utf-8?B?RVBsY05PQ3c3aXkwMDQ2WEkxZGFQdytQc3oySTcrTWhKeGhUblFtV21ra3BC?=
 =?utf-8?B?dGdNK2hZb0ZTLzhlMG9rM1VLSUFNRHJHOThYamFKamVNVnBxK1l5SUJITFha?=
 =?utf-8?B?ZkRRR090MjVQa2szMWMvQXN6cTR0VlFDeU1hT2pzd2U4dUVsdUs2NGFQaUNY?=
 =?utf-8?B?YURjK0crOXh4RTRHR0dCUkVVenlrU3Y2Z2xYZWUzZWVWWTJ6RnBILzQvR2hY?=
 =?utf-8?B?VjFjR1ZyYkV0QnNleEM5VHRGK2pMQzc2OHFRNzJKVU5udHYyRXB4Y3k0LzBN?=
 =?utf-8?B?RTFCZlBGMkw2bEI0elpSQUlMMVozdHU0YVgya2sraFFjY3lva29PQ2hoTWVR?=
 =?utf-8?B?bllvUFpyNjQrYUNVYnltNkg5eG1FWTBTc2h2N0RnZnVqdUQ3ZDJSSGlCOXYz?=
 =?utf-8?B?aXVsS0p6MVRDa3lqWEg2RENxV0tGNkFJaVhSRHFnNUxseUF6VDBtZm56TGhF?=
 =?utf-8?B?NDNvakcrMHRSY2dxQ2tnMkIxMzRqckZ0U2I1V3lFVXF0eWEvaGZIbXNyQUwr?=
 =?utf-8?B?N3JLNklmTDFyNjdKM1Bzcmd1S0R0ZHM2aFpPcnFjYUZmVFNTSEFNa3p2QTBw?=
 =?utf-8?B?djFBYTF1Q2tvVEtpRDJDbHB1eHpNYThqT3FOelRyUXhPWnFlV0JHUVdDUG5l?=
 =?utf-8?B?d2tlaldVWk9MdmIyczdFbzlBVVlaVDZaWEhjOWZWeTVhekxqTFd5WmVBaFpq?=
 =?utf-8?B?R0FJQWl1c044Y1FmWGJJMkw1ZEhRZytyMkhXYjA0cHFRMUJxYUEyZHVqemxI?=
 =?utf-8?B?QjhwS0orenI0NC9SamRTT2xta3NucE5xVHUvYTlSVGhVSnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:04.2302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7de5ca-bbb6-4364-f778-08dc8edf499d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893

setup_driver()/teardown_driver() are a bit vague. These functions are
used for virtqueue resources.

Same for alloc_resources()/teardown_resources(): they represent fixed
resources that are meant to exist during the device lifetime.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
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


