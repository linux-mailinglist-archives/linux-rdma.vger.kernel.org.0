Return-Path: <linux-rdma+bounces-3229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB090B4A5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106621C22BE5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373D115217B;
	Mon, 17 Jun 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwL3qOiu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FFB15098D;
	Mon, 17 Jun 2024 15:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636954; cv=fail; b=Y6MWTxYEXiFM6m6pRLpVJU/Hk3UJo7BORNhLOrcz6IoKdQJ9ySq0GbFWcqC+EEW3WLecUHyWNeprHxhjJSFGPA4ankOH8k0nYoq5n1oYLPog84lBwApk79C3u83rsOkaqURtLBuhTA2NPxlCtWZXf3oINaAJjWjx4rEeTfOUeOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636954; c=relaxed/simple;
	bh=1qJwzEUXHIoryHN7/mvuG6DqMOWyvAYPivd2gUhB+aI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qsgZXtC5glZOg8aP4qerP675tVRSE2wd9qX60outJbrBcy3pyp8ImdGgBTj4QAIdX9U122ilQWlJJBmM6hZzy1IJZ41tLxR/q5/7QK5J3WLFJJbyegrDTiHeJ2Zyjrqwt6RH4s02JjkzGTFgOOyhu4J48ZTgcb8dsDhBApel8l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwL3qOiu; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwsQAXn6R/VRvlOiRSjhPNCM+9fQKD1gd6MJG9SwdX9JGqA7HlsrivIPkf+FRJWbvpcZCE6HUKXSrdDv+aiP4cb2ps6re84Zp7mIrkCwRRgtgZQOB9ue538ujvUXjCBaHiVTiQHZ61yZyO67rB2dk5gTgBLrStRLbE72RNyebkJdxCpwPVAOOMh1KUP2nKqePP8rpbrPcCo1oy1SD3I0mgtYFHKRNy5Vyqg3jyd+6MzunmemcQOXpZZA5H5Pilvw/duqtvZoc1Ctl8ku/67qcFqD2cFCpzQL8x9VCaKAGeuAGG9N7hUfsruT2v2NrbV92ViieqCwSOoB71BJoQbwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9eX+AU8BIKmObJbl+Njjy+09bOEZMhAzA5zX2SkWnQ=;
 b=cKLkKmLvpWj+7ZjVLvPcSbSe2luxHU/CSximB34A7DAxYWcrwSaB2dqZjfeRzixmk+7MeZlQzc6geNu1hgZDKrj8FMwdRN0A0kZ7n3cyXZotQeq/an5RqAGUvgeqtFKCTEfwSbvOif3L3e2xNaLoiqWKXu7QENjjk38SU+qW/6tiHbL4hbLIIpuwbraVKgc94wQFXzzuEZIpbmzJoKtZrDsqV5oDv4U8gDROKMfCTsZJ/SPmmPPTIuK+iGtOdUrMy10A1sSa+JBCJejyhDgidBwpwTx6r3gmw0fiWq9HVxAFr0eAE/SqmBzCqAr3/gcDY9JFUiOt8RZRMePmSMS+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9eX+AU8BIKmObJbl+Njjy+09bOEZMhAzA5zX2SkWnQ=;
 b=hwL3qOiuTPdVdf746aTZ6AQqSZpig4/EICzTZu/+tRoCDGl9E6ob6XhmmOWln8ntzOuo4k8Z1yJ0yUG3zU9r1YOrRtBm9bk9q3zGvnLtAf/eMLV0laD3Jq71vxjj9P3JlxMyb3rCYnpZQ/dlTMBBY9ZmwJjU0txjesE6OeUPo4t+MPlDtYWN3+YjWvA2gUExVwmQH3PzpBVD4V7muhs/fIV9Gnt91P9qhDJG4Rm1kH6sagpERu7ngwpJMP/X0c+1Zld8858c+ndsK13JHWUHiAaNLpkKPV7/2FQPSI7tuKvjfpDKLSHaQp6Mq77ZWbXO21JxpNS6o2bCWiVpfajCtQ==
Received: from SA1PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:2ce::15)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:08 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:2ce:cafe::2b) by SA1PR04CA0012.outlook.office365.com
 (2603:10b6:806:2ce::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:50 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:47 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:50 +0300
Subject: [PATCH vhost 16/23] vdpa/mlx5: Add error code for suspend/resume
 VQ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-16-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 412c4610-2081-421e-9f89-08dc8edf6fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|36860700010|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RitiT0V6dXpjc2R5NGh5SHdMYzZVSWVEWHNWMDFzY0dLelJDTzVHWUZ2cng0?=
 =?utf-8?B?Ly9pNCsrMDRLSlUwbVF6anRIbDY4b0xJZk5jQWs0SmVlK09lTDB2TTUyay9W?=
 =?utf-8?B?LzJnaVg2VWthczROcTN6Y2FZSi9JZ2JpVEZNY055WmFIT1lwLzFVMzFuT2dm?=
 =?utf-8?B?V0JyMnVER096RjhwVDVyM1J6TDV2UVdzbEloQ1JJb3d2N3NRaTkxbmhsWmR3?=
 =?utf-8?B?ZGM1TmtDd3ZXdUhiZ2U3c2hjR2d2OVBiWk5MWlZRVUVGZFdFZkc4OHhXTVBH?=
 =?utf-8?B?T2RWYUdNZjE0VWNZTDhIbHNsRHlDR1hOL21qcG1USGk0V05JUDhnY1dJRVFk?=
 =?utf-8?B?WGxxc1VCRDBMbCtMaFFybmo1NW9VSTE1T2NraWE2SWg4Rjc5OUtrZ2ZnbWw5?=
 =?utf-8?B?blh5N3NjOXpQTG15OHF5UUQxRy9xaDRDK0hkSW5MTGVUdkU0aHh0Sk5sQWRw?=
 =?utf-8?B?cnJ5Rzd5UzVXSkRDeG9DNEZFQ09tUWFidjExYXJTdHFsZ2ppblVUWnVhYys0?=
 =?utf-8?B?UEZtS1N5Q3RJN1IrSm1rb1JFaUYxRzFHL3VBZUNsQjRMS2Q1UHIrQzF4dVVh?=
 =?utf-8?B?UEp4WUpyYS85SmdReDhTOTVxa0dpaFlWZ2U3dUhNOW1MS09IZ3lIYTNYK29i?=
 =?utf-8?B?TkZ0dndXTVpDVHFUVDJRSGdQV3pFbFJnSHBFektvTStoZDRsdlFpREdyc1BN?=
 =?utf-8?B?MVdsT200UUtRNkNVQUs3WmdNRGVrWGR3KzdySWRYRXBJbGZtK0tGejlLYjkz?=
 =?utf-8?B?dXFTK3IrY2xoeXBYMlV5Z082YnJhS2Q4TmNxNHh1MWRrR1ZhTmtHeXRBR3JE?=
 =?utf-8?B?ckV4RkhxY2REL1ZMblpGK0xQZnhmeG1hWk5hT0s1RTNmdXpjSDQ4NVEvS0F6?=
 =?utf-8?B?MS9zMGh3d2hVb1c2VnhWVzhNYTVUT3RZSUtQdXd0QVFNNVVsd3ZZbFZLZDB2?=
 =?utf-8?B?ZzY0cWNJa3g0ZmNSUDBHTXZWL0xwRXhGZUxoOW1yWmVSeXkxUUxlZjVYNWUv?=
 =?utf-8?B?ZWZJY1U5WlpyUXhaMFU1dmxWdnhkWG9aK1N3MUxpL3RQYk9TUysveGxyUWpM?=
 =?utf-8?B?UlI0NG9qbUFvM0locWZYMitpOGJzYm1uWFE4SVhTR0Nzc1QwWlR5VVBNZ09u?=
 =?utf-8?B?NU5VVWFVb29hcWVxRFdHQnBFSVRPSDJlbWRCQTVRY1lmbXFzd3Z5MmVxendL?=
 =?utf-8?B?REZXazBXVzVZMTV2NDVkaURjSldaS09pVHZ4Q2t4SHpLc2NCK21SRUVTaG4x?=
 =?utf-8?B?Q0dxNEwvMk9naVlxWUgvUWlFQ2pGeDRRc3RFV2FSWUNLaXUvN0g2eC9zQ2Vt?=
 =?utf-8?B?WjkxWG50ZEc4eU0vVkgvcUpWemJkSXFMdUpBQWJGaHZkRDR6aU9ON05FeEUv?=
 =?utf-8?B?NWNzbE9iL1FqS1dLNjdubXRuWFF4dmwzc0lDSTl5K0F6bEs3QmpiSngxblVu?=
 =?utf-8?B?aUd6MEtjbHB2ejRMc2VJOEVDRUFtNEx5V25SUXpWTTZCZHFSRXp3ODhBM2NE?=
 =?utf-8?B?d0E2N2lVV0xIV0t2Tys2ZXJJaFR2ck81OVA1TVFTL1NOZzRyUVhuSElucTFl?=
 =?utf-8?B?WjVrcmF0ejUxOCtMUmpndncrcVU4QkFxcnQ5aWR6ekhRREZub1E4VlJXdXpI?=
 =?utf-8?B?bVFJK0lQWEhnMnNjdXo1YTMxSHgzS2tSU29ua0wzRFlMNFNPSWJXM0Q1WGJP?=
 =?utf-8?B?TXpuVmp2L1Y5anNVWWZST3NVTWE4Z2V2bWU0Wm1PVDN0enhwUkMzdC9SZjll?=
 =?utf-8?B?aElGSzlpMW5UYllOSjNrN1owKzdQdjhDWGhmakZRMEdzZU03L3NRRk1yaGx0?=
 =?utf-8?B?Q3JzZ2dZWmxjNktKaWxGSVNpdmJ1WlFwYUhyWStOckxTRDRlVUQvd3lJU0Jn?=
 =?utf-8?B?SHB1bEd3VDQ1bWJKc1Y1aXRPcnFOVUkvVTNPR2lOU2x4d2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(36860700010)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:08.1018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412c4610-2081-421e-9f89-08dc8edf6fad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726

Instead of blindly calling suspend/resume_vqs(), make then return error
codes.

To keep compatibility, keep suspending or resuming VQs on error and
return the last error code. The assumption here is that the error code
would be the same.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 77 +++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index e4d68d2d0bb4..e3a82c43b44e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1526,71 +1526,102 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
 	return err;
 }
 
-static void suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
 	struct mlx5_virtq_attr attr;
+	int err;
 
 	if (!mvq->initialized)
-		return;
+		return 0;
 
 	if (mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
-		return;
+		return 0;
 
-	if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND))
-		mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed\n");
+	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "modify to suspend failed, err: %d\n", err);
+		return err;
+	}
 
-	if (query_virtqueue(ndev, mvq, &attr)) {
-		mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue\n");
-		return;
+	err = query_virtqueue(ndev, mvq, &attr);
+	if (err) {
+		mlx5_vdpa_warn(&ndev->mvdev, "failed to query virtqueue, err: %d\n", err);
+		return err;
 	}
+
 	mvq->avail_idx = attr.available_index;
 	mvq->used_idx = attr.used_index;
+
+	return 0;
 }
 
-static void suspend_vqs(struct mlx5_vdpa_net *ndev)
+static int suspend_vqs(struct mlx5_vdpa_net *ndev)
 {
+	int err = 0;
 	int i;
 
-	for (i = 0; i < ndev->cur_num_vqs; i++)
-		suspend_vq(ndev, &ndev->vqs[i]);
+	for (i = 0; i < ndev->cur_num_vqs; i++) {
+		int local_err = suspend_vq(ndev, &ndev->vqs[i]);
+
+		err = local_err ? local_err : err;
+	}
+
+	return err;
 }
 
-static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
+static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)
 {
+	int err;
+
 	if (!mvq->initialized)
-		return;
+		return 0;
 
 	switch (mvq->fw_state) {
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
 		/* Due to a FW quirk we need to modify the VQ fields first then change state.
 		 * This should be fixed soon. After that, a single command can be used.
 		 */
-		if (modify_virtqueue(ndev, mvq, 0))
+		err = modify_virtqueue(ndev, mvq, 0);
+		if (err) {
 			mlx5_vdpa_warn(&ndev->mvdev,
-				"modify vq properties failed for vq %u\n", mvq->index);
+				"modify vq properties failed for vq %u, err: %d\n",
+				mvq->index, err);
+			return err;
+		}
 		break;
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
 		if (!is_resumable(ndev)) {
 			mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resumable\n", mvq->index);
-			return;
+			return -EINVAL;
 		}
 		break;
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
-		return;
+		return 0;
 	default:
 		mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from bad state %d\n",
 			       mvq->index, mvq->fw_state);
-		return;
+		return -EINVAL;
 	}
 
-	if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY))
-		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u\n", mvq->index);
+	err = modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
+	if (err)
+		mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for vq %u, err: %d\n",
+			       mvq->index, err);
+
+	return err;
 }
 
-static void resume_vqs(struct mlx5_vdpa_net *ndev)
+static int resume_vqs(struct mlx5_vdpa_net *ndev)
 {
-	for (int i = 0; i < ndev->cur_num_vqs; i++)
-		resume_vq(ndev, &ndev->vqs[i]);
+	int err = 0;
+
+	for (int i = 0; i < ndev->cur_num_vqs; i++) {
+		int local_err = resume_vq(ndev, &ndev->vqs[i]);
+
+		err = local_err ? local_err : err;
+	}
+
+	return err;
 }
 
 static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq)

-- 
2.45.1


