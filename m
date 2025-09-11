Return-Path: <linux-rdma+bounces-13270-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C90B5299B
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409397B2B4F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 07:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAAA7270ECD;
	Thu, 11 Sep 2025 07:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HG6DdEvA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CF6266B67;
	Thu, 11 Sep 2025 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574664; cv=fail; b=HfCBOjN7SJflnE0ZO5l+MGoLTOVZH468v3JtbWF7J1vx3z86vHHvvnQ3UxfF05xI6OyvX/nck3DA/1ngVAUrKQY+V1JLjdqZWWSmr3H6veUkGd4oUO3kSIY7erw76Uq/k6wdF7HyD0OFdX9WJirXWYrHchML/Dkes5TvgnYqjpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574664; c=relaxed/simple;
	bh=pJXAXWP4cPS1sQCBUpZ7xY8mGUsQwn5pYrHpZy2TGWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0Cc//MxbqQKW2YMrl0y+oHU979DaBwxFqFQTTuBrdcPCaSQji/jWUHbnaH1bc2on/ELMTUDPVwA8qI4bqcah5D6lbz0NfO+PCcnYaAUvmbuJAyBTdrDGqQZD/OOdsKGUeNAYoXporIdZVmeZUBqU/+3vNNcWBMVm5ETDkGhb5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HG6DdEvA; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCBdZ9NZcXUurUBk6NrtMZPLWKxchsaF6tlfizBCcSXHTx+SbT5YSEgS1/BolyDw4YyJIdTW6zwHdQuU87V/xbUKYHoO95PtnsZ0fkh9UWvPGCEcqwS5FBvKYzUUu36mMWk/3/yU87Fuk3KQU3eEJHuvjB+rOzyRB26jMDXDZC9ekxmwlby+JwFYuvnP/OXkUfgn6Oyq+rbJUNzUhRL6oPnUxL27CBSymSqc4iV3wmYIcEtJ2ssuhfIZNkfKkXHEamVRxO+DdAtTkwkowKgoMUoIe2Mvlx9p7u4xK8KKxVhsSw0OXfChgPfHQ6u5ngDXTLPf8P1Z80rHIjVvZ8JFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80yQIPQU4TV00dyQTLEwl5LpQJvcLNF+ysqKLJ00GJc=;
 b=QF6j6K/WMfMb05uCfkEh5gp61sGIOGIEWGacAaXVQEE6xEK29RmcG6vG41HQjFqNlYHtChxC4MkzmlSnVP4m02m/BuPX3dI2d4IMkXnPK9b+MoJHMHQDuZL7raaoTG8tJtuaitVi3EDFHhf9vXTAMgFd2IRo0y2aTPyIQO1g6siflbYye+kjwegNObqJAUAJ82wlgiauTmAdp9Z+zarxhLtVecDAWzSQYf+YvfTeFkorhAnPFELlTu2epMnxCxO8EwdHOJaGhuYEhG6vUAOloSQFlOqztjFCntze+k/N2seaPJqO2NB/jKNo4XUJ6KKpErGWMA15ejtxLzdmM/S7YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80yQIPQU4TV00dyQTLEwl5LpQJvcLNF+ysqKLJ00GJc=;
 b=HG6DdEvA65cWhMSli98aJOP9AtXtBrGNrTracjqps6YL59RsZyBcBNe6ZG70Vk0bSLV5uUEGzUcitNDYxzhAh8iBr+H0kiQJYUsKdqkSekpuBLwT+yUNGfppFqbqm2WVAc+P0PfYNtfaplL5ESHry7Ia/K+NaweYmgZkmPBLskYr/10aRd1FBJOrB7rZhQpG21DHadvBRZKnXID6fjjVDVeUc0Vc+qYHK+CZsngj8e8zZ6tXyOcv+cmMEvV9yInd8skOIqOUz/RTJtijXbIGz21oYYodmlTiyVoe70qIM+JcyYB6p9C4AvGMpR9u35RKRyn4nO87XG2XANEHllsf4g==
Received: from CH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::16)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:10:57 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::eb) by CH0P220CA0024.outlook.office365.com
 (2603:10b6:610:ef::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 07:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:10:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:41 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 11
 Sep 2025 00:10:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH mlx5-next 2/3] net/mlx5: Refactor MACsec WQE metadata shifts
Date: Thu, 11 Sep 2025 10:10:18 +0300
Message-ID: <1757574619-604874-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|DM4PR12MB7765:EE_
X-MS-Office365-Filtering-Correlation-Id: fc7019f1-60ed-495d-8bc7-08ddf1025a6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGNwSnpvWXJ6NmNnRml6aEUvTTA3ajhQNzJUbXpJSVlRZVZvRXEzZ0c4MHhC?=
 =?utf-8?B?Nkc1QTBiM2RmVGFKdklOUlJDbkJNcExSODZPQVljcUtlVEFOOThmK3dnYWtm?=
 =?utf-8?B?QXVQNEN6d21LbXpyZjZLWHE5SVErWVBlL3RBcE1wVkZuME1RbGN3UG41ZFlr?=
 =?utf-8?B?c3AxalpWcHNveDFHQi9wMXpOb0trcUdRaXM1YW9NTkZOWEs1bXo0MGxjUmFW?=
 =?utf-8?B?TTJqcGJEb2s1QWhwYTVEL29pRjJibnltTzVYS1BjSlBCYXJuV1NYaUQzSVBL?=
 =?utf-8?B?U29yVCs0K3dxdXFIZGNZQU5LQnFtMGlONmtYeE4yVWhOZWx4dHRiNUY2SW5K?=
 =?utf-8?B?bFZYdXhSMWJBdjI0SHdEVWVuUEFiUVE0anhKblNLV1p5UmR0ejJJYmQrbGFV?=
 =?utf-8?B?bElSQnVmQjJpYjNRNEJlc1lZQXhjaTJ4VGx6aG5TSlM3eTF3a0hkanNwR2JP?=
 =?utf-8?B?RndZNkpWMXpKTHZnZlBzeVl2WmRyZFNLVjh6TUxPRFhIcHBEaHFhcEF0ZER3?=
 =?utf-8?B?WFNsSXBtWURLUWZ4TEY2M2lLSmtmdmJGRzZ5cllOZk14Y1o3RnA3ZDlhK2hv?=
 =?utf-8?B?aHk4MlF3OTFPSkN6WjBqZy9lZDJPbzhlNzYwTTEwUCtkamlCb1RTVjliYllV?=
 =?utf-8?B?Z2kzcnYwWTE0QkpWWFJSeW0xU2duNnJhZjdEd3UvR2hWc1htRnlNekdFV1Bh?=
 =?utf-8?B?SGRUc0syVTV4NXo0NFpzTkp1STRqKy9JTUcvM25Pc0s5SUpJV0U2YVlUQXVJ?=
 =?utf-8?B?UFVGNkJwSW4zVEt5S2FPUldIQkVIbnFZL0JscG9CeWRaYVVDM2hmbHF2c2Fx?=
 =?utf-8?B?SlhqY1V6cnhTYXJhc2lORHZYMENHb0drdCthZGIyNzdWME0yTk1IL25YZ3ph?=
 =?utf-8?B?MDZyeGw0K2h3ZTNTbUFWZmVSdDlwOVpicTNPTXIrN0dFRWpON0Y5YitaV2Ry?=
 =?utf-8?B?T3Zkd3M3bEo0anpkTHBxUDVWMXFUVzNXa0EvQWxLbDVaOUlXS29adzFZQVNK?=
 =?utf-8?B?NUtSMHZDVFBOcE5JUWFhTmQ3emtxMXI1eVZyQ25mOWFYTEpPT0htWUlnbkhB?=
 =?utf-8?B?d2pyOXF1YUdyVW5xSVJtYU1oUklzSTJpM3lLQ3MxV2F1QnV1dzFVWlNLMENv?=
 =?utf-8?B?Y2xncGt0RWF2U1BjMittVTN3RWFxNFhSMmlYWi9oQVVDV2FjY3dlaFJKYXcv?=
 =?utf-8?B?SzN2eXdJRXJnSHg2V3dpQWs4dWlYNU1rV1F2OGR3Z29HQTBKWjVNVTZPdFRW?=
 =?utf-8?B?OTJoTFl5MWNrOEhjWUM3Ymw5cWxhVStpYTRYRjZvRmI2NUdCY2x0ejZjK0xi?=
 =?utf-8?B?eklpQmNLekhwSG4zSGZPL29EZTZFK1p2NWtJWmlGYkRSS0tyZS9ycFUyZ0NG?=
 =?utf-8?B?VjUrRDZsVUxWVkRlUFk0NExDRld0b0xsQ1djbkZFakdDTnFmOVRROS95VEFs?=
 =?utf-8?B?R1huWjRZV29SSlpsTDRKSnQ2UnNqUEFjMDgzRk12YlhNNzJ5U1l0cnFTMzZ4?=
 =?utf-8?B?eVNUbWtqM05raXRlU09VTnoza0hCMmFwcngzT2ZUQXVFS0hHbkxsa2hQcW9T?=
 =?utf-8?B?NGE2MWtrQlZTR2d2TjRQa3VQQ3FOcHI4b2dRR25kMGtpbllwczZKc0tsTVIw?=
 =?utf-8?B?YkEyRVlvSThOV0dsSTcrcFJOQnZPRzkrZklWdElJQm1TK3lGcUphbVhJa1FH?=
 =?utf-8?B?ZUE2YWl1S0RKYjlqbWdpelRSQTZ3N0NGd1MzcXJUT2tUNTQwUUFoeWRrQm1M?=
 =?utf-8?B?VFRqeDQ2RVpmQVdPRzQ3QzVjREZSbmxsdHFaYkpHaTZKYjN3WkdnR0djVmQz?=
 =?utf-8?B?T2NINDFIWCtOcVVoYnAzU3h0NDczTDZ3R1RxdjJUSEZPajdxTkt5ZnZrNHJi?=
 =?utf-8?B?YVJHY0xYMWpxaVhyS1YzTmQwWEJQM0dtcThnMWhhNXZXeEg0R1JjSFd4dGRQ?=
 =?utf-8?B?Z05TbWh3S2Q3eVd3YzJsVlpDR3owL3pocVhtbWRMNkxyUjk1eU9Cb05PcHpm?=
 =?utf-8?B?T3JLRm1IbDlJUXRrQklLNWJkTFRWcHp4Mk9mQXBJQWNxNEFxcXlDblJIQkx4?=
 =?utf-8?Q?vdpYgK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:10:56.4189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7019f1-60ed-495d-8bc7-08ddf1025a6d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765

From: Carolina Jubran <cjubran@nvidia.com>

Introduce MLX5_ETH_WQE_FT_META_SHIFT as a shared base offset for
features that use the lower 8 bits of the WQE flow_table_metadata
field, currently used for timestamping, IPsec, and MACsec.

Define MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK so that fs_id occupies
bits 2–5, making it clear that fs_id occupies bits in the metadata.

Set MLX5_ETH_WQE_FT_META_MACSEC_MASK as the OR of the MACsec flag and
MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK, corresponding to the original
0x3E mask.

Update the fs_id macro to right-shift the MACsec flag by
MLX5_ETH_WQE_FT_META_SHIFT and update the RoCE modify-header action to
use it.

Introduce the helper macro MLX5_MACSEC_TX_METADATA(fs_id) to compose
the full shifted MACsec metadata value.

These changes make it explicit exactly which metadata bits carry MACsec
information, simplifying future feature exclusions when multiple
features share the WQE flowtable metadata.

In addition, drop the incorrect “RX flow steering” comment, since this
applies to TX flow steering.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c |  2 +-
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c   | 12 +++++-------
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.h   | 15 +++++++++++++++
 include/linux/mlx5/qp.h                           |  9 +++++++--
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 6ab02f3fc291..528b04d4de41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1676,7 +1676,7 @@ void mlx5e_macsec_tx_build_eseg(struct mlx5e_macsec *macsec,
 	if (!fs_id)
 		return;
 
-	eseg->flow_table_metadata = cpu_to_be32(MLX5_ETH_WQE_FT_META_MACSEC | fs_id << 2);
+	eseg->flow_table_metadata = cpu_to_be32(MLX5_MACSEC_TX_METADATA(fs_id));
 }
 
 void mlx5e_macsec_offload_handle_rx_skb(struct net_device *netdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 762d55ba9e51..9ec450603176 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -45,11 +45,7 @@
 #define MLX5_SECTAG_HEADER_SIZE_WITHOUT_SCI 0x8
 #define MLX5_SECTAG_HEADER_SIZE_WITH_SCI (MLX5_SECTAG_HEADER_SIZE_WITHOUT_SCI + MACSEC_SCI_LEN)
 
-/* MACsec RX flow steering */
-#define MLX5_ETH_WQE_FT_META_MACSEC_MASK 0x3E
-
 /* MACsec fs_id handling for steering */
-#define macsec_fs_set_tx_fs_id(fs_id) (MLX5_ETH_WQE_FT_META_MACSEC | (fs_id) << 2)
 #define macsec_fs_set_rx_fs_id(fs_id) ((fs_id) | BIT(30))
 
 struct mlx5_sectag_header {
@@ -597,7 +593,7 @@ static int macsec_fs_tx_setup_fte(struct mlx5_macsec_fs *macsec_fs,
 	MLX5_SET(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_a,
 		 MLX5_ETH_WQE_FT_META_MACSEC_MASK);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.metadata_reg_a,
-		 macsec_fs_set_tx_fs_id(id));
+		 MLX5_MACSEC_TX_METADATA(id));
 
 	*fs_id = id;
 	flow_act->crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_MACSEC;
@@ -2219,8 +2215,10 @@ static int mlx5_macsec_fs_add_roce_rule_tx(struct mlx5_macsec_fs *macsec_fs, u32
 
 	MLX5_SET(set_action_in, action, action_type, MLX5_ACTION_TYPE_SET);
 	MLX5_SET(set_action_in, action, field, MLX5_ACTION_IN_FIELD_METADATA_REG_A);
-	MLX5_SET(set_action_in, action, data, macsec_fs_set_tx_fs_id(fs_id));
-	MLX5_SET(set_action_in, action, offset, 0);
+	MLX5_SET(set_action_in, action, data,
+		 mlx5_macsec_fs_set_tx_fs_id(fs_id));
+	MLX5_SET(set_action_in, action, offset,
+		 MLX5_ETH_WQE_FT_META_MACSEC_SHIFT);
 	MLX5_SET(set_action_in, action, length, 32);
 
 	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
index 34b80c3ef6a5..15acaff43641 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
@@ -12,6 +12,21 @@
 #define MLX5_MACSEC_METADATA_MARKER(metadata)  ((((metadata) >> 30) & 0x3)  == 0x1)
 #define MLX5_MACSEC_RX_METADAT_HANDLE(metadata)  ((metadata) & MLX5_MACSEC_RX_FS_ID_MASK)
 
+/* MACsec TX flow steering */
+#define MLX5_ETH_WQE_FT_META_MACSEC_MASK \
+	(MLX5_ETH_WQE_FT_META_MACSEC | MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK)
+#define MLX5_ETH_WQE_FT_META_MACSEC_SHIFT MLX5_ETH_WQE_FT_META_SHIFT
+
+/* MACsec fs_id handling for steering */
+#define mlx5_macsec_fs_set_tx_fs_id(fs_id) \
+	(((MLX5_ETH_WQE_FT_META_MACSEC) >> MLX5_ETH_WQE_FT_META_MACSEC_SHIFT) \
+	 | ((fs_id) << 2))
+
+#define MLX5_MACSEC_TX_METADATA(fs_id) \
+	(mlx5_macsec_fs_set_tx_fs_id(fs_id) << \
+	 MLX5_ETH_WQE_FT_META_MACSEC_SHIFT)
+
+/* MACsec fs_id uses 4 bits, supports up to 16 interfaces */
 #define MLX5_MACSEC_NUM_OF_SUPPORTED_INTERFACES 16
 
 struct mlx5_macsec_fs;
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index 5546c7bd2c83..b21be7630575 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -251,9 +251,14 @@ enum {
 	MLX5_ETH_WQE_SWP_OUTER_L4_UDP   = 1 << 5,
 };
 
+/* Base shift for metadata bits used by timestamping, IPsec, and MACsec */
+#define MLX5_ETH_WQE_FT_META_SHIFT 0
+
 enum {
-	MLX5_ETH_WQE_FT_META_IPSEC = BIT(0),
-	MLX5_ETH_WQE_FT_META_MACSEC = BIT(1),
+	MLX5_ETH_WQE_FT_META_IPSEC = BIT(0) << MLX5_ETH_WQE_FT_META_SHIFT,
+	MLX5_ETH_WQE_FT_META_MACSEC = BIT(1) << MLX5_ETH_WQE_FT_META_SHIFT,
+	MLX5_ETH_WQE_FT_META_MACSEC_FS_ID_MASK =
+		GENMASK(5, 2) << MLX5_ETH_WQE_FT_META_SHIFT,
 };
 
 struct mlx5_wqe_eth_seg {
-- 
2.31.1


