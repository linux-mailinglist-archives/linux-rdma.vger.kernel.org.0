Return-Path: <linux-rdma+bounces-11784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E76AEE64A
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04351881379
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E5B2E54DF;
	Mon, 30 Jun 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Mk6MulDe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2137.outbound.protection.outlook.com [40.107.92.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C22E6135
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306308; cv=fail; b=Ip2rgI04cMdpunLc0V0p2FR/Yykp3FvvnylRl8xMeePK1Z6Pia6c5O8j7PXWzPHE0DuHclcW4jULMqNycGacnQs/deXBNLobjCTL1Be6G/WppklRHRdAdMaofygukKw+VF5bSP5fpYOVAelChve9971+hxKdHsz4DUy8itHtFJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306308; c=relaxed/simple;
	bh=0tVIXwTvj6XRjOudA3TRmF5SkSEff89N7ePaWBwrPrM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C2Z6osGfsZFoPWdt7RCOd9aVw3FDfrjUe9rpJBD5EHfqbkr44upFidsC9cAXK2QyovK804xbfG27GyVHj09WAvjIpDcAa1K913gy2Zdz+Qnm69Kh0GytahyPxaAV+ju3/zbfs7Mco1jz7grMQuVCGlc2Tx9k2Sa3xZA7tsOH3Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Mk6MulDe; arc=fail smtp.client-ip=40.107.92.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ze/52fiW8FyquyXi7xx1bJjn0I/2pk3DDSMxJQDijmhEqttJsZcLeHgWwwEAbRVFYbvbHKXaPybBZVWfnCISUtUT3Tx+sk9SG1+N4ee77MDCPi/vdX8uWnK/UjdbK+WxF4safbuMWGzwjU6/HOgf5zq0YeHtdSWsVVaUK/D7vlbgIb7j2/NYpm73eheBh4I9BBEc6gju3UQNKDOpkQTLlQlQk+dasMO5Oo8hFXKdahwXN8SYwrm45KGMIGQCDSS1SQGsZ2vP+VFp6JlBO3KwjOeC7Fa7t/1NOzi9MW9bXcc7NhT4TZEieAveB5IeCX2SnJXEuIEbawi4i66chowj7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzP59Um/5vTtc1ZdAE7T7nV0xkWaKmJGlhNk3rqYRng=;
 b=osTVzAOYHYfZtiTXcAKEOGEJYXEgolTKvbk/rNaG8Yoad0h2zJy3BUzjwF3P0/89H7DZC0P+vqA0jOQ+8o1ikWTGtWItiGumBifIobqi70tzq/cPdzNdDr58eLh6E+WL/u1/mA9z51ZKNCdLuVFPDK+TCtikzr2qIpzOfHF5o4BEDVrIIBopK4yD4CVu994CMm39zqKeKxIL81hmHYdeP3BgbUal4wJ+srJmesULzrpKyPCQyzDRUXHPg1FwQavGFKNBgevZ8LMua2F51tFYrVusW/0xyl2cLnD4rMmwmn8fsPsiv+PNV70uztEAzsoatMbo/VTi2gKbNNLDltYm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzP59Um/5vTtc1ZdAE7T7nV0xkWaKmJGlhNk3rqYRng=;
 b=Mk6MulDev/6mi3zcHGQgFLy6rzAu2zwsCfah8Pr/OQYtRflC+AQ/Wn2CEKpFFRR25r6p8PdVyTOezGDWCRrpWtNhOuxwN2z8fM6GDq6kV7b4iN6qmEwvY9ADNyJzvVIjP4LBqJqcMs/mJ9fyTK2fEM8km5CpbinpdUnDJeTlCZWW9feep1o6ypZ/3q54bkQynBqDTMsX2wlM4DM4q86idJk3XMGiRINwd6xOua3DMbDI5LcsjZ9svp6ZmSbFczqQ8sDPWYvQ7IaG1twSwCi0A0Sqt7q5qhfyfQqleGpDeY3q8yKTLdAECYbP3Y8FcNeJtyUiZFQFXq+9S8cKJK61oA==
Received: from MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::33)
 by BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.31; Mon, 30 Jun 2025 17:58:11 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::fa) by MN0P221CA0019.outlook.office365.com
 (2603:10b6:208:52a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 17:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:10 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id D389014D72A;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 7E5B01848B5D8;
	Mon, 30 Jun 2025 11:30:58 -0400 (EDT)
Subject: [PATCH for-next 14/23] RDMA/hfi2: Add system core support
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:58 -0400
Message-ID:
 <175129745844.1859400.18150879658008873878.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
References:
 <175129726945.1859400.4492277779101226937.stgit@awdrv-04.cornelisnetworks.com>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|BN3PR01MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: d9165288-04e0-4a3f-78a0-08ddb7ffad03
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1JTSTBrRmJiYTdwUlhwLy82V0ZSV3BGUWZGUDA3QWRzZXE5OHZMZDhRZ0ZY?=
 =?utf-8?B?UXd0eUJNM2lyUzA2TWgxTGhFR3ZOY1BCdFRqY3ArRlFPUVVkY1crV05PbXFh?=
 =?utf-8?B?VE9OVWliRTMxYjJZeFUrL0dybHZSRmt2Uk9uMDVuRktEcEMrVXRBdkh4U24y?=
 =?utf-8?B?OFVoWWRBbWxCTW5sUGFNTmU0QTYza244V0srbWJNOHpqWEk1cTd0ZzBydUJp?=
 =?utf-8?B?N25XRGJGZVViMmFub3I2NTBiUDJudGpFaENUWFk4NFlBNFczQk9XeHJNU3o0?=
 =?utf-8?B?OG1hMGU3R2NQMjZrdFlvRm1QTWlqcTVVNmE0dStCVllNdndaVHZlQUhHTUdQ?=
 =?utf-8?B?amhrdlVuQkRKQVgwbjh1YUdSZGpZeHkrNndvY3MvaW9rY3JkVW5zaFVoZFB5?=
 =?utf-8?B?OE16QUlDRURSQkdWUUgvUFViVTRraGpFeGN0V0lMMXl0STc4bG1hS2FwUmZr?=
 =?utf-8?B?Ym1zaVpWQzdyeXpPamtWUkZrQlY3OVRUcjJ3TE9GT1IzMGp6bWNnZ3NrYlJC?=
 =?utf-8?B?UlBIZGlvTmhEVGNQMnFRcHJXOFdsZC9hbFpUTUVSUVdkK1R5dmtUclc1VzNk?=
 =?utf-8?B?a1BYKy9Nb01WbEN2VDFLcFhmaEI4MDhaWHlIaUVXTXk5d3hTVFhKMVhWMmZB?=
 =?utf-8?B?WFhxL3B4Zzdialg1bm0xa2xHaUczRVh6MTN6SVpaTjZIZEhMY1p4Zzg4b2VJ?=
 =?utf-8?B?aFNqdjdDTVlpSExYdFdGUFl3SWZWc3BYNTNJblJWRHphTFFNYnljTUlEZXZ0?=
 =?utf-8?B?d2FyVkNSSml1TFFQc2JZNnJ0dWg1ZXM5cGovcFpNNVdJY05RNG11WDBlTkVu?=
 =?utf-8?B?NGU4THZiQTZOWVZjeC9PR1NwQWNGazZQQktUYWtvNXVnN2c2aHhKYUFyVENq?=
 =?utf-8?B?bTZueStyUTIvY2NRRUpyN3ZhOWE0N1h3WjlSZ0h0YmZDU1VkSm5Oa2J3VEtp?=
 =?utf-8?B?aHhaK0p2S2VqM3pmQnVMZkFYZFFRLytDd2dlZ1dTTkRNb2xma0x1UVBHRUJU?=
 =?utf-8?B?N3RjbXI0d250VmhpNmJEV2hzM3BndFBpS0h6SUtKU1hZVWVkdUhnR3laUWQw?=
 =?utf-8?B?U1BXWERmNDFnZG5lNWEybml1VHZnWDZPMWdjNmN2WXhWdDNzMVZkR0g2ZG1J?=
 =?utf-8?B?KzYyR1F6Sm45b1J1QlF0YmJlZkp4cWFYUDVTVitkWWkrZWNNVHhZT2xRWDVK?=
 =?utf-8?B?NFBDN2lLaXptOEFvYTJNMXpHTDVpTkdLSmZaZmZTMkZ2KzV3OTAyc1pTTGpJ?=
 =?utf-8?B?ZHZpa1VOMnNVWjFSTE5jdlZCRDV5aFlIbnNPSk9yeXgzNzRmK1hRVVFQS1ZI?=
 =?utf-8?B?RkZRaHEyQ3NldlZpWGFZYi9WdmRGQ3p4NkdINnc5d0ZFV0hLTXVIOGxvaVNM?=
 =?utf-8?B?U1V1QmdyUzY0Q3JmTEZNeEpCczhJODdwZkkrMFdJNVVDeVkxMjRsM3ZKbWZh?=
 =?utf-8?B?VVhOZnU2ZGxvcWRZOGx2bHNuM2JKeFFOOXptbTliSzF3aGhhQkFtTHIxaWVk?=
 =?utf-8?B?UFkyTnBYQndad3NMaHExVFdTNDhMdElUZlZiSFRMQUMxc1dlQW9qcE94QmtT?=
 =?utf-8?B?YUEvaWx0anUzdjh3UEpqNEZiOUwyL1JSQUNpcnNJR01oMFU5cGxXNFlESFBs?=
 =?utf-8?B?VW5kMVNrcElOa09ieFd6QWl0QUlmV3BzUnZaR01OK3psOTE4blRBdmN2d0J1?=
 =?utf-8?B?eE90T29YcXlzN3VDK3pGQ2JDd01qaDRCVjB0TzkvcFZsdGg3YjU3ZEZwcC9T?=
 =?utf-8?B?UXJCaG1XbTAvaEJlY3dQa1ZYTGt5eXV4aHJqMXBNTHQ0RG5KVG1xMGZlUjk2?=
 =?utf-8?B?S1NwQUhhUVE0T3VGelJqN0Iyb3E2MFZDNmRFV1U1WXd5QWM0VjRkWEpFb2Nl?=
 =?utf-8?B?N1JQRkl2Sy9LZmg0ZTBKMGlRak8weHRxQThZR3ZCZnFqZEdlNDB0TWYwY2tq?=
 =?utf-8?B?eFp3Y1huT0RaY2NRWHBBVjNtM1NHVFFxNG5XY0lzMmtyN01USWI4dTlRZXpO?=
 =?utf-8?B?TWVFWDk1dTRtUzVQc042dFJBVFN1aC9DbEJKWmxFWk1IOW5WTmgwMnNWUFVY?=
 =?utf-8?Q?wt4l1Q?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:10.2499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9165288-04e0-4a3f-78a0-08ddb7ffad03
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR01MB9212

Add implementation files for hooking into the core system, things like IRQs
and affinity.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/affinity.c | 1173 ++++++++++++++
 drivers/infiniband/hw/hfi2/aspm.c     |  291 ++++
 drivers/infiniband/hw/hfi2/driver.c   | 1959 ++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/efivar.c   |  138 ++
 drivers/infiniband/hw/hfi2/firmware.c | 2266 +++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/init.c     | 2729 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/intr.c     |  296 ++++
 drivers/infiniband/hw/hfi2/msix.c     |  411 +++++
 8 files changed, 9263 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.c
 create mode 100644 drivers/infiniband/hw/hfi2/aspm.c
 create mode 100644 drivers/infiniband/hw/hfi2/driver.c
 create mode 100644 drivers/infiniband/hw/hfi2/efivar.c
 create mode 100644 drivers/infiniband/hw/hfi2/firmware.c
 create mode 100644 drivers/infiniband/hw/hfi2/init.c
 create mode 100644 drivers/infiniband/hw/hfi2/intr.c
 create mode 100644 drivers/infiniband/hw/hfi2/msix.c

diff --git a/drivers/infiniband/hw/hfi2/affinity.c b/drivers/infiniband/hw/hfi2/affinity.c
new file mode 100644
index 000000000000..18c001466967
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/affinity.c
@@ -0,0 +1,1173 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ */
+
+#include <linux/topology.h>
+#include <linux/cpumask.h>
+#include <linux/interrupt.h>
+#include <linux/numa.h>
+
+#include "hfi2.h"
+#include "affinity.h"
+#include "sdma.h"
+#include "trace.h"
+
+struct hfi2_affinity_node_list node_affinity = {
+	.list = LIST_HEAD_INIT(node_affinity.list),
+	.lock = __MUTEX_INITIALIZER(node_affinity.lock)
+};
+
+/* Name of IRQ types, indexed by enum irq_type */
+static const char * const irq_type_names[] = {
+	"SDMA",
+	"RCVCTXT",
+	"NETDEVCTXT",
+	"GENERAL",
+	"OTHER",
+};
+
+/* Per NUMA node count of HFI devices */
+static unsigned int *hfi2_per_node_cntr;
+
+static inline void init_cpu_mask_set(struct cpu_mask_set *set)
+{
+	cpumask_clear(&set->mask);
+	cpumask_clear(&set->used);
+	set->gen = 0;
+}
+
+/* Increment generation of CPU set if needed */
+static void _cpu_mask_set_gen_inc(struct cpu_mask_set *set)
+{
+	if (cpumask_equal(&set->mask, &set->used)) {
+		/*
+		 * We've used up all the CPUs, bump up the generation
+		 * and reset the 'used' map
+		 */
+		set->gen++;
+		cpumask_clear(&set->used);
+	}
+}
+
+static void _cpu_mask_set_gen_dec(struct cpu_mask_set *set)
+{
+	if (cpumask_empty(&set->used) && set->gen) {
+		set->gen--;
+		cpumask_copy(&set->used, &set->mask);
+	}
+}
+
+/* Get the first CPU from the list of unused CPUs in a CPU set data structure */
+static int cpu_mask_set_get_first(struct cpu_mask_set *set, cpumask_var_t diff)
+{
+	int cpu;
+
+	if (!diff || !set)
+		return -EINVAL;
+
+	_cpu_mask_set_gen_inc(set);
+
+	/* Find out CPUs left in CPU mask */
+	cpumask_andnot(diff, &set->mask, &set->used);
+
+	cpu = cpumask_first(diff);
+	if (cpu >= nr_cpu_ids) /* empty */
+		cpu = -EINVAL;
+	else
+		cpumask_set_cpu(cpu, &set->used);
+
+	return cpu;
+}
+
+static void cpu_mask_set_put(struct cpu_mask_set *set, int cpu)
+{
+	if (!set)
+		return;
+
+	cpumask_clear_cpu(cpu, &set->used);
+	_cpu_mask_set_gen_dec(set);
+}
+
+/**
+ * Remove HT/SMT threads from cores in @cpus.
+ *
+ * Assumes that first thread in each topology_sibling_cpumask() is a
+ * real/physical thread and that other siblings in same group are HT/SMT
+ * threads.
+ *
+ * @return number of CPUs cleared from @cpus.
+ */
+static int clear_ht_siblings(cpumask_var_t cpus)
+{
+	int c, s, p = 0;
+
+	/* Remove HT/SMT threads from real_cpu_mask */
+	for (c = cpumask_first(cpus); c < nr_cpu_ids; c = cpumask_next(c, cpus)) {
+		/* Skip first CPU, assume it is a physical (non-HT/SMT) CPU */
+		s = cpumask_next(c, topology_sibling_cpumask(c));
+		while (s < nr_cpu_ids) {
+			cpumask_clear_cpu(s, cpus);
+			s = cpumask_next(s, topology_sibling_cpumask(c));
+			p++;
+		}
+	}
+
+	return p;
+}
+
+/* Initialize non-HT cpu cores mask */
+void init_real_cpu_mask(void)
+{
+	cpumask_var_t cpus = &node_affinity.real_cpu_mask;
+
+	cpumask_clear(cpus);
+	/* Start with cpu online mask as the real cpu mask */
+	cpumask_copy(cpus, cpu_online_mask);
+	clear_ht_siblings(cpus);
+}
+
+int node_affinity_init(void)
+{
+	int node;
+	struct pci_dev *dev = NULL;
+	const struct pci_device_id *ids = hfi2_pci_tbl;
+
+	cpumask_clear(&node_affinity.proc.used);
+	cpumask_copy(&node_affinity.proc.mask, cpu_online_mask);
+
+	node_affinity.proc.gen = 0;
+	node_affinity.num_possible_nodes = num_possible_nodes();
+
+	/*
+	 * The real cpu mask is part of the affinity struct but it has to be
+	 * initialized early. It is needed to calculate the number of user
+	 * contexts in set_up_context_variables().
+	 */
+	init_real_cpu_mask();
+
+	hfi2_per_node_cntr = kcalloc(node_affinity.num_possible_nodes,
+				     sizeof(*hfi2_per_node_cntr), GFP_KERNEL);
+	if (!hfi2_per_node_cntr)
+		return -ENOMEM;
+
+	while (ids->vendor) {
+		dev = NULL;
+		while ((dev = pci_get_device(ids->vendor, ids->device, dev))) {
+			node = pcibus_to_node(dev->bus);
+			if (node < 0)
+				goto out;
+
+			hfi2_per_node_cntr[node]++;
+		}
+		ids++;
+	}
+
+	return 0;
+
+out:
+	/*
+	 * Invalid PCI NUMA node information found, note it, and populate
+	 * our database 1:1.
+	 */
+	pr_err("HFI: Invalid PCI NUMA node. Performance may be affected\n");
+	pr_err("HFI: System BIOS may need to be upgraded\n");
+	for (node = 0; node < node_affinity.num_possible_nodes; node++)
+		hfi2_per_node_cntr[node] = 1;
+
+	pci_dev_put(dev);
+
+	return 0;
+}
+
+static void node_affinity_destroy(struct hfi2_affinity_node *entry)
+{
+	free_percpu(entry->comp_vect_affinity);
+	kfree(entry);
+}
+
+void node_affinity_destroy_all(void)
+{
+	struct list_head *pos, *q;
+	struct hfi2_affinity_node *entry;
+
+	mutex_lock(&node_affinity.lock);
+	list_for_each_safe(pos, q, &node_affinity.list) {
+		entry = list_entry(pos, struct hfi2_affinity_node,
+				   list);
+		list_del(pos);
+		node_affinity_destroy(entry);
+	}
+	mutex_unlock(&node_affinity.lock);
+	kfree(hfi2_per_node_cntr);
+}
+
+static struct hfi2_affinity_node *node_affinity_allocate(int node)
+{
+	struct hfi2_affinity_node *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+	entry->node = node;
+	entry->comp_vect_affinity = alloc_percpu(u16);
+	INIT_LIST_HEAD(&entry->list);
+
+	return entry;
+}
+
+/*
+ * It appends an entry to the list.
+ * It *must* be called with node_affinity.lock held.
+ */
+static void node_affinity_add_tail(struct hfi2_affinity_node *entry)
+{
+	list_add_tail(&entry->list, &node_affinity.list);
+}
+
+/* It must be called with node_affinity.lock held */
+static struct hfi2_affinity_node *node_affinity_lookup(int node)
+{
+	struct hfi2_affinity_node *entry;
+
+	list_for_each_entry(entry, &node_affinity.list, list) {
+		if (entry->node == node)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static int per_cpu_affinity_get(cpumask_var_t possible_cpumask,
+				u16 __percpu *comp_vect_affinity)
+{
+	int curr_cpu;
+	u16 cntr;
+	u16 prev_cntr;
+	int ret_cpu;
+
+	if (!possible_cpumask) {
+		ret_cpu = -EINVAL;
+		goto fail;
+	}
+
+	if (!comp_vect_affinity) {
+		ret_cpu = -EINVAL;
+		goto fail;
+	}
+
+	ret_cpu = cpumask_first(possible_cpumask);
+	if (ret_cpu >= nr_cpu_ids) {
+		ret_cpu = -EINVAL;
+		goto fail;
+	}
+
+	prev_cntr = *per_cpu_ptr(comp_vect_affinity, ret_cpu);
+	for_each_cpu(curr_cpu, possible_cpumask) {
+		cntr = *per_cpu_ptr(comp_vect_affinity, curr_cpu);
+
+		if (cntr < prev_cntr) {
+			ret_cpu = curr_cpu;
+			prev_cntr = cntr;
+		}
+	}
+
+	*per_cpu_ptr(comp_vect_affinity, ret_cpu) += 1;
+
+fail:
+	return ret_cpu;
+}
+
+static int per_cpu_affinity_put_max(cpumask_var_t possible_cpumask,
+				    u16 __percpu *comp_vect_affinity)
+{
+	int curr_cpu;
+	int max_cpu;
+	u16 cntr;
+	u16 prev_cntr;
+
+	if (!possible_cpumask)
+		return -EINVAL;
+
+	if (!comp_vect_affinity)
+		return -EINVAL;
+
+	max_cpu = cpumask_first(possible_cpumask);
+	if (max_cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	prev_cntr = *per_cpu_ptr(comp_vect_affinity, max_cpu);
+	for_each_cpu(curr_cpu, possible_cpumask) {
+		cntr = *per_cpu_ptr(comp_vect_affinity, curr_cpu);
+
+		if (cntr > prev_cntr) {
+			max_cpu = curr_cpu;
+			prev_cntr = cntr;
+		}
+	}
+
+	*per_cpu_ptr(comp_vect_affinity, max_cpu) -= 1;
+
+	return max_cpu;
+}
+
+/*
+ * Non-interrupt CPUs are used first, then interrupt CPUs.
+ * Two already allocated cpu masks must be passed.
+ */
+static int _dev_comp_vect_cpu_get(struct hfi2_devdata *dd,
+				  struct hfi2_affinity_node *entry,
+				  cpumask_var_t non_intr_cpus,
+				  cpumask_var_t available_cpus)
+	__must_hold(&node_affinity.lock)
+{
+	int cpu;
+	struct cpu_mask_set *set = dd->comp_vect;
+
+	lockdep_assert_held(&node_affinity.lock);
+	if (!non_intr_cpus) {
+		cpu = -1;
+		goto fail;
+	}
+
+	if (!available_cpus) {
+		cpu = -1;
+		goto fail;
+	}
+
+	/* Available CPUs for pinning completion vectors */
+	_cpu_mask_set_gen_inc(set);
+	cpumask_andnot(available_cpus, &set->mask, &set->used);
+
+	/* Available CPUs without SDMA engine interrupts */
+	cpumask_andnot(non_intr_cpus, available_cpus,
+		       &entry->def_intr.used);
+
+	/* If there are non-interrupt CPUs available, use them first */
+	if (!cpumask_empty(non_intr_cpus))
+		cpu = cpumask_first(non_intr_cpus);
+	else /* Otherwise, use interrupt CPUs */
+		cpu = cpumask_first(available_cpus);
+
+	if (cpu >= nr_cpu_ids) { /* empty */
+		cpu = -1;
+		goto fail;
+	}
+	cpumask_set_cpu(cpu, &set->used);
+
+fail:
+	return cpu;
+}
+
+static void _dev_comp_vect_cpu_put(struct hfi2_devdata *dd, int cpu)
+{
+	struct cpu_mask_set *set = dd->comp_vect;
+
+	if (cpu < 0)
+		return;
+
+	cpu_mask_set_put(set, cpu);
+}
+
+/* _dev_comp_vect_mappings_destroy() is reentrant */
+static void _dev_comp_vect_mappings_destroy(struct hfi2_devdata *dd)
+{
+	int i, cpu;
+
+	if (!dd->comp_vect_mappings)
+		return;
+
+	for (i = 0; i < dd->comp_vect_possible_cpus; i++) {
+		cpu = dd->comp_vect_mappings[i];
+		_dev_comp_vect_cpu_put(dd, cpu);
+		dd->comp_vect_mappings[i] = -1;
+		hfi2_cdbg(AFFINITY,
+			  "[%s] Release CPU %d from completion vector %d",
+			  rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), cpu, i);
+	}
+
+	kfree(dd->comp_vect_mappings);
+	dd->comp_vect_mappings = NULL;
+}
+
+/*
+ * This function creates the table for looking up CPUs for completion vectors.
+ * num_comp_vectors needs to have been initilized before calling this function.
+ */
+static int _dev_comp_vect_mappings_create(struct hfi2_devdata *dd,
+					  struct hfi2_affinity_node *entry)
+	__must_hold(&node_affinity.lock)
+{
+	int i, cpu, ret;
+	cpumask_var_t non_intr_cpus;
+	cpumask_var_t available_cpus;
+
+	lockdep_assert_held(&node_affinity.lock);
+
+	if (!zalloc_cpumask_var(&non_intr_cpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	if (!zalloc_cpumask_var(&available_cpus, GFP_KERNEL)) {
+		free_cpumask_var(non_intr_cpus);
+		return -ENOMEM;
+	}
+
+	dd->comp_vect_mappings = kcalloc(dd->comp_vect_possible_cpus,
+					 sizeof(*dd->comp_vect_mappings),
+					 GFP_KERNEL);
+	if (!dd->comp_vect_mappings) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	for (i = 0; i < dd->comp_vect_possible_cpus; i++)
+		dd->comp_vect_mappings[i] = -1;
+
+	for (i = 0; i < dd->comp_vect_possible_cpus; i++) {
+		cpu = _dev_comp_vect_cpu_get(dd, entry, non_intr_cpus,
+					     available_cpus);
+		if (cpu < 0) {
+			ret = -EINVAL;
+			goto fail;
+		}
+
+		dd->comp_vect_mappings[i] = cpu;
+		hfi2_cdbg(AFFINITY,
+			  "[%s] Completion Vector %d -> CPU %d",
+			  rvt_get_ibdev_name(&(dd)->verbs_dev.rdi), i, cpu);
+	}
+
+	free_cpumask_var(available_cpus);
+	free_cpumask_var(non_intr_cpus);
+	return 0;
+
+fail:
+	free_cpumask_var(available_cpus);
+	free_cpumask_var(non_intr_cpus);
+	_dev_comp_vect_mappings_destroy(dd);
+
+	return ret;
+}
+
+int hfi2_comp_vectors_set_up(struct hfi2_devdata *dd)
+{
+	int ret;
+	struct hfi2_affinity_node *entry;
+
+	mutex_lock(&node_affinity.lock);
+	entry = node_affinity_lookup(dd->node);
+	if (!entry) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+	ret = _dev_comp_vect_mappings_create(dd, entry);
+unlock:
+	mutex_unlock(&node_affinity.lock);
+
+	return ret;
+}
+
+void hfi2_comp_vectors_clean_up(struct hfi2_devdata *dd)
+{
+	_dev_comp_vect_mappings_destroy(dd);
+}
+
+int hfi2_comp_vect_mappings_lookup(struct rvt_dev_info *rdi, int comp_vect)
+{
+	struct hfi2_ibdev *verbs_dev = dev_from_rdi(rdi);
+	struct hfi2_devdata *dd = dd_from_dev(verbs_dev);
+
+	if (!dd->comp_vect_mappings)
+		return -EINVAL;
+	if (comp_vect >= dd->comp_vect_possible_cpus)
+		return -EINVAL;
+
+	return dd->comp_vect_mappings[comp_vect];
+}
+
+/*
+ * It assumes dd->comp_vect_possible_cpus is available.
+ */
+static int _dev_comp_vect_cpu_mask_init(struct hfi2_devdata *dd,
+					struct hfi2_affinity_node *entry,
+					bool first_dev_init)
+	__must_hold(&node_affinity.lock)
+{
+	int i, j, curr_cpu;
+	int possible_cpus_comp_vect = 0;
+	struct cpumask *dev_comp_vect_mask = &dd->comp_vect->mask;
+
+	lockdep_assert_held(&node_affinity.lock);
+	/*
+	 * If there's only one CPU available for completion vectors, then
+	 * there will only be one completion vector available. Othewise,
+	 * the number of completion vector available will be the number of
+	 * available CPUs divide it by the number of devices in the
+	 * local NUMA node.
+	 */
+	if (cpumask_weight(&entry->comp_vect_mask) == 1) {
+		possible_cpus_comp_vect = 1;
+		dd_dev_warn(dd,
+			    "Number of kernel receive queues is too large for completion vector affinity to be effective\n");
+	} else {
+		possible_cpus_comp_vect +=
+			cpumask_weight(&entry->comp_vect_mask) /
+				       hfi2_per_node_cntr[dd->node];
+
+		/*
+		 * If the completion vector CPUs available doesn't divide
+		 * evenly among devices, then the first device device to be
+		 * initialized gets an extra CPU.
+		 */
+		if (first_dev_init &&
+		    cpumask_weight(&entry->comp_vect_mask) %
+		    hfi2_per_node_cntr[dd->node] != 0)
+			possible_cpus_comp_vect++;
+	}
+
+	dd->comp_vect_possible_cpus = possible_cpus_comp_vect;
+
+	/* Reserving CPUs for device completion vector */
+	for (i = 0; i < dd->comp_vect_possible_cpus; i++) {
+		curr_cpu = per_cpu_affinity_get(&entry->comp_vect_mask,
+						entry->comp_vect_affinity);
+		if (curr_cpu < 0)
+			goto fail;
+
+		cpumask_set_cpu(curr_cpu, dev_comp_vect_mask);
+	}
+
+	hfi2_cdbg(AFFINITY,
+		  "[%s] Completion vector affinity CPU set(s) %*pbl",
+		  rvt_get_ibdev_name(&(dd)->verbs_dev.rdi),
+		  cpumask_pr_args(dev_comp_vect_mask));
+
+	return 0;
+
+fail:
+	for (j = 0; j < i; j++)
+		per_cpu_affinity_put_max(&entry->comp_vect_mask,
+					 entry->comp_vect_affinity);
+
+	return curr_cpu;
+}
+
+/*
+ * It assumes dd->comp_vect_possible_cpus is available.
+ */
+static void _dev_comp_vect_cpu_mask_clean_up(struct hfi2_devdata *dd,
+					     struct hfi2_affinity_node *entry)
+	__must_hold(&node_affinity.lock)
+{
+	int i, cpu;
+
+	lockdep_assert_held(&node_affinity.lock);
+	if (!dd->comp_vect_possible_cpus)
+		return;
+
+	for (i = 0; i < dd->comp_vect_possible_cpus; i++) {
+		cpu = per_cpu_affinity_put_max(&dd->comp_vect->mask,
+					       entry->comp_vect_affinity);
+		/* Clearing CPU in device completion vector cpu mask */
+		if (cpu >= 0)
+			cpumask_clear_cpu(cpu, &dd->comp_vect->mask);
+	}
+
+	dd->comp_vect_possible_cpus = 0;
+}
+
+/*
+ * Interrupt affinity.
+ *
+ * non-rcv avail gets a default mask that
+ * starts as possible cpus with threads reset
+ * and each rcv avail reset.
+ *
+ * rcv avail gets node relative 1 wrapping back
+ * to the node relative 1 as necessary.
+ *
+ */
+int hfi2_dev_affinity_init(struct hfi2_devdata *dd)
+{
+	struct hfi2_affinity_node *entry;
+	const struct cpumask *local_mask;
+	int curr_cpu, possible, i, ret;
+	bool new_entry = false;
+
+	local_mask = cpumask_of_node(dd->node);
+	if (cpumask_first(local_mask) >= nr_cpu_ids)
+		local_mask = topology_core_cpumask(0);
+
+	mutex_lock(&node_affinity.lock);
+	entry = node_affinity_lookup(dd->node);
+
+	/*
+	 * If this is the first time this NUMA node's affinity is used,
+	 * create an entry in the global affinity structure and initialize it.
+	 */
+	if (!entry) {
+		entry = node_affinity_allocate(dd->node);
+		if (!entry) {
+			dd_dev_err(dd,
+				   "Unable to allocate global affinity node\n");
+			ret = -ENOMEM;
+			goto fail;
+		}
+		new_entry = true;
+
+		init_cpu_mask_set(&entry->def_intr);
+		init_cpu_mask_set(&entry->rcv_intr);
+		cpumask_clear(&entry->comp_vect_mask);
+		cpumask_clear(&entry->general_intr_mask);
+		/* Use the "real" cpu mask of this node as the default */
+		cpumask_and(&entry->def_intr.mask, &node_affinity.real_cpu_mask,
+			    local_mask);
+
+		/* fill in the receive list */
+		possible = cpumask_weight(&entry->def_intr.mask);
+		curr_cpu = cpumask_first(&entry->def_intr.mask);
+
+		if (possible == 1) {
+			/* only one CPU, everyone will use it */
+			cpumask_set_cpu(curr_cpu, &entry->rcv_intr.mask);
+			cpumask_set_cpu(curr_cpu, &entry->general_intr_mask);
+		} else {
+			int count;
+
+			/*
+			 * The general/control context will be the first CPU in
+			 * the default list, so it is removed from the default
+			 * list and added to the general interrupt list.
+			 */
+			cpumask_clear_cpu(curr_cpu, &entry->def_intr.mask);
+			cpumask_set_cpu(curr_cpu, &entry->general_intr_mask);
+			curr_cpu = cpumask_next(curr_cpu,
+						&entry->def_intr.mask);
+
+			/*
+			 * This count determination is fine for single cards,
+			 * but makes following assumption for multiple cards:
+			 *
+			 * Each hfi2 device has the same number of ports with
+			 * the same number of kernel contexts as the current
+			 * one.  However, JKR has 1 or 2 ports, depending on
+			 * the card type and user enable, while WFR always has
+			 * 1 port.
+			 */
+			count = 0;
+			for (i = 0; i < dd->num_pports; i++)
+				if (dd->pport[i].n_krcv_queues)
+					count += dd->pport[i].n_krcv_queues - 1;
+			count *= hfi2_per_node_cntr[dd->node];
+
+			/*
+			 * Remove the remaining kernel receive queues from
+			 * the default list and add them to the receive list.
+			 */
+			for (i = 0; i < count; i++) {
+				cpumask_clear_cpu(curr_cpu,
+						  &entry->def_intr.mask);
+				cpumask_set_cpu(curr_cpu,
+						&entry->rcv_intr.mask);
+				curr_cpu = cpumask_next(curr_cpu,
+							&entry->def_intr.mask);
+				if (curr_cpu >= nr_cpu_ids)
+					break;
+			}
+
+			/*
+			 * If there ends up being 0 CPU cores leftover for SDMA
+			 * engines, use the same CPU cores as general/control
+			 * context.
+			 */
+			if (cpumask_empty(&entry->def_intr.mask))
+				cpumask_copy(&entry->def_intr.mask,
+					     &entry->general_intr_mask);
+		}
+
+		/* Determine completion vector CPUs for the entire node */
+		cpumask_and(&entry->comp_vect_mask,
+			    &node_affinity.real_cpu_mask, local_mask);
+		cpumask_andnot(&entry->comp_vect_mask,
+			       &entry->comp_vect_mask,
+			       &entry->rcv_intr.mask);
+		cpumask_andnot(&entry->comp_vect_mask,
+			       &entry->comp_vect_mask,
+			       &entry->general_intr_mask);
+
+		/*
+		 * If there ends up being 0 CPU cores leftover for completion
+		 * vectors, use the same CPU core as the general/control
+		 * context.
+		 */
+		if (cpumask_empty(&entry->comp_vect_mask))
+			cpumask_copy(&entry->comp_vect_mask,
+				     &entry->general_intr_mask);
+	}
+
+	ret = _dev_comp_vect_cpu_mask_init(dd, entry, new_entry);
+	if (ret < 0)
+		goto fail;
+
+	if (new_entry)
+		node_affinity_add_tail(entry);
+
+	dd->affinity_entry = entry;
+	mutex_unlock(&node_affinity.lock);
+
+	return 0;
+
+fail:
+	if (new_entry)
+		node_affinity_destroy(entry);
+	mutex_unlock(&node_affinity.lock);
+	return ret;
+}
+
+void hfi2_dev_affinity_clean_up(struct hfi2_devdata *dd)
+{
+	struct hfi2_affinity_node *entry;
+
+	mutex_lock(&node_affinity.lock);
+	if (!dd->affinity_entry)
+		goto unlock;
+	entry = node_affinity_lookup(dd->node);
+	if (!entry)
+		goto unlock;
+
+	/*
+	 * Free device completion vector CPUs to be used by future
+	 * completion vectors
+	 */
+	_dev_comp_vect_cpu_mask_clean_up(dd, entry);
+unlock:
+	dd->affinity_entry = NULL;
+	mutex_unlock(&node_affinity.lock);
+}
+
+/*
+ * Function updates the irq affinity hint for msix after it has been changed
+ * by the user using the /proc/irq interface. This function only accepts
+ * one cpu in the mask.
+ */
+static void hfi2_update_sdma_affinity(struct hfi2_msix_entry *msix, int cpu)
+{
+	struct sdma_engine *sde = msix->arg;
+	struct hfi2_devdata *dd = sde->dd;
+	struct hfi2_affinity_node *entry;
+	struct cpu_mask_set *set;
+	int i, old_cpu;
+
+	if (cpu > num_online_cpus() || cpu == sde->cpu)
+		return;
+
+	mutex_lock(&node_affinity.lock);
+	entry = node_affinity_lookup(dd->node);
+	if (!entry)
+		goto unlock;
+
+	old_cpu = sde->cpu;
+	sde->cpu = cpu;
+	cpumask_clear(&msix->mask);
+	cpumask_set_cpu(cpu, &msix->mask);
+	dd_dev_dbg(dd, "IRQ: %u, type %s engine %u -> cpu: %d\n",
+		   msix->irq, irq_type_names[msix->type],
+		   sde->this_idx, cpu);
+	irq_set_affinity_hint(msix->irq, &msix->mask);
+
+	/*
+	 * Set the new cpu in the hfi2_affinity_node and clean
+	 * the old cpu if it is not used by any other IRQ
+	 */
+	set = &entry->def_intr;
+	cpumask_set_cpu(cpu, &set->mask);
+	cpumask_set_cpu(cpu, &set->used);
+	for (i = 0; i < dd->msix_info.max_requested; i++) {
+		struct hfi2_msix_entry *other_msix;
+
+		other_msix = &dd->msix_info.msix_entries[i];
+		if (other_msix->type != IRQ_SDMA || other_msix == msix)
+			continue;
+
+		if (cpumask_test_cpu(old_cpu, &other_msix->mask))
+			goto unlock;
+	}
+	cpumask_clear_cpu(old_cpu, &set->mask);
+	cpumask_clear_cpu(old_cpu, &set->used);
+unlock:
+	mutex_unlock(&node_affinity.lock);
+}
+
+static void hfi2_irq_notifier_notify(struct irq_affinity_notify *notify,
+				     const cpumask_t *mask)
+{
+	int cpu = cpumask_first(mask);
+	struct hfi2_msix_entry *msix = container_of(notify,
+						    struct hfi2_msix_entry,
+						    notify);
+
+	/* Only one CPU configuration supported currently */
+	hfi2_update_sdma_affinity(msix, cpu);
+}
+
+static void hfi2_irq_notifier_release(struct kref *ref)
+{
+	/*
+	 * This is required by affinity notifier. We don't have anything to
+	 * free here.
+	 */
+}
+
+static void hfi2_setup_sdma_notifier(struct hfi2_msix_entry *msix)
+{
+	struct irq_affinity_notify *notify = &msix->notify;
+
+	notify->irq = msix->irq;
+	notify->notify = hfi2_irq_notifier_notify;
+	notify->release = hfi2_irq_notifier_release;
+
+	if (irq_set_affinity_notifier(notify->irq, notify))
+		pr_err("Failed to register sdma irq affinity notifier for irq %d\n",
+		       notify->irq);
+}
+
+static void hfi2_cleanup_sdma_notifier(struct hfi2_msix_entry *msix)
+{
+	struct irq_affinity_notify *notify = &msix->notify;
+
+	if (irq_set_affinity_notifier(notify->irq, NULL))
+		pr_err("Failed to cleanup sdma irq affinity notifier for irq %d\n",
+		       notify->irq);
+}
+
+/*
+ * Function sets the irq affinity for msix.
+ * It *must* be called with node_affinity.lock held.
+ */
+static int get_irq_affinity(struct hfi2_devdata *dd,
+			    struct hfi2_msix_entry *msix)
+{
+	cpumask_var_t diff;
+	struct hfi2_affinity_node *entry;
+	struct cpu_mask_set *set = NULL;
+	struct sdma_engine *sde = NULL;
+	struct hfi2_ctxtdata *rcd = NULL;
+	char extra[64];
+	int cpu = -1;
+
+	extra[0] = '\0';
+	cpumask_clear(&msix->mask);
+
+	entry = node_affinity_lookup(dd->node);
+
+	switch (msix->type) {
+	case IRQ_SDMA:
+		sde = (struct sdma_engine *)msix->arg;
+		scnprintf(extra, 64, "engine %u", sde->this_idx);
+		set = &entry->def_intr;
+		break;
+	case IRQ_GENERAL:
+		cpu = cpumask_first(&entry->general_intr_mask);
+		break;
+	case IRQ_RCVCTXT:
+		rcd = (struct hfi2_ctxtdata *)msix->arg;
+		if (is_control_context(rcd))
+			cpu = cpumask_first(&entry->general_intr_mask);
+		else
+			set = &entry->rcv_intr;
+		scnprintf(extra, 64, "ctxt %u", rcd->ctxt);
+		break;
+	case IRQ_NETDEVCTXT:
+		rcd = (struct hfi2_ctxtdata *)msix->arg;
+		set = &entry->def_intr;
+		scnprintf(extra, 64, "ctxt %u", rcd->ctxt);
+		break;
+	default:
+		dd_dev_err(dd, "Invalid IRQ type %d\n", msix->type);
+		return -EINVAL;
+	}
+
+	/*
+	 * The general and control contexts are placed on a particular
+	 * CPU, which is set above. Skip accounting for it. Everything else
+	 * finds its CPU here.
+	 */
+	if (cpu == -1 && set) {
+		if (!zalloc_cpumask_var(&diff, GFP_KERNEL))
+			return -ENOMEM;
+
+		cpu = cpu_mask_set_get_first(set, diff);
+		if (cpu < 0) {
+			free_cpumask_var(diff);
+			dd_dev_err(dd, "Failure to obtain CPU for IRQ\n");
+			return cpu;
+		}
+
+		free_cpumask_var(diff);
+	}
+
+	cpumask_set_cpu(cpu, &msix->mask);
+	dd_dev_info(dd, "IRQ: %u, type %s %s -> cpu: %d\n",
+		    msix->irq, irq_type_names[msix->type],
+		    extra, cpu);
+	irq_set_affinity_hint(msix->irq, &msix->mask);
+
+	if (msix->type == IRQ_SDMA) {
+		sde->cpu = cpu;
+		hfi2_setup_sdma_notifier(msix);
+	}
+
+	return 0;
+}
+
+int hfi2_get_irq_affinity(struct hfi2_devdata *dd, struct hfi2_msix_entry *msix)
+{
+	int ret;
+
+	mutex_lock(&node_affinity.lock);
+	ret = get_irq_affinity(dd, msix);
+	mutex_unlock(&node_affinity.lock);
+	return ret;
+}
+
+void hfi2_put_irq_affinity(struct hfi2_devdata *dd,
+			   struct hfi2_msix_entry *msix)
+{
+	struct cpu_mask_set *set = NULL;
+	struct hfi2_affinity_node *entry;
+
+	mutex_lock(&node_affinity.lock);
+	entry = node_affinity_lookup(dd->node);
+
+	switch (msix->type) {
+	case IRQ_SDMA:
+		set = &entry->def_intr;
+		hfi2_cleanup_sdma_notifier(msix);
+		break;
+	case IRQ_GENERAL:
+		/* Don't do accounting for general contexts */
+		break;
+	case IRQ_RCVCTXT: {
+		struct hfi2_ctxtdata *rcd = msix->arg;
+
+		/* Don't do accounting for control contexts */
+		if (!is_control_context(rcd))
+			set = &entry->rcv_intr;
+		break;
+	}
+	case IRQ_NETDEVCTXT:
+		set = &entry->def_intr;
+		break;
+	default:
+		mutex_unlock(&node_affinity.lock);
+		return;
+	}
+
+	if (set) {
+		cpumask_andnot(&set->used, &set->used, &msix->mask);
+		_cpu_mask_set_gen_dec(set);
+	}
+
+	irq_set_affinity_hint(msix->irq, NULL);
+	cpumask_clear(&msix->mask);
+	mutex_unlock(&node_affinity.lock);
+}
+
+int hfi2_get_proc_affinity(int node)
+{
+	int cpu = -1, ret, i;
+	struct hfi2_affinity_node *entry;
+	cpumask_var_t diff, hw_thread_mask, available_mask, intrs_mask;
+	const struct cpumask *node_mask,
+		*proc_mask = current->cpus_ptr;
+	struct hfi2_affinity_node_list *affinity = &node_affinity;
+	struct cpu_mask_set *set = &affinity->proc;
+	int pruned;
+
+	/*
+	 * check whether process/context affinity has already
+	 * been set
+	 */
+	if (current->nr_cpus_allowed == 1) {
+		hfi2_cdbg(PROC, "PID %u %s affinity set to CPU %*pbl",
+			  current->pid, current->comm,
+			  cpumask_pr_args(proc_mask));
+		/*
+		 * Mark the pre-set CPU as used. This is atomic so we don't
+		 * need the lock
+		 */
+		cpu = cpumask_first(proc_mask);
+		cpumask_set_cpu(cpu, &set->used);
+		goto done;
+	} else if (current->nr_cpus_allowed < cpumask_weight(&set->mask)) {
+		hfi2_cdbg(PROC, "PID %u %s affinity set to CPU set(s) %*pbl",
+			  current->pid, current->comm,
+			  cpumask_pr_args(proc_mask));
+		goto done;
+	}
+
+	/*
+	 * The process does not have a preset CPU affinity so find one to
+	 * recommend using the following algorithm:
+	 *
+	 * For each user process that is opening a context on HFI Y:
+	 *  a) If all cores are filled, reinitialize the bitmask
+	 *  b) Fill real cores first, then HT cores (First set of HT
+	 *     cores on all physical cores, then second set of HT core,
+	 *     and, so on) in the following order:
+	 *
+	 *     1. Same NUMA node as HFI Y and not running an IRQ
+	 *        handler
+	 *     2. Same NUMA node as HFI Y and running an IRQ handler
+	 *     3. Different NUMA node to HFI Y and not running an IRQ
+	 *        handler
+	 *     4. Different NUMA node to HFI Y and running an IRQ
+	 *        handler
+	 *  c) Mark core as filled in the bitmask. As user processes are
+	 *     done, clear cores from the bitmask.
+	 */
+
+	ret = zalloc_cpumask_var(&diff, GFP_KERNEL);
+	if (!ret)
+		goto done;
+	ret = zalloc_cpumask_var(&hw_thread_mask, GFP_KERNEL);
+	if (!ret)
+		goto free_diff;
+	ret = zalloc_cpumask_var(&available_mask, GFP_KERNEL);
+	if (!ret)
+		goto free_hw_thread_mask;
+	ret = zalloc_cpumask_var(&intrs_mask, GFP_KERNEL);
+	if (!ret)
+		goto free_available_mask;
+
+	mutex_lock(&affinity->lock);
+	/*
+	 * If we've used all available HW threads, clear the mask and start
+	 * overloading.
+	 */
+	_cpu_mask_set_gen_inc(set);
+
+	/*
+	 * If NUMA node has CPUs used by interrupt handlers, include them in the
+	 * interrupt handler mask.
+	 */
+	entry = node_affinity_lookup(node);
+	if (entry) {
+		cpumask_copy(intrs_mask, (entry->def_intr.gen ?
+					  &entry->def_intr.mask :
+					  &entry->def_intr.used));
+		cpumask_or(intrs_mask, intrs_mask, (entry->rcv_intr.gen ?
+						    &entry->rcv_intr.mask :
+						    &entry->rcv_intr.used));
+		cpumask_or(intrs_mask, intrs_mask, &entry->general_intr_mask);
+	}
+	hfi2_cdbg(PROC, "CPUs used by interrupts: %*pbl",
+		  cpumask_pr_args(intrs_mask));
+
+
+	/*
+	 * If HT cores are enabled, identify which HW threads within the
+	 * physical cores should be used.
+	 *
+	 * Start with affinity mask but prune HT/SMT threads. If all HW threads
+	 * are in use, then try again with all threads in mask, but only if
+	 * threads were pruned before the first step.
+	 */
+	cpumask_copy(hw_thread_mask, &affinity->proc.mask);
+	pruned = clear_ht_siblings(hw_thread_mask);
+	for (i = 0; i < 2; i++) {
+		/*
+		 * diff will always be not empty at least once in this
+		 * loop as the used mask gets reset when
+		 * (set->mask == set->used) before this loop.
+		 */
+		cpumask_andnot(diff, hw_thread_mask, &set->used);
+		if (!cpumask_empty(diff) || !pruned)
+			break;
+		cpumask_copy(hw_thread_mask, &affinity->proc.mask);
+	}
+	hfi2_cdbg(PROC, "Same available HW thread on all physical CPUs: %*pbl",
+		  cpumask_pr_args(hw_thread_mask));
+
+	node_mask = cpumask_of_node(node);
+	hfi2_cdbg(PROC, "Device on NUMA %u, CPUs %*pbl", node,
+		  cpumask_pr_args(node_mask));
+
+	/* Get cpumask of available CPUs on preferred NUMA */
+	cpumask_and(available_mask, hw_thread_mask, node_mask);
+	cpumask_andnot(available_mask, available_mask, &set->used);
+	hfi2_cdbg(PROC, "Available CPUs on NUMA %u: %*pbl", node,
+		  cpumask_pr_args(available_mask));
+
+	/*
+	 * At first, we don't want to place processes on the same
+	 * CPUs as interrupt handlers. Then, CPUs running interrupt
+	 * handlers are used.
+	 *
+	 * 1) If diff is not empty, then there are CPUs not running
+	 *    non-interrupt handlers available, so diff gets copied
+	 *    over to available_mask.
+	 * 2) If diff is empty, then all CPUs not running interrupt
+	 *    handlers are taken, so available_mask contains all
+	 *    available CPUs running interrupt handlers.
+	 * 3) If available_mask is empty, then all CPUs on the
+	 *    preferred NUMA node are taken, so other NUMA nodes are
+	 *    used for process assignments using the same method as
+	 *    the preferred NUMA node.
+	 */
+	cpumask_andnot(diff, available_mask, intrs_mask);
+	if (!cpumask_empty(diff))
+		cpumask_copy(available_mask, diff);
+
+	/* If we don't have CPUs on the preferred node, use other NUMA nodes */
+	if (cpumask_empty(available_mask)) {
+		cpumask_andnot(available_mask, hw_thread_mask, &set->used);
+		/* Excluding preferred NUMA cores */
+		cpumask_andnot(available_mask, available_mask, node_mask);
+		hfi2_cdbg(PROC,
+			  "Preferred NUMA node cores are taken, cores available in other NUMA nodes: %*pbl",
+			  cpumask_pr_args(available_mask));
+
+		/*
+		 * At first, we don't want to place processes on the same
+		 * CPUs as interrupt handlers.
+		 */
+		cpumask_andnot(diff, available_mask, intrs_mask);
+		if (!cpumask_empty(diff))
+			cpumask_copy(available_mask, diff);
+	}
+	hfi2_cdbg(PROC, "Possible CPUs for process: %*pbl",
+		  cpumask_pr_args(available_mask));
+
+	cpu = cpumask_first(available_mask);
+	if (cpu >= nr_cpu_ids) /* empty */
+		cpu = -1;
+	else
+		cpumask_set_cpu(cpu, &set->used);
+
+	mutex_unlock(&affinity->lock);
+	hfi2_cdbg(PROC, "Process assigned to CPU %d", cpu);
+
+	free_cpumask_var(intrs_mask);
+free_available_mask:
+	free_cpumask_var(available_mask);
+free_hw_thread_mask:
+	free_cpumask_var(hw_thread_mask);
+free_diff:
+	free_cpumask_var(diff);
+done:
+	return cpu;
+}
+
+void hfi2_put_proc_affinity(int cpu)
+{
+	struct hfi2_affinity_node_list *affinity = &node_affinity;
+	struct cpu_mask_set *set = &affinity->proc;
+
+	if (cpu < 0)
+		return;
+
+	mutex_lock(&affinity->lock);
+	cpu_mask_set_put(set, cpu);
+	hfi2_cdbg(PROC, "Returning CPU %d for future process assignment", cpu);
+	mutex_unlock(&affinity->lock);
+}
diff --git a/drivers/infiniband/hw/hfi2/aspm.c b/drivers/infiniband/hw/hfi2/aspm.c
new file mode 100644
index 000000000000..6c39d3f55a11
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/aspm.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2019 Intel Corporation.
+ *
+ */
+
+#include "aspm.h"
+
+/* Time after which the timer interrupt will re-enable ASPM */
+#define ASPM_TIMER_MS 1000
+/* Time for which interrupts are ignored after a timer has been scheduled */
+#define ASPM_RESCHED_TIMER_MS (ASPM_TIMER_MS / 2)
+/* Two interrupts within this time trigger ASPM disable */
+#define ASPM_TRIGGER_MS 1
+#define ASPM_TRIGGER_NS (ASPM_TRIGGER_MS * 1000 * 1000ull)
+#define ASPM_L1_SUPPORTED(reg) \
+	((((reg) & PCI_EXP_LNKCAP_ASPMS) >> 10) & 0x2)
+
+uint aspm_mode = ASPM_MODE_DISABLED;
+module_param_named(aspm, aspm_mode, uint, 0444);
+MODULE_PARM_DESC(aspm, "PCIe ASPM: 0: disable, 1: enable, 2: dynamic");
+
+static bool aspm_hw_l1_supported(struct hfi2_devdata *dd)
+{
+	struct pci_dev *parent = dd->pcidev->bus->self;
+	u32 up, dn;
+
+	/*
+	 * If the driver does not have access to the upstream component,
+	 * it cannot support ASPM L1 at all.
+	 */
+	if (!parent)
+		return false;
+
+	pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &dn);
+	dn = ASPM_L1_SUPPORTED(dn);
+
+	pcie_capability_read_dword(parent, PCI_EXP_LNKCAP, &up);
+	up = ASPM_L1_SUPPORTED(up);
+
+	/* ASPM works on A-step but is reported as not supported */
+	return (!!dn || is_ax(dd)) && !!up;
+}
+
+/* Set L1 entrance latency for slower entry to L1 */
+static void aspm_hw_set_l1_ent_latency(struct hfi2_devdata *dd)
+{
+	u32 l1_ent_lat = 0x4u;
+	u32 reg32;
+
+	pci_read_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, &reg32);
+	reg32 &= ~PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SMASK;
+	reg32 |= l1_ent_lat << PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SHIFT;
+	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL3, reg32);
+}
+
+static void aspm_hw_enable_l1(struct hfi2_devdata *dd)
+{
+	struct pci_dev *parent = dd->pcidev->bus->self;
+
+	/*
+	 * If the driver does not have access to the upstream component,
+	 * it cannot support ASPM L1 at all.
+	 */
+	if (!parent)
+		return;
+
+	/* Enable ASPM L1 first in upstream component and then downstream */
+	pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   PCI_EXP_LNKCTL_ASPM_L1);
+	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC,
+					   PCI_EXP_LNKCTL_ASPM_L1);
+}
+
+void aspm_hw_disable_l1(struct hfi2_devdata *dd)
+{
+	struct pci_dev *parent = dd->pcidev->bus->self;
+
+	/* Disable ASPM L1 first in downstream component and then upstream */
+	pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL,
+					   PCI_EXP_LNKCTL_ASPMC, 0x0);
+	if (parent)
+		pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL,
+						   PCI_EXP_LNKCTL_ASPMC, 0x0);
+}
+
+static  void aspm_enable(struct hfi2_devdata *dd)
+{
+	if (dd->aspm_enabled || aspm_mode == ASPM_MODE_DISABLED ||
+	    !dd->aspm_supported)
+		return;
+
+	aspm_hw_enable_l1(dd);
+	dd->aspm_enabled = true;
+}
+
+static  void aspm_disable(struct hfi2_devdata *dd)
+{
+	if (!dd->aspm_enabled || aspm_mode == ASPM_MODE_ENABLED)
+		return;
+
+	aspm_hw_disable_l1(dd);
+	dd->aspm_enabled = false;
+}
+
+static  void aspm_disable_inc(struct hfi2_devdata *dd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->aspm_lock, flags);
+	aspm_disable(dd);
+	atomic_inc(&dd->aspm_disabled_cnt);
+	spin_unlock_irqrestore(&dd->aspm_lock, flags);
+}
+
+static  void aspm_enable_dec(struct hfi2_devdata *dd)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->aspm_lock, flags);
+	if (atomic_dec_and_test(&dd->aspm_disabled_cnt))
+		aspm_enable(dd);
+	spin_unlock_irqrestore(&dd->aspm_lock, flags);
+}
+
+/* ASPM processing for each receive context interrupt */
+void __aspm_ctx_disable(struct hfi2_ctxtdata *rcd)
+{
+	bool restart_timer;
+	bool close_interrupts;
+	unsigned long flags;
+	ktime_t now, prev;
+
+	spin_lock_irqsave(&rcd->aspm_lock, flags);
+	/* PSM contexts are open */
+	if (!rcd->aspm_intr_enable)
+		goto unlock;
+
+	prev = rcd->aspm_ts_last_intr;
+	now = ktime_get();
+	rcd->aspm_ts_last_intr = now;
+
+	/* An interrupt pair close together in time */
+	close_interrupts = ktime_to_ns(ktime_sub(now, prev)) < ASPM_TRIGGER_NS;
+
+	/* Don't push out our timer till this much time has elapsed */
+	restart_timer = ktime_to_ns(ktime_sub(now, rcd->aspm_ts_timer_sched)) >
+				    ASPM_RESCHED_TIMER_MS * NSEC_PER_MSEC;
+	restart_timer = restart_timer && close_interrupts;
+
+	/* Disable ASPM and schedule timer */
+	if (rcd->aspm_enabled && close_interrupts) {
+		aspm_disable_inc(rcd->dd);
+		rcd->aspm_enabled = false;
+		restart_timer = true;
+	}
+
+	if (restart_timer) {
+		mod_timer(&rcd->aspm_timer,
+			  jiffies + msecs_to_jiffies(ASPM_TIMER_MS));
+		rcd->aspm_ts_timer_sched = now;
+	}
+unlock:
+	spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+}
+
+/* Timer function for re-enabling ASPM in the absence of interrupt activity */
+static  void aspm_ctx_timer_function(struct timer_list *t)
+{
+	struct hfi2_ctxtdata *rcd = from_timer(rcd, t, aspm_timer);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rcd->aspm_lock, flags);
+	aspm_enable_dec(rcd->dd);
+	rcd->aspm_enabled = true;
+	spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+}
+
+/*
+ * Disable interrupt processing for verbs contexts when user contexts
+ * are open.
+ */
+void aspm_disable_all(struct hfi2_devdata *dd)
+{
+	struct hfi2_ctxtdata *rcd;
+	unsigned long flags;
+	u16 i;
+	u16 j;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+
+		for (j = ppd->rcv_context_base;
+		     j < ppd->first_dyn_alloc_ctxt;
+		     j++) {
+			rcd = hfi2_rcd_get_by_index(dd, j);
+			if (!rcd)
+				continue;
+			timer_delete_sync(&rcd->aspm_timer);
+			spin_lock_irqsave(&rcd->aspm_lock, flags);
+			rcd->aspm_intr_enable = false;
+			spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+			hfi2_rcd_put(rcd);
+		}
+	}
+
+	aspm_disable(dd);
+	atomic_set(&dd->aspm_disabled_cnt, 0);
+}
+
+/* Re-enable interrupt processing for verbs contexts */
+void aspm_enable_all(struct hfi2_devdata *dd)
+{
+	struct hfi2_ctxtdata *rcd;
+	unsigned long flags;
+	u16 i;
+	u16 j;
+
+	aspm_enable(dd);
+
+	if (aspm_mode != ASPM_MODE_DYNAMIC)
+		return;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+
+		for (j = ppd->rcv_context_base;
+		     j < ppd->first_dyn_alloc_ctxt;
+		     j++) {
+			rcd = hfi2_rcd_get_by_index(dd, j);
+			if (!rcd)
+				continue;
+			spin_lock_irqsave(&rcd->aspm_lock, flags);
+			rcd->aspm_intr_enable = true;
+			rcd->aspm_enabled = true;
+			spin_unlock_irqrestore(&rcd->aspm_lock, flags);
+			hfi2_rcd_put(rcd);
+		}
+	}
+}
+
+static  void aspm_ctx_init(struct hfi2_ctxtdata *rcd)
+{
+	spin_lock_init(&rcd->aspm_lock);
+	timer_setup(&rcd->aspm_timer, aspm_ctx_timer_function, 0);
+	rcd->aspm_intr_supported = rcd->dd->aspm_supported &&
+		aspm_mode == ASPM_MODE_DYNAMIC &&
+		is_kernel_context(rcd);
+}
+
+void aspm_init(struct hfi2_devdata *dd)
+{
+	struct hfi2_ctxtdata *rcd;
+	u16 i;
+	u16 j;
+
+	spin_lock_init(&dd->aspm_lock);
+	dd->aspm_supported = aspm_hw_l1_supported(dd);
+
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+
+		for (j = ppd->rcv_context_base;
+		     j < ppd->first_dyn_alloc_ctxt;
+		     j++) {
+			rcd = hfi2_rcd_get_by_index(dd, j);
+			if (rcd)
+				aspm_ctx_init(rcd);
+			hfi2_rcd_put(rcd);
+		}
+	}
+
+	/* Start with ASPM disabled */
+	aspm_hw_set_l1_ent_latency(dd);
+	dd->aspm_enabled = false;
+	aspm_hw_disable_l1(dd);
+
+	/* Now turn on ASPM if configured */
+	aspm_enable_all(dd);
+}
+
+void aspm_exit(struct hfi2_devdata *dd)
+{
+	aspm_disable_all(dd);
+
+	/* Turn on ASPM on exit to conserve power */
+	aspm_enable(dd);
+}
+
diff --git a/drivers/infiniband/hw/hfi2/driver.c b/drivers/infiniband/hw/hfi2/driver.c
new file mode 100644
index 000000000000..e0c5397b861d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/driver.c
@@ -0,0 +1,1959 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015-2020 Intel Corporation.
+ * Copyright(c) 2021 Cornelis Networks.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+#include <linux/prefetch.h>
+#include <rdma/ib_verbs.h>
+#include <linux/etherdevice.h>
+
+#include "hfi2.h"
+#include "trace.h"
+#include "qp.h"
+#include "sdma.h"
+#include "debugfs.h"
+#include "fault.h"
+
+#include "ipoib.h"
+#include "netdev.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) DRIVER_NAME ": " fmt
+
+DEFINE_MUTEX(hfi2_mutex);	/* general driver use */
+
+unsigned int hfi2_max_mtu = HFI2_DEFAULT_MAX_MTU;
+module_param_named(max_mtu, hfi2_max_mtu, uint, S_IRUGO);
+MODULE_PARM_DESC(max_mtu, "Set max MTU bytes, default is " __stringify(
+		 HFI2_DEFAULT_MAX_MTU));
+
+unsigned int hfi2_cu = 1;
+module_param_named(cu, hfi2_cu, uint, S_IRUGO);
+MODULE_PARM_DESC(cu, "Credit return units");
+
+unsigned long hfi2_cap_mask = HFI2_CAP_MASK_DEFAULT;
+static int hfi2_caps_set(const char *val, const struct kernel_param *kp);
+static int hfi2_caps_get(char *buffer, const struct kernel_param *kp);
+static const struct kernel_param_ops cap_ops = {
+	.set = hfi2_caps_set,
+	.get = hfi2_caps_get
+};
+module_param_cb(cap_mask, &cap_ops, &hfi2_cap_mask, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(cap_mask, "Bit mask of enabled/disabled HW features");
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("Cornelis Omni-Path Express driver");
+
+/*
+ * MAX_PKT_RCV is the max # if packets processed per receive interrupt.
+ */
+#define MAX_PKT_RECV 64
+/*
+ * MAX_PKT_THREAD_RCV is the max # of packets processed before
+ * the qp_wait_list queue is flushed.
+ */
+#define MAX_PKT_RECV_THREAD (MAX_PKT_RECV * 4)
+#define EGR_HEAD_UPDATE_THRESHOLD 16
+
+struct hfi2_ib_stats hfi2_stats;
+
+static int hfi2_caps_set(const char *val, const struct kernel_param *kp)
+{
+	int ret = 0;
+	unsigned long *cap_mask_ptr = (unsigned long *)kp->arg,
+		cap_mask = *cap_mask_ptr, value, diff,
+		write_mask = ((HFI2_CAP_WRITABLE_MASK << HFI2_CAP_USER_SHIFT) |
+			      HFI2_CAP_WRITABLE_MASK);
+
+	ret = kstrtoul(val, 0, &value);
+	if (ret) {
+		pr_warn("Invalid module parameter value for 'cap_mask'\n");
+		goto done;
+	}
+	/* Get the changed bits (except the locked bit) */
+	diff = value ^ (cap_mask & ~HFI2_CAP_LOCKED_SMASK);
+
+	/* Remove any bits that are not allowed to change after driver load */
+	if (HFI2_CAP_LOCKED() && (diff & ~write_mask)) {
+		pr_warn("Ignoring non-writable capability bits %#lx\n",
+			diff & ~write_mask);
+		diff &= write_mask;
+	}
+
+	/* Mask off any reserved bits */
+	diff &= ~HFI2_CAP_RESERVED_MASK;
+	/* Clear any previously set and changing bits */
+	cap_mask &= ~diff;
+	/* Update the bits with the new capability */
+	cap_mask |= (value & diff);
+	/* Check for any kernel/user restrictions */
+	diff = (cap_mask & (HFI2_CAP_MUST_HAVE_KERN << HFI2_CAP_USER_SHIFT)) ^
+		((cap_mask & HFI2_CAP_MUST_HAVE_KERN) << HFI2_CAP_USER_SHIFT);
+	cap_mask &= ~diff;
+	/* Set the bitmask to the final set */
+	*cap_mask_ptr = cap_mask;
+done:
+	return ret;
+}
+
+static int hfi2_caps_get(char *buffer, const struct kernel_param *kp)
+{
+	unsigned long cap_mask = *(unsigned long *)kp->arg;
+
+	cap_mask &= ~HFI2_CAP_LOCKED_SMASK;
+	cap_mask |= ((cap_mask & HFI2_CAP_K2U) << HFI2_CAP_USER_SHIFT);
+
+	return sysfs_emit(buffer, "0x%lx\n", cap_mask);
+}
+
+struct pci_dev *get_pci_dev(struct rvt_dev_info *rdi)
+{
+	struct hfi2_ibdev *ibdev = container_of(rdi, struct hfi2_ibdev, rdi);
+	struct hfi2_devdata *dd = container_of(ibdev,
+					       struct hfi2_devdata, verbs_dev);
+	return dd->pcidev;
+}
+
+/*
+ * Return count of units with at least one port ACTIVE.
+ */
+int hfi2_count_active_units(void)
+{
+	struct hfi2_devdata *dd;
+	struct hfi2_pportdata *ppd;
+	unsigned long index, flags;
+	int pidx, nunits_active = 0;
+
+	xa_lock_irqsave(&hfi2_dev_table, flags);
+	xa_for_each(&hfi2_dev_table, index, dd) {
+		if (!(dd->flags & HFI2_PRESENT) || !dd->kregbase1)
+			continue;
+		for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+			ppd = dd->pport + pidx;
+			if (ppd->lid && ppd->linkup) {
+				nunits_active++;
+				break;
+			}
+		}
+	}
+	xa_unlock_irqrestore(&hfi2_dev_table, flags);
+	return nunits_active;
+}
+
+/*
+ * Get address of eager buffer from it's index (allocated in chunks, not
+ * contiguous).
+ */
+static inline void *get_egrbuf(const struct hfi2_packet *packet, u8 *update)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	u32 idx = packet->egr_index;
+	u32 offset = rhf_egr_buf_offset(packet->rhf);
+
+	*update |= !(idx & (rcd->egrbufs.threshold - 1)) && !offset;
+	return (void *)(((u64)(rcd->egrbufs.rcvtids[idx].addr)) +
+			(offset * RCV_BUF_BLOCK_SIZE));
+}
+
+static inline void *hfi2_get_header(struct hfi2_ctxtdata *rcd,
+				    __le32 *rhf_addr)
+{
+	u32 offset = rhf_hdrq_offset(rhf_to_cpu(rhf_addr));
+
+	return (void *)(rhf_addr - rcd->rhf_offset + offset);
+}
+
+static inline struct ib_header *hfi2_get_msgheader(struct hfi2_ctxtdata *rcd,
+						   __le32 *rhf_addr)
+{
+	return (struct ib_header *)hfi2_get_header(rcd, rhf_addr);
+}
+
+static inline struct hfi2_16b_header
+		*hfi2_get_16B_header(struct hfi2_ctxtdata *rcd,
+				     __le32 *rhf_addr)
+{
+	return (struct hfi2_16b_header *)hfi2_get_header(rcd, rhf_addr);
+}
+
+/*
+ * Validate and encode the a given RcvArray Buffer size.
+ * The function will check whether the given size falls within
+ * allowed size ranges for the respective type and, optionally,
+ * return the proper encoding.
+ */
+int hfi2_rcvbuf_validate(u32 size, u8 type, u16 *encoded)
+{
+	if (unlikely(!PAGE_ALIGNED(size)))
+		return 0;
+	if (unlikely(size < MIN_EAGER_BUFFER))
+		return 0;
+	if (size >
+	    (type == PT_EAGER ? MAX_EAGER_BUFFER : MAX_EXPECTED_BUFFER))
+		return 0;
+	if (encoded)
+		*encoded = ilog2(size / PAGE_SIZE) + 1;
+	return 1;
+}
+
+static void rcv_hdrerr(struct hfi2_ctxtdata *rcd, struct hfi2_pportdata *ppd,
+		       struct hfi2_packet *packet)
+{
+	struct ib_header *rhdr = packet->hdr;
+	u32 rte = rhe_rcv_type_err(packet);
+	u32 mlid_base;
+	struct hfi2_ibport *ibp = rcd_to_iport(rcd);
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_ibdev *verbs_dev = &dd->verbs_dev;
+	struct rvt_dev_info *rdi = &verbs_dev->rdi;
+
+	if (rhe_crk_err(packet) &&
+	    hfi2_dbg_fault_suppress_err(verbs_dev))
+		return;
+
+	if (rhe_icrc_err(packet))
+		return;
+
+	if (packet->etype == RHF_RCV_TYPE_BYPASS) {
+		goto drop;
+	} else {
+		u8 lnh = ib_get_lnh(rhdr);
+
+		mlid_base = be16_to_cpu(IB_MULTICAST_LID_BASE);
+		if (lnh == HFI2_LRH_BTH) {
+			packet->ohdr = &rhdr->u.oth;
+		} else if (lnh == HFI2_LRH_GRH) {
+			packet->ohdr = &rhdr->u.l.oth;
+			packet->grh = &rhdr->u.l.grh;
+		} else {
+			goto drop;
+		}
+	}
+
+	if (rhe_tid_err(packet)) {
+		/* For TIDERR and RC QPs preemptively schedule a NAK */
+		u32 tlen = rhf_pkt_len(packet->rhf); /* in bytes */
+		u32 dlid = ib_get_dlid(rhdr);
+		u32 qp_num;
+
+		/* Sanity check packet */
+		if (tlen < 24)
+			goto drop;
+
+		/* Check for GRH */
+		if (packet->grh) {
+			u32 vtf;
+			struct ib_grh *grh = packet->grh;
+
+			if (grh->next_hdr != IB_GRH_NEXT_HDR)
+				goto drop;
+			vtf = be32_to_cpu(grh->version_tclass_flow);
+			if ((vtf >> IB_GRH_VERSION_SHIFT) != IB_GRH_VERSION)
+				goto drop;
+		}
+
+		/* Get the destination QP number. */
+		qp_num = ib_bth_get_qpn(packet->ohdr);
+		if (dlid < mlid_base) {
+			struct rvt_qp *qp;
+			unsigned long flags;
+
+			rcu_read_lock();
+			qp = rvt_lookup_qpn(rdi, &ibp->rvp, qp_num);
+			if (!qp) {
+				rcu_read_unlock();
+				goto drop;
+			}
+
+			/*
+			 * Handle only RC QPs - for other QP types drop error
+			 * packet.
+			 */
+			spin_lock_irqsave(&qp->r_lock, flags);
+
+			/* Check for valid receive state. */
+			if (!(ib_rvt_state_ops[qp->state] &
+			      RVT_PROCESS_RECV_OK)) {
+				ibp->rvp.n_pkt_drops++;
+			}
+
+			switch (qp->ibqp.qp_type) {
+			case IB_QPT_RC:
+				hfi2_rc_hdrerr(rcd, packet, qp);
+				break;
+			default:
+				/* For now don't handle any other QP types */
+				break;
+			}
+
+			spin_unlock_irqrestore(&qp->r_lock, flags);
+			rcu_read_unlock();
+		} /* Unicast QP */
+	} /* Valid packet with TIDErr */
+
+	/* handle "RcvTypeErr" flags */
+	switch (rte) {
+	case RHF_RTE_ERROR_OP_CODE_ERR:
+	{
+		void *ebuf = NULL;
+		u8 opcode;
+
+		if (rhf_use_egr_bfr(packet->rhf))
+			ebuf = packet->ebuf;
+
+		if (!ebuf)
+			goto drop; /* this should never happen */
+
+		opcode = ib_bth_get_opcode(packet->ohdr);
+		if (opcode == IB_OPCODE_CNP) {
+			/*
+			 * Only in pre-B0 h/w is the CNP_OPCODE handled
+			 * via this code path.
+			 */
+			struct rvt_qp *qp = NULL;
+			u32 lqpn, rqpn;
+			u16 rlid;
+			u8 svc_type, sl, sc5;
+
+			sc5 = hfi2_9B_get_sc5(rhdr, packet->sc4);
+			sl = ibp->sc_to_sl[sc5];
+
+			lqpn = ib_bth_get_qpn(packet->ohdr);
+			rcu_read_lock();
+			qp = rvt_lookup_qpn(rdi, &ibp->rvp, lqpn);
+			if (!qp) {
+				rcu_read_unlock();
+				goto drop;
+			}
+
+			switch (qp->ibqp.qp_type) {
+			case IB_QPT_UD:
+				rlid = 0;
+				rqpn = 0;
+				svc_type = IB_CC_SVCTYPE_UD;
+				break;
+			case IB_QPT_UC:
+				rlid = ib_get_slid(rhdr);
+				rqpn = qp->remote_qpn;
+				svc_type = IB_CC_SVCTYPE_UC;
+				break;
+			default:
+				rcu_read_unlock();
+				goto drop;
+			}
+
+			process_becn(ppd, sl, rlid, lqpn, rqpn, svc_type);
+			rcu_read_unlock();
+		}
+
+		packet->rhf &= ~RHF_RCV_TYPE_ERR_SMASK;
+		break;
+	}
+	default:
+		break;
+	}
+
+drop:
+	return;
+}
+
+/* cache values derived from the RHF that are chip dependent */
+static void cache_rhf_values(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	u64 rhf = packet->rhf;
+
+	if (rcd->dd->params->chip_type == CHIP_WFR) {
+		packet->egr_index = wfr_rhf_egr_index(rhf);
+		packet->sc4 = !!wfr_rhf_dc_info(rhf);
+		packet->rcv_seq = wfr_rhf_rcv_seq(rhf);
+		packet->err_flags = wfr_rhf_err_flags(rhf);
+		packet->has_errs = packet->err_flags != 0;
+	} else {
+		packet->egr_index = (rhf >> 16) & 0xffff; /* RHF.EgrIndex */
+		packet->sc4 = (rhf >> 53) & 0x1;	  /* RHF.L2Type9bSc4 */
+		packet->rcv_seq = jkr_rhf_rcv_seq(rhf);	  /* RHF.RcvSeq */
+		packet->has_errs = (rhf >> 63) & 0x1;	  /* RHF.RheValid */
+		/*
+		 * NOTE: (1) The divide can be changed to a shift.  Should
+		 *           pre-calculate the value.
+		 *       (2) rhqoff (head) and rsize are both in words.
+		 */
+		if (packet->has_errs)
+			packet->err_flags = ((u64 *)(rcd->rheq))[packet->rhqoff / packet->rsize];
+		else
+			packet->err_flags = 0;
+	}
+}
+
+static inline void init_packet(struct hfi2_ctxtdata *rcd,
+			       struct hfi2_packet *packet)
+{
+	packet->rsize = get_hdrqentsize(rcd); /* words */
+	packet->maxcnt = get_hdrq_cnt(rcd) * packet->rsize; /* words */
+	packet->rcd = rcd;
+	packet->updegr = 0;
+	packet->etail = -1;
+	packet->rhqoff = hfi2_rcd_head(rcd);
+	packet->numpkt = 0;
+	packet->rhf_addr = get_rhf_addr(rcd);
+	packet->rhf = rhf_to_cpu(packet->rhf_addr);
+	cache_rhf_values(packet);
+}
+
+/* We support only two types - 9B and 16B for now */
+static const hfi2_handle_cnp hfi2_handle_cnp_tbl[2] = {
+	[HFI2_PKT_TYPE_9B] = &return_cnp,
+	[HFI2_PKT_TYPE_16B] = &return_cnp_16B
+};
+
+/**
+ * hfi2_process_ecn_slowpath - Process FECN or BECN bits
+ * @qp: The packet's destination QP
+ * @pkt: The packet itself.
+ * @prescan: Is the caller the RXQ prescan
+ *
+ * Process the packet's FECN or BECN bits. By now, the packet
+ * has already been evaluated whether processing of those bit should
+ * be done.
+ * The significance of the @prescan argument is that if the caller
+ * is the RXQ prescan, a CNP will be send out instead of waiting for the
+ * normal packet processing to send an ACK with BECN set (or a CNP).
+ */
+bool hfi2_process_ecn_slowpath(struct rvt_qp *qp, struct hfi2_packet *pkt,
+			       bool prescan)
+{
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct ib_other_headers *ohdr = pkt->ohdr;
+	struct ib_grh *grh = pkt->grh;
+	u32 rqpn = 0;
+	u16 pkey;
+	u32 rlid, slid, dlid = 0;
+	u8 hdr_type, sc, svc_type, opcode;
+	bool is_mcast = false, ignore_fecn = false, do_cnp = false,
+		fecn, becn;
+
+	/* can be called from prescan */
+	if (pkt->etype == RHF_RCV_TYPE_BYPASS) {
+		pkey = hfi2_16B_get_pkey(pkt->hdr);
+		sc = hfi2_16B_get_sc(pkt->hdr);
+		dlid = hfi2_16B_get_dlid(pkt->hdr);
+		slid = hfi2_16B_get_slid(pkt->hdr);
+		is_mcast = hfi2_is_16B_mcast(dlid);
+		opcode = ib_bth_get_opcode(ohdr);
+		hdr_type = HFI2_PKT_TYPE_16B;
+		fecn = hfi2_16B_get_fecn(pkt->hdr);
+		becn = hfi2_16B_get_becn(pkt->hdr);
+	} else {
+		pkey = ib_bth_get_pkey(ohdr);
+		sc = hfi2_9B_get_sc5(pkt->hdr, pkt->sc4);
+		dlid = qp->ibqp.qp_type != IB_QPT_UD ? ib_get_dlid(pkt->hdr) :
+			ppd->lid;
+		slid = ib_get_slid(pkt->hdr);
+		is_mcast = (dlid > be16_to_cpu(IB_MULTICAST_LID_BASE)) &&
+			   (dlid != be16_to_cpu(IB_LID_PERMISSIVE));
+		opcode = ib_bth_get_opcode(ohdr);
+		hdr_type = HFI2_PKT_TYPE_9B;
+		fecn = ib_bth_get_fecn(ohdr);
+		becn = ib_bth_get_becn(ohdr);
+	}
+
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_UD:
+		rlid = slid;
+		rqpn = ib_get_sqpn(pkt->ohdr);
+		svc_type = IB_CC_SVCTYPE_UD;
+		break;
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+		rlid = slid;
+		rqpn = ib_get_sqpn(pkt->ohdr);
+		svc_type = IB_CC_SVCTYPE_UD;
+		break;
+	case IB_QPT_UC:
+		rlid = rdma_ah_get_dlid(&qp->remote_ah_attr);
+		rqpn = qp->remote_qpn;
+		svc_type = IB_CC_SVCTYPE_UC;
+		break;
+	case IB_QPT_RC:
+		rlid = rdma_ah_get_dlid(&qp->remote_ah_attr);
+		rqpn = qp->remote_qpn;
+		svc_type = IB_CC_SVCTYPE_RC;
+		break;
+	default:
+		return false;
+	}
+
+	ignore_fecn = is_mcast || (opcode == IB_OPCODE_CNP) ||
+		(opcode == IB_OPCODE_RC_ACKNOWLEDGE);
+	/*
+	 * ACKNOWLEDGE packets do not get a CNP but this will be
+	 * guarded by ignore_fecn above.
+	 */
+	do_cnp = prescan ||
+		(opcode >= IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST &&
+		 opcode <= IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE) ||
+		opcode == TID_OP(READ_RESP) ||
+		opcode == TID_OP(ACK);
+
+	/* Call appropriate CNP handler */
+	if (!ignore_fecn && do_cnp && fecn)
+		hfi2_handle_cnp_tbl[hdr_type](ibp, qp, rqpn, pkey,
+					      dlid, rlid, sc, grh);
+
+	if (becn) {
+		u32 lqpn = be32_to_cpu(ohdr->bth[1]) & RVT_QPN_MASK;
+		u8 sl = ibp->sc_to_sl[sc];
+
+		process_becn(ppd, sl, rlid, lqpn, rqpn, svc_type);
+	}
+	return !ignore_fecn && fecn;
+}
+
+struct ps_mdata {
+	struct hfi2_ctxtdata *rcd;
+	u32 rsize;
+	u32 maxcnt;
+	u32 ps_head;
+	u32 ps_tail;
+	u32 ps_seq;
+};
+
+static inline void init_ps_mdata(struct ps_mdata *mdata,
+				 struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+
+	mdata->rcd = rcd;
+	mdata->rsize = packet->rsize;
+	mdata->maxcnt = packet->maxcnt;
+	mdata->ps_head = packet->rhqoff;
+
+	if (get_dma_rtail_setting(rcd)) {
+		mdata->ps_tail = get_rcvhdrtail(rcd);
+		if (is_control_context(rcd))
+			mdata->ps_seq = hfi2_seq_cnt(rcd);
+		else
+			mdata->ps_seq = 0; /* not used with DMA_RTAIL */
+	} else {
+		mdata->ps_tail = 0; /* used only with DMA_RTAIL*/
+		mdata->ps_seq = hfi2_seq_cnt(rcd);
+	}
+}
+
+static inline int ps_done(struct ps_mdata *mdata, u64 rhf,
+			  struct hfi2_ctxtdata *rcd)
+{
+	if (get_dma_rtail_setting(rcd))
+		return mdata->ps_head == mdata->ps_tail;
+	return mdata->ps_seq != slow_rhf_rcv_seq(rcd, rhf);
+}
+
+static inline int ps_skip(struct ps_mdata *mdata, u64 rhf,
+			  struct hfi2_ctxtdata *rcd)
+{
+	/*
+	 * Control context can potentially receive an invalid rhf.
+	 * Drop such packets.
+	 */
+	if (is_control_context(rcd) && (mdata->ps_head != mdata->ps_tail))
+		return mdata->ps_seq != slow_rhf_rcv_seq(rcd, rhf);
+
+	return 0;
+}
+
+static inline void update_ps_mdata(struct ps_mdata *mdata,
+				   struct hfi2_ctxtdata *rcd)
+{
+	mdata->ps_head += mdata->rsize;
+	if (mdata->ps_head >= mdata->maxcnt)
+		mdata->ps_head = 0;
+
+	/* Control context must do seq counting */
+	if (!get_dma_rtail_setting(rcd) || is_control_context(rcd))
+		mdata->ps_seq = hfi2_seq_incr_wrap(mdata->ps_seq);
+}
+
+/*
+ * prescan_rxq - search through the receive queue looking for packets
+ * containing Excplicit Congestion Notifications (FECNs, or BECNs).
+ * When an ECN is found, process the Congestion Notification, and toggle
+ * it off.
+ * This is declared as a macro to allow quick checking of the port to avoid
+ * the overhead of a function call if not enabled.
+ */
+#define prescan_rxq(rcd, packet) \
+	do { \
+		if (rcd->ppd->cc_prescan) \
+			__prescan_rxq(packet); \
+	} while (0)
+static void __prescan_rxq(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct ps_mdata mdata;
+
+	init_ps_mdata(&mdata, packet);
+
+	while (1) {
+		struct hfi2_ibport *ibp = rcd_to_iport(rcd);
+		__le32 *rhf_addr = (__le32 *)rcd->rcvhdrq + mdata.ps_head +
+					 packet->rcd->rhf_offset;
+		struct rvt_qp *qp;
+		struct ib_header *hdr;
+		struct rvt_dev_info *rdi = &rcd->dd->verbs_dev.rdi;
+		u64 rhf = rhf_to_cpu(rhf_addr);
+		u32 etype = rhf_rcv_type(rhf), qpn, bth1;
+		u8 lnh;
+
+		if (ps_done(&mdata, rhf, rcd))
+			break;
+
+		if (ps_skip(&mdata, rhf, rcd))
+			goto next;
+
+		if (etype != RHF_RCV_TYPE_IB)
+			goto next;
+
+		packet->hdr = hfi2_get_msgheader(packet->rcd, rhf_addr);
+		hdr = packet->hdr;
+		lnh = ib_get_lnh(hdr);
+
+		if (lnh == HFI2_LRH_BTH) {
+			packet->ohdr = &hdr->u.oth;
+			packet->grh = NULL;
+		} else if (lnh == HFI2_LRH_GRH) {
+			packet->ohdr = &hdr->u.l.oth;
+			packet->grh = &hdr->u.l.grh;
+		} else {
+			goto next; /* just in case */
+		}
+
+		if (!hfi2_may_ecn(packet))
+			goto next;
+
+		bth1 = be32_to_cpu(packet->ohdr->bth[1]);
+		qpn = bth1 & RVT_QPN_MASK;
+		rcu_read_lock();
+		qp = rvt_lookup_qpn(rdi, &ibp->rvp, qpn);
+
+		if (!qp) {
+			rcu_read_unlock();
+			goto next;
+		}
+
+		hfi2_process_ecn_slowpath(qp, packet, true);
+		rcu_read_unlock();
+
+		/* turn off BECN, FECN */
+		bth1 &= ~(IB_FECN_SMASK | IB_BECN_SMASK);
+		packet->ohdr->bth[1] = cpu_to_be32(bth1);
+next:
+		update_ps_mdata(&mdata, rcd);
+	}
+}
+
+static void process_rcv_qp_work(struct hfi2_packet *packet)
+{
+	struct rvt_qp *qp, *nqp;
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+
+	/*
+	 * Iterate over all QPs waiting to respond.
+	 * The list won't change since the IRQ is only run on one CPU.
+	 */
+	list_for_each_entry_safe(qp, nqp, &rcd->qp_wait_list, rspwait) {
+		list_del_init(&qp->rspwait);
+		if (qp->r_flags & RVT_R_RSP_NAK) {
+			qp->r_flags &= ~RVT_R_RSP_NAK;
+			packet->qp = qp;
+			hfi2_send_rc_ack(packet, 0);
+		}
+		if (qp->r_flags & RVT_R_RSP_SEND) {
+			unsigned long flags;
+
+			qp->r_flags &= ~RVT_R_RSP_SEND;
+			spin_lock_irqsave(&qp->s_lock, flags);
+			if (ib_rvt_state_ops[qp->state] &
+					RVT_PROCESS_OR_FLUSH_SEND)
+				hfi2_schedule_send(qp);
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+		}
+		rvt_put_qp(qp);
+	}
+}
+
+static noinline int max_packet_exceeded(struct hfi2_packet *packet, int thread)
+{
+	if (thread) {
+		if ((packet->numpkt & (MAX_PKT_RECV_THREAD - 1)) == 0)
+			/* allow defered processing */
+			process_rcv_qp_work(packet);
+		cond_resched();
+		return RCV_PKT_OK;
+	} else {
+		this_cpu_inc(*packet->rcd->dd->rcv_limit);
+		return RCV_PKT_LIMIT;
+	}
+}
+
+static inline int check_max_packet(struct hfi2_packet *packet, int thread)
+{
+	int ret = RCV_PKT_OK;
+
+	if (unlikely((packet->numpkt & (MAX_PKT_RECV - 1)) == 0))
+		ret = max_packet_exceeded(packet, thread);
+	return ret;
+}
+
+static noinline int skip_rcv_packet(struct hfi2_packet *packet, int thread)
+{
+	int ret;
+
+	packet->rcd->dd->ctx0_seq_drop++;
+	/* Set up for the next packet */
+	packet->rhqoff += packet->rsize;
+	if (packet->rhqoff >= packet->maxcnt)
+		packet->rhqoff = 0;
+
+	packet->numpkt++;
+	ret = check_max_packet(packet, thread);
+
+	packet->rhf_addr = (__le32 *)packet->rcd->rcvhdrq + packet->rhqoff +
+				     packet->rcd->rhf_offset;
+	packet->rhf = rhf_to_cpu(packet->rhf_addr);
+	cache_rhf_values(packet);
+
+	return ret;
+}
+
+static void process_rcv_packet_napi(struct hfi2_packet *packet)
+{
+	packet->etype = rhf_rcv_type(packet->rhf);
+
+	/* total length */
+	packet->tlen = rhf_pkt_len(packet->rhf); /* in bytes */
+	/* retrieve eager buffer details */
+	packet->etail = packet->egr_index;
+	packet->ebuf = get_egrbuf(packet, &packet->updegr);
+	/*
+	 * Prefetch the contents of the eager buffer.  It is
+	 * OK to send a negative length to prefetch_range().
+	 * The +2 is the size of the RHF.
+	 */
+	prefetch_range(packet->ebuf,
+		       packet->tlen - ((packet->rcd->rcvhdrqentsize -
+				       (rhf_hdrq_offset(packet->rhf)
+					+ 2)) * 4));
+
+	packet->rcd->rhf_rcv_function_map[packet->etype](packet);
+	packet->numpkt++;
+
+	/* Set up for the next packet */
+	packet->rhqoff += packet->rsize;
+	if (packet->rhqoff >= packet->maxcnt)
+		packet->rhqoff = 0;
+
+	packet->rhf_addr = (__le32 *)packet->rcd->rcvhdrq + packet->rhqoff +
+				      packet->rcd->rhf_offset;
+	packet->rhf = rhf_to_cpu(packet->rhf_addr);
+	cache_rhf_values(packet);
+}
+
+static inline int process_rcv_packet(struct hfi2_packet *packet, int thread)
+{
+	int ret;
+
+	packet->etype = rhf_rcv_type(packet->rhf);
+
+	/* total length */
+	packet->tlen = rhf_pkt_len(packet->rhf); /* in bytes */
+	/* retrieve eager buffer details */
+	packet->ebuf = NULL;
+	if (rhf_use_egr_bfr(packet->rhf)) {
+		packet->etail = packet->egr_index;
+		packet->ebuf = get_egrbuf(packet, &packet->updegr);
+		/*
+		 * Prefetch the contents of the eager buffer.  It is
+		 * OK to send a negative length to prefetch_range().
+		 * The +2 is the size of the RHF.
+		 */
+		prefetch_range(packet->ebuf,
+			       packet->tlen - ((get_hdrqentsize(packet->rcd) -
+					       (rhf_hdrq_offset(packet->rhf)
+						+ 2)) * 4));
+	}
+
+	/*
+	 * Call a type specific handler for the packet. We
+	 * should be able to trust that etype won't be beyond
+	 * the range of valid indexes. If so something is really
+	 * wrong and we can probably just let things come
+	 * crashing down. There is no need to eat another
+	 * comparison in this performance critical code.
+	 */
+	packet->rcd->rhf_rcv_function_map[packet->etype](packet);
+	packet->numpkt++;
+
+	/* Set up for the next packet */
+	packet->rhqoff += packet->rsize;
+	if (packet->rhqoff >= packet->maxcnt)
+		packet->rhqoff = 0;
+
+	ret = check_max_packet(packet, thread);
+
+	packet->rhf_addr = (__le32 *)packet->rcd->rcvhdrq + packet->rhqoff +
+				      packet->rcd->rhf_offset;
+	packet->rhf = rhf_to_cpu(packet->rhf_addr);
+	cache_rhf_values(packet);
+
+	return ret;
+}
+
+static inline void process_rcv_update(int last, struct hfi2_packet *packet)
+{
+	/*
+	 * Update head regs etc., every 16 packets, if not last pkt,
+	 * to help prevent rcvhdrq overflows, when many packets
+	 * are processed and queue is nearly full.
+	 * Don't request an interrupt for intermediate updates.
+	 */
+	if (!last && !(packet->numpkt & 0xf)) {
+		update_usrhead(packet->rcd, packet->rhqoff, packet->updegr,
+			       packet->etail, 0, 0);
+		packet->updegr = 0;
+	}
+	packet->grh = NULL;
+}
+
+static inline void finish_packet(struct hfi2_packet *packet)
+{
+	/*
+	 * Nothing we need to free for the packet.
+	 *
+	 * The only thing we need to do is a final update and call for an
+	 * interrupt
+	 */
+	update_usrhead(packet->rcd, hfi2_rcd_head(packet->rcd), packet->updegr,
+		       packet->etail, rcv_intr_dynamic, packet->numpkt);
+}
+
+/*
+ * handle_receive_interrupt_napi_fp - receive a packet
+ * @rcd: the context
+ * @budget: polling budget
+ *
+ * Called from interrupt handler for receive interrupt.
+ * This is the fast path interrupt handler
+ * when executing napi soft irq environment.
+ */
+int handle_receive_interrupt_napi_fp(struct hfi2_ctxtdata *rcd, int budget)
+{
+	struct hfi2_packet packet;
+
+	init_packet(rcd, &packet);
+	if (last_rcv_seq(rcd, packet.rcv_seq))
+		goto bail;
+
+	while (packet.numpkt < budget) {
+		process_rcv_packet_napi(&packet);
+		if (hfi2_seq_incr(rcd, packet.rcv_seq))
+			break;
+
+		process_rcv_update(0, &packet);
+	}
+	hfi2_set_rcd_head(rcd, packet.rhqoff);
+bail:
+	finish_packet(&packet);
+	return packet.numpkt;
+}
+
+/*
+ * Handle receive interrupts when using the no dma rtail option.
+ */
+int handle_receive_interrupt_nodma_rtail(struct hfi2_ctxtdata *rcd, int thread)
+{
+	int last = RCV_PKT_OK;
+	struct hfi2_packet packet;
+
+	init_packet(rcd, &packet);
+	if (last_rcv_seq(rcd, packet.rcv_seq)) {
+		last = RCV_PKT_DONE;
+		goto bail;
+	}
+
+	prescan_rxq(rcd, &packet);
+
+	while (last == RCV_PKT_OK) {
+		last = process_rcv_packet(&packet, thread);
+		if (hfi2_seq_incr(rcd, packet.rcv_seq))
+			last = RCV_PKT_DONE;
+		process_rcv_update(last, &packet);
+	}
+	process_rcv_qp_work(&packet);
+	hfi2_set_rcd_head(rcd, packet.rhqoff);
+bail:
+	finish_packet(&packet);
+	return last;
+}
+
+int handle_receive_interrupt_dma_rtail(struct hfi2_ctxtdata *rcd, int thread)
+{
+	u32 hdrqtail;
+	int last = RCV_PKT_OK;
+	struct hfi2_packet packet;
+
+	init_packet(rcd, &packet);
+	hdrqtail = get_rcvhdrtail(rcd);
+	if (packet.rhqoff == hdrqtail) {
+		last = RCV_PKT_DONE;
+		goto bail;
+	}
+	smp_rmb();  /* prevent speculative reads of dma'ed hdrq */
+
+	prescan_rxq(rcd, &packet);
+
+	while (last == RCV_PKT_OK) {
+		last = process_rcv_packet(&packet, thread);
+		if (packet.rhqoff == hdrqtail)
+			last = RCV_PKT_DONE;
+		process_rcv_update(last, &packet);
+	}
+	process_rcv_qp_work(&packet);
+	hfi2_set_rcd_head(rcd, packet.rhqoff);
+bail:
+	finish_packet(&packet);
+	return last;
+}
+
+static void set_all_fastpath(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	u16 i;
+
+	/*
+	 * For dynamically allocated kernel contexts (like) switch
+	 * interrupt handler only for that context. Otherwise, switch
+	 * interrupt handler for all statically allocated kernel contexts.
+	 */
+	if (is_user_context(rcd)) {
+		hfi2_rcd_get(rcd);
+		hfi2_set_fast(rcd);
+		hfi2_rcd_put(rcd);
+		return;
+	}
+
+	for (i = 0; i < ppd->num_rcv_contexts; i++) {
+		u16 ctxt = ppd->rcv_context_base + i;
+
+		rcd = hfi2_rcd_get_by_index(dd, ctxt);
+		if (rcd && !is_control_context(rcd) &&
+		    is_kernel_context(rcd))
+			hfi2_set_fast(rcd);
+		hfi2_rcd_put(rcd);
+	}
+}
+
+void set_all_slowpath(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_ctxtdata *rcd;
+	u16 i;
+
+	/* control context must always use the slow path interrupt handler */
+	for (i = 0; i < ppd->num_rcv_contexts; i++) {
+		u16 ctxt = ppd->rcv_context_base + i;
+
+		rcd = hfi2_rcd_get_by_index(dd, ctxt);
+		if (!rcd)
+			continue;
+		if (!is_control_context(rcd) && is_kernel_context(rcd))
+			rcd->do_interrupt = rcd->slow_handler;
+
+		hfi2_rcd_put(rcd);
+	}
+}
+
+static bool __set_armed_to_active(struct hfi2_packet *packet)
+{
+	u8 etype = rhf_rcv_type(packet->rhf);
+	u8 sc = SC15_PACKET;
+
+	if (etype == RHF_RCV_TYPE_IB) {
+		struct ib_header *hdr = hfi2_get_msgheader(packet->rcd,
+							   packet->rhf_addr);
+		sc = hfi2_9B_get_sc5(hdr, packet->sc4);
+	} else if (etype == RHF_RCV_TYPE_BYPASS) {
+		struct hfi2_16b_header *hdr = hfi2_get_16B_header(
+						packet->rcd,
+						packet->rhf_addr);
+		sc = hfi2_16B_get_sc(hdr);
+	}
+	if (sc != SC15_PACKET) {
+		int hwstate = driver_lstate(packet->rcd->ppd);
+		struct work_struct *lsaw =
+				&packet->rcd->ppd->linkstate_active_work;
+
+		if (hwstate != IB_PORT_ACTIVE) {
+			dd_dev_info(packet->rcd->dd,
+				    "Unexpected link state %s\n",
+				    ib_port_state_to_str(hwstate));
+			return false;
+		}
+
+		queue_work(packet->rcd->ppd->link_wq, lsaw);
+		return true;
+	}
+	return false;
+}
+
+/**
+ * set_armed_to_active  - the fast path for armed to active
+ * @packet: the packet structure
+ *
+ * Return true if packet processing needs to bail.
+ */
+static bool set_armed_to_active(struct hfi2_packet *packet)
+{
+	if (likely(packet->rcd->ppd->host_link_state != HLS_UP_ARMED))
+		return false;
+	return __set_armed_to_active(packet);
+}
+
+/*
+ * handle_receive_interrupt - receive a packet
+ * @rcd: the context
+ *
+ * Called from interrupt handler for errors or receive interrupt.
+ * This is the slow path interrupt handler.
+ */
+int handle_receive_interrupt(struct hfi2_ctxtdata *rcd, int thread)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 hdrqtail;
+	int needset, last = RCV_PKT_OK;
+	struct hfi2_packet packet;
+	int skip_pkt = 0;
+	bool is_control = is_control_context(rcd);
+
+	if (!rcd->rcvhdrq)
+		return RCV_PKT_OK;
+	/* Control context will always use the slow path interrupt handler */
+	needset = is_control ? 0 : 1;
+
+	init_packet(rcd, &packet);
+
+	if (!get_dma_rtail_setting(rcd)) {
+		if (last_rcv_seq(rcd, packet.rcv_seq)) {
+			last = RCV_PKT_DONE;
+			goto bail;
+		}
+		hdrqtail = 0;
+	} else {
+		hdrqtail = get_rcvhdrtail(rcd);
+		if (packet.rhqoff == hdrqtail) {
+			last = RCV_PKT_DONE;
+			goto bail;
+		}
+		smp_rmb();  /* prevent speculative reads of dma'ed hdrq */
+
+		/*
+		 * Control context can potentially receive an invalid
+		 * rhf. Drop such packets.
+		 */
+		if (is_control)
+			if (last_rcv_seq(rcd, packet.rcv_seq))
+				skip_pkt = 1;
+	}
+
+	prescan_rxq(rcd, &packet);
+
+	while (last == RCV_PKT_OK) {
+		if (hfi2_need_drop(dd)) {
+			/* On to the next packet */
+			packet.rhqoff += packet.rsize;
+			packet.rhf_addr = (__le32 *)rcd->rcvhdrq +
+					  packet.rhqoff +
+					  rcd->rhf_offset;
+			packet.rhf = rhf_to_cpu(packet.rhf_addr);
+			cache_rhf_values(&packet);
+
+		} else if (skip_pkt) {
+			last = skip_rcv_packet(&packet, thread);
+			skip_pkt = 0;
+		} else {
+			if (set_armed_to_active(&packet))
+				goto bail;
+			last = process_rcv_packet(&packet, thread);
+		}
+
+		if (!get_dma_rtail_setting(rcd)) {
+			if (hfi2_seq_incr(rcd, packet.rcv_seq))
+				last = RCV_PKT_DONE;
+		} else {
+			if (packet.rhqoff == hdrqtail)
+				last = RCV_PKT_DONE;
+			/*
+			 * Control context can potentially receive an invalid
+			 * rhf. Drop such packets.
+			 */
+			if (is_control) {
+				bool lseq;
+
+				lseq = hfi2_seq_incr(rcd, packet.rcv_seq);
+				if (!last && lseq)
+					skip_pkt = 1;
+			}
+		}
+
+		if (needset) {
+			needset = false;
+			set_all_fastpath(rcd);
+		}
+		process_rcv_update(last, &packet);
+	}
+
+	process_rcv_qp_work(&packet);
+	hfi2_set_rcd_head(rcd, packet.rhqoff);
+
+bail:
+	/*
+	 * Always write head at end, and setup rcv interrupt, even
+	 * if no packets were processed.
+	 */
+	finish_packet(&packet);
+	return last;
+}
+
+/*
+ * handle_receive_interrupt_napi_sp - receive a packet
+ * @rcd: the context
+ * @budget: polling budget
+ *
+ * Called from interrupt handler for errors or receive interrupt.
+ * This is the slow path interrupt handler
+ * when executing napi soft irq environment.
+ */
+int handle_receive_interrupt_napi_sp(struct hfi2_ctxtdata *rcd, int budget)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	int last = RCV_PKT_OK;
+	bool needset = true;
+	struct hfi2_packet packet;
+
+	init_packet(rcd, &packet);
+	if (last_rcv_seq(rcd, packet.rcv_seq))
+		goto bail;
+
+	while (last != RCV_PKT_DONE && packet.numpkt < budget) {
+		if (hfi2_need_drop(dd)) {
+			/* On to the next packet */
+			packet.rhqoff += packet.rsize;
+			packet.rhf_addr = (__le32 *)rcd->rcvhdrq +
+					  packet.rhqoff +
+					  rcd->rhf_offset;
+			packet.rhf = rhf_to_cpu(packet.rhf_addr);
+			cache_rhf_values(&packet);
+		} else {
+			if (set_armed_to_active(&packet))
+				goto bail;
+			process_rcv_packet_napi(&packet);
+		}
+
+		if (hfi2_seq_incr(rcd, packet.rcv_seq))
+			last = RCV_PKT_DONE;
+
+		if (needset) {
+			needset = false;
+			set_all_fastpath(rcd);
+		}
+
+		process_rcv_update(last, &packet);
+	}
+
+	hfi2_set_rcd_head(rcd, packet.rhqoff);
+
+bail:
+	/*
+	 * Always write head at end, and setup rcv interrupt, even
+	 * if no packets were processed.
+	 */
+	finish_packet(&packet);
+	return packet.numpkt;
+}
+
+/*
+ * We may discover in the interrupt that the hardware link state has
+ * changed from ARMED to ACTIVE (due to the arrival of a non-SC15 packet),
+ * and we need to update the driver's notion of the link state.  We cannot
+ * run set_link_state from interrupt context, so we queue this function on
+ * a workqueue.
+ *
+ * We delay the regular interrupt processing until after the state changes
+ * so that the link will be in the correct state by the time any application
+ * we wake up attempts to send a reply to any message it received.
+ * (Subsequent receive interrupts may possibly force the wakeup before we
+ * update the link state.)
+ *
+ * The rcd is freed in hfi2_free_ctxtdata after hfi2_postinit_cleanup invokes
+ * dd->f_cleanup(dd) to disable the interrupt handler and flush workqueues,
+ * so we're safe from use-after-free of the rcd.
+ */
+void receive_interrupt_work(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  linkstate_active_work);
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_ctxtdata *rcd;
+	u16 i;
+
+	/* Received non-SC15 packet implies neighbor_normal */
+	ppd->neighbor_normal = 1;
+	set_link_state(ppd, HLS_UP_ACTIVE);
+
+	/*
+	 * Interrupt all statically allocated kernel contexts that could
+	 * have had an interrupt during auto activation.
+	 */
+	for (i = ppd->rcv_context_base; i < ppd->first_dyn_alloc_ctxt; i++) {
+		rcd = hfi2_rcd_get_by_index(dd, i);
+		if (rcd)
+			force_recv_intr(rcd);
+		hfi2_rcd_put(rcd);
+	}
+}
+
+/*
+ * Convert a given MTU size to the on-wire MAD packet enumeration.
+ * Return -1 if the size is invalid.
+ */
+int mtu_to_enum(u32 mtu, int default_if_bad)
+{
+	switch (mtu) {
+	case     0: return OPA_MTU_0;
+	case   256: return OPA_MTU_256;
+	case   512: return OPA_MTU_512;
+	case  1024: return OPA_MTU_1024;
+	case  2048: return OPA_MTU_2048;
+	case  4096: return OPA_MTU_4096;
+	case  8192: return OPA_MTU_8192;
+	case 10240: return OPA_MTU_10240;
+	}
+	return default_if_bad;
+}
+
+u16 enum_to_mtu(int mtu)
+{
+	switch (mtu) {
+	case OPA_MTU_0:     return 0;
+	case OPA_MTU_256:   return 256;
+	case OPA_MTU_512:   return 512;
+	case OPA_MTU_1024:  return 1024;
+	case OPA_MTU_2048:  return 2048;
+	case OPA_MTU_4096:  return 4096;
+	case OPA_MTU_8192:  return 8192;
+	case OPA_MTU_10240: return 10240;
+	default: return 0xffff;
+	}
+}
+
+/*
+ * set_mtu - set the MTU
+ * @ppd: the per port data
+ *
+ * We can handle "any" incoming size, the issue here is whether we
+ * need to restrict our outgoing size.  We do not deal with what happens
+ * to programs that are already running when the size changes.
+ */
+int set_mtu(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i, drain, ret = 0, is_up = 0;
+
+	ppd->ibmtu = 0;
+	for (i = 0; i < ppd->vls_supported; i++)
+		if (ppd->ibmtu < ppd->vld[i].mtu)
+			ppd->ibmtu = ppd->vld[i].mtu;
+	ppd->ibmaxlen = ppd->ibmtu + lrh_max_header_bytes(ppd);
+
+	mutex_lock(&ppd->hls_lock);
+	if (ppd->host_link_state == HLS_UP_INIT ||
+	    ppd->host_link_state == HLS_UP_ARMED ||
+	    ppd->host_link_state == HLS_UP_ACTIVE)
+		is_up = 1;
+
+	drain = !is_ax(dd) && is_up;
+
+	if (drain)
+		/*
+		 * MTU is specified per-VL. To ensure that no packet gets
+		 * stuck (due, e.g., to the MTU for the packet's VL being
+		 * reduced), empty the per-VL FIFOs before adjusting MTU.
+		 */
+		ret = stop_drain_data_vls(ppd);
+
+	if (ret) {
+		dd_dev_err(dd, "%s: cannot stop/drain VLs - refusing to change per-VL MTUs\n",
+			   __func__);
+		goto err;
+	}
+
+	hfi2_set_ib_cfg(ppd, HFI2_IB_CFG_MTU, 0);
+
+	if (drain)
+		open_fill_data_vls(ppd); /* reopen all VLs */
+
+err:
+	mutex_unlock(&ppd->hls_lock);
+
+	return ret;
+}
+
+int hfi2_set_lid(struct hfi2_pportdata *ppd, u32 lid, u8 lmc)
+{
+	ppd->lid = lid;
+	ppd->lmc = lmc;
+	hfi2_set_ib_cfg(ppd, HFI2_IB_CFG_LIDLMC, 0);
+
+	ppd_dev_info(ppd, "got a lid: 0x%x\n", lid);
+
+	return 0;
+}
+
+/* Control LED state */
+void setextled(struct hfi2_pportdata *ppd, u32 on)
+{
+	if (on)
+		write_csr(ppd->dd, DCC_CFG_LED_CNTRL, 0x1F);
+	else
+		write_csr(ppd->dd, DCC_CFG_LED_CNTRL, 0x10);
+}
+
+void shutdown_led_override(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/*
+	 * This pairs with the memory barrier in hfi2_start_led_override to
+	 * ensure that we read the correct state of LED beaconing represented
+	 * by led_override_timer_active
+	 */
+	smp_rmb();
+	if (atomic_read(&ppd->led_override_timer_active)) {
+		timer_delete_sync(&ppd->led_override_timer);
+		atomic_set(&ppd->led_override_timer_active, 0);
+		/* Ensure the atomic_set is visible to all CPUs */
+		smp_wmb();
+	}
+
+	/* Hand control of the LED to the DC for normal operation */
+	write_csr(dd, DCC_CFG_LED_CNTRL, 0);
+}
+
+static void run_led_override(struct timer_list *t)
+{
+	struct hfi2_pportdata *ppd = from_timer(ppd, t, led_override_timer);
+	struct hfi2_devdata *dd = ppd->dd;
+	unsigned long timeout;
+	int phase_idx;
+
+	if (!(dd->flags & HFI2_INITTED))
+		return;
+
+	phase_idx = ppd->led_override_phase & 1;
+
+	setextled(ppd, phase_idx);
+
+	timeout = ppd->led_override_vals[phase_idx];
+
+	/* Set up for next phase */
+	ppd->led_override_phase = !ppd->led_override_phase;
+
+	mod_timer(&ppd->led_override_timer, jiffies + timeout);
+}
+
+/*
+ * To have the LED blink in a particular pattern, provide timeon and timeoff
+ * in milliseconds.
+ * To turn off custom blinking and return to normal operation, use
+ * shutdown_led_override()
+ */
+void hfi2_start_led_override(struct hfi2_pportdata *ppd, unsigned int timeon,
+			     unsigned int timeoff)
+{
+	if (!(ppd->dd->flags & HFI2_INITTED))
+		return;
+
+	/* Convert to jiffies for direct use in timer */
+	ppd->led_override_vals[0] = msecs_to_jiffies(timeoff);
+	ppd->led_override_vals[1] = msecs_to_jiffies(timeon);
+
+	/* Arbitrarily start from LED on phase */
+	ppd->led_override_phase = 1;
+
+	/*
+	 * If the timer has not already been started, do so. Use a "quick"
+	 * timeout so the handler will be called soon to look at our request.
+	 */
+	if (!timer_pending(&ppd->led_override_timer)) {
+		timer_setup(&ppd->led_override_timer, run_led_override, 0);
+		ppd->led_override_timer.expires = jiffies + 1;
+		add_timer(&ppd->led_override_timer);
+		atomic_set(&ppd->led_override_timer_active, 1);
+		/* Ensure the atomic_set is visible to all CPUs */
+		smp_wmb();
+	}
+}
+
+/**
+ * hfi2_reset_device - reset the chip if possible
+ * @unit: the device to reset
+ *
+ * Whether or not reset is successful, we attempt to re-initialize the chip
+ * (that is, much like a driver unload/reload).  We clear the INITTED flag
+ * so that the various entry points will fail until we reinitialize.  For
+ * now, we only allow this if no user contexts are open that use chip resources
+ */
+int hfi2_reset_device(int unit)
+{
+	int ret;
+	struct hfi2_devdata *dd = hfi2_lookup(unit);
+	struct hfi2_pportdata *ppd;
+	int pidx;
+
+	if (!dd) {
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	dd_dev_info(dd, "Reset on unit %u requested\n", unit);
+
+	if (!dd->kregbase1 || !(dd->flags & HFI2_PRESENT)) {
+		dd_dev_info(dd,
+			    "Invalid unit number %u or not initialized or not present\n",
+			    unit);
+		ret = -ENXIO;
+		goto bail;
+	}
+
+	/* If there are any user contexts, we cannot reset */
+	mutex_lock(&hfi2_mutex);
+	if (dd->rcd)
+		if (hfi2_stats.sps_ctxts) {
+			mutex_unlock(&hfi2_mutex);
+			ret = -EBUSY;
+			goto bail;
+		}
+	mutex_unlock(&hfi2_mutex);
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+
+		dd->params->shutdown_led_override(ppd);
+	}
+	if (dd->flags & HFI2_HAS_SEND_DMA)
+		sdma_exit(dd);
+
+	hfi2_reset_cpu_counters(dd);
+
+	ret = hfi2_init(dd, 1);
+
+	if (ret)
+		dd_dev_err(dd,
+			   "Reinitialize unit %u after reset failed with %d\n",
+			   unit, ret);
+	else
+		dd_dev_info(dd, "Reinitialized unit %u after resetting\n",
+			    unit);
+
+bail:
+	return ret;
+}
+
+static inline void hfi2_setup_ib_header(struct hfi2_packet *packet)
+{
+	packet->hdr = (struct hfi2_ib_message_header *)
+			hfi2_get_msgheader(packet->rcd,
+					   packet->rhf_addr);
+	packet->hlen = (u8 *)packet->rhf_addr - (u8 *)packet->hdr;
+}
+
+static int hfi2_bypass_ingress_pkt_check(struct hfi2_packet *packet)
+{
+	struct hfi2_pportdata *ppd = packet->rcd->ppd;
+
+	/* slid and dlid cannot be 0 */
+	if ((!packet->slid) || (!packet->dlid))
+		return -EINVAL;
+
+	/* Compare port lid with incoming packet dlid */
+	if ((!(hfi2_is_16B_mcast(packet->dlid))) &&
+	    (packet->dlid !=
+		opa_get_lid(be32_to_cpu(OPA_LID_PERMISSIVE), 16B))) {
+		if ((packet->dlid & ~((1 << ppd->lmc) - 1)) != ppd->lid)
+			return -EINVAL;
+	}
+
+	/* No multicast packets with SC15 */
+	if ((hfi2_is_16B_mcast(packet->dlid)) && (packet->sc == 0xF))
+		return -EINVAL;
+
+	/* Packets with permissive DLID always on SC15 */
+	if ((packet->dlid == opa_get_lid(be32_to_cpu(OPA_LID_PERMISSIVE),
+					 16B)) &&
+	    (packet->sc != 0xF))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int hfi2_setup_9B_packet(struct hfi2_packet *packet)
+{
+	struct hfi2_ibport *ibp = rcd_to_iport(packet->rcd);
+	struct ib_header *hdr;
+	u8 lnh;
+
+	hfi2_setup_ib_header(packet);
+	hdr = packet->hdr;
+
+	lnh = ib_get_lnh(hdr);
+	if (lnh == HFI2_LRH_BTH) {
+		packet->ohdr = &hdr->u.oth;
+		packet->grh = NULL;
+	} else if (lnh == HFI2_LRH_GRH) {
+		u32 vtf;
+
+		packet->ohdr = &hdr->u.l.oth;
+		packet->grh = &hdr->u.l.grh;
+		if (packet->grh->next_hdr != IB_GRH_NEXT_HDR)
+			goto drop;
+		vtf = be32_to_cpu(packet->grh->version_tclass_flow);
+		if ((vtf >> IB_GRH_VERSION_SHIFT) != IB_GRH_VERSION)
+			goto drop;
+	} else {
+		goto drop;
+	}
+
+	/* Query commonly used fields from packet header */
+	packet->payload = packet->ebuf;
+	packet->opcode = ib_bth_get_opcode(packet->ohdr);
+	packet->slid = ib_get_slid(hdr);
+	packet->dlid = ib_get_dlid(hdr);
+	if (unlikely((packet->dlid >= be16_to_cpu(IB_MULTICAST_LID_BASE)) &&
+		     (packet->dlid != be16_to_cpu(IB_LID_PERMISSIVE))))
+		packet->dlid += opa_get_mcast_base(OPA_MCAST_NR) -
+				be16_to_cpu(IB_MULTICAST_LID_BASE);
+	packet->sl = ib_get_sl(hdr);
+	packet->sc = hfi2_9B_get_sc5(hdr, packet->sc4);
+	packet->pad = ib_bth_get_pad(packet->ohdr);
+	packet->extra_byte = 0;
+	packet->pkey = ib_bth_get_pkey(packet->ohdr);
+	packet->migrated = ib_bth_is_migration(packet->ohdr);
+
+	return 0;
+drop:
+	ibp->rvp.n_pkt_drops++;
+	return -EINVAL;
+}
+
+static int hfi2_setup_bypass_packet(struct hfi2_packet *packet)
+{
+	/*
+	 * Bypass packets have a different header/payload split
+	 * compared to an IB packet.
+	 * Current split is set such that 16 bytes of the actual
+	 * header is in the header buffer and the remining is in
+	 * the eager buffer. We chose 16 since hfi2 driver only
+	 * supports 16B bypass packets and we will be able to
+	 * receive the entire LRH with such a split.
+	 */
+
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	struct hfi2_ibport *ibp = &ppd->ibport_data;
+	u8 l4;
+
+	packet->hdr = (struct hfi2_16b_header *)
+			hfi2_get_16B_header(packet->rcd,
+					    packet->rhf_addr);
+	l4 = hfi2_16B_get_l4(packet->hdr);
+	if (l4 == OPA_16B_L4_IB_LOCAL) {
+		packet->ohdr = packet->ebuf;
+		packet->grh = NULL;
+		packet->opcode = ib_bth_get_opcode(packet->ohdr);
+		packet->pad = hfi2_16B_bth_get_pad(packet->ohdr);
+		/* hdr_len_by_opcode already has an IB LRH factored in */
+		packet->hlen = hdr_len_by_opcode[packet->opcode] +
+			(LRH_16B_BYTES - LRH_9B_BYTES);
+		packet->migrated = opa_bth_is_migration(packet->ohdr);
+	} else if (l4 == OPA_16B_L4_IB_GLOBAL) {
+		u32 vtf;
+		u8 grh_len = sizeof(struct ib_grh);
+
+		packet->ohdr = packet->ebuf + grh_len;
+		packet->grh = packet->ebuf;
+		packet->opcode = ib_bth_get_opcode(packet->ohdr);
+		packet->pad = hfi2_16B_bth_get_pad(packet->ohdr);
+		/* hdr_len_by_opcode already has an IB LRH factored in */
+		packet->hlen = hdr_len_by_opcode[packet->opcode] +
+			(LRH_16B_BYTES - LRH_9B_BYTES) + grh_len;
+		packet->migrated = opa_bth_is_migration(packet->ohdr);
+
+		if (packet->grh->next_hdr != IB_GRH_NEXT_HDR)
+			goto drop;
+		vtf = be32_to_cpu(packet->grh->version_tclass_flow);
+		if ((vtf >> IB_GRH_VERSION_SHIFT) != IB_GRH_VERSION)
+			goto drop;
+	} else if (l4 == OPA_16B_L4_FM) {
+		packet->mgmt = packet->ebuf;
+		packet->ohdr = NULL;
+		packet->grh = NULL;
+		packet->opcode = IB_OPCODE_UD_SEND_ONLY;
+		packet->pad = OPA_16B_L4_FM_PAD;
+		packet->hlen = OPA_16B_L4_FM_HLEN;
+		packet->migrated = false;
+	} else {
+		goto drop;
+	}
+
+	/* Query commonly used fields from packet header */
+	packet->payload = packet->ebuf + packet->hlen - LRH_16B_BYTES;
+	packet->slid = hfi2_16B_get_slid(packet->hdr);
+	packet->dlid = hfi2_16B_get_dlid(packet->hdr);
+	if (unlikely(hfi2_is_16B_mcast(packet->dlid)))
+		packet->dlid += opa_get_mcast_base(OPA_MCAST_NR) -
+				opa_get_lid(opa_get_mcast_base(OPA_MCAST_NR),
+					    16B);
+	packet->sc = hfi2_16B_get_sc(packet->hdr);
+	packet->sl = ibp->sc_to_sl[packet->sc];
+	packet->extra_byte = SIZE_OF_LT;
+	packet->pkey = hfi2_16B_get_pkey(packet->hdr);
+
+	if (hfi2_bypass_ingress_pkt_check(packet))
+		goto drop;
+
+	return 0;
+drop:
+	hfi2_cdbg(PKT, "%s: packet dropped", __func__);
+	ibp->rvp.n_pkt_drops++;
+	return -EINVAL;
+}
+
+static void show_eflags_errs(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	u32 rte = rhe_rcv_type_err(packet);
+
+	if (rcd->dd->params->chip_type == CHIP_WFR) {
+		dd_dev_err(rcd->dd,
+			   "receive context %d: rhf 0x%016llx, errs [ %s%s%s%s%s%s%s] rte 0x%x\n",
+			   rcd->ctxt, packet->rhf,
+			   packet->rhf & RHF_K_HDR_LEN_ERR ? "k_hdr_len " : "",
+			   packet->rhf & RHF_DC_UNC_ERR ? "dc_unc " : "",
+			   packet->rhf & RHF_DC_ERR ? "dc " : "",
+			   packet->rhf & RHF_TID_ERR ? "tid " : "",
+			   packet->rhf & RHF_LEN_ERR ? "len " : "",
+			   packet->rhf & RHF_ECC_ERR ? "ecc " : "",
+			   packet->rhf & RHF_ICRC_ERR ? "icrc " : "",
+			   rte);
+	} else {
+		dd_dev_err(rcd->dd,
+			   "receive context %d: rhf 0x%016llx, errs 0x%016llx, rte 0x%x\n",
+			   rcd->ctxt, packet->rhf,
+			   packet->err_flags, rte);
+	}
+}
+
+void handle_eflags(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+
+	rcv_hdrerr(rcd, rcd->ppd, packet);
+	if (packet->has_errs)
+		show_eflags_errs(packet);
+}
+
+static void hfi2_ipoib_ib_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ibport *ibp;
+	struct net_device *netdev;
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct napi_struct *napi = rcd->napi;
+	struct sk_buff *skb;
+	struct hfi2_netdev_rxq *rxq = container_of(napi,
+			struct hfi2_netdev_rxq, napi);
+	u32 extra_bytes;
+	u32 tlen, qpnum;
+	bool do_work, do_cnp;
+
+	trace_hfi2_rcvhdr(packet);
+
+	hfi2_setup_ib_header(packet);
+
+	packet->ohdr = &((struct ib_header *)packet->hdr)->u.oth;
+	packet->grh = NULL;
+
+	if (unlikely(packet->has_errs)) {
+		handle_eflags(packet);
+		return;
+	}
+
+	qpnum = ib_bth_get_qpn(packet->ohdr);
+	netdev = hfi2_netdev_get_data(rcd->ppd, qpnum);
+	if (!netdev)
+		goto drop_no_nd;
+
+	trace_input_ibhdr(rcd->dd, packet, packet->sc4);
+	trace_ctxt_rsm_hist(rcd->ctxt);
+
+	/* handle congestion notifications */
+	do_work = hfi2_may_ecn(packet);
+	if (unlikely(do_work)) {
+		do_cnp = (packet->opcode != IB_OPCODE_CNP);
+		(void)hfi2_process_ecn_slowpath(hfi2_ipoib_priv(netdev)->qp,
+						 packet, do_cnp);
+	}
+
+	/*
+	 * We have split point after last byte of DETH
+	 * lets strip padding and CRC and ICRC.
+	 * tlen is whole packet len so we need to
+	 * subtract header size as well.
+	 */
+	tlen = packet->tlen;
+	extra_bytes = ib_bth_get_pad(packet->ohdr) + (SIZE_OF_CRC << 2) +
+			packet->hlen;
+	if (unlikely(tlen < extra_bytes))
+		goto drop;
+
+	tlen -= extra_bytes;
+
+	skb = hfi2_ipoib_prepare_skb(rxq, tlen, packet->ebuf);
+	if (unlikely(!skb))
+		goto drop;
+
+	dev_sw_netstats_rx_add(netdev, skb->len);
+
+	skb->dev = netdev;
+	skb->pkt_type = PACKET_HOST;
+	netif_receive_skb(skb);
+
+	return;
+
+drop:
+	++netdev->stats.rx_dropped;
+drop_no_nd:
+	ibp = rcd_to_iport(packet->rcd);
+	++ibp->rvp.n_pkt_drops;
+}
+
+/*
+ * The following functions are called by the interrupt handler. They are type
+ * specific handlers for each packet type.
+ */
+static void process_receive_ib(struct hfi2_packet *packet)
+{
+	if (hfi2_setup_9B_packet(packet))
+		return;
+
+	if (unlikely(hfi2_dbg_should_fault_rx(packet)))
+		return;
+
+	trace_hfi2_rcvhdr(packet);
+
+	if (unlikely(packet->has_errs)) {
+		handle_eflags(packet);
+		return;
+	}
+
+	hfi2_ib_rcv(packet);
+}
+
+static void process_receive_bypass(struct hfi2_packet *packet)
+{
+	struct hfi2_devdata *dd = packet->rcd->dd;
+
+	if (hfi2_setup_bypass_packet(packet))
+		return;
+
+	trace_hfi2_rcvhdr(packet);
+
+	if (unlikely(packet->has_errs)) {
+		handle_eflags(packet);
+		return;
+	}
+
+	if (hfi2_16B_get_l2(packet->hdr) == 0x2) {
+		hfi2_16B_rcv(packet);
+	} else {
+		dd_dev_err(dd,
+			   "Bypass packets other than 16B are not supported in normal operation. Dropping\n");
+		incr_cntr64(&dd->sw_rcv_bypass_packet_errors);
+		if (!(dd->err_info_rcvport.status_and_code &
+		      OPA_EI_STATUS_SMASK)) {
+			u64 *flits = packet->ebuf;
+
+			if (flits && !rhe_len_err(packet)) {
+				dd->err_info_rcvport.packet_flit1 = flits[0];
+				dd->err_info_rcvport.packet_flit2 =
+					packet->tlen > sizeof(flits[0]) ?
+					flits[1] : 0;
+			}
+			dd->err_info_rcvport.status_and_code |=
+				(OPA_EI_STATUS_SMASK | BAD_L2_ERR);
+		}
+	}
+}
+
+static void process_receive_error(struct hfi2_packet *packet)
+{
+	/* KHdrHCRCErr -- KDETH packet with a bad HCRC */
+	if (unlikely(
+		 hfi2_dbg_fault_suppress_err(&packet->rcd->dd->verbs_dev) &&
+		 (rhe_rcv_type_err(packet) == RHF_RCV_TYPE_ERROR ||
+		  rhe_crk_err(packet))))
+		return;
+
+	hfi2_setup_ib_header(packet);
+	handle_eflags(packet);
+
+	if (unlikely(packet->has_errs))
+		dd_dev_err(packet->rcd->dd,
+			   "Unhandled error packet received. Dropping.\n");
+}
+
+static void kdeth_process_expected(struct hfi2_packet *packet)
+{
+	hfi2_setup_9B_packet(packet);
+	if (unlikely(hfi2_dbg_should_fault_rx(packet)))
+		return;
+
+	if (unlikely(packet->has_errs)) {
+		struct hfi2_ctxtdata *rcd = packet->rcd;
+
+		if (hfi2_handle_kdeth_eflags(rcd, rcd->ppd, packet))
+			return;
+	}
+
+	hfi2_kdeth_expected_rcv(packet);
+}
+
+static void kdeth_process_eager(struct hfi2_packet *packet)
+{
+	hfi2_setup_9B_packet(packet);
+	if (unlikely(hfi2_dbg_should_fault_rx(packet)))
+		return;
+
+	trace_hfi2_rcvhdr(packet);
+	if (unlikely(packet->has_errs)) {
+		struct hfi2_ctxtdata *rcd = packet->rcd;
+
+		show_eflags_errs(packet);
+		if (hfi2_handle_kdeth_eflags(rcd, rcd->ppd, packet))
+			return;
+	}
+
+	hfi2_kdeth_eager_rcv(packet);
+}
+
+static void process_receive_invalid(struct hfi2_packet *packet)
+{
+	dd_dev_err(packet->rcd->dd, "Invalid packet type %d. Dropping\n",
+		   rhf_rcv_type(packet->rhf));
+}
+
+#define HFI2_RCVHDR_DUMP_MAX	5
+
+void seqfile_dump_rcd(struct seq_file *s, struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_packet packet;
+	struct ps_mdata mdata;
+	int i;
+
+	seq_printf(s, "Rcd %u: RcvHdr cnt %u entsize %u %s kctrl 0x%08llx rctrl 0x%08llx status 0x%08llx, head %llu tail %llu  sw head %u\n",
+		   rcd->ctxt, get_hdrq_cnt(rcd), get_hdrqentsize(rcd),
+		   get_dma_rtail_setting(rcd) ?
+		   "dma_rtail" : "nodma_rtail",
+		   read_kctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_kctxt_ctrl_reg),
+		   read_rctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_rctxt_ctrl_reg),
+		   read_ku_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_ctxt_status_reg),
+		   read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_head_reg) &
+		   RCV_HDR_HEAD_HEAD_MASK,
+		   read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_tail_reg),
+		   rcd->head);
+
+	init_packet(rcd, &packet);
+	init_ps_mdata(&mdata, &packet);
+
+	for (i = 0; i < HFI2_RCVHDR_DUMP_MAX; i++) {
+		__le32 *rhf_addr = (__le32 *)rcd->rcvhdrq + mdata.ps_head +
+					 rcd->rhf_offset;
+		struct ib_header *hdr;
+		u64 rhf = rhf_to_cpu(rhf_addr);
+		u32 etype = rhf_rcv_type(rhf), qpn;
+		u8 opcode;
+		u32 psn;
+		u8 lnh;
+
+		if (ps_done(&mdata, rhf, rcd))
+			break;
+
+		if (ps_skip(&mdata, rhf, rcd))
+			goto next;
+
+		if (etype > RHF_RCV_TYPE_IB)
+			goto next;
+
+		packet.hdr = hfi2_get_msgheader(rcd, rhf_addr);
+		hdr = packet.hdr;
+
+		lnh = be16_to_cpu(hdr->lrh[0]) & 3;
+
+		if (lnh == HFI2_LRH_BTH)
+			packet.ohdr = &hdr->u.oth;
+		else if (lnh == HFI2_LRH_GRH)
+			packet.ohdr = &hdr->u.l.oth;
+		else
+			goto next; /* just in case */
+
+		opcode = (be32_to_cpu(packet.ohdr->bth[0]) >> 24);
+		qpn = be32_to_cpu(packet.ohdr->bth[1]) & RVT_QPN_MASK;
+		psn = mask_psn(be32_to_cpu(packet.ohdr->bth[2]));
+
+		seq_printf(s, "\tEnt %u: opcode 0x%x, qpn 0x%x, psn 0x%x\n",
+			   mdata.ps_head, opcode, qpn, psn);
+next:
+		update_ps_mdata(&mdata, rcd);
+	}
+}
+
+const rhf_rcv_function_ptr normal_rhf_rcv_functions[] = {
+	[RHF_RCV_TYPE_EXPECTED] = kdeth_process_expected,
+	[RHF_RCV_TYPE_EAGER] = kdeth_process_eager,
+	[RHF_RCV_TYPE_IB] = process_receive_ib,
+	[RHF_RCV_TYPE_ERROR] = process_receive_error,
+	[RHF_RCV_TYPE_BYPASS] = process_receive_bypass,
+	[RHF_RCV_TYPE_INVALID5] = process_receive_invalid,
+	[RHF_RCV_TYPE_INVALID6] = process_receive_invalid,
+	[RHF_RCV_TYPE_INVALID7] = process_receive_invalid,
+};
+
+const rhf_rcv_function_ptr netdev_rhf_rcv_functions[] = {
+	[RHF_RCV_TYPE_EXPECTED] = process_receive_invalid,
+	[RHF_RCV_TYPE_EAGER] = process_receive_invalid,
+	[RHF_RCV_TYPE_IB] = hfi2_ipoib_ib_rcv,
+	[RHF_RCV_TYPE_ERROR] = process_receive_error,
+	[RHF_RCV_TYPE_BYPASS] = process_receive_invalid,
+	[RHF_RCV_TYPE_INVALID5] = process_receive_invalid,
+	[RHF_RCV_TYPE_INVALID6] = process_receive_invalid,
+	[RHF_RCV_TYPE_INVALID7] = process_receive_invalid,
+};
diff --git a/drivers/infiniband/hw/hfi2/efivar.c b/drivers/infiniband/hw/hfi2/efivar.c
new file mode 100644
index 000000000000..5fa9f28b99e4
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/efivar.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ */
+
+#include <linux/string.h>
+#include <linux/string_helpers.h>
+
+#include "efivar.h"
+
+/* GUID for HFI2 variables in EFI */
+#define HFI2_EFIVAR_GUID EFI_GUID(0xc50a953e, 0xa8b2, 0x42a6, \
+		0xbf, 0x89, 0xd3, 0x33, 0xa6, 0xe9, 0xe6, 0xd4)
+/* largest EFI data size we expect */
+#define EFI_DATA_SIZE 4096
+
+/*
+ * Read the named EFI variable.  Return the size of the actual data in *size
+ * and a kmalloc'ed buffer in *return_data.  The caller must free the
+ * data.  It is guaranteed that *return_data will be NULL and *size = 0
+ * if this routine fails.
+ *
+ * Return 0 on success, -errno on failure.
+ */
+static int read_efi_var(const char *name, unsigned long *size,
+			void **return_data)
+{
+	efi_status_t status;
+	efi_char16_t *uni_name;
+	efi_guid_t guid;
+	unsigned long temp_size;
+	void *temp_buffer;
+	void *data;
+	int i;
+	int ret;
+
+	/* set failure return values */
+	*size = 0;
+	*return_data = NULL;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
+		return -EOPNOTSUPP;
+
+	uni_name = kcalloc(strlen(name) + 1, sizeof(efi_char16_t), GFP_KERNEL);
+	temp_buffer = kzalloc(EFI_DATA_SIZE, GFP_KERNEL);
+
+	if (!uni_name || !temp_buffer) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	/* input: the size of the buffer */
+	temp_size = EFI_DATA_SIZE;
+
+	/* convert ASCII to unicode - it is a 1:1 mapping */
+	for (i = 0; name[i]; i++)
+		uni_name[i] = name[i];
+
+	/* need a variable for our GUID */
+	guid = HFI2_EFIVAR_GUID;
+
+	/* call into EFI runtime services */
+	status = efi.get_variable(
+			uni_name,
+			&guid,
+			NULL,
+			&temp_size,
+			temp_buffer);
+
+	/*
+	 * It would be nice to call efi_status_to_err() here, but that
+	 * is in the EFIVAR_FS code and may not be compiled in.
+	 * However, even that is insufficient since it does not cover
+	 * EFI_BUFFER_TOO_SMALL which could be an important return.
+	 * For now, just split out success or not found.
+	 */
+	ret = status == EFI_SUCCESS   ? 0 :
+	      status == EFI_NOT_FOUND ? -ENOENT :
+					-EINVAL;
+	if (ret)
+		goto fail;
+
+	/*
+	 * We have successfully read the EFI variable into our
+	 * temporary buffer.  Now allocate a correctly sized
+	 * buffer.
+	 */
+	data = kmemdup(temp_buffer, temp_size, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	*size = temp_size;
+	*return_data = data;
+
+fail:
+	kfree(uni_name);
+	kfree(temp_buffer);
+
+	return ret;
+}
+
+/*
+ * Read an HFI2 EFI variable of the form:
+ *	<PCIe address>-<kind>
+ * Return an kalloc'ed array and size of the data.
+ *
+ * Returns 0 on success, -errno on failure.
+ */
+int read_hfi2_efi_var(struct hfi2_devdata *dd, const char *kind,
+		      unsigned long *size, void **return_data)
+{
+	char prefix_name[64];
+	char name[128];
+	int result;
+
+	/* create a common prefix */
+	snprintf(prefix_name, sizeof(prefix_name), "%04x:%02x:%02x.%x",
+		 pci_domain_nr(dd->pcidev->bus),
+		 dd->pcidev->bus->number,
+		 PCI_SLOT(dd->pcidev->devfn),
+		 PCI_FUNC(dd->pcidev->devfn));
+	snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
+	result = read_efi_var(name, size, return_data);
+
+	/*
+	 * If reading the lowercase EFI variable fail, read the uppercase
+	 * variable.
+	 */
+	if (result) {
+		string_upper(prefix_name, prefix_name);
+		snprintf(name, sizeof(name), "%s-%s", prefix_name, kind);
+		result = read_efi_var(name, size, return_data);
+	}
+
+	return result;
+}
diff --git a/drivers/infiniband/hw/hfi2/firmware.c b/drivers/infiniband/hw/hfi2/firmware.c
new file mode 100644
index 000000000000..6080d5b954b0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/firmware.c
@@ -0,0 +1,2266 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2017 Intel Corporation.
+ */
+
+#include <linux/firmware.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/crc32.h>
+
+#include "hfi2.h"
+#include "trace.h"
+
+/*
+ * Make it easy to toggle firmware file name and if it gets loaded by
+ * editing the following. This may be something we do while in development
+ * but not necessarily something a user would ever need to use.
+ */
+#define DEFAULT_FW_8051_NAME_FPGA "hfi_dc8051.bin"
+#define DEFAULT_FW_8051_NAME_ASIC "hfi1_dc8051.fw"
+#define DEFAULT_FW_FABRIC_NAME "hfi1_fabric.fw"
+#define DEFAULT_FW_SBUS_NAME "hfi1_sbus.fw"
+#define DEFAULT_FW_PCIE_NAME "hfi1_pcie.fw"
+#define ALT_FW_8051_NAME_ASIC "hfi1_dc8051_d.fw"
+#define ALT_FW_FABRIC_NAME "hfi1_fabric_d.fw"
+#define ALT_FW_SBUS_NAME "hfi1_sbus_d.fw"
+#define ALT_FW_PCIE_NAME "hfi1_pcie_d.fw"
+
+MODULE_FIRMWARE(DEFAULT_FW_8051_NAME_ASIC);
+MODULE_FIRMWARE(DEFAULT_FW_FABRIC_NAME);
+MODULE_FIRMWARE(DEFAULT_FW_SBUS_NAME);
+MODULE_FIRMWARE(DEFAULT_FW_PCIE_NAME);
+
+static uint fw_8051_load = 1;
+static uint fw_fabric_serdes_load = 1;
+static uint fw_pcie_serdes_load = 1;
+static uint fw_sbus_load = 1;
+
+/* Firmware file names get set in hfi2_firmware_init() based on the above */
+static char *fw_8051_name;
+static char *fw_fabric_serdes_name;
+static char *fw_sbus_name;
+static char *fw_pcie_serdes_name;
+
+#define SBUS_MAX_POLL_COUNT 100
+#define SBUS_COUNTER(reg, name) \
+	(((reg) >> ASIC_STS_SBUS_COUNTERS_##name##_CNT_SHIFT) & \
+	 ASIC_STS_SBUS_COUNTERS_##name##_CNT_MASK)
+
+/*
+ * Firmware security header.
+ */
+struct css_header {
+	u32 module_type;
+	u32 header_len;
+	u32 header_version;
+	u32 module_id;
+	u32 module_vendor;
+	u32 date;		/* BCD yyyymmdd */
+	u32 size;		/* in DWORDs */
+	u32 key_size;		/* in DWORDs */
+	u32 modulus_size;	/* in DWORDs */
+	u32 exponent_size;	/* in DWORDs */
+	u32 reserved[22];
+};
+
+/* expected field values */
+#define CSS_MODULE_TYPE	   0x00000006
+#define CSS_HEADER_LEN	   0x000000a1
+#define CSS_HEADER_VERSION 0x00010000
+#define CSS_MODULE_VENDOR  0x00008086
+
+#define KEY_SIZE      256
+#define MU_SIZE		8
+#define EXPONENT_SIZE	4
+
+/* size of platform configuration partition */
+#define MAX_PLATFORM_CONFIG_FILE_SIZE 4096
+
+/* size of file of plaform configuration encoded in format version 4 */
+#define PLATFORM_CONFIG_FORMAT_4_FILE_SIZE 528
+
+/* the file itself */
+struct firmware_file {
+	struct css_header css_header;
+	u8 modulus[KEY_SIZE];
+	u8 exponent[EXPONENT_SIZE];
+	u8 signature[KEY_SIZE];
+	u8 firmware[];
+};
+
+struct augmented_firmware_file {
+	struct css_header css_header;
+	u8 modulus[KEY_SIZE];
+	u8 exponent[EXPONENT_SIZE];
+	u8 signature[KEY_SIZE];
+	u8 r2[KEY_SIZE];
+	u8 mu[MU_SIZE];
+	u8 firmware[];
+};
+
+/* augmented file size difference */
+#define AUGMENT_SIZE (sizeof(struct augmented_firmware_file) - \
+						sizeof(struct firmware_file))
+
+struct firmware_details {
+	/* Linux core piece */
+	const struct firmware *fw;
+
+	struct css_header *css_header;
+	u8 *firmware_ptr;		/* pointer to binary data */
+	u32 firmware_len;		/* length in bytes */
+	u8 *modulus;			/* pointer to the modulus */
+	u8 *exponent;			/* pointer to the exponent */
+	u8 *signature;			/* pointer to the signature */
+	u8 *r2;				/* pointer to r2 */
+	u8 *mu;				/* pointer to mu */
+	struct augmented_firmware_file dummy_header;
+};
+
+/*
+ * The mutex protects fw_state, fw_err, and all of the firmware_details
+ * variables.
+ */
+static DEFINE_MUTEX(fw_mutex);
+enum fw_state {
+	FW_EMPTY,
+	FW_TRY,
+	FW_FINAL,
+	FW_ERR
+};
+
+static enum fw_state fw_state = FW_EMPTY;
+static int fw_err;
+static struct firmware_details fw_8051;
+static struct firmware_details fw_fabric;
+static struct firmware_details fw_pcie;
+static struct firmware_details fw_sbus;
+
+/* flags for turn_off_spicos() */
+#define SPICO_SBUS   0x1
+#define SPICO_FABRIC 0x2
+#define ENABLE_SPICO_SMASK 0x1
+
+/* security block commands */
+#define RSA_CMD_INIT  0x1
+#define RSA_CMD_START 0x2
+
+/* security block status */
+#define RSA_STATUS_IDLE   0x0
+#define RSA_STATUS_ACTIVE 0x1
+#define RSA_STATUS_DONE   0x2
+#define RSA_STATUS_FAILED 0x3
+
+/* RSA engine timeout, in ms */
+#define RSA_ENGINE_TIMEOUT 100 /* ms */
+
+/* hardware mutex timeout, in ms */
+#define HM_TIMEOUT 10 /* ms */
+
+/* 8051 memory access timeout, in us */
+#define DC8051_ACCESS_TIMEOUT 100 /* us */
+
+/* the number of fabric SerDes on the SBus */
+#define NUM_FABRIC_SERDES 4
+
+/* ASIC_STS_SBUS_RESULT.RESULT_CODE value */
+#define SBUS_READ_COMPLETE 0x4
+
+/* SBus fabric SerDes addresses, one set per HFI */
+static const u8 fabric_serdes_addrs[2][NUM_FABRIC_SERDES] = {
+	{ 0x01, 0x02, 0x03, 0x04 },
+	{ 0x28, 0x29, 0x2a, 0x2b }
+};
+
+/* SBus PCIe SerDes addresses, one set per HFI */
+static const u8 pcie_serdes_addrs[2][NUM_PCIE_SERDES] = {
+	{ 0x08, 0x0a, 0x0c, 0x0e, 0x10, 0x12, 0x14, 0x16,
+	  0x18, 0x1a, 0x1c, 0x1e, 0x20, 0x22, 0x24, 0x26 },
+	{ 0x2f, 0x31, 0x33, 0x35, 0x37, 0x39, 0x3b, 0x3d,
+	  0x3f, 0x41, 0x43, 0x45, 0x47, 0x49, 0x4b, 0x4d }
+};
+
+/* SBus PCIe PCS addresses, one set per HFI */
+const u8 pcie_pcs_addrs[2][NUM_PCIE_SERDES] = {
+	{ 0x09, 0x0b, 0x0d, 0x0f, 0x11, 0x13, 0x15, 0x17,
+	  0x19, 0x1b, 0x1d, 0x1f, 0x21, 0x23, 0x25, 0x27 },
+	{ 0x30, 0x32, 0x34, 0x36, 0x38, 0x3a, 0x3c, 0x3e,
+	  0x40, 0x42, 0x44, 0x46, 0x48, 0x4a, 0x4c, 0x4e }
+};
+
+/* SBus fabric SerDes broadcast addresses, one per HFI */
+static const u8 fabric_serdes_broadcast[2] = { 0xe4, 0xe5 };
+static const u8 all_fabric_serdes_broadcast = 0xe1;
+
+/* SBus PCIe SerDes broadcast addresses, one per HFI */
+const u8 pcie_serdes_broadcast[2] = { 0xe2, 0xe3 };
+static const u8 all_pcie_serdes_broadcast = 0xe0;
+
+static const u32 platform_config_table_limits[PLATFORM_CONFIG_TABLE_MAX] = {
+	0,
+	SYSTEM_TABLE_MAX,
+	PORT_TABLE_MAX,
+	RX_PRESET_TABLE_MAX,
+	TX_PRESET_TABLE_MAX,
+	QSFP_ATTEN_TABLE_MAX,
+	VARIABLE_SETTINGS_TABLE_MAX
+};
+
+/* forwards */
+static void dispose_one_firmware(struct firmware_details *fdet);
+static int load_fabric_serdes_firmware(struct hfi2_devdata *dd,
+				       struct firmware_details *fdet);
+static void dump_fw_version(struct hfi2_devdata *dd);
+
+/*
+ * Read a single 64-bit value from 8051 data memory.
+ *
+ * Expects:
+ * o caller to have already set up data read, no auto increment
+ * o caller to turn off read enable when finished
+ *
+ * The address argument is a byte offset.  Bits 0:2 in the address are
+ * ignored - i.e. the hardware will always do aligned 8-byte reads as if
+ * the lower bits are zero.
+ *
+ * Return 0 on success, -ENXIO on a read error (timeout).
+ */
+static int __read_8051_data(struct hfi2_devdata *dd, u32 addr, u64 *result)
+{
+	u64 reg;
+	int count;
+
+	/* step 1: set the address, clear enable */
+	reg = (addr & DC_DC8051_CFG_RAM_ACCESS_CTRL_ADDRESS_MASK)
+			<< DC_DC8051_CFG_RAM_ACCESS_CTRL_ADDRESS_SHIFT;
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_CTRL, reg);
+	/* step 2: enable */
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_CTRL,
+		  reg | DC_DC8051_CFG_RAM_ACCESS_CTRL_READ_ENA_SMASK);
+
+	/* wait until ACCESS_COMPLETED is set */
+	count = 0;
+	while ((read_csr(dd, DC_DC8051_CFG_RAM_ACCESS_STATUS)
+		    & DC_DC8051_CFG_RAM_ACCESS_STATUS_ACCESS_COMPLETED_SMASK)
+		    == 0) {
+		count++;
+		if (count > DC8051_ACCESS_TIMEOUT) {
+			dd_dev_err(dd, "timeout reading 8051 data\n");
+			return -ENXIO;
+		}
+		ndelay(10);
+	}
+
+	/* gather the data */
+	*result = read_csr(dd, DC_DC8051_CFG_RAM_ACCESS_RD_DATA);
+
+	return 0;
+}
+
+/*
+ * Read 8051 data starting at addr, for len bytes.  Will read in 8-byte chunks.
+ * Return 0 on success, -errno on error.
+ */
+int read_8051_data(struct hfi2_devdata *dd, u32 addr, u32 len, u64 *result)
+{
+	unsigned long flags;
+	u32 done;
+	int ret = 0;
+
+	spin_lock_irqsave(&dd->dc8051_memlock, flags);
+
+	/* data read set-up, no auto-increment */
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_SETUP, 0);
+
+	for (done = 0; done < len; addr += 8, done += 8, result++) {
+		ret = __read_8051_data(dd, addr, result);
+		if (ret)
+			break;
+	}
+
+	/* turn off read enable */
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_CTRL, 0);
+
+	spin_unlock_irqrestore(&dd->dc8051_memlock, flags);
+
+	return ret;
+}
+
+/*
+ * Write data or code to the 8051 code or data RAM.
+ */
+static int write_8051(struct hfi2_devdata *dd, int code, u32 start,
+		      const u8 *data, u32 len)
+{
+	u64 reg;
+	u32 offset;
+	int aligned, count;
+
+	/* check alignment */
+	aligned = ((unsigned long)data & 0x7) == 0;
+
+	/* write set-up */
+	reg = (code ? DC_DC8051_CFG_RAM_ACCESS_SETUP_RAM_SEL_SMASK : 0ull)
+		| DC_DC8051_CFG_RAM_ACCESS_SETUP_AUTO_INCR_ADDR_SMASK;
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_SETUP, reg);
+
+	reg = ((start & DC_DC8051_CFG_RAM_ACCESS_CTRL_ADDRESS_MASK)
+			<< DC_DC8051_CFG_RAM_ACCESS_CTRL_ADDRESS_SHIFT)
+		| DC_DC8051_CFG_RAM_ACCESS_CTRL_WRITE_ENA_SMASK;
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_CTRL, reg);
+
+	/* write */
+	for (offset = 0; offset < len; offset += 8) {
+		int bytes = len - offset;
+
+		if (bytes < 8) {
+			reg = 0;
+			memcpy(&reg, &data[offset], bytes);
+		} else if (aligned) {
+			reg = *(u64 *)&data[offset];
+		} else {
+			memcpy(&reg, &data[offset], 8);
+		}
+		write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_WR_DATA, reg);
+
+		/* wait until ACCESS_COMPLETED is set */
+		count = 0;
+		while ((read_csr(dd, DC_DC8051_CFG_RAM_ACCESS_STATUS)
+		    & DC_DC8051_CFG_RAM_ACCESS_STATUS_ACCESS_COMPLETED_SMASK)
+		    == 0) {
+			count++;
+			if (count > DC8051_ACCESS_TIMEOUT) {
+				dd_dev_err(dd, "timeout writing 8051 data\n");
+				return -ENXIO;
+			}
+			udelay(1);
+		}
+	}
+
+	/* turn off write access, auto increment (also sets to data access) */
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_CTRL, 0);
+	write_csr(dd, DC_DC8051_CFG_RAM_ACCESS_SETUP, 0);
+
+	return 0;
+}
+
+/* return 0 if values match, non-zero and complain otherwise */
+static int invalid_header(struct hfi2_devdata *dd, const char *what,
+			  u32 actual, u32 expected)
+{
+	if (actual == expected)
+		return 0;
+
+	dd_dev_err(dd,
+		   "invalid firmware header field %s: expected 0x%x, actual 0x%x\n",
+		   what, expected, actual);
+	return 1;
+}
+
+/*
+ * Verify that the static fields in the CSS header match.
+ */
+static int verify_css_header(struct hfi2_devdata *dd, struct css_header *css)
+{
+	/* verify CSS header fields (most sizes are in DW, so add /4) */
+	if (invalid_header(dd, "module_type", css->module_type,
+			   CSS_MODULE_TYPE) ||
+	    invalid_header(dd, "header_len", css->header_len,
+			   (sizeof(struct firmware_file) / 4)) ||
+	    invalid_header(dd, "header_version", css->header_version,
+			   CSS_HEADER_VERSION) ||
+	    invalid_header(dd, "module_vendor", css->module_vendor,
+			   CSS_MODULE_VENDOR) ||
+	    invalid_header(dd, "key_size", css->key_size, KEY_SIZE / 4) ||
+	    invalid_header(dd, "modulus_size", css->modulus_size,
+			   KEY_SIZE / 4) ||
+	    invalid_header(dd, "exponent_size", css->exponent_size,
+			   EXPONENT_SIZE / 4)) {
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Make sure there are at least some bytes after the prefix.
+ */
+static int payload_check(struct hfi2_devdata *dd, const char *name,
+			 long file_size, long prefix_size)
+{
+	/* make sure we have some payload */
+	if (prefix_size >= file_size) {
+		dd_dev_err(dd,
+			   "firmware \"%s\", size %ld, must be larger than %ld bytes\n",
+			   name, file_size, prefix_size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Request the firmware from the system.  Extract the pieces and fill in
+ * fdet.  If successful, the caller will need to call dispose_one_firmware().
+ * Returns 0 on success, -ERRNO on error.
+ */
+static int obtain_one_firmware(struct hfi2_devdata *dd, const char *name,
+			       struct firmware_details *fdet)
+{
+	struct css_header *css;
+	int ret;
+
+	memset(fdet, 0, sizeof(*fdet));
+
+	ret = request_firmware(&fdet->fw, name, &dd->pcidev->dev);
+	if (ret) {
+		dd_dev_warn(dd, "cannot find firmware \"%s\", err %d\n",
+			    name, ret);
+		return ret;
+	}
+
+	/* verify the firmware */
+	if (fdet->fw->size < sizeof(struct css_header)) {
+		dd_dev_err(dd, "firmware \"%s\" is too small\n", name);
+		ret = -EINVAL;
+		goto done;
+	}
+	css = (struct css_header *)fdet->fw->data;
+
+	hfi2_cdbg(FIRMWARE, "Firmware %s details:", name);
+	hfi2_cdbg(FIRMWARE, "file size: 0x%lx bytes", fdet->fw->size);
+	hfi2_cdbg(FIRMWARE, "CSS structure:");
+	hfi2_cdbg(FIRMWARE, "  module_type    0x%x", css->module_type);
+	hfi2_cdbg(FIRMWARE, "  header_len     0x%03x (0x%03x bytes)",
+		  css->header_len, 4 * css->header_len);
+	hfi2_cdbg(FIRMWARE, "  header_version 0x%x", css->header_version);
+	hfi2_cdbg(FIRMWARE, "  module_id      0x%x", css->module_id);
+	hfi2_cdbg(FIRMWARE, "  module_vendor  0x%x", css->module_vendor);
+	hfi2_cdbg(FIRMWARE, "  date           0x%x", css->date);
+	hfi2_cdbg(FIRMWARE, "  size           0x%03x (0x%03x bytes)",
+		  css->size, 4 * css->size);
+	hfi2_cdbg(FIRMWARE, "  key_size       0x%03x (0x%03x bytes)",
+		  css->key_size, 4 * css->key_size);
+	hfi2_cdbg(FIRMWARE, "  modulus_size   0x%03x (0x%03x bytes)",
+		  css->modulus_size, 4 * css->modulus_size);
+	hfi2_cdbg(FIRMWARE, "  exponent_size  0x%03x (0x%03x bytes)",
+		  css->exponent_size, 4 * css->exponent_size);
+	hfi2_cdbg(FIRMWARE, "firmware size: 0x%lx bytes",
+		  fdet->fw->size - sizeof(struct firmware_file));
+
+	/*
+	 * If the file does not have a valid CSS header, fail.
+	 * Otherwise, check the CSS size field for an expected size.
+	 * The augmented file has r2 and mu inserted after the header
+	 * was generated, so there will be a known difference between
+	 * the CSS header size and the actual file size.  Use this
+	 * difference to identify an augmented file.
+	 *
+	 * Note: css->size is in DWORDs, multiply by 4 to get bytes.
+	 */
+	ret = verify_css_header(dd, css);
+	if (ret) {
+		dd_dev_info(dd, "Invalid CSS header for \"%s\"\n", name);
+	} else if ((css->size * 4) == fdet->fw->size) {
+		/* non-augmented firmware file */
+		struct firmware_file *ff = (struct firmware_file *)
+							fdet->fw->data;
+
+		/* make sure there are bytes in the payload */
+		ret = payload_check(dd, name, fdet->fw->size,
+				    sizeof(struct firmware_file));
+		if (ret == 0) {
+			fdet->css_header = css;
+			fdet->modulus = ff->modulus;
+			fdet->exponent = ff->exponent;
+			fdet->signature = ff->signature;
+			fdet->r2 = fdet->dummy_header.r2; /* use dummy space */
+			fdet->mu = fdet->dummy_header.mu; /* use dummy space */
+			fdet->firmware_ptr = ff->firmware;
+			fdet->firmware_len = fdet->fw->size -
+						sizeof(struct firmware_file);
+			/*
+			 * Header does not include r2 and mu - generate here.
+			 * For now, fail.
+			 */
+			dd_dev_err(dd, "driver is unable to validate firmware without r2 and mu (not in firmware file)\n");
+			ret = -EINVAL;
+		}
+	} else if ((css->size * 4) + AUGMENT_SIZE == fdet->fw->size) {
+		/* augmented firmware file */
+		struct augmented_firmware_file *aff =
+			(struct augmented_firmware_file *)fdet->fw->data;
+
+		/* make sure there are bytes in the payload */
+		ret = payload_check(dd, name, fdet->fw->size,
+				    sizeof(struct augmented_firmware_file));
+		if (ret == 0) {
+			fdet->css_header = css;
+			fdet->modulus = aff->modulus;
+			fdet->exponent = aff->exponent;
+			fdet->signature = aff->signature;
+			fdet->r2 = aff->r2;
+			fdet->mu = aff->mu;
+			fdet->firmware_ptr = aff->firmware;
+			fdet->firmware_len = fdet->fw->size -
+					sizeof(struct augmented_firmware_file);
+		}
+	} else {
+		/* css->size check failed */
+		dd_dev_err(dd,
+			   "invalid firmware header field size: expected 0x%lx or 0x%lx, actual 0x%x\n",
+			   fdet->fw->size / 4,
+			   (fdet->fw->size - AUGMENT_SIZE) / 4,
+			   css->size);
+
+		ret = -EINVAL;
+	}
+
+done:
+	/* if returning an error, clean up after ourselves */
+	if (ret)
+		dispose_one_firmware(fdet);
+	return ret;
+}
+
+static void dispose_one_firmware(struct firmware_details *fdet)
+{
+	release_firmware(fdet->fw);
+	/* erase all previous information */
+	memset(fdet, 0, sizeof(*fdet));
+}
+
+/*
+ * Obtain the 4 firmwares from the OS.  All must be obtained at once or not
+ * at all.  If called with the firmware state in FW_TRY, use alternate names.
+ * On exit, this routine will have set the firmware state to one of FW_TRY,
+ * FW_FINAL, or FW_ERR.
+ *
+ * Must be holding fw_mutex.
+ */
+static void __obtain_firmware(struct hfi2_devdata *dd)
+{
+	int err = 0;
+
+	if (fw_state == FW_FINAL)	/* nothing more to obtain */
+		return;
+	if (fw_state == FW_ERR)		/* already in error */
+		return;
+
+	/* fw_state is FW_EMPTY or FW_TRY */
+retry:
+	if (fw_state == FW_TRY) {
+		/*
+		 * We tried the original and it failed.  Move to the
+		 * alternate.
+		 */
+		dd_dev_warn(dd, "using alternate firmware names\n");
+		/*
+		 * Let others run.  Some systems, when missing firmware, does
+		 * something that holds for 30 seconds.  If we do that twice
+		 * in a row it triggers task blocked warning.
+		 */
+		cond_resched();
+		if (fw_8051_load)
+			dispose_one_firmware(&fw_8051);
+		if (fw_fabric_serdes_load)
+			dispose_one_firmware(&fw_fabric);
+		if (fw_sbus_load)
+			dispose_one_firmware(&fw_sbus);
+		if (fw_pcie_serdes_load)
+			dispose_one_firmware(&fw_pcie);
+		fw_8051_name = ALT_FW_8051_NAME_ASIC;
+		fw_fabric_serdes_name = ALT_FW_FABRIC_NAME;
+		fw_sbus_name = ALT_FW_SBUS_NAME;
+		fw_pcie_serdes_name = ALT_FW_PCIE_NAME;
+
+		/*
+		 * Add a delay before obtaining and loading debug firmware.
+		 * Authorization will fail if the delay between firmware
+		 * authorization events is shorter than 50us. Add 100us to
+		 * make a delay time safe.
+		 */
+		usleep_range(100, 120);
+	}
+
+	if (fw_sbus_load) {
+		err = obtain_one_firmware(dd, fw_sbus_name, &fw_sbus);
+		if (err)
+			goto done;
+	}
+
+	if (fw_pcie_serdes_load) {
+		err = obtain_one_firmware(dd, fw_pcie_serdes_name, &fw_pcie);
+		if (err)
+			goto done;
+	}
+
+	if (fw_fabric_serdes_load) {
+		err = obtain_one_firmware(dd, fw_fabric_serdes_name,
+					  &fw_fabric);
+		if (err)
+			goto done;
+	}
+
+	if (fw_8051_load) {
+		err = obtain_one_firmware(dd, fw_8051_name, &fw_8051);
+		if (err)
+			goto done;
+	}
+
+done:
+	if (err) {
+		/* oops, had problems obtaining a firmware */
+		if (fw_state == FW_EMPTY && dd->icode == ICODE_RTL_SILICON) {
+			/* retry with alternate (RTL only) */
+			fw_state = FW_TRY;
+			goto retry;
+		}
+		dd_dev_err(dd, "unable to obtain working firmware\n");
+		fw_state = FW_ERR;
+		fw_err = -ENOENT;
+	} else {
+		/* success */
+		if (fw_state == FW_EMPTY &&
+		    dd->icode != ICODE_FUNCTIONAL_SIMULATOR)
+			fw_state = FW_TRY;	/* may retry later */
+		else
+			fw_state = FW_FINAL;	/* cannot try again */
+	}
+}
+
+/*
+ * Called by all HFIs when loading their firmware - i.e. device probe time.
+ * The first one will do the actual firmware load.  Use a mutex to resolve
+ * any possible race condition.
+ *
+ * The call to this routine cannot be moved to driver load because the kernel
+ * call request_firmware() requires a device which is only available after
+ * the first device probe.
+ */
+static int obtain_firmware(struct hfi2_devdata *dd)
+{
+	unsigned long timeout;
+
+	mutex_lock(&fw_mutex);
+
+	/* 40s delay due to long delay on missing firmware on some systems */
+	timeout = jiffies + msecs_to_jiffies(40000);
+	while (fw_state == FW_TRY) {
+		/*
+		 * Another device is trying the firmware.  Wait until it
+		 * decides what works (or not).
+		 */
+		if (time_after(jiffies, timeout)) {
+			/* waited too long */
+			dd_dev_err(dd, "Timeout waiting for firmware try");
+			fw_state = FW_ERR;
+			fw_err = -ETIMEDOUT;
+			break;
+		}
+		mutex_unlock(&fw_mutex);
+		msleep(20);	/* arbitrary delay */
+		mutex_lock(&fw_mutex);
+	}
+	/* not in FW_TRY state */
+
+	/* set fw_state to FW_TRY, FW_FINAL, or FW_ERR, and fw_err */
+	if (fw_state == FW_EMPTY)
+		__obtain_firmware(dd);
+
+	mutex_unlock(&fw_mutex);
+	return fw_err;
+}
+
+/*
+ * Called when the driver unloads.  The timing is asymmetric with its
+ * counterpart, obtain_firmware().  If called at device remove time,
+ * then it is conceivable that another device could probe while the
+ * firmware is being disposed.  The mutexes can be moved to do that
+ * safely, but then the firmware would be requested from the OS multiple
+ * times.
+ *
+ * No mutex is needed as the driver is unloading and there cannot be any
+ * other callers.
+ */
+void dispose_firmware(void)
+{
+	dispose_one_firmware(&fw_8051);
+	dispose_one_firmware(&fw_fabric);
+	dispose_one_firmware(&fw_pcie);
+	dispose_one_firmware(&fw_sbus);
+
+	/* retain the error state, otherwise revert to empty */
+	if (fw_state != FW_ERR)
+		fw_state = FW_EMPTY;
+}
+
+/*
+ * Called with the result of a firmware download.
+ *
+ * Return 1 to retry loading the firmware, 0 to stop.
+ */
+static int retry_firmware(struct hfi2_devdata *dd, int load_result)
+{
+	int retry;
+
+	mutex_lock(&fw_mutex);
+
+	if (load_result == 0) {
+		/*
+		 * The load succeeded, so expect all others to do the same.
+		 * Do not retry again.
+		 */
+		if (fw_state == FW_TRY)
+			fw_state = FW_FINAL;
+		retry = 0;	/* do NOT retry */
+	} else if (fw_state == FW_TRY) {
+		/* load failed, obtain alternate firmware */
+		__obtain_firmware(dd);
+		retry = (fw_state == FW_FINAL);
+	} else {
+		/* else in FW_FINAL or FW_ERR, no retry in either case */
+		retry = 0;
+	}
+
+	mutex_unlock(&fw_mutex);
+	return retry;
+}
+
+/*
+ * Write a block of data to a given array CSR.  All calls will be in
+ * multiples of 8 bytes.
+ */
+static void write_rsa_data(struct hfi2_devdata *dd, int what,
+			   const u8 *data, int nbytes)
+{
+	int qw_size = nbytes / 8;
+	int i;
+
+	if (((unsigned long)data & 0x7) == 0) {
+		/* aligned */
+		u64 *ptr = (u64 *)data;
+
+		for (i = 0; i < qw_size; i++, ptr++)
+			write_csr(dd, what + (8 * i), *ptr);
+	} else {
+		/* not aligned */
+		for (i = 0; i < qw_size; i++, data += 8) {
+			u64 value;
+
+			memcpy(&value, data, 8);
+			write_csr(dd, what + (8 * i), value);
+		}
+	}
+}
+
+/*
+ * Write a block of data to a given CSR as a stream of writes.  All calls will
+ * be in multiples of 8 bytes.
+ */
+static void write_streamed_rsa_data(struct hfi2_devdata *dd, int what,
+				    const u8 *data, int nbytes)
+{
+	u64 *ptr = (u64 *)data;
+	int qw_size = nbytes / 8;
+
+	for (; qw_size > 0; qw_size--, ptr++)
+		write_csr(dd, what, *ptr);
+}
+
+/*
+ * Download the signature and start the RSA mechanism.  Wait for
+ * RSA_ENGINE_TIMEOUT before giving up.
+ */
+static int run_rsa(struct hfi2_devdata *dd, const char *who,
+		   const u8 *signature)
+{
+	unsigned long timeout;
+	u64 reg;
+	u32 status;
+	int ret = 0;
+
+	/* write the signature */
+	write_rsa_data(dd, MISC_CFG_RSA_SIGNATURE, signature, KEY_SIZE);
+
+	/* initialize RSA */
+	write_csr(dd, MISC_CFG_RSA_CMD, RSA_CMD_INIT);
+
+	/*
+	 * Make sure the engine is idle and insert a delay between the two
+	 * writes to MISC_CFG_RSA_CMD.
+	 */
+	status = (read_csr(dd, MISC_CFG_FW_CTRL)
+			   & MISC_CFG_FW_CTRL_RSA_STATUS_SMASK)
+			     >> MISC_CFG_FW_CTRL_RSA_STATUS_SHIFT;
+	if (status != RSA_STATUS_IDLE) {
+		dd_dev_err(dd, "%s security engine not idle - giving up\n",
+			   who);
+		return -EBUSY;
+	}
+
+	/* start RSA */
+	write_csr(dd, MISC_CFG_RSA_CMD, RSA_CMD_START);
+
+	/*
+	 * Look for the result.
+	 *
+	 * The RSA engine is hooked up to two MISC errors.  The driver
+	 * masks these errors as they do not respond to the standard
+	 * error "clear down" mechanism.  Look for these errors here and
+	 * clear them when possible.  This routine will exit with the
+	 * errors of the current run still set.
+	 *
+	 * MISC_FW_AUTH_FAILED_ERR
+	 *	Firmware authorization failed.  This can be cleared by
+	 *	re-initializing the RSA engine, then clearing the status bit.
+	 *	Do not re-init the RSA angine immediately after a successful
+	 *	run - this will reset the current authorization.
+	 *
+	 * MISC_KEY_MISMATCH_ERR
+	 *	Key does not match.  The only way to clear this is to load
+	 *	a matching key then clear the status bit.  If this error
+	 *	is raised, it will persist outside of this routine until a
+	 *	matching key is loaded.
+	 */
+	timeout = msecs_to_jiffies(RSA_ENGINE_TIMEOUT) + jiffies;
+	while (1) {
+		status = (read_csr(dd, MISC_CFG_FW_CTRL)
+			   & MISC_CFG_FW_CTRL_RSA_STATUS_SMASK)
+			     >> MISC_CFG_FW_CTRL_RSA_STATUS_SHIFT;
+
+		if (status == RSA_STATUS_IDLE) {
+			/* should not happen */
+			dd_dev_err(dd, "%s firmware security bad idle state\n",
+				   who);
+			ret = -EINVAL;
+			break;
+		} else if (status == RSA_STATUS_DONE) {
+			/* finished successfully */
+			break;
+		} else if (status == RSA_STATUS_FAILED) {
+			/* finished unsuccessfully */
+			ret = -EINVAL;
+			break;
+		}
+		/* else still active */
+
+		if (time_after(jiffies, timeout)) {
+			/*
+			 * Timed out while active.  We can't reset the engine
+			 * if it is stuck active, but run through the
+			 * error code to see what error bits are set.
+			 */
+			dd_dev_err(dd, "%s firmware security time out\n", who);
+			ret = -ETIMEDOUT;
+			break;
+		}
+
+		msleep(20);
+	}
+
+	/*
+	 * Arrive here on success or failure.  Clear all RSA engine
+	 * errors.  All current errors will stick - the RSA logic is keeping
+	 * error high.  All previous errors will clear - the RSA logic
+	 * is not keeping the error high.
+	 */
+	write_csr(dd, MISC_ERR_CLEAR,
+		  MISC_ERR_STATUS_MISC_FW_AUTH_FAILED_ERR_SMASK |
+		  MISC_ERR_STATUS_MISC_KEY_MISMATCH_ERR_SMASK);
+	/*
+	 * All that is left are the current errors.  Print warnings on
+	 * authorization failure details, if any.  Firmware authorization
+	 * can be retried, so these are only warnings.
+	 */
+	reg = read_csr(dd, MISC_ERR_STATUS);
+	if (ret) {
+		if (reg & MISC_ERR_STATUS_MISC_FW_AUTH_FAILED_ERR_SMASK)
+			dd_dev_warn(dd, "%s firmware authorization failed\n",
+				    who);
+		if (reg & MISC_ERR_STATUS_MISC_KEY_MISMATCH_ERR_SMASK)
+			dd_dev_warn(dd, "%s firmware key mismatch\n", who);
+	}
+
+	return ret;
+}
+
+static void load_security_variables(struct hfi2_devdata *dd,
+				    struct firmware_details *fdet)
+{
+	/* Security variables a.  Write the modulus */
+	write_rsa_data(dd, MISC_CFG_RSA_MODULUS, fdet->modulus, KEY_SIZE);
+	/* Security variables b.  Write the r2 */
+	write_rsa_data(dd, MISC_CFG_RSA_R2, fdet->r2, KEY_SIZE);
+	/* Security variables c.  Write the mu */
+	write_rsa_data(dd, MISC_CFG_RSA_MU, fdet->mu, MU_SIZE);
+	/* Security variables d.  Write the header */
+	write_streamed_rsa_data(dd, MISC_CFG_SHA_PRELOAD,
+				(u8 *)fdet->css_header,
+				sizeof(struct css_header));
+}
+
+/* return the 8051 firmware state */
+static inline u32 get_firmware_state(struct hfi2_devdata *dd)
+{
+	u64 reg = read_csr(dd, DC_DC8051_STS_CUR_STATE);
+
+	return (reg >> DC_DC8051_STS_CUR_STATE_FIRMWARE_SHIFT)
+				& DC_DC8051_STS_CUR_STATE_FIRMWARE_MASK;
+}
+
+/*
+ * Wait until the firmware is up and ready to take host requests.
+ * Return 0 on success, -ETIMEDOUT on timeout.
+ */
+int wait_fm_ready(struct hfi2_devdata *dd, u32 mstimeout)
+{
+	unsigned long timeout;
+
+	timeout = msecs_to_jiffies(mstimeout) + jiffies;
+	while (1) {
+		if (get_firmware_state(dd) == 0xa0)	/* ready */
+			return 0;
+		if (time_after(jiffies, timeout))	/* timed out */
+			return -ETIMEDOUT;
+		usleep_range(1950, 2050); /* sleep 2ms-ish */
+	}
+}
+
+/*
+ * Load the 8051 firmware.
+ */
+static int load_8051_firmware(struct hfi2_devdata *dd,
+			      struct firmware_details *fdet)
+{
+	u64 reg;
+	int ret;
+	u8 ver_major;
+	u8 ver_minor;
+	u8 ver_patch;
+
+	/*
+	 * DC Reset sequence
+	 * Load DC 8051 firmware
+	 */
+	/*
+	 * DC reset step 1: Reset DC8051
+	 */
+	reg = DC_DC8051_CFG_RST_M8051W_SMASK
+		| DC_DC8051_CFG_RST_CRAM_SMASK
+		| DC_DC8051_CFG_RST_DRAM_SMASK
+		| DC_DC8051_CFG_RST_IRAM_SMASK
+		| DC_DC8051_CFG_RST_SFR_SMASK;
+	write_csr(dd, DC_DC8051_CFG_RST, reg);
+
+	/*
+	 * DC reset step 2 (optional): Load 8051 data memory with link
+	 * configuration
+	 */
+
+	/*
+	 * DC reset step 3: Load DC8051 firmware
+	 */
+	/* release all but the core reset */
+	reg = DC_DC8051_CFG_RST_M8051W_SMASK;
+	write_csr(dd, DC_DC8051_CFG_RST, reg);
+
+	/* Firmware load step 1 */
+	load_security_variables(dd, fdet);
+
+	/*
+	 * Firmware load step 2.  Clear MISC_CFG_FW_CTRL.FW_8051_LOADED
+	 */
+	write_csr(dd, MISC_CFG_FW_CTRL, 0);
+
+	/* Firmware load steps 3-5 */
+	ret = write_8051(dd, 1/*code*/, 0, fdet->firmware_ptr,
+			 fdet->firmware_len);
+	if (ret)
+		return ret;
+
+	/*
+	 * DC reset step 4. Host starts the DC8051 firmware
+	 */
+	/*
+	 * Firmware load step 6.  Set MISC_CFG_FW_CTRL.FW_8051_LOADED
+	 */
+	write_csr(dd, MISC_CFG_FW_CTRL, MISC_CFG_FW_CTRL_FW_8051_LOADED_SMASK);
+
+	/* Firmware load steps 7-10 */
+	ret = run_rsa(dd, "8051", fdet->signature);
+	if (ret)
+		return ret;
+
+	/* clear all reset bits, releasing the 8051 */
+	write_csr(dd, DC_DC8051_CFG_RST, 0ull);
+
+	/*
+	 * DC reset step 5. Wait for firmware to be ready to accept host
+	 * requests.
+	 */
+	ret = wait_fm_ready(dd, TIMEOUT_8051_START);
+	if (ret) { /* timed out */
+		dd_dev_err(dd, "8051 start timeout, current state 0x%x\n",
+			   get_firmware_state(dd));
+		return -ETIMEDOUT;
+	}
+
+	read_misc_status(dd, &ver_major, &ver_minor, &ver_patch);
+	dd_dev_info(dd, "8051 firmware version %d.%d.%d\n",
+		    (int)ver_major, (int)ver_minor, (int)ver_patch);
+	dd->dc8051_ver = dc8051_ver(ver_major, ver_minor, ver_patch);
+	ret = write_host_interface_version(dd, HOST_INTERFACE_VERSION);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd,
+			   "Failed to set host interface version, return 0x%x\n",
+			   ret);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Write the SBus request register
+ *
+ * No need for masking - the arguments are sized exactly.
+ */
+void sbus_request(struct hfi2_devdata *dd,
+		  u8 receiver_addr, u8 data_addr, u8 command, u32 data_in)
+{
+	write_csr(dd, ASIC_CFG_SBUS_REQUEST,
+		  ((u64)data_in << ASIC_CFG_SBUS_REQUEST_DATA_IN_SHIFT) |
+		  ((u64)command << ASIC_CFG_SBUS_REQUEST_COMMAND_SHIFT) |
+		  ((u64)data_addr << ASIC_CFG_SBUS_REQUEST_DATA_ADDR_SHIFT) |
+		  ((u64)receiver_addr <<
+		   ASIC_CFG_SBUS_REQUEST_RECEIVER_ADDR_SHIFT));
+}
+
+/*
+ * Read a value from the SBus.
+ *
+ * Requires the caller to be in fast mode
+ */
+static u32 sbus_read(struct hfi2_devdata *dd, u8 receiver_addr, u8 data_addr,
+		     u32 data_in)
+{
+	u64 reg;
+	int retries;
+	int success = 0;
+	u32 result = 0;
+	u32 result_code = 0;
+
+	sbus_request(dd, receiver_addr, data_addr, READ_SBUS_RECEIVER, data_in);
+
+	for (retries = 0; retries < 100; retries++) {
+		usleep_range(1000, 1200); /* arbitrary */
+		reg = read_csr(dd, ASIC_STS_SBUS_RESULT);
+		result_code = (reg >> ASIC_STS_SBUS_RESULT_RESULT_CODE_SHIFT)
+				& ASIC_STS_SBUS_RESULT_RESULT_CODE_MASK;
+		if (result_code != SBUS_READ_COMPLETE)
+			continue;
+
+		success = 1;
+		result = (reg >> ASIC_STS_SBUS_RESULT_DATA_OUT_SHIFT)
+			   & ASIC_STS_SBUS_RESULT_DATA_OUT_MASK;
+		break;
+	}
+
+	if (!success) {
+		dd_dev_err(dd, "%s: read failed, result code 0x%x\n", __func__,
+			   result_code);
+	}
+
+	return result;
+}
+
+/*
+ * Turn off the SBus and fabric serdes spicos.
+ *
+ * + Must be called with Sbus fast mode turned on.
+ * + Must be called after fabric serdes broadcast is set up.
+ * + Must be called before the 8051 is loaded - assumes 8051 is not loaded
+ *   when using MISC_CFG_FW_CTRL.
+ */
+static void turn_off_spicos(struct hfi2_devdata *dd, int flags)
+{
+	/* only needed on A0 */
+	if (!is_ax(dd))
+		return;
+
+	dd_dev_info(dd, "Turning off spicos:%s%s\n",
+		    flags & SPICO_SBUS ? " SBus" : "",
+		    flags & SPICO_FABRIC ? " fabric" : "");
+
+	write_csr(dd, MISC_CFG_FW_CTRL, ENABLE_SPICO_SMASK);
+	/* disable SBus spico */
+	if (flags & SPICO_SBUS)
+		sbus_request(dd, SBUS_MASTER_BROADCAST, 0x01,
+			     WRITE_SBUS_RECEIVER, 0x00000040);
+
+	/* disable the fabric serdes spicos */
+	if (flags & SPICO_FABRIC)
+		sbus_request(dd, fabric_serdes_broadcast[dd->hfi2_id],
+			     0x07, WRITE_SBUS_RECEIVER, 0x00000000);
+	write_csr(dd, MISC_CFG_FW_CTRL, 0);
+}
+
+/*
+ * Reset all of the fabric serdes for this HFI in preparation to take the
+ * link to Polling.
+ *
+ * To do a reset, we need to write to the serdes registers.  Unfortunately,
+ * the fabric serdes download to the other HFI on the ASIC will have turned
+ * off the firmware validation on this HFI.  This means we can't write to the
+ * registers to reset the serdes.  Work around this by performing a complete
+ * re-download and validation of the fabric serdes firmware.  This, as a
+ * by-product, will reset the serdes.  NOTE: the re-download requires that
+ * the 8051 be in the Offline state.  I.e. not actively trying to use the
+ * serdes.  This routine is called at the point where the link is Offline and
+ * is getting ready to go to Polling.
+ */
+void fabric_serdes_reset(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	if (!fw_fabric_serdes_load)
+		return;
+
+	ret = acquire_chip_resource(dd, CR_SBUS, SBUS_TIMEOUT);
+	if (ret) {
+		dd_dev_err(dd,
+			   "Cannot acquire SBus resource to reset fabric SerDes - perhaps you should reboot\n");
+		return;
+	}
+	set_sbus_fast_mode(dd);
+
+	if (is_ax(dd)) {
+		/* A0 serdes do not work with a re-download */
+		u8 ra = fabric_serdes_broadcast[dd->hfi2_id];
+
+		/* place SerDes in reset and disable SPICO */
+		sbus_request(dd, ra, 0x07, WRITE_SBUS_RECEIVER, 0x00000011);
+		/* wait 100 refclk cycles @ 156.25MHz => 640ns */
+		udelay(1);
+		/* remove SerDes reset */
+		sbus_request(dd, ra, 0x07, WRITE_SBUS_RECEIVER, 0x00000010);
+		/* turn SPICO enable on */
+		sbus_request(dd, ra, 0x07, WRITE_SBUS_RECEIVER, 0x00000002);
+	} else {
+		turn_off_spicos(dd, SPICO_FABRIC);
+		/*
+		 * No need for firmware retry - what to download has already
+		 * been decided.
+		 * No need to pay attention to the load return - the only
+		 * failure is a validation failure, which has already been
+		 * checked by the initial download.
+		 */
+		(void)load_fabric_serdes_firmware(dd, &fw_fabric);
+	}
+
+	clear_sbus_fast_mode(dd);
+	release_chip_resource(dd, CR_SBUS);
+}
+
+/* Access to the SBus in this routine should probably be serialized */
+int sbus_request_slow(struct hfi2_devdata *dd,
+		      u8 receiver_addr, u8 data_addr, u8 command, u32 data_in)
+{
+	u64 reg, count = 0;
+
+	/* make sure fast mode is clear */
+	clear_sbus_fast_mode(dd);
+
+	sbus_request(dd, receiver_addr, data_addr, command, data_in);
+	write_csr(dd, ASIC_CFG_SBUS_EXECUTE,
+		  ASIC_CFG_SBUS_EXECUTE_EXECUTE_SMASK);
+	/* Wait for both DONE and RCV_DATA_VALID to go high */
+	reg = read_csr(dd, ASIC_STS_SBUS_RESULT);
+	while (!((reg & ASIC_STS_SBUS_RESULT_DONE_SMASK) &&
+		 (reg & ASIC_STS_SBUS_RESULT_RCV_DATA_VALID_SMASK))) {
+		if (count++ >= SBUS_MAX_POLL_COUNT) {
+			u64 counts = read_csr(dd, ASIC_STS_SBUS_COUNTERS);
+			/*
+			 * If the loop has timed out, we are OK if DONE bit
+			 * is set and RCV_DATA_VALID and EXECUTE counters
+			 * are the same. If not, we cannot proceed.
+			 */
+			if ((reg & ASIC_STS_SBUS_RESULT_DONE_SMASK) &&
+			    (SBUS_COUNTER(counts, RCV_DATA_VALID) ==
+			     SBUS_COUNTER(counts, EXECUTE)))
+				break;
+			return -ETIMEDOUT;
+		}
+		udelay(1);
+		reg = read_csr(dd, ASIC_STS_SBUS_RESULT);
+	}
+	count = 0;
+	write_csr(dd, ASIC_CFG_SBUS_EXECUTE, 0);
+	/* Wait for DONE to clear after EXECUTE is cleared */
+	reg = read_csr(dd, ASIC_STS_SBUS_RESULT);
+	while (reg & ASIC_STS_SBUS_RESULT_DONE_SMASK) {
+		if (count++ >= SBUS_MAX_POLL_COUNT)
+			return -ETIME;
+		udelay(1);
+		reg = read_csr(dd, ASIC_STS_SBUS_RESULT);
+	}
+	return 0;
+}
+
+static int load_fabric_serdes_firmware(struct hfi2_devdata *dd,
+				       struct firmware_details *fdet)
+{
+	int i, err;
+	const u8 ra = fabric_serdes_broadcast[dd->hfi2_id]; /* receiver addr */
+
+	dd_dev_info(dd, "Downloading fabric firmware\n");
+
+	/* step 1: load security variables */
+	load_security_variables(dd, fdet);
+	/* step 2: place SerDes in reset and disable SPICO */
+	sbus_request(dd, ra, 0x07, WRITE_SBUS_RECEIVER, 0x00000011);
+	/* wait 100 refclk cycles @ 156.25MHz => 640ns */
+	udelay(1);
+	/* step 3:  remove SerDes reset */
+	sbus_request(dd, ra, 0x07, WRITE_SBUS_RECEIVER, 0x00000010);
+	/* step 4: assert IMEM override */
+	sbus_request(dd, ra, 0x00, WRITE_SBUS_RECEIVER, 0x40000000);
+	/* step 5: download SerDes machine code */
+	for (i = 0; i < fdet->firmware_len; i += 4) {
+		sbus_request(dd, ra, 0x0a, WRITE_SBUS_RECEIVER,
+			     *(u32 *)&fdet->firmware_ptr[i]);
+	}
+	/* step 6: IMEM override off */
+	sbus_request(dd, ra, 0x00, WRITE_SBUS_RECEIVER, 0x00000000);
+	/* step 7: turn ECC on */
+	sbus_request(dd, ra, 0x0b, WRITE_SBUS_RECEIVER, 0x000c0000);
+
+	/* steps 8-11: run the RSA engine */
+	err = run_rsa(dd, "fabric serdes", fdet->signature);
+	if (err)
+		return err;
+
+	/* step 12: turn SPICO enable on */
+	sbus_request(dd, ra, 0x07, WRITE_SBUS_RECEIVER, 0x00000002);
+	/* step 13: enable core hardware interrupts */
+	sbus_request(dd, ra, 0x08, WRITE_SBUS_RECEIVER, 0x00000000);
+
+	return 0;
+}
+
+static int load_sbus_firmware(struct hfi2_devdata *dd,
+			      struct firmware_details *fdet)
+{
+	int i, err;
+	const u8 ra = SBUS_MASTER_BROADCAST; /* receiver address */
+
+	dd_dev_info(dd, "Downloading SBus firmware\n");
+
+	/* step 1: load security variables */
+	load_security_variables(dd, fdet);
+	/* step 2: place SPICO into reset and enable off */
+	sbus_request(dd, ra, 0x01, WRITE_SBUS_RECEIVER, 0x000000c0);
+	/* step 3: remove reset, enable off, IMEM_CNTRL_EN on */
+	sbus_request(dd, ra, 0x01, WRITE_SBUS_RECEIVER, 0x00000240);
+	/* step 4: set starting IMEM address for burst download */
+	sbus_request(dd, ra, 0x03, WRITE_SBUS_RECEIVER, 0x80000000);
+	/* step 5: download the SBus Master machine code */
+	for (i = 0; i < fdet->firmware_len; i += 4) {
+		sbus_request(dd, ra, 0x14, WRITE_SBUS_RECEIVER,
+			     *(u32 *)&fdet->firmware_ptr[i]);
+	}
+	/* step 6: set IMEM_CNTL_EN off */
+	sbus_request(dd, ra, 0x01, WRITE_SBUS_RECEIVER, 0x00000040);
+	/* step 7: turn ECC on */
+	sbus_request(dd, ra, 0x16, WRITE_SBUS_RECEIVER, 0x000c0000);
+
+	/* steps 8-11: run the RSA engine */
+	err = run_rsa(dd, "SBus", fdet->signature);
+	if (err)
+		return err;
+
+	/* step 12: set SPICO_ENABLE on */
+	sbus_request(dd, ra, 0x01, WRITE_SBUS_RECEIVER, 0x00000140);
+
+	return 0;
+}
+
+static int load_pcie_serdes_firmware(struct hfi2_devdata *dd,
+				     struct firmware_details *fdet)
+{
+	int i;
+	const u8 ra = SBUS_MASTER_BROADCAST; /* receiver address */
+
+	dd_dev_info(dd, "Downloading PCIe firmware\n");
+
+	/* step 1: load security variables */
+	load_security_variables(dd, fdet);
+	/* step 2: assert single step (halts the SBus Master spico) */
+	sbus_request(dd, ra, 0x05, WRITE_SBUS_RECEIVER, 0x00000001);
+	/* step 3: enable XDMEM access */
+	sbus_request(dd, ra, 0x01, WRITE_SBUS_RECEIVER, 0x00000d40);
+	/* step 4: load firmware into SBus Master XDMEM */
+	/*
+	 * NOTE: the dmem address, write_en, and wdata are all pre-packed,
+	 * we only need to pick up the bytes and write them
+	 */
+	for (i = 0; i < fdet->firmware_len; i += 4) {
+		sbus_request(dd, ra, 0x04, WRITE_SBUS_RECEIVER,
+			     *(u32 *)&fdet->firmware_ptr[i]);
+	}
+	/* step 5: disable XDMEM access */
+	sbus_request(dd, ra, 0x01, WRITE_SBUS_RECEIVER, 0x00000140);
+	/* step 6: allow SBus Spico to run */
+	sbus_request(dd, ra, 0x05, WRITE_SBUS_RECEIVER, 0x00000000);
+
+	/*
+	 * steps 7-11: run RSA, if it succeeds, firmware is available to
+	 * be swapped
+	 */
+	return run_rsa(dd, "PCIe serdes", fdet->signature);
+}
+
+/*
+ * Set the given broadcast values on the given list of devices.
+ */
+static void set_serdes_broadcast(struct hfi2_devdata *dd, u8 bg1, u8 bg2,
+				 const u8 *addrs, int count)
+{
+	while (--count >= 0) {
+		/*
+		 * Set BROADCAST_GROUP_1 and BROADCAST_GROUP_2, leave
+		 * defaults for everything else.  Do not read-modify-write,
+		 * per instruction from the manufacturer.
+		 *
+		 * Register 0xfd:
+		 *	bits    what
+		 *	-----	---------------------------------
+		 *	  0	IGNORE_BROADCAST  (default 0)
+		 *	11:4	BROADCAST_GROUP_1 (default 0xff)
+		 *	23:16	BROADCAST_GROUP_2 (default 0xff)
+		 */
+		sbus_request(dd, addrs[count], 0xfd, WRITE_SBUS_RECEIVER,
+			     (u32)bg1 << 4 | (u32)bg2 << 16);
+	}
+}
+
+int acquire_hw_mutex(struct hfi2_devdata *dd)
+{
+	unsigned long timeout;
+	int try = 0;
+	u8 mask = 1 << dd->hfi2_id;
+	u8 user = (u8)read_csr(dd, ASIC_CFG_MUTEX);
+
+	if (user == mask) {
+		dd_dev_info(dd,
+			    "Hardware mutex already acquired, mutex mask %u\n",
+			    (u32)mask);
+		return 0;
+	}
+
+retry:
+	timeout = msecs_to_jiffies(HM_TIMEOUT) + jiffies;
+	while (1) {
+		write_csr(dd, ASIC_CFG_MUTEX, mask);
+		user = (u8)read_csr(dd, ASIC_CFG_MUTEX);
+		if (user == mask)
+			return 0; /* success */
+		if (time_after(jiffies, timeout))
+			break; /* timed out */
+		msleep(20);
+	}
+
+	/* timed out */
+	dd_dev_err(dd,
+		   "Unable to acquire hardware mutex, mutex mask %u, my mask %u (%s)\n",
+		   (u32)user, (u32)mask, (try == 0) ? "retrying" : "giving up");
+
+	if (try == 0) {
+		/* break mutex and retry */
+		write_csr(dd, ASIC_CFG_MUTEX, 0);
+		try++;
+		goto retry;
+	}
+
+	return -EBUSY;
+}
+
+void release_hw_mutex(struct hfi2_devdata *dd)
+{
+	u8 mask = 1 << dd->hfi2_id;
+	u8 user = (u8)read_csr(dd, ASIC_CFG_MUTEX);
+
+	if (user != mask)
+		dd_dev_warn(dd,
+			    "Unable to release hardware mutex, mutex mask %u, my mask %u\n",
+			    (u32)user, (u32)mask);
+	else
+		write_csr(dd, ASIC_CFG_MUTEX, 0);
+}
+
+/* return the given resource bit(s) as a mask for the given HFI */
+static inline u64 resource_mask(u32 hfi2_id, u32 resource)
+{
+	return ((u64)resource) << (hfi2_id ? CR_DYN_SHIFT : 0);
+}
+
+static void fail_mutex_acquire_message(struct hfi2_devdata *dd,
+				       const char *func)
+{
+	dd_dev_err(dd,
+		   "%s: hardware mutex stuck - suggest rebooting the machine\n",
+		   func);
+}
+
+/*
+ * Acquire access to a chip resource.
+ *
+ * Return 0 on success, -EBUSY if resource busy, -EIO if mutex acquire failed.
+ */
+static int __acquire_chip_resource(struct hfi2_devdata *dd, u32 resource)
+{
+	u64 scratch0, all_bits, my_bit;
+	int ret;
+
+	if (resource & CR_DYN_MASK) {
+		/* a dynamic resource is in use if either HFI has set the bit */
+		if (dd->pcidev->device == PCI_DEVICE_ID_INTEL0 &&
+		    (resource & (CR_I2C1 | CR_I2C2))) {
+			/* discrete devices must serialize across both chains */
+			all_bits = resource_mask(0, CR_I2C1 | CR_I2C2) |
+					resource_mask(1, CR_I2C1 | CR_I2C2);
+		} else {
+			all_bits = resource_mask(0, resource) |
+						resource_mask(1, resource);
+		}
+		my_bit = resource_mask(dd->hfi2_id, resource);
+	} else {
+		/* non-dynamic resources are not split between HFIs */
+		all_bits = resource;
+		my_bit = resource;
+	}
+
+	/* lock against other callers within the driver wanting a resource */
+	mutex_lock(&dd->asic_data->asic_resource_mutex);
+
+	ret = acquire_hw_mutex(dd);
+	if (ret) {
+		fail_mutex_acquire_message(dd, __func__);
+		ret = -EIO;
+		goto done;
+	}
+
+	scratch0 = read_csr(dd, ASIC_CFG_SCRATCH);
+	if (scratch0 & all_bits) {
+		ret = -EBUSY;
+	} else {
+		write_csr(dd, ASIC_CFG_SCRATCH, scratch0 | my_bit);
+		/* force write to be visible to other HFI on another OS */
+		(void)read_csr(dd, ASIC_CFG_SCRATCH);
+	}
+
+	release_hw_mutex(dd);
+
+done:
+	mutex_unlock(&dd->asic_data->asic_resource_mutex);
+	return ret;
+}
+
+/*
+ * Acquire access to a chip resource, wait up to mswait milliseconds for
+ * the resource to become available.
+ *
+ * Return 0 on success, -EBUSY if busy (even after wait), -EIO if mutex
+ * acquire failed, -EINVAL if there is no asic_data.
+ */
+int acquire_chip_resource(struct hfi2_devdata *dd, u32 resource, u32 mswait)
+{
+	unsigned long timeout;
+	int ret;
+
+	if (!dd->asic_data)
+		return -EINVAL;
+
+	timeout = jiffies + msecs_to_jiffies(mswait);
+	while (1) {
+		ret = __acquire_chip_resource(dd, resource);
+		if (ret != -EBUSY)
+			return ret;
+		/* resource is busy, check our timeout */
+		if (time_after_eq(jiffies, timeout))
+			return -EBUSY;
+		usleep_range(80, 120);	/* arbitrary delay */
+	}
+}
+
+/*
+ * Release access to a chip resource
+ */
+void release_chip_resource(struct hfi2_devdata *dd, u32 resource)
+{
+	u64 scratch0, bit;
+
+	if (!dd->asic_data)
+		return;
+
+	/* only dynamic resources should ever be cleared */
+	if (!(resource & CR_DYN_MASK)) {
+		dd_dev_err(dd, "%s: invalid resource 0x%x\n", __func__,
+			   resource);
+		return;
+	}
+	bit = resource_mask(dd->hfi2_id, resource);
+
+	/* lock against other callers within the driver wanting a resource */
+	mutex_lock(&dd->asic_data->asic_resource_mutex);
+
+	if (acquire_hw_mutex(dd)) {
+		fail_mutex_acquire_message(dd, __func__);
+		goto done;
+	}
+
+	scratch0 = read_csr(dd, ASIC_CFG_SCRATCH);
+	if ((scratch0 & bit) != 0) {
+		scratch0 &= ~bit;
+		write_csr(dd, ASIC_CFG_SCRATCH, scratch0);
+		/* force write to be visible to other HFI on another OS */
+		(void)read_csr(dd, ASIC_CFG_SCRATCH);
+	} else {
+		dd_dev_warn(dd, "%s: id %d, resource 0x%x: bit not set\n",
+			    __func__, dd->hfi2_id, resource);
+	}
+
+	release_hw_mutex(dd);
+
+done:
+	mutex_unlock(&dd->asic_data->asic_resource_mutex);
+}
+
+/*
+ * Return true if resource is set, false otherwise.  Print a warning
+ * if not set and a function is supplied.
+ */
+bool check_chip_resource(struct hfi2_devdata *dd, u32 resource,
+			 const char *func)
+{
+	u64 scratch0, bit;
+
+	if (resource & CR_DYN_MASK)
+		bit = resource_mask(dd->hfi2_id, resource);
+	else
+		bit = resource;
+
+	scratch0 = read_csr(dd, ASIC_CFG_SCRATCH);
+	if ((scratch0 & bit) == 0) {
+		if (func)
+			dd_dev_warn(dd,
+				    "%s: id %d, resource 0x%x, not acquired!\n",
+				    func, dd->hfi2_id, resource);
+		return false;
+	}
+	return true;
+}
+
+static void clear_chip_resources(struct hfi2_devdata *dd, const char *func)
+{
+	u64 scratch0;
+
+	if (!dd->asic_data)
+		return;
+
+	/* lock against other callers within the driver wanting a resource */
+	mutex_lock(&dd->asic_data->asic_resource_mutex);
+
+	if (acquire_hw_mutex(dd)) {
+		fail_mutex_acquire_message(dd, func);
+		goto done;
+	}
+
+	/* clear all dynamic access bits for this HFI */
+	scratch0 = read_csr(dd, ASIC_CFG_SCRATCH);
+	scratch0 &= ~resource_mask(dd->hfi2_id, CR_DYN_MASK);
+	write_csr(dd, ASIC_CFG_SCRATCH, scratch0);
+	/* force write to be visible to other HFI on another OS */
+	(void)read_csr(dd, ASIC_CFG_SCRATCH);
+
+	release_hw_mutex(dd);
+
+done:
+	mutex_unlock(&dd->asic_data->asic_resource_mutex);
+}
+
+void init_chip_resources(struct hfi2_devdata *dd)
+{
+	/* clear any holds left by us */
+	clear_chip_resources(dd, __func__);
+}
+
+void finish_chip_resources(struct hfi2_devdata *dd)
+{
+	/* clear any holds left by us */
+	clear_chip_resources(dd, __func__);
+}
+
+void set_sbus_fast_mode(struct hfi2_devdata *dd)
+{
+	write_csr(dd, ASIC_CFG_SBUS_EXECUTE,
+		  ASIC_CFG_SBUS_EXECUTE_FAST_MODE_SMASK);
+}
+
+void clear_sbus_fast_mode(struct hfi2_devdata *dd)
+{
+	u64 reg, count = 0;
+
+	reg = read_csr(dd, ASIC_STS_SBUS_COUNTERS);
+	while (SBUS_COUNTER(reg, EXECUTE) !=
+	       SBUS_COUNTER(reg, RCV_DATA_VALID)) {
+		if (count++ >= SBUS_MAX_POLL_COUNT)
+			break;
+		udelay(1);
+		reg = read_csr(dd, ASIC_STS_SBUS_COUNTERS);
+	}
+	write_csr(dd, ASIC_CFG_SBUS_EXECUTE, 0);
+}
+
+int load_firmware(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	if (fw_fabric_serdes_load) {
+		ret = acquire_chip_resource(dd, CR_SBUS, SBUS_TIMEOUT);
+		if (ret)
+			return ret;
+
+		set_sbus_fast_mode(dd);
+
+		set_serdes_broadcast(dd, all_fabric_serdes_broadcast,
+				     fabric_serdes_broadcast[dd->hfi2_id],
+				     fabric_serdes_addrs[dd->hfi2_id],
+				     NUM_FABRIC_SERDES);
+		turn_off_spicos(dd, SPICO_FABRIC);
+		do {
+			ret = load_fabric_serdes_firmware(dd, &fw_fabric);
+		} while (retry_firmware(dd, ret));
+
+		clear_sbus_fast_mode(dd);
+		release_chip_resource(dd, CR_SBUS);
+		if (ret)
+			return ret;
+	}
+
+	if (fw_8051_load) {
+		do {
+			ret = load_8051_firmware(dd, &fw_8051);
+		} while (retry_firmware(dd, ret));
+		if (ret)
+			return ret;
+	}
+
+	dump_fw_version(dd);
+	return 0;
+}
+
+int hfi2_firmware_init(struct hfi2_devdata *dd)
+{
+	/* only RTL can use these */
+	if (dd->icode != ICODE_RTL_SILICON) {
+		fw_fabric_serdes_load = 0;
+		fw_pcie_serdes_load = 0;
+		fw_sbus_load = 0;
+	}
+
+	/* no 8051 or QSFP on simulator */
+	if (dd->icode == ICODE_FUNCTIONAL_SIMULATOR) {
+		u8 ver_major, ver_minor, ver_patch;
+
+		read_misc_status(dd, &ver_major, &ver_minor, &ver_patch);
+		dd_dev_info(dd, "Simulated 8051 firmware version %d.%d.%d\n",
+			    (int)ver_major, (int)ver_minor, (int)ver_patch);
+		dd->dc8051_ver = dc8051_ver(ver_major, ver_minor, ver_patch);
+		fw_8051_load = 0;
+	}
+
+	if (!fw_8051_name) {
+		if (dd->icode == ICODE_RTL_SILICON)
+			fw_8051_name = DEFAULT_FW_8051_NAME_ASIC;
+		else
+			fw_8051_name = DEFAULT_FW_8051_NAME_FPGA;
+	}
+	if (!fw_fabric_serdes_name)
+		fw_fabric_serdes_name = DEFAULT_FW_FABRIC_NAME;
+	if (!fw_sbus_name)
+		fw_sbus_name = DEFAULT_FW_SBUS_NAME;
+	if (!fw_pcie_serdes_name)
+		fw_pcie_serdes_name = DEFAULT_FW_PCIE_NAME;
+
+	return obtain_firmware(dd);
+}
+
+/*
+ * This function is a helper function for parse_platform_config(...) and
+ * does not check for validity of the platform configuration cache
+ * (because we know it is invalid as we are building up the cache).
+ * As such, this should not be called from anywhere other than
+ * parse_platform_config
+ */
+static int check_meta_version(struct hfi2_devdata *dd, u32 *system_table)
+{
+	u32 meta_ver, meta_ver_meta, ver_start, ver_len, mask;
+	struct platform_config_cache *pcfgcache = &dd->pcfg_cache;
+
+	if (!system_table)
+		return -EINVAL;
+
+	meta_ver_meta =
+	*(pcfgcache->config_tables[PLATFORM_CONFIG_SYSTEM_TABLE].table_metadata
+	+ SYSTEM_TABLE_META_VERSION);
+
+	mask = ((1 << METADATA_TABLE_FIELD_START_LEN_BITS) - 1);
+	ver_start = meta_ver_meta & mask;
+
+	meta_ver_meta >>= METADATA_TABLE_FIELD_LEN_SHIFT;
+
+	mask = ((1 << METADATA_TABLE_FIELD_LEN_LEN_BITS) - 1);
+	ver_len = meta_ver_meta & mask;
+
+	ver_start /= 8;
+	meta_ver = *((u8 *)system_table + ver_start) & ((1 << ver_len) - 1);
+
+	if (meta_ver < 4) {
+		dd_dev_info(
+			dd, "%s:Please update platform config\n", __func__);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int parse_platform_config(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct platform_config_cache *pcfgcache = &dd->pcfg_cache;
+	u32 *ptr = NULL;
+	u32 header1 = 0, header2 = 0, magic_num = 0, crc = 0, file_length = 0;
+	u32 record_idx = 0, table_type = 0, table_length_dwords = 0;
+	int ret = -EINVAL; /* assume failure */
+
+	/*
+	 * For integrated devices that did not fall back to the default file,
+	 * the SI tuning information for active channels is acquired from the
+	 * scratch register bitmap, thus there is no platform config to parse.
+	 * Skip parsing in these situations.
+	 */
+	if (ppd->config_from_scratch)
+		return 0;
+
+	if (!dd->platform_config.data) {
+		dd_dev_err(dd, "%s: Missing config file\n", __func__);
+		ret = -EINVAL;
+		goto bail;
+	}
+	ptr = (u32 *)dd->platform_config.data;
+
+	magic_num = *ptr;
+	ptr++;
+	if (magic_num != PLATFORM_CONFIG_MAGIC_NUM) {
+		dd_dev_err(dd, "%s: Bad config file\n", __func__);
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	/* Field is file size in DWORDs */
+	file_length = (*ptr) * 4;
+
+	/*
+	 * Length can't be larger than partition size. Assume platform
+	 * config format version 4 is being used. Interpret the file size
+	 * field as header instead by not moving the pointer.
+	 */
+	if (file_length > MAX_PLATFORM_CONFIG_FILE_SIZE) {
+		dd_dev_info(dd,
+			    "%s:File length out of bounds, using alternative format\n",
+			    __func__);
+		file_length = PLATFORM_CONFIG_FORMAT_4_FILE_SIZE;
+	} else {
+		ptr++;
+	}
+
+	if (file_length > dd->platform_config.size) {
+		dd_dev_info(dd, "%s:File claims to be larger than read size\n",
+			    __func__);
+		ret = -EINVAL;
+		goto bail;
+	} else if (file_length < dd->platform_config.size) {
+		dd_dev_info(dd,
+			    "%s:File claims to be smaller than read size, continuing\n",
+			    __func__);
+	}
+	/* exactly equal, perfection */
+
+	/*
+	 * In both cases where we proceed, using the self-reported file length
+	 * is the safer option. In case of old format a predefined value is
+	 * being used.
+	 */
+	while (ptr < (u32 *)(dd->platform_config.data + file_length)) {
+		header1 = *ptr;
+		header2 = *(ptr + 1);
+		if (header1 != ~header2) {
+			dd_dev_err(dd, "%s: Failed validation at offset %ld\n",
+				   __func__, (ptr - (u32 *)
+					      dd->platform_config.data));
+			ret = -EINVAL;
+			goto bail;
+		}
+
+		record_idx = *ptr &
+			((1 << PLATFORM_CONFIG_HEADER_RECORD_IDX_LEN_BITS) - 1);
+
+		table_length_dwords = (*ptr >>
+				PLATFORM_CONFIG_HEADER_TABLE_LENGTH_SHIFT) &
+		      ((1 << PLATFORM_CONFIG_HEADER_TABLE_LENGTH_LEN_BITS) - 1);
+
+		table_type = (*ptr >> PLATFORM_CONFIG_HEADER_TABLE_TYPE_SHIFT) &
+			((1 << PLATFORM_CONFIG_HEADER_TABLE_TYPE_LEN_BITS) - 1);
+
+		/* Done with this set of headers */
+		ptr += 2;
+
+		if (record_idx) {
+			/* data table */
+			switch (table_type) {
+			case PLATFORM_CONFIG_SYSTEM_TABLE:
+				pcfgcache->config_tables[table_type].num_table =
+									1;
+				ret = check_meta_version(dd, ptr);
+				if (ret)
+					goto bail;
+				break;
+			case PLATFORM_CONFIG_PORT_TABLE:
+				pcfgcache->config_tables[table_type].num_table =
+									2;
+				break;
+			case PLATFORM_CONFIG_RX_PRESET_TABLE:
+			case PLATFORM_CONFIG_TX_PRESET_TABLE:
+			case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
+			case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
+				pcfgcache->config_tables[table_type].num_table =
+							table_length_dwords;
+				break;
+			default:
+				dd_dev_err(dd,
+					   "%s: Unknown data table %d, offset %ld\n",
+					   __func__, table_type,
+					   (ptr - (u32 *)
+					    dd->platform_config.data));
+				ret = -EINVAL;
+				goto bail; /* We don't trust this file now */
+			}
+			pcfgcache->config_tables[table_type].table = ptr;
+		} else {
+			/* metadata table */
+			switch (table_type) {
+			case PLATFORM_CONFIG_SYSTEM_TABLE:
+			case PLATFORM_CONFIG_PORT_TABLE:
+			case PLATFORM_CONFIG_RX_PRESET_TABLE:
+			case PLATFORM_CONFIG_TX_PRESET_TABLE:
+			case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
+			case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
+				break;
+			default:
+				dd_dev_err(dd,
+					   "%s: Unknown meta table %d, offset %ld\n",
+					   __func__, table_type,
+					   (ptr -
+					    (u32 *)dd->platform_config.data));
+				ret = -EINVAL;
+				goto bail; /* We don't trust this file now */
+			}
+			pcfgcache->config_tables[table_type].table_metadata =
+									ptr;
+		}
+
+		/* Calculate and check table crc */
+		crc = crc32_le(~(u32)0, (unsigned char const *)ptr,
+			       (table_length_dwords * 4));
+		crc ^= ~(u32)0;
+
+		/* Jump the table */
+		ptr += table_length_dwords;
+		if (crc != *ptr) {
+			dd_dev_err(dd, "%s: Failed CRC check at offset %ld\n",
+				   __func__, (ptr -
+				   (u32 *)dd->platform_config.data));
+			ret = -EINVAL;
+			goto bail;
+		}
+		/* Jump the CRC DWORD */
+		ptr++;
+	}
+
+	pcfgcache->cache_valid = 1;
+	return 0;
+bail:
+	memset(pcfgcache, 0, sizeof(struct platform_config_cache));
+	return ret;
+}
+
+static void get_integrated_platform_config_field(
+		struct hfi2_pportdata *ppd,
+		enum platform_config_table_type_encoding table_type,
+		int field_index, u32 *data)
+{
+	u8 *cache = ppd->qsfp_info.cache;
+	u32 tx_preset = 0;
+
+	switch (table_type) {
+	case PLATFORM_CONFIG_SYSTEM_TABLE:
+		if (field_index == SYSTEM_TABLE_QSFP_POWER_CLASS_MAX)
+			*data = ppd->max_power_class;
+		else if (field_index == SYSTEM_TABLE_QSFP_ATTENUATION_DEFAULT_25G)
+			*data = ppd->default_atten;
+		break;
+	case PLATFORM_CONFIG_PORT_TABLE:
+		if (field_index == PORT_TABLE_PORT_TYPE)
+			*data = ppd->port_type;
+		else if (field_index == PORT_TABLE_LOCAL_ATTEN_25G)
+			*data = ppd->local_atten;
+		else if (field_index == PORT_TABLE_REMOTE_ATTEN_25G)
+			*data = ppd->remote_atten;
+		break;
+	case PLATFORM_CONFIG_RX_PRESET_TABLE:
+		if (field_index == RX_PRESET_TABLE_QSFP_RX_CDR_APPLY)
+			*data = (ppd->rx_preset & QSFP_RX_CDR_APPLY_SMASK) >>
+				QSFP_RX_CDR_APPLY_SHIFT;
+		else if (field_index == RX_PRESET_TABLE_QSFP_RX_EMP_APPLY)
+			*data = (ppd->rx_preset & QSFP_RX_EMP_APPLY_SMASK) >>
+				QSFP_RX_EMP_APPLY_SHIFT;
+		else if (field_index == RX_PRESET_TABLE_QSFP_RX_AMP_APPLY)
+			*data = (ppd->rx_preset & QSFP_RX_AMP_APPLY_SMASK) >>
+				QSFP_RX_AMP_APPLY_SHIFT;
+		else if (field_index == RX_PRESET_TABLE_QSFP_RX_CDR)
+			*data = (ppd->rx_preset & QSFP_RX_CDR_SMASK) >>
+				QSFP_RX_CDR_SHIFT;
+		else if (field_index == RX_PRESET_TABLE_QSFP_RX_EMP)
+			*data = (ppd->rx_preset & QSFP_RX_EMP_SMASK) >>
+				QSFP_RX_EMP_SHIFT;
+		else if (field_index == RX_PRESET_TABLE_QSFP_RX_AMP)
+			*data = (ppd->rx_preset & QSFP_RX_AMP_SMASK) >>
+				QSFP_RX_AMP_SHIFT;
+		break;
+	case PLATFORM_CONFIG_TX_PRESET_TABLE:
+		if (cache[QSFP_EQ_INFO_OFFS] & 0x4)
+			tx_preset = ppd->tx_preset_eq;
+		else
+			tx_preset = ppd->tx_preset_noeq;
+		if (field_index == TX_PRESET_TABLE_PRECUR)
+			*data = (tx_preset & TX_PRECUR_SMASK) >>
+				TX_PRECUR_SHIFT;
+		else if (field_index == TX_PRESET_TABLE_ATTN)
+			*data = (tx_preset & TX_ATTN_SMASK) >>
+				TX_ATTN_SHIFT;
+		else if (field_index == TX_PRESET_TABLE_POSTCUR)
+			*data = (tx_preset & TX_POSTCUR_SMASK) >>
+				TX_POSTCUR_SHIFT;
+		else if (field_index == TX_PRESET_TABLE_QSFP_TX_CDR_APPLY)
+			*data = (tx_preset & QSFP_TX_CDR_APPLY_SMASK) >>
+				QSFP_TX_CDR_APPLY_SHIFT;
+		else if (field_index == TX_PRESET_TABLE_QSFP_TX_EQ_APPLY)
+			*data = (tx_preset & QSFP_TX_EQ_APPLY_SMASK) >>
+				QSFP_TX_EQ_APPLY_SHIFT;
+		else if (field_index == TX_PRESET_TABLE_QSFP_TX_CDR)
+			*data = (tx_preset & QSFP_TX_CDR_SMASK) >>
+				QSFP_TX_CDR_SHIFT;
+		else if (field_index == TX_PRESET_TABLE_QSFP_TX_EQ)
+			*data = (tx_preset & QSFP_TX_EQ_SMASK) >>
+				QSFP_TX_EQ_SHIFT;
+		break;
+	case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
+	case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
+	default:
+		break;
+	}
+}
+
+static int get_platform_fw_field_metadata(struct hfi2_devdata *dd, int table,
+					  int field, u32 *field_len_bits,
+					  u32 *field_start_bits)
+{
+	struct platform_config_cache *pcfgcache = &dd->pcfg_cache;
+	u32 *src_ptr = NULL;
+
+	if (!pcfgcache->cache_valid)
+		return -EINVAL;
+
+	switch (table) {
+	case PLATFORM_CONFIG_SYSTEM_TABLE:
+	case PLATFORM_CONFIG_PORT_TABLE:
+	case PLATFORM_CONFIG_RX_PRESET_TABLE:
+	case PLATFORM_CONFIG_TX_PRESET_TABLE:
+	case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
+	case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
+		if (field && field < platform_config_table_limits[table])
+			src_ptr =
+			pcfgcache->config_tables[table].table_metadata + field;
+		break;
+	default:
+		dd_dev_info(dd, "%s: Unknown table\n", __func__);
+		break;
+	}
+
+	if (!src_ptr)
+		return -EINVAL;
+
+	if (field_start_bits)
+		*field_start_bits = *src_ptr &
+		      ((1 << METADATA_TABLE_FIELD_START_LEN_BITS) - 1);
+
+	if (field_len_bits)
+		*field_len_bits = (*src_ptr >> METADATA_TABLE_FIELD_LEN_SHIFT)
+		       & ((1 << METADATA_TABLE_FIELD_LEN_LEN_BITS) - 1);
+
+	return 0;
+}
+
+/* This is the central interface to getting data out of the platform config
+ * file. It depends on parse_platform_config() having populated the
+ * platform_config_cache in hfi2_devdata, and checks the cache_valid member to
+ * validate the sanity of the cache.
+ *
+ * The non-obvious parameters:
+ * @table_index: Acts as a look up key into which instance of the tables the
+ * relevant field is fetched from.
+ *
+ * This applies to the data tables that have multiple instances. The port table
+ * is an exception to this rule as each HFI only has one port and thus the
+ * relevant table can be distinguished by hfi_id.
+ *
+ * @data: pointer to memory that will be populated with the field requested.
+ * @len: length of memory pointed by @data in bytes.
+ */
+int get_platform_config_field(struct hfi2_pportdata *ppd,
+			      enum platform_config_table_type_encoding
+			      table_type, int table_index, int field_index,
+			      u32 *data, u32 len)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int ret = 0, wlen = 0, seek = 0;
+	u32 field_len_bits = 0, field_start_bits = 0, *src_ptr = NULL;
+	struct platform_config_cache *pcfgcache = &dd->pcfg_cache;
+
+	if (data)
+		memset(data, 0, len);
+	else
+		return -EINVAL;
+
+	if (ppd->config_from_scratch) {
+		/*
+		 * Use saved configuration from ppd for integrated platforms
+		 */
+		get_integrated_platform_config_field(ppd, table_type,
+						     field_index, data);
+		return 0;
+	}
+
+	ret = get_platform_fw_field_metadata(dd, table_type, field_index,
+					     &field_len_bits,
+					     &field_start_bits);
+	if (ret)
+		return -EINVAL;
+
+	/* Convert length to bits */
+	len *= 8;
+
+	/* Our metadata function checked cache_valid and field_index for us */
+	switch (table_type) {
+	case PLATFORM_CONFIG_SYSTEM_TABLE:
+		src_ptr = pcfgcache->config_tables[table_type].table;
+
+		if (field_index != SYSTEM_TABLE_QSFP_POWER_CLASS_MAX) {
+			if (len < field_len_bits)
+				return -EINVAL;
+
+			seek = field_start_bits / 8;
+			wlen = field_len_bits / 8;
+
+			src_ptr = (u32 *)((u8 *)src_ptr + seek);
+
+			/*
+			 * We expect the field to be byte aligned and whole byte
+			 * lengths if we are here
+			 */
+			memcpy(data, src_ptr, wlen);
+			return 0;
+		}
+		break;
+	case PLATFORM_CONFIG_PORT_TABLE:
+		/* Port table is 4 DWORDS */
+		src_ptr = dd->hfi2_id ?
+			pcfgcache->config_tables[table_type].table + 4 :
+			pcfgcache->config_tables[table_type].table;
+		break;
+	case PLATFORM_CONFIG_RX_PRESET_TABLE:
+	case PLATFORM_CONFIG_TX_PRESET_TABLE:
+	case PLATFORM_CONFIG_QSFP_ATTEN_TABLE:
+	case PLATFORM_CONFIG_VARIABLE_SETTINGS_TABLE:
+		src_ptr = pcfgcache->config_tables[table_type].table;
+
+		if (table_index <
+			pcfgcache->config_tables[table_type].num_table)
+			src_ptr += table_index;
+		else
+			src_ptr = NULL;
+		break;
+	default:
+		dd_dev_info(dd, "%s: Unknown table\n", __func__);
+		break;
+	}
+
+	if (!src_ptr || len < field_len_bits)
+		return -EINVAL;
+
+	src_ptr += (field_start_bits / 32);
+	*data = (*src_ptr >> (field_start_bits % 32)) &
+			((1 << field_len_bits) - 1);
+
+	return 0;
+}
+
+/*
+ * Download the firmware needed for the Gen3 PCIe SerDes.  An update
+ * to the SBus firmware is needed before updating the PCIe firmware.
+ *
+ * Note: caller must be holding the SBus resource.
+ */
+int load_pcie_firmware(struct hfi2_devdata *dd)
+{
+	int ret = 0;
+
+	/* both firmware loads below use the SBus */
+	set_sbus_fast_mode(dd);
+
+	if (fw_sbus_load) {
+		turn_off_spicos(dd, SPICO_SBUS);
+		do {
+			ret = load_sbus_firmware(dd, &fw_sbus);
+		} while (retry_firmware(dd, ret));
+		if (ret)
+			goto done;
+	}
+
+	if (fw_pcie_serdes_load) {
+		dd_dev_info(dd, "Setting PCIe SerDes broadcast\n");
+		set_serdes_broadcast(dd, all_pcie_serdes_broadcast,
+				     pcie_serdes_broadcast[dd->hfi2_id],
+				     pcie_serdes_addrs[dd->hfi2_id],
+				     NUM_PCIE_SERDES);
+		do {
+			ret = load_pcie_serdes_firmware(dd, &fw_pcie);
+		} while (retry_firmware(dd, ret));
+		if (ret)
+			goto done;
+	}
+
+done:
+	clear_sbus_fast_mode(dd);
+
+	return ret;
+}
+
+/*
+ * Read the GUID from the hardware, store it in dd.
+ */
+void read_guid(struct hfi2_devdata *dd)
+{
+	/* Take the DC out of reset to get a valid GUID value */
+	write_csr(dd, CCE_DC_CTRL, 0);
+	(void)read_csr(dd, CCE_DC_CTRL);
+
+	dd->base_guid = read_csr(dd, DC_DC8051_CFG_LOCAL_GUID);
+}
+
+/* read and display firmware version info */
+static void dump_fw_version(struct hfi2_devdata *dd)
+{
+	u32 pcie_vers[NUM_PCIE_SERDES];
+	u32 fabric_vers[NUM_FABRIC_SERDES];
+	u32 sbus_vers;
+	int i;
+	int all_same;
+	int ret;
+	u8 rcv_addr;
+
+	/* no firmware or sbus in simulation, skip */
+	if (dd->icode == ICODE_FUNCTIONAL_SIMULATOR)
+		return;
+
+	ret = acquire_chip_resource(dd, CR_SBUS, SBUS_TIMEOUT);
+	if (ret) {
+		dd_dev_err(dd, "Unable to acquire SBus to read firmware versions\n");
+		return;
+	}
+
+	/* set fast mode */
+	set_sbus_fast_mode(dd);
+
+	/* read version for SBus Master */
+	sbus_request(dd, SBUS_MASTER_BROADCAST, 0x02, WRITE_SBUS_RECEIVER, 0);
+	sbus_request(dd, SBUS_MASTER_BROADCAST, 0x07, WRITE_SBUS_RECEIVER, 0x1);
+	/* wait for interrupt to be processed */
+	usleep_range(10000, 11000);
+	sbus_vers = sbus_read(dd, SBUS_MASTER_BROADCAST, 0x08, 0x1);
+	dd_dev_info(dd, "SBus Master firmware version 0x%08x\n", sbus_vers);
+
+	/* read version for PCIe SerDes */
+	all_same = 1;
+	pcie_vers[0] = 0;
+	for (i = 0; i < NUM_PCIE_SERDES; i++) {
+		rcv_addr = pcie_serdes_addrs[dd->hfi2_id][i];
+		sbus_request(dd, rcv_addr, 0x03, WRITE_SBUS_RECEIVER, 0);
+		/* wait for interrupt to be processed */
+		usleep_range(10000, 11000);
+		pcie_vers[i] = sbus_read(dd, rcv_addr, 0x04, 0x0);
+		if (i > 0 && pcie_vers[0] != pcie_vers[i])
+			all_same = 0;
+	}
+
+	if (all_same) {
+		dd_dev_info(dd, "PCIe SerDes firmware version 0x%x\n",
+			    pcie_vers[0]);
+	} else {
+		dd_dev_warn(dd, "PCIe SerDes do not have the same firmware version\n");
+		for (i = 0; i < NUM_PCIE_SERDES; i++) {
+			dd_dev_info(dd,
+				    "PCIe SerDes lane %d firmware version 0x%x\n",
+				    i, pcie_vers[i]);
+		}
+	}
+
+	/* read version for fabric SerDes */
+	all_same = 1;
+	fabric_vers[0] = 0;
+	for (i = 0; i < NUM_FABRIC_SERDES; i++) {
+		rcv_addr = fabric_serdes_addrs[dd->hfi2_id][i];
+		sbus_request(dd, rcv_addr, 0x03, WRITE_SBUS_RECEIVER, 0);
+		/* wait for interrupt to be processed */
+		usleep_range(10000, 11000);
+		fabric_vers[i] = sbus_read(dd, rcv_addr, 0x04, 0x0);
+		if (i > 0 && fabric_vers[0] != fabric_vers[i])
+			all_same = 0;
+	}
+
+	if (all_same) {
+		dd_dev_info(dd, "Fabric SerDes firmware version 0x%x\n",
+			    fabric_vers[0]);
+	} else {
+		dd_dev_warn(dd, "Fabric SerDes do not have the same firmware version\n");
+		for (i = 0; i < NUM_FABRIC_SERDES; i++) {
+			dd_dev_info(dd,
+				    "Fabric SerDes lane %d firmware version 0x%x\n",
+				    i, fabric_vers[i]);
+		}
+	}
+
+	clear_sbus_fast_mode(dd);
+	release_chip_resource(dd, CR_SBUS);
+}
diff --git a/drivers/infiniband/hw/hfi2/init.c b/drivers/infiniband/hw/hfi2/init.c
new file mode 100644
index 000000000000..880f076819e3
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/init.c
@@ -0,0 +1,2729 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2021-2024 Cornelis Networks.
+ */
+
+#include <linux/pci.h>
+#include <linux/netdevice.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/xarray.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/hrtimer.h>
+#include <linux/bitmap.h>
+#include <linux/numa.h>
+#include <rdma/rdma_vt.h>
+
+#include "hfi2.h"
+#include "file_ops.h"
+#include "device.h"
+#include "common.h"
+#include "trace.h"
+#include "mad.h"
+#include "sdma.h"
+#include "debugfs.h"
+#include "verbs.h"
+#include "aspm.h"
+#include "affinity.h"
+#include "exp_rcv.h"
+#include "netdev.h"
+#include "chip_jkr.h"
+#include "chip_gen.h"
+#include "pinning.h"
+#include "cport_traps.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) DRIVER_NAME ": " fmt
+
+#undef CPORT_TRAP_DEBUG	/* all MCTXT TRAP events from CPORT */
+
+/*
+ * min buffers we want to have per context, after driver
+ */
+#define HFI2_MIN_USER_CTXT_BUFCNT 7
+
+#define HFI2_MIN_EAGER_BUFFER_SIZE (4 * 1024) /* 4KB */
+#define HFI2_MAX_EAGER_BUFFER_SIZE (256 * 1024) /* 256KB */
+
+static void wfr_start_port(struct hfi2_pportdata *ppd);
+static void wfr_stop_port(struct hfi2_pportdata *ppd);
+static void destroy_workqueues(struct hfi2_devdata *dd);
+
+/* parameters for the WFR ASIC */
+static const struct chip_params wfr_params = {
+	.chip_type = CHIP_WFR,
+	.num_ports = 1,
+
+	/* BAR0 map: rcv array splits kreg1 and kreg2 */
+	.bar0_size = TXE_PIO_SEND + TXE_PIO_SIZE,
+	.kreg1_size = RCV_ARRAY,
+	.kreg2_offset = RCV_ARRAY + RCV_ARRAY_SIZE,
+	.kreg2_size = TXE_PIO_SEND - (RCV_ARRAY + RCV_ARRAY_SIZE),
+	.rcv_array_offset = RCV_ARRAY,
+	.rcv_array_size = RCV_ARRAY_SIZE,
+
+	.link_speed_supported = OPA_LINK_SPEED_25G,
+	.link_speed_active = OPA_LINK_SPEED_25G,
+	.asic_cclock_ps = ASIC_CCLOCK_PS,
+	.rsm_rule_size = RXE_NUM_RSM_INSTANCES,
+	.pkey_table_size = WFR_MAX_PKEY_VALUES,
+	.generic_boardname = "Cornelis Omni-Path Host Fabric Interface Adapter 100 Series",
+	.max_eager_entries = MAX_EAGER_ENTRIES,
+	.pio_base_bits = WFR_PIO_BASE_BITS,
+	.egress_err_info_data = &wfr_egress_err_info_data,
+	.send_ctrl_flush = 0, /* no flush flag available */
+	.port_discard_egress_errs = WFR_PORT_DISCARD_EGRESS_ERRS,
+
+	/* interrupt sources */
+	.num_int_csrs = CCE_NUM_INT_CSRS,
+	.num_int_map_csrs = CCE_NUM_INT_MAP_CSRS,
+	.is_rcvavail_start = IS_RCVAVAIL_START,
+	.is_rcvurgent_start = IS_RCVURGENT_START,
+	.is_sdmaeng_err_start = IS_SDMAENG_ERR_START,
+	.is_sdma_idle_start = IS_SDMA_IDLE_START,
+	.is_sdma_progress_start = IS_SDMA_PROGRESS_START,
+	.is_sdma_start = IS_SDMA_START,
+	.is_last_source = IS_LAST_SOURCE,
+	.is_table = is_table,
+	.gi_enable_table = wfr_gi_enable_table,
+
+	/* counters */
+	.chip_dev_cntrs = wfr_dev_cntrs,
+	.chip_dev_cntr_first = WFR_DEV_CNTR_FIRST,
+	.chip_num_dev_cntrs = WFR_NUM_DEV_CNTRS,
+	.chip_port_cntrs = wfr_port_cntrs,
+	.chip_port_cntr_first = WFR_PORT_CNTR_FIRST,
+	.chip_num_port_cntrs = WFR_NUM_PORT_CNTRS,
+
+	/* ingress port registers */
+	.rxe_iport_stride = 0,
+	.rcv_iport_ctrl_reg = RCV_CTRL,
+	.rcv_iport_status_reg = RCV_STATUS,
+	.rcv_bth_qp_reg = RCV_BTH_QP,
+	.rcv_multicast_reg = RCV_MULTICAST,
+	.rcv_bypass_reg = RCV_BYPASS,
+	.rcv_vl15_reg = RCV_VL15,
+	.rcv_err_info_reg = RCV_ERR_INFO,
+	.rcv_err_status_reg = RCV_ERR_STATUS,
+	.rcv_err_mask_reg = RCV_ERR_MASK,
+	.rcv_err_clear_reg = RCV_ERR_CLEAR,
+	.rcv_qp_map_table_reg = RCV_QP_MAP_TABLE,
+	.rcv_partition_key_reg = RCV_PARTITION_KEY,
+	.rcv_counter_array32_reg = RCV_COUNTER_ARRAY32,
+	.rcv_counter_array64_reg = RCV_COUNTER_ARRAY64,
+
+	/* ingress port receive context registers */
+	.rxe_iprc_stride = WFR_RXE_IPRC_STRIDE,
+	.rcv_jkey_ctrl_reg = RCV_KEY_CTRL,
+
+	/* RXE restricted context registers */
+	.rxe_rctxt_stride = WFR_RXE_RCTXT_STRIDE,
+	.rcv_rctxt_ctrl_reg = RCV_CTXT_CTRL,
+	.rcv_egr_ctrl_reg = RCV_EGR_CTRL,
+	.rcv_tid_ctrl_reg = RCV_TID_CTRL,
+
+	/* RXE kernel context registers */
+	.rxe_kctxt_stride = WFR_RXE_KCTXT_STRIDE,
+	.rcv_kctxt_ctrl_reg = RCV_CTXT_CTRL,
+	.rcv_hdr_addr_reg = RCV_HDR_ADDR,
+	.rcv_hdr_cnt_reg = RCV_HDR_CNT,
+	.rcv_hdr_ent_size_reg = RCV_HDR_ENT_SIZE,
+	.rcv_hdr_tail_addr_reg = RCV_HDR_TAIL_ADDR,
+	.rcv_avail_time_out_reg = RCV_AVAIL_TIME_OUT,
+	.rcv_hdr_ovfl_cnt_reg = RCV_HDR_OVFL_CNT,
+
+	/* RXE kernel/user registers */
+	.rxe_ku_stride = WFR_RXE_KCTXT_STRIDE,
+	.rcv_ctxt_status_reg = RCV_CTXT_STATUS,
+
+	/* RXE user registers */
+	.rxe_uctxt_stride = WFR_RXE_UCTXT_STRIDE,
+	.rcv_hdr_tail_reg = RCV_HDR_TAIL,
+	.rcv_hdr_head_reg = RCV_HDR_HEAD,
+	.rcv_egr_index_head_reg = RCV_EGR_INDEX_HEAD,
+	.rcv_tid_flow_table_reg = RCV_TID_FLOW_TABLE,
+
+	/* TXE kernel registers */
+	.send_contexts_reg = SEND_CONTEXTS,
+	.send_dma_engines_reg = SEND_DMA_ENGINES,
+	.send_pio_mem_size_reg = SEND_PIO_MEM_SIZE,
+	.send_dma_mem_size_reg = SEND_DMA_MEM_SIZE,
+	.send_pio_init_ctxt_reg = SEND_PIO_INIT_CTXT,
+
+	/* send context_registers */
+	.txe_sctxt_stride = WFR_TXE_SCTXT_STRIDE,
+	.send_ctxt_status_reg = SEND_CTXT_STATUS,
+	.send_ctxt_credit_ctrl_reg = SEND_CTXT_CREDIT_CTRL,
+	.send_ctxt_credit_status_reg = SEND_CTXT_CREDIT_STATUS,
+	.send_ctxt_credit_return_addr_reg = SEND_CTXT_CREDIT_RETURN_ADDR,
+	.send_ctxt_credit_force_reg = SEND_CTXT_CREDIT_FORCE,
+	.send_ctxt_err_status_reg = SEND_CTXT_ERR_STATUS,
+	.send_ctxt_err_mask_reg = SEND_CTXT_ERR_MASK,
+	.send_ctxt_err_clear_reg = SEND_CTXT_ERR_CLEAR,
+
+	/* TXE send context registers */
+	.txe_tctxt_stride = WFR_TXE_TCTXT_STRIDE,
+	.send_ctxt_ctrl_reg = SEND_CTXT_CTRL,
+
+	/* SDMA registers */
+	.txe_sdma_stride = WFR_TXE_SDMA_STRIDE,
+	.send_dma_ctrl_reg = SEND_DMA_CTRL,
+	.send_dma_status_reg = SEND_DMA_STATUS,
+	.send_dma_base_addr_reg = SEND_DMA_BASE_ADDR,
+	.send_dma_len_gen_reg = SEND_DMA_LEN_GEN,
+	.send_dma_tail_reg = SEND_DMA_TAIL,
+	.send_dma_head_reg = SEND_DMA_HEAD,
+	.send_dma_head_addr_reg = SEND_DMA_HEAD_ADDR,
+	.send_dma_priority_thld_reg = SEND_DMA_PRIORITY_THLD,
+	.send_dma_idle_cnt_reg = SEND_DMA_IDLE_CNT,
+	.send_dma_reload_cnt_reg = SEND_DMA_RELOAD_CNT,
+	.send_dma_desc_cnt_reg = SEND_DMA_DESC_CNT,
+	.send_dma_desc_fetched_cnt_reg = SEND_DMA_DESC_FETCHED_CNT,
+	.send_dma_eng_err_status_reg = SEND_DMA_ENG_ERR_STATUS,
+	.send_dma_eng_err_mask_reg = SEND_DMA_ENG_ERR_MASK,
+	.send_dma_eng_err_clear_reg = SEND_DMA_ENG_ERR_CLEAR,
+
+	/* SDMA Config registers */
+	.txe_sdmacfg_stride = WFR_TXE_SDMACFG_STRIDE,
+	.send_dma_cfg_memory_reg = SEND_DMA_MEMORY,
+
+	/* egress port registers */
+	.txe_eport_stride = 0,
+	.send_ctrl_reg = SEND_CTRL,
+	.send_high_priority_limit_reg = SEND_HIGH_PRIORITY_LIMIT,
+	.send_egress_err_status_reg = SEND_EGRESS_ERR_STATUS,
+	.send_egress_err_mask_reg = SEND_EGRESS_ERR_MASK,
+	.send_egress_err_clear_reg = SEND_EGRESS_ERR_CLEAR,
+	.send_bth_qp_reg = SEND_BTH_QP,
+	.send_static_rate_control_reg = SEND_STATIC_RATE_CONTROL,
+	.send_sc2vlt0_reg = SEND_SC2VLT0,
+	.send_sc2vlt1_reg = SEND_SC2VLT1,
+	.send_sc2vlt2_reg = SEND_SC2VLT2,
+	.send_sc2vlt3_reg = SEND_SC2VLT3,
+	.send_len_check0_reg = SEND_LEN_CHECK0,
+	.send_len_check1_reg = SEND_LEN_CHECK1,
+	.send_low_priority_list_reg = SEND_LOW_PRIORITY_LIST,
+	.send_high_priority_list_reg = SEND_HIGH_PRIORITY_LIST,
+	.send_counter_array32_reg = SEND_COUNTER_ARRAY32,
+	.send_counter_array64_reg = SEND_COUNTER_ARRAY64,
+	.send_cm_ctrl_reg = SEND_CM_CTRL,
+	.send_cm_global_credit_reg = SEND_CM_GLOBAL_CREDIT,
+	.send_cm_credit_used_status_reg = SEND_CM_CREDIT_USED_STATUS,
+	.send_cm_timer_ctrl_reg = SEND_CM_TIMER_CTRL,
+	.send_cm_local_au_table0_to3_reg = SEND_CM_LOCAL_AU_TABLE0_TO3,
+	.send_cm_local_au_table4_to7_reg = SEND_CM_LOCAL_AU_TABLE4_TO7,
+	.send_cm_remote_au_table0_to3_reg = SEND_CM_REMOTE_AU_TABLE0_TO3,
+	.send_cm_remote_au_table4_to7_reg = SEND_CM_REMOTE_AU_TABLE4_TO7,
+	.send_cm_credit_vl_reg = SEND_CM_CREDIT_VL,
+	.send_cm_credit_vl15_reg = SEND_CM_CREDIT_VL15,
+	.send_egress_err_info_reg = SEND_EGRESS_ERR_INFO,
+	.send_egress_err_source_reg = SEND_EGRESS_ERR_SOURCE,
+	.send_egress_ctxt_status_reg = SEND_EGRESS_CTXT_STATUS,
+	.send_egress_send_dma_status_reg = SEND_EGRESS_SEND_DMA_STATUS,
+
+	/* egress port send context registers */
+	.txe_epsc_stride = WFR_TXE_EPSC_STRIDE,
+	.send_ctxt_check_enable_reg = SEND_CTXT_CHECK_ENABLE,
+	.send_ctxt_check_vl_reg = SEND_CTXT_CHECK_VL,
+	.send_ctxt_check_job_key_reg = SEND_CTXT_CHECK_JOB_KEY,
+	.send_ctxt_check_partition_key_reg = SEND_CTXT_CHECK_PARTITION_KEY,
+	.send_ctxt_check_slid_reg = SEND_CTXT_CHECK_SLID,
+	.send_ctxt_check_opcode_reg = SEND_CTXT_CHECK_OPCODE,
+
+	/* SI registers */
+	.cce_msix_int_map_vec_reg = CCE_INT_MAP,
+	.send_pio_err_status_reg = SEND_PIO_ERR_STATUS,
+	.send_pio_err_mask_reg = SEND_PIO_ERR_MASK,
+	.send_pio_err_clear_reg = SEND_PIO_ERR_CLEAR,
+	.send_dma_err_status_reg = SEND_DMA_ERR_STATUS,
+	.send_dma_err_mask_reg = SEND_DMA_ERR_MASK,
+	.send_dma_err_clear_reg = SEND_DMA_ERR_CLEAR,
+	.csr_err_status_reg = SEND_ERR_STATUS,
+	.csr_err_mask_reg = SEND_ERR_MASK,
+	.csr_err_clear_reg = SEND_ERR_CLEAR,
+
+	.setextled = setextled,
+	.start_led_override = hfi2_start_led_override,
+	.shutdown_led_override = shutdown_led_override,
+	.read_guid = read_guid,
+	.early_per_chip_init = wfr_early_per_chip_init,
+	.mid_per_chip_init = wfr_mid_per_chip_init,
+	.init_other = init_other,
+	.late_per_chip_init = wfr_late_per_chip_init,
+	.start_port = wfr_start_port,
+	.stop_port = wfr_stop_port,
+	.init_tids = wfr_init_tids,
+	.put_tid = wfr_put_tid,
+	.rcv_array_wc_fill = wfr_rcv_array_wc_fill,
+	.set_port_tid_count = wfr_set_port_tid_count,
+	.set_port_max_mtu = wfr_set_port_max_mtu,
+	.update_rcv_hdr_size = wfr_update_rcv_hdr_size,
+	.check_synth_status = wfr_check_synth_status,
+	.update_synth_status = wfr_update_synth_status,
+	.create_pbc = wfr_create_pbc,
+	.set_pio_integrity = wfr_set_pio_integrity,
+	.find_used_resources = wfr_find_used_resources,
+	.read_link_quality = wfr_read_link_quality,
+	.set_rheq_addr = NULL,
+	.handle_link_bounce = wfr_handle_link_bounce,
+	.enable_rcv_context = wfr_enable_rcv_context,
+};
+
+/* parameters for the JKR ASIC */
+static const struct chip_params jkr_params = {
+	.chip_type = CHIP_JKR,
+	.num_ports = 2,
+
+	/* BAR0 map: see comments where KREG values are defined */
+	.bar0_size = JKR_BAR0_SIZE,
+	.kreg1_size = JKR_KREG1_SIZE,
+	.kreg2_offset = JKR_KREG2_OFFSET,
+	.kreg2_size = JKR_KREG2_SIZE,
+	.rcv_array_offset = JKR_RCV_ARRAY,
+	.rcv_array_size = JKR_RCV_ARRAY_SIZE,
+
+	.link_speed_supported = OPA_LINK_SPEED_100G | OPA_LINK_SPEED_25G,
+	.link_speed_active = OPA_LINK_SPEED_100G,
+	.asic_cclock_ps = JKR_ASIC_CCLOCK_PS,
+	.rsm_rule_size = JKR_C_RXE_NUM_RSM_INSTANCES,
+	.pkey_table_size = JKR_MAX_PKEY_VALUES,
+	.generic_boardname = "Cornelis Networks 5000 Host Fabric Interface Adapter",
+	.max_eager_entries = JKR_MAX_EAGER_ENTRIES,
+	.pio_base_bits = JKR_PIO_BASE_BITS,
+	.egress_err_info_data = &jkr_egress_err_info_data,
+	.send_ctrl_flush = JKR_SEND_CTRL_FLUSH_WRONG_LINK_STATE_SMASK,
+	.port_discard_egress_errs = JKR_PORT_DISCARD_EGRESS_ERRS,
+
+	/* interrupt sources */
+	.num_int_csrs = JKR_C_CCE_NUM_INT_CSRS,
+	.num_int_map_csrs = JKR_C_CCE_NUM_INT_MAP_CSRS,
+	.is_rcvavail_start = JKR_IS_RCVAVAIL_START,
+	.is_rcvurgent_start = JKR_IS_RCVURGENT_START,
+	.is_sdmaeng_err_start = JKR_IS_SDMAENG_ERR_START,
+	.is_sdma_idle_start = JKR_IS_SDMA_IDLE_START,
+	.is_sdma_progress_start = JKR_IS_SDMA_PROGRESS_START,
+	.is_sdma_start = JKR_IS_SDMA_START,
+	.is_last_source = JKR_IS_LAST_SOURCE,
+	.is_table = jkr_is_table,
+	.gi_enable_table = jkr_gi_enable_table,
+
+	/* counters */
+	.chip_dev_cntrs = jkr_dev_cntrs,
+	.chip_dev_cntr_first = JKR_DEV_CNTR_FIRST,
+	.chip_num_dev_cntrs = JKR_NUM_DEV_CNTRS,
+	.chip_port_cntrs = jkr_port_cntrs,
+	.chip_port_cntr_first = JKR_PORT_CNTR_FIRST,
+	.chip_num_port_cntrs = JKR_NUM_PORT_CNTRS,
+
+	/* ingress port registers */
+	.rxe_iport_stride = JKR_C_RXE_IPORT_STRIDE,
+	.rcv_iport_ctrl_reg = JKR_RCV_IPORT_CTRL,
+	.rcv_iport_status_reg = JKR_RCV_IPORT_STATUS,
+	.rcv_bth_qp_reg = JKR_RCV_BTH_QP,
+	.rcv_multicast_reg = JKR_RCV_MULTICAST,
+	.rcv_bypass_reg = JKR_RCV_BYPASS,
+	.rcv_vl15_reg = JKR_RCV_VL15,
+	.rcv_err_info_reg = JKR_RCV_ERR_INFO,
+	.rcv_err_status_reg = JKR_RCV_ERR_STATUS,
+	.rcv_err_mask_reg = JKR_RCV_ERR_MASK,
+	.rcv_err_clear_reg = JKR_RCV_ERR_CLEAR,
+	.rcv_qp_map_table_reg = JKR_RCV_QP_MAP_TABLE,
+	.rcv_partition_key_reg = JKR_RCV_PARTITION_KEY,
+	.rcv_counter_array32_reg = JKR_RCV_COUNTER_ARRAY32,
+	.rcv_counter_array64_reg = JKR_RCV_COUNTER_ARRAY64,
+
+	/* ingress port receive context registers */
+	.rxe_iprc_stride = JKR_C_RXE_IPRC_STRIDE,
+	.rcv_jkey_ctrl_reg = JKR_RCV_JKEY_CTRL,
+
+	/* RXE restricted context registers */
+	.rxe_rctxt_stride = JKR_C_RXE_RCTXT_STRIDE,
+	.rcv_rctxt_ctrl_reg = JKR_RCV_RCTXT_CTRL,
+	.rcv_egr_ctrl_reg = JKR_RCV_EGR_CTRL,
+	.rcv_tid_ctrl_reg = JKR_RCV_TID_CTRL,
+
+	/* RXE kernel context registers */
+	.rxe_kctxt_stride = JKR_C_RXE_KCTXT_STRIDE,
+	.rcv_kctxt_ctrl_reg = JKR_RCV_KCTXT_CTRL,
+	.rcv_hdr_addr_reg = JKR_RCV_HDR_ADDR,
+	.rcv_hdr_cnt_reg = JKR_RCV_HDR_CNT,
+	.rcv_hdr_ent_size_reg = JKR_RCV_HDR_ENT_SIZE,
+	.rcv_hdr_tail_addr_reg = JKR_RCV_HDR_TAIL_ADDR,
+	.rcv_avail_time_out_reg = JKR_RCV_AVAIL_TIME_OUT,
+	.rcv_hdr_ovfl_cnt_reg = JKR_RCV_HDR_OVFL_CNT,
+
+	/* RXE kernel/user registers */
+	.rxe_ku_stride = JKR_C_RXE_UCTXT_STRIDE,
+	.rcv_ctxt_status_reg = JKR_RCV_CTXT_STATUS,
+
+	/* RXE user registers */
+	.rxe_uctxt_stride = JKR_C_RXE_UCTXT_STRIDE,
+	.rcv_hdr_tail_reg = JKR_RCV_HDR_TAIL,
+	.rcv_hdr_head_reg = JKR_RCV_HDR_HEAD,
+	.rcv_egr_index_head_reg = JKR_RCV_EGR_INDEX_HEAD,
+	.rcv_tid_flow_table_reg = JKR_RCV_TID_FLOW_TABLE,
+
+	/* TXE kernel registers */
+	.send_contexts_reg = JKR_SEND_CONTEXTS,
+	.send_dma_engines_reg = JKR_SEND_DMA_ENGINES,
+	.send_pio_mem_size_reg = JKR_SEND_PIO_MEM_SIZE,
+	.send_dma_mem_size_reg = JKR_SEND_DMA_MEM_SIZE,
+	.send_pio_init_ctxt_reg = JKR_SEND_PIO_INIT_CTXT,
+
+	/* send context_registers */
+	.txe_sctxt_stride = JKR_C_TXE_SCTXT_STRIDE,
+	.send_ctxt_status_reg = JKR_SEND_CTXT_STATUS,
+	.send_ctxt_credit_ctrl_reg = JKR_SEND_CTXT_CREDIT_CTRL,
+	.send_ctxt_credit_status_reg = JKR_SEND_CTXT_CREDIT_STATUS,
+	.send_ctxt_credit_return_addr_reg = JKR_SEND_CTXT_CREDIT_RETURN_ADDR,
+	.send_ctxt_credit_force_reg = JKR_SEND_CTXT_CREDIT_FORCE,
+	.send_ctxt_err_status_reg = JKR_SEND_CTXT_ERR_STATUS,
+	.send_ctxt_err_mask_reg = JKR_SEND_CTXT_ERR_MASK,
+	.send_ctxt_err_clear_reg = JKR_SEND_CTXT_ERR_CLEAR,
+
+	/* TXE send context registers */
+	.txe_tctxt_stride = JKR_C_TXE_TCTXT_STRIDE,
+	.send_ctxt_ctrl_reg = JKR_SEND_CTXT_CTRL,
+
+	/* SDMA registers */
+	.txe_sdma_stride = JKR_C_TXE_SDMA_STRIDE,
+	.send_dma_ctrl_reg = JKR_SEND_DMA_CTRL,
+	.send_dma_status_reg = JKR_SEND_DMA_STATUS,
+	.send_dma_base_addr_reg = JKR_SEND_DMA_BASE_ADDR,
+	.send_dma_len_gen_reg = JKR_SEND_DMA_LEN_GEN,
+	.send_dma_tail_reg = JKR_SEND_DMA_TAIL,
+	.send_dma_head_reg = JKR_SEND_DMA_HEAD,
+	.send_dma_head_addr_reg = JKR_SEND_DMA_HEAD_ADDR,
+	.send_dma_priority_thld_reg = JKR_SEND_DMA_PRIORITY_THLD,
+	.send_dma_idle_cnt_reg = JKR_SEND_DMA_IDLE_CNT,
+	.send_dma_reload_cnt_reg = JKR_SEND_DMA_RELOAD_CNT,
+	.send_dma_desc_cnt_reg = JKR_SEND_DMA_DESC_CNT,
+	.send_dma_desc_fetched_cnt_reg = JKR_SEND_DMA_DESC_FETCHED_CNT,
+	.send_dma_eng_err_status_reg = JKR_SEND_DMA_ENG_ERR_STATUS,
+	.send_dma_eng_err_mask_reg = JKR_SEND_DMA_ENG_ERR_MASK,
+	.send_dma_eng_err_clear_reg = JKR_SEND_DMA_ENG_ERR_CLEAR,
+
+	/* SDMA Config registers */
+	.txe_sdmacfg_stride = JKR_C_TXE_SDMACFG_STRIDE,
+	.send_dma_cfg_memory_reg = JKR_SEND_DMA_CFG_MEMORY,
+
+	/* egress port registers */
+	.txe_eport_stride = JKR_C_TXE_EPORT_STRIDE,
+	.send_ctrl_reg = JKR_SEND_CTRL,
+	.send_high_priority_limit_reg = JKR_SEND_HIGH_PRIORITY_LIMIT,
+	.send_egress_err_status_reg = JKR_SEND_EGRESS_ERR_STATUS,
+	.send_egress_err_mask_reg = JKR_SEND_EGRESS_ERR_MASK,
+	.send_egress_err_clear_reg = JKR_SEND_EGRESS_ERR_CLEAR,
+	.send_bth_qp_reg = JKR_SEND_BTH_QP,
+	.send_static_rate_control_reg = JKR_SEND_STATIC_RATE_CONTROL,
+	.send_sc2vlt0_reg = JKR_SEND_SC2VLT0,
+	.send_sc2vlt1_reg = JKR_SEND_SC2VLT1,
+	.send_sc2vlt2_reg = JKR_SEND_SC2VLT2,
+	.send_sc2vlt3_reg = JKR_SEND_SC2VLT3,
+	.send_len_check0_reg = JKR_SEND_LEN_CHECK0,
+	.send_len_check1_reg = JKR_SEND_LEN_CHECK1,
+	.send_low_priority_list_reg = JKR_SEND_LOW_PRIORITY_LIST,
+	.send_high_priority_list_reg = JKR_SEND_HIGH_PRIORITY_LIST,
+	.send_counter_array32_reg = JKR_SEND_COUNTER_ARRAY32,
+	.send_counter_array64_reg = JKR_SEND_COUNTER_ARRAY64,
+	.send_cm_ctrl_reg = JKR_SEND_CM_CTRL,
+	.send_cm_global_credit_reg = JKR_SEND_CM_GLOBAL_CREDIT,
+	.send_cm_credit_used_status_reg = JKR_SEND_CM_CREDIT_USED_STATUS,
+	.send_cm_timer_ctrl_reg = JKR_SEND_CM_TIMER_CTRL,
+	.send_cm_local_au_table0_to3_reg = JKR_SEND_CM_LOCAL_AU_TABLE0_TO3,
+	.send_cm_local_au_table4_to7_reg = JKR_SEND_CM_LOCAL_AU_TABLE4_TO7,
+	.send_cm_remote_au_table0_to3_reg = JKR_SEND_CM_REMOTE_AU_TABLE0_TO3,
+	.send_cm_remote_au_table4_to7_reg = JKR_SEND_CM_REMOTE_AU_TABLE4_TO7,
+	.send_cm_credit_vl_reg = JKR_SEND_CM_CREDIT_VL,
+	.send_cm_credit_vl15_reg = JKR_SEND_CM_CREDIT_VL15,
+	.send_egress_err_info_reg = JKR_SEND_EGRESS_ERR_INFO,
+	.send_egress_err_source_reg = JKR_SEND_EGRESS_ERR_SOURCE,
+	.send_egress_ctxt_status_reg = JKR_SEND_EGRESS_CTXT_STATUS,
+	.send_egress_send_dma_status_reg = JKR_SEND_EGRESS_SEND_DMA_STATUS,
+
+	/* egress port send context registers */
+	.txe_epsc_stride = JKR_C_TXE_EPSC_STRIDE,
+	.send_ctxt_check_enable_reg = JKR_SEND_CTXT_CHECK_ENABLE,
+	.send_ctxt_check_vl_reg = JKR_SEND_CTXT_CHECK_VL,
+	.send_ctxt_check_job_key_reg = JKR_SEND_CTXT_CHECK_JOB_KEY,
+	.send_ctxt_check_partition_key_reg = JKR_SEND_CTXT_CHECK_PARTITION_KEY,
+	.send_ctxt_check_slid_reg = JKR_SEND_CTXT_CHECK_SLID,
+	.send_ctxt_check_opcode_reg = JKR_SEND_CTXT_CHECK_OPCODE,
+
+	/* SI registers */
+	.cce_msix_int_map_vec_reg = JKR_CCE_MSIX_INT_MAP_VEC,
+	.send_pio_err_status_reg = JKR_SEND_PIO_ERR_STATUS,
+	.send_pio_err_mask_reg = JKR_SEND_PIO_ERR_MASK,
+	.send_pio_err_clear_reg = JKR_SEND_PIO_ERR_CLEAR,
+	.send_dma_err_status_reg = JKR_SEND_DMA_ERR_STATUS,
+	.send_dma_err_mask_reg = JKR_SEND_DMA_ERR_MASK,
+	.send_dma_err_clear_reg = JKR_SEND_DMA_ERR_CLEAR,
+	.csr_err_status_reg = JKR_CSR_ERR_STATUS,
+	.csr_err_mask_reg = JKR_CSR_ERR_MASK,
+	.csr_err_clear_reg = JKR_CSR_ERR_CLEAR,
+
+	.setextled = gen_setextled,
+	.start_led_override = gen_start_led_override,
+	.shutdown_led_override = gen_shutdown_led_override,
+	.read_guid = jkr_read_guid,
+	.early_per_chip_init = jkr_early_per_chip_init,
+	.mid_per_chip_init = jkr_mid_per_chip_init,
+	.init_other = jkr_init_other,
+	.late_per_chip_init = gen_late_per_chip_init,
+	.start_port = gen_start_port,
+	.stop_port = gen_stop_port,
+	.init_tids = jkr_init_tids,
+	.put_tid = jkr_put_tid,
+	.rcv_array_wc_fill = jkr_rcv_array_wc_fill,
+	.set_port_tid_count = jkr_set_port_tid_count,
+	.set_port_max_mtu = gen_set_port_max_mtu,
+	.update_rcv_hdr_size = jkr_update_rcv_hdr_size,
+	.check_synth_status = jkr_check_synth_status,
+	.update_synth_status = jkr_update_synth_status,
+	.create_pbc = gen_create_pbc,
+	.set_pio_integrity = jkr_set_pio_integrity,
+	.find_used_resources = jkr_find_used_resources,
+	.read_link_quality = jkr_read_link_quality,
+	.set_rheq_addr = jkr_set_rheq_addr,
+	.handle_link_bounce = jkr_handle_link_bounce,
+	.enable_rcv_context = jkr_enable_rcv_context,
+};
+
+/*
+ * Number of user receive contexts each port configured to use (allow for more
+ * pio buffers per ctxt, etc).
+ */
+static int num_user_contexts_array[32];
+static int num_user_contexts_count;
+module_param_array_named(num_user_contexts, num_user_contexts_array, int,
+			 &num_user_contexts_count, 0444);
+MODULE_PARM_DESC(num_user_contexts, "Set max number of user contexts to use per-device, per-port (unset or -1: use the real (non-HT) CPU count)");
+
+uint krcvqs[RXE_NUM_DATA_VL];
+int krcvqsset;
+module_param_array(krcvqs, uint, &krcvqsset, S_IRUGO);
+MODULE_PARM_DESC(krcvqs, "Array of the number of non-control kernel receive queues by VL");
+
+/* computed based on above array */
+unsigned long n_krcvqs;
+
+static unsigned hfi2_rcvarr_split = 25;
+module_param_named(rcvarr_split, hfi2_rcvarr_split, uint, S_IRUGO);
+MODULE_PARM_DESC(rcvarr_split, "Percent of context's RcvArray entries used for Eager buffers");
+
+static uint eager_buffer_size = (8 << 20); /* 8MB */
+module_param(eager_buffer_size, uint, S_IRUGO);
+MODULE_PARM_DESC(eager_buffer_size, "Size of the eager buffers, default: 8MB");
+
+static uint rcvhdrcnt = 2048; /* 2x the max eager buffer count */
+module_param_named(rcvhdrcnt, rcvhdrcnt, uint, S_IRUGO);
+MODULE_PARM_DESC(rcvhdrcnt, "Receive header queue count (default 2048)");
+
+static uint hfi2_hdrq_entsize = DEFAULT_HDRQ_ENTSIZE;
+module_param_named(hdrq_entsize, hfi2_hdrq_entsize, uint, 0444);
+MODULE_PARM_DESC(hdrq_entsize, "Size of header queue entries: 2 - 8B, 16 - 64B, 32 - 128B (default)");
+
+unsigned int user_credit_return_threshold = 33;	/* default is 33% */
+module_param(user_credit_return_threshold, uint, S_IRUGO);
+MODULE_PARM_DESC(user_credit_return_threshold, "Credit return threshold for user send contexts, return when unreturned credits passes this many blocks (in percent of allocated blocks, 0 is off)");
+
+DEFINE_XARRAY_FLAGS(hfi2_dev_table, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
+
+struct cport_trap_reg {
+	u32 mask;
+	cport_trap_handler func;
+};
+
+/* send, or resend, START message */
+static int cport_start(struct hfi2_devdata *dd)
+{
+	struct cport_start_payload start = {0};
+	u64 *resp = NULL;
+	int resp_len = 0;
+	int ret;
+
+	start.opts_ena = dd->cport->opts;
+	start.trap_ena = dd->cport->traps;
+
+	ret = cport_send_req(dd, CH_OP_START, 0, &start, sizeof(start),
+			     (void **)&resp, &resp_len, HZ);
+	if (ret)
+		dd_dev_err(dd, "CPORT start failed %d\n", ret);
+	else if (resp_len)
+		dd_dev_info(dd, "CPORT started %016llx\n", *resp);
+	else
+		dd_dev_info(dd, "CPORT started\n");
+	kfree(resp);
+	return ret;
+}
+
+int register_cport_trap(struct hfi2_devdata *dd, struct cport_trap_status traps,
+			cport_trap_handler func)
+{
+	union {
+		struct cport_trap_status traps;
+		u32 dw;
+	} trap_val, cur_traps;
+	struct cport_trap_reg *entry;
+	u32 index;
+	int ret;
+
+	if (!dd->cport)
+		return 0;
+
+	trap_val.traps = traps;
+	cur_traps.traps = dd->cport->traps;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	entry->mask = trap_val.dw;
+	entry->func = func;
+	ret = xa_alloc_irq(&dd->cport->trap_xa, &index, entry, xa_limit_32b, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(entry);
+		return ret;
+	}
+
+	trap_val.dw |= cur_traps.dw;
+	if (trap_val.dw != cur_traps.dw) {
+		dd->cport->traps = trap_val.traps;
+		ret = cport_start(dd);
+	}
+	return ret;
+}
+
+int deregister_cport_trap(struct hfi2_devdata *dd, cport_trap_handler func)
+{
+	union {
+		struct cport_trap_status traps;
+		u32 dw;
+	} trap_val, cur_traps;
+	struct cport_trap_reg *entry;
+	unsigned long index;
+
+	if (!dd->cport)
+		return 0;
+
+	trap_val.dw = 0;
+	xa_lock_irq(&dd->cport->trap_xa);
+	xa_for_each(&dd->cport->trap_xa, index, entry) {
+		if (entry->func == func) {
+			__xa_erase(&dd->cport->trap_xa, index);
+			kfree(entry);
+		} else {
+			trap_val.dw |= entry->mask;
+		}
+	}
+	xa_unlock_irq(&dd->cport->trap_xa);
+	cur_traps.traps = dd->cport->traps;
+	if (trap_val.dw != cur_traps.dw) {
+		dd->cport->traps = trap_val.traps;
+		cport_start(dd);
+	}
+
+	return 0;
+}
+
+static void clearall_cport_trap(struct hfi2_devdata *dd)
+{
+	struct cport_trap_reg *entry;
+	unsigned long index;
+	struct cport_trap_status no_traps = {0};
+
+	if (!dd->cport)
+		return;
+
+	dd->cport->traps = no_traps;
+	cport_start(dd);
+	cport_register_cb(dd, CH_OP_TRAP, CH_OP_TRAP, NULL);
+	xa_lock_irq(&dd->cport->trap_xa);
+	/* there should be none left, but make certain */
+	xa_for_each(&dd->cport->trap_xa, index, entry) {
+		__xa_erase(&dd->cport->trap_xa, index);
+		dd_dev_info(dd, "removing latent TRAP handler %pS\n", entry->func);
+		kfree(entry);
+	}
+	xa_unlock_irq(&dd->cport->trap_xa);
+}
+
+static int handle_cport_trap(struct hfi2_devdata *dd, u8 op, u8 sideband,
+			     void *payload, int len, void *handle)
+{
+	struct cport_trap_payload *traps = payload;
+	struct cport_trap_payload repress = {0};
+	union {
+		struct cport_trap_status traps;
+		u32 dw;
+	} trap_val;
+	struct cport_trap_reg *entry;
+	unsigned long index;
+	int ret;
+
+	trap_val.traps = traps->trap_sts;
+
+	/* clear-down the traps we got */
+	repress.trap_sts = traps->trap_sts;
+	ret = cport_send_notif(dd, CH_OP_TRAP_REPRESS, 0, &repress, sizeof(repress));
+	if (ret)
+		dd_dev_warn(dd, "CPORT TRAP_REPRESS failed: %d\n", ret);
+#ifdef CPORT_TRAP_DEBUG
+	pr_warn("hfi2_%d: %s: CPORT TRAP %08x\n", dd->unit, __func__, trap_val.dw);
+#endif
+
+	xa_lock_irq(&dd->cport->trap_xa);
+	xa_for_each(&dd->cport->trap_xa, index, entry) {
+		if (entry->mask & trap_val.dw)
+			entry->func(dd, trap_val.traps);
+	}
+	xa_unlock_irq(&dd->cport->trap_xa);
+
+	return 0;
+}
+
+int start_cport(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = cport_init(dd);
+	if (ret || !dd->cport)
+		return ret;
+
+	cport_register_cb(dd, CH_OP_TRAP, CH_OP_TRAP, handle_cport_trap);
+
+	dd->cport->opts.bare_metal = 1;
+
+	ret = cport_start(dd);
+	if (ret)
+		cport_exit(dd);
+	return ret;
+}
+
+static void stop_cport(struct hfi2_devdata *dd)
+{
+	struct cport_stop_payload stop = {0};
+	u64 *resp = NULL;
+	int resp_len = 0;
+	int ret;
+
+	if (!dd->cport)
+		return;
+
+	ret = cport_send_req(dd, CH_OP_STOP, 0, &stop, sizeof(stop),
+			     (void **)&resp, &resp_len, HZ);
+	if (ret)
+		dd_dev_err(dd, "CPORT stop failed %d\n", ret);
+	else if (resp_len)
+		dd_dev_info(dd, "CPORT stopped %016llx\n", *resp);
+	else
+		dd_dev_info(dd, "CPORT stopped\n");
+	kfree(resp);
+
+	cport_exit(dd);
+}
+
+static int hfi2_create_kctxt(struct hfi2_pportdata *ppd, u16 ctxt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_ctxtdata *rcd;
+	int ret;
+
+	/* Control context has to be always 0 */
+	BUILD_BUG_ON(HFI2_CTRL_CTXT != 0);
+
+	ret = hfi2_create_ctxtdata(ppd, dd->node, ctxt, &rcd);
+	if (ret < 0) {
+		dd_dev_err(dd, "Kernel receive context allocation failed\n");
+		return ret;
+	}
+
+	/*
+	 * Set up the kernel context flags here and now because they use
+	 * default values for all receive side memories.  User contexts will
+	 * be handled as they are created.
+	 */
+	rcd->flags = HFI2_CAP_KGET(MULTI_PKT_EGR) |
+		HFI2_CAP_KGET(NODROP_RHQ_FULL) |
+		HFI2_CAP_KGET(NODROP_EGR_FULL) |
+		HFI2_CAP_KGET(DMA_RTAIL);
+
+	/* Control context must use DMA_RTAIL */
+	if (is_control_context(rcd))
+		rcd->flags |= HFI2_CAP_DMA_RTAIL;
+	rcd->fast_handler = get_dma_rtail_setting(rcd) ?
+				handle_receive_interrupt_dma_rtail :
+				handle_receive_interrupt_nodma_rtail;
+
+	hfi2_set_seq_cnt(rcd, 1);
+
+	rcd->sc = sc_alloc(ppd, SC_ACK, rcd->rcvhdrqentsize, dd->node);
+	if (!rcd->sc) {
+		dd_dev_err(dd, "Kernel send context allocation failed\n");
+		return -ENOMEM;
+	}
+	hfi2_init_ctxt(rcd->sc);
+
+	return 0;
+}
+
+/*
+ * Create the receive context array and one or more kernel contexts
+ */
+int hfi2_create_kctxts(struct hfi2_devdata *dd)
+{
+	u16 i;
+	u16 j;
+	int ret;
+
+	dd->num_rcd = chip_rcv_contexts(dd);
+	dd->rcd = kcalloc_node(dd->num_rcd, sizeof(*dd->rcd),
+			       GFP_KERNEL, dd->node);
+	if (!dd->rcd) {
+		dd->num_rcd = 0;
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+
+		for (j = 0; j < ppd->n_krcv_queues; j++) {
+			u16 ctxt = ppd->rcv_context_base + j;
+
+			ret = hfi2_create_kctxt(ppd, ctxt);
+			if (ret)
+				goto bail;
+		}
+	}
+
+	return 0;
+bail:
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+
+		for (j = 0; j < ppd->n_krcv_queues; j++) {
+			u16 ctxt = ppd->rcv_context_base + j;
+
+			hfi2_free_ctxt(dd->rcd[ctxt]);
+		}
+	}
+
+	/* All the contexts should be freed, free the array */
+	kfree(dd->rcd);
+	dd->rcd = NULL;
+	dd->num_rcd = 0;
+	return ret;
+}
+
+/*
+ * Helper routines for the receive context reference count (rcd and uctxt).
+ */
+static void hfi2_rcd_init(struct hfi2_ctxtdata *rcd)
+{
+	kref_init(&rcd->kref);
+}
+
+/**
+ * hfi2_rcd_free - When reference is zero clean up.
+ * @kref: pointer to an initialized rcd data structure
+ *
+ */
+static void hfi2_rcd_free(struct kref *kref)
+{
+	unsigned long flags;
+	struct hfi2_ctxtdata *rcd =
+		container_of(kref, struct hfi2_ctxtdata, kref);
+
+	spin_lock_irqsave(&rcd->dd->uctxt_lock, flags);
+	rcd->dd->rcd[rcd->ctxt] = NULL;
+	spin_unlock_irqrestore(&rcd->dd->uctxt_lock, flags);
+
+	hfi2_free_ctxtdata(rcd->dd, rcd);
+
+	kfree(rcd);
+}
+
+/**
+ * hfi2_rcd_put - decrement reference for rcd
+ * @rcd: pointer to an initialized rcd data structure
+ *
+ * Use this to put a reference after the init.
+ */
+int hfi2_rcd_put(struct hfi2_ctxtdata *rcd)
+{
+	if (rcd)
+		return kref_put(&rcd->kref, hfi2_rcd_free);
+
+	return 0;
+}
+
+/**
+ * hfi2_rcd_get - increment reference for rcd
+ * @rcd: pointer to an initialized rcd data structure
+ *
+ * Use this to get a reference after the init.
+ *
+ * Return : reflect kref_get_unless_zero(), which returns non-zero on
+ * increment, otherwise 0.
+ */
+int hfi2_rcd_get(struct hfi2_ctxtdata *rcd)
+{
+	return kref_get_unless_zero(&rcd->kref);
+}
+
+/**
+ * allocate_rcd_index - allocate an rcd index from the rcd array
+ * @ppd: pointer to a valid port data structure
+ * @rcd: rcd data structure to assign
+ * @index[in,out]: in, suggested context number; out, selected context number
+ *
+ * Allocate an rcd index, either at the given context number or any within
+ * a dynamic range.  If the fixed index is used or the dynamic range is full,
+ * return -EBUSY.
+ */
+static int allocate_rcd_index(struct hfi2_pportdata *ppd,
+			      struct hfi2_ctxtdata *rcd, u16 *index)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	unsigned long flags;
+	u16 ctxt = *index;
+	bool found;
+
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	found = false;
+	if (ctxt == DYNAMIC_CONTEXT) {
+		/* look for an unused dynamic context */
+		for (ctxt = ppd->first_dyn_alloc_ctxt;
+		     ctxt < ppd->rcv_context_base + ppd->num_rcv_contexts;
+		     ctxt++) {
+			if (!dd->rcd[ctxt]) {
+				found = true;
+				break;
+			}
+		}
+	} else {
+		/* use the context number given */
+		if (!dd->rcd[ctxt])
+			found = true;
+	}
+
+	if (found) {
+		rcd->ctxt = ctxt;
+		dd->rcd[ctxt] = rcd;
+		hfi2_rcd_init(rcd);
+	}
+	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+
+	if (!found)
+		return -EBUSY;
+
+	*index = ctxt;
+
+	return 0;
+}
+
+/**
+ * hfi2_rcd_get_by_index - get rcd by index
+ * @dd: pointer to a valid devdata structure
+ * @ctxt: the index of a possible rcd
+ *
+ * Hold the protecting spinlock and increment the reference on the selected
+ * rcd element.
+ *
+ * The caller is responsible for calling hfi2_rcd_put() on the returned
+ * pointer.
+ */
+struct hfi2_ctxtdata *hfi2_rcd_get_by_index(struct hfi2_devdata *dd, u16 ctxt)
+{
+	unsigned long flags;
+	struct hfi2_ctxtdata *rcd = NULL;
+
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	if (ctxt < dd->num_rcd) {
+		rcd = dd->rcd[ctxt];
+		if (rcd && !hfi2_rcd_get(rcd))
+			rcd = NULL;
+	}
+	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+
+	return rcd;
+}
+
+/*
+ * Common code for user and kernel context create and setup.
+ * NOTE: the initial kref is done here (hf1_rcd_init()).
+ */
+int hfi2_create_ctxtdata(struct hfi2_pportdata *ppd, int numa, u16 ctxt,
+			 struct hfi2_ctxtdata **context)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_ctxtdata *rcd;
+
+	rcd = kzalloc_node(sizeof(*rcd), GFP_KERNEL, numa);
+	if (rcd) {
+		u32 rcvtids, max_entries;
+		int ret;
+
+		ret = allocate_rcd_index(ppd, rcd, &ctxt);
+		if (ret) {
+			*context = NULL;
+			kfree(rcd);
+			return ret;
+		}
+
+		INIT_LIST_HEAD(&rcd->qp_wait_list);
+		hfi2_exp_tid_group_init(rcd);
+		rcd->ppd = ppd;
+		rcd->dd = dd;
+		rcd->numa_id = numa;
+		rcd->rcv_array_groups = dd->rcv_entries.ngroups;
+		rcd->rhf_rcv_function_map = normal_rhf_rcv_functions;
+		rcd->slow_handler = handle_receive_interrupt;
+		rcd->do_interrupt = rcd->slow_handler;
+		rcd->msix_intr = CCE_NUM_MSIX_VECTORS;
+
+		mutex_init(&rcd->exp_mutex);
+		spin_lock_init(&rcd->exp_lock);
+		INIT_LIST_HEAD(&rcd->flow_queue.queue_head);
+		INIT_LIST_HEAD(&rcd->rarr_queue.queue_head);
+
+		hfi2_cdbg(PROC, "setting up context %u", rcd->ctxt);
+
+		/* calculate the context's RcvArray entry starting point */
+		rcd->eager_base = ppd->rcv_array_base +
+				  ((ctxt - ppd->rcv_context_base) *
+				   dd->rcv_entries.ngroups *
+				   dd->rcv_entries.group_size);
+
+		rcd->rcvhdrq_cnt = rcvhdrcnt;
+		rcd->rcvhdrqentsize = hfi2_hdrq_entsize;
+		rcd->rhf_offset =
+			rcd->rcvhdrqentsize - sizeof(u64) / sizeof(u32);
+		rcd->kdeth_rcv_hdr = DEFAULT_RCVHDRSIZE;
+		/*
+		 * Simple Eager buffer allocation: we have already pre-allocated
+		 * the number of RcvArray entry groups. Each ctxtdata structure
+		 * holds the number of groups for that context.
+		 *
+		 * To follow CSR requirements and maintain cacheline alignment,
+		 * make sure all sizes and bases are multiples of group_size.
+		 *
+		 * The expected entry count is what is left after assigning
+		 * eager.
+		 */
+		max_entries = rcd->rcv_array_groups *
+			dd->rcv_entries.group_size;
+		rcvtids = ((max_entries * hfi2_rcvarr_split) / 100);
+		rcd->egrbufs.count = round_down(rcvtids,
+						dd->rcv_entries.group_size);
+		if (rcd->egrbufs.count > dd->params->max_eager_entries) {
+			dd_dev_err(dd, "ctxt%u: requested too many RcvArray entries.\n",
+				   rcd->ctxt);
+			rcd->egrbufs.count = dd->params->max_eager_entries;
+		}
+		hfi2_cdbg(PROC,
+			  "ctxt%u: max Eager buffer RcvArray entries: %u",
+			  rcd->ctxt, rcd->egrbufs.count);
+
+		/*
+		 * Allocate array that will hold the eager buffer accounting
+		 * data.
+		 * This will allocate the maximum possible buffer count based
+		 * on the value of the RcvArray split parameter.
+		 * The resulting value will be rounded down to the closest
+		 * multiple of dd->rcv_entries.group_size.
+		 */
+		rcd->egrbufs.buffers =
+			kcalloc_node(rcd->egrbufs.count,
+				     sizeof(*rcd->egrbufs.buffers),
+				     GFP_KERNEL, numa);
+		if (!rcd->egrbufs.buffers)
+			goto bail;
+		rcd->egrbufs.rcvtids =
+			kcalloc_node(rcd->egrbufs.count,
+				     sizeof(*rcd->egrbufs.rcvtids),
+				     GFP_KERNEL, numa);
+		if (!rcd->egrbufs.rcvtids)
+			goto bail;
+		rcd->egrbufs.size = eager_buffer_size;
+		/*
+		 * The size of the buffers programmed into the RcvArray
+		 * entries needs to be big enough to handle the highest
+		 * MTU supported.
+		 */
+		if (rcd->egrbufs.size < hfi2_max_mtu) {
+			rcd->egrbufs.size = __roundup_pow_of_two(hfi2_max_mtu);
+			hfi2_cdbg(PROC,
+				  "ctxt%u: eager bufs size too small. Adjusting to %u",
+				    rcd->ctxt, rcd->egrbufs.size);
+		}
+		rcd->egrbufs.rcvtid_size = HFI2_MAX_EAGER_BUFFER_SIZE;
+
+		/* Applicable only for statically created kernel contexts */
+		if (ctxt < ppd->first_dyn_alloc_ctxt) {
+			rcd->opstats = kzalloc_node(sizeof(*rcd->opstats),
+						    GFP_KERNEL, numa);
+			if (!rcd->opstats)
+				goto bail;
+
+			/* Initialize TID flow generations for the context */
+			hfi2_kern_init_ctxt_generations(rcd);
+		}
+
+		*context = rcd;
+		return 0;
+	}
+
+bail:
+	*context = NULL;
+	hfi2_free_ctxt(rcd);
+	return -ENOMEM;
+}
+
+/**
+ * hfi2_free_ctxt - free context
+ * @rcd: pointer to an initialized rcd data structure
+ *
+ * This wrapper is the free function that matches hfi2_create_ctxtdata().
+ * When a context is done being used (kernel or user), this function is called
+ * for the "final" put to match the kref init from hfi2_create_ctxtdata().
+ * Other users of the context do a get/put sequence to make sure that the
+ * structure isn't removed while in use.
+ */
+void hfi2_free_ctxt(struct hfi2_ctxtdata *rcd)
+{
+	hfi2_rcd_put(rcd);
+}
+
+/*
+ * Select the largest ccti value over all SLs to determine the intra-
+ * packet gap for the link.
+ *
+ * called with cca_timer_lock held (to protect access to cca_timer
+ * array), and rcu_read_lock() (to protect access to cc_state).
+ */
+void set_link_ipg(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct cc_state *cc_state;
+	int i;
+	u16 cce, ccti_limit, max_ccti = 0;
+	u16 shift, mult;
+	u64 src;
+	u32 current_egress_rate; /* Mbits /sec */
+	u64 max_pkt_time;
+	/*
+	 * max_pkt_time is the maximum packet egress time in units
+	 * of the fabric clock period 1/(805 MHz).
+	 */
+
+	cc_state = get_cc_state(ppd);
+
+	if (!cc_state)
+		/*
+		 * This should _never_ happen - rcu_read_lock() is held,
+		 * and set_link_ipg() should not be called if cc_state
+		 * is NULL.
+		 */
+		return;
+
+	for (i = 0; i < OPA_MAX_SLS; i++) {
+		u16 ccti = ppd->cca_timer[i].ccti;
+
+		if (ccti > max_ccti)
+			max_ccti = ccti;
+	}
+
+	ccti_limit = cc_state->cct.ccti_limit;
+	if (max_ccti > ccti_limit)
+		max_ccti = ccti_limit;
+
+	cce = cc_state->cct.entries[max_ccti].entry;
+	shift = (cce & 0xc000) >> 14;
+	mult = (cce & 0x3fff);
+
+	current_egress_rate = active_egress_rate(ppd);
+
+	max_pkt_time = egress_cycles(ppd->ibmaxlen, current_egress_rate);
+
+	src = (max_pkt_time >> shift) * mult;
+
+	src &= SEND_STATIC_RATE_CONTROL_CSR_SRC_RELOAD_SMASK;
+	src <<= SEND_STATIC_RATE_CONTROL_CSR_SRC_RELOAD_SHIFT;
+
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_static_rate_control_reg, src);
+}
+
+static enum hrtimer_restart cca_timer_fn(struct hrtimer *t)
+{
+	struct cca_timer *cca_timer;
+	struct hfi2_pportdata *ppd;
+	int sl;
+	u16 ccti_timer, ccti_min;
+	struct cc_state *cc_state;
+	unsigned long flags;
+	enum hrtimer_restart ret = HRTIMER_NORESTART;
+
+	cca_timer = container_of(t, struct cca_timer, hrtimer);
+	ppd = cca_timer->ppd;
+	sl = cca_timer->sl;
+
+	rcu_read_lock();
+
+	cc_state = get_cc_state(ppd);
+
+	if (!cc_state) {
+		rcu_read_unlock();
+		return HRTIMER_NORESTART;
+	}
+
+	/*
+	 * 1) decrement ccti for SL
+	 * 2) calculate IPG for link (set_link_ipg())
+	 * 3) restart timer, unless ccti is at min value
+	 */
+
+	ccti_min = cc_state->cong_setting.entries[sl].ccti_min;
+	ccti_timer = cc_state->cong_setting.entries[sl].ccti_timer;
+
+	spin_lock_irqsave(&ppd->cca_timer_lock, flags);
+
+	if (cca_timer->ccti > ccti_min) {
+		cca_timer->ccti--;
+		set_link_ipg(ppd);
+	}
+
+	if (cca_timer->ccti > ccti_min) {
+		unsigned long nsec = 1024 * ccti_timer;
+		/* ccti_timer is in units of 1.024 usec */
+		hrtimer_forward_now(t, ns_to_ktime(nsec));
+		ret = HRTIMER_RESTART;
+	}
+
+	spin_unlock_irqrestore(&ppd->cca_timer_lock, flags);
+	rcu_read_unlock();
+	return ret;
+}
+
+/*
+ * Common code for initializing the physical port structure.
+ */
+void hfi2_init_pportdata(struct pci_dev *pdev, struct hfi2_pportdata *ppd,
+			 struct hfi2_devdata *dd, u8 hw_pidx, u32 port)
+{
+	int i;
+	uint default_pkey_idx;
+	struct cc_state *cc_state;
+
+	ppd->dd = dd;
+	ppd->hw_pidx = hw_pidx;
+	ppd->port = port; /* IB port number, not index */
+	ppd->prev_link_width = LINK_WIDTH_DEFAULT;
+	/*
+	 * There are C_VL_COUNT number of PortVLXmitWait counters.
+	 * Adding 1 to C_VL_COUNT to include the PortXmitWait counter.
+	 */
+	for (i = 0; i < C_VL_COUNT + 1; i++) {
+		ppd->port_vl_xmit_wait_last[i] = 0;
+		ppd->vl_xmit_flit_cnt[i] = 0;
+	}
+
+	default_pkey_idx = 1;
+
+	ppd->pkeys[default_pkey_idx] = DEFAULT_P_KEY;
+	ppd->part_enforce |= HFI2_PART_ENFORCE_IN;
+	ppd->pkeys[0] = 0x8001;
+
+	INIT_WORK(&ppd->link_vc_work, handle_verify_cap);
+	INIT_WORK(&ppd->link_up_work, handle_link_up);
+	INIT_WORK(&ppd->link_down_work, handle_link_down);
+	INIT_WORK(&ppd->link_downgrade_work, handle_link_downgrade);
+	INIT_WORK(&ppd->sma_message_work, handle_sma_message);
+	INIT_WORK(&ppd->link_bounce_work, dd->params->handle_link_bounce);
+	INIT_DELAYED_WORK(&ppd->start_link_work, handle_start_link);
+	INIT_WORK(&ppd->linkstate_active_work, receive_interrupt_work);
+	INIT_WORK(&ppd->qsfp_info.qsfp_work, qsfp_event);
+
+	mutex_init(&ppd->hls_lock);
+	spin_lock_init(&ppd->qsfp_info.qsfp_lock);
+	seqlock_init(&ppd->sc2vl_lock);
+
+	ppd->qsfp_info.ppd = ppd;
+	ppd->sm_trap_qp = 0x0;
+	ppd->sa_qp = 0x1;
+
+	spin_lock_init(&ppd->cca_timer_lock);
+
+	for (i = 0; i < OPA_MAX_SLS; i++) {
+		ppd->cca_timer[i].ppd = ppd;
+		ppd->cca_timer[i].sl = i;
+		ppd->cca_timer[i].ccti = 0;
+		hrtimer_setup(&ppd->cca_timer[i].hrtimer, cca_timer_fn, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
+	}
+
+	ppd->cc_max_table_entries = IB_CC_TABLE_CAP_DEFAULT;
+
+	spin_lock_init(&ppd->cc_state_lock);
+	spin_lock_init(&ppd->cc_log_lock);
+	cc_state = kzalloc(sizeof(*cc_state), GFP_KERNEL);
+	RCU_INIT_POINTER(ppd->cc_state, cc_state);
+	if (!cc_state)
+		goto bail;
+	atomic_set(&ppd->ipoib_rsm_usr_num, 0);
+	ppd->netdev_rsm_rule = -1;
+	return;
+
+bail:
+	dd_dev_err(dd, "Congestion Control Agent disabled for port %d\n", port);
+}
+
+/*
+ * Do initialization for device that is only needed on
+ * first detect, not on resets.
+ */
+static int loadtime_init(struct hfi2_devdata *dd)
+{
+	return 0;
+}
+
+/**
+ * init_after_reset - re-initialize after a reset
+ * @dd: the hfi2_ib device
+ *
+ * sanity check at least some of the values after reset, and
+ * ensure no receive or transmit (explicitly, in case reset
+ * failed
+ */
+static int init_after_reset(struct hfi2_devdata *dd)
+{
+	int i;
+	int j;
+	struct hfi2_ctxtdata *rcd;
+	/*
+	 * Ensure chip does no sends or receives, tail updates, or
+	 * pioavail updates while we re-initialize.  This is mostly
+	 * for the driver data structures, not chip registers.
+	 */
+	for (i = 0; i < dd->num_pports; i++) {
+		for (j = 0; j < dd->pport[i].num_rcv_contexts; j++) {
+			u16 ctxt = dd->pport[i].rcv_context_base + j;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_DIS |
+				     HFI2_RCVCTRL_INTRAVAIL_DIS |
+				     HFI2_RCVCTRL_TAILUPD_DIS, rcd);
+			hfi2_rcd_put(rcd);
+		}
+	}
+	for (i = 0; i < dd->num_pports; i++)
+		pio_send_control(&dd->pport[i], PSC_GLOBAL_DISABLE);
+	for (i = 0; i < dd->num_send_contexts; i++)
+		sc_disable(dd->send_contexts[i].sc);
+
+	return 0;
+}
+
+static void enable_chip(struct hfi2_devdata *dd)
+{
+	struct hfi2_ctxtdata *rcd;
+	u32 rcvmask;
+	u16 i;
+	u16 j;
+
+	/* enable PIO send */
+	for (i = 0; i < dd->num_pports; i++)
+		pio_send_control(&dd->pport[i], PSC_GLOBAL_ENABLE);
+
+	/*
+	 * Enable kernel ctxts' receive and receive interrupt.
+	 * Other ctxts done as user opens and initializes them.
+	 */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+
+		for (j = 0; j < ppd->n_krcv_queues; j++) {
+			u16 ctxt = ppd->rcv_context_base + j;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			if (!rcd)
+				continue;
+			rcvmask = HFI2_RCVCTRL_CTXT_ENB
+				  | HFI2_RCVCTRL_INTRAVAIL_ENB;
+			if (HFI2_CAP_KGET_MASK(rcd->flags, DMA_RTAIL))
+				rcvmask |= HFI2_RCVCTRL_TAILUPD_ENB;
+			else
+				rcvmask |= HFI2_RCVCTRL_TAILUPD_DIS;
+			if (!HFI2_CAP_KGET_MASK(rcd->flags, MULTI_PKT_EGR))
+				rcvmask |= HFI2_RCVCTRL_ONE_PKT_EGR_ENB;
+			if (HFI2_CAP_KGET_MASK(rcd->flags, NODROP_RHQ_FULL))
+				rcvmask |= HFI2_RCVCTRL_NO_RHQ_DROP_ENB;
+			if (HFI2_CAP_KGET_MASK(rcd->flags, NODROP_EGR_FULL))
+				rcvmask |= HFI2_RCVCTRL_NO_EGR_DROP_ENB;
+			if (HFI2_CAP_IS_KSET(TID_RDMA))
+				rcvmask |= HFI2_RCVCTRL_TIDFLOW_ENB;
+			hfi2_rcvctrl(dd, rcvmask, rcd);
+			sc_enable(rcd->sc);
+			hfi2_rcd_put(rcd);
+		}
+	}
+}
+
+/**
+ * create_workqueues - create per port workqueues
+ * @dd: the hfi2_ib device
+ */
+static int create_workqueues(struct hfi2_devdata *dd)
+{
+	int pidx;
+	struct hfi2_pportdata *ppd;
+
+	if (!dd->hfi2_wq) {
+		dd->hfi2_wq = alloc_workqueue("hfi2%d",
+					      WQ_SYSFS | WQ_HIGHPRI |
+					      WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
+					      HFI2_MAX_ACTIVE_GEN_WQ_ENTRIES,
+					      dd->unit);
+		if (!dd->hfi2_wq)
+			goto wq_error;
+	}
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+		if (!ppd->link_wq) {
+			/*
+			 * Make the link workqueue single-threaded to enforce
+			 * serialization.
+			 */
+			ppd->link_wq = alloc_workqueue("hfi2_link_%d_%d",
+						       WQ_SYSFS |
+						       WQ_MEM_RECLAIM |
+						       WQ_UNBOUND,
+						       1, /* max_active */
+						       dd->unit, pidx);
+			if (!ppd->link_wq) {
+				pr_err("alloc_workqueue failed for port %d\n",
+				       pidx + 1);
+				goto wq_error;
+			}
+		}
+	}
+	return 0;
+
+wq_error:
+	destroy_workqueues(dd);
+	return -ENOMEM;
+}
+
+/**
+ * destroy_workqueues - destroy per port workqueues
+ * @dd: the hfi2_ib device
+ */
+static void destroy_workqueues(struct hfi2_devdata *dd)
+{
+	int pidx;
+	struct hfi2_pportdata *ppd;
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+
+		if (ppd->link_wq) {
+			destroy_workqueue(ppd->link_wq);
+			ppd->link_wq = NULL;
+		}
+	}
+	if (dd->hfi2_wq) {
+		destroy_workqueue(dd->hfi2_wq);
+		dd->hfi2_wq = NULL;
+	}
+}
+
+/**
+ * enable_general_intr() - Enable the IRQs that will be handled by the
+ * general interrupt handler.
+ * @dd: valid devdata
+ *
+ */
+static void enable_general_intr(struct hfi2_devdata *dd)
+{
+	const struct gi_enable_entry *entry = dd->params->gi_enable_table;
+
+	for (; entry->start <= entry->end; entry++)
+		set_intr_bits(dd, entry->start, entry->end, true);
+}
+
+static void wfr_start_port(struct hfi2_pportdata *ppd)
+{
+	int ret;
+
+	init_qsfp_int(ppd);
+
+	/*
+	 * start the serdes - must be after interrupts are
+	 * enabled so we are notified when the link goes up
+	 */
+	ret = bringup_serdes(ppd);
+	if (ret)
+		ppd_dev_info(ppd, "Failed to bring up port\n");
+}
+
+static void wfr_stop_port(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * Clear SerdesEnable.
+	 * We can't count on interrupts since we are stopping.
+	 */
+	hfi2_quiet_serdes(ppd);
+	if (ppd->link_wq)
+		flush_workqueue(ppd->link_wq);
+}
+
+/**
+ * hfi2_init - do the actual initialization sequence on the chip
+ * @dd: the hfi2_ib device
+ * @reinit: re-initializing, so don't allocate new memory
+ *
+ * Do the actual initialization sequence on the chip.  This is done
+ * both from the init routine called from the PCI infrastructure, and
+ * when we reset the chip, or detect that it was reset internally,
+ * or it's administratively re-enabled.
+ *
+ * Memory allocation here and in called routines is only done in
+ * the first case (reinit == 0).  We have to be careful, because even
+ * without memory allocation, we need to re-write all the chip registers
+ * TIDs, etc. after the reset or enable has completed.
+ */
+int hfi2_init(struct hfi2_devdata *dd, int reinit)
+{
+	int ret = 0, pidx, lastfail = 0;
+	unsigned long len;
+	u16 i;
+	struct hfi2_ctxtdata *rcd;
+	struct hfi2_pportdata *ppd;
+
+	/* Set up send low level handlers */
+	dd->process_pio_send = hfi2_verbs_send_pio;
+	dd->process_dma_send = hfi2_verbs_send_dma;
+	dd->pio_inline_send = pio_copy;
+
+	if (is_ax(dd)) {
+		atomic_set(&dd->drop_packet, DROP_PACKET_ON);
+		dd->do_drop = true;
+	} else {
+		atomic_set(&dd->drop_packet, DROP_PACKET_OFF);
+		dd->do_drop = false;
+	}
+
+	/* make sure the link is not "up" */
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+		ppd->linkup = 0;
+	}
+
+	if (reinit)
+		ret = init_after_reset(dd);
+	else
+		ret = loadtime_init(dd);
+	if (ret)
+		goto done;
+
+	/* dd->rcd can be NULL if early initialization failed */
+	for (pidx = 0; dd->rcd && pidx < dd->num_pports; pidx++) {
+		ppd = dd->pport + pidx;
+
+		for (i = 0; i < ppd->n_krcv_queues; ++i) {
+			u16 ctxt = ppd->rcv_context_base + i;
+			/*
+			 * Set up the (kernel) rcvhdr queue and egr TIDs.  If
+			 * doing re-init, the simplest way to handle this is
+			 * to free existing, and re-allocate.
+			 * Need to re-create rest of ctxt 0 ctxtdata as well.
+			 */
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			if (!rcd)
+				continue;
+
+			lastfail = hfi2_create_rcvhdrq(dd, rcd);
+			if (!lastfail)
+				lastfail = hfi2_setup_eagerbufs(rcd);
+			if (!lastfail)
+				lastfail = hfi2_kern_exp_rcv_init(rcd, reinit);
+			if (lastfail) {
+				dd_dev_err(dd,
+					   "failed to allocate kernel ctxt's rcvhdrq and/or egr bufs\n");
+				ret = lastfail;
+			}
+			/* enable IRQ */
+			hfi2_rcd_put(rcd);
+		}
+	}
+
+	/* Allocate enough memory for user event notification. */
+	len = PAGE_ALIGN(chip_rcv_contexts(dd) * HFI2_MAX_SHARED_CTXTS *
+			 sizeof(*dd->events));
+	dd->events = vmalloc_user(len);
+	if (!dd->events)
+		dd_dev_err(dd, "Failed to allocate user events page\n");
+	/*
+	 * Allocate a page for device and port status.
+	 * Page will be shared amongst all user processes.
+	 */
+	dd->status = vmalloc_user(PAGE_SIZE);
+	if (!dd->status)
+		dd_dev_err(dd, "Failed to allocate dev status page\n");
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+		if (dd->status)
+			ppd->statusp = &dd->status->ports[pidx];
+
+		set_mtu(ppd);
+	}
+
+	/* enable chip even if we have an error, so we can debug cause */
+	enable_chip(dd);
+
+done:
+	/*
+	 * Set status even if port serdes is not initialized
+	 * so that diags will work.
+	 */
+	if (dd->status)
+		dd->status->dev |= HFI2_STATUS_CHIP_PRESENT |
+			HFI2_STATUS_INITTED;
+	if (!ret) {
+		/* enable all interrupts from the chip */
+		enable_general_intr(dd);
+
+		/* chip is OK for user apps; mark it as initialized */
+		for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+			ppd = dd->pport + pidx;
+
+			dd->params->start_port(ppd);
+
+			/*
+			 * Set status even if port serdes is not initialized
+			 * so that diags will work.
+			 */
+			if (ppd->statusp)
+				*ppd->statusp |= HFI2_STATUS_CHIP_PRESENT |
+							HFI2_STATUS_INITTED;
+		}
+	}
+
+	/* if ret is non-zero, we probably should do some cleanup here... */
+	return ret;
+}
+
+struct hfi2_devdata *hfi2_lookup(int unit)
+{
+	return xa_load(&hfi2_dev_table, unit);
+}
+
+/*
+ * Stop the timers during unit shutdown, or after an error late
+ * in initialization.
+ */
+static void stop_timers(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int pidx;
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+		if (ppd->led_override_timer.function) {
+			timer_delete_sync(&ppd->led_override_timer);
+			atomic_set(&ppd->led_override_timer_active, 0);
+		}
+		if (ppd->ibport_data.rvp.trap_timer.function) {
+			timer_delete_sync(&ppd->ibport_data.rvp.trap_timer);
+		}
+	}
+}
+
+/**
+ * shutdown_device - shut down a device
+ * @dd: the hfi2_ib device
+ *
+ * This is called to make the device quiet when we are about to
+ * unload the driver, and also when the device is administratively
+ * disabled.   It does not free any data structures.
+ * Everything it does has to be setup again by hfi2_init(dd, 1)
+ */
+static void shutdown_device(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ctxtdata *rcd;
+	unsigned pidx;
+	int i;
+
+	if (dd->flags & HFI2_SHUTDOWN)
+		return;
+	dd->flags |= HFI2_SHUTDOWN;
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+
+		ppd->linkup = 0;
+		if (ppd->statusp)
+			*ppd->statusp &= ~(HFI2_STATUS_IB_CONF |
+					   HFI2_STATUS_IB_READY);
+	}
+	dd->flags &= ~HFI2_INITTED;
+
+	/*
+	 * Drop all traps.  After this point, there should be no more cport
+	 * handlers that depend on driver state.
+	 */
+	clearall_cport_trap(dd);
+
+	/* disable all interrupts except cport response */
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* WFR has no cport */
+		set_intr_bits(dd, 0, dd->params->is_last_source, false);
+		msix_shut_down_interrupts(dd, false);
+	} else {
+		/* mask all but the cport interrupt source */
+		set_intr_bits(dd, 0, JKR_MCTXT_CPORT_TO_PCIE_INT - 1, false);
+		set_intr_bits(dd, JKR_MCTXT_CPORT_TO_PCIE_INT + 1,
+			      dd->params->is_last_source, false);
+		msix_shut_down_interrupts(dd, true);
+	}
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+		for (i = 0; i < ppd->num_rcv_contexts; i++) {
+			u16 ctxt = ppd->rcv_context_base + i;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			hfi2_rcvctrl(dd, HFI2_RCVCTRL_TAILUPD_DIS |
+				     HFI2_RCVCTRL_CTXT_DIS |
+				     HFI2_RCVCTRL_INTRAVAIL_DIS |
+				     HFI2_RCVCTRL_PKEY_DIS |
+				     HFI2_RCVCTRL_ONE_PKT_EGR_DIS, rcd);
+			hfi2_rcd_put(rcd);
+		}
+		/*
+		 * Gracefully stop all sends allowing any in progress to
+		 * trickle out first.
+		 */
+		for (i = 0; i < dd->num_send_contexts; i++)
+			sc_flush(dd->send_contexts[i].sc);
+	}
+
+	/*
+	 * Enough for anything that's going to trickle out to have actually
+	 * done so.
+	 */
+	udelay(20);
+
+	/* disable all contexts */
+	for (i = 0; i < dd->num_send_contexts; i++)
+		sc_disable(dd->send_contexts[i].sc);
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+
+		/* disable the send device */
+		pio_send_control(ppd, PSC_GLOBAL_DISABLE);
+
+		dd->params->shutdown_led_override(ppd);
+
+		dd->params->stop_port(ppd);
+	}
+	if (dd->hfi2_wq)
+		flush_workqueue(dd->hfi2_wq);
+	sdma_exit(dd);
+}
+
+/**
+ * hfi2_free_ctxtdata - free a context's allocated data
+ * @dd: the hfi2_ib device
+ * @rcd: the ctxtdata structure
+ *
+ * free up any allocated data for a context
+ * It should never change any chip state, or global driver state.
+ */
+void hfi2_free_ctxtdata(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd)
+{
+	u32 e;
+
+	if (!rcd)
+		return;
+
+	if (rcd->rcvhdrq) {
+		dma_free_coherent(&dd->pcidev->dev, rcvhdrq_size(rcd),
+				  rcd->rcvhdrq, rcd->rcvhdrq_dma);
+		rcd->rcvhdrq = NULL;
+		if (hfi2_rcvhdrtail_kvaddr(rcd)) {
+			dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
+					  (void *)hfi2_rcvhdrtail_kvaddr(rcd),
+					  rcd->rcvhdrqtailaddr_dma);
+			rcd->rcvhdrtail_kvaddr = NULL;
+		}
+	}
+	if (rcd->rheq) {
+		dma_free_coherent(&dd->pcidev->dev, rheq_size(rcd),
+				  rcd->rheq, rcd->rheq_dma);
+		rcd->rheq = NULL;
+	}
+
+	/* all the RcvArray entries should have been cleared by now */
+	kfree(rcd->egrbufs.rcvtids);
+	rcd->egrbufs.rcvtids = NULL;
+
+	for (e = 0; e < rcd->egrbufs.alloced; e++) {
+		if (rcd->egrbufs.buffers[e].addr)
+			dma_free_coherent(&dd->pcidev->dev,
+					  rcd->egrbufs.buffers[e].len,
+					  rcd->egrbufs.buffers[e].addr,
+					  rcd->egrbufs.buffers[e].dma);
+	}
+	kfree(rcd->egrbufs.buffers);
+	rcd->egrbufs.alloced = 0;
+	rcd->egrbufs.buffers = NULL;
+
+	sc_free(rcd->sc);
+	rcd->sc = NULL;
+
+	vfree(rcd->subctxt_uregbase);
+	vfree(rcd->subctxt_rcvegrbuf);
+	vfree(rcd->subctxt_rcvhdr_base);
+	kfree(rcd->opstats);
+
+	rcd->subctxt_uregbase = NULL;
+	rcd->subctxt_rcvegrbuf = NULL;
+	rcd->subctxt_rcvhdr_base = NULL;
+	rcd->opstats = NULL;
+}
+
+/*
+ * Release our hold on the shared asic data.  If we are the last one,
+ * return the structure to be finalized outside the lock.  Must be
+ * holding hfi2_dev_table lock.
+ */
+static struct hfi2_asic_data *release_asic_data(struct hfi2_devdata *dd)
+{
+	struct hfi2_asic_data *ad;
+	int other;
+
+	if (!dd->asic_data)
+		return NULL;
+	dd->asic_data->dds[dd->hfi2_id] = NULL;
+	other = dd->hfi2_id ? 0 : 1;
+	ad = dd->asic_data;
+	dd->asic_data = NULL;
+	/* return NULL if the other dd still has a link */
+	return ad->dds[other] ? NULL : ad;
+}
+
+static void finalize_asic_data(struct hfi2_devdata *dd,
+			       struct hfi2_asic_data *ad)
+{
+	clean_up_i2c(dd, ad);
+	kfree(ad);
+}
+
+/**
+ * hfi2_free_devdata - cleans up and frees per-unit data structure
+ * @dd: pointer to a valid devdata structure
+ *
+ * It cleans up and frees all data structures set up by
+ * by hfi2_alloc_devdata().
+ */
+static void hfi2_free_devdata(struct hfi2_devdata *dd)
+{
+	struct hfi2_asic_data *ad;
+	unsigned long flags;
+
+	xa_lock_irqsave(&hfi2_dev_table, flags);
+	__xa_erase(&hfi2_dev_table, dd->unit);
+	ad = release_asic_data(dd);
+	xa_unlock_irqrestore(&hfi2_dev_table, flags);
+
+	finalize_asic_data(dd, ad);
+	free_platform_config(dd);
+	rcu_barrier(); /* wait for rcu callbacks to complete */
+	free_percpu(dd->int_counter);
+	free_percpu(dd->rcv_limit);
+	free_percpu(dd->send_schedule);
+	free_percpu(dd->tx_opstats);
+	dd->int_counter   = NULL;
+	dd->rcv_limit     = NULL;
+	dd->send_schedule = NULL;
+	dd->tx_opstats    = NULL;
+	kfree(dd->comp_vect);
+	dd->comp_vect = NULL;
+	if (dd->rcvhdrtail_dummy_kvaddr)
+		dma_free_coherent(&dd->pcidev->dev, sizeof(u64),
+				  (void *)dd->rcvhdrtail_dummy_kvaddr,
+				  dd->rcvhdrtail_dummy_dma);
+	dd->rcvhdrtail_dummy_kvaddr = NULL;
+	sdma_clean(dd, dd->num_sdma);
+	rvt_dealloc_device(&dd->verbs_dev.rdi);
+}
+
+/**
+ * hfi2_alloc_devdata - Allocate our primary per-unit data structure.
+ * @pdev: Valid PCI device
+ * @extra: How many bytes to alloc past the default
+ *
+ * Must be done via verbs allocator, because the verbs cleanup process
+ * both does cleanup and free of the data structure.
+ * "extra" is for chip-specific data.
+ */
+static struct hfi2_devdata *hfi2_alloc_devdata(struct pci_dev *pdev,
+					       const struct chip_params *params)
+{
+	struct hfi2_devdata *dd;
+	size_t extra;
+	int ret, nports;
+
+	nports = params->num_ports;
+	extra = nports * sizeof(struct hfi2_pportdata);
+	dd = (struct hfi2_devdata *)rvt_alloc_device(sizeof(*dd) + extra,
+						     nports);
+	if (!dd)
+		return ERR_PTR(-ENOMEM);
+	dd->params = params;
+	dd->num_pports = nports;
+	dd->pport = (struct hfi2_pportdata *)(dd + 1);
+	dd->pcidev = pdev;
+	pci_set_drvdata(pdev, dd);
+
+	ret = xa_alloc_irq(&hfi2_dev_table, &dd->unit, dd, xa_limit_32b,
+			GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(&pdev->dev,
+			"Could not allocate unit ID: error %d\n", -ret);
+		goto bail;
+	}
+	rvt_set_ibdev_name(&dd->verbs_dev.rdi, "%s_%d", "hfi2", dd->unit);
+	/*
+	 * If the BIOS does not have the NUMA node information set, select
+	 * NUMA 0 so we get consistent performance.
+	 */
+	dd->node = pcibus_to_node(pdev->bus);
+	if (dd->node == NUMA_NO_NODE) {
+		dd_dev_err(dd, "Invalid PCI NUMA node. Performance may be affected\n");
+		dd->node = 0;
+	}
+
+	/*
+	 * Initialize all locks for the device. This needs to be as early as
+	 * possible so locks are usable.
+	 */
+	spin_lock_init(&dd->sc_lock);
+	spin_lock_init(&dd->sendctrl_lock);
+	spin_lock_init(&dd->rcvctrl_lock);
+	spin_lock_init(&dd->uctxt_lock);
+	spin_lock_init(&dd->hfi2_diag_trans_lock);
+	spin_lock_init(&dd->sc_init_lock);
+	spin_lock_init(&dd->dc8051_memlock);
+	spin_lock_init(&dd->sde_map_lock);
+	spin_lock_init(&dd->pio_map_lock);
+	mutex_init(&dd->dc8051_lock);
+	init_waitqueue_head(&dd->event_queue);
+	spin_lock_init(&dd->irq_src_lock);
+	INIT_WORK(&dd->freeze_work, handle_freeze);
+
+	dd->int_counter = alloc_percpu(u64);
+	if (!dd->int_counter) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	dd->rcv_limit = alloc_percpu(u64);
+	if (!dd->rcv_limit) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	dd->send_schedule = alloc_percpu(u64);
+	if (!dd->send_schedule) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	dd->tx_opstats = alloc_percpu(struct hfi2_opcode_stats_perctx);
+	if (!dd->tx_opstats) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	dd->comp_vect = kzalloc(sizeof(*dd->comp_vect), GFP_KERNEL);
+	if (!dd->comp_vect) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	/* allocate dummy tail memory for all receive contexts */
+	dd->rcvhdrtail_dummy_kvaddr =
+		dma_alloc_coherent(&dd->pcidev->dev, sizeof(u64),
+				   &dd->rcvhdrtail_dummy_dma, GFP_KERNEL);
+	if (!dd->rcvhdrtail_dummy_kvaddr) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	return dd;
+
+bail:
+	hfi2_free_devdata(dd);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Called from freeze mode handlers, and from PCI error
+ * reporting code.  Should be paranoid about state of
+ * system and data structures.
+ */
+void hfi2_disable_after_error(struct hfi2_devdata *dd)
+{
+	if (dd->flags & HFI2_INITTED) {
+		u32 pidx;
+
+		dd->flags &= ~HFI2_INITTED;
+		if (dd->pport)
+			for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+				struct hfi2_pportdata *ppd;
+
+				ppd = dd->pport + pidx;
+				if (dd->flags & HFI2_PRESENT)
+					set_link_state(ppd, HLS_DN_DISABLE);
+
+				if (ppd->statusp)
+					*ppd->statusp &= ~HFI2_STATUS_IB_READY;
+			}
+	}
+
+	/*
+	 * Mark as having had an error for driver, and also
+	 * for /sys and status word mapped to user programs.
+	 * This marks unit as not usable, until reset.
+	 */
+	if (dd->status)
+		dd->status->dev |= HFI2_STATUS_HWERROR;
+}
+
+static void remove_one(struct pci_dev *);
+static int init_one(struct pci_dev *, const struct pci_device_id *);
+static void shutdown_one(struct pci_dev *);
+
+#define DRIVER_LOAD_MSG "Cornelis " DRIVER_NAME " loaded: "
+#define PFX DRIVER_NAME ": "
+
+const struct pci_device_id hfi2_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL0) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_CORNELIS, PCI_DEVICE_ID_CORNELIS1) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, hfi2_pci_tbl);
+
+static struct pci_driver hfi2_pci_driver = {
+	.name = DRIVER_NAME,
+	.probe = init_one,
+	.remove = remove_one,
+	.shutdown = shutdown_one,
+	.id_table = hfi2_pci_tbl,
+	.err_handler = &hfi2_pci_err_handler,
+};
+
+static void __init compute_krcvqs(void)
+{
+	int i;
+
+	for (i = 0; i < krcvqsset; i++)
+		n_krcvqs += krcvqs[i];
+}
+
+/*
+ * Do all the generic driver unit- and chip-independent memory
+ * allocation and initialization.
+ */
+static int __init hfi2_mod_init(void)
+{
+	int ret;
+
+	register_system_pinning_interface();
+	register_system_tid_ops();
+
+	ret = node_affinity_init();
+	if (ret)
+		goto bail;
+
+	/* validate max MTU before any devices start */
+	if (!valid_opa_max_mtu(hfi2_max_mtu)) {
+		pr_err("Invalid max_mtu 0x%x, using 0x%x instead\n",
+		       hfi2_max_mtu, HFI2_DEFAULT_MAX_MTU);
+		hfi2_max_mtu = HFI2_DEFAULT_MAX_MTU;
+	}
+	/* valid CUs run from 1-128 in powers of 2 */
+	if (hfi2_cu > 128 || !is_power_of_2(hfi2_cu))
+		hfi2_cu = 1;
+	/* valid credit return threshold is 0-100, variable is unsigned */
+	if (user_credit_return_threshold > 100)
+		user_credit_return_threshold = 100;
+
+	compute_krcvqs();
+	/*
+	 * sanitize receive interrupt count, time must wait until after
+	 * the hardware type is known
+	 */
+	if (rcv_intr_count > RCV_HDR_HEAD_COUNTER_MASK)
+		rcv_intr_count = RCV_HDR_HEAD_COUNTER_MASK;
+	/* reject invalid combinations */
+	if (rcv_intr_count == 0 && rcv_intr_timeout == 0) {
+		pr_err("Invalid mode: both receive interrupt count and available timeout are zero - setting interrupt count to 1\n");
+		rcv_intr_count = 1;
+	}
+	if (rcv_intr_count > 1 && rcv_intr_timeout == 0) {
+		/*
+		 * Avoid indefinite packet delivery by requiring a timeout
+		 * if count is > 1.
+		 */
+		pr_err("Invalid mode: receive interrupt count greater than 1 and available timeout is zero - setting available timeout to 1\n");
+		rcv_intr_timeout = 1;
+	}
+	if (rcv_intr_dynamic && !(rcv_intr_count > 1 && rcv_intr_timeout > 0)) {
+		/*
+		 * The dynamic algorithm expects a non-zero timeout
+		 * and a count > 1.
+		 */
+		pr_err("Invalid mode: dynamic receive interrupt mitigation with invalid count and timeout - turning dynamic off\n");
+		rcv_intr_dynamic = 0;
+	}
+
+	/* sanitize link CRC options */
+	link_crc_mask &= SUPPORTED_CRCS;
+
+	ret = opfn_init();
+	if (ret < 0) {
+		pr_err("Failed to allocate opfn_wq");
+		goto bail_dev;
+	}
+
+	/*
+	 * These must be called before the driver is registered with
+	 * the PCI subsystem.
+	 */
+	hfi2_dbg_init();
+	ret = pci_register_driver(&hfi2_pci_driver);
+	if (ret < 0) {
+		pr_err("Unable to register driver: error %d\n", -ret);
+		goto bail_dev;
+	}
+	goto bail; /* all OK */
+
+bail_dev:
+	hfi2_dbg_exit();
+bail:
+	return ret;
+}
+
+module_init(hfi2_mod_init);
+
+/*
+ * Do the non-unit driver cleanup, memory free, etc. at unload.
+ */
+static void __exit hfi2_mod_cleanup(void)
+{
+	pci_unregister_driver(&hfi2_pci_driver);
+	opfn_exit();
+	node_affinity_destroy_all();
+	hfi2_dbg_exit();
+
+	WARN_ON(!xa_empty(&hfi2_dev_table));
+	dispose_firmware();	/* asymmetric with obtain_firmware() */
+
+	deregister_system_tid_ops();
+	deregister_system_pinning_interface();
+}
+
+module_exit(hfi2_mod_cleanup);
+
+/* this can only be called after a successful initialization */
+static void cleanup_device_data(struct hfi2_devdata *dd)
+{
+	int ctxt;
+	int pidx;
+
+	/* users can't do anything more with chip */
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		struct hfi2_pportdata *ppd = &dd->pport[pidx];
+		struct cc_state *cc_state;
+		int i;
+
+		if (ppd->statusp)
+			*ppd->statusp &= ~HFI2_STATUS_CHIP_PRESENT;
+
+		for (i = 0; i < OPA_MAX_SLS; i++)
+			hrtimer_cancel(&ppd->cca_timer[i].hrtimer);
+
+		spin_lock(&ppd->cc_state_lock);
+		cc_state = get_cc_state_protected(ppd);
+		RCU_INIT_POINTER(ppd->cc_state, NULL);
+		spin_unlock(&ppd->cc_state_lock);
+
+		if (cc_state)
+			kfree_rcu(cc_state, rcu);
+	}
+
+	free_credit_return(dd);
+
+	/*
+	 * Free any receive resources still in use (usually just kernel
+	 * contexts) at unload.
+	 */
+	for (ctxt = 0; dd->rcd && ctxt < dd->num_rcd; ctxt++) {
+		struct hfi2_ctxtdata *rcd = dd->rcd[ctxt];
+
+		if (rcd) {
+			hfi2_free_ctxt_rcv_groups(rcd);
+			hfi2_free_ctxt(rcd);
+		}
+	}
+
+	kfree(dd->rcd);
+	dd->rcd = NULL;
+	dd->num_rcd = 0;
+
+	free_pio_map(dd);
+	/* must follow rcv context free - need to remove rcv's hooks */
+	if (dd->send_contexts) {
+		for (ctxt = 0; ctxt < dd->num_send_contexts; ctxt++)
+			sc_free(dd->send_contexts[ctxt].sc);
+	}
+	dd->num_send_contexts = 0;
+	kfree(dd->send_contexts);
+	dd->send_contexts = NULL;
+	kfree(dd->hw_to_sw);
+	dd->hw_to_sw = NULL;
+	/* free netdev data */
+	hfi2_free_rx(dd);
+	kfree(dd->boardname);
+	vfree(dd->events);
+	vfree(dd->status);
+
+	/* finalize the cport */
+	stop_cport(dd);
+	/* release interrupts */
+	msix_clean_up_interrupts(dd);
+
+	/* register reads and writes are invalid after this call */
+	hfi2_pcie_ddcleanup(dd);
+}
+
+/*
+ * Clean up on unit shutdown, or error during unit load after
+ * successful initialization.
+ */
+static void postinit_cleanup(struct hfi2_devdata *dd)
+{
+	hfi2_start_cleanup(dd);
+	hfi2_comp_vectors_clean_up(dd);
+	hfi2_dev_affinity_clean_up(dd);
+	release_rsm_rules(dd);
+
+	cleanup_device_data(dd);
+
+	destroy_workqueues(dd);
+	hfi2_pcie_cleanup(dd->pcidev);
+	hfi2_free_devdata(dd);
+}
+
+static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	int ret = 0, pidx, initfail;
+	struct hfi2_devdata *dd;
+	const struct chip_params *params;
+
+	/* First, lock the non-writable module parameters */
+	HFI2_CAP_LOCK();
+
+	/* Validate dev ids */
+	if (ent->vendor == PCI_VENDOR_ID_INTEL &&
+	    (ent->device == PCI_DEVICE_ID_INTEL0 ||
+	      ent->device == PCI_DEVICE_ID_INTEL1)) {
+		params = &wfr_params;
+	} else if (ent->vendor == PCI_VENDOR_ID_CORNELIS &&
+		   ent->device == PCI_DEVICE_ID_CORNELIS1) {
+		params = &jkr_params;
+	} else {
+		dev_err(&pdev->dev, "Failing on unknown device %04x:%04x\n",
+			ent->vendor, ent->device);
+		return -ENODEV;
+	}
+
+	/* verify arrays are large enough */
+	if (params->num_int_csrs > LARGEST_NUM_INT_CSRS ||
+	    params->num_ports > LARGEST_NUM_PORTS ||
+	    params->pkey_table_size > MAX_PKEY_VALUES) {
+		dev_err(&pdev->dev, "Source arrays are compiled too small\n");
+		return -EINVAL;
+	}
+
+	/* Allocate the dd so we can get to work */
+	dd = hfi2_alloc_devdata(pdev, params);
+	if (IS_ERR(dd))
+		return PTR_ERR(dd);
+
+	/* Validate some global module parameters */
+	ret = hfi2_validate_rcvhdrcnt(dd, rcvhdrcnt);
+	if (ret)
+		goto free_dd;
+
+	/* use the encoding function as a sanitization check */
+	if (!encode_rcv_header_entry_size(hfi2_hdrq_entsize)) {
+		dd_dev_err(dd, "Invalid HdrQ Entry size %u\n",
+			   hfi2_hdrq_entsize);
+		ret = -EINVAL;
+		goto free_dd;
+	}
+
+	/* The receive eager buffer size must be set before the receive
+	 * contexts are created.
+	 *
+	 * Set the eager buffer size.  Validate that it falls in a range
+	 * allowed by the hardware - all powers of 2 between the min and
+	 * max.  The maximum valid MTU is within the eager buffer range
+	 * so we do not need to cap the max_mtu by an eager buffer size
+	 * setting.
+	 */
+	if (eager_buffer_size) {
+		if (!is_power_of_2(eager_buffer_size))
+			eager_buffer_size =
+				roundup_pow_of_two(eager_buffer_size);
+		eager_buffer_size =
+			clamp_val(eager_buffer_size,
+				  MIN_EAGER_BUFFER * 8,
+				  MAX_EAGER_BUFFER_TOTAL);
+		dd_dev_info(dd, "Eager buffer size %u\n",
+			    eager_buffer_size);
+	} else {
+		dd_dev_err(dd, "Invalid Eager buffer size of 0\n");
+		ret = -EINVAL;
+		goto free_dd;
+	}
+
+	/* restrict value of hfi2_rcvarr_split */
+	hfi2_rcvarr_split = clamp_val(hfi2_rcvarr_split, 0, 100);
+
+	ret = hfi2_pcie_init(dd);
+	if (ret)
+		goto free_dd;
+
+	ret = create_workqueues(dd);
+	if (ret)
+		goto pcie_cleanup;
+
+	/*
+	 * Do device-specific initialization.  If hfi2_init_dd() fails, it
+	 * cleans up after itself.
+	 */
+	ret = hfi2_init_dd(dd);
+	if (ret)
+		goto destroy_wqs; /* error already printed */
+
+	/* do the generic initialization */
+	if (!ret)
+		initfail = hfi2_init(dd, 0);
+
+	if (!initfail && !ret)
+		ret = hfi2_mad_init(dd);
+
+	if (!initfail && !ret)
+		ret = hfi2_register_ib_device(dd);
+
+	if (!initfail && !ret)
+		ret = init_cport_trap128(dd); /* after IB device register */
+
+	/*
+	 * Now ready for use.  this should be cleared whenever we
+	 * detect a reset, or initiate one.  If earlier failure,
+	 * we still create devices, so diags, etc. can be used
+	 * to determine cause of problem.
+	 */
+	if (!initfail && !ret) {
+		dd->flags |= HFI2_INITTED;
+		/* create debufs files after init and ib register */
+		hfi2_dbg_ibdev_init(&dd->verbs_dev);
+	}
+
+	if (initfail || ret) {
+		stop_cport(dd);
+		msix_clean_up_interrupts(dd);
+		stop_timers(dd);
+		flush_workqueue(ib_wq);
+		for (pidx = 0; pidx < dd->num_pports; ++pidx)
+			dd->params->stop_port(dd->pport + pidx);
+		if (!ret) {
+			hfi2_unregister_ib_device(dd);
+			hfi2_mad_deinit(dd);
+		}
+		postinit_cleanup(dd);
+		if (initfail)
+			ret = initfail;
+		goto bail;	/* everything already cleaned */
+	}
+
+	sdma_start(dd);
+
+	return 0;
+
+destroy_wqs:
+	destroy_workqueues(dd);
+pcie_cleanup:
+	hfi2_pcie_cleanup(pdev);
+free_dd:
+	hfi2_free_devdata(dd);
+bail:
+	return ret;
+}
+
+static void wait_for_clients(struct hfi2_devdata *dd)
+{
+	/*
+	 * Remove the device init value and complete the device if there is
+	 * no clients or wait for active clients to finish.
+	 */
+	if (refcount_dec_and_test(&dd->user_refcount))
+		complete(&dd->user_comp);
+
+	wait_for_completion(&dd->user_comp);
+}
+
+static void remove_one(struct pci_dev *pdev)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+
+	/* close debugfs files before ib unregister */
+	hfi2_dbg_ibdev_exit(&dd->verbs_dev);
+
+	/* wait for existing user space clients to finish */
+	wait_for_clients(dd);
+
+	/* unregister from IB core */
+	hfi2_unregister_ib_device(dd);
+
+	/* stop handling LOCAL_MAD_ from CPORT */
+	hfi2_mad_deinit(dd);
+
+	/*
+	 * Disable the IB link, disable interrupts on the device,
+	 * clear dma engines, etc.
+	 */
+	shutdown_device(dd);
+
+	stop_timers(dd);
+
+	/* wait until all of our (qsfp) queue_work() calls complete */
+	flush_workqueue(ib_wq);
+
+	postinit_cleanup(dd);
+}
+
+static void shutdown_one(struct pci_dev *pdev)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+
+	shutdown_device(dd);
+}
+
+/**
+ * hfi2_create_rcvhdrq - create a receive header queue
+ * @dd: the hfi2_ib device
+ * @rcd: the context data
+ *
+ * This must be contiguous memory (from an i/o perspective), and must be
+ * DMA'able (which means for some systems, it will go through an IOMMU,
+ * or be forced into a low address range).
+ */
+int hfi2_create_rcvhdrq(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd)
+{
+	u32 amt = rcvhdrq_size(rcd);
+
+	if (!rcd->rcvhdrq) {
+		rcd->rcvhdrq = dma_alloc_coherent(&dd->pcidev->dev, amt,
+						  &rcd->rcvhdrq_dma,
+						  GFP_KERNEL);
+
+		if (!rcd->rcvhdrq) {
+			dd_dev_err(dd,
+				   "attempt to allocate %d bytes for ctxt %u rcvhdrq failed\n",
+				   amt, rcd->ctxt);
+			goto bail;
+		}
+
+		if (HFI2_CAP_KGET_MASK(rcd->flags, DMA_RTAIL) ||
+		    HFI2_CAP_UGET_MASK(rcd->flags, DMA_RTAIL)) {
+			rcd->rcvhdrtail_kvaddr = dma_alloc_coherent(&dd->pcidev->dev,
+								    PAGE_SIZE,
+								    &rcd->rcvhdrqtailaddr_dma,
+								    GFP_KERNEL);
+			if (!rcd->rcvhdrtail_kvaddr) {
+				dd_dev_err(dd,
+					   "attempt to allocate 1 page for ctxt %u rcvhdrqtailaddr failed\n",
+					   rcd->ctxt);
+				goto rhq_free;
+			}
+		}
+
+		if (dd->params->chip_type != CHIP_WFR) {
+			u32 rheq_amt = rheq_size(rcd);
+
+			rcd->rheq = dma_alloc_coherent(&dd->pcidev->dev,
+						       rheq_amt,
+						       &rcd->rheq_dma,
+						       GFP_KERNEL);
+			if (!rcd->rheq) {
+				dd_dev_err(dd,
+					   "attempt to allocate %d bytes for ctxt %u rheq failed\n",
+					   rheq_amt, rcd->ctxt);
+				goto tail_free;
+			}
+		}
+	}
+
+	set_hdrq_regs(rcd->ppd, rcd->ctxt, rcd->rcvhdrqentsize,
+		      rcd->rcvhdrq_cnt, rcd->kdeth_rcv_hdr);
+
+	return 0;
+
+tail_free:
+	if (rcd->rcvhdrtail_kvaddr) {
+		dma_free_coherent(&dd->pcidev->dev, PAGE_SIZE,
+				  (void *)hfi2_rcvhdrtail_kvaddr(rcd),
+				  rcd->rcvhdrqtailaddr_dma);
+		rcd->rcvhdrtail_kvaddr = NULL;
+	}
+rhq_free:
+	dma_free_coherent(&dd->pcidev->dev, amt, rcd->rcvhdrq,
+			  rcd->rcvhdrq_dma);
+	rcd->rcvhdrq = NULL;
+bail:
+	return -ENOMEM;
+}
+
+/**
+ * hfi2_setup_eagerbufs - allocate eager buffers, both kernel and user
+ * contexts.
+ * @rcd: the context we are setting up.
+ *
+ * Allocate the eager TID buffers and program them into the chip.
+ * They are no longer completely contiguous, we do multiple allocation
+ * calls.  Otherwise we get the OOM code involved, by asking for too
+ * much per call, with disastrous results on some kernels.
+ */
+int hfi2_setup_eagerbufs(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 max_entries, egrtop, alloced_bytes = 0;
+	u16 order, idx = 0;
+	int ret = 0;
+	u16 round_mtu = roundup_pow_of_two(hfi2_max_mtu);
+
+	/*
+	 * The minimum size of the eager buffers is a groups of MTU-sized
+	 * buffers.
+	 * The global eager_buffer_size parameter is checked against the
+	 * theoretical lower limit of the value. Here, we check against the
+	 * MTU.
+	 */
+	if (rcd->egrbufs.size < (round_mtu * dd->rcv_entries.group_size))
+		rcd->egrbufs.size = round_mtu * dd->rcv_entries.group_size;
+	/*
+	 * If using one-pkt-per-egr-buffer, lower the eager buffer
+	 * size to the max MTU (page-aligned).
+	 */
+	if (!HFI2_CAP_KGET_MASK(rcd->flags, MULTI_PKT_EGR))
+		rcd->egrbufs.rcvtid_size = round_mtu;
+
+	/*
+	 * Eager buffers sizes of 1MB or less require smaller TID sizes
+	 * to satisfy the "multiple of 8 RcvArray entries" requirement.
+	 */
+	if (rcd->egrbufs.size <= (1 << 20))
+		rcd->egrbufs.rcvtid_size = max((unsigned long)round_mtu,
+			rounddown_pow_of_two(rcd->egrbufs.size / 8));
+
+	while (alloced_bytes < rcd->egrbufs.size &&
+	       rcd->egrbufs.alloced < rcd->egrbufs.count) {
+		rcd->egrbufs.buffers[idx].addr =
+			dma_alloc_coherent(&dd->pcidev->dev,
+					   rcd->egrbufs.rcvtid_size,
+					   &rcd->egrbufs.buffers[idx].dma,
+					   GFP_KERNEL);
+		if (rcd->egrbufs.buffers[idx].addr) {
+			rcd->egrbufs.buffers[idx].len =
+				rcd->egrbufs.rcvtid_size;
+			rcd->egrbufs.rcvtids[rcd->egrbufs.alloced].addr =
+				rcd->egrbufs.buffers[idx].addr;
+			rcd->egrbufs.rcvtids[rcd->egrbufs.alloced].dma =
+				rcd->egrbufs.buffers[idx].dma;
+			rcd->egrbufs.alloced++;
+			alloced_bytes += rcd->egrbufs.rcvtid_size;
+			idx++;
+		} else {
+			u32 new_size, i, j;
+			u64 offset = 0;
+
+			/*
+			 * Fail the eager buffer allocation if:
+			 *   - we are already using the lowest acceptable size
+			 *   - we are using one-pkt-per-egr-buffer (this implies
+			 *     that we are accepting only one size)
+			 */
+			if (rcd->egrbufs.rcvtid_size == round_mtu ||
+			    !HFI2_CAP_KGET_MASK(rcd->flags, MULTI_PKT_EGR)) {
+				dd_dev_err(dd, "ctxt%u: Failed to allocate eager buffers\n",
+					   rcd->ctxt);
+				ret = -ENOMEM;
+				goto bail_rcvegrbuf_phys;
+			}
+
+			new_size = rcd->egrbufs.rcvtid_size / 2;
+
+			/*
+			 * If the first attempt to allocate memory failed, don't
+			 * fail everything but continue with the next lower
+			 * size.
+			 */
+			if (idx == 0) {
+				rcd->egrbufs.rcvtid_size = new_size;
+				continue;
+			}
+
+			/*
+			 * Re-partition already allocated buffers to a smaller
+			 * size.
+			 */
+			rcd->egrbufs.alloced = 0;
+			for (i = 0, j = 0, offset = 0; j < idx; i++) {
+				if (i >= rcd->egrbufs.count)
+					break;
+				rcd->egrbufs.rcvtids[i].dma =
+					rcd->egrbufs.buffers[j].dma + offset;
+				rcd->egrbufs.rcvtids[i].addr =
+					rcd->egrbufs.buffers[j].addr + offset;
+				rcd->egrbufs.alloced++;
+				if ((rcd->egrbufs.buffers[j].dma + offset +
+				     new_size) ==
+				    (rcd->egrbufs.buffers[j].dma +
+				     rcd->egrbufs.buffers[j].len)) {
+					j++;
+					offset = 0;
+				} else {
+					offset += new_size;
+				}
+			}
+			rcd->egrbufs.rcvtid_size = new_size;
+		}
+	}
+	rcd->egrbufs.numbufs = idx;
+	rcd->egrbufs.size = alloced_bytes;
+
+	hfi2_cdbg(PROC,
+		  "ctxt%u: Alloced %u rcv tid entries @ %uKB, total %uKB",
+		  rcd->ctxt, rcd->egrbufs.alloced,
+		  rcd->egrbufs.rcvtid_size / 1024, rcd->egrbufs.size / 1024);
+
+	/*
+	 * Set the contexts rcv array head update threshold to the closest
+	 * power of 2 (so we can use a mask instead of modulo) below half
+	 * the allocated entries.
+	 */
+	rcd->egrbufs.threshold =
+		rounddown_pow_of_two(rcd->egrbufs.alloced / 2);
+	/*
+	 * Compute the expected RcvArray entry base. This is done after
+	 * allocating the eager buffers in order to maximize the
+	 * expected RcvArray entries for the context.
+	 */
+	max_entries = rcd->rcv_array_groups * dd->rcv_entries.group_size;
+	egrtop = roundup(rcd->egrbufs.alloced, dd->rcv_entries.group_size);
+	rcd->expected_count = max_entries - egrtop;
+	if (rcd->expected_count > MAX_TID_PAIR_ENTRIES * 2)
+		rcd->expected_count = MAX_TID_PAIR_ENTRIES * 2;
+
+	rcd->expected_base = rcd->eager_base + egrtop;
+	hfi2_cdbg(PROC, "ctxt%u: eager:%u, exp:%u, egrbase:%u, expbase:%u",
+		  rcd->ctxt, rcd->egrbufs.alloced, rcd->expected_count,
+		  rcd->eager_base, rcd->expected_base);
+
+	if (!hfi2_rcvbuf_validate(rcd->egrbufs.rcvtid_size, PT_EAGER, &order)) {
+		hfi2_cdbg(PROC,
+			  "ctxt%u: current Eager buffer size is invalid %u",
+			  rcd->ctxt, rcd->egrbufs.rcvtid_size);
+		ret = -EINVAL;
+		goto bail_rcvegrbuf_phys;
+	}
+
+	/*
+	 * Enable RcvArray access on JKR and later by configuring RcvEgrCtrl and
+	 * RcvTidCtrl before writing TIDs to the RcvArray.
+	 *
+	 * Call HFI2_RCVCTRL_TID_CONFIG only after eager_base, egrbufs.alloced,
+	 * expected_count, and expected_base are initialized in rcd.  The last
+	 * 3 of the 4 are initialized above in this function.
+	 */
+	hfi2_rcvctrl(dd, HFI2_RCVCTRL_TID_CONFIG, rcd);
+
+	for (idx = 0; idx < rcd->egrbufs.alloced; idx++) {
+		dd->params->put_tid(rcd, idx, PT_EAGER,
+				    rcd->egrbufs.rcvtids[idx].dma, order,
+				    false);
+		cond_resched();
+	}
+
+	return 0;
+
+bail_rcvegrbuf_phys:
+	for (idx = 0; idx < rcd->egrbufs.alloced &&
+	     rcd->egrbufs.buffers[idx].addr;
+	     idx++) {
+		dma_free_coherent(&dd->pcidev->dev,
+				  rcd->egrbufs.buffers[idx].len,
+				  rcd->egrbufs.buffers[idx].addr,
+				  rcd->egrbufs.buffers[idx].dma);
+		rcd->egrbufs.buffers[idx].addr = NULL;
+		rcd->egrbufs.buffers[idx].dma = 0;
+		rcd->egrbufs.buffers[idx].len = 0;
+	}
+
+	return ret;
+}
+
+/*
+ * Return number of requested user ports for the given unit and port based
+ * on information given in the module parameter num_user_contexts.
+ * Return -1 (use non-HT cores) if the corresponding entry is not set.
+ */
+int get_num_user_contexts(struct hfi2_devdata *dd, int pidx)
+{
+	struct hfi2_devdata *xdd;
+	int start;
+	int i;
+
+	/* find the count of ports from earlier units */
+	start = 0;
+	for (i = 0; i < dd->unit; i++) {
+		xdd = hfi2_lookup(i);
+		/* previous units should exist - check anyway */
+		if (!xdd) {
+			dd_dev_err(dd, "%s: unit %d not found?\n", __func__, i);
+			return -1;
+		}
+		start += xdd->num_pports;
+	}
+
+	/* adjust for the port on this unit */
+	start += pidx;
+
+	/* check if enough elements are set for this unit's port */
+	if (start >= num_user_contexts_count)
+		return -1;
+
+	return num_user_contexts_array[start];
+}
diff --git a/drivers/infiniband/hw/hfi2/intr.c b/drivers/infiniband/hw/hfi2/intr.c
new file mode 100644
index 000000000000..ba8ae3511387
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/intr.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/bitmap.h>
+
+#include "hfi2.h"
+#include "file_ops.h"
+#include "common.h"
+#include "sdma.h"
+
+#define LINK_UP_DELAY  500  /* in microseconds */
+
+static void set_mgmt_allowed(struct hfi2_pportdata *ppd)
+{
+	u32 frame;
+	struct hfi2_devdata *dd = ppd->dd;
+
+	if (ppd->neighbor_type == NEIGHBOR_TYPE_HFI) {
+		ppd->mgmt_allowed = 1;
+	} else {
+		read_8051_config(dd, REMOTE_LNI_INFO, GENERAL_CONFIG, &frame);
+		ppd->mgmt_allowed = (frame >> MGMT_ALLOWED_SHIFT)
+		& MGMT_ALLOWED_MASK;
+	}
+}
+
+/*
+ * Our neighbor has indicated that we are allowed to act as a fabric
+ * manager, so place the full management partition key in the second
+ * (0-based) pkey array position. Note that we should already have
+ * the limited management partition key in array element 1, and also
+ * that the port is not yet up when add_full_mgmt_pkey() is invoked.
+ */
+static void add_full_mgmt_pkey(struct hfi2_pportdata *ppd)
+{
+	/* Sanity check - ppd->pkeys[2] should be 0, or already initialized */
+	if (!((ppd->pkeys[2] == 0) || (ppd->pkeys[2] == FULL_MGMT_P_KEY)))
+		ppd_dev_warn(ppd, "%s pkey[2] already set to 0x%x, resetting it to 0x%x\n",
+			     __func__, ppd->pkeys[2], FULL_MGMT_P_KEY);
+	ppd->pkeys[2] = FULL_MGMT_P_KEY;
+	(void)hfi2_set_ib_cfg(ppd, HFI2_IB_CFG_PKEYS, 0);
+	hfi2_event_pkey_change(ppd->dd, ppd->port);
+}
+
+static void signal_ib_event(struct hfi2_pportdata *ppd, enum ib_event_type ev)
+{
+	struct ib_event event;
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/*
+	 * Only call ib_dispatch_event() if the IB device has been
+	 * registered.  HFI2_INITED is set iff the driver has successfully
+	 * registered with the IB core.
+	 */
+	if (!(dd->flags & HFI2_INITTED))
+		return;
+	event.device = &dd->verbs_dev.rdi.ibdev;
+	event.element.port_num = ppd->port;
+	event.event = ev;
+	ib_dispatch_event(&event);
+}
+
+/**
+ * handle_linkup_change - finish linkup/down state changes
+ * @dd: valid device
+ * @linkup: link state information
+ *
+ * Handle a linkup or link down notification.
+ * The HW needs time to finish its link up state change. Give it that chance.
+ *
+ * This is called outside an interrupt.
+ *
+ */
+void handle_linkup_change(struct hfi2_pportdata *ppd, u32 linkup)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	enum ib_event_type ev;
+
+	if (dd->cport) {
+		ppd_dev_err(ppd, "%s should not be called for JKR\n", __func__);
+		return;
+	}
+	if (!(ppd->linkup ^ !!linkup))
+		return;	/* no change, nothing to do */
+
+	if (linkup) {
+		/*
+		 * Quick linkup does not trigger or implement:
+		 *	- VerifyCap interrupt
+		 *	- VerifyCap frames
+		 * But rather moves directly to LinkUp.
+		 *
+		 * Do the work of the VerifyCap interrupt handler,
+		 * handle_verify_cap(), but do not try moving the state to
+		 * LinkUp as we are already there.
+		 *
+		 * NOTE: This uses this device's vAU, vCU, and vl15_init for
+		 * the remote values.  Both sides must be using the values.
+		 */
+		if (quick_linkup) {
+			set_up_vau(ppd, dd->vau);
+			set_up_vl15(ppd, dd->vl15_init);
+			assign_remote_cm_au_table(ppd, dd->vcu);
+		}
+
+		ppd->neighbor_guid =
+			read_csr(dd, DC_DC8051_STS_REMOTE_GUID);
+		ppd->neighbor_type =
+			read_csr(dd, DC_DC8051_STS_REMOTE_NODE_TYPE) &
+				 DC_DC8051_STS_REMOTE_NODE_TYPE_VAL_MASK;
+		ppd->neighbor_port_number =
+			read_csr(dd, DC_DC8051_STS_REMOTE_PORT_NO) &
+				 DC_DC8051_STS_REMOTE_PORT_NO_VAL_SMASK;
+		ppd->neighbor_fm_security =
+			read_csr(dd, DC_DC8051_STS_REMOTE_FM_SECURITY) &
+				 DC_DC8051_STS_LOCAL_FM_SECURITY_DISABLED_MASK;
+		ppd_dev_info(ppd,
+			     "Neighbor Guid %llx, Type %d, Port Num %d\n",
+			     ppd->neighbor_guid, ppd->neighbor_type,
+			     ppd->neighbor_port_number);
+
+		/* HW needs LINK_UP_DELAY to settle, give it that chance */
+		udelay(LINK_UP_DELAY);
+
+		/*
+		 * 'MgmtAllowed' information, which is exchanged during
+		 * LNI, is available at this point.
+		 */
+		set_mgmt_allowed(ppd);
+
+		if (ppd->mgmt_allowed)
+			add_full_mgmt_pkey(ppd);
+
+		/* physical link went up */
+		ppd->linkup = 1;
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE);
+
+		/* link widths are not available until the link is fully up */
+		get_linkup_link_widths(ppd);
+
+	} else {
+		/* physical link went down */
+		ppd->linkup = 0;
+
+		/* clear HW details of the previous connection */
+		ppd->actual_vls_operational = 0;
+		reset_link_credits(ppd);
+
+		/* freeze after a link down to guarantee a clean egress */
+		start_freeze_handling(dd, FREEZE_SELF | FREEZE_LINK_DOWN);
+
+		ev = IB_EVENT_PORT_ERR;
+
+		hfi2_set_uevent_bits(ppd, _HFI2_EVENT_LINKDOWN_BIT);
+
+		/* if we are down, the neighbor is down */
+		ppd->neighbor_normal = 0;
+
+		/* notify IB of the link change */
+		signal_ib_event(ppd, ev);
+	}
+}
+
+/* Special version of handle_linkup_change() for systems with a CPORT */
+void cport_handle_linkup_change(struct hfi2_pportdata *ppd,
+				struct opa_port_info *pi, u32 linkup)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	enum ib_event_type ev;
+
+	if (!(ppd->linkup ^ !!linkup))
+		return;	/* no change, nothing to do */
+
+	if (linkup) {
+		ppd->neighbor_guid = be64_to_cpu(pi->neigh_node_guid);
+		ppd->neighbor_port_number = pi->neigh_port_num;
+		ppd->neighbor_type = pi->port_neigh_mode & OPA_PI_MASK_NEIGH_NODE_TYPE;
+		ppd->mgmt_allowed = !!(pi->port_neigh_mode &
+				       OPA_PI_MASK_NEIGH_MGMT_ALLOWED);
+		ppd->neighbor_fm_security = !!(pi->port_neigh_mode &
+					       OPA_PI_MASK_NEIGH_FW_AUTH_BYPASS);
+
+		ppd_dev_info(ppd,
+			     "Neighbor Guid %llx, Type %d, Port Num %d\n",
+			     ppd->neighbor_guid, ppd->neighbor_type,
+			     ppd->neighbor_port_number);
+
+		if (ppd->mgmt_allowed) {
+			if (!(ppd->pkeys[2] == 0 || ppd->pkeys[2] == FULL_MGMT_P_KEY))
+				ppd_dev_warn(ppd, "%s pkey[2] already set to 0x%x, "
+					     "resetting it to 0x%x\n",
+					     __func__, ppd->pkeys[2], FULL_MGMT_P_KEY);
+			ppd->pkeys[2] = FULL_MGMT_P_KEY;
+			hfi2_event_pkey_change(ppd->dd, ppd->port);
+		}
+
+		/* physical link went up */
+		ppd->linkup = 1;
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE);
+
+		/* link widths are not available until the link is fully up */
+		ppd->link_width_enabled = be16_to_cpu(pi->link_width.enabled);
+		ppd->link_width_supported = be16_to_cpu(pi->link_width.supported);
+		ppd->link_width_active = be16_to_cpu(pi->link_width.active);
+		ppd->link_width_downgrade_supported =
+				be16_to_cpu(pi->link_width_downgrade.supported);
+		ppd->link_width_downgrade_enabled =
+				be16_to_cpu(pi->link_width_downgrade.enabled);
+		ppd->link_width_downgrade_tx_active =
+				be16_to_cpu(pi->link_width_downgrade.tx_active);
+		ppd->link_width_downgrade_rx_active =
+				be16_to_cpu(pi->link_width_downgrade.rx_active);
+		ppd->link_speed_supported = be16_to_cpu(pi->link_speed.supported);
+		ppd->link_speed_active = be16_to_cpu(pi->link_speed.active);
+		ppd->link_speed_enabled = be16_to_cpu(pi->link_speed.enabled);
+
+		/*
+		 * Rewrite the KDETH indicator.  The firmware overwrites it
+		 * when resetting the link.  All ports are rewritten, but
+		 * the same value is always used - a noop on other ports.
+		 */
+		init_kdeth_qp(dd);
+
+	} else {
+		/* physical link went down */
+		ppd->linkup = 0;
+
+		/* clear HW details of the previous connection */
+		ppd->actual_vls_operational = 0;
+
+		/* what's left from reset_link_credits() */
+		dd->vl15buf_cached = 0;
+
+		start_linkdown_handling(ppd);
+
+		ev = IB_EVENT_PORT_ERR;
+
+		hfi2_set_uevent_bits(ppd, _HFI2_EVENT_LINKDOWN_BIT);
+
+		/* if we are down, the neighbor is down */
+		ppd->neighbor_normal = 0;
+
+		/* notify IB of the link change */
+		signal_ib_event(ppd, ev);
+	}
+}
+
+/**
+ * go_port_active - All steps needed when the port goes active.
+ * @ppd: port structure
+ *
+ * Take non-chip specific steps for transition from INIT to ACTIVE.  This
+ * routine expects the port to already in INIT.  This routine is not
+ * responsible for setting the state.
+ */
+void go_port_active(struct hfi2_pportdata *ppd)
+{
+	struct ib_event event = { 0 };
+
+	/* Signal the IB layer that the port has gone active */
+	event.device = &ppd->dd->verbs_dev.rdi.ibdev;
+	event.element.port_num = ppd->port;
+	event.event = IB_EVENT_PORT_ACTIVE;
+	ib_dispatch_event(&event);
+}
+
+/*
+ * Handle receive or urgent interrupts for user contexts.  This means a user
+ * process was waiting for a packet to arrive, and didn't want to poll.
+ */
+void handle_user_interrupt(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	if (bitmap_empty(rcd->in_use_ctxts, HFI2_MAX_SHARED_CTXTS))
+		goto done;
+
+	if (test_and_clear_bit(HFI2_CTXT_WAITING_RCV, &rcd->event_flags)) {
+		wake_up_interruptible(&rcd->wait);
+		hfi2_rcvctrl(dd, HFI2_RCVCTRL_INTRAVAIL_DIS, rcd);
+	} else if (test_and_clear_bit(HFI2_CTXT_WAITING_URG,
+							&rcd->event_flags)) {
+		rcd->urgent++;
+		wake_up_interruptible(&rcd->wait);
+	}
+done:
+	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+}
diff --git a/drivers/infiniband/hw/hfi2/msix.c b/drivers/infiniband/hw/hfi2/msix.c
new file mode 100644
index 000000000000..1a3d7ace6133
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/msix.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2018 - 2020 Intel Corporation.
+ */
+
+#include "hfi2.h"
+#include "affinity.h"
+#include "sdma.h"
+#include "netdev.h"
+
+/**
+ * msix_initialize() - Calculate, request and configure MSIx IRQs
+ * @dd: valid hfi2 devdata
+ *
+ */
+int msix_initialize(struct hfi2_devdata *dd)
+{
+	u32 total;
+	int ret;
+	int pidx;
+	struct hfi2_msix_entry *entries;
+
+	/*
+	 * MSIx interrupt count:
+	 *	one for the general, "slow path" interrupt
+	 *	one per used SDMA engine
+	 *	one per kernel receive context
+	 *      ...any new IRQs should be added here.
+	 */
+	total = 1 + dd->num_sdma;
+	for (pidx = 0; pidx < dd->num_pports; pidx++)
+		total += dd->pport[pidx].n_krcv_queues + dd->pport[pidx].num_netdev_contexts;
+
+	if (total >= CCE_NUM_MSIX_VECTORS)
+		return -EINVAL;
+
+	ret = pci_alloc_irq_vectors(dd->pcidev, total, total, PCI_IRQ_MSIX);
+	if (ret < 0) {
+		dd_dev_err(dd, "pci_alloc_irq_vectors() failed: %d\n", ret);
+		return ret;
+	}
+
+	entries = kcalloc(total, sizeof(*dd->msix_info.msix_entries),
+			  GFP_KERNEL);
+	if (!entries) {
+		pci_free_irq_vectors(dd->pcidev);
+		return -ENOMEM;
+	}
+
+	dd->msix_info.msix_entries = entries;
+	spin_lock_init(&dd->msix_info.msix_lock);
+	bitmap_zero(dd->msix_info.in_use_msix, total);
+	dd->msix_info.max_requested = total;
+	dd_dev_info(dd, "%u MSI-X interrupts allocated\n", total);
+
+	return 0;
+}
+
+/**
+ * msix_request_irq() - Allocate a free MSIx IRQ
+ * @dd: valid devdata
+ * @arg: context information for the IRQ
+ * @handler: IRQ handler
+ * @thread: IRQ thread handler (could be NULL)
+ * @type: affinty IRQ type
+ * @name: IRQ name
+ *
+ * Allocated an MSIx vector if available, and then create the appropriate
+ * meta data needed to keep track of the pci IRQ request.
+ *
+ * Return:
+ *   < 0   Error
+ *   >= 0  MSIx vector
+ *
+ */
+static int msix_request_irq(struct hfi2_devdata *dd, void *arg,
+			    irq_handler_t handler, irq_handler_t thread,
+			    enum irq_type type, const char *name)
+{
+	unsigned long nr;
+	int irq;
+	int ret;
+	struct hfi2_msix_entry *me;
+
+	/* Allocate an MSIx vector */
+	spin_lock(&dd->msix_info.msix_lock);
+	nr = find_first_zero_bit(dd->msix_info.in_use_msix,
+				 dd->msix_info.max_requested);
+	if (nr < dd->msix_info.max_requested)
+		__set_bit(nr, dd->msix_info.in_use_msix);
+	spin_unlock(&dd->msix_info.msix_lock);
+
+	if (nr == dd->msix_info.max_requested)
+{
+printk("%s: failed, nr %ld, max_requested %d, -ENOSPC\n", __func__, nr, dd->msix_info.max_requested);
+		return -ENOSPC;
+}
+
+	if (type < IRQ_SDMA || type >= IRQ_OTHER)
+		return -EINVAL;
+
+	irq = pci_irq_vector(dd->pcidev, nr);
+	ret = pci_request_irq(dd->pcidev, nr, handler, thread, arg, name);
+	if (ret) {
+		dd_dev_err(dd,
+			   "%s: request for IRQ %d failed, MSIx %lx, err %d\n",
+			   name, irq, nr, ret);
+		spin_lock(&dd->msix_info.msix_lock);
+		__clear_bit(nr, dd->msix_info.in_use_msix);
+		spin_unlock(&dd->msix_info.msix_lock);
+		return ret;
+	}
+
+	/*
+	 * assign arg after pci_request_irq call, so it will be
+	 * cleaned up
+	 */
+	me = &dd->msix_info.msix_entries[nr];
+	me->irq = irq;
+	me->arg = arg;
+	me->type = type;
+
+	/* affinity is not set up when the general interrupt is requested */
+	if (type != IRQ_GENERAL) {
+		/* This is a request, so a failure is not fatal */
+		ret = hfi2_get_irq_affinity(dd, me);
+		if (ret)
+			dd_dev_err(dd, "%s: unable to pin IRQ %d, vector %ld\n",
+				   name, irq, nr);
+	}
+
+	return nr;
+}
+
+static int msix_request_rcd_irq_common(struct hfi2_ctxtdata *rcd,
+				       irq_handler_t handler,
+				       irq_handler_t thread,
+				       const char *name)
+{
+	u32 source;
+	int nr;
+
+	nr = msix_request_irq(rcd->dd, rcd, handler, thread, IRQ_RCVCTXT,
+			      name);
+	if (nr < 0)
+		return nr;
+
+	/*
+	 * Set the interrupt register and mask for this context's interrupt.
+	 */
+	source = rcd->dd->params->is_rcvavail_start + rcd->ctxt;
+	rcd->ireg = source / 64;
+	rcd->imask = ((u64)1) << (source % 64);
+	rcd->msix_intr = nr;
+	remap_intr(rcd->dd, source, nr);
+
+	return 0;
+}
+
+/**
+ * msix_request_rcd_irq() - Helper function for RCVAVAIL IRQs
+ * @rcd: valid rcd context
+ *
+ */
+int msix_request_rcd_irq(struct hfi2_ctxtdata *rcd)
+{
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d kctxt%d",
+		 rcd->dd->unit, rcd->ctxt);
+
+	return msix_request_rcd_irq_common(rcd, receive_context_interrupt,
+					   receive_context_thread, name);
+}
+
+/**
+ * msix_netdev_request_rcd_irq  - Helper function for RCVAVAIL IRQs
+ * for netdev context
+ * @rcd: valid netdev contexti
+ */
+int msix_netdev_request_rcd_irq(struct hfi2_ctxtdata *rcd)
+{
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d nd kctxt%d",
+		 rcd->dd->unit, rcd->ctxt);
+	return msix_request_rcd_irq_common(rcd, receive_context_interrupt_napi,
+					   NULL, name);
+}
+
+/**
+ * msix_request_sdma_irq  - Helper for getting SDMA IRQ resources
+ * @sde: valid sdma engine
+ *
+ */
+int msix_request_sdma_irq(struct sdma_engine *sde)
+{
+	int nr;
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d sdma%d",
+		 sde->dd->unit, sde->this_idx);
+	nr = msix_request_irq(sde->dd, sde, sdma_interrupt, sdma_interrupt_thr,
+			      IRQ_SDMA, name);
+	if (nr < 0)
+		return nr;
+	sde->msix_intr = nr;
+	remap_sdma_interrupts(sde->dd, sde->this_idx, nr);
+
+	return 0;
+}
+
+/**
+ * msix_request_general_irq - Helper for getting general IRQ
+ * resources
+ * @dd: valid device data
+ */
+int msix_request_general_irq(struct hfi2_devdata *dd)
+{
+	int nr;
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d", dd->unit);
+	nr = msix_request_irq(dd, dd, general_interrupt, NULL, IRQ_GENERAL,
+			      name);
+	if (nr < 0)
+		return nr;
+
+	/* general interrupt must be MSIx vector 0 */
+	if (nr) {
+		msix_free_irq(dd, (u8)nr);
+		dd_dev_err(dd, "Invalid index %d for GENERAL IRQ\n", nr);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * enable_sdma_srcs - Helper to enable SDMA IRQ srcs
+ * @dd: valid devdata structure
+ * @i: index of SDMA engine
+ */
+static void enable_sdma_srcs(struct hfi2_devdata *dd, int i)
+{
+	set_intr_bits(dd, dd->params->is_sdma_start + i,
+		      dd->params->is_sdma_start + i, true);
+	set_intr_bits(dd, dd->params->is_sdma_progress_start + i,
+		      dd->params->is_sdma_progress_start + i, true);
+	set_intr_bits(dd, dd->params->is_sdma_idle_start + i,
+		      dd->params->is_sdma_idle_start + i, true);
+	set_intr_bits(dd, dd->params->is_sdmaeng_err_start + i,
+		      dd->params->is_sdmaeng_err_start + i, true);
+}
+
+/**
+ * msix_request_irqs() - Allocate SDMA and receive IRQs
+ * @dd: valid devdata structure
+ *
+ * Helper function to request MSIx IRQs for SDMA and receive.
+ */
+int msix_request_irqs(struct hfi2_devdata *dd)
+{
+	int i;
+	int j;
+	int ret;
+
+	/*
+	 * The general interrupt has already been requested, but affinity
+	 * has not been set due to affinity being initialized after the
+	 * interrupt is needed.  Set the affinity here.
+	 *
+	 * This code expects the general interrupt at index 0.  This is
+	 * enforced by msix_request_general_irq().
+	 *
+	 * This is a request, so a failure is not fatal.
+	 */
+	ret = hfi2_get_irq_affinity(dd, &dd->msix_info.msix_entries[0]);
+	if (ret) {
+		dd_dev_err(dd, "general irq: unable to pin IRQ %d, vector 0\n",
+			   dd->msix_info.msix_entries[0].irq);
+	}
+
+	for (i = 0; i < dd->num_sdma; i++) {
+		struct sdma_engine *sde = &dd->per_sdma[i];
+
+		ret = msix_request_sdma_irq(sde);
+		if (ret)
+			return ret;
+		enable_sdma_srcs(sde->dd, i);
+	}
+
+	for (i = 0; i < dd->num_pports; i++) {
+		for (j = 0; j < dd->pport[i].n_krcv_queues; j++) {
+			u16 ctxt = dd->pport[i].rcv_context_base + j;
+			struct hfi2_ctxtdata *rcd = hfi2_rcd_get_by_index(dd, ctxt);
+
+			if (rcd)
+				ret = msix_request_rcd_irq(rcd);
+			hfi2_rcd_put(rcd);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * msix_early_request_irqs() - Allocate needed early IRQs.
+ * @dd: valid devdata structure
+ *
+ * Helper function to request an MSIx IRQs for anthing needed early in the
+ * device initialize.  Presently, only the general interrupt handler.
+ */
+int msix_early_request_irqs(struct hfi2_devdata *dd)
+{
+	return msix_request_general_irq(dd);
+}
+
+/**
+ * msix_free_irq() - Free the specified MSIx resources and IRQ
+ * @dd: valid devdata
+ * @msix_intr: MSIx vector to free.
+ *
+ */
+void msix_free_irq(struct hfi2_devdata *dd, u8 msix_intr)
+{
+	struct hfi2_msix_entry *me;
+
+	if (msix_intr >= dd->msix_info.max_requested)
+		return;
+
+	me = &dd->msix_info.msix_entries[msix_intr];
+
+	if (!me->arg) /* => no irq, no affinity */
+		return;
+
+	hfi2_put_irq_affinity(dd, me);
+	pci_free_irq(dd->pcidev, msix_intr, me->arg);
+
+	me->arg = NULL;
+
+	spin_lock(&dd->msix_info.msix_lock);
+	__clear_bit(msix_intr, dd->msix_info.in_use_msix);
+	spin_unlock(&dd->msix_info.msix_lock);
+}
+
+/**
+ * msix_clean_up_interrupts  - Free all MSIx IRQ resources
+ * @dd: valid device data data structure
+ *
+ * Free the MSIx and associated PCI resources, if they have been allocated.
+ */
+void msix_clean_up_interrupts(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* remove irqs - must happen before disabling/turning off */
+	for (i = 0; i < dd->msix_info.max_requested; i++)
+		msix_free_irq(dd, i);
+
+	/* clean structures */
+	kfree(dd->msix_info.msix_entries);
+	dd->msix_info.msix_entries = NULL;
+	dd->msix_info.max_requested = 0;
+
+	pci_free_irq_vectors(dd->pcidev);
+}
+
+/*
+ * msix_shut_down_interrupts - Free all or most IRQs
+ * @dd: device data structure
+ * @keep_gen: when true, keep general interrupt
+ *
+ * Free all IRQs with the possible exception of the general IRQ.  Retain all
+ * structures.  This should eventually be followed by a call to
+ * msix_clean_up_interrupts().
+ */
+void msix_shut_down_interrupts(struct hfi2_devdata *dd, bool keep_gen)
+{
+	struct hfi2_msix_entry *me;
+	int i;
+
+	/* remove irqs - must happen before disabling/turning off */
+	for (i = 0; i < dd->msix_info.max_requested; i++) {
+		me = &dd->msix_info.msix_entries[i];
+		if (keep_gen && me->type == IRQ_GENERAL)
+			continue;
+		msix_free_irq(dd, i);
+	}
+}
+
+/**
+ * msix_netdev_synchronize_irq - netdev IRQ synchronize
+ * @ppd: valid port data
+ */
+void msix_netdev_synchronize_irq(struct hfi2_pportdata *ppd)
+{
+	int i;
+	int ctxt_count = hfi2_netdev_ctxt_count(ppd);
+
+	for (i = 0; i < ctxt_count; i++) {
+		struct hfi2_ctxtdata *rcd = hfi2_netdev_get_ctxt(ppd, i);
+		struct hfi2_msix_entry *me;
+
+		me = &ppd->dd->msix_info.msix_entries[rcd->msix_intr];
+
+		synchronize_irq(me->irq);
+	}
+}



