Return-Path: <linux-rdma+bounces-18798-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBGNN+W0ymmE/QUAu9opvQ
	(envelope-from <linux-rdma+bounces-18798-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:37:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE2B35F589
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 233F6304BDB2
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 17:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6CE3DCDBC;
	Mon, 30 Mar 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lpQzuaV1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED6389109;
	Mon, 30 Mar 2026 17:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892024; cv=fail; b=RWftiotKpwDGv2r+Fg99c/VgGgNGLG2jO/gPmqqF4J+hxhRB8XsfRh0rZtaVPw3aFNU/upRlysNhJJ4zo01dNHsgrerd6YHXOD2xEoQzy4HSJNEcBJ+cBC4bZuKc3zxUaQdZJLxL0dJ5aBAAXUg9096PkV6Mnq2UcpUL5kAqyv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892024; c=relaxed/simple;
	bh=hyFGWKu2LPBzT2+ELAR52xZ/8Hs0XJ4qorlbQ9NaSZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMWaZSWF0YHefPra3O4CVwyR/taiVZn8GIq0gZjbSS5Y0ayqIOD8+f2rnpFBx5d7INDYVe6USjq6sLi3PhM1FGblJNX0Krr6t5z7FAgtehjJxx4w9gEVlfC0GsioQeT62IqML4JB6tt9KNhemTQ2XCgIuqpQaa5OQ4nBheM1vXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lpQzuaV1; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaqMSVa7O85OwttGP12YePInDFYd/NcmN4odpAtbVKfD3vRLwt1ZshkTpJmNMaCPjMeM+K3VMFtKSh2WNTIvg4AuilPf5DjQQufia/aJJGWpG11ClXkSRwsXy6nEKlJ95RIZ9BJ1Tb6tkcEef5xESCEYPg3BkVuD5VWudiNQ+hkMYrner15I1hNJCH35VPXWAAIcWFAaFZGcUmEEGD7tbGkU7Z9n8ccnBpwsh+58Iyj7Wo6Ii/ZM+K34D9FJJ1DTyp+VYrG5ZPfjWzLjMLBwsYUGs+gd3plKVaVNJ+3bMNOSXOHvuaZFuM239t38xktZGkkefTikpa6BFAmbLdpt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/8b11r4hoxyQCqVC3GtSyH8pDo/NygmcAaQoYFgXMg=;
 b=UCHHxoLtQ3VUMd6kEnV53aqhzRBi1g54caLn6+dPDv7aXAQQMKTJIi3U7gSBtDwSW+E7GjrZldVqEja2o5RGWj1WmBI1rg15YLG39dolD5EiejJsGG4Wg0+FEivFIS3Ym8yY7825tFgvAMqqhKBITnj4d2QPuG5Szb5pcGJS0ABx/SbMkYUAO5KpVis6qqqYxef9P2C4eblfq9zQ3gghsbQiX4hcw1DKwRcV285pXDxmd4tiibSIXLFKn+415gYAKuzetRsYSCJJXsUc+Fiz3Pqaqs8xaSzf9aGSFfBE7+mzjc+ZLmhjsQUmjpoUGJRv9TZko9rDiMo0RJvwekC4qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/8b11r4hoxyQCqVC3GtSyH8pDo/NygmcAaQoYFgXMg=;
 b=lpQzuaV1+Uv97+UybFLlGKiHG3ferxdv7m7q5FaKTU51Cy2SQTD2umnExWkKrObnPMilNgqYAEFl+9vu25Rg6hAEdIaZtb7Ny86NEjAfjrZ9FlXpLHFE/IxF5Zwf70ghnQu9rVfE0cMz0R3xXN63jcsPhimGmwdZquEUrXzFUckFZVRU9XZUp2APRmGWUgYELfC1r0Y5PXxo0IynIlyk++Lo97fNqbksz6kx2our6vfJC2/vLi6uC8F+T//jJph0ht9E5UDXwsdD+QVgkLqBjPBZTlV1vMrxgpopYpivjPY51uRzWokuWkgGdztMTdCrvicho6UY2+jYDdlOE/sSDQ==
Received: from PH2PEPF00003850.namprd17.prod.outlook.com (2603:10b6:518:1::72)
 by IA4PR12MB9833.namprd12.prod.outlook.com (2603:10b6:208:55b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 17:33:37 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH2PEPF00003850.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 17:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Mon, 30 Mar 2026 17:33:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:19 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:33:19 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 10:33:16 -0700
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>
Subject: [PATCH v2 iproute2-next 2/4] rdma: Add resource FRMR pools show command
Date: Mon, 30 Mar 2026 20:31:16 +0300
Message-ID: <20260330173118.766885-3-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260330173118.766885-1-cmeiohas@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|IA4PR12MB9833:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf4c7ae-ab50-4d29-66ca-08de8e827a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GB9c1SaOTIMmJaUdFGqL3STlsY6Xdk3c6NYTaANUeelBTgfPrgp3LZpa0gchcu1tINlnMJ+KD9+yOd+UJCu35AKUPix/AIMXEqxgmV9KaotHKP9GhEfNL7I9JzO2zqJAxijy9NXIikaW0zkIcCUClo6sRxKwygm5/Qz3eDtJ3JlTtlwYz3SR/8ASPZ5QF6nqWSQ4h4IdYoaMOWX4+vuir5h6Rvx47mx34m/ofDhoIKd6vhJjmCzUen5zuafJUAREim2sssiwhmJB06mXEMMP0cod1vKJUVTmglO1UhxyNv8m4VHaBbgnogz54yLKNK8VsGYH91TPHzyuDs6ewYS+h3C1wUv5Wm9f5d4negdFRbNvK777HesldAU9Wb/EOkhG8jGNXmqQ7shklT6mPFPT4HaOGtFPft1+eJO87yOIbnRbUGNygDzCeIqJjqdXRHzZWBnI48hPk8Bur4RE6AJBv0vuGy7tQ104uV+HNOYWl23aA5mWOqyUbHqOCMNf4mimeOrJWYWePXLedW6xi39nuXPQvor7LC1yzg5nUDpiOvpTveu00rg9PtJdvCfey/PPNiDv1j8POiyXCHkv+ntI9WTQ630LPgAxVTxqmEwNkPU1w0wk3Th88fws5g7SbHVabHY56B3Vr1EU2dzgBYW0ipoJTuWnQufa4oA8n9eWID21hX7ltSPRd3FMprLYlih1S+CO4zg7ca7tg23XQXcWKnKK2EhCYH3ee5efDOtimWF/MsmCCkq6zqcFXPHI6kRz6JMju1igKjLBw+Dz6X0E5w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VXu51JUnfeOumIwh5FmshZeHhVh9sDqKYWp99q4TzqPYXtYye1v6TcI5J7MRnKAHLQyQIgn/WdvgjyIpxQqqANCjGYvgr/bp9fobrzz/s0yeJDLIUhTPELjXADtotWXu5ZaT0pEmNeTQmI5jSuGSa78XBKl3z1Kq/Pbnb1JFZ58B00dwZ1wT8+zSNGYk3BQ2NhksPE+c1n7NqLBy1ppg3GoZ60nwGfIsI6L1nF4RknmTou+c1pTpKI5vdlX7ObFfTVIjXrJc6DeKy76PNguRJoiL9kswOZQdR4q5nHDINxUEZknZA/KY4U9tkortMfmgt1bziZmo4xd3AV+sN91fyqO7M75JsJJ4qoWVkUHPI9HT7IAZWbivRXk5pH63zkAQpWyOiSxE4xqSlgUJZN4e3C/vNW+urZTNNAnAm+7y5wzqwCaflnAIEOVz7NCRrflC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:33:37.6773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf4c7ae-ab50-4d29-66ca-08de8e827a04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9833
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18798-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 8AE2B35F589
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to see the FRMR pools that were created on the devices,
their properties and their usage statistics.
The set of properties of each pool are encoded as a colon-separated
list of hexadecimal fields (vendor_key:num_dma_blocks:access_flags:ats)
to simplify referencing a specific pool in 'set' commands.

Sample output:

$rdma resource show frmr_pools
dev rocep8s0f0 key 0:1000:0:0 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 0:800:0:0 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 0:400:0:0 queue 0 in_use 0 max_in_use 200

$rdma resource show frmr_pools -d
dev rocep8s0f0 key 0:1000:0:0 ats 0 access_flags 0 vendor_key 0 num_dma_blocks 4096 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 0:800:0:0 ats 0 access_flags 0 vendor_key 0 num_dma_blocks 2048 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 0:400:0:0 ats 0 access_flags 0 vendor_key 0 num_dma_blocks 1024 queue 0 in_use 0 max_in_use 200

$rdma resource show frmr_pools num_dma_blocks 2048
dev rocep8s0f0 key 0:800:0:0 queue 0 in_use 0 max_in_use 200

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
---
 man/man8/rdma-resource.8 |   8 +-
 rdma/Makefile            |   2 +-
 rdma/res-frmr-pools.c    | 174 +++++++++++++++++++++++++++++++++++++++
 rdma/res.c               |   5 +-
 rdma/res.h               |  18 ++++
 5 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100644 rdma/res-frmr-pools.c

diff --git a/man/man8/rdma-resource.8 b/man/man8/rdma-resource.8
index 61bec471..4e2ba39a 100644
--- a/man/man8/rdma-resource.8
+++ b/man/man8/rdma-resource.8
@@ -13,7 +13,8 @@ rdma-resource \- rdma resource configuration
 
 .ti -8
 .IR RESOURCE " := { "
-.BR cm_id " | " cq " | " mr " | " pd " | " qp " | " ctx " | " srq " }"
+.BR cm_id " | " cq " | " mr " | " pd " | " qp " | " ctx " | " srq " | "
+.BR frmr_pools " }"
 .sp
 
 .ti -8
@@ -113,6 +114,11 @@ rdma resource show srq lqpn 5-7
 Show SRQs that the QPs with lqpn 5-7 are associated with.
 .RE
 .PP
+rdma resource show frmr_pools ats 1
+.RS
+Show FRMR pools that have ats attribute set.
+.RE
+.PP
 
 .SH SEE ALSO
 .BR rdma (8),
diff --git a/rdma/Makefile b/rdma/Makefile
index ed3c1c1c..66fe53f9 100644
--- a/rdma/Makefile
+++ b/rdma/Makefile
@@ -5,7 +5,7 @@ CFLAGS += -I./include/uapi/
 
 RDMA_OBJ = rdma.o utils.o dev.o link.o res.o res-pd.o res-mr.o res-cq.o \
 	   res-cmid.o res-qp.o sys.o stat.o stat-mr.o res-ctx.o res-srq.o \
-	   monitor.o
+	   monitor.o res-frmr-pools.o
 
 TARGETS += rdma
 
diff --git a/rdma/res-frmr-pools.c b/rdma/res-frmr-pools.c
new file mode 100644
index 00000000..7d99a728
--- /dev/null
+++ b/rdma/res-frmr-pools.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * res-frmr-pools.c	RDMA tool
+ * Authors:    Michael Guralnik <michaelgur@nvidia.com>
+ */
+
+#include "res.h"
+#include <inttypes.h>
+
+struct frmr_pool_key {
+	uint64_t vendor_key;
+	uint64_t num_dma_blocks;
+	uint32_t access_flags;
+	uint8_t ats;
+};
+
+/* vendor_key(16) + ':' + num_dma_blocks(16) + ':' + access_flags(8) + ':' + ats(1) + '\0' */
+#define FRMR_POOL_KEY_MAX_LEN 45
+
+static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
+			       struct nlattr **nla_line)
+{
+	uint64_t in_use = 0, max_in_use = 0, kernel_vendor_key = 0;
+	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX] = {};
+	char key_str[FRMR_POOL_KEY_MAX_LEN];
+	struct frmr_pool_key key = { 0 };
+	uint32_t queue_handles = 0;
+
+	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
+		if (mnl_attr_parse_nested(
+			    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY],
+			    rd_attr_cb, key_tb) != MNL_CB_OK)
+			return MNL_CB_ERROR;
+
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS])
+			key.ats = mnl_attr_get_u8(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS])
+			key.access_flags = mnl_attr_get_u32(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY])
+			key.vendor_key = mnl_attr_get_u64(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+			key.num_dma_blocks = mnl_attr_get_u64(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
+			kernel_vendor_key = mnl_attr_get_u64(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
+
+		if (rd_is_filtered_attr(
+			    rd, "ats", key.ats,
+			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]))
+			goto out;
+
+		if (rd_is_filtered_attr(
+			    rd, "access_flags", key.access_flags,
+			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]))
+			goto out;
+
+		if (rd_is_filtered_attr(
+			    rd, "vendor_key", key.vendor_key,
+			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]))
+			goto out;
+
+		if (rd_is_filtered_attr(
+			    rd, "num_dma_blocks", key.num_dma_blocks,
+			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]))
+			goto out;
+	}
+
+	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES])
+		queue_handles = mnl_attr_get_u32(
+			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]);
+	if (rd_is_filtered_attr(
+		    rd, "queue", queue_handles,
+		    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]))
+		goto out;
+
+	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE])
+		in_use = mnl_attr_get_u64(
+			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
+	if (rd_is_filtered_attr(rd, "in_use", in_use,
+				nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]))
+		goto out;
+
+	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE])
+		max_in_use = mnl_attr_get_u64(
+			nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+	if (rd_is_filtered_attr(
+		    rd, "max_in_use", max_in_use,
+		    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]))
+		goto out;
+
+	open_json_object(NULL);
+	print_dev(idx, name);
+
+	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
+		snprintf(key_str, sizeof(key_str),
+			 "%" PRIx64 ":%" PRIx64 ":%x:%s",
+			 key.vendor_key, key.num_dma_blocks,
+			 key.access_flags, key.ats ? "1" : "0");
+		print_string(PRINT_ANY, "key", "key %s ", key_str);
+
+		if (rd->show_details) {
+			res_print_u32(
+				"ats", key.ats,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
+			res_print_u32(
+				"access_flags", key.access_flags,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
+			res_print_u64(
+				"vendor_key", key.vendor_key,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
+			res_print_u64(
+				"num_dma_blocks", key.num_dma_blocks,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+			res_print_u64(
+				"kernel_vendor_key", kernel_vendor_key,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
+		}
+	}
+
+	res_print_u32("queue", queue_handles,
+		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_QUEUE_HANDLES]);
+	res_print_u64("in_use", in_use,
+		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_IN_USE]);
+	res_print_u64("max_in_use", max_in_use,
+		      nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_MAX_IN_USE]);
+
+	print_driver_table(rd, nla_line[RDMA_NLDEV_ATTR_DRIVER]);
+	close_json_object();
+	newline();
+
+out:
+	return MNL_CB_OK;
+}
+
+int res_frmr_pools_idx_parse_cb(const struct nlmsghdr *nlh, void *data)
+{
+	return MNL_CB_OK;
+}
+
+int res_frmr_pools_parse_cb(const struct nlmsghdr *nlh, void *data)
+{
+	struct nlattr *tb[RDMA_NLDEV_ATTR_MAX] = {};
+	struct nlattr *nla_table, *nla_entry;
+	struct rd *rd = data;
+	int ret = MNL_CB_OK;
+	const char *name;
+	uint32_t idx;
+
+	mnl_attr_parse(nlh, 0, rd_attr_cb, tb);
+	if (!tb[RDMA_NLDEV_ATTR_DEV_INDEX] || !tb[RDMA_NLDEV_ATTR_DEV_NAME] ||
+	    !tb[RDMA_NLDEV_ATTR_RES_FRMR_POOLS])
+		return MNL_CB_ERROR;
+
+	name = mnl_attr_get_str(tb[RDMA_NLDEV_ATTR_DEV_NAME]);
+	idx = mnl_attr_get_u32(tb[RDMA_NLDEV_ATTR_DEV_INDEX]);
+	nla_table = tb[RDMA_NLDEV_ATTR_RES_FRMR_POOLS];
+
+	mnl_attr_for_each_nested(nla_entry, nla_table) {
+		struct nlattr *nla_line[RDMA_NLDEV_ATTR_MAX] = {};
+
+		ret = mnl_attr_parse_nested(nla_entry, rd_attr_cb, nla_line);
+		if (ret != MNL_CB_OK)
+			break;
+
+		ret = res_frmr_pools_line(rd, name, idx, nla_line);
+		if (ret != MNL_CB_OK)
+			break;
+	}
+	return ret;
+}
diff --git a/rdma/res.c b/rdma/res.c
index 7e7de042..f1f13d74 100644
--- a/rdma/res.c
+++ b/rdma/res.c
@@ -11,7 +11,7 @@ static int res_help(struct rd *rd)
 {
 	pr_out("Usage: %s resource\n", rd->filename);
 	pr_out("          resource show [DEV]\n");
-	pr_out("          resource show [qp|cm_id|pd|mr|cq|ctx|srq]\n");
+	pr_out("          resource show [qp|cm_id|pd|mr|cq|ctx|srq|frmr_pools]\n");
 	pr_out("          resource show qp link [DEV/PORT]\n");
 	pr_out("          resource show qp link [DEV/PORT] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource show cm_id link [DEV/PORT]\n");
@@ -26,6 +26,8 @@ static int res_help(struct rd *rd)
 	pr_out("          resource show ctx dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	pr_out("          resource show srq dev [DEV]\n");
 	pr_out("          resource show srq dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
+	pr_out("          resource show frmr_pools dev [DEV]\n");
+	pr_out("          resource show frmr_pools dev [DEV] [FILTER-NAME FILTER-VALUE]\n");
 	return 0;
 }
 
@@ -237,6 +239,7 @@ static int res_show(struct rd *rd)
 		{ "pd",		res_pd		},
 		{ "ctx",	res_ctx		},
 		{ "srq",	res_srq		},
+		{ "frmr_pools",	res_frmr_pools	},
 		{ 0 }
 	};
 
diff --git a/rdma/res.h b/rdma/res.h
index fd09ce7d..30edb8f8 100644
--- a/rdma/res.h
+++ b/rdma/res.h
@@ -26,6 +26,8 @@ int res_ctx_parse_cb(const struct nlmsghdr *nlh, void *data);
 int res_ctx_idx_parse_cb(const struct nlmsghdr *nlh, void *data);
 int res_srq_parse_cb(const struct nlmsghdr *nlh, void *data);
 int res_srq_idx_parse_cb(const struct nlmsghdr *nlh, void *data);
+int res_frmr_pools_parse_cb(const struct nlmsghdr *nlh, void *data);
+int res_frmr_pools_idx_parse_cb(const struct nlmsghdr *nlh, void *data);
 
 static inline uint32_t res_get_command(uint32_t command, struct rd *rd)
 {
@@ -185,6 +187,22 @@ struct filters srq_valid_filters[MAX_NUMBER_OF_FILTERS] = {
 RES_FUNC(res_srq, RDMA_NLDEV_CMD_RES_SRQ_GET, srq_valid_filters, true,
 	 RDMA_NLDEV_ATTR_RES_SRQN);
 
+
+static const
+struct filters frmr_pools_valid_filters[MAX_NUMBER_OF_FILTERS] = {
+	{ .name = "dev", .is_number = false },
+	{ .name = "ats", .is_number = true },
+	{ .name = "access_flags", .is_number = true },
+	{ .name = "vendor_key", .is_number = true },
+	{ .name = "num_dma_blocks", .is_number = true },
+	{ .name = "queue", .is_number = true },
+	{ .name = "in_use", .is_number = true },
+	{ .name = "max_in_use", .is_number = true },
+};
+
+RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
+	 frmr_pools_valid_filters, true, 0);
+
 void print_dev(uint32_t idx, const char *name);
 void print_link(uint32_t idx, const char *name, uint32_t port, struct nlattr **nla_line);
 void print_key(const char *name, uint64_t val, struct nlattr *nlattr);
-- 
2.38.1


