Return-Path: <linux-rdma+bounces-3735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998692A20C
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 14:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE961F23C5D
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jul 2024 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7F4145A0A;
	Mon,  8 Jul 2024 12:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="svltZ2Sz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A178249E;
	Mon,  8 Jul 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440158; cv=fail; b=h1i+L95Ozd7f2g06jqKbBrk+qh5z5iqyFbGgXHnLPvVgvcwHBY7KHyGsKYbdVkaJCLefeVL0t+BXIa/rpQgp/KWVNqDRgVI8nMKQb8fjgLvtoiM6LVx055bY124FwWeChMSSRmaGjE520bFcz7Cu9bosGdcnsrYwXeWa2JPFB4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440158; c=relaxed/simple;
	bh=uctDG5PQZrDUwp08ZBTd2qutlOZ9mskZpLh4FSJYwZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VlKTTyIrmZFK1fS6e7jcxGB9QMQVplPlJMXT6AEH9l/g2Nb4WZcdVMM/CXEo2un0lfhv8iXnnhNn9WoiXRo5Y2SFYNGA3sVZlEaRPpnl0j/M/gjQ74YIXmShJRdla1Qz/3bVV1ItexYcF0YLXJj2+jfPtmK0p2xTNJ9J4fvhiiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=svltZ2Sz; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRfwXdE6TP9BA/9KOHPAUcyD/et7koelELdNp5hqmSd3GuOEyPk5IW5HXk/pIEBE0KNvVTn5a7cf6IkZmeB4JBTC6J709MWfR0uCtD8g+MxPDC9RauQejgQZYI4quz6FSL4ADJXYXciWw6GvyFjmLyf0vRLyrEJIltiWZ8zGvquK88w6BNYcE40+TANuGpMG0BfdsBMphYd8KyuzAZ3LlbDjlrW8qujxWw7pnO8mv1uyY7lLGXe6ugdYKMyCA9mkV9G6LI1s4rXVn4R4JUlxNPzOZpeIWKWkSEv10JDHwY6uAx2tgqnA2ntMyoXcQ+UNDBPynmBQNsE4PeuSrTCn7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOzLcIPJYtRp1TBm3A15bBVrHGfH8AiO7M5YDX63Uqs=;
 b=BS+JPCCnhujIacJbieWCBYYDFb6Du2veqKODAcCrP07+mN1BT3Fs59Q9Cv3U2w38zpW6EMq+9mgf3KZTmQwp+VbubRQ6PaTsKVW4tqlQCDxwcwNBfmNr6ovgkhDXAaK3vbzGrV1nXeKraUSgI24wDtloyew7Y3Mo9eATJLrCa5PL+YInkTa/MZk7qTT/PIoJvxjiOPWYsIUBkzmVoU58yyuuECiKeDGodWhNLicwqlufSqquZpp3lkTsEi6gmch0EIKvlC8E/cWfqafFtueKuoAVJbvhf0MeGaXUXMdYTZpgx49XhhozIkXryfQxba4EHW9S8GE+ApokQEUxE4ZgNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOzLcIPJYtRp1TBm3A15bBVrHGfH8AiO7M5YDX63Uqs=;
 b=svltZ2SzWI0Z9LPo+1fRMri1cfe/KsucGOkkEDtxizIInCgN7fYu3iV5sc6jy+dRMKamlipMv/EpuDqGrxeksNCzYaGfZideWXD90YXF769wUfRJ0rp/j5D1QKdTiEwpY2rc1zrmsaTx4CuZm/Lm4tVqPGDhyt6/n2pv/nTYwtR/pjAqp+NpBnkrWyQuC6y4Uf3gPvbj1VR3Hh0yF9ul6fmL5F54Xqgzotj5XnRfCXRVWJ3RvibAeQm968YQQMfTWXVFZMrbfg8qKKzfxmVSIP86FR1dhfSsvxYOqCbpyvGR/XVWWLBjLO2MXAjAbAUDju5Mcy3Aa7VCTDWISPHG1w==
Received: from BL0PR0102CA0014.prod.exchangelabs.com (2603:10b6:207:18::27) by
 MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Mon, 8 Jul
 2024 12:02:29 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::cd) by BL0PR0102CA0014.outlook.office365.com
 (2603:10b6:207:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 12:02:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 12:02:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 05:01:51 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 8 Jul 2024 05:01:47 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 8 Jul 2024 15:00:37 +0300
Subject: [PATCH vhost v3 13/24] vdpa/mlx5: Start off rqt_size with max VQPs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20240708-stage-vdpa-vq-precreate-v3-13-afe3c766e393@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|MW4PR12MB6753:EE_
X-MS-Office365-Filtering-Correlation-Id: 8752057b-a185-4cdf-d55a-08dc9f45d739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG5NZEc3VW5LVmpmSnZKa1c3eDNHMCs5TVdSR1kyQ3JsSVJTUXNJTzFWUnBx?=
 =?utf-8?B?Nm13VGFHS3h0dlRta1Y5bFhiVE5GQm1TS2E3U2xxRm1PYWIxRk9QTEcrY2VB?=
 =?utf-8?B?Q290VFJDRUw0cWFBNUZXTVBibmZLbk9KQVViRWtyaVFSTXpBK05TbURaRUN6?=
 =?utf-8?B?RXQzd3RUVkZaYmJQYlNETlRwdTlicjR4Q0gySFlqb3FTajEyVUVzcWhXTHFk?=
 =?utf-8?B?ay9xejFJakV1N3pwNVU5Q3BOa3pidE1ESlYyMzJzRTcxcHRSYjRFVXZTOGIy?=
 =?utf-8?B?NUV3YnBqQ3RsV1lxdXcxTG1JemxwaXFFZDBJeXQvNWxpTm1XZjJUbzE4MUhB?=
 =?utf-8?B?cndHMTVxL3UzWldINThNVkdjd0phTHc3T1J3OE5yS0FSQXJPRVluekoxbFZm?=
 =?utf-8?B?aGNlU2hLVHVzZGx6d3RNcnpXL1ZvSCtZbmRJMzIxL2NadVdsd1ZmQWV6ZWdC?=
 =?utf-8?B?N1lPSGhnUHhicHlZeDBEdThFb3JVOXA0RkdCTjdlNHEvb2xxdmJiUVdKQjZO?=
 =?utf-8?B?dlFCbEs1SDB0LzhXeHV3TElDa3RacTc4eGw3eXV4dGtWK1FKaFhxODhiYi9n?=
 =?utf-8?B?MGxaeEhxQlZ2TGRmbFdIUXY5eTN1WVVPd2JCd0ppQUdKN3RFR3dmT2lkTzBi?=
 =?utf-8?B?RE9qWjhqV2h0N2dsRUIxSVV5T1h2ZS96eUsreExZY2lnL0VQaVRJejFxdlhU?=
 =?utf-8?B?UDdVUUNtRXcvcStYOU85NVpHaVZpZnk4R2xaWUl4QUo3VUpxY01rc2xPQkNi?=
 =?utf-8?B?RkV2REZUK1pYSFRqSkcvSUM0a2ZDb09iUlhYT1hPWjgyTUd1aUd0bUdNNjZt?=
 =?utf-8?B?MVNSUW1PbkYreXo1ak5sUEkxZ2wzVm9QbTNVOEc5c3lMU3hIK250d0U5NWpR?=
 =?utf-8?B?MVkxdTNvNU1jdUFhVUIzN0ZnNEh3Ti9qWFJiV2xlQXRscWhNcEZLeVZ0ZGRy?=
 =?utf-8?B?bXRuZ0J3U3hMa1Z4YlNyN1c0YzZxK1gvMGVody9tYUY2RENnbGRJbGNCcTU1?=
 =?utf-8?B?VmVGOW1tZlEvcXlZUzZPQ2EzdDA0eVFVSnNzN2ozZ1k3K3BkT1ZrUXAybWNW?=
 =?utf-8?B?UllpYjQ0RlRLekdVWDJCVHBsdTlDSlBRYlNpZGRiSnNNZUk4dkd0R0ljSWRF?=
 =?utf-8?B?S1kvdGpjQjVZZmpnaUpLNUlDL1BZZUxoNzhmSkJZcWVHWXYwV1BBQVRvZG0z?=
 =?utf-8?B?ai84NmR3eEJ3RmtUamMyUGwwL0srazhFWk5UVitxWlFMWEsxU2QwK3JKV1cx?=
 =?utf-8?B?MlhQRktXLytUQjNSU21zbjRtUEZEdTR5Y1V2clNVeStNTTZBQVFnbWI3SGp2?=
 =?utf-8?B?VzEva0V0OHdRNDNadmc3SERmZEpJdmt0M1FLOXJWSkQxMlZPKzlGZzg2ODVQ?=
 =?utf-8?B?a2NYYnFYeDVJejk0OUJ4elE2V2ZRZVIrL3NGWVJpTVJQQmJGa1JzQW5udHMx?=
 =?utf-8?B?LzZYUnVEODlXb0tpZnpWY0JzelJuR0F3VkVkdDkxWE1qNlludFY4U0FoaXEz?=
 =?utf-8?B?TFI1aXdQTG9xNm90MU0rWUsweWxxa1Z4Wm9PaEV3dTBLVkh4UTRId3VNbW94?=
 =?utf-8?B?SFFzODRwc1ZRMlJZMDVQRUE3WnFHeFh0R0U4Y0I5RUpBN0dJZ0dZVzRnREdM?=
 =?utf-8?B?c0ZuTVRkRWYwTUlkVXlYV1lvTk41Z0Y0WlZXYTNSMkFGempUT0tnTzAwd0NI?=
 =?utf-8?B?NFFVTVBiQld5UXUycXBxYzZYREJrUHA1KzQwKzdmMCsvSWdrMzM4S0ZTbVFE?=
 =?utf-8?B?YlVmSzFoc3Y4MUJzMGN6Q1phTVdMZTZweFIyM3lOTEpXejZQVDltZHNpNHht?=
 =?utf-8?B?MEtZT1FpYzh2a3Y5QkhsMnU4cmJuWmxZclQxOUk2YTRtK0ZrL1N2RW4xR1BG?=
 =?utf-8?B?K0J1RmJLUUdacmJoK2wvMW1acUxZSC95Z24vYkRFbkJYdi90c2NSb3hMb1NI?=
 =?utf-8?Q?m9sR7d9GqboQyuSBjIlnZ4arRw7sj3F3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:02:29.0187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8752057b-a185-4cdf-d55a-08dc9f45d739
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753

Currently rqt_size is initialized during device flag configuration.
That's because it is the earliest moment when device knows if MQ
(multi queue) is on or off.

Shift this configuration earlier to device creation time. This implies
that non-MQ devices will have a larger RQT size. But the configuration
will still be correct.

This is done in preparation for the pre-creation of hardware virtqueues
at device add time. When that change will be added, RQT will be created
at device creation time so it needs to be initialized to its max size.

Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 406cc590fe42..7f1551aa1f78 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2731,10 +2731,6 @@ static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
 		return err;
 
 	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
-	if (ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_MQ))
-		ndev->rqt_size = mlx5vdpa16_to_cpu(mvdev, ndev->config.max_virtqueue_pairs);
-	else
-		ndev->rqt_size = 1;
 
 	/* Interested in changes of vq features only. */
 	if (get_features(old_features) != get_features(mvdev->actual_features)) {
@@ -3718,8 +3714,12 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 		goto err_alloc;
 	}
 
-	if (device_features & BIT_ULL(VIRTIO_NET_F_MQ))
+	if (device_features & BIT_ULL(VIRTIO_NET_F_MQ)) {
 		config->max_virtqueue_pairs = cpu_to_mlx5vdpa16(mvdev, max_vqs / 2);
+		ndev->rqt_size = max_vqs / 2;
+	} else {
+		ndev->rqt_size = 1;
+	}
 
 	ndev->mvdev.mlx_features = device_features;
 	mvdev->vdev.dma_dev = &mdev->pdev->dev;

-- 
2.45.2


