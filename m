Return-Path: <linux-rdma+bounces-13060-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1622EB4150E
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 08:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86915561A53
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4B2E62C3;
	Wed,  3 Sep 2025 06:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tSrehu9q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDF92E2EE5;
	Wed,  3 Sep 2025 06:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756880309; cv=fail; b=ssFo0BJFmvQYveCXi0wlt0Kex1/OK6sFgpbxwr5yEl5PF6h9I3gluswFJt0B0CKOWNZrl0HkUBsNZtVF3bAIouhysjZT1VwkkHq8t67vTSWmt9EHCawycKlhdJneVCwb0z1l8SIzJt9c69+NYcXJGCRR09O86IDHuX/TiHlp1xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756880309; c=relaxed/simple;
	bh=99hbURMuhVfbPAfZGTRkNM3EqRhxO9+W3T7P5aGDrDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NtU8It6ITX/Jj8a7wr358di0rHlBM+f6tk7s+Ww8uV/Njw6url78tU3dHzDbeK9AKbO4w+sbXX0q/QML3ep/TDTMI/dDhrCfz99/S3MXq9qyp+Op4cf58l1TgdNDKtdwS+csqVpkZ7349CwFc8IudnJJihQU0kjVs78bFb0Sa1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tSrehu9q; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPyiacc1yMe8Hz2EkvQ4H1TITtuN4CSTP1CFk4jBKTr5HBmehJLz7piDhlv6HS6a3HDv6E8zhyNfENzKvqulhcKWrshcEAqnzwrxFUqPaxA3gZ/6IVETxwjQ2sWjNJmQrDdNNgyTdrSM9JgRi1k8iCoc+00PDj/ZUmtWqm6x1irBEgaw3LSgum54ppvyT2xsn0ICr8hRhM+ug1oZtRfmmhywK3w2M92UoQMFLeRLm3NQ29ZK7yCFWAInLU/Fcbsu2+TwQPoshwgmVLW6WOKZSM3Vp+SNaHvnnzX465gHNTLGyufpkCcMvCgfXQS9Y9qv5a41t+M6TdTjfcO0eaQl4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VC29UU9BkpBaAZYNr0IQJ2Pqaie12wsP53Oe2rPr0vM=;
 b=OcNxsz1Z6y6wSIHb2Kfu96S3/rDL/BrixmUViH0m2C0C/fo8FlH+VEToq7xN6pnsvEmB0x63ORKpe2ntTl7fMUplwg8FzhqucgJlaTawlbVPqAH61HdrTZAbTmRfpvGH2kw3qVOiDb84zRpoIlZ+ood4UiN1kVRTLbkxVCoS3pzcIGNadg/7r/YaekkCopLK7yeeZcWQI+oO+NcMuZVVW4z91Ezf2VkMitCjlXOuATIlYy3AFLJeyuzfQUBpqsc36h/dwsNCMxB3wRO1/9VNOrco6WRr3qfJfAD9AX5gePzuox17rlOz3XFVaJqsRDuP0H+vq7OzqeYjx8+d/+SPAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VC29UU9BkpBaAZYNr0IQJ2Pqaie12wsP53Oe2rPr0vM=;
 b=tSrehu9qWYRmbjyj6wbn8Gh6StK741r0s29csUQvI7YFyx7CmNnscOm+7qJaQL//D8azdIn+2ON6YZen94ogV0pZF13wfKLLT4cfgRyn/bYs+vIxg/y/TftzZE0BPEe5gIWZMlw9Vvrsxba4UqHRNjZG24A23974dldnQfbvKNo=
Received: from DS7PR03CA0292.namprd03.prod.outlook.com (2603:10b6:5:3ad::27)
 by SA3PR12MB8022.namprd12.prod.outlook.com (2603:10b6:806:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 06:18:19 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::ef) by DS7PR03CA0292.outlook.office365.com
 (2603:10b6:5:3ad::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Wed,
 3 Sep 2025 06:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 06:18:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 01:18:18 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 3 Sep 2025 01:18:14 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>, <jgg@ziepe.ca>,
	<leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <sln@onemain.com>, <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v6 13/14] RDMA/ionic: Implement device stats ops
Date: Wed, 3 Sep 2025 11:46:05 +0530
Message-ID: <20250903061606.4139957-14-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
References: <20250903061606.4139957-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SA3PR12MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: cc29ee61-7629-4ef2-a7bc-08ddeab1ad75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HrZXKqH3PUFHJ7tnDVTt0EXq2TuZ72KiH6e7DU8iS3myzwKj9W0Hga0XhM6H?=
 =?us-ascii?Q?EAqt0zIo+M6YetwekBLQMnqFDekUWV1OzyiqU1pQ6RvebSMZ603nsLw3L6BY?=
 =?us-ascii?Q?GLX7/fNgo2hz1s8XQoKaMmH3CXVK96T/u8vm4/arb653v+ljrWUwAsHLiM1A?=
 =?us-ascii?Q?iSpT/iJTwPoYy/8LY3mClon0wDozKYPnES2HtA2FWG03QSlv1OIEvIOAysxI?=
 =?us-ascii?Q?JlRS/13DDe85n6V234RnSAkxBiloneNlUow2Bjh+kaxkK/T9ClW8iNewMvIU?=
 =?us-ascii?Q?dqDPxzcTV3XaMzgP8x0Wkhw0n3kuEvISKQhw4pMN/bKITCEh3ACzA5lhJoFf?=
 =?us-ascii?Q?j3G0b+4SwQAyvgaYTgoW/1JOG0cP0KQF/w+cMtQ66jxzBLxtSWXPJRGNZf9m?=
 =?us-ascii?Q?iBXg56Im94cbPPeyGgT+rjPZwuaZ1JUVUjgYegEQ9QOmJEUcuPz0zujUAaCK?=
 =?us-ascii?Q?PIgVvn1+7DboFX5t8G2GW4O2VZXfzntxhTfv6Bx2u2haSTKBzA4I9sLEF7zb?=
 =?us-ascii?Q?7sE+KUusQ0xqXLFmKacPnQ+aZeD7R6XR0bDnLvgkSeSzH4owshDFlp9lDYPw?=
 =?us-ascii?Q?25C/zMFToH3AeVLbKMmvH8B66fesDwSpWTXc4U+oZ16FrZdrJ5Njc9QHAXH7?=
 =?us-ascii?Q?fJLQwQkyzXnbnnA764cl7AXmbQ0cr/2f1NpB3dLYfP/RGrLoc5w0kd0Go1nQ?=
 =?us-ascii?Q?5GCQCUqhH4Gdw83iKFPtuAx5tRlwnVcpGO8LI32WWR7WOkipRh5g4HNIo+H/?=
 =?us-ascii?Q?QrkfO+DYISaccEYwOW2r1ey99Tn2eyhTzQcyKOIJIQCx/vndwepKuvg1CB4a?=
 =?us-ascii?Q?c93X2iluTWPj5VsEHk3i9m3aW2RVt0vuD8UVQnz2VDOYJfP+vIHuKmXg0/I3?=
 =?us-ascii?Q?Xt/rmSCDg2sdQ+NxdMngQRaENZkBJ54qZr1RNEoXItp1BntWfWmhP5Z7AB5A?=
 =?us-ascii?Q?Akeg6UK6zah9CDA9qHp4U54TUzOUtD6QoeKDr4KuvrsJDm8mu0Fhl+ddIdk5?=
 =?us-ascii?Q?G09kmwTn0U9jcnFkRuL6HCCQzgoXgb1gkYB/e6fjqflEduz0ZvcBMGSpNf5Q?=
 =?us-ascii?Q?xMmHhVJEAuMSK6d9xUu9l8Qi5dRlPMWXsdijz0ncPKLlQqX7lMsqtGYmx4im?=
 =?us-ascii?Q?jm1DphqAo7YvUf/RejZgdNlNvnly0xdMMhdC8CTC3OSjPezUqAzh96wavQOA?=
 =?us-ascii?Q?ZCiwZgRAL3+3h0napo6oxnSkMsK0/rW/H3PU93O+v6/jAdllyNvvq27YaZ2R?=
 =?us-ascii?Q?HfZzPgwBZI3Z+P7sUH6zPGEiBY/avxxzapNMwT86XhTMmzHOGrcV8ERraQ7R?=
 =?us-ascii?Q?cLNODiiYzL5sywxt6ztss1c+hvWnOx+1qt3j3cc/TttnoVFv2qSVAWRIdLY3?=
 =?us-ascii?Q?JxESYqAxCoKL5jZJzbEX7Xtn9f1sLD7lDSIsoDT05lBC796LyuVBA2TQmT2E?=
 =?us-ascii?Q?LA/+2jnYKeLp6RTvpIN5Kc+wAG4+ixgs8CvrbVieADvIuGVU5K6cCwuFH0wb?=
 =?us-ascii?Q?j9JkQb+14OrcTEvOeF/Zz6oMj4Uc3S/xmPt5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 06:18:19.5949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc29ee61-7629-4ef2-a7bc-08ddeab1ad75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8022

Implement device stats operations for hw stats and qp stats.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
v2->v3
  - Fixed sparse checks

 drivers/infiniband/hw/ionic/ionic_fw.h       |  43 ++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c | 484 +++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.c    |   4 +
 drivers/infiniband/hw/ionic/ionic_ibdev.h    |  23 +
 4 files changed, 554 insertions(+)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_hw_stats.c

diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index d48ee000f334..8575a374808d 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -659,6 +659,17 @@ static inline int ionic_v1_use_spec_sge(int min_sge, int spec)
 	return spec;
 }
 
+struct ionic_admin_stats_hdr {
+	__le64		dma_addr;
+	__le32		length;
+	__le32		id_ver;
+	__u8		type_state;
+} __packed;
+
+#define IONIC_ADMIN_STATS_HDRS_IN_V1_LEN 17
+static_assert(sizeof(struct ionic_admin_stats_hdr) ==
+	       IONIC_ADMIN_STATS_HDRS_IN_V1_LEN);
+
 struct ionic_admin_create_ah {
 	__le64		dma_addr;
 	__le32		length;
@@ -837,6 +848,7 @@ struct ionic_v1_admin_wqe {
 	__le16				len;
 
 	union {
+		struct ionic_admin_stats_hdr stats;
 		struct ionic_admin_create_ah create_ah;
 		struct ionic_admin_destroy_ah destroy_ah;
 		struct ionic_admin_query_ah query_ah;
@@ -983,4 +995,35 @@ static inline u32 ionic_v1_eqe_evt_qid(u32 evt)
 	return evt >> IONIC_V1_EQE_QID_SHIFT;
 }
 
+enum ionic_v1_stat_bits {
+	IONIC_V1_STAT_TYPE_SHIFT	= 28,
+	IONIC_V1_STAT_TYPE_NONE		= 0,
+	IONIC_V1_STAT_TYPE_8		= 1,
+	IONIC_V1_STAT_TYPE_LE16		= 2,
+	IONIC_V1_STAT_TYPE_LE32		= 3,
+	IONIC_V1_STAT_TYPE_LE64		= 4,
+	IONIC_V1_STAT_TYPE_BE16		= 5,
+	IONIC_V1_STAT_TYPE_BE32		= 6,
+	IONIC_V1_STAT_TYPE_BE64		= 7,
+	IONIC_V1_STAT_OFF_MASK		= BIT(IONIC_V1_STAT_TYPE_SHIFT) - 1,
+};
+
+struct ionic_v1_stat {
+	union {
+		__be32		be_type_off;
+		u32		type_off;
+	};
+	char			name[28];
+};
+
+static inline int ionic_v1_stat_type(struct ionic_v1_stat *hdr)
+{
+	return hdr->type_off >> IONIC_V1_STAT_TYPE_SHIFT;
+}
+
+static inline unsigned int ionic_v1_stat_off(struct ionic_v1_stat *hdr)
+{
+	return hdr->type_off & IONIC_V1_STAT_OFF_MASK;
+}
+
 #endif /* _IONIC_FW_H_ */
diff --git a/drivers/infiniband/hw/ionic/ionic_hw_stats.c b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
new file mode 100644
index 000000000000..244a80dde08f
--- /dev/null
+++ b/drivers/infiniband/hw/ionic/ionic_hw_stats.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2018-2025, Advanced Micro Devices, Inc. */
+
+#include <linux/dma-mapping.h>
+
+#include "ionic_fw.h"
+#include "ionic_ibdev.h"
+
+static int ionic_v1_stat_normalize(struct ionic_v1_stat *hw_stats,
+				   int hw_stats_count)
+{
+	int hw_stat_i;
+
+	for (hw_stat_i = 0; hw_stat_i < hw_stats_count; ++hw_stat_i) {
+		struct ionic_v1_stat *stat = &hw_stats[hw_stat_i];
+
+		stat->type_off = be32_to_cpu(stat->be_type_off);
+		stat->name[sizeof(stat->name) - 1] = 0;
+		if (ionic_v1_stat_type(stat) == IONIC_V1_STAT_TYPE_NONE)
+			break;
+	}
+
+	return hw_stat_i;
+}
+
+static void ionic_fill_stats_desc(struct rdma_stat_desc *hw_stats_hdrs,
+				  struct ionic_v1_stat *hw_stats,
+				  int hw_stats_count)
+{
+	int hw_stat_i;
+
+	for (hw_stat_i = 0; hw_stat_i < hw_stats_count; ++hw_stat_i) {
+		struct ionic_v1_stat *stat = &hw_stats[hw_stat_i];
+
+		hw_stats_hdrs[hw_stat_i].name = stat->name;
+	}
+}
+
+static u64 ionic_v1_stat_val(struct ionic_v1_stat *stat,
+			     void *vals_buf, size_t vals_len)
+{
+	unsigned int off = ionic_v1_stat_off(stat);
+	int type = ionic_v1_stat_type(stat);
+
+#define __ionic_v1_stat_validate(__type)		\
+	((off + sizeof(__type) <= vals_len) &&		\
+	 (IS_ALIGNED(off, sizeof(__type))))
+
+	switch (type) {
+	case IONIC_V1_STAT_TYPE_8:
+		if (__ionic_v1_stat_validate(u8))
+			return *(u8 *)(vals_buf + off);
+		break;
+	case IONIC_V1_STAT_TYPE_LE16:
+		if (__ionic_v1_stat_validate(__le16))
+			return le16_to_cpu(*(__le16 *)(vals_buf + off));
+		break;
+	case IONIC_V1_STAT_TYPE_LE32:
+		if (__ionic_v1_stat_validate(__le32))
+			return le32_to_cpu(*(__le32 *)(vals_buf + off));
+		break;
+	case IONIC_V1_STAT_TYPE_LE64:
+		if (__ionic_v1_stat_validate(__le64))
+			return le64_to_cpu(*(__le64 *)(vals_buf + off));
+		break;
+	case IONIC_V1_STAT_TYPE_BE16:
+		if (__ionic_v1_stat_validate(__be16))
+			return be16_to_cpu(*(__be16 *)(vals_buf + off));
+		break;
+	case IONIC_V1_STAT_TYPE_BE32:
+		if (__ionic_v1_stat_validate(__be32))
+			return be32_to_cpu(*(__be32 *)(vals_buf + off));
+		break;
+	case IONIC_V1_STAT_TYPE_BE64:
+		if (__ionic_v1_stat_validate(__be64))
+			return be64_to_cpu(*(__be64 *)(vals_buf + off));
+		break;
+	}
+
+	return ~0ull;
+#undef __ionic_v1_stat_validate
+}
+
+static int ionic_hw_stats_cmd(struct ionic_ibdev *dev,
+			      dma_addr_t dma, size_t len, int qid, int op)
+{
+	struct ionic_admin_wr wr = {
+		.work = COMPLETION_INITIALIZER_ONSTACK(wr.work),
+		.wqe = {
+			.op = op,
+			.len = cpu_to_le16(IONIC_ADMIN_STATS_HDRS_IN_V1_LEN),
+			.cmd.stats = {
+				.dma_addr = cpu_to_le64(dma),
+				.length = cpu_to_le32(len),
+				.id_ver = cpu_to_le32(qid),
+			},
+		}
+	};
+
+	if (dev->lif_cfg.admin_opcodes <= op)
+		return -EBADRQC;
+
+	ionic_admin_post(dev, &wr);
+
+	return ionic_admin_wait(dev, &wr, IONIC_ADMIN_F_INTERRUPT);
+}
+
+static int ionic_init_hw_stats(struct ionic_ibdev *dev)
+{
+	dma_addr_t hw_stats_dma;
+	int rc, hw_stats_count;
+
+	if (dev->hw_stats_hdrs)
+		return 0;
+
+	dev->hw_stats_count = 0;
+
+	/* buffer for current values from the device */
+	dev->hw_stats_buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!dev->hw_stats_buf) {
+		rc = -ENOMEM;
+		goto err_buf;
+	}
+
+	/* buffer for names, sizes, offsets of values */
+	dev->hw_stats = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!dev->hw_stats) {
+		rc = -ENOMEM;
+		goto err_hw_stats;
+	}
+
+	/* request the names, sizes, offsets */
+	hw_stats_dma = dma_map_single(dev->lif_cfg.hwdev, dev->hw_stats,
+				      PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, hw_stats_dma);
+	if (rc)
+		goto err_dma;
+
+	rc = ionic_hw_stats_cmd(dev, hw_stats_dma, PAGE_SIZE, 0,
+				IONIC_V1_ADMIN_STATS_HDRS);
+	if (rc)
+		goto err_cmd;
+
+	dma_unmap_single(dev->lif_cfg.hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
+
+	/* normalize and count the number of hw_stats */
+	hw_stats_count =
+		ionic_v1_stat_normalize(dev->hw_stats,
+					PAGE_SIZE / sizeof(*dev->hw_stats));
+	if (!hw_stats_count) {
+		rc = -ENODATA;
+		goto err_dma;
+	}
+
+	dev->hw_stats_count = hw_stats_count;
+
+	/* alloc and init array of names, for alloc_hw_stats */
+	dev->hw_stats_hdrs = kcalloc(hw_stats_count,
+				     sizeof(*dev->hw_stats_hdrs),
+				     GFP_KERNEL);
+	if (!dev->hw_stats_hdrs) {
+		rc = -ENOMEM;
+		goto err_dma;
+	}
+
+	ionic_fill_stats_desc(dev->hw_stats_hdrs, dev->hw_stats,
+			      hw_stats_count);
+
+	return 0;
+
+err_cmd:
+	dma_unmap_single(dev->lif_cfg.hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
+err_dma:
+	kfree(dev->hw_stats);
+err_hw_stats:
+	kfree(dev->hw_stats_buf);
+err_buf:
+	dev->hw_stats_count = 0;
+	dev->hw_stats = NULL;
+	dev->hw_stats_buf = NULL;
+	dev->hw_stats_hdrs = NULL;
+	return rc;
+}
+
+static struct rdma_hw_stats *ionic_alloc_hw_stats(struct ib_device *ibdev,
+						  u32 port)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+
+	if (port != 1)
+		return NULL;
+
+	return rdma_alloc_hw_stats_struct(dev->hw_stats_hdrs,
+					  dev->hw_stats_count,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static int ionic_get_hw_stats(struct ib_device *ibdev,
+			      struct rdma_hw_stats *hw_stats,
+			      u32 port, int index)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+	dma_addr_t hw_stats_dma;
+	int rc, hw_stat_i;
+
+	if (port != 1)
+		return -EINVAL;
+
+	hw_stats_dma = dma_map_single(dev->lif_cfg.hwdev, dev->hw_stats_buf,
+				      PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, hw_stats_dma);
+	if (rc)
+		goto err_dma;
+
+	rc = ionic_hw_stats_cmd(dev, hw_stats_dma, PAGE_SIZE,
+				0, IONIC_V1_ADMIN_STATS_VALS);
+	if (rc)
+		goto err_cmd;
+
+	dma_unmap_single(dev->lif_cfg.hwdev, hw_stats_dma,
+			 PAGE_SIZE, DMA_FROM_DEVICE);
+
+	for (hw_stat_i = 0; hw_stat_i < dev->hw_stats_count; ++hw_stat_i)
+		hw_stats->value[hw_stat_i] =
+			ionic_v1_stat_val(&dev->hw_stats[hw_stat_i],
+					  dev->hw_stats_buf, PAGE_SIZE);
+
+	return hw_stat_i;
+
+err_cmd:
+	dma_unmap_single(dev->lif_cfg.hwdev, hw_stats_dma,
+			 PAGE_SIZE, DMA_FROM_DEVICE);
+err_dma:
+	return rc;
+}
+
+static struct rdma_hw_stats *
+ionic_counter_alloc_stats(struct rdma_counter *counter)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(counter->device);
+	struct ionic_counter *cntr;
+	int err;
+
+	cntr = kzalloc(sizeof(*cntr), GFP_KERNEL);
+	if (!cntr)
+		return NULL;
+
+	/* buffer for current values from the device */
+	cntr->vals = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!cntr->vals)
+		goto err_vals;
+
+	err = xa_alloc(&dev->counter_stats->xa_counters, &counter->id,
+		       cntr,
+		       XA_LIMIT(0, IONIC_MAX_QPID),
+		       GFP_KERNEL);
+	if (err)
+		goto err_xa;
+
+	INIT_LIST_HEAD(&cntr->qp_list);
+
+	return rdma_alloc_hw_stats_struct(dev->counter_stats->stats_hdrs,
+					 dev->counter_stats->queue_stats_count,
+					 RDMA_HW_STATS_DEFAULT_LIFESPAN);
+err_xa:
+	kfree(cntr->vals);
+err_vals:
+	kfree(cntr);
+
+	return NULL;
+}
+
+static int ionic_counter_dealloc(struct rdma_counter *counter)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(counter->device);
+	struct ionic_counter *cntr;
+
+	cntr = xa_erase(&dev->counter_stats->xa_counters, counter->id);
+	if (!cntr)
+		return -EINVAL;
+
+	kfree(cntr->vals);
+	kfree(cntr);
+
+	return 0;
+}
+
+static int ionic_counter_bind_qp(struct rdma_counter *counter,
+				 struct ib_qp *ibqp,
+				 u32 port)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(counter->device);
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+	struct ionic_counter *cntr;
+
+	cntr = xa_load(&dev->counter_stats->xa_counters, counter->id);
+	if (!cntr)
+		return -EINVAL;
+
+	list_add_tail(&qp->qp_list_counter, &cntr->qp_list);
+	ibqp->counter = counter;
+
+	return 0;
+}
+
+static int ionic_counter_unbind_qp(struct ib_qp *ibqp, u32 port)
+{
+	struct ionic_qp *qp = to_ionic_qp(ibqp);
+
+	if (ibqp->counter) {
+		list_del(&qp->qp_list_counter);
+		ibqp->counter = NULL;
+	}
+
+	return 0;
+}
+
+static int ionic_get_qp_stats(struct ib_device *ibdev,
+			      struct rdma_hw_stats *hw_stats,
+			      u32 counter_id)
+{
+	struct ionic_ibdev *dev = to_ionic_ibdev(ibdev);
+	struct ionic_counter_stats *cs;
+	struct ionic_counter *cntr;
+	dma_addr_t hw_stats_dma;
+	struct ionic_qp *qp;
+	int rc, stat_i = 0;
+
+	cs = dev->counter_stats;
+	cntr = xa_load(&cs->xa_counters, counter_id);
+	if (!cntr)
+		return -EINVAL;
+
+	hw_stats_dma = dma_map_single(dev->lif_cfg.hwdev, cntr->vals,
+				      PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, hw_stats_dma);
+	if (rc)
+		return rc;
+
+	memset(hw_stats->value, 0, sizeof(u64) * hw_stats->num_counters);
+
+	list_for_each_entry(qp, &cntr->qp_list, qp_list_counter) {
+		rc = ionic_hw_stats_cmd(dev, hw_stats_dma, PAGE_SIZE,
+					qp->qpid,
+					IONIC_V1_ADMIN_QP_STATS_VALS);
+		if (rc)
+			goto err_cmd;
+
+		for (stat_i = 0; stat_i < cs->queue_stats_count; ++stat_i)
+			hw_stats->value[stat_i] +=
+				ionic_v1_stat_val(&cs->hdr[stat_i],
+						  cntr->vals,
+						  PAGE_SIZE);
+	}
+
+	dma_unmap_single(dev->lif_cfg.hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
+	return stat_i;
+
+err_cmd:
+	dma_unmap_single(dev->lif_cfg.hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
+
+	return rc;
+}
+
+static int ionic_counter_update_stats(struct rdma_counter *counter)
+{
+	return ionic_get_qp_stats(counter->device, counter->stats, counter->id);
+}
+
+static int ionic_alloc_counters(struct ionic_ibdev *dev)
+{
+	struct ionic_counter_stats *cs = dev->counter_stats;
+	int rc, hw_stats_count;
+	dma_addr_t hdr_dma;
+
+	/* buffer for names, sizes, offsets of values */
+	cs->hdr = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!cs->hdr)
+		return -ENOMEM;
+
+	hdr_dma = dma_map_single(dev->lif_cfg.hwdev, cs->hdr,
+				 PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->lif_cfg.hwdev, hdr_dma);
+	if (rc)
+		goto err_dma;
+
+	rc = ionic_hw_stats_cmd(dev, hdr_dma, PAGE_SIZE, 0,
+				IONIC_V1_ADMIN_QP_STATS_HDRS);
+	if (rc)
+		goto err_cmd;
+
+	dma_unmap_single(dev->lif_cfg.hwdev, hdr_dma, PAGE_SIZE, DMA_FROM_DEVICE);
+
+	/* normalize and count the number of hw_stats */
+	hw_stats_count = ionic_v1_stat_normalize(cs->hdr,
+						 PAGE_SIZE / sizeof(*cs->hdr));
+	if (!hw_stats_count) {
+		rc = -ENODATA;
+		goto err_dma;
+	}
+
+	cs->queue_stats_count = hw_stats_count;
+
+	/* alloc and init array of names */
+	cs->stats_hdrs = kcalloc(hw_stats_count, sizeof(*cs->stats_hdrs),
+				 GFP_KERNEL);
+	if (!cs->stats_hdrs) {
+		rc = -ENOMEM;
+		goto err_dma;
+	}
+
+	ionic_fill_stats_desc(cs->stats_hdrs, cs->hdr, hw_stats_count);
+
+	return 0;
+
+err_cmd:
+	dma_unmap_single(dev->lif_cfg.hwdev, hdr_dma, PAGE_SIZE, DMA_FROM_DEVICE);
+err_dma:
+	kfree(cs->hdr);
+
+	return rc;
+}
+
+static const struct ib_device_ops ionic_hw_stats_ops = {
+	.driver_id = RDMA_DRIVER_IONIC,
+	.alloc_hw_port_stats = ionic_alloc_hw_stats,
+	.get_hw_stats = ionic_get_hw_stats,
+};
+
+static const struct ib_device_ops ionic_counter_stats_ops = {
+	.counter_alloc_stats = ionic_counter_alloc_stats,
+	.counter_dealloc = ionic_counter_dealloc,
+	.counter_bind_qp = ionic_counter_bind_qp,
+	.counter_unbind_qp = ionic_counter_unbind_qp,
+	.counter_update_stats = ionic_counter_update_stats,
+};
+
+void ionic_stats_init(struct ionic_ibdev *dev)
+{
+	u16 stats_type = dev->lif_cfg.stats_type;
+	int rc;
+
+	if (stats_type & IONIC_LIF_RDMA_STAT_GLOBAL) {
+		rc = ionic_init_hw_stats(dev);
+		if (rc)
+			ibdev_dbg(&dev->ibdev, "Failed to init hw stats\n");
+		else
+			ib_set_device_ops(&dev->ibdev, &ionic_hw_stats_ops);
+	}
+
+	if (stats_type & IONIC_LIF_RDMA_STAT_QP) {
+		dev->counter_stats = kzalloc(sizeof(*dev->counter_stats),
+					     GFP_KERNEL);
+		if (!dev->counter_stats)
+			return;
+
+		rc = ionic_alloc_counters(dev);
+		if (rc) {
+			ibdev_dbg(&dev->ibdev, "Failed to init counter stats\n");
+			kfree(dev->counter_stats);
+			dev->counter_stats = NULL;
+			return;
+		}
+
+		xa_init_flags(&dev->counter_stats->xa_counters, XA_FLAGS_ALLOC);
+
+		ib_set_device_ops(&dev->ibdev, &ionic_counter_stats_ops);
+	}
+}
+
+void ionic_stats_cleanup(struct ionic_ibdev *dev)
+{
+	if (dev->counter_stats) {
+		xa_destroy(&dev->counter_stats->xa_counters);
+		kfree(dev->counter_stats->hdr);
+		kfree(dev->counter_stats->stats_hdrs);
+		kfree(dev->counter_stats);
+		dev->counter_stats = NULL;
+	}
+
+	kfree(dev->hw_stats);
+	kfree(dev->hw_stats_buf);
+	kfree(dev->hw_stats_hdrs);
+}
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.c b/drivers/infiniband/hw/ionic/ionic_ibdev.c
index 5f51873af350..164046d00e5d 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -289,6 +289,7 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 {
 	ionic_kill_rdma_admin(dev, false);
 	ib_unregister_device(&dev->ibdev);
+	ionic_stats_cleanup(dev);
 	ionic_destroy_rdma_admin(dev);
 	ionic_destroy_resids(dev);
 	WARN_ON(!xa_empty(&dev->qp_tbl));
@@ -346,6 +347,8 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 
 	ib_set_device_ops(&dev->ibdev, &ionic_dev_ops);
 
+	ionic_stats_init(dev);
+
 	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
 	if (rc)
 		goto err_register;
@@ -353,6 +356,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	return dev;
 
 err_register:
+	ionic_stats_cleanup(dev);
 err_admin:
 	ionic_kill_rdma_admin(dev, false);
 	ionic_destroy_rdma_admin(dev);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index c750e049fecc..b7a1a57bae03 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -30,6 +30,7 @@
 #define IONIC_PKEY_TBL_LEN 1
 #define IONIC_GID_TBL_LEN 256
 
+#define IONIC_MAX_QPID 0xffffff
 #define IONIC_SPEC_HIGH 8
 #define IONIC_MAX_PD 1024
 #define IONIC_SPEC_HIGH 8
@@ -109,6 +110,12 @@ struct ionic_ibdev {
 	atomic_t		admin_state;
 
 	struct ionic_eq		**eq_vec;
+
+	struct ionic_v1_stat	*hw_stats;
+	void			*hw_stats_buf;
+	struct rdma_stat_desc	*hw_stats_hdrs;
+	struct ionic_counter_stats *counter_stats;
+	int			hw_stats_count;
 };
 
 struct ionic_eq {
@@ -320,6 +327,18 @@ struct ionic_mr {
 	bool			created;
 };
 
+struct ionic_counter_stats {
+	int queue_stats_count;
+	struct ionic_v1_stat *hdr;
+	struct rdma_stat_desc *stats_hdrs;
+	struct xarray xa_counters;
+};
+
+struct ionic_counter {
+	void *vals;
+	struct list_head qp_list;
+};
+
 static inline struct ionic_ibdev *to_ionic_ibdev(struct ib_device *ibdev)
 {
 	return container_of(ibdev, struct ionic_ibdev, ibdev);
@@ -480,6 +499,10 @@ int ionic_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
 int ionic_poll_cq(struct ib_cq *ibcq, int nwc, struct ib_wc *wc);
 int ionic_req_notify_cq(struct ib_cq *ibcq, enum ib_cq_notify_flags flags);
 
+/* ionic_hw_stats.c */
+void ionic_stats_init(struct ionic_ibdev *dev);
+void ionic_stats_cleanup(struct ionic_ibdev *dev);
+
 /* ionic_pgtbl.c */
 __le64 ionic_pgtbl_dma(struct ionic_tbl_buf *buf, u64 va);
 __be64 ionic_pgtbl_off(struct ionic_tbl_buf *buf, u64 va);
-- 
2.43.0


