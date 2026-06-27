Return-Path: <linux-rdma+bounces-22518-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wf7LAI/5P2qVawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22518-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE186D240A
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:25:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=AZBhZelV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22518-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22518-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09B6F3004D20
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E0F2DEA68;
	Sat, 27 Jun 2026 16:25:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020099.outbound.protection.outlook.com [52.101.46.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7DC23AB87
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:25:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577546; cv=fail; b=VO5efFc7loB8Vp5Ol0oH5k9PmMFa6zsBOb7mztKwfoTnYZFNd/XO+JdKxIBo4Tf3omYHxsessqVF6Ua5iaUp/leOYV9SJc/MZJNczSoVvchmobDMQhCdwhHqivU4SdDX6ZokUEthr1wJdXvq1M4+8NfMW9q9LQ/x5m/zdJMkpzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577546; c=relaxed/simple;
	bh=LJpyjXQjPVsfrbeDa6v1QhE+PzjCtDesu3rgiY81MkU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gk8nWdE31n0JCPu2BIwJ2I4SQw/FX89KM+BdFG1FfjFQLYMgXpwksivPJTbgOiQTOFUIWDQpCHm2OnbA0yOZGEGtPWdalWSIPS53UhTZf7mqXh2z91EdeUfqVwG31CIrKaBWEZTFF/sxnhjr0mhR1HeXOlGaqDNIYJU5DJwpBSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=AZBhZelV; arc=fail smtp.client-ip=52.101.46.99
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKf/4vnDMJYYHQDkRiV/Qaf27Je8NZGdDX12JvedI6V6BA3corgnvTFULD5Si/EXnWiy/ALoMKXuaxkSFJHNL0E/eI3SbXjxyanLZuPtJWyC+C++7uvDI7CePcE0W4AGYmaDEVz9hOwDm0PjraqP44bX2iG/aStNSujQ6lkCPT+ZS4D2ls2CXmsile+F1mdy2eZXI9KrtkYswVC2JJyBKHKmw0qW4jOyf32lUnpY2gUtgWFkCYn91MkgXOtN4B2Pai9vek4wQ5/QDROpe1Hh6JIDiU47hN3gWDKzaaQCn3uX3pjqbgQ8e26UyTOsfbAEoxHLRhP+c2aj2VFMHynTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WP+gBrLWEv+ZHjbppRIcUuBg5xT7QECm3nzlnPqjhc=;
 b=n94zFcR9gSYmbBD2aHVR2Kt71ay7LIIO6THU8ciYesEK2f/xY63jNi82oPtRmTCT9k+hSAMJan534NDRnZOGYme7TZUF0qNpb54kCz1rCSGXl4l4c88+ZSpnerMkyWTOlukStqr140eGBH9Bt4EAEF3DSJcOp/sMu0GCZtiYSMycostyqQRLi+nUatvC5nvFS4mnjluvsavqAIu6b7YZMK+qz8SImsM96iEnufedqvXtxLEGBGNI44LtD6f5dptNvvF7uShwpldl0ttircQdsBRHGcUYllBbU7pB+/XB4zdVaz3vD385N9Rqxt/MBMVkQHk4+7a3hwjq+qtOZv6RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WP+gBrLWEv+ZHjbppRIcUuBg5xT7QECm3nzlnPqjhc=;
 b=AZBhZelVoDbLIE0Uc2sBX3+lUYnMdfbgFY0eZL8DLNPxBRXckkvXqoIjFgglyy9r6LBAR2OmJnzm4zJgJwZSDX0Yi09dz1r738jlNOsL+pQdtb33728X0SEyRaECylLGkyjoj+DGn2uDbihCElJST70uTQ2IxWmd+bIqfUpj8/IriZ2naiCGyArYHrqP2WOv2lwudSFbG7y6Pg3aZ7rFjD+8oa/IbdKD7rsBL7N5EoumEVnV7nC2I2fWkLUGPuNcXX6uUgWEK+aCq90eyo6uCmhvmo7jWPJuI9F1COCqjE1T8zD49Pp7bSQuhzu1J25Yocon4ZVErEMvGt+0rVABpA==
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by SA6PR01MB8830.prod.exchangelabs.com (2603:10b6:806:433::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.18; Sat, 27 Jun 2026 16:25:37 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::97) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sat, 27
 Jun 2026 16:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:25:35 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id E5985146565;
	Sat, 27 Jun 2026 12:25:34 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id E143A1810D6C7;
	Sat, 27 Jun 2026 12:25:34 -0400 (EDT)
Subject: [PATCH v2 for-next 08/24] RDMA/hfi2: Add driver and interrupt
 infrastructure
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:25:34 -0400
Message-ID: <178257753487.371918.8409512790281994518.stgit@awdrv-04>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|SA6PR01MB8830:EE_
X-MS-Office365-Filtering-Correlation-Id: a7841529-dfb2-4289-6585-08ded468b7c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|6133799003|56012099006|5023799004|55112099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2gI2CFUGlh+RADBadcanMMdKvu/+1maVDIZh3PEbT4plvm8TOWTWT5aEjF/4LYQAshUAPraSQzDxi+VGnyLpOcXnQE8Fiup/Lv+9HPOuUUVCh9QBBM0kojN14uXvnk+RiRBxTuPEBiKSid9mmvLDOmy46J0KLP7Nb3oHUwaxc/WsTvsLw14jjz9RN6H3jFoUXE13y57fxofAchvWiTr9JGgKYoFn4xVrST9qtEIBe2z+0i25O2mqRE0QMRsuS+f+1ZlUqJ9ITuHZ0CKeiry+5oZowyWVpUWJS1F/Nfm1VS1DodkiDAmsg6GAL+LixGQelikskQ4fiN3SWnVx1k63annaAPxPYUrYCz8C4kZgHJjSWQOusMY2F+0TAjEm32wwGEzLrE7D1FwkxNPnPI8JN1LY924JUKsM4W3wSjapF3OCsEYhcG5myZYVUYUiZZjlBBuzPJk4t/wdqIBixFkCOfyWJA5nBvbaxSLjRP/ylrBbR73pwqGJds2aI+4Pm6iOnDFbfblc2Q2tPTZm0ZNztCxfBGKxJcKca4Bv2VMa4bZdkTKjd2xwMT0FrHU+MUeBvWJexKtFlCWEIiZXZ/2KGgr8Lhk/UnDNt6W6WVlqNQKJJe7C13c8AYhwUAYlskaitNSfJYgkHMSGR0ppAbQB4yCzTP9wcySZqrvMtTyULvq/+V6Dyahj2Ygt24qBk1rpt8ti/N6qfWrrkVTOn2SGpg==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(6133799003)(56012099006)(5023799004)(55112099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U+7/ixpuUSbJy3z2pTgb6ZoH6M0GkOC708iGoOaFmUHDKlHR86xb1bMcniejDt/WvwkAMz16subtjintGQkHQaWs1PAiBft5LhBBw60J71DRr05YY61wH/O+H2PjXJVC+9X1sg2ZaLHcnKiDDxQgA+ktfN8fnvM8khJmTBkOVU74UALZr6tI6mdS6ksbbRum1X4vaIFLAAUzPpDe6wYK382KBL8t5rwQLLGtFslozdA5bJWtK8Yc0OrePfvIoFFwg8bGrXPpaEPloJq1e+AEGLA2b+O5kmG+xNjtLwxADZpDpq5SlaTQCfF+m6G8DKzZvAYQWXv7KgT8AVVSQB+kl9uun+FQl8QIA5WS48Nye9+9CVz5PgoFGCPjIMsQXcv7dGMvNSqAMu+/rcZVILYaEEC0X7DJ8ML0/4jOgcPUnnTX1crpTbb8Y8X1Cs9AUaYY
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:25:35.6251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7841529-dfb2-4289-6585-08ded468b7c6
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8830
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22518-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:brendan.cunningham@cornelisnetworks.com,m:doug.miller@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,awdrv-04:mid,cornelisnetworks.com:dkim,cornelisnetworks.com:email,cornelisnetworks.com:from_mime];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CE186D240A

Add the core driver entry points, interrupt handling, MSI-X management,
and EFI variable support.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
  Changes since v3:
    - Address Leon's feedback (Re: v1 patch 07, Mar 17 2026): remove
      affinity calls from MSIx IRQ request and free paths. IRQ
      affinity is now left entirely to user space (irqbalance,
      /proc/irq/.../smp_affinity). Remove cpumask_t mask and
      irq_affinity_notify fields from struct hfi2_msix_entry.
    - Address Leon's feedback (Re: v1 patch 08, Mar 18 2026): remove
      the custom ASPM implementation (aspm.c). ASPM is managed at the
      PCIe core layer (pcie_aspm= cmdline) and the driver should not
      duplicate this functionality.
    - Address Leon's feedback (Re: v1 hfi2 series, Mar 18 2026): remove
      the module_param declarations for max_mtu, cu and cap_mask.
      Also drop the kernel_param_ops getter/setter
      hfi2_caps_get()/hfi2_caps_set() that backed cap_mask, since they
      are no longer reachable.  The variables themselves (hfi2_max_mtu,
      hfi2_cu, hfi2_cap_mask) are kept as plain globals initialized to
      their previous defaults.
  Changes since v2:
    - Fix kernel-doc: @dd -> @ppd in handle_linkup_change
---
 drivers/infiniband/hw/hfi2/driver.c | 1917 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/efivar.c |  139 +++
 drivers/infiniband/hw/hfi2/hfi2.h   |    2 
 drivers/infiniband/hw/hfi2/intr.c   |  296 +++++
 drivers/infiniband/hw/hfi2/msix.c   |  422 ++++++++
 5 files changed, 2774 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi2/driver.c
 create mode 100644 drivers/infiniband/hw/hfi2/efivar.c
 create mode 100644 drivers/infiniband/hw/hfi2/intr.c
 create mode 100644 drivers/infiniband/hw/hfi2/msix.c

diff --git a/drivers/infiniband/hw/hfi2/driver.c b/drivers/infiniband/hw/hfi2/driver.c
new file mode 100644
index 000000000000..9913d510d35a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/driver.c
@@ -0,0 +1,1917 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015-2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+DEFINE_MUTEX(hfi2_mutex); /* general driver use */
+
+unsigned int hfi2_max_mtu = HFI2_DEFAULT_MAX_MTU;
+
+unsigned int hfi2_cu = 1;
+
+unsigned long hfi2_cap_mask = HFI2_CAP_MASK_DEFAULT;
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
+struct pci_dev *hfi2_get_pci_dev(struct rvt_dev_info *rdi)
+{
+	struct hfi2_ibdev *ibdev = container_of(rdi, struct hfi2_ibdev, rdi);
+	struct hfi2_devdata *dd =
+		container_of(ibdev, struct hfi2_devdata, verbs_dev);
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
+		if (!(dd->flags & HFI2_PRESENT))
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
+static inline void *hfi2_get_header(struct hfi2_ctxtdata *rcd, __le32 *rhf_addr)
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
+static inline struct hfi2_16b_header *
+hfi2_get_16B_header(struct hfi2_ctxtdata *rcd, __le32 *rhf_addr)
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
+	if (size > (type == PT_EAGER ? MAX_EAGER_BUFFER : MAX_EXPECTED_BUFFER))
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
+	if (rhe_crk_err(packet) && hfi2_dbg_fault_suppress_err(verbs_dev))
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
+	case RHF_RTE_ERROR_OP_CODE_ERR: {
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
+			hfi2_process_becn(ppd, sl, rlid, lqpn, rqpn, svc_type);
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
+		packet->sc4 = (rhf >> 53) & 0x1; /* RHF.L2Type9bSc4 */
+		packet->rcv_seq = jkr_rhf_rcv_seq(rhf); /* RHF.RcvSeq */
+		packet->has_errs = (rhf >> 63) & 0x1; /* RHF.RheValid */
+		/*
+		 * NOTE: (1) The divide can be changed to a shift.  Should
+		 *           pre-calculate the value.
+		 *       (2) rhqoff (head) and rsize are both in words.
+		 */
+		if (packet->has_errs)
+			packet->err_flags =
+				((u64 *)(rcd->rheq))[packet->rhqoff /
+						     packet->rsize];
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
+	[HFI2_PKT_TYPE_9B] = &hfi2_return_cnp,
+	[HFI2_PKT_TYPE_16B] = &hfi2_return_cnp_16B
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
+	bool is_mcast = false, ignore_fecn = false, do_cnp = false, fecn, becn;
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
+						       ppd->lid;
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
+		      (opcode == IB_OPCODE_RC_ACKNOWLEDGE);
+	/*
+	 * ACKNOWLEDGE packets do not get a CNP but this will be
+	 * guarded by ignore_fecn above.
+	 */
+	do_cnp = prescan ||
+		 (opcode >= IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST &&
+		  opcode <= IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE) ||
+		 opcode == TID_OP(READ_RESP) || opcode == TID_OP(ACK);
+
+	/* Call appropriate CNP handler */
+	if (!ignore_fecn && do_cnp && fecn)
+		hfi2_handle_cnp_tbl[hdr_type](ibp, qp, rqpn, pkey, dlid, rlid,
+					      sc, grh);
+
+	if (becn) {
+		u32 lqpn = be32_to_cpu(ohdr->bth[1]) & RVT_QPN_MASK;
+		u8 sl = ibp->sc_to_sl[sc];
+
+		hfi2_process_becn(ppd, sl, rlid, lqpn, rqpn, svc_type);
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
+		if (hfi2_is_control_context(rcd))
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
+	return mdata->ps_seq != hfi2_slow_rhf_rcv_seq(rcd, rhf);
+}
+
+static inline int ps_skip(struct ps_mdata *mdata, u64 rhf,
+			  struct hfi2_ctxtdata *rcd)
+{
+	/*
+	 * Control context can potentially receive an invalid rhf.
+	 * Drop such packets.
+	 */
+	if (hfi2_is_control_context(rcd) && (mdata->ps_head != mdata->ps_tail))
+		return mdata->ps_seq != hfi2_slow_rhf_rcv_seq(rcd, rhf);
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
+	if (!get_dma_rtail_setting(rcd) || hfi2_is_control_context(rcd))
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
+#define prescan_rxq(rcd, packet)               \
+	do {                                   \
+		if (rcd->ppd->cc_prescan)      \
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
+				   packet->rcd->rhf_offset;
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
+			    RVT_PROCESS_OR_FLUSH_SEND)
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
+	}
+	this_cpu_inc(*packet->rcd->dd->rcv_limit);
+	return RCV_PKT_LIMIT;
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
+			   packet->rcd->rhf_offset;
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
+					(rhf_hdrq_offset(packet->rhf) + 2)) *
+				       4));
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
+			   packet->rcd->rhf_offset;
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
+			       packet->tlen -
+				       ((get_hdrqentsize(packet->rcd) -
+					 (rhf_hdrq_offset(packet->rhf) + 2)) *
+					4));
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
+			   packet->rcd->rhf_offset;
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
+		hfi2_update_usrhead(packet->rcd, packet->rhqoff, packet->updegr,
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
+	hfi2_update_usrhead(packet->rcd, hfi2_rcd_head(packet->rcd), packet->updegr,
+		       packet->etail, hfi2_rcv_intr_dynamic, packet->numpkt);
+}
+
+/*
+ * hfi2_handle_receive_interrupt_napi_fp - receive a packet
+ * @rcd: the context
+ * @budget: polling budget
+ *
+ * Called from interrupt handler for receive interrupt.
+ * This is the fast path interrupt handler
+ * when executing napi soft irq environment.
+ */
+int hfi2_handle_receive_interrupt_napi_fp(struct hfi2_ctxtdata *rcd, int budget)
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
+int hfi2_handle_receive_interrupt_nodma_rtail(struct hfi2_ctxtdata *rcd, int thread)
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
+int hfi2_handle_receive_interrupt_dma_rtail(struct hfi2_ctxtdata *rcd, int thread)
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
+	smp_rmb(); /* prevent speculative reads of dma'ed hdrq */
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
+	struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[ppd->hw_pidx];
+	u16 i;
+
+	/*
+	 * For dynamically allocated kernel contexts switch
+	 * interrupt handler only for that context. Otherwise, switch
+	 * interrupt handler for all statically allocated kernel contexts.
+	 */
+	if (hfi2_is_user_context(rcd)) {
+		hfi2_rcd_get(rcd);
+		hfi2_set_fast(rcd);
+		hfi2_rcd_put(rcd);
+		return;
+	}
+
+	for (i = 0; i < pr->num_rcv_contexts; i++) {
+		u16 ctxt = pr->rcv_context_base + i;
+
+		rcd = hfi2_rcd_get_by_index(dd, ctxt);
+		if (rcd && !hfi2_is_control_context(rcd) && (hfi2_is_kernel_context(rcd)))
+			hfi2_set_fast(rcd);
+		hfi2_rcd_put(rcd);
+	}
+}
+
+void hfi2_set_all_slowpath(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[ppd->hw_pidx];
+	struct hfi2_ctxtdata *rcd;
+	u16 i;
+
+	/* control context must always use the slow path interrupt handler */
+	for (i = 0; i < pr->num_rcv_contexts; i++) {
+		u16 ctxt = pr->rcv_context_base + i;
+
+		rcd = hfi2_rcd_get_by_index(dd, ctxt);
+		if (!rcd)
+			continue;
+		if (!hfi2_is_control_context(rcd) && (hfi2_is_kernel_context(rcd)))
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
+		struct ib_header *hdr =
+			hfi2_get_msgheader(packet->rcd, packet->rhf_addr);
+		sc = hfi2_9B_get_sc5(hdr, packet->sc4);
+	} else if (etype == RHF_RCV_TYPE_BYPASS) {
+		struct hfi2_16b_header *hdr =
+			hfi2_get_16B_header(packet->rcd, packet->rhf_addr);
+		sc = hfi2_16B_get_sc(hdr);
+	}
+	if (sc != SC15_PACKET) {
+		int hwstate = hfi2_driver_lstate(packet->rcd->ppd);
+		struct work_struct *lsaw =
+			&packet->rcd->ppd->linkstate_active_work;
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
+ * hfi2_handle_receive_interrupt - receive a packet
+ * @rcd: the context
+ *
+ * Called from interrupt handler for errors or receive interrupt.
+ * This is the slow path interrupt handler.
+ */
+int hfi2_handle_receive_interrupt(struct hfi2_ctxtdata *rcd, int thread)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 hdrqtail;
+	int needset, last = RCV_PKT_OK;
+	struct hfi2_packet packet;
+	int skip_pkt = 0;
+	bool is_control = hfi2_is_control_context(rcd);
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
+		smp_rmb(); /* prevent speculative reads of dma'ed hdrq */
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
+					  packet.rhqoff + rcd->rhf_offset;
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
+ * hfi2_handle_receive_interrupt_napi_sp - receive a packet
+ * @rcd: the context
+ * @budget: polling budget
+ *
+ * Called from interrupt handler for errors or receive interrupt.
+ * This is the slow path interrupt handler
+ * when executing napi soft irq environment.
+ */
+int hfi2_handle_receive_interrupt_napi_sp(struct hfi2_ctxtdata *rcd, int budget)
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
+					  packet.rhqoff + rcd->rhf_offset;
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
+ * run hfi2_set_link_state from interrupt context, so we queue this function on
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
+void hfi2_receive_interrupt_work(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  linkstate_active_work);
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[ppd->hw_pidx];
+	struct hfi2_ctxtdata *rcd;
+	u16 i;
+
+	/* Received non-SC15 packet implies neighbor_normal */
+	ppd->neighbor_normal = 1;
+	hfi2_set_link_state(ppd, HLS_UP_ACTIVE);
+
+	/*
+	 * Interrupt all statically allocated kernel contexts that could
+	 * have had an interrupt during auto activation.
+	 */
+	for (i = pr->rcv_context_base; i < pr->first_dyn_alloc_ctxt; i++) {
+		rcd = hfi2_rcd_get_by_index(dd, i);
+		if (rcd)
+			hfi2_force_recv_intr(rcd);
+		hfi2_rcd_put(rcd);
+	}
+}
+
+/*
+ * Convert a given MTU size to the on-wire MAD packet enumeration.
+ * Return -1 if the size is invalid.
+ */
+int hfi2_mtu_to_enum(u32 mtu, int default_if_bad)
+{
+	switch (mtu) {
+	case 0:
+		return OPA_MTU_0;
+	case 256:
+		return OPA_MTU_256;
+	case 512:
+		return OPA_MTU_512;
+	case 1024:
+		return OPA_MTU_1024;
+	case 2048:
+		return OPA_MTU_2048;
+	case 4096:
+		return OPA_MTU_4096;
+	case 8192:
+		return OPA_MTU_8192;
+	case 10240:
+		return OPA_MTU_10240;
+	}
+	return default_if_bad;
+}
+
+u16 hfi2_enum_to_mtu(int mtu)
+{
+	switch (mtu) {
+	case OPA_MTU_0:
+		return 0;
+	case OPA_MTU_256:
+		return 256;
+	case OPA_MTU_512:
+		return 512;
+	case OPA_MTU_1024:
+		return 1024;
+	case OPA_MTU_2048:
+		return 2048;
+	case OPA_MTU_4096:
+		return 4096;
+	case OPA_MTU_8192:
+		return 8192;
+	case OPA_MTU_10240:
+		return 10240;
+	default:
+		return 0xffff;
+	}
+}
+
+/*
+ * hfi2_set_mtu - set the MTU
+ * @ppd: the per port data
+ *
+ * We can handle "any" incoming size, the issue here is whether we
+ * need to restrict our outgoing size.  We do not deal with what happens
+ * to programs that are already running when the size changes.
+ */
+int hfi2_set_mtu(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i, drain, ret = 0, is_up = 0;
+
+	ppd->ibmtu = 0;
+	for (i = 0; i < ppd->vls_supported; i++)
+		if (ppd->ibmtu < ppd->vld[i].mtu)
+			ppd->ibmtu = ppd->vld[i].mtu;
+	ppd->ibmaxlen = ppd->ibmtu + hfi2_lrh_max_header_bytes(ppd);
+
+	mutex_lock(&ppd->hls_lock);
+	if (ppd->host_link_state == HLS_UP_INIT ||
+	    ppd->host_link_state == HLS_UP_ARMED ||
+	    ppd->host_link_state == HLS_UP_ACTIVE)
+		is_up = 1;
+
+	drain = !hfi2_is_ax(dd) && is_up;
+
+	if (drain)
+		/*
+		 * MTU is specified per-VL. To ensure that no packet gets
+		 * stuck (due, e.g., to the MTU for the packet's VL being
+		 * reduced), empty the per-VL FIFOs before adjusting MTU.
+		 */
+		ret = hfi2_stop_drain_data_vls(ppd);
+
+	if (ret) {
+		dd_dev_err(
+			dd,
+			"%s: cannot stop/drain VLs - refusing to change per-VL MTUs\n",
+			__func__);
+		goto err;
+	}
+
+	hfi2_set_ib_cfg(ppd, HFI2_IB_CFG_MTU, 0);
+
+	if (drain)
+		hfi2_open_fill_data_vls(ppd); /* reopen all VLs */
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
+void hfi2_setextled(struct hfi2_pportdata *ppd, u32 on)
+{
+	if (on)
+		hfi2_write_csr(ppd->dd, DCC_CFG_LED_CNTRL, 0x1F);
+	else
+		hfi2_write_csr(ppd->dd, DCC_CFG_LED_CNTRL, 0x10);
+}
+
+void hfi2_shutdown_led_override(struct hfi2_pportdata *ppd)
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
+	hfi2_write_csr(dd, DCC_CFG_LED_CNTRL, 0);
+}
+
+static void run_led_override(struct timer_list *t)
+{
+	struct hfi2_pportdata *ppd =
+		timer_container_of(ppd, t, led_override_timer);
+	struct hfi2_devdata *dd = ppd->dd;
+	unsigned long timeout;
+	int phase_idx;
+
+	if (!(dd->flags & HFI2_INITTED))
+		return;
+
+	phase_idx = ppd->led_override_phase & 1;
+
+	hfi2_setextled(ppd, phase_idx);
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
+ * hfi2_shutdown_led_override()
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
+	if (!(dd->flags & HFI2_PRESENT)) {
+		dd_dev_info(
+			dd,
+			"Invalid unit number %u or not initialized or not present\n",
+			unit);
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
+		dd->params->hfi2_shutdown_led_override(ppd);
+	}
+	if (dd->flags & HFI2_HAS_SEND_DMA)
+		hfi2_sdma_exit(dd);
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
+	packet->hdr = (struct hfi2_ib_message_header *)hfi2_get_msgheader(
+		packet->rcd, packet->rhf_addr);
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
+	     opa_get_lid(be32_to_cpu(OPA_LID_PERMISSIVE), 16B))) {
+		if ((packet->dlid & ~((1 << ppd->lmc) - 1)) != ppd->lid)
+			return -EINVAL;
+	}
+
+	/* No multicast packets with SC15 */
+	if ((hfi2_is_16B_mcast(packet->dlid)) && (packet->sc == 0xF))
+		return -EINVAL;
+
+	/* Packets with permissive DLID always on SC15 */
+	if ((packet->dlid ==
+	     opa_get_lid(be32_to_cpu(OPA_LID_PERMISSIVE), 16B)) &&
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
+	packet->hdr = (struct hfi2_16b_header *)hfi2_get_16B_header(
+		packet->rcd, packet->rhf_addr);
+	l4 = hfi2_16B_get_l4(packet->hdr);
+	if (l4 == OPA_16B_L4_IB_LOCAL) {
+		packet->ohdr = packet->ebuf;
+		packet->grh = NULL;
+		packet->opcode = ib_bth_get_opcode(packet->ohdr);
+		packet->pad = hfi2_16B_bth_get_pad(packet->ohdr);
+		/* hfi2_hdr_len_by_opcode already has an IB LRH factored in */
+		packet->hlen = hfi2_hdr_len_by_opcode[packet->opcode] +
+			       (LRH_16B_BYTES - LRH_9B_BYTES);
+		packet->migrated = opa_bth_is_migration(packet->ohdr);
+	} else if (l4 == OPA_16B_L4_IB_GLOBAL) {
+		u32 vtf;
+		u8 grh_len = sizeof(struct ib_grh);
+
+		packet->ohdr = packet->ebuf + grh_len;
+		packet->grh = packet->ebuf;
+		packet->opcode = ib_bth_get_opcode(packet->ohdr);
+		packet->pad = hfi2_16B_bth_get_pad(packet->ohdr);
+		/* hfi2_hdr_len_by_opcode already has an IB LRH factored in */
+		packet->hlen = hfi2_hdr_len_by_opcode[packet->opcode] +
+			       (LRH_16B_BYTES - LRH_9B_BYTES) + grh_len;
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
+		packet->dlid +=
+			opa_get_mcast_base(OPA_MCAST_NR) -
+			opa_get_lid(opa_get_mcast_base(OPA_MCAST_NR), 16B);
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
+		dd_dev_err(
+			rcd->dd,
+			"receive context %d: rhf 0x%016llx, errs [ %s%s%s%s%s%s%s] rte 0x%x\n",
+			rcd->ctxt, packet->rhf,
+			packet->rhf & RHF_K_HDR_LEN_ERR ? "k_hdr_len " : "",
+			packet->rhf & RHF_DC_UNC_ERR ? "dc_unc " : "",
+			packet->rhf & RHF_DC_ERR ? "dc " : "",
+			packet->rhf & RHF_TID_ERR ? "tid " : "",
+			packet->rhf & RHF_LEN_ERR ? "len " : "",
+			packet->rhf & RHF_ECC_ERR ? "ecc " : "",
+			packet->rhf & RHF_ICRC_ERR ? "icrc " : "", rte);
+	} else {
+		dd_dev_err(
+			rcd->dd,
+			"receive context %d: rhf 0x%016llx, errs 0x%016llx, rte 0x%x\n",
+			rcd->ctxt, packet->rhf, packet->err_flags, rte);
+	}
+}
+
+void hfi2_handle_eflags(struct hfi2_packet *packet)
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
+	struct hfi2_netdev_rxq *rxq =
+		container_of(napi, struct hfi2_netdev_rxq, napi);
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
+		hfi2_handle_eflags(packet);
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
+						packet, do_cnp);
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
+		      packet->hlen;
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
+		hfi2_handle_eflags(packet);
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
+		hfi2_handle_eflags(packet);
+		return;
+	}
+
+	if (hfi2_16B_get_l2(packet->hdr) == 0x2) {
+		hfi2_16B_rcv(packet);
+	} else {
+		dd_dev_err(
+			dd,
+			"Bypass packets other than 16B are not supported in normal operation. Dropping\n");
+		incr_cntr64(&dd->sw_rcv_bypass_packet_errors);
+		if (!(dd->err_info_rcvport.status_and_code &
+		      OPA_EI_STATUS_SMASK)) {
+			u64 *flits = packet->ebuf;
+
+			if (flits && !rhe_len_err(packet)) {
+				dd->err_info_rcvport.packet_flit1 = flits[0];
+				dd->err_info_rcvport.packet_flit2 =
+					packet->tlen > sizeof(flits[0]) ?
+						flits[1] :
+						0;
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
+	if (unlikely(hfi2_dbg_fault_suppress_err(&packet->rcd->dd->verbs_dev) &&
+		     (rhe_rcv_type_err(packet) == RHF_RCV_TYPE_ERROR ||
+		      rhe_crk_err(packet))))
+		return;
+
+	hfi2_setup_ib_header(packet);
+	hfi2_handle_eflags(packet);
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
+#define HFI2_RCVHDR_DUMP_MAX 5
+
+void hfi2_seqfile_dump_rcd(struct seq_file *s, struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_packet packet;
+	struct ps_mdata mdata;
+	int i;
+
+	seq_printf(
+		s,
+		"Rcd %u: RcvHdr cnt %u entsize %u %s kctrl 0x%08llx rctrl 0x%08llx status 0x%08llx, head %llu tail %llu  sw head %u\n",
+		rcd->ctxt, get_hdrq_cnt(rcd), get_hdrqentsize(rcd),
+		get_dma_rtail_setting(rcd) ? "dma_rtail" : "nodma_rtail",
+		read_kctxt_csr(rcd->dd, rcd->ctxt,
+			       rcd->dd->params->rcv_kctxt_ctrl_reg),
+		read_rctxt_csr(rcd->dd, rcd->ctxt,
+			       rcd->dd->params->rcv_rctxt_ctrl_reg),
+		read_ku_csr(rcd->dd, rcd->ctxt,
+			    rcd->dd->params->rcv_ctxt_status_reg),
+		read_uctxt_csr(rcd->dd, rcd->ctxt,
+			       rcd->dd->params->rcv_hdr_head_reg) &
+			RCV_HDR_HEAD_HEAD_MASK,
+		read_uctxt_csr(rcd->dd, rcd->ctxt,
+			       rcd->dd->params->rcv_hdr_tail_reg),
+		rcd->head);
+
+	init_packet(rcd, &packet);
+	init_ps_mdata(&mdata, &packet);
+
+	for (i = 0; i < HFI2_RCVHDR_DUMP_MAX; i++) {
+		__le32 *rhf_addr = (__le32 *)rcd->rcvhdrq + mdata.ps_head +
+				   rcd->rhf_offset;
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
+const rhf_rcv_function_ptr hfi2_normal_rhf_rcv_functions[] = {
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
+const rhf_rcv_function_ptr hfi2_netdev_rhf_rcv_functions[] = {
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
index 000000000000..fa7fd77f8ec3
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/efivar.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+int hfi2_read_hfi2_efi_var(struct hfi2_devdata *dd, const char *kind,
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
diff --git a/drivers/infiniband/hw/hfi2/hfi2.h b/drivers/infiniband/hw/hfi2/hfi2.h
index a7882177b8cb..7ff6b0bb9e91 100644
--- a/drivers/infiniband/hw/hfi2/hfi2.h
+++ b/drivers/infiniband/hw/hfi2/hfi2.h
@@ -691,8 +691,6 @@ struct hfi2_msix_entry {
 	enum irq_type type;
 	int irq;
 	void *arg;
-	cpumask_t mask;
-	struct irq_affinity_notify notify;
 };
 
 struct hfi2_msix_info {
diff --git a/drivers/infiniband/hw/hfi2/intr.c b/drivers/infiniband/hw/hfi2/intr.c
new file mode 100644
index 000000000000..b09fefab314d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/intr.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+		hfi2_read_8051_config(dd, REMOTE_LNI_INFO, GENERAL_CONFIG, &frame);
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
+ * hfi2_handle_linkup_change - finish linkup/down state changes
+ * @ppd: valid port data
+ * @linkup: link state information
+ *
+ * Handle a linkup or link down notification.
+ * The HW needs time to finish its link up state change. Give it that chance.
+ *
+ * This is called outside an interrupt.
+ *
+ */
+void hfi2_handle_linkup_change(struct hfi2_pportdata *ppd, u32 linkup)
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
+		 * hfi2_handle_verify_cap(), but do not try moving the state to
+		 * LinkUp as we are already there.
+		 *
+		 * NOTE: This uses this device's vAU, vCU, and vl15_init for
+		 * the remote values.  Both sides must be using the values.
+		 */
+		if (hfi2_quick_linkup) {
+			hfi2_set_up_vau(ppd, dd->vau);
+			hfi2_set_up_vl15(ppd, dd->vl15_init);
+			hfi2_assign_remote_cm_au_table(ppd, dd->vcu);
+		}
+
+		ppd->neighbor_guid =
+			hfi2_read_csr(dd, DC_DC8051_STS_REMOTE_GUID);
+		ppd->neighbor_type =
+			hfi2_read_csr(dd, DC_DC8051_STS_REMOTE_NODE_TYPE) &
+				 DC_DC8051_STS_REMOTE_NODE_TYPE_VAL_MASK;
+		ppd->neighbor_port_number =
+			hfi2_read_csr(dd, DC_DC8051_STS_REMOTE_PORT_NO) &
+				 DC_DC8051_STS_REMOTE_PORT_NO_VAL_SMASK;
+		ppd->neighbor_fm_security =
+			hfi2_read_csr(dd, DC_DC8051_STS_REMOTE_FM_SECURITY) &
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
+		hfi2_get_linkup_link_widths(ppd);
+
+	} else {
+		/* physical link went down */
+		ppd->linkup = 0;
+
+		/* clear HW details of the previous connection */
+		ppd->actual_vls_operational = 0;
+		hfi2_reset_link_credits(ppd);
+
+		/* freeze after a link down to guarantee a clean egress */
+		hfi2_start_freeze_handling(dd, FREEZE_SELF | FREEZE_LINK_DOWN);
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
+/* Special version of hfi2_handle_linkup_change() for systems with a CPORT */
+void hfi2_cport_handle_linkup_change(struct hfi2_pportdata *ppd,
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
+				ppd_dev_warn(ppd, "%s pkey[2] already set to 0x%x, resetting it to 0x%x\n",
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
+		hfi2_init_kdeth_qp(dd);
+
+	} else {
+		/* physical link went down */
+		ppd->linkup = 0;
+
+		/* clear HW details of the previous connection */
+		ppd->actual_vls_operational = 0;
+
+		/* what's left from hfi2_reset_link_credits() */
+		dd->vl15buf_cached = 0;
+
+		hfi2_start_linkdown_handling(ppd);
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
+ * hfi2_go_port_active - All steps needed when the port goes active.
+ * @ppd: port structure
+ *
+ * Take non-chip specific steps for transition from INIT to ACTIVE.  This
+ * routine expects the port to already in INIT.  This routine is not
+ * responsible for setting the state.
+ */
+void hfi2_go_port_active(struct hfi2_pportdata *ppd)
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
+void hfi2_handle_user_interrupt(struct hfi2_ctxtdata *rcd)
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
index 000000000000..ed3c2cbc4bd2
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/msix.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2018 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include "hfi2.h"
+#include "sdma.h"
+#include "netdev.h"
+#include "vf2pf.h"
+
+/**
+ * hfi2_msix_initialize() - Calculate, request and configure MSIx IRQs
+ * @dd: valid hfi2 devdata
+ *
+ */
+int hfi2_msix_initialize(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u32 total;
+	int ret;
+	int pidx;
+	struct hfi2_msix_entry *entries;
+
+	/*
+	 * MSIx interrupt count:
+	 *	one for the general, "slow path" interrupt
+	 *	as needed for vf2pf
+	 *	one per used SDMA engine
+	 *	one per kernel receive context
+	 *      ...any new IRQs should be added here.
+	 */
+	total = 1 + hfi2_vf2pf_num_irq(dd) +
+		(dr->last_sdma_engine - dr->first_sdma_engine);
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		total += pr->n_krcv_queues + pr->num_netdev_contexts;
+	}
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
+	entries =
+		kcalloc(total, sizeof(*dd->msix_info.msix_entries), GFP_KERNEL);
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
+	if (nr == dd->msix_info.max_requested) {
+		pr_err("%s: failed, nr %ld, max_requested %d, -ENOSPC\n",
+		       __func__, nr, dd->msix_info.max_requested);
+		return -ENOSPC;
+	}
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
+	return nr;
+}
+
+static int msix_request_rcd_irq_common(struct hfi2_ctxtdata *rcd,
+				       irq_handler_t handler,
+				       irq_handler_t thread, const char *name)
+{
+	u32 source;
+	int nr;
+
+	nr = msix_request_irq(rcd->dd, rcd, handler, thread, IRQ_RCVCTXT, name);
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
+	hfi2_remap_intr(rcd->dd, source, nr);
+
+	return 0;
+}
+
+/**
+ * hfi2_msix_request_rcd_irq() - Helper function for RCVAVAIL IRQs
+ * @rcd: valid rcd context
+ *
+ */
+int hfi2_msix_request_rcd_irq(struct hfi2_ctxtdata *rcd)
+{
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d kctxt%d", rcd->dd->unit,
+		 rcd->ctxt);
+
+	return msix_request_rcd_irq_common(rcd, hfi2_receive_context_interrupt,
+					   hfi2_receive_context_thread, name);
+}
+
+/**
+ * hfi2_msix_netdev_request_rcd_irq  - Helper function for RCVAVAIL IRQs
+ * for netdev context
+ * @rcd: valid netdev contexti
+ */
+int hfi2_msix_netdev_request_rcd_irq(struct hfi2_ctxtdata *rcd)
+{
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d nd kctxt%d",
+		 rcd->dd->unit, rcd->ctxt);
+	return msix_request_rcd_irq_common(rcd, hfi2_receive_context_interrupt_napi,
+					   NULL, name);
+}
+
+/**
+ * hfi2_msix_request_sdma_irq  - Helper for getting SDMA IRQ resources
+ * @sde: valid sdma engine
+ *
+ */
+int hfi2_msix_request_sdma_irq(struct sdma_engine *sde)
+{
+	int nr;
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d sdma%d", sde->dd->unit,
+		 sde->this_idx);
+	nr = msix_request_irq(sde->dd, sde, hfi2_sdma_interrupt, hfi2_sdma_interrupt_thr,
+			      IRQ_SDMA, name);
+	if (nr < 0)
+		return nr;
+	sde->msix_intr = nr;
+	hfi2_remap_sdma_interrupts(sde->dd, sde->this_idx, nr);
+
+	return 0;
+}
+
+/**
+ * hfi2_msix_request_general_irq - Helper for getting general IRQ
+ * resources
+ * @dd: valid device data
+ */
+int hfi2_msix_request_general_irq(struct hfi2_devdata *dd)
+{
+	int nr;
+	char name[MAX_NAME_SIZE];
+
+	snprintf(name, sizeof(name), DRIVER_NAME "_%d", dd->unit);
+	nr = msix_request_irq(dd, dd, hfi2_general_interrupt, NULL, IRQ_GENERAL,
+			      name);
+	if (nr < 0)
+		return nr;
+
+	/* general interrupt must be MSIx vector 0 */
+	if (nr) {
+		hfi2_msix_free_irq(dd, (u8)nr);
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
+	hfi2_set_intr_bits(dd, dd->params->is_sdma_start + i,
+		      dd->params->is_sdma_start + i, true);
+	hfi2_set_intr_bits(dd, dd->params->is_sdma_progress_start + i,
+		      dd->params->is_sdma_progress_start + i, true);
+	hfi2_set_intr_bits(dd, dd->params->is_sdma_idle_start + i,
+		      dd->params->is_sdma_idle_start + i, true);
+	hfi2_set_intr_bits(dd, dd->params->is_sdmaeng_err_start + i,
+		      dd->params->is_sdmaeng_err_start + i, true);
+}
+
+/**
+ * hfi2_msix_request_irqs() - Allocate SDMA and receive IRQs
+ * @dd: valid devdata structure
+ *
+ * Helper function to request MSIx IRQs for SDMA and receive.
+ */
+int hfi2_msix_request_irqs(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i;
+	int j;
+	int ret = 0;
+
+	for (i = dr->first_sdma_engine; i < dr->last_sdma_engine; i++) {
+		struct sdma_engine *sde = &dd->per_sdma[i];
+
+		ret = hfi2_msix_request_sdma_irq(sde);
+		if (ret)
+			return ret;
+		enable_sdma_srcs(sde->dd, i);
+	}
+
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[i];
+
+		for (j = 0; j < pr->n_krcv_queues; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
+			struct hfi2_ctxtdata *rcd =
+				hfi2_rcd_get_by_index(dd, ctxt);
+
+			if (rcd)
+				ret = hfi2_msix_request_rcd_irq(rcd);
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
+ * hfi2_msix_early_request_irqs() - Allocate needed early IRQs.
+ * @dd: valid devdata structure
+ *
+ * Helper function to request an MSIx IRQs for anthing needed early in the
+ * device initialize.  Presently, only the general interrupt handler.
+ */
+int hfi2_msix_early_request_irqs(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = hfi2_msix_request_general_irq(dd);
+	if (ret)
+		return ret;
+	/*
+	 * Only VFs can/must init VF2PF IRQs this early.
+	 * The PF must wait until CPORT f/w has reset all
+	 * resources in hfi2_start_cport().
+	 */
+	if (dd->is_vf)
+		ret = hfi2_vf2pf_init_irq(dd);
+
+	return ret;
+}
+
+/**
+ * hfi2_msix_free_irq() - Free the specified MSIx resources and IRQ
+ * @dd: valid devdata
+ * @msix_intr: MSIx vector to free.
+ *
+ */
+void hfi2_msix_free_irq(struct hfi2_devdata *dd, u8 msix_intr)
+{
+	struct hfi2_msix_entry *me;
+
+	if (msix_intr >= dd->msix_info.max_requested)
+		return;
+
+	me = &dd->msix_info.msix_entries[msix_intr];
+
+	if (!me->arg)
+		return;
+
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
+ * hfi2_msix_clean_up_interrupts  - Free all MSIx IRQ resources
+ * @dd: valid device data structure
+ *
+ * Free the MSIx and associated PCI resources, if they have been allocated.
+ */
+void hfi2_msix_clean_up_interrupts(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* remove irqs - must happen before disabling/turning off */
+	for (i = 0; i < dd->msix_info.max_requested; i++)
+		hfi2_msix_free_irq(dd, i);
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
+ * hfi2_msix_shut_down_interrupts - Free all or most IRQs
+ * @dd: device data structure
+ * @keep_gen: when true, keep general interrupt
+ *
+ * Free all IRQs with the possible exception of the general IRQ.  Retain all
+ * structures.  This should eventually be followed by a call to
+ * hfi2_msix_clean_up_interrupts().
+ */
+void hfi2_msix_shut_down_interrupts(struct hfi2_devdata *dd, bool keep_gen)
+{
+	struct hfi2_msix_entry *me;
+	int i;
+
+	/* remove irqs - must happen before disabling/turning off */
+	for (i = 0; i < dd->msix_info.max_requested; i++) {
+		me = &dd->msix_info.msix_entries[i];
+		if (keep_gen && me->type == IRQ_GENERAL)
+			continue;
+		hfi2_msix_free_irq(dd, i);
+	}
+}
+
+/**
+ * hfi2_msix_netdev_synchronize_irq - netdev IRQ synchronize
+ * @ppd: valid port data
+ */
+void hfi2_msix_netdev_synchronize_irq(struct hfi2_pportdata *ppd)
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
+
+int hfi2_msix_request_irq_remap(struct hfi2_devdata *dd, u16 ctxt,
+			   enum irq_type type, int src, irq_handler_t handler,
+			   irq_handler_t thread, void *arg, const char *name)
+{
+	int nr;
+
+	nr = msix_request_irq(dd, arg, handler, thread, type, name);
+	if (nr < 0)
+		return nr;
+
+	src = dd->params->is_rcvavail_start + ctxt;
+	hfi2_remap_intr(dd, src, nr);
+	return nr;
+}



