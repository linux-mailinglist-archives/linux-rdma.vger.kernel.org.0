Return-Path: <linux-rdma+bounces-12441-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC93B0F945
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CA11CC422D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B9D2405F8;
	Wed, 23 Jul 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v9UB7IHn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64523F295;
	Wed, 23 Jul 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291987; cv=fail; b=H4IOEkjizuCoF0oEJzoXU0/uh8D4Fu9+qXzuOJOaHXsUgjQNplsXthkxi0HBbzm0XMKdO1vFHSx5XEdwQBs/RgxqLz63tVUJ38Wex73t9oCXqHW+d8xeaJ4M5OFVRRYOYi9Feoi+EaKSkDcpt1Jx+KcpU1/iLRFpeoYD12Q/Uek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291987; c=relaxed/simple;
	bh=Cs9x42X1/rkFnmN2izPH+bWBRPAThmt/94TW4oqidSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c0Opdxu1WktBlIsq+SL7IatW9fCn+ueh/Qp/Bh+S4wX+/HvcB3focBIS/ILaygBXN0DItLHa+/7eglNSfsXgtDW2JHXdzLIKc1zzW3RYLHTOcIOI/cgXB8kiSCgiWW1AmET9TrELUm+xwkD7Xwq6VoBbfdrZsdI4BoEHdfO9HNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v9UB7IHn; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTdLsTbE9h9Elunj0n8wyHnjPZoAxurwHyDcxrVqk5G4UWUT/WhPtrZ11YhfyGon4cwnxdOrKOp+APPU3V7R83Ty92jyrj6hxuf+PxRJwGtw86h/U79dfswH+8qRExz4OVF0TcXuPphu5CaxWLFiB0Lsfmj+anYgSKZPSPY3qP5C4SELBGuwZ1H4sS74Qtf1dGLHMwk3oVJCi7GuCE0QfIanoScMfhszEt8kxsLTDouuG2uW4BXHBSACXNghiB5SsyO68lRyJI8s8fIO9ocPSeIzWzHxF8WjCwRlFy+o0XJdLYL0QHNRBm0A0GIJMGu1/Tqh5yMCXHnitgy5UeDGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc1i36iy1Vg41xAQePM2ehWZstorRFU72rYgZkltkMw=;
 b=OfaREGoicgrP9IkJHJJ4ESbFYPkRUQEgJAOG6MyZekgr9lQo6R8m4n7l6T19rX8vakm/wYB0FGIOGcaUTw8npc07TvbUzjYu73WciQQUZJ1hGec7ZhM7GnRNZaXYBUkAcqtknTwUDm4R10Vt6wBSH5uLUYxVb9M2O0lvCu3ETYfoeB1zdsk6XeY8UIvIZvpo0U2aH57KRJ5qK9j6Vh/FHd6ZIWRtcepdUm1l8LAYVAIEgfBXeFKdyZxDXpfcLoM41DtGKxA1B+FCKgDugx/3hEwO8tJwIv8eNFIqC48AnREc3p1JyJ9hN7R5E98BWfmyxnNezWJV8Hx6cftIqWgbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc1i36iy1Vg41xAQePM2ehWZstorRFU72rYgZkltkMw=;
 b=v9UB7IHnSYkZ3aqoDIJaCfgDGWz8Lmqb0cVdPQV3kKw+NwK9dYKto2ViO+Gp+vCUBnjRdY9bQJ3FGq9mvdDskiRvgT9Ys9J8SGfPreGjQCOMmWTPBw7Q91V9rqeLmvmHbG4JGbUmq/yvFpVpphyOWwAJkFUehuDzFB2eEHka1EE=
Received: from CH5PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:1f4::20)
 by PH7PR12MB6737.namprd12.prod.outlook.com (2603:10b6:510:1a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.27; Wed, 23 Jul
 2025 17:33:02 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:610:1f4:cafe::b3) by CH5PR04CA0002.outlook.office365.com
 (2603:10b6:610:1f4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 17:33:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:33:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:33:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:33:00 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:56 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 13/14] RDMA/ionic: Implement device stats ops
Date: Wed, 23 Jul 2025 23:01:48 +0530
Message-ID: <20250723173149.2568776-14-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB6737:EE_
X-MS-Office365-Filtering-Correlation-Id: 799637c0-6302-40d3-c564-08ddca0ef974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QBO6qgM/NxNZPVq6hyWQ0CMgA1w4cGv1oNNRULJ3R7qu5V2sOyNMzbLwvihR?=
 =?us-ascii?Q?lGxLCsnvWpC9drc3qHmlTRvvP9etVC9IRMqD8HIRPCst2z3exMUxnANLxA9W?=
 =?us-ascii?Q?8ANHvrzFv6Zrz7ECVi0efaIOahz2TOv9E1HPw8CvUTI+0CkN6lFvcGuK2hqR?=
 =?us-ascii?Q?h7VPfE34F1uIJQdDMkH4TNIKseo/baPNcczji9HqK4zgv/WNCJRsFNruZMgs?=
 =?us-ascii?Q?1n3kq4FWMR0oJ0aHhq3QCAkmS2qINLKhMyU2MHviLYXHPLgQ1DSWpGqjWkR0?=
 =?us-ascii?Q?I4cq29KBNA0Y0lhW9s+21+PGEzOcbONHDucj49pdFJOdkn78O/qiAOxTGBEB?=
 =?us-ascii?Q?ToQLKIdpSJOuMY0hOVf/BvmIq3NEG3o3FTDXADmg7h02kRbY447kMNaN7HuA?=
 =?us-ascii?Q?0M/Z3ryKvho2Y/tR6v0EOhyTlMnadozj4RZ4eqPgU3569g47JSjJ6bFsrgk0?=
 =?us-ascii?Q?GHVPVd4VW+smrQYWEKMjOk0/iZ+rj/9xOxndMnnDM16ZuFZtUN890d18OI9R?=
 =?us-ascii?Q?wRZVzMKWAn2fmpnvRpzfelcfybssfT3g1wNWGxJOjnaSULjYaqir+ndEUnr6?=
 =?us-ascii?Q?571IEjYk5KA5BMXvI8RWokINyKv808QxbUWnEoenWgk+MDjbkJUmfGvolYrp?=
 =?us-ascii?Q?p8iAB75D8JPb5u3JWJjkwUUU/Khp1KTPieT9mtvdz1vv/2V9f2wuAVnW2jgP?=
 =?us-ascii?Q?f00Y5PVst60FRPi5maKmMDogyNr7UDvwnqEmqxOlWSTEAw4F14SRMAsuiiBJ?=
 =?us-ascii?Q?dlrsle6HSPvVU/BOqDslTs2XYIow+Mms9VqNUJKD5nmRgDKXCaM3ALpiylev?=
 =?us-ascii?Q?oCLBGA+sZ1jMcovw/gwG/uKzRK+WroUZ36cRkX36VTVZoQP+qQHeFVPlcv7/?=
 =?us-ascii?Q?UQ/xVixVNZRiH2F5OHQP9XwxGrNj4L644l+cdlGvYlOulbC0qCnGtKMHPYzM?=
 =?us-ascii?Q?VECvOBsEF1cS44GkvMfJzuLPsiLF0/SBtbMB56ZrtrB7fCwP5TJ2Ggarl0Q5?=
 =?us-ascii?Q?nqomNcDgfhNpPdmZszj5lU5tMuYlqodGHadKEhZKNO2ar3c2hw6viUQUoKkx?=
 =?us-ascii?Q?nm18goF0TLhwbkb9icQZjJrK6WoHlJZ6pqusm/3j02qw6YZj6S/l3ixH0kwa?=
 =?us-ascii?Q?MP0PdcUjXfGUD7d2G8/1rFXhEmP0CHAQkIzC1s3PXeRRphdGLiv0uH82ycqW?=
 =?us-ascii?Q?v3NcpaYPeIhc30QunH2Ccvab4W7R1lSxzGg7D3dtKEGHKqzhyFlld36b+M60?=
 =?us-ascii?Q?H+OMl5ShzsyrsA87H6vSnTeq5PR1Z9Ojky6vi1jnTem0EPill21eOYcFGEr8?=
 =?us-ascii?Q?SxCs3uosvbSVXtg9kk4C2XZLlKkJU6qJ4fQC+GOgzOdVAV3DZ+esOmLoWQ9f?=
 =?us-ascii?Q?nk7QVy8j2qJxd743b97fXNJ5IdDuh3zP06ahzV8XJydsQqSislUoE0kXvypZ?=
 =?us-ascii?Q?2biHM6oSos0UNwbZxzrv+X0glQO8Vyrd6IHtf9nJY/NPaH+ELJTXCH4dASLQ?=
 =?us-ascii?Q?WQFx2aGQS7mSZVzNSzpaTPzaFzDlVrI68IdW3jUD3AQqRAKutikBZnFLzw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:33:01.9122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 799637c0-6302-40d3-c564-08ddca0ef974
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6737

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
index 84db48ba357f..90ae29e7989c 100644
--- a/drivers/infiniband/hw/ionic/ionic_ibdev.c
+++ b/drivers/infiniband/hw/ionic/ionic_ibdev.c
@@ -301,6 +301,7 @@ static void ionic_destroy_ibdev(struct ionic_ibdev *dev)
 {
 	ionic_kill_rdma_admin(dev, false);
 	ib_unregister_device(&dev->ibdev);
+	ionic_stats_cleanup(dev);
 	ionic_destroy_rdma_admin(dev);
 	ionic_destroy_resids(dev);
 	WARN_ON(!xa_empty(&dev->qp_tbl));
@@ -358,6 +359,8 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 
 	ib_set_device_ops(&dev->ibdev, &ionic_dev_ops);
 
+	ionic_stats_init(dev);
+
 	rc = ib_register_device(ibdev, "ionic_%d", ibdev->dev.parent);
 	if (rc)
 		goto err_register;
@@ -365,6 +368,7 @@ static struct ionic_ibdev *ionic_create_ibdev(struct ionic_aux_dev *ionic_adev)
 	return dev;
 
 err_register:
+	ionic_stats_cleanup(dev);
 err_admin:
 	ionic_kill_rdma_admin(dev, false);
 	ionic_destroy_rdma_admin(dev);
diff --git a/drivers/infiniband/hw/ionic/ionic_ibdev.h b/drivers/infiniband/hw/ionic/ionic_ibdev.h
index 1a2c81490c5c..8e45ade19b19 100644
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
@@ -478,6 +497,10 @@ int ionic_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *wr,
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


