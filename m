Return-Path: <linux-rdma+bounces-17388-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HhNJDyzpWlaEgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17388-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:56:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3BF1DC3F1
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7C0D307E864
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 15:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE77840758B;
	Mon,  2 Mar 2026 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJIiS86N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FDA59;
	Mon,  2 Mar 2026 15:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466775; cv=fail; b=MvOd/S6FUwX2wiKdRmqUDGeugr+lzHZM4zKhsZiqmYT7MBJg4YYQ2jN78c7EsRaSjR9h1uh3jGFQBiBkPUKSXWMV7tr9TDSEomeWLHSRbM7OZ5uZqx/WQQJy+QdgqwI4Hzcvv5+qwazzZFGGUCOpLSPCUstqfBiIan70ALYLy3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466775; c=relaxed/simple;
	bh=rcu2N2OwXhg1Z1tKe9dpL+3xCH0r8chgmFvxeEQ05/E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1pPh8/h+t8xTkvQQO86ObSvdqMfAUv+75wCV915p1dvXlSDjJ+NeGbx7Xh59c2WZ0gmBxj9ZdQiK+8mXHHbbftpQegcach2SVmF7yyBvIGNYKqhz8AMxzSZLa01Hm1fdNh4OHGTlVj1LSUm4mBA8eMrfSZVzZmPgJD7HYd1NqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LJIiS86N; arc=fail smtp.client-ip=52.101.56.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7KCKIQyJukvJY5w7FR07/+5pQN8/CjGA3phsi3ah4vji6K7mp8OkgwgMkXdKszib9n6T9bW1KcHiccSFVujA0VWrC7Wl69E5TJqI4y/5us6WE45RqjqdFjZMWPYNiw9N+r68Sw0/8/R0F0OMH+YzqX4Eit1TsJBiVh3Hc948jXjUqoXoXezGehPDWH7qEs+ICJK7B9doQj5fuvU1R+7uMumML0mcXAOxxsQAjlEYdvMBAuv3ADxrOYCziJEOL0YFcpfU9Vp0iJGytSA6dmw2YI97qU/EBVtzKADkbSvl/OUxQI0Itq8B++H/ma0HhmGP5Ul7V3GvwtfQvvlujg1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAR490Vxj8oXnWGubPvDRiOyIgmBT46gp9GpXKPlM0Q=;
 b=BBWhZ4hDvGVmD446Ek4Z6m5sa1NvFbuFaMtDFLEc67nKejM6mDBgjVJGQa4Is+AfWfiFisW31JQOPSx1i4loFZHCvvDXz953ON0gqkoAIVdIjVi5kHCDGABDrrDP5ytynGVeLtl97pkPqUJLBCWK5I1Tv2ehu6uNeGNIaSEXbl+iZLKXmZAbZ/yDQx73OwmisIj5BvEeCfKDB21PAjcVwaqxNf0Iq5e+bSjo9wn2DWTZ69HCRjfrdnXclzOJvJE33VN9LdROqvY8PG5jivVyqb3L5eTQG7zqp4iqdf3YeLlUWhGsDYpGAE6D8eilObNkdrK+L2Tx/jykS3TUCLneKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAR490Vxj8oXnWGubPvDRiOyIgmBT46gp9GpXKPlM0Q=;
 b=LJIiS86NbZo47wJpFLGqDgz4JI3rdM2oLgN+emc7JcWYHxvYvg0So23tL5qOGywPxys39jph9ovcom/6WXB8QGeJQyht+l6VMczL9aWXnYg/QIQI0BSmH8aQKbmLsHWTgCFUpG7pSKMlNcfzYM/GejYEQ9DPZsV86oM4mkNpRankyV7ElyWCwyGijJcweD28BCR6PJG9GWiZle3eaPSv7/bU60ODhEqFcbLeRQB99jwvYDi2W6cZ3HJBeA5KDU37JEwlhAtiANSHD8HiYDnI7pDltwIDv0OaJatw7RXFI8V9Xlnens+2VvdxgKvZvknhXvZ22aN1LpMA5mC36wRfAA==
Received: from SJ0PR05CA0017.namprd05.prod.outlook.com (2603:10b6:a03:33b::22)
 by BL1PR12MB5825.namprd12.prod.outlook.com (2603:10b6:208:394::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 15:52:47 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::de) by SJ0PR05CA0017.outlook.office365.com
 (2603:10b6:a03:33b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16 via Frontend Transport; Mon,
 2 Mar 2026 15:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 15:52:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:25 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:24 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Mar
 2026 07:52:22 -0800
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>
Subject: [PATCH iproute2-next 0/4] Introduce FRMR pools 
Date: Mon, 2 Mar 2026 17:51:56 +0200
Message-ID: <20260302155200.2611098-1-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|BL1PR12MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: b955f161-de2e-4132-ff54-08de7873bf8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	bqZvCe4DCvCyf9U/TgBqVKfI7jXgJ6XkIlT5DyrjQdK3VT+rGEUMt2sumcCM5rB+EJuYFQiYSkg7OUS4d2+EsSIRYMZf3NP3tj8Kfbb0ULvgCBXZLB8XoAdPA9f2sJY8RuAAPm0TjZPryEIDbjONpUNDAepFcue6A1lfFP4nJqXeXiKagQcQw5xzg/vweHMbGivsjL/sJrISvMan1QhUwn4JhnL0laJi1GeUyJ8sttcNkTDXo3JnVL9jF8x1f4stl307DphWCYpXS+N044bPah2snHJtqKjmYP5rWPdr6pE5k0ifwDenHm51+2x54uSnSyMzIc/y3eqVOoqc85CKJ+Nt8WmZMpFXGyJ8CsisCbO62c1UKQMEN881eAd3lwAaKWRiIha3j+KpgslZZ0G3oKCXQquWaEnrrVSpdPxbH+J8CG8lKUqEYTzlwsUdWDcfYJWjoluKhbZhfylxsBRLprw21Nl9GiGTP02zx/PYdOAWKik37Y90/P2bDMCcKC4qCLGhuH8ndueKCUkgrWI5O0z8mkx3ophJ3KQ43qxgAY9LW2txs72XpC5PbkPV9p5MMkrsdfKQm83dBeynwXXomnR1l7Z/UTHnTomNa/yNcu/z0faO84XOQ73LoLlzWmY32H350PnD32U30G7v4INhktweEeFgwxn3nNzZlWyu0G2wfY/PvIyTaraTOB7m8+IEEOI7u9lLG3ABYUiddJYgrufgn8P+/3lCNv503DRBq1Zgvg/Qp8yEZgLQrVKg8bQ5BpY+F5KyOCyvAS87d7t5lwZaJDf9gNqQXvSoTASGB2Ocr6dsHZLmx0lIQKT7jyxHQbAOb9Bs7eYCyReAlUtPWg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cr17PhNWMUV5W5J/CUUj0GvGO3W1VJNNWlK4KhzbvtjohVq46dSZxqrj/5GKQG6ljKVMEOcLXKo2FFmxdShPTxdn8kbeze/so/Y54ICxJ7NIggp+EQutbYUZQjsLXMOlrn6yBf+Cc164VA2xydEnTUjQS2K88vvw41+rs08VWCefueDU33qrBhVDw2fyKiqH5zYzUmKlsXLLOoFjjvx45FXYOC7yD1JMuTY8leiOw0qb/xWad6y4H8niFoFpzkt155txxwVEoqn3bFt6aUu2FdeTxsNhcYvB7u07qiBGY4j8YulxfbwLz0L9QYmJJglnnjkoeqOwubDSG4FMzPywwVG96ndDMxKPAYtMteECg9cP1DLZeOTizKab+hwEDwmK6p/Chv8MbllWxqEE5TPF/7CP1oJzSmoM0tfLZqLASG36DgoYrEFr2hZpkUGahR0p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:52:46.2578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b955f161-de2e-4132-ff54-08de7873bf8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5825
X-Rspamd-Queue-Id: EE3BF1DC3F1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17388-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From Michael:

This series adds support for managing Fast Registration Memory Region
(FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
pool behavior.

FRMR pools are used to cache and reuse Fast Registration Memory Region
handles to improve performance by avoiding the overhead of repeated
memory region creation and destruction. This series introduces commands
to view FRMR pool statistics and configure pool parameters such as
aging time and pinned handle count.

The 'show' command allows users to display FRMR pools created on
devices, their properties, and usage statistics. Each pool is identified
by a unique key (hex-encoded properties) for easy reference in
subsequent operations.

The aging 'set' command allows users to modify the aging time parameter,
which controls how long unused FRMR handles remain in the pool before
being released.

The pinned 'set' command allows users to configure the number of pinned
handles in a pool. Pinned handles are exempt from aging and remain
permanently available for reuse, which is useful for workloads with
predictable memory region usage patterns.

Command usage and examples are included in the commits and man pages.

Michael Guralnik (4):
  rdma: Update headers
  rdma: Add resource FRMR pools show command
  rdma: Add FRMR pools set aging command
  rdma: Add FRMR pools set pinned command

 man/man8/rdma-resource.8              |  51 +++-
 rdma/Makefile                         |   2 +-
 rdma/include/uapi/rdma/rdma_netlink.h |  22 ++
 rdma/res-frmr-pools.c                 | 342 ++++++++++++++++++++++++++
 rdma/res.c                            |  19 +-
 rdma/res.h                            |  20 ++
 6 files changed, 453 insertions(+), 3 deletions(-)
 create mode 100644 rdma/res-frmr-pools.c

-- 
2.38.1


