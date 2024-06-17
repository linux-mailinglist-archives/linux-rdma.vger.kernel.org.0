Return-Path: <linux-rdma+bounces-3227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF890B49A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C912871D5
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25CB14EC54;
	Mon, 17 Jun 2024 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XcD1UXLN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0814E2F3;
	Mon, 17 Jun 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636946; cv=fail; b=fTQiFmkl92/FjnseJYHtp+i0eEaY6wW37N2dOhKdb3b/drCSYuPU26QqPWWmJSUWEM4YK8fhf7YTo6deVITqkjtRTQydgENgF/EzemDCJDItLvndlLoCcfgBRn2qHqu+hz4bpbpgRqxhIabnh8AhB4w03k93fWB+WY3syYu/XLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636946; c=relaxed/simple;
	bh=bRuejokTcGklha1Ogv5K7dMZm/jWTvvqWiQnO3jrNq8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=aMNTf8wt7dLv8xaAnkh7IX+x45Pl4+BN5Rx98xJztyXvkSgY+ma0EARbctJX6rGzSP3DgF/13TPlD9oH/JCP+OLKrFWNoq2yr1VFEPcDDav7bCC0w7+/PonOWcbSlQzhVGgMjEwWO72Em7ysIv0HGZpsiRcwNxI+E6ZvzpFqK9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XcD1UXLN; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nf/jtcaOHAWE77t2nS6Fz6DYA1dtCMdkz1P43AdRKZSY95cO2gBoiTskiTjL1/XwpI5BLdymu6aKVtCgZovKn+uGt6zgvgQmYr4B29RzW+FRGhxbISw+a0c/YblcTyS9v1dqvDTzKdMfSnapQXWAKS/Ii9X7cpCbypBrUJfForneREdk2IyzTueMz1bmT9GbC9+2FXH+rRJwjP/I/uC/LS3OdogzWtWOblLtg0KVrtYvt/uXDnPO38wqWe5piw6aAAQTlwJzPVbHxwjHeY+sZxmQAPgr8A0XDQ0KS/tg0ia48MLb7WujfBqDV00/55FsWuqLZuGdZTn4/lOlix2FCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kW3zhmW9RmiOPlX6gtQVeGNE6qk3CE502+x8haxAKFw=;
 b=Y0Rn7v4CjSCSBQvT70Ha4c5zcreTu/TGwyeYMvqRIoPbivkOSWg43ONGnnzOnGUH6L1jWwRnaRG9Wiv2zvJMJ/naO5udg4BtnoVDsIE0K1kTZygty5mqOGQB7i5Cr5zeY1KAnDotlp+3T2A5n3mPlkCJk5iTtD4ynfMFhQJPoS6u9a+OnHU36grH7RuYYv6CYi+twGO8MWt0BtrhPUJsaoWIqpOSz20aLGK2ZIQlLmfreEjsEqFJJSRTCj5vLs3Ip7pfrag/WV2u3TsQaSxZGT5Z/ZquJ/qv8yX7FFFRoJJs66D3wCykKMQlgqbKzOhs4kPDYhDkuusjWWwRvKefww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kW3zhmW9RmiOPlX6gtQVeGNE6qk3CE502+x8haxAKFw=;
 b=XcD1UXLNz7E87sBJ/FIrwX9R0tblIuUZdQm0xh/rJb9AGBqLORTNcUXP0pFGBUuqzBgF/xxF/VOqQIr5TgRQpaiSLR8ZciPc9M4i45rOWYUdBv73SFJwG68yi/sPPcMclJp7Me0LoMWPdljGJ77H4SZ+cM7jUecLK1qnLL56FQp6lglZb/hoXjNz+z/i+S4Vz2Zt6p6RyFfBtYIK7nVx10IilnE6tGtcksQd1co/iHg64Er8ClFjOXsDiZwxVckf0GFDuMuIJSjUiKSYIW80NWFmQHB7XRQRrUrGi+icUAt5NMr1Hx4fG7CBVJCh6RJIpH+zv7ZIqOA+hgMHTHf7EQ==
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 15:09:00 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::6b) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Mon, 17 Jun 2024 15:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 15:09:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Jun
 2024 08:08:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 17 Jun 2024 08:08:39 -0700
Received: from dev-l-177.mtl.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 17 Jun 2024 08:08:35 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
Date: Mon, 17 Jun 2024 18:07:47 +0300
Subject: [PATCH vhost 13/23] vdpa/mlx5: Set mkey modified flags on all VQs
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240617-stage-vdpa-vq-precreate-v1-13-8c0483f0ca2a@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ba5ef0-98e4-4fd7-8ac7-08dc8edf6afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXJyeGJGek8yQWV6dzRvQTZsQTJsMXFaUFpRQnMwREg0OXBHTUgwRUxvM3VZ?=
 =?utf-8?B?Q1VSc3NDREtER0UvOTRiOXZHVkxSMTR6YW9ySmM0aUhKNGFHMlh6SEZtYlVZ?=
 =?utf-8?B?L09jN0VsamFkM0JwSGFiS211dFQ3R2pZMWY2ZWdoeW1iR1E3dWliQzJjNnhV?=
 =?utf-8?B?NkxsUE1IZHVHa1YreldlTlFOTStWWkFSQWsvVkxudjViZHBUWWNvOTA0Snhi?=
 =?utf-8?B?dVlTNVdBakdSM0VsT0d0akRBWHZmTnlPREowSy9XZGFuU3pydzQ5OUVIajRW?=
 =?utf-8?B?SlpIV25MbmxJM2RwdWkzQ1cvN24zeW0xMlVzelJ3aEt2MHcrRmI5TDRrNDBn?=
 =?utf-8?B?Slo1am1UWFYvZ2lna0xDYVZSVndBblBnd0lTTW9lVGhSUHF1THNlL0ROQVNv?=
 =?utf-8?B?K0IyZzF2ZVYrYzBLOUF5TzNqaXNYUTM0YmVwYmJnM3g1ZDJ3Qk5IT1FPcE9P?=
 =?utf-8?B?aWVNMWdCVVZnMW9wZ2U0UWs1QUlvODRUZk9NTDVxUjNIMGZycU5zTlltWVd5?=
 =?utf-8?B?NEMrUEgyaWJqTXcyeDZ6dHlsYVI4TzdobGdUbHFpMGo2UCtoazZLTVZKRVdh?=
 =?utf-8?B?L1FMdy9kU09TTUxXajdBYmpMZ2lSdE00dlVHV3hoSHduTG5kVlV6cUVMTnVT?=
 =?utf-8?B?c3ZubjJnWXBZcnllMUFxZ216bGxXWjNScXFiS3V1WjBoQUJOY2E1MHM2cTZZ?=
 =?utf-8?B?UmlUdURrZkRxQjNVemtIaFdjdUNEWUxEYTk4Y05KbmpFcnVXc2UrUFZXaVNS?=
 =?utf-8?B?NGJVUVFUL3JYU1lDckd3d3lxWU12TS9KcHBxVWtDYTZMb0xpMysyRDhOL0FT?=
 =?utf-8?B?dm84WXhlLzBxZmhaVFFhNUl4dG9IUWVIME05Nng2SGoyd05POTJPNElLVWp6?=
 =?utf-8?B?WHUvQ25OSWZPQUFxWVVUMnBuWmZQZm5ydy9aNWVrRld5Ri9LZWxpUjIrV0V4?=
 =?utf-8?B?dWFad3VrbTVHSE8wMFYzSTBseU1uUXQrVjRDR24yY1pBaU9QalUrU3JFemhY?=
 =?utf-8?B?NmY4M24wdWVzbmNSQjcyOUdOaXJ1M0FkTHJTOWg3bXVtK2R3aGpOZFI0Y0Va?=
 =?utf-8?B?V0wwYmhmckdCaldwQTB5U2ZWeDg5eVlGUnAweDg5ZEZKV1U3djRTR0tGTk1n?=
 =?utf-8?B?SmtrdGU5SlhCMDlscTBsMTlwWUlDeWdKQWZUNE1ORnFlSUNGTUhrQlpJczlO?=
 =?utf-8?B?YW15MU9RWk1HMjkvWFFPQUhlMGFkWHZWUUd4MlZnNGsvdnpFWDg4eTFUdmNL?=
 =?utf-8?B?eGRyS2NjcGduc3Fvem5JZURsU1RzdXNJeXZhb25KQklHYnJjYjBtc1hPbGFP?=
 =?utf-8?B?NzhlUUJKT0Y0cXdFTnRLcmtvTE5NL05SZUtEUmZQTjBNcjlyVzhzeW5KdllH?=
 =?utf-8?B?MzdWMkV4NzZVYm5lZXNVVUpnMjJpZnk0SHBXbk1oUnpLU214OVl3V1Q0a3VZ?=
 =?utf-8?B?cXVvUHhmaElFOW5NWjB6bG9EbVVjUDQzVmErdTI4MmtkOENsdFJvZlduZDhx?=
 =?utf-8?B?R3c2NXplM25lY0RGM2MwcE80NVVkMllWcndwNyszbzlIb1lFSEFoQXF0eE05?=
 =?utf-8?B?N2pYSmZIbHNpWUVPUzdxdkZHRVJhMk52dFZqbG9pRUVjL0Z1Wmx1em9qWmJE?=
 =?utf-8?B?cTJ6VU1IRU1BOG9BU0ErdW9ndnhqQWhOaGtuNWhGNmNvMkErK3BJT2g2V0pp?=
 =?utf-8?B?UWRYUC9XcFFSZUc2RGxwSE90QkpBeUNzcFB4T2pVUy9BL0NoK2dBMTZOU1pU?=
 =?utf-8?B?VGtrVkVCdjZRNnluWWVKMVdtb3pLNG93VWxabnZVT0Z1YjJkd1RUMCt0TGVO?=
 =?utf-8?B?RWFRemY4MFB3NkExSkhYczk0ZVJqcWdRcFhsUWM5TFJEdWtna0tXbjc1MVJV?=
 =?utf-8?B?REVqdzQ0TzBCdWs2eVNtV29kZmZSajBGRzBHclFUQTZVbmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 15:09:00.3332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ba5ef0-98e4-4fd7-8ac7-08dc8edf6afb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281

Otherwise, when virtqueues are moved from INIT to READY the latest mkey
will not be set appropriately.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 0201c6fe61e1..0abe01fd20e9 100644
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


