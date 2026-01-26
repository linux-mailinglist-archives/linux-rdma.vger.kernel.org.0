Return-Path: <linux-rdma+bounces-16009-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE23OLsUd2mHbwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16009-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:16:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A358B84BCF
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 08:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E07E30058D0
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Jan 2026 07:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637B2BEFF8;
	Mon, 26 Jan 2026 07:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CTmVw/cJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFFD2BE7B6;
	Mon, 26 Jan 2026 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769411751; cv=fail; b=QSfwVNrjmYL8SbXkf3IWl4nk95KREZcM7DqcflCiUHQwaBeu0F8ok21lFEw9wLXpzAPQXr84kQ7Xj2CK4Xm1sSSxfmPmkDxs1qSCM6JzTbLN6Nr64qguFQjXCVIfmmQERsXH5GqxayIXxfy1h3wl4DsMHbc1hqA3/pUD+FC/7cI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769411751; c=relaxed/simple;
	bh=+H9JObFHGFqyeYanJHGb8ctoNmuvvoCjqaEviMy7Ses=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H34KI8QXcpupckBnECBQoGOmG6hq8HsmvhYiQ3fQLjrD5O0X6HUYzgvzXqtC6Sw8tzIlE7xCtCO324YPgfLYYk9783YfRlh+MTE61nAiiDu5NZwXpOrHfnAgUWD2Bs5zsa5p2H4s4W0BRNQ+pikorVUohFdJ14AUsw0oUb4v16I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CTmVw/cJ; arc=fail smtp.client-ip=40.93.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb6AZf7V19RU2vThg6UBbWXJ3fur1R0qFTGEORggzRFAroCN0WqhL4jUdBrCUMd98kwkIOwhX9KkIzIYdtE/pUi5zdxhA+OQ3xJsVoaq709v5MQCRPP2akIWymj1DUGhwPBw1by/3ne1wEReAHJK+/jZnX0HjgcPyPwN8io9MyEvg6O22oin7yRq+jRTWvTan2Rr6HmXxDdqtfZ02wrKqtj4HE8MWvhzwccY+MIfyMVTJRpNSfG2uiTXDb/KT3fvGTUncbtB+77dHipsEvffxED3QO/sj8HEz/e+Hf35Ya6yah45eVm4CDQDUETq383bVO2LQxnoAZNrS+CTQyb7mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LzkAdWOaRF2iclYxB0JIsKlT49ekGlmFiULCTrp8d5Y=;
 b=LzsfB+q5WPaUVnuN0l3NUKSydYVr5QjkXvn5gJk67Ipxzo1dP0RKsJhs2e/69Qkxv9vD6CDYJS+7ESiljSE91BJyvaOhmsswIXyCY0lG6573IiUzk0/xsTRQOUM9tBPLitEv+RC1nC6N2HPOfCIqoPUroPsbtam7iQI2u8pKJnulT6k27vnreDrQ2gdew3L/f83WiwI+d4Mpdp3GkOqoPnoUtXXSTx8f5W4TEjHdlaTXrxAqAYEiBE/W5b86Zlnv6P7Wj+JSdNCeGZwyGI8TpxX/o8BXqY7GKEvu0o+swD5agQdW5LDofhu5+JGLcJDe9SlyyuLD+huE1e34/sYnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LzkAdWOaRF2iclYxB0JIsKlT49ekGlmFiULCTrp8d5Y=;
 b=CTmVw/cJSpjFEoi6oBtFRrsjxu36+M3CxnToqnmc8B5JWrbZ0HX6jddYV1fAfR56477W8Hhxcoyz5ddAenCR2jq1rGRayb0wXBdchvBhOdmSf0jPoito2Z0UdD39kipBPirxzbnlYzn8JTIEDwA5YPvL0W9bJ69yownRGNt0bE8xCkZ+MRK6sm8ApUMzDsHBhD9qwdlu4uNzAZ2fPdk3QccCp4DqwY8jrUkq2/eYMRtYhg49v3WvI06IX53dkkTgSUAu5KIcVtolv03eI1ZIzzjDcBCoBRLBUPQ4EKt3M+1UgOXk9bco8iaURiTzddrIlRH4nJFz0oeGe5TVjLBznw==
Received: from SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 07:15:43 +0000
Received: from CO1PEPF000044F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::fa) by SJ0PR13CA0036.outlook.office365.com
 (2603:10b6:a03:2c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Mon,
 26 Jan 2026 07:15:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F1.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 07:15:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 25 Jan
 2026 23:15:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 25 Jan 2026 23:15:25 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 25 Jan 2026 23:15:22 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5e: TC, delete flows only for existing peers
Date: Mon, 26 Jan 2026 09:14:54 +0200
Message-ID: <1769411695-18820-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F1:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: ee519cb3-e146-4bf7-b6df-08de5caab7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IOMYF2/EGJrCbNoUpUZtjB2AfrOZ2AtltMehbTonan9ZoyBcTjMXu54Lpg6f?=
 =?us-ascii?Q?SL+F6IHEiYPAjfZ1DB92pCOlTMYKzj99n6eKI0yS+y7A1IoEezKIfPS2GSlZ?=
 =?us-ascii?Q?/Z7sT4d7tg17I21SikhpyBFxtpPqdkemU/Jgmpcq2QVIcOWD3hMCS5EfwSnf?=
 =?us-ascii?Q?O/242k2n1FdLcyzGW69daAjFKqenYO1j3RWQafOXZDdIzGYA53NBSYl71n/C?=
 =?us-ascii?Q?23Te/TOARq58gpkdKotvNhW4xENMRMSELuxaHZX9CJ0VP/YS+lJsIAx13TTI?=
 =?us-ascii?Q?DoWIOq70R305Gv7ZCWsq8p7gNpCmp4BvEY1vGKcn3WYksGkOSw3oJd2wtJ6I?=
 =?us-ascii?Q?CGdQ9O5U7h7M4RTmBFEnqEy9qYg7zv+cm3FXfccbHod6/9fYyVl+qusAxx0c?=
 =?us-ascii?Q?zcsICvXXaGbgifW6IZfq2deVjrB8y0A850iNpfxxxHXR6c3E3FCXzjWb9wtN?=
 =?us-ascii?Q?sMhcJYqmkrJDNQk96QYScGUkqtklMWK0uqvvrgP/xxMePlr1RwSVWssLRnPo?=
 =?us-ascii?Q?ksQCeINr9oQPN/2o4dbuATXXqJBn05vLwPLrDxqtPkHN9AqUNHaR9/r9z6f/?=
 =?us-ascii?Q?oeXK9QD5M6mKI16kP3vMpApIGwDf+YA1NRhmvhreLpmLTRvnKh7g16kP9usm?=
 =?us-ascii?Q?61iXGL7arX8gvj3bGwHPGJTwg26HTbGcQ9f+2T3FtV2E9b08jHFR7W9ynq2R?=
 =?us-ascii?Q?smvAGLwmrSMhucjqebMmgIBMlwQVPCDcakD3vuKx4mqItoIJ55KLK9kikyJl?=
 =?us-ascii?Q?vQU4ZBzxtmi/DD6RsUt6tm21c4vuCnEOmMrH02MPLjpra7tWAQgKXlx3iJD6?=
 =?us-ascii?Q?dMZ5ROC2sKJkNrUNM2mHYau62K5lfDQrJyc2FzPoyD3nMJvef1tzVMu3SHDm?=
 =?us-ascii?Q?BfFK1LAMVKfQu5v+Q3HV5jz6i+NePNUoswdPQrP+3R4XMM5ujUtijimEhyiO?=
 =?us-ascii?Q?Uyn6DbrFzx+P7FP3LM9QK1eEZXW8zhcnS/nSnFwm8ElwJ5f+BSvW8dZcsWCG?=
 =?us-ascii?Q?bNmWdWVPEGG7CGbDn1NEIAJE5dOjJzILZYu4DTlnnl3RefFzUrusNMQfI/hY?=
 =?us-ascii?Q?Tw7x6M47JgZ1K2Q0+RN0PiXIpq2zl4zm013V6WN9Y9nLMTeWUNBBEBjjGPv/?=
 =?us-ascii?Q?M5ha7G9150fHUko7W8DEOWA42K4J58YExSDYKj3Nd/3+cUNIhspfESOQImSg?=
 =?us-ascii?Q?6nIKm6T8S6lFWWPIAUNJig1IeKwraV9gS0lJsax6R3Jtrgm/K4qic7Mpfj8j?=
 =?us-ascii?Q?meIY7QR1FCWEISdoBzk4j6to0bYfMix6C9m11Xdzv54+o917T8F5R8BYCyV/?=
 =?us-ascii?Q?y5Pza7ZEO3le8eK6QCf03SmTFwZqHe8rJGDUdrF9dPOGJIK06Nc3mDb/jxAL?=
 =?us-ascii?Q?lUvvrAi+NzAnfl7dc+GzPfcazD6M9pL9l1r1AzTsQ0MR6NPxM4pb1pqCFDZC?=
 =?us-ascii?Q?J/trIeANAYqEx1p4Fe6blMKFapl3lxNF/zguzXrPWRDH7kgCcNk0WxxILK5b?=
 =?us-ascii?Q?e3IM1/I7JvA/rDU78N7rkhUmrZ+juImeJnRwCHU+oBoMBMwAjg5x0Xgib3cR?=
 =?us-ascii?Q?3rfIfHdD8pK/oUONkOOTxEBw5WsV8kk0SeKPKs4ID5AxzInQxfokWKXvkQax?=
 =?us-ascii?Q?L+ZGF+JclwhwAk0Csr2OeOtAr4vpHfDOfT32pHma2Iae9ACikDfirXcmSmLD?=
 =?us-ascii?Q?CE3EpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:15:43.1737
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee519cb3-e146-4bf7-b6df-08de5caab7e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16009-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A358B84BCF
X-Rspamd-Action: no action

From: Mark Bloch <mbloch@nvidia.com>

When deleting TC steering flows, iterate only over actual devcom
peers instead of assuming all possible ports exist. This avoids
touching non-existent peers and ensures cleanup is limited to
devices the driver is currently connected to.

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 133c8a067 P4D 0
 Oops: Oops: 0002 [#1] SMP
 CPU: 19 UID: 0 PID: 2169 Comm: tc Not tainted 6.18.0+ #156 NONE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 RIP: 0010:mlx5e_tc_del_fdb_peers_flow+0xbe/0x200 [mlx5_core]
 Code: 00 00 a8 08 74 a8 49 8b 46 18 f6 c4 02 74 9f 4c 8d bf a0 12 00 00 4c 89 ff e8 0e e7 96 e1 49 8b 44 24 08 49 8b 0c 24 4c 89 ff <48> 89 41 08 48 89 08 49 89 2c 24 49 89 5c 24 08 e8 7d ce 96 e1 49
 RSP: 0018:ff11000143867528 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: dead000000000122 RCX: 0000000000000000
 RDX: ff11000143691580 RSI: ff110001026e5000 RDI: ff11000106f3d2a0
 RBP: dead000000000100 R08: 00000000000003fd R09: 0000000000000002
 R10: ff11000101c75690 R11: ff1100085faea178 R12: ff11000115f0ae78
 R13: 0000000000000000 R14: ff11000115f0a800 R15: ff11000106f3d2a0
 FS:  00007f35236bf740(0000) GS:ff110008dc809000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 0000000157a01001 CR4: 0000000000373eb0
 Call Trace:
  <TASK>
  mlx5e_tc_del_flow+0x46/0x270 [mlx5_core]
  mlx5e_flow_put+0x25/0x50 [mlx5_core]
  mlx5e_delete_flower+0x2a6/0x3e0 [mlx5_core]
  tc_setup_cb_reoffload+0x20/0x80
  fl_reoffload+0x26f/0x2f0 [cls_flower]
  ? mlx5e_tc_reoffload_flows_work+0xc0/0xc0 [mlx5_core]
  ? mlx5e_tc_reoffload_flows_work+0xc0/0xc0 [mlx5_core]
  tcf_block_playback_offloads+0x9e/0x1c0
  tcf_block_unbind+0x7b/0xd0
  tcf_block_setup+0x186/0x1d0
  tcf_block_offload_cmd.isra.0+0xef/0x130
  tcf_block_offload_unbind+0x43/0x70
  __tcf_block_put+0x85/0x160
  ingress_destroy+0x32/0x110 [sch_ingress]
  __qdisc_destroy+0x44/0x100
  qdisc_graft+0x22b/0x610
  tc_get_qdisc+0x183/0x4d0
  rtnetlink_rcv_msg+0x2d7/0x3d0
  ? rtnl_calcit.isra.0+0x100/0x100
  netlink_rcv_skb+0x53/0x100
  netlink_unicast+0x249/0x320
  ? __alloc_skb+0x102/0x1f0
  netlink_sendmsg+0x1e3/0x420
  __sock_sendmsg+0x38/0x60
  ____sys_sendmsg+0x1ef/0x230
  ? copy_msghdr_from_user+0x6c/0xa0
  ___sys_sendmsg+0x7f/0xc0
  ? ___sys_recvmsg+0x8a/0xc0
  ? __sys_sendto+0x119/0x180
  __sys_sendmsg+0x61/0xb0
  do_syscall_64+0x55/0x640
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f35238bb764
 Code: 15 b9 86 0c 00 f7 d8 64 89 02 b8 ff ff ff ff eb bf 0f 1f 44 00 00 f3 0f 1e fa 80 3d e5 08 0d 00 00 74 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 4c c3 0f 1f 00 55 48 89 e5 48 83 ec 20 89 55
 RSP: 002b:00007ffed4c35638 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 000055a2efcc75e0 RCX: 00007f35238bb764
 RDX: 0000000000000000 RSI: 00007ffed4c356a0 RDI: 0000000000000003
 RBP: 00007ffed4c35710 R08: 0000000000000010 R09: 00007f3523984b20
 R10: 0000000000000004 R11: 0000000000000202 R12: 00007ffed4c35790
 R13: 000000006947df8f R14: 000055a2efcc75e0 R15: 00007ffed4c35780

Fixes: 9be6c21fdcf8 ("net/mlx5e: Handle offloads flows per peer")
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index a8773b2342c2..424786f489ec 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2147,11 +2147,14 @@ static void mlx5e_tc_del_fdb_peer_flow(struct mlx5e_tc_flow *flow,
 
 static void mlx5e_tc_del_fdb_peers_flow(struct mlx5e_tc_flow *flow)
 {
+	struct mlx5_devcom_comp_dev *devcom;
+	struct mlx5_devcom_comp_dev *pos;
+	struct mlx5_eswitch *peer_esw;
 	int i;
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++) {
-		if (i == mlx5_get_dev_index(flow->priv->mdev))
-			continue;
+	devcom = flow->priv->mdev->priv.eswitch->devcom;
+	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
+		i = mlx5_get_dev_index(peer_esw->dev);
 		mlx5e_tc_del_fdb_peer_flow(flow, i);
 	}
 }
@@ -5513,12 +5516,16 @@ int mlx5e_tc_num_filters(struct mlx5e_priv *priv, unsigned long flags)
 
 void mlx5e_tc_clean_fdb_peer_flows(struct mlx5_eswitch *esw)
 {
+	struct mlx5_devcom_comp_dev *devcom;
+	struct mlx5_devcom_comp_dev *pos;
 	struct mlx5e_tc_flow *flow, *tmp;
+	struct mlx5_eswitch *peer_esw;
 	int i;
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++) {
-		if (i == mlx5_get_dev_index(esw->dev))
-			continue;
+	devcom = esw->devcom;
+
+	mlx5_devcom_for_each_peer_entry(devcom, peer_esw, pos) {
+		i = mlx5_get_dev_index(peer_esw->dev);
 		list_for_each_entry_safe(flow, tmp, &esw->offloads.peer_flows[i], peer[i])
 			mlx5e_tc_del_fdb_peers_flow(flow);
 	}
-- 
2.40.1


