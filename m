Return-Path: <linux-rdma+bounces-22517-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ubI7H4v5P2qUawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22517-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C16D2405
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=QChBjRpW;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22517-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22517-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9160530104BF
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0515623AB87;
	Sat, 27 Jun 2026 16:25:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020097.outbound.protection.outlook.com [52.101.56.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56102874F5
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:25:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577539; cv=fail; b=qWjMkT5oMWvzbCfzY3RYKpnl11Ei0xdVkdzDYUI1ieCO2ici9xPAtPGT6mkZ6TtEhyi5kXPGTP4gaBB3+QC4QL7cexc1cvISSdpckMjHgp718nzTGIa+2KzIc9ZmU45X/0LQBtl2lSeJpcm0mPb7lzUVfuXvYFQ8jV1wwtgqM08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577539; c=relaxed/simple;
	bh=orxHCbtotBmYTsj/GqqfvfDE6bDnwwm24m3A8w2v6N0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ttm0pUZhD7MB78/u4DuV4eIw1I7yFZuWyu5bhKJMBe/BoR4N+dUbFSVzE+DIkjWNv8/Bcc5ARfslkPAmqLeBTYx1C7Y0Bqrhv5qARZS95dJu5F+PQSAjUywcEN6xpDjTLTV6v7+/GAVYkC5vXuT7ubcqa3EGtb6oZ/CB1d1khl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=QChBjRpW; arc=fail smtp.client-ip=52.101.56.97
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qwzGLn80260k++BfVXRMr7Vt7nHbc77p8cFdvfBaj4v6CNEqzvqproYv2vkFWnqV6GO0DucTI1uQJoehVxeB74bmiY+RpLEVVZpoEDdpggyyTTScXS+bJEILnaIKEvqffC3cy+9oqmVhW7uHfCzjSHedBlbovX+BA7gfMK35ABxKIB5v6v0qQUEe5/U4l459ynDYZ6EF86lTzrK8kqxBU8IWZPiUS3fb0QyDUbOsGczKQnSh6xRzKjfeDMdlHvMbW8rxaAwtACGvUTaPdcRzWlBvoOuXYUVjpl9jtzwPn5UZ60LWNqTlpmJFu9amHVQWV8+HPEgQ0U7xJNmhCdIlcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKyfJbc2ddiQvKYvTV1vy0YAIw2vMueJuYbed1lUaRo=;
 b=rhv6D7Bc4W+Q/BCk2yS54egoJR0IAZDsHDBMSB6rYXhNF2pRVLiIfDD68CfsmnYwJJQonYTzuj9GDzzMM+c9+Osme2M7nM0JoIfmfTI1vbRmEbkot1kUIVq99xUCMLVofq8r4zggSoHbP2TiNky9HG4BeEOI1ST/dRJROMsHzVlhcmPF6VSWnqA2sKnY1+4L+1qHF1Y8xcR3x2WfpyH30u7TTehdPUp8Z00Gy/yXOjIbOflwQlacoEVsjcNsc289LBdZ6TWtK+wq2Bp/Mrg4PGdlCZ8lilByHpC80lwY+LClj8SybDhrNqTb301VCHTHXU2GTB1HBd1VOLzUSeA2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKyfJbc2ddiQvKYvTV1vy0YAIw2vMueJuYbed1lUaRo=;
 b=QChBjRpWQJ/BevFKZSipINBROuFvCmcoKiCbTR+7HWBZnvk87/UXG++Uc/dDaihUvB3Dl6qz5HOw+YLXgj3/hUJnGHsx+nWEi6p8VG+GxZMIb8chBB5ltfvMbbzgGJIxc6ewhw51c95WbdaZxMnV9ezglEi0JTMctJ2VcAd7qOOTUZJUNi8HyflWbFaoNMTjikp1s7II6ManDDtS8aaBCB+2T/m61h6xonCBYmZhlgEhk2aAoztRe78cHLGEZkbxuA1yDg7arK32sIVEMEv0KNt9kPMdABa4WbDLrdJM1gJ7jDLin3Q/wlHgKCgeSDG8qoh8fJzKVQnWVvReED7aPA==
Received: from CH2PR20CA0023.namprd20.prod.outlook.com (2603:10b6:610:58::33)
 by PH0PR01MB6296.prod.exchangelabs.com (2603:10b6:510:a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.18; Sat, 27 Jun 2026 16:25:31 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::68) by CH2PR20CA0023.outlook.office365.com
 (2603:10b6:610:58::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 16:25:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:25:30 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id D96D9146565;
	Sat, 27 Jun 2026 12:25:29 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id D4DB51810D6C7;
	Sat, 27 Jun 2026 12:25:29 -0400 (EDT)
Subject: [PATCH v2 for-next 07/24] RDMA/hfi2: Add system core header files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:25:29 -0400
Message-ID: <178257752983.371918.4101342968739560536.stgit@awdrv-04>
In-Reply-To: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
References: <178257721001.371918.6610421101075283586.stgit@awdrv-04>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|PH0PR01MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: 443d3c79-7b4c-44ee-944c-08ded468b47e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|56012099006|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H5RFe/gKN90SBKxvrc1Q1zkqxTVb+viB5Y0Qacvg5+nMD1QKgOQ5p4AZKU8yubMtkpjnXXbmyAIBm/CTZLUu2LdOQPF7002XehufgOzioB/3bDQPnGr9T3PV/JBSYZveUIRfjvri+XkqajtlzWZzaMNBXcMiEzdWiOrhLyYXWuVvak6fdtEvaPfTvk6hsx+TlX5jw4VNtbFi1sWV6RXRJttgGEoOO6Uf/RP67Hw5GeY3zdTHpfZp/tL80otsVMpK2pPwJ7/GdUzhNdwUUfx0xdEQ4nCGDDLVPd0EY2JTeye4ZxzaprL/GoNvAZmYpVu3oW7EmZIKxdwWOd/TEzls5YMgLprB7F25PYRRj/v4TunKeROfmBNU3DbXXpEOVLD5j1cVphowXgF02PHWurc5BYSy0P4Ygc3kTYBpAjOUeTG892IKG6MyqYTuzm99Mw1719MnG4205tspoxmqLT2jLQO9ZcYNPzyCfBAwQkEEm9XBG0czOq6ZvkBNFSzoL7qxHe4xWSEVe5TbzIzcGi+imJDOno8sy0d+7k/H7Wb7Oua/ZD3owwvHIxW6xiXjfeLrFChQtZ0vDi6stzPV1Xuksfu+1ADvnPdQUFbtMt5tFTn1a4fFhDi8yfPhjePQxqh5Y4E0N+WRvjyzWCsdzsEzrypDhQWRzDjLAli+/upeGyxFCguu46xXDxtNrd9+Gw10
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(56012099006)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IhqcvXqJfvcgo/BhX7wAa3eB8XVYLPIDaaxghzkb+vyoDy9dIxUKFr9Egl9YNwGzie/IVUOpL9WpA0bvBJLVkNVzP87rRxFTj83+4NtWDQHmQVKMCpLbpkdkl9EfHYRvjg2OKxubqbuzHqckQYt0TLaA/1n2RgQgQ6Zh4E0g7W1/9PtzCpiyRMhByshxrM075ud6bqUepxTaJxBTcHTrIImZ9Od0yPMZ1cuyYjzT1QN4hUyDAZm9DpAauW6vJK2cICsUEg32Me2BXHzmxSace+he5OVgycjdwl+i4LxQG73wNgi36NQ7PrT2+lFReE306tle7eYA+Ia5UDS0iQmp0CRGkiCJ9U32Va4fTqRPH1ewlGXeMYTmCSYXUcaDm24+sMEgqYZIM/evb+3Bm55ZoXd2X6ZC/T3GNJ6rTIXScG4nMbeZrtsiyUJToSxsaezP
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:25:30.1979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443d3c79-7b4c-44ee-944c-08ded468b47e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6296
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22517-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:brendan.cunningham@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,awdrv-04:mid];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 312C16D2405

Add header and support files for hooking into the core system, things
like IRQs. Includes mmu_rb.c for MMU range-based invalidation support
used by the expected receive and TID RDMA subsystems.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
  Changes since v3:
    - Address Leon's feedback (Re: v1 patch 07, Mar 17 2026): remove
      the affinity-management policy code from the driver. CPU and IRQ
      affinity belong in user space (irqbalance, sched_setaffinity, and
      /proc/irq/.../smp_affinity). As a result affinity.h is no longer
      added; enum irq_type is relocated to msix.h where it belongs.
    - Address Leon's feedback (Re: v1 patch 08, Mar 18 2026): remove
      the custom ASPM implementation. ASPM is managed at the PCIe core
      layer (pcie_aspm= cmdline) and the driver should not duplicate
      this functionality. As a result aspm.h is no longer added.
---
 drivers/infiniband/hw/hfi2/efivar.h |   17 ++
 drivers/infiniband/hw/hfi2/eprom.h  |   11 +
 drivers/infiniband/hw/hfi2/hfi2.h   |    1 
 drivers/infiniband/hw/hfi2/mmu_rb.c |  344 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/mmu_rb.h |   78 ++++++++
 drivers/infiniband/hw/hfi2/msix.h   |   32 +++
 6 files changed, 482 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/hfi2/efivar.h
 create mode 100644 drivers/infiniband/hw/hfi2/eprom.h
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.c
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.h
 create mode 100644 drivers/infiniband/hw/hfi2/msix.h

diff --git a/drivers/infiniband/hw/hfi2/efivar.h b/drivers/infiniband/hw/hfi2/efivar.h
new file mode 100644
index 000000000000..a756758034ec
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
+int hfi2_read_hfi2_efi_var(struct hfi2_devdata *dd, const char *kind,
+		      unsigned long *size, void **return_data);
+
+#endif /* _HFI2_EFIVAR_H */
diff --git a/drivers/infiniband/hw/hfi2/eprom.h b/drivers/infiniband/hw/hfi2/eprom.h
new file mode 100644
index 000000000000..b6bb0dcc03c2
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
+int hfi2_eprom_init(struct hfi2_devdata *dd);
+int hfi2_eprom_read_platform_config(struct hfi2_devdata *dd, void **buf_ret,
+			       u32 *size_ret);
diff --git a/drivers/infiniband/hw/hfi2/hfi2.h b/drivers/infiniband/hw/hfi2/hfi2.h
index d3dcf4b0a5a4..a7882177b8cb 100644
--- a/drivers/infiniband/hw/hfi2/hfi2.h
+++ b/drivers/infiniband/hw/hfi2/hfi2.h
@@ -43,7 +43,6 @@ struct hfi2_devrsrcs;
 #include "mad.h"
 #include "qsfp.h"
 #include "platform.h"
-#include "affinity.h"
 #include "msix.h"
 #include "cport.h"
 #ifdef CONFIG_HFI_L8SIM
diff --git a/drivers/infiniband/hw/hfi2/mmu_rb.c b/drivers/infiniband/hw/hfi2/mmu_rb.c
new file mode 100644
index 000000000000..7ebdc5ab691c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/mmu_rb.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ * Copyright(c) 2016 - 2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/mmu_notifier.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/sched/mm.h>
+
+#include "mmu_rb.h"
+#include "trace.h"
+
+static unsigned long mmu_node_start(struct mmu_rb_node *);
+static unsigned long mmu_node_last(struct mmu_rb_node *);
+static int mmu_notifier_range_start(struct mmu_notifier *,
+		const struct mmu_notifier_range *);
+static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *,
+					   unsigned long, unsigned long);
+static void release_immediate(struct kref *refcount);
+static void handle_remove(struct work_struct *work);
+
+static const struct mmu_notifier_ops mn_opts = {
+	.invalidate_range_start = mmu_notifier_range_start,
+};
+
+INTERVAL_TREE_DEFINE(struct mmu_rb_node, node, unsigned long, __last,
+		     mmu_node_start, mmu_node_last, static, __mmu_int_rb);
+
+static unsigned long mmu_node_start(struct mmu_rb_node *node)
+{
+	return node->addr & PAGE_MASK;
+}
+
+static unsigned long mmu_node_last(struct mmu_rb_node *node)
+{
+	return PAGE_ALIGN(node->addr + node->len) - 1;
+}
+
+static int _hfi2_mmu_rb_register(void *ops_arg,
+				 const struct mmu_rb_ops *ops,
+				 struct workqueue_struct *wq,
+				 struct mmu_rb_handler **handler,
+				 const struct mmu_notifier_ops *mnops)
+{
+	struct mmu_rb_handler *h;
+	void *free_ptr;
+	int ret;
+
+	free_ptr = kzalloc(sizeof(*h) + cache_line_size() - 1, GFP_KERNEL);
+	if (!free_ptr)
+		return -ENOMEM;
+
+	h = PTR_ALIGN(free_ptr, cache_line_size());
+	h->root = RB_ROOT_CACHED;
+	h->ops = ops;
+	h->ops_arg = ops_arg;
+	INIT_HLIST_NODE(&h->mn.hlist);
+	spin_lock_init(&h->lock);
+	h->mn.ops = &mn_opts;
+	INIT_WORK(&h->del_work, handle_remove);
+	INIT_LIST_HEAD(&h->del_list);
+	INIT_LIST_HEAD(&h->lru_list);
+	h->wq = wq;
+	h->free_ptr = free_ptr;
+
+	ret = mmu_notifier_register(&h->mn, current->mm);
+	if (ret) {
+		kfree(free_ptr);
+		return ret;
+	}
+
+	*handler = h;
+	return 0;
+}
+
+int hfi2_mmu_rb_register(void *ops_arg,
+			 const struct mmu_rb_ops *ops,
+			 struct workqueue_struct *wq,
+			 struct mmu_rb_handler **handler)
+{
+	return _hfi2_mmu_rb_register(ops_arg, ops, wq, handler, &mn_opts);
+}
+
+void hfi2_mmu_rb_unregister(struct mmu_rb_handler *handler)
+{
+	struct mmu_rb_node *rbnode;
+	struct rb_node *node;
+	unsigned long flags;
+	struct list_head del_list;
+
+	/* Prevent freeing of mm until we are completely finished. */
+	mmgrab(handler->mn.mm);
+
+	/* Unregister first so we don't get any more notifications. */
+	mmu_notifier_unregister(&handler->mn, handler->mn.mm);
+
+	/*
+	 * Make sure the wq delete handler is finished running.  It will not
+	 * be triggered once the mmu notifiers are unregistered above.
+	 */
+	flush_work(&handler->del_work);
+
+	INIT_LIST_HEAD(&del_list);
+
+	spin_lock_irqsave(&handler->lock, flags);
+	while ((node = rb_first_cached(&handler->root))) {
+		rbnode = rb_entry(node, struct mmu_rb_node, node);
+		rb_erase_cached(node, &handler->root);
+		/* move from LRU list to delete list */
+		list_move(&rbnode->list, &del_list);
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	while (!list_empty(&del_list)) {
+		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&rbnode->list);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
+
+	/* Now the mm may be freed. */
+	mmdrop(handler->mn.mm);
+
+	kfree(handler->free_ptr);
+}
+
+int hfi2_mmu_rb_insert(struct mmu_rb_handler *handler,
+		       struct mmu_rb_node *mnode)
+{
+	struct mmu_rb_node *node;
+	unsigned long flags;
+	int ret = 0;
+
+	trace_hfi2_mmu_rb_insert(mnode);
+
+	if (current->mm != handler->mn.mm)
+		return -EPERM;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
+	if (node) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+	__mmu_int_rb_insert(mnode, &handler->root);
+	list_add_tail(&mnode->list, &handler->lru_list);
+	mnode->handler = handler;
+unlock:
+	spin_unlock_irqrestore(&handler->lock, flags);
+	return ret;
+}
+
+/* Caller must hold handler lock */
+struct mmu_rb_node *hfi2_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr, unsigned long len)
+{
+	struct mmu_rb_node *node;
+
+	trace_hfi2_mmu_rb_search(addr, len);
+	node = __mmu_int_rb_iter_first(&handler->root, addr, (addr + len) - 1);
+	if (node)
+		list_move_tail(&node->list, &handler->lru_list);
+	return node;
+}
+
+/* Caller must hold handler lock */
+static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
+					   unsigned long addr,
+					   unsigned long len)
+{
+	struct mmu_rb_node *node = NULL;
+
+	trace_hfi2_mmu_rb_search(addr, len);
+	if (!handler->ops->filter) {
+		node = __mmu_int_rb_iter_first(&handler->root, addr,
+					       (addr + len) - 1);
+	} else {
+		for (node = __mmu_int_rb_iter_first(&handler->root, addr,
+						    (addr + len) - 1);
+		     node;
+		     node = __mmu_int_rb_iter_next(node, addr,
+						   (addr + len) - 1)) {
+			if (handler->ops->filter(node, addr, len))
+				return node;
+		}
+	}
+	return node;
+}
+
+/*
+ * Must NOT call while holding mnode->handler->lock.
+ * mnode->handler->ops->remove() may sleep and mnode->handler->lock is a
+ * spinlock.
+ */
+static void release_immediate(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	trace_hfi2_mmu_release_node(mnode);
+	mnode->handler->ops->remove(mnode->handler->ops_arg, mnode);
+}
+
+/* Caller must hold mnode->handler->lock */
+static void release_nolock(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	queue_work(mnode->handler->wq, &mnode->handler->del_work);
+}
+
+/*
+ * struct mmu_rb_node->refcount kref_put() callback.
+ * Adds mmu_rb_node to mmu_rb_node->handler->del_list and queues
+ * handler->del_work on handler->wq.
+ * Does not remove mmu_rb_node from handler->lru_list or handler->rb_root.
+ * Acquires mmu_rb_node->handler->lock; do not call while already holding
+ * handler->lock.
+ */
+void hfi2_mmu_rb_release(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	struct mmu_rb_handler *handler = mnode->handler;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+	queue_work(handler->wq, &handler->del_work);
+}
+
+void hfi2_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
+{
+	struct mmu_rb_node *rbnode, *ptr;
+	struct list_head del_list;
+	unsigned long flags;
+	bool stop = false;
+
+	if (current->mm != handler->mn.mm)
+		return;
+
+	INIT_LIST_HEAD(&del_list);
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
+		/* refcount == 1 implies mmu_rb_handler has only rbnode ref */
+		if (kref_read(&rbnode->refcount) > 1)
+			continue;
+
+		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
+					&stop)) {
+			__mmu_int_rb_remove(rbnode, &handler->root);
+			/* move from LRU list to delete list */
+			list_move(&rbnode->list, &del_list);
+			++handler->internal_evictions;
+		}
+		if (stop)
+			break;
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
+		trace_hfi2_mmu_rb_evict(rbnode);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
+}
+
+unsigned long hfi2_mmu_rb_for_n(struct mmu_rb_handler *handler,
+				unsigned long start, int count,
+				void (*fn)(const struct mmu_rb_node *rb_node, void *),
+				void *arg)
+{
+	struct mmu_rb_node *node = NULL, *next;
+	int i;
+
+	next = __mmu_int_rb_iter_first(&handler->root, start, ~0ULL - start);
+	for (i = 0; i < count; i++) {
+		node = next;
+		if (!node)
+			return ~0UL;
+
+		next = __mmu_int_rb_iter_next(node, start + node->len, ~0ULL);
+		fn(node, arg);
+	}
+	return node->addr;
+}
+
+static int mmu_notifier_range_start(struct mmu_notifier *mn,
+		const struct mmu_notifier_range *range)
+{
+	struct mmu_rb_handler *handler =
+		container_of(mn, struct mmu_rb_handler, mn);
+	struct rb_root_cached *root = &handler->root;
+	struct mmu_rb_node *node, *ptr = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
+	     node; node = ptr) {
+		/* Guard against node removal. */
+		ptr = __mmu_int_rb_iter_next(node, range->start,
+					     range->end - 1);
+		trace_hfi2_mmu_mem_invalidate(node);
+		/* Remove from rb tree and lru_list. */
+		__mmu_int_rb_remove(node, root);
+		list_del_init(&node->list);
+		kref_put(&node->refcount, release_nolock);
+		handler->external_evictions++;
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return 0;
+}
+
+/*
+ * Work queue function to remove all nodes that have been queued up to
+ * be removed.  The key feature is that mm->mmap_lock is not being held
+ * and the remove callback can sleep while taking it, if needed.
+ */
+static void handle_remove(struct work_struct *work)
+{
+	struct mmu_rb_handler *handler = container_of(work,
+						struct mmu_rb_handler,
+						del_work);
+	struct list_head del_list;
+	unsigned long flags;
+	struct mmu_rb_node *node;
+
+	/* remove anything that is queued to get removed */
+	spin_lock_irqsave(&handler->lock, flags);
+	list_replace_init(&handler->del_list, &del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	while (!list_empty(&del_list)) {
+		node = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&node->list);
+		trace_hfi2_mmu_release_node(node);
+		handler->ops->remove(handler->ops_arg, node);
+	}
+}
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
index 000000000000..8d17b1613dc5
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/msix.h
@@ -0,0 +1,32 @@
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
+enum irq_type { IRQ_SDMA, IRQ_RCVCTXT, IRQ_NETDEVCTXT, IRQ_GENERAL, IRQ_OTHER };
+
+/* MSIx interface */
+int hfi2_msix_initialize(struct hfi2_devdata *dd);
+int hfi2_msix_early_request_irqs(struct hfi2_devdata *dd);
+int hfi2_msix_request_irqs(struct hfi2_devdata *dd);
+void hfi2_msix_clean_up_interrupts(struct hfi2_devdata *dd);
+void hfi2_msix_shut_down_interrupts(struct hfi2_devdata *dd, bool keep_general);
+int hfi2_msix_request_general_irq(struct hfi2_devdata *dd);
+int hfi2_msix_request_rcd_irq(struct hfi2_ctxtdata *rcd);
+int hfi2_msix_request_sdma_irq(struct sdma_engine *sde);
+void hfi2_msix_free_irq(struct hfi2_devdata *dd, u8 msix_intr);
+int hfi2_msix_request_irq_remap(struct hfi2_devdata *dd, u16 ctxt,
+			   enum irq_type type, int src, irq_handler_t handler,
+			   irq_handler_t thread, void *arg, const char *name);
+
+/* Netdev interface */
+void hfi2_msix_netdev_synchronize_irq(struct hfi2_pportdata *ppd);
+int hfi2_msix_netdev_request_rcd_irq(struct hfi2_ctxtdata *rcd);
+
+#endif



