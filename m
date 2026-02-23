Return-Path: <linux-rdma+bounces-17075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAckJDW9nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:48:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC717D27B
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83674304396D
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5FE372B41;
	Mon, 23 Feb 2026 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ngZxw82T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340E37C0F6;
	Mon, 23 Feb 2026 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879452; cv=fail; b=BVfY9h2cq5+3B+NfpFiFXs4vApPwjFrSbX0NogVfLIK0Dlz6vV3FggMKL0uYWcbNdDjX5wjHyhGny+PehQhUch1U2S4PVNdx3t/MrSaO/qQJKujriBbMVVfdp6Tzrwu+IkZw+fOGuwvTYRLiBYB3dMd5zHcT36oungXz22O80h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879452; c=relaxed/simple;
	bh=AnTk9AV+jI2gODznUNZl4tkfVpQn1Gaf+j1ivrG+Jgs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+KvAL1kR5KN08NHea9dzNTHHh0Ylw+W/LktaRzYXbKDDD1k9apNGUv9t4XeZFXsOvLDoAs+b8F7A2iD7vk5LEYOSB5I8h/22Azt8uNafyZ+ynAomH978Xmu0mXOXE8l59a4MAoQav06IoC5Q/nCh+YVrkw/jEjCkwPnzjYpw0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ngZxw82T; arc=fail smtp.client-ip=52.101.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcDuw2EKL2Sx53TcnvV0/6nWyn3ntQbn0E8tRSJD0aF6OuMCA0eWIRhBu/eMCNeSABdtD+84OCzbQZme4a1hiA2yuAfS8ywo1UdBi1J5vImhppSVAzQvaM+Ij48+gn8R8RxqXlHEuv1KrXTMsu3eAZrDR4zZa/I6Vp4lWwp6CIINREYhEeRq3QcpVTcjMmd7piutOpVTgS+q/TrYopfwbEZ20C+y3wR0AAJ/jfPKxT5mLu8IxcULDqt0GgBXriqQ5pqiLgw2NgCj63xjSZhTe8Dz/xX/F0TQpcusqzrMgvRuOUrFCCSiKB36MxtFzeYUiWCzUURpXBq1VRs+oVh7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErYQXGmnVVr3CzrMelKCcxYE9pGjMjzGu14TVI8T9XM=;
 b=kH5PmwZielYofcjzakk3ZefATFOjWwk+ewaOglAw/26k00Z2O4fK7dhiCIp3QMO0xP1zB6ITJrgNVFtNY7EEV0Jr5dlPtaFWV1QBFKMe27rimufNMBz3PEpLSb3cn2yLFFoh0KJZD7m9Vg8H+8nnOoXv0IpJyVYdJTe5jZIIR0REKXEJ3FBvbUPqjLvGEmMtyIS1uNsOwViru5rNyu3JWDHBU9QHWRpx6kghevuAGoC46mTCxkNcNrkM/xoxtGxUHDTKkxDwbGa3IDaX7+kPa4vUVgeYbtBUpimVlFgvwLdTgpBqFlvItXCjKU3/FJSFEDnKK4BoShFgpmPAegStQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErYQXGmnVVr3CzrMelKCcxYE9pGjMjzGu14TVI8T9XM=;
 b=ngZxw82TrFFSS44FW2T/uDIFaQfniHdb+cDzUQNLZjzaY68aLb/Vvx8e+CSMOn0oZyjZNBZsfdXf02oTZR9wmRrhgmKLHos/g3X8Lbv2LSTYXNP1oyECUhXI/zXkHohMcpps1rMSa0Kl3v//QxLspAWBxntg2vP7TXy10gZrHy5yeKvQeljwTrSyWNaDbgciaR1aX9b8Za6Fob7/HaxZiSX5sAp7E50d2GVNdnaIwm4L+m+Rqc/O2fSGLI4FRQgXiohus7OWzZvZUyLRjfUIyJFBLMoh3DcTWTMJJgN+ALNL9iXoQsNqRLT7FsjnClthQdUaeU0yWEnedgthaEWQkA==
Received: from SN7PR18CA0006.namprd18.prod.outlook.com (2603:10b6:806:f3::8)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:57 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::74) by SN7PR18CA0006.outlook.office365.com
 (2603:10b6:806:f3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:42 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:36 -0800
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
Subject: [PATCH net-next 10/15] net/mlx5e: Alloc rq drop page based on calculated page_shift
Date: Mon, 23 Feb 2026 22:41:50 +0200
Message-ID: <20260223204155.1783580-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 9086bbe7-e3d0-413e-c00e-08de731c4448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ReS06sdHNhHqy8EK/12BeRWdMWbxlmCSe7GFUzyZxYuSR/CzGv0BwevtRcry?=
 =?us-ascii?Q?uyKLuvPOAdCXJD7LXOZKm7q2u5lTMqGwqpvB6VEAFoNZIZ//yP6SKNuSDmi2?=
 =?us-ascii?Q?5b+lnGmTqbScgSMgrn+3itQpPAN16zwSclHPiSC6ng4Xk7Jesirccs14NxeD?=
 =?us-ascii?Q?x7JPX+aHDnMaCcmMX+ZvWFwsjRTauEmLp6fWDGRysniI57OSoaTgWOnzZXpL?=
 =?us-ascii?Q?RSUwmMo3JHVSxU5I76J+tYeMi9E4DPjfHgbD22fAz0NVEJE9zAF+Ex2VmiRy?=
 =?us-ascii?Q?1b3Ux3yX4yONCWps0Lyg3+wS2XG7tRC5Mvj+HvuKgpw7+NfopSa4UcMbZUTP?=
 =?us-ascii?Q?q3roW2mdrm81opyRn9pXFkAb7Erjo0etz9D/6SOBCJznlX1DXvEUShFNKSqq?=
 =?us-ascii?Q?r1yIj+Q36qRTQCanNeuN3w9wSiHtFl5VE0ux2ap+NtHMFBKPLOjUyD/dhsn4?=
 =?us-ascii?Q?D3mT2UywxEKPdrbeCPNmH+iVYr/nTR7U/D6YtHa01cW4rTfUzWUSFCR9LCHx?=
 =?us-ascii?Q?1fE1NFd6dTyubWToprklq/8RCIQUD83zgsmMcvSehS4rAsyY6DLba1zUKICn?=
 =?us-ascii?Q?Q/BRh09WNaaoorKDg5EC6Pxk739Ccyf9XT7ahE29dLK4lRK2bprXeJt4ENuj?=
 =?us-ascii?Q?ferEgoFr5OHNYQJYHcTAq7MQ4z6FZT3wYY0jxwQRVEPzTqSp+FW/f6shrQf/?=
 =?us-ascii?Q?OO7px9oOCUy26zd7cFGfpalt4VB1cjKJDIXZL+6WVwHGbRUvWSvQJCEqNYRS?=
 =?us-ascii?Q?BS3BmN0CnoNoAV3y2NrIItJ8Db9LaLu2YL66OKRYA1nRciNtM5OxvSiCvFDD?=
 =?us-ascii?Q?jOh/1kiRhhlV1MNt3n9SsFSu8UpL2M35XFgSPY82Z0tVMQB7sUmFQz+fnCZ6?=
 =?us-ascii?Q?uSGAyCeDzIZEOkjmBRYMOnJ2Xw3AdNd+OumaTn0YAvCcQul46lM5ckNmZ81m?=
 =?us-ascii?Q?oSXTUQDbJqgGxcVLcJkKuYCgz/gocGa5ETgbKyWMT4/AS4thNhlDf4WDkHCQ?=
 =?us-ascii?Q?9mnMQO65i2rYlrsqMPDbG1RQsahbXEFsuh+NSuYN0I2aykbGzPqijL/hQHnt?=
 =?us-ascii?Q?6c0xdKynNzJNNXMNyQkRpHaeWzU9WRthmeQGr3gzTDfz0THfn31sQRR8M+3r?=
 =?us-ascii?Q?StthYsQwSKf8NwBW3RUp4UzrlyCfSfzRoIivDYvGyYTEoZCR243vauo4HsD+?=
 =?us-ascii?Q?TBtyh0KryEro+qVQFCCWN2hznT/fmdmUzckIRBfFeBAkpYMx0SzPm8dy/VTz?=
 =?us-ascii?Q?IPcHmLi9e/6Rc/oYt3QASBDOK2ABbvH+ojpRlq/R8a+la4y8s1umnDyFFAmS?=
 =?us-ascii?Q?Ypr3eaf7/apu6yKCQmWKEjaALJH/X882WM6qfLfCGYfNt5skAkHlWGQfW21y?=
 =?us-ascii?Q?8XJ47stazh0HBBQUZwq58XP8F2y7s7ry6+TMP0zcI+BAjx+yeeFVq09uIOuP?=
 =?us-ascii?Q?26iPUhp9S24CViO+aY2Pq5VuiiSsP8YciFjJspGWT2t+GWH9JJ7j/2dyACq8?=
 =?us-ascii?Q?uDvsjkRQyPLotffVUsA/MAn5RCCFd/QBm0qyBMFpTDHkq6kkYfCP0TDuC7b7?=
 =?us-ascii?Q?BRBTJAvJ598toGhs0KYFVlREY5ZdrwbFR62XSOFBJsHg72Od6ueqgVDsqPCQ?=
 =?us-ascii?Q?PevrklEXacJDBm+YgWAi6CGTuf3GBjPaxfZUDXLn9f/5zjsTqkmRR2Mz3qIl?=
 =?us-ascii?Q?ggrW7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MuIQ2aO4f1rfeaU/ZhmCWP4FcyF7plaUOQ6gRmBeTLHsC8YYd9sVW+wIzjRs+zbFvD5Kvrpf6n7aOhXXYcrrStRGspe6yXHL2F8AytQSGVaLz1144p1tbFDQta4oNwfBgrwac4+46OEqXRLP6dpBcsWn+5Oj1V3FATTBPsQd7od8k20zCFSUap0cC/Ayvdo6HYnWGWwqzRTtarhz0MWtqS8YQEbPRH3seywx8iVDhxybdPazngIpS3xu+wd/AnR0n4VqvPs7BodAjI3hyyzxrkpAvMDV93m46b5Su59h/T+/nLqwFTZS3a/f0Qo6MQGGvomi75dF7HC6QulMrN4asFgH/QD2FhdZA+nQUFMefprK6B3EdZLsj+iReaFN1xo+YhK2dkXf53KoaNSUEf2mStS+aYv449CzEJkUBgTy4y6ptZEQQd9oz26ryT6iu5Qa
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:57.3994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9086bbe7-e3d0-413e-c00e-08de731c4448
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17075-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 40CC717D27B
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

An upcoming patch will allow setting the page order for RX
pages to be greater than 0. Make sure that the drop page will
also be allocated with the right size when that happens.

Take extra care when calculating the drop page size to
account for page_shift < PAGE_SHIFT which can happen for xsk.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 27 ++++++++++++-------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6344dbb6335e..2d3d89707246 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -636,14 +636,18 @@ static void mlx5e_rq_timeout_work(struct work_struct *timeout_work)
 
 static int mlx5e_alloc_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
 {
-	rq->wqe_overflow.page = alloc_page(GFP_KERNEL);
+	/* xsk can have page_shift < PAGE_SHIFT */
+	u16 page_order = max_t(s16, rq->mpwqe.page_shift - PAGE_SHIFT, 0);
+	u32 page_size = BIT(PAGE_SHIFT + page_order);
+
+	rq->wqe_overflow.page = alloc_pages(GFP_KERNEL, page_order);
 	if (!rq->wqe_overflow.page)
 		return -ENOMEM;
 
 	rq->wqe_overflow.addr = dma_map_page(rq->pdev, rq->wqe_overflow.page, 0,
-					     PAGE_SIZE, rq->buff.map_dir);
+					     page_size, rq->buff.map_dir);
 	if (dma_mapping_error(rq->pdev, rq->wqe_overflow.addr)) {
-		__free_page(rq->wqe_overflow.page);
+		__free_pages(rq->wqe_overflow.page, page_order);
 		return -ENOMEM;
 	}
 	return 0;
@@ -651,9 +655,12 @@ static int mlx5e_alloc_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
 
 static void mlx5e_free_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
 {
-	 dma_unmap_page(rq->pdev, rq->wqe_overflow.addr, PAGE_SIZE,
-			rq->buff.map_dir);
-	 __free_page(rq->wqe_overflow.page);
+	u16 page_order = max_t(s16, rq->mpwqe.page_shift - PAGE_SHIFT, 0);
+	u32 page_size = BIT(PAGE_SHIFT + page_order);
+
+	dma_unmap_page(rq->pdev, rq->wqe_overflow.addr, page_size,
+		       rq->buff.map_dir);
+	 __free_pages(rq->wqe_overflow.page, page_order);
 }
 
 static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *params,
@@ -884,15 +891,15 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		if (err)
 			goto err_rq_xdp_prog;
 
-		err = mlx5e_alloc_mpwqe_rq_drop_page(rq);
-		if (err)
-			goto err_rq_wq_destroy;
-
 		rq->mpwqe.wq.db = &rq->mpwqe.wq.db[MLX5_RCV_DBR];
 
 		wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
 
 		rq->mpwqe.page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
+		err = mlx5e_alloc_mpwqe_rq_drop_page(rq);
+		if (err)
+			goto err_rq_wq_destroy;
+
 		rq->mpwqe.umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
 		rq->mpwqe.pages_per_wqe =
 			mlx5e_mpwrq_pages_per_wqe(mdev, rq->mpwqe.page_shift,
-- 
2.44.0


