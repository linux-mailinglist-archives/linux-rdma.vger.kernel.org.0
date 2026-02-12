Return-Path: <linux-rdma+bounces-16784-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EwuNiCtjWmz5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16784-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:36:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2F912C8E9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6497E305594B
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0562D2F0C78;
	Thu, 12 Feb 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AucrSvWB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903BE2D8799;
	Thu, 12 Feb 2026 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892413; cv=fail; b=MS7NNg52oR8gOZqAkQvEHiDLj2BlNOm/1SzrKATart/gZPuPvLgb/OCgch+xIduE7TyHgr7pKGIVBUqUPcRnxXDZ40liW/9Il7yHckVlaAw0t/vnoHAdxLtve/qiupYBNBYu5veIT0vXZC0xHkHeAWKEs0SfiKwEbT3KlICIqs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892413; c=relaxed/simple;
	bh=PABScmcppjImTnx8Q17BGnxoCmHVqHQkNvJ/KUJxeQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=No0BtB3+3fxQcdtnFdHIfn55ziczEHStwArcJ8eDUZtnxLoWU1lPx7zwBVvvNOFsLkos6nzW3G7yJ8L48/bReyDGC5hvTN7MqfBvrU+Oe+XodOeqAONzpqy8bCsLnaK3DjarrF76tE8c55BnKQevdZ+A/WrcITOda1GrpMKP328=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AucrSvWB; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMhlIjWnZT/ZMdSqM+9VvJoQX/Kzav0CsON3m5peCtWsqUF49zeUkpy4LQqb40HRJ7a5oUS58h97g8Scfmy9Ij7yielzOIUQiWegWMboykNS4Y7eu1ZWtK+zeVCHXKb3PLtxFNYDukQcujgmOq6bLNeRd6ESc2uKazcUZXBma8/16ZMDdstCcwvHJYFtGoAKRgpktHtKGATIxrs2uaSwXRdPbF2XDXAxekW+aTA5hUU1BKj1jRtdtaQ4gasGhqaUUdzrfy3LvSBAuoPXqCQPA97kjF/RTypirJwQ/rfFo0AMPLBEws6Yx3GPpyiTyl5A45ZQNpN+5p7G6zYfR9/mZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzHile+1GjbMlLC9idtk6N6g91FFXla08Xlp1RryYQc=;
 b=JUPaZZcU5A5I2L2XtX74DHSYBhvL96EWe0v2Viw5Khk8EieJiv/iSha6LrFJG8hni7yNpZ2NnHFbNFu/7vjCNlbmxa3SfKlEf5Xb3RQ+a+kQBZTbn39c2NKP7Fa6+Uz3Z80J1h/3K1mgTye7f+W1AvkC70+bSu7DYOYCzEDWDddbc20PiBy5deUi8wn8kB6YsNv08vrgG6VqU+jx7lF6bRPIePmJamVW0vsb2anB5i+jkUs3DfABeIDSWpObrP3UWYwl55LfiyQlyKd31mmAr0SBAnGh7bpfe3MLtsWEsXoPu7TsX5wAjeiuRgakzWtB94/3RlLwrDC5O9nmvFrkkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzHile+1GjbMlLC9idtk6N6g91FFXla08Xlp1RryYQc=;
 b=AucrSvWBGCHCofnAVpRbraHjLWoFraRH6nnx22Yr7+FCAi40n9WEu1VkWqjCwpI4qNxkLSWm4Is6JWZCeT6c3zi5Nzz82CLxqn89gWzm1LFdspRIkLWWBCodGcjqbaCGqH05CYa7qsrrusyLQQHwnv2EYC5LH9nsg6wUzD0UcQAHKst4v5yTY7IQ9/Yrgam20IDv5fDpi24i90MaXmEod3mHhGq1wN59dyRn37OedjWdPWvnzqnbZ130BvX0UwvzPUG/ysIp9Eb0hBwZAXuqPTxl9PE7vNHW19DN6QGRsHyuLIc+Je8fu9na9zXxh4MvFWHh/GrCdfi3rBbmK3TFog==
Received: from DS7PR03CA0213.namprd03.prod.outlook.com (2603:10b6:5:3ba::8) by
 PH7PR12MB8053.namprd12.prod.outlook.com (2603:10b6:510:279::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:33:23 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::5e) by DS7PR03CA0213.outlook.office365.com
 (2603:10b6:5:3ba::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.10 via Frontend Transport; Thu,
 12 Feb 2026 10:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:33:23 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 12
 Feb 2026 02:33:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 3/6] net/mlx5e: Fix misidentification of ASO CQE during poll loop
Date: Thu, 12 Feb 2026 12:32:14 +0200
Message-ID: <20260212103217.1752943-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260212103217.1752943-1-tariqt@nvidia.com>
References: <20260212103217.1752943-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|PH7PR12MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f8f616f-edea-4f2a-5124-08de6a22262b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yn5Yit0QR5Yt+JZUMkVtQsGeJCaCcHT8iwcZRqM1KimXurWILjPzXQJEZhiT?=
 =?us-ascii?Q?FSnOlwAKq+6LYkETfPgwr4oK30aR6GmVmcicIiyIFWIei27Wwu6DMRZi7ure?=
 =?us-ascii?Q?7uPlqMVO0fU3JK+cS0T6iBTir7k9pNeVI00FKvhmlAZDQwIrnVIjy1hur0Z8?=
 =?us-ascii?Q?LDEELs2XWvdaY6R1BMdboUTl22PNFwfAhQVtnc4y7cKVXUXfFglSj1o0t7tX?=
 =?us-ascii?Q?Bx6DW/bSHze8ZB3RsmUVvWOyI840mfdlm16CXrNvq8lpUMpB05QzBB4T8E7l?=
 =?us-ascii?Q?F7Fk9NV8v3QsTwTT4vLrNAYJx444o0CJOTVRG3RHYJ4Sa0leEnCNrIt+TB06?=
 =?us-ascii?Q?csyl9rb2xT6M9wJL4sKbJbj8SHjYAC7JDJMsA3vljW0ynC7Yllxm4Zku4Y57?=
 =?us-ascii?Q?swv9e9fA4sQJ4uIIh7M/2kVRv23Xov2FAz/iBnn2vJEo7dGRJU0pZZN40R/W?=
 =?us-ascii?Q?Zxf/L/YNCbS3HbJ1l/9zMtSeb1QLOtdX2u2FNra/t6hJnru/c8AyxCvZrk/l?=
 =?us-ascii?Q?bXRVDPxhw9ZEUb4mqZWKQtioEMOOa/8pQok6mYz+tKRWNaMYROFkLXtPgdT+?=
 =?us-ascii?Q?QpIJWFaGgJR26kq7R+ZGNgbKP0Zc3XzEe5DniV97rE31NG6SHpkhR8uP/hjd?=
 =?us-ascii?Q?34ug0u5TAh/8QXCNdVfXIIehUKb178Px+ZkeeN9GQITi9uyHu+eQTJ1WoWxx?=
 =?us-ascii?Q?RR7B28FkwOEj28/32YA8/lipjOoIUqwSQu888h2UK9R51FyHU48BXP20LncQ?=
 =?us-ascii?Q?HIhH8AHiiLPH0Kmc2nNyPhiLsL7Y2XGHuOXd0VCDRu/kMZpsrWv4yZn2OmSF?=
 =?us-ascii?Q?mxo2T+QjW1H/EyLPeXvZSNTuZJnx9SeOBqnq8cbhVwQSVtHuhLuU5HDr0j7N?=
 =?us-ascii?Q?Rsb9V2IQk/Spz0/lCFMKMSfxtkfaPeR8nTrchlT2L/fRW58HH7SYDpsgLp0U?=
 =?us-ascii?Q?wVri+sj4c5bSeYqiAlJZkV+OzB4GepB79dEslRE1GFTt5z8ZCL++ECNvdx18?=
 =?us-ascii?Q?hT8EbAfvnB+i56hA4B8buAHMWRAxllmjLEWuMWM9RUVLMI8DC42FVoDEUPWT?=
 =?us-ascii?Q?EY564BPNeG3eIo8GsfxpMpn8CIY7juQBwhWyT+EQYvNPCjKH8iH56O9H7Nqd?=
 =?us-ascii?Q?w2xN89pmuQG4/StqFiDr8LtLpOBxaQ2spiCrK0FVMykf0wc3+u2HLq7UQwzM?=
 =?us-ascii?Q?H59OAS9Voezll/1GgUutkCiufkW0X/hKNZVqcRpogTBx4TBXNyzQp2Flb1Si?=
 =?us-ascii?Q?umpEIS1Q0s5GpVM7407RM9ajeUKXyZ7cPJygigrwQ9g6i1PMz8HpfVSFzM5m?=
 =?us-ascii?Q?qZWOT4YVRbiJus8/9poyImcuaSVRhNTJ3tQrvjm3lSIlXww2RE7+rqc/WAkk?=
 =?us-ascii?Q?QGj2ErbY6CV5zaFqq64I3VNY2Z4GTRPI42CFGq3vLozrS9WsKZPwbV7OluGa?=
 =?us-ascii?Q?LgH78udMSZzQoZX+kjYvWVviRXN7SZRnyvIOjXOEoNUZhht/OCU3+HbiZz9R?=
 =?us-ascii?Q?ox42jt0WvsMoh3Ck2TljD8meZXgrl9gOIIX0uH49fUAkYD0azinI/E718Nsg?=
 =?us-ascii?Q?2//mBYB50kO7QxGUAzjj/IRNQB1MobhRdTxJMzF4orZdopGqNvbjDtEZ5zpW?=
 =?us-ascii?Q?p8jSyz6QySW1V4L2MaZjIb7760/76jKaXyIbUa7/p9xf2t1WlN9ZODcqTEgs?=
 =?us-ascii?Q?Bi/TeQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vyDn0ia548rNtIZPZKUNd38BKuFWJKwsrCjBWpffsfoZJpRqTf5BrqzffLH1SsNd8vRdBjuoroDgJdpyUsGsq7MeGT8LeZeXmAB5HLa8wIdnhboZ+KKLqSc2xIfplbeFJCWHljdoeqbev4pOMogORVnJgpuR0Tfy+ejfoICraszyvdlfB5GqT335/TrgkkcgRYwToNDiN9ZnzqG/eQbbYU5/fk1TROJjZ+UeEcTQS7JkcAQb8/SXkwtL/Oqx5r0gRQ89us1/wCP1aGfWzriN+Nd3lO9epOfK7lSBb5VatH8fS4WXFUEnhTLLAoFM3cJm5q+kYoPajZQlrLuJKWiVdepd/JA0bE7yvrIFlCbQ80YFSoZR9D0POao946qd4zLrsawDNMsMT9KU2D2RtL+c+O3Ie3cW7zWI2i3adCK9eKzju0Syoy/gMxnM+ZFtHODU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:33:23.3829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8f616f-edea-4f2a-5124-08de6a22262b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8053
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
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16784-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6C2F912C8E9
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

The ASO completion poll loop uses usleep_range() which can sleep much
longer than requested due to scheduler latency. Under load, we witnessed
a 20ms+ delay until the process was rescheduled, causing the jiffies
based timeout to expire while the thread is sleeping.

The original do-while loop structure (poll, sleep, check timeout) would
exit without a final poll when waking after timeout, missing a CQE that
arrived during sleep.

Restructure the loop by moving the poll into the while condition,
ensuring we always poll after sleeping, catching CQEs that arrived
during that time.

Fixes: 739cfa34518e ("net/mlx5: Make ASO poll CQ usable in atomic context")
Fixes: 7e3fce82d945 ("net/mlx5e: Overcome slow response for first macsec ASO WQE")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c     | 8 +++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
index 7819fb297280..2ab618e11aad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
@@ -188,11 +188,9 @@ mlx5e_tc_meter_modify(struct mlx5_core_dev *mdev,
 
 	/* With newer FW, the wait for the first ASO WQE is more than 2us, put the wait 10ms. */
 	expires = jiffies + msecs_to_jiffies(10);
-	do {
-		err = mlx5_aso_poll_cq(aso, true);
-		if (err)
-			usleep_range(2, 10);
-	} while (err && time_is_after_jiffies(expires));
+	while ((err = mlx5_aso_poll_cq(aso, true)) &&
+	       time_is_after_jiffies(expires))
+		usleep_range(2, 10);
 	mutex_unlock(&flow_meters->aso_lock);
 
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 528b04d4de41..2b3556fbfc42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -1412,11 +1412,9 @@ static int macsec_aso_query(struct mlx5_core_dev *mdev, struct mlx5e_macsec *mac
 
 	mlx5_aso_post_wqe(maso, false, &aso_wqe->ctrl);
 	expires = jiffies + msecs_to_jiffies(10);
-	do {
-		err = mlx5_aso_poll_cq(maso, false);
-		if (err)
-			usleep_range(2, 10);
-	} while (err && time_is_after_jiffies(expires));
+	while ((err = mlx5_aso_poll_cq(maso, false)) &&
+	       time_is_after_jiffies(expires))
+		usleep_range(2, 10);
 
 	if (err)
 		goto err_out;
-- 
2.44.0


