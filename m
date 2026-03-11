Return-Path: <linux-rdma+bounces-17990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLCnBnussWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:55:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 941712684DC
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A786E30CCC21
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF3C3644DD;
	Wed, 11 Mar 2026 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="VDPjz2gX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021142.outbound.protection.outlook.com [40.107.208.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A673E5ECF
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251669; cv=fail; b=HxK+TsdQYwHwrf/Eshs03kUd5IyRhPR9gqvZM+PshgklwEc4IGKT/tZWO+1qENkMMjc/0K59HwyS54ovSFtQ3b5GjjLBh7/KMCfObqCd5uMUVQhX9hDLdksgK3E2DS4gnlL4BQBY9HhwPzuDD6uCQtamN73jL5T0AL7/J5GAAmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251669; c=relaxed/simple;
	bh=E+TGbQ+f0qXpY/bavkxV4Vi/GlNSByr8R5nituZsH0c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/7pqpTBfRml8oVjvS7Tev6y5pXaGzzgojYx4q9b7BQtW8fWF10iNsX7f4gEJlXNKpGpWvGG/+tPtP3Io5/Tus+7RtlWYNsKz9AiBy5kgeR6q9Ofc8LkpIcZBhBx/5UOAbs+7HI58yS4znIsZR8i/vCEXIh2AeM77xpYzeiO9Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=VDPjz2gX; arc=fail smtp.client-ip=40.107.208.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJvSOjfdGMte/vKDkrqQ1X8pvunJrUMPRXNDJUs2z0/1Ot/iNoRMgu9e08PMftc2qi5cQcoqer0eA1yMsG+AfbXg1twBg1hXH7K1+YIglOcAtyp9IVqghWkgUrU0AEb0NZdDI99WWQ1QABxN9hZFF0UUdCXu4i0Ha25oe6w0bR+xNj32NCqUoEeM5iq9FBjw5OPaHUIyc2zPekgPx1YqAJXME8R81d1nxaD6AdDIXrKzyIQ2koJgqj9ae6ldgGDlpkln/PxFVYBIYaaafCOEqeOIc7xoUbYudTP78oYdM+QpaaiPmXRyYVHVbsEIMI+cisO3yrO4atxbGUwyQSo1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mARDpUdYBJuNfEcvdr4hbyqsC9N+0yAMJJ/E/l8tEKk=;
 b=fZnVp7Hwii8zBxS8vGjyvkBkAOw9r7abYHrPcmR53nvMqxT4acmZ1ya0spIHIIn1X5hJR6p2paAUFw2VpHd8qUEnFnm4N7M8UfxxZbolQtnlzko/IVuhALvIreNzhpJUPEPkTM1xaa0MmgSHha5ruAfSpq/7NZfJwtx6qDvwN7CeA4AZb1NFl38SecgCKTXgoVSAI4Kv+w4lwwKdL3bska8HIWiOk1tjZvq0dtCTz7wOOqM67fK0j2bGFKGzUfdyhpU7aBESAmO23Z0nKgbRnGFIb7R8bsNt1ZFTfchst+yvC2wXzOTzyL9J6ZKVA97XDuGr8qXnUpUj7muNL1SHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mARDpUdYBJuNfEcvdr4hbyqsC9N+0yAMJJ/E/l8tEKk=;
 b=VDPjz2gX3XvrOpW7IeztuarK2xzBiPAOojNN0/4gQGmuiv6tAG1hiwUKNOcI7P7ap2px9zDOEvjQKzlH2B+IS1ftKd88/H6gLb0WI+hN2l7P4xfoqmgxt05oH3wZpHcddH6MXT/3oBx/zEANvOa/3SZuOzfrSnklYF6gGkwYoaC9miOxnxycECrDjVmuUztFja1rSOMxLM07upqR1Oipfupy6D2hYIId9oFgmzB0h7L9juVEdYQ3sV5gBpMrMKgGRMBZ+xiaMqSVWSYvmjQrVHKQo012phlbJrd6OaM7QcfLMS+vvBLbSSrW7ngxSP4sEu5sLT5g2rHBB8ScUp+hLw==
Received: from SJ0PR05CA0024.namprd05.prod.outlook.com (2603:10b6:a03:33b::29)
 by SJ2PR01MB8434.prod.exchangelabs.com (2603:10b6:a03:557::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.13; Wed, 11 Mar 2026 17:54:19 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:33b:cafe::e6) by SJ0PR05CA0024.outlook.office365.com
 (2603:10b6:a03:33b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 17:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:54:21 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id CF9B914D817;
	Wed, 11 Mar 2026 13:54:20 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id C6D451810D6C5;
	Wed, 11 Mar 2026 13:54:20 -0400 (EDT)
Subject: [PATCH for-next resend 07/24] RDMA/hfi2: Add system core header files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:54:20 -0400
Message-ID:
 <177325166078.57064.16035123727786325107.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|SJ2PR01MB8434:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b482000-3560-4b28-f163-08de7f97399f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|82310400026|36860700016|376014|55112099003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	v1eN5oBeG9X3NLHa2sUseEkOhjIWeHCpkPsUnoAsCtBKEK+N+QiewVuzIGzEP7nBbvJAD7vlxuBzsoVpg15QaslATdT8e9IeUJWfVXv36H0LgswycNZQ0kboMrEHEHHbx037l2ve4tPtzWOqryf3shrf1LS2XRQRwBPKcrlqqIPme7f1O9bUtUoK+iWCTjvKNZ3FlF34UGgMoZvEe6q8EgYr46cRB5bbEjlB1hU26pR1rslXYCRVxWRruDR2nnJhseYqIJuj+VsN3S6sefFfaHOxnwzKMTFztgEQLU1Mo66N5DgYsb6U92YbObgrdgdEgcjh8+RygUxfKI6BNv/bzmUHggMrS1CnKzCi4fDR93XZMCEpB11ruL3/V/a4CiEa2vpB16srkYMoupxF92aVEOHv2zrUcZUu5Vc0H4ahL0rIRNWhSFKKaKsT+uL1xywC2zvAZKvwCH8V4dZmxO456riPDuz6jj/r8XF4HQpzx8iyc/0IiS3UMXwxfydlURQhpCfqayy7IwYZ3Z/WeJ1lOCBn9vgaCAIT9dkcvJpKQYheve66LCHzqeeGUTesOE9dtTG163bfR4DEnfV2+dq8pIIYW5ogVAkC7dQVKTjB4lcfLsQ4DBrOx7+YvJKWJM3VMVAuEZ+dvz4FUB2OOQXX0t2Egjmtfom6SSMes4Upx0+Ml4VmwnD8KLUjhaMoeLgiCy57nnw5S7owzx3Xvj87fLngUDDo/PweJr7mIZq2XPBt2idq0RV/69V45CRBWv4tRNSYylFKDFndE1Ox8B2cjA==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:c-50-148-235-34.hsd1.mn.comcast.net;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(82310400026)(36860700016)(376014)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MtoJeWZG1T342qoyEV3L3WC5nwaf20elgE3Ga7d3ph92YGqcbC86zWqcR0/BwyR9ipuX6UDGVwbon8I/bqmXlb3JQ3gBTA5E95W8H49qi8z/dt2bb+x8kNssGqJdcVvYTlk+SWZxIe7tbN5NiAThWUQCFLxwLtQjy7xXjJDYhk/AaRKOzgiTGMliT0SqPmEzQf7cxWmwFkFFNG/Ffe8PX0/s46NxExuhpLG86zg1Zr9gzS+PO5Vd6pys/9gQ2ZaBF0ifB4FwZ/qqTTNy8wRclq1FXHcEgm6mN27J+COnBW9cEpR9c2nWi4ze+rRfd5ST0PAB78l0+7gS1Wgd4Tm79Ch8w9FKTVlazYuiWaXIJqsoAF0U12QmPMsD0pRv+c9Jn5p0+3hLiPi+SelGeLhg2PXKu1TzweQZ70LNyaqAKOfPgYhKUMD8wuxgnJFLIxkr
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:54:21.4940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b482000-3560-4b28-f163-08de7f97399f
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8434
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17990-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
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
X-Rspamd-Queue-Id: 941712684DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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



