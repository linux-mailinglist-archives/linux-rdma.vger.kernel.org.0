Return-Path: <linux-rdma+bounces-3230-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB81590B4A7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD77E1C22E61
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F2915250B;
	Mon, 17 Jun 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFiuSiHP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FDB14F134;
	Mon, 17 Jun 2024 15:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636954; cv=fail; b=ZS6t2g/cgNm3ez9y+6clDc21Px/Iqqp3quu77wtMbhpJJrLToOeURD+QfMtfEhC5B7NY8LlwDBnAIqgbDhPFFzvqvBmltvFsdgLEOa6g7NkerfeGcWl1YMGe6GU/IQKzjO8bXJioxug/dg5LA6JWlB3995qvfKSI/7jArcVfsEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636954; c=relaxed/simple;
	bh=pc5HJS8voJPQzeDkzRBut/sCmy/3n4KyuJhmZ/HWW0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fXrMN8ZdY7N91BgCdKudZxK9wH3LnrYBWX2IWu5tFFxHhgFfYz4zopz064Hh3zGiH39hO68pTASL81Tn1lPRaZG0R++3Y3BlxFm/bOUkT7r9/TyZIbv1qqX0fs1RpITMQlLCyAAFz1Wh7wMu/qjZDJPhPfiQw2ulYMC4B+tqKmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFiuSiHP; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GktqS/fqjQfXh9MoTSAiilQsy9ZjLjDEOyIy3Rk8ezoAtpJs0Z6n8AqR74pcXOlm6yUpIVVp/3qQkqZlF6+SNYSjFlgEJv4obnN8Sjoz4T8ZTcFj1p/Ou4C2haAwn34jFfXs7qKlEibHKW/82LTKz7JHFZzT3t6GuVAy8hu3qml2WTbKJpxpy0nZzjO1SMo6TxxqACm2ko1sn6NRFTEjnWEFKHpQMKP+qgL1h0pcLpEscqhhY0CGXLJLb6iuar/irZECeymHvUbUIv0167p02dqXu3fHbp9jkxjbCDddymX34ABNOdG/6nnXXPtv0eY4aEy2IyExmQzLzHy8usM7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6567hXPJ3mj1qTBtnRoBRmvWg11JveSZG3/2M1shtOE=;
 b=Bjgy6+VitKWPSHURFxNPBLFTYH4trkTs6nX0CHm2KZLNvK2VpqrPvx1JjHYh5zsqnlGzrcorUjOeDNykG5xAgaiDLLP95aGWfCrXjP1oKmHn+AApkhvm5AwGhgp9UEsgBecSjRp/gE/6o6reF6MD+4Gej/WX4r9AuJNYud2EuwzCvLUIO7qz3j/G24nj32QzRdRfDgZ30O237DMSjlFxFd9wJ2XY99ll8xMojrmeuUtafbiMSf02rP9012nAaVa6ekVkJB1QeCj4MHjziho3ZAzoVmrQiiUlf2WnFvPAqBW+7sYZ+FlPnwHxe7ThNYaanTZ6F/J0phnHkrVHDbX8oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6567hXPJ3mj1qTBtnRoBRmvWg11JveSZG3/2M1shtOE=;
 b=jFiuSiHPFtMnFaSD48qjIk+WMQFYsJme0rRH1ia2e1RWgrEte/sZUAAQPwj3onYGVDA3k3sR0TVDaosggcv8ClM8LvgGlOZyruOtmil740Ekmgjq/M0nvtBgOFZjjl/a3/uqcfKj0mTWacpwBOCyjkRkKWCeGt1Rjtf76hp6HhsVJ3AIjAQdWZMP5/KNzBHYfmgi3HkkJpIwPetghyEBx0xoDGil34wEdO2MfsI1YiiSd03n2ER3Yfl74dH3GvOHNzQbhU2+M5IySyt4x8OAi46cIRNnlUFQtPIy6jcnDkcfX63O4Ltn6HHwfTWv2LtAj+P1hVxNUszOYNiZNRLguA==
Received: from SJ0PR03CA0133.namprd03.prod.outlook.com (2603:10b6:a03:33c::18)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:04 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::30) by SJ0PR03CA0133.outlook.office365.com
 (2603:10b6:a03:33c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:04 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:43 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:42 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:39 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:48 +0300
Subject: [PATCH vhost 14/23] vdpa/mlx5: Allow creation of blank VQs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-14-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 04809ec4-2705-4e63-663f-08dc8edf6d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0JtUGdJZ3JIK0pTMlVJOFVkUjE4WFNWaVpsWU5yR1NmZzhFN3hJRWh4ODcx?=
 =?utf-8?B?dDNzZ2lkZ1QrT2wreDBtWjdUWEppREw1K1d6MHJGdllxWUV1RmZrd2pWMmx4?=
 =?utf-8?B?SFJaaXU2QmlUYmVRQkJlOUdLUmRHNFYzVU5QMDkvTkJ0NTFuUWdMa3lJaXV2?=
 =?utf-8?B?aTV0VmptbW5YZWR1TWFNUFBrMVd3WDJrMEVqMEVLOFdMS1UrRjFldUNTeEVM?=
 =?utf-8?B?WlpObnFWYlBybFBMV1c0cjBHeE8yeS9VQng0Rmt3UzAwSTBycHhOT2c4cmNS?=
 =?utf-8?B?a1F3c2pFclE0T0VVVVVwczdQWTVmYzA3a1dJODYwaGdtaGFMOXRTRW9STlBQ?=
 =?utf-8?B?d1J6dTAyazVROTBodUNaeWpFV3dJTktnZHpCRXByQVZaUG8yMlpCMm1VeXpu?=
 =?utf-8?B?SmF6U3M2bFQ4amNTYkJwQjFmNGNwZmpyLzlUVmxzck0zSWNjMGh4N0V1c3Nq?=
 =?utf-8?B?aXl0R3F4Ti94R0xuelFJQ3ErbXB2cjEvd2dRMEhQZG1kMHhOZWFwSWlGNlpP?=
 =?utf-8?B?Z3EwdlhpVS85SzFDTzRQakZtanpjdTlIQmlqN2dxT2U3NmxiMWNJRXdPUEM0?=
 =?utf-8?B?TWZkeE15Mnh1SHJhWFZoTVJ6RU9FVm1ab2d1TEdCMjVzVkZ2cDlMcW5aOWNi?=
 =?utf-8?B?Uy9qSTBCWktnMkQ4OUNXbHB6aFQxTkliREpaRGlwbGlhaVVEMDJTNUFJT1Ur?=
 =?utf-8?B?VGZWekxWMnkwS2w2eGpCRlM0WFFlUTJVQ01aLzhsMkxaczR0dzhpZEJyc0dm?=
 =?utf-8?B?N0hvdTB3QjlmZzRoRE14bHdlcGZsa1RHbHdoaDk1Y0dUZ0dBbEg0UUsxbEoz?=
 =?utf-8?B?elFFSjBneU5ScjNlcUU2ZlMydkJYbEhCQVpSYkJjcWo3U0tLRmdOeHpCV3BG?=
 =?utf-8?B?a012REh4QW95U0h5TXNoRjFvcldyUWVsR2ZDWFltUnRNRU5QVmlrMGxvc3VN?=
 =?utf-8?B?Z3E1RFUrWW1ydkNoeWxGaVJOam5HNDN3SHlJTVltWlFsVnhtYXg2T3dpL0Vt?=
 =?utf-8?B?N2lFNVk1TXF4ZWV6RFNlR05KTG5GYmN5enhFNjJoU2xCL01JOU44VmswSU5H?=
 =?utf-8?B?ZHRsUEw5THhrWHJkaU03TDFvN3Y0L1M1OFJSaUV5Mm5BS2t2cTFXOTBWMkdH?=
 =?utf-8?B?NzRwWmRzR0cwR2tiRUg0UUxSZkJjamdKR09ZVzBFSUtDSFBqSUxWN3diM25T?=
 =?utf-8?B?QjlNUmZSZW1sbUZUQTNibDFpTE40TURFS0hCMFBBWFU1VzZxSDh0ZUQ1bkJw?=
 =?utf-8?B?SWVraEJMdGRzQUdiUnU4c0pwYkJIbk0yd1lLeUt6RkNuTCtLa2k0by9YMjhU?=
 =?utf-8?B?QXdLcEFwOGZtcVdvSzVUY2JWWGNpRmllRnR5NTBGbGxWdmdtcDNmVjNZTjU1?=
 =?utf-8?B?eWZFVGdDZ2E4M2MzSUNYc0psSERUK21Vc1R2eFErNElabkhDZ1VoT204RWE2?=
 =?utf-8?B?SWh0VlkvdTQ1V3NUQng5bW9zLzRZSlZEcXBHNzBKbHhkOXZmUDIwelhiY0VO?=
 =?utf-8?B?QW8zOUx2VHNJZW1XekhwQW1vOWJIMnNlbnlVN1Z0eThPeHF4STVYL2ZqK3lV?=
 =?utf-8?B?U0g2blNGN01odjFIUW1CNStEOTNubjFjMzJxc2JMWUg1M3k5SlAwbklRUm1D?=
 =?utf-8?B?akYvNDFFZkdid0xQNElJUm5sVnZSd0tBTVBLc290OUNvOXhkZmtQYWRYRVc0?=
 =?utf-8?B?dS9ib2tRalNEN3BHLzZjZXBLZlhuR1FYMDFhVHY5M0R1RkR3RUl1YTNLWGFj?=
 =?utf-8?B?a0dJR1NDTnZjYkp4N3VIU3ZtM0NqZ3gxRTJmTmFWazhyeHd3clVxdEgzbFRa?=
 =?utf-8?B?RVVrMytwTitzdjlldGhET2RQWFcyaVNRazNFZmN0RHFZM2dEUW9STC9OM0tm?=
 =?utf-8?B?aklmenpPR2NHMW1wM0hTdFNBaVBKVUJwVG5UUzVpcGZ6RVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:04.4545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04809ec4-2705-4e63-663f-08dc8edf6d70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

Based on the filled flag, create VQs that are filled or blank.
Blank VQs will be filled in later through VQ modify.

Downstream patches will make use of this to pre-create blank VQs at
vdpa device creation.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 85 +++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0abe01fd20e9..a2dd8fd58afa 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -158,7 +158,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 
 static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void init_mvqs(struct mlx5_vdpa_net *ndev);
-static int setup_vq_resources(struct mlx5_vdpa_net *ndev);
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled);
 static void teardown_vq_resources(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
@@ -874,13 +874,16 @@ static bool msix_mode_supported(struct mlx5_vdpa_dev *mvdev)
 		pci_msix_can_alloc_dyn(mvdev->mdev->pdev);
 }
 
-static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int create_virtqueue(struct mlx5_vdpa_net *ndev,
+			    struct mlx5_vdpa_virtqueue *mvq,
+			    bool filled)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_virtio_net_q_in);
 	u32 out[MLX5_ST_SZ_DW(create_virtio_net_q_out)] = {};
 	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	struct mlx5_vdpa_mr *vq_mr;
 	struct mlx5_vdpa_mr *vq_desc_mr;
+	u64 features = filled ? mvdev->actual_features : mvdev->mlx_features;
 	void *obj_context;
 	u16 mlx_features;
 	void *cmd_hdr;
@@ -898,7 +901,7 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 		goto err_alloc;
 	}
 
-	mlx_features = get_features(ndev->mvdev.actual_features);
+	mlx_features = get_features(features);
 	cmd_hdr = MLX5_ADDR_OF(create_virtio_net_q_in, in, general_obj_in_cmd_hdr);
 
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
@@ -906,8 +909,6 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.uid);
 
 	obj_context = MLX5_ADDR_OF(create_virtio_net_q_in, in, obj_context);
-	MLX5_SET(virtio_net_q_object, obj_context, hw_available_index, mvq->avail_idx);
-	MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->used_idx);
 	MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_12_3,
 		 mlx_features >> 3);
 	MLX5_SET(virtio_net_q_object, obj_context, queue_feature_bit_mask_2_0,
@@ -929,17 +930,36 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	MLX5_SET(virtio_q, vq_ctx, queue_index, mvq->index);
 	MLX5_SET(virtio_q, vq_ctx, queue_size, mvq->num_ent);
 	MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0,
-		 !!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_F_VERSION_1)));
-	MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
-	MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
-	MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
-	vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
-	if (vq_mr)
-		MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
-
-	vq_desc_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
-	if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported))
-		MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->mkey);
+		 !!(features & BIT_ULL(VIRTIO_F_VERSION_1)));
+
+	if (filled) {
+		MLX5_SET(virtio_net_q_object, obj_context, hw_available_index, mvq->avail_idx);
+		MLX5_SET(virtio_net_q_object, obj_context, hw_used_index, mvq->used_idx);
+
+		MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
+		MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr);
+		MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_addr);
+
+		vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
+		if (vq_mr)
+			MLX5_SET(virtio_q, vq_ctx, virtio_q_mkey, vq_mr->mkey);
+
+		vq_desc_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
+		if (vq_desc_mr &&
+		    MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported))
+			MLX5_SET(virtio_q, vq_ctx, desc_group_mkey, vq_desc_mr->mkey);
+	} else {
+		/* If there is no mr update, make sure that the existing ones are set
+		 * modify to ready.
+		 */
+		vq_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP]];
+		if (vq_mr)
+			mvq->modified_fields |= MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY;
+
+		vq_desc_mr = mvdev->mr[mvdev->group2asid[MLX5_VDPA_DATAVQ_DESC_GROUP]];
+		if (vq_desc_mr)
+			mvq->modified_fields |= MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY;
+	}
 
 	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
 	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
@@ -959,12 +979,15 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
 	kfree(in);
 	mvq->virtq_id = MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
 
-	mlx5_vdpa_get_mr(mvdev, vq_mr);
-	mvq->vq_mr = vq_mr;
+	if (filled) {
+		mlx5_vdpa_get_mr(mvdev, vq_mr);
+		mvq->vq_mr = vq_mr;
 
-	if (vq_desc_mr && MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported)) {
-		mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
-		mvq->desc_mr = vq_desc_mr;
+		if (vq_desc_mr &&
+		    MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, desc_group_mkey_supported)) {
+			mlx5_vdpa_get_mr(mvdev, vq_desc_mr);
+			mvq->desc_mr = vq_desc_mr;
+		}
 	}
 
 	return 0;
@@ -1442,7 +1465,9 @@ static void dealloc_vector(struct mlx5_vdpa_net *ndev,
 		}
 }
 
-static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int setup_vq(struct mlx5_vdpa_net *ndev,
+		    struct mlx5_vdpa_virtqueue *mvq,
+		    bool filled)
 {
 	u16 idx = mvq->index;
 	int err;
@@ -1471,7 +1496,7 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 		goto err_connect;
 
 	alloc_vector(ndev, mvq);
-	err = create_virtqueue(ndev, mvq);
+	err = create_virtqueue(ndev, mvq, filled);
 	if (err)
 		goto err_vq;
 
@@ -2062,7 +2087,7 @@ static int change_num_qps(struct mlx5_vdpa_dev *mvdev, int newqps)
 	} else {
 		ndev->cur_num_vqs = 2 * newqps;
 		for (i = cur_qps * 2; i < 2 * newqps; i++) {
-			err = setup_vq(ndev, &ndev->vqs[i]);
+			err = setup_vq(ndev, &ndev->vqs[i], true);
 			if (err)
 				goto clean_added;
 		}
@@ -2558,14 +2583,14 @@ static int verify_driver_features(struct mlx5_vdpa_dev *mvdev, u64 features)
 	return 0;
 }
 
-static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev)
+static int setup_virtqueues(struct mlx5_vdpa_dev *mvdev, bool filled)
 {
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	int err;
 	int i;
 
 	for (i = 0; i < mvdev->max_vqs; i++) {
-		err = setup_vq(ndev, &ndev->vqs[i]);
+		err = setup_vq(ndev, &ndev->vqs[i], filled);
 		if (err)
 			goto err_vq;
 	}
@@ -2877,7 +2902,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 
 	if (teardown) {
 		restore_channels_info(ndev);
-		err = setup_vq_resources(ndev);
+		err = setup_vq_resources(ndev, true);
 		if (err)
 			return err;
 	}
@@ -2888,7 +2913,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
 }
 
 /* reslock must be held for this function */
-static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
+static int setup_vq_resources(struct mlx5_vdpa_net *ndev, bool filled)
 {
 	struct mlx5_vdpa_dev *mvdev = &ndev->mvdev;
 	int err;
@@ -2906,7 +2931,7 @@ static int setup_vq_resources(struct mlx5_vdpa_net *ndev)
 	if (err)
 		goto err_setup;
 
-	err = setup_virtqueues(mvdev);
+	err = setup_virtqueues(mvdev, filled);
 	if (err) {
 		mlx5_vdpa_warn(mvdev, "setup_virtqueues\n");
 		goto err_setup;
@@ -3000,7 +3025,7 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
 				goto err_setup;
 			}
 			register_link_notifier(ndev);
-			err = setup_vq_resources(ndev);
+			err = setup_vq_resources(ndev, true);
 			if (err) {
 				mlx5_vdpa_warn(mvdev, "failed to setup driver\n");
 				goto err_driver;

-- 
2.45.1


