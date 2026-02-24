Return-Path: <linux-rdma+bounces-17121-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHcGL+mQnWlKQgQAu9opvQ
	(envelope-from <linux-rdma+bounces-17121-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:52:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC6F1869D2
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 12:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A09131D994A
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A65E3803E4;
	Tue, 24 Feb 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XyY3hJW1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F53803CF;
	Tue, 24 Feb 2026 11:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933658; cv=fail; b=MYbyB6FCcrY4it/HmuSYVlfx67/1rQdYtm4u86Nja3UC9FpxvN3oq9DWzcH0Qbz8rYdg31cL3X5I2B67XtCxRj7WkwbtZ9qqBArFixPzR6U++7OZmBnifr0Lv1/KBKc9F1FIOGOOdMN41XMR8Wk0Aw5Ew7UKh/H/oqYF5oy3TA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933658; c=relaxed/simple;
	bh=1ZBdiV7NN106jLNjJmk40WAH1ZrqjMg0pVNOsuhPv/8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/l2f74RlgNmxiU06qJo8Xil4QCGb8UWuGjn+t2EH7KXyWCgsbRmSB3Z21h43Oj5SLzxzDxruR1Po73+wpbamuFkMgQDZgJpgX4akAFQd+E9m/Ddp+ZUJcKM1EdiSe0xJz5cET9iC0Vpgfb6fNpwHV0PBPvKFzpk5YYcAXbLWtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XyY3hJW1; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbWtvZdbfQ6YC9oCRgWfDXfMlhAb4i/JFJCPfxYXg01ke8UQbhWnN/0mfnrEt4WA/ZdUBxEcOIQStduNi6lBQUabvq92VjAI8FrBsGzNg+MW460jO9YQqHKR2OiMBj4+wWRZ17zQSchw/zEV/Q3+D+yix8GNvv0HEuR4USGNIJecWlMfO1xLkHTlDv/9UIBamgDI9fMmpOQYwxoqDmflDd48SRm+aCXSPru3TtHQJe+iOJHe96Rg99vo5L2jKg6QTWXPx48J+tMEVAGQOg9sNCMOxtJtUneLujEZzWHA/dbdxPBwVjlTppikgmqct88sNa4kZ2W9o8YBLWvASTn3OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYdApdyHuC1pU4T6cfs4TftWkH/ghgRsI/nus93GAcs=;
 b=yx8VaVpSxYebTctJpYfjIEknT9bK+Pgrwiv+SyqVyhQkFSt9ME0Cx28sSBpo9LRsTq9db7tcSxGDhpofGewhW+jPTw/zyMHHEFF/0yhmHhJI9K6y1maf5f63uVCCiVTHKezFNYxtZLsL2je9o9iZBQnOBcQ8y7wOLn/AI+bOCQvgnlGvQPyq4kL9NDyCmO6CKno2d+yJ6NsDC1U0sdxISmm672V0/VDl6PocOyFpAKnpbexERCxW8HYOANuE9hFWGREspqiyQpI7WtHhCHoqeGi5O9vKxqGkA0q9jGmy6ht6dD+vP2tEHvtKg5CDGHQ6kce7AwGK4X4jTCOdIwfjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYdApdyHuC1pU4T6cfs4TftWkH/ghgRsI/nus93GAcs=;
 b=XyY3hJW1jEXjSDOEk5VaYBdOVLG/Zn5sgfaLCL6/2o199OgraKLkk5yvLoVc/1Jf4HQb0ay46SNAJMrXDXOBXui5WaUyfjnRsAxDtJCzv8YHbf18Wnig9Hk/mNfvc5cocmIOpuG3gYxIXLeziN6gLOrQw7PoT0n8OUjMtX/737WPEBUhR5fvPRwfwh5oXe757NM5sFnwV0vB4J4ANwNnWzyH7gkz45/XOyr+KqGCl4EhxsN5FjV+8bI7b58Angf7M6wMM07DTBXkoC7v8f3CfcksnBle8TzSe9nht/CDBez+o53soysC79Htx4Cvug+25yMBisN10Q7cfhAW3h+GTA==
Received: from BN0PR04CA0193.namprd04.prod.outlook.com (2603:10b6:408:e9::18)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 11:47:32 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::2e) by BN0PR04CA0193.outlook.office365.com
 (2603:10b6:408:e9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 11:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 11:47:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:18 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 03:47:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 24
 Feb 2026 03:47:13 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Alex Vesker <valex@nvidia.com>
Subject: [PATCH net 1/5] net/mlx5: DR, Fix circular locking dependency in dump
Date: Tue, 24 Feb 2026 13:46:48 +0200
Message-ID: <20260224114652.1787431-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260224114652.1787431-1-tariqt@nvidia.com>
References: <20260224114652.1787431-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ae5f96-2618-4edd-3665-08de739a7f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yb10Y7sAlfi+9wo8FiFV39fJrZogFl1zhyeHCDg3UpFzBMrUGEUiyfX10ug+?=
 =?us-ascii?Q?IuDgvm3UVtz8IYiqJggCGQa6beEyAk/VZQiIGMWL8LS/x9uE4Z9NPsLwmfyE?=
 =?us-ascii?Q?JZFUJ62OaPjroMnB/JAqY/DbrXaJOab/HeLwULUlL//ePpg9q46oqk471bV4?=
 =?us-ascii?Q?YTFUOKeoj/lJ5f+6DtOSoDzEoYIZp/23wTpqMqvi1DFsLPYr6qQtzfUJtd0x?=
 =?us-ascii?Q?B1gumYvk72Hjh3lPRYEcPPSWpyrWKH28e+k6MYJxUflxA+PGxXSiCcrDobN5?=
 =?us-ascii?Q?xvRv7Dbolin/13XD/3nY9NuV9q/PgdgswOHXcJaFUtVTePItL/+qJNR3i+VZ?=
 =?us-ascii?Q?lokquEyBYCnkn2ZrfVo0QhT9o1cQUOsWJ2TlNITekqYXWP1K/UF+5Dv6mEw+?=
 =?us-ascii?Q?OP/8sG3eNFUkoiue5Y9f6WeeD+gDoks1WI2YpHQLgh9SoGUSDyiKPqmi3Hlr?=
 =?us-ascii?Q?3fBHxn+Eu9SMOZ9XHsPGViqB/Er1FvJZeIw3rd4iMyIP/dWOmC/FXmYy8OZL?=
 =?us-ascii?Q?U8a77IxrAweldyjzgmkYmmuwDLKUvsz80WvsSnBw0fkcwlajI4LVZDwqsx/E?=
 =?us-ascii?Q?82ooXwJHPGlGPjTQf82XrOYZKqYQlMmZ9fN20OBk1FoWS+cxq7yop5vU80Qb?=
 =?us-ascii?Q?SjLWYntxOGF4M5CoFCQUg/eJ0jQMqbO+E1gfL/yeCxYMhkUcBJCSOaVpI9jH?=
 =?us-ascii?Q?JpNwVZOIkkKwAkSE3DQF5EXSN107REuVIE1sCxmSQhe7ZCQnoY/HMx4y0N3t?=
 =?us-ascii?Q?05XYtGy/KBYWFCnTd7t/VKzqkFEfSo7DvmFrJchBXFWetO3QGfR+mIrkzAIx?=
 =?us-ascii?Q?eH9b/xktbdCv51UqV1Iqq9vsQzPBQm8OWpsavNUBw043oME12KoC1KrMZgbm?=
 =?us-ascii?Q?x9xd2+2GpYDthwssIR5jZLvxV53SAbHZl4YUmev7drVjsKNcdclIv8/tBUbL?=
 =?us-ascii?Q?n6WEywGEXim1CNU4qhYUPEY8j7o3P50ud/XSQ6Yc0mDJ0CalLe76qtjvXJpj?=
 =?us-ascii?Q?PcHEuqCHQNuncSUC8OyAkzEzqyYuTy8WWakqh4gKtnqMtMExi1k04aPXiPRg?=
 =?us-ascii?Q?RCPhaKb3pBDF9RoPms1f79RXlifDUfL1qzHoBE07WIKDfbnpjHF2WjHfHfrg?=
 =?us-ascii?Q?+q3M8R4G2RyZwlOEt/1CuKkEa3H0ikzEqzoD0HLZ6iqxxRVb9gUb+oGuEzRH?=
 =?us-ascii?Q?wkn0/NFVXjjy4yzGWZlUq/q/ScGDwE2/lCcu5c7MNyNy8iTsSjhgxMJ/vVG8?=
 =?us-ascii?Q?rIz4GJHaRzClmJB73cJ1O11lRW+mlBM4Ky0BpJ8fTCf4QPdD768XjFLA7er5?=
 =?us-ascii?Q?UbWEuNVsJgtDJCX5nDK2wHYjw9Ep81iymsA5d8syAcnJpOX9Wknyndc5aywq?=
 =?us-ascii?Q?7wfSN6+GuSX0fI0Ir7Y4DFQGniVtm5Kb/QFgi5CHsKbrdG45mTk2xxlh7wz3?=
 =?us-ascii?Q?Ax/U7jtvYE4SS9bT3/b/ho5V0POap+tvPrAq3HYOwgRmWhk235IdoFq5fP+Y?=
 =?us-ascii?Q?i25LNlPuNpbFfgvvVpmMC6a51j2Du9hs13Fkbr06Kw+odA9HV7RNaewoFmTm?=
 =?us-ascii?Q?8pWUGF/HCcST5E+4oUewWXQg0CzLjw7UbKN5CYoqDlI6QrpZs48dhHFU1uwX?=
 =?us-ascii?Q?o9VF1Q5ssusd6iIY5BCUrWuIk8PNaCGwooqUjC007opQxnEoxz6piOiPW5oG?=
 =?us-ascii?Q?XZfeaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	64zS06XuQfkW9KbdJO9w0jcuU2KvLRXllU+xCQQqKWLrJnl12xBgrZR0IgRO/NCJSYXILlpdeTaZupoezq0UOXQ5sNsscstTGPiM1IO6bpJlptCiSUq6TTx7TzdMbcdP8zgPf9S/86nIfB5yJ+XTH4LNHlICQI/5ldqka6n/0mL+3ErUxYhAoO0jSYhuzmJzgGvehdgcA3ybT4+nZcN+8aTJQEkt2dJ8cpzJ4UKWZ18MrKxJtt9Q4goCMd14YhTlZbqCZFa1NUfhsq1Mw6DC/T6KzW/bBU09c6yzIOAk/Ec2ggYF9Jwc+I+VY9cb/6/7O4BZoMgve9ZHpo49cbunx79QmgJenomodMSVhNCqehQiIj/dgcZA/QFSJyy2jP3x1NGh2wkM3kQnNq2y9nfderiCqVMKNZVVBM629dq4xjFOykUoJwmi43DyX6rVx1i5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 11:47:32.5345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ae5f96-2618-4edd-3665-08de739a7f13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17121-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5CC6F1869D2
X-Rspamd-Action: no action

From: Shay Drory <shayd@nvidia.com>

Fix a circular locking dependency between dbg_mutex and the domain
rx/tx mutexes that could lead to a deadlock.

The dump path in dr_dump_domain_all() was acquiring locks in the order:
  dbg_mutex -> rx.mutex -> tx.mutex

While the table/matcher creation paths acquire locks in the order:
  rx.mutex -> tx.mutex -> dbg_mutex

This inverted lock ordering creates a circular dependency. Fix this by
changing dr_dump_domain_all() to acquire the domain lock before
dbg_mutex, matching the order used in mlx5dr_table_create() and
mlx5dr_matcher_create().

Lockdep splat:
 ======================================================
 WARNING: possible circular locking dependency detected
 6.19.0-rc6net_next_e817c4e #1 Not tainted
 ------------------------------------------------------
 sos/30721 is trying to acquire lock:
 ffff888102df5900 (&dmn->info.rx.mutex){+.+.}-{4:4}, at:
dr_dump_start+0x131/0x450 [mlx5_core]

 but task is already holding lock:
 ffff888102df5bc0 (&dmn->dump_info.dbg_mutex){+.+.}-{4:4}, at:
dr_dump_start+0x10b/0x450 [mlx5_core]

 which lock already depends on the new lock.

 the existing dependency chain (in reverse order) is:

 -> #2 (&dmn->dump_info.dbg_mutex){+.+.}-{4:4}:
        __mutex_lock+0x91/0x1060
        mlx5dr_matcher_create+0x377/0x5e0 [mlx5_core]
        mlx5_cmd_dr_create_flow_group+0x62/0xd0 [mlx5_core]
        mlx5_create_flow_group+0x113/0x1c0 [mlx5_core]
        mlx5_chains_create_prio+0x453/0x2290 [mlx5_core]
        mlx5_chains_get_table+0x2e2/0x980 [mlx5_core]
        esw_chains_create+0x1e6/0x3b0 [mlx5_core]
        esw_create_offloads_fdb_tables.cold+0x62/0x63f [mlx5_core]
        esw_offloads_enable+0x76f/0xd20 [mlx5_core]
        mlx5_eswitch_enable_locked+0x35a/0x500 [mlx5_core]
        mlx5_devlink_eswitch_mode_set+0x561/0x950 [mlx5_core]
        devlink_nl_eswitch_set_doit+0x67/0xe0
        genl_family_rcv_msg_doit+0xe0/0x130
        genl_rcv_msg+0x188/0x290
        netlink_rcv_skb+0x4b/0xf0
        genl_rcv+0x24/0x40
        netlink_unicast+0x1ed/0x2c0
        netlink_sendmsg+0x210/0x450
        __sock_sendmsg+0x38/0x60
        __sys_sendto+0x119/0x180
        __x64_sys_sendto+0x20/0x30
        do_syscall_64+0x70/0xd00
        entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #1 (&dmn->info.tx.mutex){+.+.}-{4:4}:
        __mutex_lock+0x91/0x1060
        mlx5dr_table_create+0x11d/0x530 [mlx5_core]
        mlx5_cmd_dr_create_flow_table+0x62/0x140 [mlx5_core]
        __mlx5_create_flow_table+0x46f/0x960 [mlx5_core]
        mlx5_create_flow_table+0x16/0x20 [mlx5_core]
        esw_create_offloads_fdb_tables+0x136/0x240 [mlx5_core]
        esw_offloads_enable+0x76f/0xd20 [mlx5_core]
        mlx5_eswitch_enable_locked+0x35a/0x500 [mlx5_core]
        mlx5_devlink_eswitch_mode_set+0x561/0x950 [mlx5_core]
        devlink_nl_eswitch_set_doit+0x67/0xe0
        genl_family_rcv_msg_doit+0xe0/0x130
        genl_rcv_msg+0x188/0x290
        netlink_rcv_skb+0x4b/0xf0
        genl_rcv+0x24/0x40
        netlink_unicast+0x1ed/0x2c0
        netlink_sendmsg+0x210/0x450
        __sock_sendmsg+0x38/0x60
        __sys_sendto+0x119/0x180
        __x64_sys_sendto+0x20/0x30
        do_syscall_64+0x70/0xd00
        entry_SYSCALL_64_after_hwframe+0x4b/0x53

 -> #0 (&dmn->info.rx.mutex){+.+.}-{4:4}:
        __lock_acquire+0x18b6/0x2eb0
        lock_acquire+0xd3/0x2c0
        __mutex_lock+0x91/0x1060
        dr_dump_start+0x131/0x450 [mlx5_core]
        seq_read_iter+0xe3/0x410
        seq_read+0xfb/0x130
        full_proxy_read+0x53/0x80
        vfs_read+0xba/0x330
        ksys_read+0x65/0xe0
        do_syscall_64+0x70/0xd00
        entry_SYSCALL_64_after_hwframe+0x4b/0x53

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&dmn->dump_info.dbg_mutex);
                                lock(&dmn->info.tx.mutex);
                                lock(&dmn->dump_info.dbg_mutex);
   lock(&dmn->info.rx.mutex);

                   *** DEADLOCK ***

Fixes: 9222f0b27da2 ("net/mlx5: DR, Add support for dumping steering info")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
index 8803fa071c50..18362e9c3314 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_dbg.c
@@ -1051,8 +1051,8 @@ static int dr_dump_domain_all(struct seq_file *file, struct mlx5dr_domain *dmn)
 	struct mlx5dr_table *tbl;
 	int ret;
 
-	mutex_lock(&dmn->dump_info.dbg_mutex);
 	mlx5dr_domain_lock(dmn);
+	mutex_lock(&dmn->dump_info.dbg_mutex);
 
 	ret = dr_dump_domain(file, dmn);
 	if (ret < 0)
@@ -1065,8 +1065,8 @@ static int dr_dump_domain_all(struct seq_file *file, struct mlx5dr_domain *dmn)
 	}
 
 unlock_mutex:
-	mlx5dr_domain_unlock(dmn);
 	mutex_unlock(&dmn->dump_info.dbg_mutex);
+	mlx5dr_domain_unlock(dmn);
 	return ret;
 }
 
-- 
2.44.0


