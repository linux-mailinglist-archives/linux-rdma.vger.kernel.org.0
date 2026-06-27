Return-Path: <linux-rdma+bounces-22522-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Si/XGaX5P2qbawkAu9opvQ
	(envelope-from <linux-rdma+bounces-22522-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:26:13 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB06B6D241A
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 18:26:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cornelisnetworks.com header.s=selector1 header.b=g32hK0yC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22522-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22522-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cornelisnetworks.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86D743017BEA
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Jun 2026 16:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE112F49FD;
	Sat, 27 Jun 2026 16:25:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020103.outbound.protection.outlook.com [52.101.85.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3942EBBAF
	for <linux-rdma@vger.kernel.org>; Sat, 27 Jun 2026 16:25:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782577559; cv=fail; b=fXgs08WAB3i+2RG36u45ryPeHfcBaP6ShoLIhOgYkJvKZ4JJecXsAOx05A0Vvs+7zZ1WQu3sU+tVxaUyv7xI3IYBpaLMlqT5tg4NlrRAPnrPNYouIUFxZrWBoLXtIQyUaPHGRAZdowp5qHVvZDlJddMc+VG8OgkgnQ/zOzR+U70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782577559; c=relaxed/simple;
	bh=/VtrJ2qclakvgoiV8Obg8dL7WjVf8RHbVx1wolpM/xU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GG5l2YkaJFwM0iVNPo1yQdFW0NJKMCWDi4V87+2BABxgj+DcZ35izJ+a/a9w72eTsZgScQo82X+TzpTg0aenrttShwrCi0Ar9ful6oYDCROVpKsxMTYrwNiKZTixvRXTiQOduwMOaprAIqWFWzNGuhj1Bu5ZxYMZkgaw1H26ql0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=g32hK0yC; arc=fail smtp.client-ip=52.101.85.103
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTnwFPxiEtAxAJ5BqtV+dt6M0nh99shO6bTTmL36sX411FFYdUbraBt6jDiv7YQejr54YMV2zMvMWSYGwEHqCmIl79l8SbNQc+zaRcdIcSMyBPLdOGVbgPmonrdx84Wprk9sKKTjnzttNLxdXWHMSXKwUozdw9Q63B4S+vLu9eysG2XCLMcsi4Nx69T8dbcwJDvkN3GCwbys9W75VSaT2cgffbYjOkW05hEWFlm7l8YPG6bmmqcQyZw4QANrwvRaOVTqst+YLxG31FIT4/9D0pTXrF3xhrD6HnKAaY/pekp0sZlElXyuTkYIZTfX8Z4sIu9Q+crHhMmDYvpvrbUrzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNfgtxvSHz2QNkykTqhZAo0b5IgH8dGMdjbZOYWE96I=;
 b=k1jrNRdp9BbeidwaIWuq8Iw34oFJLZFfxiAhdn0DVG2B+dgmLKBzuNx0gCvoe3kpqQtCf+p6HjI1hqwNIDMtQwPcBWmRafHUKLPyGgfD0tILJ+VaXEP+XGXBuv8ek1RYtSpQcT5BkFKJ8X2BXlh6Loq2aXlZjxS9zvRlTVhELMj3RKuRIWseqBS+NoLegLjCxWFoAzPjY8q/ni9bJYNXvFgClQfgB/AMuC6iWvDdvmzZSXTbyFJwGrnbDNDYDkCIwCppBJFUPsHqgzuDL6Cx9THAjVoM5bu0iPXxvlvmaoreeIPspM9mOaKRate/vt3QYtgJnjGumflP40/h3uTTfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.148.235.34) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNfgtxvSHz2QNkykTqhZAo0b5IgH8dGMdjbZOYWE96I=;
 b=g32hK0yCZuR6L/QpvesTOWfSH1j9om+ByUnOOZBH+puxUJTzWG9YrfzWF579wbCYLBUhO/wd6oALVno60bDD9T1DAHpalsHO4rg3kYOl4QUwvmLQI3nmpwHRUCbkvHk80UyLLPwLwFo+EzCZFy17gkx7IqhPdD6ZZYW3ARtdJOYqQaw0a4tU2Yg/rPwuLUAVzmqlr0ftYYLGe0TrqenSMoWE7dmEKmM7MKB9SRoQXO8c6jz1IS8Uq1ReCL9FBCdxcIte9rRP4uOhBhaerLCnCTNcuJHqF74axUS62hhnoGqNTnqyqVq8SiQxMTm76Bab/vAnBU66CXr7Ay+mQ6YDeQ==
Received: from MW4PR04CA0366.namprd04.prod.outlook.com (2603:10b6:303:81::11)
 by PHXPR01MB994646.prod.exchangelabs.com (2603:10b6:510:3cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Sat, 27 Jun
 2026 16:25:51 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::1f) by MW4PR04CA0366.outlook.office365.com
 (2603:10b6:303:81::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Sat,
 27 Jun 2026 16:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.148.235.34)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=cornelisnetworks.com;
Received-SPF: Fail (protection.outlook.com: domain of cornelisnetworks.com
 does not designate 50.148.235.34 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.148.235.34;
 helo=cn-mailer-00.localdomain;
Received: from cn-mailer-00.localdomain (50.148.235.34) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Sat, 27 Jun 2026 16:25:50 +0000
Received: from awdrv-04.localdomain (unknown [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 1AF71146565;
	Sat, 27 Jun 2026 12:25:50 -0400 (EDT)
Received: from [10.228.212.218] (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 15A9A1810D6C7;
	Sat, 27 Jun 2026 12:25:50 -0400 (EDT)
Subject: [PATCH v2 for-next 11/24] RDMA/hfi2: Add cport management
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Sat, 27 Jun 2026 12:25:50 -0400
Message-ID: <178257755004.371918.17543982215710047409.stgit@awdrv-04>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|PHXPR01MB994646:EE_
X-MS-Office365-Filtering-Correlation-Id: 528467eb-9d25-4da7-8c61-08ded468c0e8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|56012099006|5023799004|3023799007|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9+J8tsJ8qePYOyoHI+yIOUTi394F0ni7zL++vREBimiu06ZPegAbxSNJYWeN5ecQzlI96TSGTR85WG9xxGp4o34PA6IXA3zMQ0il15429iavsRSmTNZq+K/As9PLOATo+ssns6QPJtCcTf/u4VujcmMEQCl3upfG6SuGJMvqYQ8zd+x4NTOuBt2BIKEymgKCfs0Y6hwOh09UNEQsI7kb3q0F0aEs40gpLINvmZ+Ngco3VPmSspO6TxeKsh9uSQArvfWYwSUruMEVbVpxKR3vWInKG70aafSCMnb1eigH3gP5UxCPl2mwyxQv0oZxWyu6bMNnGD7lDHw3c8uZ7H7XpMr1868WDmZRIctXLv4GCJhVT1wovimf8DVxSmlbjb47585bQNfsYRyueUMatxOH2vAiy4VUM4YC8Fjpbgn6jBOtmAN4hOCDoC9MXBk8I11HufaUT//A24QD/4VCFMn25tbMBGKOS0LMZPYZJtMQeXQt1Bl0IUQY9TxPoeSV7tTI/B/uB1i8G+7yjq9p1Wl5x4estPmOdoYIYVBTN/n0YDKmJpzndhHSNLdaGNLidT4d3CZ8l7KaVWu1kkieuVkMb6aLkx8ulwwYXcXtle9KLmjL8tdDK8znbcuEIrbW21150nU6BpBIAJKLmXaCe39s/o+xafactBoTh2ca6DajPcnuXq2652hRU6gB0rbIhDFQVn6udmw0NT/nMbXtdVQW9w==
X-Forefront-Antispam-Report:
	CIP:50.148.235.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(5023799004)(3023799007)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g8L2Tc38/5G1eru1TiiH0xovh4yF4iWHNEGSznpKjW9qzJ7Q1w3nse3eu/cWAp1UMgcU24d6fCvFbm0GuSCUIF/nFMH2Zz8C7Pb7qs4goqXgROx1V7ls7X1SVhE3yM0c/BGaKy1gnVRCsJ2VyBfSNSe5nl0txzQFvVqd1t2R804+wuDorGq2Ol2sQG6+9i6d30Fw73XC3oumNx896J7PdlCvdxgYEiyQOMsugGmX8B2hC6TnZb/abWrQWHYT8m51Xi+zb9wtQfLLw783vxsndiJpsAHmDhz33zj6SwRUpRdIq+IYqwsbhfKM/NpMnIJESGkWIpGq5lVXyNea8M6kDmEJJGV6XPV0kiPqyBmiblsxjNKUBihz2eYwU/ADzygHgpX2Cp1+/uLvGIJg6Futh0ewU8t88DnPAuQD0pbelP91oOPA63kyit41F3hQOkvL
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 16:25:50.8682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528467eb-9d25-4da7-8c61-08ded468c0e8
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[50.148.235.34];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR01MB994646
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22522-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dean.luick@cornelisnetworks.com,m:doug.miller@cornelisnetworks.com,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[awdrv-04:mid,vger.kernel.org:from_smtp,cornelisnetworks.com:dkim,cornelisnetworks.com:email,cornelisnetworks.com:from_mime];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB06B6D241A

Add the cport.c file which implements communication with the embedded
micro controller on the chip for port management operations.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>

---
  Changes since v2:
    - Remove dead tautological comparisons (op_start < 0, op_end >= 256)
      on u8 params.
---
 drivers/infiniband/hw/hfi2/cport.c | 1017 ++++++++++++++++++++++++++++++++++++
 1 file changed, 1017 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/cport.c

diff --git a/drivers/infiniband/hw/hfi2/cport.c b/drivers/infiniband/hw/hfi2/cport.c
new file mode 100644
index 000000000000..ed4e017eec73
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/cport.c
@@ -0,0 +1,1017 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+/*
+ * Implementation details of CPORT communications.
+ */
+
+#include <linux/semaphore.h>
+#include <linux/io.h>
+
+#include "hfi2.h"
+#include "chip_jkr.h"
+#include "cport.h"
+
+static uint cport_ping_to;
+
+uint hfi2_cport_adm_to = 1;
+
+static bool cport_mctxt_recovery = true;
+
+static void cport_send_req_fn(struct work_struct *work);
+static void cport_send_rsp_fn(struct work_struct *work);
+
+#undef CPORT_XA_DEBUG /* every tid assigned from xarray */
+#undef CPORT_RCV_DEBUG /* every message (header) received, and outbox empty */
+#undef CPORT_SND_DEBUG /* every message (header) sent */
+#undef CPORT_INT_DEBUG /* every interrupt processed, and status in timeouts */
+#define LOST_INT_DEBUG /* print if lost intr detected */
+
+static unsigned int cport_lost_int = 1 * HZ;
+
+/*
+ * This limit needs to balance memory consuption against
+ * the need to ensure tids don't repeat during periods of
+ * CPORT stall and message timeout.
+ *
+ * Also note that the limit parameter passed to xa_alloc*()
+ * gets modified, so we cannot use a static structure here.
+ */
+#define cport_tid_limit XA_LIMIT(0, 255)
+
+/*
+ * The "header" (first qword) of a message to/from CPORT.
+ */
+union cport_header {
+	struct {
+		u64 len : 15;
+		u64 _resv1 : 1;
+		u64 is_req : 1;
+		u64 no_rsp : 1;
+		u64 seq_no : 6;
+		u64 sts : 8;
+		u64 tid : 16;
+		u64 sideband : 8;
+		u64 op_code : 8;
+	};
+	u64 qw;
+};
+
+#define CPORT_SEQNO_MASK 0x3f
+
+#define CPORT_HDR_DEF 0x0000007ec0000000ul
+#define CPORT_HDR_LEN 48 /* bit position of length in CPORT_HDR_DEF */
+#define CPORT_HDR_SEQ 28 /* bit position of SEQ_NO */
+#define CPORT_HDR_EOM 30 /* bit position of EOM */
+#define CPORT_HDR_SOM 31 /* bit position of SOM */
+
+#define CPORT_IN_SCRATCH (JKR_ASIC_CFG_SCRATCH + 0)
+#define CPORT_OUT_SCRATCH (JKR_ASIC_CFG_SCRATCH + sizeof(u64))
+
+/*
+ * Assignment of bits in JKR_MCTXT_CPORT_INT_STATUS and
+ * JKR_MCTXT_PF0_INT_STATUS.
+ */
+#define JKR_MCTXT_INT_OUTBOX_EMPTY 0b00000001
+#define JKR_MCTXT_INT_INBOX_FULL 0b00000010
+
+/*
+ * The remainder is private to the host driver.
+ * CPORT firmware has no need of this interface.
+ */
+
+/*
+ * How the MCTXT CSRs are interpreted.
+ */
+union mctxt_mem {
+	union cport_header hdr;
+	u64 qw[JKR_C_MCTXT_MEM_SIZE_IN_QWORDS];
+};
+
+/*
+ * The common structure used to implement CPORT messages in hfi2.
+ */
+struct cport_work {
+	struct work_struct work;
+	struct kref kref;
+	int flags;
+	u8 n_mctxts; /* len of mctxt_mem req/rsp arrays */
+	u8 mctxts_done; /* number of mctxs sent/received */
+	long timeout;
+	struct semaphore *sem; /* only valid in send, if request w/response */
+	struct hfi2_devdata *dd; /* only valid in recv context */
+	union mctxt_mem *req;
+	union mctxt_mem *rsp; /* only used for request w/response */
+};
+
+#define CW_FLAG_SEND 0x01 /* struct originated in send */
+#define CW_FLAG_RECV 0x02 /* struct originated in receive */
+
+/*
+ * Suspected lost interrupt, try to recover if possible.
+ */
+static void lost_mctxt_intr(struct hfi2_devdata *dd)
+{
+	u64 ints;
+
+	spin_lock(&dd->irq_src_lock); /* a compatible use of the lock */
+	ints = hfi2_read_csr(dd, JKR_MCTXT_PF0_INT_STATUS_ENABLED);
+	/* if bits set, assume lost interrupt and attempt recovery. */
+	if (ints) {
+#ifdef LOST_INT_DEBUG
+		dd_dev_info(dd, "%s forcing int for %llx\n", __func__, ints);
+#endif
+		hfi2_force_intr(dd, JKR_MCTXT_CPORT_TO_PCIE_INT);
+	}
+	spin_unlock(&dd->irq_src_lock);
+}
+
+static void cport_lost_int_chk(struct timer_list *t)
+{
+	struct hfi2_cport *cport = timer_container_of(cport, t, lost_int_timer);
+
+	if (cport_lost_int) {
+		lost_mctxt_intr(cport->dd);
+		mod_timer(&cport->lost_int_timer, jiffies + cport_lost_int);
+	}
+}
+
+/*
+ * Acquire a reference to the message structure
+ */
+static inline void cwget(struct cport_work *cw)
+{
+	kref_get(&cw->kref);
+}
+
+/*
+ * Locate and remove the 'id' message in the xarray and atomically
+ * acquire a reference to the message structure.
+ */
+static inline struct cport_work *cwget_xa(struct hfi2_devdata *dd, u32 id)
+{
+	struct cport_work *cw;
+
+	xa_lock(&dd->cport->tid_xa);
+	cw = __xa_erase(&dd->cport->tid_xa, id);
+	if (cw)
+		cwget(cw);
+	xa_unlock(&dd->cport->tid_xa);
+	return cw;
+}
+
+static void cwrelease(struct kref *kref)
+{
+	struct cport_work *cw = container_of(kref, struct cport_work, kref);
+
+	kfree(cw->req);
+	kfree(cw->rsp);
+
+	kfree(cw);
+}
+
+static void cwput(struct cport_work *cw)
+{
+	kref_put(&cw->kref, cwrelease);
+}
+
+static struct cport_work *cwalloc(int flag)
+{
+	struct cport_work *cw = kzalloc(sizeof(*cw), GFP_KERNEL);
+
+	if (!cw)
+		return NULL;
+
+	cw->flags = flag;
+	cw->n_mctxts = 1;
+	cw->req = kzalloc_obj(cw->req, GFP_KERNEL);
+	if (!cw->req) {
+		kfree(cw);
+		return NULL;
+	}
+
+	cw->rsp = kzalloc(sizeof(*cw->rsp), GFP_KERNEL);
+	if (!cw->rsp) {
+		kfree(cw->req);
+		kfree(cw);
+		return NULL;
+	}
+
+	kref_init(&cw->kref);
+	return cw;
+}
+
+/* set "external" (non-alloc) response payload */
+static void pld_rsp_set(struct cport_work *cw, void *pld, int len)
+{
+	memcpy(&cw->rsp->qw[1], pld, len);
+	cw->rsp->hdr.len = len + sizeof(cw->rsp->hdr);
+}
+
+static int cw_pad_size(struct cport_work *msg, u32 size)
+{
+	union mctxt_mem *new_reqs, *new_rsps;
+	u8 new_ctxts;
+
+	/* already large enough */
+	if (size <= msg->n_mctxts * (sizeof(*new_reqs)))
+		return 0;
+
+	/* round up to next mctxt buffer len */
+	new_ctxts = (size + (sizeof(*new_reqs) - 1)) / sizeof(*new_reqs);
+	new_reqs =
+		krealloc(msg->req, new_ctxts * sizeof(*new_reqs), GFP_KERNEL);
+	if (!new_reqs)
+		return -ENOMEM;
+	msg->req = new_reqs;
+
+	new_rsps =
+		krealloc(msg->rsp, new_ctxts * sizeof(*new_reqs), GFP_KERNEL);
+	if (!new_rsps)
+		return -ENOMEM;
+
+	msg->rsp = new_rsps;
+	msg->n_mctxts = new_ctxts;
+
+	return 0;
+}
+
+static int cwcopy(struct cport_work *msg, void *from, u32 offset, u32 len,
+		  bool req)
+{
+	union mctxt_mem *mc;
+	int ret;
+
+	ret = cw_pad_size(msg, offset + len);
+	if (ret)
+		return ret;
+
+	mc = req ? msg->req : msg->rsp;
+	memcpy(((u8 *)mc) + offset, from, len);
+
+	return 0;
+}
+
+/*
+ * Send request, non-blocking, with timeout for OUTBOX_EMPTY wait.
+ * Caller must watch 'wait' semaphore for completion, and
+ * then call hfi2_cport_send_comp() or hfi2_cport_send_cancel() to finalize everything.
+ * Returns handle for hfi2_cport_send_comp()/_cancel(), or ERR_PTR().
+ *
+ * See hfi2_cport_send_req() for example usage.
+ */
+void *hfi2_cport_send_req_nb(struct hfi2_devdata *dd, u8 op, u8 sideband,
+			void *payload, int len, struct semaphore *wait,
+			long timeout)
+{
+	int ret;
+	struct cport_work *msg;
+	u32 idx;
+
+	if (!dd->cport)
+		return ERR_PTR(-EINVAL);
+
+	msg = cwalloc(CW_FLAG_SEND);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+	msg->dd = dd;
+	msg->timeout = timeout;
+	ret = cwcopy(msg, payload, sizeof(union cport_header), len, true);
+	if (ret) {
+		cwput(msg);
+		return ERR_PTR(ret);
+	}
+	ret = xa_alloc_cyclic(&dd->cport->tid_xa, &idx, msg, cport_tid_limit,
+			      &dd->cport->tid_next, GFP_KERNEL);
+	if (ret < 0) {
+		cwput(msg);
+		return ERR_PTR(ret);
+	}
+#ifdef CPORT_XA_DEBUG
+	dd_dev_info(dd, "CPORT tid is %04x\n", idx);
+#endif
+	msg->req->hdr.op_code = op;
+	msg->req->hdr.sideband = sideband;
+	msg->req->hdr.is_req = 1;
+	msg->req->hdr.no_rsp = 0;
+	msg->req->hdr.tid = idx;
+	msg->req->hdr.len = len + sizeof(msg->req->hdr);
+	msg->sem = wait;
+	cwget(msg); /* extra ref so not freed after send */
+	INIT_WORK(&msg->work, cport_send_req_fn);
+	queue_work(dd->hfi2_wq, &msg->work);
+	return msg;
+}
+
+/*
+ * Extract results from response and drop (last) reference to structure.
+ * Returns status from response header.
+ * Must never be called twice for the same message (message has been freed).
+ * Must never be called on a message that has not received response (up'ed wait).
+ */
+int hfi2_cport_send_comp(struct hfi2_devdata *dd, void *handle, void **rsp_pld,
+		    int *rsp_len)
+{
+	struct cport_work *msg = handle;
+	void *ptr;
+	int ret;
+	int len;
+
+	*rsp_len = len = msg->rsp->hdr.len - sizeof(msg->rsp->hdr);
+	if (rsp_pld) {
+		ptr = kzalloc(len, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+		memcpy(ptr, &msg->rsp[0].qw[1], len);
+		*rsp_pld = ptr;
+	}
+	ret = msg->rsp->hdr.sts;
+	cwput(msg);
+	return ret;
+}
+
+/*
+ * Cleanup aborted wait for response.
+ * Only called for requests w/responses.
+ * Must never be called twice for the same message (message has been freed).
+ */
+void hfi2_cport_send_cancel(struct hfi2_devdata *dd, void *handle)
+{
+	struct cport_work *msg = handle;
+
+	cancel_work(&msg->work); /* cport_send() drops ref on all paths */
+	xa_erase(&dd->cport->tid_xa, msg->req->hdr.tid);
+	cwput(msg);
+}
+
+/*
+ * Send request and wait for response, with timeout.
+ * Caller must be able to sleep.
+ * Returns status from response header, and response payload data, on success.
+ * Response payload was from k[z]alloc() and caller must kfree().
+ * On error, returns -errno (response status is always 0-15).
+ */
+int hfi2_cport_send_req(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload,
+		   int len, void **rsp_pld, int *rsp_len, long timeout)
+{
+	int ret;
+	struct cport_work *msg;
+	struct semaphore comp;
+
+	sema_init(&comp, 0);
+
+	might_sleep();
+
+	msg = hfi2_cport_send_req_nb(dd, op, sideband, payload, len, &comp, timeout);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+	if (timeout > 0 && timeout != MAX_SCHEDULE_TIMEOUT)
+		ret = down_timeout(&comp, timeout);
+	else
+		ret = down_killable(&comp);
+	if (ret) {
+#ifdef CPORT_INT_DEBUG
+		u64 ints;
+
+		ints = hfi2_read_csr(dd, JKR_MCTXT_PF0_INT_STATUS);
+		dd_dev_err(
+			dd,
+			"CPORT request wait interrupted %016llx (%d) [%02llx]\n",
+			msg->req->hdr.qw, ret, ints);
+#else
+		dd_dev_err(dd, "CPORT request wait interrupted %016llx (%d)\n",
+			   msg->req->hdr.qw, ret);
+#endif
+		hfi2_cport_send_cancel(dd, msg);
+		lost_mctxt_intr(dd); /* attempt recovery */
+		return ret;
+	}
+	return hfi2_cport_send_comp(dd, msg, rsp_pld, rsp_len);
+}
+
+int hfi2_cport_send_notif(struct hfi2_devdata *dd, u8 op, u8 sideband, void *payload,
+		     int len, long timeout)
+{
+	struct cport_work *msg;
+	int ret;
+
+	if (!dd->cport)
+		return -EINVAL;
+
+	msg = cwalloc(CW_FLAG_SEND);
+	if (!msg)
+		return -ENOMEM;
+	msg->dd = dd;
+	msg->timeout = timeout;
+	ret = cwcopy(msg, payload, sizeof(union cport_header), len, true);
+	if (ret) {
+		cwput(msg);
+		return ret;
+	}
+	msg->req->hdr.len = len + sizeof(msg->req->hdr);
+	msg->req->hdr.op_code = op;
+	msg->req->hdr.sideband = sideband;
+	msg->req->hdr.is_req = 1;
+	msg->req->hdr.no_rsp = 1;
+	INIT_WORK(&msg->work, cport_send_req_fn);
+	queue_work(dd->hfi2_wq, &msg->work);
+	return 0;
+}
+
+/*
+ ********************************************************************
+ * Internal routines.
+ */
+
+/*
+ * Send a response to CPORT's request.
+ *
+ * Re-uses message structure from request. Queues to send workqueue.
+ */
+static int cport_send_rsp(struct cport_work *msg, int sts)
+{
+	struct hfi2_devdata *dd = msg->dd;
+
+	/* rsp.hdr.len and rsp.qw[1..] already setup, also rsp.op_code/rsp.tid */
+	msg->rsp->hdr.is_req = 0;
+	msg->rsp->hdr.sts = sts;
+	INIT_WORK(&msg->work, cport_send_rsp_fn);
+	queue_work(dd->hfi2_wq, &msg->work);
+	return 0;
+}
+
+static void cport_send(struct cport_work *msg, bool req)
+{
+	union mctxt_mem *mc = req ? msg->req : msg->rsp;
+	struct hfi2_devdata *dd = msg->dd;
+	u32 csr_i, tot_len, len_sent;
+	u64 cport_hdr;
+	u8 seq_no;
+	u64 *ptr;
+	int ret, mcxt_len;
+
+	/* sleep until OutboxEmpty... */
+	if (msg->timeout > 0 && msg->timeout != MAX_SCHEDULE_TIMEOUT)
+		ret = down_timeout(&dd->cport->outbox, msg->timeout);
+	else
+		ret = down_killable(&dd->cport->outbox);
+	if (ret) {
+		dd_dev_err(dd, "CPORT Send OUTBOX_EMPTY killed %016llx (%d)\n",
+			   msg->req->hdr.qw, ret);
+		cwput(msg);
+		lost_mctxt_intr(dd); /* attempt recovery */
+		return; /* no way to report error to caller */
+	}
+
+	/* sequential under lock, check if there are unfinished messages */
+	if (dd->cport->incomplete_mctxt_msg_tx &&
+	    dd->cport->incomplete_mctxt_msg_tx != msg) {
+		/* give up empty outbox, the incomplete msg must finish next */
+		up(&dd->cport->outbox);
+		/* reschedule this work until next time */
+		queue_work(dd->hfi2_wq, &msg->work);
+		return;
+	}
+
+#ifdef CPORT_SND_DEBUG
+	dd_dev_info(dd, "MCTXT sent %016llx\n", mc->hdr.qw);
+#endif
+	tot_len = mc->hdr.len;
+	len_sent = msg->mctxts_done * sizeof(union mctxt_mem);
+	ptr = &mc[msg->mctxts_done].qw[0];
+	seq_no = msg->mctxts_done;
+	mcxt_len =
+		min_t(int, (int)(tot_len - len_sent), sizeof(union mctxt_mem));
+	/* NOTE: "CPORT IN" is our output */
+	csr_i = JKR_MCTXT_CPORT_IN;
+	cport_hdr = CPORT_HDR_DEF;
+	cport_hdr |= ((u64)mcxt_len << CPORT_HDR_LEN);
+
+	cport_hdr |= (((u64)seq_no & 0x3) << CPORT_HDR_SEQ);
+
+	/* CPORT_HDR_DEF sets SOM/EOM, clear if not */
+	if (msg->mctxts_done)
+		cport_hdr &= ~((u64)1 << CPORT_HDR_SOM);
+	else
+		mc->hdr.seq_no = atomic_fetch_inc(&dd->cport->seqno);
+
+	if (msg->mctxts_done + 1 < msg->n_mctxts)
+		cport_hdr &= ~((u64)1 << CPORT_HDR_EOM);
+
+	hfi2_write_csr(dd, CPORT_IN_SCRATCH, cport_hdr);
+	while (mcxt_len > 0) {
+		hfi2_write_csr(dd, csr_i, *ptr++);
+		csr_i += sizeof(u64);
+		mcxt_len -= sizeof(u64);
+	}
+	hfi2_write_csr(dd, JKR_MCTXT_CPORT_INT_STATUS, JKR_MCTXT_INT_INBOX_FULL);
+
+	/* did we complete the message? */
+	if (++msg->mctxts_done < msg->n_mctxts) {
+		dd->cport->incomplete_mctxt_msg_tx = msg;
+		queue_work(dd->hfi2_wq,
+			   &msg->work); /* reschedule the remaining sends */
+
+		return;
+	}
+
+	dd->cport->incomplete_mctxt_msg_tx = NULL;
+	/* reset mctxts_done for response parsing */
+	if (req)
+		msg->mctxts_done = 0;
+	cwput(msg); /* may or may not free memory */
+}
+
+/*
+ * Low-level send to CPORT via MCTXT.
+ *
+ * Interfaces with MCTXT.
+ */
+static void cport_send_req_fn(struct work_struct *work)
+{
+	struct cport_work *msg = container_of(work, struct cport_work, work);
+
+	cport_send(msg, true);
+}
+
+static void cport_send_rsp_fn(struct work_struct *work)
+{
+	struct cport_work *msg = container_of(work, struct cport_work, work);
+
+	cport_send(msg, false);
+}
+
+static int echo_req(struct hfi2_devdata *dd, u8 op, u8 sideband, void *pld,
+		    int pll, void *handle)
+{
+	struct cport_work *msg = handle;
+
+	dd_dev_info(msg->dd, "cport ping %02x (%d)\n", sideband, pll);
+	/* Leave payload in-tact (echo). */
+	pld_rsp_set(msg, pld, pll);
+	return MSG_RSP_STATUS_OK;
+}
+
+static int inval_req(struct hfi2_devdata *dd, u8 op, u8 sideband, void *pld,
+		     int pll, void *handle)
+{
+	return MSG_RSP_STATUS_OPCODE_UNSUPPORTED;
+}
+
+/*
+ * Process a request from CPORT.
+ *
+ * May be dispatched to external function from handlers[].
+ */
+static void cport_req_fn(struct work_struct *work)
+{
+	struct cport_work *msg = container_of(work, struct cport_work, work);
+	cport_handler func;
+	int ret = MSG_RSP_STATUS_OK;
+	void *pld;
+	int pll;
+
+	pll = msg->req->hdr.len - sizeof(msg->req->hdr);
+	pld = &msg->req->qw[1];
+	msg->rsp->hdr.qw = msg->req->hdr.qw;
+	/* default to no payload in response (if any) */
+	msg->rsp->hdr.len = sizeof(msg->req->hdr);
+	func = msg->dd->cport->handlers[msg->req->hdr.op_code];
+	if (func)
+		ret = func(msg->dd, msg->req->hdr.op_code,
+			   msg->req->hdr.sideband, pld, pll, msg);
+	else
+		ret = inval_req(msg->dd, msg->req->hdr.op_code,
+				msg->req->hdr.sideband, pld, pll, msg);
+	if (msg->req->hdr.no_rsp) {
+		cwput(msg);
+		if (ret)
+			dd_dev_err(msg->dd, "Op %d %02x failed (%d)\n",
+				   msg->req->hdr.op_code,
+				   msg->req->hdr.sideband, ret);
+	} else {
+		/* msg->rsp->qw[*] and msg->rsp->hdr.len have been updated */
+		ret = cport_send_rsp(msg, ret);
+		if (ret)
+			dd_dev_err(msg->dd, "Response send failed (%d)\n", ret);
+	}
+}
+
+/*
+ * Handler for MCTXT Inbox Full interrupt.
+ *
+ * Only one can be queued/run until JKR_MCTXT_INT_OUTBOX_EMPTY is cleared.
+ * Run in a workqueue (not interrupt context).
+ */
+static void cport_mctxt_fn(struct work_struct *work)
+{
+	struct hfi2_cport *cport =
+		container_of(work, struct hfi2_cport, mctxt_work);
+	struct hfi2_devdata *dd = cport->dd;
+	int ret = 0;
+	u8 is_start, is_end;
+	int len;
+	u64 *ptr;
+	u64 mhdr;
+	u32 i;
+	struct cport_work *msg;
+	union cport_header hdr;
+
+	/*
+	 * CPORT output MCTXT is our input.
+	 */
+	i = JKR_MCTXT_CPORT_OUT;
+
+	mhdr = hfi2_read_csr(dd, CPORT_OUT_SCRATCH);
+	len = (mhdr >> CPORT_HDR_LEN) & 0xfff;
+	len = min_t(int, len, sizeof(union mctxt_mem));
+	is_start = (mhdr >> CPORT_HDR_SOM) & 1;
+	is_end = (mhdr >> CPORT_HDR_EOM) & 1;
+	if (is_start) {
+		hdr.qw = hfi2_read_csr(dd, i);
+	} else if (cport->incomplete_mctxt_msg_rx) {
+		msg = cport->incomplete_mctxt_msg_rx;
+		if (msg->flags & CW_FLAG_RECV) {
+			ptr = &msg->req[msg->mctxts_done++].qw[0];
+			hdr.qw = msg->req->hdr.qw;
+		} else {
+			ptr = &msg->rsp[msg->mctxts_done++].qw[0];
+			hdr.qw = msg->rsp->hdr.qw;
+		}
+		dd_dev_info(dd, "%s: got continuation of %u\n", __func__,
+			    hdr.seq_no);
+		/* skip all the start-message parsing/allocation */
+		goto copy;
+	} else {
+		/* this is bad, just skip the message */
+		dd_dev_warn(dd, "cport sent unexpected non-start packet\n");
+		goto fail;
+	}
+#ifdef CPORT_RCV_DEBUG
+	dd_dev_info(dd, "%s() %016llx\n", __func__, hdr.qw);
+#endif
+	if (hdr.len < sizeof(hdr)) {
+		/* assume message is invalid  - cannot be processed */
+		ret = -EDOM;
+		goto fail;
+	}
+	i += sizeof(u64);
+	/* No need for atomics here, we are single threaded */
+	if (hdr.seq_no != cport->rseqno) {
+		dd_dev_info(dd, "Recv out of sequence: %d -> %d\n",
+			    cport->rseqno, hdr.seq_no);
+		cport->rseqno = hdr.seq_no;
+	}
+	cport->rseqno = (cport->rseqno + 1) & CPORT_SEQNO_MASK;
+	if (hdr.is_req) {
+		/* Request from CPORT, has no existing message context */
+		msg = cwalloc(CW_FLAG_RECV);
+		if (!msg) {
+			ret = -ENOMEM;
+			goto fail; /* drop message, with error */
+		}
+		ret = cw_pad_size(msg, hdr.len);
+		if (ret)
+			goto fail;
+		ptr = &msg->req->qw[msg->mctxts_done++];
+	} else {
+		/*
+		 * Responses already have a 'msg', extra ref was already taken.
+		 * Take an additional ref against possible race with timeout
+		 * (hfi2_cport_send_cancel()) between here and the up().
+		 */
+		msg = cwget_xa(dd, hdr.tid);
+		if (!msg) {
+			ret = -ESRCH;
+			goto fail; /* drop message, with error */
+		}
+		ret = cw_pad_size(msg, hdr.len);
+		if (ret)
+			goto fail;
+		ptr = &msg->rsp->qw[msg->mctxts_done++];
+		/* assert msg->req->hdr ~= hdr */
+	}
+	*ptr++ = hdr.qw;
+	len -= sizeof(hdr);
+copy:
+	/* now copy payload into chosen buffer */
+	while (len > 0) {
+		*ptr++ = hfi2_read_csr(dd, i);
+		i += sizeof(u64);
+		len -= sizeof(u64);
+	}
+	/*
+	 * We are finished with the dd->cport->mctxt_work struct,
+	 * and the MCTXT, so it can all be re-used now.
+	 */
+	hfi2_write_csr(dd, JKR_MCTXT_CPORT_INT_STATUS, JKR_MCTXT_INT_OUTBOX_EMPTY);
+#ifdef CPORT_RCV_DEBUG
+	dd_dev_info(dd, "%s() set CPORT OUTBOX_EMPTY\n", __func__);
+#endif
+	/*
+	 * if we do not contain the end of the message then we need to wait
+	 * until next mailbox
+	 */
+	if (!is_end) {
+		cport->incomplete_mctxt_msg_rx = msg;
+		dd_dev_info(dd, "%s: expecting continuation of %u\n", __func__,
+			    hdr.seq_no);
+		return;
+	}
+	cport->incomplete_mctxt_msg_rx = NULL;
+
+	/* responses don't require any more work here - just wakeup requester */
+	if (!hdr.is_req) {
+		up(msg->sem);
+		cwput(msg);
+		return;
+	}
+	msg->dd = dd;
+
+	/* reset mctxts for response parsing */
+	msg->mctxts_done = 0;
+
+	/* dispatch 'msg' request */
+	INIT_WORK(&msg->work, cport_req_fn);
+	/* don't care about locality */
+	queue_work(dd->hfi2_wq, &msg->work);
+	return;
+fail:
+	hfi2_write_csr(dd, JKR_MCTXT_CPORT_INT_STATUS, JKR_MCTXT_INT_OUTBOX_EMPTY);
+	dd_dev_err(dd, "Dropping incoming CPORT message %016llx (%d)\n", hdr.qw,
+		   ret);
+}
+
+/*
+ * Handler for PF0 MCTXT interrupts.
+ *
+ * Called when one of the enabled MCTXT_PF0 conditions occurs.
+ * 'source' is always 0. Called in interrupt context.
+ *
+ * Since this interrupt is exclusive to MCTXT, there is no doubt
+ * about which transport to use (always is MCTXT).
+ */
+void hfi2_is_cport_int(struct hfi2_devdata *dd, unsigned int source)
+{
+	u64 ints;
+	const int limit = 100; /* arbitrary */
+	int count;
+
+	if (!dd->cport)
+		return;
+
+	/*
+	 * MctxtCportToPcieInt is a "one shot" merged interrupt.  To ensure
+	 * nothing is missed, ensure that its source, MctxtPf0IntStatusEnabled,
+	 * is cleared and reads as zero.
+	 */
+	ints = 0;
+	for (count = 0; count < limit; count++) {
+		u64 temp;
+
+		temp = hfi2_read_csr(dd, JKR_MCTXT_PF0_INT_STATUS_ENABLED);
+		if (temp == 0)
+			break;
+		ints |= temp;
+		hfi2_write_csr(dd, JKR_MCTXT_PF0_INT_ACK, temp);
+	}
+	if (count == limit)
+		dd_dev_warn(dd, "MCTXT interrupt too many loops\n");
+	if (!ints) {
+		dd_dev_warn(dd, "MCTXT interrupt, but no status bits set\n");
+		return;
+	}
+
+#ifdef CPORT_INT_DEBUG
+	dd_dev_info(dd, "%s() %02llx\n", __func__, ints);
+#endif
+	if (ints & JKR_MCTXT_INT_INBOX_FULL)
+		queue_work(dd->hfi2_wq, &dd->cport->mctxt_work);
+	if (ints & JKR_MCTXT_INT_OUTBOX_EMPTY)
+		up(&dd->cport->outbox);
+}
+
+/***************************************************
+ * API for handling notifications from CPORT
+ */
+
+int hfi2_cport_resp_set(void *handle, void *payload, int len)
+{
+	struct cport_work *msg = handle;
+
+	if (!msg || !payload || len <= 0)
+		return -EINVAL;
+	msg->rsp->hdr.len = len + sizeof(msg->rsp->hdr);
+	memcpy(&msg->rsp->qw[1], payload, len);
+	return 0;
+}
+
+int hfi2_cport_register_cb(struct hfi2_devdata *dd, u8 op_start, u8 op_end,
+		      cport_handler func)
+{
+	int x;
+
+	if (op_start > op_end)
+		return -ERANGE;
+	if (!dd->cport)
+		return -EINVAL;
+
+	/* 'func' may be NULL, to unregister */
+	for (x = op_start; x <= op_end; ++x) {
+		dd->cport->handlers[x] = func;
+	}
+	return 0;
+}
+
+static int cport_ping(void *data)
+{
+	struct hfi2_devdata *dd = data;
+	char buf[16];
+	int len;
+	unsigned int num;
+	void *rspbuf;
+	int rsplen;
+	int rc;
+
+	while (!kthread_should_stop() &&
+	       (num = atomic_read(&dd->cport->nping)) > 0) {
+		len = snprintf(buf, sizeof(buf), "ping %u", num);
+		rspbuf = NULL;
+		rc = hfi2_cport_send_req(dd, CH_OP_PING, 0, buf, len, &rspbuf,
+				    &rsplen,
+				    cport_ping_to ? cport_ping_to * HZ :
+						    MAX_SCHEDULE_TIMEOUT);
+		if (rc < 0) {
+			dd_dev_info(dd, "CPORT \"%s\" error %d\n", buf, rc);
+			if (!cport_ping_to)
+				break;
+		} else {
+			dd_dev_info(dd, "CPORT \"%s\" -> %d \"%.*s\"\n", buf,
+				    rc, rsplen, (char *)rspbuf);
+		}
+		kfree(rspbuf);
+		atomic_dec(&dd->cport->nping);
+	}
+	dd->cport->ping_th = NULL;
+	atomic_set(&dd->cport->nping, 0);
+	return 0;
+}
+
+int hfi2_cport_ping_start(struct hfi2_devdata *dd, unsigned int count)
+{
+	int rc;
+
+	if (!count) {
+		if (dd->cport->ping_th)
+			kthread_stop(dd->cport->ping_th);
+		/* kthread will zero count when exiting */
+		else
+			atomic_set(&dd->cport->nping, 0);
+		return 0;
+	}
+	atomic_set(&dd->cport->nping, count);
+	if (dd->cport->ping_th)
+		return 0;
+
+	dd->cport->ping_th =
+		kthread_create_on_node(cport_ping, dd, dd->node, "cport_ping");
+	if (IS_ERR(dd->cport->ping_th)) {
+		rc = PTR_ERR(dd->cport->ping_th);
+		dd->cport->ping_th = NULL;
+		dd_dev_err(dd, "Failed to create CPORT ping thread %d\n", rc);
+		return rc;
+	}
+	wake_up_process(dd->cport->ping_th);
+	return 0;
+}
+
+#ifdef CONFIG_HFI_CPORT_POLLING
+static int cport_poll(void *data)
+{
+	struct hfi2_devdata *dd = data;
+	u64 v;
+
+	while (!kthread_should_stop()) {
+		v = hfi2_read_csr(dd, JKR_MCTXT_PF0_INT_STATUS);
+		if (v & 0xff)
+			hfi2_is_cport_int(dd, 0);
+		fsleep(30);
+	}
+	return 0;
+}
+#endif
+
+/*
+ * Initialization/setup of MCTXT CPORT communications channel.
+ */
+int hfi2_cport_init(struct hfi2_devdata *dd)
+{
+	struct hfi2_cport *cport;
+
+	if (dd->params->chip_type == CHIP_WFR || dd->is_vf)
+		return 0;
+
+	cport = kzalloc_obj(cport, GFP_KERNEL);
+	if (!cport)
+		goto err1;
+
+	INIT_WORK(&cport->mctxt_work, cport_mctxt_fn);
+	xa_init_flags(&cport->tid_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&cport->trap_xa, XA_FLAGS_ALLOC);
+
+	/*
+	 * Setting initial state can be problematic.
+	 * We require that CPORT set JKR_MCTXT_INT_OUTBOX_EMPTY in
+	 * JKR_MCTXT_PF0_INT_STATUS or we will never start sending.
+	 * We also require that CPORT never set JKR_MCTXT_INT_OUTBOX_EMPTY
+	 * gratuitously, or we get a semaphore count > 1 and will
+	 * start overrunning MCTXT. Essentially, CPORT must set this
+	 * exactly once when entering the "ready to receive" state
+	 * (initially and after processing each message).
+	 */
+	sema_init(&cport->outbox, 0);
+
+	cport->dd = dd;
+	dd->cport = cport;
+
+	hfi2_cport_register_cb(dd, CH_OP_PING, CH_OP_PING, echo_req);
+
+	if (cport_mctxt_recovery) {
+		u64 is, ie;
+
+		is = hfi2_read_csr(dd, JKR_MCTXT_PF0_INT_STATUS);
+		ie = hfi2_read_csr(dd, JKR_MCTXT_PF0_INT_ENABLE);
+		if (!(is & JKR_MCTXT_INT_OUTBOX_EMPTY) && ie) {
+			dd_dev_warn(dd, "recovering CPORT MCTXT state\n");
+			hfi2_write_csr(dd, JKR_MCTXT_PF0_INT_ENABLE, 0);
+			hfi2_write_csr(dd, JKR_MCTXT_PF0_INT_STATUS,
+				  JKR_MCTXT_INT_OUTBOX_EMPTY);
+		}
+	}
+
+#ifdef CONFIG_HFI_CPORT_POLLING
+	cport->poll_th =
+		kthread_create_on_node(cport_poll, dd, dd->node, "cport_poll");
+	if (!cport->poll_th)
+		dd_dev_err(dd, "Failed to create CPORT polling thread\n");
+	else
+		wake_up_process(dd->cport->poll_th);
+#else
+	/* Enable intr source for MCTXT from CPORT (to PF0) */
+	hfi2_write_csr(dd, JKR_MCTXT_PF0_INT_ENABLE,
+		  JKR_MCTXT_INT_INBOX_FULL | JKR_MCTXT_INT_OUTBOX_EMPTY);
+	hfi2_set_intr_bits(dd, JKR_MCTXT_CPORT_TO_PCIE_INT,
+		      JKR_MCTXT_CPORT_TO_PCIE_INT, true);
+	timer_setup(&cport->lost_int_timer, cport_lost_int_chk, 0);
+	if (cport_lost_int)
+		mod_timer(&cport->lost_int_timer, jiffies + cport_lost_int);
+#endif
+
+	/*
+	 * Must reset/resync sequence numbers as CPORT is strictly enforcing
+	 * sequence number order. Use a timeout to allow easier cleanup should
+	 * init fail.
+	 */
+	hfi2_cport_send_notif(dd, CH_OP_PING, 0, NULL, 0, hfi2_cport_adm_to * HZ);
+	return 0;
+
+err1:
+	return -ENOMEM;
+}
+
+/*
+ * Deinitialization of MCTXT CPORT communications channel.
+ */
+int hfi2_cport_exit(struct hfi2_devdata *dd)
+{
+	if (!dd->cport)
+		return 0;
+
+	timer_delete_sync(&dd->cport->lost_int_timer);
+	/* flush all cport queued tasks (plus anything else on this queue) */
+	flush_workqueue(dd->hfi2_wq);
+
+	/* Disable intr source for MCTXT from CPORT (to PF0) */
+	hfi2_set_intr_bits(dd, JKR_MCTXT_CPORT_TO_PCIE_INT,
+		      JKR_MCTXT_CPORT_TO_PCIE_INT, false);
+	hfi2_write_csr(dd, JKR_MCTXT_PF0_INT_ENABLE, 0);
+	/* leave JKR_MCTXT_INT_OUTBOX_EMPTY set so that future users are ready-to-go */
+	hfi2_write_csr(dd, JKR_MCTXT_PF0_INT_STATUS, JKR_MCTXT_INT_OUTBOX_EMPTY);
+#ifdef CONFIG_HFI_CPORT_POLLING
+	if (dd->cport->poll_th)
+		kthread_stop(dd->cport->poll_th);
+#endif
+	if (dd->cport->ping_th)
+		kthread_stop(dd->cport->ping_th);
+
+	cancel_work(&dd->cport->mctxt_work);
+
+	xa_destroy(&dd->cport->tid_xa);
+	xa_destroy(&dd->cport->trap_xa);
+	kfree(dd->cport);
+	dd->cport = NULL;
+
+	return 0;
+}



