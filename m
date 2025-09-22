Return-Path: <linux-rdma+bounces-13545-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99940B8F12C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 08:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1975D7AA5A8
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2622D94B3;
	Mon, 22 Sep 2025 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="td5PvJlL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010070.outbound.protection.outlook.com [52.101.46.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292572D592D;
	Mon, 22 Sep 2025 06:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758521238; cv=fail; b=KnB8ZV6t04o9PiZdv0WlUUngJ0i8mqRYSqVEOAfBJUdUg2tUYREi9jJrQ5Bf01c4beVbO0TFZDYbwtBox+/eDaxWz/c0f16ytPM6p+Vqi7E1WH9O8J24wVed+joUcpZAGmjzgvP27Dby/piFSheab3rZNwkB/dAXv+odvjimCKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758521238; c=relaxed/simple;
	bh=JfpQFnmypVavONx0nI+ea2//yz8wk7zfFRFsbkTqBrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPlyFOMWuquo+SNoX6W1qJPgGXrkVzTEHwy3P6vn4OZp7+G/rjBshslTjJLcyD8s0jH1FkK0/XqRd8NtkmyHbOZ5bEUGWhL4ELeXMca8YLJgHr7+VatqvXcgrXqw6TgxV2KIDUgwLSUxpOizfRb5rliZgC/OAAWa3lxuT1XvuwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=td5PvJlL; arc=fail smtp.client-ip=52.101.46.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ih7N+24O/mSUl8gta8y26ZgJGIBw6cQJGTdhi1v07SROg2yphKvTzqP3HyPRCfZE89+nDL3jrEviR82ue84AtNHBdKzdFEoGp9Bo9ETQOMJGOlx4DGIf/o6bQ2/+uC3j+4cbjqKhuI8fYImzBdLr6xz6yjZ+My1RysJjzpNeI13gRISgXlFo9hu/4OI9ZA4IIaGxq0LZW9q1EhBr/yRfMzFLs81Zms7lESTeA8+x5dhn+TWfiHYyQnbHw7f7odU+ofhPo1+B+D506z5iqQeLKLU977aicLRp7WcUC8PE1EvpM6sOJu8fhvJMxDeVXoPbEfBwhWqAOHmuKDU8LcRQFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ReJBm723rcNp0bCX/EdlrDln99RxIxG5t+HlHN6/pw=;
 b=Tt+Z7KPN7gQu7n9X6yFc3OQl+JMzXuUynFM7j5Zc6K49d6l0b7wBM9G18mclKrmGhLR8SAFBSvO4rJpHWK1LNQWFMOctCOWWcObQTX/DK/Q7mov1TKA2ovGy5iUMrQcEMwUI5fLK3SWtfXl9lGV/n44qoNqy/AVa2V9AkHnHhlNDRDUlfjOitx0NKgG33n8qG1I7UhDMbYXn6ORWakEVXqAnq6iYCYkB7+nVAy+CoMoM5Gy733JmTvOZsW0xueQu1owWUoVFUWyFMwMJ3Pfl663thddv47xgkmT6OFTrDhtq2ajs2YPpxV7dhuu8Bnvqy+VAd2Rpgg0iznOzQwJLMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ReJBm723rcNp0bCX/EdlrDln99RxIxG5t+HlHN6/pw=;
 b=td5PvJlLHyS/1F11WLNxYzzC9tiitAQ4Ju2zCHjpI7Tmddvg1WNydR51wVrzYa9+Zpqjm0e6+HzQHzV7lkUrcLxdJwp5Rc9h25jKYMb4xGj01Du0i2vbpzQVcdVXJQeZ5IejGelN+xetpxrjeNGXY0/6BFw5Ym9cS7Aq76e9v3Gfs8nb8rOu3g/QL/Q1Zk2B3R+Lbf+KLQ3HtQMNKhMAETxiu9KGEESy9O9/EU28WpfKKwnKasrI0YOxiaGDffw91V6ApAeHy/zXDeAoFH8H3EFZ47Nx0CBcBdF9DrUmHZ49ryLR/Anrc9cikPWU9oWVXE5ds0cE44jTLlVX+71NUw==
Received: from BN0PR10CA0024.namprd10.prod.outlook.com (2603:10b6:408:143::15)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 06:07:11 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::50) by BN0PR10CA0024.outlook.office365.com
 (2603:10b6:408:143::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 06:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 06:07:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 23:06:53 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 21 Sep
 2025 23:06:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 21
 Sep 2025 23:06:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH mlx5-next 1/2] net/mlx5: Add IFC bit for TIR/SQ order capability
Date: Mon, 22 Sep 2025 09:06:30 +0300
Message-ID: <1758521191-814350-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758521191-814350-1-git-send-email-tariqt@nvidia.com>
References: <1758521191-814350-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a1e616d-cc6d-419e-1bac-08ddf99e44cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Guz8gqJOSbSb6Tniagf2I+Mottnzq6JYENfLeBhxgNPVsyyvh8I3uSneh4jV?=
 =?us-ascii?Q?GnhyTZVJUTrlK+MfqdghIJr2SFIM1vygxHYhKknBFKwFQzQvxQJjQCdQ8y+2?=
 =?us-ascii?Q?s9h1bKXTsJ/7XHoeMgbGweTJRnQ7/sV/IDToewfMJQROdKSGNzRDxKX65m6g?=
 =?us-ascii?Q?h8iaJ91XSx5KkYYJE+gAeGKUWZkwdf9an0E/LF5mQpzpIgpuEC4LKdumLbAB?=
 =?us-ascii?Q?5Xv/Gal8ZlycmykPprwzczG4o1YQH0ivwjuNY8XeibpcqSFThr3ksjMORalb?=
 =?us-ascii?Q?NfWSR7ZjXymyxzj13jblJvrX/N5zP0/yfwBOPbUwMK23rzXz4Qh9D7OC1qlA?=
 =?us-ascii?Q?ZjSWBzeBBZz+XrT74YqGxVx0c3CmWhI9lZJdbPGU5n6jiZIBeFi2H/HqbZOD?=
 =?us-ascii?Q?UsA/6dlDxJxqrUc3amiFxCRKtqLiQ+SU4VUOLHYVCrMHQwtOLgufhggHVW0l?=
 =?us-ascii?Q?YlBA5CcIfGSRzMmDGj0vXyyZa1p/bHEZOyb8mTAs8xw47RC/xziVVLSN+YLS?=
 =?us-ascii?Q?o11jwvvJDn8oUx1BYPqlXyjpRl2W/4QRxaUeOuIlOb7LTMQpPqt41vJgFHo9?=
 =?us-ascii?Q?nWvZI+TztJ+Tm1+esgrtqaHjkV5mOdTQNVhFYomS24nMCYerlUYn3cqS6+d3?=
 =?us-ascii?Q?FNoJefxc5vcgI+XG4C6J0IU5PY4+EMZnrVTG3+76Q6tNs2Icewxmu/emVXU+?=
 =?us-ascii?Q?LKy+vMtjp7fPTVQSI9NxLIQ1YDpoE/0ETdwQGNI16BtmBdnrMYBft4qlCHMC?=
 =?us-ascii?Q?FX35ovUMO170miCw0vvhMSPqYztE0NYYxugEiATmj4Tj/kbAuKcNI9U5EjUM?=
 =?us-ascii?Q?65Zgbmlj3xmJenaTzlqQZfmtLqkWryS1/BULeEaIQ1eegQHpP91FQEz81dUI?=
 =?us-ascii?Q?7k0u0FRd9LhMF9vJ7qOrUap+PI28LVhFPL2eStGOZq0GpDHUX/AfxqPOSDrb?=
 =?us-ascii?Q?6YLWrq7zELG0IyPrvlWHtqp6SbsdTs1e9sEMZ1iqvbYi6uxyyWHdAC6PRhOE?=
 =?us-ascii?Q?kZ8ftCtT78As8aef0QR3EaFRpTyKX+nM1E7gexYdaWOLAzEr6otQlyQZHnZh?=
 =?us-ascii?Q?7C5diDL82TCpSCKshhiqVaHgAEhkHSe0lPwO4dldVaEgrNufVRVzLOsDFX9O?=
 =?us-ascii?Q?7axM8WVMHzL/5MRjhhnr7W6BAX1fAmaUI6l+YhMvjeM/5YTw29m2lw3mQvah?=
 =?us-ascii?Q?EiRUh3dl1wZE5TVKW7fO7ovyT44E6/u7tE/6t/YlRG4/H24g1cBM8hvMLl8e?=
 =?us-ascii?Q?5s/OYVevjTKCDD+jHbXKSs9UsNTuWy+gyX3un3SiYB2FbWMIb7JtZFJwteMn?=
 =?us-ascii?Q?GGN4UBzhNXX2l7AE8XiZeAvvCZMHrlXDY4UTPShz0HCwXyADdoVsPK62Jg7G?=
 =?us-ascii?Q?4mZJO6Wxq4yQY0GZWWn/W/ZSDQe0aXzm60074PrfLBKs4WLd+kZT6ug27o3B?=
 =?us-ascii?Q?rEDUkMFRjd3tI1iL+G8jBUXAT5hmElRQll1xpLr90sJCebA+9zc+LEV1RqVA?=
 =?us-ascii?Q?QiTVwKMj+3oZ3/AcTGSENQ1KZVZ46pBQWIAY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 06:07:10.9287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a1e616d-cc6d-419e-1bac-08ddf99e44cf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659

Before this cap, firmware requested a certain creation order between TIR
objects and SQs of the same transport domain to properly support the
self loopback prevention feature. If order is not preserved, explicit
modify_tir operations are necessary after the opening of the SQs.

When set, this cap bit indicates that this firmware requirement /
limitation no longer holds.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 0cf187e13def..c0f5fee7a4a5 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1895,7 +1895,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         reserved_at_2a0[0x7];
 	u8         mkey_pcie_tph[0x1];
-	u8         reserved_at_2a8[0x2];
+	u8         reserved_at_2a8[0x1];
+	u8         tis_tir_td_order[0x1];
 
 	u8         psp[0x1];
 	u8         shampo[0x1];
-- 
2.31.1


