Return-Path: <linux-rdma+bounces-11774-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3185AEE639
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55C14189C6B8
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F732D320B;
	Mon, 30 Jun 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="j5u+Avyu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020118.outbound.protection.outlook.com [52.101.56.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E272E6D11
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306298; cv=fail; b=azfq+T8RibtZzMzfxIeQ06DX7/wHji1oQ0rKW2ijX++7NcqIZ6MSXLQ4E3Ql6EWS2J+iF+xc+8nkjpvsUgSnIKZVNNluhCw92V0DXc2T1s+r4B3++YJLDMlv8hNZkXcb23j/Jxel7e892por4HK+Rw41C122QLosDFlGsTQSaI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306298; c=relaxed/simple;
	bh=3hyKKMcUSus0Sf4PsVxasXzsU7cUqp7K1CoUSiq7sIY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bImorxzA+BLzkQyf9jQU27esA/HnzAUDkLfNV94a8XIxPlHlLOkYFNXCkEZC9OMukhnWAoAxkGDnP/mxBxtCGX1lmnTC/ceXD8Xhyj+p1sSNINdJDAuD6fUWeDjqvsPnTCC8KbY/bSHWRctW7LbIlGBduQ8rQk2A0n37bZS83Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=j5u+Avyu; arc=fail smtp.client-ip=52.101.56.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNz14gLBHGu8YcwDNJphj8yhKJCELY+Pmu5xzWVaxhiDS7vRSEYOYqiXu0dDnBpDYT2PDV5QGVU4wtaEEtUnSfWYOXVRl5YFXCgRiDzP8E8tpisC2iULwXrJU65/I48ebFtGpp3NnC2H6p8lrGLJeufpbObBA5vvLqQsd5LPMcg+nOdM2zG7BKf44Nqd3J4nw6WgAH2fSCrGz3zzubKgqDJOjfDCez8QD0KS23lNmr+18OF6DXniMSi12d/uOVMs14wr9eH1W3+TQwjDwOYPLoJihzWvbcEcXEXZfkLgswZckR2cG7kYoTf2pBgSFcKmpHd2DwB0LRtz+XXcctd3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzeC3QdgVqSRUy2RUI1ImOTsNG1yo+RIkCTho7HnAf8=;
 b=JpPwkAI28TfIWDTlWnleklm2YPok9pQs3U5xDpYdcX9W6YUWut2Am38IubusBHHCteXZVi++SssZK/kK/WSy9jAyzyHEcvdTCopOwgWZSGEPGQMnN19PCIq+9BAtvS7Bd+R42EUmoIS84DxeZa/M+btRIYk/y6cHUk6CYiK/6NOLRG0PQoXltdJmX/27hUsz3+sdTmS/Wtyu8xPFaUQUjRI2DCVEAYF8ojZQishZxVNewtRAjhoUKsDU6a8REoS1aIaVURiSbLaZfyg/gMLevV9pkGkp//refm1u7Yimc/h9uQflN2n3CP1foEu0V52WFK4c1xKAIEzwEVNz0cjldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzeC3QdgVqSRUy2RUI1ImOTsNG1yo+RIkCTho7HnAf8=;
 b=j5u+AvyuODVfXTfYCqQ6kyhtPKicYXBFe5KPoxr2YyYex3ReAH9+AsZ36DAC3gygI2QIQmAQvnw7NW6tpwi7jfesOMuzOICHFjDyXpk97a1+Qbs36DTM7aV1Q+diI2qdAA85wDoME3S606EbCbjCZoRgpzKIgL26zISAAoo2jzx69zU6sDM0LqKgN2+8ZNzY0YM6hdCGMfl57WYUIST22QF5pSFra+4NtEyK7Rv5aIKKkYxOX4WB2/3ItarQwI6+sSSE7IU2OLOgrgjhwLzy7E2wGIxuI+bytkUaI2btIiWix9HgLU4ssRHRmZ6kP993daz8DrXfNVVwXy7GFCFTTw==
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by BY3PR01MB6561.prod.exchangelabs.com (2603:10b6:a03:362::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.29; Mon, 30 Jun 2025 17:58:11 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::33) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.29 via Frontend Transport; Mon,
 30 Jun 2025 17:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:09 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id C534D14D722;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 58F3F1848B5D1;
	Mon, 30 Jun 2025 11:30:48 -0400 (EDT)
Subject: [PATCH for-next 12/23] RDMA/hfi2: Add in trace support
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:48 -0400
Message-ID:
 <175129744832.1859400.5445209715015307475.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|BY3PR01MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 8545cf35-8809-4289-63c1-08ddb7ffac92
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z0p0aG9TTTJkVjFmUFhGRzdsQlEzMUIyeTJPL1o5bnBwWE5rYllHQS8yTWg0?=
 =?utf-8?B?dTNjbWVmc2pYU2NHa3lTajYrOHRxWm51RitGWG9EVEY0VEhrZ3c2ZG1zVmIy?=
 =?utf-8?B?TlozWkxhQ3FWQ0VsU0NwMWFnKzMvaXEyRnVXeFJQQnMxZ0dDamFCaEtFWXN1?=
 =?utf-8?B?Z2Z4eWc0L092VkNsbnhJYWJNeEx4dkFZdk1qcExzVE9mR3FQWkRaSEhvWUM4?=
 =?utf-8?B?NjJlRC9mYVdyOHpicjNXbGUvRWN0U2NhNUtFY0hLVktSellrUUQwZkFzT1F0?=
 =?utf-8?B?NlBCMC9xY2s5YjRhVFBJcHhjTXJibmtLazI4anJQTzFXYWVnNjJYNDRQWTE1?=
 =?utf-8?B?bEp4REozL2JSNG1XUThLd3Zwamc2Qi9MMEhyandwcVpnYWRrVHVLTFZTYzJY?=
 =?utf-8?B?bmRNbmVIMzZPYjhOWm1hak5FUTJocVlUakI1dUxlR1c2MUIzSXlONHIycXNj?=
 =?utf-8?B?SDhZVjVqMlgzclkvQnJrK1ZBZk4vOVU3dkJFR0dOeU1BWGdseUtldWpEdnhN?=
 =?utf-8?B?REE0TmpvRDN1U3NoMGFDc0dvamVoMmp6N1VLVUFqdTZkcDRpdzBFUEVScnFL?=
 =?utf-8?B?WUdKVEw5ZVorZ2RDUHg2Ynd4T2p6OS8zb3ZJMVVMalAralRRYldQMEZ0YW9P?=
 =?utf-8?B?V0JIN3hwMi81VnV2THBIdDlWNlpEcDZyTlVWNSs3enpmWXowQzU3MjdwOVhF?=
 =?utf-8?B?MnlwOXNXQkcvZll2NG9rSW1LbXRjOGFEejNzNno5VlF5MWhhMUpIMEFlOTFK?=
 =?utf-8?B?NVpkV0Jvd0oyR0lvc0tmR2dDT3p4Qm81VGMvRlhBYzkzSS9WUkdvTzVUQmta?=
 =?utf-8?B?Z2JiYUdtbHZMS3U4T282OXFsaC9hYjg3bFVkaEExeFVXbUpITDdGcDhQbHk0?=
 =?utf-8?B?LzFPMjNybFo4S1VnNlpDWVRMVnZIbnRxTDl0WDRkeW0yMXk2V1g5cGsxMk1L?=
 =?utf-8?B?TGQ5Tzg1b01RSkVyWW5zRVB0SUkwbno3TmFUYXhvRmhtRWZybFNTNVcxUU0w?=
 =?utf-8?B?ZGJmQmR6dmhzS3hET3VYNFFxSFhaaGxDTy9iK1U2SDNwelJHdUdDQStnNlU3?=
 =?utf-8?B?blBkbE11SXQvUDd0UjNZVXVFaC9RTFZTeFVlaUV1ckN6SzlsdC9uN3JwZWxM?=
 =?utf-8?B?U2hESTNWRFpZOE5USGlPRGtCS3U0dXVqRFRaL0VwdW9SR3N1a1BoamRvU3Bo?=
 =?utf-8?B?MlU5RHhzUUhEN3JBbmNGd3AzUHp4T0VhbFR1UjJXWVJ0b3NrSXR5T3JsMHA3?=
 =?utf-8?B?VEUzekNtd0RaR0ZHSFlMckdSZnlJaWJ4b1V4SDRSdlN6Rm8zYkFYak9FY042?=
 =?utf-8?B?SzM0M3Rha3cwaGYwYU9DdzVYMU52eFBtR05CQTZGT2RrOHBVa0QwYmdKTkJj?=
 =?utf-8?B?WW1yV3oyay92aThCZkhqazZCbHpvbXhvTjBzRzdWclVjZlk2OWNsWldMM2dk?=
 =?utf-8?B?eUE3cmJDeER6TU5Yb21tVXNpcTF0WjJZTGpLY2Q2VkMySmRtTTM2VUZrdlZq?=
 =?utf-8?B?bmRKQ3lBN2tvQ29DNWEzZEhudHJWU1BLeHR0dVpuMVZIYXcxd3UvUThBSEkz?=
 =?utf-8?B?eFl6UTRXYzA5dWFlT0xzRVFVSERTczRJSm9uVUw0ZXNuMDlLdERsRk9zclFr?=
 =?utf-8?B?QTZtVFRWUzFBVms5TXUyQytiT1BWaVZpdG1RbUJlTEgwaks5Y0svZXJaSEhp?=
 =?utf-8?B?TnFrRFE3Z3JWelUzWlJLVkR4b2o1RmlKMURWb3ZCT0l4aXByUWdwY1RFaVJ0?=
 =?utf-8?B?alY3YlFNbVdqQVBaaE5OcEtoVHNLTHlUUGNWaUMvZ3d4d2puYkpDRGI1SGt0?=
 =?utf-8?B?akZXK3NXeWpsTjNCZnVGcDYvdVp3d2x1VmZ6ZGdicFJuNEpuak85MDEwMTZx?=
 =?utf-8?B?Tk9lS2hlMW00WUowazk0L2QzZEVaTmtZU1g2SjdWdFhKdk53aUQ0bVByWGp2?=
 =?utf-8?B?R0YyZkdKRzVTbDBGU2VlOUxkN2p2U2Mwa0M5NE1lcHorbXNBN0tXd2dIblNk?=
 =?utf-8?B?VWpXWnFFeVRtRGI1Z20wS21kQWpmVGNrMDl6R0VpcUh5cklqTTZiOVVsK3lm?=
 =?utf-8?Q?GieF1x?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:09.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8545cf35-8809-4289-63c1-08ddb7ffac92
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6561

Adds the base trace even support for the driver.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/trace.c |  535 ++++++++++++++++++++++++++++++++++++
 1 file changed, 535 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/trace.c

diff --git a/drivers/infiniband/hw/hfi2/trace.c b/drivers/infiniband/hw/hfi2/trace.c
new file mode 100644
index 000000000000..0a117d1692b9
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace.c
@@ -0,0 +1,535 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ */
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+#include "exp_rcv.h"
+#include "ipoib.h"
+
+static u8 __get_ib_hdr_len(struct ib_header *hdr)
+{
+	struct ib_other_headers *ohdr;
+	u8 opcode;
+
+	if (ib_get_lnh(hdr) == HFI2_LRH_BTH)
+		ohdr = &hdr->u.oth;
+	else
+		ohdr = &hdr->u.l.oth;
+	opcode = ib_bth_get_opcode(ohdr);
+	return hdr_len_by_opcode[opcode] == 0 ?
+	       0 : hdr_len_by_opcode[opcode] - (12 + 8);
+}
+
+static u8 __get_16b_hdr_len(struct hfi2_16b_header *hdr)
+{
+	struct ib_other_headers *ohdr = NULL;
+	u8 opcode;
+	u8 l4 = hfi2_16B_get_l4(hdr);
+
+	if (l4 == OPA_16B_L4_FM) {
+		opcode = IB_OPCODE_UD_SEND_ONLY;
+		return (8 + 8); /* No BTH */
+	}
+
+	if (l4 == OPA_16B_L4_IB_LOCAL)
+		ohdr = &hdr->u.oth;
+	else
+		ohdr = &hdr->u.l.oth;
+
+	opcode = ib_bth_get_opcode(ohdr);
+	return hdr_len_by_opcode[opcode] == 0 ?
+	       0 : hdr_len_by_opcode[opcode] - (12 + 8 + 8);
+}
+
+u8 hfi2_trace_packet_hdr_len(struct hfi2_packet *packet)
+{
+	if (packet->etype != RHF_RCV_TYPE_BYPASS)
+		return __get_ib_hdr_len(packet->hdr);
+	else
+		return __get_16b_hdr_len(packet->hdr);
+}
+
+u8 hfi2_trace_opa_hdr_len(struct hfi2_opa_header *opa_hdr)
+{
+	if (!opa_hdr->hdr_type)
+		return __get_ib_hdr_len(&opa_hdr->ibh);
+	else
+		return __get_16b_hdr_len(&opa_hdr->opah);
+}
+
+const char *hfi2_trace_get_packet_l4_str(u8 l4)
+{
+	if (l4)
+		return "16B";
+	else
+		return "9B";
+}
+
+const char *hfi2_trace_get_packet_l2_str(u8 l2)
+{
+	switch (l2) {
+	case 0:
+		return "0";
+	case 1:
+		return "1";
+	case 2:
+		return "16B";
+	case 3:
+		return "9B";
+	}
+	return "";
+}
+
+#define IMM_PRN  "imm:%d"
+#define RETH_PRN "reth vaddr:0x%.16llx rkey:0x%.8x dlen:0x%.8x"
+#define AETH_PRN "aeth syn:0x%.2x %s msn:0x%.8x"
+#define DETH_PRN "deth qkey:0x%.8x sqpn:0x%.6x"
+#define DETH_ENTROPY_PRN "deth qkey:0x%.8x sqpn:0x%.6x entropy:0x%.2x"
+#define IETH_PRN "ieth rkey:0x%.8x"
+#define ATOMICACKETH_PRN "origdata:%llx"
+#define ATOMICETH_PRN "vaddr:0x%llx rkey:0x%.8x sdata:%llx cdata:%llx"
+#define TID_RDMA_KDETH "kdeth0 0x%x kdeth1 0x%x"
+#define TID_RDMA_KDETH_DATA "kdeth0 0x%x: kver %u sh %u intr %u tidctrl %u tid %x offset %x kdeth1 0x%x: jkey %x"
+#define TID_READ_REQ_PRN "tid_flow_psn 0x%x tid_flow_qp 0x%x verbs_qp 0x%x"
+#define TID_READ_RSP_PRN "verbs_qp 0x%x"
+#define TID_WRITE_REQ_PRN "original_qp 0x%x"
+#define TID_WRITE_RSP_PRN "tid_flow_psn 0x%x tid_flow_qp 0x%x verbs_qp 0x%x"
+#define TID_WRITE_DATA_PRN "verbs_qp 0x%x"
+#define TID_ACK_PRN "tid_flow_psn 0x%x verbs_psn 0x%x tid_flow_qp 0x%x verbs_qp 0x%x"
+#define TID_RESYNC_PRN "verbs_qp 0x%x"
+
+#define OP(transport, op) IB_OPCODE_## transport ## _ ## op
+
+static const char *parse_syndrome(u8 syndrome)
+{
+	switch (syndrome >> 5) {
+	case 0:
+		return "ACK";
+	case 1:
+		return "RNRNAK";
+	case 3:
+		return "NAK";
+	}
+	return "";
+}
+
+void hfi2_trace_parse_9b_bth(struct ib_other_headers *ohdr,
+			     u8 *ack, bool *becn, bool *fecn, u8 *mig,
+			     u8 *se, u8 *pad, u8 *opcode, u8 *tver,
+			     u16 *pkey, u32 *psn, u32 *qpn)
+{
+	*ack = ib_bth_get_ackreq(ohdr);
+	*becn = ib_bth_get_becn(ohdr);
+	*fecn = ib_bth_get_fecn(ohdr);
+	*mig = ib_bth_get_migreq(ohdr);
+	*se = ib_bth_get_se(ohdr);
+	*pad = ib_bth_get_pad(ohdr);
+	*opcode = ib_bth_get_opcode(ohdr);
+	*tver = ib_bth_get_tver(ohdr);
+	*pkey = ib_bth_get_pkey(ohdr);
+	*psn = mask_psn(ib_bth_get_psn(ohdr));
+	*qpn = ib_bth_get_qpn(ohdr);
+}
+
+void hfi2_trace_parse_16b_bth(struct ib_other_headers *ohdr,
+			      u8 *ack, u8 *mig, u8 *opcode,
+			      u8 *pad, u8 *se, u8 *tver,
+			      u32 *psn, u32 *qpn)
+{
+	*ack = ib_bth_get_ackreq(ohdr);
+	*mig = ib_bth_get_migreq(ohdr);
+	*opcode = ib_bth_get_opcode(ohdr);
+	*pad = ib_bth_get_pad(ohdr);
+	*se = ib_bth_get_se(ohdr);
+	*tver = ib_bth_get_tver(ohdr);
+	*psn = mask_psn(ib_bth_get_psn(ohdr));
+	*qpn = ib_bth_get_qpn(ohdr);
+}
+
+void hfi2_trace_parse_9b_hdr(struct ib_header *hdr, bool sc5,
+			     u8 *lnh, u8 *lver, u8 *sl, u8 *sc,
+			     u16 *len, u32 *dlid, u32 *slid)
+{
+	*lnh = ib_get_lnh(hdr);
+	*lver = ib_get_lver(hdr);
+	*sl = ib_get_sl(hdr);
+	*sc = ib_get_sc(hdr) | (sc5 << 4);
+	*len = ib_get_len(hdr);
+	*dlid = ib_get_dlid(hdr);
+	*slid = ib_get_slid(hdr);
+}
+
+void hfi2_trace_parse_16b_hdr(struct hfi2_16b_header *hdr,
+			      u8 *age, bool *becn, bool *fecn,
+			      u8 *l4, u8 *rc, u8 *sc,
+			      u16 *entropy, u16 *len, u16 *pkey,
+			      u32 *dlid, u32 *slid)
+{
+	*age = hfi2_16B_get_age(hdr);
+	*becn = hfi2_16B_get_becn(hdr);
+	*fecn = hfi2_16B_get_fecn(hdr);
+	*l4 = hfi2_16B_get_l4(hdr);
+	*rc = hfi2_16B_get_rc(hdr);
+	*sc = hfi2_16B_get_sc(hdr);
+	*entropy = hfi2_16B_get_entropy(hdr);
+	*len = hfi2_16B_get_len(hdr);
+	*pkey = hfi2_16B_get_pkey(hdr);
+	*dlid = hfi2_16B_get_dlid(hdr);
+	*slid = hfi2_16B_get_slid(hdr);
+}
+
+#define LRH_PRN "len:%d sc:%d dlid:0x%.4x slid:0x%.4x "
+#define LRH_9B_PRN "lnh:%d,%s lver:%d sl:%d"
+#define LRH_16B_PRN "age:%d becn:%d fecn:%d l4:%d " \
+		    "rc:%d sc:%d pkey:0x%.4x entropy:0x%.4x"
+const char *hfi2_trace_fmt_lrh(struct trace_seq *p, bool bypass,
+			       u8 age, bool becn, bool fecn, u8 l4,
+			       u8 lnh, const char *lnh_name, u8 lver,
+			       u8 rc, u8 sc, u8 sl, u16 entropy,
+			       u16 len, u16 pkey, u32 dlid, u32 slid)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	trace_seq_printf(p, LRH_PRN, len, sc, dlid, slid);
+
+	if (bypass)
+		trace_seq_printf(p, LRH_16B_PRN,
+				 age, becn, fecn, l4, rc, sc, pkey, entropy);
+
+	else
+		trace_seq_printf(p, LRH_9B_PRN,
+				 lnh, lnh_name, lver, sl);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+#define BTH_9B_PRN \
+	"op:0x%.2x,%s se:%d m:%d pad:%d tver:%d pkey:0x%.4x " \
+	"f:%d b:%d qpn:0x%.6x a:%d psn:0x%.8x"
+#define BTH_16B_PRN \
+	"op:0x%.2x,%s se:%d m:%d pad:%d tver:%d " \
+	"qpn:0x%.6x a:%d psn:0x%.8x"
+#define L4_FM_16B_PRN \
+	"op:0x%.2x,%s dest_qpn:0x%.6x src_qpn:0x%.6x"
+const char *hfi2_trace_fmt_rest(struct trace_seq *p, bool bypass, u8 l4,
+				u8 ack, bool becn, bool fecn, u8 mig,
+				u8 se, u8 pad, u8 opcode, const char *opname,
+				u8 tver, u16 pkey, u32 psn, u32 qpn,
+				u32 dest_qpn, u32 src_qpn)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (bypass)
+		if (l4 == OPA_16B_L4_FM)
+			trace_seq_printf(p, L4_FM_16B_PRN,
+					 opcode, opname, dest_qpn, src_qpn);
+		else
+			trace_seq_printf(p, BTH_16B_PRN,
+					 opcode, opname,
+					 se, mig, pad, tver, qpn, ack, psn);
+
+	else
+		trace_seq_printf(p, BTH_9B_PRN,
+				 opcode, opname,
+				 se, mig, pad, tver, pkey, fecn, becn,
+				 qpn, ack, psn);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
+const char *parse_everbs_hdrs(
+	struct trace_seq *p,
+	u8 opcode, u8 l4, u32 dest_qpn, u32 src_qpn,
+	void *ehdrs)
+{
+	union ib_ehdrs *eh = ehdrs;
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	if (l4 == OPA_16B_L4_FM) {
+		trace_seq_printf(p, "mgmt pkt");
+		goto out;
+	}
+
+	switch (opcode) {
+	/* imm */
+	case OP(RC, SEND_LAST_WITH_IMMEDIATE):
+	case OP(UC, SEND_LAST_WITH_IMMEDIATE):
+	case OP(RC, SEND_ONLY_WITH_IMMEDIATE):
+	case OP(UC, SEND_ONLY_WITH_IMMEDIATE):
+	case OP(RC, RDMA_WRITE_LAST_WITH_IMMEDIATE):
+	case OP(UC, RDMA_WRITE_LAST_WITH_IMMEDIATE):
+		trace_seq_printf(p, IMM_PRN,
+				 be32_to_cpu(eh->imm_data));
+		break;
+	/* reth + imm */
+	case OP(RC, RDMA_WRITE_ONLY_WITH_IMMEDIATE):
+	case OP(UC, RDMA_WRITE_ONLY_WITH_IMMEDIATE):
+		trace_seq_printf(p, RETH_PRN " " IMM_PRN,
+				 get_ib_reth_vaddr(&eh->rc.reth),
+				 be32_to_cpu(eh->rc.reth.rkey),
+				 be32_to_cpu(eh->rc.reth.length),
+				 be32_to_cpu(eh->rc.imm_data));
+		break;
+	/* reth */
+	case OP(RC, RDMA_READ_REQUEST):
+	case OP(RC, RDMA_WRITE_FIRST):
+	case OP(UC, RDMA_WRITE_FIRST):
+	case OP(RC, RDMA_WRITE_ONLY):
+	case OP(UC, RDMA_WRITE_ONLY):
+		trace_seq_printf(p, RETH_PRN,
+				 get_ib_reth_vaddr(&eh->rc.reth),
+				 be32_to_cpu(eh->rc.reth.rkey),
+				 be32_to_cpu(eh->rc.reth.length));
+		break;
+	case OP(RC, RDMA_READ_RESPONSE_FIRST):
+	case OP(RC, RDMA_READ_RESPONSE_LAST):
+	case OP(RC, RDMA_READ_RESPONSE_ONLY):
+	case OP(RC, ACKNOWLEDGE):
+		trace_seq_printf(p, AETH_PRN, be32_to_cpu(eh->aeth) >> 24,
+				 parse_syndrome(be32_to_cpu(eh->aeth) >> 24),
+				 be32_to_cpu(eh->aeth) & IB_MSN_MASK);
+		break;
+	case OP(TID_RDMA, WRITE_REQ):
+		trace_seq_printf(p, TID_RDMA_KDETH " " RETH_PRN " "
+				 TID_WRITE_REQ_PRN,
+				 le32_to_cpu(eh->tid_rdma.w_req.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.w_req.kdeth1),
+				 ib_u64_get(&eh->tid_rdma.w_req.reth.vaddr),
+				 be32_to_cpu(eh->tid_rdma.w_req.reth.rkey),
+				 be32_to_cpu(eh->tid_rdma.w_req.reth.length),
+				 be32_to_cpu(eh->tid_rdma.w_req.verbs_qp));
+		break;
+	case OP(TID_RDMA, WRITE_RESP):
+		trace_seq_printf(p, TID_RDMA_KDETH " " AETH_PRN " "
+				 TID_WRITE_RSP_PRN,
+				 le32_to_cpu(eh->tid_rdma.w_rsp.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.w_rsp.kdeth1),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.aeth) >> 24,
+				 parse_syndrome(/* aeth */
+					 be32_to_cpu(eh->tid_rdma.w_rsp.aeth)
+					 >> 24),
+				 (be32_to_cpu(eh->tid_rdma.w_rsp.aeth) &
+				  IB_MSN_MASK),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.tid_flow_psn),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.tid_flow_qp),
+				 be32_to_cpu(eh->tid_rdma.w_rsp.verbs_qp));
+		break;
+	case OP(TID_RDMA, WRITE_DATA_LAST):
+	case OP(TID_RDMA, WRITE_DATA):
+		trace_seq_printf(p, TID_RDMA_KDETH_DATA " " TID_WRITE_DATA_PRN,
+				 le32_to_cpu(eh->tid_rdma.w_data.kdeth0),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, KVER),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, SH),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, INTR),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, TIDCTRL),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, TID),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth0, OFFSET),
+				 le32_to_cpu(eh->tid_rdma.w_data.kdeth1),
+				 KDETH_GET(eh->tid_rdma.w_data.kdeth1, JKEY),
+				 be32_to_cpu(eh->tid_rdma.w_data.verbs_qp));
+		break;
+	case OP(TID_RDMA, READ_REQ):
+		trace_seq_printf(p, TID_RDMA_KDETH " " RETH_PRN " "
+				 TID_READ_REQ_PRN,
+				 le32_to_cpu(eh->tid_rdma.r_req.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.r_req.kdeth1),
+				 ib_u64_get(&eh->tid_rdma.r_req.reth.vaddr),
+				 be32_to_cpu(eh->tid_rdma.r_req.reth.rkey),
+				 be32_to_cpu(eh->tid_rdma.r_req.reth.length),
+				 be32_to_cpu(eh->tid_rdma.r_req.tid_flow_psn),
+				 be32_to_cpu(eh->tid_rdma.r_req.tid_flow_qp),
+				 be32_to_cpu(eh->tid_rdma.r_req.verbs_qp));
+		break;
+	case OP(TID_RDMA, READ_RESP):
+		trace_seq_printf(p, TID_RDMA_KDETH_DATA " " AETH_PRN " "
+				 TID_READ_RSP_PRN,
+				 le32_to_cpu(eh->tid_rdma.r_rsp.kdeth0),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, KVER),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, SH),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, INTR),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, TIDCTRL),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, TID),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth0, OFFSET),
+				 le32_to_cpu(eh->tid_rdma.r_rsp.kdeth1),
+				 KDETH_GET(eh->tid_rdma.r_rsp.kdeth1, JKEY),
+				 be32_to_cpu(eh->tid_rdma.r_rsp.aeth) >> 24,
+				 parse_syndrome(/* aeth */
+					 be32_to_cpu(eh->tid_rdma.r_rsp.aeth)
+					 >> 24),
+				 (be32_to_cpu(eh->tid_rdma.r_rsp.aeth) &
+				  IB_MSN_MASK),
+				 be32_to_cpu(eh->tid_rdma.r_rsp.verbs_qp));
+		break;
+	case OP(TID_RDMA, ACK):
+		trace_seq_printf(p, TID_RDMA_KDETH " " AETH_PRN " "
+				 TID_ACK_PRN,
+				 le32_to_cpu(eh->tid_rdma.ack.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.ack.kdeth1),
+				 be32_to_cpu(eh->tid_rdma.ack.aeth) >> 24,
+				 parse_syndrome(/* aeth */
+					 be32_to_cpu(eh->tid_rdma.ack.aeth)
+					 >> 24),
+				 (be32_to_cpu(eh->tid_rdma.ack.aeth) &
+				  IB_MSN_MASK),
+				 be32_to_cpu(eh->tid_rdma.ack.tid_flow_psn),
+				 be32_to_cpu(eh->tid_rdma.ack.verbs_psn),
+				 be32_to_cpu(eh->tid_rdma.ack.tid_flow_qp),
+				 be32_to_cpu(eh->tid_rdma.ack.verbs_qp));
+		break;
+	case OP(TID_RDMA, RESYNC):
+		trace_seq_printf(p, TID_RDMA_KDETH " " TID_RESYNC_PRN,
+				 le32_to_cpu(eh->tid_rdma.resync.kdeth0),
+				 le32_to_cpu(eh->tid_rdma.resync.kdeth1),
+				 be32_to_cpu(eh->tid_rdma.resync.verbs_qp));
+		break;
+	/* aeth + atomicacketh */
+	case OP(RC, ATOMIC_ACKNOWLEDGE):
+		trace_seq_printf(p, AETH_PRN " " ATOMICACKETH_PRN,
+				 be32_to_cpu(eh->at.aeth) >> 24,
+				 parse_syndrome(be32_to_cpu(eh->at.aeth) >> 24),
+				 be32_to_cpu(eh->at.aeth) & IB_MSN_MASK,
+				 ib_u64_get(&eh->at.atomic_ack_eth));
+		break;
+	/* atomiceth */
+	case OP(RC, COMPARE_SWAP):
+	case OP(RC, FETCH_ADD):
+		trace_seq_printf(p, ATOMICETH_PRN,
+				 get_ib_ateth_vaddr(&eh->atomic_eth),
+				 eh->atomic_eth.rkey,
+				 get_ib_ateth_swap(&eh->atomic_eth),
+				 get_ib_ateth_compare(&eh->atomic_eth));
+		break;
+	/* deth */
+	case OP(UD, SEND_ONLY):
+		trace_seq_printf(p, DETH_ENTROPY_PRN,
+				 be32_to_cpu(eh->ud.deth[0]),
+				 be32_to_cpu(eh->ud.deth[1]) & RVT_QPN_MASK,
+				 be32_to_cpu(eh->ud.deth[1]) >>
+					     HFI2_IPOIB_ENTROPY_SHIFT);
+		break;
+	case OP(UD, SEND_ONLY_WITH_IMMEDIATE):
+		trace_seq_printf(p, DETH_PRN,
+				 be32_to_cpu(eh->ud.deth[0]),
+				 be32_to_cpu(eh->ud.deth[1]) & RVT_QPN_MASK);
+		break;
+	/* ieth */
+	case OP(RC, SEND_LAST_WITH_INVALIDATE):
+	case OP(RC, SEND_ONLY_WITH_INVALIDATE):
+		trace_seq_printf(p, IETH_PRN,
+				 be32_to_cpu(eh->ieth));
+		break;
+	}
+out:
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+const char *parse_sdma_flags(struct trace_seq *p, u64 *qw, u8 first, u8 last)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	char flags[5] = { 'x', 'x', 'x', 'x', 0 };
+
+	flags[0] = (qw[1] & SDMA_DESC1_INT_REQ_FLAG) ? 'I' : '-';
+	flags[1] = (qw[1] & SDMA_DESC1_HEAD_TO_HOST_FLAG) ?  'H' : '-';
+	flags[2] = first ? 'F' : '-';
+	flags[3] = last ? 'L' : '-';
+	trace_seq_printf(p, "%s", flags);
+	if (first)
+		trace_seq_printf(p, " amode:%u aidx:%u alen:%u",
+				 (u8)((qw[1] >> SDMA_DESC1_HEADER_MODE_SHIFT) &
+				      SDMA_DESC1_HEADER_MODE_MASK),
+				 (u8)((qw[1] >> SDMA_DESC1_HEADER_INDEX_SHIFT) &
+				      SDMA_DESC1_HEADER_INDEX_MASK),
+				 (u8)((qw[1] >> SDMA_DESC1_HEADER_DWS_SHIFT) &
+				      SDMA_DESC1_HEADER_DWS_MASK));
+	return ret;
+}
+
+const char *print_u32_array(
+	struct trace_seq *p,
+	u32 *arr, int len)
+{
+	int i;
+	const char *ret = trace_seq_buffer_ptr(p);
+
+	for (i = 0; i < len ; i++)
+		trace_seq_printf(p, "%s%#x", i == 0 ? "" : " ", arr[i]);
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+u8 hfi2_trace_get_tid_ctrl(u32 ent)
+{
+	return EXP_TID_GET(ent, CTRL);
+}
+
+u16 hfi2_trace_get_tid_len(u32 ent)
+{
+	return EXP_TID_GET(ent, LEN);
+}
+
+u16 hfi2_trace_get_tid_idx(u32 ent)
+{
+	return EXP_TID_GET(ent, IDX);
+}
+
+struct hfi2_ctxt_hist {
+	atomic_t count;
+	atomic_t data[255];
+};
+
+static struct hfi2_ctxt_hist hist = {
+	.count = ATOMIC_INIT(0)
+};
+
+const char *hfi2_trace_print_rsm_hist(struct trace_seq *p, unsigned int ctxt)
+{
+	int i, len = ARRAY_SIZE(hist.data);
+	const char *ret = trace_seq_buffer_ptr(p);
+	unsigned long packet_count = atomic_fetch_inc(&hist.count);
+
+	trace_seq_printf(p, "packet[%lu]", packet_count);
+	for (i = 0; i < len; ++i) {
+		unsigned long val;
+		atomic_t *count = &hist.data[i];
+
+		if (ctxt == i)
+			val = atomic_fetch_inc(count);
+		else
+			val = atomic_read(count);
+
+		if (val)
+			trace_seq_printf(p, "(%d:%lu)", i, val);
+	}
+	trace_seq_putc(p, 0);
+	return ret;
+}
+
+const char *hfi2_memtype_str(unsigned int mt)
+{
+	switch (mt) {
+	case HFI2_MEMINFO_TYPE_SYSTEM:
+		return "System";
+	}
+
+	return "<unknown>";
+}
+
+__hfi2_trace_fn(AFFINITY);
+__hfi2_trace_fn(PKT);
+__hfi2_trace_fn(PROC);
+__hfi2_trace_fn(SDMA);
+__hfi2_trace_fn(LINKVERB);
+__hfi2_trace_fn(DEBUG);
+__hfi2_trace_fn(SNOOP);
+__hfi2_trace_fn(CNTR);
+__hfi2_trace_fn(PIO);
+__hfi2_trace_fn(DC8051);
+__hfi2_trace_fn(FIRMWARE);
+__hfi2_trace_fn(RCVCTRL);
+__hfi2_trace_fn(TID);
+__hfi2_trace_fn(MMU);
+__hfi2_trace_fn(IOCTL);



