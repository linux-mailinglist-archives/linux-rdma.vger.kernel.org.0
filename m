Return-Path: <linux-rdma+bounces-8133-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75645A45DC2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6DAC1898D47
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF4221F3B;
	Wed, 26 Feb 2025 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e4b+4n/g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16516221DBD;
	Wed, 26 Feb 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570548; cv=fail; b=t81YHF3FHw0xs4gTWgvaLdF7IDP9SqYT1uQ5EP90Z9h2UlUKvmtF6VqPXrde7N+fcPjNlsLhAs07uzDdbPqfctSdMMHNMxYEJCcTvOeE6WAotLEa5TGzpCuz/eUvZr02swoxE0mCO36DHuLKjKOXP33C9BXHx46Py0NqAVdM0W8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570548; c=relaxed/simple;
	bh=/g6jTL2adeVjGCMS4kIFiFEnN6YDGZUYlEUt3MhdFY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oi3wi8kg2j87tai6Un9VcB5Xn2de16+9VnKpnCfi+9BjBCAVKjTAoIdMmKQuDefB8JgDIy740ckgFfyUUzoB+QKIwDf5Vgp6ZUPYl6yzeKrAY3Qai1Z6cvhRANTgzVQ2pPxowvJ2jR5bMuhChWdXYTZXTshrBDDQL27MnlAzh6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e4b+4n/g; arc=fail smtp.client-ip=40.107.92.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0YEeI3NSGQAqFZxmM6U9s/kiBnJnagumJ1INNOuLSA86y/fsQ/VgwyD+71bUKUPlSBYlLL4IDooTwva4l0fTEoTuM2vmJ2XmHlpGVG1iTNl/1q7gs7xOuR/lf6tzHBOgVH7o2WYINkM0GtdhNag316QnXagRab5bLmJUnQx3dP5xRk7Z9j70TH7+Y0+XQHKDDouNyCi3Khe1RGnSzqnKoUsSu/cDpcuxAVKJCWC0/XPVpNF172ueWBfIcUg2fnCEAy79T0LLoq9WSPxE1ud3x5dE6LMpyqvGoSr00p5zq+fwugqvpRS980K3VbIUPa7zVqOw17fX82ruSBVnZjdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=spTsY7bKjVPHS7Z4ve7fdJL9M7Yb0Fy0vW+OO5nooqw=;
 b=BgHa+0NrA8df16/1iRr7T48jd91/DYH4cvEoXDjZaiZz1ZTdg7vD8tA/nhlnZSdd0iP4NMCeLL8vkFGX3ns4OXwzobIoECK7SWNT2cJliMjGutb3Ta/90MtfhNT1jic+tM4XUN5D1nE/jxBdNse3EI+hmDY5OhP5S5YclsMIph8Np1HIqfTJQlobiJJb/wbPl2ncaxgoGhJ/a5nv+Y78If3x5wb3cXTU/dofk8cjABCmBNzi+Gem0NizwIPNj8tomdBGKT5nHWRpMU7Kr6bUEVu+rNFqCdk8Ni3OJI7/QfYYiHUYzHeJ01EpDBFnOAjXQMxnIoy82u7XUzwPYhSGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spTsY7bKjVPHS7Z4ve7fdJL9M7Yb0Fy0vW+OO5nooqw=;
 b=e4b+4n/gw2sqp2uwBVqm9i3Cce5Exf7K+VACg1ymrU225ucIrmmIGaQ2YSy2TlQLyDpTN7+AnYqtYahIAkbHMNZpCYRSNFYCyjP0L8ZRJ2XTgruhbiOuu+F47uIx5AwlJIMhMtgnvQxfxVVNtnmaLeQ616JPty6x+pv5UdiWM64vYuj9Ii1Lvu/m8wljRl/6JSDCxaZvAIynfnpV1Co1O9XIk0jUHN6pg7v/K9GSBeLfTJQY539Z/JiRu7AO71kvgTI/K+sQnhJHZ1dLs5Nhwi2xg7UFCPEjWyDqc/GV+c9I0/0XHT7Ps+jxNCQUOfY27fmJxXVRL/4cnb26ebRs+Q==
Received: from SA0PR11CA0166.namprd11.prod.outlook.com (2603:10b6:806:1bb::21)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 11:49:01 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:1bb:cafe::6a) by SA0PR11CA0166.outlook.office365.com
 (2603:10b6:806:1bb::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 11:49:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 11:49:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 03:48:45 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 03:48:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 03:48:41 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 6/6] net/mlx5e: Properly match IPsec subnet addresses
Date: Wed, 26 Feb 2025 13:47:52 +0200
Message-ID: <20250226114752.104838-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226114752.104838-1-tariqt@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bc5d86-da56-4c36-a720-08dd565b8f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsgHdkmv9LNJs3Vkvrr4Hi5T8iDtTDBwiqM7c6JTOBLkTJxLpIgISqN6baDg?=
 =?us-ascii?Q?dEeTo0zWFSvBzsWriL7uzVTuOT/aGZ+2YL+lrWjJ5LE6jvoy7W21NorW2QQ5?=
 =?us-ascii?Q?ElIMVIIZXLLjc9YsDH9zmXBCKortTsic4pwSZ8ynIUQM5ccfyIykapkxFhgt?=
 =?us-ascii?Q?y7NydZGWA1hcwLCsKC3etRuaiYCAuWHrlwqaUMwDjLSOpiC4O1H3On9f8NsU?=
 =?us-ascii?Q?rw/FWDTVbMRvRTjQhbrQLk1PskWTyL3gDGAc5mgaY5jj/FJlTzcKgKiNBiHE?=
 =?us-ascii?Q?oMuFTV3uJbuV9XD5RowdoRzjuV0Qy2JaQskgdaaaF4MDbcACdK2WbaH2Bkcm?=
 =?us-ascii?Q?BhujzbdWvVfkrkuktgerbwAax3iNBaWTTi0GZJY/GfP5vXlMkW9tkfsxBN1s?=
 =?us-ascii?Q?60hv2GKl48HOnRRowWqQJLy4i4vPYU2LmjFlLNF83nr0xp9bf9xc1mASpIhJ?=
 =?us-ascii?Q?4093uaU2FR9Xj4Yu0FjOsd38IOpWIctQP9Otx2azbPm9x9p2Z4137pmCsqcV?=
 =?us-ascii?Q?9Rtus6I3MnhKr3CqBzvqA/OoaxSlir5Gb7YkRyq1See6VxYmPN8qvkcdWWig?=
 =?us-ascii?Q?/HVY0jOsuTQ/W+hbLng4JF+dZUZ0n4uiQHAqSro4ssdbymUWnJOHaRA3Ohvq?=
 =?us-ascii?Q?ZqD/N5yb1k1BuDmofDv+CQTwC/qgo02EBuB1FOJWeCA2o6pvCwjjm+q71euF?=
 =?us-ascii?Q?mxHsEw+MlCTmHOYSgZ+A+yEO++894NzJuptUbpYzOFLB+RBR+90GZlVrtg1v?=
 =?us-ascii?Q?fd6s+K8hXc+e9N0HDJpH695gPDD5eF//9j2StlNIyxcP8lK+mDzJxdcL0Lif?=
 =?us-ascii?Q?383HzvXfINBS1AU2vGeKmiWSV5+ncLUQbnSL35FK+Yjh2+7Q66tdodSyAy4N?=
 =?us-ascii?Q?UBDH4HVKud+m6uQYIU04OyszqE6gPjPNOJ7+0Wu88CF5+JiOQRBCr4ZhbXVI?=
 =?us-ascii?Q?CQkfHxuL0kn2rpEWQxVQPvZueGJ7knsuXvI/T1YflN0/VGWmIXs31WhbVgR1?=
 =?us-ascii?Q?UsElX8o1K4LsLF+RAncxJ8/HeM+JQIxWZ/yE4AvxB9oHnGGA+d0w/Z/hdLeD?=
 =?us-ascii?Q?kCdQLts2vdN09vaH79lHWfVyQIMKDz9hhRCRhxn/42D+dcrTV0QmIQpl6m/p?=
 =?us-ascii?Q?PACD14zKl6dLbEAaklgaespYJeN98oSjX+ztdoGTOi17mQZnELyi3fYevqlY?=
 =?us-ascii?Q?nXwpG840qhp43ljfZ3dyh0PdGf572eyonvvnoslalFqYOsgIyv8vxEF7TPGK?=
 =?us-ascii?Q?vZfPc7oo81s2e1nB6w9+Ja/WXDVBdeUMbfM7Tjm4t3S5tN9Qoc4JURIrr4rr?=
 =?us-ascii?Q?ul2a42svGvFFfpJbmi9o9R17109B4qFUJQgorAaU3US1MUlzE2gSCzwyeKwg?=
 =?us-ascii?Q?tXNxvpRlEs6F/3cQB/xhmsL0LYrHNdP7dG+DRoLjmB17c5/zICXsAdtiM4xp?=
 =?us-ascii?Q?bofqp0tkgglBvxvySOM/p2RkY1AiZ6vjtgZbi7tzSvyrwF2JEQqkyIqKIUrx?=
 =?us-ascii?Q?67W55zQSKdEQQ54=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:49:00.0121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bc5d86-da56-4c36-a720-08dd565b8f36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207

From: Leon Romanovsky <leonro@nvidia.com>

Existing match criteria didn't allow to match whole subnet and
only by specific addresses only. This caused to tunnel mode do not
forward such traffic through relevant SA.

In tunnel mode, policies look like this:
src 192.169.0.0/16 dst 192.169.0.0/16
        dir out priority 383615 ptype main
        tmpl src 192.169.101.2 dst 192.169.101.1
                proto esp spi 0xc5141c18 reqid 1 mode tunnel
        crypto offload parameters: dev eth2 mode packet

In this case, the XFRM core code handled all subnet calculations and
forwarded network address to the drivers e.g. 192.169.0.0.

For mlx5 devices, there is a need to set relevant prefix e.g. 0xFFFF00
to perform flow steering match operation.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 49 +++++++++++++++++++
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  9 +++-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 +++++---
 3 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index beb7275d721a..782f6d51434d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -303,6 +303,16 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	neigh_release(n);
 }
 
+static void mlx5e_ipsec_state_mask(struct mlx5e_ipsec_addr *addrs)
+{
+	/*
+	 * State doesn't have subnet prefixes in outer headers.
+	 * The match is performed for exaxt source/destination addresses.
+	 */
+	memset(addrs->smask.m6, 0xFF, sizeof(__be32) * 4);
+	memset(addrs->dmask.m6, 0xFF, sizeof(__be32) * 4);
+}
+
 void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 					struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
@@ -378,6 +388,7 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	       sizeof(attrs->addrs.saddr));
 	memcpy(&attrs->addrs.daddr, x->id.daddr.a6, sizeof(attrs->addrs.daddr));
 	attrs->addrs.family = x->props.family;
+	mlx5e_ipsec_state_mask(&attrs->addrs);
 	attrs->type = x->xso.type;
 	attrs->reqid = x->props.reqid;
 	attrs->upspec.dport = ntohs(x->sel.dport);
@@ -1046,6 +1057,43 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	x->curlft.bytes += success_bytes - headers * success_packets;
 }
 
+static __be32 word_to_mask(int prefix)
+{
+	if (prefix < 0)
+		return 0;
+
+	if (!prefix || prefix > 31)
+		return cpu_to_be32(0xFFFFFFFF);
+
+	return cpu_to_be32(((1U << prefix) - 1) << (32 - prefix));
+}
+
+static void mlx5e_ipsec_policy_mask(struct mlx5e_ipsec_addr *addrs,
+				    struct xfrm_selector *sel)
+{
+	int i;
+
+	if (addrs->family == AF_INET) {
+		addrs->smask.m4 = word_to_mask(sel->prefixlen_s);
+		addrs->saddr.a4 &= addrs->smask.m4;
+		addrs->dmask.m4 = word_to_mask(sel->prefixlen_d);
+		addrs->daddr.a4 &= addrs->dmask.m4;
+		return;
+	}
+
+	for (i = 0; i < 4; i++) {
+		if (sel->prefixlen_s != 32 * i)
+			addrs->smask.m6[i] =
+				word_to_mask(sel->prefixlen_s - 32 * i);
+		addrs->saddr.a6[i] &= addrs->smask.m6[i];
+
+		if (sel->prefixlen_d != 32 * i)
+			addrs->dmask.m6[i] =
+				word_to_mask(sel->prefixlen_d - 32 * i);
+		addrs->daddr.a6[i] &= addrs->dmask.m6[i];
+	}
+}
+
 static int mlx5e_xfrm_validate_policy(struct mlx5_core_dev *mdev,
 				      struct xfrm_policy *x,
 				      struct netlink_ext_ack *extack)
@@ -1121,6 +1169,7 @@ mlx5e_ipsec_build_accel_pol_attrs(struct mlx5e_ipsec_pol_entry *pol_entry,
 	memcpy(&attrs->addrs.saddr, sel->saddr.a6, sizeof(attrs->addrs.saddr));
 	memcpy(&attrs->addrs.daddr, sel->daddr.a6, sizeof(attrs->addrs.daddr));
 	attrs->addrs.family = sel->family;
+	mlx5e_ipsec_policy_mask(&attrs->addrs, sel);
 	attrs->dir = x->xdo.dir;
 	attrs->action = x->action;
 	attrs->type = XFRM_DEV_OFFLOAD_PACKET;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 37ef1e331135..a63c2289f8af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -81,11 +81,18 @@ struct mlx5e_ipsec_addr {
 		__be32 a4;
 		__be32 a6[4];
 	} saddr;
-
+	union {
+		__be32 m4;
+		__be32 m6[4];
+	} smask;
 	union {
 		__be32 a4;
 		__be32 a6[4];
 	} daddr;
+	union {
+		__be32 m4;
+		__be32 m6[4];
+	} dmask;
 	u8 family;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 23b63dea2f7f..98b6a3a623f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1488,7 +1488,9 @@ static void setup_fte_addr4(struct mlx5_flow_spec *spec,
 			    struct mlx5e_ipsec_addr *addrs)
 {
 	__be32 *saddr = &addrs->saddr.a4;
+	__be32 *smask = &addrs->smask.m4;
 	__be32 *daddr = &addrs->daddr.a4;
+	__be32 *dmask = &addrs->dmask.m4;
 
 	if (!*saddr && !*daddr)
 		return;
@@ -1501,15 +1503,15 @@ static void setup_fte_addr4(struct mlx5_flow_spec *spec,
 	if (*saddr) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4), saddr, 4);
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
-				 outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.src_ipv4_src_ipv6.ipv4_layout.ipv4), smask, 4);
 	}
 
 	if (*daddr) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4), daddr, 4);
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
-				 outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.dst_ipv4_dst_ipv6.ipv4_layout.ipv4), dmask, 4);
 	}
 }
 
@@ -1517,7 +1519,9 @@ static void setup_fte_addr6(struct mlx5_flow_spec *spec,
 			    struct mlx5e_ipsec_addr *addrs)
 {
 	__be32 *saddr = addrs->saddr.a6;
+	__be32 *smask = addrs->smask.m6;
 	__be32 *daddr = addrs->daddr.a6;
+	__be32 *dmask = addrs->dmask.m6;
 
 	if (addr6_all_zero(saddr) && addr6_all_zero(daddr))
 		return;
@@ -1530,15 +1534,15 @@ static void setup_fte_addr6(struct mlx5_flow_spec *spec,
 	if (!addr6_all_zero(saddr)) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), saddr, 16);
-		memset(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
-				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), 0xff, 16);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.src_ipv4_src_ipv6.ipv6_layout.ipv6), dmask, 16);
 	}
 
 	if (!addr6_all_zero(daddr)) {
 		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_value,
 				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), daddr, 16);
-		memset(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
-				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), 0xff, 16);
+		memcpy(MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
+				    outer_headers.dst_ipv4_dst_ipv6.ipv6_layout.ipv6), smask, 16);
 	}
 }
 
-- 
2.45.0


