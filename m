Return-Path: <linux-rdma+bounces-3499-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004D7917DD0
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D9D285A82
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8F317E45E;
	Wed, 26 Jun 2024 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="brtJMiBs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A5A17DE02;
	Wed, 26 Jun 2024 10:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397637; cv=fail; b=M+ba43QrrqeZGRFwu3ThXwF3VN3zbbS+ixYq0om/WI2BPg6rxfckY71KErRHHkCJhI3SA4w3NeY+oY/D5tJ1rLW5aN/7gFfsq4T0lq4DVhy3CtDHLSvSY1ZlJzx7OtaRf2FaMbsIvsgOQxKVV7fG1qC3iB3o2l5B/tv5iUzfXIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397637; c=relaxed/simple;
	bh=0xyUujEt5tlp/JGtbLdkTmvJMn5GpsoNwlG+zuN1A4U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YCJhpCY8NDvCwF3LC3yzK3MiMNdy0XecksWUV4xcXfzFUFWWUYend2fT5C99c9QB76YrUp2KcaWIGbdexaRP6V/uf6iO/jqfHJBkz8/7k2DkC8vSEKlpeRC64aKT5S5Kz2fou8PqNxI0qWmZVE7J+AAv3c118L+RNtvRn8jhSig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=brtJMiBs; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFT9IfDSBszZRSrTNDq73Hpkvb7cnky3UBg8cgXCRoQd73U0Fx6gkIGeVGr9oFNBpURtF5wVDSLE9xhYc4b6jFFIzhxSgDksuwp2lmonySinoHc5xmp/2HKAwgXYxa120yZ+YUxDUoqmc+Sn+lzxXNueJ++l6U3vjkbQIgyVDWHdm4vOsry8M3FThYO0Ows2TC6YndVnkNb6T6FbV8+w9VBrx0vVeqBlM4ugmUhhSWsxaGRGcNOYQeEIVPZ+2BtDLGx8Zi8x6v/5BcMSkdKFXGcA9BAnr9B2Bu/9bn/q1je/VYhiygyf/PKnhgR01ugrhXO9n/3P2pJgCpidMWt71Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqqdoPA11rvLppM3bcAIiQFOvnyc7bkbAU7AC+X1w44=;
 b=KjXfDzmyRiek7agQL2WCGqPRgpdpbB6sgdL+Hv/3+QFjXE8Cw2L0mt82u8oWPwi7WBjZ/lF++NMtaKBTNn2SMgjKjWXTFF1PG0txQ4Ooj55k7wfbZUrpUub7tUhsrksvmawAhNvmHq3YcHa33VZlu9FQGv/Lpx69PXezwDj3oQhcmwTFy+qBUmiWnY0503IWZ1tSYDY1wRUDur/jXC158gxbimKank3Pa4mY1wU+zHE7CDwxC5OneEOHqumDLqrBhMS2BPCx3H1VUka/OxXUEkQMSsl1ejtYR+fx7tlNjbFQNwLIFcKOpcxtyKv2tRqYlaMvYTdztuEOGOg03bSU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqqdoPA11rvLppM3bcAIiQFOvnyc7bkbAU7AC+X1w44=;
 b=brtJMiBs5F/7Ol0/HgwlLrGiCaJGN5RgdLTPSc02nlKeoUS96FpcUmcRwn4ncYjlENXgypuxSU/akNgCuCiAeOXpgzApWNvJioaTaZp73gAWO7RxWje8MXffzUoR16kUP6YChWgxks/7ZCosoX3wRT9KLOC+L3RV6BCJOJcTc4Gw11oDpWGAlQOvSjp+B/VFanjDgnz3uv6ZUsxJ8C4CghUTzYHAvnQ37OXLe4TXMD2oAa9sSeCur0elYSA5SyuS1j/f3zvlDDcLPRkDx6oZImH/oV99Iz6FYhm/4xjy3iOB8TQZMA+p5LJA/714V5oY6tONZKJ0UiNhvuPqUWN8Uw==
Received: from SJ0PR13CA0096.namprd13.prod.outlook.com (2603:10b6:a03:2c5::11)
 by LV3PR12MB9331.namprd12.prod.outlook.com (2603:10b6:408:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:27:12 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::1a) by SJ0PR13CA0096.outlook.office365.com
 (2603:10b6:a03:2c5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.18 via Frontend
 Transport; Wed, 26 Jun 2024 10:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:27:11 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:26:55 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:26:51 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:38 +0300
Subject: [PATCH vhost v2 02/24] vdpa/mlx5: Make
 setup/teardown_vq_resources() symmetrical
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-2-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|LV3PR12MB9331:EE_
X-MS-Office365-Filtering-Correlation-Id: 25333384-52d7-4e79-2ca3-08dc95ca8a8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|36860700011|7416012|82310400024|376012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXFwWjM1NUJOeVVaTmRDZkNVU1p6WDh6ZjJESGJtZDBPSGxFcldKcFIwWjZO?=
 =?utf-8?B?TTBhS1VyVjlqcmVmbkFNVGFqZXF2SzNYWElvQUdDRUpYazdNdndna0dsKzFO?=
 =?utf-8?B?MVJMTGx4L0cvVXJpTFVRRGtGeU1PdGhRRHlZZzlwQ1l3SUxVZ2FwcENZNmsw?=
 =?utf-8?B?N0xVVkZ3cU1OQk5CZzFrZzczOXZTejdtQXZvR1FFZDREWmtXL2poTDVDMTZl?=
 =?utf-8?B?N2djQlUvSW9vdllQb2VmVzE1MWJNdXNOOURsTjVKRVQ3eWVwZkZXeEd2UXVI?=
 =?utf-8?B?cHpkeFJiaUtXbHhoKzkwWHVaMll2VXJYcU1WRHE1VFA3Q1ZmS3lJSFo2VDhs?=
 =?utf-8?B?MTJtMFFTbXI2NjFSbUU0WHdaNDBUOUQ2U3FHS09IVnlXT0VzN2N5SFpmVVJm?=
 =?utf-8?B?bHdJUEx5MlVEY2V2R0Jlcm1aMHdjdHlPbmZxS2hTWmc1MC9nS3JBT2p4bk5i?=
 =?utf-8?B?TEluUHU3eEtsQWZsd09FelF6Vng4T2hSbDRiV2xsdnJOQ0U2U1R2ODRrMG9U?=
 =?utf-8?B?eTRwVEhiMXY2emVtVFQ5Yk81MGpMKy80QWM1elZDdVJ1a2NpNU9RZkVtNWto?=
 =?utf-8?B?cVU0dzBwWTFnR0xCbG5Odlp4bjBQM3dzcmlxYjhaOWx1Smt6bHNOM0IxbnQv?=
 =?utf-8?B?QnBSMjhTT2RSUzdEa3JyT0N3N2E1VTlzZDY1bFpVTkxWNU44MSszU2kwWkpH?=
 =?utf-8?B?U2tpcUNsNlJaRkxMTHJ3MDNPK09vUFFQYnZwR1VVMEp5OEZsNHJ6ZE5kUXlY?=
 =?utf-8?B?RVM3aHMwVHJ1cGhZYlJjUzVvM2dHVWllSHF5cHFBSnM1Sjg5ZnUrZTVaL2dw?=
 =?utf-8?B?azlLcnoxeVVzajNBSHkxK0hHdnAvcEtMNE9hVC9BU0lqS3hQSXgrdVBPMzFT?=
 =?utf-8?B?d21GQkxiUzBiYWhNS3BCeXp5cnJLdnFiT2JBMVFveU9qV2NTWmpyWGE0bnlh?=
 =?utf-8?B?TFMzZThGQmZqd2E1bElxejFTQ1VoZmk3U0NlY1FPY3dzSGRlSktRRVpGbEIr?=
 =?utf-8?B?amljK3lmR002ZC9pZmtnUFZEV0dmNElPZEZJQUVlcWl1TVR5MGFKZmVLdWM0?=
 =?utf-8?B?ZnJIMDdITkpkU0VuZS9qM3hJNUJCOTRHa2hUUXlXMzJFdE4zbDljRjdZMTVq?=
 =?utf-8?B?emxmcGU5MnpsRTRleitvT1J2bjJzSUNnUDNOUXppVGtIR1pHMHpNZUc1NGlG?=
 =?utf-8?B?OFc4Q1U2cmsvWFFCL3dvU05kSHJnLzRETkVpOHd1UHFWWHpmRGZmSTZiUDJ3?=
 =?utf-8?B?dTVEV2U1aDhndWtUMXhZNmk4K2VEeHFWVFJBL2tvSStpZ3Zzc2VZNXhSV1lV?=
 =?utf-8?B?cXdZZXVzR24vdUo1cTZjY0lOSXZtdUk3aUE1Z0RrNG9ZUTNRWWNQMWFkdUhR?=
 =?utf-8?B?aG9BdVFtZllXdldFTTlTOUpYTWJVZmJPUEhCUEFVaEZkUlhRbS9rR1puMk1u?=
 =?utf-8?B?eERJbElSREYyRUpPVnBlRzM2aHErcWdHb1JSdVJ5STUyQXluWXcxWDMxRjJU?=
 =?utf-8?B?V25KeWluZFM3K3VKbC95V0YwaHN5RjV1VGdjS2tCcmhDaFpQRW5oK0xqWG1m?=
 =?utf-8?B?c0FvQ0FVRVc4OFVEK1JZVllEeHBQWWUyL1huUU9VZ0tGNUpSQ3JIaGplZ0Vp?=
 =?utf-8?B?bGM2N2MxWkRtSDlpTVkvVHJUd1I3VXdJbkJtS0xZaVYxNTdjQkhleURvcDJG?=
 =?utf-8?B?RHh4Nm9GYlBMWW0wdkJjZEx5UjZ3U3NQd2ZVMDFBK2FDR3Y4aSticEVYTGp5?=
 =?utf-8?B?Qk9xNHFpWVNWaFBUYXhWZlZVQ2xNdDFsLzF4V0toWW9FbUd1WGE4Q29vUDBM?=
 =?utf-8?B?YlJsQ3V5QXNvWVU1L3FsdExMM2dSa29PMjQ0YlEzMFhxZFRVVldPelViUWR3?=
 =?utf-8?B?Zm14cXB0WFpUS2tXVThZVmRJTE9oRVg4QTRtQml1bDkyR2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(1800799022)(36860700011)(7416012)(82310400024)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:27:11.8761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25333384-52d7-4e79-2ca3-08dc95ca8a8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9331

... by changing the setup_vq_resources() parameter type.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
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


