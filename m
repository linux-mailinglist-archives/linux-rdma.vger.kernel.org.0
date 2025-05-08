Return-Path: <linux-rdma+bounces-10145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B33AAF27E
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 07:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428591C20159
	for <lists+linux-rdma@lfdr.de>; Thu,  8 May 2025 05:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A4C231C87;
	Thu,  8 May 2025 05:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yO1B28l+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421C22D9F3;
	Thu,  8 May 2025 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746680509; cv=fail; b=F6+oMKCLg/omOt8v1yqLeWywL7o/+5HSJjMmmQGOB5dmS9biMQ3qBVqSf0qFU/r2ScESVGiYjZAYepp/O7UNTlz5xyJ+l2XdgDoViB4ZRKffYyM1AeWesFTpkJ3Za9i5n2GQDXrRAmfPTjtGwDetelxVSPs9/j8iYiwA141fl50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746680509; c=relaxed/simple;
	bh=WvYQ5MxjI6dEWkysbHKnafmvvsGe0ZfhtWz7oBzmtoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl3WZxwOf3RTzjOzL3c7RYFyagq0HSTQK+l0Qjc2awe7JC1lHeX5PfYfVdkY7IDVkHz7Gy0rpp+P1PULQ4DDb5gVABJpXdg5TMnPJsOQ73LHIR1dlV0jGTMquM80uj3emzq56aONv8D7xMzHE8ahfMs+cOFPGMajcfqMMYgfpX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yO1B28l+; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XNG+KdaV/cznDAEnAAGjndBpnBUeSP2djQrRvHB99bi8kNHESdPkskFLtF4V6iYHANoUVXAAHZMA4QaBdSZHtZUvEoDmQp6DYrSw44Hj2Ge6BCxY0ogSfrHuavbBdKHBgXOcquV4coRzuUDKpgtC02ZWaa8sIVG8IERlGlBFuTPAdWgoF/pKme2xZx41X5p/5wI7JiYVzFwWf2SDmB+G3bSNvdwRROO/8i4xriIIuDqHNs4sleuDKWIg+qHF+lFFZhzk4N+58FAY+zW74UHnrYrnEi7M9HuY9GYwQ1mqzW5oHztp0YWJ9NckDKK5wrnz6SwdSzQwXl5sEbwGwXlVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SoGSoxMk4TodhEZU4WFUQvvbvUpyyO9cIOpHdXDe9I=;
 b=T6rODppSi3+EwgV6z9MxV9cq5biA9saz4gx9okahXEmgTm349Py+LnBHKve8Xi34R0TpSYFPHpNdR2T130LQKHkZJJtqoEOaFw6AStDrJ0Wt/9br85WoKxa8mX7vWrtTNIddoSx2uufmfJYsvqtywVH8MtMUGV30VhdVPnLK5YrkI5PkfKzyFhW08PAxseC77yAu6U0f94tN4g3QBq3nGE9x32PZAG9bDrYlqjytY9SZV7xJOpYaEqkFkqpJsIKqn9fiZIhJOMQQ0Xirhn1lYO+wmRub1fFKFoYBGBfTMh0vz1ke4/gi/eGEmCe+FndfL7IYwyaAoCCTOGE53vc/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SoGSoxMk4TodhEZU4WFUQvvbvUpyyO9cIOpHdXDe9I=;
 b=yO1B28l+LEsU8p3/6SSlKuXooZ2xrb0h8YDjB2NYPMWTIB6WhtnePSctY4kChAEt8DZ0HJAzJchdThZaXRZvzNny5Fb8mmggFHXnkcXdjlf+voCl69Xmd/K/eAknHmAIEgtNp+ghCoGhKn2i7SIC8ZONhk8AcvUsss++hNfI/aM=
Received: from MN2PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:160::38)
 by MW4PR12MB7168.namprd12.prod.outlook.com (2603:10b6:303:22d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 05:01:37 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::70) by MN2PR13CA0025.outlook.office365.com
 (2603:10b6:208:160::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.13 via Frontend Transport; Thu,
 8 May 2025 05:01:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:01:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:01:33 -0500
Received: from xhdipdslab61.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 8 May 2025 00:01:29 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v2 13/14] RDMA/ionic: Implement device stats ops
Date: Thu, 8 May 2025 10:29:56 +0530
Message-ID: <20250508045957.2823318-14-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
References: <20250508045957.2823318-1-abhijit.gangurde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|MW4PR12MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a649f7-3e1f-4a95-cf50-08dd8ded6910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wIZFiVfNmQ648wtbAza3WCtnulwwHK5RWKOYVD+n8KC2YrDUp1XavYFyeGci?=
 =?us-ascii?Q?ZLiI88fGo99cYsFXTXXnJpVeRltwUraC7cF17v8Quu14c1O4Wh2OAmzbRNvn?=
 =?us-ascii?Q?DQQMjMEpHbBmBmBPEIxw30m1wtHzqgjQJXDVBDnNtODl0aGb2CeTDbkUoVjR?=
 =?us-ascii?Q?7u3qgboLlGag/Na9SnJEq6kgXx6RNxWy9CTIqQC9NoJ4dTiEWLFUiNiaFFHe?=
 =?us-ascii?Q?ZoQ9uOjDjamrMr3Ah05hSjLi7IXQIOkWGF/rmOPNEoFn91JxEo994Y1lboIu?=
 =?us-ascii?Q?QEutxgO2sxlYEQsPkVDz7KcWVumKwrcLkMC72SeyvP6AbonqSmfZB58xhnB8?=
 =?us-ascii?Q?2goiwoLoEUk1K6+u+QxB/XADXR/IB1GpBmQFPws9j9ZDJQZaRC0rEXm9xAWH?=
 =?us-ascii?Q?zW43+aBAafHIMIF+9UzNxcbvNWil9VP6KX8FDtjagXE2LUm8e1YuwcxPHYiz?=
 =?us-ascii?Q?qTajL65oS8VlHZQhquCTBXg3yDSaldcX6eXmP3pvxbN2oWKg9TGz2oBWPj02?=
 =?us-ascii?Q?oRIIo7J5lpkVkqU6cGuq++jdGHNVeb8d+8tbaVtcSrGTJwZ1FXNDbJwS+u2u?=
 =?us-ascii?Q?5nX1LHNot/11BYjFaOuDamrdIoRqXCY5aV+YmDZnfG/tdi+Z8QLRaWPkleAL?=
 =?us-ascii?Q?N++VtldLcJNdFdSilBEBhUS/SNXAE57dfU4gdPpv1Mk60c2jpjR6e+nTMY/z?=
 =?us-ascii?Q?5ImjJ9j7PoNid88Pb3tnP2vzhEX7msIPuu9u5brYBk1Ul9cUyf+4cJroSn/N?=
 =?us-ascii?Q?LGyZpx4ZQA9xFIiOJ1x+BKFW3h7KKGi+MvJzB/LWQH4+pdajf4xkBfBnnJd9?=
 =?us-ascii?Q?byu8ZcElMCw91OuYdyPU4OSb5UfZcueI0heZcA7HrcvlZNMZTxP7PYZ4sHHk?=
 =?us-ascii?Q?5F+1FluTIQ+WYK5YiCh7U9Tx63EiHqaqVTrFBgxNMP3Q+/yMsoAxvq8P5ty8?=
 =?us-ascii?Q?IYk2zxgW4PfS1iWUgtoifk1SyJGvC1+SqDvtWkuhb8DcOLTde2uw6UFwtL5T?=
 =?us-ascii?Q?7/2bNQDUX3n3XLki6VlPDRvOppq2vBxchjy/1s0JDK5bK/JSSr+og5GEaUTs?=
 =?us-ascii?Q?QCPAz8l5yeRbAdZY3mxVcLnuaiaFvMHhb2YBU7me8AQbeq+sg+c4RoXlt8c2?=
 =?us-ascii?Q?HgxK7Xs7OudWOao36TtLpPw5nJlS18kv4hpW+RqYWaIBfJBkrQWnbjobx1Cp?=
 =?us-ascii?Q?HzvSBp6of7S2q/mGWcuVPXYOhaHC8EjBMSYmCmisIu5YoB0P0MjSdRjJXg8w?=
 =?us-ascii?Q?DOLWhHPgL+8v0t3XI7Orqhu3gSV2ocyYGncPqYUQKYbWqPydCYRymClhhhLj?=
 =?us-ascii?Q?7GlTKISJ+MiBZOcHEB4kiFj6K9OXWg6VQtloohVeOjqPpf97sGKpIMSUH1xe?=
 =?us-ascii?Q?Z7QA8undgWDcDbisbsCJdgDOyT9/8ktMbuuCp7qm5fx6t8dotjBRw+CxDGxc?=
 =?us-ascii?Q?JSNctsld/Ehaxt0tcHzV0fpWLstfYZ0sK6katT6+Lks+tfSGCXFtDP10usRe?=
 =?us-ascii?Q?tR0/EAgtzASfO6G8tYq53k/AW1e01UHojX2BOM3esEpOiaJHuoReKK7pZw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:01:36.5491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a649f7-3e1f-4a95-cf50-08dd8ded6910
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7168

Implement device stats operations for hw stats and qp stats.

Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 drivers/infiniband/hw/ionic/ionic_fw.h       |  43 ++
 drivers/infiniband/hw/ionic/ionic_hw_stats.c | 484 +++++++++++++++++++
 drivers/infiniband/hw/ionic/ionic_ibdev.c    |   4 +
 drivers/infiniband/hw/ionic/ionic_ibdev.h    |  23 +
 4 files changed, 554 insertions(+)
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
index 000000000000..29f2571463ac
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
index 1fe58ca2238f..e292278fcbba 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -329,6 +329,7 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 {
 	ionic_kill_rdma_admin(dev, false);
 	ib_unregister_device(&dev->ibdev);
+	ionic_stats_cleanup(dev);
 	ionic_destroy_rdma_admin(dev);
 	ionic_destroy_resids(dev);
 	xa_destroy(&dev->qp_tbl);
@@ -401,6 +402,8 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	ionic_datapath_setops(dev);
 	ionic_controlpath_setops(dev);
 
+	ionic_stats_init(dev);
+
 	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
 	if (rc)
 		goto err_register;
@@ -408,6 +411,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	return dev;
 
 err_register:
+	ionic_stats_cleanup(dev);
 err_admin:
 	ionic_kill_rdma_admin(dev, false);
 	ionic_destroy_rdma_admin(dev);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 446cb8d5e334..803127c625cc 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.h
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.h
@@ -36,6 +36,7 @@
 #define IONIC_PKEY_TBL_LEN 1
 #define IONIC_GID_TBL_LEN 256
 
+#define IONIC_MAX_QPID 0xffffff
 #define IONIC_SPEC_HIGH 8
 #define IONIC_MAX_PD 1024
 #define IONIC_SPEC_HIGH 8
@@ -120,6 +121,12 @@ struct ionic_ibdev {
 	enum ionic_admin_state	admin_state;
 
 	struct ionic_eq		**eq_vec;
+
+	struct ionic_v1_stat	*hw_stats;
+	void			*hw_stats_buf;
+	struct rdma_stat_desc	*hw_stats_hdrs;
+	struct ionic_counter_stats *counter_stats;
+	int			hw_stats_count;
 };
 
 struct ionic_eq {
@@ -346,6 +353,18 @@ struct ionic_mr {
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
@@ -466,6 +485,10 @@ void ionic_notify_flush_cq(struct ionic_cq *cq);
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


