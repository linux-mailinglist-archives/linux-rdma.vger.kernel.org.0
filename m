Return-Path: <linux-rdma+bounces-11776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F49AEE638
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676373A7244
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDFB2E7187;
	Mon, 30 Jun 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="dgoFGUyu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2126.outbound.protection.outlook.com [40.107.223.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264FE2E7186
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306301; cv=fail; b=Wopffv+0zWK12dOtlzPahWjyspJa8I7QO5KAX784uIrnAqYwVxxLpTKgd5Q5evWyFRP2181xg+Q7evzCOhYebOMyF6XsOh3vsQtMzkgRRLC+q/5MPX4vyaXtMCM9cihDsBFwbIa6VU8JqpmvjT5Cj8ZiPpsDPas00jisAlb0ZNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306301; c=relaxed/simple;
	bh=9hbYvyB3pndKWczU/n4W+KUUveRazGp4af6a8ba8E8U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IbQ4eMRgRKqjd8UlhaYs597binUA794uXvzUG/kya7Cuh5yO5yHiYMFS2F3m+0EtWUEJM/6EdbtPA5HTF43Lxe4z7q2m4rXFhVIEll95IWsOrVKOiYNJnjiRQBT621jqtnebcCT6dwVQEjWBqcxGNnSWVaWRZ0F64ng2Q8qe5/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=dgoFGUyu; arc=fail smtp.client-ip=40.107.223.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCpFuqa/LgIhZQK4ale+WMLwUszd1dVPc2cRY/9eSolSiCzmDS9KpgZCujwpuYgC0kbniNj808QMi4sIRIytKXC4kcCGmLzB63xdGw3ptrVHMJVU+IFmOoLaXD2CLuLReV+5fVEE1ZlMkJ9AkdiIOEStzplLWCu75ZtyqcyOLEKPFUJfgOi4hkeYue4JLz9DntCEkgwClZZAYKZ+vuyzmZU96bb14rY8MjhWTWZSblqIaTkxI0VBm1/FW7a0XfCd+4gncDjc3qoJGeT4QobTYbVVLwcO+4m10LxdBFIGJiEdD7B01in8behsUkUNMTg5wXBvXtpFIdyROwfKCcyJ+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHMo/OVJU/xv/jsEq/Pcn6hNkc4gyMfrkOj9PmsXDvA=;
 b=kspNDyO7866agyq8PP+xs9p6zdRI6yDGKBLHy0sbWVT5ykfdVKdj44wz/zSDkY8QUEkdKV86Zr9aV0Lo2stImNS3U3W6Dos/ULhzzWgVX3nPcngaV86zzG0Vdh59b6nRIzh2tGmzWH93IqSz9O3nxP3C6ZYXS9b+uRt05yK5ohNJwkuz3hkL6WzYtzPB60SD0rjI5v5WUUhNh7mX85UhlDsn8GMInd1RzTPBQhsgDaZ/kcanIJ+awF7/wRgu+jvOPzPiCJRKlimVZXygsQGpsyRqcjvUZwIBHoacytr0x46/Q4WeEp4cBVjt0y91AdW0EzrsbEdmHErtVJqacyPZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHMo/OVJU/xv/jsEq/Pcn6hNkc4gyMfrkOj9PmsXDvA=;
 b=dgoFGUyu17uRlHPFFsJWsJuah9y3KdB63flEyTzhHQJwQzYyMdQoyuTdxxl7QzFJCflM5xYdrmQVb689J9yhOY9WSzTAMVmISwFa3B8xBrpUDHPQPlUNbI+gXtZkejq1gi0YFaIitewjM5rNRmyCKo1BPutM6bwPD9AojjQjx1ejMbwOcvWPVSQ02yAH395XFdkUtUSNcsbFwQjma9SE0xlNsDw2R1qbEUTr0vWHHkUssUthGZ/cYOX4lvpT86O6XfVOgqhb4qMZYzQx9Uz8aTVDTw/CwIMCLV/Sa2SLUWxIZmTQ1VFxLzucTHFlsY1hXIqeipiOKUg0/gP2ICQcOw==
Received: from SA0PR11CA0186.namprd11.prod.outlook.com (2603:10b6:806:1bc::11)
 by LV3PR01MB8462.prod.exchangelabs.com (2603:10b6:408:1a7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Mon, 30 Jun 2025 17:58:10 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::e4) by SA0PR11CA0186.outlook.office365.com
 (2603:10b6:806:1bc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 17:58:10 +0000
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
 via Frontend Transport; Mon, 30 Jun 2025 17:58:09 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id D29F114D728;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 272101848B5E4;
	Mon, 30 Jun 2025 11:31:44 -0400 (EDT)
Subject: [PATCH for-next 23/23] RDMA/hfi2: Make it build
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:31:44 -0400
Message-ID:
 <175129750410.1859400.2810253865329800382.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|LV3PR01MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d74bf97-d923-4fcc-e612-08ddb7ffacd1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTI2aWJTZ2lBc2VuVWE4cVNSbURUYXNHZkM0QXBGcHFWbzRLeUppSFladTkx?=
 =?utf-8?B?dEFNRU9JWWZXcHFTeDJGYStFeVozOHJxSndGdjdYOTdCZEo5RnhrTnBlUUhm?=
 =?utf-8?B?MUd5bWFSREc5U3cxV3hNQ0VONFFIdnlVc2t6ZnJqMno3VURyWTNqR2VsWWgr?=
 =?utf-8?B?WXc5c0k5SjgwRHJnN3FSVFZiZnJVRU5ucjlzbEFiWkVKVmplN2x3R0xzTVd0?=
 =?utf-8?B?dVNMUmpQRk9SNXVTSlJpMTBubHFyTDYyVjFJWjV6Sjc2UjBFZ2xINjl1S2Yr?=
 =?utf-8?B?Zm9wMmtESExXQjNkNDlDbHJVYkxTTlU0d29MQ28vS0Z3OTh6ZDdUelhCcnlD?=
 =?utf-8?B?d092bEw3TkhJcU00eVY5dXlHZzV3N1FGN0ZaWUdZckNsUVk1MUdhdjFqQWNp?=
 =?utf-8?B?TXlTYlA0ejQzRkhWaHFsbFhpT3h3cUtrMHo2a05MQ0tnajVhYVFrUDUwZGRT?=
 =?utf-8?B?Uy9oK2xIcTZOUjVoVkthWUt6L0JReVFxRjY4dVMxYmJOU1BOK2pyTldHb3R0?=
 =?utf-8?B?dU9FL0tzYmVnaitlWEpiOVpaSGVFMWVYcUJtQ1cxY0I5TDkza05VZktuVUpl?=
 =?utf-8?B?MWZZM2E3OFJtVnVEYkRZTzJGb0hSV3B4VnZ2cVJQMTdPL0ZCVUZJaDBIelNL?=
 =?utf-8?B?SXRQVWU4bVhWTnlKdzdRTnBIbEExd0hoQ2M5YktRVzloVnlrRkZvTy90QzV6?=
 =?utf-8?B?ejFmazVUVzkvQ3pyNHBNRVFubUlOR0VLWmtHVUpaekFEcU1xZnJ4R09hbzMy?=
 =?utf-8?B?M0MwSU1ZV1FiclU5SEhaRFVOM2tBeDJRNHZrcUVTbHdUN0QyNHhOMEVOMHNs?=
 =?utf-8?B?cWNRdnhUbExDSmV6R1E4T1VLencvY25DMk9oQWtJVDIyUnhJZHRIVUNJRWJp?=
 =?utf-8?B?QjFZNGViQTdGV2dCVXlFdDYxaHgyYmJaTFdVeWlNM0tObnVNVjVMeWVlZjZ0?=
 =?utf-8?B?RG5aT0R6SnBKQ0xHczcwbWVPOFJZY0I3WTU2WXFZeDFRYXIrcWplNW5IaXRS?=
 =?utf-8?B?akdSajBBbGgzbUZDTHFaMWFqc1VsaktTS3RwRWhSc1MrbXl0NHZtbklpWHhX?=
 =?utf-8?B?YzRPNVNtSU9xNWZkb2dKRVJYbStNTWZjMi9qZTlMdVZpd1dRd0xyQk13dDlZ?=
 =?utf-8?B?UVVtQlViaHEzRzFMbVlCZmZadkU5bmhsS3dsdmthSGlEOGtmMTFlMlorbkFL?=
 =?utf-8?B?T2VGbmJNUFIrbGRPVmkzektSSVhNdWdFaE9IQ2ZmRHZzOGhFVkVMbEFpamwr?=
 =?utf-8?B?TmdhVzFEbExaNVF0WkU4T1RvWXhDWEpWeHMxUE5FamdEVVhUSUdqdElpSmta?=
 =?utf-8?B?YXVJeW5wNy9NZ2RCWm9xZTJuczR6TUhpa1NueDdTaEZCVGpSZUZKV1JUZ3ZJ?=
 =?utf-8?B?UHhuQlpneXpuSmNBV1FGWTFncVY0NEk2QWZwbVhuTjFUc1NDNVh3Wjl6TDd3?=
 =?utf-8?B?bENlbzl2dVZmTUY0Kzd6NkhWM3B6MDZiMGdZMFBNaVdxLy9vcEg3TUp3b0VF?=
 =?utf-8?B?VW1qTXJpTlVMb0N5RnoxbnpwMmlNdmo3SlU3RHFQOVg1NUlCVDBnSVBnVW4x?=
 =?utf-8?B?NzhGL1oyWkg2WkxtUW9qdDlDcGVTeXNGWS96VWlXWWw5MG1icjNHZjlINmlp?=
 =?utf-8?B?ZlZUQ0k2WnppTk5BUmI2WG0wNGJRQTM5cUxqVDZBVXI4ZFBBaTRVSjE4L3hZ?=
 =?utf-8?B?OXpRRG94Y09jTlVqRk94UDk0V096SmdiRi9xbHlhWER2TFBrNzNOb3A0V245?=
 =?utf-8?B?K291N0VUMnNRRURTeUd1ekxuelFVbk5ZYVJhdzlZbXlwMnhxMTA1NG9mVjlR?=
 =?utf-8?B?aDlUdm9BZjg2K21qSmltemZVWitlcnBQY015UmFKRWVGbzJ1Q1hYcUw5c25Z?=
 =?utf-8?B?SXlFV1RWTDdhY0dhK3F0cHBicW95bTYwS2NFV1lkbi8xczF4clVaMEFSQzAv?=
 =?utf-8?B?ZVl4aHdYdndKdG9xVkdiT1JLeTZqSlViY2UvWVh2STVld3MyekZZZmFFYzg3?=
 =?utf-8?B?MkFsN0I2Y3psMWhoMVdhZi81S1YzaGxrUEhJMVpIYnQ0RmRZVnNWL0EyOGV0?=
 =?utf-8?Q?Hcoi4V?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:09.9156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d74bf97-d923-4fcc-e612-08ddb7ffacd1
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8462

Add in the Makefile now that all the pieces are in place.

Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 MAINTAINERS                         |    8 ++++
 drivers/infiniband/Kconfig          |    1 +
 drivers/infiniband/hw/hfi2/Kconfig  |   23 ++++++++++++
 drivers/infiniband/hw/hfi2/Makefile |   69 +++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100644 drivers/infiniband/hw/hfi2/Kconfig
 create mode 100644 drivers/infiniband/hw/hfi2/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index c95f54b45fc3..3d0934edcc76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10469,9 +10469,15 @@ F:	include/uapi/linux/cciss*.h
 HFI1 DRIVER
 M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
 L:	linux-rdma@vger.kernel.org
-S:	Supported
+S:	Obsolete
 F:	drivers/infiniband/hw/hfi1
 
+HFI2 DRIVER
+M:	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
+L:	linux-rdma@vger.kernel.org
+S:	Supported
+F:	drivers/infiniband/hw/hfi2
+
 HFS FILESYSTEM
 M:	Viacheslav Dubeyko <slava@dubeyko.com>
 M:	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index abf8fd114a2c..ad80d3da82f1 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -84,6 +84,7 @@ source "drivers/infiniband/hw/cxgb4/Kconfig"
 source "drivers/infiniband/hw/efa/Kconfig"
 source "drivers/infiniband/hw/erdma/Kconfig"
 source "drivers/infiniband/hw/hfi1/Kconfig"
+source "drivers/infiniband/hw/hfi2/Kconfig"
 source "drivers/infiniband/hw/hns/Kconfig"
 source "drivers/infiniband/hw/irdma/Kconfig"
 source "drivers/infiniband/hw/mana/Kconfig"
diff --git a/drivers/infiniband/hw/hfi2/Kconfig b/drivers/infiniband/hw/hfi2/Kconfig
new file mode 100644
index 000000000000..5c0e5c507e5c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config INFINIBAND_HFI2
+	tristate "Cornelis CN5000 and legacy support"
+	depends on X86_64 && INFINIBAND_RDMAVT && I2C && !UML
+	select MMU_NOTIFIER
+	select CRC32
+	select I2C_ALGOBIT
+	help
+	This is a low-level driver for Cornelis OPX Gen1 adapter.
+config HFI2_DEBUG_SDMA_ORDER
+	bool "HFI2 SDMA Order debug"
+	depends on INFINIBAND_HFI2
+	default n
+	help
+	This is a debug flag to test for out of order
+	sdma completions for unit testing
+config HFI2_SDMA_VERBOSITY
+	bool "Config SDMA Verbosity"
+	depends on INFINIBAND_HFI2
+	default n
+	help
+	This is a configuration flag to enable verbose
+	SDMA debug
diff --git a/drivers/infiniband/hw/hfi2/Makefile b/drivers/infiniband/hw/hfi2/Makefile
new file mode 100644
index 000000000000..f7503d16f8e5
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/Makefile
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# HFI2 driver
+#
+#
+#
+# Called from the kernel module build system.
+#
+obj-$(CONFIG_INFINIBAND_HFI2) += hfi2.o
+
+ccflags-$(CONFIG_SDMA_VERBOSITY) += -DCONFIG_SDMA_VERBOSITY
+
+hfi2-y := \
+	affinity.o \
+	aspm.o \
+	chip.o \
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
+	verbs_txreq.o 
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



