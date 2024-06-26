Return-Path: <linux-rdma+bounces-3511-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F4C917E02
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 201F8B26971
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FFD186E58;
	Wed, 26 Jun 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m2Ry6ljb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B5186E45;
	Wed, 26 Jun 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397684; cv=fail; b=l6ts2TNxkQg74bNYmf3JpiWLDtnkNOiwGk3ZbXuHlFTY31AgUyKi90g790Dc3t1k/K/3LV1gd+wJIlaOJ6p6ztKgI4QEn8IVixk/Gs54MRCar48yTuMdN7fp3n25VrEe4NvRfi/JFDK9zjBeO2tS0xQus31s2P+qyhq97TaDwus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397684; c=relaxed/simple;
	bh=judr+EMnZNwE7tn3YiN5Hzy0MkYgxyp3CLgpUI7Xzpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=J+F/hpOzonf3ceVhWkepyHtV1NgP16+oBuRqOlhFMj2zZTOIJrdJrtSFj3UbP41hRoed6VFubjUak0NxkpHO/UHdTofX7oCITmMb+Wv1QB6w3H9R0vvGbOXMJGFxAvE783Rk1xVYUy64kpzAYsd/wF7UTHSKnHFbCzBY7opvh5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m2Ry6ljb; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKu8TiGUexMYhGBNnbDN8wlnCbJLaIiIHWyUA+6JylGbZtx0KGcYeRQRbbFWu0azKxahtf5WDu/I6dDVMcb9VS4+VhV1lqJnU8aypq2Y+5k51flUkkieb/qSUZfn/REJVoSFdM2TynWgN+dr959czI4jtV6Ca6NqKCpDdxjwpCRf/gZCrEUYpCNGsv+SffdN/IKfgVAVqNTYoU30r5sFi8y6/i8ZH8hgHTbzosZuRx+B9OBeapEwbgET5PckiGAqqCzlIOgcRF3+VfQWjJ+sEb6BekzNp548FZtvI4mHDHxvqvPDpjwD7rSprj6tGfDVDHPCJ/5oVclJQ5Nmd8LLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE21AnfVwosUgk/yfrNlF81mb7z/76UVneqpNI/TsC4=;
 b=Rkr7v96rKRXHkeP9NsLB91sBmI3c4MjVFuTIuLksKAJ7ZPfQIll8xg50yGhlwZDhZ4b4ZG1Brak/DmD/8lnEByxNUoJvmNkH7DcxWNtl8XTkmRs165TNRdAAEhGb537voFBaZXZrkaURvQlsasBDSDo9YqYIY4HJ0ChruZe5edWilcreAMWtgSmZdLiGmdPYyoo9Y0J1yLA/XsA8NCB33LwBKU+R+uRbyWk5dYBzao4Co05UteCoyINGurkaKrUceQj8nAR48NqiK2GFuMQ5XxIOMBXH84akqrYKKTfNunwjkHlad/Ju1P6iF72WG/bIm4y9QiyL1DLoZrb3EmjvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE21AnfVwosUgk/yfrNlF81mb7z/76UVneqpNI/TsC4=;
 b=m2Ry6ljbOSft8ORfFDBY+4TKJMZ7HwpzTZWRIghZ7zfhUeFWSltUJuTF1+y45mXmu2AxFgwNY+AtOtlxk+pweyBJYfthDEx6XVnFLzxfhH1g5dOwQO/C/IyQh5lbrJGIo5iZbw53lLX8GIkpUdgQ1xPc2FnHiY309Ii7Rzxit/afUMTm5uVbaZqTNlQEVwD/88BkpEFEAWKAM8681ITAY2aHxdWqH7DqR/xYRxQJt9ZZLNSVRgg0oblLDUh82ntbHs3DthW5bb9HempSW6yE/aQkX9kyRycyRaQGw+8MEiId57y1estGao7H/LjBSXMR5E3X7itbVfvaS9SDRU19SA==
Received: from BYAPR11CA0105.namprd11.prod.outlook.com (2603:10b6:a03:f4::46)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 10:28:00 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:a03:f4:cafe::cb) by BYAPR11CA0105.outlook.office365.com
 (2603:10b6:a03:f4::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:27:43 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:27:40 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:26:50 +0300
Subject: [PATCH vhost v2 14/24] vdpa/mlx5: Set mkey modified flags on all
 VQs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-14-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: 64858163-fd1c-4b16-2ef7-08dc95caa748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|82310400024|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkZsVG5SRFZ6djRzbjBzbjJXTEVTdWNCN3pjMnkyOStqN2R0MW55TkVzL0NV?=
 =?utf-8?B?UHowcDc4M1FQRU9QdHZNZXdvSU93QUw0Mm1md0RHTGVqRnNEL2I4c0V6c0xy?=
 =?utf-8?B?ajlhUHkvZ2xSTzdCNUljbDRsdWdGU1hKQk13RUtYbWZVaUM3WW9Gc1JGaHlr?=
 =?utf-8?B?NkVucTVBVW1TSTNiL2t3MGQvblY1b01tNFBkd21JT0I4TFBXMS9jUGM3SGgw?=
 =?utf-8?B?T3dpUXlkSlFjSWx6L0JTWDZYZnBiTHFTSXczQ1VORjF5NlhOVFc2dkVqZXhC?=
 =?utf-8?B?dENRSkpRZEkzUEFpb283cmk1L1RZNDlsWlU4KytDSkNxWVQ2MWg3S1VOWHNK?=
 =?utf-8?B?OXBOVWhmQlRwUnBFUDJIeHJMY3FQZ3Zpek44dmplNjYxV2F6TnRoZm52cTlE?=
 =?utf-8?B?QW9PaGRORU5CMzF5UElHc0E0Qngwdmh0bTZ5NXk2ek5jTjJ5TXk1SU9RT1dv?=
 =?utf-8?B?UlJ6b1FiMGtmVlV3VVlTRUFCQzlCNmJpVFFrRHc0MkdzT2wyZ0F1dFlxN1ov?=
 =?utf-8?B?RkxLcHFmekduYmtMTHBtSXpaSWdnNy90aVVkZU9tMGduZWZDbFZkd2hQVzlW?=
 =?utf-8?B?RnZFNExXWjEyQjBTNWJ3LzRoSXM0YXQrYitteTFlc05HSldPM2d4ME9pdzJw?=
 =?utf-8?B?U2NaNFVJZ1pDVHA0OGRISVhrQ09xVklHYkhteWEraG80bjNtdmI3eHI1UXZN?=
 =?utf-8?B?ZVVWNFJZVmdjbEdZaW5QVXRqdlFDajdYaHFhZ2hPV2ZZWnhHRjg1RE8yYTRz?=
 =?utf-8?B?MWx2Y0R2YzRYd3J2U25ROGNHMVd6eDF6OGcwaUtpOEpMc3VUNzgvNXZyWWJm?=
 =?utf-8?B?MXlxbmpvejZEenRuMTF3bjFJZmp0NERMVUhoSndLSjU3TDdxd1orRzNwVU4v?=
 =?utf-8?B?RUhpVzlqaTdBbGxEeVV5a1dZa0REZ005cVpOQ1hPUlowNzcxQmlpVjU1Zyth?=
 =?utf-8?B?K01NZmxrTlRJWW1HVzhTSXYrNTJ3dzBYL1dIaW5OOFAvY0M5WEtEUmxjZWhD?=
 =?utf-8?B?QTVxTFhlbExVNHRaNnB6Vk1RZTRIOGxaQWloSmxKQWFKMS9waTUyOHV6ZFlS?=
 =?utf-8?B?ekNOQW4va0EvakJTWUhyQUtHU3lrZDcwQUJaK2pCVnBPNTJWQzRXNEdJVmhY?=
 =?utf-8?B?bnhPMUpvdzcwVSs5cXQvcHdkbU9KdFhPVTFWTDRhZE9BOVpwY3NOcFJReU1R?=
 =?utf-8?B?Yk40ekZrT3NZOHZHazZUODRnM0RrWWZFM3Y1WEhPMzBuRXliUGw2QTMxTERh?=
 =?utf-8?B?N1pUMUZpbTBnYVlzd1V4bDdXODdJTHNpOGVBVld4R2RyMTQ5cU00bUhlWXE2?=
 =?utf-8?B?V2JLMk15Z0lzdnJEQlZZaFF1djl2L0czM09OZ3VYNEszMmZEUDVEL1djVjdr?=
 =?utf-8?B?WmVHZTFwWko3S3VDcERMUldKWlBzK1BkTTZ4VUF5VzR3MFVTdlE1VHBzWTVM?=
 =?utf-8?B?MUdHZVREVFp5VXpJS1ZCcUtONWtROXJGSlpScUhseVE2UTgzclVGcUlneWNk?=
 =?utf-8?B?Mldhc1lZOFdHMXBwUUJvRmNLSFU4M3B6RGpSVVJ6RXdNTFJBY1FsM2U3NkFB?=
 =?utf-8?B?OXAwNGV4Z0I0L3VqbnZabksrV0IyWVM1dzFJNC9ocm8zeXhCT1ptTHpZSGEr?=
 =?utf-8?B?OW45RHcvaG15TTRKN2FOQnBnVEVWRCtQNjJibm9Kdmc1S2xtZW4zdVVOR2Q2?=
 =?utf-8?B?Q3VQTlY5bC9zdURGc25HWkVTRnN6RGtnUXBNTDBsdE5QTVZwTzdjalFSNVZE?=
 =?utf-8?B?U2xRVnZQQ2tEeFhVREdMUGxsTUphTHhiR3pnOURQSnNVeXZtbU1SVVVGcjRN?=
 =?utf-8?B?MXpWWjE3cEJhbmZYTjlIczQ5eURPc3l3eGtFVlNPd296aUNBcEwvUUsxL2Jh?=
 =?utf-8?B?dWNaSy9tSnN0MlI2TWpQM0daZlBSeEUvc0cveERES0ptYVAzWkM1NWo3OFp6?=
 =?utf-8?Q?P65Zb95IDCA369WDIdS9BnN2ewBpfmsm?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(82310400024)(1800799022);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:00.1444
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64858163-fd1c-4b16-2ef7-08dc95caa748
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142

Otherwise, when virtqueues are moved from INIT to READY the latest mkey
will not be set appropriately.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 7f1551aa1f78..a8ac542f30f7 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2868,7 +2868,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	mlx5_vdpa_update_mr(mvdev, new_mr, asid);
 
-	for (int i = 0; i < ndev->cur_num_vqs; i++)
+	for (int i = 0; i < mvdev->max_vqs; i++)
 		ndev->vqs[i].modified_fields |= MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY |
 						MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY;
 

-- 
2.45.1


