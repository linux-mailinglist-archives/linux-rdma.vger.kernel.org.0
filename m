Return-Path: <linux-rdma+bounces-3217-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7D490B48F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0EAB4468E
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4A13D2A0;
	Mon, 17 Jun 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UFMO3TjQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2046.outbound.protection.outlook.com [40.107.96.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539C813D255;
	Mon, 17 Jun 2024 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636902; cv=fail; b=bF9WaGGHX0/MA2AdimTU5cW2aBueZTT2d8t3OphFdQMm071qVXw3RecWeppTJUPy+1g3b6mjsYmIwETAqz3FjZ4oT/E8phCor7Xx2wHgJGmIYKqyx9sohzE1UgI7zda892jFvFNHIwiivm0sQyYkaq6W1Pwy4dqcgjA7GldSfAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636902; c=relaxed/simple;
	bh=31tu6QW/csWgaBPf3pU+rLm4fxqdQnI6YJHErqHH2GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VO3pfNYZeFy87LF2r4kqlslvEVYli0l8xl55Q2vOODEfS7cIR1tXSaHGRfZJSO/xwhctlM5a5cRItnBOiGZmP9A7CW5bspzRd8mg0GRVHvlcIbFC5YX2cRqd+O6v4Xa3jCRdCgk9RoafMIOsnMD+GFgpsikVbaXNzb8Z5fD0ZIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UFMO3TjQ; arc=fail smtp.client-ip=40.107.96.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E92RI0X37FXBhoqB+taQFztbFa6tQe9zeJd1mci+Oy8lb9fHgge7LSKzvMRIRQ846N0EfnLe4VPbp6T5gt8HKvTzrYT1etaQhelHyizFO/ConqTFuNaFJCPQGgeYW+LfH0Kbdt33D28rGh1vIdJcqECh8b2jVQKEwtZM/2OAcUWKM/SB/2mamGH/CpPDLhxi74QXRX236xjh1p+1XcC+0WFExh/MxOj++Rw3iTJg+rTmC3JuyCIGMLHhjRby7eAiKDZP/153eKzhUggeNZ3sN6GCUjmvhDJGqB+wP6rxb/ydK5gvRlOubCLIk+TNOiA7BNLWuicUuv9Ow3OcigWpVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n2Cyrp7dTR1fq08H8JWrGW2H3ySaVka4YieTkKJ9mgA=;
 b=mBkrxjwdbXyyHg5M1XrSlQlQlg3jXFaUqPUj+5gyaV2RP2USnLFUW6/xZPka+b9u1zGbdpGabuvGQ/syMMUYBdcWmFZ35TG8aOF1r4LFeuuR/qfT+GLik3zNgLBMMgar5wf/XBqg0xNN/Hm4ji2hUZUKZIR9bDwW+mRPY5XN0MPy3neqn9Q449rdcvOepgzeLZS+/67tOe2FcWIn2mTEi3IMMmdmD7VE2MwMnulAsqJud2D8ilbpfoDTy5G799ADowrm+f1LiJYLy0lboxN1hupmBxzab8EyrS7YjRYfXWH71kOdGCc3MXwY/pliKwgAGhEV3rMLgchBKzj8WycBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2Cyrp7dTR1fq08H8JWrGW2H3ySaVka4YieTkKJ9mgA=;
 b=UFMO3TjQV8/tS5n7cyvQ3S54yapNn7NjGNQknaXy6ZX8dhlrkmwTJitFUgF8kgAOQQElMEufpVan18cpl0vQhS6U3XfHVW9nGBhdT8AT2aj4PIRKZ5P4Cd0f4RcsFdFOQrJgeXn+5jj5kQfDqYiAiQ2zM2GYQvnuyN/tx51QJ6dt6vBTOlB3Xrtbpt8Qg2JtftnWTWvI+p+5Cc7wX9ksvvALKyn/9dXaDgWYLvrKsIRI0PyQmWN27wKYHcQNwcS7VPLZ08Mp1YXjeN/xTATWeWQsOT+KQCY826LwIkIIVgS8BVEtEhmKRJIdnuFMgkwgsvinFWavLfc5RceJrqts8A==
Received: from SN7PR04CA0075.namprd04.prod.outlook.com (2603:10b6:806:121::20)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:08:15 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::db) by SN7PR04CA0075.outlook.office365.com
 (2603:10b6:806:121::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:08:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:08:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:07:59 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:07:56 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:37 +0300
Subject: [PATCH vhost 03/23] vdpa/mlx5: Drop redundant code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-3-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d903e40-7f1f-4c77-7a2a-08dc8edf4eb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXZvdHRLTGN4d3RqS2JtRHRZZnNGU2ZjOFpXTy9STUNpdWJoVWo4enBhVGI4?=
 =?utf-8?B?aEQ0UVk2S1pxbVdOYmhsbTNqTDAzd0hhRXJUZ21EOXpYTm5KR1U4NzRSUVEw?=
 =?utf-8?B?WUxFUHowbTdWcGk4MzFVV2FxTmtwK2pVOUJnYmJuVG04S0N3aVREdGE5T0Zp?=
 =?utf-8?B?ODdjbXRSa050TTFqbXZHdmJ3a1c2UHZQTVhjZHhkYkN5UXBLN3QySFEwUnFm?=
 =?utf-8?B?YlAzc3QwNXBjS2V5RW94V2x5dDJYYXdWNWs4RDkzMEZLblhpSEJJM0dnRGJN?=
 =?utf-8?B?UHl3THFNdDlQZHhBd3hQTW93NWRmOHdGOGhWRTJJRE82eXhaTkt0QktvT0xy?=
 =?utf-8?B?MjJmc3VYVUlWbUhTSGcwM0xZVm1pRTJRZUZGZlJhc29VVFRJM1FBK0JvV21C?=
 =?utf-8?B?QXVoWmlVZkpOczRVeElOUXllYWJtdnp4S2lHM1F0NDVtKzUyU013a0tya1Rw?=
 =?utf-8?B?Nm9ac0JIclZ1UW1XRGZYR083WEFjUXFjajJFdldSWk92cEdnRUlxVS9sOEcy?=
 =?utf-8?B?T1lxb1BncTAyNUhyVVJid2xidjhWVW4xVDBFaVY5R2Qxd2xPM0N3Z3Jyajkr?=
 =?utf-8?B?Mkh1ZFVTOFN0b3pLb3F5UHAvdlhnc1VxamxKQzBxUStHeVlFR2gzQTdBS2N2?=
 =?utf-8?B?bXYrQXRZWmQxdE1oUU5BOGFzZG9YNlNoV2ozN1hjVVF3Nk1DOHU1cGNaQjAw?=
 =?utf-8?B?a2FYWm96eVF5cDZrRnI1RTBaeGk5UEFVYWRyWWlyQUhxVlNIbTlsRUhQYVFQ?=
 =?utf-8?B?UFQ5MGpmc0ZxemV4UjU2S1dsVTA4eUhpa1NXUVI5bll5cnAzNldwZGo2eTZz?=
 =?utf-8?B?ak41dTVIZ00vTWFzK2FobndDSThIelgvN1ZDNkJJSm5SVlNQdzMrREY2TWcx?=
 =?utf-8?B?R1F6V2J6blB3YVEwUFQ2M05LSndKQTA2T3FITURMdExMS0FQUjNIWGFLU2I1?=
 =?utf-8?B?MWhsNUwxdEduM1RzQmFPSkx1ZUZ1NmdjTEZiTnFqVjJrTXQ5ZkJUMVVGaC9x?=
 =?utf-8?B?Z3dqOTEySUZCek1SbmNUOFNEWWZJVWVJWHArZHY4VS9ZNlFGUTdDQ3hFVkhV?=
 =?utf-8?B?MWpEZFRleG43bWhCQWNHVDlhWU03NEhXQnY5TVE2Nm9seTBOeUVWdGEyeWxn?=
 =?utf-8?B?dFFGQnRVcEpkZTVZODk2bUdXc0JCNm9aQ25oSmxwOW42TlhzMUJkTFZkZlpL?=
 =?utf-8?B?UDhoVkpSblJwQ0l5dVpwVkVaQytNbmZtTG9FdlQrZEI0bzdvb0sweit2S2N1?=
 =?utf-8?B?UTZwYXdId3BKanlPTnhjN2c0Smg0VTdKT2FDS2xMVUVVL3lQdlVSbVlMUFFS?=
 =?utf-8?B?bmpBRzg5QjlxN2luZ3YrMisya2hPTjdLZ3BTWmoxMlVIUDVNKzgvNzhpL3lO?=
 =?utf-8?B?NGwwcktRMTZUZDRqYWNMSXNhMVJvSlpXWDE3M0ZkbS85QUEzYWtnUlhmQzlY?=
 =?utf-8?B?cVFKclBpai9md0E2REhSaXgrQmlsV2JMVFpERkVIYldNZUQ5MlZtaGJaNmJt?=
 =?utf-8?B?aVRPTFNoZzRnbU9nTmhzVXpRcWhwWWV3Si9pakYybHViZmt5ajB5bXVUdWo0?=
 =?utf-8?B?UFNFa3BudCttbUIzWUJhK081NnVXZ2kzZlJxeHZPTlA3cVJ5T2F2UVVveExG?=
 =?utf-8?B?RTRPemJWb2NaanViSWdaY2JnQUJ2OHdGM1ZrS0Z6dFl1VXU2dkZmUmI4WEIy?=
 =?utf-8?B?Tk5Ka0E1ZXBKa0RJVGgxaFVhNCtUSzNxTGpMUVlBWUg0T3QwenhQNEUxcCtZ?=
 =?utf-8?B?Y3FmKzlaUVNvQWtNbkNXMnBZVURvZ1dYZExLcmw1U3Z4eG9PbS9rS01IUmph?=
 =?utf-8?B?b2NnNHU1RXJ2S203QUdiS3o3V0xHRXRUSW4xMUN5Q0F4SEZNL2NUeHBOZmpx?=
 =?utf-8?B?T3NGZ244ZnVYT3V6dThPelNsKzV2UnpMK1Y0SEFRL0hDa3c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:08:12.7713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d903e40-7f1f-4c77-7a2a-08dc8edf4eb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788

The second iteration in init_mvqs() is never called because the first
one will iterate up to max_vqs.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
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
2.45.1


