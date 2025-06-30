Return-Path: <linux-rdma+bounces-11786-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AADAEE647
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3424E171F47
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFB42E613E;
	Mon, 30 Jun 2025 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="VMj2lWu1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2129.outbound.protection.outlook.com [40.107.100.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF672E6D1D
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306314; cv=fail; b=lOr2hs4PaOtQ7E0AfB2leM1Z6lUMkKHY36x6MLRxM887gLPqFrxNyOMRLAX7zdAMkbPQnIdUg0DG63wAOxYuEdiEMHn2rrpYbUEkmGuo1IzQyfzUkQJkFg3GfdnyclexiaFsscaxjyIkTc389IiP2JuYKMTAQzqZ44JyVy4NerU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306314; c=relaxed/simple;
	bh=3+cOhWqWvtb5iEaj7Eb4ZdhUUGERCQ8PgseUanBdaLk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4lxV14GrFhSr8KpFL8yMIMRO/9tuywPud50zEebqjd75cVLF2EuK565pRcgyXqYi13j+plnhivRL5S9XMW481R7NFKZtOFA9UzpC47XbR5IUDLt9endq3aKiVOwEs8ImBEzuOnMOOZT8dAnRK/iPEDeUUiHScrVSQqyzTNsHBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=VMj2lWu1; arc=fail smtp.client-ip=40.107.100.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BC6y7E/xseuyRZDL0Jrbn8LIztrq2S57m8oYNEY8v3nZhgpYCjPcbP4J3CVIiSMZ2wVmn+3fBATUw0doIgp/k+eUAuCbu0mq2ZftGw3E1pdTM4O90Thf8xfh8c91uP71l1znscEXB7EjSga6Yi4tpUBaoT6vL9UpBeOFiAx7AnveenTyW6KKIomOKXGTikuYdY0n5L6TnnSrrCC6q+lLg8lD7/O2Lj61Twn6bKmN6GXd1BeTO2plSjCcmxNKnMXAfmLWHmOd6K4igptAjfDrK5YjDpdcaGgxlCGGCQjYHK65O5L8SHfVAKaw4QTvq3lFWTnaHIyzuXm3oK2L/qBEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oi3L6EP+9kJVvD+59Gi/dY8If3+DGXhcApMfGsAKGTc=;
 b=VcEbQsZTneD7zTA38WZ9gAEpQAKlPsc9huyeuR/mewZB7Wu3JmKqXpJO99C52dc9pKYQafnuhpSqA/fxuP0m+g7CfSkChtXW9CMhO5mddTQBpYqrFy7qUvFZ9h1fR8bQsowMuC6KBTOUdNROiPeWRBONIBjeD3DI4gamqCqf9pxVdwZpFW2DckHaLeNPAkQHH2/A67fE4PvKg3Fl9BRPeMkh54nZn0AnGwBzYjotovM5GqHc7qt0QPOPsAS31Trww/yd38wpdI1RUe9GzLfcc017giOkOhhgiYqskrS2IghNyU/LJwZ2EWihX5Is3MMMBEWIi5ur079RZPMcNYDKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oi3L6EP+9kJVvD+59Gi/dY8If3+DGXhcApMfGsAKGTc=;
 b=VMj2lWu1NagTGHKIjaIxQfGu2dR0jzMbl/TtbIrRBOEWgh3p9vL1spq7NFfZj7DHUwSk3J9FzRtwaaMZLggJmvfamQX6tYkV79fZiOyVtb2+uahTM6GBBwUu3caUgI5ZpSzQ63L2aBPGZAz0A7DLFuQ0ACpCROOQdOfAVDknnHefy/T1zIbnqEFRIvj5J19ugSZxqGz9i1S6njjjB4Cx+AzLSpC/eYgI1EMkKyx7/WlFBcTs8NBciNGGeDU9vFGNfRfdxGM3HWRpBd4pBw5k0aSg6fCVyXvxQVto7ckYc5AQcbwIC/vQVrwIeyByfl8nuxwi7cwu5ZSVJGnYVSCyCA==
Received: from SJ2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:a03:505::20)
 by SJ2PR01MB8151.prod.exchangelabs.com (2603:10b6:a03:500::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.25; Mon, 30 Jun 2025 17:58:09 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::9e) by SJ2PR07CA0011.outlook.office365.com
 (2603:10b6:a03:505::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.32 via Frontend Transport; Mon,
 30 Jun 2025 17:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:07 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id BC2BE14D71B;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id D93911848B5DD;
	Mon, 30 Jun 2025 11:31:23 -0400 (EDT)
Subject: [PATCH for-next 19/23] RDMA/hfi2: Add in support for verbs
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:31:23 -0400
Message-ID:
 <175129748380.1859400.2079032224081921772.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SJ2PR01MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: c743668e-4307-4258-bbe4-08ddb7ffab61
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGo2SjIrMHBzWExtK1NmcXZtb01nSkYzVWVqUVQyNndVcnJqcXcwZGlPemVh?=
 =?utf-8?B?djF0Uk1hQ3VZUVN3c0ZwVHBxbWxKY0I2TjJsQ1d1TnZ5bTZWaFFySmJ0V1Y3?=
 =?utf-8?B?Nlk1RUVXWnMrOGNiRmtnTEY2L3h1SThGV3I3N2hiNGRHcnQvRGlZNTlxaDBj?=
 =?utf-8?B?Y29RMnRzakszcEJLY0owT0svR1V4S21QS3Q3RHFwUU5ya01WbTJQRlY5eTdE?=
 =?utf-8?B?OFVHY1ltQm1LSmNSdzNMbmt0MVRYNVo3R28yRFE4ZGJXRnNaOXJRNHdySmlk?=
 =?utf-8?B?SHdJMGljWHB4Tmc0Qi84eG9tUEY1ZVdYMkFudXcrTWFCOVlkSnlmaGRYTGFr?=
 =?utf-8?B?eUtXdzJlSkFubG5NUWx2c2tnT0hlcE1mUEFkQmVWWkhtSmpnS21KOTlMRWFo?=
 =?utf-8?B?bW4yb1NtYkpUYi9GTG81azBLeVIvYU1hZytXdXVuVkE0TEJFSGo2SitlRU9m?=
 =?utf-8?B?VnErNU1sWlRiWDQ0dWhFOXpFbkdtVkFOR2xlQjhxYkZQTlJRQTdMeDFzZkdL?=
 =?utf-8?B?eitiM3AvVFpUa2hSMnJyV1pHaXo3bXFiZk1mQVk4QVJmQ1ltdFk4V296Y2Zr?=
 =?utf-8?B?QWVxaUFHbE1XYU1yOEFzUjJIbG5Ea1ppUFBna0h6dkVVb2psOGhsNHovcGxL?=
 =?utf-8?B?VzRldk11RDF2MFN5bTVSTWRETzBKRXFONEZMYWNieEFRdHREcVlOWlE0ZU0y?=
 =?utf-8?B?d2NnNU5STjF2Ym5qOW03L2tLZFA1Zm1OOHA1R3FCNU1UMUU2VmZ4SU1uMW5n?=
 =?utf-8?B?VVA5M2k5V2EyVUlHOG9BUjlYb0RkaHVlbjdmMDRTUlQ3Qzd2bDB3N0IraVRv?=
 =?utf-8?B?bnZDT1FpVWM2bzJySklTaXRpa3lCNjhpV3RodTVPRlo3OEtGZTBmTlVLVk0w?=
 =?utf-8?B?SHR2azhLV3JCNXY5aCsrT2dZU3psUEU0ZXFKSWQrK3F0Ym1CSTV1VS9CbmYy?=
 =?utf-8?B?YVdYUU90M1g5L08ySVo1SUZCYjlSMXp0cGIyY0lpNC84MU50TFdoTWVOK0pl?=
 =?utf-8?B?alBrcWd3emtjZndzRHo5S1RCV293dEpVMGFGOGN5aWF3M0oxTXZ5N2MwMmsy?=
 =?utf-8?B?UnZwSzRZWDJ6Y0Q3MThNZGN4YXppTzJ4M3pmeHp4YVpNZEhMbTF5UkVpejc2?=
 =?utf-8?B?eUJOc0svUFdpZm55MktHWFVZeHNoUHUxKzFaS0NxbUNuWVVOb1hjMi9BOHNV?=
 =?utf-8?B?R0N5S3BVaUdMYXBpT2lHSDVjVEZ2UVhNcWx5aGhzZUpyL3VVNGtOamlSVzE2?=
 =?utf-8?B?RENJcVpVZDI2czkyQ21DRngxN0xXc2hQbzVxcEllSllaaFJXWG9JbzRNNG92?=
 =?utf-8?B?YzFGWHQxb3FkK2I4WmdsYm04c3I4ZEM0aFJ2WEh4UGZTRFNqUGgrZm55U2sx?=
 =?utf-8?B?Zkx1c0NzYThxNnVqdGthN1lhcHFRekFTTThTd3I2aHd2bDd0ajVjeUU5a3dn?=
 =?utf-8?B?dlFrdHowT1NBVGdOcUlld2ZzYWIxTXFpcSt4aTZRSVhnclRqdjJmTHlSSWt5?=
 =?utf-8?B?c1picDBrcjNPbmk3Z242Ty9Pek5hb1VtaTI5dUkzV1ZYeko4NUdWV09WVFlN?=
 =?utf-8?B?dGRqQzFGUDlWa1hJRXdJUlZ2TlpCdlJodGVCY2ErWDg2bkVKQzIzeTJxS3dp?=
 =?utf-8?B?MytvcDZZUzR5TWJybG5YL1ZQRXZFN2U4bno3VWQ5emJTd2J6TUZiZ1M2S3B1?=
 =?utf-8?B?bTRqcHJWeFF6Uis3cm1VNFpzb1pXL1RKY3YyNU91WW01TnJleFB5UGVJNHl4?=
 =?utf-8?B?a1IyRlNjdUh1TXE3UTZuRXRtWEw5NVdYcDNGZUlsejU3QnZIOCtCcU9RbEdx?=
 =?utf-8?B?U1BzOTM4K2tCMTY4YjRqT0ZoVHAwdFREeDNKU2V3QVhPdzFSWVMrWGxOMmpL?=
 =?utf-8?B?eGxTWnVhbVAzSi9LUVpXNGphTTlSV3F3akJCZFJRNlpNTHFEclhCTWRhbzRm?=
 =?utf-8?B?cEVGNFFPd3lTemFTSWJ2Q3B5VEFmTVUrdWYreUhXcU8zckVySXBRY0hKTUJq?=
 =?utf-8?B?aTR0dTFDL2ZNUm5jR3MvaENHVE5hRzVPZ2xTOS9SVUxjeXZEOUNCSHZ3VU9y?=
 =?utf-8?Q?dlmaps?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:07.4058
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c743668e-4307-4258-bbe4-08ddb7ffab61
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8151

The new hfi2 supports verbs in the same way as hfi1 did. We use rdmavt.
While technically possible to fold rdmavt back into the driver now that qib
has been (is being) removed we opt not to do this. That would introduce a
lot of churn that's not necessary right now and we also have plans to
leverage rdmavt for adding support for RoCE in future generations of the
HW.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/opfn.c        |  323 ++
 drivers/infiniband/hw/hfi2/qp.c          |  949 +++++
 drivers/infiniband/hw/hfi2/rc.c          | 3259 ++++++++++++++++++
 drivers/infiniband/hw/hfi2/ruc.c         |  595 +++
 drivers/infiniband/hw/hfi2/tid_rdma.c    | 5538 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/uc.c          |  542 +++
 drivers/infiniband/hw/hfi2/ud.c          | 1030 ++++++
 drivers/infiniband/hw/hfi2/uverbs.c      |  598 +++
 drivers/infiniband/hw/hfi2/verbs.c       | 2052 +++++++++++
 drivers/infiniband/hw/hfi2/verbs_txreq.c |  100 +
 10 files changed, 14986 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/opfn.c
 create mode 100644 drivers/infiniband/hw/hfi2/qp.c
 create mode 100644 drivers/infiniband/hw/hfi2/rc.c
 create mode 100644 drivers/infiniband/hw/hfi2/ruc.c
 create mode 100644 drivers/infiniband/hw/hfi2/tid_rdma.c
 create mode 100644 drivers/infiniband/hw/hfi2/uc.c
 create mode 100644 drivers/infiniband/hw/hfi2/ud.c
 create mode 100644 drivers/infiniband/hw/hfi2/uverbs.c
 create mode 100644 drivers/infiniband/hw/hfi2/verbs.c
 create mode 100644 drivers/infiniband/hw/hfi2/verbs_txreq.c

diff --git a/drivers/infiniband/hw/hfi2/opfn.c b/drivers/infiniband/hw/hfi2/opfn.c
new file mode 100644
index 000000000000..88b03fcd4628
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/opfn.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ *
+ */
+#include "hfi2.h"
+#include "trace.h"
+#include "qp.h"
+#include "opfn.h"
+
+#define IB_BTHE_E                 BIT(IB_BTHE_E_SHIFT)
+
+#define OPFN_CODE(code) BIT((code) - 1)
+#define OPFN_MASK(code) OPFN_CODE(STL_VERBS_EXTD_##code)
+
+struct hfi2_opfn_type {
+	bool (*request)(struct rvt_qp *qp, u64 *data);
+	bool (*response)(struct rvt_qp *qp, u64 *data);
+	bool (*reply)(struct rvt_qp *qp, u64 data);
+	void (*error)(struct rvt_qp *qp);
+};
+
+static struct hfi2_opfn_type hfi2_opfn_handlers[STL_VERBS_EXTD_MAX] = {
+	[STL_VERBS_EXTD_TID_RDMA] = {
+		.request = tid_rdma_conn_req,
+		.response = tid_rdma_conn_resp,
+		.reply = tid_rdma_conn_reply,
+		.error = tid_rdma_conn_error,
+	},
+};
+
+static struct workqueue_struct *opfn_wq;
+
+static void opfn_schedule_conn_request(struct rvt_qp *qp);
+
+static bool hfi2_opfn_extended(u32 bth1)
+{
+	return !!(bth1 & IB_BTHE_E);
+}
+
+static void opfn_conn_request(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_atomic_wr wr;
+	u16 mask, capcode;
+	struct hfi2_opfn_type *extd;
+	u64 data;
+	unsigned long flags;
+	int ret = 0;
+
+	trace_hfi2_opfn_state_conn_request(qp);
+	spin_lock_irqsave(&priv->opfn.lock, flags);
+	/*
+	 * Exit if the extended bit is not set, or if nothing is requested, or
+	 * if we have completed all requests, or if a previous request is in
+	 * progress
+	 */
+	if (!priv->opfn.extended || !priv->opfn.requested ||
+	    priv->opfn.requested == priv->opfn.completed || priv->opfn.curr)
+		goto done;
+
+	mask = priv->opfn.requested & ~priv->opfn.completed;
+	capcode = ilog2(mask & ~(mask - 1)) + 1;
+	if (capcode >= STL_VERBS_EXTD_MAX) {
+		priv->opfn.completed |= OPFN_CODE(capcode);
+		goto done;
+	}
+
+	extd = &hfi2_opfn_handlers[capcode];
+	if (!extd || !extd->request || !extd->request(qp, &data)) {
+		/*
+		 * Either there is no handler for this capability or the request
+		 * packet could not be generated. Either way, mark it as done so
+		 * we don't keep attempting to complete it.
+		 */
+		priv->opfn.completed |= OPFN_CODE(capcode);
+		goto done;
+	}
+
+	trace_hfi2_opfn_data_conn_request(qp, capcode, data);
+	data = (data & ~0xf) | capcode;
+
+	memset(&wr, 0, sizeof(wr));
+	wr.wr.opcode = IB_WR_OPFN;
+	wr.remote_addr = HFI2_VERBS_E_ATOMIC_VADDR;
+	wr.compare_add = data;
+
+	priv->opfn.curr = capcode;	/* A new request is now in progress */
+	/* Drop opfn.lock before calling ib_post_send() */
+	spin_unlock_irqrestore(&priv->opfn.lock, flags);
+
+	ret = ib_post_send(&qp->ibqp, &wr.wr, NULL);
+	if (ret)
+		goto err;
+	trace_hfi2_opfn_state_conn_request(qp);
+	return;
+err:
+	trace_hfi2_msg_opfn_conn_request(qp, "ib_ost_send failed: ret = ",
+					 (u64)ret);
+	spin_lock_irqsave(&priv->opfn.lock, flags);
+	/*
+	 * In case of an unexpected error return from ib_post_send
+	 * clear opfn.curr and reschedule to try again
+	 */
+	priv->opfn.curr = STL_VERBS_EXTD_NONE;
+	opfn_schedule_conn_request(qp);
+done:
+	spin_unlock_irqrestore(&priv->opfn.lock, flags);
+}
+
+void opfn_send_conn_request(struct work_struct *work)
+{
+	struct hfi2_opfn_data *od;
+	struct hfi2_qp_priv *qpriv;
+
+	od = container_of(work, struct hfi2_opfn_data, opfn_work);
+	qpriv = container_of(od, struct hfi2_qp_priv, opfn);
+
+	opfn_conn_request(qpriv->owner);
+}
+
+/*
+ * When QP s_lock is held in the caller, the OPFN request must be scheduled
+ * to a different workqueue to avoid double locking QP s_lock in call to
+ * ib_post_send in opfn_conn_request
+ */
+static void opfn_schedule_conn_request(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	trace_hfi2_opfn_state_sched_conn_request(qp);
+	queue_work(opfn_wq, &priv->opfn.opfn_work);
+}
+
+void opfn_conn_response(struct rvt_qp *qp, struct rvt_ack_entry *e,
+			struct ib_atomic_eth *ateth)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	u64 data = be64_to_cpu(ateth->compare_data);
+	struct hfi2_opfn_type *extd;
+	u8 capcode;
+	unsigned long flags;
+
+	trace_hfi2_opfn_state_conn_response(qp);
+	capcode = data & 0xf;
+	trace_hfi2_opfn_data_conn_response(qp, capcode, data);
+	if (!capcode || capcode >= STL_VERBS_EXTD_MAX)
+		return;
+
+	extd = &hfi2_opfn_handlers[capcode];
+
+	if (!extd || !extd->response) {
+		e->atomic_data = capcode;
+		return;
+	}
+
+	spin_lock_irqsave(&priv->opfn.lock, flags);
+	if (priv->opfn.completed & OPFN_CODE(capcode)) {
+		/*
+		 * We are receiving a request for a feature that has already
+		 * been negotiated. This may mean that the other side has reset
+		 */
+		priv->opfn.completed &= ~OPFN_CODE(capcode);
+		if (extd->error)
+			extd->error(qp);
+	}
+
+	if (extd->response(qp, &data))
+		priv->opfn.completed |= OPFN_CODE(capcode);
+	e->atomic_data = (data & ~0xf) | capcode;
+	trace_hfi2_opfn_state_conn_response(qp);
+	spin_unlock_irqrestore(&priv->opfn.lock, flags);
+}
+
+void opfn_conn_reply(struct rvt_qp *qp, u64 data)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_opfn_type *extd;
+	u8 capcode;
+	unsigned long flags;
+
+	trace_hfi2_opfn_state_conn_reply(qp);
+	capcode = data & 0xf;
+	trace_hfi2_opfn_data_conn_reply(qp, capcode, data);
+	if (!capcode || capcode >= STL_VERBS_EXTD_MAX)
+		return;
+
+	spin_lock_irqsave(&priv->opfn.lock, flags);
+	/*
+	 * Either there is no previous request or the reply is not for the
+	 * current request
+	 */
+	if (!priv->opfn.curr || capcode != priv->opfn.curr)
+		goto done;
+
+	extd = &hfi2_opfn_handlers[capcode];
+
+	if (!extd || !extd->reply)
+		goto clear;
+
+	if (extd->reply(qp, data))
+		priv->opfn.completed |= OPFN_CODE(capcode);
+clear:
+	/*
+	 * Clear opfn.curr to indicate that the previous request is no longer in
+	 * progress
+	 */
+	priv->opfn.curr = STL_VERBS_EXTD_NONE;
+	trace_hfi2_opfn_state_conn_reply(qp);
+done:
+	spin_unlock_irqrestore(&priv->opfn.lock, flags);
+}
+
+void opfn_conn_error(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_opfn_type *extd = NULL;
+	unsigned long flags;
+	u16 capcode;
+
+	trace_hfi2_opfn_state_conn_error(qp);
+	trace_hfi2_msg_opfn_conn_error(qp, "error. qp state ", (u64)qp->state);
+	/*
+	 * The QP has gone into the Error state. We have to invalidate all
+	 * negotiated feature, including the one in progress (if any). The RC
+	 * QP handling will clean the WQE for the connection request.
+	 */
+	spin_lock_irqsave(&priv->opfn.lock, flags);
+	while (priv->opfn.completed) {
+		capcode = priv->opfn.completed & ~(priv->opfn.completed - 1);
+		extd = &hfi2_opfn_handlers[ilog2(capcode) + 1];
+		if (extd->error)
+			extd->error(qp);
+		priv->opfn.completed &= ~OPFN_CODE(capcode);
+	}
+	priv->opfn.extended = 0;
+	priv->opfn.requested = 0;
+	priv->opfn.curr = STL_VERBS_EXTD_NONE;
+	spin_unlock_irqrestore(&priv->opfn.lock, flags);
+}
+
+void opfn_qp_init(struct rvt_qp *qp, struct ib_qp_attr *attr, int attr_mask)
+{
+	struct ib_qp *ibqp = &qp->ibqp;
+	struct hfi2_qp_priv *priv = qp->priv;
+	unsigned long flags;
+
+	if (attr_mask & IB_QP_RETRY_CNT)
+		priv->s_retry = attr->retry_cnt;
+
+	spin_lock_irqsave(&priv->opfn.lock, flags);
+	if (ibqp->qp_type == IB_QPT_RC && HFI2_CAP_IS_KSET(TID_RDMA)) {
+		struct tid_rdma_params *local = &priv->tid_rdma.local;
+
+		if (attr_mask & IB_QP_TIMEOUT)
+			priv->tid_retry_timeout_jiffies = qp->timeout_jiffies;
+		if (qp->pmtu == enum_to_mtu(OPA_MTU_4096) ||
+		    qp->pmtu == enum_to_mtu(OPA_MTU_8192)) {
+			tid_rdma_opfn_init(qp, local);
+			/*
+			 * We only want to set the OPFN requested bit when the
+			 * QP transitions to RTS.
+			 */
+			if (attr_mask & IB_QP_STATE &&
+			    attr->qp_state == IB_QPS_RTS) {
+				priv->opfn.requested |= OPFN_MASK(TID_RDMA);
+				/*
+				 * If the QP is transitioning to RTS and the
+				 * opfn.completed for TID RDMA has already been
+				 * set, the QP is being moved *back* into RTS.
+				 * We can now renegotiate the TID RDMA
+				 * parameters.
+				 */
+				if (priv->opfn.completed &
+				    OPFN_MASK(TID_RDMA)) {
+					priv->opfn.completed &=
+						~OPFN_MASK(TID_RDMA);
+					/*
+					 * Since the opfn.completed bit was
+					 * already set, it is safe to assume
+					 * that the opfn.extended is also set.
+					 */
+					opfn_schedule_conn_request(qp);
+				}
+			}
+		} else {
+			memset(local, 0, sizeof(*local));
+		}
+	}
+	spin_unlock_irqrestore(&priv->opfn.lock, flags);
+}
+
+void opfn_trigger_conn_request(struct rvt_qp *qp, u32 bth1)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (!priv->opfn.extended && hfi2_opfn_extended(bth1) &&
+	    HFI2_CAP_IS_KSET(OPFN)) {
+		priv->opfn.extended = 1;
+		if (qp->state == IB_QPS_RTS)
+			opfn_conn_request(qp);
+	}
+}
+
+int opfn_init(void)
+{
+	opfn_wq = alloc_workqueue("hfi2_opfn",
+				  WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE |
+				  WQ_MEM_RECLAIM,
+				  HFI2_MAX_ACTIVE_WORKQUEUE_ENTRIES);
+	if (!opfn_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void opfn_exit(void)
+{
+	if (opfn_wq) {
+		destroy_workqueue(opfn_wq);
+		opfn_wq = NULL;
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/qp.c b/drivers/infiniband/hw/hfi2/qp.c
new file mode 100644
index 000000000000..89e778ae2fe6
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/qp.c
@@ -0,0 +1,949 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ */
+
+#include <linux/err.h>
+#include <linux/vmalloc.h>
+#include <linux/hash.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <rdma/rdma_vt.h>
+#include <rdma/rdmavt_qp.h>
+#include <rdma/ib_verbs.h>
+
+#include "hfi2.h"
+#include "qp.h"
+#include "trace.h"
+#include "verbs_txreq.h"
+
+unsigned int hfi2_qp_table_size = 256;
+module_param_named(qp_table_size, hfi2_qp_table_size, uint, S_IRUGO);
+MODULE_PARM_DESC(qp_table_size, "QP table size");
+
+static void flush_tx_list(struct rvt_qp *qp);
+static int iowait_sleep(
+	struct sdma_engine *sde,
+	struct iowait_work *wait,
+	struct sdma_txreq *stx,
+	unsigned int seq,
+	bool pkts_sent);
+static void iowait_wakeup(struct iowait *wait, int reason);
+static void iowait_sdma_drained(struct iowait *wait);
+static void qp_pio_drain(struct rvt_qp *qp);
+
+const struct rvt_operation_params hfi2_post_parms[RVT_OPERATION_MAX] = {
+[IB_WR_RDMA_WRITE] = {
+	.length = sizeof(struct ib_rdma_wr),
+	.qpt_support = BIT(IB_QPT_UC) | BIT(IB_QPT_RC),
+},
+
+[IB_WR_RDMA_READ] = {
+	.length = sizeof(struct ib_rdma_wr),
+	.qpt_support = BIT(IB_QPT_RC),
+	.flags = RVT_OPERATION_ATOMIC,
+},
+
+[IB_WR_ATOMIC_CMP_AND_SWP] = {
+	.length = sizeof(struct ib_atomic_wr),
+	.qpt_support = BIT(IB_QPT_RC),
+	.flags = RVT_OPERATION_ATOMIC | RVT_OPERATION_ATOMIC_SGE,
+},
+
+[IB_WR_ATOMIC_FETCH_AND_ADD] = {
+	.length = sizeof(struct ib_atomic_wr),
+	.qpt_support = BIT(IB_QPT_RC),
+	.flags = RVT_OPERATION_ATOMIC | RVT_OPERATION_ATOMIC_SGE,
+},
+
+[IB_WR_RDMA_WRITE_WITH_IMM] = {
+	.length = sizeof(struct ib_rdma_wr),
+	.qpt_support = BIT(IB_QPT_UC) | BIT(IB_QPT_RC),
+},
+
+[IB_WR_SEND] = {
+	.length = sizeof(struct ib_send_wr),
+	.qpt_support = BIT(IB_QPT_UD) | BIT(IB_QPT_SMI) | BIT(IB_QPT_GSI) |
+		       BIT(IB_QPT_UC) | BIT(IB_QPT_RC),
+},
+
+[IB_WR_SEND_WITH_IMM] = {
+	.length = sizeof(struct ib_send_wr),
+	.qpt_support = BIT(IB_QPT_UD) | BIT(IB_QPT_SMI) | BIT(IB_QPT_GSI) |
+		       BIT(IB_QPT_UC) | BIT(IB_QPT_RC),
+},
+
+[IB_WR_REG_MR] = {
+	.length = sizeof(struct ib_reg_wr),
+	.qpt_support = BIT(IB_QPT_UC) | BIT(IB_QPT_RC),
+	.flags = RVT_OPERATION_LOCAL,
+},
+
+[IB_WR_LOCAL_INV] = {
+	.length = sizeof(struct ib_send_wr),
+	.qpt_support = BIT(IB_QPT_UC) | BIT(IB_QPT_RC),
+	.flags = RVT_OPERATION_LOCAL,
+},
+
+[IB_WR_SEND_WITH_INV] = {
+	.length = sizeof(struct ib_send_wr),
+	.qpt_support = BIT(IB_QPT_RC),
+},
+
+[IB_WR_OPFN] = {
+	.length = sizeof(struct ib_atomic_wr),
+	.qpt_support = BIT(IB_QPT_RC),
+	.flags = RVT_OPERATION_USE_RESERVE,
+},
+
+[IB_WR_TID_RDMA_WRITE] = {
+	.length = sizeof(struct ib_rdma_wr),
+	.qpt_support = BIT(IB_QPT_RC),
+	.flags = RVT_OPERATION_IGN_RNR_CNT,
+},
+
+};
+
+static void flush_list_head(struct list_head *l)
+{
+	while (!list_empty(l)) {
+		struct sdma_txreq *tx;
+
+		tx = list_first_entry(
+			l,
+			struct sdma_txreq,
+			list);
+		list_del_init(&tx->list);
+		hfi2_put_txreq(
+			container_of(tx, struct verbs_txreq, txreq));
+	}
+}
+
+static void flush_tx_list(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	flush_list_head(&iowait_get_ib_work(&priv->s_iowait)->tx_head);
+	flush_list_head(&iowait_get_tid_work(&priv->s_iowait)->tx_head);
+}
+
+static void flush_iowait(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	unsigned long flags;
+	seqlock_t *lock = priv->s_iowait.lock;
+
+	if (!lock)
+		return;
+	write_seqlock_irqsave(lock, flags);
+	if (!list_empty(&priv->s_iowait.list)) {
+		list_del_init(&priv->s_iowait.list);
+		priv->s_iowait.lock = NULL;
+		rvt_put_qp(qp);
+	}
+	write_sequnlock_irqrestore(lock, flags);
+}
+
+/*
+ * This function is what we would push to the core layer if we wanted to be a
+ * "first class citizen".  Instead we hide this here and rely on Verbs ULPs
+ * to blindly pass the MTU enum value from the PathRecord to us.
+ */
+static inline int verbs_mtu_enum_to_int(struct ib_device *dev, enum ib_mtu mtu)
+{
+	/* Constraining 10KB packets to 8KB packets */
+	if (mtu == (enum ib_mtu)OPA_MTU_10240)
+		mtu = (enum ib_mtu)OPA_MTU_8192;
+	return opa_mtu_enum_to_int((enum opa_mtu)mtu);
+}
+
+int hfi2_check_modify_qp(struct rvt_qp *qp, struct ib_qp_attr *attr,
+			 int attr_mask, struct ib_udata *udata)
+{
+	struct ib_qp *ibqp = &qp->ibqp;
+	struct hfi2_ibdev *dev = to_idev(ibqp->device);
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+	u8 sc;
+
+	if (attr_mask & IB_QP_AV) {
+		sc = ah_to_sc(ibqp->device, &attr->ah_attr);
+		if (sc == 0xf)
+			return -EINVAL;
+
+		if (!qp_to_sdma_engine(qp, sc) &&
+		    dd->flags & HFI2_HAS_SEND_DMA)
+			return -EINVAL;
+
+		if (!qp_to_send_context(qp, sc))
+			return -EINVAL;
+	}
+
+	if (attr_mask & IB_QP_ALT_PATH) {
+		sc = ah_to_sc(ibqp->device, &attr->alt_ah_attr);
+		if (sc == 0xf)
+			return -EINVAL;
+
+		if (!qp_to_sdma_engine(qp, sc) &&
+		    dd->flags & HFI2_HAS_SEND_DMA)
+			return -EINVAL;
+
+		if (!qp_to_send_context(qp, sc))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * qp_set_16b - Set the hdr_type based on whether the slid or the
+ * dlid in the connection is extended. Only applicable for RC and UC
+ * QPs. UD QPs determine this on the fly from the ah in the wqe
+ */
+static inline void qp_set_16b(struct rvt_qp *qp)
+{
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ibport *ibp;
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	/* Update ah_attr to account for extended LIDs */
+	hfi2_update_ah_attr(qp->ibqp.device, &qp->remote_ah_attr);
+
+	/* Create 32 bit LIDs */
+	hfi2_make_opa_lid(&qp->remote_ah_attr);
+
+	if (!(rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH))
+		return;
+
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+	ppd = ppd_from_ibp(ibp);
+	priv->hdr_type = hfi2_get_hdr_type(ppd->lid, &qp->remote_ah_attr);
+}
+
+void hfi2_modify_qp(struct rvt_qp *qp, struct ib_qp_attr *attr,
+		    int attr_mask, struct ib_udata *udata)
+{
+	struct ib_qp *ibqp = &qp->ibqp;
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (attr_mask & IB_QP_AV) {
+		priv->s_sc = ah_to_sc(ibqp->device, &qp->remote_ah_attr);
+		priv->s_sde = qp_to_sdma_engine(qp, priv->s_sc);
+		priv->s_sendcontext = qp_to_send_context(qp, priv->s_sc);
+		qp_set_16b(qp);
+	}
+
+	if (attr_mask & IB_QP_PATH_MIG_STATE &&
+	    attr->path_mig_state == IB_MIG_MIGRATED &&
+	    qp->s_mig_state == IB_MIG_ARMED) {
+		qp->s_flags |= HFI2_S_AHG_CLEAR;
+		priv->s_sc = ah_to_sc(ibqp->device, &qp->remote_ah_attr);
+		priv->s_sde = qp_to_sdma_engine(qp, priv->s_sc);
+		priv->s_sendcontext = qp_to_send_context(qp, priv->s_sc);
+		qp_set_16b(qp);
+	}
+
+	if (attr_mask & IB_QP_PORT) {
+		/*
+		 * Set or replace associated receive context based on the new
+		 * port number.  Note: At call time, qp->port_num is updated,
+		 * but qp->ibqp.port is not updated.
+		 */
+		priv->rcd = qp_to_rcd(qp);
+	}
+
+	opfn_qp_init(qp, attr, attr_mask);
+}
+
+/**
+ * hfi2_setup_wqe - set up the wqe
+ * @qp: The qp
+ * @wqe: The built wqe
+ * @call_send: Determine if the send should be posted or scheduled.
+ *
+ * Perform setup of the wqe.  This is called
+ * prior to inserting the wqe into the ring but after
+ * the wqe has been setup by RDMAVT. This function
+ * allows the driver the opportunity to perform
+ * validation and additional setup of the wqe.
+ *
+ * Returns 0 on success, -EINVAL on failure
+ *
+ */
+int hfi2_setup_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe, bool *call_send)
+{
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct rvt_ah *ah;
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_RC:
+		hfi2_setup_tid_rdma_wqe(qp, wqe);
+		fallthrough;
+	case IB_QPT_UC:
+		if (wqe->length > 0x80000000U)
+			return -EINVAL;
+		if (wqe->length > qp->pmtu)
+			*call_send = false;
+		break;
+	case IB_QPT_SMI:
+		/*
+		 * SM packets should exclusively use VL15 and their SL is
+		 * ignored (IBTA v1.3, Section 3.5.8.2). Therefore, when ah
+		 * is created, SL is 0 in most cases and as a result some
+		 * fields (vl and pmtu) in ah may not be set correctly,
+		 * depending on the SL2SC and SC2VL tables at the time.
+		 */
+		if (wqe->length > ppd->vld[15].mtu)
+			return -EINVAL;
+		break;
+	case IB_QPT_GSI:
+	case IB_QPT_UD:
+		ah = rvt_get_swqe_ah(wqe);
+		if (wqe->length > (1 << ah->log_pmtu))
+			return -EINVAL;
+		if (ibp->sl_to_sc[rdma_ah_get_sl(&ah->attr)] == 0xf)
+			return -EINVAL;
+		break;
+	default:
+		break;
+	}
+
+	/*
+	 * Reject any non-SMP transmit attempts unless the link is ACTIVE
+	 * or ARMED + NeighborNormal.
+	 */
+	if (qp->ibqp.qp_type != IB_QPT_SMI &&
+	    !(ppd->host_link_state == HLS_UP_ACTIVE ||
+	     (ppd->host_link_state == HLS_UP_ARMED && ppd->neighbor_normal))) {
+		return -EINVAL;
+	}
+
+	/*
+	 * System latency between send and schedule is large enough that
+	 * forcing call_send to true for piothreshold packets is necessary.
+	 */
+	if (wqe->length <= piothreshold)
+		*call_send = true;
+	return 0;
+}
+
+/**
+ * _hfi2_schedule_send - schedule progress
+ * @qp: the QP
+ *
+ * This schedules qp progress w/o regard to the s_flags.
+ *
+ * It is only used in the post send, which doesn't hold
+ * the s_lock.
+ */
+bool _hfi2_schedule_send(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ibport *ibp =
+		to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	if (dd->flags & HFI2_SHUTDOWN)
+		return true;
+
+	return iowait_schedule(&priv->s_iowait, dd->hfi2_wq,
+			       priv->s_sde ?
+			       priv->s_sde->cpu :
+			       cpumask_first(cpumask_of_node(dd->node)));
+}
+
+static void qp_pio_drain(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (!priv->s_sendcontext)
+		return;
+	while (iowait_pio_pending(&priv->s_iowait)) {
+		write_seqlock_irq(&priv->s_sendcontext->waitlock);
+		hfi2_sc_wantpiobuf_intr(priv->s_sendcontext, 1);
+		write_sequnlock_irq(&priv->s_sendcontext->waitlock);
+		iowait_pio_drain(&priv->s_iowait);
+		write_seqlock_irq(&priv->s_sendcontext->waitlock);
+		hfi2_sc_wantpiobuf_intr(priv->s_sendcontext, 0);
+		write_sequnlock_irq(&priv->s_sendcontext->waitlock);
+	}
+}
+
+/**
+ * hfi2_schedule_send - schedule progress
+ * @qp: the QP
+ *
+ * This schedules qp progress and caller should hold
+ * the s_lock.
+ * @return true if the first leg is scheduled;
+ * false if the first leg is not scheduled.
+ */
+bool hfi2_schedule_send(struct rvt_qp *qp)
+{
+	lockdep_assert_held(&qp->s_lock);
+	if (hfi2_send_ok(qp)) {
+		_hfi2_schedule_send(qp);
+		return true;
+	}
+	if (qp->s_flags & HFI2_S_ANY_WAIT_IO)
+		iowait_set_flag(&((struct hfi2_qp_priv *)qp->priv)->s_iowait,
+				IOWAIT_PENDING_IB);
+	return false;
+}
+
+static void hfi2_qp_schedule(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	bool ret;
+
+	if (iowait_flag_set(&priv->s_iowait, IOWAIT_PENDING_IB)) {
+		ret = hfi2_schedule_send(qp);
+		if (ret)
+			iowait_clear_flag(&priv->s_iowait, IOWAIT_PENDING_IB);
+	}
+	if (iowait_flag_set(&priv->s_iowait, IOWAIT_PENDING_TID)) {
+		ret = hfi2_schedule_tid_send(qp);
+		if (ret)
+			iowait_clear_flag(&priv->s_iowait, IOWAIT_PENDING_TID);
+	}
+}
+
+void hfi2_qp_wakeup(struct rvt_qp *qp, u32 flag)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (qp->s_flags & flag) {
+		qp->s_flags &= ~flag;
+		trace_hfi2_qpwakeup(qp, flag);
+		hfi2_qp_schedule(qp);
+	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	/* Notify hfi2_destroy_qp() if it is waiting. */
+	rvt_put_qp(qp);
+}
+
+void hfi2_qp_unbusy(struct rvt_qp *qp, struct iowait_work *wait)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (iowait_set_work_flag(wait) == IOWAIT_IB_SE) {
+		qp->s_flags &= ~RVT_S_BUSY;
+		/*
+		 * If we are sending a first-leg packet from the second leg,
+		 * we need to clear the busy flag from priv->s_flags to
+		 * avoid a race condition when the qp wakes up before
+		 * the call to hfi2_verbs_send() returns to the second
+		 * leg. In that case, the second leg will terminate without
+		 * being re-scheduled, resulting in failure to send TID RDMA
+		 * WRITE DATA and TID RDMA ACK packets.
+		 */
+		if (priv->s_flags & HFI2_S_TID_BUSY_SET) {
+			priv->s_flags &= ~(HFI2_S_TID_BUSY_SET |
+					   RVT_S_BUSY);
+			iowait_set_flag(&priv->s_iowait, IOWAIT_PENDING_TID);
+		}
+	} else {
+		priv->s_flags &= ~RVT_S_BUSY;
+	}
+}
+
+static int iowait_sleep(
+	struct sdma_engine *sde,
+	struct iowait_work *wait,
+	struct sdma_txreq *stx,
+	uint seq,
+	bool pkts_sent)
+{
+	struct verbs_txreq *tx = container_of(stx, struct verbs_txreq, txreq);
+	struct rvt_qp *qp;
+	struct hfi2_qp_priv *priv;
+	unsigned long flags;
+	int ret = 0;
+
+	qp = tx->qp;
+	priv = qp->priv;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK) {
+		/*
+		 * If we couldn't queue the DMA request, save the info
+		 * and try again later rather than destroying the
+		 * buffer and undoing the side effects of the copy.
+		 */
+		/* Make a common routine? */
+		list_add_tail(&stx->list, &wait->tx_head);
+		write_seqlock(&sde->waitlock);
+		if (sdma_progress(sde, seq, stx))
+			goto eagain;
+		if (list_empty(&priv->s_iowait.list)) {
+			struct hfi2_ibport *ibp =
+				to_iport(qp->ibqp.device, qp->port_num);
+
+			ibp->rvp.n_dmawait++;
+			qp->s_flags |= RVT_S_WAIT_DMA_DESC;
+			iowait_get_priority(&priv->s_iowait);
+			iowait_queue(pkts_sent, &priv->s_iowait,
+				     &sde->dmawait);
+			priv->s_iowait.lock = &sde->waitlock;
+			trace_hfi2_qpsleep(qp, RVT_S_WAIT_DMA_DESC);
+			rvt_get_qp(qp);
+		}
+		write_sequnlock(&sde->waitlock);
+		hfi2_qp_unbusy(qp, wait);
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		ret = -EIOCBQUEUED;
+	} else {
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		/*
+		 * Silently drop by faking success:
+		 * o drop the extra reference taken in hfi2_verbs_send_dma()
+		 * o return 0 ("success")
+		 */
+		hfi2_put_txreq(tx);
+	}
+	return ret;
+eagain:
+	write_sequnlock(&sde->waitlock);
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	list_del_init(&stx->list);
+	return -EAGAIN;
+}
+
+static void iowait_wakeup(struct iowait *wait, int reason)
+{
+	struct rvt_qp *qp = iowait_to_qp(wait);
+
+	WARN_ON(reason != SDMA_AVAIL_REASON);
+	hfi2_qp_wakeup(qp, RVT_S_WAIT_DMA_DESC);
+}
+
+static void iowait_sdma_drained(struct iowait *wait)
+{
+	struct rvt_qp *qp = iowait_to_qp(wait);
+	unsigned long flags;
+
+	/*
+	 * This happens when the send engine notes
+	 * a QP in the error state and cannot
+	 * do the flush work until that QP's
+	 * sdma work has finished.
+	 */
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (qp->s_flags & RVT_S_WAIT_DMA) {
+		qp->s_flags &= ~RVT_S_WAIT_DMA;
+		hfi2_schedule_send(qp);
+	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+}
+
+static void hfi2_init_priority(struct iowait *w)
+{
+	struct rvt_qp *qp = iowait_to_qp(w);
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (qp->s_flags & RVT_S_ACK_PENDING)
+		w->priority++;
+	if (priv->s_flags & RVT_S_ACK_PENDING)
+		w->priority++;
+}
+
+/**
+ * qp_to_sdma_engine - map a qp to a send engine
+ * @qp: the QP
+ * @sc5: the 5 bit sc
+ *
+ * Return:
+ * A send engine for the qp or NULL for SMI type qp.
+ */
+struct sdma_engine *qp_to_sdma_engine(struct rvt_qp *qp, u8 sc5)
+{
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+	struct sdma_engine *sde;
+
+	if (!(dd->flags & HFI2_HAS_SEND_DMA))
+		return NULL;
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_SMI:
+		return NULL;
+	default:
+		break;
+	}
+	sde = sdma_select_engine_sc(ppd, qp->ibqp.qp_num >> ppd->qos_shift, sc5);
+	return sde;
+}
+
+/**
+ * qp_to_send_context - map a qp to a send context
+ * @qp: the QP
+ * @sc5: the 5 bit sc
+ *
+ * Return:
+ * A send context for the qp
+ */
+struct send_context *qp_to_send_context(struct rvt_qp *qp, u8 sc5)
+{
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_SMI:
+		/* SMA packets to VL15 */
+		return ppd->vld[15].sc;
+	default:
+		break;
+	}
+
+	return pio_select_send_context_sc(ppd, qp->ibqp.qp_num >> ppd->qos_shift,
+					  sc5);
+}
+
+static const char * const qp_type_str[] = {
+	"SMI", "GSI", "RC", "UC", "UD",
+};
+
+static int qp_idle(struct rvt_qp *qp)
+{
+	return
+		qp->s_last == qp->s_acked &&
+		qp->s_acked == qp->s_cur &&
+		qp->s_cur == qp->s_tail &&
+		qp->s_tail == qp->s_head;
+}
+
+/**
+ * qp_iter_print - print the qp information to seq_file
+ * @s: the seq_file to emit the qp information on
+ * @iter: the iterator for the qp hash list
+ */
+void qp_iter_print(struct seq_file *s, struct rvt_qp_iter *iter)
+{
+	struct rvt_swqe *wqe;
+	struct rvt_qp *qp = iter->qp;
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct sdma_engine *sde;
+	struct send_context *send_context;
+	struct rvt_ack_entry *e = NULL;
+	struct rvt_srq *srq = qp->ibqp.srq ?
+		ibsrq_to_rvtsrq(qp->ibqp.srq) : NULL;
+
+	sde = qp_to_sdma_engine(qp, priv->s_sc);
+	wqe = rvt_get_swqe_ptr(qp, qp->s_last);
+	send_context = qp_to_send_context(qp, priv->s_sc);
+	if (qp->s_ack_queue)
+		e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+	seq_printf(s,
+		   "N %d %s QP %x R %u %s %u %u f=%x %u %u %u %u %u %u SPSN %x %x %x %x %x RPSN %x S(%u %u %u %u %u %u %u) R(%u %u %u) RQP %x LID %x SL %u MTU %u %u %u %u %u SDE %p,%u SC %p,%u SCQ %u %u PID %d OS %x %x E %x %x %x RNR %d %s %d\n",
+		   iter->n,
+		   qp_idle(qp) ? "I" : "B",
+		   qp->ibqp.qp_num,
+		   atomic_read(&qp->refcount),
+		   qp_type_str[qp->ibqp.qp_type],
+		   qp->state,
+		   wqe ? wqe->wr.opcode : 0,
+		   qp->s_flags,
+		   iowait_sdma_pending(&priv->s_iowait),
+		   iowait_pio_pending(&priv->s_iowait),
+		   !list_empty(&priv->s_iowait.list),
+		   qp->timeout,
+		   wqe ? wqe->ssn : 0,
+		   qp->s_lsn,
+		   qp->s_last_psn,
+		   qp->s_psn, qp->s_next_psn,
+		   qp->s_sending_psn, qp->s_sending_hpsn,
+		   qp->r_psn,
+		   qp->s_last, qp->s_acked, qp->s_cur,
+		   qp->s_tail, qp->s_head, qp->s_size,
+		   qp->s_avail,
+		   /* ack_queue ring pointers, size */
+		   qp->s_tail_ack_queue, qp->r_head_ack_queue,
+		   rvt_max_atomic(&to_idev(qp->ibqp.device)->rdi),
+		   /* remote QP info  */
+		   qp->remote_qpn,
+		   rdma_ah_get_dlid(&qp->remote_ah_attr),
+		   rdma_ah_get_sl(&qp->remote_ah_attr),
+		   qp->pmtu,
+		   qp->s_retry,
+		   qp->s_retry_cnt,
+		   qp->s_rnr_retry_cnt,
+		   qp->s_rnr_retry,
+		   sde,
+		   sde ? sde->this_idx : 0,
+		   send_context,
+		   send_context ? send_context->sw_index : 0,
+		   ib_cq_head(qp->ibqp.send_cq),
+		   ib_cq_tail(qp->ibqp.send_cq),
+		   qp->pid,
+		   qp->s_state,
+		   qp->s_ack_state,
+		   /* ack queue information */
+		   e ? e->opcode : 0,
+		   e ? e->psn : 0,
+		   e ? e->lpsn : 0,
+		   qp->r_min_rnr_timer,
+		   srq ? "SRQ" : "RQ",
+		   srq ? srq->rq.size : qp->r_rq.size
+		);
+}
+
+void *qp_priv_alloc(struct rvt_dev_info *rdi, struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv;
+
+	priv = kzalloc_node(sizeof(*priv), GFP_KERNEL, rdi->dparms.node);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	priv->owner = qp;
+
+	priv->s_ahg = kzalloc_node(sizeof(*priv->s_ahg), GFP_KERNEL,
+				   rdi->dparms.node);
+	if (!priv->s_ahg) {
+		kfree(priv);
+		return ERR_PTR(-ENOMEM);
+	}
+	iowait_init(
+		&priv->s_iowait,
+		1,
+		_hfi2_do_send,
+		_hfi2_do_tid_send,
+		iowait_sleep,
+		iowait_wakeup,
+		iowait_sdma_drained,
+		hfi2_init_priority);
+	/* Init to a value to start the running average correctly */
+	priv->s_running_pkt_size = piothreshold / 2;
+	return priv;
+}
+
+void qp_priv_free(struct rvt_dev_info *rdi, struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	hfi2_qp_priv_tid_free(rdi, qp);
+	kfree(priv->s_ahg);
+	kfree(priv);
+}
+
+unsigned free_all_qps(struct rvt_dev_info *rdi)
+{
+	struct hfi2_ibdev *verbs_dev = container_of(rdi,
+						    struct hfi2_ibdev,
+						    rdi);
+	struct hfi2_devdata *dd = container_of(verbs_dev,
+					       struct hfi2_devdata,
+					       verbs_dev);
+	int n;
+	unsigned qp_inuse = 0;
+
+	for (n = 0; n < dd->num_pports; n++) {
+		struct hfi2_ibport *ibp = &dd->pport[n].ibport_data;
+
+		rcu_read_lock();
+		if (rcu_dereference(ibp->rvp.qp[0]))
+			qp_inuse++;
+		if (rcu_dereference(ibp->rvp.qp[1]))
+			qp_inuse++;
+		rcu_read_unlock();
+	}
+
+	return qp_inuse;
+}
+
+void flush_qp_waiters(struct rvt_qp *qp)
+{
+	lockdep_assert_held(&qp->s_lock);
+	flush_iowait(qp);
+	hfi2_tid_rdma_flush_wait(qp);
+}
+
+void stop_send_queue(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	iowait_cancel_work(&priv->s_iowait);
+	if (cancel_work_sync(&priv->tid_rdma.trigger_work))
+		rvt_put_qp(qp);
+}
+
+void quiesce_qp(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	hfi2_del_tid_reap_timer(qp);
+	hfi2_del_tid_retry_timer(qp);
+	iowait_sdma_drain(&priv->s_iowait);
+	qp_pio_drain(qp);
+	flush_tx_list(qp);
+}
+
+void notify_qp_reset(struct rvt_qp *qp)
+{
+	hfi2_qp_kern_exp_rcv_clear_all(qp);
+	qp->r_adefered = 0;
+	clear_ahg(qp);
+
+	/* Clear any OPFN state */
+	if (qp->ibqp.qp_type == IB_QPT_RC)
+		opfn_conn_error(qp);
+}
+
+/*
+ * Switch to alternate path.
+ * The QP s_lock should be held and interrupts disabled.
+ */
+void hfi2_migrate_qp(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_event ev;
+
+	qp->s_mig_state = IB_MIG_MIGRATED;
+	qp->remote_ah_attr = qp->alt_ah_attr;
+	qp->port_num = rdma_ah_get_port_num(&qp->alt_ah_attr);
+	qp->s_pkey_index = qp->s_alt_pkey_index;
+	qp->s_flags |= HFI2_S_AHG_CLEAR;
+	priv->s_sc = ah_to_sc(qp->ibqp.device, &qp->remote_ah_attr);
+	priv->s_sde = qp_to_sdma_engine(qp, priv->s_sc);
+	qp_set_16b(qp);
+
+	ev.device = qp->ibqp.device;
+	ev.element.qp = &qp->ibqp;
+	ev.event = IB_EVENT_PATH_MIG;
+	qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
+}
+
+int mtu_to_path_mtu(u32 mtu)
+{
+	return mtu_to_enum(mtu, OPA_MTU_8192);
+}
+
+u32 mtu_from_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp, u32 pmtu)
+{
+	u32 mtu;
+	struct hfi2_ibdev *verbs_dev = container_of(rdi,
+						    struct hfi2_ibdev,
+						    rdi);
+	struct hfi2_devdata *dd = container_of(verbs_dev,
+					       struct hfi2_devdata,
+					       verbs_dev);
+	struct hfi2_pportdata *ppd = &dd->pport[qp->port_num - 1];
+	struct hfi2_ibport *ibp = &ppd->ibport_data;
+	u8 sc, vl;
+
+	sc = ibp->sl_to_sc[rdma_ah_get_sl(&qp->remote_ah_attr)];
+	vl = sc_to_vlt(ppd, sc);
+
+	mtu = verbs_mtu_enum_to_int(qp->ibqp.device, pmtu);
+	if (vl < PER_VL_SEND_CONTEXTS)
+		mtu = min_t(u32, mtu, ppd->vld[vl].mtu);
+	return mtu;
+}
+
+int get_pmtu_from_attr(struct rvt_dev_info *rdi, struct rvt_qp *qp,
+		       struct ib_qp_attr *attr)
+{
+	int mtu, pidx = qp->port_num - 1;
+	struct hfi2_ibdev *verbs_dev = container_of(rdi,
+						    struct hfi2_ibdev,
+						    rdi);
+	struct hfi2_devdata *dd = container_of(verbs_dev,
+					       struct hfi2_devdata,
+					       verbs_dev);
+	mtu = verbs_mtu_enum_to_int(qp->ibqp.device, attr->path_mtu);
+	if (mtu == -1)
+		return -1; /* values less than 0 are error */
+
+	if (mtu > dd->pport[pidx].ibmtu)
+		return mtu_to_enum(dd->pport[pidx].ibmtu, IB_MTU_2048);
+	else
+		return attr->path_mtu;
+}
+
+void notify_error_qp(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	seqlock_t *lock = priv->s_iowait.lock;
+
+	if (lock) {
+		write_seqlock(lock);
+		if (!list_empty(&priv->s_iowait.list) &&
+		    !(qp->s_flags & RVT_S_BUSY) &&
+		    !(priv->s_flags & RVT_S_BUSY)) {
+			qp->s_flags &= ~HFI2_S_ANY_WAIT_IO;
+			iowait_clear_flag(&priv->s_iowait, IOWAIT_PENDING_IB);
+			iowait_clear_flag(&priv->s_iowait, IOWAIT_PENDING_TID);
+			list_del_init(&priv->s_iowait.list);
+			priv->s_iowait.lock = NULL;
+			rvt_put_qp(qp);
+		}
+		write_sequnlock(lock);
+	}
+
+	if (!(qp->s_flags & RVT_S_BUSY) && !(priv->s_flags & RVT_S_BUSY)) {
+		qp->s_hdrwords = 0;
+		if (qp->s_rdma_mr) {
+			rvt_put_mr(qp->s_rdma_mr);
+			qp->s_rdma_mr = NULL;
+		}
+		flush_tx_list(qp);
+	}
+}
+
+/**
+ * hfi2_qp_iter_cb - callback for iterator
+ * @qp: the qp
+ * @v: the sl in low bits of v
+ *
+ * This is called from the iterator callback to work
+ * on an individual qp.
+ */
+static void hfi2_qp_iter_cb(struct rvt_qp *qp, u64 v)
+{
+	int lastwqe;
+	struct ib_event ev;
+	struct hfi2_ibport *ibp =
+		to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	u8 sl = (u8)v;
+
+	if (qp->port_num != ppd->port ||
+	    (qp->ibqp.qp_type != IB_QPT_UC &&
+	     qp->ibqp.qp_type != IB_QPT_RC) ||
+	    rdma_ah_get_sl(&qp->remote_ah_attr) != sl ||
+	    !(ib_rvt_state_ops[qp->state] & RVT_POST_SEND_OK))
+		return;
+
+	spin_lock_irq(&qp->r_lock);
+	spin_lock(&qp->s_hlock);
+	spin_lock(&qp->s_lock);
+	lastwqe = rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+	spin_unlock(&qp->s_lock);
+	spin_unlock(&qp->s_hlock);
+	spin_unlock_irq(&qp->r_lock);
+	if (lastwqe) {
+		ev.device = qp->ibqp.device;
+		ev.element.qp = &qp->ibqp;
+		ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
+		qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
+	}
+}
+
+/**
+ * hfi2_error_port_qps - put a port's RC/UC qps into error state
+ * @ibp: the ibport.
+ * @sl: the service level.
+ *
+ * This function places all RC/UC qps with a given service level into error
+ * state. It is generally called to force upper lay apps to abandon stale qps
+ * after an sl->sc mapping change.
+ */
+void hfi2_error_port_qps(struct hfi2_ibport *ibp, u8 sl)
+{
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_ibdev *dev = &ppd->dd->verbs_dev;
+
+	rvt_qp_iter(&dev->rdi, sl, hfi2_qp_iter_cb);
+}
diff --git a/drivers/infiniband/hw/hfi2/rc.c b/drivers/infiniband/hw/hfi2/rc.c
new file mode 100644
index 000000000000..8f4e230b09f1
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/rc.c
@@ -0,0 +1,3259 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#include <linux/io.h>
+#include <rdma/rdma_vt.h>
+#include <rdma/rdmavt_qp.h>
+
+#include "hfi2.h"
+#include "qp.h"
+#include "rc.h"
+#include "verbs_txreq.h"
+#include "trace.h"
+
+struct rvt_ack_entry *find_prev_entry(struct rvt_qp *qp, u32 psn, u8 *prev,
+				      u8 *prev_ack, bool *scheduled)
+	__must_hold(&qp->s_lock)
+{
+	struct rvt_ack_entry *e = NULL;
+	u8 i, p;
+	bool s = true;
+
+	for (i = qp->r_head_ack_queue; ; i = p) {
+		if (i == qp->s_tail_ack_queue)
+			s = false;
+		if (i)
+			p = i - 1;
+		else
+			p = rvt_size_atomic(ib_to_rvt(qp->ibqp.device));
+		if (p == qp->r_head_ack_queue) {
+			e = NULL;
+			break;
+		}
+		e = &qp->s_ack_queue[p];
+		if (!e->opcode) {
+			e = NULL;
+			break;
+		}
+		if (cmp_psn(psn, e->psn) >= 0) {
+			if (p == qp->s_tail_ack_queue &&
+			    cmp_psn(psn, e->lpsn) <= 0)
+				s = false;
+			break;
+		}
+	}
+	if (prev)
+		*prev = p;
+	if (prev_ack)
+		*prev_ack = i;
+	if (scheduled)
+		*scheduled = s;
+	return e;
+}
+
+/**
+ * make_rc_ack - construct a response packet (ACK, NAK, or RDMA read)
+ * @dev: the device for this QP
+ * @qp: a pointer to the QP
+ * @ohdr: a pointer to the IB header being constructed
+ * @ps: the xmit packet state
+ *
+ * Return 1 if constructed; otherwise, return 0.
+ * Note that we are in the responder's side of the QP context.
+ * Note the QP s_lock must be held.
+ */
+static int make_rc_ack(struct hfi2_ibdev *dev, struct rvt_qp *qp,
+		       struct ib_other_headers *ohdr,
+		       struct hfi2_pkt_state *ps)
+{
+	struct rvt_ack_entry *e;
+	u32 hwords, hdrlen;
+	u32 len = 0;
+	u32 bth0 = 0, bth2 = 0;
+	u32 bth1 = qp->remote_qpn | (HFI2_CAP_IS_KSET(OPFN) << IB_BTHE_E_SHIFT);
+	int middle = 0;
+	u32 pmtu = qp->pmtu;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	bool last_pkt;
+	u32 delta;
+	u8 next = qp->s_tail_ack_queue;
+	struct tid_rdma_request *req;
+
+	trace_hfi2_rsp_make_rc_ack(qp, 0);
+	lockdep_assert_held(&qp->s_lock);
+	/* Don't send an ACK if we aren't supposed to. */
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK))
+		goto bail;
+
+	if (qpriv->hdr_type == HFI2_PKT_TYPE_9B)
+		/* header size in 32-bit words LRH+BTH = (8+12)/4. */
+		hwords = 5;
+	else
+		/* header size in 32-bit words 16B LRH+BTH = (16+12)/4. */
+		hwords = 7;
+
+	switch (qp->s_ack_state) {
+	case OP(RDMA_READ_RESPONSE_LAST):
+	case OP(RDMA_READ_RESPONSE_ONLY):
+		e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+		release_rdma_sge_mr(e);
+		fallthrough;
+	case OP(ATOMIC_ACKNOWLEDGE):
+		/*
+		 * We can increment the tail pointer now that the last
+		 * response has been sent instead of only being
+		 * constructed.
+		 */
+		if (++next > rvt_size_atomic(&dev->rdi))
+			next = 0;
+		/*
+		 * Only advance the s_acked_ack_queue pointer if there
+		 * have been no TID RDMA requests.
+		 */
+		e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+		if (e->opcode != TID_OP(WRITE_REQ) &&
+		    qp->s_acked_ack_queue == qp->s_tail_ack_queue)
+			qp->s_acked_ack_queue = next;
+		qp->s_tail_ack_queue = next;
+		trace_hfi2_rsp_make_rc_ack(qp, e->psn);
+		fallthrough;
+	case OP(SEND_ONLY):
+	case OP(ACKNOWLEDGE):
+		/* Check for no next entry in the queue. */
+		if (qp->r_head_ack_queue == qp->s_tail_ack_queue) {
+			if (qp->s_flags & RVT_S_ACK_PENDING)
+				goto normal;
+			goto bail;
+		}
+
+		e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+		/* Check for tid write fence */
+		if ((qpriv->s_flags & HFI2_R_TID_WAIT_INTERLCK) ||
+		    hfi2_tid_rdma_ack_interlock(qp, e)) {
+			iowait_set_flag(&qpriv->s_iowait, IOWAIT_PENDING_IB);
+			goto bail;
+		}
+		if (e->opcode == OP(RDMA_READ_REQUEST)) {
+			/*
+			 * If a RDMA read response is being resent and
+			 * we haven't seen the duplicate request yet,
+			 * then stop sending the remaining responses the
+			 * responder has seen until the requester re-sends it.
+			 */
+			len = e->rdma_sge.sge_length;
+			if (len && !e->rdma_sge.mr) {
+				if (qp->s_acked_ack_queue ==
+				    qp->s_tail_ack_queue)
+					qp->s_acked_ack_queue =
+						qp->r_head_ack_queue;
+				qp->s_tail_ack_queue = qp->r_head_ack_queue;
+				goto bail;
+			}
+			/* Copy SGE state in case we need to resend */
+			ps->s_txreq->mr = e->rdma_sge.mr;
+			if (ps->s_txreq->mr)
+				rvt_get_mr(ps->s_txreq->mr);
+			qp->s_ack_rdma_sge.sge = e->rdma_sge;
+			qp->s_ack_rdma_sge.num_sge = 1;
+			ps->s_txreq->ss = &qp->s_ack_rdma_sge;
+			if (len > pmtu) {
+				len = pmtu;
+				qp->s_ack_state = OP(RDMA_READ_RESPONSE_FIRST);
+			} else {
+				qp->s_ack_state = OP(RDMA_READ_RESPONSE_ONLY);
+				e->sent = 1;
+			}
+			ohdr->u.aeth = rvt_compute_aeth(qp);
+			hwords++;
+			qp->s_ack_rdma_psn = e->psn;
+			bth2 = mask_psn(qp->s_ack_rdma_psn++);
+		} else if (e->opcode == TID_OP(WRITE_REQ)) {
+			/*
+			 * If a TID RDMA WRITE RESP is being resent, we have to
+			 * wait for the actual request. All requests that are to
+			 * be resent will have their state set to
+			 * TID_REQUEST_RESEND. When the new request arrives, the
+			 * state will be changed to TID_REQUEST_RESEND_ACTIVE.
+			 */
+			req = ack_to_tid_req(e);
+			if (req->state == TID_REQUEST_RESEND ||
+			    req->state == TID_REQUEST_INIT_RESEND)
+				goto bail;
+			qp->s_ack_state = TID_OP(WRITE_RESP);
+			qp->s_ack_rdma_psn = mask_psn(e->psn + req->cur_seg);
+			goto write_resp;
+		} else if (e->opcode == TID_OP(READ_REQ)) {
+			/*
+			 * If a TID RDMA read response is being resent and
+			 * we haven't seen the duplicate request yet,
+			 * then stop sending the remaining responses the
+			 * responder has seen until the requester re-sends it.
+			 */
+			len = e->rdma_sge.sge_length;
+			if (len && !e->rdma_sge.mr) {
+				if (qp->s_acked_ack_queue ==
+				    qp->s_tail_ack_queue)
+					qp->s_acked_ack_queue =
+						qp->r_head_ack_queue;
+				qp->s_tail_ack_queue = qp->r_head_ack_queue;
+				goto bail;
+			}
+			/* Copy SGE state in case we need to resend */
+			ps->s_txreq->mr = e->rdma_sge.mr;
+			if (ps->s_txreq->mr)
+				rvt_get_mr(ps->s_txreq->mr);
+			qp->s_ack_rdma_sge.sge = e->rdma_sge;
+			qp->s_ack_rdma_sge.num_sge = 1;
+			qp->s_ack_state = TID_OP(READ_RESP);
+			goto read_resp;
+		} else {
+			/* COMPARE_SWAP or FETCH_ADD */
+			ps->s_txreq->ss = NULL;
+			len = 0;
+			qp->s_ack_state = OP(ATOMIC_ACKNOWLEDGE);
+			ohdr->u.at.aeth = rvt_compute_aeth(qp);
+			ib_u64_put(e->atomic_data, &ohdr->u.at.atomic_ack_eth);
+			hwords += sizeof(ohdr->u.at) / sizeof(u32);
+			bth2 = mask_psn(e->psn);
+			e->sent = 1;
+		}
+		trace_hfi2_tid_write_rsp_make_rc_ack(qp);
+		bth0 = qp->s_ack_state << 24;
+		break;
+
+	case OP(RDMA_READ_RESPONSE_FIRST):
+		qp->s_ack_state = OP(RDMA_READ_RESPONSE_MIDDLE);
+		fallthrough;
+	case OP(RDMA_READ_RESPONSE_MIDDLE):
+		ps->s_txreq->ss = &qp->s_ack_rdma_sge;
+		ps->s_txreq->mr = qp->s_ack_rdma_sge.sge.mr;
+		if (ps->s_txreq->mr)
+			rvt_get_mr(ps->s_txreq->mr);
+		len = qp->s_ack_rdma_sge.sge.sge_length;
+		if (len > pmtu) {
+			len = pmtu;
+			middle = HFI2_CAP_IS_KSET(SDMA_AHG);
+		} else {
+			ohdr->u.aeth = rvt_compute_aeth(qp);
+			hwords++;
+			qp->s_ack_state = OP(RDMA_READ_RESPONSE_LAST);
+			e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+			e->sent = 1;
+		}
+		bth0 = qp->s_ack_state << 24;
+		bth2 = mask_psn(qp->s_ack_rdma_psn++);
+		break;
+
+	case TID_OP(WRITE_RESP):
+write_resp:
+		/*
+		 * 1. Check if RVT_S_ACK_PENDING is set. If yes,
+		 *    goto normal.
+		 * 2. Attempt to allocate TID resources.
+		 * 3. Remove RVT_S_RESP_PENDING flags from s_flags
+		 * 4. If resources not available:
+		 *    4.1 Set RVT_S_WAIT_TID_SPACE
+		 *    4.2 Queue QP on RCD TID queue
+		 *    4.3 Put QP on iowait list.
+		 *    4.4 Build IB RNR NAK with appropriate timeout value
+		 *    4.5 Return indication progress made.
+		 * 5. If resources are available:
+		 *    5.1 Program HW flow CSRs
+		 *    5.2 Build TID RDMA WRITE RESP packet
+		 *    5.3 If more resources needed, do 2.1 - 2.3.
+		 *    5.4 Wake up next QP on RCD TID queue.
+		 *    5.5 Return indication progress made.
+		 */
+
+		e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+		req = ack_to_tid_req(e);
+
+		/*
+		 * Send scheduled RNR NAK's. RNR NAK's need to be sent at
+		 * segment boundaries, not at request boundaries. Don't change
+		 * s_ack_state because we are still in the middle of a request
+		 */
+		if (qpriv->rnr_nak_state == TID_RNR_NAK_SEND &&
+		    qp->s_tail_ack_queue == qpriv->r_tid_alloc &&
+		    req->cur_seg == req->alloc_seg) {
+			qpriv->rnr_nak_state = TID_RNR_NAK_SENT;
+			goto normal_no_state;
+		}
+
+		bth2 = mask_psn(qp->s_ack_rdma_psn);
+		hdrlen = hfi2_build_tid_rdma_write_resp(qp, e, ohdr, &bth1,
+							bth2, &len,
+							&ps->s_txreq->ss);
+		if (!hdrlen)
+			return 0;
+
+		hwords += hdrlen;
+		bth0 = qp->s_ack_state << 24;
+		qp->s_ack_rdma_psn++;
+		trace_hfi2_tid_req_make_rc_ack_write(qp, 0, e->opcode, e->psn,
+						     e->lpsn, req);
+		if (req->cur_seg != req->total_segs)
+			break;
+
+		e->sent = 1;
+		/* Do not free e->rdma_sge until all data are received */
+		qp->s_ack_state = OP(ATOMIC_ACKNOWLEDGE);
+		break;
+
+	case TID_OP(READ_RESP):
+read_resp:
+		e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+		ps->s_txreq->ss = &qp->s_ack_rdma_sge;
+		delta = hfi2_build_tid_rdma_read_resp(qp, e, ohdr, &bth0,
+						      &bth1, &bth2, &len,
+						      &last_pkt);
+		if (delta == 0)
+			goto error_qp;
+		hwords += delta;
+		if (last_pkt) {
+			e->sent = 1;
+			/*
+			 * Increment qp->s_tail_ack_queue through s_ack_state
+			 * transition.
+			 */
+			qp->s_ack_state = OP(RDMA_READ_RESPONSE_LAST);
+		}
+		break;
+	case TID_OP(READ_REQ):
+		goto bail;
+
+	default:
+normal:
+		/*
+		 * Send a regular ACK.
+		 * Set the s_ack_state so we wait until after sending
+		 * the ACK before setting s_ack_state to ACKNOWLEDGE
+		 * (see above).
+		 */
+		qp->s_ack_state = OP(SEND_ONLY);
+normal_no_state:
+		if (qp->s_nak_state)
+			ohdr->u.aeth =
+				cpu_to_be32((qp->r_msn & IB_MSN_MASK) |
+					    (qp->s_nak_state <<
+					     IB_AETH_CREDIT_SHIFT));
+		else
+			ohdr->u.aeth = rvt_compute_aeth(qp);
+		hwords++;
+		len = 0;
+		bth0 = OP(ACKNOWLEDGE) << 24;
+		bth2 = mask_psn(qp->s_ack_psn);
+		qp->s_flags &= ~RVT_S_ACK_PENDING;
+		ps->s_txreq->txreq.flags |= SDMA_TXREQ_F_VIP;
+		ps->s_txreq->ss = NULL;
+	}
+	qp->s_rdma_ack_cnt++;
+	ps->s_txreq->sde = qpriv->s_sde;
+	ps->s_txreq->s_cur_size = len;
+	ps->s_txreq->hdr_dwords = hwords;
+	hfi2_make_ruc_header(qp, ohdr, bth0, bth1, bth2, middle, ps);
+	return 1;
+error_qp:
+	spin_unlock_irqrestore(&qp->s_lock, ps->flags);
+	spin_lock_irqsave(&qp->r_lock, ps->flags);
+	spin_lock(&qp->s_lock);
+	rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+	spin_unlock(&qp->s_lock);
+	spin_unlock_irqrestore(&qp->r_lock, ps->flags);
+	spin_lock_irqsave(&qp->s_lock, ps->flags);
+bail:
+	qp->s_ack_state = OP(ACKNOWLEDGE);
+	/*
+	 * Ensure s_rdma_ack_cnt changes are committed prior to resetting
+	 * RVT_S_RESP_PENDING
+	 */
+	smp_wmb();
+	qp->s_flags &= ~(RVT_S_RESP_PENDING
+				| RVT_S_ACK_PENDING
+				| HFI2_S_AHG_VALID);
+	return 0;
+}
+
+/**
+ * hfi2_make_rc_req - construct a request packet (SEND, RDMA r/w, ATOMIC)
+ * @qp: a pointer to the QP
+ * @ps: the current packet state
+ *
+ * Assumes s_lock is held.
+ *
+ * Return 1 if constructed; otherwise, return 0.
+ */
+int hfi2_make_rc_req(struct rvt_qp *qp, struct hfi2_pkt_state *ps)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ibdev *dev = to_idev(qp->ibqp.device);
+	struct ib_other_headers *ohdr;
+	struct rvt_sge_state *ss = NULL;
+	struct rvt_swqe *wqe;
+	struct hfi2_swqe_priv *wpriv;
+	struct tid_rdma_request *req = NULL;
+	/* header size in 32-bit words LRH+BTH = (8+12)/4. */
+	u32 hwords = 5;
+	u32 len = 0;
+	u32 bth0 = 0, bth2 = 0;
+	u32 bth1 = qp->remote_qpn | (HFI2_CAP_IS_KSET(OPFN) << IB_BTHE_E_SHIFT);
+	u32 pmtu = qp->pmtu;
+	char newreq;
+	int middle = 0;
+	int delta;
+	struct tid_rdma_flow *flow = NULL;
+	struct tid_rdma_params *remote;
+
+	trace_hfi2_sender_make_rc_req(qp);
+	lockdep_assert_held(&qp->s_lock);
+	ps->s_txreq = alloc_txreq(ps->dev, qp);
+	if (!ps->s_txreq)
+		goto bail_no_tx;
+
+	if (priv->hdr_type == HFI2_PKT_TYPE_9B) {
+		/* header size in 32-bit words LRH+BTH = (8+12)/4. */
+		hwords = 5;
+		if (rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH)
+			ohdr = &ps->s_txreq->phdr.hdr.ibh.u.l.oth;
+		else
+			ohdr = &ps->s_txreq->phdr.hdr.ibh.u.oth;
+	} else {
+		/* header size in 32-bit words 16B LRH+BTH = (16+12)/4. */
+		hwords = 7;
+		if ((rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH) &&
+		    (hfi2_check_mcast(rdma_ah_get_dlid(&qp->remote_ah_attr))))
+			ohdr = &ps->s_txreq->phdr.hdr.opah.u.l.oth;
+		else
+			ohdr = &ps->s_txreq->phdr.hdr.opah.u.oth;
+	}
+
+	/* Sending responses has higher priority over sending requests. */
+	if ((qp->s_flags & RVT_S_RESP_PENDING) &&
+	    make_rc_ack(dev, qp, ohdr, ps))
+		return 1;
+
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_SEND_OK)) {
+		if (!(ib_rvt_state_ops[qp->state] & RVT_FLUSH_SEND))
+			goto bail;
+		/* We are in the error state, flush the work request. */
+		if (qp->s_last == READ_ONCE(qp->s_head))
+			goto bail;
+		/* If DMAs are in progress, we can't flush immediately. */
+		if (iowait_sdma_pending(&priv->s_iowait)) {
+			qp->s_flags |= RVT_S_WAIT_DMA;
+			goto bail;
+		}
+		clear_ahg(qp);
+		wqe = rvt_get_swqe_ptr(qp, qp->s_last);
+		hfi2_trdma_send_complete(qp, wqe, qp->s_last != qp->s_acked ?
+					 IB_WC_SUCCESS : IB_WC_WR_FLUSH_ERR);
+		/* will get called again */
+		goto done_free_tx;
+	}
+
+	if (qp->s_flags & (RVT_S_WAIT_RNR | RVT_S_WAIT_ACK | HFI2_S_WAIT_HALT))
+		goto bail;
+
+	if (cmp_psn(qp->s_psn, qp->s_sending_hpsn) <= 0) {
+		if (cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) <= 0) {
+			qp->s_flags |= RVT_S_WAIT_PSN;
+			goto bail;
+		}
+		qp->s_sending_psn = qp->s_psn;
+		qp->s_sending_hpsn = qp->s_psn - 1;
+	}
+
+	/* Send a request. */
+	wqe = rvt_get_swqe_ptr(qp, qp->s_cur);
+check_s_state:
+	switch (qp->s_state) {
+	default:
+		if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_NEXT_SEND_OK))
+			goto bail;
+		/*
+		 * Resend an old request or start a new one.
+		 *
+		 * We keep track of the current SWQE so that
+		 * we don't reset the "furthest progress" state
+		 * if we need to back up.
+		 */
+		newreq = 0;
+		if (qp->s_cur == qp->s_tail) {
+			/* Check if send work queue is empty. */
+			if (qp->s_tail == READ_ONCE(qp->s_head)) {
+				clear_ahg(qp);
+				goto bail;
+			}
+			/*
+			 * If a fence is requested, wait for previous
+			 * RDMA read and atomic operations to finish.
+			 * However, there is no need to guard against
+			 * TID RDMA READ after TID RDMA READ.
+			 */
+			if ((wqe->wr.send_flags & IB_SEND_FENCE) &&
+			    qp->s_num_rd_atomic &&
+			    (wqe->wr.opcode != IB_WR_TID_RDMA_READ ||
+			     priv->pending_tid_r_segs < qp->s_num_rd_atomic)) {
+				qp->s_flags |= RVT_S_WAIT_FENCE;
+				goto bail;
+			}
+			/*
+			 * Local operations are processed immediately
+			 * after all prior requests have completed
+			 */
+			if (wqe->wr.opcode == IB_WR_REG_MR ||
+			    wqe->wr.opcode == IB_WR_LOCAL_INV) {
+				int local_ops = 0;
+				int err = 0;
+
+				if (qp->s_last != qp->s_cur)
+					goto bail;
+				if (++qp->s_cur == qp->s_size)
+					qp->s_cur = 0;
+				if (++qp->s_tail == qp->s_size)
+					qp->s_tail = 0;
+				if (!(wqe->wr.send_flags &
+				      RVT_SEND_COMPLETION_ONLY)) {
+					err = rvt_invalidate_rkey(
+						qp,
+						wqe->wr.ex.invalidate_rkey);
+					local_ops = 1;
+				}
+				rvt_send_complete(qp, wqe,
+						  err ? IB_WC_LOC_PROT_ERR
+						      : IB_WC_SUCCESS);
+				if (local_ops)
+					atomic_dec(&qp->local_ops_pending);
+				goto done_free_tx;
+			}
+
+			newreq = 1;
+			qp->s_psn = wqe->psn;
+		}
+		/*
+		 * Note that we have to be careful not to modify the
+		 * original work request since we may need to resend
+		 * it.
+		 */
+		len = wqe->length;
+		ss = &qp->s_sge;
+		bth2 = mask_psn(qp->s_psn);
+
+		/*
+		 * Interlock between various IB requests and TID RDMA
+		 * if necessary.
+		 */
+		if ((priv->s_flags & HFI2_S_TID_WAIT_INTERLCK) ||
+		    hfi2_tid_rdma_wqe_interlock(qp, wqe))
+			goto bail;
+
+		switch (wqe->wr.opcode) {
+		case IB_WR_SEND:
+		case IB_WR_SEND_WITH_IMM:
+		case IB_WR_SEND_WITH_INV:
+			/* If no credit, return. */
+			if (!rvt_rc_credit_avail(qp, wqe))
+				goto bail;
+			if (len > pmtu) {
+				qp->s_state = OP(SEND_FIRST);
+				len = pmtu;
+				break;
+			}
+			if (wqe->wr.opcode == IB_WR_SEND) {
+				qp->s_state = OP(SEND_ONLY);
+			} else if (wqe->wr.opcode == IB_WR_SEND_WITH_IMM) {
+				qp->s_state = OP(SEND_ONLY_WITH_IMMEDIATE);
+				/* Immediate data comes after the BTH */
+				ohdr->u.imm_data = wqe->wr.ex.imm_data;
+				hwords += 1;
+			} else {
+				qp->s_state = OP(SEND_ONLY_WITH_INVALIDATE);
+				/* Invalidate rkey comes after the BTH */
+				ohdr->u.ieth = cpu_to_be32(
+						wqe->wr.ex.invalidate_rkey);
+				hwords += 1;
+			}
+			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+				bth0 |= IB_BTH_SOLICITED;
+			bth2 |= IB_BTH_REQ_ACK;
+			if (++qp->s_cur == qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		case IB_WR_RDMA_WRITE:
+			if (newreq && !(qp->s_flags & RVT_S_UNLIMITED_CREDIT))
+				qp->s_lsn++;
+			goto no_flow_control;
+		case IB_WR_RDMA_WRITE_WITH_IMM:
+			/* If no credit, return. */
+			if (!rvt_rc_credit_avail(qp, wqe))
+				goto bail;
+no_flow_control:
+			put_ib_reth_vaddr(
+				wqe->rdma_wr.remote_addr,
+				&ohdr->u.rc.reth);
+			ohdr->u.rc.reth.rkey =
+				cpu_to_be32(wqe->rdma_wr.rkey);
+			ohdr->u.rc.reth.length = cpu_to_be32(len);
+			hwords += sizeof(struct ib_reth) / sizeof(u32);
+			if (len > pmtu) {
+				qp->s_state = OP(RDMA_WRITE_FIRST);
+				len = pmtu;
+				break;
+			}
+			if (wqe->wr.opcode == IB_WR_RDMA_WRITE) {
+				qp->s_state = OP(RDMA_WRITE_ONLY);
+			} else {
+				qp->s_state =
+					OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE);
+				/* Immediate data comes after RETH */
+				ohdr->u.rc.imm_data = wqe->wr.ex.imm_data;
+				hwords += 1;
+				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+					bth0 |= IB_BTH_SOLICITED;
+			}
+			bth2 |= IB_BTH_REQ_ACK;
+			if (++qp->s_cur == qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		case IB_WR_TID_RDMA_WRITE:
+			if (newreq) {
+				/*
+				 * Limit the number of TID RDMA WRITE requests.
+				 */
+				if (atomic_read(&priv->n_tid_requests) >=
+				    HFI2_TID_RDMA_WRITE_CNT)
+					goto bail;
+
+				if (!(qp->s_flags & RVT_S_UNLIMITED_CREDIT))
+					qp->s_lsn++;
+			}
+
+			hwords += hfi2_build_tid_rdma_write_req(qp, wqe, ohdr,
+								&bth1, &bth2,
+								&len);
+			ss = NULL;
+			if (priv->s_tid_cur == HFI2_QP_WQE_INVALID) {
+				priv->s_tid_cur = qp->s_cur;
+				if (priv->s_tid_tail == HFI2_QP_WQE_INVALID) {
+					priv->s_tid_tail = qp->s_cur;
+					priv->s_state = TID_OP(WRITE_RESP);
+				}
+			} else if (priv->s_tid_cur == priv->s_tid_head) {
+				struct rvt_swqe *__w;
+				struct tid_rdma_request *__r;
+
+				__w = rvt_get_swqe_ptr(qp, priv->s_tid_cur);
+				__r = wqe_to_tid_req(__w);
+
+				/*
+				 * The s_tid_cur pointer is advanced to s_cur if
+				 * any of the following conditions about the WQE
+				 * to which s_ti_cur currently points to are
+				 * satisfied:
+				 *   1. The request is not a TID RDMA WRITE
+				 *      request,
+				 *   2. The request is in the INACTIVE or
+				 *      COMPLETE states (TID RDMA READ requests
+				 *      stay at INACTIVE and TID RDMA WRITE
+				 *      transition to COMPLETE when done),
+				 *   3. The request is in the ACTIVE or SYNC
+				 *      state and the number of completed
+				 *      segments is equal to the total segment
+				 *      count.
+				 *      (If ACTIVE, the request is waiting for
+				 *       ACKs. If SYNC, the request has not
+				 *       received any responses because it's
+				 *       waiting on a sync point.)
+				 */
+				if (__w->wr.opcode != IB_WR_TID_RDMA_WRITE ||
+				    __r->state == TID_REQUEST_INACTIVE ||
+				    __r->state == TID_REQUEST_COMPLETE ||
+				    ((__r->state == TID_REQUEST_ACTIVE ||
+				      __r->state == TID_REQUEST_SYNC) &&
+				     __r->comp_seg == __r->total_segs)) {
+					if (priv->s_tid_tail ==
+					    priv->s_tid_cur &&
+					    priv->s_state ==
+					    TID_OP(WRITE_DATA_LAST)) {
+						priv->s_tid_tail = qp->s_cur;
+						priv->s_state =
+							TID_OP(WRITE_RESP);
+					}
+					priv->s_tid_cur = qp->s_cur;
+				}
+				/*
+				 * A corner case: when the last TID RDMA WRITE
+				 * request was completed, s_tid_head,
+				 * s_tid_cur, and s_tid_tail all point to the
+				 * same location. Other requests are posted and
+				 * s_cur wraps around to the same location,
+				 * where a new TID RDMA WRITE is posted. In
+				 * this case, none of the indices need to be
+				 * updated. However, the priv->s_state should.
+				 */
+				if (priv->s_tid_tail == qp->s_cur &&
+				    priv->s_state == TID_OP(WRITE_DATA_LAST))
+					priv->s_state = TID_OP(WRITE_RESP);
+			}
+			req = wqe_to_tid_req(wqe);
+			if (newreq) {
+				priv->s_tid_head = qp->s_cur;
+				priv->pending_tid_w_resp += req->total_segs;
+				atomic_inc(&priv->n_tid_requests);
+				atomic_dec(&priv->n_requests);
+			} else {
+				req->state = TID_REQUEST_RESEND;
+				req->comp_seg = delta_psn(bth2, wqe->psn);
+				/*
+				 * Pull back any segments since we are going
+				 * to re-receive them.
+				 */
+				req->setup_head = req->clear_tail;
+				priv->pending_tid_w_resp +=
+					delta_psn(wqe->lpsn, bth2) + 1;
+			}
+
+			trace_hfi2_tid_write_sender_make_req(qp, newreq);
+			trace_hfi2_tid_req_make_req_write(qp, newreq,
+							  wqe->wr.opcode,
+							  wqe->psn, wqe->lpsn,
+							  req);
+			if (++qp->s_cur == qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		case IB_WR_RDMA_READ:
+			/*
+			 * Don't allow more operations to be started
+			 * than the QP limits allow.
+			 */
+			if (qp->s_num_rd_atomic >=
+			    qp->s_max_rd_atomic) {
+				qp->s_flags |= RVT_S_WAIT_RDMAR;
+				goto bail;
+			}
+			qp->s_num_rd_atomic++;
+			if (newreq && !(qp->s_flags & RVT_S_UNLIMITED_CREDIT))
+				qp->s_lsn++;
+			put_ib_reth_vaddr(
+				wqe->rdma_wr.remote_addr,
+				&ohdr->u.rc.reth);
+			ohdr->u.rc.reth.rkey =
+				cpu_to_be32(wqe->rdma_wr.rkey);
+			ohdr->u.rc.reth.length = cpu_to_be32(len);
+			qp->s_state = OP(RDMA_READ_REQUEST);
+			hwords += sizeof(ohdr->u.rc.reth) / sizeof(u32);
+			ss = NULL;
+			len = 0;
+			bth2 |= IB_BTH_REQ_ACK;
+			if (++qp->s_cur == qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		case IB_WR_TID_RDMA_READ:
+			trace_hfi2_tid_read_sender_make_req(qp, newreq);
+			wpriv = wqe->priv;
+			req = wqe_to_tid_req(wqe);
+			trace_hfi2_tid_req_make_req_read(qp, newreq,
+							 wqe->wr.opcode,
+							 wqe->psn, wqe->lpsn,
+							 req);
+			delta = cmp_psn(qp->s_psn, wqe->psn);
+
+			/*
+			 * Don't allow more operations to be started
+			 * than the QP limits allow. We could get here under
+			 * three conditions; (1) It's a new request; (2) We are
+			 * sending the second or later segment of a request,
+			 * but the qp->s_state is set to OP(RDMA_READ_REQUEST)
+			 * when the last segment of a previous request is
+			 * received just before this; (3) We are re-sending a
+			 * request.
+			 */
+			if (qp->s_num_rd_atomic >= qp->s_max_rd_atomic) {
+				qp->s_flags |= RVT_S_WAIT_RDMAR;
+				goto bail;
+			}
+			if (newreq) {
+				struct tid_rdma_flow *flow =
+					&req->flows[req->setup_head];
+
+				/*
+				 * Set up s_sge as it is needed for TID
+				 * allocation. However, if the pages have been
+				 * walked and mapped, skip it. An earlier try
+				 * has failed to allocate the TID entries.
+				 */
+				if (!flow->npagesets) {
+					qp->s_sge.sge = wqe->sg_list[0];
+					qp->s_sge.sg_list = wqe->sg_list + 1;
+					qp->s_sge.num_sge = wqe->wr.num_sge;
+					qp->s_sge.total_len = wqe->length;
+					qp->s_len = wqe->length;
+					req->isge = 0;
+					req->clear_tail = req->setup_head;
+					req->flow_idx = req->setup_head;
+					req->state = TID_REQUEST_ACTIVE;
+				}
+			} else if (delta == 0) {
+				/* Re-send a request */
+				req->cur_seg = 0;
+				req->comp_seg = 0;
+				req->ack_pending = 0;
+				req->flow_idx = req->clear_tail;
+				req->state = TID_REQUEST_RESEND;
+			}
+			req->s_next_psn = qp->s_psn;
+			/* Read one segment at a time */
+			len = min_t(u32, req->seg_len,
+				    wqe->length - req->seg_len * req->cur_seg);
+			delta = hfi2_build_tid_rdma_read_req(qp, wqe, ohdr,
+							     &bth1, &bth2,
+							     &len);
+			if (delta <= 0) {
+				/* Wait for TID space */
+				goto bail;
+			}
+			if (newreq && !(qp->s_flags & RVT_S_UNLIMITED_CREDIT))
+				qp->s_lsn++;
+			hwords += delta;
+			ss = &wpriv->ss;
+			/* Check if this is the last segment */
+			if (req->cur_seg >= req->total_segs &&
+			    ++qp->s_cur == qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		case IB_WR_ATOMIC_CMP_AND_SWP:
+		case IB_WR_ATOMIC_FETCH_AND_ADD:
+			/*
+			 * Don't allow more operations to be started
+			 * than the QP limits allow.
+			 */
+			if (qp->s_num_rd_atomic >=
+			    qp->s_max_rd_atomic) {
+				qp->s_flags |= RVT_S_WAIT_RDMAR;
+				goto bail;
+			}
+			qp->s_num_rd_atomic++;
+			fallthrough;
+		case IB_WR_OPFN:
+			if (newreq && !(qp->s_flags & RVT_S_UNLIMITED_CREDIT))
+				qp->s_lsn++;
+			if (wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+			    wqe->wr.opcode == IB_WR_OPFN) {
+				qp->s_state = OP(COMPARE_SWAP);
+				put_ib_ateth_swap(wqe->atomic_wr.swap,
+						  &ohdr->u.atomic_eth);
+				put_ib_ateth_compare(wqe->atomic_wr.compare_add,
+						     &ohdr->u.atomic_eth);
+			} else {
+				qp->s_state = OP(FETCH_ADD);
+				put_ib_ateth_swap(wqe->atomic_wr.compare_add,
+						  &ohdr->u.atomic_eth);
+				put_ib_ateth_compare(0, &ohdr->u.atomic_eth);
+			}
+			put_ib_ateth_vaddr(wqe->atomic_wr.remote_addr,
+					   &ohdr->u.atomic_eth);
+			ohdr->u.atomic_eth.rkey = cpu_to_be32(
+				wqe->atomic_wr.rkey);
+			hwords += sizeof(struct ib_atomic_eth) / sizeof(u32);
+			ss = NULL;
+			len = 0;
+			bth2 |= IB_BTH_REQ_ACK;
+			if (++qp->s_cur == qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		default:
+			goto bail;
+		}
+		if (wqe->wr.opcode != IB_WR_TID_RDMA_READ) {
+			qp->s_sge.sge = wqe->sg_list[0];
+			qp->s_sge.sg_list = wqe->sg_list + 1;
+			qp->s_sge.num_sge = wqe->wr.num_sge;
+			qp->s_sge.total_len = wqe->length;
+			qp->s_len = wqe->length;
+		}
+		if (newreq) {
+			qp->s_tail++;
+			if (qp->s_tail >= qp->s_size)
+				qp->s_tail = 0;
+		}
+		if (wqe->wr.opcode == IB_WR_RDMA_READ ||
+		    wqe->wr.opcode == IB_WR_TID_RDMA_WRITE)
+			qp->s_psn = wqe->lpsn + 1;
+		else if (wqe->wr.opcode == IB_WR_TID_RDMA_READ)
+			qp->s_psn = req->s_next_psn;
+		else
+			qp->s_psn++;
+		break;
+
+	case OP(RDMA_READ_RESPONSE_FIRST):
+		/*
+		 * qp->s_state is normally set to the opcode of the
+		 * last packet constructed for new requests and therefore
+		 * is never set to RDMA read response.
+		 * RDMA_READ_RESPONSE_FIRST is used by the ACK processing
+		 * thread to indicate a SEND needs to be restarted from an
+		 * earlier PSN without interfering with the sending thread.
+		 * See restart_rc().
+		 */
+		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
+		fallthrough;
+	case OP(SEND_FIRST):
+		qp->s_state = OP(SEND_MIDDLE);
+		fallthrough;
+	case OP(SEND_MIDDLE):
+		bth2 = mask_psn(qp->s_psn++);
+		ss = &qp->s_sge;
+		len = qp->s_len;
+		if (len > pmtu) {
+			len = pmtu;
+			middle = HFI2_CAP_IS_KSET(SDMA_AHG);
+			break;
+		}
+		if (wqe->wr.opcode == IB_WR_SEND) {
+			qp->s_state = OP(SEND_LAST);
+		} else if (wqe->wr.opcode == IB_WR_SEND_WITH_IMM) {
+			qp->s_state = OP(SEND_LAST_WITH_IMMEDIATE);
+			/* Immediate data comes after the BTH */
+			ohdr->u.imm_data = wqe->wr.ex.imm_data;
+			hwords += 1;
+		} else {
+			qp->s_state = OP(SEND_LAST_WITH_INVALIDATE);
+			/* invalidate data comes after the BTH */
+			ohdr->u.ieth = cpu_to_be32(wqe->wr.ex.invalidate_rkey);
+			hwords += 1;
+		}
+		if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+			bth0 |= IB_BTH_SOLICITED;
+		bth2 |= IB_BTH_REQ_ACK;
+		qp->s_cur++;
+		if (qp->s_cur >= qp->s_size)
+			qp->s_cur = 0;
+		break;
+
+	case OP(RDMA_READ_RESPONSE_LAST):
+		/*
+		 * qp->s_state is normally set to the opcode of the
+		 * last packet constructed for new requests and therefore
+		 * is never set to RDMA read response.
+		 * RDMA_READ_RESPONSE_LAST is used by the ACK processing
+		 * thread to indicate a RDMA write needs to be restarted from
+		 * an earlier PSN without interfering with the sending thread.
+		 * See restart_rc().
+		 */
+		qp->s_len = restart_sge(&qp->s_sge, wqe, qp->s_psn, pmtu);
+		fallthrough;
+	case OP(RDMA_WRITE_FIRST):
+		qp->s_state = OP(RDMA_WRITE_MIDDLE);
+		fallthrough;
+	case OP(RDMA_WRITE_MIDDLE):
+		bth2 = mask_psn(qp->s_psn++);
+		ss = &qp->s_sge;
+		len = qp->s_len;
+		if (len > pmtu) {
+			len = pmtu;
+			middle = HFI2_CAP_IS_KSET(SDMA_AHG);
+			break;
+		}
+		if (wqe->wr.opcode == IB_WR_RDMA_WRITE) {
+			qp->s_state = OP(RDMA_WRITE_LAST);
+		} else {
+			qp->s_state = OP(RDMA_WRITE_LAST_WITH_IMMEDIATE);
+			/* Immediate data comes after the BTH */
+			ohdr->u.imm_data = wqe->wr.ex.imm_data;
+			hwords += 1;
+			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+				bth0 |= IB_BTH_SOLICITED;
+		}
+		bth2 |= IB_BTH_REQ_ACK;
+		qp->s_cur++;
+		if (qp->s_cur >= qp->s_size)
+			qp->s_cur = 0;
+		break;
+
+	case OP(RDMA_READ_RESPONSE_MIDDLE):
+		/*
+		 * qp->s_state is normally set to the opcode of the
+		 * last packet constructed for new requests and therefore
+		 * is never set to RDMA read response.
+		 * RDMA_READ_RESPONSE_MIDDLE is used by the ACK processing
+		 * thread to indicate a RDMA read needs to be restarted from
+		 * an earlier PSN without interfering with the sending thread.
+		 * See restart_rc().
+		 */
+		len = (delta_psn(qp->s_psn, wqe->psn)) * pmtu;
+		put_ib_reth_vaddr(
+			wqe->rdma_wr.remote_addr + len,
+			&ohdr->u.rc.reth);
+		ohdr->u.rc.reth.rkey =
+			cpu_to_be32(wqe->rdma_wr.rkey);
+		ohdr->u.rc.reth.length = cpu_to_be32(wqe->length - len);
+		qp->s_state = OP(RDMA_READ_REQUEST);
+		hwords += sizeof(ohdr->u.rc.reth) / sizeof(u32);
+		bth2 = mask_psn(qp->s_psn) | IB_BTH_REQ_ACK;
+		qp->s_psn = wqe->lpsn + 1;
+		ss = NULL;
+		len = 0;
+		qp->s_cur++;
+		if (qp->s_cur == qp->s_size)
+			qp->s_cur = 0;
+		break;
+
+	case TID_OP(WRITE_RESP):
+		/*
+		 * This value for s_state is used for restarting a TID RDMA
+		 * WRITE request. See comment in OP(RDMA_READ_RESPONSE_MIDDLE
+		 * for more).
+		 */
+		req = wqe_to_tid_req(wqe);
+		req->state = TID_REQUEST_RESEND;
+		rcu_read_lock();
+		remote = rcu_dereference(priv->tid_rdma.remote);
+		req->comp_seg = delta_psn(qp->s_psn, wqe->psn);
+		len = wqe->length - (req->comp_seg * remote->max_len);
+		rcu_read_unlock();
+
+		bth2 = mask_psn(qp->s_psn);
+		hwords += hfi2_build_tid_rdma_write_req(qp, wqe, ohdr, &bth1,
+							&bth2, &len);
+		qp->s_psn = wqe->lpsn + 1;
+		ss = NULL;
+		qp->s_state = TID_OP(WRITE_REQ);
+		priv->pending_tid_w_resp += delta_psn(wqe->lpsn, bth2) + 1;
+		priv->s_tid_cur = qp->s_cur;
+		if (++qp->s_cur == qp->s_size)
+			qp->s_cur = 0;
+		trace_hfi2_tid_req_make_req_write(qp, 0, wqe->wr.opcode,
+						  wqe->psn, wqe->lpsn, req);
+		break;
+
+	case TID_OP(READ_RESP):
+		if (wqe->wr.opcode != IB_WR_TID_RDMA_READ)
+			goto bail;
+		/* This is used to restart a TID read request */
+		req = wqe_to_tid_req(wqe);
+		wpriv = wqe->priv;
+		/*
+		 * Back down. The field qp->s_psn has been set to the psn with
+		 * which the request should be restart. It's OK to use division
+		 * as this is on the retry path.
+		 */
+		req->cur_seg = delta_psn(qp->s_psn, wqe->psn) / priv->pkts_ps;
+
+		/*
+		 * The following function need to be redefined to return the
+		 * status to make sure that we find the flow. At the same
+		 * time, we can use the req->state change to check if the
+		 * call succeeds or not.
+		 */
+		req->state = TID_REQUEST_RESEND;
+		hfi2_tid_rdma_restart_req(qp, wqe, &bth2);
+		if (req->state != TID_REQUEST_ACTIVE) {
+			/*
+			 * Failed to find the flow. Release all allocated tid
+			 * resources.
+			 */
+			hfi2_kern_exp_rcv_clear_all(req);
+			hfi2_kern_clear_hw_flow(priv->rcd, qp);
+
+			hfi2_trdma_send_complete(qp, wqe, IB_WC_LOC_QP_OP_ERR);
+			goto bail;
+		}
+		req->state = TID_REQUEST_RESEND;
+		len = min_t(u32, req->seg_len,
+			    wqe->length - req->seg_len * req->cur_seg);
+		flow = &req->flows[req->flow_idx];
+		len -= flow->sent;
+		req->s_next_psn = flow->flow_state.ib_lpsn + 1;
+		delta = hfi2_build_tid_rdma_read_packet(wqe, ohdr, &bth1,
+							&bth2, &len);
+		if (delta <= 0) {
+			/* Wait for TID space */
+			goto bail;
+		}
+		hwords += delta;
+		ss = &wpriv->ss;
+		/* Check if this is the last segment */
+		if (req->cur_seg >= req->total_segs &&
+		    ++qp->s_cur == qp->s_size)
+			qp->s_cur = 0;
+		qp->s_psn = req->s_next_psn;
+		trace_hfi2_tid_req_make_req_read(qp, 0, wqe->wr.opcode,
+						 wqe->psn, wqe->lpsn, req);
+		break;
+	case TID_OP(READ_REQ):
+		req = wqe_to_tid_req(wqe);
+		delta = cmp_psn(qp->s_psn, wqe->psn);
+		/*
+		 * If the current WR is not TID RDMA READ, or this is the start
+		 * of a new request, we need to change the qp->s_state so that
+		 * the request can be set up properly.
+		 */
+		if (wqe->wr.opcode != IB_WR_TID_RDMA_READ || delta == 0 ||
+		    qp->s_cur == qp->s_tail) {
+			qp->s_state = OP(RDMA_READ_REQUEST);
+			if (delta == 0 || qp->s_cur == qp->s_tail)
+				goto check_s_state;
+			else
+				goto bail;
+		}
+
+		/* Rate limiting */
+		if (qp->s_num_rd_atomic >= qp->s_max_rd_atomic) {
+			qp->s_flags |= RVT_S_WAIT_RDMAR;
+			goto bail;
+		}
+
+		wpriv = wqe->priv;
+		/* Read one segment at a time */
+		len = min_t(u32, req->seg_len,
+			    wqe->length - req->seg_len * req->cur_seg);
+		delta = hfi2_build_tid_rdma_read_req(qp, wqe, ohdr, &bth1,
+						     &bth2, &len);
+		if (delta <= 0) {
+			/* Wait for TID space */
+			goto bail;
+		}
+		hwords += delta;
+		ss = &wpriv->ss;
+		/* Check if this is the last segment */
+		if (req->cur_seg >= req->total_segs &&
+		    ++qp->s_cur == qp->s_size)
+			qp->s_cur = 0;
+		qp->s_psn = req->s_next_psn;
+		trace_hfi2_tid_req_make_req_read(qp, 0, wqe->wr.opcode,
+						 wqe->psn, wqe->lpsn, req);
+		break;
+	}
+	qp->s_sending_hpsn = bth2;
+	delta = delta_psn(bth2, wqe->psn);
+	if (delta && delta % HFI2_PSN_CREDIT == 0 &&
+	    wqe->wr.opcode != IB_WR_TID_RDMA_WRITE)
+		bth2 |= IB_BTH_REQ_ACK;
+	if (qp->s_flags & RVT_S_SEND_ONE) {
+		qp->s_flags &= ~RVT_S_SEND_ONE;
+		qp->s_flags |= RVT_S_WAIT_ACK;
+		bth2 |= IB_BTH_REQ_ACK;
+	}
+	qp->s_len -= len;
+	ps->s_txreq->hdr_dwords = hwords;
+	ps->s_txreq->sde = priv->s_sde;
+	ps->s_txreq->ss = ss;
+	ps->s_txreq->s_cur_size = len;
+	hfi2_make_ruc_header(
+		qp,
+		ohdr,
+		bth0 | (qp->s_state << 24),
+		bth1,
+		bth2,
+		middle,
+		ps);
+	return 1;
+
+done_free_tx:
+	hfi2_put_txreq(ps->s_txreq);
+	ps->s_txreq = NULL;
+	return 1;
+
+bail:
+	hfi2_put_txreq(ps->s_txreq);
+
+bail_no_tx:
+	ps->s_txreq = NULL;
+	qp->s_flags &= ~RVT_S_BUSY;
+	/*
+	 * If we didn't get a txreq, the QP will be woken up later to try
+	 * again. Set the flags to indicate which work item to wake
+	 * up.
+	 */
+	iowait_set_flag(&priv->s_iowait, IOWAIT_PENDING_IB);
+	return 0;
+}
+
+static inline void hfi2_make_bth_aeth(struct rvt_qp *qp,
+				      struct ib_other_headers *ohdr,
+				      u32 bth0, u32 bth1)
+{
+	if (qp->r_nak_state)
+		ohdr->u.aeth = cpu_to_be32((qp->r_msn & IB_MSN_MASK) |
+					    (qp->r_nak_state <<
+					     IB_AETH_CREDIT_SHIFT));
+	else
+		ohdr->u.aeth = rvt_compute_aeth(qp);
+
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(bth1 | qp->remote_qpn);
+	ohdr->bth[2] = cpu_to_be32(mask_psn(qp->r_ack_psn));
+}
+
+static inline void hfi2_queue_rc_ack(struct hfi2_packet *packet, bool is_fecn)
+{
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_ibport *ibp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK))
+		goto unlock;
+	ibp = rcd_to_iport(packet->rcd);
+	this_cpu_inc(*ibp->rvp.rc_qacks);
+	qp->s_flags |= RVT_S_ACK_PENDING | RVT_S_RESP_PENDING;
+	qp->s_nak_state = qp->r_nak_state;
+	qp->s_ack_psn = qp->r_ack_psn;
+	if (is_fecn)
+		qp->s_flags |= RVT_S_ECN;
+
+	/* Schedule the send tasklet. */
+	hfi2_schedule_send(qp);
+unlock:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+}
+
+static inline void hfi2_make_rc_ack_9B(struct hfi2_packet *packet,
+				       struct hfi2_opa_header *opa_hdr,
+				       u8 sc5, bool is_fecn,
+				       u64 *pbc_flags, u32 *hwords,
+				       u32 *nwords, u32 *l2)
+{
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_ibport *ibp = rcd_to_iport(packet->rcd);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct ib_header *hdr = &opa_hdr->ibh;
+	struct ib_other_headers *ohdr;
+	u16 lrh0 = HFI2_LRH_BTH;
+	u16 pkey;
+	u32 bth0, bth1;
+
+	opa_hdr->hdr_type = HFI2_PKT_TYPE_9B;
+	ohdr = &hdr->u.oth;
+	/* header size in 32-bit words LRH+BTH+AETH = (8+12+4)/4 */
+	*hwords = 6;
+
+	if (unlikely(rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH)) {
+		*hwords += hfi2_make_grh(ibp, &hdr->u.l.grh,
+					 rdma_ah_read_grh(&qp->remote_ah_attr),
+					 *hwords - 2, SIZE_OF_CRC);
+		ohdr = &hdr->u.l.oth;
+		lrh0 = HFI2_LRH_GRH;
+	}
+	/* set sc[4] in PBC flags */
+	*pbc_flags |= pbc_sc4_flag(sc5);
+	*l2 = PBC_L2_9B;
+
+	/* read pkey_index w/o lock (its atomic) */
+	pkey = hfi2_get_pkey(ibp, qp->s_pkey_index);
+
+	lrh0 |= (sc5 & IB_SC_MASK) << IB_SC_SHIFT |
+		(rdma_ah_get_sl(&qp->remote_ah_attr) & IB_SL_MASK) <<
+			IB_SL_SHIFT;
+
+	hfi2_make_ib_hdr(hdr, lrh0, *hwords + SIZE_OF_CRC,
+			 opa_get_lid(rdma_ah_get_dlid(&qp->remote_ah_attr), 9B),
+			 ppd->lid | rdma_ah_get_path_bits(&qp->remote_ah_attr));
+
+	bth0 = pkey | (OP(ACKNOWLEDGE) << 24);
+	if (qp->s_mig_state == IB_MIG_MIGRATED)
+		bth0 |= IB_BTH_MIG_REQ;
+	bth1 = (!!is_fecn) << IB_BECN_SHIFT;
+	/*
+	 * Inline ACKs go out without the use of the Verbs send engine, so
+	 * we need to set the STL Verbs Extended bit here
+	 */
+	bth1 |= HFI2_CAP_IS_KSET(OPFN) << IB_BTHE_E_SHIFT;
+	hfi2_make_bth_aeth(qp, ohdr, bth0, bth1);
+}
+
+static inline void hfi2_make_rc_ack_16B(struct hfi2_packet *packet,
+					struct hfi2_opa_header *opa_hdr,
+					u8 sc5, bool is_fecn,
+					u64 *pbc_flags, u32 *hwords,
+					u32 *nwords, u32 *l2)
+{
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_ibport *ibp = rcd_to_iport(packet->rcd);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_16b_header *hdr = &opa_hdr->opah;
+	struct ib_other_headers *ohdr;
+	u32 bth0, bth1 = 0;
+	u16 len, pkey;
+	bool becn = is_fecn;
+	u8 l4 = OPA_16B_L4_IB_LOCAL;
+	u8 extra_bytes;
+
+	opa_hdr->hdr_type = HFI2_PKT_TYPE_16B;
+	ohdr = &hdr->u.oth;
+	/* header size in 32-bit words 16B LRH+BTH+AETH = (16+12+4)/4 */
+	*hwords = 8;
+	if (ppd->dd->params->chip_type == CHIP_WFR) {
+		extra_bytes = hfi2_get_16b_padding(*hwords << 2, 0);
+		*nwords = SIZE_OF_CRC + ((extra_bytes + SIZE_OF_LT) >> 2);
+	} else {
+		extra_bytes = hfi2_pad8(*hwords << 2);
+		/* add CRC QW */
+		*nwords = (extra_bytes + 8) >> 2;
+	}
+
+	if (unlikely(rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH) &&
+	    hfi2_check_mcast(rdma_ah_get_dlid(&qp->remote_ah_attr))) {
+		*hwords += hfi2_make_grh(ibp, &hdr->u.l.grh,
+					 rdma_ah_read_grh(&qp->remote_ah_attr),
+					 *hwords - 4, *nwords);
+		ohdr = &hdr->u.l.oth;
+		l4 = OPA_16B_L4_IB_GLOBAL;
+	}
+	/* pbc_flags: no extra flags added */
+	*l2 = PBC_L2_16B;
+
+	/* read pkey_index w/o lock (its atomic) */
+	pkey = hfi2_get_pkey(ibp, qp->s_pkey_index);
+
+	/* Convert dwords to flits */
+	len = (*hwords + *nwords) >> 1;
+
+	hfi2_make_16b_hdr(hdr, ppd->lid |
+			  (rdma_ah_get_path_bits(&qp->remote_ah_attr) &
+			  ((1 << ppd->lmc) - 1)),
+			  opa_get_lid(rdma_ah_get_dlid(&qp->remote_ah_attr),
+				      16B), len, pkey, becn, 0, l4, sc5);
+
+	bth0 = pkey | (OP(ACKNOWLEDGE) << 24);
+	bth0 |= extra_bytes << 20;
+	if (qp->s_mig_state == IB_MIG_MIGRATED)
+		bth1 = OPA_BTH_MIG_REQ;
+	hfi2_make_bth_aeth(qp, ohdr, bth0, bth1);
+}
+
+typedef void (*hfi2_make_rc_ack)(struct hfi2_packet *packet,
+				 struct hfi2_opa_header *opa_hdr,
+				 u8 sc5, bool is_fecn,
+				 u64 *pbc_flags, u32 *hwords,
+				 u32 *nwords, u32 *l2);
+
+/* We support only two types - 9B and 16B for now */
+static const hfi2_make_rc_ack hfi2_make_rc_ack_tbl[2] = {
+	[HFI2_PKT_TYPE_9B] = &hfi2_make_rc_ack_9B,
+	[HFI2_PKT_TYPE_16B] = &hfi2_make_rc_ack_16B
+};
+
+/*
+ * hfi2_send_rc_ack - Construct an ACK packet and send it
+ *
+ * This is called from hfi2_rc_rcv() and handle_receive_interrupt().
+ * Note that RDMA reads and atomics are handled in the
+ * send side QP state and send engine.
+ */
+void hfi2_send_rc_ack(struct hfi2_packet *packet, bool is_fecn)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_ibport *ibp = rcd_to_iport(rcd);
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+	u8 sc5 = ibp->sl_to_sc[rdma_ah_get_sl(&qp->remote_ah_attr)];
+	u64 pbc, pbc_flags = 0;
+	u32 l2 = PBC_L2_9B; /* will be overridden */
+	u32 hwords = 0;
+	u32 nwords = 0;
+	u32 plen;
+	struct pio_buf *pbuf;
+	struct hfi2_opa_header opa_hdr;
+
+	/* clear the defer count */
+	qp->r_adefered = 0;
+
+	/* Don't send ACK or NAK if a RDMA read or atomic is pending. */
+	if (qp->s_flags & RVT_S_RESP_PENDING) {
+		hfi2_queue_rc_ack(packet, is_fecn);
+		return;
+	}
+
+	/* Ensure s_rdma_ack_cnt changes are committed */
+	if (qp->s_rdma_ack_cnt) {
+		hfi2_queue_rc_ack(packet, is_fecn);
+		return;
+	}
+
+	/* Don't try to send ACKs if the link isn't ACTIVE */
+	if (driver_lstate(ppd) != IB_PORT_ACTIVE)
+		return;
+
+	/* Make the appropriate header */
+	hfi2_make_rc_ack_tbl[priv->hdr_type](packet, &opa_hdr, sc5, is_fecn,
+					     &pbc_flags, &hwords, &nwords,
+					     &l2);
+
+	plen = 2 /* PBC */ + hwords + nwords;
+	pbc = dd->params->create_pbc(ppd, pbc_flags, qp->srate_mbps,
+				     sc_to_vlt(ppd, sc5), plen, l2,
+				     packet->dlid, rcd->sc->hw_context);
+	pbuf = sc_buffer_alloc(rcd->sc, plen, NULL, NULL);
+	if (IS_ERR_OR_NULL(pbuf)) {
+		/*
+		 * We have no room to send at the moment.  Pass
+		 * responsibility for sending the ACK to the send engine
+		 * so that when enough buffer space becomes available,
+		 * the ACK is sent ahead of other outgoing packets.
+		 */
+		hfi2_queue_rc_ack(packet, is_fecn);
+		return;
+	}
+	trace_ack_output_ibhdr(dd, &opa_hdr, ib_is_sc5(sc5), 0);
+
+	/* write the pbc and data */
+	dd->pio_inline_send(dd, pbuf, pbc,
+			    (priv->hdr_type == HFI2_PKT_TYPE_9B ?
+			    (void *)&opa_hdr.ibh :
+			    (void *)&opa_hdr.opah), hwords);
+	return;
+}
+
+/**
+ * update_num_rd_atomic - update the qp->s_num_rd_atomic
+ * @qp: the QP
+ * @psn: the packet sequence number to restart at
+ * @wqe: the wqe
+ *
+ * This is called from reset_psn() to update qp->s_num_rd_atomic
+ * for the current wqe.
+ * Called at interrupt level with the QP s_lock held.
+ */
+static void update_num_rd_atomic(struct rvt_qp *qp, u32 psn,
+				 struct rvt_swqe *wqe)
+{
+	u32 opcode = wqe->wr.opcode;
+
+	if (opcode == IB_WR_RDMA_READ ||
+	    opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+	    opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
+		qp->s_num_rd_atomic++;
+	} else if (opcode == IB_WR_TID_RDMA_READ) {
+		struct tid_rdma_request *req = wqe_to_tid_req(wqe);
+		struct hfi2_qp_priv *priv = qp->priv;
+
+		if (cmp_psn(psn, wqe->lpsn) <= 0) {
+			u32 cur_seg;
+
+			cur_seg = (psn - wqe->psn) / priv->pkts_ps;
+			req->ack_pending = cur_seg - req->comp_seg;
+			priv->pending_tid_r_segs += req->ack_pending;
+			qp->s_num_rd_atomic += req->ack_pending;
+			trace_hfi2_tid_req_update_num_rd_atomic(qp, 0,
+								wqe->wr.opcode,
+								wqe->psn,
+								wqe->lpsn,
+								req);
+		} else {
+			priv->pending_tid_r_segs += req->total_segs;
+			qp->s_num_rd_atomic += req->total_segs;
+		}
+	}
+}
+
+/**
+ * reset_psn - reset the QP state to send starting from PSN
+ * @qp: the QP
+ * @psn: the packet sequence number to restart at
+ *
+ * This is called from hfi2_rc_rcv() to process an incoming RC ACK
+ * for the given QP.
+ * Called at interrupt level with the QP s_lock held.
+ */
+static void reset_psn(struct rvt_qp *qp, u32 psn)
+{
+	u32 n = qp->s_acked;
+	struct rvt_swqe *wqe = rvt_get_swqe_ptr(qp, n);
+	u32 opcode;
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	lockdep_assert_held(&qp->s_lock);
+	qp->s_cur = n;
+	priv->pending_tid_r_segs = 0;
+	priv->pending_tid_w_resp = 0;
+	qp->s_num_rd_atomic = 0;
+
+	/*
+	 * If we are starting the request from the beginning,
+	 * let the normal send code handle initialization.
+	 */
+	if (cmp_psn(psn, wqe->psn) <= 0) {
+		qp->s_state = OP(SEND_LAST);
+		goto done;
+	}
+	update_num_rd_atomic(qp, psn, wqe);
+
+	/* Find the work request opcode corresponding to the given PSN. */
+	for (;;) {
+		int diff;
+
+		if (++n == qp->s_size)
+			n = 0;
+		if (n == qp->s_tail)
+			break;
+		wqe = rvt_get_swqe_ptr(qp, n);
+		diff = cmp_psn(psn, wqe->psn);
+		if (diff < 0) {
+			/* Point wqe back to the previous one*/
+			wqe = rvt_get_swqe_ptr(qp, qp->s_cur);
+			break;
+		}
+		qp->s_cur = n;
+		/*
+		 * If we are starting the request from the beginning,
+		 * let the normal send code handle initialization.
+		 */
+		if (diff == 0) {
+			qp->s_state = OP(SEND_LAST);
+			goto done;
+		}
+
+		update_num_rd_atomic(qp, psn, wqe);
+	}
+	opcode = wqe->wr.opcode;
+
+	/*
+	 * Set the state to restart in the middle of a request.
+	 * Don't change the s_sge, s_cur_sge, or s_cur_size.
+	 * See hfi2_make_rc_req().
+	 */
+	switch (opcode) {
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+		qp->s_state = OP(RDMA_READ_RESPONSE_FIRST);
+		break;
+
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		qp->s_state = OP(RDMA_READ_RESPONSE_LAST);
+		break;
+
+	case IB_WR_TID_RDMA_WRITE:
+		qp->s_state = TID_OP(WRITE_RESP);
+		break;
+
+	case IB_WR_RDMA_READ:
+		qp->s_state = OP(RDMA_READ_RESPONSE_MIDDLE);
+		break;
+
+	case IB_WR_TID_RDMA_READ:
+		qp->s_state = TID_OP(READ_RESP);
+		break;
+
+	default:
+		/*
+		 * This case shouldn't happen since its only
+		 * one PSN per req.
+		 */
+		qp->s_state = OP(SEND_LAST);
+	}
+done:
+	priv->s_flags &= ~HFI2_S_TID_WAIT_INTERLCK;
+	qp->s_psn = psn;
+	/*
+	 * Set RVT_S_WAIT_PSN as rc_complete() may start the timer
+	 * asynchronously before the send engine can get scheduled.
+	 * Doing it in hfi2_make_rc_req() is too late.
+	 */
+	if ((cmp_psn(qp->s_psn, qp->s_sending_hpsn) <= 0) &&
+	    (cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) <= 0))
+		qp->s_flags |= RVT_S_WAIT_PSN;
+	qp->s_flags &= ~HFI2_S_AHG_VALID;
+	trace_hfi2_sender_reset_psn(qp);
+}
+
+/*
+ * Back up requester to resend the last un-ACKed request.
+ * The QP r_lock and s_lock should be held and interrupts disabled.
+ */
+void hfi2_restart_rc(struct rvt_qp *qp, u32 psn, int wait)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct rvt_swqe *wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+	struct hfi2_ibport *ibp;
+
+	lockdep_assert_held(&qp->r_lock);
+	lockdep_assert_held(&qp->s_lock);
+	trace_hfi2_sender_restart_rc(qp);
+	if (qp->s_retry == 0) {
+		if (qp->s_mig_state == IB_MIG_ARMED) {
+			hfi2_migrate_qp(qp);
+			qp->s_retry = qp->s_retry_cnt;
+		} else if (qp->s_last == qp->s_acked) {
+			/*
+			 * We need special handling for the OPFN request WQEs as
+			 * they are not allowed to generate real user errors
+			 */
+			if (wqe->wr.opcode == IB_WR_OPFN) {
+				struct hfi2_ibport *ibp =
+					to_iport(qp->ibqp.device, qp->port_num);
+				/*
+				 * Call opfn_conn_reply() with capcode and
+				 * remaining data as 0 to close out the
+				 * current request
+				 */
+				opfn_conn_reply(qp, priv->opfn.curr);
+				wqe = do_rc_completion(qp, wqe, ibp);
+				qp->s_flags &= ~RVT_S_WAIT_ACK;
+			} else {
+				trace_hfi2_tid_write_sender_restart_rc(qp, 0);
+				if (wqe->wr.opcode == IB_WR_TID_RDMA_READ) {
+					struct tid_rdma_request *req;
+
+					req = wqe_to_tid_req(wqe);
+					hfi2_kern_exp_rcv_clear_all(req);
+					hfi2_kern_clear_hw_flow(priv->rcd, qp);
+				}
+
+				hfi2_trdma_send_complete(qp, wqe,
+							 IB_WC_RETRY_EXC_ERR);
+				rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+			}
+			return;
+		} else { /* need to handle delayed completion */
+			return;
+		}
+	} else {
+		qp->s_retry--;
+	}
+
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+	if (wqe->wr.opcode == IB_WR_RDMA_READ ||
+	    wqe->wr.opcode == IB_WR_TID_RDMA_READ)
+		ibp->rvp.n_rc_resends++;
+	else
+		ibp->rvp.n_rc_resends += delta_psn(qp->s_psn, psn);
+
+	qp->s_flags &= ~(RVT_S_WAIT_FENCE | RVT_S_WAIT_RDMAR |
+			 RVT_S_WAIT_SSN_CREDIT | RVT_S_WAIT_PSN |
+			 RVT_S_WAIT_ACK | HFI2_S_WAIT_TID_RESP);
+	if (wait)
+		qp->s_flags |= RVT_S_SEND_ONE;
+	reset_psn(qp, psn);
+}
+
+/*
+ * Set qp->s_sending_psn to the next PSN after the given one.
+ * This would be psn+1 except when RDMA reads or TID RDMA ops
+ * are present.
+ */
+static void reset_sending_psn(struct rvt_qp *qp, u32 psn)
+{
+	struct rvt_swqe *wqe;
+	u32 n = qp->s_last;
+
+	lockdep_assert_held(&qp->s_lock);
+	/* Find the work request corresponding to the given PSN. */
+	for (;;) {
+		wqe = rvt_get_swqe_ptr(qp, n);
+		if (cmp_psn(psn, wqe->lpsn) <= 0) {
+			if (wqe->wr.opcode == IB_WR_RDMA_READ ||
+			    wqe->wr.opcode == IB_WR_TID_RDMA_READ ||
+			    wqe->wr.opcode == IB_WR_TID_RDMA_WRITE)
+				qp->s_sending_psn = wqe->lpsn + 1;
+			else
+				qp->s_sending_psn = psn + 1;
+			break;
+		}
+		if (++n == qp->s_size)
+			n = 0;
+		if (n == qp->s_tail)
+			break;
+	}
+}
+
+/**
+ * hfi2_rc_verbs_aborted - handle abort status
+ * @qp: the QP
+ * @opah: the opa header
+ *
+ * This code modifies both ACK bit in BTH[2]
+ * and the s_flags to go into send one mode.
+ *
+ * This serves to throttle the send engine to only
+ * send a single packet in the likely case the
+ * a link has gone down.
+ */
+void hfi2_rc_verbs_aborted(struct rvt_qp *qp, struct hfi2_opa_header *opah)
+{
+	struct ib_other_headers *ohdr = hfi2_get_rc_ohdr(opah);
+	u8 opcode = ib_bth_get_opcode(ohdr);
+	u32 psn;
+
+	/* ignore responses */
+	if ((opcode >= OP(RDMA_READ_RESPONSE_FIRST) &&
+	     opcode <= OP(ATOMIC_ACKNOWLEDGE)) ||
+	    opcode == TID_OP(READ_RESP) ||
+	    opcode == TID_OP(WRITE_RESP))
+		return;
+
+	psn = ib_bth_get_psn(ohdr) | IB_BTH_REQ_ACK;
+	ohdr->bth[2] = cpu_to_be32(psn);
+	qp->s_flags |= RVT_S_SEND_ONE;
+}
+
+/*
+ * This should be called with the QP s_lock held and interrupts disabled.
+ */
+void hfi2_rc_send_complete(struct rvt_qp *qp, struct hfi2_opa_header *opah)
+{
+	struct ib_other_headers *ohdr;
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct rvt_swqe *wqe;
+	u32 opcode, head, tail;
+	u32 psn;
+	struct tid_rdma_request *req;
+
+	lockdep_assert_held(&qp->s_lock);
+	if (!(ib_rvt_state_ops[qp->state] & RVT_SEND_OR_FLUSH_OR_RECV_OK))
+		return;
+
+	ohdr = hfi2_get_rc_ohdr(opah);
+	opcode = ib_bth_get_opcode(ohdr);
+	if ((opcode >= OP(RDMA_READ_RESPONSE_FIRST) &&
+	     opcode <= OP(ATOMIC_ACKNOWLEDGE)) ||
+	    opcode == TID_OP(READ_RESP) ||
+	    opcode == TID_OP(WRITE_RESP)) {
+		WARN_ON(!qp->s_rdma_ack_cnt);
+		qp->s_rdma_ack_cnt--;
+		return;
+	}
+
+	psn = ib_bth_get_psn(ohdr);
+	/*
+	 * Don't attempt to reset the sending PSN for packets in the
+	 * KDETH PSN space since the PSN does not match anything.
+	 */
+	if (opcode != TID_OP(WRITE_DATA) &&
+	    opcode != TID_OP(WRITE_DATA_LAST) &&
+	    opcode != TID_OP(ACK) && opcode != TID_OP(RESYNC))
+		reset_sending_psn(qp, psn);
+
+	/* Handle TID RDMA WRITE packets differently */
+	if (opcode >= TID_OP(WRITE_REQ) &&
+	    opcode <= TID_OP(WRITE_DATA_LAST)) {
+		head = priv->s_tid_head;
+		tail = priv->s_tid_cur;
+		/*
+		 * s_tid_cur is set to s_tid_head in the case, where
+		 * a new TID RDMA request is being started and all
+		 * previous ones have been completed.
+		 * Therefore, we need to do a secondary check in order
+		 * to properly determine whether we should start the
+		 * RC timer.
+		 */
+		wqe = rvt_get_swqe_ptr(qp, tail);
+		req = wqe_to_tid_req(wqe);
+		if (head == tail && req->comp_seg < req->total_segs) {
+			if (tail == 0)
+				tail = qp->s_size - 1;
+			else
+				tail -= 1;
+		}
+	} else {
+		head = qp->s_tail;
+		tail = qp->s_acked;
+	}
+
+	/*
+	 * Start timer after a packet requesting an ACK has been sent and
+	 * there are still requests that haven't been acked.
+	 */
+	if ((psn & IB_BTH_REQ_ACK) && tail != head &&
+	    opcode != TID_OP(WRITE_DATA) && opcode != TID_OP(WRITE_DATA_LAST) &&
+	    opcode != TID_OP(RESYNC) &&
+	    !(qp->s_flags &
+	      (RVT_S_TIMER | RVT_S_WAIT_RNR | RVT_S_WAIT_PSN)) &&
+	    (ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK)) {
+		if (opcode == TID_OP(READ_REQ))
+			rvt_add_retry_timer_ext(qp, priv->timeout_shift);
+		else
+			rvt_add_retry_timer(qp);
+	}
+
+	/* Start TID RDMA ACK timer */
+	if ((opcode == TID_OP(WRITE_DATA) ||
+	     opcode == TID_OP(WRITE_DATA_LAST) ||
+	     opcode == TID_OP(RESYNC)) &&
+	    (psn & IB_BTH_REQ_ACK) &&
+	    !(priv->s_flags & HFI2_S_TID_RETRY_TIMER) &&
+	    (ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK)) {
+		/*
+		 * The TID RDMA ACK packet could be received before this
+		 * function is called. Therefore, add the timer only if TID
+		 * RDMA ACK packets are actually pending.
+		 */
+		wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+		req = wqe_to_tid_req(wqe);
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE &&
+		    req->ack_seg < req->cur_seg)
+			hfi2_add_tid_retry_timer(qp);
+	}
+
+	while (qp->s_last != qp->s_acked) {
+		wqe = rvt_get_swqe_ptr(qp, qp->s_last);
+		if (cmp_psn(wqe->lpsn, qp->s_sending_psn) >= 0 &&
+		    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) <= 0)
+			break;
+		trdma_clean_swqe(qp, wqe);
+		trace_hfi2_qp_send_completion(qp, wqe, qp->s_last);
+		rvt_qp_complete_swqe(qp,
+				     wqe,
+				     ib_hfi2_wc_opcode[wqe->wr.opcode],
+				     IB_WC_SUCCESS);
+	}
+	/*
+	 * If we were waiting for sends to complete before re-sending,
+	 * and they are now complete, restart sending.
+	 */
+	trace_hfi2_sendcomplete(qp, psn);
+	if (qp->s_flags & RVT_S_WAIT_PSN &&
+	    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) > 0) {
+		qp->s_flags &= ~RVT_S_WAIT_PSN;
+		qp->s_sending_psn = qp->s_psn;
+		qp->s_sending_hpsn = qp->s_psn - 1;
+		hfi2_schedule_send(qp);
+	}
+}
+
+static inline void update_last_psn(struct rvt_qp *qp, u32 psn)
+{
+	qp->s_last_psn = psn;
+}
+
+/*
+ * Generate a SWQE completion.
+ * This is similar to hfi2_send_complete but has to check to be sure
+ * that the SGEs are not being referenced if the SWQE is being resent.
+ */
+struct rvt_swqe *do_rc_completion(struct rvt_qp *qp,
+				  struct rvt_swqe *wqe,
+				  struct hfi2_ibport *ibp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	lockdep_assert_held(&qp->s_lock);
+	/*
+	 * Don't decrement refcount and don't generate a
+	 * completion if the SWQE is being resent until the send
+	 * is finished.
+	 */
+	trace_hfi2_rc_completion(qp, wqe->lpsn);
+	if (cmp_psn(wqe->lpsn, qp->s_sending_psn) < 0 ||
+	    cmp_psn(qp->s_sending_psn, qp->s_sending_hpsn) > 0) {
+		trdma_clean_swqe(qp, wqe);
+		trace_hfi2_qp_send_completion(qp, wqe, qp->s_last);
+		rvt_qp_complete_swqe(qp,
+				     wqe,
+				     ib_hfi2_wc_opcode[wqe->wr.opcode],
+				     IB_WC_SUCCESS);
+	} else {
+		struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+
+		this_cpu_inc(*ibp->rvp.rc_delayed_comp);
+		/*
+		 * If send progress not running attempt to progress
+		 * SDMA queue.
+		 */
+		if (ppd->dd->flags & HFI2_HAS_SEND_DMA) {
+			struct sdma_engine *engine;
+			u8 sl = rdma_ah_get_sl(&qp->remote_ah_attr);
+			u8 sc5;
+
+			/* For now use sc to find engine */
+			sc5 = ibp->sl_to_sc[sl];
+			engine = qp_to_sdma_engine(qp, sc5);
+			sdma_engine_progress_schedule(engine);
+		}
+	}
+
+	qp->s_retry = qp->s_retry_cnt;
+	/*
+	 * Don't update the last PSN if the request being completed is
+	 * a TID RDMA WRITE request.
+	 * Completion of the TID RDMA WRITE requests are done by the
+	 * TID RDMA ACKs and as such could be for a request that has
+	 * already been ACKed as far as the IB state machine is
+	 * concerned.
+	 */
+	if (wqe->wr.opcode != IB_WR_TID_RDMA_WRITE)
+		update_last_psn(qp, wqe->lpsn);
+
+	/*
+	 * If we are completing a request which is in the process of
+	 * being resent, we can stop re-sending it since we know the
+	 * responder has already seen it.
+	 */
+	if (qp->s_acked == qp->s_cur) {
+		if (++qp->s_cur >= qp->s_size)
+			qp->s_cur = 0;
+		qp->s_acked = qp->s_cur;
+		wqe = rvt_get_swqe_ptr(qp, qp->s_cur);
+		if (qp->s_acked != qp->s_tail) {
+			qp->s_state = OP(SEND_LAST);
+			qp->s_psn = wqe->psn;
+		}
+	} else {
+		if (++qp->s_acked >= qp->s_size)
+			qp->s_acked = 0;
+		if (qp->state == IB_QPS_SQD && qp->s_acked == qp->s_cur)
+			qp->s_draining = 0;
+		wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+	}
+	if (priv->s_flags & HFI2_S_TID_WAIT_INTERLCK) {
+		priv->s_flags &= ~HFI2_S_TID_WAIT_INTERLCK;
+		hfi2_schedule_send(qp);
+	}
+	return wqe;
+}
+
+static void set_restart_qp(struct rvt_qp *qp, struct hfi2_ctxtdata *rcd)
+{
+	/* Retry this request. */
+	if (!(qp->r_flags & RVT_R_RDMAR_SEQ)) {
+		qp->r_flags |= RVT_R_RDMAR_SEQ;
+		hfi2_restart_rc(qp, qp->s_last_psn + 1, 0);
+		if (list_empty(&qp->rspwait)) {
+			qp->r_flags |= RVT_R_RSP_SEND;
+			rvt_get_qp(qp);
+			list_add_tail(&qp->rspwait, &rcd->qp_wait_list);
+		}
+	}
+}
+
+/**
+ * update_qp_retry_state - Update qp retry state.
+ * @qp: the QP
+ * @psn: the packet sequence number of the TID RDMA WRITE RESP.
+ * @spsn:  The start psn for the given TID RDMA WRITE swqe.
+ * @lpsn:  The last psn for the given TID RDMA WRITE swqe.
+ *
+ * This function is called to update the qp retry state upon
+ * receiving a TID WRITE RESP after the qp is scheduled to retry
+ * a request.
+ */
+static void update_qp_retry_state(struct rvt_qp *qp, u32 psn, u32 spsn,
+				  u32 lpsn)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+
+	qp->s_psn = psn + 1;
+	/*
+	 * If this is the first TID RDMA WRITE RESP packet for the current
+	 * request, change the s_state so that the retry will be processed
+	 * correctly. Similarly, if this is the last TID RDMA WRITE RESP
+	 * packet, change the s_state and advance the s_cur.
+	 */
+	if (cmp_psn(psn, lpsn) >= 0) {
+		qp->s_cur = qpriv->s_tid_cur + 1;
+		if (qp->s_cur >= qp->s_size)
+			qp->s_cur = 0;
+		qp->s_state = TID_OP(WRITE_REQ);
+	} else  if (!cmp_psn(psn, spsn)) {
+		qp->s_cur = qpriv->s_tid_cur;
+		qp->s_state = TID_OP(WRITE_RESP);
+	}
+}
+
+/*
+ * do_rc_ack - process an incoming RC ACK
+ * @qp: the QP the ACK came in on
+ * @psn: the packet sequence number of the ACK
+ * @opcode: the opcode of the request that resulted in the ACK
+ *
+ * This is called from rc_rcv_resp() to process an incoming RC ACK
+ * for the given QP.
+ * May be called at interrupt level, with the QP s_lock held.
+ * Returns 1 if OK, 0 if current operation should be aborted (NAK).
+ */
+int do_rc_ack(struct rvt_qp *qp, u32 aeth, u32 psn, int opcode,
+	      u64 val, struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_ibport *ibp;
+	enum ib_wc_status status;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct rvt_swqe *wqe;
+	int ret = 0;
+	u32 ack_psn;
+	int diff;
+	struct rvt_dev_info *rdi;
+
+	lockdep_assert_held(&qp->s_lock);
+	/*
+	 * Note that NAKs implicitly ACK outstanding SEND and RDMA write
+	 * requests and implicitly NAK RDMA read and atomic requests issued
+	 * before the NAK'ed request.  The MSN won't include the NAK'ed
+	 * request but will include an ACK'ed request(s).
+	 */
+	ack_psn = psn;
+	if (aeth >> IB_AETH_NAK_SHIFT)
+		ack_psn--;
+	wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+	ibp = rcd_to_iport(rcd);
+
+	/*
+	 * The MSN might be for a later WQE than the PSN indicates so
+	 * only complete WQEs that the PSN finishes.
+	 */
+	while ((diff = delta_psn(ack_psn, wqe->lpsn)) >= 0) {
+		/*
+		 * RDMA_READ_RESPONSE_ONLY is a special case since
+		 * we want to generate completion events for everything
+		 * before the RDMA read, copy the data, then generate
+		 * the completion for the read.
+		 */
+		if (wqe->wr.opcode == IB_WR_RDMA_READ &&
+		    opcode == OP(RDMA_READ_RESPONSE_ONLY) &&
+		    diff == 0) {
+			ret = 1;
+			goto bail_stop;
+		}
+		/*
+		 * If this request is a RDMA read or atomic, and the ACK is
+		 * for a later operation, this ACK NAKs the RDMA read or
+		 * atomic.  In other words, only a RDMA_READ_LAST or ONLY
+		 * can ACK a RDMA read and likewise for atomic ops.  Note
+		 * that the NAK case can only happen if relaxed ordering is
+		 * used and requests are sent after an RDMA read or atomic
+		 * is sent but before the response is received.
+		 */
+		if ((wqe->wr.opcode == IB_WR_RDMA_READ &&
+		     (opcode != OP(RDMA_READ_RESPONSE_LAST) || diff != 0)) ||
+		    (wqe->wr.opcode == IB_WR_TID_RDMA_READ &&
+		     (opcode != TID_OP(READ_RESP) || diff != 0)) ||
+		    ((wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		      wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD) &&
+		     (opcode != OP(ATOMIC_ACKNOWLEDGE) || diff != 0)) ||
+		    (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE &&
+		     (delta_psn(psn, qp->s_last_psn) != 1))) {
+			set_restart_qp(qp, rcd);
+			/*
+			 * No need to process the ACK/NAK since we are
+			 * restarting an earlier request.
+			 */
+			goto bail_stop;
+		}
+		if (wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
+			u64 *vaddr = wqe->sg_list[0].vaddr;
+			*vaddr = val;
+		}
+		if (wqe->wr.opcode == IB_WR_OPFN)
+			opfn_conn_reply(qp, val);
+
+		if (qp->s_num_rd_atomic &&
+		    (wqe->wr.opcode == IB_WR_RDMA_READ ||
+		     wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		     wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD)) {
+			qp->s_num_rd_atomic--;
+			/* Restart sending task if fence is complete */
+			if ((qp->s_flags & RVT_S_WAIT_FENCE) &&
+			    !qp->s_num_rd_atomic) {
+				qp->s_flags &= ~(RVT_S_WAIT_FENCE |
+						 RVT_S_WAIT_ACK);
+				hfi2_schedule_send(qp);
+			} else if (qp->s_flags & RVT_S_WAIT_RDMAR) {
+				qp->s_flags &= ~(RVT_S_WAIT_RDMAR |
+						 RVT_S_WAIT_ACK);
+				hfi2_schedule_send(qp);
+			}
+		}
+
+		/*
+		 * TID RDMA WRITE requests will be completed by the TID RDMA
+		 * ACK packet handler (see tid_rdma.c).
+		 */
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE)
+			break;
+
+		wqe = do_rc_completion(qp, wqe, ibp);
+		if (qp->s_acked == qp->s_tail)
+			break;
+	}
+
+	trace_hfi2_rc_ack_do(qp, aeth, psn, wqe);
+	trace_hfi2_sender_do_rc_ack(qp);
+	switch (aeth >> IB_AETH_NAK_SHIFT) {
+	case 0:         /* ACK */
+		this_cpu_inc(*ibp->rvp.rc_acks);
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_READ) {
+			if (wqe_to_tid_req(wqe)->ack_pending)
+				rvt_mod_retry_timer_ext(qp,
+							qpriv->timeout_shift);
+			else
+				rvt_stop_rc_timers(qp);
+		} else if (qp->s_acked != qp->s_tail) {
+			struct rvt_swqe *__w = NULL;
+
+			if (qpriv->s_tid_cur != HFI2_QP_WQE_INVALID)
+				__w = rvt_get_swqe_ptr(qp, qpriv->s_tid_cur);
+
+			/*
+			 * Stop timers if we've received all of the TID RDMA
+			 * WRITE * responses.
+			 */
+			if (__w && __w->wr.opcode == IB_WR_TID_RDMA_WRITE &&
+			    opcode == TID_OP(WRITE_RESP)) {
+				/*
+				 * Normally, the loop above would correctly
+				 * process all WQEs from s_acked onward and
+				 * either complete them or check for correct
+				 * PSN sequencing.
+				 * However, for TID RDMA, due to pipelining,
+				 * the response may not be for the request at
+				 * s_acked so the above look would just be
+				 * skipped. This does not allow for checking
+				 * the PSN sequencing. It has to be done
+				 * separately.
+				 */
+				if (cmp_psn(psn, qp->s_last_psn + 1)) {
+					set_restart_qp(qp, rcd);
+					goto bail_stop;
+				}
+				/*
+				 * If the psn is being resent, stop the
+				 * resending.
+				 */
+				if (qp->s_cur != qp->s_tail &&
+				    cmp_psn(qp->s_psn, psn) <= 0)
+					update_qp_retry_state(qp, psn,
+							      __w->psn,
+							      __w->lpsn);
+				else if (--qpriv->pending_tid_w_resp)
+					rvt_mod_retry_timer(qp);
+				else
+					rvt_stop_rc_timers(qp);
+			} else {
+				/*
+				 * We are expecting more ACKs so
+				 * mod the retry timer.
+				 */
+				rvt_mod_retry_timer(qp);
+				/*
+				 * We can stop re-sending the earlier packets
+				 * and continue with the next packet the
+				 * receiver wants.
+				 */
+				if (cmp_psn(qp->s_psn, psn) <= 0)
+					reset_psn(qp, psn + 1);
+			}
+		} else {
+			/* No more acks - kill all timers */
+			rvt_stop_rc_timers(qp);
+			if (cmp_psn(qp->s_psn, psn) <= 0) {
+				qp->s_state = OP(SEND_LAST);
+				qp->s_psn = psn + 1;
+			}
+		}
+		if (qp->s_flags & RVT_S_WAIT_ACK) {
+			qp->s_flags &= ~RVT_S_WAIT_ACK;
+			hfi2_schedule_send(qp);
+		}
+		rvt_get_credit(qp, aeth);
+		qp->s_rnr_retry = qp->s_rnr_retry_cnt;
+		qp->s_retry = qp->s_retry_cnt;
+		/*
+		 * If the current request is a TID RDMA WRITE request and the
+		 * response is not a TID RDMA WRITE RESP packet, s_last_psn
+		 * can't be advanced.
+		 */
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE &&
+		    opcode != TID_OP(WRITE_RESP) &&
+		    cmp_psn(psn, wqe->psn) >= 0)
+			return 1;
+		update_last_psn(qp, psn);
+		return 1;
+
+	case 1:         /* RNR NAK */
+		ibp->rvp.n_rnr_naks++;
+		if (qp->s_acked == qp->s_tail)
+			goto bail_stop;
+		if (qp->s_flags & RVT_S_WAIT_RNR)
+			goto bail_stop;
+		rdi = ib_to_rvt(qp->ibqp.device);
+		if (!(rdi->post_parms[wqe->wr.opcode].flags &
+		       RVT_OPERATION_IGN_RNR_CNT)) {
+			if (qp->s_rnr_retry == 0) {
+				status = IB_WC_RNR_RETRY_EXC_ERR;
+				goto class_b;
+			}
+			if (qp->s_rnr_retry_cnt < 7 && qp->s_rnr_retry_cnt > 0)
+				qp->s_rnr_retry--;
+		}
+
+		/*
+		 * The last valid PSN is the previous PSN. For TID RDMA WRITE
+		 * request, s_last_psn should be incremented only when a TID
+		 * RDMA WRITE RESP is received to avoid skipping lost TID RDMA
+		 * WRITE RESP packets.
+		 */
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE) {
+			reset_psn(qp, qp->s_last_psn + 1);
+		} else {
+			update_last_psn(qp, psn - 1);
+			reset_psn(qp, psn);
+		}
+
+		ibp->rvp.n_rc_resends += delta_psn(qp->s_psn, psn);
+		qp->s_flags &= ~(RVT_S_WAIT_SSN_CREDIT | RVT_S_WAIT_ACK);
+		rvt_stop_rc_timers(qp);
+		rvt_add_rnr_timer(qp, aeth);
+		return 0;
+
+	case 3:         /* NAK */
+		if (qp->s_acked == qp->s_tail)
+			goto bail_stop;
+		/* The last valid PSN is the previous PSN. */
+		update_last_psn(qp, psn - 1);
+		switch ((aeth >> IB_AETH_CREDIT_SHIFT) &
+			IB_AETH_CREDIT_MASK) {
+		case 0: /* PSN sequence error */
+			ibp->rvp.n_seq_naks++;
+			/*
+			 * Back up to the responder's expected PSN.
+			 * Note that we might get a NAK in the middle of an
+			 * RDMA READ response which terminates the RDMA
+			 * READ.
+			 */
+			hfi2_restart_rc(qp, psn, 0);
+			hfi2_schedule_send(qp);
+			break;
+
+		case 1: /* Invalid Request */
+			status = IB_WC_REM_INV_REQ_ERR;
+			ibp->rvp.n_other_naks++;
+			goto class_b;
+
+		case 2: /* Remote Access Error */
+			status = IB_WC_REM_ACCESS_ERR;
+			ibp->rvp.n_other_naks++;
+			goto class_b;
+
+		case 3: /* Remote Operation Error */
+			status = IB_WC_REM_OP_ERR;
+			ibp->rvp.n_other_naks++;
+class_b:
+			if (qp->s_last == qp->s_acked) {
+				if (wqe->wr.opcode == IB_WR_TID_RDMA_READ)
+					hfi2_kern_read_tid_flow_free(qp);
+
+				hfi2_trdma_send_complete(qp, wqe, status);
+				rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+			}
+			break;
+
+		default:
+			/* Ignore other reserved NAK error codes */
+			goto reserved;
+		}
+		qp->s_retry = qp->s_retry_cnt;
+		qp->s_rnr_retry = qp->s_rnr_retry_cnt;
+		goto bail_stop;
+
+	default:                /* 2: reserved */
+reserved:
+		/* Ignore reserved NAK codes. */
+		goto bail_stop;
+	}
+	/* cannot be reached  */
+bail_stop:
+	rvt_stop_rc_timers(qp);
+	return ret;
+}
+
+/*
+ * We have seen an out of sequence RDMA read middle or last packet.
+ * This ACKs SENDs and RDMA writes up to the first RDMA read or atomic SWQE.
+ */
+static void rdma_seq_err(struct rvt_qp *qp, struct hfi2_ibport *ibp, u32 psn,
+			 struct hfi2_ctxtdata *rcd)
+{
+	struct rvt_swqe *wqe;
+
+	lockdep_assert_held(&qp->s_lock);
+	/* Remove QP from retry timer */
+	rvt_stop_rc_timers(qp);
+
+	wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+
+	while (cmp_psn(psn, wqe->lpsn) > 0) {
+		if (wqe->wr.opcode == IB_WR_RDMA_READ ||
+		    wqe->wr.opcode == IB_WR_TID_RDMA_READ ||
+		    wqe->wr.opcode == IB_WR_TID_RDMA_WRITE ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD)
+			break;
+		wqe = do_rc_completion(qp, wqe, ibp);
+	}
+
+	ibp->rvp.n_rdma_seq++;
+	qp->r_flags |= RVT_R_RDMAR_SEQ;
+	hfi2_restart_rc(qp, qp->s_last_psn + 1, 0);
+	if (list_empty(&qp->rspwait)) {
+		qp->r_flags |= RVT_R_RSP_SEND;
+		rvt_get_qp(qp);
+		list_add_tail(&qp->rspwait, &rcd->qp_wait_list);
+	}
+}
+
+/**
+ * rc_rcv_resp - process an incoming RC response packet
+ * @packet: data packet information
+ *
+ * This is called from hfi2_rc_rcv() to process an incoming RC response
+ * packet for the given QP.
+ * Called at interrupt level.
+ */
+static void rc_rcv_resp(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	void *data = packet->payload;
+	u32 tlen = packet->tlen;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_ibport *ibp;
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_swqe *wqe;
+	enum ib_wc_status status;
+	unsigned long flags;
+	int diff;
+	u64 val;
+	u32 aeth;
+	u32 psn = ib_bth_get_psn(packet->ohdr);
+	u32 pmtu = qp->pmtu;
+	u16 hdrsize = packet->hlen;
+	u8 opcode = packet->opcode;
+	u8 pad = packet->pad;
+	u8 extra_bytes = pad + packet->extra_byte + (SIZE_OF_CRC << 2);
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	trace_hfi2_ack(qp, psn);
+
+	/* Ignore invalid responses. */
+	if (cmp_psn(psn, READ_ONCE(qp->s_next_psn)) >= 0)
+		goto ack_done;
+
+	/* Ignore duplicate responses. */
+	diff = cmp_psn(psn, qp->s_last_psn);
+	if (unlikely(diff <= 0)) {
+		/* Update credits for "ghost" ACKs */
+		if (diff == 0 && opcode == OP(ACKNOWLEDGE)) {
+			aeth = be32_to_cpu(ohdr->u.aeth);
+			if ((aeth >> IB_AETH_NAK_SHIFT) == 0)
+				rvt_get_credit(qp, aeth);
+		}
+		goto ack_done;
+	}
+
+	/*
+	 * Skip everything other than the PSN we expect, if we are waiting
+	 * for a reply to a restarted RDMA read or atomic op.
+	 */
+	if (qp->r_flags & RVT_R_RDMAR_SEQ) {
+		if (cmp_psn(psn, qp->s_last_psn + 1) != 0)
+			goto ack_done;
+		qp->r_flags &= ~RVT_R_RDMAR_SEQ;
+	}
+
+	if (unlikely(qp->s_acked == qp->s_tail))
+		goto ack_done;
+	wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+	status = IB_WC_SUCCESS;
+
+	switch (opcode) {
+	case OP(ACKNOWLEDGE):
+	case OP(ATOMIC_ACKNOWLEDGE):
+	case OP(RDMA_READ_RESPONSE_FIRST):
+		aeth = be32_to_cpu(ohdr->u.aeth);
+		if (opcode == OP(ATOMIC_ACKNOWLEDGE))
+			val = ib_u64_get(&ohdr->u.at.atomic_ack_eth);
+		else
+			val = 0;
+		if (!do_rc_ack(qp, aeth, psn, opcode, val, rcd) ||
+		    opcode != OP(RDMA_READ_RESPONSE_FIRST))
+			goto ack_done;
+		wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+		if (unlikely(wqe->wr.opcode != IB_WR_RDMA_READ))
+			goto ack_op_err;
+		/*
+		 * If this is a response to a resent RDMA read, we
+		 * have to be careful to copy the data to the right
+		 * location.
+		 */
+		qp->s_rdma_read_len = restart_sge(&qp->s_rdma_read_sge,
+						  wqe, psn, pmtu);
+		goto read_middle;
+
+	case OP(RDMA_READ_RESPONSE_MIDDLE):
+		/* no AETH, no ACK */
+		if (unlikely(cmp_psn(psn, qp->s_last_psn + 1)))
+			goto ack_seq_err;
+		if (unlikely(wqe->wr.opcode != IB_WR_RDMA_READ))
+			goto ack_op_err;
+read_middle:
+		if (unlikely(tlen != (hdrsize + pmtu + extra_bytes)))
+			goto ack_len_err;
+		if (unlikely(pmtu >= qp->s_rdma_read_len))
+			goto ack_len_err;
+
+		/*
+		 * We got a response so update the timeout.
+		 * 4.096 usec. * (1 << qp->timeout)
+		 */
+		rvt_mod_retry_timer(qp);
+		if (qp->s_flags & RVT_S_WAIT_ACK) {
+			qp->s_flags &= ~RVT_S_WAIT_ACK;
+			hfi2_schedule_send(qp);
+		}
+
+		if (opcode == OP(RDMA_READ_RESPONSE_MIDDLE))
+			qp->s_retry = qp->s_retry_cnt;
+
+		/*
+		 * Update the RDMA receive state but do the copy w/o
+		 * holding the locks and blocking interrupts.
+		 */
+		qp->s_rdma_read_len -= pmtu;
+		update_last_psn(qp, psn);
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		rvt_copy_sge(qp, &qp->s_rdma_read_sge,
+			     data, pmtu, false, false);
+		goto bail;
+
+	case OP(RDMA_READ_RESPONSE_ONLY):
+		aeth = be32_to_cpu(ohdr->u.aeth);
+		if (!do_rc_ack(qp, aeth, psn, opcode, 0, rcd))
+			goto ack_done;
+		/*
+		 * Check that the data size is >= 0 && <= pmtu.
+		 * Remember to account for ICRC (4).
+		 */
+		if (unlikely(tlen < (hdrsize + extra_bytes)))
+			goto ack_len_err;
+		/*
+		 * If this is a response to a resent RDMA read, we
+		 * have to be careful to copy the data to the right
+		 * location.
+		 */
+		wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+		qp->s_rdma_read_len = restart_sge(&qp->s_rdma_read_sge,
+						  wqe, psn, pmtu);
+		goto read_last;
+
+	case OP(RDMA_READ_RESPONSE_LAST):
+		/* ACKs READ req. */
+		if (unlikely(cmp_psn(psn, qp->s_last_psn + 1)))
+			goto ack_seq_err;
+		if (unlikely(wqe->wr.opcode != IB_WR_RDMA_READ))
+			goto ack_op_err;
+		/*
+		 * Check that the data size is >= 1 && <= pmtu.
+		 * Remember to account for ICRC (4).
+		 */
+		if (unlikely(tlen <= (hdrsize + extra_bytes)))
+			goto ack_len_err;
+read_last:
+		tlen -= hdrsize + extra_bytes;
+		if (unlikely(tlen != qp->s_rdma_read_len))
+			goto ack_len_err;
+		aeth = be32_to_cpu(ohdr->u.aeth);
+		rvt_copy_sge(qp, &qp->s_rdma_read_sge,
+			     data, tlen, false, false);
+		WARN_ON(qp->s_rdma_read_sge.num_sge);
+		(void)do_rc_ack(qp, aeth, psn,
+				 OP(RDMA_READ_RESPONSE_LAST), 0, rcd);
+		goto ack_done;
+	}
+
+ack_op_err:
+	status = IB_WC_LOC_QP_OP_ERR;
+	goto ack_err;
+
+ack_seq_err:
+	ibp = rcd_to_iport(rcd);
+	rdma_seq_err(qp, ibp, psn, rcd);
+	goto ack_done;
+
+ack_len_err:
+	status = IB_WC_LOC_LEN_ERR;
+ack_err:
+	if (qp->s_last == qp->s_acked) {
+		rvt_send_complete(qp, wqe, status);
+		rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+	}
+ack_done:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+bail:
+	return;
+}
+
+static inline void rc_cancel_ack(struct rvt_qp *qp)
+{
+	qp->r_adefered = 0;
+	if (list_empty(&qp->rspwait))
+		return;
+	list_del_init(&qp->rspwait);
+	qp->r_flags &= ~RVT_R_RSP_NAK;
+	rvt_put_qp(qp);
+}
+
+/**
+ * rc_rcv_error - process an incoming duplicate or error RC packet
+ * @ohdr: the other headers for this packet
+ * @data: the packet data
+ * @qp: the QP for this packet
+ * @opcode: the opcode for this packet
+ * @psn: the packet sequence number for this packet
+ * @diff: the difference between the PSN and the expected PSN
+ * @rcd: the receive context
+ *
+ * This is called from hfi2_rc_rcv() to process an unexpected
+ * incoming RC packet for the given QP.
+ * Called at interrupt level.
+ * Return 1 if no more processing is needed; otherwise return 0 to
+ * schedule a response to be sent.
+ */
+static noinline int rc_rcv_error(struct ib_other_headers *ohdr, void *data,
+				 struct rvt_qp *qp, u32 opcode, u32 psn,
+				 int diff, struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_ibport *ibp = rcd_to_iport(rcd);
+	struct rvt_ack_entry *e;
+	unsigned long flags;
+	u8 prev;
+	u8 mra; /* most recent ACK */
+	bool old_req;
+
+	trace_hfi2_rcv_error(qp, psn);
+	if (diff > 0) {
+		/*
+		 * Packet sequence error.
+		 * A NAK will ACK earlier sends and RDMA writes.
+		 * Don't queue the NAK if we already sent one.
+		 */
+		if (!qp->r_nak_state) {
+			ibp->rvp.n_rc_seqnak++;
+			qp->r_nak_state = IB_NAK_PSN_ERROR;
+			/* Use the expected PSN. */
+			qp->r_ack_psn = qp->r_psn;
+			/*
+			 * Wait to send the sequence NAK until all packets
+			 * in the receive queue have been processed.
+			 * Otherwise, we end up propagating congestion.
+			 */
+			rc_defered_ack(rcd, qp);
+		}
+		goto done;
+	}
+
+	/*
+	 * Handle a duplicate request.  Don't re-execute SEND, RDMA
+	 * write or atomic op.  Don't NAK errors, just silently drop
+	 * the duplicate request.  Note that r_sge, r_len, and
+	 * r_rcv_len may be in use so don't modify them.
+	 *
+	 * We are supposed to ACK the earliest duplicate PSN but we
+	 * can coalesce an outstanding duplicate ACK.  We have to
+	 * send the earliest so that RDMA reads can be restarted at
+	 * the requester's expected PSN.
+	 *
+	 * First, find where this duplicate PSN falls within the
+	 * ACKs previously sent.
+	 * old_req is true if there is an older response that is scheduled
+	 * to be sent before sending this one.
+	 */
+	e = NULL;
+	old_req = true;
+	ibp->rvp.n_rc_dupreq++;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+
+	e = find_prev_entry(qp, psn, &prev, &mra, &old_req);
+
+	switch (opcode) {
+	case OP(RDMA_READ_REQUEST): {
+		struct ib_reth *reth;
+		u32 offset;
+		u32 len;
+
+		/*
+		 * If we didn't find the RDMA read request in the ack queue,
+		 * we can ignore this request.
+		 */
+		if (!e || e->opcode != OP(RDMA_READ_REQUEST))
+			goto unlock_done;
+		/* RETH comes after BTH */
+		reth = &ohdr->u.rc.reth;
+		/*
+		 * Address range must be a subset of the original
+		 * request and start on pmtu boundaries.
+		 * We reuse the old ack_queue slot since the requester
+		 * should not back up and request an earlier PSN for the
+		 * same request.
+		 */
+		offset = delta_psn(psn, e->psn) * qp->pmtu;
+		len = be32_to_cpu(reth->length);
+		if (unlikely(offset + len != e->rdma_sge.sge_length))
+			goto unlock_done;
+		release_rdma_sge_mr(e);
+		if (len != 0) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = get_ib_reth_vaddr(reth);
+			int ok;
+
+			ok = rvt_rkey_ok(qp, &e->rdma_sge, len, vaddr, rkey,
+					 IB_ACCESS_REMOTE_READ);
+			if (unlikely(!ok))
+				goto unlock_done;
+		} else {
+			e->rdma_sge.vaddr = NULL;
+			e->rdma_sge.length = 0;
+			e->rdma_sge.sge_length = 0;
+		}
+		e->psn = psn;
+		if (old_req)
+			goto unlock_done;
+		if (qp->s_acked_ack_queue == qp->s_tail_ack_queue)
+			qp->s_acked_ack_queue = prev;
+		qp->s_tail_ack_queue = prev;
+		break;
+	}
+
+	case OP(COMPARE_SWAP):
+	case OP(FETCH_ADD): {
+		/*
+		 * If we didn't find the atomic request in the ack queue
+		 * or the send engine is already backed up to send an
+		 * earlier entry, we can ignore this request.
+		 */
+		if (!e || e->opcode != (u8)opcode || old_req)
+			goto unlock_done;
+		if (qp->s_tail_ack_queue == qp->s_acked_ack_queue)
+			qp->s_acked_ack_queue = prev;
+		qp->s_tail_ack_queue = prev;
+		break;
+	}
+
+	default:
+		/*
+		 * Ignore this operation if it doesn't request an ACK
+		 * or an earlier RDMA read or atomic is going to be resent.
+		 */
+		if (!(psn & IB_BTH_REQ_ACK) || old_req)
+			goto unlock_done;
+		/*
+		 * Resend the most recent ACK if this request is
+		 * after all the previous RDMA reads and atomics.
+		 */
+		if (mra == qp->r_head_ack_queue) {
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+			qp->r_nak_state = 0;
+			qp->r_ack_psn = qp->r_psn - 1;
+			goto send_ack;
+		}
+
+		/*
+		 * Resend the RDMA read or atomic op which
+		 * ACKs this duplicate request.
+		 */
+		if (qp->s_tail_ack_queue == qp->s_acked_ack_queue)
+			qp->s_acked_ack_queue = mra;
+		qp->s_tail_ack_queue = mra;
+		break;
+	}
+	qp->s_ack_state = OP(ACKNOWLEDGE);
+	qp->s_flags |= RVT_S_RESP_PENDING;
+	qp->r_nak_state = 0;
+	hfi2_schedule_send(qp);
+
+unlock_done:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+done:
+	return 1;
+
+send_ack:
+	return 0;
+}
+
+static void log_cca_event(struct hfi2_pportdata *ppd, u8 sl, u32 rlid,
+			  u32 lqpn, u32 rqpn, u8 svc_type)
+{
+	struct opa_hfi2_cong_log_event_internal *cc_event;
+	unsigned long flags;
+
+	if (sl >= OPA_MAX_SLS)
+		return;
+
+	spin_lock_irqsave(&ppd->cc_log_lock, flags);
+
+	ppd->threshold_cong_event_map[sl / 8] |= 1 << (sl % 8);
+	ppd->threshold_event_counter++;
+
+	cc_event = &ppd->cc_events[ppd->cc_log_idx++];
+	if (ppd->cc_log_idx == OPA_CONG_LOG_ELEMS)
+		ppd->cc_log_idx = 0;
+	cc_event->lqpn = lqpn & RVT_QPN_MASK;
+	cc_event->rqpn = rqpn & RVT_QPN_MASK;
+	cc_event->sl = sl;
+	cc_event->svc_type = svc_type;
+	cc_event->rlid = rlid;
+	/* keep timestamp in units of 1.024 usec */
+	cc_event->timestamp = ktime_get_ns() / 1024;
+
+	spin_unlock_irqrestore(&ppd->cc_log_lock, flags);
+}
+
+void process_becn(struct hfi2_pportdata *ppd, u8 sl, u32 rlid, u32 lqpn,
+		  u32 rqpn, u8 svc_type)
+{
+	struct cca_timer *cca_timer;
+	u16 ccti, ccti_incr, ccti_timer, ccti_limit;
+	u8 trigger_threshold;
+	struct cc_state *cc_state;
+	unsigned long flags;
+
+	/* no direct driver congestion control involvement after WFR */
+	if (ppd->dd->params->chip_type != CHIP_WFR)
+		return;
+
+	if (sl >= OPA_MAX_SLS)
+		return;
+
+	cc_state = get_cc_state(ppd);
+
+	if (!cc_state)
+		return;
+
+	/*
+	 * 1) increase CCTI (for this SL)
+	 * 2) select IPG (i.e., call set_link_ipg())
+	 * 3) start timer
+	 */
+	ccti_limit = cc_state->cct.ccti_limit;
+	ccti_incr = cc_state->cong_setting.entries[sl].ccti_increase;
+	ccti_timer = cc_state->cong_setting.entries[sl].ccti_timer;
+	trigger_threshold =
+		cc_state->cong_setting.entries[sl].trigger_threshold;
+
+	spin_lock_irqsave(&ppd->cca_timer_lock, flags);
+
+	cca_timer = &ppd->cca_timer[sl];
+	if (cca_timer->ccti < ccti_limit) {
+		if (cca_timer->ccti + ccti_incr <= ccti_limit)
+			cca_timer->ccti += ccti_incr;
+		else
+			cca_timer->ccti = ccti_limit;
+		set_link_ipg(ppd);
+	}
+
+	ccti = cca_timer->ccti;
+
+	if (!hrtimer_active(&cca_timer->hrtimer)) {
+		/* ccti_timer is in units of 1.024 usec */
+		unsigned long nsec = 1024 * ccti_timer;
+
+		hrtimer_start(&cca_timer->hrtimer, ns_to_ktime(nsec),
+			      HRTIMER_MODE_REL_PINNED);
+	}
+
+	spin_unlock_irqrestore(&ppd->cca_timer_lock, flags);
+
+	if ((trigger_threshold != 0) && (ccti >= trigger_threshold))
+		log_cca_event(ppd, sl, rlid, lqpn, rqpn, svc_type);
+}
+
+/**
+ * hfi2_rc_rcv - process an incoming RC packet
+ * @packet: data packet information
+ *
+ * This is called from qp_rcv() to process an incoming RC packet
+ * for the given QP.
+ * May be called at interrupt level.
+ */
+void hfi2_rc_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	void *data = packet->payload;
+	u32 tlen = packet->tlen;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct hfi2_ibport *ibp = rcd_to_iport(rcd);
+	struct ib_other_headers *ohdr = packet->ohdr;
+	u32 opcode = packet->opcode;
+	u32 hdrsize = packet->hlen;
+	u32 psn = ib_bth_get_psn(packet->ohdr);
+	u32 pad = packet->pad;
+	struct ib_wc wc;
+	u32 pmtu = qp->pmtu;
+	int diff;
+	struct ib_reth *reth;
+	unsigned long flags;
+	int ret;
+	bool copy_last = false, fecn;
+	u32 rkey;
+	u8 extra_bytes = pad + packet->extra_byte + (SIZE_OF_CRC << 2);
+
+	lockdep_assert_held(&qp->r_lock);
+
+	if (hfi2_ruc_check_hdr(ibp, packet))
+		return;
+
+	fecn = process_ecn(qp, packet);
+	opfn_trigger_conn_request(qp, be32_to_cpu(ohdr->bth[1]));
+
+	/*
+	 * Process responses (ACKs) before anything else.  Note that the
+	 * packet sequence number will be for something in the send work
+	 * queue rather than the expected receive packet sequence number.
+	 * In other words, this QP is the requester.
+	 */
+	if (opcode >= OP(RDMA_READ_RESPONSE_FIRST) &&
+	    opcode <= OP(ATOMIC_ACKNOWLEDGE)) {
+		rc_rcv_resp(packet);
+		return;
+	}
+
+	/* Compute 24 bits worth of difference. */
+	diff = delta_psn(psn, qp->r_psn);
+	if (unlikely(diff)) {
+		if (rc_rcv_error(ohdr, data, qp, opcode, psn, diff, rcd))
+			return;
+		goto send_ack;
+	}
+
+	/* Check for opcode sequence errors. */
+	switch (qp->r_state) {
+	case OP(SEND_FIRST):
+	case OP(SEND_MIDDLE):
+		if (opcode == OP(SEND_MIDDLE) ||
+		    opcode == OP(SEND_LAST) ||
+		    opcode == OP(SEND_LAST_WITH_IMMEDIATE) ||
+		    opcode == OP(SEND_LAST_WITH_INVALIDATE))
+			break;
+		goto nack_inv;
+
+	case OP(RDMA_WRITE_FIRST):
+	case OP(RDMA_WRITE_MIDDLE):
+		if (opcode == OP(RDMA_WRITE_MIDDLE) ||
+		    opcode == OP(RDMA_WRITE_LAST) ||
+		    opcode == OP(RDMA_WRITE_LAST_WITH_IMMEDIATE))
+			break;
+		goto nack_inv;
+
+	default:
+		if (opcode == OP(SEND_MIDDLE) ||
+		    opcode == OP(SEND_LAST) ||
+		    opcode == OP(SEND_LAST_WITH_IMMEDIATE) ||
+		    opcode == OP(SEND_LAST_WITH_INVALIDATE) ||
+		    opcode == OP(RDMA_WRITE_MIDDLE) ||
+		    opcode == OP(RDMA_WRITE_LAST) ||
+		    opcode == OP(RDMA_WRITE_LAST_WITH_IMMEDIATE))
+			goto nack_inv;
+		/*
+		 * Note that it is up to the requester to not send a new
+		 * RDMA read or atomic operation before receiving an ACK
+		 * for the previous operation.
+		 */
+		break;
+	}
+
+	if (qp->state == IB_QPS_RTR && !(qp->r_flags & RVT_R_COMM_EST))
+		rvt_comm_est(qp);
+
+	/* OK, process the packet. */
+	switch (opcode) {
+	case OP(SEND_FIRST):
+		ret = rvt_get_rwqe(qp, false);
+		if (ret < 0)
+			goto nack_op_err;
+		if (!ret)
+			goto rnr_nak;
+		qp->r_rcv_len = 0;
+		fallthrough;
+	case OP(SEND_MIDDLE):
+	case OP(RDMA_WRITE_MIDDLE):
+send_middle:
+		/* Check for invalid length PMTU or posted rwqe len. */
+		/*
+		 * There will be no padding for 9B packet but 16B packets
+		 * will come in with some padding since we always add
+		 * CRC and LT bytes which will need to be flit aligned
+		 */
+		if (unlikely(tlen != (hdrsize + pmtu + extra_bytes)))
+			goto nack_inv;
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len))
+			goto nack_inv;
+		rvt_copy_sge(qp, &qp->r_sge, data, pmtu, true, false);
+		break;
+
+	case OP(RDMA_WRITE_LAST_WITH_IMMEDIATE):
+		/* consume RWQE */
+		ret = rvt_get_rwqe(qp, true);
+		if (ret < 0)
+			goto nack_op_err;
+		if (!ret)
+			goto rnr_nak;
+		goto send_last_imm;
+
+	case OP(SEND_ONLY):
+	case OP(SEND_ONLY_WITH_IMMEDIATE):
+	case OP(SEND_ONLY_WITH_INVALIDATE):
+		ret = rvt_get_rwqe(qp, false);
+		if (ret < 0)
+			goto nack_op_err;
+		if (!ret)
+			goto rnr_nak;
+		qp->r_rcv_len = 0;
+		if (opcode == OP(SEND_ONLY))
+			goto no_immediate_data;
+		if (opcode == OP(SEND_ONLY_WITH_INVALIDATE))
+			goto send_last_inv;
+		fallthrough;	/* for SEND_ONLY_WITH_IMMEDIATE */
+	case OP(SEND_LAST_WITH_IMMEDIATE):
+send_last_imm:
+		wc.ex.imm_data = ohdr->u.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		goto send_last;
+	case OP(SEND_LAST_WITH_INVALIDATE):
+send_last_inv:
+		rkey = be32_to_cpu(ohdr->u.ieth);
+		if (rvt_invalidate_rkey(qp, rkey))
+			goto no_immediate_data;
+		wc.ex.invalidate_rkey = rkey;
+		wc.wc_flags = IB_WC_WITH_INVALIDATE;
+		goto send_last;
+	case OP(RDMA_WRITE_LAST):
+		copy_last = rvt_is_user_qp(qp);
+		fallthrough;
+	case OP(SEND_LAST):
+no_immediate_data:
+		wc.wc_flags = 0;
+		wc.ex.imm_data = 0;
+send_last:
+		/* Check for invalid length. */
+		/* LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + extra_bytes)))
+			goto nack_inv;
+		/* Don't count the CRC(and padding and LT byte for 16B). */
+		tlen -= (hdrsize + extra_bytes);
+		wc.byte_len = tlen + qp->r_rcv_len;
+		if (unlikely(wc.byte_len > qp->r_len))
+			goto nack_inv;
+		rvt_copy_sge(qp, &qp->r_sge, data, tlen, true, copy_last);
+		rvt_put_ss(&qp->r_sge);
+		qp->r_msn++;
+		if (!__test_and_clear_bit(RVT_R_WRID_VALID, &qp->r_aflags))
+			break;
+		wc.wr_id = qp->r_wr_id;
+		wc.status = IB_WC_SUCCESS;
+		if (opcode == OP(RDMA_WRITE_LAST_WITH_IMMEDIATE) ||
+		    opcode == OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE))
+			wc.opcode = IB_WC_RECV_RDMA_WITH_IMM;
+		else
+			wc.opcode = IB_WC_RECV;
+		wc.qp = &qp->ibqp;
+		wc.src_qp = qp->remote_qpn;
+		wc.slid = rdma_ah_get_dlid(&qp->remote_ah_attr) & U16_MAX;
+		/*
+		 * It seems that IB mandates the presence of an SL in a
+		 * work completion only for the UD transport (see section
+		 * 11.4.2 of IBTA Vol. 1).
+		 *
+		 * However, the way the SL is chosen below is consistent
+		 * with the way that IB/qib works and is trying avoid
+		 * introducing incompatibilities.
+		 *
+		 * See also OPA Vol. 1, section 9.7.6, and table 9-17.
+		 */
+		wc.sl = rdma_ah_get_sl(&qp->remote_ah_attr);
+		/* zero fields that are N/A */
+		wc.vendor_err = 0;
+		wc.pkey_index = 0;
+		wc.dlid_path_bits = 0;
+		wc.port_num = 0;
+		/* Signal completion event if the solicited bit is set. */
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
+		break;
+
+	case OP(RDMA_WRITE_ONLY):
+		copy_last = rvt_is_user_qp(qp);
+		fallthrough;
+	case OP(RDMA_WRITE_FIRST):
+	case OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE):
+		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_WRITE)))
+			goto nack_inv;
+		/* consume RWQE */
+		reth = &ohdr->u.rc.reth;
+		qp->r_len = be32_to_cpu(reth->length);
+		qp->r_rcv_len = 0;
+		qp->r_sge.sg_list = NULL;
+		if (qp->r_len != 0) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = get_ib_reth_vaddr(reth);
+			int ok;
+
+			/* Check rkey & NAK */
+			ok = rvt_rkey_ok(qp, &qp->r_sge.sge, qp->r_len, vaddr,
+					 rkey, IB_ACCESS_REMOTE_WRITE);
+			if (unlikely(!ok))
+				goto nack_acc;
+			qp->r_sge.num_sge = 1;
+		} else {
+			qp->r_sge.num_sge = 0;
+			qp->r_sge.sge.mr = NULL;
+			qp->r_sge.sge.vaddr = NULL;
+			qp->r_sge.sge.length = 0;
+			qp->r_sge.sge.sge_length = 0;
+		}
+		if (opcode == OP(RDMA_WRITE_FIRST))
+			goto send_middle;
+		else if (opcode == OP(RDMA_WRITE_ONLY))
+			goto no_immediate_data;
+		ret = rvt_get_rwqe(qp, true);
+		if (ret < 0)
+			goto nack_op_err;
+		if (!ret) {
+			/* peer will send again */
+			rvt_put_ss(&qp->r_sge);
+			goto rnr_nak;
+		}
+		wc.ex.imm_data = ohdr->u.rc.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		goto send_last;
+
+	case OP(RDMA_READ_REQUEST): {
+		struct rvt_ack_entry *e;
+		u32 len;
+		u8 next;
+
+		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_READ)))
+			goto nack_inv;
+		next = qp->r_head_ack_queue + 1;
+		/* s_ack_queue is size rvt_size_atomic()+1 so use > not >= */
+		if (next > rvt_size_atomic(ib_to_rvt(qp->ibqp.device)))
+			next = 0;
+		spin_lock_irqsave(&qp->s_lock, flags);
+		if (unlikely(next == qp->s_acked_ack_queue)) {
+			if (!qp->s_ack_queue[next].sent)
+				goto nack_inv_unlck;
+			update_ack_queue(qp, next);
+		}
+		e = &qp->s_ack_queue[qp->r_head_ack_queue];
+		release_rdma_sge_mr(e);
+		reth = &ohdr->u.rc.reth;
+		len = be32_to_cpu(reth->length);
+		if (len) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = get_ib_reth_vaddr(reth);
+			int ok;
+
+			/* Check rkey & NAK */
+			ok = rvt_rkey_ok(qp, &e->rdma_sge, len, vaddr,
+					 rkey, IB_ACCESS_REMOTE_READ);
+			if (unlikely(!ok))
+				goto nack_acc_unlck;
+			/*
+			 * Update the next expected PSN.  We add 1 later
+			 * below, so only add the remainder here.
+			 */
+			qp->r_psn += rvt_div_mtu(qp, len - 1);
+		} else {
+			e->rdma_sge.mr = NULL;
+			e->rdma_sge.vaddr = NULL;
+			e->rdma_sge.length = 0;
+			e->rdma_sge.sge_length = 0;
+		}
+		e->opcode = opcode;
+		e->sent = 0;
+		e->psn = psn;
+		e->lpsn = qp->r_psn;
+		/*
+		 * We need to increment the MSN here instead of when we
+		 * finish sending the result since a duplicate request would
+		 * increment it more than once.
+		 */
+		qp->r_msn++;
+		qp->r_psn++;
+		qp->r_state = opcode;
+		qp->r_nak_state = 0;
+		qp->r_head_ack_queue = next;
+		qpriv->r_tid_alloc = qp->r_head_ack_queue;
+
+		/* Schedule the send engine. */
+		qp->s_flags |= RVT_S_RESP_PENDING;
+		if (fecn)
+			qp->s_flags |= RVT_S_ECN;
+		hfi2_schedule_send(qp);
+
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		return;
+	}
+
+	case OP(COMPARE_SWAP):
+	case OP(FETCH_ADD): {
+		struct ib_atomic_eth *ateth = &ohdr->u.atomic_eth;
+		u64 vaddr = get_ib_ateth_vaddr(ateth);
+		bool opfn = opcode == OP(COMPARE_SWAP) &&
+			vaddr == HFI2_VERBS_E_ATOMIC_VADDR;
+		struct rvt_ack_entry *e;
+		atomic64_t *maddr;
+		u64 sdata;
+		u32 rkey;
+		u8 next;
+
+		if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+			     !opfn))
+			goto nack_inv;
+		next = qp->r_head_ack_queue + 1;
+		if (next > rvt_size_atomic(ib_to_rvt(qp->ibqp.device)))
+			next = 0;
+		spin_lock_irqsave(&qp->s_lock, flags);
+		if (unlikely(next == qp->s_acked_ack_queue)) {
+			if (!qp->s_ack_queue[next].sent)
+				goto nack_inv_unlck;
+			update_ack_queue(qp, next);
+		}
+		e = &qp->s_ack_queue[qp->r_head_ack_queue];
+		release_rdma_sge_mr(e);
+		/* Process OPFN special virtual address */
+		if (opfn) {
+			opfn_conn_response(qp, e, ateth);
+			goto ack;
+		}
+		if (unlikely(vaddr & (sizeof(u64) - 1)))
+			goto nack_inv_unlck;
+		rkey = be32_to_cpu(ateth->rkey);
+		/* Check rkey & NAK */
+		if (unlikely(!rvt_rkey_ok(qp, &qp->r_sge.sge, sizeof(u64),
+					  vaddr, rkey,
+					  IB_ACCESS_REMOTE_ATOMIC)))
+			goto nack_acc_unlck;
+		/* Perform atomic OP and save result. */
+		maddr = (atomic64_t *)qp->r_sge.sge.vaddr;
+		sdata = get_ib_ateth_swap(ateth);
+		e->atomic_data = (opcode == OP(FETCH_ADD)) ?
+			(u64)atomic64_add_return(sdata, maddr) - sdata :
+			(u64)cmpxchg((u64 *)qp->r_sge.sge.vaddr,
+				      get_ib_ateth_compare(ateth),
+				      sdata);
+		rvt_put_mr(qp->r_sge.sge.mr);
+		qp->r_sge.num_sge = 0;
+ack:
+		e->opcode = opcode;
+		e->sent = 0;
+		e->psn = psn;
+		e->lpsn = psn;
+		qp->r_msn++;
+		qp->r_psn++;
+		qp->r_state = opcode;
+		qp->r_nak_state = 0;
+		qp->r_head_ack_queue = next;
+		qpriv->r_tid_alloc = qp->r_head_ack_queue;
+
+		/* Schedule the send engine. */
+		qp->s_flags |= RVT_S_RESP_PENDING;
+		if (fecn)
+			qp->s_flags |= RVT_S_ECN;
+		hfi2_schedule_send(qp);
+
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+		return;
+	}
+
+	default:
+		/* NAK unknown opcodes. */
+		goto nack_inv;
+	}
+	qp->r_psn++;
+	qp->r_state = opcode;
+	qp->r_ack_psn = psn;
+	qp->r_nak_state = 0;
+	/* Send an ACK if requested or required. */
+	if (psn & IB_BTH_REQ_ACK || fecn) {
+		if (packet->numpkt == 0 || fecn ||
+		    qp->r_adefered >= HFI2_PSN_CREDIT) {
+			rc_cancel_ack(qp);
+			goto send_ack;
+		}
+		qp->r_adefered++;
+		rc_defered_ack(rcd, qp);
+	}
+	return;
+
+rnr_nak:
+	qp->r_nak_state = qp->r_min_rnr_timer | IB_RNR_NAK;
+	qp->r_ack_psn = qp->r_psn;
+	/* Queue RNR NAK for later */
+	rc_defered_ack(rcd, qp);
+	return;
+
+nack_op_err:
+	rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
+	qp->r_nak_state = IB_NAK_REMOTE_OPERATIONAL_ERROR;
+	qp->r_ack_psn = qp->r_psn;
+	/* Queue NAK for later */
+	rc_defered_ack(rcd, qp);
+	return;
+
+nack_inv_unlck:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+nack_inv:
+	rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
+	qp->r_nak_state = IB_NAK_INVALID_REQUEST;
+	qp->r_ack_psn = qp->r_psn;
+	/* Queue NAK for later */
+	rc_defered_ack(rcd, qp);
+	return;
+
+nack_acc_unlck:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+nack_acc:
+	rvt_rc_error(qp, IB_WC_LOC_PROT_ERR);
+	qp->r_nak_state = IB_NAK_REMOTE_ACCESS_ERROR;
+	qp->r_ack_psn = qp->r_psn;
+send_ack:
+	hfi2_send_rc_ack(packet, fecn);
+}
+
+void hfi2_rc_hdrerr(
+	struct hfi2_ctxtdata *rcd,
+	struct hfi2_packet *packet,
+	struct rvt_qp *qp)
+{
+	struct hfi2_ibport *ibp = rcd_to_iport(rcd);
+	int diff;
+	u32 opcode;
+	u32 psn;
+
+	if (hfi2_ruc_check_hdr(ibp, packet))
+		return;
+
+	psn = ib_bth_get_psn(packet->ohdr);
+	opcode = ib_bth_get_opcode(packet->ohdr);
+
+	/* Only deal with RDMA Writes for now */
+	if (opcode < IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST) {
+		diff = delta_psn(psn, qp->r_psn);
+		if (!qp->r_nak_state && diff >= 0) {
+			ibp->rvp.n_rc_seqnak++;
+			qp->r_nak_state = IB_NAK_PSN_ERROR;
+			/* Use the expected PSN. */
+			qp->r_ack_psn = qp->r_psn;
+			/*
+			 * Wait to send the sequence
+			 * NAK until all packets
+			 * in the receive queue have
+			 * been processed.
+			 * Otherwise, we end up
+			 * propagating congestion.
+			 */
+			rc_defered_ack(rcd, qp);
+		} /* Out of sequence NAK */
+	} /* QP Request NAKs */
+}
diff --git a/drivers/infiniband/hw/hfi2/ruc.c b/drivers/infiniband/hw/hfi2/ruc.c
new file mode 100644
index 000000000000..ad567a53b16b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ruc.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#include <linux/spinlock.h>
+
+#include "hfi2.h"
+#include "mad.h"
+#include "qp.h"
+#include "verbs_txreq.h"
+#include "trace.h"
+
+static int gid_ok(union ib_gid *gid, __be64 gid_prefix, __be64 id)
+{
+	return (gid->global.interface_id == id &&
+		(gid->global.subnet_prefix == gid_prefix ||
+		 gid->global.subnet_prefix == IB_DEFAULT_GID_PREFIX));
+}
+
+/*
+ *
+ * This should be called with the QP r_lock held.
+ *
+ * The s_lock will be acquired around the hfi2_migrate_qp() call.
+ */
+int hfi2_ruc_check_hdr(struct hfi2_ibport *ibp, struct hfi2_packet *packet)
+{
+	__be64 guid;
+	unsigned long flags;
+	struct rvt_qp *qp = packet->qp;
+	u8 sc5 = ibp->sl_to_sc[rdma_ah_get_sl(&qp->remote_ah_attr)];
+	u32 dlid = packet->dlid;
+	u32 slid = packet->slid;
+	u32 sl = packet->sl;
+	bool migrated = packet->migrated;
+	u16 pkey = packet->pkey;
+
+	if (qp->s_mig_state == IB_MIG_ARMED && migrated) {
+		if (!packet->grh) {
+			if ((rdma_ah_get_ah_flags(&qp->alt_ah_attr) &
+			     IB_AH_GRH) &&
+			    (packet->etype != RHF_RCV_TYPE_BYPASS))
+				return 1;
+		} else {
+			const struct ib_global_route *grh;
+
+			if (!(rdma_ah_get_ah_flags(&qp->alt_ah_attr) &
+			      IB_AH_GRH))
+				return 1;
+			grh = rdma_ah_read_grh(&qp->alt_ah_attr);
+			guid = get_sguid(ibp, grh->sgid_index);
+			if (!gid_ok(&packet->grh->dgid, ibp->rvp.gid_prefix,
+				    guid))
+				return 1;
+			if (!gid_ok(
+				&packet->grh->sgid,
+				grh->dgid.global.subnet_prefix,
+				grh->dgid.global.interface_id))
+				return 1;
+		}
+		if (unlikely(rcv_pkey_check(ppd_from_ibp(ibp), pkey,
+					    sc5, slid))) {
+			hfi2_bad_pkey(ibp, pkey, sl, 0, qp->ibqp.qp_num,
+				      slid, dlid);
+			return 1;
+		}
+		/* Validate the SLID. See Ch. 9.6.1.5 and 17.2.8 */
+		if (slid != rdma_ah_get_dlid(&qp->alt_ah_attr) ||
+		    ppd_from_ibp(ibp)->port !=
+			rdma_ah_get_port_num(&qp->alt_ah_attr))
+			return 1;
+		spin_lock_irqsave(&qp->s_lock, flags);
+		hfi2_migrate_qp(qp);
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+	} else {
+		if (!packet->grh) {
+			if ((rdma_ah_get_ah_flags(&qp->remote_ah_attr) &
+			     IB_AH_GRH) &&
+			    (packet->etype != RHF_RCV_TYPE_BYPASS))
+				return 1;
+		} else {
+			const struct ib_global_route *grh;
+
+			if (!(rdma_ah_get_ah_flags(&qp->remote_ah_attr) &
+						   IB_AH_GRH))
+				return 1;
+			grh = rdma_ah_read_grh(&qp->remote_ah_attr);
+			guid = get_sguid(ibp, grh->sgid_index);
+			if (!gid_ok(&packet->grh->dgid, ibp->rvp.gid_prefix,
+				    guid))
+				return 1;
+			if (!gid_ok(
+			     &packet->grh->sgid,
+			     grh->dgid.global.subnet_prefix,
+			     grh->dgid.global.interface_id))
+				return 1;
+		}
+		if (unlikely(rcv_pkey_check(ppd_from_ibp(ibp), pkey,
+					    sc5, slid))) {
+			hfi2_bad_pkey(ibp, pkey, sl, 0, qp->ibqp.qp_num,
+				      slid, dlid);
+			return 1;
+		}
+		/* Validate the SLID. See Ch. 9.6.1.5 */
+		if ((slid != rdma_ah_get_dlid(&qp->remote_ah_attr)) ||
+		    ppd_from_ibp(ibp)->port != qp->port_num)
+			return 1;
+		if (qp->s_mig_state == IB_MIG_REARM && !migrated)
+			qp->s_mig_state = IB_MIG_ARMED;
+	}
+
+	return 0;
+}
+
+/**
+ * hfi2_make_grh - construct a GRH header
+ * @ibp: a pointer to the IB port
+ * @hdr: a pointer to the GRH header being constructed
+ * @grh: the global route address to send to
+ * @hwords: size of header after grh being sent in dwords
+ * @nwords: the number of 32 bit words of data being sent
+ *
+ * Return the size of the header in 32 bit words.
+ */
+u32 hfi2_make_grh(struct hfi2_ibport *ibp, struct ib_grh *hdr,
+		  const struct ib_global_route *grh, u32 hwords, u32 nwords)
+{
+	hdr->version_tclass_flow =
+		cpu_to_be32((IB_GRH_VERSION << IB_GRH_VERSION_SHIFT) |
+			    (grh->traffic_class << IB_GRH_TCLASS_SHIFT) |
+			    (grh->flow_label << IB_GRH_FLOW_SHIFT));
+	hdr->paylen = cpu_to_be16((hwords + nwords) << 2);
+	/* next_hdr is defined by C8-7 in ch. 8.4.1 */
+	hdr->next_hdr = IB_GRH_NEXT_HDR;
+	hdr->hop_limit = grh->hop_limit;
+	/* The SGID is 32-bit aligned. */
+	hdr->sgid.global.subnet_prefix = ibp->rvp.gid_prefix;
+	hdr->sgid.global.interface_id =
+		grh->sgid_index < HFI2_GUIDS_PER_PORT ?
+		get_sguid(ibp, grh->sgid_index) :
+		get_sguid(ibp, HFI2_PORT_GUID_INDEX);
+	hdr->dgid = grh->dgid;
+
+	/* GRH header size in 32-bit words. */
+	return sizeof(struct ib_grh) / sizeof(u32);
+}
+
+#define BTH2_OFFSET (offsetof(struct hfi2_sdma_header, \
+			      hdr.ibh.u.oth.bth[2]) / 4)
+
+/**
+ * build_ahg - create ahg in s_ahg
+ * @qp: a pointer to QP
+ * @npsn: the next PSN for the request/response
+ *
+ * This routine handles the AHG by allocating an ahg entry and causing the
+ * copy of the first middle.
+ *
+ * Subsequent middles use the copied entry, editing the
+ * PSN with 1 or 2 edits.
+ */
+static inline void build_ahg(struct rvt_qp *qp, u32 npsn)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (unlikely(qp->s_flags & HFI2_S_AHG_CLEAR))
+		clear_ahg(qp);
+	if (!(qp->s_flags & HFI2_S_AHG_VALID)) {
+		/* first middle that needs copy  */
+		if (qp->s_ahgidx < 0)
+			qp->s_ahgidx = sdma_ahg_alloc(priv->s_sde);
+		if (qp->s_ahgidx >= 0) {
+			qp->s_ahgpsn = npsn;
+			priv->s_ahg->tx_flags |= SDMA_TXREQ_F_AHG_COPY;
+			/* save to protect a change in another thread */
+			priv->s_ahg->ahgidx = qp->s_ahgidx;
+			qp->s_flags |= HFI2_S_AHG_VALID;
+		}
+	} else {
+		/* subsequent middle after valid */
+		if (qp->s_ahgidx >= 0) {
+			priv->s_ahg->tx_flags |= SDMA_TXREQ_F_USE_AHG;
+			priv->s_ahg->ahgidx = qp->s_ahgidx;
+			priv->s_ahg->ahgcount++;
+			priv->s_ahg->ahgdesc[0] =
+				sdma_build_ahg_descriptor(
+					(__force u16)cpu_to_be16((u16)npsn),
+					BTH2_OFFSET,
+					16,
+					16);
+			if ((npsn & 0xffff0000) !=
+					(qp->s_ahgpsn & 0xffff0000)) {
+				priv->s_ahg->ahgcount++;
+				priv->s_ahg->ahgdesc[1] =
+					sdma_build_ahg_descriptor(
+						(__force u16)cpu_to_be16(
+							(u16)(npsn >> 16)),
+						BTH2_OFFSET,
+						0,
+						16);
+			}
+		}
+	}
+}
+
+static inline void hfi2_make_ruc_bth(struct rvt_qp *qp,
+				     struct ib_other_headers *ohdr,
+				     u32 bth0, u32 bth1, u32 bth2)
+{
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(bth1);
+	ohdr->bth[2] = cpu_to_be32(bth2);
+}
+
+/**
+ * hfi2_make_ruc_header_16B - build a 16B header
+ * @qp: the queue pair
+ * @ohdr: a pointer to the destination header memory
+ * @bth0: bth0 passed in from the RC/UC builder
+ * @bth1: bth1 passed in from the RC/UC builder
+ * @bth2: bth2 passed in from the RC/UC builder
+ * @middle: non zero implies indicates ahg "could" be used
+ * @ps: the current packet state
+ *
+ * This routine may disarm ahg under these situations:
+ * - packet needs a GRH
+ * - BECN needed
+ * - migration state not IB_MIG_MIGRATED
+ */
+static inline void hfi2_make_ruc_header_16B(struct rvt_qp *qp,
+					    struct ib_other_headers *ohdr,
+					    u32 bth0, u32 bth1, u32 bth2,
+					    int middle,
+					    struct hfi2_pkt_state *ps)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ibport *ibp = ps->ibp;
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	u32 slid;
+	u16 pkey = hfi2_get_pkey(ibp, qp->s_pkey_index);
+	u8 l4 = OPA_16B_L4_IB_LOCAL;
+	u8 extra_bytes;
+	u32 nwords;
+	bool becn = false;
+
+	if (ppd->dd->params->chip_type == CHIP_WFR) {
+		extra_bytes = hfi2_get_16b_padding((ps->s_txreq->hdr_dwords << 2),
+						   ps->s_txreq->s_cur_size);
+		nwords = SIZE_OF_CRC + ((ps->s_txreq->s_cur_size +
+				extra_bytes + SIZE_OF_LT) >> 2);
+	} else {
+		/* round up to multiple of 8 */
+		extra_bytes = hfi2_pad8((ps->s_txreq->hdr_dwords << 2) +
+					ps->s_txreq->s_cur_size);
+		/* add in ICRC QW */
+		nwords = (ps->s_txreq->s_cur_size + extra_bytes + 8) >> 2;
+	}
+
+	if (unlikely(rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH) &&
+	    hfi2_check_mcast(rdma_ah_get_dlid(&qp->remote_ah_attr))) {
+		struct ib_grh *grh;
+		struct ib_global_route *grd =
+			rdma_ah_retrieve_grh(&qp->remote_ah_attr);
+		/*
+		 * Ensure OPA GIDs are transformed to IB gids
+		 * before creating the GRH.
+		 */
+		if (grd->sgid_index == OPA_GID_INDEX)
+			grd->sgid_index = 0;
+		grh = &ps->s_txreq->phdr.hdr.opah.u.l.grh;
+		l4 = OPA_16B_L4_IB_GLOBAL;
+		ps->s_txreq->hdr_dwords +=
+			hfi2_make_grh(ibp, grh, grd,
+				      ps->s_txreq->hdr_dwords - LRH_16B_DWORDS,
+				      nwords);
+		middle = 0;
+	}
+
+	if (qp->s_mig_state == IB_MIG_MIGRATED)
+		bth1 |= OPA_BTH_MIG_REQ;
+	else
+		middle = 0;
+
+	if (qp->s_flags & RVT_S_ECN) {
+		qp->s_flags &= ~RVT_S_ECN;
+		/* we recently received a FECN, so return a BECN */
+		becn = true;
+		middle = 0;
+	}
+	if (middle)
+		build_ahg(qp, bth2);
+	else
+		qp->s_flags &= ~HFI2_S_AHG_VALID;
+
+	bth0 |= pkey;
+	bth0 |= extra_bytes << 20;
+	hfi2_make_ruc_bth(qp, ohdr, bth0, bth1, bth2);
+
+	if (!ppd->lid)
+		slid = be32_to_cpu(OPA_LID_PERMISSIVE);
+	else
+		slid = ppd->lid |
+			(rdma_ah_get_path_bits(&qp->remote_ah_attr) &
+			((1 << ppd->lmc) - 1));
+
+	hfi2_make_16b_hdr(&ps->s_txreq->phdr.hdr.opah,
+			  slid,
+			  opa_get_lid(rdma_ah_get_dlid(&qp->remote_ah_attr),
+				      16B),
+			  (ps->s_txreq->hdr_dwords + nwords) >> 1,
+			  pkey, becn, 0, l4, priv->s_sc);
+}
+
+/**
+ * hfi2_make_ruc_header_9B - build a 9B header
+ * @qp: the queue pair
+ * @ohdr: a pointer to the destination header memory
+ * @bth0: bth0 passed in from the RC/UC builder
+ * @bth1: bth1 passed in from the RC/UC builder
+ * @bth2: bth2 passed in from the RC/UC builder
+ * @middle: non zero implies indicates ahg "could" be used
+ * @ps: the current packet state
+ *
+ * This routine may disarm ahg under these situations:
+ * - packet needs a GRH
+ * - BECN needed
+ * - migration state not IB_MIG_MIGRATED
+ */
+static inline void hfi2_make_ruc_header_9B(struct rvt_qp *qp,
+					   struct ib_other_headers *ohdr,
+					   u32 bth0, u32 bth1, u32 bth2,
+					   int middle,
+					   struct hfi2_pkt_state *ps)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ibport *ibp = ps->ibp;
+	u16 pkey = hfi2_get_pkey(ibp, qp->s_pkey_index);
+	u16 lrh0 = HFI2_LRH_BTH;
+	u8 extra_bytes = -ps->s_txreq->s_cur_size & 3;
+	u32 nwords = SIZE_OF_CRC + ((ps->s_txreq->s_cur_size +
+					 extra_bytes) >> 2);
+
+	if (unlikely(rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH)) {
+		struct ib_grh *grh = &ps->s_txreq->phdr.hdr.ibh.u.l.grh;
+
+		lrh0 = HFI2_LRH_GRH;
+		ps->s_txreq->hdr_dwords +=
+			hfi2_make_grh(ibp, grh,
+				      rdma_ah_read_grh(&qp->remote_ah_attr),
+				      ps->s_txreq->hdr_dwords - LRH_9B_DWORDS,
+				      nwords);
+		middle = 0;
+	}
+	lrh0 |= (priv->s_sc & 0xf) << 12 |
+		(rdma_ah_get_sl(&qp->remote_ah_attr) & 0xf) << 4;
+
+	if (qp->s_mig_state == IB_MIG_MIGRATED)
+		bth0 |= IB_BTH_MIG_REQ;
+	else
+		middle = 0;
+
+	if (qp->s_flags & RVT_S_ECN) {
+		qp->s_flags &= ~RVT_S_ECN;
+		/* we recently received a FECN, so return a BECN */
+		bth1 |= (IB_BECN_MASK << IB_BECN_SHIFT);
+		middle = 0;
+	}
+	if (middle)
+		build_ahg(qp, bth2);
+	else
+		qp->s_flags &= ~HFI2_S_AHG_VALID;
+
+	bth0 |= pkey;
+	bth0 |= extra_bytes << 20;
+	hfi2_make_ruc_bth(qp, ohdr, bth0, bth1, bth2);
+	hfi2_make_ib_hdr(&ps->s_txreq->phdr.hdr.ibh,
+			 lrh0,
+			 ps->s_txreq->hdr_dwords + nwords,
+			 opa_get_lid(rdma_ah_get_dlid(&qp->remote_ah_attr), 9B),
+			 ppd_from_ibp(ibp)->lid |
+				rdma_ah_get_path_bits(&qp->remote_ah_attr));
+}
+
+typedef void (*hfi2_make_ruc_hdr)(struct rvt_qp *qp,
+				  struct ib_other_headers *ohdr,
+				  u32 bth0, u32 bth1, u32 bth2, int middle,
+				  struct hfi2_pkt_state *ps);
+
+/* We support only two types - 9B and 16B for now */
+static const hfi2_make_ruc_hdr hfi2_ruc_header_tbl[2] = {
+	[HFI2_PKT_TYPE_9B] = &hfi2_make_ruc_header_9B,
+	[HFI2_PKT_TYPE_16B] = &hfi2_make_ruc_header_16B
+};
+
+void hfi2_make_ruc_header(struct rvt_qp *qp, struct ib_other_headers *ohdr,
+			  u32 bth0, u32 bth1, u32 bth2, int middle,
+			  struct hfi2_pkt_state *ps)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	/*
+	 * reset s_ahg/AHG fields
+	 *
+	 * This insures that the ahgentry/ahgcount
+	 * are at a non-AHG default to protect
+	 * build_verbs_tx_desc() from using
+	 * an include ahgidx.
+	 *
+	 * build_ahg() will modify as appropriate
+	 * to use the AHG feature.
+	 */
+	priv->s_ahg->tx_flags = 0;
+	priv->s_ahg->ahgcount = 0;
+	priv->s_ahg->ahgidx = 0;
+
+	/* Make the appropriate header */
+	hfi2_ruc_header_tbl[priv->hdr_type](qp, ohdr, bth0, bth1, bth2, middle,
+					    ps);
+}
+
+/* when sending, force a reschedule every one of these periods */
+#define SEND_RESCHED_TIMEOUT (5 * HZ)  /* 5s in jiffies */
+
+/**
+ * hfi2_schedule_send_yield - test for a yield required for QP
+ * send engine
+ * @qp: a pointer to QP
+ * @ps: a pointer to a structure with commonly lookup values for
+ *      the send engine progress
+ * @tid: true if it is the tid leg
+ *
+ * This routine checks if the time slice for the QP has expired
+ * for RC QPs, if so an additional work entry is queued. At this
+ * point, other QPs have an opportunity to be scheduled. It
+ * returns true if a yield is required, otherwise, false
+ * is returned.
+ */
+bool hfi2_schedule_send_yield(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			      bool tid)
+{
+	ps->pkts_sent = true;
+
+	if (unlikely(time_after(jiffies, ps->timeout))) {
+		if (!ps->in_thread ||
+		    workqueue_congested(ps->cpu, ps->ppd->dd->hfi2_wq)) {
+			spin_lock_irqsave(&qp->s_lock, ps->flags);
+			if (!tid) {
+				qp->s_flags &= ~RVT_S_BUSY;
+				hfi2_schedule_send(qp);
+			} else {
+				struct hfi2_qp_priv *priv = qp->priv;
+
+				if (priv->s_flags &
+				    HFI2_S_TID_BUSY_SET) {
+					qp->s_flags &= ~RVT_S_BUSY;
+					priv->s_flags &=
+						~(HFI2_S_TID_BUSY_SET |
+						  RVT_S_BUSY);
+				} else {
+					priv->s_flags &= ~RVT_S_BUSY;
+				}
+				hfi2_schedule_tid_send(qp);
+			}
+
+			spin_unlock_irqrestore(&qp->s_lock, ps->flags);
+			this_cpu_inc(*ps->ppd->dd->send_schedule);
+			trace_hfi2_rc_expired_time_slice(qp, true);
+			return true;
+		}
+
+		cond_resched();
+		this_cpu_inc(*ps->ppd->dd->send_schedule);
+		ps->timeout = jiffies + ps->timeout_int;
+	}
+
+	trace_hfi2_rc_expired_time_slice(qp, false);
+	return false;
+}
+
+void hfi2_do_send_from_rvt(struct rvt_qp *qp)
+{
+	hfi2_do_send(qp, false);
+}
+
+void _hfi2_do_send(struct work_struct *work)
+{
+	struct iowait_work *w = container_of(work, struct iowait_work, iowork);
+	struct rvt_qp *qp = iowait_to_qp(w->iow);
+
+	hfi2_do_send(qp, true);
+}
+
+/**
+ * hfi2_do_send - perform a send on a QP
+ * @qp: a pointer to the QP
+ * @in_thread: true if in a workqueue thread
+ *
+ * Process entries in the send work queue until credit or queue is
+ * exhausted.  Only allow one CPU to send a packet per QP.
+ * Otherwise, two threads could send packets out of order.
+ */
+void hfi2_do_send(struct rvt_qp *qp, bool in_thread)
+{
+	struct hfi2_pkt_state ps;
+	struct hfi2_qp_priv *priv = qp->priv;
+	int (*make_req)(struct rvt_qp *qp, struct hfi2_pkt_state *ps);
+
+	ps.dev = to_idev(qp->ibqp.device);
+	ps.ibp = to_iport(qp->ibqp.device, qp->port_num);
+	ps.ppd = ppd_from_ibp(ps.ibp);
+	/* complete with error any sends that arrive on an unavailable port */
+	if (!port_available_ppd(ps.ppd)) {
+		struct rvt_swqe *wqe;
+
+		if (qp->s_last != READ_ONCE(qp->s_head)) {
+			wqe = rvt_get_swqe_ptr(qp, qp->s_last);
+			rvt_send_complete(qp, wqe, IB_WC_GENERAL_ERR);
+		}
+		return;
+	}
+	ps.in_thread = in_thread;
+	ps.wait = iowait_get_ib_work(&priv->s_iowait);
+
+	trace_hfi2_rc_do_send(qp, in_thread);
+
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_RC:
+		if (!loopback && ((rdma_ah_get_dlid(&qp->remote_ah_attr) &
+				   ~((1 << ps.ppd->lmc) - 1)) ==
+				  ps.ppd->lid)) {
+			rvt_ruc_loopback(qp);
+			return;
+		}
+		make_req = hfi2_make_rc_req;
+		ps.timeout_int = qp->timeout_jiffies;
+		break;
+	case IB_QPT_UC:
+		if (!loopback && ((rdma_ah_get_dlid(&qp->remote_ah_attr) &
+				   ~((1 << ps.ppd->lmc) - 1)) ==
+				  ps.ppd->lid)) {
+			rvt_ruc_loopback(qp);
+			return;
+		}
+		make_req = hfi2_make_uc_req;
+		ps.timeout_int = SEND_RESCHED_TIMEOUT;
+		break;
+	default:
+		make_req = hfi2_make_ud_req;
+		ps.timeout_int = SEND_RESCHED_TIMEOUT;
+	}
+
+	spin_lock_irqsave(&qp->s_lock, ps.flags);
+
+	/* Return if we are already busy processing a work request. */
+	if (!hfi2_send_ok(qp)) {
+		if (qp->s_flags & HFI2_S_ANY_WAIT_IO)
+			iowait_set_flag(&priv->s_iowait, IOWAIT_PENDING_IB);
+		spin_unlock_irqrestore(&qp->s_lock, ps.flags);
+		return;
+	}
+
+	qp->s_flags |= RVT_S_BUSY;
+
+	ps.timeout_int = ps.timeout_int / 8;
+	ps.timeout = jiffies + ps.timeout_int;
+	ps.cpu = priv->s_sde ? priv->s_sde->cpu :
+			cpumask_first(cpumask_of_node(ps.ppd->dd->node));
+	ps.pkts_sent = false;
+
+	/* insure a pre-built packet is handled  */
+	ps.s_txreq = get_waiting_verbs_txreq(ps.wait);
+	do {
+		/* Check for a constructed packet to be sent. */
+		if (ps.s_txreq) {
+			if (priv->s_flags & HFI2_S_TID_BUSY_SET)
+				qp->s_flags |= RVT_S_BUSY;
+			spin_unlock_irqrestore(&qp->s_lock, ps.flags);
+			/*
+			 * If the packet cannot be sent now, return and
+			 * the send engine will be woken up later.
+			 */
+			if (hfi2_verbs_send(qp, &ps))
+				return;
+
+			/* allow other tasks to run */
+			if (hfi2_schedule_send_yield(qp, &ps, false))
+				return;
+
+			spin_lock_irqsave(&qp->s_lock, ps.flags);
+		}
+	} while (make_req(qp, &ps));
+	iowait_starve_clear(ps.pkts_sent, &priv->s_iowait);
+	spin_unlock_irqrestore(&qp->s_lock, ps.flags);
+}
diff --git a/drivers/infiniband/hw/hfi2/tid_rdma.c b/drivers/infiniband/hw/hfi2/tid_rdma.c
new file mode 100644
index 000000000000..d9317cb99c03
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/tid_rdma.c
@@ -0,0 +1,5538 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2018 - 2020 Intel Corporation.
+ *
+ */
+
+#include "hfi2.h"
+#include "qp.h"
+#include "rc.h"
+#include "verbs.h"
+#include "tid_rdma.h"
+#include "exp_rcv.h"
+#include "trace.h"
+
+/**
+ * DOC: TID RDMA READ protocol
+ *
+ * This is an end-to-end protocol at the hfi2 level between two nodes that
+ * improves performance by avoiding data copy on the requester side. It
+ * converts a qualified RDMA READ request into a TID RDMA READ request on
+ * the requester side and thereafter handles the request and response
+ * differently. To be qualified, the RDMA READ request should meet the
+ * following:
+ * -- The total data length should be greater than 256K;
+ * -- The total data length should be a multiple of 4K page size;
+ * -- Each local scatter-gather entry should be 4K page aligned;
+ * -- Each local scatter-gather entry should be a multiple of 4K page size;
+ */
+
+#define RCV_TID_FLOW_TABLE_CTRL_FLOW_VALID_SMASK BIT_ULL(32)
+#define RCV_TID_FLOW_TABLE_CTRL_HDR_SUPP_EN_SMASK BIT_ULL(33)
+#define RCV_TID_FLOW_TABLE_CTRL_KEEP_AFTER_SEQ_ERR_SMASK BIT_ULL(34)
+#define RCV_TID_FLOW_TABLE_CTRL_KEEP_ON_GEN_ERR_SMASK BIT_ULL(35)
+#define RCV_TID_FLOW_TABLE_STATUS_SEQ_MISMATCH_SMASK BIT_ULL(37)
+#define RCV_TID_FLOW_TABLE_STATUS_GEN_MISMATCH_SMASK BIT_ULL(38)
+
+/* Maximum number of packets within a flow generation. */
+#define MAX_TID_FLOW_PSN BIT(HFI2_KDETH_BTH_SEQ_SHIFT)
+
+#define GENERATION_MASK 0xFFFFF
+
+static u32 mask_generation(u32 a)
+{
+	return a & GENERATION_MASK;
+}
+
+/* Reserved generation value to set to unused flows for kernel contexts */
+#define KERN_GENERATION_RESERVED mask_generation(U32_MAX)
+
+/*
+ * J_KEY for kernel contexts when TID RDMA is used.
+ * See generate_jkey() in hfi2.h for more information.
+ */
+#define TID_RDMA_JKEY                   32
+#define HFI2_KERNEL_MIN_JKEY HFI2_ADMIN_JKEY_RANGE
+#define HFI2_KERNEL_MAX_JKEY (2 * HFI2_ADMIN_JKEY_RANGE - 1)
+
+/* Maximum number of segments in flight per QP request. */
+#define TID_RDMA_MAX_READ_SEGS_PER_REQ  6
+#define TID_RDMA_MAX_WRITE_SEGS_PER_REQ 4
+#define MAX_REQ max_t(u16, TID_RDMA_MAX_READ_SEGS_PER_REQ, \
+			TID_RDMA_MAX_WRITE_SEGS_PER_REQ)
+#define MAX_FLOWS roundup_pow_of_two(MAX_REQ + 1)
+
+#define MAX_EXPECTED_PAGES     (MAX_EXPECTED_BUFFER / PAGE_SIZE)
+
+#define TID_RDMA_DESTQP_FLOW_SHIFT      11
+#define TID_RDMA_DESTQP_FLOW_MASK       0x1f
+
+#define TID_OPFN_QP_CTXT_MASK 0xff
+#define TID_OPFN_QP_CTXT_SHIFT 56
+#define TID_OPFN_QP_KDETH_MASK 0xff
+#define TID_OPFN_QP_KDETH_SHIFT 48
+#define TID_OPFN_MAX_LEN_MASK 0x7ff
+#define TID_OPFN_MAX_LEN_SHIFT 37
+#define TID_OPFN_TIMEOUT_MASK 0x1f
+#define TID_OPFN_TIMEOUT_SHIFT 32
+#define TID_OPFN_RESERVED_MASK 0x3f
+#define TID_OPFN_RESERVED_SHIFT 26
+#define TID_OPFN_URG_MASK 0x1
+#define TID_OPFN_URG_SHIFT 25
+#define TID_OPFN_VER_MASK 0x7
+#define TID_OPFN_VER_SHIFT 22
+#define TID_OPFN_JKEY_MASK 0x3f
+#define TID_OPFN_JKEY_SHIFT 16
+#define TID_OPFN_MAX_READ_MASK 0x3f
+#define TID_OPFN_MAX_READ_SHIFT 10
+#define TID_OPFN_MAX_WRITE_MASK 0x3f
+#define TID_OPFN_MAX_WRITE_SHIFT 4
+
+/*
+ * OPFN TID layout
+ *
+ * 63               47               31               15
+ * NNNNNNNNKKKKKKKK MMMMMMMMMMMTTTTT DDDDDDUVVVJJJJJJ RRRRRRWWWWWWCCCC
+ * 3210987654321098 7654321098765432 1098765432109876 5432109876543210
+ * N - the context Number
+ * K - the Kdeth_qp
+ * M - Max_len
+ * T - Timeout
+ * D - reserveD
+ * V - version
+ * U - Urg capable
+ * J - Jkey
+ * R - max_Read
+ * W - max_Write
+ * C - Capcode
+ */
+
+static void tid_rdma_trigger_resume(struct work_struct *work);
+static void hfi2_kern_exp_rcv_free_flows(struct tid_rdma_request *req);
+static int hfi2_kern_exp_rcv_alloc_flows(struct tid_rdma_request *req,
+					 gfp_t gfp);
+static void hfi2_init_trdma_req(struct rvt_qp *qp,
+				struct tid_rdma_request *req);
+static void hfi2_tid_write_alloc_resources(struct rvt_qp *qp, bool intr_ctx);
+static void hfi2_tid_timeout(struct timer_list *t);
+static void hfi2_add_tid_reap_timer(struct rvt_qp *qp);
+static void hfi2_mod_tid_reap_timer(struct rvt_qp *qp);
+static void hfi2_mod_tid_retry_timer(struct rvt_qp *qp);
+static int hfi2_stop_tid_retry_timer(struct rvt_qp *qp);
+static void hfi2_tid_retry_timeout(struct timer_list *t);
+static int make_tid_rdma_ack(struct rvt_qp *qp,
+			     struct ib_other_headers *ohdr,
+			     struct hfi2_pkt_state *ps);
+static void hfi2_do_tid_send(struct rvt_qp *qp);
+static u32 read_r_next_psn(struct hfi2_devdata *dd, u16 ctxt, u8 fidx);
+static void tid_rdma_rcv_err(struct hfi2_packet *packet,
+			     struct ib_other_headers *ohdr,
+			     struct rvt_qp *qp, u32 psn, int diff, bool fecn);
+static void update_r_next_psn_fecn(struct hfi2_packet *packet,
+				   struct hfi2_qp_priv *priv,
+				   struct hfi2_ctxtdata *rcd,
+				   struct tid_rdma_flow *flow,
+				   bool fecn);
+
+static void validate_r_tid_ack(struct hfi2_qp_priv *priv)
+{
+	if (priv->r_tid_ack == HFI2_QP_WQE_INVALID)
+		priv->r_tid_ack = priv->r_tid_tail;
+}
+
+static void tid_rdma_schedule_ack(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	priv->s_flags |= RVT_S_ACK_PENDING;
+	hfi2_schedule_tid_send(qp);
+}
+
+static void tid_rdma_trigger_ack(struct rvt_qp *qp)
+{
+	validate_r_tid_ack(qp->priv);
+	tid_rdma_schedule_ack(qp);
+}
+
+static u64 tid_rdma_opfn_encode(struct tid_rdma_params *p)
+{
+	return
+		(((u64)p->qp & TID_OPFN_QP_CTXT_MASK) <<
+			TID_OPFN_QP_CTXT_SHIFT) |
+		((((u64)p->qp >> 16) & TID_OPFN_QP_KDETH_MASK) <<
+			TID_OPFN_QP_KDETH_SHIFT) |
+		(((u64)((p->max_len >> PAGE_SHIFT) - 1) &
+			TID_OPFN_MAX_LEN_MASK) << TID_OPFN_MAX_LEN_SHIFT) |
+		(((u64)p->timeout & TID_OPFN_TIMEOUT_MASK) <<
+			TID_OPFN_TIMEOUT_SHIFT) |
+		(((u64)p->urg & TID_OPFN_URG_MASK) << TID_OPFN_URG_SHIFT) |
+		(((u64)p->jkey & TID_OPFN_JKEY_MASK) << TID_OPFN_JKEY_SHIFT) |
+		(((u64)p->max_read & TID_OPFN_MAX_READ_MASK) <<
+			TID_OPFN_MAX_READ_SHIFT) |
+		(((u64)p->max_write & TID_OPFN_MAX_WRITE_MASK) <<
+			TID_OPFN_MAX_WRITE_SHIFT);
+}
+
+static void tid_rdma_opfn_decode(struct tid_rdma_params *p, u64 data)
+{
+	p->max_len = (((data >> TID_OPFN_MAX_LEN_SHIFT) &
+		TID_OPFN_MAX_LEN_MASK) + 1) << PAGE_SHIFT;
+	p->jkey = (data >> TID_OPFN_JKEY_SHIFT) & TID_OPFN_JKEY_MASK;
+	p->max_write = (data >> TID_OPFN_MAX_WRITE_SHIFT) &
+		TID_OPFN_MAX_WRITE_MASK;
+	p->max_read = (data >> TID_OPFN_MAX_READ_SHIFT) &
+		TID_OPFN_MAX_READ_MASK;
+	p->qp =
+		((((data >> TID_OPFN_QP_KDETH_SHIFT) & TID_OPFN_QP_KDETH_MASK)
+			<< 16) |
+		((data >> TID_OPFN_QP_CTXT_SHIFT) & TID_OPFN_QP_CTXT_MASK));
+	p->urg = (data >> TID_OPFN_URG_SHIFT) & TID_OPFN_URG_MASK;
+	p->timeout = (data >> TID_OPFN_TIMEOUT_SHIFT) & TID_OPFN_TIMEOUT_MASK;
+}
+
+void tid_rdma_opfn_init(struct rvt_qp *qp, struct tid_rdma_params *p)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	p->qp = (RVT_KDETH_QP_PREFIX << 16) | priv->rcd->ctxt;
+	p->max_len = TID_RDMA_MAX_SEGMENT_SIZE;
+	p->jkey = priv->rcd->jkey;
+	p->max_read = TID_RDMA_MAX_READ_SEGS_PER_REQ;
+	p->max_write = TID_RDMA_MAX_WRITE_SEGS_PER_REQ;
+	p->timeout = qp->timeout;
+	p->urg = is_urg_masked(priv->rcd);
+}
+
+bool tid_rdma_conn_req(struct rvt_qp *qp, u64 *data)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	*data = tid_rdma_opfn_encode(&priv->tid_rdma.local);
+	return true;
+}
+
+bool tid_rdma_conn_reply(struct rvt_qp *qp, u64 data)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct tid_rdma_params *remote, *old;
+	bool ret = true;
+
+	old = rcu_dereference_protected(priv->tid_rdma.remote,
+					lockdep_is_held(&priv->opfn.lock));
+	data &= ~0xfULL;
+	/*
+	 * If data passed in is zero, return true so as not to continue the
+	 * negotiation process
+	 */
+	if (!data || !HFI2_CAP_IS_KSET(TID_RDMA))
+		goto null;
+	/*
+	 * If kzalloc fails, return false. This will result in:
+	 * * at the requester a new OPFN request being generated to retry
+	 *   the negotiation
+	 * * at the responder, 0 being returned to the requester so as to
+	 *   disable TID RDMA at both the requester and the responder
+	 */
+	remote = kzalloc(sizeof(*remote), GFP_ATOMIC);
+	if (!remote) {
+		ret = false;
+		goto null;
+	}
+
+	tid_rdma_opfn_decode(remote, data);
+	priv->tid_timer_timeout_jiffies =
+		usecs_to_jiffies((((4096UL * (1UL << remote->timeout)) /
+				   1000UL) << 3) * 7);
+	trace_hfi2_opfn_param(qp, 0, &priv->tid_rdma.local);
+	trace_hfi2_opfn_param(qp, 1, remote);
+	rcu_assign_pointer(priv->tid_rdma.remote, remote);
+	/*
+	 * A TID RDMA READ request's segment size is not equal to
+	 * remote->max_len only when the request's data length is smaller
+	 * than remote->max_len. In that case, there will be only one segment.
+	 * Therefore, when priv->pkts_ps is used to calculate req->cur_seg
+	 * during retry, it will lead to req->cur_seg = 0, which is exactly
+	 * what is expected.
+	 */
+	priv->pkts_ps = (u16)rvt_div_mtu(qp, remote->max_len);
+	priv->timeout_shift = ilog2(priv->pkts_ps - 1) + 1;
+	goto free;
+null:
+	RCU_INIT_POINTER(priv->tid_rdma.remote, NULL);
+	priv->timeout_shift = 0;
+free:
+	if (old)
+		kfree_rcu(old, rcu_head);
+	return ret;
+}
+
+bool tid_rdma_conn_resp(struct rvt_qp *qp, u64 *data)
+{
+	bool ret;
+
+	ret = tid_rdma_conn_reply(qp, *data);
+	*data = 0;
+	/*
+	 * If tid_rdma_conn_reply() returns error, set *data as 0 to indicate
+	 * TID RDMA could not be enabled. This will result in TID RDMA being
+	 * disabled at the requester too.
+	 */
+	if (ret)
+		(void)tid_rdma_conn_req(qp, data);
+	return ret;
+}
+
+void tid_rdma_conn_error(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct tid_rdma_params *old;
+
+	old = rcu_dereference_protected(priv->tid_rdma.remote,
+					lockdep_is_held(&priv->opfn.lock));
+	RCU_INIT_POINTER(priv->tid_rdma.remote, NULL);
+	if (old)
+		kfree_rcu(old, rcu_head);
+}
+
+/* This is called at context initialization time */
+int hfi2_kern_exp_rcv_init(struct hfi2_ctxtdata *rcd, int reinit)
+{
+	if (reinit)
+		return 0;
+
+	BUILD_BUG_ON(TID_RDMA_JKEY < HFI2_KERNEL_MIN_JKEY);
+	BUILD_BUG_ON(TID_RDMA_JKEY > HFI2_KERNEL_MAX_JKEY);
+	rcd->jkey = TID_RDMA_JKEY;
+	hfi2_set_ctxt_jkey(rcd->dd, rcd, rcd->jkey);
+	return hfi2_alloc_ctxt_rcv_groups(rcd);
+}
+
+/**
+ * qp_to_rcd - determine the receive context used by a qp
+ * @qp: the qp
+ *
+ * Return the receive context associated with the qp's qpn.  There may not yet
+ * be an associated port.  If not, return NULL.  It is expected that the port
+ * will be updated later.
+ *
+ * This is called at QP creation time or when the QP is updated with a port
+ * number.  When called during a port update, qp->port_num has the new port,
+ * but qp->ibqp.port is not yet updated.
+ */
+struct hfi2_ctxtdata *qp_to_rcd(struct rvt_qp *qp)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(qp->ibqp.device);
+	struct hfi2_pportdata *ppd;
+	unsigned int ctxt;
+
+	/* find the associated port, return NULL if not available */
+	if (qp->port_num == 0)
+		return NULL;
+	ppd = &dd->pport[qp->port_num - 1];
+
+	if (qp->ibqp.qp_num == 0)
+		ctxt = ppd->rcv_context_base; /* control context */
+	else
+		ctxt = hfi2_get_qp_map(ppd, qp->ibqp.qp_num >> ppd->qos_shift);
+	return dd->rcd[ctxt];
+}
+
+int hfi2_qp_priv_init(struct rvt_dev_info *rdi, struct rvt_qp *qp,
+		      struct ib_qp_init_attr *init_attr)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	int i, ret;
+
+	qpriv->rcd = qp_to_rcd(qp);
+
+	spin_lock_init(&qpriv->opfn.lock);
+	INIT_WORK(&qpriv->opfn.opfn_work, opfn_send_conn_request);
+	INIT_WORK(&qpriv->tid_rdma.trigger_work, tid_rdma_trigger_resume);
+	qpriv->flow_state.psn = 0;
+	qpriv->flow_state.index = RXE_NUM_TID_FLOWS;
+	qpriv->flow_state.last_index = RXE_NUM_TID_FLOWS;
+	qpriv->flow_state.generation = KERN_GENERATION_RESERVED;
+	qpriv->s_state = TID_OP(WRITE_RESP);
+	qpriv->s_tid_cur = HFI2_QP_WQE_INVALID;
+	qpriv->s_tid_head = HFI2_QP_WQE_INVALID;
+	qpriv->s_tid_tail = HFI2_QP_WQE_INVALID;
+	qpriv->rnr_nak_state = TID_RNR_NAK_INIT;
+	qpriv->r_tid_head = HFI2_QP_WQE_INVALID;
+	qpriv->r_tid_tail = HFI2_QP_WQE_INVALID;
+	qpriv->r_tid_ack = HFI2_QP_WQE_INVALID;
+	qpriv->r_tid_alloc = HFI2_QP_WQE_INVALID;
+	atomic_set(&qpriv->n_requests, 0);
+	atomic_set(&qpriv->n_tid_requests, 0);
+	timer_setup(&qpriv->s_tid_timer, hfi2_tid_timeout, 0);
+	timer_setup(&qpriv->s_tid_retry_timer, hfi2_tid_retry_timeout, 0);
+	INIT_LIST_HEAD(&qpriv->tid_wait);
+
+	if (init_attr->qp_type == IB_QPT_RC && HFI2_CAP_IS_KSET(TID_RDMA)) {
+		struct hfi2_devdata *dd = qpriv->rcd->dd;
+
+		qpriv->pages = kzalloc_node(TID_RDMA_MAX_PAGES *
+						sizeof(*qpriv->pages),
+					    GFP_KERNEL, dd->node);
+		if (!qpriv->pages)
+			return -ENOMEM;
+		for (i = 0; i < qp->s_size; i++) {
+			struct hfi2_swqe_priv *priv;
+			struct rvt_swqe *wqe = rvt_get_swqe_ptr(qp, i);
+
+			priv = kzalloc_node(sizeof(*priv), GFP_KERNEL,
+					    dd->node);
+			if (!priv)
+				return -ENOMEM;
+
+			hfi2_init_trdma_req(qp, &priv->tid_req);
+			priv->tid_req.e.swqe = wqe;
+			wqe->priv = priv;
+		}
+		for (i = 0; i < rvt_max_atomic(rdi); i++) {
+			struct hfi2_ack_priv *priv;
+
+			priv = kzalloc_node(sizeof(*priv), GFP_KERNEL,
+					    dd->node);
+			if (!priv)
+				return -ENOMEM;
+
+			hfi2_init_trdma_req(qp, &priv->tid_req);
+			priv->tid_req.e.ack = &qp->s_ack_queue[i];
+
+			ret = hfi2_kern_exp_rcv_alloc_flows(&priv->tid_req,
+							    GFP_KERNEL);
+			if (ret) {
+				kfree(priv);
+				return ret;
+			}
+			qp->s_ack_queue[i].priv = priv;
+		}
+	}
+
+	return 0;
+}
+
+void hfi2_qp_priv_tid_free(struct rvt_dev_info *rdi, struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct rvt_swqe *wqe;
+	u32 i;
+
+	if (qp->ibqp.qp_type == IB_QPT_RC && HFI2_CAP_IS_KSET(TID_RDMA)) {
+		for (i = 0; i < qp->s_size; i++) {
+			wqe = rvt_get_swqe_ptr(qp, i);
+			kfree(wqe->priv);
+			wqe->priv = NULL;
+		}
+		for (i = 0; i < rvt_max_atomic(rdi); i++) {
+			struct hfi2_ack_priv *priv = qp->s_ack_queue[i].priv;
+
+			if (priv)
+				hfi2_kern_exp_rcv_free_flows(&priv->tid_req);
+			kfree(priv);
+			qp->s_ack_queue[i].priv = NULL;
+		}
+		cancel_work_sync(&qpriv->opfn.opfn_work);
+		kfree(qpriv->pages);
+		qpriv->pages = NULL;
+	}
+}
+
+/* Flow and tid waiter functions */
+/**
+ * DOC: lock ordering
+ *
+ * There are two locks involved with the queuing
+ * routines: the qp s_lock and the exp_lock.
+ *
+ * Since the tid space allocation is called from
+ * the send engine, the qp s_lock is already held.
+ *
+ * The allocation routines will get the exp_lock.
+ *
+ * The first_qp() call is provided to allow the head of
+ * the rcd wait queue to be fetched under the exp_lock and
+ * followed by a drop of the exp_lock.
+ *
+ * Any qp in the wait list will have the qp reference count held
+ * to hold the qp in memory.
+ */
+
+/*
+ * return head of rcd wait list
+ *
+ * Must hold the exp_lock.
+ *
+ * Get a reference to the QP to hold the QP in memory.
+ *
+ * The caller must release the reference when the local
+ * is no longer being used.
+ */
+static struct rvt_qp *first_qp(struct hfi2_ctxtdata *rcd,
+			       struct tid_queue *queue)
+	__must_hold(&rcd->exp_lock)
+{
+	struct hfi2_qp_priv *priv;
+
+	lockdep_assert_held(&rcd->exp_lock);
+	priv = list_first_entry_or_null(&queue->queue_head,
+					struct hfi2_qp_priv,
+					tid_wait);
+	if (!priv)
+		return NULL;
+	rvt_get_qp(priv->owner);
+	return priv->owner;
+}
+
+/**
+ * kernel_tid_waiters - determine rcd wait
+ * @rcd: the receive context
+ * @queue: the queue to operate on
+ * @qp: the head of the qp being processed
+ *
+ * This routine will return false IFF
+ * the list is NULL or the head of the
+ * list is the indicated qp.
+ *
+ * Must hold the qp s_lock and the exp_lock.
+ *
+ * Return:
+ * false if either of the conditions below are satisfied:
+ * 1. The list is empty or
+ * 2. The indicated qp is at the head of the list and the
+ *    HFI2_S_WAIT_TID_SPACE bit is set in qp->s_flags.
+ * true is returned otherwise.
+ */
+static bool kernel_tid_waiters(struct hfi2_ctxtdata *rcd,
+			       struct tid_queue *queue, struct rvt_qp *qp)
+	__must_hold(&rcd->exp_lock) __must_hold(&qp->s_lock)
+{
+	struct rvt_qp *fqp;
+	bool ret = true;
+
+	lockdep_assert_held(&qp->s_lock);
+	lockdep_assert_held(&rcd->exp_lock);
+	fqp = first_qp(rcd, queue);
+	if (!fqp || (fqp == qp && (qp->s_flags & HFI2_S_WAIT_TID_SPACE)))
+		ret = false;
+	rvt_put_qp(fqp);
+	return ret;
+}
+
+/**
+ * dequeue_tid_waiter - dequeue the qp from the list
+ * @rcd: the receive context
+ * @queue: the queue to operate on
+ * @qp: the qp to remove the wait list
+ *
+ * This routine removes the indicated qp from the
+ * wait list if it is there.
+ *
+ * This should be done after the hardware flow and
+ * tid array resources have been allocated.
+ *
+ * Must hold the qp s_lock and the rcd exp_lock.
+ *
+ * It assumes the s_lock to protect the s_flags
+ * field and to reliably test the HFI2_S_WAIT_TID_SPACE flag.
+ */
+static void dequeue_tid_waiter(struct hfi2_ctxtdata *rcd,
+			       struct tid_queue *queue, struct rvt_qp *qp)
+	__must_hold(&rcd->exp_lock) __must_hold(&qp->s_lock)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	lockdep_assert_held(&qp->s_lock);
+	lockdep_assert_held(&rcd->exp_lock);
+	if (list_empty(&priv->tid_wait))
+		return;
+	list_del_init(&priv->tid_wait);
+	qp->s_flags &= ~HFI2_S_WAIT_TID_SPACE;
+	queue->dequeue++;
+	rvt_put_qp(qp);
+}
+
+/**
+ * queue_qp_for_tid_wait - suspend QP on tid space
+ * @rcd: the receive context
+ * @queue: the queue to operate on
+ * @qp: the qp
+ *
+ * The qp is inserted at the tail of the rcd
+ * wait queue and the HFI2_S_WAIT_TID_SPACE s_flag is set.
+ *
+ * Must hold the qp s_lock and the exp_lock.
+ */
+static void queue_qp_for_tid_wait(struct hfi2_ctxtdata *rcd,
+				  struct tid_queue *queue, struct rvt_qp *qp)
+	__must_hold(&rcd->exp_lock) __must_hold(&qp->s_lock)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	lockdep_assert_held(&qp->s_lock);
+	lockdep_assert_held(&rcd->exp_lock);
+	if (list_empty(&priv->tid_wait)) {
+		qp->s_flags |= HFI2_S_WAIT_TID_SPACE;
+		list_add_tail(&priv->tid_wait, &queue->queue_head);
+		priv->tid_enqueue = ++queue->enqueue;
+		rcd->dd->verbs_dev.n_tidwait++;
+		trace_hfi2_qpsleep(qp, HFI2_S_WAIT_TID_SPACE);
+		rvt_get_qp(qp);
+	}
+}
+
+/**
+ * __trigger_tid_waiter - trigger tid waiter
+ * @qp: the qp
+ *
+ * This is a private entrance to schedule the qp
+ * assuming the caller is holding the qp->s_lock.
+ */
+static void __trigger_tid_waiter(struct rvt_qp *qp)
+	__must_hold(&qp->s_lock)
+{
+	lockdep_assert_held(&qp->s_lock);
+	if (!(qp->s_flags & HFI2_S_WAIT_TID_SPACE))
+		return;
+	trace_hfi2_qpwakeup(qp, HFI2_S_WAIT_TID_SPACE);
+	hfi2_schedule_send(qp);
+}
+
+/**
+ * tid_rdma_schedule_tid_wakeup - schedule wakeup for a qp
+ * @qp: the qp
+ *
+ * trigger a schedule or a waiting qp in a deadlock
+ * safe manner.  The qp reference is held prior
+ * to this call via first_qp().
+ *
+ * If the qp trigger was already scheduled (!rval)
+ * the reference is dropped, otherwise the resume
+ * or the destroy cancel will dispatch the reference.
+ */
+static void tid_rdma_schedule_tid_wakeup(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv;
+	struct hfi2_ibport *ibp;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_devdata *dd;
+	bool rval;
+
+	if (!qp)
+		return;
+
+	priv = qp->priv;
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+	ppd = ppd_from_ibp(ibp);
+	dd = dd_from_ibdev(qp->ibqp.device);
+
+	rval = queue_work_on(priv->s_sde ?
+			     priv->s_sde->cpu :
+			     cpumask_first(cpumask_of_node(dd->node)),
+			     dd->hfi2_wq,
+			     &priv->tid_rdma.trigger_work);
+	if (!rval)
+		rvt_put_qp(qp);
+}
+
+/**
+ * tid_rdma_trigger_resume - field a trigger work request
+ * @work: the work item
+ *
+ * Complete the off qp trigger processing by directly
+ * calling the progress routine.
+ */
+static void tid_rdma_trigger_resume(struct work_struct *work)
+{
+	struct tid_rdma_qp_params *tr;
+	struct hfi2_qp_priv *priv;
+	struct rvt_qp *qp;
+
+	tr = container_of(work, struct tid_rdma_qp_params, trigger_work);
+	priv = container_of(tr, struct hfi2_qp_priv, tid_rdma);
+	qp = priv->owner;
+	spin_lock_irq(&qp->s_lock);
+	if (qp->s_flags & HFI2_S_WAIT_TID_SPACE) {
+		spin_unlock_irq(&qp->s_lock);
+		hfi2_do_send(priv->owner, true);
+	} else {
+		spin_unlock_irq(&qp->s_lock);
+	}
+	rvt_put_qp(qp);
+}
+
+/*
+ * tid_rdma_flush_wait - unwind any tid space wait
+ *
+ * This is called when resetting a qp to
+ * allow a destroy or reset to get rid
+ * of any tid space linkage and reference counts.
+ */
+static void _tid_rdma_flush_wait(struct rvt_qp *qp, struct tid_queue *queue)
+	__must_hold(&qp->s_lock)
+{
+	struct hfi2_qp_priv *priv;
+
+	if (!qp)
+		return;
+	lockdep_assert_held(&qp->s_lock);
+	priv = qp->priv;
+	qp->s_flags &= ~HFI2_S_WAIT_TID_SPACE;
+	spin_lock(&priv->rcd->exp_lock);
+	if (!list_empty(&priv->tid_wait)) {
+		list_del_init(&priv->tid_wait);
+		qp->s_flags &= ~HFI2_S_WAIT_TID_SPACE;
+		queue->dequeue++;
+		rvt_put_qp(qp);
+	}
+	spin_unlock(&priv->rcd->exp_lock);
+}
+
+void hfi2_tid_rdma_flush_wait(struct rvt_qp *qp)
+	__must_hold(&qp->s_lock)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (!priv->rcd)
+		return;
+	_tid_rdma_flush_wait(qp, &priv->rcd->flow_queue);
+	_tid_rdma_flush_wait(qp, &priv->rcd->rarr_queue);
+}
+
+/* Flow functions */
+/**
+ * kern_reserve_flow - allocate a hardware flow
+ * @rcd: the context to use for allocation
+ * @last: the index of the preferred flow. Use RXE_NUM_TID_FLOWS to
+ *         signify "don't care".
+ *
+ * Use a bit mask based allocation to reserve a hardware
+ * flow for use in receiving KDETH data packets. If a preferred flow is
+ * specified the function will attempt to reserve that flow again, if
+ * available.
+ *
+ * The exp_lock must be held.
+ *
+ * Return:
+ * On success: a value positive value between 0 and RXE_NUM_TID_FLOWS - 1
+ * On failure: -EAGAIN
+ */
+static int kern_reserve_flow(struct hfi2_ctxtdata *rcd, int last)
+	__must_hold(&rcd->exp_lock)
+{
+	int nr;
+
+	/* Attempt to reserve the preferred flow index */
+	if (last >= 0 && last < RXE_NUM_TID_FLOWS &&
+	    !test_and_set_bit(last, &rcd->flow_mask))
+		return last;
+
+	nr = ffz(rcd->flow_mask);
+	BUILD_BUG_ON(RXE_NUM_TID_FLOWS >=
+		     (sizeof(rcd->flow_mask) * BITS_PER_BYTE));
+	if (nr > (RXE_NUM_TID_FLOWS - 1))
+		return -EAGAIN;
+	set_bit(nr, &rcd->flow_mask);
+	return nr;
+}
+
+static void kern_set_hw_flow(struct hfi2_ctxtdata *rcd, u32 generation,
+			     u32 flow_idx)
+{
+	u64 reg;
+
+	reg = ((u64)generation << HFI2_KDETH_BTH_SEQ_SHIFT) |
+		RCV_TID_FLOW_TABLE_CTRL_FLOW_VALID_SMASK |
+		RCV_TID_FLOW_TABLE_CTRL_KEEP_AFTER_SEQ_ERR_SMASK |
+		RCV_TID_FLOW_TABLE_CTRL_KEEP_ON_GEN_ERR_SMASK |
+		RCV_TID_FLOW_TABLE_STATUS_SEQ_MISMATCH_SMASK |
+		RCV_TID_FLOW_TABLE_STATUS_GEN_MISMATCH_SMASK;
+
+	if (generation != KERN_GENERATION_RESERVED)
+		reg |= RCV_TID_FLOW_TABLE_CTRL_HDR_SUPP_EN_SMASK;
+
+	write_uctxt_csr(rcd->dd, rcd->ctxt,
+			rcd->dd->params->rcv_tid_flow_table_reg + 8 * flow_idx, reg);
+}
+
+static u32 kern_setup_hw_flow(struct hfi2_ctxtdata *rcd, u32 flow_idx)
+	__must_hold(&rcd->exp_lock)
+{
+	u32 generation = rcd->flows[flow_idx].generation;
+
+	kern_set_hw_flow(rcd, generation, flow_idx);
+	return generation;
+}
+
+static u32 kern_flow_generation_next(u32 gen)
+{
+	u32 generation = mask_generation(gen + 1);
+
+	if (generation == KERN_GENERATION_RESERVED)
+		generation = mask_generation(generation + 1);
+	return generation;
+}
+
+static void kern_clear_hw_flow(struct hfi2_ctxtdata *rcd, u32 flow_idx)
+	__must_hold(&rcd->exp_lock)
+{
+	rcd->flows[flow_idx].generation =
+		kern_flow_generation_next(rcd->flows[flow_idx].generation);
+	kern_set_hw_flow(rcd, KERN_GENERATION_RESERVED, flow_idx);
+}
+
+int hfi2_kern_setup_hw_flow(struct hfi2_ctxtdata *rcd, struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *qpriv = (struct hfi2_qp_priv *)qp->priv;
+	struct tid_flow_state *fs = &qpriv->flow_state;
+	struct rvt_qp *fqp;
+	unsigned long flags;
+	int ret = 0;
+
+	/* The QP already has an allocated flow */
+	if (fs->index != RXE_NUM_TID_FLOWS)
+		return ret;
+
+	spin_lock_irqsave(&rcd->exp_lock, flags);
+	if (kernel_tid_waiters(rcd, &rcd->flow_queue, qp))
+		goto queue;
+
+	ret = kern_reserve_flow(rcd, fs->last_index);
+	if (ret < 0)
+		goto queue;
+	fs->index = ret;
+	fs->last_index = fs->index;
+
+	/* Generation received in a RESYNC overrides default flow generation */
+	if (fs->generation != KERN_GENERATION_RESERVED)
+		rcd->flows[fs->index].generation = fs->generation;
+	fs->generation = kern_setup_hw_flow(rcd, fs->index);
+	fs->psn = 0;
+	dequeue_tid_waiter(rcd, &rcd->flow_queue, qp);
+	/* get head before dropping lock */
+	fqp = first_qp(rcd, &rcd->flow_queue);
+	spin_unlock_irqrestore(&rcd->exp_lock, flags);
+
+	tid_rdma_schedule_tid_wakeup(fqp);
+	return 0;
+queue:
+	queue_qp_for_tid_wait(rcd, &rcd->flow_queue, qp);
+	spin_unlock_irqrestore(&rcd->exp_lock, flags);
+	return -EAGAIN;
+}
+
+void hfi2_kern_clear_hw_flow(struct hfi2_ctxtdata *rcd, struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *qpriv = (struct hfi2_qp_priv *)qp->priv;
+	struct tid_flow_state *fs = &qpriv->flow_state;
+	struct rvt_qp *fqp;
+	unsigned long flags;
+
+	if (fs->index >= RXE_NUM_TID_FLOWS)
+		return;
+	spin_lock_irqsave(&rcd->exp_lock, flags);
+	kern_clear_hw_flow(rcd, fs->index);
+	clear_bit(fs->index, &rcd->flow_mask);
+	fs->index = RXE_NUM_TID_FLOWS;
+	fs->psn = 0;
+	fs->generation = KERN_GENERATION_RESERVED;
+
+	/* get head before dropping lock */
+	fqp = first_qp(rcd, &rcd->flow_queue);
+	spin_unlock_irqrestore(&rcd->exp_lock, flags);
+
+	if (fqp == qp) {
+		__trigger_tid_waiter(fqp);
+		rvt_put_qp(fqp);
+	} else {
+		tid_rdma_schedule_tid_wakeup(fqp);
+	}
+}
+
+void hfi2_kern_init_ctxt_generations(struct hfi2_ctxtdata *rcd)
+{
+	int i;
+
+	for (i = 0; i < RXE_NUM_TID_FLOWS; i++) {
+		rcd->flows[i].generation = mask_generation(get_random_u32());
+		kern_set_hw_flow(rcd, KERN_GENERATION_RESERVED, i);
+	}
+}
+
+/* TID allocation functions */
+static u8 trdma_pset_order(struct tid_rdma_pageset *s)
+{
+	u8 count = s->count;
+
+	return ilog2(count) + 1;
+}
+
+/**
+ * tid_rdma_find_phys_blocks_4k - get groups base on mr info
+ * @flow: overall info for a TID RDMA segment
+ * @pages: pointer to an array of page structs
+ * @npages: number of pages
+ * @list: page set array to return
+ *
+ * This routine returns the number of groups associated with
+ * the current sge information.  This implementation is based
+ * on the expected receive find_phys_blocks() adjusted to
+ * use the MR information vs. the pfn.
+ *
+ * Return:
+ * the number of RcvArray entries
+ */
+static u32 tid_rdma_find_phys_blocks_4k(struct tid_rdma_flow *flow,
+					struct page **pages,
+					u32 npages,
+					struct tid_rdma_pageset *list)
+{
+	u32 pagecount, pageidx, setcount = 0, i;
+	void *vaddr, *this_vaddr;
+
+	if (!npages)
+		return 0;
+
+	/*
+	 * Look for sets of physically contiguous pages in the user buffer.
+	 * This will allow us to optimize Expected RcvArray entry usage by
+	 * using the bigger supported sizes.
+	 */
+	vaddr = page_address(pages[0]);
+	trace_hfi2_tid_flow_page(flow->req->qp, flow, 0, 0, 0, vaddr);
+	for (pageidx = 0, pagecount = 1, i = 1; i <= npages; i++) {
+		this_vaddr = i < npages ? page_address(pages[i]) : NULL;
+		trace_hfi2_tid_flow_page(flow->req->qp, flow, i, 0, 0,
+					 this_vaddr);
+		/*
+		 * If the vaddr's are not sequential, pages are not physically
+		 * contiguous.
+		 */
+		if (this_vaddr != (vaddr + PAGE_SIZE)) {
+			/*
+			 * At this point we have to loop over the set of
+			 * physically contiguous pages and break them down it
+			 * sizes supported by the HW.
+			 * There are two main constraints:
+			 *     1. The max buffer size is MAX_EXPECTED_BUFFER.
+			 *        If the total set size is bigger than that
+			 *        program only a MAX_EXPECTED_BUFFER chunk.
+			 *     2. The buffer size has to be a power of two. If
+			 *        it is not, round down to the closes power of
+			 *        2 and program that size.
+			 */
+			while (pagecount) {
+				int maxpages = pagecount;
+				u32 bufsize = pagecount * PAGE_SIZE;
+
+				if (bufsize > MAX_EXPECTED_BUFFER)
+					maxpages =
+						MAX_EXPECTED_BUFFER >>
+						PAGE_SHIFT;
+				else if (!is_power_of_2(bufsize))
+					maxpages =
+						rounddown_pow_of_two(bufsize) >>
+						PAGE_SHIFT;
+
+				list[setcount].idx = pageidx;
+				list[setcount].count = maxpages;
+				trace_hfi2_tid_pageset(flow->req->qp, setcount,
+						       list[setcount].idx,
+						       list[setcount].count);
+				pagecount -= maxpages;
+				pageidx += maxpages;
+				setcount++;
+			}
+			pageidx = i;
+			pagecount = 1;
+			vaddr = this_vaddr;
+		} else {
+			vaddr += PAGE_SIZE;
+			pagecount++;
+		}
+	}
+	/* insure we always return an even number of sets */
+	if (setcount & 1)
+		list[setcount++].count = 0;
+	return setcount;
+}
+
+/**
+ * tid_flush_pages - dump out pages into pagesets
+ * @list: list of pagesets
+ * @idx: pointer to current page index
+ * @pages: number of pages to dump
+ * @sets: current number of pagesset
+ *
+ * This routine flushes out accumuated pages.
+ *
+ * To insure an even number of sets the
+ * code may add a filler.
+ *
+ * This can happen with when pages is not
+ * a power of 2 or pages is a power of 2
+ * less than the maximum pages.
+ *
+ * Return:
+ * The new number of sets
+ */
+
+static u32 tid_flush_pages(struct tid_rdma_pageset *list,
+			   u32 *idx, u32 pages, u32 sets)
+{
+	while (pages) {
+		u32 maxpages = pages;
+
+		if (maxpages > MAX_EXPECTED_PAGES)
+			maxpages = MAX_EXPECTED_PAGES;
+		else if (!is_power_of_2(maxpages))
+			maxpages = rounddown_pow_of_two(maxpages);
+		list[sets].idx = *idx;
+		list[sets++].count = maxpages;
+		*idx += maxpages;
+		pages -= maxpages;
+	}
+	/* might need a filler */
+	if (sets & 1)
+		list[sets++].count = 0;
+	return sets;
+}
+
+/**
+ * tid_rdma_find_phys_blocks_8k - get groups base on mr info
+ * @flow: overall info for a TID RDMA segment
+ * @pages: pointer to an array of page structs
+ * @npages: number of pages
+ * @list: page set array to return
+ *
+ * This routine parses an array of pages to compute pagesets
+ * in an 8k compatible way.
+ *
+ * pages are tested two at a time, i, i + 1 for contiguous
+ * pages and i - 1 and i contiguous pages.
+ *
+ * If any condition is false, any accumulated pages are flushed and
+ * v0,v1 are emitted as separate PAGE_SIZE pagesets
+ *
+ * Otherwise, the current 8k is totaled for a future flush.
+ *
+ * Return:
+ * The number of pagesets
+ * list set with the returned number of pagesets
+ *
+ */
+static u32 tid_rdma_find_phys_blocks_8k(struct tid_rdma_flow *flow,
+					struct page **pages,
+					u32 npages,
+					struct tid_rdma_pageset *list)
+{
+	u32 idx, sets = 0, i;
+	u32 pagecnt = 0;
+	void *v0, *v1, *vm1;
+
+	if (!npages)
+		return 0;
+	for (idx = 0, i = 0, vm1 = NULL; i < npages; i += 2) {
+		/* get a new v0 */
+		v0 = page_address(pages[i]);
+		trace_hfi2_tid_flow_page(flow->req->qp, flow, i, 1, 0, v0);
+		v1 = i + 1 < npages ?
+				page_address(pages[i + 1]) : NULL;
+		trace_hfi2_tid_flow_page(flow->req->qp, flow, i, 1, 1, v1);
+		/* compare i, i + 1 vaddr */
+		if (v1 != (v0 + PAGE_SIZE)) {
+			/* flush out pages */
+			sets = tid_flush_pages(list, &idx, pagecnt, sets);
+			/* output v0,v1 as two pagesets */
+			list[sets].idx = idx++;
+			list[sets++].count = 1;
+			if (v1) {
+				list[sets].count = 1;
+				list[sets++].idx = idx++;
+			} else {
+				list[sets++].count = 0;
+			}
+			vm1 = NULL;
+			pagecnt = 0;
+			continue;
+		}
+		/* i,i+1 consecutive, look at i-1,i */
+		if (vm1 && v0 != (vm1 + PAGE_SIZE)) {
+			/* flush out pages */
+			sets = tid_flush_pages(list, &idx, pagecnt, sets);
+			pagecnt = 0;
+		}
+		/* pages will always be a multiple of 8k */
+		pagecnt += 2;
+		/* save i-1 */
+		vm1 = v1;
+		/* move to next pair */
+	}
+	/* dump residual pages at end */
+	sets = tid_flush_pages(list, &idx, npages - idx, sets);
+	/* by design cannot be odd sets */
+	WARN_ON(sets & 1);
+	return sets;
+}
+
+/*
+ * Find pages for one segment of a sge array represented by @ss. The function
+ * does not check the sge, the sge must have been checked for alignment with a
+ * prior call to hfi2_kern_trdma_ok. Other sge checking is done as part of
+ * rvt_lkey_ok and rvt_rkey_ok. Also, the function only modifies the local sge
+ * copy maintained in @ss->sge, the original sge is not modified.
+ *
+ * Unlike IB RDMA WRITE, we can't decrement ss->num_sge here because we are not
+ * releasing the MR reference count at the same time. Otherwise, we'll "leak"
+ * references to the MR. This difference requires that we keep track of progress
+ * into the sg_list. This is done by the cur_seg cursor in the tid_rdma_request
+ * structure.
+ */
+static u32 kern_find_pages(struct tid_rdma_flow *flow,
+			   struct page **pages,
+			   struct rvt_sge_state *ss, bool *last)
+{
+	struct tid_rdma_request *req = flow->req;
+	struct rvt_sge *sge = &ss->sge;
+	u32 length = flow->req->seg_len;
+	u32 len = PAGE_SIZE;
+	u32 i = 0;
+
+	while (length && req->isge < ss->num_sge) {
+		pages[i++] = virt_to_page(sge->vaddr);
+
+		sge->vaddr += len;
+		sge->length -= len;
+		sge->sge_length -= len;
+		if (!sge->sge_length) {
+			if (++req->isge < ss->num_sge)
+				*sge = ss->sg_list[req->isge - 1];
+		} else if (sge->length == 0 && sge->mr->lkey) {
+			if (++sge->n >= RVT_SEGSZ) {
+				++sge->m;
+				sge->n = 0;
+			}
+			sge->vaddr = sge->mr->map[sge->m]->segs[sge->n].vaddr;
+			sge->length = sge->mr->map[sge->m]->segs[sge->n].length;
+		}
+		length -= len;
+	}
+
+	flow->length = flow->req->seg_len - length;
+	*last = req->isge != ss->num_sge;
+	return i;
+}
+
+static void dma_unmap_flow(struct tid_rdma_flow *flow)
+{
+	struct hfi2_devdata *dd;
+	int i;
+	struct tid_rdma_pageset *pset;
+
+	dd = flow->req->rcd->dd;
+	for (i = 0, pset = &flow->pagesets[0]; i < flow->npagesets;
+			i++, pset++) {
+		if (pset->count && pset->addr) {
+			dma_unmap_page(&dd->pcidev->dev,
+				       pset->addr,
+				       PAGE_SIZE * pset->count,
+				       DMA_FROM_DEVICE);
+			pset->mapped = 0;
+		}
+	}
+}
+
+static int dma_map_flow(struct tid_rdma_flow *flow, struct page **pages)
+{
+	int i;
+	struct hfi2_devdata *dd = flow->req->rcd->dd;
+	struct tid_rdma_pageset *pset;
+
+	for (i = 0, pset = &flow->pagesets[0]; i < flow->npagesets;
+			i++, pset++) {
+		if (pset->count) {
+			pset->addr = dma_map_page(&dd->pcidev->dev,
+						  pages[pset->idx],
+						  0,
+						  PAGE_SIZE * pset->count,
+						  DMA_FROM_DEVICE);
+
+			if (dma_mapping_error(&dd->pcidev->dev, pset->addr)) {
+				dma_unmap_flow(flow);
+				return -ENOMEM;
+			}
+			pset->mapped = 1;
+		}
+	}
+	return 0;
+}
+
+static inline bool dma_mapped(struct tid_rdma_flow *flow)
+{
+	return !!flow->pagesets[0].mapped;
+}
+
+/*
+ * Get pages pointers and identify contiguous physical memory chunks for a
+ * segment. All segments are of length flow->req->seg_len.
+ */
+static int kern_get_phys_blocks(struct tid_rdma_flow *flow,
+				struct page **pages,
+				struct rvt_sge_state *ss, bool *last)
+{
+	u8 npages;
+
+	/* Reuse previously computed pagesets, if any */
+	if (flow->npagesets) {
+		trace_hfi2_tid_flow_alloc(flow->req->qp, flow->req->setup_head,
+					  flow);
+		if (!dma_mapped(flow))
+			return dma_map_flow(flow, pages);
+		return 0;
+	}
+
+	npages = kern_find_pages(flow, pages, ss, last);
+
+	if (flow->req->qp->pmtu == enum_to_mtu(OPA_MTU_4096))
+		flow->npagesets =
+			tid_rdma_find_phys_blocks_4k(flow, pages, npages,
+						     flow->pagesets);
+	else
+		flow->npagesets =
+			tid_rdma_find_phys_blocks_8k(flow, pages, npages,
+						     flow->pagesets);
+
+	return dma_map_flow(flow, pages);
+}
+
+static inline void kern_add_tid_node(struct tid_rdma_flow *flow,
+				     struct hfi2_ctxtdata *rcd, char *s,
+				     struct tid_group *grp, u8 cnt)
+{
+	struct kern_tid_node *node = &flow->tnode[flow->tnode_cnt++];
+
+	WARN_ON_ONCE(flow->tnode_cnt >=
+		     (TID_RDMA_MAX_SEGMENT_SIZE >> PAGE_SHIFT));
+	if (WARN_ON_ONCE(cnt & 1))
+		dd_dev_err(rcd->dd,
+			   "unexpected odd allocation cnt %u map 0x%x used %u",
+			   cnt, grp->map, grp->used);
+
+	node->grp = grp;
+	node->map = grp->map;
+	node->cnt = cnt;
+	trace_hfi2_tid_node_add(flow->req->qp, s, flow->tnode_cnt - 1,
+				grp->base, grp->map, grp->used, cnt);
+}
+
+/*
+ * Try to allocate pageset_count TID's from TID groups for a context
+ *
+ * This function allocates TID's without moving groups between lists or
+ * modifying grp->map. This is done as follows, being cogizant of the lists
+ * between which the TID groups will move:
+ * 1. First allocate complete groups of 8 TID's since this is more efficient,
+ *    these groups will move from group->full without affecting used
+ * 2. If more TID's are needed allocate from used (will move from used->full or
+ *    stay in used)
+ * 3. If we still don't have the required number of TID's go back and look again
+ *    at a complete group (will move from group->used)
+ */
+static int kern_alloc_tids(struct tid_rdma_flow *flow)
+{
+	struct hfi2_ctxtdata *rcd = flow->req->rcd;
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 ngroups, pageidx = 0;
+	struct tid_group *group = NULL, *used;
+	u8 use;
+
+	flow->tnode_cnt = 0;
+	ngroups = flow->npagesets / dd->rcv_entries.group_size;
+	if (!ngroups)
+		goto used_list;
+
+	/* First look at complete groups */
+	list_for_each_entry(group,  &rcd->tid_group_list.list, list) {
+		kern_add_tid_node(flow, rcd, "complete groups", group,
+				  group->size);
+
+		pageidx += group->size;
+		if (!--ngroups)
+			break;
+	}
+
+	if (pageidx >= flow->npagesets)
+		goto ok;
+
+used_list:
+	/* Now look at partially used groups */
+	list_for_each_entry(used, &rcd->tid_used_list.list, list) {
+		use = min_t(u32, flow->npagesets - pageidx,
+			    used->size - used->used);
+		kern_add_tid_node(flow, rcd, "used groups", used, use);
+
+		pageidx += use;
+		if (pageidx >= flow->npagesets)
+			goto ok;
+	}
+
+	/*
+	 * Look again at a complete group, continuing from where we left.
+	 * However, if we are at the head, we have reached the end of the
+	 * complete groups list from the first loop above
+	 */
+	if (group && &group->list == &rcd->tid_group_list.list)
+		goto bail_eagain;
+	group = list_prepare_entry(group, &rcd->tid_group_list.list,
+				   list);
+	if (list_is_last(&group->list, &rcd->tid_group_list.list))
+		goto bail_eagain;
+	group = list_next_entry(group, list);
+	use = min_t(u32, flow->npagesets - pageidx, group->size);
+	kern_add_tid_node(flow, rcd, "complete continue", group, use);
+	pageidx += use;
+	if (pageidx >= flow->npagesets)
+		goto ok;
+bail_eagain:
+	trace_hfi2_msg_alloc_tids(flow->req->qp, " insufficient tids: needed ",
+				  (u64)flow->npagesets);
+	return -EAGAIN;
+ok:
+	return 0;
+}
+
+static void kern_program_rcv_group(struct tid_rdma_flow *flow, int grp_num,
+				   u32 *pset_idx)
+{
+	struct hfi2_ctxtdata *rcd = flow->req->rcd;
+	struct kern_tid_node *node = &flow->tnode[grp_num];
+	struct tid_group *grp = node->grp;
+	struct tid_rdma_pageset *pset;
+	u32 pmtu_pg = flow->req->qp->pmtu >> PAGE_SHIFT;
+	u32 rcventry, npages = 0, pair = 0, tidctrl;
+	u8 i, cnt = 0;
+
+	for (i = 0; i < grp->size; i++) {
+		rcventry = grp->base + i;
+
+		if (node->map & BIT(i) || cnt >= node->cnt) {
+			rcd->dd->params->rcv_array_wc_fill(rcd, rcventry,
+							   PT_EXPECTED);
+			continue;
+		}
+		pset = &flow->pagesets[(*pset_idx)++];
+		if (pset->count) {
+			rcd->dd->params->put_tid(rcd, rcventry, PT_EXPECTED,
+						 pset->addr,
+						 trdma_pset_order(pset), false);
+		} else {
+			rcd->dd->params->put_tid(rcd, rcventry, PT_EXPECTED,
+						 0, 0, false);
+		}
+		npages += pset->count;
+
+		tidctrl = pair ? 0x3 : rcventry & 0x1 ? 0x2 : 0x1;
+		/*
+		 * A single TID entry will be used to use a rcvarr pair (with
+		 * tidctrl 0x3), if ALL these are true (a) the bit pos is even
+		 * (b) the group map shows current and the next bits as free
+		 * indicating two consecutive rcvarry entries are available (c)
+		 * we actually need 2 more entries
+		 */
+		pair = !(i & 0x1) && !((node->map >> i) & 0x3) &&
+			node->cnt >= cnt + 2;
+		if (!pair) {
+			if (!pset->count)
+				tidctrl = 0x1;
+			flow->tid_entry[flow->tidcnt++] =
+				EXP_TID_SET(IDX, rcventry >> 1) |
+				EXP_TID_SET(CTRL, tidctrl) |
+				EXP_TID_SET(LEN, npages);
+			trace_hfi2_tid_entry_alloc(/* entry */
+			   flow->req->qp, flow->tidcnt - 1,
+			   flow->tid_entry[flow->tidcnt - 1]);
+
+			/* Efficient DIV_ROUND_UP(npages, pmtu_pg) */
+			flow->npkts += (npages + pmtu_pg - 1) >> ilog2(pmtu_pg);
+			npages = 0;
+		}
+
+		if (grp->used == grp->size - 1)
+			tid_group_move(grp, &rcd->tid_used_list,
+				       &rcd->tid_full_list);
+		else if (!grp->used)
+			tid_group_move(grp, &rcd->tid_group_list,
+				       &rcd->tid_used_list);
+
+		grp->used++;
+		grp->map |= BIT(i);
+		cnt++;
+	}
+}
+
+static void kern_unprogram_rcv_group(struct tid_rdma_flow *flow, int grp_num)
+{
+	struct hfi2_ctxtdata *rcd = flow->req->rcd;
+	struct kern_tid_node *node = &flow->tnode[grp_num];
+	struct tid_group *grp = node->grp;
+	u32 rcventry;
+	u8 i, cnt = 0;
+
+	for (i = 0; i < grp->size; i++) {
+		rcventry = grp->base + i;
+
+		if (node->map & BIT(i) || cnt >= node->cnt) {
+			rcd->dd->params->rcv_array_wc_fill(rcd, rcventry, PT_EXPECTED);
+			continue;
+		}
+
+		rcd->dd->params->put_tid(rcd, rcventry, PT_EXPECTED, 0, 0,
+					 false);
+
+		grp->used--;
+		grp->map &= ~BIT(i);
+		cnt++;
+
+		if (grp->used == grp->size - 1)
+			tid_group_move(grp, &rcd->tid_full_list,
+				       &rcd->tid_used_list);
+		else if (!grp->used)
+			tid_group_move(grp, &rcd->tid_used_list,
+				       &rcd->tid_group_list);
+	}
+	if (WARN_ON_ONCE(cnt & 1)) {
+		struct hfi2_ctxtdata *rcd = flow->req->rcd;
+		struct hfi2_devdata *dd = rcd->dd;
+
+		dd_dev_err(dd, "unexpected odd free cnt %u map 0x%x used %u",
+			   cnt, grp->map, grp->used);
+	}
+}
+
+static void kern_program_rcvarray(struct tid_rdma_flow *flow)
+{
+	u32 pset_idx = 0;
+	int i;
+
+	flow->npkts = 0;
+	flow->tidcnt = 0;
+	for (i = 0; i < flow->tnode_cnt; i++)
+		kern_program_rcv_group(flow, i, &pset_idx);
+	trace_hfi2_tid_flow_alloc(flow->req->qp, flow->req->setup_head, flow);
+}
+
+/**
+ * hfi2_kern_exp_rcv_setup() - setup TID's and flow for one segment of a
+ * TID RDMA request
+ *
+ * @req: TID RDMA request for which the segment/flow is being set up
+ * @ss: sge state, maintains state across successive segments of a sge
+ * @last: set to true after the last sge segment has been processed
+ *
+ * This function
+ * (1) finds a free flow entry in the flow circular buffer
+ * (2) finds pages and continuous physical chunks constituing one segment
+ *     of an sge
+ * (3) allocates TID group entries for those chunks
+ * (4) programs rcvarray entries in the hardware corresponding to those
+ *     TID's
+ * (5) computes a tidarray with formatted TID entries which can be sent
+ *     to the sender
+ * (6) Reserves and programs HW flows.
+ * (7) It also manages queueing the QP when TID/flow resources are not
+ *     available.
+ *
+ * @req points to struct tid_rdma_request of which the segments are a part. The
+ * function uses qp, rcd and seg_len members of @req. In the absence of errors,
+ * req->flow_idx is the index of the flow which has been prepared in this
+ * invocation of function call. With flow = &req->flows[req->flow_idx],
+ * flow->tid_entry contains the TID array which the sender can use for TID RDMA
+ * sends and flow->npkts contains number of packets required to send the
+ * segment.
+ *
+ * hfi2_check_sge_align should be called prior to calling this function and if
+ * it signals error TID RDMA cannot be used for this sge and this function
+ * should not be called.
+ *
+ * For the queuing, caller must hold the flow->req->qp s_lock from the send
+ * engine and the function will procure the exp_lock.
+ *
+ * Return:
+ * The function returns -EAGAIN if sufficient number of TID/flow resources to
+ * map the segment could not be allocated. In this case the function should be
+ * called again with previous arguments to retry the TID allocation. There are
+ * no other error returns. The function returns 0 on success.
+ */
+int hfi2_kern_exp_rcv_setup(struct tid_rdma_request *req,
+			    struct rvt_sge_state *ss, bool *last)
+	__must_hold(&req->qp->s_lock)
+{
+	struct tid_rdma_flow *flow = &req->flows[req->setup_head];
+	struct hfi2_ctxtdata *rcd = req->rcd;
+	struct hfi2_qp_priv *qpriv = req->qp->priv;
+	unsigned long flags;
+	struct rvt_qp *fqp;
+	u16 clear_tail = req->clear_tail;
+
+	lockdep_assert_held(&req->qp->s_lock);
+	/*
+	 * We return error if either (a) we don't have space in the flow
+	 * circular buffer, or (b) we already have max entries in the buffer.
+	 * Max entries depend on the type of request we are processing and the
+	 * negotiated TID RDMA parameters.
+	 */
+	if (!CIRC_SPACE(req->setup_head, clear_tail, MAX_FLOWS) ||
+	    CIRC_CNT(req->setup_head, clear_tail, MAX_FLOWS) >=
+	    req->n_flows)
+		return -EINVAL;
+
+	/*
+	 * Get pages, identify contiguous physical memory chunks for the segment
+	 * If we can not determine a DMA address mapping we will treat it just
+	 * like if we ran out of space above.
+	 */
+	if (kern_get_phys_blocks(flow, qpriv->pages, ss, last)) {
+		hfi2_wait_kmem(flow->req->qp);
+		return -ENOMEM;
+	}
+
+	spin_lock_irqsave(&rcd->exp_lock, flags);
+	if (kernel_tid_waiters(rcd, &rcd->rarr_queue, flow->req->qp))
+		goto queue;
+
+	/*
+	 * At this point we know the number of pagesets and hence the number of
+	 * TID's to map the segment. Allocate the TID's from the TID groups. If
+	 * we cannot allocate the required number we exit and try again later
+	 */
+	if (kern_alloc_tids(flow))
+		goto queue;
+	/*
+	 * Finally program the TID entries with the pagesets, compute the
+	 * tidarray and enable the HW flow
+	 */
+	kern_program_rcvarray(flow);
+
+	/*
+	 * Setup the flow state with relevant information.
+	 * This information is used for tracking the sequence of data packets
+	 * for the segment.
+	 * The flow is setup here as this is the most accurate time and place
+	 * to do so. Doing at a later time runs the risk of the flow data in
+	 * qpriv getting out of sync.
+	 */
+	memset(&flow->flow_state, 0x0, sizeof(flow->flow_state));
+	flow->idx = qpriv->flow_state.index;
+	flow->flow_state.generation = qpriv->flow_state.generation;
+	flow->flow_state.spsn = qpriv->flow_state.psn;
+	flow->flow_state.lpsn = flow->flow_state.spsn + flow->npkts - 1;
+	flow->flow_state.r_next_psn =
+		full_flow_psn(flow, flow->flow_state.spsn);
+	qpriv->flow_state.psn += flow->npkts;
+
+	dequeue_tid_waiter(rcd, &rcd->rarr_queue, flow->req->qp);
+	/* get head before dropping lock */
+	fqp = first_qp(rcd, &rcd->rarr_queue);
+	spin_unlock_irqrestore(&rcd->exp_lock, flags);
+	tid_rdma_schedule_tid_wakeup(fqp);
+
+	req->setup_head = (req->setup_head + 1) & (MAX_FLOWS - 1);
+	return 0;
+queue:
+	queue_qp_for_tid_wait(rcd, &rcd->rarr_queue, flow->req->qp);
+	spin_unlock_irqrestore(&rcd->exp_lock, flags);
+	return -EAGAIN;
+}
+
+static void hfi2_tid_rdma_reset_flow(struct tid_rdma_flow *flow)
+{
+	flow->npagesets = 0;
+}
+
+/*
+ * This function is called after one segment has been successfully sent to
+ * release the flow and TID HW/SW resources for that segment. The segments for a
+ * TID RDMA request are setup and cleared in FIFO order which is managed using a
+ * circular buffer.
+ */
+int hfi2_kern_exp_rcv_clear(struct tid_rdma_request *req)
+	__must_hold(&req->qp->s_lock)
+{
+	struct tid_rdma_flow *flow = &req->flows[req->clear_tail];
+	struct hfi2_ctxtdata *rcd = req->rcd;
+	unsigned long flags;
+	int i;
+	struct rvt_qp *fqp;
+
+	lockdep_assert_held(&req->qp->s_lock);
+	/* Exit if we have nothing in the flow circular buffer */
+	if (!CIRC_CNT(req->setup_head, req->clear_tail, MAX_FLOWS))
+		return -EINVAL;
+
+	spin_lock_irqsave(&rcd->exp_lock, flags);
+
+	for (i = 0; i < flow->tnode_cnt; i++)
+		kern_unprogram_rcv_group(flow, i);
+	/* To prevent double unprogramming */
+	flow->tnode_cnt = 0;
+	/* get head before dropping lock */
+	fqp = first_qp(rcd, &rcd->rarr_queue);
+	spin_unlock_irqrestore(&rcd->exp_lock, flags);
+
+	dma_unmap_flow(flow);
+
+	hfi2_tid_rdma_reset_flow(flow);
+	req->clear_tail = (req->clear_tail + 1) & (MAX_FLOWS - 1);
+
+	if (fqp == req->qp) {
+		__trigger_tid_waiter(fqp);
+		rvt_put_qp(fqp);
+	} else {
+		tid_rdma_schedule_tid_wakeup(fqp);
+	}
+
+	return 0;
+}
+
+/*
+ * This function is called to release all the tid entries for
+ * a request.
+ */
+void hfi2_kern_exp_rcv_clear_all(struct tid_rdma_request *req)
+	__must_hold(&req->qp->s_lock)
+{
+	/* Use memory barrier for proper ordering */
+	while (CIRC_CNT(req->setup_head, req->clear_tail, MAX_FLOWS)) {
+		if (hfi2_kern_exp_rcv_clear(req))
+			break;
+	}
+}
+
+/**
+ * hfi2_kern_exp_rcv_free_flows - free previously allocated flow information
+ * @req: the tid rdma request to be cleaned
+ */
+static void hfi2_kern_exp_rcv_free_flows(struct tid_rdma_request *req)
+{
+	kfree(req->flows);
+	req->flows = NULL;
+}
+
+/**
+ * __trdma_clean_swqe - clean up for large sized QPs
+ * @qp: the queue patch
+ * @wqe: the send wqe
+ */
+void __trdma_clean_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
+{
+	struct hfi2_swqe_priv *p = wqe->priv;
+
+	hfi2_kern_exp_rcv_free_flows(&p->tid_req);
+}
+
+/*
+ * This can be called at QP create time or in the data path.
+ */
+static int hfi2_kern_exp_rcv_alloc_flows(struct tid_rdma_request *req,
+					 gfp_t gfp)
+{
+	struct tid_rdma_flow *flows;
+	int i;
+
+	if (likely(req->flows))
+		return 0;
+	flows = kmalloc_node(MAX_FLOWS * sizeof(*flows), gfp,
+			     req->rcd->numa_id);
+	if (!flows)
+		return -ENOMEM;
+	/* mini init */
+	for (i = 0; i < MAX_FLOWS; i++) {
+		flows[i].req = req;
+		flows[i].npagesets = 0;
+		flows[i].pagesets[0].mapped =  0;
+		flows[i].resync_npkts = 0;
+	}
+	req->flows = flows;
+	return 0;
+}
+
+static void hfi2_init_trdma_req(struct rvt_qp *qp,
+				struct tid_rdma_request *req)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+
+	/*
+	 * Initialize various TID RDMA request variables.
+	 * These variables are "static", which is why they
+	 * can be pre-initialized here before the WRs has
+	 * even been submitted.
+	 * However, non-NULL values for these variables do not
+	 * imply that this WQE has been enabled for TID RDMA.
+	 * Drivers should check the WQE's opcode to determine
+	 * if a request is a TID RDMA one or not.
+	 */
+	req->qp = qp;
+	req->rcd = qpriv->rcd;
+}
+
+u64 hfi2_access_sw_tid_wait(const struct cntr_entry *entry,
+			    void *context, int vl, int mode, u64 data)
+{
+	struct hfi2_devdata *dd = context;
+
+	return dd->verbs_dev.n_tidwait;
+}
+
+static struct tid_rdma_flow *find_flow_ib(struct tid_rdma_request *req,
+					  u32 psn, u16 *fidx)
+{
+	u16 head, tail;
+	struct tid_rdma_flow *flow;
+
+	head = req->setup_head;
+	tail = req->clear_tail;
+	for ( ; CIRC_CNT(head, tail, MAX_FLOWS);
+	     tail = CIRC_NEXT(tail, MAX_FLOWS)) {
+		flow = &req->flows[tail];
+		if (cmp_psn(psn, flow->flow_state.ib_spsn) >= 0 &&
+		    cmp_psn(psn, flow->flow_state.ib_lpsn) <= 0) {
+			if (fidx)
+				*fidx = tail;
+			return flow;
+		}
+	}
+	return NULL;
+}
+
+/* TID RDMA READ functions */
+u32 hfi2_build_tid_rdma_read_packet(struct rvt_swqe *wqe,
+				    struct ib_other_headers *ohdr, u32 *bth1,
+				    u32 *bth2, u32 *len)
+{
+	struct tid_rdma_request *req = wqe_to_tid_req(wqe);
+	struct tid_rdma_flow *flow = &req->flows[req->flow_idx];
+	struct rvt_qp *qp = req->qp;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct hfi2_swqe_priv *wpriv = wqe->priv;
+	struct tid_rdma_read_req *rreq = &ohdr->u.tid_rdma.r_req;
+	struct tid_rdma_params *remote;
+	u32 req_len = 0;
+	void *req_addr = NULL;
+
+	/* This is the IB psn used to send the request */
+	*bth2 = mask_psn(flow->flow_state.ib_spsn + flow->pkt);
+	trace_hfi2_tid_flow_build_read_pkt(qp, req->flow_idx, flow);
+
+	/* TID Entries for TID RDMA READ payload */
+	req_addr = &flow->tid_entry[flow->tid_idx];
+	req_len = sizeof(*flow->tid_entry) *
+			(flow->tidcnt - flow->tid_idx);
+
+	memset(&ohdr->u.tid_rdma.r_req, 0, sizeof(ohdr->u.tid_rdma.r_req));
+	wpriv->ss.sge.vaddr = req_addr;
+	wpriv->ss.sge.sge_length = req_len;
+	wpriv->ss.sge.length = wpriv->ss.sge.sge_length;
+	/*
+	 * We can safely zero these out. Since the first SGE covers the
+	 * entire packet, nothing else should even look at the MR.
+	 */
+	wpriv->ss.sge.mr = NULL;
+	wpriv->ss.sge.m = 0;
+	wpriv->ss.sge.n = 0;
+
+	wpriv->ss.sg_list = NULL;
+	wpriv->ss.total_len = wpriv->ss.sge.sge_length;
+	wpriv->ss.num_sge = 1;
+
+	/* Construct the TID RDMA READ REQ packet header */
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+
+	KDETH_RESET(rreq->kdeth0, KVER, 0x1);
+	KDETH_RESET(rreq->kdeth1, JKEY, remote->jkey);
+	rreq->reth.vaddr = cpu_to_be64(wqe->rdma_wr.remote_addr +
+			   req->cur_seg * req->seg_len + flow->sent);
+	rreq->reth.rkey = cpu_to_be32(wqe->rdma_wr.rkey);
+	rreq->reth.length = cpu_to_be32(*len);
+	rreq->tid_flow_psn =
+		cpu_to_be32((flow->flow_state.generation <<
+			     HFI2_KDETH_BTH_SEQ_SHIFT) |
+			    ((flow->flow_state.spsn + flow->pkt) &
+			     HFI2_KDETH_BTH_SEQ_MASK));
+	rreq->tid_flow_qp =
+		cpu_to_be32(qpriv->tid_rdma.local.qp |
+			    ((flow->idx & TID_RDMA_DESTQP_FLOW_MASK) <<
+			     TID_RDMA_DESTQP_FLOW_SHIFT) |
+			    qpriv->rcd->ctxt);
+	rreq->verbs_qp = cpu_to_be32(qp->remote_qpn);
+	*bth1 &= ~RVT_QPN_MASK;
+	*bth1 |= remote->qp;
+	*bth2 |= IB_BTH_REQ_ACK;
+	rcu_read_unlock();
+
+	/* We are done with this segment */
+	flow->sent += *len;
+	req->cur_seg++;
+	qp->s_state = TID_OP(READ_REQ);
+	req->ack_pending++;
+	req->flow_idx = (req->flow_idx + 1) & (MAX_FLOWS - 1);
+	qpriv->pending_tid_r_segs++;
+	qp->s_num_rd_atomic++;
+
+	/* Set the TID RDMA READ request payload size */
+	*len = req_len;
+
+	return sizeof(ohdr->u.tid_rdma.r_req) / sizeof(u32);
+}
+
+/*
+ * @len: contains the data length to read upon entry and the read request
+ *       payload length upon exit.
+ */
+u32 hfi2_build_tid_rdma_read_req(struct rvt_qp *qp, struct rvt_swqe *wqe,
+				 struct ib_other_headers *ohdr, u32 *bth1,
+				 u32 *bth2, u32 *len)
+	__must_hold(&qp->s_lock)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_rdma_request *req = wqe_to_tid_req(wqe);
+	struct tid_rdma_flow *flow = NULL;
+	u32 hdwords = 0;
+	bool last;
+	bool retry = true;
+	u32 npkts = rvt_div_round_up_mtu(qp, *len);
+
+	trace_hfi2_tid_req_build_read_req(qp, 0, wqe->wr.opcode, wqe->psn,
+					  wqe->lpsn, req);
+	/*
+	 * Check sync conditions. Make sure that there are no pending
+	 * segments before freeing the flow.
+	 */
+sync_check:
+	if (req->state == TID_REQUEST_SYNC) {
+		if (qpriv->pending_tid_r_segs)
+			goto done;
+
+		hfi2_kern_clear_hw_flow(req->rcd, qp);
+		qpriv->s_flags &= ~HFI2_R_TID_SW_PSN;
+		req->state = TID_REQUEST_ACTIVE;
+	}
+
+	/*
+	 * If the request for this segment is resent, the tid resources should
+	 * have been allocated before. In this case, req->flow_idx should
+	 * fall behind req->setup_head.
+	 */
+	if (req->flow_idx == req->setup_head) {
+		retry = false;
+		if (req->state == TID_REQUEST_RESEND) {
+			/*
+			 * This is the first new segment for a request whose
+			 * earlier segments have been re-sent. We need to
+			 * set up the sge pointer correctly.
+			 */
+			restart_sge(&qp->s_sge, wqe, req->s_next_psn,
+				    qp->pmtu);
+			req->isge = 0;
+			req->state = TID_REQUEST_ACTIVE;
+		}
+
+		/*
+		 * Check sync. The last PSN of each generation is reserved for
+		 * RESYNC.
+		 */
+		if ((qpriv->flow_state.psn + npkts) > MAX_TID_FLOW_PSN - 1) {
+			req->state = TID_REQUEST_SYNC;
+			goto sync_check;
+		}
+
+		/* Allocate the flow if not yet */
+		if (hfi2_kern_setup_hw_flow(qpriv->rcd, qp))
+			goto done;
+
+		/*
+		 * The following call will advance req->setup_head after
+		 * allocating the tid entries.
+		 */
+		if (hfi2_kern_exp_rcv_setup(req, &qp->s_sge, &last)) {
+			req->state = TID_REQUEST_QUEUED;
+
+			/*
+			 * We don't have resources for this segment. The QP has
+			 * already been queued.
+			 */
+			goto done;
+		}
+	}
+
+	/* req->flow_idx should only be one slot behind req->setup_head */
+	flow = &req->flows[req->flow_idx];
+	flow->pkt = 0;
+	flow->tid_idx = 0;
+	flow->sent = 0;
+	if (!retry) {
+		/* Set the first and last IB PSN for the flow in use.*/
+		flow->flow_state.ib_spsn = req->s_next_psn;
+		flow->flow_state.ib_lpsn =
+			flow->flow_state.ib_spsn + flow->npkts - 1;
+	}
+
+	/* Calculate the next segment start psn.*/
+	req->s_next_psn += flow->npkts;
+
+	/* Build the packet header */
+	hdwords = hfi2_build_tid_rdma_read_packet(wqe, ohdr, bth1, bth2, len);
+done:
+	return hdwords;
+}
+
+/*
+ * Validate and accept the TID RDMA READ request parameters.
+ * Return 0 if the request is accepted successfully;
+ * Return 1 otherwise.
+ */
+static int tid_rdma_rcv_read_request(struct rvt_qp *qp,
+				     struct rvt_ack_entry *e,
+				     struct hfi2_packet *packet,
+				     struct ib_other_headers *ohdr,
+				     u32 bth0, u32 psn, u64 vaddr, u32 len)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	u32 flow_psn, i, tidlen = 0, pktlen, tlen;
+
+	req = ack_to_tid_req(e);
+
+	/* Validate the payload first */
+	flow = &req->flows[req->setup_head];
+
+	/* payload length = packet length - (header length + ICRC length) */
+	pktlen = packet->tlen - (packet->hlen + 4);
+	if (pktlen > sizeof(flow->tid_entry))
+		return 1;
+	memcpy(flow->tid_entry, packet->ebuf, pktlen);
+	flow->tidcnt = pktlen / sizeof(*flow->tid_entry);
+
+	/*
+	 * Walk the TID_ENTRY list to make sure we have enough space for a
+	 * complete segment. Also calculate the number of required packets.
+	 */
+	flow->npkts = rvt_div_round_up_mtu(qp, len);
+	for (i = 0; i < flow->tidcnt; i++) {
+		trace_hfi2_tid_entry_rcv_read_req(qp, i,
+						  flow->tid_entry[i]);
+		tlen = EXP_TID_GET(flow->tid_entry[i], LEN);
+		if (!tlen)
+			return 1;
+
+		/*
+		 * For tid pair (tidctr == 3), the buffer size of the pair
+		 * should be the sum of the buffer size described by each
+		 * tid entry. However, only the first entry needs to be
+		 * specified in the request (see WFR HAS Section 8.5.7.1).
+		 */
+		tidlen += tlen;
+	}
+	if (tidlen * PAGE_SIZE < len)
+		return 1;
+
+	/* Empty the flow array */
+	req->clear_tail = req->setup_head;
+	flow->pkt = 0;
+	flow->tid_idx = 0;
+	flow->tid_offset = 0;
+	flow->sent = 0;
+	flow->tid_qpn = be32_to_cpu(ohdr->u.tid_rdma.r_req.tid_flow_qp);
+	flow->idx = (flow->tid_qpn >> TID_RDMA_DESTQP_FLOW_SHIFT) &
+		    TID_RDMA_DESTQP_FLOW_MASK;
+	flow_psn = mask_psn(be32_to_cpu(ohdr->u.tid_rdma.r_req.tid_flow_psn));
+	flow->flow_state.generation = flow_psn >> HFI2_KDETH_BTH_SEQ_SHIFT;
+	flow->flow_state.spsn = flow_psn & HFI2_KDETH_BTH_SEQ_MASK;
+	flow->length = len;
+
+	flow->flow_state.lpsn = flow->flow_state.spsn +
+		flow->npkts - 1;
+	flow->flow_state.ib_spsn = psn;
+	flow->flow_state.ib_lpsn = flow->flow_state.ib_spsn + flow->npkts - 1;
+
+	trace_hfi2_tid_flow_rcv_read_req(qp, req->setup_head, flow);
+	/* Set the initial flow index to the current flow. */
+	req->flow_idx = req->setup_head;
+
+	/* advance circular buffer head */
+	req->setup_head = (req->setup_head + 1) & (MAX_FLOWS - 1);
+
+	/*
+	 * Compute last PSN for request.
+	 */
+	e->opcode = (bth0 >> 24) & 0xff;
+	e->psn = psn;
+	e->lpsn = psn + flow->npkts - 1;
+	e->sent = 0;
+
+	req->n_flows = qpriv->tid_rdma.local.max_read;
+	req->state = TID_REQUEST_ACTIVE;
+	req->cur_seg = 0;
+	req->comp_seg = 0;
+	req->ack_seg = 0;
+	req->isge = 0;
+	req->seg_len = qpriv->tid_rdma.local.max_len;
+	req->total_len = len;
+	req->total_segs = 1;
+	req->r_flow_psn = e->psn;
+
+	trace_hfi2_tid_req_rcv_read_req(qp, 0, e->opcode, e->psn, e->lpsn,
+					req);
+	return 0;
+}
+
+static int tid_rdma_rcv_error(struct hfi2_packet *packet,
+			      struct ib_other_headers *ohdr,
+			      struct rvt_qp *qp, u32 psn, int diff)
+{
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_ctxtdata *rcd = ((struct hfi2_qp_priv *)qp->priv)->rcd;
+	struct hfi2_ibdev *dev = to_idev(qp->ibqp.device);
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct rvt_ack_entry *e;
+	struct tid_rdma_request *req;
+	unsigned long flags;
+	u8 prev;
+	bool old_req;
+
+	trace_hfi2_rsp_tid_rcv_error(qp, psn);
+	trace_hfi2_tid_rdma_rcv_err(qp, 0, psn, diff);
+	if (diff > 0) {
+		/* sequence error */
+		if (!qp->r_nak_state) {
+			ibp->rvp.n_rc_seqnak++;
+			qp->r_nak_state = IB_NAK_PSN_ERROR;
+			qp->r_ack_psn = qp->r_psn;
+			rc_defered_ack(rcd, qp);
+		}
+		goto done;
+	}
+
+	ibp->rvp.n_rc_dupreq++;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	e = find_prev_entry(qp, psn, &prev, NULL, &old_req);
+	if (!e || (e->opcode != TID_OP(READ_REQ) &&
+		   e->opcode != TID_OP(WRITE_REQ)))
+		goto unlock;
+
+	req = ack_to_tid_req(e);
+	req->r_flow_psn = psn;
+	trace_hfi2_tid_req_rcv_err(qp, 0, e->opcode, e->psn, e->lpsn, req);
+	if (e->opcode == TID_OP(READ_REQ)) {
+		struct ib_reth *reth;
+		u32 len;
+		u32 rkey;
+		u64 vaddr;
+		int ok;
+		u32 bth0;
+
+		reth = &ohdr->u.tid_rdma.r_req.reth;
+		/*
+		 * The requester always restarts from the start of the original
+		 * request.
+		 */
+		len = be32_to_cpu(reth->length);
+		if (psn != e->psn || len != req->total_len)
+			goto unlock;
+
+		release_rdma_sge_mr(e);
+
+		rkey = be32_to_cpu(reth->rkey);
+		vaddr = get_ib_reth_vaddr(reth);
+
+		qp->r_len = len;
+		ok = rvt_rkey_ok(qp, &e->rdma_sge, len, vaddr, rkey,
+				 IB_ACCESS_REMOTE_READ);
+		if (unlikely(!ok))
+			goto unlock;
+
+		/*
+		 * If all the response packets for the current request have
+		 * been sent out and this request is complete (old_request
+		 * == false) and the TID flow may be unusable (the
+		 * req->clear_tail is advanced). However, when an earlier
+		 * request is received, this request will not be complete any
+		 * more (qp->s_tail_ack_queue is moved back, see below).
+		 * Consequently, we need to update the TID flow info every time
+		 * a duplicate request is received.
+		 */
+		bth0 = be32_to_cpu(ohdr->bth[0]);
+		if (tid_rdma_rcv_read_request(qp, e, packet, ohdr, bth0, psn,
+					      vaddr, len))
+			goto unlock;
+
+		/*
+		 * True if the request is already scheduled (between
+		 * qp->s_tail_ack_queue and qp->r_head_ack_queue);
+		 */
+		if (old_req)
+			goto unlock;
+	} else {
+		struct flow_state *fstate;
+		bool schedule = false;
+		u8 i;
+
+		if (req->state == TID_REQUEST_RESEND) {
+			req->state = TID_REQUEST_RESEND_ACTIVE;
+		} else if (req->state == TID_REQUEST_INIT_RESEND) {
+			req->state = TID_REQUEST_INIT;
+			schedule = true;
+		}
+
+		/*
+		 * True if the request is already scheduled (between
+		 * qp->s_tail_ack_queue and qp->r_head_ack_queue).
+		 * Also, don't change requests, which are at the SYNC
+		 * point and haven't generated any responses yet.
+		 * There is nothing to retransmit for them yet.
+		 */
+		if (old_req || req->state == TID_REQUEST_INIT ||
+		    (req->state == TID_REQUEST_SYNC && !req->cur_seg)) {
+			for (i = prev + 1; ; i++) {
+				if (i > rvt_size_atomic(&dev->rdi))
+					i = 0;
+				if (i == qp->r_head_ack_queue)
+					break;
+				e = &qp->s_ack_queue[i];
+				req = ack_to_tid_req(e);
+				if (e->opcode == TID_OP(WRITE_REQ) &&
+				    req->state == TID_REQUEST_INIT)
+					req->state = TID_REQUEST_INIT_RESEND;
+			}
+			/*
+			 * If the state of the request has been changed,
+			 * the first leg needs to get scheduled in order to
+			 * pick up the change. Otherwise, normal response
+			 * processing should take care of it.
+			 */
+			if (!schedule)
+				goto unlock;
+		}
+
+		/*
+		 * If there is no more allocated segment, just schedule the qp
+		 * without changing any state.
+		 */
+		if (req->clear_tail == req->setup_head)
+			goto schedule;
+		/*
+		 * If this request has sent responses for segments, which have
+		 * not received data yet (flow_idx != clear_tail), the flow_idx
+		 * pointer needs to be adjusted so the same responses can be
+		 * re-sent.
+		 */
+		if (CIRC_CNT(req->flow_idx, req->clear_tail, MAX_FLOWS)) {
+			fstate = &req->flows[req->clear_tail].flow_state;
+			qpriv->pending_tid_w_segs -=
+				CIRC_CNT(req->flow_idx, req->clear_tail,
+					 MAX_FLOWS);
+			req->flow_idx =
+				CIRC_ADD(req->clear_tail,
+					 delta_psn(psn, fstate->resp_ib_psn),
+					 MAX_FLOWS);
+			qpriv->pending_tid_w_segs +=
+				delta_psn(psn, fstate->resp_ib_psn);
+			/*
+			 * When flow_idx == setup_head, we've gotten a duplicate
+			 * request for a segment, which has not been allocated
+			 * yet. In that case, don't adjust this request.
+			 * However, we still want to go through the loop below
+			 * to adjust all subsequent requests.
+			 */
+			if (CIRC_CNT(req->setup_head, req->flow_idx,
+				     MAX_FLOWS)) {
+				req->cur_seg = delta_psn(psn, e->psn);
+				req->state = TID_REQUEST_RESEND_ACTIVE;
+			}
+		}
+
+		for (i = prev + 1; ; i++) {
+			/*
+			 * Look at everything up to and including
+			 * s_tail_ack_queue
+			 */
+			if (i > rvt_size_atomic(&dev->rdi))
+				i = 0;
+			if (i == qp->r_head_ack_queue)
+				break;
+			e = &qp->s_ack_queue[i];
+			req = ack_to_tid_req(e);
+			trace_hfi2_tid_req_rcv_err(qp, 0, e->opcode, e->psn,
+						   e->lpsn, req);
+			if (e->opcode != TID_OP(WRITE_REQ) ||
+			    req->cur_seg == req->comp_seg ||
+			    req->state == TID_REQUEST_INIT ||
+			    req->state == TID_REQUEST_INIT_RESEND) {
+				if (req->state == TID_REQUEST_INIT)
+					req->state = TID_REQUEST_INIT_RESEND;
+				continue;
+			}
+			qpriv->pending_tid_w_segs -=
+				CIRC_CNT(req->flow_idx,
+					 req->clear_tail,
+					 MAX_FLOWS);
+			req->flow_idx = req->clear_tail;
+			req->state = TID_REQUEST_RESEND;
+			req->cur_seg = req->comp_seg;
+		}
+		qpriv->s_flags &= ~HFI2_R_TID_WAIT_INTERLCK;
+	}
+	/* Re-process old requests.*/
+	if (qp->s_acked_ack_queue == qp->s_tail_ack_queue)
+		qp->s_acked_ack_queue = prev;
+	qp->s_tail_ack_queue = prev;
+	/*
+	 * Since the qp->s_tail_ack_queue is modified, the
+	 * qp->s_ack_state must be changed to re-initialize
+	 * qp->s_ack_rdma_sge; Otherwise, we will end up in
+	 * wrong memory region.
+	 */
+	qp->s_ack_state = OP(ACKNOWLEDGE);
+schedule:
+	/*
+	 * It's possible to receive a retry psn that is earlier than an RNRNAK
+	 * psn. In this case, the rnrnak state should be cleared.
+	 */
+	if (qpriv->rnr_nak_state) {
+		qp->s_nak_state = 0;
+		qpriv->rnr_nak_state = TID_RNR_NAK_INIT;
+		qp->r_psn = e->lpsn + 1;
+		hfi2_tid_write_alloc_resources(qp, true);
+	}
+
+	qp->r_state = e->opcode;
+	qp->r_nak_state = 0;
+	qp->s_flags |= RVT_S_RESP_PENDING;
+	hfi2_schedule_send(qp);
+unlock:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+done:
+	return 1;
+}
+
+void hfi2_rc_rcv_tid_rdma_read_req(struct hfi2_packet *packet)
+{
+	/* HANDLER FOR TID RDMA READ REQUEST packet (Responder side)*/
+
+	/*
+	 * 1. Verify TID RDMA READ REQ as per IB_OPCODE_RC_RDMA_READ
+	 *    (see hfi2_rc_rcv())
+	 * 2. Put TID RDMA READ REQ into the response queue (s_ack_queue)
+	 *     - Setup struct tid_rdma_req with request info
+	 *     - Initialize struct tid_rdma_flow info;
+	 *     - Copy TID entries;
+	 * 3. Set the qp->s_ack_state.
+	 * 4. Set RVT_S_RESP_PENDING in s_flags.
+	 * 5. Kick the send engine (hfi2_schedule_send())
+	 */
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_ack_entry *e;
+	unsigned long flags;
+	struct ib_reth *reth;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	u32 bth0, psn, len, rkey;
+	bool fecn;
+	u8 next;
+	u64 vaddr;
+	int diff;
+	u8 nack_state = IB_NAK_INVALID_REQUEST;
+
+	bth0 = be32_to_cpu(ohdr->bth[0]);
+	if (hfi2_ruc_check_hdr(ibp, packet))
+		return;
+
+	fecn = process_ecn(qp, packet);
+	psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+	trace_hfi2_rsp_rcv_tid_read_req(qp, psn);
+
+	if (qp->state == IB_QPS_RTR && !(qp->r_flags & RVT_R_COMM_EST))
+		rvt_comm_est(qp);
+
+	if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_READ)))
+		goto nack_inv;
+
+	reth = &ohdr->u.tid_rdma.r_req.reth;
+	vaddr = be64_to_cpu(reth->vaddr);
+	len = be32_to_cpu(reth->length);
+	/* The length needs to be in multiples of PAGE_SIZE */
+	if (!len || len & ~PAGE_MASK || len > qpriv->tid_rdma.local.max_len)
+		goto nack_inv;
+
+	diff = delta_psn(psn, qp->r_psn);
+	if (unlikely(diff)) {
+		tid_rdma_rcv_err(packet, ohdr, qp, psn, diff, fecn);
+		return;
+	}
+
+	/* We've verified the request, insert it into the ack queue. */
+	next = qp->r_head_ack_queue + 1;
+	if (next > rvt_size_atomic(ib_to_rvt(qp->ibqp.device)))
+		next = 0;
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (unlikely(next == qp->s_tail_ack_queue)) {
+		if (!qp->s_ack_queue[next].sent) {
+			nack_state = IB_NAK_REMOTE_OPERATIONAL_ERROR;
+			goto nack_inv_unlock;
+		}
+		update_ack_queue(qp, next);
+	}
+	e = &qp->s_ack_queue[qp->r_head_ack_queue];
+	release_rdma_sge_mr(e);
+
+	rkey = be32_to_cpu(reth->rkey);
+	qp->r_len = len;
+
+	if (unlikely(!rvt_rkey_ok(qp, &e->rdma_sge, qp->r_len, vaddr,
+				  rkey, IB_ACCESS_REMOTE_READ)))
+		goto nack_acc;
+
+	/* Accept the request parameters */
+	if (tid_rdma_rcv_read_request(qp, e, packet, ohdr, bth0, psn, vaddr,
+				      len))
+		goto nack_inv_unlock;
+
+	qp->r_state = e->opcode;
+	qp->r_nak_state = 0;
+	/*
+	 * We need to increment the MSN here instead of when we
+	 * finish sending the result since a duplicate request would
+	 * increment it more than once.
+	 */
+	qp->r_msn++;
+	qp->r_psn += e->lpsn - e->psn + 1;
+
+	qp->r_head_ack_queue = next;
+
+	/*
+	 * For all requests other than TID WRITE which are added to the ack
+	 * queue, qpriv->r_tid_alloc follows qp->r_head_ack_queue. It is ok to
+	 * do this because of interlocks between these and TID WRITE
+	 * requests. The same change has also been made in hfi2_rc_rcv().
+	 */
+	qpriv->r_tid_alloc = qp->r_head_ack_queue;
+
+	/* Schedule the send tasklet. */
+	qp->s_flags |= RVT_S_RESP_PENDING;
+	if (fecn)
+		qp->s_flags |= RVT_S_ECN;
+	hfi2_schedule_send(qp);
+
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	return;
+
+nack_inv_unlock:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+nack_inv:
+	rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
+	qp->r_nak_state = nack_state;
+	qp->r_ack_psn = qp->r_psn;
+	/* Queue NAK for later */
+	rc_defered_ack(rcd, qp);
+	return;
+nack_acc:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	rvt_rc_error(qp, IB_WC_LOC_PROT_ERR);
+	qp->r_nak_state = IB_NAK_REMOTE_ACCESS_ERROR;
+	qp->r_ack_psn = qp->r_psn;
+}
+
+u32 hfi2_build_tid_rdma_read_resp(struct rvt_qp *qp, struct rvt_ack_entry *e,
+				  struct ib_other_headers *ohdr, u32 *bth0,
+				  u32 *bth1, u32 *bth2, u32 *len, bool *last)
+{
+	struct hfi2_ack_priv *epriv = e->priv;
+	struct tid_rdma_request *req = &epriv->tid_req;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_rdma_flow *flow = &req->flows[req->clear_tail];
+	u32 tidentry = flow->tid_entry[flow->tid_idx];
+	u32 tidlen = EXP_TID_GET(tidentry, LEN) << PAGE_SHIFT;
+	struct tid_rdma_read_resp *resp = &ohdr->u.tid_rdma.r_rsp;
+	u32 next_offset, om = KDETH_OM_LARGE;
+	bool last_pkt;
+	u32 hdwords = 0;
+	struct tid_rdma_params *remote;
+
+	*len = min_t(u32, qp->pmtu, tidlen - flow->tid_offset);
+	flow->sent += *len;
+	next_offset = flow->tid_offset + *len;
+	last_pkt = (flow->sent >= flow->length);
+
+	trace_hfi2_tid_entry_build_read_resp(qp, flow->tid_idx, tidentry);
+	trace_hfi2_tid_flow_build_read_resp(qp, req->clear_tail, flow);
+
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+	if (!remote) {
+		rcu_read_unlock();
+		goto done;
+	}
+	KDETH_RESET(resp->kdeth0, KVER, 0x1);
+	KDETH_SET(resp->kdeth0, SH, !last_pkt);
+	KDETH_SET(resp->kdeth0, INTR, !!(!last_pkt && remote->urg));
+	KDETH_SET(resp->kdeth0, TIDCTRL, EXP_TID_GET(tidentry, CTRL));
+	KDETH_SET(resp->kdeth0, TID, EXP_TID_GET(tidentry, IDX));
+	KDETH_SET(resp->kdeth0, OM, om == KDETH_OM_LARGE);
+	KDETH_SET(resp->kdeth0, OFFSET, flow->tid_offset / om);
+	KDETH_RESET(resp->kdeth1, JKEY, remote->jkey);
+	resp->verbs_qp = cpu_to_be32(qp->remote_qpn);
+	rcu_read_unlock();
+
+	resp->aeth = rvt_compute_aeth(qp);
+	resp->verbs_psn = cpu_to_be32(mask_psn(flow->flow_state.ib_spsn +
+					       flow->pkt));
+
+	*bth0 = TID_OP(READ_RESP) << 24;
+	*bth1 = flow->tid_qpn;
+	*bth2 = mask_psn(((flow->flow_state.spsn + flow->pkt++) &
+			  HFI2_KDETH_BTH_SEQ_MASK) |
+			 (flow->flow_state.generation <<
+			  HFI2_KDETH_BTH_SEQ_SHIFT));
+	*last = last_pkt;
+	if (last_pkt)
+		/* Advance to next flow */
+		req->clear_tail = (req->clear_tail + 1) &
+				  (MAX_FLOWS - 1);
+
+	if (next_offset >= tidlen) {
+		flow->tid_offset = 0;
+		flow->tid_idx++;
+	} else {
+		flow->tid_offset = next_offset;
+	}
+
+	hdwords = sizeof(ohdr->u.tid_rdma.r_rsp) / sizeof(u32);
+
+done:
+	return hdwords;
+}
+
+static inline struct tid_rdma_request *
+find_tid_request(struct rvt_qp *qp, u32 psn, enum ib_wr_opcode opcode)
+	__must_hold(&qp->s_lock)
+{
+	struct rvt_swqe *wqe;
+	struct tid_rdma_request *req = NULL;
+	u32 i, end;
+
+	end = qp->s_cur + 1;
+	if (end == qp->s_size)
+		end = 0;
+	for (i = qp->s_acked; i != end;) {
+		wqe = rvt_get_swqe_ptr(qp, i);
+		if (cmp_psn(psn, wqe->psn) >= 0 &&
+		    cmp_psn(psn, wqe->lpsn) <= 0) {
+			if (wqe->wr.opcode == opcode)
+				req = wqe_to_tid_req(wqe);
+			break;
+		}
+		if (++i == qp->s_size)
+			i = 0;
+	}
+
+	return req;
+}
+
+void hfi2_rc_rcv_tid_rdma_read_resp(struct hfi2_packet *packet)
+{
+	/* HANDLER FOR TID RDMA READ RESPONSE packet (Requester side) */
+
+	/*
+	 * 1. Find matching SWQE
+	 * 2. Check that the entire segment has been read.
+	 * 3. Remove HFI2_S_WAIT_TID_RESP from s_flags.
+	 * 4. Free the TID flow resources.
+	 * 5. Kick the send engine (hfi2_schedule_send())
+	 */
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	u32 opcode, aeth;
+	bool fecn;
+	unsigned long flags;
+	u32 kpsn, ipsn;
+
+	trace_hfi2_sender_rcv_tid_read_resp(qp);
+	fecn = process_ecn(qp, packet);
+	kpsn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+	aeth = be32_to_cpu(ohdr->u.tid_rdma.r_rsp.aeth);
+	opcode = (be32_to_cpu(ohdr->bth[0]) >> 24) & 0xff;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	ipsn = mask_psn(be32_to_cpu(ohdr->u.tid_rdma.r_rsp.verbs_psn));
+	req = find_tid_request(qp, ipsn, IB_WR_TID_RDMA_READ);
+	if (unlikely(!req))
+		goto ack_op_err;
+
+	flow = &req->flows[req->clear_tail];
+	/* When header suppression is disabled */
+	if (cmp_psn(ipsn, flow->flow_state.ib_lpsn)) {
+		update_r_next_psn_fecn(packet, priv, rcd, flow, fecn);
+
+		if (cmp_psn(kpsn, flow->flow_state.r_next_psn))
+			goto ack_done;
+		flow->flow_state.r_next_psn = mask_psn(kpsn + 1);
+		/*
+		 * Copy the payload to destination buffer if this packet is
+		 * delivered as an eager packet due to RSM rule and FECN.
+		 * The RSM rule selects FECN bit in BTH and SH bit in
+		 * KDETH header and therefore will not match the last
+		 * packet of each segment that has SH bit cleared.
+		 */
+		if (fecn && packet->etype == RHF_RCV_TYPE_EAGER) {
+			struct rvt_sge_state ss;
+			u32 len;
+			u32 tlen = packet->tlen;
+			u16 hdrsize = packet->hlen;
+			u8 pad = packet->pad;
+			u8 extra_bytes = pad + packet->extra_byte +
+				(SIZE_OF_CRC << 2);
+			u32 pmtu = qp->pmtu;
+
+			if (unlikely(tlen != (hdrsize + pmtu + extra_bytes)))
+				goto ack_op_err;
+			len = restart_sge(&ss, req->e.swqe, ipsn, pmtu);
+			if (unlikely(len < pmtu))
+				goto ack_op_err;
+			rvt_copy_sge(qp, &ss, packet->payload, pmtu, false,
+				     false);
+			/* Raise the sw sequence check flag for next packet */
+			priv->s_flags |= HFI2_R_TID_SW_PSN;
+		}
+
+		goto ack_done;
+	}
+	flow->flow_state.r_next_psn = mask_psn(kpsn + 1);
+	req->ack_pending--;
+	priv->pending_tid_r_segs--;
+	qp->s_num_rd_atomic--;
+	if ((qp->s_flags & RVT_S_WAIT_FENCE) &&
+	    !qp->s_num_rd_atomic) {
+		qp->s_flags &= ~(RVT_S_WAIT_FENCE |
+				 RVT_S_WAIT_ACK);
+		hfi2_schedule_send(qp);
+	}
+	if (qp->s_flags & RVT_S_WAIT_RDMAR) {
+		qp->s_flags &= ~(RVT_S_WAIT_RDMAR | RVT_S_WAIT_ACK);
+		hfi2_schedule_send(qp);
+	}
+
+	trace_hfi2_ack(qp, ipsn);
+	trace_hfi2_tid_req_rcv_read_resp(qp, 0, req->e.swqe->wr.opcode,
+					 req->e.swqe->psn, req->e.swqe->lpsn,
+					 req);
+	trace_hfi2_tid_flow_rcv_read_resp(qp, req->clear_tail, flow);
+
+	/* Release the tid resources */
+	hfi2_kern_exp_rcv_clear(req);
+
+	if (!do_rc_ack(qp, aeth, ipsn, opcode, 0, rcd))
+		goto ack_done;
+
+	/* If not done yet, build next read request */
+	if (++req->comp_seg >= req->total_segs) {
+		priv->tid_r_comp++;
+		req->state = TID_REQUEST_COMPLETE;
+	}
+
+	/*
+	 * Clear the hw flow under two conditions:
+	 * 1. This request is a sync point and it is complete;
+	 * 2. Current request is completed and there are no more requests.
+	 */
+	if ((req->state == TID_REQUEST_SYNC &&
+	     req->comp_seg == req->cur_seg) ||
+	    priv->tid_r_comp == priv->tid_r_reqs) {
+		hfi2_kern_clear_hw_flow(priv->rcd, qp);
+		priv->s_flags &= ~HFI2_R_TID_SW_PSN;
+		if (req->state == TID_REQUEST_SYNC)
+			req->state = TID_REQUEST_ACTIVE;
+	}
+
+	hfi2_schedule_send(qp);
+	goto ack_done;
+
+ack_op_err:
+	/*
+	 * The test indicates that the send engine has finished its cleanup
+	 * after sending the request and it's now safe to put the QP into error
+	 * state. However, if the wqe queue is empty (qp->s_acked == qp->s_tail
+	 * == qp->s_head), it would be unsafe to complete the wqe pointed by
+	 * qp->s_acked here. Putting the qp into error state will safely flush
+	 * all remaining requests.
+	 */
+	if (qp->s_last == qp->s_acked)
+		rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+
+ack_done:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+}
+
+void hfi2_kern_read_tid_flow_free(struct rvt_qp *qp)
+	__must_hold(&qp->s_lock)
+{
+	u32 n = qp->s_acked;
+	struct rvt_swqe *wqe;
+	struct tid_rdma_request *req;
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	lockdep_assert_held(&qp->s_lock);
+	/* Free any TID entries */
+	while (n != qp->s_tail) {
+		wqe = rvt_get_swqe_ptr(qp, n);
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_READ) {
+			req = wqe_to_tid_req(wqe);
+			hfi2_kern_exp_rcv_clear_all(req);
+		}
+
+		if (++n == qp->s_size)
+			n = 0;
+	}
+	/* Free flow */
+	hfi2_kern_clear_hw_flow(priv->rcd, qp);
+}
+
+static bool tid_rdma_tid_err(struct hfi2_packet *packet, u8 rcv_type)
+{
+	struct rvt_qp *qp = packet->qp;
+
+	if (rcv_type >= RHF_RCV_TYPE_IB)
+		goto done;
+
+	spin_lock(&qp->s_lock);
+
+	/*
+	 * We've ran out of space in the eager buffer.
+	 * Eagerly received KDETH packets which require space in the
+	 * Eager buffer (packet that have payload) are TID RDMA WRITE
+	 * response packets. In this case, we have to re-transmit the
+	 * TID RDMA WRITE request.
+	 */
+	if (rcv_type == RHF_RCV_TYPE_EAGER) {
+		hfi2_restart_rc(qp, qp->s_last_psn + 1, 1);
+		hfi2_schedule_send(qp);
+	}
+
+	/* Since no payload is delivered, just drop the packet */
+	spin_unlock(&qp->s_lock);
+done:
+	return true;
+}
+
+static void restart_tid_rdma_read_req(struct hfi2_ctxtdata *rcd,
+				      struct rvt_qp *qp, struct rvt_swqe *wqe)
+{
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+
+	/* Start from the right segment */
+	qp->r_flags |= RVT_R_RDMAR_SEQ;
+	req = wqe_to_tid_req(wqe);
+	flow = &req->flows[req->clear_tail];
+	hfi2_restart_rc(qp, flow->flow_state.ib_spsn, 0);
+	if (list_empty(&qp->rspwait)) {
+		qp->r_flags |= RVT_R_RSP_SEND;
+		rvt_get_qp(qp);
+		list_add_tail(&qp->rspwait, &rcd->qp_wait_list);
+	}
+}
+
+/*
+ * Handle the KDETH eflags for TID RDMA READ response.
+ *
+ * Return true if the last packet for a segment has been received and it is
+ * time to process the response normally; otherwise, return true.
+ *
+ * The caller must hold the packet->qp->r_lock and the rcu_read_lock.
+ */
+static bool handle_read_kdeth_eflags(struct hfi2_ctxtdata *rcd,
+				     struct hfi2_packet *packet, u8 rcv_type,
+				     u8 rte, u32 psn, u32 ibpsn)
+	__must_hold(&packet->qp->r_lock) __must_hold(RCU)
+{
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	struct hfi2_devdata *dd = ppd->dd;
+	struct hfi2_ibport *ibp;
+	struct rvt_swqe *wqe;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	u32 ack_psn;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_qp_priv *priv = qp->priv;
+	bool ret = true;
+	int diff = 0;
+	u32 fpsn;
+
+	lockdep_assert_held(&qp->r_lock);
+	trace_hfi2_rsp_read_kdeth_eflags(qp, ibpsn);
+	trace_hfi2_sender_read_kdeth_eflags(qp);
+	trace_hfi2_tid_read_sender_kdeth_eflags(qp, 0);
+	spin_lock(&qp->s_lock);
+	/* If the psn is out of valid range, drop the packet */
+	if (cmp_psn(ibpsn, qp->s_last_psn) < 0 ||
+	    cmp_psn(ibpsn, qp->s_psn) > 0)
+		goto s_unlock;
+
+	/*
+	 * Note that NAKs implicitly ACK outstanding SEND and RDMA write
+	 * requests and implicitly NAK RDMA read and atomic requests issued
+	 * before the NAK'ed request.
+	 */
+	ack_psn = ibpsn - 1;
+	wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+
+	/* Complete WQEs that the PSN finishes. */
+	while ((int)delta_psn(ack_psn, wqe->lpsn) >= 0) {
+		/*
+		 * If this request is a RDMA read or atomic, and the NACK is
+		 * for a later operation, this NACK NAKs the RDMA read or
+		 * atomic.
+		 */
+		if (wqe->wr.opcode == IB_WR_RDMA_READ ||
+		    wqe->wr.opcode == IB_WR_TID_RDMA_READ ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_CMP_AND_SWP ||
+		    wqe->wr.opcode == IB_WR_ATOMIC_FETCH_AND_ADD) {
+			/* Retry this request. */
+			if (!(qp->r_flags & RVT_R_RDMAR_SEQ)) {
+				qp->r_flags |= RVT_R_RDMAR_SEQ;
+				if (wqe->wr.opcode == IB_WR_TID_RDMA_READ) {
+					restart_tid_rdma_read_req(rcd, qp,
+								  wqe);
+				} else {
+					hfi2_restart_rc(qp, qp->s_last_psn + 1,
+							0);
+					if (list_empty(&qp->rspwait)) {
+						qp->r_flags |= RVT_R_RSP_SEND;
+						rvt_get_qp(qp);
+						list_add_tail(/* wait */
+						   &qp->rspwait,
+						   &rcd->qp_wait_list);
+					}
+				}
+			}
+			/*
+			 * No need to process the NAK since we are
+			 * restarting an earlier request.
+			 */
+			break;
+		}
+
+		wqe = do_rc_completion(qp, wqe, ibp);
+		if (qp->s_acked == qp->s_tail)
+			goto s_unlock;
+	}
+
+	if (qp->s_acked == qp->s_tail)
+		goto s_unlock;
+
+	/* Handle the eflags for the request */
+	if (wqe->wr.opcode != IB_WR_TID_RDMA_READ)
+		goto s_unlock;
+
+	req = wqe_to_tid_req(wqe);
+	trace_hfi2_tid_req_read_kdeth_eflags(qp, 0, wqe->wr.opcode, wqe->psn,
+					     wqe->lpsn, req);
+	switch (rcv_type) {
+	case RHF_RCV_TYPE_EXPECTED:
+		switch (rte) {
+		case RHF_RTE_EXPECTED_FLOW_SEQ_ERR:
+			/*
+			 * On the first occurrence of a Flow Sequence error,
+			 * the flag TID_FLOW_SW_PSN is set.
+			 *
+			 * After that, the flow is *not* reprogrammed and the
+			 * protocol falls back to SW PSN checking. This is done
+			 * to prevent continuous Flow Sequence errors for any
+			 * packets that could be still in the fabric.
+			 */
+			flow = &req->flows[req->clear_tail];
+			trace_hfi2_tid_flow_read_kdeth_eflags(qp,
+							      req->clear_tail,
+							      flow);
+			if (priv->s_flags & HFI2_R_TID_SW_PSN) {
+				diff = cmp_psn(psn,
+					       flow->flow_state.r_next_psn);
+				if (diff > 0) {
+					/* Drop the packet.*/
+					goto s_unlock;
+				} else if (diff < 0) {
+					/*
+					 * If a response packet for a restarted
+					 * request has come back, reset the
+					 * restart flag.
+					 */
+					if (qp->r_flags & RVT_R_RDMAR_SEQ)
+						qp->r_flags &=
+							~RVT_R_RDMAR_SEQ;
+
+					/* Drop the packet.*/
+					goto s_unlock;
+				}
+
+				/*
+				 * If SW PSN verification is successful and
+				 * this is the last packet in the segment, tell
+				 * the caller to process it as a normal packet.
+				 */
+				fpsn = full_flow_psn(flow,
+						     flow->flow_state.lpsn);
+				if (cmp_psn(fpsn, psn) == 0) {
+					ret = false;
+					if (qp->r_flags & RVT_R_RDMAR_SEQ)
+						qp->r_flags &=
+							~RVT_R_RDMAR_SEQ;
+				}
+				flow->flow_state.r_next_psn =
+					mask_psn(psn + 1);
+			} else {
+				u32 last_psn;
+
+				last_psn = read_r_next_psn(dd, rcd->ctxt,
+							   flow->idx);
+				flow->flow_state.r_next_psn = last_psn;
+				priv->s_flags |= HFI2_R_TID_SW_PSN;
+				/*
+				 * If no request has been restarted yet,
+				 * restart the current one.
+				 */
+				if (!(qp->r_flags & RVT_R_RDMAR_SEQ))
+					restart_tid_rdma_read_req(rcd, qp,
+								  wqe);
+			}
+
+			break;
+
+		case RHF_RTE_EXPECTED_FLOW_GEN_ERR:
+			/*
+			 * Since the TID flow is able to ride through
+			 * generation mismatch, drop this stale packet.
+			 */
+			break;
+
+		default:
+			break;
+		}
+		break;
+
+	case RHF_RCV_TYPE_ERROR:
+		switch (rte) {
+		case RHF_RTE_ERROR_OP_CODE_ERR:
+		case RHF_RTE_ERROR_KHDR_MIN_LEN_ERR:
+		case RHF_RTE_ERROR_KHDR_HCRC_ERR:
+		case RHF_RTE_ERROR_KHDR_KVER_ERR:
+		case RHF_RTE_ERROR_CONTEXT_ERR:
+		case RHF_RTE_ERROR_KHDR_TID_ERR:
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+s_unlock:
+	spin_unlock(&qp->s_lock);
+	return ret;
+}
+
+bool hfi2_handle_kdeth_eflags(struct hfi2_ctxtdata *rcd,
+			      struct hfi2_pportdata *ppd,
+			      struct hfi2_packet *packet)
+{
+	struct hfi2_ibport *ibp = &ppd->ibport_data;
+	struct hfi2_devdata *dd = ppd->dd;
+	struct rvt_dev_info *rdi = &dd->verbs_dev.rdi;
+	u8 rcv_type = rhf_rcv_type(packet->rhf);
+	u8 rte = rhe_rcv_type_err(packet);
+	struct ib_header *hdr = packet->hdr;
+	struct ib_other_headers *ohdr = NULL;
+	int lnh = be16_to_cpu(hdr->lrh[0]) & 3;
+	u16 lid  = be16_to_cpu(hdr->lrh[1]);
+	u8 opcode;
+	u32 qp_num, psn, ibpsn;
+	struct rvt_qp *qp;
+	struct hfi2_qp_priv *qpriv;
+	unsigned long flags;
+	bool ret = true;
+	struct rvt_ack_entry *e;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	int diff = 0;
+
+	trace_hfi2_msg_handle_kdeth_eflags(NULL, "Kdeth error: rhf ",
+					   packet->rhf);
+	if (rhe_icrc_err(packet))
+		return ret;
+
+	packet->ohdr = &hdr->u.oth;
+	ohdr = packet->ohdr;
+	trace_input_ibhdr(rcd->dd, packet, packet->sc4);
+
+	/* Get the destination QP number. */
+	qp_num = be32_to_cpu(ohdr->u.tid_rdma.r_rsp.verbs_qp) &
+		RVT_QPN_MASK;
+	if (lid >= be16_to_cpu(IB_MULTICAST_LID_BASE))
+		goto drop;
+
+	psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+	opcode = (be32_to_cpu(ohdr->bth[0]) >> 24) & 0xff;
+
+	rcu_read_lock();
+	qp = rvt_lookup_qpn(rdi, &ibp->rvp, qp_num);
+	if (!qp)
+		goto rcu_unlock;
+
+	packet->qp = qp;
+
+	/* Check for valid receive state. */
+	spin_lock_irqsave(&qp->r_lock, flags);
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK)) {
+		ibp->rvp.n_pkt_drops++;
+		goto r_unlock;
+	}
+
+	if (rhe_tid_err(packet)) {
+		/* For TIDERR and RC QPs preemptively schedule a NAK */
+		u32 tlen = rhf_pkt_len(packet->rhf); /* in bytes */
+
+		/* Sanity check packet */
+		if (tlen < 24)
+			goto r_unlock;
+
+		/*
+		 * Check for GRH. We should never get packets with GRH in this
+		 * path.
+		 */
+		if (lnh == HFI2_LRH_GRH)
+			goto r_unlock;
+
+		if (tid_rdma_tid_err(packet, rcv_type))
+			goto r_unlock;
+	}
+
+	/* handle TID RDMA READ */
+	if (opcode == TID_OP(READ_RESP)) {
+		ibpsn = be32_to_cpu(ohdr->u.tid_rdma.r_rsp.verbs_psn);
+		ibpsn = mask_psn(ibpsn);
+		ret = handle_read_kdeth_eflags(rcd, packet, rcv_type, rte, psn,
+					       ibpsn);
+		goto r_unlock;
+	}
+
+	/*
+	 * qp->s_tail_ack_queue points to the rvt_ack_entry currently being
+	 * processed. These a completed sequentially so we can be sure that
+	 * the pointer will not change until the entire request has completed.
+	 */
+	spin_lock(&qp->s_lock);
+	qpriv = qp->priv;
+	if (qpriv->r_tid_tail == HFI2_QP_WQE_INVALID ||
+	    qpriv->r_tid_tail == qpriv->r_tid_head)
+		goto unlock;
+	e = &qp->s_ack_queue[qpriv->r_tid_tail];
+	if (e->opcode != TID_OP(WRITE_REQ))
+		goto unlock;
+	req = ack_to_tid_req(e);
+	if (req->comp_seg == req->cur_seg)
+		goto unlock;
+	flow = &req->flows[req->clear_tail];
+	trace_hfi2_eflags_err_write(qp, rcv_type, rte, psn);
+	trace_hfi2_rsp_handle_kdeth_eflags(qp, psn);
+	trace_hfi2_tid_write_rsp_handle_kdeth_eflags(qp);
+	trace_hfi2_tid_req_handle_kdeth_eflags(qp, 0, e->opcode, e->psn,
+					       e->lpsn, req);
+	trace_hfi2_tid_flow_handle_kdeth_eflags(qp, req->clear_tail, flow);
+
+	switch (rcv_type) {
+	case RHF_RCV_TYPE_EXPECTED:
+		switch (rte) {
+		case RHF_RTE_EXPECTED_FLOW_SEQ_ERR:
+			if (!(qpriv->s_flags & HFI2_R_TID_SW_PSN)) {
+				qpriv->s_flags |= HFI2_R_TID_SW_PSN;
+				flow->flow_state.r_next_psn =
+					read_r_next_psn(dd, rcd->ctxt,
+							flow->idx);
+				qpriv->r_next_psn_kdeth =
+					flow->flow_state.r_next_psn;
+				goto nak_psn;
+			} else {
+				/*
+				 * If the received PSN does not match the next
+				 * expected PSN, NAK the packet.
+				 * However, only do that if we know that the a
+				 * NAK has already been sent. Otherwise, this
+				 * mismatch could be due to packets that were
+				 * already in flight.
+				 */
+				diff = cmp_psn(psn,
+					       flow->flow_state.r_next_psn);
+				if (diff > 0)
+					goto nak_psn;
+				else if (diff < 0)
+					break;
+
+				qpriv->s_nak_state = 0;
+				/*
+				 * If SW PSN verification is successful and this
+				 * is the last packet in the segment, tell the
+				 * caller to process it as a normal packet.
+				 */
+				if (psn == full_flow_psn(flow,
+							 flow->flow_state.lpsn))
+					ret = false;
+				flow->flow_state.r_next_psn =
+					mask_psn(psn + 1);
+				qpriv->r_next_psn_kdeth =
+					flow->flow_state.r_next_psn;
+			}
+			break;
+
+		case RHF_RTE_EXPECTED_FLOW_GEN_ERR:
+			goto nak_psn;
+
+		default:
+			break;
+		}
+		break;
+
+	case RHF_RCV_TYPE_ERROR:
+		switch (rte) {
+		case RHF_RTE_ERROR_OP_CODE_ERR:
+		case RHF_RTE_ERROR_KHDR_MIN_LEN_ERR:
+		case RHF_RTE_ERROR_KHDR_HCRC_ERR:
+		case RHF_RTE_ERROR_KHDR_KVER_ERR:
+		case RHF_RTE_ERROR_CONTEXT_ERR:
+		case RHF_RTE_ERROR_KHDR_TID_ERR:
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+unlock:
+	spin_unlock(&qp->s_lock);
+r_unlock:
+	spin_unlock_irqrestore(&qp->r_lock, flags);
+rcu_unlock:
+	rcu_read_unlock();
+drop:
+	return ret;
+nak_psn:
+	ibp->rvp.n_rc_seqnak++;
+	if (!qpriv->s_nak_state) {
+		qpriv->s_nak_state = IB_NAK_PSN_ERROR;
+		/* We are NAK'ing the next expected PSN */
+		qpriv->s_nak_psn = mask_psn(flow->flow_state.r_next_psn);
+		tid_rdma_trigger_ack(qp);
+	}
+	goto unlock;
+}
+
+/*
+ * "Rewind" the TID request information.
+ * This means that we reset the state back to ACTIVE,
+ * find the proper flow, set the flow index to that flow,
+ * and reset the flow information.
+ */
+void hfi2_tid_rdma_restart_req(struct rvt_qp *qp, struct rvt_swqe *wqe,
+			       u32 *bth2)
+{
+	struct tid_rdma_request *req = wqe_to_tid_req(wqe);
+	struct tid_rdma_flow *flow;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	int diff, delta_pkts;
+	u32 tididx = 0, i;
+	u16 fidx;
+
+	if (wqe->wr.opcode == IB_WR_TID_RDMA_READ) {
+		*bth2 = mask_psn(qp->s_psn);
+		flow = find_flow_ib(req, *bth2, &fidx);
+		if (!flow) {
+			trace_hfi2_msg_tid_restart_req(/* msg */
+			   qp, "!!!!!! Could not find flow to restart: bth2 ",
+			   (u64)*bth2);
+			trace_hfi2_tid_req_restart_req(qp, 0, wqe->wr.opcode,
+						       wqe->psn, wqe->lpsn,
+						       req);
+			return;
+		}
+	} else {
+		fidx = req->acked_tail;
+		flow = &req->flows[fidx];
+		*bth2 = mask_psn(req->r_ack_psn);
+	}
+
+	if (wqe->wr.opcode == IB_WR_TID_RDMA_READ)
+		delta_pkts = delta_psn(*bth2, flow->flow_state.ib_spsn);
+	else
+		delta_pkts = delta_psn(*bth2,
+				       full_flow_psn(flow,
+						     flow->flow_state.spsn));
+
+	trace_hfi2_tid_flow_restart_req(qp, fidx, flow);
+	diff = delta_pkts + flow->resync_npkts;
+
+	flow->sent = 0;
+	flow->pkt = 0;
+	flow->tid_idx = 0;
+	flow->tid_offset = 0;
+	if (diff) {
+		for (tididx = 0; tididx < flow->tidcnt; tididx++) {
+			u32 tidentry = flow->tid_entry[tididx], tidlen,
+				tidnpkts, npkts;
+
+			flow->tid_offset = 0;
+			tidlen = EXP_TID_GET(tidentry, LEN) * PAGE_SIZE;
+			tidnpkts = rvt_div_round_up_mtu(qp, tidlen);
+			npkts = min_t(u32, diff, tidnpkts);
+			flow->pkt += npkts;
+			flow->sent += (npkts == tidnpkts ? tidlen :
+				       npkts * qp->pmtu);
+			flow->tid_offset += npkts * qp->pmtu;
+			diff -= npkts;
+			if (!diff)
+				break;
+		}
+	}
+	if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE) {
+		rvt_skip_sge(&qpriv->tid_ss, (req->cur_seg * req->seg_len) +
+			     flow->sent, 0);
+		/*
+		 * Packet PSN is based on flow_state.spsn + flow->pkt. However,
+		 * during a RESYNC, the generation is incremented and the
+		 * sequence is reset to 0. Since we've adjusted the npkts in the
+		 * flow and the SGE has been sufficiently advanced, we have to
+		 * adjust flow->pkt in order to calculate the correct PSN.
+		 */
+		flow->pkt -= flow->resync_npkts;
+	}
+
+	if (flow->tid_offset ==
+	    EXP_TID_GET(flow->tid_entry[tididx], LEN) * PAGE_SIZE) {
+		tididx++;
+		flow->tid_offset = 0;
+	}
+	flow->tid_idx = tididx;
+	if (wqe->wr.opcode == IB_WR_TID_RDMA_READ)
+		/* Move flow_idx to correct index */
+		req->flow_idx = fidx;
+	else
+		req->clear_tail = fidx;
+
+	trace_hfi2_tid_flow_restart_req(qp, fidx, flow);
+	trace_hfi2_tid_req_restart_req(qp, 0, wqe->wr.opcode, wqe->psn,
+				       wqe->lpsn, req);
+	req->state = TID_REQUEST_ACTIVE;
+	if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE) {
+		/* Reset all the flows that we are going to resend */
+		fidx = CIRC_NEXT(fidx, MAX_FLOWS);
+		i = qpriv->s_tid_tail;
+		do {
+			for (; CIRC_CNT(req->setup_head, fidx, MAX_FLOWS);
+			      fidx = CIRC_NEXT(fidx, MAX_FLOWS)) {
+				req->flows[fidx].sent = 0;
+				req->flows[fidx].pkt = 0;
+				req->flows[fidx].tid_idx = 0;
+				req->flows[fidx].tid_offset = 0;
+				req->flows[fidx].resync_npkts = 0;
+			}
+			if (i == qpriv->s_tid_cur)
+				break;
+			do {
+				i = (++i == qp->s_size ? 0 : i);
+				wqe = rvt_get_swqe_ptr(qp, i);
+			} while (wqe->wr.opcode != IB_WR_TID_RDMA_WRITE);
+			req = wqe_to_tid_req(wqe);
+			req->cur_seg = req->ack_seg;
+			fidx = req->acked_tail;
+			/* Pull req->clear_tail back */
+			req->clear_tail = fidx;
+		} while (1);
+	}
+}
+
+void hfi2_qp_kern_exp_rcv_clear_all(struct rvt_qp *qp)
+{
+	int i, ret;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_flow_state *fs;
+
+	if (qp->ibqp.qp_type != IB_QPT_RC || !HFI2_CAP_IS_KSET(TID_RDMA))
+		return;
+
+	/*
+	 * First, clear the flow to help prevent any delayed packets from
+	 * being delivered.
+	 */
+	fs = &qpriv->flow_state;
+	if (fs->index != RXE_NUM_TID_FLOWS)
+		hfi2_kern_clear_hw_flow(qpriv->rcd, qp);
+
+	for (i = qp->s_acked; i != qp->s_head;) {
+		struct rvt_swqe *wqe = rvt_get_swqe_ptr(qp, i);
+
+		if (++i == qp->s_size)
+			i = 0;
+		/* Free only locally allocated TID entries */
+		if (wqe->wr.opcode != IB_WR_TID_RDMA_READ)
+			continue;
+		do {
+			struct hfi2_swqe_priv *priv = wqe->priv;
+
+			ret = hfi2_kern_exp_rcv_clear(&priv->tid_req);
+		} while (!ret);
+	}
+	for (i = qp->s_acked_ack_queue; i != qp->r_head_ack_queue;) {
+		struct rvt_ack_entry *e = &qp->s_ack_queue[i];
+
+		if (++i == rvt_max_atomic(ib_to_rvt(qp->ibqp.device)))
+			i = 0;
+		/* Free only locally allocated TID entries */
+		if (e->opcode != TID_OP(WRITE_REQ))
+			continue;
+		do {
+			struct hfi2_ack_priv *priv = e->priv;
+
+			ret = hfi2_kern_exp_rcv_clear(&priv->tid_req);
+		} while (!ret);
+	}
+}
+
+bool hfi2_tid_rdma_wqe_interlock(struct rvt_qp *qp, struct rvt_swqe *wqe)
+{
+	struct rvt_swqe *prev;
+	struct hfi2_qp_priv *priv = qp->priv;
+	u32 s_prev;
+	struct tid_rdma_request *req;
+
+	s_prev = (qp->s_cur == 0 ? qp->s_size : qp->s_cur) - 1;
+	prev = rvt_get_swqe_ptr(qp, s_prev);
+
+	switch (wqe->wr.opcode) {
+	case IB_WR_SEND:
+	case IB_WR_SEND_WITH_IMM:
+	case IB_WR_SEND_WITH_INV:
+	case IB_WR_ATOMIC_CMP_AND_SWP:
+	case IB_WR_ATOMIC_FETCH_AND_ADD:
+	case IB_WR_RDMA_WRITE:
+	case IB_WR_RDMA_WRITE_WITH_IMM:
+		switch (prev->wr.opcode) {
+		case IB_WR_TID_RDMA_WRITE:
+			req = wqe_to_tid_req(prev);
+			if (req->ack_seg != req->total_segs)
+				goto interlock;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IB_WR_RDMA_READ:
+		if (prev->wr.opcode != IB_WR_TID_RDMA_WRITE)
+			break;
+		fallthrough;
+	case IB_WR_TID_RDMA_READ:
+		switch (prev->wr.opcode) {
+		case IB_WR_RDMA_READ:
+			if (qp->s_acked != qp->s_cur)
+				goto interlock;
+			break;
+		case IB_WR_TID_RDMA_WRITE:
+			req = wqe_to_tid_req(prev);
+			if (req->ack_seg != req->total_segs)
+				goto interlock;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+	return false;
+
+interlock:
+	priv->s_flags |= HFI2_S_TID_WAIT_INTERLCK;
+	return true;
+}
+
+/* Does @sge meet the alignment requirements for tid rdma? */
+static inline bool hfi2_check_sge_align(struct rvt_qp *qp,
+					struct rvt_sge *sge, int num_sge)
+{
+	int i;
+
+	for (i = 0; i < num_sge; i++, sge++) {
+		trace_hfi2_sge_check_align(qp, i, sge);
+		if ((u64)sge->vaddr & ~PAGE_MASK ||
+		    sge->sge_length & ~PAGE_MASK)
+			return false;
+	}
+	return true;
+}
+
+void setup_tid_rdma_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
+{
+	struct hfi2_qp_priv *qpriv = (struct hfi2_qp_priv *)qp->priv;
+	struct hfi2_swqe_priv *priv = wqe->priv;
+	struct tid_rdma_params *remote;
+	enum ib_wr_opcode new_opcode;
+	bool do_tid_rdma = false;
+	struct hfi2_pportdata *ppd = qpriv->rcd->ppd;
+
+	if ((rdma_ah_get_dlid(&qp->remote_ah_attr) & ~((1 << ppd->lmc) - 1)) ==
+				ppd->lid)
+		return;
+	if (qpriv->hdr_type != HFI2_PKT_TYPE_9B)
+		return;
+
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+	/*
+	 * If TID RDMA is disabled by the negotiation, don't
+	 * use it.
+	 */
+	if (!remote)
+		goto exit;
+
+	if (wqe->wr.opcode == IB_WR_RDMA_READ) {
+		if (hfi2_check_sge_align(qp, &wqe->sg_list[0],
+					 wqe->wr.num_sge)) {
+			new_opcode = IB_WR_TID_RDMA_READ;
+			do_tid_rdma = true;
+		}
+	} else if (wqe->wr.opcode == IB_WR_RDMA_WRITE) {
+		/*
+		 * TID RDMA is enabled for this RDMA WRITE request iff:
+		 *   1. The remote address is page-aligned,
+		 *   2. The length is larger than the minimum segment size,
+		 *   3. The length is page-multiple.
+		 */
+		if (!(wqe->rdma_wr.remote_addr & ~PAGE_MASK) &&
+		    !(wqe->length & ~PAGE_MASK)) {
+			new_opcode = IB_WR_TID_RDMA_WRITE;
+			do_tid_rdma = true;
+		}
+	}
+
+	if (do_tid_rdma) {
+		if (hfi2_kern_exp_rcv_alloc_flows(&priv->tid_req, GFP_ATOMIC))
+			goto exit;
+		wqe->wr.opcode = new_opcode;
+		priv->tid_req.seg_len =
+			min_t(u32, remote->max_len, wqe->length);
+		priv->tid_req.total_segs =
+			DIV_ROUND_UP(wqe->length, priv->tid_req.seg_len);
+		/* Compute the last PSN of the request */
+		wqe->lpsn = wqe->psn;
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_READ) {
+			priv->tid_req.n_flows = remote->max_read;
+			qpriv->tid_r_reqs++;
+			wqe->lpsn += rvt_div_round_up_mtu(qp, wqe->length) - 1;
+		} else {
+			wqe->lpsn += priv->tid_req.total_segs - 1;
+			atomic_inc(&qpriv->n_requests);
+		}
+
+		priv->tid_req.cur_seg = 0;
+		priv->tid_req.comp_seg = 0;
+		priv->tid_req.ack_seg = 0;
+		priv->tid_req.state = TID_REQUEST_INACTIVE;
+		/*
+		 * Reset acked_tail.
+		 * TID RDMA READ does not have ACKs so it does not
+		 * update the pointer. We have to reset it so TID RDMA
+		 * WRITE does not get confused.
+		 */
+		priv->tid_req.acked_tail = priv->tid_req.setup_head;
+		trace_hfi2_tid_req_setup_tid_wqe(qp, 1, wqe->wr.opcode,
+						 wqe->psn, wqe->lpsn,
+						 &priv->tid_req);
+	}
+exit:
+	rcu_read_unlock();
+}
+
+/* TID RDMA WRITE functions */
+
+u32 hfi2_build_tid_rdma_write_req(struct rvt_qp *qp, struct rvt_swqe *wqe,
+				  struct ib_other_headers *ohdr,
+				  u32 *bth1, u32 *bth2, u32 *len)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_rdma_request *req = wqe_to_tid_req(wqe);
+	struct tid_rdma_params *remote;
+
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+	/*
+	 * Set the number of flow to be used based on negotiated
+	 * parameters.
+	 */
+	req->n_flows = remote->max_write;
+	req->state = TID_REQUEST_ACTIVE;
+
+	KDETH_RESET(ohdr->u.tid_rdma.w_req.kdeth0, KVER, 0x1);
+	KDETH_RESET(ohdr->u.tid_rdma.w_req.kdeth1, JKEY, remote->jkey);
+	ohdr->u.tid_rdma.w_req.reth.vaddr =
+		cpu_to_be64(wqe->rdma_wr.remote_addr + (wqe->length - *len));
+	ohdr->u.tid_rdma.w_req.reth.rkey =
+		cpu_to_be32(wqe->rdma_wr.rkey);
+	ohdr->u.tid_rdma.w_req.reth.length = cpu_to_be32(*len);
+	ohdr->u.tid_rdma.w_req.verbs_qp = cpu_to_be32(qp->remote_qpn);
+	*bth1 &= ~RVT_QPN_MASK;
+	*bth1 |= remote->qp;
+	qp->s_state = TID_OP(WRITE_REQ);
+	qp->s_flags |= HFI2_S_WAIT_TID_RESP;
+	*bth2 |= IB_BTH_REQ_ACK;
+	*len = 0;
+
+	rcu_read_unlock();
+	return sizeof(ohdr->u.tid_rdma.w_req) / sizeof(u32);
+}
+
+static u32 hfi2_compute_tid_rdma_flow_wt(struct rvt_qp *qp)
+{
+	/*
+	 * Heuristic for computing the RNR timeout when waiting on the flow
+	 * queue. Rather than a computationaly expensive exact estimate of when
+	 * a flow will be available, we assume that if a QP is at position N in
+	 * the flow queue it has to wait approximately (N + 1) * (number of
+	 * segments between two sync points). The rationale for this is that
+	 * flows are released and recycled at each sync point.
+	 */
+	return (MAX_TID_FLOW_PSN * qp->pmtu) >> TID_RDMA_SEGMENT_SHIFT;
+}
+
+static u32 position_in_queue(struct hfi2_qp_priv *qpriv,
+			     struct tid_queue *queue)
+{
+	return qpriv->tid_enqueue - queue->dequeue;
+}
+
+/*
+ * @qp: points to rvt_qp context.
+ * @to_seg: desired RNR timeout in segments.
+ * Return: index of the next highest timeout in the ib_hfi2_rnr_table[]
+ */
+static u32 hfi2_compute_tid_rnr_timeout(struct rvt_qp *qp, u32 to_seg)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	u64 timeout;
+	u32 bytes_per_us;
+	u8 i;
+
+	bytes_per_us = active_egress_rate(qpriv->rcd->ppd) / 8;
+	timeout = (to_seg * TID_RDMA_MAX_SEGMENT_SIZE) / bytes_per_us;
+	/*
+	 * Find the next highest value in the RNR table to the required
+	 * timeout. This gives the responder some padding.
+	 */
+	for (i = 1; i <= IB_AETH_CREDIT_MASK; i++)
+		if (rvt_rnr_tbl_to_usec(i) >= timeout)
+			return i;
+	return 0;
+}
+
+/*
+ * Central place for resource allocation at TID write responder,
+ * is called from write_req and write_data interrupt handlers as
+ * well as the send thread when a queued QP is scheduled for
+ * resource allocation.
+ *
+ * Iterates over (a) segments of a request and then (b) queued requests
+ * themselves to allocate resources for up to local->max_write
+ * segments across multiple requests. Stop allocating when we
+ * hit a sync point, resume allocating after data packets at
+ * sync point have been received.
+ *
+ * Resource allocation and sending of responses is decoupled. The
+ * request/segment which are being allocated and sent are as follows.
+ * Resources are allocated for:
+ *     [request: qpriv->r_tid_alloc, segment: req->alloc_seg]
+ * The send thread sends:
+ *     [request: qp->s_tail_ack_queue, segment:req->cur_seg]
+ */
+static void hfi2_tid_write_alloc_resources(struct rvt_qp *qp, bool intr_ctx)
+{
+	struct tid_rdma_request *req;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct hfi2_ctxtdata *rcd = qpriv->rcd;
+	struct tid_rdma_params *local = &qpriv->tid_rdma.local;
+	struct rvt_ack_entry *e;
+	u32 npkts, to_seg;
+	bool last;
+	int ret = 0;
+
+	lockdep_assert_held(&qp->s_lock);
+
+	while (1) {
+		trace_hfi2_rsp_tid_write_alloc_res(qp, 0);
+		trace_hfi2_tid_write_rsp_alloc_res(qp);
+		/*
+		 * Don't allocate more segments if a RNR NAK has already been
+		 * scheduled to avoid messing up qp->r_psn: the RNR NAK will
+		 * be sent only when all allocated segments have been sent.
+		 * However, if more segments are allocated before that, TID RDMA
+		 * WRITE RESP packets will be sent out for these new segments
+		 * before the RNR NAK packet. When the requester receives the
+		 * RNR NAK packet, it will restart with qp->s_last_psn + 1,
+		 * which does not match qp->r_psn and will be dropped.
+		 * Consequently, the requester will exhaust its retries and
+		 * put the qp into error state.
+		 */
+		if (qpriv->rnr_nak_state == TID_RNR_NAK_SEND)
+			break;
+
+		/* No requests left to process */
+		if (qpriv->r_tid_alloc == qpriv->r_tid_head) {
+			/* If all data has been received, clear the flow */
+			if (qpriv->flow_state.index < RXE_NUM_TID_FLOWS &&
+			    !qpriv->alloc_w_segs) {
+				hfi2_kern_clear_hw_flow(rcd, qp);
+				qpriv->s_flags &= ~HFI2_R_TID_SW_PSN;
+			}
+			break;
+		}
+
+		e = &qp->s_ack_queue[qpriv->r_tid_alloc];
+		if (e->opcode != TID_OP(WRITE_REQ))
+			goto next_req;
+		req = ack_to_tid_req(e);
+		trace_hfi2_tid_req_write_alloc_res(qp, 0, e->opcode, e->psn,
+						   e->lpsn, req);
+		/* Finished allocating for all segments of this request */
+		if (req->alloc_seg >= req->total_segs)
+			goto next_req;
+
+		/* Can allocate only a maximum of local->max_write for a QP */
+		if (qpriv->alloc_w_segs >= local->max_write)
+			break;
+
+		/* Don't allocate at a sync point with data packets pending */
+		if (qpriv->sync_pt && qpriv->alloc_w_segs)
+			break;
+
+		/* All data received at the sync point, continue */
+		if (qpriv->sync_pt && !qpriv->alloc_w_segs) {
+			hfi2_kern_clear_hw_flow(rcd, qp);
+			qpriv->sync_pt = false;
+			qpriv->s_flags &= ~HFI2_R_TID_SW_PSN;
+		}
+
+		/* Allocate flow if we don't have one */
+		if (qpriv->flow_state.index >= RXE_NUM_TID_FLOWS) {
+			ret = hfi2_kern_setup_hw_flow(qpriv->rcd, qp);
+			if (ret) {
+				to_seg = hfi2_compute_tid_rdma_flow_wt(qp) *
+					position_in_queue(qpriv,
+							  &rcd->flow_queue);
+				break;
+			}
+		}
+
+		npkts = rvt_div_round_up_mtu(qp, req->seg_len);
+
+		/*
+		 * We are at a sync point if we run out of KDETH PSN space.
+		 * Last PSN of every generation is reserved for RESYNC.
+		 */
+		if (qpriv->flow_state.psn + npkts > MAX_TID_FLOW_PSN - 1) {
+			qpriv->sync_pt = true;
+			break;
+		}
+
+		/*
+		 * If overtaking req->acked_tail, send an RNR NAK. Because the
+		 * QP is not queued in this case, and the issue can only be
+		 * caused by a delay in scheduling the second leg which we
+		 * cannot estimate, we use a rather arbitrary RNR timeout of
+		 * (MAX_FLOWS / 2) segments
+		 */
+		if (!CIRC_SPACE(req->setup_head, req->acked_tail,
+				MAX_FLOWS)) {
+			ret = -EAGAIN;
+			to_seg = MAX_FLOWS >> 1;
+			tid_rdma_trigger_ack(qp);
+			break;
+		}
+
+		/* Try to allocate rcv array / TID entries */
+		ret = hfi2_kern_exp_rcv_setup(req, &req->ss, &last);
+		if (ret == -EAGAIN)
+			to_seg = position_in_queue(qpriv, &rcd->rarr_queue);
+		if (ret)
+			break;
+
+		qpriv->alloc_w_segs++;
+		req->alloc_seg++;
+		continue;
+next_req:
+		/* Begin processing the next request */
+		if (++qpriv->r_tid_alloc >
+		    rvt_size_atomic(ib_to_rvt(qp->ibqp.device)))
+			qpriv->r_tid_alloc = 0;
+	}
+
+	/*
+	 * Schedule an RNR NAK to be sent if (a) flow or rcv array allocation
+	 * has failed (b) we are called from the rcv handler interrupt context
+	 * (c) an RNR NAK has not already been scheduled
+	 */
+	if (ret == -EAGAIN && intr_ctx && !qp->r_nak_state)
+		goto send_rnr_nak;
+
+	return;
+
+send_rnr_nak:
+	lockdep_assert_held(&qp->r_lock);
+
+	/* Set r_nak_state to prevent unrelated events from generating NAK's */
+	qp->r_nak_state = hfi2_compute_tid_rnr_timeout(qp, to_seg) | IB_RNR_NAK;
+
+	/* Pull back r_psn to the segment being RNR NAK'd */
+	qp->r_psn = e->psn + req->alloc_seg;
+	qp->r_ack_psn = qp->r_psn;
+	/*
+	 * Pull back r_head_ack_queue to the ack entry following the request
+	 * being RNR NAK'd. This allows resources to be allocated to the request
+	 * if the queued QP is scheduled.
+	 */
+	qp->r_head_ack_queue = qpriv->r_tid_alloc + 1;
+	if (qp->r_head_ack_queue > rvt_size_atomic(ib_to_rvt(qp->ibqp.device)))
+		qp->r_head_ack_queue = 0;
+	qpriv->r_tid_head = qp->r_head_ack_queue;
+	/*
+	 * These send side fields are used in make_rc_ack(). They are set in
+	 * hfi2_send_rc_ack() but must be set here before dropping qp->s_lock
+	 * for consistency
+	 */
+	qp->s_nak_state = qp->r_nak_state;
+	qp->s_ack_psn = qp->r_ack_psn;
+	/*
+	 * Clear the ACK PENDING flag to prevent unwanted ACK because we
+	 * have modified qp->s_ack_psn here.
+	 */
+	qp->s_flags &= ~(RVT_S_ACK_PENDING);
+
+	trace_hfi2_rsp_tid_write_alloc_res(qp, qp->r_psn);
+	/*
+	 * qpriv->rnr_nak_state is used to determine when the scheduled RNR NAK
+	 * has actually been sent. qp->s_flags RVT_S_ACK_PENDING bit cannot be
+	 * used for this because qp->s_lock is dropped before calling
+	 * hfi2_send_rc_ack() leading to inconsistency between the receive
+	 * interrupt handlers and the send thread in make_rc_ack()
+	 */
+	qpriv->rnr_nak_state = TID_RNR_NAK_SEND;
+
+	/*
+	 * Schedule RNR NAK to be sent. RNR NAK's are scheduled from the receive
+	 * interrupt handlers but will be sent from the send engine behind any
+	 * previous responses that may have been scheduled
+	 */
+	rc_defered_ack(rcd, qp);
+}
+
+void hfi2_rc_rcv_tid_rdma_write_req(struct hfi2_packet *packet)
+{
+	/* HANDLER FOR TID RDMA WRITE REQUEST packet (Responder side)*/
+
+	/*
+	 * 1. Verify TID RDMA WRITE REQ as per IB_OPCODE_RC_RDMA_WRITE_FIRST
+	 *    (see hfi2_rc_rcv())
+	 *     - Don't allow 0-length requests.
+	 * 2. Put TID RDMA WRITE REQ into the response queue (s_ack_queue)
+	 *     - Setup struct tid_rdma_req with request info
+	 *     - Prepare struct tid_rdma_flow array?
+	 * 3. Set the qp->s_ack_state as state diagram in design doc.
+	 * 4. Set RVT_S_RESP_PENDING in s_flags.
+	 * 5. Kick the send engine (hfi2_schedule_send())
+	 */
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_ack_entry *e;
+	unsigned long flags;
+	struct ib_reth *reth;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_rdma_request *req;
+	u32 bth0, psn, len, rkey, num_segs;
+	bool fecn;
+	u8 next;
+	u64 vaddr;
+	int diff;
+
+	bth0 = be32_to_cpu(ohdr->bth[0]);
+	if (hfi2_ruc_check_hdr(ibp, packet))
+		return;
+
+	fecn = process_ecn(qp, packet);
+	psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+	trace_hfi2_rsp_rcv_tid_write_req(qp, psn);
+
+	if (qp->state == IB_QPS_RTR && !(qp->r_flags & RVT_R_COMM_EST))
+		rvt_comm_est(qp);
+
+	if (unlikely(!(qp->qp_access_flags & IB_ACCESS_REMOTE_WRITE)))
+		goto nack_inv;
+
+	reth = &ohdr->u.tid_rdma.w_req.reth;
+	vaddr = be64_to_cpu(reth->vaddr);
+	len = be32_to_cpu(reth->length);
+
+	num_segs = DIV_ROUND_UP(len, qpriv->tid_rdma.local.max_len);
+	diff = delta_psn(psn, qp->r_psn);
+	if (unlikely(diff)) {
+		tid_rdma_rcv_err(packet, ohdr, qp, psn, diff, fecn);
+		return;
+	}
+
+	/*
+	 * The resent request which was previously RNR NAK'd is inserted at the
+	 * location of the original request, which is one entry behind
+	 * r_head_ack_queue
+	 */
+	if (qpriv->rnr_nak_state)
+		qp->r_head_ack_queue = qp->r_head_ack_queue ?
+			qp->r_head_ack_queue - 1 :
+			rvt_size_atomic(ib_to_rvt(qp->ibqp.device));
+
+	/* We've verified the request, insert it into the ack queue. */
+	next = qp->r_head_ack_queue + 1;
+	if (next > rvt_size_atomic(ib_to_rvt(qp->ibqp.device)))
+		next = 0;
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (unlikely(next == qp->s_acked_ack_queue)) {
+		if (!qp->s_ack_queue[next].sent)
+			goto nack_inv_unlock;
+		update_ack_queue(qp, next);
+	}
+	e = &qp->s_ack_queue[qp->r_head_ack_queue];
+	req = ack_to_tid_req(e);
+
+	/* Bring previously RNR NAK'd request back to life */
+	if (qpriv->rnr_nak_state) {
+		qp->r_nak_state = 0;
+		qp->s_nak_state = 0;
+		qpriv->rnr_nak_state = TID_RNR_NAK_INIT;
+		qp->r_psn = e->lpsn + 1;
+		req->state = TID_REQUEST_INIT;
+		goto update_head;
+	}
+
+	release_rdma_sge_mr(e);
+
+	/* The length needs to be in multiples of PAGE_SIZE */
+	if (!len || len & ~PAGE_MASK)
+		goto nack_inv_unlock;
+
+	rkey = be32_to_cpu(reth->rkey);
+	qp->r_len = len;
+
+	if (e->opcode == TID_OP(WRITE_REQ) &&
+	    (req->setup_head != req->clear_tail ||
+	     req->clear_tail != req->acked_tail))
+		goto nack_inv_unlock;
+
+	if (unlikely(!rvt_rkey_ok(qp, &e->rdma_sge, qp->r_len, vaddr,
+				  rkey, IB_ACCESS_REMOTE_WRITE)))
+		goto nack_acc;
+
+	qp->r_psn += num_segs - 1;
+
+	e->opcode = (bth0 >> 24) & 0xff;
+	e->psn = psn;
+	e->lpsn = qp->r_psn;
+	e->sent = 0;
+
+	req->n_flows = min_t(u16, num_segs, qpriv->tid_rdma.local.max_write);
+	req->state = TID_REQUEST_INIT;
+	req->cur_seg = 0;
+	req->comp_seg = 0;
+	req->ack_seg = 0;
+	req->alloc_seg = 0;
+	req->isge = 0;
+	req->seg_len = qpriv->tid_rdma.local.max_len;
+	req->total_len = len;
+	req->total_segs = num_segs;
+	req->r_flow_psn = e->psn;
+	req->ss.sge = e->rdma_sge;
+	req->ss.num_sge = 1;
+
+	req->flow_idx = req->setup_head;
+	req->clear_tail = req->setup_head;
+	req->acked_tail = req->setup_head;
+
+	qp->r_state = e->opcode;
+	qp->r_nak_state = 0;
+	/*
+	 * We need to increment the MSN here instead of when we
+	 * finish sending the result since a duplicate request would
+	 * increment it more than once.
+	 */
+	qp->r_msn++;
+	qp->r_psn++;
+
+	trace_hfi2_tid_req_rcv_write_req(qp, 0, e->opcode, e->psn, e->lpsn,
+					 req);
+
+	if (qpriv->r_tid_tail == HFI2_QP_WQE_INVALID) {
+		qpriv->r_tid_tail = qp->r_head_ack_queue;
+	} else if (qpriv->r_tid_tail == qpriv->r_tid_head) {
+		struct tid_rdma_request *ptr;
+
+		e = &qp->s_ack_queue[qpriv->r_tid_tail];
+		ptr = ack_to_tid_req(e);
+
+		if (e->opcode != TID_OP(WRITE_REQ) ||
+		    ptr->comp_seg == ptr->total_segs) {
+			if (qpriv->r_tid_tail == qpriv->r_tid_ack)
+				qpriv->r_tid_ack = qp->r_head_ack_queue;
+			qpriv->r_tid_tail = qp->r_head_ack_queue;
+		}
+	}
+update_head:
+	qp->r_head_ack_queue = next;
+	qpriv->r_tid_head = qp->r_head_ack_queue;
+
+	hfi2_tid_write_alloc_resources(qp, true);
+	trace_hfi2_tid_write_rsp_rcv_req(qp);
+
+	/* Schedule the send tasklet. */
+	qp->s_flags |= RVT_S_RESP_PENDING;
+	if (fecn)
+		qp->s_flags |= RVT_S_ECN;
+	hfi2_schedule_send(qp);
+
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	return;
+
+nack_inv_unlock:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+nack_inv:
+	rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
+	qp->r_nak_state = IB_NAK_INVALID_REQUEST;
+	qp->r_ack_psn = qp->r_psn;
+	/* Queue NAK for later */
+	rc_defered_ack(rcd, qp);
+	return;
+nack_acc:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	rvt_rc_error(qp, IB_WC_LOC_PROT_ERR);
+	qp->r_nak_state = IB_NAK_REMOTE_ACCESS_ERROR;
+	qp->r_ack_psn = qp->r_psn;
+}
+
+u32 hfi2_build_tid_rdma_write_resp(struct rvt_qp *qp, struct rvt_ack_entry *e,
+				   struct ib_other_headers *ohdr, u32 *bth1,
+				   u32 bth2, u32 *len,
+				   struct rvt_sge_state **ss)
+{
+	struct hfi2_ack_priv *epriv = e->priv;
+	struct tid_rdma_request *req = &epriv->tid_req;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_rdma_flow *flow = NULL;
+	u32 resp_len = 0, hdwords = 0;
+	void *resp_addr = NULL;
+	struct tid_rdma_params *remote;
+
+	trace_hfi2_tid_req_build_write_resp(qp, 0, e->opcode, e->psn, e->lpsn,
+					    req);
+	trace_hfi2_tid_write_rsp_build_resp(qp);
+	trace_hfi2_rsp_build_tid_write_resp(qp, bth2);
+	flow = &req->flows[req->flow_idx];
+	switch (req->state) {
+	default:
+		/*
+		 * Try to allocate resources here in case QP was queued and was
+		 * later scheduled when resources became available
+		 */
+		hfi2_tid_write_alloc_resources(qp, false);
+
+		/* We've already sent everything which is ready */
+		if (req->cur_seg >= req->alloc_seg)
+			goto done;
+
+		/*
+		 * Resources can be assigned but responses cannot be sent in
+		 * rnr_nak state, till the resent request is received
+		 */
+		if (qpriv->rnr_nak_state == TID_RNR_NAK_SENT)
+			goto done;
+
+		req->state = TID_REQUEST_ACTIVE;
+		trace_hfi2_tid_flow_build_write_resp(qp, req->flow_idx, flow);
+		req->flow_idx = CIRC_NEXT(req->flow_idx, MAX_FLOWS);
+		hfi2_add_tid_reap_timer(qp);
+		break;
+
+	case TID_REQUEST_RESEND_ACTIVE:
+	case TID_REQUEST_RESEND:
+		trace_hfi2_tid_flow_build_write_resp(qp, req->flow_idx, flow);
+		req->flow_idx = CIRC_NEXT(req->flow_idx, MAX_FLOWS);
+		if (!CIRC_CNT(req->setup_head, req->flow_idx, MAX_FLOWS))
+			req->state = TID_REQUEST_ACTIVE;
+
+		hfi2_mod_tid_reap_timer(qp);
+		break;
+	}
+	flow->flow_state.resp_ib_psn = bth2;
+	resp_addr = (void *)flow->tid_entry;
+	resp_len = sizeof(*flow->tid_entry) * flow->tidcnt;
+	req->cur_seg++;
+
+	memset(&ohdr->u.tid_rdma.w_rsp, 0, sizeof(ohdr->u.tid_rdma.w_rsp));
+	epriv->ss.sge.vaddr = resp_addr;
+	epriv->ss.sge.sge_length = resp_len;
+	epriv->ss.sge.length = epriv->ss.sge.sge_length;
+	/*
+	 * We can safely zero these out. Since the first SGE covers the
+	 * entire packet, nothing else should even look at the MR.
+	 */
+	epriv->ss.sge.mr = NULL;
+	epriv->ss.sge.m = 0;
+	epriv->ss.sge.n = 0;
+
+	epriv->ss.sg_list = NULL;
+	epriv->ss.total_len = epriv->ss.sge.sge_length;
+	epriv->ss.num_sge = 1;
+
+	*ss = &epriv->ss;
+	*len = epriv->ss.total_len;
+
+	/* Construct the TID RDMA WRITE RESP packet header */
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+
+	KDETH_RESET(ohdr->u.tid_rdma.w_rsp.kdeth0, KVER, 0x1);
+	KDETH_RESET(ohdr->u.tid_rdma.w_rsp.kdeth1, JKEY, remote->jkey);
+	ohdr->u.tid_rdma.w_rsp.aeth = rvt_compute_aeth(qp);
+	ohdr->u.tid_rdma.w_rsp.tid_flow_psn =
+		cpu_to_be32((flow->flow_state.generation <<
+			     HFI2_KDETH_BTH_SEQ_SHIFT) |
+			    (flow->flow_state.spsn &
+			     HFI2_KDETH_BTH_SEQ_MASK));
+	ohdr->u.tid_rdma.w_rsp.tid_flow_qp =
+		cpu_to_be32(qpriv->tid_rdma.local.qp |
+			    ((flow->idx & TID_RDMA_DESTQP_FLOW_MASK) <<
+			     TID_RDMA_DESTQP_FLOW_SHIFT) |
+			    qpriv->rcd->ctxt);
+	ohdr->u.tid_rdma.w_rsp.verbs_qp = cpu_to_be32(qp->remote_qpn);
+	*bth1 = remote->qp;
+	rcu_read_unlock();
+	hdwords = sizeof(ohdr->u.tid_rdma.w_rsp) / sizeof(u32);
+	qpriv->pending_tid_w_segs++;
+done:
+	return hdwords;
+}
+
+static void hfi2_add_tid_reap_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+
+	lockdep_assert_held(&qp->s_lock);
+	if (!(qpriv->s_flags & HFI2_R_TID_RSC_TIMER)) {
+		qpriv->s_flags |= HFI2_R_TID_RSC_TIMER;
+		qpriv->s_tid_timer.expires = jiffies +
+			qpriv->tid_timer_timeout_jiffies;
+		add_timer(&qpriv->s_tid_timer);
+	}
+}
+
+static void hfi2_mod_tid_reap_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+
+	lockdep_assert_held(&qp->s_lock);
+	qpriv->s_flags |= HFI2_R_TID_RSC_TIMER;
+	mod_timer(&qpriv->s_tid_timer, jiffies +
+		  qpriv->tid_timer_timeout_jiffies);
+}
+
+static int hfi2_stop_tid_reap_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	int rval = 0;
+
+	lockdep_assert_held(&qp->s_lock);
+	if (qpriv->s_flags & HFI2_R_TID_RSC_TIMER) {
+		rval = timer_delete(&qpriv->s_tid_timer);
+		qpriv->s_flags &= ~HFI2_R_TID_RSC_TIMER;
+	}
+	return rval;
+}
+
+void hfi2_del_tid_reap_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+
+	timer_delete_sync(&qpriv->s_tid_timer);
+	qpriv->s_flags &= ~HFI2_R_TID_RSC_TIMER;
+}
+
+static void hfi2_tid_timeout(struct timer_list *t)
+{
+	struct hfi2_qp_priv *qpriv = from_timer(qpriv, t, s_tid_timer);
+	struct rvt_qp *qp = qpriv->owner;
+	struct rvt_dev_info *rdi = ib_to_rvt(qp->ibqp.device);
+	unsigned long flags;
+	u32 i;
+
+	spin_lock_irqsave(&qp->r_lock, flags);
+	spin_lock(&qp->s_lock);
+	if (qpriv->s_flags & HFI2_R_TID_RSC_TIMER) {
+		dd_dev_warn(dd_from_ibdev(qp->ibqp.device), "[QP%u] %s %d\n",
+			    qp->ibqp.qp_num, __func__, __LINE__);
+		trace_hfi2_msg_tid_timeout(/* msg */
+			qp, "resource timeout = ",
+			(u64)qpriv->tid_timer_timeout_jiffies);
+		hfi2_stop_tid_reap_timer(qp);
+		/*
+		 * Go though the entire ack queue and clear any outstanding
+		 * HW flow and RcvArray resources.
+		 */
+		hfi2_kern_clear_hw_flow(qpriv->rcd, qp);
+		for (i = 0; i < rvt_max_atomic(rdi); i++) {
+			struct tid_rdma_request *req =
+				ack_to_tid_req(&qp->s_ack_queue[i]);
+
+			hfi2_kern_exp_rcv_clear_all(req);
+		}
+		spin_unlock(&qp->s_lock);
+		if (qp->ibqp.event_handler) {
+			struct ib_event ev;
+
+			ev.device = qp->ibqp.device;
+			ev.element.qp = &qp->ibqp;
+			ev.event = IB_EVENT_QP_FATAL;
+			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
+		}
+		rvt_rc_error(qp, IB_WC_RESP_TIMEOUT_ERR);
+		goto unlock_r_lock;
+	}
+	spin_unlock(&qp->s_lock);
+unlock_r_lock:
+	spin_unlock_irqrestore(&qp->r_lock, flags);
+}
+
+void hfi2_rc_rcv_tid_rdma_write_resp(struct hfi2_packet *packet)
+{
+	/* HANDLER FOR TID RDMA WRITE RESPONSE packet (Requester side) */
+
+	/*
+	 * 1. Find matching SWQE
+	 * 2. Check that TIDENTRY array has enough space for a complete
+	 *    segment. If not, put QP in error state.
+	 * 3. Save response data in struct tid_rdma_req and struct tid_rdma_flow
+	 * 4. Remove HFI2_S_WAIT_TID_RESP from s_flags.
+	 * 5. Set qp->s_state
+	 * 6. Kick the send engine (hfi2_schedule_send())
+	 */
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct rvt_swqe *wqe;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	enum ib_wc_status status;
+	u32 opcode, aeth, psn, flow_psn, i, tidlen = 0, pktlen;
+	bool fecn;
+	unsigned long flags;
+
+	fecn = process_ecn(qp, packet);
+	psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+	aeth = be32_to_cpu(ohdr->u.tid_rdma.w_rsp.aeth);
+	opcode = (be32_to_cpu(ohdr->bth[0]) >> 24) & 0xff;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+
+	/* Ignore invalid responses */
+	if (cmp_psn(psn, qp->s_next_psn) >= 0)
+		goto ack_done;
+
+	/* Ignore duplicate responses. */
+	if (unlikely(cmp_psn(psn, qp->s_last_psn) <= 0))
+		goto ack_done;
+
+	if (unlikely(qp->s_acked == qp->s_tail))
+		goto ack_done;
+
+	/*
+	 * If we are waiting for a particular packet sequence number
+	 * due to a request being resent, check for it. Otherwise,
+	 * ensure that we haven't missed anything.
+	 */
+	if (qp->r_flags & RVT_R_RDMAR_SEQ) {
+		if (cmp_psn(psn, qp->s_last_psn + 1) != 0)
+			goto ack_done;
+		qp->r_flags &= ~RVT_R_RDMAR_SEQ;
+	}
+
+	wqe = rvt_get_swqe_ptr(qp, qpriv->s_tid_cur);
+	if (unlikely(wqe->wr.opcode != IB_WR_TID_RDMA_WRITE))
+		goto ack_op_err;
+
+	req = wqe_to_tid_req(wqe);
+	/*
+	 * If we've lost ACKs and our acked_tail pointer is too far
+	 * behind, don't overwrite segments. Just drop the packet and
+	 * let the reliability protocol take care of it.
+	 */
+	if (!CIRC_SPACE(req->setup_head, req->acked_tail, MAX_FLOWS))
+		goto ack_done;
+
+	/*
+	 * The call to do_rc_ack() should be last in the chain of
+	 * packet checks because it will end up updating the QP state.
+	 * Therefore, anything that would prevent the packet from
+	 * being accepted as a successful response should be prior
+	 * to it.
+	 */
+	if (!do_rc_ack(qp, aeth, psn, opcode, 0, rcd))
+		goto ack_done;
+
+	trace_hfi2_ack(qp, psn);
+
+	flow = &req->flows[req->setup_head];
+	flow->pkt = 0;
+	flow->tid_idx = 0;
+	flow->tid_offset = 0;
+	flow->sent = 0;
+	flow->resync_npkts = 0;
+	flow->tid_qpn = be32_to_cpu(ohdr->u.tid_rdma.w_rsp.tid_flow_qp);
+	flow->idx = (flow->tid_qpn >> TID_RDMA_DESTQP_FLOW_SHIFT) &
+		TID_RDMA_DESTQP_FLOW_MASK;
+	flow_psn = mask_psn(be32_to_cpu(ohdr->u.tid_rdma.w_rsp.tid_flow_psn));
+	flow->flow_state.generation = flow_psn >> HFI2_KDETH_BTH_SEQ_SHIFT;
+	flow->flow_state.spsn = flow_psn & HFI2_KDETH_BTH_SEQ_MASK;
+	flow->flow_state.resp_ib_psn = psn;
+	flow->length = min_t(u32, req->seg_len,
+			     (wqe->length - (req->comp_seg * req->seg_len)));
+
+	flow->npkts = rvt_div_round_up_mtu(qp, flow->length);
+	flow->flow_state.lpsn = flow->flow_state.spsn +
+		flow->npkts - 1;
+	/* payload length = packet length - (header length + ICRC length) */
+	pktlen = packet->tlen - (packet->hlen + 4);
+	if (pktlen > sizeof(flow->tid_entry)) {
+		status = IB_WC_LOC_LEN_ERR;
+		goto ack_err;
+	}
+	memcpy(flow->tid_entry, packet->ebuf, pktlen);
+	flow->tidcnt = pktlen / sizeof(*flow->tid_entry);
+	trace_hfi2_tid_flow_rcv_write_resp(qp, req->setup_head, flow);
+
+	req->comp_seg++;
+	trace_hfi2_tid_write_sender_rcv_resp(qp, 0);
+	/*
+	 * Walk the TID_ENTRY list to make sure we have enough space for a
+	 * complete segment.
+	 */
+	for (i = 0; i < flow->tidcnt; i++) {
+		trace_hfi2_tid_entry_rcv_write_resp(/* entry */
+			qp, i, flow->tid_entry[i]);
+		if (!EXP_TID_GET(flow->tid_entry[i], LEN)) {
+			status = IB_WC_LOC_LEN_ERR;
+			goto ack_err;
+		}
+		tidlen += EXP_TID_GET(flow->tid_entry[i], LEN);
+	}
+	if (tidlen * PAGE_SIZE < flow->length) {
+		status = IB_WC_LOC_LEN_ERR;
+		goto ack_err;
+	}
+
+	trace_hfi2_tid_req_rcv_write_resp(qp, 0, wqe->wr.opcode, wqe->psn,
+					  wqe->lpsn, req);
+	/*
+	 * If this is the first response for this request, set the initial
+	 * flow index to the current flow.
+	 */
+	if (!cmp_psn(psn, wqe->psn)) {
+		req->r_last_acked = mask_psn(wqe->psn - 1);
+		/* Set acked flow index to head index */
+		req->acked_tail = req->setup_head;
+	}
+
+	/* advance circular buffer head */
+	req->setup_head = CIRC_NEXT(req->setup_head, MAX_FLOWS);
+	req->state = TID_REQUEST_ACTIVE;
+
+	/*
+	 * If all responses for this TID RDMA WRITE request have been received
+	 * advance the pointer to the next one.
+	 * Since TID RDMA requests could be mixed in with regular IB requests,
+	 * they might not appear sequentially in the queue. Therefore, the
+	 * next request needs to be "found".
+	 */
+	if (qpriv->s_tid_cur != qpriv->s_tid_head &&
+	    req->comp_seg == req->total_segs) {
+		for (i = qpriv->s_tid_cur + 1; ; i++) {
+			if (i == qp->s_size)
+				i = 0;
+			wqe = rvt_get_swqe_ptr(qp, i);
+			if (i == qpriv->s_tid_head)
+				break;
+			if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE)
+				break;
+		}
+		qpriv->s_tid_cur = i;
+	}
+	qp->s_flags &= ~HFI2_S_WAIT_TID_RESP;
+	hfi2_schedule_tid_send(qp);
+	goto ack_done;
+
+ack_op_err:
+	status = IB_WC_LOC_QP_OP_ERR;
+ack_err:
+	rvt_error_qp(qp, status);
+ack_done:
+	if (fecn)
+		qp->s_flags |= RVT_S_ECN;
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+}
+
+bool hfi2_build_tid_rdma_packet(struct rvt_swqe *wqe,
+				struct ib_other_headers *ohdr,
+				u32 *bth1, u32 *bth2, u32 *len)
+{
+	struct tid_rdma_request *req = wqe_to_tid_req(wqe);
+	struct tid_rdma_flow *flow = &req->flows[req->clear_tail];
+	struct tid_rdma_params *remote;
+	struct rvt_qp *qp = req->qp;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	u32 tidentry = flow->tid_entry[flow->tid_idx];
+	u32 tidlen = EXP_TID_GET(tidentry, LEN) << PAGE_SHIFT;
+	struct tid_rdma_write_data *wd = &ohdr->u.tid_rdma.w_data;
+	u32 next_offset, om = KDETH_OM_LARGE;
+	bool last_pkt;
+
+	if (!tidlen) {
+		hfi2_trdma_send_complete(qp, wqe, IB_WC_REM_INV_RD_REQ_ERR);
+		rvt_error_qp(qp, IB_WC_REM_INV_RD_REQ_ERR);
+	}
+
+	*len = min_t(u32, qp->pmtu, tidlen - flow->tid_offset);
+	flow->sent += *len;
+	next_offset = flow->tid_offset + *len;
+	last_pkt = (flow->tid_idx == (flow->tidcnt - 1) &&
+		    next_offset >= tidlen) || (flow->sent >= flow->length);
+	trace_hfi2_tid_entry_build_write_data(qp, flow->tid_idx, tidentry);
+	trace_hfi2_tid_flow_build_write_data(qp, req->clear_tail, flow);
+
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+	KDETH_RESET(wd->kdeth0, KVER, 0x1);
+	KDETH_SET(wd->kdeth0, SH, !last_pkt);
+	KDETH_SET(wd->kdeth0, INTR, !!(!last_pkt && remote->urg));
+	KDETH_SET(wd->kdeth0, TIDCTRL, EXP_TID_GET(tidentry, CTRL));
+	KDETH_SET(wd->kdeth0, TID, EXP_TID_GET(tidentry, IDX));
+	KDETH_SET(wd->kdeth0, OM, om == KDETH_OM_LARGE);
+	KDETH_SET(wd->kdeth0, OFFSET, flow->tid_offset / om);
+	KDETH_RESET(wd->kdeth1, JKEY, remote->jkey);
+	wd->verbs_qp = cpu_to_be32(qp->remote_qpn);
+	rcu_read_unlock();
+
+	*bth1 = flow->tid_qpn;
+	*bth2 = mask_psn(((flow->flow_state.spsn + flow->pkt++) &
+			 HFI2_KDETH_BTH_SEQ_MASK) |
+			 (flow->flow_state.generation <<
+			  HFI2_KDETH_BTH_SEQ_SHIFT));
+	if (last_pkt) {
+		/* PSNs are zero-based, so +1 to count number of packets */
+		if (flow->flow_state.lpsn + 1 +
+		    rvt_div_round_up_mtu(qp, req->seg_len) >
+		    MAX_TID_FLOW_PSN)
+			req->state = TID_REQUEST_SYNC;
+		*bth2 |= IB_BTH_REQ_ACK;
+	}
+
+	if (next_offset >= tidlen) {
+		flow->tid_offset = 0;
+		flow->tid_idx++;
+	} else {
+		flow->tid_offset = next_offset;
+	}
+	return last_pkt;
+}
+
+void hfi2_rc_rcv_tid_rdma_write_data(struct hfi2_packet *packet)
+{
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ctxtdata *rcd = priv->rcd;
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_ack_entry *e;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	struct hfi2_ibdev *dev = to_idev(qp->ibqp.device);
+	unsigned long flags;
+	u32 psn, next;
+	u8 opcode;
+	bool fecn;
+
+	fecn = process_ecn(qp, packet);
+	psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+	opcode = (be32_to_cpu(ohdr->bth[0]) >> 24) & 0xff;
+
+	/*
+	 * All error handling should be done by now. If we are here, the packet
+	 * is either good or been accepted by the error handler.
+	 */
+	spin_lock_irqsave(&qp->s_lock, flags);
+	e = &qp->s_ack_queue[priv->r_tid_tail];
+	req = ack_to_tid_req(e);
+	flow = &req->flows[req->clear_tail];
+	if (cmp_psn(psn, full_flow_psn(flow, flow->flow_state.lpsn))) {
+		update_r_next_psn_fecn(packet, priv, rcd, flow, fecn);
+
+		if (cmp_psn(psn, flow->flow_state.r_next_psn))
+			goto send_nak;
+
+		flow->flow_state.r_next_psn = mask_psn(psn + 1);
+		/*
+		 * Copy the payload to destination buffer if this packet is
+		 * delivered as an eager packet due to RSM rule and FECN.
+		 * The RSM rule selects FECN bit in BTH and SH bit in
+		 * KDETH header and therefore will not match the last
+		 * packet of each segment that has SH bit cleared.
+		 */
+		if (fecn && packet->etype == RHF_RCV_TYPE_EAGER) {
+			struct rvt_sge_state ss;
+			u32 len;
+			u32 tlen = packet->tlen;
+			u16 hdrsize = packet->hlen;
+			u8 pad = packet->pad;
+			u8 extra_bytes = pad + packet->extra_byte +
+				(SIZE_OF_CRC << 2);
+			u32 pmtu = qp->pmtu;
+
+			if (unlikely(tlen != (hdrsize + pmtu + extra_bytes)))
+				goto send_nak;
+			len = req->comp_seg * req->seg_len;
+			len += delta_psn(psn,
+				full_flow_psn(flow, flow->flow_state.spsn)) *
+				pmtu;
+			if (unlikely(req->total_len - len < pmtu))
+				goto send_nak;
+
+			/*
+			 * The e->rdma_sge field is set when TID RDMA WRITE REQ
+			 * is first received and is never modified thereafter.
+			 */
+			ss.sge = e->rdma_sge;
+			ss.sg_list = NULL;
+			ss.num_sge = 1;
+			ss.total_len = req->total_len;
+			rvt_skip_sge(&ss, len, false);
+			rvt_copy_sge(qp, &ss, packet->payload, pmtu, false,
+				     false);
+			/* Raise the sw sequence check flag for next packet */
+			priv->r_next_psn_kdeth = mask_psn(psn + 1);
+			priv->s_flags |= HFI2_R_TID_SW_PSN;
+		}
+		goto exit;
+	}
+	flow->flow_state.r_next_psn = mask_psn(psn + 1);
+	hfi2_kern_exp_rcv_clear(req);
+	priv->alloc_w_segs--;
+	rcd->flows[flow->idx].psn = psn & HFI2_KDETH_BTH_SEQ_MASK;
+	req->comp_seg++;
+	priv->s_nak_state = 0;
+
+	/*
+	 * Release the flow if one of the following conditions has been met:
+	 *  - The request has reached a sync point AND all outstanding
+	 *    segments have been completed, or
+	 *  - The entire request is complete and there are no more requests
+	 *    (of any kind) in the queue.
+	 */
+	trace_hfi2_rsp_rcv_tid_write_data(qp, psn);
+	trace_hfi2_tid_req_rcv_write_data(qp, 0, e->opcode, e->psn, e->lpsn,
+					  req);
+	trace_hfi2_tid_write_rsp_rcv_data(qp);
+	validate_r_tid_ack(priv);
+
+	if (opcode == TID_OP(WRITE_DATA_LAST)) {
+		release_rdma_sge_mr(e);
+		for (next = priv->r_tid_tail + 1; ; next++) {
+			if (next > rvt_size_atomic(&dev->rdi))
+				next = 0;
+			if (next == priv->r_tid_head)
+				break;
+			e = &qp->s_ack_queue[next];
+			if (e->opcode == TID_OP(WRITE_REQ))
+				break;
+		}
+		priv->r_tid_tail = next;
+		if (++qp->s_acked_ack_queue > rvt_size_atomic(&dev->rdi))
+			qp->s_acked_ack_queue = 0;
+	}
+
+	hfi2_tid_write_alloc_resources(qp, true);
+
+	/*
+	 * If we need to generate more responses, schedule the
+	 * send engine.
+	 */
+	if (req->cur_seg < req->total_segs ||
+	    qp->s_tail_ack_queue != qp->r_head_ack_queue) {
+		qp->s_flags |= RVT_S_RESP_PENDING;
+		hfi2_schedule_send(qp);
+	}
+
+	priv->pending_tid_w_segs--;
+	if (priv->s_flags & HFI2_R_TID_RSC_TIMER) {
+		if (priv->pending_tid_w_segs)
+			hfi2_mod_tid_reap_timer(req->qp);
+		else
+			hfi2_stop_tid_reap_timer(req->qp);
+	}
+
+done:
+	tid_rdma_schedule_ack(qp);
+exit:
+	priv->r_next_psn_kdeth = flow->flow_state.r_next_psn;
+	if (fecn)
+		qp->s_flags |= RVT_S_ECN;
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	return;
+
+send_nak:
+	if (!priv->s_nak_state) {
+		priv->s_nak_state = IB_NAK_PSN_ERROR;
+		priv->s_nak_psn = flow->flow_state.r_next_psn;
+		tid_rdma_trigger_ack(qp);
+	}
+	goto done;
+}
+
+static bool hfi2_tid_rdma_is_resync_psn(u32 psn)
+{
+	return (bool)((psn & HFI2_KDETH_BTH_SEQ_MASK) ==
+		      HFI2_KDETH_BTH_SEQ_MASK);
+}
+
+u32 hfi2_build_tid_rdma_write_ack(struct rvt_qp *qp, struct rvt_ack_entry *e,
+				  struct ib_other_headers *ohdr, u16 iflow,
+				  u32 *bth1, u32 *bth2)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_flow_state *fs = &qpriv->flow_state;
+	struct tid_rdma_request *req = ack_to_tid_req(e);
+	struct tid_rdma_flow *flow = &req->flows[iflow];
+	struct tid_rdma_params *remote;
+
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+	KDETH_RESET(ohdr->u.tid_rdma.ack.kdeth1, JKEY, remote->jkey);
+	ohdr->u.tid_rdma.ack.verbs_qp = cpu_to_be32(qp->remote_qpn);
+	*bth1 = remote->qp;
+	rcu_read_unlock();
+
+	if (qpriv->resync) {
+		*bth2 = mask_psn((fs->generation <<
+				  HFI2_KDETH_BTH_SEQ_SHIFT) - 1);
+		ohdr->u.tid_rdma.ack.aeth = rvt_compute_aeth(qp);
+	} else if (qpriv->s_nak_state) {
+		*bth2 = mask_psn(qpriv->s_nak_psn);
+		ohdr->u.tid_rdma.ack.aeth =
+			cpu_to_be32((qp->r_msn & IB_MSN_MASK) |
+				    (qpriv->s_nak_state <<
+				     IB_AETH_CREDIT_SHIFT));
+	} else {
+		*bth2 = full_flow_psn(flow, flow->flow_state.lpsn);
+		ohdr->u.tid_rdma.ack.aeth = rvt_compute_aeth(qp);
+	}
+	KDETH_RESET(ohdr->u.tid_rdma.ack.kdeth0, KVER, 0x1);
+	ohdr->u.tid_rdma.ack.tid_flow_qp =
+		cpu_to_be32(qpriv->tid_rdma.local.qp |
+			    ((flow->idx & TID_RDMA_DESTQP_FLOW_MASK) <<
+			     TID_RDMA_DESTQP_FLOW_SHIFT) |
+			    qpriv->rcd->ctxt);
+
+	ohdr->u.tid_rdma.ack.tid_flow_psn = 0;
+	ohdr->u.tid_rdma.ack.verbs_psn =
+		cpu_to_be32(flow->flow_state.resp_ib_psn);
+
+	if (qpriv->resync) {
+		/*
+		 * If the PSN before the current expect KDETH PSN is the
+		 * RESYNC PSN, then we never received a good TID RDMA WRITE
+		 * DATA packet after a previous RESYNC.
+		 * In this case, the next expected KDETH PSN stays the same.
+		 */
+		if (hfi2_tid_rdma_is_resync_psn(qpriv->r_next_psn_kdeth - 1)) {
+			ohdr->u.tid_rdma.ack.tid_flow_psn =
+				cpu_to_be32(qpriv->r_next_psn_kdeth_save);
+		} else {
+			/*
+			 * Because the KDETH PSNs jump during a RESYNC, it's
+			 * not possible to infer (or compute) the previous value
+			 * of r_next_psn_kdeth in the case of back-to-back
+			 * RESYNC packets. Therefore, we save it.
+			 */
+			qpriv->r_next_psn_kdeth_save =
+				qpriv->r_next_psn_kdeth - 1;
+			ohdr->u.tid_rdma.ack.tid_flow_psn =
+				cpu_to_be32(qpriv->r_next_psn_kdeth_save);
+			qpriv->r_next_psn_kdeth = mask_psn(*bth2 + 1);
+		}
+		qpriv->resync = false;
+	}
+
+	return sizeof(ohdr->u.tid_rdma.ack) / sizeof(u32);
+}
+
+void hfi2_rc_rcv_tid_rdma_ack(struct hfi2_packet *packet)
+{
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct rvt_swqe *wqe;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	u32 aeth, psn, req_psn, ack_psn, flpsn, resync_psn, ack_kpsn;
+	unsigned long flags;
+	u16 fidx;
+
+	trace_hfi2_tid_write_sender_rcv_tid_ack(qp, 0);
+	process_ecn(qp, packet);
+	psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+	aeth = be32_to_cpu(ohdr->u.tid_rdma.ack.aeth);
+	req_psn = mask_psn(be32_to_cpu(ohdr->u.tid_rdma.ack.verbs_psn));
+	resync_psn = mask_psn(be32_to_cpu(ohdr->u.tid_rdma.ack.tid_flow_psn));
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	trace_hfi2_rcv_tid_ack(qp, aeth, psn, req_psn, resync_psn);
+
+	/* If we are waiting for an ACK to RESYNC, drop any other packets */
+	if ((qp->s_flags & HFI2_S_WAIT_HALT) &&
+	    cmp_psn(psn, qpriv->s_resync_psn))
+		goto ack_op_err;
+
+	ack_psn = req_psn;
+	if (hfi2_tid_rdma_is_resync_psn(psn))
+		ack_kpsn = resync_psn;
+	else
+		ack_kpsn = psn;
+	if (aeth >> 29) {
+		ack_psn--;
+		ack_kpsn--;
+	}
+
+	if (unlikely(qp->s_acked == qp->s_tail))
+		goto ack_op_err;
+
+	wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+
+	if (wqe->wr.opcode != IB_WR_TID_RDMA_WRITE)
+		goto ack_op_err;
+
+	req = wqe_to_tid_req(wqe);
+	trace_hfi2_tid_req_rcv_tid_ack(qp, 0, wqe->wr.opcode, wqe->psn,
+				       wqe->lpsn, req);
+	flow = &req->flows[req->acked_tail];
+	trace_hfi2_tid_flow_rcv_tid_ack(qp, req->acked_tail, flow);
+
+	/* Drop stale ACK/NAK */
+	if (cmp_psn(psn, full_flow_psn(flow, flow->flow_state.spsn)) < 0 ||
+	    cmp_psn(req_psn, flow->flow_state.resp_ib_psn) < 0)
+		goto ack_op_err;
+
+	while (cmp_psn(ack_kpsn,
+		       full_flow_psn(flow, flow->flow_state.lpsn)) >= 0 &&
+	       req->ack_seg < req->cur_seg) {
+		req->ack_seg++;
+		/* advance acked segment pointer */
+		req->acked_tail = CIRC_NEXT(req->acked_tail, MAX_FLOWS);
+		req->r_last_acked = flow->flow_state.resp_ib_psn;
+		trace_hfi2_tid_req_rcv_tid_ack(qp, 0, wqe->wr.opcode, wqe->psn,
+					       wqe->lpsn, req);
+		if (req->ack_seg == req->total_segs) {
+			req->state = TID_REQUEST_COMPLETE;
+			wqe = do_rc_completion(qp, wqe,
+					       to_iport(qp->ibqp.device,
+							qp->port_num));
+			trace_hfi2_sender_rcv_tid_ack(qp);
+			atomic_dec(&qpriv->n_tid_requests);
+			if (qp->s_acked == qp->s_tail)
+				break;
+			if (wqe->wr.opcode != IB_WR_TID_RDMA_WRITE)
+				break;
+			req = wqe_to_tid_req(wqe);
+		}
+		flow = &req->flows[req->acked_tail];
+		trace_hfi2_tid_flow_rcv_tid_ack(qp, req->acked_tail, flow);
+	}
+
+	trace_hfi2_tid_req_rcv_tid_ack(qp, 0, wqe->wr.opcode, wqe->psn,
+				       wqe->lpsn, req);
+	switch (aeth >> 29) {
+	case 0:         /* ACK */
+		if (qpriv->s_flags & RVT_S_WAIT_ACK)
+			qpriv->s_flags &= ~RVT_S_WAIT_ACK;
+		if (!hfi2_tid_rdma_is_resync_psn(psn)) {
+			/* Check if there is any pending TID ACK */
+			if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE &&
+			    req->ack_seg < req->cur_seg)
+				hfi2_mod_tid_retry_timer(qp);
+			else
+				hfi2_stop_tid_retry_timer(qp);
+			hfi2_schedule_send(qp);
+		} else {
+			u32 spsn, fpsn, last_acked, generation;
+			struct tid_rdma_request *rptr;
+
+			/* ACK(RESYNC) */
+			hfi2_stop_tid_retry_timer(qp);
+			/* Allow new requests (see hfi2_make_tid_rdma_pkt) */
+			qp->s_flags &= ~HFI2_S_WAIT_HALT;
+			/*
+			 * Clear RVT_S_SEND_ONE flag in case that the TID RDMA
+			 * ACK is received after the TID retry timer is fired
+			 * again. In this case, do not send any more TID
+			 * RESYNC request or wait for any more TID ACK packet.
+			 */
+			qpriv->s_flags &= ~RVT_S_SEND_ONE;
+			hfi2_schedule_send(qp);
+
+			if ((qp->s_acked == qpriv->s_tid_tail &&
+			     req->ack_seg == req->total_segs) ||
+			    qp->s_acked == qp->s_tail) {
+				qpriv->s_state = TID_OP(WRITE_DATA_LAST);
+				goto done;
+			}
+
+			if (req->ack_seg == req->comp_seg) {
+				qpriv->s_state = TID_OP(WRITE_DATA);
+				goto done;
+			}
+
+			/*
+			 * The PSN to start with is the next PSN after the
+			 * RESYNC PSN.
+			 */
+			psn = mask_psn(psn + 1);
+			generation = psn >> HFI2_KDETH_BTH_SEQ_SHIFT;
+			spsn = 0;
+
+			/*
+			 * Update to the correct WQE when we get an ACK(RESYNC)
+			 * in the middle of a request.
+			 */
+			if (delta_psn(ack_psn, wqe->lpsn))
+				wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+			req = wqe_to_tid_req(wqe);
+			flow = &req->flows[req->acked_tail];
+			/*
+			 * RESYNC re-numbers the PSN ranges of all remaining
+			 * segments. Also, PSN's start from 0 in the middle of a
+			 * segment and the first segment size is less than the
+			 * default number of packets. flow->resync_npkts is used
+			 * to track the number of packets from the start of the
+			 * real segment to the point of 0 PSN after the RESYNC
+			 * in order to later correctly rewind the SGE.
+			 */
+			fpsn = full_flow_psn(flow, flow->flow_state.spsn);
+			req->r_ack_psn = psn;
+			/*
+			 * If resync_psn points to the last flow PSN for a
+			 * segment and the new segment (likely from a new
+			 * request) starts with a new generation number, we
+			 * need to adjust resync_psn accordingly.
+			 */
+			if (flow->flow_state.generation !=
+			    (resync_psn >> HFI2_KDETH_BTH_SEQ_SHIFT))
+				resync_psn = mask_psn(fpsn - 1);
+			flow->resync_npkts +=
+				delta_psn(mask_psn(resync_psn + 1), fpsn);
+			/*
+			 * Renumber all packet sequence number ranges
+			 * based on the new generation.
+			 */
+			last_acked = qp->s_acked;
+			rptr = req;
+			while (1) {
+				/* start from last acked segment */
+				for (fidx = rptr->acked_tail;
+				     CIRC_CNT(rptr->setup_head, fidx,
+					      MAX_FLOWS);
+				     fidx = CIRC_NEXT(fidx, MAX_FLOWS)) {
+					u32 lpsn;
+					u32 gen;
+
+					flow = &rptr->flows[fidx];
+					gen = flow->flow_state.generation;
+					if (WARN_ON(gen == generation &&
+						    flow->flow_state.spsn !=
+						     spsn))
+						continue;
+					lpsn = flow->flow_state.lpsn;
+					lpsn = full_flow_psn(flow, lpsn);
+					flow->npkts =
+						delta_psn(lpsn,
+							  mask_psn(resync_psn)
+							  );
+					flow->flow_state.generation =
+						generation;
+					flow->flow_state.spsn = spsn;
+					flow->flow_state.lpsn =
+						flow->flow_state.spsn +
+						flow->npkts - 1;
+					flow->pkt = 0;
+					spsn += flow->npkts;
+					resync_psn += flow->npkts;
+					trace_hfi2_tid_flow_rcv_tid_ack(qp,
+									fidx,
+									flow);
+				}
+				if (++last_acked == qpriv->s_tid_cur + 1)
+					break;
+				if (last_acked == qp->s_size)
+					last_acked = 0;
+				wqe = rvt_get_swqe_ptr(qp, last_acked);
+				rptr = wqe_to_tid_req(wqe);
+			}
+			req->cur_seg = req->ack_seg;
+			qpriv->s_tid_tail = qp->s_acked;
+			qpriv->s_state = TID_OP(WRITE_REQ);
+			hfi2_schedule_tid_send(qp);
+		}
+done:
+		qpriv->s_retry = qp->s_retry_cnt;
+		break;
+
+	case 3:         /* NAK */
+		hfi2_stop_tid_retry_timer(qp);
+		switch ((aeth >> IB_AETH_CREDIT_SHIFT) &
+			IB_AETH_CREDIT_MASK) {
+		case 0: /* PSN sequence error */
+			if (!req->flows)
+				break;
+			flow = &req->flows[req->acked_tail];
+			flpsn = full_flow_psn(flow, flow->flow_state.lpsn);
+			if (cmp_psn(psn, flpsn) > 0)
+				break;
+			trace_hfi2_tid_flow_rcv_tid_ack(qp, req->acked_tail,
+							flow);
+			req->r_ack_psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+			req->cur_seg = req->ack_seg;
+			qpriv->s_tid_tail = qp->s_acked;
+			qpriv->s_state = TID_OP(WRITE_REQ);
+			qpriv->s_retry = qp->s_retry_cnt;
+			hfi2_schedule_tid_send(qp);
+			break;
+
+		default:
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+ack_op_err:
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+}
+
+void hfi2_add_tid_retry_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_qp *ibqp = &qp->ibqp;
+	struct rvt_dev_info *rdi = ib_to_rvt(ibqp->device);
+
+	lockdep_assert_held(&qp->s_lock);
+	if (!(priv->s_flags & HFI2_S_TID_RETRY_TIMER)) {
+		priv->s_flags |= HFI2_S_TID_RETRY_TIMER;
+		priv->s_tid_retry_timer.expires = jiffies +
+			priv->tid_retry_timeout_jiffies + rdi->busy_jiffies;
+		add_timer(&priv->s_tid_retry_timer);
+	}
+}
+
+static void hfi2_mod_tid_retry_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_qp *ibqp = &qp->ibqp;
+	struct rvt_dev_info *rdi = ib_to_rvt(ibqp->device);
+
+	lockdep_assert_held(&qp->s_lock);
+	priv->s_flags |= HFI2_S_TID_RETRY_TIMER;
+	mod_timer(&priv->s_tid_retry_timer, jiffies +
+		  priv->tid_retry_timeout_jiffies + rdi->busy_jiffies);
+}
+
+static int hfi2_stop_tid_retry_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	int rval = 0;
+
+	lockdep_assert_held(&qp->s_lock);
+	if (priv->s_flags & HFI2_S_TID_RETRY_TIMER) {
+		rval = timer_delete(&priv->s_tid_retry_timer);
+		priv->s_flags &= ~HFI2_S_TID_RETRY_TIMER;
+	}
+	return rval;
+}
+
+void hfi2_del_tid_retry_timer(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	timer_delete_sync(&priv->s_tid_retry_timer);
+	priv->s_flags &= ~HFI2_S_TID_RETRY_TIMER;
+}
+
+static void hfi2_tid_retry_timeout(struct timer_list *t)
+{
+	struct hfi2_qp_priv *priv = from_timer(priv, t, s_tid_retry_timer);
+	struct rvt_qp *qp = priv->owner;
+	struct rvt_swqe *wqe;
+	unsigned long flags;
+	struct tid_rdma_request *req;
+
+	spin_lock_irqsave(&qp->r_lock, flags);
+	spin_lock(&qp->s_lock);
+	trace_hfi2_tid_write_sender_retry_timeout(qp, 0);
+	if (priv->s_flags & HFI2_S_TID_RETRY_TIMER) {
+		hfi2_stop_tid_retry_timer(qp);
+		if (!priv->s_retry) {
+			trace_hfi2_msg_tid_retry_timeout(/* msg */
+				qp,
+				"Exhausted retries. Tid retry timeout = ",
+				(u64)priv->tid_retry_timeout_jiffies);
+
+			wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+			hfi2_trdma_send_complete(qp, wqe, IB_WC_RETRY_EXC_ERR);
+			rvt_error_qp(qp, IB_WC_WR_FLUSH_ERR);
+		} else {
+			wqe = rvt_get_swqe_ptr(qp, qp->s_acked);
+			req = wqe_to_tid_req(wqe);
+			trace_hfi2_tid_req_tid_retry_timeout(/* req */
+			   qp, 0, wqe->wr.opcode, wqe->psn, wqe->lpsn, req);
+
+			priv->s_flags &= ~RVT_S_WAIT_ACK;
+			/* Only send one packet (the RESYNC) */
+			priv->s_flags |= RVT_S_SEND_ONE;
+			/*
+			 * No additional request shall be made by this QP until
+			 * the RESYNC has been complete.
+			 */
+			qp->s_flags |= HFI2_S_WAIT_HALT;
+			priv->s_state = TID_OP(RESYNC);
+			priv->s_retry--;
+			hfi2_schedule_tid_send(qp);
+		}
+	}
+	spin_unlock(&qp->s_lock);
+	spin_unlock_irqrestore(&qp->r_lock, flags);
+}
+
+u32 hfi2_build_tid_rdma_resync(struct rvt_qp *qp, struct rvt_swqe *wqe,
+			       struct ib_other_headers *ohdr, u32 *bth1,
+			       u32 *bth2, u16 fidx)
+{
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct tid_rdma_params *remote;
+	struct tid_rdma_request *req = wqe_to_tid_req(wqe);
+	struct tid_rdma_flow *flow = &req->flows[fidx];
+	u32 generation;
+
+	rcu_read_lock();
+	remote = rcu_dereference(qpriv->tid_rdma.remote);
+	KDETH_RESET(ohdr->u.tid_rdma.ack.kdeth1, JKEY, remote->jkey);
+	ohdr->u.tid_rdma.ack.verbs_qp = cpu_to_be32(qp->remote_qpn);
+	*bth1 = remote->qp;
+	rcu_read_unlock();
+
+	generation = kern_flow_generation_next(flow->flow_state.generation);
+	*bth2 = mask_psn((generation << HFI2_KDETH_BTH_SEQ_SHIFT) - 1);
+	qpriv->s_resync_psn = *bth2;
+	*bth2 |= IB_BTH_REQ_ACK;
+	KDETH_RESET(ohdr->u.tid_rdma.ack.kdeth0, KVER, 0x1);
+
+	return sizeof(ohdr->u.tid_rdma.resync) / sizeof(u32);
+}
+
+void hfi2_rc_rcv_tid_rdma_resync(struct hfi2_packet *packet)
+{
+	struct ib_other_headers *ohdr = packet->ohdr;
+	struct rvt_qp *qp = packet->qp;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct hfi2_ctxtdata *rcd = qpriv->rcd;
+	struct hfi2_ibdev *dev = to_idev(qp->ibqp.device);
+	struct rvt_ack_entry *e;
+	struct tid_rdma_request *req;
+	struct tid_rdma_flow *flow;
+	struct tid_flow_state *fs = &qpriv->flow_state;
+	u32 psn, generation, idx, gen_next;
+	bool fecn;
+	unsigned long flags;
+
+	fecn = process_ecn(qp, packet);
+	psn = mask_psn(be32_to_cpu(ohdr->bth[2]));
+
+	generation = mask_psn(psn + 1) >> HFI2_KDETH_BTH_SEQ_SHIFT;
+	spin_lock_irqsave(&qp->s_lock, flags);
+
+	gen_next = (fs->generation == KERN_GENERATION_RESERVED) ?
+		generation : kern_flow_generation_next(fs->generation);
+	/*
+	 * RESYNC packet contains the "next" generation and can only be
+	 * from the current or previous generations
+	 */
+	if (generation != mask_generation(gen_next - 1) &&
+	    generation != gen_next)
+		goto bail;
+	/* Already processing a resync */
+	if (qpriv->resync)
+		goto bail;
+
+	spin_lock(&rcd->exp_lock);
+	if (fs->index >= RXE_NUM_TID_FLOWS) {
+		/*
+		 * If we don't have a flow, save the generation so it can be
+		 * applied when a new flow is allocated
+		 */
+		fs->generation = generation;
+	} else {
+		/* Reprogram the QP flow with new generation */
+		rcd->flows[fs->index].generation = generation;
+		fs->generation = kern_setup_hw_flow(rcd, fs->index);
+	}
+	fs->psn = 0;
+	/*
+	 * Disable SW PSN checking since a RESYNC is equivalent to a
+	 * sync point and the flow has/will be reprogrammed
+	 */
+	qpriv->s_flags &= ~HFI2_R_TID_SW_PSN;
+	trace_hfi2_tid_write_rsp_rcv_resync(qp);
+
+	/*
+	 * Reset all TID flow information with the new generation.
+	 * This is done for all requests and segments after the
+	 * last received segment
+	 */
+	for (idx = qpriv->r_tid_tail; ; idx++) {
+		u16 flow_idx;
+
+		if (idx > rvt_size_atomic(&dev->rdi))
+			idx = 0;
+		e = &qp->s_ack_queue[idx];
+		if (e->opcode == TID_OP(WRITE_REQ)) {
+			req = ack_to_tid_req(e);
+			trace_hfi2_tid_req_rcv_resync(qp, 0, e->opcode, e->psn,
+						      e->lpsn, req);
+
+			/* start from last unacked segment */
+			for (flow_idx = req->clear_tail;
+			     CIRC_CNT(req->setup_head, flow_idx,
+				      MAX_FLOWS);
+			     flow_idx = CIRC_NEXT(flow_idx, MAX_FLOWS)) {
+				u32 lpsn;
+				u32 next;
+
+				flow = &req->flows[flow_idx];
+				lpsn = full_flow_psn(flow,
+						     flow->flow_state.lpsn);
+				next = flow->flow_state.r_next_psn;
+				flow->npkts = delta_psn(lpsn, next - 1);
+				flow->flow_state.generation = fs->generation;
+				flow->flow_state.spsn = fs->psn;
+				flow->flow_state.lpsn =
+					flow->flow_state.spsn + flow->npkts - 1;
+				flow->flow_state.r_next_psn =
+					full_flow_psn(flow,
+						      flow->flow_state.spsn);
+				fs->psn += flow->npkts;
+				trace_hfi2_tid_flow_rcv_resync(qp, flow_idx,
+							       flow);
+			}
+		}
+		if (idx == qp->s_tail_ack_queue)
+			break;
+	}
+
+	spin_unlock(&rcd->exp_lock);
+	qpriv->resync = true;
+	/* RESYNC request always gets a TID RDMA ACK. */
+	qpriv->s_nak_state = 0;
+	tid_rdma_trigger_ack(qp);
+bail:
+	if (fecn)
+		qp->s_flags |= RVT_S_ECN;
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+}
+
+/*
+ * Call this function when the last TID RDMA WRITE DATA packet for a request
+ * is built.
+ */
+static void update_tid_tail(struct rvt_qp *qp)
+	__must_hold(&qp->s_lock)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	u32 i;
+	struct rvt_swqe *wqe;
+
+	lockdep_assert_held(&qp->s_lock);
+	/* Can't move beyond s_tid_cur */
+	if (priv->s_tid_tail == priv->s_tid_cur)
+		return;
+	for (i = priv->s_tid_tail + 1; ; i++) {
+		if (i == qp->s_size)
+			i = 0;
+
+		if (i == priv->s_tid_cur)
+			break;
+		wqe = rvt_get_swqe_ptr(qp, i);
+		if (wqe->wr.opcode == IB_WR_TID_RDMA_WRITE)
+			break;
+	}
+	priv->s_tid_tail = i;
+	priv->s_state = TID_OP(WRITE_RESP);
+}
+
+int hfi2_make_tid_rdma_pkt(struct rvt_qp *qp, struct hfi2_pkt_state *ps)
+	__must_hold(&qp->s_lock)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct rvt_swqe *wqe;
+	u32 bth1 = 0, bth2 = 0, hwords = 5, len, middle = 0;
+	struct ib_other_headers *ohdr;
+	struct rvt_sge_state *ss = &qp->s_sge;
+	struct rvt_ack_entry *e = &qp->s_ack_queue[qp->s_tail_ack_queue];
+	struct tid_rdma_request *req = ack_to_tid_req(e);
+	bool last = false;
+	u8 opcode = TID_OP(WRITE_DATA);
+
+	lockdep_assert_held(&qp->s_lock);
+	trace_hfi2_tid_write_sender_make_tid_pkt(qp, 0);
+	/*
+	 * Prioritize the sending of the requests and responses over the
+	 * sending of the TID RDMA data packets.
+	 */
+	if (((atomic_read(&priv->n_tid_requests) < HFI2_TID_RDMA_WRITE_CNT) &&
+	     atomic_read(&priv->n_requests) &&
+	     !(qp->s_flags & (RVT_S_BUSY | RVT_S_WAIT_ACK |
+			     HFI2_S_ANY_WAIT_IO))) ||
+	    (e->opcode == TID_OP(WRITE_REQ) && req->cur_seg < req->alloc_seg &&
+	     !(qp->s_flags & (RVT_S_BUSY | HFI2_S_ANY_WAIT_IO)))) {
+		struct iowait_work *iowork;
+
+		iowork = iowait_get_ib_work(&priv->s_iowait);
+		ps->s_txreq = get_waiting_verbs_txreq(iowork);
+		if (ps->s_txreq || hfi2_make_rc_req(qp, ps)) {
+			priv->s_flags |= HFI2_S_TID_BUSY_SET;
+			return 1;
+		}
+	}
+
+	ps->s_txreq = alloc_txreq(ps->dev, qp);
+	if (!ps->s_txreq)
+		goto bail_no_tx;
+
+	ohdr = &ps->s_txreq->phdr.hdr.ibh.u.oth;
+
+	if ((priv->s_flags & RVT_S_ACK_PENDING) &&
+	    make_tid_rdma_ack(qp, ohdr, ps))
+		return 1;
+
+	/*
+	 * Bail out if we can't send data.
+	 * Be reminded that this check must been done after the call to
+	 * make_tid_rdma_ack() because the responding QP could be in
+	 * RTR state where it can send TID RDMA ACK, not TID RDMA WRITE DATA.
+	 */
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_SEND_OK))
+		goto bail;
+
+	if (priv->s_flags & RVT_S_WAIT_ACK)
+		goto bail;
+
+	/* Check whether there is anything to do. */
+	if (priv->s_tid_tail == HFI2_QP_WQE_INVALID)
+		goto bail;
+	wqe = rvt_get_swqe_ptr(qp, priv->s_tid_tail);
+	req = wqe_to_tid_req(wqe);
+	trace_hfi2_tid_req_make_tid_pkt(qp, 0, wqe->wr.opcode, wqe->psn,
+					wqe->lpsn, req);
+	switch (priv->s_state) {
+	case TID_OP(WRITE_REQ):
+	case TID_OP(WRITE_RESP):
+		priv->tid_ss.sge = wqe->sg_list[0];
+		priv->tid_ss.sg_list = wqe->sg_list + 1;
+		priv->tid_ss.num_sge = wqe->wr.num_sge;
+		priv->tid_ss.total_len = wqe->length;
+
+		if (priv->s_state == TID_OP(WRITE_REQ))
+			hfi2_tid_rdma_restart_req(qp, wqe, &bth2);
+		priv->s_state = TID_OP(WRITE_DATA);
+		fallthrough;
+
+	case TID_OP(WRITE_DATA):
+		/*
+		 * 1. Check whether TID RDMA WRITE RESP available.
+		 * 2. If no:
+		 *    2.1 If have more segments and no TID RDMA WRITE RESP,
+		 *        set HFI2_S_WAIT_TID_RESP
+		 *    2.2 Return indicating no progress made.
+		 * 3. If yes:
+		 *    3.1 Build TID RDMA WRITE DATA packet.
+		 *    3.2 If last packet in segment:
+		 *        3.2.1 Change KDETH header bits
+		 *        3.2.2 Advance RESP pointers.
+		 *    3.3 Return indicating progress made.
+		 */
+		trace_hfi2_sender_make_tid_pkt(qp);
+		trace_hfi2_tid_write_sender_make_tid_pkt(qp, 0);
+		wqe = rvt_get_swqe_ptr(qp, priv->s_tid_tail);
+		req = wqe_to_tid_req(wqe);
+		len = wqe->length;
+
+		if (!req->comp_seg || req->cur_seg == req->comp_seg)
+			goto bail;
+
+		trace_hfi2_tid_req_make_tid_pkt(qp, 0, wqe->wr.opcode,
+						wqe->psn, wqe->lpsn, req);
+		last = hfi2_build_tid_rdma_packet(wqe, ohdr, &bth1, &bth2,
+						  &len);
+
+		if (last) {
+			/* move pointer to next flow */
+			req->clear_tail = CIRC_NEXT(req->clear_tail,
+						    MAX_FLOWS);
+			if (++req->cur_seg < req->total_segs) {
+				if (!CIRC_CNT(req->setup_head, req->clear_tail,
+					      MAX_FLOWS))
+					qp->s_flags |= HFI2_S_WAIT_TID_RESP;
+			} else {
+				priv->s_state = TID_OP(WRITE_DATA_LAST);
+				opcode = TID_OP(WRITE_DATA_LAST);
+
+				/* Advance the s_tid_tail now */
+				update_tid_tail(qp);
+			}
+		}
+		hwords += sizeof(ohdr->u.tid_rdma.w_data) / sizeof(u32);
+		ss = &priv->tid_ss;
+		break;
+
+	case TID_OP(RESYNC):
+		trace_hfi2_sender_make_tid_pkt(qp);
+		/* Use generation from the most recently received response */
+		wqe = rvt_get_swqe_ptr(qp, priv->s_tid_cur);
+		req = wqe_to_tid_req(wqe);
+		/* If no responses for this WQE look at the previous one */
+		if (!req->comp_seg) {
+			wqe = rvt_get_swqe_ptr(qp,
+					       (!priv->s_tid_cur ? qp->s_size :
+						priv->s_tid_cur) - 1);
+			req = wqe_to_tid_req(wqe);
+		}
+		hwords += hfi2_build_tid_rdma_resync(qp, wqe, ohdr, &bth1,
+						     &bth2,
+						     CIRC_PREV(req->setup_head,
+							       MAX_FLOWS));
+		ss = NULL;
+		len = 0;
+		opcode = TID_OP(RESYNC);
+		break;
+
+	default:
+		goto bail;
+	}
+	if (priv->s_flags & RVT_S_SEND_ONE) {
+		priv->s_flags &= ~RVT_S_SEND_ONE;
+		priv->s_flags |= RVT_S_WAIT_ACK;
+		bth2 |= IB_BTH_REQ_ACK;
+	}
+	qp->s_len -= len;
+	ps->s_txreq->hdr_dwords = hwords;
+	ps->s_txreq->sde = priv->s_sde;
+	ps->s_txreq->ss = ss;
+	ps->s_txreq->s_cur_size = len;
+	hfi2_make_ruc_header(qp, ohdr, (opcode << 24), bth1, bth2,
+			     middle, ps);
+	return 1;
+bail:
+	hfi2_put_txreq(ps->s_txreq);
+bail_no_tx:
+	ps->s_txreq = NULL;
+	priv->s_flags &= ~RVT_S_BUSY;
+	/*
+	 * If we didn't get a txreq, the QP will be woken up later to try
+	 * again, set the flags to the wake up which work item to wake
+	 * up.
+	 * (A better algorithm should be found to do this and generalize the
+	 * sleep/wakeup flags.)
+	 */
+	iowait_set_flag(&priv->s_iowait, IOWAIT_PENDING_TID);
+	return 0;
+}
+
+static int make_tid_rdma_ack(struct rvt_qp *qp,
+			     struct ib_other_headers *ohdr,
+			     struct hfi2_pkt_state *ps)
+{
+	struct rvt_ack_entry *e;
+	struct hfi2_qp_priv *qpriv = qp->priv;
+	struct hfi2_ibdev *dev = to_idev(qp->ibqp.device);
+	u32 hwords, next;
+	u32 len = 0;
+	u32 bth1 = 0, bth2 = 0;
+	int middle = 0;
+	u16 flow;
+	struct tid_rdma_request *req, *nreq;
+
+	trace_hfi2_tid_write_rsp_make_tid_ack(qp);
+	/* Don't send an ACK if we aren't supposed to. */
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK))
+		goto bail;
+
+	/* header size in 32-bit words LRH+BTH = (8+12)/4. */
+	hwords = 5;
+
+	e = &qp->s_ack_queue[qpriv->r_tid_ack];
+	req = ack_to_tid_req(e);
+	/*
+	 * In the RESYNC case, we are exactly one segment past the
+	 * previously sent ack or at the previously sent NAK. So to send
+	 * the resync ack, we go back one segment (which might be part of
+	 * the previous request) and let the do-while loop execute again.
+	 * The advantage of executing the do-while loop is that any data
+	 * received after the previous ack is automatically acked in the
+	 * RESYNC ack. It turns out that for the do-while loop we only need
+	 * to pull back qpriv->r_tid_ack, not the segment
+	 * indices/counters. The scheme works even if the previous request
+	 * was not a TID WRITE request.
+	 */
+	if (qpriv->resync) {
+		if (!req->ack_seg || req->ack_seg == req->total_segs)
+			qpriv->r_tid_ack = !qpriv->r_tid_ack ?
+				rvt_size_atomic(&dev->rdi) :
+				qpriv->r_tid_ack - 1;
+		e = &qp->s_ack_queue[qpriv->r_tid_ack];
+		req = ack_to_tid_req(e);
+	}
+
+	trace_hfi2_rsp_make_tid_ack(qp, e->psn);
+	trace_hfi2_tid_req_make_tid_ack(qp, 0, e->opcode, e->psn, e->lpsn,
+					req);
+	/*
+	 * If we've sent all the ACKs that we can, we are done
+	 * until we get more segments...
+	 */
+	if (!qpriv->s_nak_state && !qpriv->resync &&
+	    req->ack_seg == req->comp_seg)
+		goto bail;
+
+	do {
+		/*
+		 * To deal with coalesced ACKs, the acked_tail pointer
+		 * into the flow array is used. The distance between it
+		 * and the clear_tail is the number of flows that are
+		 * being ACK'ed.
+		 */
+		req->ack_seg +=
+			/* Get up-to-date value */
+			CIRC_CNT(req->clear_tail, req->acked_tail,
+				 MAX_FLOWS);
+		/* Advance acked index */
+		req->acked_tail = req->clear_tail;
+
+		/*
+		 * req->clear_tail points to the segment currently being
+		 * received. So, when sending an ACK, the previous
+		 * segment is being ACK'ed.
+		 */
+		flow = CIRC_PREV(req->acked_tail, MAX_FLOWS);
+		if (req->ack_seg != req->total_segs)
+			break;
+		req->state = TID_REQUEST_COMPLETE;
+
+		next = qpriv->r_tid_ack + 1;
+		if (next > rvt_size_atomic(&dev->rdi))
+			next = 0;
+		qpriv->r_tid_ack = next;
+		if (qp->s_ack_queue[next].opcode != TID_OP(WRITE_REQ))
+			break;
+		nreq = ack_to_tid_req(&qp->s_ack_queue[next]);
+		if (!nreq->comp_seg || nreq->ack_seg == nreq->comp_seg)
+			break;
+
+		/* Move to the next ack entry now */
+		e = &qp->s_ack_queue[qpriv->r_tid_ack];
+		req = ack_to_tid_req(e);
+	} while (1);
+
+	/*
+	 * At this point qpriv->r_tid_ack == qpriv->r_tid_tail but e and
+	 * req could be pointing at the previous ack queue entry
+	 */
+	if (qpriv->s_nak_state ||
+	    (qpriv->resync &&
+	     !hfi2_tid_rdma_is_resync_psn(qpriv->r_next_psn_kdeth - 1) &&
+	     (cmp_psn(qpriv->r_next_psn_kdeth - 1,
+		      full_flow_psn(&req->flows[flow],
+				    req->flows[flow].flow_state.lpsn)) > 0))) {
+		/*
+		 * A NAK will implicitly acknowledge all previous TID RDMA
+		 * requests. Therefore, we NAK with the req->acked_tail
+		 * segment for the request at qpriv->r_tid_ack (same at
+		 * this point as the req->clear_tail segment for the
+		 * qpriv->r_tid_tail request)
+		 */
+		e = &qp->s_ack_queue[qpriv->r_tid_ack];
+		req = ack_to_tid_req(e);
+		flow = req->acked_tail;
+	} else if (req->ack_seg == req->total_segs &&
+		   qpriv->s_flags & HFI2_R_TID_WAIT_INTERLCK)
+		qpriv->s_flags &= ~HFI2_R_TID_WAIT_INTERLCK;
+
+	trace_hfi2_tid_write_rsp_make_tid_ack(qp);
+	trace_hfi2_tid_req_make_tid_ack(qp, 0, e->opcode, e->psn, e->lpsn,
+					req);
+	hwords += hfi2_build_tid_rdma_write_ack(qp, e, ohdr, flow, &bth1,
+						&bth2);
+	len = 0;
+	qpriv->s_flags &= ~RVT_S_ACK_PENDING;
+	ps->s_txreq->hdr_dwords = hwords;
+	ps->s_txreq->sde = qpriv->s_sde;
+	ps->s_txreq->s_cur_size = len;
+	ps->s_txreq->ss = NULL;
+	hfi2_make_ruc_header(qp, ohdr, (TID_OP(ACK) << 24), bth1, bth2, middle,
+			     ps);
+	ps->s_txreq->txreq.flags |= SDMA_TXREQ_F_VIP;
+	return 1;
+bail:
+	/*
+	 * Ensure s_rdma_ack_cnt changes are committed prior to resetting
+	 * RVT_S_RESP_PENDING
+	 */
+	smp_wmb();
+	qpriv->s_flags &= ~RVT_S_ACK_PENDING;
+	return 0;
+}
+
+static int hfi2_send_tid_ok(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	return !(priv->s_flags & RVT_S_BUSY ||
+		 qp->s_flags & HFI2_S_ANY_WAIT_IO) &&
+		(verbs_txreq_queued(iowait_get_tid_work(&priv->s_iowait)) ||
+		 (priv->s_flags & RVT_S_RESP_PENDING) ||
+		 !(qp->s_flags & HFI2_S_ANY_TID_WAIT_SEND));
+}
+
+void _hfi2_do_tid_send(struct work_struct *work)
+{
+	struct iowait_work *w = container_of(work, struct iowait_work, iowork);
+	struct rvt_qp *qp = iowait_to_qp(w->iow);
+
+	hfi2_do_tid_send(qp);
+}
+
+static void hfi2_do_tid_send(struct rvt_qp *qp)
+{
+	struct hfi2_pkt_state ps;
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	ps.dev = to_idev(qp->ibqp.device);
+	ps.ibp = to_iport(qp->ibqp.device, qp->port_num);
+	ps.ppd = ppd_from_ibp(ps.ibp);
+	ps.wait = iowait_get_tid_work(&priv->s_iowait);
+	ps.in_thread = false;
+	ps.timeout_int = qp->timeout_jiffies / 8;
+
+	trace_hfi2_rc_do_tid_send(qp, false);
+	spin_lock_irqsave(&qp->s_lock, ps.flags);
+
+	/* Return if we are already busy processing a work request. */
+	if (!hfi2_send_tid_ok(qp)) {
+		if (qp->s_flags & HFI2_S_ANY_WAIT_IO)
+			iowait_set_flag(&priv->s_iowait, IOWAIT_PENDING_TID);
+		spin_unlock_irqrestore(&qp->s_lock, ps.flags);
+		return;
+	}
+
+	priv->s_flags |= RVT_S_BUSY;
+
+	ps.timeout = jiffies + ps.timeout_int;
+	ps.cpu = priv->s_sde ? priv->s_sde->cpu :
+		cpumask_first(cpumask_of_node(ps.ppd->dd->node));
+	ps.pkts_sent = false;
+
+	/* insure a pre-built packet is handled  */
+	ps.s_txreq = get_waiting_verbs_txreq(ps.wait);
+	do {
+		/* Check for a constructed packet to be sent. */
+		if (ps.s_txreq) {
+			if (priv->s_flags & HFI2_S_TID_BUSY_SET) {
+				qp->s_flags |= RVT_S_BUSY;
+				ps.wait = iowait_get_ib_work(&priv->s_iowait);
+			}
+			spin_unlock_irqrestore(&qp->s_lock, ps.flags);
+
+			/*
+			 * If the packet cannot be sent now, return and
+			 * the send tasklet will be woken up later.
+			 */
+			if (hfi2_verbs_send(qp, &ps))
+				return;
+
+			/* allow other tasks to run */
+			if (hfi2_schedule_send_yield(qp, &ps, true))
+				return;
+
+			spin_lock_irqsave(&qp->s_lock, ps.flags);
+			if (priv->s_flags & HFI2_S_TID_BUSY_SET) {
+				qp->s_flags &= ~RVT_S_BUSY;
+				priv->s_flags &= ~HFI2_S_TID_BUSY_SET;
+				ps.wait = iowait_get_tid_work(&priv->s_iowait);
+				if (iowait_flag_set(&priv->s_iowait,
+						    IOWAIT_PENDING_IB))
+					hfi2_schedule_send(qp);
+			}
+		}
+	} while (hfi2_make_tid_rdma_pkt(qp, &ps));
+	iowait_starve_clear(ps.pkts_sent, &priv->s_iowait);
+	spin_unlock_irqrestore(&qp->s_lock, ps.flags);
+}
+
+static bool _hfi2_schedule_tid_send(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ibport *ibp =
+		to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	if ((dd->flags & HFI2_SHUTDOWN))
+		return true;
+
+	return iowait_tid_schedule(&priv->s_iowait, dd->hfi2_wq,
+				   priv->s_sde ?
+				   priv->s_sde->cpu :
+				   cpumask_first(cpumask_of_node(dd->node)));
+}
+
+/**
+ * hfi2_schedule_tid_send - schedule progress on TID RDMA state machine
+ * @qp: the QP
+ *
+ * This schedules qp progress on the TID RDMA state machine. Caller
+ * should hold the s_lock.
+ * Unlike hfi2_schedule_send(), this cannot use hfi2_send_ok() because
+ * the two state machines can step on each other with respect to the
+ * RVT_S_BUSY flag.
+ * Therefore, a modified test is used.
+ *
+ * Return: %true if the second leg is scheduled;
+ *  %false if the second leg is not scheduled.
+ */
+bool hfi2_schedule_tid_send(struct rvt_qp *qp)
+{
+	lockdep_assert_held(&qp->s_lock);
+	if (hfi2_send_tid_ok(qp)) {
+		/*
+		 * The following call returns true if the qp is not on the
+		 * queue and false if the qp is already on the queue before
+		 * this call. Either way, the qp will be on the queue when the
+		 * call returns.
+		 */
+		_hfi2_schedule_tid_send(qp);
+		return true;
+	}
+	if (qp->s_flags & HFI2_S_ANY_WAIT_IO)
+		iowait_set_flag(&((struct hfi2_qp_priv *)qp->priv)->s_iowait,
+				IOWAIT_PENDING_TID);
+	return false;
+}
+
+bool hfi2_tid_rdma_ack_interlock(struct rvt_qp *qp, struct rvt_ack_entry *e)
+{
+	struct rvt_ack_entry *prev;
+	struct tid_rdma_request *req;
+	struct hfi2_ibdev *dev = to_idev(qp->ibqp.device);
+	struct hfi2_qp_priv *priv = qp->priv;
+	u32 s_prev;
+
+	s_prev = qp->s_tail_ack_queue == 0 ? rvt_size_atomic(&dev->rdi) :
+		(qp->s_tail_ack_queue - 1);
+	prev = &qp->s_ack_queue[s_prev];
+
+	if ((e->opcode == TID_OP(READ_REQ) ||
+	     e->opcode == OP(RDMA_READ_REQUEST)) &&
+	    prev->opcode == TID_OP(WRITE_REQ)) {
+		req = ack_to_tid_req(prev);
+		if (req->ack_seg != req->total_segs) {
+			priv->s_flags |= HFI2_R_TID_WAIT_INTERLCK;
+			return true;
+		}
+	}
+	return false;
+}
+
+static u32 read_r_next_psn(struct hfi2_devdata *dd, u16 ctxt, u8 fidx)
+{
+	u64 reg;
+
+	/*
+	 * The only sane way to get the amount of
+	 * progress is to read the HW flow state.
+	 */
+	reg = read_uctxt_csr(dd, ctxt, dd->params->rcv_tid_flow_table_reg + (8 * fidx));
+	return mask_psn(reg);
+}
+
+static void tid_rdma_rcv_err(struct hfi2_packet *packet,
+			     struct ib_other_headers *ohdr,
+			     struct rvt_qp *qp, u32 psn, int diff, bool fecn)
+{
+	unsigned long flags;
+
+	tid_rdma_rcv_error(packet, ohdr, qp, psn, diff);
+	if (fecn) {
+		spin_lock_irqsave(&qp->s_lock, flags);
+		qp->s_flags |= RVT_S_ECN;
+		spin_unlock_irqrestore(&qp->s_lock, flags);
+	}
+}
+
+static void update_r_next_psn_fecn(struct hfi2_packet *packet,
+				   struct hfi2_qp_priv *priv,
+				   struct hfi2_ctxtdata *rcd,
+				   struct tid_rdma_flow *flow,
+				   bool fecn)
+{
+	/*
+	 * If a start/middle packet is delivered here due to
+	 * RSM rule and FECN, we need to update the r_next_psn.
+	 */
+	if (fecn && packet->etype == RHF_RCV_TYPE_EAGER &&
+	    !(priv->s_flags & HFI2_R_TID_SW_PSN)) {
+		struct hfi2_devdata *dd = rcd->dd;
+
+		flow->flow_state.r_next_psn =
+			read_r_next_psn(dd, rcd->ctxt, flow->idx);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/uc.c b/drivers/infiniband/hw/hfi2/uc.c
new file mode 100644
index 000000000000..534e9e7aa542
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/uc.c
@@ -0,0 +1,542 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#include "hfi2.h"
+#include "verbs_txreq.h"
+#include "qp.h"
+
+/* cut down ridiculously long IB macro names */
+#define OP(x) UC_OP(x)
+
+/**
+ * hfi2_make_uc_req - construct a request packet (SEND, RDMA write)
+ * @qp: a pointer to the QP
+ * @ps: the current packet state
+ *
+ * Assume s_lock is held.
+ *
+ * Return 1 if constructed; otherwise, return 0.
+ */
+int hfi2_make_uc_req(struct rvt_qp *qp, struct hfi2_pkt_state *ps)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_other_headers *ohdr;
+	struct rvt_swqe *wqe;
+	u32 hwords;
+	u32 bth0 = 0;
+	u32 len;
+	u32 pmtu = qp->pmtu;
+	int middle = 0;
+
+	ps->s_txreq = alloc_txreq(ps->dev, qp);
+	if (!ps->s_txreq)
+		goto bail_no_tx;
+
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_SEND_OK)) {
+		if (!(ib_rvt_state_ops[qp->state] & RVT_FLUSH_SEND))
+			goto bail;
+		/* We are in the error state, flush the work request. */
+		if (qp->s_last == READ_ONCE(qp->s_head))
+			goto bail;
+		/* If DMAs are in progress, we can't flush immediately. */
+		if (iowait_sdma_pending(&priv->s_iowait)) {
+			qp->s_flags |= RVT_S_WAIT_DMA;
+			goto bail;
+		}
+		clear_ahg(qp);
+		wqe = rvt_get_swqe_ptr(qp, qp->s_last);
+		rvt_send_complete(qp, wqe, IB_WC_WR_FLUSH_ERR);
+		goto done_free_tx;
+	}
+
+	if (priv->hdr_type == HFI2_PKT_TYPE_9B) {
+		/* header size in 32-bit words LRH+BTH = (8+12)/4. */
+		hwords = 5;
+		if (rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH)
+			ohdr = &ps->s_txreq->phdr.hdr.ibh.u.l.oth;
+		else
+			ohdr = &ps->s_txreq->phdr.hdr.ibh.u.oth;
+	} else {
+		/* header size in 32-bit words 16B LRH+BTH = (16+12)/4. */
+		hwords = 7;
+		if ((rdma_ah_get_ah_flags(&qp->remote_ah_attr) & IB_AH_GRH) &&
+		    (hfi2_check_mcast(rdma_ah_get_dlid(&qp->remote_ah_attr))))
+			ohdr = &ps->s_txreq->phdr.hdr.opah.u.l.oth;
+		else
+			ohdr = &ps->s_txreq->phdr.hdr.opah.u.oth;
+	}
+
+	/* Get the next send request. */
+	wqe = rvt_get_swqe_ptr(qp, qp->s_cur);
+	qp->s_wqe = NULL;
+	switch (qp->s_state) {
+	default:
+		if (!(ib_rvt_state_ops[qp->state] &
+		    RVT_PROCESS_NEXT_SEND_OK))
+			goto bail;
+		/* Check if send work queue is empty. */
+		if (qp->s_cur == READ_ONCE(qp->s_head)) {
+			clear_ahg(qp);
+			goto bail;
+		}
+		/*
+		 * Local operations are processed immediately
+		 * after all prior requests have completed.
+		 */
+		if (wqe->wr.opcode == IB_WR_REG_MR ||
+		    wqe->wr.opcode == IB_WR_LOCAL_INV) {
+			int local_ops = 0;
+			int err = 0;
+
+			if (qp->s_last != qp->s_cur)
+				goto bail;
+			if (++qp->s_cur == qp->s_size)
+				qp->s_cur = 0;
+			if (!(wqe->wr.send_flags & RVT_SEND_COMPLETION_ONLY)) {
+				err = rvt_invalidate_rkey(
+					qp, wqe->wr.ex.invalidate_rkey);
+				local_ops = 1;
+			}
+			rvt_send_complete(qp, wqe, err ? IB_WC_LOC_PROT_ERR
+							: IB_WC_SUCCESS);
+			if (local_ops)
+				atomic_dec(&qp->local_ops_pending);
+			goto done_free_tx;
+		}
+		/*
+		 * Start a new request.
+		 */
+		qp->s_psn = wqe->psn;
+		qp->s_sge.sge = wqe->sg_list[0];
+		qp->s_sge.sg_list = wqe->sg_list + 1;
+		qp->s_sge.num_sge = wqe->wr.num_sge;
+		qp->s_sge.total_len = wqe->length;
+		len = wqe->length;
+		qp->s_len = len;
+		switch (wqe->wr.opcode) {
+		case IB_WR_SEND:
+		case IB_WR_SEND_WITH_IMM:
+			if (len > pmtu) {
+				qp->s_state = OP(SEND_FIRST);
+				len = pmtu;
+				break;
+			}
+			if (wqe->wr.opcode == IB_WR_SEND) {
+				qp->s_state = OP(SEND_ONLY);
+			} else {
+				qp->s_state =
+					OP(SEND_ONLY_WITH_IMMEDIATE);
+				/* Immediate data comes after the BTH */
+				ohdr->u.imm_data = wqe->wr.ex.imm_data;
+				hwords += 1;
+			}
+			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+				bth0 |= IB_BTH_SOLICITED;
+			qp->s_wqe = wqe;
+			if (++qp->s_cur >= qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		case IB_WR_RDMA_WRITE:
+		case IB_WR_RDMA_WRITE_WITH_IMM:
+			ohdr->u.rc.reth.vaddr =
+				cpu_to_be64(wqe->rdma_wr.remote_addr);
+			ohdr->u.rc.reth.rkey =
+				cpu_to_be32(wqe->rdma_wr.rkey);
+			ohdr->u.rc.reth.length = cpu_to_be32(len);
+			hwords += sizeof(struct ib_reth) / 4;
+			if (len > pmtu) {
+				qp->s_state = OP(RDMA_WRITE_FIRST);
+				len = pmtu;
+				break;
+			}
+			if (wqe->wr.opcode == IB_WR_RDMA_WRITE) {
+				qp->s_state = OP(RDMA_WRITE_ONLY);
+			} else {
+				qp->s_state =
+					OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE);
+				/* Immediate data comes after the RETH */
+				ohdr->u.rc.imm_data = wqe->wr.ex.imm_data;
+				hwords += 1;
+				if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+					bth0 |= IB_BTH_SOLICITED;
+			}
+			qp->s_wqe = wqe;
+			if (++qp->s_cur >= qp->s_size)
+				qp->s_cur = 0;
+			break;
+
+		default:
+			goto bail;
+		}
+		break;
+
+	case OP(SEND_FIRST):
+		qp->s_state = OP(SEND_MIDDLE);
+		fallthrough;
+	case OP(SEND_MIDDLE):
+		len = qp->s_len;
+		if (len > pmtu) {
+			len = pmtu;
+			middle = HFI2_CAP_IS_KSET(SDMA_AHG);
+			break;
+		}
+		if (wqe->wr.opcode == IB_WR_SEND) {
+			qp->s_state = OP(SEND_LAST);
+		} else {
+			qp->s_state = OP(SEND_LAST_WITH_IMMEDIATE);
+			/* Immediate data comes after the BTH */
+			ohdr->u.imm_data = wqe->wr.ex.imm_data;
+			hwords += 1;
+		}
+		if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+			bth0 |= IB_BTH_SOLICITED;
+		qp->s_wqe = wqe;
+		if (++qp->s_cur >= qp->s_size)
+			qp->s_cur = 0;
+		break;
+
+	case OP(RDMA_WRITE_FIRST):
+		qp->s_state = OP(RDMA_WRITE_MIDDLE);
+		fallthrough;
+	case OP(RDMA_WRITE_MIDDLE):
+		len = qp->s_len;
+		if (len > pmtu) {
+			len = pmtu;
+			middle = HFI2_CAP_IS_KSET(SDMA_AHG);
+			break;
+		}
+		if (wqe->wr.opcode == IB_WR_RDMA_WRITE) {
+			qp->s_state = OP(RDMA_WRITE_LAST);
+		} else {
+			qp->s_state =
+				OP(RDMA_WRITE_LAST_WITH_IMMEDIATE);
+			/* Immediate data comes after the BTH */
+			ohdr->u.imm_data = wqe->wr.ex.imm_data;
+			hwords += 1;
+			if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+				bth0 |= IB_BTH_SOLICITED;
+		}
+		qp->s_wqe = wqe;
+		if (++qp->s_cur >= qp->s_size)
+			qp->s_cur = 0;
+		break;
+	}
+	qp->s_len -= len;
+	ps->s_txreq->hdr_dwords = hwords;
+	ps->s_txreq->sde = priv->s_sde;
+	ps->s_txreq->ss = &qp->s_sge;
+	ps->s_txreq->s_cur_size = len;
+	hfi2_make_ruc_header(qp, ohdr, bth0 | (qp->s_state << 24),
+			     qp->remote_qpn, mask_psn(qp->s_psn++),
+			     middle, ps);
+	return 1;
+
+done_free_tx:
+	hfi2_put_txreq(ps->s_txreq);
+	ps->s_txreq = NULL;
+	return 1;
+
+bail:
+	hfi2_put_txreq(ps->s_txreq);
+
+bail_no_tx:
+	ps->s_txreq = NULL;
+	qp->s_flags &= ~RVT_S_BUSY;
+	return 0;
+}
+
+/**
+ * hfi2_uc_rcv - handle an incoming UC packet
+ * @packet: the packet structure
+ *
+ * This is called from qp_rcv() to process an incoming UC packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+void hfi2_uc_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ibport *ibp = rcd_to_iport(packet->rcd);
+	void *data = packet->payload;
+	u32 tlen = packet->tlen;
+	struct rvt_qp *qp = packet->qp;
+	struct ib_other_headers *ohdr = packet->ohdr;
+	u32 opcode = packet->opcode;
+	u32 hdrsize = packet->hlen;
+	u32 psn;
+	u32 pad = packet->pad;
+	struct ib_wc wc;
+	u32 pmtu = qp->pmtu;
+	struct ib_reth *reth;
+	int ret;
+	u8 extra_bytes = pad + packet->extra_byte + (SIZE_OF_CRC << 2);
+
+	if (hfi2_ruc_check_hdr(ibp, packet))
+		return;
+
+	process_ecn(qp, packet);
+
+	psn = ib_bth_get_psn(ohdr);
+	/* Compare the PSN verses the expected PSN. */
+	if (unlikely(cmp_psn(psn, qp->r_psn) != 0)) {
+		/*
+		 * Handle a sequence error.
+		 * Silently drop any current message.
+		 */
+		qp->r_psn = psn;
+inv:
+		if (qp->r_state == OP(SEND_FIRST) ||
+		    qp->r_state == OP(SEND_MIDDLE)) {
+			set_bit(RVT_R_REWIND_SGE, &qp->r_aflags);
+			qp->r_sge.num_sge = 0;
+		} else {
+			rvt_put_ss(&qp->r_sge);
+		}
+		qp->r_state = OP(SEND_LAST);
+		switch (opcode) {
+		case OP(SEND_FIRST):
+		case OP(SEND_ONLY):
+		case OP(SEND_ONLY_WITH_IMMEDIATE):
+			goto send_first;
+
+		case OP(RDMA_WRITE_FIRST):
+		case OP(RDMA_WRITE_ONLY):
+		case OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE):
+			goto rdma_first;
+
+		default:
+			goto drop;
+		}
+	}
+
+	/* Check for opcode sequence errors. */
+	switch (qp->r_state) {
+	case OP(SEND_FIRST):
+	case OP(SEND_MIDDLE):
+		if (opcode == OP(SEND_MIDDLE) ||
+		    opcode == OP(SEND_LAST) ||
+		    opcode == OP(SEND_LAST_WITH_IMMEDIATE))
+			break;
+		goto inv;
+
+	case OP(RDMA_WRITE_FIRST):
+	case OP(RDMA_WRITE_MIDDLE):
+		if (opcode == OP(RDMA_WRITE_MIDDLE) ||
+		    opcode == OP(RDMA_WRITE_LAST) ||
+		    opcode == OP(RDMA_WRITE_LAST_WITH_IMMEDIATE))
+			break;
+		goto inv;
+
+	default:
+		if (opcode == OP(SEND_FIRST) ||
+		    opcode == OP(SEND_ONLY) ||
+		    opcode == OP(SEND_ONLY_WITH_IMMEDIATE) ||
+		    opcode == OP(RDMA_WRITE_FIRST) ||
+		    opcode == OP(RDMA_WRITE_ONLY) ||
+		    opcode == OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE))
+			break;
+		goto inv;
+	}
+
+	if (qp->state == IB_QPS_RTR && !(qp->r_flags & RVT_R_COMM_EST))
+		rvt_comm_est(qp);
+
+	/* OK, process the packet. */
+	switch (opcode) {
+	case OP(SEND_FIRST):
+	case OP(SEND_ONLY):
+	case OP(SEND_ONLY_WITH_IMMEDIATE):
+send_first:
+		if (test_and_clear_bit(RVT_R_REWIND_SGE, &qp->r_aflags)) {
+			qp->r_sge = qp->s_rdma_read_sge;
+		} else {
+			ret = rvt_get_rwqe(qp, false);
+			if (ret < 0)
+				goto op_err;
+			if (!ret)
+				goto drop;
+			/*
+			 * qp->s_rdma_read_sge will be the owner
+			 * of the mr references.
+			 */
+			qp->s_rdma_read_sge = qp->r_sge;
+		}
+		qp->r_rcv_len = 0;
+		if (opcode == OP(SEND_ONLY))
+			goto no_immediate_data;
+		else if (opcode == OP(SEND_ONLY_WITH_IMMEDIATE))
+			goto send_last_imm;
+		fallthrough;
+	case OP(SEND_MIDDLE):
+		/* Check for invalid length PMTU or posted rwqe len. */
+		/*
+		 * There will be no padding for 9B packet but 16B packets
+		 * will come in with some padding since we always add
+		 * CRC and LT bytes which will need to be flit aligned
+		 */
+		if (unlikely(tlen != (hdrsize + pmtu + extra_bytes)))
+			goto rewind;
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len))
+			goto rewind;
+		rvt_copy_sge(qp, &qp->r_sge, data, pmtu, false, false);
+		break;
+
+	case OP(SEND_LAST_WITH_IMMEDIATE):
+send_last_imm:
+		wc.ex.imm_data = ohdr->u.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+		goto send_last;
+	case OP(SEND_LAST):
+no_immediate_data:
+		wc.ex.imm_data = 0;
+		wc.wc_flags = 0;
+send_last:
+		/* Check for invalid length. */
+		/* LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + extra_bytes)))
+			goto rewind;
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + extra_bytes);
+		wc.byte_len = tlen + qp->r_rcv_len;
+		if (unlikely(wc.byte_len > qp->r_len))
+			goto rewind;
+		wc.opcode = IB_WC_RECV;
+		rvt_copy_sge(qp, &qp->r_sge, data, tlen, false, false);
+		rvt_put_ss(&qp->s_rdma_read_sge);
+last_imm:
+		wc.wr_id = qp->r_wr_id;
+		wc.status = IB_WC_SUCCESS;
+		wc.qp = &qp->ibqp;
+		wc.src_qp = qp->remote_qpn;
+		wc.slid = rdma_ah_get_dlid(&qp->remote_ah_attr) & U16_MAX;
+		/*
+		 * It seems that IB mandates the presence of an SL in a
+		 * work completion only for the UD transport (see section
+		 * 11.4.2 of IBTA Vol. 1).
+		 *
+		 * However, the way the SL is chosen below is consistent
+		 * with the way that IB/qib works and is trying avoid
+		 * introducing incompatibilities.
+		 *
+		 * See also OPA Vol. 1, section 9.7.6, and table 9-17.
+		 */
+		wc.sl = rdma_ah_get_sl(&qp->remote_ah_attr);
+		/* zero fields that are N/A */
+		wc.vendor_err = 0;
+		wc.pkey_index = 0;
+		wc.dlid_path_bits = 0;
+		wc.port_num = 0;
+		/* Signal completion event if the solicited bit is set. */
+		rvt_recv_cq(qp, &wc, ib_bth_is_solicited(ohdr));
+		break;
+
+	case OP(RDMA_WRITE_FIRST):
+	case OP(RDMA_WRITE_ONLY):
+	case OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE): /* consume RWQE */
+rdma_first:
+		if (unlikely(!(qp->qp_access_flags &
+			       IB_ACCESS_REMOTE_WRITE))) {
+			goto drop;
+		}
+		reth = &ohdr->u.rc.reth;
+		qp->r_len = be32_to_cpu(reth->length);
+		qp->r_rcv_len = 0;
+		qp->r_sge.sg_list = NULL;
+		if (qp->r_len != 0) {
+			u32 rkey = be32_to_cpu(reth->rkey);
+			u64 vaddr = be64_to_cpu(reth->vaddr);
+			int ok;
+
+			/* Check rkey */
+			ok = rvt_rkey_ok(qp, &qp->r_sge.sge, qp->r_len,
+					 vaddr, rkey, IB_ACCESS_REMOTE_WRITE);
+			if (unlikely(!ok))
+				goto drop;
+			qp->r_sge.num_sge = 1;
+		} else {
+			qp->r_sge.num_sge = 0;
+			qp->r_sge.sge.mr = NULL;
+			qp->r_sge.sge.vaddr = NULL;
+			qp->r_sge.sge.length = 0;
+			qp->r_sge.sge.sge_length = 0;
+		}
+		if (opcode == OP(RDMA_WRITE_ONLY)) {
+			goto rdma_last;
+		} else if (opcode == OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE)) {
+			wc.ex.imm_data = ohdr->u.rc.imm_data;
+			goto rdma_last_imm;
+		}
+		fallthrough;
+	case OP(RDMA_WRITE_MIDDLE):
+		/* Check for invalid length PMTU or posted rwqe len. */
+		if (unlikely(tlen != (hdrsize + pmtu + 4)))
+			goto drop;
+		qp->r_rcv_len += pmtu;
+		if (unlikely(qp->r_rcv_len > qp->r_len))
+			goto drop;
+		rvt_copy_sge(qp, &qp->r_sge, data, pmtu, true, false);
+		break;
+
+	case OP(RDMA_WRITE_LAST_WITH_IMMEDIATE):
+		wc.ex.imm_data = ohdr->u.imm_data;
+rdma_last_imm:
+		wc.wc_flags = IB_WC_WITH_IMM;
+
+		/* Check for invalid length. */
+		/* LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4)))
+			goto drop;
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + extra_bytes);
+		if (unlikely(tlen + qp->r_rcv_len != qp->r_len))
+			goto drop;
+		if (test_and_clear_bit(RVT_R_REWIND_SGE, &qp->r_aflags)) {
+			rvt_put_ss(&qp->s_rdma_read_sge);
+		} else {
+			ret = rvt_get_rwqe(qp, true);
+			if (ret < 0)
+				goto op_err;
+			if (!ret)
+				goto drop;
+		}
+		wc.byte_len = qp->r_len;
+		wc.opcode = IB_WC_RECV_RDMA_WITH_IMM;
+		rvt_copy_sge(qp, &qp->r_sge, data, tlen, true, false);
+		rvt_put_ss(&qp->r_sge);
+		goto last_imm;
+
+	case OP(RDMA_WRITE_LAST):
+rdma_last:
+		/* Check for invalid length. */
+		/* LAST len should be >= 1 */
+		if (unlikely(tlen < (hdrsize + pad + 4)))
+			goto drop;
+		/* Don't count the CRC. */
+		tlen -= (hdrsize + extra_bytes);
+		if (unlikely(tlen + qp->r_rcv_len != qp->r_len))
+			goto drop;
+		rvt_copy_sge(qp, &qp->r_sge, data, tlen, true, false);
+		rvt_put_ss(&qp->r_sge);
+		break;
+
+	default:
+		/* Drop packet for unknown opcodes. */
+		goto drop;
+	}
+	qp->r_psn++;
+	qp->r_state = opcode;
+	return;
+
+rewind:
+	set_bit(RVT_R_REWIND_SGE, &qp->r_aflags);
+	qp->r_sge.num_sge = 0;
+drop:
+	ibp->rvp.n_pkt_drops++;
+	return;
+
+op_err:
+	rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
+}
diff --git a/drivers/infiniband/hw/hfi2/ud.c b/drivers/infiniband/hw/hfi2/ud.c
new file mode 100644
index 000000000000..f339fd5aaabd
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ud.c
@@ -0,0 +1,1030 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation.
+ */
+
+#include <linux/net.h>
+#include <rdma/ib_smi.h>
+
+#include "hfi2.h"
+#include "mad.h"
+#include "verbs_txreq.h"
+#include "trace_ibhdrs.h"
+#include "qp.h"
+
+/* We support only two types - 9B and 16B for now */
+static const hfi2_make_req hfi2_make_ud_req_tbl[2] = {
+	[HFI2_PKT_TYPE_9B] = &hfi2_make_ud_req_9B,
+	[HFI2_PKT_TYPE_16B] = &hfi2_make_ud_req_16B
+};
+
+/**
+ * ud_loopback - handle send on loopback QPs
+ * @sqp: the sending QP
+ * @swqe: the send work request
+ *
+ * This is called from hfi2_make_ud_req() to forward a WQE addressed
+ * to the same HFI.
+ * Note that the receive interrupt handler may be calling hfi2_ud_rcv()
+ * while this is being called.
+ */
+static void ud_loopback(struct rvt_qp *sqp, struct rvt_swqe *swqe)
+{
+	struct hfi2_ibport *ibp = to_iport(sqp->ibqp.device, sqp->port_num);
+	struct hfi2_pportdata *ppd;
+	struct hfi2_qp_priv *priv = sqp->priv;
+	struct rvt_qp *qp;
+	struct rdma_ah_attr *ah_attr;
+	unsigned long flags;
+	struct rvt_sge_state ssge;
+	struct rvt_sge *sge;
+	struct ib_wc wc;
+	u32 length;
+	enum ib_qp_type sqptype, dqptype;
+
+	rcu_read_lock();
+
+	qp = rvt_lookup_qpn(ib_to_rvt(sqp->ibqp.device), &ibp->rvp,
+			    rvt_get_swqe_remote_qpn(swqe));
+	if (!qp) {
+		ibp->rvp.n_pkt_drops++;
+		rcu_read_unlock();
+		return;
+	}
+
+	sqptype = sqp->ibqp.qp_type == IB_QPT_GSI ?
+			IB_QPT_UD : sqp->ibqp.qp_type;
+	dqptype = qp->ibqp.qp_type == IB_QPT_GSI ?
+			IB_QPT_UD : qp->ibqp.qp_type;
+
+	if (dqptype != sqptype ||
+	    !(ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK)) {
+		ibp->rvp.n_pkt_drops++;
+		goto drop;
+	}
+
+	ah_attr = rvt_get_swqe_ah_attr(swqe);
+	ppd = ppd_from_ibp(ibp);
+
+	if (qp->ibqp.qp_num > 1) {
+		u16 pkey;
+		u32 slid;
+		u8 sc5 = ibp->sl_to_sc[rdma_ah_get_sl(ah_attr)];
+
+		pkey = hfi2_get_pkey(ibp, sqp->s_pkey_index);
+		slid = ppd->lid | (rdma_ah_get_path_bits(ah_attr) &
+				   ((1 << ppd->lmc) - 1));
+		if (unlikely(ingress_pkey_check(ppd, pkey, sc5,
+						qp->s_pkey_index,
+						slid, false))) {
+			hfi2_bad_pkey(ibp, pkey,
+				      rdma_ah_get_sl(ah_attr),
+				      sqp->ibqp.qp_num, qp->ibqp.qp_num,
+				      slid, rdma_ah_get_dlid(ah_attr));
+			goto drop;
+		}
+	}
+
+	/*
+	 * Check that the qkey matches (except for QP0, see 9.6.1.4.1).
+	 * Qkeys with the high order bit set mean use the
+	 * qkey from the QP context instead of the WR (see 10.2.5).
+	 */
+	if (qp->ibqp.qp_num) {
+		u32 qkey;
+
+		qkey = (int)rvt_get_swqe_remote_qkey(swqe) < 0 ?
+			sqp->qkey : rvt_get_swqe_remote_qkey(swqe);
+		if (unlikely(qkey != qp->qkey))
+			goto drop; /* silently drop per IBTA spec */
+	}
+
+	/*
+	 * A GRH is expected to precede the data even if not
+	 * present on the wire.
+	 */
+	length = swqe->length;
+	memset(&wc, 0, sizeof(wc));
+	wc.byte_len = length + sizeof(struct ib_grh);
+
+	if (swqe->wr.opcode == IB_WR_SEND_WITH_IMM) {
+		wc.wc_flags = IB_WC_WITH_IMM;
+		wc.ex.imm_data = swqe->wr.ex.imm_data;
+	}
+
+	spin_lock_irqsave(&qp->r_lock, flags);
+
+	/*
+	 * Get the next work request entry to find where to put the data.
+	 */
+	if (qp->r_flags & RVT_R_REUSE_SGE) {
+		qp->r_flags &= ~RVT_R_REUSE_SGE;
+	} else {
+		int ret;
+
+		ret = rvt_get_rwqe(qp, false);
+		if (ret < 0) {
+			rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
+			goto bail_unlock;
+		}
+		if (!ret) {
+			if (qp->ibqp.qp_num == 0)
+				ibp->rvp.n_vl15_dropped++;
+			goto bail_unlock;
+		}
+	}
+	/* Silently drop packets which are too big. */
+	if (unlikely(wc.byte_len > qp->r_len)) {
+		qp->r_flags |= RVT_R_REUSE_SGE;
+		ibp->rvp.n_pkt_drops++;
+		goto bail_unlock;
+	}
+
+	if (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) {
+		struct ib_grh grh;
+		struct ib_global_route grd = *(rdma_ah_read_grh(ah_attr));
+
+		/*
+		 * For loopback packets with extended LIDs, the
+		 * sgid_index in the GRH is 0 and the dgid is
+		 * OPA GID of the sender. While creating a response
+		 * to the loopback packet, IB core creates the new
+		 * sgid_index from the DGID and that will be the
+		 * OPA_GID_INDEX. The new dgid is from the sgid
+		 * index and that will be in the IB GID format.
+		 *
+		 * We now have a case where the sent packet had a
+		 * different sgid_index and dgid compared to the
+		 * one that was received in response.
+		 *
+		 * Fix this inconsistency.
+		 */
+		if (priv->hdr_type == HFI2_PKT_TYPE_16B) {
+			if (grd.sgid_index == 0)
+				grd.sgid_index = OPA_GID_INDEX;
+
+			if (ib_is_opa_gid(&grd.dgid))
+				grd.dgid.global.interface_id =
+				cpu_to_be64(ppd->guids[HFI2_PORT_GUID_INDEX]);
+		}
+
+		hfi2_make_grh(ibp, &grh, &grd, 0, 0);
+		rvt_copy_sge(qp, &qp->r_sge, &grh,
+			     sizeof(grh), true, false);
+		wc.wc_flags |= IB_WC_GRH;
+	} else {
+		rvt_skip_sge(&qp->r_sge, sizeof(struct ib_grh), true);
+	}
+	ssge.sg_list = swqe->sg_list + 1;
+	ssge.sge = *swqe->sg_list;
+	ssge.num_sge = swqe->wr.num_sge;
+	sge = &ssge.sge;
+	while (length) {
+		u32 len = rvt_get_sge_length(sge, length);
+
+		WARN_ON_ONCE(len == 0);
+		rvt_copy_sge(qp, &qp->r_sge, sge->vaddr, len, true, false);
+		rvt_update_sge(&ssge, len, false);
+		length -= len;
+	}
+	rvt_put_ss(&qp->r_sge);
+	if (!test_and_clear_bit(RVT_R_WRID_VALID, &qp->r_aflags))
+		goto bail_unlock;
+	wc.wr_id = qp->r_wr_id;
+	wc.status = IB_WC_SUCCESS;
+	wc.opcode = IB_WC_RECV;
+	wc.qp = &qp->ibqp;
+	wc.src_qp = sqp->ibqp.qp_num;
+	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_SMI) {
+		if (sqp->ibqp.qp_type == IB_QPT_GSI ||
+		    sqp->ibqp.qp_type == IB_QPT_SMI)
+			wc.pkey_index = rvt_get_swqe_pkey_index(swqe);
+		else
+			wc.pkey_index = sqp->s_pkey_index;
+	} else {
+		wc.pkey_index = 0;
+	}
+	wc.slid = (ppd->lid | (rdma_ah_get_path_bits(ah_attr) &
+				   ((1 << ppd->lmc) - 1))) & U16_MAX;
+	/* Check for loopback when the port lid is not set */
+	if (wc.slid == 0 && sqp->ibqp.qp_type == IB_QPT_GSI)
+		wc.slid = be16_to_cpu(IB_LID_PERMISSIVE);
+	wc.sl = rdma_ah_get_sl(ah_attr);
+	wc.dlid_path_bits = rdma_ah_get_dlid(ah_attr) & ((1 << ppd->lmc) - 1);
+	wc.port_num = qp->port_num;
+	/* Signal completion event if the solicited bit is set. */
+	rvt_recv_cq(qp, &wc, swqe->wr.send_flags & IB_SEND_SOLICITED);
+	ibp->rvp.n_loop_pkts++;
+bail_unlock:
+	spin_unlock_irqrestore(&qp->r_lock, flags);
+drop:
+	rcu_read_unlock();
+}
+
+static void hfi2_make_bth_deth(struct rvt_qp *qp, struct rvt_swqe *wqe,
+			       struct ib_other_headers *ohdr,
+			       u16 *pkey, u32 extra_bytes, bool bypass)
+{
+	u32 bth0;
+	struct hfi2_ibport *ibp;
+
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+	if (wqe->wr.opcode == IB_WR_SEND_WITH_IMM) {
+		ohdr->u.ud.imm_data = wqe->wr.ex.imm_data;
+		bth0 = IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE << 24;
+	} else {
+		bth0 = IB_OPCODE_UD_SEND_ONLY << 24;
+	}
+
+	if (wqe->wr.send_flags & IB_SEND_SOLICITED)
+		bth0 |= IB_BTH_SOLICITED;
+	bth0 |= extra_bytes << 20;
+	if (qp->ibqp.qp_type == IB_QPT_GSI || qp->ibqp.qp_type == IB_QPT_SMI)
+		*pkey = hfi2_get_pkey(ibp, rvt_get_swqe_pkey_index(wqe));
+	else
+		*pkey = hfi2_get_pkey(ibp, qp->s_pkey_index);
+	if (!bypass)
+		bth0 |= *pkey;
+	ohdr->bth[0] = cpu_to_be32(bth0);
+	ohdr->bth[1] = cpu_to_be32(rvt_get_swqe_remote_qpn(wqe));
+	ohdr->bth[2] = cpu_to_be32(mask_psn(wqe->psn));
+	/*
+	 * Qkeys with the high order bit set mean use the
+	 * qkey from the QP context instead of the WR (see 10.2.5).
+	 */
+	ohdr->u.ud.deth[0] =
+		cpu_to_be32((int)rvt_get_swqe_remote_qkey(wqe) < 0 ? qp->qkey :
+			    rvt_get_swqe_remote_qkey(wqe));
+	ohdr->u.ud.deth[1] = cpu_to_be32(qp->ibqp.qp_num);
+}
+
+void hfi2_make_ud_req_9B(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			 struct rvt_swqe *wqe)
+{
+	u32 nwords, extra_bytes;
+	u16 len, slid, dlid, pkey;
+	u16 lrh0 = 0;
+	u8 sc5;
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_other_headers *ohdr;
+	struct rdma_ah_attr *ah_attr;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ibport *ibp;
+	struct ib_grh *grh;
+
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+	ppd = ppd_from_ibp(ibp);
+	ah_attr = rvt_get_swqe_ah_attr(wqe);
+
+	extra_bytes = -wqe->length & 3;
+	nwords = ((wqe->length + extra_bytes) >> 2) + SIZE_OF_CRC;
+	/* header size in dwords LRH+BTH+DETH = (8+12+8)/4. */
+	ps->s_txreq->hdr_dwords = 7;
+	if (wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
+		ps->s_txreq->hdr_dwords++;
+
+	if (rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) {
+		grh = &ps->s_txreq->phdr.hdr.ibh.u.l.grh;
+		ps->s_txreq->hdr_dwords +=
+			hfi2_make_grh(ibp, grh, rdma_ah_read_grh(ah_attr),
+				      ps->s_txreq->hdr_dwords - LRH_9B_DWORDS,
+				      nwords);
+		lrh0 = HFI2_LRH_GRH;
+		ohdr = &ps->s_txreq->phdr.hdr.ibh.u.l.oth;
+	} else {
+		lrh0 = HFI2_LRH_BTH;
+		ohdr = &ps->s_txreq->phdr.hdr.ibh.u.oth;
+	}
+
+	sc5 = ibp->sl_to_sc[rdma_ah_get_sl(ah_attr)];
+	lrh0 |= (rdma_ah_get_sl(ah_attr) & 0xf) << 4;
+	if (qp->ibqp.qp_type == IB_QPT_SMI) {
+		lrh0 |= 0xF000; /* Set VL (see ch. 13.5.3.1) */
+		priv->s_sc = 0xf;
+	} else {
+		lrh0 |= (sc5 & 0xf) << 12;
+		priv->s_sc = sc5;
+	}
+
+	dlid = opa_get_lid(rdma_ah_get_dlid(ah_attr), 9B);
+	if (dlid == be16_to_cpu(IB_LID_PERMISSIVE)) {
+		slid = be16_to_cpu(IB_LID_PERMISSIVE);
+	} else {
+		u16 lid = (u16)ppd->lid;
+
+		if (lid) {
+			lid |= rdma_ah_get_path_bits(ah_attr) &
+				((1 << ppd->lmc) - 1);
+			slid = lid;
+		} else {
+			slid = be16_to_cpu(IB_LID_PERMISSIVE);
+		}
+	}
+	hfi2_make_bth_deth(qp, wqe, ohdr, &pkey, extra_bytes, false);
+	len = ps->s_txreq->hdr_dwords + nwords;
+
+	/* Setup the packet */
+	ps->s_txreq->phdr.hdr.hdr_type = HFI2_PKT_TYPE_9B;
+	hfi2_make_ib_hdr(&ps->s_txreq->phdr.hdr.ibh,
+			 lrh0, len, dlid, slid);
+}
+
+void hfi2_make_ud_req_16B(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			  struct rvt_swqe *wqe)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_other_headers *ohdr;
+	struct rdma_ah_attr *ah_attr;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ibport *ibp;
+	u32 dlid, slid, nwords, extra_bytes;
+	u32 dest_qp = rvt_get_swqe_remote_qpn(wqe);
+	u32 src_qp = qp->ibqp.qp_num;
+	u16 len, pkey;
+	u8 l4, sc5;
+	bool is_mgmt = false;
+
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+	ppd = ppd_from_ibp(ibp);
+	ah_attr = rvt_get_swqe_ah_attr(wqe);
+
+	/*
+	 * Build 16B Management Packet if either the destination
+	 * or source queue pair number is 0 or 1.
+	 */
+	if (dest_qp == 0 || src_qp == 0 || dest_qp == 1 || src_qp == 1) {
+		/* header size in dwords 16B LRH+L4_FM = (16+8)/4. */
+		ps->s_txreq->hdr_dwords = 6;
+		is_mgmt = true;
+	} else {
+		/* header size in dwords 16B LRH+BTH+DETH = (16+12+8)/4. */
+		ps->s_txreq->hdr_dwords = 9;
+		if (wqe->wr.opcode == IB_WR_SEND_WITH_IMM)
+			ps->s_txreq->hdr_dwords++;
+	}
+
+	if (ppd->dd->params->chip_type == CHIP_WFR) {
+		/* SW provides space for CRC and LT for bypass packets. */
+		extra_bytes = hfi2_get_16b_padding((ps->s_txreq->hdr_dwords << 2),
+						   wqe->length);
+		nwords = ((wqe->length + extra_bytes + SIZE_OF_LT) >> 2) + SIZE_OF_CRC;
+	} else {
+		/* pad total message to a multiple of 8 */
+		extra_bytes = hfi2_pad8((ps->s_txreq->hdr_dwords << 2) +
+					wqe->length);
+		/* add in ICRC QW */
+		nwords = (wqe->length + extra_bytes + 8) >> 2;
+	}
+
+	if ((rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH) &&
+	    hfi2_check_mcast(rdma_ah_get_dlid(ah_attr))) {
+		struct ib_grh *grh;
+		struct ib_global_route *grd = rdma_ah_retrieve_grh(ah_attr);
+		/*
+		 * Ensure OPA GIDs are transformed to IB gids
+		 * before creating the GRH.
+		 */
+		if (grd->sgid_index == OPA_GID_INDEX) {
+			ppd_dev_warn(ppd, "Bad sgid_index. sgid_index: %d\n",
+				     grd->sgid_index);
+			grd->sgid_index = 0;
+		}
+		grh = &ps->s_txreq->phdr.hdr.opah.u.l.grh;
+		ps->s_txreq->hdr_dwords += hfi2_make_grh(
+			ibp, grh, grd,
+			ps->s_txreq->hdr_dwords - LRH_16B_DWORDS,
+			nwords);
+		ohdr = &ps->s_txreq->phdr.hdr.opah.u.l.oth;
+		l4 = OPA_16B_L4_IB_GLOBAL;
+	} else {
+		ohdr = &ps->s_txreq->phdr.hdr.opah.u.oth;
+		l4 = OPA_16B_L4_IB_LOCAL;
+	}
+
+	sc5 = ibp->sl_to_sc[rdma_ah_get_sl(ah_attr)];
+	if (qp->ibqp.qp_type == IB_QPT_SMI)
+		priv->s_sc = 0xf;
+	else
+		priv->s_sc = sc5;
+
+	dlid = opa_get_lid(rdma_ah_get_dlid(ah_attr), 16B);
+	if (!ppd->lid)
+		slid = be32_to_cpu(OPA_LID_PERMISSIVE);
+	else
+		slid = ppd->lid | (rdma_ah_get_path_bits(ah_attr) &
+			   ((1 << ppd->lmc) - 1));
+
+	if (is_mgmt) {
+		l4 = OPA_16B_L4_FM;
+		pkey = hfi2_get_pkey(ibp, rvt_get_swqe_pkey_index(wqe));
+		hfi2_16B_set_qpn(&ps->s_txreq->phdr.hdr.opah.u.mgmt,
+				 dest_qp, src_qp);
+	} else {
+		hfi2_make_bth_deth(qp, wqe, ohdr, &pkey, extra_bytes, true);
+	}
+	/* Convert dwords to flits */
+	len = (ps->s_txreq->hdr_dwords + nwords) >> 1;
+
+	/* Setup the packet */
+	ps->s_txreq->phdr.hdr.hdr_type = HFI2_PKT_TYPE_16B;
+	hfi2_make_16b_hdr(&ps->s_txreq->phdr.hdr.opah,
+			  slid, dlid, len, pkey, 0, 0, l4, priv->s_sc);
+}
+
+/**
+ * hfi2_make_ud_req - construct a UD request packet
+ * @qp: the QP
+ * @ps: the current packet state
+ *
+ * Assume s_lock is held.
+ *
+ * Return 1 if constructed; otherwise, return 0.
+ */
+int hfi2_make_ud_req(struct rvt_qp *qp, struct hfi2_pkt_state *ps)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct rdma_ah_attr *ah_attr;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_ibport *ibp;
+	struct rvt_swqe *wqe;
+	int next_cur;
+	u32 lid;
+
+	ps->s_txreq = alloc_txreq(ps->dev, qp);
+	if (!ps->s_txreq)
+		goto bail_no_tx;
+
+	if (!(ib_rvt_state_ops[qp->state] & RVT_PROCESS_NEXT_SEND_OK)) {
+		if (!(ib_rvt_state_ops[qp->state] & RVT_FLUSH_SEND))
+			goto bail;
+		/* We are in the error state, flush the work request. */
+		if (qp->s_last == READ_ONCE(qp->s_head))
+			goto bail;
+		/* If DMAs are in progress, we can't flush immediately. */
+		if (iowait_sdma_pending(&priv->s_iowait)) {
+			qp->s_flags |= RVT_S_WAIT_DMA;
+			goto bail;
+		}
+		wqe = rvt_get_swqe_ptr(qp, qp->s_last);
+		rvt_send_complete(qp, wqe, IB_WC_WR_FLUSH_ERR);
+		goto done_free_tx;
+	}
+
+	/* see post_one_send() */
+	if (qp->s_cur == READ_ONCE(qp->s_head))
+		goto bail;
+
+	wqe = rvt_get_swqe_ptr(qp, qp->s_cur);
+	next_cur = qp->s_cur + 1;
+	if (next_cur >= qp->s_size)
+		next_cur = 0;
+
+	/* Construct the header. */
+	ibp = to_iport(qp->ibqp.device, qp->port_num);
+	ppd = ppd_from_ibp(ibp);
+	ah_attr = rvt_get_swqe_ah_attr(wqe);
+	priv->hdr_type = hfi2_get_hdr_type(ppd->lid, ah_attr);
+	if ((!hfi2_check_mcast(rdma_ah_get_dlid(ah_attr))) ||
+	    (rdma_ah_get_dlid(ah_attr) == be32_to_cpu(OPA_LID_PERMISSIVE))) {
+		lid = rdma_ah_get_dlid(ah_attr) & ~((1 << ppd->lmc) - 1);
+		if (unlikely(!loopback &&
+			     ((lid == ppd->lid) ||
+			      ((lid == be32_to_cpu(OPA_LID_PERMISSIVE)) &&
+			       (qp->ibqp.qp_type == IB_QPT_GSI))))) {
+			unsigned long tflags = ps->flags;
+			/*
+			 * If DMAs are in progress, we can't generate
+			 * a completion for the loopback packet since
+			 * it would be out of order.
+			 * Instead of waiting, we could queue a
+			 * zero length descriptor so we get a callback.
+			 */
+			if (iowait_sdma_pending(&priv->s_iowait)) {
+				qp->s_flags |= RVT_S_WAIT_DMA;
+				goto bail;
+			}
+			qp->s_cur = next_cur;
+			spin_unlock_irqrestore(&qp->s_lock, tflags);
+			ud_loopback(qp, wqe);
+			spin_lock_irqsave(&qp->s_lock, tflags);
+			ps->flags = tflags;
+			rvt_send_complete(qp, wqe, IB_WC_SUCCESS);
+			goto done_free_tx;
+		}
+	}
+
+	qp->s_cur = next_cur;
+	ps->s_txreq->s_cur_size = wqe->length;
+	ps->s_txreq->ss = &qp->s_sge;
+	qp->s_srate = rdma_ah_get_static_rate(ah_attr);
+	qp->srate_mbps = ib_rate_to_mbps(qp->s_srate);
+	qp->s_wqe = wqe;
+	qp->s_sge.sge = wqe->sg_list[0];
+	qp->s_sge.sg_list = wqe->sg_list + 1;
+	qp->s_sge.num_sge = wqe->wr.num_sge;
+	qp->s_sge.total_len = wqe->length;
+
+	/* Make the appropriate header */
+	hfi2_make_ud_req_tbl[priv->hdr_type](qp, ps, qp->s_wqe);
+	priv->s_sde = qp_to_sdma_engine(qp, priv->s_sc);
+	ps->s_txreq->sde = priv->s_sde;
+	priv->s_sendcontext = qp_to_send_context(qp, priv->s_sc);
+	ps->s_txreq->psc = priv->s_sendcontext;
+	/* disarm any ahg */
+	priv->s_ahg->ahgcount = 0;
+	priv->s_ahg->ahgidx = 0;
+	priv->s_ahg->tx_flags = 0;
+
+	return 1;
+
+done_free_tx:
+	hfi2_put_txreq(ps->s_txreq);
+	ps->s_txreq = NULL;
+	return 1;
+
+bail:
+	hfi2_put_txreq(ps->s_txreq);
+
+bail_no_tx:
+	ps->s_txreq = NULL;
+	qp->s_flags &= ~RVT_S_BUSY;
+	return 0;
+}
+
+/*
+ * Hardware can't check this so we do it here.
+ *
+ * This is a slightly different algorithm than the standard pkey check.  It
+ * special cases the management keys and allows for 0x7fff and 0xffff to be in
+ * the table at the same time.
+ *
+ * @returns the index found or -1 if not found
+ */
+int hfi2_lookup_pkey_idx(struct hfi2_ibport *ibp, u16 pkey)
+{
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	unsigned i;
+
+	if (pkey == FULL_MGMT_P_KEY || pkey == LIM_MGMT_P_KEY) {
+		unsigned lim_idx = -1;
+
+		for (i = 0; i < ppd->dd->params->pkey_table_size; ++i) {
+			/* here we look for an exact match */
+			if (ppd->pkeys[i] == pkey)
+				return i;
+			if (ppd->pkeys[i] == LIM_MGMT_P_KEY)
+				lim_idx = i;
+		}
+
+		/* did not find 0xffff return 0x7fff idx if found */
+		if (pkey == FULL_MGMT_P_KEY)
+			return lim_idx;
+
+		/* no match...  */
+		return -1;
+	}
+
+	pkey &= 0x7fff; /* remove limited/full membership bit */
+
+	for (i = 0; i < ppd->dd->params->pkey_table_size; ++i)
+		if ((ppd->pkeys[i] & 0x7fff) == pkey)
+			return i;
+
+	/*
+	 * Should not get here, this means hardware failed to validate pkeys.
+	 */
+	return -1;
+}
+
+void return_cnp_16B(struct hfi2_ibport *ibp, struct rvt_qp *qp,
+		    u32 remote_qpn, u16 pkey, u32 slid, u32 dlid,
+		    u8 sc5, const struct ib_grh *old_grh)
+{
+	u64 pbc;
+	u32 bth0, plen, vl, hwords = 7;
+	u32 extra_bytes;
+	u16 len;
+	u8 l4;
+	struct hfi2_opa_header hdr;
+	struct ib_other_headers *ohdr;
+	struct pio_buf *pbuf;
+	struct send_context *ctxt = qp_to_send_context(qp, sc5);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 nwords;
+
+	hdr.hdr_type = HFI2_PKT_TYPE_16B;
+	/* Populate length */
+	if (dd->params->chip_type == CHIP_WFR) {
+		extra_bytes = hfi2_get_16b_padding(hwords << 2, 0);
+		nwords = ((extra_bytes + SIZE_OF_LT) >> 2) + SIZE_OF_CRC;
+	} else {
+		/* pad to multiple of 8 */
+		extra_bytes = hfi2_pad8(hwords);
+		/* add ICRC QW */
+		nwords = (extra_bytes + 8) >> 2;
+	}
+	if (old_grh) {
+		struct ib_grh *grh = &hdr.opah.u.l.grh;
+
+		grh->version_tclass_flow = old_grh->version_tclass_flow;
+		grh->paylen = cpu_to_be16(
+			(hwords - LRH_16B_DWORDS + nwords) << 2);
+		grh->hop_limit = 0xff;
+		grh->sgid = old_grh->dgid;
+		grh->dgid = old_grh->sgid;
+		ohdr = &hdr.opah.u.l.oth;
+		l4 = OPA_16B_L4_IB_GLOBAL;
+		hwords += sizeof(struct ib_grh) / sizeof(u32);
+	} else {
+		ohdr = &hdr.opah.u.oth;
+		l4 = OPA_16B_L4_IB_LOCAL;
+	}
+
+	/* BIT 16 to 19 is TVER. Bit 20 to 22 is pad cnt */
+	bth0 = (IB_OPCODE_CNP << 24) | (1 << 16) | (extra_bytes << 20);
+	ohdr->bth[0] = cpu_to_be32(bth0);
+
+	ohdr->bth[1] = cpu_to_be32(remote_qpn);
+	ohdr->bth[2] = 0; /* PSN 0 */
+
+	/* Convert dwords to flits */
+	len = (hwords + nwords) >> 1;
+	hfi2_make_16b_hdr(&hdr.opah, slid, dlid, len, pkey, 1, 0, l4, sc5);
+
+	plen = 2 /* PBC */ + hwords + nwords;
+	vl = sc_to_vlt(ppd, sc5);
+	if (ctxt) {
+		pbc = dd->params->create_pbc(ppd, 0, qp->srate_mbps, vl, plen,
+					     PBC_L2_16B, dlid,
+					     ctxt->hw_context);
+		pbuf = sc_buffer_alloc(ctxt, plen, NULL, NULL);
+		if (!IS_ERR_OR_NULL(pbuf)) {
+			trace_pio_output_ibhdr(dd, &hdr, sc5, 0);
+			dd->pio_inline_send(dd, pbuf, pbc, &hdr, hwords);
+		}
+	}
+}
+
+void return_cnp(struct hfi2_ibport *ibp, struct rvt_qp *qp, u32 remote_qpn,
+		u16 pkey, u32 slid, u32 dlid, u8 sc5,
+		const struct ib_grh *old_grh)
+{
+	u64 pbc, pbc_flags = 0;
+	u32 bth0, plen, vl, hwords = 5;
+	u16 lrh0;
+	u8 sl = ibp->sc_to_sl[sc5];
+	struct hfi2_opa_header hdr;
+	struct ib_other_headers *ohdr;
+	struct pio_buf *pbuf;
+	struct send_context *ctxt = qp_to_send_context(qp, sc5);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	hdr.hdr_type = HFI2_PKT_TYPE_9B;
+	if (old_grh) {
+		struct ib_grh *grh = &hdr.ibh.u.l.grh;
+
+		grh->version_tclass_flow = old_grh->version_tclass_flow;
+		grh->paylen = cpu_to_be16(
+			(hwords - LRH_9B_DWORDS + SIZE_OF_CRC) << 2);
+		grh->hop_limit = 0xff;
+		grh->sgid = old_grh->dgid;
+		grh->dgid = old_grh->sgid;
+		ohdr = &hdr.ibh.u.l.oth;
+		lrh0 = HFI2_LRH_GRH;
+		hwords += sizeof(struct ib_grh) / sizeof(u32);
+	} else {
+		ohdr = &hdr.ibh.u.oth;
+		lrh0 = HFI2_LRH_BTH;
+	}
+
+	lrh0 |= (sc5 & 0xf) << 12 | sl << 4;
+
+	bth0 = pkey | (IB_OPCODE_CNP << 24);
+	ohdr->bth[0] = cpu_to_be32(bth0);
+
+	ohdr->bth[1] = cpu_to_be32(remote_qpn | (1 << IB_BECN_SHIFT));
+	ohdr->bth[2] = 0; /* PSN 0 */
+
+	hfi2_make_ib_hdr(&hdr.ibh, lrh0, hwords + SIZE_OF_CRC, dlid, slid);
+	plen = 2 /* PBC */ + hwords;
+	pbc_flags |= pbc_sc4_flag(sc5);
+	vl = sc_to_vlt(ppd, sc5);
+	if (ctxt) {
+		pbc = dd->params->create_pbc(ppd, pbc_flags, qp->srate_mbps, vl,
+					     plen, PBC_L2_9B, dlid,
+					     ctxt->hw_context);
+		pbuf = sc_buffer_alloc(ctxt, plen, NULL, NULL);
+		if (!IS_ERR_OR_NULL(pbuf)) {
+			trace_pio_output_ibhdr(dd, &hdr, sc5, 0);
+			dd->pio_inline_send(dd, pbuf, pbc, &hdr, hwords);
+		}
+	}
+}
+
+/*
+ * opa_smp_check() - Do the regular pkey checking, and the additional
+ * checks for SMPs specified in OPAv1 rev 1.0, 9/19/2016 update, section
+ * 9.10.25 ("SMA Packet Checks").
+ *
+ * Note that:
+ *   - Checks are done using the pkey directly from the packet's BTH,
+ *     and specifically _not_ the pkey that we attach to the completion,
+ *     which may be different.
+ *   - These checks are specifically for "non-local" SMPs (i.e., SMPs
+ *     which originated on another node). SMPs which are sent from, and
+ *     destined to this node are checked in opa_local_smp_check().
+ *
+ * At the point where opa_smp_check() is called, we know:
+ *   - destination QP is QP0
+ *
+ * opa_smp_check() returns 0 if all checks succeed, 1 otherwise.
+ */
+static int opa_smp_check(struct hfi2_ibport *ibp, u16 pkey, u8 sc5,
+			 struct rvt_qp *qp, u16 slid, struct opa_smp *smp)
+{
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+
+	/*
+	 * I don't think it's possible for us to get here with sc != 0xf,
+	 * but check it to be certain.
+	 */
+	if (sc5 != 0xf)
+		return 1;
+
+	if (rcv_pkey_check(ppd, pkey, sc5, slid))
+		return 1;
+
+	/*
+	 * At this point we know (and so don't need to check again) that
+	 * the pkey is either LIM_MGMT_P_KEY, or FULL_MGMT_P_KEY
+	 * (see ingress_pkey_check).
+	 */
+	if (smp->mgmt_class != IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE &&
+	    smp->mgmt_class != IB_MGMT_CLASS_SUBN_LID_ROUTED) {
+		ingress_pkey_table_fail(ppd, pkey, slid);
+		return 1;
+	}
+
+	/*
+	 * SMPs fall into one of four (disjoint) categories:
+	 * SMA request, SMA response, SMA trap, or SMA trap repress.
+	 * Our response depends, in part, on which type of SMP we're
+	 * processing.
+	 *
+	 * If this is an SMA response, skip the check here.
+	 *
+	 * If this is an SMA request or SMA trap repress:
+	 *   - pkey != FULL_MGMT_P_KEY =>
+	 *       increment port recv constraint errors, drop MAD
+	 *
+	 * Otherwise:
+	 *    - accept if the port is running an SM
+	 *    - drop MAD if it's an SMA trap
+	 *    - pkey == FULL_MGMT_P_KEY =>
+	 *        reply with unsupported method
+	 *    - pkey != FULL_MGMT_P_KEY =>
+	 *	  increment port recv constraint errors, drop MAD
+	 */
+	switch (smp->method) {
+	case IB_MGMT_METHOD_GET_RESP:
+	case IB_MGMT_METHOD_REPORT_RESP:
+		break;
+	case IB_MGMT_METHOD_GET:
+	case IB_MGMT_METHOD_SET:
+	case IB_MGMT_METHOD_REPORT:
+	case IB_MGMT_METHOD_TRAP_REPRESS:
+		if (pkey != FULL_MGMT_P_KEY) {
+			ingress_pkey_table_fail(ppd, pkey, slid);
+			return 1;
+		}
+		break;
+	default:
+		if (ibp->rvp.port_cap_flags & IB_PORT_SM)
+			return 0;
+		if (smp->method == IB_MGMT_METHOD_TRAP)
+			return 1;
+		if (pkey == FULL_MGMT_P_KEY) {
+			smp->status |= IB_SMP_UNSUP_METHOD;
+			return 0;
+		}
+		ingress_pkey_table_fail(ppd, pkey, slid);
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * hfi2_ud_rcv - receive an incoming UD packet
+ * @packet: the packet structure
+ *
+ * This is called from qp_rcv() to process an incoming UD packet
+ * for the given QP.
+ * Called at interrupt level.
+ */
+void hfi2_ud_rcv(struct hfi2_packet *packet)
+{
+	u32 hdrsize = packet->hlen;
+	struct ib_wc wc;
+	u32 src_qp;
+	u16 pkey;
+	int mgmt_pkey_idx = -1;
+	struct hfi2_ibport *ibp = rcd_to_iport(packet->rcd);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	void *data = packet->payload;
+	u32 tlen = packet->tlen;
+	struct rvt_qp *qp = packet->qp;
+	u8 sc5 = packet->sc;
+	u8 sl_from_sc;
+	u8 opcode = packet->opcode;
+	u8 sl = packet->sl;
+	u32 dlid = packet->dlid;
+	u32 slid = packet->slid;
+	u8 extra_bytes;
+	u8 l4 = 0;
+	bool dlid_is_permissive;
+	bool slid_is_permissive;
+	bool solicited = false;
+
+	extra_bytes = packet->pad + packet->extra_byte + (SIZE_OF_CRC << 2);
+
+	if (packet->etype == RHF_RCV_TYPE_BYPASS) {
+		u32 permissive_lid =
+			opa_get_lid(be32_to_cpu(OPA_LID_PERMISSIVE), 16B);
+
+		l4 = hfi2_16B_get_l4(packet->hdr);
+		pkey = hfi2_16B_get_pkey(packet->hdr);
+		dlid_is_permissive = (dlid == permissive_lid);
+		slid_is_permissive = (slid == permissive_lid);
+	} else {
+		pkey = ib_bth_get_pkey(packet->ohdr);
+		dlid_is_permissive = (dlid == be16_to_cpu(IB_LID_PERMISSIVE));
+		slid_is_permissive = (slid == be16_to_cpu(IB_LID_PERMISSIVE));
+	}
+	sl_from_sc = ibp->sc_to_sl[sc5];
+
+	if (likely(l4 != OPA_16B_L4_FM)) {
+		src_qp = ib_get_sqpn(packet->ohdr);
+		solicited = ib_bth_is_solicited(packet->ohdr);
+	} else {
+		src_qp = hfi2_16B_get_src_qpn(packet->mgmt);
+	}
+
+	process_ecn(qp, packet);
+	/*
+	 * Get the number of bytes the message was padded by
+	 * and drop incomplete packets.
+	 */
+	if (unlikely(tlen < (hdrsize + extra_bytes)))
+		goto drop;
+
+	tlen -= hdrsize + extra_bytes;
+
+	/*
+	 * Check that the permissive LID is only used on QP0
+	 * and the QKEY matches (see 9.6.1.4.1 and 9.6.1.5.1).
+	 */
+	if (qp->ibqp.qp_num) {
+		if (unlikely(dlid_is_permissive || slid_is_permissive))
+			goto drop;
+		if (qp->ibqp.qp_num > 1) {
+			if (unlikely(rcv_pkey_check(ppd, pkey, sc5, slid))) {
+				/*
+				 * Traps will not be sent for packets dropped
+				 * by the HW. This is fine, as sending trap
+				 * for invalid pkeys is optional according to
+				 * IB spec (release 1.3, section 10.9.4)
+				 */
+				hfi2_bad_pkey(ibp,
+					      pkey, sl,
+					      src_qp, qp->ibqp.qp_num,
+					      slid, dlid);
+				return;
+			}
+		} else {
+			/* GSI packet */
+			mgmt_pkey_idx = hfi2_lookup_pkey_idx(ibp, pkey);
+			if (mgmt_pkey_idx < 0)
+				goto drop;
+		}
+		if (unlikely(l4 != OPA_16B_L4_FM &&
+			     ib_get_qkey(packet->ohdr) != qp->qkey))
+			return; /* Silent drop */
+
+		/* Drop invalid MAD packets (see 13.5.3.1). */
+		if (unlikely(qp->ibqp.qp_num == 1 &&
+			     (tlen > 2048 || (sc5 == 0xF))))
+			goto drop;
+	} else {
+		/* Received on QP0, and so by definition, this is an SMP */
+		struct opa_smp *smp = (struct opa_smp *)data;
+
+		if (opa_smp_check(ibp, pkey, sc5, qp, slid, smp))
+			goto drop;
+
+		if (tlen > 2048)
+			goto drop;
+		if ((dlid_is_permissive || slid_is_permissive) &&
+		    smp->mgmt_class != IB_MGMT_CLASS_SUBN_DIRECTED_ROUTE)
+			goto drop;
+
+		/* look up SMI pkey */
+		mgmt_pkey_idx = hfi2_lookup_pkey_idx(ibp, pkey);
+		if (mgmt_pkey_idx < 0)
+			goto drop;
+	}
+
+	if (qp->ibqp.qp_num > 1 &&
+	    opcode == IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE) {
+		wc.ex.imm_data = packet->ohdr->u.ud.imm_data;
+		wc.wc_flags = IB_WC_WITH_IMM;
+	} else if (opcode == IB_OPCODE_UD_SEND_ONLY) {
+		wc.ex.imm_data = 0;
+		wc.wc_flags = 0;
+	} else {
+		goto drop;
+	}
+
+	/*
+	 * A GRH is expected to precede the data even if not
+	 * present on the wire.
+	 */
+	wc.byte_len = tlen + sizeof(struct ib_grh);
+
+	/*
+	 * Get the next work request entry to find where to put the data.
+	 */
+	if (qp->r_flags & RVT_R_REUSE_SGE) {
+		qp->r_flags &= ~RVT_R_REUSE_SGE;
+	} else {
+		int ret;
+
+		ret = rvt_get_rwqe(qp, false);
+		if (ret < 0) {
+			rvt_rc_error(qp, IB_WC_LOC_QP_OP_ERR);
+			return;
+		}
+		if (!ret) {
+			if (qp->ibqp.qp_num == 0)
+				ibp->rvp.n_vl15_dropped++;
+			return;
+		}
+	}
+	/* Silently drop packets which are too big. */
+	if (unlikely(wc.byte_len > qp->r_len)) {
+		qp->r_flags |= RVT_R_REUSE_SGE;
+		goto drop;
+	}
+	if (packet->grh) {
+		rvt_copy_sge(qp, &qp->r_sge, packet->grh,
+			     sizeof(struct ib_grh), true, false);
+		wc.wc_flags |= IB_WC_GRH;
+	} else {
+		rvt_skip_sge(&qp->r_sge, sizeof(struct ib_grh), true);
+	}
+	rvt_copy_sge(qp, &qp->r_sge, data, wc.byte_len - sizeof(struct ib_grh),
+		     true, false);
+	rvt_put_ss(&qp->r_sge);
+	if (!test_and_clear_bit(RVT_R_WRID_VALID, &qp->r_aflags))
+		return;
+	wc.wr_id = qp->r_wr_id;
+	wc.status = IB_WC_SUCCESS;
+	wc.opcode = IB_WC_RECV;
+	wc.vendor_err = 0;
+	wc.qp = &qp->ibqp;
+	wc.src_qp = src_qp;
+
+	if (qp->ibqp.qp_type == IB_QPT_GSI ||
+	    qp->ibqp.qp_type == IB_QPT_SMI) {
+		if (mgmt_pkey_idx < 0) {
+			if (net_ratelimit()) {
+				struct hfi2_devdata *dd = ppd->dd;
+
+				dd_dev_err(dd, "QP type %d mgmt_pkey_idx < 0 and packet not dropped???\n",
+					   qp->ibqp.qp_type);
+				mgmt_pkey_idx = 0;
+			}
+		}
+		wc.pkey_index = (unsigned)mgmt_pkey_idx;
+	} else {
+		wc.pkey_index = 0;
+	}
+	if (slid_is_permissive)
+		slid = be32_to_cpu(OPA_LID_PERMISSIVE);
+	wc.slid = slid & U16_MAX;
+	wc.sl = sl_from_sc;
+
+	/*
+	 * Save the LMC lower bits if the destination LID is a unicast LID.
+	 */
+	wc.dlid_path_bits = hfi2_check_mcast(dlid) ? 0 :
+		dlid & ((1 << ppd_from_ibp(ibp)->lmc) - 1);
+	wc.port_num = qp->port_num;
+	/* Signal completion event if the solicited bit is set. */
+	rvt_recv_cq(qp, &wc, solicited);
+	return;
+
+drop:
+	ibp->rvp.n_pkt_drops++;
+}
diff --git a/drivers/infiniband/hw/hfi2/uverbs.c b/drivers/infiniband/hw/hfi2/uverbs.c
new file mode 100644
index 000000000000..37dd366376d5
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/uverbs.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2024 Cornelis Networks, Inc.
+ */
+
+#include "hfi2.h"
+#include "user_sdma.h"
+#include "uverbs.h"
+#include "file_ops.h"
+
+#define UVERBS_MODULE_NAME hfi2_uv
+#include <rdma/uverbs_named_ioctl.h>
+
+static const u64 zero8; /* 8 bytes of 0 */
+
+/*
+ * RDMA mmap token: <type> << <page offset>
+ *
+ * Expect type to be less than 256 (8 bits).  rdmavt reserves the bottom 256
+ * tokens for the driver.  A type of zero is always considered invalid.
+ * Types >= 256 are used for rdmavt's dynamic token generation.
+ */
+
+/* convert RDMA mmap token to type: the first 8 bits above a page */
+static inline u8 rdma_mmap_get_type(unsigned long token)
+{
+	return token >> PAGE_SHIFT;
+}
+
+/* calculate the token from an integer offset */
+static inline unsigned long rdma_mmap_token_i(u8 type, unsigned long offset)
+{
+	return ((unsigned long)type << PAGE_SHIFT) | offset_in_page(offset);
+}
+
+/* calculate the token from a pointer offset */
+static inline unsigned long rdma_mmap_token_p(u8 type, void *offset)
+{
+	return rdma_mmap_token_i(type, (unsigned long)offset);
+}
+
+int hfi2_alloc_ucontext(struct ib_ucontext *ucontext, struct ib_udata *udata)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(ucontext->device);
+	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
+	struct hfi2_filedata *fd;
+
+	fd = hfi2_alloc_filedata(dd);
+	if (!fd)
+		return -ENOMEM;
+
+	rcontext->priv = fd;
+
+	return 0;
+}
+
+void hfi2_dealloc_ucontext(struct ib_ucontext *ucontext)
+{
+	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
+	struct hfi2_filedata *fd;
+
+	fd = rcontext->priv;
+	if (fd) {
+		hfi2_dealloc_filedata(fd);
+		rcontext->priv = NULL;
+	}
+}
+
+static inline struct hfi2_filedata *fd_from_attrs(struct uverbs_attr_bundle *attrs)
+{
+	struct ib_ucontext *ucontext = ib_uverbs_get_ucontext(attrs);
+	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
+
+	return rcontext->priv;
+}
+
+static int UVERBS_HANDLER(HFI2_METHOD_ASSIGN_CTXT)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_assign_ctxt_cmd cmd;
+	unsigned int swmajor;
+	int ret;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_ASSIGN_CTXT_CMD);
+	if (ret)
+		return ret;
+
+	swmajor = cmd.userversion >> HFI2_SWMAJOR_SHIFT;
+	if (swmajor != HFI2_RDMA_USER_SWMAJOR)
+		return -ENODEV;
+
+	if (cmd.reserved1 != 0 || cmd.reserved2 != 0)
+		return -EINVAL;
+
+	return hfi2_do_assign_ctxt(fd, &cmd);
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_CTXT_INFO)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_ctxt_info_rsp rsp = {};
+
+	if (!uctxt)
+		return -EINVAL;
+
+	rsp.runtime_flags = (((uctxt->flags >> HFI2_CAP_MISC_SHIFT) &
+				HFI2_CAP_MISC_MASK) << HFI2_CAP_USER_SHIFT) |
+			    HFI2_CAP_UGET_MASK(uctxt->flags, MASK) |
+			    HFI2_CAP_KGET_MASK(uctxt->flags, K2U);
+	/* adjust flag if this fd is not able to cache */
+	if (!fd->use_mn)
+		rsp.runtime_flags |= HFI2_CAP_TID_UNMAP; /* no caching */
+
+	rsp.num_active = hfi2_count_active_units();
+	rsp.unit = uctxt->dd->unit;
+	rsp.ctxt = uctxt->ctxt;
+	rsp.subctxt = fd->subctxt;
+	rsp.rcvtids = roundup(uctxt->egrbufs.alloced,
+			      uctxt->dd->rcv_entries.group_size) +
+		      uctxt->expected_count;
+	rsp.credits = uctxt->sc->credits;
+	rsp.numa_node = uctxt->numa_id;
+	rsp.rec_cpu = fd->rec_cpu_num;
+	rsp.send_ctxt = uctxt->sc->hw_context;
+
+	rsp.egrtids = uctxt->egrbufs.alloced;
+	rsp.rcvhdrq_cnt = get_hdrq_cnt(uctxt);
+	rsp.rcvhdrq_entsize = get_hdrqentsize(uctxt) << 2;
+	rsp.sdma_ring_size = fd->cq->nentries;
+	rsp.rcvegr_size = uctxt->egrbufs.rcvtid_size;
+
+	return uverbs_copy_to(attrs, HFI2_ATTR_CTXT_INFO_RSP, &rsp,
+			      sizeof(rsp));
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_USER_INFO)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_user_info_rsp rsp = {};
+	struct hfi2_devdata *dd;
+	unsigned long offset;
+
+	if (!uctxt)
+		return -EINVAL;
+	dd = uctxt->dd;
+
+	rsp.hw_version = dd->revision;
+	rsp.sw_version = HFI2_USER_SWVERSION;
+	rsp.bthqp = RVT_KDETH_QP_PREFIX;
+	rsp.jkey = uctxt->jkey;
+	/*
+	 * If more than 64 contexts are enabled, the allocated credit return
+	 * will span two or three contiguous pages. Only the page containing
+	 * the context's credit return address is mapped.  Calculate the offset
+	 * in the proper page.
+	 */
+	offset = ((u64)uctxt->sc->hw_free -
+		  (u64)dd->cr_base[uctxt->numa_id].va) % PAGE_SIZE;
+	rsp.sc_credits_addr = rdma_mmap_token_i(PIO_CRED, offset);
+	rsp.pio_bufbase = rdma_mmap_token_p(PIO_BUFS, uctxt->sc->base_addr);
+	rsp.pio_bufbase_sop = rdma_mmap_token_p(PIO_BUFS_SOP,
+						uctxt->sc->base_addr);
+	rsp.rcvhdr_bufbase = rdma_mmap_token_p(RCV_HDRQ, uctxt->rcvhdrq);
+	rsp.rcvegr_bufbase = rdma_mmap_token_i(RCV_EGRBUF,
+					       uctxt->egrbufs.rcvtids[0].dma);
+	rsp.sdma_comp_bufbase = rdma_mmap_token_i(SDMA_COMP, 0);
+	/*
+	 * user regs are at
+	 * (RXE_PER_CONTEXT_USER + (ctxt * RXE_PER_CONTEXT_SIZE))
+	 */
+	rsp.user_regbase = rdma_mmap_token_i(UREGS, 0);
+	offset = offset_in_page((uctxt_offset(uctxt) + fd->subctxt) *
+				sizeof(*dd->events));
+	rsp.events_bufbase = rdma_mmap_token_i(EVENTS, offset);
+	rsp.status_bufbase = rdma_mmap_token_p(STATUS, dd->status);
+	if (HFI2_CAP_IS_USET(DMA_RTAIL))
+		rsp.rcvhdrtail_base = rdma_mmap_token_i(RTAIL, 0);
+	if (uctxt->subctxt_cnt) {
+		rsp.subctxt_uregbase = rdma_mmap_token_i(SUBCTXT_UREGS, 0);
+		rsp.subctxt_rcvhdrbuf = rdma_mmap_token_i(SUBCTXT_RCV_HDRQ, 0);
+		rsp.subctxt_rcvegrbuf = rdma_mmap_token_i(SUBCTXT_EGRBUF, 0);
+	}
+
+	if (dd->params->chip_type != CHIP_WFR)
+		rsp.rheq_bufbase = rdma_mmap_token_p(RCV_RHEQ, uctxt->rcvhdrq);
+
+	return uverbs_copy_to(attrs, HFI2_ATTR_USER_INFO_RSP, &rsp,
+			      sizeof(rsp));
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_TID_UPDATE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_tid_info tinfo = {};
+	struct hfi2_tid_update_cmd cmd;
+	struct hfi2_tid_update_rsp rsp = {};
+	int ret;
+
+	if (!fd->uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_TID_UPDATE_CMD);
+	if (ret)
+		return ret;
+
+	/* reserved .flags bits must be 0 */
+	if (cmd.flags & HFI2_TID_UPDATE_FLAGS_RESERVED_MASK)
+		return -EINVAL;
+	/* reserved for now */
+	if (cmd.context)
+		return -EINVAL;
+
+	/* copy to internal structure */
+	tinfo.vaddr = cmd.vaddr;
+	tinfo.tidlist = cmd.tidlist;
+	tinfo.length = cmd.length;
+	tinfo.tidcnt = cmd.tidcnt;
+	tinfo.flags = cmd.flags;
+	tinfo.context = cmd.context;
+
+	ret = hfi2_user_exp_rcv_setup(fd, &tinfo, false, true);
+	if (ret)
+		return ret;
+
+	rsp.length = tinfo.length;
+	rsp.tidcnt = tinfo.tidcnt;
+	ret = uverbs_copy_to(attrs, HFI2_ATTR_TID_UPDATE_RSP, &rsp,
+			     sizeof(rsp));
+	if (!ret)
+		hfi2_user_exp_rcv_clear(fd, (struct hfi1_tid_info *)&tinfo);
+
+	return ret;
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_TID_FREE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi1_tid_info tinfo = {};
+	struct hfi2_tid_free_cmd cmd;
+	struct hfi2_tid_free_rsp rsp = {};
+	int ret;
+
+	if (!fd->uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_TID_FREE_CMD);
+	if (ret)
+		return ret;
+
+	if (cmd.reserved != 0)
+		return -EINVAL;
+
+	tinfo.tidlist = cmd.tidlist;
+	tinfo.tidcnt = cmd.tidcnt;
+
+	ret = hfi2_user_exp_rcv_clear(fd, &tinfo);
+	if (!ret)
+		return ret;
+
+	rsp.tidcnt = tinfo.tidcnt;
+
+	return uverbs_copy_to(attrs, HFI2_ATTR_TID_FREE_RSP, &rsp,
+			      sizeof(rsp));
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_CREDIT_UPD)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	if (!uctxt)
+		return -EINVAL;
+	sc_return_credits(uctxt->sc);
+
+	return 0;
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_RECV_CTRL)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_recv_ctrl_cmd cmd;
+	int ret;
+
+	if (!uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_RECV_CTRL_CMD);
+	if (ret)
+		return ret;
+
+	/* verify small reserved array of u8s is zero */
+	if (memcmp(cmd.reserved, &zero8, sizeof(cmd.reserved)) != 0)
+		return -EINVAL;
+
+	return manage_rcvq(uctxt, fd->subctxt, cmd.start_stop);
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_POLL_TYPE)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_poll_type_cmd cmd;
+	int ret;
+
+	if (!uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_POLL_TYPE_CMD);
+	if (ret)
+		return ret;
+
+	if (cmd.reserved != 0)
+		return -EINVAL;
+
+	uctxt->poll_type = (typeof(uctxt->poll_type))cmd.poll_type;
+
+	return 0;
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_ACK_EVENT)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_ack_event_cmd cmd;
+	int ret;
+
+	if (!uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_ACK_EVENT_CMD);
+	if (ret)
+		return ret;
+
+	return user_event_ack(uctxt, fd->subctxt, cmd.event);
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_SET_PKEY)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_set_pkey_cmd cmd;
+	int ret;
+
+	if (!uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_SET_PKEY_CMD);
+	if (ret)
+		return ret;
+
+	/* verify small reserved array of u8s is zero */
+	if (memcmp(cmd.reserved, &zero8, sizeof(cmd.reserved)) != 0)
+		return -EINVAL;
+
+	return set_ctxt_pkey(uctxt, cmd.pkey);
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_CTXT_RESET)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	if (!uctxt)
+		return -EINVAL;
+
+	return ctxt_reset(uctxt);
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_TID_INVAL_READ)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi1_tid_info tinfo = {};
+	struct hfi2_tid_inval_read_cmd cmd;
+	struct hfi2_tid_inval_read_rsp rsp = {};
+	int ret;
+
+	if (!fd->uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_TID_INVAL_READ_CMD);
+	if (ret)
+		return ret;
+
+	if (cmd.reserved != 0)
+		return -EINVAL;
+
+	tinfo.tidlist = cmd.tidlist;
+	tinfo.tidcnt = cmd.tidcnt;
+
+	ret = hfi2_user_exp_rcv_invalid(fd, &tinfo, true);
+	if (!ret)
+		return ret;
+
+	rsp.tidcnt = tinfo.tidcnt;
+
+	return uverbs_copy_to(attrs, HFI2_ATTR_TID_INVAL_READ_RSP, &rsp,
+			      sizeof(rsp));
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_GET_VERS)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_get_vers_rsp rsp = {};
+
+	rsp.version = HFI2_RDMA_USER_SWVERSION;
+	return uverbs_copy_to(attrs, HFI2_ATTR_GET_VERS_RSP, &rsp, sizeof(rsp));
+};
+
+static int UVERBS_HANDLER(HFI2_METHOD_PIN_STATS)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct hfi2_filedata *fd = fd_from_attrs(attrs);
+	struct hfi2_pin_stats_cmd cmd;
+	struct hfi2_pin_stats_rsp rsp = {};
+	struct hfi2_pin_stats stats = {};
+	int ret;
+
+	if (!fd->uctxt)
+		return -EINVAL;
+
+	ret = uverbs_copy_from(&cmd, attrs, HFI2_ATTR_PIN_STATS_CMD);
+	if (ret)
+		return ret;
+
+	stats.memtype = cmd.memtype;
+	stats.index = cmd.index;
+	ret = hfi2_get_pinning_stats(fd, &stats);
+	if (ret)
+		return ret;
+
+	rsp.id = stats.id;
+	rsp.cache_entries = stats.cache_entries;
+	rsp.total_refcounts = stats.total_refcounts;
+	rsp.total_bytes = stats.total_bytes;
+	rsp.hits = stats.hits;
+	rsp.misses = stats.misses;
+	rsp.internal_evictions = stats.internal_evictions;
+	rsp.external_evictions = stats.external_evictions;
+
+	return uverbs_copy_to(attrs, HFI2_ATTR_PIN_STATS_RSP, &rsp,
+			      sizeof(rsp));
+};
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_ASSIGN_CTXT,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_ASSIGN_CTXT_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_assign_ctxt_cmd),
+			   UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_CTXT_INFO,
+	UVERBS_ATTR_PTR_OUT(HFI2_ATTR_CTXT_INFO_RSP,
+			    UVERBS_ATTR_TYPE(struct hfi2_ctxt_info_rsp),
+			    UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_USER_INFO,
+	UVERBS_ATTR_PTR_OUT(HFI2_ATTR_USER_INFO_RSP,
+			    UVERBS_ATTR_TYPE(struct hfi2_user_info_rsp),
+			    UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_TID_UPDATE,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_TID_UPDATE_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_tid_update_cmd),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HFI2_ATTR_TID_UPDATE_RSP,
+			    UVERBS_ATTR_TYPE(struct hfi2_tid_update_rsp),
+			    UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_TID_FREE,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_TID_FREE_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_tid_free_cmd),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HFI2_ATTR_TID_FREE_RSP,
+			    UVERBS_ATTR_TYPE(struct hfi2_tid_free_rsp),
+			    UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_CREDIT_UPD,
+	/* no arguments */
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_RECV_CTRL,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_RECV_CTRL_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_recv_ctrl_cmd),
+			   UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_POLL_TYPE,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_POLL_TYPE_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_poll_type_cmd),
+			   UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_ACK_EVENT,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_ACK_EVENT_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_ack_event_cmd),
+			   UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_SET_PKEY,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_SET_PKEY_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_set_pkey_cmd),
+			   UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_CTXT_RESET,
+	/* no arguments */
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_TID_INVAL_READ,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_TID_INVAL_READ_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_tid_inval_read_cmd),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HFI2_ATTR_TID_INVAL_READ_RSP,
+			    UVERBS_ATTR_TYPE(struct hfi2_tid_inval_read_rsp),
+			    UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_GET_VERS,
+	UVERBS_ATTR_PTR_OUT(HFI2_ATTR_GET_VERS_RSP,
+			    UVERBS_ATTR_TYPE(struct hfi2_get_vers_rsp),
+			    UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_NAMED_METHOD(HFI2_METHOD_PIN_STATS,
+	UVERBS_ATTR_PTR_IN(HFI2_ATTR_PIN_STATS_CMD,
+			   UVERBS_ATTR_TYPE(struct hfi2_pin_stats_cmd),
+			   UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(HFI2_ATTR_PIN_STATS_RSP,
+			    UVERBS_ATTR_TYPE(struct hfi2_pin_stats_rsp),
+			    UA_MANDATORY),
+	);
+
+DECLARE_UVERBS_GLOBAL_METHODS(HFI2_OBJECT_DV0,
+	&UVERBS_METHOD(HFI2_METHOD_ASSIGN_CTXT),
+	&UVERBS_METHOD(HFI2_METHOD_CTXT_INFO),
+	&UVERBS_METHOD(HFI2_METHOD_USER_INFO),
+	&UVERBS_METHOD(HFI2_METHOD_TID_UPDATE),
+	&UVERBS_METHOD(HFI2_METHOD_TID_FREE),
+	&UVERBS_METHOD(HFI2_METHOD_CREDIT_UPD),
+	&UVERBS_METHOD(HFI2_METHOD_RECV_CTRL),
+	&UVERBS_METHOD(HFI2_METHOD_POLL_TYPE));
+
+DECLARE_UVERBS_GLOBAL_METHODS(HFI2_OBJECT_DV1,
+	&UVERBS_METHOD(HFI2_METHOD_ACK_EVENT),
+	&UVERBS_METHOD(HFI2_METHOD_SET_PKEY),
+	&UVERBS_METHOD(HFI2_METHOD_CTXT_RESET),
+	&UVERBS_METHOD(HFI2_METHOD_TID_INVAL_READ),
+	&UVERBS_METHOD(HFI2_METHOD_GET_VERS),
+	&UVERBS_METHOD(HFI2_METHOD_PIN_STATS));
+
+const struct uapi_definition hfi2_ib_defs[] = {
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(HFI2_OBJECT_DV0),
+	UAPI_DEF_CHAIN_OBJ_TREE_NAMED(HFI2_OBJECT_DV1),
+	{}
+};
+
+int hfi2_rdma_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma)
+{
+	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
+	struct hfi2_filedata *fd = rcontext->priv;
+	unsigned long token;
+	u8 type;
+
+	if (!fd)
+		return -EINVAL;
+
+	token = vma->vm_pgoff << PAGE_SHIFT;
+	type = rdma_mmap_get_type(token);
+
+	return hfi2_do_mmap(fd, type, vma);
+}
+
+ssize_t hfi2_uverbs_write_iter(struct ib_ucontext *ucontext,
+			       struct iov_iter *from)
+{
+	struct rvt_ucontext *rcontext = container_of(ucontext, struct rvt_ucontext, ibucontext);
+	struct hfi2_filedata *fd = rcontext->priv;
+
+	return hfi2_do_write_iter(fd, from);
+}
diff --git a/drivers/infiniband/hw/hfi2/verbs.c b/drivers/infiniband/hw/hfi2/verbs.c
new file mode 100644
index 000000000000..06c1bab6043b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/verbs.c
@@ -0,0 +1,2052 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ */
+
+#include <rdma/ib_mad.h>
+#include <rdma/ib_user_verbs.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/utsname.h>
+#include <linux/rculist.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <rdma/opa_addr.h>
+#include <linux/nospec.h>
+
+#include "hfi2.h"
+#include "common.h"
+#include "device.h"
+#include "trace.h"
+#include "qp.h"
+#include "verbs_txreq.h"
+#include "debugfs.h"
+#include "fault.h"
+#include "affinity.h"
+#include "ipoib.h"
+#include "uverbs.h"
+
+static unsigned int hfi2_lkey_table_size = 16;
+module_param_named(lkey_table_size, hfi2_lkey_table_size, uint,
+		   S_IRUGO);
+MODULE_PARM_DESC(lkey_table_size,
+		 "LKEY table size in bits (2^n, 1 <= n <= 23)");
+
+static unsigned int hfi2_max_pds = 0xFFFF;
+module_param_named(max_pds, hfi2_max_pds, uint, S_IRUGO);
+MODULE_PARM_DESC(max_pds,
+		 "Maximum number of protection domains to support");
+
+static unsigned int hfi2_max_ahs = 0xFFFF;
+module_param_named(max_ahs, hfi2_max_ahs, uint, S_IRUGO);
+MODULE_PARM_DESC(max_ahs, "Maximum number of address handles to support");
+
+unsigned int hfi2_max_cqes = 0x2FFFFF;
+module_param_named(max_cqes, hfi2_max_cqes, uint, S_IRUGO);
+MODULE_PARM_DESC(max_cqes,
+		 "Maximum number of completion queue entries to support");
+
+unsigned int hfi2_max_cqs = 0x1FFFF;
+module_param_named(max_cqs, hfi2_max_cqs, uint, S_IRUGO);
+MODULE_PARM_DESC(max_cqs, "Maximum number of completion queues to support");
+
+unsigned int hfi2_max_qp_wrs = 0x3FFF;
+module_param_named(max_qp_wrs, hfi2_max_qp_wrs, uint, S_IRUGO);
+MODULE_PARM_DESC(max_qp_wrs, "Maximum number of QP WRs to support");
+
+unsigned int hfi2_max_qps = 32768;
+module_param_named(max_qps, hfi2_max_qps, uint, S_IRUGO);
+MODULE_PARM_DESC(max_qps, "Maximum number of QPs to support");
+
+unsigned int hfi2_max_sges = 0x60;
+module_param_named(max_sges, hfi2_max_sges, uint, S_IRUGO);
+MODULE_PARM_DESC(max_sges, "Maximum number of SGEs to support");
+
+unsigned int hfi2_max_mcast_grps = 16384;
+module_param_named(max_mcast_grps, hfi2_max_mcast_grps, uint, S_IRUGO);
+MODULE_PARM_DESC(max_mcast_grps,
+		 "Maximum number of multicast groups to support");
+
+unsigned int hfi2_max_mcast_qp_attached = 16;
+module_param_named(max_mcast_qp_attached, hfi2_max_mcast_qp_attached,
+		   uint, S_IRUGO);
+MODULE_PARM_DESC(max_mcast_qp_attached,
+		 "Maximum number of attached QPs to support");
+
+unsigned int hfi2_max_srqs = 1024;
+module_param_named(max_srqs, hfi2_max_srqs, uint, S_IRUGO);
+MODULE_PARM_DESC(max_srqs, "Maximum number of SRQs to support");
+
+unsigned int hfi2_max_srq_sges = 128;
+module_param_named(max_srq_sges, hfi2_max_srq_sges, uint, S_IRUGO);
+MODULE_PARM_DESC(max_srq_sges, "Maximum number of SRQ SGEs to support");
+
+unsigned int hfi2_max_srq_wrs = 0x1FFFF;
+module_param_named(max_srq_wrs, hfi2_max_srq_wrs, uint, S_IRUGO);
+MODULE_PARM_DESC(max_srq_wrs, "Maximum number of SRQ WRs support");
+
+unsigned short piothreshold = 256;
+module_param(piothreshold, ushort, S_IRUGO);
+MODULE_PARM_DESC(piothreshold, "size used to determine sdma vs. pio");
+
+static unsigned int sge_copy_mode;
+module_param(sge_copy_mode, uint, S_IRUGO);
+MODULE_PARM_DESC(sge_copy_mode,
+		 "Verbs copy mode: 0 use memcpy, 1 use cacheless copy, 2 adapt based on WSS");
+
+static void verbs_sdma_complete(
+	struct sdma_txreq *cookie,
+	int status);
+
+static int pio_wait(struct rvt_qp *qp,
+		    struct send_context *sc,
+		    struct hfi2_pkt_state *ps,
+		    u32 flag);
+
+/* Length of buffer to create verbs txreq cache name */
+#define TXREQ_NAME_LEN 24
+
+static uint wss_threshold = 80;
+module_param(wss_threshold, uint, S_IRUGO);
+MODULE_PARM_DESC(wss_threshold, "Percentage (1-100) of LLC to use as a threshold for a cacheless copy");
+static uint wss_clean_period = 256;
+module_param(wss_clean_period, uint, S_IRUGO);
+MODULE_PARM_DESC(wss_clean_period, "Count of verbs copies before an entry in the page copy table is cleaned");
+
+/*
+ * Translate ib_wr_opcode into ib_wc_opcode.
+ */
+const enum ib_wc_opcode ib_hfi2_wc_opcode[] = {
+	[IB_WR_RDMA_WRITE] = IB_WC_RDMA_WRITE,
+	[IB_WR_TID_RDMA_WRITE] = IB_WC_RDMA_WRITE,
+	[IB_WR_RDMA_WRITE_WITH_IMM] = IB_WC_RDMA_WRITE,
+	[IB_WR_SEND] = IB_WC_SEND,
+	[IB_WR_SEND_WITH_IMM] = IB_WC_SEND,
+	[IB_WR_RDMA_READ] = IB_WC_RDMA_READ,
+	[IB_WR_TID_RDMA_READ] = IB_WC_RDMA_READ,
+	[IB_WR_ATOMIC_CMP_AND_SWP] = IB_WC_COMP_SWAP,
+	[IB_WR_ATOMIC_FETCH_AND_ADD] = IB_WC_FETCH_ADD,
+	[IB_WR_SEND_WITH_INV] = IB_WC_SEND,
+	[IB_WR_LOCAL_INV] = IB_WC_LOCAL_INV,
+	[IB_WR_REG_MR] = IB_WC_REG_MR
+};
+
+/*
+ * Length of header by opcode, 0 --> not supported
+ */
+const u8 hdr_len_by_opcode[256] = {
+	/* RC */
+	[IB_OPCODE_RC_SEND_FIRST]                     = 12 + 8,
+	[IB_OPCODE_RC_SEND_MIDDLE]                    = 12 + 8,
+	[IB_OPCODE_RC_SEND_LAST]                      = 12 + 8,
+	[IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE]       = 12 + 8 + 4,
+	[IB_OPCODE_RC_SEND_ONLY]                      = 12 + 8,
+	[IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE]       = 12 + 8 + 4,
+	[IB_OPCODE_RC_RDMA_WRITE_FIRST]               = 12 + 8 + 16,
+	[IB_OPCODE_RC_RDMA_WRITE_MIDDLE]              = 12 + 8,
+	[IB_OPCODE_RC_RDMA_WRITE_LAST]                = 12 + 8,
+	[IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE] = 12 + 8 + 4,
+	[IB_OPCODE_RC_RDMA_WRITE_ONLY]                = 12 + 8 + 16,
+	[IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE] = 12 + 8 + 20,
+	[IB_OPCODE_RC_RDMA_READ_REQUEST]              = 12 + 8 + 16,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST]       = 12 + 8 + 4,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE]      = 12 + 8,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST]        = 12 + 8 + 4,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY]        = 12 + 8 + 4,
+	[IB_OPCODE_RC_ACKNOWLEDGE]                    = 12 + 8 + 4,
+	[IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE]             = 12 + 8 + 4 + 8,
+	[IB_OPCODE_RC_COMPARE_SWAP]                   = 12 + 8 + 28,
+	[IB_OPCODE_RC_FETCH_ADD]                      = 12 + 8 + 28,
+	[IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE]      = 12 + 8 + 4,
+	[IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE]      = 12 + 8 + 4,
+	[IB_OPCODE_TID_RDMA_READ_REQ]                 = 12 + 8 + 36,
+	[IB_OPCODE_TID_RDMA_READ_RESP]                = 12 + 8 + 36,
+	[IB_OPCODE_TID_RDMA_WRITE_REQ]                = 12 + 8 + 36,
+	[IB_OPCODE_TID_RDMA_WRITE_RESP]               = 12 + 8 + 36,
+	[IB_OPCODE_TID_RDMA_WRITE_DATA]               = 12 + 8 + 36,
+	[IB_OPCODE_TID_RDMA_WRITE_DATA_LAST]          = 12 + 8 + 36,
+	[IB_OPCODE_TID_RDMA_ACK]                      = 12 + 8 + 36,
+	[IB_OPCODE_TID_RDMA_RESYNC]                   = 12 + 8 + 36,
+	/* UC */
+	[IB_OPCODE_UC_SEND_FIRST]                     = 12 + 8,
+	[IB_OPCODE_UC_SEND_MIDDLE]                    = 12 + 8,
+	[IB_OPCODE_UC_SEND_LAST]                      = 12 + 8,
+	[IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE]       = 12 + 8 + 4,
+	[IB_OPCODE_UC_SEND_ONLY]                      = 12 + 8,
+	[IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE]       = 12 + 8 + 4,
+	[IB_OPCODE_UC_RDMA_WRITE_FIRST]               = 12 + 8 + 16,
+	[IB_OPCODE_UC_RDMA_WRITE_MIDDLE]              = 12 + 8,
+	[IB_OPCODE_UC_RDMA_WRITE_LAST]                = 12 + 8,
+	[IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE] = 12 + 8 + 4,
+	[IB_OPCODE_UC_RDMA_WRITE_ONLY]                = 12 + 8 + 16,
+	[IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE] = 12 + 8 + 20,
+	/* UD */
+	[IB_OPCODE_UD_SEND_ONLY]                      = 12 + 8 + 8,
+	[IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE]       = 12 + 8 + 12
+};
+
+static const opcode_handler opcode_handler_tbl[256] = {
+	/* RC */
+	[IB_OPCODE_RC_SEND_FIRST]                     = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_SEND_MIDDLE]                    = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_SEND_LAST]                      = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_SEND_LAST_WITH_IMMEDIATE]       = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_SEND_ONLY]                      = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_SEND_ONLY_WITH_IMMEDIATE]       = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_WRITE_FIRST]               = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_WRITE_MIDDLE]              = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_WRITE_LAST]                = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_WRITE_LAST_WITH_IMMEDIATE] = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_WRITE_ONLY]                = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE] = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_READ_REQUEST]              = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST]       = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE]      = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST]        = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY]        = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_ACKNOWLEDGE]                    = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_ATOMIC_ACKNOWLEDGE]             = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_COMPARE_SWAP]                   = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_FETCH_ADD]                      = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_SEND_LAST_WITH_INVALIDATE]      = &hfi2_rc_rcv,
+	[IB_OPCODE_RC_SEND_ONLY_WITH_INVALIDATE]      = &hfi2_rc_rcv,
+
+	/* TID RDMA has separate handlers for different opcodes.*/
+	[IB_OPCODE_TID_RDMA_WRITE_REQ]       = &hfi2_rc_rcv_tid_rdma_write_req,
+	[IB_OPCODE_TID_RDMA_WRITE_RESP]      = &hfi2_rc_rcv_tid_rdma_write_resp,
+	[IB_OPCODE_TID_RDMA_WRITE_DATA]      = &hfi2_rc_rcv_tid_rdma_write_data,
+	[IB_OPCODE_TID_RDMA_WRITE_DATA_LAST] = &hfi2_rc_rcv_tid_rdma_write_data,
+	[IB_OPCODE_TID_RDMA_READ_REQ]        = &hfi2_rc_rcv_tid_rdma_read_req,
+	[IB_OPCODE_TID_RDMA_READ_RESP]       = &hfi2_rc_rcv_tid_rdma_read_resp,
+	[IB_OPCODE_TID_RDMA_RESYNC]          = &hfi2_rc_rcv_tid_rdma_resync,
+	[IB_OPCODE_TID_RDMA_ACK]             = &hfi2_rc_rcv_tid_rdma_ack,
+
+	/* UC */
+	[IB_OPCODE_UC_SEND_FIRST]                     = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_SEND_MIDDLE]                    = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_SEND_LAST]                      = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_SEND_LAST_WITH_IMMEDIATE]       = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_SEND_ONLY]                      = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_SEND_ONLY_WITH_IMMEDIATE]       = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_RDMA_WRITE_FIRST]               = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_RDMA_WRITE_MIDDLE]              = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_RDMA_WRITE_LAST]                = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_RDMA_WRITE_LAST_WITH_IMMEDIATE] = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_RDMA_WRITE_ONLY]                = &hfi2_uc_rcv,
+	[IB_OPCODE_UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE] = &hfi2_uc_rcv,
+	/* UD */
+	[IB_OPCODE_UD_SEND_ONLY]                      = &hfi2_ud_rcv,
+	[IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE]       = &hfi2_ud_rcv,
+	/* CNP */
+	[IB_OPCODE_CNP]				      = &hfi2_cnp_rcv
+};
+
+#define OPMASK 0x1f
+
+static const u32 pio_opmask[BIT(3)] = {
+	/* RC */
+	[IB_OPCODE_RC >> 5] =
+		BIT(RC_OP(SEND_ONLY) & OPMASK) |
+		BIT(RC_OP(SEND_ONLY_WITH_IMMEDIATE) & OPMASK) |
+		BIT(RC_OP(RDMA_WRITE_ONLY) & OPMASK) |
+		BIT(RC_OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE) & OPMASK) |
+		BIT(RC_OP(RDMA_READ_REQUEST) & OPMASK) |
+		BIT(RC_OP(ACKNOWLEDGE) & OPMASK) |
+		BIT(RC_OP(ATOMIC_ACKNOWLEDGE) & OPMASK) |
+		BIT(RC_OP(COMPARE_SWAP) & OPMASK) |
+		BIT(RC_OP(FETCH_ADD) & OPMASK),
+	/* UC */
+	[IB_OPCODE_UC >> 5] =
+		BIT(UC_OP(SEND_ONLY) & OPMASK) |
+		BIT(UC_OP(SEND_ONLY_WITH_IMMEDIATE) & OPMASK) |
+		BIT(UC_OP(RDMA_WRITE_ONLY) & OPMASK) |
+		BIT(UC_OP(RDMA_WRITE_ONLY_WITH_IMMEDIATE) & OPMASK),
+};
+
+/*
+ * System image GUID.
+ */
+__be64 ib_hfi2_sys_image_guid;
+
+/*
+ * Make sure the QP is ready and able to accept the given opcode.
+ */
+static inline opcode_handler qp_ok(struct hfi2_packet *packet)
+{
+	if (!(ib_rvt_state_ops[packet->qp->state] & RVT_PROCESS_RECV_OK))
+		return NULL;
+	if (((packet->opcode & RVT_OPCODE_QP_MASK) ==
+	     packet->qp->allowed_ops) ||
+	    (packet->opcode == IB_OPCODE_CNP))
+		return opcode_handler_tbl[packet->opcode];
+
+	return NULL;
+}
+
+static u64 hfi2_fault_tx(struct rvt_qp *qp, u8 opcode, u64 pbc)
+{
+#ifdef CONFIG_FAULT_INJECTION
+	if ((opcode & IB_OPCODE_MSP) == IB_OPCODE_MSP) {
+		/*
+		 * In order to drop non-IB traffic we
+		 * set PbcInsertHrc to NONE (0x2).
+		 * The packet will still be delivered
+		 * to the receiving node but a
+		 * KHdrHCRCErr (KDETH packet with a bad
+		 * HCRC) will be triggered and the
+		 * packet will not be delivered to the
+		 * correct context.
+		 */
+		pbc &= ~PBC_INSERT_HCRC_SMASK;
+		pbc |= (u64)PBC_IHCRC_NONE << PBC_INSERT_HCRC_SHIFT;
+	} else {
+		/*
+		 * In order to drop regular verbs
+		 * traffic we set the PbcTestEbp
+		 * flag. The packet will still be
+		 * delivered to the receiving node but
+		 * a 'late ebp error' will be
+		 * triggered and will be dropped.
+		 */
+		pbc |= PBC_TEST_EBP;
+	}
+#endif
+	return pbc;
+}
+
+static opcode_handler tid_qp_ok(int opcode, struct hfi2_packet *packet)
+{
+	if (packet->qp->ibqp.qp_type != IB_QPT_RC ||
+	    !(ib_rvt_state_ops[packet->qp->state] & RVT_PROCESS_RECV_OK))
+		return NULL;
+	if ((opcode & RVT_OPCODE_QP_MASK) == IB_OPCODE_TID_RDMA)
+		return opcode_handler_tbl[opcode];
+	return NULL;
+}
+
+void hfi2_kdeth_eager_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct ib_header *hdr = packet->hdr;
+	u32 tlen = packet->tlen;
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	struct hfi2_ibport *ibp = &ppd->ibport_data;
+	struct rvt_dev_info *rdi = &ppd->dd->verbs_dev.rdi;
+	opcode_handler opcode_handler;
+	unsigned long flags;
+	u32 qp_num;
+	int lnh;
+	u8 opcode;
+
+	/* DW == LRH (2) + BTH (3) + KDETH (9) + CRC (1) */
+	if (unlikely(tlen < 15 * sizeof(u32)))
+		goto drop;
+
+	lnh = be16_to_cpu(hdr->lrh[0]) & 3;
+	if (lnh != HFI2_LRH_BTH)
+		goto drop;
+
+	packet->ohdr = &hdr->u.oth;
+	trace_input_ibhdr(rcd->dd, packet, packet->sc4);
+
+	opcode = (be32_to_cpu(packet->ohdr->bth[0]) >> 24);
+	inc_opstats(tlen, &rcd->opstats->stats[opcode]);
+
+	/* verbs_qp can be picked up from any tid_rdma header struct */
+	qp_num = be32_to_cpu(packet->ohdr->u.tid_rdma.r_req.verbs_qp) &
+		RVT_QPN_MASK;
+
+	rcu_read_lock();
+	packet->qp = rvt_lookup_qpn(rdi, &ibp->rvp, qp_num);
+	if (!packet->qp)
+		goto drop_rcu;
+	spin_lock_irqsave(&packet->qp->r_lock, flags);
+	opcode_handler = tid_qp_ok(opcode, packet);
+	if (likely(opcode_handler))
+		opcode_handler(packet);
+	else
+		goto drop_unlock;
+	spin_unlock_irqrestore(&packet->qp->r_lock, flags);
+	rcu_read_unlock();
+
+	return;
+drop_unlock:
+	spin_unlock_irqrestore(&packet->qp->r_lock, flags);
+drop_rcu:
+	rcu_read_unlock();
+drop:
+	ibp->rvp.n_pkt_drops++;
+}
+
+void hfi2_kdeth_expected_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct ib_header *hdr = packet->hdr;
+	u32 tlen = packet->tlen;
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	struct hfi2_ibport *ibp = &ppd->ibport_data;
+	struct rvt_dev_info *rdi = &ppd->dd->verbs_dev.rdi;
+	opcode_handler opcode_handler;
+	unsigned long flags;
+	u32 qp_num;
+	int lnh;
+	u8 opcode;
+
+	/* DW == LRH (2) + BTH (3) + KDETH (9) + CRC (1) */
+	if (unlikely(tlen < 15 * sizeof(u32)))
+		goto drop;
+
+	lnh = be16_to_cpu(hdr->lrh[0]) & 3;
+	if (lnh != HFI2_LRH_BTH)
+		goto drop;
+
+	packet->ohdr = &hdr->u.oth;
+	trace_input_ibhdr(rcd->dd, packet, packet->sc4);
+
+	opcode = (be32_to_cpu(packet->ohdr->bth[0]) >> 24);
+	inc_opstats(tlen, &rcd->opstats->stats[opcode]);
+
+	/* verbs_qp can be picked up from any tid_rdma header struct */
+	qp_num = be32_to_cpu(packet->ohdr->u.tid_rdma.r_rsp.verbs_qp) &
+		RVT_QPN_MASK;
+
+	rcu_read_lock();
+	packet->qp = rvt_lookup_qpn(rdi, &ibp->rvp, qp_num);
+	if (!packet->qp)
+		goto drop_rcu;
+	spin_lock_irqsave(&packet->qp->r_lock, flags);
+	opcode_handler = tid_qp_ok(opcode, packet);
+	if (likely(opcode_handler))
+		opcode_handler(packet);
+	else
+		goto drop_unlock;
+	spin_unlock_irqrestore(&packet->qp->r_lock, flags);
+	rcu_read_unlock();
+
+	return;
+drop_unlock:
+	spin_unlock_irqrestore(&packet->qp->r_lock, flags);
+drop_rcu:
+	rcu_read_unlock();
+drop:
+	ibp->rvp.n_pkt_drops++;
+}
+
+static int hfi2_do_pkey_check(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	struct hfi2_16b_header *hdr = packet->hdr;
+	u16 pkey;
+
+	/* Pkey check needed only for bypass packets */
+	if (packet->etype != RHF_RCV_TYPE_BYPASS)
+		return 0;
+
+	/* Perform pkey check */
+	pkey = hfi2_16B_get_pkey(hdr);
+	return ingress_pkey_check(ppd, pkey, packet->sc,
+				  packet->qp->s_pkey_index,
+				  packet->slid, true);
+}
+
+static inline void hfi2_handle_packet(struct hfi2_packet *packet,
+				      bool is_mcast)
+{
+	u32 qp_num;
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+	struct hfi2_pportdata *ppd = rcd->ppd;
+	struct hfi2_ibport *ibp = rcd_to_iport(rcd);
+	struct rvt_dev_info *rdi = &ppd->dd->verbs_dev.rdi;
+	opcode_handler packet_handler;
+	unsigned long flags;
+
+	inc_opstats(packet->tlen, &rcd->opstats->stats[packet->opcode]);
+
+	if (unlikely(is_mcast)) {
+		struct rvt_mcast *mcast;
+		struct rvt_mcast_qp *p;
+
+		if (!packet->grh)
+			goto drop;
+		mcast = rvt_mcast_find(&ibp->rvp,
+				       &packet->grh->dgid,
+				       opa_get_lid(packet->dlid, 9B));
+		if (!mcast)
+			goto drop;
+		rcu_read_lock();
+		list_for_each_entry_rcu(p, &mcast->qp_list, list) {
+			packet->qp = p->qp;
+			if (hfi2_do_pkey_check(packet))
+				goto unlock_drop;
+			spin_lock_irqsave(&packet->qp->r_lock, flags);
+			packet_handler = qp_ok(packet);
+			if (likely(packet_handler))
+				packet_handler(packet);
+			else
+				ibp->rvp.n_pkt_drops++;
+			spin_unlock_irqrestore(&packet->qp->r_lock, flags);
+		}
+		rcu_read_unlock();
+		/*
+		 * Notify rvt_multicast_detach() if it is waiting for us
+		 * to finish.
+		 */
+		if (atomic_dec_return(&mcast->refcount) <= 1)
+			wake_up(&mcast->wait);
+	} else {
+		/* Get the destination QP number. */
+		if (packet->etype == RHF_RCV_TYPE_BYPASS &&
+		    hfi2_16B_get_l4(packet->hdr) == OPA_16B_L4_FM)
+			qp_num = hfi2_16B_get_dest_qpn(packet->mgmt);
+		else
+			qp_num = ib_bth_get_qpn(packet->ohdr);
+
+		rcu_read_lock();
+		packet->qp = rvt_lookup_qpn(rdi, &ibp->rvp, qp_num);
+		if (!packet->qp)
+			goto unlock_drop;
+
+		if (hfi2_do_pkey_check(packet))
+			goto unlock_drop;
+
+		spin_lock_irqsave(&packet->qp->r_lock, flags);
+		packet_handler = qp_ok(packet);
+		if (likely(packet_handler))
+			packet_handler(packet);
+		else
+			ibp->rvp.n_pkt_drops++;
+		spin_unlock_irqrestore(&packet->qp->r_lock, flags);
+		rcu_read_unlock();
+	}
+	return;
+unlock_drop:
+	rcu_read_unlock();
+drop:
+	ibp->rvp.n_pkt_drops++;
+}
+
+/**
+ * hfi2_ib_rcv - process an incoming packet
+ * @packet: data packet information
+ *
+ * This is called to process an incoming packet at interrupt level.
+ */
+void hfi2_ib_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+
+	trace_input_ibhdr(rcd->dd, packet, packet->sc4);
+	hfi2_handle_packet(packet, hfi2_check_mcast(packet->dlid));
+}
+
+void hfi2_16B_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ctxtdata *rcd = packet->rcd;
+
+	trace_input_ibhdr(rcd->dd, packet, false);
+	hfi2_handle_packet(packet, hfi2_check_mcast(packet->dlid));
+}
+
+/*
+ * This is called from a timer to check for QPs
+ * which need kernel memory in order to send a packet.
+ */
+static void mem_timer(struct timer_list *t)
+{
+	struct hfi2_ibdev *dev = from_timer(dev, t, mem_timer);
+	struct list_head *list = &dev->memwait;
+	struct rvt_qp *qp = NULL;
+	struct iowait *wait;
+	unsigned long flags;
+	struct hfi2_qp_priv *priv;
+
+	write_seqlock_irqsave(&dev->iowait_lock, flags);
+	if (!list_empty(list)) {
+		wait = list_first_entry(list, struct iowait, list);
+		qp = iowait_to_qp(wait);
+		priv = qp->priv;
+		list_del_init(&priv->s_iowait.list);
+		priv->s_iowait.lock = NULL;
+		/* refcount held until actual wake up */
+		if (!list_empty(list))
+			mod_timer(&dev->mem_timer, jiffies + 1);
+	}
+	write_sequnlock_irqrestore(&dev->iowait_lock, flags);
+
+	if (qp)
+		hfi2_qp_wakeup(qp, RVT_S_WAIT_KMEM);
+}
+
+/*
+ * This is called with progress side lock held.
+ */
+/* New API */
+static void verbs_sdma_complete(
+	struct sdma_txreq *cookie,
+	int status)
+{
+	struct verbs_txreq *tx =
+		container_of(cookie, struct verbs_txreq, txreq);
+	struct rvt_qp *qp = tx->qp;
+
+	spin_lock(&qp->s_lock);
+	if (tx->wqe) {
+		rvt_send_complete(qp, tx->wqe, IB_WC_SUCCESS);
+	} else if (qp->ibqp.qp_type == IB_QPT_RC) {
+		struct hfi2_opa_header *hdr;
+
+		hdr = &tx->phdr.hdr;
+		if (unlikely(status == SDMA_TXREQ_S_ABORTED))
+			hfi2_rc_verbs_aborted(qp, hdr);
+		hfi2_rc_send_complete(qp, hdr);
+	}
+	spin_unlock(&qp->s_lock);
+
+	hfi2_put_txreq(tx);
+}
+
+void hfi2_wait_kmem(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct ib_qp *ibqp = &qp->ibqp;
+	struct ib_device *ibdev = ibqp->device;
+	struct hfi2_ibdev *dev = to_idev(ibdev);
+
+	if (list_empty(&priv->s_iowait.list)) {
+		if (list_empty(&dev->memwait))
+			mod_timer(&dev->mem_timer, jiffies + 1);
+		qp->s_flags |= RVT_S_WAIT_KMEM;
+		list_add_tail(&priv->s_iowait.list, &dev->memwait);
+		priv->s_iowait.lock = &dev->iowait_lock;
+		trace_hfi2_qpsleep(qp, RVT_S_WAIT_KMEM);
+		rvt_get_qp(qp);
+	}
+}
+
+static int wait_kmem(struct hfi2_ibdev *dev,
+		     struct rvt_qp *qp,
+		     struct hfi2_pkt_state *ps)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK) {
+		/* take a new txreq reference */
+		hfi2_get_txreq(ps->s_txreq);
+		write_seqlock(&dev->iowait_lock);
+		list_add_tail(&ps->s_txreq->txreq.list,
+			      &ps->wait->tx_head);
+		hfi2_wait_kmem(qp);
+		write_sequnlock(&dev->iowait_lock);
+		hfi2_qp_unbusy(qp, ps->wait);
+		ret = -EBUSY;
+	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+
+	return ret;
+}
+
+/*
+ * This routine calls txadds for each sg entry.
+ *
+ * Add failures will revert the sge cursor
+ */
+static noinline int build_verbs_ulp_payload(
+	struct sdma_engine *sde,
+	u32 length,
+	struct verbs_txreq *tx)
+{
+	struct rvt_sge_state *ss = tx->ss;
+	struct rvt_sge *sg_list = ss->sg_list;
+	struct rvt_sge sge = ss->sge;
+	u8 num_sge = ss->num_sge;
+	u32 len;
+	int ret = 0;
+
+	while (length) {
+		len = rvt_get_sge_length(&ss->sge, length);
+		WARN_ON_ONCE(len == 0);
+		ret = sdma_txadd_kvaddr(
+			sde->dd,
+			&tx->txreq,
+			ss->sge.vaddr,
+			len);
+		if (ret)
+			goto bail_txadd;
+		rvt_update_sge(ss, len, false);
+		length -= len;
+	}
+	return ret;
+bail_txadd:
+	/* unwind cursor */
+	ss->sge = sge;
+	ss->num_sge = num_sge;
+	ss->sg_list = sg_list;
+	return ret;
+}
+
+/**
+ * update_tx_opstats - record stats by opcode
+ * @qp: the qp
+ * @ps: transmit packet state
+ * @plen: the plen in dwords
+ *
+ * This is a routine to record the tx opstats after a
+ * packet has been presented to the egress mechanism.
+ */
+static void update_tx_opstats(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			      u32 plen)
+{
+#ifdef CONFIG_DEBUG_FS
+	struct hfi2_devdata *dd = dd_from_ibdev(qp->ibqp.device);
+	struct hfi2_opcode_stats_perctx *s = get_cpu_ptr(dd->tx_opstats);
+
+	inc_opstats(plen * 4, &s->stats[ps->opcode]);
+	put_cpu_ptr(s);
+#endif
+}
+
+/*
+ * Build the number of DMA descriptors needed to send length bytes of data.
+ *
+ * NOTE: DMA mapping is held in the tx until completed in the ring or
+ *       the tx desc is freed without having been submitted to the ring
+ *
+ * This routine ensures all the helper routine calls succeed.
+ */
+/* New API */
+static int build_verbs_tx_desc(
+	struct sdma_engine *sde,
+	u32 length,
+	struct verbs_txreq *tx,
+	struct hfi2_ahg_info *ahg_info,
+	u64 pbc)
+{
+	int ret = 0;
+	struct hfi2_sdma_header *phdr = &tx->phdr;
+	u16 hdrbytes = (tx->hdr_dwords + sizeof(pbc) / 4) << 2;
+	u8 extra_bytes = 0;
+
+	if (tx->phdr.hdr.hdr_type) {
+		/*
+		 * hdrbytes accounts for PBC. Need to subtract 8 bytes
+		 * before calculating padding.
+		 */
+		if (sde->dd->params->chip_type == CHIP_WFR) {
+			extra_bytes = hfi2_get_16b_padding(hdrbytes - 8, length)
+					+ (SIZE_OF_CRC << 2) + SIZE_OF_LT;
+		} else {
+			/* add ICRC QW */
+			extra_bytes = hfi2_pad8(hdrbytes - 8 + length) + 8;
+		}
+	}
+	if (!ahg_info->ahgcount) {
+		ret = sdma_txinit_ahg(sde->dd,
+			&tx->txreq,
+			ahg_info->tx_flags,
+			hdrbytes + length +
+			extra_bytes,
+			ahg_info->ahgidx,
+			0,
+			NULL,
+			0,
+			verbs_sdma_complete);
+		if (ret)
+			goto bail_txadd;
+		phdr->pbc = cpu_to_le64(pbc);
+		ret = sdma_txadd_kvaddr(
+			sde->dd,
+			&tx->txreq,
+			phdr,
+			hdrbytes);
+		if (ret)
+			goto bail_txadd;
+	} else {
+		ret = sdma_txinit_ahg(sde->dd,
+			&tx->txreq,
+			ahg_info->tx_flags,
+			length,
+			ahg_info->ahgidx,
+			ahg_info->ahgcount,
+			ahg_info->ahgdesc,
+			hdrbytes,
+			verbs_sdma_complete);
+		if (ret)
+			goto bail_txadd;
+	}
+	/* add the ulp payload - if any. tx->ss can be NULL for acks */
+	if (tx->ss) {
+		ret = build_verbs_ulp_payload(sde, length, tx);
+		if (ret)
+			goto bail_txadd;
+	}
+
+	/* add icrc, lt byte, and padding to flit */
+	if (extra_bytes)
+		ret = sdma_txadd_daddr(sde->dd, &tx->txreq, sde->dd->sdma_pad_phys,
+				       extra_bytes);
+
+bail_txadd:
+	return ret;
+}
+
+static u64 update_hcrc(u8 opcode, u64 pbc)
+{
+	if ((opcode & IB_OPCODE_TID_RDMA) == IB_OPCODE_TID_RDMA) {
+		pbc &= ~PBC_INSERT_HCRC_SMASK;
+		pbc |= (u64)PBC_IHCRC_LKDETH << PBC_INSERT_HCRC_SHIFT;
+	}
+	return pbc;
+}
+
+int hfi2_verbs_send_dma(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			u64 pbc)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ahg_info *ahg_info = priv->s_ahg;
+	u32 hdrwords = ps->s_txreq->hdr_dwords;
+	u32 len = ps->s_txreq->s_cur_size;
+	u32 plen;
+	struct hfi2_ibdev *dev = ps->dev;
+	struct hfi2_pportdata *ppd = ps->ppd;
+	struct hfi2_devdata *dd = ppd->dd;
+	struct verbs_txreq *tx;
+	u8 sc5 = priv->s_sc;
+	int ret;
+	u32 dwords;
+
+	if (ps->s_txreq->phdr.hdr.hdr_type) {
+		u8 extra_bytes;
+
+		if (dd->params->chip_type == CHIP_WFR) {
+			extra_bytes = hfi2_get_16b_padding((hdrwords << 2), len);
+			dwords = (len + extra_bytes + (SIZE_OF_CRC << 2) +
+				  SIZE_OF_LT) >> 2;
+		} else {
+			/* round up to multiple of 8 */
+			extra_bytes = hfi2_pad8((hdrwords << 2) + len);
+			/* add ICRC QW */
+			dwords = (len + extra_bytes + 8) >> 2;
+		}
+	} else {
+		dwords = (len + 3) >> 2;
+	}
+	plen = hdrwords + dwords + sizeof(pbc) / 4;
+
+	tx = ps->s_txreq;
+	if (!sdma_txreq_built(&tx->txreq)) {
+		if (likely(pbc == 0)) {
+			u32 vl = sc_to_vlt(ppd, sc5);
+			u32 l2;
+			u32 dlid;
+
+			/* No vl15 here */
+			/* set PBC_DC_INFO bit (aka SC[4]) in pbc */
+			if (ps->s_txreq->phdr.hdr.hdr_type) {
+				l2 = PBC_L2_16B;
+				dlid = hfi2_16B_get_dlid(&tx->phdr.hdr.opah);
+			} else {
+				pbc |= pbc_sc4_flag(sc5);
+				l2 = PBC_L2_9B;
+				dlid = ib_get_dlid(&tx->phdr.hdr.ibh);
+			}
+
+			pbc = dd->params->create_pbc(ppd, pbc, qp->srate_mbps,
+						     vl, plen, l2, dlid,
+						     priv->s_sendcontext->hw_context);
+
+			if (unlikely(hfi2_dbg_should_fault_tx(qp, ps->opcode)))
+				pbc = hfi2_fault_tx(qp, ps->opcode, pbc);
+			else
+				/* Update HCRC based on packet opcode */
+				pbc = update_hcrc(ps->opcode, pbc);
+		}
+		tx->wqe = qp->s_wqe;
+		ret = build_verbs_tx_desc(tx->sde, len, tx, ahg_info, pbc);
+		if (unlikely(ret))
+			goto bail_build;
+	}
+	/*
+	 * sdma_send_txreq() does not know about verbs_txreq and may transfer
+	 * ownership of tx's ref.  Take an extra reference here so that tx
+	 * remains valid for the trace that follows the sdma_send_txreq() call.
+	 *
+	 * Reference ownership will have been transferred if the return value
+	 * is 0, -ECOMM, or -EIOCBQUEUED.
+	 */
+	hfi2_get_txreq(tx);
+	ret = sdma_send_txreq(tx->sde, ps->wait, &tx->txreq, ps->pkts_sent);
+	trace_sdma_output_ibhdr(dd, &ps->s_txreq->phdr.hdr, ib_is_sc5(sc5), ret);
+	if (unlikely(ret < 0))
+		goto bail_ecomm;
+	/* ret == 0 => the extra reference has been transferred */
+
+	update_tx_opstats(qp, ps, plen);
+	/* put ps's reference */
+	hfi2_put_txreq(tx);
+	ps->s_txreq = NULL;
+	return 0;
+
+bail_ecomm:
+	if (ret == -EIOCBQUEUED) {
+		/*
+		 * The SDMA engine descriptor queue is full.  The txreq (and
+		 * its reference) has been added to the wait list.
+		 *
+		 * Return an error so pending transmit attempts cease until
+		 * the engine is ready.
+		 */
+	} else if (ret == -ECOMM) {
+		/*
+		 * The SDMA engine has stopped.  The txreq (and its reference)
+		 * has been transferred to a flush list.
+		 *
+		 * Return 0 so all pending transmits also drop like this one.
+		 */
+		ret = 0;
+	} else {
+		/*
+		 * An unexpected error has occurred.  Drop the txreq.  Remove
+		 * the extra reference taken above.
+		 */
+		hfi2_put_txreq(tx);
+	}
+	/* put ps's reference */
+	hfi2_put_txreq(tx);
+	ps->s_txreq = NULL;
+	return ret;
+bail_build:
+	/* wait_kmem() may take a reference to ps->s_txreq */
+	ret = wait_kmem(dev, qp, ps);
+	/* put ps's reference */
+	hfi2_put_txreq(ps->s_txreq);
+	ps->s_txreq = NULL;
+	return ret;
+}
+
+/*
+ * If we are now in the error state, return zero to flush the
+ * send work request.
+ */
+static int pio_wait(struct rvt_qp *qp,
+		    struct send_context *sc,
+		    struct hfi2_pkt_state *ps,
+		    u32 flag)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_devdata *dd = sc->dd;
+	unsigned long flags;
+	int ret = 0;
+
+	/*
+	 * Note that as soon as want_buffer() is called and
+	 * possibly before it returns, sc_piobufavail()
+	 * could be called. Therefore, put QP on the I/O wait list before
+	 * enabling the PIO avail interrupt.
+	 */
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK) {
+		/* take a new txreq reference */
+		hfi2_get_txreq(ps->s_txreq);
+		write_seqlock(&sc->waitlock);
+		list_add_tail(&ps->s_txreq->txreq.list,
+			      &ps->wait->tx_head);
+		if (list_empty(&priv->s_iowait.list)) {
+			struct hfi2_ibdev *dev = &dd->verbs_dev;
+			int was_empty;
+
+			dev->n_piowait += !!(flag & RVT_S_WAIT_PIO);
+			dev->n_piodrain += !!(flag & HFI2_S_WAIT_PIO_DRAIN);
+			qp->s_flags |= flag;
+			was_empty = list_empty(&sc->piowait);
+			iowait_get_priority(&priv->s_iowait);
+			iowait_queue(ps->pkts_sent, &priv->s_iowait,
+				     &sc->piowait);
+			priv->s_iowait.lock = &sc->waitlock;
+			trace_hfi2_qpsleep(qp, RVT_S_WAIT_PIO);
+			rvt_get_qp(qp);
+			/* counting: only call wantpiobuf_intr if first user */
+			if (was_empty)
+				hfi2_sc_wantpiobuf_intr(sc, 1);
+		}
+		write_sequnlock(&sc->waitlock);
+		hfi2_qp_unbusy(qp, ps->wait);
+		ret = -EBUSY;
+	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+	return ret;
+}
+
+static void verbs_pio_complete(void *arg, int code)
+{
+	struct rvt_qp *qp = (struct rvt_qp *)arg;
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	if (iowait_pio_dec(&priv->s_iowait))
+		iowait_drain_wakeup(&priv->s_iowait);
+}
+
+int hfi2_verbs_send_pio(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			u64 pbc)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+	u32 hdrwords = ps->s_txreq->hdr_dwords;
+	struct rvt_sge_state *ss = ps->s_txreq->ss;
+	u32 len = ps->s_txreq->s_cur_size;
+	u32 dwords;
+	u32 plen;
+	struct hfi2_pportdata *ppd = ps->ppd;
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 *hdr;
+	u8 sc5;
+	unsigned long flags = 0;
+	struct send_context *sc;
+	struct pio_buf *pbuf;
+	int wc_status = IB_WC_SUCCESS;
+	int ret = 0;
+	pio_release_cb cb = NULL;
+	u8 extra_bytes = 0;
+
+	if (ps->s_txreq->phdr.hdr.hdr_type) {
+		if (dd->params->chip_type == CHIP_WFR) {
+			u8 pad_size = hfi2_get_16b_padding((hdrwords << 2), len);
+
+			extra_bytes = pad_size + (SIZE_OF_CRC << 2) + SIZE_OF_LT;
+		} else {
+			/* round up to next multiple of 8, add ICRC */
+			extra_bytes = hfi2_pad8((hdrwords << 2) + len) + 8;
+		}
+		dwords = (len + extra_bytes) >> 2;
+		hdr = (u32 *)&ps->s_txreq->phdr.hdr.opah;
+	} else {
+		dwords = (len + 3) >> 2;
+		hdr = (u32 *)&ps->s_txreq->phdr.hdr.ibh;
+	}
+	plen = hdrwords + dwords + sizeof(pbc) / 4;
+
+	/* only RC/UC use complete */
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_RC:
+	case IB_QPT_UC:
+		cb = verbs_pio_complete;
+		break;
+	default:
+		break;
+	}
+
+	/* vl15 special case taken care of in ud.c */
+	sc5 = priv->s_sc;
+	sc = ps->s_txreq->psc;
+
+	if (likely(pbc == 0)) {
+		u8 vl = sc_to_vlt(ppd, sc5);
+		u32 l2;
+		u32 dlid;
+
+		/* set PBC_DC_INFO bit (aka SC[4]) in pbc */
+		if (ps->s_txreq->phdr.hdr.hdr_type) {
+			l2 = PBC_L2_16B;
+			dlid = hfi2_16B_get_dlid(&ps->s_txreq->phdr.hdr.opah);
+		} else {
+			pbc |= pbc_sc4_flag(sc5);
+			l2 = PBC_L2_9B;
+			dlid = ib_get_dlid(&ps->s_txreq->phdr.hdr.ibh);
+		}
+
+		pbc = dd->params->create_pbc(ppd, pbc, qp->srate_mbps, vl, plen,
+					     l2, dlid,
+					     priv->s_sendcontext->hw_context);
+		if (unlikely(hfi2_dbg_should_fault_tx(qp, ps->opcode)))
+			pbc = hfi2_fault_tx(qp, ps->opcode, pbc);
+		else
+			/* Update HCRC based on packet opcode */
+			pbc = update_hcrc(ps->opcode, pbc);
+	}
+	if (cb)
+		iowait_pio_inc(&priv->s_iowait);
+	pbuf = sc_buffer_alloc(sc, plen, cb, qp);
+	if (IS_ERR_OR_NULL(pbuf)) {
+		if (cb)
+			verbs_pio_complete(qp, 0);
+		if (IS_ERR(pbuf)) {
+			/*
+			 * If we have filled the PIO buffers to capacity and are
+			 * not in an active state this request is not going to
+			 * go out to so just complete it with an error or else a
+			 * ULP or the core may be stuck waiting.
+			 */
+			hfi2_cdbg(
+				PIO,
+				"alloc failed. state not active, completing");
+			wc_status = IB_WC_GENERAL_ERR;
+			goto pio_bail;
+		} else {
+			/*
+			 * This is a normal occurrence. The PIO buffs are full
+			 * up but we are still happily sending, well we could be
+			 * so lets continue to queue the request.
+			 */
+			hfi2_cdbg(PIO, "alloc failed. state active, queuing");
+			ret = pio_wait(qp, sc, ps, RVT_S_WAIT_PIO);
+			/* txreq may or may not be queued - done either way */
+			goto bail;
+		}
+	}
+
+	if (dwords == 0) {
+		pio_copy(dd, pbuf, pbc, hdr, hdrwords);
+	} else {
+		seg_pio_copy_start(pbuf, pbc,
+				   hdr, hdrwords * 4);
+		if (ss) {
+			while (len) {
+				void *addr = ss->sge.vaddr;
+				u32 slen = rvt_get_sge_length(&ss->sge, len);
+
+				rvt_update_sge(ss, slen, false);
+				seg_pio_copy_mid(pbuf, addr, slen);
+				len -= slen;
+			}
+		}
+		/* add icrc, lt byte, and padding to flit */
+		if (extra_bytes)
+			seg_pio_copy_mid(pbuf, dd->sdma_pad_dma,
+					 extra_bytes);
+
+		seg_pio_copy_end(pbuf);
+	}
+
+	update_tx_opstats(qp, ps, plen);
+	trace_pio_output_ibhdr(dd, &ps->s_txreq->phdr.hdr, ib_is_sc5(sc5), 0);
+
+pio_bail:
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (qp->s_wqe) {
+		rvt_send_complete(qp, qp->s_wqe, wc_status);
+	} else if (qp->ibqp.qp_type == IB_QPT_RC) {
+		if (unlikely(wc_status == IB_WC_GENERAL_ERR))
+			hfi2_rc_verbs_aborted(qp, &ps->s_txreq->phdr.hdr);
+		hfi2_rc_send_complete(qp, &ps->s_txreq->phdr.hdr);
+	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
+
+	ret = 0;
+
+bail:
+	/* release ps hold on s_txreq */
+	hfi2_put_txreq(ps->s_txreq);
+	ps->s_txreq = NULL;
+	return ret;
+}
+
+/*
+ * egress_pkey_matches_entry - return 1 if the pkey matches ent (ent
+ * being an entry from the partition key table), return 0
+ * otherwise. Use the matching criteria for egress partition keys
+ * specified in the OPAv1 spec., section 9.1l.7.
+ */
+static inline int egress_pkey_matches_entry(u16 pkey, u16 ent)
+{
+	u16 mkey = pkey & PKEY_LOW_15_MASK;
+	u16 mentry = ent & PKEY_LOW_15_MASK;
+
+	if (mkey == mentry) {
+		/*
+		 * If pkey[15] is set (full partition member),
+		 * is bit 15 in the corresponding table element
+		 * clear (limited member)?
+		 */
+		if (pkey & PKEY_MEMBER_MASK)
+			return !!(ent & PKEY_MEMBER_MASK);
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * egress_pkey_check - check P_KEY of a packet
+ * @ppd:  Physical IB port data
+ * @slid: SLID for packet
+ * @pkey: PKEY for header
+ * @sc5:  SC for packet
+ * @s_pkey_index: It will be used for look up optimization for kernel contexts
+ * only. If it is negative value, then it means user contexts is calling this
+ * function.
+ *
+ * It checks if hdr's pkey is valid.
+ *
+ * Return: 0 on success, otherwise, 1
+ */
+int egress_pkey_check(struct hfi2_pportdata *ppd, u32 slid, u16 pkey,
+		      u8 sc5, int8_t s_pkey_index)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i;
+	int is_user_ctxt_mechanism = (s_pkey_index < 0);
+
+	if (!(ppd->part_enforce & HFI2_PART_ENFORCE_OUT))
+		return 0;
+
+	/* If SC15, pkey[0:14] must be 0x7fff */
+	if ((sc5 == 0xf) && ((pkey & PKEY_LOW_15_MASK) != PKEY_LOW_15_MASK))
+		goto bad;
+
+	/* Is the pkey = 0x0, or 0x8000? */
+	if ((pkey & PKEY_LOW_15_MASK) == 0)
+		goto bad;
+
+	/*
+	 * For the kernel contexts only, if a qp is passed into the function,
+	 * the most likely matching pkey has index qp->s_pkey_index
+	 */
+	if (!is_user_ctxt_mechanism &&
+	    egress_pkey_matches_entry(pkey, ppd->pkeys[s_pkey_index])) {
+		return 0;
+	}
+
+	for (i = 0; i < dd->params->pkey_table_size; i++) {
+		if (egress_pkey_matches_entry(pkey, ppd->pkeys[i]))
+			return 0;
+	}
+bad:
+	/*
+	 * For the user-context mechanism, the P_KEY check would only happen
+	 * once per SDMA request, not once per packet.  Therefore, there's no
+	 * need to increment the counter for the user-context mechanism.
+	 */
+	if (!is_user_ctxt_mechanism) {
+		incr_cntr64(&ppd->port_xmit_constraint_errors);
+		if (!(dd->err_info_xmit_constraint.status &
+		      OPA_EI_STATUS_SMASK)) {
+			dd->err_info_xmit_constraint.status |=
+				OPA_EI_STATUS_SMASK;
+			dd->err_info_xmit_constraint.slid = slid;
+			dd->err_info_xmit_constraint.pkey = pkey;
+		}
+	}
+	return 1;
+}
+
+/*
+ * get_send_routine - choose an egress routine
+ *
+ * Choose an egress routine based on QP type
+ * and size
+ */
+static inline send_routine get_send_routine(struct rvt_qp *qp,
+					    struct hfi2_pkt_state *ps)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(qp->ibqp.device);
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct verbs_txreq *tx = ps->s_txreq;
+
+	if (unlikely(!(dd->flags & HFI2_HAS_SEND_DMA)))
+		return dd->process_pio_send;
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_SMI:
+		return dd->process_pio_send;
+	case IB_QPT_GSI:
+	case IB_QPT_UD:
+		break;
+	case IB_QPT_UC:
+	case IB_QPT_RC:
+		priv->s_running_pkt_size =
+			(tx->s_cur_size + priv->s_running_pkt_size) / 2;
+		if (piothreshold &&
+		    priv->s_running_pkt_size <= min(piothreshold, qp->pmtu) &&
+		    (BIT(ps->opcode & OPMASK) & pio_opmask[ps->opcode >> 5]) &&
+		    iowait_sdma_pending(&priv->s_iowait) == 0 &&
+		    !sdma_txreq_built(&tx->txreq))
+			return dd->process_pio_send;
+		break;
+	default:
+		break;
+	}
+	return dd->process_dma_send;
+}
+
+/**
+ * hfi2_verbs_send - send a packet
+ * @qp: the QP to send on
+ * @ps: the state of the packet to send
+ *
+ * Return zero if packet is sent or queued OK.
+ * Return non-zero and clear qp->s_flags RVT_S_BUSY otherwise.
+ */
+int hfi2_verbs_send(struct rvt_qp *qp, struct hfi2_pkt_state *ps)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(qp->ibqp.device);
+	struct hfi2_qp_priv *priv = qp->priv;
+	struct hfi2_ibport *ibp = to_iport(qp->ibqp.device, qp->port_num);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct ib_other_headers *ohdr = NULL;
+	send_routine sr;
+	int ret;
+	u16 pkey;
+	u32 slid;
+	u8 l4 = 0;
+
+	/* locate the pkey within the headers */
+	if (ps->s_txreq->phdr.hdr.hdr_type) {
+		struct hfi2_16b_header *hdr = &ps->s_txreq->phdr.hdr.opah;
+
+		l4 = hfi2_16B_get_l4(hdr);
+		if (l4 == OPA_16B_L4_IB_LOCAL)
+			ohdr = &hdr->u.oth;
+		else if (l4 == OPA_16B_L4_IB_GLOBAL)
+			ohdr = &hdr->u.l.oth;
+
+		slid = hfi2_16B_get_slid(hdr);
+		pkey = hfi2_16B_get_pkey(hdr);
+	} else {
+		struct ib_header *hdr = &ps->s_txreq->phdr.hdr.ibh;
+		u8 lnh = ib_get_lnh(hdr);
+
+		if (lnh == HFI2_LRH_GRH)
+			ohdr = &hdr->u.l.oth;
+		else
+			ohdr = &hdr->u.oth;
+		slid = ib_get_slid(hdr);
+		pkey = ib_bth_get_pkey(ohdr);
+	}
+
+	if (likely(l4 != OPA_16B_L4_FM))
+		ps->opcode = ib_bth_get_opcode(ohdr);
+	else
+		ps->opcode = IB_OPCODE_UD_SEND_ONLY;
+
+	sr = get_send_routine(qp, ps);
+	ret = egress_pkey_check(ppd, slid, pkey,
+				priv->s_sc, qp->s_pkey_index);
+	if (unlikely(ret)) {
+		/*
+		 * The value we are returning here does not get propagated to
+		 * the verbs caller. Thus we need to complete the request with
+		 * error otherwise the caller could be sitting waiting on the
+		 * completion event. Only do this for PIO. SDMA has its own
+		 * mechanism for handling the errors. So for SDMA we can just
+		 * return.
+		 */
+		if (sr == dd->process_pio_send) {
+			unsigned long flags;
+
+			hfi2_cdbg(PIO, "%s() Failed. Completing with err",
+				  __func__);
+			spin_lock_irqsave(&qp->s_lock, flags);
+			rvt_send_complete(qp, qp->s_wqe, IB_WC_GENERAL_ERR);
+			spin_unlock_irqrestore(&qp->s_lock, flags);
+		}
+		return -EINVAL;
+	}
+	if (sr == dd->process_dma_send && iowait_pio_pending(&priv->s_iowait)) {
+		ret = pio_wait(qp, ps->s_txreq->psc, ps, HFI2_S_WAIT_PIO_DRAIN);
+		/* queued or not, ps is done with s_txreq */
+		hfi2_put_txreq(ps->s_txreq);
+		ps->s_txreq = NULL;
+		return ret;
+	}
+	return sr(qp, ps, 0);
+}
+
+/**
+ * hfi2_fill_device_attr - Fill in rvt dev info device attributes.
+ * @dd: the device data structure
+ */
+static void hfi2_fill_device_attr(struct hfi2_devdata *dd)
+{
+	struct rvt_dev_info *rdi = &dd->verbs_dev.rdi;
+	u32 ver = dd->dc8051_ver;
+
+	memset(&rdi->dparms.props, 0, sizeof(rdi->dparms.props));
+
+	rdi->dparms.props.fw_ver = ((u64)(dc8051_ver_maj(ver)) << 32) |
+		((u64)(dc8051_ver_min(ver)) << 16) |
+		(u64)dc8051_ver_patch(ver);
+
+	rdi->dparms.props.device_cap_flags = IB_DEVICE_BAD_PKEY_CNTR |
+			IB_DEVICE_BAD_QKEY_CNTR | IB_DEVICE_SHUTDOWN_PORT |
+			IB_DEVICE_SYS_IMAGE_GUID | IB_DEVICE_RC_RNR_NAK_GEN |
+			IB_DEVICE_PORT_ACTIVE_EVENT | IB_DEVICE_SRQ_RESIZE |
+			IB_DEVICE_MEM_MGT_EXTENSIONS;
+	rdi->dparms.props.kernel_cap_flags = IBK_RDMA_NETDEV_OPA;
+	rdi->dparms.props.page_size_cap = PAGE_SIZE;
+	rdi->dparms.props.vendor_id = dd->oui1 << 16 | dd->oui2 << 8 | dd->oui3;
+	rdi->dparms.props.vendor_part_id = dd->pcidev->device;
+	rdi->dparms.props.hw_ver = dd->minrev;
+	rdi->dparms.props.sys_image_guid = ib_hfi2_sys_image_guid;
+	rdi->dparms.props.max_mr_size = U64_MAX;
+	rdi->dparms.props.max_fast_reg_page_list_len = UINT_MAX;
+	rdi->dparms.props.max_qp = hfi2_max_qps;
+	rdi->dparms.props.max_qp_wr =
+		(hfi2_max_qp_wrs >= HFI2_QP_WQE_INVALID ?
+		 HFI2_QP_WQE_INVALID - 1 : hfi2_max_qp_wrs);
+	rdi->dparms.props.max_send_sge = hfi2_max_sges;
+	rdi->dparms.props.max_recv_sge = hfi2_max_sges;
+	rdi->dparms.props.max_sge_rd = hfi2_max_sges;
+	rdi->dparms.props.max_cq = hfi2_max_cqs;
+	rdi->dparms.props.max_ah = hfi2_max_ahs;
+	rdi->dparms.props.max_cqe = hfi2_max_cqes;
+	rdi->dparms.props.max_pd = hfi2_max_pds;
+	rdi->dparms.props.max_qp_rd_atom = HFI2_MAX_RDMA_ATOMIC;
+	rdi->dparms.props.max_qp_init_rd_atom = 255;
+	rdi->dparms.props.max_srq = hfi2_max_srqs;
+	rdi->dparms.props.max_srq_wr = hfi2_max_srq_wrs;
+	rdi->dparms.props.max_srq_sge = hfi2_max_srq_sges;
+	rdi->dparms.props.atomic_cap = IB_ATOMIC_GLOB;
+	rdi->dparms.props.max_pkeys = hfi2_get_npkeys(dd);
+	rdi->dparms.props.max_mcast_grp = hfi2_max_mcast_grps;
+	rdi->dparms.props.max_mcast_qp_attach = hfi2_max_mcast_qp_attached;
+	rdi->dparms.props.max_total_mcast_qp_attach =
+					rdi->dparms.props.max_mcast_qp_attach *
+					rdi->dparms.props.max_mcast_grp;
+}
+
+static inline u16 opa_speed_to_ib(u16 in)
+{
+	u16 out = 0;
+
+	if (in & OPA_LINK_SPEED_100G)
+		out |= IB_SPEED_NDR;
+	if (in & OPA_LINK_SPEED_50G)
+		out |= IB_SPEED_HDR;
+	if (in & OPA_LINK_SPEED_25G)
+		out |= IB_SPEED_EDR;
+	if (in & OPA_LINK_SPEED_12_5G)
+		out |= IB_SPEED_FDR;
+
+	return out;
+}
+
+/*
+ * Convert a single OPA link width (no multiple flags) to an IB value.
+ * A zero OPA link width means link down, which means the IB width value
+ * is a don't care.
+ */
+static inline u16 opa_width_to_ib(u16 in)
+{
+	switch (in) {
+	case OPA_LINK_WIDTH_1X:
+	/* map 2x and 3x to 1x as they don't exist in IB */
+	case OPA_LINK_WIDTH_2X:
+	case OPA_LINK_WIDTH_3X:
+		return IB_WIDTH_1X;
+	default: /* link down or unknown, return our largest width */
+	case OPA_LINK_WIDTH_4X:
+		return IB_WIDTH_4X;
+	}
+}
+
+static int query_port(struct rvt_dev_info *rdi, u32 port_num,
+		      struct ib_port_attr *props)
+{
+	struct hfi2_ibdev *verbs_dev = dev_from_rdi(rdi);
+	struct hfi2_devdata *dd = dd_from_dev(verbs_dev);
+	struct hfi2_pportdata *ppd = &dd->pport[port_num - 1];
+	u32 lid = ppd->lid;
+
+	/* props being zeroed by the caller, avoid zeroing it here */
+	props->lid = lid ? lid : 0;
+	props->lmc = ppd->lmc;
+	/* OPA logical states match IB logical states */
+	props->state = driver_lstate(ppd);
+	props->phys_state = driver_pstate(ppd);
+	props->gid_tbl_len = HFI2_GUIDS_PER_PORT;
+	props->active_width = (u8)opa_width_to_ib(ppd->link_width_active);
+	/* see rate_show() in ib core/sysfs.c */
+	props->active_speed = opa_speed_to_ib(ppd->link_speed_active);
+	props->max_vl_num = ppd->vls_supported;
+
+	/* Once we are a "first class" citizen and have added the OPA MTUs to
+	 * the core we can advertise the larger MTU enum to the ULPs, for now
+	 * advertise only 4K.
+	 *
+	 * Those applications which are either OPA aware or pass the MTU enum
+	 * from the Path Records to us will get the new 8k MTU.  Those that
+	 * attempt to process the MTU enum may fail in various ways.
+	 */
+	props->max_mtu = mtu_to_enum((!valid_ib_mtu(hfi2_max_mtu) ?
+				      4096 : hfi2_max_mtu), IB_MTU_4096);
+	props->active_mtu = !valid_ib_mtu(ppd->ibmtu) ? props->max_mtu :
+		mtu_to_enum(ppd->ibmtu, IB_MTU_4096);
+	props->phys_mtu = hfi2_max_mtu;
+
+	return 0;
+}
+
+static int modify_device(struct ib_device *device,
+			 int device_modify_mask,
+			 struct ib_device_modify *device_modify)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(device);
+	unsigned i;
+	int ret;
+
+	if (device_modify_mask & ~(IB_DEVICE_MODIFY_SYS_IMAGE_GUID |
+				   IB_DEVICE_MODIFY_NODE_DESC)) {
+		ret = -EOPNOTSUPP;
+		goto bail;
+	}
+
+	if (device_modify_mask & IB_DEVICE_MODIFY_NODE_DESC) {
+		memcpy(device->node_desc, device_modify->node_desc,
+		       IB_DEVICE_NODE_DESC_MAX);
+		for (i = 0; i < dd->num_pports; i++) {
+			struct hfi2_ibport *ibp = &dd->pport[i].ibport_data;
+
+			hfi2_node_desc_chg(ibp);
+		}
+	}
+
+	if (device_modify_mask & IB_DEVICE_MODIFY_SYS_IMAGE_GUID) {
+		ib_hfi2_sys_image_guid =
+			cpu_to_be64(device_modify->sys_image_guid);
+		for (i = 0; i < dd->num_pports; i++) {
+			struct hfi2_ibport *ibp = &dd->pport[i].ibport_data;
+
+			hfi2_sys_guid_chg(ibp);
+		}
+	}
+
+	ret = 0;
+
+bail:
+	return ret;
+}
+
+static int shut_down_port(struct rvt_dev_info *rdi, u32 port_num)
+{
+	struct hfi2_ibdev *verbs_dev = dev_from_rdi(rdi);
+	struct hfi2_devdata *dd = dd_from_dev(verbs_dev);
+	struct hfi2_pportdata *ppd = &dd->pport[port_num - 1];
+
+	set_link_down_reason(ppd, OPA_LINKDOWN_REASON_UNKNOWN, 0,
+			     OPA_LINKDOWN_REASON_UNKNOWN);
+	return set_link_state(ppd, HLS_DN_DOWNDEF);
+}
+
+static int hfi2_get_guid_be(struct rvt_dev_info *rdi, struct rvt_ibport *rvp,
+			    int guid_index, __be64 *guid)
+{
+	struct hfi2_ibport *ibp = container_of(rvp, struct hfi2_ibport, rvp);
+
+	if (guid_index >= HFI2_GUIDS_PER_PORT)
+		return -EINVAL;
+
+	*guid = get_sguid(ibp, guid_index);
+	return 0;
+}
+
+/*
+ * convert ah port,sl to sc
+ */
+u8 ah_to_sc(struct ib_device *ibdev, struct rdma_ah_attr *ah)
+{
+	struct hfi2_ibport *ibp = to_iport(ibdev, rdma_ah_get_port_num(ah));
+
+	return ibp->sl_to_sc[rdma_ah_get_sl(ah)];
+}
+
+static int hfi2_check_ah(struct ib_device *ibdev, struct rdma_ah_attr *ah_attr)
+{
+	struct hfi2_ibport *ibp;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_devdata *dd;
+	u8 sc5;
+	u8 sl;
+	u8 vl;
+
+	if (hfi2_check_mcast(rdma_ah_get_dlid(ah_attr)) &&
+	    !(rdma_ah_get_ah_flags(ah_attr) & IB_AH_GRH))
+		return -EINVAL;
+
+	/* test the mapping for validity */
+	ibp = to_iport(ibdev, rdma_ah_get_port_num(ah_attr));
+	ppd = ppd_from_ibp(ibp);
+	dd = dd_from_ppd(ppd);
+
+	sl = rdma_ah_get_sl(ah_attr);
+	if (sl >= ARRAY_SIZE(ibp->sl_to_sc))
+		return -EINVAL;
+	sl = array_index_nospec(sl, ARRAY_SIZE(ibp->sl_to_sc));
+
+	sc5 = ibp->sl_to_sc[sl];
+	vl = sc_to_vlt(ppd, sc5);
+	if (vl > num_vls && vl != 0xf)
+		return -EINVAL;
+	return 0;
+}
+
+static void hfi2_notify_new_ah(struct ib_device *ibdev,
+			       struct rdma_ah_attr *ah_attr,
+			       struct rvt_ah *ah)
+{
+	struct hfi2_ibport *ibp;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_devdata *dd;
+	u8 sc5;
+	struct rdma_ah_attr *attr = &ah->attr;
+
+	/*
+	 * Do not trust reading anything from rvt_ah at this point as it is not
+	 * done being setup. We can however modify things which we need to set.
+	 */
+
+	ibp = to_iport(ibdev, rdma_ah_get_port_num(ah_attr));
+	ppd = ppd_from_ibp(ibp);
+	sc5 = ibp->sl_to_sc[rdma_ah_get_sl(&ah->attr)];
+	hfi2_update_ah_attr(ibdev, attr);
+	hfi2_make_opa_lid(attr);
+	dd = dd_from_ppd(ppd);
+	ah->vl = sc_to_vlt(ppd, sc5);
+	if (ah->vl < num_vls || ah->vl == 15)
+		ah->log_pmtu = ilog2(ppd->vld[ah->vl].mtu);
+}
+
+/**
+ * hfi2_get_npkeys - return the size of the PKEY table for context 0
+ * @dd: the hfi2_ib device
+ */
+unsigned int hfi2_get_npkeys(struct hfi2_devdata *dd)
+{
+	return dd->params->pkey_table_size;
+}
+
+static void init_ibport(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_ibport *ibp = &ppd->ibport_data;
+	size_t sz = ARRAY_SIZE(ibp->sl_to_sc);
+	int i;
+
+	for (i = 0; i < sz; i++) {
+		ibp->sl_to_sc[i] = i;
+		ibp->sc_to_sl[i] = i;
+	}
+
+	for (i = 0; i < RVT_MAX_TRAP_LISTS ; i++)
+		INIT_LIST_HEAD(&ibp->rvp.trap_lists[i].list);
+	timer_setup(&ibp->rvp.trap_timer, hfi2_handle_trap_timer, 0);
+
+	spin_lock_init(&ibp->rvp.lock);
+	/* Set the prefix to the default value (see ch. 4.1.1) */
+	ibp->rvp.gid_prefix = IB_DEFAULT_GID_PREFIX;
+	ibp->rvp.sm_lid = 0;
+	/*
+	 * Below should only set bits defined in OPA PortInfo.CapabilityMask
+	 * and PortInfo.CapabilityMask3
+	 */
+	ibp->rvp.port_cap_flags = IB_PORT_AUTO_MIGR_SUP |
+		IB_PORT_CAP_MASK_NOTICE_SUP;
+	ibp->rvp.port_cap3_flags = OPA_CAP_MASK3_IsSharedSpaceSupported;
+	ibp->rvp.pma_counter_select[0] = IB_PMA_PORT_XMIT_DATA;
+	ibp->rvp.pma_counter_select[1] = IB_PMA_PORT_RCV_DATA;
+	ibp->rvp.pma_counter_select[2] = IB_PMA_PORT_XMIT_PKTS;
+	ibp->rvp.pma_counter_select[3] = IB_PMA_PORT_RCV_PKTS;
+	ibp->rvp.pma_counter_select[4] = IB_PMA_PORT_XMIT_WAIT;
+
+	RCU_INIT_POINTER(ibp->rvp.qp[0], NULL);
+	RCU_INIT_POINTER(ibp->rvp.qp[1], NULL);
+}
+
+static void hfi2_get_dev_fw_str(struct ib_device *ibdev, char *str)
+{
+	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
+	struct hfi2_ibdev *dev = dev_from_rdi(rdi);
+	u32 ver = dd_from_dev(dev)->dc8051_ver;
+
+	snprintf(str, IB_FW_VERSION_NAME_MAX, "%u.%u.%u", dc8051_ver_maj(ver),
+		 dc8051_ver_min(ver), dc8051_ver_patch(ver));
+}
+
+static const char * const driver_cntr_names[] = {
+	/* must be element 0*/
+	"DRIVER_KernIntr",
+	"DRIVER_ErrorIntr",
+	"DRIVER_Tx_Errs",
+	"DRIVER_Rcv_Errs",
+	"DRIVER_HW_Errs",
+	"DRIVER_NoPIOBufs",
+	"DRIVER_CtxtsOpen",
+	"DRIVER_RcvLen_Errs",
+	"DRIVER_EgrBufFull",
+	"DRIVER_EgrHdrFull"
+};
+
+static struct rdma_stat_desc *dev_cntr_descs;
+static struct rdma_stat_desc *port_cntr_descs;
+int num_driver_cntrs = ARRAY_SIZE(driver_cntr_names);
+static int num_dev_cntrs;
+static int num_port_cntrs;
+
+/*
+ * Convert a list of names separated by '\n' into an array of NULL terminated
+ * strings. Optionally some entries can be reserved in the array to hold extra
+ * external strings.
+ */
+static int init_cntr_names(const char *names_in, const size_t names_len,
+			   int num_extra_names, int *num_cntrs,
+			   struct rdma_stat_desc **cntr_descs)
+{
+	struct rdma_stat_desc *names_out;
+	char *p;
+	int i, n;
+
+	n = 0;
+	for (i = 0; i < names_len; i++)
+		if (names_in[i] == '\n')
+			n++;
+
+	names_out = kzalloc((n + num_extra_names) * sizeof(*names_out)
+				+ names_len,
+			    GFP_KERNEL);
+	if (!names_out) {
+		*num_cntrs = 0;
+		*cntr_descs = NULL;
+		return -ENOMEM;
+	}
+
+	p = (char *)&names_out[n + num_extra_names];
+	memcpy(p, names_in, names_len);
+
+	for (i = 0; i < n; i++) {
+		names_out[i].name = p;
+		p = strchr(p, '\n');
+		*p++ = '\0';
+	}
+
+	*num_cntrs = n;
+	*cntr_descs = names_out;
+	return 0;
+}
+
+static struct rdma_hw_stats *hfi2_alloc_hw_device_stats(struct ib_device *ibdev)
+{
+	if (!dev_cntr_descs) {
+		struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+		int i, err;
+
+		err = init_cntr_names(dd->cntrnames, dd->cntrnameslen,
+				      num_driver_cntrs,
+				      &num_dev_cntrs, &dev_cntr_descs);
+		if (err)
+			return NULL;
+
+		for (i = 0; i < num_driver_cntrs; i++)
+			dev_cntr_descs[num_dev_cntrs + i].name =
+							driver_cntr_names[i];
+	}
+	return rdma_alloc_hw_stats_struct(dev_cntr_descs,
+					  num_dev_cntrs + num_driver_cntrs,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static struct rdma_hw_stats *hfi2_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num)
+{
+	if (!port_cntr_descs) {
+		struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+		int err;
+
+		err = init_cntr_names(dd->portcntrnames, dd->portcntrnameslen,
+				      0,
+				      &num_port_cntrs, &port_cntr_descs);
+		if (err)
+			return NULL;
+	}
+	return rdma_alloc_hw_stats_struct(port_cntr_descs, num_port_cntrs,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static u64 hfi2_sps_ints(void)
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
+	return sps_ints;
+}
+
+static int get_hw_stats(struct ib_device *ibdev, struct rdma_hw_stats *stats,
+			u32 port, int index)
+{
+	u64 *values;
+	int count;
+
+	if (!port) {
+		u64 *stats = (u64 *)&hfi2_stats;
+		int i;
+
+		hfi2_read_cntrs(dd_from_ibdev(ibdev), NULL, &values);
+		values[num_dev_cntrs] = hfi2_sps_ints();
+		for (i = 1; i < num_driver_cntrs; i++)
+			values[num_dev_cntrs + i] = stats[i];
+		count = num_dev_cntrs + num_driver_cntrs;
+	} else {
+		struct hfi2_ibport *ibp = to_iport(ibdev, port);
+
+		hfi2_read_portcntrs(ppd_from_ibp(ibp), NULL, &values);
+		count = num_port_cntrs;
+	}
+
+	memcpy(stats->value, values, count * sizeof(u64));
+	return count;
+}
+
+static const struct ib_device_ops hfi2_dev_ops = {
+	.owner = THIS_MODULE,
+	.driver_id = RDMA_DRIVER_HFI2,
+
+	.alloc_hw_device_stats = hfi2_alloc_hw_device_stats,
+	.alloc_hw_port_stats = hfi2_alloc_hw_port_stats,
+	.device_group = &ib_hfi2_attr_group,
+	.get_dev_fw_str = hfi2_get_dev_fw_str,
+	.get_hw_stats = get_hw_stats,
+	.modify_device = modify_device,
+	.port_groups = wfr_attr_port_groups,
+	/* keep process mad in the driver */
+	.process_mad = hfi2_process_mad,
+	.rdma_netdev_get_params = hfi2_ipoib_rn_get_params,
+	.write_iter = hfi2_uverbs_write_iter,
+};
+
+static const struct ib_device_ops cport_dev_ops = {
+	.owner = THIS_MODULE,
+	.driver_id = RDMA_DRIVER_HFI2,
+
+	/* XXX - some more of these probably need to change */
+	.alloc_hw_device_stats = hfi2_alloc_hw_device_stats,
+	.alloc_hw_port_stats = hfi2_alloc_hw_port_stats,
+	.device_group = &ib_hfi2_attr_group,
+	.get_dev_fw_str = hfi2_get_dev_fw_str,
+	.get_hw_stats = get_hw_stats,
+	.modify_device = modify_device,
+	.port_groups = cport_attr_port_groups,
+	/* keep process mad in the driver */
+	.process_mad = cport_process_mad,
+	.rdma_netdev_get_params = hfi2_ipoib_rn_get_params,
+	.write_iter = hfi2_uverbs_write_iter,
+};
+
+/**
+ * hfi2_register_ib_device - register our device with the infiniband core
+ * @dd: the device data structure
+ * Return 0 if successful, errno if unsuccessful.
+ */
+int hfi2_register_ib_device(struct hfi2_devdata *dd)
+{
+	struct hfi2_ibdev *dev = &dd->verbs_dev;
+	struct ib_device *ibdev = &dev->rdi.ibdev;
+	struct hfi2_pportdata *ppd;
+	unsigned int i;
+	int ret;
+	u8 max_qos_shift;
+
+	/* rdmavt has only a single QPN space - use the largest QOS shift */
+	max_qos_shift = 1; /* always shift by at least 1 */
+	for (i = 0, ppd = dd->pport; i < dd->num_pports; i++, ppd++) {
+		init_ibport(ppd);
+		max_qos_shift = max_t(u8, max_qos_shift, ppd->qos_shift);
+	}
+
+	/* Only need to initialize non-zero fields. */
+
+	timer_setup(&dev->mem_timer, mem_timer, 0);
+
+	seqlock_init(&dev->iowait_lock);
+	seqlock_init(&dev->txwait_lock);
+	INIT_LIST_HEAD(&dev->txwait);
+	INIT_LIST_HEAD(&dev->memwait);
+
+	ret = verbs_txreq_init(dev);
+	if (ret)
+		goto err_verbs_txreq;
+
+	/* Use first-port GUID as node guid */
+	ibdev->node_guid = get_sguid(&dd->pport[HFI2_PORT_IDX].ibport_data,
+				     HFI2_PORT_GUID_INDEX);
+
+	/*
+	 * The system image GUID is supposed to be the same for all
+	 * HFIs in a single system but since there can be other
+	 * device types in the system, we can't be sure this is unique.
+	 */
+	if (!ib_hfi2_sys_image_guid)
+		ib_hfi2_sys_image_guid = ibdev->node_guid;
+	ibdev->phys_port_cnt = dd->num_pports;
+	ibdev->dev.parent = &dd->pcidev->dev;
+
+	if (dd->cport)
+		ib_set_device_ops(ibdev, &cport_dev_ops);
+	else
+		ib_set_device_ops(ibdev, &hfi2_dev_ops);
+
+	strscpy(ibdev->node_desc, init_utsname()->nodename,
+		sizeof(ibdev->node_desc));
+
+	if (IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS))
+		ibdev->driver_def = hfi2_ib_defs;
+
+	/*
+	 * Fill in rvt info object.
+	 */
+	dd->verbs_dev.rdi.driver_f.get_pci_dev = get_pci_dev;
+	dd->verbs_dev.rdi.driver_f.check_ah = hfi2_check_ah;
+	dd->verbs_dev.rdi.driver_f.notify_new_ah = hfi2_notify_new_ah;
+	dd->verbs_dev.rdi.driver_f.get_guid_be = hfi2_get_guid_be;
+	dd->verbs_dev.rdi.driver_f.query_port_state = query_port;
+	dd->verbs_dev.rdi.driver_f.shut_down_port = shut_down_port;
+	dd->verbs_dev.rdi.driver_f.cap_mask_chg = hfi2_cap_mask_chg;
+	/*
+	 * Fill in rvt info device attributes.
+	 */
+	hfi2_fill_device_attr(dd);
+
+	/* queue pair */
+	dd->verbs_dev.rdi.dparms.qp_table_size = hfi2_qp_table_size;
+	dd->verbs_dev.rdi.dparms.qpn_start = 0;
+	dd->verbs_dev.rdi.dparms.qpn_inc = 1;
+	dd->verbs_dev.rdi.dparms.qos_shift = max_qos_shift;
+	dd->verbs_dev.rdi.dparms.qpn_res_start = RVT_KDETH_QP_BASE;
+	dd->verbs_dev.rdi.dparms.qpn_res_end = RVT_AIP_QP_MAX;
+	dd->verbs_dev.rdi.dparms.max_rdma_atomic = HFI2_MAX_RDMA_ATOMIC;
+	dd->verbs_dev.rdi.dparms.psn_mask = PSN_MASK;
+	dd->verbs_dev.rdi.dparms.psn_shift = PSN_SHIFT;
+	dd->verbs_dev.rdi.dparms.psn_modify_mask = PSN_MODIFY_MASK;
+	dd->verbs_dev.rdi.dparms.core_cap_flags = RDMA_CORE_PORT_INTEL_OPA |
+						RDMA_CORE_CAP_OPA_AH;
+	dd->verbs_dev.rdi.dparms.max_mad_size = OPA_MGMT_MAD_SIZE;
+
+	dd->verbs_dev.rdi.driver_f.qp_priv_alloc = qp_priv_alloc;
+	dd->verbs_dev.rdi.driver_f.qp_priv_init = hfi2_qp_priv_init;
+	dd->verbs_dev.rdi.driver_f.qp_priv_free = qp_priv_free;
+	dd->verbs_dev.rdi.driver_f.free_all_qps = free_all_qps;
+	dd->verbs_dev.rdi.driver_f.notify_qp_reset = notify_qp_reset;
+	dd->verbs_dev.rdi.driver_f.do_send = hfi2_do_send_from_rvt;
+	dd->verbs_dev.rdi.driver_f.schedule_send = hfi2_schedule_send;
+	dd->verbs_dev.rdi.driver_f.schedule_send_no_lock = _hfi2_schedule_send;
+	dd->verbs_dev.rdi.driver_f.get_pmtu_from_attr = get_pmtu_from_attr;
+	dd->verbs_dev.rdi.driver_f.notify_error_qp = notify_error_qp;
+	dd->verbs_dev.rdi.driver_f.flush_qp_waiters = flush_qp_waiters;
+	dd->verbs_dev.rdi.driver_f.stop_send_queue = stop_send_queue;
+	dd->verbs_dev.rdi.driver_f.quiesce_qp = quiesce_qp;
+	dd->verbs_dev.rdi.driver_f.notify_error_qp = notify_error_qp;
+	dd->verbs_dev.rdi.driver_f.mtu_from_qp = mtu_from_qp;
+	dd->verbs_dev.rdi.driver_f.mtu_to_path_mtu = mtu_to_path_mtu;
+	dd->verbs_dev.rdi.driver_f.check_modify_qp = hfi2_check_modify_qp;
+	dd->verbs_dev.rdi.driver_f.modify_qp = hfi2_modify_qp;
+	dd->verbs_dev.rdi.driver_f.notify_restart_rc = hfi2_restart_rc;
+	dd->verbs_dev.rdi.driver_f.setup_wqe = hfi2_setup_wqe;
+	dd->verbs_dev.rdi.driver_f.comp_vect_cpu_lookup =
+						hfi2_comp_vect_mappings_lookup;
+	dd->verbs_dev.rdi.driver_f.alloc_ucontext = hfi2_alloc_ucontext;
+	dd->verbs_dev.rdi.driver_f.dealloc_ucontext = hfi2_dealloc_ucontext;
+	dd->verbs_dev.rdi.driver_f.mmap = hfi2_rdma_mmap;
+
+	/* completeion queue */
+	dd->verbs_dev.rdi.ibdev.num_comp_vectors = dd->comp_vect_possible_cpus;
+	dd->verbs_dev.rdi.dparms.node = dd->node;
+
+	/* misc settings */
+	dd->verbs_dev.rdi.flags = 0; /* Let rdmavt handle it all */
+	dd->verbs_dev.rdi.dparms.lkey_table_size = hfi2_lkey_table_size;
+	dd->verbs_dev.rdi.dparms.nports = dd->num_pports;
+	dd->verbs_dev.rdi.dparms.npkeys = hfi2_get_npkeys(dd);
+	dd->verbs_dev.rdi.dparms.sge_copy_mode = sge_copy_mode;
+	dd->verbs_dev.rdi.dparms.wss_threshold = wss_threshold;
+	dd->verbs_dev.rdi.dparms.wss_clean_period = wss_clean_period;
+	dd->verbs_dev.rdi.dparms.reserved_operations = 1;
+	dd->verbs_dev.rdi.dparms.extra_rdma_atomic = HFI2_TID_RDMA_WRITE_CNT;
+
+	/* post send table */
+	dd->verbs_dev.rdi.post_parms = hfi2_post_parms;
+
+	/* opcode translation table */
+	dd->verbs_dev.rdi.wc_opcode = ib_hfi2_wc_opcode;
+
+	for (i = 0, ppd = dd->pport; i < dd->num_pports; i++, ppd++)
+		rvt_init_port(&dd->verbs_dev.rdi,
+			      &ppd->ibport_data.rvp,
+			      i,
+			      ppd->pkeys);
+
+	ret = rvt_register_device(&dd->verbs_dev.rdi);
+	if (ret)
+		goto err_verbs_txreq;
+
+	ret = hfi2_verbs_register_sysfs(dd);
+	if (ret)
+		goto err_class;
+
+	return ret;
+
+err_class:
+	rvt_unregister_device(&dd->verbs_dev.rdi);
+err_verbs_txreq:
+	verbs_txreq_exit(dev);
+	dd_dev_err(dd, "cannot register verbs: %d!\n", -ret);
+	return ret;
+}
+
+void hfi2_unregister_ib_device(struct hfi2_devdata *dd)
+{
+	struct hfi2_ibdev *dev = &dd->verbs_dev;
+
+	hfi2_verbs_unregister_sysfs(dd);
+
+	rvt_unregister_device(&dd->verbs_dev.rdi);
+
+	if (!list_empty(&dev->txwait))
+		dd_dev_err(dd, "txwait list not empty!\n");
+	if (!list_empty(&dev->memwait))
+		dd_dev_err(dd, "memwait list not empty!\n");
+
+	timer_delete_sync(&dev->mem_timer);
+	verbs_txreq_exit(dev);
+
+	kfree(dev_cntr_descs);
+	kfree(port_cntr_descs);
+	dev_cntr_descs = NULL;
+	port_cntr_descs = NULL;
+}
+
+void hfi2_cnp_rcv(struct hfi2_packet *packet)
+{
+	struct hfi2_ibport *ibp = rcd_to_iport(packet->rcd);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct rvt_qp *qp = packet->qp;
+	u32 lqpn, rqpn = 0;
+	u16 rlid = 0;
+	u8 sl, svc_type;
+
+	switch (packet->qp->ibqp.qp_type) {
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
+	case IB_QPT_SMI:
+	case IB_QPT_GSI:
+	case IB_QPT_UD:
+		svc_type = IB_CC_SVCTYPE_UD;
+		break;
+	default:
+		ibp->rvp.n_pkt_drops++;
+		return;
+	}
+
+	sl = ibp->sc_to_sl[packet->sc];
+	lqpn = qp->ibqp.qp_num;
+
+	process_becn(ppd, sl, rlid, lqpn, rqpn, svc_type);
+}
diff --git a/drivers/infiniband/hw/hfi2/verbs_txreq.c b/drivers/infiniband/hw/hfi2/verbs_txreq.c
new file mode 100644
index 000000000000..db27b612d258
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/verbs_txreq.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2016 - 2018 Intel Corporation.
+ */
+
+#include "hfi2.h"
+#include "verbs_txreq.h"
+#include "qp.h"
+#include "trace.h"
+
+#define TXREQ_LEN 24
+
+void dealloc_txreq(struct kref *ref)
+{
+	struct verbs_txreq *tx = container_of(ref, struct verbs_txreq, ref);
+	struct hfi2_ibdev *dev;
+	struct rvt_qp *qp;
+	unsigned long flags;
+	unsigned int seq;
+	struct hfi2_qp_priv *priv;
+
+	qp = tx->qp;
+	dev = to_idev(qp->ibqp.device);
+
+	if (tx->mr)
+		rvt_put_mr(tx->mr);
+
+	sdma_txclean(dd_from_dev(dev), &tx->txreq);
+
+	/* Free verbs_txreq and return to slab cache */
+	kmem_cache_free(dev->verbs_txreq_cache, tx);
+
+	do {
+		seq = read_seqbegin(&dev->txwait_lock);
+		if (!list_empty(&dev->txwait)) {
+			struct iowait *wait;
+
+			write_seqlock_irqsave(&dev->txwait_lock, flags);
+			wait = list_first_entry(&dev->txwait, struct iowait,
+						list);
+			qp = iowait_to_qp(wait);
+			priv = qp->priv;
+			list_del_init(&priv->s_iowait.list);
+			/* refcount held until actual wake up */
+			write_sequnlock_irqrestore(&dev->txwait_lock, flags);
+			hfi2_qp_wakeup(qp, RVT_S_WAIT_TX);
+			break;
+		}
+	} while (read_seqretry(&dev->txwait_lock, seq));
+}
+
+struct verbs_txreq *__get_txreq(struct hfi2_ibdev *dev,
+				struct rvt_qp *qp)
+	__must_hold(&qp->s_lock)
+{
+	struct verbs_txreq *tx = NULL;
+
+	write_seqlock(&dev->txwait_lock);
+	if (ib_rvt_state_ops[qp->state] & RVT_PROCESS_RECV_OK) {
+		struct hfi2_qp_priv *priv;
+
+		tx = kmem_cache_alloc(dev->verbs_txreq_cache, VERBS_TXREQ_GFP);
+		if (tx)
+			goto out;
+		priv = qp->priv;
+		if (list_empty(&priv->s_iowait.list)) {
+			dev->n_txwait++;
+			qp->s_flags |= RVT_S_WAIT_TX;
+			list_add_tail(&priv->s_iowait.list, &dev->txwait);
+			priv->s_iowait.lock = &dev->txwait_lock;
+			trace_hfi2_qpsleep(qp, RVT_S_WAIT_TX);
+			rvt_get_qp(qp);
+		}
+		qp->s_flags &= ~RVT_S_BUSY;
+	}
+out:
+	write_sequnlock(&dev->txwait_lock);
+	return tx;
+}
+
+int verbs_txreq_init(struct hfi2_ibdev *dev)
+{
+	char buf[TXREQ_LEN];
+	struct hfi2_devdata *dd = dd_from_dev(dev);
+
+	snprintf(buf, sizeof(buf), "hfi2_%u_vtxreq_cache", dd->unit);
+	dev->verbs_txreq_cache = kmem_cache_create(buf,
+						   sizeof(struct verbs_txreq),
+						   0, SLAB_HWCACHE_ALIGN,
+						   NULL);
+	if (!dev->verbs_txreq_cache)
+		return -ENOMEM;
+	return 0;
+}
+
+void verbs_txreq_exit(struct hfi2_ibdev *dev)
+{
+	kmem_cache_destroy(dev->verbs_txreq_cache);
+	dev->verbs_txreq_cache = NULL;
+}



