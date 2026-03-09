Return-Path: <linux-rdma+bounces-17820-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMUAIzkzr2kPQQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17820-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:53:13 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F11FC24126F
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34E4A307D61A
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80418368965;
	Mon,  9 Mar 2026 20:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="JB0otCVk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020094.outbound.protection.outlook.com [52.101.61.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C99284663
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089473; cv=fail; b=sN5d727uv3Wc/4iDaANGuTlcRPp398AbHVD7zdx7g4GwPuL/xkD9ZQ6HiHuSJ5BxMTwKBq1ur6ghbhj1a9mfP2hAPX+f4iwK5/K78kqHx+c1rEUQ4JlEB2jC8irYQeZxciSIwJbc5qzOATRHwbKqy6agW8IssNs5E0wjHXsK4uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089473; c=relaxed/simple;
	bh=E+TGbQ+f0qXpY/bavkxV4Vi/GlNSByr8R5nituZsH0c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ii0x3eKQVx5OO5jVrGHCxMZanzyev50sA9LhbL87otsKTQvOtaNm6wpM15gBBHs+1VQ0yiHzuzeCe7VV64RaDYDO7dEULFVyvbtNhQewsgDyw47SLECaNjEU3LfiJ1EOPQzP3LibpRM0f+2mbV9Us0WRAnWTRb9kHKvsDESYFY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=JB0otCVk; arc=fail smtp.client-ip=52.101.61.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbB/gfYMDbeEgGxa52er6HqVmB43trA3iHJa3kakrUKIEgou+7RjWy4wJk/I3IzRFHhW7JOv2XCxhDRA3uj5f7iqYZJQ1NeGcf+aZ86GL/bDhwqtuAde3XQZ9bGORw3q+aROLy7RhARnI8ZmRBR5BHnN1TpadpoctPy9+5LN7niJ5+lBpA9FX4ZcrYFOLXpQnnijMRuNpXboITBjWAG+aCHbwsL8Z0enMoGIcHsfl5xheHRphgZ2vvkG94s5ZQ72Jsm9Rna72CpCuQbiPlsPCwX7aCnCzxwuUjnOtQ9MzpH0n1WarS3hru5QFiM+DutoToJKjzZUKxwtOtAX/DsYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mARDpUdYBJuNfEcvdr4hbyqsC9N+0yAMJJ/E/l8tEKk=;
 b=slmiZEfGEbuOfdw5eQpXlLMpA3RndEvLijyQ1fbNK4NEMeAnEKZXifmKyJRihaYKN8902dML9dC63BWcQiVftBu2B7l3lOCc/G9vofTUF/mZrD+tRWc46dGSiPQDdAV/5i8OKQq9R3BO31KwvtIPmjZJIGBf8kgC6HfY+lc9BDRZOYunTLYael/VbSYqyIqwVEOP4UVe1b5w52VnvkzAyn1RyvS6Fi+fGMs7TsjNbBytmsaxp81beuIsYjpalFKfrR1XDjWXCl3W5XM+xxuJtWRZdK3v21Nb3hdvIgbR1Du7MzzSAJdiG5Lt2mx1YzT9Ykh0ddTlaHCQ1gwDwXqb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mARDpUdYBJuNfEcvdr4hbyqsC9N+0yAMJJ/E/l8tEKk=;
 b=JB0otCVkFa1EyQgboIsd8bsSbXrYDU89TjWf38s4HXGAbgWxlkBMKeI8iJ+7pdCXo7jsRRjttpNIqRjBgkdK94+HuHAwnrk+/6Eq/P68WK5a03GTpQHSBxG3Tqp5bVyLnGb1IfP/rFfoBVPtUiU71J7KIjiShd9w6qd6G1vLgw/+src+iUfDSSpZQ7Iqxbl8ad/L9N5Uoywhx6vA/xsMMBMjjVz+KxJCSDVhVhqcF937hTHL4DTpQdpBtSd9kjVnzMukDYDs5qdC7ZrdoWkbuVIIDlNTkjx3QB6gWNucyFnen1n/utwW2AxWA6kN6HMhksq+KE9genZ3rJjFQNeVbQ==
Received: from SA1PR05CA0024.namprd05.prod.outlook.com (2603:10b6:806:2d2::27)
 by DM4PR01MB7545.prod.exchangelabs.com (2603:10b6:8:5c::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.25; Mon, 9 Mar 2026 20:51:03 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::40) by SA1PR05CA0024.outlook.office365.com
 (2603:10b6:806:2d2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 20:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 20:51:02 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 02E5714D715;
	Mon,  9 Mar 2026 16:51:02 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id F2F0A1810D6D7;
	Mon,  9 Mar 2026 16:51:01 -0400 (EDT)
Subject: [PATCH for-next 07/24] RDMA/hfi2: Add system core header files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Mon, 09 Mar 2026 16:51:01 -0400
Message-ID:
 <177308946194.1280641.11467627580342324692.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177308916470.1280641.1779641444229092453.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177308916470.1280641.1779641444229092453.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DM4PR01MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: a7057a70-d0fc-4e37-4509-08de7e1d938a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	xuCfV028PK8yMbXhiNS4QZvORs39naT4bDMb229NA532/lYfSM3XFr1UZQp7puzel9C2zhCTt0+DmBYByXUie0vgESsZmOPyCwUg+4zOVTT7rK0qYqUz/Gih8RjYHeuJLkEeSfj4v3RCSjDpPafVo9Laa0MgulcSn9YnQ2W1OerZ59+UpzlNFvrF1T01LLuvycjWoKugMEKqZ/ThLCGv9cFHz3iGoOIII/Wc2fOaYx0tjwNQ3d5hOYRI0c9HPhSC+Xt4IZlGf6GjToIdra/VaGysWGdSmNcVQ6fV+bYJCuwmtO+BMmHMPDzYwSH0Dz/PGoYxK6CqFkVTwREfCv2Nt/OCCbSWnD4dU2O4EkVy/emNSLBWwFFmXK/pKSSZcmE/LN4bW9/vM4t+ynFGjJIMNnH5PG7t/jtLX86eJDVKInwCNOG2UXy+5dcy29hzgGQZ1K5zorx9dJPVWkIlFaieO8xzLkEYg8HGq+QER8JWMTvNTbeqT9l85uFxFr49DpDQ9PlX7DSpbFr2v0/S/Bf/euPngPmkytsyX4r/dSRguhvL5vV1Gjr9tpVU4z4j4DX5kbLgnFLRhZAoGxUl6f6J7T1BRguwBg3jwO2+R2V+eW/NzmXeLILJ6hGWDY2NFy8T3UNhIpJX6CkXims7m9fIZ3UrTosGOm6dQ+MqYvhNl9tteDVeNOcx19DohmxdqtIdWCb0xXNEmfT6f4ydRETl+EYPJIkPoagIxC7AmFzCuT4YabVgbdVBkodZQaEOYvPloX5gHrV3FdMrXW5PXTv3IA==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	v+/a8xQ/SDUtr7VrsGwc1+BGCgssM9ZP/EOM4nHdsqhVUjeLbxStjNY2vzrl6oXkawDWyM5tmCVHLgFjqJoeXdyUkTitozsaBsJoh3t16XBpEsULkcm4SVkguqVC9/ZhO6RJWVhQq+pDzlUMNPZFgeLefVFzGwsGr8nnCy5yuav9+qaAWyLSddnH4KGg6hBHKG6No5Z0c6qTkxN/bofgesqP89vJOI9jionylUSHZcsLU+dQkLcakWcDABpfHgm1gFa3a8ah/LtSd6r0CXHZAM661f7Ayj857r9nRb3TgRfvfs0N85BnsPPw01RD+kTJXW6x5tCrTH835JfKXnCCGUeqKtJBggcuns6utAdjcaJ5pfKTJY0VU8r3dY2t+gYQLBTt4G4stLtmX3xjK8CxzVd5QNAN4BZmN1uisO9rkPbn7xK34atYjFks1odJz6Vt
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:51:02.5864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7057a70-d0fc-4e37-4509-08de7e1d938a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7545
X-Rspamd-Queue-Id: F11FC24126F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17820-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:dkim,cornelisnetworks.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,awdrv-04.cornelisnetworks.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add header files for hooking into the core system, things like IRQs and
affinity.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/affinity.h |   86 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/aspm.h     |   36 ++++++++++++++
 drivers/infiniband/hw/hfi2/efivar.h   |   17 +++++++
 drivers/infiniband/hw/hfi2/eprom.h    |   11 ++++
 drivers/infiniband/hw/hfi2/mmu_rb.h   |   78 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/msix.h     |   31 ++++++++++++
 6 files changed, 259 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.h
 create mode 100644 drivers/infiniband/hw/hfi2/aspm.h
 create mode 100644 drivers/infiniband/hw/hfi2/efivar.h
 create mode 100644 drivers/infiniband/hw/hfi2/eprom.h
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.h
 create mode 100644 drivers/infiniband/hw/hfi2/msix.h

diff --git a/drivers/infiniband/hw/hfi2/affinity.h b/drivers/infiniband/hw/hfi2/affinity.h
new file mode 100644
index 000000000000..26f8cb63550b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/affinity.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
index 000000000000..22e850b23e4c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/aspm.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015-2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
diff --git a/drivers/infiniband/hw/hfi2/efivar.h b/drivers/infiniband/hw/hfi2/efivar.h
new file mode 100644
index 000000000000..b38db9dbdafa
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/efivar.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
index 000000000000..7926e9e6d7c3
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/eprom.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+struct hfi2_devdata;
+
+int eprom_init(struct hfi2_devdata *dd);
+int eprom_read_platform_config(struct hfi2_devdata *dd, void **buf_ret,
+			       u32 *size_ret);
diff --git a/drivers/infiniband/hw/hfi2/mmu_rb.h b/drivers/infiniband/hw/hfi2/mmu_rb.h
new file mode 100644
index 000000000000..05a277f44582
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/mmu_rb.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ * Copyright(c) 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
index 000000000000..57c42f89af27
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/msix.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2018 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+int msix_request_irq_remap(struct hfi2_devdata *dd, u16 ctxt,
+			   enum irq_type type, int src,
+			   irq_handler_t handler, irq_handler_t thread,
+			   void *arg, const char *name);
+
+/* Netdev interface */
+void msix_netdev_synchronize_irq(struct hfi2_pportdata *ppd);
+int msix_netdev_request_rcd_irq(struct hfi2_ctxtdata *rcd);
+
+#endif



