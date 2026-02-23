Return-Path: <linux-rdma+bounces-17076-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICAAJNS+nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17076-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:55:48 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5A217D431
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 952A13101694
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B5C37D115;
	Mon, 23 Feb 2026 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VAwaG9gM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282363793BC;
	Mon, 23 Feb 2026 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879454; cv=fail; b=i482RYc7R68warNebA+Um9+JcCwMC5KqSpI4NOl0W1/uGhlC7CPHtCrZwxtdHhHoYJJMHmFV8TPEbkIntZjumKTghgNC9eiqRI0/9JU4OTRD0e+7DdKORJhAVwf4MDESw0zX46tl/2urT9PLHCKWNxPeWmEtYKMTduyM9UzL74U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879454; c=relaxed/simple;
	bh=3vhYamg7bF5hlXgHaB6uGrytviQdNVjHoxYjAZul3aY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTvzDm3K/3DFatCSRuo+12WPnZg4zH4IkZ2MYI87hOrLyTewcr2EIuXwu89HJ0VELyJDt4Zd35l2tbMkq9z+w88YK/80zlwNz+t9Yv+n3OtzH9KS9oqIa7i1UQIzBLnaMBuhmjDvbSa2y7Uzqrs7pst5gOK1RDztE7yAkiLSZoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VAwaG9gM; arc=fail smtp.client-ip=52.101.48.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3PEO/hoz63Rlc1HMlALl9+2FhpQtC9sEWd7c/XDGh9WFIFHERec/oAQtdsOf7qtj02xo0TNt1uJsQArdflU3x76gkYoaG8PM6pKukGxHXxP+fEAhIZd/tb0m4VJkfY9dVkmWlZqS3MC/lIEaV4NDHcpp9+TkDy9wDa1xzjkx1q8rdw5FNszNQbd+Uhi3/9N0mXvte6WOd4Msqr9ltu06/QQeLDRSS/Cee1nK7Iy3jRD/zPPHUVeBa/eRXsqUGA5am1B05q1t9PgnSUhRksodKiab4Agom6WA3Wc9FGOgrp9qBqlEuSDtLdrFCPSsufO9DYoLH/HxAZhSelf4AQuIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK/kh/yL4X941MIFZPvKAwFX3DuIt8JT2MSWC7zlwwA=;
 b=OejtPmb2xchJxyM9mcg0abc2kMWvccPNL/SlIei06s9TjD7eo/LaJ9Z+HeSdn+gUTV4UBLgSAaMgZmvWtwiD1Oi7XrQroHHQVXj8QZFZw2B1xLwwZuho4iL2KIhephdtakWfva5zTUvoKNlUXAM+E7T4Na75zYlVuQEUg/hviIozO5v4ynhzLTN24LIw/fABKe/0bVblQB/CktdOG/FhIs09wNZGCv/j9H2Kq4zoy3+rflF03+goDEn7EarjgBvxvxCFg20XkRUFQux3NPyhwhMoUMwDc4QFkpsa6/e95dkkMzCzVjrZ5abAkkkhPu50WctBLET+YEtEAMK4WaupuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK/kh/yL4X941MIFZPvKAwFX3DuIt8JT2MSWC7zlwwA=;
 b=VAwaG9gMUbWW8RWhechGX7cee2YU2eKrimi4SU1X40YJyntMn+if6qnt1lbpLIAfDaIWrsllo6MfdNRv8/crVnhHpSpHZgq6XXY//wuAnbmRSUhH5l0cJStpQ9tM6v9sdO9C9d5hVOPZ136vYPcb4nhxJp6CWTmpbMdDSbee+pX1m0zw3s5BYFld3R2b9r0b+mLZZG8J6pWiKUjz7ozmDCJ/K5suIBdIy09c+8CfwR9SD6c6uWYd/7UTBbyyu4+S2AachkFVoR9jMJgirStvXpksMqO3Vk1/yXpavDRb2s5Q/OD12gLK8mTaN4IV49ouXIHpO4X/Ydvq8L9/hzGsiw==
Received: from SA0PR11CA0208.namprd11.prod.outlook.com (2603:10b6:806:1bc::33)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:44:04 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::96) by SA0PR11CA0208.outlook.office365.com
 (2603:10b6:806:1bc::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:44:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:49 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:43 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 11/15] net/mlx5e: RX, Make page frag bias more robust
Date: Mon, 23 Feb 2026 22:41:51 +0200
Message-ID: <20260223204155.1783580-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: ff709922-3c24-4689-f051-08de731c484e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KTcK8Ng/IyNXvPry5HmyCSyWCPKNeZiH9Yu9FXgYWWQrPNpn7dBiz+WAaDbv?=
 =?us-ascii?Q?R/ktjIsBTslOxyYp3EA0whuVRyaVgaMt6E2uFjAy6UBXgEX49xoPQ0kxCAOO?=
 =?us-ascii?Q?HaN4EoW0AYz/OfVVRi4sPkBhGwl5W6g1cjdauI4GhioMfJz+15UWJs6Q4xIS?=
 =?us-ascii?Q?G0kbQjOf5racg9vvTeTTpGeI2HJWfzBbuLac5qWBAZiWH4DxUuN5FTf6jMGe?=
 =?us-ascii?Q?TtP+kKS8LgtnDDUvuRGDn9JjOSgTIk1S3Rx0J4jZWHLJnwbBqd7C0cmKigHZ?=
 =?us-ascii?Q?LHSd79cd2ZFdFv0UIIigLsns8gjssb41P/gSYRVQeO8LF19Du20q3lKtHbD8?=
 =?us-ascii?Q?FSexe8mKG5R2pTgZ0FJ1AXndC1d3LNzBds9878hcHFl3i2TKOgE0AZkomLD8?=
 =?us-ascii?Q?Ox+lIpf2Cl6YZQp5PqhKvwc4wBzn7o+2jqpEvka9BIe1olrPRIbxa8bWAphC?=
 =?us-ascii?Q?jJbw2RZlzH1m5IwPvJJDcDLU5wxO85f0WshRB58kwZKdysS8pHusZbBHlC/D?=
 =?us-ascii?Q?yPfeCy+LCHK0+8iazUJCKrCkB2rLwFTQj4rGw9Kw/A5oeNQTPHM9YsTYTUIl?=
 =?us-ascii?Q?0t4GzU0otyhd/KlzAkm76BRtMrTYur8jTALJ15aaDObvQekQW/4V6MYrJSPf?=
 =?us-ascii?Q?i7weJ6eNhnw8NQDpAsPtnyxDpQRvHmZD6sY7nCUI7EWYpCBs8DEJf/JkppMm?=
 =?us-ascii?Q?IVpcFq20tTPNzr30AZr8XbCf9f09F19tuwXHFYRQLROFiJmjsYQAR89AssEX?=
 =?us-ascii?Q?tU6bV8XbIcFyo1y/sfBS81dXOQQn3jF902tbZZxEro8N4ToxF6jp71Mfr34U?=
 =?us-ascii?Q?e53OgZBrJrylvuA6W450e9faGXgcKALCRnoFKBJbNztGYBJE0tAaT4NQixYb?=
 =?us-ascii?Q?PyMb1OlIg2Zjggerj6RiLC0xJhXFmAoybKe5ZPtFOXUaVCYD/wUp+vIz59G4?=
 =?us-ascii?Q?5gwZVTexkYS+btmUEZCpuuznmtdoFcla2kiRP7SgMm60cjuGo+A+QEcu2RA2?=
 =?us-ascii?Q?3dFWwbEVpPRBWLjNA04o6Afy/z1tj8ZHrqSda2RXFXhLx5mrc0MM4kd9sbel?=
 =?us-ascii?Q?txb0ZE7M5DY566WMdoc1Nfb1+p2c9JPeZKZm6hX/Myc2GaLFd0mD90aHSw70?=
 =?us-ascii?Q?0eTpAujk4kbHHfi4S0S+LWCpGboROyH+4p+tUJR6GmlUxH0obuRb2+7PTerC?=
 =?us-ascii?Q?y6sBj5BHrESKAvNoF4ORcppvfaITj8DOStDhSPjHlS0AtrRBIhkcpFSSYuxs?=
 =?us-ascii?Q?59ZG435r6NdvQZLgl8AvgHy7A5SKTxPZkXhaXtiFUlT9qwe73+ZzE9nP8mwV?=
 =?us-ascii?Q?3mQ2nLCyjLwe8leNjCbV0tDGM1Ps823n0/tcrcKn7YnqC4jRy0lgSJuKscZB?=
 =?us-ascii?Q?XK/2eTTsyrnszK+W6YzNI4aKTjgPTWERsfT7JIaWbVPYADTd+r9yQXNd53jo?=
 =?us-ascii?Q?erIa4LYJWHcAFD/U2LITd0foBmilArdApxTMWxrL4xzZfGfOMabklT/8YcHp?=
 =?us-ascii?Q?ckGtgV/puCe4XT8/4dAtGV0J+zUDzYe9on1oU41aMmWuCEnxQtbJQwYGz8x+?=
 =?us-ascii?Q?h1ma0DITTDRNd0CgxH/s+shK0HVczpuAr09/n0FcEDABozUuYpIRZ6ac2JcV?=
 =?us-ascii?Q?gZ3SURDWlLuDTbwUIDXoDW0G4r4n+FsL5IwHQIwYAHzAZZGpYm9DBaT/WF3q?=
 =?us-ascii?Q?txmnew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DI8/vKUwetV8B/ALP+18BeT38vxF2dmNdiHxhSIUyV1nyzQhCdvEF3aOCWNMTfr52EBjNAP5A2dmDrMErgggMSx3hslHnwMPmVk1rvs6xkIag3luBezojTIFAfhBCr+WJHD2ucu7+BGRtrRYJsTkB16nKvZrtFwS2zZq8zUrjRP0C/z6IY1YCyUHpp9S4KCGRFPh8NB+jju1MHjtsmQ4b1OF6DvObzzUZjAmdJOBem9D7EhQm+/g37ujPvrqQAEZyNJe9AZm/4Pxssa1W8OEkZXysK4lrlUTpbHdaJqx1Ln1B0TO26xvuWOr/Nz5LdckxBWTqsoghW8VDbQ3ZlA6AGD1bEppiQtrk/5oae16ZxMQwhN8NfyQYlEGQBqiZdQvSz1lc4qrjFDmfH51G4U5NAcR9ZPhyxBklhWljKg85sTDQs5yEr5quf23riUq/jcq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:44:04.1228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff709922-3c24-4689-f051-08de731c484e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17076-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: DF5A217D431
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

The formula uses the system page size but does not account
for high order pages.

One way to fix this would be to adapt the formula to take
into account the pool order. This would require calculating it
for every allocation or adding an additional rq struct member to
hold the bias max.

However, the above is not really needed as the driver doesn't
check the bias value. It has other means to calculate the expected
number of fragments based on context.

This patch simply sets the value to the max possible value. A sanity
check is added during queue init phase to avoid having really big pages
from using more fragments than the type can fit.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 6 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c   | 2 --
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5181d6ab39ae..c7ac6ebe8290 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -80,6 +80,7 @@ struct page_pool;
 #define MLX5_SKB_FRAG_SZ(len)	(SKB_DATA_ALIGN(len) +	\
 				 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+#define MLX5E_PAGECNT_BIAS_MAX U16_MAX
 #define MLX5E_RX_MAX_HEAD (256)
 #define MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE (8)
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2d3d89707246..cf977273f753 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -969,6 +969,12 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		/* Create a page_pool and register it with rxq */
 		struct page_pool_params pp_params = { 0 };
 
+		if (WARN_ON(BIT(PAGE_SHIFT + pool_order) / 64 >
+			    MLX5E_PAGECNT_BIAS_MAX)) {
+			err = -E2BIG;
+			goto err_free_by_rq_type;
+		}
+
 		pp_params.order     = pool_order;
 		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pp_params.pool_size = pool_size;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index fc95ea00666b..8fb57a4f36dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -272,8 +272,6 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 	return mlx5e_decompress_cqes_cont(rq, wq, 1, budget_rem);
 }
 
-#define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
-
 static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
 				       struct mlx5e_frag_page *frag_page)
 {
-- 
2.44.0


