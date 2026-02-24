Return-Path: <linux-rdma+bounces-17120-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF3ZKbOQnWlKQgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17120-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:51:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 236981869A5
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 874EB3147CD9
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C993803E1;
	Tue, 24 Feb 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QtQ/vZvL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013015.outbound.protection.outlook.com [40.107.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3637C111;
	Tue, 24 Feb 2026 11:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933649; cv=fail; b=imk81iP8FT/6iWiuGfJfeFeZNvBDihRwxO5Z8fqV7prPikDTyFr2URIPYWlesr3glcFg/MgxwTX5l3c2JdIzDE0YUTxwkJ1J/T/3Wa0LasS+bpbwImoM6XTcuqIAdbMpmax/IzDu2sztCcg7b8wRNhXCHfFtQiydSUg+0xocIXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933649; c=relaxed/simple;
	bh=emYXbSI/ElbIXu270DwsZ6JHUmyH/6MZibtH6U2AZnU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fZVg13h0xM8nUnaxaEN6eDMWhoV+VUv8lgVUIThd2+fSewlw9/nqf+MJCXVvUIb2YNPuTlL5h5TBt+K1xvPBvgb2IAljXoX3AWTOVBpabC8SUibpXaJ4ZNg8aGNZZ6l+UzeDxHY+KS36UqbhAptKJ0DwRKYqAnXkDp6tcI7ycrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QtQ/vZvL; arc=fail smtp.client-ip=40.107.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5p6/ciSREu+m+4IvF8a3xZdeEL13S9tPPm5DXfBpzcn33FzUfYM+jkwOL/NfGatnvi7IoeyfSMi2FtfPCuok5Tv7rDogIrmIz0sEuUtzMLNIMdRTHX/J/0UU2h+lDyHoYo50CKsd46zM9FEPxL2ES0PH24tHxk1M1RE1C0+ka2bnxKHT/2W1SJ7ziW4ch4XcuLmtFbrneLCiWycDcEhUbRLqJMoGOZ4Ryj9fy2zckk/acdGM6QvFwy6TuMKZkZTWxr2H/+vOMTPDQnc85CKeuJcN/lY+YNg0UrmVFfoTzMI9gEAih2xmH8IjBUPUsCZzQ1osWuTElpBd+WZNXsIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1VFHliDSusoCMEAPcImfeBA+8sQyc5MqxAKuU4+Qks=;
 b=hzrY2GHR3UBIeuHYS1XntyBqoV7QKDAwVi9wXCrrGbyaCvDz+0+UQnWrr0S3WVXDnqdrVmBTdRTKi6jdGZCKutDz1u19pMQtdWJTAstXCJDxF5F/pLdogwqbKvp5utvmVfpCoWD8dhNexQ3fR6YHG9wNAbj65oNf4eeaiwBDZzu3YYL31elIIV9zCsJT3k38HM9NoNTz5O0qkyENKTnLycFLtKxqlvzwNHp7hhtKM8EDY/lQQSqtkxhuKRmHmX3/h3nUwEosEEx5adbXFESfvftffIV6Auz2QSTMC9K0eDtsbkLtfjoDkmsC4TOArfnhnXdel+j8pYYdr5pKn6bsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1VFHliDSusoCMEAPcImfeBA+8sQyc5MqxAKuU4+Qks=;
 b=QtQ/vZvLhWT7B+o2847SXuvXSNLOZK7fA9wcIc2ZF3xPGoADzvlDrjxHHkbkan42HhgKFUfmZXb3Nk54j3SwAP1jmu62bhbNjN9oPtT+7PUJ5KZiQcdk4qrsZ1ULcOwpyo2tkU2jZMEgPIc6pMgrd/q11vi5/tLY8HdywPI0s4azLNCu/uPaPmD2/+/9j64oOocCIbs5rH8tT49NGMPqHxJcQ8alVgmu50u38bKlemtdjHnBJIhofAuCl6rhzJMQ43DMWL2j8hwfTkVDqSs3+wiFivB4kNTiysDv1seRXNa35fNNyT3hk9Wtky5aQwWN0ZryKX84FDD/aS/VARdx2A==
Received: from CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::12)
 by CH1PR12MB9573.namprd12.prod.outlook.com (2603:10b6:610:2ae::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:47:23 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::75) by CH0P221CA0014.outlook.office365.com
 (2603:10b6:610:11c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend
 Transport; Tue, 24 Feb 2026 11:47:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 11:47:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:13 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:12 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Feb 2026 03:47:08 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 0/5] mlx5 misc fixes 2026-02-24
Date: Tue, 24 Feb 2026 13:46:47 +0200
Message-ID: <20260224114652.1787431-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CH1PR12MB9573:EE_
X-MS-Office365-Filtering-Correlation-Id: 591eb787-d0ce-42c7-dad0-08de739a7975
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ad8kHIkh0tOV6XuSjkw982qpyMdpzNr6EEXgYjf57nuspxk8Kx8+APv/JvJC?=
 =?us-ascii?Q?O54PKI9gxv3gM/aNoA9/7Oqx0SmahMsaTx99xekL6dK2ufUiG62OeCm3jan4?=
 =?us-ascii?Q?GJnVrM2yIlZ6vgz69n0SIDtDzVqGS5xp0jfL0P9oqIRWyPry2QaA3+13WIlc?=
 =?us-ascii?Q?LJ9A3aeil9aC7VUf1nQNpo2Q1nice35v+sV1T/tKmfWtnaMACNB5cRuOc73u?=
 =?us-ascii?Q?VkUvurdeAlBdx/HK85enHNk55n7tWAep3wAedR8bLxLeNBGxuRJkSSK7Wyky?=
 =?us-ascii?Q?52WR91Hi/d8D/4Nrsg4ob3qtv50BQ7huJjawLtmvecaYTd204l+e2NVr4bPv?=
 =?us-ascii?Q?YRaPTO7XU/klaPINRPS0fcczuKm0PaLeIvj5Fc/9FMfO6tkpc7uJHX4GKXPC?=
 =?us-ascii?Q?qls15FcbFVPJIeVlq86w6qXdmjaNLVLAsinDTFXONEpkpjDRqwN7Ahcjhi4L?=
 =?us-ascii?Q?dW3M3KEaBWQBphrkxL2mFHFDMV5g98ejXZvkP+k4fu1UUh7U2jBHx0mQIfm+?=
 =?us-ascii?Q?Zb1t6I2VI/ILboQD5ES1Y4xuHR2nqWpTRIwZqBQqc0TIyIhuFwso52IUENLs?=
 =?us-ascii?Q?9Y2L3jcN/j5x1jg5LLmV8q8OjJZVO/xPaKGa2r9fa0f/gYCYpak+eEQGpg1u?=
 =?us-ascii?Q?OD6wD2JOEHKie8eespnDrdiKAObgajq7txbbUDbXRO4bMPZBgikhBiIx0fuN?=
 =?us-ascii?Q?IPamvUKXH67SH5DWQ9LmrRaSzglkN2KfjMXOKI7ch9v+GGCssY8iZDWBhb9W?=
 =?us-ascii?Q?GJu3rjNc5BAZgaJeCIEDlRVnubHGn7eUGlJPugqRyZ8V6NgqJpfA9lRZEh6k?=
 =?us-ascii?Q?+aFzQyK4amOVGdtKkM5siojxzZkgRnSoJvZfe2MRIKdCxpMWYnrPehW1an3a?=
 =?us-ascii?Q?dIjRMZQj68sNJESs0+rukY22gyZqMbSbt71loaaiCRp3g8xPNAyIvRWWq5YP?=
 =?us-ascii?Q?2DO6IH0KkRQfx9xZkpGt6nAzlgtzEHbUBbrM9+NAwyRgiQ8dSms8D8yeoTaS?=
 =?us-ascii?Q?82YbYiXWSCghZuZon0Ab4eErb/HxzCZHsVa4YplaKHf3JxCO5M+Bt80tqSIB?=
 =?us-ascii?Q?DD7hk42Z3ATpVqKTgBJDEcNK0ng43jTeZUJktwwmKR0YLqveNtii0kxti5G6?=
 =?us-ascii?Q?h3mecedYiZaDmu2LSPFB4tTdxTBACez7H8Zdh1R+53uM9B8T3F9q8xZsZQ7i?=
 =?us-ascii?Q?4OTilUsSrMALMUD13IAI4xEUkQ0gpDRs7rrI8+gOwvqqQ3nxSGrW7EgLd8KW?=
 =?us-ascii?Q?EgJDJwHj+P9JCkNRiTwGWpB0NQEnU9D2bj8wSYXWJ904slC+UqMkuSTFD2qs?=
 =?us-ascii?Q?OVvuxQcTtH7K+rtahOa2wzS46sBdYqircvfpnl/O17LsGv0KwC1HLvP1FMzi?=
 =?us-ascii?Q?yS4/5EHOEMcZfTK3Zexc3Y6M78myWy/QCOMFEu64BVWYwUlWCKhLBiMUM31O?=
 =?us-ascii?Q?WV2+R6fXadxDTl/AR+0jtlFd9/6cDilWZpkYvbp1ISbf4eC21Vj9CgN1/OEt?=
 =?us-ascii?Q?t2DZfuBnOVHgLKU0XRJTc6mbluFgqQL1b6p1+F97oOKMJi+eN49kTuuhhPMQ?=
 =?us-ascii?Q?PSWz2TnTdlcAWglfPOC3SWPpdSgdMo5BS7dDdZsRY9K/m8Lu32zbQfMx+4vy?=
 =?us-ascii?Q?+KK7bquaphqpdW16S6Gh0/yfs1C314pVVLS2YclHSznYbiyVleVV8eteTA0s?=
 =?us-ascii?Q?sRPZ3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P1W+KSl5XDZnCjV/AcEZKM2LCKIg6BzLujBrPB9zspzLC+UTO763PaDx6HUlFGmjRAv3aheTPKkDi/izbAjUFGHHMb9X8Apr+d6O5i7F5/Q5bMp16irn8NWbqHhsxWNbI2wmrB5YKIRW2W3JlGrvfMQVKKt4SMGBLv9CGZJfIzLCAxNovB6TNYHj+b+Kw7OQN9VX13ewrZ/Sq6wIZR2SkisMh1nMUvUOVY1OqEfJj5b0BH/EzJ79E2WKp0/bs/9LLgQYaLBlsA91qPrEmTbJBTvm7GKdM0lW9GdUe9SAcmJhtRsGLaoJQdhnsAcqQFYUhA3LaMrlYGDAlz+pl2hHZHUyJKUaDT4cLJlVAFuIjRiGVfAkIBNz6xXG3n6Aa45OT01bhkysRkWJ/0rB2iQs4LncHXiMjyizXPNRQZcwdpeGr5cr9HT5NcoywBQJhiEn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:47:23.1522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 591eb787-d0ce-42c7-dad0-08de739a7975
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9573
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17120-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 236981869A5
X-Rspamd-Action: no action

Hi,

This patchset provides misc bug fixes from the team to the mlx5
core and Eth drivers.

Thanks,
Tariq.

Jianbo Liu (1):
  net/mlx5e: Fix "scheduling while atomic" in IPsec MAC address query

Shay Drory (4):
  net/mlx5: DR, Fix circular locking dependency in dump
  net/mlx5: LAG, disable MPESW in lag_disable_change()
  net/mlx5: E-switch, Clear legacy flag when moving to switchdev
  net/mlx5: Fix missing devlink lock in SRIOV enable error path

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c  | 3 +--
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c         | 8 ++++++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c       | 8 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.h       | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c           | 2 ++
 .../net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c | 4 ++--
 7 files changed, 22 insertions(+), 10 deletions(-)


base-commit: 82aec772fca2223bc5774bd9af486fd95766e578
-- 
2.44.0


