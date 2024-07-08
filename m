Return-Path: <linux-rdma+bounces-3731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C60E692A1FB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252A7B222EB
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BE78287C;
	Mon,  8 Jul 2024 12:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ih1npZSt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3366613E033;
	Mon,  8 Jul 2024 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440135; cv=fail; b=lxJIT8i7sf3TPUA/jpFbbHsIipNkGFG9g0ZGYnFeuPmZ9JFgo4SASYpgGfe1Qvg14kN5fwsoiz0fUKq6Hsiwih5+zsY26JsPssEZftQSzMAYI/se9/uPrO82lnOT59tGuBtYUj+7oG+KPAf7EOylIcvenLyJkULyR/+toShbq7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440135; c=relaxed/simple;
	bh=HZPdJHo98IJDyiIE+59nkgVbHCaUJjoE88a8e4zhErw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dh6+w64qGelwZ1muIlWUf0512bm/e/Emyy5bYYIfIN8pZIs8CE6Ehgzl5Ke5hT6mVK7A0jR69kVYTS4VhUGywaRDBHH17b7XXW30JUhQSk1ID/i3Kiy3XiOobgvsiqrCVklhgmESf55JcA3BzsjSW6Nurz+fc2cafnbS0qH/vts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ih1npZSt; arc=fail smtp.client-ip=40.107.100.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI1JQnOxOwRuoKnQ0sn6LuOBaZXCrJNzchsfc9YOmkMyVRcxJRrKCV/JNzPBo2yXeLL6u88GFKNbk0ZNlX2TRABVBhue9FD+q+Ggcb/4Zyrq0ow9gM55pACmQ4SOd1AFI/s0qEJTHut5e86hMz8+TjyW2viGN/CTfER+84noxGqmffhJcNmD1rQokb4scwJK9PMGMnS3HW3s4HZWOwh0MEbyy+BcanRSsL8ERaSg+/+px9v54qc0Sd5SpzsxTfTJmxlrevvJ5VKL327xADnzaivwrMHu18osCThe1/BabHV55q/jqkeZuIcLsieKwtIsAsiBIkqLB1/artSp+HnetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cREcdg83i+E91FcU03gHGtmMztmDrz+EkM71cwATqWE=;
 b=gl2eks/8XwM9ZUiO6CCLq8Be9ZUl/cSrXxMvSbDi92prBZLqmfUqygljAF8ZipO1BmOnArGkZTy7PuQEw7jUVMhymEkbKJZBIvKA/x57txcaVbuszoopMNaM65iR7R3CtgUIaf2tmWwE1dPaVZPqfbMMrWBy8k4/ptpYqlSzZZUEV1waYUkxQGzzT8uMqucPe64kfDE7tmKQL/hBqhBexP0j7t+a8FyI9sFeZQr7i6tl9LhmYx6xwiQdsQiYpvta7pQBT3wV92Ay+120LvLExVCTbi7pRizILWWv2niOpJUwyBaVOCmJpFT7xCHkRsfxBi4MPjGyFzpRiiWHU/xx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cREcdg83i+E91FcU03gHGtmMztmDrz+EkM71cwATqWE=;
 b=Ih1npZStdL0ipL36df7pqXXdPHSxQshSyZg8EEeERdYvmCI9rF/pgwNRmrvaN1EIqeI8a3dxbnJQeLFskyoWW/y9b2idHs5YglsQUxVUgAW7tcV9L/ZZMippvGT76rb/rPJ0DgM1Ohd1R0mORJPcAHu6fWolN3Wqgg8SH3EwK3h41QHx68lwej+dnCzPwVqJMGdCMI8GRFSPzOFEUuyxoxyJak8TNR23n75MoL69w1LteHQPJL6TvTDWkYLYKsMC5Rm8O7vm0YejfHcputEsk1udV+rN7DVh9X+m1Ws3ETR/zX1z8OFjmCtOHSFrzKZs5UfrliFQ0l6yIdAWYkqE+w==
Received: from MN2PR05CA0021.namprd05.prod.outlook.com (2603:10b6:208:c0::34)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 12:02:10 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::12) by MN2PR05CA0021.outlook.office365.com
 (2603:10b6:208:c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.18 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:01:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:11 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:08 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:27 +0300
Subject: [PATCH vhost v3 03/24] vdpa/mlx5: Drop redundant code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-3-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: f859f6e2-e1f6-42cb-7357-08dc9f45c330
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVk4NHJSeDhMdFVYR0ZZeS9USEJOb1RBL0M1VWJJZ213dlplaHUwVEw5Wlkz?=
 =?utf-8?B?SHlRT2VyWmx1bGVmZXM2aEJJRDE0djVZN2JEV1M3aisvQklBWnhxZTVDWlVp?=
 =?utf-8?B?Qjd4WVNCcVpuaUxzcVlzWnh1RkQ2aGgrUGkzVldqa3BxbFVWSmMyd25yWUYr?=
 =?utf-8?B?TXlOK1l3QitsTUFldUJDNnVhMURSYWZ3RlJvc1RGQzFITnhkOWNtN3pCMGlq?=
 =?utf-8?B?c0dRTUY4ZUhVUENuclo4M2JsdWZ2MHA4aitheklGdmNzR2hWUWgyLzdlVjMr?=
 =?utf-8?B?S0xwYmFsbDc1U0NCeE9OdmZKdFUxbVE5TU0zMGM3Y0tuMDFtamZETm1nTERU?=
 =?utf-8?B?OXlkbFFMMi9zN1pqWXQ4T3pjS05RaG8wTG1NNFREa3JKQW15Q2t3eURpQVVs?=
 =?utf-8?B?ZU8xdnFqRnk0SkxKTWFxMHlRclNSL1NvdzVLZXZOL1hISnMwYXRDZ1prQmE4?=
 =?utf-8?B?ajF1MUhRcFlJeDJtcFdmckpFV3pNZk53THdCcDFCaVVqVk8xQVA4L1oyYkMr?=
 =?utf-8?B?YjJzbFJ5Z2cxMXNsR084ZTA1M3F4TnVNcDJSZVcvVE5oMWF0cFlOUElkYzJB?=
 =?utf-8?B?Ym4vaGpScWlmQ0svVmxJR2s4NkZqUWZTZHQ1WmhNc2hwc3p5eU1JOXlUOGxi?=
 =?utf-8?B?cmNraC9uWjhSUDlXWnYxd3c3YWtEU2NnQ2tYbVJxMkNZV2NIdUVNbXJSaUJx?=
 =?utf-8?B?TlJDOFdlNk9MUkorY1dCd2tJVDZoa2ZBYnNCWGN2TVkrNzc3NVVHUC9HVm9a?=
 =?utf-8?B?dUtVcUZCYmJJNWQzUml5Z3BnWlZrTkxxWWNlcGQvbTZ5bzRGS1V6QitwYWla?=
 =?utf-8?B?Lzk0ZUZXbWhTVmxLNWtsZVY3ZWJZc3hrWUJmRGlzdEdhcUFMNjBlVTQyM2Ez?=
 =?utf-8?B?Y0xlWWVDM0NaRW1BSkxYek9ZQ3g4clJtVWQ5bE00QXVHMUV5RHh0YUdWdFlt?=
 =?utf-8?B?bGdnb3VVblR3NFFsaXJqRG9UL0hBL1VGTXBqZFAxbTg1a3h0MkFEcEVBL3RI?=
 =?utf-8?B?TXgwV2p1MWQ2ejEvQVN6MFhEK25jSFd4OW5ndC8yK3BXR3RlWE9nTzIzajRJ?=
 =?utf-8?B?Qks5RWFkUmtaRHJaMVdhVUNCTDdNalh1VDFJcmkwTmtyY0c0aTA1MjVaV25V?=
 =?utf-8?B?UXpwSVpERHNTK1dMYjdreUNMOW9razcvY2lzSks0QVFpd2ZvVTVIYmV3K1Jn?=
 =?utf-8?B?Qkt2NzJ0NHB6SVMyK3lVdm16bUR4SE5uSldOYlRrc1p5cElNSlF4MlFWMGRT?=
 =?utf-8?B?QVVEeTBOMmVGL0QvK3NZc09YNmdmNjdITGVWRkgvYTNnMlF4N2tuaTlZc2V5?=
 =?utf-8?B?YkNWdjZzTnFKNExBVWtDNGc0enBWeFBOU0dTbzBlQUV0NXlEUjRYdWVrM0tz?=
 =?utf-8?B?bkI3T2loUE8yWXMwbFJCYkYrYmE5c2U2SmlXYzVWN0cramVJUm5DMnFxaWNX?=
 =?utf-8?B?c1VldjN0YldOa0s0cjZwUFZRV3UzQ0VkL0lHY0dpQ0h5RjdFYmllMVh0K1RX?=
 =?utf-8?B?aGViSzVDYllPWFZmd1VCOVI1RXFLSnVYRkpmenlvSlI4RXN4VnlSL0M2UEdP?=
 =?utf-8?B?d29YMGhRWjBOb2d1VnVsSEZSbERBQnE4U0ZsaWdCL08yRytQVGIzYWcwMHVQ?=
 =?utf-8?B?THNlSFBQWEJqL2IvR3hab1QrQkJPZnFZcy9WdDVTL3VPRGFwK3cxcUg1akEy?=
 =?utf-8?B?YjkxcGlSNnhZQ2w3ajVibTdMaHhZVjJKWFBkRzRnaGIzRDJJMWdaaFlyYksr?=
 =?utf-8?B?OFlvTzBmaythbG9WSzZJZG5PRkRLWlJpWC9iNmFUVnMxYkJ1c3d1OEM5Uitq?=
 =?utf-8?B?ekluTldCc3RaOENSak9Cc2FlZjltQnpvaTRyRkNZUml4c05PNmx5WlVTcjBX?=
 =?utf-8?B?V001V29jL1EvTk1DNlF5ZUhhOExDb0JrNmxSSWlXcHVxVGpyMzBNZENpQWEx?=
 =?utf-8?Q?clLO2p9/2/Z4JkpiBEoSZbyR5xiBNvK0?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:01:55.4028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f859f6e2-e1f6-42cb-7357-08dc9f45c330
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731

Originally, the second loop initialized the CVQ. But (acde3929492b
("vdpa/mlx5: Use consistent RQT size") initialized all the queues in the
first loop, so the second iteration in init_mvqs() is never called
because the first one will iterate up to max_vqs.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1ad281cbc541..b4d9ef4f66c8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -3519,12 +3519,6 @@ static void init_mvqs(struct mlx5_vdpa_net *ndev)
 		mvq->fwqp.fw = true;
 		mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
 	}
-	for (; i < ndev->mvdev.max_vqs; i++) {
-		mvq = &ndev->vqs[i];
-		memset(mvq, 0, offsetof(struct mlx5_vdpa_virtqueue, ri));
-		mvq->index = i;
-		mvq->ndev = ndev;
-	}
 }
 
 struct mlx5_vdpa_mgmtdev {

-- 
2.45.2


