Return-Path: <linux-rdma+bounces-17817-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIJhMSszr2kPQQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17817-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:52:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0DC241247
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 21:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA7D304E715
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9B3612C7;
	Mon,  9 Mar 2026 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="J94Tm3O6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022086.outbound.protection.outlook.com [40.93.195.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25123101CE
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773089455; cv=fail; b=slcd2pxwqpamu63Yax2ZKGfef9osEk+P492RkEsrgGSEH6y/lTAjB13VJsVnkDf3zivkdQqTBZdz4CEfvHH9hsr7117ywkcnsVs51nhCwmtMhbUa9+HWki+GdfPQh2LVzq9vOgzvwJImt+ER0L9e6Kzmojujnb/TStCxfE1IdpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773089455; c=relaxed/simple;
	bh=UaRpMTGDcIXsLQcIwyj9Gj6YxhCgkZ08nETz9ngUTGM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UD05lkr8SbBdRtlr7qtDVBotW93u7HfV15+Y6bHcZCjBQ3oBFeDHQ2GsVfi31PZBtnwz2RwZ9NS10vbvEsBi9HjIUnlUx95Yd0xD1IjdXatGuQPhEOjQSZpd+Lo8l1SgUFs41a26m350wKQXQGVjS4hrWfuv2BY6kCfsS8tNrhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=J94Tm3O6; arc=fail smtp.client-ip=40.93.195.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMppdyvwltbEG7l9mZ0dr/pq/xliAtoC+DyiIy0LdbrLBEvAuwyYWKCFd7RyTC0HFUV30sx8tvSBHBnUxIke00BnGY+iC8RRmCwVVOBVMZ8Xo1tLnHOGYiKlFUoJ19VxDwfWr5qx/Zp7VahVFvtN317dMXv+Sisa7QZWg4OkE10q2SedDp1lPSyBfx0Sof5rrkoal6iASq/Bfhup2dJPSANXWC1W0YZ6qwu/Y3pAJSnTLhsGTQtqibSHe7r4CpOl4I5cI3TQVMO5hTe/DpkrApnbwwAMJgkTT+kmZSx5eDCnC71C0ETLRsbRjuxxM4BwKWshOx0LmozCzNssOZpGmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLWTwbN3ZzLF3mDQ7siYV1ArVfZ97aWtcQx3/4yo8Xc=;
 b=e5P/FOifoyVXfdj7p7IcFZi6ymciFKRfFvo01KFyQspjmfaqn0KSrfOg/2KtDT5expxGyMjAL+USzJAN6/xf2sNyKshIQi+zFOORXqAFmxx2OpdZbZ4nP8tK/IAkqj7r44Dl6s4ylVUgUXVRwSzO71X0vcRUgKaehLlYed3yCkxPgG4TXt3SceLF1hbptb2crRJSNR36Cmgktf5hlhoX4GbVfcyhR3bAHvPbAT40MDIh4QOEc5VTH/d+N4yR5pfPLOFIQch8JYE9Y3+axYNpNptgbGeM25Kdj4rB5E2QU2echdHbjVz9q6kVw7gDs4Bx3IllkdIU6YyreY+jaHMn7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLWTwbN3ZzLF3mDQ7siYV1ArVfZ97aWtcQx3/4yo8Xc=;
 b=J94Tm3O6RaN33aJ8jV3wPpO+h0Hg3mDX2XI1Y4XKXND4ZJMFHLygt5+Gx7D20u+8nbUZKWo2vNFNXIZ/tL4HexagclroOWeInjwnx8A+Oe5qEc6nzK3BLFariyFXYtqfeza5c8VHxjZGfEh51fKhahwYiG00qOdhLsxjbDvUp2VFxtKdmMypen1w+BVuaeuf4fBazOsCuq9D/zroPJ2u/6ICOaz8607jJnnKhgtWqqeTlrorsskT/O5FkYFRUWxs/Du2GozySiD0z28jc8716RRjWeDKJFzh08oPG6xUYBIOUiDbAH2CTmPtfJ5xkUJeKQEI7xiOTpG1thkAw69Wig==
Received: from CH2PR02CA0016.namprd02.prod.outlook.com (2603:10b6:610:4e::26)
 by LV5PR01MB994197.prod.exchangelabs.com (2603:10b6:408:35e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 20:50:42 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::76) by CH2PR02CA0016.outlook.office365.com
 (2603:10b6:610:4e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 20:50:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Mon, 9 Mar 2026 20:50:42 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id AA86014D715;
	Mon,  9 Mar 2026 16:50:41 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id A70011810D6D7;
	Mon,  9 Mar 2026 16:50:41 -0400 (EDT)
Subject: [PATCH for-next 03/24] RDMA/hfi2: Add counter accessor functions
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 09 Mar 2026 16:50:41 -0400
Message-ID:
 <177308944163.1280641.5476538219844666908.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|LV5PR01MB994197:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d344334-51d8-456a-8433-08de7e1d8794
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	u6b+p4EcqQjVESd/NENIcT/iu68GARKq1ScRP+lF10pmUenmp2HPjiJoRNw97L22G8ZqkruuwM0weZ1IVymme8g8jFIwWimGWFIbZmDIKjd8wc0Wk7yhs/o1OPuP4msa7HfpNUI7TQVYLxQKrF8axDtjCc9M2asCfDW8154SCNoh0S66iS7nrapIB9KcgIazTnDqGSD+IoHJAcHIlEUE70WBQ2nyTFxH2E01qKgv1f4ks2cZ5z7wRVPm37GPiA48LiLYSYG8cUnp398m8hoQUieHsqTQgpTtGNnICNIsZrNlW08JI1VhNrZVxU586iieK+FVj5OCw7XcPfwB0DltpEgDjlD5aHC/8iHRVbI0Pjg6fYnPe3Qid6f2OkjjY6oBoMVW4/C9bMnNgzxWYqwJK1VqdbR1p5nCeC7aQjxyNTm0DbrTaRsKlU8mzXSZvXo7rTncdahv+CM5oZl/UD5E6LF6b3A+WXhoQw0V11Kzg2ISbw2myJqzooMyPArTi6FOcrTWPEZRCPCe2afCe5MbPP7ZXZVhdRo7tzBQKDPWHEsqOalgTaffGcXjpWb91zkW4149uj8cdpZuEaz46yugq8Dinrb3/9nuT7+IwWEr650Vdl3mBpkjW9oLNvFH8LNLhpE+Qs9ZcLCiVwhrQ8kUPxAl43IeX5gjzzZ2rwyeWVQ2s1oaSWjrrKVAJ9F763KckyxmcZmeoDqXaYnP0nqrGLhrxHDZVK/LNOUqjPYYBTtJKO35PGvMlCme3Z5P9PwXkibuVuQTyGdQHSRpEhfNTA==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RPnuIR0ozrzsN7NblbdHGyO4brGD/C6jr5dssXFFIrAsIP87VGxSPBDl3lkZVyTy+VkqQ0/Gen9+4BfJ5MDUNJvR0G+6iWItuxILRyl6CnbUvtFNTBuYXEp7XpfrFKs++Q2iu37QX1/EWerxf4ch9S5LM9ehDIwi6QYlslzldiR8FwCKYNawMKMgdwZPEwNis8ohPotzLDbc4n2JP87C9Qqwe66wGFgwCg1N1NPNT/IuP6tXxwQ6dAzHk9lbTRscPM6Jzre9DLwYxrY6tnTYcnKL5n/uEqOEYRm0IbA+5Zfrv/cZEObETERhmztuUjuzYWECdy4yyNIrqMfH21UTAn8HaQK2imv3eJ5HVTmoL7H5a15walut4XEHRph0EO9CJtt3uGm4Dg2oZpAI5mns/soPFgN4K1D63M3zkrKx6edaAlFCPxOQXfc/Gr2D6WND
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:50:42.5634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d344334-51d8-456a-8433-08de7e1d8794
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR01MB994197
X-Rspamd-Queue-Id: BD0DC241247
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17817-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cornelisnetworks.com:dkim,cornelisnetworks.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,awdrv-04.cornelisnetworks.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Action: no action

Add the hardware counter accessor functions and counter table arrays
for the hfi2 driver. These are machine-generated accessor functions
and CNTR_ELEM table entries that map hardware counters to the driver
counter infrastructure.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/chip.h          |    4 
 drivers/infiniband/hw/hfi2/chip_counters.c | 4129 ++++++++++++++++++++++++++++
 2 files changed, 4133 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/chip_counters.c

diff --git a/drivers/infiniband/hw/hfi2/chip.h b/drivers/infiniband/hw/hfi2/chip.h
index bbc4878a68f4..5e0a97a30677 100644
--- a/drivers/infiniband/hw/hfi2/chip.h
+++ b/drivers/infiniband/hw/hfi2/chip.h
@@ -1413,6 +1413,10 @@ extern struct cntr_entry wfr_dev_cntrs[];
 extern struct cntr_entry jkr_dev_cntrs[];
 extern struct cntr_entry wfr_port_cntrs[];
 extern struct cntr_entry jkr_port_cntrs[];
+#define CNTR_MAX 0xFFFFFFFFFFFFFFFFULL
+#define CNTR_32BIT_MAX 0x00000000FFFFFFFF
+extern struct cntr_entry shared_dev_cntrs[];
+extern struct cntr_entry shared_port_cntrs[];
 
 struct flag_table {
 	u64 flag;	/* the flag */
diff --git a/drivers/infiniband/hw/hfi2/chip_counters.c b/drivers/infiniband/hw/hfi2/chip_counters.c
new file mode 100644
index 000000000000..81f81e854627
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_counters.c
@@ -0,0 +1,4129 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+/*
+ * This file contains all of the code that is specific to the HFI chip
+ */
+
+#include <linux/pci.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+
+#include "hfi2.h"
+#include "file_ops.h"
+#include "trace.h"
+#include "mad.h"
+#include "pio.h"
+#include "sdma.h"
+#include "eprom.h"
+#include "efivar.h"
+#include "platform.h"
+#include "aspm.h"
+#include "affinity.h"
+#include "debugfs.h"
+#include "fault.h"
+#include "netdev.h"
+#include "chip_registers_jkr.h"
+
+#define CNTR_ELEM(name, csr, offset, flags, accessor) \
+{ \
+	name, \
+	csr, \
+	offset, \
+	flags, \
+	accessor \
+}
+
+/* 32bit RXE */
+#define RXE32_PORT_CNTR_ELEM(name, counter, flags) \
+	{ name, (counter) * 8, 0, flags | CNTR_32BIT, port_access_rxe32_csr }
+
+/* 64bit RXE */
+#define RXE64_PORT_CNTR_ELEM(name, counter, flags) \
+CNTR_ELEM(#name, \
+	  (counter) * 8, \
+	  0, flags, \
+	  port_access_rxe64_csr)
+
+/* 32bit TXE */
+#define TXE32_PORT_CNTR_ELEM(name, counter, flags) \
+CNTR_ELEM(#name, \
+	  (counter) * 8, \
+	  0, flags | CNTR_32BIT, \
+	  port_access_txe32_csr)
+
+/* 64bit TXE */
+#define TXE64_PORT_CNTR_ELEM(name, counter, flags) \
+CNTR_ELEM(#name, \
+	  (counter) * 8, \
+	  0, flags, \
+	  port_access_txe64_csr)
+
+/* CCE */
+#define CCE_PERF_DEV_CNTR_ELEM(name, counter, flags) \
+CNTR_ELEM(name, \
+	  (counter * 8 + CCE_COUNTER_ARRAY32), \
+	  0, flags | CNTR_32BIT, \
+	  dev_access_u32_csr)
+
+#define CCE_INT_DEV_CNTR_ELEM(name, counter, flags) \
+CNTR_ELEM(#name, \
+	  (counter * 8 + CCE_INT_COUNTER_ARRAY32), \
+	  0, flags | CNTR_32BIT, \
+	  dev_access_u32_csr)
+
+/* DC */
+#define DC_PERF_CNTR(name, counter, flags) \
+CNTR_ELEM(#name, \
+	  counter, \
+	  0, \
+	  flags, \
+	  dev_access_u64_csr)
+
+#define DC_PERF_CNTR_LCB(name, counter, flags) \
+CNTR_ELEM(#name, \
+	  counter, \
+	  0, \
+	  flags, \
+	  dc_access_lcb_cntr)
+
+/* ibp counters */
+#define SW_IBP_CNTR(name, cntr) \
+CNTR_ELEM(#name, \
+	  0, \
+	  0, \
+	  CNTR_SYNTH, \
+	  access_ibp_##cntr)
+
+/**
+ * ctxt_csr_addr - return addr for readq/writeq for a per-context register
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ * @ctxt: the context number
+ * @stride: the per-context stride
+ *
+ * This routine returns the appropriate ioremaped BAR address based on the
+ * offset and context.
+ */
+static inline void __iomem *ctxt_csr_addr(const struct hfi2_devdata *dd,
+					  u32 offset, u32 ctxt, u32 stride)
+{
+	void __iomem *base;
+	u32 cbi = ctxt_bar_idx(ctxt);
+	u32 cbc = ctxt_bar_ctxt(ctxt);
+
+	if (offset >= dd->base2_start) {
+		base = dd->bar_maps[cbi].kregbase2;
+		offset -= dd->base2_start;
+	} else {
+		base = dd->bar_maps[cbi].kregbase1;
+	}
+
+	if (!base) {
+		WARN(1, "bad context: offset 0x%x, ctxt %d, stride %d\n",
+		     offset, ctxt, stride);
+		/* return address of first register of bar0 - not writable */
+		return dd->bar_maps[0].kregbase1;
+	}
+	return base + offset + (cbc * stride);
+}
+
+/**
+ * hfi2_addr_from_offset - return addr for readq/writeq
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ *
+ * This routine selects the appropriate base address
+ * based on the indicated offset.
+ */
+static inline void __iomem *hfi2_addr_from_offset(const struct hfi2_devdata *dd,
+						  u32 offset)
+{
+	return ctxt_csr_addr(dd, offset, 0, 0);
+}
+
+/**
+ * read_csr - read CSR at the indicated offset
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ *
+ * Return: the value read or all FF's if there
+ * is no mapping
+ */
+u64 read_csr(const struct hfi2_devdata *dd, u32 offset)
+{
+	if (dd->flags & HFI2_PRESENT)
+		return readq(hfi2_addr_from_offset(dd, offset));
+	return -1;
+}
+
+/**
+ * write_csr - write CSR at the indicated offset
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ * @value: value to write
+ */
+void write_csr(const struct hfi2_devdata *dd, u32 offset, u64 value)
+{
+	if (dd->flags & HFI2_PRESENT) {
+		void __iomem *base = hfi2_addr_from_offset(dd, offset);
+
+		/* avoid write to RcvArray */
+		if (WARN_ON(offset >= dd->params->rcv_array_offset &&
+			    offset < (dd->params->rcv_array_offset +
+				      dd->params->rcv_array_size)))
+			return;
+		writeq(value, base);
+	}
+}
+
+u64 read_ctxt_csr(const struct hfi2_devdata *dd, u32 offset, u32 ctxt,
+		  u32 stride)
+{
+	if (unlikely(!(dd->flags & HFI2_PRESENT)))
+		return -1;
+	return readq(ctxt_csr_addr(dd, offset, ctxt, stride));
+}
+
+void write_ctxt_csr(const struct hfi2_devdata *dd, u32 offset, u32 ctxt,
+		    u32 stride, u64 value)
+{
+	if (unlikely(!(dd->flags & HFI2_PRESENT)))
+		return;
+	writeq(value, ctxt_csr_addr(dd, offset, ctxt, stride));
+}
+
+/**
+ * get_csr_addr - return te iomem address for offset
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ *
+ * Return: The iomem address to use in subsequent
+ * writeq/readq operations.
+ */
+void __iomem *get_csr_addr(
+	const struct hfi2_devdata *dd,
+	u32 offset)
+{
+	if (dd->flags & HFI2_PRESENT)
+		return hfi2_addr_from_offset(dd, offset);
+	return NULL;
+}
+
+static inline u64 read_write_csr(const struct hfi2_devdata *dd, u32 csr,
+				 int mode, u64 value)
+{
+	u64 ret;
+
+	if (mode == CNTR_MODE_R) {
+		ret = read_csr(dd, csr);
+	} else if (mode == CNTR_MODE_W) {
+		write_csr(dd, csr, value);
+		ret = value;
+	} else {
+		dd_dev_err(dd, "Invalid cntr register access mode");
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "csr 0x%x val 0x%llx mode %d", csr, ret, mode);
+	return ret;
+}
+
+/* Dev Access */
+static u64 dev_access_u32_csr(const struct cntr_entry *entry,
+			      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+	u64 csr = entry->csr;
+
+	if (entry->flags & CNTR_SDMA) {
+		if (vl == CNTR_INVALID_VL)
+			return 0;
+		csr += 0x100 * vl;
+	} else {
+		if (vl != CNTR_INVALID_VL)
+			return 0;
+	}
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 dev_access_sde_desc_fetched_cnt(const struct cntr_entry *entry,
+					   void *context, int idx, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u32 csr = dd->params->send_dma_desc_fetched_cnt_reg +
+		  (dd->params->txe_sdma_stride * idx);
+
+	if (idx < dr->first_sdma_engine || idx >= dr->last_sdma_engine)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 access_sde_err_cnt(const struct cntr_entry *entry,
+			      void *context, int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine && idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].err_cnt;
+	return 0;
+}
+
+static u64 access_sde_int_cnt(const struct cntr_entry *entry,
+			      void *context, int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine && idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].sdma_int_cnt;
+	return 0;
+}
+
+static u64 access_sde_idle_int_cnt(const struct cntr_entry *entry,
+				   void *context, int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine && idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].idle_int_cnt;
+	return 0;
+}
+
+static u64 access_sde_progress_int_cnt(const struct cntr_entry *entry,
+				       void *context, int idx, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+
+	if (dd->per_sdma && idx >= dr->first_sdma_engine && idx < dr->last_sdma_engine)
+		return dd->per_sdma[idx].progress_int_cnt;
+	return 0;
+}
+
+static u64 access_ovf_csr(const struct cntr_entry *entry,
+			  void *context, int idx, int mode,
+			  u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+
+	if (idx < 0 || idx >= dd->num_rcd) {
+		ppd_dev_err(ppd, "Invalid ovf counter idx %d", idx);
+		return 0;
+	}
+
+	if (mode == CNTR_MODE_R)
+		return read_kctxt_csr(dd, idx, dd->params->rcv_hdr_ovfl_cnt_reg);
+	write_kctxt_csr(dd, idx, dd->params->rcv_hdr_ovfl_cnt_reg, data);
+	return 0;
+}
+
+static u64 dev_access_u64_csr(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	u64 val = 0;
+	u64 csr = entry->csr;
+
+	if (entry->flags & CNTR_VL) {
+		if (vl == CNTR_INVALID_VL)
+			return 0;
+		csr += 8 * vl;
+	} else {
+		if (vl != CNTR_INVALID_VL)
+			return 0;
+	}
+
+	val = read_write_csr(dd, csr, mode, data);
+	return val;
+}
+
+static u64 dc_access_lcb_cntr(const struct cntr_entry *entry, void *context,
+			      int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+	u32 csr = entry->csr;
+	int ret = 0;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	if (mode == CNTR_MODE_R)
+		ret = read_lcb_csr(&dd->pport[HFI2_PORT_IDX], csr, &data);
+	else if (mode == CNTR_MODE_W)
+		ret = write_lcb_csr(&dd->pport[HFI2_PORT_IDX], csr, data);
+
+	if (ret) {
+		if (!(dd->flags & HFI2_SHUTDOWN))
+			dd_dev_err(dd, "Could not acquire LCB for counter 0x%x", csr);
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "csr 0x%x val 0x%llx mode %d", csr, data, mode);
+	return data;
+}
+
+/* Port Access */
+static u64 port_access_txe32_csr(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 csr = entry->csr + dd->params->send_counter_array32_reg +
+		  (dd->params->txe_eport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 port_access_txe64_csr(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 csr = entry->csr + dd->params->send_counter_array64_reg +
+		  (dd->params->txe_eport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	if (entry->flags & CNTR_VL) {
+		if (vl == CNTR_INVALID_VL)
+			return 0;
+		csr += 8 * vl;
+	} else {
+		if (vl != CNTR_INVALID_VL)
+			return 0;
+	}
+
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 port_access_rxe32_csr(const struct cntr_entry *entry,
+				 void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 csr = entry->csr + dd->params->rcv_counter_array32_reg +
+		  (dd->params->rxe_iport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 port_access_rxe64_csr(const struct cntr_entry *entry,
+				 void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 csr = entry->csr + dd->params->rcv_counter_array64_reg +
+		  (dd->params->rxe_iport_stride * ppd->hw_pidx);
+
+	if (dd->is_vf)
+		return 0;
+	return read_write_csr(dd, csr, mode, data);
+}
+
+/* Software defined */
+static inline u64 read_write_sw(struct hfi2_devdata *dd, u64 *cntr, int mode,
+				u64 data)
+{
+	u64 ret;
+
+	if (mode == CNTR_MODE_R) {
+		ret = *cntr;
+	} else if (mode == CNTR_MODE_W) {
+		*cntr = data;
+		ret = data;
+	} else {
+		dd_dev_err(dd, "Invalid cntr sw access mode");
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "val 0x%llx mode %d", ret, mode);
+
+	return ret;
+}
+
+static u64 access_sw_link_dn_cnt(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	return read_write_sw(ppd->dd, &ppd->link_downed, mode, data);
+}
+
+static u64 access_sw_link_up_cnt(const struct cntr_entry *entry, void *context,
+				 int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	return read_write_sw(ppd->dd, &ppd->link_up, mode, data);
+}
+
+static u64 access_sw_unknown_frame_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+	return read_write_sw(ppd->dd, &ppd->unknown_frame_count, mode, data);
+}
+
+static u64 access_sw_xmit_discards(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context;
+	u64 zero = 0;
+	u64 *counter;
+
+	if (vl == CNTR_INVALID_VL)
+		counter = &ppd->port_xmit_discards;
+	else if (vl >= 0 && vl < C_VL_COUNT)
+		counter = &ppd->port_xmit_discards_vl[vl];
+	else
+		counter = &zero;
+
+	return read_write_sw(ppd->dd, counter, mode, data);
+}
+
+static u64 access_xmit_constraint_errs(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+
+	return read_write_sw(ppd->dd, &ppd->port_xmit_constraint_errors,
+			     mode, data);
+}
+
+static u64 access_rcv_constraint_errs(const struct cntr_entry *entry,
+				      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_pportdata *ppd = context;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+
+	return read_write_sw(ppd->dd, &ppd->port_rcv_constraint_errors,
+			     mode, data);
+}
+
+u64 get_all_cpu_total(u64 __percpu *cntr)
+{
+	int cpu;
+	u64 counter = 0;
+
+	for_each_possible_cpu(cpu)
+		counter += *per_cpu_ptr(cntr, cpu);
+	return counter;
+}
+
+static u64 read_write_cpu(struct hfi2_devdata *dd, u64 *z_val,
+			  u64 __percpu *cntr,
+			  int vl, int mode, u64 data)
+{
+	u64 ret = 0;
+
+	if (vl != CNTR_INVALID_VL)
+		return 0;
+
+	if (mode == CNTR_MODE_R) {
+		ret = get_all_cpu_total(cntr) - *z_val;
+	} else if (mode == CNTR_MODE_W) {
+		/* A write can only zero the counter */
+		if (data == 0)
+			*z_val = get_all_cpu_total(cntr);
+		else
+			dd_dev_err(dd, "Per CPU cntrs can only be zeroed");
+	} else {
+		dd_dev_err(dd, "Invalid cntr sw cpu access mode");
+		return 0;
+	}
+
+	return ret;
+}
+
+static u64 access_sw_cpu_intr(const struct cntr_entry *entry,
+			      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return read_write_cpu(dd, &dd->z_int_counter, dd->int_counter, vl,
+			      mode, data);
+}
+
+static u64 access_sw_cpu_rcv_limit(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return read_write_cpu(dd, &dd->z_rcv_limit, dd->rcv_limit, vl,
+			      mode, data);
+}
+
+static u64 access_sw_pio_wait(const struct cntr_entry *entry,
+			      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->verbs_dev.n_piowait;
+}
+
+static u64 access_sw_pio_drain(const struct cntr_entry *entry,
+			       void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->verbs_dev.n_piodrain;
+}
+
+static u64 access_sw_ctx0_seq_drop(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->ctx0_seq_drop;
+}
+
+static u64 access_sw_vtx_wait(const struct cntr_entry *entry,
+			      void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->verbs_dev.n_txwait;
+}
+
+static u64 access_sw_kmem_wait(const struct cntr_entry *entry,
+			       void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->verbs_dev.n_kmem_wait;
+}
+
+static u64 access_sw_send_schedule(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return read_write_cpu(dd, &dd->z_send_schedule, dd->send_schedule, vl,
+			      mode, data);
+}
+
+/* Software counters for the error status bits within MISC_ERR_STATUS */
+static u64 access_misc_pll_lock_fail_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[12];
+}
+
+static u64 access_misc_mbist_fail_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[11];
+}
+
+static u64 access_misc_invalid_eep_cmd_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[10];
+}
+
+static u64 access_misc_efuse_done_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[9];
+}
+
+static u64 access_misc_efuse_write_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[8];
+}
+
+static u64 access_misc_efuse_read_bad_addr_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[7];
+}
+
+static u64 access_misc_efuse_csr_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[6];
+}
+
+static u64 access_misc_fw_auth_failed_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[5];
+}
+
+static u64 access_misc_key_mismatch_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[4];
+}
+
+static u64 access_misc_sbus_write_failed_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[3];
+}
+
+static u64 access_misc_csr_write_bad_addr_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[2];
+}
+
+static u64 access_misc_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[1];
+}
+
+static u64 access_misc_csr_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->misc_err_status_cnt[0];
+}
+
+/*
+ * Software counter for the aggregate of
+ * individual CceErrStatus counters
+ */
+static u64 access_sw_cce_err_status_aggregated_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_cce_err_status_aggregate;
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within CceErrStatus
+ */
+static u64 access_cce_msix_csr_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[40];
+}
+
+static u64 access_cce_int_map_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[39];
+}
+
+static u64 access_cce_int_map_cor_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[38];
+}
+
+static u64 access_cce_msix_table_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[37];
+}
+
+static u64 access_cce_msix_table_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[36];
+}
+
+static u64 access_cce_rxdma_conv_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[35];
+}
+
+static u64 access_cce_rcpl_async_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[34];
+}
+
+static u64 access_cce_seg_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[33];
+}
+
+static u64 access_cce_seg_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl, int mode,
+						u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[32];
+}
+
+static u64 access_la_triggered_cnt(const struct cntr_entry *entry,
+				   void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[31];
+}
+
+static u64 access_cce_trgt_cpl_timeout_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[30];
+}
+
+static u64 access_pcic_receive_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[29];
+}
+
+static u64 access_pcic_transmit_back_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[28];
+}
+
+static u64 access_pcic_transmit_front_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[27];
+}
+
+static u64 access_pcic_cpl_dat_q_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[26];
+}
+
+static u64 access_pcic_cpl_hd_q_unc_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[25];
+}
+
+static u64 access_pcic_post_dat_q_unc_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[24];
+}
+
+static u64 access_pcic_post_hd_q_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[23];
+}
+
+static u64 access_pcic_retry_sot_mem_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[22];
+}
+
+static u64 access_pcic_retry_mem_unc_err(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[21];
+}
+
+static u64 access_pcic_n_post_dat_q_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[20];
+}
+
+static u64 access_pcic_n_post_h_q_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[19];
+}
+
+static u64 access_pcic_cpl_dat_q_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[18];
+}
+
+static u64 access_pcic_cpl_hd_q_cor_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[17];
+}
+
+static u64 access_pcic_post_dat_q_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[16];
+}
+
+static u64 access_pcic_post_hd_q_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[15];
+}
+
+static u64 access_pcic_retry_sot_mem_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[14];
+}
+
+static u64 access_pcic_retry_mem_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[13];
+}
+
+static u64 access_cce_cli1_async_fifo_dbg_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[12];
+}
+
+static u64 access_cce_cli1_async_fifo_rxdma_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[11];
+}
+
+static u64 access_cce_cli1_async_fifo_sdma_hd_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[10];
+}
+
+static u64 access_cce_cl1_async_fifo_pio_crdt_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[9];
+}
+
+static u64 access_cce_cli2_async_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[8];
+}
+
+static u64 access_cce_csr_cfg_bus_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[7];
+}
+
+static u64 access_cce_cli0_async_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[6];
+}
+
+static u64 access_cce_rspd_data_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[5];
+}
+
+static u64 access_cce_trgt_access_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[4];
+}
+
+static u64 access_cce_trgt_async_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[3];
+}
+
+static u64 access_cce_csr_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[2];
+}
+
+static u64 access_cce_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[1];
+}
+
+static u64 access_ccs_csr_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->cce_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within RcvErrStatus
+ */
+static u64 access_rx_csr_parity_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[63];
+}
+
+static u64 access_rx_csr_write_bad_addr_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[62];
+}
+
+static u64 access_rx_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[61];
+}
+
+static u64 access_rx_dma_csr_unc_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[60];
+}
+
+static u64 access_rx_dma_dq_fsm_encoding_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[59];
+}
+
+static u64 access_rx_dma_eq_fsm_encoding_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[58];
+}
+
+static u64 access_rx_dma_csr_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[57];
+}
+
+static u64 access_rx_rbuf_data_cor_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[56];
+}
+
+static u64 access_rx_rbuf_data_unc_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[55];
+}
+
+static u64 access_rx_dma_data_fifo_rd_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[54];
+}
+
+static u64 access_rx_dma_data_fifo_rd_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[53];
+}
+
+static u64 access_rx_dma_hdr_fifo_rd_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[52];
+}
+
+static u64 access_rx_dma_hdr_fifo_rd_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[51];
+}
+
+static u64 access_rx_rbuf_desc_part2_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[50];
+}
+
+static u64 access_rx_rbuf_desc_part2_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[49];
+}
+
+static u64 access_rx_rbuf_desc_part1_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[48];
+}
+
+static u64 access_rx_rbuf_desc_part1_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[47];
+}
+
+static u64 access_rx_hq_intr_fsm_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[46];
+}
+
+static u64 access_rx_hq_intr_csr_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[45];
+}
+
+static u64 access_rx_lookup_csr_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[44];
+}
+
+static u64 access_rx_lookup_rcv_array_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[43];
+}
+
+static u64 access_rx_lookup_rcv_array_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[42];
+}
+
+static u64 access_rx_lookup_des_part2_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[41];
+}
+
+static u64 access_rx_lookup_des_part1_unc_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[40];
+}
+
+static u64 access_rx_lookup_des_part1_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[39];
+}
+
+static u64 access_rx_rbuf_next_free_buf_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[38];
+}
+
+static u64 access_rx_rbuf_next_free_buf_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[37];
+}
+
+static u64 access_rbuf_fl_init_wr_addr_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[36];
+}
+
+static u64 access_rx_rbuf_fl_initdone_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[35];
+}
+
+static u64 access_rx_rbuf_fl_write_addr_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[34];
+}
+
+static u64 access_rx_rbuf_fl_rd_addr_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[33];
+}
+
+static u64 access_rx_rbuf_empty_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[32];
+}
+
+static u64 access_rx_rbuf_full_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[31];
+}
+
+static u64 access_rbuf_bad_lookup_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[30];
+}
+
+static u64 access_rbuf_ctx_id_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[29];
+}
+
+static u64 access_rbuf_csr_qeopdw_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[28];
+}
+
+static u64 access_rx_rbuf_csr_q_num_of_pkt_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[27];
+}
+
+static u64 access_rx_rbuf_csr_q_t1_ptr_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[26];
+}
+
+static u64 access_rx_rbuf_csr_q_hd_ptr_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[25];
+}
+
+static u64 access_rx_rbuf_csr_q_vld_bit_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[24];
+}
+
+static u64 access_rx_rbuf_csr_q_next_buf_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[23];
+}
+
+static u64 access_rx_rbuf_csr_q_ent_cnt_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[22];
+}
+
+static u64 access_rx_rbuf_csr_q_head_buf_num_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[21];
+}
+
+static u64 access_rx_rbuf_block_list_read_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[20];
+}
+
+static u64 access_rx_rbuf_block_list_read_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[19];
+}
+
+static u64 access_rx_rbuf_lookup_des_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[18];
+}
+
+static u64 access_rx_rbuf_lookup_des_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[17];
+}
+
+static u64 access_rx_rbuf_lookup_des_reg_unc_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[16];
+}
+
+static u64 access_rx_rbuf_lookup_des_reg_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[15];
+}
+
+static u64 access_rx_rbuf_free_list_cor_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[14];
+}
+
+static u64 access_rx_rbuf_free_list_unc_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[13];
+}
+
+static u64 access_rx_rcv_fsm_encoding_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[12];
+}
+
+static u64 access_rx_dma_flag_cor_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[11];
+}
+
+static u64 access_rx_dma_flag_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[10];
+}
+
+static u64 access_rx_dc_sop_eop_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[9];
+}
+
+static u64 access_rx_rcv_csr_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[8];
+}
+
+static u64 access_rx_rcv_qp_map_table_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[7];
+}
+
+static u64 access_rx_rcv_qp_map_table_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[6];
+}
+
+static u64 access_rx_rcv_data_cor_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[5];
+}
+
+static u64 access_rx_rcv_data_unc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[4];
+}
+
+static u64 access_rx_rcv_hdr_cor_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[3];
+}
+
+static u64 access_rx_rcv_hdr_unc_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[2];
+}
+
+static u64 access_rx_dc_intf_parity_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[1];
+}
+
+static u64 access_rx_dma_csr_cor_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->rcv_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendPioErrStatus
+ */
+static u64 access_pio_pec_sop_head_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[35];
+}
+
+static u64 access_pio_pcc_sop_head_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[34];
+}
+
+static u64 access_pio_last_returned_cnt_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[33];
+}
+
+static u64 access_pio_current_free_cnt_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[32];
+}
+
+static u64 access_pio_reserved_31_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[31];
+}
+
+static u64 access_pio_reserved_30_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[30];
+}
+
+static u64 access_pio_ppmc_sop_len_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[29];
+}
+
+static u64 access_pio_ppmc_bqc_mem_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[28];
+}
+
+static u64 access_pio_vl_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[27];
+}
+
+static u64 access_pio_vlf_sop_parity_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[26];
+}
+
+static u64 access_pio_vlf_v1_len_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[25];
+}
+
+static u64 access_pio_block_qw_count_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[24];
+}
+
+static u64 access_pio_write_qw_valid_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[23];
+}
+
+static u64 access_pio_state_machine_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[22];
+}
+
+static u64 access_pio_write_data_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[21];
+}
+
+static u64 access_pio_host_addr_mem_cor_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[20];
+}
+
+static u64 access_pio_host_addr_mem_unc_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[19];
+}
+
+static u64 access_pio_pkt_evict_sm_or_arb_sm_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[18];
+}
+
+static u64 access_pio_init_sm_in_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[17];
+}
+
+static u64 access_pio_ppmc_pbl_fifo_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[16];
+}
+
+static u64 access_pio_credit_ret_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[15];
+}
+
+static u64 access_pio_v1_len_mem_bank1_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[14];
+}
+
+static u64 access_pio_v1_len_mem_bank0_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[13];
+}
+
+static u64 access_pio_v1_len_mem_bank1_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[12];
+}
+
+static u64 access_pio_v1_len_mem_bank0_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[11];
+}
+
+static u64 access_pio_sm_pkt_reset_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[10];
+}
+
+static u64 access_pio_pkt_evict_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[9];
+}
+
+static u64 access_pio_sbrdctrl_crrel_fifo_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[8];
+}
+
+static u64 access_pio_sbrdctl_crrel_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[7];
+}
+
+static u64 access_pio_pec_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[6];
+}
+
+static u64 access_pio_pcc_fifo_parity_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[5];
+}
+
+static u64 access_pio_sb_mem_fifo1_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[4];
+}
+
+static u64 access_pio_sb_mem_fifo0_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[3];
+}
+
+static u64 access_pio_csr_parity_err_cnt(const struct cntr_entry *entry,
+					 void *context, int vl, int mode,
+					 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[2];
+}
+
+static u64 access_pio_write_addr_parity_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[1];
+}
+
+static u64 access_pio_write_bad_ctxt_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_pio_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendDmaErrStatus
+ */
+static u64 access_sdma_pcie_req_tracking_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[3];
+}
+
+static u64 access_sdma_pcie_req_tracking_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[2];
+}
+
+static u64 access_sdma_csr_parity_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[1];
+}
+
+static u64 access_sdma_rpy_tag_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_dma_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendEgressErrStatus
+ */
+static u64 access_tx_read_pio_memory_csr_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[63];
+}
+
+static u64 access_tx_read_sdma_memory_csr_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[62];
+}
+
+static u64 access_tx_egress_fifo_cor_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[61];
+}
+
+static u64 access_tx_read_pio_memory_cor_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[60];
+}
+
+static u64 access_tx_read_sdma_memory_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[59];
+}
+
+static u64 access_tx_sb_hdr_cor_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[58];
+}
+
+static u64 access_tx_credit_overrun_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[57];
+}
+
+static u64 access_tx_launch_fifo8_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[56];
+}
+
+static u64 access_tx_launch_fifo7_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[55];
+}
+
+static u64 access_tx_launch_fifo6_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[54];
+}
+
+static u64 access_tx_launch_fifo5_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[53];
+}
+
+static u64 access_tx_launch_fifo4_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[52];
+}
+
+static u64 access_tx_launch_fifo3_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[51];
+}
+
+static u64 access_tx_launch_fifo2_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[50];
+}
+
+static u64 access_tx_launch_fifo1_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[49];
+}
+
+static u64 access_tx_launch_fifo0_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[48];
+}
+
+static u64 access_tx_credit_return_vl_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[47];
+}
+
+static u64 access_tx_hcrc_insertion_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[46];
+}
+
+static u64 access_tx_egress_fifo_unc_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[45];
+}
+
+static u64 access_tx_read_pio_memory_unc_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[44];
+}
+
+static u64 access_tx_read_sdma_memory_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[43];
+}
+
+static u64 access_tx_sb_hdr_unc_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[42];
+}
+
+static u64 access_tx_credit_return_partiy_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[41];
+}
+
+static u64 access_tx_launch_fifo8_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[40];
+}
+
+static u64 access_tx_launch_fifo7_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[39];
+}
+
+static u64 access_tx_launch_fifo6_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[38];
+}
+
+static u64 access_tx_launch_fifo5_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[37];
+}
+
+static u64 access_tx_launch_fifo4_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[36];
+}
+
+static u64 access_tx_launch_fifo3_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[35];
+}
+
+static u64 access_tx_launch_fifo2_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[34];
+}
+
+static u64 access_tx_launch_fifo1_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[33];
+}
+
+static u64 access_tx_launch_fifo0_unc_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[32];
+}
+
+static u64 access_tx_sdma15_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[31];
+}
+
+static u64 access_tx_sdma14_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[30];
+}
+
+static u64 access_tx_sdma13_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[29];
+}
+
+static u64 access_tx_sdma12_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[28];
+}
+
+static u64 access_tx_sdma11_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[27];
+}
+
+static u64 access_tx_sdma10_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[26];
+}
+
+static u64 access_tx_sdma9_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[25];
+}
+
+static u64 access_tx_sdma8_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[24];
+}
+
+static u64 access_tx_sdma7_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[23];
+}
+
+static u64 access_tx_sdma6_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[22];
+}
+
+static u64 access_tx_sdma5_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[21];
+}
+
+static u64 access_tx_sdma4_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[20];
+}
+
+static u64 access_tx_sdma3_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[19];
+}
+
+static u64 access_tx_sdma2_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[18];
+}
+
+static u64 access_tx_sdma1_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[17];
+}
+
+static u64 access_tx_sdma0_disallowed_packet_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[16];
+}
+
+static u64 access_tx_config_parity_err_cnt(const struct cntr_entry *entry,
+					   void *context, int vl, int mode,
+					   u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[15];
+}
+
+static u64 access_tx_sbrd_ctl_csr_parity_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[14];
+}
+
+static u64 access_tx_launch_csr_parity_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[13];
+}
+
+static u64 access_tx_illegal_vl_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[12];
+}
+
+static u64 access_tx_sbrd_ctl_state_machine_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[11];
+}
+
+static u64 access_egress_reserved_10_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[10];
+}
+
+static u64 access_egress_reserved_9_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[9];
+}
+
+static u64 access_tx_sdma_launch_intf_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[8];
+}
+
+static u64 access_tx_pio_launch_intf_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[7];
+}
+
+static u64 access_egress_reserved_6_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[6];
+}
+
+static u64 access_tx_incorrect_link_state_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[5];
+}
+
+static u64 access_tx_linkdown_err_cnt(const struct cntr_entry *entry,
+				      void *context, int vl, int mode,
+				      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[4];
+}
+
+static u64 access_tx_egress_fifi_underrun_or_parity_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[3];
+}
+
+static u64 access_egress_reserved_2_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[2];
+}
+
+static u64 access_tx_pkt_integrity_mem_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[1];
+}
+
+static u64 access_tx_pkt_integrity_mem_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_egress_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendErrStatus
+ */
+static u64 access_send_csr_write_bad_addr_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_err_status_cnt[2];
+}
+
+static u64 access_send_csr_read_bad_addr_err_cnt(const struct cntr_entry *entry,
+						 void *context, int vl,
+						 int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_err_status_cnt[1];
+}
+
+static u64 access_send_csr_parity_cnt(const struct cntr_entry *entry,
+				      void *context, int vl, int mode,
+				      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->send_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendCtxtErrStatus
+ */
+static u64 access_pio_write_out_of_bounds_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[4];
+}
+
+static u64 access_pio_write_overflow_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[3];
+}
+
+static u64 access_pio_write_crosses_boundary_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[2];
+}
+
+static u64 access_pio_disallowed_packet_err_cnt(const struct cntr_entry *entry,
+						void *context, int vl,
+						int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[1];
+}
+
+static u64 access_pio_inconsistent_sop_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl, int mode,
+					       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_ctxt_err_status_cnt[0];
+}
+
+/*
+ * Software counters corresponding to each of the
+ * error status bits within SendDmaEngErrStatus
+ */
+static u64 access_sdma_header_request_fifo_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[23];
+}
+
+static u64 access_sdma_header_storage_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[22];
+}
+
+static u64 access_sdma_packet_tracking_cor_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[21];
+}
+
+static u64 access_sdma_assembly_cor_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[20];
+}
+
+static u64 access_sdma_desc_table_cor_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[19];
+}
+
+static u64 access_sdma_header_request_fifo_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[18];
+}
+
+static u64 access_sdma_header_storage_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[17];
+}
+
+static u64 access_sdma_packet_tracking_unc_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[16];
+}
+
+static u64 access_sdma_assembly_unc_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[15];
+}
+
+static u64 access_sdma_desc_table_unc_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[14];
+}
+
+static u64 access_sdma_timeout_err_cnt(const struct cntr_entry *entry,
+				       void *context, int vl, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[13];
+}
+
+static u64 access_sdma_header_length_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[12];
+}
+
+static u64 access_sdma_header_address_err_cnt(const struct cntr_entry *entry,
+					      void *context, int vl, int mode,
+					      u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[11];
+}
+
+static u64 access_sdma_header_select_err_cnt(const struct cntr_entry *entry,
+					     void *context, int vl, int mode,
+					     u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[10];
+}
+
+static u64 access_sdma_reserved_9_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[9];
+}
+
+static u64 access_sdma_packet_desc_overflow_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[8];
+}
+
+static u64 access_sdma_length_mismatch_err_cnt(const struct cntr_entry *entry,
+					       void *context, int vl,
+					       int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[7];
+}
+
+static u64 access_sdma_halt_err_cnt(const struct cntr_entry *entry,
+				    void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[6];
+}
+
+static u64 access_sdma_mem_read_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[5];
+}
+
+static u64 access_sdma_first_desc_err_cnt(const struct cntr_entry *entry,
+					  void *context, int vl, int mode,
+					  u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[4];
+}
+
+static u64 access_sdma_tail_out_of_bounds_err_cnt(
+				const struct cntr_entry *entry,
+				void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[3];
+}
+
+static u64 access_sdma_too_long_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[2];
+}
+
+static u64 access_sdma_gen_mismatch_err_cnt(const struct cntr_entry *entry,
+					    void *context, int vl, int mode,
+					    u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[1];
+}
+
+static u64 access_sdma_wrong_dw_err_cnt(const struct cntr_entry *entry,
+					void *context, int vl, int mode,
+					u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	return dd->sw_send_dma_eng_err_status_cnt[0];
+}
+
+static u64 access_dc_rcv_err_cnt(const struct cntr_entry *entry,
+				 void *context, int vl, int mode,
+				 u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	u64 val = 0;
+	u64 csr = entry->csr;
+
+	val = read_write_csr(dd, csr, mode, data);
+	if (mode == CNTR_MODE_R) {
+		val = val > CNTR_MAX - dd->sw_rcv_bypass_packet_errors ?
+			CNTR_MAX : val + dd->sw_rcv_bypass_packet_errors;
+	} else if (mode == CNTR_MODE_W) {
+		dd->sw_rcv_bypass_packet_errors = 0;
+	} else {
+		dd_dev_err(dd, "Invalid cntr register access mode");
+		return 0;
+	}
+	return val;
+}
+
+#define def_access_sw_cpu(cntr) \
+static u64 access_sw_cpu_##cntr(const struct cntr_entry *entry,		      \
+			      void *context, int vl, int mode, u64 data)      \
+{									      \
+	struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context;	      \
+	return read_write_cpu(ppd->dd, &ppd->ibport_data.rvp.z_ ##cntr,	      \
+			      ppd->ibport_data.rvp.cntr, vl,		      \
+			      mode, data);				      \
+}
+
+def_access_sw_cpu(rc_acks);
+def_access_sw_cpu(rc_qacks);
+def_access_sw_cpu(rc_delayed_comp);
+
+#define def_access_ibp_counter(cntr) \
+static u64 access_ibp_##cntr(const struct cntr_entry *entry,		      \
+				void *context, int vl, int mode, u64 data)    \
+{									      \
+	struct hfi2_pportdata *ppd = (struct hfi2_pportdata *)context;	      \
+									      \
+	if (vl != CNTR_INVALID_VL)					      \
+		return 0;						      \
+									      \
+	return read_write_sw(ppd->dd, &ppd->ibport_data.rvp.n_ ##cntr,	      \
+			     mode, data);				      \
+}
+
+def_access_ibp_counter(loop_pkts);
+def_access_ibp_counter(rc_resends);
+def_access_ibp_counter(rnr_naks);
+def_access_ibp_counter(other_naks);
+def_access_ibp_counter(rc_timeouts);
+def_access_ibp_counter(pkt_drops);
+def_access_ibp_counter(dmawait);
+def_access_ibp_counter(rc_seqnak);
+def_access_ibp_counter(rc_dupreq);
+def_access_ibp_counter(rdma_seq);
+def_access_ibp_counter(unaligned);
+def_access_ibp_counter(seq_naks);
+def_access_ibp_counter(rc_crwaits);
+
+struct cntr_entry shared_dev_cntrs[SHARED_DEV_CNTR_LAST] = {
+[C_CCE_PCI_CR_ST] = CCE_PERF_DEV_CNTR_ELEM("CcePciCrSt",
+			CCE_PCIE_POSTED_CRDT_STALL_CNT, CNTR_NORMAL),
+[C_CCE_SDMA_INT] = CCE_INT_DEV_CNTR_ELEM(CceSdmaInt, CCE_SDMA_INT_CNT,
+			CNTR_NORMAL),
+[C_CCE_MISC_INT] = CCE_INT_DEV_CNTR_ELEM(CceMiscInt, CCE_MISC_INT_CNT,
+			CNTR_NORMAL),
+[C_CCE_RCV_AV_INT] = CCE_INT_DEV_CNTR_ELEM(CceRcvAvInt, CCE_RCV_AVAIL_INT_CNT,
+			CNTR_NORMAL),
+[C_CCE_RCV_URG_INT] = CCE_INT_DEV_CNTR_ELEM(CceRcvUrgInt,
+			CCE_RCV_URGENT_INT_CNT,	CNTR_NORMAL),
+[C_CCE_SEND_CR_INT] = CCE_INT_DEV_CNTR_ELEM(CceSndCrInt,
+			CCE_SEND_CREDIT_INT_CNT, CNTR_NORMAL),
+[C_SW_CPU_INTR] = CNTR_ELEM("Intr", 0, 0, CNTR_NORMAL,
+			    access_sw_cpu_intr),
+[C_SW_CPU_RCV_LIM] = CNTR_ELEM("RcvLimit", 0, 0, CNTR_NORMAL,
+			    access_sw_cpu_rcv_limit),
+[C_SW_CTX0_SEQ_DROP] = CNTR_ELEM("SeqDrop0", 0, 0, CNTR_NORMAL,
+			    access_sw_ctx0_seq_drop),
+[C_SW_VTX_WAIT] = CNTR_ELEM("vTxWait", 0, 0, CNTR_NORMAL,
+			    access_sw_vtx_wait),
+[C_SW_PIO_WAIT] = CNTR_ELEM("PioWait", 0, 0, CNTR_NORMAL,
+			    access_sw_pio_wait),
+[C_SW_PIO_DRAIN] = CNTR_ELEM("PioDrain", 0, 0, CNTR_NORMAL,
+			    access_sw_pio_drain),
+[C_SW_KMEM_WAIT] = CNTR_ELEM("KmemWait", 0, 0, CNTR_NORMAL,
+			    access_sw_kmem_wait),
+[C_SW_TID_WAIT] = CNTR_ELEM("TidWait", 0, 0, CNTR_NORMAL,
+			    hfi2_access_sw_tid_wait),
+[C_SW_SEND_SCHED] = CNTR_ELEM("SendSched", 0, 0, CNTR_NORMAL,
+			    access_sw_send_schedule),
+[C_SDMA_DESC_FETCHED_CNT] = CNTR_ELEM("SDEDscFdCn",
+				      0, 0,
+				      CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+				      dev_access_sde_desc_fetched_cnt),
+[C_SDMA_INT_CNT] = CNTR_ELEM("SDMAInt", 0, 0,
+			     CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+			     access_sde_int_cnt),
+[C_SDMA_ERR_CNT] = CNTR_ELEM("SDMAErrCt", 0, 0,
+			     CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+			     access_sde_err_cnt),
+[C_SDMA_IDLE_INT_CNT] = CNTR_ELEM("SDMAIdInt", 0, 0,
+				  CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+				  access_sde_idle_int_cnt),
+[C_SDMA_PROGRESS_INT_CNT] = CNTR_ELEM("SDMAPrIntCn", 0, 0,
+				      CNTR_NORMAL | CNTR_32BIT | CNTR_SDMA,
+				      access_sde_progress_int_cnt),
+/* MISC_ERR_STATUS */
+[C_MISC_PLL_LOCK_FAIL_ERR] = CNTR_ELEM("MISC_PLL_LOCK_FAIL_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_pll_lock_fail_err_cnt),
+[C_MISC_MBIST_FAIL_ERR] = CNTR_ELEM("MISC_MBIST_FAIL_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_mbist_fail_err_cnt),
+[C_MISC_INVALID_EEP_CMD_ERR] = CNTR_ELEM("MISC_INVALID_EEP_CMD_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_invalid_eep_cmd_err_cnt),
+[C_MISC_EFUSE_DONE_PARITY_ERR] = CNTR_ELEM("MISC_EFUSE_DONE_PARITY_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_efuse_done_parity_err_cnt),
+[C_MISC_EFUSE_WRITE_ERR] = CNTR_ELEM("MISC_EFUSE_WRITE_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_efuse_write_err_cnt),
+[C_MISC_EFUSE_READ_BAD_ADDR_ERR] = CNTR_ELEM("MISC_EFUSE_READ_BAD_ADDR_ERR", 0,
+				0, CNTR_NORMAL,
+				access_misc_efuse_read_bad_addr_err_cnt),
+[C_MISC_EFUSE_CSR_PARITY_ERR] = CNTR_ELEM("MISC_EFUSE_CSR_PARITY_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_efuse_csr_parity_err_cnt),
+[C_MISC_FW_AUTH_FAILED_ERR] = CNTR_ELEM("MISC_FW_AUTH_FAILED_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_fw_auth_failed_err_cnt),
+[C_MISC_KEY_MISMATCH_ERR] = CNTR_ELEM("MISC_KEY_MISMATCH_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_key_mismatch_err_cnt),
+[C_MISC_SBUS_WRITE_FAILED_ERR] = CNTR_ELEM("MISC_SBUS_WRITE_FAILED_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_sbus_write_failed_err_cnt),
+[C_MISC_CSR_WRITE_BAD_ADDR_ERR] = CNTR_ELEM("MISC_CSR_WRITE_BAD_ADDR_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_csr_write_bad_addr_err_cnt),
+[C_MISC_CSR_READ_BAD_ADDR_ERR] = CNTR_ELEM("MISC_CSR_READ_BAD_ADDR_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_csr_read_bad_addr_err_cnt),
+[C_MISC_CSR_PARITY_ERR] = CNTR_ELEM("MISC_CSR_PARITY_ERR", 0, 0,
+				CNTR_NORMAL,
+				access_misc_csr_parity_err_cnt),
+/* CceErrStatus */
+[C_CCE_ERR_STATUS_AGGREGATED_CNT] = CNTR_ELEM("CceErrStatusAggregatedCnt", 0, 0,
+				CNTR_NORMAL,
+				access_sw_cce_err_status_aggregated_cnt),
+[C_CCE_MSIX_CSR_PARITY_ERR] = CNTR_ELEM("CceMsixCsrParityErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_msix_csr_parity_err_cnt),
+[C_CCE_INT_MAP_UNC_ERR] = CNTR_ELEM("CceIntMapUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_int_map_unc_err_cnt),
+[C_CCE_INT_MAP_COR_ERR] = CNTR_ELEM("CceIntMapCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_int_map_cor_err_cnt),
+[C_CCE_MSIX_TABLE_UNC_ERR] = CNTR_ELEM("CceMsixTableUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_msix_table_unc_err_cnt),
+[C_CCE_MSIX_TABLE_COR_ERR] = CNTR_ELEM("CceMsixTableCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_msix_table_cor_err_cnt),
+[C_CCE_RXDMA_CONV_FIFO_PARITY_ERR] = CNTR_ELEM("CceRxdmaConvFifoParityErr", 0,
+				0, CNTR_NORMAL,
+				access_cce_rxdma_conv_fifo_parity_err_cnt),
+[C_CCE_RCPL_ASYNC_FIFO_PARITY_ERR] = CNTR_ELEM("CceRcplAsyncFifoParityErr", 0,
+				0, CNTR_NORMAL,
+				access_cce_rcpl_async_fifo_parity_err_cnt),
+[C_CCE_SEG_WRITE_BAD_ADDR_ERR] = CNTR_ELEM("CceSegWriteBadAddrErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_seg_write_bad_addr_err_cnt),
+[C_CCE_SEG_READ_BAD_ADDR_ERR] = CNTR_ELEM("CceSegReadBadAddrErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_seg_read_bad_addr_err_cnt),
+[C_LA_TRIGGERED] = CNTR_ELEM("Cce LATriggered", 0, 0,
+				CNTR_NORMAL,
+				access_la_triggered_cnt),
+[C_CCE_TRGT_CPL_TIMEOUT_ERR] = CNTR_ELEM("CceTrgtCplTimeoutErr", 0, 0,
+				CNTR_NORMAL,
+				access_cce_trgt_cpl_timeout_err_cnt),
+[C_PCIC_RECEIVE_PARITY_ERR] = CNTR_ELEM("PcicReceiveParityErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_receive_parity_err_cnt),
+[C_PCIC_TRANSMIT_BACK_PARITY_ERR] = CNTR_ELEM("PcicTransmitBackParityErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_transmit_back_parity_err_cnt),
+[C_PCIC_TRANSMIT_FRONT_PARITY_ERR] = CNTR_ELEM("PcicTransmitFrontParityErr", 0,
+				0, CNTR_NORMAL,
+				access_pcic_transmit_front_parity_err_cnt),
+[C_PCIC_CPL_DAT_Q_UNC_ERR] = CNTR_ELEM("PcicCplDatQUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_cpl_dat_q_unc_err_cnt),
+[C_PCIC_CPL_HD_Q_UNC_ERR] = CNTR_ELEM("PcicCplHdQUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_cpl_hd_q_unc_err_cnt),
+[C_PCIC_POST_DAT_Q_UNC_ERR] = CNTR_ELEM("PcicPostDatQUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_post_dat_q_unc_err_cnt),
+[C_PCIC_POST_HD_Q_UNC_ERR] = CNTR_ELEM("PcicPostHdQUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_post_hd_q_unc_err_cnt),
+[C_PCIC_RETRY_SOT_MEM_UNC_ERR] = CNTR_ELEM("PcicRetrySotMemUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_retry_sot_mem_unc_err_cnt),
+[C_PCIC_RETRY_MEM_UNC_ERR] = CNTR_ELEM("PcicRetryMemUncErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_retry_mem_unc_err),
+[C_PCIC_N_POST_DAT_Q_PARITY_ERR] = CNTR_ELEM("PcicNPostDatQParityErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_n_post_dat_q_parity_err_cnt),
+[C_PCIC_N_POST_H_Q_PARITY_ERR] = CNTR_ELEM("PcicNPostHQParityErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_n_post_h_q_parity_err_cnt),
+[C_PCIC_CPL_DAT_Q_COR_ERR] = CNTR_ELEM("PcicCplDatQCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_cpl_dat_q_cor_err_cnt),
+[C_PCIC_CPL_HD_Q_COR_ERR] = CNTR_ELEM("PcicCplHdQCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_cpl_hd_q_cor_err_cnt),
+[C_PCIC_POST_DAT_Q_COR_ERR] = CNTR_ELEM("PcicPostDatQCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_post_dat_q_cor_err_cnt),
+[C_PCIC_POST_HD_Q_COR_ERR] = CNTR_ELEM("PcicPostHdQCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_post_hd_q_cor_err_cnt),
+[C_PCIC_RETRY_SOT_MEM_COR_ERR] = CNTR_ELEM("PcicRetrySotMemCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_retry_sot_mem_cor_err_cnt),
+[C_PCIC_RETRY_MEM_COR_ERR] = CNTR_ELEM("PcicRetryMemCorErr", 0, 0,
+				CNTR_NORMAL,
+				access_pcic_retry_mem_cor_err_cnt),
+[C_CCE_CLI1_ASYNC_FIFO_DBG_PARITY_ERR] = CNTR_ELEM(
+				"CceCli1AsyncFifoDbgParityError", 0, 0,
+				CNTR_NORMAL,
+				access_cce_cli1_async_fifo_dbg_parity_err_cnt),
+[C_CCE_CLI1_ASYNC_FIFO_RXDMA_PARITY_ERR] = CNTR_ELEM(
+				"CceCli1AsyncFifoRxdmaParityError", 0, 0,
+				CNTR_NORMAL,
+				access_cce_cli1_async_fifo_rxdma_parity_err_cnt
+				),
+[C_CCE_CLI1_ASYNC_FIFO_SDMA_HD_PARITY_ERR] = CNTR_ELEM(
+			"CceCli1AsyncFifoSdmaHdParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_cce_cli1_async_fifo_sdma_hd_parity_err_cnt),
+[C_CCE_CLI1_ASYNC_FIFO_PIO_CRDT_PARITY_ERR] = CNTR_ELEM(
+			"CceCli1AsyncFifoPioCrdtParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_cce_cl1_async_fifo_pio_crdt_parity_err_cnt),
+[C_CCE_CLI2_ASYNC_FIFO_PARITY_ERR] = CNTR_ELEM("CceCli2AsyncFifoParityErr", 0,
+			0, CNTR_NORMAL,
+			access_cce_cli2_async_fifo_parity_err_cnt),
+[C_CCE_CSR_CFG_BUS_PARITY_ERR] = CNTR_ELEM("CceCsrCfgBusParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_cce_csr_cfg_bus_parity_err_cnt),
+[C_CCE_CLI0_ASYNC_FIFO_PARTIY_ERR] = CNTR_ELEM("CceCli0AsyncFifoParityErr", 0,
+			0, CNTR_NORMAL,
+			access_cce_cli0_async_fifo_parity_err_cnt),
+[C_CCE_RSPD_DATA_PARITY_ERR] = CNTR_ELEM("CceRspdDataParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_cce_rspd_data_parity_err_cnt),
+[C_CCE_TRGT_ACCESS_ERR] = CNTR_ELEM("CceTrgtAccessErr", 0, 0,
+			CNTR_NORMAL,
+			access_cce_trgt_access_err_cnt),
+[C_CCE_TRGT_ASYNC_FIFO_PARITY_ERR] = CNTR_ELEM("CceTrgtAsyncFifoParityErr", 0,
+			0, CNTR_NORMAL,
+			access_cce_trgt_async_fifo_parity_err_cnt),
+[C_CCE_CSR_WRITE_BAD_ADDR_ERR] = CNTR_ELEM("CceCsrWriteBadAddrErr", 0, 0,
+			CNTR_NORMAL,
+			access_cce_csr_write_bad_addr_err_cnt),
+[C_CCE_CSR_READ_BAD_ADDR_ERR] = CNTR_ELEM("CceCsrReadBadAddrErr", 0, 0,
+			CNTR_NORMAL,
+			access_cce_csr_read_bad_addr_err_cnt),
+[C_CCE_CSR_PARITY_ERR] = CNTR_ELEM("CceCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_ccs_csr_parity_err_cnt),
+
+/* RcvErrStatus */
+[C_RX_CSR_PARITY_ERR] = CNTR_ELEM("RxCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_csr_parity_err_cnt),
+[C_RX_CSR_WRITE_BAD_ADDR_ERR] = CNTR_ELEM("RxCsrWriteBadAddrErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_csr_write_bad_addr_err_cnt),
+[C_RX_CSR_READ_BAD_ADDR_ERR] = CNTR_ELEM("RxCsrReadBadAddrErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_csr_read_bad_addr_err_cnt),
+[C_RX_DMA_CSR_UNC_ERR] = CNTR_ELEM("RxDmaCsrUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_csr_unc_err_cnt),
+[C_RX_DMA_DQ_FSM_ENCODING_ERR] = CNTR_ELEM("RxDmaDqFsmEncodingErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_dq_fsm_encoding_err_cnt),
+[C_RX_DMA_EQ_FSM_ENCODING_ERR] = CNTR_ELEM("RxDmaEqFsmEncodingErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_eq_fsm_encoding_err_cnt),
+[C_RX_DMA_CSR_PARITY_ERR] = CNTR_ELEM("RxDmaCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_csr_parity_err_cnt),
+[C_RX_RBUF_DATA_COR_ERR] = CNTR_ELEM("RxRbufDataCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_data_cor_err_cnt),
+[C_RX_RBUF_DATA_UNC_ERR] = CNTR_ELEM("RxRbufDataUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_data_unc_err_cnt),
+[C_RX_DMA_DATA_FIFO_RD_COR_ERR] = CNTR_ELEM("RxDmaDataFifoRdCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_data_fifo_rd_cor_err_cnt),
+[C_RX_DMA_DATA_FIFO_RD_UNC_ERR] = CNTR_ELEM("RxDmaDataFifoRdUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_data_fifo_rd_unc_err_cnt),
+[C_RX_DMA_HDR_FIFO_RD_COR_ERR] = CNTR_ELEM("RxDmaHdrFifoRdCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_hdr_fifo_rd_cor_err_cnt),
+[C_RX_DMA_HDR_FIFO_RD_UNC_ERR] = CNTR_ELEM("RxDmaHdrFifoRdUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_hdr_fifo_rd_unc_err_cnt),
+[C_RX_RBUF_DESC_PART2_COR_ERR] = CNTR_ELEM("RxRbufDescPart2CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_desc_part2_cor_err_cnt),
+[C_RX_RBUF_DESC_PART2_UNC_ERR] = CNTR_ELEM("RxRbufDescPart2UncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_desc_part2_unc_err_cnt),
+[C_RX_RBUF_DESC_PART1_COR_ERR] = CNTR_ELEM("RxRbufDescPart1CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_desc_part1_cor_err_cnt),
+[C_RX_RBUF_DESC_PART1_UNC_ERR] = CNTR_ELEM("RxRbufDescPart1UncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_desc_part1_unc_err_cnt),
+[C_RX_HQ_INTR_FSM_ERR] = CNTR_ELEM("RxHqIntrFsmErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_hq_intr_fsm_err_cnt),
+[C_RX_HQ_INTR_CSR_PARITY_ERR] = CNTR_ELEM("RxHqIntrCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_hq_intr_csr_parity_err_cnt),
+[C_RX_LOOKUP_CSR_PARITY_ERR] = CNTR_ELEM("RxLookupCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_lookup_csr_parity_err_cnt),
+[C_RX_LOOKUP_RCV_ARRAY_COR_ERR] = CNTR_ELEM("RxLookupRcvArrayCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_lookup_rcv_array_cor_err_cnt),
+[C_RX_LOOKUP_RCV_ARRAY_UNC_ERR] = CNTR_ELEM("RxLookupRcvArrayUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_lookup_rcv_array_unc_err_cnt),
+[C_RX_LOOKUP_DES_PART2_PARITY_ERR] = CNTR_ELEM("RxLookupDesPart2ParityErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_lookup_des_part2_parity_err_cnt),
+[C_RX_LOOKUP_DES_PART1_UNC_COR_ERR] = CNTR_ELEM("RxLookupDesPart1UncCorErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_lookup_des_part1_unc_cor_err_cnt),
+[C_RX_LOOKUP_DES_PART1_UNC_ERR] = CNTR_ELEM("RxLookupDesPart1UncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_lookup_des_part1_unc_err_cnt),
+[C_RX_RBUF_NEXT_FREE_BUF_COR_ERR] = CNTR_ELEM("RxRbufNextFreeBufCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_next_free_buf_cor_err_cnt),
+[C_RX_RBUF_NEXT_FREE_BUF_UNC_ERR] = CNTR_ELEM("RxRbufNextFreeBufUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_next_free_buf_unc_err_cnt),
+[C_RX_RBUF_FL_INIT_WR_ADDR_PARITY_ERR] = CNTR_ELEM(
+			"RxRbufFlInitWrAddrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rbuf_fl_init_wr_addr_parity_err_cnt),
+[C_RX_RBUF_FL_INITDONE_PARITY_ERR] = CNTR_ELEM("RxRbufFlInitdoneParityErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_rbuf_fl_initdone_parity_err_cnt),
+[C_RX_RBUF_FL_WRITE_ADDR_PARITY_ERR] = CNTR_ELEM("RxRbufFlWrAddrParityErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_rbuf_fl_write_addr_parity_err_cnt),
+[C_RX_RBUF_FL_RD_ADDR_PARITY_ERR] = CNTR_ELEM("RxRbufFlRdAddrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_fl_rd_addr_parity_err_cnt),
+[C_RX_RBUF_EMPTY_ERR] = CNTR_ELEM("RxRbufEmptyErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_empty_err_cnt),
+[C_RX_RBUF_FULL_ERR] = CNTR_ELEM("RxRbufFullErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_full_err_cnt),
+[C_RX_RBUF_BAD_LOOKUP_ERR] = CNTR_ELEM("RxRBufBadLookupErr", 0, 0,
+			CNTR_NORMAL,
+			access_rbuf_bad_lookup_err_cnt),
+[C_RX_RBUF_CTX_ID_PARITY_ERR] = CNTR_ELEM("RxRbufCtxIdParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rbuf_ctx_id_parity_err_cnt),
+[C_RX_RBUF_CSR_QEOPDW_PARITY_ERR] = CNTR_ELEM("RxRbufCsrQEOPDWParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rbuf_csr_qeopdw_parity_err_cnt),
+[C_RX_RBUF_CSR_Q_NUM_OF_PKT_PARITY_ERR] = CNTR_ELEM(
+			"RxRbufCsrQNumOfPktParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_csr_q_num_of_pkt_parity_err_cnt),
+[C_RX_RBUF_CSR_Q_T1_PTR_PARITY_ERR] = CNTR_ELEM(
+			"RxRbufCsrQTlPtrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_csr_q_t1_ptr_parity_err_cnt),
+[C_RX_RBUF_CSR_Q_HD_PTR_PARITY_ERR] = CNTR_ELEM("RxRbufCsrQHdPtrParityErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_rbuf_csr_q_hd_ptr_parity_err_cnt),
+[C_RX_RBUF_CSR_Q_VLD_BIT_PARITY_ERR] = CNTR_ELEM("RxRbufCsrQVldBitParityErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_rbuf_csr_q_vld_bit_parity_err_cnt),
+[C_RX_RBUF_CSR_Q_NEXT_BUF_PARITY_ERR] = CNTR_ELEM("RxRbufCsrQNextBufParityErr",
+			0, 0, CNTR_NORMAL,
+			access_rx_rbuf_csr_q_next_buf_parity_err_cnt),
+[C_RX_RBUF_CSR_Q_ENT_CNT_PARITY_ERR] = CNTR_ELEM("RxRbufCsrQEntCntParityErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_rbuf_csr_q_ent_cnt_parity_err_cnt),
+[C_RX_RBUF_CSR_Q_HEAD_BUF_NUM_PARITY_ERR] = CNTR_ELEM(
+			"RxRbufCsrQHeadBufNumParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_csr_q_head_buf_num_parity_err_cnt),
+[C_RX_RBUF_BLOCK_LIST_READ_COR_ERR] = CNTR_ELEM("RxRbufBlockListReadCorErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_rbuf_block_list_read_cor_err_cnt),
+[C_RX_RBUF_BLOCK_LIST_READ_UNC_ERR] = CNTR_ELEM("RxRbufBlockListReadUncErr", 0,
+			0, CNTR_NORMAL,
+			access_rx_rbuf_block_list_read_unc_err_cnt),
+[C_RX_RBUF_LOOKUP_DES_COR_ERR] = CNTR_ELEM("RxRbufLookupDesCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_lookup_des_cor_err_cnt),
+[C_RX_RBUF_LOOKUP_DES_UNC_ERR] = CNTR_ELEM("RxRbufLookupDesUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_lookup_des_unc_err_cnt),
+[C_RX_RBUF_LOOKUP_DES_REG_UNC_COR_ERR] = CNTR_ELEM(
+			"RxRbufLookupDesRegUncCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_lookup_des_reg_unc_cor_err_cnt),
+[C_RX_RBUF_LOOKUP_DES_REG_UNC_ERR] = CNTR_ELEM("RxRbufLookupDesRegUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_lookup_des_reg_unc_err_cnt),
+[C_RX_RBUF_FREE_LIST_COR_ERR] = CNTR_ELEM("RxRbufFreeListCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_free_list_cor_err_cnt),
+[C_RX_RBUF_FREE_LIST_UNC_ERR] = CNTR_ELEM("RxRbufFreeListUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rbuf_free_list_unc_err_cnt),
+[C_RX_RCV_FSM_ENCODING_ERR] = CNTR_ELEM("RxRcvFsmEncodingErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_fsm_encoding_err_cnt),
+[C_RX_DMA_FLAG_COR_ERR] = CNTR_ELEM("RxDmaFlagCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_flag_cor_err_cnt),
+[C_RX_DMA_FLAG_UNC_ERR] = CNTR_ELEM("RxDmaFlagUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_flag_unc_err_cnt),
+[C_RX_DC_SOP_EOP_PARITY_ERR] = CNTR_ELEM("RxDcSopEopParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dc_sop_eop_parity_err_cnt),
+[C_RX_RCV_CSR_PARITY_ERR] = CNTR_ELEM("RxRcvCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_csr_parity_err_cnt),
+[C_RX_RCV_QP_MAP_TABLE_COR_ERR] = CNTR_ELEM("RxRcvQpMapTableCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_qp_map_table_cor_err_cnt),
+[C_RX_RCV_QP_MAP_TABLE_UNC_ERR] = CNTR_ELEM("RxRcvQpMapTableUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_qp_map_table_unc_err_cnt),
+[C_RX_RCV_DATA_COR_ERR] = CNTR_ELEM("RxRcvDataCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_data_cor_err_cnt),
+[C_RX_RCV_DATA_UNC_ERR] = CNTR_ELEM("RxRcvDataUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_data_unc_err_cnt),
+[C_RX_RCV_HDR_COR_ERR] = CNTR_ELEM("RxRcvHdrCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_hdr_cor_err_cnt),
+[C_RX_RCV_HDR_UNC_ERR] = CNTR_ELEM("RxRcvHdrUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_rcv_hdr_unc_err_cnt),
+[C_RX_DC_INTF_PARITY_ERR] = CNTR_ELEM("RxDcIntfParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dc_intf_parity_err_cnt),
+[C_RX_DMA_CSR_COR_ERR] = CNTR_ELEM("RxDmaCsrCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_rx_dma_csr_cor_err_cnt),
+/* SendPioErrStatus */
+[C_PIO_PEC_SOP_HEAD_PARITY_ERR] = CNTR_ELEM("PioPecSopHeadParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_pec_sop_head_parity_err_cnt),
+[C_PIO_PCC_SOP_HEAD_PARITY_ERR] = CNTR_ELEM("PioPccSopHeadParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_pcc_sop_head_parity_err_cnt),
+[C_PIO_LAST_RETURNED_CNT_PARITY_ERR] = CNTR_ELEM("PioLastReturnedCntParityErr",
+			0, 0, CNTR_NORMAL,
+			access_pio_last_returned_cnt_parity_err_cnt),
+[C_PIO_CURRENT_FREE_CNT_PARITY_ERR] = CNTR_ELEM("PioCurrentFreeCntParityErr", 0,
+			0, CNTR_NORMAL,
+			access_pio_current_free_cnt_parity_err_cnt),
+[C_PIO_RSVD_31_ERR] = CNTR_ELEM("Pio Reserved 31", 0, 0,
+			CNTR_NORMAL,
+			access_pio_reserved_31_err_cnt),
+[C_PIO_RSVD_30_ERR] = CNTR_ELEM("Pio Reserved 30", 0, 0,
+			CNTR_NORMAL,
+			access_pio_reserved_30_err_cnt),
+[C_PIO_PPMC_SOP_LEN_ERR] = CNTR_ELEM("PioPpmcSopLenErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_ppmc_sop_len_err_cnt),
+[C_PIO_PPMC_BQC_MEM_PARITY_ERR] = CNTR_ELEM("PioPpmcBqcMemParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_ppmc_bqc_mem_parity_err_cnt),
+[C_PIO_VL_FIFO_PARITY_ERR] = CNTR_ELEM("PioVlFifoParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_vl_fifo_parity_err_cnt),
+[C_PIO_VLF_SOP_PARITY_ERR] = CNTR_ELEM("PioVlfSopParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_vlf_sop_parity_err_cnt),
+[C_PIO_VLF_V1_LEN_PARITY_ERR] = CNTR_ELEM("PioVlfVlLenParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_vlf_v1_len_parity_err_cnt),
+[C_PIO_BLOCK_QW_COUNT_PARITY_ERR] = CNTR_ELEM("PioBlockQwCountParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_block_qw_count_parity_err_cnt),
+[C_PIO_WRITE_QW_VALID_PARITY_ERR] = CNTR_ELEM("PioWriteQwValidParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_write_qw_valid_parity_err_cnt),
+[C_PIO_STATE_MACHINE_ERR] = CNTR_ELEM("PioStateMachineErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_state_machine_err_cnt),
+[C_PIO_WRITE_DATA_PARITY_ERR] = CNTR_ELEM("PioWriteDataParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_write_data_parity_err_cnt),
+[C_PIO_HOST_ADDR_MEM_COR_ERR] = CNTR_ELEM("PioHostAddrMemCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_host_addr_mem_cor_err_cnt),
+[C_PIO_HOST_ADDR_MEM_UNC_ERR] = CNTR_ELEM("PioHostAddrMemUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_host_addr_mem_unc_err_cnt),
+[C_PIO_PKT_EVICT_SM_OR_ARM_SM_ERR] = CNTR_ELEM("PioPktEvictSmOrArbSmErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_pkt_evict_sm_or_arb_sm_err_cnt),
+[C_PIO_INIT_SM_IN_ERR] = CNTR_ELEM("PioInitSmInErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_init_sm_in_err_cnt),
+[C_PIO_PPMC_PBL_FIFO_ERR] = CNTR_ELEM("PioPpmcPblFifoErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_ppmc_pbl_fifo_err_cnt),
+[C_PIO_CREDIT_RET_FIFO_PARITY_ERR] = CNTR_ELEM("PioCreditRetFifoParityErr", 0,
+			0, CNTR_NORMAL,
+			access_pio_credit_ret_fifo_parity_err_cnt),
+[C_PIO_V1_LEN_MEM_BANK1_COR_ERR] = CNTR_ELEM("PioVlLenMemBank1CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_v1_len_mem_bank1_cor_err_cnt),
+[C_PIO_V1_LEN_MEM_BANK0_COR_ERR] = CNTR_ELEM("PioVlLenMemBank0CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_v1_len_mem_bank0_cor_err_cnt),
+[C_PIO_V1_LEN_MEM_BANK1_UNC_ERR] = CNTR_ELEM("PioVlLenMemBank1UncErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_v1_len_mem_bank1_unc_err_cnt),
+[C_PIO_V1_LEN_MEM_BANK0_UNC_ERR] = CNTR_ELEM("PioVlLenMemBank0UncErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_v1_len_mem_bank0_unc_err_cnt),
+[C_PIO_SM_PKT_RESET_PARITY_ERR] = CNTR_ELEM("PioSmPktResetParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_sm_pkt_reset_parity_err_cnt),
+[C_PIO_PKT_EVICT_FIFO_PARITY_ERR] = CNTR_ELEM("PioPktEvictFifoParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_pkt_evict_fifo_parity_err_cnt),
+[C_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR] = CNTR_ELEM(
+			"PioSbrdctrlCrrelFifoParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_sbrdctrl_crrel_fifo_parity_err_cnt),
+[C_PIO_SBRDCTL_CRREL_PARITY_ERR] = CNTR_ELEM("PioSbrdctlCrrelParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_sbrdctl_crrel_parity_err_cnt),
+[C_PIO_PEC_FIFO_PARITY_ERR] = CNTR_ELEM("PioPecFifoParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_pec_fifo_parity_err_cnt),
+[C_PIO_PCC_FIFO_PARITY_ERR] = CNTR_ELEM("PioPccFifoParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_pcc_fifo_parity_err_cnt),
+[C_PIO_SB_MEM_FIFO1_ERR] = CNTR_ELEM("PioSbMemFifo1Err", 0, 0,
+			CNTR_NORMAL,
+			access_pio_sb_mem_fifo1_err_cnt),
+[C_PIO_SB_MEM_FIFO0_ERR] = CNTR_ELEM("PioSbMemFifo0Err", 0, 0,
+			CNTR_NORMAL,
+			access_pio_sb_mem_fifo0_err_cnt),
+[C_PIO_CSR_PARITY_ERR] = CNTR_ELEM("PioCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_csr_parity_err_cnt),
+[C_PIO_WRITE_ADDR_PARITY_ERR] = CNTR_ELEM("PioWriteAddrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_write_addr_parity_err_cnt),
+[C_PIO_WRITE_BAD_CTXT_ERR] = CNTR_ELEM("PioWriteBadCtxtErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_write_bad_ctxt_err_cnt),
+/* SendDmaErrStatus */
+[C_SDMA_PCIE_REQ_TRACKING_COR_ERR] = CNTR_ELEM("SDmaPcieReqTrackingCorErr", 0,
+			0, CNTR_NORMAL,
+			access_sdma_pcie_req_tracking_cor_err_cnt),
+[C_SDMA_PCIE_REQ_TRACKING_UNC_ERR] = CNTR_ELEM("SDmaPcieReqTrackingUncErr", 0,
+			0, CNTR_NORMAL,
+			access_sdma_pcie_req_tracking_unc_err_cnt),
+[C_SDMA_CSR_PARITY_ERR] = CNTR_ELEM("SDmaCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_csr_parity_err_cnt),
+[C_SDMA_RPY_TAG_ERR] = CNTR_ELEM("SDmaRpyTagErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_rpy_tag_err_cnt),
+/* SendEgressErrStatus */
+[C_TX_READ_PIO_MEMORY_CSR_UNC_ERR] = CNTR_ELEM("TxReadPioMemoryCsrUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_read_pio_memory_csr_unc_err_cnt),
+[C_TX_READ_SDMA_MEMORY_CSR_UNC_ERR] = CNTR_ELEM("TxReadSdmaMemoryCsrUncErr", 0,
+			0, CNTR_NORMAL,
+			access_tx_read_sdma_memory_csr_err_cnt),
+[C_TX_EGRESS_FIFO_COR_ERR] = CNTR_ELEM("TxEgressFifoCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_egress_fifo_cor_err_cnt),
+[C_TX_READ_PIO_MEMORY_COR_ERR] = CNTR_ELEM("TxReadPioMemoryCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_read_pio_memory_cor_err_cnt),
+[C_TX_READ_SDMA_MEMORY_COR_ERR] = CNTR_ELEM("TxReadSdmaMemoryCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_read_sdma_memory_cor_err_cnt),
+[C_TX_SB_HDR_COR_ERR] = CNTR_ELEM("TxSbHdrCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_sb_hdr_cor_err_cnt),
+[C_TX_CREDIT_OVERRUN_ERR] = CNTR_ELEM("TxCreditOverrunErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_credit_overrun_err_cnt),
+[C_TX_LAUNCH_FIFO8_COR_ERR] = CNTR_ELEM("TxLaunchFifo8CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo8_cor_err_cnt),
+[C_TX_LAUNCH_FIFO7_COR_ERR] = CNTR_ELEM("TxLaunchFifo7CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo7_cor_err_cnt),
+[C_TX_LAUNCH_FIFO6_COR_ERR] = CNTR_ELEM("TxLaunchFifo6CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo6_cor_err_cnt),
+[C_TX_LAUNCH_FIFO5_COR_ERR] = CNTR_ELEM("TxLaunchFifo5CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo5_cor_err_cnt),
+[C_TX_LAUNCH_FIFO4_COR_ERR] = CNTR_ELEM("TxLaunchFifo4CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo4_cor_err_cnt),
+[C_TX_LAUNCH_FIFO3_COR_ERR] = CNTR_ELEM("TxLaunchFifo3CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo3_cor_err_cnt),
+[C_TX_LAUNCH_FIFO2_COR_ERR] = CNTR_ELEM("TxLaunchFifo2CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo2_cor_err_cnt),
+[C_TX_LAUNCH_FIFO1_COR_ERR] = CNTR_ELEM("TxLaunchFifo1CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo1_cor_err_cnt),
+[C_TX_LAUNCH_FIFO0_COR_ERR] = CNTR_ELEM("TxLaunchFifo0CorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_fifo0_cor_err_cnt),
+[C_TX_CREDIT_RETURN_VL_ERR] = CNTR_ELEM("TxCreditReturnVLErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_credit_return_vl_err_cnt),
+[C_TX_HCRC_INSERTION_ERR] = CNTR_ELEM("TxHcrcInsertionErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_hcrc_insertion_err_cnt),
+[C_TX_EGRESS_FIFI_UNC_ERR] = CNTR_ELEM("TxEgressFifoUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_egress_fifo_unc_err_cnt),
+[C_TX_READ_PIO_MEMORY_UNC_ERR] = CNTR_ELEM("TxReadPioMemoryUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_read_pio_memory_unc_err_cnt),
+[C_TX_READ_SDMA_MEMORY_UNC_ERR] = CNTR_ELEM("TxReadSdmaMemoryUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_read_sdma_memory_unc_err_cnt),
+[C_TX_SB_HDR_UNC_ERR] = CNTR_ELEM("TxSbHdrUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_sb_hdr_unc_err_cnt),
+[C_TX_CREDIT_RETURN_PARITY_ERR] = CNTR_ELEM("TxCreditReturnParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_credit_return_partiy_err_cnt),
+[C_TX_LAUNCH_FIFO8_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo8UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo8_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO7_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo7UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo7_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO6_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo6UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo6_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO5_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo5UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo5_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO4_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo4UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo4_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO3_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo3UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo3_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO2_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo2UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo2_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO1_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo1UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo1_unc_or_parity_err_cnt),
+[C_TX_LAUNCH_FIFO0_UNC_OR_PARITY_ERR] = CNTR_ELEM("TxLaunchFifo0UncOrParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_launch_fifo0_unc_or_parity_err_cnt),
+[C_TX_SDMA15_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma15DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma15_disallowed_packet_err_cnt),
+[C_TX_SDMA14_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma14DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma14_disallowed_packet_err_cnt),
+[C_TX_SDMA13_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma13DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma13_disallowed_packet_err_cnt),
+[C_TX_SDMA12_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma12DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma12_disallowed_packet_err_cnt),
+[C_TX_SDMA11_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma11DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma11_disallowed_packet_err_cnt),
+[C_TX_SDMA10_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma10DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma10_disallowed_packet_err_cnt),
+[C_TX_SDMA9_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma9DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma9_disallowed_packet_err_cnt),
+[C_TX_SDMA8_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma8DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma8_disallowed_packet_err_cnt),
+[C_TX_SDMA7_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma7DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma7_disallowed_packet_err_cnt),
+[C_TX_SDMA6_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma6DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma6_disallowed_packet_err_cnt),
+[C_TX_SDMA5_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma5DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma5_disallowed_packet_err_cnt),
+[C_TX_SDMA4_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma4DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma4_disallowed_packet_err_cnt),
+[C_TX_SDMA3_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma3DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma3_disallowed_packet_err_cnt),
+[C_TX_SDMA2_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma2DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma2_disallowed_packet_err_cnt),
+[C_TX_SDMA1_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma1DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma1_disallowed_packet_err_cnt),
+[C_TX_SDMA0_DISALLOWED_PACKET_ERR] = CNTR_ELEM("TxSdma0DisallowedPacketErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma0_disallowed_packet_err_cnt),
+[C_TX_CONFIG_PARITY_ERR] = CNTR_ELEM("TxConfigParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_config_parity_err_cnt),
+[C_TX_SBRD_CTL_CSR_PARITY_ERR] = CNTR_ELEM("TxSbrdCtlCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_sbrd_ctl_csr_parity_err_cnt),
+[C_TX_LAUNCH_CSR_PARITY_ERR] = CNTR_ELEM("TxLaunchCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_launch_csr_parity_err_cnt),
+[C_TX_ILLEGAL_CL_ERR] = CNTR_ELEM("TxIllegalVLErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_illegal_vl_err_cnt),
+[C_TX_SBRD_CTL_STATE_MACHINE_PARITY_ERR] = CNTR_ELEM(
+			"TxSbrdCtlStateMachineParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_sbrd_ctl_state_machine_parity_err_cnt),
+[C_TX_RESERVED_10] = CNTR_ELEM("Tx Egress Reserved 10", 0, 0,
+			CNTR_NORMAL,
+			access_egress_reserved_10_err_cnt),
+[C_TX_RESERVED_9] = CNTR_ELEM("Tx Egress Reserved 9", 0, 0,
+			CNTR_NORMAL,
+			access_egress_reserved_9_err_cnt),
+[C_TX_SDMA_LAUNCH_INTF_PARITY_ERR] = CNTR_ELEM("TxSdmaLaunchIntfParityErr",
+			0, 0, CNTR_NORMAL,
+			access_tx_sdma_launch_intf_parity_err_cnt),
+[C_TX_PIO_LAUNCH_INTF_PARITY_ERR] = CNTR_ELEM("TxPioLaunchIntfParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_pio_launch_intf_parity_err_cnt),
+[C_TX_RESERVED_6] = CNTR_ELEM("Tx Egress Reserved 6", 0, 0,
+			CNTR_NORMAL,
+			access_egress_reserved_6_err_cnt),
+[C_TX_INCORRECT_LINK_STATE_ERR] = CNTR_ELEM("TxIncorrectLinkStateErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_incorrect_link_state_err_cnt),
+[C_TX_LINK_DOWN_ERR] = CNTR_ELEM("TxLinkdownErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_linkdown_err_cnt),
+[C_TX_EGRESS_FIFO_UNDERRUN_OR_PARITY_ERR] = CNTR_ELEM(
+			"EgressFifoUnderrunOrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_egress_fifi_underrun_or_parity_err_cnt),
+[C_TX_RESERVED_2] = CNTR_ELEM("Tx Egress Reserved 2", 0, 0,
+			CNTR_NORMAL,
+			access_egress_reserved_2_err_cnt),
+[C_TX_PKT_INTEGRITY_MEM_UNC_ERR] = CNTR_ELEM("TxPktIntegrityMemUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_pkt_integrity_mem_unc_err_cnt),
+[C_TX_PKT_INTEGRITY_MEM_COR_ERR] = CNTR_ELEM("TxPktIntegrityMemCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_tx_pkt_integrity_mem_cor_err_cnt),
+/* SendErrStatus */
+[C_SEND_CSR_WRITE_BAD_ADDR_ERR] = CNTR_ELEM("SendCsrWriteBadAddrErr", 0, 0,
+			CNTR_NORMAL,
+			access_send_csr_write_bad_addr_err_cnt),
+[C_SEND_CSR_READ_BAD_ADD_ERR] = CNTR_ELEM("SendCsrReadBadAddrErr", 0, 0,
+			CNTR_NORMAL,
+			access_send_csr_read_bad_addr_err_cnt),
+[C_SEND_CSR_PARITY_ERR] = CNTR_ELEM("SendCsrParityErr", 0, 0,
+			CNTR_NORMAL,
+			access_send_csr_parity_cnt),
+/* SendCtxtErrStatus */
+[C_PIO_WRITE_OUT_OF_BOUNDS_ERR] = CNTR_ELEM("PioWriteOutOfBoundsErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_write_out_of_bounds_err_cnt),
+[C_PIO_WRITE_OVERFLOW_ERR] = CNTR_ELEM("PioWriteOverflowErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_write_overflow_err_cnt),
+[C_PIO_WRITE_CROSSES_BOUNDARY_ERR] = CNTR_ELEM("PioWriteCrossesBoundaryErr",
+			0, 0, CNTR_NORMAL,
+			access_pio_write_crosses_boundary_err_cnt),
+[C_PIO_DISALLOWED_PACKET_ERR] = CNTR_ELEM("PioDisallowedPacketErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_disallowed_packet_err_cnt),
+[C_PIO_INCONSISTENT_SOP_ERR] = CNTR_ELEM("PioInconsistentSopErr", 0, 0,
+			CNTR_NORMAL,
+			access_pio_inconsistent_sop_err_cnt),
+/* SendDmaEngErrStatus */
+[C_SDMA_HEADER_REQUEST_FIFO_COR_ERR] = CNTR_ELEM("SDmaHeaderRequestFifoCorErr",
+			0, 0, CNTR_NORMAL,
+			access_sdma_header_request_fifo_cor_err_cnt),
+[C_SDMA_HEADER_STORAGE_COR_ERR] = CNTR_ELEM("SDmaHeaderStorageCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_header_storage_cor_err_cnt),
+[C_SDMA_PACKET_TRACKING_COR_ERR] = CNTR_ELEM("SDmaPacketTrackingCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_packet_tracking_cor_err_cnt),
+[C_SDMA_ASSEMBLY_COR_ERR] = CNTR_ELEM("SDmaAssemblyCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_assembly_cor_err_cnt),
+[C_SDMA_DESC_TABLE_COR_ERR] = CNTR_ELEM("SDmaDescTableCorErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_desc_table_cor_err_cnt),
+[C_SDMA_HEADER_REQUEST_FIFO_UNC_ERR] = CNTR_ELEM("SDmaHeaderRequestFifoUncErr",
+			0, 0, CNTR_NORMAL,
+			access_sdma_header_request_fifo_unc_err_cnt),
+[C_SDMA_HEADER_STORAGE_UNC_ERR] = CNTR_ELEM("SDmaHeaderStorageUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_header_storage_unc_err_cnt),
+[C_SDMA_PACKET_TRACKING_UNC_ERR] = CNTR_ELEM("SDmaPacketTrackingUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_packet_tracking_unc_err_cnt),
+[C_SDMA_ASSEMBLY_UNC_ERR] = CNTR_ELEM("SDmaAssemblyUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_assembly_unc_err_cnt),
+[C_SDMA_DESC_TABLE_UNC_ERR] = CNTR_ELEM("SDmaDescTableUncErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_desc_table_unc_err_cnt),
+[C_SDMA_TIMEOUT_ERR] = CNTR_ELEM("SDmaTimeoutErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_timeout_err_cnt),
+[C_SDMA_HEADER_LENGTH_ERR] = CNTR_ELEM("SDmaHeaderLengthErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_header_length_err_cnt),
+[C_SDMA_HEADER_ADDRESS_ERR] = CNTR_ELEM("SDmaHeaderAddressErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_header_address_err_cnt),
+[C_SDMA_HEADER_SELECT_ERR] = CNTR_ELEM("SDmaHeaderSelectErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_header_select_err_cnt),
+[C_SMDA_RESERVED_9] = CNTR_ELEM("SDma Reserved 9", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_reserved_9_err_cnt),
+[C_SDMA_PACKET_DESC_OVERFLOW_ERR] = CNTR_ELEM("SDmaPacketDescOverflowErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_packet_desc_overflow_err_cnt),
+[C_SDMA_LENGTH_MISMATCH_ERR] = CNTR_ELEM("SDmaLengthMismatchErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_length_mismatch_err_cnt),
+[C_SDMA_HALT_ERR] = CNTR_ELEM("SDmaHaltErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_halt_err_cnt),
+[C_SDMA_MEM_READ_ERR] = CNTR_ELEM("SDmaMemReadErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_mem_read_err_cnt),
+[C_SDMA_FIRST_DESC_ERR] = CNTR_ELEM("SDmaFirstDescErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_first_desc_err_cnt),
+[C_SDMA_TAIL_OUT_OF_BOUNDS_ERR] = CNTR_ELEM("SDmaTailOutOfBoundsErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_tail_out_of_bounds_err_cnt),
+[C_SDMA_TOO_LONG_ERR] = CNTR_ELEM("SDmaTooLongErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_too_long_err_cnt),
+[C_SDMA_GEN_MISMATCH_ERR] = CNTR_ELEM("SDmaGenMismatchErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_gen_mismatch_err_cnt),
+[C_SDMA_WRONG_DW_ERR] = CNTR_ELEM("SDmaWrongDwErr", 0, 0,
+			CNTR_NORMAL,
+			access_sdma_wrong_dw_err_cnt),
+};
+
+struct cntr_entry wfr_dev_cntrs[WFR_NUM_DEV_CNTRS] = {
+#define A(x) ((x) - WFR_DEV_CNTR_FIRST) /* absolute number */
+[A(C_DC_UNC_ERR)] = DC_PERF_CNTR(DcUnctblErr, DCC_ERR_UNCORRECTABLE_CNT,
+				 CNTR_SYNTH),
+[A(C_DC_RCV_ERR)] = CNTR_ELEM("DcRecvErr", DCC_ERR_PORTRCV_ERR_CNT, 0,
+			      CNTR_SYNTH, access_dc_rcv_err_cnt),
+[A(C_DC_FM_CFG_ERR)] = DC_PERF_CNTR(DcFmCfgErr, DCC_ERR_FMCONFIG_ERR_CNT,
+				    CNTR_SYNTH),
+[A(C_DC_RMT_PHY_ERR)] = DC_PERF_CNTR(DcRmtPhyErr, DCC_ERR_RCVREMOTE_PHY_ERR_CNT,
+				     CNTR_SYNTH),
+[A(C_DC_DROPPED_PKT)] = DC_PERF_CNTR(DcDroppedPkt, DCC_ERR_DROPPED_PKT_CNT,
+				     CNTR_SYNTH),
+[A(C_DC_MC_XMIT_PKTS)] = DC_PERF_CNTR(DcMcXmitPkts,
+				      DCC_PRF_PORT_XMIT_MULTICAST_CNT,
+				      CNTR_SYNTH),
+[A(C_DC_MC_RCV_PKTS)] = DC_PERF_CNTR(DcMcRcvPkts,
+				     DCC_PRF_PORT_RCV_MULTICAST_PKT_CNT,
+				     CNTR_SYNTH),
+[A(C_DC_XMIT_CERR)] = DC_PERF_CNTR(DcXmitCorr,
+				   DCC_PRF_PORT_XMIT_CORRECTABLE_CNT,
+				   CNTR_SYNTH),
+[A(C_DC_RCV_CERR)] = DC_PERF_CNTR(DcRcvCorrCnt,
+				  DCC_PRF_PORT_RCV_CORRECTABLE_CNT,
+				  CNTR_SYNTH),
+[A(C_DC_RCV_FCC)] = DC_PERF_CNTR(DcRxFCntl, DCC_PRF_RX_FLOW_CRTL_CNT,
+				 CNTR_SYNTH),
+[A(C_DC_XMIT_FCC)] = DC_PERF_CNTR(DcXmitFCntl, DCC_PRF_TX_FLOW_CRTL_CNT,
+				  CNTR_SYNTH),
+[A(C_DC_XMIT_FLITS)] = DC_PERF_CNTR(DcXmitFlits, DCC_PRF_PORT_XMIT_DATA_CNT,
+				    CNTR_SYNTH),
+[A(C_DC_RCV_FLITS)] = DC_PERF_CNTR(DcRcvFlits, DCC_PRF_PORT_RCV_DATA_CNT,
+				   CNTR_SYNTH),
+[A(C_DC_XMIT_PKTS)] = DC_PERF_CNTR(DcXmitPkts, DCC_PRF_PORT_XMIT_PKTS_CNT,
+				   CNTR_SYNTH),
+[A(C_DC_RCV_PKTS)] = DC_PERF_CNTR(DcRcvPkts, DCC_PRF_PORT_RCV_PKTS_CNT,
+				  CNTR_SYNTH),
+[A(C_DC_RX_FLIT_VL)] = DC_PERF_CNTR(DcRxFlitVl, DCC_PRF_PORT_VL_RCV_DATA_CNT,
+				    CNTR_SYNTH | CNTR_VL),
+[A(C_DC_RX_PKT_VL)] = DC_PERF_CNTR(DcRxPktVl, DCC_PRF_PORT_VL_RCV_PKTS_CNT,
+				   CNTR_SYNTH | CNTR_VL),
+[A(C_DC_RCV_FCN)] = DC_PERF_CNTR(DcRcvFcn, DCC_PRF_PORT_RCV_FECN_CNT,
+				 CNTR_SYNTH),
+[A(C_DC_RCV_FCN_VL)] = DC_PERF_CNTR(DcRcvFcnVl, DCC_PRF_PORT_VL_RCV_FECN_CNT,
+				    CNTR_SYNTH | CNTR_VL),
+[A(C_DC_RCV_BCN)] = DC_PERF_CNTR(DcRcvBcn, DCC_PRF_PORT_RCV_BECN_CNT,
+				 CNTR_SYNTH),
+[A(C_DC_RCV_BCN_VL)] = DC_PERF_CNTR(DcRcvBcnVl, DCC_PRF_PORT_VL_RCV_BECN_CNT,
+				    CNTR_SYNTH | CNTR_VL),
+[A(C_DC_RCV_BBL)] = DC_PERF_CNTR(DcRcvBbl, DCC_PRF_PORT_RCV_BUBBLE_CNT,
+				 CNTR_SYNTH),
+[A(C_DC_RCV_BBL_VL)] = DC_PERF_CNTR(DcRcvBblVl, DCC_PRF_PORT_VL_RCV_BUBBLE_CNT,
+				    CNTR_SYNTH | CNTR_VL),
+[A(C_DC_MARK_FECN)] = DC_PERF_CNTR(DcMarkFcn, DCC_PRF_PORT_MARK_FECN_CNT,
+				   CNTR_SYNTH),
+[A(C_DC_MARK_FECN_VL)] = DC_PERF_CNTR(DcMarkFcnVl,
+				      DCC_PRF_PORT_VL_MARK_FECN_CNT,
+				      CNTR_SYNTH | CNTR_VL),
+[A(C_DC_TOTAL_CRC)] = DC_PERF_CNTR_LCB(DcTotCrc, DC_LCB_ERR_INFO_TOTAL_CRC_ERR,
+				       CNTR_SYNTH),
+[A(C_DC_CRC_LN0)] = DC_PERF_CNTR_LCB(DcCrcLn0, DC_LCB_ERR_INFO_CRC_ERR_LN0,
+				     CNTR_SYNTH),
+[A(C_DC_CRC_LN1)] = DC_PERF_CNTR_LCB(DcCrcLn1, DC_LCB_ERR_INFO_CRC_ERR_LN1,
+				     CNTR_SYNTH),
+[A(C_DC_CRC_LN2)] = DC_PERF_CNTR_LCB(DcCrcLn2, DC_LCB_ERR_INFO_CRC_ERR_LN2,
+				     CNTR_SYNTH),
+[A(C_DC_CRC_LN3)] = DC_PERF_CNTR_LCB(DcCrcLn3, DC_LCB_ERR_INFO_CRC_ERR_LN3,
+				     CNTR_SYNTH),
+[A(C_DC_CRC_MULT_LN)] = DC_PERF_CNTR_LCB(DcMultLn,
+					 DC_LCB_ERR_INFO_CRC_ERR_MULTI_LN,
+					 CNTR_SYNTH),
+[A(C_DC_TX_REPLAY)] = DC_PERF_CNTR_LCB(DcTxReplay,
+				       DC_LCB_ERR_INFO_TX_REPLAY_CNT,
+				       CNTR_SYNTH),
+[A(C_DC_RX_REPLAY)] = DC_PERF_CNTR_LCB(DcRxReplay,
+				       DC_LCB_ERR_INFO_RX_REPLAY_CNT,
+				       CNTR_SYNTH),
+[A(C_DC_SEQ_CRC_CNT)] = DC_PERF_CNTR_LCB(DcLinkSeqCrc,
+					 DC_LCB_ERR_INFO_SEQ_CRC_CNT,
+					 CNTR_SYNTH),
+[A(C_DC_ESC0_ONLY_CNT)] = DC_PERF_CNTR_LCB(DcEsc0,
+					   DC_LCB_ERR_INFO_ESCAPE_0_ONLY_CNT,
+					   CNTR_SYNTH),
+[A(C_DC_ESC0_PLUS1_CNT)] = DC_PERF_CNTR_LCB(DcEsc1,
+					    DC_LCB_ERR_INFO_ESCAPE_0_PLUS1_CNT,
+					    CNTR_SYNTH),
+[A(C_DC_ESC0_PLUS2_CNT)] = DC_PERF_CNTR_LCB(DcEsc0Plus2,
+					    DC_LCB_ERR_INFO_ESCAPE_0_PLUS2_CNT,
+					    CNTR_SYNTH),
+[A(C_DC_REINIT_FROM_PEER_CNT)] =
+	DC_PERF_CNTR_LCB(DcReinitPeer, DC_LCB_ERR_INFO_REINIT_FROM_PEER_CNT,
+			 CNTR_SYNTH),
+[A(C_DC_SBE_CNT)] = DC_PERF_CNTR_LCB(DcSbe, DC_LCB_ERR_INFO_SBE_CNT,
+				     CNTR_SYNTH),
+[A(C_DC_MISC_FLG_CNT)] = DC_PERF_CNTR_LCB(DcMiscFlg,
+					  DC_LCB_ERR_INFO_MISC_FLG_CNT,
+					  CNTR_SYNTH),
+[A(C_DC_PRF_GOOD_LTP_CNT)] = DC_PERF_CNTR_LCB(DcGoodLTP,
+					      DC_LCB_PRF_GOOD_LTP_CNT,
+					      CNTR_SYNTH),
+[A(C_DC_PRF_ACCEPTED_LTP_CNT)] = DC_PERF_CNTR_LCB(DcAccLTP,
+						  DC_LCB_PRF_ACCEPTED_LTP_CNT,
+						  CNTR_SYNTH),
+[A(C_DC_PRF_RX_FLIT_CNT)] = DC_PERF_CNTR_LCB(DcPrfRxFlit,
+					     DC_LCB_PRF_RX_FLIT_CNT,
+					     CNTR_SYNTH),
+[A(C_DC_PRF_TX_FLIT_CNT)] = DC_PERF_CNTR_LCB(DcPrfTxFlit,
+					     DC_LCB_PRF_TX_FLIT_CNT,
+					     CNTR_SYNTH),
+[A(C_DC_PRF_CLK_CNTR)] = DC_PERF_CNTR_LCB(DcPrfClk,
+					  DC_LCB_PRF_CLK_CNTR, CNTR_SYNTH),
+[A(C_DC_PG_DBG_FLIT_CRDTS_CNT)] = DC_PERF_CNTR_LCB(DcFltCrdts,
+						   DC_LCB_PG_DBG_FLIT_CRDTS_CNT,
+						   CNTR_SYNTH),
+[A(C_DC_PG_STS_PAUSE_COMPLETE_CNT)] =
+	DC_PERF_CNTR_LCB(DcPauseComp, DC_LCB_PG_STS_PAUSE_COMPLETE_CNT,
+			 CNTR_SYNTH),
+[A(C_DC_PG_STS_TX_SBE_CNT)] =
+	DC_PERF_CNTR_LCB(DcStsTxSbe, DC_LCB_PG_STS_TX_SBE_CNT, CNTR_SYNTH),
+[A(C_DC_PG_STS_TX_MBE_CNT)] =
+	DC_PERF_CNTR_LCB(DcStsTxMbe, DC_LCB_PG_STS_TX_MBE_CNT, CNTR_SYNTH),
+[A(C_CCE_PCI_TR_ST)] = CCE_PERF_DEV_CNTR_ELEM("CcePciTrSt", CCE_PCIE_TRGT_STALL_CNT,
+				CNTR_NORMAL),
+[A(C_CCE_PIO_WR_ST)] = CCE_PERF_DEV_CNTR_ELEM("CcePioWrSt", CCE_PIO_WR_STALL_CNT,
+				CNTR_NORMAL),
+[A(C_CCE_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(CceErrInt, WFR_CCE_ERR_INT_CNT,
+				CNTR_NORMAL),
+#undef A
+};
+
+struct cntr_entry jkr_dev_cntrs[JKR_NUM_DEV_CNTRS] = {
+#define A(x) ((x) - JKR_DEV_CNTR_FIRST) /* absolute number */
+[A(C_CCE_RW_ST_BY_R)] = CCE_PERF_DEV_CNTR_ELEM("CceRdWrStByRd", 0, CNTR_NORMAL),
+[A(C_CCE_OTHER_INT)] = CCE_INT_DEV_CNTR_ELEM(CceOtherInt, JKR_C_CCE_OTHER_INT_CNT,
+				CNTR_NORMAL),
+[A(C_CCE_PBC_INT)] = CCE_INT_DEV_CNTR_ELEM(CcePbcInt, JKR_C_CCE_PBC_INT_CNT,
+				CNTR_NORMAL),
+[A(C_CCE_PIO_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(CcePioErrInt, JKR_C_CCE_PIO_ERR_INT_CNT,
+				CNTR_NORMAL),
+[A(C_CCE_SDMA_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(CceSdmaErrInt, JKR_C_CCE_SDMA_ERR_INT_CNT,
+				CNTR_NORMAL),
+[A(C_CCE_CSR_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(CceCsrErrInt, JKR_C_CCE_CSR_ERR_INT_CNT,
+				CNTR_NORMAL),
+#undef A
+};
+
+struct cntr_entry shared_port_cntrs[SHARED_PORT_CNTR_LAST] = {
+[C_TX_UNSUP_VL] = TXE32_PORT_CNTR_ELEM(TxUnVLErr, SEND_UNSUP_VL_ERR_CNT,
+			CNTR_NORMAL),
+[C_TX_INVAL_LEN] = TXE32_PORT_CNTR_ELEM(TxInvalLen, SEND_LEN_ERR_CNT,
+			CNTR_NORMAL),
+[C_TX_MM_LEN_ERR] = TXE32_PORT_CNTR_ELEM(TxMMLenErr, SEND_MAX_MIN_LEN_ERR_CNT,
+			CNTR_NORMAL),
+[C_TX_UNDERRUN] = TXE32_PORT_CNTR_ELEM(TxUnderrun, SEND_UNDERRUN_CNT,
+			CNTR_NORMAL),
+[C_TX_FLOW_STALL] = TXE32_PORT_CNTR_ELEM(TxFlowStall, SEND_FLOW_STALL_CNT,
+			CNTR_NORMAL),
+[C_TX_DROPPED] = TXE32_PORT_CNTR_ELEM(TxDropped, SEND_DROPPED_PKT_CNT,
+			CNTR_NORMAL),
+[C_TX_HDR_ERR] = TXE32_PORT_CNTR_ELEM(TxHdrErr, SEND_HEADERS_ERR_CNT,
+			CNTR_NORMAL),
+[C_TX_PKT] = TXE64_PORT_CNTR_ELEM(TxPkt, SEND_DATA_PKT_CNT, CNTR_NORMAL),
+[C_TX_WORDS] = TXE64_PORT_CNTR_ELEM(TxWords, SEND_DWORD_CNT, CNTR_NORMAL),
+[C_TX_WAIT] = TXE64_PORT_CNTR_ELEM(TxWait, SEND_WAIT_CNT, CNTR_SYNTH),
+[C_TX_FLIT_VL] = TXE64_PORT_CNTR_ELEM(TxFlitVL, SEND_DATA_VL0_CNT,
+				      CNTR_SYNTH | CNTR_VL),
+[C_TX_PKT_VL] = TXE64_PORT_CNTR_ELEM(TxPktVL, SEND_DATA_PKT_VL0_CNT,
+				     CNTR_SYNTH | CNTR_VL),
+[C_TX_WAIT_VL] = TXE64_PORT_CNTR_ELEM(TxWaitVL, SEND_WAIT_VL0_CNT,
+				      CNTR_SYNTH | CNTR_VL),
+[C_RCV_OVF] = RXE32_PORT_CNTR_ELEM("RcvOverflow", RCV_BUF_OVFL_CNT, CNTR_SYNTH),
+[C_RX_LEN_ERR] = RXE32_PORT_CNTR_ELEM("RxLenErr", RCV_LENGTH_ERR_CNT, CNTR_SYNTH),
+[C_RX_SHORT_ERR] = RXE32_PORT_CNTR_ELEM("RxShrErr", RCV_SHORT_ERR_CNT, CNTR_SYNTH),
+[C_RX_ICRC_ERR] = RXE32_PORT_CNTR_ELEM("RxICrcErr", RCV_ICRC_ERR_CNT, CNTR_SYNTH),
+[C_RX_EBP] = RXE32_PORT_CNTR_ELEM("RxEbpCnt", RCV_EBP_CNT, CNTR_SYNTH),
+[C_RX_PKEY_MISMATCH] = RXE32_PORT_CNTR_ELEM("RxPkeyMismatch",
+					    RCV_PKEY_MISMATCH_CNT, CNTR_SYNTH),
+[C_RX_PKT] = RXE64_PORT_CNTR_ELEM(RxPkt, RCV_DATA_PKT_CNT, CNTR_NORMAL),
+[C_RX_WORDS] = RXE64_PORT_CNTR_ELEM(RxWords, RCV_DWORD_CNT, CNTR_NORMAL),
+[C_SW_LINK_DOWN] = CNTR_ELEM("SwLinkDown", 0, 0, CNTR_SYNTH | CNTR_32BIT,
+			     access_sw_link_dn_cnt),
+[C_SW_LINK_UP] = CNTR_ELEM("SwLinkUp", 0, 0, CNTR_SYNTH | CNTR_32BIT,
+			   access_sw_link_up_cnt),
+[C_SW_UNKNOWN_FRAME] = CNTR_ELEM("UnknownFrame", 0, 0, CNTR_NORMAL,
+				 access_sw_unknown_frame_cnt),
+[C_SW_XMIT_DSCD] = CNTR_ELEM("XmitDscd", 0, 0, CNTR_SYNTH | CNTR_32BIT,
+			     access_sw_xmit_discards),
+[C_SW_XMIT_DSCD_VL] = CNTR_ELEM("XmitDscdVl", 0, 0,
+				CNTR_SYNTH | CNTR_32BIT | CNTR_VL,
+				access_sw_xmit_discards),
+[C_SW_XMIT_CSTR_ERR] = CNTR_ELEM("XmitCstrErr", 0, 0, CNTR_SYNTH,
+				 access_xmit_constraint_errs),
+[C_SW_RCV_CSTR_ERR] = CNTR_ELEM("RcvCstrErr", 0, 0, CNTR_SYNTH,
+				access_rcv_constraint_errs),
+[C_SW_IBP_LOOP_PKTS] = SW_IBP_CNTR(LoopPkts, loop_pkts),
+[C_SW_IBP_RC_RESENDS] = SW_IBP_CNTR(RcResend, rc_resends),
+[C_SW_IBP_RNR_NAKS] = SW_IBP_CNTR(RnrNak, rnr_naks),
+[C_SW_IBP_OTHER_NAKS] = SW_IBP_CNTR(OtherNak, other_naks),
+[C_SW_IBP_RC_TIMEOUTS] = SW_IBP_CNTR(RcTimeOut, rc_timeouts),
+[C_SW_IBP_PKT_DROPS] = SW_IBP_CNTR(PktDrop, pkt_drops),
+[C_SW_IBP_DMA_WAIT] = SW_IBP_CNTR(DmaWait, dmawait),
+[C_SW_IBP_RC_SEQNAK] = SW_IBP_CNTR(RcSeqNak, rc_seqnak),
+[C_SW_IBP_RC_DUPREQ] = SW_IBP_CNTR(RcDupRew, rc_dupreq),
+[C_SW_IBP_RDMA_SEQ] = SW_IBP_CNTR(RdmaSeq, rdma_seq),
+[C_SW_IBP_UNALIGNED] = SW_IBP_CNTR(Unaligned, unaligned),
+[C_SW_IBP_SEQ_NAK] = SW_IBP_CNTR(SeqNak, seq_naks),
+[C_SW_IBP_RC_CRWAITS] = SW_IBP_CNTR(RcCrWait, rc_crwaits),
+[C_SW_CPU_RC_ACKS] = CNTR_ELEM("RcAcks", 0, 0, CNTR_NORMAL,
+			       access_sw_cpu_rc_acks),
+[C_SW_CPU_RC_QACKS] = CNTR_ELEM("RcQacks", 0, 0, CNTR_NORMAL,
+				access_sw_cpu_rc_qacks),
+[C_SW_CPU_RC_DELAYED_COMP] = CNTR_ELEM("RcDelayComp", 0, 0, CNTR_NORMAL,
+				       access_sw_cpu_rc_delayed_comp),
+[C_RCV_HDR_OVF] = CNTR_ELEM("RcvHdrOvr", 0, 0, CNTR_OVF, access_ovf_csr),
+};
+
+struct cntr_entry wfr_port_cntrs[WFR_NUM_PORT_CNTRS] = {
+#define A(x) ((x) - WFR_PORT_CNTR_FIRST) /* absolute number */
+[A(C_WFR_RX_DROPPED_PKT)] = RXE32_PORT_CNTR_ELEM("RxDroppedPkt",
+				RCV_DROPPED_PKT_CNT, CNTR_SYNTH),
+[A(C_WFR_RX_DROPPED_BYPASS_PKT)] = RXE32_PORT_CNTR_ELEM("RxDroppedBypassPkt",
+				RCV_DROPPED_BYPASS_PKT_CNT, CNTR_SYNTH),
+[A(C_WFR_RX_TID_FULL)] = RXE32_PORT_CNTR_ELEM("RxTIDFullErr",
+				RCV_TID_FULL_ERR_CNT, CNTR_NORMAL),
+[A(C_WFR_RX_TID_INVALID)] = RXE32_PORT_CNTR_ELEM("RxTIDInvalid",
+				RCV_TID_VALID_ERR_CNT, CNTR_NORMAL),
+[A(C_WFR_RX_TID_FLGMS)] = RXE32_PORT_CNTR_ELEM("RxTidFLGMs",
+				RCV_TID_FLOW_GEN_MISMATCH_CNT, CNTR_NORMAL),
+[A(C_WFR_RX_CTX_EGRS)] = RXE32_PORT_CNTR_ELEM("RxCtxEgrS",
+				RCV_CONTEXT_EGR_STALL, CNTR_NORMAL),
+[A(C_WFR_RCV_TID_FLSMS)] = RXE32_PORT_CNTR_ELEM("RxTidFLSMs",
+				RCV_TID_FLOW_SEQ_MISMATCH_CNT, CNTR_NORMAL),
+#undef A
+};
+
+/* RcvCounterArray32 selected indices specific to JKR */
+enum {
+	JKR_RCV_L2_TYPE_DISABLED = 5,
+	JKR_RCV_DROPPED_PKT_CNT_16B = 18,
+	JKR_RCV_DROPPED_PKT_CNT_9B = 19,
+	JKR_RCV_TID_FULL_ERR_CNT = 20,
+	JKR_RCV_TID_VALID_ERR_CNT = 21,
+	JKR_RCV_TID_FLOW_GEN_MISMATCH_CNT = 22,
+	JKR_RCV_CONTEXT_EGR_STALL = 24,
+	JKR_RCV_TID_FLOW_SEQ_MISMATCH_CNT = 25,
+};
+
+struct cntr_entry jkr_port_cntrs[JKR_NUM_PORT_CNTRS] = {
+#define A(x) ((x) - JKR_DEV_CNTR_FIRST) /* absolute number */
+[A(C_JKR_RX_L2_TYPE_DISABLED)] = RXE32_PORT_CNTR_ELEM("RxL2TypeDisabled",
+				JKR_RCV_L2_TYPE_DISABLED, CNTR_SYNTH),
+[A(C_JKR_RX_DROPPED_PKT_16B)] = RXE32_PORT_CNTR_ELEM("RxDroppedPkt16B",
+				JKR_RCV_DROPPED_PKT_CNT_16B, CNTR_SYNTH),
+[A(C_JKR_RX_DROPPED_PKT_9B)] = RXE32_PORT_CNTR_ELEM("RxDroppedPkt9B",
+				JKR_RCV_DROPPED_PKT_CNT_9B, CNTR_SYNTH),
+[A(C_JKR_RX_TID_FULL)] = RXE32_PORT_CNTR_ELEM("RxTIDFullErr",
+				JKR_RCV_TID_FULL_ERR_CNT, CNTR_NORMAL),
+[A(C_JKR_RX_TID_INVALID)] = RXE32_PORT_CNTR_ELEM("RxTIDInvalid",
+				JKR_RCV_TID_VALID_ERR_CNT, CNTR_NORMAL),
+[A(C_JKR_RX_TID_FLGMS)] = RXE32_PORT_CNTR_ELEM("RxTidFLGMs",
+				JKR_RCV_TID_FLOW_GEN_MISMATCH_CNT, CNTR_NORMAL),
+[A(C_JKR_RX_CTX_EGRS)] = RXE32_PORT_CNTR_ELEM("RxCtxEgrS",
+				JKR_RCV_CONTEXT_EGR_STALL, CNTR_NORMAL),
+[A(C_JKR_RCV_TID_FLSMS)] = RXE32_PORT_CNTR_ELEM("RxTidFLSMs",
+				JKR_RCV_TID_FLOW_SEQ_MISMATCH_CNT, CNTR_NORMAL),
+#undef A
+};



