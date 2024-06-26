Return-Path: <linux-rdma+bounces-3501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEC0917DDB
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D661F257DC
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CBA180A76;
	Wed, 26 Jun 2024 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ud6SNkNy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81AF17F4FF;
	Wed, 26 Jun 2024 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397643; cv=fail; b=ctqw0TCkcLdxCPcugynlmbqosQH6r34hqBBwl5pNl6jpengZqTs/PrUHvAdkK1HuON6xGFG8/MuTB8LkhfaB5fhjfJkv+833e4I1Y3PSWdK4zFlNFtno0wIe7N4Wg94FLnw5S8chJzcg3V7r6sWbBmaTbJaiimZflUgn204FEFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397643; c=relaxed/simple;
	bh=V+c11mBEvPiAb+ZonFLkKZHZtjCSpTh2ODwGbDP26mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c20WJRyB7kbTXb1InBFzkZzn51jHFe4qnyc3CATtc0nXZb5UMVUEm4JAf51APN7GHByhhJaBr4hRkqBxsfnH7oduUaAwq+iDn35+eC3aWfBzVsdYERFiCfXUvqvLHyQHHD9ALHdXEXlQYDMZPwPlL4yypCxvcIz7r6e0C/Jvfws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ud6SNkNy; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWPobb3ZKHgvXcJZRqEdC03Ukjj06a9RL4ElG48UBZYMkKnC4j1ewv2vfZ4X19ZVAg20dK+XXzXfnZJC18N9LsAVvGSZXIS+fwxiUBciUkAkrtQy+2sEEpuodDFktRGfVSern/Nk0oBV8i8UR3fs6Ga4CvlT5BufPT3Nu8vCyjDzLIpj160UX24smIyi/ucAu12dQJnWG+Lb/d+jgFyuum5PD8rv9qKUz1scTeGbxTRC8J3vPYhd+p2sIsupSqpYtQAOnSKE4jTXxEX2A36fRT30+X6W2s7pKCtiehoaq4dVzIoQQMwvfU7g4xtxHt5QK0F5RKa6xAkSEtseNCfrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddVcJoq8kA1qFbvpzC/tVsyBvkhF/IiAe0sgs7JJm9g=;
 b=LTlalrtExmB2qFR2OPw0HV/BDO5NM/kY2yFgbLh5XPqopFlnqwAq/dHwoYEDWS5u5kT545ASKHO4imz1IYFgjWk+tI4tR3jNXujZKUkX3h0q/2SbkQHKVx9jZWs9q01diyfXiR5AgPcTQchWLWPOoMbW0n63i7uKl1jcj9+d7a9fY6QR50RXC41HMc+H70H7MTLaY6NAY6vBE/qxz6wjrUtJz8etksbkU9TMBo560/SooEt/WxNLCEZNT5ulYc6uUSEpgbtNM2lLtxx8VuyNf/9CWTC4w7jFYNU4r8NEEJ6hFZpI3PvaCUZlUS0csAEoaWJZplR2moXM+Hbd4c3/RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddVcJoq8kA1qFbvpzC/tVsyBvkhF/IiAe0sgs7JJm9g=;
 b=ud6SNkNyiC3jxncEm61Ez0PXhbz1h4EJ6RKkWjOsEdZUaLjfeMXNEoNlH8sKT1WAgPJHYKgjdd7ZM+R4ApNEYLRxbEJwOf+L8+Xhzls625dKYMWVm7/CE8Jy7w3DUx5NNrDqpPdrYczFKXwtRn5cMdwzVLmn5OhL4V0jKmOaVRM0N7miIOvVtcSYwBJEh8Xa4h4/3efLnJyJAH2Tmw+ryaijeZE0OlE4VgN+BtS8ILHeZNfogBDBnmGdPHOxB0SDaJlES6xVcOcDfUJXVvfHq4CYJT5CJZk6fAF1FJkVZuQSGdY4erh1xy7QQgF4qeL7UTyiISGb62oK/Dnr6TIIww==
Received: from BL1PR13CA0421.namprd13.prod.outlook.com (2603:10b6:208:2c3::6)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Wed, 26 Jun
 2024 10:27:16 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::9b) by BL1PR13CA0421.outlook.office365.com
 (2603:10b6:208:2c3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:03 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:00 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:40 +0300
Subject: [PATCH vhost v2 04/24] vdpa/mlx5: Drop redundant check in
 teardown_virtqueues()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-4-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 34aab502-e7ff-4585-770a-08dc95ca8cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3kzWmZib1FiRU5pdHJJSGgvd01VTXB5L2ppbGI2SkJJK2JENHFmbGpJOTIv?=
 =?utf-8?B?ekxIQU56SXJwR2ZKUkg4bVJJUmwyWmZIZGF6L1d4azk2M3k0M05IcnAzTFhQ?=
 =?utf-8?B?cVVudUhhR05jd1hFNVcvV2VaWlNrdmx6aWphS3FPUTgxTUEwSUh5MVNhRjl2?=
 =?utf-8?B?ejhSaHdxQjFKdDAyNUh2cjhxcmlqS3FxeFUzUHR1cmZiVTVEZ2R1YTRUTjgr?=
 =?utf-8?B?MXErS0JKRGtvS05HanVHdmdVa0d2QUtZVTJDZFBGYXdQdWduY1JOdWdLeDg5?=
 =?utf-8?B?M1dtSk1ObUhmS1grYkhqNVRCWWhXSDhjM3Vzdy9FUzRpempDQW45Qy84cWg1?=
 =?utf-8?B?b2krREloQTJlVGlwWGFsWGNIWkxqMk5lc2NVVnRQbU45RzZ3Q0ZwdmYvZEY1?=
 =?utf-8?B?Z0FFQThRdXliT0dQV0plc3NXemdJemg0b2YxQUJza0ZRRjBqWmZIUXBlSWYw?=
 =?utf-8?B?cmJ5bU8vY2p5bm5DL09LMTQvT0VJMUVaY1dIb0JmTDYwdGtsM2dOKytPeXo3?=
 =?utf-8?B?Q09rMzZuMTBLeHVkWTRtS1dsa01nNlB6VCtTOHJSTkordzJIWGVRdjR4MU43?=
 =?utf-8?B?Q21TWFBCMUowanI2QkJXaVFLNnZ0Um5FUkdvVjBxUHBnRy95ajdQOE9QbUlP?=
 =?utf-8?B?YVBsQjJmbXNMaXh6QXNTZGgvVWg0KzlRYVIyYnJLWFovd2d4VlY2WmtqTzgr?=
 =?utf-8?B?OHFlY2xrY2dJS3NUOUNCVFJPUUlFYmFhTGhMMFc5aUdKOFU5OHBDVUN3S010?=
 =?utf-8?B?b3o0OUVRZTB2OVJkYWhTV2ZJUVBWWHFYbi9pSmQzQ0pZMDdtcThNdUVYYmZt?=
 =?utf-8?B?RjNBbU42VC9uMkptWkR4Vmg1WkV6ZWJidjhtTEdmQnhUaWRxRHR6QmxITlhy?=
 =?utf-8?B?VkJFY3VheUtKMU13K3J2WEJpZWUyeWN6eFc5UmFMRUdCTExCWmYwVURzVDZ1?=
 =?utf-8?B?bkxZMDNma3gzaVYrNXFGV2JqWU1OYW5SWkZtUk5LVEEybGtJOWVaSnJMTUky?=
 =?utf-8?B?emJSaEsyL2Juak5tTVdacDA2NVIzbkJ2WUNPcEpaMWU4Q1RRcjNyRTc5N0ZQ?=
 =?utf-8?B?L05CbTAxSXNFTldFa2NLTnBRYWh6ZkxCTE1aV3BSa2lTVCtyWWxUNjVzNWlO?=
 =?utf-8?B?SmVjdXhvRUU3aDRzWW5FUDlxaFBzRElLNTJmWkU5VEZMN2NRcHVTR1ZTZXJW?=
 =?utf-8?B?Y05wN2lGYUFaZDhoNHVKYVFiNWUzSGRIWjdPNEF2VFBDaDliYVVRT3hYYWQw?=
 =?utf-8?B?ZzhHRlZRc2pnTHd2NTE4cXFCLzZXdjlOMHdCWmk0SlFnZVIzOUVSZjdObStR?=
 =?utf-8?B?cDRYWFZaWHE1ck9CRkxleEdsd0piZW1TcVVvL2ZJV0Ivd2I1dGMvRkMwczd1?=
 =?utf-8?B?Wk42UCs2bWFoWEtOQjR4VnAzbWpVdDJ1L1pQeWtGZkEvN0hSdXhXSkM2NnB2?=
 =?utf-8?B?a2pDaEVaU0w3ZEhJdU9pQjFLRlJZSkJEU0JqQTNUT3hJTVVuT0dGM3J5Q0RG?=
 =?utf-8?B?b3hiT2hPY3JINWg3WnQyamc4MFQ2ZHlpeFRaZjRJUGlvZEo1RGlGRC9KNVdF?=
 =?utf-8?B?QkZINldhUE16NEdScXU2QlFWZHo4QmsvV1Q0SGFyWllidVhvOVhnQ3pkMW82?=
 =?utf-8?B?dC91UkdOeGVqMTc4MjJTaCtiVnpwUUdZNUkzdExpM0VYcHFIVnN2SlQwOHh3?=
 =?utf-8?B?Qk9UeDFoNThQTG05WkcvaXBJVnlodnZ0U2c5TUNuTzdnYUcrbEQyczZnYmMy?=
 =?utf-8?B?NTNpUUI3cE43Ym43Yk9WT2cxL3ZZUHk1N1YzRUh0QUJFNVl1dzZDVGVVbnow?=
 =?utf-8?B?cldpMmZlSjBhOHkvZTRHUThxRldaVnFpMzl1QXBPc2Z3KzMwTlBBdDBoclY2?=
 =?utf-8?B?aUZrSVNuZGpxV2JRQkRwRk81UWFZM2tXbi9ValhNZW9tamM2YXNTOWVNUHl5?=
 =?utf-8?Q?kVfQH85Utx1K9FHyzLVC3Gpu58MSVL7q?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:15.9140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34aab502-e7ff-4585-770a-08dc95ca8cf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273

The check is done inside teardown_vq().

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index b4d9ef4f66c8..96782b34e2b2 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2559,16 +2559,10 @@ static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
 
 static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
 {
-	struct mlx5_vdpa_virtqueue *mvq;
 	int i;
 
-	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--) {
-		mvq = &ndev->vqs[i];
-		if (!mvq->initialized)
-			continue;
-
-		teardown_vq(ndev, mvq);
-	}
+	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--)
+		teardown_vq(ndev, &ndev->vqs[i]);
 }
 
 static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)

-- 
2.45.1


