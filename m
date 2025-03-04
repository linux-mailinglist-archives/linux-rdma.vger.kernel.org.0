Return-Path: <linux-rdma+bounces-8331-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5A5A4E64E
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95ED519C52BE
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810DE2D3A80;
	Tue,  4 Mar 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RFFM3QgT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4C529C35A;
	Tue,  4 Mar 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104451; cv=fail; b=JOmTdaBdL3Y8V1tkv0AlwYQuuo9U3Jo8bKLlQquVFXsSklrU/aTslffCP8RLjvGMNBt4Mva2wwwDsYJqEdyJSDg6lYNDnu2CXrampd94rKklcI1xrmICxo3wz4u2VZFA+liQwRLkGVMNRlQYrxDw5k9Rg4lx10pIluwgw7lDpXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104451; c=relaxed/simple;
	bh=bYF9v5ufkwgKQiMySA56oJfPCCpSagb3eqv42UBvE0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fseOGjr31XoH8Y0Fmgu5SesEKkbmOr/yCyDtB2WhmoVG94UaclYMXGobM7yaP2naT8OMGmysUI5itG1CTlOeAeCaKtz3bD2opuMtx18B4zJIEI2TObNb7uiGVSEbfHuSg1PDU93iuBpdlcZOctYhxYRKHi+2cntHbrOQyDIoKKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RFFM3QgT; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkF5kzUf3N6+5r7ELtrTYzKHHgow+rdeNw5pnQzBBT1r29fRZZWX2NG9jTPDVfYp7mBXoQfHqjZpJhJgEDFbuLM6MlcB3r+SvWj2KpQjq4SXV7/cElWd27BW6f/Vzn4Ex+XeBkp56EDDktSnCnmAIySojh+Gl5HyKf7Pa86l0w8nuqK59Tlvup49dAx+cprPId0AwzvAqrMyoxMg7sP0TBKbFBYR3AQHsNpGc8/N8WthPOIlImwOLEAYHQw2ik1SS7tvyA0ynBMduofzAMaRaSqySyNebJkKxD2aDcXp7RPgV/IXYSTJZmBXuMxvgiLKk7KPCrUMzJSHahpS9A7vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvoPwjk8ib197xrgN8n5iCcP8sx52JIzEywWlxn8uxw=;
 b=JlJJSlmA3eua1oIrYoUnIHVTRtm2g+r/jp8mUuuS/5wURky7XuATp/ZWuX76ZRodYuoILXMCLEuXxUn2rSo2b+80SMHEwLtC31z0P6iuX4efha5319W/77xESQOwjmUmETvukFg2SDUJsjlUT/fv8viN1ayMolk5cO2eNLiUSFPTXvXjuJ5HoSNj+wKQUPAM+dg2gmKjDBDq63nKPaEcubiCH8qJCJI0Ali5oRpvVlTq5kUQR3FzPyZG0ofJVdZA0DgZWDmu9LPudaXMuE5GFneLTjt7jhhjCidSe8ao/PYXatFNXJ5TgXYxPhb7EbY7DPHabIMu8zbQJKsEu0rxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvoPwjk8ib197xrgN8n5iCcP8sx52JIzEywWlxn8uxw=;
 b=RFFM3QgTQAAQ2OQlmONGM6+Bt6sY/wSzGwZ5utAt4gpuoOFQrqO/Y1le+p6zyNSAOe5Yj/SZHUDEkLzqYQ7UvI4b8UA4DxL2SQ7zIeHeTDJBIOxuW+h2sz/I9jmG+IM0MHD+ycLllJB5V2iT3DghgLQx3dbZqnq22H35g9+f6jj6JBOuPBZXwEeaUlaWHjG610oHkClnmNSTxMaX/i4B/7XIyf80Qaix74rs8/OJ6U71hO1/N2EK08S+xSOxxpRRGb49aqrOeAkpja0A+ec9IpDahS7ZY13qDfSjnOalwlwSUZFyF+thdhmdFcCKEdeRRIIvEGlmi3AZOgmv946HgA==
Received: from PH7P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::20)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:07:26 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::e8) by PH7P223CA0019.outlook.office365.com
 (2603:10b6:510:338::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.29 via Frontend Transport; Tue,
 4 Mar 2025 16:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:07:25 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 08:07:05 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 08:07:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 4 Mar
 2025 08:07:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 6/6] net/mlx5e: Properly match IPsec subnet addresses
Date: Tue, 4 Mar 2025 18:06:20 +0200
Message-ID: <20250304160620.417580-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250304160620.417580-1-tariqt@nvidia.com>
References: <20250304160620.417580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: c3196444-da0b-45b5-4387-08dd5b36a7ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/hEFgYXQA326r7BSYh3N6Xf41oMr1iGk6eS3egb/M+bby9GEyH0eUguuugv?=
 =?us-ascii?Q?eUP7GKnJfMzSVrYDQctAp5Pon2DFDjSMe0iBVZf4p71hMucGtFElqbo5FY5D?=
 =?us-ascii?Q?JTCsmP4vVrfLwlkhFA9zkyzim5uCbygHn9/EKGiDHaJqAwrc5oOQXbNFSp4p?=
 =?us-ascii?Q?jQgI4YLusZPdoq5JF2zNkSzwvYQnQykmfDWT2YBgsqR3FjyeFgvVQt3IAfZR?=
 =?us-ascii?Q?L+DfQgx//yvRTn2F/JU+SNqqKEWjAqdWKhtACpQhMs/UX0XynrmTwNQbCFPA?=
 =?us-ascii?Q?VXRXPPF24aF7PaE67WDFM4VwuxLbo/8TUUsaY2vs7nTuUNDETJcB0zGh3hGI?=
 =?us-ascii?Q?/LJTNKVWKUrr1UU6y11zhjn7Sswpd1k1FlkEfeJ4HGAM/z5Rh7knzdRdxotB?=
 =?us-ascii?Q?8D7nWzGx2S4cNutIsjJ8o2J/79ioz5BuAXtyWJqp34Jx4QlhrNYSRyW/yXvV?=
 =?us-ascii?Q?VJOpzjnToUFkM5Odo9kUf+iYRztTYfhZVNTUnjF7PH6TQcWSq+EZQd/lOzMM?=
 =?us-ascii?Q?e1/SoLxy0rqHFnwUWQt1kqCsVyoAgrwISkrDfG7cL9rzQk0qgiAYWkZBq8Dn?=
 =?us-ascii?Q?8fUeaaEA/yl+/qzvSYSO1jGGEtsW6P3mNZAQ27T+u60gMbu8VzxAVJ8PXvl1?=
 =?us-ascii?Q?FKAGr0awrxTw8S4Kgo+QZPjEmpnUGdih27ZJ3wWEATwr6fgdNuzZm4ZsPvWE?=
 =?us-ascii?Q?TX8CwOi0/qEDM9DONhI27AXvDRfrIzcCAhFhsE22nUClY53YvwLam1gF2tHj?=
 =?us-ascii?Q?BrMYRPQJDuF/BEkBv3MhCmxwtzOYaolKYV5BjHLoi5TJ35umhUmhdsEzZ1bu?=
 =?us-ascii?Q?GiJu3oP3LM4SecwBLnXaSxgzGAYXHGxo6iB1zgk6jzmoSK7Uib12frhXxRZL?=
 =?us-ascii?Q?u6IfCm/EDb13MjA7vbiLBQBtF7Z48GBXVTyjoeBsgKHOz8phI8gQXvMSLTzS?=
 =?us-ascii?Q?ToozzeB2affjZfNFDE67tEPCe5F6ppkQT5JgF3LJd1+jcW/CKflhU2pGVfXc?=
 =?us-ascii?Q?fvxCww2h1yZzBMN0NGJQaZDLdaqspTvLXbqmJryMu34h4X3BMpOem5QPZYrC?=
 =?us-ascii?Q?bLPqHzmmIRz+kjX3JgMHBi/Qz2Fj6plkpULaaRkKVZd6qfIv0gTSKXxTDoCu?=
 =?us-ascii?Q?5b4GfJaTeugpNKRrmzPNlGz+OxKkY2cRpnbLSuBZMDwtl2chALKIO7o78HC/?=
 =?us-ascii?Q?h2LtBP8T5ifaUydcBPoQxLjyur/Q4ZA5FqCpUcTUE3Oc3swT9CHyD+rc3Lif?=
 =?us-ascii?Q?UsQrNrDl9uYLeTD7T/gOxbCx9SnbFVnVPsdR2wxKVu4p8IvrPHTwXJBmrxsk?=
 =?us-ascii?Q?aKdRw27jL5lzjDd9DTOY9qiRK07IT2ESbxplg3pjxpjWqQg9DMc9oTQgp94W?=
 =?us-ascii?Q?7AQk6cvUh/9poo2ilJnwIWCAnlY1HyYwhjAVrXCZUzPxHqNQS7i/vL42GCUX?=
 =?us-ascii?Q?uw9m0r8/XwD2kZWO4OxrTnbeR5Y4TMuWiTXcSFDxwehD1E0fwyR2Msgy8sDh?=
 =?us-ascii?Q?XjCIpgkSRB22VKo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:07:25.5052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3196444-da0b-45b5-4387-08dd5b36a7ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526

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
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
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


