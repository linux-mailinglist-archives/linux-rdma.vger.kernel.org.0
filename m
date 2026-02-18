Return-Path: <linux-rdma+bounces-16987-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBPwGRNrlWkzQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16987-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:32:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D522C153B39
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4089730692DE
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 07:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DCA31062D;
	Wed, 18 Feb 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K2OskCcq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF83101DC;
	Wed, 18 Feb 2026 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399797; cv=fail; b=lcNhVeDUU2XbLdxOGibXSJvhFHZ0VIUJinaPmxQlQ6Kgijz9gXNr7b22RM+NodY3+bKUGrArlFU5+YR5yUYhnbRPffRs54swwf2GSsiLY6Jhunm73SEHZFMibfUn+K7gCaDw85qkHe5UOHNoEe+uRrCjIPykxN1TNt+M0k0Vmag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399797; c=relaxed/simple;
	bh=ZDCkElM5JKGC7OZJ7hl6InM+4Cm8UDUFK1BIdqMb324=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9iWIRZYkxqckm3xS8B1LzvYys0A6iAYlfpNVZ7QTx4WrNIaX+S6m8bZ0l1tyEg6iqhf0nVUopHbwhVEnq0IoHSk6l1FKkLvBriuLezoHTGh+vZj5T3lXjBgjcRgJYmAnIaIXZbr7k4O+b+ayk5SloA08FNjQXMBIeMNAUKtwNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K2OskCcq; arc=fail smtp.client-ip=52.101.61.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rq3FxURRgPTyxkhYQyIr4tpsAmmDDhioa0LqOlWz4QxZT2caRX2uFvHGYrhMD437YZD6l3jFITcPwrrD43UwcMgC5EnzmT4FUqBQHB6c9Shmn/LiuJZNuRja6VZWxF1VynFiR53g0jVlTCoTiBxHO+DTEz/7KIGENSFsFWd1I/AFk6K2UxLyl/j4lbdZL9Fe09VVc+8ZkvbXEjv4vq/Klrg4SmlsP2sC+aPiWA4ISyHSwS14e01LMvplGQnCsbLEUFqo6X2RMZcpUwSwatn7xRyg0/NtlRjCcA+a2nptaEfoo4DqVLoUmYbn1UWVYtzYw+zCcRR+3tBxhHqQ3dw2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp0tZ213Hqo/njx71Ex0A0t2suIWp7pGwrNGOQmLmDM=;
 b=sxMyHSHssemdrJtgxz4dD/C1TgkbmL6XHOl4GdJJfwGDLt4k4+a6H1Od6pQznDFe54MU1Sk/84gJ022kp1gVlzsLfvejgcumH56ub5vE06Kdyf48FF/dI5fOxwDC1zs6uMnFjRB284q6iQRPpOofvr5dNZ1U/50KjxNjKsZj9tGxlzoOZkjSu9/8X9DhXt87gJDbKp1gPDzZVR4jufrYC3rqXGfhQG5PGjEdzsjqUQeDIflhazH+tVDSENHep5595YEydlOpQ6r0jSdWza2+3MMjfZfTkkThaZfQ8j2sopz8qkUzYJVH33BJ+U8yyKCC2cWml3zx7TyIRd07hcpptQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp0tZ213Hqo/njx71Ex0A0t2suIWp7pGwrNGOQmLmDM=;
 b=K2OskCcqlrxWo2FuHCv8e80jzXuUUdIz4Ai/Xngbb2NhUTTLQTgbOsg4fks8J1evdXGXd8LEtL/towQXOI6UtsIgQBVr19hy6R+i4/K9AhP6uKwVEO6EcKtEEtwcp+CuuaTDvmReEQbhUvwUzfLlq/IHxKbtZsvGYXdYqCOLWy7DmfQk3dWFBodwupJ0etoQ+dnQQpdrfzivrNjhham/1q+ma5WGa4LOJpUJmcYXuIDUtlYptuTtVfjWKrj+aQLhbDdm/76AYieFDpZ8buhdBk/N7T5T/kDE7pxBMlYpuJKfOR7UfsueW22MljKkhhsYkP8lmwkuRntWGZvyQwkCOA==
Received: from CH0PR03CA0042.namprd03.prod.outlook.com (2603:10b6:610:b3::17)
 by BN7PPFFC4F04B28.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6ea) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 18 Feb
 2026 07:29:49 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::4f) by CH0PR03CA0042.outlook.office365.com
 (2603:10b6:610:b3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.14 via Frontend Transport; Wed,
 18 Feb 2026 07:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 07:29:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Feb 2026 23:29:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net V2 3/6] net/mlx5: Fix misidentification of write combining CQE during poll loop
Date: Wed, 18 Feb 2026 09:29:01 +0200
Message-ID: <20260218072904.1764634-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|BN7PPFFC4F04B28:EE_
X-MS-Office365-Filtering-Correlation-Id: 805a9d70-1980-4d42-b2ad-08de6ebf7fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WnZrod0Z/Eot+U8B/sLcEmca+p/ShEnPCgxMprD/fBz4t0/bcUpJpzCeSf8k?=
 =?us-ascii?Q?40HoT6267+T3xNJ7/uZWI4Tg4994XLY+SvSOzYrQiC3yFuI2Lo/vA/8Qw0wU?=
 =?us-ascii?Q?Vl0EW+qvvy9cB4XicHTwza37tHzjBbeACheSrQ6UvDn6hPIRU+Lup7/jsDKH?=
 =?us-ascii?Q?DtEo3qjhgrX1c8Voiv4OHCndI+mwLj8J8p5+0V9BVgqKWzyUwPXyUdNB06Jg?=
 =?us-ascii?Q?oLzu6IXLKFMbmza3bpi0vzZCUfz0QZRRHBTjTszPajc11RSHs/xRTR0kQKc8?=
 =?us-ascii?Q?2+pG3HxZeOJfENBJ9KI74VWa8oZHK/RWNODQEtKPyZ4qZyUVK6pdBx8fSW84?=
 =?us-ascii?Q?XrdUu39JRaFBz6iomK4sub34ERPFQ8gSza5BTc5glgOyWG4tbcPJQJ81EaH9?=
 =?us-ascii?Q?Ym1RXYDjC081ZpnsG52PLgGtbWKgYfg0onE4hqsWlKjFD5pdsU+pWK8+xNFA?=
 =?us-ascii?Q?bA026mp87NoombheCXyoQnxmIRWycOR8ogQtzc4D2GgojcxyDErJDsPpdBQo?=
 =?us-ascii?Q?0CdvbpOpsTquyvM6y6IwR8m9BPreiE/NBvV+sO+ntxpg6N8m7912EVVbjgFx?=
 =?us-ascii?Q?dQalqb70AApJ8SS58KrpZv5YnhhN3tA6BJUoLnKGxId6XMX3XR95gCfVNcjM?=
 =?us-ascii?Q?m2k3vznvc06fAIcMy/N4UkW5XaRcKD7i8te3ALQdsj5BXOVkS2+DcPTVRDwV?=
 =?us-ascii?Q?zGuScuEVL/LBe+Ro9esbFqEB/6rkGUzIZQIY/muLLHtcRUPfNXo24fcTjHgC?=
 =?us-ascii?Q?zje6h+qSoqv1xxyI/2wW68bepYwoa7xTRMW6s9bF/x3Cay8vV7kx+JVtW8mD?=
 =?us-ascii?Q?OdVNDp75sVRX5HpqLkQg45CeYpijp7OCvV6Bek+rbonbWuQJ15X5v9aea0oG?=
 =?us-ascii?Q?AJ7TQPAKVu/c5noELMan8tKdzDn7ZayT/KEHH2jG6NRrHsRlf+8c6l0Qlu8p?=
 =?us-ascii?Q?AmI4wLoEL95HBQGGjAD6dQm+VBS6fikph/554vMqW+AbvETm9e8XKeyvgZDU?=
 =?us-ascii?Q?A/r0R/b2b+r3XfLC6sgHYfDOteoEO6WT4dT/1OOcuY9jJ5O5OE9vLii7Hcsw?=
 =?us-ascii?Q?vz4lyJYtnjZDTG0FY31p3L/tc6q+vW2zSsInENu1ytybwx9aNA8iRZAny2ir?=
 =?us-ascii?Q?rMrT8cahjd/ud6ctAcFYLZZ+cHl25rQ3c5cn5rHezleAaLJhZ9V//0Sz19C2?=
 =?us-ascii?Q?pWUwafYARetG15mZyw+M02cNqK8zUnEFnW+jmD8JuJ5V5eR7xgwfBOkTzrZ0?=
 =?us-ascii?Q?+ATQA7+JKWR20PkV/DJlJWoUv+oQwVATCHxAiaiAaFs8Zcr2MfO0AaLN2mz9?=
 =?us-ascii?Q?GrZFfr4zW4MgpzDcBuXb7fhzpwTDvUE72joRjBj5SYeYjkt65sHVL1tFMEaD?=
 =?us-ascii?Q?lIioMohbQsts69mJ872Ss4XkqcN+GuIU2FEZda/hL8xaz4kWO/x036hE5lvW?=
 =?us-ascii?Q?k9C2Qp1PwSoX/9bhD9MpNkk1VhyH/rgb3sNv+nAjPTGctqQwWHBQp7HndSZC?=
 =?us-ascii?Q?41+BmPfe7vKCkgNUcKbZZbbbBEzyXw/ruAY5Fg5BLpN3oqJcS/uNNiMOtvfK?=
 =?us-ascii?Q?2Xvcuj2LgfWOgndiI3BjbPIcj/d5T0cFUud18o09w8Qvvxy31w/jmwELxCv8?=
 =?us-ascii?Q?sTX7N1lF2OV3l8vNv2a87R0U/heQQ3jj9A6fkRdWw6n7/Xch1uG48Oo+fXv+?=
 =?us-ascii?Q?8yn4xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+0lfiZguQPrWEul7GfaIghaehKQ8NVDwGrdnHfZjk/oF036FUXfFl5r6/dGa2BJKKtZbXFESu3jGATogg+T+cBFzAbnTWMY6NO5DTjyAnk9GSJgTsUJqTjGV+ZMYG9DzoGE5qJ9h0yRZ+FVRoWq/tbN8j3FNDtXJrKG9L5yYmY4vUmw16hUQ8y/jlduI9Z0yCGKkWeHdGqzBnI+feZl0H7bVte1XYbQJ+7OQaNm9boPzSSGN6ZQae2m/rhze/LVHXULQMW01CXdNokfZIFx0ShQGi5GuChVKdEFX/eniyIUAZmiy4mAqsjTLXN73ORa6cbUCKs9IUqrZAqFcNSeM7On6LFyMv1jp9R/W6ELNTKuiTNQe0XzCpWSDkoMFT90gA3zg+eKpdZ2O/KZ4RC/kIT9cr9Eicf7UNJC038YpZnNhG4jqJZoRPG54UbWgfy40
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:29:49.5328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805a9d70-1980-4d42-b2ad-08de6ebf7fe7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFFC4F04B28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16987-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D522C153B39
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

The write combining completion poll loop uses usleep_range() which can
sleep much longer than requested due to scheduler latency. Under load,
we witnessed a 20ms+ delay until the process was rescheduled, causing
the jiffies based timeout to expire while the thread is sleeping.

The original do-while loop structure (poll, sleep, check timeout) would
exit without a final poll when waking after timeout, missing a CQE that
arrived during sleep.

Instead of the open-coded while loop, use the kernel's poll_timeout_us()
which always performs an additional check after the sleep expiration,
and is less error-prone.

Note: poll_timeout_us() doesn't accept a sleep range, by passing 10
sleep_us the sleep range effectively changes from 2-10 to 3-10 usecs.

Fixes: d98995b4bf98 ("net/mlx5: Reimplement write combining test")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 815a7c97d6b0..04d03be1bb77 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/mlx5/transobj.h>
 #include "lib/clock.h"
 #include "mlx5_core.h"
@@ -15,7 +16,7 @@
 #define TEST_WC_NUM_WQES 255
 #define TEST_WC_LOG_CQ_SZ (order_base_2(TEST_WC_NUM_WQES))
 #define TEST_WC_SQ_LOG_WQ_SZ TEST_WC_LOG_CQ_SZ
-#define TEST_WC_POLLING_MAX_TIME_JIFFIES msecs_to_jiffies(100)
+#define TEST_WC_POLLING_MAX_TIME_USEC (100 * USEC_PER_MSEC)
 
 struct mlx5_wc_cq {
 	/* data path - accessed per cqe */
@@ -359,7 +360,6 @@ static int mlx5_wc_poll_cq(struct mlx5_wc_sq *sq)
 static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 {
 	unsigned int offset = 0;
-	unsigned long expires;
 	struct mlx5_wc_sq *sq;
 	int i, err;
 
@@ -389,13 +389,9 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 
 	mlx5_wc_post_nop(sq, &offset, true);
 
-	expires = jiffies + TEST_WC_POLLING_MAX_TIME_JIFFIES;
-	do {
-		err = mlx5_wc_poll_cq(sq);
-		if (err)
-			usleep_range(2, 10);
-	} while (mdev->wc_state == MLX5_WC_STATE_UNINITIALIZED &&
-		 time_is_after_jiffies(expires));
+	poll_timeout_us(mlx5_wc_poll_cq(sq),
+			mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED, 10,
+			TEST_WC_POLLING_MAX_TIME_USEC, false);
 
 	mlx5_wc_destroy_sq(sq);
 
-- 
2.44.0


