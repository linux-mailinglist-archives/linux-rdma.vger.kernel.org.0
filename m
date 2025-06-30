Return-Path: <linux-rdma+bounces-11769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D86AEE632
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EA47A2140
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ECA2E6124;
	Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="THLerhqB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2128.outbound.protection.outlook.com [40.107.236.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF18293B5A
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306295; cv=fail; b=rsNS1E28jHwJpKaN45GoK3B/uPCMbjJxEWEhpfnuSB53DADwHS4nY/SM95vziaLXwt0fcuSlGp6BUWnLBmbFOQvvnswRjd9Iq6BbPXUaPEMQ7SUc8py/1AAD08X99ImJnxDuFaYEe397F5vtlHVYiTJ+y20QOQqDSpB/ffmG9Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306295; c=relaxed/simple;
	bh=16r/4AUgkbszjtqYnidqbTRt/WdYbxcmjPylxNwTjY8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUoK+Em6gPTTMspYWgZl0dzRc53mNdMm5yj6Z6nhsLzwLJi0oB2SXv3WE6osKIh+fHXq9yx5shzFCxbbLk15rtxLhnrk16qv53Int35dJy15+EkcPWjy/XxqnvuMdQcgpGsrC5yda4RcvlYcv0/Ew8p/yRktW5PRz9ks40AcV9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=THLerhqB; arc=fail smtp.client-ip=40.107.236.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/BGe2vEDQMh3+G0njE6RgO4g2vID+NOSe6eb4aqBp+lVoAIXnpq6Ndli8Ozf6DB5mnMNqDcDZIu0edXCIxXmBsxNQVdkfoP/ZUL70TeKJO8OCcVDBgtUHn65UUTFsc/50soCf/h8rrHLNHRjEhLV5E/YkYwR7S4m4+APpBNmJ2Qq+rY0vrm4KkcF/MxTtgps3SbZHm/D15/iapQC7eRldCzF1MmSptXJ5crAANTLA3Dp0TuiqJXBi/nuAZ3mMxQ4J8vwYrorQ/6heKLBi18zw/OmlJb9G2GQw5/XOO9v3w9NWsZEpzpv2FsEDw0jWGvV6Rj2/OAz9rjIxzv1NFSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r10f4GzA/SgM9ZjKBZJKGPcMwIrCxty/3/6Bh86GIY=;
 b=i2Dr6LtYbavzSfcmw4UjKzZ2bKE/Qca6HW4MU4BFRpQ0zkTO6imc2wTxyWVyGfAtPj4GyD5oWtmzfZdvaxYBypTNi4/JxagCY1q2T5Cyq1eSDIjfQZ2WQ2fMXRmXh5K+0Xsd5DlJTr5qlSq6UabJyOQl4NSfG6BpKeUuuUkOUGt45EzRloAT+OB4/pkUrNDkGVIUVbE3LroWQ+XihB7V6LnGt2gf08bo5Fm6huOstQb8j/FSj0gYWPJR94GqItT5XU6FQeuPGeiRDBMVO5p1pdntmflG1tE2Trylk7lPYzdrar0VJDu/IZ7Hjblak61xt/kLgzOW3wG33bkc7T/kVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r10f4GzA/SgM9ZjKBZJKGPcMwIrCxty/3/6Bh86GIY=;
 b=THLerhqB9GjmaJ16RGrNCRWBPHuNsDnXgRJ0DRlBmmG6MLs5NqyVp4FjNDZ5ndTMF7TcztHEhTsIR7fNAVg9ZnNFlh6zUgf82jScuIgz1v6YlCvLlHoERCQp+JYiTTaz1IYiaI96n9AMXfYU2mohVEKrR7oBB/Jf3+zkdARTzIz8vONTa84ARCGlAOeLmxbe3psVA6EtFv7PaaddVjs8F58+fnX2P6ZB34g6hErodlp+s0KwzDNed0oxEl5s7SdERF3ndJBuFs07rBeVIAGzLoDHfxhBMVinEyeri/0DQgLMhZaNRemmisr0oji1/2hdy0htngeh60bMHdE51PsLcQ==
Received: from PH7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::20)
 by BY3PR01MB6513.prod.exchangelabs.com (2603:10b6:a03:363::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.27; Mon, 30 Jun 2025 17:58:10 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::ac) by PH7P222CA0017.outlook.office365.com
 (2603:10b6:510:33a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 17:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:09 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id CDB9B14D725;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 6B0F91848B5D6;
	Mon, 30 Jun 2025 11:30:53 -0400 (EDT)
Subject: [PATCH for-next 13/23] RDMA/hfi2: Add system core header files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:53 -0400
Message-ID:
 <175129745337.1859400.18028867979647760264.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BY3PR01MB6513:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1e3f0b-34a7-485c-213e-08ddb7ffac88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ek1XVlZHYklhWUdhYU1CL2NWS0tCSU9la3p5bTZpaHVNZnQ5ckJRMEhSZFRz?=
 =?utf-8?B?Umk5WDIwNW51VVlVMmZlcjViNDR5cmwwQ3h6QW1IblpvckZYNEx0K3Z6N2RC?=
 =?utf-8?B?LzBaY0ZucGE5aVRzYzN6cklJcHJxNmZ4dnprcTkxRjB1bDFIYUhuM2MzV3NS?=
 =?utf-8?B?dG1ndmZzbFJKZHJwbWY5L0pFaGtiekM0UzFOYlJ2K2htM0oydjVOUnI1SVFU?=
 =?utf-8?B?U0doYld1bVo2M2huOTg5VFVlK0NPcW8xa1RwMld6ai9yRHFBTDJYenJYK2VW?=
 =?utf-8?B?STRmSEVxQmpKNk9VbVFFVFQwWEpNYVZUWWFTTG1KaDJyZmFGbGY1ek9FOG82?=
 =?utf-8?B?c093ZGxRTytBQnpSV0xXOGZoWkNXWlFmWURjaUQ3Sm5jRmlGQi93VmpIR2ZZ?=
 =?utf-8?B?M2pSK0lpemIyVXVxdjZoN2ZFU3UrVTUwS3RZWjJzaDVqbldmaUFnS2xSUTJL?=
 =?utf-8?B?cldHN2NMZlo5eExXTW1jamF1WUJuQlR6S25xWjgwc3lsN21BOW1Bb2JCaHY3?=
 =?utf-8?B?OU5YTjFXQzhpUWp1QU03bitmOWR6ZVExWEo1bHB0Q3dvTWZKUXVNeUNEQmx5?=
 =?utf-8?B?WVhpUjZWdWdQUXRUWDMrS1l5aFhtVDNOcTNqRjFUbUZPNUhjZ3YxMlhLelhF?=
 =?utf-8?B?QTlJVEF4YnNFL09oZzlMalB2ZmxiVUtuRXI1T3hGK0taZjJOdFowUVh5OGtr?=
 =?utf-8?B?ZDZrN3lFcUJSSCtMRC9pK0oxVzQ5L29EWXZaTkRJOTR4M1Z0T2Z6Sk5GRlgz?=
 =?utf-8?B?T294S3NEcWFYNGtaVDBjVWo3cVZtYzFYSzNQMlkvUTUzOHJnc0IzKy9iNitV?=
 =?utf-8?B?UGlFVVFXOGJ6REt3bVVHNjRXVWUxQktjc0pBcFJuOTF2L2pFRThQVkJUbXdR?=
 =?utf-8?B?QzdSdXdOLzY3ZEx0TndHcUtpT1NJb0VQcjBvc1kwVlRKYUtUWXVJaU1wdjlj?=
 =?utf-8?B?d3pRZ09YYnN1cjk5VWVwS1lKaG5KSFROc1ZuQWdiQVVDN2xnWXRrNTUwOVY4?=
 =?utf-8?B?a0x4bE9UZlBCVkJuNnZzNzR3dWxYQkkyamFDNVQ4OVRRNDJ6Yjkwc3Vwb3ZJ?=
 =?utf-8?B?RVB2NEVlcFRSWmRDSi9xcEUxa2dnbFhIVnRheE5hQ3R2Q21XMHk3SGZwSUlL?=
 =?utf-8?B?Uzl5dUhoK2I2a3F4QmE2QitZMndmUFRJS1IwSHFWNUoxWTV4T3lzRkxrZmg1?=
 =?utf-8?B?TFRhbFdrYnA1eUlGZDBUWDdaVWZ5U0c1WlFJQ3hCSlhwY2JtczBXejAxVi9z?=
 =?utf-8?B?bFoycjlJbWVta2tkK0cyR29UWjh4dmRtbGlXZXZmbjVlaG16QWRBYm9GRE9u?=
 =?utf-8?B?UlZYWlc4b0tqNU81emRTbjdnREl4cHZYZjJXZ2F6b1dlbG5nT2tXQkR0QkhH?=
 =?utf-8?B?V1lhOGd1dWFPaUJuWjdZTFJMWCs0Z3dFSEJmNkt0Rk43Y3Ywbm04WXVsQ1FS?=
 =?utf-8?B?b2xvYU9ZbTFhZnphZForL3JZRnlYYlhiY1B2ajBtVXVjUzlLbnhuRXBVOVgr?=
 =?utf-8?B?emtvSmxDUlRBZyt5S0RXQlpYU0IwUUM2Q2kxK3pvWVdYSVg2SWVTci9nU2RU?=
 =?utf-8?B?STk1L2dsN1MzcXpvbWF3eFI0L0Nvc2FTWFVCdUd6R25XNW5lb0dteXJiaGNr?=
 =?utf-8?B?Y21xbDdmYmkyamxueGxZRzlHQm5FRGpVbmZpcFBzOUNGYSswdDZTL2d6OFhI?=
 =?utf-8?B?czQrTms0QkxaTFI4c2ZlV3diWmFWakhFbjl6dVVlQXplNU1JWTJTVERTRk1i?=
 =?utf-8?B?KzBZYkswN1U5NFI4c2wraGluWExPUDdWSk12TFhvUmNtOEJ2bjlERWxaZHJj?=
 =?utf-8?B?czJiL0J4L3JrYU5JcnBTRE90VnNQdVo5dWVZUHBTTWY1SWR0d1p6L3VEemVq?=
 =?utf-8?B?UnlxWEtLdFVNV2JxOUNYRUFKTHV6M0ZxM0VVZ0dIV21GNS8wejAreG9oZFEv?=
 =?utf-8?B?SlNtTG5zZE5obHhvTUdOeGduaWY5WllGdzlTNkVad1NmUlJqdmJqZ0pRNHlu?=
 =?utf-8?B?WXIzRmk5WSt5dDh5d05zUW1TSDRRRU8zdUw3T2lhKzJ1VGovM1hhdW9FbFM2?=
 =?utf-8?Q?Obflly?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:09.4138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1e3f0b-34a7-485c-213e-08ddb7ffac88
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6513

Add header files for hooking into the core system, things like IRQs and
affinity.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/affinity.h |   85 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/aspm.h     |   35 ++++++++++++++
 drivers/infiniband/hw/hfi2/device.h   |   18 +++++++
 drivers/infiniband/hw/hfi2/efivar.h   |   16 ++++++
 drivers/infiniband/hw/hfi2/eprom.h    |   10 ++++
 drivers/infiniband/hw/hfi2/mmu_rb.h   |   77 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/msix.h     |   26 ++++++++++
 7 files changed, 267 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
 create mode 100644 drivers/infiniband/hw/hfi2/aspm.h
 create mode 100644 drivers/infiniband/hw/hfi2/device.h
 create mode 100644 drivers/infiniband/hw/hfi2/efivar.h
 create mode 100644 drivers/infiniband/hw/hfi2/eprom.h
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.h
 create mode 100644 drivers/infiniband/hw/hfi2/msix.h

diff --git a/drivers/infiniband/hw/hfi2/affinity.h b/drivers/infiniband/hw/hfi2/affinity.h
new file mode 100644
index 000000000000..36a55767e324
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/affinity.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ */
+
+#ifndef _HFI2_AFFINITY_H
+#define _HFI2_AFFINITY_H
+
+#include "hfi2.h"
+
+enum irq_type {
+	IRQ_SDMA,
+	IRQ_RCVCTXT,
+	IRQ_NETDEVCTXT,
+	IRQ_GENERAL,
+	IRQ_OTHER
+};
+
+/* Can be used for both memory and cpu */
+enum affinity_flags {
+	AFF_AUTO,
+	AFF_NUMA_LOCAL,
+	AFF_DEV_LOCAL,
+	AFF_IRQ_LOCAL
+};
+
+struct cpu_mask_set {
+	struct cpumask mask;
+	struct cpumask used;
+	uint gen;
+};
+
+struct hfi2_msix_entry;
+
+/* Initialize non-HT cpu cores mask */
+void init_real_cpu_mask(void);
+/* Initialize driver affinity data */
+int hfi2_dev_affinity_init(struct hfi2_devdata *dd);
+/*
+ * Set IRQ affinity to a CPU. The function will determine the
+ * CPU and set the affinity to it.
+ */
+int hfi2_get_irq_affinity(struct hfi2_devdata *dd,
+			  struct hfi2_msix_entry *msix);
+/*
+ * Remove the IRQ's CPU affinity. This function also updates
+ * any internal CPU tracking data
+ */
+void hfi2_put_irq_affinity(struct hfi2_devdata *dd,
+			   struct hfi2_msix_entry *msix);
+/*
+ * Determine a CPU affinity for a user process, if the process does not
+ * have an affinity set yet.
+ */
+int hfi2_get_proc_affinity(int node);
+/* Release a CPU used by a user process. */
+void hfi2_put_proc_affinity(int cpu);
+
+struct hfi2_affinity_node {
+	int node;
+	u16 __percpu *comp_vect_affinity;
+	struct cpu_mask_set def_intr;
+	struct cpu_mask_set rcv_intr;
+	struct cpumask general_intr_mask;
+	struct cpumask comp_vect_mask;
+	struct list_head list;
+};
+
+struct hfi2_affinity_node_list {
+	struct list_head list;
+	struct cpumask real_cpu_mask;
+	struct cpu_mask_set proc;
+	int num_possible_nodes;
+	struct mutex lock; /* protects affinity nodes */
+};
+
+int node_affinity_init(void);
+void node_affinity_destroy_all(void);
+extern struct hfi2_affinity_node_list node_affinity;
+void hfi2_dev_affinity_clean_up(struct hfi2_devdata *dd);
+int hfi2_comp_vect_mappings_lookup(struct rvt_dev_info *rdi, int comp_vect);
+int hfi2_comp_vectors_set_up(struct hfi2_devdata *dd);
+void hfi2_comp_vectors_clean_up(struct hfi2_devdata *dd);
+
+#endif /* _HFI2_AFFINITY_H */
diff --git a/drivers/infiniband/hw/hfi2/aspm.h b/drivers/infiniband/hw/hfi2/aspm.h
new file mode 100644
index 000000000000..c62251bbc018
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/aspm.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015-2017 Intel Corporation.
+ */
+
+#ifndef _ASPM_H
+#define _ASPM_H
+
+#include "hfi2.h"
+
+extern uint aspm_mode;
+
+enum aspm_mode {
+	ASPM_MODE_DISABLED = 0,	/* ASPM always disabled, performance mode */
+	ASPM_MODE_ENABLED = 1,	/* ASPM always enabled, power saving mode */
+	ASPM_MODE_DYNAMIC = 2,	/* ASPM enabled/disabled dynamically */
+};
+
+void aspm_init(struct hfi2_devdata *dd);
+void aspm_exit(struct hfi2_devdata *dd);
+void aspm_hw_disable_l1(struct hfi2_devdata *dd);
+void __aspm_ctx_disable(struct hfi2_ctxtdata *rcd);
+void aspm_disable_all(struct hfi2_devdata *dd);
+void aspm_enable_all(struct hfi2_devdata *dd);
+
+static inline void aspm_ctx_disable(struct hfi2_ctxtdata *rcd)
+{
+	/* Quickest exit for minimum impact */
+	if (likely(!rcd->aspm_intr_supported))
+		return;
+
+	__aspm_ctx_disable(rcd);
+}
+
+#endif /* _ASPM_H */
diff --git a/drivers/infiniband/hw/hfi2/device.h b/drivers/infiniband/hw/hfi2/device.h
new file mode 100644
index 000000000000..8948b9a48ac4
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/device.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ */
+
+#ifndef _HFI2_DEVICE_H
+#define _HFI2_DEVICE_H
+
+int hfi2_cdev_init(int minor, const char *name,
+		   const struct file_operations *fops,
+		   struct cdev *cdev, struct device **devp,
+		   bool user_accessible,
+		   struct kobject *parent);
+void hfi2_cdev_cleanup(struct cdev *cdev, struct device **devp);
+int __init dev_init(void);
+void dev_cleanup(void);
+
+#endif                          /* _HFI2_DEVICE_H */
diff --git a/drivers/infiniband/hw/hfi2/efivar.h b/drivers/infiniband/hw/hfi2/efivar.h
new file mode 100644
index 000000000000..cd252647d229
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/efivar.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ */
+
+#ifndef _HFI2_EFIVAR_H
+#define _HFI2_EFIVAR_H
+
+#include <linux/efi.h>
+
+#include "hfi2.h"
+
+int read_hfi2_efi_var(struct hfi2_devdata *dd, const char *kind,
+		      unsigned long *size, void **return_data);
+
+#endif /* _HFI2_EFIVAR_H */
diff --git a/drivers/infiniband/hw/hfi2/eprom.h b/drivers/infiniband/hw/hfi2/eprom.h
new file mode 100644
index 000000000000..a3e871e5c6e9
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/eprom.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ */
+
+struct hfi2_devdata;
+
+int eprom_init(struct hfi2_devdata *dd);
+int eprom_read_platform_config(struct hfi2_devdata *dd, void **buf_ret,
+			       u32 *size_ret);
diff --git a/drivers/infiniband/hw/hfi2/mmu_rb.h b/drivers/infiniband/hw/hfi2/mmu_rb.h
new file mode 100644
index 000000000000..f503ea43640b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/mmu_rb.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2020 Cornelis Networks, Inc.
+ * Copyright(c) 2016 Intel Corporation.
+ */
+
+#ifndef _HFI2_MMU_RB_H
+#define _HFI2_MMU_RB_H
+
+#include "hfi2.h"
+
+struct mmu_rb_node {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long __last;
+	struct rb_node node;
+	struct mmu_rb_handler *handler;
+	struct list_head list;
+	struct kref refcount;
+};
+
+/* filter and evict must not sleep. Only remove is allowed to sleep. */
+struct mmu_rb_ops {
+	bool (*filter)(struct mmu_rb_node *node, unsigned long addr,
+		       unsigned long len);
+	void (*remove)(void *ops_arg, struct mmu_rb_node *mnode);
+	int (*evict)(void *ops_arg, struct mmu_rb_node *mnode,
+		     void *evict_arg, bool *stop);
+};
+
+struct mmu_rb_handler {
+	/*
+	 * struct mmu_notifier is 56 bytes, and spinlock_t is 4 bytes, so
+	 * they fit together in one cache line.  mn is relatively rarely
+	 * accessed, so co-locating the spinlock with it achieves much of
+	 * the cacheline contention reduction of giving the spinlock its own
+	 * cacheline without the overhead of doing so.
+	 */
+	struct mmu_notifier mn;
+	spinlock_t lock;        /* protect the RB tree */
+
+	/* Begin on a new cachline boundary here */
+	struct rb_root_cached root ____cacheline_aligned_in_smp;
+	void *ops_arg;
+	const struct mmu_rb_ops *ops;
+	struct list_head lru_list;
+	struct work_struct del_work;
+	struct list_head del_list;
+	struct workqueue_struct *wq;
+	size_t hits;
+	size_t misses;
+	size_t hint_hits;
+	size_t hint_misses;
+	size_t internal_evictions;
+	size_t external_evictions;
+	void *free_ptr;
+};
+
+int hfi2_mmu_rb_register(void *ops_arg,
+			 const struct mmu_rb_ops *ops,
+			 struct workqueue_struct *wq,
+			 struct mmu_rb_handler **handler);
+void hfi2_mmu_rb_unregister(struct mmu_rb_handler *handler);
+int hfi2_mmu_rb_insert(struct mmu_rb_handler *handler,
+		       struct mmu_rb_node *mnode);
+void hfi2_mmu_rb_release(struct kref *refcount);
+
+void hfi2_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg);
+struct mmu_rb_node *hfi2_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr,
+					  unsigned long len);
+unsigned long hfi2_mmu_rb_for_n(struct mmu_rb_handler *handler,
+				unsigned long start, int count,
+				void (*fn)(const struct mmu_rb_node *rb_node, void *),
+				void *arg);
+
+#endif /* _HFI2_MMU_RB_H */
diff --git a/drivers/infiniband/hw/hfi2/msix.h b/drivers/infiniband/hw/hfi2/msix.h
new file mode 100644
index 000000000000..f11a7e6b5fe2
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/msix.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2018 - 2020 Intel Corporation.
+ */
+
+#ifndef _HFI2_MSIX_H
+#define _HFI2_MSIX_H
+
+#include "hfi2.h"
+
+/* MSIx interface */
+int msix_initialize(struct hfi2_devdata *dd);
+int msix_early_request_irqs(struct hfi2_devdata *dd);
+int msix_request_irqs(struct hfi2_devdata *dd);
+void msix_clean_up_interrupts(struct hfi2_devdata *dd);
+void msix_shut_down_interrupts(struct hfi2_devdata *dd, bool keep_general);
+int msix_request_general_irq(struct hfi2_devdata *dd);
+int msix_request_rcd_irq(struct hfi2_ctxtdata *rcd);
+int msix_request_sdma_irq(struct sdma_engine *sde);
+void msix_free_irq(struct hfi2_devdata *dd, u8 msix_intr);
+
+/* Netdev interface */
+void msix_netdev_synchronize_irq(struct hfi2_pportdata *ppd);
+int msix_netdev_request_rcd_irq(struct hfi2_ctxtdata *rcd);
+
+#endif



