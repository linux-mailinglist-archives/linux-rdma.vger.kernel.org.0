Return-Path: <linux-rdma+bounces-9728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6DEA9878E
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 510984430CA
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31DA27817D;
	Wed, 23 Apr 2025 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ziso9h6B"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B92277811;
	Wed, 23 Apr 2025 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404341; cv=fail; b=Wy1E4NZc8/kiTlQJ7HcyO9EgcRvn8BMfAIMXR4yuipSWgq1Aptn+YHax/wduALtOkhrUUFGtMix+kMTTBpRsfrtVuCPYxetOmcL/rPHU68Q+o0Q3WORXqqFZNDFISszqHySgZJhs8vi6VoA2MhTvwx27x33lCGz+jODOoqhFjkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404341; c=relaxed/simple;
	bh=qi2sWENapw4K3Kh2D723BKIdLs8wbv1Mn3c1GHT0gRw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3Wvqw0jhLi4cA4SA6to4ZuqXipkBJzzf0t0eASCMEJv3lOPL0PPA4XOE7NZ61cysplq9gBPG0fxAco/l5p0/swoI8Qw8DetyPHqvgKP1S/qvvFIeitxNAdgBkZF/4sda7bpqtLirFdOC1h/eYqhuWwoi+vZXvljqXdH/To615c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ziso9h6B; arc=fail smtp.client-ip=40.107.101.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9HvhKqaMfyykGMqwAbU54wC4wTZaKR7c9lV0f+nO7HC4r/SCsFCUBzbAXNjxwiyfVSM20WZtV45t9+lj8WRGuNnf+oRTnXzC8m6lxylyDYvsCsR2wXIMjGWhq0vux11ryZKOJYSDhdmbwoupMvVmodCvEHuKkyG3XY9hjvOsL39lIKnCwTlv5eQHM2/bjpMzAfTa36nC7uGK+rDu0akcPLkwGi5Z1EU3MrBUkMTws48JpABm1/SQGHWQD7PknIyhljgfNjgirpjqMnwwU+yypBo8ybXcCf2mR09bgb93CgI5l+B3e70hKpxaQZi2NMTzqlLbr0F2LuqlJe5ysuLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei1b/BU/pExbtYf9gn8xQYnGDubWf47uNuNS5L0dYho=;
 b=wfsONE/W60SSoxUWdJ+psooSsOG8q2wp0+KEwz4aH9/CdLJcm85cOTn1C5oZoRPIYSLY9MRAxh/XsddcvH0CDBuixx1R8grdR+o6oNuh3hrNtPDDt1OsF2tBdSH3uWzW6t607wtMpvQJg3s3J15ghCCJUNwgFvzCa1LpzzKStA7JsorUCCFSyeU1NeDt+wNWlTFVBtn3wO1kYWDhSWE7MTg71jWR/T/N0Yyna8FXyVuYuVsSZRpBZ3AI2FmLufzskcS5B6Brjzo37tfuLV1aik5KsvV7p3Q5YvQHxEmWWniQmAGTMdEykONWWo2vQEEuUts63dzM9whLEZXGjv5X5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei1b/BU/pExbtYf9gn8xQYnGDubWf47uNuNS5L0dYho=;
 b=ziso9h6B/4VVOJwcU/wkdBdqUgB6KeoQV/fo0rDyj+0HTTT7LigxX1aOVbfLeuD2P/kH5nmblUpUrvZB9tTLjFzR19NbVHwocIrBoK6KTA/ginS/rNCHq4XoOcPPJ+VsKMQyjUIS2177ff/VaYxIUBWvZtB4peipik4e3/znDpU=
Received: from CH0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:610:b3::14)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.33; Wed, 23 Apr 2025 10:32:13 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::db) by CH0PR03CA0039.outlook.office365.com
 (2603:10b6:610:b3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 10:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:32:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 05:32:11 -0500
Received: from xhdipdslab48.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 23 Apr 2025 05:32:05 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH 13/14] RDMA/ionic: Implement device stats ops
Date: Wed, 23 Apr 2025 15:59:12 +0530
Message-ID: <20250423102913.438027-14-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423102913.438027-1-abhijit.gangurde@amd.com>
References: <20250423102913.438027-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: f939c8fc-5a59-4592-91e8-08dd82521c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZqs2dq/Yo0LWQiKLUnL6nbQjsFfIRlis+BG9Y3s3u1hN+TIQCnbe/NQTgMz?=
 =?us-ascii?Q?fsJj6/wZ+vQ3REIsDWae0k8whkfVpYSTWLxOFEX8DJQCzE/2TQsFKChbiUbX?=
 =?us-ascii?Q?hNLggA9Wj2F22Acde+NedvaKnk5pN8dmNHQuYUZoQR6nz/YC4L6IBAHpMF3K?=
 =?us-ascii?Q?ZGssXq4IOAa3PL5asLnjxS+Uwd9/YrxqyzwJEALC/Seg0IPGrs5paSB1Scfj?=
 =?us-ascii?Q?ZFk3GwE+CqYa4IZ+3FN75wUPxvR0M2XMp0tT7ivFEC6EWOakm88glThD2cLt?=
 =?us-ascii?Q?sz/DlhO75XlscGGwMtM0fNX7BBJIoWPms9kQuYcGpLgcHmCxwtSZVGNSJBcx?=
 =?us-ascii?Q?HkMMDkrAgxiv25Bdm6gaCcPc/q2jiHCXVe6pAsBshdli9t9jmnm/Na1HWKqG?=
 =?us-ascii?Q?A/lNiUXqz9cgG2qoWUwG7SknIF/m3JhjyDgFmSbh7mRbYCQqpcMjjcvfB5uv?=
 =?us-ascii?Q?4y4pK311kvaH9w6e0iPoToIzO3iGOfUo6TeN4jYCkiafwWDRO2gR0Po28bra?=
 =?us-ascii?Q?j2BDMIgA9lbuTCUOqKqJ/oaxDb/4yKJOiwToNxiy5rz+dRgRZOAuBbCRDHeW?=
 =?us-ascii?Q?C/BYRSPDqFFvaqfXyZWDi0DkVOWb30TvLM+QTqkBmXhNB1NFteB7LVb74853?=
 =?us-ascii?Q?Em3JRErIonEfjsJ0/vrHZLEURHA45G+Ao/9oXj82DUOxE23sUJwIqsK2cxBj?=
 =?us-ascii?Q?4MZgQtfrj1EioN9Fd9Cx82+4X53SK427JknoKth12XZgs0QBTC5x6MOJWjpY?=
 =?us-ascii?Q?jeCuZ0XVcv/9YCBRnY3vHVcFeWfVlovx9yxX8KPA5m8lV8khd2uB0czK87NA?=
 =?us-ascii?Q?jc1mTykX1rZHuyOW0MqUqfAMzFS63zWPfBQsTRYK1XlLgUKHuhP3gFoTeI6V?=
 =?us-ascii?Q?MQ9jDj/BZjj82LS45DQ5/+pC2lURcurgWQcrsxEcqxgKzodX3GQEYvtFUhRG?=
 =?us-ascii?Q?wFu0Q2ZHvu+UKgUznb51gXeKK72kVsc8/Yxz7LZQWDHkIDLChYwBxFLaITf2?=
 =?us-ascii?Q?200EwRwyG/9Wi3FufOm2FR39l/4pT2GoBxI2abJODI3gAq12GfrWJIOEt9l3?=
 =?us-ascii?Q?ugH+JZ9sLe45sloRqzqT2IvMwwCoRe+dUVaDuaawLDaSP2Zh5juLcDSnshd1?=
 =?us-ascii?Q?CHklFY9Tx8g+yfEaf3wbCJpDcZ69rIfd1iHuD35nLdXBUL62MqyIHK8V5fYa?=
 =?us-ascii?Q?cQQX3Ps4/UPgN7tT58Vfh/zonm36PUaIKywOSRwgg+Tl7Vbg28XvYLYsVr/D?=
 =?us-ascii?Q?Acg0cjCj53c2d3XY7KfAPiCf5p8rDmFO12UNGTrZUietqvjVPsjeiANT1QKq?=
 =?us-ascii?Q?CGV2s66bLhvcvZaKNK0SEMv5HGDZAk5vCYnY67ZniiEPt/ugBedG/u4xXp8O?=
 =?us-ascii?Q?cst1xLgmb8kYLggRFBf8OUF2QvzeY0zFu1VET7IrkiScmujoD34AJ0vAEmFy?=
 =?us-ascii?Q?QYu3q6PxPFchWtv89+AKpn2oLXZz56qR8xyrO41vTMHnoNHMrtGXknwt1pDu?=
 =?us-ascii?Q?S+9kIbUwS0UNF0GeuApeIVKtwcNQtgONkrwjLTvjN0M0F8XooOT2jwe0gg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:32:13.0742
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f939c8fc-5a59-4592-91e8-08dd82521c5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724

Implement device stats operations for hw stats and qp stats.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_fw.h       |  43 ++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c | 484 +++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.c    |   8 +-
 drivers/infiniband/hw/ionic/ionic_ibdev.h    |  24 +
 4 files changed, 558 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/ionic/ionic_hw_stats.c

diff --git a/drivers/infiniband/hw/ionic/ionic_fw.h b/drivers/infiniband/hw/ionic/ionic_fw.h
index 9971e1ccf4ee..2d9a2e9a0b60 100644
--- a/drivers/infiniband/hw/ionic/ionic_fw.h
+++ b/drivers/infiniband/hw/ionic/ionic_fw.h
@@ -661,6 +661,17 @@ static inline int ionic_v1_use_spec_sge(int min_sge, int spec)
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
@@ -839,6 +850,7 @@ struct ionic_v1_admin_wqe {
 	__le16				len;
 
 	union {
+		struct ionic_admin_stats_hdr stats;
 		struct ionic_admin_create_ah create_ah;
 		struct ionic_admin_destroy_ah destroy_ah;
 		struct ionic_admin_query_ah query_ah;
@@ -985,4 +997,35 @@ static inline u32 ionic_v1_eqe_evt_qid(u32 evt)
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
index 000000000000..8fe339233d44
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
+			.len = IONIC_ADMIN_STATS_HDRS_IN_V1_LEN,
+			.cmd.stats = {
+				.dma_addr = cpu_to_le64(dma),
+				.length = cpu_to_le32(len),
+				.id_ver = cpu_to_le32(qid),
+			},
+		}
+	};
+
+	if (dev->admin_opcodes <= op)
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
+	hw_stats_dma = dma_map_single(dev->hwdev, dev->hw_stats,
+				      PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->hwdev, hw_stats_dma);
+	if (rc)
+		goto err_dma;
+
+	rc = ionic_hw_stats_cmd(dev, hw_stats_dma, PAGE_SIZE, 0,
+				IONIC_V1_ADMIN_STATS_HDRS);
+	if (rc)
+		goto err_cmd;
+
+	dma_unmap_single(dev->hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
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
+	dma_unmap_single(dev->hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
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
+	hw_stats_dma = dma_map_single(dev->hwdev, dev->hw_stats_buf,
+				      PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->hwdev, hw_stats_dma);
+	if (rc)
+		goto err_dma;
+
+	rc = ionic_hw_stats_cmd(dev, hw_stats_dma, PAGE_SIZE,
+				0, IONIC_V1_ADMIN_STATS_VALS);
+	if (rc)
+		goto err_cmd;
+
+	dma_unmap_single(dev->hwdev, hw_stats_dma,
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
+	dma_unmap_single(dev->hwdev, hw_stats_dma,
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
+	hw_stats_dma = dma_map_single(dev->hwdev, cntr->vals,
+				      PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->hwdev, hw_stats_dma);
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
+	dma_unmap_single(dev->hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
+	return stat_i;
+
+err_cmd:
+	dma_unmap_single(dev->hwdev, hw_stats_dma, PAGE_SIZE, DMA_FROM_DEVICE);
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
+	hdr_dma = dma_map_single(dev->hwdev, cs->hdr,
+				 PAGE_SIZE, DMA_FROM_DEVICE);
+	rc = dma_mapping_error(dev->hwdev, hdr_dma);
+	if (rc)
+		goto err_dma;
+
+	rc = ionic_hw_stats_cmd(dev, hdr_dma, PAGE_SIZE, 0,
+				IONIC_V1_ADMIN_QP_STATS_HDRS);
+	if (rc)
+		goto err_cmd;
+
+	dma_unmap_single(dev->hwdev, hdr_dma, PAGE_SIZE, DMA_FROM_DEVICE);
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
+	dma_unmap_single(dev->hwdev, hdr_dma, PAGE_SIZE, DMA_FROM_DEVICE);
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
+	u16 stats_type = cpu_to_le16(dev->ident->rdma.stats_type);
+	int rc;
+
+	if (stats_type & IONIC_LIF_RDMA_STAT_GLOBAL) {
+		rc = ionic_init_hw_stats(dev);
+		if (rc)
+			netdev_dbg(dev->ndev, "ionic_rdma: Failed to init hw stats\n");
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
+			netdev_dbg(dev->ndev, "ionic_rdma: Failed to init counter stats\n");
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
index 731d280a301b..e8f1477277c9 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -267,6 +267,7 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 {
 	ionic_kill_rdma_admin(dev, false);
 	ib_unregister_device(&dev->ibdev);
+	ionic_stats_cleanup(dev);
 	ionic_destroy_rdma_admin(dev);
 	ionic_resid_destroy(&dev->inuse_qpid);
 	ionic_resid_destroy(&dev->inuse_cqid);
@@ -441,12 +442,17 @@ static struct ionic_ibdev *ionic_create_ibdev(void *handle,
 	ib_set_device_ops(&dev->ibdev, &ionic_dev_ops);
 	ionic_datapath_setops(dev);
 	ionic_controlpath_setops(dev);
+
+	ionic_stats_init(dev);
+
 	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
 	if (rc)
-		goto err_register;
+		goto err_stats;
 
 	return dev;
 
+err_stats:
+	ionic_stats_cleanup(dev);
 err_register:
 	ionic_kill_rdma_admin(dev, false);
 	ionic_destroy_rdma_admin(dev);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 00ad562b4713..30bb0905d3d4 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -36,6 +36,7 @@
 #define IONIC_GID_TBL_LEN 256
 #define IONIC_MAX_PD 1024
 
+#define IONIC_MAX_QPID 0xffffff
 #define IONIC_SPEC_HIGH 8
 #define IONIC_MAX_PD 1024
 #define IONIC_SQCMB_ORDER 5
@@ -153,6 +154,13 @@ struct ionic_ibdev {
 
 	struct ionic_eq		**eq_vec;
 	int			eq_count;
+
+	int			hw_stats_count;
+	struct ionic_v1_stat	*hw_stats;
+	void			*hw_stats_buf;
+	struct rdma_stat_desc	*hw_stats_hdrs;
+
+	struct ionic_counter_stats *counter_stats;
 };
 
 struct ionic_eq {
@@ -379,6 +387,18 @@ struct ionic_mr {
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
@@ -499,6 +519,10 @@ void ionic_notify_flush_cq(struct ionic_cq *cq);
 /* ionic_datapath.c */
 void ionic_datapath_setops(struct ionic_ibdev *dev);
 
+/* ionic_hw_stats.c */
+void ionic_stats_init(struct ionic_ibdev *dev);
+void ionic_stats_cleanup(struct ionic_ibdev *dev);
+
 /* ionic_pgtbl.c */
 __le64 ionic_pgtbl_dma(struct ionic_tbl_buf *buf, u64 va);
 __be64 ionic_pgtbl_off(struct ionic_tbl_buf *buf, u64 va);
-- 
2.34.1


