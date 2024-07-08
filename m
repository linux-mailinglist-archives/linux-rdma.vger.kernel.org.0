Return-Path: <linux-rdma+bounces-3733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF5592A205
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F063CB214C2
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E610823CD;
	Mon,  8 Jul 2024 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U+aUWkrh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E23C81ACB;
	Mon,  8 Jul 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440148; cv=fail; b=RiwZ0+9kVC4NfKXxLTF3oLH4q4TXocJI2vJigsmLsgfGtXxVzSHWdh4bMISHqC70/uBoDFEST0WxLKGeAkSUgr4+RIx5HEoCsLcFw8THNsfFlf5Jq+C8xFmnG4cgQ5/Nut24pGqj8xZ0EZR1zRchSDGFdlYZ9HC9SmRDIltrZho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440148; c=relaxed/simple;
	bh=TwPw47efXO1B+Q3nzT6e//56UQUzyCnKn2YznnWBahM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KcGUg7swFA9zG3Z+L8FUX38A9fgKqOPGSxjIqGWQnGLS2mAp6SC2fbTakz2r8u8sOc1OqVPwhU0Xs1F/9RhBmNzWBDg/STa2ebeW3wFcUAJgZup7qv4ZrHenY0qKxly5GHeUrxj25ZCLWjtIwSBEpM7e+Z//sRaUZxmbQUaR8dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U+aUWkrh; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3PDOU8L32KUjmNbs3ObvUc7TLNntYYreUZsgQrlQqbLX2IP2Y3Y/dhB/tpaaYUGOdBU5V77iZTYfK5JM223Xkz3HjwHFOJlZzPrx5i6g2dneZjms6ZpxyprbTKRH7VuGouUT9MIM6Sgz+yKOPLOoaxqT+Nida9s7qndiuh17nNy/5J5V1Ujwv0vwowlDkBX1D5rsw2U7x2j7StGsVn4F8aWgnwwAl81QU8FTsos2s9hBViXSD5jyEJPFBAYGWGLB7F2boNStivIl7RUgTmyfWMWpy3b1RmdiwVT5aH6vWC0i8KNkz66h6e2ndetHLSAhix5nHPmVf7bUHJZ9XSbGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWB+O0G5uLWJ1mMDlgSXHc++Kxn74xpH2LYJgVRT2xo=;
 b=ljIlKQMhmx15uHrD3Q5fytmqY5aXLgUA7F9xjuaqhobB+p2qCL/QR5jYmt4M8S5F4+5svGvebS3ozcWe825xAHScjK/94/Vhv60KVJu938wWH2DNAboH04I3v1StwMphrmXlLBLcBTc943xPDyNLThEHIv4w53AI6NRLO4VoaTRAbM9F/eCBrbvJXjc417Ktnsv/FihhRL3g+Oaap3g26W9MJlzL8j1iFzrw8F9wZSnNzThIjwVTvSs+eE6GlarQGITtJZJSHea2hGWwhF/YiVI5JvkOZ2uhcu6EE9QInA+qCbqeElmSBveuHO/7jxmFrRpnGJuVSTBTXe1zqK0Esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWB+O0G5uLWJ1mMDlgSXHc++Kxn74xpH2LYJgVRT2xo=;
 b=U+aUWkrhf7WqzVjQ9HjOt3LcNAZBGygyKVue5sGEswwyajWBKoln0vxCjhJAeaub7uYaUw9seL3MDwpUisXXlSIoYf5aiupukUIAsfla3bPJ+znVT9MktsN2jmlwGObEjExscnflWW3TYYBZEMCSd/mMAAg0EDXSOAq4hvJf53Ba9SUBZSsDuEmLZqAqUovrvsniJ3oLmDwbC1DJM8JFwZ2X93awlqRcpoCFxKAO3dQdt9a1fh2SSBTQMYZ9kliaZEyQr58+2c0ANe6g56EPI7v+/exaR1Y1FEXbLuBKTEvKGekYoV6i6DRC3FnfHsKAxWVEB+PVyGg8psMre3djWw==
Received: from BL1PR13CA0270.namprd13.prod.outlook.com (2603:10b6:208:2ba::35)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:20 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2ba:cafe::da) by BL1PR13CA0270.outlook.office365.com
 (2603:10b6:208:2ba::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.22 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:59 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:59 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:55 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:39 +0300
Subject: [PATCH vhost v3 15/24] vdpa/mlx5: Allow creation of blank VQs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-15-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: defc8862-54ac-4982-7bc4-08dc9f45d21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T09HOW9FNjd6WmI1WjY3OGhxb2lxdU15NVlpWTVOOWNwMWkwdHdHK3IxWkRl?=
 =?utf-8?B?clByUWh5SWhVUk1QWEhjWG5ENFAwTE8wVFZGVVdzOFY0aE8yUFBvVXdaMytN?=
 =?utf-8?B?ZEl2dU9PWmR1S0xtQmZNeVJ1WDdxZUxlb0owaXVEazBWdHB3eVhUdXRjWkI3?=
 =?utf-8?B?dDdNTlh5TmQ3Z0ROelZiZTdrR2g5dnFITlJUbFROV3IwRFVzdUM1SHZ0SzFN?=
 =?utf-8?B?dE10NWVRc2kvY0JxK2ZOT01YVXJBM0ZWR014N0lWSEtQeG55Nm1mV3FYY0ts?=
 =?utf-8?B?YlJRanA2SmJyenlkVlg3NUlTT09JSFFieXFZWnlkbnVGekxYODlIQzBmMFM2?=
 =?utf-8?B?c2xFWWxDbks1UTJtYTgrRU5ISGhJYStjM1dtczRFMGUzZGErR05Lb05VRkdv?=
 =?utf-8?B?eUJzd3VsbmZrV0lvK2hpOTdXTG1IYU9lVWcwT3BBejc3allIeURQNEM0V1Vi?=
 =?utf-8?B?bmhaNDFYUlpndnl4RUNqMlgyZFVON2ZObnhCL25qcmxWNGJFZytGNGIraUt3?=
 =?utf-8?B?djRyOStkeTRJbjZpSEJZTW9zNDlaT0lhY3BEUU95MG9XZnJ3OCtGZ1ZJSk1z?=
 =?utf-8?B?WHE4MFNxSkZyWmh3SWFIOUE4ZWV5ZHU1WEZNNXpCQm0zL3JRWlR6YzV4dFZS?=
 =?utf-8?B?QlpHblE4MWVTMU53YTU0em1UTFV6eWplWW0zOGMvNUM4TURLeDhhVVc1ZEVw?=
 =?utf-8?B?eHNsbEFtWW5Na2NOeXRGQmF4bVJQZm93K0g4dkFkRU9TQm1RQ3EvdHNkaXov?=
 =?utf-8?B?TkdkL3RhNWZTV1l0emlPNzVpNFJFNjFwekRkdEZDK20ySm90WWN4V0ZJdDI4?=
 =?utf-8?B?aTlkNlZQWnl3UHV2c1VhTzJvNy9hTGt1RUNVR3E1Tmg2VlhYSHlqQldJTUZr?=
 =?utf-8?B?cEUvUDJDazUvTHEvK1A3RlN6ZHJxT2c1cXJMVmcySkVoajhHQWNoZncxR3pF?=
 =?utf-8?B?MWZadGptTkYvRnFyM1lYODlKd1czVkJxeGpKTVpGTVZlTDJsdUczc3FHZkhL?=
 =?utf-8?B?UVZabWpYalZCR0JzQlMyUkttM0pVZ3RoUkcxTGRlakRiVCsrWFF4MFpCR0Zk?=
 =?utf-8?B?TFBVcG5FRmpaeGRYSFNabU9PZC9VMHhDa0NiUy9UVDRYWXFiSk1ycG9CRXl5?=
 =?utf-8?B?VVdybytVS2JpcXcrNldtQVd1YUVlVlNhVS8yQjFtZWtKSUNXdXhIWG1CVnpI?=
 =?utf-8?B?S1JHS0dwR1lscng4WHRhejI5UHFuWE9aUGVRUzk5YjBUOUxiQVh0RFlhR3hq?=
 =?utf-8?B?TlRCMm1iQmlXbnNsUHRqQTJPL0NHMzcrYXZWMHpHWlVTcHJhS0RpWXkvZkpn?=
 =?utf-8?B?NG12RlZVVGFkUW1ubTVEeC9TOWFRem1XYm9ndU0vMUZQR1M4N2c4SGRBakI4?=
 =?utf-8?B?WXBZR3pkRGZVaXdQUXo4MDVZOEVRK3NCZ2dwSGUvZCtpaU9jWFZ4V0FMaVQ5?=
 =?utf-8?B?andIZHBYNGIyZ0JkOWNxelBiRVNMU2FaQlJ2K2JHOXJUK3FiLys5SzNZLy8y?=
 =?utf-8?B?d1dHWjBMUE1XMk90YVFFWk44WFQ1Zk96dHAwUmREZklEaU9UUXZmTlN2NzEr?=
 =?utf-8?B?S3F6WlkzWXpFUDI1ZFNLY01Wd0g3UTBHSzgvNXZpY0o3bW5LZ2x5elR4SVkw?=
 =?utf-8?B?NUFQeVMvN1o3VEpNd2Z4MGhPMTNJVWJ6bDEwNXpLVXhiaExHb3JFWlpVdUVD?=
 =?utf-8?B?VG1iSVhxL2cvUmVEMWVyRXl2ZUwvU1Nod09EQk53YTNDL3NWcjU5djk5eEJY?=
 =?utf-8?B?Ymw2TUY2U0NVa2dxUzBJdGZ5ellacG12clRxc3BISU1LdHhHejFXYnhMWUFo?=
 =?utf-8?B?VUF2Njd0UElWVUR4eVJzRXJKVHJGOUYxWGd3MFpQVHJxYS9idkw2UU5leE1h?=
 =?utf-8?B?ZHBaSHNoK2QwazNkVnlmdC9Ua25zektTV2RSaGhqTVRGTmtyMU15aW9pY3ds?=
 =?utf-8?Q?HnM2ipQeyRyYkc2O8j4wbvF7sUdJEuHw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:20.4247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: defc8862-54ac-4982-7bc4-08dc9f45d21a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586

Based on the filled flag, create VQs that are filled or blank.
Blank VQs will be filled in later through VQ modify.

Later patches will make use of this to pre-create blank VQs at
vdpa device creation.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 85 +++++++++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index a8ac542f30f7..0a62ce0b4af8 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -158,7 +158,7 @@ static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
 
 static void free_fixed_resources(struct mlx5_vdpa_net *ndev);
 static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev);
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
2.45.2


