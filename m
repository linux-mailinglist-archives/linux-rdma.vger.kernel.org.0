Return-Path: <linux-rdma+bounces-13778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A4ABB94AC
	for <lists+linux-rdma@lfdr.de>; Sun, 05 Oct 2025 10:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8983B3BC046
	for <lists+linux-rdma@lfdr.de>; Sun,  5 Oct 2025 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9A31865FA;
	Sun,  5 Oct 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oqoMR1wy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013019.outbound.protection.outlook.com [40.107.201.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC401F3B87;
	Sun,  5 Oct 2025 08:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759653055; cv=fail; b=dehXJqUjsjqI0Ig/Kr0alJS4sy7VbQLaroE8hmlO/XnDNtAduDM3vjwZT7D+EipEw/GPXq03kyWrnn2aKNaBmzLwEEOi3Zbo2/LKADzqLOKuY7VjRpl9D/ReoKW+qxqEV5xYEZCyR87YqXX2SCstqg10cPtKU8FHM8GJxOK0rjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759653055; c=relaxed/simple;
	bh=9v7LaNfs6a9of/UxptfhO1UxbKTgqHyGqiP8fgROFI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqdRc88edjz/5Z6TnS4YmHmu3Q8YlrKO+H5RFox+PNB0GJif+9yWRN2yXuIDPL3bRttE+F/QQWWNEFqDOJTwKctfODkNxwcq0XSAIyH7JHcJ37SYoSbyzbWynP5y6yKmHadP/STaORHBWqwjtpvXXAqP+XArZTrXHAJ6PcxzE0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oqoMR1wy; arc=fail smtp.client-ip=40.107.201.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VpQ/wuZkKpdtZGBGPNJsAhH6B0W8m8Bf7B/QN5vRZkm7KjPtkn+ZuCRfO7WS1YXDaMZ2NB0YfIOao/myNENwToVh0dO45jG27Wh77Ks2P4+9e7Vh8667bPKXYm/ilrg/7/FRBWKGJbzzBi6DLPTnODRa5y0QVxnvSMMa/gG0QKT0GPELSbBCId6V0mCeumd59Iejmp3Z9scq/HnTQ2CpgSzcI3VBa4Qptlkb4AuD3sxHBWCreh2zKCBmBn8rvH4GG31Ggin2pjgAfiUfC37IzfBUuHLQP1PHpE06oRe9vfUweIoDwjK/iBxFntjtk7jcyjRabblL7A718QmIgXRhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdsCja1zoNSq1Ynmd6kh5VPMHYuds48wi+m8vckpzMc=;
 b=E0eFJ2PnqoLaeMTHSPBMT6JC90d6/1Bi9kwPDjqWdxOXIMWlv7+oZCFQi8myADlNaVLArySOBYhflGoTWYX6vZ1GZRR+dFYMD5E7KyM+bt4BWgO8sjc02ZnuulVTg2ywzg7+NiLMk9PKiOoosNBOXnNyvlgm0m6DbGvpiHfgZ025zYZX+iKRhXIzTTTSaQgC0t4ZCqd1QUMQom8N1quJD97WN7TJIdncJhhnuCoXpB/omK5647A52AxnExswTjUcihFj4d9+CHobWbFgFtPhX7cX5d1o3GcETDE8IVIdahEgeZZDmIpdim+IBMnUcW9Qpc9my42fNUNbgRgpSogNvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdsCja1zoNSq1Ynmd6kh5VPMHYuds48wi+m8vckpzMc=;
 b=oqoMR1wyfmc54UZ9Gi+cOOKJpbLt6l+jJGMxJVVBBtEEAmUCym7XSWC2XPrIUQWqLCl8FCAzeTFRc34CcS5yele95k9ow4EQ8Ntj5QazVkXPdoy8UV4tVeomW5zBtjBXTARG4P4dM8mktxfEZyBwcsDVtJtSr067ftwZyL03r82cHtGXqVBnfFOMGrp6H42iImqly827fMpBYpDil1vXZ61f4OajV3swi8/oRbEK9IszvkRE+kbLH/ERw46ZdcOFYKtE0EQ0tjaMfjsVoajIlju2CPiE1GcYA1zcWWRz1VqzDhV0P6qV3rJl+k2pe64Dk5PpDMW39ilY8H5XYVnQ/Q==
Received: from BN8PR15CA0069.namprd15.prod.outlook.com (2603:10b6:408:80::46)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Sun, 5 Oct
 2025 08:30:45 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:80:cafe::d5) by BN8PR15CA0069.outlook.office365.com
 (2603:10b6:408:80::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Sun,
 5 Oct 2025 08:30:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Sun, 5 Oct 2025 08:30:45 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 5 Oct
 2025 01:30:22 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 5 Oct
 2025 01:30:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 5 Oct
 2025 01:30:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: Prevent tunnel mode conflicts between FDB and NIC IPsec tables
Date: Sun, 5 Oct 2025 11:29:57 +0300
Message-ID: <1759652999-858513-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
References: <1759652999-858513-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 7186c8cc-49de-48af-bc46-08de03e97a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEU1SU9qK3hjanltQnM5V1V5YUM2WXhzTFZ1RlNSMWo5cFl1VVNoV0N0M1hE?=
 =?utf-8?B?blpNalQrQXlWYTFjZ2xBbkpRcUpHS0VFK21mTWpVU3hZL3RQTjRuMVgwbk1y?=
 =?utf-8?B?RG5HUU5GWWp3S01UQlhuUi85b3dGU0txd2g1Tk1YL2dOajd5b2NzZlFJc3c3?=
 =?utf-8?B?NHhoL3RHQXE4ajF0UVZhaC9rYkVwTG04U09ON3VDamZ6VjJ2dlhTTHpBNjVV?=
 =?utf-8?B?VGVSek9UNzMwWWJwZnVCSjZkMkhpQmt6VzZWV21qUDY1SlVVUHp0bTVDT2Zs?=
 =?utf-8?B?Vi9FMW9VbWRlcnAyZ3VSRVorSnM2TG8rMUxidUdlMC8yVjRQdTFseENudU5R?=
 =?utf-8?B?Uk9lTzVYNG4vdkxsZktVM2NRbjZmSGVBODM0V24vZzlvS1JFdGNzSDU1SEox?=
 =?utf-8?B?RE1OUThpNEhTT2ZXaDd3ZXhhRlNpSVhZeHJtYTAyeU1tYlFBZEZ0TGxaTzc4?=
 =?utf-8?B?V0luRnhVd0VCUWh2UmY5NU1ZalpCc3M4QjhITXlsTERKazI1VGc4SnhidHcw?=
 =?utf-8?B?Q2hPcWh6Nk9xV0Zzb1hYZHU3ZmF4dDQyMENhMGtjdmFXd3NWdG8yNGFyU2pj?=
 =?utf-8?B?ZDRKc2tDQ3IvNGE4NHNXRVJESmpvWGF0TC9FUmpITCtNNzdxajh3cC9BeWVB?=
 =?utf-8?B?NmVjdnpxODJOMDhyZjI0MEcyVkF0aWhOS3dLR3J0Z1lVN1ZYSWtqS2lRS0tv?=
 =?utf-8?B?SkFxNndJZ0IvdEp0MWF3MlNuOWE5TEltbWNoRGhRQXVuWFRsd00wTDJRcEFv?=
 =?utf-8?B?NVlxK2p0OHpQVkpNK0tUV0FtMGFRam9sYTJDdmNuMHkyK0xyeVVING9EaW1z?=
 =?utf-8?B?bE9FUlZaTXFYYlFJbEQwa2RvUE42MHVnanZRT2MzNklsQkdReWFtZmRmbnJ4?=
 =?utf-8?B?YndURGRrV2RXU0hBZ0ZlRUFKK2ZsTTIxT3BYQzh1M0xkYW9kMGxNVDhkbHFK?=
 =?utf-8?B?cGx2azUxS1hHWW85bHVhTlhCT0lNSlU0K29URWZaRWtHYTBnMEJKUEM5cnV4?=
 =?utf-8?B?UXBLbGh2clAyRlQrMXFIcEpLbWpwQ21rTFBiS3R2YlBSQzJsRGlvZk1qcDNB?=
 =?utf-8?B?M0E5OU9KcDM2bHIzTEpMNWw0U2QzVWIzR1ByZ09WRHFmbFZjM0ZaOXBIbnZB?=
 =?utf-8?B?bDRicEdtVjk4dk5NREN0MFlsV0Z0bFAvMm9mVFpUekNuZHMyTFA5MzExK0JN?=
 =?utf-8?B?VStmTjlEZ2YycUU5d0hFYzV4RElkekU1Nm52em1FTFBBakFuQ05QN2RPMndY?=
 =?utf-8?B?Z1B2c3BMSUxreS96b0hxN1crOTlkVWVRa0JKOCt1bllVUGpkZXRuK3F3OXMr?=
 =?utf-8?B?OFNOaGxPWk5FWG9rMEJRMFNONHZsN1VIRTNITUdVZ04rSmRFV09QRVRCZmRh?=
 =?utf-8?B?T2UzZWFmc1cyV29RQUVBTHJFam9PWXpvK2x1UjB0V3loaGxkVUs1eWxLV3V0?=
 =?utf-8?B?WmR6SFpWRjZucnRXdjdGWjRVS0Z3NlJpbWVxUjFFYUIyQkJtYW84cEVKNkNo?=
 =?utf-8?B?ZjJTTDlrZWhONmhwblZyM0Fyd2Vab3B1SytPbTIvYnZCcTg5aHh1UUIrU0lo?=
 =?utf-8?B?eU1FR1pZZDg0ODRXTE9waFgxdHU1MXNJTFdHUXV3cVd6b05uZVE4cjB0Vml3?=
 =?utf-8?B?ZzYvbHBpYVlkZFg0ck5YV2wvRFE1L2JEMVVIdGo4UHZsTlBrTlFXbHI1MjVx?=
 =?utf-8?B?OWYyNUg1OW1NSm1sWFduVllwZHI1aWpvMWZwS1FOMVpDNUJraUhKbzVSNG5N?=
 =?utf-8?B?NHE1UUJyemxMV1VndGxxRlQxcnppNEgvTlJFVS9IQkZTZEY5NmZ5QzgzbVNx?=
 =?utf-8?B?VWRQSjJMK1pOZDFpRi9nQmVTYkJZLzNHR2tydTc2UzdHM1BzVE9QdGRndG1r?=
 =?utf-8?B?Q1BGUTFCek1EaUpDejFqd2d3cXlpaW8yMDZ3L3FLT3lrYTJWVUhiUjVYRjdZ?=
 =?utf-8?B?QXlyazZxR3lLUjQ5dUEweDFqVmoyMDFnK2RlREFyZCtJaUU3YWtyMUZqRFpm?=
 =?utf-8?B?RzhPa1FJTk5lNVBGVmYxWEV1aEZJcDRrTW1SOTlmbUlwUFhwVGxSZDFNWDhD?=
 =?utf-8?B?VEwzcVVnZDJUeG8vVGlmWlR2c3Y2NHVkZlV2UVpZL3ZHYWFzZjJEUUFEVDVW?=
 =?utf-8?Q?uCTo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2025 08:30:45.0817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7186c8cc-49de-48af-bc46-08de03e97a9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590

From: Carolina Jubran <cjubran@nvidia.com>

When creating IPsec flow tables with tunnel mode enabled, the driver
uses mlx5_eswitch_block_encap() to prevent tunnel encapsulation
conflicts across different domains (NIC_RX/NIC_TX and FDB), since the
firmware doesn’t allow both at the same time.

Currently, the driver attempts to reserve tunnel mode unconditionally
for both NIC and FDB IPsec tables. This can lead to conflicting tunnel
mode setups, for example, if a flow table was created in the FDB
domain with tunnel offload enabled, and we later try to create another
one in the NIC, or vice versa.

To resolve this, adjust the blocking logic so that tunnel mode is only
reserved by NIC flows. This ensures that tunnel offload is exclusively
used in either the NIC or the FDB, and avoids unintended offload
conflicts.

Fixes: 1762f132d542 ("net/mlx5e: Support IPsec packet offload for RX in switchdev mode")
Fixes: c6c2bf5db4ea ("net/mlx5e: Support IPsec packet offload for TX in switchdev mode")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c     |  8 ++++++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h  |  5 +++--
 .../mellanox/mlx5/core/eswitch_offloads.c      | 18 ++++++++++--------
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 6ccfc2af07b7..0bc080274584 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1069,7 +1069,9 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 
 	/* Create FT */
 	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
-		rx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
+		rx->allow_tunnel_mode =
+			mlx5_eswitch_block_encap(mdev, rx == ipsec->rx_esw);
+
 	if (rx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 	ft = ipsec_ft_create(attr.ns, attr.sa_level, attr.prio, 1, 2, flags);
@@ -1310,7 +1312,9 @@ static int tx_create(struct mlx5e_ipsec *ipsec, struct mlx5e_ipsec_tx *tx,
 		goto err_status_rule;
 
 	if (mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_TUNNEL)
-		tx->allow_tunnel_mode = mlx5_eswitch_block_encap(mdev);
+		tx->allow_tunnel_mode =
+			mlx5_eswitch_block_encap(mdev, tx == ipsec->tx_esw);
+
 	if (tx->allow_tunnel_mode)
 		flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT;
 	ft = ipsec_ft_create(tx->ns, attr.sa_level, attr.prio, 1, 4, flags);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index df3756d7e52e..16eb99aba2a7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -879,7 +879,7 @@ void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
 int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
 
-bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev);
+bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev, bool from_fdb);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
 
 int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev);
@@ -974,7 +974,8 @@ mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 	return 0;
 }
 
-static inline bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev)
+static inline bool
+mlx5_eswitch_block_encap(struct mlx5_core_dev *dev, bool from_fdb)
 {
 	return true;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 52c3de24bea3..4cf995be127d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4006,23 +4006,25 @@ int mlx5_devlink_eswitch_inline_mode_get(struct devlink *devlink, u8 *mode)
 	return esw_inline_mode_to_devlink(esw->offloads.inline_mode, mode);
 }
 
-bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev)
+bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev, bool from_fdb)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
+	enum devlink_eswitch_encap_mode encap;
+	bool allow_tunnel = false;
 
 	if (!mlx5_esw_allowed(esw))
 		return true;
 
 	down_write(&esw->mode_lock);
-	if (esw->mode != MLX5_ESWITCH_LEGACY &&
-	    esw->offloads.encap != DEVLINK_ESWITCH_ENCAP_MODE_NONE) {
-		up_write(&esw->mode_lock);
-		return false;
+	encap = esw->offloads.encap;
+	if (esw->mode == MLX5_ESWITCH_LEGACY ||
+	    (encap == DEVLINK_ESWITCH_ENCAP_MODE_NONE && !from_fdb)) {
+		allow_tunnel = true;
+		esw->offloads.num_block_encap++;
 	}
-
-	esw->offloads.num_block_encap++;
 	up_write(&esw->mode_lock);
-	return true;
+
+	return allow_tunnel;
 }
 
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev)
-- 
2.31.1


