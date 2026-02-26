Return-Path: <linux-rdma+bounces-17229-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIyUH2JVoGlLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17229-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:14:58 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C696B1A74E1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 695D232185FF
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A583D3D04;
	Thu, 26 Feb 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CgpXvbrj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0160F3BFE3F;
	Thu, 26 Feb 2026 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772114008; cv=fail; b=QrmUZv/5up8bhQT9IawoQPSP9kxhZ4yyyjR+LLjq0a/73zWBYjSeaaWxvGVZ0Rdj0QIYg1u1+3rPAGPxPHlk3uYPttJptfWRlLi6o1eKTMB+5ahfc8oS7vmzsVmvf6QnvlVSfXeuKzWWv8UKB6qu/xYNtj7zWtXD44eekNM9ZBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772114008; c=relaxed/simple;
	bh=IH7ZzJNncTdpTKoD9WPmbhw/KN2okI0wyMhtpc0cSc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XOvmVmyWnZxZojl4twJD6IwEvM+dqIt4ujUnMTxHk5u7gmPniRajM1mZ9VI3s08drJ/JhkoLwlgFJcXWXV4k55OJBFiOG9ybm/fKml4CrGldKlsxzfkQ4wNsofyJ4BVSsCVeBHjDYfp3KpiKtTTA7v7iDpHayJX2HqRmzpQnRrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CgpXvbrj; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCmIMekUA1h3Y0vdazOaLb5JAigyxtdqdRbOa++c9T1T+6gEkEOrh8qNVeqI3zzonxVODmxr+2xUe/VdmPmZZ9jZWf/nhx7CrB+ZsdT1L9UxugNkqlA2Hn/uLgPbynn/UnUwgMTUJauTt+abNlXwAAPgXU+gDCFLQ7kmOc/hYac20IQiAQEXCX5phF7e5IIvIgl100Rp5Qm3srmxI/RSmA6pZkparc9PzqT9tpqOCF4jiMNmoGCkGCuDSGQKemsrwqMAW1A40UizDdg4dWxwetWoysW3uA2L7Jo56+EWOuGQv94ANg4arHLLGuaK/BKRwRVlmtq6NZMooz27QQPFJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GE1umpjQYtmCkRvaeLC4wq07Asx/GcPVf41v6YJwd/w=;
 b=lIDlJlu479mB6CJlWryiP9pb5k5aYdKs5YFdw0pIuF+gnvtabwCqm0e6GE5z/XYQ0q9ZJP2LC2fHlfeXtxH7s++kbxvuv3YyKdIJhilp7T29lLqM0ySNsXl5yCHXdM/BmRhpZA/5RBcWfnZ8ORumU6KccOtm9l7e+VK3HvBbTXcBcfzPnklSBxpoKvJdYwjNP/dj5ku+/+FpAfvEMvUK65LibxMvcW8Yl9K++QlltJm3DAsXxr9aOk8p/2E3xqmv7kNw4OpcjGSsyA+tGxMPdv5JN0vPkrGj5lvGSbLhnPS5ZVqXUdkYUxSMMga/u5gPTBR04ch3RHQujtg1COYwcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GE1umpjQYtmCkRvaeLC4wq07Asx/GcPVf41v6YJwd/w=;
 b=CgpXvbrjIfu7wzID7LLz0mM28NamWMkBeilF7N1Ogux9+LvfkN4MRIoClIV+usJaYMwFXtY48V7hIaicnCI1NBvc8uabkLA7KC9xWMgTYm68aOpwD5G3iBjfoDbRRxQAYQtML6v5SnnXE8k5Qq7AAcHwz7Uobc64U0Yfm+5l/v+qD2mIejqu+4n1HmjLhSLUM7tIRc+4RuXgPl7BA1ETE9G8G2zB813p+FH0piRDQ/35iPLUswiTdOp056HffxJVm18M8yZWiQ54bwfYn0GmqQjqrRajpFDXjtxtsMLVckC0u4q96e3xdo76qB3TAe6TkjNMhzHxbb5jvhfMVKR9rg==
Received: from PH2PEPF0000384E.namprd17.prod.outlook.com (2603:10b6:518:1::6f)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 13:53:19 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH2PEPF0000384E.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Thu,
 26 Feb 2026 13:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:53:19 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:53:07 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:53:06 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:53:03 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:16 +0200
Subject: [PATCH rdma-next v4 11/11] RDMA/nldev: Expose kernel-internal FRMR
 pools in netlink
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-11-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=4433;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=U2BznfWeSMeLyFDgCPdq9zZyWcQcAmns5s62Yj1T6Mc=;
 b=kZA9Fq4+J/YEwb4NiSb+9nt1tzJoKhv/BAcOdjlEMjCkbEHmLJOfNtS+QZCNUCJwl810udwIc
 onvtIgDGCfxAcjmj4l7O/dYeXWI+u/vmTxPTph5jbZl6X2BkoqyFbxv
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: d28b29b4-b68d-44ae-c492-08de753e6611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	QX4FsJJw24oZf5bpEgWMT70A3xRvflsp2c+accg9S61lMvYapa5GYXNt2g5RCAXtufbNFpmpa4SrY1wPx6ZWvFusE6c7Dr3hqbIR4hkpf7PnAXEOLiXWdfjEXg6YAjIYcQewUfNiE+twp6HhBNJvXUPU7O3UUKHIwzs9+0jpZtqRopSsRcSwDQ2eddMaQFis0aCObrl07iOz2ibeXLIsTWFHr6NLR+k+O6AgM/XoYuZlmh1vtIrQ9WnNKJ1x6EXXgZm+LN7cPH1czxRWfTzjlqPsLnMC6ZTO1y00PoBznd3ZO8qY5byudzMyk9TeVRB0TgyILxBCRzKvxzqLopInONi5effPE7KZWkciPwwKxOGbQXiK41DdwJH0XQZbNvTKqukKiOg7NQu979wU2f8yFiGv0DC88GAM2dq/k9heAGFBGswLuw5YB7qf9vGhKiZ3jezzkZ6kdKY+4ZxwekOE4EdWfaFfxYKqGmYaQ3spwEWOUuTQDXe/0G9VfqZbdKA/ewjkKId45vCnFSaRTgefEgx97jK+v0o+nTq+PccPjGPEwUmlHwGd7HExv1wwV1ID/jCYMc+8sh5apv848mgdBCy7pDv3ZHHOCnxUgqKwvzdv0oScGALMVd+8kSnT20w425QbnbV/FruYkyCBY3kvZcnL/2dlvu9rYSULY6PacsWt1JqQW81mxtgn6DTyLIudC0oUWX/t8rv7loHLBtR6x1/x8D9eEbuy8R01TiwtHK3kHVLM8CSCHlFdoEtRwNH+h3Brjw+LABbENAvWyZi/r9jwxs8XPilIPKxzHX8hAZvyWziF6rffQIJihr2fBoT4Ji/rcvii0RIG9E9O3Zahclgd4uSGPjb2ybiuzPJ8ieA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TWXcOJJ+9vMBPf8ugjyfDjSQ6HcUTIxZV0cwcGU9gVVK1uNiipEse0ozu3gjiYPDxAFlXLZ8AaWx+fBS2PSppza/Dx58StEhNXYKmjmk1EekC/ZfMY2wUUbt0M9B/bY+zYghnOAuiTLNOgnBEVI14skKqJbtvwYtW8oPmRI1F+Q57qc09oAsm79hPQ2IrTElmVGgzrkxA/a4A7DNiiX0ZheO2MMHn4P82xwW9/QtfOTKZbVn6AGIbug6hcj+CCFUwI/yG/XWveILyuy6wXGS7NPo/o7buo23uWwzWW0YXzdXoRkdLLLsCwxQEI9P79eellxAXglobZ1joVRuE1SCXNxhqP1rJIiJlenXw84f4PBXG/re+mVzTkonaV1pHqpz2eEbgPg0Kb055+E35TVTMJmqQeWSQusEICd8g1mY5j7PnP4QsDgrwWDRVkV4KB58
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:53:19.3286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d28b29b4-b68d-44ae-c492-08de753e6611
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17229-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C696B1A74E1
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow netlink users, through the usage of driver-details netlink
attribute, to get information about internal FRMR pools that use the
kernel_vendor_key FRMR key member.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 28 +++++++++++++++++++++++-----
 include/uapi/rdma/rdma_netlink.h |  1 +
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 0b0f689eadd7643fbe77a5364b8fefe3d3a60de9..80b0079f63ae83511883da20fc1aa4cca9a78120 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -186,6 +186,7 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 	[RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD] = { .type = NLA_U32 },
 	[RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY] = { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2671,6 +2672,12 @@ static int fill_frmr_pool_key(struct sk_buff *msg, struct ib_frmr_key *key)
 			      key->num_dma_blocks, RDMA_NLDEV_ATTR_PAD))
 		goto err;
 
+	if (key->kernel_vendor_key &&
+	    nla_put_u64_64bit(msg,
+			      RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,
+			      key->kernel_vendor_key, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
 	nla_nest_end(msg, key_attr);
 	return 0;
 
@@ -2705,9 +2712,9 @@ static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
 	return -EMSGSIZE;
 }
 
-static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
-				       struct ib_frmr_key *key,
-				       struct netlink_ext_ack *extack)
+static int nldev_frmr_pools_parse_key(struct nlattr *tb[],
+				      struct ib_frmr_key *key,
+				      struct netlink_ext_ack *extack)
 {
 	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS])
 		key->ats = nla_get_u8(tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]);
@@ -2723,6 +2730,11 @@ static void nldev_frmr_pools_parse_key(struct nlattr *tb[],
 	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
 		key->num_dma_blocks = nla_get_u64(
 			tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+
+	if (tb[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
+		return -EINVAL;
+
+	return 0;
 }
 
 static int nldev_frmr_pools_set_pinned(struct ib_device *device,
@@ -2746,7 +2758,9 @@ static int nldev_frmr_pools_set_pinned(struct ib_device *device,
 	if (err)
 		return err;
 
-	nldev_frmr_pools_parse_key(key_tb, &key, extack);
+	err = nldev_frmr_pools_parse_key(key_tb, &key, extack);
+	if (err)
+		return err;
 
 	err = ib_frmr_pools_set_pinned(device, &key, pinned_handles);
 
@@ -2762,6 +2776,7 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	struct ib_frmr_pool *pool;
 	struct nlattr *table_attr;
 	struct nlattr *entry_attr;
+	bool show_details = false;
 	struct ib_device *device;
 	int start = cb->args[0];
 	struct rb_node *node;
@@ -2778,6 +2793,9 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	if (!device)
 		return -EINVAL;
 
+	if (tb[RDMA_NLDEV_ATTR_DRIVER_DETAILS])
+		show_details = nla_get_u8(tb[RDMA_NLDEV_ATTR_DRIVER_DETAILS]);
+
 	pools = device->frmr_pools;
 	if (!pools) {
 		ib_device_put(device);
@@ -2803,7 +2821,7 @@ static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
 	read_lock(&pools->rb_lock);
 	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
 		pool = rb_entry(node, struct ib_frmr_pool, node);
-		if (pool->key.kernel_vendor_key)
+		if (pool->key.kernel_vendor_key && !show_details)
 			continue;
 
 		if (idx < start) {
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index 39178df104f01d19a8135554adece66be881fd15..aac9782ddc09a4f4e36708593cc27bb6f27a3398 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -602,6 +602,7 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
 	RDMA_NLDEV_ATTR_FRMR_POOLS_AGING_PERIOD,	/* u32 */
 	RDMA_NLDEV_ATTR_FRMR_POOL_PINNED_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_KERNEL_VENDOR_KEY,	/* u64 */
 
 	/*
 	 * Always the end

-- 
2.49.0


