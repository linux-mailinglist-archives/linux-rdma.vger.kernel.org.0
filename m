Return-Path: <linux-rdma+bounces-17994-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGNPAW6ssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17994-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:54:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 469152684BD
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F8DF3019FE8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B963E63A1;
	Wed, 11 Mar 2026 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="VO6iM9mn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021078.outbound.protection.outlook.com [52.101.62.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8223E6395
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251687; cv=fail; b=libsJcJkZdvXqa9j/ZcLJRxIHV80dPmtDM8Z/4LzgNy0S/M/EpZpYiI3SDp1vJ1aWTqNvKZf5Sc5Jt495elGmIvaoNk7u+x2SDsGjliSsHeerncZItjoU1gitl9zheIS8PKfVNILsM/Lkff2wNNUPI8ZWIlKP9uD3+/OZ7pWEmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251687; c=relaxed/simple;
	bh=mxfJH+aWCPTgRwCMV6Y3lu+b0ksc391j2Ok5TYHc1Ec=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDYT+v1xoOh6zctNALeQeqr8Mh/w9P3utIbz1jYAVOKSLA98RLQNFWGWNXfZsxut96mYXRghJ+3qKZhxc5rdiN5UP2+nAv6imZzpQMHtRfbEFj3a0/CbrA3ZNZup/QgdE+EoCEO0NgRRv6CJVEPtieOKN+AXS9FKTjqJE65UgIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=VO6iM9mn; arc=fail smtp.client-ip=52.101.62.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDGju3vt+kuUpXdcf+JG08m0Doyi5TqbcCq2zpku7iXMI7TflClWyoHUKsY32vrPs1qIBwAJf6U0WW41yjkq3lxB+yU8vQzYhBtCd7eyM49eCK1ydexbrFgajRfsq4JZ9tI/xcJqD0tDTrKeWIBCcDVcA/4TO7njSp0h3OX1UUypp0ZYh0Ac2crgKUfYmI/VE16ojnl4lTM1xpyTjv9wWp43snUaubdYqDtI0cgN1iIRlydgac/2xMXoSdoXAVzKkvEE36GI6u7dH8irCYr+9kx551Kisu3oem5MQjjNZovkanzpfz1qaS9E6zFx6Aexl0yFvKm8cyuo69ez3aLylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=501R6gy7bckCzzyDO3EZ/BJDJxihElue4MRVHHFktc0=;
 b=VreTrK96NRhyAfQ1BrWuS647J/LNYbgCIslDHGpbmztAvjxwvtI7j3xo4Ood1is8ukdHlEL5v5sksCxZyXQGFBFdIcdFrVuWzzJVgaAed5ulxFw4p3uG6Fz2BxDAR6rhGUbyK0jjKhFgQoCUU1eon3yO9uvIG61aENITodbmKPBw33ibnpEp/DeG+/mB8YnvaHvW6i+p6tIS/HYnoKRT7sD+REeTUQn6OaKtLBVcjHcYsF/ElE63tu/9Bl9fq6JOBNfDHXjEro/M5Adpbqf+h+3m0eY2gIi7deJu56Rlw1icQ9c9KiEdiEWILg8jORqRoWZ1lsTGTOGOkopwSZda3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=501R6gy7bckCzzyDO3EZ/BJDJxihElue4MRVHHFktc0=;
 b=VO6iM9mnw1MseJrmiJ9MR3rnw/+LoOtbRg65HhlOOITB840RCZ+pNfVy3KzH37pEBKXq3kuyldxpuF11ASJ4e4RaU4CMeyGklPaN5QGr9Li+tsZaHY2jJy2TshTxstBlXjgAmvMXw7lob8lcmzkYlrpWKqYLgBK/g6Uez0emnrByOd4usCCVSAqkwoGa70Um2oHwurLNf9IJ6+GKhyhnxZVz9LZwD/uuEshkSeLNevp15b6nR/zFxnspQR+Wj+QsOldnG/mDNe4lApo1a9hvkoI9Vy3DXHy8cZWmOfJRuieTFb7YdDeeQsExohu4UDtLx+VW8CNXsQvkaCwKC8NtJQ==
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by EA2PR01MB994404.prod.exchangelabs.com (2603:10b6:303:2bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Wed, 11 Mar
 2026 17:54:33 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2603:10b6:a03:39c:cafe::c7) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 17:54:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:54:31 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id E1ED814D817;
	Wed, 11 Mar 2026 13:54:30 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id DE39C1810D6C5;
	Wed, 11 Mar 2026 13:54:30 -0400 (EDT)
Subject: [PATCH for-next resend 09/24] RDMA/hfi2: Add initialization and
 firmware support
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:54:30 -0400
Message-ID:
 <177325167086.57064.11403114326044529507.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|EA2PR01MB994404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8151e2-957e-4064-2095-08de7f973fad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|34020700016|55112099003|18082099003|18002099003|56012099003|18092099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	Okzi6MCoaRTeUBWXK2gSoecKpGokMyutA/T3Os5WV+oGHZ5lMusxc3/X4HvVzzCd91SaZo9bjRgnEEsomtL2VZCLqi4Oq03s/yMRESwGZDUiMF7CAaELrw+dRAmu17EvCI40reqMZkBDta1h9KBgqSj8edleK24YS7MvuI3W9dbnt31wnOvzDkIMSVfF1u1ZhOE009QJwQIpfWNg3Fui6z4I/pgF2uTiNFqNLokl5kjVvoH5wTdpyGAsPaqP0fpXELfRkk/G/9pbadbIny6hDZOIYIN15cXRO20jB6kFoMGNzY7ODlZ8yBR4de2pQXZZpUYyA90Ke3k406wTqFAEftiiupoC4h049Cxy8G5KAurA7nPG+COcGvVFbtgwZJ4jorXzawjmnxaxF2oO50cm6pcGkAQQG4LlJ7xpihOrl55fRxPNASh2an+9q3IqtUxwAFwFQFLKghNOUzd6zvzibCIr/uajY9sY4F4mbo6THZNHniIjSC9asXa8sqvB8lARHciKt5qBK0FmurTKu4o7wFcGGTaLPRNr29x1m/P8GGoZRAMh2kTEIVeLB4wiD0+KM8PJumbXhuWptvzZW2YUW/eSblbbBWTfUATjPM2HBSvbXYEFdXUCgtrWzRi69+LKVzjmr45zAnP1HhGSm0EnyT9rsQx2pkh0fzDRtqsp1mDfWEDlt0VebXDDxTOrZgk4pp43l7tMhPDuIm1LmUnsuXfOz0apyUiee94GAC8lVE1pD+mE2P9JyHYmhfPgJV7jJvbapxdctW0oxNqFCYiXVw==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(34020700016)(55112099003)(18082099003)(18002099003)(56012099003)(18092099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P7nm7ts4kehl6McRHcdJSY2qVBC1Ckw3LcFlB6LR4viOhfh5xbtYzSjllMMWP+iibNJ3GsXTfI0K8EpA5zgnT6CjglB8uB+nZ/d9AkU0x1AkYJWkaDUQO9QVT4SNJBd2c60scXpwKbhpiM/lf/yYmmR5HQvHS4PbB/xxvQw5mPJR2gCLggB6uW4baK9KPFVx6Mj7A8vO6oAuzhLhJKQ0HP1iA3qCIIyfyTkRDnuC/ttj4wX+LZnmXq/g/tZi8VrWxDo3ghP0vuJD96SInbC9VvLpUZTX1JcBnrcVEKA1CrCG1jYdU3eb0EuYuBFEXnvtow0NRskY/Ho8pK8eTBBmOg3b71BpTxUxUkK6PalLNyBCTQd1HBQ/4NiradF8LLoVQzHBnHyPAjSkOPAZTl08DymhPWgmM4xAIUBIMf4vdAfURmrVrBR0iIgHckAysobq
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:54:31.6358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8151e2-957e-4064-2095-08de7f973fad
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR01MB994404
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17994-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 469152684BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add device initialization, firmware loading and management, and CPU
affinity support.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/affinity.c | 1194 +++++++++++++
 drivers/infiniband/hw/hfi2/chip.c     |    4 
 drivers/infiniband/hw/hfi2/firmware.c | 2267 ++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/init.c     | 2931 +++++++++++++++++++++++++++++++++
 4 files changed, 6394 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi2/affinity.c
 create mode 100644 drivers/infiniband/hw/hfi2/firmware.c
 create mode 100644 drivers/infiniband/hw/hfi2/init.c

diff --git a/drivers/infiniband/hw/hfi2/affinity.c b/drivers/infiniband/hw/hfi2/affinity.c
new file mode 100644
index 000000000000..8347ab5eb440
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/affinity.c
@@ -0,0 +1,1194 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+	entry = kzalloc_obj(entry, GFP_KERNEL);
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
+	cpu = cpumask_first(non_intr_cpus);
+
+	/* Otherwise, use interrupt CPUs */
+	if (cpu >= nr_cpu_ids)
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
+ * num_comp_vectors needs to have been initialized before calling this function.
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
+	u16 max_krcvq;
+
+	local_mask = cpumask_of_node(dd->node);
+	if (cpumask_first(local_mask) >= nr_cpu_ids)
+		local_mask = topology_core_cpumask(0);
+
+	mutex_lock(&node_affinity.lock);
+	entry = node_affinity_lookup(dd->node);
+
+	max_krcvq = 0;
+	for (i = 0; i < dd->num_pports; ++i) {
+		struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[i];
+
+		if (pr->n_krcv_queues > max_krcvq)
+			max_krcvq = pr->n_krcv_queues;
+	}
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
+			for (i = 0; i < dd->num_pports; i++) {
+				struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[i];
+
+				if (pr->n_krcv_queues)
+					count += pr->n_krcv_queues - 1;
+			}
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
+	/*
+	 * Generic IRQ irq_*() functions have their own internal locking.
+	 * Calling the irq_*() functions while holding node_affinity.lock
+	 * risks deadlock with IRQ affinity updater tasks.
+	 * So unregister the IRQ affinity update handler before acquiring
+	 * node_affinity.lock.
+	 */
+	if (msix->type == IRQ_SDMA)
+		hfi2_cleanup_sdma_notifier(msix);
+
+	mutex_lock(&node_affinity.lock);
+	entry = node_affinity_lookup(dd->node);
+
+	switch (msix->type) {
+	case IRQ_SDMA:
+		set = &entry->def_intr;
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
+	if (cpumask_andnot(diff, available_mask, intrs_mask))
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
+		if (cpumask_andnot(diff, available_mask, intrs_mask))
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
diff --git a/drivers/infiniband/hw/hfi2/chip.c b/drivers/infiniband/hw/hfi2/chip.c
index c9012ea0b970..7547058acb29 100644
--- a/drivers/infiniband/hw/hfi2/chip.c
+++ b/drivers/infiniband/hw/hfi2/chip.c
@@ -12141,13 +12141,13 @@ int wfr_early_per_chip_init(struct hfi2_devdata *dd)
 	if (ret)
 		return ret;
 
-	/* call before get_platform_config(), after init_chip_resources() */
+	/* call before hfi2_get_platform_config(), after init_chip_resources() */
 	ret = eprom_init(dd);
 	if (ret)
 		return ret;
 
 	/* Needs to be called before hfi2_firmware_init */
-	get_platform_config(&dd->pport[HFI2_PORT_IDX]);
+	hfi2_get_platform_config(&dd->pport[HFI2_PORT_IDX]);
 
 	/* read in firmware */
 	ret = hfi2_firmware_init(dd);
diff --git a/drivers/infiniband/hw/hfi2/firmware.c b/drivers/infiniband/hw/hfi2/firmware.c
new file mode 100644
index 000000000000..1a94622ba09e
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/firmware.c
@@ -0,0 +1,2267 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+#define DEFAULT_FW_8051_NAME_ASIC "hfi2_dc8051.fw"
+#define DEFAULT_FW_FABRIC_NAME "hfi2_fabric.fw"
+#define DEFAULT_FW_SBUS_NAME "hfi2_sbus.fw"
+#define DEFAULT_FW_PCIE_NAME "hfi2_pcie.fw"
+#define ALT_FW_8051_NAME_ASIC "hfi2_dc8051_d.fw"
+#define ALT_FW_FABRIC_NAME "hfi2_fabric_d.fw"
+#define ALT_FW_SBUS_NAME "hfi2_sbus_d.fw"
+#define ALT_FW_PCIE_NAME "hfi2_pcie_d.fw"
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
+/* size of file of platform configuration encoded in format version 4 */
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
index 000000000000..70145b643d31
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/init.c
@@ -0,0 +1,2931 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+#include "sriov.h"
+#include "vf2pf.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) DRIVER_NAME ": " fmt
+
+#undef CPORT_TRAP_DEBUG	/* all MCTXT TRAP events from CPORT */
+#define PDEV_SRIOV_DEBUG
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
+	.dma_mask_bits = 48,
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
+	.rsm_rule_size = WFR_RXE_NUM_RSM_INSTANCES,
+	.rsm_rule_offset_shift = WFR_RCV_RSM_CFG_OFFSET_SHIFT,
+	.rsm_map_table_entries = 256,
+	.rsm_map_table_entries_per_csr = 8,
+	.rsm_map_table_entry_mask = 0xff,
+	.rsm_map_table_entry_shift = 8,
+	.qp_map_table_entries = 256,
+	.qp_map_table_entries_per_csr = 8,
+	.qp_map_table_entry_mask = 0xff,
+	.qp_map_table_entry_shift = 8,
+	.pkey_table_size = WFR_MAX_PKEY_VALUES,
+	.generic_boardname = "Cornelis Omni-Path Host Fabric Interface Adapter 100 Series",
+	.max_eager_entries = WFR_MAX_EAGER_ENTRIES,
+	.pio_base_bits = WFR_PIO_BASE_BITS,
+	.pio_base_shift = WFR_SEND_CTXT_CTRL_CTXT_BASE_SHIFT,
+	.egress_err_info_data = &wfr_egress_err_info_data,
+	.send_ctrl_flush = 0, /* no flush flag available */
+	.port_discard_egress_errs = WFR_PORT_DISCARD_EGRESS_ERRS,
+
+	/* interrupt sources */
+	.num_int_csrs = WFR_CCE_NUM_INT_CSRS,
+	.num_int_map_csrs = WFR_CCE_NUM_INT_MAP_CSRS,
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
+	/* cce_interrupt registers */
+	.cce_int_status_reg = WFR_CCE_INT_STATUS,
+	.cce_int_mask_reg = WFR_CCE_INT_MASK,
+	.cce_int_clear_reg = WFR_CCE_INT_CLEAR,
+	.cce_int_force_reg = WFR_CCE_INT_FORCE,
+	.cce_int_blocked_reg = WFR_CCE_INT_BLOCKED,
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
+	.rcv_iport_ctrl_reg = WFR_RCV_CTRL,
+	.rcv_iport_status_reg = WFR_RCV_STATUS,
+	.rcv_bth_qp_reg = WFR_RCV_BTH_QP,
+	.rcv_multicast_reg = WFR_RCV_MULTICAST,
+	.rcv_bypass_reg = WFR_RCV_BYPASS,
+	.rcv_vl15_reg = WFR_RCV_VL15,
+	.rcv_err_info_reg = WFR_RCV_ERR_INFO,
+	.rcv_err_status_reg = WFR_RCV_ERR_STATUS,
+	.rcv_err_mask_reg = WFR_RCV_ERR_MASK,
+	.rcv_err_clear_reg = WFR_RCV_ERR_CLEAR,
+	.rcv_qp_map_table_reg = WFR_RCV_QP_MAP_TABLE,
+	.rcv_partition_key_reg = WFR_RCV_PARTITION_KEY,
+	.rcv_counter_array32_reg = WFR_RCV_COUNTER_ARRAY32,
+	.rcv_counter_array64_reg = WFR_RCV_COUNTER_ARRAY64,
+
+	/* ingress port receive context registers */
+	.rxe_iprc_stride = WFR_RXE_IPRC_STRIDE,
+	.rcv_jkey_ctrl_reg = WFR_RCV_KEY_CTRL,
+
+	/* RXE restricted context registers */
+	.rxe_rctxt_stride = WFR_RXE_RCTXT_STRIDE,
+	.rcv_rctxt_ctrl_reg = WFR_RCV_CTXT_CTRL,
+	.rcv_egr_ctrl_reg = WFR_RCV_EGR_CTRL,
+	.rcv_tid_ctrl_reg = WFR_RCV_TID_CTRL,
+
+	/* RXE kernel context registers */
+	.rxe_kctxt_stride = WFR_RXE_KCTXT_STRIDE,
+	.rcv_kctxt_ctrl_reg = WFR_RCV_CTXT_CTRL,
+	.rcv_hdr_addr_reg = WFR_RCV_HDR_ADDR,
+	.rcv_hdr_cnt_reg = WFR_RCV_HDR_CNT,
+	.rcv_hdr_ent_size_reg = WFR_RCV_HDR_ENT_SIZE,
+	.rcv_hdr_tail_addr_reg = WFR_RCV_HDR_TAIL_ADDR,
+	.rcv_avail_time_out_reg = WFR_RCV_AVAIL_TIME_OUT,
+	.rcv_hdr_ovfl_cnt_reg = WFR_RCV_HDR_OVFL_CNT,
+
+	/* RXE kernel/user registers */
+	.rxe_ku_stride = WFR_RXE_KCTXT_STRIDE,
+	.rcv_ctxt_status_reg = WFR_RCV_CTXT_STATUS,
+
+	/* RXE user registers */
+	.rxe_uctxt_stride = WFR_RXE_UCTXT_STRIDE,
+	.rcv_hdr_tail_reg = WFR_RCV_HDR_TAIL,
+	.rcv_hdr_head_reg = WFR_RCV_HDR_HEAD,
+	.rcv_egr_index_head_reg = WFR_RCV_EGR_INDEX_HEAD,
+	.rcv_tid_flow_table_reg = WFR_RCV_TID_FLOW_TABLE,
+
+	/* RXE RSM registers */
+	.rcv_rsm_cfg_reg = WFR_RCV_RSM_CFG,
+	.rcv_rsm_select_reg = WFR_RCV_RSM_SELECT,
+	.rcv_rsm_match_reg = WFR_RCV_RSM_MATCH,
+	.rcv_rsm_map_table_reg = WFR_RCV_RSM_MAP_TABLE,
+
+	/* TXE kernel registers */
+	.send_contexts_reg = SEND_CONTEXTS,
+	.send_dma_engines_reg = WFR_SEND_DMA_ENGINES,
+	.send_pio_mem_size_reg = WFR_SEND_PIO_MEM_SIZE,
+	.send_dma_mem_size_reg = WFR_SEND_DMA_MEM_SIZE,
+	.send_pio_init_ctxt_reg = WFR_SEND_PIO_INIT_CTXT,
+
+	/* send context_registers */
+	.txe_sctxt_stride = WFR_TXE_SCTXT_STRIDE,
+	.send_ctxt_status_reg = WFR_SEND_CTXT_STATUS,
+	.send_ctxt_credit_ctrl_reg = WFR_SEND_CTXT_CREDIT_CTRL,
+	.send_ctxt_credit_status_reg = WFR_SEND_CTXT_CREDIT_STATUS,
+	.send_ctxt_credit_return_addr_reg = WFR_SEND_CTXT_CREDIT_RETURN_ADDR,
+	.send_ctxt_credit_force_reg = WFR_SEND_CTXT_CREDIT_FORCE,
+	.send_ctxt_err_status_reg = WFR_SEND_CTXT_ERR_STATUS,
+	.send_ctxt_err_mask_reg = WFR_SEND_CTXT_ERR_MASK,
+	.send_ctxt_err_clear_reg = WFR_SEND_CTXT_ERR_CLEAR,
+
+	/* TXE send context registers */
+	.txe_tctxt_stride = WFR_TXE_TCTXT_STRIDE,
+	.send_ctxt_ctrl_reg = WFR_SEND_CTXT_CTRL,
+
+	/* SDMA registers */
+	.txe_sdma_stride = WFR_TXE_SDMA_STRIDE,
+	.send_dma_ctrl_reg = WFR_SEND_DMA_CTRL,
+	.send_dma_status_reg = WFR_SEND_DMA_STATUS,
+	.send_dma_base_addr_reg = WFR_SEND_DMA_BASE_ADDR,
+	.send_dma_len_gen_reg = WFR_SEND_DMA_LEN_GEN,
+	.send_dma_tail_reg = WFR_SEND_DMA_TAIL,
+	.send_dma_head_reg = WFR_SEND_DMA_HEAD,
+	.send_dma_head_addr_reg = WFR_SEND_DMA_HEAD_ADDR,
+	.send_dma_priority_thld_reg = WFR_SEND_DMA_PRIORITY_THLD,
+	.send_dma_idle_cnt_reg = WFR_SEND_DMA_IDLE_CNT,
+	.send_dma_reload_cnt_reg = WFR_SEND_DMA_RELOAD_CNT,
+	.send_dma_desc_cnt_reg = WFR_SEND_DMA_DESC_CNT,
+	.send_dma_desc_fetched_cnt_reg = WFR_SEND_DMA_DESC_FETCHED_CNT,
+	.send_dma_eng_err_status_reg = WFR_SEND_DMA_ENG_ERR_STATUS,
+	.send_dma_eng_err_mask_reg = WFR_SEND_DMA_ENG_ERR_MASK,
+	.send_dma_eng_err_clear_reg = WFR_SEND_DMA_ENG_ERR_CLEAR,
+
+	/* SDMA Config registers */
+	.txe_sdmacfg_stride = WFR_TXE_SDMACFG_STRIDE,
+	.send_dma_cfg_memory_reg = WFR_SEND_DMA_MEMORY,
+
+	/* egress port registers */
+	.txe_eport_stride = 0,
+	.send_ctrl_reg = SEND_CTRL,
+	.send_high_priority_limit_reg = WFR_SEND_HIGH_PRIORITY_LIMIT,
+	.send_egress_err_status_reg = WFR_SEND_EGRESS_ERR_STATUS,
+	.send_egress_err_mask_reg = WFR_SEND_EGRESS_ERR_MASK,
+	.send_egress_err_clear_reg = WFR_SEND_EGRESS_ERR_CLEAR,
+	.send_bth_qp_reg = WFR_SEND_BTH_QP,
+	.send_static_rate_control_reg = WFR_SEND_STATIC_RATE_CONTROL,
+	.send_sc2vlt0_reg = WFR_SEND_SC2VLT0,
+	.send_sc2vlt1_reg = WFR_SEND_SC2VLT1,
+	.send_sc2vlt2_reg = WFR_SEND_SC2VLT2,
+	.send_sc2vlt3_reg = WFR_SEND_SC2VLT3,
+	.send_len_check0_reg = WFR_SEND_LEN_CHECK0,
+	.send_len_check1_reg = WFR_SEND_LEN_CHECK1,
+	.send_low_priority_list_reg = WFR_SEND_LOW_PRIORITY_LIST,
+	.send_high_priority_list_reg = WFR_SEND_HIGH_PRIORITY_LIST,
+	.send_counter_array32_reg = WFR_SEND_COUNTER_ARRAY32,
+	.send_counter_array64_reg = WFR_SEND_COUNTER_ARRAY64,
+	.send_cm_ctrl_reg = WFR_SEND_CM_CTRL,
+	.send_cm_global_credit_reg = WFR_SEND_CM_GLOBAL_CREDIT,
+	.send_cm_credit_used_status_reg = WFR_SEND_CM_CREDIT_USED_STATUS,
+	.send_cm_timer_ctrl_reg = WFR_SEND_CM_TIMER_CTRL,
+	.send_cm_local_au_table0_to3_reg = WFR_SEND_CM_LOCAL_AU_TABLE0_TO3,
+	.send_cm_local_au_table4_to7_reg = WFR_SEND_CM_LOCAL_AU_TABLE4_TO7,
+	.send_cm_remote_au_table0_to3_reg = WFR_SEND_CM_REMOTE_AU_TABLE0_TO3,
+	.send_cm_remote_au_table4_to7_reg = WFR_SEND_CM_REMOTE_AU_TABLE4_TO7,
+	.send_cm_credit_vl_reg = WFR_SEND_CM_CREDIT_VL,
+	.send_cm_credit_vl15_reg = WFR_SEND_CM_CREDIT_VL15,
+	.send_egress_err_info_reg = WFR_SEND_EGRESS_ERR_INFO,
+	.send_egress_err_source_reg = WFR_SEND_EGRESS_ERR_SOURCE,
+	.send_egress_ctxt_status_reg = WFR_SEND_EGRESS_CTXT_STATUS,
+	.send_egress_send_dma_status_reg = WFR_SEND_EGRESS_SEND_DMA_STATUS,
+
+	/* egress port send context registers */
+	.txe_epsc_stride = WFR_TXE_EPSC_STRIDE,
+	.send_ctxt_check_enable_reg = WFR_SEND_CTXT_CHECK_ENABLE,
+	.send_ctxt_check_vl_reg = WFR_SEND_CTXT_CHECK_VL,
+	.send_ctxt_check_job_key_reg = WFR_SEND_CTXT_CHECK_JOB_KEY,
+	.send_ctxt_check_partition_key_reg = WFR_SEND_CTXT_CHECK_PARTITION_KEY,
+	.send_ctxt_check_slid_reg = WFR_SEND_CTXT_CHECK_SLID,
+	.send_ctxt_check_opcode_reg = WFR_SEND_CTXT_CHECK_OPCODE,
+
+	/* SI registers */
+	.cce_msix_int_map_vec_reg = WFR_CCE_INT_MAP,
+	.send_pio_err_status_reg = WFR_SEND_PIO_ERR_STATUS,
+	.send_pio_err_mask_reg = WFR_SEND_PIO_ERR_MASK,
+	.send_pio_err_clear_reg = WFR_SEND_PIO_ERR_CLEAR,
+	.send_dma_err_status_reg = WFR_SEND_DMA_ERR_STATUS,
+	.send_dma_err_mask_reg = WFR_SEND_DMA_ERR_MASK,
+	.send_dma_err_clear_reg = WFR_SEND_DMA_ERR_CLEAR,
+	.csr_err_status_reg = WFR_SEND_ERR_STATUS,
+	.csr_err_mask_reg = WFR_SEND_ERR_MASK,
+	.csr_err_clear_reg = WFR_SEND_ERR_CLEAR,
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
+	.put_tid = wfr_put_tid,
+	.rcv_array_wc_fill = wfr_rcv_array_wc_fill,
+	.set_port_tid_config = wfr_set_port_tid_config,
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
+	.dma_mask_bits = 58,
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
+	.rsm_rule_offset_shift = JKR_RCV_RSM_CFG_OFFSET_SHIFT,
+	.rsm_map_table_entries = 256,
+	.rsm_map_table_entries_per_csr = 8,
+	.rsm_map_table_entry_mask = 0xff,
+	.rsm_map_table_entry_shift = 8,
+	.qp_map_table_entries = 256,
+	.qp_map_table_entries_per_csr = 8,
+	.qp_map_table_entry_mask = 0xff,
+	.qp_map_table_entry_shift = 8,
+	.pkey_table_size = JKR_MAX_PKEY_VALUES,
+	.generic_boardname = "Cornelis Networks 5000 Host Fabric Interface Adapter",
+	.max_eager_entries = JKR_MAX_EAGER_ENTRIES,
+	.pio_base_bits = JKR_PIO_BASE_BITS,
+	.pio_base_shift = JKR_SEND_CTXT_CTRL_CTXT_BASE_SHIFT,
+	.egress_err_info_data = &jkr_egress_err_info_data,
+	.send_ctrl_flush = JKR_SEND_CTRL_FLUSH_WRONG_LINK_STATE_SMASK,
+	.port_discard_egress_errs = JKR_PORT_DISCARD_EGRESS_ERRS,
+
+	/* interrupt sources */
+	.num_int_csrs = JKR_C_CCE_NUM_INT_CSRS,
+	.num_int_map_csrs = JKR_C_CCE_NUM_INT_MAP_CSRS,
+	.is_cport_int = JKR_MCTXT_CPORT_TO_PCIE_INT,
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
+	/* cce_interrupt registers */
+	.cce_int_status_reg = JKR_CCE_INT_STATUS,
+	.cce_int_mask_reg = JKR_CCE_INT_MASK,
+	.cce_int_clear_reg = JKR_CCE_INT_CLEAR,
+	.cce_int_force_reg = JKR_CCE_INT_FORCE,
+	.cce_int_blocked_reg = JKR_CCE_INT_BLOCKED,
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
+	/* RXE RSM registers */
+	.rcv_rsm_cfg_reg = JKR_RCV_RSM_CFG,
+	.rcv_rsm_select_reg = JKR_RCV_RSM_SELECT,
+	.rcv_rsm_match_reg = JKR_RCV_RSM_MATCH,
+	.rcv_rsm_map_table_reg = JKR_RCV_RSM_MAP_TABLE,
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
+	.put_tid = jkr_put_tid,
+	.rcv_array_wc_fill = jkr_rcv_array_wc_fill,
+	.set_port_tid_config = jkr_set_port_tid_config,
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
+MODULE_PARM_DESC(num_user_contexts, "Set max number of user contexts to use per-hfi, per-port (unset or -1: use the real (non-HT) CPU count)");
+
+uint krcvqs[RXE_NUM_DATA_VL];
+int krcvqsset;
+module_param_array(krcvqs, uint, &krcvqsset, 0444);
+MODULE_PARM_DESC(krcvqs, "Array of the number of non-control kernel receive queues by VL");
+
+/* computed based on above array */
+unsigned long n_krcvqs;
+
+static unsigned int hfi2_rcvarr_split = 25;
+module_param_named(rcvarr_split, hfi2_rcvarr_split, uint, 0444);
+MODULE_PARM_DESC(rcvarr_split, "Percent of context's RcvArray entries used for Eager buffers");
+
+static uint eager_buffer_size = (8 << 20); /* 8MB */
+module_param(eager_buffer_size, uint, 0444);
+MODULE_PARM_DESC(eager_buffer_size, "Size of the eager buffers, default: 8MB");
+
+static uint rcvhdrcnt = 2048; /* 2x the max eager buffer count */
+module_param_named(rcvhdrcnt, rcvhdrcnt, uint, 0444);
+MODULE_PARM_DESC(rcvhdrcnt, "Receive header queue count (default 2048)");
+
+static uint hfi2_hdrq_entsize = DEFAULT_HDRQ_ENTSIZE;
+module_param_named(hdrq_entsize, hfi2_hdrq_entsize, uint, 0444);
+MODULE_PARM_DESC(hdrq_entsize, "Size of header queue entries: 2 - 8B, 16 - 64B, 32 - 128B (default)");
+
+unsigned int user_credit_return_threshold = 33;	/* default is 33% */
+module_param(user_credit_return_threshold, uint, 0444);
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
+static int cport_start(struct hfi2_devdata *dd, int to_secs)
+{
+	struct cport_start_payload start = {0};
+	union {
+		struct cport_start_payload pl;
+		u64 qw;
+	} *resp = NULL;
+	int resp_len = 0;
+	int ret;
+
+	start.opts_ena = dd->cport->opts;
+	start.trap_ena = dd->cport->traps;
+
+	ret = cport_send_req(dd, CH_OP_START, 0, &start, sizeof(start),
+			     (void **)&resp, &resp_len, to_secs * HZ);
+	if (ret == MSG_RSP_STATUS_SEQ_NO_ERROR) {
+		dd_dev_info(dd, "CPORT sequence error, retrying\n");
+		ret = cport_send_req(dd, CH_OP_START, 0, &start, sizeof(start),
+				     (void **)&resp, &resp_len, HZ);
+	}
+	if (ret) {
+		dd_dev_err(dd, "CPORT start failed %d\n", ret);
+	} else if (resp_len) {
+		dd_dev_info(dd, "CPORT started %016llx\n", resp->qw);
+		dd->cport->traps_act = resp->pl.trap_ena;
+	} else {
+		dd_dev_info(dd, "CPORT started\n");
+	}
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
+	entry = kzalloc_obj(entry, GFP_KERNEL);
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
+		ret = cport_start(dd, cport_adm_to);
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
+		cport_start(dd, cport_adm_to);
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
+	cport_start(dd, cport_adm_to);
+	cport_register_cb(dd, CH_OP_TRAP, CH_OP_TRAP, NULL);
+	xa_lock_irq(&dd->cport->trap_xa);
+	/* there should be none left, but make certain */
+	xa_for_each(&dd->cport->trap_xa, index, entry) {
+		__xa_erase(&dd->cport->trap_xa, index);
+		dd_dev_info(dd, "removing latent TRAP handler %ps\n", entry->func);
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
+	ret = cport_send_notif(dd, CH_OP_TRAP_REPRESS, 0, &repress, sizeof(repress),
+			       cport_adm_to * HZ);
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
+static void cport_stop(struct hfi2_devdata *dd)
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
+			     (void **)&resp, &resp_len, cport_adm_to * HZ);
+	if (ret)
+		dd_dev_err(dd, "CPORT stop failed %d\n", ret);
+	else if (resp_len)
+		dd_dev_info(dd, "CPORT stopped %016llx\n", *resp);
+	else
+		dd_dev_info(dd, "CPORT stopped\n");
+	kfree(resp);
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
+	/*
+	 * Do a STOP to ensure the device is properly cleaned up.
+	 * This may cause firmware to be unresponsive for awhile,
+	 * so increase the timeout for the subsequent START.
+	 */
+	cport_stop(dd);
+
+	cport_register_cb(dd, CH_OP_TRAP, CH_OP_TRAP, handle_cport_trap);
+
+	dd->cport->opts.bare_metal = 1;
+
+	ret = cport_start(dd, 3 * cport_adm_to);
+	if (ret)
+		cport_exit(dd);
+	return (ret > 0 ? -EIO : ret);
+}
+
+static void stop_cport(struct hfi2_devdata *dd)
+{
+	if (!dd->cport)
+		return;
+
+	cport_stop(dd);
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
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u16 i;
+	u16 j;
+	int ret;
+
+	/*
+	 * so this is making dd->rcd much larger than needed. Unfortunately,
+	 * current code requires that dd->rcd[x].ctxt == x (h/w context number
+	 * must be the same as dd->rcd index number - s/w context number)
+	 * and much code needs to change in order to fix this.
+	 */
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
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		for (j = 0; j < pr->n_krcv_queues; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
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
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		for (j = 0; j < pr->n_krcv_queues; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
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
+	struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[ppd->hw_pidx];
+	unsigned long flags;
+	u16 ctxt = *index;
+	bool found;
+
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	found = false;
+	if (ctxt == DYNAMIC_CONTEXT) {
+		/* look for an unused dynamic context */
+		for (ctxt = pr->first_dyn_alloc_ctxt;
+		     ctxt < pr->rcv_context_base + pr->num_rcv_contexts;
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
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct hfi2_portrsrcs *pr = &dr->ppr[ppd->hw_pidx];
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
+		rcd->eager_base = pr->rcv_array_base +
+				  ((ctxt - pr->rcv_context_base) *
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
+		max_entries = rcd->rcv_array_groups * dd->rcv_entries.group_size;
+		rcvtids = ((max_entries * hfi2_rcvarr_split) / 100);
+		rcd->egrbufs.count = round_down(rcvtids, dd->rcv_entries.group_size);
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
+		if (ctxt < pr->first_dyn_alloc_ctxt) {
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
+	cc_state = kzalloc_obj(cc_state, GFP_KERNEL);
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
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i;
+	int j;
+	struct hfi2_ctxtdata *rcd;
+	/*
+	 * Ensure chip does no sends or receives, tail updates, or
+	 * pioavail updates while we re-initialize.  This is mostly
+	 * for the driver data structures, not chip registers.
+	 */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		for (j = 0; j < pr->num_rcv_contexts; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
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
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
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
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		for (j = 0; j < pr->n_krcv_queues; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
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
+		dd->hfi2_wq = alloc_workqueue("hfi%d",
+					      WQ_SYSFS | WQ_HIGHPRI |
+					      WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
+					      WQ_PERCPU,
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
+			ppd->link_wq = alloc_workqueue("hfi_link_%d_%d",
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
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
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
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		for (i = 0; i < pr->n_krcv_queues; ++i) {
+			u16 ctxt = pr->rcv_context_base + i;
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
+	/*
+	 * so this is making dd->events much larger than needed. Unfortunately,
+	 * uctxt_offset() uses the h/w context number and so all that would
+	 * need to change in order to fix this.
+	 */
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
+		if (ppd->ibport_data.rvp.trap_timer.function)
+			timer_delete_sync(&ppd->ibport_data.rvp.trap_timer);
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
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ctxtdata *rcd;
+	unsigned int pidx;
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
+		vf2pf_deinit_irq(dd); /* gracefully stop using interrupts */
+		/* mask all but the cport interrupt source */
+		set_intr_bits(dd, 0, dd->params->is_cport_int - 1, false);
+		set_intr_bits(dd, dd->params->is_cport_int + 1,
+			      dd->params->is_last_source, false);
+		msix_shut_down_interrupts(dd, true);
+	}
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		ppd = dd->pport + pidx;
+		for (i = 0; i < pr->num_rcv_contexts; i++) {
+			u16 ctxt = pr->rcv_context_base + i;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			hfi2_rcvctrl(dd, HFI2_RCVCTRL_TAILUPD_DIS |
+				     HFI2_RCVCTRL_CTXT_DIS |
+				     HFI2_RCVCTRL_INTRAVAIL_DIS |
+				     HFI2_RCVCTRL_PKEY_DIS |
+				     HFI2_RCVCTRL_ONE_PKT_EGR_DIS, rcd);
+			hfi2_rcd_put(rcd);
+		}
+	}
+	/*
+	 * Gracefully stop all sends allowing any in progress to
+	 * trickle out first.
+	 */
+	for (i = 0; i < dd->num_send_contexts; i++)
+		sc_flush(dd->send_contexts[i].sc);
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
+/*
+ * SRIOV has been disabled. Do any cleanup not handled by
+ * VF remove_one() calls.
+ */
+void hfi2_pf0_cleanup(struct hfi2_devdata *dd)
+{
+	restore_qpmap_table(dd);
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
+ * hfi2_alloc_devdata().
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
+	sdma_clean(dd);
+	hfi2_sriov_free_cfg(dd);
+	/* dd is freed by the time this returns: */
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
+	/*
+	 * Check for PCI device being a VF in SRIOV.
+	 * The VFs do not have a Power Management capability block.
+	 */
+	dd->is_vf = (params->chip_type != CHIP_WFR && !pdev->pm_cap);
+	dd->is_sriov = (dd->is_vf || sriov_is_enabled());
+#if defined(CONFIG_X86)
+	dd->is_vm = boot_cpu_has(X86_FEATURE_HYPERVISOR);
+#endif
+#ifdef PDEV_SRIOV_DEBUG
+	dev_warn(&pdev->dev, "is_vm=%d is_vf=%d is_physfn=%d is_virtfn=%d physfn=%p\n",
+		dd->is_vm, dd->is_vf, pdev->is_physfn, pdev->is_virtfn, pdev->physfn);
+#endif
+	pci_set_drvdata(pdev, dd);
+
+	/*
+	 * Must set DMA mask for device before any dma_map*() or
+	 * dma_alloc*() calls referring to pdev->dev. Otherwise
+	 * those calls may return DMA addresses that are
+	 * incompatible with the HFI.
+	 */
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(params->dma_mask_bits));
+	if (ret) {
+		dd_dev_warn(dd, "Failed to set %u-bit DMA mask ret %d; setting 32-bit DMA mask\n",
+			    params->dma_mask_bits, ret);
+		ret = dma_set_mask_and_coherent(&pdev->dev,
+						DMA_BIT_MASK(32));
+		if (ret) {
+			dd_dev_err(dd, "Unable to set DMA mask: %d\n",
+				   ret);
+			goto bail;
+		}
+	}
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
+	{ PCI_DEVICE(PCI_VENDOR_ID_CORNELIS, PCI_DEVICE_ID_CORNELIS_CN5000) },
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
+	.sriov_configure = hfi2_sriov_configure,
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
+	/*
+	 * This causes devices to be probed, so any initialization
+	 * that must happen before that must be above this point.
+	 */
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
+	vf2pf_deinit(dd); /* still requires CSR access/permissions */
+
+	/* finalize the cport - CSR perms revoked on PF0 */
+	stop_cport(dd);
+	/* release interrupts */
+	msix_clean_up_interrupts(dd);
+
+	/* CSR reads and writes are invalid after this call */
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
+#ifdef CONFIG_HFI_L8SIM
+	if (!(pdev->bus->bus_flags & PCI_BUS_FLAGS_SIMULATED)) {
+		dev_warn(&pdev->dev, "Ignoring real hardware on simulator driver\n");
+		return -ENODEV;
+	}
+#endif
+	/* VF in host driver - leave for KVM */
+	if (pdev->is_virtfn) {
+		/*
+		 * It is theoretically possible for the host driver to claim
+		 * a VF, so the decision whether to claim or not is made by
+		 * hfi2_sriov_init(). Returning ENODEV does not fail SRIOV init.
+		 */
+		ret = hfi2_sriov_init(pdev); /* may do nothing */
+		if (ret)
+			return ret; /* do not claim device */
+	}
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
+		   ent->device == PCI_DEVICE_ID_CORNELIS_CN5000) {
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
+	init_cport_overtemp(dd);
+
+	hfi2_sriov_auto_conf(dd);
+	vf2pf_ready(dd);
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
+/*
+ * This is called for rmmod or other driver-device unbinds.
+ * (and now by shutdown_one() if not WFR)
+ */
+static void remove_one(struct pci_dev *pdev)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+
+	if (pdev->is_virtfn) {
+		/*
+		 * Should only reach here if the VF was claimed by the driver,
+		 * however, this cannot destroy device functionality.
+		 */
+		hfi2_sriov_remove(pdev);
+	}
+
+	/*
+	 * If VFs are still active, must shut them down now,
+	 * before PF0 becomes unusable.
+	 */
+	if (pdev->is_physfn)
+		hfi2_sriov_disable(dd->pcidev);
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
+/*
+ * This is called during system reboot/shutdown/halt.
+ */
+static void shutdown_one(struct pci_dev *pdev)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+
+	if (dd->params->chip_type == CHIP_WFR)
+		shutdown_device(dd);
+	else
+		remove_one(pdev);
+}
+
+/* The device has reported over-temp and will shutdown soon (~500mS) */
+void hfi2_overtemp(struct hfi2_devdata *dd)
+{
+	dd_dev_err(dd, "*** OVER TEMP *** device shutdown imminent!\n");
+	/* take some action to gracefully shut down/quiesce */
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
+	 * Call set_port_tid_config only after eager_base, egrbufs.alloced,
+	 * expected_count, and expected_base are initialized in rcd.  The last
+	 * 3 of the 4 are initialized above in this function.
+	 */
+	dd->params->set_port_tid_config(dd, rcd->ppd->hw_pidx, rcd->ctxt,
+			rcd->eager_base, rcd->egrbufs.alloced,
+			rcd->expected_base, rcd->expected_count);
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
+ * Return number of requested user contexts for the given unit and port based
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



