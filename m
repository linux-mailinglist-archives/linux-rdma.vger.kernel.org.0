Return-Path: <linux-rdma+bounces-3734-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D0492A207
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FCE1C2131F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0331448C0;
	Mon,  8 Jul 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="baZ2m+ki"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD43E823DF;
	Mon,  8 Jul 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440153; cv=fail; b=lA+aVaJl4O3Nk53ONohTpSWLOZ1AMn1lJSf9unpBAKJ15DKO9cASERGhx9sDZUKZdKKkbESLJwP+xdHEhdYsbrCOPBB5mnvrnedgHYLm7H5+L69gp2/T2enJQRAP72iSp9j1r5Uwugo83LfbBojBkf/Zwgbk1P4cYpgokdLxurk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440153; c=relaxed/simple;
	bh=LIkAqiXldR1JJu4c3worPdJiI6If5bbvP3LoaKyTXPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=p7U5CoCtCr1x+Sw4Ug/vOp6oub+lWs3aWUAuxR/OBMpv/HP2IgTb2cpYJbkdRqWhp0xYxxRqLAsDVOBYILcMx/VXeJlKupjNT7/5hgOpA8LpgvaABXHkpoJS+13jvHPW02PT2tyg+xyIctRo8ChzaxvIdX3FAWuWFUgbw95US5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=baZ2m+ki; arc=fail smtp.client-ip=40.107.95.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkArWJxivfIhfKhUclDYbtNIOD6UjLQvSfyeITZSR9rBkSLDlMw4jjKE4VoU159dGXm+6rIy/uax2W75TgoISxuqBLDGhmvPiptQVs5/wrcZ3oz3atwnbi2unKkaDMLATo/iKqwkvEw9aasPOWql6WxpZy4xHgd8ZYKmxQfTq5ivzJf9mz6cuDpi+1EB41PKUIWNu9n4CbCso6upunOehRZS24fmx3aTLbvtB/4FReKc84S5Ce5i77xKpPJa/aSuqWvt0Jkeb53V/ZHHOce9tpdKCnsphztmCCp9vA2GDD4Tnn05N18Th1gFDob9q3/7keFxv5rNxMQ2WjBtpLB8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtyvVBYdcxD9Rj/nFWt7i6rnQILL/qRJ0iRZbPyhNEA=;
 b=EAhRZrWLUi+56yqlZqNUdnY2QGc7OXXZxxPAwLhGIOZO09NpkJEggJQuajxuZEmqG7ViHYPJYgI8rtRXpPJ1udTY2NJFM4cFMD3WKdObwP1LbvkimbufRJ5WI4RtN6EHljhm7IpIF6ht7JWGYRoRxEg2i5V8tMaAPOItCbylg9gvzxdFuOAXOZz7pz4THg1AkmWCcwebbBx9vOIe83AvdiTpxrQU2sPCZs6Xn5UNN3r/Bsx/KIez1AhfKYaJ7xyiQNpCz4BHVw9AffksJjKcFFwmzPo49Pe5gl5cnt0lwYIo1GMvzwcxe77NyqJROz8J2wVYBvwRuMLo+NHqoLWrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtyvVBYdcxD9Rj/nFWt7i6rnQILL/qRJ0iRZbPyhNEA=;
 b=baZ2m+kiTpJ+ZC+A1LlrFKsJli7pYes3qSsoqmeuCw2SIhJzB5raWHPah9K8w4Xwk1Wl5s3Y0qYpUsgZzvIQLqsBJlpysdVOssLi2ArGNxWlEleiChQvx0p3ppQW/RBuLx9uSuz2HML7FCvtpij+U/ZjjkXHIYPk8Sm/OFXl4BKacD8kh+5bKRJ27En+huLhLUX5piVjJVFaTFAb7kFwWPBhhk+k0P+uXPnZBRXey3POTQKVzNHLrLM4uh6QM2Sa6xJRfXS2ZJFmlvRfmrm0ABKWoJFx5Kz+QPgmHoB4kaFmj9UaBxhIryl9o4MwFjXybRUSBnGSbljyCLgTMsKqgA==
Received: from BLAPR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:32b::29)
 by PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 12:02:26 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::56) by BLAPR03CA0024.outlook.office365.com
 (2603:10b6:208:32b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:47 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:47 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:43 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:36 +0300
Subject: [PATCH vhost v3 12/24] vdpa/mlx5: Set an initial size on the VQ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-12-afe3c766e393@nvidia.com>
References: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
In-Reply-To: <20240708-stage-vdpa-vq-precreate-v3-0-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cfe4bba-6b39-442e-ec5b-08dc9f45d529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3pCYVpPbHUvSVRyMWxzenZERGVtcWhFSVJXb1pWOFdTK0R0MUVER3pSUjdC?=
 =?utf-8?B?VHBtdHFEMWxYTGR0aURZU1h4Unl6M0VnaWdseGgwQWZNVDRJQ0VnNlhZdFJt?=
 =?utf-8?B?QWgrd3ZDSk95Rzg2UFlEWkFMTjdjR2ROaUtLQUVKNWxFNDB1eEJ6RG1uSGRk?=
 =?utf-8?B?enJ5d3JGQWdpN0VURFZ6cE90ekk1VHFxYnYwMFY0emZIdzh4bGVVRFJkTUJ0?=
 =?utf-8?B?eUZqWktTd2s5SnZhcEFJanAzNitaTzVSTzJlSUZlSndMcmpIejBTcS94NW9h?=
 =?utf-8?B?cWVKM1AvWnpoUFg2Z2hmUkFaTzhsUUxRbmtDdHR6N1BlN1pYMXV0N0FoM2ZJ?=
 =?utf-8?B?NkVVQkUrQlo0TStJYisvNVdSK2Q5aDhnOXNGSzdUOC9CdVluWjhIL3d1eDUy?=
 =?utf-8?B?Rk15a2o2MFVublJmdzNRUHBONlhFNFRNa09WMVVNeWpEelRCWHV2V21FWTRQ?=
 =?utf-8?B?dm80OXVuSzlwYm9yZjNuWHNUblloaWhzMnRrSTZZT05JRVppV2wySktkQk1L?=
 =?utf-8?B?QnUzVXlZTFBiUnF3OVY0ZDl3K0xlcEorbjVnL1g2VnNLaXh6eUdGRGVLcUUw?=
 =?utf-8?B?V1gwUEtDU2VoMWlNbzl2S3V1M04zMWhuMlJ5UUlsd3k0V2VycTdpSG83N3ov?=
 =?utf-8?B?NnhkQmFiQ2hVejBzbjlVLytQN1Q1Vk5lbWdwSWdnaUFLUUF6UVpGWTJKWHJj?=
 =?utf-8?B?QkxRMlZMeVJudzNTVEMyT1R0ZlZxQmtVWit6L0FaYUJHcEsrVWdiUGhycnBK?=
 =?utf-8?B?eHNDMWVzeGRzUU5nREhZOEdSa2ppK2VEdHh6K3hlU3dubEFNRlI2blhZV0tX?=
 =?utf-8?B?cmc1NXJIK2M5TmRDcTVYaFVoZDlhckJSa1U4MFppazB6YlB6VEF0NVJEejNX?=
 =?utf-8?B?b09qNHFsOFc0SlY1L1doOFdqMHE2cGNCbzZNTDR1MkM0Y1gyKzBhNHVYMDdU?=
 =?utf-8?B?eVYxd0VrbmF4czlURTZ0Wm9ZR0JWTloyemU0a1NvNk9mU0VyTmlBNEVoTHM2?=
 =?utf-8?B?NVNFdmtiM28vVmtjM3dyWThGa1gyOGpmenBqUmxtcmUvNmVSQ0RPV3FHNWhw?=
 =?utf-8?B?S1A1bnl1KzVidW9iWXJUelYyUGIzaXoxZEZsNmtHdmdSeGdzSStVMTVsR01J?=
 =?utf-8?B?cmxHME9FdzBEdjBYb1Q4ZTRub3N2YVFYblNtU3puOWp0cllnaWtHaDZRNzRy?=
 =?utf-8?B?Ri9seGNjaEZmSGU3OG96NysrSDA3bmJSODBQSndOcGg4WjBoZW85eHBJaElx?=
 =?utf-8?B?S05qb25mcGRRQ1JLT0Vaajl0WjIrd2lKd0Z3c3BuMXdST1pQVnJCcVBKb2dN?=
 =?utf-8?B?YVdFamI0UGVHYld2SDN0bXZ3bTFENytyL2NqeG1wNFNwcndtNHJtajhKWUdn?=
 =?utf-8?B?NmdJZlhlUGhjNllEYzU1L0w2VVpYclp1WnpuczFwU2w3bWNuNGNmU0luRm51?=
 =?utf-8?B?ZmVCMHdOTmdReVcySWRRSmhlbmIrNGRaM3o3UjRKSXNSeUJXRVl2aERicXpX?=
 =?utf-8?B?Rk1nM1NpYzdFR2pkd3o5NWo4YjNNYmp5dFp4dSsxOVJvR2gwT2JqYyszd3hp?=
 =?utf-8?B?WVA0ZWtpWEFsbVlrRmhxa3gxVFZ5eTFKUk9hUEVjSVhrOXI0ak5HWmFPb0NI?=
 =?utf-8?B?TytQT05UdmRvVEY5WjdQOGJHd2VxamtQN2FBMEUzdjJ4d3BRY1lMY0dYZkoy?=
 =?utf-8?B?bngvaGVNSjRud1IrRDBQaVJoME1lRUlJOFg0ZkVKUFdSTTI1NzExbmV0K0Fp?=
 =?utf-8?B?MmZVY090THRGRHNvOFVGUEYzbkhiRXpIc1NJU2MvQjg2TjE0azRvK2ZSNzlr?=
 =?utf-8?B?OVEycE1hQWE5RCtSQ0ozVlRxTW1kV1gvN2NSb2lWL0JhL3hyak1ic3hFUy80?=
 =?utf-8?B?c2FlZXdlYksxaWtjdU13c1hIblBWbFpqTlhSVFdOZnNMYkEyV2htdEVyS0Vv?=
 =?utf-8?Q?/rmAtxQGZVyNEHkNWRGFzDXkfR1N876R?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:25.5747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfe4bba-6b39-442e-ec5b-08dc9f45d529
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

The virtqueue size is a pre-requisite for setting up any virtqueue
resources. For the upcoming optimization of creating virtqueues at
device add, the virtqueue size has to be configured.

The queue size check in setup_vq() will always be false. So remove it.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index db86e541b788..406cc590fe42 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -58,6 +58,8 @@ MODULE_LICENSE("Dual BSD/GPL");
  */
 #define MLX5V_DEFAULT_VQ_COUNT 2
 
+#define MLX5V_DEFAULT_VQ_SIZE 256
+
 struct mlx5_vdpa_cq_buf {
 	struct mlx5_frag_buf_ctrl fbc;
 	struct mlx5_frag_buf frag_buf;
@@ -1445,9 +1447,6 @@ static int setup_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 	u16 idx = mvq->index;
 	int err;
 
-	if (!mvq->num_ent)
-		return 0;
-
 	if (mvq->initialized)
 		return 0;
 
@@ -3523,6 +3522,7 @@ static void mvqs_set_defaults(struct mlx5_vdpa_net *ndev)
 		mvq->ndev = ndev;
 		mvq->fwqp.fw = true;
 		mvq->fw_state = MLX5_VIRTIO_NET_Q_OBJECT_NONE;
+		mvq->num_ent = MLX5V_DEFAULT_VQ_SIZE;
 	}
 }
 

-- 
2.45.2


