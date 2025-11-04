Return-Path: <linux-rdma+bounces-14227-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F45C2F7D1
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 07:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 129E14EAE10
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 06:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A8A2D46DB;
	Tue,  4 Nov 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0/K95VI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361E41A9F90;
	Tue,  4 Nov 2025 06:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238957; cv=fail; b=Qgo35Hh5DFCCuJxpE4oHiFiQfTITZYgFTIEa8WNnvhHQUQQuaQPjZUDJn+X0HBvIef381FuEG7MaqVAqusDpj/VQiudCy1WQoD1j4SBNc9SZE/cS/HSc0lg1d3m38mdCWhYa0WmXLbYirYEIP6SjNHSCCl067m/KC0wOMmkSQe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238957; c=relaxed/simple;
	bh=3gFB0UsL7AWecmqqtxRd4oTKWPKgbsoQvKi6BsoiAZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keZ7jqRUmEq45NazWctU6uycwD1BONQ4Qq7dc+Sw/ZHF+/SpIM9slsAsYxNkP2oYYrfJIfuwC0NnP3ZOtotlacrD843tYnVAy1TDZouh64bAx/zXGu+EA76lnHRL6yhxiWzE3G3uONzh/lQPj/RRDSeOyCSFUb65KX9x8SksLc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0/K95VI; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sK1qruZZKpbZEzg/RSIHaMLavoJA/9Q1VXtStnSwK70mC+zzvDgD6YyxhKlYozzOVmiN51YlvTf6Il1MnWFbilDlxt+yRjMtACZiKp5t0c7RjUBYWGr3QNEKeH9IPkjCgZaI+BuoXLXKXa/34fhl2vfax0JKAZK6p3Fg94VnTTjqQnZ09oH/1UIVrDrTO3kDURNYSm5G9Qe8H4ndIpIjahh2AA9ZaMvLF2WqPrBukQXB7M5RW39CtsUjVM+pYzCbM7OXrHoDLF4jHOp4qhzs1+5p0B6e3AMHLFg2KsQvzZ2PxE0iAKOx3eewhGsWIwSIMrWBsZGV7UrzUe1s4F6fJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAEOps5z7c75N47lyRqzE9YbxYJd9VDMS5D44kv82GY=;
 b=CVPRgpkdc4FUjT/PIt1E0hQ4ea8ogrB+VIPsddV4JzeBknzQH5f+dL+ZM3V45NEVDbXvniDYK/gjryb69EeHpXOHlKrumLRbQVd1xRUQP2DtgCJxXb0Sm5ZIr9dkQjQNw8sYo1n2RyNn2eDEQzql1D58ugifPP2VfC9GEd2JXlHLlU5DLRf/1Aq8L0jPsVwgVxntnkQQJnn3v2pZ+CO0C1y395OehUoJmXexH41B5wRAEJOGb5dH/RR81VO2MUQ0LxAHKtqaez9c61IRt86oLRZFEoIA7E4q6A1U4UzbXghGLRSeLx6+mAWABM5Yaem+UbjmS3pjeK6afeYtZiyuTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAEOps5z7c75N47lyRqzE9YbxYJd9VDMS5D44kv82GY=;
 b=a0/K95VImd6YX++1F19/WFj+aM7AKYM7DFGJfRTb7O84klrG1Bq1ia8+HnWZkRdzPvSF29ELuVjBbUIhlfVeMr7Zmm/ey+iEjBU1DqnpB+8zFZe3inM3zb6/kTqbznPsmGEyYiS+Lal9YCGwmsO2HCN4425eMeUMGjBvoithvORbMiqtieAuGsF58pqd0tSc9BvpMTacdyB9cABni3SGQJgpxUnNcdCTTZON9/dIcM/V10fJ0yABqgx+uQxAUmCUdNIWjJBlHvuX+U98BNAC96R/nEGiOZmoSrZA3zChfIgqFXcqtrX985wUECVQUfiCFicZ61szUOK4T9gYyrWQfQ==
Received: from CH2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:4e::11)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 06:49:12 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::9b) by CH2PR02CA0001.outlook.office365.com
 (2603:10b6:610:4e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 06:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:49:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:48:59 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Nov 2025 22:48:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 22:48:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net V2 2/3] net/mlx5e: SHAMPO, Fix skb size check for 64K pages
Date: Tue, 4 Nov 2025 08:48:34 +0200
Message-ID: <1762238915-1027590-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
References: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f4f13c-9041-4db1-2a39-08de1b6e42f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NaS7CxNloSQrNvkLLHqJF2cwQ9uzXbX2zw2fGhYcuaCCEhIPuUxlocLh3cOF?=
 =?us-ascii?Q?6nRjat6us8JoAe8SejMryyeYgSdVMAa4WwLGHLh1DUeUZLEPDf9uDiB1L2Sv?=
 =?us-ascii?Q?yPCvHutyYz8ddvuwMVKTDt771wrWFcsHvKD+fCtRYV/b4nGBHgSKXn6qty93?=
 =?us-ascii?Q?0iLcUNwSJGX2vyex7UAHU9caqF3/8w24ESIKmZlaGMBSGCELuBfb2AtTyAZB?=
 =?us-ascii?Q?n7WwAGaljnkY4OelIU036sW3BLhtJDxF8RZmnWwkg1nCaWdU88BIctIc8dkV?=
 =?us-ascii?Q?0ZMtlIJd3tycNdlpc+RJc3RsZyaCbKVSiRgQPzONV4P5KKLFx3stnHhFYhNc?=
 =?us-ascii?Q?xvOSk3nPHGgNWffw6lG3eY2OdplcSCNL4JQYCfqxVMaQtnYGo0+FMDUnS6cG?=
 =?us-ascii?Q?USiT8sDlbRUbz9nNkrZMjO0AdlwEbz1aMcUL4uqxW5J8phdx50nU0sfT8TGT?=
 =?us-ascii?Q?i2Yaely9W1cnGrYQ2u2byJU3PYW2HQunwmO7uhvzbfUmbZ1OCKYLIscYXnKv?=
 =?us-ascii?Q?AgVV2umt16/X0Ku7Cwc7Tdh/wXCb9K8xNBswrafNNzRcTpQ9phnu465F55Ip?=
 =?us-ascii?Q?R06tdPVOzuAz3zv+93/GIaouj6KeStCM1eMF2678gmamHUvODVTAaFW4FHEA?=
 =?us-ascii?Q?k8ASqo3i8E/Vsp3A5BsWqeEcsoxCvJaGTlrdoSsEMiNM0eG7+IfYNbaVSm+K?=
 =?us-ascii?Q?/hHywM+yvfxDC57yKSqI2UOUcQtLqtioNEcHZQIJIx3tqQeVpSeE8r31Ugc4?=
 =?us-ascii?Q?PBrWRBRcl4vlrnm/wzgyA37AzCT2e+4Y/VcAAROZev+SAP5tVh5Qqt1HcUXy?=
 =?us-ascii?Q?fiQMtfDETutU8v+IAQTscAM/w5dXjrScOlqZVIYumGiYrnDvMR/lmXXfeJKl?=
 =?us-ascii?Q?scKi+1Kl3vMidZ7L5SIMxdowZwrwc2esGOgb8TIRs5HMgU0GN0Pa0bn/0LY6?=
 =?us-ascii?Q?mKunyVb+gR6dJs9xXRBJeMaVaqNlcOeJmOm58v5WB4VsyAfw1vZHpzm916DE?=
 =?us-ascii?Q?mOJna7i9L56UT6mQpJ4pd+E6UDoVRvIhM3MrMkiaXN5s2hXMDUSlQvPjsC71?=
 =?us-ascii?Q?PhzOMBLp1A9L87mcDJGGnlHgrUKeTz0H8jKBXUP3i5AG4c2mNKTcEDprzJ0+?=
 =?us-ascii?Q?kfK6Pr7PjvMcIkn8DlX40EIJjdFInrz4h/LpuzMgoU8ZRaycXDXjrjEHnMdT?=
 =?us-ascii?Q?TSE+HFBn9A1vtAXwnNBBxsZohUEZQCXJnPzyEFAxfgpMbtMfhJ0bZvIpSl+K?=
 =?us-ascii?Q?QGrdd+DwYkKbN5IAOI0R1vg3kq9eNfhtzEqaXyAbq1JnkuqCVc4b0DzFqg8f?=
 =?us-ascii?Q?ieHNDb2BVkQPYnkqN2V61IF89YhSt5dlR6HuU/I9EQvqKU09Qr+HHjOet5FQ?=
 =?us-ascii?Q?eljhY1wIpXKewAgU0wwaYOEK22WO5y7Naj6LK/4uZ2f3qS7j9KLU32Yy3OJ1?=
 =?us-ascii?Q?hujGnxjBw4BCVdLIl2EQPUu9aWiu3J2Fu7p7TGGdT4+tBHPdRUMRvPXGLS84?=
 =?us-ascii?Q?ajZeXGEdqKuUD3GVU3spoD1vwTqANDc4vkqh134JN1zXY8gSTS3YltEHh74G?=
 =?us-ascii?Q?2bc0RPe7ebfADbq0jdE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:49:11.5591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f4f13c-9041-4db1-2a39-08de1b6e42f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865

From: Dragos Tatulea <dtatulea@nvidia.com>

mlx5e_hw_gro_skb_has_enough_space() uses a formula to check if there is
enough space in the skb frags to store more data. This formula is
incorrect for 64K page sizes and it triggers early GRO session
termination because the first fragment will blow up beyond
GRO_LEGACY_MAX_SIZE.

This patch adds a special case for page sizes >= GRO_LEGACY_MAX_SIZE
(64K) which uses the skb->len instead. Within this context,
the check is safe from fragment overflow because the hardware
will continuously fill the data up to the reservation size of 64K
and the driver will coalesce all data from the same page to the same
fragment. This means that the data will span one fragment or at most
two for such a large page size.

It is expected that the if statement will be optimized out as the
check is done with constants.

Fixes: 92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 0c031954ca30..f2a06752ce37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -2354,7 +2354,10 @@ mlx5e_hw_gro_skb_has_enough_space(struct sk_buff *skb, u16 data_bcnt)
 {
 	int nr_frags = skb_shinfo(skb)->nr_frags;
 
-	return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+	if (PAGE_SIZE >= GRO_LEGACY_MAX_SIZE)
+		return skb->len + data_bcnt <= GRO_LEGACY_MAX_SIZE;
+	else
+		return PAGE_SIZE * nr_frags + data_bcnt <= GRO_LEGACY_MAX_SIZE;
 }
 
 static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
-- 
2.31.1


