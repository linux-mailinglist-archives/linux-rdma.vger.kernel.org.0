Return-Path: <linux-rdma+bounces-9353-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1EFA84CD6
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FBC1895741
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2312980B4;
	Thu, 10 Apr 2025 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QWHfjGyp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A32980AC;
	Thu, 10 Apr 2025 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312763; cv=fail; b=mkFyXgxFrXGsN+4MIPz0RxzgvPXw4nKoF+livPeuiwAAok289JxL9jII4QmS3/qg6wLNb0TXq1zyOqwc+hZV8O9rGyncOh85ICSrnAGbqsSAXSvkArbU0UuOAYrNIo5qfnepft2lhiyr2vmRIC7BEw99TG00E7Oly8AkxgS9wm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312763; c=relaxed/simple;
	bh=LdWbAvwVV3gdpqNIW7snSk18guPZp4MDOVRwqcioHHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KezEuk5aklQJk3N9jqgnrLvEDDbpAgL8y0VIxPqIqGYE9X+BltifcdGvAEZD0cmTl5KwM8M/6nZv9oXjSJvkRKdKkrrk3vrPI/SRlMmbJq9EarhYYVpQg4vsPqrz7r79BL5zf8v92tHLvI517efPkRVoKgachszfXJFWnw9Jg5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QWHfjGyp; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/a0Q4lwOEkA4o9ZLIHXl5SvrWwjhLX1Qnp2jOf6pq/IstCj31i8cUaq1WxTbGdmha9DqWyLc2FMEDWCzVyI6XwHozuFmeTah/tAQrY1Unbzm5UWUCdyli2zFXaDK2Z4a+ZgW4rtxJ8qaOwQzu9ZhfPEGMrE3gOy9kQYkNkS3UIDXHawgBN7bExuPK9NYEZk0pjXbnO9GaNC3h3ijfslMbwK4zNIX4UV4KPjur3f6dVKFc6ErV2Bt10aht7UDQcVQGAPQmabPtJ5MMFBUIro9OQveBpaQA5AlVdOp8sPBW+KfKp/d9tj8BKtabFdQkEJq20SlMK4U+sw/ZxQakqrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4uC3Tae1BvHEGMR+mXAwlWyNT9nTTI01Bks0njptF0=;
 b=n7WDj0kxTnMmZNh+HqLCtnxudoQyil16EROCzFzHfLpt/QK8fXDSmdDDQBA3r30Viiut2B+176RVuLZIqORBKHqAM0d8u8toISMoC2fxB8f30vaav085PABIBs5P7u0tlAda3H4t42YoD5onawFgyrDatbAkXfG9Zz/Po2uCRVM2QPN+2NjwkhdxHmLljwtf+QrxrxmnWkND+2Wt9GDhqPqwQ8YWlKffnFXydI2SU/+QM43iwRPxLEVJPZIEjDiB45qLF7dYiPx3nJ/Gf4mfBklz3S/FXQpVrcCnZJxMf+ZD3Jc+V4usAQlDw5co9+nlwrqCCI0fXyJwOwcUX7D+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4uC3Tae1BvHEGMR+mXAwlWyNT9nTTI01Bks0njptF0=;
 b=QWHfjGypLcdtjbqrq7qnksxnhAAIEkJBU/91J36z4HMfBWdYj0MY2OdVN390QJPUGjhP3rgiYHTyM17d/WATWrz4OJ822T3zQwbiv5qWGo932ThXlQJyIoH1UD8v67Lvs86RxQuQPFIjOh1qGeu81WOPud+/zAjB33fcLkkEEUXDb023zfsj34XcxQr9STZ0vC8k1nPstmaFopSLpc7TbdvpZN6p1SCXeV+pcpChmu1SkFIXpKZ/2ZZQiiMED9udvQJZe/GxAq2cuy9h+Ihfo+w1xUzL+RjhKLv3FOZkTXcPxwhjqeViHntSEuuI0YMmSHUwXWRtj4BLREPlXoyb4A==
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.20; Thu, 10 Apr
 2025 19:19:10 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::73) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Thu,
 10 Apr 2025 19:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:19:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:55 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 10/12] net/mlx5: HWS, Cleanup matcher action STE table
Date: Thu, 10 Apr 2025 22:17:40 +0300
Message-ID: <1744312662-356571-11-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1accd30b-6146-444d-46e1-08dd78649232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kgaYe0JthOSpr/BwZKzVi5ugu+xE/XxD9ZfF1mBeSVilI4inCHQ3AAIMm3lT?=
 =?us-ascii?Q?KgNR/SDcTSCsQzsH9aF6SxsTgEgDxp2wQUJWdr7CBlKlx5qQ/vUlJ4eouekx?=
 =?us-ascii?Q?g5jFOOVqi5HsDvXICYig6z40InDjPF5ctCS16XAHr0UgCohb3gyikKmv9wdQ?=
 =?us-ascii?Q?ZR2G+e+I/ojx65g9xbZ+9qkjVzvEhL4vUF5enasv6BqPZUyR2rgCno6MuA5E?=
 =?us-ascii?Q?42wF4FRYJ513hSdHY8n7+SdOONQd2h7oCMCubRsR31MPkW/UEOS7sBeyffd6?=
 =?us-ascii?Q?BqNFZmaby8BtuKyA2uJFDE3qKogfpOf8yPaAxnjy7CFPf/8y8F4e8VMMtcQE?=
 =?us-ascii?Q?Ja6BwwLnTS3UWf1EussHYNdG6L9zP/dRsWQNqSlUEv2Bz0yLJ7hLOR5/+a73?=
 =?us-ascii?Q?kYTIA69hisid+oPYKCd1TUI4K0YW9ck2CODSGXka5dz3QNvkd1UuVJKV/nJc?=
 =?us-ascii?Q?HiV/s8EWTqcuW/4C4I5AdmoJJrJFc3Pr08ei/UCiBFmsAA6khmK3WmB1PgQ1?=
 =?us-ascii?Q?wG9P8WtlKuYYF46LMhRyHFmgJHaZExaTACit7VDf+x15h9zlHjLh0tDiqbXk?=
 =?us-ascii?Q?5ZP14W2GE34LWcWytSp8h69PXMHDaVuADnV+dyjCDUDOj47HQcQV3wG2LX4T?=
 =?us-ascii?Q?kegaicQ2+DNRRkjM3ImSg8pJakc8i5yXlb3MAY38+Z/PKCm2Lo2MB948YnsE?=
 =?us-ascii?Q?vPsG5GMo+iNuIhplOpuSL2cVX1pa2/58dgGvx2gSve6fu9sr+A0VprFqzd19?=
 =?us-ascii?Q?QP6WqdfwcrI1VViZsNsWL/G7HwGuUzyU/QgdWqKamUahR5v2KwN3eHnwXLDr?=
 =?us-ascii?Q?fMps9EtSAlAJ5KATo9O7TfYLxA5wz0P2tkuTIatv9SsLOEdVJSXOQEElDg2D?=
 =?us-ascii?Q?5EMd54Vs9HXHmEu5heTIiNWVBAOGEivDsVqqHlNlrUJRWWquopxRfj6wKi04?=
 =?us-ascii?Q?qst0k/b4abTcF0DwaSV/70lS9X+oJBgo0URi0BkjSgCF6xohnAdzXYrvA6s5?=
 =?us-ascii?Q?NgQrRJfp9PhZOQGIwTsXCEcpU1fNmJf9W5l//HSzQwdvRopSC44dl6LS6EFa?=
 =?us-ascii?Q?z51A/PYwMGLUak9EVzO9efdGKqqzm3CSI9xgSHwSEocGUyFV3WPIdV2WPOTn?=
 =?us-ascii?Q?viemWTmQSVhfdOXDpGTvF004NXefZmhRgey/KtRfpRvOIo0sd3Mbkoccizf1?=
 =?us-ascii?Q?4C+Hu/owHavdslt44XdLGWKJD4V766gpZ1MY/tPltvwkN+ELJhhZTxIPwFie?=
 =?us-ascii?Q?1PSmQzXZIomUlIRAe6K7dmrWjo9hBR+gglkVOXbgV+lxRFEAKb+kcfCev95R?=
 =?us-ascii?Q?F+NX3kDn1TSePH+7xOqZQMhcYhhZWp6OaHJ8fvS4MFg+8ccMqxohQHqIL0Wm?=
 =?us-ascii?Q?Vn8Dqog6ic1zU12n0Ro9azD4yWdJYzAcgYTK1RfwJ3FJ8OJe0hvHVSJP8JRy?=
 =?us-ascii?Q?ZF3+qL/jxZHy9zL2GmpHTSoN8uVwG9zCuvM0Vn8YooD0e33Pmxfao/U/0V1K?=
 =?us-ascii?Q?71D5t1BeXKuOCdp19VOsrYcwJ0OEa5XI+wsI?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:19:10.0059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1accd30b-6146-444d-46e1-08dd78649232
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828

From: Vlad Dogaru <vdogaru@nvidia.com>

Remove the matcher action STE implementation now that the code uses
per-queue action STE pools. This also allows simplifying matcher code
because it is now only handling a single type of RTC/STE.

The matcher resize data is also going away. Matchers were saving old
action STE data because the rules still used it, but now that data lives
in the action STE pool and is no longer coupled to a matcher.

Furthermore, matchers no longer need to rehash a due to action template
addition.  If a new action template needs more action STEs, we simply
update the matcher's num_of_action_stes and future rules will allocate
the correct number. Existing rules are unaffected by such an operation
and can continue to use their existing action STEs.

The range action was using the matcher action STE implementation, but
there was no reason to do this other than the container fitting the
purpose. Extract that information to a separate structure.

Finally, stop dumping per-matcher information about action RTCs,
because they no longer exist. A later patch in this series will add
support for dumping action STE pools.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/action.c  |  23 +-
 .../mellanox/mlx5/core/steering/hws/action.h  |   8 +-
 .../mellanox/mlx5/core/steering/hws/bwc.c     |  77 +---
 .../mellanox/mlx5/core/steering/hws/debug.c   |  17 +-
 .../mellanox/mlx5/core/steering/hws/matcher.c | 336 ++++--------------
 .../mellanox/mlx5/core/steering/hws/matcher.h |  20 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |   5 +-
 .../mellanox/mlx5/core/steering/hws/rule.c    |   2 +-
 8 files changed, 87 insertions(+), 401 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
index 161ad720b339..bef4d25c1a2a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.c
@@ -1574,13 +1574,13 @@ hws_action_create_dest_match_range_definer(struct mlx5hws_context *ctx)
 	return definer;
 }
 
-static struct mlx5hws_matcher_action_ste *
+static struct mlx5hws_range_action_table *
 hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 					 struct mlx5hws_definer *definer,
 					 u32 miss_ft_id)
 {
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
-	struct mlx5hws_matcher_action_ste *table_ste;
+	struct mlx5hws_range_action_table *table_ste;
 	struct mlx5hws_pool_attr pool_attr = {0};
 	struct mlx5hws_pool *ste_pool, *stc_pool;
 	u32 *rtc_0_id, *rtc_1_id;
@@ -1669,9 +1669,9 @@ hws_action_create_dest_match_range_table(struct mlx5hws_context *ctx,
 	return NULL;
 }
 
-static void
-hws_action_destroy_dest_match_range_table(struct mlx5hws_context *ctx,
-					  struct mlx5hws_matcher_action_ste *table_ste)
+static void hws_action_destroy_dest_match_range_table(
+	struct mlx5hws_context *ctx,
+	struct mlx5hws_range_action_table *table_ste)
 {
 	mutex_lock(&ctx->ctrl_lock);
 
@@ -1683,12 +1683,11 @@ hws_action_destroy_dest_match_range_table(struct mlx5hws_context *ctx,
 	mutex_unlock(&ctx->ctrl_lock);
 }
 
-static int
-hws_action_create_dest_match_range_fill_table(struct mlx5hws_context *ctx,
-					      struct mlx5hws_matcher_action_ste *table_ste,
-					      struct mlx5hws_action *hit_ft_action,
-					      struct mlx5hws_definer *range_definer,
-					      u32 min, u32 max)
+static int hws_action_create_dest_match_range_fill_table(
+	struct mlx5hws_context *ctx,
+	struct mlx5hws_range_action_table *table_ste,
+	struct mlx5hws_action *hit_ft_action,
+	struct mlx5hws_definer *range_definer, u32 min, u32 max)
 {
 	struct mlx5hws_wqe_gta_data_seg_ste match_wqe_data = {0};
 	struct mlx5hws_wqe_gta_data_seg_ste range_wqe_data = {0};
@@ -1784,7 +1783,7 @@ mlx5hws_action_create_dest_match_range(struct mlx5hws_context *ctx,
 				       u32 min, u32 max, u32 flags)
 {
 	struct mlx5hws_cmd_stc_modify_attr stc_attr = {0};
-	struct mlx5hws_matcher_action_ste *table_ste;
+	struct mlx5hws_range_action_table *table_ste;
 	struct mlx5hws_action *hit_ft_action;
 	struct mlx5hws_definer *definer;
 	struct mlx5hws_action *action;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
index 64b76075f7f8..25fa0d4c9221 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action.h
@@ -118,6 +118,12 @@ struct mlx5hws_action_template {
 	u8 only_term;
 };
 
+struct mlx5hws_range_action_table {
+	struct mlx5hws_pool *pool;
+	u32 rtc_0_id;
+	u32 rtc_1_id;
+};
+
 struct mlx5hws_action {
 	u8 type;
 	u8 flags;
@@ -186,7 +192,7 @@ struct mlx5hws_action {
 					size_t size;
 				} remove_header;
 				struct {
-					struct mlx5hws_matcher_action_ste *table_ste;
+					struct mlx5hws_range_action_table *table_ste;
 					struct mlx5hws_action *hit_ft_action;
 					struct mlx5hws_definer *definer;
 				} range;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 32de8bfc7644..510bfbbe5991 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -478,21 +478,9 @@ hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher)
 	struct mlx5hws_cmd_query_caps *caps = bwc_matcher->matcher->tbl->ctx->caps;
 
 	/* check the match RTC size */
-	if ((bwc_matcher->size_log +
-	     MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
-	     MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP) >
-	    (caps->ste_alloc_log_max - 1))
-		return true;
-
-	/* check the action RTC size */
-	if ((bwc_matcher->size_log +
-	     MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP +
-	     ilog2(roundup_pow_of_two(bwc_matcher->matcher->action_ste.max_stes)) +
-	     MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT) >
-	    (caps->ste_alloc_log_max - 1))
-		return true;
-
-	return false;
+	return (bwc_matcher->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
+		MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP) >
+	       (caps->ste_alloc_log_max - 1);
 }
 
 static bool
@@ -779,19 +767,6 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	return hws_bwc_matcher_move(bwc_matcher);
 }
 
-static int
-hws_bwc_matcher_rehash_at(struct mlx5hws_bwc_matcher *bwc_matcher)
-{
-	/* Rehash by action template doesn't require any additional checking.
-	 * The bwc_matcher already contains the new action template.
-	 * Just do the usual rehash:
-	 *  - create new matcher
-	 *  - move all the rules to the new matcher
-	 *  - destroy the old matcher
-	 */
-	return hws_bwc_matcher_move(bwc_matcher);
-}
-
 int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 				   u32 *match_param,
 				   struct mlx5hws_rule_action rule_actions[],
@@ -803,7 +778,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
 	u32 num_of_rules;
-	bool need_rehash;
 	int ret = 0;
 	int at_idx;
 
@@ -830,30 +804,11 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		at_idx = bwc_matcher->num_of_at - 1;
 
 		ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-						bwc_matcher->at[at_idx],
-						&need_rehash);
+						bwc_matcher->at[at_idx]);
 		if (unlikely(ret)) {
 			hws_bwc_unlock_all_queues(ctx);
 			return ret;
 		}
-		if (unlikely(need_rehash)) {
-			/* The new action template requires more action STEs.
-			 * Need to attempt creating new matcher with all
-			 * the action templates, including the new one.
-			 */
-			ret = hws_bwc_matcher_rehash_at(bwc_matcher);
-			if (unlikely(ret)) {
-				mlx5hws_action_template_destroy(bwc_matcher->at[at_idx]);
-				bwc_matcher->at[at_idx] = NULL;
-				bwc_matcher->num_of_at--;
-
-				hws_bwc_unlock_all_queues(ctx);
-
-				mlx5hws_err(ctx,
-					    "BWC rule insertion: rehash AT failed (%d)\n", ret);
-				return ret;
-			}
-		}
 
 		hws_bwc_unlock_all_queues(ctx);
 		mutex_lock(queue_lock);
@@ -973,7 +928,6 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
-	bool need_rehash;
 	int at_idx, ret;
 	u16 idx;
 
@@ -1005,32 +959,11 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 			at_idx = bwc_matcher->num_of_at - 1;
 
 			ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
-							bwc_matcher->at[at_idx],
-							&need_rehash);
+							bwc_matcher->at[at_idx]);
 			if (unlikely(ret)) {
 				hws_bwc_unlock_all_queues(ctx);
 				return ret;
 			}
-			if (unlikely(need_rehash)) {
-				/* The new action template requires more action
-				 * STEs. Need to attempt creating new matcher
-				 * with all the action templates, including the
-				 * new one.
-				 */
-				ret = hws_bwc_matcher_rehash_at(bwc_matcher);
-				if (unlikely(ret)) {
-					mlx5hws_action_template_destroy(bwc_matcher->at[at_idx]);
-					bwc_matcher->at[at_idx] = NULL;
-					bwc_matcher->num_of_at--;
-
-					hws_bwc_unlock_all_queues(ctx);
-
-					mlx5hws_err(ctx,
-						    "BWC rule update: rehash AT failed (%d)\n",
-						    ret);
-					return ret;
-				}
-			}
 		}
 
 		hws_bwc_unlock_all_queues(ctx);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
index 3491408c5d84..38f75dec9cfc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/debug.c
@@ -146,18 +146,6 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 		   matcher->match_ste.rtc_1_id,
 		   (int)ste_1_id);
 
-	ste_pool = matcher->action_ste.pool;
-	if (ste_pool) {
-		ste_0_id = mlx5hws_pool_get_base_id(ste_pool);
-		if (tbl_type == MLX5HWS_TABLE_TYPE_FDB)
-			ste_1_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
-		else
-			ste_1_id = -1;
-	} else {
-		ste_0_id = -1;
-		ste_1_id = -1;
-	}
-
 	ft_attr.type = matcher->tbl->fw_ft_type;
 	ret = mlx5hws_cmd_flow_table_query(matcher->tbl->ctx->mdev,
 					   matcher->end_ft_id,
@@ -167,10 +155,7 @@ static int hws_debug_dump_matcher(struct seq_file *f, struct mlx5hws_matcher *ma
 	if (ret)
 		return ret;
 
-	seq_printf(f, ",%d,%d,%d,%d,%d,0x%llx,0x%llx\n",
-		   matcher->action_ste.rtc_0_id, (int)ste_0_id,
-		   matcher->action_ste.rtc_1_id, (int)ste_1_id,
-		   0,
+	seq_printf(f, ",-1,-1,-1,-1,0,0x%llx,0x%llx\n",
 		   mlx5hws_debug_icm_to_idx(icm_addr_0),
 		   mlx5hws_debug_icm_to_idx(icm_addr_1));
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 3028e0387e3f..716502732d3d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -3,25 +3,6 @@
 
 #include "internal.h"
 
-enum mlx5hws_matcher_rtc_type {
-	HWS_MATCHER_RTC_TYPE_MATCH,
-	HWS_MATCHER_RTC_TYPE_STE_ARRAY,
-	HWS_MATCHER_RTC_TYPE_MAX,
-};
-
-static const char * const mlx5hws_matcher_rtc_type_str[] = {
-	[HWS_MATCHER_RTC_TYPE_MATCH] = "MATCH",
-	[HWS_MATCHER_RTC_TYPE_STE_ARRAY] = "STE_ARRAY",
-	[HWS_MATCHER_RTC_TYPE_MAX] = "UNKNOWN",
-};
-
-static const char *hws_matcher_rtc_type_to_str(enum mlx5hws_matcher_rtc_type rtc_type)
-{
-	if (rtc_type > HWS_MATCHER_RTC_TYPE_MAX)
-		rtc_type = HWS_MATCHER_RTC_TYPE_MAX;
-	return mlx5hws_matcher_rtc_type_str[rtc_type];
-}
-
 static bool hws_matcher_requires_col_tbl(u8 log_num_of_rules)
 {
 	/* Collision table concatenation is done only for large rule tables */
@@ -209,83 +190,52 @@ static void hws_matcher_set_rtc_attr_sz(struct mlx5hws_matcher *matcher,
 	}
 }
 
-static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
-				  enum mlx5hws_matcher_rtc_type rtc_type)
+static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_matcher_attr *attr = &matcher->attr;
 	struct mlx5hws_cmd_rtc_create_attr rtc_attr = {0};
 	struct mlx5hws_match_template *mt = matcher->mt;
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
-	struct mlx5hws_matcher_action_ste *action_ste;
 	struct mlx5hws_table *tbl = matcher->tbl;
-	struct mlx5hws_pool *ste_pool;
-	u32 *rtc_0_id, *rtc_1_id;
 	u32 obj_id;
 	int ret;
 
-	switch (rtc_type) {
-	case HWS_MATCHER_RTC_TYPE_MATCH:
-		rtc_0_id = &matcher->match_ste.rtc_0_id;
-		rtc_1_id = &matcher->match_ste.rtc_1_id;
-		ste_pool = matcher->match_ste.pool;
-
-		rtc_attr.log_size = attr->table.sz_row_log;
-		rtc_attr.log_depth = attr->table.sz_col_log;
-		rtc_attr.is_frst_jumbo = mlx5hws_matcher_mt_is_jumbo(mt);
-		rtc_attr.is_scnd_range = 0;
-		rtc_attr.miss_ft_id = matcher->end_ft_id;
-
-		if (attr->insert_mode == MLX5HWS_MATCHER_INSERT_BY_HASH) {
-			/* The usual Hash Table */
-			rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_HASH;
-
-			/* The first mt is used since all share the same definer */
-			rtc_attr.match_definer_0 = mlx5hws_definer_get_id(mt->definer);
-		} else if (attr->insert_mode == MLX5HWS_MATCHER_INSERT_BY_INDEX) {
-			rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
-			rtc_attr.num_hash_definer = 1;
-
-			if (attr->distribute_mode == MLX5HWS_MATCHER_DISTRIBUTE_BY_HASH) {
-				/* Hash Split Table */
-				rtc_attr.access_index_mode = MLX5_IFC_RTC_STE_ACCESS_MODE_BY_HASH;
-				rtc_attr.match_definer_0 = mlx5hws_definer_get_id(mt->definer);
-			} else if (attr->distribute_mode == MLX5HWS_MATCHER_DISTRIBUTE_BY_LINEAR) {
-				/* Linear Lookup Table */
-				rtc_attr.access_index_mode = MLX5_IFC_RTC_STE_ACCESS_MODE_LINEAR;
-				rtc_attr.match_definer_0 = ctx->caps->linear_match_definer;
-			}
+	rtc_attr.log_size = attr->table.sz_row_log;
+	rtc_attr.log_depth = attr->table.sz_col_log;
+	rtc_attr.is_frst_jumbo = mlx5hws_matcher_mt_is_jumbo(mt);
+	rtc_attr.is_scnd_range = 0;
+	rtc_attr.miss_ft_id = matcher->end_ft_id;
+
+	if (attr->insert_mode == MLX5HWS_MATCHER_INSERT_BY_HASH) {
+		/* The usual Hash Table */
+		rtc_attr.update_index_mode =
+			MLX5_IFC_RTC_STE_UPDATE_MODE_BY_HASH;
+
+		/* The first mt is used since all share the same definer */
+		rtc_attr.match_definer_0 = mlx5hws_definer_get_id(mt->definer);
+	} else if (attr->insert_mode == MLX5HWS_MATCHER_INSERT_BY_INDEX) {
+		rtc_attr.update_index_mode =
+			MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
+		rtc_attr.num_hash_definer = 1;
+
+		if (attr->distribute_mode ==
+		    MLX5HWS_MATCHER_DISTRIBUTE_BY_HASH) {
+			/* Hash Split Table */
+			rtc_attr.access_index_mode =
+				MLX5_IFC_RTC_STE_ACCESS_MODE_BY_HASH;
+			rtc_attr.match_definer_0 =
+				mlx5hws_definer_get_id(mt->definer);
+		} else if (attr->distribute_mode ==
+			   MLX5HWS_MATCHER_DISTRIBUTE_BY_LINEAR) {
+			/* Linear Lookup Table */
+			rtc_attr.access_index_mode =
+				MLX5_IFC_RTC_STE_ACCESS_MODE_LINEAR;
+			rtc_attr.match_definer_0 =
+				ctx->caps->linear_match_definer;
 		}
-		break;
-
-	case HWS_MATCHER_RTC_TYPE_STE_ARRAY:
-		action_ste = &matcher->action_ste;
-
-		rtc_0_id = &action_ste->rtc_0_id;
-		rtc_1_id = &action_ste->rtc_1_id;
-		ste_pool = action_ste->pool;
-		/* Action RTC size calculation:
-		 * log((max number of rules in matcher) *
-		 *     (max number of action STEs per rule) *
-		 *     (2 to support writing new STEs for update rule))
-		 */
-		rtc_attr.log_size =
-			ilog2(roundup_pow_of_two(action_ste->max_stes)) +
-			attr->table.sz_row_log +
-			MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT;
-		rtc_attr.log_depth = 0;
-		rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
-		/* The action STEs use the default always hit definer */
-		rtc_attr.match_definer_0 = ctx->caps->trivial_match_definer;
-		rtc_attr.is_frst_jumbo = false;
-		rtc_attr.miss_ft_id = 0;
-		break;
-
-	default:
-		mlx5hws_err(ctx, "HWS Invalid RTC type\n");
-		return -EINVAL;
 	}
 
-	obj_id = mlx5hws_pool_get_base_id(ste_pool);
+	obj_id = mlx5hws_pool_get_base_id(matcher->match_ste.pool);
 
 	rtc_attr.pd = ctx->pd_num;
 	rtc_attr.ste_base = obj_id;
@@ -297,15 +247,16 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	obj_id = mlx5hws_pool_get_base_id(ctx->stc_pool);
 	rtc_attr.stc_base = obj_id;
 
-	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_0_id);
+	ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr,
+				     &matcher->match_ste.rtc_0_id);
 	if (ret) {
-		mlx5hws_err(ctx, "Failed to create matcher RTC of type %s",
-			    hws_matcher_rtc_type_to_str(rtc_type));
+		mlx5hws_err(ctx, "Failed to create matcher RTC\n");
 		return ret;
 	}
 
 	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB) {
-		obj_id = mlx5hws_pool_get_base_mirror_id(ste_pool);
+		obj_id = mlx5hws_pool_get_base_mirror_id(
+			matcher->match_ste.pool);
 		rtc_attr.ste_base = obj_id;
 		rtc_attr.table_type = mlx5hws_table_get_res_fw_ft_type(tbl->type, true);
 
@@ -313,10 +264,10 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 		rtc_attr.stc_base = obj_id;
 		hws_matcher_set_rtc_attr_sz(matcher, &rtc_attr, true);
 
-		ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr, rtc_1_id);
+		ret = mlx5hws_cmd_rtc_create(ctx->mdev, &rtc_attr,
+					     &matcher->match_ste.rtc_1_id);
 		if (ret) {
-			mlx5hws_err(ctx, "Failed to create peer matcher RTC of type %s",
-				    hws_matcher_rtc_type_to_str(rtc_type));
+			mlx5hws_err(ctx, "Failed to create mirror matcher RTC\n");
 			goto destroy_rtc_0;
 		}
 	}
@@ -324,33 +275,18 @@ static int hws_matcher_create_rtc(struct mlx5hws_matcher *matcher,
 	return 0;
 
 destroy_rtc_0:
-	mlx5hws_cmd_rtc_destroy(ctx->mdev, *rtc_0_id);
+	mlx5hws_cmd_rtc_destroy(ctx->mdev, matcher->match_ste.rtc_0_id);
 	return ret;
 }
 
-static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher,
-				    enum mlx5hws_matcher_rtc_type rtc_type)
+static void hws_matcher_destroy_rtc(struct mlx5hws_matcher *matcher)
 {
-	struct mlx5hws_table *tbl = matcher->tbl;
-	u32 rtc_0_id, rtc_1_id;
-
-	switch (rtc_type) {
-	case HWS_MATCHER_RTC_TYPE_MATCH:
-		rtc_0_id = matcher->match_ste.rtc_0_id;
-		rtc_1_id = matcher->match_ste.rtc_1_id;
-		break;
-	case HWS_MATCHER_RTC_TYPE_STE_ARRAY:
-		rtc_0_id = matcher->action_ste.rtc_0_id;
-		rtc_1_id = matcher->action_ste.rtc_1_id;
-		break;
-	default:
-		return;
-	}
+	struct mlx5_core_dev *mdev = matcher->tbl->ctx->mdev;
 
-	if (tbl->type == MLX5HWS_TABLE_TYPE_FDB)
-		mlx5hws_cmd_rtc_destroy(tbl->ctx->mdev, rtc_1_id);
+	if (matcher->tbl->type == MLX5HWS_TABLE_TYPE_FDB)
+		mlx5hws_cmd_rtc_destroy(mdev, matcher->match_ste.rtc_1_id);
 
-	mlx5hws_cmd_rtc_destroy(tbl->ctx->mdev, rtc_0_id);
+	mlx5hws_cmd_rtc_destroy(mdev, matcher->match_ste.rtc_0_id);
 }
 
 static int
@@ -418,85 +354,17 @@ static int hws_matcher_check_and_process_at(struct mlx5hws_matcher *matcher,
 	return 0;
 }
 
-static int hws_matcher_resize_init(struct mlx5hws_matcher *src_matcher)
-{
-	struct mlx5hws_matcher_resize_data *resize_data;
-
-	resize_data = kzalloc(sizeof(*resize_data), GFP_KERNEL);
-	if (!resize_data)
-		return -ENOMEM;
-
-	resize_data->max_stes = src_matcher->action_ste.max_stes;
-
-	resize_data->stc = src_matcher->action_ste.stc;
-	resize_data->rtc_0_id = src_matcher->action_ste.rtc_0_id;
-	resize_data->rtc_1_id = src_matcher->action_ste.rtc_1_id;
-	resize_data->pool = src_matcher->action_ste.max_stes ?
-			    src_matcher->action_ste.pool : NULL;
-
-	/* Place the new resized matcher on the dst matcher's list */
-	list_add(&resize_data->list_node, &src_matcher->resize_dst->resize_data);
-
-	/* Move all the previous resized matchers to the dst matcher's list */
-	while (!list_empty(&src_matcher->resize_data)) {
-		resize_data = list_first_entry(&src_matcher->resize_data,
-					       struct mlx5hws_matcher_resize_data,
-					       list_node);
-		list_del_init(&resize_data->list_node);
-		list_add(&resize_data->list_node, &src_matcher->resize_dst->resize_data);
-	}
-
-	return 0;
-}
-
-static void hws_matcher_resize_uninit(struct mlx5hws_matcher *matcher)
-{
-	struct mlx5hws_matcher_resize_data *resize_data;
-
-	if (!mlx5hws_matcher_is_resizable(matcher))
-		return;
-
-	while (!list_empty(&matcher->resize_data)) {
-		resize_data = list_first_entry(&matcher->resize_data,
-					       struct mlx5hws_matcher_resize_data,
-					       list_node);
-		list_del_init(&resize_data->list_node);
-
-		if (resize_data->max_stes) {
-			mlx5hws_action_free_single_stc(matcher->tbl->ctx,
-						       matcher->tbl->type,
-						       &resize_data->stc);
-
-			if (matcher->tbl->type == MLX5HWS_TABLE_TYPE_FDB)
-				mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev,
-							resize_data->rtc_1_id);
-
-			mlx5hws_cmd_rtc_destroy(matcher->tbl->ctx->mdev,
-						resize_data->rtc_0_id);
-
-			if (resize_data->pool)
-				mlx5hws_pool_destroy(resize_data->pool);
-		}
-
-		kfree(resize_data);
-	}
-}
-
 static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 {
 	bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
-	struct mlx5hws_cmd_stc_modify_attr stc_attr = {0};
-	struct mlx5hws_matcher_action_ste *action_ste;
-	struct mlx5hws_table *tbl = matcher->tbl;
-	struct mlx5hws_pool_attr pool_attr = {0};
-	struct mlx5hws_context *ctx = tbl->ctx;
-	u32 required_stes;
-	u8 max_stes = 0;
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	u8 required_stes, max_stes;
 	int i, ret;
 
 	if (matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION)
 		return 0;
 
+	max_stes = 0;
 	for (i = 0; i < matcher->num_of_at; i++) {
 		struct mlx5hws_action_template *at = &matcher->at[i];
 
@@ -512,74 +380,9 @@ static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 		/* Future: Optimize reparse */
 	}
 
-	/* There are no additional STEs required for matcher */
-	if (!max_stes)
-		return 0;
-
-	matcher->action_ste.max_stes = max_stes;
-
-	action_ste = &matcher->action_ste;
-
-	/* Allocate action STE mempool */
-	pool_attr.table_type = tbl->type;
-	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
-	pool_attr.flags = MLX5HWS_POOL_FLAG_BUDDY;
-	/* Pool size is similar to action RTC size */
-	pool_attr.alloc_log_sz = ilog2(roundup_pow_of_two(action_ste->max_stes)) +
-				 matcher->attr.table.sz_row_log +
-				 MLX5HWS_MATCHER_ACTION_RTC_UPDATE_MULT;
-	hws_matcher_set_pool_attr(&pool_attr, matcher);
-	action_ste->pool = mlx5hws_pool_create(ctx, &pool_attr);
-	if (!action_ste->pool) {
-		mlx5hws_err(ctx, "Failed to create action ste pool\n");
-		return -EINVAL;
-	}
-
-	/* Allocate action RTC */
-	ret = hws_matcher_create_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY);
-	if (ret) {
-		mlx5hws_err(ctx, "Failed to create action RTC\n");
-		goto free_ste_pool;
-	}
-
-	/* Allocate STC for jumps to STE */
-	stc_attr.action_offset = MLX5HWS_ACTION_OFFSET_HIT;
-	stc_attr.action_type = MLX5_IFC_STC_ACTION_TYPE_JUMP_TO_STE_TABLE;
-	stc_attr.reparse_mode = MLX5_IFC_STC_REPARSE_IGNORE;
-	stc_attr.ste_table.ste_pool = action_ste->pool;
-	stc_attr.ste_table.match_definer_id = ctx->caps->trivial_match_definer;
-
-	ret = mlx5hws_action_alloc_single_stc(ctx, &stc_attr, tbl->type,
-					      &action_ste->stc);
-	if (ret) {
-		mlx5hws_err(ctx, "Failed to create action jump to table STC\n");
-		goto free_rtc;
-	}
+	matcher->num_of_action_stes = max_stes;
 
 	return 0;
-
-free_rtc:
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY);
-free_ste_pool:
-	mlx5hws_pool_destroy(action_ste->pool);
-	return ret;
-}
-
-static void hws_matcher_unbind_at(struct mlx5hws_matcher *matcher)
-{
-	struct mlx5hws_matcher_action_ste *action_ste;
-	struct mlx5hws_table *tbl = matcher->tbl;
-
-	action_ste = &matcher->action_ste;
-
-	if (!action_ste->max_stes ||
-	    matcher->flags & MLX5HWS_MATCHER_FLAGS_COLLISION ||
-	    mlx5hws_matcher_is_in_resize(matcher))
-		return;
-
-	mlx5hws_action_free_single_stc(tbl->ctx, tbl->type, &action_ste->stc);
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_STE_ARRAY);
-	mlx5hws_pool_destroy(action_ste->pool);
 }
 
 static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
@@ -723,10 +526,10 @@ static int hws_matcher_create_and_connect(struct mlx5hws_matcher *matcher)
 	/* Create matcher end flow table anchor */
 	ret = hws_matcher_create_end_ft(matcher);
 	if (ret)
-		goto unbind_at;
+		goto unbind_mt;
 
 	/* Allocate the RTC for the new matcher */
-	ret = hws_matcher_create_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH);
+	ret = hws_matcher_create_rtc(matcher);
 	if (ret)
 		goto destroy_end_ft;
 
@@ -738,11 +541,9 @@ static int hws_matcher_create_and_connect(struct mlx5hws_matcher *matcher)
 	return 0;
 
 destroy_rtc:
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH);
+	hws_matcher_destroy_rtc(matcher);
 destroy_end_ft:
 	hws_matcher_destroy_end_ft(matcher);
-unbind_at:
-	hws_matcher_unbind_at(matcher);
 unbind_mt:
 	hws_matcher_unbind_mt(matcher);
 	return ret;
@@ -750,11 +551,9 @@ static int hws_matcher_create_and_connect(struct mlx5hws_matcher *matcher)
 
 static void hws_matcher_destroy_and_disconnect(struct mlx5hws_matcher *matcher)
 {
-	hws_matcher_resize_uninit(matcher);
 	hws_matcher_disconnect(matcher);
-	hws_matcher_destroy_rtc(matcher, HWS_MATCHER_RTC_TYPE_MATCH);
+	hws_matcher_destroy_rtc(matcher);
 	hws_matcher_destroy_end_ft(matcher);
-	hws_matcher_unbind_at(matcher);
 	hws_matcher_unbind_mt(matcher);
 }
 
@@ -776,8 +575,6 @@ hws_matcher_create_col_matcher(struct mlx5hws_matcher *matcher)
 	if (!col_matcher)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&col_matcher->resize_data);
-
 	col_matcher->tbl = matcher->tbl;
 	col_matcher->mt = matcher->mt;
 	col_matcher->at = matcher->at;
@@ -831,8 +628,6 @@ static int hws_matcher_init(struct mlx5hws_matcher *matcher)
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 	int ret;
 
-	INIT_LIST_HEAD(&matcher->resize_data);
-
 	mutex_lock(&ctx->ctrl_lock);
 
 	/* Allocate matcher resource and connect to the packet pipe */
@@ -889,16 +684,12 @@ static int hws_matcher_grow_at_array(struct mlx5hws_matcher *matcher)
 }
 
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at,
-			      bool *need_rehash)
+			      struct mlx5hws_action_template *at)
 {
 	bool is_jumbo = mlx5hws_matcher_mt_is_jumbo(matcher->mt);
-	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 	u32 required_stes;
 	int ret;
 
-	*need_rehash = false;
-
 	if (unlikely(matcher->num_of_at >= matcher->size_of_at_array)) {
 		ret = hws_matcher_grow_at_array(matcher);
 		if (ret)
@@ -916,11 +707,8 @@ int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
 		return ret;
 
 	required_stes = at->num_of_action_stes - (!is_jumbo || at->only_term);
-	if (matcher->action_ste.max_stes < required_stes) {
-		mlx5hws_dbg(ctx, "Required STEs [%d] exceeds initial action template STE [%d]\n",
-			    required_stes, matcher->action_ste.max_stes);
-		*need_rehash = true;
-	}
+	if (matcher->num_of_action_stes < required_stes)
+		matcher->num_of_action_stes = required_stes;
 
 	matcher->at[matcher->num_of_at] = *at;
 	matcher->num_of_at += 1;
@@ -1102,7 +890,7 @@ static int hws_matcher_resize_precheck(struct mlx5hws_matcher *src_matcher,
 		return -EINVAL;
 	}
 
-	if (src_matcher->action_ste.max_stes > dst_matcher->action_ste.max_stes) {
+	if (src_matcher->num_of_action_stes > dst_matcher->num_of_action_stes) {
 		mlx5hws_err(ctx, "Src/dst matcher max STEs mismatch\n");
 		return -EINVAL;
 	}
@@ -1131,10 +919,6 @@ int mlx5hws_matcher_resize_set_target(struct mlx5hws_matcher *src_matcher,
 
 	src_matcher->resize_dst = dst_matcher;
 
-	ret = hws_matcher_resize_init(src_matcher);
-	if (ret)
-		src_matcher->resize_dst = NULL;
-
 out:
 	mutex_unlock(&src_matcher->tbl->ctx->ctrl_lock);
 	return ret;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index 0450b6175ac9..bad1fa8f77fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -50,23 +50,6 @@ struct mlx5hws_matcher_match_ste {
 	struct mlx5hws_pool *pool;
 };
 
-struct mlx5hws_matcher_action_ste {
-	struct mlx5hws_pool_chunk stc;
-	u32 rtc_0_id;
-	u32 rtc_1_id;
-	struct mlx5hws_pool *pool;
-	u8 max_stes;
-};
-
-struct mlx5hws_matcher_resize_data {
-	struct mlx5hws_pool_chunk stc;
-	u32 rtc_0_id;
-	u32 rtc_1_id;
-	struct mlx5hws_pool *pool;
-	u8 max_stes;
-	struct list_head list_node;
-};
-
 struct mlx5hws_matcher {
 	struct mlx5hws_table *tbl;
 	struct mlx5hws_matcher_attr attr;
@@ -75,15 +58,14 @@ struct mlx5hws_matcher {
 	u8 num_of_at;
 	u8 size_of_at_array;
 	u8 num_of_mt;
+	u8 num_of_action_stes;
 	/* enum mlx5hws_matcher_flags */
 	u8 flags;
 	u32 end_ft_id;
 	struct mlx5hws_matcher *col_matcher;
 	struct mlx5hws_matcher *resize_dst;
 	struct mlx5hws_matcher_match_ste match_ste;
-	struct mlx5hws_matcher_action_ste action_ste;
 	struct list_head list_node;
-	struct list_head resize_data;
 };
 
 static inline bool
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
index 8ed8a715a2eb..5121951f2778 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/mlx5hws.h
@@ -399,14 +399,11 @@ int mlx5hws_matcher_destroy(struct mlx5hws_matcher *matcher);
  *
  * @matcher: Matcher to attach the action template to.
  * @at: Action template to be attached to the matcher.
- * @need_rehash: Output parameter that tells callers if the matcher needs to be
- * rehashed.
  *
  * Return: Zero on success, non-zero otherwise.
  */
 int mlx5hws_matcher_attach_at(struct mlx5hws_matcher *matcher,
-			      struct mlx5hws_action_template *at,
-			      bool *need_rehash);
+			      struct mlx5hws_action_template *at);
 
 /**
  * mlx5hws_matcher_resize_set_target - Link two matchers and enable moving rules.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 5b758467ed03..9e6f35d68445 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -203,7 +203,7 @@ static int mlx5hws_rule_alloc_action_ste(struct mlx5hws_rule *rule,
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
 
 	rule->action_ste.ste.order =
-		ilog2(roundup_pow_of_two(matcher->action_ste.max_stes));
+		ilog2(roundup_pow_of_two(matcher->num_of_action_stes));
 	return mlx5hws_action_ste_chunk_alloc(&ctx->action_ste_pool[queue_id],
 					      skip_rx, skip_tx,
 					      &rule->action_ste);
-- 
2.31.1


