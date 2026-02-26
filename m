Return-Path: <linux-rdma+bounces-17225-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFlpO8RWoGn4iQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17225-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:20:52 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCAC1A7668
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9018330D37E1
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7BB3BFE4F;
	Thu, 26 Feb 2026 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCEyxyh4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3363A9D94;
	Thu, 26 Feb 2026 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113997; cv=fail; b=lqHiDZNjeML0R3So6NQSprrEyCjohwc7muFNHOKzJh8VzuWNGx6EYcwbPKzbKQys5/RlBbUnHUbV5nj72dorbaJFnIioHmbD1OAOM3SHF3X3RY8wma9LsLIov26TtimxoEsYJxdqZb5aVt6cJ5tt/gjnfSKVAl0g4CxPLBpvuZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113997; c=relaxed/simple;
	bh=08BRcOa0VLC5qMxuIx+7aqMrkNkgCHtEox22muJhwnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DTAcqYGLxX9EXTEzntwpwvTvGRenQe71J6uKX9/X8UvPwLnI/IiCUms6b7mTTMZ/rBzOvBhEg6bVZxlQN0yJJ/swaF54aaFeKzg9bce9AIkqyPLwT2NICNpiveRNYH0sAdkhGx7znkiOAVrRWZiJuJ7/JSkPUfxBI/zkd7lv8Fw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCEyxyh4; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5lP7D9BlykNEBHpIdAHCjRXeOBecNqvY9D/87LR9TO83nvFQr2rHCzz6WdSAI9dv6BLtip6L6n8TXzfVPXqYkQAw4ndvZ8fgvsrQ/fSVuacUwMGaJ/+x0KGpiStOwIk8lM9+N5cHQ4ah9gp2u3DXvEUkpJXsngn4PHSQKOl/XjMNLvBiHXo/GVk2+hfeUqnqxXQhTSzudFZiaMnUJAnJ8VukHajXl2IL+pq+JFkh6qFkqIWL0tSX7RgJuIZ/N2oL43VC0LHcpeSKdbY+NbsNuX6PT/BgqfBG602wHeOE4cxf1+0DdEiHAavrV+Uqpc9kb4SY9OIodMDxcsv71WdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWT+lm9qM8W7/rQlZjW3kFfWv3yj7Nkwpd/NTO2nYjo=;
 b=XidE6799aDUNeKtoVZw2UYWIeRx66adZiGk7wvWD8ItifSayUmLsMqiN/Yo0pfE3F5/NL6kwaE1MdExiT7sx4eS/kiEU5O2UwNHhzkVRqYxY7Itne0sObDSyCGgpeOc1rgW3c3B5U/WR5XV1Dzkby00NaXz9YC/gQRIg5gMiS7XczHSr/GwJ7DH1dIfsf/dgBaHdQnSYD3w9vFNWzoygMruJo6oCUSc+e9YeluMKdzFa4pY1Hj9OptTFe+rGjnjDYmLEbNwA4fbmdRE/gPaeeQubT2bNt0W9WN3zZ5KGsvqebrMjWuypKRnVdF5dsIOjEqMDVpNsIBcvEQ6LqR8B8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWT+lm9qM8W7/rQlZjW3kFfWv3yj7Nkwpd/NTO2nYjo=;
 b=VCEyxyh4Rg0s8v/piM4J6T8ikRt38gJO4X4DQi4KRdKmQNirvGqUouKHZtwSYr3qARdcLk6XjS1dXKxFpTdGC4eZJM2OfpSKjDB19QVhKAd7qBsAsGwil0MWtTEE5OfKJbSg9zUlJUFOwmwABJlkobtnwXbfXutdS5S/4JgL8blhCGsz+6c3se2mhHD3Sfup3F4cUJARd6rAtJAMITgnTbQkSZd2P0KUwc8lWX+Bx/McmF404li1OUKtB1KPrBTEJ4bOuk9pNSg7gGtA4uX2XKKyPunp9E5Oi+fI52J1QD5nKAnmCDWTT2Dsiu9WhEwoSFIWepB8sUhk8Lqq+OODSQ==
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 13:53:09 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.15 via Frontend Transport; Thu,
 26 Feb 2026 13:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:53:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:55 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:54 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:51 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:13 +0200
Subject: [PATCH rdma-next v4 08/11] RDMA/nldev: Add command to get FRMR
 pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-8-95360b54f15e@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=7671;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=2hImZ8nbVAAe7KtXN7Cme8siEDjovUk6VsdfENbtN7c=;
 b=YJFIxnSlc4viNYhMN1RrwkYeIfgxzmxQAdoee5trqRvX6FQK6u1kby3LnC/P04aqMMKc4EBZG
 NSLeaLNvo4KA1t2/LKokdvfaaT5NkM+X9Vv4ZkdRxXUHGDRe8Td1h7/
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f63c29f-660b-4c84-92ca-08de753e5e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	8ABEZZ0078/SC8S0V54pW1r5QiDe5pEo6npjUKKLbQzWvEzouo/Q33oefNMWgwNRvR6NBeBKT74D7F1Nsv+C3irldizQdicxtHhAN03yq4haatKRcUB17cYsJq/X4xL6FIVDF3pKA7/U7aRjQWtq5YMoHeTGhiwwxSL0DgMoIHu63p8htTxw4yAhN/RoLSC/8J68hBFVwzzaNEeyXIqleri1GQDOFVe/1G7sPyE/t379cfOItakbA1mrpS7r9rE7eriCwlqGHpkiCVSeJFOKkal8BpxfPQNY698s8+ojSoUXktOYmvbv7+DyKeXylbsxog1OfnlTeFK9Feybc0Tf+fhBvRssp4CgT3fmpmDVC6WiQbWNaM35Ltqa5dYaBiELckZEHgW12qUjaIAlBk0wQ0hlJROq23MdZ6d1dSp12OWaPadZQtXrs7sJlYFk203JCOTsMLzj3x3PLIsSYBEs6qvuvlwutAOs/RxFhkr8louBNuAQ0IaecZHQVDq1vBVlco/s0U5Iwv8Tk+8GYRq7Dg5AbVJDp/W/E6NqX24mBRubQySA9WZ9NQvpeDBruYwQ86S7ryRLBhSwr9uZyt6B3t+r7h+KRxFcoRQjBgNZDOoEYjBTqReeIp2h09eSo66BxgOsgD54R/IYMvAm5cDr7iVahRfkN7YD9LKrkT7+/41RCjHyjZK9tZK5CIaOr9OY34bjWql2E19ylUkV/hdXkK8cWGvGooR/Uh4UDJcd4Rv5IvqiiOZzbkt04+c/2R9w5tDRKRJMrzNY5tNwvW2wCiHgjZApBZ7L2vkKfmZNwML+01lJGZlBNxCICMOlpUnvymnc0mVA0WPchj7I8v8eCO9QnyZNbjvudpiSPmP3OTo=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4KKUbm8biTljtF2LwsiAzXkaTccLZnRVcht1FPRT262Y/hWIAPY9CLFzIgi8TTNxmgSwUTS6lcVz+SGg7JcyAJN5NKgrqKiYeY+3hrZTwkSVV35gBdJ1Rs9cHr/4o5PnJ+oixQ1rEC6ZLk0JEP7l2hpVNLJx0BqtNTrZ5NORjt8wB0smBLwIEBuHo4QHCk4b1BJVYONw2ZYSQoX50BQLqy+e9pfxeUfdimoV9JAyhJTwxPv6UWm8GUq+AXW8QSaIULHKqHlcoSqpTnbNzByuhrvWolUKIkQTPCJtycXcLFPF9U/NpgqAd7epmQgNYRhnPJ+L2B7pv8DSZkVXwlOdhNRGot+Wni3iGtQSpAPPXz+AvsGUxst2j1drEKmuIFi0BEJOYbIBj5Oh+XALqRDYE9RruXBwaWTo8f6dbt0fWVKeji1xgapUqaQ81NDqEn7V
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:53:06.5938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f63c29f-660b-4c84-92ca-08de753e5e88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-17225-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0CCAC1A7668
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Add support for a new command in netlink to dump to user the state of
the FRMR pools on the devices.
Expose each pool with its key and the usage statistics for it.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/nldev.c  | 165 +++++++++++++++++++++++++++++++++++++++
 include/uapi/rdma/rdma_netlink.h |  17 ++++
 2 files changed, 182 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 2220a2dfab240eaef2eb64d8e45cb221dfa25614..6637c76165be2555a732ce8e062e886f4309ce40 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -37,11 +37,13 @@
 #include <net/netlink.h>
 #include <rdma/rdma_cm.h>
 #include <rdma/rdma_netlink.h>
+#include <rdma/frmr_pools.h>
 
 #include "core_priv.h"
 #include "cma_priv.h"
 #include "restrack.h"
 #include "uverbs.h"
+#include "frmr_pools.h"
 
 /*
  * This determines whether a non-privileged user is allowed to specify a
@@ -172,6 +174,16 @@ static const struct nla_policy nldev_policy[RDMA_NLDEV_ATTR_MAX] = {
 	[RDMA_NLDEV_ATTR_NAME_ASSIGN_TYPE]	= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_EVENT_TYPE]		= { .type = NLA_U8 },
 	[RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED] = { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOLS]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY]	= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY]		= { .type = NLA_NESTED },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS]	= { .type = NLA_U8 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS] = { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES] = { .type = NLA_U32 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE]	= { .type = NLA_U64 },
+	[RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE]	= { .type = NLA_U64 },
 };
 
 static int put_driver_name_print_type(struct sk_buff *msg, const char *name,
@@ -2637,6 +2649,156 @@ static int nldev_deldev(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return ib_del_sub_device_and_put(device);
 }
 
+static int fill_frmr_pool_key(struct sk_buff *msg, struct ib_frmr_key *key)
+{
+	struct nlattr *key_attr;
+
+	key_attr = nla_nest_start(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY);
+	if (!key_attr)
+		return -EMSGSIZE;
+
+	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS, key->ats))
+		goto err;
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,
+			key->access_flags))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,
+			      key->vendor_key, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,
+			      key->num_dma_blocks, RDMA_NLDEV_ATTR_PAD))
+		goto err;
+
+	nla_nest_end(msg, key_attr);
+	return 0;
+
+err:
+	return -EMSGSIZE;
+}
+
+static int fill_frmr_pool_entry(struct sk_buff *msg, struct ib_frmr_pool *pool)
+{
+	if (fill_frmr_pool_key(msg, &pool->key))
+		return -EMSGSIZE;
+
+	spin_lock(&pool->lock);
+	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,
+			pool->queue.ci + pool->inactive_queue.ci))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,
+			      pool->max_in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	if (nla_put_u64_64bit(msg, RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,
+			      pool->in_use, RDMA_NLDEV_ATTR_PAD))
+		goto err_unlock;
+	spin_unlock(&pool->lock);
+
+	return 0;
+
+err_unlock:
+	spin_unlock(&pool->lock);
+	return -EMSGSIZE;
+}
+
+static int nldev_frmr_pools_get_dumpit(struct sk_buff *skb,
+				       struct netlink_callback *cb)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX];
+	struct ib_frmr_pools *pools;
+	int err, ret = 0, idx = 0;
+	struct ib_frmr_pool *pool;
+	struct nlattr *table_attr;
+	struct nlattr *entry_attr;
+	struct ib_device *device;
+	int start = cb->args[0];
+	struct rb_node *node;
+	struct nlmsghdr *nlh;
+	bool filled = false;
+
+	err = __nlmsg_parse(cb->nlh, 0, tb, RDMA_NLDEV_ATTR_MAX - 1,
+			    nldev_policy, NL_VALIDATE_LIBERAL, NULL);
+	if (err || !tb[RDMA_NLDEV_ATTR_DEV_INDEX])
+		return -EINVAL;
+
+	device = ib_device_get_by_index(
+		sock_net(skb->sk), nla_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]));
+	if (!device)
+		return -EINVAL;
+
+	pools = device->frmr_pools;
+	if (!pools) {
+		ib_device_put(device);
+		return 0;
+	}
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			RDMA_NL_GET_TYPE(RDMA_NL_NLDEV,
+					 RDMA_NLDEV_CMD_FRMR_POOLS_GET),
+			0, NLM_F_MULTI);
+
+	if (!nlh || fill_nldev_handle(skb, device)) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	table_attr = nla_nest_start_noflag(skb, RDMA_NLDEV_ATTR_FRMR_POOLS);
+	if (!table_attr) {
+		ret = -EMSGSIZE;
+		goto err;
+	}
+
+	read_lock(&pools->rb_lock);
+	for (node = rb_first(&pools->rb_root); node; node = rb_next(node)) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		if (pool->key.kernel_vendor_key)
+			continue;
+
+		if (idx < start) {
+			idx++;
+			continue;
+		}
+
+		filled = true;
+
+		entry_attr = nla_nest_start_noflag(
+			skb, RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY);
+		if (!entry_attr) {
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		if (fill_frmr_pool_entry(skb, pool)) {
+			nla_nest_cancel(skb, entry_attr);
+			ret = -EMSGSIZE;
+			goto end_msg;
+		}
+
+		nla_nest_end(skb, entry_attr);
+		idx++;
+	}
+end_msg:
+	read_unlock(&pools->rb_lock);
+
+	nla_nest_end(skb, table_attr);
+	nlmsg_end(skb, nlh);
+	cb->args[0] = idx;
+
+	/*
+	 * No more entries to fill, cancel the message and
+	 * return 0 to mark end of dumpit.
+	 */
+	if (!filled)
+		goto err;
+
+	ib_device_put(device);
+	return skb->len;
+
+err:
+	nlmsg_cancel(skb, nlh);
+	ib_device_put(device);
+	return ret;
+}
+
 static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 	[RDMA_NLDEV_CMD_GET] = {
 		.doit = nldev_get_doit,
@@ -2743,6 +2905,9 @@ static const struct rdma_nl_cbs nldev_cb_table[RDMA_NLDEV_NUM_OPS] = {
 		.doit = nldev_deldev,
 		.flags = RDMA_NL_ADMIN_PERM,
 	},
+	[RDMA_NLDEV_CMD_FRMR_POOLS_GET] = {
+		.dump = nldev_frmr_pools_get_dumpit,
+	},
 };
 
 static int fill_mon_netdev_rename(struct sk_buff *msg,
diff --git a/include/uapi/rdma/rdma_netlink.h b/include/uapi/rdma/rdma_netlink.h
index f41f0228fcd0e0b74e74b4d87611546b00f799a1..8f17ffe0190cb86131109209c45caec155ab36da 100644
--- a/include/uapi/rdma/rdma_netlink.h
+++ b/include/uapi/rdma/rdma_netlink.h
@@ -308,6 +308,8 @@ enum rdma_nldev_command {
 
 	RDMA_NLDEV_CMD_MONITOR,
 
+	RDMA_NLDEV_CMD_FRMR_POOLS_GET, /* can dump */
+
 	RDMA_NLDEV_NUM_OPS
 };
 
@@ -582,6 +584,21 @@ enum rdma_nldev_attr {
 	RDMA_NLDEV_SYS_ATTR_MONITOR_MODE,	/* u8 */
 
 	RDMA_NLDEV_ATTR_STAT_OPCOUNTER_ENABLED,	/* u8 */
+
+	/*
+	 * FRMR Pools attributes
+	 */
+	RDMA_NLDEV_ATTR_FRMR_POOLS,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_ENTRY,	/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY,		/* nested table */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ATS,	/* u8 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_ACCESS_FLAGS,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_VENDOR_KEY,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_KEY_NUM_DMA_BLOCKS,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_QUEUE_HANDLES,	/* u32 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_MAX_IN_USE,	/* u64 */
+	RDMA_NLDEV_ATTR_FRMR_POOL_IN_USE,	/* u64 */
+
 	/*
 	 * Always the end
 	 */

-- 
2.49.0


