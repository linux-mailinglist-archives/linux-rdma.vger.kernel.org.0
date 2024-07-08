Return-Path: <linux-rdma+bounces-3743-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82C92A22C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496BF1F25D6D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D414D70F;
	Mon,  8 Jul 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fd2xfHsO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53D514D2A3;
	Mon,  8 Jul 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440181; cv=fail; b=o/ZWxikE/Sus8vNZ5yEtEyJlizxHrbBcuN3c1D5I01SvpTqCHrKDc/MnRRdvOti3IFw+C21NVLMgdjtwHs+0YerXGIsYH6cluPvb0GC1b2iuF1s8FwJ0zl/3Yry/9YW+KDhhij/Fs799pw9qjL4bWHCDCtfSffdcKIBV3TgR+NA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440181; c=relaxed/simple;
	bh=A5VrFzTMxPT0EgZnn+WGlbgID/a3a77z+U7WttivrBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ewtbQ9BR04Jlv2Mg1/zny1bguLSfYSulAmXGxww1QKQhZEdusrpLniuBi1jnMxa3zHKDElW2dAIaf+w4OSQ3ou48PavSnJB2Nh8Si1Oi1v5zgrYnHDtzASZDpaSl7LPxNrJ6cCBwlxpq7fwy9KkgPS3F3l+BZoYvF6262Hi36ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fd2xfHsO; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZFvIAdoYcsZaq4CtIfrgvC/UKS5MzlV4tj4ltWdc/YPf00hQJoHJRi16eqxeuhJC9RM9c81ID44dabHEPWxlkL3yJy/4EoWTZRu8+YwoPEbrUfWZZKSDhIDba6YHYlz9mEacTo1XyIbzj5iFmxbHxYz/Q1UzpNg/MbMFgJ1kstwTXSfNstswjOWVQI7i2/RteqOAAIaTws1GC4dtgzv3llSV2FidEFqptUL3kISAfTVnySKCXm3shgCwUNheiR0NABFd3kwurLHqWPftYM2MvNxcBpSFwgxZT4RY7Ey/zgJkiMSnp9xTXVZk6Vp2rFNq7fOI9fX5nLsM2DJugfZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q6lmaZBID6zQ2E9GNyKHsYArsrVBmSblcaZV7VcHDo=;
 b=BpImp1B0POFI/+nyBWkw5ewncqEmrhZGZf24uXobayjVMm+9jKjBeHUm/jPFgXgccMIg0kQk636PyH2onXUjXv+jdaBrX6VPZuZFpt4KKdLdYuX2oEqaAs7ArMroZzEBS6dPDmE2KO72ea7zZLggBp3aatXT2cLeqoibnyQGMM2/XqcF9NpIpUuiQpnXxF5ZjMPZHYTbbrEiSBEeKR9WBMhzBOvvHTOh0WF+Mr7pZDWJquqB7WMoqyMrald+8B2Emj6i3vAQ9P8eaYsFllkKuMdrCbRrhQgFTkzuwNMauKaC81LA6y8gZoZo5SivxEd/A7bUP0wH2xn8Zw4+ebCenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Q6lmaZBID6zQ2E9GNyKHsYArsrVBmSblcaZV7VcHDo=;
 b=fd2xfHsOOiEDtYDNSptOz80Ihl8ToTSSC4+Lp2sARiCCYZ/DAPHyWm+/09o2C7410yQtqFKRtF9/OjnaPpITgUrv7Y3lPMcvMXJJZDF0yRTvEYsM1RQfeVZEtYgjVhRMAc01tx2rtZ6Kpln4SITZ6q7HTRPNjUkVu4MQnEVUaBNm6XSE4psWJGUrv5t5Q9NKRRaBeUlNevMA+kV3dQy5/14SOhi8r2e3NVzl51MMoAVFtV09OUROnhwDF8mfe0HpkTja9jcZ3DBoXf8sT89CQUJv/1Db31WjQs7VjbzTm5e7+qot5C09l+adkM3cHS1Vshn44ZrJvIWEPBW9ZugYig==
Received: from MN2PR01CA0016.prod.exchangelabs.com (2603:10b6:208:10c::29) by
 DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.42; Mon, 8 Jul 2024 12:02:55 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::8e) by MN2PR01CA0016.outlook.office365.com
 (2603:10b6:208:10c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:55 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:02:35 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:02:32 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:48 +0300
Subject: [PATCH vhost v3 24/24] vdpa/mlx5: Don't enable non-active VQs in
 .set_vq_ready()
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-24-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: a759b9cf-1057-4fc8-7a05-08dc9f45e6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dTRXS3NEdXFTMWcvcGhlZHhNMDVIMU5sTjdGcWcycFRYMDRGdG1HcWRZL29a?=
 =?utf-8?B?RVBDY1p1dVNBMmU4NlluYUxzdVdabUZBS2RzbVgvOC9haUVpYVVzMlZMdEl6?=
 =?utf-8?B?MGwyTkFOSDRQZVlXRzlITjR0OEY2d2QvNW1BUVc5QU82dGx3RktqTnM2cWYz?=
 =?utf-8?B?cEVxbUNVVk03TkV0L0tiSzhjc29MOGdyRUpFN0pTUXlURFBPaWUvb0trbUNa?=
 =?utf-8?B?VFVtaWc2MDBOMmw5bTZVYmNGOG8wSGV2Zm9CaHRjV1RybUtQVjcrdG1UR2hC?=
 =?utf-8?B?c0RYNDIvZi9MMnZad2pZNGQ0Nm5vYVJ1dUVGWk1BN3hTV2VtbXU2dnZBVlF5?=
 =?utf-8?B?Wnlqd1ZVOVBlcHpkRVBXdE5DdGx6YSszaEFGTCtZYW92ZnQ3TFV4NUdOSGhJ?=
 =?utf-8?B?WTcxME43S05GN0Z2Z3lFd3Z4WkhPc1VWRHFVb1VTSGZLdG9QYlNGbmMzbkU4?=
 =?utf-8?B?c3Y5Q0hyc0NCekkraU1yaUM0RXBGdlB1YkZaT2NzUDVBZ1Y5ZWhBUUZkcFlz?=
 =?utf-8?B?cUN0U25zOVpCRGV2UWgzVTRrNWJmcFhYcEtpTFk4QTRjOG83TFA5OTZkdVVF?=
 =?utf-8?B?ZXZxcnB5ek5NQjIvcUdzNHFFMk9tQW1iZkhaUnY4Wk1RbFFxcUcveVlFM1Vh?=
 =?utf-8?B?K2hrMTI4elV6ZGxDSEhaMEJyMlNGMm9LcUIzcGxqdG9aNnprOEU2YVZtelU4?=
 =?utf-8?B?QVRlenptSlZmbkM2T1NTQ0NYeWtUT3dqZ21GbjUvNUJCQzRacjE0V085NW5U?=
 =?utf-8?B?QUFySmZFRm9naVlkZVdydldVZmVVY0htYXU0dnVpbU1mSmxucEFtams0akFo?=
 =?utf-8?B?ZzhMbjYwRjZJd25MK3U2WDVXT3UrZHU3dkpZMlZBTHhDdzRsNktTRWhiK0lo?=
 =?utf-8?B?ZXc2UlZPZit2Z0dCcCtPV2U0am5wWWh6VnVHV3ZvNGQ3L1U0bTNzUlFNVUNV?=
 =?utf-8?B?YmVRdXRJVjlPNHB4QlBYUXVQT3hkVytWakZNcmhzaTFTbFpBSGZMQnZQa0F4?=
 =?utf-8?B?N0xvakczcGU5SXVDbERURDlKK0pHR1k4RnVocWxTdUljUmpxdHZGRlllRXhv?=
 =?utf-8?B?SmNoQU5BMGJveVJEbTBEbjF2eHdTdjZscjdWQTI5TzBMU0FucGFBeHg3OVhk?=
 =?utf-8?B?a1BsTWNrMGF5WG1XWUhGenNDaFI3WGJGNm5JeXFMVjIwb3RLdytBY1NsVmhJ?=
 =?utf-8?B?RVpxeUtXTXpxdmkxeVE5dlEyYkxSVXRiTmZNTy9SSTV3WTdLT0RTZUNmTHBw?=
 =?utf-8?B?cHpqS2pwVk9VYUw3dXhlTWcyVFFiTW81OFNib2QvTGVISTBIVWFIcXZnVTNr?=
 =?utf-8?B?dnRjRTdpRlhjbHJ6U0FuUHdyT3ZITjNrSkEzTEt1bi9kWTNMZk5lcVRsUy92?=
 =?utf-8?B?bTZVazhSN01SdGU2NENDRnAxb25uMXY4YXU2L1dMdTR4YzdTdDZhSS9QYnFv?=
 =?utf-8?B?WGxBUGVtNG8ycHdOREFRbnBXTWxuWW1mSUR3RjJyR2poZzlyTDVKVnZUcmxO?=
 =?utf-8?B?U09KYktZQi9ZVTNDNTdRMmVnZUh4TGhtMkszY0VQV0k0amllempoU2ZrN3kv?=
 =?utf-8?B?T09oRFBrYjRWcG1mNW92T1BzUmpZRXdSdldNQmp3UWxjeGdmaVg3S2hWNkV0?=
 =?utf-8?B?WHQ4QjAzQWVxUklGT0dzRDRrVTljMFE2MUdOQyszeFZod250aDR4dFR3VzFm?=
 =?utf-8?B?bWJjS0phd0xkNDBFNkxGb0xZb01yamdKc3RIa0xaYksrVlNhT2tXU0drSFVN?=
 =?utf-8?B?d2NIY25HZXlGcjVUZmI3enRvbDg1amZnbzJrM2ZwdSt6RW1NeTVYNFpwejI5?=
 =?utf-8?B?VUdZUllpVThkSUgxckQ5VWtUY3dTMzBPQVJoSzJ0cmhSNjhSeUZaOVVBNUZo?=
 =?utf-8?B?OGdZRXV5WUpKaTliNDQxc2k1aHp1QkZ1SlZ2dG5BMTRlYitDczJYRG5nUm1y?=
 =?utf-8?Q?zVpb1eufPMh465YcaHHFlFFEhRvzkqfH?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:55.2898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a759b9cf-1057-4fc8-7a05-08dc9f45e6e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

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
index 4e464a22381b..4557b2d29c02 100644
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
2.45.2


