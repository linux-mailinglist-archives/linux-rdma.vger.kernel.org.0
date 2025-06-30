Return-Path: <linux-rdma+bounces-11778-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039BAEE63E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469F4189C6E4
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5DB2E7622;
	Mon, 30 Jun 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="KFs8DQGC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2091.outbound.protection.outlook.com [40.107.100.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C482E5408
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306302; cv=fail; b=KyHRm1cQ5XNEW9SsCULE3ZDUcjB2PBGUv+hKyvSZCLatcLXh2gLw85IiwvTFYtU+WFjS4AB/nE8s8opresm4yEA2swoEgOIiSEA53ge+1nT9WnF/fi4RCUzq0NOfiGSLP+uliktn/RvK8+IWMVLMfvUySX+0CTAq8Axb6hP41yY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306302; c=relaxed/simple;
	bh=0B1Rp7zK/aihLCUjQglAQmRMamwA8yixAcnLTQm43zM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3eAlT5cnbBhnjZK+l1xSqwC5KcUO6v9+xSd9ahdvWCp+b1tOg0k/rkeqLX8YlWXFaOIudlD103IKo2ti9v7f2+Td44impGDQbgNgAQr1L/NOI9YpcnE8BMLshIZRYIScgvAgcsgg1fEd4D2vMHGslzY0aehSOZXS+ibEdUKXwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=KFs8DQGC; arc=fail smtp.client-ip=40.107.100.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lExwUrGwcbB1BnnOXcWVUHAZWSqO7JUikS/8110Fd1BT/0G3GrgkHbvEuXQlXjTJafouF7VifPw6wNg6ycofEIuzyIqLPHDm7+Ui/A+2z2dG9T7lTCyHJkXiJafpe3wavjItzW694xYoQrvv/JiRtmq9j0CJTvazHLv8NaEIXCpnb7YjbYdLBaOJZy2tp1w59ZMxiCRJ1fbl366BSZEItaUsu/glSvzDjhfQ05ylDnj07c4daLh2dLV3lBbZmMJPf2n1VH44pGok95B+4g+hIKywfDuLT++YvZFsKAekvhmCuYVng/Tw6d5kBXl0uPjhSuu70KKJ5Qq4x0iKV8ik+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcB+NYxPEgJw9TCEvI+09mVa0peJ/sqH8yjy7/H/CpQ=;
 b=yiClAglGen0vARbcyY4AfDmSuzhyMOSqYxzem1a4q9uwTgTAwBXx6gD8dNlkVk1LdZ2sePZ0jkAi7IcfU1CMrT1Te1U2Y79Z5H2G0a8DAJBMP+RfAJch7vbsJydpbX/zSQvKuLBgp1WMPORSGn3RRHCAhe9iR0b8TPZL7c82uVioIUPpNS0rvvfsAwVX2L/muUqdi/FXKmZJh4oaduZ0/YELxxH2FlV7n3JESo56di2sBFAtXf40EM9CA4cRBeDW4JeEuTzCCPUfbdhK+JWQlnhRBhr7NPvg/N6PUp2QFDsKLv1tbWKj/IAIm9/a5vXOnMOdKSK6dBvZ9pPfTsBNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcB+NYxPEgJw9TCEvI+09mVa0peJ/sqH8yjy7/H/CpQ=;
 b=KFs8DQGCr179m7PLVNZBmuK9zIkYtn9V7M616iQpb+RFuE2kJdLlpz3JP3DRpCLuB17cZOVXm5LiDe3SNb2IA36yovCjwniXLHHBEvH7KCX1Cza+5Dkr9OZOCTDFx8C8MrMfbLcTcdk7quQu+L8ZMYIEo6AC/UMvfJX/8IVICxkD6CotRi9x6Cufk01hRon3aPuz4ML56rW6iYy5Fvlvl/dLP0ThVpRXqDYGWH/1J9wYivG0Der2G5h4Rj42rjqfbOixIkb/VI/GnZv1sk8CBj7CDQAGMu2qrsWG786Q2mg4YGZZ37VXSZXtdByykK//DPF9hoH9teavrTYMZdb85Q==
Received: from SN7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::19)
 by DS2PR01MB9413.prod.exchangelabs.com (2603:10b6:8:2ad::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.30; Mon, 30 Jun 2025 17:58:10 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::c0) by SN7P222CA0006.outlook.office365.com
 (2603:10b6:806:124::19) with Microsoft SMTP Server (version=TLS1_3,
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
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:09 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id D2BF514D729;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 209BC1848B5CD;
	Mon, 30 Jun 2025 11:30:33 -0400 (EDT)
Subject: [PATCH for-next 09/23] RDMA/hfi2: Add in HW register definition files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:33 -0400
Message-ID:
 <175129743309.1859400.11138422041598929573.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DS2PR01MB9413:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c758d4-1ddc-4535-039a-08ddb7ffacd8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2RQak11R0grRVNIM1dvTzBES2JYT0pJSlNyVzRjMXlIVTdNalB3WDJDU3J4?=
 =?utf-8?B?WTllTEsrZVAyUnI4NXBPekcyNXFFZGM3S3JyUy8vNUNaNjljbVJDRDZ5NDRY?=
 =?utf-8?B?ZTBEMGJwV0ZqcTEvOW1nL29xN1hMRExPaVVvK1JRcVNBQnhKT01NeWRLcWtP?=
 =?utf-8?B?WEU4Ky83MzBwMHVJc0JhRGZCR2UrcElPRk5HbGxIM25mZUNZSkdWS2RzbUpv?=
 =?utf-8?B?STVEOURSdUFCZEFGKysvcm1pbHE0WHI5a2N3czlhZ0w5ZE8xcnM3dFZLb1Zy?=
 =?utf-8?B?SldURmV5Q2NsWXYvSmdkN2RyYkdrbFpkYXZVWndnYXpSMmNySTloSmhlR09i?=
 =?utf-8?B?S1lYUkpKbGxZQUlrc1R6dGZST2l2bk9UdjROdjNoeTdvWWhaWUxqNTYyVkp1?=
 =?utf-8?B?dnB5VER2cHdqT3hIUm1RRjBaV1Frd3pNM2lXZVZZTDlhdkNDNXNtaVpzSnJE?=
 =?utf-8?B?U0JhUkJuWjIzcmMweTNLZkMwTy9POGVDSXFUY0hHeEZPMUhzbSs1WWRwekR5?=
 =?utf-8?B?ejBtSDFRN3F5U0tMUGJ6dmM4NWRUdnVxdlpla29Qc1RFRy9XUzJzSUNrdlZ6?=
 =?utf-8?B?bFdrQWM5VlNlRTZJdE5tQUpCaGtIMDdjQ0h6NDNMYW5UU1JIajV1d05xVzVX?=
 =?utf-8?B?M0EyanJ4UkJ5c2FNZ0ZIQ2xwMWVrSFJoZ0xHMUR2Njk5anJqTk51VUhOM1U1?=
 =?utf-8?B?UlArSVVIRlhjck5uem96ZG9IUXQ2M0RydkthTmFGcWpGenhuaTNSdmNoTFk5?=
 =?utf-8?B?Z0hEdmpIcWxONTk5d0ZEbmtIVTU1NGJmVzM3SVZyKzlSSyt5ZU5jUC92ek5G?=
 =?utf-8?B?ZUR3UGRGOE02dVV3Mi9vNVNrb3M4UTcrSDkvWGEyaUpBSlpJZndmdGRXQ2th?=
 =?utf-8?B?Nm5GUFBUL1drN21uTXB1WlZGMVRJVks0a0VNSjV5TU5ZU2drbVV0dzJJMTZF?=
 =?utf-8?B?QmQ0UkE0d3BCWWt5RmhCaGRjNlk4NmNrQ2l0Zml3Nm1OV0YwN2lOS3ZWczl2?=
 =?utf-8?B?NVFBd2E5ck43ckRkWERYTWhSdHNGWkdYRVNLUWFQZUppMTgwZzFScFNOUkc5?=
 =?utf-8?B?MlppYko2NHRTK2c4cXVCRkRZWm1hMnZDaCtuVmUrdzVnTFhkc1NNUHppcTN5?=
 =?utf-8?B?SVZwa3doNis4ZXl4Tmp6MXZuMmZCd0ZvVFJkM21WSFVhYkFiL1JTYlVlNzNh?=
 =?utf-8?B?VGRPc0JUc2FxSVVZUTBUQWtMVWdhM2tabEp3MnEwN2pKTFhMd0UwZi9SRHRD?=
 =?utf-8?B?b0NUUWJjcjhYdTZiQXFPTURmbmxKWjZkYUtWVEZHOHYrajN5WFJRZWlsWEJz?=
 =?utf-8?B?YjZ0T29wQVptOCtFV2NpR1BsdjlOSGhYZjNyc3MvMGpsaFRIc0NrWTJJSDkr?=
 =?utf-8?B?ZC9vVzllcE41R2JnOGlHcityd2NGYXpjOFdvdTg3aDdJa2lqODcyL3dXTUo5?=
 =?utf-8?B?T2VzOEZrMnpxOGRtN1ZkdnRqdjdsQzVjN1Q5OEMvUzZpeDFYekNQandPUDhQ?=
 =?utf-8?B?NzVsR1grb3p3VWg4d0ZMMWMzeWJ4TTBZOUtKOFcyTE1xTk0zdmZtY0JJZUdY?=
 =?utf-8?B?bitsWEIxNGlrWTJqSnd1S0xIV1NMM3hhN3YzSHhWbEh5VFBVdGthUzJPcUpS?=
 =?utf-8?B?Z2k4cWVwRWgvQmo5bzhNYXJaSjZjUEprR2N4Q3ZiUUxUYTJoOHBxSFRUWGtu?=
 =?utf-8?B?ZURRWWFxZTBTeEljYjRoVFN6TVFNNFdPanBTRzJzMEVMMi9EOEFtd3lSTEFs?=
 =?utf-8?B?alVNUktRWDFsTkZZOFFuQkJPak5aUmQra0M1MnBzTTRHaHBtRnJHc3VRamJW?=
 =?utf-8?B?WEdlbVdWekMyMUtDVFNGYmR6RFVEdkZQTytWNGJnL1Vlbld2YXowdWNUaWdS?=
 =?utf-8?B?cnlSMTJTSjRtaUNsTkZyMUtXTWNDcm5pdTZtNnkwT1VLVUhINGlYUjRXNWJv?=
 =?utf-8?B?R0NzZW04elhCSkZZYmF1dkNYUnV4dndDd1NmY01xaGhrUC9qYTM1ZFlnd282?=
 =?utf-8?B?UElrM3ZuL3lEc0RQc1Fuam1lMllqRDNDRU1EMWt4Ym9aU3Y2cXhDVG9SbzVZ?=
 =?utf-8?Q?QuFPlL?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:09.9125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c758d4-1ddc-4535-039a-08ddb7ffacd8
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR01MB9413

These are the HW registers for both generations of chips currently
supported.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/chip.h               | 1420 +++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/chip_gen.h           |   29 
 drivers/infiniband/hw/hfi2/chip_jkr.h           |  119 ++
 drivers/infiniband/hw/hfi2/chip_registers.h     | 1297 +++++++++++++++++++++
 drivers/infiniband/hw/hfi2/chip_registers_jkr.h |  224 ++++
 5 files changed, 3089 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/chip.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_gen.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_jkr.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_registers.h
 create mode 100644 drivers/infiniband/hw/hfi2/chip_registers_jkr.h

diff --git a/drivers/infiniband/hw/hfi2/chip.h b/drivers/infiniband/hw/hfi2/chip.h
new file mode 100644
index 000000000000..212968371707
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip.h
@@ -0,0 +1,1420 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2024 Cornelis Networks, Inc.
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ */
+
+#ifndef _CHIP_H
+#define _CHIP_H
+/*
+ * This file contains all of the defines that is specific to the chip
+ */
+
+/* sizes */
+#define BITS_PER_REGISTER (BITS_PER_BYTE * sizeof(u64))
+#define NUM_INTERRUPT_SOURCES 768
+#define RXE_NUM_CONTEXTS 160
+#define RXE_NUM_TID_FLOWS 32
+#define RXE_NUM_DATA_VL 8
+#define TXE_NUM_SDMA_ENGINES 16
+#define NUM_CONTEXTS_PER_SET 8
+#define VL_ARB_HIGH_PRIO_TABLE_SIZE 16
+#define VL_ARB_LOW_PRIO_TABLE_SIZE 16
+#define VL_ARB_TABLE_SIZE 16
+#define TXE_NUM_32_BIT_COUNTER 7
+#define TXE_NUM_64_BIT_COUNTER 30
+#define TXE_NUM_DATA_VL 8
+#define TXE_PIO_SIZE (32 * 0x100000)	/* 32 MB */
+#define RCV_ARRAY_SIZE (64 * 1024 * 8)  /* 64K entries of 8 bytes = 512 KB */
+#define PIO_BLOCK_SIZE 64			/* bytes */
+#define SDMA_BLOCK_SIZE 64			/* bytes */
+#define RCV_BUF_BLOCK_SIZE 64               /* bytes */
+#define PIO_CMASK 0x7ff	/* counter mask for free and fill counters */
+#define MAX_EAGER_ENTRIES    2048	/* max receive eager entries */
+#define MAX_TID_PAIR_ENTRIES 1024	/* max receive expected pairs */
+/*
+ * Virtual? Allocation Unit, defined as AU = 8*2^vAU, 64 bytes, AU is fixed
+ * at 64 bytes for all generation one devices
+ */
+#define CM_VAU 3
+/* ink credit count, AKA receive buffer depth (RBUF_DEPTH) */
+#define CM_GLOBAL_CREDITS 0x880
+/* Number of PKey entries in the WFR HW */
+#define WFR_MAX_PKEY_VALUES 16
+/* number of SendCtxtCtrl.CtxtBase bits in the WFR HW */
+#define WFR_PIO_BASE_BITS 14
+
+#include "chip_registers.h"
+
+#define TXE_PIO_SEND (TXE + TXE_PIO_SEND_OFFSET)
+
+/* register strides */
+#define WFR_RXE_IPRC_STRIDE 0x100
+#define WFR_RXE_RCTXT_STRIDE 0x100
+#define WFR_RXE_KCTXT_STRIDE 0x100
+#define WFR_RXE_UCTXT_STRIDE 0x1000
+#define WFR_TXE_SCTXT_STRIDE 0x100
+#define WFR_TXE_TCTXT_STRIDE 0x100
+#define WFR_TXE_SDMA_STRIDE 0x100
+#define WFR_TXE_SDMACFG_STRIDE 0x100
+#define WFR_TXE_EPSC_STRIDE 0x100
+
+/* PBC flags */
+#define PBC_INTR		BIT_ULL(31)
+#define PBC_9B_SC4_SHIFT	(30)	/* aka PBC_DC_INFO */
+#define PBC_9B_SC4		BIT_ULL(PBC_9B_SC4_SHIFT)
+#define PBC_TEST_EBP		BIT_ULL(29)
+#define PBC_PACKET_BYPASS	BIT_ULL(28) /* WFR only */
+#define PBC_CREDIT_RETURN	BIT_ULL(25)
+#define PBC_INSERT_BYPASS_ICRC	BIT_ULL(24)
+#define PBC_TEST_BAD_ICRC	BIT_ULL(23)
+#define PBC_FECN		BIT_ULL(22)
+
+/* return PBC flag for bit sc[4] */
+static inline u64 pbc_sc4_flag(u16 sc5)
+{
+	return (u64)ib_is_sc5(sc5) << PBC_9B_SC4_SHIFT;
+}
+
+/* PBC L2 types */
+#define PBC_L2_16B 2	/* 16B header */
+#define PBC_L2_9B  3	/* 9B header */
+
+/* PbcInsertHcrc field settings */
+#define PBC_IHCRC_LKDETH 0x0	/* insert @ local KDETH offset */
+#define PBC_IHCRC_GKDETH 0x1	/* insert @ global KDETH offset */
+#define PBC_IHCRC_NONE   0x2	/* no HCRC inserted */
+
+/* WFR PBC fields */
+#define PBC_STATIC_RATE_CONTROL_COUNT_SHIFT 32
+#define PBC_STATIC_RATE_CONTROL_COUNT_MASK 0xffffull
+#define PBC_STATIC_RATE_CONTROL_COUNT_SMASK \
+	(PBC_STATIC_RATE_CONTROL_COUNT_MASK << \
+	PBC_STATIC_RATE_CONTROL_COUNT_SHIFT)
+
+/* JKR and beyond PBC fields */
+#define PBC_SEND_CTXT_SHIFT 56
+#define PBC_DLID_SHIFT 32
+#define PBC_DLID_MASK 0xffffff
+#define PBC_L2_TYPE_SHIFT 20
+#define PBC_PORT_IDX_SHIFT 16
+
+/* common PBC fields */
+#define PBC_INSERT_HCRC_SHIFT 26
+#define PBC_INSERT_HCRC_MASK 0x3ull
+#define PBC_INSERT_HCRC_SMASK \
+	(PBC_INSERT_HCRC_MASK << PBC_INSERT_HCRC_SHIFT)
+
+#define PBC_VL_SHIFT 12
+#define PBC_VL_MASK 0xfull
+#define PBC_VL_SMASK (PBC_VL_MASK << PBC_VL_SHIFT)
+
+#define PBC_LENGTH_DWS_SHIFT 0
+#define PBC_LENGTH_DWS_MASK 0xfffull
+#define PBC_LENGTH_DWS_SMASK \
+	(PBC_LENGTH_DWS_MASK << PBC_LENGTH_DWS_SHIFT)
+
+/* Credit Return Fields */
+#define CR_COUNTER_SHIFT 0
+#define CR_COUNTER_MASK 0x7ffull
+#define CR_COUNTER_SMASK (CR_COUNTER_MASK << CR_COUNTER_SHIFT)
+
+#define CR_STATUS_SHIFT 11
+#define CR_STATUS_MASK 0x1ull
+#define CR_STATUS_SMASK (CR_STATUS_MASK << CR_STATUS_SHIFT)
+
+#define CR_CREDIT_RETURN_DUE_TO_PBC_SHIFT 12
+#define CR_CREDIT_RETURN_DUE_TO_PBC_MASK 0x1ull
+#define CR_CREDIT_RETURN_DUE_TO_PBC_SMASK \
+	(CR_CREDIT_RETURN_DUE_TO_PBC_MASK << \
+	CR_CREDIT_RETURN_DUE_TO_PBC_SHIFT)
+
+#define CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SHIFT 13
+#define CR_CREDIT_RETURN_DUE_TO_THRESHOLD_MASK 0x1ull
+#define CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SMASK \
+	(CR_CREDIT_RETURN_DUE_TO_THRESHOLD_MASK << \
+	CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SHIFT)
+
+#define CR_CREDIT_RETURN_DUE_TO_ERR_SHIFT 14
+#define CR_CREDIT_RETURN_DUE_TO_ERR_MASK 0x1ull
+#define CR_CREDIT_RETURN_DUE_TO_ERR_SMASK \
+	(CR_CREDIT_RETURN_DUE_TO_ERR_MASK << \
+	CR_CREDIT_RETURN_DUE_TO_ERR_SHIFT)
+
+#define CR_CREDIT_RETURN_DUE_TO_FORCE_SHIFT 15
+#define CR_CREDIT_RETURN_DUE_TO_FORCE_MASK 0x1ull
+#define CR_CREDIT_RETURN_DUE_TO_FORCE_SMASK \
+	(CR_CREDIT_RETURN_DUE_TO_FORCE_MASK << \
+	CR_CREDIT_RETURN_DUE_TO_FORCE_SHIFT)
+
+/* Specific IRQ sources */
+#define CCE_ERR_INT		  0
+#define RXE_ERR_INT		  1
+#define MISC_ERR_INT		  2
+#define PIO_ERR_INT		  4
+#define SDMA_ERR_INT		  5
+#define EGRESS_ERR_INT		  6
+#define TXE_ERR_INT		  7
+#define PBC_INT			240
+#define GPIO_ASSERT_INT		241
+#define QSFP1_INT		242
+#define QSFP2_INT		243
+#define TCRIT_INT		244
+
+/* interrupt source ranges */
+#define IS_GENERAL_ERR_START		  0
+#define IS_SDMAENG_ERR_START		 16
+#define IS_SENDCTXT_ERR_START		 32
+#define IS_SDMA_START			192
+#define IS_SDMA_PROGRESS_START		208
+#define IS_SDMA_IDLE_START		224
+#define IS_VARIOUS_START		240
+#define IS_DC_START			248
+#define IS_RCVAVAIL_START		256
+#define IS_RCVURGENT_START		416
+#define IS_SENDCREDIT_START		576
+#define IS_RESERVED_START		736
+#define IS_LAST_SOURCE			767
+
+/* derived interrupt source values */
+#define IS_GENERAL_ERR_END		15
+#define IS_SDMAENG_ERR_END		31
+#define IS_SENDCTXT_ERR_END		191
+#define IS_SDMA_END                     207
+#define IS_SDMA_PROGRESS_END            223
+#define IS_SDMA_IDLE_END		239
+#define IS_VARIOUS_END			247
+#define IS_DC_END			255
+#define IS_RCVAVAIL_END			415
+#define IS_RCVURGENT_END		575
+#define IS_SENDCREDIT_END		735
+#define IS_RESERVED_END			IS_LAST_SOURCE
+
+/* DCC_CFG_PORT_CONFIG logical link states */
+#define LSTATE_DOWN    0x1
+#define LSTATE_INIT    0x2
+#define LSTATE_ARMED   0x3
+#define LSTATE_ACTIVE  0x4
+
+/* DCC_CFG_RESET reset states */
+#define LCB_RX_FPE_TX_FPE_INTO_RESET   (DCC_CFG_RESET_RESET_LCB    | \
+					DCC_CFG_RESET_RESET_TX_FPE | \
+					DCC_CFG_RESET_RESET_RX_FPE | \
+					DCC_CFG_RESET_ENABLE_CCLK_BCC)
+					/* 0x17 */
+
+#define LCB_RX_FPE_TX_FPE_OUT_OF_RESET  DCC_CFG_RESET_ENABLE_CCLK_BCC /* 0x10 */
+
+/* DC8051_STS_CUR_STATE port values (physical link states) */
+#define PLS_DISABLED			   0x30
+#define PLS_OFFLINE				   0x90
+#define PLS_OFFLINE_QUIET			   0x90
+#define PLS_OFFLINE_PLANNED_DOWN_INFORM	   0x91
+#define PLS_OFFLINE_READY_TO_QUIET_LT	   0x92
+#define PLS_OFFLINE_REPORT_FAILURE		   0x93
+#define PLS_OFFLINE_READY_TO_QUIET_BCC	   0x94
+#define PLS_OFFLINE_QUIET_DURATION	   0x95
+#define PLS_POLLING				   0x20
+#define PLS_POLLING_QUIET			   0x20
+#define PLS_POLLING_ACTIVE			   0x21
+#define PLS_CONFIGPHY			   0x40
+#define PLS_CONFIGPHY_DEBOUCE		   0x40
+#define PLS_CONFIGPHY_ESTCOMM		   0x41
+#define PLS_CONFIGPHY_ESTCOMM_TXRX_HUNT	   0x42
+#define PLS_CONFIGPHY_ESTCOMM_LOCAL_COMPLETE   0x43
+#define PLS_CONFIGPHY_OPTEQ			   0x44
+#define PLS_CONFIGPHY_OPTEQ_OPTIMIZING	   0x44
+#define PLS_CONFIGPHY_OPTEQ_LOCAL_COMPLETE	   0x45
+#define PLS_CONFIGPHY_VERIFYCAP		   0x46
+#define PLS_CONFIGPHY_VERIFYCAP_EXCHANGE	   0x46
+#define PLS_CONFIGPHY_VERIFYCAP_LOCAL_COMPLETE 0x47
+#define PLS_CONFIGLT			   0x48
+#define PLS_CONFIGLT_CONFIGURE		   0x48
+#define PLS_CONFIGLT_LINK_TRANSFER_ACTIVE	   0x49
+#define PLS_LINKUP				   0x50
+#define PLS_PHYTEST				   0xB0
+#define PLS_INTERNAL_SERDES_LOOPBACK	   0xe1
+#define PLS_QUICK_LINKUP			   0xe2
+
+/* DC_DC8051_CFG_HOST_CMD_0.REQ_TYPE - 8051 host commands */
+#define HCMD_LOAD_CONFIG_DATA  0x01
+#define HCMD_READ_CONFIG_DATA  0x02
+#define HCMD_CHANGE_PHY_STATE  0x03
+#define HCMD_SEND_LCB_IDLE_MSG 0x04
+#define HCMD_MISC		   0x05
+#define HCMD_READ_LCB_IDLE_MSG 0x06
+#define HCMD_READ_LCB_CSR      0x07
+#define HCMD_WRITE_LCB_CSR     0x08
+#define HCMD_INTERFACE_TEST	   0xff
+
+/* DC_DC8051_CFG_HOST_CMD_1.RETURN_CODE - 8051 host command return */
+#define HCMD_SUCCESS 2
+
+/* DC_DC8051_DBG_ERR_INFO_SET_BY_8051.ERROR - error flags */
+#define SPICO_ROM_FAILED		BIT(0)
+#define UNKNOWN_FRAME			BIT(1)
+#define TARGET_BER_NOT_MET		BIT(2)
+#define FAILED_SERDES_INTERNAL_LOOPBACK	BIT(3)
+#define FAILED_SERDES_INIT		BIT(4)
+#define FAILED_LNI_POLLING		BIT(5)
+#define FAILED_LNI_DEBOUNCE		BIT(6)
+#define FAILED_LNI_ESTBCOMM		BIT(7)
+#define FAILED_LNI_OPTEQ		BIT(8)
+#define FAILED_LNI_VERIFY_CAP1		BIT(9)
+#define FAILED_LNI_VERIFY_CAP2		BIT(10)
+#define FAILED_LNI_CONFIGLT		BIT(11)
+#define HOST_HANDSHAKE_TIMEOUT		BIT(12)
+#define EXTERNAL_DEVICE_REQ_TIMEOUT	BIT(13)
+
+#define FAILED_LNI (FAILED_LNI_POLLING | FAILED_LNI_DEBOUNCE \
+			| FAILED_LNI_ESTBCOMM | FAILED_LNI_OPTEQ \
+			| FAILED_LNI_VERIFY_CAP1 \
+			| FAILED_LNI_VERIFY_CAP2 \
+			| FAILED_LNI_CONFIGLT | HOST_HANDSHAKE_TIMEOUT \
+			| EXTERNAL_DEVICE_REQ_TIMEOUT)
+
+/* DC_DC8051_DBG_ERR_INFO_SET_BY_8051.HOST_MSG - host message flags */
+#define HOST_REQ_DONE		BIT(0)
+#define BC_PWR_MGM_MSG		BIT(1)
+#define BC_SMA_MSG		BIT(2)
+#define BC_BCC_UNKNOWN_MSG	BIT(3)
+#define BC_IDLE_UNKNOWN_MSG	BIT(4)
+#define EXT_DEVICE_CFG_REQ	BIT(5)
+#define VERIFY_CAP_FRAME	BIT(6)
+#define LINKUP_ACHIEVED		BIT(7)
+#define LINK_GOING_DOWN		BIT(8)
+#define LINK_WIDTH_DOWNGRADED	BIT(9)
+
+/* DC_DC8051_CFG_EXT_DEV_1.REQ_TYPE - 8051 host requests */
+#define HREQ_LOAD_CONFIG	0x01
+#define HREQ_SAVE_CONFIG	0x02
+#define HREQ_READ_CONFIG	0x03
+#define HREQ_SET_TX_EQ_ABS	0x04
+#define HREQ_SET_TX_EQ_REL	0x05
+#define HREQ_ENABLE		0x06
+#define HREQ_LCB_RESET		0x07
+#define HREQ_CONFIG_DONE	0xfe
+#define HREQ_INTERFACE_TEST	0xff
+
+/* DC_DC8051_CFG_EXT_DEV_0.RETURN_CODE - 8051 host request return codes */
+#define HREQ_INVALID		0x01
+#define HREQ_SUCCESS		0x02
+#define HREQ_NOT_SUPPORTED		0x03
+#define HREQ_FEATURE_NOT_SUPPORTED	0x04 /* request specific feature */
+#define HREQ_REQUEST_REJECTED	0xfe
+#define HREQ_EXECUTION_ONGOING	0xff
+
+/* MISC host command functions */
+#define HCMD_MISC_REQUEST_LCB_ACCESS 0x1
+#define HCMD_MISC_GRANT_LCB_ACCESS   0x2
+
+/* idle flit message types */
+#define IDLE_PHYSICAL_LINK_MGMT 0x1
+#define IDLE_CRU		    0x2
+#define IDLE_SMA		    0x3
+#define IDLE_POWER_MGMT	    0x4
+
+/* idle flit message send fields (both send and read) */
+#define IDLE_PAYLOAD_MASK 0xffffffffffull /* 40 bits */
+#define IDLE_PAYLOAD_SHIFT 8
+#define IDLE_MSG_TYPE_MASK 0xf
+#define IDLE_MSG_TYPE_SHIFT 0
+
+/* idle flit message read fields */
+#define READ_IDLE_MSG_TYPE_MASK 0xf
+#define READ_IDLE_MSG_TYPE_SHIFT 0
+
+/* SMA idle flit payload commands */
+#define SMA_IDLE_ARM	1
+#define SMA_IDLE_ACTIVE 2
+
+/* DC_DC8051_CFG_MODE.GENERAL bits */
+#define DISABLE_SELF_GUID_CHECK 0x2
+
+/* Bad L2 frame error code */
+#define BAD_L2_ERR      0x6
+
+/*
+ * Eager buffer minimum and maximum sizes supported by the hardware.
+ * All power-of-two sizes in between are supported as well.
+ * MAX_EAGER_BUFFER_TOTAL is the maximum size of memory
+ * allocatable for Eager buffer to a single context. All others
+ * are limits for the RcvArray entries.
+ */
+#define MIN_EAGER_BUFFER       (4 * 1024)
+#define MAX_EAGER_BUFFER       (256 * 1024)
+#define MAX_EAGER_BUFFER_TOTAL (64 * (1 << 20)) /* max per ctxt 64MB */
+#define MAX_EXPECTED_BUFFER    (2048 * 1024)
+#define HFI2_MIN_HDRQ_EGRBUF_CNT 32
+#define HFI2_MAX_HDRQ_EGRBUF_CNT 16352
+
+/*
+ * Receive expected base and count and eager base and count increment -
+ * the CSR fields hold multiples of this value.
+ */
+#define RCV_SHIFT 3
+#define RCV_INCREMENT BIT(RCV_SHIFT)
+
+/*
+ * Receive header queue entry increment - the CSR holds multiples of
+ * this value.
+ */
+#define HDRQ_SIZE_SHIFT 5
+#define HDRQ_INCREMENT BIT(HDRQ_SIZE_SHIFT)
+
+/*
+ * Freeze handling flags
+ */
+#define FREEZE_ABORT     0x01	/* do not do recovery */
+#define FREEZE_SELF	     0x02	/* initiate the freeze */
+#define FREEZE_LINK_DOWN 0x04	/* link is down */
+
+/*
+ * Chip implementation codes.
+ */
+#define ICODE_RTL_SILICON		0x00
+#define ICODE_RTL_VCS_SIMULATION	0x01
+#define ICODE_FPGA_EMULATION	0x02
+#define ICODE_FUNCTIONAL_SIMULATOR	0x03
+
+/*
+ * 8051 data memory size.
+ */
+#define DC8051_DATA_MEM_SIZE 0x1000
+
+/*
+ * 8051 firmware registers
+ */
+#define NUM_GENERAL_FIELDS 0x17
+#define NUM_LANE_FIELDS    0x8
+
+/* 8051 general register Field IDs */
+#define LINK_OPTIMIZATION_SETTINGS   0x00
+#define LINK_TUNING_PARAMETERS	     0x02
+#define DC_HOST_COMM_SETTINGS	     0x03
+#define TX_SETTINGS		     0x06
+#define VERIFY_CAP_LOCAL_PHY	     0x07
+#define VERIFY_CAP_LOCAL_FABRIC	     0x08
+#define VERIFY_CAP_LOCAL_LINK_MODE   0x09
+#define LOCAL_DEVICE_ID		     0x0a
+#define RESERVED_REGISTERS	     0x0b
+#define LOCAL_LNI_INFO		     0x0c
+#define REMOTE_LNI_INFO              0x0d
+#define MISC_STATUS		     0x0e
+#define VERIFY_CAP_REMOTE_PHY	     0x0f
+#define VERIFY_CAP_REMOTE_FABRIC     0x10
+#define VERIFY_CAP_REMOTE_LINK_WIDTH 0x11
+#define LAST_LOCAL_STATE_COMPLETE    0x12
+#define LAST_REMOTE_STATE_COMPLETE   0x13
+#define LINK_QUALITY_INFO            0x14
+#define REMOTE_DEVICE_ID	     0x15
+#define LINK_DOWN_REASON	     0x16 /* first byte of offset 0x16 */
+#define VERSION_PATCH		     0x16 /* last byte of offset 0x16 */
+
+/* 8051 lane specific register field IDs */
+#define TX_EQ_SETTINGS		0x00
+#define CHANNEL_LOSS_SETTINGS	0x05
+
+/* Lane ID for general configuration registers */
+#define GENERAL_CONFIG 4
+
+/* LINK_TUNING_PARAMETERS fields */
+#define TUNING_METHOD_SHIFT 24
+
+/* LINK_OPTIMIZATION_SETTINGS fields */
+#define ENABLE_EXT_DEV_CONFIG_SHIFT 24
+
+/* LOAD_DATA 8051 command shifts and fields */
+#define LOAD_DATA_FIELD_ID_SHIFT 40
+#define LOAD_DATA_FIELD_ID_MASK 0xfull
+#define LOAD_DATA_LANE_ID_SHIFT 32
+#define LOAD_DATA_LANE_ID_MASK 0xfull
+#define LOAD_DATA_DATA_SHIFT   0x0
+#define LOAD_DATA_DATA_MASK   0xffffffffull
+
+/* READ_DATA 8051 command shifts and fields */
+#define READ_DATA_FIELD_ID_SHIFT 40
+#define READ_DATA_FIELD_ID_MASK 0xffull
+#define READ_DATA_LANE_ID_SHIFT 32
+#define READ_DATA_LANE_ID_MASK 0xffull
+#define READ_DATA_DATA_SHIFT   0x0
+#define READ_DATA_DATA_MASK   0xffffffffull
+
+/* TX settings fields */
+#define ENABLE_LANE_TX_SHIFT		0
+#define ENABLE_LANE_TX_MASK		0xff
+#define TX_POLARITY_INVERSION_SHIFT	8
+#define TX_POLARITY_INVERSION_MASK	0xff
+#define RX_POLARITY_INVERSION_SHIFT	16
+#define RX_POLARITY_INVERSION_MASK	0xff
+#define MAX_RATE_SHIFT			24
+#define MAX_RATE_MASK			0xff
+
+/* verify capability PHY fields */
+#define CONTINIOUS_REMOTE_UPDATE_SUPPORT_SHIFT	0x4
+#define CONTINIOUS_REMOTE_UPDATE_SUPPORT_MASK	0x1
+#define POWER_MANAGEMENT_SHIFT			0x0
+#define POWER_MANAGEMENT_MASK			0xf
+
+/* 8051 lane register Field IDs */
+#define SPICO_FW_VERSION 0x7	/* SPICO firmware version */
+
+/* SPICO firmware version fields */
+#define SPICO_ROM_VERSION_SHIFT 0
+#define SPICO_ROM_VERSION_MASK 0xffff
+#define SPICO_ROM_PROD_ID_SHIFT 16
+#define SPICO_ROM_PROD_ID_MASK 0xffff
+
+/* verify capability fabric fields */
+#define VAU_SHIFT	0
+#define VAU_MASK	0x0007
+#define Z_SHIFT		3
+#define Z_MASK		0x0001
+#define VCU_SHIFT	4
+#define VCU_MASK	0x0007
+#define VL15BUF_SHIFT	8
+#define VL15BUF_MASK	0x0fff
+#define CRC_SIZES_SHIFT 20
+#define CRC_SIZES_MASK	0x7
+
+/* verify capability local link width fields */
+#define LINK_WIDTH_SHIFT 0		/* also for remote link width */
+#define LINK_WIDTH_MASK 0xffff		/* also for remote link width */
+#define LOCAL_FLAG_BITS_SHIFT 16
+#define LOCAL_FLAG_BITS_MASK 0xff
+#define MISC_CONFIG_BITS_SHIFT 24
+#define MISC_CONFIG_BITS_MASK 0xff
+
+/* verify capability remote link width fields */
+#define REMOTE_TX_RATE_SHIFT 16
+#define REMOTE_TX_RATE_MASK 0xff
+
+/* LOCAL_DEVICE_ID fields */
+#define LOCAL_DEVICE_REV_SHIFT 0
+#define LOCAL_DEVICE_REV_MASK 0xff
+#define LOCAL_DEVICE_ID_SHIFT 8
+#define LOCAL_DEVICE_ID_MASK 0xffff
+
+/* REMOTE_DEVICE_ID fields */
+#define REMOTE_DEVICE_REV_SHIFT 0
+#define REMOTE_DEVICE_REV_MASK 0xff
+#define REMOTE_DEVICE_ID_SHIFT 8
+#define REMOTE_DEVICE_ID_MASK 0xffff
+
+/* local LNI link width fields */
+#define ENABLE_LANE_RX_SHIFT 16
+#define ENABLE_LANE_RX_MASK  0xff
+
+/* mask, shift for reading 'mgmt_enabled' value from REMOTE_LNI_INFO field */
+#define MGMT_ALLOWED_SHIFT 23
+#define MGMT_ALLOWED_MASK 0x1
+
+/* mask, shift for 'link_quality' within LINK_QUALITY_INFO field */
+#define LINK_QUALITY_SHIFT 24
+#define LINK_QUALITY_MASK  0x7
+
+/*
+ * mask, shift for reading 'planned_down_remote_reason_code'
+ * from LINK_QUALITY_INFO field
+ */
+#define DOWN_REMOTE_REASON_SHIFT 16
+#define DOWN_REMOTE_REASON_MASK  0xff
+
+#define HOST_INTERFACE_VERSION 1
+#define HOST_INTERFACE_VERSION_SHIFT 16
+#define HOST_INTERFACE_VERSION_MASK  0xff
+
+/* verify capability PHY power management bits */
+#define PWRM_BER_CONTROL	0x1
+#define PWRM_BANDWIDTH_CONTROL	0x2
+
+/* 8051 link down reasons */
+#define LDR_LINK_TRANSFER_ACTIVE_LOW   0xa
+#define LDR_RECEIVED_LINKDOWN_IDLE_MSG 0xb
+#define LDR_RECEIVED_HOST_OFFLINE_REQ  0xc
+
+/* verify capability fabric CRC size bits */
+enum {
+	CAP_CRC_14B = (1 << 0), /* 14b CRC */
+	CAP_CRC_48B = (1 << 1), /* 48b CRC */
+	CAP_CRC_12B_16B_PER_LANE = (1 << 2) /* 12b-16b per lane CRC */
+};
+
+#define SUPPORTED_CRCS (CAP_CRC_14B | CAP_CRC_48B)
+
+/* misc status version fields */
+#define STS_FM_VERSION_MINOR_SHIFT 16
+#define STS_FM_VERSION_MINOR_MASK  0xff
+#define STS_FM_VERSION_MAJOR_SHIFT 24
+#define STS_FM_VERSION_MAJOR_MASK  0xff
+#define STS_FM_VERSION_PATCH_SHIFT 24
+#define STS_FM_VERSION_PATCH_MASK  0xff
+
+/* LCB_CFG_CRC_MODE TX_VAL and RX_VAL CRC mode values */
+#define LCB_CRC_16B			0x0	/* 16b CRC */
+#define LCB_CRC_14B			0x1	/* 14b CRC */
+#define LCB_CRC_48B			0x2	/* 48b CRC */
+#define LCB_CRC_12B_16B_PER_LANE	0x3	/* 12b-16b per lane CRC */
+
+/*
+ * the following enum is (almost) a copy/paste of the definition
+ * in the OPA spec, section 20.2.2.6.8 (PortInfo)
+ */
+enum {
+	PORT_LTP_CRC_MODE_NONE = 0,
+	PORT_LTP_CRC_MODE_14 = 1, /* 14-bit LTP CRC mode (optional) */
+	PORT_LTP_CRC_MODE_16 = 2, /* 16-bit LTP CRC mode */
+	PORT_LTP_CRC_MODE_48 = 4,
+		/* 48-bit overlapping LTP CRC mode (optional) */
+	PORT_LTP_CRC_MODE_PER_LANE = 8
+		/* 12 to 16 bit per lane LTP CRC mode (optional) */
+};
+
+/* timeouts */
+#define LINK_RESTART_DELAY 1000		/* link restart delay, in ms */
+#define TIMEOUT_8051_START 5000         /* 8051 start timeout, in ms */
+#define DC8051_COMMAND_TIMEOUT 1000	/* DC8051 command timeout, in ms */
+#define FREEZE_STATUS_TIMEOUT 20	/* wait for freeze indicators, in ms */
+#define VL_STATUS_CLEAR_TIMEOUT 5000	/* per-VL status clear, in ms */
+#define CCE_STATUS_TIMEOUT 10		/* time to clear CCE Status, in ms */
+
+/* cclock tick time, in picoseconds per tick: 1/speed * 10^12  */
+#define ASIC_CCLOCK_PS  1242	/* 805 MHz */
+
+/*
+ * Mask of enabled MISC errors.  Do not enable the two RSA engine errors -
+ * see firmware.c:run_rsa() for details.
+ */
+#define DRIVER_MISC_MASK \
+	(~(MISC_ERR_STATUS_MISC_FW_AUTH_FAILED_ERR_SMASK \
+		| MISC_ERR_STATUS_MISC_KEY_MISMATCH_ERR_SMASK))
+
+/* valid values for the loopback module parameter */
+#define LOOPBACK_NONE	0	/* no loopback - default */
+#define LOOPBACK_SERDES 1
+#define LOOPBACK_LCB	2
+#define LOOPBACK_CABLE	3	/* external cable */
+
+/* set up bits in MISC_CONFIG_BITS */
+#define LOOPBACK_SERDES_CONFIG_BIT_MASK_SHIFT 0
+#define EXT_CFG_LCB_RESET_SUPPORTED_SHIFT     3
+
+/* read and write hardware registers */
+u64 read_csr(const struct hfi2_devdata *dd, u32 offset);
+void write_csr(const struct hfi2_devdata *dd, u32 offset, u64 value);
+
+int read_lcb_csr(struct hfi2_pportdata *ppd, u32 offset, u64 *data);
+int write_lcb_csr(struct hfi2_pportdata *ppd, u32 offset, u64 data);
+
+void __iomem *get_csr_addr(
+	const struct hfi2_devdata *dd,
+	u32 offset);
+
+static inline u32 chip_rcv_contexts(struct hfi2_devdata *dd)
+{
+	return read_csr(dd, RCV_CONTEXTS);
+}
+
+static inline u32 chip_rcv_array_count(struct hfi2_devdata *dd)
+{
+	return read_csr(dd, RCV_ARRAY_CNT);
+}
+
+bool wfr_check_synth_status(struct hfi2_devdata *dd);
+void wfr_update_synth_status(struct hfi2_devdata *dd);
+
+u8 encode_rcv_header_entry_size(u8 size);
+int hfi2_validate_rcvhdrcnt(struct hfi2_devdata *dd, uint thecnt);
+void set_hdrq_regs(struct hfi2_pportdata *ppd, u16 ctxt, u8 entsize, u16 hdrcnt,
+		   u8 kdeth_rcv_hdr);
+void wfr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt, u32 size);
+
+u64 wfr_create_pbc(struct hfi2_pportdata *ppd, u64 flags, int srate_mbs, u32 vl,
+		   u32 dw_len, u32 l2, u32 dlid, u32 sctxt);
+
+/* firmware.c */
+#define SBUS_MASTER_BROADCAST 0xfd
+#define NUM_PCIE_SERDES 16	/* number of PCIe serdes on the SBus */
+extern const u8 pcie_serdes_broadcast[];
+extern const u8 pcie_pcs_addrs[2][NUM_PCIE_SERDES];
+
+/* SBus commands */
+#define RESET_SBUS_RECEIVER 0x20
+#define WRITE_SBUS_RECEIVER 0x21
+#define READ_SBUS_RECEIVER  0x22
+void sbus_request(struct hfi2_devdata *dd,
+		  u8 receiver_addr, u8 data_addr, u8 command, u32 data_in);
+int sbus_request_slow(struct hfi2_devdata *dd,
+		      u8 receiver_addr, u8 data_addr, u8 command, u32 data_in);
+void set_sbus_fast_mode(struct hfi2_devdata *dd);
+void clear_sbus_fast_mode(struct hfi2_devdata *dd);
+int hfi2_firmware_init(struct hfi2_devdata *dd);
+int load_pcie_firmware(struct hfi2_devdata *dd);
+int load_firmware(struct hfi2_devdata *dd);
+void dispose_firmware(void);
+int acquire_hw_mutex(struct hfi2_devdata *dd);
+void release_hw_mutex(struct hfi2_devdata *dd);
+
+/*
+ * Bitmask of dynamic access for ASIC block chip resources.  Each chip has its
+ * own range of bits for the resource so it can clear its own bits on
+ * starting and exiting.  If either device has the resource bit set, the
+ * resource is in use.  The separate bit ranges are:
+ *	HFI  bits  7:0
+ *	HFI2 bits 15:8
+ */
+#define CR_SBUS  0x01	/* SBUS, THERM, and PCIE registers */
+#define CR_EPROM 0x02	/* EEP, GPIO registers */
+#define CR_I2C1  0x04	/* QSFP1_OE register */
+#define CR_I2C2  0x08	/* QSFP2_OE register */
+#define CR_DYN_SHIFT 8	/* dynamic flag shift */
+#define CR_DYN_MASK  ((1ull << CR_DYN_SHIFT) - 1)
+
+/*
+ * Bitmask of static ASIC states these are outside of the dynamic ASIC
+ * block chip resources above.  These are to be set once and never cleared.
+ * Must be holding the SBus dynamic flag when setting.
+ */
+#define CR_THERM_INIT	0x010000
+
+int acquire_chip_resource(struct hfi2_devdata *dd, u32 resource, u32 mswait);
+void release_chip_resource(struct hfi2_devdata *dd, u32 resource);
+bool check_chip_resource(struct hfi2_devdata *dd, u32 resource,
+			 const char *func);
+void init_chip_resources(struct hfi2_devdata *dd);
+void finish_chip_resources(struct hfi2_devdata *dd);
+
+/* ms wait time for access to an SBus resoure */
+#define SBUS_TIMEOUT 4000 /* long enough for a FW download and SBR */
+
+/* ms wait time for a qsfp (i2c) chain to become available */
+#define QSFP_WAIT 20000 /* long enough for FW update to the F4 uc */
+
+void fabric_serdes_reset(struct hfi2_devdata *dd);
+int read_8051_data(struct hfi2_devdata *dd, u32 addr, u32 len, u64 *result);
+
+/* wfr specific */
+int wfr_find_used_resources(struct hfi2_devdata *dd);
+int wfr_early_per_chip_init(struct hfi2_devdata *dd);
+int wfr_mid_per_chip_init(struct hfi2_devdata *dd);
+int wfr_late_per_chip_init(struct hfi2_devdata *dd);
+void wfr_enable_rcv_context(struct hfi2_pportdata *ppd, u16 ctxt,
+			    u64 *kctxt_ctrl, bool enable);
+
+/* chip.c */
+void read_misc_status(struct hfi2_devdata *dd, u8 *ver_major, u8 *ver_minor,
+		      u8 *ver_patch);
+int write_host_interface_version(struct hfi2_devdata *dd, u8 version);
+void read_guid(struct hfi2_devdata *dd);
+int wait_fm_ready(struct hfi2_devdata *dd, u32 mstimeout);
+void set_link_down_reason(struct hfi2_pportdata *ppd, u8 lcl_reason,
+			  u8 neigh_reason, u8 rem_reason);
+int set_link_state(struct hfi2_pportdata *, u32 state);
+void init_kdeth_qp(struct hfi2_devdata *dd);
+int port_ltp_to_cap(int port_ltp);
+void handle_verify_cap(struct work_struct *work);
+void handle_freeze(struct work_struct *work);
+void handle_link_up(struct work_struct *work);
+void handle_link_down(struct work_struct *work);
+void handle_link_downgrade(struct work_struct *work);
+void wfr_handle_link_bounce(struct work_struct *work);
+void handle_start_link(struct work_struct *work);
+void handle_sma_message(struct work_struct *work);
+int reset_qsfp(struct hfi2_pportdata *ppd);
+void qsfp_event(struct work_struct *work);
+void start_freeze_handling(struct hfi2_devdata *dd, int flags);
+void start_linkdown_handling(struct hfi2_pportdata *ppd);
+int send_idle_sma(struct hfi2_devdata *dd, u64 message);
+int load_8051_config(struct hfi2_devdata *, u8, u8, u32);
+int read_8051_config(struct hfi2_devdata *, u8, u8, u32 *);
+int start_link(struct hfi2_pportdata *ppd);
+int bringup_serdes(struct hfi2_pportdata *ppd);
+void set_intr_state(struct hfi2_devdata *dd, u32 enable);
+bool apply_link_downgrade_policy(struct hfi2_pportdata *ppd,
+				 bool refresh_widths);
+void update_usrhead(struct hfi2_ctxtdata *rcd, u32 hd, u32 updegr, u32 egrhd,
+		    u32 intr_adjust, u32 npkts);
+int stop_drain_data_vls(struct hfi2_pportdata *ppd);
+int open_fill_data_vls(struct hfi2_pportdata *ppd);
+u32 ns_to_cclock(struct hfi2_devdata *dd, u32 ns);
+u32 cclock_to_ns(struct hfi2_devdata *dd, u32 cclock);
+void get_linkup_link_widths(struct hfi2_pportdata *ppd);
+void clear_linkup_counters(struct hfi2_pportdata *ppd);
+u32 hdrqempty(struct hfi2_ctxtdata *rcd);
+int is_ax(struct hfi2_devdata *dd);
+int is_bx(struct hfi2_devdata *dd);
+bool is_urg_masked(struct hfi2_ctxtdata *rcd);
+u32 read_physical_state(struct hfi2_devdata *dd);
+u32 chip_to_opa_pstate(struct hfi2_devdata *dd, u32 chip_pstate);
+const char *opa_pstate_name(u32 pstate);
+u32 driver_pstate(struct hfi2_pportdata *ppd);
+u32 driver_lstate(struct hfi2_pportdata *ppd);
+
+int acquire_lcb_access(struct hfi2_devdata *dd, int sleep_ok);
+int release_lcb_access(struct hfi2_devdata *dd, int sleep_ok);
+#define LCB_START DC_LCB_CSRS
+#define LCB_END   DC_8051_CSRS /* next block is 8051 */
+extern uint num_vls;
+
+extern uint disable_integrity;
+u64 read_dev_cntr(struct hfi2_devdata *dd, int index, int vl);
+u64 write_dev_cntr(struct hfi2_devdata *dd, int index, int vl, u64 data);
+u64 read_port_cntr(struct hfi2_pportdata *ppd, int index, int vl);
+u64 write_port_cntr(struct hfi2_pportdata *ppd, int index, int vl, u64 data);
+u32 read_logical_state(struct hfi2_devdata *dd);
+void force_recv_intr(struct hfi2_ctxtdata *rcd);
+
+/* Per VL indexes */
+enum {
+	C_VL_0 = 0,
+	C_VL_1,
+	C_VL_2,
+	C_VL_3,
+	C_VL_4,
+	C_VL_5,
+	C_VL_6,
+	C_VL_7,
+	C_VL_15,
+	C_VL_COUNT
+};
+
+static inline int vl_from_idx(int idx)
+{
+	return (idx == C_VL_15 ? 15 : idx);
+}
+
+static inline int idx_from_vl(int vl)
+{
+	return (vl == 15 ? C_VL_15 : vl);
+}
+
+/* shared device counter indexes */
+enum {
+	C_CCE_PCI_CR_ST,
+	C_CCE_SDMA_INT,
+	C_CCE_MISC_INT,
+	C_CCE_RCV_AV_INT,
+	C_CCE_RCV_URG_INT,
+	C_CCE_SEND_CR_INT,
+	C_SW_CPU_INTR,
+	C_SW_CPU_RCV_LIM,
+	C_SW_CTX0_SEQ_DROP,
+	C_SW_VTX_WAIT,
+	C_SW_PIO_WAIT,
+	C_SW_PIO_DRAIN,
+	C_SW_KMEM_WAIT,
+	C_SW_TID_WAIT,
+	C_SW_SEND_SCHED,
+	C_SDMA_DESC_FETCHED_CNT,
+	C_SDMA_INT_CNT,
+	C_SDMA_ERR_CNT,
+	C_SDMA_IDLE_INT_CNT,
+	C_SDMA_PROGRESS_INT_CNT,
+/* MISC_ERR_STATUS */
+	C_MISC_PLL_LOCK_FAIL_ERR,
+	C_MISC_MBIST_FAIL_ERR,
+	C_MISC_INVALID_EEP_CMD_ERR,
+	C_MISC_EFUSE_DONE_PARITY_ERR,
+	C_MISC_EFUSE_WRITE_ERR,
+	C_MISC_EFUSE_READ_BAD_ADDR_ERR,
+	C_MISC_EFUSE_CSR_PARITY_ERR,
+	C_MISC_FW_AUTH_FAILED_ERR,
+	C_MISC_KEY_MISMATCH_ERR,
+	C_MISC_SBUS_WRITE_FAILED_ERR,
+	C_MISC_CSR_WRITE_BAD_ADDR_ERR,
+	C_MISC_CSR_READ_BAD_ADDR_ERR,
+	C_MISC_CSR_PARITY_ERR,
+/* CceErrStatus */
+	/*
+	* A special counter that is the aggregate count
+	* of all the cce_err_status errors.  The remainder
+	* are actual bits in the CceErrStatus register.
+	*/
+	C_CCE_ERR_STATUS_AGGREGATED_CNT,
+	C_CCE_MSIX_CSR_PARITY_ERR,
+	C_CCE_INT_MAP_UNC_ERR,
+	C_CCE_INT_MAP_COR_ERR,
+	C_CCE_MSIX_TABLE_UNC_ERR,
+	C_CCE_MSIX_TABLE_COR_ERR,
+	C_CCE_RXDMA_CONV_FIFO_PARITY_ERR,
+	C_CCE_RCPL_ASYNC_FIFO_PARITY_ERR,
+	C_CCE_SEG_WRITE_BAD_ADDR_ERR,
+	C_CCE_SEG_READ_BAD_ADDR_ERR,
+	C_LA_TRIGGERED,
+	C_CCE_TRGT_CPL_TIMEOUT_ERR,
+	C_PCIC_RECEIVE_PARITY_ERR,
+	C_PCIC_TRANSMIT_BACK_PARITY_ERR,
+	C_PCIC_TRANSMIT_FRONT_PARITY_ERR,
+	C_PCIC_CPL_DAT_Q_UNC_ERR,
+	C_PCIC_CPL_HD_Q_UNC_ERR,
+	C_PCIC_POST_DAT_Q_UNC_ERR,
+	C_PCIC_POST_HD_Q_UNC_ERR,
+	C_PCIC_RETRY_SOT_MEM_UNC_ERR,
+	C_PCIC_RETRY_MEM_UNC_ERR,
+	C_PCIC_N_POST_DAT_Q_PARITY_ERR,
+	C_PCIC_N_POST_H_Q_PARITY_ERR,
+	C_PCIC_CPL_DAT_Q_COR_ERR,
+	C_PCIC_CPL_HD_Q_COR_ERR,
+	C_PCIC_POST_DAT_Q_COR_ERR,
+	C_PCIC_POST_HD_Q_COR_ERR,
+	C_PCIC_RETRY_SOT_MEM_COR_ERR,
+	C_PCIC_RETRY_MEM_COR_ERR,
+	C_CCE_CLI1_ASYNC_FIFO_DBG_PARITY_ERR,
+	C_CCE_CLI1_ASYNC_FIFO_RXDMA_PARITY_ERR,
+	C_CCE_CLI1_ASYNC_FIFO_SDMA_HD_PARITY_ERR,
+	C_CCE_CLI1_ASYNC_FIFO_PIO_CRDT_PARITY_ERR,
+	C_CCE_CLI2_ASYNC_FIFO_PARITY_ERR,
+	C_CCE_CSR_CFG_BUS_PARITY_ERR,
+	C_CCE_CLI0_ASYNC_FIFO_PARTIY_ERR,
+	C_CCE_RSPD_DATA_PARITY_ERR,
+	C_CCE_TRGT_ACCESS_ERR,
+	C_CCE_TRGT_ASYNC_FIFO_PARITY_ERR,
+	C_CCE_CSR_WRITE_BAD_ADDR_ERR,
+	C_CCE_CSR_READ_BAD_ADDR_ERR,
+	C_CCE_CSR_PARITY_ERR,
+/* RcvErrStatus */
+	C_RX_CSR_PARITY_ERR,
+	C_RX_CSR_WRITE_BAD_ADDR_ERR,
+	C_RX_CSR_READ_BAD_ADDR_ERR,
+	C_RX_DMA_CSR_UNC_ERR,
+	C_RX_DMA_DQ_FSM_ENCODING_ERR,
+	C_RX_DMA_EQ_FSM_ENCODING_ERR,
+	C_RX_DMA_CSR_PARITY_ERR,
+	C_RX_RBUF_DATA_COR_ERR,
+	C_RX_RBUF_DATA_UNC_ERR,
+	C_RX_DMA_DATA_FIFO_RD_COR_ERR,
+	C_RX_DMA_DATA_FIFO_RD_UNC_ERR,
+	C_RX_DMA_HDR_FIFO_RD_COR_ERR,
+	C_RX_DMA_HDR_FIFO_RD_UNC_ERR,
+	C_RX_RBUF_DESC_PART2_COR_ERR,
+	C_RX_RBUF_DESC_PART2_UNC_ERR,
+	C_RX_RBUF_DESC_PART1_COR_ERR,
+	C_RX_RBUF_DESC_PART1_UNC_ERR,
+	C_RX_HQ_INTR_FSM_ERR,
+	C_RX_HQ_INTR_CSR_PARITY_ERR,
+	C_RX_LOOKUP_CSR_PARITY_ERR,
+	C_RX_LOOKUP_RCV_ARRAY_COR_ERR,
+	C_RX_LOOKUP_RCV_ARRAY_UNC_ERR,
+	C_RX_LOOKUP_DES_PART2_PARITY_ERR,
+	C_RX_LOOKUP_DES_PART1_UNC_COR_ERR,
+	C_RX_LOOKUP_DES_PART1_UNC_ERR,
+	C_RX_RBUF_NEXT_FREE_BUF_COR_ERR,
+	C_RX_RBUF_NEXT_FREE_BUF_UNC_ERR,
+	C_RX_RBUF_FL_INIT_WR_ADDR_PARITY_ERR,
+	C_RX_RBUF_FL_INITDONE_PARITY_ERR,
+	C_RX_RBUF_FL_WRITE_ADDR_PARITY_ERR,
+	C_RX_RBUF_FL_RD_ADDR_PARITY_ERR,
+	C_RX_RBUF_EMPTY_ERR,
+	C_RX_RBUF_FULL_ERR,
+	C_RX_RBUF_BAD_LOOKUP_ERR,
+	C_RX_RBUF_CTX_ID_PARITY_ERR,
+	C_RX_RBUF_CSR_QEOPDW_PARITY_ERR,
+	C_RX_RBUF_CSR_Q_NUM_OF_PKT_PARITY_ERR,
+	C_RX_RBUF_CSR_Q_T1_PTR_PARITY_ERR,
+	C_RX_RBUF_CSR_Q_HD_PTR_PARITY_ERR,
+	C_RX_RBUF_CSR_Q_VLD_BIT_PARITY_ERR,
+	C_RX_RBUF_CSR_Q_NEXT_BUF_PARITY_ERR,
+	C_RX_RBUF_CSR_Q_ENT_CNT_PARITY_ERR,
+	C_RX_RBUF_CSR_Q_HEAD_BUF_NUM_PARITY_ERR,
+	C_RX_RBUF_BLOCK_LIST_READ_COR_ERR,
+	C_RX_RBUF_BLOCK_LIST_READ_UNC_ERR,
+	C_RX_RBUF_LOOKUP_DES_COR_ERR,
+	C_RX_RBUF_LOOKUP_DES_UNC_ERR,
+	C_RX_RBUF_LOOKUP_DES_REG_UNC_COR_ERR,
+	C_RX_RBUF_LOOKUP_DES_REG_UNC_ERR,
+	C_RX_RBUF_FREE_LIST_COR_ERR,
+	C_RX_RBUF_FREE_LIST_UNC_ERR,
+	C_RX_RCV_FSM_ENCODING_ERR,
+	C_RX_DMA_FLAG_COR_ERR,
+	C_RX_DMA_FLAG_UNC_ERR,
+	C_RX_DC_SOP_EOP_PARITY_ERR,
+	C_RX_RCV_CSR_PARITY_ERR,
+	C_RX_RCV_QP_MAP_TABLE_COR_ERR,
+	C_RX_RCV_QP_MAP_TABLE_UNC_ERR,
+	C_RX_RCV_DATA_COR_ERR,
+	C_RX_RCV_DATA_UNC_ERR,
+	C_RX_RCV_HDR_COR_ERR,
+	C_RX_RCV_HDR_UNC_ERR,
+	C_RX_DC_INTF_PARITY_ERR,
+	C_RX_DMA_CSR_COR_ERR,
+/* SendPioErrStatus */
+	C_PIO_PEC_SOP_HEAD_PARITY_ERR,
+	C_PIO_PCC_SOP_HEAD_PARITY_ERR,
+	C_PIO_LAST_RETURNED_CNT_PARITY_ERR,
+	C_PIO_CURRENT_FREE_CNT_PARITY_ERR,
+	C_PIO_RSVD_31_ERR,
+	C_PIO_RSVD_30_ERR,
+	C_PIO_PPMC_SOP_LEN_ERR,
+	C_PIO_PPMC_BQC_MEM_PARITY_ERR,
+	C_PIO_VL_FIFO_PARITY_ERR,
+	C_PIO_VLF_SOP_PARITY_ERR,
+	C_PIO_VLF_V1_LEN_PARITY_ERR,
+	C_PIO_BLOCK_QW_COUNT_PARITY_ERR,
+	C_PIO_WRITE_QW_VALID_PARITY_ERR,
+	C_PIO_STATE_MACHINE_ERR,
+	C_PIO_WRITE_DATA_PARITY_ERR,
+	C_PIO_HOST_ADDR_MEM_COR_ERR,
+	C_PIO_HOST_ADDR_MEM_UNC_ERR,
+	C_PIO_PKT_EVICT_SM_OR_ARM_SM_ERR,
+	C_PIO_INIT_SM_IN_ERR,
+	C_PIO_PPMC_PBL_FIFO_ERR,
+	C_PIO_CREDIT_RET_FIFO_PARITY_ERR,
+	C_PIO_V1_LEN_MEM_BANK1_COR_ERR,
+	C_PIO_V1_LEN_MEM_BANK0_COR_ERR,
+	C_PIO_V1_LEN_MEM_BANK1_UNC_ERR,
+	C_PIO_V1_LEN_MEM_BANK0_UNC_ERR,
+	C_PIO_SM_PKT_RESET_PARITY_ERR,
+	C_PIO_PKT_EVICT_FIFO_PARITY_ERR,
+	C_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR,
+	C_PIO_SBRDCTL_CRREL_PARITY_ERR,
+	C_PIO_PEC_FIFO_PARITY_ERR,
+	C_PIO_PCC_FIFO_PARITY_ERR,
+	C_PIO_SB_MEM_FIFO1_ERR,
+	C_PIO_SB_MEM_FIFO0_ERR,
+	C_PIO_CSR_PARITY_ERR,
+	C_PIO_WRITE_ADDR_PARITY_ERR,
+	C_PIO_WRITE_BAD_CTXT_ERR,
+/* SendDmaErrStatus */
+	C_SDMA_PCIE_REQ_TRACKING_COR_ERR,
+	C_SDMA_PCIE_REQ_TRACKING_UNC_ERR,
+	C_SDMA_CSR_PARITY_ERR,
+	C_SDMA_RPY_TAG_ERR,
+/* SendEgressErrStatus */
+	C_TX_READ_PIO_MEMORY_CSR_UNC_ERR,
+	C_TX_READ_SDMA_MEMORY_CSR_UNC_ERR,
+	C_TX_EGRESS_FIFO_COR_ERR,
+	C_TX_READ_PIO_MEMORY_COR_ERR,
+	C_TX_READ_SDMA_MEMORY_COR_ERR,
+	C_TX_SB_HDR_COR_ERR,
+	C_TX_CREDIT_OVERRUN_ERR,
+	C_TX_LAUNCH_FIFO8_COR_ERR,
+	C_TX_LAUNCH_FIFO7_COR_ERR,
+	C_TX_LAUNCH_FIFO6_COR_ERR,
+	C_TX_LAUNCH_FIFO5_COR_ERR,
+	C_TX_LAUNCH_FIFO4_COR_ERR,
+	C_TX_LAUNCH_FIFO3_COR_ERR,
+	C_TX_LAUNCH_FIFO2_COR_ERR,
+	C_TX_LAUNCH_FIFO1_COR_ERR,
+	C_TX_LAUNCH_FIFO0_COR_ERR,
+	C_TX_CREDIT_RETURN_VL_ERR,
+	C_TX_HCRC_INSERTION_ERR,
+	C_TX_EGRESS_FIFI_UNC_ERR,
+	C_TX_READ_PIO_MEMORY_UNC_ERR,
+	C_TX_READ_SDMA_MEMORY_UNC_ERR,
+	C_TX_SB_HDR_UNC_ERR,
+	C_TX_CREDIT_RETURN_PARITY_ERR,
+	C_TX_LAUNCH_FIFO8_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO7_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO6_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO5_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO4_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO3_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO2_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO1_UNC_OR_PARITY_ERR,
+	C_TX_LAUNCH_FIFO0_UNC_OR_PARITY_ERR,
+	C_TX_SDMA15_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA14_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA13_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA12_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA11_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA10_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA9_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA8_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA7_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA6_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA5_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA4_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA3_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA2_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA1_DISALLOWED_PACKET_ERR,
+	C_TX_SDMA0_DISALLOWED_PACKET_ERR,
+	C_TX_CONFIG_PARITY_ERR,
+	C_TX_SBRD_CTL_CSR_PARITY_ERR,
+	C_TX_LAUNCH_CSR_PARITY_ERR,
+	C_TX_ILLEGAL_CL_ERR,
+	C_TX_SBRD_CTL_STATE_MACHINE_PARITY_ERR,
+	C_TX_RESERVED_10,
+	C_TX_RESERVED_9,
+	C_TX_SDMA_LAUNCH_INTF_PARITY_ERR,
+	C_TX_PIO_LAUNCH_INTF_PARITY_ERR,
+	C_TX_RESERVED_6,
+	C_TX_INCORRECT_LINK_STATE_ERR,
+	C_TX_LINK_DOWN_ERR,
+	C_TX_EGRESS_FIFO_UNDERRUN_OR_PARITY_ERR,
+	C_TX_RESERVED_2,
+	C_TX_PKT_INTEGRITY_MEM_UNC_ERR,
+	C_TX_PKT_INTEGRITY_MEM_COR_ERR,
+/* SendErrStatus */
+	C_SEND_CSR_WRITE_BAD_ADDR_ERR,
+	C_SEND_CSR_READ_BAD_ADD_ERR,
+	C_SEND_CSR_PARITY_ERR,
+/* SendCtxtErrStatus */
+	C_PIO_WRITE_OUT_OF_BOUNDS_ERR,
+	C_PIO_WRITE_OVERFLOW_ERR,
+	C_PIO_WRITE_CROSSES_BOUNDARY_ERR,
+	C_PIO_DISALLOWED_PACKET_ERR,
+	C_PIO_INCONSISTENT_SOP_ERR,
+/*SendDmaEngErrStatus */
+	C_SDMA_HEADER_REQUEST_FIFO_COR_ERR,
+	C_SDMA_HEADER_STORAGE_COR_ERR,
+	C_SDMA_PACKET_TRACKING_COR_ERR,
+	C_SDMA_ASSEMBLY_COR_ERR,
+	C_SDMA_DESC_TABLE_COR_ERR,
+	C_SDMA_HEADER_REQUEST_FIFO_UNC_ERR,
+	C_SDMA_HEADER_STORAGE_UNC_ERR,
+	C_SDMA_PACKET_TRACKING_UNC_ERR,
+	C_SDMA_ASSEMBLY_UNC_ERR,
+	C_SDMA_DESC_TABLE_UNC_ERR,
+	C_SDMA_TIMEOUT_ERR,
+	C_SDMA_HEADER_LENGTH_ERR,
+	C_SDMA_HEADER_ADDRESS_ERR,
+	C_SDMA_HEADER_SELECT_ERR,
+	C_SMDA_RESERVED_9,
+	C_SDMA_PACKET_DESC_OVERFLOW_ERR,
+	C_SDMA_LENGTH_MISMATCH_ERR,
+	C_SDMA_HALT_ERR,
+	C_SDMA_MEM_READ_ERR,
+	C_SDMA_FIRST_DESC_ERR,
+	C_SDMA_TAIL_OUT_OF_BOUNDS_ERR,
+	C_SDMA_TOO_LONG_ERR,
+	C_SDMA_GEN_MISMATCH_ERR,
+	C_SDMA_WRONG_DW_ERR,
+	SHARED_DEV_CNTR_LAST  /* keep last */
+};
+
+/* chip specific counter start points - keep a separate range per chip */
+#define WFR_DEV_CNTR_FIRST 0x200
+#define JKR_DEV_CNTR_FIRST 0x400
+#define WFR_PORT_CNTR_FIRST 0x200
+#define JKR_PORT_CNTR_FIRST 0x400
+
+/* WFR device counter indexes */
+enum {
+	C_DC_UNC_ERR = WFR_DEV_CNTR_FIRST,
+	C_DC_RCV_ERR,
+	C_DC_FM_CFG_ERR,
+	C_DC_RMT_PHY_ERR,
+	C_DC_DROPPED_PKT,
+	C_DC_MC_XMIT_PKTS,
+	C_DC_MC_RCV_PKTS,
+	C_DC_XMIT_CERR,
+	C_DC_RCV_CERR,
+	C_DC_RCV_FCC,
+	C_DC_XMIT_FCC,
+	C_DC_XMIT_FLITS,
+	C_DC_RCV_FLITS,
+	C_DC_XMIT_PKTS,
+	C_DC_RCV_PKTS,
+	C_DC_RX_FLIT_VL,
+	C_DC_RX_PKT_VL,
+	C_DC_RCV_FCN,
+	C_DC_RCV_FCN_VL,
+	C_DC_RCV_BCN,
+	C_DC_RCV_BCN_VL,
+	C_DC_RCV_BBL,
+	C_DC_RCV_BBL_VL,
+	C_DC_MARK_FECN,
+	C_DC_MARK_FECN_VL,
+	C_DC_TOTAL_CRC,
+	C_DC_CRC_LN0,
+	C_DC_CRC_LN1,
+	C_DC_CRC_LN2,
+	C_DC_CRC_LN3,
+	C_DC_CRC_MULT_LN,
+	C_DC_TX_REPLAY,
+	C_DC_RX_REPLAY,
+	C_DC_SEQ_CRC_CNT,
+	C_DC_ESC0_ONLY_CNT,
+	C_DC_ESC0_PLUS1_CNT,
+	C_DC_ESC0_PLUS2_CNT,
+	C_DC_REINIT_FROM_PEER_CNT,
+	C_DC_SBE_CNT,
+	C_DC_MISC_FLG_CNT,
+	C_DC_PRF_GOOD_LTP_CNT,
+	C_DC_PRF_ACCEPTED_LTP_CNT,
+	C_DC_PRF_RX_FLIT_CNT,
+	C_DC_PRF_TX_FLIT_CNT,
+	C_DC_PRF_CLK_CNTR,
+	C_DC_PG_DBG_FLIT_CRDTS_CNT,
+	C_DC_PG_STS_PAUSE_COMPLETE_CNT,
+	C_DC_PG_STS_TX_SBE_CNT,
+	C_DC_PG_STS_TX_MBE_CNT,
+	C_CCE_PCI_TR_ST,
+	C_CCE_PIO_WR_ST,
+	C_CCE_ERR_INT,
+	WFR_DEV_CNTR_LAST  /* keep last */
+};
+
+#define WFR_NUM_DEV_CNTRS (WFR_DEV_CNTR_LAST - WFR_DEV_CNTR_FIRST)
+
+/* JKR device counter indexes */
+enum {
+	C_CCE_RW_ST_BY_R = JKR_DEV_CNTR_FIRST,
+	C_CCE_OTHER_INT,
+	C_CCE_PBC_ERR_INT,
+	C_CCE_PIO_ERR_INT,
+	C_CCE_SDMA_ERR_INT,
+	C_CCE_CSR_ERR_INT,
+	JKR_DEV_CNTR_LAST  /* keep last */
+};
+
+#define JKR_NUM_DEV_CNTRS (JKR_DEV_CNTR_LAST - JKR_DEV_CNTR_FIRST)
+
+/* Per port counter indexes */
+enum {
+	C_TX_UNSUP_VL = 0,
+	C_TX_INVAL_LEN,
+	C_TX_MM_LEN_ERR,
+	C_TX_UNDERRUN,
+	C_TX_FLOW_STALL,
+	C_TX_DROPPED,
+	C_TX_HDR_ERR,
+	C_TX_PKT,
+	C_TX_WORDS,
+	C_TX_WAIT,
+	C_TX_FLIT_VL,
+	C_TX_PKT_VL,
+	C_TX_WAIT_VL,
+	C_RCV_OVF,
+	C_RX_LEN_ERR,
+	C_RX_SHORT_ERR,
+	C_RX_ICRC_ERR,
+	C_RX_EBP,
+	C_RX_PKEY_MISMATCH,
+	C_RX_PKT,
+	C_RX_WORDS,
+	C_SW_LINK_DOWN,
+	C_SW_LINK_UP,
+	C_SW_UNKNOWN_FRAME,
+	C_SW_XMIT_DSCD,
+	C_SW_XMIT_DSCD_VL,
+	C_SW_XMIT_CSTR_ERR,
+	C_SW_RCV_CSTR_ERR,
+	C_SW_IBP_LOOP_PKTS,
+	C_SW_IBP_RC_RESENDS,
+	C_SW_IBP_RNR_NAKS,
+	C_SW_IBP_OTHER_NAKS,
+	C_SW_IBP_RC_TIMEOUTS,
+	C_SW_IBP_PKT_DROPS,
+	C_SW_IBP_DMA_WAIT,
+	C_SW_IBP_RC_SEQNAK,
+	C_SW_IBP_RC_DUPREQ,
+	C_SW_IBP_RDMA_SEQ,
+	C_SW_IBP_UNALIGNED,
+	C_SW_IBP_SEQ_NAK,
+	C_SW_IBP_RC_CRWAITS,
+	C_SW_CPU_RC_ACKS,
+	C_SW_CPU_RC_QACKS,
+	C_SW_CPU_RC_DELAYED_COMP,
+	C_RCV_HDR_OVF,
+	SHARED_PORT_CNTR_LAST /* Must be kept last */
+};
+
+/* WFR port counter indexes */
+enum {
+	C_WFR_RX_DROPPED_PKT = WFR_PORT_CNTR_FIRST,
+	C_WFR_RX_DROPPED_BYPASS_PKT,
+	C_WFR_RX_TID_FULL,
+	C_WFR_RX_TID_INVALID,
+	C_WFR_RX_TID_FLGMS,
+	C_WFR_RX_CTX_EGRS,
+	C_WFR_RCV_TID_FLSMS,
+	WFR_PORT_CNTR_LAST, /* keep last */
+};
+
+#define WFR_NUM_PORT_CNTRS (WFR_PORT_CNTR_LAST - WFR_PORT_CNTR_FIRST)
+
+/* JKR port counter indexes */
+enum {
+	C_JKR_RX_L2_TYPE_DISABLED = JKR_PORT_CNTR_FIRST,
+	C_JKR_RX_DROPPED_PKT_16B,
+	C_JKR_RX_DROPPED_PKT_9B,
+	C_JKR_RX_TID_FULL,
+	C_JKR_RX_TID_INVALID,
+	C_JKR_RX_TID_FLGMS,
+	C_JKR_RX_CTX_EGRS,
+	C_JKR_RCV_TID_FLSMS,
+	JKR_PORT_CNTR_LAST, /* keep last */
+};
+
+#define JKR_NUM_PORT_CNTRS (JKR_PORT_CNTR_LAST - JKR_PORT_CNTR_FIRST)
+
+/* SendEgressErrInfo bits that correspond to a PortXmitDiscard counter */
+#define WFR_PORT_DISCARD_EGRESS_ERRS \
+	(SEND_EGRESS_ERR_INFO_TOO_LONG_IB_PACKET_ERR_SMASK \
+	| SEND_EGRESS_ERR_INFO_VL_MAPPING_ERR_SMASK \
+	| SEND_EGRESS_ERR_INFO_VL_ERR_SMASK)
+
+u64 get_all_cpu_total(u64 __percpu *cntr);
+void hfi2_start_cleanup(struct hfi2_devdata *dd);
+void hfi2_clear_tids(struct hfi2_ctxtdata *rcd);
+void hfi2_init_ctxt(struct send_context *sc);
+void wfr_init_tids(struct hfi2_devdata *dd);
+void wfr_put_tid(struct hfi2_ctxtdata *rcd, u32 index,
+		 u32 type, unsigned long pa, u16 order, bool flush);
+void wfr_rcv_array_wc_fill(struct hfi2_ctxtdata *rcd, u32 index, u32 type);
+void wfr_set_port_tid_count(struct hfi2_ctxtdata *rcd);
+void hfi2_quiet_serdes(struct hfi2_pportdata *ppd);
+void hfi2_rcvctrl(struct hfi2_devdata *dd, unsigned int op,
+		  struct hfi2_ctxtdata *rcd);
+bool is_control_context(struct hfi2_ctxtdata *rcd);
+bool is_kernel_context(struct hfi2_ctxtdata *rcd);
+bool is_dynamic_context(struct hfi2_ctxtdata *rcd);
+bool is_user_context(struct hfi2_ctxtdata *rcd);
+u32 hfi2_read_cntrs(struct hfi2_devdata *dd, char **namep, u64 **cntrp);
+u32 hfi2_read_portcntrs(struct hfi2_pportdata *ppd, char **namep, u64 **cntrp);
+int hfi2_get_ib_cfg(struct hfi2_pportdata *ppd, int which);
+int hfi2_set_ib_cfg(struct hfi2_pportdata *ppd, int which, u32 val);
+int hfi2_set_ctxt_jkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd,
+		       u16 jkey);
+int hfi2_clear_ctxt_jkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *ctxt);
+int hfi2_set_ctxt_pkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *ctxt,
+		       u16 pkey);
+int hfi2_clear_ctxt_pkey(struct hfi2_devdata *dd, struct hfi2_ctxtdata *ctxt);
+void wfr_read_link_quality(struct hfi2_pportdata *ppd, u8 *link_quality);
+
+irqreturn_t general_interrupt(int irq, void *data);
+irqreturn_t sdma_interrupt(int irq, void *data);
+irqreturn_t sdma_interrupt_thr(int irq, void *data);
+irqreturn_t receive_context_interrupt(int irq, void *data);
+irqreturn_t receive_context_thread(int irq, void *data);
+irqreturn_t receive_context_interrupt_napi(int irq, void *data);
+
+int set_intr_bits(struct hfi2_devdata *dd, u16 first, u16 last, bool set);
+void init_qsfp_int(struct hfi2_pportdata *ppd);
+void remap_intr(struct hfi2_devdata *dd, int isrc, int msix_intr);
+void remap_sdma_interrupts(struct hfi2_devdata *dd, int engine, int msix_intr);
+void reset_interrupts(struct hfi2_devdata *dd);
+u16 hfi2_get_qp_map(struct hfi2_pportdata *ppd, u16 idx);
+void hfi2_init_aip_rsm(struct hfi2_pportdata *ppd);
+void hfi2_deinit_aip_rsm(struct hfi2_pportdata *ppd);
+void init_other(struct hfi2_devdata *dd);
+void init_early_variables(struct hfi2_devdata *dd);
+void wfr_set_port_max_mtu(struct hfi2_pportdata *ppd, u32 maxvlmtu);
+u32 slow_rhf_rcv_seq(struct hfi2_ctxtdata *rcd, u64 rhf);
+void release_rsm_rules(struct hfi2_devdata *dd);
+
+/*
+ * Interrupt source table.
+ *
+ * Each entry is an interrupt source "type".  It is ordered by increasing
+ * number.
+ */
+struct is_table {
+	int start;	 /* interrupt source type start */
+	int end;	 /* interrupt source type end */
+	/* routine that returns the name of the interrupt source */
+	char *(*is_name)(char *name, size_t size, unsigned int source);
+	/* routine to call when receiving an interrupt */
+	void (*is_int)(struct hfi2_devdata *dd, unsigned int source);
+};
+
+extern const struct is_table is_table[];
+
+/* table entry for general interrupt enable */
+struct gi_enable_entry {
+	u32 start;	/* starting source number */
+	u32 end;	/* ending source number */
+};
+
+extern const struct gi_enable_entry wfr_gi_enable_table[];
+
+/* interrupt clear down register type */
+enum icd_type {
+	ICD_NORMAL,	/* non-indexed register */
+	ICD_SDMA,	/* indexed SDMA register */
+	ICD_INGRESS,	/* indexed ingress register */
+	ICD_EGRESS,	/* indexed egress register */
+};
+
+/*
+ * Error interrupt table entry.  This is used as input to the interrupt
+ * "clear down" routine used for all second tier error interrupt registers.
+ * Second tier interrupt registers have a single bit representing them
+ * in the top-level CceIntStatus.
+ */
+struct err_reg_info {
+	u32 status;		/* status CSR offset */
+	u32 clear;		/* clear CSR offset */
+	u32 mask;		/* mask CSR offset */
+	enum icd_type type;	/* register type */
+	void (*handler)(struct hfi2_devdata *dd, u32 source, u64 reg);
+	const char *desc;
+};
+
+/* helpers for filling out struct err_reg_info */
+#define EE_N(reg, handler, desc) \
+	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_NORMAL, handler, desc }
+
+#define EE_S(reg, handler, desc) \
+	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_SDMA, handler, desc }
+
+#define EE_I(reg, handler, desc) \
+	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_INGRESS, handler, desc }
+
+#define EE_E(reg, handler, desc) \
+	{ reg##_STATUS, reg##_CLEAR, reg##_MASK, ICD_EGRESS, handler, desc }
+
+char *is_sdma_eng_err_name(char *buf, size_t bsize, unsigned int source);
+char *is_sendctxt_err_name(char *buf, size_t bsize, unsigned int source);
+char *is_sdma_eng_name(char *buf, size_t bsize, unsigned int source);
+char *is_rcv_avail_name(char *buf, size_t bsize, unsigned int source);
+char *is_rcv_urgent_name(char *buf, size_t bsize, unsigned int source);
+char *is_send_credit_name(char *buf, size_t bsize, unsigned int source);
+
+void interrupt_clear_down(struct hfi2_devdata *dd, u32 context,
+			  const struct err_reg_info *eri);
+void handle_sdma_eng_err(struct hfi2_devdata *dd, unsigned int context,
+			 u64 err_status);
+void is_sdma_eng_int(struct hfi2_devdata *dd, unsigned int source);
+void is_sendctxt_err_int(struct hfi2_devdata *dd, unsigned int hw_context);
+void is_rcv_avail_int(struct hfi2_devdata *dd, unsigned int source);
+void is_rcv_urgent_int(struct hfi2_devdata *dd, unsigned int source);
+void is_send_credit_int(struct hfi2_devdata *dd, unsigned int source);
+void handle_temp_err(struct hfi2_devdata *dd);
+void handle_pio_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+void handle_sdma_err(struct hfi2_devdata *dd, u32 unused, u64 reg);
+void handle_rxe_err(struct hfi2_devdata *dd, u32 pidx, u64 reg);
+void handle_egress_err(struct hfi2_devdata *dd, u32 pidx, u64 reg);
+
+void update_statusp(struct hfi2_pportdata *ppd, u32 state);
+const char *link_state_name(u32 state);
+const char *link_state_reason_name(struct hfi2_pportdata *ppd, u32 state);
+void log_state_transition(struct hfi2_pportdata *ppd, u32 state);
+void update_xmit_counters(struct hfi2_pportdata *ppd, u16 link_width);
+
+struct cntr_entry {
+	/* counter name */
+	char *name;
+	/* csr to read for name (if applicable) */
+	u64 csr;
+	/* offset into dd or ppd to store the counter's value */
+	int offset;
+	/* flags */
+	u8 flags;
+	/* accessor for stat element, context either dd or ppd */
+	u64 (*rw_cntr)(const struct cntr_entry *, void *context, int vl,
+		       int mode, u64 data);
+};
+
+extern struct cntr_entry wfr_dev_cntrs[];
+extern struct cntr_entry jkr_dev_cntrs[];
+extern struct cntr_entry wfr_port_cntrs[];
+extern struct cntr_entry jkr_port_cntrs[];
+
+struct flag_table {
+	u64 flag;	/* the flag */
+	char *str;	/* description string */
+	u16 extra;	/* extra information */
+	u16 unused0;
+	u32 unused1;
+};
+
+struct flag_data {
+	const struct flag_table *table;
+	u32 size;
+};
+
+extern const struct flag_data wfr_egress_err_info_data;
+
+#endif /* _CHIP_H */
diff --git a/drivers/infiniband/hw/hfi2/chip_gen.h b/drivers/infiniband/hw/hfi2/chip_gen.h
new file mode 100644
index 000000000000..8eb332cb610b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_gen.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023 Cornelis Networks, Inc.
+ *
+ * Generalized (parameterized) chip specific declaractions.
+ */
+
+#ifndef _CHIP_GEN_H
+#define _CHIP_GEN_H
+
+void gen_setextled(struct hfi2_pportdata *ppd, u32 on);
+void gen_start_led_override(struct hfi2_pportdata *ppd, unsigned int timeon,
+			    unsigned int timeoff);
+void gen_shutdown_led_override(struct hfi2_pportdata *ppd);
+void gen_read_guid(struct hfi2_devdata *dd);
+int gen_late_per_chip_init(struct hfi2_devdata *dd);
+void gen_start_port(struct hfi2_pportdata *ppd);
+void gen_stop_port(struct hfi2_pportdata *ppd);
+void gen_set_port_max_mtu(struct hfi2_pportdata *ppd, u32 maxvlmtu);
+u64 gen_create_pbc(struct hfi2_pportdata *ppd, u64 flags, int srate_mbs, u32 vl,
+		   u32 dw_len, u32 l2, u32 dlid, u32 sctxt);
+
+int cport_set_link_state(struct hfi2_pportdata *ppd, struct opa_port_info *pi, u32 state);
+int cport_start_link(struct hfi2_pportdata *ppd, struct opa_port_info *pi);
+
+int init_cport_trap128(struct hfi2_devdata *dd);
+int deinit_cport_trap128(struct hfi2_devdata *dd);
+
+#endif /* _CHIP_GEN_H */
diff --git a/drivers/infiniband/hw/hfi2/chip_jkr.h b/drivers/infiniband/hw/hfi2/chip_jkr.h
new file mode 100644
index 000000000000..c3ad10a9717b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_jkr.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023 Cornelis Networks, Inc.
+ */
+
+#ifndef _CHIP_JKR_H
+#define _CHIP_JKR_H
+
+#include "chip_registers_jkr.h"
+
+/* items not defined in the generated register file */
+#define JKR_PIO_SEND (JKR_TXE + JKR_C_TXE_PIO_SEND_OFFSET)
+#define JKR_RCV_ARRAY JKR_C_RXE_RCV_ARRAY_EGR_BASE
+
+/*
+ * The JKR BAR space is not split up by the RcvArray.  To maintain
+ * compatibility with WFR, arbitrarily split the BAR space at some
+ * page-aligned spot. Use JKR_RXE - the start of the RXE block.
+ */
+#define JKR_BAR0_SIZE (128 * 1024 * 1024)	/* 128 MB */
+#define JKR_KREG1_SIZE JKR_RXE
+#define JKR_KREG2_OFFSET JKR_RXE
+#define JKR_KREG2_SIZE (JKR_PIO_SEND - JKR_RXE)
+
+#define JKR_RCV_ARRAY_SIZE (64 * 1024 * 1024)	/* 64 MB */
+
+/* cclock tick time, in picoseconds per tick: 1/speed * 10^12  */
+#define JKR_ASIC_CCLOCK_PS 602	/* 1660.15625 MHz */
+
+/* max number of eager entries per context */
+#define JKR_MAX_EAGER_ENTRIES 16384
+
+/* Number of PKey entries in the JKR HW */
+#define JKR_MAX_PKEY_VALUES 1024
+/* number of SendCtxtCtrl.CtxtBase bits in the JKR HW */
+#define JKR_PIO_BASE_BITS 16
+
+/* register strides not derived from the spec */
+#define JKR_C_RXE_IPRC_STRIDE 8
+#define JKR_C_TXE_TCTXT_STRIDE 8
+#define JKR_C_TXE_SDMACFG_STRIDE 8
+#define JKR_C_TXE_EPSC_STRIDE 8
+
+void jkr_init_other(struct hfi2_devdata *dd);
+
+/* Specific IRQ sources */
+#define JKR_ASIC_ERR_INT		2
+#define JKR_MCTXT_CPORT_TO_PCIE_INT	4	/* part of JKR_IS_GENERAL_ERR_START/END */
+
+/* interrupt source starts */
+#define JKR_IS_GENERAL_ERR_START	   0
+#define JKR_IS_SDMAENG_ERR_START	  16
+#define JKR_IS_SENDCTXT_ERR_START	  32
+#define JKR_IS_SDMA_START		 272
+#define JKR_IS_SDMA_PROGRESS_START	 288
+#define JKR_IS_SDMA_IDLE_START		 304
+#define JKR_IS_VARIOUS_START		 320
+#define JKR_IS_PORT_START		 324
+#define JKR_IS_RCVAVAIL_START		 356
+#define JKR_IS_RCVURGENT_START		 596
+#define JKR_IS_SENDCREDIT_START		 836
+#define JKR_IS_PBC_START		1076
+#define JKR_IS_PIO_ERR_START		1316
+#define JKR_IS_SDMA_ERR_SI_START	1325
+#define JKR_IS_CSR_ERR_START		1334
+#define JKR_IS_RESERVED_START		1343
+#define JKR_IS_TABLE_NUM		1344
+
+/* derived interrupt source values */
+#define JKR_IS_GENERAL_ERR_END		(JKR_IS_SDMAENG_ERR_START - 1)
+#define JKR_IS_SDMAENG_ERR_END		(JKR_IS_SENDCTXT_ERR_START - 1)
+#define JKR_IS_SENDCTXT_ERR_END		(JKR_IS_SDMA_START - 1)
+#define JKR_IS_SDMA_END			(JKR_IS_SDMA_PROGRESS_START - 1)
+#define JKR_IS_SDMA_PROGRESS_END	(JKR_IS_SDMA_IDLE_START - 1)
+#define JKR_IS_SDMA_IDLE_END		(JKR_IS_VARIOUS_START - 1)
+#define JKR_IS_VARIOUS_END		(JKR_IS_PORT_START - 1)
+#define JKR_IS_PORT_END			(JKR_IS_RCVAVAIL_START - 1)
+#define JKR_IS_RCVAVAIL_END		(JKR_IS_RCVURGENT_START - 1)
+#define JKR_IS_RCVURGENT_END		(JKR_IS_SENDCREDIT_START - 1)
+#define JKR_IS_SENDCREDIT_END		(JKR_IS_PBC_START - 1)
+#define JKR_IS_PBC_END			(JKR_IS_PIO_ERR_START - 1)
+#define JKR_IS_PIO_ERR_END		(JKR_IS_SDMA_ERR_SI_START - 1)
+#define JKR_IS_SDMA_ERR_SI_END		(JKR_IS_CSR_ERR_START - 1)
+#define JKR_IS_CSR_ERR_END		(JKR_IS_RESERVED_START - 1)
+#define JKR_IS_RESERVED_END		(JKR_IS_TABLE_NUM - 1)
+
+/* last interrupt */
+#define JKR_IS_LAST_SOURCE JKR_IS_RESERVED_END
+
+extern const struct is_table jkr_is_table[];
+extern const struct gi_enable_entry jkr_gi_enable_table[];
+extern const struct flag_data jkr_egress_err_info_data;
+
+/* SendEgressErrInfo bits that correspond to a PortXmitDiscard counter */
+#define JKR_PORT_DISCARD_EGRESS_ERRS \
+	(JKR_SEND_EGRESS_ERR_INFO_TOO_LONG_PACKET_ERR9B_SMASK \
+	| JKR_SEND_EGRESS_ERR_INFO_VL_MAPPING_ERR9B_SMASK \
+	| JKR_SEND_EGRESS_ERR_INFO_VL_ERR9B_SMASK)
+
+int jkr_find_used_resources(struct hfi2_devdata *dd);
+void jkr_read_guid(struct hfi2_devdata *dd);
+int jkr_early_per_chip_init(struct hfi2_devdata *dd);
+int jkr_mid_per_chip_init(struct hfi2_devdata *dd);
+void jkr_init_tids(struct hfi2_devdata *dd);
+void jkr_put_tid(struct hfi2_ctxtdata *rcd, u32 index,
+		 u32 type, unsigned long pa, u16 order, bool flush);
+void jkr_rcv_array_wc_fill(struct hfi2_ctxtdata *rcd, u32 index, u32 type);
+void jkr_set_port_tid_count(struct hfi2_ctxtdata *rcd);
+void jkr_update_rcv_hdr_size(struct hfi2_pportdata *ppd, u16 ctxt, u32 size);
+bool jkr_check_synth_status(struct hfi2_devdata *dd);
+void jkr_update_synth_status(struct hfi2_devdata *dd);
+void jkr_set_pio_integrity(struct send_context *sc, enum spi_cmds cmd);
+void jkr_read_link_quality(struct hfi2_pportdata *ppd, u8 *link_quality);
+void jkr_set_rheq_addr(struct hfi2_devdata *dd, u16 ctxt, u64 dma_addr);
+void jkr_handle_link_bounce(struct work_struct *work);
+void jkr_enable_rcv_context(struct hfi2_pportdata *ppd, u16 ctxt,
+			    u64 *kctxt_ctrl, bool enable);
+
+#endif /* _CHIP_JKR_H */
diff --git a/drivers/infiniband/hw/hfi2/chip_registers.h b/drivers/infiniband/hw/hfi2/chip_registers.h
new file mode 100644
index 000000000000..63934ab6e70b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_registers.h
@@ -0,0 +1,1297 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ */
+
+#ifndef DEF_CHIP_REG
+#define DEF_CHIP_REG
+
+#define CORE		0x000000000000
+#define CCE			(CORE + 0x000000000000)
+#define ASIC		(CORE + 0x000000400000)
+#define MISC		(CORE + 0x000000500000)
+#define DC_TOP_CSRS		(CORE + 0x000000600000)
+#define CHIP_DEBUG		(CORE + 0x000000700000)
+#define RXE			(CORE + 0x000001000000)
+#define TXE			(CORE + 0x000001800000)
+#define DCC_CSRS		(DC_TOP_CSRS + 0x000000000000)
+#define DC_LCB_CSRS		(DC_TOP_CSRS + 0x000000001000)
+#define DC_8051_CSRS		(DC_TOP_CSRS + 0x000000002000)
+#define PCIE		0
+
+#define ASIC_NUM_SCRATCH 4
+#define WFR_CCE_ERR_INT_CNT 0
+#define CCE_MISC_INT_CNT 2
+#define CCE_NUM_32_BIT_COUNTERS 3
+#define CCE_NUM_32_BIT_INT_COUNTERS 6
+#define CCE_NUM_INT_CSRS 12
+#define CCE_NUM_INT_MAP_CSRS 96
+#define CCE_NUM_MSIX_PBAS 4
+#define CCE_NUM_MSIX_VECTORS 256
+#define CCE_NUM_SCRATCH 4
+#define CCE_PCIE_POSTED_CRDT_STALL_CNT 2
+#define CCE_PCIE_TRGT_STALL_CNT 0
+#define CCE_PIO_WR_STALL_CNT 1
+#define CCE_RCV_AVAIL_INT_CNT 3
+#define CCE_RCV_URGENT_INT_CNT 4
+#define CCE_SDMA_INT_CNT 1
+#define CCE_SEND_CREDIT_INT_CNT 5
+#define DCC_CFG_LED_CNTRL (DCC_CSRS + 0x000000000040)
+#define DCC_CFG_LED_CNTRL_LED_CNTRL_SMASK 0x10ull
+#define DCC_CFG_LED_CNTRL_LED_SW_BLINK_RATE_SHIFT 0
+#define DCC_CFG_LED_CNTRL_LED_SW_BLINK_RATE_SMASK 0xFull
+#define DCC_CFG_PORT_CONFIG (DCC_CSRS + 0x000000000008)
+#define DCC_CFG_PORT_CONFIG1 (DCC_CSRS + 0x000000000010)
+#define DCC_CFG_PORT_CONFIG1_DLID_MASK_MASK 0xFFFFull
+#define DCC_CFG_PORT_CONFIG1_DLID_MASK_SHIFT 16
+#define DCC_CFG_PORT_CONFIG1_DLID_MASK_SMASK 0xFFFF0000ull
+#define DCC_CFG_PORT_CONFIG1_TARGET_DLID_MASK 0xFFFFull
+#define DCC_CFG_PORT_CONFIG1_TARGET_DLID_SHIFT 0
+#define DCC_CFG_PORT_CONFIG1_TARGET_DLID_SMASK 0xFFFFull
+#define DCC_CFG_PORT_CONFIG_LINK_STATE_MASK 0x7ull
+#define DCC_CFG_PORT_CONFIG_LINK_STATE_SHIFT 48
+#define DCC_CFG_PORT_CONFIG_LINK_STATE_SMASK 0x7000000000000ull
+#define DCC_CFG_PORT_CONFIG_MTU_CAP_MASK 0x7ull
+#define DCC_CFG_PORT_CONFIG_MTU_CAP_SHIFT 32
+#define DCC_CFG_PORT_CONFIG_MTU_CAP_SMASK 0x700000000ull
+#define DCC_CFG_RESET (DCC_CSRS + 0x000000000000)
+#define DCC_CFG_RESET_RESET_LCB          BIT_ULL(0)
+#define DCC_CFG_RESET_RESET_TX_FPE       BIT_ULL(1)
+#define DCC_CFG_RESET_RESET_RX_FPE       BIT_ULL(2)
+#define DCC_CFG_RESET_RESET_8051         BIT_ULL(3)
+#define DCC_CFG_RESET_ENABLE_CCLK_BCC    BIT_ULL(4)
+#define DCC_CFG_SC_VL_TABLE_15_0 (DCC_CSRS + 0x000000000028)
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY0_SHIFT 0
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY10_SHIFT 40
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY11_SHIFT 44
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY12_SHIFT 48
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY13_SHIFT 52
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY14_SHIFT 56
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY15_SHIFT 60
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY1_SHIFT 4
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY2_SHIFT 8
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY3_SHIFT 12
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY4_SHIFT 16
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY5_SHIFT 20
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY6_SHIFT 24
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY7_SHIFT 28
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY8_SHIFT 32
+#define DCC_CFG_SC_VL_TABLE_15_0_ENTRY9_SHIFT 36
+#define DCC_CFG_SC_VL_TABLE_31_16 (DCC_CSRS + 0x000000000030)
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY16_SHIFT 0
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY17_SHIFT 4
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY18_SHIFT 8
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY19_SHIFT 12
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY20_SHIFT 16
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY21_SHIFT 20
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY22_SHIFT 24
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY23_SHIFT 28
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY24_SHIFT 32
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY25_SHIFT 36
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY26_SHIFT 40
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY27_SHIFT 44
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY28_SHIFT 48
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY29_SHIFT 52
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY30_SHIFT 56
+#define DCC_CFG_SC_VL_TABLE_31_16_ENTRY31_SHIFT 60
+#define DCC_ERR_DROPPED_PKT_CNT (DCC_CSRS + 0x000000000120)
+#define DCC_ERR_FLG (DCC_CSRS + 0x000000000050)
+#define DCC_ERR_FLG_BAD_CRDT_ACK_ERR_SMASK 0x4000ull
+#define DCC_ERR_FLG_BAD_CTRL_DIST_ERR_SMASK 0x200000ull
+#define DCC_ERR_FLG_BAD_CTRL_FLIT_ERR_SMASK 0x10000ull
+#define DCC_ERR_FLG_BAD_DLID_TARGET_ERR_SMASK 0x200ull
+#define DCC_ERR_FLG_BAD_HEAD_DIST_ERR_SMASK 0x800000ull
+#define DCC_ERR_FLG_BAD_L2_ERR_SMASK 0x2ull
+#define DCC_ERR_FLG_BAD_LVER_ERR_SMASK 0x400ull
+#define DCC_ERR_FLG_BAD_MID_TAIL_ERR_SMASK 0x8ull
+#define DCC_ERR_FLG_BAD_PKT_LENGTH_ERR_SMASK 0x4000000ull
+#define DCC_ERR_FLG_BAD_PREEMPTION_ERR_SMASK 0x10ull
+#define DCC_ERR_FLG_BAD_SC_ERR_SMASK 0x4ull
+#define DCC_ERR_FLG_BAD_TAIL_DIST_ERR_SMASK 0x400000ull
+#define DCC_ERR_FLG_BAD_VL_MARKER_ERR_SMASK 0x80ull
+#define DCC_ERR_FLG_CLR (DCC_CSRS + 0x000000000060)
+#define DCC_ERR_FLG_CSR_ACCESS_BLOCKED_HOST_SMASK 0x8000000000ull
+#define DCC_ERR_FLG_CSR_ACCESS_BLOCKED_UC_SMASK 0x10000000000ull
+#define DCC_ERR_FLG_CSR_INVAL_ADDR_SMASK 0x400000000000ull
+#define DCC_ERR_FLG_CSR_PARITY_ERR_SMASK 0x200000000000ull
+#define DCC_ERR_FLG_DLID_ZERO_ERR_SMASK 0x40000000ull
+#define DCC_ERR_FLG_EN (DCC_CSRS + 0x000000000058)
+#define DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_HOST_SMASK 0x8000000000ull
+#define DCC_ERR_FLG_EN_CSR_ACCESS_BLOCKED_UC_SMASK 0x10000000000ull
+#define DCC_ERR_FLG_EVENT_CNTR_PARITY_ERR_SMASK 0x20000ull
+#define DCC_ERR_FLG_EVENT_CNTR_ROLLOVER_ERR_SMASK 0x40000ull
+#define DCC_ERR_FLG_FMCONFIG_ERR_SMASK 0x40000000000000ull
+#define DCC_ERR_FLG_FPE_TX_FIFO_OVFLW_ERR_SMASK 0x2000000000ull
+#define DCC_ERR_FLG_FPE_TX_FIFO_UNFLW_ERR_SMASK 0x4000000000ull
+#define DCC_ERR_FLG_LATE_EBP_ERR_SMASK 0x1000000000ull
+#define DCC_ERR_FLG_LATE_LONG_ERR_SMASK 0x800000000ull
+#define DCC_ERR_FLG_LATE_SHORT_ERR_SMASK 0x400000000ull
+#define DCC_ERR_FLG_LENGTH_MTU_ERR_SMASK 0x80000000ull
+#define DCC_ERR_FLG_LINK_ERR_SMASK 0x80000ull
+#define DCC_ERR_FLG_MISC_CNTR_ROLLOVER_ERR_SMASK 0x100000ull
+#define DCC_ERR_FLG_NONVL15_STATE_ERR_SMASK 0x1000000ull
+#define DCC_ERR_FLG_PERM_NVL15_ERR_SMASK 0x10000000ull
+#define DCC_ERR_FLG_PREEMPTION_ERR_SMASK 0x20ull
+#define DCC_ERR_FLG_PREEMPTIONVL15_ERR_SMASK 0x40ull
+#define DCC_ERR_FLG_RCVPORT_ERR_SMASK 0x80000000000000ull
+#define DCC_ERR_FLG_RX_BYTE_SHFT_PARITY_ERR_SMASK 0x1000000000000ull
+#define DCC_ERR_FLG_RX_CTRL_PARITY_MBE_ERR_SMASK 0x100000000000ull
+#define DCC_ERR_FLG_RX_EARLY_DROP_ERR_SMASK 0x200000000ull
+#define DCC_ERR_FLG_SLID_ZERO_ERR_SMASK 0x20000000ull
+#define DCC_ERR_FLG_TX_BYTE_SHFT_PARITY_ERR_SMASK 0x800000000000ull
+#define DCC_ERR_FLG_TX_CTRL_PARITY_ERR_SMASK 0x20000000000ull
+#define DCC_ERR_FLG_TX_CTRL_PARITY_MBE_ERR_SMASK 0x40000000000ull
+#define DCC_ERR_FLG_TX_SC_PARITY_ERR_SMASK 0x80000000000ull
+#define DCC_ERR_FLG_UNCORRECTABLE_ERR_SMASK 0x2000ull
+#define DCC_ERR_FLG_UNSUP_PKT_TYPE_SMASK 0x8000ull
+#define DCC_ERR_FLG_UNSUP_VL_ERR_SMASK 0x8000000ull
+#define DCC_ERR_FLG_VL15_MULTI_ERR_SMASK 0x2000000ull
+#define DCC_ERR_FMCONFIG_ERR_CNT (DCC_CSRS + 0x000000000110)
+#define DCC_ERR_INFO_FMCONFIG (DCC_CSRS + 0x000000000090)
+#define DCC_ERR_INFO_PORTRCV (DCC_CSRS + 0x000000000078)
+#define DCC_ERR_INFO_PORTRCV_HDR0 (DCC_CSRS + 0x000000000080)
+#define DCC_ERR_INFO_PORTRCV_HDR1 (DCC_CSRS + 0x000000000088)
+#define DCC_ERR_INFO_UNCORRECTABLE (DCC_CSRS + 0x000000000098)
+#define DCC_ERR_PORTRCV_ERR_CNT (DCC_CSRS + 0x000000000108)
+#define DCC_ERR_RCVREMOTE_PHY_ERR_CNT (DCC_CSRS + 0x000000000118)
+#define DCC_ERR_UNCORRECTABLE_CNT (DCC_CSRS + 0x000000000100)
+#define DCC_PRF_PORT_MARK_FECN_CNT (DCC_CSRS + 0x000000000330)
+#define DCC_PRF_PORT_RCV_BECN_CNT (DCC_CSRS + 0x000000000290)
+#define DCC_PRF_PORT_RCV_BUBBLE_CNT (DCC_CSRS + 0x0000000002E0)
+#define DCC_PRF_PORT_RCV_CORRECTABLE_CNT (DCC_CSRS + 0x000000000140)
+#define DCC_PRF_PORT_RCV_DATA_CNT (DCC_CSRS + 0x000000000198)
+#define DCC_PRF_PORT_RCV_FECN_CNT (DCC_CSRS + 0x000000000240)
+#define DCC_PRF_PORT_RCV_MULTICAST_PKT_CNT (DCC_CSRS + 0x000000000130)
+#define DCC_PRF_PORT_RCV_PKTS_CNT (DCC_CSRS + 0x0000000001A8)
+#define DCC_PRF_PORT_VL_MARK_FECN_CNT (DCC_CSRS + 0x000000000338)
+#define DCC_PRF_PORT_VL_RCV_BECN_CNT (DCC_CSRS + 0x000000000298)
+#define DCC_PRF_PORT_VL_RCV_BUBBLE_CNT (DCC_CSRS + 0x0000000002E8)
+#define DCC_PRF_PORT_VL_RCV_DATA_CNT (DCC_CSRS + 0x0000000001B0)
+#define DCC_PRF_PORT_VL_RCV_FECN_CNT (DCC_CSRS + 0x000000000248)
+#define DCC_PRF_PORT_VL_RCV_PKTS_CNT (DCC_CSRS + 0x0000000001F8)
+#define DCC_PRF_PORT_XMIT_CORRECTABLE_CNT (DCC_CSRS + 0x000000000138)
+#define DCC_PRF_PORT_XMIT_DATA_CNT (DCC_CSRS + 0x000000000190)
+#define DCC_PRF_PORT_XMIT_MULTICAST_CNT (DCC_CSRS + 0x000000000128)
+#define DCC_PRF_PORT_XMIT_PKTS_CNT (DCC_CSRS + 0x0000000001A0)
+#define DCC_PRF_RX_FLOW_CRTL_CNT (DCC_CSRS + 0x000000000180)
+#define DCC_PRF_TX_FLOW_CRTL_CNT (DCC_CSRS + 0x000000000188)
+#define DC_DC8051_CFG_CSR_ACCESS_SEL (DC_8051_CSRS + 0x000000000110)
+#define DC_DC8051_CFG_CSR_ACCESS_SEL_DCC_SMASK 0x2ull
+#define DC_DC8051_CFG_CSR_ACCESS_SEL_LCB_SMASK 0x1ull
+#define DC_DC8051_CFG_EXT_DEV_0 (DC_8051_CSRS + 0x000000000118)
+#define DC_DC8051_CFG_EXT_DEV_0_COMPLETED_SMASK 0x1ull
+#define DC_DC8051_CFG_EXT_DEV_0_RETURN_CODE_SHIFT 8
+#define DC_DC8051_CFG_EXT_DEV_0_RSP_DATA_SHIFT 16
+#define DC_DC8051_CFG_EXT_DEV_1 (DC_8051_CSRS + 0x000000000120)
+#define DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_MASK 0xFFFFull
+#define DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SHIFT 16
+#define DC_DC8051_CFG_EXT_DEV_1_REQ_DATA_SMASK 0xFFFF0000ull
+#define DC_DC8051_CFG_EXT_DEV_1_REQ_NEW_SMASK 0x1ull
+#define DC_DC8051_CFG_EXT_DEV_1_REQ_TYPE_MASK 0xFFull
+#define DC_DC8051_CFG_EXT_DEV_1_REQ_TYPE_SHIFT 8
+#define DC_DC8051_CFG_HOST_CMD_0 (DC_8051_CSRS + 0x000000000028)
+#define DC_DC8051_CFG_HOST_CMD_0_REQ_DATA_MASK 0xFFFFFFFFFFFFull
+#define DC_DC8051_CFG_HOST_CMD_0_REQ_DATA_SHIFT 16
+#define DC_DC8051_CFG_HOST_CMD_0_REQ_NEW_SMASK 0x1ull
+#define DC_DC8051_CFG_HOST_CMD_0_REQ_TYPE_MASK 0xFFull
+#define DC_DC8051_CFG_HOST_CMD_0_REQ_TYPE_SHIFT 8
+#define DC_DC8051_CFG_HOST_CMD_1 (DC_8051_CSRS + 0x000000000030)
+#define DC_DC8051_CFG_HOST_CMD_1_COMPLETED_SMASK 0x1ull
+#define DC_DC8051_CFG_HOST_CMD_1_RETURN_CODE_MASK 0xFFull
+#define DC_DC8051_CFG_HOST_CMD_1_RETURN_CODE_SHIFT 8
+#define DC_DC8051_CFG_HOST_CMD_1_RSP_DATA_MASK 0xFFFFFFFFFFFFull
+#define DC_DC8051_CFG_HOST_CMD_1_RSP_DATA_SHIFT 16
+#define DC_DC8051_CFG_LOCAL_GUID (DC_8051_CSRS + 0x000000000038)
+#define DC_DC8051_CFG_MODE (DC_8051_CSRS + 0x000000000070)
+#define DC_DC8051_CFG_RAM_ACCESS_CTRL (DC_8051_CSRS + 0x000000000008)
+#define DC_DC8051_CFG_RAM_ACCESS_CTRL_ADDRESS_MASK 0x7FFFull
+#define DC_DC8051_CFG_RAM_ACCESS_CTRL_ADDRESS_SHIFT 0
+#define DC_DC8051_CFG_RAM_ACCESS_CTRL_WRITE_ENA_SMASK 0x1000000ull
+#define DC_DC8051_CFG_RAM_ACCESS_CTRL_READ_ENA_SMASK 0x10000ull
+#define DC_DC8051_CFG_RAM_ACCESS_SETUP (DC_8051_CSRS + 0x000000000000)
+#define DC_DC8051_CFG_RAM_ACCESS_SETUP_AUTO_INCR_ADDR_SMASK 0x100ull
+#define DC_DC8051_CFG_RAM_ACCESS_SETUP_RAM_SEL_SMASK 0x1ull
+#define DC_DC8051_CFG_RAM_ACCESS_STATUS (DC_8051_CSRS + 0x000000000018)
+#define DC_DC8051_CFG_RAM_ACCESS_STATUS_ACCESS_COMPLETED_SMASK 0x10000ull
+#define DC_DC8051_CFG_RAM_ACCESS_WR_DATA (DC_8051_CSRS + 0x000000000010)
+#define DC_DC8051_CFG_RAM_ACCESS_RD_DATA (DC_8051_CSRS + 0x000000000020)
+#define DC_DC8051_CFG_RST (DC_8051_CSRS + 0x000000000068)
+#define DC_DC8051_CFG_RST_CRAM_SMASK 0x2ull
+#define DC_DC8051_CFG_RST_DRAM_SMASK 0x4ull
+#define DC_DC8051_CFG_RST_IRAM_SMASK 0x8ull
+#define DC_DC8051_CFG_RST_M8051W_SMASK 0x1ull
+#define DC_DC8051_CFG_RST_SFR_SMASK 0x10ull
+#define DC_DC8051_DBG_ERR_INFO_SET_BY_8051 (DC_8051_CSRS + 0x0000000000D8)
+#define DC_DC8051_DBG_ERR_INFO_SET_BY_8051_ERROR_MASK 0xFFFFFFFFull
+#define DC_DC8051_DBG_ERR_INFO_SET_BY_8051_ERROR_SHIFT 16
+#define DC_DC8051_DBG_ERR_INFO_SET_BY_8051_HOST_MSG_MASK 0xFFFFull
+#define DC_DC8051_DBG_ERR_INFO_SET_BY_8051_HOST_MSG_SHIFT 0
+#define DC_DC8051_ERR_CLR (DC_8051_CSRS + 0x0000000000E8)
+#define DC_DC8051_ERR_EN (DC_8051_CSRS + 0x0000000000F0)
+#define DC_DC8051_ERR_EN_LOST_8051_HEART_BEAT_SMASK 0x2ull
+#define DC_DC8051_ERR_FLG (DC_8051_CSRS + 0x0000000000E0)
+#define DC_DC8051_ERR_FLG_CRAM_MBE_SMASK 0x4ull
+#define DC_DC8051_ERR_FLG_CRAM_SBE_SMASK 0x8ull
+#define DC_DC8051_ERR_FLG_DRAM_MBE_SMASK 0x10ull
+#define DC_DC8051_ERR_FLG_DRAM_SBE_SMASK 0x20ull
+#define DC_DC8051_ERR_FLG_INVALID_CSR_ADDR_SMASK 0x400ull
+#define DC_DC8051_ERR_FLG_IRAM_MBE_SMASK 0x40ull
+#define DC_DC8051_ERR_FLG_IRAM_SBE_SMASK 0x80ull
+#define DC_DC8051_ERR_FLG_LOST_8051_HEART_BEAT_SMASK 0x2ull
+#define DC_DC8051_ERR_FLG_SET_BY_8051_SMASK 0x1ull
+#define DC_DC8051_ERR_FLG_UNMATCHED_SECURE_MSG_ACROSS_BCC_LANES_SMASK 0x100ull
+#define DC_DC8051_STS_CUR_STATE (DC_8051_CSRS + 0x000000000060)
+#define DC_DC8051_STS_CUR_STATE_FIRMWARE_MASK 0xFFull
+#define DC_DC8051_STS_CUR_STATE_FIRMWARE_SHIFT 16
+#define DC_DC8051_STS_CUR_STATE_PORT_MASK 0xFFull
+#define DC_DC8051_STS_CUR_STATE_PORT_SHIFT 0
+#define DC_DC8051_STS_LOCAL_FM_SECURITY (DC_8051_CSRS + 0x000000000050)
+#define DC_DC8051_STS_LOCAL_FM_SECURITY_DISABLED_MASK 0x1ull
+#define DC_DC8051_STS_REMOTE_FM_SECURITY (DC_8051_CSRS + 0x000000000058)
+#define DC_DC8051_STS_REMOTE_GUID (DC_8051_CSRS + 0x000000000040)
+#define DC_DC8051_STS_REMOTE_NODE_TYPE (DC_8051_CSRS + 0x000000000048)
+#define DC_DC8051_STS_REMOTE_NODE_TYPE_VAL_MASK 0x3ull
+#define DC_DC8051_STS_REMOTE_PORT_NO (DC_8051_CSRS + 0x000000000130)
+#define DC_DC8051_STS_REMOTE_PORT_NO_VAL_SMASK 0xFFull
+#define DC_LCB_CFG_ALLOW_LINK_UP (DC_LCB_CSRS + 0x000000000128)
+#define DC_LCB_CFG_ALLOW_LINK_UP_VAL_SHIFT 0
+#define DC_LCB_CFG_CRC_MODE (DC_LCB_CSRS + 0x000000000058)
+#define DC_LCB_CFG_CRC_MODE_TX_VAL_SHIFT 0
+#define DC_LCB_CFG_IGNORE_LOST_RCLK (DC_LCB_CSRS + 0x000000000020)
+#define DC_LCB_CFG_IGNORE_LOST_RCLK_EN_SMASK 0x1ull
+#define DC_LCB_CFG_LANE_WIDTH (DC_LCB_CSRS + 0x000000000100)
+#define DC_LCB_CFG_LINK_KILL_EN (DC_LCB_CSRS + 0x000000000120)
+#define DC_LCB_CFG_LINK_KILL_EN_FLIT_INPUT_BUF_MBE_SMASK 0x100000ull
+#define DC_LCB_CFG_LINK_KILL_EN_REPLAY_BUF_MBE_SMASK 0x400000ull
+#define DC_LCB_CFG_LN_DCLK (DC_LCB_CSRS + 0x000000000060)
+#define DC_LCB_CFG_LOOPBACK (DC_LCB_CSRS + 0x0000000000F8)
+#define DC_LCB_CFG_LOOPBACK_VAL_SHIFT 0
+#define DC_LCB_CFG_RUN (DC_LCB_CSRS + 0x000000000000)
+#define DC_LCB_CFG_RUN_EN_SHIFT 0
+#define DC_LCB_CFG_RX_FIFOS_RADR (DC_LCB_CSRS + 0x000000000018)
+#define DC_LCB_CFG_RX_FIFOS_RADR_DO_NOT_JUMP_VAL_SHIFT 8
+#define DC_LCB_CFG_RX_FIFOS_RADR_OK_TO_JUMP_VAL_SHIFT 4
+#define DC_LCB_CFG_RX_FIFOS_RADR_RST_VAL_SHIFT 0
+#define DC_LCB_CFG_TX_FIFOS_RADR (DC_LCB_CSRS + 0x000000000010)
+#define DC_LCB_CFG_TX_FIFOS_RADR_RST_VAL_SHIFT 0
+#define DC_LCB_CFG_TX_FIFOS_RESET (DC_LCB_CSRS + 0x000000000008)
+#define DC_LCB_CFG_TX_FIFOS_RESET_VAL_SHIFT 0
+#define DC_LCB_CFG_REINIT_AS_SLAVE (DC_LCB_CSRS + 0x000000000030)
+#define DC_LCB_CFG_CNT_FOR_SKIP_STALL (DC_LCB_CSRS + 0x000000000040)
+#define DC_LCB_CFG_CLK_CNTR (DC_LCB_CSRS + 0x000000000110)
+#define DC_LCB_ERR_CLR (DC_LCB_CSRS + 0x000000000308)
+#define DC_LCB_ERR_EN (DC_LCB_CSRS + 0x000000000310)
+#define DC_LCB_ERR_FLG (DC_LCB_CSRS + 0x000000000300)
+#define DC_LCB_ERR_FLG_REDUNDANT_FLIT_PARITY_ERR_SMASK 0x20000000ull
+#define DC_LCB_ERR_FLG_NEG_EDGE_LINK_TRANSFER_ACTIVE_SMASK 0x10000000ull
+#define DC_LCB_ERR_FLG_HOLD_REINIT_SMASK 0x8000000ull
+#define DC_LCB_ERR_FLG_RST_FOR_INCOMPLT_RND_TRIP_SMASK 0x4000000ull
+#define DC_LCB_ERR_FLG_RST_FOR_LINK_TIMEOUT_SMASK 0x2000000ull
+#define DC_LCB_ERR_FLG_CREDIT_RETURN_FLIT_MBE_SMASK 0x1000000ull
+#define DC_LCB_ERR_FLG_REPLAY_BUF_SBE_SMASK 0x800000ull
+#define DC_LCB_ERR_FLG_REPLAY_BUF_MBE_SMASK 0x400000ull
+#define DC_LCB_ERR_FLG_FLIT_INPUT_BUF_SBE_SMASK 0x200000ull
+#define DC_LCB_ERR_FLG_FLIT_INPUT_BUF_MBE_SMASK 0x100000ull
+#define DC_LCB_ERR_FLG_VL_ACK_INPUT_WRONG_CRC_MODE_SMASK 0x80000ull
+#define DC_LCB_ERR_FLG_VL_ACK_INPUT_PARITY_ERR_SMASK 0x40000ull
+#define DC_LCB_ERR_FLG_VL_ACK_INPUT_BUF_OFLW_SMASK 0x20000ull
+#define DC_LCB_ERR_FLG_FLIT_INPUT_BUF_OFLW_SMASK 0x10000ull
+#define DC_LCB_ERR_FLG_ILLEGAL_FLIT_ENCODING_SMASK 0x8000ull
+#define DC_LCB_ERR_FLG_ILLEGAL_NULL_LTP_SMASK 0x4000ull
+#define DC_LCB_ERR_FLG_UNEXPECTED_ROUND_TRIP_MARKER_SMASK 0x2000ull
+#define DC_LCB_ERR_FLG_UNEXPECTED_REPLAY_MARKER_SMASK 0x1000ull
+#define DC_LCB_ERR_FLG_RCLK_STOPPED_SMASK 0x800ull
+#define DC_LCB_ERR_FLG_CRC_ERR_CNT_HIT_LIMIT_SMASK 0x400ull
+#define DC_LCB_ERR_FLG_REINIT_FOR_LN_DEGRADE_SMASK 0x200ull
+#define DC_LCB_ERR_FLG_REINIT_FROM_PEER_SMASK 0x100ull
+#define DC_LCB_ERR_FLG_SEQ_CRC_ERR_SMASK 0x80ull
+#define DC_LCB_ERR_FLG_RX_LESS_THAN_FOUR_LNS_SMASK 0x40ull
+#define DC_LCB_ERR_FLG_TX_LESS_THAN_FOUR_LNS_SMASK 0x20ull
+#define DC_LCB_ERR_FLG_LOST_REINIT_STALL_OR_TOS_SMASK 0x10ull
+#define DC_LCB_ERR_FLG_ALL_LNS_FAILED_REINIT_TEST_SMASK 0x8ull
+#define DC_LCB_ERR_FLG_RST_FOR_FAILED_DESKEW_SMASK 0x4ull
+#define DC_LCB_ERR_FLG_INVALID_CSR_ADDR_SMASK 0x2ull
+#define DC_LCB_ERR_FLG_CSR_PARITY_ERR_SMASK 0x1ull
+#define DC_LCB_ERR_INFO_CRC_ERR_LN0 (DC_LCB_CSRS + 0x000000000328)
+#define DC_LCB_ERR_INFO_CRC_ERR_LN1 (DC_LCB_CSRS + 0x000000000330)
+#define DC_LCB_ERR_INFO_CRC_ERR_LN2 (DC_LCB_CSRS + 0x000000000338)
+#define DC_LCB_ERR_INFO_CRC_ERR_LN3 (DC_LCB_CSRS + 0x000000000340)
+#define DC_LCB_ERR_INFO_CRC_ERR_MULTI_LN (DC_LCB_CSRS + 0x000000000348)
+#define DC_LCB_ERR_INFO_ESCAPE_0_ONLY_CNT (DC_LCB_CSRS + 0x000000000368)
+#define DC_LCB_ERR_INFO_ESCAPE_0_PLUS1_CNT (DC_LCB_CSRS + 0x000000000370)
+#define DC_LCB_ERR_INFO_ESCAPE_0_PLUS2_CNT (DC_LCB_CSRS + 0x000000000378)
+#define DC_LCB_ERR_INFO_MISC_FLG_CNT (DC_LCB_CSRS + 0x000000000390)
+#define DC_LCB_ERR_INFO_REINIT_FROM_PEER_CNT (DC_LCB_CSRS + 0x000000000380)
+#define DC_LCB_ERR_INFO_RX_REPLAY_CNT (DC_LCB_CSRS + 0x000000000358)
+#define DC_LCB_ERR_INFO_SBE_CNT (DC_LCB_CSRS + 0x000000000388)
+#define DC_LCB_ERR_INFO_SEQ_CRC_CNT (DC_LCB_CSRS + 0x000000000360)
+#define DC_LCB_ERR_INFO_TOTAL_CRC_ERR (DC_LCB_CSRS + 0x000000000320)
+#define DC_LCB_ERR_INFO_TX_REPLAY_CNT (DC_LCB_CSRS + 0x000000000350)
+#define DC_LCB_PG_DBG_FLIT_CRDTS_CNT (DC_LCB_CSRS + 0x000000000580)
+#define DC_LCB_PG_STS_PAUSE_COMPLETE_CNT (DC_LCB_CSRS + 0x0000000005F8)
+#define DC_LCB_PG_STS_TX_MBE_CNT (DC_LCB_CSRS + 0x000000000608)
+#define DC_LCB_PG_STS_TX_SBE_CNT (DC_LCB_CSRS + 0x000000000600)
+#define DC_LCB_PRF_ACCEPTED_LTP_CNT (DC_LCB_CSRS + 0x000000000408)
+#define DC_LCB_PRF_CLK_CNTR (DC_LCB_CSRS + 0x000000000420)
+#define DC_LCB_PRF_GOOD_LTP_CNT (DC_LCB_CSRS + 0x000000000400)
+#define DC_LCB_PRF_RX_FLIT_CNT (DC_LCB_CSRS + 0x000000000410)
+#define DC_LCB_PRF_TX_FLIT_CNT (DC_LCB_CSRS + 0x000000000418)
+#define DC_LCB_STS_LINK_TRANSFER_ACTIVE (DC_LCB_CSRS + 0x000000000468)
+#define DC_LCB_STS_ROUND_TRIP_LTP_CNT (DC_LCB_CSRS + 0x0000000004B0)
+#define RCV_LENGTH_ERR_CNT 0
+#define RCV_SHORT_ERR_CNT 2
+#define RCV_ICRC_ERR_CNT 6
+#define RCV_EBP_CNT 9
+#define RCV_BUF_OVFL_CNT 10
+#define RCV_PKEY_MISMATCH_CNT 11
+#define RCV_DROPPED_PKT_CNT 16
+#define RCV_DROPPED_BYPASS_PKT_CNT 17
+#define RCV_CONTEXT_EGR_STALL 22
+#define RCV_DATA_PKT_CNT 0
+#define RCV_DWORD_CNT 1
+#define RCV_TID_FLOW_GEN_MISMATCH_CNT 20
+#define RCV_TID_FLOW_SEQ_MISMATCH_CNT 23
+#define RCV_TID_FULL_ERR_CNT 18
+#define RCV_TID_VALID_ERR_CNT 19
+#define RXE_NUM_32_BIT_COUNTERS 24
+#define RXE_NUM_64_BIT_COUNTERS 2
+#define RXE_NUM_RSM_INSTANCES 4
+#define RXE_NUM_TID_FLOWS 32
+#define SEND_DATA_PKT_CNT 0
+#define SEND_DATA_PKT_VL0_CNT 12
+#define SEND_DATA_VL0_CNT 3
+#define SEND_DROPPED_PKT_CNT 5
+#define SEND_DWORD_CNT 1
+#define SEND_FLOW_STALL_CNT 4
+#define SEND_HEADERS_ERR_CNT 6
+#define SEND_LEN_ERR_CNT 1
+#define SEND_MAX_MIN_LEN_ERR_CNT 2
+#define SEND_UNDERRUN_CNT 3
+#define SEND_UNSUP_VL_ERR_CNT 0
+#define SEND_WAIT_CNT 2
+#define SEND_WAIT_VL0_CNT 21
+#define TXE_PIO_SEND_OFFSET 0x0800000
+#define ASIC_CFG_DRV_STR (ASIC + 0x000000000048)
+#define ASIC_CFG_MUTEX (ASIC + 0x000000000040)
+#define ASIC_CFG_SBUS_EXECUTE (ASIC + 0x000000000008)
+#define ASIC_CFG_SBUS_EXECUTE_EXECUTE_SMASK 0x1ull
+#define ASIC_CFG_SBUS_EXECUTE_FAST_MODE_SMASK 0x2ull
+#define ASIC_CFG_SBUS_REQUEST (ASIC + 0x000000000000)
+#define ASIC_CFG_SBUS_REQUEST_COMMAND_SHIFT 16
+#define ASIC_CFG_SBUS_REQUEST_DATA_ADDR_SHIFT 8
+#define ASIC_CFG_SBUS_REQUEST_DATA_IN_SHIFT 32
+#define ASIC_CFG_SBUS_REQUEST_RECEIVER_ADDR_SHIFT 0
+#define ASIC_CFG_SCRATCH (ASIC + 0x000000000020)
+#define ASIC_CFG_SCRATCH_1 (ASIC_CFG_SCRATCH + 0x08)
+#define ASIC_CFG_SCRATCH_2 (ASIC_CFG_SCRATCH + 0x10)
+#define ASIC_CFG_SCRATCH_3 (ASIC_CFG_SCRATCH + 0x18)
+#define ASIC_CFG_THERM_POLL_EN (ASIC + 0x000000000050)
+#define ASIC_EEP_ADDR_CMD (ASIC + 0x000000000308)
+#define ASIC_EEP_ADDR_CMD_EP_ADDR_MASK 0xFFFFFFull
+#define ASIC_EEP_CTL_STAT (ASIC + 0x000000000300)
+#define ASIC_EEP_CTL_STAT_EP_RESET_SMASK 0x4ull
+#define ASIC_EEP_CTL_STAT_RATE_SPI_SHIFT 8
+#define ASIC_EEP_CTL_STAT_RESETCSR 0x0000000083818000ull
+#define ASIC_EEP_DATA (ASIC + 0x000000000310)
+#define ASIC_GPIO_CLEAR (ASIC + 0x000000000230)
+#define ASIC_GPIO_FORCE (ASIC + 0x000000000238)
+#define ASIC_GPIO_IN (ASIC + 0x000000000200)
+#define ASIC_GPIO_INVERT (ASIC + 0x000000000210)
+#define ASIC_GPIO_MASK (ASIC + 0x000000000220)
+#define ASIC_GPIO_OE (ASIC + 0x000000000208)
+#define ASIC_GPIO_OUT (ASIC + 0x000000000218)
+#define ASIC_PCIE_SD_HOST_CMD (ASIC + 0x000000000100)
+#define ASIC_PCIE_SD_HOST_CMD_INTRPT_CMD_SHIFT 0
+#define ASIC_PCIE_SD_HOST_CMD_SBR_MODE_SMASK 0x400ull
+#define ASIC_PCIE_SD_HOST_CMD_SBUS_RCVR_ADDR_SHIFT 2
+#define ASIC_PCIE_SD_HOST_CMD_TIMER_MASK 0xFFFFFull
+#define ASIC_PCIE_SD_HOST_CMD_TIMER_SHIFT 12
+#define ASIC_PCIE_SD_HOST_STATUS (ASIC + 0x000000000108)
+#define ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_ERR_MASK 0x7ull
+#define ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_ERR_SHIFT 2
+#define ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_STS_MASK 0x3ull
+#define ASIC_PCIE_SD_HOST_STATUS_FW_DNLD_STS_SHIFT 0
+#define ASIC_PCIE_SD_INTRPT_DATA_CODE (ASIC + 0x000000000110)
+#define ASIC_PCIE_SD_INTRPT_ENABLE (ASIC + 0x000000000118)
+#define ASIC_PCIE_SD_INTRPT_LIST (ASIC + 0x000000000180)
+#define ASIC_PCIE_SD_INTRPT_LIST_INTRPT_CODE_SHIFT 16
+#define ASIC_PCIE_SD_INTRPT_LIST_INTRPT_DATA_SHIFT 0
+#define ASIC_PCIE_SD_INTRPT_STATUS (ASIC + 0x000000000128)
+#define ASIC_QSFP1_CLEAR (ASIC + 0x000000000270)
+#define ASIC_QSFP1_FORCE (ASIC + 0x000000000278)
+#define ASIC_QSFP1_IN (ASIC + 0x000000000240)
+#define ASIC_QSFP1_INVERT (ASIC + 0x000000000250)
+#define ASIC_QSFP1_MASK (ASIC + 0x000000000260)
+#define ASIC_QSFP1_OE (ASIC + 0x000000000248)
+#define ASIC_QSFP1_OUT (ASIC + 0x000000000258)
+#define ASIC_QSFP1_STATUS (ASIC + 0x000000000268)
+#define ASIC_QSFP2_CLEAR (ASIC + 0x0000000002B0)
+#define ASIC_QSFP2_FORCE (ASIC + 0x0000000002B8)
+#define ASIC_QSFP2_IN (ASIC + 0x000000000280)
+#define ASIC_QSFP2_INVERT (ASIC + 0x000000000290)
+#define ASIC_QSFP2_MASK (ASIC + 0x0000000002A0)
+#define ASIC_QSFP2_OE (ASIC + 0x000000000288)
+#define ASIC_QSFP2_OUT (ASIC + 0x000000000298)
+#define ASIC_QSFP2_STATUS (ASIC + 0x0000000002A8)
+#define ASIC_STS_SBUS_COUNTERS (ASIC + 0x000000000018)
+#define ASIC_STS_SBUS_COUNTERS_EXECUTE_CNT_MASK 0xFFFFull
+#define ASIC_STS_SBUS_COUNTERS_EXECUTE_CNT_SHIFT 0
+#define ASIC_STS_SBUS_COUNTERS_RCV_DATA_VALID_CNT_MASK 0xFFFFull
+#define ASIC_STS_SBUS_COUNTERS_RCV_DATA_VALID_CNT_SHIFT 16
+#define ASIC_STS_SBUS_RESULT (ASIC + 0x000000000010)
+#define ASIC_STS_SBUS_RESULT_DONE_SMASK 0x1ull
+#define ASIC_STS_SBUS_RESULT_RCV_DATA_VALID_SMASK 0x2ull
+#define ASIC_STS_SBUS_RESULT_RESULT_CODE_SHIFT 2
+#define ASIC_STS_SBUS_RESULT_RESULT_CODE_MASK 0x7ull
+#define ASIC_STS_SBUS_RESULT_DATA_OUT_SHIFT 32
+#define ASIC_STS_SBUS_RESULT_DATA_OUT_MASK 0xFFFFFFFFull
+#define ASIC_STS_THERM (ASIC + 0x000000000058)
+#define ASIC_STS_THERM_CRIT_TEMP_MASK 0x7FFull
+#define ASIC_STS_THERM_CRIT_TEMP_SHIFT 18
+#define ASIC_STS_THERM_CURR_TEMP_MASK 0x7FFull
+#define ASIC_STS_THERM_CURR_TEMP_SHIFT 2
+#define ASIC_STS_THERM_HI_TEMP_MASK 0x7FFull
+#define ASIC_STS_THERM_HI_TEMP_SHIFT 50
+#define ASIC_STS_THERM_LO_TEMP_MASK 0x7FFull
+#define ASIC_STS_THERM_LO_TEMP_SHIFT 34
+#define ASIC_STS_THERM_LOW_SHIFT 13
+#define CCE_COUNTER_ARRAY32 (CCE + 0x000000000060)
+#define CCE_CTRL (CCE + 0x000000000010)
+#define CCE_CTRL_RXE_RESUME_SMASK 0x800ull
+#define CCE_CTRL_SPC_FREEZE_SMASK 0x100ull
+#define CCE_CTRL_SPC_UNFREEZE_SMASK 0x200ull
+#define CCE_CTRL_TXE_RESUME_SMASK 0x2000ull
+#define CCE_DC_CTRL (CCE + 0x0000000000B8)
+#define CCE_DC_CTRL_DC_RESET_SMASK 0x1ull
+#define CCE_DC_CTRL_RESETCSR 0x0000000000000001ull
+#define CCE_ERR_CLEAR (CCE + 0x000000000050)
+#define CCE_ERR_MASK (CCE + 0x000000000048)
+#define CCE_ERR_STATUS (CCE + 0x000000000040)
+#define CCE_ERR_STATUS_CCE_CLI0_ASYNC_FIFO_PARITY_ERR_SMASK 0x40ull
+#define CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_DBG_PARITY_ERROR_SMASK 0x1000ull
+#define CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_PIO_CRDT_PARITY_ERR_SMASK \
+		0x200ull
+#define CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_RXDMA_PARITY_ERROR_SMASK \
+		0x800ull
+#define CCE_ERR_STATUS_CCE_CLI1_ASYNC_FIFO_SDMA_HD_PARITY_ERR_SMASK \
+		0x400ull
+#define CCE_ERR_STATUS_CCE_CLI2_ASYNC_FIFO_PARITY_ERR_SMASK 0x100ull
+#define CCE_ERR_STATUS_CCE_CSR_CFG_BUS_PARITY_ERR_SMASK 0x80ull
+#define CCE_ERR_STATUS_CCE_CSR_PARITY_ERR_SMASK 0x1ull
+#define CCE_ERR_STATUS_CCE_CSR_READ_BAD_ADDR_ERR_SMASK 0x2ull
+#define CCE_ERR_STATUS_CCE_CSR_WRITE_BAD_ADDR_ERR_SMASK 0x4ull
+#define CCE_ERR_STATUS_CCE_INT_MAP_COR_ERR_SMASK 0x4000000000ull
+#define CCE_ERR_STATUS_CCE_INT_MAP_UNC_ERR_SMASK 0x8000000000ull
+#define CCE_ERR_STATUS_CCE_MSIX_CSR_PARITY_ERR_SMASK 0x10000000000ull
+#define CCE_ERR_STATUS_CCE_MSIX_TABLE_COR_ERR_SMASK 0x1000000000ull
+#define CCE_ERR_STATUS_CCE_MSIX_TABLE_UNC_ERR_SMASK 0x2000000000ull
+#define CCE_ERR_STATUS_CCE_RCPL_ASYNC_FIFO_PARITY_ERR_SMASK 0x400000000ull
+#define CCE_ERR_STATUS_CCE_RSPD_DATA_PARITY_ERR_SMASK 0x20ull
+#define CCE_ERR_STATUS_CCE_RXDMA_CONV_FIFO_PARITY_ERR_SMASK 0x800000000ull
+#define CCE_ERR_STATUS_CCE_SEG_READ_BAD_ADDR_ERR_SMASK 0x100000000ull
+#define CCE_ERR_STATUS_CCE_SEG_WRITE_BAD_ADDR_ERR_SMASK 0x200000000ull
+#define CCE_ERR_STATUS_CCE_TRGT_ACCESS_ERR_SMASK 0x10ull
+#define CCE_ERR_STATUS_CCE_TRGT_ASYNC_FIFO_PARITY_ERR_SMASK 0x8ull
+#define CCE_ERR_STATUS_CCE_TRGT_CPL_TIMEOUT_ERR_SMASK 0x40000000ull
+#define CCE_ERR_STATUS_LA_TRIGGERED_SMASK 0x80000000ull
+#define CCE_ERR_STATUS_PCIC_CPL_DAT_QCOR_ERR_SMASK 0x40000ull
+#define CCE_ERR_STATUS_PCIC_CPL_DAT_QUNC_ERR_SMASK 0x4000000ull
+#define CCE_ERR_STATUS_PCIC_CPL_HD_QCOR_ERR_SMASK 0x20000ull
+#define CCE_ERR_STATUS_PCIC_CPL_HD_QUNC_ERR_SMASK 0x2000000ull
+#define CCE_ERR_STATUS_PCIC_NPOST_DAT_QPARITY_ERR_SMASK 0x100000ull
+#define CCE_ERR_STATUS_PCIC_NPOST_HQ_PARITY_ERR_SMASK 0x80000ull
+#define CCE_ERR_STATUS_PCIC_POST_DAT_QCOR_ERR_SMASK 0x10000ull
+#define CCE_ERR_STATUS_PCIC_POST_DAT_QUNC_ERR_SMASK 0x1000000ull
+#define CCE_ERR_STATUS_PCIC_POST_HD_QCOR_ERR_SMASK 0x8000ull
+#define CCE_ERR_STATUS_PCIC_POST_HD_QUNC_ERR_SMASK 0x800000ull
+#define CCE_ERR_STATUS_PCIC_RECEIVE_PARITY_ERR_SMASK 0x20000000ull
+#define CCE_ERR_STATUS_PCIC_RETRY_MEM_COR_ERR_SMASK 0x2000ull
+#define CCE_ERR_STATUS_PCIC_RETRY_MEM_UNC_ERR_SMASK 0x200000ull
+#define CCE_ERR_STATUS_PCIC_RETRY_SOT_MEM_COR_ERR_SMASK 0x4000ull
+#define CCE_ERR_STATUS_PCIC_RETRY_SOT_MEM_UNC_ERR_SMASK 0x400000ull
+#define CCE_ERR_STATUS_PCIC_TRANSMIT_BACK_PARITY_ERR_SMASK 0x10000000ull
+#define CCE_ERR_STATUS_PCIC_TRANSMIT_FRONT_PARITY_ERR_SMASK 0x8000000ull
+#define CCE_INT_CLEAR (CCE + 0x000000110A00)
+#define CCE_INT_COUNTER_ARRAY32 (CCE + 0x000000110D00)
+#define CCE_INT_FORCE (CCE + 0x000000110B00)
+#define CCE_INT_MAP (CCE + 0x000000110500)
+#define CCE_INT_MASK (CCE + 0x000000110900)
+#define CCE_INT_STATUS (CCE + 0x000000110800)
+#define CCE_MSIX_INT_GRANTED (CCE + 0x000000110200)
+#define CCE_MSIX_TABLE_LOWER (CCE + 0x000000100000)
+#define CCE_MSIX_TABLE_UPPER (CCE + 0x000000100008)
+#define CCE_MSIX_TABLE_UPPER_RESETCSR 0x0000000100000000ull
+#define CCE_MSIX_VEC_CLR_WITHOUT_INT (CCE + 0x000000110400)
+#define CCE_PCIE_CTRL (CCE + 0x0000000000C0)
+#define CCE_PCIE_CTRL_PCIE_LANE_BUNDLE_MASK 0x3ull
+#define CCE_PCIE_CTRL_PCIE_LANE_BUNDLE_SHIFT 0
+#define CCE_PCIE_CTRL_PCIE_LANE_DELAY_MASK 0xFull
+#define CCE_PCIE_CTRL_PCIE_LANE_DELAY_SHIFT 2
+#define CCE_PCIE_CTRL_XMT_MARGIN_OVERWRITE_ENABLE_SHIFT 8
+#define CCE_PCIE_CTRL_XMT_MARGIN_SHIFT 9
+#define CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_OVERWRITE_ENABLE_MASK 0x1ull
+#define CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_OVERWRITE_ENABLE_SHIFT 12
+#define CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_MASK 0x7ull
+#define CCE_PCIE_CTRL_XMT_MARGIN_GEN1_GEN2_SHIFT 13
+#define CCE_REVISION (CCE + 0x000000000000)
+#define CCE_REVISION2 (CCE + 0x000000000008)
+#define CCE_REVISION2_HFI_ID_MASK 0x1ull
+#define CCE_REVISION2_HFI_ID_SHIFT 0
+#define CCE_REVISION2_IMPL_CODE_SHIFT 8
+#define CCE_REVISION2_IMPL_REVISION_SHIFT 16
+#define CCE_REVISION_BOARD_ID_LOWER_NIBBLE_MASK 0xFull
+#define CCE_REVISION_BOARD_ID_LOWER_NIBBLE_SHIFT 32
+#define CCE_REVISION_CHIP_REV_MAJOR_MASK 0xFFull
+#define CCE_REVISION_CHIP_REV_MAJOR_SHIFT 8
+#define CCE_REVISION_CHIP_REV_MINOR_MASK 0xFFull
+#define CCE_REVISION_CHIP_REV_MINOR_SHIFT 0
+#define CCE_REVISION_SW_MASK 0xFFull
+#define CCE_REVISION_SW_SHIFT 24
+#define CCE_SCRATCH (CCE + 0x000000000020)
+#define CCE_STATUS (CCE + 0x000000000018)
+#define CCE_STATUS_RXE_FROZE_SMASK 0x2ull
+#define CCE_STATUS_RXE_PAUSED_SMASK 0x20ull
+#define CCE_STATUS_SDMA_FROZE_SMASK 0x1ull
+#define CCE_STATUS_SDMA_PAUSED_SMASK 0x10ull
+#define CCE_STATUS_TXE_FROZE_SMASK 0x4ull
+#define CCE_STATUS_TXE_PAUSED_SMASK 0x40ull
+#define CCE_STATUS_TXE_PIO_FROZE_SMASK 0x8ull
+#define CCE_STATUS_TXE_PIO_PAUSED_SMASK 0x80ull
+#define MISC_CFG_FW_CTRL (MISC + 0x000000001000)
+#define MISC_CFG_FW_CTRL_FW_8051_LOADED_SMASK 0x2ull
+#define MISC_CFG_FW_CTRL_RSA_STATUS_SHIFT 2
+#define MISC_CFG_FW_CTRL_RSA_STATUS_SMASK 0xCull
+#define MISC_CFG_RSA_CMD (MISC + 0x000000000A08)
+#define MISC_CFG_RSA_MODULUS (MISC + 0x000000000400)
+#define MISC_CFG_RSA_MU (MISC + 0x000000000A10)
+#define MISC_CFG_RSA_R2 (MISC + 0x000000000000)
+#define MISC_CFG_RSA_SIGNATURE (MISC + 0x000000000200)
+#define MISC_CFG_SHA_PRELOAD (MISC + 0x000000000A00)
+#define MISC_ERR_CLEAR (MISC + 0x000000002010)
+#define MISC_ERR_MASK (MISC + 0x000000002008)
+#define MISC_ERR_STATUS (MISC + 0x000000002000)
+#define MISC_ERR_STATUS_MISC_PLL_LOCK_FAIL_ERR_SMASK 0x1000ull
+#define MISC_ERR_STATUS_MISC_MBIST_FAIL_ERR_SMASK 0x800ull
+#define MISC_ERR_STATUS_MISC_INVALID_EEP_CMD_ERR_SMASK 0x400ull
+#define MISC_ERR_STATUS_MISC_EFUSE_DONE_PARITY_ERR_SMASK 0x200ull
+#define MISC_ERR_STATUS_MISC_EFUSE_WRITE_ERR_SMASK 0x100ull
+#define MISC_ERR_STATUS_MISC_EFUSE_READ_BAD_ADDR_ERR_SMASK 0x80ull
+#define MISC_ERR_STATUS_MISC_EFUSE_CSR_PARITY_ERR_SMASK 0x40ull
+#define MISC_ERR_STATUS_MISC_FW_AUTH_FAILED_ERR_SMASK 0x20ull
+#define MISC_ERR_STATUS_MISC_KEY_MISMATCH_ERR_SMASK 0x10ull
+#define MISC_ERR_STATUS_MISC_SBUS_WRITE_FAILED_ERR_SMASK 0x8ull
+#define MISC_ERR_STATUS_MISC_CSR_WRITE_BAD_ADDR_ERR_SMASK 0x4ull
+#define MISC_ERR_STATUS_MISC_CSR_READ_BAD_ADDR_ERR_SMASK 0x2ull
+#define MISC_ERR_STATUS_MISC_CSR_PARITY_ERR_SMASK 0x1ull
+#define PCI_CFG_MSIX0 (PCIE + 0x0000000000B0)
+#define PCI_CFG_REG1 (PCIE + 0x000000000004)
+#define PCI_CFG_REG11 (PCIE + 0x00000000002C)
+#define PCIE_CFG_SPCIE1 (PCIE + 0x00000000014C)
+#define PCIE_CFG_SPCIE2 (PCIE + 0x000000000150)
+#define PCIE_CFG_TPH2 (PCIE + 0x000000000180)
+#define RCV_ARRAY (RXE + 0x000000200000)
+#define RCV_ARRAY_CNT (RXE + 0x000000000018)
+#define RCV_ARRAY_RT_ADDR_MASK 0xFFFFFFFFFull
+#define RCV_ARRAY_RT_ADDR_SHIFT 0
+#define RCV_ARRAY_RT_BUF_SIZE_SHIFT 36
+#define RCV_ARRAY_RT_WRITE_ENABLE_SMASK 0x8000000000000000ull
+#define RCV_AVAIL_TIME_OUT (RXE + 0x000000100050)
+#define RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_MASK 0xFFull
+#define RCV_AVAIL_TIME_OUT_TIME_OUT_RELOAD_SHIFT 0
+#define RCV_BTH_QP (RXE + 0x000000000028)
+#define RCV_BTH_QP_KDETH_QP_MASK 0xFFull
+#define RCV_BTH_QP_KDETH_QP_SHIFT 16
+#define RCV_BYPASS (RXE + 0x000000000038)
+#define RCV_BYPASS_HDR_SIZE_SHIFT 16
+#define RCV_BYPASS_HDR_SIZE_MASK 0x1Full
+#define RCV_BYPASS_HDR_SIZE_SMASK 0x1F0000ull
+#define RCV_BYPASS_BYPASS_CONTEXT_SHIFT 0
+#define RCV_BYPASS_BYPASS_CONTEXT_MASK 0xFFull
+#define RCV_BYPASS_BYPASS_CONTEXT_SMASK 0xFFull
+#define RCV_CONTEXTS (RXE + 0x000000000010)
+#define RCV_COUNTER_ARRAY32 (RXE + 0x000000000400)
+#define RCV_COUNTER_ARRAY64 (RXE + 0x000000000500)
+#define RCV_CTRL (RXE + 0x000000000000)
+#define RCV_CTRL_RCV_BYPASS_ENABLE_SMASK 0x10ull
+#define RCV_CTRL_RCV_EXTENDED_PSN_ENABLE_SMASK 0x40ull
+#define RCV_CTRL_RCV_PARTITION_KEY_ENABLE_SMASK 0x4ull
+#define RCV_CTRL_RCV_PORT_ENABLE_SMASK 0x1ull
+#define RCV_CTRL_RCV_QP_MAP_ENABLE_SMASK 0x2ull
+#define RCV_CTRL_RCV_RSM_ENABLE_SMASK 0x20ull
+#define RCV_CTRL_RX_RBUF_INIT_SMASK 0x200ull
+#define RCV_CTXT_CTRL (RXE + 0x000000100000)
+#define RCV_CTXT_CTRL_DONT_DROP_EGR_FULL_SMASK 0x4ull
+#define RCV_CTXT_CTRL_DONT_DROP_RHQ_FULL_SMASK 0x8ull
+#define RCV_CTXT_CTRL_EGR_BUF_SIZE_MASK 0x7ull
+#define RCV_CTXT_CTRL_EGR_BUF_SIZE_SHIFT 8
+#define RCV_CTXT_CTRL_EGR_BUF_SIZE_SMASK 0x700ull
+#define RCV_CTXT_CTRL_ENABLE_SMASK 0x1ull
+#define RCV_CTXT_CTRL_INTR_AVAIL_SMASK 0x20ull
+#define RCV_CTXT_CTRL_ONE_PACKET_PER_EGR_BUFFER_SMASK 0x2ull
+#define RCV_CTXT_CTRL_TAIL_UPD_SMASK 0x40ull
+#define RCV_CTXT_CTRL_TID_FLOW_ENABLE_SMASK 0x10ull
+#define RCV_CTXT_STATUS (RXE + 0x000000100008)
+#define RCV_EGR_CTRL (RXE + 0x000000100010)
+#define RCV_EGR_CTRL_EGR_BASE_INDEX_MASK 0x1FFFull
+#define RCV_EGR_CTRL_EGR_BASE_INDEX_SHIFT 0
+#define RCV_EGR_CTRL_EGR_CNT_MASK 0x1FFull
+#define RCV_EGR_CTRL_EGR_CNT_SHIFT 32
+#define RCV_EGR_INDEX_HEAD (RXE + 0x000000300018)
+#define RCV_EGR_INDEX_HEAD_HEAD_MASK 0x7FFull
+#define RCV_EGR_INDEX_HEAD_HEAD_SHIFT 0
+#define RCV_ERR_CLEAR (RXE + 0x000000000070)
+#define RCV_ERR_INFO (RXE + 0x000000000050)
+#define RCV_ERR_INFO_RCV_EXCESS_BUFFER_OVERRUN_SC_SMASK 0x1Full
+#define RCV_ERR_INFO_RCV_EXCESS_BUFFER_OVERRUN_SMASK 0x20ull
+#define RCV_ERR_MASK (RXE + 0x000000000068)
+#define RCV_ERR_STATUS (RXE + 0x000000000060)
+#define RCV_ERR_STATUS_RX_CSR_PARITY_ERR_SMASK 0x8000000000000000ull
+#define RCV_ERR_STATUS_RX_CSR_READ_BAD_ADDR_ERR_SMASK 0x2000000000000000ull
+#define RCV_ERR_STATUS_RX_CSR_WRITE_BAD_ADDR_ERR_SMASK \
+		0x4000000000000000ull
+#define RCV_ERR_STATUS_RX_DC_INTF_PARITY_ERR_SMASK 0x2ull
+#define RCV_ERR_STATUS_RX_DC_SOP_EOP_PARITY_ERR_SMASK 0x200ull
+#define RCV_ERR_STATUS_RX_DMA_CSR_COR_ERR_SMASK 0x1ull
+#define RCV_ERR_STATUS_RX_DMA_CSR_PARITY_ERR_SMASK 0x200000000000000ull
+#define RCV_ERR_STATUS_RX_DMA_CSR_UNC_ERR_SMASK 0x1000000000000000ull
+#define RCV_ERR_STATUS_RX_DMA_DATA_FIFO_RD_COR_ERR_SMASK \
+		0x40000000000000ull
+#define RCV_ERR_STATUS_RX_DMA_DATA_FIFO_RD_UNC_ERR_SMASK \
+		0x20000000000000ull
+#define RCV_ERR_STATUS_RX_DMA_DQ_FSM_ENCODING_ERR_SMASK \
+		0x800000000000000ull
+#define RCV_ERR_STATUS_RX_DMA_EQ_FSM_ENCODING_ERR_SMASK \
+		0x400000000000000ull
+#define RCV_ERR_STATUS_RX_DMA_FLAG_COR_ERR_SMASK 0x800ull
+#define RCV_ERR_STATUS_RX_DMA_FLAG_UNC_ERR_SMASK 0x400ull
+#define RCV_ERR_STATUS_RX_DMA_HDR_FIFO_RD_COR_ERR_SMASK 0x10000000000000ull
+#define RCV_ERR_STATUS_RX_DMA_HDR_FIFO_RD_UNC_ERR_SMASK 0x8000000000000ull
+#define RCV_ERR_STATUS_RX_HQ_INTR_CSR_PARITY_ERR_SMASK 0x200000000000ull
+#define RCV_ERR_STATUS_RX_HQ_INTR_FSM_ERR_SMASK 0x400000000000ull
+#define RCV_ERR_STATUS_RX_LOOKUP_CSR_PARITY_ERR_SMASK 0x100000000000ull
+#define RCV_ERR_STATUS_RX_LOOKUP_DES_PART1_UNC_COR_ERR_SMASK \
+		0x10000000000ull
+#define RCV_ERR_STATUS_RX_LOOKUP_DES_PART1_UNC_ERR_SMASK 0x8000000000ull
+#define RCV_ERR_STATUS_RX_LOOKUP_DES_PART2_PARITY_ERR_SMASK \
+		0x20000000000ull
+#define RCV_ERR_STATUS_RX_LOOKUP_RCV_ARRAY_COR_ERR_SMASK 0x80000000000ull
+#define RCV_ERR_STATUS_RX_LOOKUP_RCV_ARRAY_UNC_ERR_SMASK 0x40000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_BAD_LOOKUP_ERR_SMASK 0x40000000ull
+#define RCV_ERR_STATUS_RX_RBUF_BLOCK_LIST_READ_COR_ERR_SMASK 0x100000ull
+#define RCV_ERR_STATUS_RX_RBUF_BLOCK_LIST_READ_UNC_ERR_SMASK 0x80000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QENT_CNT_PARITY_ERR_SMASK 0x400000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QEOPDW_PARITY_ERR_SMASK 0x10000000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QHD_PTR_PARITY_ERR_SMASK 0x2000000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QHEAD_BUF_NUM_PARITY_ERR_SMASK \
+		0x200000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QNEXT_BUF_PARITY_ERR_SMASK 0x800000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QNUM_OF_PKT_PARITY_ERR_SMASK \
+		0x8000000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QTL_PTR_PARITY_ERR_SMASK 0x4000000ull
+#define RCV_ERR_STATUS_RX_RBUF_CSR_QVLD_BIT_PARITY_ERR_SMASK 0x1000000ull
+#define RCV_ERR_STATUS_RX_RBUF_CTX_ID_PARITY_ERR_SMASK 0x20000000ull
+#define RCV_ERR_STATUS_RX_RBUF_DATA_COR_ERR_SMASK 0x100000000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_DATA_UNC_ERR_SMASK 0x80000000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_DESC_PART1_COR_ERR_SMASK 0x1000000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_DESC_PART1_UNC_ERR_SMASK 0x800000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_DESC_PART2_COR_ERR_SMASK 0x4000000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_DESC_PART2_UNC_ERR_SMASK 0x2000000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_EMPTY_ERR_SMASK 0x100000000ull
+#define RCV_ERR_STATUS_RX_RBUF_FL_INITDONE_PARITY_ERR_SMASK 0x800000000ull
+#define RCV_ERR_STATUS_RX_RBUF_FL_INIT_WR_ADDR_PARITY_ERR_SMASK \
+		0x1000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_FL_RD_ADDR_PARITY_ERR_SMASK 0x200000000ull
+#define RCV_ERR_STATUS_RX_RBUF_FL_WR_ADDR_PARITY_ERR_SMASK 0x400000000ull
+#define RCV_ERR_STATUS_RX_RBUF_FREE_LIST_COR_ERR_SMASK 0x4000ull
+#define RCV_ERR_STATUS_RX_RBUF_FREE_LIST_UNC_ERR_SMASK 0x2000ull
+#define RCV_ERR_STATUS_RX_RBUF_FULL_ERR_SMASK 0x80000000ull
+#define RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_COR_ERR_SMASK 0x40000ull
+#define RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_REG_UNC_COR_ERR_SMASK 0x10000ull
+#define RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_REG_UNC_ERR_SMASK 0x8000ull
+#define RCV_ERR_STATUS_RX_RBUF_LOOKUP_DES_UNC_ERR_SMASK 0x20000ull
+#define RCV_ERR_STATUS_RX_RBUF_NEXT_FREE_BUF_COR_ERR_SMASK 0x4000000000ull
+#define RCV_ERR_STATUS_RX_RBUF_NEXT_FREE_BUF_UNC_ERR_SMASK 0x2000000000ull
+#define RCV_ERR_STATUS_RX_RCV_CSR_PARITY_ERR_SMASK 0x100ull
+#define RCV_ERR_STATUS_RX_RCV_DATA_COR_ERR_SMASK 0x20ull
+#define RCV_ERR_STATUS_RX_RCV_DATA_UNC_ERR_SMASK 0x10ull
+#define RCV_ERR_STATUS_RX_RCV_FSM_ENCODING_ERR_SMASK 0x1000ull
+#define RCV_ERR_STATUS_RX_RCV_HDR_COR_ERR_SMASK 0x8ull
+#define RCV_ERR_STATUS_RX_RCV_HDR_UNC_ERR_SMASK 0x4ull
+#define RCV_ERR_STATUS_RX_RCV_QP_MAP_TABLE_COR_ERR_SMASK 0x80ull
+#define RCV_ERR_STATUS_RX_RCV_QP_MAP_TABLE_UNC_ERR_SMASK 0x40ull
+#define RCV_HDR_ADDR (RXE + 0x000000100028)
+#define RCV_HDR_CNT (RXE + 0x000000100030)
+#define RCV_HDR_CNT_CNT_MASK 0x1FFull
+#define RCV_HDR_CNT_CNT_SHIFT 0
+#define RCV_HDR_ENT_SIZE (RXE + 0x000000100038)
+#define RCV_HDR_ENT_SIZE_ENT_SIZE_MASK 0x7ull
+#define RCV_HDR_ENT_SIZE_ENT_SIZE_SHIFT 0
+#define RCV_HDR_HEAD (RXE + 0x000000300008)
+#define RCV_HDR_HEAD_COUNTER_MASK 0xFFull
+#define RCV_HDR_HEAD_COUNTER_SHIFT 32
+#define RCV_HDR_HEAD_HEAD_MASK 0x7FFFFull
+#define RCV_HDR_HEAD_HEAD_SHIFT 0
+#define RCV_HDR_HEAD_HEAD_SMASK 0x7FFFFull
+#define RCV_HDR_OVFL_CNT (RXE + 0x000000100058)
+#define RCV_HDR_SIZE (RXE + 0x000000100040)
+#define RCV_HDR_SIZE_HDR_SIZE_MASK 0x1Full
+#define RCV_HDR_SIZE_HDR_SIZE_SHIFT 0
+#define RCV_HDR_TAIL (RXE + 0x000000300000)
+#define RCV_HDR_TAIL_ADDR (RXE + 0x000000100048)
+#define RCV_KEY_CTRL (RXE + 0x000000100020)
+#define RCV_KEY_CTRL_JOB_KEY_ENABLE_SMASK 0x200000000ull
+#define RCV_KEY_CTRL_JOB_KEY_VALUE_MASK 0xFFFFull
+#define RCV_KEY_CTRL_JOB_KEY_VALUE_SHIFT 0
+#define RCV_MULTICAST (RXE + 0x000000000030)
+#define RCV_PARTITION_KEY (RXE + 0x000000000200)
+#define RCV_PARTITION_KEY_PARTITION_KEY_A_MASK 0xFFFFull
+#define RCV_PARTITION_KEY_PARTITION_KEY_B_SHIFT 16
+#define RCV_QP_MAP_TABLE (RXE + 0x000000000100)
+#define RCV_RSM_CFG (RXE + 0x000000000600)
+#define RCV_RSM_CFG_ENABLE_OR_CHAIN_RSM0_MASK 0x1ull
+#define RCV_RSM_CFG_ENABLE_OR_CHAIN_RSM0_SHIFT 0
+#define RCV_RSM_CFG_PACKET_TYPE_SHIFT 60
+#define RCV_RSM_CFG_OFFSET_SHIFT 32
+#define RCV_RSM_MAP_TABLE (RXE + 0x000000000900)
+#define RCV_RSM_MAP_TABLE_RCV_CONTEXT_A_MASK 0xFFull
+#define RCV_RSM_MATCH (RXE + 0x000000000800)
+#define RCV_RSM_MATCH_MASK1_SHIFT 0
+#define RCV_RSM_MATCH_MASK2_SHIFT 16
+#define RCV_RSM_MATCH_VALUE1_SHIFT 8
+#define RCV_RSM_MATCH_VALUE2_SHIFT 24
+#define RCV_RSM_SELECT (RXE + 0x000000000700)
+#define RCV_RSM_SELECT_FIELD1_OFFSET_SHIFT 0
+#define RCV_RSM_SELECT_FIELD2_OFFSET_SHIFT 16
+#define RCV_RSM_SELECT_INDEX1_OFFSET_SHIFT 32
+#define RCV_RSM_SELECT_INDEX1_WIDTH_SHIFT 44
+#define RCV_RSM_SELECT_INDEX2_OFFSET_SHIFT 48
+#define RCV_RSM_SELECT_INDEX2_WIDTH_SHIFT 60
+#define RCV_STATUS (RXE + 0x000000000008)
+#define RCV_STATUS_RX_PKT_IN_PROGRESS_SMASK 0x1ull
+#define RCV_STATUS_RX_RBUF_INIT_DONE_SMASK 0x200ull
+#define RCV_STATUS_RX_RBUF_PKT_PENDING_SMASK 0x40ull
+#define RCV_TID_CTRL (RXE + 0x000000100018)
+#define RCV_TID_CTRL_TID_BASE_INDEX_MASK 0x1FFFull
+#define RCV_TID_CTRL_TID_BASE_INDEX_SHIFT 0
+#define RCV_TID_CTRL_TID_PAIR_CNT_MASK 0x1FFull
+#define RCV_TID_CTRL_TID_PAIR_CNT_SHIFT 32
+#define RCV_TID_FLOW_TABLE (RXE + 0x000000300800)
+#define RCV_VL15 (RXE + 0x000000000048)
+#define SEND_BTH_QP (TXE + 0x0000000000A0)
+#define SEND_BTH_QP_KDETH_QP_MASK 0xFFull
+#define SEND_BTH_QP_KDETH_QP_SHIFT 16
+#define SEND_CM_CREDIT_USED_STATUS (TXE + 0x000000000510)
+#define SEND_CM_CREDIT_USED_STATUS_VL0_RETURN_CREDIT_STATUS_SMASK \
+		0x1000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL15_RETURN_CREDIT_STATUS_SMASK \
+		0x8000000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL1_RETURN_CREDIT_STATUS_SMASK \
+		0x2000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL2_RETURN_CREDIT_STATUS_SMASK \
+		0x4000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL3_RETURN_CREDIT_STATUS_SMASK \
+		0x8000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL4_RETURN_CREDIT_STATUS_SMASK \
+		0x10000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL5_RETURN_CREDIT_STATUS_SMASK \
+		0x20000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL6_RETURN_CREDIT_STATUS_SMASK \
+		0x40000000000000ull
+#define SEND_CM_CREDIT_USED_STATUS_VL7_RETURN_CREDIT_STATUS_SMASK \
+		0x80000000000000ull
+#define SEND_CM_CREDIT_VL (TXE + 0x000000000600)
+#define SEND_CM_CREDIT_VL15 (TXE + 0x000000000678)
+#define SEND_CM_CREDIT_VL15_DEDICATED_LIMIT_VL_SHIFT 0
+#define SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_MASK 0xFFFFull
+#define SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SHIFT 0
+#define SEND_CM_CREDIT_VL_DEDICATED_LIMIT_VL_SMASK 0xFFFFull
+#define SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_MASK 0xFFFFull
+#define SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SHIFT 16
+#define SEND_CM_CREDIT_VL_SHARED_LIMIT_VL_SMASK 0xFFFF0000ull
+#define SEND_CM_CTRL (TXE + 0x000000000500)
+#define SEND_CM_CTRL_FORCE_CREDIT_MODE_SMASK 0x8ull
+#define SEND_CM_CTRL_RESETCSR 0x0000000000000020ull
+#define SEND_CM_GLOBAL_CREDIT (TXE + 0x000000000508)
+#define SEND_CM_GLOBAL_CREDIT_AU_MASK 0x7ull
+#define SEND_CM_GLOBAL_CREDIT_AU_SHIFT 16
+#define SEND_CM_GLOBAL_CREDIT_AU_SMASK 0x70000ull
+#define SEND_CM_GLOBAL_CREDIT_RESETCSR 0x0000094000030000ull
+#define SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_MASK 0xFFFFull
+#define SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SHIFT 0
+#define SEND_CM_GLOBAL_CREDIT_SHARED_LIMIT_SMASK 0xFFFFull
+#define SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_MASK 0xFFFFull
+#define SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SHIFT 32
+#define SEND_CM_GLOBAL_CREDIT_TOTAL_CREDIT_LIMIT_SMASK 0xFFFF00000000ull
+#define SEND_CM_LOCAL_AU_TABLE0_TO3 (TXE + 0x000000000520)
+#define SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE0_SHIFT 0
+#define SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE1_SHIFT 16
+#define SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE2_SHIFT 32
+#define SEND_CM_LOCAL_AU_TABLE0_TO3_LOCAL_AU_TABLE3_SHIFT 48
+#define SEND_CM_LOCAL_AU_TABLE4_TO7 (TXE + 0x000000000528)
+#define SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE4_SHIFT 0
+#define SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE5_SHIFT 16
+#define SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE6_SHIFT 32
+#define SEND_CM_LOCAL_AU_TABLE4_TO7_LOCAL_AU_TABLE7_SHIFT 48
+#define SEND_CM_REMOTE_AU_TABLE0_TO3 (TXE + 0x000000000530)
+#define SEND_CM_REMOTE_AU_TABLE4_TO7 (TXE + 0x000000000538)
+#define SEND_CM_TIMER_CTRL (TXE + 0x000000000518)
+#define SEND_CONTEXTS (TXE + 0x000000000010)
+#define SEND_CONTEXT_SET_CTRL (TXE + 0x000000000200)
+#define SEND_COUNTER_ARRAY32 (TXE + 0x000000000300)
+#define SEND_COUNTER_ARRAY64 (TXE + 0x000000000400)
+#define SEND_CTRL (TXE + 0x000000000000)
+#define SEND_CTRL_CM_RESET_SMASK 0x4ull
+#define SEND_CTRL_SEND_ENABLE_SMASK 0x1ull
+#define SEND_CTRL_UNSUPPORTED_VL_SHIFT 3
+#define SEND_CTRL_UNSUPPORTED_VL_MASK 0xFFull
+#define SEND_CTRL_UNSUPPORTED_VL_SMASK (SEND_CTRL_UNSUPPORTED_VL_MASK \
+		<< SEND_CTRL_UNSUPPORTED_VL_SHIFT)
+#define SEND_CTRL_VL_ARBITER_ENABLE_SMASK 0x2ull
+#define SEND_CTXT_CHECK_ENABLE (TXE + 0x000000100080)
+#define SEND_CTXT_CHECK_ENABLE_CHECK_BYPASS_VL_MAPPING_SMASK 0x80ull
+#define SEND_CTXT_CHECK_ENABLE_CHECK_ENABLE_SMASK 0x1ull
+#define SEND_CTXT_CHECK_ENABLE_CHECK_JOB_KEY_SMASK 0x4ull
+#define SEND_CTXT_CHECK_ENABLE_CHECK_OPCODE_SMASK 0x20ull
+#define SEND_CTXT_CHECK_ENABLE_CHECK_PARTITION_KEY_SMASK 0x8ull
+#define SEND_CTXT_CHECK_ENABLE_CHECK_SLID_SMASK 0x10ull
+#define SEND_CTXT_CHECK_ENABLE_CHECK_VL_MAPPING_SMASK 0x40ull
+#define SEND_CTXT_CHECK_ENABLE_CHECK_VL_SMASK 0x2ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_BAD_PKT_LEN_SMASK 0x20000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_BYPASS_BAD_PKT_LEN_SMASK \
+		0x200000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_BYPASS_SMASK 0x800ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_GRH_SMASK 0x400ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_KDETH_PACKETS_SMASK 0x1000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_NON_KDETH_PACKETS_SMASK 0x2000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_PBC_STATIC_RATE_CONTROL_SMASK \
+		0x100000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_PBC_TEST_SMASK 0x10000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_RAW_IPV6_SMASK 0x200ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_RAW_SMASK 0x100ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_LONG_BYPASS_PACKETS_SMASK \
+		0x80000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_LONG_IB_PACKETS_SMASK \
+		0x40000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_SMALL_BYPASS_PACKETS_SMASK \
+		0x8000ull
+#define SEND_CTXT_CHECK_ENABLE_DISALLOW_TOO_SMALL_IB_PACKETS_SMASK \
+		0x4000ull
+#define SEND_CTXT_CHECK_JOB_KEY (TXE + 0x000000100090)
+#define SEND_CTXT_CHECK_JOB_KEY_ALLOW_PERMISSIVE_SMASK 0x100000000ull
+#define SEND_CTXT_CHECK_JOB_KEY_MASK_SMASK 0xFFFF0000ull
+#define SEND_CTXT_CHECK_JOB_KEY_VALUE_MASK 0xFFFFull
+#define SEND_CTXT_CHECK_JOB_KEY_VALUE_SHIFT 0
+#define SEND_CTXT_CHECK_OPCODE (TXE + 0x0000001000A8)
+#define SEND_CTXT_CHECK_OPCODE_MASK_SHIFT 8
+#define SEND_CTXT_CHECK_OPCODE_VALUE_SHIFT 0
+#define SEND_CTXT_CHECK_PARTITION_KEY (TXE + 0x000000100098)
+#define SEND_CTXT_CHECK_PARTITION_KEY_VALUE_MASK 0xFFFFull
+#define SEND_CTXT_CHECK_PARTITION_KEY_VALUE_SHIFT 0
+#define SEND_CTXT_CHECK_SLID (TXE + 0x0000001000A0)
+#define SEND_CTXT_CHECK_SLID_MASK_MASK 0xFFFFull
+#define SEND_CTXT_CHECK_SLID_MASK_SHIFT 16
+#define SEND_CTXT_CHECK_SLID_VALUE_MASK 0xFFFFull
+#define SEND_CTXT_CHECK_SLID_VALUE_SHIFT 0
+#define SEND_CTXT_CHECK_VL (TXE + 0x000000100088)
+#define SEND_CTXT_CREDIT_CTRL (TXE + 0x000000100010)
+#define SEND_CTXT_CREDIT_CTRL_CREDIT_INTR_SMASK 0x20000ull
+#define SEND_CTXT_CREDIT_CTRL_EARLY_RETURN_SMASK 0x10000ull
+#define SEND_CTXT_CREDIT_CTRL_THRESHOLD_MASK 0x7FFull
+#define SEND_CTXT_CREDIT_CTRL_THRESHOLD_SHIFT 0
+#define SEND_CTXT_CREDIT_CTRL_THRESHOLD_SMASK 0x7FFull
+#define SEND_CTXT_CREDIT_STATUS (TXE + 0x000000100018)
+#define SEND_CTXT_CREDIT_STATUS_CURRENT_FREE_COUNTER_MASK 0x7FFull
+#define SEND_CTXT_CREDIT_STATUS_CURRENT_FREE_COUNTER_SHIFT 32
+#define SEND_CTXT_CREDIT_STATUS_LAST_RETURNED_COUNTER_SMASK 0x7FFull
+#define SEND_CTXT_CREDIT_FORCE (TXE + 0x000000100028)
+#define SEND_CTXT_CREDIT_FORCE_FORCE_RETURN_SMASK 0x1ull
+#define SEND_CTXT_CREDIT_RETURN_ADDR (TXE + 0x000000100020)
+#define SEND_CTXT_CREDIT_RETURN_ADDR_ADDRESS_SMASK 0xFFFFFFFFFFC0ull
+#define SEND_CTXT_CTRL (TXE + 0x000000100000)
+#define SEND_CTXT_CTRL_CTXT_BASE_MASK 0x3FFFull
+#define SEND_CTXT_CTRL_CTXT_BASE_SHIFT 32
+#define SEND_CTXT_CTRL_CTXT_DEPTH_MASK 0x7FFull
+#define SEND_CTXT_CTRL_CTXT_DEPTH_SHIFT 48
+#define SEND_CTXT_CTRL_CTXT_ENABLE_SMASK 0x1ull
+#define SEND_CTXT_ERR_CLEAR (TXE + 0x000000100050)
+#define SEND_CTXT_ERR_MASK (TXE + 0x000000100048)
+#define SEND_CTXT_ERR_STATUS (TXE + 0x000000100040)
+#define SEND_CTXT_ERR_STATUS_PIO_DISALLOWED_PACKET_ERR_SMASK 0x2ull
+#define SEND_CTXT_ERR_STATUS_PIO_INCONSISTENT_SOP_ERR_SMASK 0x1ull
+#define SEND_CTXT_ERR_STATUS_PIO_WRITE_CROSSES_BOUNDARY_ERR_SMASK 0x4ull
+#define SEND_CTXT_ERR_STATUS_PIO_WRITE_OUT_OF_BOUNDS_ERR_SMASK 0x10ull
+#define SEND_CTXT_ERR_STATUS_PIO_WRITE_OVERFLOW_ERR_SMASK 0x8ull
+#define SEND_CTXT_STATUS (TXE + 0x000000100008)
+#define SEND_CTXT_STATUS_CTXT_HALTED_SMASK 0x1ull
+#define SEND_DMA_BASE_ADDR (TXE + 0x000000200010)
+#define SEND_DMA_CHECK_ENABLE (TXE + 0x000000200080)
+#define SEND_DMA_CHECK_ENABLE_CHECK_BYPASS_VL_MAPPING_SMASK 0x80ull
+#define SEND_DMA_CHECK_ENABLE_CHECK_ENABLE_SMASK 0x1ull
+#define SEND_DMA_CHECK_ENABLE_CHECK_JOB_KEY_SMASK 0x4ull
+#define SEND_DMA_CHECK_ENABLE_CHECK_OPCODE_SMASK 0x20ull
+#define SEND_DMA_CHECK_ENABLE_CHECK_PARTITION_KEY_SMASK 0x8ull
+#define SEND_DMA_CHECK_ENABLE_CHECK_SLID_SMASK 0x10ull
+#define SEND_DMA_CHECK_ENABLE_CHECK_VL_MAPPING_SMASK 0x40ull
+#define SEND_DMA_CHECK_ENABLE_CHECK_VL_SMASK 0x2ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_BAD_PKT_LEN_SMASK 0x20000ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_BYPASS_BAD_PKT_LEN_SMASK 0x200000ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_PBC_STATIC_RATE_CONTROL_SMASK \
+		0x100000ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_RAW_IPV6_SMASK 0x200ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_RAW_SMASK 0x100ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_LONG_BYPASS_PACKETS_SMASK \
+		0x80000ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_LONG_IB_PACKETS_SMASK 0x40000ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_SMALL_BYPASS_PACKETS_SMASK \
+		0x8000ull
+#define SEND_DMA_CHECK_ENABLE_DISALLOW_TOO_SMALL_IB_PACKETS_SMASK 0x4000ull
+#define SEND_DMA_CHECK_JOB_KEY (TXE + 0x000000200090)
+#define SEND_DMA_CHECK_OPCODE (TXE + 0x0000002000A8)
+#define SEND_DMA_CHECK_PARTITION_KEY (TXE + 0x000000200098)
+#define SEND_DMA_CHECK_SLID (TXE + 0x0000002000A0)
+#define SEND_DMA_CHECK_SLID_MASK_MASK 0xFFFFull
+#define SEND_DMA_CHECK_SLID_MASK_SHIFT 16
+#define SEND_DMA_CHECK_SLID_VALUE_MASK 0xFFFFull
+#define SEND_DMA_CHECK_SLID_VALUE_SHIFT 0
+#define SEND_DMA_CHECK_VL (TXE + 0x000000200088)
+#define SEND_DMA_CTRL (TXE + 0x000000200000)
+#define SEND_DMA_CTRL_SDMA_CLEANUP_SMASK 0x4ull
+#define SEND_DMA_CTRL_SDMA_ENABLE_SMASK 0x1ull
+#define SEND_DMA_CTRL_SDMA_HALT_SMASK 0x2ull
+#define SEND_DMA_CTRL_SDMA_INT_ENABLE_SMASK 0x8ull
+#define SEND_DMA_DESC_CNT (TXE + 0x000000200050)
+#define SEND_DMA_DESC_CNT_CNT_MASK 0xFFFFull
+#define SEND_DMA_DESC_CNT_CNT_SHIFT 0
+#define SEND_DMA_ENG_ERR_CLEAR (TXE + 0x000000200070)
+#define SEND_DMA_ENG_ERR_CLEAR_SDMA_HEADER_REQUEST_FIFO_UNC_ERR_MASK 0x1ull
+#define SEND_DMA_ENG_ERR_CLEAR_SDMA_HEADER_REQUEST_FIFO_UNC_ERR_SHIFT 18
+#define SEND_DMA_ENG_ERR_MASK (TXE + 0x000000200068)
+#define SEND_DMA_ENG_ERR_STATUS (TXE + 0x000000200060)
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_ASSEMBLY_UNC_ERR_SMASK 0x8000ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_DESC_TABLE_UNC_ERR_SMASK 0x4000ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_FIRST_DESC_ERR_SMASK 0x10ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_GEN_MISMATCH_ERR_SMASK 0x2ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_HALT_ERR_SMASK 0x40ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_HEADER_ADDRESS_ERR_SMASK 0x800ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_HEADER_LENGTH_ERR_SMASK 0x1000ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_HEADER_REQUEST_FIFO_UNC_ERR_SMASK \
+		0x40000ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_HEADER_SELECT_ERR_SMASK 0x400ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_HEADER_STORAGE_UNC_ERR_SMASK \
+		0x20000ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_LENGTH_MISMATCH_ERR_SMASK 0x80ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_MEM_READ_ERR_SMASK 0x20ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_PACKET_DESC_OVERFLOW_ERR_SMASK \
+		0x100ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_PACKET_TRACKING_UNC_ERR_SMASK \
+		0x10000ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_TAIL_OUT_OF_BOUNDS_ERR_SMASK 0x8ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_TIMEOUT_ERR_SMASK 0x2000ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_TOO_LONG_ERR_SMASK 0x4ull
+#define SEND_DMA_ENG_ERR_STATUS_SDMA_WRONG_DW_ERR_SMASK 0x1ull
+#define SEND_DMA_ENGINES (TXE + 0x000000000018)
+#define SEND_DMA_ERR_CLEAR (TXE + 0x000000000070)
+#define SEND_DMA_ERR_MASK (TXE + 0x000000000068)
+#define SEND_DMA_ERR_STATUS (TXE + 0x000000000060)
+#define SEND_DMA_ERR_STATUS_SDMA_CSR_PARITY_ERR_SMASK 0x2ull
+#define SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_COR_ERR_SMASK 0x8ull
+#define SEND_DMA_ERR_STATUS_SDMA_PCIE_REQ_TRACKING_UNC_ERR_SMASK 0x4ull
+#define SEND_DMA_ERR_STATUS_SDMA_RPY_TAG_ERR_SMASK 0x1ull
+#define SEND_DMA_HEAD (TXE + 0x000000200028)
+#define SEND_DMA_HEAD_ADDR (TXE + 0x000000200030)
+#define SEND_DMA_LEN_GEN (TXE + 0x000000200018)
+#define SEND_DMA_LEN_GEN_GENERATION_SHIFT 16
+#define SEND_DMA_LEN_GEN_LENGTH_SHIFT 6
+#define SEND_DMA_MEMORY (TXE + 0x0000002000B0)
+#define SEND_DMA_MEMORY_SDMA_MEMORY_CNT_SHIFT 16
+#define SEND_DMA_MEMORY_SDMA_MEMORY_INDEX_SHIFT 0
+#define SEND_DMA_MEM_SIZE (TXE + 0x000000000028)
+#define SEND_DMA_PRIORITY_THLD (TXE + 0x000000200038)
+#define SEND_DMA_RELOAD_CNT (TXE + 0x000000200048)
+#define SEND_DMA_STATUS (TXE + 0x000000200008)
+#define SEND_DMA_STATUS_ENG_CLEANED_UP_SMASK 0x200000000000000ull
+#define SEND_DMA_STATUS_ENG_HALTED_SMASK 0x100000000000000ull
+#define SEND_DMA_TAIL (TXE + 0x000000200020)
+#define SEND_EGRESS_CTXT_STATUS (TXE + 0x000000000800)
+#define SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_HALT_STATUS_SMASK 0x10000ull
+#define SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SHIFT 0
+#define SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SMASK \
+		0x3FFFull
+#define SEND_EGRESS_ERR_CLEAR (TXE + 0x000000000090)
+#define SEND_EGRESS_ERR_INFO (TXE + 0x000000000F00)
+#define SEND_EGRESS_ERR_INFO_BAD_PKT_LEN_ERR_SMASK 0x20000ull
+#define SEND_EGRESS_ERR_INFO_BYPASS_ERR_SMASK 0x800ull
+#define SEND_EGRESS_ERR_INFO_GRH_ERR_SMASK 0x400ull
+#define SEND_EGRESS_ERR_INFO_JOB_KEY_ERR_SMASK 0x4ull
+#define SEND_EGRESS_ERR_INFO_KDETH_PACKETS_ERR_SMASK 0x1000ull
+#define SEND_EGRESS_ERR_INFO_NON_KDETH_PACKETS_ERR_SMASK 0x2000ull
+#define SEND_EGRESS_ERR_INFO_OPCODE_ERR_SMASK 0x20ull
+#define SEND_EGRESS_ERR_INFO_PARTITION_KEY_ERR_SMASK 0x8ull
+#define SEND_EGRESS_ERR_INFO_PBC_STATIC_RATE_CONTROL_ERR_SMASK 0x100000ull
+#define SEND_EGRESS_ERR_INFO_PBC_TEST_ERR_SMASK 0x10000ull
+#define SEND_EGRESS_ERR_INFO_RAW_ERR_SMASK 0x100ull
+#define SEND_EGRESS_ERR_INFO_RAW_IPV6_ERR_SMASK 0x200ull
+#define SEND_EGRESS_ERR_INFO_SLID_ERR_SMASK 0x10ull
+#define SEND_EGRESS_ERR_INFO_TOO_LONG_BYPASS_PACKETS_ERR_SMASK 0x80000ull
+#define SEND_EGRESS_ERR_INFO_TOO_LONG_IB_PACKET_ERR_SMASK 0x40000ull
+#define SEND_EGRESS_ERR_INFO_TOO_SMALL_BYPASS_PACKETS_ERR_SMASK 0x8000ull
+#define SEND_EGRESS_ERR_INFO_TOO_SMALL_IB_PACKETS_ERR_SMASK 0x4000ull
+#define SEND_EGRESS_ERR_INFO_VL_ERR_SMASK 0x2ull
+#define SEND_EGRESS_ERR_INFO_VL_MAPPING_ERR_SMASK 0x40ull
+#define SEND_EGRESS_ERR_MASK (TXE + 0x000000000088)
+#define SEND_EGRESS_ERR_SOURCE (TXE + 0x000000000F08)
+#define SEND_EGRESS_ERR_STATUS (TXE + 0x000000000080)
+#define SEND_EGRESS_ERR_STATUS_TX_CONFIG_PARITY_ERR_SMASK 0x8000ull
+#define SEND_EGRESS_ERR_STATUS_TX_CREDIT_OVERRUN_ERR_SMASK \
+		0x200000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_CREDIT_RETURN_PARITY_ERR_SMASK \
+		0x20000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_CREDIT_RETURN_VL_ERR_SMASK \
+		0x800000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_EGRESS_FIFO_COR_ERR_SMASK \
+		0x2000000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_EGRESS_FIFO_UNC_ERR_SMASK \
+		0x200000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_EGRESS_FIFO_UNDERRUN_OR_PARITY_ERR_SMASK \
+		0x8ull
+#define SEND_EGRESS_ERR_STATUS_TX_HCRC_INSERTION_ERR_SMASK \
+		0x400000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_ILLEGAL_VL_ERR_SMASK 0x1000ull
+#define SEND_EGRESS_ERR_STATUS_TX_INCORRECT_LINK_STATE_ERR_SMASK 0x20ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_CSR_PARITY_ERR_SMASK 0x2000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO0_COR_ERR_SMASK \
+		0x1000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO0_UNC_OR_PARITY_ERR_SMASK \
+		0x100000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO1_COR_ERR_SMASK \
+		0x2000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO1_UNC_OR_PARITY_ERR_SMASK \
+		0x200000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO2_COR_ERR_SMASK \
+		0x4000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO2_UNC_OR_PARITY_ERR_SMASK \
+		0x400000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO3_COR_ERR_SMASK \
+		0x8000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO3_UNC_OR_PARITY_ERR_SMASK \
+		0x800000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO4_COR_ERR_SMASK \
+		0x10000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO4_UNC_OR_PARITY_ERR_SMASK \
+		0x1000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO5_COR_ERR_SMASK \
+		0x20000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO5_UNC_OR_PARITY_ERR_SMASK \
+		0x2000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO6_COR_ERR_SMASK \
+		0x40000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO6_UNC_OR_PARITY_ERR_SMASK \
+		0x4000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO7_COR_ERR_SMASK \
+		0x80000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO7_UNC_OR_PARITY_ERR_SMASK \
+		0x8000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO8_COR_ERR_SMASK \
+		0x100000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LAUNCH_FIFO8_UNC_OR_PARITY_ERR_SMASK \
+		0x10000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_LINKDOWN_ERR_SMASK 0x10ull
+#define SEND_EGRESS_ERR_STATUS_TX_PIO_LAUNCH_INTF_PARITY_ERR_SMASK 0x80ull
+#define SEND_EGRESS_ERR_STATUS_TX_PKT_INTEGRITY_MEM_COR_ERR_SMASK 0x1ull
+#define SEND_EGRESS_ERR_STATUS_TX_PKT_INTEGRITY_MEM_UNC_ERR_SMASK 0x2ull
+#define SEND_EGRESS_ERR_STATUS_TX_READ_PIO_MEMORY_COR_ERR_SMASK \
+		0x1000000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_READ_PIO_MEMORY_CSR_UNC_ERR_SMASK \
+		0x8000000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_READ_PIO_MEMORY_UNC_ERR_SMASK \
+		0x100000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_READ_SDMA_MEMORY_COR_ERR_SMASK \
+		0x800000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_READ_SDMA_MEMORY_CSR_UNC_ERR_SMASK \
+		0x4000000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_READ_SDMA_MEMORY_UNC_ERR_SMASK \
+		0x80000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SB_HDR_COR_ERR_SMASK 0x400000000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SB_HDR_UNC_ERR_SMASK 0x40000000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SBRD_CTL_CSR_PARITY_ERR_SMASK 0x4000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SBRD_CTL_STATE_MACHINE_PARITY_ERR_SMASK \
+		0x800ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA0_DISALLOWED_PACKET_ERR_SMASK \
+		0x10000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA10_DISALLOWED_PACKET_ERR_SMASK \
+		0x4000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA11_DISALLOWED_PACKET_ERR_SMASK \
+		0x8000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA12_DISALLOWED_PACKET_ERR_SMASK \
+		0x10000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA13_DISALLOWED_PACKET_ERR_SMASK \
+		0x20000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA14_DISALLOWED_PACKET_ERR_SMASK \
+		0x40000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA15_DISALLOWED_PACKET_ERR_SMASK \
+		0x80000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA1_DISALLOWED_PACKET_ERR_SMASK \
+		0x20000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA2_DISALLOWED_PACKET_ERR_SMASK \
+		0x40000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA3_DISALLOWED_PACKET_ERR_SMASK \
+		0x80000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA4_DISALLOWED_PACKET_ERR_SMASK \
+		0x100000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA5_DISALLOWED_PACKET_ERR_SMASK \
+		0x200000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA6_DISALLOWED_PACKET_ERR_SMASK \
+		0x400000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA7_DISALLOWED_PACKET_ERR_SMASK \
+		0x800000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA8_DISALLOWED_PACKET_ERR_SMASK \
+		0x1000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA9_DISALLOWED_PACKET_ERR_SMASK \
+		0x2000000ull
+#define SEND_EGRESS_ERR_STATUS_TX_SDMA_LAUNCH_INTF_PARITY_ERR_SMASK \
+		0x100ull
+#define SEND_EGRESS_SEND_DMA_STATUS (TXE + 0x000000000E00)
+#define SEND_EGRESS_SEND_DMA_STATUS_SDMA_EGRESS_PACKET_OCCUPANCY_SHIFT 0
+#define SEND_EGRESS_SEND_DMA_STATUS_SDMA_EGRESS_PACKET_OCCUPANCY_SMASK \
+		0x3FFFull
+#define SEND_ERR_CLEAR (TXE + 0x0000000000F0)
+#define SEND_ERR_MASK (TXE + 0x0000000000E8)
+#define SEND_ERR_STATUS (TXE + 0x0000000000E0)
+#define SEND_ERR_STATUS_SEND_CSR_PARITY_ERR_SMASK 0x1ull
+#define SEND_ERR_STATUS_SEND_CSR_READ_BAD_ADDR_ERR_SMASK 0x2ull
+#define SEND_ERR_STATUS_SEND_CSR_WRITE_BAD_ADDR_ERR_SMASK 0x4ull
+#define SEND_HIGH_PRIORITY_LIMIT (TXE + 0x000000000030)
+#define SEND_HIGH_PRIORITY_LIMIT_LIMIT_MASK 0x3FFFull
+#define SEND_HIGH_PRIORITY_LIMIT_LIMIT_SHIFT 0
+#define SEND_HIGH_PRIORITY_LIST (TXE + 0x000000000180)
+#define SEND_LEN_CHECK0 (TXE + 0x0000000000D0)
+#define SEND_LEN_CHECK0_LEN_VL0_MASK 0xFFFull
+#define SEND_LEN_CHECK0_LEN_VL1_SHIFT 12
+#define SEND_LEN_CHECK1 (TXE + 0x0000000000D8)
+#define SEND_LEN_CHECK1_LEN_VL15_MASK 0xFFFull
+#define SEND_LEN_CHECK1_LEN_VL15_SHIFT 48
+#define SEND_LEN_CHECK1_LEN_VL4_MASK 0xFFFull
+#define SEND_LEN_CHECK1_LEN_VL5_SHIFT 12
+#define SEND_LOW_PRIORITY_LIST (TXE + 0x000000000100)
+#define SEND_LOW_PRIORITY_LIST_VL_MASK 0x7ull
+#define SEND_LOW_PRIORITY_LIST_VL_SHIFT 16
+#define SEND_LOW_PRIORITY_LIST_WEIGHT_MASK 0xFFull
+#define SEND_LOW_PRIORITY_LIST_WEIGHT_SHIFT 0
+#define SEND_PIO_ERR_CLEAR (TXE + 0x000000000050)
+#define SEND_PIO_ERR_CLEAR_PIO_INIT_SM_IN_ERR_SMASK 0x20000ull
+#define SEND_PIO_ERR_MASK (TXE + 0x000000000048)
+#define SEND_PIO_ERR_STATUS (TXE + 0x000000000040)
+#define SEND_PIO_ERR_STATUS_PIO_BLOCK_QW_COUNT_PARITY_ERR_SMASK \
+		0x1000000ull
+#define SEND_PIO_ERR_STATUS_PIO_CREDIT_RET_FIFO_PARITY_ERR_SMASK 0x8000ull
+#define SEND_PIO_ERR_STATUS_PIO_CSR_PARITY_ERR_SMASK 0x4ull
+#define SEND_PIO_ERR_STATUS_PIO_CURRENT_FREE_CNT_PARITY_ERR_SMASK \
+		0x100000000ull
+#define SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_COR_ERR_SMASK 0x100000ull
+#define SEND_PIO_ERR_STATUS_PIO_HOST_ADDR_MEM_UNC_ERR_SMASK 0x80000ull
+#define SEND_PIO_ERR_STATUS_PIO_INIT_SM_IN_ERR_SMASK 0x20000ull
+#define SEND_PIO_ERR_STATUS_PIO_LAST_RETURNED_CNT_PARITY_ERR_SMASK \
+		0x200000000ull
+#define SEND_PIO_ERR_STATUS_PIO_PCC_FIFO_PARITY_ERR_SMASK 0x20ull
+#define SEND_PIO_ERR_STATUS_PIO_PCC_SOP_HEAD_PARITY_ERR_SMASK \
+		0x400000000ull
+#define SEND_PIO_ERR_STATUS_PIO_PEC_FIFO_PARITY_ERR_SMASK 0x40ull
+#define SEND_PIO_ERR_STATUS_PIO_PEC_SOP_HEAD_PARITY_ERR_SMASK \
+		0x800000000ull
+#define SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_FIFO_PARITY_ERR_SMASK 0x200ull
+#define SEND_PIO_ERR_STATUS_PIO_PKT_EVICT_SM_OR_ARB_SM_ERR_SMASK 0x40000ull
+#define SEND_PIO_ERR_STATUS_PIO_PPMC_BQC_MEM_PARITY_ERR_SMASK 0x10000000ull
+#define SEND_PIO_ERR_STATUS_PIO_PPMC_PBL_FIFO_ERR_SMASK 0x10000ull
+#define SEND_PIO_ERR_STATUS_PIO_PPMC_SOP_LEN_ERR_SMASK 0x20000000ull
+#define SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO0_ERR_SMASK 0x8ull
+#define SEND_PIO_ERR_STATUS_PIO_SB_MEM_FIFO1_ERR_SMASK 0x10ull
+#define SEND_PIO_ERR_STATUS_PIO_SBRDCTL_CRREL_PARITY_ERR_SMASK 0x80ull
+#define SEND_PIO_ERR_STATUS_PIO_SBRDCTRL_CRREL_FIFO_PARITY_ERR_SMASK \
+		0x100ull
+#define SEND_PIO_ERR_STATUS_PIO_SM_PKT_RESET_PARITY_ERR_SMASK 0x400ull
+#define SEND_PIO_ERR_STATUS_PIO_STATE_MACHINE_ERR_SMASK 0x400000ull
+#define SEND_PIO_ERR_STATUS_PIO_VL_FIFO_PARITY_ERR_SMASK 0x8000000ull
+#define SEND_PIO_ERR_STATUS_PIO_VLF_SOP_PARITY_ERR_SMASK 0x4000000ull
+#define SEND_PIO_ERR_STATUS_PIO_VLF_VL_LEN_PARITY_ERR_SMASK 0x2000000ull
+#define SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_COR_ERR_SMASK 0x2000ull
+#define SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK0_UNC_ERR_SMASK 0x800ull
+#define SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_COR_ERR_SMASK 0x4000ull
+#define SEND_PIO_ERR_STATUS_PIO_VL_LEN_MEM_BANK1_UNC_ERR_SMASK 0x1000ull
+#define SEND_PIO_ERR_STATUS_PIO_WRITE_ADDR_PARITY_ERR_SMASK 0x2ull
+#define SEND_PIO_ERR_STATUS_PIO_WRITE_BAD_CTXT_ERR_SMASK 0x1ull
+#define SEND_PIO_ERR_STATUS_PIO_WRITE_DATA_PARITY_ERR_SMASK 0x200000ull
+#define SEND_PIO_ERR_STATUS_PIO_WRITE_QW_VALID_PARITY_ERR_SMASK 0x800000ull
+#define SEND_PIO_INIT_CTXT (TXE + 0x000000000038)
+#define SEND_PIO_INIT_CTXT_PIO_ALL_CTXT_INIT_SMASK 0x1ull
+#define SEND_PIO_INIT_CTXT_PIO_CTXT_NUM_MASK 0xFFull
+#define SEND_PIO_INIT_CTXT_PIO_CTXT_NUM_SHIFT 8
+#define SEND_PIO_INIT_CTXT_PIO_INIT_ERR_SMASK 0x8ull
+#define SEND_PIO_INIT_CTXT_PIO_INIT_IN_PROGRESS_SMASK 0x4ull
+#define SEND_PIO_INIT_CTXT_PIO_SINGLE_CTXT_INIT_SMASK 0x2ull
+#define SEND_PIO_MEM_SIZE (TXE + 0x000000000020)
+#define SEND_SC2VLT0 (TXE + 0x0000000000B0)
+#define SEND_SC2VLT0_SC0_SHIFT 0
+#define SEND_SC2VLT0_SC1_SHIFT 8
+#define SEND_SC2VLT0_SC2_SHIFT 16
+#define SEND_SC2VLT0_SC3_SHIFT 24
+#define SEND_SC2VLT0_SC4_SHIFT 32
+#define SEND_SC2VLT0_SC5_SHIFT 40
+#define SEND_SC2VLT0_SC6_SHIFT 48
+#define SEND_SC2VLT0_SC7_SHIFT 56
+#define SEND_SC2VLT1 (TXE + 0x0000000000B8)
+#define SEND_SC2VLT1_SC10_SHIFT 16
+#define SEND_SC2VLT1_SC11_SHIFT 24
+#define SEND_SC2VLT1_SC12_SHIFT 32
+#define SEND_SC2VLT1_SC13_SHIFT 40
+#define SEND_SC2VLT1_SC14_SHIFT 48
+#define SEND_SC2VLT1_SC15_SHIFT 56
+#define SEND_SC2VLT1_SC8_SHIFT 0
+#define SEND_SC2VLT1_SC9_SHIFT 8
+#define SEND_SC2VLT2 (TXE + 0x0000000000C0)
+#define SEND_SC2VLT2_SC16_SHIFT 0
+#define SEND_SC2VLT2_SC17_SHIFT 8
+#define SEND_SC2VLT2_SC18_SHIFT 16
+#define SEND_SC2VLT2_SC19_SHIFT 24
+#define SEND_SC2VLT2_SC20_SHIFT 32
+#define SEND_SC2VLT2_SC21_SHIFT 40
+#define SEND_SC2VLT2_SC22_SHIFT 48
+#define SEND_SC2VLT2_SC23_SHIFT 56
+#define SEND_SC2VLT3 (TXE + 0x0000000000C8)
+#define SEND_SC2VLT3_SC24_SHIFT 0
+#define SEND_SC2VLT3_SC25_SHIFT 8
+#define SEND_SC2VLT3_SC26_SHIFT 16
+#define SEND_SC2VLT3_SC27_SHIFT 24
+#define SEND_SC2VLT3_SC28_SHIFT 32
+#define SEND_SC2VLT3_SC29_SHIFT 40
+#define SEND_SC2VLT3_SC30_SHIFT 48
+#define SEND_SC2VLT3_SC31_SHIFT 56
+#define SEND_STATIC_RATE_CONTROL (TXE + 0x0000000000A8)
+#define SEND_STATIC_RATE_CONTROL_CSR_SRC_RELOAD_SHIFT 0
+#define SEND_STATIC_RATE_CONTROL_CSR_SRC_RELOAD_SMASK 0xFFFFull
+#define PCIE_CFG_REG_PL2 (PCIE + 0x000000000708)
+#define PCIE_CFG_REG_PL3 (PCIE + 0x00000000070C)
+#define PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SHIFT 27
+#define PCIE_CFG_REG_PL3_L1_ENT_LATENCY_SMASK 0x38000000
+#define PCIE_CFG_REG_PL102 (PCIE + 0x000000000898)
+#define PCIE_CFG_REG_PL102_GEN3_EQ_POST_CURSOR_PSET_SHIFT 12
+#define PCIE_CFG_REG_PL102_GEN3_EQ_CURSOR_PSET_SHIFT 6
+#define PCIE_CFG_REG_PL102_GEN3_EQ_PRE_CURSOR_PSET_SHIFT 0
+#define PCIE_CFG_REG_PL103 (PCIE + 0x00000000089C)
+#define PCIE_CFG_REG_PL105 (PCIE + 0x0000000008A4)
+#define PCIE_CFG_REG_PL105_GEN3_EQ_VIOLATE_COEF_RULES_SMASK 0x1ull
+#define PCIE_CFG_REG_PL2_LOW_PWR_ENT_CNT_SHIFT 24
+#define PCIE_CFG_REG_PL100 (PCIE + 0x000000000890)
+#define PCIE_CFG_REG_PL100_EQ_EIEOS_CNT_SMASK 0x400ull
+#define PCIE_CFG_REG_PL101 (PCIE + 0x000000000894)
+#define PCIE_CFG_REG_PL101_GEN3_EQ_LOCAL_FS_SHIFT 6
+#define PCIE_CFG_REG_PL101_GEN3_EQ_LOCAL_LF_SHIFT 0
+#define PCIE_CFG_REG_PL106 (PCIE + 0x0000000008A8)
+#define PCIE_CFG_REG_PL106_GEN3_EQ_PSET_REQ_VEC_SHIFT 8
+#define PCIE_CFG_REG_PL106_GEN3_EQ_EVAL2MS_DISABLE_SMASK 0x20ull
+#define PCIE_CFG_REG_PL106_GEN3_EQ_PHASE23_EXIT_MODE_SMASK 0x10ull
+#define CCE_INT_BLOCKED (CCE + 0x000000110C00)
+#define SEND_DMA_IDLE_CNT (TXE + 0x000000200040)
+#define SEND_DMA_DESC_FETCHED_CNT (TXE + 0x000000200058)
+#define CCE_MSIX_PBA_OFFSET 0X0110000
+
+#endif          /* DEF_CHIP_REG */
diff --git a/drivers/infiniband/hw/hfi2/chip_registers_jkr.h b/drivers/infiniband/hw/hfi2/chip_registers_jkr.h
new file mode 100644
index 000000000000..ddc9c12f00c6
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/chip_registers_jkr.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023 Cornelis Networks
+ */
+
+#ifndef _CHIP_REGISTERS_JKR_H
+#define _CHIP_REGISTERS_JKR_H
+
+/*
+ * Definitions in this file were generated from the spec document.
+ */
+
+/* top level block offsets */
+#define JKR_CCE     0x0000000
+#define JKR_MCTXT   0x0200000
+#define JKR_ASIC    0x0400000
+#define JKR_MISC    0x0500000
+#define JKR_RXE     0x1000000
+#define JKR_TXE     0x1800000
+
+#define JKR_C_CCE_NUM_INT_CSRS 21
+#define JKR_C_CCE_NUM_INT_MAP_CSRS 168
+#define JKR_C_CCE_SI_INT_ENABLES_STRIDE 4096
+#define JKR_C_CCE_OTHER_INT_CNT 0
+#define JKR_C_CCE_PBC_ERR_INT_CNT 6
+#define JKR_C_CCE_PIO_ERR_INT_CNT 7
+#define JKR_C_CCE_SDMA_ERR_INT_CNT 8
+#define JKR_C_CCE_CSR_ERR_INT_CNT 9
+#define JKR_CCE_ERR_STATUS (JKR_CCE + 0x000000000040)
+#define JKR_CCE_ERR_MASK (JKR_CCE + 0x000000000048)
+#define JKR_CCE_ERR_CLEAR (JKR_CCE + 0x000000000050)
+#define JKR_CCE_SPC_FREEZE_INT_STATUS (JKR_CCE + 0x000000000128)
+#define JKR_CCE_SPC_FREEZE_INT_MASK (JKR_CCE + 0x000000000130)
+#define JKR_CCE_SPC_FREEZE_INT_CLEAR (JKR_CCE + 0x000000000138)
+#define JKR_CCE_SI_INT_ENABLES (JKR_CCE + 0x000000080000)
+#define JKR_CCE_MSIX_INT_MAP_VEC (JKR_CCE + 0x000000120000)
+#define JKR_SEND_PIO_ERR_STATUS (JKR_CCE + 0x000000110F08)
+#define JKR_SEND_PIO_ERR_MASK (JKR_CCE + 0x000000110F10)
+#define JKR_SEND_PIO_ERR_CLEAR (JKR_CCE + 0x000000110F18)
+#define JKR_SEND_DMA_ERR_STATUS (JKR_CCE + 0x000000110F28)
+#define JKR_SEND_DMA_ERR_MASK (JKR_CCE + 0x000000110F30)
+#define JKR_SEND_DMA_ERR_CLEAR (JKR_CCE + 0x000000110F38)
+#define JKR_CSR_ERR_STATUS (JKR_CCE + 0x000000110F48)
+#define JKR_CSR_ERR_MASK (JKR_CCE + 0x000000110F50)
+#define JKR_CSR_ERR_CLEAR (JKR_CCE + 0x000000110F58)
+#define JKR_C_MCTXT_MEM_SIZE_IN_QWORDS 256
+#define JKR_MCTXT_CPORT_IN (JKR_MCTXT + 0x000000000000)
+#define JKR_MCTXT_CPORT_OUT (JKR_MCTXT + 0x000000002000)
+#define JKR_MCTXT_CPORT_INT_STATUS (JKR_MCTXT + 0x000000004000)
+#define JKR_MCTXT_CPORT_INT_ACK (JKR_MCTXT + 0x000000004018)
+#define JKR_MCTXT_PF0_INT_STATUS (JKR_MCTXT + 0x000000004020)
+#define JKR_MCTXT_PF0_INT_ENABLE (JKR_MCTXT + 0x000000004028)
+#define JKR_MCTXT_PF0_INT_STATUS_ENABLED (JKR_MCTXT + 0x000000004030)
+#define JKR_MCTXT_PF0_INT_ACK (JKR_MCTXT + 0x000000004038)
+#define JKR_ASIC_CFG_SCRATCH (JKR_ASIC + 0x000000000020)
+#define JKR_ASIC_ERR_STATUS (JKR_ASIC + 0x000000002000)
+#define JKR_ASIC_ERR_MASK (JKR_ASIC + 0x000000002008)
+#define JKR_ASIC_ERR_CLEAR (JKR_ASIC + 0x000000002010)
+#define JKR_C_RXE_RCV_ARRAY_EGR_BASE 67108864
+#define JKR_C_RXE_UCTXT_STRIDE 8192
+#define JKR_C_RXE_KCTXT_STRIDE 8192
+#define JKR_C_RXE_RCTXT_STRIDE 256
+#define JKR_C_RXE_IPORT_STRIDE 65536
+#define JKR_C_RXE_NUM_RSM_INSTANCES 32
+#define JKR_RCV_IPORT_CTRL (JKR_RXE + 0x000000020000)
+#define JKR_RCV_IPORT_STATUS (JKR_RXE + 0x000000020008)
+#define JKR_RCV_BTH_QP (JKR_RXE + 0x000000020028)
+#define JKR_RCV_MULTICAST (JKR_RXE + 0x000000020030)
+#define JKR_RCV_BYPASS (JKR_RXE + 0x000000020038)
+#define JKR_RCV_VL15 (JKR_RXE + 0x000000020048)
+#define JKR_RCV_ERR_INFO (JKR_RXE + 0x000000020050)
+#define JKR_RCV_ERR_STATUS (JKR_RXE + 0x000000020060)
+#define JKR_RCV_ERR_MASK (JKR_RXE + 0x000000020068)
+#define JKR_RCV_ERR_CLEAR (JKR_RXE + 0x000000020070)
+#define JKR_RCV_QP_MAP_TABLE (JKR_RXE + 0x000000020100)
+#define JKR_RCV_PARTITION_KEY (JKR_RXE + 0x000000028000)
+#define JKR_RCV_COUNTER_ARRAY32 (JKR_RXE + 0x000000020400)
+#define JKR_RCV_COUNTER_ARRAY64 (JKR_RXE + 0x000000020500)
+#define JKR_RCV_KCTXT_CTRL (JKR_RXE + 0x000000200000)
+#define JKR_RCV_KCTXT_CTRL_RECEIVE_CUT_THROUGH_DISABLE_SMASK 0x800ull
+#define JKR_RCV_EGR_CTRL (JKR_RXE + 0x000000010008)
+#define JKR_RCV_EGR_CTRL_EGR_CNT_SHIFT 32
+#define JKR_RCV_EGR_CTRL_EGR_CNT_MASK 0xFFFull
+#define JKR_RCV_EGR_CTRL_EGR_BASE_INDEX_SHIFT 0
+#define JKR_RCV_EGR_CTRL_EGR_BASE_INDEX_MASK 0x3FFFull
+#define JKR_RCV_TID_CTRL (JKR_RXE + 0x000000010010)
+#define JKR_RCV_TID_CTRL_TID_PAIR_CNT_SHIFT 32
+#define JKR_RCV_TID_CTRL_TID_PAIR_CNT_MASK 0x1FFull
+#define JKR_RCV_TID_CTRL_TID_BASE_INDEX_SHIFT 0
+#define JKR_RCV_TID_CTRL_TID_BASE_INDEX_MASK 0x3FFFull
+#define JKR_RCV_JKEY_CTRL (JKR_RXE + 0x000000023000)
+#define JKR_RCV_HDR_ADDR (JKR_RXE + 0x000000200028)
+#define JKR_RCV_HDR_CNT (JKR_RXE + 0x000000200030)
+#define JKR_RCV_HDR_ENT_SIZE (JKR_RXE + 0x000000200038)
+#define JKR_RCV_HDR_TAIL_ADDR (JKR_RXE + 0x000000200048)
+#define JKR_RCV_AVAIL_TIME_OUT (JKR_RXE + 0x000000200050)
+#define JKR_RCV_HDR_OVFL_CNT (JKR_RXE + 0x000000200058)
+#define JKR_RCV_ERR_ADDR (JKR_RXE + 0x000000200060)
+#define JKR_RCV_RCTXT_CTRL (JKR_RXE + 0x000000010000)
+#define JKR_RCV_SI_IDX (JKR_RXE + 0x000000010030)
+#define JKR_RCV_PKT_CTRL (JKR_RXE + 0x000000022000)
+#define JKR_RCV_PKT_CTRL_RCV_PORT_ENABLE_SMASK 0x8000000000000000ull
+#define JKR_RCV_PKT_CTRL_CONTEXT_ENABLED_SMASK 0x2000000000000000ull
+#define JKR_RCV_PKT_CTRL_L2_TYPE_ENABLE_MASK_SHIFT 56
+#define JKR_RCV_PKT_CTRL_L2_TYPE_ENABLE_MASK_SMASK 0xF00000000000000ull
+#define JKR_RCV_PKT_CTRL_HDR_SIZE_SHIFT 24
+#define JKR_RCV_PKT_CTRL_HDR_SIZE_SMASK 0x1F000000ull
+#define JKR_RCV_TID_PAIR_COUNT (JKR_RXE + 0x000000024000)
+#define JKR_RCV_ARRAY_EGR_RT_BUF_SIZE_SHIFT 46
+#define JKR_RCV_HDR_TAIL (JKR_RXE + 0x000000600000)
+#define JKR_RCV_HDR_HEAD (JKR_RXE + 0x000000600008)
+#define JKR_RCV_EGR_INDEX_HEAD (JKR_RXE + 0x000000600018)
+#define JKR_RCV_TID_FLOW_TABLE (JKR_RXE + 0x000000600800)
+#define JKR_RCV_CTXT_STATUS (JKR_RXE + 0x000000600028)
+#define JKR_C_TXE_EPORT_STRIDE 65536
+#define JKR_C_TXE_SCTXT_STRIDE 8192
+#define JKR_C_TXE_SDMA_STRIDE 8192
+#define JKR_C_TXE_PIO_SEND_OFFSET 8388608
+#define JKR_SEND_CTRL (JKR_TXE + 0x000000380000)
+#define JKR_SEND_CTRL_FLUSH_WRONG_LINK_STATE_SMASK 0x8000000000000000ull
+#define JKR_SEND_CONTEXTS (JKR_TXE + 0x000000300010)
+#define JKR_SEND_DMA_ENGINES (JKR_TXE + 0x000000300018)
+#define JKR_SEND_PIO_MEM_SIZE (JKR_TXE + 0x000000300020)
+#define JKR_SEND_DMA_MEM_SIZE (JKR_TXE + 0x000000300028)
+#define JKR_SEND_HIGH_PRIORITY_LIMIT (JKR_TXE + 0x000000380008)
+#define JKR_SEND_PIO_INIT_CTXT (JKR_TXE + 0x000000300038)
+#define JKR_SEND_EGRESS_ERR_STATUS (JKR_TXE + 0x000000380010)
+#define JKR_SEND_EGRESS_ERR_MASK (JKR_TXE + 0x000000380018)
+#define JKR_SEND_EGRESS_ERR_CLEAR (JKR_TXE + 0x000000380020)
+#define JKR_SEND_BTH_QP (JKR_TXE + 0x000000380030)
+#define JKR_SEND_STATIC_RATE_CONTROL (JKR_TXE + 0x000000380038)
+#define JKR_SEND_SC2VLT0 (JKR_TXE + 0x000000380040)
+#define JKR_SEND_SC2VLT1 (JKR_TXE + 0x000000380048)
+#define JKR_SEND_SC2VLT2 (JKR_TXE + 0x000000380050)
+#define JKR_SEND_SC2VLT3 (JKR_TXE + 0x000000380058)
+#define JKR_SEND_LEN_CHECK0 (JKR_TXE + 0x000000380060)
+#define JKR_SEND_LEN_CHECK1 (JKR_TXE + 0x000000380068)
+#define JKR_SEND_LOW_PRIORITY_LIST (JKR_TXE + 0x000000380100)
+#define JKR_SEND_HIGH_PRIORITY_LIST (JKR_TXE + 0x000000380180)
+#define JKR_SEND_COUNTER_ARRAY32 (JKR_TXE + 0x000000380300)
+#define JKR_SEND_COUNTER_ARRAY64 (JKR_TXE + 0x000000380400)
+#define JKR_SEND_CM_CTRL (JKR_TXE + 0x000000380500)
+#define JKR_SEND_CM_GLOBAL_CREDIT (JKR_TXE + 0x000000380508)
+#define JKR_SEND_CM_CREDIT_USED_STATUS (JKR_TXE + 0x000000380510)
+#define JKR_SEND_CM_TIMER_CTRL (JKR_TXE + 0x000000380518)
+#define JKR_SEND_CM_LOCAL_AU_TABLE0_TO3 (JKR_TXE + 0x000000380520)
+#define JKR_SEND_CM_LOCAL_AU_TABLE4_TO7 (JKR_TXE + 0x000000380528)
+#define JKR_SEND_CM_REMOTE_AU_TABLE0_TO3 (JKR_TXE + 0x000000380530)
+#define JKR_SEND_CM_REMOTE_AU_TABLE4_TO7 (JKR_TXE + 0x000000380538)
+#define JKR_SEND_CM_CREDIT_VL (JKR_TXE + 0x000000380600)
+#define JKR_SEND_CM_CREDIT_VL15 (JKR_TXE + 0x000000380678)
+#define JKR_SEND_EGRESS_ERR_INFO (JKR_TXE + 0x000000380F00)
+#define JKR_SEND_EGRESS_ERR_INFO_TOO_LONG_PACKET_ERR9B_SMASK 0x800000000ull
+#define JKR_SEND_EGRESS_ERR_INFO_VL_MAPPING_ERR9B_SMASK 0x8000000ull
+#define JKR_SEND_EGRESS_ERR_INFO_VL_ERR9B_SMASK 0x80ull
+#define JKR_SEND_EGRESS_ERR_SOURCE (JKR_TXE + 0x000000380F08)
+#define JKR_SEND_CTXT_CTRL (JKR_TXE + 0x000000340000)
+#define JKR_SEND_CTXT_STATUS (JKR_TXE + 0x000000000008)
+#define JKR_SEND_CTXT_CREDIT_CTRL (JKR_TXE + 0x000000000010)
+#define JKR_SEND_CTXT_CREDIT_STATUS (JKR_TXE + 0x000000000018)
+#define JKR_SEND_CTXT_CREDIT_RETURN_ADDR (JKR_TXE + 0x000000000020)
+#define JKR_SEND_CTXT_CREDIT_FORCE (JKR_TXE + 0x000000000028)
+#define JKR_SEND_CTXT_ERR_STATUS (JKR_TXE + 0x000000000030)
+#define JKR_SEND_CTXT_ERR_MASK (JKR_TXE + 0x000000000038)
+#define JKR_SEND_CTXT_ERR_CLEAR (JKR_TXE + 0x000000000040)
+#define JKR_SEND_CTXT_CHECK_ENABLE (JKR_TXE + 0x000000381000)
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BTOO_LONG_PACKET_SMASK 0x8000000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BTOO_SMALL_PACKETS_SMASK 0x4000000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BNON_KDETH_PACKETS_SMASK 0x2000000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BKDETH_PACKETS_SMASK 0x1000000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BBAD_PKT_LEN_SMASK 0x800000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BGRH_SMASK 0x400000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BRAW_IPV6_SMASK 0x200000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BRAW_SMASK 0x100000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW9BPBC_TEST_SMASK 0x80000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BVL_MAPPING_SMASK 0x40000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BOPCODE_SMASK 0x20000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BSLID_SMASK 0x10000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BPARTITION_KEY_SMASK 0x8000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BJOB_KEY_SMASK 0x4000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK9BVL_SMASK 0x2000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_L2_TYPE9BALLOWED_SMASK 0x1000000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BTOO_LONG_PACKET_SMASK 0x800000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BTOO_SMALL_PACKETS_SMASK 0x400000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BNON_KDETH_PACKETS_SMASK 0x200000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BKDETH_PACKETS_SMASK 0x100000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BBAD_PKT_LEN_SMASK 0x80000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BGRH_SMASK 0x40000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BRAW_IPV6_SMASK 0x20000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BRAW_SMASK 0x10000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_DISALLOW16BPBC_TEST_SMASK 0x8000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BVL_MAPPING_SMASK 0x4000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BOPCODE_SMASK 0x2000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BSLID_SMASK 0x1000000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BPARTITION_KEY_SMASK 0x800000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BJOB_KEY_SMASK 0x400000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_CHECK16BVL_SMASK 0x200000000ull
+#define JKR_SEND_CTXT_CHECK_ENABLE_L2_TYPE16BALLOWED_SMASK 0x100000000ull
+#define JKR_SEND_CTXT_CHECK_VL (JKR_TXE + 0x000000382000)
+#define JKR_SEND_CTXT_CHECK_JOB_KEY (JKR_TXE + 0x000000383000)
+#define JKR_SEND_CTXT_CHECK_PARTITION_KEY (JKR_TXE + 0x000000384000)
+#define JKR_SEND_CTXT_CHECK_SLID (JKR_TXE + 0x000000385000)
+#define JKR_SEND_CTXT_CHECK_OPCODE (JKR_TXE + 0x000000386000)
+#define JKR_SEND_CTXT_SI_IDX (JKR_TXE + 0x000000341000)
+#define JKR_SEND_EGRESS_CTXT_STATUS (JKR_TXE + 0x000000388000)
+#define JKR_SEND_DMA_CTRL (JKR_TXE + 0x000000200000)
+#define JKR_SEND_DMA_STATUS (JKR_TXE + 0x000000200008)
+#define JKR_SEND_DMA_BASE_ADDR (JKR_TXE + 0x000000200010)
+#define JKR_SEND_DMA_LEN_GEN (JKR_TXE + 0x000000200018)
+#define JKR_SEND_DMA_TAIL (JKR_TXE + 0x000000200020)
+#define JKR_SEND_DMA_HEAD (JKR_TXE + 0x000000200028)
+#define JKR_SEND_DMA_HEAD_ADDR (JKR_TXE + 0x000000200030)
+#define JKR_SEND_DMA_PRIORITY_THLD (JKR_TXE + 0x000000200038)
+#define JKR_SEND_DMA_IDLE_CNT (JKR_TXE + 0x000000200040)
+#define JKR_SEND_DMA_RELOAD_CNT (JKR_TXE + 0x000000200048)
+#define JKR_SEND_DMA_DESC_CNT (JKR_TXE + 0x000000200050)
+#define JKR_SEND_DMA_DESC_FETCHED_CNT (JKR_TXE + 0x000000200058)
+#define JKR_SEND_DMA_ENG_ERR_STATUS (JKR_TXE + 0x000000200060)
+#define JKR_SEND_DMA_ENG_ERR_MASK (JKR_TXE + 0x000000200068)
+#define JKR_SEND_DMA_ENG_ERR_CLEAR (JKR_TXE + 0x000000200070)
+#define JKR_SEND_DMA_CFG_MEMORY (JKR_TXE + 0x000000300B00)
+#define JKR_SEND_EGRESS_SEND_DMA_STATUS (JKR_TXE + 0x000000389000)
+
+#endif /* _CHIP_REGISTERS_JKR_H */



