Return-Path: <linux-rdma+bounces-13480-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47B3B84365
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 12:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967B7189018C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 10:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D48F2F7462;
	Thu, 18 Sep 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S7vLGtfw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEB2F361C;
	Thu, 18 Sep 2025 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758192292; cv=fail; b=eTzmvZ5ocYxePvrN9LpJbdIq8kBQVGEZJcfwZSBaGtx5E3qCub+jCC/ON7pI8JMIRysXfxgHkFJDPM62n3tTQv3FxVsheGedpK9pT4blwy/Kty3uXX1Nwu2h89ZVVVLCcb4UQmtV5+TNF2S8ckxnTOnbhSzbuu7fgQuRzSZBOF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758192292; c=relaxed/simple;
	bh=WiDvdLcwyBaI4TDlJj/Yh/c3zOMXjuasmG7vD8GES5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ncwy6Uf+qzJePXxdaDrOcB2akJ3UmIj9Tp239AoDf46YzHoaEXbqpWbqnDOZinh0JL9NByO+W1YMbL0VyoxoKQlgoSQNOpcETSUFyJ/zJBqDv9TYJqYoKVznsPPhJfkvHszGEYhB0BAHsJ0x1XH7uEfFnA/2gGbMxuwigWlozpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S7vLGtfw; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUz7vmzcrsGbXtfAVJNtPDR4rPx7kUbuD2IzKN8+YkkdePe9DER8sMDMi3O4u1soYG0EhyzFjQyua2AQtv4TinVWj3H3zGDW9p8bfWTsMHZLZOjdXKlpEUd/aIugJyWwJ8a0DHmAYv8W6rRvt+CtiPXTIdCoNi5iUfvX19Y8Mi9NnKSimNvpMKmsYgG66G/zY/FvMsM8EvcEM2HpGvh7ZbccMcNYIHz1Yr2vwfDXzFyQPzkPEHiRW4IMFGkgu3lKgjtvM/Qs8xQLw8y6Bbe5bXV+4Yhse8f5p7jdEaKeyb4/Vavj1GXhcvnvHi2tN9S6v3C2bQPHqfH2FlGpVWzmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EJ+TYw04hJGsyWBdww3UKxti0iD02NoopyzaCWsbCs=;
 b=Fci9IzbONhaQL/8iFABx3D4/BxnFPs7I8BGit28ksdq+lJi4z8PJGOtpIpoUsrMbcyRuu2vt0yZGr66+DsEkbowTXq9X/8k8DD1Nj8gqiwxhDsRJVfX/Rx2UMWCE5vY/mVSPe/iquqPu9I32nlGVV3SwbufZT/U9wzOlBgBKvLqX+BKISMiRPAP9O/hXzIaLVXtkOIxrQKMYrNaGeLBQlsrMaM4MYlJzkkLG5F/2ieCWfBL23Z7E1jFAHggabmrKeAIbFp0f60sTyXte9A2JLJoTvvtviw42TyiaES3NxndxJLwBZQIHvjQkN+rL07epyxEdEyBkZl9EJ95RClCuzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EJ+TYw04hJGsyWBdww3UKxti0iD02NoopyzaCWsbCs=;
 b=S7vLGtfwr9kZyXUVZLi0cHfnBLhFYUR/DY2Y81jgSUkCaamsQeq/06mjABGZRik71fVK1wUJJro2FCTSlf8zFCrf4mREYbU0hEA8cMjXsjSpdJVC9yeu+wFGZ+dEZ1e/hW7AZnjdxXOHmv7BXFe3NTIDELyJmWsazBOUQz6gWGUImBjASpFkXumLfblCidfb4snRPZs3dQOJmKAHaGrudDJeoBbjMSEXDU7pjk0WlM9SUvJr9S6v2EFV2LyPWpEAgc5FBxOG1Gl29ZDtmCkWUjQHbGs2b/GufpVDyK3ejd9YKUHIBqbJKroB5NeDS86+s/ksDUQqU+YO3G0VRaAMfg==
Received: from BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::15)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 10:44:40 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::88) by BLAP220CA0010.outlook.office365.com
 (2603:10b6:208:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 10:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 10:44:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:26 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 03:44:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 03:44:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Julia
 Lawall" <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
	Richard Cochran <richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, <cocci@inria.fr>,
	"Gal Pressman" <gal@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5: Use %pe format specifier for error pointers
Date: Thu, 18 Sep 2025 13:43:47 +0300
Message-ID: <1758192227-701925-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
References: <1758192227-701925-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 45717ee0-e388-4570-0e89-08ddf6a05eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gswfTEoa4/M8iAVJ04N56k8gJop9HvHCgVfGlULi+wxbWeBvozn509Rdt/hp?=
 =?us-ascii?Q?ycFGZujISl2DMuzmjg4dBgkp6izHk8c/w7ukbztGOYXXlmdo8ljdLL56Y7jB?=
 =?us-ascii?Q?mYXM8RjY1gzjZzQCBsToT5Ebt4QEKI8qbUTTsR+VSDImvVO797r3UUl3Na7A?=
 =?us-ascii?Q?jresohI4b8W5Vs6SkhT+EcVGSulFeltIu+FgXbgpnb+3reiHCcnF31KqCEKs?=
 =?us-ascii?Q?JdP4FMb55EyV/PaXC1UWil/uY3TRXAz5wMnLCmNfdzFtB1ZyyIN2i9el5RsK?=
 =?us-ascii?Q?wiP5+V/WdBplhHDlenO1Et2f1Bd4fA/xEps2G9UXNSjhciWpl0gUOCfmjwIG?=
 =?us-ascii?Q?BNgycgHUKY74xkEiLR7AeetGHZtY1CwRp3VuudeP3oKRKIGbCJ+x1eIfY5L2?=
 =?us-ascii?Q?/hz3Gai+i2bs60wfkPKdr/+HGkxYgihF0aI+v7ATNljO2P0SIabEK/qtfIEh?=
 =?us-ascii?Q?1rggdrE8nmZZ1YfRy0zDpoW+vqOrrLRGdt2+nKMatzfwSupSHPH4efdKHXYG?=
 =?us-ascii?Q?cBJSfI+cYYFrY/FPR4fqAG6Gxh7Ofm9OLfQIIr/1U4mh9CrlYGhePvqkQDPF?=
 =?us-ascii?Q?6EpkpLUKEDrXilg5EyyEMHiThV9LwOhL2X1kvOUrSUYlsu9dmiAzjaTUZHCY?=
 =?us-ascii?Q?TYSb86UUrKwgNxSQq23gSZfNR5x9RZWL7yvIf5NnndCdBQcYaL9cUo+Zitz+?=
 =?us-ascii?Q?vHawb94QGFmtNZHet9F6vtD5FuLz4DCHnmhZs5j2Vxi+QbT41FQ2z1ZH0/Ek?=
 =?us-ascii?Q?/3rgTtEg0DbzTBHh/LFE/wMMptZcMtiLSSu/60oIYLWbBZF9skV/OPVtQldg?=
 =?us-ascii?Q?D7L49kEIiQGTnSBjJ4N6BgyHUBApReJi8tcT9sOr+xcCFk7oW7j0addOhFxE?=
 =?us-ascii?Q?zgIVadPM8s3ZgPYyexEDZLmAMy+XPyjC36UZ4Y8ChQWVXieBRtKddLv6+Kgw?=
 =?us-ascii?Q?fuf47/Tk48/vRmtRg6b/ot00/8+be5kh0rX93tSJHp4W4HfnWhBxpqxPyr9a?=
 =?us-ascii?Q?2/MQZciZX8Xzl93VSd2MsoP5y+vHW7DLN8ZO75HkDJAjW274yOsVQY+lrzEy?=
 =?us-ascii?Q?vQOZpkuD9nkOr+YIf5DTA2NITqmNshAUlOAU1OZfQmyjsSU+BQNvQ6xDGTDw?=
 =?us-ascii?Q?Pt90vkeqRHM+XX2zzaVj/+OuH0oJQDRj7xpoQfI9r0/uceNy+6topEE3Tr8q?=
 =?us-ascii?Q?vcIvpkuY01NGde4KRsNM9D5LehaCqAHp0Z/5HzSZS6mriREJrA9yHbWmLEqD?=
 =?us-ascii?Q?e4f4zPIuxHhux/RWSU25zaFl/dSSKasv8i1r12Q+iGkimhn6IiYnhi/qRmQp?=
 =?us-ascii?Q?JvPNzEwahTwxL8o8Zlm7WgtFdt8NpAG6FJNGdpgZOhh0lToR888FqhHBDMR5?=
 =?us-ascii?Q?P+1v11Om84BZZXaTjfeY3X1CepzQMwnqWZ5+ujkb579sAGEt79PaG7d6NSdW?=
 =?us-ascii?Q?ANVct/24c8vlyNXIV5MVYpQnnjr+QQIPKENDh8EMIBfG9et/aJuAV0vUAYLW?=
 =?us-ascii?Q?zsE4blZLcaFSvqUqMW1WRYSkHo9bTSa+RtY5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 10:44:40.2236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45717ee0-e388-4570-0e89-08ddf6a05eec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

From: Gal Pressman <gal@nvidia.com>

Using the coccinelle test introduced in previous commit
(scripts/coccinelle/misc/ptr_err_to_pe.cocci), convert error logging
throughout the mlx5 driver to use the %pe format specifier instead of
PTR_ERR() with integer format specifiers.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Alexei Lazar <alazar@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |  4 +-
 .../mellanox/mlx5/core/en/hv_vhca_stats.c     |  4 +-
 .../mellanox/mlx5/core/en/rep/bridge.c        |  7 +--
 .../mellanox/mlx5/core/en/reporter_rx.c       |  4 +-
 .../mellanox/mlx5/core/en/reporter_tx.c       |  4 +-
 .../mellanox/mlx5/core/en/tc/ct_fs_hmfs.c     |  4 +-
 .../mellanox/mlx5/core/en/tc/ct_fs_smfs.c     |  4 +-
 .../mellanox/mlx5/core/en/tc/int_port.c       |  8 ++--
 .../mellanox/mlx5/core/en/tc_tun_encap.c      |  8 ++--
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |  2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  4 +-
 .../ethernet/mellanox/mlx5/core/en_common.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  4 +-
 .../mellanox/mlx5/core/esw/acl/egress_lgcy.c  |  4 +-
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 47 ++++++++++---------
 .../mellanox/mlx5/core/esw/vporttbl.c         |  4 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  4 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 16 ++++---
 .../net/ethernet/mellanox/mlx5/core/health.c  |  8 ++--
 .../mellanox/mlx5/core/irq_affinity.c         |  4 +-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   |  4 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  4 +-
 22 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index 73f5b62b8c7f..a17f82321c25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -138,8 +138,8 @@ void mlx5_reporter_vnic_create(struct mlx5_core_dev *dev)
 					       dev);
 	if (IS_ERR(health->vnic_reporter))
 		mlx5_core_warn(dev,
-			       "Failed to create vnic reporter, err = %ld\n",
-			       PTR_ERR(health->vnic_reporter));
+			       "Failed to create vnic reporter, err = %pe\n",
+			       health->vnic_reporter);
 }
 
 void mlx5_reporter_vnic_destroy(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
index b4f3bd7d346e..195863b2c013 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/hv_vhca_stats.c
@@ -138,8 +138,8 @@ void mlx5e_hv_vhca_stats_create(struct mlx5e_priv *priv)
 	if (IS_ERR_OR_NULL(agent)) {
 		if (IS_ERR(agent))
 			netdev_warn(priv->netdev,
-				    "Failed to create hv vhca stats agent, err = %ld\n",
-				    PTR_ERR(agent));
+				    "Failed to create hv vhca stats agent, err = %pe\n",
+				    agent);
 
 		kvfree(priv->stats_agent.buf);
 		return;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 0f5d7ea8956f..9d1c677814e0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -488,8 +488,8 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
 							       fdb_info,
 							       br_offloads);
 		if (IS_ERR(work)) {
-			WARN_ONCE(1, "Failed to init switchdev work, err=%ld",
-				  PTR_ERR(work));
+			WARN_ONCE(1, "Failed to init switchdev work, err=%pe",
+				  work);
 			return notifier_from_errno(PTR_ERR(work));
 		}
 
@@ -527,7 +527,8 @@ void mlx5e_rep_bridge_init(struct mlx5e_priv *priv)
 	br_offloads = mlx5_esw_bridge_init(esw);
 	rtnl_unlock();
 	if (IS_ERR(br_offloads)) {
-		esw_warn(mdev, "Failed to init esw bridge (err=%ld)\n", PTR_ERR(br_offloads));
+		esw_warn(mdev, "Failed to init esw bridge (err=%pe)\n",
+			 br_offloads);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index eb1cace5910c..b1415992ffa2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -672,8 +672,8 @@ void mlx5e_reporter_rx_create(struct mlx5e_priv *priv)
 						       &mlx5_rx_reporter_ops,
 						       priv);
 	if (IS_ERR(reporter)) {
-		netdev_warn(priv->netdev, "Failed to create rx reporter, err = %ld\n",
-			    PTR_ERR(reporter));
+		netdev_warn(priv->netdev, "Failed to create rx reporter, err = %pe\n",
+			    reporter);
 		return;
 	}
 	priv->rx_reporter = reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 5a4fe8403a21..9e2cf191ed30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -561,8 +561,8 @@ void mlx5e_reporter_tx_create(struct mlx5e_priv *priv)
 						       priv);
 	if (IS_ERR(reporter)) {
 		netdev_warn(priv->netdev,
-			    "Failed to create tx reporter, err = %ld\n",
-			    PTR_ERR(reporter));
+			    "Failed to create tx reporter, err = %pe\n",
+			    reporter);
 		return;
 	}
 	priv->tx_reporter = reporter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
index 01d522b02947..d3db6146fcad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_hmfs.c
@@ -136,8 +136,8 @@ mlx5_ct_fs_hmfs_matcher_get(struct mlx5_ct_fs *fs, struct mlx5_flow_spec *spec,
 	hws_bwc_matcher = mlx5_ct_fs_hmfs_matcher_create(fs, tbl, spec, ipv4, tcp, gre);
 	if (IS_ERR(hws_bwc_matcher)) {
 		netdev_warn(fs->netdev,
-			    "ct_fs_hmfs: failed to create bwc matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %ld\n",
-			    nat, ipv4, tcp, gre, PTR_ERR(hws_bwc_matcher));
+			    "ct_fs_hmfs: failed to create bwc matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %pe\n",
+			    nat, ipv4, tcp, gre, hws_bwc_matcher);
 
 		hmfs_matcher = ERR_CAST(hws_bwc_matcher);
 		goto out_unlock;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
index 0c97c5899904..4d6924b644c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/ct_fs_smfs.c
@@ -148,8 +148,8 @@ mlx5_ct_fs_smfs_matcher_get(struct mlx5_ct_fs *fs, bool nat, bool ipv4, bool tcp
 	dr_matcher = mlx5_ct_fs_smfs_matcher_create(fs, tbl, ipv4, tcp, gre, prio);
 	if (IS_ERR(dr_matcher)) {
 		netdev_warn(fs->netdev,
-			    "ct_fs_smfs: failed to create matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %ld\n",
-			    nat, ipv4, tcp, gre, PTR_ERR(dr_matcher));
+			    "ct_fs_smfs: failed to create matcher (nat %d, ipv4 %d, tcp %d, gre %d), err: %pe\n",
+			    nat, ipv4, tcp, gre, dr_matcher);
 
 		smfs_matcher = ERR_CAST(dr_matcher);
 		goto out_unlock;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
index 8afcec0c5d3c..896f718483c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/int_port.c
@@ -93,8 +93,8 @@ mlx5e_int_port_create_rx_rule(struct mlx5_eswitch *esw,
 	flow_rule = mlx5_add_flow_rules(esw->offloads.ft_offloads, spec,
 					&flow_act, dest, 1);
 	if (IS_ERR(flow_rule))
-		mlx5_core_warn(esw->dev, "ft offloads: Failed to add internal vport rx rule err %ld\n",
-			       PTR_ERR(flow_rule));
+		mlx5_core_warn(esw->dev, "ft offloads: Failed to add internal vport rx rule err %pe\n",
+			       flow_rule);
 
 	kvfree(spec);
 
@@ -322,8 +322,8 @@ mlx5e_tc_int_port_init(struct mlx5e_priv *priv)
 								sizeof(u32) * 2,
 								(1 << ESW_VPORT_BITS) - 1, true);
 	if (IS_ERR(int_port_priv->metadata_mapping)) {
-		mlx5_core_warn(priv->mdev, "Can't allocate metadata mapping of int port offload, err=%ld\n",
-			       PTR_ERR(int_port_priv->metadata_mapping));
+		mlx5_core_warn(priv->mdev, "Can't allocate metadata mapping of int port offload, err=%pe\n",
+			       int_port_priv->metadata_mapping);
 		goto err_mapping;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
index a0fc76a1bc08..0735d10f2bac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_encap.c
@@ -172,8 +172,8 @@ void mlx5e_tc_encap_flows_add(struct mlx5e_priv *priv,
 						     &reformat_params,
 						     MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(e->pkt_reformat)) {
-		mlx5_core_warn(priv->mdev, "Failed to offload cached encapsulation header, %lu\n",
-			       PTR_ERR(e->pkt_reformat));
+		mlx5_core_warn(priv->mdev, "Failed to offload cached encapsulation header, %pe\n",
+			       e->pkt_reformat);
 		return;
 	}
 	e->flags |= MLX5_ENCAP_ENTRY_VALID;
@@ -1845,8 +1845,8 @@ static int mlx5e_tc_tun_fib_event(struct notifier_block *nb, unsigned long event
 			queue_work(priv->wq, &fib_work->work);
 		} else if (IS_ERR(fib_work)) {
 			NL_SET_ERR_MSG_MOD(info->extack, "Failed to init fib work");
-			mlx5_core_warn(priv->mdev, "Failed to init fib work, %ld\n",
-				       PTR_ERR(fib_work));
+			mlx5_core_warn(priv->mdev, "Failed to init fib work, %pe\n",
+				       fib_work);
 		}
 
 		break;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
index 4f83e3172767..1febdc5b81f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
@@ -138,7 +138,7 @@ struct mlx5_flow_handle *mlx5e_accel_fs_add_sk(struct mlx5e_flow_steering *fs,
 	flow = mlx5_add_flow_rules(ft->t, spec, &flow_act, &dest, 1);
 
 	if (IS_ERR(flow))
-		fs_err(fs, "mlx5_add_flow_rules() failed, flow is %ld\n", PTR_ERR(flow));
+		fs_err(fs, "mlx5_add_flow_rules() failed, flow is %pe\n", flow);
 
 out:
 	kvfree(spec);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 98b6a3a623f9..cc067a0a3151 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1704,8 +1704,8 @@ static int setup_modify_header(struct mlx5e_ipsec *ipsec, int type, u32 val, u8
 
 	modify_hdr = mlx5_modify_header_alloc(mdev, ns_type, num_of_actions, action);
 	if (IS_ERR(modify_hdr)) {
-		mlx5_core_err(mdev, "Failed to allocate modify_header %ld\n",
-			      PTR_ERR(modify_hdr));
+		mlx5_core_err(mdev, "Failed to allocate modify_header %pe\n",
+			      modify_hdr);
 		return PTR_ERR(modify_hdr);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 96b744ceaf13..30424ccad584 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -210,8 +210,8 @@ int mlx5e_create_mdev_resources(struct mlx5_core_dev *mdev, bool create_tises)
 
 	mdev->mlx5e_res.dek_priv = mlx5_crypto_dek_init(mdev);
 	if (IS_ERR(mdev->mlx5e_res.dek_priv)) {
-		mlx5_core_err(mdev, "crypto dek init failed, %ld\n",
-			      PTR_ERR(mdev->mlx5e_res.dek_priv));
+		mlx5_core_err(mdev, "crypto dek init failed, %pe\n",
+			      mdev->mlx5e_res.dek_priv);
 		mdev->mlx5e_res.dek_priv = NULL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index b231e7855bca..d91db3c8c1b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1450,8 +1450,8 @@ static void mlx5e_rep_vnic_reporter_create(struct mlx5e_priv *priv,
 						    rpriv);
 	if (IS_ERR(reporter)) {
 		mlx5_core_err(priv->mdev,
-			      "Failed to create representor vnic reporter, err = %ld\n",
-			      PTR_ERR(reporter));
+			      "Failed to create representor vnic reporter, err = %pe\n",
+			      reporter);
 		return;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
index 7dd1dc3f77c7..c9a1654d83a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/acl/egress_lgcy.c
@@ -87,8 +87,8 @@ int esw_acl_egress_lgcy_setup(struct mlx5_eswitch *esw,
 		drop_counter = mlx5_fc_create(esw->dev, false);
 		if (IS_ERR(drop_counter)) {
 			esw_warn(esw->dev,
-				 "vport[%d] configure egress drop rule counter err(%ld)\n",
-				 vport->vport, PTR_ERR(drop_counter));
+				 "vport[%d] configure egress drop rule counter err(%pe)\n",
+				 vport->vport, drop_counter);
 			drop_counter = NULL;
 		}
 		vport->egress.legacy.drop_counter = drop_counter;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index 76e35c827da0..60e10047770f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -81,7 +81,8 @@ mlx5_esw_bridge_table_create(int max_fte, u32 level, struct mlx5_eswitch *esw)
 	ft_attr.prio = FDB_BR_OFFLOAD;
 	fdb = mlx5_create_flow_table(ns, &ft_attr);
 	if (IS_ERR(fdb))
-		esw_warn(dev, "Failed to create bridge FDB Table (err=%ld)\n", PTR_ERR(fdb));
+		esw_warn(dev, "Failed to create bridge FDB Table (err=%pe)\n",
+			 fdb);
 
 	return fdb;
 }
@@ -121,8 +122,8 @@ mlx5_esw_bridge_ingress_vlan_proto_fg_create(unsigned int from, unsigned int to,
 	kvfree(in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create VLAN(proto=%x) flow group for bridge ingress table (err=%ld)\n",
-			 vlan_proto, PTR_ERR(fg));
+			 "Failed to create VLAN(proto=%x) flow group for bridge ingress table (err=%pe)\n",
+			 vlan_proto, fg);
 
 	return fg;
 }
@@ -180,8 +181,8 @@ mlx5_esw_bridge_ingress_vlan_proto_filter_fg_create(unsigned int from, unsigned
 	fg = mlx5_create_flow_group(ingress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create bridge ingress table VLAN filter flow group (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create bridge ingress table VLAN filter flow group (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -237,8 +238,8 @@ mlx5_esw_bridge_ingress_mac_fg_create(struct mlx5_eswitch *esw, struct mlx5_flow
 	fg = mlx5_create_flow_group(ingress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create MAC flow group for bridge ingress table (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create MAC flow group for bridge ingress table (err=%pe)\n",
+			 fg);
 
 	kvfree(in);
 	return fg;
@@ -274,8 +275,8 @@ mlx5_esw_bridge_egress_vlan_proto_fg_create(unsigned int from, unsigned int to,
 	fg = mlx5_create_flow_group(egress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create VLAN flow group for bridge egress table (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create VLAN flow group for bridge egress table (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -324,8 +325,8 @@ mlx5_esw_bridge_egress_mac_fg_create(struct mlx5_eswitch *esw, struct mlx5_flow_
 	fg = mlx5_create_flow_group(egress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create bridge egress table MAC flow group (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create bridge egress table MAC flow group (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -354,8 +355,8 @@ mlx5_esw_bridge_egress_miss_fg_create(struct mlx5_eswitch *esw, struct mlx5_flow
 	fg = mlx5_create_flow_group(egress_ft, in);
 	if (IS_ERR(fg))
 		esw_warn(esw->dev,
-			 "Failed to create bridge egress table miss flow group (err=%ld)\n",
-			 PTR_ERR(fg));
+			 "Failed to create bridge egress table miss flow group (err=%pe)\n",
+			 fg);
 	kvfree(in);
 	return fg;
 }
@@ -501,8 +502,8 @@ mlx5_esw_bridge_egress_table_init(struct mlx5_esw_bridge_offloads *br_offloads,
 	if (mlx5_esw_bridge_pkt_reformat_vlan_pop_supported(esw)) {
 		miss_fg = mlx5_esw_bridge_egress_miss_fg_create(esw, egress_ft);
 		if (IS_ERR(miss_fg)) {
-			esw_warn(esw->dev, "Failed to create miss flow group (err=%ld)\n",
-				 PTR_ERR(miss_fg));
+			esw_warn(esw->dev, "Failed to create miss flow group (err=%pe)\n",
+				 miss_fg);
 			miss_fg = NULL;
 			goto skip_miss_flow;
 		}
@@ -510,8 +511,8 @@ mlx5_esw_bridge_egress_table_init(struct mlx5_esw_bridge_offloads *br_offloads,
 		miss_pkt_reformat = mlx5_esw_bridge_pkt_reformat_vlan_pop_create(esw);
 		if (IS_ERR(miss_pkt_reformat)) {
 			esw_warn(esw->dev,
-				 "Failed to alloc packet reformat REMOVE_HEADER (err=%ld)\n",
-				 PTR_ERR(miss_pkt_reformat));
+				 "Failed to alloc packet reformat REMOVE_HEADER (err=%pe)\n",
+				 miss_pkt_reformat);
 			miss_pkt_reformat = NULL;
 			mlx5_destroy_flow_group(miss_fg);
 			miss_fg = NULL;
@@ -522,8 +523,8 @@ mlx5_esw_bridge_egress_table_init(struct mlx5_esw_bridge_offloads *br_offloads,
 								      br_offloads->skip_ft,
 								      miss_pkt_reformat);
 		if (IS_ERR(miss_handle)) {
-			esw_warn(esw->dev, "Failed to create miss flow (err=%ld)\n",
-				 PTR_ERR(miss_handle));
+			esw_warn(esw->dev, "Failed to create miss flow (err=%pe)\n",
+				 miss_handle);
 			miss_handle = NULL;
 			mlx5_packet_reformat_dealloc(esw->dev, miss_pkt_reformat);
 			miss_pkt_reformat = NULL;
@@ -1048,8 +1049,8 @@ mlx5_esw_bridge_vlan_push_create(u16 vlan_proto, struct mlx5_esw_bridge_vlan *vl
 						  &reformat_params,
 						  MLX5_FLOW_NAMESPACE_FDB);
 	if (IS_ERR(pkt_reformat)) {
-		esw_warn(esw->dev, "Failed to alloc packet reformat INSERT_HEADER (err=%ld)\n",
-			 PTR_ERR(pkt_reformat));
+		esw_warn(esw->dev, "Failed to alloc packet reformat INSERT_HEADER (err=%pe)\n",
+			 pkt_reformat);
 		return PTR_ERR(pkt_reformat);
 	}
 
@@ -1076,8 +1077,8 @@ mlx5_esw_bridge_vlan_pop_create(struct mlx5_esw_bridge_vlan *vlan, struct mlx5_e
 
 	pkt_reformat = mlx5_esw_bridge_pkt_reformat_vlan_pop_create(esw);
 	if (IS_ERR(pkt_reformat)) {
-		esw_warn(esw->dev, "Failed to alloc packet reformat REMOVE_HEADER (err=%ld)\n",
-			 PTR_ERR(pkt_reformat));
+		esw_warn(esw->dev, "Failed to alloc packet reformat REMOVE_HEADER (err=%pe)\n",
+			 pkt_reformat);
 		return PTR_ERR(pkt_reformat);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
index 749c3957a128..407062096a82 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
@@ -45,8 +45,8 @@ esw_vport_tbl_create(struct mlx5_eswitch *esw, struct mlx5_flow_namespace *ns,
 	ft_attr.flags = vport_ns->flags;
 	fdb = mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 	if (IS_ERR(fdb)) {
-		esw_warn(esw->dev, "Failed to create per vport FDB Table err %ld\n",
-			 PTR_ERR(fdb));
+		esw_warn(esw->dev, "Failed to create per vport FDB Table err %pe\n",
+			 fdb);
 	}
 
 	return fdb;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 10eca910a2db..e2ffb87b94cb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -257,8 +257,8 @@ __esw_fdb_set_vport_rule(struct mlx5_eswitch *esw, u16 vport, bool rx_rule,
 				    &flow_act, &dest, 1);
 	if (IS_ERR(flow_rule)) {
 		esw_warn(esw->dev,
-			 "FDB: Failed to add flow rule: dmac_v(%pM) dmac_c(%pM) -> vport(%d), err(%ld)\n",
-			 dmac_v, dmac_c, vport, PTR_ERR(flow_rule));
+			 "FDB: Failed to add flow rule: dmac_v(%pM) dmac_c(%pM) -> vport(%d), err(%pe)\n",
+			 dmac_v, dmac_c, vport, flow_rule);
 		flow_rule = NULL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bc9838dc5bf8..b8ec55929ab1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1016,8 +1016,8 @@ mlx5_eswitch_add_send_to_vport_rule(struct mlx5_eswitch *on_esw,
 	flow_rule = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(on_esw),
 					spec, &flow_act, &dest, 1);
 	if (IS_ERR(flow_rule))
-		esw_warn(on_esw->dev, "FDB: Failed to add send to vport rule err %ld\n",
-			 PTR_ERR(flow_rule));
+		esw_warn(on_esw->dev, "FDB: Failed to add send to vport rule err %pe\n",
+			 flow_rule);
 out:
 	kvfree(spec);
 	return flow_rule;
@@ -1065,8 +1065,8 @@ mlx5_eswitch_add_send_to_vport_meta_rule(struct mlx5_eswitch *esw, u16 vport_num
 	flow_rule = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
 					spec, &flow_act, &dest, 1);
 	if (IS_ERR(flow_rule))
-		esw_warn(esw->dev, "FDB: Failed to add send to vport meta rule vport %d, err %ld\n",
-			 vport_num, PTR_ERR(flow_rule));
+		esw_warn(esw->dev, "FDB: Failed to add send to vport meta rule vport %d, err %pe\n",
+			 vport_num, flow_rule);
 
 	kvfree(spec);
 	return flow_rule;
@@ -2159,7 +2159,9 @@ mlx5_eswitch_create_vport_rx_rule(struct mlx5_eswitch *esw, u16 vport,
 	flow_rule = mlx5_add_flow_rules(esw->offloads.ft_offloads, spec,
 					&flow_act, dest, 1);
 	if (IS_ERR(flow_rule)) {
-		esw_warn(esw->dev, "fs offloads: Failed to add vport rx rule err %ld\n", PTR_ERR(flow_rule));
+		esw_warn(esw->dev,
+			 "fs offloads: Failed to add vport rx rule err %pe\n",
+			 flow_rule);
 		goto out;
 	}
 
@@ -2178,8 +2180,8 @@ static int esw_create_vport_rx_drop_rule(struct mlx5_eswitch *esw)
 					&flow_act, NULL, 0);
 	if (IS_ERR(flow_rule)) {
 		esw_warn(esw->dev,
-			 "fs offloads: Failed to add vport rx drop rule err %ld\n",
-			 PTR_ERR(flow_rule));
+			 "fs offloads: Failed to add vport rx drop rule err %pe\n",
+			 flow_rule);
 		return PTR_ERR(flow_rule);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index b63c5a221eb9..aeeb136f5ebc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -718,15 +718,15 @@ void mlx5_fw_reporters_create(struct mlx5_core_dev *dev)
 
 	health->fw_reporter = devl_health_reporter_create(devlink, fw_ops, dev);
 	if (IS_ERR(health->fw_reporter))
-		mlx5_core_warn(dev, "Failed to create fw reporter, err = %ld\n",
-			       PTR_ERR(health->fw_reporter));
+		mlx5_core_warn(dev, "Failed to create fw reporter, err = %pe\n",
+			       health->fw_reporter);
 
 	health->fw_fatal_reporter = devl_health_reporter_create(devlink,
 								fw_fatal_ops,
 								dev);
 	if (IS_ERR(health->fw_fatal_reporter))
-		mlx5_core_warn(dev, "Failed to create fw fatal reporter, err = %ld\n",
-			       PTR_ERR(health->fw_fatal_reporter));
+		mlx5_core_warn(dev, "Failed to create fw fatal reporter, err = %pe\n",
+			       health->fw_fatal_reporter);
 }
 
 static void mlx5_fw_reporters_destroy(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 82d3c2568244..14d339eceb92 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -150,8 +150,8 @@ mlx5_irq_affinity_request(struct mlx5_core_dev *dev, struct mlx5_irq_pool *pool,
 	if (IS_ERR(new_irq)) {
 		if (!least_loaded_irq) {
 			/* We failed to create an IRQ and we didn't find an IRQ */
-			mlx5_core_err(pool->dev, "Didn't find a matching IRQ. err = %ld\n",
-				      PTR_ERR(new_irq));
+			mlx5_core_err(pool->dev, "Didn't find a matching IRQ. err = %pe\n",
+				      new_irq);
 			mutex_unlock(&pool->lock);
 			return new_irq;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 8f2ad45bec9f..d0ba83d77cd1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1365,9 +1365,9 @@ static void mlx5_init_clock_dev(struct mlx5_core_dev *mdev)
 	clock->ptp = ptp_clock_register(&clock->ptp_info,
 					clock->shared ? NULL : &mdev->pdev->dev);
 	if (IS_ERR(clock->ptp)) {
-		mlx5_core_warn(mdev, "%sptp_clock_register failed %ld\n",
+		mlx5_core_warn(mdev, "%sptp_clock_register failed %pe\n",
 			       clock->shared ? "shared clock " : "",
-			       PTR_ERR(clock->ptp));
+			       clock->ptp);
 		clock->ptp = NULL;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 6b6d6b05b893..df93625c9dfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -979,8 +979,8 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 
 	dev->priv.devc = mlx5_devcom_register_device(dev);
 	if (IS_ERR(dev->priv.devc))
-		mlx5_core_warn(dev, "failed to register devcom device %ld\n",
-			       PTR_ERR(dev->priv.devc));
+		mlx5_core_warn(dev, "failed to register devcom device %pe\n",
+			       dev->priv.devc);
 
 	err = mlx5_query_board_id(dev);
 	if (err) {
-- 
2.31.1


