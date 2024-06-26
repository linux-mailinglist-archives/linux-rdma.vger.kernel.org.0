Return-Path: <linux-rdma+bounces-3521-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636EE917E2E
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 12:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6AC1C23E14
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2024 10:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11DF180A65;
	Wed, 26 Jun 2024 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VQpb5nty"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4AE18EFEB;
	Wed, 26 Jun 2024 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719397723; cv=fail; b=cdt9fMdUS0fsmkzJQ3HwHlnigItuIBDX22O90MeDCvB2aLRhiIgvYj6xq4wd8ZHQdiuG6S+cYcu8OWDKSzGEA3qrAvkWUdFoBQMSwf/Ii8BDNJSg3hgH55Nm1F5Mjcch6ycC4ji2CsY5ym3fB+Fzd8HK7ViyJgoQ979BSm3PSLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719397723; c=relaxed/simple;
	bh=KBnBLZMKRDaX0Ajt793FuGR2p9G/jNobTfmgv1LiTxI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Wq1QpQiHRDRSKZcf7T+Oo8P8yNmTrLYD70nzhN4DldtEIe7KRYFo56kC/hM9aSh99P+yYQbHHlJ1JIzRe/bor4S+eM4NbK5gOqESjeys/jUZ5gPIjYKywaHrMixDBRReoSbAUbo7I/ippIXKgidqvCbb7hmcTGIClHuUj7I3sms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VQpb5nty; arc=fail smtp.client-ip=40.107.94.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgk79V7g6AH+r9cGUb1XmHHWH0WjGz1NFmnMjV6o7fIcYW6GdoHM1rbjbml2Mp0bAtDfuAVWc2vlSzPk6o8UCVBV0Qbmldxj/pVPHnqo2uAzOiVBNLM3ib6Prh7dw6t/h8NqOfTyfaFXXv2+9cbMnam/gUw0q/gVafs7GCY88yR1zjQm/q9ileWMvW2djyLVkG2vgneei5JbMisg3qXZ/GDCOag0k09aW0hlbF0FCnCrbBixVf3hMohd31ln9bCokUXxJJS9pMjG9eEYZatJRdCkvOxcpIaAW9BJnoqWIDb74Ng/1EHiz/wrh4+lYgLMpsSnC3W7LYB3Q6OtManzEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9kDi5k6Pml6EGu7R9eE8ZQZvIGr/YjAOvpoY03s6Pg=;
 b=jYlJH0uSnxu7jle4Hs5uk4ITc4qHHjrgclDENMOMmrLWlpuiBJyWWk+X8UJ+WbvdkjjKUi2Ouyn+aUsMvyf/R4zXes3zIWkVhEvZnp7xFbR58DNExyBrMMwEjEh/BkpXtEnEJfiozuiyqq9r+nhnkrC1NwPW6mL06g1Jee9apAQTEXML15P6que5GEAHuvpeOjWsxXTaRA4zaEJsP0qefn/Ch/W0ZzbczF7LX3POvvwOGV4BD/RVcMQm3YAJrNBQ74xEdSoELjM8l+WwGZ6KIcfnchzn23lU4WP5lzlQcShutSZdPScq2CESNtwsLPWXB9GaelDXr6cyxHR3FmPmrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9kDi5k6Pml6EGu7R9eE8ZQZvIGr/YjAOvpoY03s6Pg=;
 b=VQpb5ntys9iumS/ffmCmINFScPRWH+QVOlyEkAY/CMdmaLZPVI8nJWb/tNGKa6JPBXy4HNzboOh+A4QCEIWny6hxFZ6FBhLpyAmQIYV30TOvDs3Q5B9JVwE3EdiqxwR9n7BC1UxufeJRGPX+56K+UsDsIoqDezxzZ7psTHplslXt1igOxGWuqfjG4sXrKe4L9FM3gJrFQ7JW1ZB/+VpEe4y67DI89yMPSwLFvoZ9SqnRrQ1mk8RuMRQeWeMqj20TP6EpDFcm/npD86oWLb/Tid2uNWZ+Uf1Z7gaWzrEAVOHPRn974uYp4q+Tx2/pXjG6p4mUs+/dp+dXvCFdm7hGqg==
Received: from SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 10:28:37 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::e0) by SJ0PR03CA0370.outlook.office365.com
 (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 10:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 10:28:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:25 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Jun
 2024 03:28:24 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 03:28:21 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Wed, 26 Jun 2024 13:27:00 +0300
Subject: [PATCH vhost v2 24/24] vdpa/mlx5: Don't enable non-active VQs in
 .set_vq_ready()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240626-stage-vdpa-vq-precreate-v2-24-560c491078df@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6a3ebb-2596-429e-b0a8-08dc95cabd83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHdLUERoV0owRUZMa2ZsZm16WlBDY1JKUSt3ME92Z2Z3ZGNpNkhna3UxVm41?=
 =?utf-8?B?K2FVUzBsTkhSTkpMNy9EV3dOOEZ0WnZUSTZEYXN4SExwSXI1UkNHVkRRT3dw?=
 =?utf-8?B?T2o5ZVU1eStCSzZuVHF3T3Y2dythNXA4SHFza1VTRy9VRThRUzFrRG9hZGwy?=
 =?utf-8?B?MXVPT1VyeE5WSzJXb2Y1VFNqQ0xXQjc3ZGZ3cndSL0NPQkhqVnlXdGJVSnR0?=
 =?utf-8?B?RVNMSEJkbE5jVVBQTlhkYmFGVzc5WUZiR1JrWnBHUkNXUDZIekFjMm05Y1VC?=
 =?utf-8?B?QnAxdEZCdW56OTFpVzRIOHhMYkh2VytzQmZadzNHTFN4VmpMVndqc21hUjZL?=
 =?utf-8?B?U1hFM3podXZIMldOV0J2OUsyVDJKTU0yaVgxZFJ4UnArRmRpNVVVVE5QeWZa?=
 =?utf-8?B?MW1HUjFKQmNZd1ZTRnEyVmdQS3hUTWlvMWRaTHd4TnQyRnZkZGFPNzZVaThB?=
 =?utf-8?B?QlhlY3ZOZUZTUUp6aThqSG53ajFYWmJMZ1pvV2Y3bGp4cWdTZFl0dnNSUUhW?=
 =?utf-8?B?N3k5N1BqakFkaFRJV0tHVWV2Y1JpMEZEeWk0ZmhuZGpCTkRSTWh3UEpHaTFU?=
 =?utf-8?B?dElhaGpRUkxZcDJlM21tdFZNUkU5L3NVOTdJajFxRjcvSndRcEtKUDBOZGgy?=
 =?utf-8?B?bTh1UWkxODBhbTJ1WWVBTGVNR3MzNS9aSWZCNkRnYnNLb29sMFZPdC9qUXN5?=
 =?utf-8?B?QTVwbkExSk5jTWQ0OGQwUEN3MnR3cHBDblY1cFZ6R1o3aExueXRlMC9VQ1BJ?=
 =?utf-8?B?QUpRcHE1dmJWd3Q0OXE2UEdDQlpsV2VMMUNBU2d6SHBBUXJzWTRCbXVwNWFS?=
 =?utf-8?B?MGlQUDdlbTBpZXdRdEVxMWZ1MnB0RS9CQldycFNkQ3RDYW1UTDlER1Y3NUdO?=
 =?utf-8?B?bkJoR0tCWENhMnFPM01DMTJyVHBaV0JnZ24rMGNtbUhnQ2gzQmdVWUs3bGNj?=
 =?utf-8?B?b3N2akU5bjBmSHdzLzZ4eTIrQmFXQzRKazlNU3NSWXhTeWdjejB3eG9EZ2ZU?=
 =?utf-8?B?SHFqU2MrZzRtbFZSS3Fvbm04WTI4anppbzk0UE1uL3VyVHJVcElZaTdmSzlG?=
 =?utf-8?B?dDU5Mk1id0VLaFM3Vis5QzI2KzJ0NGdSZkNwTHV2YVNlWG9wei9TNFMxZ2Q2?=
 =?utf-8?B?cjgzU3RKd3cxVUtXcy92Ulc4SmFkWTVzSFk5Y3g2ZW5VZHhZaUpsSmQraVd3?=
 =?utf-8?B?NTFuVldJNGZna1ZpdU52dWZIc3VHV2tYY2N4RVo5a1YzRVprSmZEYVhPUWVy?=
 =?utf-8?B?eTV0b1BBQ1BBbGNHOHJjazlWcFlxVjNxVStScHU3QTgvamdzUVp5dTdiNUVM?=
 =?utf-8?B?QkU3U1c1Tkkydms3MGdRaDhwOFYvRUxVTTZiVEZrY1FyUCs5dUxkZEE0RXpE?=
 =?utf-8?B?VEtUcnN2Q3ZmTkdyUWhwRjM1TmhGRTdhZHNmdUtxVHN3WmovbnlSclhxMlVK?=
 =?utf-8?B?Tm5KRUpvSWVhZmFwb2o3THY0UVJrc1JzQlRwNHlvZFBDUkRybVpvU1pSUHJu?=
 =?utf-8?B?empiU2dEQlp5aGpuMjJ4UCtObHZXUUNxZXBsYit4Z0JQckJCd1RNaGR1WDFv?=
 =?utf-8?B?V3lnMXJRRUxTZUN2TTY5Z3ViNW5SNm43K09ORFhBMkFQcDFSeXBBUUl1ZVNM?=
 =?utf-8?B?WEhScUduLzNZdDZYeVNyK2lvcFhHbGNwQUlxVjh1bFVwWEdTOThoMEVEbnNN?=
 =?utf-8?B?VzdRZ0R1N3loNXVPQjJrMERDSGx4UHJKVWZ0ZVZQdHVac3VlLzBWT253NmV1?=
 =?utf-8?B?VEcycUxNTkM5RFdETlRKSnoydnZqc3dsa1dOWXpuMm80dlYyTDBiRHpmcEJZ?=
 =?utf-8?B?QjJDNmVCSXcrQVRyRTkyTFltejRmNGk4ckk4eGRZc204NytDaFg4MnYwR2ZS?=
 =?utf-8?B?VzVJUkR3Y0RJVTNpWHlOeEkrMENBa1cxYWhzRlNIM3VPVXl5c3FocHhaYzAz?=
 =?utf-8?Q?EBrpvsQ+1VRfhnptJ3bKM342U/T0WqIo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 10:28:37.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6a3ebb-2596-429e-b0a8-08dc95cabd83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

VQ indices in the range [cur_num_qps, max_vqs) represent queues that
have not yet been activated. .set_vq_ready should not activate these
VQs.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 573dc01df8c3..fa78e8288ebb 100644
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


