Return-Path: <linux-rdma+bounces-18007-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA8ZMc6ssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18007-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A370A268556
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33EA30E739C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED703E63A7;
	Wed, 11 Mar 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="WtluEhBq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023109.outbound.protection.outlook.com [40.107.201.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BE83E63AA
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251750; cv=fail; b=sDkpHifK5hTi3udQm7FNpF1kpK/6P1UnOpX0f/eIT7j54cHTerZiskHFsA5bUxVpsaGI6pv3BGerXwht+eK8J4MDPYGULNFvofv9cpV6EPXFl0rkeByiT4vN7ZDJXK4JeuHGmpG0Xd5Kslfilhjvpqzp/FJuXugceQRO7UwgmL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251750; c=relaxed/simple;
	bh=G0t1jjxrTEF5Ksz/TajGftokm54Mv5ejYLZetrUXZ+o=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KlD122aeJhzL36YiIFgTyULryHEdCzGgUMH9z+bHigV0KvyDb7ab0hwaflNDhE1X8ogqrBbrC9rbYd/hekvnL8Cu2kdawDppTNMBmJD1X/JOTjvAAQHBTzpEB1vZZlJrQeiVu1g2rVoMOypOd/rTGjqSX2y5uWSKuFD/oCLE6kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=WtluEhBq; arc=fail smtp.client-ip=40.107.201.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x863ItNHiShH0AIhB2whwum0GE+kzh1a4iV1wVkpOaxyIl071FDEAqnE9WskAphUUY2yQaP1HIYnFUnUnUsavAWe9slvDS/JfbaOaL45iLPY+prCCMYBLhf7XHPMJyj9nx1+fRZmVnMa9ywxRlgFjIb/xZZpwldI6O9NKBpGLuJom9KhEh1t9rFkY5kUDx7zVlbw34FcBWDKuLEAKVUfEQBtRE6U3RnWgpSh2eMEn2L3tz246pyPAj7LkBq5bhL4NjpJnYSP0xE5Fzc8L4bTNtahcFwo4vhzszwtI4L5L4jkbYvJLWfvl1QbJF2yfg1TOb3TNyz8js+IxlwocAQdow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuFRCJS/MFBgIndooBjWcq/JNJssFBhUAVOlhHFKak4=;
 b=nfhfTmnlFI+P7nUFPtGO2tELFo8/2I+52gjlmqPlZHFuekKUk27NChqY6O0xNp4lVMOuML7Nb3YRgY3Gf1o2RjaoAGtYVqwFbVHM6iDkcWeklyoT1MZ+9GLK0Vxzu0cBwT/p4nY01Ze9NdgygBXIwvPtz0k8tO7SaGoJd8E5sKtlugoRmwTahDgQjb9dHEQVHIRhuf2/RKfw9WY6FQEBDyTOAMe/aFaFxBUx4iQA1CKW9B+3y8Uo2wnNfWaYCWOR/gAoEVTB7dzRz/0fN8CS9miv59bZcE0gHhPDiAfVGwA7V3NGmajQsVUezUdpCqzX8H4UnHbq/i6ZqWuYdAo76A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuFRCJS/MFBgIndooBjWcq/JNJssFBhUAVOlhHFKak4=;
 b=WtluEhBqt4rwwGvta0OphVJz2pGYK6MPLbFyz68Ti+d+UTydMwrNTR5G82lEahd0TF+it4ftdpJcYMgl23hKa+pRa5ULFUQUlAqWydanSDmUFc5/CVhU56FIGjFagt9pN9RBps8NmMjDclmoIw3qtmX23j4hPBQ4/shVyEJs/dfmlX0JKueWADsPvQgdE+IXleElnufpFxIbB9vz9ZbkTC5zPYbcHw3iTjSpyxDyMacv0AoQ5TUQuOUDC/XTlxbpbF/A3rAVnX1xUHy26imSEAir+6RWedXZ79elSJYlUeMRD+VRai9+8OdDXNi86cVeXQfVI4tlr/SDfvyDOiBPWw==
Received: from BL1PR13CA0091.namprd13.prod.outlook.com (2603:10b6:208:2b9::6)
 by BL3PR01MB6803.prod.exchangelabs.com (2603:10b6:208:33e::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.13; Wed, 11 Mar 2026 17:55:34 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::fc) by BL1PR13CA0091.outlook.office365.com
 (2603:10b6:208:2b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.10 via Frontend Transport; Wed,
 11 Mar 2026 17:55:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:55:36 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 75C3D14D819;
	Wed, 11 Mar 2026 13:55:36 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 70ABF1810D6C5;
	Wed, 11 Mar 2026 13:55:36 -0400 (EDT)
Subject: [PATCH for-next resend 22/24] RDMA/hfi2: Add the rest of the driver
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:55:36 -0400
Message-ID:
 <177325173642.57064.10911327722700331940.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|BL3PR01MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: f34a1b51-6ded-47c9-ec68-08de7f97666e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|34020700016|1800799024|376014|22082099003|18002099003|56012099003|7142099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	1x2w4r6c7qL1MqURJT6bO0A1uSSTyHYmn1tGmw6BIEf8hDZ6EvNqcVwWLug7OMEQtxhhCEEAYEbwOdOUrDXkXNdSVTkNlRj6Q1dGtJepooVVQ1KwFShu+ggXIxLh4XGuPMKmIkuDVqPkik+ObQ6my1yvRGp8Nr7h2I7vxlwNPuGYewJKC73rC5R+uAmXNLZXVusBk13TwsVLite5o9b3RI9eQkCeDiDRwlG4rEzXOKSPjFnUHbIQTwiC7lFa/x6ST479JrCMSJ/JI+fTN4oUbp3Aa1Yy3yewNFD6khKgpWcq4P9J7blqowFIJm0wJbA7qS6tFY8oy/Nd8IPDprd6lGEoHTeebFZTXapLRGv4s9XxeP4V1Yh4UE281VOYNgbkfiMyPxBr5MxEGW9ZoAFBONFjj2H9zOJUMEDLjB9FVBIm4XlVIE1Ozv+xQeZpMpx2ajhlGbZiKQMx0ZQ26VcQq4Sat1drxOsjdgBMqcwUE0PskS6ROsXK/DDPIhGKeAn927NXxhicslP/MGPcuM7ByE/MYqaKilwcExRuE1cy0pgZMj91xEc2tdVV02UCxI/a5kfzIv8AQ32+ANffasA6ZGLcX5eYeTYbEicbSkJ9M8MDNY15JoWpJjggdSEUH9AA+wsD4GVNwAfnP3E6Idx/XuxWpNOUfbU3JLJ7G5WGEmlYMTtUYB++5EcefM+AaJtRXZSStlor4hh0rSl6TPn5bvn8lFKCoYH0pOnMYXWlrK0suubo3yNEf97sNT4f+AihpgbUnWXhRMHfzJILS4/S7A==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(34020700016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(7142099003)(55112099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vKNYfp4ntPNf43UmgcXpG7Y+QQJemo1ZD0gD+UnPETP1SHGHHu5u9d/Um50Cuy5bHOuGN2m9GNgWIfxw5RqwihAztjsR56RH9l0kAP/bdiQowsOW+Yxk8acgxVuM2YyjS1nRXfcsxvYC8Rdedo46JWs2cgxtF46Qb9mafM14MNyWFSo5/OSZkk3TWS4oV8WV9PXUj4eGTLLFfXjAYJuy2MQ/2Lqp03y1Azz2TIIZYSlrCquEWl2F1t7900g1JH/XlJCpthbGoFzuampD6DFi9UqahVGm4/684MYu2lf3XwdOZocjyYlg/w+b+A89Rh5JJHUYw8sHOIpvy2l0empHsii24tjDugb6WLJVtJSvcj/4pH3YHrT2Z8szItXR7hfl6P5Q9iSqk6pjoqu2y5bMNUMT02y+BLeF3wyeOPcMNleMQJB/CSNnmmqeXMP2nhn3
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:55:36.7832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f34a1b51-6ded-47c9-ec68-08de7f97666e
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6803
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18007-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A370A268556
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are a few other C files left after adding all the major topics adding
them in one go.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/Makefile   |   76 ++
 drivers/infiniband/hw/hfi2/debugfs.c  | 1551 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/eprom.c    |  451 ++++++++++
 drivers/infiniband/hw/hfi2/fault.c    |  325 +++++++
 drivers/infiniband/hw/hfi2/pcie.c     | 1459 +++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/platform.c | 1041 ++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/qsfp.c     |  788 +++++++++++++++++
 drivers/infiniband/hw/hfi2/sriov.c    |   11 
 drivers/infiniband/hw/hfi2/sysfs.c    |  878 +++++++++++++++++++
 9 files changed, 6569 insertions(+), 11 deletions(-)
 create mode 100644 drivers/infiniband/hw/hfi2/Makefile
 create mode 100644 drivers/infiniband/hw/hfi2/debugfs.c
 create mode 100644 drivers/infiniband/hw/hfi2/eprom.c
 create mode 100644 drivers/infiniband/hw/hfi2/fault.c
 create mode 100644 drivers/infiniband/hw/hfi2/pcie.c
 create mode 100644 drivers/infiniband/hw/hfi2/platform.c
 create mode 100644 drivers/infiniband/hw/hfi2/qsfp.c
 create mode 100644 drivers/infiniband/hw/hfi2/sysfs.c

diff --git a/drivers/infiniband/hw/hfi2/Makefile b/drivers/infiniband/hw/hfi2/Makefile
new file mode 100644
index 000000000000..25547c94393f
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/Makefile
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025-2026 Cornelis Networks, Inc.
+#
+# HFI 2 driver
+#
+#
+#
+# Called from the kernel module build system.
+#
+obj-$(CONFIG_INFINIBAND_HFI2) += hfi2.o
+
+ccflags-$(CONFIG_HFI2_SDMA_VERBOSITY) += -DCONFIG_HFI2_SDMA_VERBOSITY
+KBUILD_EXTRA_SYMBOLS := $(srctree)/drivers/infiniband/sw/rdmavt/Module.symvers
+
+hfi2-y := \
+	affinity.o \
+	aspm.o \
+	chip.o \
+	chip_counters.o \
+	chip_gen.o \
+	chip_jkr.o \
+	cport.o \
+	driver.o \
+	efivar.o \
+	eprom.o \
+	exp_rcv.o \
+	file_ops.o \
+	firmware.o \
+	init.o \
+	intr.o \
+	iowait.o \
+	ipoib_main.o \
+	ipoib_rx.o \
+	ipoib_tx.o \
+	mad.o \
+	mmu_rb.o \
+	msix.o \
+	netdev_rx.o \
+	opfn.o \
+	pcie.o \
+	pinning.o \
+	pin_system.o \
+	pio.o \
+	pio_copy.o \
+	platform.o \
+	qp.o \
+	qsfp.o \
+	rc.o \
+	ruc.o \
+	sdma.o \
+	sriov.o \
+	sysfs.o \
+	tid_rdma.o \
+	tid_system.o \
+	trace.o \
+	uc.o \
+	ud.o \
+	user_exp_rcv.o \
+	user_pages.o \
+	user_sdma.o \
+	uverbs.o \
+	verbs.o \
+	verbs_txreq.o \
+	vf2pf.o \
+	vf2pf_lb.o
+
+ifdef CONFIG_DEBUG_FS
+hfi2-y += debugfs.o
+ifdef CONFIG_FAULT_INJECTION
+ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+hfi2-y += fault.o
+endif
+endif
+endif
+
+CFLAGS_trace.o = -I$(src)
diff --git a/drivers/infiniband/hw/hfi2/debugfs.c b/drivers/infiniband/hw/hfi2/debugfs.c
new file mode 100644
index 000000000000..b89e53f8fcf0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/debugfs.c
@@ -0,0 +1,1551 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015-2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/kernel.h>
+#include <linux/export.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/ratelimit.h>
+#include <linux/fault-inject.h>
+
+#include "hfi2.h"
+#include "trace.h"
+#include "debugfs.h"
+#include "qp.h"
+#include "sdma.h"
+#include "fault.h"
+#include "cport.h"
+
+static struct dentry *hfi2_dbg_root;
+
+#define private2dd(file) (file_inode(file)->i_private)
+#define private2ppd(file) (file_inode(file)->i_private)
+
+static void *_opcode_stats_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct hfi2_opcode_stats_perctx *opstats;
+
+	if (*pos >= ARRAY_SIZE(opstats->stats))
+		return NULL;
+	return pos;
+}
+
+static void *_opcode_stats_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct hfi2_opcode_stats_perctx *opstats;
+
+	++*pos;
+	if (*pos >= ARRAY_SIZE(opstats->stats))
+		return NULL;
+	return pos;
+}
+
+static void _opcode_stats_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int opcode_stats_show(struct seq_file *s, u8 i, u64 packets, u64 bytes)
+{
+	if (!packets && !bytes)
+		return SEQ_SKIP;
+	seq_printf(s, "%02x %llu/%llu\n", i,
+		   (unsigned long long)packets,
+		   (unsigned long long)bytes);
+
+	return 0;
+}
+
+static int _opcode_stats_seq_show(struct seq_file *s, void *v)
+{
+	loff_t *spos = v;
+	loff_t i = *spos, j;
+	u64 n_packets = 0, n_bytes = 0;
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct hfi2_ctxtdata *rcd;
+	int pidx;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		for (j = 0; j < pr->n_krcv_queues; j++) {
+			u16 ctxt = pr->rcv_context_base + j;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			if (rcd) {
+				n_packets += rcd->opstats->stats[i].n_packets;
+				n_bytes += rcd->opstats->stats[i].n_bytes;
+			}
+			hfi2_rcd_put(rcd);
+		}
+	}
+	return opcode_stats_show(s, i, n_packets, n_bytes);
+}
+
+DEBUGFS_SEQ_FILE_OPS(opcode_stats);
+DEBUGFS_SEQ_FILE_OPEN(opcode_stats)
+DEBUGFS_FILE_OPS(opcode_stats);
+
+static void *_tx_opcode_stats_seq_start(struct seq_file *s, loff_t *pos)
+{
+	return _opcode_stats_seq_start(s, pos);
+}
+
+static void *_tx_opcode_stats_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	return _opcode_stats_seq_next(s, v, pos);
+}
+
+static void _tx_opcode_stats_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int _tx_opcode_stats_seq_show(struct seq_file *s, void *v)
+{
+	loff_t *spos = v;
+	loff_t i = *spos;
+	int j;
+	u64 n_packets = 0, n_bytes = 0;
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+
+	for_each_possible_cpu(j) {
+		struct hfi2_opcode_stats_perctx *s =
+			per_cpu_ptr(dd->tx_opstats, j);
+		n_packets += s->stats[i].n_packets;
+		n_bytes += s->stats[i].n_bytes;
+	}
+	return opcode_stats_show(s, i, n_packets, n_bytes);
+}
+
+DEBUGFS_SEQ_FILE_OPS(tx_opcode_stats);
+DEBUGFS_SEQ_FILE_OPEN(tx_opcode_stats)
+DEBUGFS_FILE_OPS(tx_opcode_stats);
+
+static void *_ctx_stats_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+
+	/* plan: iterate through all rcds, looking for kernel contexts */
+
+	/* starting point must be in range */
+	if (*pos >= dd->num_rcd)
+		return NULL;
+
+	return pos;
+}
+
+static void *_ctx_stats_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+
+	++*pos;
+	if (*pos >= dd->num_rcd)
+		return NULL;
+
+	return pos;
+}
+
+static void _ctx_stats_seq_stop(struct seq_file *s, void *v)
+{
+	/* nothing allocated */
+}
+
+static int _ctx_stats_seq_show(struct seq_file *s, void *v)
+{
+	loff_t *spos;
+	loff_t i, j;
+	u64 n_packets = 0;
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	struct hfi2_ctxtdata *rcd;
+
+	spos = v;
+	i = *spos;
+
+	if (i == 0)
+		seq_puts(s, "Ctx:npkts\n");
+
+	rcd = hfi2_rcd_get_by_index(dd, i);
+	if (!rcd)
+		return 0;
+
+	/* only kernel contexts have opstats */
+	if (rcd->opstats) {
+		for (j = 0; j < ARRAY_SIZE(rcd->opstats->stats); j++)
+			n_packets += rcd->opstats->stats[j].n_packets;
+	}
+
+	hfi2_rcd_put(rcd);
+
+	if (!n_packets)
+		return 0;
+
+	seq_printf(s, "  %llu:%llu\n", i, n_packets);
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(ctx_stats);
+DEBUGFS_SEQ_FILE_OPEN(ctx_stats)
+DEBUGFS_FILE_OPS(ctx_stats);
+
+static void *_qp_stats_seq_start(struct seq_file *s, loff_t *pos)
+	__acquires(RCU)
+{
+	struct rvt_qp_iter *iter;
+	loff_t n = *pos;
+
+	iter = rvt_qp_iter_init(s->private, 0, NULL);
+
+	/* stop calls rcu_read_unlock */
+	rcu_read_lock();
+
+	if (!iter)
+		return NULL;
+
+	do {
+		if (rvt_qp_iter_next(iter)) {
+			kfree(iter);
+			return NULL;
+		}
+	} while (n--);
+
+	return iter;
+}
+
+static void *_qp_stats_seq_next(struct seq_file *s, void *iter_ptr,
+				loff_t *pos)
+	__must_hold(RCU)
+{
+	struct rvt_qp_iter *iter = iter_ptr;
+
+	(*pos)++;
+
+	if (rvt_qp_iter_next(iter)) {
+		kfree(iter);
+		return NULL;
+	}
+
+	return iter;
+}
+
+static void _qp_stats_seq_stop(struct seq_file *s, void *iter_ptr)
+	__releases(RCU)
+{
+	rcu_read_unlock();
+}
+
+static int _qp_stats_seq_show(struct seq_file *s, void *iter_ptr)
+{
+	struct rvt_qp_iter *iter = iter_ptr;
+
+	if (!iter)
+		return 0;
+
+	hfi2_qp_iter_print(s, iter);
+
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(qp_stats);
+DEBUGFS_SEQ_FILE_OPEN(qp_stats)
+DEBUGFS_FILE_OPS(qp_stats);
+
+static void *_sdes_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd;
+	struct hfi2_devdata *dd;
+
+	ibd = (struct hfi2_ibdev *)s->private;
+	dd = dd_from_dev(ibd);
+	if (!dd->per_sdma || *pos >= dd->num_sdma)
+		return NULL;
+	return pos;
+}
+
+static void *_sdes_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+
+	++*pos;
+	if (!dd->per_sdma || *pos >= dd->num_sdma)
+		return NULL;
+	return pos;
+}
+
+static void _sdes_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int _sdes_seq_show(struct seq_file *s, void *v)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	loff_t *spos = v;
+	loff_t i = *spos;
+
+	if (dd->per_sdma && i >= dr->first_sdma_engine && i < dr->last_sdma_engine)
+		sdma_seqfile_dump_sde(s, &dd->per_sdma[i]);
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(sdes);
+DEBUGFS_SEQ_FILE_OPEN(sdes)
+DEBUGFS_FILE_OPS(sdes);
+
+static void *_rcds_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd;
+	struct hfi2_devdata *dd;
+
+	ibd = (struct hfi2_ibdev *)s->private;
+	dd = dd_from_dev(ibd);
+	if (!dd->rcd || *pos >= dd->num_rcd)
+		return NULL;
+	return pos;
+}
+
+static void *_rcds_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+
+	++*pos;
+	if (!dd->rcd || *pos >= dd->num_rcd)
+		return NULL;
+	return pos;
+}
+
+static void _rcds_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int _rcds_seq_show(struct seq_file *s, void *v)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	struct hfi2_ctxtdata *rcd;
+	loff_t *spos = v;
+	loff_t i = *spos;
+
+	rcd = hfi2_rcd_get_by_index(dd, i);
+	if (rcd)
+		seqfile_dump_rcd(s, rcd);
+	hfi2_rcd_put(rcd);
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(rcds);
+DEBUGFS_SEQ_FILE_OPEN(rcds)
+DEBUGFS_FILE_OPS(rcds);
+
+static void *_pios_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd;
+	struct hfi2_devdata *dd;
+
+	ibd = (struct hfi2_ibdev *)s->private;
+	dd = dd_from_dev(ibd);
+	if (!dd->send_contexts || *pos >= dd->num_send_contexts)
+		return NULL;
+	return pos;
+}
+
+static void *_pios_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+
+	++*pos;
+	if (!dd->send_contexts || *pos >= dd->num_send_contexts)
+		return NULL;
+	return pos;
+}
+
+static void _pios_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int _pios_seq_show(struct seq_file *s, void *v)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	struct send_context_info *sci;
+	loff_t *spos = v;
+	loff_t i = *spos;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->sc_lock, flags);
+	sci = &dd->send_contexts[i];
+	if (sci && sci->type != SC_USER && sci->allocated && sci->sc)
+		seqfile_dump_sci(s, i, sci);
+	spin_unlock_irqrestore(&dd->sc_lock, flags);
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(pios);
+DEBUGFS_SEQ_FILE_OPEN(pios)
+DEBUGFS_FILE_OPS(pios);
+
+/* read the per-device counters */
+static ssize_t dev_counters_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	u64 *counters;
+	size_t avail;
+	struct hfi2_devdata *dd;
+	ssize_t rval;
+
+	dd = private2dd(file);
+	avail = hfi2_read_cntrs(dd, NULL, &counters);
+	rval =  simple_read_from_buffer(buf, count, ppos, counters, avail);
+	return rval;
+}
+
+/* read the per-device counters */
+static ssize_t dev_names_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	char *names;
+	size_t avail;
+	struct hfi2_devdata *dd;
+	ssize_t rval;
+
+	dd = private2dd(file);
+	avail = hfi2_read_cntrs(dd, &names, NULL);
+	rval =  simple_read_from_buffer(buf, count, ppos, names, avail);
+	return rval;
+}
+
+struct counter_info {
+	char *name;
+	const struct file_operations ops;
+};
+
+/*
+ * Could use file_inode(file)->i_ino to figure out which file,
+ * instead of separate routine for each, but for now, this works...
+ */
+
+/* read the per-port names (same for each port) */
+static ssize_t portnames_read(struct file *file, char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	char *names;
+	size_t avail;
+	struct hfi2_devdata *dd;
+	ssize_t rval;
+
+	dd = private2dd(file);
+	avail = hfi2_read_portcntrs(dd->pport, &names, NULL);
+	rval = simple_read_from_buffer(buf, count, ppos, names, avail);
+	return rval;
+}
+
+/* read the per-port counters */
+static ssize_t portcntrs_debugfs_read(struct file *file, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	u64 *counters;
+	size_t avail;
+	struct hfi2_pportdata *ppd;
+	ssize_t rval;
+
+	ppd = private2ppd(file);
+	avail = hfi2_read_portcntrs(ppd, NULL, &counters);
+	rval = simple_read_from_buffer(buf, count, ppos, counters, avail);
+	return rval;
+}
+
+static void check_dyn_flag(u64 scratch0, char *p, int size, int *used,
+			   int this_hfi, int hfi, u32 flag, const char *what)
+{
+	u32 mask;
+
+	mask = flag << (hfi ? CR_DYN_SHIFT : 0);
+	if (scratch0 & mask) {
+		*used += scnprintf(p + *used, size - *used,
+				   "  0x%08x - HFI%d %s in use, %s device\n",
+				   mask, hfi, what,
+				   this_hfi == hfi ? "this" : "other");
+	}
+}
+
+static ssize_t asic_flags_read(struct file *file, char __user *buf,
+			       size_t count, loff_t *ppos)
+{
+	struct hfi2_devdata *dd;
+	u64 scratch0;
+	char *tmp;
+	int ret = 0;
+	int size;
+	int used;
+	int i;
+
+	dd = private2dd(file);
+	size = PAGE_SIZE;
+	used = 0;
+	tmp = kmalloc(size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	scratch0 = read_csr(dd, ASIC_CFG_SCRATCH);
+	used += scnprintf(tmp + used, size - used,
+			  "Resource flags: 0x%016llx\n", scratch0);
+
+	/* check permanent flag */
+	if (scratch0 & CR_THERM_INIT) {
+		used += scnprintf(tmp + used, size - used,
+				  "  0x%08x - thermal monitoring initialized\n",
+				  (u32)CR_THERM_INIT);
+	}
+
+	/* check each dynamic flag on each HFI */
+	for (i = 0; i < 2; i++) {
+		check_dyn_flag(scratch0, tmp, size, &used, dd->hfi2_id, i,
+			       CR_SBUS, "SBus");
+		check_dyn_flag(scratch0, tmp, size, &used, dd->hfi2_id, i,
+			       CR_EPROM, "EPROM");
+		check_dyn_flag(scratch0, tmp, size, &used, dd->hfi2_id, i,
+			       CR_I2C1, "i2c chain 1");
+		check_dyn_flag(scratch0, tmp, size, &used, dd->hfi2_id, i,
+			       CR_I2C2, "i2c chain 2");
+	}
+	used += scnprintf(tmp + used, size - used, "Write bits to clear\n");
+
+	ret = simple_read_from_buffer(buf, count, ppos, tmp, used);
+	kfree(tmp);
+	return ret;
+}
+
+static ssize_t asic_flags_write(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct hfi2_devdata *dd;
+	char *buff;
+	int ret;
+	unsigned long long value;
+	u64 scratch0;
+	u64 clear;
+
+	dd = private2dd(file);
+
+	if (!dd->asic_data)
+		return -EINVAL;
+
+	/* zero terminate and read the expected integer */
+	buff = memdup_user_nul(buf, count);
+	if (IS_ERR(buff))
+		return PTR_ERR(buff);
+
+	ret = kstrtoull(buff, 0, &value);
+	if (ret)
+		goto do_free;
+	clear = value;
+
+	/* obtain exclusive access */
+	mutex_lock(&dd->asic_data->asic_resource_mutex);
+	acquire_hw_mutex(dd);
+
+	scratch0 = read_csr(dd, ASIC_CFG_SCRATCH);
+	scratch0 &= ~clear;
+	write_csr(dd, ASIC_CFG_SCRATCH, scratch0);
+	/* force write to be visible to other HFI on another OS */
+	(void)read_csr(dd, ASIC_CFG_SCRATCH);
+
+	release_hw_mutex(dd);
+	mutex_unlock(&dd->asic_data->asic_resource_mutex);
+
+	/* return the number of bytes written */
+	ret = count;
+
+ do_free:
+	kfree(buff);
+	return ret;
+}
+
+/* read the dc8051 memory */
+static ssize_t dc8051_memory_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	struct hfi2_pportdata *ppd = private2ppd(file);
+	ssize_t rval;
+	void *tmp;
+	loff_t start, end;
+
+	/* the checks below expect the position to be positive */
+	if (*ppos < 0)
+		return -EINVAL;
+
+	tmp = kzalloc(DC8051_DATA_MEM_SIZE, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	/*
+	 * Fill in the requested portion of the temporary buffer from the
+	 * 8051 memory.  The 8051 memory read is done in terms of 8 bytes.
+	 * Adjust start and end to fit.  Skip reading anything if out of
+	 * range.
+	 */
+	start = *ppos & ~0x7;	/* round down */
+	if (start < DC8051_DATA_MEM_SIZE) {
+		end = (*ppos + count + 7) & ~0x7; /* round up */
+		if (end > DC8051_DATA_MEM_SIZE)
+			end = DC8051_DATA_MEM_SIZE;
+		rval = read_8051_data(ppd->dd, start, end - start,
+				      (u64 *)(tmp + start));
+		if (rval)
+			goto done;
+	}
+
+	rval = simple_read_from_buffer(buf, count, ppos, tmp,
+				       DC8051_DATA_MEM_SIZE);
+done:
+	kfree(tmp);
+	return rval;
+}
+
+static ssize_t debugfs_lcb_read(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	struct hfi2_pportdata *ppd = private2ppd(file);
+	unsigned long total, csr_off;
+	u64 data;
+
+	if (*ppos < 0)
+		return -EINVAL;
+	/* only read 8 byte quantities */
+	if ((count % 8) != 0)
+		return -EINVAL;
+	/* offset must be 8-byte aligned */
+	if ((*ppos % 8) != 0)
+		return -EINVAL;
+	/* do nothing if out of range or zero count */
+	if (*ppos >= (LCB_END - LCB_START) || !count)
+		return 0;
+	/* reduce count if needed */
+	if (*ppos + count > LCB_END - LCB_START)
+		count = (LCB_END - LCB_START) - *ppos;
+
+	csr_off = LCB_START + *ppos;
+	for (total = 0; total < count; total += 8, csr_off += 8) {
+		if (read_lcb_csr(ppd, csr_off, (u64 *)&data))
+			break; /* failed */
+		if (put_user(data, (unsigned long __user *)(buf + total)))
+			break;
+	}
+	*ppos += total;
+	return total;
+}
+
+static ssize_t debugfs_lcb_write(struct file *file, const char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct hfi2_pportdata *ppd = private2ppd(file);
+	unsigned long total, csr_off, data;
+
+	if (*ppos < 0)
+		return -EINVAL;
+	/* only write 8 byte quantities */
+	if ((count % 8) != 0)
+		return -EINVAL;
+	/* offset must be 8-byte aligned */
+	if ((*ppos % 8) != 0)
+		return -EINVAL;
+	/* do nothing if out of range or zero count */
+	if (*ppos >= (LCB_END - LCB_START) || !count)
+		return 0;
+	/* reduce count if needed */
+	if (*ppos + count > LCB_END - LCB_START)
+		count = (LCB_END - LCB_START) - *ppos;
+
+	csr_off = LCB_START + *ppos;
+	for (total = 0; total < count; total += 8, csr_off += 8) {
+		if (get_user(data, (unsigned long __user *)(buf + total)))
+			break;
+		if (write_lcb_csr(ppd, csr_off, data))
+			break; /* failed */
+	}
+	*ppos += total;
+	return total;
+}
+
+/*
+ * read the per-port QSFP data for ppd
+ */
+static ssize_t qsfp_debugfs_dump(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	struct hfi2_pportdata *ppd;
+	char *tmp;
+	int ret;
+
+	ppd = private2ppd(file);
+	tmp = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	ret = qsfp_dump(ppd, tmp, PAGE_SIZE);
+	if (ret > 0)
+		ret = simple_read_from_buffer(buf, count, ppos, tmp, ret);
+	kfree(tmp);
+	return ret;
+}
+
+/* Do an i2c write operation on the chain for the given HFI. */
+static ssize_t __i2c_debugfs_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+	char *buff;
+	int ret;
+	int i2c_addr;
+	int offset;
+	int total_written;
+
+	ppd = private2ppd(file);
+
+	/* byte offset format: [offsetSize][i2cAddr][offsetHigh][offsetLow] */
+	i2c_addr = (*ppos >> 16) & 0xffff;
+	offset = *ppos & 0xffff;
+
+	/* explicitly reject invalid address 0 to catch cp and cat */
+	if (i2c_addr == 0)
+		return -EINVAL;
+
+	buff = memdup_user(buf, count);
+	if (IS_ERR(buff))
+		return PTR_ERR(buff);
+
+	total_written = i2c_write(ppd, target, i2c_addr, offset, buff, count);
+	if (total_written < 0) {
+		ret = total_written;
+		goto _free;
+	}
+
+	*ppos += total_written;
+
+	ret = total_written;
+
+ _free:
+	kfree(buff);
+	return ret;
+}
+
+/* Do an i2c write operation on chain for HFI 0. */
+static ssize_t i2c1_debugfs_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	return __i2c_debugfs_write(file, buf, count, ppos, 0);
+}
+
+/* Do an i2c write operation on chain for HFI 1. */
+static ssize_t i2c2_debugfs_write(struct file *file, const char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	return __i2c_debugfs_write(file, buf, count, ppos, 1);
+}
+
+/* Do an i2c read operation on the chain for the given HFI. */
+static ssize_t __i2c_debugfs_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+	char *buff;
+	int ret;
+	int i2c_addr;
+	int offset;
+	int total_read;
+
+	ppd = private2ppd(file);
+
+	/* byte offset format: [offsetSize][i2cAddr][offsetHigh][offsetLow] */
+	i2c_addr = (*ppos >> 16) & 0xffff;
+	offset = *ppos & 0xffff;
+
+	/* explicitly reject invalid address 0 to catch cp and cat */
+	if (i2c_addr == 0)
+		return -EINVAL;
+
+	buff = kmalloc(count, GFP_KERNEL);
+	if (!buff)
+		return -ENOMEM;
+
+	total_read = i2c_read(ppd, target, i2c_addr, offset, buff, count);
+	if (total_read < 0) {
+		ret = total_read;
+		goto _free;
+	}
+
+	*ppos += total_read;
+
+	ret = copy_to_user(buf, buff, total_read);
+	if (ret > 0) {
+		ret = -EFAULT;
+		goto _free;
+	}
+
+	ret = total_read;
+
+ _free:
+	kfree(buff);
+	return ret;
+}
+
+/* Do an i2c read operation on chain for HFI 0. */
+static ssize_t i2c1_debugfs_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	return __i2c_debugfs_read(file, buf, count, ppos, 0);
+}
+
+/* Do an i2c read operation on chain for HFI 1. */
+static ssize_t i2c2_debugfs_read(struct file *file, char __user *buf,
+				 size_t count, loff_t *ppos)
+{
+	return __i2c_debugfs_read(file, buf, count, ppos, 1);
+}
+
+/* Do a QSFP write operation on the i2c chain for the given HFI. */
+static ssize_t __qsfp_debugfs_write(struct file *file, const char __user *buf,
+				    size_t count, loff_t *ppos, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+	char *buff;
+	int ret;
+	int total_written;
+
+	if (*ppos + count > QSFP_PAGESIZE * 4) /* base page + page00-page03 */
+		return -EINVAL;
+
+	ppd = private2ppd(file);
+
+	buff = memdup_user(buf, count);
+	if (IS_ERR(buff))
+		return PTR_ERR(buff);
+
+	total_written = qsfp_write(ppd, target, *ppos, buff, count);
+	if (total_written < 0) {
+		ret = total_written;
+		goto _free;
+	}
+
+	*ppos += total_written;
+
+	ret = total_written;
+
+ _free:
+	kfree(buff);
+	return ret;
+}
+
+/* Do a QSFP write operation on i2c chain for HFI 0. */
+static ssize_t qsfp1_debugfs_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	return __qsfp_debugfs_write(file, buf, count, ppos, 0);
+}
+
+/* Do a QSFP write operation on i2c chain for HFI 1. */
+static ssize_t qsfp2_debugfs_write(struct file *file, const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	return __qsfp_debugfs_write(file, buf, count, ppos, 1);
+}
+
+/* Do a QSFP read operation on the i2c chain for the given HFI. */
+static ssize_t __qsfp_debugfs_read(struct file *file, char __user *buf,
+				   size_t count, loff_t *ppos, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+	char *buff;
+	int ret;
+	int total_read;
+
+	if (*ppos + count > QSFP_PAGESIZE * 4) { /* base page + page00-page03 */
+		ret = -EINVAL;
+		goto _return;
+	}
+
+	ppd = private2ppd(file);
+
+	buff = kmalloc(count, GFP_KERNEL);
+	if (!buff) {
+		ret = -ENOMEM;
+		goto _return;
+	}
+
+	total_read = qsfp_read(ppd, target, *ppos, buff, count);
+	if (total_read < 0) {
+		ret = total_read;
+		goto _free;
+	}
+
+	*ppos += total_read;
+
+	ret = copy_to_user(buf, buff, total_read);
+	if (ret > 0) {
+		ret = -EFAULT;
+		goto _free;
+	}
+
+	ret = total_read;
+
+ _free:
+	kfree(buff);
+ _return:
+	return ret;
+}
+
+/* Do a QSFP read operation on i2c chain for HFI 0. */
+static ssize_t qsfp1_debugfs_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	return __qsfp_debugfs_read(file, buf, count, ppos, 0);
+}
+
+/* Do a QSFP read operation on i2c chain for HFI 1. */
+static ssize_t qsfp2_debugfs_read(struct file *file, char __user *buf,
+				  size_t count, loff_t *ppos)
+{
+	return __qsfp_debugfs_read(file, buf, count, ppos, 1);
+}
+
+static int __i2c_debugfs_open(struct inode *in, struct file *fp, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+
+	ppd = private2ppd(fp);
+
+	return acquire_chip_resource(ppd->dd, i2c_target(target), 0);
+}
+
+static int i2c1_debugfs_open(struct inode *in, struct file *fp)
+{
+	return __i2c_debugfs_open(in, fp, 0);
+}
+
+static int i2c2_debugfs_open(struct inode *in, struct file *fp)
+{
+	return __i2c_debugfs_open(in, fp, 1);
+}
+
+static int __i2c_debugfs_release(struct inode *in, struct file *fp, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+
+	ppd = private2ppd(fp);
+
+	release_chip_resource(ppd->dd, i2c_target(target));
+
+	return 0;
+}
+
+static int i2c1_debugfs_release(struct inode *in, struct file *fp)
+{
+	return __i2c_debugfs_release(in, fp, 0);
+}
+
+static int i2c2_debugfs_release(struct inode *in, struct file *fp)
+{
+	return __i2c_debugfs_release(in, fp, 1);
+}
+
+static int __qsfp_debugfs_open(struct inode *in, struct file *fp, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+
+	ppd = private2ppd(fp);
+
+	return acquire_chip_resource(ppd->dd, i2c_target(target), 0);
+}
+
+static int qsfp1_debugfs_open(struct inode *in, struct file *fp)
+{
+	return __qsfp_debugfs_open(in, fp, 0);
+}
+
+static int qsfp2_debugfs_open(struct inode *in, struct file *fp)
+{
+	return __qsfp_debugfs_open(in, fp, 1);
+}
+
+static int __qsfp_debugfs_release(struct inode *in, struct file *fp, u32 target)
+{
+	struct hfi2_pportdata *ppd;
+
+	ppd = private2ppd(fp);
+
+	release_chip_resource(ppd->dd, i2c_target(target));
+
+	return 0;
+}
+
+static int qsfp1_debugfs_release(struct inode *in, struct file *fp)
+{
+	return __qsfp_debugfs_release(in, fp, 0);
+}
+
+static int qsfp2_debugfs_release(struct inode *in, struct file *fp)
+{
+	return __qsfp_debugfs_release(in, fp, 1);
+}
+
+#define EXPROM_WRITE_ENABLE BIT_ULL(14)
+
+static bool exprom_wp_disabled;
+
+static int exprom_wp_set(struct hfi2_devdata *dd, bool disable)
+{
+	u64 gpio_val = 0;
+
+	if (disable) {
+		gpio_val = EXPROM_WRITE_ENABLE;
+		exprom_wp_disabled = true;
+		dd_dev_info(dd, "Disable Expansion ROM Write Protection\n");
+	} else {
+		exprom_wp_disabled = false;
+		dd_dev_info(dd, "Enable Expansion ROM Write Protection\n");
+	}
+
+	write_csr(dd, ASIC_GPIO_OUT, gpio_val);
+	write_csr(dd, ASIC_GPIO_OE, gpio_val);
+
+	return 0;
+}
+
+static ssize_t exprom_wp_debugfs_read(struct file *file, char __user *buf,
+				      size_t count, loff_t *ppos)
+{
+	return 0;
+}
+
+static ssize_t exprom_wp_debugfs_write(struct file *file,
+				       const char __user *buf, size_t count,
+				       loff_t *ppos)
+{
+	struct hfi2_pportdata *ppd = private2ppd(file);
+	char cdata;
+
+	if (count != 1)
+		return -EINVAL;
+	if (get_user(cdata, buf))
+		return -EFAULT;
+	if (cdata == '0')
+		exprom_wp_set(ppd->dd, false);
+	else if (cdata == '1')
+		exprom_wp_set(ppd->dd, true);
+	else
+		return -EINVAL;
+
+	return 1;
+}
+
+static unsigned long exprom_in_use;
+
+static int exprom_wp_debugfs_open(struct inode *in, struct file *fp)
+{
+	if (test_and_set_bit(0, &exprom_in_use))
+		return -EBUSY;
+
+	return 0;
+}
+
+static int exprom_wp_debugfs_release(struct inode *in, struct file *fp)
+{
+	struct hfi2_pportdata *ppd = private2ppd(fp);
+
+	if (exprom_wp_disabled)
+		exprom_wp_set(ppd->dd, false);
+	clear_bit(0, &exprom_in_use);
+
+	return 0;
+}
+
+#define DEBUGFS_OPS(nm, readroutine, writeroutine)	\
+{ \
+	.name = nm, \
+	.ops = { \
+		.owner = THIS_MODULE, \
+		.read = readroutine, \
+		.write = writeroutine, \
+		.llseek = generic_file_llseek, \
+	}, \
+}
+
+#define DEBUGFS_XOPS(nm, readf, writef, openf, releasef) \
+{ \
+	.name = nm, \
+	.ops = { \
+		.owner = THIS_MODULE, \
+		.read = readf, \
+		.write = writef, \
+		.llseek = generic_file_llseek, \
+		.open = openf, \
+		.release = releasef \
+	}, \
+}
+
+static const struct counter_info cntr_ops[] = {
+	DEBUGFS_OPS("counter_names", dev_names_read, NULL),
+	DEBUGFS_OPS("counters", dev_counters_read, NULL),
+	DEBUGFS_OPS("portcounter_names", portnames_read, NULL),
+};
+
+static const struct counter_info wfr_cntr_ops[] = {
+	DEBUGFS_OPS("asic_flags", asic_flags_read, asic_flags_write),
+};
+
+static const struct counter_info port_cntr_ops[] = {
+	DEBUGFS_OPS("port%dcounters", portcntrs_debugfs_read, NULL),
+};
+
+static const struct counter_info wfr_port_cntr_ops[] = {
+	DEBUGFS_XOPS("i2c1", i2c1_debugfs_read, i2c1_debugfs_write,
+		     i2c1_debugfs_open, i2c1_debugfs_release),
+	DEBUGFS_XOPS("i2c2", i2c2_debugfs_read, i2c2_debugfs_write,
+		     i2c2_debugfs_open, i2c2_debugfs_release),
+	DEBUGFS_OPS("qsfp_dump%d", qsfp_debugfs_dump, NULL),
+	DEBUGFS_XOPS("qsfp1", qsfp1_debugfs_read, qsfp1_debugfs_write,
+		     qsfp1_debugfs_open, qsfp1_debugfs_release),
+	DEBUGFS_XOPS("qsfp2", qsfp2_debugfs_read, qsfp2_debugfs_write,
+		     qsfp2_debugfs_open, qsfp2_debugfs_release),
+	DEBUGFS_XOPS("exprom_wp", exprom_wp_debugfs_read,
+		     exprom_wp_debugfs_write, exprom_wp_debugfs_open,
+		     exprom_wp_debugfs_release),
+	DEBUGFS_OPS("dc8051_memory", dc8051_memory_read, NULL),
+	DEBUGFS_OPS("lcb", debugfs_lcb_read, debugfs_lcb_write),
+};
+
+static void *_sdma_cpu_list_seq_start(struct seq_file *s, loff_t *pos)
+{
+	if (*pos >= num_online_cpus())
+		return NULL;
+
+	return pos;
+}
+
+static void *_sdma_cpu_list_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos >= num_online_cpus())
+		return NULL;
+
+	return pos;
+}
+
+static void _sdma_cpu_list_seq_stop(struct seq_file *s, void *v)
+{
+	/* nothing allocated */
+}
+
+static int _sdma_cpu_list_seq_show(struct seq_file *s, void *v)
+{
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	loff_t *spos = v;
+	loff_t i = *spos;
+
+	sdma_seqfile_dump_cpu_list(s, dd, (unsigned long)i);
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(sdma_cpu_list);
+DEBUGFS_SEQ_FILE_OPEN(sdma_cpu_list)
+DEBUGFS_FILE_OPS(sdma_cpu_list);
+
+static ssize_t link_debug_read(struct file *file,
+			       char __user *user_buf, size_t count,
+			       loff_t *ppos)
+{
+	return 0;
+}
+
+static void fake_linkup(struct hfi2_devdata *dd, int pidx)
+{
+	struct hfi2_pportdata *ppd;
+
+	if (pidx < 0 || pidx >= dd->num_pports) {
+		pr_info("%s: invalid port index %d\n", __func__, pidx);
+		return;
+	}
+	ppd = &dd->pport[pidx];
+
+	pr_info("%s: fake linkup port index %d\n", __func__, pidx);
+	ppd->host_link_state = HLS_UP_INIT;
+	handle_linkup_change(ppd, 1);
+}
+
+static void fake_linkdown(struct hfi2_devdata *dd, int pidx)
+{
+	struct hfi2_pportdata *ppd;
+
+	if (pidx < 0 || pidx >= dd->num_pports) {
+		pr_info("%s: invalid port index %d\n", __func__, pidx);
+		return;
+	}
+	ppd = &dd->pport[pidx];
+
+	pr_info("%s: fake linkdown port index %d\n", __func__, pidx);
+	ppd->host_link_state = HLS_DN_OFFLINE;
+	handle_linkup_change(ppd, 0);
+}
+
+static void fake_active(struct hfi2_devdata *dd, int pidx)
+{
+	struct hfi2_pportdata *ppd;
+	struct ib_event event = { 0 };
+	u32 lid;
+	u8 lmc;
+
+	if (pidx < 0 || pidx >= dd->num_pports) {
+		pr_info("%s: invalid port index %d\n", __func__, pidx);
+		return;
+	}
+	ppd = &dd->pport[pidx];
+
+	/* IB Port 1 = LID 1, IB Port 2 = LID 2 */
+	lid = pidx + 1;
+	lmc = 0x0;	/* only allow 1 */
+
+	printk("%s: fake active port index %d, lid %d (with set_mtu call)\n",
+		__func__, pidx, lid);
+
+	/*
+	 * From __subn_set_opa_portinfo().  In there, this comes after
+	 * call to hfi2_set_lid().
+	 *
+	 * Need to set SendCtxtCreditCtrl.  Can be set after setting
+	 * host_link_state, but it may be simpler to do it before.
+	 */
+	set_mtu(ppd);
+
+	/* swiped from __subn_set_opa_portinfo() */
+	hfi2_set_lid(ppd, lid, lmc);
+
+	ppd->host_link_state = HLS_UP_ACTIVE;
+
+	event.device = &dd->verbs_dev.rdi.ibdev;
+	event.element.port_num = pidx + 1;
+	event.event = IB_EVENT_LID_CHANGE;
+	ib_dispatch_event(&event);
+	ppd->guids[HFI2_PORT_GUID_INDEX + 1] = be64_to_cpu(OPA_MAKE_ID(lid));
+	event.event = IB_EVENT_GID_CHANGE;
+	ib_dispatch_event(&event);
+
+	/* swiped from set_link_state - sorta.  go_port_active() is new in this
+	 * stack of patches
+	 */
+	go_port_active(ppd);
+}
+
+static ssize_t link_debug_write(struct file *file,
+				const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct hfi2_devdata *dd = file->private_data;
+	char buf[128];
+	size_t buf_size;
+
+	buf_size = min(count, (sizeof(buf) - 1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+	buf[buf_size] = 0;
+
+	if (strcmp(buf, "linkup0\n") == 0)
+		fake_linkup(dd, 0);
+	else if (strcmp(buf, "linkup1\n") == 0)
+		fake_linkup(dd, 1);
+	else if (strcmp(buf, "linkdown0\n") == 0)
+		fake_linkdown(dd, 0);
+	else if (strcmp(buf, "linkdown1\n") == 0)
+		fake_linkdown(dd, 1);
+	else if (strcmp(buf, "active0\n") == 0)
+		fake_active(dd, 0);
+	else if (strcmp(buf, "active1\n") == 0)
+		fake_active(dd, 1);
+	else
+		pr_info("%s: unknown command \"%s\"\n", __func__, buf);
+
+	return count;
+}
+
+static const struct file_operations _link_debug_ops = {
+	.open = simple_open,
+	.read = link_debug_read,
+	.write = link_debug_write,
+	.llseek = default_llseek,
+};
+
+static ssize_t cport_ping_read(struct file *file,
+			       char __user *user_buf, size_t count,
+			       loff_t *ppos)
+{
+	struct hfi2_devdata *dd = file->private_data;
+	char buf[16];
+	loff_t pos = *ppos;
+	int len;
+
+	if (pos < 0 || !count)
+		return -EINVAL;
+
+	len = snprintf(buf, sizeof(buf), "%u", atomic_read(&dd->cport->nping));
+	if (pos >= len)
+		return 0;
+	if (count > len - pos)
+		count = len - pos;
+	if (copy_to_user(user_buf, buf + *ppos, count))
+		return -EFAULT;
+
+	*ppos += count;
+	return count;
+}
+
+static ssize_t cport_ping_write(struct file *file,
+				const char __user *user_buf,
+				size_t count, loff_t *ppos)
+{
+	struct hfi2_devdata *dd = file->private_data;
+	char buf[16];
+	char *start = buf;
+	size_t buf_size;
+	unsigned int value;
+	int rc;
+
+	buf_size = min(count, (sizeof(buf) - 1));
+	if (copy_from_user(buf, user_buf, buf_size))
+		return -EFAULT;
+	buf[buf_size] = 0;
+	while (*start == ' ')
+		start++;
+
+	rc = kstrtouint(start, 0, &value);
+	if (rc)
+		return -EINVAL;
+
+	rc = cport_ping_start(dd, value);
+	if (rc)
+		return rc;
+	return count;
+}
+
+static const struct file_operations _cport_ping_ops = {
+	.open = simple_open,
+	.read = cport_ping_read,
+	.write = cport_ping_write,
+	.llseek = default_llseek,
+};
+
+static void add_port_files(struct dentry *root, struct hfi2_pportdata *ppd,
+		      const struct counter_info *port_ops, int num_ops)
+{
+	char name[64];
+	int i;
+
+	for (i = 0; i < num_ops; i++) {
+		snprintf(name, sizeof(name), port_ops[i].name, ppd->port);
+		debugfs_create_file(name, !port_ops[i].ops.write ? 0444 : 0644,
+				    root, ppd, &port_ops[i].ops);
+	}
+}
+
+void hfi2_dbg_ibdev_init(struct hfi2_ibdev *ibd)
+{
+	char name[sizeof("port0counters") + 1];
+	char link[10];
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	struct hfi2_pportdata *ppd;
+	struct dentry *root;
+	int unit = dd->unit;
+	int i;
+
+	if (!hfi2_dbg_root)
+		return;
+	snprintf(name, sizeof(name), "%s_%d", "hfi2", unit);
+	snprintf(link, sizeof(link), "%d", unit);
+	root = debugfs_create_dir(name, hfi2_dbg_root);
+	ibd->hfi2_ibdev_dbg = root;
+
+	ibd->hfi2_ibdev_link =
+		debugfs_create_symlink(link, hfi2_dbg_root, name);
+
+	debugfs_create_file("opcode_stats", 0444, root, ibd,
+			    &_opcode_stats_file_ops);
+	debugfs_create_file("tx_opcode_stats", 0444, root, ibd,
+			    &_tx_opcode_stats_file_ops);
+	debugfs_create_file("ctx_stats", 0444, root, ibd, &_ctx_stats_file_ops);
+	debugfs_create_file("qp_stats", 0444, root, ibd, &_qp_stats_file_ops);
+	debugfs_create_file("sdes", 0444, root, ibd, &_sdes_file_ops);
+	debugfs_create_file("rcds", 0444, root, ibd, &_rcds_file_ops);
+	debugfs_create_file("pios", 0444, root, ibd, &_pios_file_ops);
+	debugfs_create_file("sdma_cpu_list", 0444, root, ibd,
+			    &_sdma_cpu_list_file_ops);
+	if (dd->cport)
+		debugfs_create_file("cport_ping", 0644, root, dd, &_cport_ping_ops);
+	debugfs_create_file("link_debug", 0644, root, dd, &_link_debug_ops);
+
+	/* dev counter files */
+	for (i = 0; i < ARRAY_SIZE(cntr_ops); i++)
+		debugfs_create_file(cntr_ops[i].name, 0444, root, dd,
+				    &cntr_ops[i].ops);
+
+	if (dd->params->chip_type == CHIP_WFR) {
+		for (i = 0; i < ARRAY_SIZE(wfr_cntr_ops); i++) {
+			debugfs_create_file(wfr_cntr_ops[i].name, 0444, root,
+					    dd, &wfr_cntr_ops[i].ops);
+		}
+	}
+
+	/* per port files */
+	for (ppd = dd->pport, i = 0; i < dd->num_pports; i++, ppd++) {
+		add_port_files(root, ppd, port_cntr_ops,
+			       ARRAY_SIZE(port_cntr_ops));
+		if (dd->params->chip_type == CHIP_WFR) {
+			add_port_files(root, ppd, wfr_port_cntr_ops,
+				       ARRAY_SIZE(wfr_port_cntr_ops));
+		}
+	}
+
+	hfi2_fault_init_debugfs(ibd);
+}
+
+void hfi2_dbg_ibdev_exit(struct hfi2_ibdev *ibd)
+{
+	if (!hfi2_dbg_root)
+		goto out;
+	hfi2_fault_exit_debugfs(ibd);
+	debugfs_remove(ibd->hfi2_ibdev_link);
+	debugfs_remove_recursive(ibd->hfi2_ibdev_dbg);
+out:
+	ibd->hfi2_ibdev_dbg = NULL;
+}
+
+/*
+ * driver stats field names, one line per stat, single string.  Used by
+ * programs like hfistats to print the stats in a way which works for
+ * different versions of drivers, without changing program source.
+ * if hfi2_ib_stats changes, this needs to change.  Names need to be
+ * 12 chars or less (w/o newline), for proper display by hfistats utility.
+ */
+static const char * const hfi2_statnames[] = {
+	/* must be element 0*/
+	"KernIntr",
+	"ErrorIntr",
+	"Tx_Errs",
+	"Rcv_Errs",
+	"H/W_Errs",
+	"NoPIOBufs",
+	"CtxtsOpen",
+	"RcvLen_Errs",
+	"EgrBufFull",
+	"EgrHdrFull"
+};
+
+static void *_driver_stats_names_seq_start(struct seq_file *s, loff_t *pos)
+{
+	if (*pos >= ARRAY_SIZE(hfi2_statnames))
+		return NULL;
+	return pos;
+}
+
+static void *_driver_stats_names_seq_next(
+	struct seq_file *s,
+	void *v,
+	loff_t *pos)
+{
+	++*pos;
+	if (*pos >= ARRAY_SIZE(hfi2_statnames))
+		return NULL;
+	return pos;
+}
+
+static void _driver_stats_names_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int _driver_stats_names_seq_show(struct seq_file *s, void *v)
+{
+	loff_t *spos = v;
+
+	seq_printf(s, "%s\n", hfi2_statnames[*spos]);
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(driver_stats_names);
+DEBUGFS_SEQ_FILE_OPEN(driver_stats_names)
+DEBUGFS_FILE_OPS(driver_stats_names);
+
+static void *_driver_stats_seq_start(struct seq_file *s, loff_t *pos)
+{
+	if (*pos >= ARRAY_SIZE(hfi2_statnames))
+		return NULL;
+	return pos;
+}
+
+static void *_driver_stats_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	++*pos;
+	if (*pos >= ARRAY_SIZE(hfi2_statnames))
+		return NULL;
+	return pos;
+}
+
+static void _driver_stats_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static void hfi2_sps_show_ints(struct seq_file *s)
+{
+	unsigned long index, flags;
+	struct hfi2_devdata *dd;
+	u64 sps_ints = 0;
+
+	xa_lock_irqsave(&hfi2_dev_table, flags);
+	xa_for_each(&hfi2_dev_table, index, dd) {
+		sps_ints += get_all_cpu_total(dd->int_counter);
+	}
+	xa_unlock_irqrestore(&hfi2_dev_table, flags);
+	seq_write(s, &sps_ints, sizeof(u64));
+}
+
+static int _driver_stats_seq_show(struct seq_file *s, void *v)
+{
+	loff_t *spos = v;
+	u64 *stats = (u64 *)&hfi2_stats;
+
+	/* special case for interrupts */
+	if (*spos == 0)
+		hfi2_sps_show_ints(s);
+	else
+		seq_write(s, stats + *spos, sizeof(u64));
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(driver_stats);
+DEBUGFS_SEQ_FILE_OPEN(driver_stats)
+DEBUGFS_FILE_OPS(driver_stats);
+
+void hfi2_dbg_init(void)
+{
+	hfi2_dbg_root  = debugfs_create_dir(DRIVER_NAME, NULL);
+	debugfs_create_file("driver_stats_names", 0444, hfi2_dbg_root, NULL,
+			    &_driver_stats_names_file_ops);
+	debugfs_create_file("driver_stats", 0444, hfi2_dbg_root, NULL,
+			    &_driver_stats_file_ops);
+}
+
+void hfi2_dbg_exit(void)
+{
+	debugfs_remove_recursive(hfi2_dbg_root);
+	hfi2_dbg_root = NULL;
+}
diff --git a/drivers/infiniband/hw/hfi2/eprom.c b/drivers/infiniband/hw/hfi2/eprom.c
new file mode 100644
index 000000000000..2e0f81d464de
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/eprom.c
@@ -0,0 +1,451 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/delay.h>
+#include "hfi2.h"
+#include "common.h"
+#include "eprom.h"
+
+/*
+ * The EPROM is logically divided into three partitions:
+ *	partition 0: the first 128K, visible from PCI ROM BAR
+ *	partition 1: 4K config file (sector size)
+ *	partition 2: the rest
+ */
+#define P0_SIZE (128 * 1024)
+#define P1_SIZE   (4 * 1024)
+#define P1_START P0_SIZE
+#define P2_START (P0_SIZE + P1_SIZE)
+
+/* controller page size, in bytes */
+#define EP_PAGE_SIZE 256
+#define EP_PAGE_MASK (EP_PAGE_SIZE - 1)
+#define EP_PAGE_DWORDS (EP_PAGE_SIZE / sizeof(u32))
+
+/* controller commands */
+#define CMD_SHIFT 24
+#define CMD_NOP			    (0)
+#define CMD_READ_DATA(addr)	    ((0x03 << CMD_SHIFT) | addr)
+#define CMD_RELEASE_POWERDOWN_NOID  ((0xab << CMD_SHIFT))
+
+/* controller interface speeds */
+#define EP_SPEED_FULL 0x2	/* full speed */
+
+/*
+ * How long to wait for the EPROM to become available, in ms.
+ * The spec 32 Mb EPROM takes around 40s to erase then write.
+ * Double it for safety.
+ */
+#define EPROM_TIMEOUT 80000 /* ms */
+
+/*
+ * Read a 256 byte (64 dword) EPROM page.
+ * All callers have verified the offset is at a page boundary.
+ */
+static void read_page(struct hfi2_devdata *dd, u32 offset, u32 *result)
+{
+	int i;
+
+	write_csr(dd, ASIC_EEP_ADDR_CMD, CMD_READ_DATA(offset));
+	for (i = 0; i < EP_PAGE_DWORDS; i++)
+		result[i] = (u32)read_csr(dd, ASIC_EEP_DATA);
+	write_csr(dd, ASIC_EEP_ADDR_CMD, CMD_NOP); /* close open page */
+}
+
+/*
+ * Read length bytes starting at offset from the start of the EPROM.
+ */
+static int read_length(struct hfi2_devdata *dd, u32 start, u32 len, void *dest)
+{
+	u32 buffer[EP_PAGE_DWORDS];
+	u32 end;
+	u32 start_offset;
+	u32 read_start;
+	u32 bytes;
+
+	if (len == 0)
+		return 0;
+
+	end = start + len;
+
+	/*
+	 * Make sure the read range is not outside of the controller read
+	 * command address range.  Note that '>' is correct below - the end
+	 * of the range is OK if it stops at the limit, but no higher.
+	 */
+	if (end > (1 << CMD_SHIFT))
+		return -EINVAL;
+
+	/* read the first partial page */
+	start_offset = start & EP_PAGE_MASK;
+	if (start_offset) {
+		/* partial starting page */
+
+		/* align and read the page that contains the start */
+		read_start = start & ~EP_PAGE_MASK;
+		read_page(dd, read_start, buffer);
+
+		/* the rest of the page is available data */
+		bytes = EP_PAGE_SIZE - start_offset;
+
+		if (len <= bytes) {
+			/* end is within this page */
+			memcpy(dest, (u8 *)buffer + start_offset, len);
+			return 0;
+		}
+
+		memcpy(dest, (u8 *)buffer + start_offset, bytes);
+
+		start += bytes;
+		len -= bytes;
+		dest += bytes;
+	}
+	/* start is now page aligned */
+
+	/* read whole pages */
+	while (len >= EP_PAGE_SIZE) {
+		read_page(dd, start, buffer);
+		memcpy(dest, buffer, EP_PAGE_SIZE);
+
+		start += EP_PAGE_SIZE;
+		len -= EP_PAGE_SIZE;
+		dest += EP_PAGE_SIZE;
+	}
+
+	/* read the last partial page */
+	if (len) {
+		read_page(dd, start, buffer);
+		memcpy(dest, buffer, len);
+	}
+
+	return 0;
+}
+
+/*
+ * Initialize the EPROM handler.
+ */
+int eprom_init(struct hfi2_devdata *dd)
+{
+	int ret = 0;
+
+	/* only the discrete chip has an EPROM */
+	if (dd->pcidev->device != PCI_DEVICE_ID_INTEL0)
+		return 0;
+
+	/*
+	 * It is OK if both HFIs reset the EPROM as long as they don't
+	 * do it at the same time.
+	 */
+	ret = acquire_chip_resource(dd, CR_EPROM, EPROM_TIMEOUT);
+	if (ret) {
+		dd_dev_err(dd,
+			   "%s: unable to acquire EPROM resource, no EPROM support\n",
+			   __func__);
+		goto done_asic;
+	}
+
+	/* reset EPROM to be sure it is in a good state */
+
+	/* set reset */
+	write_csr(dd, ASIC_EEP_CTL_STAT, ASIC_EEP_CTL_STAT_EP_RESET_SMASK);
+	/* clear reset, set speed */
+	write_csr(dd, ASIC_EEP_CTL_STAT,
+		  EP_SPEED_FULL << ASIC_EEP_CTL_STAT_RATE_SPI_SHIFT);
+
+	/* wake the device with command "release powerdown NoID" */
+	write_csr(dd, ASIC_EEP_ADDR_CMD, CMD_RELEASE_POWERDOWN_NOID);
+
+	dd->eprom_available = true;
+	release_chip_resource(dd, CR_EPROM);
+done_asic:
+	return ret;
+}
+
+/* magic character sequence that begins an image */
+#define IMAGE_START_MAGIC "APO="
+
+/* magic character sequence that might trail an image */
+#define IMAGE_TRAIL_MAGIC "egamiAPO"
+
+/* EPROM file types */
+#define HFI2_EFT_PLATFORM_CONFIG 2
+
+/* segment size - 128 KiB */
+#define SEG_SIZE (128 * 1024)
+
+struct hfi2_eprom_footer {
+	u32 oprom_size;		/* size of the oprom, in bytes */
+	u16 num_table_entries;
+	u16 version;		/* version of this footer */
+	u32 magic;		/* must be last */
+};
+
+struct hfi2_eprom_table_entry {
+	u32 type;		/* file type */
+	u32 offset;		/* file offset from start of EPROM */
+	u32 size;		/* file size, in bytes */
+};
+
+/*
+ * Calculate the max number of table entries that will fit within a directory
+ * buffer of size 'dir_size'.
+ */
+#define MAX_TABLE_ENTRIES(dir_size) \
+	(((dir_size) - sizeof(struct hfi2_eprom_footer)) / \
+		sizeof(struct hfi2_eprom_table_entry))
+
+#define DIRECTORY_SIZE(n) (sizeof(struct hfi2_eprom_footer) + \
+	(sizeof(struct hfi2_eprom_table_entry) * (n)))
+
+#define MAGIC4(a, b, c, d) ((d) << 24 | (c) << 16 | (b) << 8 | (a))
+#define FOOTER_MAGIC MAGIC4('e', 'p', 'r', 'm')
+#define FOOTER_VERSION 1
+
+/*
+ * Read all of partition 1.  The actual file is at the front.  Adjust
+ * the returned size if a trailing image magic is found.
+ */
+static int read_partition_platform_config(struct hfi2_devdata *dd, void **data,
+					  u32 *size)
+{
+	void *buffer;
+	void *p;
+	u32 length;
+	int ret;
+
+	buffer = kmalloc(P1_SIZE, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = read_length(dd, P1_START, P1_SIZE, buffer);
+	if (ret) {
+		kfree(buffer);
+		return ret;
+	}
+
+	/* config partition is valid only if it starts with IMAGE_START_MAGIC */
+	if (memcmp(buffer, IMAGE_START_MAGIC, strlen(IMAGE_START_MAGIC))) {
+		kfree(buffer);
+		return -ENOENT;
+	}
+
+	/* scan for image magic that may trail the actual data */
+	p = strnstr(buffer, IMAGE_TRAIL_MAGIC, P1_SIZE);
+	if (p)
+		length = p - buffer;
+	else
+		length = P1_SIZE;
+
+	*data = buffer;
+	*size = length;
+	return 0;
+}
+
+/*
+ * The segment magic has been checked.  There is a footer and table of
+ * contents present.
+ *
+ * directory is a u32 aligned buffer of size EP_PAGE_SIZE.
+ */
+static int read_segment_platform_config(struct hfi2_devdata *dd,
+					void *directory, void **data, u32 *size)
+{
+	struct hfi2_eprom_footer *footer;
+	struct hfi2_eprom_table_entry *table;
+	struct hfi2_eprom_table_entry *entry;
+	void *buffer = NULL;
+	void *table_buffer = NULL;
+	int ret, i;
+	u32 directory_size;
+	u32 seg_base, seg_offset;
+	u32 bytes_available, ncopied, to_copy;
+
+	/* the footer is at the end of the directory */
+	footer = (struct hfi2_eprom_footer *)
+			(directory + EP_PAGE_SIZE - sizeof(*footer));
+
+	/* make sure the structure version is supported */
+	if (footer->version != FOOTER_VERSION)
+		return -EINVAL;
+
+	/* oprom size cannot be larger than a segment */
+	if (footer->oprom_size >= SEG_SIZE)
+		return -EINVAL;
+
+	/* the file table must fit in a segment with the oprom */
+	if (footer->num_table_entries >
+			MAX_TABLE_ENTRIES(SEG_SIZE - footer->oprom_size))
+		return -EINVAL;
+
+	/* find the file table start, which precedes the footer */
+	directory_size = DIRECTORY_SIZE(footer->num_table_entries);
+	if (directory_size <= EP_PAGE_SIZE) {
+		/* the file table fits into the directory buffer handed in */
+		table = (struct hfi2_eprom_table_entry *)
+				(directory + EP_PAGE_SIZE - directory_size);
+	} else {
+		/* need to allocate and read more */
+		table_buffer = kmalloc(directory_size, GFP_KERNEL);
+		if (!table_buffer)
+			return -ENOMEM;
+		ret = read_length(dd, SEG_SIZE - directory_size,
+				  directory_size, table_buffer);
+		if (ret)
+			goto done;
+		table = table_buffer;
+	}
+
+	/* look for the platform configuration file in the table */
+	for (entry = NULL, i = 0; i < footer->num_table_entries; i++) {
+		if (table[i].type == HFI2_EFT_PLATFORM_CONFIG) {
+			entry = &table[i];
+			break;
+		}
+	}
+	if (!entry) {
+		ret = -ENOENT;
+		goto done;
+	}
+
+	/*
+	 * Sanity check on the configuration file size - it should never
+	 * be larger than 4 KiB.
+	 */
+	if (entry->size > (4 * 1024)) {
+		dd_dev_err(dd, "Bad configuration file size 0x%x\n",
+			   entry->size);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* check for bogus offset and size that wrap when added together */
+	if (entry->offset + entry->size < entry->offset) {
+		dd_dev_err(dd,
+			   "Bad configuration file start + size 0x%x+0x%x\n",
+			   entry->offset, entry->size);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	/* allocate the buffer to return */
+	buffer = kmalloc(entry->size, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	/*
+	 * Extract the file by looping over segments until it is fully read.
+	 */
+	seg_offset = entry->offset % SEG_SIZE;
+	seg_base = entry->offset - seg_offset;
+	ncopied = 0;
+	while (ncopied < entry->size) {
+		/* calculate data bytes available in this segment */
+
+		/* start with the bytes from the current offset to the end */
+		bytes_available = SEG_SIZE - seg_offset;
+		/* subtract off footer and table from segment 0 */
+		if (seg_base == 0) {
+			/*
+			 * Sanity check: should not have a starting point
+			 * at or within the directory.
+			 */
+			if (bytes_available <= directory_size) {
+				dd_dev_err(dd,
+					   "Bad configuration file - offset 0x%x within footer+table\n",
+					   entry->offset);
+				ret = -EINVAL;
+				goto done;
+			}
+			bytes_available -= directory_size;
+		}
+
+		/* calculate bytes wanted */
+		to_copy = entry->size - ncopied;
+
+		/* max out at the available bytes in this segment */
+		if (to_copy > bytes_available)
+			to_copy = bytes_available;
+
+		/*
+		 * Read from the EPROM.
+		 *
+		 * The sanity check for entry->offset is done in read_length().
+		 * The EPROM offset is validated against what the hardware
+		 * addressing supports.  In addition, if the offset is larger
+		 * than the actual EPROM, it silently wraps.  It will work
+		 * fine, though the reader may not get what they expected
+		 * from the EPROM.
+		 */
+		ret = read_length(dd, seg_base + seg_offset, to_copy,
+				  buffer + ncopied);
+		if (ret)
+			goto done;
+
+		ncopied += to_copy;
+
+		/* set up for next segment */
+		seg_offset = footer->oprom_size;
+		seg_base += SEG_SIZE;
+	}
+
+	/* success */
+	ret = 0;
+	*data = buffer;
+	*size = entry->size;
+
+done:
+	kfree(table_buffer);
+	if (ret)
+		kfree(buffer);
+	return ret;
+}
+
+/*
+ * Read the platform configuration file from the EPROM.
+ *
+ * On success, an allocated buffer containing the data and its size are
+ * returned.  It is up to the caller to free this buffer.
+ *
+ * Return value:
+ *   0	      - success
+ *   -ENXIO   - no EPROM is available
+ *   -EBUSY   - not able to acquire access to the EPROM
+ *   -ENOENT  - no recognizable file written
+ *   -ENOMEM  - buffer could not be allocated
+ *   -EINVAL  - invalid EPROM contentents found
+ */
+int eprom_read_platform_config(struct hfi2_devdata *dd, void **data, u32 *size)
+{
+	u32 directory[EP_PAGE_DWORDS]; /* aligned buffer */
+	int ret;
+
+	if (!dd->eprom_available)
+		return -ENXIO;
+
+	ret = acquire_chip_resource(dd, CR_EPROM, EPROM_TIMEOUT);
+	if (ret)
+		return -EBUSY;
+
+	/* read the last page of the segment for the EPROM format magic */
+	ret = read_length(dd, SEG_SIZE - EP_PAGE_SIZE, EP_PAGE_SIZE, directory);
+	if (ret)
+		goto done;
+
+	/* last dword of the segment contains a magic value */
+	if (directory[EP_PAGE_DWORDS - 1] == FOOTER_MAGIC) {
+		/* segment format */
+		ret = read_segment_platform_config(dd, directory, data, size);
+	} else {
+		/* partition format */
+		ret = read_partition_platform_config(dd, data, size);
+	}
+
+done:
+	release_chip_resource(dd, CR_EPROM);
+	return ret;
+}
diff --git a/drivers/infiniband/hw/hfi2/fault.c b/drivers/infiniband/hw/hfi2/fault.c
new file mode 100644
index 000000000000..0c8127bb695b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/fault.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/bitmap.h>
+
+#include "debugfs.h"
+#include "fault.h"
+#include "trace.h"
+
+#define HFI2_FAULT_DIR_TX   BIT(0)
+#define HFI2_FAULT_DIR_RX   BIT(1)
+#define HFI2_FAULT_DIR_TXRX (HFI2_FAULT_DIR_TX | HFI2_FAULT_DIR_RX)
+
+static void *_fault_stats_seq_start(struct seq_file *s, loff_t *pos)
+{
+	struct hfi2_opcode_stats_perctx *opstats;
+
+	if (*pos >= ARRAY_SIZE(opstats->stats))
+		return NULL;
+	return pos;
+}
+
+static void *_fault_stats_seq_next(struct seq_file *s, void *v, loff_t *pos)
+{
+	struct hfi2_opcode_stats_perctx *opstats;
+
+	++*pos;
+	if (*pos >= ARRAY_SIZE(opstats->stats))
+		return NULL;
+	return pos;
+}
+
+static void _fault_stats_seq_stop(struct seq_file *s, void *v)
+{
+}
+
+static int _fault_stats_seq_show(struct seq_file *s, void *v)
+{
+	loff_t *spos = v;
+	loff_t i = *spos, j;
+	u64 n_packets = 0, n_bytes = 0;
+	struct hfi2_ibdev *ibd = (struct hfi2_ibdev *)s->private;
+	struct hfi2_devdata *dd = dd_from_dev(ibd);
+	struct hfi2_ctxtdata *rcd;
+	int pidx;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		for (j = dd->rsrcs.ppr[pidx].rcv_context_base;
+		     j < dd->rsrcs.ppr[pidx].first_dyn_alloc_ctxt;
+		     j++) {
+			rcd = hfi2_rcd_get_by_index(dd, j);
+			if (rcd) {
+				n_packets += rcd->opstats->stats[i].n_packets;
+				n_bytes += rcd->opstats->stats[i].n_bytes;
+			}
+			hfi2_rcd_put(rcd);
+		}
+	}
+	for_each_possible_cpu(j) {
+		struct hfi2_opcode_stats_perctx *sp =
+			per_cpu_ptr(dd->tx_opstats, j);
+
+		n_packets += sp->stats[i].n_packets;
+		n_bytes += sp->stats[i].n_bytes;
+	}
+	if (!n_packets && !n_bytes)
+		return SEQ_SKIP;
+	if (!ibd->fault->n_rxfaults[i] && !ibd->fault->n_txfaults[i])
+		return SEQ_SKIP;
+	seq_printf(s, "%02llx %llu/%llu (faults rx:%llu faults: tx:%llu)\n", i,
+		   (unsigned long long)n_packets,
+		   (unsigned long long)n_bytes,
+		   (unsigned long long)ibd->fault->n_rxfaults[i],
+		   (unsigned long long)ibd->fault->n_txfaults[i]);
+	return 0;
+}
+
+DEBUGFS_SEQ_FILE_OPS(fault_stats);
+DEBUGFS_SEQ_FILE_OPEN(fault_stats);
+DEBUGFS_FILE_OPS(fault_stats);
+
+static int fault_opcodes_open(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return nonseekable_open(inode, file);
+}
+
+static ssize_t fault_opcodes_write(struct file *file, const char __user *buf,
+				   size_t len, loff_t *pos)
+{
+	ssize_t ret = 0;
+	/* 1280 = 256 opcodes * 4 chars/opcode + 255 commas + NULL */
+	size_t copy, datalen = 1280;
+	char *data, *token, *ptr, *end;
+	struct fault *fault = file->private_data;
+
+	data = kcalloc(datalen, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	copy = min(len, datalen - 1);
+	if (copy_from_user(data, buf, copy)) {
+		ret = -EFAULT;
+		goto free_data;
+	}
+
+	ptr = data;
+	token = ptr;
+	for (ptr = data; *ptr; ptr = end + 1, token = ptr) {
+		char *dash;
+		unsigned long range_start, range_end, i;
+		bool remove = false;
+		unsigned long bound = 1U << BITS_PER_BYTE;
+
+		end = strchr(ptr, ',');
+		if (end)
+			*end = '\0';
+		if (token[0] == '-') {
+			remove = true;
+			token++;
+		}
+		dash = strchr(token, '-');
+		if (dash)
+			*dash = '\0';
+		if (kstrtoul(token, 0, &range_start))
+			break;
+		if (dash) {
+			token = dash + 1;
+			if (kstrtoul(token, 0, &range_end))
+				break;
+		} else {
+			range_end = range_start;
+		}
+		if (range_start == range_end && range_start == -1UL) {
+			bitmap_zero(fault->opcodes, sizeof(fault->opcodes) *
+				    BITS_PER_BYTE);
+			break;
+		}
+		/* Check the inputs */
+		if (range_start >= bound || range_end >= bound)
+			break;
+
+		for (i = range_start; i <= range_end; i++) {
+			if (remove)
+				clear_bit(i, fault->opcodes);
+			else
+				set_bit(i, fault->opcodes);
+		}
+		if (!end)
+			break;
+	}
+	ret = len;
+
+free_data:
+	kfree(data);
+	return ret;
+}
+
+static ssize_t fault_opcodes_read(struct file *file, char __user *buf,
+				  size_t len, loff_t *pos)
+{
+	ssize_t ret = 0;
+	char *data;
+	size_t datalen = 1280, size = 0; /* see fault_opcodes_write() */
+	unsigned long bit = 0, zero = 0;
+	struct fault *fault = file->private_data;
+	size_t bitsize = sizeof(fault->opcodes) * BITS_PER_BYTE;
+
+	data = kcalloc(datalen, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	bit = find_first_bit(fault->opcodes, bitsize);
+	while (bit < bitsize) {
+		zero = find_next_zero_bit(fault->opcodes, bitsize, bit);
+		if (zero - 1 != bit)
+			size += scnprintf(data + size,
+					 datalen - size - 1,
+					 "0x%lx-0x%lx,", bit, zero - 1);
+		else
+			size += scnprintf(data + size,
+					 datalen - size - 1, "0x%lx,",
+					 bit);
+		bit = find_next_bit(fault->opcodes, bitsize, zero);
+	}
+	data[size - 1] = '\n';
+	data[size] = '\0';
+	ret = simple_read_from_buffer(buf, len, pos, data, size);
+	kfree(data);
+	return ret;
+}
+
+static const struct file_operations __fault_opcodes_fops = {
+	.owner = THIS_MODULE,
+	.open = fault_opcodes_open,
+	.read = fault_opcodes_read,
+	.write = fault_opcodes_write,
+};
+
+void hfi2_fault_exit_debugfs(struct hfi2_ibdev *ibd)
+{
+	if (ibd->fault)
+		debugfs_remove_recursive(ibd->fault->dir);
+	kfree(ibd->fault);
+	ibd->fault = NULL;
+}
+
+int hfi2_fault_init_debugfs(struct hfi2_ibdev *ibd)
+{
+	struct dentry *parent = ibd->hfi2_ibdev_dbg;
+	struct dentry *fault_dir;
+
+	ibd->fault = kzalloc_obj(ibd->fault, GFP_KERNEL);
+	if (!ibd->fault)
+		return -ENOMEM;
+
+	ibd->fault->attr.interval = 1;
+	ibd->fault->attr.require_end = ULONG_MAX;
+	ibd->fault->attr.stacktrace_depth = 32;
+	ibd->fault->attr.dname = NULL;
+	ibd->fault->attr.verbose = 0;
+	ibd->fault->enable = false;
+	ibd->fault->opcode = false;
+	ibd->fault->fault_skip = 0;
+	ibd->fault->skip = 0;
+	ibd->fault->direction = HFI2_FAULT_DIR_TXRX;
+	ibd->fault->suppress_err = false;
+	bitmap_zero(ibd->fault->opcodes,
+		    sizeof(ibd->fault->opcodes) * BITS_PER_BYTE);
+
+	fault_dir =
+		fault_create_debugfs_attr("fault", parent, &ibd->fault->attr);
+	if (IS_ERR(fault_dir)) {
+		kfree(ibd->fault);
+		ibd->fault = NULL;
+		return -ENOENT;
+	}
+	ibd->fault->dir = fault_dir;
+
+	debugfs_create_file("fault_stats", 0444, fault_dir, ibd,
+			    &_fault_stats_file_ops);
+	debugfs_create_bool("enable", 0600, fault_dir, &ibd->fault->enable);
+	debugfs_create_bool("suppress_err", 0600, fault_dir,
+			    &ibd->fault->suppress_err);
+	debugfs_create_bool("opcode_mode", 0600, fault_dir,
+			    &ibd->fault->opcode);
+	debugfs_create_file("opcodes", 0600, fault_dir, ibd->fault,
+			    &__fault_opcodes_fops);
+	debugfs_create_u64("skip_pkts", 0600, fault_dir,
+			   &ibd->fault->fault_skip);
+	debugfs_create_u64("skip_usec", 0600, fault_dir,
+			   &ibd->fault->fault_skip_usec);
+	debugfs_create_u8("direction", 0600, fault_dir, &ibd->fault->direction);
+
+	return 0;
+}
+
+bool hfi2_dbg_fault_suppress_err(struct hfi2_ibdev *ibd)
+{
+	if (ibd->fault)
+		return ibd->fault->suppress_err;
+	return false;
+}
+
+static bool __hfi2_should_fault(struct hfi2_ibdev *ibd, u32 opcode,
+				u8 direction)
+{
+	bool ret = false;
+
+	if (!ibd->fault || !ibd->fault->enable)
+		return false;
+	if (!(ibd->fault->direction & direction))
+		return false;
+	if (ibd->fault->opcode) {
+		if (bitmap_empty(ibd->fault->opcodes,
+				 (sizeof(ibd->fault->opcodes) *
+				  BITS_PER_BYTE)))
+			return false;
+		if (!(test_bit(opcode, ibd->fault->opcodes)))
+			return false;
+	}
+	if (ibd->fault->fault_skip_usec &&
+	    time_before(jiffies, ibd->fault->skip_usec))
+		return false;
+	if (ibd->fault->fault_skip && ibd->fault->skip) {
+		ibd->fault->skip--;
+		return false;
+	}
+	ret = should_fail(&ibd->fault->attr, 1);
+	if (ret) {
+		ibd->fault->skip = ibd->fault->fault_skip;
+		ibd->fault->skip_usec = jiffies +
+			usecs_to_jiffies(ibd->fault->fault_skip_usec);
+	}
+	return ret;
+}
+
+bool hfi2_dbg_should_fault_tx(struct rvt_qp *qp, u32 opcode)
+{
+	struct hfi2_ibdev *ibd = to_idev(qp->ibqp.device);
+
+	if (__hfi2_should_fault(ibd, opcode, HFI2_FAULT_DIR_TX)) {
+		trace_hfi2_fault_opcode(qp, opcode);
+		ibd->fault->n_txfaults[opcode]++;
+		return true;
+	}
+	return false;
+}
+
+bool hfi2_dbg_should_fault_rx(struct hfi2_packet *packet)
+{
+	struct hfi2_ibdev *ibd = &packet->rcd->dd->verbs_dev;
+
+	if (__hfi2_should_fault(ibd, packet->opcode, HFI2_FAULT_DIR_RX)) {
+		trace_hfi2_fault_packet(packet);
+		ibd->fault->n_rxfaults[packet->opcode]++;
+		return true;
+	}
+	return false;
+}
diff --git a/drivers/infiniband/hw/hfi2/pcie.c b/drivers/infiniband/hw/hfi2/pcie.c
new file mode 100644
index 000000000000..11d9d522ff70
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pcie.c
@@ -0,0 +1,1459 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/vmalloc.h>
+#include <linux/module.h>
+
+#include "hfi2.h"
+#include "chip_registers.h"
+#include "aspm.h"
+#include "sriov.h"
+
+/*
+ * This file contains PCIe utility routines.
+ */
+
+#define PCI_EXP_COMP_TIMEOUT_RANGE_A	0x01
+#define PCI_EXP_COMP_TIMEOUT_RANGE_B	0x02
+#define PCI_EXP_COMP_TIMEOUT_RANGE_C	0x04
+#define PCI_EXP_COMP_TIMEOUT_RANGE_D	0x08
+
+#define PCI_EXP_COMP_TIMEOUT_MASK	(PCI_EXP_DEVCTL2_COMP_TMOUT_DIS | \
+					 PCI_EXP_DEVCTL2_COMP_TIMEOUT)
+
+int pcie_compl_to = PCI_EXP_COMP_TIMEOUT_RANGE_C | PCI_EXP_COMP_TIMEOUT_RANGE_B;
+module_param_named(pcie_compl_to, pcie_compl_to, int, 0444);
+MODULE_PARM_DESC(pcie_compl_to, "PCIe Completion Timeout bitmap, 0 no change, 0x10 disable");
+
+/*
+ * Prevent upstream errors from being reported if a software stray read
+ * occurs in a write-only BAR range.
+ */
+static void mask_aer_unsupported_request(struct pci_dev *pdev)
+{
+	u32 mask;
+	int aer;
+
+	aer = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
+	if (!aer)
+		return;
+	pci_read_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK, &mask);
+	if (mask & PCI_ERR_UNC_UNSUP)
+		return;
+	mask |= PCI_ERR_UNC_UNSUP; /* mask Unsupported Request */
+	pci_write_config_dword(pdev, aer + PCI_ERR_UNCOR_MASK, mask);
+}
+
+/*
+ * Do all the common PCIe setup and initialization.
+ */
+int hfi2_pcie_init(struct hfi2_devdata *dd)
+{
+	int ret;
+	struct pci_dev *pdev = dd->pcidev;
+
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		/*
+		 * This can happen (in theory) iff:
+		 * We did a chip reset, and then failed to reprogram the
+		 * BAR, or the chip reset due to an internal error.  We then
+		 * unloaded the driver and reloaded it.
+		 *
+		 * Both reset cases set the BAR back to initial state.  For
+		 * the latter case, the AER sticky error bit at offset 0x718
+		 * should be set, but the Linux kernel doesn't yet know
+		 * about that, it appears.  If the original BAR was retained
+		 * in the kernel data structures, this may be OK.
+		 */
+		dd_dev_err(dd, "pci enable failed: error %d\n", -ret);
+		return ret;
+	}
+
+	ret = pci_request_regions(pdev, DRIVER_NAME);
+	if (ret) {
+		dd_dev_err(dd, "pci_request_regions fails: err %d\n", -ret);
+		goto bail;
+	}
+
+	pci_set_master(pdev);
+	if (dd->params->chip_type == CHIP_JKR)
+		mask_aer_unsupported_request(pdev);
+	return 0;
+
+bail:
+	hfi2_pcie_cleanup(pdev);
+	return ret;
+}
+
+/*
+ * Clean what was done in hfi2_pcie_init()
+ */
+void hfi2_pcie_cleanup(struct pci_dev *pdev)
+{
+	pci_disable_device(pdev);
+	/*
+	 * Release regions should be called after the disable. OK to
+	 * call if request regions has not been called or failed.
+	 */
+	pci_release_regions(pdev);
+}
+
+/*
+ * Map a single 64-bit BAR.  Expect each BAR to have the same ranges.
+ * This will set:
+ *	dd->bar_map[idx]
+ *	dd->revision (BAR 0 only)
+ *	dd->base2_start (BAR 0 only)
+ */
+static int do_bar_map(struct hfi2_devdata *dd, struct pci_dev *pdev, int idx)
+{
+	unsigned long len;
+	resource_size_t addr;
+	struct bar_map *bm = &dd->bar_maps[idx];
+	int pci_bar_idx = 2 * idx; /* PCIe 64-bit BAR: 0/1, 2/3, or 4/5 */
+
+	addr = pci_resource_start(pdev, pci_bar_idx);
+	len = pci_resource_len(pdev, pci_bar_idx);
+
+	if (idx > 0 && len == 0) {
+		/* BAR not used - ignore */
+		return 0;
+	}
+
+	/*
+	 * The TXE PIO buffers are at the tail end of the chip space.
+	 * Cut them off and map them separately.
+	 */
+
+	/* sanity check vs expectations */
+	if (len != dd->params->bar0_size) {
+		dd_dev_err(dd, "chip BAR0 size does not match\n");
+		return -EINVAL;
+	}
+
+	bm->kregbase1 = ioremap(addr, dd->params->kreg1_size);
+	if (!bm->kregbase1) {
+		dd_dev_err(dd, "BAR %d: UC mapping of kregbase1 failed\n", idx);
+		return -ENOMEM;
+	}
+	dd_dev_info(dd, "BAR %d: UC base1 %p, len %x\n", idx, bm->kregbase1,
+		    dd->params->kreg1_size);
+
+	/* bar 0 only actions */
+	if (idx == 0) {
+		/* verify that reads actually work, save revision for reset check */
+		/*
+		 * VFs don't have a CCE_REVISION, so need to avoid access violation.
+		 * Calling vf2pf_get_config() provides this information to VFs.
+		 */
+		if (!dd->is_vf) {
+			dd->revision = readq(bm->kregbase1 + CCE_REVISION);
+			if (dd->revision == ~(u64)0) {
+				dd_dev_err(dd, "Cannot read chip CSRs\n");
+				return -EINVAL;
+			}
+		}
+		/* cache base2 offset value */
+		dd->base2_start = dd->params->kreg2_offset;
+	}
+
+	bm->kregbase2 = ioremap(addr + dd->base2_start,
+				dd->params->kreg2_size);
+	if (!bm->kregbase2) {
+		dd_dev_err(dd, "BAR %d: UC mapping of kregbase2 failed\n", idx);
+		return -ENOMEM;
+	}
+	dd_dev_info(dd, "BAR %d: UC base2 %p, len %x\n", idx, bm->kregbase2,
+		    dd->params->kreg2_size);
+
+	bm->piobase = ioremap_wc(addr + TXE_PIO_SEND, TXE_PIO_SIZE);
+	if (!bm->piobase) {
+		dd_dev_err(dd, "BAR %d: WC mapping of send buffers failed\n", idx);
+		return -ENOMEM;
+	}
+	dd_dev_info(dd, "BAR %d: WC piobase %p, len %x\n", idx, bm->piobase, TXE_PIO_SIZE);
+
+	bm->physaddr = addr;        /* used for io_remap, etc. */
+
+	/*
+	 * Map the chip's RcvArray as write-combining to allow us
+	 * to write an entire cacheline worth of entries in one shot.
+	 */
+	bm->rcvarray_wc = ioremap_wc(addr + dd->params->rcv_array_offset,
+				     dd->params->rcv_array_size);
+	if (!bm->rcvarray_wc) {
+		dd_dev_err(dd, "BAR %d: WC mapping of receive array failed\n", idx);
+		return -ENOMEM;
+	}
+	dd_dev_info(dd, "BAR %d: WC RcvArray %p, len %x\n", idx,
+		    bm->rcvarray_wc, dd->params->rcv_array_size);
+
+	return 0;
+}
+
+/*
+ * Do remaining PCIe setup, once dd is allocated, and save away
+ * fields required to re-initialize after a chip reset, or for
+ * various other purposes
+ */
+int hfi2_pcie_ddinit(struct hfi2_devdata *dd, struct pci_dev *pdev)
+{
+	int ret;
+
+	ret = do_bar_map(dd, pdev, 0);
+	if (ret)
+		goto fail;
+	ret = do_bar_map(dd, pdev, 1);
+	if (ret)
+		goto fail;
+	ret = do_bar_map(dd, pdev, 2);
+	if (ret)
+		goto fail;
+
+	dd->flags |= HFI2_PRESENT;	/* CSR access routines now work */
+	return 0;
+fail:
+	hfi2_pcie_ddcleanup(dd);
+	return ret;
+}
+
+static void do_bar_unmap(struct hfi2_devdata *dd, int idx)
+{
+	struct bar_map *bm = &dd->bar_maps[idx];
+
+	if (bm->kregbase1)
+		iounmap(bm->kregbase1);
+	bm->kregbase1 = NULL;
+	if (bm->kregbase2)
+		iounmap(bm->kregbase2);
+	bm->kregbase2 = NULL;
+	if (bm->rcvarray_wc)
+		iounmap(bm->rcvarray_wc);
+	bm->rcvarray_wc = NULL;
+	if (bm->piobase)
+		iounmap(bm->piobase);
+	bm->piobase = NULL;
+}
+
+/*
+ * Do PCIe cleanup related to dd, after chip-specific cleanup, etc.  Just prior
+ * to releasing the dd memory.
+ * Void because all of the core pcie cleanup functions are void.
+ */
+void hfi2_pcie_ddcleanup(struct hfi2_devdata *dd)
+{
+	dd->flags &= ~HFI2_PRESENT;
+	do_bar_unmap(dd, 0);
+	do_bar_unmap(dd, 1);
+	do_bar_unmap(dd, 2);
+}
+
+/* return the PCIe link speed from the given link status */
+static u32 extract_speed(u16 linkstat)
+{
+	u32 speed;
+
+	switch (linkstat & PCI_EXP_LNKSTA_CLS) {
+	default: /* not defined, assume Gen1 */
+	case PCI_EXP_LNKSTA_CLS_2_5GB:
+		speed = 2500; /* Gen 1, 2.5GHz */
+		break;
+	case PCI_EXP_LNKSTA_CLS_5_0GB:
+		speed = 5000; /* Gen 2, 5GHz */
+		break;
+	case PCI_EXP_LNKSTA_CLS_8_0GB:
+		speed = 8000; /* Gen 3, 8GHz */
+		break;
+	}
+	return speed;
+}
+
+/* read the link status and set dd->{lbus_width,lbus_speed,lbus_info} */
+static void update_lbus_info(struct hfi2_devdata *dd)
+{
+	u16 linkstat;
+	int ret;
+
+	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKSTA, &linkstat);
+	if (ret) {
+		dd_dev_err(dd, "Unable to read from PCI config\n");
+		return;
+	}
+
+	dd->lbus_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, linkstat);
+	dd->lbus_speed = extract_speed(linkstat);
+	snprintf(dd->lbus_info, sizeof(dd->lbus_info),
+		 "PCIe,%uMHz,x%u", dd->lbus_speed, dd->lbus_width);
+}
+
+/*
+ * Read in the current PCIe link width and speed.  Find if the link is
+ * Gen3 capable.
+ */
+int pcie_speeds(struct hfi2_devdata *dd)
+{
+	u32 linkcap;
+	struct pci_dev *parent = dd->pcidev->bus->self;
+	int ret;
+
+	if (!pci_is_pcie(dd->pcidev)) {
+		dd_dev_err(dd, "Can't find PCI Express capability!\n");
+		return -EINVAL;
+	}
+
+	/* find if our max speed is Gen3 and parent supports Gen3 speeds */
+	dd->link_gen3_capable = 1;
+
+	ret = pcie_capability_read_dword(dd->pcidev, PCI_EXP_LNKCAP, &linkcap);
+	if (ret) {
+		dd_dev_err(dd, "Unable to read from PCI config\n");
+		return pcibios_err_to_errno(ret);
+	}
+
+	if ((linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_8_0GB) {
+		dd_dev_info(dd,
+			    "This HFI is not Gen3 capable, max speed 0x%x, need 0x3\n",
+			    linkcap & PCI_EXP_LNKCAP_SLS);
+		dd->link_gen3_capable = 0;
+	}
+
+	/*
+	 * bus->max_bus_speed is set from the bridge's linkcap Max Link Speed
+	 */
+	if (parent &&
+	    (dd->pcidev->bus->max_bus_speed == PCIE_SPEED_2_5GT ||
+	     dd->pcidev->bus->max_bus_speed == PCIE_SPEED_5_0GT)) {
+		dd_dev_info(dd, "Parent PCIe bridge does not support Gen3\n");
+		dd->link_gen3_capable = 0;
+	}
+
+	/* obtain the link width and current speed */
+	update_lbus_info(dd);
+
+	dd_dev_info(dd, "%s\n", dd->lbus_info);
+
+	return 0;
+}
+
+/*
+ * Restore command and BARs after a reset has wiped them out
+ *
+ * Returns 0 on success, otherwise a negative error value
+ */
+int restore_pci_variables(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = pci_write_config_word(dd->pcidev, PCI_COMMAND, dd->pci_command);
+	if (ret)
+		goto error;
+
+	ret = pci_write_config_dword(dd->pcidev, PCI_BASE_ADDRESS_0,
+				     dd->pcibar0);
+	if (ret)
+		goto error;
+
+	ret = pci_write_config_dword(dd->pcidev, PCI_BASE_ADDRESS_1,
+				     dd->pcibar1);
+	if (ret)
+		goto error;
+
+	ret = pci_write_config_dword(dd->pcidev, PCI_ROM_ADDRESS, dd->pci_rom);
+	if (ret)
+		goto error;
+
+	ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_DEVCTL,
+					 dd->pcie_devctl);
+	if (ret)
+		goto error;
+
+	ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_LNKCTL,
+					 dd->pcie_lnkctl);
+	if (ret)
+		goto error;
+
+	ret = pcie_capability_write_word(dd->pcidev, PCI_EXP_DEVCTL2,
+					 dd->pcie_devctl2);
+	if (ret)
+		goto error;
+
+	ret = pci_write_config_dword(dd->pcidev, PCI_CFG_MSIX0, dd->pci_msix0);
+	if (ret)
+		goto error;
+
+	if (pci_find_ext_capability(dd->pcidev, PCI_EXT_CAP_ID_TPH)) {
+		ret = pci_write_config_dword(dd->pcidev, PCIE_CFG_TPH2,
+					     dd->pci_tph2);
+		if (ret)
+			goto error;
+	}
+	return 0;
+
+error:
+	dd_dev_err(dd, "Unable to write to PCI config\n");
+	return pcibios_err_to_errno(ret);
+}
+
+/*
+ * Save BARs and command to rewrite after device reset
+ *
+ * Returns 0 on success, otherwise a negative error value
+ */
+int save_pci_variables(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = pci_read_config_dword(dd->pcidev, PCI_BASE_ADDRESS_0,
+				    &dd->pcibar0);
+	if (ret)
+		goto error;
+
+	ret = pci_read_config_dword(dd->pcidev, PCI_BASE_ADDRESS_1,
+				    &dd->pcibar1);
+	if (ret)
+		goto error;
+
+	ret = pci_read_config_dword(dd->pcidev, PCI_ROM_ADDRESS, &dd->pci_rom);
+	if (ret)
+		goto error;
+
+	ret = pci_read_config_word(dd->pcidev, PCI_COMMAND, &dd->pci_command);
+	if (ret)
+		goto error;
+
+	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_DEVCTL,
+					&dd->pcie_devctl);
+	if (ret)
+		goto error;
+
+	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_LNKCTL,
+					&dd->pcie_lnkctl);
+	if (ret)
+		goto error;
+
+	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_DEVCTL2,
+					&dd->pcie_devctl2);
+	if (ret)
+		goto error;
+
+	ret = pci_read_config_dword(dd->pcidev, PCI_CFG_MSIX0, &dd->pci_msix0);
+	if (ret)
+		goto error;
+
+	if (pci_find_ext_capability(dd->pcidev, PCI_EXT_CAP_ID_TPH)) {
+		ret = pci_read_config_dword(dd->pcidev, PCIE_CFG_TPH2,
+					    &dd->pci_tph2);
+		if (ret)
+			goto error;
+	}
+	return 0;
+
+error:
+	dd_dev_err(dd, "Unable to read from PCI config\n");
+	return pcibios_err_to_errno(ret);
+}
+
+/*
+ * BIOS may not set PCIe bus-utilization parameters for best performance.
+ * Check and optionally adjust them to maximize our throughput.
+ */
+static int hfi2_pcie_caps;
+module_param_named(pcie_caps, hfi2_pcie_caps, int, 0444);
+MODULE_PARM_DESC(pcie_caps, "Max PCIe tuning: Payload (0..3), ReadReq (4..7)");
+
+/**
+ * tune_pcie_caps() - Code to adjust PCIe capabilities.
+ * @dd: Valid device data structure
+ *
+ */
+void tune_pcie_caps(struct hfi2_devdata *dd)
+{
+	struct pci_dev *parent;
+	u16 rc_mpss, rc_mps, ep_mpss, ep_mps;
+	u16 rc_mrrs, ep_mrrs, max_mrrs, ectl;
+	int ret;
+
+	if (dd->params->chip_type != CHIP_WFR && pcie_compl_to > 0) {
+		if (pcie_compl_to > PCI_EXP_COMP_TIMEOUT_MASK) {
+			dd_dev_warn(dd, "Ignoring invalid pcie_compl_to 0x%x\n",
+				    pcie_compl_to);
+		} else {
+			pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_DEVCTL2,
+							   PCI_EXP_COMP_TIMEOUT_MASK,
+							   pcie_compl_to);
+		}
+	}
+
+	/*
+	 * Turn on extended tags in DevCtl in case the BIOS has turned it off
+	 * to improve WFR SDMA bandwidth
+	 */
+	ret = pcie_capability_read_word(dd->pcidev, PCI_EXP_DEVCTL, &ectl);
+	if ((!ret) && !(ectl & PCI_EXP_DEVCTL_EXT_TAG)) {
+		dd_dev_info(dd, "Enabling PCIe extended tags\n");
+		ectl |= PCI_EXP_DEVCTL_EXT_TAG;
+		ret = pcie_capability_write_word(dd->pcidev,
+						 PCI_EXP_DEVCTL, ectl);
+		if (ret)
+			dd_dev_info(dd, "Unable to write to PCI config\n");
+	}
+	/* Find out supported and configured values for parent (root) */
+	parent = dd->pcidev->bus->self;
+	/*
+	 * The driver cannot perform the tuning if it does not have
+	 * access to the upstream component.
+	 */
+	if (!parent) {
+		dd_dev_info(dd, "Parent not found\n");
+		return;
+	}
+	if (!pci_is_root_bus(parent->bus)) {
+		dd_dev_info(dd, "Parent not root\n");
+		return;
+	}
+	if (!pci_is_pcie(parent)) {
+		dd_dev_info(dd, "Parent is not PCI Express capable\n");
+		return;
+	}
+	if (!pci_is_pcie(dd->pcidev)) {
+		dd_dev_info(dd, "PCI device is not PCI Express capable\n");
+		return;
+	}
+	rc_mpss = parent->pcie_mpss;
+	rc_mps = ffs(pcie_get_mps(parent)) - 8;
+	/* Find out supported and configured values for endpoint (us) */
+	ep_mpss = dd->pcidev->pcie_mpss;
+	ep_mps = ffs(pcie_get_mps(dd->pcidev)) - 8;
+
+	/* Find max payload supported by root, endpoint */
+	if (rc_mpss > ep_mpss)
+		rc_mpss = ep_mpss;
+
+	/* If Supported greater than limit in module param, limit it */
+	if (rc_mpss > (hfi2_pcie_caps & 7))
+		rc_mpss = hfi2_pcie_caps & 7;
+	/* If less than (allowed, supported), bump root payload */
+	if (rc_mpss > rc_mps) {
+		rc_mps = rc_mpss;
+		pcie_set_mps(parent, 128 << rc_mps);
+	}
+	/* If less than (allowed, supported), bump endpoint payload */
+	if (rc_mpss > ep_mps) {
+		ep_mps = rc_mpss;
+		pcie_set_mps(dd->pcidev, 128 << ep_mps);
+	}
+
+	/*
+	 * Now the Read Request size.
+	 * No field for max supported, but PCIe spec limits it to 4096,
+	 * which is code '5' (log2(4096) - 7)
+	 */
+	max_mrrs = 5;
+	if (max_mrrs > ((hfi2_pcie_caps >> 4) & 7))
+		max_mrrs = (hfi2_pcie_caps >> 4) & 7;
+
+	max_mrrs = 128 << max_mrrs;
+	rc_mrrs = pcie_get_readrq(parent);
+	ep_mrrs = pcie_get_readrq(dd->pcidev);
+
+	if (max_mrrs > rc_mrrs) {
+		rc_mrrs = max_mrrs;
+		pcie_set_readrq(parent, rc_mrrs);
+	}
+	if (max_mrrs > ep_mrrs) {
+		ep_mrrs = max_mrrs;
+		pcie_set_readrq(dd->pcidev, ep_mrrs);
+	}
+}
+
+/* End of PCIe capability tuning */
+
+/*
+ * From here through hfi2_pci_err_handler definition is invoked via
+ * PCI error infrastructure, registered via pci
+ */
+static pci_ers_result_t
+pci_error_detected(struct pci_dev *pdev, pci_channel_state_t state)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+	pci_ers_result_t ret = PCI_ERS_RESULT_RECOVERED;
+
+	switch (state) {
+	case pci_channel_io_normal:
+		dd_dev_info(dd, "State Normal, ignoring\n");
+		break;
+
+	case pci_channel_io_frozen:
+		dd_dev_info(dd, "State Frozen, requesting reset\n");
+		pci_disable_device(pdev);
+		ret = PCI_ERS_RESULT_NEED_RESET;
+		break;
+
+	case pci_channel_io_perm_failure:
+		if (dd) {
+			dd_dev_info(dd, "State Permanent Failure, disabling\n");
+			/* no more register accesses! */
+			dd->flags &= ~HFI2_PRESENT;
+			hfi2_disable_after_error(dd);
+		}
+		 /* else early, or other problem */
+		ret =  PCI_ERS_RESULT_DISCONNECT;
+		break;
+
+	default: /* shouldn't happen */
+		dd_dev_info(dd, "HFI2 PCI errors detected (state %d)\n",
+			    state);
+		break;
+	}
+	return ret;
+}
+
+static pci_ers_result_t
+pci_mmio_enabled(struct pci_dev *pdev)
+{
+	u64 rev;
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+	pci_ers_result_t ret = PCI_ERS_RESULT_RECOVERED;
+
+	if (dd) {
+		/* test read a device register */
+		rev = read_csr(dd, CCE_REVISION);
+		if (rev == ~0ULL)
+			ret = PCI_ERS_RESULT_NEED_RESET;
+		dd_dev_info(dd,
+			    "HFI2 mmio_enabled function called, read revision 0x%llx, returning %d\n",
+			    rev, ret);
+	}
+	return  ret;
+}
+
+static pci_ers_result_t
+pci_slot_reset(struct pci_dev *pdev)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+
+	dd_dev_info(dd, "HFI2 slot_reset function called, ignored\n");
+	return PCI_ERS_RESULT_CAN_RECOVER;
+}
+
+static void
+pci_resume(struct pci_dev *pdev)
+{
+	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
+
+	dd_dev_info(dd, "HFI2 resume function called\n");
+	/*
+	 * Running jobs will fail, since it's asynchronous
+	 * unlike sysfs-requested reset.   Better than
+	 * doing nothing.
+	 */
+	hfi2_init(dd, 1); /* same as re-init after reset */
+}
+
+const struct pci_error_handlers hfi2_pci_err_handler = {
+	.error_detected = pci_error_detected,
+	.mmio_enabled = pci_mmio_enabled,
+	.slot_reset = pci_slot_reset,
+	.resume = pci_resume,
+};
+
+/*============================================================================*/
+/* PCIe Gen3 support */
+
+/*
+ * This code is separated out because it is expected to be removed in the
+ * final shipping product.  If not, then it will be revisited and items
+ * will be moved to more standard locations.
+ */
+
+/* ASIC_PCI_SD_HOST_STATUS.FW_DNLD_STS field values */
+#define DL_STATUS_HFI0 0x1	/* hfi0 firmware download complete */
+#define DL_STATUS_HFI2 0x2	/* hfi2 firmware download complete */
+#define DL_STATUS_BOTH 0x3	/* hfi0 and hfi2 firmware download complete */
+
+/* ASIC_PCI_SD_HOST_STATUS.FW_DNLD_ERR field values */
+#define DL_ERR_NONE		0x0	/* no error */
+#define DL_ERR_SWAP_PARITY	0x1	/* parity error in SerDes interrupt */
+					/*   or response data */
+#define DL_ERR_DISABLED	0x2	/* hfi disabled */
+#define DL_ERR_SECURITY	0x3	/* security check failed */
+#define DL_ERR_SBUS		0x4	/* SBus status error */
+#define DL_ERR_XFR_PARITY	0x5	/* parity error during ROM transfer*/
+
+/* gasket block secondary bus reset delay */
+#define SBR_DELAY_US 200000	/* 200ms */
+
+static uint pcie_target = 3;
+module_param(pcie_target, uint, 0444);
+MODULE_PARM_DESC(pcie_target, "PCIe target speed (0 skip, 1-3 Gen1-3)");
+
+static uint pcie_force;
+module_param(pcie_force, uint, 0444);
+MODULE_PARM_DESC(pcie_force, "Force driver to do a PCIe firmware download even if already at target speed");
+
+static uint pcie_retry = 5;
+module_param(pcie_retry, uint, 0444);
+MODULE_PARM_DESC(pcie_retry, "Driver will try this many times to reach requested speed");
+
+#define UNSET_PSET 255
+#define DEFAULT_DISCRETE_PSET 2	/* discrete HFI */
+#define DEFAULT_MCP_PSET 6	/* MCP HFI */
+static uint pcie_pset = UNSET_PSET;
+module_param(pcie_pset, uint, 0444);
+MODULE_PARM_DESC(pcie_pset, "PCIe Eq Pset value to use, range is 0-10");
+
+static uint pcie_ctle = 3; /* discrete on, integrated on */
+module_param(pcie_ctle, uint, 0444);
+MODULE_PARM_DESC(pcie_ctle, "PCIe static CTLE mode, bit 0 - discrete on/off, bit 1 - integrated on/off");
+
+/* equalization columns */
+#define PREC 0
+#define ATTN 1
+#define POST 2
+
+/* discrete silicon preliminary equalization values */
+static const u8 discrete_preliminary_eq[11][3] = {
+	/* prec   attn   post */
+	{  0x00,  0x00,  0x12 },	/* p0 */
+	{  0x00,  0x00,  0x0c },	/* p1 */
+	{  0x00,  0x00,  0x0f },	/* p2 */
+	{  0x00,  0x00,  0x09 },	/* p3 */
+	{  0x00,  0x00,  0x00 },	/* p4 */
+	{  0x06,  0x00,  0x00 },	/* p5 */
+	{  0x09,  0x00,  0x00 },	/* p6 */
+	{  0x06,  0x00,  0x0f },	/* p7 */
+	{  0x09,  0x00,  0x09 },	/* p8 */
+	{  0x0c,  0x00,  0x00 },	/* p9 */
+	{  0x00,  0x00,  0x18 },	/* p10 */
+};
+
+/* integrated silicon preliminary equalization values */
+static const u8 integrated_preliminary_eq[11][3] = {
+	/* prec   attn   post */
+	{  0x00,  0x1e,  0x07 },	/* p0 */
+	{  0x00,  0x1e,  0x05 },	/* p1 */
+	{  0x00,  0x1e,  0x06 },	/* p2 */
+	{  0x00,  0x1e,  0x04 },	/* p3 */
+	{  0x00,  0x1e,  0x00 },	/* p4 */
+	{  0x03,  0x1e,  0x00 },	/* p5 */
+	{  0x04,  0x1e,  0x00 },	/* p6 */
+	{  0x03,  0x1e,  0x06 },	/* p7 */
+	{  0x03,  0x1e,  0x04 },	/* p8 */
+	{  0x05,  0x1e,  0x00 },	/* p9 */
+	{  0x00,  0x1e,  0x0a },	/* p10 */
+};
+
+static const u8 discrete_ctle_tunings[11][4] = {
+	/* DC     LF     HF     BW */
+	{  0x48,  0x0b,  0x04,  0x04 },	/* p0 */
+	{  0x60,  0x05,  0x0f,  0x0a },	/* p1 */
+	{  0x50,  0x09,  0x06,  0x06 },	/* p2 */
+	{  0x68,  0x05,  0x0f,  0x0a },	/* p3 */
+	{  0x80,  0x05,  0x0f,  0x0a },	/* p4 */
+	{  0x70,  0x05,  0x0f,  0x0a },	/* p5 */
+	{  0x68,  0x05,  0x0f,  0x0a },	/* p6 */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p7 */
+	{  0x48,  0x09,  0x06,  0x06 },	/* p8 */
+	{  0x60,  0x05,  0x0f,  0x0a },	/* p9 */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p10 */
+};
+
+static const u8 integrated_ctle_tunings[11][4] = {
+	/* DC     LF     HF     BW */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p0 */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p1 */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p2 */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p3 */
+	{  0x58,  0x0a,  0x05,  0x05 },	/* p4 */
+	{  0x48,  0x0a,  0x05,  0x05 },	/* p5 */
+	{  0x40,  0x0a,  0x05,  0x05 },	/* p6 */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p7 */
+	{  0x38,  0x0f,  0x00,  0x00 },	/* p8 */
+	{  0x38,  0x09,  0x06,  0x06 },	/* p9 */
+	{  0x38,  0x0e,  0x01,  0x01 },	/* p10 */
+};
+
+/* helper to format the value to write to hardware */
+#define eq_value(pre, curr, post) \
+	((((u32)(pre)) << \
+			PCIE_CFG_REG_PL102_GEN3_EQ_PRE_CURSOR_PSET_SHIFT) \
+	| (((u32)(curr)) << PCIE_CFG_REG_PL102_GEN3_EQ_CURSOR_PSET_SHIFT) \
+	| (((u32)(post)) << \
+		PCIE_CFG_REG_PL102_GEN3_EQ_POST_CURSOR_PSET_SHIFT))
+
+/*
+ * Load the given EQ preset table into the PCIe hardware.
+ */
+static int load_eq_table(struct hfi2_devdata *dd, const u8 eq[11][3], u8 fs,
+			 u8 div)
+{
+	struct pci_dev *pdev = dd->pcidev;
+	u32 hit_error = 0;
+	u32 violation;
+	u32 i;
+	u8 c_minus1, c0, c_plus1;
+	int ret;
+
+	for (i = 0; i < 11; i++) {
+		/* set index */
+		pci_write_config_dword(pdev, PCIE_CFG_REG_PL103, i);
+		/* write the value */
+		c_minus1 = eq[i][PREC] / div;
+		c0 = fs - (eq[i][PREC] / div) - (eq[i][POST] / div);
+		c_plus1 = eq[i][POST] / div;
+		pci_write_config_dword(pdev, PCIE_CFG_REG_PL102,
+				       eq_value(c_minus1, c0, c_plus1));
+		/* check if these coefficients violate EQ rules */
+		ret = pci_read_config_dword(dd->pcidev,
+					    PCIE_CFG_REG_PL105, &violation);
+		if (ret) {
+			dd_dev_err(dd, "Unable to read from PCI config\n");
+			hit_error = 1;
+			break;
+		}
+
+		if (violation
+		    & PCIE_CFG_REG_PL105_GEN3_EQ_VIOLATE_COEF_RULES_SMASK){
+			if (hit_error == 0) {
+				dd_dev_err(dd,
+					   "Gen3 EQ Table Coefficient rule violations\n");
+				dd_dev_err(dd, "         prec   attn   post\n");
+			}
+			dd_dev_err(dd, "   p%02d:   %02x     %02x     %02x\n",
+				   i, (u32)eq[i][0], (u32)eq[i][1],
+				   (u32)eq[i][2]);
+			dd_dev_err(dd, "            %02x     %02x     %02x\n",
+				   (u32)c_minus1, (u32)c0, (u32)c_plus1);
+			hit_error = 1;
+		}
+	}
+	if (hit_error)
+		return -EINVAL;
+	return 0;
+}
+
+/*
+ * Steps to be done after the PCIe firmware is downloaded and
+ * before the SBR for the Pcie Gen3.
+ * The SBus resource is already being held.
+ */
+static void pcie_post_steps(struct hfi2_devdata *dd)
+{
+	int i;
+
+	set_sbus_fast_mode(dd);
+	/*
+	 * Write to the PCIe PCSes to set the G3_LOCKED_NEXT bits to 1.
+	 * This avoids a spurious framing error that can otherwise be
+	 * generated by the MAC layer.
+	 *
+	 * Use individual addresses since no broadcast is set up.
+	 */
+	for (i = 0; i < NUM_PCIE_SERDES; i++) {
+		sbus_request(dd, pcie_pcs_addrs[dd->hfi2_id][i],
+			     0x03, WRITE_SBUS_RECEIVER, 0x00022132);
+	}
+
+	clear_sbus_fast_mode(dd);
+}
+
+/*
+ * Trigger a secondary bus reset (SBR) on ourselves using our parent.
+ *
+ * Based on pci_parent_bus_reset() which is not exported by the
+ * kernel core.
+ */
+static int trigger_sbr(struct hfi2_devdata *dd)
+{
+	struct pci_dev *dev = dd->pcidev;
+	struct pci_dev *pdev;
+
+	/* need a parent */
+	if (!dev->bus->self) {
+		dd_dev_err(dd, "%s: no parent device\n", __func__);
+		return -ENOTTY;
+	}
+
+	/* should not be anyone else on the bus */
+	list_for_each_entry(pdev, &dev->bus->devices, bus_list)
+		if (pdev != dev) {
+			dd_dev_err(dd,
+				   "%s: another device is on the same bus\n",
+				   __func__);
+			return -ENOTTY;
+		}
+
+	/*
+	 * This is an end around to do an SBR during probe time. A new API needs
+	 * to be implemented to have cleaner interface but this fixes the
+	 * current brokenness
+	 */
+	return pci_bridge_secondary_bus_reset(dev->bus->self);
+}
+
+/*
+ * Write the given gasket interrupt register.
+ */
+static void write_gasket_interrupt(struct hfi2_devdata *dd, int index,
+				   u16 code, u16 data)
+{
+	write_csr(dd, ASIC_PCIE_SD_INTRPT_LIST + (index * 8),
+		  (((u64)code << ASIC_PCIE_SD_INTRPT_LIST_INTRPT_CODE_SHIFT) |
+		   ((u64)data << ASIC_PCIE_SD_INTRPT_LIST_INTRPT_DATA_SHIFT)));
+}
+
+/*
+ * Tell the gasket logic how to react to the reset.
+ */
+static void arm_gasket_logic(struct hfi2_devdata *dd)
+{
+	u64 reg;
+
+	reg = (((u64)1 << dd->hfi2_id) <<
+	       ASIC_PCIE_SD_HOST_CMD_INTRPT_CMD_SHIFT) |
+	      ((u64)pcie_serdes_broadcast[dd->hfi2_id] <<
+	       ASIC_PCIE_SD_HOST_CMD_SBUS_RCVR_ADDR_SHIFT |
+	       ASIC_PCIE_SD_HOST_CMD_SBR_MODE_SMASK |
+	       ((u64)SBR_DELAY_US & ASIC_PCIE_SD_HOST_CMD_TIMER_MASK) <<
+	       ASIC_PCIE_SD_HOST_CMD_TIMER_SHIFT);
+	write_csr(dd, ASIC_PCIE_SD_HOST_CMD, reg);
+	/* read back to push the write */
+	read_csr(dd, ASIC_PCIE_SD_HOST_CMD);
+}
+
+/*
+ * CCE_PCIE_CTRL long name helpers
+ * We redefine these shorter macros to use in the code while leaving
+ * chip_registers.h to be autogenerated from the hardware spec.
+ */
+#define LANE_BUNDLE_MASK              CCE_PCIE_CTRL_PCIE_LANE_BUNDLE_MASK
+#define LANE_BUNDLE_SHIFT             CCE_PCIE_CTRL_PCIE_LANE_BUNDLE_SHIFT
+#define LANE_DELAY_MASK               CCE_PCIE_CTRL_PCIE_LANE_DELAY_MASK
+#define LANE_DELAY_SHIFT              CCE_PCIE_CTRL_PCIE_LANE_DELAY_SHIFT
+#define MARGIN_OVERWRITE_ENABLE_SHIFT CCE_PCIE_CTRL_XMT_MARGIN_OVERWRITE_ENABLE_SHIFT
+#define MARGIN_SHIFT                  CCE_PCIE_CTRL_XMT_MARGIN_SHIFT
+#define MARGIN_G1_G2_OVERWRITE_MASK   CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_OVERWRITE_ENABLE_MASK
+#define MARGIN_G1_G2_OVERWRITE_SHIFT  CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_OVERWRITE_ENABLE_SHIFT
+#define MARGIN_GEN1_GEN2_MASK         CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_MASK
+#define MARGIN_GEN1_GEN2_SHIFT        CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_SHIFT
+
+ /*
+  * Write xmt_margin for full-swing (WFR-B) or half-swing (WFR-C).
+  */
+static void write_xmt_margin(struct hfi2_devdata *dd, const char *fname)
+{
+	u64 pcie_ctrl;
+	u64 xmt_margin;
+	u64 xmt_margin_oe;
+	u64 lane_delay;
+	u64 lane_bundle;
+
+	pcie_ctrl = read_csr(dd, CCE_PCIE_CTRL);
+
+	/*
+	 * For Discrete, use full-swing.
+	 *  - PCIe TX defaults to full-swing.
+	 *    Leave this register as default.
+	 * For Integrated, use half-swing
+	 *  - Copy xmt_margin and xmt_margin_oe
+	 *    from Gen1/Gen2 to Gen3.
+	 */
+	if (dd->pcidev->device == PCI_DEVICE_ID_INTEL1) { /* integrated */
+		/* extract initial fields */
+		xmt_margin = (pcie_ctrl >> MARGIN_GEN1_GEN2_SHIFT)
+			      & MARGIN_GEN1_GEN2_MASK;
+		xmt_margin_oe = (pcie_ctrl >> MARGIN_G1_G2_OVERWRITE_SHIFT)
+				 & MARGIN_G1_G2_OVERWRITE_MASK;
+		lane_delay = (pcie_ctrl >> LANE_DELAY_SHIFT) & LANE_DELAY_MASK;
+		lane_bundle = (pcie_ctrl >> LANE_BUNDLE_SHIFT)
+			       & LANE_BUNDLE_MASK;
+
+		/*
+		 * For A0, EFUSE values are not set.  Override with the
+		 * correct values.
+		 */
+		if (is_ax(dd)) {
+			/*
+			 * xmt_margin and OverwiteEnabel should be the
+			 * same for Gen1/Gen2 and Gen3
+			 */
+			xmt_margin = 0x5;
+			xmt_margin_oe = 0x1;
+			lane_delay = 0xF; /* Delay 240ns. */
+			lane_bundle = 0x0; /* Set to 1 lane. */
+		}
+
+		/* overwrite existing values */
+		pcie_ctrl = (xmt_margin << MARGIN_GEN1_GEN2_SHIFT)
+			| (xmt_margin_oe << MARGIN_G1_G2_OVERWRITE_SHIFT)
+			| (xmt_margin << MARGIN_SHIFT)
+			| (xmt_margin_oe << MARGIN_OVERWRITE_ENABLE_SHIFT)
+			| (lane_delay << LANE_DELAY_SHIFT)
+			| (lane_bundle << LANE_BUNDLE_SHIFT);
+
+		write_csr(dd, CCE_PCIE_CTRL, pcie_ctrl);
+	}
+
+	dd_dev_dbg(dd, "%s: program XMT margin, CcePcieCtrl 0x%llx\n",
+		   fname, pcie_ctrl);
+}
+
+/*
+ * Do all the steps needed to transition the PCIe link to Gen3 speed.
+ */
+int do_pcie_gen3_transition(struct hfi2_devdata *dd)
+{
+	struct pci_dev *parent = dd->pcidev->bus->self;
+	u64 fw_ctrl;
+	u64 reg, therm;
+	u32 reg32, fs, lf;
+	u32 status, err;
+	int ret;
+	int do_retry, retry_count = 0;
+	int intnum = 0;
+	uint default_pset;
+	uint pset = pcie_pset;
+	u16 target_vector, target_speed;
+	u16 lnkctl2, vendor;
+	u8 div;
+	const u8 (*eq)[3];
+	const u8 (*ctle_tunings)[4];
+	uint static_ctle_mode;
+	int return_error = 0;
+	u32 target_width;
+
+	/* PCIe Gen3 is for the ASIC only */
+	if (dd->icode != ICODE_RTL_SILICON)
+		return 0;
+
+	if (pcie_target == 1) {			/* target Gen1 */
+		target_vector = PCI_EXP_LNKCTL2_TLS_2_5GT;
+		target_speed = 2500;
+	} else if (pcie_target == 2) {		/* target Gen2 */
+		target_vector = PCI_EXP_LNKCTL2_TLS_5_0GT;
+		target_speed = 5000;
+	} else if (pcie_target == 3) {		/* target Gen3 */
+		target_vector = PCI_EXP_LNKCTL2_TLS_8_0GT;
+		target_speed = 8000;
+	} else {
+		/* off or invalid target - skip */
+		dd_dev_info(dd, "%s: Skipping PCIe transition\n", __func__);
+		return 0;
+	}
+
+	/* if already at target speed, done (unless forced) */
+	if (dd->lbus_speed == target_speed) {
+		dd_dev_info(dd, "%s: PCIe already at gen%d, %s\n", __func__,
+			    pcie_target,
+			    pcie_force ? "re-doing anyway" : "skipping");
+		if (!pcie_force)
+			return 0;
+	}
+
+	/*
+	 * The driver cannot do the transition if it has no access to the
+	 * upstream component
+	 */
+	if (!parent) {
+		dd_dev_info(dd, "%s: No upstream, Can't do gen3 transition\n",
+			    __func__);
+		return 0;
+	}
+
+	/* Previous Gen1/Gen2 bus width */
+	target_width = dd->lbus_width;
+
+	/*
+	 * Do the Gen3 transition.  Steps are those of the PCIe Gen3
+	 * recipe.
+	 */
+
+	/* step 1: pcie link working in gen1/gen2 */
+
+	/* step 2: if either side is not capable of Gen3, done */
+	if (pcie_target == 3 && !dd->link_gen3_capable) {
+		dd_dev_err(dd, "The PCIe link is not Gen3 capable\n");
+		ret = -EOPNOTSUPP;
+		goto done_no_mutex;
+	}
+
+	/* hold the SBus resource across the firmware download and SBR */
+	ret = acquire_chip_resource(dd, CR_SBUS, SBUS_TIMEOUT);
+	if (ret) {
+		dd_dev_err(dd, "%s: unable to acquire SBus resource\n",
+			   __func__);
+		return ret;
+	}
+
+	/* make sure thermal polling is not causing interrupts */
+	therm = read_csr(dd, ASIC_CFG_THERM_POLL_EN);
+	if (therm) {
+		write_csr(dd, ASIC_CFG_THERM_POLL_EN, 0x0);
+		msleep(100);
+		dd_dev_info(dd, "%s: Disabled therm polling\n",
+			    __func__);
+	}
+
+retry:
+	/* the SBus download will reset the spico for thermal */
+
+	/* step 3: download SBus Master firmware */
+	/* step 4: download PCIe Gen3 SerDes firmware */
+	dd_dev_info(dd, "%s: downloading firmware\n", __func__);
+	ret = load_pcie_firmware(dd);
+	if (ret) {
+		/* do not proceed if the firmware cannot be downloaded */
+		return_error = 1;
+		goto done;
+	}
+
+	/* step 5: set up device parameter settings */
+	dd_dev_info(dd, "%s: setting PCIe registers\n", __func__);
+
+	/*
+	 * PcieCfgSpcie1 - Link Control 3
+	 * Leave at reset value.  No need to set PerfEq - link equalization
+	 * will be performed automatically after the SBR when the target
+	 * speed is 8GT/s.
+	 */
+
+	/* clear all 16 per-lane error bits (PCIe: Lane Error Status) */
+	pci_write_config_dword(dd->pcidev, PCIE_CFG_SPCIE2, 0xffff);
+
+	/* step 5a: Set Synopsys Port Logic registers */
+
+	/*
+	 * PcieCfgRegPl2 - Port Force Link
+	 *
+	 * Set the low power field to 0x10 to avoid unnecessary power
+	 * management messages.  All other fields are zero.
+	 */
+	reg32 = 0x10ul << PCIE_CFG_REG_PL2_LOW_PWR_ENT_CNT_SHIFT;
+	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL2, reg32);
+
+	/*
+	 * PcieCfgRegPl100 - Gen3 Control
+	 *
+	 * turn off PcieCfgRegPl100.Gen3ZRxDcNonCompl
+	 * turn on PcieCfgRegPl100.EqEieosCnt
+	 * Everything else zero.
+	 */
+	reg32 = PCIE_CFG_REG_PL100_EQ_EIEOS_CNT_SMASK;
+	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL100, reg32);
+
+	/*
+	 * PcieCfgRegPl101 - Gen3 EQ FS and LF
+	 * PcieCfgRegPl102 - Gen3 EQ Presets to Coefficients Mapping
+	 * PcieCfgRegPl103 - Gen3 EQ Preset Index
+	 * PcieCfgRegPl105 - Gen3 EQ Status
+	 *
+	 * Give initial EQ settings.
+	 */
+	if (dd->pcidev->device == PCI_DEVICE_ID_INTEL0) { /* discrete */
+		/* 1000mV, FS=24, LF = 8 */
+		fs = 24;
+		lf = 8;
+		div = 3;
+		eq = discrete_preliminary_eq;
+		default_pset = DEFAULT_DISCRETE_PSET;
+		ctle_tunings = discrete_ctle_tunings;
+		/* bit 0 - discrete on/off */
+		static_ctle_mode = pcie_ctle & 0x1;
+	} else {
+		/* 400mV, FS=29, LF = 9 */
+		fs = 29;
+		lf = 9;
+		div = 1;
+		eq = integrated_preliminary_eq;
+		default_pset = DEFAULT_MCP_PSET;
+		ctle_tunings = integrated_ctle_tunings;
+		/* bit 1 - integrated on/off */
+		static_ctle_mode = (pcie_ctle >> 1) & 0x1;
+	}
+	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL101,
+			       (fs <<
+				PCIE_CFG_REG_PL101_GEN3_EQ_LOCAL_FS_SHIFT) |
+			       (lf <<
+				PCIE_CFG_REG_PL101_GEN3_EQ_LOCAL_LF_SHIFT));
+	ret = load_eq_table(dd, eq, fs, div);
+	if (ret)
+		goto done;
+
+	/*
+	 * PcieCfgRegPl106 - Gen3 EQ Control
+	 *
+	 * Set Gen3EqPsetReqVec, leave other fields 0.
+	 */
+	if (pset == UNSET_PSET)
+		pset = default_pset;
+	if (pset > 10) {	/* valid range is 0-10, inclusive */
+		dd_dev_err(dd, "%s: Invalid Eq Pset %u, setting to %d\n",
+			   __func__, pset, default_pset);
+		pset = default_pset;
+	}
+	dd_dev_info(dd, "%s: using EQ Pset %u\n", __func__, pset);
+	pci_write_config_dword(dd->pcidev, PCIE_CFG_REG_PL106,
+			       ((1 << pset) <<
+			PCIE_CFG_REG_PL106_GEN3_EQ_PSET_REQ_VEC_SHIFT) |
+			PCIE_CFG_REG_PL106_GEN3_EQ_EVAL2MS_DISABLE_SMASK |
+			PCIE_CFG_REG_PL106_GEN3_EQ_PHASE23_EXIT_MODE_SMASK);
+
+	/*
+	 * step 5b: Do post firmware download steps via SBus
+	 */
+	dd_dev_info(dd, "%s: doing pcie post steps\n", __func__);
+	pcie_post_steps(dd);
+
+	/*
+	 * step 5c: Program gasket interrupts
+	 */
+	/* set the Rx Bit Rate to REFCLK ratio */
+	write_gasket_interrupt(dd, intnum++, 0x0006, 0x0050);
+	/* disable pCal for PCIe Gen3 RX equalization */
+	/* select adaptive or static CTLE */
+	write_gasket_interrupt(dd, intnum++, 0x0026,
+			       0x5b01 | (static_ctle_mode << 3));
+	/*
+	 * Enable iCal for PCIe Gen3 RX equalization, and set which
+	 * evaluation of RX_EQ_EVAL will launch the iCal procedure.
+	 */
+	write_gasket_interrupt(dd, intnum++, 0x0026, 0x5202);
+
+	if (static_ctle_mode) {
+		/* apply static CTLE tunings */
+		u8 pcie_dc, pcie_lf, pcie_hf, pcie_bw;
+
+		pcie_dc = ctle_tunings[pset][0];
+		pcie_lf = ctle_tunings[pset][1];
+		pcie_hf = ctle_tunings[pset][2];
+		pcie_bw = ctle_tunings[pset][3];
+		write_gasket_interrupt(dd, intnum++, 0x0026, 0x0200 | pcie_dc);
+		write_gasket_interrupt(dd, intnum++, 0x0026, 0x0100 | pcie_lf);
+		write_gasket_interrupt(dd, intnum++, 0x0026, 0x0000 | pcie_hf);
+		write_gasket_interrupt(dd, intnum++, 0x0026, 0x5500 | pcie_bw);
+	}
+
+	/* terminate list */
+	write_gasket_interrupt(dd, intnum++, 0x0000, 0x0000);
+
+	/*
+	 * step 5d: program XMT margin
+	 */
+	write_xmt_margin(dd, __func__);
+
+	/*
+	 * step 5e: disable active state power management (ASPM). It
+	 * will be enabled if required later
+	 */
+	dd_dev_info(dd, "%s: clearing ASPM\n", __func__);
+	aspm_hw_disable_l1(dd);
+
+	/*
+	 * step 5f: clear DirectSpeedChange
+	 * PcieCfgRegPl67.DirectSpeedChange must be zero to prevent the
+	 * change in the speed target from starting before we are ready.
+	 * This field defaults to 0 and we are not changing it, so nothing
+	 * needs to be done.
+	 */
+
+	/* step 5g: Set target link speed */
+	/*
+	 * Set target link speed to be target on both device and parent.
+	 * On setting the parent: Some system BIOSs "helpfully" set the
+	 * parent target speed to Gen2 to match the ASIC's initial speed.
+	 * We can set the target Gen3 because we have already checked
+	 * that it is Gen3 capable earlier.
+	 */
+	dd_dev_info(dd, "%s: setting parent target link speed\n", __func__);
+	ret = pcie_capability_read_word(parent, PCI_EXP_LNKCTL2, &lnkctl2);
+	if (ret) {
+		dd_dev_err(dd, "Unable to read from PCI config\n");
+		return_error = 1;
+		goto done;
+	}
+
+	dd_dev_info(dd, "%s: ..old link control2: 0x%x\n", __func__,
+		    (u32)lnkctl2);
+	/* only write to parent if target is not as high as ours */
+	if ((lnkctl2 & PCI_EXP_LNKCTL2_TLS) < target_vector) {
+		ret = pcie_capability_clear_and_set_word(parent, PCI_EXP_LNKCTL2,
+							 PCI_EXP_LNKCTL2_TLS,
+							 target_vector);
+		if (ret) {
+			dd_dev_err(dd, "Unable to change parent PCI target speed\n");
+			return_error = 1;
+			goto done;
+		}
+	} else {
+		dd_dev_info(dd, "%s: ..target speed is OK\n", __func__);
+	}
+
+	dd_dev_info(dd, "%s: setting target link speed\n", __func__);
+	ret = pcie_capability_clear_and_set_word(dd->pcidev, PCI_EXP_LNKCTL2,
+						 PCI_EXP_LNKCTL2_TLS,
+						 target_vector);
+	if (ret) {
+		dd_dev_err(dd, "Unable to change device PCI target speed\n");
+		return_error = 1;
+		goto done;
+	}
+
+	/* step 5h: arm gasket logic */
+	/* hold DC in reset across the SBR */
+	write_csr(dd, CCE_DC_CTRL, CCE_DC_CTRL_DC_RESET_SMASK);
+	(void)read_csr(dd, CCE_DC_CTRL); /* DC reset hold */
+	/* save firmware control across the SBR */
+	fw_ctrl = read_csr(dd, MISC_CFG_FW_CTRL);
+
+	dd_dev_info(dd, "%s: arming gasket logic\n", __func__);
+	arm_gasket_logic(dd);
+
+	/*
+	 * step 6: quiesce PCIe link
+	 * The chip has already been reset, so there will be no traffic
+	 * from the chip.  Linux has no easy way to enforce that it will
+	 * not try to access the device, so we just need to hope it doesn't
+	 * do it while we are doing the reset.
+	 */
+
+	/*
+	 * step 7: initiate the secondary bus reset (SBR)
+	 * step 8: hardware brings the links back up
+	 * step 9: wait for link speed transition to be complete
+	 */
+	dd_dev_info(dd, "%s: calling trigger_sbr\n", __func__);
+	ret = trigger_sbr(dd);
+	if (ret)
+		goto done;
+
+	/* step 10: decide what to do next */
+
+	/* check if we can read PCI space */
+	ret = pci_read_config_word(dd->pcidev, PCI_VENDOR_ID, &vendor);
+	if (ret) {
+		dd_dev_info(dd,
+			    "%s: read of VendorID failed after SBR, err %d\n",
+			    __func__, ret);
+		return_error = 1;
+		goto done;
+	}
+	if (vendor == 0xffff) {
+		dd_dev_info(dd, "%s: VendorID is all 1s after SBR\n", __func__);
+		return_error = 1;
+		ret = -EIO;
+		goto done;
+	}
+
+	/* restore PCI space registers we know were reset */
+	dd_dev_info(dd, "%s: calling restore_pci_variables\n", __func__);
+	ret = restore_pci_variables(dd);
+	if (ret) {
+		dd_dev_err(dd, "%s: Could not restore PCI variables\n",
+			   __func__);
+		return_error = 1;
+		goto done;
+	}
+
+	/* restore firmware control */
+	write_csr(dd, MISC_CFG_FW_CTRL, fw_ctrl);
+
+	/*
+	 * Check the gasket block status.
+	 *
+	 * This is the first CSR read after the SBR.  If the read returns
+	 * all 1s (fails), the link did not make it back.
+	 *
+	 * Once we're sure we can read and write, clear the DC reset after
+	 * the SBR.  Then check for any per-lane errors. Then look over
+	 * the status.
+	 */
+	reg = read_csr(dd, ASIC_PCIE_SD_HOST_STATUS);
+	dd_dev_info(dd, "%s: gasket block status: 0x%llx\n", __func__, reg);
+	if (reg == ~0ull) {	/* PCIe read failed/timeout */
+		dd_dev_err(dd, "SBR failed - unable to read from device\n");
+		return_error = 1;
+		ret = -EOPNOTSUPP;
+		goto done;
+	}
+
+	/* clear the DC reset */
+	write_csr(dd, CCE_DC_CTRL, 0);
+
+	/* Set the LED off (only 1 port for WFR) */
+	dd->params->setextled(&dd->pport[0], 0);
+
+	/* check for any per-lane errors */
+	ret = pci_read_config_dword(dd->pcidev, PCIE_CFG_SPCIE2, &reg32);
+	if (ret) {
+		dd_dev_err(dd, "Unable to read from PCI config\n");
+		return_error = 1;
+		goto done;
+	}
+
+	dd_dev_info(dd, "%s: per-lane errors: 0x%x\n", __func__, reg32);
+
+	/* extract status, look for our HFI */
+	status = (reg >> ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_STS_SHIFT)
+			& ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_STS_MASK;
+	if ((status & (1 << dd->hfi2_id)) == 0) {
+		dd_dev_err(dd,
+			   "%s: gasket status 0x%x, expecting 0x%x\n",
+			   __func__, status, 1 << dd->hfi2_id);
+		ret = -EIO;
+		goto done;
+	}
+
+	/* extract error */
+	err = (reg >> ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_ERR_SHIFT)
+		& ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_ERR_MASK;
+	if (err) {
+		dd_dev_err(dd, "%s: gasket error %d\n", __func__, err);
+		ret = -EIO;
+		goto done;
+	}
+
+	/* update our link information cache */
+	update_lbus_info(dd);
+	dd_dev_info(dd, "%s: new speed and width: %s\n", __func__,
+		    dd->lbus_info);
+
+	if (dd->lbus_speed != target_speed ||
+	    dd->lbus_width < target_width) { /* not target */
+		/* maybe retry */
+		do_retry = retry_count < pcie_retry;
+		dd_dev_err(dd, "PCIe link speed or width did not match target%s\n",
+			   do_retry ? ", retrying" : "");
+		retry_count++;
+		if (do_retry) {
+			msleep(100); /* allow time to settle */
+			goto retry;
+		}
+		ret = -EIO;
+	}
+
+done:
+	if (therm) {
+		write_csr(dd, ASIC_CFG_THERM_POLL_EN, 0x1);
+		msleep(100);
+		dd_dev_info(dd, "%s: Re-enable therm polling\n",
+			    __func__);
+	}
+	release_chip_resource(dd, CR_SBUS);
+done_no_mutex:
+	/* return no error if it is OK to be at current speed */
+	if (ret && !return_error) {
+		dd_dev_err(dd, "Proceeding at current speed PCIe speed\n");
+		ret = 0;
+	}
+
+	dd_dev_dbg(dd, "%s: done\n", __func__);
+	return ret;
+}
diff --git a/drivers/infiniband/hw/hfi2/platform.c b/drivers/infiniband/hw/hfi2/platform.c
new file mode 100644
index 000000000000..3cf767f5cdcd
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/platform.c
@@ -0,0 +1,1041 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/firmware.h>
+
+#include "hfi2.h"
+#include "efivar.h"
+#include "eprom.h"
+
+#define DEFAULT_PLATFORM_CONFIG_NAME "hfi2_platform.dat"
+
+static int validate_scratch_checksum(struct hfi2_devdata *dd)
+{
+	u64 checksum = 0, temp_scratch = 0;
+	int i, j, version;
+
+	temp_scratch = read_csr(dd, ASIC_CFG_SCRATCH);
+	version = (temp_scratch & BITMAP_VERSION_SMASK) >> BITMAP_VERSION_SHIFT;
+
+	/* Prevent power on default of all zeroes from passing checksum */
+	if (!version) {
+		dd_dev_err(dd, "%s: Config bitmap uninitialized\n", __func__);
+		dd_dev_err(dd,
+			   "%s: Please update your BIOS to support active channels\n",
+			   __func__);
+		return 0;
+	}
+
+	/*
+	 * ASIC scratch 0 only contains the checksum and bitmap version as
+	 * fields of interest, both of which are handled separately from the
+	 * loop below, so skip it
+	 */
+	checksum += version;
+	for (i = 1; i < ASIC_NUM_SCRATCH; i++) {
+		temp_scratch = read_csr(dd, ASIC_CFG_SCRATCH + (8 * i));
+		for (j = sizeof(u64); j != 0; j -= 2) {
+			checksum += (temp_scratch & 0xFFFF);
+			temp_scratch >>= 16;
+		}
+	}
+
+	while (checksum >> 16)
+		checksum = (checksum & CHECKSUM_MASK) + (checksum >> 16);
+
+	temp_scratch = read_csr(dd, ASIC_CFG_SCRATCH);
+	temp_scratch &= CHECKSUM_SMASK;
+	temp_scratch >>= CHECKSUM_SHIFT;
+
+	if (checksum + temp_scratch == 0xFFFF)
+		return 1;
+
+	dd_dev_err(dd, "%s: Configuration bitmap corrupted\n", __func__);
+	return 0;
+}
+
+static void save_platform_config_fields(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 temp_scratch = 0, temp_dest = 0;
+
+	temp_scratch = read_csr(dd, ASIC_CFG_SCRATCH_1);
+
+	temp_dest = temp_scratch &
+		    (dd->hfi2_id ? PORT1_PORT_TYPE_SMASK :
+		     PORT0_PORT_TYPE_SMASK);
+	ppd->port_type = temp_dest >>
+			 (dd->hfi2_id ? PORT1_PORT_TYPE_SHIFT :
+			  PORT0_PORT_TYPE_SHIFT);
+
+	temp_dest = temp_scratch &
+		    (dd->hfi2_id ? PORT1_LOCAL_ATTEN_SMASK :
+		     PORT0_LOCAL_ATTEN_SMASK);
+	ppd->local_atten = temp_dest >>
+			   (dd->hfi2_id ? PORT1_LOCAL_ATTEN_SHIFT :
+			    PORT0_LOCAL_ATTEN_SHIFT);
+
+	temp_dest = temp_scratch &
+		    (dd->hfi2_id ? PORT1_REMOTE_ATTEN_SMASK :
+		     PORT0_REMOTE_ATTEN_SMASK);
+	ppd->remote_atten = temp_dest >>
+			    (dd->hfi2_id ? PORT1_REMOTE_ATTEN_SHIFT :
+			     PORT0_REMOTE_ATTEN_SHIFT);
+
+	temp_dest = temp_scratch &
+		    (dd->hfi2_id ? PORT1_DEFAULT_ATTEN_SMASK :
+		     PORT0_DEFAULT_ATTEN_SMASK);
+	ppd->default_atten = temp_dest >>
+			     (dd->hfi2_id ? PORT1_DEFAULT_ATTEN_SHIFT :
+			      PORT0_DEFAULT_ATTEN_SHIFT);
+
+	temp_scratch = read_csr(dd, dd->hfi2_id ? ASIC_CFG_SCRATCH_3 :
+				ASIC_CFG_SCRATCH_2);
+
+	ppd->tx_preset_eq = (temp_scratch & TX_EQ_SMASK) >> TX_EQ_SHIFT;
+	ppd->tx_preset_noeq = (temp_scratch & TX_NO_EQ_SMASK) >> TX_NO_EQ_SHIFT;
+	ppd->rx_preset = (temp_scratch & RX_SMASK) >> RX_SHIFT;
+
+	ppd->max_power_class = (temp_scratch & QSFP_MAX_POWER_SMASK) >>
+				QSFP_MAX_POWER_SHIFT;
+
+	ppd->config_from_scratch = true;
+}
+
+void hfi2_get_platform_config(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int ret = 0;
+	u8 *temp_platform_config = NULL;
+	u32 esize;
+	const struct firmware *platform_config_file = NULL;
+
+	if (is_integrated(dd)) {
+		if (validate_scratch_checksum(dd)) {
+			save_platform_config_fields(ppd);
+			return;
+		}
+	} else {
+		ret = eprom_read_platform_config(dd,
+						 (void **)&temp_platform_config,
+						 &esize);
+		if (!ret) {
+			/* success */
+			dd->platform_config.data = temp_platform_config;
+			dd->platform_config.size = esize;
+			return;
+		}
+	}
+	dd_dev_err(dd,
+		   "%s: Failed to get platform config, falling back to sub-optimal default file\n",
+		   __func__);
+
+	ret = request_firmware(&platform_config_file,
+			       DEFAULT_PLATFORM_CONFIG_NAME,
+			       &dd->pcidev->dev);
+	if (ret) {
+		dd_dev_err(dd,
+			   "%s: No default platform config file found\n",
+			   __func__);
+		return;
+	}
+
+	/*
+	 * Allocate separate memory block to store data and free firmware
+	 * structure. This allows free_platform_config to treat EPROM and
+	 * fallback configs in the same manner.
+	 */
+	dd->platform_config.data = kmemdup(platform_config_file->data,
+					   platform_config_file->size,
+					   GFP_KERNEL);
+	dd->platform_config.size = platform_config_file->size;
+	release_firmware(platform_config_file);
+}
+
+void free_platform_config(struct hfi2_devdata *dd)
+{
+	/* Release memory allocated for eprom or fallback file read. */
+	kfree(dd->platform_config.data);
+	dd->platform_config.data = NULL;
+}
+
+void get_port_type(struct hfi2_pportdata *ppd)
+{
+	int ret;
+	u32 temp;
+
+	ret = get_platform_config_field(ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+					PORT_TABLE_PORT_TYPE, &temp,
+					4);
+	if (ret) {
+		ppd->port_type = PORT_TYPE_UNKNOWN;
+		return;
+	}
+	ppd->port_type = temp;
+}
+
+int set_qsfp_tx(struct hfi2_pportdata *ppd, int on)
+{
+	u8 tx_ctrl_byte = on ? 0x0 : 0xF;
+	int ret = 0;
+
+	ret = qsfp_write(ppd, ppd->dd->hfi2_id, QSFP_TX_CTRL_BYTE_OFFS,
+			 &tx_ctrl_byte, 1);
+	/* we expected 1, so consider 0 an error */
+	if (ret == 0)
+		ret = -EIO;
+	else if (ret == 1)
+		ret = 0;
+	return ret;
+}
+
+static int qual_power(struct hfi2_pportdata *ppd)
+{
+	u32 cable_power_class = 0, power_class_max = 0;
+	u8 *cache = ppd->qsfp_info.cache;
+	int ret = 0;
+
+	ret = get_platform_config_field(
+		ppd, PLATFORM_CONFIG_SYSTEM_TABLE, 0,
+		SYSTEM_TABLE_QSFP_POWER_CLASS_MAX, &power_class_max, 4);
+	if (ret)
+		return ret;
+
+	cable_power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
+
+	if (cable_power_class > power_class_max)
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_POWER_POLICY);
+
+	if (ppd->offline_disabled_reason ==
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_POWER_POLICY)) {
+		dd_dev_err(
+			ppd->dd,
+			"%s: Port disabled due to system power restrictions\n",
+			__func__);
+		ret = -EPERM;
+	}
+	return ret;
+}
+
+static int qual_bitrate(struct hfi2_pportdata *ppd)
+{
+	u16 lss = ppd->link_speed_supported, lse = ppd->link_speed_enabled;
+	u8 *cache = ppd->qsfp_info.cache;
+
+	if ((lss & OPA_LINK_SPEED_25G) && (lse & OPA_LINK_SPEED_25G) &&
+	    cache[QSFP_NOM_BIT_RATE_250_OFFS] < 0x64)
+		ppd->offline_disabled_reason =
+			   HFI2_ODR_MASK(OPA_LINKDOWN_REASON_LINKSPEED_POLICY);
+
+	if ((lss & OPA_LINK_SPEED_12_5G) && (lse & OPA_LINK_SPEED_12_5G) &&
+	    cache[QSFP_NOM_BIT_RATE_100_OFFS] < 0x7D)
+		ppd->offline_disabled_reason =
+			   HFI2_ODR_MASK(OPA_LINKDOWN_REASON_LINKSPEED_POLICY);
+
+	if (ppd->offline_disabled_reason ==
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_LINKSPEED_POLICY)) {
+		dd_dev_err(
+			ppd->dd,
+			"%s: Cable failed bitrate check, disabling port\n",
+			__func__);
+		return -EPERM;
+	}
+	return 0;
+}
+
+static int set_qsfp_high_power(struct hfi2_pportdata *ppd)
+{
+	u8 cable_power_class = 0, power_ctrl_byte = 0;
+	u8 *cache = ppd->qsfp_info.cache;
+	int ret;
+
+	cable_power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
+
+	if (cable_power_class > QSFP_POWER_CLASS_1) {
+		power_ctrl_byte = cache[QSFP_PWR_CTRL_BYTE_OFFS];
+
+		power_ctrl_byte |= 1;
+		power_ctrl_byte &= ~(0x2);
+
+		ret = qsfp_write(ppd, ppd->dd->hfi2_id,
+				 QSFP_PWR_CTRL_BYTE_OFFS,
+				 &power_ctrl_byte, 1);
+		if (ret != 1)
+			return -EIO;
+
+		if (cable_power_class > QSFP_POWER_CLASS_4) {
+			power_ctrl_byte |= (1 << 2);
+			ret = qsfp_write(ppd, ppd->dd->hfi2_id,
+					 QSFP_PWR_CTRL_BYTE_OFFS,
+					 &power_ctrl_byte, 1);
+			if (ret != 1)
+				return -EIO;
+		}
+
+		/* SFF 8679 rev 1.7 LPMode Deassert time */
+		msleep(300);
+	}
+	return 0;
+}
+
+static void apply_rx_cdr(struct hfi2_pportdata *ppd,
+			 u32 rx_preset_index,
+			 u8 *cdr_ctrl_byte)
+{
+	u32 rx_preset;
+	u8 *cache = ppd->qsfp_info.cache;
+	int cable_power_class;
+
+	if (!((cache[QSFP_MOD_PWR_OFFS] & 0x4) &&
+	      (cache[QSFP_CDR_INFO_OFFS] & 0x40)))
+		return;
+
+	/* RX CDR present, bypass supported */
+	cable_power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
+
+	if (cable_power_class <= QSFP_POWER_CLASS_3) {
+		/* Power class <= 3, ignore config & turn RX CDR on */
+		*cdr_ctrl_byte |= 0xF;
+		return;
+	}
+
+	get_platform_config_field(
+		ppd, PLATFORM_CONFIG_RX_PRESET_TABLE,
+		rx_preset_index, RX_PRESET_TABLE_QSFP_RX_CDR_APPLY,
+		&rx_preset, 4);
+
+	if (!rx_preset) {
+		dd_dev_info(
+			ppd->dd,
+			"%s: RX_CDR_APPLY is set to disabled\n",
+			__func__);
+		return;
+	}
+	get_platform_config_field(
+		ppd, PLATFORM_CONFIG_RX_PRESET_TABLE,
+		rx_preset_index, RX_PRESET_TABLE_QSFP_RX_CDR,
+		&rx_preset, 4);
+
+	/* Expand cdr setting to all 4 lanes */
+	rx_preset = (rx_preset | (rx_preset << 1) |
+			(rx_preset << 2) | (rx_preset << 3));
+
+	if (rx_preset) {
+		*cdr_ctrl_byte |= rx_preset;
+	} else {
+		*cdr_ctrl_byte &= rx_preset;
+		/* Preserve current TX CDR status */
+		*cdr_ctrl_byte |= (cache[QSFP_CDR_CTRL_BYTE_OFFS] & 0xF0);
+	}
+}
+
+static void apply_tx_cdr(struct hfi2_pportdata *ppd,
+			 u32 tx_preset_index,
+			 u8 *cdr_ctrl_byte)
+{
+	u32 tx_preset;
+	u8 *cache = ppd->qsfp_info.cache;
+	int cable_power_class;
+
+	if (!((cache[QSFP_MOD_PWR_OFFS] & 0x8) &&
+	      (cache[QSFP_CDR_INFO_OFFS] & 0x80)))
+		return;
+
+	/* TX CDR present, bypass supported */
+	cable_power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
+
+	if (cable_power_class <= QSFP_POWER_CLASS_3) {
+		/* Power class <= 3, ignore config & turn TX CDR on */
+		*cdr_ctrl_byte |= 0xF0;
+		return;
+	}
+
+	get_platform_config_field(
+		ppd,
+		PLATFORM_CONFIG_TX_PRESET_TABLE, tx_preset_index,
+		TX_PRESET_TABLE_QSFP_TX_CDR_APPLY, &tx_preset, 4);
+
+	if (!tx_preset) {
+		dd_dev_info(
+			ppd->dd,
+			"%s: TX_CDR_APPLY is set to disabled\n",
+			__func__);
+		return;
+	}
+	get_platform_config_field(
+		ppd,
+		PLATFORM_CONFIG_TX_PRESET_TABLE,
+		tx_preset_index,
+		TX_PRESET_TABLE_QSFP_TX_CDR, &tx_preset, 4);
+
+	/* Expand cdr setting to all 4 lanes */
+	tx_preset = (tx_preset | (tx_preset << 1) |
+			(tx_preset << 2) | (tx_preset << 3));
+
+	if (tx_preset)
+		*cdr_ctrl_byte |= (tx_preset << 4);
+	else
+		/* Preserve current/determined RX CDR status */
+		*cdr_ctrl_byte &= ((tx_preset << 4) | 0xF);
+}
+
+static void apply_cdr_settings(
+		struct hfi2_pportdata *ppd, u32 rx_preset_index,
+		u32 tx_preset_index)
+{
+	u8 *cache = ppd->qsfp_info.cache;
+	u8 cdr_ctrl_byte = cache[QSFP_CDR_CTRL_BYTE_OFFS];
+
+	apply_rx_cdr(ppd, rx_preset_index, &cdr_ctrl_byte);
+
+	apply_tx_cdr(ppd, tx_preset_index, &cdr_ctrl_byte);
+
+	qsfp_write(ppd, ppd->dd->hfi2_id, QSFP_CDR_CTRL_BYTE_OFFS,
+		   &cdr_ctrl_byte, 1);
+}
+
+static void apply_tx_eq_auto(struct hfi2_pportdata *ppd)
+{
+	u8 *cache = ppd->qsfp_info.cache;
+	u8 tx_eq;
+
+	if (!(cache[QSFP_EQ_INFO_OFFS] & 0x8))
+		return;
+	/* Disable adaptive TX EQ if present */
+	tx_eq = cache[(128 * 3) + 241];
+	tx_eq &= 0xF0;
+	qsfp_write(ppd, ppd->dd->hfi2_id, (256 * 3) + 241, &tx_eq, 1);
+}
+
+static void apply_tx_eq_prog(struct hfi2_pportdata *ppd, u32 tx_preset_index)
+{
+	u8 *cache = ppd->qsfp_info.cache;
+	u32 tx_preset;
+	u8 tx_eq;
+
+	if (!(cache[QSFP_EQ_INFO_OFFS] & 0x4))
+		return;
+
+	get_platform_config_field(
+		ppd, PLATFORM_CONFIG_TX_PRESET_TABLE,
+		tx_preset_index, TX_PRESET_TABLE_QSFP_TX_EQ_APPLY,
+		&tx_preset, 4);
+	if (!tx_preset) {
+		dd_dev_info(
+			ppd->dd,
+			"%s: TX_EQ_APPLY is set to disabled\n",
+			__func__);
+		return;
+	}
+	get_platform_config_field(
+			ppd, PLATFORM_CONFIG_TX_PRESET_TABLE,
+			tx_preset_index, TX_PRESET_TABLE_QSFP_TX_EQ,
+			&tx_preset, 4);
+
+	if (((cache[(128 * 3) + 224] & 0xF0) >> 4) < tx_preset) {
+		dd_dev_info(
+			ppd->dd,
+			"%s: TX EQ %x unsupported\n",
+			__func__, tx_preset);
+
+		dd_dev_info(
+			ppd->dd,
+			"%s: Applying EQ %x\n",
+			__func__, cache[608] & 0xF0);
+
+		tx_preset = (cache[608] & 0xF0) >> 4;
+	}
+
+	tx_eq = tx_preset | (tx_preset << 4);
+	qsfp_write(ppd, ppd->dd->hfi2_id, (256 * 3) + 234, &tx_eq, 1);
+	qsfp_write(ppd, ppd->dd->hfi2_id, (256 * 3) + 235, &tx_eq, 1);
+}
+
+static void apply_rx_eq_emp(struct hfi2_pportdata *ppd, u32 rx_preset_index)
+{
+	u32 rx_preset;
+	u8 rx_eq, *cache = ppd->qsfp_info.cache;
+
+	if (!(cache[QSFP_EQ_INFO_OFFS] & 0x2))
+		return;
+	get_platform_config_field(
+			ppd, PLATFORM_CONFIG_RX_PRESET_TABLE,
+			rx_preset_index, RX_PRESET_TABLE_QSFP_RX_EMP_APPLY,
+			&rx_preset, 4);
+
+	if (!rx_preset) {
+		dd_dev_info(
+			ppd->dd,
+			"%s: RX_EMP_APPLY is set to disabled\n",
+			__func__);
+		return;
+	}
+	get_platform_config_field(
+		ppd, PLATFORM_CONFIG_RX_PRESET_TABLE,
+		rx_preset_index, RX_PRESET_TABLE_QSFP_RX_EMP,
+		&rx_preset, 4);
+
+	if ((cache[(128 * 3) + 224] & 0xF) < rx_preset) {
+		dd_dev_info(
+			ppd->dd,
+			"%s: Requested RX EMP %x\n",
+			__func__, rx_preset);
+
+		dd_dev_info(
+			ppd->dd,
+			"%s: Applying supported EMP %x\n",
+			__func__, cache[608] & 0xF);
+
+		rx_preset = cache[608] & 0xF;
+	}
+
+	rx_eq = rx_preset | (rx_preset << 4);
+
+	qsfp_write(ppd, ppd->dd->hfi2_id, (256 * 3) + 236, &rx_eq, 1);
+	qsfp_write(ppd, ppd->dd->hfi2_id, (256 * 3) + 237, &rx_eq, 1);
+}
+
+static void apply_eq_settings(struct hfi2_pportdata *ppd,
+			      u32 rx_preset_index, u32 tx_preset_index)
+{
+	u8 *cache = ppd->qsfp_info.cache;
+
+	/* no point going on w/o a page 3 */
+	if (cache[2] & 4) {
+		ppd_dev_info(ppd,
+			     "%s: Upper page 03 not present\n",
+			     __func__);
+		return;
+	}
+
+	apply_tx_eq_auto(ppd);
+
+	apply_tx_eq_prog(ppd, tx_preset_index);
+
+	apply_rx_eq_emp(ppd, rx_preset_index);
+}
+
+static void apply_rx_amplitude_settings(
+		struct hfi2_pportdata *ppd, u32 rx_preset_index,
+		u32 tx_preset_index)
+{
+	u32 rx_preset;
+	u8 rx_amp = 0, i = 0, preferred = 0, *cache = ppd->qsfp_info.cache;
+
+	/* no point going on w/o a page 3 */
+	if (cache[2] & 4) {
+		ppd_dev_info(ppd,
+			     "%s: Upper page 03 not present\n",
+			     __func__);
+		return;
+	}
+	if (!(cache[QSFP_EQ_INFO_OFFS] & 0x1)) {
+		ppd_dev_info(ppd,
+			     "%s: RX_AMP_APPLY is set to disabled\n",
+			     __func__);
+		return;
+	}
+
+	get_platform_config_field(ppd,
+				  PLATFORM_CONFIG_RX_PRESET_TABLE,
+				  rx_preset_index,
+				  RX_PRESET_TABLE_QSFP_RX_AMP_APPLY,
+				  &rx_preset, 4);
+
+	if (!rx_preset) {
+		ppd_dev_info(ppd,
+			     "%s: RX_AMP_APPLY is set to disabled\n",
+			     __func__);
+		return;
+	}
+	get_platform_config_field(ppd,
+				  PLATFORM_CONFIG_RX_PRESET_TABLE,
+				  rx_preset_index,
+				  RX_PRESET_TABLE_QSFP_RX_AMP,
+				  &rx_preset, 4);
+
+	ppd_dev_info(ppd,
+		     "%s: Requested RX AMP %x\n",
+		     __func__,
+		     rx_preset);
+
+	for (i = 0; i < 4; i++) {
+		if (cache[(128 * 3) + 225] & (1 << i)) {
+			preferred = i;
+			if (preferred == rx_preset)
+				break;
+		}
+	}
+
+	/*
+	 * Verify that preferred RX amplitude is not just a
+	 * fall through of the default
+	 */
+	if (!preferred && !(cache[(128 * 3) + 225] & 0x1)) {
+		ppd_dev_info(ppd, "No supported RX AMP, not applying\n");
+		return;
+	}
+
+	ppd_dev_info(ppd,
+		     "%s: Applying RX AMP %x\n", __func__, preferred);
+
+	rx_amp = preferred | (preferred << 4);
+	qsfp_write(ppd, ppd->dd->hfi2_id, (256 * 3) + 238, &rx_amp, 1);
+	qsfp_write(ppd, ppd->dd->hfi2_id, (256 * 3) + 239, &rx_amp, 1);
+}
+
+#define OPA_INVALID_INDEX 0xFFF
+
+static void apply_tx_lanes(struct hfi2_pportdata *ppd, u8 field_id,
+			   u32 config_data, const char *message)
+{
+	u8 i;
+	int ret;
+
+	for (i = 0; i < 4; i++) {
+		ret = load_8051_config(ppd->dd, field_id, i, config_data);
+		if (ret != HCMD_SUCCESS) {
+			dd_dev_err(
+				ppd->dd,
+				"%s: %s for lane %u failed\n",
+				message, __func__, i);
+		}
+	}
+}
+
+/*
+ * Return a special SerDes setting for low power AOC cables.  The power class
+ * threshold and setting being used were all found by empirical testing.
+ *
+ * Summary of the logic:
+ *
+ * if (QSFP and QSFP_TYPE == AOC and QSFP_POWER_CLASS < 4)
+ *     return 0xe
+ * return 0; // leave at default
+ */
+static u8 aoc_low_power_setting(struct hfi2_pportdata *ppd)
+{
+	u8 *cache = ppd->qsfp_info.cache;
+	int power_class;
+
+	/* QSFP only */
+	if (ppd->port_type != PORT_TYPE_QSFP)
+		return 0; /* leave at default */
+
+	/* active optical cables only */
+	switch ((cache[QSFP_MOD_TECH_OFFS] & 0xF0) >> 4) {
+	case 0x0 ... 0x9:
+		fallthrough;
+	case 0xC:
+		fallthrough;
+	case 0xE:
+		/* active AOC */
+		power_class = get_qsfp_power_class(cache[QSFP_MOD_PWR_OFFS]);
+		if (power_class < QSFP_POWER_CLASS_4)
+			return 0xe;
+	}
+	return 0; /* leave at default */
+}
+
+static void apply_tunings(
+		struct hfi2_pportdata *ppd, u32 tx_preset_index,
+		u8 tuning_method, u32 total_atten, u8 limiting_active)
+{
+	int ret = 0;
+	u32 config_data = 0, tx_preset = 0;
+	u8 precur = 0, attn = 0, postcur = 0, external_device_config = 0;
+	u8 *cache = ppd->qsfp_info.cache;
+
+	/* Pass tuning method to 8051 */
+	read_8051_config(ppd->dd, LINK_TUNING_PARAMETERS, GENERAL_CONFIG,
+			 &config_data);
+	config_data &= ~(0xff << TUNING_METHOD_SHIFT);
+	config_data |= ((u32)tuning_method << TUNING_METHOD_SHIFT);
+	ret = load_8051_config(ppd->dd, LINK_TUNING_PARAMETERS, GENERAL_CONFIG,
+			       config_data);
+	if (ret != HCMD_SUCCESS)
+		ppd_dev_err(ppd, "%s: Failed to set tuning method\n",
+			    __func__);
+
+	/* Set same channel loss for both TX and RX */
+	config_data = 0 | (total_atten << 16) | (total_atten << 24);
+	apply_tx_lanes(ppd, CHANNEL_LOSS_SETTINGS, config_data,
+		       "Setting channel loss");
+
+	/* Inform 8051 of cable capabilities */
+	if (ppd->qsfp_info.cache_valid) {
+		external_device_config =
+			((cache[QSFP_MOD_PWR_OFFS] & 0x4) << 3) |
+			((cache[QSFP_MOD_PWR_OFFS] & 0x8) << 2) |
+			((cache[QSFP_EQ_INFO_OFFS] & 0x2) << 1) |
+			(cache[QSFP_EQ_INFO_OFFS] & 0x4);
+		ret = read_8051_config(ppd->dd, DC_HOST_COMM_SETTINGS,
+				       GENERAL_CONFIG, &config_data);
+		/* Clear, then set the external device config field */
+		config_data &= ~(u32)0xFF;
+		config_data |= external_device_config;
+		ret = load_8051_config(ppd->dd, DC_HOST_COMM_SETTINGS,
+				       GENERAL_CONFIG, config_data);
+		if (ret != HCMD_SUCCESS)
+			ppd_dev_err(ppd,
+				    "%s: Failed set ext device config params\n",
+				    __func__);
+	}
+
+	if (tx_preset_index == OPA_INVALID_INDEX) {
+		if (ppd->port_type == PORT_TYPE_QSFP && limiting_active)
+			ppd_dev_err(ppd, "%s: Invalid Tx preset index\n",
+				    __func__);
+		return;
+	}
+
+	/* Following for limiting active channels only */
+	get_platform_config_field(
+		ppd, PLATFORM_CONFIG_TX_PRESET_TABLE, tx_preset_index,
+		TX_PRESET_TABLE_PRECUR, &tx_preset, 4);
+	precur = tx_preset;
+
+	get_platform_config_field(
+		ppd, PLATFORM_CONFIG_TX_PRESET_TABLE,
+		tx_preset_index, TX_PRESET_TABLE_ATTN, &tx_preset, 4);
+	attn = tx_preset;
+
+	get_platform_config_field(
+		ppd, PLATFORM_CONFIG_TX_PRESET_TABLE,
+		tx_preset_index, TX_PRESET_TABLE_POSTCUR, &tx_preset, 4);
+	postcur = tx_preset;
+
+	/*
+	 * NOTES:
+	 * o The aoc_low_power_setting is applied to all lanes even
+	 *   though only lane 0's value is examined by the firmware.
+	 * o A lingering low power setting after a cable swap does
+	 *   not occur.  On cable unplug the 8051 is reset and
+	 *   restarted on cable insert.  This resets all settings to
+	 *   their default, erasing any previous low power setting.
+	 */
+	config_data = precur | (attn << 8) | (postcur << 16) |
+			(aoc_low_power_setting(ppd) << 24);
+
+	apply_tx_lanes(ppd, TX_EQ_SETTINGS, config_data,
+		       "Applying TX settings");
+}
+
+/* Must be holding the QSFP i2c resource */
+static int tune_active_qsfp(struct hfi2_pportdata *ppd, u32 *ptr_tx_preset,
+			    u32 *ptr_rx_preset, u32 *ptr_total_atten)
+{
+	int ret;
+	u16 lss = ppd->link_speed_supported, lse = ppd->link_speed_enabled;
+	u8 *cache = ppd->qsfp_info.cache;
+
+	ppd->qsfp_info.limiting_active = 1;
+
+	ret = set_qsfp_tx(ppd, 0);
+	if (ret)
+		return ret;
+
+	ret = qual_power(ppd);
+	if (ret)
+		return ret;
+
+	ret = qual_bitrate(ppd);
+	if (ret)
+		return ret;
+
+	/*
+	 * We'll change the QSFP memory contents from here on out, thus we set a
+	 * flag here to remind ourselves to reset the QSFP module. This prevents
+	 * reuse of stale settings established in our previous pass through.
+	 */
+	if (ppd->qsfp_info.reset_needed) {
+		ret = reset_qsfp(ppd);
+		if (ret)
+			return ret;
+		refresh_qsfp_cache(ppd, &ppd->qsfp_info);
+	} else {
+		ppd->qsfp_info.reset_needed = 1;
+	}
+
+	ret = set_qsfp_high_power(ppd);
+	if (ret)
+		return ret;
+
+	if (cache[QSFP_EQ_INFO_OFFS] & 0x4) {
+		ret = get_platform_config_field(
+			ppd,
+			PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_TX_PRESET_IDX_ACTIVE_EQ,
+			ptr_tx_preset, 4);
+		if (ret) {
+			*ptr_tx_preset = OPA_INVALID_INDEX;
+			return ret;
+		}
+	} else {
+		ret = get_platform_config_field(
+			ppd,
+			PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_TX_PRESET_IDX_ACTIVE_NO_EQ,
+			ptr_tx_preset, 4);
+		if (ret) {
+			*ptr_tx_preset = OPA_INVALID_INDEX;
+			return ret;
+		}
+	}
+
+	ret = get_platform_config_field(
+		ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+		PORT_TABLE_RX_PRESET_IDX, ptr_rx_preset, 4);
+	if (ret) {
+		*ptr_rx_preset = OPA_INVALID_INDEX;
+		return ret;
+	}
+
+	if ((lss & OPA_LINK_SPEED_25G) && (lse & OPA_LINK_SPEED_25G))
+		get_platform_config_field(
+			ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_LOCAL_ATTEN_25G, ptr_total_atten, 4);
+	else if ((lss & OPA_LINK_SPEED_12_5G) && (lse & OPA_LINK_SPEED_12_5G))
+		get_platform_config_field(
+			ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_LOCAL_ATTEN_12G, ptr_total_atten, 4);
+
+	apply_cdr_settings(ppd, *ptr_rx_preset, *ptr_tx_preset);
+
+	apply_eq_settings(ppd, *ptr_rx_preset, *ptr_tx_preset);
+
+	apply_rx_amplitude_settings(ppd, *ptr_rx_preset, *ptr_tx_preset);
+
+	ret = set_qsfp_tx(ppd, 1);
+
+	return ret;
+}
+
+static int tune_qsfp(struct hfi2_pportdata *ppd,
+		     u32 *ptr_tx_preset, u32 *ptr_rx_preset,
+		     u8 *ptr_tuning_method, u32 *ptr_total_atten)
+{
+	u32 cable_atten = 0, remote_atten = 0, platform_atten = 0;
+	u16 lss = ppd->link_speed_supported, lse = ppd->link_speed_enabled;
+	int ret = 0;
+	u8 *cache = ppd->qsfp_info.cache;
+
+	switch ((cache[QSFP_MOD_TECH_OFFS] & 0xF0) >> 4) {
+	case 0xA ... 0xB:
+		ret = get_platform_config_field(
+			ppd,
+			PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_LOCAL_ATTEN_25G,
+			&platform_atten, 4);
+		if (ret)
+			return ret;
+
+		if ((lss & OPA_LINK_SPEED_25G) && (lse & OPA_LINK_SPEED_25G))
+			cable_atten = cache[QSFP_CU_ATTEN_12G_OFFS];
+		else if ((lss & OPA_LINK_SPEED_12_5G) &&
+			 (lse & OPA_LINK_SPEED_12_5G))
+			cable_atten = cache[QSFP_CU_ATTEN_7G_OFFS];
+
+		/* Fallback to configured attenuation if cable memory is bad */
+		if (cable_atten == 0 || cable_atten > 36) {
+			ret = get_platform_config_field(
+				ppd,
+				PLATFORM_CONFIG_SYSTEM_TABLE, 0,
+				SYSTEM_TABLE_QSFP_ATTENUATION_DEFAULT_25G,
+				&cable_atten, 4);
+			if (ret)
+				return ret;
+		}
+
+		ret = get_platform_config_field(
+			ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_REMOTE_ATTEN_25G, &remote_atten, 4);
+		if (ret)
+			return ret;
+
+		*ptr_total_atten = platform_atten + cable_atten + remote_atten;
+
+		*ptr_tuning_method = OPA_PASSIVE_TUNING;
+		break;
+	case 0x0 ... 0x9:
+		fallthrough;
+	case 0xC:
+		fallthrough;
+	case 0xE:
+		ret = tune_active_qsfp(ppd, ptr_tx_preset, ptr_rx_preset,
+				       ptr_total_atten);
+		if (ret)
+			return ret;
+
+		*ptr_tuning_method = OPA_ACTIVE_TUNING;
+		break;
+	case 0xD:
+		fallthrough;
+	case 0xF:
+	default:
+		ppd_dev_warn(ppd, "%s: Unknown/unsupported cable\n",
+			     __func__);
+		break;
+	}
+	return ret;
+}
+
+/*
+ * This function communicates its success or failure via ppd->driver_link_ready
+ * Thus, it depends on its association with start_link(...) which checks
+ * driver_link_ready before proceeding with the link negotiation and
+ * initialization process.
+ */
+void tune_serdes(struct hfi2_pportdata *ppd)
+{
+	int ret = 0;
+	u32 total_atten = 0;
+	u32 remote_atten = 0, platform_atten = 0;
+	u32 rx_preset_index, tx_preset_index;
+	u8 tuning_method = 0, limiting_active = 0;
+	struct hfi2_devdata *dd = ppd->dd;
+
+	rx_preset_index = OPA_INVALID_INDEX;
+	tx_preset_index = OPA_INVALID_INDEX;
+
+	/* the link defaults to enabled */
+	ppd->link_enabled = 1;
+	/* the driver link ready state defaults to not ready */
+	ppd->driver_link_ready = 0;
+	ppd->offline_disabled_reason = HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE);
+
+	/* skip tuning when in loopback */
+	if (loopback != LOOPBACK_NONE) {
+		ppd->driver_link_ready = 1;
+
+		if (qsfp_mod_present(ppd)) {
+			ret = acquire_chip_resource(ppd->dd,
+						    qsfp_resource(ppd->dd),
+						    QSFP_WAIT);
+			if (ret) {
+				ppd_dev_err(ppd, "%s: hfi%d: cannot lock i2c chain\n",
+					    __func__, (int)ppd->dd->hfi2_id);
+				goto bail;
+			}
+
+			refresh_qsfp_cache(ppd, &ppd->qsfp_info);
+			release_chip_resource(ppd->dd, qsfp_resource(ppd->dd));
+		}
+
+		return;
+	}
+
+	switch (ppd->port_type) {
+	case PORT_TYPE_DISCONNECTED:
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_DISCONNECTED);
+		dd_dev_warn(dd, "%s: Port disconnected, disabling port\n",
+			    __func__);
+		goto bail;
+	case PORT_TYPE_FIXED:
+		/* platform_atten, remote_atten pre-zeroed to catch error */
+		get_platform_config_field(
+			ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_LOCAL_ATTEN_25G, &platform_atten, 4);
+
+		get_platform_config_field(
+			ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+			PORT_TABLE_REMOTE_ATTEN_25G, &remote_atten, 4);
+
+		total_atten = platform_atten + remote_atten;
+
+		tuning_method = OPA_PASSIVE_TUNING;
+		break;
+	case PORT_TYPE_VARIABLE:
+		if (qsfp_mod_present(ppd)) {
+			/*
+			 * platform_atten, remote_atten pre-zeroed to
+			 * catch error
+			 */
+			get_platform_config_field(
+				ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+				PORT_TABLE_LOCAL_ATTEN_25G,
+				&platform_atten, 4);
+
+			get_platform_config_field(
+				ppd, PLATFORM_CONFIG_PORT_TABLE, 0,
+				PORT_TABLE_REMOTE_ATTEN_25G,
+				&remote_atten, 4);
+
+			total_atten = platform_atten + remote_atten;
+
+			tuning_method = OPA_PASSIVE_TUNING;
+		} else {
+			ppd->offline_disabled_reason =
+			     HFI2_ODR_MASK(OPA_LINKDOWN_REASON_CHASSIS_CONFIG);
+			goto bail;
+		}
+		break;
+	case PORT_TYPE_QSFP:
+		if (qsfp_mod_present(ppd)) {
+			ret = acquire_chip_resource(ppd->dd,
+						    qsfp_resource(ppd->dd),
+						    QSFP_WAIT);
+			if (ret) {
+				ppd_dev_err(ppd, "%s: hfi%d: cannot lock i2c chain\n",
+					    __func__, (int)ppd->dd->hfi2_id);
+				goto bail;
+			}
+			refresh_qsfp_cache(ppd, &ppd->qsfp_info);
+
+			if (ppd->qsfp_info.cache_valid) {
+				ret = tune_qsfp(ppd,
+						&tx_preset_index,
+						&rx_preset_index,
+						&tuning_method,
+						&total_atten);
+
+				/*
+				 * We may have modified the QSFP memory, so
+				 * update the cache to reflect the changes
+				 */
+				refresh_qsfp_cache(ppd, &ppd->qsfp_info);
+				limiting_active =
+						ppd->qsfp_info.limiting_active;
+			} else {
+				dd_dev_err(dd,
+					   "%s: Reading QSFP memory failed\n",
+					   __func__);
+				ret = -EINVAL; /* a fail indication */
+			}
+			release_chip_resource(ppd->dd, qsfp_resource(ppd->dd));
+			if (ret)
+				goto bail;
+		} else {
+			ppd->offline_disabled_reason =
+			   HFI2_ODR_MASK(
+				OPA_LINKDOWN_REASON_LOCAL_MEDIA_NOT_INSTALLED);
+			goto bail;
+		}
+		break;
+	default:
+		ppd_dev_warn(ppd, "%s: Unknown port type\n", __func__);
+		ppd->port_type = PORT_TYPE_UNKNOWN;
+		tuning_method = OPA_UNKNOWN_TUNING;
+		total_atten = 0;
+		limiting_active = 0;
+		tx_preset_index = OPA_INVALID_INDEX;
+		break;
+	}
+
+	if (ppd->offline_disabled_reason ==
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE))
+		apply_tunings(ppd, tx_preset_index, tuning_method,
+			      total_atten, limiting_active);
+
+	if (!ret)
+		ppd->driver_link_ready = 1;
+
+	return;
+bail:
+	ppd->driver_link_ready = 0;
+}
diff --git a/drivers/infiniband/hw/hfi2/qsfp.c b/drivers/infiniband/hw/hfi2/qsfp.c
new file mode 100644
index 000000000000..afe91f68073f
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/qsfp.c
@@ -0,0 +1,788 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+
+#include "hfi2.h"
+
+/* for the given bus number, return the CSR for reading an i2c line */
+static inline u32 i2c_in_csr(u32 bus_num)
+{
+	return bus_num ? ASIC_QSFP2_IN : ASIC_QSFP1_IN;
+}
+
+/* for the given bus number, return the CSR for writing an i2c line */
+static inline u32 i2c_oe_csr(u32 bus_num)
+{
+	return bus_num ? ASIC_QSFP2_OE : ASIC_QSFP1_OE;
+}
+
+static void hfi2_setsda(void *data, int state)
+{
+	struct hfi2_i2c_bus *bus = (struct hfi2_i2c_bus *)data;
+	struct hfi2_devdata *dd = bus->controlling_dd;
+	u64 reg;
+	u32 target_oe;
+
+	target_oe = i2c_oe_csr(bus->num);
+	reg = read_csr(dd, target_oe);
+	/*
+	 * The OE bit value is inverted and connected to the pin.  When
+	 * OE is 0 the pin is left to be pulled up, when the OE is 1
+	 * the pin is driven low.  This matches the "open drain" or "open
+	 * collector" convention.
+	 */
+	if (state)
+		reg &= ~QSFP_HFI0_I2CDAT;
+	else
+		reg |= QSFP_HFI0_I2CDAT;
+	write_csr(dd, target_oe, reg);
+	/* do a read to force the write into the chip */
+	(void)read_csr(dd, target_oe);
+}
+
+static void hfi2_setscl(void *data, int state)
+{
+	struct hfi2_i2c_bus *bus = (struct hfi2_i2c_bus *)data;
+	struct hfi2_devdata *dd = bus->controlling_dd;
+	u64 reg;
+	u32 target_oe;
+
+	target_oe = i2c_oe_csr(bus->num);
+	reg = read_csr(dd, target_oe);
+	/*
+	 * The OE bit value is inverted and connected to the pin.  When
+	 * OE is 0 the pin is left to be pulled up, when the OE is 1
+	 * the pin is driven low.  This matches the "open drain" or "open
+	 * collector" convention.
+	 */
+	if (state)
+		reg &= ~QSFP_HFI0_I2CCLK;
+	else
+		reg |= QSFP_HFI0_I2CCLK;
+	write_csr(dd, target_oe, reg);
+	/* do a read to force the write into the chip */
+	(void)read_csr(dd, target_oe);
+}
+
+static int hfi2_getsda(void *data)
+{
+	struct hfi2_i2c_bus *bus = (struct hfi2_i2c_bus *)data;
+	u64 reg;
+	u32 target_in;
+
+	hfi2_setsda(data, 1);	/* clear OE so we do not pull line down */
+	udelay(2);		/* 1us pull up + 250ns hold */
+
+	target_in = i2c_in_csr(bus->num);
+	reg = read_csr(bus->controlling_dd, target_in);
+	return !!(reg & QSFP_HFI0_I2CDAT);
+}
+
+static int hfi2_getscl(void *data)
+{
+	struct hfi2_i2c_bus *bus = (struct hfi2_i2c_bus *)data;
+	u64 reg;
+	u32 target_in;
+
+	hfi2_setscl(data, 1);	/* clear OE so we do not pull line down */
+	udelay(2);		/* 1us pull up + 250ns hold */
+
+	target_in = i2c_in_csr(bus->num);
+	reg = read_csr(bus->controlling_dd, target_in);
+	return !!(reg & QSFP_HFI0_I2CCLK);
+}
+
+/*
+ * Allocate and initialize the given i2c bus number.
+ * Returns NULL on failure.
+ */
+static struct hfi2_i2c_bus *init_i2c_bus(struct hfi2_devdata *dd,
+					 struct hfi2_asic_data *ad, int num)
+{
+	struct hfi2_i2c_bus *bus;
+	int ret;
+
+	bus = kzalloc_obj(bus, GFP_KERNEL);
+	if (!bus)
+		return NULL;
+
+	bus->controlling_dd = dd;
+	bus->num = num;	/* our bus number */
+
+	bus->algo.setsda = hfi2_setsda;
+	bus->algo.setscl = hfi2_setscl;
+	bus->algo.getsda = hfi2_getsda;
+	bus->algo.getscl = hfi2_getscl;
+	bus->algo.udelay = 5;
+	bus->algo.timeout = usecs_to_jiffies(100000);
+	bus->algo.data = bus;
+
+	bus->adapter.owner = THIS_MODULE;
+	bus->adapter.algo_data = &bus->algo;
+	bus->adapter.dev.parent = &dd->pcidev->dev;
+	snprintf(bus->adapter.name, sizeof(bus->adapter.name),
+		 "hfi2_i2c%d", num);
+
+	ret = i2c_bit_add_bus(&bus->adapter);
+	if (ret) {
+		dd_dev_info(dd, "%s: unable to add i2c bus %d, err %d\n",
+			    __func__, num, ret);
+		kfree(bus);
+		return NULL;
+	}
+
+	return bus;
+}
+
+/*
+ * Initialize i2c buses.
+ * Return 0 on success, -errno on error.
+ */
+int set_up_i2c(struct hfi2_devdata *dd, struct hfi2_asic_data *ad)
+{
+	ad->i2c_bus0 = init_i2c_bus(dd, ad, 0);
+	ad->i2c_bus1 = init_i2c_bus(dd, ad, 1);
+	if (!ad->i2c_bus0 || !ad->i2c_bus1)
+		return -ENOMEM;
+	return 0;
+};
+
+static void clean_i2c_bus(struct hfi2_i2c_bus *bus)
+{
+	if (bus) {
+		i2c_del_adapter(&bus->adapter);
+		kfree(bus);
+	}
+}
+
+void clean_up_i2c(struct hfi2_devdata *dd, struct hfi2_asic_data *ad)
+{
+	if (!ad)
+		return;
+	clean_i2c_bus(ad->i2c_bus0);
+	ad->i2c_bus0 = NULL;
+	clean_i2c_bus(ad->i2c_bus1);
+	ad->i2c_bus1 = NULL;
+}
+
+static int i2c_bus_write(struct hfi2_devdata *dd, struct hfi2_i2c_bus *i2c,
+			 u8 slave_addr, int offset, int offset_size,
+			 u8 *data, u16 len)
+{
+	int ret;
+	int num_msgs;
+	u8 offset_bytes[2];
+	struct i2c_msg msgs[2];
+
+	switch (offset_size) {
+	case 0:
+		num_msgs = 1;
+		msgs[0].addr = slave_addr;
+		msgs[0].flags = 0;
+		msgs[0].len = len;
+		msgs[0].buf = data;
+		break;
+	case 2:
+		offset_bytes[1] = (offset >> 8) & 0xff;
+		fallthrough;
+	case 1:
+		num_msgs = 2;
+		offset_bytes[0] = offset & 0xff;
+
+		msgs[0].addr = slave_addr;
+		msgs[0].flags = 0;
+		msgs[0].len = offset_size;
+		msgs[0].buf = offset_bytes;
+
+		msgs[1].addr = slave_addr;
+		msgs[1].flags = I2C_M_NOSTART;
+		msgs[1].len = len;
+		msgs[1].buf = data;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	i2c->controlling_dd = dd;
+	ret = i2c_transfer(&i2c->adapter, msgs, num_msgs);
+	if (ret != num_msgs) {
+		dd_dev_err(dd, "%s: bus %d, i2c slave 0x%x, offset 0x%x, len 0x%x; write failed, ret %d\n",
+			   __func__, i2c->num, slave_addr, offset, len, ret);
+		return ret < 0 ? ret : -EIO;
+	}
+	return 0;
+}
+
+static int i2c_bus_read(struct hfi2_devdata *dd, struct hfi2_i2c_bus *bus,
+			u8 slave_addr, int offset, int offset_size,
+			u8 *data, u16 len)
+{
+	int ret;
+	int num_msgs;
+	u8 offset_bytes[2];
+	struct i2c_msg msgs[2];
+
+	switch (offset_size) {
+	case 0:
+		num_msgs = 1;
+		msgs[0].addr = slave_addr;
+		msgs[0].flags = I2C_M_RD;
+		msgs[0].len = len;
+		msgs[0].buf = data;
+		break;
+	case 2:
+		offset_bytes[1] = (offset >> 8) & 0xff;
+		fallthrough;
+	case 1:
+		num_msgs = 2;
+		offset_bytes[0] = offset & 0xff;
+
+		msgs[0].addr = slave_addr;
+		msgs[0].flags = 0;
+		msgs[0].len = offset_size;
+		msgs[0].buf = offset_bytes;
+
+		msgs[1].addr = slave_addr;
+		msgs[1].flags = I2C_M_RD;
+		msgs[1].len = len;
+		msgs[1].buf = data;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	bus->controlling_dd = dd;
+	ret = i2c_transfer(&bus->adapter, msgs, num_msgs);
+	if (ret != num_msgs) {
+		dd_dev_err(dd, "%s: bus %d, i2c slave 0x%x, offset 0x%x, len 0x%x; read failed, ret %d\n",
+			   __func__, bus->num, slave_addr, offset, len, ret);
+		return ret < 0 ? ret : -EIO;
+	}
+	return 0;
+}
+
+/*
+ * Raw i2c write.  No set-up or lock checking.
+ *
+ * Return 0 on success, -errno on error.
+ */
+static int __i2c_write(struct hfi2_pportdata *ppd, u32 target, int i2c_addr,
+		       int offset, void *bp, int len)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_i2c_bus *bus;
+	u8 slave_addr;
+	int offset_size;
+
+	bus = target ? dd->asic_data->i2c_bus1 : dd->asic_data->i2c_bus0;
+	slave_addr = (i2c_addr & 0xff) >> 1; /* convert to 7-bit addr */
+	offset_size = (i2c_addr >> 8) & 0x3;
+	return i2c_bus_write(dd, bus, slave_addr, offset, offset_size, bp, len);
+}
+
+/*
+ * Caller must hold the i2c chain resource.
+ *
+ * Return number of bytes written, or -errno.
+ */
+int i2c_write(struct hfi2_pportdata *ppd, u32 target, int i2c_addr, int offset,
+	      void *bp, int len)
+{
+	int ret;
+
+	if (!check_chip_resource(ppd->dd, i2c_target(target), __func__))
+		return -EACCES;
+
+	ret = __i2c_write(ppd, target, i2c_addr, offset, bp, len);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/*
+ * Raw i2c read.  No set-up or lock checking.
+ *
+ * Return 0 on success, -errno on error.
+ */
+static int __i2c_read(struct hfi2_pportdata *ppd, u32 target, int i2c_addr,
+		      int offset, void *bp, int len)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_i2c_bus *bus;
+	u8 slave_addr;
+	int offset_size;
+
+	bus = target ? dd->asic_data->i2c_bus1 : dd->asic_data->i2c_bus0;
+	slave_addr = (i2c_addr & 0xff) >> 1; /* convert to 7-bit addr */
+	offset_size = (i2c_addr >> 8) & 0x3;
+	return i2c_bus_read(dd, bus, slave_addr, offset, offset_size, bp, len);
+}
+
+/*
+ * Caller must hold the i2c chain resource.
+ *
+ * Return number of bytes read, or -errno.
+ */
+int i2c_read(struct hfi2_pportdata *ppd, u32 target, int i2c_addr, int offset,
+	     void *bp, int len)
+{
+	int ret;
+
+	if (!check_chip_resource(ppd->dd, i2c_target(target), __func__))
+		return -EACCES;
+
+	ret = __i2c_read(ppd, target, i2c_addr, offset, bp, len);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+/*
+ * Write page n, offset m of QSFP memory as defined by SFF 8636
+ * by writing @addr = ((256 * n) + m)
+ *
+ * Caller must hold the i2c chain resource.
+ *
+ * Return number of bytes written or -errno.
+ */
+int qsfp_write(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+	       int len)
+{
+	int count = 0;
+	int offset;
+	int nwrite;
+	int ret = 0;
+	u8 page;
+
+	if (!check_chip_resource(ppd->dd, i2c_target(target), __func__))
+		return -EACCES;
+
+	while (count < len) {
+		/*
+		 * Set the qsfp page based on a zero-based address
+		 * and a page size of QSFP_PAGESIZE bytes.
+		 */
+		page = (u8)(addr / QSFP_PAGESIZE);
+
+		ret = __i2c_write(ppd, target, QSFP_DEV | QSFP_OFFSET_SIZE,
+				  QSFP_PAGE_SELECT_BYTE_OFFS, &page, 1);
+		/* QSFPs require a 5-10msec delay after write operations */
+		mdelay(5);
+		if (ret) {
+			hfi2_dev_porterr(ppd->dd, ppd->port,
+					 "QSFP chain %d can't write QSFP_PAGE_SELECT_BYTE: %d\n",
+					 target, ret);
+			break;
+		}
+
+		offset = addr % QSFP_PAGESIZE;
+		nwrite = len - count;
+		/* truncate write to boundary if crossing boundary */
+		if (((addr % QSFP_RW_BOUNDARY) + nwrite) > QSFP_RW_BOUNDARY)
+			nwrite = QSFP_RW_BOUNDARY - (addr % QSFP_RW_BOUNDARY);
+
+		ret = __i2c_write(ppd, target, QSFP_DEV | QSFP_OFFSET_SIZE,
+				  offset, bp + count, nwrite);
+		/* QSFPs require a 5-10msec delay after write operations */
+		mdelay(5);
+		if (ret)	/* stop on error */
+			break;
+
+		count += nwrite;
+		addr += nwrite;
+	}
+
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+/*
+ * Access page n, offset m of QSFP memory as defined by SFF 8636
+ * by reading @addr = ((256 * n) + m)
+ *
+ * Caller must hold the i2c chain resource.
+ *
+ * Return the number of bytes read or -errno.
+ */
+int qsfp_read(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+	      int len)
+{
+	int count = 0;
+	int offset;
+	int nread;
+	int ret = 0;
+	u8 page;
+
+	if (!check_chip_resource(ppd->dd, i2c_target(target), __func__))
+		return -EACCES;
+
+	while (count < len) {
+		/*
+		 * Set the qsfp page based on a zero-based address
+		 * and a page size of QSFP_PAGESIZE bytes.
+		 */
+		page = (u8)(addr / QSFP_PAGESIZE);
+		ret = __i2c_write(ppd, target, QSFP_DEV | QSFP_OFFSET_SIZE,
+				  QSFP_PAGE_SELECT_BYTE_OFFS, &page, 1);
+		/* QSFPs require a 5-10msec delay after write operations */
+		mdelay(5);
+		if (ret) {
+			hfi2_dev_porterr(ppd->dd, ppd->port,
+					 "QSFP chain %d can't write QSFP_PAGE_SELECT_BYTE: %d\n",
+					 target, ret);
+			break;
+		}
+
+		offset = addr % QSFP_PAGESIZE;
+		nread = len - count;
+		/* truncate read to boundary if crossing boundary */
+		if (((addr % QSFP_RW_BOUNDARY) + nread) > QSFP_RW_BOUNDARY)
+			nread = QSFP_RW_BOUNDARY - (addr % QSFP_RW_BOUNDARY);
+
+		ret = __i2c_read(ppd, target, QSFP_DEV | QSFP_OFFSET_SIZE,
+				 offset, bp + count, nread);
+		if (ret)	/* stop on error */
+			break;
+
+		count += nread;
+		addr += nread;
+	}
+
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+/*
+ * Perform a stand-alone single QSFP read.  Acquire the resource, do the
+ * read, then release the resource.
+ */
+int one_qsfp_read(struct hfi2_pportdata *ppd, u32 target, int addr, void *bp,
+		  int len)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 resource = qsfp_resource(dd);
+	int ret;
+
+	ret = acquire_chip_resource(dd, resource, QSFP_WAIT);
+	if (ret)
+		return ret;
+	ret = qsfp_read(ppd, target, addr, bp, len);
+	release_chip_resource(dd, resource);
+
+	return ret;
+}
+
+/*
+ * This function caches the QSFP memory range in 128 byte chunks.
+ * As an example, the next byte after address 255 is byte 128 from
+ * upper page 01H (if existing) rather than byte 0 from lower page 00H.
+ * Access page n, offset m of QSFP memory as defined by SFF 8636
+ * in the cache by reading byte ((128 * n) + m)
+ * The calls to qsfp_{read,write} in this function correctly handle the
+ * address map difference between this mapping and the mapping implemented
+ * by those functions
+ *
+ * The caller must be holding the QSFP i2c chain resource.
+ */
+int refresh_qsfp_cache(struct hfi2_pportdata *ppd, struct qsfp_data *cp)
+{
+	u32 target = ppd->dd->hfi2_id;
+	int ret;
+	unsigned long flags;
+	u8 *cache = &cp->cache[0];
+
+	/* ensure sane contents on invalid reads, for cable swaps */
+	memset(cache, 0, (QSFP_MAX_NUM_PAGES * 128));
+	spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+	ppd->qsfp_info.cache_valid = 0;
+	spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock, flags);
+
+	if (!qsfp_mod_present(ppd)) {
+		ret = -ENODEV;
+		goto bail;
+	}
+
+	ret = qsfp_read(ppd, target, 0, cache, QSFP_PAGESIZE);
+	if (ret != QSFP_PAGESIZE) {
+		ppd_dev_info(ppd,
+			     "%s: Page 0 read failed, expected %d, got %d\n",
+			     __func__, QSFP_PAGESIZE, ret);
+		goto bail;
+	}
+
+	/* Is paging enabled? */
+	if (!(cache[2] & 4)) {
+		/* Paging enabled, page 03 required */
+		if ((cache[195] & 0xC0) == 0xC0) {
+			/* all */
+			ret = qsfp_read(ppd, target, 384, cache + 256, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+			ret = qsfp_read(ppd, target, 640, cache + 384, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+			ret = qsfp_read(ppd, target, 896, cache + 512, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+		} else if ((cache[195] & 0x80) == 0x80) {
+			/* only page 2 and 3 */
+			ret = qsfp_read(ppd, target, 640, cache + 384, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+			ret = qsfp_read(ppd, target, 896, cache + 512, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+		} else if ((cache[195] & 0x40) == 0x40) {
+			/* only page 1 and 3 */
+			ret = qsfp_read(ppd, target, 384, cache + 256, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+			ret = qsfp_read(ppd, target, 896, cache + 512, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+		} else {
+			/* only page 3 */
+			ret = qsfp_read(ppd, target, 896, cache + 512, 128);
+			if (ret <= 0 || ret != 128) {
+				ppd_dev_info(ppd, "%s failed\n", __func__);
+				goto bail;
+			}
+		}
+	}
+
+	spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+	ppd->qsfp_info.cache_valid = 1;
+	ppd->qsfp_info.cache_refresh_required = 0;
+	spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock, flags);
+
+	return 0;
+
+bail:
+	memset(cache, 0, (QSFP_MAX_NUM_PAGES * 128));
+	return ret;
+}
+
+const char * const hfi2_qsfp_devtech[16] = {
+	"850nm VCSEL", "1310nm VCSEL", "1550nm VCSEL", "1310nm FP",
+	"1310nm DFB", "1550nm DFB", "1310nm EML", "1550nm EML",
+	"Cu Misc", "1490nm DFB", "Cu NoEq", "Cu Eq",
+	"Undef", "Cu Active BothEq", "Cu FarEq", "Cu NearEq"
+};
+
+#define QSFP_DUMP_CHUNK 16 /* Holds longest string */
+#define QSFP_DEFAULT_HDR_CNT 224
+
+#define QSFP_PWR(pbyte) (((pbyte) >> 6) & 3)
+#define QSFP_HIGH_PWR(pbyte) ((pbyte) & 3)
+/* For use with QSFP_HIGH_PWR macro */
+#define QSFP_HIGH_PWR_UNUSED	0 /* Bits [1:0] = 00 implies low power module */
+
+/*
+ * Takes power class byte [Page 00 Byte 129] in SFF 8636
+ * Returns power class as integer (1 through 7, per SFF 8636 rev 2.4)
+ */
+int get_qsfp_power_class(u8 power_byte)
+{
+	if (QSFP_HIGH_PWR(power_byte) == QSFP_HIGH_PWR_UNUSED)
+		/* power classes count from 1, their bit encodings from 0 */
+		return (QSFP_PWR(power_byte) + 1);
+	/*
+	 * 00 in the high power classes stands for unused, bringing
+	 * balance to the off-by-1 offset above, we add 4 here to
+	 * account for the difference between the low and high power
+	 * groups
+	 */
+	return (QSFP_HIGH_PWR(power_byte) + 4);
+}
+
+int qsfp_mod_present(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = read_csr(dd, dd->hfi2_id ? ASIC_QSFP2_IN : ASIC_QSFP1_IN);
+	return !(reg & QSFP_HFI0_MODPRST_N);
+}
+
+/*
+ * This function maps QSFP memory addresses in 128 byte chunks in the following
+ * fashion per the CableInfo SMA query definition in the IBA 1.3 spec/OPA Gen 1
+ * spec
+ * For addr 000-127, lower page 00h
+ * For addr 128-255, upper page 00h
+ * For addr 256-383, upper page 01h
+ * For addr 384-511, upper page 02h
+ * For addr 512-639, upper page 03h
+ *
+ * For addresses beyond this range, it returns the invalid range of data buffer
+ * set to 0.
+ * For upper pages that are optional, if they are not valid, returns the
+ * particular range of bytes in the data buffer set to 0.
+ */
+int get_cable_info(struct hfi2_pportdata *ppd, u32 addr, u32 len, u8 *data)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 excess_len = len;
+	int ret = 0, offset = 0;
+
+	if (!qsfp_mod_present(ppd)) {
+		ret = -ENODEV;
+		goto set_zeroes;
+	}
+
+	if (!ppd->qsfp_info.cache_valid) {
+		ret = -EINVAL;
+		goto set_zeroes;
+	}
+
+	if (addr >= (QSFP_MAX_NUM_PAGES * 128)) {
+		ret = -ERANGE;
+		goto set_zeroes;
+	}
+
+	if ((addr + len) > (QSFP_MAX_NUM_PAGES * 128)) {
+		excess_len = (addr + len) - (QSFP_MAX_NUM_PAGES * 128);
+		memcpy(data, &ppd->qsfp_info.cache[addr], (len - excess_len));
+		data += (len - excess_len);
+		goto set_zeroes;
+	}
+
+	memcpy(data, &ppd->qsfp_info.cache[addr], len);
+
+	if (addr <= QSFP_MONITOR_VAL_END &&
+	    (addr + len) >= QSFP_MONITOR_VAL_START) {
+		/* Overlap with the dynamic channel monitor range */
+		if (addr < QSFP_MONITOR_VAL_START) {
+			if (addr + len <= QSFP_MONITOR_VAL_END)
+				len = addr + len - QSFP_MONITOR_VAL_START;
+			else
+				len = QSFP_MONITOR_RANGE;
+			offset = QSFP_MONITOR_VAL_START - addr;
+			addr = QSFP_MONITOR_VAL_START;
+		} else if (addr == QSFP_MONITOR_VAL_START) {
+			offset = 0;
+			if (addr + len > QSFP_MONITOR_VAL_END)
+				len = QSFP_MONITOR_RANGE;
+		} else {
+			offset = 0;
+			if (addr + len > QSFP_MONITOR_VAL_END)
+				len = QSFP_MONITOR_VAL_END - addr + 1;
+		}
+		/* Refresh the values of the dynamic monitors from the cable */
+		ret = one_qsfp_read(ppd, dd->hfi2_id, addr, data + offset, len);
+		if (ret != len) {
+			ret = -EAGAIN;
+			goto set_zeroes;
+		}
+	}
+
+	return 0;
+
+set_zeroes:
+	memset(data, 0, excess_len);
+	return ret;
+}
+
+static const char *pwr_codes[8] = {"N/AW",
+				  "1.5W",
+				  "2.0W",
+				  "2.5W",
+				  "3.5W",
+				  "4.0W",
+				  "4.5W",
+				  "5.0W"
+				 };
+
+int qsfp_dump(struct hfi2_pportdata *ppd, char *buf, int len)
+{
+	u8 *cache = &ppd->qsfp_info.cache[0];
+	u8 bin_buff[QSFP_DUMP_CHUNK];
+	char lenstr[6];
+	int sofar;
+	int bidx = 0;
+	u8 *atten = &cache[QSFP_ATTEN_OFFS];
+	u8 *vendor_oui = &cache[QSFP_VOUI_OFFS];
+	u8 power_byte = 0;
+
+	sofar = 0;
+	lenstr[0] = ' ';
+	lenstr[1] = '\0';
+
+	if (ppd->qsfp_info.cache_valid) {
+		if (QSFP_IS_CU(cache[QSFP_MOD_TECH_OFFS]))
+			snprintf(lenstr, sizeof(lenstr), "%dM ",
+				 cache[QSFP_MOD_LEN_OFFS]);
+
+		power_byte = cache[QSFP_MOD_PWR_OFFS];
+		sofar += scnprintf(buf + sofar, len - sofar, "PWR:%.3sW\n",
+				pwr_codes[get_qsfp_power_class(power_byte)]);
+
+		sofar += scnprintf(buf + sofar, len - sofar, "TECH:%s%s\n",
+				lenstr,
+			hfi2_qsfp_devtech[(cache[QSFP_MOD_TECH_OFFS]) >> 4]);
+
+		sofar += scnprintf(buf + sofar, len - sofar, "Vendor:%.*s\n",
+				   QSFP_VEND_LEN, &cache[QSFP_VEND_OFFS]);
+
+		sofar += scnprintf(buf + sofar, len - sofar, "OUI:%06X\n",
+				   QSFP_OUI(vendor_oui));
+
+		sofar += scnprintf(buf + sofar, len - sofar, "Part#:%.*s\n",
+				   QSFP_PN_LEN, &cache[QSFP_PN_OFFS]);
+
+		sofar += scnprintf(buf + sofar, len - sofar, "Rev:%.*s\n",
+				   QSFP_REV_LEN, &cache[QSFP_REV_OFFS]);
+
+		if (QSFP_IS_CU(cache[QSFP_MOD_TECH_OFFS]))
+			sofar += scnprintf(buf + sofar, len - sofar,
+				"Atten:%d, %d\n",
+				QSFP_ATTEN_SDR(atten),
+				QSFP_ATTEN_DDR(atten));
+
+		sofar += scnprintf(buf + sofar, len - sofar, "Serial:%.*s\n",
+				   QSFP_SN_LEN, &cache[QSFP_SN_OFFS]);
+
+		sofar += scnprintf(buf + sofar, len - sofar, "Date:%.*s\n",
+				   QSFP_DATE_LEN, &cache[QSFP_DATE_OFFS]);
+
+		sofar += scnprintf(buf + sofar, len - sofar, "Lot:%.*s\n",
+				   QSFP_LOT_LEN, &cache[QSFP_LOT_OFFS]);
+
+		while (bidx < QSFP_DEFAULT_HDR_CNT) {
+			int iidx;
+
+			memcpy(bin_buff, &cache[bidx], QSFP_DUMP_CHUNK);
+			for (iidx = 0; iidx < QSFP_DUMP_CHUNK; ++iidx) {
+				sofar += scnprintf(buf + sofar, len - sofar,
+					" %02X", bin_buff[iidx]);
+			}
+			sofar += scnprintf(buf + sofar, len - sofar, "\n");
+			bidx += QSFP_DUMP_CHUNK;
+		}
+	}
+	return sofar;
+}
diff --git a/drivers/infiniband/hw/hfi2/sriov.c b/drivers/infiniband/hw/hfi2/sriov.c
index 3a937a81f07d..c608fc67587c 100644
--- a/drivers/infiniband/hw/hfi2/sriov.c
+++ b/drivers/infiniband/hw/hfi2/sriov.c
@@ -77,7 +77,6 @@ int sriov_get_config(struct hfi2_devdata *dd, struct hfi2_devrsrcs *out, int si)
 #ifdef HFI_SRIOV_MOD_PARAMS
 	num_vfs = max_num_vfs;
 #endif
-	/* TODO: other methods of SRIOV config... */
 
 	if (!num_vfs)
 		return -ENODEV;
@@ -185,7 +184,6 @@ int hfi2_sriov_set_si(struct hfi2_devdata *dd)
 		if (dd->is_vm)
 			si = vf2pf_probe_si(dd); /* hope for the best */
 		else
-			/* TODO: need to adjust for CYR? does pci_iov already do that? */
 			si = pci_iov_vf_id(dd->pcidev) + 1;
 	}
 	if (!si) {
@@ -291,10 +289,8 @@ void hfi2_sriov_free_cfg(struct hfi2_devdata *dd)
  *		since pdev->physfn cannot be valid - nor pdev->sriov?)
  *		(this needs to have a 'dd' but handled different)
  *
- * TODO: how to determine whether we're host or guest?!
  *	PCI_FUNC(pdev->devfn) != 0 && !pdev->is_virtfn for guest VFs?
  *
- * TODO: does PCI_FUNC() need to be something different if ARI is active?
  */
 
 int sriov_is_enabled(void)
@@ -302,7 +298,6 @@ int sriov_is_enabled(void)
 #ifdef HFI_SRIOV_MOD_PARAMS
 	return max_num_vfs > 0;
 #else
-	/* TODO: how to determine SRIOV is allowed */
 	return 0;
 #endif
 }
@@ -312,7 +307,6 @@ int sriov_is_enabled(void)
  *
  * Normally, the VF devices will be pass-through to VMs, in which
  * case the host driver does not want to claim the device.
- * TODO: Does KVM (virtsh) tolerate the driver claiming the VF,
  * by calling the remove_one() function when assigning the device
  * to the guest? If so, we can go ahead and claim the device here,
  * however that will cause a complete setup (and tear-down) of a 'dd' for it.
@@ -384,16 +378,11 @@ int hfi2_sriov_disable(struct pci_dev *pdev)
  */
 static int hfi2_sriov_deconfigure(struct hfi2_devdata *dd)
 {
-	/* TODO: do paranoid cleanup? */
 	pci_disable_sriov(dd->pcidev);
 	hfi2_pf0_cleanup(dd);
 	return 0;
 }
 
-/* TODO: any setup required for RPMSG, etc.
- *
- * pdev is PF0.
- */
 int hfi2_sriov_configure(struct pci_dev *pdev, int nvf)
 {
 	struct hfi2_devdata *dd = pci_get_drvdata(pdev);
diff --git a/drivers/infiniband/hw/hfi2/sysfs.c b/drivers/infiniband/hw/hfi2/sysfs.c
new file mode 100644
index 000000000000..eda8fffcf91e
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/sysfs.c
@@ -0,0 +1,878 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015-2017 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/ctype.h>
+#include <rdma/ib_sysfs.h>
+
+#include "hfi2.h"
+#include "mad.h"
+#include "trace.h"
+#include "chip_gen.h"
+#include "vf2pf.h"
+
+static struct hfi2_pportdata *hfi2_get_pportdata_kobj(struct kobject *kobj)
+{
+	u32 port_num;
+	struct ib_device *ibdev = ib_port_sysfs_get_ibdev_kobj(kobj, &port_num);
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+
+	return &dd->pport[port_num - 1];
+}
+
+/*
+ * Start of per-port congestion control structures and support code
+ */
+
+/*
+ * Congestion control table size followed by table entries
+ */
+static ssize_t cc_table_bin_read(struct file *filp, struct kobject *kobj,
+				 const struct bin_attribute *bin_attr,
+				 char *buf, loff_t pos, size_t count)
+{
+	int ret;
+	struct hfi2_pportdata *ppd = hfi2_get_pportdata_kobj(kobj);
+	struct cc_state *cc_state;
+
+	ret = ppd->total_cct_entry * sizeof(struct ib_cc_table_entry_shadow)
+		 + sizeof(__be16);
+
+	if (pos > ret)
+		return -EINVAL;
+
+	if (count > ret - pos)
+		count = ret - pos;
+
+	if (!count)
+		return count;
+
+	rcu_read_lock();
+	cc_state = get_cc_state(ppd);
+	if (!cc_state) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	memcpy(buf, (void *)&cc_state->cct + pos, count);
+	rcu_read_unlock();
+
+	return count;
+}
+static const BIN_ATTR_RO(cc_table_bin, PAGE_SIZE);
+
+/*
+ * Congestion settings: port control, control map and an array of 16
+ * entries for the congestion entries - increase, timer, event log
+ * trigger threshold and the minimum injection rate delay.
+ */
+static ssize_t cc_setting_bin_read(struct file *filp, struct kobject *kobj,
+				   const struct bin_attribute *bin_attr,
+				   char *buf, loff_t pos, size_t count)
+{
+	struct hfi2_pportdata *ppd = hfi2_get_pportdata_kobj(kobj);
+	int ret;
+	struct cc_state *cc_state;
+
+	ret = sizeof(struct opa_congestion_setting_attr_shadow);
+
+	if (pos > ret)
+		return -EINVAL;
+	if (count > ret - pos)
+		count = ret - pos;
+
+	if (!count)
+		return count;
+
+	rcu_read_lock();
+	cc_state = get_cc_state(ppd);
+	if (!cc_state) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	memcpy(buf, (void *)&cc_state->cong_setting + pos, count);
+	rcu_read_unlock();
+
+	return count;
+}
+static const BIN_ATTR_RO(cc_setting_bin, PAGE_SIZE);
+
+static const struct bin_attribute *const port_cc_bin_attributes[] = {
+	&bin_attr_cc_setting_bin,
+	&bin_attr_cc_table_bin,
+	NULL
+};
+
+static ssize_t cc_prescan_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi2_pportdata *ppd = &dd->pport[port_num - 1];
+
+	return sysfs_emit(buf, "%s\n", ppd->cc_prescan ? "on" : "off");
+}
+
+static ssize_t cc_prescan_store(struct ib_device *ibdev, u32 port_num,
+				struct ib_port_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi2_pportdata *ppd = &dd->pport[port_num - 1];
+
+	if (!memcmp(buf, "on", 2))
+		ppd->cc_prescan = true;
+	else if (!memcmp(buf, "off", 3))
+		ppd->cc_prescan = false;
+
+	return count;
+}
+static IB_PORT_ATTR_ADMIN_RW(cc_prescan);
+
+static struct attribute *port_cc_attributes[] = {
+	&ib_port_attr_cc_prescan.attr,
+	NULL
+};
+
+static const struct attribute_group port_cc_group = {
+	.name = "CCMgtA",
+	.attrs = port_cc_attributes,
+	.bin_attrs = port_cc_bin_attributes,
+};
+
+/* Start sc2vl */
+struct hfi2_sc2vl_attr {
+	struct ib_port_attribute attr;
+	int sc;
+};
+
+static ssize_t sc2vl_attr_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi2_sc2vl_attr *sattr =
+		container_of(attr, struct hfi2_sc2vl_attr, attr);
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi2_pportdata *ppd = &dd->pport[port_num - 1];
+
+	return sysfs_emit(buf, "%u\n", *((u8 *)ppd->sc2vl + sattr->sc));
+}
+
+#define HFI2_SC2VL_ATTR(N)                                                     \
+	static struct hfi2_sc2vl_attr hfi2_sc2vl_attr_##N = {                  \
+		.attr = __ATTR(N, 0444, sc2vl_attr_show, NULL),                \
+		.sc = N,                                                       \
+	}
+
+HFI2_SC2VL_ATTR(0);
+HFI2_SC2VL_ATTR(1);
+HFI2_SC2VL_ATTR(2);
+HFI2_SC2VL_ATTR(3);
+HFI2_SC2VL_ATTR(4);
+HFI2_SC2VL_ATTR(5);
+HFI2_SC2VL_ATTR(6);
+HFI2_SC2VL_ATTR(7);
+HFI2_SC2VL_ATTR(8);
+HFI2_SC2VL_ATTR(9);
+HFI2_SC2VL_ATTR(10);
+HFI2_SC2VL_ATTR(11);
+HFI2_SC2VL_ATTR(12);
+HFI2_SC2VL_ATTR(13);
+HFI2_SC2VL_ATTR(14);
+HFI2_SC2VL_ATTR(15);
+HFI2_SC2VL_ATTR(16);
+HFI2_SC2VL_ATTR(17);
+HFI2_SC2VL_ATTR(18);
+HFI2_SC2VL_ATTR(19);
+HFI2_SC2VL_ATTR(20);
+HFI2_SC2VL_ATTR(21);
+HFI2_SC2VL_ATTR(22);
+HFI2_SC2VL_ATTR(23);
+HFI2_SC2VL_ATTR(24);
+HFI2_SC2VL_ATTR(25);
+HFI2_SC2VL_ATTR(26);
+HFI2_SC2VL_ATTR(27);
+HFI2_SC2VL_ATTR(28);
+HFI2_SC2VL_ATTR(29);
+HFI2_SC2VL_ATTR(30);
+HFI2_SC2VL_ATTR(31);
+
+static struct attribute *port_sc2vl_attributes[] = {
+	&hfi2_sc2vl_attr_0.attr.attr,
+	&hfi2_sc2vl_attr_1.attr.attr,
+	&hfi2_sc2vl_attr_2.attr.attr,
+	&hfi2_sc2vl_attr_3.attr.attr,
+	&hfi2_sc2vl_attr_4.attr.attr,
+	&hfi2_sc2vl_attr_5.attr.attr,
+	&hfi2_sc2vl_attr_6.attr.attr,
+	&hfi2_sc2vl_attr_7.attr.attr,
+	&hfi2_sc2vl_attr_8.attr.attr,
+	&hfi2_sc2vl_attr_9.attr.attr,
+	&hfi2_sc2vl_attr_10.attr.attr,
+	&hfi2_sc2vl_attr_11.attr.attr,
+	&hfi2_sc2vl_attr_12.attr.attr,
+	&hfi2_sc2vl_attr_13.attr.attr,
+	&hfi2_sc2vl_attr_14.attr.attr,
+	&hfi2_sc2vl_attr_15.attr.attr,
+	&hfi2_sc2vl_attr_16.attr.attr,
+	&hfi2_sc2vl_attr_17.attr.attr,
+	&hfi2_sc2vl_attr_18.attr.attr,
+	&hfi2_sc2vl_attr_19.attr.attr,
+	&hfi2_sc2vl_attr_20.attr.attr,
+	&hfi2_sc2vl_attr_21.attr.attr,
+	&hfi2_sc2vl_attr_22.attr.attr,
+	&hfi2_sc2vl_attr_23.attr.attr,
+	&hfi2_sc2vl_attr_24.attr.attr,
+	&hfi2_sc2vl_attr_25.attr.attr,
+	&hfi2_sc2vl_attr_26.attr.attr,
+	&hfi2_sc2vl_attr_27.attr.attr,
+	&hfi2_sc2vl_attr_28.attr.attr,
+	&hfi2_sc2vl_attr_29.attr.attr,
+	&hfi2_sc2vl_attr_30.attr.attr,
+	&hfi2_sc2vl_attr_31.attr.attr,
+	NULL
+};
+
+static const struct attribute_group port_sc2vl_group = {
+	.name = "sc2vl",
+	.attrs = port_sc2vl_attributes,
+};
+/* End sc2vl */
+
+/* Start sl2sc */
+struct hfi2_sl2sc_attr {
+	struct ib_port_attribute attr;
+	int sl;
+};
+
+static ssize_t sl2sc_attr_show(struct ib_device *ibdev, u32 port_num,
+			       struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi2_sl2sc_attr *sattr =
+		container_of(attr, struct hfi2_sl2sc_attr, attr);
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi2_ibport *ibp = &dd->pport[port_num - 1].ibport_data;
+
+	return sysfs_emit(buf, "%u\n", ibp->sl_to_sc[sattr->sl]);
+}
+
+#define HFI2_SL2SC_ATTR(N)                                                     \
+	static struct hfi2_sl2sc_attr hfi2_sl2sc_attr_##N = {                  \
+		.attr = __ATTR(N, 0444, sl2sc_attr_show, NULL), .sl = N        \
+	}
+
+HFI2_SL2SC_ATTR(0);
+HFI2_SL2SC_ATTR(1);
+HFI2_SL2SC_ATTR(2);
+HFI2_SL2SC_ATTR(3);
+HFI2_SL2SC_ATTR(4);
+HFI2_SL2SC_ATTR(5);
+HFI2_SL2SC_ATTR(6);
+HFI2_SL2SC_ATTR(7);
+HFI2_SL2SC_ATTR(8);
+HFI2_SL2SC_ATTR(9);
+HFI2_SL2SC_ATTR(10);
+HFI2_SL2SC_ATTR(11);
+HFI2_SL2SC_ATTR(12);
+HFI2_SL2SC_ATTR(13);
+HFI2_SL2SC_ATTR(14);
+HFI2_SL2SC_ATTR(15);
+HFI2_SL2SC_ATTR(16);
+HFI2_SL2SC_ATTR(17);
+HFI2_SL2SC_ATTR(18);
+HFI2_SL2SC_ATTR(19);
+HFI2_SL2SC_ATTR(20);
+HFI2_SL2SC_ATTR(21);
+HFI2_SL2SC_ATTR(22);
+HFI2_SL2SC_ATTR(23);
+HFI2_SL2SC_ATTR(24);
+HFI2_SL2SC_ATTR(25);
+HFI2_SL2SC_ATTR(26);
+HFI2_SL2SC_ATTR(27);
+HFI2_SL2SC_ATTR(28);
+HFI2_SL2SC_ATTR(29);
+HFI2_SL2SC_ATTR(30);
+HFI2_SL2SC_ATTR(31);
+
+static struct attribute *port_sl2sc_attributes[] = {
+	&hfi2_sl2sc_attr_0.attr.attr,
+	&hfi2_sl2sc_attr_1.attr.attr,
+	&hfi2_sl2sc_attr_2.attr.attr,
+	&hfi2_sl2sc_attr_3.attr.attr,
+	&hfi2_sl2sc_attr_4.attr.attr,
+	&hfi2_sl2sc_attr_5.attr.attr,
+	&hfi2_sl2sc_attr_6.attr.attr,
+	&hfi2_sl2sc_attr_7.attr.attr,
+	&hfi2_sl2sc_attr_8.attr.attr,
+	&hfi2_sl2sc_attr_9.attr.attr,
+	&hfi2_sl2sc_attr_10.attr.attr,
+	&hfi2_sl2sc_attr_11.attr.attr,
+	&hfi2_sl2sc_attr_12.attr.attr,
+	&hfi2_sl2sc_attr_13.attr.attr,
+	&hfi2_sl2sc_attr_14.attr.attr,
+	&hfi2_sl2sc_attr_15.attr.attr,
+	&hfi2_sl2sc_attr_16.attr.attr,
+	&hfi2_sl2sc_attr_17.attr.attr,
+	&hfi2_sl2sc_attr_18.attr.attr,
+	&hfi2_sl2sc_attr_19.attr.attr,
+	&hfi2_sl2sc_attr_20.attr.attr,
+	&hfi2_sl2sc_attr_21.attr.attr,
+	&hfi2_sl2sc_attr_22.attr.attr,
+	&hfi2_sl2sc_attr_23.attr.attr,
+	&hfi2_sl2sc_attr_24.attr.attr,
+	&hfi2_sl2sc_attr_25.attr.attr,
+	&hfi2_sl2sc_attr_26.attr.attr,
+	&hfi2_sl2sc_attr_27.attr.attr,
+	&hfi2_sl2sc_attr_28.attr.attr,
+	&hfi2_sl2sc_attr_29.attr.attr,
+	&hfi2_sl2sc_attr_30.attr.attr,
+	&hfi2_sl2sc_attr_31.attr.attr,
+	NULL
+};
+
+static const struct attribute_group port_sl2sc_group = {
+	.name = "sl2sc",
+	.attrs = port_sl2sc_attributes,
+};
+
+/* End sl2sc */
+
+/* Start vl2mtu */
+
+struct hfi2_vl2mtu_attr {
+	struct ib_port_attribute attr;
+	int vl;
+};
+
+static ssize_t vl2mtu_attr_show(struct ib_device *ibdev, u32 port_num,
+				struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi2_vl2mtu_attr *vlattr =
+		container_of(attr, struct hfi2_vl2mtu_attr, attr);
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi2_pportdata *ppd = &dd->pport[port_num - 1];
+
+	return sysfs_emit(buf, "%u\n", ppd->vld[vlattr->vl].mtu);
+}
+
+#define HFI2_VL2MTU_ATTR(N)                                                    \
+	static struct hfi2_vl2mtu_attr hfi2_vl2mtu_attr_##N = {                \
+		.attr = __ATTR(N, 0444, vl2mtu_attr_show, NULL),               \
+		.vl = N,                                                       \
+	}
+
+HFI2_VL2MTU_ATTR(0);
+HFI2_VL2MTU_ATTR(1);
+HFI2_VL2MTU_ATTR(2);
+HFI2_VL2MTU_ATTR(3);
+HFI2_VL2MTU_ATTR(4);
+HFI2_VL2MTU_ATTR(5);
+HFI2_VL2MTU_ATTR(6);
+HFI2_VL2MTU_ATTR(7);
+HFI2_VL2MTU_ATTR(8);
+HFI2_VL2MTU_ATTR(9);
+HFI2_VL2MTU_ATTR(10);
+HFI2_VL2MTU_ATTR(11);
+HFI2_VL2MTU_ATTR(12);
+HFI2_VL2MTU_ATTR(13);
+HFI2_VL2MTU_ATTR(14);
+HFI2_VL2MTU_ATTR(15);
+
+static struct attribute *port_vl2mtu_attributes[] = {
+	&hfi2_vl2mtu_attr_0.attr.attr,
+	&hfi2_vl2mtu_attr_1.attr.attr,
+	&hfi2_vl2mtu_attr_2.attr.attr,
+	&hfi2_vl2mtu_attr_3.attr.attr,
+	&hfi2_vl2mtu_attr_4.attr.attr,
+	&hfi2_vl2mtu_attr_5.attr.attr,
+	&hfi2_vl2mtu_attr_6.attr.attr,
+	&hfi2_vl2mtu_attr_7.attr.attr,
+	&hfi2_vl2mtu_attr_8.attr.attr,
+	&hfi2_vl2mtu_attr_9.attr.attr,
+	&hfi2_vl2mtu_attr_10.attr.attr,
+	&hfi2_vl2mtu_attr_11.attr.attr,
+	&hfi2_vl2mtu_attr_12.attr.attr,
+	&hfi2_vl2mtu_attr_13.attr.attr,
+	&hfi2_vl2mtu_attr_14.attr.attr,
+	&hfi2_vl2mtu_attr_15.attr.attr,
+	NULL
+};
+
+static const struct attribute_group port_vl2mtu_group = {
+	.name = "vl2mtu",
+	.attrs = port_vl2mtu_attributes,
+};
+
+/* start per-port nctxts and freectxts */
+static ssize_t num_ctxts_show(struct ib_device *ibdev, u32 port_num,
+			      struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi2_portrsrcs *pr = &dd->rsrcs.ppr[port_num - 1];
+
+	return sysfs_emit(buf, "%u\n", pr->num_user_contexts);
+}
+
+static IB_PORT_ATTR_RO(num_ctxts);
+
+static ssize_t num_freectxts_show(struct ib_device *ibdev, u32 port_num,
+				  struct ib_port_attribute *attr, char *buf)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	struct hfi2_pportdata *ppd = &dd->pport[port_num - 1];
+
+	return sysfs_emit(buf, "%u\n", ppd->freectxts);
+}
+
+static IB_PORT_ATTR_RO(num_freectxts);
+
+static struct attribute *port_ctxt_attributes[] = {
+	&ib_port_attr_num_ctxts.attr,
+	&ib_port_attr_num_freectxts.attr,
+	NULL,
+};
+
+static struct attribute_group port_ctxt_group = {
+	.attrs = port_ctxt_attributes,
+};
+
+/* end of per-port file structures and support code */
+
+/*
+ * Start of per-unit (or driver, in some cases, but replicated
+ * per unit) functions (these get a device *)
+ */
+static ssize_t hw_rev_show(struct device *device, struct device_attribute *attr,
+			   char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+
+	return sysfs_emit(buf, "%x\n", dd_from_dev(dev)->minrev);
+}
+static DEVICE_ATTR_RO(hw_rev);
+
+static ssize_t board_id_show(struct device *device,
+			     struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+
+	if (!dd->boardname)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", dd->boardname);
+}
+static DEVICE_ATTR_RO(board_id);
+
+static ssize_t boardversion_show(struct device *device,
+				 struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+
+	/* The string printed here is already newline-terminated. */
+	return sysfs_emit(buf, "%s\n", dd->boardversion);
+}
+static DEVICE_ATTR_RO(boardversion);
+
+static ssize_t nctxts_show(struct device *device,
+			   struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	u32 total;
+	int pidx;
+
+	total = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++)
+		total += dd->rsrcs.ppr[pidx].num_user_contexts;
+
+	return sysfs_emit(buf, "%u\n", total);
+}
+static DEVICE_ATTR_RO(nctxts);
+
+static ssize_t nfreectxts_show(struct device *device,
+			       struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	u32 total;
+	int i;
+
+	for (total = 0, i = 0; i < dd->num_pports; i++)
+		total += dd->pport[i].freectxts;
+
+	/* Return the number of free user ports (contexts) available. */
+	return sysfs_emit(buf, "%u\n", total);
+}
+static DEVICE_ATTR_RO(nfreectxts);
+
+static ssize_t serial_show(struct device *device,
+			   struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+
+	/* dd->serial is already newline terminated in chip.c */
+	return sysfs_emit(buf, "%s\n", dd->serial);
+}
+static DEVICE_ATTR_RO(serial);
+
+static ssize_t chip_reset_store(struct device *device,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	int ret;
+
+	if (count < 5 || memcmp(buf, "reset", 5)) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	ret = hfi2_reset_device(dd->unit);
+bail:
+	return ret < 0 ? ret : count;
+}
+static DEVICE_ATTR_WO(chip_reset);
+
+/*
+ * Convert the reported temperature from an integer (reported in
+ * units of 0.25C) to a floating point number.
+ */
+#define temp_d(t) ((t) >> 2)
+#define temp_f(t) (((t)&0x3) * 25u)
+
+static ssize_t emit_temperature(char *buf, ssize_t off, const char *lbl,
+				s16 temp, bool valid)
+{
+	int n = temp * 125;
+	bool neg = false;
+
+	if (!valid)
+		return sysfs_emit_at(buf, off, "%s none\n", lbl);
+	if (n < 0) {
+		neg = true;
+		n = -n;
+	}
+	return sysfs_emit_at(buf, off, "%s %s%u.%03u\n", lbl, neg ? "-" : "",
+			     n / 1000, n % 1000);
+}
+
+static ssize_t emit_cport_temp(struct hfi2_devdata *dd, char *buf,
+			       struct cport_temp *temp)
+{
+	ssize_t off = 0;
+
+	off += emit_temperature(buf, off, "ASIC", temp->asic,
+				temp->asic_valid);
+	off += emit_temperature(buf, off, "QSFP1", temp->qsfp1,
+				temp->qsfp1_valid);
+	off += emit_temperature(buf, off, "QSFP2", temp->qsfp2,
+				temp->qsfp2_valid);
+	return off;
+}
+
+/*
+ * Dump tempsense values, in decimal, to ease shell-scripts.
+ */
+static ssize_t tempsense_show(struct device *device,
+			      struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	struct hfi2_cport *cport;
+	struct cport_temp temp = {0};
+	int ret;
+
+	if (dd->params->chip_type == CHIP_WFR) {
+		struct hfi2_temp temp;
+
+		ret = hfi2_tempsense_rd(dd, &temp);
+		if (ret)
+			return ret;
+
+		return sysfs_emit(buf, "%u.%02u %u.%02u %u.%02u %u.%02u %u %u %u\n",
+				  temp_d(temp.curr), temp_f(temp.curr),
+				  temp_d(temp.lo_lim), temp_f(temp.lo_lim),
+				  temp_d(temp.hi_lim), temp_f(temp.hi_lim),
+				  temp_d(temp.crit_lim), temp_f(temp.crit_lim),
+				  temp.triggers & 0x1,
+				  temp.triggers & 0x2,
+				  temp.triggers & 0x4);
+	}
+
+	/* beyond WFR */
+	cport = dd->cport;
+	if (!cport)
+		return -EINVAL;
+
+	/* the firmware does not update often, use cached value until timeout */
+	if (time_after(jiffies, cport->temp_timeout)) {
+		ret = cport_read_temp(dd, &temp);
+		if (ret)
+			return ret;
+		cport->temp = temp;
+		/* firmware updates every ~15 seconds */
+		cport->temp_timeout = jiffies + msecs_to_jiffies(5000);
+	} else {
+		temp = cport->temp;
+	}
+	return emit_cport_temp(dd, buf, &temp);
+}
+static DEVICE_ATTR_RO(tempsense);
+
+/*
+ * Dump device resource assignments.
+ */
+static ssize_t hw_resources_show(struct device *device,
+				 struct device_attribute *attr, char *buf)
+{
+	struct hfi2_ibdev *dev =
+		rdma_device_to_drv_device(device, struct hfi2_ibdev, rdi.ibdev);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	ssize_t off = 0;
+	int pidx;
+
+	off += sysfs_emit_at(buf, off,
+			     "pfunit %u\n"
+			     "si_idx %u\n"
+			     "numvfs %u\n",
+			     dr->pfunit, dr->si_idx, dr->num_vfs);
+
+	off += sysfs_emit_at(buf, off,
+			     "sctxt  %u-%u\n"
+			     "rctxt  %u-%u\n"
+			     "sde    %u-%u\n"
+			     "rcvary %u-%u\n"
+			     "pio    %u-%u\n",
+			     dr->c.first_send_context, dr->c.last_send_context - 1,
+			     dr->c.first_rcv_context, dr->c.last_rcv_context - 1,
+			     dr->first_sdma_engine, dr->last_sdma_engine - 1,
+			     dr->c.first_rcvarray_entry, dr->c.last_rcvarray_entry - 1,
+			     dr->c.first_pio_block, dr->c.last_pio_block - 1);
+
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		struct hfi2_portrsrcs *pr = &dr->ppr[pidx];
+
+		if (!pr->num_rcv_contexts) {
+			off += sysfs_emit_at(buf, off, "p%d not used\n", pidx);
+			continue;
+		}
+
+		off += sysfs_emit_at(buf, off,
+				     "p%d.rctxt    %u-%u\n"
+				     "p%d.firstdyn %u\n",
+				     pidx, pr->rcv_context_base,
+				     pr->rcv_context_base + pr->num_rcv_contexts - 1,
+				     pidx, pr->first_dyn_alloc_ctxt);
+		off += sysfs_emit_at(buf, off,
+				     "p%d.nkrcvq   %u\n"
+				     "p%d.nnetdev  %u\n"
+				     "p%d.nuctxts  %u\n",
+				     pidx, pr->n_krcv_queues,
+				     pidx, pr->num_netdev_contexts,
+				     pidx, pr->num_user_contexts);
+		off += sysfs_emit_at(buf, off,
+				     "p%d.rcvary   %u\n",
+				     pidx, pr->rcv_array_base);
+	}
+	off += vf2pf_sysfs_emit_at(dd, buf, off);
+	if (off >= PAGE_SIZE) {
+		dd_dev_warn(dd, "hw_resources exceeds PAGE_SIZE.\n");
+		return -EFBIG;
+	}
+	return off;
+}
+static DEVICE_ATTR_RO(hw_resources);
+
+/*
+ * end of per-unit (or driver, in some cases, but replicated
+ * per unit) functions
+ */
+
+/* start of per-unit file structures and support code */
+static struct attribute *hfi2_attributes[] = {
+	&dev_attr_hw_rev.attr,
+	&dev_attr_board_id.attr,
+	&dev_attr_nctxts.attr,
+	&dev_attr_nfreectxts.attr,
+	&dev_attr_serial.attr,
+	&dev_attr_boardversion.attr,
+	&dev_attr_tempsense.attr,
+	&dev_attr_chip_reset.attr,
+	&dev_attr_hw_resources.attr,
+	NULL,
+};
+
+const struct attribute_group ib_hfi2_attr_group = {
+	.attrs = hfi2_attributes,
+};
+
+const struct attribute_group *wfr_attr_port_groups[] = {
+	&port_cc_group,
+	&port_sc2vl_group,
+	&port_sl2sc_group,
+	&port_vl2mtu_group,
+	&port_ctxt_group,
+	NULL,
+};
+
+const struct attribute_group *cport_attr_port_groups[] = {
+	&port_sc2vl_group,
+	&port_sl2sc_group,
+	&port_vl2mtu_group,
+	&port_ctxt_group,
+	NULL,
+};
+
+struct sde_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct sdma_engine *sde, char *buf);
+	ssize_t (*store)(struct sdma_engine *sde, const char *buf, size_t cnt);
+};
+
+static ssize_t sde_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct sde_attribute *sde_attr =
+		container_of(attr, struct sde_attribute, attr);
+	struct sdma_engine *sde =
+		container_of(kobj, struct sdma_engine, kobj);
+
+	if (!sde_attr->show)
+		return -EINVAL;
+
+	return sde_attr->show(sde, buf);
+}
+
+static ssize_t sde_store(struct kobject *kobj, struct attribute *attr,
+			 const char *buf, size_t count)
+{
+	struct sde_attribute *sde_attr =
+		container_of(attr, struct sde_attribute, attr);
+	struct sdma_engine *sde =
+		container_of(kobj, struct sdma_engine, kobj);
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (!sde_attr->store)
+		return -EINVAL;
+
+	return sde_attr->store(sde, buf, count);
+}
+
+static const struct sysfs_ops sde_sysfs_ops = {
+	.show = sde_show,
+	.store = sde_store,
+};
+
+static const struct kobj_type sde_ktype = {
+	.sysfs_ops = &sde_sysfs_ops,
+};
+
+#define SDE_ATTR(_name, _mode, _show, _store) \
+	struct sde_attribute sde_attr_##_name = \
+		__ATTR(_name, _mode, _show, _store)
+
+static ssize_t sde_show_cpu_to_sde_map(struct sdma_engine *sde, char *buf)
+{
+	return sdma_get_cpu_to_sde_map(sde, buf);
+}
+
+static ssize_t sde_store_cpu_to_sde_map(struct sdma_engine *sde,
+					const char *buf, size_t count)
+{
+	return sdma_set_cpu_to_sde_map(sde, buf, count);
+}
+
+static ssize_t sde_show_vl(struct sdma_engine *sde, char *buf)
+{
+	struct hfi2_devdata *dd = sde->dd;
+	ssize_t off = 0;
+	int vl;
+	int i;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		vl = sdma_engine_get_vl(&dd->pport[i], sde);
+		if (vl < 0)
+			return vl;
+		if (i != 0)
+			off += sysfs_emit_at(buf, off, ",");
+		off += sysfs_emit_at(buf, off, "%d", vl);
+	}
+
+	return off;
+}
+
+static SDE_ATTR(cpu_list, 0644,
+		sde_show_cpu_to_sde_map,
+		sde_store_cpu_to_sde_map);
+static SDE_ATTR(vl, 0444, sde_show_vl, NULL);
+
+static struct sde_attribute *sde_attribs[] = {
+	&sde_attr_cpu_list,
+	&sde_attr_vl
+};
+
+/*
+ * Register and create our files in /sys/class/infiniband.
+ */
+int hfi2_verbs_register_sysfs(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	struct ib_device *dev = &dd->verbs_dev.rdi.ibdev;
+	struct device *class_dev = &dev->dev;
+	int i, j, ret;
+
+	for (i = dr->first_sdma_engine; i < dr->last_sdma_engine; i++) {
+		ret = kobject_init_and_add(&dd->per_sdma[i].kobj,
+					   &sde_ktype, &class_dev->kobj,
+					   "sdma%d", i);
+		if (ret)
+			goto bail;
+
+		for (j = 0; j < ARRAY_SIZE(sde_attribs); j++) {
+			ret = sysfs_create_file(&dd->per_sdma[i].kobj,
+						&sde_attribs[j]->attr);
+			if (ret)
+				goto bail;
+		}
+	}
+
+	vf2pf_init_sysfs(dd, class_dev);
+
+	return 0;
+bail:
+	/*
+	 * The function kobject_put() will call kobject_del() if the kobject
+	 * has been added successfully. The sysfs files created under the
+	 * kobject directory will also be removed during the process.
+	 */
+	for (; i >= dr->first_sdma_engine; i--)
+		kobject_put(&dd->per_sdma[i].kobj);
+
+	return ret;
+}
+
+/*
+ * Unregister and remove our files in /sys/class/infiniband.
+ */
+void hfi2_verbs_unregister_sysfs(struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	int i;
+
+	/* Unwind operations in hfi2_verbs_register_sysfs() */
+	for (i = dr->first_sdma_engine; i < dr->last_sdma_engine; i++)
+		kobject_put(&dd->per_sdma[i].kobj);
+}



