Return-Path: <linux-rdma+bounces-17391-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJ77ABuzpWlMEgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17391-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:56:11 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 167301DC3E1
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 16:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 35D1D3023781
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D065041C2FA;
	Mon,  2 Mar 2026 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PVskwkBw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41D5413231;
	Mon,  2 Mar 2026 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466794; cv=fail; b=Fr/nYPeOsIp+xSH0XkOwXUZywjak/E7J2EHXjC5UCyhpeNJwijbzJaOlHWtejE3xw6QmsnFY3tKUEJz7/qLUAnwV1WyMJhd/d0SzdjheyjKmUQxOEc2yCUKIRvCFjnz5UdV+yOotIQyJvzilW/CdwsJoANPqSpeFRsC6vb9+Wjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466794; c=relaxed/simple;
	bh=Kd2Y8n9a/2dn9CbL26ErgZiza8ZaWoPmYYCmVjNZ8gY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PkiLsua0kKzzlblCjTQtoxQ/AZr5teBoBG1dvbLpNfIrL0t4q6J1TZO/b9snFSqfcuiiJhRK0dV0qvsXPSFzFHax4QNx+WxvJSdvWGHbLgsMpZmD3rb+bUtXWw8F7kE27J8ED2J0ZWbJ7Y9boZcDBtrsN64urhYW698asa4Vy5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PVskwkBw; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/W/vHZDrqJXUg3yQ/r0T+fTzT00+UfOyqjx2i8u5gPdAV+9WkLxl4KkGoRHQvkDGXfVII95MbJZjlzEJ8jLDh6fxMOAwH1KQ+KOrGsqHx3OsbqrlEi1nK4H/Q0+MnxqMIGUTIaEGzzuDPdQffE2xTpQZTqBSIVRouhksdsBS4iS3tEXanQwAcQ4PkwmUYMB79HwGPSgwaonvK11dtENIXwj8eci/rfh8jXbf28M91qT8qXH5qegrLQKxXaIETAOQnfL9gscC4s90sfve34AVMM3Jqo/qU8P/VizQGekkVU6ThwzauoH5jByYG0PzjcIOXrLefTg1wbjt3yYnoO2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IN8OH1QjKfW0CcZddPK0UWoXp/3xfenzSZ5OlJBPnZ0=;
 b=maPLvve9BgHRlIR4zf54szpbFJSDjMGXeZdoIqULkt+1WQ1e6riuVTWUjcMt2FhbIWCLnzjvfSUVlNFyc2z6oBohoedOcs+tzNFzqJRD8AQrzTgIFC6jD1JrC6DC2c3QIFZHLPXr0sLbkOvLTsht6XeFTQDXd8hIWk3jtPUgFRqGi3V6FjsK51l2BNB8AjPvCXXdySRm6RiPDZbaKrr1gEobUMOz2DqoPseNKx22dHGZYVQmu2/vcF1YaxEVWKX/cQo0Dec+YTFiuvGaOBEb0CMLg1jfqwecpJ/JWkHBsEDPgDM7yJlV9fVDGRAVS1UixyasjAhj3X8nkBgcfTznsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IN8OH1QjKfW0CcZddPK0UWoXp/3xfenzSZ5OlJBPnZ0=;
 b=PVskwkBwXQYLSlrV4++6iQCSRZqOVX9W+6VVx64mIvIPTywRUAvOszM6BByjEX74FyONwMFSryvi72hx7aTg2rUTVxp/iA6zgcP1AP9qh/s6YZWuSi2cYD6tb1cKhHVFIP69xlxSs/3fenEjtoJnQefrHg7bXRF8KvUgkcLfB1+YNSltqnAvUnTbbZIgnw0vifu1zLh6mRnMrCJMfIrl08RF1q73o0lvSq8CMZXwqOTBGLBCL7QqmvtEq0g3gN8ZLgJT8OZFJ+U6V5nUlysCS4D26E2oeiiBxNb7jyOoTMZIC766lte4ThkvYp7XvG8kOyyb6jaxaHbmPAHJL9esQw==
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by MN2PR12MB4047.namprd12.prod.outlook.com (2603:10b6:208:1de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Mon, 2 Mar
 2026 15:52:59 +0000
Received: from MWH0EPF000C6187.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::1d) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.28 via Frontend Transport; Mon,
 2 Mar 2026 15:52:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C6187.mail.protection.outlook.com (10.167.249.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 15:52:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:39 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Mar
 2026 07:52:39 -0800
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 2 Mar
 2026 07:52:36 -0800
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Patrisious Haddad <phaddad@nvidia.com>
Subject: [PATCH iproute2-next 2/4] rdma: Add resource FRMR pools show command
Date: Mon, 2 Mar 2026 17:51:58 +0200
Message-ID: <20260302155200.2611098-3-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20260302155200.2611098-1-cmeiohas@nvidia.com>
References: <20260302155200.2611098-1-cmeiohas@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6187:EE_|MN2PR12MB4047:EE_
X-MS-Office365-Filtering-Correlation-Id: c9dab7d2-bc43-42f6-80f7-08de7873c707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	MwG5IF2+RzD30xNlsDBa2kIPCkEH3Q3AJMPSoCKk2lUilgycooGlyY25hL9WpYlTGeigQo3cF1cgYOvjkrsBBvWZLN+KY/QWJna3eseSmUa6ooqQyLiunwJtMvyHMvXbPnVnLRWFe/asO1an2U3ijDfpDbW6JYt+NqPwyIIK9h8CPSPAYmEcVWERYjk4rZVIUKTysXdpvHb1r30OIcUGIF+DQw28xXRkpfGCdCJqglUVIXVhmc1axO3sJ1z4AIOhrNyDHmn9PSgeeHsOCHE3zbHc/1i0M70lJKf6IKX1GEU+e9qqxsw8GKy0TyYPWw1u7G4jRj7YGPeuW6hgixaey2kcQuMSEbSpXxiBG3UEkQSZdVPik33TEnC/BJT5bt11lYSDR23I9JC4er9cGriXRzq1qK9l8raFA6bnY34hBvkiiDWEpIDEV1UAG4/7aVVTrKFxytD0+oL1/zWR3akSZG0O76PuskIfgBhzgc7V/ldoniqvupxifWphdSI0xlA3zEOK0j1114p4j98y+FhNmFPEiQsqvsrj5CnL7fc/pTjjnk0AuJ7t5WaWYp7rTuuoJkh7B1xOoB4/LAxIPU19VAFx8BYYijB+X+M/gN7gHQjhnjTFYw/LgWObznQM9blJsAHROgjpUTjPmbUPDl8wz5Rxyxt8FzlcouTKPRze3nvxaaSfCwPP2ayRR6r/Ko8Cts03RWMREbJJiRFfu0e6C91LB35GoslRyVBAttX+W3tM/FtY3Om5+roLJ08W+rSAmL8KMGKXt87TSs6EAtnFmE/FYib1VfKMosYso7E57PxTiaMQsqcORrRZwXcciTCPLeBoYrhfCC0DfXF0SkaJ7Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TZs/qXrgVdF0r+5h78fndImc3Uf8rgTbBC5RYBDg8QOW2WsXowQGykW6/6MGDxvjzhGQ+zQKm2qMozsLE0H3arHwR42FCBQLUnJKfsjO11MIWfq+QHNVawnQYvi/gPLgCSdJhTow5Z6smVPKF2iImvG5x9UG3uGWk+k33ZRicFi8gnld0YKlZcRg9MykxmZkSz6DMcarMRhJf59vjbKw3NkbejMJ0neoyilzfmnVjgV23dxc+SuTo5vlydkP1LR0z+vPXMkRbQsvEvlNofkoiarqLLfDbpjJsxAnBGizhkqGNrqSPCZx4zHVOUclo6X+cs1ATc0CngYPL996Uzvrbx/njVyHV194y7v5y84OS5RhpJF9yCBbye/VBhlp/YlBJx4ns1REd2b9Z2UW8tSYXQJPAMAP2ZC6iy+BO4PezYy+CYszWHrc+VzxlblwGFrj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 15:52:58.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dab7d2-bc43-42f6-80f7-08de7873c707
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6187.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4047
X-Rspamd-Queue-Id: 167301DC3E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17391-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Allow users to see the FRMR pools that were created on the devices,
their properties and their usage statistics.
The set of properties of each pool are encoded to a hex representation
in order to simplify referencing a specific pool in 'set' commands.

Sample output:

$rdma resource show frmr_pools
dev rocep8s0f0 key 10000000000000 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 8000000000000 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 4000000000000 queue 0 in_use 0 max_in_use 200

$rdma resource show frmr_pools -d
dev rocep8s0f0 key 10000000000000 ats 0 access_flags 0 vendor_key 0 num_dma_blocks 4096 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 8000000000000 ats 0 access_flags 0 vendor_key 0 num_dma_blocks 2048 queue 0 in_use 0 max_in_use 200
dev rocep8s0f0 key 4000000000000 ats 0 access_flags 0 vendor_key 0 num_dma_blocks 1024 queue 0 in_use 0 max_in_use 200

$rdma resource show frmr_pools num_dma_blocks 2048
dev rocep8s0f0 key 8000000000000 queue 0 in_use 0 max_in_use 200

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
---
 man/man8/rdma-resource.8 |   8 +-
 rdma/Makefile            |   2 +-
 rdma/res-frmr-pools.c    | 190 +++++++++++++++++++++++++++++++++++++++
 rdma/res.c               |   5 +-
 rdma/res.h               |  18 ++++
 5 files changed, 220 insertions(+), 3 deletions(-)
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
index 00000000..97d59705
--- /dev/null
+++ b/rdma/res-frmr-pools.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * res-frmr-pools.c	RDMA tool
+ * Authors:    Michael Guralnik <michaelgur@nvidia.com>
+ */
+
+#include "res.h"
+#include <inttypes.h>
+
+#define FRMR_POOL_KEY_SIZE 21
+#define FRMR_POOL_KEY_HEX_SIZE (FRMR_POOL_KEY_SIZE * 2)
+union frmr_pool_key {
+	struct {
+		uint8_t ats;
+		uint32_t access_flags;
+		uint64_t vendor_key;
+		uint64_t num_dma_blocks;
+	} __attribute__((packed)) fields;
+	uint8_t raw[FRMR_POOL_KEY_SIZE];
+};
+
+/* Function to encode FRMR pool key to hex string (dropping leading zeros) */
+static void encode_hex_pool_key(const union frmr_pool_key *key,
+				char *hex_string)
+{
+	char temp_hex[FRMR_POOL_KEY_HEX_SIZE + 1] = { 0 };
+	int i;
+
+	for (i = 0; i < FRMR_POOL_KEY_SIZE; i++)
+		sprintf(temp_hex + (i * 2), "%02x", key->raw[i]);
+
+	for (i = 0; i < FRMR_POOL_KEY_HEX_SIZE && temp_hex[i] == '0'; i++) {
+		/* Skip leading zeros */
+	}
+
+	if (i == FRMR_POOL_KEY_HEX_SIZE) {
+		strcpy(hex_string, "0");
+		return;
+	}
+
+	strcpy(hex_string, temp_hex + i);
+}
+
+static int res_frmr_pools_line(struct rd *rd, const char *name, int idx,
+			       struct nlattr **nla_line)
+{
+	uint64_t in_use = 0, max_in_use = 0, kernel_vendor_key = 0;
+	char hex_string[FRMR_POOL_KEY_HEX_SIZE + 1] = { 0 };
+	struct nlattr *key_tb[RDMA_NLDEV_ATTR_MAX] = {};
+	union frmr_pool_key key = { 0 };
+	uint32_t queue_handles = 0;
+
+	if (nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY]) {
+		if (mnl_attr_parse_nested(
+			    nla_line[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY],
+			    rd_attr_cb, key_tb) != MNL_CB_OK)
+			return MNL_CB_ERROR;
+
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS])
+			key.fields.ats = mnl_attr_get_u8(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS])
+			key.fields.access_flags = mnl_attr_get_u32(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY])
+			key.fields.vendor_key = mnl_attr_get_u64(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS])
+			key.fields.num_dma_blocks = mnl_attr_get_u64(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_NUM_DMA_BLOCKS]);
+		if (key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY])
+			kernel_vendor_key = mnl_attr_get_u64(
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_KERNEL_VENDOR_KEY]);
+
+		if (rd_is_filtered_attr(
+			    rd, "ats", key.fields.ats,
+			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]))
+			goto out;
+
+		if (rd_is_filtered_attr(
+			    rd, "access_flags", key.fields.access_flags,
+			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]))
+			goto out;
+
+		if (rd_is_filtered_attr(
+			    rd, "vendor_key", key.fields.vendor_key,
+			    key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]))
+			goto out;
+
+		if (rd_is_filtered_attr(
+			    rd, "num_dma_blocks", key.fields.num_dma_blocks,
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
+		encode_hex_pool_key(&key, hex_string);
+		print_string(PRINT_ANY, "key", "key %s ", hex_string);
+
+		if (rd->show_details) {
+			res_print_u32(
+				"ats", key.fields.ats,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ATS]);
+			res_print_u32(
+				"access_flags", key.fields.access_flags,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_ACCESS_FLAGS]);
+			res_print_u64(
+				"vendor_key", key.fields.vendor_key,
+				key_tb[RDMA_NLDEV_ATTR_RES_FRMR_POOL_KEY_VENDOR_KEY]);
+			res_print_u64(
+				"num_dma_blocks", key.fields.num_dma_blocks,
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


