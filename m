Return-Path: <linux-rdma+bounces-16416-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF73FY+igWmJIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16416-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:23:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24C5D5ADC
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AC6F30909E9
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2215392800;
	Tue,  3 Feb 2026 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EyghfiAu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244C2FDC53;
	Tue,  3 Feb 2026 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103339; cv=fail; b=grAaF2GI3c/C7PXgQqQO5NQpk7SHnY0XYbsS+C4B3bkj0l+GMZuhub4lYYNs6I+fDFLwAM2wTe8DT0JrIkwney5SC6czDZd3ik+eOBnvEenyI4GPnGQz1DdCEz7z1P0DnauqxMcJ2gmynHerXePHWe1XlSsLMqACEQ0JJggjqY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103339; c=relaxed/simple;
	bh=Xva6TAsRFAdampMWKbjmU570Gn8wJA3YGIqkB+aaWWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TX60rjaW60FIby0WvsWNjR1j3cQW3k7GbN7cVv8TMrof4jShnOj0szC7PalAJ8+YiYTloL9BhdnlRadpcOXdfy/27nN3mEIWtnLTDqsjupR9DU3pWpyAfv8CBlURpt/5kKEHxFjJILXj86OFEdjk4fdgyjZ39Azqzo8HAWfTyNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EyghfiAu; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xgd3xq+Zy/imZIBmiaaFx7/s2PhfSQa9OLny2g7IIrPe30R/729bH1fgcV3FiIbGO4ml9GlKfJPfGQBKo4FtqOFER/eDj863qZlsd/a62kU5YEvf7/sQdzSrKQZmzrvH/ybrN3DZM664PJogAFUkpCqQajiyARH5xDLLY3Jmjv++TEmskJ0c6AqSo56EMmE742JElBRNdw4sXeQOW5TF7CUsN5GiGeO2Gu0ETVuxaJSiPEiMVrWYVBnfJKC7kBmUDGR7+1jbCz6VDWW666yRpJD00Z9XsqPE/DgIhq4GbKOHBTXP4dsqWuT+0Uinq5Om5qV21ka7R4jTCN6MWCqQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF29UUM1+iAF587z+KOYdbfuPir83YCNxwgqWFJ/UAY=;
 b=IVUQcJlEK/jjEAd2TJUk6LvkEVBiZiZlvmepHIpbH+h1nF0AnpEvcywbU1UW2uWiZPXXZW2rf8maDit1PrA+VQQXNFGdK1vFmwPLdJf5/Zf1xGrTw9mvlbt/Ycd3Q4aI8NgHUSr1nr4N7di01adrfvWit55690DY7venfJ37XNNAquCZK03CL2+8p3EXEXbuwqqk1ULzXF1M588Ilhe8ldqDj5P/vNMxKP3NSikOD0SMoLtRCPIfOp0jpkTeF/8W2111IiDJMpEUTDCmrB+dAc04e5EqQ95iaPiv/Tp22tcvYvjysNHBQli2tFV7SlvBXtOu20Rq4kWiQMhs3PDbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF29UUM1+iAF587z+KOYdbfuPir83YCNxwgqWFJ/UAY=;
 b=EyghfiAuDGQMFFoVSsdWc1wJStj7AUHZNpCjXo8UrU9Djk01JuH850EkDjxldF/Y6B7dtesSw2oR75/MLJX7LclC/qkAbIo7/0l/o+ep4OX0OoIWnjw+1lcWrYusu9NULV+yLsUZ3LWRWvvSvOOPD1XL/POBxyFAXRRgp9ZS59wbNtizamInMMsMQP66TM7hXhCX7KqplHXGMiomEslqqPWf8V+OXcXrKLH7dveKgqj8+ssjve4g+Z+gMrsRZx26eg5yiyHZL3uzT63SFtH8T8i5NfcL7ra06/XOz+M4/sFrkEYQnrWsAz+yNXF/8r1/ohhd6qdx2ba0A29JgR5SyA==
Received: from SJ0PR13CA0211.namprd13.prod.outlook.com (2603:10b6:a03:2c1::6)
 by IA0PPF44635DB8D.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Tue, 3 Feb
 2026 07:22:11 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::a6) by SJ0PR13CA0211.outlook.office365.com
 (2603:10b6:a03:2c1::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:22:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:22:02 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 23:22:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 23:21:58 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next V2 2/2] net/mlx5e: SHAMPO, Improve allocation recovery
Date: Tue, 3 Feb 2026 09:21:30 +0200
Message-ID: <20260203072130.1710255-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203072130.1710255-1-tariqt@nvidia.com>
References: <20260203072130.1710255-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|IA0PPF44635DB8D:EE_
X-MS-Office365-Filtering-Correlation-Id: f6581eb4-429d-4d36-c041-08de62f4f276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?INb+8XWj9xwRMjFHS3aIb7hvagQca6rfi3AJpiraI/eKrtTDT62R7an7fUNW?=
 =?us-ascii?Q?k9eRAi9ew9dDz6DB/DI1tQ0NBOWpJZOGz/gZwjlMLY9ignHzfam59IIWEE1P?=
 =?us-ascii?Q?p5iPRLnNv7ywv0jaudngEi9XN7Q6wgJdZ+SN2u84jECV3TFfFd/Ckq1Di9en?=
 =?us-ascii?Q?4umL0ZY9qoYDv0XJZhoJYAbrsys2Da4sqMylc2Mh5J7eGCVt4r/D7MLAl0WG?=
 =?us-ascii?Q?GKIutcg5VEZj74bbHNbeUSk69NQlcAeKtg87Hx+Gtq8KnBQ3tV78bf7q2wmC?=
 =?us-ascii?Q?Cut7L5MMfgqvvr1gTSbYvE6F5K3jaeK04PvMYuIVsjAZSfc/x39wFRsq9yBr?=
 =?us-ascii?Q?SjSdmPE63YvYe5l2cx8K3uqRp6boDgYLTXgxwveBq6Hr9+AEQVppECQhibpz?=
 =?us-ascii?Q?m730cfdYn2wXqYKeiB3ud5x8RpKEVplUVmMB/yBA6f3OUVFFYaB1lNVlPRod?=
 =?us-ascii?Q?042ua/JCPqD6ZUZ0N8dcrvP8cjblygbFTxeJe0eBfhjU9NLsXeY6rXUytE7q?=
 =?us-ascii?Q?sAxfIkXwvPJFFYpDWmmrpodCZx5Ugl/mV2GC2us7Had2pEMHXDdYPtD9tuHe?=
 =?us-ascii?Q?4yGbXgWXZymql2QG6poQVic2q/yFtFOiQHybORM9DZvTMbEbwXBFnOpwtqLw?=
 =?us-ascii?Q?I/iQ1r9m57qo3RSEJyeX7Ym6UWIcxm1ZQ85eunUsohVTwShU7Y7/y3fK3z/A?=
 =?us-ascii?Q?YJ00MZ26QMQXsqCvV4JshslfY70aCdQCVCWv0EtdjwkeMQh5zjvk9+zUmbhq?=
 =?us-ascii?Q?oClmzVcFpiLYHIs8rzNKVA8xoTrE1evvpobJoLLEcsn6lIW+I8FGDVSIAcQa?=
 =?us-ascii?Q?3sp1SRje9bDf4rlO/MP4MQVEcTJ+1N5TNOMKK+F8flEJ3GGyQ0T9PWFEJhpR?=
 =?us-ascii?Q?TSh8XUarMNTjQaERoxqd8/xDKXgyjX0zqpVivfy5yqRBkToZP8hLswFN9YPE?=
 =?us-ascii?Q?2lmIovSmSkxcLpsl+eSP9nSBvAF9NPbCYJAm7GAYJZLJrQocQQvJwBCh/E21?=
 =?us-ascii?Q?4vuEunRf02TF3oM1O3vZUgiQfDtpcwbilfuaUq/g5QIWxye/nRJbYzq/Sa8D?=
 =?us-ascii?Q?C2Xm4BPPpjoBWKMrA9wQ7yDVYkysXBWs4Rfvxwuxzh647z5PZ+koDzjAXyRh?=
 =?us-ascii?Q?FX4F6aZgxGVVO5z/b275krm6V9YnNhO+ldeXfxuZ3HlacTzOx8o1lh2IYKap?=
 =?us-ascii?Q?syTuw+Dd0EA7e3ocRtEYEQhwFkFORunxISMtvrswj6gGR6Kiel0EudQQSOr/?=
 =?us-ascii?Q?VlxaA1VNq4IwP23xxFjrj41+8uh3bLvgEPoKRm0t4m8vNtffxRvYrvOGfCMa?=
 =?us-ascii?Q?yjKWce/or5JJtElEHK1Avsu9vG4/xX/zq2/XDsqdFtms5Sc8ooCnilIfB89q?=
 =?us-ascii?Q?TBSh0a4EZJtcs4UEhMYKblNxPHchGyi8KR4YHRrrM+i2vIN4kFd9gDi9eKSU?=
 =?us-ascii?Q?YdqU6c8JeVcMnfZP+LXWu7f45O9utQWL56aBmYPBtKAN9vIhR6X0y9J/YPAW?=
 =?us-ascii?Q?wp4GYkzIo9tiX3k24n2gTJ80uPnQ4rczYvclYhvISnw4shDaPVVZEyNRHVQV?=
 =?us-ascii?Q?T3u3zuGQq3/qmDhfqBeIVtWZ5CUPQ8o6t29cfeKqkGNQbLp3G5dd0AQ0OSko?=
 =?us-ascii?Q?3RcB+IKWVMQ+x0t4FVbNOfOr8OMnO52z87pZTeTvgYNyWVGNWSC/BjwIdXdl?=
 =?us-ascii?Q?ty4i+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(30052699003)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4eEzw/NrOjPaX7gH26A7Y3YEsbU3ql0X8CEG60pzG0xQIX1EUkbzmo/GbG5osRQm2to22JRnE4ILqkR8fmLtp2LP8vUrYZMBF1y1bvmT/pp3NgWh4BeyEsCaQVuBfymHea7A221jmuYrT8HqOV/lythfQH9iskxLOjp39Sn2xqHsSk2Oli9rSyEWlYED2xzKn2bq7viwMPZwF4onB7XhnwTEm+uOhNC/Pyp4NG6Klid5gqmtcJ2xNyxZ6HCRH3UbhiARKyuwefsqWmIzEtGEIWlXVafMtWSUB6kXqYNLCMDq7gpUrcusjAeh/k4Rh/mWRJivD9lu5GEpFLZ0C6m3DR1pXauhWq7kBqgE0Afq8oVVz9tZcge7cDY8LgOj9gSecscm41fed7Ql0Yc7TUMtV2A1Z2gaYCKhKJEdijRfY+hga4Lo/7prX9bx1XIGc1tc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:22:11.2278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6581eb4-429d-4d36-c041-08de62f4f276
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF44635DB8D
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16416-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A24C5D5ADC
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

When memory providers are used, there is a disconnect between the
page_pool size and the available memory in the provider. This means
that the page_pool can run out of memory if the user didn't provision
a large enough buffer.

Under these conditions, mlx5 gets stuck trying to allocate new
buffers without being able to release existing buffers. This happens due
to the optimization introduced in commit 4c2a13236807
("net/mlx5e: RX, Defer page release in striding rq for better recycling")
which delays WQE releases to increase the chance of page_pool direct
recycling. The optimization was developed before memory providers
existed and this circumstance was not considered.

This patch unblocks the queue by reclaiming pages from WQEs that can be
freed and doing a one-shot retry. A WQE can be freed when:
1) All its strides have been consumed (WQE is no longer in linked list).
2) The WQE pages/netmems have not been previously released.

This reclaim mechanism is useful for regular pages as well.

Note that provisioning memory that can't fill even one MPWQE (64
4K pages) will still render the queue unusable. Same when
the application doesn't release its buffers for various reasons.
Or a combination of the two: a very small buffer is provisioned,
application releases buffers in bulk, bulk size never reached
=> queue is stuck.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 26 +++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 05b682327305..849e1f16482a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1087,11 +1087,24 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 	return i;
 }
 
+static void mlx5e_reclaim_mpwqe_pages(struct mlx5e_rq *rq, int head,
+				      int reclaim)
+{
+	struct mlx5_wq_ll *wq = &rq->mpwqe.wq;
+
+	for (int i = 0; i < reclaim; i++) {
+		head = mlx5_wq_ll_get_wqe_next_ix(wq, head);
+
+		mlx5e_dealloc_rx_mpwqe(rq, head);
+	}
+}
+
 INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 {
 	struct mlx5_wq_ll *wq = &rq->mpwqe.wq;
 	u8  umr_completed = rq->mpwqe.umr_completed;
 	struct mlx5e_icosq *sq = rq->icosq;
+	bool reclaimed = false;
 	int alloc_err = 0;
 	u8  missing, i;
 	u16 head;
@@ -1126,11 +1139,20 @@ INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 		/* Deferred free for better page pool cache usage. */
 		mlx5e_free_rx_mpwqe(rq, wi);
 
+retry:
 		alloc_err = rq->xsk_pool ? mlx5e_xsk_alloc_rx_mpwqe(rq, head) :
 					   mlx5e_alloc_rx_mpwqe(rq, head);
+		if (unlikely(alloc_err)) {
+			int reclaim = i - 1;
 
-		if (unlikely(alloc_err))
-			break;
+			if (reclaimed || !reclaim)
+				break;
+
+			mlx5e_reclaim_mpwqe_pages(rq, head, reclaim);
+			reclaimed = true;
+
+			goto retry;
+		}
 		head = mlx5_wq_ll_get_wqe_next_ix(wq, head);
 	} while (--i);
 
-- 
2.44.0


