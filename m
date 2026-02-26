Return-Path: <linux-rdma+bounces-17221-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG28CpdSoGlLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17221-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:03:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C946A1A7282
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA5131E46C4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1313AE70E;
	Thu, 26 Feb 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E42m1cfx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A343AE6EF;
	Thu, 26 Feb 2026 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113977; cv=fail; b=RgdpkOfyH+f8MSe/2Yv14gK4ENfvR8ee8LvQFFDePmiYXNZGrhdAz1vEAVhp6qJYD7tponE0BsShlUN7V3kvTpjDs4ytvOrjQztxEGSdE4iHYRShSWiuGrIHiR+JDM4L6k7jRaUKuMCObV/b998ItjluwnShEOtFxWPPXaq5X+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113977; c=relaxed/simple;
	bh=alj8gz8xmsYcbasFPKHWlLY66VUVF8Iwdg2z1R8gQr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YVaqKG1kegiF/Ksdvmxgjxo1tEcH71yFCebTEj9TnAPvwf7ijL6zuRJJddFRp1V1Zt0Sh12IBo/iz2DFbiRqxhPfR5Pf4mV/EX5J4GWCw2l10av3hko+fIT1wJMRNlUrQ9rbmqahXailpX+ieCTtXAZ8vmvU9Jt4cDFCsklYeVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E42m1cfx; arc=fail smtp.client-ip=40.107.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEsRknkfeCwcRC7Zd2JqDZlkyFRxwV7aXVzpOc6vmCqgzY9Woji0YBN6pwwiuLvE3HavHWADLJ31MCry1Uw0NGNP14wKv8avPhjY1A6VVkBTodSQUaaqB57cj1mJ1uNA9EgVQsuyquEwAQJic/fGgaG827xsGCWO88924ISBVxmmBeHDisWprRGFqNXNSSr4RwN1FHErvQ3fbGAKeXYqN5rH99oFWMfyPvgOFKrfdlAcXQKjfW4L/TUNc9XKWklabQ2eoVKBW0PNeVcRfWUJHu0Rqk0NPlzO8eFaNg77W+erFRugcXfjBaSSWJfPMXSJfR+s5lxXCyJJVkeO4bno2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wg5mIJ8BvYUJbNXbP/p+SaB1IJQCg8Ez13FzRpqmwpU=;
 b=UqRUWCX8MybPCvNHHjRsjtLHhHsWYPX+6ODnxsurcCvCl2EvU0iutEKgGgifcFtaftjk2rPaaDuh3Wd4a3g1PABDQPlb4pxhy1Y5wHBZMfQioWi2pCVr5VfTrgl5VadiTyDRSYMdwWvYXk5ahuhQ3d3nCZ3tekXCO+ZqU0Ng0963Geo8RRGU8ekMzEUgNTjGIqNyeT3BwrkqvKctvTm3Tyva80Ebhy/f2r88s7FNZL9N0PsZH4mjp4pSJ/QkYYXMfZlmXZzg82zLdKho0yjrPmTycmeRHUHIlEgqc7puQoLEXx7b1OikGNuro7bMx4k9hi5ISDiX4wXh8gcVzPZhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wg5mIJ8BvYUJbNXbP/p+SaB1IJQCg8Ez13FzRpqmwpU=;
 b=E42m1cfx6//rjcRWv16v1NavaPD9XJEyK+B3aw8HhwOtvF3ly69umcFFmZbmkkHsjaTkZ/+Ns7iNmzfhzvShlwsDZyyZC/GN+h4i1PSwGTKCqguLG4eTtdprmCTcBGmenBHI+Aa6WFqaUcF9nH92kgbziS3iV1jTypzsKImiET4ZvBU+6KHIo3fpw1bxpmN6h3d68cycOtiy4K7x+EkfGaCsvsqgyCIwWbYIHomiPsJrNfZD7dzPUz6JY0O+sLAe+svdVICM3YqWOwRO9bvfNUspGJ06hOCZpZpFzov3jf73Zdtd+OT1eTnS3VfKaDh9YnQsg/eGk7BvJK84VbRVmg==
Received: from CYXPR03CA0075.namprd03.prod.outlook.com (2603:10b6:930:d3::21)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 26 Feb
 2026 13:52:45 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::1d) by CYXPR03CA0075.outlook.office365.com
 (2603:10b6:930:d3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:52:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:31 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:31 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:27 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:07 +0200
Subject: [PATCH rdma-next v4 02/11] IB/core: Introduce FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-2-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=15398;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=PnnvUI1SvoNllX8KWtGPUsQ054HLq/ths5JRvDDyJTA=;
 b=QquA60gom/Er8n9cMgDeM0edmOZ2jcLlu+lXRuhcJngVhIp0djQ0gkiyR/Dlz8/N0bMu+jkja
 fKjFO8fx1hFCJ/Esn/Lb0noRUgZfcIn3mQQSV7NWLBT5ZK5NEbHdyXe
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c75642-1114-4159-4d86-08de753e51d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	UbEHhKUXyL8PeLfVNI1/FvHsCzVRu4obbsTKMvfoX27UcSzY5Iv6F4g5fBFyTp/lxlENbTuQaJJtQnp5WSN/e+ZC/q9FSyFGmfKSvaAuilPpD4x4pDBnX+B1CIDIbLJjofiHO/gbI0qoe7YUhuOjeNl+IlGykGX+5e3ePKrNkt9PwDvMEec6nB6+UhTNiSgB16aM4hT4SNLMbIYt12O3ZVmAeUicZ/NU9taVcACDYyNu8PTITPG5tc5Iz5wNXmI1F0I6qxf8D64Xy1oUOlWlEy0GySArO3i8A7MkQL78jqEuWgj+Lymb/EGTetAPwwq7a2N3ZL49owmQCsLzL2zSs0UwhU9snT9c7pJS12Kpxbv7uWnqW9FApqlAgqs8LbPyNSH/EWLop0rpJtrjKRvAVybBeQliUsNloSwaQuI5u81v9neOvdWAg8VOmHZAU54H84BtHNiSDMc8p1w8N6rimfP2ujZ1PYItZEzPz9AXV5FP8sFTLRdO/Dl6ggsEtlTkrcafTV0cyHmzTCgJ46ymIHKG3Xza0VhhbxRvHNA+bFHW992k1E9HDDZpMl6OfPNzGRbpj9WkgYnWmPtQY6YvLtWnj7FqaBiER3J0T3YfTqvL3ZN6MgSA3WjRpPE6zckwYPqHBOusF9agFm9jYn7QXDLY22sY5kt5MPKcLu5TlD1u5fWgsC3qSwsd8GHzz8czRP5lJC6dZklCWvkz/CkpOllpO0jq9kLTebpPlsxSi0lwSHKLSHINn9CqbvQI2tUPE1mMW91qQcYYL+ZwkZURYlQBk0EPnKLW4cu5SDmhVvwIIPvteqg60fbK2GBj+nvf/wnKafSYDg6q0dK4tzZCxZO6PDrjRKEhM1VVS4P81Tw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m30WccOQB6zXqa2Xz2JDFqpWTK9QYU1SuLs0nIFZTXW55uoym60mOGpLG7xrNlj13nAEthnOgsDxjA3P/qI0zyTfG4pYq5DQyQ0lmWwxxXBCe77LJ32hJOEXXWbcTNU9fle3LPw/SYNYTc03hA5aUjLOb3VzoZ657JUfX8WEV89TBfM00la5r/a5J4r0pAFVrOHghkjw01WfuAk0gx0C+h6yrVMEgnRgcTnsNeEEMJwibW3L7+Lmq85oBRiKCNiFs470GmPR9bVF9J5FDKt4BFCVaKGaxXtqI+9w8eejHgBWBXa6QFbFjpHr6/Qvbwm4pSDIvjRUWHuD6Cjf40JhIZqBvWUsoUh277KjJaCZFpezMmWRTiz2U1F3hIksNPr1j5eWSuD/Awj5lxhp0oon5S+WBY4EkHyNQ3m6VxzFLsDRtRZYBtH61VW4UU+XvURq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:52:45.3284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c75642-1114-4159-4d86-08de753e51d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17221-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[yishaih.nvidia.com:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C946A1A7282
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Add a generic Fast Registration Memory Region pools mechanism to allow
drivers to optimize memory registration performance.
Drivers that have the ability to reuse MRs or their underlying HW
objects can take advantage of the mechanism to keep a 'handle' for those
objects and use them upon user request.
We assume that to achieve this goal a driver and its HW should implement
a modify operation for the MRs that is able to at least clear and set the
MRs and in more advanced implementations also support changing a subset
of the MRs properties.

The mechanism is built using an RB-tree consisting of pools, each pool
represents a set of MR properties that are shared by all of the MRs
residing in the pool and are unmodifiable by the vendor driver or HW.

The exposed API from ib_core to the driver has 4 operations:
Init and cleanup - handles data structs and locks for the pools.
Push and pop - store and retrieve 'handle' for a memory registration
or deregistrations request.

The FRMR pools mechanism implements the logic to search the RB-tree for
a pool with matching properties and create a new one when needed and
requires the driver to implement creation and destruction of a 'handle'
when pool is empty or a handle is requested or is being destroyed.

Later patch will introduce Netlink API to interact with the FRMR pools
mechanism to allow users to both configure and track its usage.
A vendor wishing to configure FRMR pool without exposing it or without
exposing internal MR properties to users, should use the
kernel_vendor_key field in the pools key. This can be useful in a few
cases, e.g, when the FRMR handle has a vendor-specific un-modifiable
property that the user registering the memory might not be aware of.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/Makefile     |   2 +-
 drivers/infiniband/core/frmr_pools.c | 319 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/frmr_pools.h |  48 ++++++
 include/rdma/frmr_pools.h            |  37 ++++
 include/rdma/ib_verbs.h              |   8 +
 5 files changed, 413 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index a2a7a9d2e0d3e8b07b4c7ed8524a5723a2fe1099..bd9d09427bfecde9646ce48bd8a9913881b0adcb 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o lag.o
+				trace.o lag.o frmr_pools.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
new file mode 100644
index 0000000000000000000000000000000000000000..f2612f5a0a43105abde9e845eb7ec233a52001ed
--- /dev/null
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <linux/sort.h>
+#include <linux/spinlock.h>
+#include <rdma/ib_verbs.h>
+
+#include "frmr_pools.h"
+
+static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 handle)
+{
+	u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
+	struct frmr_handles_page *page;
+
+	if (queue->ci >= queue->num_pages * NUM_HANDLES_PER_PAGE) {
+		page = kzalloc_obj(*page, GFP_ATOMIC);
+		if (!page)
+			return -ENOMEM;
+		queue->num_pages++;
+		list_add_tail(&page->list, &queue->pages_list);
+	} else {
+		page = list_last_entry(&queue->pages_list,
+				       struct frmr_handles_page, list);
+	}
+
+	page->handles[tmp] = handle;
+	queue->ci++;
+	return 0;
+}
+
+static u32 pop_handle_from_queue_locked(struct frmr_queue *queue)
+{
+	u32 tmp = (queue->ci - 1) % NUM_HANDLES_PER_PAGE;
+	struct frmr_handles_page *page;
+	u32 handle;
+
+	page = list_last_entry(&queue->pages_list, struct frmr_handles_page,
+			       list);
+	handle = page->handles[tmp];
+	queue->ci--;
+
+	if (!tmp) {
+		list_del(&page->list);
+		queue->num_pages--;
+		kfree(page);
+	}
+
+	return handle;
+}
+
+static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
+				  struct frmr_queue *queue,
+				  struct frmr_handles_page **page, u32 *count)
+{
+	spin_lock(&pool->lock);
+	if (list_empty(&queue->pages_list)) {
+		spin_unlock(&pool->lock);
+		return false;
+	}
+
+	*page = list_first_entry(&queue->pages_list, struct frmr_handles_page,
+				 list);
+	list_del(&(*page)->list);
+	queue->num_pages--;
+
+	/* If this is the last page, count may be less than
+	 * NUM_HANDLES_PER_PAGE.
+	 */
+	if (queue->ci >= NUM_HANDLES_PER_PAGE)
+		*count = NUM_HANDLES_PER_PAGE;
+	else
+		*count = queue->ci;
+
+	queue->ci -= *count;
+	spin_unlock(&pool->lock);
+	return true;
+}
+
+static void destroy_frmr_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct frmr_handles_page *page;
+	u32 count;
+
+	while (pop_frmr_handles_page(pool, &pool->queue, &page, &count)) {
+		pools->pool_ops->destroy_frmrs(device, page->handles, count);
+		kfree(page);
+	}
+
+	kfree(pool);
+}
+
+/*
+ * Initialize the FRMR pools for a device.
+ *
+ * @device: The device to initialize the FRMR pools for.
+ * @pool_ops: The pool operations to use.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pools_init(struct ib_device *device,
+		       const struct ib_frmr_pool_ops *pool_ops)
+{
+	struct ib_frmr_pools *pools;
+
+	pools = kzalloc_obj(*pools);
+	if (!pools)
+		return -ENOMEM;
+
+	pools->rb_root = RB_ROOT;
+	rwlock_init(&pools->rb_lock);
+	pools->pool_ops = pool_ops;
+
+	device->frmr_pools = pools;
+	return 0;
+}
+EXPORT_SYMBOL(ib_frmr_pools_init);
+
+/*
+ * Clean up the FRMR pools for a device.
+ *
+ * @device: The device to clean up the FRMR pools for.
+ *
+ * Call cleanup only after all FRMR handles have been pushed back to the pool
+ * and no other FRMR operations are allowed to run in parallel.
+ * Ensuring this allows us to save synchronization overhead in pop and push
+ * operations.
+ */
+void ib_frmr_pools_cleanup(struct ib_device *device)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool, *next;
+
+	if (!pools)
+		return;
+
+	rbtree_postorder_for_each_entry_safe(pool, next, &pools->rb_root, node)
+		destroy_frmr_pool(device, pool);
+
+	kfree(pools);
+	device->frmr_pools = NULL;
+}
+EXPORT_SYMBOL(ib_frmr_pools_cleanup);
+
+static inline int compare_keys(struct ib_frmr_key *key1,
+			       struct ib_frmr_key *key2)
+{
+	int res;
+
+	res = cmp_int(key1->ats, key2->ats);
+	if (res)
+		return res;
+
+	res = cmp_int(key1->access_flags, key2->access_flags);
+	if (res)
+		return res;
+
+	res = cmp_int(key1->vendor_key, key2->vendor_key);
+	if (res)
+		return res;
+
+	res = cmp_int(key1->kernel_vendor_key, key2->kernel_vendor_key);
+	if (res)
+		return res;
+
+	/*
+	 * allow using handles that support more DMA blocks, up to twice the
+	 * requested number
+	 */
+	res = cmp_int(key1->num_dma_blocks, key2->num_dma_blocks);
+	if (res > 0) {
+		if (key1->num_dma_blocks - key2->num_dma_blocks <
+		    key2->num_dma_blocks)
+			return 0;
+	}
+
+	return res;
+}
+
+static int frmr_pool_cmp_find(const void *key, const struct rb_node *node)
+{
+	struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, node);
+
+	return compare_keys(&pool->key, (struct ib_frmr_key *)key);
+}
+
+static int frmr_pool_cmp_add(struct rb_node *new, const struct rb_node *node)
+{
+	struct ib_frmr_pool *new_pool =
+		rb_entry(new, struct ib_frmr_pool, node);
+	struct ib_frmr_pool *pool = rb_entry(node, struct ib_frmr_pool, node);
+
+	return compare_keys(&pool->key, &new_pool->key);
+}
+
+static struct ib_frmr_pool *ib_frmr_pool_find(struct ib_frmr_pools *pools,
+					      struct ib_frmr_key *key)
+{
+	struct ib_frmr_pool *pool;
+	struct rb_node *node;
+
+	/* find operation is done under read lock for performance reasons.
+	 * The case of threads failing to find the same pool and creating it
+	 * is handled by the create_frmr_pool function.
+	 */
+	read_lock(&pools->rb_lock);
+	node = rb_find(key, &pools->rb_root, frmr_pool_cmp_find);
+	pool = rb_entry_safe(node, struct ib_frmr_pool, node);
+	read_unlock(&pools->rb_lock);
+
+	return pool;
+}
+
+static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
+					     struct ib_frmr_key *key)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+	struct rb_node *existing;
+
+	pool = kzalloc_obj(*pool);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&pool->key, key, sizeof(*key));
+	INIT_LIST_HEAD(&pool->queue.pages_list);
+	spin_lock_init(&pool->lock);
+
+	write_lock(&pools->rb_lock);
+	existing = rb_find_add(&pool->node, &pools->rb_root, frmr_pool_cmp_add);
+	write_unlock(&pools->rb_lock);
+
+	/* If a different thread has already created the pool, return it.
+	 * The insert operation is done under the write lock so we are sure
+	 * that the pool is not inserted twice.
+	 */
+	if (existing) {
+		kfree(pool);
+		return rb_entry(existing, struct ib_frmr_pool, node);
+	}
+
+	return pool;
+}
+
+static int get_frmr_from_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool, struct ib_mr *mr)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	u32 handle;
+	int err;
+
+	spin_lock(&pool->lock);
+	if (pool->queue.ci == 0) {
+		spin_unlock(&pool->lock);
+		err = pools->pool_ops->create_frmrs(device, &pool->key, &handle,
+						    1);
+		if (err)
+			return err;
+	} else {
+		handle = pop_handle_from_queue_locked(&pool->queue);
+		spin_unlock(&pool->lock);
+	}
+
+	mr->frmr.pool = pool;
+	mr->frmr.handle = handle;
+
+	return 0;
+}
+
+/*
+ * Pop an FRMR handle from the pool.
+ *
+ * @device: The device to pop the FRMR handle from.
+ * @mr: The MR to pop the FRMR handle from.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+
+	WARN_ON_ONCE(!device->frmr_pools);
+	pool = ib_frmr_pool_find(pools, &mr->frmr.key);
+	if (!pool) {
+		pool = create_frmr_pool(device, &mr->frmr.key);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+	}
+
+	return get_frmr_from_pool(device, pool, mr);
+}
+EXPORT_SYMBOL(ib_frmr_pool_pop);
+
+/*
+ * Push an FRMR handle back to the pool.
+ *
+ * @device: The device to push the FRMR handle to.
+ * @mr: The MR containing the FRMR handle to push back to the pool.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
+{
+	struct ib_frmr_pool *pool = mr->frmr.pool;
+	int ret;
+
+	spin_lock(&pool->lock);
+	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+	spin_unlock(&pool->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_frmr_pool_push);
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
new file mode 100644
index 0000000000000000000000000000000000000000..5a4d03b3d86f431c3f2091dd5ab27292547c2030
--- /dev/null
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef RDMA_CORE_FRMR_POOLS_H
+#define RDMA_CORE_FRMR_POOLS_H
+
+#include <rdma/frmr_pools.h>
+#include <linux/rbtree_types.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+#include <asm/page.h>
+
+#define NUM_HANDLES_PER_PAGE \
+	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
+
+struct frmr_handles_page {
+	struct list_head list;
+	u32 handles[NUM_HANDLES_PER_PAGE];
+};
+
+/* FRMR queue holds a list of frmr_handles_page.
+ * num_pages: number of pages in the queue.
+ * ci: current index in the handles array across all pages.
+ */
+struct frmr_queue {
+	struct list_head pages_list;
+	u32 num_pages;
+	unsigned long ci;
+};
+
+struct ib_frmr_pool {
+	struct rb_node node;
+	struct ib_frmr_key key; /* Pool key */
+
+	/* Protect access to the queue */
+	spinlock_t lock;
+	struct frmr_queue queue;
+};
+
+struct ib_frmr_pools {
+	struct rb_root rb_root;
+	rwlock_t rb_lock;
+	const struct ib_frmr_pool_ops *pool_ops;
+};
+
+#endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
new file mode 100644
index 0000000000000000000000000000000000000000..da92ef4d7310c0fe0cebf937a0049f81580ad386
--- /dev/null
+++ b/include/rdma/frmr_pools.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef FRMR_POOLS_H
+#define FRMR_POOLS_H
+
+#include <linux/types.h>
+#include <asm/page.h>
+
+struct ib_device;
+struct ib_mr;
+
+struct ib_frmr_key {
+	u64 vendor_key;
+	/* A pool with non-zero kernel_vendor_key is a kernel-only pool. */
+	u64 kernel_vendor_key;
+	size_t num_dma_blocks;
+	int access_flags;
+	u8 ats:1;
+};
+
+struct ib_frmr_pool_ops {
+	int (*create_frmrs)(struct ib_device *device, struct ib_frmr_key *key,
+			    u32 *handles, u32 count);
+	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
+			      u32 count);
+};
+
+int ib_frmr_pools_init(struct ib_device *device,
+		       const struct ib_frmr_pool_ops *pool_ops);
+void ib_frmr_pools_cleanup(struct ib_device *device);
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
+int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
+
+#endif /* FRMR_POOLS_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 3f3827e1c711d8048cb58c0ef3d11caafeef8985..fa4706b0bf05fd5ccdb0e305bbd7bfffc57c5643 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -44,6 +44,7 @@
 #include <uapi/rdma/rdma_user_ioctl.h>
 #include <uapi/rdma/ib_user_ioctl_verbs.h>
 #include <linux/pci-tph.h>
+#include <rdma/frmr_pools.h>
 #include <linux/dma-buf.h>
 
 #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
@@ -1904,6 +1905,11 @@ struct ib_mr {
 	struct ib_dm      *dm;
 	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
 	struct ib_dmah *dmah;
+	struct {
+		struct ib_frmr_pool *pool;
+		struct ib_frmr_key key;
+		u32 handle;
+	} frmr;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -2907,6 +2913,8 @@ struct ib_device {
 	struct list_head subdev_list;
 
 	enum rdma_nl_name_assign_type name_assign_type;
+
+	struct ib_frmr_pools *frmr_pools;
 };
 
 static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,

-- 
2.49.0


