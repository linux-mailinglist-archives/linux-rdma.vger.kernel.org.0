Return-Path: <linux-rdma+bounces-15159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 166FECD6261
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95CBA30778CC
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D452DFF28;
	Mon, 22 Dec 2025 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dt1aRtp7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013009.outbound.protection.outlook.com [40.107.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053C2C21E8;
	Mon, 22 Dec 2025 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766409977; cv=fail; b=HSg8l2dW0oHa/a3czNT1AFV3mvjR20OryjWJzLicJDsNV8/hYNNtywENop58DpB1a6NPqcTr4apJo3+f2IVA2l0TDZnq7zzdVsVYsyoGLQw/S3vDJjxa2s6mCrN4AfkMgXr4nzkUS+vZWTxfl7JNECeG3Di9U7n2fg4mqq3QCPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766409977; c=relaxed/simple;
	bh=c6VIx52RyD/xm3kfCisa1/H092U0njyB0Lq+zf8oNuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCVQVYGkfhL5nx8QKLctHqx5vE3IT2QOAD5BzT1acUi5UkCCdRA67YP0T/dZVC7AGI1/dOp8DgMzU1GEK6AJOyJXD3QEyJlP7u72f0HMvEpc3aZC/cZlC7DoZYKVJAz2O70jmhjalXyDh7zzHBC5KnMBAgW/SGFRQI3TYy9iWPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dt1aRtp7; arc=fail smtp.client-ip=40.107.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oz+c6FcSJTwfFKrX2zXsl7gh462qvQzVSTk45arU0Y2qQnPL+w6p9kkIrKs8zku+YfmhUAZE07Fvcewhsfz9NiBXkC219g1f/9VrcJdhZDs1FybUa5oWfeT8TF9Clxb7LrvtsuDwwEFjlm2nTgZeUypZOmjHIqHTgZuEinULierSd57NNFGvRfYaOc85TsqdRuJo8mFxR7BV4rnnJrsOu3hFg3vy0HxwKwmxX46bZCK6SdLb8A8JwGH9pIA38T3wVXzs/8tms1CI2TufhdBjbZs6TV0V/VmPprgaXvezmbyD1cK2TZEjvhefa9FYmzhkqg1E8bb7UeMgqpWnc64kyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GN5KfllOdBpwO+qZYZh8QoPcsbqLuTqqMpTBcxW3isQ=;
 b=Ol1UEMmmWJ5hZmRHOrHMPpTwQMhdYgY7MPq/rhoVzepwKFTE+myyz4FQ+momXZn7MFrbGyt3e3osAC1umNraY1EyNSCpk+BUQ2P8tI6O6hooUyQ3TJISupmKyTlsu8HwxZw5b4XcXhwJoLXR7gzL14TAVslfTNieSfp9MYFGB46qGky2dYZO9ubyc7JnqkhRavogllSxObLhV61KWhpZMpZD9I8Y2CeXoffrlryDFj/57R0QIKcrtnNu2WYGKls5K1FVsYg+K9GkaAHSwjQ9MwfAjW/vVHStIhqbEJyyvfr/wT9DFhP44rF3wUwO0EKXzGc0172ulxnukoVr5ii9iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GN5KfllOdBpwO+qZYZh8QoPcsbqLuTqqMpTBcxW3isQ=;
 b=dt1aRtp7KEsrz0IzkJg/Yp6Y45PO5EEqhKyy1m1DapsY5unbgt9u2yBasfcyAR5UQ/4ou/WAnmya+biyM67GV6WlO+WY89L3QAlKP821d5THAI5r2s+0UwZa3ctvFBC7Fnshzkz7+vM9J5c1MD7cuRsX9aN13OtIRtNHWVugzw+ijb9qKAvsoBFmf14286s5wuRwkJqiB/3Md2fFGX+ePuosr0cRDWRlfyIhkBb1gevlNhlOHURVVcm6LQG3AYZJdxWjCm43TzGBlOpfAOdPUj1xZBQUmhkd+OaMStGlddiKvkFofHlr5Z7nTEHKpCqTSBrWv8RW8AEL8/GmhmHSlQ==
Received: from DM6PR01CA0005.prod.exchangelabs.com (2603:10b6:5:296::10) by
 IA1PR12MB9032.namprd12.prod.outlook.com (2603:10b6:208:3f3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 13:26:10 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::6a) by DM6PR01CA0005.outlook.office365.com
 (2603:10b6:5:296::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 13:25:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 13:26:09 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 05:26:01 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Dec 2025 05:26:00 -0800
Received: from vdi.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 05:25:58 -0800
From: Patrisious Haddad <phaddad@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: Michael Guralnik <michaelgur@nvidia.com>, <netdev@vger.kernel.org>,
	<jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>
Subject: [RFC iproute2-next 2/4] rdma: Add resource FRMR pools show command
Date: Mon, 22 Dec 2025 15:25:44 +0200
Message-ID: <20251222132549.995921-3-phaddad@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251222132549.995921-1-phaddad@nvidia.com>
References: <20251222132549.995921-1-phaddad@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|IA1PR12MB9032:EE_
X-MS-Office365-Filtering-Correlation-Id: 892ef7cd-79c9-4b4e-7bf2-08de415daba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?68CLvek4DFXnyUqNZ9F+yiNPx3GcVTmMstVcZm/pSPA3Hnc+ULivUgtsb/64?=
 =?us-ascii?Q?FRjtpZLJeMm1421kaBst3HHsuibOnVLcPPgRe1ZhS9/vfD4makXcx7tEd1JL?=
 =?us-ascii?Q?lPDoWXKUy3KREyuScELafy7dBCWl8umUDIalrQ6TsJ/t4N+1/VHe8/YKj5Eh?=
 =?us-ascii?Q?lijq4njRZsemAN95DufjmLcKLqfCrDRm2jHKokUHhFngZXmuJdQCfWF3KN3m?=
 =?us-ascii?Q?dMQsGqikO80v20Nz75VCcDpWUwke7XEGo9G0ErRNkWcYCvQmCzWSTitfxz1R?=
 =?us-ascii?Q?k1GeGtxr03mK/DybysEfDa0cbcwSXtHfj+aIdENHEC+HZFUMOjjJ0jqDfUYy?=
 =?us-ascii?Q?Z5wo/7priOYLpTaB0G4olX9PSAG8OdsQM6yFpqJvDjPkM3RuSVf1qvgXhLEc?=
 =?us-ascii?Q?jzKhdwqB/RybYiNCv/pcRL/pbjNKzCLfZ+FZePEh7LKAWjMsZEIqHxo+zZE3?=
 =?us-ascii?Q?+kD5IwbwzmEjf6Z35v6qfYSwsvS5/xZoiIwdQxhPJalOdzcTpsfqUdldIv+R?=
 =?us-ascii?Q?0dWZcZZeXx+Syc+tVkqUYB+Mfd6Yg8ZwfPegsrSOi1x8/H/y14OEIhLr4D0v?=
 =?us-ascii?Q?41NljaDugAC+8mXiNiWK1GmxmNsdmdQ+qBmlciN9YyuCUYp1lC69ifo8R+P5?=
 =?us-ascii?Q?qoFaHH6oZoH2p4RdwLS5uXpFpK/im0RUegGYOUu71JoKbXhMinuUKemWI4id?=
 =?us-ascii?Q?gn2Pisxoa7Kquf752sSYyAuEsnatGJdma9joQ39KzRAzI98y3pFeTTrLrGxf?=
 =?us-ascii?Q?VHzFUk7nDdAOIn75g4PSyG/09sePYv5ORk42D2EwbMo3fYc4cmkPgIMGk773?=
 =?us-ascii?Q?uj4lRRCOQHQlYlIXKUaLBSF8KhHsQ8jV/yli9/emU8m3T4NduRWViOdoa4CT?=
 =?us-ascii?Q?ZhAbL9jg1Cg8jRl3D1RmHbjVXiZp93FW2a1zJE//alXeRL7O6l8Hyjd7kpN+?=
 =?us-ascii?Q?rvZLWeiWyaMNsIHSMsPnp+CYyOSA2RExRlz0igc7djGOLiiFH0D7scPVtbtU?=
 =?us-ascii?Q?xm01krhjjo04dO+XmHGH8NMbiij8ZEf3ye1539Jn0G3pYNM0GSK6wB7ZpNiy?=
 =?us-ascii?Q?71Os0eqOQ9cnIEgx0uG1IrtAwUJLqGwD4KFihPhRtwQ/RS75RecFl9yCTQuR?=
 =?us-ascii?Q?QLXVTxaOT15Efl50XYUO/DrgmvKDdg+5I/h51ge46GlC7Z8uMv+21qtwg+Cq?=
 =?us-ascii?Q?1BA7vVVDH6aqSuS31ph20KKYovwH1JNF5jOVZZM/LRH62bvFuIeAytnxmi1S?=
 =?us-ascii?Q?Y5LQ27yL1V4FtGf2/8rG3aVeDAJt8+N6mDlKaHxyo8k31zWmVwC8GoNwxwzq?=
 =?us-ascii?Q?mRfdklgEbEMeDv+IiyS/VXkcriHztJvWlLY31Q/3KIjpN9WtK58HZQqYaL5C?=
 =?us-ascii?Q?glOKrR4+4ZMulWSMNCjLQ7MFC46BUhtFgJLu+/wCR2f/mY+R/rTWrxTZ4tQg?=
 =?us-ascii?Q?ZLmQgsVKwIeAeW2UUOPRa+R9UVZGF06/FIvJqXI59hlqtT47bbFblCdxDYGJ?=
 =?us-ascii?Q?Uj56j5QNoeZjtYPR2cSUJo+qzs+mvT6u+7U3AInEwB4TJj/DogfMYtEkQDZ9?=
 =?us-ascii?Q?RvjEZHNqBI3k7FqShNs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 13:26:09.8963
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892ef7cd-79c9-4b4e-7bf2-08de415daba8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9032

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
index 1035478d..b1bd0b3f 100644
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
2.47.0


