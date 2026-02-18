Return-Path: <linux-rdma+bounces-16984-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJNNHKNqlWkzQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16984-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:30:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E9153AEF
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5277D302881A
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 07:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E630F819;
	Wed, 18 Feb 2026 07:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BnmqVyTm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012033.outbound.protection.outlook.com [40.107.200.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139F30EF7A;
	Wed, 18 Feb 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399787; cv=fail; b=DpCjxPHeiin/f7fsc9FL6o0jeVM0dS+mwX++jQXaOjSpVzEiu9jRSgDfV1sDoXe9lOSeN7Jiedi6FgpbqxYhxC8yYrhuZLt30Aw75qA4BDqXSg49Bs5S1LLRaYvGwOpODOjIZm/d9lL7Gzruqw1sf7JKSH24+C4i1LSGmMdkBMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399787; c=relaxed/simple;
	bh=e0AHb+AOxuaSQLhAtPDmHrpW1eHWZBkz0476t0W0ZNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh5A1wcLV3JqEzZIUJ+qhKEyoBAUL79mukHoROe+7gl4gTG04xr+oBT58XVJ51dwZT6qsPHnjiBC+rVfkpRDGVZs9IZ1NfeZTK+JkVXjFXFiKw0fMG4tGTrNLpcNtWCzaViM6jIsnYMnfu/iwJ7RVOWq4PVcuUejM31gxXymnkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BnmqVyTm; arc=fail smtp.client-ip=40.107.200.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mroz4H4FqzbZQ7guV8iYr1/6vMzOGGt4pATqce5wi2gECDBgLT9o+Hs49cKoVAt3DcPAAoEnvQjeeoNwv2UBAascz04sWyARzdX3aQdtF4ihhUzihzEr1B3dMUOaXcKis7FiDy5Jl45mQ6ntcdnqNpcEB5OpnZXpwFdtNxmbLAxByCQ7nkI/8GkFWrQhmQ5lvDDYDeF7A7r/VGwpHM+DUqfN9UVy4npNPKKhSlhynT7iUxJ9BbPaq3HMGOah7a5UoBBlI643zpcJFR1azIz/95PbDkbUEqY5aKbwX1+mlm5JioCOYwbXH6JZfG/etNQvU3AMOQd8/n/1n2ilZq7anw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lYMlBN/eNDpByaL/novHLiF4JiktXte4dEWir26/Yk=;
 b=vA8Qu3DNNsdltywR+YtsLUXzzYHLFL2DBX8ipUFc9RdMqIO+AMymosNzcOF1eLkUwjkcR89GePW3DMTkHUR14pubZ5ZfZi5uBSOL2q/aUjtzUL0Kn4uGuHMMwSOUF4xDMF0XU5WADtnp+G5EhnObTopeMXgqe3DOO1WzJra6xW7WAEkvMlI6TvRnk9an/yrkUMmH2++2tpTNTFn3xciWwEGsih8q75LkYFWkP+BHrnh1+w7uY1SrkeUtUv1XF8ZiSdzz+IqwNLS2ZRo1MyD23OmLVF7zhoah+AgmXoxVqaKPKZL4jh5jV2n0ugW8rNOzGZAPGcJxiBi6VgCHU6VVYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lYMlBN/eNDpByaL/novHLiF4JiktXte4dEWir26/Yk=;
 b=BnmqVyTmTOcxmrbAxMu32CkaWAeK5pDYUTaurGOnpYzxSDeqULO3qsaidQMB7dLXtHdvlEIc+5taw5KLIGhwGfW7Er9Hcdvbrt5q3V4bZfKTM9lVFYQZDLgmvW0x7HOyKvH1sDU7/RiivwQN7oLaP7pWVlrSpSanTiyB8QOFuso76eNk8HDskP37gPMb2L7jVmtB4PGIBpKGJF6qTMgB6elLAhZv6yJBS59xgjwQ7T+1waAcFhUwFjPQaoxSvpclVGiLlSIXaHoeNfKDgniDbtfITHnwpg9qMTVsrdQG8QbWPwuubHUAV0CaQRDmXIOyyKiBFBQTIin13HeYXOHsZA==
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by DS5PPF5E0E7945E.namprd12.prod.outlook.com (2603:10b6:f:fc00::650) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 18 Feb
 2026 07:29:41 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::d2) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Wed,
 18 Feb 2026 07:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 07:29:40 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:25 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Feb 2026 23:29:20 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Shay Drory
	<shayd@nvidia.com>
Subject: [PATCH net V2 1/6] net/mlx5: Fix multiport device check over light SFs
Date: Wed, 18 Feb 2026 09:28:59 +0200
Message-ID: <20260218072904.1764634-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260218072904.1764634-1-tariqt@nvidia.com>
References: <20260218072904.1764634-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|DS5PPF5E0E7945E:EE_
X-MS-Office365-Filtering-Correlation-Id: eddec305-e2aa-4ebd-226b-08de6ebf7acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUn+FVtsLT+wpmiM+Pyd+aUw1VmcANg9oy8odNF+Rj3GDfXQ5Nv+GW5pjFWq?=
 =?us-ascii?Q?SDDfO7ujvFZGxPMK42BZD7rsT+raisBl+ML31IaFUI3QMhiJKuddvRXEwTU1?=
 =?us-ascii?Q?ZFWIjXgAtZEM+kTW+/Tieo8Gxx8vJr40gRoaW4r6AdsdruciYGd+TurK/hFw?=
 =?us-ascii?Q?znFtgv1GG8xARKQWUOQq1ZhY8v4pXqqHk705/QZoAGvewVQ7huYDU6moar6e?=
 =?us-ascii?Q?xwe0fPQ6si8vmZZlHNT6V1Wu/XmchsFV2oh/LWxdRHnlNWr5fTu/+8KTkhpV?=
 =?us-ascii?Q?cs3PWCNpKvMzQYdK7Zn8gkbH17Q77nQTV7Q6eIuMHrTED0xYjV49QDhyT51J?=
 =?us-ascii?Q?cb5degXLhM9+cktO/Sytj8I/oYjFmyYEN55FgJeXtavjUq4KdzS9yo0fdiYi?=
 =?us-ascii?Q?Qe9Y2zdHlofswIam/9DmSpY0Tfv7uA2RHhbYIn/+u6jwOF6k7t38AvYpB1JO?=
 =?us-ascii?Q?Uytz9yFUav4PmSirqlcMret59nKtFhdomWn0h/DfC+cT/LJcEpy8UzjIJ8of?=
 =?us-ascii?Q?JKi0cTI24v7Sua8MZZuJ5WH277sCUCi1CFH5uyLeewkbjBDkKDkCOVDcvh9r?=
 =?us-ascii?Q?jZsPoMvyCpl4MXIN3rCGDNklUblhVygAT+PG54VCAMLbHahW0voUiEjaM+G3?=
 =?us-ascii?Q?g3a3NGccuWUMjC9JGZ8nEXWnCaL9gaK+eVSHvg32RuHdbWIFuk/ebUGrQAX9?=
 =?us-ascii?Q?QSYU2hn8xRtLRxdEshnIcOgehKXuQg43xRvoQBKN9QZLgNq+VwQ6RcucqYaz?=
 =?us-ascii?Q?cvalSjvVxXKgR51BzjAmUYp8W2ru99WdYlC7dyhUldHxxHj1aYiWEK+81zEH?=
 =?us-ascii?Q?73cy0xSLPv3W/rVTBw9+N3+Vnc/Nb9pJKpjXXkeQCr9wegn/Fcyqxjp0SsRn?=
 =?us-ascii?Q?eHbfaHO3boZ7GJShnr2zfbRvDeApkYpX9vB/HdO3e5X1I2NbZ5n9cHcaJnup?=
 =?us-ascii?Q?jdZj39x+PcxrJKQSWywnjbl/NdPbwjx4hRkBHvyKe6CA9u+F0GYAL+0Pdvp2?=
 =?us-ascii?Q?zfjAY1QbeRm/ioo4HZ5MK7MMQzEblKCAzIW9hJ2K5FDxt4vt+ZYfzpt5XrHt?=
 =?us-ascii?Q?PUSEYXxGOqRmk80XNpcEn+nQRVNNmkfLkuFjjLcUIvUB+U47pydgMtVYckmp?=
 =?us-ascii?Q?RYPE87ONQe5/N3gtFZjdkrFcAJJSr8jBUC2r1cELhDU8/5j4DuECFwzNIXTZ?=
 =?us-ascii?Q?HgODoEbc7KFIg5oMA79upVrEUiARJKkMYwXUxJprLaQ2TffPawu5AqU5zbCS?=
 =?us-ascii?Q?5+wMjyKd4KW/ASXxcViG0nWsQlgcCj/FewyD5YaAHoKHekSpihtqEBA++UsZ?=
 =?us-ascii?Q?ErJH646U78AlZm8E0g5sCcf/vdKbv/rod0b6jLCMxAXgOmX0l/iA1Y3LMeS2?=
 =?us-ascii?Q?ceImQZVh2G7RM63D8fTWqAo7qP9TvZAvMXFqoxsgezQxgJVynha4+pv6CLvM?=
 =?us-ascii?Q?+5AaoI0Uccv6FVPFbUe8OYTBzl0S4ywOJ2k0jLC8H2r1VYSUXWU/OUTcNR0X?=
 =?us-ascii?Q?Ue3z6VkYe/lPPjAsTuQ7UWT9yZzZtWpfur7lcw/s/u2i05pvSNCfarZNdKTx?=
 =?us-ascii?Q?+iXHDVHZN3jYNhjKPIg9sjOPXpqqUXzBkx5UCJWjNygOxjFFjA0guOao88SJ?=
 =?us-ascii?Q?DBAhzi3Wk+hr1KQFC9Ac8WWK8Z6xvofgzvvEH7GM9VCfQD+7S41evl8KH0WV?=
 =?us-ascii?Q?Xhk8ZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LeYzvnW6RqpeZMJKVZHIrHjshWKafklW62nTctQtO/3JILYetW3DDrHlyGaYB6BD2l1+F6GorAh7+wSpy8r0z68vaBXgSbGgnLbSC9aHVcorLjOmCEVP9AjoYnzBCBdMUdVcwIT8/S55NZWq7ec2vi0zu4iMMOZVQghwT631IxtHc9/gMF6r3RW8f4TSNKZ9hpkt7z5IkpLZEYXOFbphwG+M/To7i4b7DFsXFtiCrFUe6UOt0q/Y2wovczy5CrSJiKvIuZxkpyeXEMHhJ8/vtaxdG4f7FM9QKGsg8Ulz24p8c+zCycZkatD4Vv4mJQJcZAiLLNSn/26lvLOKcB+8p+u4XEj+ChdKVppawPkCzq0caiIN+OnVsNgVT7d1e2QYXRRgkIgJrkMTNjUI3nrayKAsvK2rUOFyDSzPTs0Ad6tqNDC8N1MwcWcpVfWAQc5j
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:29:40.9263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eddec305-e2aa-4ebd-226b-08de6ebf7acb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5E0E7945E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16984-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A94E9153AEF
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Driver is using num_vhca_ports capability to distinguish between
multiport master device and multiport slave device. num_vhca_ports is a
capability the driver sets according to the MAX num_vhca_ports
capability reported by FW. On the other hand, light SFs doesn't set the
above capbility.

This leads to wrong results whenever light SFs is checking whether he is
a multiport master or slave.

Therefore, use the MAX capability to distinguish between master and
slave devices.

Fixes: e71383fb9cd1 ("net/mlx5: Light probe local SFs")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 include/linux/mlx5/driver.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e2d067b1e67b..04dcd09f7517 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1282,12 +1282,12 @@ static inline bool mlx5_rl_is_supported(struct mlx5_core_dev *dev)
 static inline int mlx5_core_is_mp_slave(struct mlx5_core_dev *dev)
 {
 	return MLX5_CAP_GEN(dev, affiliate_nic_vport_criteria) &&
-	       MLX5_CAP_GEN(dev, num_vhca_ports) <= 1;
+	       MLX5_CAP_GEN_MAX(dev, num_vhca_ports) <= 1;
 }
 
 static inline int mlx5_core_is_mp_master(struct mlx5_core_dev *dev)
 {
-	return MLX5_CAP_GEN(dev, num_vhca_ports) > 1;
+	return MLX5_CAP_GEN_MAX(dev, num_vhca_ports) > 1;
 }
 
 static inline int mlx5_core_mp_enabled(struct mlx5_core_dev *dev)
-- 
2.44.0


