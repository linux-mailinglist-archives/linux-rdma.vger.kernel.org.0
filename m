Return-Path: <linux-rdma+bounces-13998-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7887BFF634
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094DA188693B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B2D2D0298;
	Thu, 23 Oct 2025 06:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="c8HzZ82W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8312BF016;
	Thu, 23 Oct 2025 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201931; cv=fail; b=gkFj/lo5eSExv2DZecEDO/ENr4kYx7IGbvn2Hrps41c5dJNDBtwhu7GjOGVt2uZ3/kVT1cpQ4FmxHWniVCDvws9GVixXBL6m7bW+XJEFSgnVLuISQwCb2V7JXYsMtWgsoyE4YAw0FrFe6iBrCjB3xA2ShZgirx38psNLZZI2lsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201931; c=relaxed/simple;
	bh=sj6pc8Ru7BGU56SxZWZjy3EWYhAQXSwE9p0Mqu+nWjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZ0K3SO82RznQ80zJ8cad7GVB6LntaEozpYhNxWeu2qNUohwDRRQFzdaVm+lChEUXHecoOLDQg39oQGdPNtCcNYa+C+3KtGcdcXS2RGdDn2Ry4CkP0lQBwQQxCz7K0RfxUI0Xt9huQgIvi7Z8qwHE7LDqXomu04mv8yUHEZObRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=c8HzZ82W; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVBowywA78eAczJM/Fgx78IFNmCgfFlxMTmqNpjIgfiHeorPpOPl+TVaGNOqEbYW69HPvglqj/Tqmqd0RBWyQ3MWVC13A9xSSMJeQ1lAQ/DJyPUkMYB1EzXGcVh01z/pvE57Mv0QurnBcBy3wK4W7Pdn6M2B+pLLUe6DtGWtQlsLQ4YNF2S3ttRaD6MrHHPGzHI7w52ikFoCKFWjZARs3wCKRU4V0Sr7Qd5d1t8bSUl5HCvnM69tSryWX1/ySKISX7uwtI9gNR8G5sJQd/t4da6cB6mrR0sgSuENaR1etbOd230dVHEl+5fvxvvAHZoujrJPNL+3pdqf7x0lvpzrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Ft3Hxs7gHXvDuW228ckY84w8WDRhl3NFXMLDFqUGlk=;
 b=kBGy5d9N+xxT68zip9A5C4xb8/keF2X/zId9nIh5vbWCxIaqzo9fO/kFgjn+QlDmCNjXNXBwynIWPEnOZvJZoaH/aA4EDjurfAn70x5zCiojJ0q2rDQ90Ypq7ljDg5P/+JuSWnChXKhZvbepJPlpwHtp3fs7BuY7y5mFIUwoVus3XhMnC4ZvhK9F77L8UUVr+o+WLKp3RNasjywODX/5CMvPaUPiHEQeNjMnfMkfJhpqTcJQQwPxc9jBbVt7Xm7VnfU4AlazSgu6/E5xVDeFTuAUByjd70C3ffvJ0wr0SCiKFCAjbQ4i2yFx4ptEtn8+2yD3W5tIb/n08x84YGbALQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Ft3Hxs7gHXvDuW228ckY84w8WDRhl3NFXMLDFqUGlk=;
 b=c8HzZ82WaOFC9HDhy7pvphTWPFpS5GtN2XMMH6TJZbU4s/YUDiXDtZieTS2SZTaqGzCE4G938Un0dJYlYR7q447pHDytn2UJ1xTicI0ZEZK/h90/BUVUTZWxN7EsVqujsxMDZid8sMACytKSUE41sKXHrKzKSGgozRi9fLNa9ubJPbRogs004VKigDe+iVAsd8zDYF09d4+S4BzYhgop2Zvl4c92Dcys2t9uen2smbrAovyTYc5RCoej29t7UPwyehTrTcwSBbGgs8whJfzDZAqtN3loGX60iTSNg8oTvEHS8b2HfSNZLgHf5RZv6QYyGWE0SHRGxAvfl1t6RIMRAg==
Received: from CH0PR04CA0014.namprd04.prod.outlook.com (2603:10b6:610:76::19)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:45:25 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::6c) by CH0PR04CA0014.outlook.office365.com
 (2603:10b6:610:76::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 06:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 23:45:12 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:45:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:45:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 5/7] net/mlx5e: Do not re-apply TIR loopback configuration if not necessary
Date: Thu, 23 Oct 2025 09:43:38 +0300
Message-ID: <1761201820-923638-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: da27cbd6-98ac-4a8f-b34f-08de11ffbedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0E8j1yaLG7YMBKwtognUqqHyDWf0Y1wNhIQWu37zFW+px+06u8JrSxQNHi4j?=
 =?us-ascii?Q?FfVML6EiB/BYXHHujdC21SgywV1TywUhEa75SE3fwELqa/oq1tA13oAq0ZA2?=
 =?us-ascii?Q?1r4p80pwZx6YYkkSo5OzIeLKcacADHH9iMapDVORofV0LImQX6UJZxZ5KiTG?=
 =?us-ascii?Q?agCpniU/u+h/ik+KzdaYEKitD5C7/JB9/NZVDcDsUqInt5BR+Zdmf8eKjWQw?=
 =?us-ascii?Q?+HUDvZiEHr4iGzUFRRrrxSyiqs1SM2ekk79Ywjc36cLyMbcl8DQboRGSchkh?=
 =?us-ascii?Q?ZyeRyXHCXMbNFb5fp6W8iBH4G4UzP/knvY7HILZnrVbx9JArE7J1YTUjlHwp?=
 =?us-ascii?Q?rEfsErWCdC8G/J781ZBlOyjZ/ifrHeAPBi50xKLLmphF5HRklhVS50n/Ivbs?=
 =?us-ascii?Q?iC98CbjM+7+UDTVXyeIj96bilPw9JkFlDCqKpt9BN7DZK3GEHytMvcnIdY6g?=
 =?us-ascii?Q?64weYhGy5eubgyo8t7tN4vRWiR2qBt1KzDRIVFIM3ONoSsyl9jVCFocinvEO?=
 =?us-ascii?Q?M9WBYaQbeE5LWjemvp4YHXRJIn1IHL+zmkbqVHJTiPQPfVCHXusEKDsLstkE?=
 =?us-ascii?Q?lkbLa/oHarNRiC/YtFs674SrbodLXowEmEBngo40BFDNP1skRmpuCpMUxTgx?=
 =?us-ascii?Q?AFd4UwmmZxXA2I8qspPN0smxkVwFGgR1eT9Fx5Baj9YlAaol9cd/GLfe9w65?=
 =?us-ascii?Q?KgRame2Ni6koGQEOuTv+8T+rsPkpDQVKl6zmAAqrxfQy/hz+03YxQ4za1PLT?=
 =?us-ascii?Q?RbbRU0SMkoBQ6lQvPFnbj4gZYuH7LoVyH6WZi8QUcX7VWRtFDa1ej29Tek/I?=
 =?us-ascii?Q?O3uCbBAH8qYYykmB3RNLiC+MoQLdmZRjwGXd269OqueGC+IUaAnsM15i+vAY?=
 =?us-ascii?Q?Cqf0Rv6UhOCsed/EL0vG31deVVZgpdFRkdFBTZkHdQU8W1Y3RDIb8i41R6KU?=
 =?us-ascii?Q?5tN9+jspd7xB/Q4oz57IZXkyzXIRcMBTuNDIa+T+UmNb0pqaDseh1/S/oJuu?=
 =?us-ascii?Q?0vAQ+ep4pZNRviIE7zz1pS1Drb6aqpC8IhUSDQNlV6vbyGzIsx8sB17sqZTT?=
 =?us-ascii?Q?R5h8plvyDgJgDtS6M+EutB8WsPH7tq/i86dUtyxi9tiajNVbMbc6RqIIBzjP?=
 =?us-ascii?Q?qzXUbtqumZ0coiQIyJGp5rSXttp7nKjHk+nR9V9GAvIxvIOY6SITxYkqdxi4?=
 =?us-ascii?Q?oFUVMiMNv5jQT59wG4BTMLo6eknBSFRrazkr7h4a6iEitR30uT6TL+ghOxAy?=
 =?us-ascii?Q?LOqqRF08UKNW2E4Iy7yhJXTWwacwrl/RzvPLCjnBJg1iOayO3bTFJd9JQNlE?=
 =?us-ascii?Q?FnWl5EsTW8SKihuGfMf9m5zk84c5xJqL4Vp65H6vfvCMIEJs+zKRc9MYWY9D?=
 =?us-ascii?Q?AByrwayQS2kKVANt2ksA8EWYp/T1fDXHFZNHQf3jvhu+Jm87UcgcwiBjH+WM?=
 =?us-ascii?Q?dhFHSoTS7PzRhbpjgCZiqtmxwY7j2R77gu8whSq66NLyIq1FClvBbFpG+McB?=
 =?us-ascii?Q?EifXfXbTbNCx6FMuY6g9ItF+UuLWw4Kp8UiGRHqic9SmTNsIgeG2ePLrzwtu?=
 =?us-ascii?Q?LU9t3e5J69LnBOolWac=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:24.8107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da27cbd6-98ac-4a8f-b34f-08de11ffbedc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346

On old firmware, (tis_tir_td_order=0), TIR of a transport domain should
either be created after all SQs of the same domain, or TIR.self_lb_en
should be reapplied using MODIFY_TIR, for self loopback filtering to
function correctly.

This is not necessary anymnore on new FW (tis_tir_td_order=1), thus
there's no need for calling modify_tir operations after creating a new
set of SQs to maintain the self loopback prevention functional.

Skip these operations.

This saves O(max_num_channels) MODIFY_TIR firmware commands in
operations like interface up or channels configuration change.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index fad6b761f622..1d663c9597a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -282,5 +282,8 @@ int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 int mlx5e_refresh_tirs(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 		       bool enable_mc_lb)
 {
+	if (MLX5_CAP_GEN(mdev, tis_tir_td_order))
+		return 0; /* refresh not needed */
+
 	return mlx5e_modify_tirs_lb(mdev, enable_uc_lb, enable_mc_lb);
 }
-- 
2.31.1


