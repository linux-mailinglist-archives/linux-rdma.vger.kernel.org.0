Return-Path: <linux-rdma+bounces-16785-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJoUFmytjWmz5wAAu9opvQ
	(envelope-from <linux-rdma+bounces-16785-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:37:32 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B032312C915
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 11:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFB8431B73FA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Feb 2026 10:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706232F2918;
	Thu, 12 Feb 2026 10:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b9prisZ7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7952EDD41;
	Thu, 12 Feb 2026 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770892416; cv=fail; b=WJcwRARMa8vP+GgAfinh5lmPDD/4H1Udoc5yRBTtgTzj715yNgKc2c7aAjsdAtdC45kWMdNb6QrgSAJJym3P5KHiAuMTbtRZNmyCrxJjxdoJYaSv4GwazeP+s6bCJGkP5ROvOJ+ixqR3n1I1FA9SwgcFYtB1+g0kcyqdsvLBkT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770892416; c=relaxed/simple;
	bh=o5/MkinI80hfvzCdH1uE/WS1liMIxcUafuQsAP+sR5E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qF0SUNnaaDyOggv5uPPgLwQDeShi4fMMRHnT63uc1KqMC7tcyJhHlHDPN018KFs3o+IkiLc+lWea1cwJiywkcVeLIs879MgxGgkHbfoWmnsOOoxxzz+seLx+VBtCniBu8AXzrxRbQKY+fWNt0Ii+4MV8JtRneDhSZli61KvelKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b9prisZ7; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAMwCvoOZUWSAwTOXjrIx7dyOMFwHB9iM2X8B6at1FQtI9mFRKsX5KFzJS9UuYTtGWsC0pb98UD7dSe2K2Z9gGvR2vmqRx/e6zKv5niibL+xluQytvdsB5hrqUzvY/8DmbXrzOcE8BREr56qKTFYEIs6Shja9+AAX9zt2Nsbd/6cT6azq3Q1DLrvDpn2oIkPUTNJrNlTKay341f+pkSo4601LzgMrbdH4wlBlrkfZdvcWyZ5asfTFrdIaeIRre6dj2sC1LU0QIUCi1g+D8CxtB0yM9Rvz7EtgKR8GQwNt5xpB/C0XSINfaJWW+b1PIENN0SZXflSEhH0UUK+BTSH/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S22FCv/+rraoszs43mTZvV6R7P1rdYAHmBel3iz2gXQ=;
 b=JJE5ddhzr6MUE8B4oJUGa1V5Y6WNMqEeSOASQoo6GJrueeDhiCugyM1wiiVeQan7nLo2Ve82Slb+R/Cx+tmFmR2NtEhst1bo4OMY/pOWUcggMnWv4AX9bpvZlrjbtmUL3EVWQHUPuPq0TDaC3NLb6zm7T9ACeienvi2sRUezahuxBg5AqPmqiFfIBTEtDtgqZwIv4t8G1xuCnX0OugmToFSWZxD4pL0ifykbMcPN8wxfGegatHjhtNrIQWj7LlxqWQRbIPgDb9HqwSE3AnjFyTXSNmq5SAbfQ0v0AaM7wQVHkXAi1keYqkUSTT7OOSOH+19BxhREnvFoToataWpyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S22FCv/+rraoszs43mTZvV6R7P1rdYAHmBel3iz2gXQ=;
 b=b9prisZ7MQCO6mGr/fKbxxxJXxf8aHDTu86j9tQiRWYLngAXvFtgwW+VHUrnekZyJi06XwYQ8rjJtFNPDekWvUoyvK8LFC+tdbFImRHO1VBxCm/5zze1y18mmcHhfC70rEosn1vzSvm6Jrr2XxRjRawtRkLVY2Il3H1rBmaYwq0iOMaWtQYTLkDKrPQQIOtx5HTYhgBdu5SCU+nvI4Q9RnSKLbM1T7ThZ5ABbr2Ue1wpmb0M+jwxZrCMtfdBUDkFtWe03rZun6WjEobLa/M426TFRrNLP/EcZdK9zvrzcq/EwhuHg3DrRTLyeAT0I6JuZePx8sgYwYWaJf6ObdWbcA==
Received: from CH3P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::15)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:33:26 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::be) by CH3P220CA0022.outlook.office365.com
 (2603:10b6:610:1e8::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11 via Frontend
 Transport; Thu, 12 Feb 2026 10:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 12 Feb 2026 10:33:26 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:15 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Feb
 2026 02:33:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 12
 Feb 2026 02:33:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net 5/6] net/mlx5e: Fix deadlocks between devlink and netdev instance locks
Date: Thu, 12 Feb 2026 12:32:16 +0200
Message-ID: <20260212103217.1752943-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e9e210-4555-4f9f-e6c2-08de6a22281d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fYkBXpFNXPJgQSFC22fuXOJqJV17MgMQMW0SuW1ugu4jOSK5zAFYBZI1yO4D?=
 =?us-ascii?Q?gCBx9wLVmPogV8gFe+n5Ln0qfaTZ8U13vcy2d9X6eMurlHGDD7FsM0kM7iLx?=
 =?us-ascii?Q?KpkaQ17oWozFg8VsZ8FZNrdokoYDncRp1UcVjhuFgAwZUUc0RkVRYzjcrbCw?=
 =?us-ascii?Q?IgQFt1tP8JclHO5mAkSMoJ6xAF3hKs2vJUuJeliwmeWbqksBDNtT8/cpVxCV?=
 =?us-ascii?Q?ynsGr3HTjlBcPEzr1yVuxKJdH4k+vwz/5oSk3tmd09tvYkF6qkPeIqqyAg3R?=
 =?us-ascii?Q?dMIyw7AESJ8AJJAYhoO2vm3uzfXu3SxlZbAKftJMSj567WBr43Nztfcs/MR8?=
 =?us-ascii?Q?6NX2Kr+rSt69jJ6lK2ZeT9CGs8lhwoTLuhcbL3rixS4QL71WQjJ0lICxRbjY?=
 =?us-ascii?Q?gyTzMmp9Ve9VgohOkysC/VTjc4Emkx/YVGmpVZ7LH4au/OefsSHGwQERki0E?=
 =?us-ascii?Q?uMC6ZSvy9j6uRG1kwH6wWV+w5wKeCnWlkLz6yH2f+BJK8WGnQvN0kgTsqbgV?=
 =?us-ascii?Q?oe53AHYjO+FyZgFvyEcE9fCmqXKaeiQPHjKLV/5AjstcpcnZpVUYSyaCiygt?=
 =?us-ascii?Q?rZbDFa2AHY20hFLPyQyK74ud8/jFe69F64Z8e8Nx5bTkRpd16JqKJLvJuUFy?=
 =?us-ascii?Q?EyEVrCAC660UXXnGa33/kX19y7Sp8ThpESYUblUuYLezNvG7o6vFcV1+Vq3N?=
 =?us-ascii?Q?Mk85hBrprULLm/3eDwJJcRccUliVOXhF1eKYhOdbq/qcNSk+pfcEUyRdh5fw?=
 =?us-ascii?Q?yMrqW9oErUVoXZd+bedsw50ljRf1tc06J616WjXatvsD5wuo+dInp4F68J6m?=
 =?us-ascii?Q?b1zDTBljOLn45v3f6nAQdyzANMXEO1CC9w3JnIhvRfhwFpOfUCLiYG2Kkzo9?=
 =?us-ascii?Q?fVbX8eq+xwlCXqP9F20RCHEYK5Aspi+oXgeDjYw8KX+nlHClEXxLbIKOBBV3?=
 =?us-ascii?Q?ia0rkG8B1sgvlMUoo3+nV2BGUKXiYbOSzGl9u5l/vvQEeGdZuBQY/GhG7ubD?=
 =?us-ascii?Q?+jbqdZpFx0xzoYLUvIQoOMqvhWciOs/dDPxzj8+SGQotvlx9Ew18XtyEqZbI?=
 =?us-ascii?Q?Cs8eRV0z7MXP1VwOlJrUaov4DDcdZvGrRtSHNQlk2dIohU8OZbniuiUwxdGS?=
 =?us-ascii?Q?wIC4Xp11pQ+vOeRoytbL3Zan+lnM9d0Rv+J5RUGKLbCgg7NimwghDp+yr97E?=
 =?us-ascii?Q?E64HQi9GxdZHNkHugxZlDtsOmpRz6IJNU8o1AnvvcY4i+Hp2ATMZqpW/qiRk?=
 =?us-ascii?Q?S92F6B9MEv14AqL5N0nJjMBDMw86gwhTvbd4PGjX01gxFTislV4J8u4lW4m8?=
 =?us-ascii?Q?l3nBo1VgLcmyjEP7W4jb2RBAf5/9/XuQB8EU8umnJwEshzXk+8a9yK1N2EA7?=
 =?us-ascii?Q?2Jf2SqKMdiO0YRYO8mlpBf4uCskxWSX8BvVbhGtgEV2xvS2Fvsfe7oUjt+H+?=
 =?us-ascii?Q?MHf6Obx/svAcTArX6v9EL3cv5t6fMom2fTgMf1CPAryz3FoE9cwgsC8Q8MG/?=
 =?us-ascii?Q?mp/U4EhXlh38W68OAMiFkfnsq+7Rn/YG5lPRyDe/MpSUbZ+bU8zig/PQfzSk?=
 =?us-ascii?Q?CnfPTZeI2JcPJqRf61jWJT1e+hR8NK/GH8lWTud3OszhMp1n+8nV2gC4EOa6?=
 =?us-ascii?Q?ovNVsFAOzZHykQZ1PI3Sw5rFgiuJkCBXL0rmr88Kem3+MaMet4XiR/4FXC60?=
 =?us-ascii?Q?psrOPA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JT3BPXKKf+bpqMS3z4yQpPnxUcY9ZkHVZBc+Mr96fLuHr7c7pmZOBNc4NesW0lcTtVvnkE9nUADsX6GklK+ndTQZEPXuN/uDNomirrvaHBPh+I66KpS1gnqDZ+rtULna1PL3FCTGf5cwksNC/fw7GcafoZ1fu12Jg2j+2OBCY6gb6eWIMuHFh33b1959+Y5SfJxloQp4EoWLb8mUigkbWcBpKoKvHBBT+wISK3WVvrdcp2MzvUdjkKwScbh+02QpZCsiQQpYUAM8tYJhgOXpmr9vhsyPzSW8iFE5jQFwtEV6kqX/jFafWjjhfy3rI0m8dgSDuhNj5Nhpxn/yAMXmTnxOY+J0nOQzwkVke3noMejbbDKYn1lNdgE/SGbQ8aFiwmQjXpct+TaOBwT5gvlvgQz2+0fDGBmQPWkKktjyi3jcWd1RzqgBHDXTREgf3xFs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 10:33:26.5897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e9e210-4555-4f9f-e6c2-08de6a22281d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149
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
	TAGGED_FROM(0.00)[bounces-16785-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: B032312C915
X-Rspamd-Action: no action

From: Cosmin Ratiu <cratiu@nvidia.com>

In the mentioned "Fixes" commit, various work tasks triggering devlink
health reporter recovery were switched to use netdev_trylock to protect
against concurrent tear down of the channels being recovered. But this
had the side effect of introducing potential deadlocks because of
incorrect lock ordering.

The correct lock order is described by the init flow:
probe_one -> mlx5_init_one (acquires devlink lock)
-> mlx5_init_one_devl_locked -> mlx5_register_device
-> mlx5_rescan_drivers_locked -...-> mlx5e_probe -> _mlx5e_probe
-> register_netdev (acquires rtnl lock)
-> register_netdevice (acquires netdev lock)
=> devlink lock -> rtnl lock -> netdev lock.

But in the current recovery flow, the order is wrong:
mlx5e_tx_err_cqe_work (acquires netdev lock)
-> mlx5e_reporter_tx_err_cqe -> mlx5e_health_report
-> devlink_health_report (acquires devlink lock => boom!)
-> devlink_health_reporter_recover
-> mlx5e_tx_reporter_recover -> mlx5e_tx_reporter_recover_from_ctx
-> mlx5e_tx_reporter_err_cqe_recover

The same pattern exists in:
mlx5e_reporter_rx_timeout
mlx5e_reporter_tx_ptpsq_unhealthy
mlx5e_reporter_tx_timeout

Fix these by moving the netdev_trylock calls from the work handlers
lower in the call stack, in the respective recovery functions, where
they are actually necessary.

Fixes: 8f7b00307bf1 ("net/mlx5e: Convert mlx5 netdevs to instance locking")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  | 14 -----
 .../mellanox/mlx5/core/en/reporter_rx.c       | 13 +++++
 .../mellanox/mlx5/core/en/reporter_tx.c       | 52 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 40 --------------
 4 files changed, 61 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 424f8a2728a3..74660e7fe674 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -457,22 +457,8 @@ static void mlx5e_ptpsq_unhealthy_work(struct work_struct *work)
 {
 	struct mlx5e_ptpsq *ptpsq =
 		container_of(work, struct mlx5e_ptpsq, report_unhealthy_work);
-	struct mlx5e_txqsq *sq = &ptpsq->txqsq;
-
-	/* Recovering the PTP SQ means re-enabling NAPI, which requires the
-	 * netdev instance lock. However, SQ closing has to wait for this work
-	 * task to finish while also holding the same lock. So either get the
-	 * lock or find that the SQ is no longer enabled and thus this work is
-	 * not relevant anymore.
-	 */
-	while (!netdev_trylock(sq->netdev)) {
-		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
-			return;
-		msleep(20);
-	}
 
 	mlx5e_reporter_tx_ptpsq_unhealthy(ptpsq);
-	netdev_unlock(sq->netdev);
 }
 
 static int mlx5e_ptp_open_txqsq(struct mlx5e_ptp *c, u32 tisn,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 0686fbdd5a05..6efb626b5506 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Mellanox Technologies.
 
+#include <net/netdev_lock.h>
+
 #include "health.h"
 #include "params.h"
 #include "txrx.h"
@@ -177,6 +179,16 @@ static int mlx5e_rx_reporter_timeout_recover(void *ctx)
 	rq = ctx;
 	priv = rq->priv;
 
+	/* Acquire netdev instance lock to synchronize with channel close and
+	 * reopen flows. Either successfully obtain the lock, or detect that
+	 * channels are closing for another reason, making this work no longer
+	 * necessary.
+	 */
+	while (!netdev_trylock(rq->netdev)) {
+		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &rq->priv->state))
+			return 0;
+		msleep(20);
+	}
 	mutex_lock(&priv->state_lock);
 
 	eq = rq->cq.mcq.eq;
@@ -186,6 +198,7 @@ static int mlx5e_rx_reporter_timeout_recover(void *ctx)
 		clear_bit(MLX5E_SQ_STATE_ENABLED, &rq->icosq->state);
 
 	mutex_unlock(&priv->state_lock);
+	netdev_unlock(rq->netdev);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 9e2cf191ed30..9f6454102cf7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Copyright (c) 2019 Mellanox Technologies. */
 
+#include <net/netdev_lock.h>
+
 #include "health.h"
 #include "en/ptp.h"
 #include "en/devlink.h"
@@ -78,6 +80,18 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
 	if (!test_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state))
 		return 0;
 
+	/* Recovering queues means re-enabling NAPI, which requires the netdev
+	 * instance lock. However, SQ closing flows have to wait for work tasks
+	 * to finish while also holding the netdev instance lock. So either get
+	 * the lock or find that the SQ is no longer enabled and thus this work
+	 * is not relevant anymore.
+	 */
+	while (!netdev_trylock(dev)) {
+		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
+			return 0;
+		msleep(20);
+	}
+
 	err = mlx5_core_query_sq_state(mdev, sq->sqn, &state);
 	if (err) {
 		netdev_err(dev, "Failed to query SQ 0x%x state. err = %d\n",
@@ -113,9 +127,11 @@ static int mlx5e_tx_reporter_err_cqe_recover(void *ctx)
 	else
 		mlx5e_trigger_napi_sched(sq->cq.napi);
 
+	netdev_unlock(dev);
 	return 0;
 out:
 	clear_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state);
+	netdev_unlock(dev);
 	return err;
 }
 
@@ -136,10 +152,24 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	sq = to_ctx->sq;
 	eq = sq->cq.mcq.eq;
 	priv = sq->priv;
+
+	/* Recovering the TX queues implies re-enabling NAPI, which requires
+	 * the netdev instance lock.
+	 * However, channel closing flows have to wait for this work to finish
+	 * while holding the same lock. So either get the lock or find that
+	 * channels are being closed for other reason and this work is not
+	 * relevant anymore.
+	 */
+	while (!netdev_trylock(sq->netdev)) {
+		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
+			return 0;
+		msleep(20);
+	}
+
 	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq->cq.ch_stats);
 	if (!err) {
 		to_ctx->status = 0; /* this sq recovered */
-		return err;
+		goto out;
 	}
 
 	mutex_lock(&priv->state_lock);
@@ -147,7 +177,7 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	mutex_unlock(&priv->state_lock);
 	if (!err) {
 		to_ctx->status = 1; /* all channels recovered */
-		return err;
+		goto out;
 	}
 
 	to_ctx->status = err;
@@ -155,7 +185,8 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	netdev_err(priv->netdev,
 		   "mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(%d).\n",
 		   err);
-
+out:
+	netdev_unlock(sq->netdev);
 	return err;
 }
 
@@ -172,10 +203,22 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 		return 0;
 
 	priv = ptpsq->txqsq.priv;
+	netdev = priv->netdev;
+
+	/* Recovering the PTP SQ means re-enabling NAPI, which requires the
+	 * netdev instance lock. However, SQ closing has to wait for this work
+	 * task to finish while also holding the same lock. So either get the
+	 * lock or find that the SQ is no longer enabled and thus this work is
+	 * not relevant anymore.
+	 */
+	while (!netdev_trylock(netdev)) {
+		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &ptpsq->txqsq.state))
+			return 0;
+		msleep(20);
+	}
 
 	mutex_lock(&priv->state_lock);
 	chs = &priv->channels;
-	netdev = priv->netdev;
 
 	carrier_ok = netif_carrier_ok(netdev);
 	netif_carrier_off(netdev);
@@ -192,6 +235,7 @@ static int mlx5e_tx_reporter_ptpsq_unhealthy_recover(void *ctx)
 		netif_carrier_on(netdev);
 
 	mutex_unlock(&priv->state_lock);
+	netdev_unlock(netdev);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 4b2963bbe7ff..e15e6fb4cd8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -688,19 +688,7 @@ static void mlx5e_rq_timeout_work(struct work_struct *timeout_work)
 					   struct mlx5e_rq,
 					   rx_timeout_work);
 
-	/* Acquire netdev instance lock to synchronize with channel close and
-	 * reopen flows. Either successfully obtain the lock, or detect that
-	 * channels are closing for another reason, making this work no longer
-	 * necessary.
-	 */
-	while (!netdev_trylock(rq->netdev)) {
-		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &rq->priv->state))
-			return;
-		msleep(20);
-	}
-
 	mlx5e_reporter_rx_timeout(rq);
-	netdev_unlock(rq->netdev);
 }
 
 static int mlx5e_alloc_mpwqe_rq_drop_page(struct mlx5e_rq *rq)
@@ -1997,20 +1985,7 @@ void mlx5e_tx_err_cqe_work(struct work_struct *recover_work)
 	struct mlx5e_txqsq *sq = container_of(recover_work, struct mlx5e_txqsq,
 					      recover_work);
 
-	/* Recovering queues means re-enabling NAPI, which requires the netdev
-	 * instance lock. However, SQ closing flows have to wait for work tasks
-	 * to finish while also holding the netdev instance lock. So either get
-	 * the lock or find that the SQ is no longer enabled and thus this work
-	 * is not relevant anymore.
-	 */
-	while (!netdev_trylock(sq->netdev)) {
-		if (!test_bit(MLX5E_SQ_STATE_ENABLED, &sq->state))
-			return;
-		msleep(20);
-	}
-
 	mlx5e_reporter_tx_err_cqe(sq);
-	netdev_unlock(sq->netdev);
 }
 
 static struct dim_cq_moder mlx5e_get_def_tx_moderation(u8 cq_period_mode)
@@ -5121,19 +5096,6 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 	struct net_device *netdev = priv->netdev;
 	int i;
 
-	/* Recovering the TX queues implies re-enabling NAPI, which requires
-	 * the netdev instance lock.
-	 * However, channel closing flows have to wait for this work to finish
-	 * while holding the same lock. So either get the lock or find that
-	 * channels are being closed for other reason and this work is not
-	 * relevant anymore.
-	 */
-	while (!netdev_trylock(netdev)) {
-		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
-			return;
-		msleep(20);
-	}
-
 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
 		struct netdev_queue *dev_queue =
 			netdev_get_tx_queue(netdev, i);
@@ -5146,8 +5108,6 @@ static void mlx5e_tx_timeout_work(struct work_struct *work)
 		/* break if tried to reopened channels */
 			break;
 	}
-
-	netdev_unlock(netdev);
 }
 
 static void mlx5e_tx_timeout(struct net_device *dev, unsigned int txqueue)
-- 
2.44.0


