Return-Path: <linux-rdma+bounces-3237-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E290790B4C7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A811F26A24
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB63176AC9;
	Mon, 17 Jun 2024 15:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JnZU86bk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D31741FE;
	Mon, 17 Jun 2024 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636978; cv=fail; b=idhnCF+FON4bdK2vJCTuHggU/eW/Mj9af1bAzsuKSI7EiiQzl6hpC5T/AxddpAnm7ergkaDwUdKmEchrmpLnPO2+XKO0fusNhRMTSszcsBrXmhClzbHbTyHC3MPwmix6OkUgo2WbPKjAEXjGpB4rVo9KUdsChPkIQ6Qo7R2ZG1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636978; c=relaxed/simple;
	bh=AFKqxZPICXDBRRM3Jnaz0zJRsTPE9v92jV4IJ15lGpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ocZx1YEDrgMwNt/bPtrv7AaFYxPzgjMbVJnqEFJC2gOUUK8e3p2qRnExlLQ2iEVHMlHAF2o7j+s1iHKTPL+unXGfJoYdzr0evSn8VlCUxWEXGZZD36rfcRk4KQao7Gikd0edSO2OBxUxCbBAK6WFVBX3rgW2xSS4oEIyVmGx3dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JnZU86bk; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cA1tKSCHsZ44Gl6PeVmtKVMZa8kgiPpR1fX9sYCmBMayujzXbPjOkyOufhJQXM2Jj6iLE9nPebFiNPBMd3QBMPq8N64l0PL+VqMYVOqPD4jG+7jNl6PgxgSNn1lwcHYKRLfC+LUWIVExTyNPN7SzbKbVl7PAuB6AuJFypOmWXPBWznM9LzqtFnjimNmgBLiqNAcIJ7/g36Txju2Vb0cf6bGyRBw6Op1FkmuEdyzU2uJqESaMcLYNixH3/wW6uAVuK0yevq3rA5iFnaPZuwcKZ+AKf+f/L0Cy4nHfwV172cyQuXiq9sPW+kUuoFepI77XeZb6VtGYkUu7OseSg9PoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2qeVJE78M3ALmMWqAx3P0GQv/ossQz7wdatKeTQmhE=;
 b=VfOHo2JFoiHwBGGucw8dpNRWZuFS3QOdSFjGOY0F69tNoqy/IPIuWaeinH4PZCiZMRXtiv1d1nq6735M6JWbG0fRzsSnvIrq1DfXL+a9nenPZ0aFnPlD02kqD1mGo41IW6J81vT+a8DsElO9VNUftpvZrVs6DZas152mu/WLS5CD7VGKbqYaxmh6VGGgkpMlDC7Op3ZPjXfD6Ch66d7308BJEl4uae9KS29j6kiLuupr+2oZAF2etX/jT9/Kyp4Nb++YKccVHE7RQIH4eOOFC51vtkHTRxhWLLj49wEpAJBTH8w48pLFT9BhnraYSFdHThFIIdpI/Wf91QBwIw7KUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2qeVJE78M3ALmMWqAx3P0GQv/ossQz7wdatKeTQmhE=;
 b=JnZU86bkLUJ/HXQr5Jfi0HdvpLPnx6ph70+untYPC86ixtGCoajK1tjIKLwDdstjkakNmyebqcJ50mJ0XaMnMSOLPk2dRCdsCVfmCHQziZrp+MS8KNV6LPdCfnVvhRJ5fykZv+UGNuUKSc7yxgUDHVJK+gohnaQD97DmugZO47he66RbkR5Tb+PLIvbhLO0GboHDJ4loOAouK0szuUVFr31KYCVNM8c68MWarcRWsiCL4mWeDlHJf7VtWfkYf12J9LfbCbQz5GZFdJHe+r3qXddCmlmI8ge8wOOyBhaJ4JrV8epIHGPDEZDuh4lkU7q7/dd8YS7oniQLJV6I56synQ==
Received: from SJ0PR03CA0124.namprd03.prod.outlook.com (2603:10b6:a03:33c::9)
 by PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Mon, 17 Jun
 2024 15:09:33 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::68) by SJ0PR03CA0124.outlook.office365.com
 (2603:10b6:a03:33c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:09:18 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:09:17 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:09:14 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:57 +0300
Subject: [PATCH vhost 23/23] vdpa/mlx5: Don't enable non-active VQs in
 .set_vq_ready()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-23-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH0PR12MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd2aaea-9aa8-469a-ded9-08dc8edf7e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|7416011|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVRrenhGak5ROG9sczdwSE45N0h4MzZyUTN3QXhsVVdHb3kxeWlicmVRS21k?=
 =?utf-8?B?dE9Eb09LRWxxTUZ1eHh0aGZncnAwYUcxUHc2VVo5VnMvOTB5MHJnZVduM2hx?=
 =?utf-8?B?RXZYUUh1M3I5ZUNGSEtkdTJaNzJKZm8rSzR3dU9Rbi9OQTM2aGo0TWFsaVlS?=
 =?utf-8?B?YVc3czFzRVdZTnVnNWUzM0lrTEt0V2xNQ0I3Z0U0RGlVWlRGT1hCMDlXemxT?=
 =?utf-8?B?VVk5NE53QWlzYVFEYkFmWTM0QmtkcGtvSjFpWktndEJyTk16YzgrTUYzdEpR?=
 =?utf-8?B?VWNzc1NoQitKS05kME1VQ2ZpLzd0ZktLMFVNenMvTzZWdm9CUm5xU1J2VEFR?=
 =?utf-8?B?OUd6Z1BPTVE1Z2JVSCtjeHUvQjJqaGFyUVJZdDNhc3VjcklyNXA5Sm55T2tr?=
 =?utf-8?B?d0k4R21vdnNGZjI2WE1kR1pMUmJrZ0VaY3RNMUtXSEtrZmZMTEMxVS82OUcr?=
 =?utf-8?B?MFhibUdMV0ova1RUSk5hbzRka0FQalExVFVSMEJ0VlhsNkhXN0JtWWdnVjlq?=
 =?utf-8?B?WjBIZWcrUGtSVEVoN1RyRHRyanRvc3FhdEZhWlFqQ2hTNURDdER1ZlVMOWRH?=
 =?utf-8?B?VTd0c2s2MVdtRVlQNTdsNTVnNmk0eFJJVnc3V1RKZlBrOUJkNGVza0ZES3cx?=
 =?utf-8?B?N0hMb1BDNkpCSFVBZkFKaUU0SzNVVk56N0lUdm1XcDZoZVRIR2pvb0tBMW85?=
 =?utf-8?B?cjZISlBySFNaaXhnMEt2TGVMMEtlaHFManMrMHd3TXZTRXo1ZzlCMWhSajZx?=
 =?utf-8?B?TVRoSEFlRE52bUMzcWY1KzJpcUI5NkRtbDlGT2s3bkNlV2dFbE5rQkVscERv?=
 =?utf-8?B?VkMybXY1b0I1WjdLTGZIL1Mra3B2a1h3YlQrWDFoL0Vsdmc3QXkxb1l5dEtC?=
 =?utf-8?B?UHZNdENDSXhxeDBidUV3c2duYkNGVmY2L1NXNXNJMkNpV1B5bHFJRHM3N09h?=
 =?utf-8?B?VzRjczM3Tk5xZldzS3NNdHlFSHMvUFc0UTdjWlRLR01xMGEyejh6OFJtd290?=
 =?utf-8?B?azMwMytmYzFwaVhMSmRmZHl6NDdURk55MEtFYVJGYjVQU1BzQSsrMWNFR1hC?=
 =?utf-8?B?TGlZSDE0VVNZaHY5Qnl4YmZTd1h6UzlXcnRKQjRBVkZqUTduRCtWTyszbm0w?=
 =?utf-8?B?WkpnbXJaOUtLTXNicXRTMzhkRXdXZzIzWUpyMzA5V1VkYkxmTStEZlh3a2NT?=
 =?utf-8?B?YmtGYWZVcTNxYU5PTjBtakJSTm5RMlNMQ0g5NkE5amFCQ1BCNWg5ZTA2V2Nv?=
 =?utf-8?B?ZE16RysyeXd0WjBCbWk1ellHN1RsU0Zsd285aDRIeVJFM1QzQTFDdzlhQnAv?=
 =?utf-8?B?RVpkSGcvSTk1YlJ0cnhtZEd6VWMyOXJlUXN1OE5LUEtTcjVsMnVOR1FPejV0?=
 =?utf-8?B?V3R2RXNGUTBmL1c1SGxhNUlzSFNnbE9vNTVNYUZVQ3lXVDBHV2JxcVFSd3hx?=
 =?utf-8?B?OW03SSs4V05SY0c2YUgxUUpvQnB5T2J5bGRvcnltQlpyaThyVHduUTRob1ZC?=
 =?utf-8?B?ZmIvVW9pNVZqMlJjS1pneER4OEtJejN5NEs0RHRpWlpDYTFidkM5ZEp3OVRF?=
 =?utf-8?B?WW4xV0RYcGtHNy9vTTdUSW03TjhZbmRwT3B6dU0yaFJubmZna3ZTTUsyR1Y1?=
 =?utf-8?B?M3RuM1pUTWRJS2Rjb2htRFBqUTkrUUxUbWVYclhhQUdWUnVDQWxtd0xtaGlo?=
 =?utf-8?B?NlZOVjZUZWM0SEVtN25iSjUwekRRMG9JcEVIVkFMS1pMT2tiSTM2V1FmdW5s?=
 =?utf-8?B?VHZwbHJ4OVRxQ09QaTNkRGJpSDZieklOMEhvaVVSRlZMVlRQU2ZRMDR4ZHJh?=
 =?utf-8?B?dnpxZEFocXRjNkRuVy80WWZYdzdiRHFHaWJxcVBYUUxrbHVlOGRQZFdiMkN4?=
 =?utf-8?B?MGkyMnVDK0lVandXdlJMaWZjQktDZHNBZitxWE9TaHQ0RVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(7416011)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:32.3144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd2aaea-9aa8-469a-ded9-08dc8edf7e0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7486

VQ indices in the range [cur_num_qps, max_vqs) represent queues that
have not yet been activated. .set_vq_ready should not activate these
VQs.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 1a5ee0d2b47f..a969a7f105a6 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1575,6 +1575,9 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
 	if (!mvq->initialized)
 		return 0;
 
+	if (mvq->index >= ndev->cur_num_vqs)
+		return 0;
+
 	switch (mvq->fw_state) {
 	case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
 		/* Due to a FW quirk we need to modify the VQ fields first then change state.

-- 
2.45.1


