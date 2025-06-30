Return-Path: <linux-rdma+bounces-11787-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B30AEE649
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8647A3EE9
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D0F2E62C6;
	Mon, 30 Jun 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="Q780mB4c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2104.outbound.protection.outlook.com [40.107.93.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E4D2E7184
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306319; cv=fail; b=LIO56Cgvf5KK7m3VXBpGMDjVerIcO445+tOYVgVs2BwlTrnU0QCTs9jjHNGy1tQBmC3862+9PS6dO3i8BUA1AK16aBLnF7+f8BoWiWLSI7DOaJHWvDHJpAi4RrqlM3f1ClyPh3PpdhfIEQqCJ6w0o8X4//drTZOzpf09h3QR8fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306319; c=relaxed/simple;
	bh=TAr6nw5JDySiqmrRLFbfWbcUfm0SnP0LRWecNwFy6bo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Co9uUTOBBtO3uq8tcLqM+01MouBoSwmJfF3FfcgASLM5EFjejhVa+qcUjoUQTCUjJTa9K1F4d6RheEcTl0H2mqdEwe/TKoc7xLHQwUX2B82iU9lgI1XaEY1u9gLgd3Qo/GeO73OxH1oHVG4vk7r4TRAQpcT0TETbe0YKx8l3d3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=Q780mB4c; arc=fail smtp.client-ip=40.107.93.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWwUub+lSlgzj5kUBJ3aVtMxKeO9OuIxLoLp3E2pxXuvQXV6Ba0C3L2eiELJjm5GhmI/kDr4+hcYn17/DkMLyvJfRLZKhIrYZYhUvDbju3fmsgCHW/xF7+8Wm6UINXv2d6MWnFRjr09ec6/nNWC/i7Zra7JTa1lMK+8Ut3bLY3w2igEBnF3MCG9AvUH9c7qOJJ4p3IkzymE/tRgzviGIbzzLO797JNExAOnYc+ifHul2iOSjNixLt8SfzZb8gxTE0qBtDEVA10qZOYOgySx8ZkGy8V8TzVBmHVeYkY0OjH3Nw12ONA0pAb9ld+Jv6krTzTZfK4ssvSES0ascyMyPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybu0N4A3cZ+SFod02mEtq/wlMhwbP3ImFG3y+Vwz5aY=;
 b=MN5PBXmlhYET/dB2vig0JO18puwyPyT30r0rCSgwZS20lLkudG8FQ5iEeWJf7iDit+3kH6x8wTlYVroC37rmlPriku1iopoD+By1wjQwCiV+xBj5qr9uuIcaN35x4827xgznv9HGMnvgT7whJWiFk/wazUle6QA2WDnZ67kAhH1kYpfkMYTs65DbBiMOIBGarZxTtDFBgr0pqIQhjX5oxJ2Z79c2neT2svldcSZI4XYax6Igbja/Mf7ZIKzww1Cg34bsA6YC9gvppzVY4TR6kg7JxKOR9ULGNSvQ2uBQSZdLMqQCeF8r5hDmSwHYHRtN+yVFK2DUNAgehVj/JTa8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ybu0N4A3cZ+SFod02mEtq/wlMhwbP3ImFG3y+Vwz5aY=;
 b=Q780mB4crZTTk7fuqR5qsMaW3A+7iVoaxvm4g7r5d7qPLjSTEBb+xRAB1xGTfmksJI7d1aLGCkm54dJ0Is5XYjYb0ed/q0/2hw9+d0BwkWMA7Hop0fbRpHe5dli5eyzjChJITA+HOVUonfjFHN8cmgGV3+aIpBj6pcZKgp/0Pvd/VM0iXx4XZX5Y/HHttoE8EtNihG2++V965ufdZYCKmIj4KfcAJqVYFOEILKS8btrrHCj6MB8pXOIe+o9F8oFVJyPEPXuLxR5HOEYw+LJJ/ig+UeKYl+Iwd2T23A5FlKoB22tCzMSDf8g6TcjQJXs/Xlb3leW69DrDfqaT2bjGwg==
Received: from SA0PR11CA0185.namprd11.prod.outlook.com (2603:10b6:806:1bc::10)
 by LV3PR01MB8534.prod.exchangelabs.com (2603:10b6:408:197::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 17:58:08 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::d) by SA0PR11CA0185.outlook.office365.com
 (2603:10b6:806:1bc::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 17:58:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:07 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id AACA014D715;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 3BC851848B5CF;
	Mon, 30 Jun 2025 11:30:38 -0400 (EDT)
Subject: [PATCH for-next 10/23] RDMA/hfi2: Add in HW register access support
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:38 -0400
Message-ID:
 <175129743814.1859400.4253022820082459886.stgit@awdrv-04.cornelisnetworks.com>
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
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV3PR01MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0e0d83-8be2-454c-5414-08ddb7ffab61
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjdEYmtYRytqSTV2RldpTGtzSDZVVnNWQ1o5ZGt2cHhhSVN0cFVPUDdkSFo1?=
 =?utf-8?B?TjByWEQ1YW9ObHdBamFKVGhWSk1Kb2E1ODU2cU9Dcm1BSVJjKy9pYjdZYWdK?=
 =?utf-8?B?KzVQdnN5eGdMYVVvcUVHS2w2ZlpKc3UzMkM2STVKdWNrNDgxQXNzdE9DSm1j?=
 =?utf-8?B?dm9hdnBVN0xQWUpHeFNyQU5EbldmTEFwY01Td013TlpGcCtSNEtsNXFSeWUv?=
 =?utf-8?B?YjhxMlhkVkpxOTkydENQeUhxZFdpU3cxUjdTMXBadEpxeDZ5UE9sT0R4LzN5?=
 =?utf-8?B?c0V5Q3FuVEpWRkhsMElOeFhjY2hkREJWdy9UWFREMlFFTnJMaXRkU2tEU3dq?=
 =?utf-8?B?TW1HU1VMYUduM3dFay84NytKQ2prM2M0WWF3dWN4VTl6azVQMEdlblhJWll2?=
 =?utf-8?B?MTVNY0tsblN5MXFjcnlQSmJ5ZHhFL09Vc0lmbUU3b3RTTVhpaGl6MkR5Q25B?=
 =?utf-8?B?WWhteUs4c3pTNlM0UGtkaVFTMDVDYjE4ZFhDZTRJQU5hN0l3Mjh1UVVMa1RW?=
 =?utf-8?B?aEVmY3hMUTNBbERDM0ZUTDgvcjJaMkRWN2xFSGlZeTdDK20wODNWamRsR1Zr?=
 =?utf-8?B?U3hSSXJ3U0RqQzRFZ3pJcmoyaldPNDRMZXhhTEhJaHBTVXZWYS9xQjZBZEZS?=
 =?utf-8?B?SkFUUkZNQjJFcEwvMmREanF5Y2pvOUc5b1lCbEVMSjNGVWJZY0E2S2xJSzE2?=
 =?utf-8?B?UldMTGYzc2VIVU96aGpmL2c3blAxR2I2V0FsU1NkaVJiYm9yWHV2KzJlclpM?=
 =?utf-8?B?TU9vaGhPVmtkaE04SVJ5emFJcjBXcklZdDJhV1BhNW5sR2szcktpRkp6U1RY?=
 =?utf-8?B?R0pFeEZNV3N4bE5lUzU1QUtBTUwyeTNnTDFjb2R4S3g2YXpKRE9XK3FpVlZG?=
 =?utf-8?B?enJoRzIwNHlWY2JvOGQ3NlB4TUlXSlNXNWlrQWhDZjBqdlQxejIrWVcrZWwz?=
 =?utf-8?B?Yk9Yd2JGdkxOSHh3SjF1NzdRUVVoSVhPVW5rVS9ZTTFNMHU4R1BWNUNGQVJh?=
 =?utf-8?B?TnAzdHBEUTA0Z3lHYW9FWVhWMUl6UVJrWEFaWkc2ejR4SU1wZml5WEZZV1Ru?=
 =?utf-8?B?T0lxV0lkUzlTUnBIMjdnWkZmeEJzVUdzOXAvT1F1RWFsNzZxdHVqR3ZrcGxT?=
 =?utf-8?B?c1Vsd3d0dWpZUGNmM2VFQXY4a1VOV2l1SjJ5ajNra0srUXFxZU9nM2l4MklU?=
 =?utf-8?B?NGZmSUxHL0VMTGRtc3RiSlZ4Y0dhQmhKNzBuNFlKd2cyNzZHL1NBSkI1b2xE?=
 =?utf-8?B?WU02bWI1OUxSZjFnQVhHVkZuRWdHa1hLN0ZvM0h1RWY2VVFIOXZKL0t2MytJ?=
 =?utf-8?B?MVhvTzRIa3Z0VzFDclpKd3l4RGtxc0x1azFPWFRMQ0dvaHpoSWRkNW9NN25W?=
 =?utf-8?B?YnNhR2FIM3VjRlY2TkR6WTJGbWloaDkxenZIMWVtUyt5bW5OQkV5U2JwSy9G?=
 =?utf-8?B?Znpyd0RmY1ZkeGg1RGNyQWFTaUZyUFp0ejRNTWtrWmdUZ05ZczF1b0JXdVkw?=
 =?utf-8?B?UWdnN0JCa3hWVWx5d2V6K09ieWRkaE9BQ25oODVvdFpZd3VqWEtBSW1yME5h?=
 =?utf-8?B?OTRhWEdkbmRUOExQNWlFdkthSHJGSm1INHhNZGxRb2VTWjdyOUUvRWo2MkNT?=
 =?utf-8?B?dmczSnhvNTlrSDVlMmpyaHY1cU14NVFXTlh0aWhGVzFyQ1NrZ2pSYWgvQ2dn?=
 =?utf-8?B?ZHUyTFhIN0pBeXhXOWZnd01EK1Y2SFJaRk9hdFVmK3B2anZmcUhTL0NqeFN3?=
 =?utf-8?B?OHdCNEFUUUd4UnJwYk9MdGYxejZPanFrQStCWjZURTU0T3dJb0VkOGNQN1c4?=
 =?utf-8?B?ZFRNMzBsV3FOaS9ORVdEZE14QmxHd05tb3dvNFhhVU9QR1hTd1NHNlhGQjBJ?=
 =?utf-8?B?Z1M1VFB4dGF3VDJRT0VUaTZoSVpKNWplellpRVYxMTYzTXMrVkVQSERkdmpl?=
 =?utf-8?B?SXprNUVFN0lGQzF0L3NJRVU2SWhJZklpU1RyUEpTSHQzWEtBUHREVkZjNHFN?=
 =?utf-8?B?dUsxUWc4cXozRWZDNVV5c1JCQllCWGQ5djgxYXArRHdhUEVwSUpISmxubENH?=
 =?utf-8?Q?A30LZX?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:07.4581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0e0d83-8be2-454c-5414-08ddb7ffab61
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8534

Add in files that implement the use of the registers defined in the header
files added previously.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/chip.c     |16345 +++++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/chip_gen.c |  504 +
 drivers/infiniband/hw/hfi2/chip_jkr.c |  873 ++
 3 files changed, 17722 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/chip.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip_gen.c
 create mode 100644 drivers/infiniband/hw/hfi2/chip_jkr.c

diff --git a/drivers/infiniband/hw/hfi2/chip.c b/drivers/infiniband/hw/hfi2/chip.c
new file mode 100644
index 000000000000..5b22c7caa6dd
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip.c
@@ -0,0 +1,16345 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2021 Cornelis Networks.
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
+uint num_vls = HFI2_MAX_VLS_SUPPORTED;
+module_param(num_vls, uint, S_IRUGO);
+MODULE_PARM_DESC(num_vls, "Set number of Virtual Lanes to use (1-8)");
+
+/*
+ * Default time to aggregate two 10K packets from the idle state
+ * (timer not running). The timer starts at the end of the first packet,
+ * so only the time for one 10K packet and header plus a bit extra is needed.
+ * 10 * 1024 + 64 header byte = 10304 byte
+ * 10304 byte / 12.5 GB/s = 824.32ns
+ */
+uint rcv_intr_timeout = (824 + 16); /* 16 is for coalescing interrupt */
+module_param(rcv_intr_timeout, uint, S_IRUGO);
+MODULE_PARM_DESC(rcv_intr_timeout, "Receive interrupt mitigation timeout in ns");
+
+uint rcv_intr_count = 16; /* same as qib */
+module_param(rcv_intr_count, uint, S_IRUGO);
+MODULE_PARM_DESC(rcv_intr_count, "Receive interrupt mitigation count");
+
+ushort link_crc_mask = SUPPORTED_CRCS;
+module_param(link_crc_mask, ushort, S_IRUGO);
+MODULE_PARM_DESC(link_crc_mask, "CRCs to use on the link");
+
+uint loopback;
+module_param_named(loopback, loopback, uint, S_IRUGO);
+MODULE_PARM_DESC(loopback, "Put into loopback mode (1 = serdes, 3 = external cable");
+
+int sdma_yield = 1000;	/* how often to yield when in thrd intr handler */
+module_param_named(sdma_yield, sdma_yield, int, S_IWUSR | S_IRUGO);
+MODULE_PARM_DESC(sdma_yield, "How long to run threaded SDMA irq without yield, mS");
+
+/* Other driver tunables */
+uint rcv_intr_dynamic = 1; /* enable dynamic mode for rcv int mitigation*/
+static ushort crc_14b_sideband = 1;
+static uint use_flr = 1;
+uint quick_linkup; /* skip LNI */
+
+/* str must be a string constant */
+#define FLAG_ENTRY(str, extra, flag) {flag, str, extra}
+#define FLAG_ENTRY0(str, flag) {flag, str, 0}
+
+/* Send Error Consequences */
+#define SEC_WRITE_DROPPED	0x1
+#define SEC_PACKET_DROPPED	0x2
+#define SEC_SC_HALTED		0x4	/* per-context only */
+#define SEC_SPC_FREEZE		0x8	/* per-HFI only */
+
+#define DEFAULT_KRCVQS		  2
+#define MIN_KERNEL_KCTXTS         2
+#define FIRST_KERNEL_KCTXT        1
+
+/*
+ * RSM types
+ */
+#define RSM_TYPE_FECN             0
+#define RSM_TYPE_DEPRECATED       1
+#define RSM_TYPE_AIP              2
+#define RSM_TYPE_VERBS            3
+#define RSM_TYPE_MAD_RSP          4
+#define RSM_TYPE_MAD_ACTION       5
+
+/* Bit offset into the GUID which carries HFI id information */
+#define GUID_HFI_INDEX_SHIFT     39
+
+/* RSM fields for Verbs */
+#define QW_SHIFT               6ull
+/* QPN[7..1] */
+#define QPN_WIDTH              7ull
+
+/* LRH.BTH: QW 0, OFFSET 48 - for match */
+#define LRH_BTH_QW             0ull
+#define LRH_BTH_BIT_OFFSET     48ull
+#define LRH_BTH_OFFSET(off)    ((LRH_BTH_QW << QW_SHIFT) | (off))
+#define LRH_BTH_MATCH_OFFSET   LRH_BTH_OFFSET(LRH_BTH_BIT_OFFSET)
+#define LRH_BTH_SELECT
+#define LRH_BTH_MASK           3ull
+#define LRH_BTH_VALUE          2ull
+
+/* LRH.SC[3..0] QW 0, OFFSET 56 - for match */
+#define LRH_SC_QW              0ull
+#define LRH_SC_BIT_OFFSET      56ull
+#define LRH_SC_OFFSET(off)     ((LRH_SC_QW << QW_SHIFT) | (off))
+#define LRH_SC_MATCH_OFFSET    LRH_SC_OFFSET(LRH_SC_BIT_OFFSET)
+#define LRH_SC_MASK            128ull
+#define LRH_SC_VALUE           0ull
+
+/* SC[n..0] QW 0, OFFSET 60 - for select */
+#define LRH_SC_SELECT_OFFSET  ((LRH_SC_QW << QW_SHIFT) | (60ull))
+
+/* QPN[m+n:1] QW 1, OFFSET 1 */
+#define QPN_SELECT_OFFSET      ((1ull << QW_SHIFT) | (1ull))
+
+/* RSM fields for AIP */
+/* LRH.BTH above is reused for this rule */
+
+/* BTH.DESTQP: QW 1, OFFSET 16 for match */
+#define BTH_DESTQP_QW           1ull
+#define BTH_DESTQP_BIT_OFFSET   16ull
+#define BTH_DESTQP_OFFSET(off) ((BTH_DESTQP_QW << QW_SHIFT) | (off))
+#define BTH_DESTQP_MATCH_OFFSET BTH_DESTQP_OFFSET(BTH_DESTQP_BIT_OFFSET)
+#define BTH_DESTQP_MASK         0xFFull
+#define BTH_DESTQP_VALUE        0x81ull
+
+/* DETH.SQPN: QW 1 Offset 56 for select */
+/* We use 8 most significant Soure QPN bits as entropy fpr AIP */
+#define DETH_AIP_SQPN_QW 3ull
+#define DETH_AIP_SQPN_BIT_OFFSET 56ull
+#define DETH_AIP_SQPN_OFFSET(off) ((DETH_AIP_SQPN_QW << QW_SHIFT) | (off))
+#define DETH_AIP_SQPN_SELECT_OFFSET \
+	DETH_AIP_SQPN_OFFSET(DETH_AIP_SQPN_BIT_OFFSET)
+
+/* L4_TYPE QW 1, OFFSET 0 - for match */
+#define L4_TYPE_QW              1ull
+#define L4_TYPE_BIT_OFFSET      0ull
+#define L4_TYPE_OFFSET(off)     ((L4_TYPE_QW << QW_SHIFT) | (off))
+#define L4_TYPE_MATCH_OFFSET    L4_TYPE_OFFSET(L4_TYPE_BIT_OFFSET)
+#define L4_16B_TYPE_MASK        0xFFull
+#define L4_16B_ETH_VALUE        0x78ull
+
+/* 16B VESWID - for select */
+#define L4_16B_HDR_VESWID_OFFSET  ((2 << QW_SHIFT) | (16ull))
+/* 16B ENTROPY - for select */
+#define L2_16B_ENTROPY_OFFSET     ((1 << QW_SHIFT) | (32ull))
+
+/* defines to build power on SC2VL table */
+#define SC2VL_VAL( \
+	num, \
+	sc0, sc0val, \
+	sc1, sc1val, \
+	sc2, sc2val, \
+	sc3, sc3val, \
+	sc4, sc4val, \
+	sc5, sc5val, \
+	sc6, sc6val, \
+	sc7, sc7val) \
+( \
+	((u64)(sc0val) << SEND_SC2VLT##num##_SC##sc0##_SHIFT) | \
+	((u64)(sc1val) << SEND_SC2VLT##num##_SC##sc1##_SHIFT) | \
+	((u64)(sc2val) << SEND_SC2VLT##num##_SC##sc2##_SHIFT) | \
+	((u64)(sc3val) << SEND_SC2VLT##num##_SC##sc3##_SHIFT) | \
+	((u64)(sc4val) << SEND_SC2VLT##num##_SC##sc4##_SHIFT) | \
+	((u64)(sc5val) << SEND_SC2VLT##num##_SC##sc5##_SHIFT) | \
+	((u64)(sc6val) << SEND_SC2VLT##num##_SC##sc6##_SHIFT) | \
+	((u64)(sc7val) << SEND_SC2VLT##num##_SC##sc7##_SHIFT)   \
+)
+
+#define DC_SC_VL_VAL( \
+	range, \
+	e0, e0val, \
+	e1, e1val, \
+	e2, e2val, \
+	e3, e3val, \
+	e4, e4val, \
+	e5, e5val, \
+	e6, e6val, \
+	e7, e7val, \
+	e8, e8val, \
+	e9, e9val, \
+	e10, e10val, \
+	e11, e11val, \
+	e12, e12val, \
+	e13, e13val, \
+	e14, e14val, \
+	e15, e15val) \
+( \
+	((u64)(e0val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e0##_SHIFT) | \
+	((u64)(e1val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e1##_SHIFT) | \
+	((u64)(e2val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e2##_SHIFT) | \
+	((u64)(e3val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e3##_SHIFT) | \
+	((u64)(e4val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e4##_SHIFT) | \
+	((u64)(e5val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e5##_SHIFT) | \
+	((u64)(e6val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e6##_SHIFT) | \
+	((u64)(e7val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e7##_SHIFT) | \
+	((u64)(e8val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e8##_SHIFT) | \
+	((u64)(e9val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e9##_SHIFT) | \
+	((u64)(e10val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e10##_SHIFT) | \
+	((u64)(e11val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e11##_SHIFT) | \
+	((u64)(e12val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e12##_SHIFT) | \
+	((u64)(e13val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e13##_SHIFT) | \
+	((u64)(e14val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e14##_SHIFT) | \
+	((u64)(e15val) << DCC_CFG_SC_VL_TABLE_##range##_ENTRY##e15##_SHIFT) \
+)
+
+/* all CceStatus sub-block freeze bits */
+#define ALL_FROZE (CCE_STATUS_SDMA_FROZE_SMASK \
+			| CCE_STATUS_RXE_FROZE_SMASK \
+			| CCE_STATUS_TXE_FROZE_SMASK \
+			| CCE_STATUS_TXE_PIO_FROZE_SMASK)
+/* all CceStatus sub-block TXE pause bits */
+#define ALL_TXE_PAUSE (CCE_STATUS_TXE_PIO_PAUSED_SMASK \
+			| CCE_STATUS_TXE_PAUSED_SMASK \
+			| CCE_STATUS_SDMA_PAUSED_SMASK)
+/* all CceStatus sub-block RXE pause bits */
+#define ALL_RXE_PAUSE CCE_STATUS_RXE_PAUSED_SMASK
+
+#define CNTR_MAX 0xFFFFFFFFFFFFFFFFULL
+#define CNTR_32BIT_MAX 0x00000000FFFFFFFF
+
+/*
+ * CCE Error flags.
+ */
+static const struct flag_table cce_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("CceCsrParityErr",
+		CCE_ERR_STATUS_CCE_CSR_PARITY_ERR_SMASK),
+/* 1*/	FLAG_ENTRY0("CceCsrReadBadAddrErr",
+		CCE_ERR_STATUS_CCE_CSR_READ_BAD_ADDR_ERR_SMASK),
+/* 2*/	FLAG_ENTRY0("CceCsrWriteBadAddrErr",
+		CCE_ERR_STATUS_CCE_CSR_WRITE_BAD_ADDR_ERR_SMASK),
+/* 3*/	FLAG_ENTRY0("CceTrgtAsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_TRGT_ASYNC_FIFO_PARITY_ERR_SMASK),
+/* 4*/	FLAG_ENTRY0("CceTrgtAccessErr",
+		CCE_ERR_STATUS_CCE_TRGT_ACCESS_ERR_SMASK),
+/* 5*/	FLAG_ENTRY0("CceRspdDataParityErr",
+		CCE_ERR_STATUS_CCE_RSPD_DATA_PARITY_ERR_SMASK),
+/* 6*/	FLAG_ENTRY0("CceCli0AsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_CLI0_ASYNC_FIFO_PARITY_ERR_SMASK),
+/* 7*/	FLAG_ENTRY0("CceCsrCfgBusParityErr",
+		CCE_ERR_STATUS_CCE_CSR_CFG_BUS_PARITY_ERR_SMASK),
+/* 8*/	FLAG_ENTRY0("CceCli2AsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_CLI2_ASYNC_FIFO_PARITY_ERR_SMASK),
+/* 9*/	FLAG_ENTRY0("CceCli1AsyncFifoPioCrdtParityErr",
+	    CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_PIO_CRDT_PARITY_ERR_SMASK),
+/*10*/	FLAG_ENTRY0("CceCli1AsyncFifoPioCrdtParityErr",
+	    CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_SDMA_HD_PARITY_ERR_SMASK),
+/*11*/	FLAG_ENTRY0("CceCli1AsyncFifoRxdmaParityError",
+	    CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_RXDMA_PARITY_ERROR_SMASK),
+/*12*/	FLAG_ENTRY0("CceCli1AsyncFifoDbgParityError",
+		CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_DBG_PARITY_ERROR_SMASK),
+/*13*/	FLAG_ENTRY0("PcicRetryMemCorErr",
+		CCE_ERR_STATUS_PCIC_RETRY_MEM_COR_ERR_SMASK),
+/*14*/	FLAG_ENTRY0("PcicRetryMemCorErr",
+		CCE_ERR_STATUS_PCIC_RETRY_SOT_MEM_COR_ERR_SMASK),
+/*15*/	FLAG_ENTRY0("PcicPostHdQCorErr",
+		CCE_ERR_STATUS_PCIC_POST_HD_QCOR_ERR_SMASK),
+/*16*/	FLAG_ENTRY0("PcicPostHdQCorErr",
+		CCE_ERR_STATUS_PCIC_POST_DAT_QCOR_ERR_SMASK),
+/*17*/	FLAG_ENTRY0("PcicPostHdQCorErr",
+		CCE_ERR_STATUS_PCIC_CPL_HD_QCOR_ERR_SMASK),
+/*18*/	FLAG_ENTRY0("PcicCplDatQCorErr",
+		CCE_ERR_STATUS_PCIC_CPL_DAT_QCOR_ERR_SMASK),
+/*19*/	FLAG_ENTRY0("PcicNPostHQParityErr",
+		CCE_ERR_STATUS_PCIC_NPOST_HQ_PARITY_ERR_SMASK),
+/*20*/	FLAG_ENTRY0("PcicNPostDatQParityErr",
+		CCE_ERR_STATUS_PCIC_NPOST_DAT_QPARITY_ERR_SMASK),
+/*21*/	FLAG_ENTRY0("PcicRetryMemUncErr",
+		CCE_ERR_STATUS_PCIC_RETRY_MEM_UNC_ERR_SMASK),
+/*22*/	FLAG_ENTRY0("PcicRetrySotMemUncErr",
+		CCE_ERR_STATUS_PCIC_RETRY_SOT_MEM_UNC_ERR_SMASK),
+/*23*/	FLAG_ENTRY0("PcicPostHdQUncErr",
+		CCE_ERR_STATUS_PCIC_POST_HD_QUNC_ERR_SMASK),
+/*24*/	FLAG_ENTRY0("PcicPostDatQUncErr",
+		CCE_ERR_STATUS_PCIC_POST_DAT_QUNC_ERR_SMASK),
+/*25*/	FLAG_ENTRY0("PcicCplHdQUncErr",
+		CCE_ERR_STATUS_PCIC_CPL_HD_QUNC_ERR_SMASK),
+/*26*/	FLAG_ENTRY0("PcicCplDatQUncErr",
+		CCE_ERR_STATUS_PCIC_CPL_DAT_QUNC_ERR_SMASK),
+/*27*/	FLAG_ENTRY0("PcicTransmitFrontParityErr",
+		CCE_ERR_STATUS_PCIC_TRANSMIT_FRONT_PARITY_ERR_SMASK),
+/*28*/	FLAG_ENTRY0("PcicTransmitBackParityErr",
+		CCE_ERR_STATUS_PCIC_TRANSMIT_BACK_PARITY_ERR_SMASK),
+/*29*/	FLAG_ENTRY0("PcicReceiveParityErr",
+		CCE_ERR_STATUS_PCIC_RECEIVE_PARITY_ERR_SMASK),
+/*30*/	FLAG_ENTRY0("CceTrgtCplTimeoutErr",
+		CCE_ERR_STATUS_CCE_TRGT_CPL_TIMEOUT_ERR_SMASK),
+/*31*/	FLAG_ENTRY0("LATriggered",
+		CCE_ERR_STATUS_LA_TRIGGERED_SMASK),
+/*32*/	FLAG_ENTRY0("CceSegReadBadAddrErr",
+		CCE_ERR_STATUS_CCE_SEG_READ_BAD_ADDR_ERR_SMASK),
+/*33*/	FLAG_ENTRY0("CceSegWriteBadAddrErr",
+		CCE_ERR_STATUS_CCE_SEG_WRITE_BAD_ADDR_ERR_SMASK),
+/*34*/	FLAG_ENTRY0("CceRcplAsyncFifoParityErr",
+		CCE_ERR_STATUS_CCE_RCPL_ASYNC_FIFO_PARITY_ERR_SMASK),
+/*35*/	FLAG_ENTRY0("CceRxdmaConvFifoParityErr",
+		CCE_ERR_STATUS_CCE_RXDMA_CONV_FIFO_PARITY_ERR_SMASK),
+/*36*/	FLAG_ENTRY0("CceMsixTableCorErr",
+		CCE_ERR_STATUS_CCE_MSIX_TABLE_COR_ERR_SMASK),
+/*37*/	FLAG_ENTRY0("CceMsixTableUncErr",
+		CCE_ERR_STATUS_CCE_MSIX_TABLE_UNC_ERR_SMASK),
+/*38*/	FLAG_ENTRY0("CceIntMapCorErr",
+		CCE_ERR_STATUS_CCE_INT_MAP_COR_ERR_SMASK),
+/*39*/	FLAG_ENTRY0("CceIntMapUncErr",
+		CCE_ERR_STATUS_CCE_INT_MAP_UNC_ERR_SMASK),
+/*40*/	FLAG_ENTRY0("CceMsixCsrParityErr",
+		CCE_ERR_STATUS_CCE_MSIX_CSR_PARITY_ERR_SMASK),
+/*41-63 reserved*/
+};
+
+/*
+ * Misc Error flags
+ */
+#define MES(text) MISC_ERR_STATUS_MISC_##text##_ERR_SMASK
+static const struct flag_table misc_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("CSR_PARITY", MES(CSR_PARITY)),
+/* 1*/	FLAG_ENTRY0("CSR_READ_BAD_ADDR", MES(CSR_READ_BAD_ADDR)),
+/* 2*/	FLAG_ENTRY0("CSR_WRITE_BAD_ADDR", MES(CSR_WRITE_BAD_ADDR)),
+/* 3*/	FLAG_ENTRY0("SBUS_WRITE_FAILED", MES(SBUS_WRITE_FAILED)),
+/* 4*/	FLAG_ENTRY0("KEY_MISMATCH", MES(KEY_MISMATCH)),
+/* 5*/	FLAG_ENTRY0("FW_AUTH_FAILED", MES(FW_AUTH_FAILED)),
+/* 6*/	FLAG_ENTRY0("EFUSE_CSR_PARITY", MES(EFUSE_CSR_PARITY)),
+/* 7*/	FLAG_ENTRY0("EFUSE_READ_BAD_ADDR", MES(EFUSE_READ_BAD_ADDR)),
+/* 8*/	FLAG_ENTRY0("EFUSE_WRITE", MES(EFUSE_WRITE)),
+/* 9*/	FLAG_ENTRY0("EFUSE_DONE_PARITY", MES(EFUSE_DONE_PARITY)),
+/*10*/	FLAG_ENTRY0("INVALID_EEP_CMD", MES(INVALID_EEP_CMD)),
+/*11*/	FLAG_ENTRY0("MBIST_FAIL", MES(MBIST_FAIL)),
+/*12*/	FLAG_ENTRY0("PLL_LOCK_FAIL", MES(PLL_LOCK_FAIL))
+};
+
+/*
+ * TXE PIO Error flags and consequences
+ */
+static const struct flag_table pio_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY("PioWriteBadCtxt",
+	SEC_WRITE_DROPPED,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_BAD_CTXT_ERR_SMASK),
+/* 1*/	FLAG_ENTRY("PioWriteAddrParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_ADDR_PARITY_ERR_SMASK),
+/* 2*/	FLAG_ENTRY("PioCsrParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_CSR_PARITY_ERR_SMASK),
+/* 3*/	FLAG_ENTRY("PioSbMemFifo0",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO0_ERR_SMASK),
+/* 4*/	FLAG_ENTRY("PioSbMemFifo1",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO1_ERR_SMASK),
+/* 5*/	FLAG_ENTRY("PioPccFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PCC_FIFO_PARITY_ERR_SMASK),
+/* 6*/	FLAG_ENTRY("PioPecFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PEC_FIFO_PARITY_ERR_SMASK),
+/* 7*/	FLAG_ENTRY("PioSbrdctlCrrelParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SBRDCTL_CRREL_PARITY_ERR_SMASK),
+/* 8*/	FLAG_ENTRY("PioSbrdctrlCrrelFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR_SMASK),
+/* 9*/	FLAG_ENTRY("PioPktEvictFifoParityErr",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_FIFO_PARITY_ERR_SMASK),
+/*10*/	FLAG_ENTRY("PioSmPktResetParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_SM_PKT_RESET_PARITY_ERR_SMASK),
+/*11*/	FLAG_ENTRY("PioVlLenMemBank0Unc",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_UNC_ERR_SMASK),
+/*12*/	FLAG_ENTRY("PioVlLenMemBank1Unc",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_UNC_ERR_SMASK),
+/*13*/	FLAG_ENTRY("PioVlLenMemBank0Cor",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_COR_ERR_SMASK),
+/*14*/	FLAG_ENTRY("PioVlLenMemBank1Cor",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_COR_ERR_SMASK),
+/*15*/	FLAG_ENTRY("PioCreditRetFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_CREDIT_RET_FIFO_PARITY_ERR_SMASK),
+/*16*/	FLAG_ENTRY("PioPpmcPblFifo",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PPMC_PBL_FIFO_ERR_SMASK),
+/*17*/	FLAG_ENTRY("PioInitSmIn",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_INIT_SM_IN_ERR_SMASK),
+/*18*/	FLAG_ENTRY("PioPktEvictSmOrArbSm",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_SM_OR_ARB_SM_ERR_SMASK),
+/*19*/	FLAG_ENTRY("PioHostAddrMemUnc",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_UNC_ERR_SMASK),
+/*20*/	FLAG_ENTRY("PioHostAddrMemCor",
+	0,
+	SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_COR_ERR_SMASK),
+/*21*/	FLAG_ENTRY("PioWriteDataParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_DATA_PARITY_ERR_SMASK),
+/*22*/	FLAG_ENTRY("PioStateMachine",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_STATE_MACHINE_ERR_SMASK),
+/*23*/	FLAG_ENTRY("PioWriteQwValidParity",
+	SEC_WRITE_DROPPED | SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_WRITE_QW_VALID_PARITY_ERR_SMASK),
+/*24*/	FLAG_ENTRY("PioBlockQwCountParity",
+	SEC_WRITE_DROPPED | SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_BLOCK_QW_COUNT_PARITY_ERR_SMASK),
+/*25*/	FLAG_ENTRY("PioVlfVlLenParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VLF_VL_LEN_PARITY_ERR_SMASK),
+/*26*/	FLAG_ENTRY("PioVlfSopParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VLF_SOP_PARITY_ERR_SMASK),
+/*27*/	FLAG_ENTRY("PioVlFifoParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_VL_FIFO_PARITY_ERR_SMASK),
+/*28*/	FLAG_ENTRY("PioPpmcBqcMemParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PPMC_BQC_MEM_PARITY_ERR_SMASK),
+/*29*/	FLAG_ENTRY("PioPpmcSopLen",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PPMC_SOP_LEN_ERR_SMASK),
+/*30-31 reserved*/
+/*32*/	FLAG_ENTRY("PioCurrentFreeCntParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_CURRENT_FREE_CNT_PARITY_ERR_SMASK),
+/*33*/	FLAG_ENTRY("PioLastReturnedCntParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_LAST_RETURNED_CNT_PARITY_ERR_SMASK),
+/*34*/	FLAG_ENTRY("PioPccSopHeadParity",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PCC_SOP_HEAD_PARITY_ERR_SMASK),
+/*35*/	FLAG_ENTRY("PioPecSopHeadParityErr",
+	SEC_SPC_FREEZE,
+	SEND_PIO_ERR_STATUS_PIO_PEC_SOP_HEAD_PARITY_ERR_SMASK),
+/*36-63 reserved*/
+};
+
+/* TXE PIO errors that cause an SPC freeze */
+#define ALL_PIO_FREEZE_ERR \
+	(SEND_PIO_ERR_STATUS_PIO_WRITE_ADDR_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_CSR_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO0_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO1_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PCC_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PEC_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SBRDCTL_CRREL_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_SM_PKT_RESET_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_UNC_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_UNC_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_CREDIT_RET_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PPMC_PBL_FIFO_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_SM_OR_ARB_SM_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_UNC_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_WRITE_DATA_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_STATE_MACHINE_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_WRITE_QW_VALID_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_BLOCK_QW_COUNT_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VLF_VL_LEN_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VLF_SOP_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_VL_FIFO_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PPMC_BQC_MEM_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PPMC_SOP_LEN_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_CURRENT_FREE_CNT_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_LAST_RETURNED_CNT_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PCC_SOP_HEAD_PARITY_ERR_SMASK \
+	| SEND_PIO_ERR_STATUS_PIO_PEC_SOP_HEAD_PARITY_ERR_SMASK)
+
+/*
+ * TXE SDMA Error flags
+ */
+static const struct flag_table sdma_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("SDmaRpyTagErr",
+		SEND_DMA_ERR_STATUS_SDMA_RPY_TAG_ERR_SMASK),
+/* 1*/	FLAG_ENTRY0("SDmaCsrParityErr",
+		SEND_DMA_ERR_STATUS_SDMA_CSR_PARITY_ERR_SMASK),
+/* 2*/	FLAG_ENTRY0("SDmaPcieReqTrackingUncErr",
+		SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_UNC_ERR_SMASK),
+/* 3*/	FLAG_ENTRY0("SDmaPcieReqTrackingCorErr",
+		SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_COR_ERR_SMASK),
+/*04-63 reserved*/
+};
+
+/* TXE SDMA errors that cause an SPC freeze */
+#define ALL_SDMA_FREEZE_ERR  \
+		(SEND_DMA_ERR_STATUS_SDMA_RPY_TAG_ERR_SMASK \
+		| SEND_DMA_ERR_STATUS_SDMA_CSR_PARITY_ERR_SMASK \
+		| SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_UNC_ERR_SMASK)
+
+/*
+ * TXE Egress Error flags
+ */
+#define SEES(text) SEND_EGRESS_ERR_STATUS_##text##_ERR_SMASK
+static struct flag_table egress_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("TxPktIntegrityMemCorErr", SEES(TX_PKT_INTEGRITY_MEM_COR)), /* WFR */
+/* 1*/	FLAG_ENTRY0("TxPktIntegrityMemUncErr", SEES(TX_PKT_INTEGRITY_MEM_UNC)), /* WFR */
+/* 2 reserved */
+/* 3*/	FLAG_ENTRY0("TxEgressFifoUnderrunOrParityErr",
+		SEES(TX_EGRESS_FIFO_UNDERRUN_OR_PARITY)),
+/* 4*/	FLAG_ENTRY0("TxLinkdownErr", SEES(TX_LINKDOWN)),
+/* 5*/	FLAG_ENTRY0("TxIncorrectLinkStateErr", SEES(TX_INCORRECT_LINK_STATE)),
+/* 6 reserved */
+/* 7*/	FLAG_ENTRY0("TxPioLaunchIntfParityErr",
+		SEES(TX_PIO_LAUNCH_INTF_PARITY)),
+/* 8*/	FLAG_ENTRY0("TxSdmaLaunchIntfParityErr",
+		SEES(TX_SDMA_LAUNCH_INTF_PARITY)),
+/* 9-10 reserved */
+/*11*/	FLAG_ENTRY0("TxSbrdCtlStateMachineParityErr",
+		SEES(TX_SBRD_CTL_STATE_MACHINE_PARITY)),
+/*12*/	FLAG_ENTRY0("TxIllegalVLErr", SEES(TX_ILLEGAL_VL)),
+/*13*/	FLAG_ENTRY0("TxLaunchCsrParityErr", SEES(TX_LAUNCH_CSR_PARITY)), /* WFR */
+/*14*/	FLAG_ENTRY0("TxSbrdCtlCsrParityErr", SEES(TX_SBRD_CTL_CSR_PARITY)),
+/*15*/	FLAG_ENTRY0("TxConfigParityErr", SEES(TX_CONFIG_PARITY)),
+/*16*/	FLAG_ENTRY0("TxSdma0DisallowedPacketErr",
+		SEES(TX_SDMA0_DISALLOWED_PACKET)),
+/*17*/	FLAG_ENTRY0("TxSdma1DisallowedPacketErr",
+		SEES(TX_SDMA1_DISALLOWED_PACKET)),
+/*18*/	FLAG_ENTRY0("TxSdma2DisallowedPacketErr",
+		SEES(TX_SDMA2_DISALLOWED_PACKET)),
+/*19*/	FLAG_ENTRY0("TxSdma3DisallowedPacketErr",
+		SEES(TX_SDMA3_DISALLOWED_PACKET)),
+/*20*/	FLAG_ENTRY0("TxSdma4DisallowedPacketErr",
+		SEES(TX_SDMA4_DISALLOWED_PACKET)),
+/*21*/	FLAG_ENTRY0("TxSdma5DisallowedPacketErr",
+		SEES(TX_SDMA5_DISALLOWED_PACKET)),
+/*22*/	FLAG_ENTRY0("TxSdma6DisallowedPacketErr",
+		SEES(TX_SDMA6_DISALLOWED_PACKET)),
+/*23*/	FLAG_ENTRY0("TxSdma7DisallowedPacketErr",
+		SEES(TX_SDMA7_DISALLOWED_PACKET)),
+/*24*/	FLAG_ENTRY0("TxSdma8DisallowedPacketErr",
+		SEES(TX_SDMA8_DISALLOWED_PACKET)),
+/*25*/	FLAG_ENTRY0("TxSdma9DisallowedPacketErr",
+		SEES(TX_SDMA9_DISALLOWED_PACKET)),
+/*26*/	FLAG_ENTRY0("TxSdma10DisallowedPacketErr",
+		SEES(TX_SDMA10_DISALLOWED_PACKET)),
+/*27*/	FLAG_ENTRY0("TxSdma11DisallowedPacketErr",
+		SEES(TX_SDMA11_DISALLOWED_PACKET)),
+/*28*/	FLAG_ENTRY0("TxSdma12DisallowedPacketErr",
+		SEES(TX_SDMA12_DISALLOWED_PACKET)),
+/*29*/	FLAG_ENTRY0("TxSdma13DisallowedPacketErr",
+		SEES(TX_SDMA13_DISALLOWED_PACKET)),
+/*30*/	FLAG_ENTRY0("TxSdma14DisallowedPacketErr",
+		SEES(TX_SDMA14_DISALLOWED_PACKET)),
+/*31*/	FLAG_ENTRY0("TxSdma15DisallowedPacketErr",
+		SEES(TX_SDMA15_DISALLOWED_PACKET)),
+/*32*/	FLAG_ENTRY0("TxLaunchFifo0UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO0_UNC_OR_PARITY)),
+/*33*/	FLAG_ENTRY0("TxLaunchFifo1UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO1_UNC_OR_PARITY)),
+/*34*/	FLAG_ENTRY0("TxLaunchFifo2UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO2_UNC_OR_PARITY)),
+/*35*/	FLAG_ENTRY0("TxLaunchFifo3UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO3_UNC_OR_PARITY)),
+/*36*/	FLAG_ENTRY0("TxLaunchFifo4UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO4_UNC_OR_PARITY)),
+/*37*/	FLAG_ENTRY0("TxLaunchFifo5UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO5_UNC_OR_PARITY)),
+/*38*/	FLAG_ENTRY0("TxLaunchFifo6UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO6_UNC_OR_PARITY)),
+/*39*/	FLAG_ENTRY0("TxLaunchFifo7UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO7_UNC_OR_PARITY)),
+/*40*/	FLAG_ENTRY0("TxLaunchFifo8UncOrParityErr",
+		SEES(TX_LAUNCH_FIFO8_UNC_OR_PARITY)),
+/*41*/	FLAG_ENTRY0("TxCreditReturnParityErr", SEES(TX_CREDIT_RETURN_PARITY)),
+/*42*/	FLAG_ENTRY0("TxSbHdrUncErr", SEES(TX_SB_HDR_UNC)),
+/*43*/	FLAG_ENTRY0("TxReadSdmaMemoryUncErr", SEES(TX_READ_SDMA_MEMORY_UNC)),
+/*44*/	FLAG_ENTRY0("TxReadPioMemoryUncErr", SEES(TX_READ_PIO_MEMORY_UNC)),
+/*45*/	FLAG_ENTRY0("TxEgressFifoUncErr", SEES(TX_EGRESS_FIFO_UNC)),
+/*46*/	FLAG_ENTRY0("TxHcrcInsertionErr", SEES(TX_HCRC_INSERTION)),
+/*47*/	FLAG_ENTRY0("TxCreditReturnVLErr", SEES(TX_CREDIT_RETURN_VL)),
+/*48*/	FLAG_ENTRY0("TxLaunchFifo0CorErr", SEES(TX_LAUNCH_FIFO0_COR)),
+/*49*/	FLAG_ENTRY0("TxLaunchFifo1CorErr", SEES(TX_LAUNCH_FIFO1_COR)),
+/*50*/	FLAG_ENTRY0("TxLaunchFifo2CorErr", SEES(TX_LAUNCH_FIFO2_COR)),
+/*51*/	FLAG_ENTRY0("TxLaunchFifo3CorErr", SEES(TX_LAUNCH_FIFO3_COR)),
+/*52*/	FLAG_ENTRY0("TxLaunchFifo4CorErr", SEES(TX_LAUNCH_FIFO4_COR)),
+/*53*/	FLAG_ENTRY0("TxLaunchFifo5CorErr", SEES(TX_LAUNCH_FIFO5_COR)),
+/*54*/	FLAG_ENTRY0("TxLaunchFifo6CorErr", SEES(TX_LAUNCH_FIFO6_COR)),
+/*55*/	FLAG_ENTRY0("TxLaunchFifo7CorErr", SEES(TX_LAUNCH_FIFO7_COR)),
+/*56*/	FLAG_ENTRY0("TxLaunchFifo8CorErr", SEES(TX_LAUNCH_FIFO8_COR)),
+/*57*/	FLAG_ENTRY0("TxCreditOverrunErr", SEES(TX_CREDIT_OVERRUN)),
+/*58*/	FLAG_ENTRY0("TxSbHdrCorErr", SEES(TX_SB_HDR_COR)),
+/*59*/	FLAG_ENTRY0("TxReadSdmaMemoryCorErr", SEES(TX_READ_SDMA_MEMORY_COR)),
+/*60*/	FLAG_ENTRY0("TxReadPioMemoryCorErr", SEES(TX_READ_PIO_MEMORY_COR)),
+/*61*/	FLAG_ENTRY0("TxEgressFifoCorErr", SEES(TX_EGRESS_FIFO_COR)),
+/*62*/	FLAG_ENTRY0("TxReadSdmaMemoryCsrUncErr",
+		SEES(TX_READ_SDMA_MEMORY_CSR_UNC)), /* WFR */
+/*63*/	FLAG_ENTRY0("TxReadPioMemoryCsrUncErr",
+		SEES(TX_READ_PIO_MEMORY_CSR_UNC)), /* WFR */
+};
+
+/*
+ * TXE Egress Error Info flags
+ */
+#define SEEI(text) SEND_EGRESS_ERR_INFO_##text##_ERR_SMASK
+const struct flag_table wfr_egress_err_info_flags[] = {
+/* 0*/	FLAG_ENTRY0("Reserved", 0ull),
+/* 1*/	FLAG_ENTRY0("VLErr", SEEI(VL)),
+/* 2*/	FLAG_ENTRY0("JobKeyErr", SEEI(JOB_KEY)),
+/* 3*/	FLAG_ENTRY0("JobKeyErr", SEEI(JOB_KEY)),
+/* 4*/	FLAG_ENTRY0("PartitionKeyErr", SEEI(PARTITION_KEY)),
+/* 5*/	FLAG_ENTRY0("SLIDErr", SEEI(SLID)),
+/* 6*/	FLAG_ENTRY0("OpcodeErr", SEEI(OPCODE)),
+/* 7*/	FLAG_ENTRY0("VLMappingErr", SEEI(VL_MAPPING)),
+/* 8*/	FLAG_ENTRY0("RawErr", SEEI(RAW)),
+/* 9*/	FLAG_ENTRY0("RawIPv6Err", SEEI(RAW_IPV6)),
+/*10*/	FLAG_ENTRY0("GRHErr", SEEI(GRH)),
+/*11*/	FLAG_ENTRY0("BypassErr", SEEI(BYPASS)),
+/*12*/	FLAG_ENTRY0("KDETHPacketsErr", SEEI(KDETH_PACKETS)),
+/*13*/	FLAG_ENTRY0("NonKDETHPacketsErr", SEEI(NON_KDETH_PACKETS)),
+/*14*/	FLAG_ENTRY0("TooSmallIBPacketsErr", SEEI(TOO_SMALL_IB_PACKETS)),
+/*15*/	FLAG_ENTRY0("TooSmallBypassPacketsErr", SEEI(TOO_SMALL_BYPASS_PACKETS)),
+/*16*/	FLAG_ENTRY0("PbcTestErr", SEEI(PBC_TEST)),
+/*17*/	FLAG_ENTRY0("BadPktLenErr", SEEI(BAD_PKT_LEN)),
+/*18*/	FLAG_ENTRY0("TooLongIBPacketErr", SEEI(TOO_LONG_IB_PACKET)),
+/*19*/	FLAG_ENTRY0("TooLongBypassPacketsErr", SEEI(TOO_LONG_BYPASS_PACKETS)),
+/*20*/	FLAG_ENTRY0("PbcStaticRateControlErr", SEEI(PBC_STATIC_RATE_CONTROL)),
+/*21*/	FLAG_ENTRY0("BypassBadPktLenErr", SEEI(BAD_PKT_LEN)),
+};
+const struct flag_data wfr_egress_err_info_data = {
+	.table = wfr_egress_err_info_flags,
+	.size = ARRAY_SIZE(wfr_egress_err_info_flags),
+};
+
+/* TXE Egress errors that cause an SPC freeze */
+#define ALL_TXE_EGRESS_FREEZE_ERR \
+	(SEES(TX_EGRESS_FIFO_UNDERRUN_OR_PARITY) \
+	| SEES(TX_PIO_LAUNCH_INTF_PARITY) \
+	| SEES(TX_SDMA_LAUNCH_INTF_PARITY) \
+	| SEES(TX_SBRD_CTL_STATE_MACHINE_PARITY) \
+	| SEES(TX_LAUNCH_CSR_PARITY) \
+	| SEES(TX_SBRD_CTL_CSR_PARITY) \
+	| SEES(TX_CONFIG_PARITY) \
+	| SEES(TX_LAUNCH_FIFO0_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO1_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO2_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO3_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO4_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO5_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO6_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO7_UNC_OR_PARITY) \
+	| SEES(TX_LAUNCH_FIFO8_UNC_OR_PARITY) \
+	| SEES(TX_CREDIT_RETURN_PARITY))
+
+/*
+ * TXE Send error flags
+ */
+#define SES(name) SEND_ERR_STATUS_SEND_##name##_ERR_SMASK
+static const struct flag_table send_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("SendCsrParityErr", SES(CSR_PARITY)),
+/* 1*/	FLAG_ENTRY0("SendCsrReadBadAddrErr", SES(CSR_READ_BAD_ADDR)),
+/* 2*/	FLAG_ENTRY0("SendCsrWriteBadAddrErr", SES(CSR_WRITE_BAD_ADDR))
+};
+
+/*
+ * TXE Send Context Error flags and consequences
+ */
+static const struct flag_table sc_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY("InconsistentSop",
+		SEC_PACKET_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_INCONSISTENT_SOP_ERR_SMASK),
+/* 1*/	FLAG_ENTRY("DisallowedPacket",
+		SEC_PACKET_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_DISALLOWED_PACKET_ERR_SMASK),
+/* 2*/	FLAG_ENTRY("WriteCrossesBoundary",
+		SEC_WRITE_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_WRITE_CROSSES_BOUNDARY_ERR_SMASK),
+/* 3*/	FLAG_ENTRY("WriteOverflow",
+		SEC_WRITE_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_WRITE_OVERFLOW_ERR_SMASK),
+/* 4*/	FLAG_ENTRY("WriteOutOfBounds",
+		SEC_WRITE_DROPPED | SEC_SC_HALTED,
+		SEND_CTXT_ERR_STATUS_PIO_WRITE_OUT_OF_BOUNDS_ERR_SMASK),
+/* 5-63 reserved*/
+};
+
+/*
+ * RXE Receive Error flags
+ */
+#define RXES(name) RCV_ERR_STATUS_RX_##name##_ERR_SMASK
+static const struct flag_table rxe_err_status_flags[] = {
+/* 0*/	FLAG_ENTRY0("RxDmaCsrCorErr", RXES(DMA_CSR_COR)),
+/* 1*/	FLAG_ENTRY0("RxCrkIntfParityErr", RXES(DC_INTF_PARITY)),
+/* 2*/	FLAG_ENTRY0("RxRcvHdrUncErr", RXES(RCV_HDR_UNC)),
+/* 3*/	FLAG_ENTRY0("RxRcvHdrCorErr", RXES(RCV_HDR_COR)),
+/* 4*/	FLAG_ENTRY0("RxRcvDataUncErr", RXES(RCV_DATA_UNC)),
+/* 5*/	FLAG_ENTRY0("RxRcvDataCorErr", RXES(RCV_DATA_COR)),
+/* 6*/	FLAG_ENTRY0("RxRcvQpMapTableUncErr", RXES(RCV_QP_MAP_TABLE_UNC)),
+/* 7*/	FLAG_ENTRY0("RxRcvQpMapTableCorErr", RXES(RCV_QP_MAP_TABLE_COR)),
+/* 8*/	FLAG_ENTRY0("RxRcvCsrParityErr", RXES(RCV_CSR_PARITY)),
+/* 9*/	FLAG_ENTRY0("RxCrkSopEopParityErr", RXES(DC_SOP_EOP_PARITY)),
+/*10*/	FLAG_ENTRY0("RxDmaFlagUncErr", RXES(DMA_FLAG_UNC)),
+/*11*/	FLAG_ENTRY0("RxDmaFlagCorErr", RXES(DMA_FLAG_COR)),
+/*12*/	FLAG_ENTRY0("RxRcvFsmEncodingErr", RXES(RCV_FSM_ENCODING)),
+/*13*/	FLAG_ENTRY0("RxRbufFreeListUncErr", RXES(RBUF_FREE_LIST_UNC)),
+/*14*/	FLAG_ENTRY0("RxRbufFreeListCorErr", RXES(RBUF_FREE_LIST_COR)),
+/*15*/	FLAG_ENTRY0("RxRbufLookupDesRegUncErr", RXES(RBUF_LOOKUP_DES_REG_UNC)),
+/*16*/	FLAG_ENTRY0("RxRbufLookupDesRegUncCorErr",
+		RXES(RBUF_LOOKUP_DES_REG_UNC_COR)),
+/*17*/	FLAG_ENTRY0("RxRbufLookupDesUncErr", RXES(RBUF_LOOKUP_DES_UNC)),
+/*18*/	FLAG_ENTRY0("RxRbufLookupDesCorErr", RXES(RBUF_LOOKUP_DES_COR)),
+/*19*/	FLAG_ENTRY0("RxRbufBlockListReadUncErr",
+		RXES(RBUF_BLOCK_LIST_READ_UNC)),
+/*20*/	FLAG_ENTRY0("RxRbufBlockListReadCorErr",
+		RXES(RBUF_BLOCK_LIST_READ_COR)),
+/*21*/	FLAG_ENTRY0("RxRbufCsrQHeadBufNumParityErr",
+		RXES(RBUF_CSR_QHEAD_BUF_NUM_PARITY)),
+/*22*/	FLAG_ENTRY0("RxRbufCsrQEntCntParityErr",
+		RXES(RBUF_CSR_QENT_CNT_PARITY)),
+/*23*/	FLAG_ENTRY0("RxRbufCsrQNextBufParityErr",
+		RXES(RBUF_CSR_QNEXT_BUF_PARITY)),
+/*24*/	FLAG_ENTRY0("RxRbufCsrQVldBitParityErr",
+		RXES(RBUF_CSR_QVLD_BIT_PARITY)),
+/*25*/	FLAG_ENTRY0("RxRbufCsrQHdPtrParityErr", RXES(RBUF_CSR_QHD_PTR_PARITY)),
+/*26*/	FLAG_ENTRY0("RxRbufCsrQTlPtrParityErr", RXES(RBUF_CSR_QTL_PTR_PARITY)),
+/*27*/	FLAG_ENTRY0("RxRbufCsrQNumOfPktParityErr",
+		RXES(RBUF_CSR_QNUM_OF_PKT_PARITY)),
+/*28*/	FLAG_ENTRY0("RxRbufCsrQEOPDWParityErr", RXES(RBUF_CSR_QEOPDW_PARITY)),
+/*29*/	FLAG_ENTRY0("RxRbufCtxIdParityErr", RXES(RBUF_CTX_ID_PARITY)),
+/*30*/	FLAG_ENTRY0("RxRBufBadLookupErr", RXES(RBUF_BAD_LOOKUP)),
+/*31*/	FLAG_ENTRY0("RxRbufFullErr", RXES(RBUF_FULL)),
+/*32*/	FLAG_ENTRY0("RxRbufEmptyErr", RXES(RBUF_EMPTY)),
+/*33*/	FLAG_ENTRY0("RxRbufFlRdAddrParityErr", RXES(RBUF_FL_RD_ADDR_PARITY)),
+/*34*/	FLAG_ENTRY0("RxRbufFlWrAddrParityErr", RXES(RBUF_FL_WR_ADDR_PARITY)),
+/*35*/	FLAG_ENTRY0("RxRbufFlInitdoneParityErr",
+		RXES(RBUF_FL_INITDONE_PARITY)),
+/*36*/	FLAG_ENTRY0("RxRbufFlInitWrAddrParityErr",
+		RXES(RBUF_FL_INIT_WR_ADDR_PARITY)),
+/*37*/	FLAG_ENTRY0("RxRbufNextFreeBufUncErr", RXES(RBUF_NEXT_FREE_BUF_UNC)),
+/*38*/	FLAG_ENTRY0("RxRbufNextFreeBufCorErr", RXES(RBUF_NEXT_FREE_BUF_COR)),
+/*39*/	FLAG_ENTRY0("RxLookupDesPart1UncErr", RXES(LOOKUP_DES_PART1_UNC)),
+/*40*/	FLAG_ENTRY0("RxLookupDesPart1UncCorErr",
+		RXES(LOOKUP_DES_PART1_UNC_COR)),
+/*41*/	FLAG_ENTRY0("RxLookupDesPart2ParityErr",
+		RXES(LOOKUP_DES_PART2_PARITY)),
+/*42*/	FLAG_ENTRY0("RxLookupRcvArrayUncErr", RXES(LOOKUP_RCV_ARRAY_UNC)),
+/*43*/	FLAG_ENTRY0("RxLookupRcvArrayCorErr", RXES(LOOKUP_RCV_ARRAY_COR)),
+/*44*/	FLAG_ENTRY0("RxLookupCsrParityErr", RXES(LOOKUP_CSR_PARITY)),
+/*45*/	FLAG_ENTRY0("RxHqIntrCsrParityErr", RXES(HQ_INTR_CSR_PARITY)),
+/*46*/	FLAG_ENTRY0("RxHqIntrFsmErr", RXES(HQ_INTR_FSM)),
+/*47*/	FLAG_ENTRY0("RxRbufDescPart1UncErr", RXES(RBUF_DESC_PART1_UNC)),
+/*48*/	FLAG_ENTRY0("RxRbufDescPart1CorErr", RXES(RBUF_DESC_PART1_COR)),
+/*49*/	FLAG_ENTRY0("RxRbufDescPart2UncErr", RXES(RBUF_DESC_PART2_UNC)),
+/*50*/	FLAG_ENTRY0("RxRbufDescPart2CorErr", RXES(RBUF_DESC_PART2_COR)),
+/*51*/	FLAG_ENTRY0("RxDmaHdrFifoRdUncErr", RXES(DMA_HDR_FIFO_RD_UNC)),
+/*52*/	FLAG_ENTRY0("RxDmaHdrFifoRdCorErr", RXES(DMA_HDR_FIFO_RD_COR)),
+/*53*/	FLAG_ENTRY0("RxDmaDataFifoRdUncErr", RXES(DMA_DATA_FIFO_RD_UNC)),
+/*54*/	FLAG_ENTRY0("RxDmaDataFifoRdCorErr", RXES(DMA_DATA_FIFO_RD_COR)),
+/*55*/	FLAG_ENTRY0("RxRbufDataUncErr", RXES(RBUF_DATA_UNC)),
+/*56*/	FLAG_ENTRY0("RxRbufDataCorErr", RXES(RBUF_DATA_COR)),
+/*57*/	FLAG_ENTRY0("RxDmaCsrParityErr", RXES(DMA_CSR_PARITY)),
+/*58*/	FLAG_ENTRY0("RxDmaEqFsmEncodingErr", RXES(DMA_EQ_FSM_ENCODING)),
+/*59*/	FLAG_ENTRY0("RxDmaDqFsmEncodingErr", RXES(DMA_DQ_FSM_ENCODING)),
+/*60*/	FLAG_ENTRY0("RxDmaCsrUncErr", RXES(DMA_CSR_UNC)),
+/*61*/	FLAG_ENTRY0("RxCsrReadBadAddrErr", RXES(CSR_READ_BAD_ADDR)),
+/*62*/	FLAG_ENTRY0("RxCsrWriteBadAddrErr", RXES(CSR_WRITE_BAD_ADDR)), /* WFR */
+/*63*/	FLAG_ENTRY0("RxCsrParityErr", RXES(CSR_PARITY)) /* WFR */
+};
+
+/* RXE errors that will trigger an SPC freeze */
+#define ALL_RXE_FREEZE_ERR  \
+	(RCV_ERR_STATUS_RX_RCV_QP_MAP_TABLE_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RCV_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_FLAG_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RCV_FSM_ENCODING_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FREE_LIST_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_REG_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_REG_UNC_COR_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_BLOCK_LIST_READ_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QHEAD_BUF_NUM_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QENT_CNT_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QNEXT_BUF_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QVLD_BIT_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QHD_PTR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QTL_PTR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QNUM_OF_PKT_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CSR_QEOPDW_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_CTX_ID_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_BAD_LOOKUP_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FULL_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_EMPTY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_RD_ADDR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_WR_ADDR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_INITDONE_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_FL_INIT_WR_ADDR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_NEXT_FREE_BUF_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_DES_PART1_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_DES_PART1_UNC_COR_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_DES_PART2_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_RCV_ARRAY_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_LOOKUP_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_HQ_INTR_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_HQ_INTR_FSM_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DESC_PART1_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DESC_PART1_COR_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DESC_PART2_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_HDR_FIFO_RD_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_DATA_FIFO_RD_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_RBUF_DATA_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_CSR_PARITY_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_EQ_FSM_ENCODING_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_DQ_FSM_ENCODING_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_DMA_CSR_UNC_ERR_SMASK \
+	| RCV_ERR_STATUS_RX_CSR_PARITY_ERR_SMASK)
+
+#define RXE_FREEZE_ABORT_MASK \
+	(RCV_ERR_STATUS_RX_DMA_CSR_UNC_ERR_SMASK | \
+	RCV_ERR_STATUS_RX_DMA_HDR_FIFO_RD_UNC_ERR_SMASK | \
+	RCV_ERR_STATUS_RX_DMA_DATA_FIFO_RD_UNC_ERR_SMASK)
+
+/*
+ * DCC Error Flags
+ */
+#define DCCE(name) DCC_ERR_FLG_##name##_SMASK
+static const struct flag_table dcc_err_flags[] = {
+	FLAG_ENTRY0("bad_l2_err", DCCE(BAD_L2_ERR)),
+	FLAG_ENTRY0("bad_sc_err", DCCE(BAD_SC_ERR)),
+	FLAG_ENTRY0("bad_mid_tail_err", DCCE(BAD_MID_TAIL_ERR)),
+	FLAG_ENTRY0("bad_preemption_err", DCCE(BAD_PREEMPTION_ERR)),
+	FLAG_ENTRY0("preemption_err", DCCE(PREEMPTION_ERR)),
+	FLAG_ENTRY0("preemptionvl15_err", DCCE(PREEMPTIONVL15_ERR)),
+	FLAG_ENTRY0("bad_vl_marker_err", DCCE(BAD_VL_MARKER_ERR)),
+	FLAG_ENTRY0("bad_dlid_target_err", DCCE(BAD_DLID_TARGET_ERR)),
+	FLAG_ENTRY0("bad_lver_err", DCCE(BAD_LVER_ERR)),
+	FLAG_ENTRY0("uncorrectable_err", DCCE(UNCORRECTABLE_ERR)),
+	FLAG_ENTRY0("bad_crdt_ack_err", DCCE(BAD_CRDT_ACK_ERR)),
+	FLAG_ENTRY0("unsup_pkt_type", DCCE(UNSUP_PKT_TYPE)),
+	FLAG_ENTRY0("bad_ctrl_flit_err", DCCE(BAD_CTRL_FLIT_ERR)),
+	FLAG_ENTRY0("event_cntr_parity_err", DCCE(EVENT_CNTR_PARITY_ERR)),
+	FLAG_ENTRY0("event_cntr_rollover_err", DCCE(EVENT_CNTR_ROLLOVER_ERR)),
+	FLAG_ENTRY0("link_err", DCCE(LINK_ERR)),
+	FLAG_ENTRY0("misc_cntr_rollover_err", DCCE(MISC_CNTR_ROLLOVER_ERR)),
+	FLAG_ENTRY0("bad_ctrl_dist_err", DCCE(BAD_CTRL_DIST_ERR)),
+	FLAG_ENTRY0("bad_tail_dist_err", DCCE(BAD_TAIL_DIST_ERR)),
+	FLAG_ENTRY0("bad_head_dist_err", DCCE(BAD_HEAD_DIST_ERR)),
+	FLAG_ENTRY0("nonvl15_state_err", DCCE(NONVL15_STATE_ERR)),
+	FLAG_ENTRY0("vl15_multi_err", DCCE(VL15_MULTI_ERR)),
+	FLAG_ENTRY0("bad_pkt_length_err", DCCE(BAD_PKT_LENGTH_ERR)),
+	FLAG_ENTRY0("unsup_vl_err", DCCE(UNSUP_VL_ERR)),
+	FLAG_ENTRY0("perm_nvl15_err", DCCE(PERM_NVL15_ERR)),
+	FLAG_ENTRY0("slid_zero_err", DCCE(SLID_ZERO_ERR)),
+	FLAG_ENTRY0("dlid_zero_err", DCCE(DLID_ZERO_ERR)),
+	FLAG_ENTRY0("length_mtu_err", DCCE(LENGTH_MTU_ERR)),
+	FLAG_ENTRY0("rx_early_drop_err", DCCE(RX_EARLY_DROP_ERR)),
+	FLAG_ENTRY0("late_short_err", DCCE(LATE_SHORT_ERR)),
+	FLAG_ENTRY0("late_long_err", DCCE(LATE_LONG_ERR)),
+	FLAG_ENTRY0("late_ebp_err", DCCE(LATE_EBP_ERR)),
+	FLAG_ENTRY0("fpe_tx_fifo_ovflw_err", DCCE(FPE_TX_FIFO_OVFLW_ERR)),
+	FLAG_ENTRY0("fpe_tx_fifo_unflw_err", DCCE(FPE_TX_FIFO_UNFLW_ERR)),
+	FLAG_ENTRY0("csr_access_blocked_host", DCCE(CSR_ACCESS_BLOCKED_HOST)),
+	FLAG_ENTRY0("csr_access_blocked_uc", DCCE(CSR_ACCESS_BLOCKED_UC)),
+	FLAG_ENTRY0("tx_ctrl_parity_err", DCCE(TX_CTRL_PARITY_ERR)),
+	FLAG_ENTRY0("tx_ctrl_parity_mbe_err", DCCE(TX_CTRL_PARITY_MBE_ERR)),
+	FLAG_ENTRY0("tx_sc_parity_err", DCCE(TX_SC_PARITY_ERR)),
+	FLAG_ENTRY0("rx_ctrl_parity_mbe_err", DCCE(RX_CTRL_PARITY_MBE_ERR)),
+	FLAG_ENTRY0("csr_parity_err", DCCE(CSR_PARITY_ERR)),
+	FLAG_ENTRY0("csr_inval_addr", DCCE(CSR_INVAL_ADDR)),
+	FLAG_ENTRY0("tx_byte_shft_parity_err", DCCE(TX_BYTE_SHFT_PARITY_ERR)),
+	FLAG_ENTRY0("rx_byte_shft_parity_err", DCCE(RX_BYTE_SHFT_PARITY_ERR)),
+	FLAG_ENTRY0("fmconfig_err", DCCE(FMCONFIG_ERR)),
+	FLAG_ENTRY0("rcvport_err", DCCE(RCVPORT_ERR)),
+};
+
+/*
+ * LCB error flags
+ */
+#define LCBE(name) DC_LCB_ERR_FLG_##name##_SMASK
+static const struct flag_table lcb_err_flags[] = {
+/* 0*/	FLAG_ENTRY0("CSR_PARITY_ERR", LCBE(CSR_PARITY_ERR)),
+/* 1*/	FLAG_ENTRY0("INVALID_CSR_ADDR", LCBE(INVALID_CSR_ADDR)),
+/* 2*/	FLAG_ENTRY0("RST_FOR_FAILED_DESKEW", LCBE(RST_FOR_FAILED_DESKEW)),
+/* 3*/	FLAG_ENTRY0("ALL_LNS_FAILED_REINIT_TEST",
+		LCBE(ALL_LNS_FAILED_REINIT_TEST)),
+/* 4*/	FLAG_ENTRY0("LOST_REINIT_STALL_OR_TOS", LCBE(LOST_REINIT_STALL_OR_TOS)),
+/* 5*/	FLAG_ENTRY0("TX_LESS_THAN_FOUR_LNS", LCBE(TX_LESS_THAN_FOUR_LNS)),
+/* 6*/	FLAG_ENTRY0("RX_LESS_THAN_FOUR_LNS", LCBE(RX_LESS_THAN_FOUR_LNS)),
+/* 7*/	FLAG_ENTRY0("SEQ_CRC_ERR", LCBE(SEQ_CRC_ERR)),
+/* 8*/	FLAG_ENTRY0("REINIT_FROM_PEER", LCBE(REINIT_FROM_PEER)),
+/* 9*/	FLAG_ENTRY0("REINIT_FOR_LN_DEGRADE", LCBE(REINIT_FOR_LN_DEGRADE)),
+/*10*/	FLAG_ENTRY0("CRC_ERR_CNT_HIT_LIMIT", LCBE(CRC_ERR_CNT_HIT_LIMIT)),
+/*11*/	FLAG_ENTRY0("RCLK_STOPPED", LCBE(RCLK_STOPPED)),
+/*12*/	FLAG_ENTRY0("UNEXPECTED_REPLAY_MARKER", LCBE(UNEXPECTED_REPLAY_MARKER)),
+/*13*/	FLAG_ENTRY0("UNEXPECTED_ROUND_TRIP_MARKER",
+		LCBE(UNEXPECTED_ROUND_TRIP_MARKER)),
+/*14*/	FLAG_ENTRY0("ILLEGAL_NULL_LTP", LCBE(ILLEGAL_NULL_LTP)),
+/*15*/	FLAG_ENTRY0("ILLEGAL_FLIT_ENCODING", LCBE(ILLEGAL_FLIT_ENCODING)),
+/*16*/	FLAG_ENTRY0("FLIT_INPUT_BUF_OFLW", LCBE(FLIT_INPUT_BUF_OFLW)),
+/*17*/	FLAG_ENTRY0("VL_ACK_INPUT_BUF_OFLW", LCBE(VL_ACK_INPUT_BUF_OFLW)),
+/*18*/	FLAG_ENTRY0("VL_ACK_INPUT_PARITY_ERR", LCBE(VL_ACK_INPUT_PARITY_ERR)),
+/*19*/	FLAG_ENTRY0("VL_ACK_INPUT_WRONG_CRC_MODE",
+		LCBE(VL_ACK_INPUT_WRONG_CRC_MODE)),
+/*20*/	FLAG_ENTRY0("FLIT_INPUT_BUF_MBE", LCBE(FLIT_INPUT_BUF_MBE)),
+/*21*/	FLAG_ENTRY0("FLIT_INPUT_BUF_SBE", LCBE(FLIT_INPUT_BUF_SBE)),
+/*22*/	FLAG_ENTRY0("REPLAY_BUF_MBE", LCBE(REPLAY_BUF_MBE)),
+/*23*/	FLAG_ENTRY0("REPLAY_BUF_SBE", LCBE(REPLAY_BUF_SBE)),
+/*24*/	FLAG_ENTRY0("CREDIT_RETURN_FLIT_MBE", LCBE(CREDIT_RETURN_FLIT_MBE)),
+/*25*/	FLAG_ENTRY0("RST_FOR_LINK_TIMEOUT", LCBE(RST_FOR_LINK_TIMEOUT)),
+/*26*/	FLAG_ENTRY0("RST_FOR_INCOMPLT_RND_TRIP",
+		LCBE(RST_FOR_INCOMPLT_RND_TRIP)),
+/*27*/	FLAG_ENTRY0("HOLD_REINIT", LCBE(HOLD_REINIT)),
+/*28*/	FLAG_ENTRY0("NEG_EDGE_LINK_TRANSFER_ACTIVE",
+		LCBE(NEG_EDGE_LINK_TRANSFER_ACTIVE)),
+/*29*/	FLAG_ENTRY0("REDUNDANT_FLIT_PARITY_ERR",
+		LCBE(REDUNDANT_FLIT_PARITY_ERR))
+};
+
+/*
+ * DC8051 Error Flags
+ */
+#define D8E(name) DC_DC8051_ERR_FLG_##name##_SMASK
+static const struct flag_table dc8051_err_flags[] = {
+	FLAG_ENTRY0("SET_BY_8051", D8E(SET_BY_8051)),
+	FLAG_ENTRY0("LOST_8051_HEART_BEAT", D8E(LOST_8051_HEART_BEAT)),
+	FLAG_ENTRY0("CRAM_MBE", D8E(CRAM_MBE)),
+	FLAG_ENTRY0("CRAM_SBE", D8E(CRAM_SBE)),
+	FLAG_ENTRY0("DRAM_MBE", D8E(DRAM_MBE)),
+	FLAG_ENTRY0("DRAM_SBE", D8E(DRAM_SBE)),
+	FLAG_ENTRY0("IRAM_MBE", D8E(IRAM_MBE)),
+	FLAG_ENTRY0("IRAM_SBE", D8E(IRAM_SBE)),
+	FLAG_ENTRY0("UNMATCHED_SECURE_MSG_ACROSS_BCC_LANES",
+		    D8E(UNMATCHED_SECURE_MSG_ACROSS_BCC_LANES)),
+	FLAG_ENTRY0("INVALID_CSR_ADDR", D8E(INVALID_CSR_ADDR)),
+};
+
+/*
+ * DC8051 Information Error flags
+ *
+ * Flags in DC8051_DBG_ERR_INFO_SET_BY_8051.ERROR field.
+ */
+static const struct flag_table dc8051_info_err_flags[] = {
+	FLAG_ENTRY0("Spico ROM check failed",  SPICO_ROM_FAILED),
+	FLAG_ENTRY0("Unknown frame received",  UNKNOWN_FRAME),
+	FLAG_ENTRY0("Target BER not met",      TARGET_BER_NOT_MET),
+	FLAG_ENTRY0("Serdes internal loopback failure",
+		    FAILED_SERDES_INTERNAL_LOOPBACK),
+	FLAG_ENTRY0("Failed SerDes init",      FAILED_SERDES_INIT),
+	FLAG_ENTRY0("Failed LNI(Polling)",     FAILED_LNI_POLLING),
+	FLAG_ENTRY0("Failed LNI(Debounce)",    FAILED_LNI_DEBOUNCE),
+	FLAG_ENTRY0("Failed LNI(EstbComm)",    FAILED_LNI_ESTBCOMM),
+	FLAG_ENTRY0("Failed LNI(OptEq)",       FAILED_LNI_OPTEQ),
+	FLAG_ENTRY0("Failed LNI(VerifyCap_1)", FAILED_LNI_VERIFY_CAP1),
+	FLAG_ENTRY0("Failed LNI(VerifyCap_2)", FAILED_LNI_VERIFY_CAP2),
+	FLAG_ENTRY0("Failed LNI(ConfigLT)",    FAILED_LNI_CONFIGLT),
+	FLAG_ENTRY0("Host Handshake Timeout",  HOST_HANDSHAKE_TIMEOUT),
+	FLAG_ENTRY0("External Device Request Timeout",
+		    EXTERNAL_DEVICE_REQ_TIMEOUT),
+};
+
+/*
+ * DC8051 Information Host Information flags
+ *
+ * Flags in DC8051_DBG_ERR_INFO_SET_BY_8051.HOST_MSG field.
+ */
+static const struct flag_table dc8051_info_host_msg_flags[] = {
+	FLAG_ENTRY0("Host request done", 0x0001),
+	FLAG_ENTRY0("BC PWR_MGM message", 0x0002),
+	FLAG_ENTRY0("BC SMA message", 0x0004),
+	FLAG_ENTRY0("BC Unknown message (BCC)", 0x0008),
+	FLAG_ENTRY0("BC Unknown message (LCB)", 0x0010),
+	FLAG_ENTRY0("External device config request", 0x0020),
+	FLAG_ENTRY0("VerifyCap all frames received", 0x0040),
+	FLAG_ENTRY0("LinkUp achieved", 0x0080),
+	FLAG_ENTRY0("Link going down", 0x0100),
+	FLAG_ENTRY0("Link width downgraded", 0x0200),
+};
+
+static u32 encoded_size(u32 size);
+static u32 chip_to_opa_lstate(struct hfi2_devdata *dd, u32 chip_lstate);
+static int set_physical_link_state(struct hfi2_devdata *dd, u64 state);
+static void read_vc_remote_phy(struct hfi2_devdata *dd, u8 *power_management,
+			       u8 *continuous);
+static void read_vc_remote_fabric(struct hfi2_devdata *dd, u8 *vau, u8 *z,
+				  u8 *vcu, u16 *vl15buf, u8 *crc_sizes);
+static void read_vc_remote_link_width(struct hfi2_devdata *dd,
+				      u8 *remote_tx_rate, u16 *link_widths);
+static void read_vc_local_link_mode(struct hfi2_devdata *dd, u8 *misc_bits,
+				    u8 *flag_bits, u16 *link_widths);
+static void read_remote_device_id(struct hfi2_devdata *dd, u16 *device_id,
+				  u8 *device_rev);
+static void read_local_lni(struct hfi2_devdata *dd, u8 *enable_lane_rx);
+static int read_tx_settings(struct hfi2_devdata *dd, u8 *enable_lane_tx,
+			    u8 *tx_polarity_inversion,
+			    u8 *rx_polarity_inversion, u8 *max_rate);
+static void handle_qsfp_int(struct hfi2_devdata *dd, u32 source, u64 reg);
+static void handle_dcc_err(struct hfi2_devdata *dd,
+			   unsigned int context, u64 err_status);
+static void handle_lcb_err(struct hfi2_devdata *dd,
+			   unsigned int context, u64 err_status);
+static void handle_8051_interrupt(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void handle_cce_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void handle_misc_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void handle_txe_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+static void set_partition_keys(struct hfi2_pportdata *ppd);
+static int do_8051_command(struct hfi2_devdata *dd, u32 type, u64 in_data,
+			   u64 *out_data);
+static int read_idle_sma(struct hfi2_devdata *dd, u64 *data);
+static int thermal_init(struct hfi2_devdata *dd);
+
+static int wait_phys_link_offline_substates(struct hfi2_pportdata *ppd,
+					    int msecs);
+static int wait_logical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				  int msecs);
+static void log_physical_state(struct hfi2_pportdata *ppd, u32 state);
+static int wait_physical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				   int msecs);
+static int wait_phys_link_out_of_offline(struct hfi2_pportdata *ppd,
+					 int msecs);
+static void read_planned_down_reason_code(struct hfi2_devdata *dd, u8 *pdrrc);
+static void read_link_down_reason(struct hfi2_devdata *dd, u8 *ldr);
+static void dc_shutdown(struct hfi2_devdata *dd);
+static void dc_start(struct hfi2_devdata *dd);
+static int qos_rmt_entries(unsigned int n_krcv_queues, unsigned int *mp,
+			   unsigned int *np);
+static void clear_full_mgmt_pkey(struct hfi2_pportdata *ppd);
+static int wait_link_transfer_active(struct hfi2_devdata *dd, int wait_ms);
+static void clear_rsm_rule(struct hfi2_devdata *dd, int rule_index);
+
+#define NUM_MISC_ERRS (IS_GENERAL_ERR_END + 1 - IS_GENERAL_ERR_START)
+#define NUM_DC_ERRS (IS_DC_END + 1 - IS_DC_START)
+#define NUM_VARIOUS (IS_VARIOUS_END + 1 - IS_VARIOUS_START)
+
+/*
+ * Helpers DC error interrupt table entries.  Different helpers are needed
+ * because of inconsistent register names.
+ */
+#define DC_EE1(reg, handler, desc) \
+	{ reg##_FLG, reg##_FLG_CLR, reg##_FLG_EN, ICD_NORMAL, handler, desc }
+#define DC_EE2(reg, handler, desc) \
+	{ reg##_FLG, reg##_CLR, reg##_EN, ICD_NORMAL, handler, desc }
+
+/*
+ * Table of the "misc" grouping of error interrupts.  Each entry refers to
+ * another register containing more information.
+ */
+static const struct err_reg_info misc_errs[NUM_MISC_ERRS] = {
+	EE_N(CCE_ERR,	      handle_cce_err,    "CceErr"),
+	EE_I(RCV_ERR,	      handle_rxe_err,    "RxeErr"),
+	EE_N(MISC_ERR,	      handle_misc_err,   "MiscErr"),
+	{}, /* reserved */
+	EE_N(SEND_PIO_ERR,    handle_pio_err,    "PioErr"),
+	EE_N(SEND_DMA_ERR,    handle_sdma_err,   "SDmaErr"),
+	EE_E(SEND_EGRESS_ERR, handle_egress_err, "EgressErr"),
+	EE_N(SEND_ERR,	      handle_txe_err,    "TxeErr")
+	/* the rest are reserved */
+};
+
+/*
+ * Index into the Various section of the interrupt sources
+ * corresponding to the Critical Temperature interrupt.
+ */
+#define TCRIT_INT_SOURCE 4
+
+/*
+ * SDMA error interrupt entry - refers to another register containing more
+ * information.
+ */
+static const struct err_reg_info sdma_eng_err =
+	EE_S(SEND_DMA_ENG_ERR, handle_sdma_eng_err, "SDmaEngErr");
+
+static const struct err_reg_info various_err[NUM_VARIOUS] = {
+	{}, /* PbcInt */
+	{}, /* GpioAssertInt */
+	EE_N(ASIC_QSFP1, handle_qsfp_int, "QSFP1"),
+	EE_N(ASIC_QSFP2, handle_qsfp_int, "QSFP2"),
+	{}, /* TCritInt */
+	/* the rest are reserved */
+};
+
+/*
+ * The DC encoding of mtu_cap for 10K MTU in the DCC_CFG_PORT_CONFIG
+ * register can not be derived from the MTU value because 10K is not
+ * a power of 2. Therefore, we need a constant. Everything else can
+ * be calculated.
+ */
+#define DCC_CFG_PORT_MTU_CAP_10240 7
+
+/*
+ * Table of the DC grouping of error interrupts.  Each entry refers to
+ * another register containing more information.
+ */
+static const struct err_reg_info dc_errs[NUM_DC_ERRS] = {
+	DC_EE1(DCC_ERR,		handle_dcc_err,	       "DCC Err"),
+	DC_EE2(DC_LCB_ERR,	handle_lcb_err,	       "LCB Err"),
+	DC_EE2(DC_DC8051_ERR,	handle_8051_interrupt, "DC8051 Interrupt"),
+	/* dc_lbm_int - special, see is_dc_int() */
+	/* the rest are reserved */
+};
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
+ * hfi2_addr_from_offset - return addr for readq/writeq
+ * @dd: the dd device
+ * @offset: the offset of the CSR within bar0
+ *
+ * This routine selects the appropriate base address
+ * based on the indicated offset.
+ */
+static inline void __iomem *hfi2_addr_from_offset(
+	const struct hfi2_devdata *dd,
+	u32 offset)
+{
+	if (offset >= dd->base2_start)
+		return dd->kregbase2 + (offset - dd->base2_start);
+	return dd->kregbase1 + offset;
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
+	u32 csr = dd->params->send_dma_desc_fetched_cnt_reg +
+		  (dd->params->txe_sdma_stride * idx);
+
+	return read_write_csr(dd, csr, mode, data);
+}
+
+static u64 access_sde_err_cnt(const struct cntr_entry *entry,
+			      void *context, int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	if (dd->per_sdma && idx < dd->num_sdma)
+		return dd->per_sdma[idx].err_cnt;
+	return 0;
+}
+
+static u64 access_sde_int_cnt(const struct cntr_entry *entry,
+			      void *context, int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	if (dd->per_sdma && idx < dd->num_sdma)
+		return dd->per_sdma[idx].sdma_int_cnt;
+	return 0;
+}
+
+static u64 access_sde_idle_int_cnt(const struct cntr_entry *entry,
+				   void *context, int idx, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	if (dd->per_sdma && idx < dd->num_sdma)
+		return dd->per_sdma[idx].idle_int_cnt;
+	return 0;
+}
+
+static u64 access_sde_progress_int_cnt(const struct cntr_entry *entry,
+				       void *context, int idx, int mode,
+				       u64 data)
+{
+	struct hfi2_devdata *dd = (struct hfi2_devdata *)context;
+
+	if (dd->per_sdma && idx < dd->num_sdma)
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
+static struct cntr_entry shared_dev_cntrs[SHARED_DEV_CNTR_LAST] = {
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
+[A(C_CCE_PBC_ERR_INT)] = CCE_INT_DEV_CNTR_ELEM(CcePbcErrInt, JKR_C_CCE_PBC_ERR_INT_CNT,
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
+static struct cntr_entry shared_port_cntrs[SHARED_PORT_CNTR_LAST] = {
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
+
+/* ======================================================================== */
+
+/* return true if this is WFR chip revision revision a */
+int is_ax(struct hfi2_devdata *dd)
+{
+	int chip_rev_minor;
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return 0;
+
+	chip_rev_minor = (dd->revision >> CCE_REVISION_CHIP_REV_MINOR_SHIFT)
+				& CCE_REVISION_CHIP_REV_MINOR_MASK;
+	return (chip_rev_minor & 0xf0) == 0;
+}
+
+/* return true if this is WFR chip revision revision b or not WFR */
+int is_bx(struct hfi2_devdata *dd)
+{
+	int chip_rev_minor;
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return 1;
+
+	chip_rev_minor = (dd->revision >> CCE_REVISION_CHIP_REV_MINOR_SHIFT)
+				& CCE_REVISION_CHIP_REV_MINOR_MASK;
+	return (chip_rev_minor & 0xF0) == 0x10;
+}
+
+/* return true is kernel urg disabled for rcd */
+bool is_urg_masked(struct hfi2_ctxtdata *rcd)
+{
+	u64 mask;
+	u32 is = rcd->dd->params->is_rcvurgent_start + rcd->ctxt;
+	u8 bit = is % 64;
+
+	mask = read_csr(rcd->dd, CCE_INT_MASK + (8 * (is / 64)));
+	return !(mask & BIT_ULL(bit));
+}
+
+/*
+ * Append string s to buffer buf.  Arguments curp and len are the current
+ * position and remaining length, respectively.
+ *
+ * return 0 on success, 1 on out of room
+ */
+static int append_str(char *buf, char **curp, int *lenp, const char *s)
+{
+	char *p = *curp;
+	int len = *lenp;
+	int result = 0; /* success */
+	char c;
+
+	/* add a comma, if first in the buffer */
+	if (p != buf) {
+		if (len == 0) {
+			result = 1; /* out of room */
+			goto done;
+		}
+		*p++ = ',';
+		len--;
+	}
+
+	/* copy the string */
+	while ((c = *s++) != 0) {
+		if (len == 0) {
+			result = 1; /* out of room */
+			goto done;
+		}
+		*p++ = c;
+		len--;
+	}
+
+done:
+	/* write return values */
+	*curp = p;
+	*lenp = len;
+
+	return result;
+}
+
+/*
+ * Using the given flag table, print a comma separated string into
+ * the buffer.  End in '*' if the buffer is too short.
+ */
+static char *flag_string(char *buf, int buf_len, u64 flags,
+			 const struct flag_table *table, int table_size)
+{
+	char extra[32];
+	char *p = buf;
+	int len = buf_len;
+	int no_room = 0;
+	int i;
+
+	/* make sure there is at least 2 so we can form "*" */
+	if (len < 2)
+		return "";
+
+	len--;	/* leave room for a nul */
+	for (i = 0; i < table_size; i++) {
+		if (flags & table[i].flag) {
+			no_room = append_str(buf, &p, &len, table[i].str);
+			if (no_room)
+				break;
+			flags &= ~table[i].flag;
+		}
+	}
+
+	/* any undocumented bits left? */
+	if (!no_room && flags) {
+		snprintf(extra, sizeof(extra), "bits 0x%llx", flags);
+		no_room = append_str(buf, &p, &len, extra);
+	}
+
+	/* add * if ran out of room */
+	if (no_room) {
+		/* may need to back up to add space for a '*' */
+		if (len == 0)
+			--p;
+		*p++ = '*';
+	}
+
+	/* add final nul - space already allocated above */
+	*p = 0;
+	return buf;
+}
+
+/* first 8 CCE error interrupt source names */
+static const char * const cce_misc_names[] = {
+	"CceErrInt",		/* 0 */
+	"RxeErrInt",		/* 1 */
+	"MiscErrInt",		/* 2 */
+	"Reserved3",		/* 3 */
+	"PioErrInt",		/* 4 */
+	"SDmaErrInt",		/* 5 */
+	"EgressErrInt",		/* 6 */
+	"TxeErrInt"		/* 7 */
+};
+
+/*
+ * Return the miscellaneous error interrupt name.
+ */
+static char *is_misc_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	if (source < ARRAY_SIZE(cce_misc_names))
+		strscpy_pad(buf, cce_misc_names[source], bsize);
+	else
+		snprintf(buf, bsize, "Reserved%u",
+			 source + IS_GENERAL_ERR_START);
+
+	return buf;
+}
+
+/*
+ * Return the SDMA engine error interrupt name.
+ */
+char *is_sdma_eng_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "SDmaEngErrInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the send context error interrupt name.
+ */
+char *is_sendctxt_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "SendCtxtErrInt%u", source);
+	return buf;
+}
+
+static const char * const various_names[] = {
+	"PbcInt",
+	"GpioAssertInt",
+	"Qsfp1Int",
+	"Qsfp2Int",
+	"TCritInt"
+};
+
+/*
+ * Return the various interrupt name.
+ */
+static char *is_various_name(char *buf, size_t bsize, unsigned int source)
+{
+	if (source < ARRAY_SIZE(various_names))
+		strscpy_pad(buf, various_names[source], bsize);
+	else
+		snprintf(buf, bsize, "Reserved%u", source + IS_VARIOUS_START);
+	return buf;
+}
+
+/*
+ * Return the DC interrupt name.
+ */
+static char *is_dc_name(char *buf, size_t bsize, unsigned int source)
+{
+	static const char * const dc_int_names[] = {
+		"common",
+		"lcb",
+		"8051",
+		"lbm"	/* local block merge */
+	};
+
+	if (source < ARRAY_SIZE(dc_int_names))
+		snprintf(buf, bsize, "dc_%s_int", dc_int_names[source]);
+	else
+		snprintf(buf, bsize, "DCInt%u", source);
+	return buf;
+}
+
+static const char * const sdma_int_names[] = {
+	"SDmaInt",
+	"SdmaIdleInt",
+	"SdmaProgressInt",
+};
+
+/*
+ * Return the SDMA engine interrupt name.
+ */
+char *is_sdma_eng_name(char *buf, size_t bsize, unsigned int source)
+{
+	/* what interrupt */
+	unsigned int what  = source / TXE_NUM_SDMA_ENGINES;
+	/* which engine */
+	unsigned int which = source % TXE_NUM_SDMA_ENGINES;
+
+	if (likely(what < 3))
+		snprintf(buf, bsize, "%s%u", sdma_int_names[what], which);
+	else
+		snprintf(buf, bsize, "Invalid SDMA interrupt %u", source);
+	return buf;
+}
+
+/*
+ * Return the receive available interrupt name.
+ */
+char *is_rcv_avail_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "RcvAvailInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the receive urgent interrupt name.
+ */
+char *is_rcv_urgent_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "RcvUrgentInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the send credit interrupt name.
+ */
+char *is_send_credit_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "SendCreditInt%u", source);
+	return buf;
+}
+
+/*
+ * Return the reserved interrupt name.
+ */
+static char *is_reserved_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "Reserved%u", source + IS_RESERVED_START);
+	return buf;
+}
+
+static char *cce_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   cce_err_status_flags,
+			   ARRAY_SIZE(cce_err_status_flags));
+}
+
+static char *rxe_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   rxe_err_status_flags,
+			   ARRAY_SIZE(rxe_err_status_flags));
+}
+
+static char *misc_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, misc_err_status_flags,
+			   ARRAY_SIZE(misc_err_status_flags));
+}
+
+static char *pio_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   pio_err_status_flags,
+			   ARRAY_SIZE(pio_err_status_flags));
+}
+
+static char *sdma_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   sdma_err_status_flags,
+			   ARRAY_SIZE(sdma_err_status_flags));
+}
+
+static char *egress_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   egress_err_status_flags,
+			   ARRAY_SIZE(egress_err_status_flags));
+}
+
+static char *egress_err_info_string(struct hfi2_devdata *dd, char *buf,
+				    int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   dd->params->egress_err_info_data->table,
+			   dd->params->egress_err_info_data->size);
+}
+
+static char *send_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   send_err_status_flags,
+			   ARRAY_SIZE(send_err_status_flags));
+}
+
+static void handle_cce_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	/*
+	 * For most these errors, there is nothing that can be done except
+	 * report or record it.
+	 */
+	dd_dev_info(dd, "CCE Error: %s\n",
+		    cce_err_status_string(buf, sizeof(buf), reg));
+
+	if ((reg & CCE_ERR_STATUS_CCE_CLI2_ASYNC_FIFO_PARITY_ERR_SMASK) &&
+	    is_ax(dd)) {
+		/* this error requires a manual drop into SPC freeze mode */
+		/* then a fix up */
+		start_freeze_handling(dd, FREEZE_SELF);
+	}
+
+	for (i = 0; i < NUM_CCE_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i)) {
+			incr_cntr64(&dd->cce_err_status_cnt[i]);
+			/* maintain a counter over all cce_err_status errors */
+			incr_cntr64(&dd->sw_cce_err_status_aggregate);
+		}
+	}
+}
+
+/*
+ * Check counters for receive errors that do not have an interrupt
+ * associated with them.
+ */
+static void do_rcverr_timer(struct work_struct *work)
+{
+	struct hfi2_devdata *dd = container_of(work, struct hfi2_devdata,
+					       rcverr_work);
+	struct hfi2_pportdata *ppd;
+	u32 cur_ovfl_cnt;
+	int pidx;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		ppd = &dd->pport[pidx];
+		cur_ovfl_cnt = read_port_cntr(ppd, C_RCV_OVF, CNTR_INVALID_VL);
+
+		if (ppd->rcv_ovfl_cnt < cur_ovfl_cnt &&
+		    ppd->port_error_action & OPA_PI_MASK_EX_BUFFER_OVERRUN) {
+			ppd_dev_info(ppd, "%s: PortErrorAction bounce\n", __func__);
+			set_link_down_reason(ppd,
+				OPA_LINKDOWN_REASON_EXCESSIVE_BUFFER_OVERRUN, 0,
+				OPA_LINKDOWN_REASON_EXCESSIVE_BUFFER_OVERRUN);
+			queue_work(ppd->link_wq, &ppd->link_bounce_work);
+		}
+		ppd->rcv_ovfl_cnt = cur_ovfl_cnt;
+	}
+}
+
+#define RCVERR_CHECK_TIME 10
+static void update_rcverr_timer(struct timer_list *t)
+{
+	struct hfi2_devdata *dd = from_timer(dd, t, rcverr_timer);
+
+	/* avoid timer interrupt context CSR access when simulating */
+	if (dd->icode == ICODE_FUNCTIONAL_SIMULATOR)
+		queue_work(dd->update_cntr_wq, &dd->rcverr_work);
+	else
+		do_rcverr_timer(&dd->rcverr_work);
+	mod_timer(&dd->rcverr_timer, jiffies + HZ * RCVERR_CHECK_TIME);
+}
+
+void handle_rxe_err(struct hfi2_devdata *dd, u32 pidx, u64 reg)
+{
+	struct hfi2_pportdata *ppd = &dd->pport[pidx];
+	char buf[96];
+	int i = 0;
+
+	ppd_dev_info(ppd, "Receive Error: %s\n",
+		     rxe_err_status_string(buf, sizeof(buf), reg));
+
+	if (reg & ALL_RXE_FREEZE_ERR) {
+		int flags = 0;
+
+		/*
+		 * Freeze mode recovery is disabled for the errors
+		 * in RXE_FREEZE_ABORT_MASK
+		 */
+		if (is_ax(dd) && (reg & RXE_FREEZE_ABORT_MASK))
+			flags = FREEZE_ABORT;
+
+		start_freeze_handling(dd, flags);
+	}
+
+	for (i = 0; i < NUM_RCV_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->rcv_err_status_cnt[i]);
+	}
+}
+
+static void handle_misc_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "Misc Error: %s",
+		    misc_err_status_string(buf, sizeof(buf), reg));
+	for (i = 0; i < NUM_MISC_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->misc_err_status_cnt[i]);
+	}
+}
+
+void handle_pio_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "PIO Error: %s\n",
+		    pio_err_status_string(buf, sizeof(buf), reg));
+
+	if (reg & ALL_PIO_FREEZE_ERR)
+		start_freeze_handling(dd, 0);
+
+	for (i = 0; i < NUM_SEND_PIO_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->send_pio_err_status_cnt[i]);
+	}
+}
+
+void handle_sdma_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "SDMA Error: %s\n",
+		    sdma_err_status_string(buf, sizeof(buf), reg));
+
+	if (reg & ALL_SDMA_FREEZE_ERR)
+		start_freeze_handling(dd, 0);
+
+	for (i = 0; i < NUM_SEND_DMA_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->send_dma_err_status_cnt[i]);
+	}
+}
+
+static inline void __count_port_discards(struct hfi2_pportdata *ppd)
+{
+	incr_cntr64(&ppd->port_xmit_discards);
+}
+
+static void count_port_inactive(struct hfi2_pportdata *ppd)
+{
+	__count_port_discards(ppd);
+}
+
+/*
+ * We have had a "disallowed packet" error during egress. Determine the
+ * integrity check which failed, and update relevant error counter, etc.
+ *
+ * Note that the SEND_EGRESS_ERR_INFO register has only a single
+ * bit of state per integrity check, and so we can miss the reason for an
+ * egress error if more than one packet fails the same integrity check
+ * since we cleared the corresponding bit in SEND_EGRESS_ERR_INFO.
+ */
+static void handle_send_egress_err_info(struct hfi2_pportdata *ppd,
+					int vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	/* read err source first */
+	u64 src = read_eport_csr(dd, ppd->hw_pidx,
+				 dd->params->send_egress_err_source_reg);
+	u64 info = read_eport_csr(dd, ppd->hw_pidx,
+				  dd->params->send_egress_err_info_reg);
+	char buf[96];
+
+	/* clear down all observed info as quickly as possible after read */
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_egress_err_info_reg, info);
+
+	ppd_dev_info(ppd,
+		     "Egress Error Info: 0x%llx, %s Egress Error Src 0x%llx\n",
+		     info, egress_err_info_string(dd, buf, sizeof(buf), info), src);
+
+	/* Eventually add other counters for each bit */
+	if (info & dd->params->port_discard_egress_errs) {
+		int weight, i;
+
+		/*
+		 * Count all applicable bits as individual errors and
+		 * attribute them to the packet that triggered this handler.
+		 * This may not be completely accurate due to limitations
+		 * on the available hardware error information.  There is
+		 * a single information register and any number of error
+		 * packets may have occurred and contributed to it before
+		 * this routine is called.  This means that:
+		 * a) If multiple packets with the same error occur before
+		 *    this routine is called, earlier packets are missed.
+		 *    There is only a single bit for each error type.
+		 * b) Errors may not be attributed to the correct VL.
+		 *    The driver is attributing all bits in the info register
+		 *    to the packet that triggered this call, but bits
+		 *    could be an accumulation of different packets with
+		 *    different VLs.
+		 * c) A single error packet may have multiple counts attached
+		 *    to it.  There is no way for the driver to know if
+		 *    multiple bits set in the info register are due to a
+		 *    single packet or multiple packets.  The driver assumes
+		 *    multiple packets.
+		 */
+		weight = hweight64(info & dd->params->port_discard_egress_errs);
+		for (i = 0; i < weight; i++) {
+			__count_port_discards(ppd);
+			if (vl >= 0 && vl < TXE_NUM_DATA_VL)
+				incr_cntr64(&ppd->port_xmit_discards_vl[vl]);
+			else if (vl == 15)
+				incr_cntr64(&ppd->port_xmit_discards_vl
+					    [C_VL_15]);
+		}
+	}
+}
+
+/*
+ * Input value is a bit position within the SEND_EGRESS_ERR_STATUS
+ * register. Does it represent a 'port inactive' error?
+ */
+static inline int port_inactive_err(int posn)
+{
+	return (posn >= ilog2(SEES(TX_LINKDOWN)) &&
+		posn <= ilog2(SEES(TX_INCORRECT_LINK_STATE)));
+}
+
+/*
+ * Input value is a bit position within the SEND_EGRESS_ERR_STATUS
+ * register. Does it represent a 'disallowed packet' error?
+ */
+static inline int disallowed_pkt_err(int posn)
+{
+	return (posn >= ilog2(SEES(TX_SDMA0_DISALLOWED_PACKET)) &&
+		posn <= ilog2(SEES(TX_SDMA15_DISALLOWED_PACKET)));
+}
+
+/*
+ * Input value is a bit position of one of the SDMA engine disallowed
+ * packet errors.  Return which engine.  Use of this must be guarded by
+ * disallowed_pkt_err().
+ */
+static inline int disallowed_pkt_engine(int posn)
+{
+	return posn - ilog2(SEES(TX_SDMA0_DISALLOWED_PACKET));
+}
+
+/*
+ * Translate an SDMA engine to a VL.  Return -1 if the tranlation cannot
+ * be done.
+ */
+static int engine_to_vl(struct hfi2_pportdata *ppd, int engine)
+{
+	struct sdma_vl_map *m;
+	int vl;
+
+	/* range check */
+	if (engine < 0 || engine >= TXE_NUM_SDMA_ENGINES)
+		return -1;
+
+	rcu_read_lock();
+	m = rcu_dereference(ppd->sdma_map);
+	vl = m->engine_to_vl[engine];
+	rcu_read_unlock();
+
+	return vl;
+}
+
+/*
+ * Translate the send context (sofware index) into a VL.  Return -1 if the
+ * translation cannot be done.
+ */
+static int sc_to_vl(struct hfi2_devdata *dd, int sw_index)
+{
+	struct send_context_info *sci;
+	struct send_context *sc;
+	int i;
+
+	sci = &dd->send_contexts[sw_index];
+
+	/* there is no information for user (PSM) and ack contexts */
+	if ((sci->type != SC_KERNEL) && (sci->type != SC_VL15))
+		return -1;
+
+	sc = sci->sc;
+	if (!sc)
+		return -1;
+	if (sc->ppd->vld[15].sc == sc)
+		return 15;
+	for (i = 0; i < num_vls; i++)
+		if (sc->ppd->vld[i].sc == sc)
+			return i;
+
+	return -1;
+}
+
+void handle_egress_err(struct hfi2_devdata *dd, u32 pidx, u64 reg)
+{
+	struct hfi2_pportdata *ppd = &dd->pport[pidx];
+	u64 reg_copy = reg;
+	char buf[96];
+	bool err_info_avail = true; /* info available on first call only */
+
+	if (reg & ALL_TXE_EGRESS_FREEZE_ERR)
+		start_freeze_handling(dd, 0);
+	else if (is_ax(dd) &&
+		 (reg & SEND_EGRESS_ERR_STATUS_TX_CREDIT_RETURN_VL_ERR_SMASK))
+		start_freeze_handling(dd, 0);
+
+	while (reg_copy) {
+		int posn = fls64(reg_copy);
+		/* fls64() returns a 1-based offset, we want it zero based */
+		int shift = posn - 1;
+		u64 mask = 1ULL << shift;
+
+		if (port_inactive_err(shift)) {
+			count_port_inactive(ppd);
+		} else if (err_info_avail && disallowed_pkt_err(shift)) {
+			int vl = engine_to_vl(ppd, disallowed_pkt_engine(shift));
+
+			handle_send_egress_err_info(ppd, vl);
+			err_info_avail = false;
+		}
+		incr_cntr64(&dd->send_egress_err_status_cnt[shift]);
+		reg_copy &= ~mask;
+	}
+
+	if (reg)
+		ppd_dev_info(ppd, "Egress Error: %s\n",
+			     egress_err_status_string(buf, sizeof(buf), reg));
+}
+
+static void handle_txe_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+	int i = 0;
+
+	dd_dev_info(dd, "Send Error: %s\n",
+		    send_err_status_string(buf, sizeof(buf), reg));
+
+	for (i = 0; i < NUM_SEND_ERR_STATUS_COUNTERS; i++) {
+		if (reg & (1ull << i))
+			incr_cntr64(&dd->send_err_status_cnt[i]);
+	}
+}
+
+/*
+ * The maximum number of times the error clear down will loop before
+ * blocking a repeating error.  This value is arbitrary.
+ */
+#define MAX_CLEAR_COUNT 20
+
+/* helper for interrupt_clear_down() register read */
+static u64 read_icd_csr(struct hfi2_devdata *dd, enum icd_type type,
+			u32 idx, u32 reg)
+{
+	switch (type) {
+	case ICD_NORMAL:
+		return read_csr(dd, reg);
+	case ICD_SDMA:
+		return read_sdma_csr(dd, idx, reg);
+	case ICD_INGRESS:
+		return read_iport_csr(dd, idx, reg);
+	case ICD_EGRESS:
+		return read_eport_csr(dd, idx, reg);
+	}
+	return 0;
+}
+
+/* helper for interrupt_clear_down() register write */
+static void write_icd_csr(struct hfi2_devdata *dd, enum icd_type type,
+			  u32 idx, u32 reg, u64 value)
+{
+	switch (type) {
+	case ICD_NORMAL:
+		write_csr(dd, reg, value);
+		return;
+	case ICD_SDMA:
+		write_sdma_csr(dd, idx, reg, value);
+		return;
+	case ICD_INGRESS:
+		write_iport_csr(dd, idx, reg, value);
+		return;
+	case ICD_EGRESS:
+		write_eport_csr(dd, idx, reg, value);
+		return;
+	}
+}
+
+/*
+ * Clear and handle an error register.  All error interrupts are funneled
+ * through here to have a central location to correctly handle single-
+ * or multi-shot errors.
+ *
+ * The error register info indicates the type of access needed for the error
+ * register.  The idx is an indexer for the error register.
+ *
+ * If the handler loops too many times, assume that something is wrong
+ * and can't be fixed, so mask the error bits.
+ */
+void interrupt_clear_down(struct hfi2_devdata *dd, u32 idx,
+			  const struct err_reg_info *eri)
+{
+	u64 reg;
+	u32 count;
+
+	/* read in a loop until no more errors are seen */
+	count = 0;
+	while (1) {
+		reg = read_icd_csr(dd, eri->type, idx, eri->status);
+		if (reg == 0)
+			break;
+		write_icd_csr(dd, eri->type, idx, eri->clear, reg);
+		if (likely(eri->handler))
+			eri->handler(dd, idx, reg);
+		count++;
+		if (count > MAX_CLEAR_COUNT) {
+			u64 mask;
+
+			dd_dev_err(dd, "Repeating %s bits 0x%llx - masking\n",
+				   eri->desc, reg);
+			/*
+			 * Read-modify-write so any other masked bits
+			 * remain masked.
+			 */
+			mask = read_icd_csr(dd, eri->type, idx, eri->mask);
+			mask &= ~reg;
+			write_icd_csr(dd, eri->type, idx, eri->mask, mask);
+			break;
+		}
+	}
+}
+
+/*
+ * CCE block "misc" interrupt.  Source is < 16.
+ */
+static void is_misc_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct err_reg_info *eri = &misc_errs[source];
+
+	if (eri->handler) {
+		interrupt_clear_down(dd, 0, eri);
+	} else {
+		dd_dev_err(dd, "Unexpected misc interrupt (%u) - reserved\n",
+			   source);
+	}
+}
+
+static char *send_context_err_status_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags,
+			   sc_err_status_flags,
+			   ARRAY_SIZE(sc_err_status_flags));
+}
+
+/*
+ * Send context error interrupt.
+ *
+ * All send context errors cause the send context to halt.  The normal
+ * clear-down mechanism cannot be used because we cannot clear the
+ * error bits until several other long-running items are done first.
+ * This is OK because with the context halted, nothing else is going
+ * to happen on it anyway.
+ */
+void is_sendctxt_err_int(struct hfi2_devdata *dd, unsigned int hw_context)
+{
+	struct send_context_info *sci;
+	struct send_context *sc;
+	char flags[96];
+	u64 status;
+	u32 sw_index;
+	int i = 0;
+	unsigned long irq_flags;
+
+	sw_index = dd->hw_to_sw[hw_context];
+	if (sw_index >= dd->num_send_contexts) {
+		dd_dev_err(dd,
+			   "out of range sw index %u for send context %u\n",
+			   sw_index, hw_context);
+		return;
+	}
+	sci = &dd->send_contexts[sw_index];
+	spin_lock_irqsave(&dd->sc_lock, irq_flags);
+	sc = sci->sc;
+	if (!sc) {
+		dd_dev_err(dd, "%s: context %u(%u): no sc?\n", __func__,
+			   sw_index, hw_context);
+		spin_unlock_irqrestore(&dd->sc_lock, irq_flags);
+		return;
+	}
+
+	/* tell the software that a halt has begun */
+	sc_stop(sc, SCF_HALTED);
+
+	/*
+	 * All per-send context errors will halt the context and no more
+	 * errors can be generated.  Calling interrupt_clear_down() to handle
+	 * repeating errors is not needed.  The per-context error status
+	 * register is cleared when the context is re-enabled.
+	 */
+	status = read_sctxt_csr(dd, hw_context, dd->params->send_ctxt_err_status_reg);
+
+	dd_dev_info(dd, "Send Context %u(%u) Error: %s\n", sw_index, hw_context,
+		    send_context_err_status_string(flags, sizeof(flags),
+						   status));
+
+	if (status & SEND_CTXT_ERR_STATUS_PIO_DISALLOWED_PACKET_ERR_SMASK)
+		handle_send_egress_err_info(sc->ppd, sc_to_vl(dd, sw_index));
+
+	/*
+	 * Automatically restart halted kernel contexts out of interrupt
+	 * context.  User contexts must ask the driver to restart the context.
+	 */
+	if (sc->type != SC_USER)
+		queue_work(dd->hfi2_wq, &sc->halt_work);
+	spin_unlock_irqrestore(&dd->sc_lock, irq_flags);
+
+	/*
+	 * Update the counters for the corresponding status bits.
+	 * Note that these particular counters are aggregated over all
+	 * contexts.
+	 */
+	for (i = 0; i < NUM_SEND_CTXT_ERR_STATUS_COUNTERS; i++) {
+		if (status & (1ull << i))
+			incr_cntr64(&dd->sw_ctxt_err_status_cnt[i]);
+	}
+}
+
+void handle_sdma_eng_err(struct hfi2_devdata *dd, unsigned int source,
+			 u64 status)
+{
+	struct sdma_engine *sde;
+	int i = 0;
+
+	sde = &dd->per_sdma[source];
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) %s:%d %s()\n", sde->this_idx,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) source: %u status 0x%llx\n",
+		   sde->this_idx, source, (unsigned long long)status);
+#endif
+	sde->err_cnt++;
+	sdma_engine_error(sde, status);
+
+	/*
+	* Update the counters for the corresponding status bits.
+	* Note that these particular counters are aggregated over
+	* all 16 DMA engines.
+	*/
+	for (i = 0; i < NUM_SEND_DMA_ENG_ERR_STATUS_COUNTERS; i++) {
+		if (status & (1ull << i))
+			incr_cntr64(&dd->sw_send_dma_eng_err_status_cnt[i]);
+	}
+}
+
+/*
+ * CCE block SDMA error interrupt.  Source is < 16.
+ */
+static void is_sdma_eng_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+#ifdef CONFIG_SDMA_VERBOSITY
+	struct sdma_engine *sde = &dd->per_sdma[source];
+
+	dd_dev_err(dd, "CONFIG SDMA(%u) %s:%d %s()\n", sde->this_idx,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	dd_dev_err(dd, "CONFIG SDMA(%u) source: %u\n", sde->this_idx,
+		   source);
+	sdma_dumpstate(sde);
+#endif
+	interrupt_clear_down(dd, source, &sdma_eng_err);
+}
+
+/*
+ * CCE block "various" interrupt.  Source is < 8.
+ */
+static void is_various_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct err_reg_info *eri = &various_err[source];
+
+	/*
+	 * TCritInt cannot go through interrupt_clear_down()
+	 * because it is not a second tier interrupt. The handler
+	 * should be called directly.
+	 */
+	if (source == TCRIT_INT_SOURCE)
+		handle_temp_err(dd);
+	else if (eri->handler)
+		interrupt_clear_down(dd, 0, eri);
+	else
+		dd_dev_info(dd,
+			    "%s: Unimplemented/reserved interrupt %d\n",
+			    __func__, source);
+}
+
+static void handle_qsfp_int(struct hfi2_devdata *dd, u32 src_ctx, u64 reg)
+{
+	/* src_ctx is always zero */
+	struct hfi2_pportdata *ppd = dd->pport;
+	unsigned long flags;
+	u64 qsfp_int_mgmt = (u64)(QSFP_HFI0_INT_N | QSFP_HFI0_MODPRST_N);
+
+	if (reg & QSFP_HFI0_MODPRST_N) {
+		if (!qsfp_mod_present(ppd)) {
+			ppd_dev_info(ppd, "%s: QSFP module removed\n",
+				     __func__);
+
+			ppd->driver_link_ready = 0;
+			/*
+			 * Cable removed, reset all our information about the
+			 * cache and cable capabilities
+			 */
+
+			spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+			/*
+			 * We don't set cache_refresh_required here as we expect
+			 * an interrupt when a cable is inserted
+			 */
+			ppd->qsfp_info.cache_valid = 0;
+			ppd->qsfp_info.reset_needed = 0;
+			ppd->qsfp_info.limiting_active = 0;
+			spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock,
+					       flags);
+			/* Invert the ModPresent pin now to detect plug-in */
+			write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_INVERT :
+				  ASIC_QSFP1_INVERT, qsfp_int_mgmt);
+
+			if ((ppd->offline_disabled_reason >
+			  HFI2_ODR_MASK(
+			  OPA_LINKDOWN_REASON_LOCAL_MEDIA_NOT_INSTALLED)) ||
+			  (ppd->offline_disabled_reason ==
+			  HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE)))
+				ppd->offline_disabled_reason =
+				HFI2_ODR_MASK(
+				OPA_LINKDOWN_REASON_LOCAL_MEDIA_NOT_INSTALLED);
+
+			if (ppd->host_link_state == HLS_DN_POLL) {
+				/*
+				 * The link is still in POLL. This means
+				 * that the normal link down processing
+				 * will not happen. We have to do it here
+				 * before turning the DC off.
+				 */
+				queue_work(ppd->link_wq, &ppd->link_down_work);
+			}
+		} else {
+			ppd_dev_info(ppd, "%s: QSFP module inserted\n",
+				     __func__);
+
+			spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+			ppd->qsfp_info.cache_valid = 0;
+			ppd->qsfp_info.cache_refresh_required = 1;
+			spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock,
+					       flags);
+
+			/*
+			 * Stop inversion of ModPresent pin to detect
+			 * removal of the cable
+			 */
+			qsfp_int_mgmt &= ~(u64)QSFP_HFI0_MODPRST_N;
+			write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_INVERT :
+				  ASIC_QSFP1_INVERT, qsfp_int_mgmt);
+
+			ppd->offline_disabled_reason =
+				HFI2_ODR_MASK(OPA_LINKDOWN_REASON_TRANSIENT);
+		}
+	}
+
+	if (reg & QSFP_HFI0_INT_N) {
+		ppd_dev_info(ppd, "%s: Interrupt received from QSFP module\n",
+			     __func__);
+		spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+		ppd->qsfp_info.check_interrupt_flags = 1;
+		spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock, flags);
+	}
+
+	/* Schedule the QSFP work only if there is a cable attached. */
+	if (qsfp_mod_present(ppd))
+		queue_work(ppd->link_wq, &ppd->qsfp_info.qsfp_work);
+}
+
+static int request_host_lcb_access(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = do_8051_command(dd, HCMD_MISC,
+			      (u64)HCMD_MISC_REQUEST_LCB_ACCESS <<
+			      LOAD_DATA_FIELD_ID_SHIFT, NULL);
+	if (ret != HCMD_SUCCESS && !(dd->flags & HFI2_SHUTDOWN)) {
+		dd_dev_err(dd, "%s: command failed with error %d\n",
+			   __func__, ret);
+	}
+	return ret == HCMD_SUCCESS ? 0 : -EBUSY;
+}
+
+static int request_8051_lcb_access(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = do_8051_command(dd, HCMD_MISC,
+			      (u64)HCMD_MISC_GRANT_LCB_ACCESS <<
+			      LOAD_DATA_FIELD_ID_SHIFT, NULL);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd, "%s: command failed with error %d\n",
+			   __func__, ret);
+	}
+	return ret == HCMD_SUCCESS ? 0 : -EBUSY;
+}
+
+/*
+ * Set the LCB selector - allow host access.  The DCC selector always
+ * points to the host.
+ */
+static inline void set_host_lcb_access(struct hfi2_devdata *dd)
+{
+	write_csr(dd, DC_DC8051_CFG_CSR_ACCESS_SEL,
+		  DC_DC8051_CFG_CSR_ACCESS_SEL_DCC_SMASK |
+		  DC_DC8051_CFG_CSR_ACCESS_SEL_LCB_SMASK);
+}
+
+/*
+ * Clear the LCB selector - allow 8051 access.  The DCC selector always
+ * points to the host.
+ */
+static inline void set_8051_lcb_access(struct hfi2_devdata *dd)
+{
+	write_csr(dd, DC_DC8051_CFG_CSR_ACCESS_SEL,
+		  DC_DC8051_CFG_CSR_ACCESS_SEL_DCC_SMASK);
+}
+
+/*
+ * Acquire LCB access from the 8051.  If the host already has access,
+ * just increment a counter.  Otherwise, inform the 8051 that the
+ * host is taking access.
+ *
+ * Returns:
+ *	0 on success
+ *	-EBUSY if the 8051 has control and cannot be disturbed
+ *	-errno if unable to acquire access from the 8051
+ */
+int acquire_lcb_access(struct hfi2_devdata *dd, int sleep_ok)
+{
+	struct hfi2_pportdata *ppd = dd->pport;
+	int ret = 0;
+
+	/*
+	 * Use the host link state lock so the operation of this routine
+	 * { link state check, selector change, count increment } can occur
+	 * as a unit against a link state change.  Otherwise there is a
+	 * race between the state change and the count increment.
+	 */
+	if (sleep_ok) {
+		mutex_lock(&ppd->hls_lock);
+	} else {
+		while (!mutex_trylock(&ppd->hls_lock))
+			udelay(1);
+	}
+
+	/* this access is valid only when the link is up */
+	if (ppd->host_link_state & HLS_DOWN) {
+		ppd_dev_info(ppd, "%s: link state %s not up\n",
+			     __func__, link_state_name(ppd->host_link_state));
+		ret = -EBUSY;
+		goto done;
+	}
+
+	if (dd->lcb_access_count == 0) {
+		ret = request_host_lcb_access(dd);
+		if (ret) {
+			if (!(dd->flags & HFI2_SHUTDOWN))
+				ppd_dev_err(ppd,
+					    "%s: unable to acquire LCB access, err %d\n",
+					    __func__, ret);
+			goto done;
+		}
+		set_host_lcb_access(dd);
+	}
+	dd->lcb_access_count++;
+done:
+	mutex_unlock(&ppd->hls_lock);
+	return ret;
+}
+
+/*
+ * Release LCB access by decrementing the use count.  If the count is moving
+ * from 1 to 0, inform 8051 that it has control back.
+ *
+ * Returns:
+ *	0 on success
+ *	-errno if unable to release access to the 8051
+ */
+int release_lcb_access(struct hfi2_devdata *dd, int sleep_ok)
+{
+	int ret = 0;
+
+	/*
+	 * Use the host link state lock because the acquire needed it.
+	 * Here, we only need to keep { selector change, count decrement }
+	 * as a unit.
+	 */
+	if (sleep_ok) {
+		mutex_lock(&dd->pport->hls_lock);
+	} else {
+		while (!mutex_trylock(&dd->pport->hls_lock))
+			udelay(1);
+	}
+
+	if (dd->lcb_access_count == 0) {
+		dd_dev_err(dd, "%s: LCB access count is zero.  Skipping.\n",
+			   __func__);
+		goto done;
+	}
+
+	if (dd->lcb_access_count == 1) {
+		set_8051_lcb_access(dd);
+		ret = request_8051_lcb_access(dd);
+		if (ret) {
+			dd_dev_err(dd,
+				   "%s: unable to release LCB access, err %d\n",
+				   __func__, ret);
+			/* restore host access if the grant didn't work */
+			set_host_lcb_access(dd);
+			goto done;
+		}
+	}
+	dd->lcb_access_count--;
+done:
+	mutex_unlock(&dd->pport->hls_lock);
+	return ret;
+}
+
+/*
+ * Initialize LCB access variables and state.  Called during driver load,
+ * after most of the initialization is finished.
+ *
+ * The DC default is LCB access on for the host.  The driver defaults to
+ * leaving access to the 8051.  Assign access now - this constrains the call
+ * to this routine to be after all LCB set-up is done.  In particular, after
+ * hf1_init_dd() -> set_up_interrupts() -> clear_all_interrupts()
+ */
+static void init_lcb_access(struct hfi2_devdata *dd)
+{
+	dd->lcb_access_count = 0;
+}
+
+/*
+ * Write a response back to a 8051 request.
+ */
+static void hreq_response(struct hfi2_devdata *dd, u8 return_code, u16 rsp_data)
+{
+	write_csr(dd, DC_DC8051_CFG_EXT_DEV_0,
+		  DC_DC8051_CFG_EXT_DEV_0_COMPLETED_SMASK |
+		  (u64)return_code <<
+		  DC_DC8051_CFG_EXT_DEV_0_RETURN_CODE_SHIFT |
+		  (u64)rsp_data << DC_DC8051_CFG_EXT_DEV_0_RSP_DATA_SHIFT);
+}
+
+/*
+ * Handle host requests from the 8051.
+ */
+static void handle_8051_request(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u16 data = 0;
+	u8 type;
+
+	reg = read_csr(dd, DC_DC8051_CFG_EXT_DEV_1);
+	if ((reg & DC_DC8051_CFG_EXT_DEV_1_REQ_NEW_SMASK) == 0)
+		return;	/* no request */
+
+	/* zero out COMPLETED so the response is seen */
+	write_csr(dd, DC_DC8051_CFG_EXT_DEV_0, 0);
+
+	/* extract request details */
+	type = (reg >> DC_DC8051_CFG_EXT_DEV_1_REQ_TYPE_SHIFT)
+			& DC_DC8051_CFG_EXT_DEV_1_REQ_TYPE_MASK;
+	data = (reg >> DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SHIFT)
+			& DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_MASK;
+
+	switch (type) {
+	case HREQ_LOAD_CONFIG:
+	case HREQ_SAVE_CONFIG:
+	case HREQ_READ_CONFIG:
+	case HREQ_SET_TX_EQ_ABS:
+	case HREQ_SET_TX_EQ_REL:
+	case HREQ_ENABLE:
+		ppd_dev_info(ppd, "8051 request: request 0x%x not supported\n",
+			     type);
+		hreq_response(dd, HREQ_NOT_SUPPORTED, 0);
+		break;
+	case HREQ_LCB_RESET:
+		/* Put the LCB, RX FPE and TX FPE into reset */
+		write_csr(dd, DCC_CFG_RESET, LCB_RX_FPE_TX_FPE_INTO_RESET);
+		/* Make sure the write completed */
+		(void)read_csr(dd, DCC_CFG_RESET);
+		/* Hold the reset long enough to take effect */
+		udelay(1);
+		/* Take the LCB, RX FPE and TX FPE out of reset */
+		write_csr(dd, DCC_CFG_RESET, LCB_RX_FPE_TX_FPE_OUT_OF_RESET);
+		hreq_response(dd, HREQ_SUCCESS, 0);
+
+		break;
+	case HREQ_CONFIG_DONE:
+		hreq_response(dd, HREQ_SUCCESS, 0);
+		break;
+
+	case HREQ_INTERFACE_TEST:
+		hreq_response(dd, HREQ_SUCCESS, data);
+		break;
+	default:
+		ppd_dev_err(ppd, "8051 request: unknown request 0x%x\n", type);
+		hreq_response(dd, HREQ_NOT_SUPPORTED, 0);
+		break;
+	}
+}
+
+/*
+ * Set up allocation unit vaulue.
+ */
+void set_up_vau(struct hfi2_pportdata *ppd, u8 vau)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+
+	/* do not modify other values in the register */
+	reg &= ~SEND_CM_GLOBAL_CREDIT_AU_SMASK;
+	reg |= (u64)vau << SEND_CM_GLOBAL_CREDIT_AU_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+}
+
+/*
+ * Set up initial VL15 credits of the remote.  Assumes the rest of
+ * the CM credit registers are zero from a previous global or credit reset.
+ * Shared limit for VL15 will always be 0.
+ */
+void set_up_vl15(struct hfi2_pportdata *ppd, u16 vl15buf)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+
+	/* set initial values for total and shared credit limit */
+	reg &= ~(SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SMASK |
+		 SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SMASK);
+
+	/*
+	 * Set total limit to be equal to VL15 credits.
+	 * Leave shared limit at 0.
+	 */
+	reg |= (u64)vl15buf << SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+
+	if (unlikely(dd->hfi2_snoop.mode_flag == HFI2_PORT_SNOOP_MODE)) {
+		write_eport_csr(dd, ppd->hw_pidx,
+			        dd->params->send_cm_credit_vl15_reg,
+				(u64)(vl15buf >> 1) << SEND_CM_CREDIT_VL15_DEDICATED_LIMIT_VL_SHIFT);
+		write_eport_csr(dd, ppd->hw_pidx,
+				dd->params->send_cm_credit_vl_reg,
+				(u64)(vl15buf >> 1) << SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SHIFT);
+	} else {
+		write_eport_csr(dd, ppd->hw_pidx,
+			        dd->params->send_cm_credit_vl15_reg,
+				(u64)vl15buf << SEND_CM_CREDIT_VL15_DEDICATED_LIMIT_VL_SHIFT);
+	}
+}
+
+/*
+ * Zero all credit details from the previous connection and
+ * reset the CM manager's internal counters.
+ */
+void reset_link_credits(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i;
+
+	/* remove all previous VL credit limits */
+	for (i = 0; i < TXE_NUM_DATA_VL; i++)
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_credit_vl_reg + (8 * i), 0);
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_credit_vl15_reg, 0);
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, 0);
+	/* reset the CM block */
+	pio_send_control(ppd, PSC_CM_RESET);
+	/* reset cached value */
+	dd->vl15buf_cached = 0;
+}
+
+/* convert a vCU to a CU */
+static u32 vcu_to_cu(u8 vcu)
+{
+	return 1 << vcu;
+}
+
+/* convert a CU to a vCU */
+static u8 cu_to_vcu(u32 cu)
+{
+	return ilog2(cu);
+}
+
+/* convert a vAU to an AU */
+static u32 vau_to_au(u8 vau)
+{
+	return 8 * (1 << vau);
+}
+
+static void set_linkup_defaults(struct hfi2_pportdata *ppd)
+{
+	ppd->sm_trap_qp = 0x0;
+	ppd->sa_qp = 0x1;
+}
+
+/*
+ * Graceful LCB shutdown.  This leaves the LCB FIFOs in reset.
+ */
+static void lcb_shutdown(struct hfi2_devdata *dd, int abort)
+{
+	u64 reg;
+
+	/* clear lcb run: LCB_CFG_RUN.EN = 0 */
+	write_csr(dd, DC_LCB_CFG_RUN, 0);
+	/* set tx fifo reset: LCB_CFG_TX_FIFOS_RESET.VAL = 1 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET,
+		  1ull << DC_LCB_CFG_TX_FIFOS_RESET_VAL_SHIFT);
+	/* set dcc reset csr: DCC_CFG_RESET.{reset_lcb,reset_rx_fpe} = 1 */
+	dd->lcb_err_en = read_csr(dd, DC_LCB_ERR_EN);
+	reg = read_csr(dd, DCC_CFG_RESET);
+	write_csr(dd, DCC_CFG_RESET, reg |
+		  DCC_CFG_RESET_RESET_LCB | DCC_CFG_RESET_RESET_RX_FPE);
+	(void)read_csr(dd, DCC_CFG_RESET); /* make sure the write completed */
+	if (!abort) {
+		udelay(1);    /* must hold for the longer of 16cclks or 20ns */
+		write_csr(dd, DCC_CFG_RESET, reg);
+		write_csr(dd, DC_LCB_ERR_EN, dd->lcb_err_en);
+	}
+}
+
+/*
+ * This routine should be called after the link has been transitioned to
+ * OFFLINE (OFFLINE state has the side effect of putting the SerDes into
+ * reset).
+ *
+ * The expectation is that the caller of this routine would have taken
+ * care of properly transitioning the link into the correct state.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
+ */
+static void _dc_shutdown(struct hfi2_devdata *dd)
+{
+	lockdep_assert_held(&dd->dc8051_lock);
+
+	if (dd->dc_shutdown)
+		return;
+
+	dd->dc_shutdown = 1;
+	/* Shutdown the LCB */
+	lcb_shutdown(dd, 1);
+	/*
+	 * Going to OFFLINE would have causes the 8051 to put the
+	 * SerDes into reset already. Just need to shut down the 8051,
+	 * itself.
+	 */
+	write_csr(dd, DC_DC8051_CFG_RST, 0x1);
+}
+
+static void dc_shutdown(struct hfi2_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_shutdown(dd);
+	mutex_unlock(&dd->dc8051_lock);
+}
+
+/*
+ * Calling this after the DC has been brought out of reset should not
+ * do any damage.
+ * NOTE: the caller needs to acquire the dd->dc8051_lock lock
+ *       before calling this function.
+ */
+static void _dc_start(struct hfi2_devdata *dd)
+{
+	lockdep_assert_held(&dd->dc8051_lock);
+
+	if (!dd->dc_shutdown)
+		return;
+
+	/* Take the 8051 out of reset */
+	write_csr(dd, DC_DC8051_CFG_RST, 0ull);
+	/* Wait until 8051 is ready */
+	if (wait_fm_ready(dd, TIMEOUT_8051_START))
+		dd_dev_err(dd, "%s: timeout starting 8051 firmware\n",
+			   __func__);
+
+	/* Take away reset for LCB and RX FPE (set in lcb_shutdown). */
+	write_csr(dd, DCC_CFG_RESET, LCB_RX_FPE_TX_FPE_OUT_OF_RESET);
+	/* lcb_shutdown() with abort=1 does not restore these */
+	write_csr(dd, DC_LCB_ERR_EN, dd->lcb_err_en);
+	dd->dc_shutdown = 0;
+}
+
+static void dc_start(struct hfi2_devdata *dd)
+{
+	mutex_lock(&dd->dc8051_lock);
+	_dc_start(dd);
+	mutex_unlock(&dd->dc8051_lock);
+}
+
+/*
+ * Handle a SMA idle message
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_sma_message(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							sma_message_work);
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 msg;
+	int ret;
+
+	/*
+	 * msg is bytes 1-4 of the 40-bit idle message - the command code
+	 * is stripped off
+	 */
+	ret = read_idle_sma(dd, &msg);
+	if (ret)
+		return;
+	ppd_dev_info(ppd, "%s: SMA message 0x%llx\n", __func__, msg);
+	/*
+	 * React to the SMA message.  Byte[1] (0 for us) is the command.
+	 */
+	switch (msg & 0xff) {
+	case SMA_IDLE_ARM:
+		/*
+		 * See OPAv1 table 9-14 - HFI and External Switch Ports Key
+		 * State Transitions
+		 *
+		 * Only expected in INIT or ARMED, discard otherwise.
+		 */
+		if (ppd->host_link_state & (HLS_UP_INIT | HLS_UP_ARMED))
+			ppd->neighbor_normal = 1;
+		break;
+	case SMA_IDLE_ACTIVE:
+		/*
+		 * See OPAv1 table 9-14 - HFI and External Switch Ports Key
+		 * State Transitions
+		 *
+		 * Can activate the node.  Discard otherwise.
+		 */
+		if (ppd->host_link_state == HLS_UP_ARMED &&
+		    ppd->is_active_optimize_enabled) {
+			ppd->neighbor_normal = 1;
+			ret = set_link_state(ppd, HLS_UP_ACTIVE);
+			if (ret)
+				ppd_dev_err(ppd,
+					    "%s: received Active SMA idle message, couldn't set link to Active\n",
+					    __func__);
+		}
+		break;
+	default:
+		ppd_dev_err(ppd,
+			    "%s: received unexpected SMA idle message 0x%llx\n",
+			    __func__, msg);
+		break;
+	}
+}
+
+static void adjust_rcvctrl(struct hfi2_pportdata *ppd, u64 add, u64 clear)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 rcvctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->rcvctrl_lock, flags);
+	rcvctrl = read_iport_csr(dd, ppd->hw_pidx, dd->params->rcv_iport_ctrl_reg);
+	rcvctrl |= add;
+	rcvctrl &= ~clear;
+	write_iport_csr(dd, ppd->hw_pidx, dd->params->rcv_iport_ctrl_reg, rcvctrl);
+	spin_unlock_irqrestore(&dd->rcvctrl_lock, flags);
+}
+
+static inline void add_rcvctrl(struct hfi2_pportdata *ppd, u64 add)
+{
+	adjust_rcvctrl(ppd, add, 0);
+}
+
+static inline void clear_rcvctrl(struct hfi2_pportdata *ppd, u64 clear)
+{
+	adjust_rcvctrl(ppd, 0, clear);
+}
+
+/*
+ * Steps needed to handle active PIO and SDMA when a link goes down.  Not
+ * called at interrupt time.
+ *
+ * This is an alternative to an SPC freeze for link down.  It depends on the
+ * hardware ability to flush packets when in the wrong link state.  WFR does
+ * not have this feature and should continue to perform an SPC freeze on link
+ * down.
+ */
+void start_linkdown_handling(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct send_context *sc;
+	int sc_flags;
+	int i;
+
+	/*
+	 * Stop step
+	 *
+	 * SDMA: Keep the engines running - other ports may be using them.
+	 * Expect all descriptors bound for the down port to be processed,
+	 * but the contents dropped.  This ability is only available on
+	 * hardware after WFR.  Pre-WFR, the descriptor would stall.
+	 *
+	 * PIO: Halt, with linkdown flag, all of the enabled send contexts for
+	 * this port.
+	 */
+	sc_flags = SCF_LINK_DOWN;
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (!sc || sc->ppd != ppd || !(sc->flags & SCF_ENABLED))
+			continue;
+
+		sc_stop(sc, sc_flags);
+	}
+
+	/*
+	 * Disable step
+	 *
+	 * SDMA: The engines are left running.  Nothing to do.
+	 *
+	 * PIO: Disable all contexts for this port.  Non-user contexts will be
+	 * re-enabled at linkup time.  User contexts will be re-enabled when
+	 * the user requests a context reset.
+	 */
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (!sc || sc->ppd != ppd)
+			continue;
+
+		sc_disable(sc);
+	}
+}
+
+/*
+ * Called from all interrupt handlers to start handling an SPC freeze.
+ */
+void start_freeze_handling(struct hfi2_devdata *dd, int flags)
+{
+	struct send_context *sc;
+	int i;
+	int sc_flags;
+
+	if (flags & FREEZE_SELF)
+		write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_FREEZE_SMASK);
+
+	/* enter frozen mode */
+	dd->flags |= HFI2_FROZEN;
+
+	/* notify all SDMA engines that they are going into a freeze */
+	sdma_freeze_notify(dd, !!(flags & FREEZE_LINK_DOWN));
+
+	sc_flags = SCF_FROZEN | SCF_HALTED | (flags & FREEZE_LINK_DOWN ?
+					      SCF_LINK_DOWN : 0);
+	/* do halt pre-handling on all enabled send contexts */
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (sc && (sc->flags & SCF_ENABLED))
+			sc_stop(sc, sc_flags);
+	}
+
+	/* Send context are frozen. Notify user space */
+	for (i = 0; i < dd->num_pports; i++)
+		hfi2_set_uevent_bits(&dd->pport[i], _HFI2_EVENT_FROZEN_BIT);
+
+	if (flags & FREEZE_ABORT) {
+		dd_dev_err(dd, "Aborted freeze recovery. Please REBOOT system\n");
+		return;
+	}
+	/* queue non-interrupt handler */
+	queue_work(dd->hfi2_wq, &dd->freeze_work);
+}
+
+/*
+ * Wait until all 4 sub-blocks indicate that they have frozen or unfrozen,
+ * depending on the "freeze" parameter.
+ *
+ * No need to return an error if it times out, our only option
+ * is to proceed anyway.
+ */
+static void wait_for_freeze_status(struct hfi2_devdata *dd, int freeze)
+{
+	unsigned long timeout;
+	u64 reg;
+
+	timeout = jiffies + msecs_to_jiffies(FREEZE_STATUS_TIMEOUT);
+	while (1) {
+		reg = read_csr(dd, CCE_STATUS);
+		if (freeze) {
+			/* waiting until all indicators are set */
+			if ((reg & ALL_FROZE) == ALL_FROZE)
+				return;	/* all done */
+		} else {
+			/* waiting until all indicators are clear */
+			if ((reg & ALL_FROZE) == 0)
+				return; /* all done */
+		}
+
+		if (time_after(jiffies, timeout)) {
+			dd_dev_err(dd,
+				   "Time out waiting for SPC %sfreeze, bits 0x%llx, expecting 0x%llx, continuing",
+				   freeze ? "" : "un", reg & ALL_FROZE,
+				   freeze ? ALL_FROZE : 0ull);
+			return;
+		}
+		usleep_range(80, 120);
+	}
+}
+
+/*
+ * Do all freeze handling for the RXE block.
+ */
+static void rxe_freeze(struct hfi2_devdata *dd)
+{
+	int i, j;
+	struct hfi2_ctxtdata *rcd;
+
+	/* disable all receive contexts */
+	for (i = 0; i < dd->num_pports; i++) {
+		/* disable port */
+		clear_rcvctrl(&dd->pport[i], RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+
+		for (j = 0; j < dd->pport[i].num_rcv_contexts; j++) {
+			u16 ctxt = dd->pport[i].rcv_context_base + j;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_DIS, rcd);
+			hfi2_rcd_put(rcd);
+		}
+	}
+}
+
+/*
+ * Unfreeze handling for the RXE block - kernel contexts only.
+ * This will also enable the port.  User contexts will do unfreeze
+ * handling on a per-context basis as they call into the driver.
+ */
+static void rxe_kernel_unfreeze(struct hfi2_devdata *dd)
+{
+	struct hfi2_ctxtdata *rcd;
+	u32 rcvmask;
+	u16 i;
+	u16 j;
+
+	/* enable all kernel contexts */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+
+		for (j = 0; j < ppd->num_rcv_contexts; j++) {
+			u16 ctxt = ppd->rcv_context_base + j;
+
+			rcd = hfi2_rcd_get_by_index(dd, ctxt);
+			/*
+			 * Ensure all non-user contexts (kernel) are
+			 * enabled.
+			 */
+			if (!rcd || is_user_context(rcd)) {
+				hfi2_rcd_put(rcd);
+				continue;
+			}
+			rcvmask = HFI2_RCVCTRL_CTXT_ENB;
+			/* HFI2_RCVCTRL_TAILUPD_* needs to be set explicitly */
+			rcvmask |= hfi2_rcvhdrtail_kvaddr(rcd)
+					? HFI2_RCVCTRL_TAILUPD_ENB
+					: HFI2_RCVCTRL_TAILUPD_DIS;
+			hfi2_rcvctrl(dd, rcvmask, rcd);
+			hfi2_rcd_put(rcd);
+		}
+
+		/* enable port */
+		add_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+	}
+}
+
+/*
+ * Non-interrupt SPC freeze handling.
+ *
+ * This is a work-queue function outside of the triggering interrupt.
+ */
+void handle_freeze(struct work_struct *work)
+{
+	struct hfi2_devdata *dd = container_of(work, struct hfi2_devdata,
+								freeze_work);
+
+	/* wait for freeze indicators on all affected blocks */
+	wait_for_freeze_status(dd, 1);
+
+	/* SPC is now frozen */
+
+	/* do send PIO freeze steps */
+	pio_freeze(dd);
+
+	/* do send DMA freeze steps */
+	sdma_freeze(dd);
+
+	/* do send egress freeze steps - nothing to do */
+
+	/* do receive freeze steps */
+	rxe_freeze(dd);
+
+	/*
+	 * Unfreeze the hardware - clear the freeze, wait for each
+	 * block's frozen bit to clear, then clear the frozen flag.
+	 */
+	write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_UNFREEZE_SMASK);
+	wait_for_freeze_status(dd, 0);
+
+	if (is_ax(dd)) {
+		write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_FREEZE_SMASK);
+		wait_for_freeze_status(dd, 1);
+		write_csr(dd, CCE_CTRL, CCE_CTRL_SPC_UNFREEZE_SMASK);
+		wait_for_freeze_status(dd, 0);
+	}
+
+	/* do send PIO unfreeze steps for kernel contexts */
+	pio_kernel_unfreeze(dd);
+
+	/* do send DMA unfreeze steps */
+	sdma_unfreeze(dd);
+
+	/* do send egress unfreeze steps - nothing to do */
+
+	/* do receive unfreeze steps for kernel contexts */
+	rxe_kernel_unfreeze(dd);
+
+	/*
+	 * The unfreeze procedure touches global device registers when
+	 * it disables and re-enables RXE. Mark the device unfrozen
+	 * after all that is done so other parts of the driver waiting
+	 * for the device to unfreeze don't do things out of order.
+	 *
+	 * The above implies that the meaning of HFI2_FROZEN flag is
+	 * "Device has gone into freeze mode and freeze mode handling
+	 * is still in progress."
+	 *
+	 * The flag will be removed when freeze mode processing has
+	 * completed.
+	 */
+	dd->flags &= ~HFI2_FROZEN;
+	wake_up(&dd->event_queue);
+
+	/* no longer frozen */
+}
+
+/**
+ * update_xmit_counters - update PortXmitWait/PortVlXmitWait
+ * counters.
+ * @ppd: info of physical Hfi port
+ * @link_width: new link width after link up or downgrade
+ *
+ * Update the PortXmitWait and PortVlXmitWait counters after
+ * a link up or downgrade event to reflect a link width change.
+ */
+void update_xmit_counters(struct hfi2_pportdata *ppd, u16 link_width)
+{
+	int i;
+	u16 tx_width;
+	u16 link_speed;
+
+	tx_width = tx_link_width(link_width);
+	link_speed = get_link_speed(ppd->link_speed_active);
+
+	/*
+	 * There are C_VL_COUNT number of PortVLXmitWait counters.
+	 * Adding 1 to C_VL_COUNT to include the PortXmitWait counter.
+	 */
+	for (i = 0; i < C_VL_COUNT + 1; i++)
+		get_xmit_wait_counters(ppd, tx_width, link_speed, i);
+}
+
+static void read_ltp_rtt(struct hfi2_pportdata *ppd)
+{
+	u64 reg;
+
+	if (read_lcb_csr(ppd, DC_LCB_STS_ROUND_TRIP_LTP_CNT, &reg)) {
+		ppd_dev_err(ppd, "%s: unable to read LTP RTT\n", __func__);
+		ppd->link_ltp_rtt = 0;
+	} else {
+		ppd->link_ltp_rtt = reg;
+	}
+}
+
+/*
+ * Handle a link up interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_link_up(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  link_up_work);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	set_link_state(ppd, HLS_UP_INIT);
+
+	/* cache the read of DC_LCB_STS_ROUND_TRIP_LTP_CNT */
+	read_ltp_rtt(ppd);
+	/*
+	 * OPA specifies that certain counters are cleared on a transition
+	 * to link up, so do that.
+	 */
+	clear_linkup_counters(ppd);
+	/*
+	 * And (re)set link up default values.
+	 */
+	set_linkup_defaults(ppd);
+
+	/*
+	 * Set VL15 credits. Use cached value from verify cap interrupt.
+	 * In case of quick linkup, vl15 value will be set by
+	 * handle_linkup_change. VerifyCap interrupt handler will not be
+	 * called in those scenarios.
+	 */
+	if (!quick_linkup)
+		set_up_vl15(ppd, dd->vl15buf_cached);
+
+	/* enforce link speed enabled */
+	if ((ppd->link_speed_active & ppd->link_speed_enabled) == 0) {
+		/* oops - current speed is not enabled, bounce */
+		ppd_dev_err(ppd,
+			    "Link speed active 0x%x is outside enabled 0x%x, downing link\n",
+			    ppd->link_speed_active, ppd->link_speed_enabled);
+		set_link_down_reason(ppd, OPA_LINKDOWN_REASON_SPEED_POLICY, 0,
+				     OPA_LINKDOWN_REASON_SPEED_POLICY);
+		set_link_state(ppd, HLS_DN_OFFLINE);
+		start_link(ppd);
+	}
+}
+
+/*
+ * Several pieces of LNI information were cached for SMA in ppd.
+ * Reset these on link down
+ */
+static void reset_neighbor_info(struct hfi2_pportdata *ppd)
+{
+	ppd->neighbor_guid = 0;
+	ppd->neighbor_port_number = 0;
+	ppd->neighbor_type = 0;
+	ppd->neighbor_fm_security = 0;
+}
+
+static const char * const link_down_reason_strs[] = {
+	[OPA_LINKDOWN_REASON_NONE] = "None",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_0] = "Receive error 0",
+	[OPA_LINKDOWN_REASON_BAD_PKT_LEN] = "Bad packet length",
+	[OPA_LINKDOWN_REASON_PKT_TOO_LONG] = "Packet too long",
+	[OPA_LINKDOWN_REASON_PKT_TOO_SHORT] = "Packet too short",
+	[OPA_LINKDOWN_REASON_BAD_SLID] = "Bad SLID",
+	[OPA_LINKDOWN_REASON_BAD_DLID] = "Bad DLID",
+	[OPA_LINKDOWN_REASON_BAD_L2] = "Bad L2",
+	[OPA_LINKDOWN_REASON_BAD_SC] = "Bad SC",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_8] = "Receive error 8",
+	[OPA_LINKDOWN_REASON_BAD_MID_TAIL] = "Bad mid tail",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_10] = "Receive error 10",
+	[OPA_LINKDOWN_REASON_PREEMPT_ERROR] = "Preempt error",
+	[OPA_LINKDOWN_REASON_PREEMPT_VL15] = "Preempt vl15",
+	[OPA_LINKDOWN_REASON_BAD_VL_MARKER] = "Bad VL marker",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_14] = "Receive error 14",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_15] = "Receive error 15",
+	[OPA_LINKDOWN_REASON_BAD_HEAD_DIST] = "Bad head distance",
+	[OPA_LINKDOWN_REASON_BAD_TAIL_DIST] = "Bad tail distance",
+	[OPA_LINKDOWN_REASON_BAD_CTRL_DIST] = "Bad control distance",
+	[OPA_LINKDOWN_REASON_BAD_CREDIT_ACK] = "Bad credit ack",
+	[OPA_LINKDOWN_REASON_UNSUPPORTED_VL_MARKER] = "Unsupported VL marker",
+	[OPA_LINKDOWN_REASON_BAD_PREEMPT] = "Bad preempt",
+	[OPA_LINKDOWN_REASON_BAD_CONTROL_FLIT] = "Bad control flit",
+	[OPA_LINKDOWN_REASON_EXCEED_MULTICAST_LIMIT] = "Exceed multicast limit",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_24] = "Receive error 24",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_25] = "Receive error 25",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_26] = "Receive error 26",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_27] = "Receive error 27",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_28] = "Receive error 28",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_29] = "Receive error 29",
+	[OPA_LINKDOWN_REASON_RCV_ERROR_30] = "Receive error 30",
+	[OPA_LINKDOWN_REASON_EXCESSIVE_BUFFER_OVERRUN] =
+					"Excessive buffer overrun",
+	[OPA_LINKDOWN_REASON_UNKNOWN] = "Unknown",
+	[OPA_LINKDOWN_REASON_REBOOT] = "Reboot",
+	[OPA_LINKDOWN_REASON_NEIGHBOR_UNKNOWN] = "Neighbor unknown",
+	[OPA_LINKDOWN_REASON_FM_BOUNCE] = "FM bounce",
+	[OPA_LINKDOWN_REASON_SPEED_POLICY] = "Speed policy",
+	[OPA_LINKDOWN_REASON_WIDTH_POLICY] = "Width policy",
+	[OPA_LINKDOWN_REASON_DISCONNECTED] = "Disconnected",
+	[OPA_LINKDOWN_REASON_LOCAL_MEDIA_NOT_INSTALLED] =
+					"Local media not installed",
+	[OPA_LINKDOWN_REASON_NOT_INSTALLED] = "Not installed",
+	[OPA_LINKDOWN_REASON_CHASSIS_CONFIG] = "Chassis config",
+	[OPA_LINKDOWN_REASON_END_TO_END_NOT_INSTALLED] =
+					"End to end not installed",
+	[OPA_LINKDOWN_REASON_POWER_POLICY] = "Power policy",
+	[OPA_LINKDOWN_REASON_LINKSPEED_POLICY] = "Link speed policy",
+	[OPA_LINKDOWN_REASON_LINKWIDTH_POLICY] = "Link width policy",
+	[OPA_LINKDOWN_REASON_SWITCH_MGMT] = "Switch management",
+	[OPA_LINKDOWN_REASON_SMA_DISABLED] = "SMA disabled",
+	[OPA_LINKDOWN_REASON_TRANSIENT] = "Transient"
+};
+
+/* return the neighbor link down reason string */
+static const char *link_down_reason_str(u8 reason)
+{
+	const char *str = NULL;
+
+	if (reason < ARRAY_SIZE(link_down_reason_strs))
+		str = link_down_reason_strs[reason];
+	if (!str)
+		str = "(invalid)";
+
+	return str;
+}
+
+/*
+ * Handle a link down interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_link_down(struct work_struct *work)
+{
+	u8 lcl_reason, neigh_reason = 0;
+	u8 link_down_reason;
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  link_down_work);
+	int was_up;
+	static const char ldr_str[] = "Link down reason: ";
+
+	if ((ppd->host_link_state &
+	     (HLS_DN_POLL | HLS_VERIFY_CAP | HLS_GOING_UP)) &&
+	     ppd->port_type == PORT_TYPE_FIXED)
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NOT_INSTALLED);
+
+	/* Go offline first, then deal with reading/writing through 8051 */
+	was_up = !!(ppd->host_link_state & HLS_UP);
+	set_link_state(ppd, HLS_DN_OFFLINE);
+	xchg(&ppd->is_link_down_queued, 0);
+
+	if (was_up) {
+		lcl_reason = 0;
+		/* link down reason is only valid if the link was up */
+		read_link_down_reason(ppd->dd, &link_down_reason);
+		switch (link_down_reason) {
+		case LDR_LINK_TRANSFER_ACTIVE_LOW:
+			/* the link went down, no idle message reason */
+			ppd_dev_info(ppd, "%sUnexpected link down\n",
+				     ldr_str);
+			break;
+		case LDR_RECEIVED_LINKDOWN_IDLE_MSG:
+			/*
+			 * The neighbor reason is only valid if an idle message
+			 * was received for it.
+			 */
+			read_planned_down_reason_code(ppd->dd, &neigh_reason);
+			ppd_dev_info(ppd,
+				     "%sNeighbor link down message %d, %s\n",
+				     ldr_str, neigh_reason,
+				     link_down_reason_str(neigh_reason));
+			break;
+		case LDR_RECEIVED_HOST_OFFLINE_REQ:
+			ppd_dev_info(ppd,
+				     "%sHost requested link to go offline\n",
+				     ldr_str);
+			break;
+		default:
+			ppd_dev_info(ppd, "%sUnknown reason 0x%x\n",
+				     ldr_str, link_down_reason);
+			break;
+		}
+
+		/*
+		 * If no reason, assume peer-initiated but missed
+		 * LinkGoingDown idle flits.
+		 */
+		if (neigh_reason == 0)
+			lcl_reason = OPA_LINKDOWN_REASON_NEIGHBOR_UNKNOWN;
+	} else {
+		/* went down while polling or going up */
+		lcl_reason = OPA_LINKDOWN_REASON_TRANSIENT;
+	}
+
+	set_link_down_reason(ppd, lcl_reason, neigh_reason, 0);
+
+	/* inform the SMA when the link transitions from up to down */
+	if (was_up && ppd->local_link_down_reason.sma == 0 &&
+	    ppd->neigh_link_down_reason.sma == 0) {
+		ppd->local_link_down_reason.sma =
+					ppd->local_link_down_reason.latest;
+		ppd->neigh_link_down_reason.sma =
+					ppd->neigh_link_down_reason.latest;
+	}
+
+	reset_neighbor_info(ppd);
+
+	/* disable the port */
+	clear_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+
+	/*
+	 * If there is no cable attached, turn the DC off. Otherwise,
+	 * start the link bring up.
+	 */
+	if (ppd->port_type == PORT_TYPE_QSFP && !qsfp_mod_present(ppd))
+		dc_shutdown(ppd->dd);
+	else
+		start_link(ppd);
+}
+
+void wfr_handle_link_bounce(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							link_bounce_work);
+
+	/*
+	 * Only do something if the link is currently up.
+	 */
+	if (ppd->host_link_state & HLS_UP) {
+		set_link_state(ppd, HLS_DN_OFFLINE);
+		start_link(ppd);
+	} else {
+		ppd_dev_info(ppd, "%s: link not up (%s), nothing to do\n",
+			     __func__, link_state_name(ppd->host_link_state));
+	}
+}
+
+/*
+ * Mask conversion: Capability exchange to Port LTP.  The capability
+ * exchange has an implicit 16b CRC that is mandatory.
+ */
+static int cap_to_port_ltp(int cap)
+{
+	int port_ltp = PORT_LTP_CRC_MODE_16; /* this mode is mandatory */
+
+	if (cap & CAP_CRC_14B)
+		port_ltp |= PORT_LTP_CRC_MODE_14;
+	if (cap & CAP_CRC_48B)
+		port_ltp |= PORT_LTP_CRC_MODE_48;
+	if (cap & CAP_CRC_12B_16B_PER_LANE)
+		port_ltp |= PORT_LTP_CRC_MODE_PER_LANE;
+
+	return port_ltp;
+}
+
+/*
+ * Convert an OPA Port LTP mask to capability mask
+ */
+int port_ltp_to_cap(int port_ltp)
+{
+	int cap_mask = 0;
+
+	if (port_ltp & PORT_LTP_CRC_MODE_14)
+		cap_mask |= CAP_CRC_14B;
+	if (port_ltp & PORT_LTP_CRC_MODE_48)
+		cap_mask |= CAP_CRC_48B;
+	if (port_ltp & PORT_LTP_CRC_MODE_PER_LANE)
+		cap_mask |= CAP_CRC_12B_16B_PER_LANE;
+
+	return cap_mask;
+}
+
+/*
+ * Convert a single DC LCB CRC mode to an OPA Port LTP mask.
+ */
+static int lcb_to_port_ltp(int lcb_crc)
+{
+	int port_ltp = 0;
+
+	if (lcb_crc == LCB_CRC_12B_16B_PER_LANE)
+		port_ltp = PORT_LTP_CRC_MODE_PER_LANE;
+	else if (lcb_crc == LCB_CRC_48B)
+		port_ltp = PORT_LTP_CRC_MODE_48;
+	else if (lcb_crc == LCB_CRC_14B)
+		port_ltp = PORT_LTP_CRC_MODE_14;
+	else
+		port_ltp = PORT_LTP_CRC_MODE_16;
+
+	return port_ltp;
+}
+
+static void clear_full_mgmt_pkey(struct hfi2_pportdata *ppd)
+{
+	if (ppd->pkeys[2] != 0) {
+		ppd->pkeys[2] = 0;
+		(void)hfi2_set_ib_cfg(ppd, HFI2_IB_CFG_PKEYS, 0);
+		hfi2_event_pkey_change(ppd->dd, ppd->port);
+	}
+}
+
+/*
+ * Convert the given link width to the OPA link width bitmask.
+ */
+static u16 link_width_to_bits(struct hfi2_devdata *dd, u16 width)
+{
+	switch (width) {
+	case 0:
+		/*
+		 * Quick linkup does not set the width.
+		 * Just set it to 4x without complaint.
+		 */
+		if (quick_linkup)
+			return OPA_LINK_WIDTH_4X;
+		return 0; /* no lanes up */
+	case 1: return OPA_LINK_WIDTH_1X;
+	case 2: return OPA_LINK_WIDTH_2X;
+	case 3: return OPA_LINK_WIDTH_3X;
+	case 4: return OPA_LINK_WIDTH_4X;
+	default:
+		dd_dev_info(dd, "%s: invalid width %d, using 4\n",
+			    __func__, width);
+		return OPA_LINK_WIDTH_4X;
+	}
+}
+
+/*
+ * Do a population count on the bottom nibble.
+ */
+static const u8 bit_counts[16] = {
+	0, 1, 1, 2, 1, 2, 2, 3, 1, 2, 2, 3, 2, 3, 3, 4
+};
+
+static inline u8 nibble_to_count(u8 nibble)
+{
+	return bit_counts[nibble & 0xf];
+}
+
+/*
+ * Read the active lane information from the 8051 registers and return
+ * their widths.
+ *
+ * Active lane information is found in these 8051 registers:
+ *	enable_lane_tx
+ *	enable_lane_rx
+ */
+static void get_link_widths(struct hfi2_pportdata *ppd, u16 *tx_width,
+			    u16 *rx_width)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u16 tx, rx;
+	u8 enable_lane_rx;
+	u8 enable_lane_tx;
+	u8 tx_polarity_inversion;
+	u8 rx_polarity_inversion;
+	u8 max_rate;
+
+	/* read the active lanes */
+	read_tx_settings(dd, &enable_lane_tx, &tx_polarity_inversion,
+			 &rx_polarity_inversion, &max_rate);
+	read_local_lni(dd, &enable_lane_rx);
+
+	/* convert to counts */
+	tx = nibble_to_count(enable_lane_tx);
+	rx = nibble_to_count(enable_lane_rx);
+
+	/*
+	 * Set link_speed_active here, overriding what was set in
+	 * handle_verify_cap().  The ASIC 8051 firmware does not correctly
+	 * set the max_rate field in handle_verify_cap until v0.19.
+	 */
+	if ((dd->icode == ICODE_RTL_SILICON) &&
+	    (dd->dc8051_ver < dc8051_ver(0, 19, 0))) {
+		/* max_rate: 0 = 12.5G, 1 = 25G */
+		switch (max_rate) {
+		case 0:
+			ppd->link_speed_active = OPA_LINK_SPEED_12_5G;
+			break;
+		case 1:
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+			break;
+		default:
+			ppd_dev_err(ppd,
+				    "%s: unexpected max rate %d, using 25Gb\n",
+				    __func__, (int)max_rate);
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+			break;
+		}
+	}
+
+	ppd_dev_info(ppd,
+		     "Fabric active lanes (width): tx 0x%x (%d), rx 0x%x (%d)\n",
+		     enable_lane_tx, tx, enable_lane_rx, rx);
+	*tx_width = link_width_to_bits(dd, tx);
+	*rx_width = link_width_to_bits(dd, rx);
+}
+
+/*
+ * Read verify_cap_local_fm_link_width[1] to obtain the link widths.
+ * Valid after the end of VerifyCap and during LinkUp.  Does not change
+ * after link up.  I.e. look elsewhere for downgrade information.
+ *
+ * Bits are:
+ *	+ bits [7:4] contain the number of active transmitters
+ *	+ bits [3:0] contain the number of active receivers
+ * These are numbers 1 through 4 and can be different values if the
+ * link is asymmetric.
+ *
+ * verify_cap_local_fm_link_width[0] retains its original value.
+ */
+static void get_linkup_widths(struct hfi2_pportdata *ppd, u16 *tx_width,
+			      u16 *rx_width)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u16 widths, tx, rx;
+	u8 misc_bits, local_flags;
+	u16 active_tx, active_rx;
+
+	read_vc_local_link_mode(dd, &misc_bits, &local_flags, &widths);
+	tx = widths >> 12;
+	rx = (widths >> 8) & 0xf;
+
+	*tx_width = link_width_to_bits(dd, tx);
+	*rx_width = link_width_to_bits(dd, rx);
+
+	/* print the active widths */
+	get_link_widths(ppd, &active_tx, &active_rx);
+}
+
+/*
+ * Set ppd->link_width_active and ppd->link_width_downgrade_active using
+ * hardware information when the link first comes up.
+ *
+ * The link width is not available until after VerifyCap.AllFramesReceived
+ * (the trigger for handle_verify_cap), so this is outside that routine
+ * and should be called when the 8051 signals linkup.
+ */
+void get_linkup_link_widths(struct hfi2_pportdata *ppd)
+{
+	if (ppd->dd->params->chip_type == CHIP_WFR) {
+		u16 tx_width, rx_width;
+
+		/* get end-of-LNI link widths */
+		get_linkup_widths(ppd, &tx_width, &rx_width);
+
+		/* use tx_width as the link is supposed to be symmetric on link up */
+		ppd->link_width_active = tx_width;
+	} else {
+		ppd->link_speed_active = OPA_LINK_SPEED_25G;
+		ppd->link_speed_enabled = OPA_LINK_SPEED_25G;
+		ppd->link_width_active = OPA_LINK_WIDTH_4X;
+	}
+	/* link width downgrade active (LWD.A) starts out matching LW.A */
+	ppd->link_width_downgrade_tx_active = ppd->link_width_active;
+	ppd->link_width_downgrade_rx_active = ppd->link_width_active;
+	/* per OPA spec, on link up LWD.E resets to LWD.S */
+	ppd->link_width_downgrade_enabled = ppd->link_width_downgrade_supported;
+	/* cache the active egress rate (units {10^6 bits/sec]) */
+	ppd->current_egress_rate = active_egress_rate(ppd);
+}
+
+/*
+ * Handle a verify capabilities interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_verify_cap(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+								link_vc_work);
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u8 power_management;
+	u8 continuous;
+	u8 vcu;
+	u8 vau;
+	u8 z;
+	u16 vl15buf;
+	u16 link_widths;
+	u16 crc_mask;
+	u16 crc_val;
+	u16 device_id;
+	u16 active_tx, active_rx;
+	u8 partner_supported_crc;
+	u8 remote_tx_rate;
+	u8 device_rev;
+
+	set_link_state(ppd, HLS_VERIFY_CAP);
+
+	lcb_shutdown(dd, 0);
+
+	read_vc_remote_phy(dd, &power_management, &continuous);
+	read_vc_remote_fabric(dd, &vau, &z, &vcu, &vl15buf,
+			      &partner_supported_crc);
+	read_vc_remote_link_width(dd, &remote_tx_rate, &link_widths);
+	read_remote_device_id(dd, &device_id, &device_rev);
+
+	/* print the active widths */
+	get_link_widths(ppd, &active_tx, &active_rx);
+	ppd_dev_info(ppd,
+		     "Peer PHY: power management 0x%x, continuous updates 0x%x\n",
+		     (int)power_management, (int)continuous);
+	ppd_dev_info(ppd,
+		     "Peer Fabric: vAU %d, Z %d, vCU %d, vl15 credits 0x%x, CRC sizes 0x%x\n",
+		     (int)vau, (int)z, (int)vcu, (int)vl15buf,
+		     (int)partner_supported_crc);
+	ppd_dev_info(ppd, "Peer Link Width: tx rate 0x%x, widths 0x%x\n",
+		     (u32)remote_tx_rate, (u32)link_widths);
+	ppd_dev_info(ppd, "Peer Device ID: 0x%04x, Revision 0x%02x\n",
+		     (u32)device_id, (u32)device_rev);
+	/*
+	 * The peer vAU value just read is the peer receiver value.  HFI does
+	 * not support a transmit vAU of 0 (AU == 8).  We advertised that
+	 * with Z=1 in the fabric capabilities sent to the peer.  The peer
+	 * will see our Z=1, and, if it advertised a vAU of 0, will move its
+	 * receive to vAU of 1 (AU == 16).  Do the same here.  We do not care
+	 * about the peer Z value - our sent vAU is 3 (hardwired) and is not
+	 * subject to the Z value exception.
+	 */
+	if (vau == 0)
+		vau = 1;
+	set_up_vau(ppd, vau);
+
+	/*
+	 * Set VL15 credits to 0 in global credit register. Cache remote VL15
+	 * credits value and wait for link-up interrupt ot set it.
+	 */
+	set_up_vl15(ppd, 0);
+	dd->vl15buf_cached = vl15buf;
+
+	/* set up the LCB CRC mode */
+	crc_mask = ppd->port_crc_mode_enabled & partner_supported_crc;
+
+	/* order is important: use the lowest bit in common */
+	if (crc_mask & CAP_CRC_14B)
+		crc_val = LCB_CRC_14B;
+	else if (crc_mask & CAP_CRC_48B)
+		crc_val = LCB_CRC_48B;
+	else if (crc_mask & CAP_CRC_12B_16B_PER_LANE)
+		crc_val = LCB_CRC_12B_16B_PER_LANE;
+	else
+		crc_val = LCB_CRC_16B;
+
+	ppd_dev_info(ppd, "Final LCB CRC mode: %d\n", (int)crc_val);
+	write_csr(dd, DC_LCB_CFG_CRC_MODE,
+		  (u64)crc_val << DC_LCB_CFG_CRC_MODE_TX_VAL_SHIFT);
+
+	/* set (14b only) or clear sideband credit */
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_ctrl_reg);
+	if (crc_val == LCB_CRC_14B && crc_14b_sideband) {
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_ctrl_reg,
+				reg | SEND_CM_CTRL_FORCE_CREDIT_MODE_SMASK);
+	} else {
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_ctrl_reg,
+				reg & ~SEND_CM_CTRL_FORCE_CREDIT_MODE_SMASK);
+	}
+
+	ppd->link_speed_active = 0;	/* invalid value */
+	if (dd->dc8051_ver < dc8051_ver(0, 20, 0)) {
+		/* remote_tx_rate: 0 = 12.5G, 1 = 25G */
+		switch (remote_tx_rate) {
+		case 0:
+			ppd->link_speed_active = OPA_LINK_SPEED_12_5G;
+			break;
+		case 1:
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+			break;
+		}
+	} else {
+		/* actual rate is highest bit of the ANDed rates */
+		u8 rate = remote_tx_rate & ppd->local_tx_rate;
+
+		if (rate & 2)
+			ppd->link_speed_active = OPA_LINK_SPEED_25G;
+		else if (rate & 1)
+			ppd->link_speed_active = OPA_LINK_SPEED_12_5G;
+	}
+	if (ppd->link_speed_active == 0) {
+		ppd_dev_err(ppd, "%s: unexpected remote tx rate %d, using 25Gb\n",
+			    __func__, (int)remote_tx_rate);
+		ppd->link_speed_active = OPA_LINK_SPEED_25G;
+	}
+
+	/*
+	 * Cache the values of the supported, enabled, and active
+	 * LTP CRC modes to return in 'portinfo' queries. But the bit
+	 * flags that are returned in the portinfo query differ from
+	 * what's in the link_crc_mask, crc_sizes, and crc_val
+	 * variables. Convert these here.
+	 */
+	ppd->port_ltp_crc_mode = cap_to_port_ltp(link_crc_mask) << 8;
+		/* supported crc modes */
+	ppd->port_ltp_crc_mode |=
+		cap_to_port_ltp(ppd->port_crc_mode_enabled) << 4;
+		/* enabled crc modes */
+	ppd->port_ltp_crc_mode |= lcb_to_port_ltp(crc_val);
+		/* active crc mode */
+
+	/* set up the remote credit return table */
+	assign_remote_cm_au_table(ppd, vcu);
+
+	/*
+	 * The LCB is reset on entry to handle_verify_cap(), so this must
+	 * be applied on every link up.
+	 *
+	 * Adjust LCB error kill enable to kill the link if
+	 * these RBUF errors are seen:
+	 *	REPLAY_BUF_MBE_SMASK
+	 *	FLIT_INPUT_BUF_MBE_SMASK
+	 */
+	if (is_ax(dd)) {			/* fixed in B0 */
+		reg = read_csr(dd, DC_LCB_CFG_LINK_KILL_EN);
+		reg |= DC_LCB_CFG_LINK_KILL_EN_REPLAY_BUF_MBE_SMASK
+			| DC_LCB_CFG_LINK_KILL_EN_FLIT_INPUT_BUF_MBE_SMASK;
+		write_csr(dd, DC_LCB_CFG_LINK_KILL_EN, reg);
+	}
+
+	/* pull LCB fifos out of reset - all fifo clocks must be stable */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0);
+
+	/* give 8051 access to the LCB CSRs */
+	write_csr(dd, DC_LCB_ERR_EN, 0); /* mask LCB errors */
+	set_8051_lcb_access(dd);
+
+	/* tell the 8051 to go to LinkUp */
+	set_link_state(ppd, HLS_GOING_UP);
+}
+
+/**
+ * apply_link_downgrade_policy - Apply the link width downgrade enabled
+ * policy against the current active link widths.
+ * @ppd: info of physical Hfi port
+ * @refresh_widths: True indicates link downgrade event
+ * @return: True indicates a successful link downgrade. False indicates
+ *	    link downgrade event failed and the link will bounce back to
+ *	    default link width.
+ *
+ * Called when the enabled policy changes or the active link widths
+ * change.
+ * Refresh_widths indicates that a link downgrade occurred. The
+ * link_downgraded variable is set by refresh_widths and
+ * determines the success/failure of the policy application.
+ */
+bool apply_link_downgrade_policy(struct hfi2_pportdata *ppd,
+				 bool refresh_widths)
+{
+	int do_bounce = 0;
+	int tries;
+	u16 lwde;
+	u16 tx, rx;
+	bool link_downgraded = refresh_widths;
+
+	/* use the hls lock to avoid a race with actual link up */
+	tries = 0;
+retry:
+	mutex_lock(&ppd->hls_lock);
+	/* only apply if the link is up */
+	if (ppd->host_link_state & HLS_DOWN) {
+		/* still going up..wait and retry */
+		if (ppd->host_link_state & HLS_GOING_UP) {
+			if (++tries < 1000) {
+				mutex_unlock(&ppd->hls_lock);
+				usleep_range(100, 120); /* arbitrary */
+				goto retry;
+			}
+			ppd_dev_err(ppd,
+				    "%s: giving up waiting for link state change\n",
+				    __func__);
+		}
+		goto done;
+	}
+
+	lwde = ppd->link_width_downgrade_enabled;
+
+	if (refresh_widths) {
+		get_link_widths(ppd, &tx, &rx);
+		ppd->link_width_downgrade_tx_active = tx;
+		ppd->link_width_downgrade_rx_active = rx;
+	}
+
+	if (ppd->link_width_downgrade_tx_active == 0 ||
+	    ppd->link_width_downgrade_rx_active == 0) {
+		/* the 8051 reported a dead link as a downgrade */
+		ppd_dev_err(ppd, "Link downgrade is really a link down, ignoring\n");
+		link_downgraded = false;
+	} else if (lwde == 0) {
+		/* downgrade is disabled */
+
+		/* bounce if not at starting active width */
+		if ((ppd->link_width_active !=
+		     ppd->link_width_downgrade_tx_active) ||
+		    (ppd->link_width_active !=
+		     ppd->link_width_downgrade_rx_active)) {
+			ppd_dev_err(ppd,
+				    "Link downgrade is disabled and link has downgraded, downing link\n");
+			ppd_dev_err(ppd,
+				    "  original 0x%x, tx active 0x%x, rx active 0x%x\n",
+				    ppd->link_width_active,
+				    ppd->link_width_downgrade_tx_active,
+				    ppd->link_width_downgrade_rx_active);
+			do_bounce = 1;
+			link_downgraded = false;
+		}
+	} else if ((lwde & ppd->link_width_downgrade_tx_active) == 0 ||
+		   (lwde & ppd->link_width_downgrade_rx_active) == 0) {
+		/* Tx or Rx is outside the enabled policy */
+		ppd_dev_err(ppd,
+			    "Link is outside of downgrade allowed, downing link\n");
+		ppd_dev_err(ppd,
+			    "  enabled 0x%x, tx active 0x%x, rx active 0x%x\n",
+			    lwde, ppd->link_width_downgrade_tx_active,
+			    ppd->link_width_downgrade_rx_active);
+		do_bounce = 1;
+		link_downgraded = false;
+	}
+
+done:
+	mutex_unlock(&ppd->hls_lock);
+
+	if (do_bounce) {
+		set_link_down_reason(ppd, OPA_LINKDOWN_REASON_WIDTH_POLICY, 0,
+				     OPA_LINKDOWN_REASON_WIDTH_POLICY);
+		set_link_state(ppd, HLS_DN_OFFLINE);
+		start_link(ppd);
+	}
+
+	return link_downgraded;
+}
+
+/*
+ * Handle a link downgrade interrupt from the 8051.
+ *
+ * This is a work-queue function outside of the interrupt.
+ */
+void handle_link_downgrade(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							link_downgrade_work);
+
+	ppd_dev_info(ppd, "8051: Link width downgrade\n");
+	if (apply_link_downgrade_policy(ppd, true))
+		update_xmit_counters(ppd, ppd->link_width_downgrade_tx_active);
+}
+
+static char *dcc_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dcc_err_flags,
+		ARRAY_SIZE(dcc_err_flags));
+}
+
+static char *lcb_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, lcb_err_flags,
+		ARRAY_SIZE(lcb_err_flags));
+}
+
+static char *dc8051_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dc8051_err_flags,
+		ARRAY_SIZE(dc8051_err_flags));
+}
+
+static char *dc8051_info_err_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dc8051_info_err_flags,
+		ARRAY_SIZE(dc8051_info_err_flags));
+}
+
+static char *dc8051_info_host_msg_string(char *buf, int buf_len, u64 flags)
+{
+	return flag_string(buf, buf_len, flags, dc8051_info_host_msg_flags,
+		ARRAY_SIZE(dc8051_info_host_msg_flags));
+}
+
+static void handle_8051_interrupt(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	struct hfi2_pportdata *ppd = dd->pport;
+	u64 info, err, host_msg;
+	int queue_link_down = 0;
+	char buf[96];
+
+	/* look at the flags */
+	if (reg & DC_DC8051_ERR_FLG_SET_BY_8051_SMASK) {
+		/* 8051 information set by firmware */
+		/* read DC8051_DBG_ERR_INFO_SET_BY_8051 for details */
+		info = read_csr(dd, DC_DC8051_DBG_ERR_INFO_SET_BY_8051);
+		err = (info >> DC_DC8051_DBG_ERR_INFO_SET_BY_8051_ERROR_SHIFT)
+			& DC_DC8051_DBG_ERR_INFO_SET_BY_8051_ERROR_MASK;
+		host_msg = (info >>
+			DC_DC8051_DBG_ERR_INFO_SET_BY_8051_HOST_MSG_SHIFT)
+			& DC_DC8051_DBG_ERR_INFO_SET_BY_8051_HOST_MSG_MASK;
+
+		/*
+		 * Handle error flags.
+		 */
+		if (err & FAILED_LNI) {
+			/*
+			 * LNI error indications are cleared by the 8051
+			 * only when starting polling.  Only pay attention
+			 * to them when in the states that occur during
+			 * LNI.
+			 */
+			if (ppd->host_link_state
+			    & (HLS_DN_POLL | HLS_VERIFY_CAP | HLS_GOING_UP)) {
+				queue_link_down = 1;
+				ppd_dev_info(ppd, "Link error: %s\n",
+					     dc8051_info_err_string(buf,
+								    sizeof(buf),
+								    err &
+								    FAILED_LNI));
+			}
+			err &= ~(u64)FAILED_LNI;
+		}
+		/* unknown frames can happen durning LNI, just count */
+		if (err & UNKNOWN_FRAME) {
+			ppd->unknown_frame_count++;
+			err &= ~(u64)UNKNOWN_FRAME;
+		}
+		if (err) {
+			/* report remaining errors, but do not do anything */
+			ppd_dev_err(ppd, "8051 info error: %s\n",
+				    dc8051_info_err_string(buf, sizeof(buf),
+							   err));
+		}
+
+		/*
+		 * Handle host message flags.
+		 */
+		if (host_msg & HOST_REQ_DONE) {
+			/*
+			 * Presently, the driver does a busy wait for
+			 * host requests to complete.  This is only an
+			 * informational message.
+			 * NOTE: The 8051 clears the host message
+			 * information *on the next 8051 command*.
+			 * Therefore, when linkup is achieved,
+			 * this flag will still be set.
+			 */
+			host_msg &= ~(u64)HOST_REQ_DONE;
+		}
+		if (host_msg & BC_SMA_MSG) {
+			queue_work(ppd->link_wq, &ppd->sma_message_work);
+			host_msg &= ~(u64)BC_SMA_MSG;
+		}
+		if (host_msg & LINKUP_ACHIEVED) {
+			ppd_dev_info(ppd, "8051: Link up\n");
+			queue_work(ppd->link_wq, &ppd->link_up_work);
+			host_msg &= ~(u64)LINKUP_ACHIEVED;
+		}
+		if (host_msg & EXT_DEVICE_CFG_REQ) {
+			handle_8051_request(ppd);
+			host_msg &= ~(u64)EXT_DEVICE_CFG_REQ;
+		}
+		if (host_msg & VERIFY_CAP_FRAME) {
+			queue_work(ppd->link_wq, &ppd->link_vc_work);
+			host_msg &= ~(u64)VERIFY_CAP_FRAME;
+		}
+		if (host_msg & LINK_GOING_DOWN) {
+			const char *extra = "";
+			/* no downgrade action needed if going down */
+			if (host_msg & LINK_WIDTH_DOWNGRADED) {
+				host_msg &= ~(u64)LINK_WIDTH_DOWNGRADED;
+				extra = " (ignoring downgrade)";
+			}
+			dd_dev_info(dd, "8051: Link down%s\n", extra);
+			queue_link_down = 1;
+			host_msg &= ~(u64)LINK_GOING_DOWN;
+		}
+		if (host_msg & LINK_WIDTH_DOWNGRADED) {
+			queue_work(ppd->link_wq, &ppd->link_downgrade_work);
+			host_msg &= ~(u64)LINK_WIDTH_DOWNGRADED;
+		}
+		if (host_msg) {
+			/* report remaining messages, but do not do anything */
+			ppd_dev_info(ppd, "8051 info host message: %s\n",
+				     dc8051_info_host_msg_string(buf,
+								 sizeof(buf),
+								 host_msg));
+		}
+
+		reg &= ~DC_DC8051_ERR_FLG_SET_BY_8051_SMASK;
+	}
+	if (reg & DC_DC8051_ERR_FLG_LOST_8051_HEART_BEAT_SMASK) {
+		/*
+		 * Lost the 8051 heartbeat.  If this happens, we
+		 * receive constant interrupts about it.  Disable
+		 * the interrupt after the first.
+		 */
+		ppd_dev_err(ppd, "Lost 8051 heartbeat\n");
+		write_csr(dd, DC_DC8051_ERR_EN,
+			  read_csr(dd, DC_DC8051_ERR_EN) &
+			  ~DC_DC8051_ERR_EN_LOST_8051_HEART_BEAT_SMASK);
+
+		reg &= ~DC_DC8051_ERR_FLG_LOST_8051_HEART_BEAT_SMASK;
+	}
+	if (reg) {
+		/* report the error, but do not do anything */
+		ppd_dev_err(ppd, "8051 error: %s\n",
+			    dc8051_err_string(buf, sizeof(buf), reg));
+	}
+
+	if (queue_link_down) {
+		/*
+		 * if the link is already going down or disabled, do not
+		 * queue another. If there's a link down entry already
+		 * queued, don't queue another one.
+		 */
+		if ((ppd->host_link_state &
+		    (HLS_GOING_OFFLINE | HLS_LINK_COOLDOWN)) ||
+		    ppd->link_enabled == 0) {
+			ppd_dev_info(ppd, "%s: not queuing link down. host_link_state %x, link_enabled %x\n",
+				     __func__, ppd->host_link_state,
+				     ppd->link_enabled);
+		} else {
+			if (xchg(&ppd->is_link_down_queued, 1) == 1)
+				ppd_dev_info(ppd,
+					     "%s: link down request already queued\n",
+					     __func__);
+			else
+				queue_work(ppd->link_wq, &ppd->link_down_work);
+		}
+	}
+}
+
+static const char * const fm_config_txt[] = {
+[0] =
+	"BadHeadDist: Distance violation between two head flits",
+[1] =
+	"BadTailDist: Distance violation between two tail flits",
+[2] =
+	"BadCtrlDist: Distance violation between two credit control flits",
+[3] =
+	"BadCrdAck: Credits return for unsupported VL",
+[4] =
+	"UnsupportedVLMarker: Received VL Marker",
+[5] =
+	"BadPreempt: Exceeded the preemption nesting level",
+[6] =
+	"BadControlFlit: Received unsupported control flit",
+/* no 7 */
+[8] =
+	"UnsupportedVLMarker: Received VL Marker for unconfigured or disabled VL",
+};
+
+static const char * const port_rcv_txt[] = {
+[1] =
+	"BadPktLen: Illegal PktLen",
+[2] =
+	"PktLenTooLong: Packet longer than PktLen",
+[3] =
+	"PktLenTooShort: Packet shorter than PktLen",
+[4] =
+	"BadSLID: Illegal SLID (0, using multicast as SLID, does not include security validation of SLID)",
+[5] =
+	"BadDLID: Illegal DLID (0, doesn't match HFI)",
+[6] =
+	"BadL2: Illegal L2 opcode",
+[7] =
+	"BadSC: Unsupported SC",
+[9] =
+	"BadRC: Illegal RC",
+[11] =
+	"PreemptError: Preempting with same VL",
+[12] =
+	"PreemptVL15: Preempting a VL15 packet",
+};
+
+#define OPA_LDR_FMCONFIG_OFFSET 16
+#define OPA_LDR_PORTRCV_OFFSET 0
+static void handle_dcc_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	u64 info, hdr0, hdr1;
+	const char *extra;
+	char buf[96];
+	struct hfi2_pportdata *ppd = dd->pport;
+	u8 lcl_reason = 0;
+	int do_bounce = 0;
+
+	if (reg & DCC_ERR_FLG_UNCORRECTABLE_ERR_SMASK) {
+		if (!(dd->err_info_uncorrectable & OPA_EI_STATUS_SMASK)) {
+			info = read_csr(dd, DCC_ERR_INFO_UNCORRECTABLE);
+			dd->err_info_uncorrectable = info & OPA_EI_CODE_SMASK;
+			/* set status bit */
+			dd->err_info_uncorrectable |= OPA_EI_STATUS_SMASK;
+		}
+		reg &= ~DCC_ERR_FLG_UNCORRECTABLE_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_LINK_ERR_SMASK) {
+		/* this counter saturates at (2^32) - 1 */
+		if (ppd->link_downed < (u32)UINT_MAX)
+			ppd->link_downed++;
+		reg &= ~DCC_ERR_FLG_LINK_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_FMCONFIG_ERR_SMASK) {
+		u8 reason_valid = 1;
+
+		info = read_csr(dd, DCC_ERR_INFO_FMCONFIG);
+		if (!(dd->err_info_fmconfig & OPA_EI_STATUS_SMASK)) {
+			dd->err_info_fmconfig = info & OPA_EI_CODE_SMASK;
+			/* set status bit */
+			dd->err_info_fmconfig |= OPA_EI_STATUS_SMASK;
+		}
+		switch (info) {
+		case 0:
+		case 1:
+		case 2:
+		case 3:
+		case 4:
+		case 5:
+		case 6:
+			extra = fm_config_txt[info];
+			break;
+		case 8:
+			extra = fm_config_txt[info];
+			if (ppd->port_error_action &
+			    OPA_PI_MASK_FM_CFG_UNSUPPORTED_VL_MARKER) {
+				do_bounce = 1;
+				/*
+				 * lcl_reason cannot be derived from info
+				 * for this error
+				 */
+				lcl_reason =
+				  OPA_LINKDOWN_REASON_UNSUPPORTED_VL_MARKER;
+			}
+			break;
+		default:
+			reason_valid = 0;
+			snprintf(buf, sizeof(buf), "reserved%lld", info);
+			extra = buf;
+			break;
+		}
+
+		if (reason_valid && !do_bounce) {
+			do_bounce = ppd->port_error_action &
+					(1 << (OPA_LDR_FMCONFIG_OFFSET + info));
+			lcl_reason = info + OPA_LINKDOWN_REASON_BAD_HEAD_DIST;
+		}
+
+		/* just report this */
+		dd_dev_info_ratelimited(dd, "DCC Error: fmconfig error: %s\n",
+					extra);
+		reg &= ~DCC_ERR_FLG_FMCONFIG_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_RCVPORT_ERR_SMASK) {
+		u8 reason_valid = 1;
+
+		info = read_csr(dd, DCC_ERR_INFO_PORTRCV);
+		hdr0 = read_csr(dd, DCC_ERR_INFO_PORTRCV_HDR0);
+		hdr1 = read_csr(dd, DCC_ERR_INFO_PORTRCV_HDR1);
+		if (!(dd->err_info_rcvport.status_and_code &
+		      OPA_EI_STATUS_SMASK)) {
+			dd->err_info_rcvport.status_and_code =
+				info & OPA_EI_CODE_SMASK;
+			/* set status bit */
+			dd->err_info_rcvport.status_and_code |=
+				OPA_EI_STATUS_SMASK;
+			/*
+			 * save first 2 flits in the packet that caused
+			 * the error
+			 */
+			dd->err_info_rcvport.packet_flit1 = hdr0;
+			dd->err_info_rcvport.packet_flit2 = hdr1;
+		}
+		switch (info) {
+		case 1:
+		case 2:
+		case 3:
+		case 4:
+		case 5:
+		case 6:
+		case 7:
+		case 9:
+		case 11:
+		case 12:
+			extra = port_rcv_txt[info];
+			break;
+		default:
+			reason_valid = 0;
+			snprintf(buf, sizeof(buf), "reserved%lld", info);
+			extra = buf;
+			break;
+		}
+
+		if (reason_valid && !do_bounce) {
+			do_bounce = ppd->port_error_action &
+					(1 << (OPA_LDR_PORTRCV_OFFSET + info));
+			lcl_reason = info + OPA_LINKDOWN_REASON_RCV_ERROR_0;
+		}
+
+		/* just report this */
+		dd_dev_info_ratelimited(dd, "DCC Error: PortRcv error: %s\n"
+					"               hdr0 0x%llx, hdr1 0x%llx\n",
+					extra, hdr0, hdr1);
+
+		reg &= ~DCC_ERR_FLG_RCVPORT_ERR_SMASK;
+	}
+
+	if (reg & DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_UC_SMASK) {
+		/* informative only */
+		dd_dev_info_ratelimited(dd, "8051 access to LCB blocked\n");
+		reg &= ~DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_UC_SMASK;
+	}
+	if (reg & DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_HOST_SMASK) {
+		/* informative only */
+		dd_dev_info_ratelimited(dd, "host access to LCB blocked\n");
+		reg &= ~DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_HOST_SMASK;
+	}
+
+	if (unlikely(hfi2_dbg_fault_suppress_err(&dd->verbs_dev)))
+		reg &= ~DCC_ERR_FLG_LATE_EBP_ERR_SMASK;
+
+	/* report any remaining errors */
+	if (reg)
+		dd_dev_info_ratelimited(dd, "DCC Error: %s\n",
+					dcc_err_string(buf, sizeof(buf), reg));
+
+	if (lcl_reason == 0)
+		lcl_reason = OPA_LINKDOWN_REASON_UNKNOWN;
+
+	if (do_bounce) {
+		dd_dev_info_ratelimited(dd, "%s: PortErrorAction bounce\n",
+					__func__);
+		set_link_down_reason(ppd, lcl_reason, 0, lcl_reason);
+		queue_work(ppd->link_wq, &ppd->link_bounce_work);
+	}
+}
+
+static void handle_lcb_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	char buf[96];
+
+	dd_dev_info(dd, "LCB Error: %s\n",
+		    lcb_err_string(buf, sizeof(buf), reg));
+}
+
+/*
+ * CCE block DC interrupt.  Source is < 8.
+ */
+static void is_dc_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct err_reg_info *eri = &dc_errs[source];
+
+	if (eri->handler) {
+		interrupt_clear_down(dd, 0, eri);
+	} else if (source == 3 /* dc_lbm_int */) {
+		/*
+		 * This indicates that a parity error has occurred on the
+		 * address/control lines presented to the LBM.  The error
+		 * is a single pulse, there is no associated error flag,
+		 * and it is non-maskable.  This is because if a parity
+		 * error occurs on the request the request is dropped.
+		 * This should never occur, but it is nice to know if it
+		 * ever does.
+		 */
+		dd_dev_err(dd, "Parity error in DC LBM block\n");
+	} else {
+		dd_dev_err(dd, "Invalid DC interrupt %u\n", source);
+	}
+}
+
+/*
+ * TX block send credit interrupt.
+ */
+void is_send_credit_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	sc_group_release_update(dd, source);
+}
+
+/*
+ * TX block SDMA interrupt.  Source is < 48.
+ *
+ * SDMA interrupts are grouped by type:
+ *
+ *	 0 -  N-1 = SDma
+ *	 N - 2N-1 = SDmaProgress
+ *	2N - 3N-1 = SDmaIdle
+ */
+void is_sdma_eng_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	/* what interrupt */
+	unsigned int what  = source / TXE_NUM_SDMA_ENGINES;
+	/* which engine */
+	unsigned int which = source % TXE_NUM_SDMA_ENGINES;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(dd, "CONFIG SDMA(%u) %s:%d %s()\n", which,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	sdma_dumpstate(&dd->per_sdma[which]);
+#endif
+
+	if (likely(what < 3 && which < dd->num_sdma)) {
+		sdma_engine_interrupt(&dd->per_sdma[which], 1ull << source);
+	} else {
+		/* should not happen */
+		dd_dev_err(dd, "Invalid SDMA interrupt 0x%x\n", source);
+	}
+}
+
+/**
+ * is_rcv_avail_int() - User receive context available IRQ handler
+ * @dd: valid dd
+ * @source: logical IRQ source (offset from IS_RCVAVAIL_START)
+ *
+ * RX block receive available interrupt.
+ *
+ * This is the general interrupt handler for user (PSM) receive contexts,
+ * and can only be used for non-threaded IRQs.
+ */
+void is_rcv_avail_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	struct hfi2_ctxtdata *rcd;
+
+	rcd = hfi2_rcd_get_by_index(dd, source);
+	if (rcd) {
+		handle_user_interrupt(rcd);
+		hfi2_rcd_put(rcd);
+		return;	/* OK */
+	}
+	dd_dev_err(dd, "unexpected dataless receive available context interrupt %u\n",
+		   source);
+}
+
+/**
+ * is_rcv_urgent_int() - User receive context urgent IRQ handler
+ * @dd: valid dd
+ * @source: logical IRQ source (offset from IS_RCVURGENT_START)
+ *
+ * RX block receive urgent interrupt.
+ *
+ * NOTE: kernel receive contexts specifically do NOT enable this IRQ.
+ */
+void is_rcv_urgent_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	struct hfi2_ctxtdata *rcd;
+
+	rcd = hfi2_rcd_get_by_index(dd, source);
+	if (rcd) {
+		handle_user_interrupt(rcd);
+		hfi2_rcd_put(rcd);
+		return;	/* OK */
+	}
+	dd_dev_err(dd, "unexpected dataless receive urgent context interrupt %u\n",
+		   source);
+}
+
+/*
+ * Reserved range interrupt.  Should not be called in normal operation.
+ */
+static void is_reserved_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	dd_dev_err(dd, "unexpected %s interrupt\n",
+		   is_reserved_name(name, sizeof(name), source));
+}
+
+const struct is_table is_table[] = {
+/*
+ * start		 end
+ *				name func		interrupt func
+ */
+{ IS_GENERAL_ERR_START,  IS_GENERAL_ERR_END,
+				is_misc_err_name,	is_misc_err_int },
+{ IS_SDMAENG_ERR_START,  IS_SDMAENG_ERR_END,
+				is_sdma_eng_err_name,	is_sdma_eng_err_int },
+{ IS_SENDCTXT_ERR_START, IS_SENDCTXT_ERR_END,
+				is_sendctxt_err_name,	is_sendctxt_err_int },
+{ IS_SDMA_START,	     IS_SDMA_IDLE_END,
+				is_sdma_eng_name,	is_sdma_eng_int },
+{ IS_VARIOUS_START,	     IS_VARIOUS_END,
+				is_various_name,	is_various_int },
+{ IS_DC_START,	     IS_DC_END,
+				is_dc_name,		is_dc_int },
+{ IS_RCVAVAIL_START,     IS_RCVAVAIL_END,
+				is_rcv_avail_name,	is_rcv_avail_int },
+{ IS_RCVURGENT_START,    IS_RCVURGENT_END,
+				is_rcv_urgent_name,	is_rcv_urgent_int },
+{ IS_SENDCREDIT_START,   IS_SENDCREDIT_END,
+				is_send_credit_name,	is_send_credit_int},
+{ IS_RESERVED_START,     IS_RESERVED_END,
+				is_reserved_name,	is_reserved_int},
+{ 0, 0, 0, 0 } /* terminator */
+};
+
+/*
+ * General interrupt sources to enable.  This is all sources but SDMA
+ * (SdmaEngErr, Sdma, SdmaProgress, SdmaIdle), and Receive (RcvAvail,
+ * RcvUrgent).
+ */
+const struct gi_enable_entry wfr_gi_enable_table[] = {
+	{ IS_GENERAL_ERR_START, IS_GENERAL_ERR_END },
+	{ IS_SENDCTXT_ERR_START, IS_SENDCTXT_ERR_END },
+	{ IS_VARIOUS_START, IS_VARIOUS_END },
+	{ IS_DC_START, IS_DC_END },
+	{ IS_SENDCREDIT_START, IS_SENDCREDIT_END },
+	{ 1, 0 } /* terminator */
+};
+
+/*
+ * Interrupt source interrupt - called when the given source has an interrupt.
+ * Source is a bit index into an array of 64-bit integers.
+ */
+static void is_interrupt(struct hfi2_devdata *dd, unsigned int source)
+{
+	const struct is_table *entry;
+
+	/* avoids a double compare by walking the table in-order */
+	for (entry = &dd->params->is_table[0]; entry->is_name; entry++) {
+		if (source <= entry->end) {
+			trace_hfi2_interrupt(dd, entry, source);
+			entry->is_int(dd, source - entry->start);
+			return;
+		}
+	}
+	/* fell off the end */
+	dd_dev_err(dd, "invalid interrupt source %u\n", source);
+}
+
+/**
+ * general_interrupt -  General interrupt handler
+ * @irq: MSIx IRQ vector
+ * @data: hfi2 devdata
+ *
+ * This is able to correctly handle all non-threaded interrupts.  Receive
+ * context DATA IRQs are threaded and are not supported by this handler.
+ *
+ */
+irqreturn_t general_interrupt(int irq, void *data)
+{
+	struct hfi2_devdata *dd = data;
+	u64 regs[LARGEST_NUM_INT_CSRS];
+	u64 mask;
+	u32 bit;
+	int i;
+	irqreturn_t handled = IRQ_NONE;
+
+	this_cpu_inc(*dd->int_counter);
+
+	/* phase 1: scan and clear all handled interrupts */
+	for (i = 0; i < dd->params->num_int_csrs; i++) {
+		/* create mask from hw masked and remapped */
+		mask = dd->gi_mask[i].cce_int_mask & dd->gi_mask[i].remap;
+		if (mask == 0) {
+			regs[i] = 0;	/* used later */
+			continue;
+		}
+		regs[i] = read_csr(dd, CCE_INT_STATUS + (8 * i)) & mask;
+		/* only clear if anything is set */
+		if (regs[i])
+			write_csr(dd, CCE_INT_CLEAR + (8 * i), regs[i]);
+	}
+
+	/* phase 2: call the appropriate handler */
+	for_each_set_bit(bit, (unsigned long *)&regs[0],
+			 dd->params->num_int_csrs * 64) {
+		is_interrupt(dd, bit);
+		handled = IRQ_HANDLED;
+	}
+
+	return handled;
+}
+
+static inline void __hfi2_sde_eoi_intr(struct sdma_engine *sde, u32 off, u64 status)
+{
+	struct hfi2_devdata *dd = sde->dd;
+
+	/* clear the interrupt(s) *after* handling them */
+	write_csr(dd, CCE_INT_CLEAR + off, status);
+	if (sdma_work_pending(sde))
+		write_csr(dd, CCE_INT_FORCE + off, sde->int_mask);
+}
+
+irqreturn_t sdma_interrupt(int irq, void *data)
+{
+	struct sdma_engine *sde = data;
+	struct hfi2_devdata *dd = sde->dd;
+	u64 status;
+	u32 off;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(dd, "CONFIG SDMA(%u) %s:%d %s()\n", sde->this_idx,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	sdma_dumpstate(sde);
+#endif
+
+	this_cpu_inc(*dd->int_counter);
+
+	/* This read_csr is really bad in the hot path */
+	off = 8 * (dd->params->is_sdma_start / 64);
+	status = read_csr(dd, CCE_INT_STATUS + off) & sde->imask;
+	if (likely(status)) {
+		/* handle the interrupt(s) */
+		sdma_engine_interrupt(sde, status);
+		if (sdma_work_pending(sde))
+			return IRQ_WAKE_THREAD;
+		__hfi2_sde_eoi_intr(sde, off, status);
+	} else {
+		dd_dev_info_ratelimited(dd, "SDMA engine %u interrupt, but no status bits set\n",
+					sde->this_idx);
+	}
+	return IRQ_HANDLED;
+}
+
+irqreturn_t sdma_interrupt_thr(int irq, void *data)
+{
+	struct sdma_engine *sde = data;
+	struct hfi2_devdata *dd = sde->dd;
+	u64 status;
+	u32 off;
+	unsigned long ty;
+	unsigned long flags;
+
+	/* This read_csr is really bad in the hot path */
+	off = 8 * (dd->params->is_sdma_start / 64);
+	status = read_csr(dd, CCE_INT_STATUS + off) & sde->imask;
+	ty = jiffies + msecs_to_jiffies(sdma_yield);
+	if (likely(status)) {
+again:
+		/* handle the interrupt(s) */
+		sdma_engine_interrupt(sde, status);
+
+		if (sdma_work_pending(sde)) {
+			if (time_after(jiffies, ty)) {
+				cond_resched();
+				ty = jiffies + msecs_to_jiffies(sdma_yield);
+			}
+			goto again;
+		}
+		local_irq_save(flags);
+		__hfi2_sde_eoi_intr(sde, off, status);
+		local_irq_restore(flags);
+	} else {
+		dd_dev_info_ratelimited(dd, "SDMA engine %u interrupt, but no status bits set\n",
+					sde->this_idx);
+	}
+	return IRQ_HANDLED;
+}
+
+/*
+ * Clear the receive interrupt.  Use a read of the interrupt clear CSR
+ * to insure that the write completed.  This does NOT guarantee that
+ * queued DMA writes to memory from the chip are pushed.
+ */
+static inline void clear_recv_intr(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 addr = CCE_INT_CLEAR + (8 * rcd->ireg);
+
+	write_csr(dd, addr, rcd->imask);
+	/* force the above write on the chip and get a value back */
+	(void)read_csr(dd, addr);
+}
+
+/* force the receive interrupt */
+void force_recv_intr(struct hfi2_ctxtdata *rcd)
+{
+	write_csr(rcd->dd, CCE_INT_FORCE + (8 * rcd->ireg), rcd->imask);
+}
+
+/*
+ * Return the receive sequence from the given RHF.  This routine is intended
+ * to be called without a previously determined chip type, so it needs to
+ * check the chip type to correctly extract the RHF field.  Hence "slow".
+ */
+u32 slow_rhf_rcv_seq(struct hfi2_ctxtdata *rcd, u64 rhf)
+{
+	if (rcd->dd->params->chip_type == CHIP_WFR)
+		return wfr_rhf_rcv_seq(rhf);
+	return jkr_rhf_rcv_seq(rhf);
+}
+
+static bool hfi2_packet_present(struct hfi2_ctxtdata *rcd)
+{
+	if (likely(!rcd->rcvhdrtail_kvaddr)) {
+		u32 seq = slow_rhf_rcv_seq(rcd, rhf_to_cpu(get_rhf_addr(rcd)));
+
+		return !last_rcv_seq(rcd, seq);
+	}
+	return hfi2_rcd_head(rcd) != get_rcvhdrtail(rcd);
+}
+
+/*
+ * Return non-zero if a packet is present.
+ *
+ * This routine is called when rechecking for packets after the RcvAvail
+ * interrupt has been cleared down.  First, do a quick check of memory for
+ * a packet present.  If not found, use an expensive CSR read of the context
+ * tail to determine the actual tail.  The CSR read is necessary because there
+ * is no method to push pending DMAs to memory other than an interrupt and we
+ * are trying to determine if we need to force an interrupt.
+ */
+static inline int check_packet_present(struct hfi2_ctxtdata *rcd)
+{
+	u32 tail;
+
+	if (hfi2_packet_present(rcd))
+		return 1;
+
+	/* fall back to a CSR read, correct indpendent of DMA_RTAIL */
+	tail = (u32)read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_tail_reg);
+	return hfi2_rcd_head(rcd) != tail;
+}
+
+/*
+ * Common code for receive contexts interrupt handlers.
+ * Update traces, increment kernel IRQ counter and
+ * setup ASPM when needed.
+ */
+static void receive_interrupt_common(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+
+	trace_hfi2_receive_interrupt(dd, rcd);
+	this_cpu_inc(*dd->int_counter);
+	aspm_ctx_disable(rcd);
+}
+
+/*
+ * __hfi2_rcd_eoi_intr() - Make HW issue receive interrupt
+ * when there are packets present in the queue. When calling
+ * with interrupts enabled please use hfi2_rcd_eoi_intr.
+ *
+ * @rcd: valid receive context
+ */
+static void __hfi2_rcd_eoi_intr(struct hfi2_ctxtdata *rcd)
+{
+	if (!rcd->rcvhdrq)
+		return;
+	clear_recv_intr(rcd);
+	if (check_packet_present(rcd))
+		force_recv_intr(rcd);
+}
+
+/**
+ * hfi2_rcd_eoi_intr() - End of Interrupt processing action
+ *
+ * @rcd: Ptr to hfi2_ctxtdata of receive context
+ *
+ *  Hold IRQs so we can safely clear the interrupt and
+ *  recheck for a packet that may have arrived after the previous
+ *  check and the interrupt clear.  If a packet arrived, force another
+ *  interrupt. This routine can be called at the end of receive packet
+ *  processing in interrupt service routines, interrupt service thread
+ *  and softirqs
+ */
+static void hfi2_rcd_eoi_intr(struct hfi2_ctxtdata *rcd)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__hfi2_rcd_eoi_intr(rcd);
+	local_irq_restore(flags);
+}
+
+/**
+ * hfi2_netdev_rx_napi - napi poll function to move eoi inline
+ * @napi: pointer to napi object
+ * @budget: netdev budget
+ */
+int hfi2_netdev_rx_napi(struct napi_struct *napi, int budget)
+{
+	struct hfi2_netdev_rxq *rxq = container_of(napi,
+			struct hfi2_netdev_rxq, napi);
+	struct hfi2_ctxtdata *rcd = rxq->rcd;
+	int work_done = 0;
+
+	work_done = rcd->do_interrupt(rcd, budget);
+
+	if (work_done < budget) {
+		napi_complete_done(napi, work_done);
+		hfi2_rcd_eoi_intr(rcd);
+	}
+
+	return work_done;
+}
+
+/* Receive packet napi handler for netdevs and AIP  */
+irqreturn_t receive_context_interrupt_napi(int irq, void *data)
+{
+	struct hfi2_ctxtdata *rcd = data;
+
+	receive_interrupt_common(rcd);
+
+	if (likely(rcd->napi)) {
+		if (likely(napi_schedule_prep(rcd->napi)))
+			__napi_schedule_irqoff(rcd->napi);
+		else
+			__hfi2_rcd_eoi_intr(rcd);
+	} else {
+		WARN_ONCE(1, "Napi IRQ handler without napi set up ctxt=%d\n",
+			  rcd->ctxt);
+		__hfi2_rcd_eoi_intr(rcd);
+	}
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Receive packet IRQ handler.  This routine expects to be on its own IRQ.
+ * This routine will try to handle packets immediately (latency), but if
+ * it finds too many, it will invoke the thread handler (bandwitdh).  The
+ * chip receive interrupt is *not* cleared down until this or the thread (if
+ * invoked) is finished.  The intent is to avoid extra interrupts while we
+ * are processing packets anyway.
+ */
+irqreturn_t receive_context_interrupt(int irq, void *data)
+{
+	struct hfi2_ctxtdata *rcd = data;
+	int disposition;
+
+	receive_interrupt_common(rcd);
+
+	/* receive interrupt remains blocked while processing packets */
+	disposition = rcd->do_interrupt(rcd, 0);
+
+	/*
+	 * Too many packets were seen while processing packets in this
+	 * IRQ handler.  Invoke the handler thread.  The receive interrupt
+	 * remains blocked.
+	 */
+	if (disposition == RCV_PKT_LIMIT)
+		return IRQ_WAKE_THREAD;
+
+	__hfi2_rcd_eoi_intr(rcd);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Receive packet thread handler.  This expects to be invoked with the
+ * receive interrupt still blocked.
+ */
+irqreturn_t receive_context_thread(int irq, void *data)
+{
+	struct hfi2_ctxtdata *rcd = data;
+
+	/* receive interrupt is still blocked from the IRQ handler */
+	(void)rcd->do_interrupt(rcd, 1);
+
+	hfi2_rcd_eoi_intr(rcd);
+
+	return IRQ_HANDLED;
+}
+
+/* ========================================================================= */
+
+u32 read_physical_state(struct hfi2_devdata *dd)
+{
+	u64 reg;
+
+	reg = read_csr(dd, DC_DC8051_STS_CUR_STATE);
+	return (reg >> DC_DC8051_STS_CUR_STATE_PORT_SHIFT)
+				& DC_DC8051_STS_CUR_STATE_PORT_MASK;
+}
+
+u32 read_logical_state(struct hfi2_devdata *dd)
+{
+	u64 reg;
+
+	reg = read_csr(dd, DCC_CFG_PORT_CONFIG);
+	return (reg >> DCC_CFG_PORT_CONFIG_LINK_STATE_SHIFT)
+				& DCC_CFG_PORT_CONFIG_LINK_STATE_MASK;
+}
+
+static void set_logical_state(struct hfi2_devdata *dd, u32 chip_lstate)
+{
+	u64 reg;
+
+	reg = read_csr(dd, DCC_CFG_PORT_CONFIG);
+	/* clear current state, set new state */
+	reg &= ~DCC_CFG_PORT_CONFIG_LINK_STATE_SMASK;
+	reg |= (u64)chip_lstate << DCC_CFG_PORT_CONFIG_LINK_STATE_SHIFT;
+	write_csr(dd, DCC_CFG_PORT_CONFIG, reg);
+}
+
+/*
+ * Use the 8051 to read a LCB CSR.
+ */
+static int read_lcb_via_8051(struct hfi2_devdata *dd, u32 addr, u64 *data)
+{
+	u32 regno;
+	int ret;
+
+	/* register is an index of LCB registers: (offset - base) / 8 */
+	regno = (addr - DC_LCB_CFG_RUN) >> 3;
+	ret = do_8051_command(dd, HCMD_READ_LCB_CSR, regno, data);
+	if (ret != HCMD_SUCCESS)
+		return -EBUSY;
+	return 0;
+}
+
+/*
+ * Provide a cache for some of the LCB registers in case the LCB is
+ * unavailable.
+ * (The LCB is unavailable in certain link states, for example.)
+ */
+struct lcb_datum {
+	u32 off;
+	u64 val;
+};
+
+static struct lcb_datum lcb_cache[] = {
+	{ DC_LCB_ERR_INFO_RX_REPLAY_CNT, 0},
+	{ DC_LCB_ERR_INFO_SEQ_CRC_CNT, 0 },
+	{ DC_LCB_ERR_INFO_REINIT_FROM_PEER_CNT, 0 },
+};
+
+static void update_lcb_cache(struct hfi2_pportdata *ppd)
+{
+	int i;
+	int ret;
+	u64 val;
+
+	for (i = 0; i < ARRAY_SIZE(lcb_cache); i++) {
+		ret = read_lcb_csr(ppd, lcb_cache[i].off, &val);
+
+		/* Update if we get good data */
+		if (likely(ret != -EBUSY))
+			lcb_cache[i].val = val;
+	}
+}
+
+static int read_lcb_cache(u32 off, u64 *val)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lcb_cache); i++) {
+		if (lcb_cache[i].off == off) {
+			*val = lcb_cache[i].val;
+			return 0;
+		}
+	}
+
+	pr_warn("%s bad offset 0x%x\n", __func__, off);
+	return -1;
+}
+
+/*
+ * Read an LCB CSR.  Access may not be in host control, so check.
+ * Return 0 on success, -EBUSY on failure.
+ */
+int read_lcb_csr(struct hfi2_pportdata *ppd, u32 addr, u64 *data)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/* if up, go through the 8051 for the value */
+	if (ppd->host_link_state & HLS_UP)
+		return read_lcb_via_8051(dd, addr, data);
+	/* if going up or down, check the cache, otherwise, no access */
+	if (ppd->host_link_state & (HLS_GOING_UP | HLS_GOING_OFFLINE)) {
+		if (read_lcb_cache(addr, data))
+			return -EBUSY;
+		return 0;
+	}
+
+	/* otherwise, host has access */
+	*data = read_csr(dd, addr);
+	return 0;
+}
+
+/*
+ * Use the 8051 to write a LCB CSR.
+ */
+static int write_lcb_via_8051(struct hfi2_devdata *dd, u32 addr, u64 data)
+{
+	u32 regno;
+	int ret;
+
+	/* register is an index of LCB registers: (offset - base) / 8 */
+	regno = (addr - DC_LCB_CFG_RUN) >> 3;
+	ret = do_8051_command(dd, HCMD_WRITE_LCB_CSR, regno, &data);
+	if (ret != HCMD_SUCCESS)
+		return -EBUSY;
+	return 0;
+}
+
+/*
+ * Write an LCB CSR.  Access may not be in host control, so check.
+ * Return 0 on success, -EBUSY on failure.
+ */
+int write_lcb_csr(struct hfi2_pportdata *ppd, u32 addr, u64 data)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/* if up, go through the 8051 for the value */
+	if (ppd->host_link_state & HLS_UP)
+		return write_lcb_via_8051(dd, addr, data);
+	/* if going up or down, no access */
+	if (ppd->host_link_state & (HLS_GOING_UP | HLS_GOING_OFFLINE))
+		return -EBUSY;
+	/* otherwise, host has access */
+	write_csr(dd, addr, data);
+	return 0;
+}
+
+/*
+ * Returns:
+ *	< 0 = Linux error, not able to get access
+ *	> 0 = 8051 command RETURN_CODE
+ */
+static int do_8051_command(struct hfi2_devdata *dd, u32 type, u64 in_data,
+			   u64 *out_data)
+{
+	u64 reg, completed;
+	int return_code;
+	unsigned long timeout;
+
+	hfi2_cdbg(DC8051, "type %d, data 0x%012llx", type, in_data);
+
+	mutex_lock(&dd->dc8051_lock);
+
+	/* We can't send any commands to the 8051 if it's in reset */
+	if (dd->dc_shutdown) {
+		return_code = -ENODEV;
+		goto fail;
+	}
+
+	/*
+	 * If an 8051 host command timed out previously, then the 8051 is
+	 * stuck.
+	 *
+	 * On first timeout, attempt to reset and restart the entire DC
+	 * block (including 8051). (Is this too big of a hammer?)
+	 *
+	 * If the 8051 times out a second time, the reset did not bring it
+	 * back to healthy life. In that case, fail any subsequent commands.
+	 */
+	if (dd->dc8051_timed_out) {
+		if (dd->dc8051_timed_out > 1) {
+			dd_dev_err(dd,
+				   "Previous 8051 host command timed out, skipping command %u\n",
+				   type);
+			return_code = -ENXIO;
+			goto fail;
+		}
+		_dc_shutdown(dd);
+		_dc_start(dd);
+	}
+
+	/*
+	 * If there is no timeout, then the 8051 command interface is
+	 * waiting for a command.
+	 */
+
+	/*
+	 * When writing a LCB CSR, out_data contains the full value to
+	 * be written, while in_data contains the relative LCB
+	 * address in 7:0.  Do the work here, rather than the caller,
+	 * of distrubting the write data to where it needs to go:
+	 *
+	 * Write data
+	 *   39:00 -> in_data[47:8]
+	 *   47:40 -> DC8051_CFG_EXT_DEV_0.RETURN_CODE
+	 *   63:48 -> DC8051_CFG_EXT_DEV_0.RSP_DATA
+	 */
+	if (type == HCMD_WRITE_LCB_CSR) {
+		in_data |= ((*out_data) & 0xffffffffffull) << 8;
+		/* must preserve COMPLETED - it is tied to hardware */
+		reg = read_csr(dd, DC_DC8051_CFG_EXT_DEV_0);
+		reg &= DC_DC8051_CFG_EXT_DEV_0_COMPLETED_SMASK;
+		reg |= ((((*out_data) >> 40) & 0xff) <<
+				DC_DC8051_CFG_EXT_DEV_0_RETURN_CODE_SHIFT)
+		      | ((((*out_data) >> 48) & 0xffff) <<
+				DC_DC8051_CFG_EXT_DEV_0_RSP_DATA_SHIFT);
+		write_csr(dd, DC_DC8051_CFG_EXT_DEV_0, reg);
+	}
+
+	/*
+	 * Do two writes: the first to stabilize the type and req_data, the
+	 * second to activate.
+	 */
+	reg = ((u64)type & DC_DC8051_CFG_HOST_CMD_0_REQ_TYPE_MASK)
+			<< DC_DC8051_CFG_HOST_CMD_0_REQ_TYPE_SHIFT
+		| (in_data & DC_DC8051_CFG_HOST_CMD_0_REQ_DATA_MASK)
+			<< DC_DC8051_CFG_HOST_CMD_0_REQ_DATA_SHIFT;
+	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, reg);
+	reg |= DC_DC8051_CFG_HOST_CMD_0_REQ_NEW_SMASK;
+	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, reg);
+
+	/* wait for completion, alternate: interrupt */
+	timeout = jiffies + msecs_to_jiffies(DC8051_COMMAND_TIMEOUT);
+	while (1) {
+		reg = read_csr(dd, DC_DC8051_CFG_HOST_CMD_1);
+		completed = reg & DC_DC8051_CFG_HOST_CMD_1_COMPLETED_SMASK;
+		if (completed)
+			break;
+		if (time_after(jiffies, timeout)) {
+			dd->dc8051_timed_out++;
+			dd_dev_err(dd, "8051 host command %u timeout\n", type);
+			if (out_data)
+				*out_data = 0;
+			return_code = -ETIMEDOUT;
+			goto fail;
+		}
+		udelay(2);
+	}
+
+	if (out_data) {
+		*out_data = (reg >> DC_DC8051_CFG_HOST_CMD_1_RSP_DATA_SHIFT)
+				& DC_DC8051_CFG_HOST_CMD_1_RSP_DATA_MASK;
+		if (type == HCMD_READ_LCB_CSR) {
+			/* top 16 bits are in a different register */
+			*out_data |= (read_csr(dd, DC_DC8051_CFG_EXT_DEV_1)
+				& DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SMASK)
+				<< (48
+				    - DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SHIFT);
+		}
+	}
+	return_code = (reg >> DC_DC8051_CFG_HOST_CMD_1_RETURN_CODE_SHIFT)
+				& DC_DC8051_CFG_HOST_CMD_1_RETURN_CODE_MASK;
+	dd->dc8051_timed_out = 0;
+	/*
+	 * Clear command for next user.
+	 */
+	write_csr(dd, DC_DC8051_CFG_HOST_CMD_0, 0);
+
+fail:
+	mutex_unlock(&dd->dc8051_lock);
+	return return_code;
+}
+
+static int set_physical_link_state(struct hfi2_devdata *dd, u64 state)
+{
+	return do_8051_command(dd, HCMD_CHANGE_PHY_STATE, state, NULL);
+}
+
+int load_8051_config(struct hfi2_devdata *dd, u8 field_id,
+		     u8 lane_id, u32 config_data)
+{
+	u64 data;
+	int ret;
+
+	data = (u64)field_id << LOAD_DATA_FIELD_ID_SHIFT
+		| (u64)lane_id << LOAD_DATA_LANE_ID_SHIFT
+		| (u64)config_data << LOAD_DATA_DATA_SHIFT;
+	ret = do_8051_command(dd, HCMD_LOAD_CONFIG_DATA, data, NULL);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd,
+			   "load 8051 config: field id %d, lane %d, err %d\n",
+			   (int)field_id, (int)lane_id, ret);
+	}
+	return ret;
+}
+
+/*
+ * Read the 8051 firmware "registers".  Use the RAM directly.  Always
+ * set the result, even on error.
+ * Return 0 on success, -errno on failure
+ */
+int read_8051_config(struct hfi2_devdata *dd, u8 field_id, u8 lane_id,
+		     u32 *result)
+{
+	u64 big_data;
+	u32 addr;
+	int ret;
+
+	/* address start depends on the lane_id */
+	if (lane_id < 4)
+		addr = (4 * NUM_GENERAL_FIELDS)
+			+ (lane_id * 4 * NUM_LANE_FIELDS);
+	else
+		addr = 0;
+	addr += field_id * 4;
+
+	/* read is in 8-byte chunks, hardware will truncate the address down */
+	ret = read_8051_data(dd, addr, 8, &big_data);
+
+	if (ret == 0) {
+		/* extract the 4 bytes we want */
+		if (addr & 0x4)
+			*result = (u32)(big_data >> 32);
+		else
+			*result = (u32)big_data;
+	} else {
+		*result = 0;
+		dd_dev_err(dd, "%s: direct read failed, lane %d, field %d!\n",
+			   __func__, lane_id, field_id);
+	}
+
+	return ret;
+}
+
+static int write_vc_local_phy(struct hfi2_devdata *dd, u8 power_management,
+			      u8 continuous)
+{
+	u32 frame;
+
+	frame = continuous << CONTINIOUS_REMOTE_UPDATE_SUPPORT_SHIFT
+		| power_management << POWER_MANAGEMENT_SHIFT;
+	return load_8051_config(dd, VERIFY_CAP_LOCAL_PHY,
+				GENERAL_CONFIG, frame);
+}
+
+static int write_vc_local_fabric(struct hfi2_devdata *dd, u8 vau, u8 z, u8 vcu,
+				 u16 vl15buf, u8 crc_sizes)
+{
+	u32 frame;
+
+	frame = (u32)vau << VAU_SHIFT
+		| (u32)z << Z_SHIFT
+		| (u32)vcu << VCU_SHIFT
+		| (u32)vl15buf << VL15BUF_SHIFT
+		| (u32)crc_sizes << CRC_SIZES_SHIFT;
+	return load_8051_config(dd, VERIFY_CAP_LOCAL_FABRIC,
+				GENERAL_CONFIG, frame);
+}
+
+static void read_vc_local_link_mode(struct hfi2_devdata *dd, u8 *misc_bits,
+				    u8 *flag_bits, u16 *link_widths)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_LOCAL_LINK_MODE, GENERAL_CONFIG,
+			 &frame);
+	*misc_bits = (frame >> MISC_CONFIG_BITS_SHIFT) & MISC_CONFIG_BITS_MASK;
+	*flag_bits = (frame >> LOCAL_FLAG_BITS_SHIFT) & LOCAL_FLAG_BITS_MASK;
+	*link_widths = (frame >> LINK_WIDTH_SHIFT) & LINK_WIDTH_MASK;
+}
+
+static int write_vc_local_link_mode(struct hfi2_devdata *dd,
+				    u8 misc_bits,
+				    u8 flag_bits,
+				    u16 link_widths)
+{
+	u32 frame;
+
+	frame = (u32)misc_bits << MISC_CONFIG_BITS_SHIFT
+		| (u32)flag_bits << LOCAL_FLAG_BITS_SHIFT
+		| (u32)link_widths << LINK_WIDTH_SHIFT;
+	return load_8051_config(dd, VERIFY_CAP_LOCAL_LINK_MODE, GENERAL_CONFIG,
+		     frame);
+}
+
+static int write_local_device_id(struct hfi2_devdata *dd, u16 device_id,
+				 u8 device_rev)
+{
+	u32 frame;
+
+	frame = ((u32)device_id << LOCAL_DEVICE_ID_SHIFT)
+		| ((u32)device_rev << LOCAL_DEVICE_REV_SHIFT);
+	return load_8051_config(dd, LOCAL_DEVICE_ID, GENERAL_CONFIG, frame);
+}
+
+static void read_remote_device_id(struct hfi2_devdata *dd, u16 *device_id,
+				  u8 *device_rev)
+{
+	u32 frame;
+
+	read_8051_config(dd, REMOTE_DEVICE_ID, GENERAL_CONFIG, &frame);
+	*device_id = (frame >> REMOTE_DEVICE_ID_SHIFT) & REMOTE_DEVICE_ID_MASK;
+	*device_rev = (frame >> REMOTE_DEVICE_REV_SHIFT)
+			& REMOTE_DEVICE_REV_MASK;
+}
+
+int write_host_interface_version(struct hfi2_devdata *dd, u8 version)
+{
+	u32 frame;
+	u32 mask;
+
+	mask = (HOST_INTERFACE_VERSION_MASK << HOST_INTERFACE_VERSION_SHIFT);
+	read_8051_config(dd, RESERVED_REGISTERS, GENERAL_CONFIG, &frame);
+	/* Clear, then set field */
+	frame &= ~mask;
+	frame |= ((u32)version << HOST_INTERFACE_VERSION_SHIFT);
+	return load_8051_config(dd, RESERVED_REGISTERS, GENERAL_CONFIG,
+				frame);
+}
+
+void read_misc_status(struct hfi2_devdata *dd, u8 *ver_major, u8 *ver_minor,
+		      u8 *ver_patch)
+{
+	u32 frame;
+
+	read_8051_config(dd, MISC_STATUS, GENERAL_CONFIG, &frame);
+	*ver_major = (frame >> STS_FM_VERSION_MAJOR_SHIFT) &
+		STS_FM_VERSION_MAJOR_MASK;
+	*ver_minor = (frame >> STS_FM_VERSION_MINOR_SHIFT) &
+		STS_FM_VERSION_MINOR_MASK;
+
+	read_8051_config(dd, VERSION_PATCH, GENERAL_CONFIG, &frame);
+	*ver_patch = (frame >> STS_FM_VERSION_PATCH_SHIFT) &
+		STS_FM_VERSION_PATCH_MASK;
+}
+
+static void read_vc_remote_phy(struct hfi2_devdata *dd, u8 *power_management,
+			       u8 *continuous)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_REMOTE_PHY, GENERAL_CONFIG, &frame);
+	*power_management = (frame >> POWER_MANAGEMENT_SHIFT)
+					& POWER_MANAGEMENT_MASK;
+	*continuous = (frame >> CONTINIOUS_REMOTE_UPDATE_SUPPORT_SHIFT)
+					& CONTINIOUS_REMOTE_UPDATE_SUPPORT_MASK;
+}
+
+static void read_vc_remote_fabric(struct hfi2_devdata *dd, u8 *vau, u8 *z,
+				  u8 *vcu, u16 *vl15buf, u8 *crc_sizes)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_REMOTE_FABRIC, GENERAL_CONFIG, &frame);
+	*vau = (frame >> VAU_SHIFT) & VAU_MASK;
+	*z = (frame >> Z_SHIFT) & Z_MASK;
+	*vcu = (frame >> VCU_SHIFT) & VCU_MASK;
+	*vl15buf = (frame >> VL15BUF_SHIFT) & VL15BUF_MASK;
+	*crc_sizes = (frame >> CRC_SIZES_SHIFT) & CRC_SIZES_MASK;
+}
+
+static void read_vc_remote_link_width(struct hfi2_devdata *dd,
+				      u8 *remote_tx_rate,
+				      u16 *link_widths)
+{
+	u32 frame;
+
+	read_8051_config(dd, VERIFY_CAP_REMOTE_LINK_WIDTH, GENERAL_CONFIG,
+			 &frame);
+	*remote_tx_rate = (frame >> REMOTE_TX_RATE_SHIFT)
+				& REMOTE_TX_RATE_MASK;
+	*link_widths = (frame >> LINK_WIDTH_SHIFT) & LINK_WIDTH_MASK;
+}
+
+static void read_local_lni(struct hfi2_devdata *dd, u8 *enable_lane_rx)
+{
+	u32 frame;
+
+	read_8051_config(dd, LOCAL_LNI_INFO, GENERAL_CONFIG, &frame);
+	*enable_lane_rx = (frame >> ENABLE_LANE_RX_SHIFT) & ENABLE_LANE_RX_MASK;
+}
+
+static void read_last_local_state(struct hfi2_devdata *dd, u32 *lls)
+{
+	read_8051_config(dd, LAST_LOCAL_STATE_COMPLETE, GENERAL_CONFIG, lls);
+}
+
+static void read_last_remote_state(struct hfi2_devdata *dd, u32 *lrs)
+{
+	read_8051_config(dd, LAST_REMOTE_STATE_COMPLETE, GENERAL_CONFIG, lrs);
+}
+
+void wfr_read_link_quality(struct hfi2_pportdata *ppd, u8 *link_quality)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 frame;
+	int ret;
+
+	*link_quality = 0;
+	if (ppd->host_link_state & HLS_UP) {
+		ret = read_8051_config(dd, LINK_QUALITY_INFO, GENERAL_CONFIG,
+				       &frame);
+		if (ret == 0)
+			*link_quality = (frame >> LINK_QUALITY_SHIFT)
+						& LINK_QUALITY_MASK;
+	}
+}
+
+static void read_planned_down_reason_code(struct hfi2_devdata *dd, u8 *pdrrc)
+{
+	u32 frame;
+
+	read_8051_config(dd, LINK_QUALITY_INFO, GENERAL_CONFIG, &frame);
+	*pdrrc = (frame >> DOWN_REMOTE_REASON_SHIFT) & DOWN_REMOTE_REASON_MASK;
+}
+
+static void read_link_down_reason(struct hfi2_devdata *dd, u8 *ldr)
+{
+	u32 frame;
+
+	read_8051_config(dd, LINK_DOWN_REASON, GENERAL_CONFIG, &frame);
+	*ldr = (frame & 0xff);
+}
+
+static int read_tx_settings(struct hfi2_devdata *dd,
+			    u8 *enable_lane_tx,
+			    u8 *tx_polarity_inversion,
+			    u8 *rx_polarity_inversion,
+			    u8 *max_rate)
+{
+	u32 frame;
+	int ret;
+
+	ret = read_8051_config(dd, TX_SETTINGS, GENERAL_CONFIG, &frame);
+	*enable_lane_tx = (frame >> ENABLE_LANE_TX_SHIFT)
+				& ENABLE_LANE_TX_MASK;
+	*tx_polarity_inversion = (frame >> TX_POLARITY_INVERSION_SHIFT)
+				& TX_POLARITY_INVERSION_MASK;
+	*rx_polarity_inversion = (frame >> RX_POLARITY_INVERSION_SHIFT)
+				& RX_POLARITY_INVERSION_MASK;
+	*max_rate = (frame >> MAX_RATE_SHIFT) & MAX_RATE_MASK;
+	return ret;
+}
+
+static int write_tx_settings(struct hfi2_devdata *dd,
+			     u8 enable_lane_tx,
+			     u8 tx_polarity_inversion,
+			     u8 rx_polarity_inversion,
+			     u8 max_rate)
+{
+	u32 frame;
+
+	/* no need to mask, all variable sizes match field widths */
+	frame = enable_lane_tx << ENABLE_LANE_TX_SHIFT
+		| tx_polarity_inversion << TX_POLARITY_INVERSION_SHIFT
+		| rx_polarity_inversion << RX_POLARITY_INVERSION_SHIFT
+		| max_rate << MAX_RATE_SHIFT;
+	return load_8051_config(dd, TX_SETTINGS, GENERAL_CONFIG, frame);
+}
+
+/*
+ * Read an idle LCB message.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+static int read_idle_message(struct hfi2_devdata *dd, u64 type, u64 *data_out)
+{
+	int ret;
+
+	ret = do_8051_command(dd, HCMD_READ_LCB_IDLE_MSG, type, data_out);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd, "read idle message: type %d, err %d\n",
+			   (u32)type, ret);
+		return -EINVAL;
+	}
+	dd_dev_info(dd, "%s: read idle message 0x%llx\n", __func__, *data_out);
+	/* return only the payload as we already know the type */
+	*data_out >>= IDLE_PAYLOAD_SHIFT;
+	return 0;
+}
+
+/*
+ * Read an idle SMA message.  To be done in response to a notification from
+ * the 8051.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+static int read_idle_sma(struct hfi2_devdata *dd, u64 *data)
+{
+	return read_idle_message(dd, (u64)IDLE_SMA << IDLE_MSG_TYPE_SHIFT,
+				 data);
+}
+
+/*
+ * Send an idle LCB message.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+static int send_idle_message(struct hfi2_devdata *dd, u64 data)
+{
+	int ret;
+
+	dd_dev_info(dd, "%s: sending idle message 0x%llx\n", __func__, data);
+	ret = do_8051_command(dd, HCMD_SEND_LCB_IDLE_MSG, data, NULL);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd, "send idle message: data 0x%llx, err %d\n",
+			   data, ret);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Send an idle SMA message.
+ *
+ * Returns 0 on success, -EINVAL on error
+ */
+int send_idle_sma(struct hfi2_devdata *dd, u64 message)
+{
+	u64 data;
+
+	data = ((message & IDLE_PAYLOAD_MASK) << IDLE_PAYLOAD_SHIFT) |
+		((u64)IDLE_SMA << IDLE_MSG_TYPE_SHIFT);
+	return send_idle_message(dd, data);
+}
+
+/*
+ * Initialize the LCB then do a quick link up.  This may or may not be
+ * in loopback.
+ *
+ * return 0 on success, -errno on error
+ */
+static int do_quick_linkup(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	lcb_shutdown(dd, 0);
+
+	if (loopback) {
+		/* LCB_CFG_LOOPBACK.VAL = 2 */
+		/* LCB_CFG_LANE_WIDTH.VAL = 0 */
+		write_csr(dd, DC_LCB_CFG_LOOPBACK,
+			  2ull << DC_LCB_CFG_LOOPBACK_VAL_SHIFT);
+		write_csr(dd, DC_LCB_CFG_LANE_WIDTH, 0);
+	}
+
+	/* start the LCBs */
+	/* LCB_CFG_TX_FIFOS_RESET.VAL = 0 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0);
+
+	if (!loopback) {
+		/*
+		 * When doing quick linkup and not in loopback, both
+		 * sides must be done with LCB set-up before either
+		 * starts the quick linkup.  Put a delay here so that
+		 * both sides can be started and have a chance to be
+		 * done with LCB set up before resuming.
+		 */
+		dd_dev_err(dd,
+			   "Pausing for peer to be finished with LCB set up\n");
+		msleep(5000);
+		dd_dev_err(dd, "Continuing with quick linkup\n");
+	}
+
+	write_csr(dd, DC_LCB_ERR_EN, 0); /* mask LCB errors */
+	set_8051_lcb_access(dd);
+
+	/*
+	 * State "quick" LinkUp request sets the physical link state to
+	 * LinkUp without a verify capability sequence.
+	 */
+	ret = set_physical_link_state(dd, PLS_QUICK_LINKUP);
+	if (ret != HCMD_SUCCESS) {
+		dd_dev_err(dd,
+			   "%s: set physical link state to quick LinkUp failed with return %d\n",
+			   __func__, ret);
+
+		set_host_lcb_access(dd);
+		write_csr(dd, DC_LCB_ERR_EN, ~0ull); /* watch LCB errors */
+
+		if (ret >= 0)
+			ret = -EINVAL;
+		return ret;
+	}
+
+	return 0; /* success */
+}
+
+/*
+ * Do all special steps to set up loopback.
+ */
+static int init_loopback(struct hfi2_devdata *dd)
+{
+	dd_dev_info(dd, "Entering loopback mode\n");
+
+	/* all loopbacks should disable self GUID check */
+	write_csr(dd, DC_DC8051_CFG_MODE,
+		  (read_csr(dd, DC_DC8051_CFG_MODE) | DISABLE_SELF_GUID_CHECK));
+
+	/*
+	 * The simulator has only one loopback option - LCB.  Switch
+	 * to that option, which includes quick link up.
+	 *
+	 * Accept all valid loopback values.
+	 */
+	if ((dd->icode == ICODE_FUNCTIONAL_SIMULATOR) &&
+	    (loopback == LOOPBACK_SERDES || loopback == LOOPBACK_LCB ||
+	     loopback == LOOPBACK_CABLE)) {
+		loopback = LOOPBACK_LCB;
+		quick_linkup = 1;
+		return 0;
+	}
+
+	/*
+	 * SerDes loopback init sequence is handled in set_local_link_attributes
+	 */
+	if (loopback == LOOPBACK_SERDES)
+		return 0;
+
+	/* LCB loopback - handled at poll time */
+	if (loopback == LOOPBACK_LCB) {
+		quick_linkup = 1; /* LCB is always quick linkup */
+		return 0;
+	}
+
+	/* external cable loopback requires no extra steps */
+	if (loopback == LOOPBACK_CABLE)
+		return 0;
+
+	dd_dev_err(dd, "Invalid loopback mode %d\n", loopback);
+	return -EINVAL;
+}
+
+/*
+ * Translate from the OPA_LINK_WIDTH handed to us by the FM to bits
+ * used in the Verify Capability link width attribute.
+ */
+static u16 opa_to_vc_link_widths(u16 opa_widths)
+{
+	int i;
+	u16 result = 0;
+
+	static const struct link_bits {
+		u16 from;
+		u16 to;
+	} opa_link_xlate[] = {
+		{ OPA_LINK_WIDTH_1X, 1 << (1 - 1)  },
+		{ OPA_LINK_WIDTH_2X, 1 << (2 - 1)  },
+		{ OPA_LINK_WIDTH_3X, 1 << (3 - 1)  },
+		{ OPA_LINK_WIDTH_4X, 1 << (4 - 1)  },
+	};
+
+	for (i = 0; i < ARRAY_SIZE(opa_link_xlate); i++) {
+		if (opa_widths & opa_link_xlate[i].from)
+			result |= opa_link_xlate[i].to;
+	}
+	return result;
+}
+
+/*
+ * Set link attributes before moving to polling.
+ */
+static int set_local_link_attributes(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u8 enable_lane_tx;
+	u8 tx_polarity_inversion;
+	u8 rx_polarity_inversion;
+	int ret;
+	u32 misc_bits = 0;
+	/* reset our fabric serdes to clear any lingering problems */
+	fabric_serdes_reset(dd);
+
+	/* set the local tx rate - need to read-modify-write */
+	ret = read_tx_settings(dd, &enable_lane_tx, &tx_polarity_inversion,
+			       &rx_polarity_inversion, &ppd->local_tx_rate);
+	if (ret)
+		goto set_local_link_attributes_fail;
+
+	if (dd->dc8051_ver < dc8051_ver(0, 20, 0)) {
+		/* set the tx rate to the fastest enabled */
+		if (ppd->link_speed_enabled & OPA_LINK_SPEED_25G)
+			ppd->local_tx_rate = 1;
+		else
+			ppd->local_tx_rate = 0;
+	} else {
+		/* set the tx rate to all enabled */
+		ppd->local_tx_rate = 0;
+		if (ppd->link_speed_enabled & OPA_LINK_SPEED_25G)
+			ppd->local_tx_rate |= 2;
+		if (ppd->link_speed_enabled & OPA_LINK_SPEED_12_5G)
+			ppd->local_tx_rate |= 1;
+	}
+
+	enable_lane_tx = 0xF; /* enable all four lanes */
+	ret = write_tx_settings(dd, enable_lane_tx, tx_polarity_inversion,
+				rx_polarity_inversion, ppd->local_tx_rate);
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	ret = write_host_interface_version(dd, HOST_INTERFACE_VERSION);
+	if (ret != HCMD_SUCCESS) {
+		ppd_dev_err(ppd,
+			    "Failed to set host interface version, return 0x%x\n",
+			    ret);
+		goto set_local_link_attributes_fail;
+	}
+
+	/*
+	 * DC supports continuous updates.
+	 */
+	ret = write_vc_local_phy(dd,
+				 0 /* no power management */,
+				 1 /* continuous updates */);
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	/* z=1 in the next call: AU of 0 is not supported by the hardware */
+	ret = write_vc_local_fabric(dd, dd->vau, 1, dd->vcu, dd->vl15_init,
+				    ppd->port_crc_mode_enabled);
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	/*
+	 * SerDes loopback init sequence requires
+	 * setting bit 0 of MISC_CONFIG_BITS
+	 */
+	if (loopback == LOOPBACK_SERDES)
+		misc_bits |= 1 << LOOPBACK_SERDES_CONFIG_BIT_MASK_SHIFT;
+
+	/*
+	 * An external device configuration request is used to reset the LCB
+	 * to retry to obtain operational lanes when the first attempt is
+	 * unsuccesful.
+	 */
+	if (dd->dc8051_ver >= dc8051_ver(1, 25, 0))
+		misc_bits |= 1 << EXT_CFG_LCB_RESET_SUPPORTED_SHIFT;
+
+	ret = write_vc_local_link_mode(dd, misc_bits, 0,
+				       opa_to_vc_link_widths(
+						ppd->link_width_enabled));
+	if (ret != HCMD_SUCCESS)
+		goto set_local_link_attributes_fail;
+
+	/* let peer know who we are */
+	ret = write_local_device_id(dd, dd->pcidev->device, dd->minrev);
+	if (ret == HCMD_SUCCESS)
+		return 0;
+
+set_local_link_attributes_fail:
+	ppd_dev_err(ppd,
+		    "Failed to set local link attributes, return 0x%x\n",
+		    ret);
+	return ret;
+}
+
+/*
+ * Call this to start the link.
+ * Do not do anything if the link is disabled.
+ * Returns 0 if link is disabled, moved to polling, or the driver is not ready.
+ */
+int start_link(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * Tune the SerDes to a ballpark setting for optimal signal and bit
+	 * error rate.  Needs to be done before starting the link.
+	 */
+	tune_serdes(ppd);
+
+	if (!ppd->driver_link_ready) {
+		ppd_dev_info(ppd,
+			     "%s: stopping link start because driver is not ready\n",
+			     __func__);
+		return 0;
+	}
+
+	/*
+	 * FULL_MGMT_P_KEY is cleared from the pkey table, so that the
+	 * pkey table can be configured properly if the HFI unit is connected
+	 * to switch port with MgmtAllowed=NO
+	 */
+	clear_full_mgmt_pkey(ppd);
+
+	return set_link_state(ppd, HLS_DN_POLL);
+}
+
+static void wait_for_qsfp_init(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 mask;
+	unsigned long timeout;
+
+	/*
+	 * Some QSFP cables have a quirk that asserts the IntN line as a side
+	 * effect of power up on plug-in. We ignore this false positive
+	 * interrupt until the module has finished powering up by waiting for
+	 * a minimum timeout of the module inrush initialization time of
+	 * 500 ms (SFF 8679 Table 5-6) to ensure the voltage rails in the
+	 * module have stabilized.
+	 */
+	msleep(500);
+
+	/*
+	 * Check for QSFP interrupt for t_init (SFF 8679 Table 8-1)
+	 */
+	timeout = jiffies + msecs_to_jiffies(2000);
+	while (1) {
+		mask = read_csr(dd, dd->hfi2_id ?
+				ASIC_QSFP2_IN : ASIC_QSFP1_IN);
+		if (!(mask & QSFP_HFI0_INT_N))
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_info(ppd, "%s: No IntN detected, reset complete\n",
+				     __func__);
+			break;
+		}
+		udelay(2);
+	}
+}
+
+static void set_qsfp_int_n(struct hfi2_pportdata *ppd, u8 enable)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 mask;
+
+	mask = read_csr(dd, dd->hfi2_id ? ASIC_QSFP2_MASK : ASIC_QSFP1_MASK);
+	if (enable) {
+		/*
+		 * Clear the status register to avoid an immediate interrupt
+		 * when we re-enable the IntN pin
+		 */
+		write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_CLEAR : ASIC_QSFP1_CLEAR,
+			  QSFP_HFI0_INT_N);
+		mask |= (u64)QSFP_HFI0_INT_N;
+	} else {
+		mask &= ~(u64)QSFP_HFI0_INT_N;
+	}
+	write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_MASK : ASIC_QSFP1_MASK, mask);
+}
+
+int reset_qsfp(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 mask, qsfp_mask;
+
+	/* Disable INT_N from triggering QSFP interrupts */
+	set_qsfp_int_n(ppd, 0);
+
+	/* Reset the QSFP */
+	mask = (u64)QSFP_HFI0_RESET_N;
+
+	qsfp_mask = read_csr(dd,
+			     dd->hfi2_id ? ASIC_QSFP2_OUT : ASIC_QSFP1_OUT);
+	qsfp_mask &= ~mask;
+	write_csr(dd,
+		  dd->hfi2_id ? ASIC_QSFP2_OUT : ASIC_QSFP1_OUT, qsfp_mask);
+
+	udelay(10);
+
+	qsfp_mask |= mask;
+	write_csr(dd,
+		  dd->hfi2_id ? ASIC_QSFP2_OUT : ASIC_QSFP1_OUT, qsfp_mask);
+
+	wait_for_qsfp_init(ppd);
+
+	/*
+	 * Allow INT_N to trigger the QSFP interrupt to watch
+	 * for alarms and warnings
+	 */
+	set_qsfp_int_n(ppd, 1);
+
+	/*
+	 * After the reset, AOC transmitters are enabled by default. They need
+	 * to be turned off to complete the QSFP setup before they can be
+	 * enabled again.
+	 */
+	return set_qsfp_tx(ppd, 0);
+}
+
+static int handle_qsfp_error_conditions(struct hfi2_pportdata *ppd,
+					u8 *qsfp_interrupt_status)
+{
+	if ((qsfp_interrupt_status[0] & QSFP_HIGH_TEMP_ALARM) ||
+	    (qsfp_interrupt_status[0] & QSFP_HIGH_TEMP_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP cable temperature too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[0] & QSFP_LOW_TEMP_ALARM) ||
+	    (qsfp_interrupt_status[0] & QSFP_LOW_TEMP_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP cable temperature too low\n",
+			    __func__);
+
+	/*
+	 * The remaining alarms/warnings don't matter if the link is down.
+	 */
+	if (ppd->host_link_state & HLS_DOWN)
+		return 0;
+
+	if ((qsfp_interrupt_status[1] & QSFP_HIGH_VCC_ALARM) ||
+	    (qsfp_interrupt_status[1] & QSFP_HIGH_VCC_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP supply voltage too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[1] & QSFP_LOW_VCC_ALARM) ||
+	    (qsfp_interrupt_status[1] & QSFP_LOW_VCC_WARNING))
+		ppd_dev_err(ppd, "%s: QSFP supply voltage too low\n",
+			    __func__);
+
+	/* Byte 2 is vendor specific */
+
+	if ((qsfp_interrupt_status[3] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[3] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 1/2 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[3] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[3] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 1/2 power too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[4] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[4] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 3/4 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[4] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[4] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable RX channel 3/4 power too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[5] & QSFP_HIGH_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[5] & QSFP_HIGH_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 bias too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[5] & QSFP_LOW_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[5] & QSFP_LOW_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 bias too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[6] & QSFP_HIGH_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[6] & QSFP_HIGH_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 bias too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[6] & QSFP_LOW_BIAS_ALARM) ||
+	    (qsfp_interrupt_status[6] & QSFP_LOW_BIAS_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 bias too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[7] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[7] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[7] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[7] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 1/2 power too low\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[8] & QSFP_HIGH_POWER_ALARM) ||
+	    (qsfp_interrupt_status[8] & QSFP_HIGH_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 power too high\n",
+			    __func__);
+
+	if ((qsfp_interrupt_status[8] & QSFP_LOW_POWER_ALARM) ||
+	    (qsfp_interrupt_status[8] & QSFP_LOW_POWER_WARNING))
+		ppd_dev_err(ppd, "%s: Cable TX channel 3/4 power too low\n",
+			    __func__);
+
+	/* Bytes 9-10 and 11-12 are reserved */
+	/* Bytes 13-15 are vendor specific */
+
+	return 0;
+}
+
+/* This routine will only be scheduled if the QSFP module present is asserted */
+void qsfp_event(struct work_struct *work)
+{
+	struct qsfp_data *qd;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_devdata *dd;
+
+	qd = container_of(work, struct qsfp_data, qsfp_work);
+	ppd = qd->ppd;
+	dd = ppd->dd;
+
+	/* Sanity check */
+	if (!qsfp_mod_present(ppd))
+		return;
+
+	if (ppd->host_link_state == HLS_DN_DISABLE) {
+		ppd_dev_info(ppd,
+			     "%s: stopping link start because link is disabled\n",
+			     __func__);
+		return;
+	}
+
+	/*
+	 * Turn DC back on after cable has been re-inserted. Up until
+	 * now, the DC has been in reset to save power.
+	 */
+	dc_start(dd);
+
+	if (qd->cache_refresh_required) {
+		set_qsfp_int_n(ppd, 0);
+
+		wait_for_qsfp_init(ppd);
+
+		/*
+		 * Allow INT_N to trigger the QSFP interrupt to watch
+		 * for alarms and warnings
+		 */
+		set_qsfp_int_n(ppd, 1);
+
+		start_link(ppd);
+	}
+
+	if (qd->check_interrupt_flags) {
+		u8 qsfp_interrupt_status[16] = {0,};
+
+		if (one_qsfp_read(ppd, dd->hfi2_id, 6,
+				  &qsfp_interrupt_status[0], 16) != 16) {
+			ppd_dev_info(ppd,
+				     "%s: Failed to read status of QSFP module\n",
+				     __func__);
+		} else {
+			unsigned long flags;
+
+			handle_qsfp_error_conditions(
+					ppd, qsfp_interrupt_status);
+			spin_lock_irqsave(&ppd->qsfp_info.qsfp_lock, flags);
+			ppd->qsfp_info.check_interrupt_flags = 0;
+			spin_unlock_irqrestore(&ppd->qsfp_info.qsfp_lock,
+					       flags);
+		}
+	}
+}
+
+void init_qsfp_int(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 qsfp_mask;
+
+	qsfp_mask = (u64)(QSFP_HFI0_INT_N | QSFP_HFI0_MODPRST_N);
+	/* Clear current status to avoid spurious interrupts */
+	write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_CLEAR : ASIC_QSFP1_CLEAR,
+		  qsfp_mask);
+	write_csr(dd, dd->hfi2_id ? ASIC_QSFP2_MASK : ASIC_QSFP1_MASK,
+		  qsfp_mask);
+
+	set_qsfp_int_n(ppd, 0);
+
+	/* Handle active low nature of INT_N and MODPRST_N pins */
+	if (qsfp_mod_present(ppd))
+		qsfp_mask &= ~(u64)QSFP_HFI0_MODPRST_N;
+	write_csr(dd,
+		  dd->hfi2_id ? ASIC_QSFP2_INVERT : ASIC_QSFP1_INVERT,
+		  qsfp_mask);
+
+	/* Enable the appropriate QSFP IRQ source */
+	if (!dd->hfi2_id)
+		set_intr_bits(dd, QSFP1_INT, QSFP1_INT, true);
+	else
+		set_intr_bits(dd, QSFP2_INT, QSFP2_INT, true);
+}
+
+/*
+ * Do a one-time initialize of the LCB block.
+ */
+static void init_lcb(struct hfi2_devdata *dd)
+{
+	/* the DC has been reset earlier in the driver load */
+
+	/* set LCB for cclk loopback on the port */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0x01);
+	write_csr(dd, DC_LCB_CFG_LANE_WIDTH, 0x00);
+	write_csr(dd, DC_LCB_CFG_REINIT_AS_SLAVE, 0x00);
+	write_csr(dd, DC_LCB_CFG_CNT_FOR_SKIP_STALL, 0x110);
+	write_csr(dd, DC_LCB_CFG_CLK_CNTR, 0x08);
+	write_csr(dd, DC_LCB_CFG_LOOPBACK, 0x02);
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0x00);
+}
+
+/*
+ * Perform a test read on the QSFP.  Return 0 on success, -ERRNO
+ * on error.
+ */
+static int test_qsfp_read(struct hfi2_pportdata *ppd)
+{
+	int ret;
+	u8 status;
+
+	/*
+	 * Report success if not a QSFP or, if it is a QSFP, but the cable is
+	 * not present
+	 */
+	if (ppd->port_type != PORT_TYPE_QSFP || !qsfp_mod_present(ppd))
+		return 0;
+
+	/* read byte 2, the status byte */
+	ret = one_qsfp_read(ppd, ppd->dd->hfi2_id, 2, &status, 1);
+	if (ret < 0)
+		return ret;
+	if (ret != 1)
+		return -EIO;
+
+	return 0; /* success */
+}
+
+/*
+ * Values for QSFP retry.
+ *
+ * Give up after 10s (20 x 500ms).  The overall timeout was empirically
+ * arrived at from experience on a large cluster.
+ */
+#define MAX_QSFP_RETRIES 20
+#define QSFP_RETRY_WAIT 500 /* msec */
+
+/*
+ * Try a QSFP read.  If it fails, schedule a retry for later.
+ * Called on first link activation after driver load.
+ */
+static void try_start_link(struct hfi2_pportdata *ppd)
+{
+	if (test_qsfp_read(ppd)) {
+		/* read failed */
+		if (ppd->qsfp_retry_count >= MAX_QSFP_RETRIES) {
+			ppd_dev_err(ppd, "QSFP not responding, giving up\n");
+			return;
+		}
+		ppd_dev_info(ppd,
+			     "QSFP not responding, waiting and retrying %d\n",
+			     (int)ppd->qsfp_retry_count);
+		ppd->qsfp_retry_count++;
+		queue_delayed_work(ppd->link_wq, &ppd->start_link_work,
+				   msecs_to_jiffies(QSFP_RETRY_WAIT));
+		return;
+	}
+	ppd->qsfp_retry_count = 0;
+
+	start_link(ppd);
+}
+
+/*
+ * Workqueue function to start the link after a delay.
+ */
+void handle_start_link(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+						  start_link_work.work);
+	try_start_link(ppd);
+}
+
+int bringup_serdes(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 guid;
+	int ret;
+
+	if (HFI2_CAP_IS_KSET(EXTENDED_PSN))
+		add_rcvctrl(ppd, RCV_CTRL_RCV_EXTENDED_PSN_ENABLE_SMASK);
+
+	guid = ppd->guids[HFI2_PORT_GUID_INDEX];
+	if (!guid) {
+		/* OPA spec says bits 34:32 are port number, 1-7 */
+		if (dd->base_guid)
+			guid = (dd->base_guid & ~(7ULL << 32)) | ((u64)ppd->port << 32);
+		ppd->guids[HFI2_PORT_GUID_INDEX] = guid;
+	}
+
+	/* Set linkinit_reason on power up per OPA spec */
+	ppd->linkinit_reason = OPA_LINKINIT_REASON_LINKUP;
+
+	/* one-time init of the LCB */
+	init_lcb(dd);
+
+	if (loopback) {
+		ret = init_loopback(dd);
+		if (ret < 0)
+			return ret;
+	}
+
+	get_port_type(ppd);
+	if (ppd->port_type == PORT_TYPE_QSFP) {
+		set_qsfp_int_n(ppd, 0);
+		wait_for_qsfp_init(ppd);
+		set_qsfp_int_n(ppd, 1);
+	}
+
+	try_start_link(ppd);
+	return 0;
+}
+
+void hfi2_quiet_serdes(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * Shut down the link and keep it down.   First turn off that the
+	 * driver wants to allow the link to be up (driver_link_ready).
+	 * Then make sure the link is not automatically restarted
+	 * (link_enabled).  Cancel any pending restart.  And finally
+	 * go offline.
+	 */
+	ppd->driver_link_ready = 0;
+	ppd->link_enabled = 0;
+
+	ppd->qsfp_retry_count = MAX_QSFP_RETRIES; /* prevent more retries */
+	flush_delayed_work(&ppd->start_link_work);
+	cancel_delayed_work_sync(&ppd->start_link_work);
+
+	ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_REBOOT);
+	set_link_down_reason(ppd, OPA_LINKDOWN_REASON_REBOOT, 0,
+			     OPA_LINKDOWN_REASON_REBOOT);
+	set_link_state(ppd, HLS_DN_OFFLINE);
+
+	/* disable the port */
+	clear_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+	flush_work(&ppd->dd->freeze_work);
+}
+
+static inline int init_cpu_counters(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int i;
+
+	ppd = (struct hfi2_pportdata *)(dd + 1);
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		ppd->ibport_data.rvp.rc_acks = NULL;
+		ppd->ibport_data.rvp.rc_qacks = NULL;
+		ppd->ibport_data.rvp.rc_acks = alloc_percpu(u64);
+		ppd->ibport_data.rvp.rc_qacks = alloc_percpu(u64);
+		ppd->ibport_data.rvp.rc_delayed_comp = alloc_percpu(u64);
+		if (!ppd->ibport_data.rvp.rc_acks ||
+		    !ppd->ibport_data.rvp.rc_delayed_comp ||
+		    !ppd->ibport_data.rvp.rc_qacks)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/* WFR does not have a port tid count */
+void wfr_set_port_tid_count(struct hfi2_ctxtdata *rcd)
+{
+}
+
+/*
+ * Update a TID entry of a given receive context.
+ *
+ * @rcd	  Receive context being updated.
+ * @index When type is PT_EAGER or PT_EXPECTED, index is the index into the
+ *	  receive array _relative_ to how the context is set up.  Otherwise
+ *	  it is a raw index.
+ * @pa	  Physical DMA address.  If invalidating, this should be zero.
+ * @order Order of map.  If invalidating, this should be zero.
+ * @flush Forced flush.  Otherwise, will flush on eager or on 32-byte boundary.
+ */
+void wfr_put_tid(struct hfi2_ctxtdata *rcd, u32 index,
+		 u32 type, unsigned long pa, u16 order, bool flush)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u64 reg;
+
+	if (!(dd->flags & HFI2_PRESENT))
+		return;
+
+	if (type == PT_EAGER)
+		index += rcd->eager_base;
+	else if (type == PT_EXPECTED)
+		index += rcd->expected_base;
+	trace_hfi2_put_tid(dd, index, type, pa, order);
+
+#define RT_ADDR_SHIFT 12	/* 4KB kernel address boundary */
+	reg = RCV_ARRAY_RT_WRITE_ENABLE_SMASK
+		| (u64)order << RCV_ARRAY_RT_BUF_SIZE_SHIFT
+		| ((pa >> RT_ADDR_SHIFT) & RCV_ARRAY_RT_ADDR_MASK)
+					<< RCV_ARRAY_RT_ADDR_SHIFT;
+	trace_hfi2_write_rcvarray(dd->rcvarray_wc + (index * 8), reg);
+	writeq(reg, dd->rcvarray_wc + (index * 8));
+
+	if (type == PT_EAGER || flush || (index & 3) == 3)
+		flush_wc();
+}
+
+/*
+ * Write an "no-op" RcvArray entry.
+ *
+ * Called by the TID registration code to write to unused/unneeded RcvArray
+ * entries to fill out a write-combining buffer line.  The HFI will ignore this
+ * write to the RcvArray entry.
+ */
+void wfr_rcv_array_wc_fill(struct hfi2_ctxtdata *rcd, u32 index, u32 type)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+
+	/*
+	 * Doing the WC fill writes only makes sense if the device is
+	 * present and the RcvArray has been mapped as WC memory.
+	 */
+	if ((dd->flags & HFI2_PRESENT) && dd->rcvarray_wc) {
+		if (type == PT_EAGER)
+			index += rcd->eager_base;
+		else if (type == PT_EXPECTED)
+			index += rcd->expected_base;
+
+		writeq(0, dd->rcvarray_wc + (index * 8));
+		if ((index & 3) == 3)
+			flush_wc();
+	}
+}
+
+void wfr_init_tids(struct hfi2_devdata *dd)
+{
+	const u64 reg = RCV_ARRAY_RT_WRITE_ENABLE_SMASK;
+	u32 num_rcv;
+	u32 i;
+
+	num_rcv = chip_rcv_array_count(dd);
+	for (i = 0; i < num_rcv; i++) {
+		writeq(reg, dd->rcvarray_wc + (i * 8));
+		if ((i & 3) == 3)
+			flush_wc();
+	}
+}
+
+void hfi2_clear_tids(struct hfi2_ctxtdata *rcd)
+{
+	u32 i;
+
+	for (i = 0; i < rcd->egrbufs.alloced; i++)
+		rcd->dd->params->put_tid(rcd, i, PT_EAGER, 0, 0, false);
+
+	for (i = 0; i < rcd->expected_count; i++)
+		rcd->dd->params->put_tid(rcd, i, PT_EXPECTED, 0, 0, false);
+}
+
+static const char * const ib_cfg_name_strings[] = {
+	"HFI2_IB_CFG_LIDLMC",
+	"HFI2_IB_CFG_LWID_DG_ENB",
+	"HFI2_IB_CFG_LWID_ENB",
+	"HFI2_IB_CFG_LWID",
+	"HFI2_IB_CFG_SPD_ENB",
+	"HFI2_IB_CFG_SPD",
+	"HFI2_IB_CFG_RXPOL_ENB",
+	"HFI2_IB_CFG_LREV_ENB",
+	"HFI2_IB_CFG_LINKLATENCY",
+	"HFI2_IB_CFG_HRTBT",
+	"HFI2_IB_CFG_OP_VLS",
+	"HFI2_IB_CFG_VL_HIGH_CAP",
+	"HFI2_IB_CFG_VL_LOW_CAP",
+	"HFI2_IB_CFG_OVERRUN_THRESH",
+	"HFI2_IB_CFG_PHYERR_THRESH",
+	"HFI2_IB_CFG_LINKDEFAULT",
+	"HFI2_IB_CFG_PKEYS",
+	"HFI2_IB_CFG_MTU",
+	"HFI2_IB_CFG_LSTATE",
+	"HFI2_IB_CFG_VL_HIGH_LIMIT",
+	"HFI2_IB_CFG_PMA_TICKS",
+	"HFI2_IB_CFG_PORT"
+};
+
+static const char *ib_cfg_name(int which)
+{
+	if (which < 0 || which >= ARRAY_SIZE(ib_cfg_name_strings))
+		return "invalid";
+	return ib_cfg_name_strings[which];
+}
+
+int hfi2_get_ib_cfg(struct hfi2_pportdata *ppd, int which)
+{
+	int val = 0;
+
+	switch (which) {
+	case HFI2_IB_CFG_LWID_ENB: /* allowed Link-width */
+		val = ppd->link_width_enabled;
+		break;
+	case HFI2_IB_CFG_LWID: /* currently active Link-width */
+		val = ppd->link_width_active;
+		break;
+	case HFI2_IB_CFG_SPD_ENB: /* allowed Link speeds */
+		val = ppd->link_speed_enabled;
+		break;
+	case HFI2_IB_CFG_SPD: /* current Link speed */
+		val = ppd->link_speed_active;
+		break;
+
+	case HFI2_IB_CFG_RXPOL_ENB: /* Auto-RX-polarity enable */
+	case HFI2_IB_CFG_LREV_ENB: /* Auto-Lane-reversal enable */
+	case HFI2_IB_CFG_LINKLATENCY:
+		goto unimplemented;
+
+	case HFI2_IB_CFG_OP_VLS:
+		val = ppd->actual_vls_operational;
+		break;
+	case HFI2_IB_CFG_VL_HIGH_CAP: /* VL arb high priority table size */
+		val = VL_ARB_HIGH_PRIO_TABLE_SIZE;
+		break;
+	case HFI2_IB_CFG_VL_LOW_CAP: /* VL arb low priority table size */
+		val = VL_ARB_LOW_PRIO_TABLE_SIZE;
+		break;
+	case HFI2_IB_CFG_OVERRUN_THRESH: /* IB overrun threshold */
+		val = ppd->overrun_threshold;
+		break;
+	case HFI2_IB_CFG_PHYERR_THRESH: /* IB PHY error threshold */
+		val = ppd->phy_error_threshold;
+		break;
+	case HFI2_IB_CFG_LINKDEFAULT: /* IB link default (sleep/poll) */
+		val = HLS_DEFAULT;
+		break;
+
+	case HFI2_IB_CFG_HRTBT: /* Heartbeat off/enable/auto */
+	case HFI2_IB_CFG_PMA_TICKS:
+	default:
+unimplemented:
+		if (HFI2_CAP_IS_KSET(PRINT_UNIMPL))
+			ppd_dev_info(ppd,
+				     "%s: which %s: not implemented\n",
+				     __func__,
+				     ib_cfg_name(which));
+		break;
+	}
+
+	return val;
+}
+
+/*
+ * The largest MAD packet size.
+ */
+#define MAX_MAD_PACKET 2048
+
+/*
+ * Return the maximum header bytes that can go on the _wire_
+ * for this device. This count includes the ICRC which is
+ * not part of the packet held in memory but it is appended
+ * by the HW.
+ * This is dependent on the device's receive header entry size.
+ * HFI allows this to be set per-receive context, but the
+ * driver presently enforces a global value.
+ */
+u32 lrh_max_header_bytes(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * The maximum non-payload (MTU) bytes in LRH.PktLen are
+	 * the Receive Header Entry Size minus the PBC (or RHF) size
+	 * plus one DW for the ICRC appended by HW.
+	 *
+	 * hdrqentsize is in DW.
+	 *
+	 * Use this port's kernel contexts' receive header entry size.
+	 */
+	return (kctxt_hdrqentsize(ppd) - 2/*PBC/RHF*/ + 1/*ICRC*/) << 2;
+}
+
+/* set what to accept in the port hardware */
+static void set_dlid_lmc(struct hfi2_pportdata *ppd, u32 mask, u32 lid)
+{
+	u64 c1 = read_csr(ppd->dd, DCC_CFG_PORT_CONFIG1);
+
+	c1 &= ~(DCC_CFG_PORT_CONFIG1_TARGET_DLID_SMASK
+		| DCC_CFG_PORT_CONFIG1_DLID_MASK_SMASK);
+	c1 |= ((lid & DCC_CFG_PORT_CONFIG1_TARGET_DLID_MASK)
+			<< DCC_CFG_PORT_CONFIG1_TARGET_DLID_SHIFT) |
+	      ((mask & DCC_CFG_PORT_CONFIG1_DLID_MASK_MASK)
+			<< DCC_CFG_PORT_CONFIG1_DLID_MASK_SHIFT);
+	write_csr(ppd->dd, DCC_CFG_PORT_CONFIG1, c1);
+}
+
+/* set maximum MTU for the port */
+void wfr_set_port_max_mtu(struct hfi2_pportdata *ppd, u32 maxvlmtu)
+{
+	u64 config;
+	u32 dcmtu;
+
+	/* Adjust maximum MTU for the port in DC */
+	dcmtu = maxvlmtu == 10240 ? DCC_CFG_PORT_MTU_CAP_10240 :
+		(ilog2(maxvlmtu >> 8) + 1);
+	config = read_csr(ppd->dd, DCC_CFG_PORT_CONFIG);
+	config &= ~DCC_CFG_PORT_CONFIG_MTU_CAP_SMASK;
+	config |= ((u64)dcmtu & DCC_CFG_PORT_CONFIG_MTU_CAP_MASK) <<
+		  DCC_CFG_PORT_CONFIG_MTU_CAP_SHIFT;
+	write_csr(ppd->dd, DCC_CFG_PORT_CONFIG, config);
+}
+
+/*
+ * Set Send Length
+ * @ppd: per port data
+ *
+ * Set the MTU by limiting how many DWs may be sent.  The SendLenCheck*
+ * registers compare against LRH.PktLen, so use the max bytes included
+ * in the LRH.
+ *
+ * This routine changes all VL values except VL15, which it maintains at
+ * the same value.
+ */
+static void set_send_length(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 maxvlmtu = ppd->vld[15].mtu;
+	int i, j;
+	u32 thres;
+
+	/* per-vl send contexts are not present if port is not available */
+	if (!port_available_ppd(ppd))
+		return;
+
+	for (i = 0; i < ppd->vls_supported; i++) {
+		if (ppd->vld[i].mtu > maxvlmtu)
+			maxvlmtu = ppd->vld[i].mtu;
+	}
+
+	/* only WFR needs to write SendLenCheckn */
+	if (dd->params->chip_type == CHIP_WFR) {
+		u32 max_hb = lrh_max_header_bytes(ppd);
+		u64 len1 = 0;
+		u64 len2 = (((ppd->vld[15].mtu + max_hb) >> 2)
+				      & SEND_LEN_CHECK1_LEN_VL15_MASK) <<
+			   SEND_LEN_CHECK1_LEN_VL15_SHIFT;
+
+		for (i = 0; i < ppd->vls_supported; i++) {
+			if (i <= 3)
+				len1 |= (((ppd->vld[i].mtu + max_hb) >> 2)
+					 & SEND_LEN_CHECK0_LEN_VL0_MASK) <<
+					((i % 4) * SEND_LEN_CHECK0_LEN_VL1_SHIFT);
+			else
+				len2 |= (((ppd->vld[i].mtu + max_hb) >> 2)
+					 & SEND_LEN_CHECK1_LEN_VL4_MASK) <<
+					((i % 4) * SEND_LEN_CHECK1_LEN_VL5_SHIFT);
+		}
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_len_check0_reg, len1);
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_len_check1_reg, len2);
+	}
+	/* adjust kernel credit return thresholds based on new MTUs */
+	/* all kernel receive contexts have the same hdrqentsize */
+	for (i = 0; i < ppd->vls_supported; i++) {
+		thres = min(sc_percent_to_threshold(ppd->vld[i].sc, 50),
+			    sc_mtu_to_threshold(ppd->vld[i].sc,
+						ppd->vld[i].mtu,
+						kctxt_hdrqentsize(ppd)));
+		for (j = 0; j < INIT_SC_PER_VL; j++)
+			sc_set_cr_threshold(
+					pio_select_send_context_vl(ppd, j, i),
+					    thres);
+	}
+	thres = min(sc_percent_to_threshold(ppd->vld[15].sc, 50),
+		    sc_mtu_to_threshold(ppd->vld[15].sc,
+					ppd->vld[15].mtu,
+					kctxt_hdrqentsize(ppd)));
+	sc_set_cr_threshold(ppd->vld[15].sc, thres);
+
+	dd->params->set_port_max_mtu(ppd, maxvlmtu);
+}
+
+static void set_lidlmc(struct hfi2_pportdata *ppd)
+{
+	int i;
+	u64 sreg = 0;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 mask = ~((1U << ppd->lmc) - 1);
+	u32 lid;
+
+	/*
+	 * Program 0 in CSR if port lid is extended. This prevents
+	 * 9B packets being sent out for large lids.
+	 */
+	lid = (ppd->lid >= be16_to_cpu(IB_MULTICAST_LID_BASE)) ? 0 : ppd->lid;
+	if (dd->hfi2_snoop.mode_flag)
+		ppd_dev_info(ppd, "Set lid/lmc while snooping");
+
+	/* set port hardware */
+	set_dlid_lmc(ppd, mask, lid);
+
+	/*
+	 * Iterate over all the send contexts for this port and set their SLID
+	 * check.
+	 */
+	if (dd->params->chip_type == CHIP_WFR) {
+		sreg = ((mask & SEND_CTXT_CHECK_SLID_MASK_MASK) <<
+				SEND_CTXT_CHECK_SLID_MASK_SHIFT) |
+		       (((lid & mask) & SEND_CTXT_CHECK_SLID_VALUE_MASK) <<
+				SEND_CTXT_CHECK_SLID_VALUE_SHIFT);
+	} else {
+		sreg = ((u64)(mask & 0xffffff) << 32) | (lid & 0xffffff) |
+			BIT_ULL(63); /* PermissiveSlidAllowed */
+	}
+
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		struct send_context *sc = dd->send_contexts[i].sc;
+
+		if (!sc)
+			continue;
+		if (sc->ppd != ppd)
+			continue;
+
+		hfi2_cdbg(LINKVERB, "SendContext[%d].SLID_CHECK = 0x%x",
+			  i, (u32)sreg);
+		write_epsc_csr(dd, ppd->hw_pidx, sc->hw_context,
+			       dd->params->send_ctxt_check_slid_reg, sreg);
+	}
+
+	/* Now we have to do the same thing for the sdma engines */
+	sdma_update_lmc(dd, mask, lid);
+}
+
+static const char *state_completed_string(u32 completed)
+{
+	static const char * const state_completed[] = {
+		"EstablishComm",
+		"OptimizeEQ",
+		"VerifyCap"
+	};
+
+	if (completed < ARRAY_SIZE(state_completed))
+		return state_completed[completed];
+
+	return "unknown";
+}
+
+static const char all_lanes_dead_timeout_expired[] =
+	"All lanes were inactive – was the interconnect media removed?";
+static const char tx_out_of_policy[] =
+	"Passing lanes on local port do not meet the local link width policy";
+static const char no_state_complete[] =
+	"State timeout occurred before link partner completed the state";
+static const char * const state_complete_reasons[] = {
+	[0x00] = "Reason unknown",
+	[0x01] = "Link was halted by driver, refer to LinkDownReason",
+	[0x02] = "Link partner reported failure",
+	[0x10] = "Unable to achieve frame sync on any lane",
+	[0x11] =
+	  "Unable to find a common bit rate with the link partner",
+	[0x12] =
+	  "Unable to achieve frame sync on sufficient lanes to meet the local link width policy",
+	[0x13] =
+	  "Unable to identify preset equalization on sufficient lanes to meet the local link width policy",
+	[0x14] = no_state_complete,
+	[0x15] =
+	  "State timeout occurred before link partner identified equalization presets",
+	[0x16] =
+	  "Link partner completed the EstablishComm state, but the passing lanes do not meet the local link width policy",
+	[0x17] = tx_out_of_policy,
+	[0x20] = all_lanes_dead_timeout_expired,
+	[0x21] =
+	  "Unable to achieve acceptable BER on sufficient lanes to meet the local link width policy",
+	[0x22] = no_state_complete,
+	[0x23] =
+	  "Link partner completed the OptimizeEq state, but the passing lanes do not meet the local link width policy",
+	[0x24] = tx_out_of_policy,
+	[0x30] = all_lanes_dead_timeout_expired,
+	[0x31] =
+	  "State timeout occurred waiting for host to process received frames",
+	[0x32] = no_state_complete,
+	[0x33] =
+	  "Link partner completed the VerifyCap state, but the passing lanes do not meet the local link width policy",
+	[0x34] = tx_out_of_policy,
+	[0x35] = "Negotiated link width is mutually exclusive",
+	[0x36] =
+	  "Timed out before receiving verifycap frames in VerifyCap.Exchange",
+	[0x37] = "Unable to resolve secure data exchange",
+};
+
+static const char *state_complete_reason_code_string(struct hfi2_pportdata *ppd,
+						     u32 code)
+{
+	const char *str = NULL;
+
+	if (code < ARRAY_SIZE(state_complete_reasons))
+		str = state_complete_reasons[code];
+
+	if (str)
+		return str;
+	return "Reserved";
+}
+
+/* describe the given last state complete frame */
+static void decode_state_complete(struct hfi2_pportdata *ppd, u32 frame,
+				  const char *prefix)
+{
+	u32 success;
+	u32 state;
+	u32 reason;
+	u32 lanes;
+
+	/*
+	 * Decode frame:
+	 *  [ 0: 0] - success
+	 *  [ 3: 1] - state
+	 *  [ 7: 4] - next state timeout
+	 *  [15: 8] - reason code
+	 *  [31:16] - lanes
+	 */
+	success = frame & 0x1;
+	state = (frame >> 1) & 0x7;
+	reason = (frame >> 8) & 0xff;
+	lanes = (frame >> 16) & 0xffff;
+
+	ppd_dev_err(ppd, "Last %s LNI state complete frame 0x%08x:\n",
+		    prefix, frame);
+	ppd_dev_err(ppd, "    last reported state state: %s (0x%x)\n",
+		    state_completed_string(state), state);
+	ppd_dev_err(ppd, "    state successfully completed: %s\n",
+		    success ? "yes" : "no");
+	ppd_dev_err(ppd, "    fail reason 0x%x: %s\n",
+		    reason, state_complete_reason_code_string(ppd, reason));
+	ppd_dev_err(ppd, "    passing lane mask: 0x%x", lanes);
+}
+
+/*
+ * Read the last state complete frames and explain them.  This routine
+ * expects to be called if the link went down during link negotiation
+ * and initialization (LNI).  That is, anywhere between polling and link up.
+ */
+static void check_lni_states(struct hfi2_pportdata *ppd)
+{
+	u32 last_local_state;
+	u32 last_remote_state;
+
+	read_last_local_state(ppd->dd, &last_local_state);
+	read_last_remote_state(ppd->dd, &last_remote_state);
+
+	/*
+	 * Don't report anything if there is nothing to report.  A value of
+	 * 0 means the link was taken down while polling and there was no
+	 * training in-process.
+	 */
+	if (last_local_state == 0 && last_remote_state == 0)
+		return;
+
+	decode_state_complete(ppd, last_local_state, "transmitted");
+	decode_state_complete(ppd, last_remote_state, "received");
+}
+
+/* wait for wait_ms for LINK_TRANSFER_ACTIVE to go to 1 */
+static int wait_link_transfer_active(struct hfi2_devdata *dd, int wait_ms)
+{
+	u64 reg;
+	unsigned long timeout;
+
+	/* watch LCB_STS_LINK_TRANSFER_ACTIVE */
+	timeout = jiffies + msecs_to_jiffies(wait_ms);
+	while (1) {
+		reg = read_csr(dd, DC_LCB_STS_LINK_TRANSFER_ACTIVE);
+		if (reg)
+			break;
+		if (time_after(jiffies, timeout)) {
+			dd_dev_err(dd,
+				   "timeout waiting for LINK_TRANSFER_ACTIVE\n");
+			return -ETIMEDOUT;
+		}
+		udelay(2);
+	}
+	return 0;
+}
+
+/* called when the logical link state is not down as it should be */
+static void force_logical_link_state_down(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/*
+	 * Bring link up in LCB loopback
+	 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 1);
+	write_csr(dd, DC_LCB_CFG_IGNORE_LOST_RCLK,
+		  DC_LCB_CFG_IGNORE_LOST_RCLK_EN_SMASK);
+
+	write_csr(dd, DC_LCB_CFG_LANE_WIDTH, 0);
+	write_csr(dd, DC_LCB_CFG_REINIT_AS_SLAVE, 0);
+	write_csr(dd, DC_LCB_CFG_CNT_FOR_SKIP_STALL, 0x110);
+	write_csr(dd, DC_LCB_CFG_LOOPBACK, 0x2);
+
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 0);
+	(void)read_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET);
+	udelay(3);
+	write_csr(dd, DC_LCB_CFG_ALLOW_LINK_UP, 1);
+	write_csr(dd, DC_LCB_CFG_RUN, 1ull << DC_LCB_CFG_RUN_EN_SHIFT);
+
+	wait_link_transfer_active(dd, 100);
+
+	/*
+	 * Bring the link down again.
+	 */
+	write_csr(dd, DC_LCB_CFG_TX_FIFOS_RESET, 1);
+	write_csr(dd, DC_LCB_CFG_ALLOW_LINK_UP, 0);
+	write_csr(dd, DC_LCB_CFG_IGNORE_LOST_RCLK, 0);
+
+	ppd_dev_info(ppd, "logical state forced to LINK_DOWN\n");
+}
+
+/*
+ * Helper for set_link_state().  Do not call except from that routine.
+ * Expects ppd->hls_mutex to be held.
+ *
+ * @rem_reason value to be sent to the neighbor
+ *
+ * LinkDownReasons only set if transition succeeds.
+ */
+static int goto_offline(struct hfi2_pportdata *ppd, u8 rem_reason)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 previous_state;
+	int offline_state_ret;
+	int ret;
+
+	update_lcb_cache(ppd);
+
+	previous_state = ppd->host_link_state;
+	ppd->host_link_state = HLS_GOING_OFFLINE;
+
+	/* start offline transition */
+	ret = set_physical_link_state(dd, (rem_reason << 8) | PLS_OFFLINE);
+
+	if (ret != HCMD_SUCCESS) {
+		ppd_dev_err(ppd,
+			    "Failed to transition to Offline link state, return %d\n",
+			    ret);
+		return -EINVAL;
+	}
+	if (ppd->offline_disabled_reason ==
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE))
+		ppd->offline_disabled_reason =
+		HFI2_ODR_MASK(OPA_LINKDOWN_REASON_TRANSIENT);
+
+	offline_state_ret = wait_phys_link_offline_substates(ppd, 10000);
+	if (offline_state_ret < 0)
+		return offline_state_ret;
+
+	/* Disabling AOC transmitters */
+	if (ppd->port_type == PORT_TYPE_QSFP &&
+	    ppd->qsfp_info.limiting_active &&
+	    qsfp_mod_present(ppd)) {
+		int ret;
+
+		ret = acquire_chip_resource(dd, qsfp_resource(dd), QSFP_WAIT);
+		if (ret == 0) {
+			set_qsfp_tx(ppd, 0);
+			release_chip_resource(dd, qsfp_resource(dd));
+		} else {
+			/* not fatal, but should warn */
+			ppd_dev_err(ppd,
+				    "Unable to acquire lock to turn off QSFP TX\n");
+		}
+	}
+
+	/*
+	 * Wait for the offline.Quiet transition if it hasn't happened yet. It
+	 * can take a while for the link to go down.
+	 */
+	if (offline_state_ret != PLS_OFFLINE_QUIET) {
+		ret = wait_physical_linkstate(ppd, PLS_OFFLINE, 30000);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * Now in charge of LCB - must be after the physical state is
+	 * offline.quiet and before host_link_state is changed.
+	 */
+	set_host_lcb_access(dd);
+	write_csr(dd, DC_LCB_ERR_EN, ~0ull); /* watch LCB errors */
+
+	/* make sure the logical state is also down */
+	ret = wait_logical_linkstate(ppd, IB_PORT_DOWN, 1000);
+	if (ret)
+		force_logical_link_state_down(ppd);
+
+	ppd->host_link_state = HLS_LINK_COOLDOWN; /* LCB access allowed */
+	update_statusp(ppd, IB_PORT_DOWN);
+
+	/*
+	 * The LNI has a mandatory wait time after the physical state
+	 * moves to Offline.Quiet.  The wait time may be different
+	 * depending on how the link went down.  The 8051 firmware
+	 * will observe the needed wait time and only move to ready
+	 * when that is completed.  The largest of the quiet timeouts
+	 * is 6s, so wait that long and then at least 0.5s more for
+	 * other transitions, and another 0.5s for a buffer.
+	 */
+	ret = wait_fm_ready(dd, 7000);
+	if (ret) {
+		ppd_dev_err(ppd,
+			    "After going offline, timed out waiting for the 8051 to become ready to accept host requests\n");
+		/* state is really offline, so make it so */
+		ppd->host_link_state = HLS_DN_OFFLINE;
+		return ret;
+	}
+
+	/*
+	 * The state is now offline and the 8051 is ready to accept host
+	 * requests.
+	 *	- change our state
+	 *	- notify others if we were previously in a linkup state
+	 */
+	ppd->host_link_state = HLS_DN_OFFLINE;
+	if (previous_state & HLS_UP) {
+		/* went down while link was up */
+		handle_linkup_change(ppd, 0);
+	} else if (previous_state
+			& (HLS_DN_POLL | HLS_VERIFY_CAP | HLS_GOING_UP)) {
+		/* went down while attempting link up */
+		check_lni_states(ppd);
+
+		/* The QSFP doesn't need to be reset on LNI failure */
+		ppd->qsfp_info.reset_needed = 0;
+	}
+
+	/* the active link width (downgrade) is 0 on link down */
+	ppd->link_width_active = 0;
+	ppd->link_width_downgrade_tx_active = 0;
+	ppd->link_width_downgrade_rx_active = 0;
+	ppd->current_egress_rate = 0;
+	return 0;
+}
+
+/* return the link state name */
+const char *link_state_name(u32 state)
+{
+	const char *name;
+	int n = ilog2(state);
+	static const char * const names[] = {
+		[__HLS_UP_INIT_BP]	 = "INIT",
+		[__HLS_UP_ARMED_BP]	 = "ARMED",
+		[__HLS_UP_ACTIVE_BP]	 = "ACTIVE",
+		[__HLS_DN_DOWNDEF_BP]	 = "DOWNDEF",
+		[__HLS_DN_POLL_BP]	 = "POLL",
+		[__HLS_DN_DISABLE_BP]	 = "DISABLE",
+		[__HLS_DN_OFFLINE_BP]	 = "OFFLINE",
+		[__HLS_VERIFY_CAP_BP]	 = "VERIFY_CAP",
+		[__HLS_GOING_UP_BP]	 = "GOING_UP",
+		[__HLS_GOING_OFFLINE_BP] = "GOING_OFFLINE",
+		[__HLS_LINK_COOLDOWN_BP] = "LINK_COOLDOWN"
+	};
+
+	name = n < ARRAY_SIZE(names) ? names[n] : NULL;
+	return name ? name : "unknown";
+}
+
+/* return the link state reason name */
+const char *link_state_reason_name(struct hfi2_pportdata *ppd, u32 state)
+{
+	if (state == HLS_UP_INIT) {
+		switch (ppd->linkinit_reason) {
+		case OPA_LINKINIT_REASON_LINKUP:
+			return "(LINKUP)";
+		case OPA_LINKINIT_REASON_FLAPPING:
+			return "(FLAPPING)";
+		case OPA_LINKINIT_OUTSIDE_POLICY:
+			return "(OUTSIDE_POLICY)";
+		case OPA_LINKINIT_QUARANTINED:
+			return "(QUARANTINED)";
+		case OPA_LINKINIT_INSUFIC_CAPABILITY:
+			return "(INSUFIC_CAPABILITY)";
+		default:
+			break;
+		}
+	}
+	return "";
+}
+
+/*
+ * driver_pstate - convert the driver's notion of a port's
+ * state (an HLS_*) into a physical state (a {IB,OPA}_PORTPHYSSTATE_*).
+ * Return -1 (converted to a u32) to indicate error.
+ */
+u32 driver_pstate(struct hfi2_pportdata *ppd)
+{
+	switch (ppd->host_link_state) {
+	case HLS_UP_INIT:
+	case HLS_UP_ARMED:
+	case HLS_UP_ACTIVE:
+		return IB_PORTPHYSSTATE_LINKUP;
+	case HLS_DN_POLL:
+		return IB_PORTPHYSSTATE_POLLING;
+	case HLS_DN_DISABLE:
+		return IB_PORTPHYSSTATE_DISABLED;
+	case HLS_DN_OFFLINE:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case HLS_VERIFY_CAP:
+		return IB_PORTPHYSSTATE_TRAINING;
+	case HLS_GOING_UP:
+		return IB_PORTPHYSSTATE_TRAINING;
+	case HLS_GOING_OFFLINE:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case HLS_LINK_COOLDOWN:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case HLS_DN_DOWNDEF:
+	default:
+		ppd_dev_err(ppd, "invalid host_link_state 0x%x\n",
+			    ppd->host_link_state);
+		return  -1;
+	}
+}
+
+/*
+ * driver_lstate - convert the driver's notion of a port's
+ * state (an HLS_*) into a logical state (a IB_PORT_*). Return -1
+ * (converted to a u32) to indicate error.
+ */
+u32 driver_lstate(struct hfi2_pportdata *ppd)
+{
+	if (ppd->host_link_state && (ppd->host_link_state & HLS_DOWN))
+		return IB_PORT_DOWN;
+
+	switch (ppd->host_link_state & HLS_UP) {
+	case HLS_UP_INIT:
+		return IB_PORT_INIT;
+	case HLS_UP_ARMED:
+		return IB_PORT_ARMED;
+	case HLS_UP_ACTIVE:
+		return IB_PORT_ACTIVE;
+	default:
+		ppd_dev_err(ppd, "invalid host_link_state 0x%x\n",
+			    ppd->host_link_state);
+	return -1;
+	}
+}
+
+void set_link_down_reason(struct hfi2_pportdata *ppd, u8 lcl_reason,
+			  u8 neigh_reason, u8 rem_reason)
+{
+	if (ppd->local_link_down_reason.latest == 0 &&
+	    ppd->neigh_link_down_reason.latest == 0) {
+		ppd->local_link_down_reason.latest = lcl_reason;
+		ppd->neigh_link_down_reason.latest = neigh_reason;
+		ppd->remote_link_down_reason = rem_reason;
+	}
+}
+
+/**
+ * data_vls_operational() - Verify if data VL BCT credits and MTU
+ *			    are both set.
+ * @ppd: pointer to hfi2_pportdata structure
+ *
+ * Return: true - Ok, false -otherwise.
+ */
+static inline bool data_vls_operational(struct hfi2_pportdata *ppd)
+{
+	int i;
+	u64 reg;
+
+	if (!ppd->actual_vls_operational)
+		return false;
+
+	for (i = 0; i < ppd->vls_supported; i++) {
+		u32 off = ppd->dd->params->send_cm_credit_vl_reg + (8 * i);
+
+		reg = read_eport_csr(ppd->dd, ppd->hw_pidx, off);
+		if ((reg && !ppd->vld[i].mtu) ||
+		    (!reg && ppd->vld[i].mtu))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Change the physical and/or logical link state.
+ *
+ * Do not call this routine while inside an interrupt.  It contains
+ * calls to routines that can take multiple seconds to finish.
+ *
+ * Returns 0 on success, -errno on failure.
+ */
+int set_link_state(struct hfi2_pportdata *ppd, u32 state)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int ret1, ret = 0;
+	int orig_new_state, poll_bounce;
+
+	mutex_lock(&ppd->hls_lock);
+
+	orig_new_state = state;
+	if (state == HLS_DN_DOWNDEF)
+		state = HLS_DEFAULT;
+
+	/* interpret poll -> poll as a link bounce */
+	poll_bounce = ppd->host_link_state == HLS_DN_POLL &&
+		      state == HLS_DN_POLL;
+
+	ppd_dev_info(ppd, "%s: current %s, new %s %s%s\n", __func__,
+		     link_state_name(ppd->host_link_state),
+		     link_state_name(orig_new_state),
+		     poll_bounce ? "(bounce) " : "",
+		     link_state_reason_name(ppd, state));
+
+	/*
+	 * If we're going to a (HLS_*) link state that implies the logical
+	 * link state is neither of (IB_PORT_ARMED, IB_PORT_ACTIVE), then
+	 * reset is_sm_config_started to 0.
+	 */
+	if (!(state & (HLS_UP_ARMED | HLS_UP_ACTIVE)))
+		ppd->is_sm_config_started = 0;
+
+	/*
+	 * Do nothing if the states match.  Let a poll to poll link bounce
+	 * go through.
+	 */
+	if (ppd->host_link_state == state && !poll_bounce)
+		goto done;
+
+	switch (state) {
+	case HLS_UP_INIT:
+		if (ppd->host_link_state == HLS_DN_POLL &&
+		    quick_linkup) {
+			/*
+			 * Quick link up jumps from polling to here.
+			 * Accept that here.
+			 */
+			/* OK */
+		} else if (ppd->host_link_state != HLS_GOING_UP) {
+			goto unexpected;
+		}
+
+		/*
+		 * Wait for Link_Up physical state.
+		 * Physical and Logical states should already be
+		 * be transitioned to LinkUp and LinkInit respectively.
+		 */
+		ret = wait_physical_linkstate(ppd, PLS_LINKUP, 1000);
+		if (ret) {
+			dd_dev_err(dd,
+				   "%s: physical state did not change to LINK-UP\n",
+				   __func__);
+			break;
+		}
+
+		ret = wait_logical_linkstate(ppd, IB_PORT_INIT, 1000);
+		if (ret) {
+			ppd_dev_err(ppd,
+				    "%s: logical state did not change to INIT\n",
+				    __func__);
+			break;
+		}
+
+		/* clear old transient LINKINIT_REASON code */
+		if (ppd->linkinit_reason >= OPA_LINKINIT_REASON_CLEAR)
+			ppd->linkinit_reason =
+				OPA_LINKINIT_REASON_LINKUP;
+
+		/* enable the port */
+		add_rcvctrl(ppd, RCV_CTRL_RCV_PORT_ENABLE_SMASK);
+
+		handle_linkup_change(ppd, 1);
+		pio_kernel_linkup(ppd);
+		/* tell engines to go running after a link bounce */
+		sdma_all_running(dd);
+
+		/*
+		 * After link up, a new link width will have been set.
+		 * Update the xmit counters with regards to the new
+		 * link width.
+		 */
+		update_xmit_counters(ppd, ppd->link_width_active);
+
+		ppd->host_link_state = HLS_UP_INIT;
+		update_statusp(ppd, IB_PORT_INIT);
+		break;
+	case HLS_UP_ARMED:
+		if (ppd->host_link_state != HLS_UP_INIT)
+			goto unexpected;
+
+		if (!data_vls_operational(ppd)) {
+			ppd_dev_err(ppd,
+				    "%s: Invalid data VL credits or mtu\n",
+				    __func__);
+			ret = -EINVAL;
+			break;
+		}
+
+		set_logical_state(dd, LSTATE_ARMED);
+		ret = wait_logical_linkstate(ppd, IB_PORT_ARMED, 1000);
+		if (ret) {
+			ppd_dev_err(ppd,
+				    "%s: logical state did not change to ARMED\n",
+				    __func__);
+			break;
+		}
+		ppd->host_link_state = HLS_UP_ARMED;
+		update_statusp(ppd, IB_PORT_ARMED);
+		break;
+	case HLS_UP_ACTIVE:
+		if (ppd->host_link_state != HLS_UP_ARMED)
+			goto unexpected;
+
+		set_logical_state(dd, LSTATE_ACTIVE);
+		ret = wait_logical_linkstate(ppd, IB_PORT_ACTIVE, 1000);
+		if (ret) {
+			ppd_dev_err(ppd,
+				    "%s: logical state did not change to ACTIVE\n",
+				    __func__);
+		} else {
+			ppd->host_link_state = HLS_UP_ACTIVE;
+			update_statusp(ppd, IB_PORT_ACTIVE);
+			go_port_active(ppd);
+		}
+		break;
+	case HLS_DN_POLL:
+		if ((ppd->host_link_state == HLS_DN_DISABLE ||
+		     ppd->host_link_state == HLS_DN_OFFLINE) &&
+		    dd->dc_shutdown)
+			dc_start(dd);
+		/* Hand LED control to the DC */
+		write_csr(dd, DCC_CFG_LED_CNTRL, 0);
+
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			u8 tmp = ppd->link_enabled;
+
+			ret = goto_offline(ppd, ppd->remote_link_down_reason);
+			if (ret) {
+				ppd->link_enabled = tmp;
+				break;
+			}
+			ppd->remote_link_down_reason = 0;
+
+			if (ppd->driver_link_ready)
+				ppd->link_enabled = 1;
+		}
+
+		set_all_slowpath(ppd);
+		ret = set_local_link_attributes(ppd);
+		if (ret)
+			break;
+
+		ppd->port_error_action = 0;
+
+		if (quick_linkup) {
+			/* quick linkup does not go into polling */
+			ret = do_quick_linkup(dd);
+		} else {
+			ret1 = set_physical_link_state(dd, PLS_POLLING);
+			if (!ret1)
+				ret1 = wait_phys_link_out_of_offline(ppd,
+								     3000);
+			if (ret1 != HCMD_SUCCESS) {
+				ppd_dev_err(ppd,
+					    "Failed to transition to Polling link state, return 0x%x\n",
+					    ret1);
+				ret = -EINVAL;
+			}
+		}
+
+		/*
+		 * Change the host link state after requesting DC8051 to
+		 * change its physical state so that we can ignore any
+		 * interrupt with stale LNI(XX) error, which will not be
+		 * cleared until DC8051 transitions to Polling state.
+		 */
+		ppd->host_link_state = HLS_DN_POLL;
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE);
+		/*
+		 * If an error occurred above, go back to offline.  The
+		 * caller may reschedule another attempt.
+		 */
+		if (ret)
+			goto_offline(ppd, 0);
+		else
+			log_physical_state(ppd, PLS_POLLING);
+		break;
+	case HLS_DN_DISABLE:
+		/* link is disabled */
+		ppd->link_enabled = 0;
+
+		/* allow any state to transition to disabled */
+
+		/* must transition to offline first */
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			ret = goto_offline(ppd, ppd->remote_link_down_reason);
+			if (ret)
+				break;
+			ppd->remote_link_down_reason = 0;
+		}
+
+		if (!dd->dc_shutdown) {
+			ret1 = set_physical_link_state(dd, PLS_DISABLED);
+			if (ret1 != HCMD_SUCCESS) {
+				ppd_dev_err(ppd,
+					    "Failed to transition to Disabled link state, return 0x%x\n",
+					    ret1);
+				ret = -EINVAL;
+				break;
+			}
+			ret = wait_physical_linkstate(ppd, PLS_DISABLED, 10000);
+			if (ret) {
+				ppd_dev_err(ppd,
+					    "%s: physical state did not change to DISABLED\n",
+					    __func__);
+				break;
+			}
+			dc_shutdown(dd);
+		}
+		ppd->host_link_state = HLS_DN_DISABLE;
+		break;
+	case HLS_DN_OFFLINE:
+		if (ppd->host_link_state == HLS_DN_DISABLE)
+			dc_start(dd);
+
+		/* allow any state to transition to offline */
+		ret = goto_offline(ppd, ppd->remote_link_down_reason);
+		if (!ret)
+			ppd->remote_link_down_reason = 0;
+		break;
+	case HLS_VERIFY_CAP:
+		if (ppd->host_link_state != HLS_DN_POLL)
+			goto unexpected;
+		ppd->host_link_state = HLS_VERIFY_CAP;
+		log_physical_state(ppd, PLS_CONFIGPHY_VERIFYCAP);
+		break;
+	case HLS_GOING_UP:
+		if (ppd->host_link_state != HLS_VERIFY_CAP)
+			goto unexpected;
+
+		ret1 = set_physical_link_state(dd, PLS_LINKUP);
+		if (ret1 != HCMD_SUCCESS) {
+			ppd_dev_err(ppd,
+				    "Failed to transition to link up state, return 0x%x\n",
+				    ret1);
+			ret = -EINVAL;
+			break;
+		}
+		ppd->host_link_state = HLS_GOING_UP;
+		break;
+
+	case HLS_GOING_OFFLINE:		/* transient within goto_offline() */
+	case HLS_LINK_COOLDOWN:		/* transient within goto_offline() */
+	default:
+		ppd_dev_info(ppd, "%s: state 0x%x: not supported\n",
+			     __func__, state);
+		ret = -EINVAL;
+		break;
+	}
+
+	goto done;
+
+unexpected:
+	ppd_dev_err(ppd, "%s: unexpected state transition from %s to %s\n",
+		    __func__, link_state_name(ppd->host_link_state),
+		    link_state_name(state));
+	ret = -EINVAL;
+
+done:
+	mutex_unlock(&ppd->hls_lock);
+
+	return ret;
+}
+
+int hfi2_set_ib_cfg(struct hfi2_pportdata *ppd, int which, u32 val)
+{
+	u64 reg;
+	int ret = 0;
+
+	switch (which) {
+	case HFI2_IB_CFG_LIDLMC:
+		set_lidlmc(ppd);
+		break;
+	case HFI2_IB_CFG_VL_HIGH_LIMIT:
+		/*
+		 * The VL Arbitrator high limit is sent in units of 4k
+		 * bytes, while HFI stores it in units of 64 bytes.
+		 */
+		val *= 4096 / 64;
+		reg = ((u64)val & SEND_HIGH_PRIORITY_LIMIT_LIMIT_MASK)
+			<< SEND_HIGH_PRIORITY_LIMIT_LIMIT_SHIFT;
+		write_eport_csr(ppd->dd, ppd->hw_pidx,
+				ppd->dd->params->send_high_priority_limit_reg,
+				reg);
+		break;
+	case HFI2_IB_CFG_LINKDEFAULT: /* IB link default (sleep/poll) */
+		/* HFI only supports POLL as the default link down state */
+		if (val != HLS_DN_POLL)
+			ret = -EINVAL;
+		break;
+	case HFI2_IB_CFG_OP_VLS:
+		if (ppd->vls_operational != val) {
+			ppd->vls_operational = val;
+			if (!ppd->port)
+				ret = -EINVAL;
+		}
+		break;
+	/*
+	 * For link width, link width downgrade, and speed enable, always AND
+	 * the setting with what is actually supported.  This has two benefits.
+	 * First, enabled can't have unsupported values, no matter what the
+	 * SM or FM might want.  Second, the ALL_SUPPORTED wildcards that mean
+	 * "fill in with your supported value" have all the bits in the
+	 * field set, so simply ANDing with supported has the desired result.
+	 */
+	case HFI2_IB_CFG_LWID_ENB: /* set allowed Link-width */
+		ppd->link_width_enabled = val & ppd->link_width_supported;
+		break;
+	case HFI2_IB_CFG_LWID_DG_ENB: /* set allowed link width downgrade */
+		ppd->link_width_downgrade_enabled =
+				val & ppd->link_width_downgrade_supported;
+		break;
+	case HFI2_IB_CFG_SPD_ENB: /* allowed Link speeds */
+		ppd->link_speed_enabled = val & ppd->link_speed_supported;
+		break;
+	case HFI2_IB_CFG_OVERRUN_THRESH: /* IB overrun threshold */
+		/*
+		 * HFI does not follow IB specs, save this value
+		 * so we can report it, if asked.
+		 */
+		ppd->overrun_threshold = val;
+		break;
+	case HFI2_IB_CFG_PHYERR_THRESH: /* IB PHY error threshold */
+		/*
+		 * HFI does not follow IB specs, save this value
+		 * so we can report it, if asked.
+		 */
+		ppd->phy_error_threshold = val;
+		break;
+
+	case HFI2_IB_CFG_MTU:
+		set_send_length(ppd);
+		break;
+
+	case HFI2_IB_CFG_PKEYS:
+		if (HFI2_CAP_IS_KSET(PKEY_CHECK))
+			set_partition_keys(ppd);
+		break;
+
+	default:
+		if (HFI2_CAP_IS_KSET(PRINT_UNIMPL))
+			ppd_dev_info(ppd,
+				     "%s: which %s, val 0x%x: not implemented\n",
+				     __func__, ib_cfg_name(which), val);
+		break;
+	}
+	return ret;
+}
+
+/* begin functions related to vl arbitration table caching */
+static void init_vl_arb_caches(struct hfi2_pportdata *ppd)
+{
+	int i;
+
+	BUILD_BUG_ON(VL_ARB_TABLE_SIZE !=
+			VL_ARB_LOW_PRIO_TABLE_SIZE);
+	BUILD_BUG_ON(VL_ARB_TABLE_SIZE !=
+			VL_ARB_HIGH_PRIO_TABLE_SIZE);
+
+	/*
+	 * Note that we always return values directly from the
+	 * 'vl_arb_cache' (and do no CSR reads) in response to a
+	 * 'Get(VLArbTable)'. This is obviously correct after a
+	 * 'Set(VLArbTable)', since the cache will then be up to
+	 * date. But it's also correct prior to any 'Set(VLArbTable)'
+	 * since then both the cache, and the relevant h/w registers
+	 * will be zeroed.
+	 */
+
+	for (i = 0; i < MAX_PRIO_TABLE; i++)
+		spin_lock_init(&ppd->vl_arb_cache[i].lock);
+}
+
+/*
+ * vl_arb_lock_cache
+ *
+ * All other vl_arb_* functions should be called only after locking
+ * the cache.
+ */
+static inline struct vl_arb_cache *
+vl_arb_lock_cache(struct hfi2_pportdata *ppd, int idx)
+{
+	if (idx != LO_PRIO_TABLE && idx != HI_PRIO_TABLE)
+		return NULL;
+	spin_lock(&ppd->vl_arb_cache[idx].lock);
+	return &ppd->vl_arb_cache[idx];
+}
+
+static inline void vl_arb_unlock_cache(struct hfi2_pportdata *ppd, int idx)
+{
+	spin_unlock(&ppd->vl_arb_cache[idx].lock);
+}
+
+static void vl_arb_get_cache(struct vl_arb_cache *cache,
+			     struct ib_vl_weight_elem *vl)
+{
+	memcpy(vl, cache->table, VL_ARB_TABLE_SIZE * sizeof(*vl));
+}
+
+static void vl_arb_set_cache(struct vl_arb_cache *cache,
+			     struct ib_vl_weight_elem *vl)
+{
+	memcpy(cache->table, vl, VL_ARB_TABLE_SIZE * sizeof(*vl));
+}
+
+static int vl_arb_match_cache(struct vl_arb_cache *cache,
+			      struct ib_vl_weight_elem *vl)
+{
+	return !memcmp(cache->table, vl, VL_ARB_TABLE_SIZE * sizeof(*vl));
+}
+
+/* end functions related to vl arbitration table caching */
+
+static int set_vl_weights(struct hfi2_pportdata *ppd, u32 target,
+			  u32 size, struct ib_vl_weight_elem *vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	unsigned int i, is_up = 0;
+	int drain, ret = 0;
+
+	/* only set the registers on WFR */
+	if (dd->params->chip_type != CHIP_WFR)
+		return 0;
+
+	mutex_lock(&ppd->hls_lock);
+
+	if (ppd->host_link_state & HLS_UP)
+		is_up = 1;
+
+	drain = !is_ax(dd) && is_up;
+
+	if (drain)
+		/*
+		 * Before adjusting VL arbitration weights, empty per-VL
+		 * FIFOs, otherwise a packet whose VL weight is being
+		 * set to 0 could get stuck in a FIFO with no chance to
+		 * egress.
+		 */
+		ret = stop_drain_data_vls(ppd);
+
+	if (ret) {
+		ppd_dev_err(ppd,
+			    "%s: cannot stop/drain VLs - refusing to change VL arbitration weights\n",
+			    __func__);
+		goto err;
+	}
+
+	for (i = 0; i < size; i++, vl++) {
+		/*
+		 * NOTE: The low priority shift and mask are used here, but
+		 * they are the same for both the low and high registers.
+		 */
+		reg = (((u64)vl->vl & SEND_LOW_PRIORITY_LIST_VL_MASK)
+				<< SEND_LOW_PRIORITY_LIST_VL_SHIFT)
+		      | (((u64)vl->weight
+				& SEND_LOW_PRIORITY_LIST_WEIGHT_MASK)
+				<< SEND_LOW_PRIORITY_LIST_WEIGHT_SHIFT);
+		write_eport_csr(dd, ppd->hw_pidx, target + (i * 8), reg);
+	}
+	pio_send_control(ppd, PSC_GLOBAL_VLARB_ENABLE);
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
+/*
+ * Read one credit merge VL register.
+ */
+static void read_one_cm_vl(struct hfi2_pportdata *ppd, u32 csr,
+			   struct vl_limit *vll)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = read_eport_csr(dd, ppd->hw_pidx, csr);
+
+	vll->dedicated = cpu_to_be16(
+		(reg >> SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SHIFT)
+		& SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_MASK);
+	vll->shared = cpu_to_be16(
+		(reg >> SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SHIFT)
+		& SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_MASK);
+}
+
+/*
+ * Read the current credit merge limits.
+ */
+static int get_buffer_control(struct hfi2_pportdata *ppd,
+			      struct buffer_control *bc, u16 *overall_limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	int i;
+
+	/* not all entries are filled in */
+	memset(bc, 0, sizeof(*bc));
+
+	/* OPA and HFI have a 1-1 mapping */
+	for (i = 0; i < TXE_NUM_DATA_VL; i++)
+		read_one_cm_vl(ppd, dd->params->send_cm_credit_vl_reg + (8 * i), &bc->vl[i]);
+
+	/* NOTE: assumes that VL* and VL15 CSRs are bit-wise identical */
+	read_one_cm_vl(ppd, dd->params->send_cm_credit_vl15_reg, &bc->vl[15]);
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+	bc->overall_shared_limit = cpu_to_be16(
+		(reg >> SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SHIFT)
+		& SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_MASK);
+	if (overall_limit)
+		*overall_limit = (reg
+			>> SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SHIFT)
+			& SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_MASK;
+	return sizeof(struct buffer_control);
+}
+
+static int get_sc2vlnt(struct hfi2_devdata *dd, struct sc2vlnt *dp)
+{
+	u64 reg;
+	int i;
+
+	/* each register contains 16 SC->VLnt mappings, 4 bits each */
+	reg = read_csr(dd, DCC_CFG_SC_VL_TABLE_15_0);
+	for (i = 0; i < sizeof(u64); i++) {
+		u8 byte = *(((u8 *)&reg) + i);
+
+		dp->vlnt[2 * i] = byte & 0xf;
+		dp->vlnt[(2 * i) + 1] = (byte & 0xf0) >> 4;
+	}
+
+	reg = read_csr(dd, DCC_CFG_SC_VL_TABLE_31_16);
+	for (i = 0; i < sizeof(u64); i++) {
+		u8 byte = *(((u8 *)&reg) + i);
+
+		dp->vlnt[16 + (2 * i)] = byte & 0xf;
+		dp->vlnt[16 + (2 * i) + 1] = (byte & 0xf0) >> 4;
+	}
+	return sizeof(struct sc2vlnt);
+}
+
+static void get_vlarb_preempt(struct hfi2_devdata *dd, u32 nelems,
+			      struct ib_vl_weight_elem *vl)
+{
+	unsigned int i;
+
+	for (i = 0; i < nelems; i++, vl++) {
+		vl->vl = 0xf;
+		vl->weight = 0;
+	}
+}
+
+static void set_sc2vlnt(struct hfi2_devdata *dd, struct sc2vlnt *dp)
+{
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_15_0,
+		  DC_SC_VL_VAL(15_0,
+			       0, dp->vlnt[0] & 0xf,
+			       1, dp->vlnt[1] & 0xf,
+			       2, dp->vlnt[2] & 0xf,
+			       3, dp->vlnt[3] & 0xf,
+			       4, dp->vlnt[4] & 0xf,
+			       5, dp->vlnt[5] & 0xf,
+			       6, dp->vlnt[6] & 0xf,
+			       7, dp->vlnt[7] & 0xf,
+			       8, dp->vlnt[8] & 0xf,
+			       9, dp->vlnt[9] & 0xf,
+			       10, dp->vlnt[10] & 0xf,
+			       11, dp->vlnt[11] & 0xf,
+			       12, dp->vlnt[12] & 0xf,
+			       13, dp->vlnt[13] & 0xf,
+			       14, dp->vlnt[14] & 0xf,
+			       15, dp->vlnt[15] & 0xf));
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_31_16,
+		  DC_SC_VL_VAL(31_16,
+			       16, dp->vlnt[16] & 0xf,
+			       17, dp->vlnt[17] & 0xf,
+			       18, dp->vlnt[18] & 0xf,
+			       19, dp->vlnt[19] & 0xf,
+			       20, dp->vlnt[20] & 0xf,
+			       21, dp->vlnt[21] & 0xf,
+			       22, dp->vlnt[22] & 0xf,
+			       23, dp->vlnt[23] & 0xf,
+			       24, dp->vlnt[24] & 0xf,
+			       25, dp->vlnt[25] & 0xf,
+			       26, dp->vlnt[26] & 0xf,
+			       27, dp->vlnt[27] & 0xf,
+			       28, dp->vlnt[28] & 0xf,
+			       29, dp->vlnt[29] & 0xf,
+			       30, dp->vlnt[30] & 0xf,
+			       31, dp->vlnt[31] & 0xf));
+}
+
+static void nonzero_msg(struct hfi2_devdata *dd, int idx, const char *what,
+			u16 limit)
+{
+	if (limit != 0)
+		dd_dev_info(dd, "Invalid %s limit %d on VL %d, ignoring\n",
+			    what, (int)limit, idx);
+}
+
+/* change only the shared limit portion of SendCmGLobalCredit */
+static void set_global_shared(struct hfi2_pportdata *ppd, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+	reg &= ~SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SMASK;
+	reg |= (u64)limit << SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+}
+
+/* change only the total credit limit portion of SendCmGLobalCredit */
+static void set_global_limit(struct hfi2_pportdata *ppd, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg);
+	reg &= ~SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SMASK;
+	reg |= (u64)limit << SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, dd->params->send_cm_global_credit_reg, reg);
+}
+
+/* set the given per-VL shared limit */
+static void set_vl_shared(struct hfi2_pportdata *ppd, int vl, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u32 addr;
+
+	if (vl < TXE_NUM_DATA_VL)
+		addr = dd->params->send_cm_credit_vl_reg + (8 * vl);
+	else
+		addr = dd->params->send_cm_credit_vl15_reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, addr);
+	reg &= ~SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SMASK;
+	reg |= (u64)limit << SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, addr, reg);
+}
+
+/* set the given per-VL dedicated limit */
+static void set_vl_dedicated(struct hfi2_pportdata *ppd, int vl, u16 limit)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	u32 addr;
+
+	if (vl < TXE_NUM_DATA_VL)
+		addr = dd->params->send_cm_credit_vl_reg + (8 * vl);
+	else
+		addr = dd->params->send_cm_credit_vl15_reg;
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, addr);
+	reg &= ~SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SMASK;
+	reg |= (u64)limit << SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SHIFT;
+	write_eport_csr(dd, ppd->hw_pidx, addr, reg);
+}
+
+/* spin until the given per-VL status mask bits clear */
+static void wait_for_vl_status_clear(struct hfi2_pportdata *ppd, u64 mask,
+				     const char *which)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	unsigned long timeout;
+	u64 reg;
+
+	timeout = jiffies + msecs_to_jiffies(VL_STATUS_CLEAR_TIMEOUT);
+	while (1) {
+		reg = read_eport_csr(dd, ppd->hw_pidx,
+				     dd->params->send_cm_credit_used_status_reg)
+				     & mask;
+
+		if (reg == 0)
+			return;	/* success */
+		if (time_after(jiffies, timeout))
+			break;		/* timed out */
+		udelay(1);
+	}
+
+	ppd_dev_err(ppd,
+		    "%s credit change status not clearing after %dms, mask 0x%llx, not clear 0x%llx\n",
+		    which, VL_STATUS_CLEAR_TIMEOUT, mask, reg);
+	/*
+	 * If this occurs, it is likely there was a credit loss on the link.
+	 * The only recovery from that is a link bounce.
+	 */
+	ppd_dev_err(ppd,
+		    "Continuing anyway.  A credit loss may occur.  Suggest a link bounce\n");
+}
+
+/*
+ * The number of credits on the VLs may be changed while everything
+ * is "live", but the following algorithm must be followed due to
+ * how the hardware is actually implemented.  In particular,
+ * Return_Credit_Status[] is the only correct status check.
+ *
+ * if (reducing Global_Shared_Credit_Limit or any shared limit changing)
+ *     set Global_Shared_Credit_Limit = 0
+ *     use_all_vl = 1
+ * mask0 = all VLs that are changing either dedicated or shared limits
+ * set Shared_Limit[mask0] = 0
+ * spin until Return_Credit_Status[use_all_vl ? all VL : mask0] == 0
+ * if (changing any dedicated limit)
+ *     mask1 = all VLs that are lowering dedicated limits
+ *     lower Dedicated_Limit[mask1]
+ *     spin until Return_Credit_Status[mask1] == 0
+ *     raise Dedicated_Limits
+ * raise Shared_Limits
+ * raise Global_Shared_Credit_Limit
+ *
+ * lower = if the new limit is lower, set the limit to the new value
+ * raise = if the new limit is higher than the current value (may be changed
+ *	earlier in the algorithm), set the new limit to the new value
+ */
+int set_buffer_control(struct hfi2_pportdata *ppd,
+		       struct buffer_control *new_bc)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 changing_mask, ld_mask, stat_mask;
+	int change_count;
+	int i, use_all_mask;
+	int this_shared_changing;
+	int vl_count = 0, ret;
+	/*
+	 * A0: add the variable any_shared_limit_changing below and in the
+	 * algorithm above.  If removing A0 support, it can be removed.
+	 */
+	int any_shared_limit_changing;
+	struct buffer_control cur_bc;
+	u8 changing[OPA_MAX_VLS];
+	u8 lowering_dedicated[OPA_MAX_VLS];
+	u16 cur_total;
+	u32 new_total = 0;
+	const u64 all_mask =
+	SEND_CM_CREDIT_USED_STATUS_VL0_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL1_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL2_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL3_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL4_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL5_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL6_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL7_RETURN_CREDIT_STATUS_SMASK
+	 | SEND_CM_CREDIT_USED_STATUS_VL15_RETURN_CREDIT_STATUS_SMASK;
+
+#define valid_vl(idx) ((idx) < TXE_NUM_DATA_VL || (idx) == 15)
+#define NUM_USABLE_VLS 16	/* look at VL15 and less */
+
+	/* find the new total credits, do sanity check on unused VLs */
+	for (i = 0; i < OPA_MAX_VLS; i++) {
+		if (valid_vl(i)) {
+			new_total += be16_to_cpu(new_bc->vl[i].dedicated);
+			continue;
+		}
+		nonzero_msg(dd, i, "dedicated",
+			    be16_to_cpu(new_bc->vl[i].dedicated));
+		nonzero_msg(dd, i, "shared",
+			    be16_to_cpu(new_bc->vl[i].shared));
+		new_bc->vl[i].dedicated = 0;
+		new_bc->vl[i].shared = 0;
+	}
+	new_total += be16_to_cpu(new_bc->overall_shared_limit);
+
+	/* fetch the current values */
+	get_buffer_control(ppd, &cur_bc, &cur_total);
+
+	/*
+	 * Create the masks we will use.
+	 */
+	memset(changing, 0, sizeof(changing));
+	memset(lowering_dedicated, 0, sizeof(lowering_dedicated));
+	/*
+	 * NOTE: Assumes that the individual VL bits are adjacent and in
+	 * increasing order
+	 */
+	stat_mask =
+		SEND_CM_CREDIT_USED_STATUS_VL0_RETURN_CREDIT_STATUS_SMASK;
+	changing_mask = 0;
+	ld_mask = 0;
+	change_count = 0;
+	any_shared_limit_changing = 0;
+	for (i = 0; i < NUM_USABLE_VLS; i++, stat_mask <<= 1) {
+		if (!valid_vl(i))
+			continue;
+		this_shared_changing = new_bc->vl[i].shared
+						!= cur_bc.vl[i].shared;
+		if (this_shared_changing)
+			any_shared_limit_changing = 1;
+		if (new_bc->vl[i].dedicated != cur_bc.vl[i].dedicated ||
+		    this_shared_changing) {
+			changing[i] = 1;
+			changing_mask |= stat_mask;
+			change_count++;
+		}
+		if (be16_to_cpu(new_bc->vl[i].dedicated) <
+					be16_to_cpu(cur_bc.vl[i].dedicated)) {
+			lowering_dedicated[i] = 1;
+			ld_mask |= stat_mask;
+		}
+	}
+
+	/* bracket the credit change with a total adjustment */
+	if (new_total > cur_total)
+		set_global_limit(ppd, new_total);
+
+	/*
+	 * Start the credit change algorithm.
+	 */
+	use_all_mask = 0;
+	if ((be16_to_cpu(new_bc->overall_shared_limit) <
+	     be16_to_cpu(cur_bc.overall_shared_limit)) ||
+	    (is_ax(dd) && any_shared_limit_changing)) {
+		set_global_shared(ppd, 0);
+		cur_bc.overall_shared_limit = 0;
+		use_all_mask = 1;
+	}
+
+	for (i = 0; i < NUM_USABLE_VLS; i++) {
+		if (!valid_vl(i))
+			continue;
+
+		if (changing[i]) {
+			set_vl_shared(ppd, i, 0);
+			cur_bc.vl[i].shared = 0;
+		}
+	}
+
+	wait_for_vl_status_clear(ppd, use_all_mask ? all_mask : changing_mask,
+				 "shared");
+
+	if (change_count > 0) {
+		for (i = 0; i < NUM_USABLE_VLS; i++) {
+			if (!valid_vl(i))
+				continue;
+
+			if (lowering_dedicated[i]) {
+				set_vl_dedicated(ppd, i,
+						 be16_to_cpu(new_bc->
+							     vl[i].dedicated));
+				cur_bc.vl[i].dedicated =
+						new_bc->vl[i].dedicated;
+			}
+		}
+
+		wait_for_vl_status_clear(ppd, ld_mask, "dedicated");
+
+		/* now raise all dedicated that are going up */
+		for (i = 0; i < NUM_USABLE_VLS; i++) {
+			if (!valid_vl(i))
+				continue;
+
+			if (be16_to_cpu(new_bc->vl[i].dedicated) >
+					be16_to_cpu(cur_bc.vl[i].dedicated))
+				set_vl_dedicated(ppd, i,
+						 be16_to_cpu(new_bc->
+							     vl[i].dedicated));
+		}
+	}
+
+	/* next raise all shared that are going up */
+	for (i = 0; i < NUM_USABLE_VLS; i++) {
+		if (!valid_vl(i))
+			continue;
+
+		if (be16_to_cpu(new_bc->vl[i].shared) >
+				be16_to_cpu(cur_bc.vl[i].shared))
+			set_vl_shared(ppd, i, be16_to_cpu(new_bc->vl[i].shared));
+	}
+
+	/* finally raise the global shared */
+	if (be16_to_cpu(new_bc->overall_shared_limit) >
+	    be16_to_cpu(cur_bc.overall_shared_limit))
+		set_global_shared(ppd,
+				  be16_to_cpu(new_bc->overall_shared_limit));
+
+	/* bracket the credit change with a total adjustment */
+	if (new_total < cur_total)
+		set_global_limit(ppd, new_total);
+
+	/*
+	 * Determine the actual number of operational VLS using the number of
+	 * dedicated and shared credits for each VL.
+	 */
+	if (change_count > 0) {
+		for (i = 0; i < TXE_NUM_DATA_VL; i++)
+			if (be16_to_cpu(new_bc->vl[i].dedicated) > 0 ||
+			    be16_to_cpu(new_bc->vl[i].shared) > 0)
+				vl_count++;
+		ppd->actual_vls_operational = vl_count;
+		ret = sdma_map_init(ppd, vl_count ?
+				    ppd->actual_vls_operational :
+				    ppd->vls_operational,
+				    NULL);
+		if (ret == 0)
+			ret = pio_map_init(ppd, vl_count ?
+					   ppd->actual_vls_operational :
+					   ppd->vls_operational);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/*
+ * Read the given fabric manager table. Return the size of the
+ * table (in bytes) on success, and a negative error code on
+ * failure.
+ */
+int fm_get_table(struct hfi2_pportdata *ppd, int which, void *t)
+
+{
+	int size;
+	struct vl_arb_cache *vlc;
+
+	switch (which) {
+	case FM_TBL_VL_HIGH_ARB:
+		size = 256;
+		/*
+		 * OPA specifies 128 elements (of 2 bytes each), though
+		 * HFI supports only 16 elements in h/w.
+		 */
+		vlc = vl_arb_lock_cache(ppd, HI_PRIO_TABLE);
+		vl_arb_get_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, HI_PRIO_TABLE);
+		break;
+	case FM_TBL_VL_LOW_ARB:
+		size = 256;
+		/*
+		 * OPA specifies 128 elements (of 2 bytes each), though
+		 * HFI supports only 16 elements in h/w.
+		 */
+		vlc = vl_arb_lock_cache(ppd, LO_PRIO_TABLE);
+		vl_arb_get_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, LO_PRIO_TABLE);
+		break;
+	case FM_TBL_BUFFER_CONTROL:
+		size = get_buffer_control(ppd, t, NULL);
+		break;
+	case FM_TBL_SC2VLNT:
+		size = get_sc2vlnt(ppd->dd, t);
+		break;
+	case FM_TBL_VL_PREEMPT_ELEMS:
+		size = 256;
+		/* OPA specifies 128 elements, of 2 bytes each */
+		get_vlarb_preempt(ppd->dd, OPA_MAX_VLS, t);
+		break;
+	case FM_TBL_VL_PREEMPT_MATRIX:
+		size = 256;
+		/*
+		 * OPA specifies that this is the same size as the VL
+		 * arbitration tables (i.e., 256 bytes).
+		 */
+		break;
+	default:
+		return -EINVAL;
+	}
+	return size;
+}
+
+/*
+ * Write the given fabric manager table.
+ */
+int fm_set_table(struct hfi2_pportdata *ppd, int which, void *t)
+{
+	int ret = 0;
+	struct vl_arb_cache *vlc;
+
+	switch (which) {
+	case FM_TBL_VL_HIGH_ARB:
+		vlc = vl_arb_lock_cache(ppd, HI_PRIO_TABLE);
+		if (vl_arb_match_cache(vlc, t)) {
+			vl_arb_unlock_cache(ppd, HI_PRIO_TABLE);
+			break;
+		}
+		vl_arb_set_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, HI_PRIO_TABLE);
+		ret = set_vl_weights(ppd, ppd->dd->params->send_high_priority_list_reg,
+				     VL_ARB_HIGH_PRIO_TABLE_SIZE, t);
+		break;
+	case FM_TBL_VL_LOW_ARB:
+		vlc = vl_arb_lock_cache(ppd, LO_PRIO_TABLE);
+		if (vl_arb_match_cache(vlc, t)) {
+			vl_arb_unlock_cache(ppd, LO_PRIO_TABLE);
+			break;
+		}
+		vl_arb_set_cache(vlc, t);
+		vl_arb_unlock_cache(ppd, LO_PRIO_TABLE);
+		ret = set_vl_weights(ppd, ppd->dd->params->send_low_priority_list_reg,
+				     VL_ARB_LOW_PRIO_TABLE_SIZE, t);
+		break;
+	case FM_TBL_BUFFER_CONTROL:
+		ret = set_buffer_control(ppd, t);
+		break;
+	case FM_TBL_SC2VLNT:
+		set_sc2vlnt(ppd->dd, t);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+/*
+ * Disable all data VLs.
+ *
+ * Return 0 if disabled, non-zero if the VLs cannot be disabled.
+ */
+static int disable_data_vls(struct hfi2_pportdata *ppd)
+{
+	if (is_ax(ppd->dd))
+		return 1;
+
+	pio_send_control(ppd, PSC_DATA_VL_DISABLE);
+
+	return 0;
+}
+
+/*
+ * open_fill_data_vls() - the counterpart to stop_drain_data_vls().
+ * Just re-enables all data VLs (the "fill" part happens
+ * automatically - the name was chosen for symmetry with
+ * stop_drain_data_vls()).
+ *
+ * Return 0 if successful, non-zero if the VLs cannot be enabled.
+ */
+int open_fill_data_vls(struct hfi2_pportdata *ppd)
+{
+	if (is_ax(ppd->dd))
+		return 1;
+
+	pio_send_control(ppd, PSC_DATA_VL_ENABLE);
+
+	return 0;
+}
+
+/*
+ * drain_data_vls() - assumes that disable_data_vls() has been called,
+ * wait for occupancy (of per-VL FIFOs) for all contexts, and SDMA
+ * engines to drop to 0.
+ */
+static void drain_data_vls(struct hfi2_devdata *dd)
+{
+	sc_wait(dd);
+	sdma_wait(dd);
+	pause_for_credit_return(dd);
+}
+
+/*
+ * stop_drain_data_vls() - disable, then drain all per-VL fifos.
+ *
+ * Use open_fill_data_vls() to resume using data VLs.  This pair is
+ * meant to be used like this:
+ *
+ * stop_drain_data_vls(dd);
+ * // do things with per-VL resources
+ * open_fill_data_vls(dd);
+ */
+int stop_drain_data_vls(struct hfi2_pportdata *ppd)
+{
+	int ret;
+
+	ret = disable_data_vls(ppd);
+	if (ret == 0)
+		drain_data_vls(ppd->dd);
+
+	return ret;
+}
+
+/*
+ * Convert a nanosecond time to a cclock count.  No matter how slow
+ * the cclock, a non-zero ns will always have a non-zero result.
+ */
+u32 ns_to_cclock(struct hfi2_devdata *dd, u32 ns)
+{
+	u32 cclocks;
+
+	/* simulation pretends to be ASIC */
+	cclocks = (ns * 1000) / dd->params->asic_cclock_ps;
+	if (ns && !cclocks)	/* if ns nonzero, must be at least 1 */
+		cclocks = 1;
+	return cclocks;
+}
+
+/*
+ * Convert a cclock count to nanoseconds. No matter how slow
+ * the cclock, a non-zero cclocks will always have a non-zero result.
+ */
+u32 cclock_to_ns(struct hfi2_devdata *dd, u32 cclocks)
+{
+	u32 ns;
+
+	/* simulation pretends to be ASIC */
+	ns = (cclocks * dd->params->asic_cclock_ps) / 1000;
+	if (cclocks && !ns)
+		ns = 1;
+	return ns;
+}
+
+/*
+ * Dynamically adjust the receive interrupt timeout for a context based on
+ * incoming packet rate.
+ *
+ * NOTE: Dynamic adjustment does not allow rcv_intr_count to be zero.
+ */
+static void adjust_rcv_timeout(struct hfi2_ctxtdata *rcd, u32 npkts)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 timeout = rcd->rcvavail_timeout;
+
+	/*
+	 * This algorithm doubles or halves the timeout depending on whether
+	 * the number of packets received in this interrupt were less than or
+	 * greater equal the interrupt count.
+	 *
+	 * The calculations below do not allow a steady state to be achieved.
+	 * Only at the endpoints it is possible to have an unchanging
+	 * timeout.
+	 */
+	if (npkts < rcv_intr_count) {
+		/*
+		 * Not enough packets arrived before the timeout, adjust
+		 * timeout downward.
+		 */
+		if (timeout < 2) /* already at minimum? */
+			return;
+		timeout >>= 1;
+	} else {
+		/*
+		 * More than enough packets arrived before the timeout, adjust
+		 * timeout upward.
+		 */
+		if (timeout >= dd->rcv_intr_timeout_csr) /* already at max? */
+			return;
+		timeout = min(timeout << 1, dd->rcv_intr_timeout_csr);
+	}
+
+	rcd->rcvavail_timeout = timeout;
+	/*
+	 * timeout cannot be larger than rcv_intr_timeout_csr which has already
+	 * been verified to be in range
+	 */
+	write_kctxt_csr(dd, rcd->ctxt, dd->params->rcv_avail_time_out_reg,
+			(u64)timeout <<
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_SHIFT);
+}
+
+void update_usrhead(struct hfi2_ctxtdata *rcd, u32 hd, u32 updegr, u32 egrhd,
+		    u32 intr_adjust, u32 npkts)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u64 reg;
+	u32 ctxt = rcd->ctxt;
+
+	/*
+	 * Need to write timeout register before updating RcvHdrHead to ensure
+	 * that a new value is used when the HW decides to restart counting.
+	 */
+	if (intr_adjust)
+		adjust_rcv_timeout(rcd, npkts);
+	if (updegr) {
+		reg = (egrhd & RCV_EGR_INDEX_HEAD_HEAD_MASK)
+			<< RCV_EGR_INDEX_HEAD_HEAD_SHIFT;
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_egr_index_head_reg, reg);
+	}
+	reg = ((u64)rcv_intr_count << RCV_HDR_HEAD_COUNTER_SHIFT) |
+		(((u64)hd & RCV_HDR_HEAD_HEAD_MASK)
+			<< RCV_HDR_HEAD_HEAD_SHIFT);
+	write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, reg);
+}
+
+u32 hdrqempty(struct hfi2_ctxtdata *rcd)
+{
+	u32 head, tail;
+
+	head = (read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_head_reg)
+		& RCV_HDR_HEAD_HEAD_SMASK) >> RCV_HDR_HEAD_HEAD_SHIFT;
+
+	if (hfi2_rcvhdrtail_kvaddr(rcd))
+		tail = get_rcvhdrtail(rcd);
+	else
+		tail = read_uctxt_csr(rcd->dd, rcd->ctxt, rcd->dd->params->rcv_hdr_tail_reg);
+
+	return head == tail;
+}
+
+/*
+ * Context Control and Receive Array encoding for buffer size:
+ *	0x0 invalid
+ *	0x1   4 KB
+ *	0x2   8 KB
+ *	0x3  16 KB
+ *	0x4  32 KB
+ *	0x5  64 KB
+ *	0x6 128 KB
+ *	0x7 256 KB
+ *	0x8 512 KB (Receive Array only)
+ *	0x9   1 MB (Receive Array only)
+ *	0xa   2 MB (Receive Array only)
+ *
+ *	0xB-0xF - reserved (Receive Array only)
+ *
+ *
+ * This routine assumes that the value has already been sanity checked.
+ */
+static u32 encoded_size(u32 size)
+{
+	switch (size) {
+	case   4 * 1024: return 0x1;
+	case   8 * 1024: return 0x2;
+	case  16 * 1024: return 0x3;
+	case  32 * 1024: return 0x4;
+	case  64 * 1024: return 0x5;
+	case 128 * 1024: return 0x6;
+	case 256 * 1024: return 0x7;
+	case 512 * 1024: return 0x8;
+	case   1 * 1024 * 1024: return 0x9;
+	case   2 * 1024 * 1024: return 0xa;
+	}
+	return 0x1;	/* if invalid, go with the minimum size */
+}
+
+/**
+ * encode_rcv_header_entry_size - return chip specific encoding for size
+ * @size: size in dwords
+ *
+ * Convert a receive header entry size that to the encoding used in the CSR.
+ *
+ * Return a zero if the given size is invalid, otherwise the encoding.
+ */
+u8 encode_rcv_header_entry_size(u8 size)
+{
+	/* there are only 3 valid receive header entry sizes */
+	if (size == 2)
+		return 1;
+	if (size == 16)
+		return 2;
+	if (size == 32)
+		return 4;
+	return 0; /* invalid */
+}
+
+/**
+ * hfi2_validate_rcvhdrcnt - validate hdrcnt
+ * @dd: the device data
+ * @thecnt: the header count
+ */
+int hfi2_validate_rcvhdrcnt(struct hfi2_devdata *dd, uint thecnt)
+{
+	if (thecnt <= HFI2_MIN_HDRQ_EGRBUF_CNT) {
+		dd_dev_err(dd, "Receive header queue count too small\n");
+		return -EINVAL;
+	}
+
+	if (thecnt > HFI2_MAX_HDRQ_EGRBUF_CNT) {
+		dd_dev_err(dd,
+			   "Receive header queue count cannot be greater than %u\n",
+			   HFI2_MAX_HDRQ_EGRBUF_CNT);
+		return -EINVAL;
+	}
+
+	if (thecnt % HDRQ_INCREMENT) {
+		dd_dev_err(dd, "Receive header queue count %d must be divisible by %lu\n",
+			   thecnt, HDRQ_INCREMENT);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void wfr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt, u32 size)
+{
+	u64 reg;
+
+	reg = ((u64)size & RCV_HDR_SIZE_HDR_SIZE_MASK) <<
+	      RCV_HDR_SIZE_HDR_SIZE_SHIFT;
+	write_kctxt_csr(ppd->dd, ctxt, RCV_HDR_SIZE, reg);
+}
+
+/**
+ * set_hdrq_regs - set header queue registers for context
+ * @dd: the device data
+ * @ctxt: the context
+ * @entsize: the dword entry size
+ * @hdrcnt: the number of header entries
+ * @kdeth_rcv_hdr: KDETH receive header size
+ */
+void set_hdrq_regs(struct hfi2_pportdata *ppd, u16 ctxt, u8 entsize, u16 hdrcnt,
+		   u8 kdeth_rcv_hdr)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = (((u64)hdrcnt >> HDRQ_SIZE_SHIFT) & RCV_HDR_CNT_CNT_MASK) <<
+	      RCV_HDR_CNT_CNT_SHIFT;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_cnt_reg, reg);
+	reg = ((u64)encode_rcv_header_entry_size(entsize) &
+	       RCV_HDR_ENT_SIZE_ENT_SIZE_MASK) <<
+	      RCV_HDR_ENT_SIZE_ENT_SIZE_SHIFT;
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_ent_size_reg, reg);
+	dd->params->update_rcv_hdr_size(ppd, ctxt, kdeth_rcv_hdr);
+
+	/*
+	 * Program dummy tail address for every receive context
+	 * before enabling any receive context
+	 */
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+			dd->rcvhdrtail_dummy_dma);
+}
+
+/* this is a type of kernel context */
+bool is_control_context(struct hfi2_ctxtdata *rcd)
+{
+	return rcd->ctxt == rcd->ppd->rcv_context_base + HFI2_CTRL_CTXT;
+}
+
+/* includes control context */
+bool is_kernel_context(struct hfi2_ctxtdata *rcd)
+{
+	/* assumes in sequential order from base */
+	return rcd->ctxt < rcd->ppd->first_dyn_alloc_ctxt;
+}
+
+/* includes user contexts */
+bool is_dynamic_context(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_pportdata *ppd = rcd->ppd;
+
+	return rcd->ctxt >= ppd->first_dyn_alloc_ctxt &&
+	       rcd->ctxt < (ppd->rcv_context_base + ppd->num_rcv_contexts);
+}
+
+bool is_user_context(struct hfi2_ctxtdata *rcd)
+{
+	return is_dynamic_context(rcd);
+}
+
+/* WFR specific rcv context enable, disable */
+void wfr_enable_rcv_context(struct hfi2_pportdata *ppd, u16 ctxt,
+			    u64 *kctxt_ctrl, bool enable)
+{
+	/* nothing special needs to be done */
+}
+
+void hfi2_rcvctrl(struct hfi2_devdata *dd, unsigned int op,
+		  struct hfi2_ctxtdata *rcd)
+{
+	u64 rcvctrl, reg;
+	u64 rctxt_ctrl;
+	int did_enable = 0;
+	u16 ctxt;
+
+	if (!rcd)
+		return;
+
+	ctxt = rcd->ctxt;
+
+	hfi2_cdbg(RCVCTRL, "ctxt %d op 0x%x", ctxt, op);
+
+	rcvctrl = read_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg);
+	/* if the context already enabled, don't do the extra steps */
+	if ((op & HFI2_RCVCTRL_CTXT_ENB) &&
+	    !(rcvctrl & RCV_CTXT_CTRL_ENABLE_SMASK)) {
+		/* reset the tail and hdr addresses, and sequence count */
+		write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_addr_reg,
+				rcd->rcvhdrq_dma);
+		if (hfi2_rcvhdrtail_kvaddr(rcd))
+			write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+					rcd->rcvhdrqtailaddr_dma);
+		if (dd->params->set_rheq_addr)
+			dd->params->set_rheq_addr(dd, ctxt, rcd->rheq_dma);
+		hfi2_set_seq_cnt(rcd, 1);
+
+		/* reset the cached receive header queue head value */
+		hfi2_set_rcd_head(rcd, 0);
+
+		/*
+		 * Zero the receive header queue so we don't get false
+		 * positives when checking the sequence number.  The
+		 * sequence numbers could land exactly on the same spot.
+		 * E.g. a rcd restart before the receive header wrapped.
+		 */
+		memset(rcd->rcvhdrq, 0, rcvhdrq_size(rcd));
+
+		/* starting timeout */
+		rcd->rcvavail_timeout = dd->rcv_intr_timeout_csr;
+
+		/* enable the context */
+		rcvctrl |= RCV_CTXT_CTRL_ENABLE_SMASK;
+
+		/* clean the egr buffer size first */
+		rcvctrl &= ~RCV_CTXT_CTRL_EGR_BUF_SIZE_SMASK;
+		rcvctrl |= ((u64)encoded_size(rcd->egrbufs.rcvtid_size)
+				& RCV_CTXT_CTRL_EGR_BUF_SIZE_MASK)
+					<< RCV_CTXT_CTRL_EGR_BUF_SIZE_SHIFT;
+
+		/* zero RcvHdrHead - set RcvHdrHead.Counter after enable */
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, 0);
+		did_enable = 1;
+
+		/* zero RcvEgrIndexHead */
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_egr_index_head_reg, 0);
+
+		/* WFR only: direct VL15 packets to the control context */
+		if (is_control_context(rcd) && dd->params->chip_type == CHIP_WFR) {
+			write_iport_csr(dd, rcd->ppd->hw_pidx,
+					dd->params->rcv_vl15_reg, ctxt);
+		}
+
+		/* per-chip enable */
+		dd->params->enable_rcv_context(rcd->ppd, ctxt, &rcvctrl, true);
+	}
+	if (op & HFI2_RCVCTRL_CTXT_DIS) {
+		/*
+		 * When receive context is being disabled turn on tail
+		 * update with a dummy tail address and then disable
+		 * receive context.
+		 */
+		if (dd->rcvhdrtail_dummy_dma) {
+			write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+					dd->rcvhdrtail_dummy_dma);
+			/* Enabling RcvCtxtCtrl.TailUpd is intentional. */
+			rcvctrl |= RCV_CTXT_CTRL_TAIL_UPD_SMASK;
+		}
+
+		rcvctrl &= ~RCV_CTXT_CTRL_ENABLE_SMASK;
+
+		/* per-chip disable */
+		dd->params->enable_rcv_context(rcd->ppd, ctxt, &rcvctrl, false);
+	}
+	if (op & HFI2_RCVCTRL_TID_CONFIG) {
+		/* set eager count and base index */
+		reg = ((u64)(rcd->egrbufs.alloced >> RCV_SHIFT)
+				<< RCV_EGR_CTRL_EGR_CNT_SHIFT) |
+		      ((rcd->eager_base >> RCV_SHIFT)
+				<< RCV_EGR_CTRL_EGR_BASE_INDEX_SHIFT);
+		write_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg, reg);
+
+		/*
+		 * Set TID (expected) count and base index.
+		 * rcd->expected_count is set to individual RcvArray entries,
+		 * not pairs, and the CSR takes a pair-count in groups of
+		 * four, so divide by 8.
+		 */
+		reg = ((u64)(rcd->expected_count >> RCV_SHIFT)
+				<< RCV_TID_CTRL_TID_PAIR_CNT_SHIFT) |
+		      ((rcd->expected_base >> RCV_SHIFT)
+				<< RCV_TID_CTRL_TID_BASE_INDEX_SHIFT);
+		write_rctxt_csr(dd, ctxt, dd->params->rcv_tid_ctrl_reg, reg);
+		dd->params->set_port_tid_count(rcd);
+	}
+	if ((op & HFI2_RCVCTRL_TAILUPD_ENB) && hfi2_rcvhdrtail_kvaddr(rcd))
+		rcvctrl |= RCV_CTXT_CTRL_TAIL_UPD_SMASK;
+	if (op & HFI2_RCVCTRL_TAILUPD_DIS) {
+		/* See comment on RcvCtxtCtrl.TailUpd above */
+		if (!(op & HFI2_RCVCTRL_CTXT_DIS))
+			rcvctrl &= ~RCV_CTXT_CTRL_TAIL_UPD_SMASK;
+	}
+	if (op & HFI2_RCVCTRL_ONE_PKT_EGR_ENB) {
+		/*
+		 * In one-packet-per-eager mode, the size comes from
+		 * the RcvArray entry.
+		 */
+		rcvctrl &= ~RCV_CTXT_CTRL_EGR_BUF_SIZE_SMASK;
+		rcvctrl |= RCV_CTXT_CTRL_ONE_PACKET_PER_EGR_BUFFER_SMASK;
+	}
+	if (op & HFI2_RCVCTRL_ONE_PKT_EGR_DIS)
+		rcvctrl &= ~RCV_CTXT_CTRL_ONE_PACKET_PER_EGR_BUFFER_SMASK;
+	if (op & HFI2_RCVCTRL_URGENT_ENB)
+		set_intr_bits(dd, dd->params->is_rcvurgent_start + rcd->ctxt,
+			      dd->params->is_rcvurgent_start + rcd->ctxt, true);
+	if (op & HFI2_RCVCTRL_URGENT_DIS)
+		set_intr_bits(dd, dd->params->is_rcvurgent_start + rcd->ctxt,
+			      dd->params->is_rcvurgent_start + rcd->ctxt, false);
+
+	write_kctxt_csr(dd, ctxt, dd->params->rcv_kctxt_ctrl_reg, rcvctrl);
+
+	rctxt_ctrl = read_rctxt_csr(dd, ctxt, dd->params->rcv_rctxt_ctrl_reg);
+	if (op & HFI2_RCVCTRL_INTRAVAIL_ENB) {
+		set_intr_bits(dd, dd->params->is_rcvavail_start + rcd->ctxt,
+			      dd->params->is_rcvavail_start + rcd->ctxt, true);
+		rctxt_ctrl |= RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
+	}
+	if (op & HFI2_RCVCTRL_INTRAVAIL_DIS) {
+		set_intr_bits(dd, dd->params->is_rcvavail_start + rcd->ctxt,
+			      dd->params->is_rcvavail_start + rcd->ctxt, false);
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_INTR_AVAIL_SMASK;
+	}
+	if (op & HFI2_RCVCTRL_TIDFLOW_ENB)
+		rctxt_ctrl |= RCV_CTXT_CTRL_TID_FLOW_ENABLE_SMASK;
+	if (op & HFI2_RCVCTRL_TIDFLOW_DIS)
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_TID_FLOW_ENABLE_SMASK;
+	if (op & HFI2_RCVCTRL_NO_RHQ_DROP_ENB)
+		rctxt_ctrl |= RCV_CTXT_CTRL_DONT_DROP_RHQ_FULL_SMASK;
+	if (op & HFI2_RCVCTRL_NO_RHQ_DROP_DIS)
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_DONT_DROP_RHQ_FULL_SMASK;
+	if (op & HFI2_RCVCTRL_NO_EGR_DROP_ENB)
+		rctxt_ctrl |= RCV_CTXT_CTRL_DONT_DROP_EGR_FULL_SMASK;
+	if (op & HFI2_RCVCTRL_NO_EGR_DROP_DIS)
+		rctxt_ctrl &= ~RCV_CTXT_CTRL_DONT_DROP_EGR_FULL_SMASK;
+
+	hfi2_cdbg(RCVCTRL, "ctxt %d kctrl 0x%llx rctrl 0x%llx", ctxt, rcvctrl, rctxt_ctrl);
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_rctxt_ctrl_reg, rctxt_ctrl);
+
+	/* work around sticky RcvCtxtStatus.BlockedRHQFull */
+	if (did_enable &&
+	    (rctxt_ctrl & RCV_CTXT_CTRL_DONT_DROP_RHQ_FULL_SMASK)) {
+		reg = read_ku_csr(dd, ctxt, dd->params->rcv_ctxt_status_reg);
+		if (reg != 0) {
+			dd_dev_info(dd, "ctxt %d status %lld (blocked)\n",
+				    ctxt, reg);
+			read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg);
+			write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, 0x10);
+			write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, 0x00);
+			read_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg);
+			reg = read_ku_csr(dd, ctxt, dd->params->rcv_ctxt_status_reg);
+			dd_dev_info(dd, "ctxt %d status %lld (%s blocked)\n",
+				    ctxt, reg, reg == 0 ? "not" : "still");
+		}
+	}
+
+	if (did_enable) {
+		/*
+		 * The interrupt timeout and count must be set after
+		 * the context is enabled to take effect.
+		 */
+		/* set interrupt timeout */
+		write_kctxt_csr(dd, ctxt, dd->params->rcv_avail_time_out_reg,
+				(u64)rcd->rcvavail_timeout <<
+				RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_SHIFT);
+
+		/* set RcvHdrHead.Counter, zero RcvHdrHead.Head (again) */
+		reg = (u64)rcv_intr_count << RCV_HDR_HEAD_COUNTER_SHIFT;
+		write_uctxt_csr(dd, ctxt, dd->params->rcv_hdr_head_reg, reg);
+	}
+
+	if (op & (HFI2_RCVCTRL_TAILUPD_DIS | HFI2_RCVCTRL_CTXT_DIS))
+		/*
+		 * If the context has been disabled and the Tail Update has
+		 * been cleared, set the RCV_HDR_TAIL_ADDR CSR to dummy address
+		 * so it doesn't contain an address that is invalid.
+		 */
+		write_kctxt_csr(dd, ctxt, dd->params->rcv_hdr_tail_addr_reg,
+				dd->rcvhdrtail_dummy_dma);
+}
+
+/*
+ * Read the counters from the table, store the values read into results.
+ */
+static void read_counters(struct hfi2_devdata *dd,
+			  const struct cntr_entry *table,
+			  int table_size,
+			  void *context,
+			  u64 *results)
+{
+	const struct cntr_entry *entry;
+	u64 val;
+	u32 num_sdma = chip_sdma_engines(dd);
+	int i, j;
+
+	/* fill in each counter from the table */
+	for (i = 0; i < table_size; i++) {
+		entry = &table[i];
+		hfi2_cdbg(CNTR, "reading %s", entry->name);
+		if (entry->flags & CNTR_DISABLED) {
+			/* Nothing */
+			hfi2_cdbg(CNTR, "\tDisabled");
+			continue;
+		}
+
+		if (entry->flags & CNTR_VL) {
+			hfi2_cdbg(CNTR, "\tPer VL");
+			for (j = 0; j < C_VL_COUNT; j++) {
+				val = entry->rw_cntr(entry, context, j,
+						     CNTR_MODE_R, 0);
+				hfi2_cdbg(CNTR, "\t\tRead 0x%llx for %d",
+					  val, j);
+				results[entry->offset + j] = val;
+			}
+		} else if (entry->flags & CNTR_SDMA) {
+			hfi2_cdbg(CNTR, "\tPer SDMA Engine");
+			for (j = 0; j < num_sdma; j++) {
+				val = entry->rw_cntr(entry, context, j,
+						     CNTR_MODE_R, 0);
+				hfi2_cdbg(CNTR, "\t\tRead 0x%llx for %d",
+					  val, j);
+				results[entry->offset + j] = val;
+			}
+		} else if (entry->flags & CNTR_OVF) {
+			hfi2_cdbg(CNTR, "\tPer ctxt");
+			for (j = 0; j < dd->num_rcd; j++) {
+				if (test_bit(j, dd->ovf_disabled))
+					continue;
+				val = entry->rw_cntr(entry, context, j,
+						     CNTR_MODE_R, 0);
+				hfi2_cdbg(CNTR,
+					  "\t\tRead 0x%llx for %d",
+					  val, j);
+				results[entry->offset + dd->ovf_offset[j]] = val;
+			}
+		} else {
+			val = entry->rw_cntr(entry, context, CNTR_INVALID_VL,
+					     CNTR_MODE_R, 0);
+			results[entry->offset] = val;
+			hfi2_cdbg(CNTR, "\tRead 0x%llx", val);
+		}
+	}
+}
+
+/*
+ * Return device counter names or updated counter values.  Return buffer size.
+ * Used by sysfs and verbs.
+ */
+u32 hfi2_read_cntrs(struct hfi2_devdata *dd, char **namep, u64 **cntrp)
+{
+	if (namep) {
+		*namep = dd->cntrnames;
+		return dd->cntrnameslen;
+	}
+
+	read_counters(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+		      dd, dd->cntrs);
+	read_counters(dd, dd->params->chip_dev_cntrs,
+		      dd->params->chip_num_dev_cntrs,
+		      dd, dd->cntrs);
+	*cntrp = dd->cntrs;
+	return dd->ndevcntrs * sizeof(u64);
+}
+
+/*
+ * Return port counter names or updated counter values.  Return buffer size.
+ * Used by sysfs and verbs.
+ */
+u32 hfi2_read_portcntrs(struct hfi2_pportdata *ppd, char **namep, u64 **cntrp)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+
+	if (namep) {
+		*namep = dd->portcntrnames;
+		return dd->portcntrnameslen;
+	}
+
+	read_counters(dd, shared_port_cntrs, SHARED_PORT_CNTR_LAST,
+		      ppd, ppd->cntrs);
+	read_counters(dd, dd->params->chip_port_cntrs,
+		      dd->params->chip_num_port_cntrs,
+		      ppd, ppd->cntrs);
+
+	*cntrp = ppd->cntrs;
+	return dd->nportcntrs * sizeof(u64);
+}
+
+static void free_cntrs(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int i;
+
+	if (dd->synth_stats_timer.function)
+		timer_delete_sync(&dd->synth_stats_timer);
+	if (dd->rcverr_timer.function)
+		timer_delete_sync(&dd->rcverr_timer);
+	cancel_work_sync(&dd->update_cntr_work);
+	cancel_work_sync(&dd->rcverr_work);
+	ppd = (struct hfi2_pportdata *)(dd + 1);
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		kfree(ppd->cntrs);
+		kfree(ppd->scntrs);
+		free_percpu(ppd->ibport_data.rvp.rc_acks);
+		free_percpu(ppd->ibport_data.rvp.rc_qacks);
+		free_percpu(ppd->ibport_data.rvp.rc_delayed_comp);
+		ppd->cntrs = NULL;
+		ppd->scntrs = NULL;
+		ppd->ibport_data.rvp.rc_acks = NULL;
+		ppd->ibport_data.rvp.rc_qacks = NULL;
+		ppd->ibport_data.rvp.rc_delayed_comp = NULL;
+	}
+	kfree(dd->portcntrnames);
+	dd->portcntrnames = NULL;
+	kfree(dd->cntrs);
+	dd->cntrs = NULL;
+	kfree(dd->scntrs);
+	dd->scntrs = NULL;
+	kfree(dd->cntrnames);
+	dd->cntrnames = NULL;
+	if (dd->update_cntr_wq) {
+		destroy_workqueue(dd->update_cntr_wq);
+		dd->update_cntr_wq = NULL;
+	}
+}
+
+static u64 read_dev_port_cntr(struct hfi2_devdata *dd, struct cntr_entry *entry,
+			      u64 *psval, void *context, int vl)
+{
+	u64 val;
+	u64 sval = *psval;
+
+	if (entry->flags & CNTR_DISABLED) {
+		dd_dev_err(dd, "Counter %s not enabled", entry->name);
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "cntr: %s vl %d psval 0x%llx", entry->name, vl, *psval);
+
+	val = entry->rw_cntr(entry, context, vl, CNTR_MODE_R, 0);
+
+	/* If its a synthetic counter there is more work we need to do */
+	if (entry->flags & CNTR_SYNTH) {
+		if (sval == CNTR_MAX) {
+			/* No need to read already saturated */
+			return CNTR_MAX;
+		}
+
+		if (entry->flags & CNTR_32BIT) {
+			/* 32bit counters can wrap multiple times */
+			u64 upper = sval >> 32;
+			u64 lower = (sval << 32) >> 32;
+
+			if (lower > val) { /* hw wrapped */
+				if (upper == CNTR_32BIT_MAX)
+					val = CNTR_MAX;
+				else
+					upper++;
+			}
+
+			if (val != CNTR_MAX)
+				val = (upper << 32) | val;
+
+		} else {
+			/* If we rolled we are saturated */
+			if ((val < sval) || (val > CNTR_MAX))
+				val = CNTR_MAX;
+		}
+	}
+
+	*psval = val;
+
+	hfi2_cdbg(CNTR, "\tNew val=0x%llx", val);
+
+	return val;
+}
+
+static u64 write_dev_port_cntr(struct hfi2_devdata *dd,
+			       struct cntr_entry *entry,
+			       u64 *psval, void *context, int vl, u64 data)
+{
+	u64 val;
+
+	if (entry->flags & CNTR_DISABLED) {
+		dd_dev_err(dd, "Counter %s not enabled", entry->name);
+		return 0;
+	}
+
+	hfi2_cdbg(CNTR, "cntr: %s vl %d psval 0x%llx", entry->name, vl, *psval);
+
+	if (entry->flags & CNTR_SYNTH) {
+		*psval = data;
+		if (entry->flags & CNTR_32BIT) {
+			val = entry->rw_cntr(entry, context, vl, CNTR_MODE_W,
+					     (data << 32) >> 32);
+			val = data; /* return the full 64bit value */
+		} else {
+			val = entry->rw_cntr(entry, context, vl, CNTR_MODE_W,
+					     data);
+		}
+	} else {
+		val = entry->rw_cntr(entry, context, vl, CNTR_MODE_W, data);
+	}
+
+	*psval = val;
+
+	hfi2_cdbg(CNTR, "\tNew val=0x%llx", val);
+
+	return val;
+}
+
+u64 read_dev_cntr(struct hfi2_devdata *dd, int index, int vl)
+{
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	if (index < SHARED_DEV_CNTR_LAST) {
+		entry = &shared_dev_cntrs[index];
+	} else {
+		index -= dd->params->chip_dev_cntr_first;
+		if (index < 0 || index >= dd->params->chip_num_dev_cntrs) {
+			dd_dev_err(dd, "%s: invalid dev counter index 0x%x\n",
+				   __func__,
+				   index + dd->params->chip_dev_cntr_first);
+			return 0;
+		}
+		entry = &dd->params->chip_dev_cntrs[index];
+	}
+	sval = dd->scntrs + entry->offset;
+
+	if (vl != CNTR_INVALID_VL)
+		sval += vl;
+
+	return read_dev_port_cntr(dd, entry, sval, dd, vl);
+}
+
+u64 write_dev_cntr(struct hfi2_devdata *dd, int index, int vl, u64 data)
+{
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	if (index < SHARED_DEV_CNTR_LAST) {
+		entry = &shared_dev_cntrs[index];
+	} else {
+		index -= dd->params->chip_dev_cntr_first;
+		if (index < 0 || index >= dd->params->chip_num_dev_cntrs) {
+			dd_dev_err(dd, "%s: invalid dev counter index 0x%x\n",
+				   __func__,
+				   index + dd->params->chip_dev_cntr_first);
+			return 0;
+		}
+		entry = &dd->params->chip_dev_cntrs[index];
+	}
+	sval = dd->scntrs + entry->offset;
+
+	if (vl != CNTR_INVALID_VL)
+		sval += vl;
+
+	return write_dev_port_cntr(dd, entry, sval, dd, vl, data);
+}
+
+/* return the counter entry for the given index, or NULL if invalid */
+static struct cntr_entry *get_port_entry(struct hfi2_devdata *dd,
+					 int index, const char *caller)
+{
+	if (index < SHARED_PORT_CNTR_LAST)
+		return &shared_port_cntrs[index];
+
+	index -= dd->params->chip_port_cntr_first;
+	if (index < 0 || index >= dd->params->chip_num_port_cntrs) {
+		dd_dev_err(dd, "%s: invalid port counter index 0x%x\n",
+			   caller,
+			   index + dd->params->chip_port_cntr_first);
+		return NULL;
+	}
+	return &dd->params->chip_port_cntrs[index];
+}
+
+/*
+ * Counters may be indexed by vl or (indirectly) context number.
+ *
+ * Return the actual index for this counter, as determined by parameter
+ * in_index and counter type.
+ */
+static int get_port_entry_index(struct hfi2_devdata *dd,
+				struct cntr_entry *entry,
+				int in_index)
+{
+	int out_index = 0;
+
+	if (entry->flags & CNTR_OVF) {
+		if (in_index >= 0 && in_index < dd->num_rcd) {
+			/* vl is really a context # */
+			out_index = dd->ovf_offset[in_index];
+		} else {
+			dd_dev_err(dd, "bad ovl ctxt %d\n", in_index);
+		}
+	} else {
+		if (in_index != CNTR_INVALID_VL)
+			out_index = in_index;
+	}
+	return out_index;
+}
+
+u64 read_port_cntr(struct hfi2_pportdata *ppd, int index, int vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	entry = get_port_entry(dd, index, __func__);
+	if (!entry)
+		return 0;
+	sval = ppd->scntrs + entry->offset;
+
+	sval += get_port_entry_index(dd, entry, vl);
+
+	if (entry->flags & CNTR_DISABLED) {
+		/* skip disabled contexts */
+		return 0;
+	}
+
+	return read_dev_port_cntr(dd, entry, sval, ppd, vl);
+}
+
+u64 write_port_cntr(struct hfi2_pportdata *ppd, int index, int vl, u64 data)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct cntr_entry *entry;
+	u64 *sval;
+
+	entry = get_port_entry(dd, index, __func__);
+	if (!entry)
+		return 0;
+	sval = ppd->scntrs + entry->offset;
+
+	sval += get_port_entry_index(dd, entry, vl);
+
+	if (entry->flags & CNTR_DISABLED) {
+		/* skip disabled contexts */
+		return 0;
+	}
+
+	return write_dev_port_cntr(dd, entry, sval, ppd, vl, data);
+}
+
+/*
+ * Perform a WFR specific check on whether to update synthetic counters.
+ */
+bool wfr_check_synth_status(struct hfi2_devdata *dd)
+{
+	struct wfr_synth_data *sd = &dd->synth_data.wfr;
+	u64 cur_tx;
+	u64 cur_rx;
+	u64 total_flits;
+	bool update = false;
+
+	/*
+	 * Rather than keep beating on the CSRs pick a minimal set that we can
+	 * check to watch for potential roll over. We can do this by looking at
+	 * the number of flits sent/recv. If the total flits exceeds 32bits then
+	 * we have to iterate all the counters and update.
+	 */
+	cur_rx = read_dev_cntr(dd, C_DC_RCV_FLITS, CNTR_INVALID_VL);
+	cur_tx = read_dev_cntr(dd, C_DC_XMIT_FLITS, CNTR_INVALID_VL);
+
+	hfi2_cdbg(CNTR,
+		  "[%d] curr tx=0x%llx rx=0x%llx :: last tx=0x%llx rx=0x%llx",
+		  dd->unit, cur_tx, cur_rx, sd->last_tx, sd->last_rx);
+
+	if ((cur_tx < sd->last_tx) || (cur_rx < sd->last_rx)) {
+		/*
+		 * May not be strictly necessary to update but it won't hurt and
+		 * simplifies the logic here.
+		 */
+		update = true;
+		hfi2_cdbg(CNTR, "[%d] Tripwire counter rolled, updating",
+			  dd->unit);
+	} else {
+		total_flits = (cur_tx - sd->last_tx) + (cur_rx - sd->last_rx);
+		hfi2_cdbg(CNTR,
+			  "[%d] total flits 0x%llx limit 0x%llx", dd->unit,
+			  total_flits, (u64)CNTR_32BIT_MAX);
+		if (total_flits >= CNTR_32BIT_MAX) {
+			hfi2_cdbg(CNTR, "[%d] 32bit limit hit, updating",
+				  dd->unit);
+			update = true;
+		}
+	}
+
+	return update;
+}
+
+void wfr_update_synth_status(struct hfi2_devdata *dd)
+{
+	struct wfr_synth_data *sd = &dd->synth_data.wfr;
+
+	/*
+	 * We want the value in the register. The goal is to keep track
+	 * of the number of "ticks" not the counter value. In other
+	 * words if the register rolls we want to notice it and go ahead
+	 * and force an update.
+	 */
+	sd->last_tx = read_dev_cntr(dd, C_DC_XMIT_FLITS, CNTR_INVALID_VL);
+	sd->last_rx = read_dev_cntr(dd, C_DC_RCV_FLITS, CNTR_INVALID_VL);
+
+	hfi2_cdbg(CNTR, "[%d] setting last tx/rx to 0x%llx 0x%llx",
+		  dd->unit, sd->last_tx, sd->last_rx);
+}
+
+static void do_update_synth_timer(struct work_struct *work)
+{
+	bool update;
+	int i;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_devdata *dd = container_of(work, struct hfi2_devdata,
+					       update_cntr_work);
+
+	update = dd->params->check_synth_status(dd);
+
+	if (update) {
+		hfi2_cdbg(CNTR, "[%d] Updating dd and ppd counters", dd->unit);
+		read_counters(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+			      dd, dd->scntrs);
+		read_counters(dd, dd->params->chip_dev_cntrs,
+			      dd->params->chip_num_dev_cntrs,
+			      dd, dd->scntrs);
+		ppd = (struct hfi2_pportdata *)(dd + 1);
+		for (i = 0; i < dd->num_pports; i++, ppd++) {
+			read_counters(dd, shared_port_cntrs,
+				      SHARED_PORT_CNTR_LAST,
+				      ppd, ppd->scntrs);
+			read_counters(dd, dd->params->chip_port_cntrs,
+				      dd->params->chip_num_port_cntrs,
+				      ppd, ppd->scntrs);
+		}
+		dd->params->update_synth_status(dd);
+	} else {
+		hfi2_cdbg(CNTR, "[%d] No update necessary", dd->unit);
+	}
+}
+
+static void update_synth_timer(struct timer_list *t)
+{
+	struct hfi2_devdata *dd = from_timer(dd, t, synth_stats_timer);
+
+	queue_work(dd->update_cntr_wq, &dd->update_cntr_work);
+	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
+}
+
+static const char bit_type_32[] = ",32";
+static const int bit_type_32_sz = 3;
+#define C_MAX_NAME 16 /* 15 chars + one for /0 */
+
+/*
+ * Calculate and return the indexed name size.  Keep in sync with
+ * copy_indexed_name().
+ */
+static size_t size_indexed_name(const char *raw_name, int flags, int idx)
+{
+	char name[C_MAX_NAME];
+	size_t sz;
+
+	snprintf(name, C_MAX_NAME, "%s%d", raw_name, idx);
+	/* +1 for newline */
+	sz = strlen(name) + 1;
+	/* add ",32" for 32-bit counters */
+	if (flags & CNTR_32BIT)
+		sz += bit_type_32_sz;
+
+	return sz;
+}
+
+/*
+ * Copy indexed name into p.  Advance and return p.  Keep in sync with
+ * size_indexed_name().
+ */
+static char *copy_indexed_name(char *p, const char *raw_name, int flags,
+				int idx)
+{
+	char name[C_MAX_NAME];
+
+	snprintf(name, C_MAX_NAME, "%s%d", raw_name, idx);
+	memcpy(p, name, strlen(name));
+	p += strlen(name);
+	/* counter is 32 bits */
+	if (flags & CNTR_32BIT) {
+		memcpy(p, bit_type_32, bit_type_32_sz);
+		p += bit_type_32_sz;
+	}
+	*p++ = '\n';
+
+	return p;
+}
+
+/*
+ * Calculate and return the single name size.  Keep in sync with
+ * copy_single_name().
+ */
+static size_t size_single_name(const char *raw_name, int flags)
+{
+	size_t sz;
+
+	/* +1 for newline */
+	sz = strlen(raw_name) + 1;
+	/* add ",32" for 32-bit counters */
+	if (flags & CNTR_32BIT)
+		sz += bit_type_32_sz;
+
+	return sz;
+}
+
+/*
+ * Copy single name into p.  Advance and return p.  Keep in sync with
+ * size_single_name().
+ */
+static char *copy_single_name(char *p, const char *raw_name, int flags)
+{
+	memcpy(p, raw_name, strlen(raw_name));
+	p += strlen(raw_name);
+	/* counter is 32 bits */
+	if (flags & CNTR_32BIT) {
+		memcpy(p, bit_type_32, bit_type_32_sz);
+		p += bit_type_32_sz;
+	}
+	*p++ = '\n';
+
+	return p;
+}
+
+/*
+ * Walk through the table, increasing the calculated number of counters and
+ * name size.
+ */
+static void size_cntr_names(struct hfi2_devdata *dd,
+			   struct cntr_entry *table, int table_size,
+			   size_t *countp, size_t *szp)
+{
+	u32 sdma_engines = chip_sdma_engines(dd);
+	u32 num_rcv = chip_rcv_contexts(dd);
+	size_t count;
+	size_t sz;
+	int i, j;
+	u8 ovf_offset;
+
+	count = *countp;	/* need current count */
+	sz = 0;
+	ovf_offset = 0;
+	for (i = 0; i < table_size; i++) {
+		if (table[i].flags & CNTR_DISABLED) {
+			hfi2_dbg_early("\tSkipping %s\n", table[i].name);
+			continue;
+		}
+
+		table[i].offset = count;
+		if (table[i].flags & CNTR_VL) {
+			for (j = 0; j < C_VL_COUNT; j++) {
+				sz += size_indexed_name(table[i].name,
+							table[i].flags,
+							vl_from_idx(j));
+				count++;
+			}
+		} else if (table[i].flags & CNTR_SDMA) {
+			for (j = 0; j < sdma_engines; j++) {
+				sz += size_indexed_name(table[i].name,
+							table[i].flags,
+							j);
+				count++;
+			}
+		} else if (table[i].flags & CNTR_OVF) {
+			for (j = 0; j < num_rcv; j++) {
+				if (test_bit(j, dd->ovf_disabled))
+					continue;
+				dd->ovf_offset[j] = ovf_offset;
+				sz += size_indexed_name(table[i].name,
+							table[i].flags,
+							j);
+				count++;
+				ovf_offset++;
+			}
+		} else {
+			sz += size_single_name(table[i].name, table[i].flags);
+			count++;
+		}
+	}
+
+	/* return updated sizes */
+	*countp = count;
+	*szp += sz;
+}
+
+/*
+ * Fill the counter names into p.  Return p's final value.
+ */
+static char *fill_cntr_names(struct hfi2_devdata *dd,
+			     struct cntr_entry *table, int table_size, char *p)
+{
+	u32 sdma_engines = chip_sdma_engines(dd);
+	u32 num_rcv = chip_rcv_contexts(dd);
+	int i, j;
+
+	for (i = 0; i < table_size; i++) {
+		if (table[i].flags & CNTR_DISABLED) {
+			/* Nothing */
+		} else if (table[i].flags & CNTR_VL) {
+			for (j = 0; j < C_VL_COUNT; j++) {
+				p = copy_indexed_name(p, table[i].name,
+						      table[i].flags,
+						      vl_from_idx(j));
+			}
+		} else if (table[i].flags & CNTR_SDMA) {
+			for (j = 0; j < sdma_engines; j++) {
+				p = copy_indexed_name(p, table[i].name,
+						      table[i].flags,
+						      j);
+			}
+		} else if (table[i].flags & CNTR_OVF) {
+			for (j = 0; j < num_rcv; j++) {
+				if (test_bit(j, dd->ovf_disabled))
+					continue;
+				p = copy_indexed_name(p, table[i].name,
+						      table[i].flags,
+						      j);
+			}
+		} else {
+			p = copy_single_name(p, table[i].name, table[i].flags);
+		}
+	}
+
+	return p;
+}
+
+static int init_cntrs(struct hfi2_devdata *dd)
+{
+	int i, j;
+	size_t sz;
+	struct hfi2_pportdata *ppd;
+	char *p;
+
+	/* set up the stats timers; the add_timer calls are done at the end */
+	timer_setup(&dd->synth_stats_timer, update_synth_timer, 0);
+	timer_setup(&dd->rcverr_timer, update_rcverr_timer, 0);
+	/* Assume the hardware counter has been reset */
+	for (i = 0; i < dd->num_pports; i++)
+		dd->pport[i].rcv_ovfl_cnt = 0;
+
+	/***********************/
+	/* per device counters */
+	/***********************/
+
+	/* size names and determine how many we have */
+	dd->ndevcntrs = 0;
+	sz = 0;
+	size_cntr_names(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+			&dd->ndevcntrs, &sz);
+	size_cntr_names(dd, dd->params->chip_dev_cntrs,
+			dd->params->chip_num_dev_cntrs,
+			&dd->ndevcntrs, &sz);
+
+	/* allocate space for the counter values */
+	dd->cntrs = kcalloc(dd->ndevcntrs + num_driver_cntrs, sizeof(u64),
+			    GFP_KERNEL);
+	if (!dd->cntrs)
+		goto bail;
+
+	dd->scntrs = kcalloc(dd->ndevcntrs, sizeof(u64), GFP_KERNEL);
+	if (!dd->scntrs)
+		goto bail;
+
+	/* allocate space for the counter names */
+	dd->cntrnameslen = sz;
+	dd->cntrnames = kmalloc(sz, GFP_KERNEL);
+	if (!dd->cntrnames)
+		goto bail;
+
+	/* fill in the names */
+	p = fill_cntr_names(dd, shared_dev_cntrs, SHARED_DEV_CNTR_LAST,
+			    dd->cntrnames);
+	fill_cntr_names(dd, dd->params->chip_dev_cntrs,
+			dd->params->chip_num_dev_cntrs, p);
+
+	/*********************/
+	/* per port counters */
+	/*********************/
+
+	/*
+	 * Go through the counters for the overflows and disable the ones we
+	 * don't need. This varies based on platform so we need to do it
+	 * dynamically here.
+	 */
+	bitmap_fill(dd->ovf_disabled, MAX_CTXTS);
+	for (i = 0; i < dd->num_pports; i++) {
+		for (j = 0; j < dd->pport[i].num_rcv_contexts; j++) {
+			u16 ctxt = dd->pport[i].rcv_context_base + j;
+
+			clear_bit(ctxt, dd->ovf_disabled);
+		}
+	}
+
+	/* size port counter names and determine how many we have */
+	dd->nportcntrs = 0;
+	sz = 0;
+	size_cntr_names(dd, shared_port_cntrs, SHARED_PORT_CNTR_LAST,
+			&dd->nportcntrs, &sz);
+	size_cntr_names(dd, dd->params->chip_port_cntrs,
+			dd->params->chip_num_port_cntrs,
+			&dd->nportcntrs, &sz);
+
+	/* allocate space for the counter names */
+	dd->portcntrnameslen = sz;
+	dd->portcntrnames = kmalloc(sz, GFP_KERNEL);
+	if (!dd->portcntrnames)
+		goto bail;
+
+	/* fill in port cntr names */
+	p = fill_cntr_names(dd, shared_port_cntrs, SHARED_PORT_CNTR_LAST,
+			    dd->portcntrnames);
+	fill_cntr_names(dd, dd->params->chip_port_cntrs,
+			dd->params->chip_num_port_cntrs, p);
+
+	/* allocate per port storage for counter values */
+	ppd = (struct hfi2_pportdata *)(dd + 1);
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		ppd->cntrs = kcalloc(dd->nportcntrs, sizeof(u64), GFP_KERNEL);
+		if (!ppd->cntrs)
+			goto bail;
+
+		ppd->scntrs = kcalloc(dd->nportcntrs, sizeof(u64), GFP_KERNEL);
+		if (!ppd->scntrs)
+			goto bail;
+	}
+
+	/* CPU counters need to be allocated and zeroed */
+	if (init_cpu_counters(dd))
+		goto bail;
+
+	dd->update_cntr_wq = alloc_ordered_workqueue("hfi2_update_cntr_%d",
+						     WQ_MEM_RECLAIM, dd->unit);
+	if (!dd->update_cntr_wq)
+		goto bail;
+
+	INIT_WORK(&dd->update_cntr_work, do_update_synth_timer);
+	INIT_WORK(&dd->rcverr_work, do_rcverr_timer);
+
+	mod_timer(&dd->synth_stats_timer, jiffies + HZ * SYNTH_CNT_TIME);
+	mod_timer(&dd->rcverr_timer, jiffies + HZ * RCVERR_CHECK_TIME);
+	return 0;
+bail:
+	free_cntrs(dd);
+	return -ENOMEM;
+}
+
+static u32 chip_to_opa_lstate(struct hfi2_devdata *dd, u32 chip_lstate)
+{
+	switch (chip_lstate) {
+	case LSTATE_DOWN:
+		return IB_PORT_DOWN;
+	case LSTATE_INIT:
+		return IB_PORT_INIT;
+	case LSTATE_ARMED:
+		return IB_PORT_ARMED;
+	case LSTATE_ACTIVE:
+		return IB_PORT_ACTIVE;
+	default:
+		dd_dev_err(dd,
+			   "Unknown logical state 0x%x, reporting IB_PORT_DOWN\n",
+			   chip_lstate);
+		return IB_PORT_DOWN;
+	}
+}
+
+u32 chip_to_opa_pstate(struct hfi2_devdata *dd, u32 chip_pstate)
+{
+	/* look at the HFI meta-states only */
+	switch (chip_pstate & 0xf0) {
+	case PLS_DISABLED:
+		return IB_PORTPHYSSTATE_DISABLED;
+	case PLS_OFFLINE:
+		return OPA_PORTPHYSSTATE_OFFLINE;
+	case PLS_POLLING:
+		return IB_PORTPHYSSTATE_POLLING;
+	case PLS_CONFIGPHY:
+		return IB_PORTPHYSSTATE_TRAINING;
+	case PLS_LINKUP:
+		return IB_PORTPHYSSTATE_LINKUP;
+	case PLS_PHYTEST:
+		return IB_PORTPHYSSTATE_PHY_TEST;
+	default:
+		dd_dev_err(dd, "Unexpected chip physical state of 0x%x\n",
+			   chip_pstate);
+		return IB_PORTPHYSSTATE_DISABLED;
+	}
+}
+
+/* return the OPA port physical state name */
+const char *opa_pstate_name(u32 pstate)
+{
+	static const char * const port_physical_names[] = {
+		"PHYS_NOP",
+		"reserved1",
+		"PHYS_POLL",
+		"PHYS_DISABLED",
+		"PHYS_TRAINING",
+		"PHYS_LINKUP",
+		"PHYS_LINK_ERR_RECOVER",
+		"PHYS_PHY_TEST",
+		"reserved8",
+		"PHYS_OFFLINE",
+		"PHYS_GANGED",
+		"PHYS_TEST",
+	};
+	if (pstate < ARRAY_SIZE(port_physical_names))
+		return port_physical_names[pstate];
+	return "unknown";
+}
+
+/**
+ * update_statusp - Update userspace status flag
+ * @ppd: Port data structure
+ * @state: port state information
+ *
+ * Actual port status is determined by the host_link_state value
+ * in the ppd.
+ *
+ * host_link_state MUST be updated before updating the user space
+ * statusp.
+ */
+void update_statusp(struct hfi2_pportdata *ppd, u32 state)
+{
+	/*
+	 * Set port status flags in the page mapped into userspace
+	 * memory. Do it here to ensure a reliable state - this is
+	 * the only function called by all state handling code.
+	 * Always set the flags due to the fact that the cache value
+	 * might have been changed explicitly outside of this
+	 * function.
+	 */
+	if (ppd->statusp) {
+		switch (state) {
+		case IB_PORT_DOWN:
+		case IB_PORT_INIT:
+			*ppd->statusp &= ~(HFI2_STATUS_IB_CONF |
+					   HFI2_STATUS_IB_READY);
+			break;
+		case IB_PORT_ARMED:
+			*ppd->statusp |= HFI2_STATUS_IB_CONF;
+			break;
+		case IB_PORT_ACTIVE:
+			*ppd->statusp |= HFI2_STATUS_IB_READY;
+			break;
+		}
+	}
+}
+
+/**
+ * wait_logical_linkstate - wait for an IB link state change to occur
+ * @ppd: port device
+ * @state: the state to wait for
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for IB link state change to occur.
+ * For now, take the easy polling route.
+ * Returns 0 if state reached, otherwise -ETIMEDOUT.
+ */
+static int wait_logical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				  int msecs)
+{
+	unsigned long timeout;
+	u32 new_state;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		new_state = chip_to_opa_lstate(ppd->dd,
+					       read_logical_state(ppd->dd));
+		if (new_state == state)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				   "timeout waiting for link state 0x%x\n",
+				   state);
+			return -ETIMEDOUT;
+		}
+		msleep(20);
+	}
+
+	return 0;
+}
+
+void log_state_transition(struct hfi2_pportdata *ppd, u32 state)
+{
+	u32 ib_pstate = chip_to_opa_pstate(ppd->dd, state);
+
+	ppd_dev_info(ppd,
+		     "physical state changed to %s (0x%x), phy 0x%x\n",
+		     opa_pstate_name(ib_pstate), ib_pstate, state);
+}
+
+/*
+ * Read the physical hardware link state and check if it matches host
+ * drivers anticipated state.
+ */
+static void log_physical_state(struct hfi2_pportdata *ppd, u32 state)
+{
+	u32 read_state = read_physical_state(ppd->dd);
+
+	if (read_state == state) {
+		log_state_transition(ppd, state);
+	} else {
+		ppd_dev_err(ppd,
+			   "anticipated phy link state 0x%x, read 0x%x\n",
+			   state, read_state);
+	}
+}
+
+/*
+ * wait_physical_linkstate - wait for an physical link state change to occur
+ * @ppd: port device
+ * @state: the state to wait for
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for physical link state change to occur.
+ * Returns 0 if state reached, otherwise -ETIMEDOUT.
+ */
+static int wait_physical_linkstate(struct hfi2_pportdata *ppd, u32 state,
+				   int msecs)
+{
+	u32 read_state;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		read_state = read_physical_state(ppd->dd);
+		if (read_state == state)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				    "timeout waiting for phy link state 0x%x\n",
+				    state);
+			return -ETIMEDOUT;
+		}
+		usleep_range(1950, 2050); /* sleep 2ms-ish */
+	}
+
+	log_state_transition(ppd, state);
+	return 0;
+}
+
+/*
+ * wait_phys_link_offline_quiet_substates - wait for any offline substate
+ * @ppd: port device
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for any offline physical link
+ * state change to occur.
+ * Returns 0 if at least one state is reached, otherwise -ETIMEDOUT.
+ */
+static int wait_phys_link_offline_substates(struct hfi2_pportdata *ppd,
+					    int msecs)
+{
+	u32 read_state;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		read_state = read_physical_state(ppd->dd);
+		if ((read_state & 0xF0) == PLS_OFFLINE)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				    "timeout waiting for phy link offline.quiet substates. Read state 0x%x, %dms\n",
+				    read_state, msecs);
+			return -ETIMEDOUT;
+		}
+		usleep_range(1950, 2050); /* sleep 2ms-ish */
+	}
+
+	log_state_transition(ppd, read_state);
+	return read_state;
+}
+
+/*
+ * wait_phys_link_out_of_offline - wait for any out of offline state
+ * @ppd: port device
+ * @msecs: the number of milliseconds to wait
+ *
+ * Wait up to msecs milliseconds for any out of offline physical link
+ * state change to occur.
+ * Returns 0 if at least one state is reached, otherwise -ETIMEDOUT.
+ */
+static int wait_phys_link_out_of_offline(struct hfi2_pportdata *ppd,
+					 int msecs)
+{
+	u32 read_state;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(msecs);
+	while (1) {
+		read_state = read_physical_state(ppd->dd);
+		if ((read_state & 0xF0) != PLS_OFFLINE)
+			break;
+		if (time_after(jiffies, timeout)) {
+			ppd_dev_err(ppd,
+				    "timeout waiting for phy link out of offline. Read state 0x%x, %dms\n",
+				    read_state, msecs);
+			return -ETIMEDOUT;
+		}
+		usleep_range(1950, 2050); /* sleep 2ms-ish */
+	}
+
+	log_state_transition(ppd, read_state);
+	return read_state;
+}
+
+void hfi2_init_ctxt(struct send_context *sc)
+{
+	if (sc) {
+		sc->dd->params->set_pio_integrity(sc, SPI_INIT);
+	}
+}
+
+int hfi2_tempsense_rd(struct hfi2_devdata *dd, struct hfi2_temp *temp)
+{
+	int ret = 0;
+	u64 reg;
+
+	if (dd->icode != ICODE_RTL_SILICON) {
+		if (HFI2_CAP_IS_KSET(PRINT_UNIMPL))
+			dd_dev_info(dd, "%s: tempsense not supported by HW\n",
+				    __func__);
+		return -EINVAL;
+	}
+
+	if (dd->params->chip_type == CHIP_JKR) {
+		dd_dev_info(dd, "%s: tempsense not implemented for JKR\n",
+			    __func__);
+		return -EINVAL;
+	}
+
+	reg = read_csr(dd, ASIC_STS_THERM);
+	temp->curr = ((reg >> ASIC_STS_THERM_CURR_TEMP_SHIFT) &
+		      ASIC_STS_THERM_CURR_TEMP_MASK);
+	temp->lo_lim = ((reg >> ASIC_STS_THERM_LO_TEMP_SHIFT) &
+			ASIC_STS_THERM_LO_TEMP_MASK);
+	temp->hi_lim = ((reg >> ASIC_STS_THERM_HI_TEMP_SHIFT) &
+			ASIC_STS_THERM_HI_TEMP_MASK);
+	temp->crit_lim = ((reg >> ASIC_STS_THERM_CRIT_TEMP_SHIFT) &
+			  ASIC_STS_THERM_CRIT_TEMP_MASK);
+	/* triggers is a 3-bit value - 1 bit per trigger. */
+	temp->triggers = (u8)((reg >> ASIC_STS_THERM_LOW_SHIFT) & 0x7);
+
+	return ret;
+}
+
+/* ========================================================================= */
+
+/**
+ * read_mod_write() - Calculate the IRQ register index and set/clear the bits
+ * @dd: valid devdata
+ * @src: IRQ source to determine register index from
+ * @bits: the bits to set or clear
+ * @set: true == set the bits, false == clear the bits
+ *
+ */
+static void read_mod_write(struct hfi2_devdata *dd, u16 src, u64 bits,
+			   bool set)
+{
+	u64 reg;
+	u16 idx = src / BITS_PER_REGISTER;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dd->irq_src_lock, flags);
+	reg = read_csr(dd, CCE_INT_MASK + (8 * idx));
+	if (set) {
+		reg |= bits;
+		dd->gi_mask[idx].cce_int_mask |= bits;
+	} else {
+		reg &= ~bits;
+		dd->gi_mask[idx].cce_int_mask &= ~bits;
+	}
+	write_csr(dd, CCE_INT_MASK + (8 * idx), reg);
+	spin_unlock_irqrestore(&dd->irq_src_lock, flags);
+}
+
+/**
+ * set_intr_bits() - Enable/disable a range (one or more) IRQ sources
+ * @dd: valid devdata
+ * @first: first IRQ source to set/clear
+ * @last: last IRQ source (inclusive) to set/clear
+ * @set: true == set the bits, false == clear the bits
+ *
+ * If first == last, set the exact source.
+ */
+int set_intr_bits(struct hfi2_devdata *dd, u16 first, u16 last, bool set)
+{
+	u64 bits = 0;
+	u64 bit;
+	u16 src;
+
+	if (last > dd->params->is_last_source)
+		return -EINVAL;
+	if (last < first)
+		return -ERANGE;
+
+	for (src = first; src <= last; src++) {
+		bit = src % BITS_PER_REGISTER;
+		/* wrapped to next register? */
+		if (!bit && bits) {
+			read_mod_write(dd, src - 1, bits, set);
+			bits = 0;
+		}
+		bits |= BIT_ULL(bit);
+	}
+	read_mod_write(dd, last, bits, set);
+
+	return 0;
+}
+
+/*
+ * Clear all interrupt sources on the chip.
+ */
+static void clear_all_interrupts(struct hfi2_devdata *dd)
+{
+	int i;
+
+	for (i = 0; i < dd->params->num_int_csrs; i++)
+		write_csr(dd, CCE_INT_CLEAR + (8 * i), ~(u64)0);
+
+	write_csr(dd, dd->params->csr_err_clear_reg, ~(u64)0);
+	write_csr(dd, dd->params->send_pio_err_clear_reg, ~(u64)0);
+	write_csr(dd, dd->params->send_dma_err_clear_reg, ~(u64)0);
+	for (i = dd->first_send_context; i < chip_send_contexts(dd); i++)
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_clear_reg, ~(u64)0);
+	for (i = 0; i < chip_sdma_engines(dd); i++)
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_clear_reg, ~(u64)0);
+
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* CPORT is initializing these */
+		write_csr(dd, CCE_ERR_CLEAR, ~(u64)0);
+		for (i = 0; i < dd->num_pports; i++) {
+			write_iport_csr(dd, i, dd->params->rcv_err_clear_reg, ~(u64)0);
+			write_eport_csr(dd, i, dd->params->send_egress_err_clear_reg, ~(u64)0);
+		}
+
+		/* only WFR has these blocks */
+		write_csr(dd, MISC_ERR_CLEAR, ~(u64)0);
+		write_csr(dd, DCC_ERR_FLG_CLR, ~(u64)0);
+		write_csr(dd, DC_LCB_ERR_CLR, ~(u64)0);
+		write_csr(dd, DC_DC8051_ERR_CLR, ~(u64)0);
+	}
+}
+
+/*
+ * Remap the interrupt source from the general handler to the given MSI-X
+ * interrupt.
+ */
+void remap_intr(struct hfi2_devdata *dd, int isrc, int msix_intr)
+{
+	u64 reg;
+	int m, n;
+
+	/* clear from the handled mask of the general interrupt */
+	m = isrc / 64;
+	n = isrc % 64;
+	if (likely(m < dd->params->num_int_csrs)) {
+		dd->gi_mask[m].remap &= ~((u64)1 << n);
+	} else {
+		dd_dev_err(dd, "remap interrupt err\n");
+		return;
+	}
+
+	/* direct the chip source to the given MSI-X interrupt */
+	m = isrc / 8;
+	n = isrc % 8;
+	reg = read_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * m));
+	reg &= ~((u64)0xff << (8 * n));
+	reg |= ((u64)msix_intr & 0xff) << (8 * n);
+	write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * m), reg);
+}
+
+void remap_sdma_interrupts(struct hfi2_devdata *dd, int engine, int msix_intr)
+{
+	/*
+	 * SDMA engine interrupt sources grouped by type, rather than
+	 * engine.  Per-engine interrupts are as follows:
+	 *	SDMA
+	 *	SDMAProgress
+	 *	SDMAIdle
+	 */
+	remap_intr(dd, dd->params->is_sdma_start + engine, msix_intr);
+	remap_intr(dd, dd->params->is_sdma_progress_start + engine, msix_intr);
+	remap_intr(dd, dd->params->is_sdma_idle_start + engine, msix_intr);
+}
+
+/*
+ * Set the general handler to accept all interrupts, remap all
+ * chip interrupts back to MSI-X 0.
+ */
+void reset_interrupts(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* all interrupts handled by the general handler */
+	for (i = 0; i < dd->params->num_int_csrs; i++) {
+		dd->gi_mask[i].remap = ~(u64)0;
+		dd->gi_mask[i].cce_int_mask = read_csr(dd, CCE_INT_MASK + (8 * i));
+	}
+
+	/* all chip interrupts map to MSI-X 0 */
+	for (i = 0; i < dd->params->num_int_map_csrs; i++)
+		write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * i), 0);
+}
+
+/**
+ * set_up_interrupts() - Initialize the IRQ resources and state
+ * @dd: valid devdata
+ *
+ */
+static int set_up_interrupts(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	/* mask all interrupts */
+	set_intr_bits(dd, 0, dd->params->is_last_source, false);
+
+	/* clear all pending interrupts */
+	clear_all_interrupts(dd);
+
+	/* reset general handler mask, chip MSI-X mappings */
+	reset_interrupts(dd);
+
+	/* ask for MSI-X interrupts */
+	ret = msix_initialize(dd);
+	if (ret)
+		return ret;
+
+	ret = msix_early_request_irqs(dd);
+	if (ret)
+		msix_clean_up_interrupts(dd);
+
+	return ret;
+}
+
+static int late_set_up_interrupts(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	ret = msix_request_irqs(dd);
+	if (ret)
+		msix_clean_up_interrupts(dd);
+
+	return ret;
+}
+
+/*
+ * Reduce the total per-port user receive context counts by the given amount.
+ *
+ * Return 0 if success, -EINVAL if there is not enough extra.
+ */
+static int reduce_ctxts(struct hfi2_devdata *dd, u32 *counts, int amount)
+{
+	const u32 count_min = 0; /* do not allow count to go below this value */
+	int pidx;
+
+	/* remove one at a time, round robin */
+	while (amount > 0) {
+		bool adjusted = false;
+
+		for (pidx = 0; pidx < dd->num_pports && amount > 0; pidx++) {
+			if (counts[pidx] > count_min) {
+				counts[pidx]--;
+				amount--;
+				adjusted = true;
+			}
+		}
+
+		if (!adjusted)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int reduce_rcv_ctxts(struct hfi2_devdata *dd, u32 *counts, int amount,
+			    const char *why)
+{
+	int ret = reduce_ctxts(dd, counts, amount);
+
+	if (ret) {
+		dd_dev_err(dd, "Cannot reduce user receive contexts requested by %d [%s]\n",
+			   amount, why);
+	}
+	return ret;
+}
+
+/* return true if the fabric is reachable on the card */
+/* this function does not range validate pidx */
+static bool hardware_pidx_available(struct hfi2_devdata *dd, int pidx)
+{
+	/* only need to check JKR */
+	if (dd->params->chip_type != CHIP_JKR)
+		return true;
+
+	/* dual port JKR has all ports available */
+	if (dd->pcidev->subsystem_device == PCI_SUBDEVICE_CN5000_DUAL_PORT)
+		return true;
+
+	/* single port JKR only has port 2 available */
+	return pidx == 1;
+}
+
+/*
+ * Decide how to divide resources between ports.  Resources include
+ * receive contexts, RSM table, RcvArray, and send contexts.
+ *
+ * User context resources may be asymmetric across ports.
+ *
+ * Receive contexts allocated in order at each port base:
+ *	Control context
+ *	Kernel contexts
+ *	Dynamic context pool (user and netdev)
+ *
+ * These fields are set:
+ *
+ * dd:
+ *   rcv_entries	  - details on RcvArray entries for each port
+ *   num_send_contexts	  - number of PIO send contexts being used
+ * ppd:
+ *   n_krcv_queues	  - number of kernel contexts for each port
+ *			      (includes control context)
+ *   num_netdev_contexts  - number of reserved netdev contexts for each port
+ *   num_rcv_contexts	  - number of contexts being used for this port
+ *   num_user_conexts	  - number of user contexts for this port
+ *   rcv_context_base	  - first context for this port
+ *   first_dyn_alloc_ctxt - first dynamically allocated (user) context for
+ *			      this port
+ *   freectxts		  - number of free user contexts for this port
+ *   rcv_array_base	  - first RcvArray entry for this port
+ */
+static int set_up_context_variables(struct hfi2_devdata *dd)
+{
+	u32 num_kernel_contexts[LARGEST_NUM_PORTS];
+	u32 num_netdev_contexts[LARGEST_NUM_PORTS];
+	u32 def_kernel_contexts;
+	u32 def_netdev_contexts;
+	int ret;
+	int pidx;
+	int base;
+	int rmt_count;
+	int rcv_pool_count;
+	int total_netdev;
+	int rcvarray_avail;
+	int max_eager_allowed;
+	int total_groups;
+	int over;
+	char *limited;
+	u32 total_rcv;
+	u32 n_usr_ctxts[LARGEST_NUM_PORTS];
+	u32 send_contexts = chip_send_contexts(dd) - dd->first_send_context;
+	u32 rcv_contexts = chip_rcv_contexts(dd) - dd->first_rcv_context;
+	bool recalculated = false;
+
+	/*
+	 * Calculate the default number of per-port kernel receive contexts.
+	 *
+	 * n_krcvqs is the sum of module parameter kernel receive contexts,
+	 * krcvqs[].  It does not include the control context, so add that.
+	 */
+	if (n_krcvqs)
+		def_kernel_contexts = n_krcvqs + 1;
+	else
+		def_kernel_contexts = DEFAULT_KRCVQS + 1;
+
+	def_netdev_contexts = hfi2_num_netdev_contexts(dd,
+						       HFI2_MAX_NETDEV_CTXTS,
+						       &node_affinity.real_cpu_mask);
+
+	/* obtain requested user context numbers from module parameters */
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		int count = get_num_user_contexts(dd, pidx);
+		/*
+		 * Per-port user contexts defaults to negative if unset in
+		 * the module parameter.
+		 * - unavailable ports always have zero user contexts no
+		 *   matter what the parameter says
+		 * - default to 1 user context per real (non-HT) CPU core
+		 */
+		if (!hardware_pidx_available(dd, pidx))
+			count = 0;
+		if (count < 0)
+			count = cpumask_weight(&node_affinity.real_cpu_mask);
+		n_usr_ctxts[pidx] = count;
+
+		/* no user contexts implies no port */
+		if (count == 0) {
+			num_kernel_contexts[pidx] = 0;
+			num_netdev_contexts[pidx] = 0;
+		} else {
+			num_kernel_contexts[pidx] = def_kernel_contexts;
+			num_netdev_contexts[pidx] = def_netdev_contexts;
+		}
+	}
+
+do_recalc:
+	/*
+	 * Adjust the counts given a global max.
+	 */
+	total_rcv = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		total_rcv += num_kernel_contexts[pidx] +
+			     num_netdev_contexts[pidx] +
+			     n_usr_ctxts[pidx];
+	}
+
+	if (rcv_contexts < total_rcv) {
+		over = total_rcv - rcv_contexts;
+		ret = reduce_rcv_ctxts(dd, n_usr_ctxts, over, "available receive contexts");
+		if (ret)
+			return -EINVAL;
+		/* total_rcv is no longer valid */
+	}
+
+	/*
+	 * RMT entries are allocated as follows:
+	 * 1. QOS (0 to 128 entries)
+	 * 2. FECN (num_kernel_context - 1 [a] + num_user_contexts +
+	 *          num_netdev_contexts [b])
+	 * 3. netdev (NUM_NETDEV_MAP_ENTRIES)
+	 *
+	 * Notes:
+	 * [a] Kernel contexts (except control) are included in FECN if kernel
+	 *     TID_RDMA is active.
+	 * [b] Netdev and user contexts are randomly allocated from the same
+	 *     context pool, so FECN must cover all contexts in the pool.
+	 */
+	rmt_count = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		/* no RMT used if port is not available */
+		if (num_kernel_contexts[pidx] == 0)
+			continue;
+		rmt_count += (HFI2_CAP_IS_KSET(TID_RDMA)
+					? (num_kernel_contexts[pidx] - 1) : 0)
+			     + n_usr_ctxts[pidx]
+			     + num_netdev_contexts[pidx]
+			     + NUM_NETDEV_MAP_ENTRIES
+			     + qos_rmt_entries(num_kernel_contexts[pidx] - 1, NULL, NULL);
+	}
+
+	if (rmt_count > NUM_MAP_ENTRIES) {
+		over = rmt_count - NUM_MAP_ENTRIES;
+		ret = reduce_rcv_ctxts(dd, n_usr_ctxts, over, "available RMT entries");
+		if (ret)
+			return -EINVAL;
+	}
+
+	/*
+	 * For each port, the first N are kernel contexts, the rest are
+	 * user/netdev contexts
+	 */
+
+	dd_dev_info(dd, "rcv contexts: avail %d\n", rcv_contexts);
+	base = dd->first_rcv_context;
+	total_rcv = 0; /* recalculate */
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_pportdata *ppd = &dd->pport[pidx];
+
+		ppd->n_krcv_queues = num_kernel_contexts[pidx];
+		ppd->num_netdev_contexts = num_netdev_contexts[pidx];
+		ppd->num_rcv_contexts = num_kernel_contexts[pidx] +
+					num_netdev_contexts[pidx] +
+					n_usr_ctxts[pidx];
+		ppd->num_user_contexts = n_usr_ctxts[pidx];
+		ppd->rcv_context_base = base;
+		ppd->freectxts = ppd->num_user_contexts;
+		ppd->first_dyn_alloc_ctxt = ppd->rcv_context_base
+					    + num_kernel_contexts[pidx];
+		dd_dev_info(dd,
+			    "  pidx[%d]: base %d, used %d (kernel %d, netdev %u, user %u)\n",
+			    pidx,
+			    ppd->rcv_context_base,
+			    ppd->num_rcv_contexts,
+			    ppd->n_krcv_queues,
+			    ppd->num_netdev_contexts,
+			    ppd->num_user_contexts);
+
+		base += ppd->num_rcv_contexts;
+		total_rcv += ppd->num_rcv_contexts;
+	}
+
+	/*
+	 * Receive array allocation:
+	 *   Avoid first N RcvArray entries.
+	 *
+	 *   All RcvArray entries are divided into groups of 8. This
+	 *   is required by the hardware and will speed up writes to
+	 *   consecutive entries by using write-combining of the entire
+	 *   cacheline.
+	 *
+	 *   The number of groups are evenly divided among all contexts.
+	 */
+	dd->rcv_entries.group_size = RCV_INCREMENT;
+	rcvarray_avail = chip_rcv_array_count(dd) - dd->first_rcvarray_entry;
+	total_groups = rcvarray_avail / dd->rcv_entries.group_size;
+	if (total_rcv)
+		dd->rcv_entries.ngroups = total_groups / total_rcv;
+	else
+		dd->rcv_entries.ngroups = 0; /* alternate: total_groups */
+	max_eager_allowed = dd->params->max_eager_entries * 2;
+	if (dd->rcv_entries.ngroups * dd->rcv_entries.group_size >
+	    max_eager_allowed) {
+		dd->rcv_entries.ngroups = max_eager_allowed /
+					  dd->rcv_entries.group_size;
+		limited = " (limited by max eager entries)";
+	} else {
+		limited = "";
+	}
+	dd_dev_info(dd, "RcvArray per-context groups %u%s, unused groups %u\n",
+		    dd->rcv_entries.ngroups,
+		    limited,
+		    total_groups - (dd->rcv_entries.ngroups * total_rcv));
+
+	base = dd->first_rcvarray_entry;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_pportdata *ppd = &dd->pport[pidx];
+
+		ppd->rcv_array_base = base;
+		base += ppd->num_rcv_contexts * dd->rcv_entries.ngroups;
+	}
+
+	/*
+	 * PIO send contexts
+	 */
+	ret = init_sc_pools_and_sizes(dd);
+	if (ret < 0)
+		return ret;
+	dd->num_send_contexts = ret;
+
+	dd_dev_info(dd,
+		    "send contexts: avail %d, used %d (kernel %d, ack %d, user %d, vl15 %d)\n",
+		    send_contexts,
+		    dd->num_send_contexts,
+		    dd->sc_sizes[SC_KERNEL].count,
+		    dd->sc_sizes[SC_ACK].count,
+		    dd->sc_sizes[SC_USER].count,
+		    dd->sc_sizes[SC_VL15].count);
+
+	/*
+	 * There may be less PIO user send contexts available than user
+	 * receive contexts.  If so, reduce the requested user receive
+	 * context count and go back to re-calculate the resources.
+	 */
+	rcv_pool_count = 0;
+	total_netdev = 0;
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_pportdata *ppd = &dd->pport[pidx];
+
+		rcv_pool_count += ppd->num_netdev_contexts + ppd->num_user_contexts;
+		total_netdev += ppd->num_netdev_contexts;
+	}
+
+	if (rcv_pool_count > dd->sc_sizes[SC_USER].count) {
+		const char *action = recalculated ? "fail"
+						  : "recalculating";
+
+		dd_dev_info(dd, "too many user rc %d vs sc %d - %s",
+			    rcv_pool_count,
+			    dd->sc_sizes[SC_USER].count,
+			    action);
+		if (recalculated)
+			return -EINVAL;
+
+		/* netdev is required, enforce that many in the pool */
+		if (dd->sc_sizes[SC_USER].count < total_netdev) {
+			dd_dev_err(dd, "more pool rcv contexts required than available\n");
+			return -EINVAL;
+		}
+
+		over = rcv_pool_count - dd->sc_sizes[SC_USER].count;
+		ret = reduce_rcv_ctxts(dd, n_usr_ctxts, over, "available send contexts");
+		if (ret)
+			return -EINVAL;
+		dd_dev_info(dd, "reducing requested receive contexts by %d",
+			    over);
+		recalculated = true;
+		goto do_recalc;
+	}
+
+	return 0;
+}
+
+/*
+ * Set the device/port partition key table. The MAD code
+ * will ensure that, at least, the partial management
+ * partition key is present in the table.
+ */
+static void set_partition_keys(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = 0;
+	int i;
+
+	/* cport controls setting the hardware pkey table on later hardware */
+	if (dd->params->chip_type != CHIP_WFR)
+		return;
+
+	ppd_dev_info(ppd, "Setting partition keys\n");
+	for (i = 0; i < hfi2_get_npkeys(dd); i++) {
+		reg |= (ppd->pkeys[i] &
+			RCV_PARTITION_KEY_PARTITION_KEY_A_MASK) <<
+			((i % 4) *
+			 RCV_PARTITION_KEY_PARTITION_KEY_B_SHIFT);
+		/* Each register holds 4 PKey values. */
+		if ((i % 4) == 3) {
+			write_iport_csr(dd, ppd->hw_pidx,
+					dd->params->rcv_partition_key_reg +
+					((i - 3) * 2), reg);
+			reg = 0;
+		}
+	}
+
+	/* Always enable HW pkeys check when pkeys table is set */
+	add_rcvctrl(ppd, RCV_CTRL_RCV_PARTITION_KEY_ENABLE_SMASK);
+}
+
+/*
+ * These CSRs and memories are uninitialized on reset and must be
+ * written before reading to set the ECC/parity bits.
+ *
+ * NOTE: All user context CSRs that are not mmaped write-only
+ * (e.g. the TID flows) must be initialized even if the driver never
+ * reads them.
+ */
+static void write_uninitialized_csrs_and_memories(struct hfi2_devdata *dd)
+{
+	int i, j;
+
+	/* CceIntMap */
+	for (i = 0; i < dd->params->num_int_map_csrs; i++)
+		write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * i), 0);
+
+	/* SendCtxtCreditReturnAddr */
+	for (i = 0; i < chip_send_contexts(dd); i++)
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_return_addr_reg, 0);
+
+	/* PIO Send buffers */
+	/* SDMA Send buffers */
+	/*
+	 * These are not normally read, and (presently) have no method
+	 * to be read, so are not pre-initialized
+	 */
+
+	/* RcvHdrAddr */
+	/* RcvHdrTailAddr */
+	/* RcvTidFlowTable */
+	for (i = 0; i < chip_rcv_contexts(dd); i++) {
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_addr_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_tail_addr_reg, 0);
+		for (j = 0; j < RXE_NUM_TID_FLOWS; j++)
+			write_uctxt_csr(dd, i, dd->params->rcv_tid_flow_table_reg + (8 * j), 0);
+	}
+
+	/* RcvArray */
+	dd->params->init_tids(dd);
+
+	/* RcvQPMapTable */
+	for (i = 0; i < dd->num_pports; i++) {
+		for (j = 0; j < 32; j++) {
+			u32 off = dd->params->rcv_qp_map_table_reg + (8 * i);
+
+			write_iport_csr(dd, i, off, 0);
+		}
+	}
+}
+
+/*
+ * Use the ctrl_bits in CceCtrl to clear the status_bits in CceStatus.
+ */
+static void clear_cce_status(struct hfi2_devdata *dd, u64 status_bits,
+			     u64 ctrl_bits)
+{
+	unsigned long timeout;
+	u64 reg;
+
+	/* is the condition present? */
+	reg = read_csr(dd, CCE_STATUS);
+	if ((reg & status_bits) == 0)
+		return;
+
+	/* clear the condition */
+	write_csr(dd, CCE_CTRL, ctrl_bits);
+
+	/* wait for the condition to clear */
+	timeout = jiffies + msecs_to_jiffies(CCE_STATUS_TIMEOUT);
+	while (1) {
+		reg = read_csr(dd, CCE_STATUS);
+		if ((reg & status_bits) == 0)
+			return;
+		if (time_after(jiffies, timeout)) {
+			dd_dev_err(dd,
+				   "Timeout waiting for CceStatus to clear bits 0x%llx, remaining 0x%llx\n",
+				   status_bits, reg & status_bits);
+			return;
+		}
+		udelay(1);
+	}
+}
+
+/* set CCE CSRs to chip reset defaults */
+static void reset_cce_csrs(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* CCE_REVISION read-only */
+	/* CCE_REVISION2 read-only */
+	/* CCE_CTRL - bits clear automatically */
+	/* CCE_STATUS read-only, use CceCtrl to clear */
+	clear_cce_status(dd, ALL_FROZE, CCE_CTRL_SPC_UNFREEZE_SMASK);
+	clear_cce_status(dd, ALL_TXE_PAUSE, CCE_CTRL_TXE_RESUME_SMASK);
+	clear_cce_status(dd, ALL_RXE_PAUSE, CCE_CTRL_RXE_RESUME_SMASK);
+	for (i = 0; i < CCE_NUM_SCRATCH; i++)
+		write_csr(dd, CCE_SCRATCH + (8 * i), 0);
+	/* CCE_ERR_STATUS read-only */
+	write_csr(dd, CCE_ERR_MASK, 0);
+	write_csr(dd, CCE_ERR_CLEAR, ~0ull);
+	/* CCE_ERR_FORCE leave alone */
+	for (i = 0; i < CCE_NUM_32_BIT_COUNTERS; i++)
+		write_csr(dd, CCE_COUNTER_ARRAY32 + (8 * i), 0);
+	write_csr(dd, CCE_DC_CTRL, CCE_DC_CTRL_RESETCSR);
+	/* CCE_PCIE_CTRL leave alone */
+	for (i = 0; i < CCE_NUM_MSIX_VECTORS; i++) {
+		write_csr(dd, CCE_MSIX_TABLE_LOWER + (0x10 * i), 0);
+		write_csr(dd, CCE_MSIX_TABLE_UPPER + (0x10 * i),
+			  CCE_MSIX_TABLE_UPPER_RESETCSR);
+	}
+	for (i = 0; i < CCE_NUM_MSIX_PBAS; i++) {
+		/* CCE_MSIX_PBA read-only */
+		write_csr(dd, CCE_MSIX_INT_GRANTED, ~0ull);
+		write_csr(dd, CCE_MSIX_VEC_CLR_WITHOUT_INT, ~0ull);
+	}
+	for (i = 0; i < dd->params->num_int_map_csrs; i++)
+		write_csr(dd, dd->params->cce_msix_int_map_vec_reg + (8 * i), 0);
+	for (i = 0; i < dd->params->num_int_csrs; i++) {
+		/* CCE_INT_STATUS read-only */
+		write_csr(dd, CCE_INT_MASK + (8 * i), 0);
+		write_csr(dd, CCE_INT_CLEAR + (8 * i), ~0ull);
+		/* CCE_INT_FORCE leave alone */
+		/* CCE_INT_BLOCKED read-only */
+	}
+	for (i = 0; i < CCE_NUM_32_BIT_INT_COUNTERS; i++)
+		write_csr(dd, CCE_INT_COUNTER_ARRAY32 + (8 * i), 0);
+}
+
+/* set MISC CSRs to chip reset defaults */
+static void reset_misc_csrs(struct hfi2_devdata *dd)
+{
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		write_csr(dd, MISC_CFG_RSA_R2 + (8 * i), 0);
+		write_csr(dd, MISC_CFG_RSA_SIGNATURE + (8 * i), 0);
+		write_csr(dd, MISC_CFG_RSA_MODULUS + (8 * i), 0);
+	}
+	/*
+	 * MISC_CFG_SHA_PRELOAD leave alone - always reads 0 and can
+	 * only be written 128-byte chunks
+	 */
+	/* init RSA engine to clear lingering errors */
+	write_csr(dd, MISC_CFG_RSA_CMD, 1);
+	write_csr(dd, MISC_CFG_RSA_MU, 0);
+	write_csr(dd, MISC_CFG_FW_CTRL, 0);
+	/* MISC_STS_8051_DIGEST read-only */
+	/* MISC_STS_SBM_DIGEST read-only */
+	/* MISC_STS_PCIE_DIGEST read-only */
+	/* MISC_STS_FAB_DIGEST read-only */
+	/* MISC_ERR_STATUS read-only */
+	write_csr(dd, MISC_ERR_MASK, 0);
+	write_csr(dd, MISC_ERR_CLEAR, ~0ull);
+	/* MISC_ERR_FORCE leave alone */
+}
+
+/* set TXE CSRs to chip reset defaults */
+static void reset_txe_csrs(struct hfi2_devdata *dd)
+{
+	int i, j;
+
+	/*
+	 * TXE Kernel CSRs
+	 */
+	for (i = 0; i < dd->num_pports; i++) {
+		write_eport_csr(dd, i, dd->params->send_ctrl_reg, 0);
+		__cm_reset(&dd->pport[i], 0);	/* reset CM internal state */
+		/* SEND_CONTEXTS read-only */
+		/* SEND_DMA_ENGINES read-only */
+		/* SEND_PIO_MEM_SIZE read-only */
+		/* SEND_DMA_MEM_SIZE read-only */
+		write_eport_csr(dd, i, dd->params->send_high_priority_limit_reg, 0);
+		/* SEND_DMA_ERR_FORCE leave alone */
+		/* SEND_EGRESS_ERR_STATUS read-only */
+		write_eport_csr(dd, i, dd->params->send_egress_err_mask_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_egress_err_clear_reg, ~0ull);
+		/* SEND_EGRESS_ERR_FORCE leave alone */
+		write_eport_csr(dd, i, dd->params->send_bth_qp_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_static_rate_control_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt0_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt1_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt2_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_sc2vlt3_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_len_check0_reg, 0);
+		write_eport_csr(dd, i, dd->params->send_len_check1_reg, 0);
+		for (j = 0; j < VL_ARB_LOW_PRIO_TABLE_SIZE; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_low_priority_list_reg + (8 * j),
+					0);
+		}
+		for (j = 0; j < VL_ARB_HIGH_PRIO_TABLE_SIZE; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_high_priority_list_reg + (8 * j),
+					0);
+		}
+		for (j = 0; j < TXE_NUM_32_BIT_COUNTER; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_counter_array32_reg + (8 * j),
+					0);
+		}
+		for (j = 0; j < TXE_NUM_64_BIT_COUNTER; j++) {
+			write_eport_csr(dd, i,
+					dd->params->send_counter_array64_reg + (8 * j),
+					0);
+		}
+		write_eport_csr(dd, i, dd->params->send_cm_ctrl_reg,
+				SEND_CM_CTRL_RESETCSR);
+		write_eport_csr(dd, i, dd->params->send_cm_global_credit_reg,
+				SEND_CM_GLOBAL_CREDIT_RESETCSR);
+		/* SEND_CM_CREDIT_USED_STATUS read-only */
+		write_eport_csr(dd, i, dd->params->send_cm_timer_ctrl_reg, 0);
+		if (dd->params->chip_type == CHIP_WFR) {
+			write_eport_csr(dd, i, dd->params->send_cm_local_au_table0_to3_reg, 0);
+			write_eport_csr(dd, i, dd->params->send_cm_local_au_table4_to7_reg, 0);
+			write_eport_csr(dd, i, dd->params->send_cm_remote_au_table0_to3_reg, 0);
+			write_eport_csr(dd, i, dd->params->send_cm_remote_au_table4_to7_reg, 0);
+		}
+		for (j = 0; j < TXE_NUM_DATA_VL; j++)
+			write_eport_csr(dd, i, dd->params->send_cm_credit_vl_reg + (8 * j), 0);
+		write_eport_csr(dd, i, dd->params->send_cm_credit_vl15_reg, 0);
+		/* SEND_CM_CREDIT_USED_VL read-only */
+		/* SEND_CM_CREDIT_USED_VL15 read-only */
+		/* SEND_EGRESS_CTXT_STATUS read-only */
+		/* SEND_EGRESS_SEND_DMA_STATUS read-only */
+		write_eport_csr(dd, i, dd->params->send_egress_err_info_reg, ~0ull);
+		/* SEND_EGRESS_ERR_SOURCE read-only */
+	}
+	pio_reset_all(dd);	/* SEND_PIO_INIT_CTXT */
+	/* SEND_PIO_ERR_STATUS read-only */
+	write_csr(dd, dd->params->send_pio_err_mask_reg, 0);
+	write_csr(dd, dd->params->send_pio_err_clear_reg, ~0ull);
+	/* SEND_PIO_ERR_FORCE leave alone */
+	/* SEND_DMA_ERR_STATUS read-only */
+	write_csr(dd, dd->params->send_dma_err_mask_reg, 0);
+	write_csr(dd, dd->params->send_dma_err_clear_reg, ~0ull);
+	/* SEND_ERR_STATUS read-only */
+	write_csr(dd, dd->params->csr_err_mask_reg, 0);
+	write_csr(dd, dd->params->csr_err_clear_reg, ~0ull);
+	/* SEND_ERR_FORCE read-only */
+	for (i = 0; i < chip_send_contexts(dd) / NUM_CONTEXTS_PER_SET; i++)
+		write_csr(dd, SEND_CONTEXT_SET_CTRL + (8 * i), 0);
+
+	/*
+	 * TXE Per-Context CSRs
+	 */
+	for (i = dd->first_send_context; i < chip_send_contexts(dd); i++) {
+		write_tctxt_csr(dd, i, dd->params->send_ctxt_ctrl_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_ctrl_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_return_addr_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_credit_force_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_mask_reg, 0);
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_clear_reg, ~0ull);
+		for (j = 0; j < dd->num_pports; j++) {
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_enable_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_vl_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_job_key_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_partition_key_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_slid_reg, 0);
+			write_epsc_csr(dd, j, i, dd->params->send_ctxt_check_opcode_reg, 0);
+		}
+	}
+
+	/*
+	 * TXE Per-SDMA CSRs
+	 */
+	for (i = 0; i < chip_sdma_engines(dd); i++) {
+		write_sdma_csr(dd, i, dd->params->send_dma_ctrl_reg, 0);
+		/* SEND_DMA_STATUS read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_base_addr_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_len_gen_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_tail_reg, 0);
+		/* SEND_DMA_HEAD read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_head_addr_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_priority_thld_reg, 0);
+		/* SEND_DMA_IDLE_CNT read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_reload_cnt_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_desc_cnt_reg, 0);
+		/* SEND_DMA_DESC_FETCHED_CNT read-only */
+		/* SEND_DMA_ENG_ERR_STATUS read-only */
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_mask_reg, 0);
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_clear_reg, ~0ull);
+		/* SEND_DMA_ENG_ERR_FORCE leave alone */
+		if (dd->params->chip_type == CHIP_WFR) {
+			/* SEND_DMA_CHECK_* are WFR only */
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_ENABLE, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_VL, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_JOB_KEY, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_PARTITION_KEY, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_SLID, 0);
+			write_kctxt_csr(dd, i, SEND_DMA_CHECK_OPCODE, 0);
+		}
+		write_sdmacfg_csr(dd, i, dd->params->send_dma_cfg_memory_reg, 0);
+	}
+}
+
+/*
+ * Expect on entry:
+ * o Packet ingress is disabled, i.e. RcvCtrl.RcvPortEnable == 0
+ */
+static void init_rbufs(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+	int count;
+	int pidx = ppd->hw_pidx;
+
+	/*
+	 * Wait for DMA to stop: RxRbufPktPending and RxPktInProgress are
+	 * clear.
+	 */
+	count = 0;
+	while (1) {
+		reg = read_iport_csr(dd, pidx, dd->params->rcv_iport_status_reg);
+		if ((reg & (RCV_STATUS_RX_RBUF_PKT_PENDING_SMASK
+			    | RCV_STATUS_RX_PKT_IN_PROGRESS_SMASK)) == 0)
+			break;
+		/*
+		 * Give up after 1ms - maximum wait time.
+		 *
+		 * RBuf size is 136KiB.  Slowest possible is PCIe Gen1 x1 at
+		 * 250MB/s bandwidth.  Lower rate to 66% for overhead to get:
+		 *	136 KB / (66% * 250MB/s) = 844us
+		 */
+		if (count++ > 500) {
+			ppd_dev_err(ppd,
+				    "%s: in-progress DMA not clearing: RcvStatus 0x%llx, continuing\n",
+				    __func__, reg);
+			break;
+		}
+		udelay(2); /* do not busy-wait the CSR */
+	}
+
+	/* start the init - expect RcvCtrl to be 0 */
+	write_iport_csr(dd, pidx, dd->params->rcv_iport_ctrl_reg,
+			RCV_CTRL_RX_RBUF_INIT_SMASK);
+
+	/*
+	 * Read to force the write of RcvCtrl.RxRbufInit.  There is a brief
+	 * period after the write before RcvStatus.RxRbufInitDone is valid.
+	 * The delay in the first run through the loop below is sufficient and
+	 * required before the first read of RcvStatus.RxRbufInitDone.
+	 */
+	read_iport_csr(dd, pidx, dd->params->rcv_iport_ctrl_reg);
+
+	/* wait for the init to finish */
+	count = 0;
+	while (1) {
+		/* delay is required first time through - see above */
+		udelay(2); /* do not busy-wait the CSR */
+		reg = read_iport_csr(dd, pidx, dd->params->rcv_iport_status_reg);
+		if (reg & (RCV_STATUS_RX_RBUF_INIT_DONE_SMASK))
+			break;
+
+		/* give up after 100us - slowest possible at 33MHz is 73us */
+		if (count++ > 50) {
+			ppd_dev_err(ppd,
+				    "%s: RcvStatus.RxRbufInit not set, continuing\n",
+				    __func__);
+			break;
+		}
+	}
+}
+
+/* set RXE CSRs to chip reset defaults */
+static void reset_rxe_csrs(struct hfi2_devdata *dd)
+{
+	int i, j;
+
+	/*
+	 * RXE per-port Kernel CSRs
+	 */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = dd->pport + i;
+		int pidx = ppd->hw_pidx;
+
+		write_iport_csr(dd, pidx, dd->params->rcv_iport_ctrl_reg, 0);
+		init_rbufs(ppd);
+		/* RCV_STATUS read-only */
+		/* RCV_CONTEXTS read-only */
+		/* RCV_ARRAY_CNT read-only */
+		/* RCV_BUF_SIZE read-only */
+		write_iport_csr(dd, pidx, dd->params->rcv_bth_qp_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_multicast_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_bypass_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_vl15_reg, 0);
+		/* this is a clear-down */
+		write_iport_csr(dd, pidx, dd->params->rcv_err_info_reg,
+				RCV_ERR_INFO_RCV_EXCESS_BUFFER_OVERRUN_SMASK);
+		/* RCV_ERR_STATUS read-only */
+		write_iport_csr(dd, pidx, dd->params->rcv_err_mask_reg, 0);
+		write_iport_csr(dd, pidx, dd->params->rcv_err_clear_reg, ~0ull);
+		/* RCV_ERR_FORCE leave alone */
+		for (i = 0; i < 32; i++)
+			write_iport_csr(dd, pidx,
+					dd->params->rcv_qp_map_table_reg + (8 * i), 0);
+		for (i = 0; i < 4; i++)
+			write_iport_csr(dd, pidx,
+					dd->params->rcv_partition_key_reg + (8 * i), 0);
+		for (i = 0; i < RXE_NUM_32_BIT_COUNTERS; i++)
+			write_iport_csr(dd, pidx, dd->params->rcv_counter_array32_reg +
+					(8 * i), 0);
+		for (i = 0; i < RXE_NUM_64_BIT_COUNTERS; i++)
+			write_iport_csr(dd, pidx, dd->params->rcv_counter_array64_reg +
+					(8 * i), 0);
+	}
+
+	for (i = 0; i < dd->params->rsm_rule_size; i++)
+		clear_rsm_rule(dd, i);
+	for (i = 0; i < 32; i++)
+		write_csr(dd, RCV_RSM_MAP_TABLE + (8 * i), 0);
+
+	/*
+	 * RXE Kernel and User Per-Context CSRs
+	 */
+	for (i = 0; i < chip_rcv_contexts(dd); i++) {
+		/* kernel */
+		write_kctxt_csr(dd, i, dd->params->rcv_kctxt_ctrl_reg, 0);
+		write_rctxt_csr(dd, i, dd->params->rcv_rctxt_ctrl_reg, 0);
+		/* RCV_CTXT_STATUS read-only */
+		write_rctxt_csr(dd, i, dd->params->rcv_egr_ctrl_reg, 0);
+		write_rctxt_csr(dd, i, dd->params->rcv_tid_ctrl_reg, 0);
+		for (j = 0; j < dd->num_pports; j++)
+			write_iprc_csr(dd, j, i, dd->params->rcv_jkey_ctrl_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_addr_reg, 0);
+		if (dd->params->set_rheq_addr)
+			dd->params->set_rheq_addr(dd, i, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_cnt_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_ent_size_reg, 0);
+		if (dd->params->chip_type == CHIP_WFR)
+			write_kctxt_csr(dd, i, RCV_HDR_SIZE, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_tail_addr_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_avail_time_out_reg, 0);
+		write_kctxt_csr(dd, i, dd->params->rcv_hdr_ovfl_cnt_reg, 0);
+
+		/* user */
+		/* RCV_HDR_TAIL read-only */
+		write_uctxt_csr(dd, i, dd->params->rcv_hdr_head_reg, 0);
+		/* RCV_EGR_INDEX_TAIL read-only */
+		write_uctxt_csr(dd, i, dd->params->rcv_egr_index_head_reg, 0);
+		/* RCV_EGR_OFFSET_TAIL read-only */
+		for (j = 0; j < RXE_NUM_TID_FLOWS; j++) {
+			write_uctxt_csr(dd, i,
+					dd->params->rcv_tid_flow_table_reg + (8 * j), 0);
+		}
+	}
+}
+
+/*
+ * Set sc2vl tables.
+ *
+ * They power on to zeros, so to avoid send context errors
+ * they need to be set:
+ *
+ * SC 0-7 -> VL 0-7 (respectively)
+ * SC 15  -> VL 15
+ * otherwise
+ *        -> VL 0
+ */
+static void init_sc2vl_tables(struct hfi2_devdata *dd)
+{
+	int i;
+	int j;
+	/* init per architecture spec, constrained by hardware capability */
+
+	if (dd->params->chip_type != CHIP_WFR) {
+		/* cport is active - read the current sc2vlt */
+		for (i = 0; i < dd->num_pports; i++) {
+			struct hfi2_pportdata *ppd = &dd->pport[i];
+
+			get_sc2vlt_tables(ppd, ppd->sc2vl);
+		}
+
+		return;
+	}
+
+	/* HFI maps sent packets */
+	for (i = 0; i < dd->num_pports; i++) {
+		write_eport_csr(dd, i, dd->params->send_sc2vlt0_reg, SC2VL_VAL(
+				0,
+				0, 0, 1, 1,
+				2, 2, 3, 3,
+				4, 4, 5, 5,
+				6, 6, 7, 7));
+		write_eport_csr(dd, i, dd->params->send_sc2vlt1_reg, SC2VL_VAL(
+				1,
+				8, 0, 9, 0,
+				10, 0, 11, 0,
+				12, 0, 13, 0,
+				14, 0, 15, 15));
+		write_eport_csr(dd, i, dd->params->send_sc2vlt2_reg, SC2VL_VAL(
+				2,
+				16, 0, 17, 0,
+				18, 0, 19, 0,
+				20, 0, 21, 0,
+				22, 0, 23, 0));
+		write_eport_csr(dd, i, dd->params->send_sc2vlt3_reg, SC2VL_VAL(
+				3,
+				24, 0, 25, 0,
+				26, 0, 27, 0,
+				28, 0, 29, 0,
+				30, 0, 31, 0));
+	}
+
+	/* DC maps received packets */
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_15_0, DC_SC_VL_VAL(15_0,
+		  0, 0, 1, 1,  2, 2,  3, 3,  4, 4,  5, 5,  6, 6,  7,  7,
+		  8, 0, 9, 0, 10, 0, 11, 0, 12, 0, 13, 0, 14, 0, 15, 15));
+	write_csr(dd, DCC_CFG_SC_VL_TABLE_31_16, DC_SC_VL_VAL(31_16,
+		  16, 0, 17, 0, 18, 0, 19, 0, 20, 0, 21, 0, 22, 0, 23, 0,
+		  24, 0, 25, 0, 26, 0, 27, 0, 28, 0, 29, 0, 30, 0, 31, 0));
+
+	/* initialize the cached sc2vl values consistently with h/w */
+	for (i = 0; i < dd->num_pports; i++) {
+		struct hfi2_pportdata *ppd = &dd->pport[i];
+
+		for (j = 0; j < 32; j++) {
+			if (j < 8 || j == 15)
+				*((u8 *)(ppd->sc2vl) + j) = (u8)j;
+			else
+				*((u8 *)(ppd->sc2vl) + j) = 0;
+		}
+	}
+}
+
+/*
+ * Read chip sizes and then reset parts to sane, disabled, values.  We cannot
+ * depend on the chip going through a power-on reset - a driver may be loaded
+ * and unloaded many times.
+ *
+ * Do not write any CSR values to the chip in this routine - there may be
+ * a reset following the (possible) FLR in this routine.
+ *
+ */
+static int init_chip(struct hfi2_devdata *dd)
+{
+	int i;
+	int ret = 0;
+
+	/*
+	 * Put the HFI CSRs in a known state.
+	 * Combine this with a DC reset.
+	 *
+	 * Stop the device from doing anything while we do a
+	 * reset.  We know there are no other active users of
+	 * the device since we are now in charge.  Turn off
+	 * off all outbound and inbound traffic and make sure
+	 * the device does not generate any interrupts.
+	 */
+
+	/* disable send contexts and SDMA engines */
+	for (i = 0; i < dd->num_pports; i++)
+		write_eport_csr(dd, i, dd->params->send_ctrl_reg, 0);
+	for (i = 0; i < chip_send_contexts(dd); i++)
+		write_tctxt_csr(dd, i, dd->params->send_ctxt_ctrl_reg, 0);
+	for (i = 0; i < chip_sdma_engines(dd); i++)
+		write_sdma_csr(dd, i, dd->params->send_dma_ctrl_reg, 0);
+	/* disable port (turn off RXE inbound traffic) and contexts */
+	for (i = 0; i < dd->num_pports; i++)
+		write_iport_csr(dd, i, dd->params->rcv_iport_ctrl_reg, 0);
+	for (i = 0; i < chip_rcv_contexts(dd); i++) {
+		write_kctxt_csr(dd, i, dd->params->rcv_kctxt_ctrl_reg, 0);
+		write_rctxt_csr(dd, i, dd->params->rcv_rctxt_ctrl_reg, 0);
+	}
+	/* mask all interrupt sources */
+	for (i = 0; i < dd->params->num_int_csrs; i++)
+		write_csr(dd, CCE_INT_MASK + (8 * i), 0ull);
+
+	/*
+	 * DC Reset: do a full DC reset before the register clear.
+	 * A recommended length of time to hold is one CSR read,
+	 * so reread the CceDcCtrl.  Then, hold the DC in reset
+	 * across the clear.
+	 */
+	write_csr(dd, CCE_DC_CTRL, CCE_DC_CTRL_DC_RESET_SMASK);
+	(void)read_csr(dd, CCE_DC_CTRL);
+
+	if (use_flr) {
+		/*
+		 * A FLR will reset the SPC core and part of the PCIe.
+		 * The parts that need to be restored have already been
+		 * saved.
+		 */
+		dd_dev_info(dd, "Resetting CSRs with FLR\n");
+
+		/* do the FLR, the DC reset will remain */
+		pcie_flr(dd->pcidev);
+
+		/* restore command and BARs */
+		ret = restore_pci_variables(dd);
+		if (ret) {
+			dd_dev_err(dd, "%s: Could not restore PCI variables\n",
+				   __func__);
+			return ret;
+		}
+
+		if (is_ax(dd)) {
+			dd_dev_info(dd, "Resetting CSRs with FLR\n");
+			pcie_flr(dd->pcidev);
+			ret = restore_pci_variables(dd);
+			if (ret) {
+				dd_dev_err(dd, "%s: Could not restore PCI variables\n",
+					   __func__);
+				return ret;
+			}
+		}
+	} else {
+		dd_dev_info(dd, "Resetting CSRs with writes\n");
+		reset_cce_csrs(dd);
+		reset_txe_csrs(dd);
+		reset_rxe_csrs(dd);
+		reset_misc_csrs(dd);
+	}
+	/* clear the DC reset */
+	write_csr(dd, CCE_DC_CTRL, 0);
+
+	/* Turn off LEDs */
+	for (i = 0; i < dd->num_pports; i++)
+		dd->params->setextled(&dd->pport[i], 0);
+
+	/*
+	 * Clear the QSFP reset.
+	 * An FLR enforces a 0 on all out pins. The driver does not touch
+	 * ASIC_QSFPn_OUT otherwise.  This leaves RESET_N low and
+	 * anything plugged constantly in reset, if it pays attention
+	 * to RESET_N.
+	 * Prime examples of this are optical cables. Set all pins high.
+	 * I2CCLK and I2CDAT will change per direction, and INT_N and
+	 * MODPRS_N are input only and their value is ignored.
+	 */
+	write_csr(dd, ASIC_QSFP1_OUT, 0x1f);
+	write_csr(dd, ASIC_QSFP2_OUT, 0x1f);
+	init_chip_resources(dd);
+	return ret;
+}
+
+void init_early_variables(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* assign link credit variables */
+	dd->vau = CM_VAU;
+	dd->link_credits = CM_GLOBAL_CREDITS;
+	if (is_ax(dd))
+		dd->link_credits--;
+	dd->vcu = cu_to_vcu(hfi2_cu);
+	/* enough room for 8 MAD packets plus header - 17K */
+	dd->vl15_init = (8 * (2048 + 128)) / vau_to_au(dd->vau);
+	if (dd->vl15_init > dd->link_credits)
+		dd->vl15_init = dd->link_credits;
+
+	if (HFI2_CAP_IS_KSET(PKEY_CHECK))
+		for (i = 0; i < dd->num_pports; i++) {
+			struct hfi2_pportdata *ppd = &dd->pport[i];
+
+			set_partition_keys(ppd);
+		}
+	init_sc2vl_tables(dd);
+}
+
+void init_kdeth_qp(struct hfi2_devdata *dd)
+{
+	u64 val;
+	int i;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		val = (RVT_KDETH_QP_PREFIX & SEND_BTH_QP_KDETH_QP_MASK) <<
+		      SEND_BTH_QP_KDETH_QP_SHIFT;
+		write_eport_csr(dd, i, dd->params->send_bth_qp_reg, val);
+
+		val = (RVT_KDETH_QP_PREFIX & RCV_BTH_QP_KDETH_QP_MASK) <<
+		      RCV_BTH_QP_KDETH_QP_SHIFT;
+		write_iport_csr(dd, i, dd->params->rcv_bth_qp_reg, val);
+	}
+}
+
+/**
+ * hfi2_get_qp_map - get qp map entry
+ * @dd: device data
+ * @idx: index to read (will be masked to table size)
+ */
+u16 hfi2_get_qp_map(struct hfi2_pportdata *ppd, u16 idx)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 off;
+	u64 reg;
+
+	idx &= 0xff;  /* table has 256 entries */
+	off = dd->params->rcv_qp_map_table_reg + (idx / 8) * 8;
+	reg = read_iport_csr(dd, ppd->hw_pidx, off);
+	reg >>= (idx % 8) * 8;
+	reg &= 0xff; /* packing: 8 bits per context */
+	return reg;
+}
+
+/**
+ * init_qpmap_table - init qp map
+ * @dd: device data
+ * @first_ctxt: first context
+ * @last_ctxt: first context
+ *
+ * This return sets the qpn mapping table that
+ * is indexed by qpn[8:1].
+ *
+ * The routine will round robin the 256 settings
+ * from first_ctxt to last_ctxt.
+ *
+ * The first/last looks ahead to having specialized
+ * receive contexts for mgmt and bypass.  Normal
+ * verbs traffic will assumed to be on a range
+ * of receive contexts.
+ */
+static void init_qpmap_table(struct hfi2_pportdata *ppd,
+			     u32 first_ctxt,
+			     u32 last_ctxt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg = 0;
+	u32 regno = dd->params->rcv_qp_map_table_reg;
+	int i;
+	u64 ctxt = first_ctxt;
+
+	for (i = 0; i < 256; i++) {
+		reg |= ctxt << (8 * (i % 8));
+		ctxt++;
+		if (ctxt > last_ctxt)
+			ctxt = first_ctxt;
+		if (i % 8 == 7) {
+			write_iport_csr(dd, ppd->hw_pidx, regno, reg);
+			reg = 0;
+			regno += 8;
+		}
+	}
+
+	add_rcvctrl(ppd, RCV_CTRL_RCV_QP_MAP_ENABLE_SMASK
+		    | RCV_CTRL_RCV_BYPASS_ENABLE_SMASK);
+}
+
+struct rsm_map_table {
+	u64 map[NUM_MAP_REGS];
+	unsigned int used;
+};
+
+static void set_rmt_entry(struct rsm_map_table *rmt, u8 idx, u8 value);
+
+struct rsm_rule_data {
+	u8 offset;
+	u8 pkt_type;
+	u8 pidx_mask;
+	u32 field1_off;
+	u32 field2_off;
+	u32 index1_off;
+	u32 index1_width;
+	u32 index2_off;
+	u32 index2_width;
+	u32 mask1;
+	u32 value1;
+	u32 mask2;
+	u32 value2;
+};
+
+/*
+ * Return an initialized RMT map table for users to fill in.  OK if it
+ * returns NULL, indicating no table.
+ */
+static struct rsm_map_table *alloc_rsm_map_table(struct hfi2_devdata *dd)
+{
+	struct rsm_map_table *rmt;
+	u8 rxcontext = is_ax(dd) ? 0 : 0xff;  /* 0 is default if a0 ver. */
+
+	rmt = kmalloc(sizeof(*rmt), GFP_KERNEL);
+	if (rmt) {
+		memset(rmt->map, rxcontext, sizeof(rmt->map));
+		rmt->used = 0;
+	}
+
+	return rmt;
+}
+
+/*
+ * Write the final RMT map table to the chip and free the table.  OK if
+ * table is NULL.
+ */
+static void complete_rsm_map_table(struct hfi2_devdata *dd,
+				   struct rsm_map_table *rmt)
+{
+	int i;
+
+	if (rmt) {
+		/* write table to chip */
+		for (i = 0; i < NUM_MAP_REGS; i++)
+			write_csr(dd, RCV_RSM_MAP_TABLE + (8 * i), rmt->map[i]);
+
+		/* enable RSM on each port */
+		for (i = 0; i < dd->num_pports; i++) {
+			add_rcvctrl(dd->pport + i,
+				    RCV_CTRL_RCV_RSM_ENABLE_SMASK);
+		}
+	}
+}
+
+/*
+ * Add a receive side mapping rule.
+ */
+static void add_rsm_rule(struct hfi2_devdata *dd, u8 rule_index,
+			 struct rsm_rule_data *rrd)
+{
+	write_csr(dd, RCV_RSM_CFG + (8 * rule_index),
+		  (u64)rrd->offset << RCV_RSM_CFG_OFFSET_SHIFT |
+		  (u64)rrd->pidx_mask << 40 | /* port enable mask (non WFR) */
+		  1ull << (rule_index % 4) | /* enable bit, no chain */
+		  (u64)rrd->pkt_type << RCV_RSM_CFG_PACKET_TYPE_SHIFT);
+	write_csr(dd, RCV_RSM_SELECT + (8 * rule_index),
+		  (u64)rrd->field1_off << RCV_RSM_SELECT_FIELD1_OFFSET_SHIFT |
+		  (u64)rrd->field2_off << RCV_RSM_SELECT_FIELD2_OFFSET_SHIFT |
+		  (u64)rrd->index1_off << RCV_RSM_SELECT_INDEX1_OFFSET_SHIFT |
+		  (u64)rrd->index1_width << RCV_RSM_SELECT_INDEX1_WIDTH_SHIFT |
+		  (u64)rrd->index2_off << RCV_RSM_SELECT_INDEX2_OFFSET_SHIFT |
+		  (u64)rrd->index2_width << RCV_RSM_SELECT_INDEX2_WIDTH_SHIFT);
+	write_csr(dd, RCV_RSM_MATCH + (8 * rule_index),
+		  (u64)rrd->mask1 << RCV_RSM_MATCH_MASK1_SHIFT |
+		  (u64)rrd->value1 << RCV_RSM_MATCH_VALUE1_SHIFT |
+		  (u64)rrd->mask2 << RCV_RSM_MATCH_MASK2_SHIFT |
+		  (u64)rrd->value2 << RCV_RSM_MATCH_VALUE2_SHIFT);
+}
+
+/*
+ * Clear a receive side mapping rule.
+ */
+static void clear_rsm_rule(struct hfi2_devdata *dd, int rule_index)
+{
+	if (rule_index < 0 || rule_index >= dd->params->rsm_rule_size)
+		return;
+
+	write_csr(dd, RCV_RSM_CFG + (8 * rule_index), 0);
+	write_csr(dd, RCV_RSM_SELECT + (8 * rule_index), 0);
+	write_csr(dd, RCV_RSM_MATCH + (8 * rule_index), 0);
+	if (test_and_clear_bit(rule_index, dd->rsm_rule_bitmap) == 0) {
+		dd_dev_err(dd, "%s: rule_index %d not set\n", __func__,
+			   rule_index);
+	}
+}
+
+/*
+ * Release all allocated rules.
+ * Expect to be called at driver unload time.
+ */
+void release_rsm_rules(struct hfi2_devdata *dd)
+{
+	int i;
+
+	if (!dd->rsm_rule_init)
+		return;
+
+	for (i = dd->first_rsm_rule; i < dd->params->rsm_rule_size; i++) {
+		if (test_bit(i, dd->rsm_rule_bitmap))
+			clear_rsm_rule(dd, i);
+	}
+	dd->rsm_rule_init = false;
+}
+
+/*
+ * Allocate a RSM rule index.
+ * Returns >=0 rule index, or -ENOSPC if no room
+ */
+static int alloc_rsm_rule(struct hfi2_devdata *dd, int type)
+{
+	unsigned long rule_index;
+
+	/* loop in case there is an allocate race */
+	while (1) {
+		rule_index = find_first_zero_bit(dd->rsm_rule_bitmap,
+						 dd->params->rsm_rule_size);
+		if (rule_index >= dd->params->rsm_rule_size) {
+			dd_dev_err(dd, "Unable to allocate rule for type %d\n",
+			           type);
+			return -ENOSPC;
+		}
+
+		if (test_and_set_bit(rule_index, dd->rsm_rule_bitmap) == 0)
+			break;
+	}
+	return (int)rule_index;
+}
+
+/* return the number of RSM map table entries that will be used for QOS */
+static int qos_rmt_entries(unsigned int n_krcv_queues, unsigned int *mp,
+			   unsigned int *np)
+{
+	int i;
+	unsigned int m, n;
+	uint max_by_vl = 0;
+
+	/* is QOS active at all? */
+	if (n_krcv_queues < MIN_KERNEL_KCTXTS ||
+	    num_vls == 1 ||
+	    krcvqsset <= 1)
+		goto no_qos;
+
+	/* determine bits for qpn */
+	for (i = 0; i < min_t(unsigned int, num_vls, krcvqsset); i++)
+		if (krcvqs[i] > max_by_vl)
+			max_by_vl = krcvqs[i];
+	if (max_by_vl > 32)
+		goto no_qos;
+	m = ilog2(__roundup_pow_of_two(max_by_vl));
+
+	/* determine bits for vl */
+	n = ilog2(__roundup_pow_of_two(num_vls));
+
+	/* reject if too much is used */
+	if ((m + n) > 7)
+		goto no_qos;
+
+	if (mp)
+		*mp = m;
+	if (np)
+		*np = n;
+
+	return 1 << (m + n);
+
+no_qos:
+	if (mp)
+		*mp = 0;
+	if (np)
+		*np = 0;
+	return 0;
+}
+
+/**
+ * init_qos_port - initialize RX QOS for a single port
+ * @ppd: port data
+ * @rmt: RSM map table
+ *
+ * This routine initializes a rule and the RSM map table to implement
+ * quality of service (qos) for this port.
+ *
+ * If all of the limit tests succeed, qos is applied based on the array
+ * interpretation of krcvqs where entry 0 is VL0.
+ *
+ * The number of vl bits (n) and the number of qpn bits (m) are computed to
+ * feed both the RSM map table and the single rule.
+ */
+static void init_qos_port(struct hfi2_pportdata *ppd, struct rsm_map_table *rmt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct rsm_rule_data rrd;
+	unsigned int qpns_per_vl, extended_vl, ctxt, i, qpn, n, m;
+	unsigned int rmt_entries;
+	int rule_index;
+
+	if (!rmt)
+		goto bail;
+	if (!ppd->n_krcv_queues)
+		goto bail;
+	rmt_entries = qos_rmt_entries(ppd->n_krcv_queues - 1, &m, &n);
+	if (rmt_entries == 0)
+		goto bail;
+	qpns_per_vl = 1 << m;
+	extended_vl = 1 << n;
+
+	/* enough room in the map table? */
+	if (rmt->used + rmt_entries > NUM_MAP_ENTRIES)
+		goto bail;
+
+	/* allocate a rule */
+	rule_index = alloc_rsm_rule(dd, RSM_TYPE_VERBS);
+	if (rule_index < 0)
+		goto bail;
+
+	/* fill block in RMT with this port's control context */
+	ctxt = ppd->rcv_context_base + HFI2_CTRL_CTXT;
+	for (i = 0; i < rmt_entries; i++)
+		set_rmt_entry(rmt, rmt->used + i, ctxt);
+
+	/* overwrite applicable qos entries */
+	ctxt = ppd->rcv_context_base + FIRST_KERNEL_KCTXT;
+	for (i = 0; i < num_vls; i++) {
+		unsigned int tctxt;
+		unsigned int idx;
+
+		for (qpn = 0, tctxt = ctxt;
+		     krcvqs[i] && qpn < qpns_per_vl; qpn++) {
+			/* generate the index the hardware will produce */
+			idx = rmt->used + ((qpn << n) ^ i);
+			set_rmt_entry(rmt, idx, tctxt);
+			tctxt++;
+			if (tctxt == ctxt + krcvqs[i])
+				tctxt = ctxt;
+		}
+		ctxt += krcvqs[i];
+	}
+
+	/*
+	 * Create a rule to extract an index using the formula:
+	 *	idx = qpn[m+n+1:1] ^ VL[n-1:0]
+	 *
+	 * The "qos_shift" setting will ensure the bottom n+1 bits of the QPN
+	 * will always be zero (except for GSI QPN=1).
+	 */
+	rrd.offset = rmt->used;
+	rrd.pkt_type = RHF_RCV_TYPE_IB;
+	rrd.pidx_mask = 1 << ppd->hw_pidx;
+	rrd.field1_off = LRH_BTH_MATCH_OFFSET;
+	rrd.field2_off = LRH_SC_MATCH_OFFSET;
+	rrd.index1_off = LRH_SC_SELECT_OFFSET;
+	rrd.index1_width = n;
+	rrd.index2_off = QPN_SELECT_OFFSET;
+	rrd.index2_width = m + n;
+	rrd.mask1 = LRH_BTH_MASK;
+	rrd.value1 = LRH_BTH_VALUE;
+	rrd.mask2 = LRH_SC_MASK;
+	rrd.value2 = LRH_SC_VALUE;
+
+	/* add rule */
+	add_rsm_rule(dd, rule_index, &rrd);
+
+	/* mark RSM map entries as used */
+	rmt->used += rmt_entries;
+
+	ppd->qos_shift = n + 1;
+
+	/* map everything else to this port's mcast/err/vl15 context */
+	init_qpmap_table(ppd, ppd->rcv_context_base + HFI2_CTRL_CTXT,
+			 ppd->rcv_context_base + HFI2_CTRL_CTXT);
+	return;
+bail:
+	ppd->qos_shift = 1;
+
+	if (ppd->n_krcv_queues) {
+		/* map everything to this port's kernel contexts */
+		init_qpmap_table(ppd, ppd->rcv_context_base + FIRST_KERNEL_KCTXT,
+				 ppd->rcv_context_base + ppd->n_krcv_queues - 1);
+	}
+}
+
+static void init_qos(struct hfi2_devdata *dd, struct rsm_map_table *rmt)
+{
+	int i;
+
+	for (i = 0; i < dd->num_pports; i++)
+		init_qos_port(&dd->pport[i], rmt);
+}
+
+/* set a single RSM Map Table (RMT) entry in the given map */
+static void set_rmt_entry(struct rsm_map_table *rmt, u8 idx, u8 value)
+{
+	u64 reg;
+	int regoff, regidx;
+
+	regoff = ((int)idx % 8) * 8;
+	regidx = (int)idx / 8;
+	reg = rmt->map[regidx];
+	reg &= ~(RCV_RSM_MAP_TABLE_RCV_CONTEXT_A_MASK << regoff);
+	reg |= (u64)value << regoff;
+	rmt->map[regidx] = reg;
+}
+
+static void init_fecn_handling(struct hfi2_pportdata *ppd,
+			       struct rsm_map_table *rmt)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct rsm_rule_data rrd;
+	int i, idx, start, end;
+	u8 offset;
+	u32 total_cnt;
+	int rule_index;
+
+	/* do nothing if port is not availble */
+	if (!port_available_ppd(ppd))
+		return;
+
+	if (HFI2_CAP_IS_KSET(TID_RDMA))
+		/* Exclude control context */
+		start = ppd->rcv_context_base + 1;
+	else
+		start = ppd->first_dyn_alloc_ctxt;
+	end = ppd->rcv_context_base + ppd->num_rcv_contexts;
+
+	total_cnt = end - start;
+
+	/* there needs to be enough room in the map table */
+	if (rmt->used + total_cnt > NUM_MAP_ENTRIES) {
+		ppd_dev_err(ppd, "FECN handling disabled - too many contexts allocated\n");
+		return;
+	}
+
+	rule_index = alloc_rsm_rule(dd, RSM_TYPE_FECN);
+	if (rule_index < 0)
+		return;
+
+	/*
+	 * RSM will extract the destination context as an index into the
+	 * map table.  The destination contexts are a sequential block
+	 * in the range start..end-1 (inclusive).
+	 * Map entries are accessed as offset + extracted value.  Adjust
+	 * the added offset so this sequence can be placed anywhere in
+	 * the table - as long as the entries themselves do not wrap.
+	 * There are only enough bits in offset for the table size, so
+	 * start with that to allow for a "negative" offset.
+	 */
+	offset = (u8)(NUM_MAP_ENTRIES + rmt->used - start);
+
+	for (i = start, idx = rmt->used; i < end; i++, idx++) {
+		/* replace with identity mapping */
+		set_rmt_entry(rmt, idx, i);
+	}
+
+	/*
+	 * For RSM intercept of Expected FECN packets:
+	 * o packet type 0 - expected
+	 * o match on F (bit 95), using select/match 1, and
+	 * o match on SH (bit 133), using select/match 2.
+	 *
+	 * Use index 1 to extract the 8-bit receive context from DestQP
+	 * (start at bit 64).  Use that as the RSM map table index.
+	 */
+	rrd.offset = offset;
+	rrd.pkt_type = RHF_RCV_TYPE_EXPECTED;
+	rrd.pidx_mask = 1 << ppd->hw_pidx;
+	rrd.field1_off = 95;
+	rrd.field2_off = 133;
+	rrd.index1_off = 64;
+	rrd.index1_width = 8;
+	rrd.index2_off = 0;
+	rrd.index2_width = 0;
+	rrd.mask1 = 1;
+	rrd.value1 = 1;
+	rrd.mask2 = 1;
+	rrd.value2 = 1;
+
+	add_rsm_rule(dd, rule_index, &rrd);
+
+	rmt->used += total_cnt;
+}
+
+static inline int hfi2_netdev_set_free_rmt_idx(struct hfi2_pportdata *ppd,
+					       struct rsm_map_table *rmt)
+{
+	if (rmt->used + NUM_NETDEV_MAP_ENTRIES > NUM_MAP_ENTRIES) {
+		ppd_dev_err(ppd, "Not enough RMT entries, used = %d\n",
+			    rmt->used);
+		return -ENOSPC;
+	}
+	ppd->netdev_rx->rmt_start = rmt->used;
+	rmt->used += NUM_NETDEV_MAP_ENTRIES;
+	return 0;
+}
+
+static void hfi2_netdev_update_rmt(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i, j;
+	int ctx_id = 0;
+	u64 reg;
+	u32 regoff;
+	int rmt_start = hfi2_netdev_get_free_rmt_idx(ppd);
+	int ctxt_count = hfi2_netdev_ctxt_count(ppd);
+
+	dev_dbg(&(dd)->pcidev->dev, "RMT start = %d, end %d\n",
+		rmt_start,
+		rmt_start + NUM_NETDEV_MAP_ENTRIES);
+
+	/* Update RSM mapping table, 32 regs, 256 entries - 1 ctx per byte */
+	regoff = RCV_RSM_MAP_TABLE + (rmt_start / 8) * 8;
+	reg = read_csr(dd, regoff);
+	for (i = 0; i < NUM_NETDEV_MAP_ENTRIES; i++) {
+		/* Update map register with netdev context */
+		j = (rmt_start + i) % 8;
+		reg &= ~(0xffllu << (j * 8));
+		reg |= (u64)hfi2_netdev_get_ctxt(ppd, ctx_id++)->ctxt << (j * 8);
+		/* Wrap up netdev ctx index */
+		ctx_id %= ctxt_count;
+		/* Write back map register */
+		if (j == 7 || ((i + 1) == NUM_NETDEV_MAP_ENTRIES)) {
+			dev_dbg(&(dd)->pcidev->dev,
+				"RMT[%d] =0x%llx\n",
+				regoff - RCV_RSM_MAP_TABLE, reg);
+
+			write_csr(dd, regoff, reg);
+			regoff += 8;
+			if (i < (NUM_NETDEV_MAP_ENTRIES - 1))
+				reg = read_csr(dd, regoff);
+		}
+	}
+}
+
+static void hfi2_enable_rsm_rule(struct hfi2_pportdata *ppd,
+				 int type, struct rsm_rule_data *rrd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int rule_index;
+
+	/* lock is for setting netdev_rsm_rule */
+	mutex_lock(&hfi2_mutex);
+	if (ppd->netdev_rsm_rule >= 0) {
+		ppd_dev_info(ppd, "Netdev contexts are already mapped in RMT\n");
+		goto done;
+	}
+
+	rule_index = alloc_rsm_rule(dd, type);
+	if (rule_index < 0)
+		goto done;
+
+	hfi2_netdev_update_rmt(ppd);
+
+	ppd->netdev_rsm_rule = rule_index;
+	add_rsm_rule(dd, rule_index, rrd);
+	add_rcvctrl(ppd, RCV_CTRL_RCV_RSM_ENABLE_SMASK);
+
+done:
+	mutex_unlock(&hfi2_mutex);
+}
+
+void hfi2_init_aip_rsm(struct hfi2_pportdata *ppd)
+{
+	/*
+	 * go through with the initialisation only if this rule actually doesn't
+	 * exist yet
+	 */
+	if (atomic_fetch_inc(&ppd->ipoib_rsm_usr_num) == 0) {
+		int rmt_start = hfi2_netdev_get_free_rmt_idx(ppd);
+		struct rsm_rule_data rrd = {
+			.offset = rmt_start,
+			.pkt_type = RHF_RCV_TYPE_IB,
+			.pidx_mask = 1 << ppd->hw_pidx,
+			.field1_off = LRH_BTH_MATCH_OFFSET,
+			.mask1 = LRH_BTH_MASK,
+			.value1 = LRH_BTH_VALUE,
+			.field2_off = BTH_DESTQP_MATCH_OFFSET,
+			.mask2 = BTH_DESTQP_MASK,
+			.value2 = BTH_DESTQP_VALUE,
+			.index1_off = DETH_AIP_SQPN_SELECT_OFFSET +
+					ilog2(NUM_NETDEV_MAP_ENTRIES),
+			.index1_width = ilog2(NUM_NETDEV_MAP_ENTRIES),
+			.index2_off = DETH_AIP_SQPN_SELECT_OFFSET,
+			.index2_width = ilog2(NUM_NETDEV_MAP_ENTRIES)
+		};
+
+		hfi2_enable_rsm_rule(ppd, RSM_TYPE_AIP, &rrd);
+	}
+}
+
+void hfi2_deinit_aip_rsm(struct hfi2_pportdata *ppd)
+{
+	/* only actually clear the rule if it's the last user asking to do so */
+	if (atomic_fetch_add_unless(&ppd->ipoib_rsm_usr_num, -1, 0) == 1) {
+		mutex_lock(&hfi2_mutex);
+		clear_rsm_rule(ppd->dd, ppd->netdev_rsm_rule);
+		ppd->netdev_rsm_rule = -1;
+		mutex_unlock(&hfi2_mutex);
+	}
+}
+
+/*
+ * RSM match rules for ports.
+ *
+ * RSM match bits are numbered little-endian by QWORD.  Take this into account
+ * when deciding bit offsets.
+ */
+static const struct rsm_rule_data mad_response_rules[] = {
+	/* 9B Response MAD packets */
+	{
+		.offset = 0,		/* filled in */
+		.pidx_mask = 0,		/* filled in */
+		.pkt_type = RHF_RCV_TYPE_IB,
+		.field1_off = 60,	/* LRH.VL offset */
+		.mask1 = 0x0f,		/*   4 bits */
+		.value1 = 0x0f,		/*  match LRH.VL=15 */
+		.field2_off = 199,	/* MAD.R offset */
+		.mask2 = 0x01,		/*   1 bit */
+		.value2 = 0x01,		/*   match MAD.R=1 */
+		.index1_off = 0,	/* do not index off of offset */
+		.index1_width = 0,
+		.index2_off = 0,
+		.index2_width = 0,
+	},
+	/* 9B TRAP MAD packets */
+	{
+		.offset = 0,		/* filled in */
+		.pidx_mask = 0,		/* filled in */
+		.pkt_type = RHF_RCV_TYPE_IB,
+		.field1_off = 60,	/* LRH.VL offset */
+		.mask1 = 0x0f,		/*   4 bits */
+		.value1 = 0x0f,		/*   match LRH.VL=15 */
+		.field2_off = 192,	/* MAD.Method offset */
+		.mask2 = 0x7f,		/*   7 bits */
+		.value2 = 0x05,		/*   match MAD.Method=TRAP */
+		.index1_off = 0,	/* do not index off of offset */
+		.index1_width = 0,
+		.index2_off = 0,
+		.index2_width = 0,
+	},
+};
+
+/*
+ * 16B (bypass) Packets (STL Mgmt L4 Header version, aka L4_FM)
+ * --------------------
+ * A 16B L4_FM type MAD packet starts with headers
+ *     16B LRH (16 bytes)
+ *     Mgmt L4 (8 bytes)
+ *     MAD
+ *
+ * Match vl15 in 16B.SC (5 bits)
+ * 16B.SC is bits 56:52 in the first QWORD.
+ *     offset = 52		bit offset
+ *     mask   = 0x1f		bits to check
+ *     value  = 0x0f		value to compare
+ *
+ * Match MAD.R (1 bit)
+ * MAD.R is the 4th byte on the wire of the MAD header, bit 7.
+ *     Preceding headers:      24 bytes  = 192 bits
+ *     Preceding bytes of MAD:  3 bytes  =  24 bits
+ *     Bit 7:                            =   7 bits
+ *     Total: 192 + 24 + 7 = 223
+ *
+ *     offset = 223		bit offset
+ *     mask   = 0x01		bits to check
+ *     value  = 0x00		value to compare
+ */
+static const struct rsm_rule_data mad_action_rules[] = {
+	{
+		.offset = 0,		/* filled in */
+		.pidx_mask = 0,		/* filled in */
+		.pkt_type = RHF_RCV_TYPE_BYPASS,
+		.field1_off = 52,	/* 16B.SC offset */
+		.mask1 = 0x1f,		/*   5 bits */
+		.value1 = 0x0f,		/*   match 16B.SC=15 */
+		.field2_off = 223,	/* MAD.R offset */
+		.mask2 = 0x01,		/*   1 bit */
+		.value2 = 0x00,		/*   match MAD.R=0 */
+		.index1_off = 0,	/* do not index off of offset */
+		.index1_width = 0,
+		.index2_off = 0,
+		.index2_width = 0,
+	},
+};
+
+/*
+ * Set up a rule for all entries in mmr_tbl to go to the target context.
+ */
+static int do_port_mapping(struct hfi2_pportdata *ppd,
+			   struct rsm_map_table *rmt,
+			   const struct rsm_rule_data *rrd_tbl,
+			   int rrd_len,
+			   int target_ctxt,
+			   int rule_type)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct rsm_rule_data rrd;
+	int rmt_index;
+	int rule_index;
+	int row;
+
+	/* check for room in RMT - need 1 entry */
+	if (rmt->used >= NUM_MAP_ENTRIES) {
+		ppd_dev_err(ppd, "%s: out of RMT entries\n", __func__);
+		return -ENOSPC;
+	}
+	/* allocate the RMT index */
+	rmt_index = rmt->used++;
+
+	/* update the RSM Map Table entry with the target context */
+	set_rmt_entry(rmt, rmt_index, target_ctxt);
+
+	/* assign the rules */
+	for (row = 0; row < rrd_len; row++) {
+		/* copy to a writable structure */
+		rrd = rrd_tbl[row];
+
+		/* fill in variable fields */
+		rrd.offset = rmt_index;		   /* lookup dest here... */
+		rrd.pidx_mask = 1 << ppd->hw_pidx; /* ...on this port */
+
+		/* allocate a rule index */
+		rule_index = alloc_rsm_rule(dd, rule_type);
+		if (rule_index < 0)
+			return rule_index; /* this is a -ERRNO */
+
+		/* set the rule registers */
+		add_rsm_rule(dd, rule_index, &rrd);
+	}
+
+	return 0;
+}
+
+/*
+ * Add port-specific mappings to the RSM Map Table.
+ */
+static int init_port_mapping(struct hfi2_pportdata *ppd,
+			     struct rsm_map_table *rmt)
+{
+	int ret;
+
+	/* no port mapping for WFR */
+	if (ppd->dd->params->chip_type == CHIP_WFR)
+		return 0;
+
+	/*
+	 * Redirect MAD responses and traps to the driver. Use this port's
+	 * receive control context.
+	 */
+	ret = do_port_mapping(ppd, rmt, mad_response_rules,
+			      ARRAY_SIZE(mad_response_rules),
+			      ppd->rcv_context_base + HFI2_CTRL_CTXT,
+			      RSM_TYPE_MAD_RSP);
+	if (ret)
+		return ret;
+
+	/*
+	 * Redirect MAD actions to the cport.  Cport owns the same receive
+	 * context as the port index.
+	 */
+	ret = do_port_mapping(ppd, rmt, mad_action_rules,
+			      ARRAY_SIZE(mad_action_rules),
+			      ppd->hw_pidx,
+			      RSM_TYPE_MAD_ACTION);
+	return ret;
+}
+
+static int init_rxe(struct hfi2_devdata *dd)
+{
+	struct rsm_map_table *rmt;
+	u64 val;
+	int i;
+	int ret;
+
+	/* enable all receive errors */
+	for (i = 0; i < dd->num_pports; i++)
+		write_iport_csr(dd, i, dd->params->rcv_err_mask_reg, ~0ull);
+
+	rmt = alloc_rsm_map_table(dd);
+	if (!rmt)
+		return -ENOMEM;
+
+	/* set up QOS, including the QPN map table */
+	init_qos(dd, rmt);
+	for (i = 0; i < dd->num_pports; i++) {
+		ret = init_port_mapping(dd->pport + i, rmt);
+		if (ret)
+			goto done;
+		init_fecn_handling(dd->pport + i, rmt);
+	}
+	complete_rsm_map_table(dd, rmt);
+	/* reserve RMT entries for netdev */
+	for (i = 0; i < dd->num_pports; i++) {
+		ret = hfi2_netdev_set_free_rmt_idx(&dd->pport[i], rmt);
+		if (ret < 0)
+			goto done;
+	}
+
+	/*
+	 * make sure RcvCtrl.RcvWcb <= PCIe Device Control
+	 * Register Max_Payload_Size (PCI_EXP_DEVCTL in Linux PCIe config
+	 * space, PciCfgCap2.MaxPayloadSize in HFI).  There is only one
+	 * invalid configuration: RcvCtrl.RcvWcb set to its max of 256 and
+	 * Max_PayLoad_Size set to its minimum of 128.
+	 *
+	 * Presently, RcvCtrl.RcvWcb is not modified from its default of 0
+	 * (64 bytes).  Max_Payload_Size is possibly modified upward in
+	 * tune_pcie_caps() which is called after this routine.
+	 */
+
+	for (i = 0; i < dd->num_pports; i++) {
+		u64 control = dd->pport[i].rcv_context_base + HFI2_CTRL_CTXT;
+
+		/* set 16 bytes (4 DW) header available in header queue */
+		/* set bypass context to the port control context */
+		val = (4ull << RCV_BYPASS_HDR_SIZE_SHIFT) | control;
+		write_iport_csr(dd, i, dd->params->rcv_bypass_reg, val);
+
+		write_iport_csr(dd, i, dd->params->rcv_multicast_reg, control);
+	}
+	ret = 0;
+
+done:
+	kfree(rmt);
+	return ret;
+}
+
+void init_other(struct hfi2_devdata *dd)
+{
+	/* enable all CCE errors */
+	write_csr(dd, CCE_ERR_MASK, ~0ull);
+	/* enable *some* Misc errors */
+	write_csr(dd, MISC_ERR_MASK, DRIVER_MISC_MASK);
+	/* enable all DC errors, except LCB */
+	write_csr(dd, DCC_ERR_FLG_EN, ~0ull);
+	write_csr(dd, DC_DC8051_ERR_EN, ~0ull);
+}
+
+/*
+ * Fill out the given AU table using the given CU.  A CU is defined in terms
+ * AUs.  The table is a an encoding: given the index, how many AUs does that
+ * represent?
+ *
+ * NOTE: Assumes that the register layout is the same for the
+ * local and remote tables.
+ */
+static void assign_cm_au_table(struct hfi2_pportdata *ppd, u32 cu,
+			       u32 csr0to3, u32 csr4to7)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int pidx = ppd->hw_pidx;
+
+	if (dd->params->chip_type != CHIP_WFR)
+		return;
+
+	write_eport_csr(dd, pidx, csr0to3,
+			0ull << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE0_SHIFT |
+			1ull << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE1_SHIFT |
+			2ull * cu << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE2_SHIFT |
+			4ull * cu << SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE3_SHIFT);
+	write_eport_csr(dd, pidx, csr4to7,
+			8ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE4_SHIFT |
+			16ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE5_SHIFT |
+			32ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE6_SHIFT |
+			64ull * cu << SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE7_SHIFT);
+}
+
+static void assign_local_cm_au_table(struct hfi2_pportdata *ppd, u8 vcu)
+{
+	assign_cm_au_table(ppd, vcu_to_cu(vcu), ppd->dd->params->send_cm_local_au_table0_to3_reg,
+			   ppd->dd->params->send_cm_local_au_table4_to7_reg);
+}
+
+void assign_remote_cm_au_table(struct hfi2_pportdata *ppd, u8 vcu)
+{
+	assign_cm_au_table(ppd, vcu_to_cu(vcu), ppd->dd->params->send_cm_remote_au_table0_to3_reg,
+			   ppd->dd->params->send_cm_remote_au_table4_to7_reg);
+}
+
+static void init_txe(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* enable all PIO, SDMA, general, and Egress errors */
+	write_csr(dd, dd->params->send_pio_err_mask_reg, ~0ull);
+	write_csr(dd, dd->params->send_dma_err_mask_reg, ~0ull);
+	write_csr(dd, dd->params->csr_err_mask_reg, ~0ull);
+	for (i = 0; i < dd->num_pports; i++) {
+		write_eport_csr(dd, i, dd->params->send_egress_err_mask_reg,
+				~0ull);
+	}
+
+	/* enable all per-context and per-SDMA engine errors */
+	for (i = dd->first_send_context; i < chip_send_contexts(dd); i++)
+		write_sctxt_csr(dd, i, dd->params->send_ctxt_err_mask_reg, ~0ull);
+	for (i = 0; i < chip_sdma_engines(dd); i++)
+		write_sdma_csr(dd, i, dd->params->send_dma_eng_err_mask_reg, ~0ull);
+
+	/* set the local CU to AU mapping */
+	for (i = 0; i < dd->num_pports; i++)
+		assign_local_cm_au_table(dd->pport + i, dd->vcu);
+
+	/*
+	 * Set reasonable default for Credit Return Timer
+	 */
+	if (dd->params->chip_type == CHIP_WFR) {
+		for (i = 0; i < dd->num_pports; i++) {
+			write_eport_csr(dd, i,
+					dd->params->send_cm_timer_ctrl_reg,
+					HFI2_CREDIT_RETURN_RATE);
+		}
+	}
+}
+
+int hfi2_set_ctxt_jkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd,
+		       u16 jkey)
+{
+	int pidx;
+	u16 hw_ctxt;
+	u64 reg;
+
+	if (!rcd || !rcd->sc)
+		return -EINVAL;
+
+	pidx = rcd->ppd->hw_pidx;
+	hw_ctxt = rcd->sc->hw_context;
+	reg = SEND_CTXT_CHECK_JOB_KEY_MASK_SMASK | /* mask is always 1's */
+		((jkey & SEND_CTXT_CHECK_JOB_KEY_VALUE_MASK) <<
+		 SEND_CTXT_CHECK_JOB_KEY_VALUE_SHIFT);
+	/* JOB_KEY_ALLOW_PERMISSIVE is not allowed by default */
+	if (HFI2_CAP_KGET_MASK(rcd->flags, ALLOW_PERM_JKEY))
+		reg |= SEND_CTXT_CHECK_JOB_KEY_ALLOW_PERMISSIVE_SMASK;
+	write_epsc_csr(dd, pidx, hw_ctxt, dd->params->send_ctxt_check_job_key_reg, reg);
+	/*
+	 * Enable send-side J_KEY integrity check, unless this is A0 h/w
+	 */
+	if (!is_ax(dd)) {
+		dd->params->set_pio_integrity(rcd->sc, SPI_SET_JKEY);
+	}
+
+	/* Enable J_KEY check on receive context. */
+	reg = RCV_KEY_CTRL_JOB_KEY_ENABLE_SMASK |
+		((jkey & RCV_KEY_CTRL_JOB_KEY_VALUE_MASK) <<
+		 RCV_KEY_CTRL_JOB_KEY_VALUE_SHIFT);
+	write_iprc_csr(dd, pidx, rcd->ctxt, dd->params->rcv_jkey_ctrl_reg, reg);
+
+	return 0;
+}
+
+int hfi2_clear_ctxt_jkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd)
+{
+	int pidx;
+	u16 hw_ctxt;
+
+	if (!rcd || !rcd->sc)
+		return -EINVAL;
+
+	pidx = rcd->ppd->hw_pidx;
+	hw_ctxt = rcd->sc->hw_context;
+	write_epsc_csr(dd, pidx, hw_ctxt, dd->params->send_ctxt_check_job_key_reg, 0);
+	/*
+	 * Disable send-side J_KEY integrity check, unless this is A0 h/w.
+	 * This check would not have been enabled for A0 h/w, see
+	 * set_ctxt_jkey().
+	 */
+	if (!is_ax(dd)) {
+		dd->params->set_pio_integrity(rcd->sc, SPI_CLEAR_JKEY);
+	}
+	/* Turn off the J_KEY on the receive side */
+	write_iprc_csr(dd, pidx, rcd->ctxt, dd->params->rcv_jkey_ctrl_reg, 0);
+
+	return 0;
+}
+
+int hfi2_set_ctxt_pkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd,
+		       u16 pkey)
+{
+	int pidx;
+	u16 hw_ctxt;
+	u64 reg;
+
+	if (!rcd || !rcd->sc)
+		return -EINVAL;
+
+	pidx = rcd->ppd->hw_pidx;
+	hw_ctxt = rcd->sc->hw_context;
+	reg = ((u64)pkey & SEND_CTXT_CHECK_PARTITION_KEY_VALUE_MASK) <<
+		SEND_CTXT_CHECK_PARTITION_KEY_VALUE_SHIFT;
+	write_epsc_csr(dd, pidx, hw_ctxt, dd->params->send_ctxt_check_partition_key_reg, reg);
+	dd->params->set_pio_integrity(rcd->sc, SPI_SET_PKEY);
+
+	return 0;
+}
+
+int hfi2_clear_ctxt_pkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *ctxt)
+{
+	int pidx;
+	u16 hw_ctxt;
+
+	if (!ctxt || !ctxt->sc)
+		return -EINVAL;
+
+	pidx = ctxt->ppd->hw_pidx;
+	hw_ctxt = ctxt->sc->hw_context;
+	dd->params->set_pio_integrity(ctxt->sc, SPI_CLEAR_PKEY);
+	write_epsc_csr(dd, pidx, hw_ctxt, dd->params->send_ctxt_check_partition_key_reg, 0);
+
+	return 0;
+}
+
+/*
+ * Start doing the clean up the chip. Our clean up happens in multiple
+ * stages and this is just the first.
+ */
+void hfi2_start_cleanup(struct hfi2_devdata *dd)
+{
+	aspm_exit(dd);
+	free_cntrs(dd);
+	finish_chip_resources(dd);
+}
+
+#define HFI_BASE_GUID(dev) \
+	((dev)->base_guid & ~(1ULL << GUID_HFI_INDEX_SHIFT))
+
+/*
+ * Information can be shared between the two HFIs on the same ASIC
+ * in the same OS.  This function finds the peer device and sets
+ * up a shared structure.
+ */
+static int init_asic_data(struct hfi2_devdata *dd)
+{
+	unsigned long index;
+	struct hfi2_devdata *peer;
+	struct hfi2_asic_data *asic_data;
+	int ret = 0;
+
+	/* pre-allocate the asic structure in case we are the first device */
+	asic_data = kzalloc(sizeof(*dd->asic_data), GFP_KERNEL);
+	if (!asic_data)
+		return -ENOMEM;
+
+	xa_lock_irq(&hfi2_dev_table);
+	/* Find our peer device */
+	xa_for_each(&hfi2_dev_table, index, peer) {
+		if ((HFI_BASE_GUID(dd) == HFI_BASE_GUID(peer)) &&
+		    dd->unit != peer->unit)
+			break;
+	}
+
+	if (peer) {
+		/* use already allocated structure */
+		dd->asic_data = peer->asic_data;
+		kfree(asic_data);
+	} else {
+		dd->asic_data = asic_data;
+		mutex_init(&dd->asic_data->asic_resource_mutex);
+	}
+	dd->asic_data->dds[dd->hfi2_id] = dd; /* self back-pointer */
+	xa_unlock_irq(&hfi2_dev_table);
+
+	/* first one through - set up i2c devices */
+	if (!peer)
+		ret = set_up_i2c(dd, dd->asic_data);
+
+	return ret;
+}
+
+/*
+ * Set dd->boardname.  Use a generic name if a name is not returned from
+ * EFI variable space.
+ *
+ * Return 0 on success, -ENOMEM if space could not be allocated.
+ */
+static int obtain_boardname(struct hfi2_devdata *dd)
+{
+	unsigned long size;
+	int ret;
+
+	ret = read_hfi2_efi_var(dd, "description", &size,
+				(void **)&dd->boardname);
+	if (ret) {
+		dd_dev_info(dd, "Board description not found\n");
+		/* use generic description */
+		dd->boardname = kstrdup(dd->params->generic_boardname,
+					GFP_KERNEL);
+		if (!dd->boardname)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+/*
+ * Check the interrupt registers to make sure that they are mapped correctly.
+ * It is intended to help user identify any mismapping by VMM when the driver
+ * is running in a VM. This function should only be called before interrupt
+ * is set up properly.
+ *
+ * Return 0 on success, -EINVAL on failure.
+ */
+static int check_int_registers(struct hfi2_devdata *dd)
+{
+	u64 reg;
+	u64 all_bits = ~(u64)0;
+	u64 mask;
+
+	/* Clear CceIntMask[0] to avoid raising any interrupts */
+	mask = read_csr(dd, CCE_INT_MASK);
+	write_csr(dd, CCE_INT_MASK, 0ull);
+	reg = read_csr(dd, CCE_INT_MASK);
+	if (reg)
+		goto err_exit;
+
+	/* Clear all interrupt status bits */
+	write_csr(dd, CCE_INT_CLEAR, all_bits);
+	reg = read_csr(dd, CCE_INT_STATUS);
+	if (reg)
+		goto err_exit;
+
+	/* Set all interrupt status bits */
+	write_csr(dd, CCE_INT_FORCE, all_bits);
+	reg = read_csr(dd, CCE_INT_STATUS);
+	if (reg != all_bits)
+		goto err_exit;
+
+	/* Restore the interrupt mask */
+	write_csr(dd, CCE_INT_CLEAR, all_bits);
+	write_csr(dd, CCE_INT_MASK, mask);
+
+	return 0;
+err_exit:
+	write_csr(dd, CCE_INT_MASK, mask);
+	dd_dev_err(dd, "Interrupt registers not properly mapped by VMM\n");
+	return -EINVAL;
+}
+
+int wfr_find_used_resources(struct hfi2_devdata *dd)
+{
+	/* set resource allocation start values */
+	dd->first_rcvarray_entry = 0;
+	dd->first_pio_block = 1; /* do not use block 0, HAS entry 291585 */
+	dd->first_rcv_context = 0;
+	dd->first_send_context = 0;
+	dd->rsm_rule_init = true;
+
+	return 0;
+}
+
+/* early WFR specific chip init */
+int wfr_early_per_chip_init(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	/* set up shared ASIC data with peer device */
+	ret = init_asic_data(dd);
+	if (ret)
+		return ret;
+
+	/* obtain chip sizes, reset chip CSRs */
+	ret = init_chip(dd);
+	if (ret)
+		return ret;
+
+	/* read in the PCIe link speed information */
+	ret = pcie_speeds(dd);
+	if (ret)
+		return ret;
+
+	/* call before get_platform_config(), after init_chip_resources() */
+	ret = eprom_init(dd);
+	if (ret)
+		return ret;
+
+	/* Needs to be called before hfi2_firmware_init */
+	get_platform_config(&dd->pport[HFI2_PORT_IDX]);
+
+	/* read in firmware */
+	ret = hfi2_firmware_init(dd);
+	if (ret)
+		return ret;
+
+	/*
+	 * In general, the PCIe Gen3 transition must occur after the
+	 * chip has been idled (so it won't initiate any PCIe transactions
+	 * e.g. an interrupt) and before the driver changes any registers
+	 * (the transition will reset the registers).
+	 *
+	 * In particular, place this call after:
+	 * - init_chip()     - the chip will not initiate any PCIe transactions
+	 * - pcie_speeds()   - reads the current link speed
+	 * - hfi2_firmware_init() - the needed firmware is ready to be
+	 *			    downloaded
+	 */
+	ret = do_pcie_gen3_transition(dd);
+	if (ret)
+		return ret;
+
+	/*
+	 * This should probably occur in hfi2_pcie_init(), but historically
+	 * occurs after the do_pcie_gen3_transition() code.
+	 */
+	tune_pcie_caps(dd);
+
+	/* start setting dd values and adjusting CSRs */
+	init_early_variables(dd);
+
+	write_uninitialized_csrs_and_memories(dd);
+
+	parse_platform_config(&dd->pport[HFI2_PORT_IDX]);
+
+	return 0;
+}
+
+int wfr_mid_per_chip_init(struct hfi2_devdata *dd)
+{
+	return 0;
+}
+
+int wfr_late_per_chip_init(struct hfi2_devdata *dd)
+{
+	/* set up LCB access - must be after set_up_interrupts() */
+	init_lcb_access(dd);
+
+	return load_firmware(dd); /* asymmetric with dispose_firmware() */
+}
+
+/**
+ * hfi2_init_dd() - Initialize most of the dd structure.
+ * @dd: the dd device
+ *
+ * This is global, and is called directly at init to set up the
+ * chip-specific function pointers for later use.
+ */
+int hfi2_init_dd(struct hfi2_devdata *dd)
+{
+	struct pci_dev *pdev = dd->pcidev;
+	struct hfi2_pportdata *ppd;
+	u64 reg;
+	int i, ret;
+	static const char * const inames[] = { /* implementation names */
+		"RTL silicon",
+		"RTL VCS simulation",
+		"RTL FPGA emulation",
+		"Functional simulator"
+	};
+	struct pci_dev *parent = pdev->bus->self;
+
+	/*
+	 * Do remaining PCIe setup.  Error messaging is done by the callee.
+	 * On return, the BAR is mapped and register access is enabled.
+	 */
+	ret = hfi2_pcie_ddinit(dd, pdev);
+	if (ret < 0)
+		goto bail;
+
+	if (num_vls < HFI2_MIN_VLS_SUPPORTED ||
+	    num_vls > HFI2_MAX_VLS_SUPPORTED) {
+		dd_dev_err(dd, "Invalid num_vls %u, using %u VLs\n",
+			   num_vls, HFI2_MAX_VLS_SUPPORTED);
+		num_vls = HFI2_MAX_VLS_SUPPORTED;
+	}
+
+	/*
+	 * Decide on number of SDMA engines to use based on hardware
+	 * availability, number of VLs, and module parameter.
+	 */
+	if (HFI2_CAP_IS_KSET(SDMA)) {
+		u32 sdma_engines = chip_sdma_engines(dd);
+
+		/* insure num_vls isn't larger than number of sdma engines */
+		if (num_vls > sdma_engines) {
+			dd_dev_err(dd, "num_vls %u too large, using %u VLs\n",
+				   num_vls, sdma_engines);
+			num_vls = sdma_engines;
+		}
+
+		if (mod_num_sdma &&
+		    /* can't exceed chip support */
+		    mod_num_sdma <= sdma_engines &&
+		    /* count must be >= vls */
+		    mod_num_sdma >= num_vls)
+			sdma_engines = mod_num_sdma;
+
+		dd->num_sdma = sdma_engines;
+	} else {
+		HFI2_CAP_CLEAR(SDMA_AHG);
+		dd->num_sdma = 0;
+	}
+
+	ppd = dd->pport;
+	for (i = 0; i < dd->num_pports; i++, ppd++) {
+		int vl;
+		/* init common fields */
+		hfi2_init_pportdata(pdev, ppd, dd, i, i + 1);
+		/* DC supports 4 link widths */
+		ppd->link_width_supported =
+			OPA_LINK_WIDTH_1X | OPA_LINK_WIDTH_2X |
+			OPA_LINK_WIDTH_3X | OPA_LINK_WIDTH_4X;
+		ppd->link_width_downgrade_supported =
+			ppd->link_width_supported;
+		/* start out enabling only 4X */
+		ppd->link_width_enabled = OPA_LINK_WIDTH_4X;
+		ppd->link_width_downgrade_enabled =
+					ppd->link_width_downgrade_supported;
+		/* link width active is 0 when link is down */
+		/* link width downgrade active is 0 when link is down */
+
+		ppd->vls_supported = num_vls;
+		ppd->vls_operational = ppd->vls_supported;
+		/* Set the default MTU. */
+		for (vl = 0; vl < num_vls; vl++)
+			ppd->vld[vl].mtu = hfi2_max_mtu;
+		ppd->vld[15].mtu = MAX_MAD_PACKET;
+
+		/*
+		 * Set the initial values to reasonable default, will be set
+		 * for real when link is up.
+		 */
+		ppd->overrun_threshold = 0x4;
+		ppd->phy_error_threshold = 0xf;
+		ppd->port_crc_mode_enabled = link_crc_mask;
+		/* initialize supported LTP CRC mode */
+		ppd->port_ltp_crc_mode = cap_to_port_ltp(link_crc_mask) << 8;
+		/* initialize enabled LTP CRC mode */
+		ppd->port_ltp_crc_mode |= cap_to_port_ltp(link_crc_mask) << 4;
+		/* start in offline */
+		ppd->host_link_state = HLS_DN_OFFLINE;
+		init_vl_arb_caches(ppd);
+
+		/* speeds the hardware can support */
+		ppd->link_speed_supported = dd->params->link_speed_supported;
+		/* speeds allowed to run at */
+		ppd->link_speed_enabled = ppd->link_speed_supported;
+		/* give a reasonable active value, will be set on link up */
+		ppd->link_speed_active = dd->params->link_speed_active;
+	}
+
+	/* Save PCI space registers to rewrite after device reset */
+	ret = save_pci_variables(dd);
+	if (ret < 0)
+		goto bail_cleanup;
+
+	dd->majrev = (dd->revision >> CCE_REVISION_CHIP_REV_MAJOR_SHIFT)
+			& CCE_REVISION_CHIP_REV_MAJOR_MASK;
+	dd->minrev = (dd->revision >> CCE_REVISION_CHIP_REV_MINOR_SHIFT)
+			& CCE_REVISION_CHIP_REV_MINOR_MASK;
+
+	/*
+	 * Check interrupt registers mapping if the driver has no access to
+	 * the upstream component. In this case, it is likely that the driver
+	 * is running in a VM.
+	 */
+	if (!parent) {
+		ret = check_int_registers(dd);
+		if (ret)
+			goto bail_cleanup;
+	}
+
+	/*
+	 * obtain the hardware ID - NOT related to unit, which is a
+	 * software enumeration
+	 */
+	reg = read_csr(dd, CCE_REVISION2);
+	dd->hfi2_id = (reg >> CCE_REVISION2_HFI_ID_SHIFT)
+					& CCE_REVISION2_HFI_ID_MASK;
+	/* the variable size will remove unwanted bits */
+	dd->icode = reg >> CCE_REVISION2_IMPL_CODE_SHIFT;
+	dd->irev = reg >> CCE_REVISION2_IMPL_REVISION_SHIFT;
+	dd_dev_info(dd, "Implementation: %s, revision 0x%x\n",
+		    dd->icode < ARRAY_SIZE(inames) ?
+		    inames[dd->icode] : "unknown", (int)dd->irev);
+
+	/*
+	 * Convert the ns parameter to the 64 * cclocks used in the CSR.
+	 * Limit the max if larger than the field holds.  If timeout is
+	 * non-zero, then the calculated field will be at least 1.
+	 *
+	 * Must be after icode is set up - the cclock rate depends
+	 * on knowing the hardware being used.
+	 */
+	dd->rcv_intr_timeout_csr = ns_to_cclock(dd, rcv_intr_timeout) / 64;
+	if (dd->rcv_intr_timeout_csr >
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_MASK)
+		dd->rcv_intr_timeout_csr =
+			RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_MASK;
+	else if (dd->rcv_intr_timeout_csr == 0 && rcv_intr_timeout)
+		dd->rcv_intr_timeout_csr = 1;
+
+	/* find resources already consumed */
+	ret = dd->params->find_used_resources(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	ret = set_up_context_variables(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	ret = dd->params->early_per_chip_init(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	ret = set_up_interrupts(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	ret = start_cport(dd);
+	if (ret)
+		goto bail_cleanup;
+
+	/* needs to be done before we look for the peer device */
+	dd->params->read_guid(dd);
+	dd_dev_info(dd, "GUID %llx",
+		    (unsigned long long)dd->base_guid);
+
+	ret = dd->params->mid_per_chip_init(dd);
+	if (ret)
+		goto bail_clean_early_intr;
+
+	ret = obtain_boardname(dd);
+	if (ret)
+		goto bail_clean_early_intr;
+
+	snprintf(dd->boardversion, BOARD_VERS_MAX,
+		 "ChipABI %u.%u, ChipRev %u.%u, SW Compat %llu\n",
+		 HFI2_CHIP_VERS_MAJ, HFI2_CHIP_VERS_MIN,
+		 (u32)dd->majrev,
+		 (u32)dd->minrev,
+		 (dd->revision >> CCE_REVISION_SW_SHIFT)
+		    & CCE_REVISION_SW_MASK);
+
+	/* alloc AIP rx data */
+	ret = hfi2_alloc_rx(dd);
+	if (ret)
+		goto bail_free_boardname;
+
+	/* set initial RXE CSRs */
+	ret = init_rxe(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/* set initial TXE CSRs */
+	init_txe(dd);
+	/* set initial non-RXE, non-TXE CSRs */
+	dd->params->init_other(dd);
+	/* set up KDETH QP prefix in both RX and TX CSRs */
+	init_kdeth_qp(dd);
+
+	ret = hfi2_dev_affinity_init(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/* send contexts must be set up before receive contexts */
+	ret = init_send_contexts(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	ret = hfi2_create_kctxts(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/*
+	 * Initialize aspm, to be done after gen3 transition and setting up
+	 * contexts and before enabling interrupts
+	 */
+	aspm_init(dd);
+
+	/* per-vl send context and sdma init */
+	for (i = 0; i < dd->num_pports; ++i) {
+		ret = init_pervl_scs(dd->pport + i);
+		if (ret)
+			goto bail_free_rx;
+	}
+	ret = sdma_init(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	/* use contexts created by hfi2_create_kctxts */
+	ret = late_set_up_interrupts(dd);
+	if (ret)
+		goto bail_free_rx;
+
+	ret = hfi2_comp_vectors_set_up(dd);
+	if (ret)
+		goto bail_clear_comp_vectors;
+
+	ret = dd->params->late_per_chip_init(dd);
+	if (ret)
+		goto bail_clear_comp_vectors;
+
+	/*
+	 * Serial number is created from the base guid:
+	 * [27:24] = base guid [38:35]
+	 * [23: 0] = base guid [23: 0]
+	 */
+	snprintf(dd->serial, SERIAL_MAX, "0x%08llx\n",
+		 (dd->base_guid & 0xFFFFFF) |
+		     ((dd->base_guid >> 11) & 0xF000000));
+
+	dd->oui1 = dd->base_guid >> 56 & 0xFF;
+	dd->oui2 = dd->base_guid >> 48 & 0xFF;
+	dd->oui3 = dd->base_guid >> 40 & 0xFF;
+
+	thermal_init(dd);
+
+	ret = init_cntrs(dd);
+	if (ret)
+		goto bail_clear_comp_vectors;
+
+	init_completion(&dd->user_comp);
+
+	/* The user refcount starts with one to inidicate an active device */
+	refcount_set(&dd->user_refcount, 1);
+
+	goto bail;
+
+bail_clear_comp_vectors:
+	hfi2_comp_vectors_clean_up(dd);
+bail_free_rx:
+	hfi2_free_rx(dd);
+bail_free_boardname:
+	kfree(dd->boardname);
+	dd->boardname = NULL;
+bail_clean_early_intr:
+	msix_clean_up_interrupts(dd);
+bail_cleanup:
+	hfi2_pcie_ddcleanup(dd);
+bail:
+	return ret;
+}
+
+static u16 delay_cycles(struct hfi2_pportdata *ppd, u32 desired_egress_rate,
+			u32 dw_len)
+{
+	u32 delta_cycles;
+	u32 current_egress_rate = ppd->current_egress_rate;
+	/* rates here are in units of 10^6 bits/sec */
+
+	if (desired_egress_rate == -1)
+		return 0; /* shouldn't happen */
+
+	if (desired_egress_rate >= current_egress_rate)
+		return 0; /* we can't help go faster, only slower */
+
+	delta_cycles = egress_cycles(dw_len * 4, desired_egress_rate) -
+			egress_cycles(dw_len * 4, current_egress_rate);
+
+	return (u16)delta_cycles;
+}
+
+/**
+ * wfr_create_pbc - build a pbc for transmission
+ * @ppd: info of physical Hfi port
+ * @flags: special case flags or-ed in built pbc
+ * @srate_mbs: static rate
+ * @vl: vl
+ * @dw_len: dword length (header words + data words + pbc words)
+ * @l2: L2 header field - determines type
+ * @dlid: destination LID - unused
+ * @sctxt: send context number - unused
+ *
+ * Create a PBC with the given flags, rate, VL, and length.
+ *
+ * NOTE: The PBC created will not insert any HCRC - all callers but one are
+ * for verbs, which does not use this PSM feature.  The lone other caller
+ * is for the diagnostic interface which calls this if the user does not
+ * supply their own PBC.
+ */
+u64 wfr_create_pbc(struct hfi2_pportdata *ppd, u64 flags, int srate_mbs, u32 vl,
+		   u32 dw_len, u32 l2, u32 dlid, u32 sctxt)
+{
+	u64 pbc, delay = 0;
+
+	if (unlikely(srate_mbs))
+		delay = delay_cycles(ppd, srate_mbs, dw_len);
+
+	/* on WFR, non-9B are always bypass */
+	if (l2 != PBC_L2_9B)
+		flags |= PBC_PACKET_BYPASS | PBC_INSERT_BYPASS_ICRC;
+
+	pbc = flags
+		| (delay << PBC_STATIC_RATE_CONTROL_COUNT_SHIFT)
+		| ((u64)PBC_IHCRC_NONE << PBC_INSERT_HCRC_SHIFT)
+		| (vl & PBC_VL_MASK) << PBC_VL_SHIFT
+		| (dw_len & PBC_LENGTH_DWS_MASK)
+			<< PBC_LENGTH_DWS_SHIFT;
+
+	return pbc;
+}
+
+#define SBUS_THERMAL    0x4f
+#define SBUS_THERM_MONITOR_MODE 0x1
+
+#define THERM_FAILURE(dev, ret, reason) \
+	dd_dev_err((dd),						\
+		   "Thermal sensor initialization failed: %s (%d)\n",	\
+		   (reason), (ret))
+
+/*
+ * Initialize the thermal sensor.
+ *
+ * After initialization, enable polling of thermal sensor through
+ * SBus interface. In order for this to work, the SBus Master
+ * firmware has to be loaded due to the fact that the HW polling
+ * logic uses SBus interrupts, which are not supported with
+ * default firmware. Otherwise, no data will be returned through
+ * the ASIC_STS_THERM CSR.
+ */
+static int thermal_init(struct hfi2_devdata *dd)
+{
+	int ret = 0;
+
+	if (dd->icode != ICODE_RTL_SILICON ||
+	    dd->params->chip_type != CHIP_WFR ||
+	    check_chip_resource(dd, CR_THERM_INIT, NULL))
+		return ret;
+
+	ret = acquire_chip_resource(dd, CR_SBUS, SBUS_TIMEOUT);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Acquire SBus");
+		return ret;
+	}
+
+	dd_dev_info(dd, "Initializing thermal sensor\n");
+	/* Disable polling of thermal readings */
+	write_csr(dd, ASIC_CFG_THERM_POLL_EN, 0x0);
+	msleep(100);
+	/* Thermal Sensor Initialization */
+	/*    Step 1: Reset the Thermal SBus Receiver */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x0,
+				RESET_SBUS_RECEIVER, 0);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Bus Reset");
+		goto done;
+	}
+	/*    Step 2: Set Reset bit in Thermal block */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x0,
+				WRITE_SBUS_RECEIVER, 0x1);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Therm Block Reset");
+		goto done;
+	}
+	/*    Step 3: Write clock divider value (100MHz -> 2MHz) */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x1,
+				WRITE_SBUS_RECEIVER, 0x32);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Write Clock Div");
+		goto done;
+	}
+	/*    Step 4: Select temperature mode */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x3,
+				WRITE_SBUS_RECEIVER,
+				SBUS_THERM_MONITOR_MODE);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Write Mode Sel");
+		goto done;
+	}
+	/*    Step 5: De-assert block reset and start conversion */
+	ret = sbus_request_slow(dd, SBUS_THERMAL, 0x0,
+				WRITE_SBUS_RECEIVER, 0x2);
+	if (ret) {
+		THERM_FAILURE(dd, ret, "Write Reset Deassert");
+		goto done;
+	}
+	/*    Step 5.1: Wait for first conversion (21.5ms per spec) */
+	msleep(22);
+
+	/* Enable polling of thermal readings */
+	write_csr(dd, ASIC_CFG_THERM_POLL_EN, 0x1);
+
+	/* Set initialized flag */
+	ret = acquire_chip_resource(dd, CR_THERM_INIT, 0);
+	if (ret)
+		THERM_FAILURE(dd, ret, "Unable to set thermal init flag");
+
+done:
+	release_chip_resource(dd, CR_SBUS);
+	return ret;
+}
+
+void handle_temp_err(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int pidx;
+	/*
+	 * Thermal Critical Interrupt
+	 * Put the device into forced freeze mode, take link down to
+	 * offline, and put DC into reset.
+	 */
+	dd_dev_emerg(dd,
+		     "Critical temperature reached! Forcing device into freeze mode!\n");
+	dd->flags |= HFI2_FORCED_FREEZE;
+
+	start_freeze_handling(dd, FREEZE_SELF | FREEZE_ABORT);
+	for (pidx = 0; pidx < dd->num_pports; ++pidx) {
+		ppd = dd->pport + pidx;
+
+		/*
+		 * Shut DC down as much and as quickly as possible.
+		 *
+		 * Step 1: Iterate over the ports and take the links down to OFFLINE.
+		 *	   This will cause the 8051 to put the Serdes in reset. However,
+		 *	   we don't want to go through the entire link state machine since
+		 *	   we want to shutdown ASAP. Furthermore, this is not a graceful
+		 *	   shutdown but rather an attempt to save the chip.
+		 *         Code below is almost the same as quiet_serdes() but avoids
+		 *         all the extra work and the sleeps.
+		 */
+		ppd->driver_link_ready = 0;
+		ppd->link_enabled = 0;
+	}
+
+	set_physical_link_state(dd, (OPA_LINKDOWN_REASON_SMA_DISABLED << 8) |
+				PLS_OFFLINE);
+	/*
+	 * Step 2: Shutdown LCB and 8051
+	 *         After shutdown, do not restore DC_CFG_RESET value.
+	 */
+	dc_shutdown(dd);
+}
diff --git a/drivers/infiniband/hw/hfi2/chip_gen.c b/drivers/infiniband/hw/hfi2/chip_gen.c
new file mode 100644
index 000000000000..78ebe950fe1e
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_gen.c
@@ -0,0 +1,504 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2023 - Cornelis Networks, Inc.
+ *
+ * Generalized (parameterized) chip specific functions and variables.
+ */
+
+#include "hfi2.h"
+#include "chip_gen.h"
+#include "cport_traps.h"
+
+#undef DEBUG_CPORT_TRAP
+
+/*
+ * Control the port LED state.  Cancel with gen_shutdown_led_override().
+ */
+void gen_setextled(struct hfi2_pportdata *ppd, u32 on)
+{
+	ppd_dev_warn(ppd, "%s: on %d, JKR TODO\n", __func__, on);
+}
+
+/*
+ * Make the port LED blink in pattern.  Parameters timeon and timeoff are
+ * in milliseconds.  Cancel with gen_shutdown_led_override().
+ */
+void gen_start_led_override(struct hfi2_pportdata *ppd, unsigned int timeon,
+			    unsigned int timeoff)
+{
+	ppd_dev_warn(ppd, "%s: JKR TODO\n", __func__);
+
+	/* used by the subnet manager to know if it set beaconing */
+	atomic_set(&ppd->led_override_timer_active, 1);
+	/* ensure the atomic_set is visible to all CPUs */
+	smp_wmb();
+}
+
+/*
+ * Return to normal LED operation.  This cancels overrides started with
+ * gen_setextled() or gen_start_led_override().
+ */
+void gen_shutdown_led_override(struct hfi2_pportdata *ppd)
+{
+	ppd_dev_warn(ppd, "%s: JKR TODO\n", __func__);
+
+	/* used by the subnet manager to know if it set beaconing */
+	atomic_set(&ppd->led_override_timer_active, 0);
+	/* ensure the atomic_set is visible to all CPUs */
+	smp_wmb();
+}
+
+void gen_read_guid(struct hfi2_devdata *dd)
+{
+	dd_dev_warn(dd, "%s: JKR TODO\n", __func__);
+
+	dd->base_guid = 0xabcd;
+}
+
+int gen_late_per_chip_init(struct hfi2_devdata *dd)
+{
+	return 0;
+}
+
+void gen_start_port(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 guid;
+
+	guid = ppd->guids[HFI2_PORT_GUID_INDEX];
+	if (!guid) {
+		/* OPA spec says bits 34:32 are port number, 1-7 */
+		if (dd->base_guid)
+			guid = (dd->base_guid & ~(7ULL << 32)) | ((u64)ppd->port << 32);
+		ppd->guids[HFI2_PORT_GUID_INDEX] = guid;
+		pr_warn("%s: ppd->guids[HFI2_PORT_GUID_INDEX] = 0x%llx",
+			__func__, guid);
+	}
+}
+
+void gen_stop_port(struct hfi2_pportdata *ppd)
+{
+	ppd_dev_warn(ppd, "%s: pidx %d, JKR TODO\n", __func__, ppd->hw_pidx);
+}
+
+void gen_set_port_max_mtu(struct hfi2_pportdata *ppd, u32 maxvlmtu)
+{
+	ppd_dev_warn(ppd, "%s: pidx %d, JKR TODO\n", __func__, ppd->hw_pidx);
+}
+
+/**
+ * gen_create_pbc - build a pbc for transmission
+ * @ppd: info of physical Hfi port
+ * @flags: special case flags or-ed in built pbc
+ * @srate_mbs: static rate - unused
+ * @vl: vl
+ * @dw_len: dword length (header words + data words + pbc words)
+ * @l2: L2 header field - determines type
+ * @dlid: destination LID
+ * @sctxt: send context number
+ *
+ * Create a PBC with the given flags, rate, VL, and length.
+ *
+ * NOTE: The PBC created will not insert any HCRC.
+ */
+u64 gen_create_pbc(struct hfi2_pportdata *ppd, u64 flags, int srate_mbs, u32 vl,
+		   u32 dw_len, u32 l2, u32 dlid, u32 sctxt)
+{
+	/* always add ICRC for non 9B packets */
+	if (l2 != PBC_L2_9B)
+		flags |= PBC_INSERT_BYPASS_ICRC; /* AKA PbcInsertNon9bIcrc */
+
+	return (u64)sctxt << PBC_SEND_CTXT_SHIFT |
+	       (u64)dlid << PBC_DLID_SHIFT |
+	       /* lower 32 bits */
+	       flags |
+	       PBC_IHCRC_NONE << PBC_INSERT_HCRC_SHIFT |
+	       l2 << PBC_L2_TYPE_SHIFT |
+	       ppd->hw_pidx << PBC_PORT_IDX_SHIFT |
+	       (vl & PBC_VL_MASK) << PBC_VL_SHIFT |
+	       (dw_len & PBC_LENGTH_DWS_MASK) << PBC_LENGTH_DWS_SHIFT;
+}
+
+/*
+ * Construct a OPA MAD for sending to CPORT.
+ */
+static struct opa_smp *build_cport_mad(int meth, int attr)
+{
+	struct opa_smp *mad;
+
+	mad = kzalloc(sizeof(*mad), GFP_KERNEL);
+	if (!mad)
+		return mad;
+	mad->base_version = OPA_MGMT_BASE_VERSION;
+	mad->mgmt_class = IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE;
+	mad->class_version = OPA_SM_CLASS_VERSION;
+	mad->method = meth;
+	mad->attr_id = attr;
+	return mad;
+}
+
+/*
+ * Send a GET PORT_INFO OPA MAD to CPORT to get details on port.
+ * Caller must kfree() the buffer returned (if not IS_ERR()).
+ */
+static struct opa_smp *cport_get_portinfo(struct hfi2_devdata *dd, int port)
+{
+	u8 sb = port; /* 1.. */
+	struct opa_smp *mad;
+	struct opa_smp *rsp;
+	size_t rsp_len;
+	int ret;
+
+	mad = build_cport_mad(IB_MGMT_METHOD_GET, IB_SMP_ATTR_PORT_INFO);
+	if (!mad)
+		return ERR_PTR(-ENOMEM);
+	/*
+	 * Set port in attribute modifier field, for PORT_INFO.
+	 */
+	mad->attr_mod = cpu_to_be32(0x1000000 | port);
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: send: %02x %02x %02x %02x - %04x %04x %08x\n",
+		dd->unit, __func__,
+		mad->base_version, mad->mgmt_class, mad->class_version, mad->method,
+		be16_to_cpu(mad->status), be16_to_cpu(mad->attr_id),
+		be32_to_cpu(mad->attr_mod));
+#endif
+	rsp_len = sizeof(*rsp);
+	rsp = kzalloc(rsp_len, GFP_KERNEL);
+	if (!rsp) {
+		kfree(mad);
+		return ERR_PTR(-ENOMEM);
+	}
+	ret = cport_send_recv_mad(dd, sb, mad, sizeof(*mad) - OPA_SMP_DR_DATA_SIZE,
+				  rsp, &rsp_len);
+	kfree(mad);
+	if (ret) {
+		kfree(rsp);
+		if (ret > 0)
+			ret = -EINVAL;
+		return ERR_PTR(ret);
+	}
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: resp: %02x %02x %02x %02x - %04x %04x %08x\n",
+		dd->unit, __func__,
+		rsp->base_version, rsp->mgmt_class, rsp->class_version, rsp->method,
+		be16_to_cpu(rsp->status), be16_to_cpu(rsp->attr_id), be32_to_cpu(rsp->attr_mod));
+#endif
+	return rsp;
+}
+
+#ifdef DEBUG_CPORT_TRAP
+static const char *ps_state_name(struct opa_port_states *ps)
+{
+	static const char * const state_name[] = {
+		[IB_PORT_NOP]		= "NOP",
+		[IB_PORT_DOWN]		= "DOWN",
+		[IB_PORT_INIT]		= "INIT",
+		[IB_PORT_ARMED]		= "ARMED",
+		[IB_PORT_ACTIVE]	= "ACTIVE",
+		[IB_PORT_ACTIVE_DEFER]	= "ACTIVE_DEFER"
+	};
+	u8 ls = port_states_to_logical_state(ps);
+
+	if (ls > IB_PORT_ACTIVE_DEFER)
+		return "???";
+	return state_name[ls];
+}
+#endif
+
+static void check_cport_state(struct work_struct *work)
+{
+	struct hfi2_cport *cport = container_of(work, struct hfi2_cport, psc.work);
+	struct hfi2_devdata *dd = cport->dd;
+	struct opa_smp *mad;
+	struct opa_port_info *pi;
+	int ret;
+	int pidx;
+
+	/*
+	 * There should be only one running. Others could abort except for
+	 * the race between checking states and releasing semaphore.
+	 */
+	ret = down_killable(&dd->cport->psc.wait);
+	if (ret) {
+		atomic_dec(&dd->cport->psc.nq);
+		return;
+	}
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: starting port_info loop\n", dd->unit, __func__);
+#endif
+
+	for (pidx = 0; pidx < dd->params->num_ports; ++pidx) {
+		if (!port_available_pidx(dd, pidx)) {
+			ppd_dev_info(&dd->pport[pidx], "Skipping port state check - port not available\n");
+			continue;
+		}
+		mad = cport_get_portinfo(dd, pidx + 1);
+		if (IS_ERR(mad)) {
+			ret = PTR_ERR(mad);
+		} else {
+			pi = (struct opa_port_info *)opa_get_smp_data(mad);
+#ifdef DEBUG_CPORT_TRAP
+			pr_warn("hfi2_%d: %s: PORTINFO %d: %s %08x (%x)\n",
+				dd->unit, __func__,
+				pidx + 1, ps_state_name(&pi->port_states),
+				be32_to_cpu(mad->attr_mod),
+				be16_to_cpu(mad->status));
+#endif
+			ret = update_from_opa_portinfo(&dd->pport[pidx], mad, pi);
+			kfree(mad);
+		}
+		if (ret)
+			dd_dev_warn(dd, "Failed to update PORT_INFO on port %d (%d)\n",
+				    pidx + 1, ret);
+	}
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: finished port_info loop\n", dd->unit, __func__);
+#endif
+	atomic_dec(&dd->cport->psc.nq);
+	up(&dd->cport->psc.wait);
+}
+
+static void handle_cport_trap128(struct hfi2_devdata *dd, struct cport_trap_status traps)
+{
+	/* note: traps are already repressed */
+#ifdef DEBUG_CPORT_TRAP
+	pr_warn("hfi2_%d: %s: TRAP128 psc=%d\n", dd->unit, __func__, traps.psc);
+#endif
+
+	if (atomic_read(&dd->cport->psc.nq) > 1) {
+#ifdef DEBUG_CPORT_TRAP
+		pr_warn("hfi2_%d: %s: TRAP128(s) pending: %d\n",
+			dd->unit, __func__, atomic_read(&dd->cport->psc.nq));
+#endif
+		return;
+	}
+	atomic_inc(&dd->cport->psc.nq);
+	queue_work(dd->hfi2_wq, &dd->cport->psc.work);
+}
+
+/*
+ * This initializes everything necessary to receive and process Port
+ * State Change TRAPs from CPORT. It also kicks off the initial gathering
+ * of port states from CPORT.
+ */
+int init_cport_trap128(struct hfi2_devdata *dd)
+{
+	struct cport_trap_status traps = {0};
+	int ret = 0;
+
+	if (!dd->cport)
+		return 0;
+
+	atomic_set(&dd->cport->psc.nq, 0);
+	sema_init(&dd->cport->psc.wait, 1);
+	INIT_WORK(&dd->cport->psc.work, check_cport_state);
+	traps.psc = 1;	/* Trap 128 Port State Change */
+	ret = register_cport_trap(dd, traps, handle_cport_trap128);
+	if (ret)
+		dd_dev_warn(dd, "Failed to register for CPORT TRAP 128: %d\n", ret);
+	/* Fake a TRAP-128 to gather initial port states even if register fails */
+	handle_cport_trap128(dd, traps);
+	return ret;
+}
+
+int deinit_cport_trap128(struct hfi2_devdata *dd)
+{
+	if (!dd->cport)
+		return 0;
+	return deregister_cport_trap(dd, handle_cport_trap128);
+}
+
+static int cport_goto_offline(struct hfi2_pportdata *ppd, struct opa_port_info *pi,
+			      u8 rem_reason)
+{
+	u32 previous_state;
+
+	previous_state = ppd->host_link_state;
+	ppd->host_link_state = HLS_GOING_OFFLINE;
+
+	/* start offline transition */
+	if (ppd->offline_disabled_reason ==
+	    HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE))
+		ppd->offline_disabled_reason = HFI2_ODR_MASK(OPA_LINKDOWN_REASON_TRANSIENT);
+
+	update_statusp(ppd, IB_PORT_DOWN);
+
+	/*
+	 * The state in CPORT is now offline.
+	 *	- change our state
+	 *	- notify others if we were previously in a linkup state
+	 */
+	ppd->host_link_state = HLS_DN_OFFLINE;
+	if (previous_state & HLS_UP) {
+		/* went down while link was up */
+		cport_handle_linkup_change(ppd, pi, 0);
+	}
+
+	/* the active link width (downgrade) is 0 on link down */
+	ppd->link_width_active = 0;
+	ppd->link_width_downgrade_tx_active = 0;
+	ppd->link_width_downgrade_rx_active = 0;
+	ppd->current_egress_rate = 0;
+	return 0;
+}
+
+/* set_link_state() for CPORT-based systems. Only update local data. */
+int cport_set_link_state(struct hfi2_pportdata *ppd, struct opa_port_info *pi, u32 state)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int ret = 0;
+	int orig_new_state, poll_bounce;
+
+	mutex_lock(&ppd->hls_lock);
+
+	orig_new_state = state;
+	if (state == HLS_DN_DOWNDEF)
+		state = HLS_DEFAULT;
+
+	/* interpret poll -> poll as a link bounce */
+	poll_bounce = ppd->host_link_state == HLS_DN_POLL &&
+		      state == HLS_DN_POLL;
+
+	ppd_dev_info(ppd, "%s: current %s, new %s %s%s\n", __func__,
+		    link_state_name(ppd->host_link_state),
+		    link_state_name(orig_new_state),
+		    poll_bounce ? "(bounce) " : "",
+		    link_state_reason_name(ppd, state));
+
+	/*
+	 * If we're going to a (HLS_*) link state that implies the logical
+	 * link state is neither of (IB_PORT_ARMED, IB_PORT_ACTIVE), then
+	 * reset is_sm_config_started to 0.
+	 */
+	if (!(state & (HLS_UP_ARMED | HLS_UP_ACTIVE)))
+		ppd->is_sm_config_started = 0;
+
+	/*
+	 * Do nothing if the states match.  Let a poll to poll link bounce
+	 * go through.
+	 */
+	if (ppd->host_link_state == state && !poll_bounce)
+		goto done;
+
+	switch (state) {
+	case HLS_UP_INIT:
+		log_state_transition(ppd, PLS_LINKUP);
+
+		/* clear old transient LINKINIT_REASON code */
+		if (ppd->linkinit_reason >= OPA_LINKINIT_REASON_CLEAR)
+			ppd->linkinit_reason = OPA_LINKINIT_REASON_LINKUP;
+
+		cport_handle_linkup_change(ppd, pi, 1);
+		pio_kernel_linkup(ppd);
+
+		/*
+		 * After link up, a new link width will have been set.
+		 * Update the xmit counters with regards to the new
+		 * link width.
+		 */
+		update_xmit_counters(ppd, ppd->link_width_active);
+
+		ppd->host_link_state = HLS_UP_INIT;
+		update_statusp(ppd, IB_PORT_INIT);
+		break;
+	case HLS_UP_ARMED:
+		if (ppd->host_link_state != HLS_UP_INIT)
+			dd_dev_err(dd, "%s %d: allowing unexpected state transition from %s to %s\n",
+				   __func__, ppd->port,
+				   link_state_name(ppd->host_link_state),
+				   link_state_name(state));
+
+		ppd->host_link_state = HLS_UP_ARMED;
+		update_statusp(ppd, IB_PORT_ARMED);
+		break;
+	case HLS_UP_ACTIVE:
+		if (ppd->host_link_state != HLS_UP_ARMED)
+			dd_dev_err(dd, "%s %d: allowing unexpected state transition from %s to %s\n",
+				   __func__, ppd->port,
+				   link_state_name(ppd->host_link_state),
+				   link_state_name(state));
+
+		ppd->host_link_state = HLS_UP_ACTIVE;
+		update_statusp(ppd, IB_PORT_ACTIVE);
+		go_port_active(ppd);
+		break;
+	case HLS_DN_POLL:
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			u8 tmp = ppd->link_enabled;
+
+			ret = cport_goto_offline(ppd, pi, ppd->remote_link_down_reason);
+			if (ret) {
+				ppd->link_enabled = tmp;
+				break;
+			}
+			ppd->remote_link_down_reason = 0;
+
+			if (ppd->driver_link_ready)
+				ppd->link_enabled = 1;
+		}
+
+		set_all_slowpath(ppd);
+
+		ppd->port_error_action = 0;
+
+		ppd->host_link_state = HLS_DN_POLL;
+		ppd->offline_disabled_reason =
+			HFI2_ODR_MASK(OPA_LINKDOWN_REASON_NONE);
+		log_state_transition(ppd, PLS_POLLING);
+		break;
+	case HLS_DN_DISABLE:
+		/* link is disabled */
+		ppd->link_enabled = 0;
+
+		/* allow any state to transition to disabled */
+
+		/* must transition to offline first */
+		if (ppd->host_link_state != HLS_DN_OFFLINE) {
+			ret = cport_goto_offline(ppd, pi, ppd->remote_link_down_reason);
+			if (ret)
+				break;
+			ppd->remote_link_down_reason = 0;
+		}
+
+		ppd->host_link_state = HLS_DN_DISABLE;
+		break;
+	case HLS_DN_OFFLINE:
+		/* allow any state to transition to offline */
+		ret = cport_goto_offline(ppd, pi, ppd->remote_link_down_reason);
+		if (!ret)
+			ppd->remote_link_down_reason = 0;
+		break;
+	case HLS_GOING_UP:		/* never seen by driver */
+	case HLS_VERIFY_CAP:		/* never seen by driver */
+	case HLS_GOING_OFFLINE:		/* transient within goto_offline() */
+	case HLS_LINK_COOLDOWN:		/* transient within goto_offline() */
+	default:
+		dd_dev_info(dd, "%s %d: state 0x%x: not supported\n",
+			    __func__, ppd->port, state);
+		ret = -EINVAL;
+		break;
+	}
+
+done:
+	mutex_unlock(&ppd->hls_lock);
+
+	return ret;
+}
+
+int cport_start_link(struct hfi2_pportdata *ppd, struct opa_port_info *pi)
+{
+	/*
+	 * FULL_MGMT_P_KEY is cleared from the pkey table, so that the
+	 * pkey table can be configured properly if the HFI unit is connected
+	 * to switch port with MgmtAllowed=NO
+	 */
+	/* this writes CSRs... clear_full_mgmt_pkey(ppd); so do: */
+	if (ppd->pkeys[2] != 0) {
+		ppd->pkeys[2] = 0;
+		/* avoid hfi2_set_ib_cfg(HFI2_IB_CFG_PKEYS) */
+		hfi2_event_pkey_change(ppd->dd, ppd->port);
+	}
+
+	return cport_set_link_state(ppd, pi, HLS_DN_POLL);
+}
diff --git a/drivers/infiniband/hw/hfi2/chip_jkr.c b/drivers/infiniband/hw/hfi2/chip_jkr.c
new file mode 100644
index 000000000000..36a239019255
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_jkr.c
@@ -0,0 +1,873 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2023 - Cornelis Networks, Inc.
+ */
+
+#include "hfi2.h"
+#include "trace.h"
+#include "chip_jkr.h"
+#include "cport.h"
+
+int jkr_find_used_resources(struct hfi2_devdata *dd)
+{
+	u32 num_send = chip_send_contexts(dd);
+	u32 num_rcv = chip_rcv_contexts(dd);
+	u64 val;
+	bool found_first_unused;
+	int i;
+
+	/*
+	 * Find reserved resources.  Expectations:  All used resources are
+	 * at the front of the resource.  If this is not the case, there
+	 * will be wasted resources.
+	 */
+
+	/*
+	 * Look for send reserved.
+	 */
+	found_first_unused = false;
+	dd->first_send_context = 0;
+	dd->first_pio_block = 0;
+	for (i = 0; i < num_send; i++) {
+		val = read_csr(dd, JKR_SEND_CTXT_SI_IDX + (8 * i));
+		if (val == 0) {		/* 0 means pf0 */
+			/* this context is for the driver */
+			if (!found_first_unused) {
+				found_first_unused = true;
+				dd->first_send_context = i;
+			}
+		} else {
+			u32 base;	/* in blocks */
+			u32 size;	/* in blocks */
+
+			/* this context is non-driver */
+			if (found_first_unused) {
+				/*
+				 * Expect an initial set of non-driver
+				 * contexts, then all driver after that.
+				 */
+				return -EINVAL;
+			}
+			/* read PIO send resources for this context */
+			val = read_tctxt_csr(dd, i, dd->params->send_ctxt_ctrl_reg);
+			base = (val >> SEND_CTXT_CTRL_CTXT_BASE_SHIFT) &
+				MASK_ULL(dd->params->pio_base_bits);
+			size = (val >> SEND_CTXT_CTRL_CTXT_DEPTH_SHIFT) &
+				SEND_CTXT_CTRL_CTXT_DEPTH_MASK;
+			dd_dev_info(dd, "Non driver send ctxt %d: base 0x%x, size 0x%x\n",
+				    i, base, size);
+			/*
+			 * Expect the non-driver contexts to use the blocks in
+			 * increasing groups.  Warn otherise.  This is a simple
+			 * attempt to warn if there may be wasted reserved
+			 * blocks.  I.e. no holes.  Doing this right would
+			 * involve much more complicated range lists that are
+			 * not worth doing.
+			 */
+			if (dd->first_pio_block != base) {
+				dd_dev_warn(dd, "%s: WARNING: unexpected PIO blocks used\n",
+					    __func__);
+			}
+			/* adjust top used */
+			if (dd->first_pio_block < base + size)
+				dd->first_pio_block = base + size;
+		}
+	}
+
+	/*
+	 * Look for receive reserved.
+	 */
+	found_first_unused = false;
+	dd->first_rcv_context = 0;
+	dd->first_rcvarray_entry = 0;
+	for (i = 0; i < num_rcv; i++) {
+		val = read_rctxt_csr(dd, i, JKR_RCV_SI_IDX);
+		if (val == 0) {		/* 0 means pf0 */
+			/* this context is for the driver */
+			if (!found_first_unused) {
+				found_first_unused = true;
+				dd->first_rcv_context = i;
+			}
+		} else {
+			u32 egr_base;
+			u32 egr_count;
+			u32 tid_base;
+			u32 tid_count;
+
+			/* this context is non-driver */
+			if (found_first_unused) {
+				/*
+				 * Expect an initial set of non-driver
+				 * contexts, then all driver after that.
+				 */
+				return -EINVAL;
+			}
+
+			/* read resources for this context */
+			/* RcvEgrCtrl RcvTidCtrl */
+			val = read_rctxt_csr(dd, i, dd->params->rcv_egr_ctrl_reg);
+			egr_base = (val >> JKR_RCV_EGR_CTRL_EGR_BASE_INDEX_SHIFT) &
+					JKR_RCV_EGR_CTRL_EGR_BASE_INDEX_MASK;
+			egr_count = (val >> JKR_RCV_EGR_CTRL_EGR_CNT_SHIFT) &
+					JKR_RCV_EGR_CTRL_EGR_CNT_MASK;
+			val = read_rctxt_csr(dd, i, dd->params->rcv_tid_ctrl_reg);
+			tid_base = (val >> JKR_RCV_TID_CTRL_TID_BASE_INDEX_SHIFT) &
+					JKR_RCV_TID_CTRL_TID_BASE_INDEX_MASK;
+			tid_count = (val >> JKR_RCV_TID_CTRL_TID_PAIR_CNT_SHIFT) &
+					JKR_RCV_TID_CTRL_TID_PAIR_CNT_MASK;
+			dd_dev_info(dd, "Non driver rcv ctxt %d: egr_base 0x%x, egr_count 0x%x, tid_base 0x%x, tid_count 0x%x\n",
+				    i, egr_base, egr_count, tid_base,
+				    tid_count);
+			/* expect no TID resources used */
+			if (tid_count != 0)
+				return -EINVAL;
+
+			/* convert from group to individual counts */
+			egr_base *= RCV_INCREMENT;
+			egr_count *= RCV_INCREMENT;
+
+			/*
+			 * Expect the non-driver contexts to use the entries in
+			 * increasing groups.  Warn otherise.  This is a simple
+			 * attempt to warn if there may be wasted reserved
+			 * blocks.  I.e. no holes.  Doing this right would
+			 * involve much more complicated range lists that are
+			 * not worth doing.
+			 */
+			if (dd->first_rcvarray_entry != egr_base) {
+				dd_dev_warn(dd, "%s: WARNING: unexpected RcvArray entries used\n",
+					    __func__);
+			}
+
+			if (dd->first_rcvarray_entry < egr_base + egr_count)
+				dd->first_rcvarray_entry = egr_base + egr_count;
+		}
+	}
+
+	/*
+	 * Look for RSM rules being used.
+	 */
+	for (i = 0; i < dd->params->rsm_rule_size; i++) {
+		val = read_csr(dd, RCV_RSM_CFG + (8 * i));
+		if (val == 0)
+			break;
+	}
+	if (val == dd->params->rsm_rule_size) {
+		dd_dev_err(dd, "All %d RSM rules used\n",
+			   dd->params->rsm_rule_size);
+		return -EINVAL;
+	}
+	dd->first_rsm_rule = i;
+	/* mark these as used */
+	for (i = 0; i < dd->first_rsm_rule; i++)
+		set_bit(i, dd->rsm_rule_bitmap);
+	dd->rsm_rule_init = true;
+
+	dd_dev_info(dd, "Resource starts: send ctxt %d, pio block %d, rcv ctxt %d, RcvArray %d, rsm rule %d\n",
+		    dd->first_send_context, dd->first_pio_block,
+		    dd->first_rcv_context, dd->first_rcvarray_entry,
+		    dd->first_rsm_rule);
+
+	return 0;
+}
+
+void jkr_read_guid(struct hfi2_devdata *dd)
+{
+	/* This should get refactored into early_per_chip_init() for all */
+}
+
+int jkr_early_per_chip_init(struct hfi2_devdata *dd)
+{
+	tune_pcie_caps(dd);
+	init_early_variables(dd);
+	return 0;
+}
+
+int jkr_mid_per_chip_init(struct hfi2_devdata *dd)
+{
+	struct cport_who_payload *who = NULL;
+	int resp_len = 0;
+	int ret;
+
+	dd->base_guid = 0xabcd;	/* on success, a valid value is set */
+	ret = cport_send_req(dd, CH_OP_WHO, 0, NULL, 0, (void **)&who, &resp_len, HZ);
+	if (ret) {
+		dd_dev_err(dd, "CPORT who failed %d\n", ret);
+	} else if (resp_len == sizeof(*who)) {
+		dd->base_guid = who->node_guid;
+		if (!ib_hfi2_sys_image_guid)
+			ib_hfi2_sys_image_guid = cpu_to_be64(dd->base_guid);
+		dd_dev_info(dd, "CPORT firmware version %d.%d.%d.%d %u\n",
+			who->vers_maj, who->vers_min, who->vers_mnt, who->vers_pat,
+			who->vers_bld);
+	} else
+		dd_dev_err(dd, "CPORT who invalid resp %d\n", resp_len);
+
+	kfree(who);
+	return ret;
+}
+
+static void clear_si_int_enable(struct hfi2_devdata *dd, u32 src)
+{
+	u32 idx = src / 8;
+	u32 bit = src % 8;
+	u64 val;
+
+	val = read_csr(dd, JKR_CCE_SI_INT_ENABLES + (8 * idx));
+	val &= ~(1ull << bit);
+	write_csr(dd, JKR_CCE_SI_INT_ENABLES + (8 * idx), val);
+}
+
+/* non-RXE, non-TXE, csr init */
+void jkr_init_other(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* enable all pf0 SI interrupts */
+	for (i = 0; i < dd->params->num_int_csrs; i++)
+		write_csr(dd, JKR_CCE_SI_INT_ENABLES + (8 * i), ~0ull);
+	/* .. remove a few */
+	for (i = JKR_ASIC_ERR_INT + 1; i <= JKR_IS_GENERAL_ERR_END; i++) {
+		if (i == JKR_MCTXT_CPORT_TO_PCIE_INT) /* keep enabled */
+			continue;
+		clear_si_int_enable(dd, i);
+	}
+}
+
+/* all "misc" interrupt source names */
+static const char * const jkr_misc_names[] = {
+	"CceErrInt",		/* 0 */
+	"CceSpcFreezeInt",	/* 1 */
+	"AsicErrInt",		/* 2 */
+	"cfg_vpd_int",		/* 3 */
+	"MctxtCportToPcieInt",	/* 4 */
+	"MctxtPcieToCportInt",	/* 5 */
+	"CportVdmRxInt",	/* 6 */
+	"CportVdmTxInt",	/* 7 */
+	"FlrInt0",		/* 8 */
+	"FlrInt1",		/* 9 */
+	"FlrInt2",		/* 10 */
+	"FlrInt3",		/* 11 */
+	"FlrInt4",		/* 12 */
+	"FlrInt5",		/* 13 */
+	"FlrInt6",		/* 14 */
+	"FlrInt7",		/* 15 */
+};
+
+/* all "various" interrupt source names */
+static const char * const jkr_various_names[] = {
+	"GpioAssertInt",
+	"PcoreResetInt",
+	"app_ltssm_enable_int",
+	"TCritInt",
+};
+
+/* generic routine for returning names from a table */
+static void gen_name(char *buf, size_t bsize, unsigned int source,
+		     const char * const *names, size_t nsize,
+		     const char *detail)
+{
+	if (source < nsize)
+		strscpy(buf, names[source], bsize);
+	else
+		snprintf(buf, bsize, "%s%u (invalid)", detail, source);
+}
+
+static char *jkr_is_misc_name(char *buf, size_t bsize, unsigned int source)
+{
+	gen_name(buf, bsize, source, jkr_misc_names,
+		 ARRAY_SIZE(jkr_misc_names), "MiscInt");
+	return buf;
+}
+
+static char *jkr_is_various_name(char *buf, size_t bsize, unsigned int source)
+{
+	gen_name(buf, bsize, source, jkr_various_names,
+		 ARRAY_SIZE(jkr_various_names), "VariousInt");
+	return buf;
+}
+
+static char *jkr_is_port_name(char *buf, size_t bsize, unsigned int source)
+{
+	/* ports have 8 interrupts each */
+	snprintf(buf, bsize, "Port%uInt%u", source / 8, source % 8);
+	return buf;
+}
+
+static char *jkr_is_pcb_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "PbcInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_pio_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "PioErrInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_sdma_err_si_name(char *buf, size_t bsize,
+				     unsigned int source)
+{
+	snprintf(buf, bsize, "SdmaErrSiInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_csr_err_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "CsrErrInt%u", source);
+	return buf;
+}
+
+static char *jkr_is_reserved_name(char *buf, size_t bsize, unsigned int source)
+{
+	snprintf(buf, bsize, "Reserved%u", source + JKR_IS_RESERVED_START);
+	return buf;
+}
+
+static void jkr_handle_cce_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+static void jkr_handle_spc_freeze(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+static void jkr_handle_asic_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+static void jkr_handle_csr_err(struct hfi2_devdata *dd, u32 unused, u64 reg)
+{
+	dd_dev_warn(dd, "%s: unhandled 0x%016llx\n", __func__, reg);
+}
+
+/* misc errs that need a clear down are also the first 3 */
+static const struct err_reg_info jkr_misc_errs[] = {
+	EE_N(JKR_CCE_ERR,            jkr_handle_cce_err,    "CceErr"),
+	EE_N(JKR_CCE_SPC_FREEZE_INT, jkr_handle_spc_freeze, "CceSpcFreeze"),
+	EE_N(JKR_ASIC_ERR,           jkr_handle_asic_err,   "AsicErr"),
+};
+
+static const struct err_reg_info jkr_sdma_eng_err =
+	EE_S(JKR_SEND_DMA_ENG_ERR, handle_sdma_eng_err, "SDmaEngErr");
+
+static const struct err_reg_info jkr_send_pio_err =
+	EE_N(JKR_SEND_PIO_ERR, handle_pio_err, "SendPioErr");
+
+static const struct err_reg_info jkr_send_dma_err =
+	EE_N(JKR_SEND_DMA_ERR, handle_sdma_err, "SendDmaErr");
+
+static const struct err_reg_info jkr_csr_err =
+	EE_N(JKR_CSR_ERR, jkr_handle_csr_err, "CsrErr");
+
+static const struct err_reg_info jkr_send_egress_err =
+	EE_E(JKR_SEND_EGRESS_ERR, handle_egress_err, "SendEgressErr");
+
+static const struct err_reg_info jkr_rcv_err =
+	EE_I(JKR_RCV_ERR, handle_rxe_err, "RcvErr");
+
+static void jkr_is_misc_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	/* jkr_misc_errs[] has all interrupts that need a clear down */
+	if (source < ARRAY_SIZE(jkr_misc_errs)) {
+		interrupt_clear_down(dd, 0, &jkr_misc_errs[source]);
+		return;
+	}
+
+	if (source == JKR_MCTXT_CPORT_TO_PCIE_INT - JKR_IS_GENERAL_ERR_START) {
+		is_cport_int(dd, source);
+		return;
+	}
+
+	dd_dev_err(dd, "unhandled misc interrupt %s\n",
+		   jkr_is_misc_name(name, sizeof(name), source));
+}
+
+static void jkr_is_sdma_eng_err_int(struct hfi2_devdata *dd,
+				    unsigned int source)
+{
+	interrupt_clear_down(dd, source, &jkr_sdma_eng_err);
+}
+
+static void jkr_is_various_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	if (source == 3) { /* "TCritInt" */
+		handle_temp_err(dd);
+		return;
+	}
+
+	/* not expecting any other various interrupts */
+	dd_dev_err(dd, "unhandled various interrupt %s\n",
+		   jkr_is_various_name(name, sizeof(name), source));
+}
+
+static void jkr_is_port_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+	u32 pidx = source / 8; /* port interrupts are in groups of 8 */
+	u32 which = source % 8;
+
+	if (which == 4) { /* send egress errors */
+		interrupt_clear_down(dd, pidx, &jkr_send_egress_err);
+		return;
+	}
+	if (which == 5) { /* receive errors */
+		interrupt_clear_down(dd, pidx, &jkr_rcv_err);
+		return;
+	}
+
+	dd_dev_err(dd, "unhandled port interrupt %s\n",
+		   jkr_is_port_name(name, sizeof(name), source));
+}
+
+static void jkr_is_pcb_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	/*
+	 * This is a per-send context interrupt.  It is called if the PbcIntr
+	 * bit is set on a context's PIO PBC and the packet has completely
+	 * cleared the send buffer.
+	 *
+	 * Presently, the PbcIntr bit is never set.
+	 */
+	dd_dev_err(dd, "unhandled pcb interrupt %s\n",
+		   jkr_is_pcb_name(name, sizeof(name), source));
+}
+
+static void jkr_is_pio_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	/* this is a per-SI interrupt */
+	interrupt_clear_down(dd, 0, &jkr_send_pio_err);
+}
+
+static void jkr_is_sdma_err_si_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	/* this is a per-SI interrupt */
+	interrupt_clear_down(dd, 0, &jkr_send_dma_err);
+}
+
+static void jkr_is_csr_err_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	/* this is a per-SI interrupt */
+	interrupt_clear_down(dd, 0, &jkr_csr_err);
+}
+
+static void jkr_is_reserved_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	char name[64];
+
+	dd_dev_err(dd, "unhandled reserved interrupt %s\n",
+		   jkr_is_reserved_name(name, sizeof(name), source));
+}
+
+const struct is_table jkr_is_table[] = {
+/*
+ * start			end
+ *		name func			interrupt func
+ */
+{ JKR_IS_GENERAL_ERR_START,	JKR_IS_GENERAL_ERR_END,
+		jkr_is_misc_name,		jkr_is_misc_int },
+{ JKR_IS_SDMAENG_ERR_START,	JKR_IS_SDMAENG_ERR_END,
+		is_sdma_eng_err_name,		jkr_is_sdma_eng_err_int },
+{ JKR_IS_SENDCTXT_ERR_START,	JKR_IS_SENDCTXT_ERR_END,
+		is_sendctxt_err_name,		is_sendctxt_err_int },
+{ JKR_IS_SDMA_START,		JKR_IS_SDMA_IDLE_END,
+		is_sdma_eng_name,		is_sdma_eng_int },
+{ JKR_IS_VARIOUS_START,		JKR_IS_VARIOUS_END,
+		jkr_is_various_name,		jkr_is_various_int },
+{ JKR_IS_PORT_START,		JKR_IS_PORT_END,
+		jkr_is_port_name,		jkr_is_port_int },
+{ JKR_IS_RCVAVAIL_START,	JKR_IS_RCVAVAIL_END,
+		is_rcv_avail_name,		is_rcv_avail_int },
+{ JKR_IS_RCVURGENT_START,	JKR_IS_RCVURGENT_END,
+		is_rcv_urgent_name,		is_rcv_urgent_int },
+{ JKR_IS_SENDCREDIT_START,	JKR_IS_SENDCREDIT_END,
+		is_send_credit_name,		is_send_credit_int},
+{ JKR_IS_PBC_START,		JKR_IS_PBC_END,
+		jkr_is_pcb_name,		jkr_is_pcb_int},
+{ JKR_IS_PIO_ERR_START,		JKR_IS_PIO_ERR_END,
+		jkr_is_pio_err_name,		jkr_is_pio_err_int},
+{ JKR_IS_SDMA_ERR_SI_START,	JKR_IS_SDMA_ERR_SI_END,
+		jkr_is_sdma_err_si_name,	jkr_is_sdma_err_si_int},
+{ JKR_IS_CSR_ERR_START,		JKR_IS_CSR_ERR_END,
+		jkr_is_csr_err_name,		jkr_is_csr_err_int},
+{ JKR_IS_RESERVED_START,	JKR_IS_RESERVED_END,
+		jkr_is_reserved_name,		jkr_is_reserved_int},
+{ 0, 0, 0, 0 } /* terminator */
+};
+
+/*
+ * General interrupt sources to enable.  This is all sources but SDMA
+ * (SdmaEngErr, Sdma, SdmaProgress, SdmaIdle), and Receive (RcvAvail,
+ * RcvUrgent). MctxtCportToPcieInt is enabled separately.
+ */
+const struct gi_enable_entry jkr_gi_enable_table[] = {
+	{ JKR_IS_GENERAL_ERR_START, JKR_ASIC_ERR_INT },
+	{ JKR_IS_SENDCTXT_ERR_START, JKR_IS_SENDCTXT_ERR_END },
+	{ JKR_IS_VARIOUS_START, JKR_IS_VARIOUS_END },
+	{ JKR_IS_PORT_START, JKR_IS_PORT_END },
+	{ JKR_IS_SENDCREDIT_START, JKR_IS_SENDCREDIT_END },
+	{ JKR_IS_PBC_START, JKR_IS_PBC_END },
+	{ JKR_IS_PIO_ERR_START, JKR_IS_PIO_ERR_END },
+	{ JKR_IS_SDMA_ERR_SI_START, JKR_IS_SDMA_ERR_SI_END },
+	{ JKR_IS_CSR_ERR_START, JKR_IS_CSR_ERR_END },
+	{ 1, 0 } /* terminator */
+};
+
+void jkr_set_port_tid_count(struct hfi2_ctxtdata *rcd)
+{
+	/*
+	 * Value must match value written into RcvTidCtrl.TidPairCnt.  See
+	 * hfi2_rcvctrl() write to rcv_tid_ctrl_reg.
+	 */
+	u64 count = rcd->expected_count >> RCV_SHIFT;
+	struct hfi2_devdata *dd = rcd->ppd->dd;
+	u8 pidx = rcd->ppd->hw_pidx;
+
+	write_iprc_csr(dd, pidx, rcd->ctxt, JKR_RCV_TID_PAIR_COUNT, count);
+}
+
+static inline u32 rcvarray_offset(u32 ctxt, u32 index, u32 type)
+{
+/* RcvArray access shifts */
+#define JKR_RCV_ARRAY_EGR_TID_SELECT_SHIFT 25
+#define JKR_RCV_ARRAY_RCV_CTXT_IDX_SHIFT 17
+#define JKR_RCV_ARRAY_CSR_INDEX_SHIFT 3
+	return (type == PT_EAGER ? 0 : BIT(JKR_RCV_ARRAY_EGR_TID_SELECT_SHIFT))
+	       | (ctxt << JKR_RCV_ARRAY_RCV_CTXT_IDX_SHIFT)
+	       | (index << JKR_RCV_ARRAY_CSR_INDEX_SHIFT);
+}
+
+/*
+ * Update a TID entry of a given receive context.
+ *
+ * @rcd	  Receive context being updated.
+ * @index When type is PT_EAGER or PT_EXPECTED, index is the index into the
+ *	  receive array _relative_ to how the context is set up.
+ * @pa	  Physical DMA address.  If invalidating, this should be zero.
+ * @order Order of map.  If invalidating, this should be zero.
+ * @flush Forced flush.  Otherwise, will flush on eager or on 32-byte boundary.
+ */
+void jkr_put_tid(struct hfi2_ctxtdata *rcd, u32 index,
+		 u32 type, unsigned long pa, u16 order, bool flush)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u64 reg;
+	u32 offset;
+
+	if (!(dd->flags & HFI2_PRESENT))
+		return;
+
+	trace_hfi2_put_tid(dd, index, type, pa, order);
+	offset = rcvarray_offset(rcd->ctxt, index, type);
+
+#define RT_ADDR_SHIFT 12	/* 4KB kernel address boundary */
+	/* eager and expected have the same layout */
+	reg =   RCV_ARRAY_RT_WRITE_ENABLE_SMASK
+	      | ((u64)order << JKR_RCV_ARRAY_EGR_RT_BUF_SIZE_SHIFT)
+	      | (pa >> RT_ADDR_SHIFT);
+	trace_hfi2_write_rcvarray(dd->rcvarray_wc + offset, reg);
+	writeq(reg, dd->rcvarray_wc + offset);
+
+	if (type == PT_EAGER || flush || (index & 3) == 3)
+		flush_wc();
+}
+
+/*
+ * Write an "no-op" RcvArray entry.
+ *
+ * Called by the TID registration code to write to unused/unneeded RcvArray
+ * entries to fill out a write-combining buffer line.  The HFI will ignore this
+ * write to the RcvArray entry.
+ */
+void jkr_rcv_array_wc_fill(struct hfi2_ctxtdata *rcd, u32 index, u32 type)
+{
+	u32 offset = rcvarray_offset(rcd->ctxt, index, type);
+
+	writeq(0, rcd->dd->rcvarray_wc + offset);
+	if ((index & 3) == 3)
+		flush_wc();
+}
+
+/*
+ * Initialize RcvArray memory by enabling eager access to a range on receive
+ * context 239 then writing to that range.  Shift the range to cover the whole
+ * RcvArray.
+ */
+void jkr_init_tids(struct hfi2_devdata *dd)
+{
+	const u64 value = RCV_ARRAY_RT_WRITE_ENABLE_SMASK;
+	const u32 step_size = 2048;	/* size supported on all chips */
+	const u32 ctxt = 239;		/* target context */
+	u64 save;
+	u64 temp;
+	u32 loops = chip_rcv_array_count(dd) / step_size;
+	u32 i, j;
+	u32 offset;
+
+	save = read_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg);
+	for (i = 0; i < loops; i++) {
+		/* set up count and base */
+		temp =   (((u64)(step_size / 8)) <<
+				JKR_RCV_EGR_CTRL_EGR_CNT_SHIFT)
+		       | ((u64)step_size / 8) * i;
+		write_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg, temp);
+		/* write empty entries */
+		for (j = 0; j < step_size; j++) {
+			offset = rcvarray_offset(ctxt, j, PT_EAGER);
+			writeq(value, dd->rcvarray_wc + offset);
+			if ((j & 3) == 3)
+				flush_wc();
+		}
+	}
+	write_rctxt_csr(dd, ctxt, dd->params->rcv_egr_ctrl_reg, save);
+}
+
+/* chip specific rcv context enable, disable */
+void jkr_enable_rcv_context(struct hfi2_pportdata *ppd, u16 ctxt,
+			    u64 *kctxt_ctrl, bool enable)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 bits = JKR_RCV_PKT_CTRL_RCV_PORT_ENABLE_SMASK |
+		   JKR_RCV_PKT_CTRL_CONTEXT_ENABLED_SMASK;
+	u64 reg;
+
+	reg = read_iprc_csr(dd, ppd->hw_pidx, ctxt, JKR_RCV_PKT_CTRL);
+	/* always clear the L2TypeEnable field */
+	reg &= ~JKR_RCV_PKT_CTRL_L2_TYPE_ENABLE_MASK_SMASK;
+	if (enable) {
+		/* allow 16B and 9B L2 */
+		reg |= bits |
+		       (0xcull << JKR_RCV_PKT_CTRL_L2_TYPE_ENABLE_MASK_SHIFT);
+	} else {
+		reg &= ~bits;
+	}
+	write_iprc_csr(dd, ppd->hw_pidx, ctxt, JKR_RCV_PKT_CTRL, reg);
+
+	/* adjustments to KctxtCtrl */
+	if (enable)
+		*kctxt_ctrl |= JKR_RCV_KCTXT_CTRL_RECEIVE_CUT_THROUGH_DISABLE_SMASK;
+}
+
+void jkr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt, u32 size)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg;
+
+	reg = read_iprc_csr(dd, ppd->hw_pidx, ctxt, JKR_RCV_PKT_CTRL);
+	reg &= ~JKR_RCV_PKT_CTRL_HDR_SIZE_SMASK;
+	reg |= (u64)size << JKR_RCV_PKT_CTRL_HDR_SIZE_SHIFT;
+	write_iprc_csr(dd, ppd->hw_pidx, ctxt, JKR_RCV_PKT_CTRL, reg);
+}
+
+void jkr_set_rheq_addr(struct hfi2_devdata *dd, u16 ctxt, u64 dma_addr)
+{
+	write_kctxt_csr(dd, ctxt, JKR_RCV_ERR_ADDR, dma_addr);
+}
+
+bool jkr_check_synth_status(struct hfi2_devdata *dd)
+{
+	return false;
+}
+
+void jkr_update_synth_status(struct hfi2_devdata *dd)
+{
+}
+
+#define FLAG_ENTRY1(flag, str) { flag, str, 0 }
+const struct flag_table jkr_egress_err_info_flags[] = {
+	FLAG_ENTRY1(BIT_ULL(62), "PbcTestErr"),
+	FLAG_ENTRY1(BIT_ULL(61), "RawIPv6Err"),
+	FLAG_ENTRY1(BIT_ULL(60), "RawErr"),
+	FLAG_ENTRY1(BIT_ULL(59), "AgeCspecErr9B"),
+	FLAG_ENTRY1(BIT_ULL(58), "AgeCspecErr16B"),
+	FLAG_ENTRY1(BIT_ULL(57), "GRHErr9B"),
+	FLAG_ENTRY1(BIT_ULL(56), "GRHErr16B"),
+	FLAG_ENTRY1(BIT_ULL(55), "SdmaMemSpaceErr9B"),
+	FLAG_ENTRY1(BIT_ULL(54), "SdmaMemSpaceErr16B"),
+	FLAG_ENTRY1(BIT_ULL(53), "SdmaMemSpaceErr10B"),
+	FLAG_ENTRY1(BIT_ULL(52), "SdmaMemSpaceErr8B"),
+	FLAG_ENTRY1(BIT_ULL(51), "DisallowedPortErr9B"),
+	FLAG_ENTRY1(BIT_ULL(50), "DisallowedPortErr16B"),
+	FLAG_ENTRY1(BIT_ULL(49), "DisallowedPortErr10B"),
+	FLAG_ENTRY1(BIT_ULL(48), "DisallowedPortErr8B"),
+	FLAG_ENTRY1(BIT_ULL(47), "BadPktLenErr9B"),
+	FLAG_ENTRY1(BIT_ULL(46), "BadPktLenErr16B"),
+	FLAG_ENTRY1(BIT_ULL(45), "BadPktLenErr10B"),
+	FLAG_ENTRY1(BIT_ULL(44), "BadPktLenErr8B"),
+	FLAG_ENTRY1(BIT_ULL(43), "NonKDETHPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(42), "NonKDETHPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(41), "NonKDETHPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(40), "NonKDETHPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(39), "KDETHPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(38), "KDETHPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(37), "KDETHPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(36), "KDETHPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(35), "TooLongPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(34), "TooLongPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(33), "TooLongPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(32), "TooLongPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(31), "TooSmallPacketErr9B"),
+	FLAG_ENTRY1(BIT_ULL(30), "TooSmallPacketErr16B"),
+	FLAG_ENTRY1(BIT_ULL(29), "TooSmallPacketErr10B"),
+	FLAG_ENTRY1(BIT_ULL(28), "TooSmallPacketErr8B"),
+	FLAG_ENTRY1(BIT_ULL(27), "VLMappingErr9B"),
+	FLAG_ENTRY1(BIT_ULL(26), "VLMappingErr16B"),
+	FLAG_ENTRY1(BIT_ULL(25), "VLMappingErr10B"),
+	FLAG_ENTRY1(BIT_ULL(24), "VLMappingErr8B"),
+	FLAG_ENTRY1(BIT_ULL(23), "OpcodeErr9B"),
+	FLAG_ENTRY1(BIT_ULL(22), "OpcodeErr16B"),
+	FLAG_ENTRY1(BIT_ULL(21), "OpcodeErr10B"),
+	FLAG_ENTRY1(BIT_ULL(20), "OpcodeErr8B"),
+	FLAG_ENTRY1(BIT_ULL(19), "SLIDErr9B"),
+	FLAG_ENTRY1(BIT_ULL(18), "SLIDErr16B"),
+	FLAG_ENTRY1(BIT_ULL(17), "SLIDErr10B"),
+	FLAG_ENTRY1(BIT_ULL(16), "SLIDErr8B"),
+	FLAG_ENTRY1(BIT_ULL(15), "PartitionKeyErr9B"),
+	FLAG_ENTRY1(BIT_ULL(14), "PartitionKeyErr16B"),
+	FLAG_ENTRY1(BIT_ULL(13), "PartitionKeyErr10B"),
+	FLAG_ENTRY1(BIT_ULL(12), "PartitionKeyErr8B"),
+	FLAG_ENTRY1(BIT_ULL(11), "JobKeyErr9B"),
+	FLAG_ENTRY1(BIT_ULL(10), "JobKeyErr16B"),
+	FLAG_ENTRY1(BIT_ULL(9), "JobKeyErr10B"),
+	FLAG_ENTRY1(BIT_ULL(8), "JobKeyErr8B"),
+	FLAG_ENTRY1(BIT_ULL(7), "VLErr9B"),
+	FLAG_ENTRY1(BIT_ULL(6), "VLErr16B"),
+	FLAG_ENTRY1(BIT_ULL(5), "VLErr10B"),
+	FLAG_ENTRY1(BIT_ULL(4), "VLErr8B"),
+	FLAG_ENTRY1(BIT_ULL(3), "L2TypeErr9B"),
+	FLAG_ENTRY1(BIT_ULL(2), "L2TypeErr16B"),
+	FLAG_ENTRY1(BIT_ULL(1), "L2TypeErr10B"),
+	FLAG_ENTRY1(BIT_ULL(0), "L2TypeErr8B"),
+};
+
+const struct flag_data jkr_egress_err_info_data = {
+	.table = jkr_egress_err_info_flags,
+	.size = ARRAY_SIZE(jkr_egress_err_info_flags),
+};
+
+/* send context base integrity checks */
+#define SC_BASE_CHECKS (0 \
+	/* 9B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BTOO_LONG_PACKET_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BTOO_SMALL_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BBAD_PKT_LEN_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BRAW_IPV6_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BRAW_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BPBC_TEST_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BVL_MAPPING_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BOPCODE_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BSLID_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BJOB_KEY_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BVL_SMASK \
+	/* 16B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BTOO_LONG_PACKET_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BTOO_SMALL_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BBAD_PKT_LEN_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BRAW_IPV6_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BRAW_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BPBC_TEST_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BVL_MAPPING_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BSLID_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BJOB_KEY_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BVL_SMASK \
+	)
+
+/* send context user integrity checks */
+#define SC_USER_CHECKS (0 \
+	/* 9B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BNON_KDETH_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BGRH_SMASK \
+	/* 16B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BNON_KDETH_PACKETS_SMASK \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BGRH_SMASK \
+	)
+
+/* send context kernel integrity checks */
+#define SC_KERNEL_CHECKS (0 \
+	/* 9B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BKDETH_PACKETS_SMASK \
+	/* 16B */ \
+	| JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BKDETH_PACKETS_SMASK \
+	)
+
+void jkr_set_pio_integrity(struct send_context *sc, enum spi_cmds cmd)
+{
+	struct hfi2_devdata *dd = sc->dd;
+	u32 hw_context = sc->hw_context;
+	u32 pidx = sc->ppd->hw_pidx;
+	int type = sc->type;
+	u64 val;
+
+	/* DEFAULT does not do a read-modify-write */
+	if (cmd == SPI_DEFAULT) {
+		/* allow 9B and 16B packets, no checking */
+		val =   JKR_SEND_CTXT_CHECK_ENABLE_L2_TYPE9BALLOWED_SMASK
+		      | JKR_SEND_CTXT_CHECK_ENABLE_L2_TYPE16BALLOWED_SMASK;
+	} else {
+		val = read_epsc_csr(dd, pidx, hw_context,
+				    dd->params->send_ctxt_check_enable_reg);
+	}
+
+	switch (cmd) {
+	case SPI_DEFAULT:
+		/* No integrity checks if HFI2_CAP_NO_INTEGRITY is set */
+		if (HFI2_CAP_IS_KSET(NO_INTEGRITY) ||
+		    (dd->hfi2_snoop.mode_flag & HFI2_PORT_SNOOP_MODE))
+			break;
+		val |= SC_BASE_CHECKS;
+		if (type == SC_USER)
+			val |= SC_USER_CHECKS;
+		else if (type != SC_KERNEL)
+			val |= SC_KERNEL_CHECKS;
+		break;
+	case SPI_INIT:
+		/* no checks to set/clear */
+		break;
+	case SPI_SET_JKEY:
+		val |= JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BJOB_KEY_SMASK |
+		       JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BJOB_KEY_SMASK;
+		break;
+	case SPI_CLEAR_JKEY:
+		val &= ~(JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BJOB_KEY_SMASK |
+		         JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BJOB_KEY_SMASK);
+		break;
+	case SPI_SET_PKEY:
+		val |= JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BPARTITION_KEY_SMASK |
+		       JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BPARTITION_KEY_SMASK;
+
+		val &= ~(JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BKDETH_PACKETS_SMASK |
+			 JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BKDETH_PACKETS_SMASK);
+		break;
+	case SPI_CLEAR_PKEY:
+		val &= ~(JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BPARTITION_KEY_SMASK |
+			 JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BPARTITION_KEY_SMASK);
+		break;
+	}
+	write_epsc_csr(dd, pidx, hw_context,
+		       dd->params->send_ctxt_check_enable_reg, val);
+
+}
+
+void jkr_read_link_quality(struct hfi2_pportdata *ppd, u8 *link_quality)
+{
+	*link_quality = 5; /* best */
+}
+
+void jkr_handle_link_bounce(struct work_struct *work)
+{
+	struct hfi2_pportdata *ppd = container_of(work, struct hfi2_pportdata,
+							link_bounce_work);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	dd_dev_warn(dd, "%s: TODO for JKR\n", __func__);
+}



