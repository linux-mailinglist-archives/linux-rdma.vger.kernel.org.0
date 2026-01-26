Return-Path: <linux-rdma+bounces-16008-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMzxEMwUd2mHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16008-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:16:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E9D84BEC
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EE5130156D3
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 07:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5942BD001;
	Mon, 26 Jan 2026 07:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tw4ejJZ+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C4129E0F8;
	Mon, 26 Jan 2026 07:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411746; cv=fail; b=sYVRLIaP1qjrZhf6sXPxP72ulco5x+6WFtUZJxkOfOmZGai706jIGWVYwkUOLt3HG4eT1hXty4Jv0TUY0hWmwySxE4gPvgLjoISM/2vxedbOiEHsHhn03gUxoy9VlB00AYkC2+BDyylIantIfSxD1kNhxM9wS9ER8SyYZj+dlEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411746; c=relaxed/simple;
	bh=NWM4QMvS9zI4EEQDoWiKOxjMje65l20ac4/Lg1nfGKc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYc61Z/b3ieoDaLWyeNgpufErTtQEEdbXjVo6sOYI/K96YgP3FLbbo0F5O2dm1gmT62OcycdCKyXsK5dQVuy1X5WtCAx3MXLdJOl4gxOZaJTptkNjg5r5dZRYQSR2M9iqiYfwJKdfu8lXtnx4YUaWziBqKI3cueipU+x7msqmaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tw4ejJZ+; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJy4/F7e3xhfn4qeLESkkiizyYwUH4GvePOVWDZaC9ljPTUPLB+VkG+3N1C7G1COQlGzz6LgpmxA16KaWesC8S8vxKLdzeSPD1oc/YkEXhOcs4QNvePIPb3Lw7cdDKZOsUSZ038nk2ECqzLlp7o7scIPZiBkDrZ+FM0hL/1vZ9j1lbo5fDCgKDAC/miCUdc+5yFNFM5UBgfTogDXNw5/Iy/BlekrcEBD4F4pzwimWM5YFElAt6gIEadZQah/zqMaUV8ZpHpt+I1XJtPwOZGIvP4a9nydeKTYCBRBoIR1Lm/m/LlIAFlA0k/FbrhhSIe096/XZX5frfmTLzmWx8WeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+CsvzdCyHwd8f4AUacSmN/xFDueuYrTwJ59RsGZR74=;
 b=baCFl1Uc55T7jcgyIusuthVcOJ2L3E1XFAMW8DpUI55K/z2zhCRm6Ydqqk9t1k62n07yTD3Phg7PoXfZs9G9p21Ltgd1XOnxhECzXuqoK+j+wAKhfnTFi/7UXfhB8eryB7TIOFIw2kNImrMQasYLIEQvhzEc12d4lYFmsPhyCcXjkGBEvR9oKvF7ZPBUt0Ij16tzJq6U4fBs3iYTfElYO8xvUWkD3FjX21z7L5zIQpW3eFE+oP4ceNPJ/f9d1e4uTRouaNUulpiJ//xwmKTn+aNC9HzSO/W8VlEg8s+N1dp52TgdR+PpeyGXn0yDPN3Gz5PWU5zXXMLGzOUj979e7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+CsvzdCyHwd8f4AUacSmN/xFDueuYrTwJ59RsGZR74=;
 b=tw4ejJZ+/cHpPmLKMa6ufIEAFOpvW+YDlFus84qYdb9ZUNFPVYSLYXOBERupW5gNbKJsaPHjiBmNVVOwH+GY7CunYQdoFE64QPHSFBCsfTCtmlbxX/8nQoTpuGi4P//FGXlirSVhdOQjQ5ISjbn2DYAawZ6GHi6KdJ7nBmNR16VssRQ6eU5i/wciAffU90UFyx4AaGX4/oaWJAfIBY+uEROXXGt5Ynuxd4gTJ6KG2z2gOT68sjL1bL2+yzTrw64eMtbM0i/uJOE5M0UHPcE4vSIiJv2mSgZ+gK8frL916CR8bdzA6Ja4O+s+6CTt///R7M/PVYfoiOL2mjkKfnVjiw==
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 07:15:40 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::e6) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 07:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:15:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:15:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:15:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 25 Jan 2026 23:15:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5: Fix Unbinding uplink-netdev in switchdev mode
Date: Mon, 26 Jan 2026 09:14:53 +0200
Message-ID: <1769411695-18820-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
References: <1769411695-18820-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 71152abd-33e0-41b0-e0c6-08de5caab5c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rFDKVEVBxNwuP9uT4vIF0x8YcECZu1LpgBcof7zwdpYXesdr6XiIozadscYw?=
 =?us-ascii?Q?wMBBER6zTwsO7Y3j+kowEnpiEWTXtJWziJ0IFcplAjhxdUYffRfj++waxhI7?=
 =?us-ascii?Q?bpyr2BSHmghXXXqKGYKanmR2CxzAo525YFSlUkLCdUHCDTi0z4GKJ5KG1xhN?=
 =?us-ascii?Q?FFmfiwceI9OQnPOvm4hwHgHm0YVN5kNT6GOoBfEDZFs/GLWebPj19+geUj1D?=
 =?us-ascii?Q?VPOGXYWxJVuIe0ygaJdMbEWTmq8Ed+4TYS/P8z6FBCB6n04Qi+mdNZ83WOX3?=
 =?us-ascii?Q?vT8p+WUA5b2W22FKCyYbqmBwXaF4KVkbtlNW5XWOLwydKktXMrfoVsTL4BDx?=
 =?us-ascii?Q?zWJ5C1gFxIMRIHCVGb73IAYd9RMThXgyaYWoG8YBo2XMIFh4opR4EcASvemo?=
 =?us-ascii?Q?HqICF0DfMfbZ1kzXxaaq1y71gwNV7P1fjV5I989XTk+HWHEIpDiTjhDIH6tM?=
 =?us-ascii?Q?+ikgLK7xaCERE7UUwsZhn8soHoGHo1SjYafl84fxwg4LY7V2vteB031JTwWh?=
 =?us-ascii?Q?lcXS0P8lC2Nylj/vQbxHzOL+HVztdbyOt9qH74vjvUdF24pQNrXHeOVRqbLy?=
 =?us-ascii?Q?y+qx2a0Gpp7wF61ggnqmgkuUOsTYKeVTWDpLAQMVOriJJwYxYUJf/1cGF+29?=
 =?us-ascii?Q?/vWXu56lJboGk3a7vun3u8mut3lSYajVwDvrKe+QtTvxnSXRsKqMZzFJRw/b?=
 =?us-ascii?Q?uUvU5sROxvydu82zi/moyWEwz/bLNT/orf9feT16/B4tGaIYQwOJNU9QgeYQ?=
 =?us-ascii?Q?KCYRwSQQqCTc7McV8aLtUGUyZRcI+FBTdnTJXOx/bolvIgdktOqctX/Zl+D8?=
 =?us-ascii?Q?4QVAhS9BrxzMI7aHt31qDBLQEoa8HzwwvUu/hroxI/5bLSUGA/9oWfgDX5v4?=
 =?us-ascii?Q?VpMbrWXBY5qhfu1zAEYoIIqtYP5K9/2vTr8wB9UcOe7mNXLDl5SjoiG2Cvdi?=
 =?us-ascii?Q?no07XMl2wzn3tvuCDf8akkJMCHr2c/F4nK8GgfwtYJ+IbzX0FNzdU8tHjFH/?=
 =?us-ascii?Q?w4/TCaTyQD23N5RKuYlkeozrIBcBUMoxDXw/plXh0uh6K9lBMSjsuYtuwn2V?=
 =?us-ascii?Q?p4saGw+Ad6J4QVMmpGMjs6QTiY4pT9aFuDqZXx/Pld9vHtNeufmYuFX/ROze?=
 =?us-ascii?Q?BnbyaJn+gdQmxEzcmXElBcfzsNFpslexKlBHM+iGGTtXsF58kTQoRvhAke2G?=
 =?us-ascii?Q?59GrXOBfk/1eG/hDOEFl23QCReHoQIdMhnbTxxxdVpynu/u+QiX8Z3BUir9R?=
 =?us-ascii?Q?HHwGglFKFavBbsQaL92c936jMPFcEek95RdJjujUK6pwemJKiFjo2NPUGl/v?=
 =?us-ascii?Q?U/jDMpPuSfwT2yPguQ6e6DydF/LTjjNTvaJFwHWj4z3fxlIMuad4yo/PpB0G?=
 =?us-ascii?Q?ZSAInYiubtKykUq/4WnJ5L9H3zX3CNUPgJoprwNqNhsIpJs/luVJPMuGZ9r2?=
 =?us-ascii?Q?gUUv8bh0BFa/bunNeHTYjRpRsEKLfXDxDpfIZOM9yPlXifBzZm5JTcy0wqxJ?=
 =?us-ascii?Q?amihf5/ICsJR8ZJ15z1+0bVRObwF2zsX+2zhAEMM1bXwPVHPJHxEqy3/URf+?=
 =?us-ascii?Q?dryiB1/pmzapupAUl1PW8UgLgUOK1kHvglXcY0dDyQqsAqf9TYl5v2oJawIg?=
 =?us-ascii?Q?S9QEonMBmrNOl1Ol6QI/WDuo+uKZBQ2f9i4l9NWCyFhRLWQlkNkT13BQ/fr+?=
 =?us-ascii?Q?EVrFWg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:15:39.5845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71152abd-33e0-41b0-e0c6-08de5caab5c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16008-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,00000000c912e04b:email,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B0E9D84BEC
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

It is possible to unbind the uplink ETH driver while the E-Switch is
in switchdev mode. This leads to netdevice reference counting issues[1],
as the driver removal path was not designed to clean up from this state.

During uplink ETH driver removal (_mlx5e_remove), the code now waits for
any concurrent E-Switch mode transition to finish. It then removes the
REPs auxiliary device, if exists. This ensures a graceful cleanup.

[1]
unregister_netdevice: waiting for eth2 to become free. Usage count = 2
ref_tracker: netdev@00000000c912e04b has 1/1 users at
     ib_device_set_netdev+0x130/0x270 [ib_core]
     mlx5_ib_vport_rep_load+0xf4/0x3e0 [mlx5_ib]
     mlx5_esw_offloads_rep_load+0xc7/0xe0 [mlx5_core]
     esw_offloads_enable+0x583/0x900 [mlx5_core]
     mlx5_eswitch_enable_locked+0x1b2/0x290 [mlx5_core]
     mlx5_devlink_eswitch_mode_set+0x107/0x3e0 [mlx5_core]
     devlink_nl_eswitch_set_doit+0x60/0xd0
     genl_family_rcv_msg_doit+0xe0/0x130
     genl_rcv_msg+0x183/0x290
     netlink_rcv_skb+0x4b/0xf0
     genl_rcv+0x24/0x40
     netlink_unicast+0x255/0x380
     netlink_sendmsg+0x1f3/0x420
     __sock_sendmsg+0x38/0x60
     __sys_sendto+0x119/0x180
     __x64_sys_sendto+0x20/0x30

Fixes: 7a9fb35e8c3a ("net/mlx5e: Do not reload ethernet ports when changing eswitch mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c | 14 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 26 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 +
 5 files changed, 46 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 64c04f52990f..781e39b5aa1d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -575,3 +575,17 @@ bool mlx5_same_hw_devs(struct mlx5_core_dev *dev, struct mlx5_core_dev *peer_dev
 	return plen && flen && flen == plen &&
 		!memcmp(fsystem_guid, psystem_guid, flen);
 }
+
+void mlx5_core_reps_aux_devs_remove(struct mlx5_core_dev *dev)
+{
+	struct mlx5_priv *priv = &dev->priv;
+
+	if (priv->adev[MLX5_INTERFACE_PROTOCOL_ETH])
+		device_lock_assert(&priv->adev[MLX5_INTERFACE_PROTOCOL_ETH]->adev.dev);
+	else
+		mlx5_core_err(dev, "ETH driver already removed\n");
+	if (priv->adev[MLX5_INTERFACE_PROTOCOL_IB_REP])
+		del_adev(&priv->adev[MLX5_INTERFACE_PROTOCOL_IB_REP]->adev);
+	if (priv->adev[MLX5_INTERFACE_PROTOCOL_ETH_REP])
+		del_adev(&priv->adev[MLX5_INTERFACE_PROTOCOL_ETH_REP]->adev);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9042c8a388e4..f83359f7fdea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -6842,6 +6842,7 @@ static void _mlx5e_remove(struct auxiliary_device *adev)
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5_core_dev *mdev = edev->mdev;
 
+	mlx5_eswitch_safe_aux_devs_remove(mdev);
 	mlx5_core_uplink_netdev_set(mdev, NULL);
 
 	if (priv->profile)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index e7fe43799b23..714ad28e8445 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -929,6 +929,7 @@ int mlx5_esw_ipsec_vf_packet_offload_set(struct mlx5_eswitch *esw, struct mlx5_v
 int mlx5_esw_ipsec_vf_packet_offload_supported(struct mlx5_core_dev *dev,
 					       u16 vport_num);
 bool mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev);
+void mlx5_eswitch_safe_aux_devs_remove(struct mlx5_core_dev *dev);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
@@ -1012,6 +1013,9 @@ mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
 	return false;
 }
 
+static inline void
+mlx5_eswitch_safe_aux_devs_remove(struct mlx5_core_dev *dev) {}
+
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index ea94a727633f..02b7e474586d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3981,6 +3981,32 @@ static bool mlx5_devlink_switchdev_active_mode_change(struct mlx5_eswitch *esw,
 	return true;
 }
 
+#define MLX5_ESW_HOLD_TIMEOUT_MS 7000
+#define MLX5_ESW_HOLD_RETRY_DELAY_MS 500
+
+void mlx5_eswitch_safe_aux_devs_remove(struct mlx5_core_dev *dev)
+{
+	unsigned long timeout;
+	bool hold_esw = true;
+
+	/* Wait for any concurrent eswitch mode transition to complete. */
+	if (!mlx5_esw_hold(dev)) {
+		timeout = jiffies + msecs_to_jiffies(MLX5_ESW_HOLD_TIMEOUT_MS);
+		while (!mlx5_esw_hold(dev)) {
+			if (!time_before(jiffies, timeout)) {
+				hold_esw = false;
+				break;
+			}
+			msleep(MLX5_ESW_HOLD_RETRY_DELAY_MS);
+		}
+	}
+	if (hold_esw) {
+		if (mlx5_eswitch_mode(dev) == MLX5_ESWITCH_OFFLOADS)
+			mlx5_core_reps_aux_devs_remove(dev);
+		mlx5_esw_release(dev);
+	}
+}
+
 int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 				  struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index cfebc110c02f..99b0a25054ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -290,6 +290,7 @@ int mlx5_register_device(struct mlx5_core_dev *dev);
 void mlx5_unregister_device(struct mlx5_core_dev *dev);
 void mlx5_dev_set_lightweight(struct mlx5_core_dev *dev);
 bool mlx5_dev_is_lightweight(struct mlx5_core_dev *dev);
+void mlx5_core_reps_aux_devs_remove(struct mlx5_core_dev *dev);
 
 void mlx5_fw_reporters_create(struct mlx5_core_dev *dev);
 int mlx5_query_mtpps(struct mlx5_core_dev *dev, u32 *mtpps, u32 mtpps_size);
-- 
2.40.1


