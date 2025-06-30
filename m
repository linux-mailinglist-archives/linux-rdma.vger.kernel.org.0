Return-Path: <linux-rdma+bounces-11780-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AFCAEE640
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EEAA7A1D1B
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601922BE7D1;
	Mon, 30 Jun 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="bC5WFfni"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2100.outbound.protection.outlook.com [40.107.223.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0F92E54B3
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306303; cv=fail; b=M0yIlJml6jS5y3GxlYqZ8G75olMsONtbH5PmQUqteB2x83SFH5sG8ZKLHNQO13v4YCSPFBYSzfZF/QlUyDc3QVjjisSeA9IoQUg4f+hdFlfHvrF9kgvVBZ0JJM9d3ya8lUPUg6PWNnBjcoGc9WL1DC1v2Zy1C1Qftdil4cyj+wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306303; c=relaxed/simple;
	bh=9wV2ssvc4qipCqZptwaKUqEfg1USVGL1aM6XUQo9TQM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sM7yEahslGkI/QCXio6SwTxQnJJ+JtsWyiqBFDa4zj5bjGl+GsppATAUBwRwSGV7i3zMJP6kBPTN61SOKPzKqyr+mZcU/Vv8L2WLbdzw+7Wj434LV+iE3epH51a0hSOy0tdvjGqO4hmsxzg+t5acxFJmxOxp7qPbsLxTYAijVQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=bC5WFfni; arc=fail smtp.client-ip=40.107.223.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqMieHLYYJ210QeMcoBUumlN6dcmip9iojJYNEFCfrPHU/4MvsnMB+Gq9SrIhH+ArEFWfaK+ClBRtb5wAn5hF99bbWIi39I+nG0zvbiCn7xzVnssrcEBIr2hQVj8T0sP5PIOTaUT+QV/MOExonh8cJV9xdm914tjKpqOO+vwxbbsQjhm0yJutnZQr6zdpwBySX7Tjy7VZKw+kgYIKEaohDoXovgUJOY/rmBNnrA3Wr2n0pEXqvYAQiIbRuhXrCY+c7sgtM+2Z/bm8JhR5EBO7cFKgy3wBfCAVWB8eR4PnoQSTEDuiXkfRtohPXknexUIFBmwlx4Km+5hfFtJfB2FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSAxS6tDMgUK4r6YCO+827TG2NeRQxRzmAyHALx1n1g=;
 b=tP81WTEpAsqqsMFWR3MQ0rD/tEMoChrPg5RxMzk9ly0M3eYnNYo6YC1jqgKV+T/uiOfEKnrnLQ9AT7ZoDgKbVzn9pK+Sodfe61stmJmO7CzoFTjj+CO11s63pk3trKbZWZt29mwolTmp/FwuZiI/O7EQzDFTP332igw91w0S6SAZi9/an/WsFMRfOceyie9SsMbNo4D3Xid72N8ZgJcs3S2K1p2RSbM6GGtBMsRcud+8SwYkN9u5Tbop9OEaISy8oiH9p60PL46f1B0oUUrAunRxr0LjsN3pn6SQ85edvyH1boYTved7FBTKzUmo5GvBqL2nmb1hS/SxbdxEpZtB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSAxS6tDMgUK4r6YCO+827TG2NeRQxRzmAyHALx1n1g=;
 b=bC5WFfnizflE9oNzFa6TEQFkzbsixKS3BZT67m8KaMPahGjMPVYSzVeg9rvaUICZvpTUrWwq1dw9Pqi4ODFXmtOcvO6aLRMG6BFPZKjTMVWdQLdOQ254BMtENNrjTOzRPO1XX/g5lbK88aolRKMse1gR/smUtb4NI1PhAuc6MzcRDZ9KhZ8UZIidr99MAwf2iJn5174vRRl3BRUC7H5f6wdUghWryx0kFxPSgBnkJdexHq/n/n0ue8DNyLD/jqn3FgxkLeiMkGSCuzJaHry845j3RXumsrjbwbgH8aKbaDQo2abUpxbon1qvdsFb1NOjt5uDjqwPDIk6PcLvK8B4XA==
Received: from SN1PR12CA0088.namprd12.prod.outlook.com (2603:10b6:802:21::23)
 by SA1PR01MB8670.prod.exchangelabs.com (2603:10b6:806:3a7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Mon, 30 Jun 2025 17:58:11 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::4f) by SN1PR12CA0088.outlook.office365.com
 (2603:10b6:802:21::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Mon,
 30 Jun 2025 17:58:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:10 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id E189B14D731;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id ACAD71848B5DB;
	Mon, 30 Jun 2025 11:31:13 -0400 (EDT)
Subject: [PATCH for-next 17/23] RDMA/hfi2: Add IO related headers
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:31:13 -0400
Message-ID:
 <175129747365.1859400.10435766274074444526.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|SA1PR01MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a68ae43-196a-4bd7-fb29-08ddb7ffad70
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDV5VCtheGcyQUoydFp0UzVUZ1lpLzBOV3hNT3hOUVVnQ3VMZ056cWdxenVi?=
 =?utf-8?B?OVkwUmpaSTIxaTNSblN1UlBEdnhCY3RJK3V3M081MjFUamhpaWFXYk5GRUxm?=
 =?utf-8?B?am96bXBCQUR3NWpYa0s5L3R5UGZib1FxZzFtZG5jRmNBaDlRQjRuUXZBMDNt?=
 =?utf-8?B?UGhvUlJSMERRdEtQdTY1RUh0Zlk4NThha2w0ZUxENjBJejgyQ1ZIOVFvN3Zn?=
 =?utf-8?B?d1FhQ2xGdHR0Vm1EeGE0Q0dGVHJrcXF5ZHRzSjQwSUx2aTdtZ1pIWHhhTkRU?=
 =?utf-8?B?b0NWMW9QMDhaVlZuaWI2bVZ3MkZHRHprNFpGajNjYlQyL3hSbUZqNlFobGxB?=
 =?utf-8?B?b0tYd1U1NnVyalpCSjB3S0lPWklxTk5MdlBkSk1CMVNsRHBZMWZQNlNuT0ha?=
 =?utf-8?B?eldtTlpFaFRuT0xjQUFwMHRsSmJhVzkxNStZSDRqUXJsVEp1MDY3dEpNcXE1?=
 =?utf-8?B?MzVGd1FZNk9paGVjcXlGZ1pPYXVVNjJzaXBydVVEV3d1RlVHelhQbTBpUlV6?=
 =?utf-8?B?MUw2MlBWbjdjMVpoVjI2b0NkTVpEMTMzQzBtRUtrc2JxeFJlVnNPSGhMdnZR?=
 =?utf-8?B?eWFtZUIraTQ0K21sK0pyYTBQZ0Y3K1FSUVJGK0o0Y2FybjlnUGRRM1hWRlFJ?=
 =?utf-8?B?dnJac0hKelZoblNSUnJJcWh3VmtFR3pKUGsyVEpwNm1FV3VuK3h1cEJ4LzZH?=
 =?utf-8?B?K1c3YkloRmU2VlpqSTM0anJlb3JUQ1pDaStyV2RybXdKRkFmcStBMmpEVWVX?=
 =?utf-8?B?b0h5T0dkVUNrcTJmaWl4N2E5czV1Ri9pQXFycEV0M0ZqQTY0TG9KQ2x0RVdk?=
 =?utf-8?B?Zngzczl3WmFGbUlkTGVPTVUrVlN5TW8xSzVVTittMFdxWGNIMm5YZTIwenNy?=
 =?utf-8?B?SVFqaVpESkV4Y0pFMmVaMjhMd05od0taS3QvWWZWbDlOMzJhT0lBUHp1d0R3?=
 =?utf-8?B?V3FKU3A0dDdCL1lLblNicjZaZmw5djB4MU54MkZaR21hZERrSFJvWjkxeStl?=
 =?utf-8?B?bUxZb2UzNWpTRTlNYWJmd0ErRUxBMUJOS01uS2h2Ym90YWFqV2RCeDl1cmRJ?=
 =?utf-8?B?WWlTZ0NLZVNUekVlV29FL3Z5MG1vQnBlanZkTUVuS2dEVTl6ZHNvVWEwcjRi?=
 =?utf-8?B?MGpkaXNUclNOZ3cxZ21VMUFiOVJWNmVvcHJocllZTm1GVmpQVG5YM2VJUEdH?=
 =?utf-8?B?ZHZmR2Y1WG9ObExsSk1mNlFZOG9CSEtzQVBvMGR2Z1ZGVGVEWnRTcnhMbDYr?=
 =?utf-8?B?N3ozS2JTNElDSXk1NGhsd3VkaGt1a1ZndC81WWZTSklrTjJCN1Uyd1pNRjJL?=
 =?utf-8?B?NXI3blNYTTc0U3VUK0VwQXpqY3FJQjhpNHRwbG1jSWN5OU5xRmxkdi8ya2ps?=
 =?utf-8?B?VkhwY1V5dDhQQy8xS0VqbEhyOVhqR0FuQVgrV0JJSUkrRnNYUzRVS05wOWIy?=
 =?utf-8?B?U3dOdEZtemNVMEVia0Mwa1BwQ25KVXRYV012RTA1OTh6RHNVRGtWdGl5NUg1?=
 =?utf-8?B?S09yK2hwTjQxOWJWUUFZelg5VHVBcythenFmVVBESzZac2VNaWtuaStIZ3RD?=
 =?utf-8?B?dG1tWDliME5DalVXV3RsOW1OMHZoR1VnSmFBWFEwUnR3a1djcC85T2N1QmZx?=
 =?utf-8?B?VXV4ZGE1Wlp5aGx4MFV0bmxXUTVYcFVwTlRMUGp5d29KL3d0d21hdmhCQ2Na?=
 =?utf-8?B?VTNWQlB2eml6Mk5uTkRzTWtMUHpYdWhpV09EMVZmRy8yVzQ4YjBCaXlsTFNW?=
 =?utf-8?B?MndFeXNMcy9iMWhwQXNMVjZCOGNaREpTemw3OG03NEF2U1VlYnF2cTZVVU9U?=
 =?utf-8?B?ckFRUnpJT0Y1cFpFWmtQdmgxTnJQSU5zNW5icFQ3WWlXKzVXRXRoU2ZQTk1x?=
 =?utf-8?B?QUVsbG1oaUhtT3gxNXUzZ0VoazY3MmZnZVRmSVZBSDE2TUROZElkRHByemww?=
 =?utf-8?B?ZE9wQmJ0bGV3Yzl1eHk1cHpRY1FlUWVxRmV5SGF2T00ydGNxNFl5SExBL3Er?=
 =?utf-8?B?aXBPVXBneTZOMS80ZGlOQ3Q4TkJrWnJMS1BuY04vTG0yR0FUNDNTNGp3Zmxt?=
 =?utf-8?Q?6/3JSd?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:10.9177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a68ae43-196a-4bd7-fb29-08ddb7ffad70
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB8670

The hfi2 driver will continue to support verbs, and libfabric. However
unlike hfi1 there is no private cdev and user operations are managed
through the ib core cdev and passed to the driver.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/exp_rcv.h      |  156 ++++
 drivers/infiniband/hw/hfi2/file_ops.h     |   46 +
 drivers/infiniband/hw/hfi2/iowait.h       |  457 +++++++++++
 drivers/infiniband/hw/hfi2/ipoib.h        |  172 ++++
 drivers/infiniband/hw/hfi2/netdev.h       |   99 ++
 drivers/infiniband/hw/hfi2/pinning.h      |   74 ++
 drivers/infiniband/hw/hfi2/pio.h          |  305 +++++++
 drivers/infiniband/hw/hfi2/qp.h           |  107 +++
 drivers/infiniband/hw/hfi2/rc.h           |   59 +
 drivers/infiniband/hw/hfi2/sdma.h         | 1212 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/sdma_defs.h    |  116 +++
 drivers/infiniband/hw/hfi2/sdma_txreq.h   |  104 ++
 drivers/infiniband/hw/hfi2/tid_rdma.h     |  320 ++++++++
 drivers/infiniband/hw/hfi2/user_exp_rcv.h |  404 ++++++++++
 drivers/infiniband/hw/hfi2/user_sdma.h    |  262 ++++++
 drivers/infiniband/hw/hfi2/uverbs.h       |   19 
 drivers/infiniband/hw/hfi2/verbs.h        |  488 ++++++++++++
 drivers/infiniband/hw/hfi2/verbs_txreq.h  |   97 ++
 18 files changed, 4497 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/exp_rcv.h
 create mode 100644 drivers/infiniband/hw/hfi2/file_ops.h
 create mode 100644 drivers/infiniband/hw/hfi2/iowait.h
 create mode 100644 drivers/infiniband/hw/hfi2/ipoib.h
 create mode 100644 drivers/infiniband/hw/hfi2/netdev.h
 create mode 100644 drivers/infiniband/hw/hfi2/pinning.h
 create mode 100644 drivers/infiniband/hw/hfi2/pio.h
 create mode 100644 drivers/infiniband/hw/hfi2/qp.h
 create mode 100644 drivers/infiniband/hw/hfi2/rc.h
 create mode 100644 drivers/infiniband/hw/hfi2/sdma.h
 create mode 100644 drivers/infiniband/hw/hfi2/sdma_defs.h
 create mode 100644 drivers/infiniband/hw/hfi2/sdma_txreq.h
 create mode 100644 drivers/infiniband/hw/hfi2/tid_rdma.h
 create mode 100644 drivers/infiniband/hw/hfi2/user_exp_rcv.h
 create mode 100644 drivers/infiniband/hw/hfi2/user_sdma.h
 create mode 100644 drivers/infiniband/hw/hfi2/uverbs.h
 create mode 100644 drivers/infiniband/hw/hfi2/verbs.h
 create mode 100644 drivers/infiniband/hw/hfi2/verbs_txreq.h

diff --git a/drivers/infiniband/hw/hfi2/exp_rcv.h b/drivers/infiniband/hw/hfi2/exp_rcv.h
new file mode 100644
index 000000000000..76c422646626
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/exp_rcv.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2017 Intel Corporation.
+ */
+
+#ifndef _HFI2_EXP_RCV_H
+#define _HFI2_EXP_RCV_H
+#include "hfi2.h"
+
+#define EXP_TID_SET_EMPTY(set) (set.count == 0 && list_empty(&set.list))
+
+#define EXP_TID_TIDLEN_MASK   0x7FFULL
+#define EXP_TID_TIDLEN_SHIFT  0
+#define EXP_TID_TIDCTRL_MASK  0x3ULL
+#define EXP_TID_TIDCTRL_SHIFT 20
+#define EXP_TID_TIDIDX_MASK   0x3FFULL
+#define EXP_TID_TIDIDX_SHIFT  22
+
+/* Expected buffer entry (TID) addressing supported by the hardware */
+#define EXP_TID_ADDR_SHIFT    12
+#define EXP_TID_ADDR_SIZE     BIT(EXP_TID_ADDR_SHIFT)
+
+#define EXP_TID_GET(tid, field)	\
+	(((tid) >> EXP_TID_TID##field##_SHIFT) & EXP_TID_TID##field##_MASK)
+
+#define EXP_TID_SET(field, value)			\
+	(((value) & EXP_TID_TID##field##_MASK) <<	\
+	 EXP_TID_TID##field##_SHIFT)
+#define EXP_TID_CLEAR(tid, field) ({					\
+		(tid) &= ~(EXP_TID_TID##field##_MASK <<			\
+			   EXP_TID_TID##field##_SHIFT);			\
+		})
+#define EXP_TID_RESET(tid, field, value) do {				\
+		EXP_TID_CLEAR(tid, field);				\
+		(tid) |= EXP_TID_SET(field, (value));			\
+	} while (0)
+
+/*
+ * Define fields in the KDETH header so we can update the header
+ * template.
+ */
+#define KDETH_OFFSET_SHIFT        0
+#define KDETH_OFFSET_MASK         0x7fff
+#define KDETH_OM_SHIFT            15
+#define KDETH_OM_MASK             0x1
+#define KDETH_TID_SHIFT           16
+#define KDETH_TID_MASK            0x3ff
+#define KDETH_TIDCTRL_SHIFT       26
+#define KDETH_TIDCTRL_MASK        0x3
+#define KDETH_INTR_SHIFT          28
+#define KDETH_INTR_MASK           0x1
+#define KDETH_SH_SHIFT            29
+#define KDETH_SH_MASK             0x1
+#define KDETH_KVER_SHIFT          30
+#define KDETH_KVER_MASK           0x3
+#define KDETH_JKEY_SHIFT          0x0
+#define KDETH_JKEY_MASK           0xff
+#define KDETH_HCRC_UPPER_SHIFT    16
+#define KDETH_HCRC_UPPER_MASK     0xff
+#define KDETH_HCRC_LOWER_SHIFT    24
+#define KDETH_HCRC_LOWER_MASK     0xff
+
+#define KDETH_GET(val, field)						\
+	(((le32_to_cpu((val))) >> KDETH_##field##_SHIFT) & KDETH_##field##_MASK)
+#define KDETH_SET(dw, field, val) do {					\
+		u32 dwval = le32_to_cpu(dw);				\
+		dwval &= ~(KDETH_##field##_MASK << KDETH_##field##_SHIFT); \
+		dwval |= (((val) & KDETH_##field##_MASK) << \
+			  KDETH_##field##_SHIFT);			\
+		dw = cpu_to_le32(dwval);				\
+	} while (0)
+
+#define KDETH_RESET(dw, field, val) ({ dw = 0; KDETH_SET(dw, field, val); })
+
+/* KDETH OM multipliers and switch over point */
+#define KDETH_OM_SMALL     4
+#define KDETH_OM_SMALL_SHIFT     2
+#define KDETH_OM_LARGE     64
+#define KDETH_OM_LARGE_SHIFT     6
+#define KDETH_OM_MAX_SIZE  (1 << ((KDETH_OM_LARGE / KDETH_OM_SMALL) + 1))
+
+struct tid_group {
+	struct list_head list;
+	u32 base;
+	u8 size;
+	u8 used;
+	u8 map;
+};
+
+static inline void tid_group_add_tail(struct tid_group *grp,
+				      struct exp_tid_set *set)
+{
+	list_add_tail(&grp->list, &set->list);
+	set->count++;
+}
+
+static inline void tid_group_remove(struct tid_group *grp,
+				    struct exp_tid_set *set)
+{
+	list_del_init(&grp->list);
+	set->count--;
+}
+
+static inline void tid_group_move(struct tid_group *group,
+				  struct exp_tid_set *s1,
+				  struct exp_tid_set *s2)
+{
+	tid_group_remove(group, s1);
+	tid_group_add_tail(group, s2);
+}
+
+static inline struct tid_group *tid_group_pop(struct exp_tid_set *set)
+{
+	struct tid_group *grp =
+		list_first_entry(&set->list, struct tid_group, list);
+	list_del_init(&grp->list);
+	set->count--;
+	return grp;
+}
+
+static inline u32 create_tid(u32 rcventry, u32 npages)
+{
+	u32 pair = rcventry & ~0x1;
+
+	return EXP_TID_SET(IDX, pair >> 1) |
+		EXP_TID_SET(CTRL, 1 << (rcventry - pair)) |
+		EXP_TID_SET(LEN, npages);
+}
+
+/**
+ * hfi2_tid_group_to_idx - convert an index to a group
+ * @rcd - the receive context
+ * @grp - the group pointer
+ */
+static inline u16
+hfi2_tid_group_to_idx(struct hfi2_ctxtdata *rcd, struct tid_group *grp)
+{
+	return grp - &rcd->groups[0];
+}
+
+/**
+ * hfi2_idx_to_tid_group - convert a group to an index
+ * @rcd - the receive context
+ * @idx - the index
+ */
+static inline struct tid_group *
+hfi2_idx_to_tid_group(struct hfi2_ctxtdata *rcd, u16 idx)
+{
+	return &rcd->groups[idx];
+}
+
+int hfi2_alloc_ctxt_rcv_groups(struct hfi2_ctxtdata *rcd);
+void hfi2_free_ctxt_rcv_groups(struct hfi2_ctxtdata *rcd);
+void hfi2_exp_tid_group_init(struct hfi2_ctxtdata *rcd);
+
+#endif /* _HFI2_EXP_RCV_H */
diff --git a/drivers/infiniband/hw/hfi2/file_ops.h b/drivers/infiniband/hw/hfi2/file_ops.h
new file mode 100644
index 000000000000..f03ea6d21ad0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/file_ops.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2024 Cornelis Networks, Inc.
+ */
+
+#ifndef _HFI2_FILE_OPS_H
+#define _HFI2_FILE_OPS_H
+
+#include "hfi2.h"
+
+int hfi2_set_uevent_bits(struct hfi2_pportdata *ppd, const int evtbit);
+struct hfi2_filedata *hfi2_alloc_filedata(struct hfi2_devdata *dd);
+void hfi2_dealloc_filedata(struct hfi2_filedata *fdata);
+int hfi2_do_assign_ctxt(struct hfi2_filedata *fd,
+			const struct hfi2_assign_ctxt_cmd *uinfo);
+int manage_rcvq(struct hfi2_ctxtdata *uctxt, u16 subctxt, int start_stop);
+int user_event_ack(struct hfi2_ctxtdata *uctxt, u16 subctxt,
+		   unsigned long events);
+int set_ctxt_pkey(struct hfi2_ctxtdata *uctxt, u16 pkey);
+int ctxt_reset(struct hfi2_ctxtdata *uctxt);
+int hfi2_get_pinning_stats(struct hfi2_filedata *fd,
+			   struct hfi2_pin_stats *stats);
+int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma);
+ssize_t hfi2_do_write_iter(struct hfi2_filedata *fd, struct iov_iter *from);
+
+/*
+ * Types of memories mapped into user processes' space
+ */
+enum mmap_types {
+	PIO_BUFS = 1,
+	PIO_BUFS_SOP,
+	PIO_CRED,
+	RCV_HDRQ,
+	RCV_EGRBUF,
+	UREGS,
+	EVENTS,
+	STATUS,
+	RTAIL,
+	SUBCTXT_UREGS,
+	SUBCTXT_RCV_HDRQ,
+	SUBCTXT_EGRBUF,
+	SDMA_COMP,
+	RCV_RHEQ,
+};
+
+#endif /* _HFI2_FILE_OPS_H */
diff --git a/drivers/infiniband/hw/hfi2/iowait.h b/drivers/infiniband/hw/hfi2/iowait.h
new file mode 100644
index 000000000000..23e5d6600064
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/iowait.h
@@ -0,0 +1,457 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#ifndef _HFI2_IOWAIT_H
+#define _HFI2_IOWAIT_H
+
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/wait.h>
+#include <linux/sched.h>
+
+#include "sdma_txreq.h"
+
+/*
+ * typedef (*restart_t)() - restart callback
+ * @work: pointer to work structure
+ */
+typedef void (*restart_t)(struct work_struct *work);
+
+#define IOWAIT_PENDING_IB  0x0
+#define IOWAIT_PENDING_TID 0x1
+
+/*
+ * A QP can have multiple Send Engines (SEs).
+ *
+ * The current use case is for supporting a TID RDMA
+ * packet build/xmit mechanism independent from verbs.
+ */
+#define IOWAIT_SES 2
+#define IOWAIT_IB_SE 0
+#define IOWAIT_TID_SE 1
+
+struct sdma_txreq;
+struct sdma_engine;
+/**
+ * @iowork: the work struct
+ * @tx_head: list of prebuilt packets
+ * @iow: the parent iowait structure
+ *
+ * This structure is the work item (process) specific
+ * details associated with the each of the two SEs of the
+ * QP.
+ *
+ * The workstruct and the queued TXs are unique to each
+ * SE.
+ */
+struct iowait;
+struct iowait_work {
+	struct work_struct iowork;
+	struct list_head tx_head;
+	struct iowait *iow;
+};
+
+/**
+ * @list: used to add/insert into QP/PQ wait lists
+ * @tx_head: overflow list of sdma_txreq's
+ * @sleep: no space callback
+ * @wakeup: space callback wakeup
+ * @sdma_drained: sdma count drained
+ * @init_priority: callback to manipulate priority
+ * @lock: lock protected head of wait queue
+ * @iowork: workqueue overhead
+ * @wait_dma: wait for sdma_busy == 0
+ * @wait_pio: wait for pio_busy == 0
+ * @sdma_busy: # of packets in flight
+ * @count: total number of descriptors in tx_head'ed list
+ * @tx_limit: limit for overflow queuing
+ * @tx_count: number of tx entry's in tx_head'ed list
+ * @flags: wait flags (one per QP)
+ * @wait: SE array for multiple legs
+ *
+ * This is to be embedded in user's state structure
+ * (QP or PQ).
+ *
+ * The sleep and wakeup members are a
+ * bit misnamed.   They do not strictly
+ * speaking sleep or wake up, but they
+ * are callbacks for the ULP to implement
+ * what ever queuing/dequeuing of
+ * the embedded iowait and its containing struct
+ * when a resource shortage like SDMA ring space
+ * or PIO credit space is seen.
+ *
+ * Both potentially have locks help
+ * so sleeping is not allowed and it is not
+ * supported to submit txreqs from the wakeup
+ * call directly because of lock conflicts.
+ *
+ * The wait_dma member along with the iow
+ *
+ * The lock field is used by waiters to record
+ * the seqlock_t that guards the list head.
+ * Waiters explicitly know that, but the destroy
+ * code that unwaits QPs does not.
+ */
+struct iowait {
+	struct list_head list;
+	int (*sleep)(
+		struct sdma_engine *sde,
+		struct iowait_work *wait,
+		struct sdma_txreq *tx,
+		uint seq,
+		bool pkts_sent
+		);
+	void (*wakeup)(struct iowait *wait, int reason);
+	void (*sdma_drained)(struct iowait *wait);
+	void (*init_priority)(struct iowait *wait);
+	seqlock_t *lock;
+	wait_queue_head_t wait_dma;
+	wait_queue_head_t wait_pio;
+	atomic_t sdma_busy;
+	atomic_t pio_busy;
+	u32 count;
+	u32 tx_limit;
+	u32 tx_count;
+	u8 starved_cnt;
+	u8 priority;
+	unsigned long flags;
+	struct iowait_work wait[IOWAIT_SES];
+};
+
+#define SDMA_AVAIL_REASON 0
+
+void iowait_set_flag(struct iowait *wait, u32 flag);
+bool iowait_flag_set(struct iowait *wait, u32 flag);
+void iowait_clear_flag(struct iowait *wait, u32 flag);
+
+void iowait_init(struct iowait *wait, u32 tx_limit,
+		 void (*func)(struct work_struct *work),
+		 void (*tidfunc)(struct work_struct *work),
+		 int (*sleep)(struct sdma_engine *sde,
+			      struct iowait_work *wait,
+			      struct sdma_txreq *tx,
+			      uint seq,
+			      bool pkts_sent),
+		 void (*wakeup)(struct iowait *wait, int reason),
+		 void (*sdma_drained)(struct iowait *wait),
+		 void (*init_priority)(struct iowait *wait));
+
+/**
+ * iowait_schedule() - schedule the default send engine work
+ * @wait: wait struct to schedule
+ * @wq: workqueue for schedule
+ * @cpu: cpu
+ */
+static inline bool iowait_schedule(struct iowait *wait,
+				   struct workqueue_struct *wq, int cpu)
+{
+	return !!queue_work_on(cpu, wq, &wait->wait[IOWAIT_IB_SE].iowork);
+}
+
+/**
+ * iowait_tid_schedule - schedule the tid SE
+ * @wait: the iowait structure
+ * @wq: the work queue
+ * @cpu: the cpu
+ */
+static inline bool iowait_tid_schedule(struct iowait *wait,
+				       struct workqueue_struct *wq, int cpu)
+{
+	return !!queue_work_on(cpu, wq, &wait->wait[IOWAIT_TID_SE].iowork);
+}
+
+/**
+ * iowait_sdma_drain() - wait for DMAs to drain
+ *
+ * @wait: iowait structure
+ *
+ * This will delay until the iowait sdmas have
+ * completed.
+ */
+static inline void iowait_sdma_drain(struct iowait *wait)
+{
+	wait_event(wait->wait_dma, !atomic_read(&wait->sdma_busy));
+}
+
+/**
+ * iowait_sdma_pending() - return sdma pending count
+ *
+ * @wait: iowait structure
+ *
+ */
+static inline int iowait_sdma_pending(struct iowait *wait)
+{
+	return atomic_read(&wait->sdma_busy);
+}
+
+/**
+ * iowait_sdma_inc - note sdma io pending
+ * @wait: iowait structure
+ */
+static inline void iowait_sdma_inc(struct iowait *wait)
+{
+	atomic_inc(&wait->sdma_busy);
+}
+
+/**
+ * iowait_sdma_add - add count to pending
+ * @wait: iowait structure
+ */
+static inline void iowait_sdma_add(struct iowait *wait, int count)
+{
+	atomic_add(count, &wait->sdma_busy);
+}
+
+/**
+ * iowait_sdma_dec - note sdma complete
+ * @wait: iowait structure
+ */
+static inline int iowait_sdma_dec(struct iowait *wait)
+{
+	if (!wait)
+		return 0;
+	return atomic_dec_and_test(&wait->sdma_busy);
+}
+
+/**
+ * iowait_pio_drain() - wait for pios to drain
+ *
+ * @wait: iowait structure
+ *
+ * This will delay until the iowait pios have
+ * completed.
+ */
+static inline void iowait_pio_drain(struct iowait *wait)
+{
+	wait_event_timeout(wait->wait_pio,
+			   !atomic_read(&wait->pio_busy),
+			   HZ);
+}
+
+/**
+ * iowait_pio_pending() - return pio pending count
+ *
+ * @wait: iowait structure
+ *
+ */
+static inline int iowait_pio_pending(struct iowait *wait)
+{
+	return atomic_read(&wait->pio_busy);
+}
+
+/**
+ * iowait_pio_inc - note pio pending
+ * @wait: iowait structure
+ */
+static inline void iowait_pio_inc(struct iowait *wait)
+{
+	atomic_inc(&wait->pio_busy);
+}
+
+/**
+ * iowait_pio_dec - note pio complete
+ * @wait: iowait structure
+ */
+static inline int iowait_pio_dec(struct iowait *wait)
+{
+	if (!wait)
+		return 0;
+	return atomic_dec_and_test(&wait->pio_busy);
+}
+
+/**
+ * iowait_drain_wakeup() - trigger iowait_drain() waiter
+ *
+ * @wait: iowait structure
+ *
+ * This will trigger any waiters.
+ */
+static inline void iowait_drain_wakeup(struct iowait *wait)
+{
+	wake_up(&wait->wait_dma);
+	wake_up(&wait->wait_pio);
+	if (wait->sdma_drained)
+		wait->sdma_drained(wait);
+}
+
+/**
+ * iowait_get_txhead() - get packet off of iowait list
+ *
+ * @wait: iowait_work structure
+ */
+static inline struct sdma_txreq *iowait_get_txhead(struct iowait_work *wait)
+{
+	struct sdma_txreq *tx = NULL;
+
+	if (!list_empty(&wait->tx_head)) {
+		tx = list_first_entry(
+			&wait->tx_head,
+			struct sdma_txreq,
+			list);
+		list_del_init(&tx->list);
+	}
+	return tx;
+}
+
+static inline u16 iowait_get_desc(struct iowait_work *w)
+{
+	u16 num_desc = 0;
+	struct sdma_txreq *tx = NULL;
+
+	if (!list_empty(&w->tx_head)) {
+		tx = list_first_entry(&w->tx_head, struct sdma_txreq,
+				      list);
+		num_desc = tx->num_desc;
+		if (tx->flags & SDMA_TXREQ_F_VIP)
+			w->iow->priority++;
+	}
+	return num_desc;
+}
+
+static inline u32 iowait_get_all_desc(struct iowait *w)
+{
+	u32 num_desc = 0;
+
+	num_desc = iowait_get_desc(&w->wait[IOWAIT_IB_SE]);
+	num_desc += iowait_get_desc(&w->wait[IOWAIT_TID_SE]);
+	return num_desc;
+}
+
+static inline void iowait_update_priority(struct iowait_work *w)
+{
+	struct sdma_txreq *tx = NULL;
+
+	if (!list_empty(&w->tx_head)) {
+		tx = list_first_entry(&w->tx_head, struct sdma_txreq,
+				      list);
+		if (tx->flags & SDMA_TXREQ_F_VIP)
+			w->iow->priority++;
+	}
+}
+
+static inline void iowait_update_all_priority(struct iowait *w)
+{
+	iowait_update_priority(&w->wait[IOWAIT_IB_SE]);
+	iowait_update_priority(&w->wait[IOWAIT_TID_SE]);
+}
+
+static inline void iowait_init_priority(struct iowait *w)
+{
+	w->priority = 0;
+	if (w->init_priority)
+		w->init_priority(w);
+}
+
+static inline void iowait_get_priority(struct iowait *w)
+{
+	iowait_init_priority(w);
+	iowait_update_all_priority(w);
+}
+
+/**
+ * iowait_queue - Put the iowait on a wait queue
+ * @pkts_sent: have some packets been sent before queuing?
+ * @w: the iowait struct
+ * @wait_head: the wait queue
+ *
+ * This function is called to insert an iowait struct into a
+ * wait queue after a resource (eg, sdma descriptor or pio
+ * buffer) is run out.
+ */
+static inline void iowait_queue(bool pkts_sent, struct iowait *w,
+				struct list_head *wait_head)
+{
+	/*
+	 * To play fair, insert the iowait at the tail of the wait queue if it
+	 * has already sent some packets; Otherwise, put it at the head.
+	 * However, if it has priority packets to send, also put it at the
+	 * head.
+	 */
+	if (pkts_sent)
+		w->starved_cnt = 0;
+	else
+		w->starved_cnt++;
+
+	if (w->priority > 0 || !pkts_sent)
+		list_add(&w->list, wait_head);
+	else
+		list_add_tail(&w->list, wait_head);
+}
+
+/**
+ * iowait_starve_clear - clear the wait queue's starve count
+ * @pkts_sent: have some packets been sent?
+ * @w: the iowait struct
+ *
+ * This function is called to clear the starve count. If no
+ * packets have been sent, the starve count will not be cleared.
+ */
+static inline void iowait_starve_clear(bool pkts_sent, struct iowait *w)
+{
+	if (pkts_sent)
+		w->starved_cnt = 0;
+}
+
+/* Update the top priority index */
+uint iowait_priority_update_top(struct iowait *w,
+				struct iowait *top,
+				uint idx, uint top_idx);
+
+/**
+ * iowait_packet_queued() - determine if a packet is queued
+ * @wait: the iowait_work structure
+ */
+static inline bool iowait_packet_queued(struct iowait_work *wait)
+{
+	return !list_empty(&wait->tx_head);
+}
+
+/**
+ * inc_wait_count - increment wait counts
+ * @w: the log work struct
+ * @n: the count
+ */
+static inline void iowait_inc_wait_count(struct iowait_work *w, u16 n)
+{
+	if (!w)
+		return;
+	w->iow->tx_count++;
+	w->iow->count += n;
+}
+
+/**
+ * iowait_get_tid_work - return iowait_work for tid SE
+ * @w: the iowait struct
+ */
+static inline struct iowait_work *iowait_get_tid_work(struct iowait *w)
+{
+	return &w->wait[IOWAIT_TID_SE];
+}
+
+/**
+ * iowait_get_ib_work - return iowait_work for ib SE
+ * @w: the iowait struct
+ */
+static inline struct iowait_work *iowait_get_ib_work(struct iowait *w)
+{
+	return &w->wait[IOWAIT_IB_SE];
+}
+
+/**
+ * iowait_ioww_to_iow - return iowait given iowait_work
+ * @w: the iowait_work struct
+ */
+static inline struct iowait *iowait_ioww_to_iow(struct iowait_work *w)
+{
+	if (likely(w))
+		return w->iow;
+	return NULL;
+}
+
+void iowait_cancel_work(struct iowait *w);
+int iowait_set_work_flag(struct iowait_work *w);
+
+#endif
diff --git a/drivers/infiniband/hw/hfi2/ipoib.h b/drivers/infiniband/hw/hfi2/ipoib.h
new file mode 100644
index 000000000000..ad62b223fa9b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ipoib.h
@@ -0,0 +1,172 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ *
+ */
+
+/*
+ * This file contains HFI2 support for IPOIB functionality
+ */
+
+#ifndef HFI2_IPOIB_H
+#define HFI2_IPOIB_H
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <linux/atomic.h>
+#include <linux/netdevice.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/list.h>
+#include <linux/if_infiniband.h>
+
+#include "hfi2.h"
+#include "iowait.h"
+#include "netdev.h"
+
+#include <rdma/ib_verbs.h>
+
+#define HFI2_IPOIB_ENTROPY_SHIFT   24
+
+#define HFI2_IPOIB_TXREQ_NAME_LEN   32
+
+#define HFI2_IPOIB_PSEUDO_LEN 20
+#define HFI2_IPOIB_ENCAP_LEN 4
+
+struct hfi2_ipoib_dev_priv;
+
+union hfi2_ipoib_flow {
+	u16 as_int;
+	struct {
+		u8 tx_queue;
+		u8 sc5;
+	} __attribute__((__packed__));
+};
+
+/**
+ * struct ipoib_txreq - IPOIB transmit descriptor
+ * @txreq: sdma transmit request
+ * @sdma_hdr: 9b ib headers
+ * @sdma_status: status returned by sdma engine
+ * @complete: non-zero implies complete
+ * @priv: ipoib netdev private data
+ * @txq: txq on which skb was output
+ * @skb: skb to send
+ */
+struct ipoib_txreq {
+	struct sdma_txreq           txreq;
+	struct hfi2_sdma_header     *sdma_hdr;
+	int                         sdma_status;
+	int                         complete;
+	struct hfi2_ipoib_dev_priv *priv;
+	struct hfi2_ipoib_txq      *txq;
+	struct sk_buff             *skb;
+};
+
+/**
+ * struct hfi2_ipoib_circ_buf - List of items to be processed
+ * @items: ring of items each a power of two size
+ * @max_items: max items + 1 that the ring can contain
+ * @shift: log2 of size for getting txreq
+ * @sent_txreqs: count of txreqs posted to sdma
+ * @tail: ring tail
+ * @stops: count of stops of queue
+ * @ring_full: ring has been filled
+ * @no_desc: descriptor shortage seen
+ * @complete_txreqs: count of txreqs completed by sdma
+ * @head: ring head
+ */
+struct hfi2_ipoib_circ_buf {
+	void *items;
+	u32 max_items;
+	u32 shift;
+	/* consumer cache line */
+	u64 ____cacheline_aligned_in_smp sent_txreqs;
+	u32 avail;
+	u32 tail;
+	atomic_t stops;
+	atomic_t ring_full;
+	atomic_t no_desc;
+	/* producer cache line */
+	u64 ____cacheline_aligned_in_smp complete_txreqs;
+	u32 head;
+};
+
+/**
+ * struct hfi2_ipoib_txq - IPOIB per Tx queue information
+ * @priv: private pointer
+ * @sde: sdma engine
+ * @tx_list: tx request list
+ * @sent_txreqs: count of txreqs posted to sdma
+ * @flow: tracks when list needs to be flushed for a flow change
+ * @q_idx: ipoib Tx queue index
+ * @pkts_sent: indicator packets have been sent from this queue
+ * @wait: iowait structure
+ * @napi: pointer to tx napi interface
+ * @tx_ring: ring of ipoib txreqs to be reaped by napi callback
+ */
+struct hfi2_ipoib_txq {
+	struct napi_struct napi;
+	struct hfi2_ipoib_dev_priv *priv;
+	struct sdma_engine *sde;
+	struct list_head tx_list;
+	union hfi2_ipoib_flow flow;
+	u8 q_idx;
+	bool pkts_sent;
+	struct iowait wait;
+
+	struct hfi2_ipoib_circ_buf ____cacheline_aligned_in_smp tx_ring;
+};
+
+struct hfi2_ipoib_dev_priv {
+	struct hfi2_devdata *dd;
+	struct hfi2_pportdata *ppd;
+	struct net_device   *netdev;
+	struct ib_device    *device;
+	struct hfi2_ipoib_txq *txqs;
+	const struct net_device_ops *netdev_ops;
+	struct rvt_qp *qp;
+	u32 qkey;
+	u16 pkey;
+	u16 pkey_index;
+	u8 port_num;
+};
+
+/* hfi2 ipoib rdma netdev's private data structure */
+struct hfi2_ipoib_rdma_netdev {
+	struct rdma_netdev rn;  /* keep this first */
+	/* followed by device private data */
+	struct hfi2_ipoib_dev_priv dev_priv;
+};
+
+static inline struct hfi2_ipoib_dev_priv *
+hfi2_ipoib_priv(const struct net_device *dev)
+{
+	return &((struct hfi2_ipoib_rdma_netdev *)netdev_priv(dev))->dev_priv;
+}
+
+int hfi2_ipoib_send(struct net_device *dev,
+		    struct sk_buff *skb,
+		    struct ib_ah *address,
+		    u32 dqpn);
+
+int hfi2_ipoib_txreq_init(struct hfi2_ipoib_dev_priv *priv);
+void hfi2_ipoib_txreq_deinit(struct hfi2_ipoib_dev_priv *priv);
+
+int hfi2_ipoib_rxq_init(struct net_device *dev);
+void hfi2_ipoib_rxq_deinit(struct net_device *dev);
+
+void hfi2_ipoib_napi_tx_enable(struct net_device *dev);
+void hfi2_ipoib_napi_tx_disable(struct net_device *dev);
+
+struct sk_buff *hfi2_ipoib_prepare_skb(struct hfi2_netdev_rxq *rxq,
+				       int size, void *data);
+
+int hfi2_ipoib_rn_get_params(struct ib_device *device,
+			     u32 port_num,
+			     enum rdma_netdev_t type,
+			     struct rdma_netdev_alloc_params *params);
+
+void hfi2_ipoib_tx_timeout(struct net_device *dev, unsigned int q);
+
+#endif /* _IPOIB_H */
diff --git a/drivers/infiniband/hw/hfi2/netdev.h b/drivers/infiniband/hw/hfi2/netdev.h
new file mode 100644
index 000000000000..f5b698eafa5c
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/netdev.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2020 Intel Corporation.
+ *
+ */
+
+#ifndef HFI2_NETDEV_H
+#define HFI2_NETDEV_H
+
+#include "hfi2.h"
+
+#include <linux/netdevice.h>
+#include <linux/xarray.h>
+
+/**
+ * struct hfi2_netdev_rxq - Receive Queue for HFI
+ * IPoIB netdevices will be working on the rx abstraction.
+ * @napi: napi object
+ * @rx: ptr to netdev_rx
+ * @rcd:  ptr to receive context data
+ */
+struct hfi2_netdev_rxq {
+	struct napi_struct napi;
+	struct hfi2_netdev_rx *rx;
+	struct hfi2_ctxtdata *rcd;
+};
+
+/*
+ * Number of netdev contexts used. Ensure it is less than or equal to
+ * max queues supported.
+ */
+#define HFI2_MAX_NETDEV_CTXTS   8
+
+/* Number of NETDEV RSM entries */
+#define NUM_NETDEV_MAP_ENTRIES HFI2_MAX_NETDEV_CTXTS
+
+/**
+ * struct hfi2_netdev_rx: data required to setup and run HFI netdev.
+ * @rx_napi:	the dummy netdevice to support "polling" the receive contexts
+ * @dd:		hfi2_devdata
+ * @ppd:	hfi2_pportdata
+ * @rxq:	pointer to dummy netdev receive queues.
+ * @num_rx_q:	number of receive queues
+ * @rmt_start:	first allocated index in the RMT
+ * @dev_tbl:	netdev table for unique identifier IPoIb VLANs.
+ * @enabled:	atomic counter of netdevs enabling receive queues.
+ *		When 0 NAPI will be disabled.
+ * @netdevs:	count of netdev_rx users, protected by hfi2_mutex.
+ *		When 0 receive queues will be freed.
+ */
+struct hfi2_netdev_rx {
+	struct net_device *rx_napi;
+	struct hfi2_devdata *dd;
+	struct hfi2_pportdata *ppd;
+	struct hfi2_netdev_rxq *rxq;
+	int num_rx_q;
+	int rmt_start;
+	struct xarray dev_tbl;
+	/* count of enabled napi polls */
+	atomic_t enabled;
+	int netdevs;
+};
+
+static inline
+int hfi2_netdev_ctxt_count(struct hfi2_pportdata *ppd)
+{
+	return ppd->netdev_rx->num_rx_q;
+}
+
+static inline
+struct hfi2_ctxtdata *hfi2_netdev_get_ctxt(struct hfi2_pportdata *ppd, int ctxt)
+{
+	return ppd->netdev_rx->rxq[ctxt].rcd;
+}
+
+static inline
+int hfi2_netdev_get_free_rmt_idx(struct hfi2_pportdata *ppd)
+{
+	return ppd->netdev_rx->rmt_start;
+}
+
+u32 hfi2_num_netdev_contexts(struct hfi2_devdata *dd, u32 available_contexts,
+			     struct cpumask *cpu_mask);
+
+void hfi2_netdev_enable_queues(struct hfi2_pportdata *ppd);
+void hfi2_netdev_disable_queues(struct hfi2_pportdata *ppd);
+int hfi2_netdev_rx_init(struct hfi2_pportdata *ppd);
+int hfi2_netdev_rx_destroy(struct hfi2_pportdata *ppd);
+int hfi2_alloc_rx(struct hfi2_devdata *dd);
+void hfi2_free_rx(struct hfi2_devdata *dd);
+int hfi2_netdev_add_data(struct hfi2_pportdata *ppd, int id, void *data);
+void *hfi2_netdev_remove_data(struct hfi2_pportdata *ppd, int id);
+void *hfi2_netdev_get_data(struct hfi2_pportdata *ppd, int id);
+void *hfi2_netdev_get_first_data(struct hfi2_pportdata *ppd, int *start_id);
+
+/* chip.c  */
+int hfi2_netdev_rx_napi(struct napi_struct *napi, int budget);
+
+#endif /* HFI2_NETDEV_H */
diff --git a/drivers/infiniband/hw/hfi2/pinning.h b/drivers/infiniband/hw/hfi2/pinning.h
new file mode 100644
index 000000000000..f924cc2d67ad
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pinning.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023 Cornelis Networks, Inc.
+ */
+#ifndef _HFI2_PINNING_H
+#define _HFI2_PINNING_H
+
+#include <rdma/hfi2-abi.h>
+
+struct hfi2_user_sdma_pkt_q;
+struct user_sdma_request;
+struct user_sdma_txreq;
+struct user_sdma_iovec;
+
+struct pinning_interface {
+	int (*init)(struct hfi2_user_sdma_pkt_q *pq);
+	void (*free)(struct hfi2_user_sdma_pkt_q *pq);
+
+	/*
+	 * Add up to pkt_data_remaining bytes to the txreq, starting at the
+	 * current offset in the given iovec entry and continuing until all
+	 * data has been added to the iovec or the iovec entry type changes.
+	 * On success, prior to returning, the implementation must adjust
+	 * pkt_data_remaining, req->iov_idx, and the offset value in
+	 * req->iov[req->iov_idx] to reflect the data that has been
+	 * consumed.
+	 */
+	int (*add_to_sdma_packet)(struct user_sdma_request *req,
+				  struct user_sdma_txreq *tx,
+				  struct user_sdma_iovec *iovec,
+				  u32 *pkt_data_remaining);
+
+	int (*get_stats)(struct hfi2_user_sdma_pkt_q *pq, int index,
+			 struct hfi2_pin_stats *stats);
+	void (*put)(void *ptr);
+};
+
+#define PINNING_MAX_INTERFACES BIT(HFI2_MEMINFO_TYPE_ENTRY_BITS)
+
+struct pinning_state {
+	void *interface[PINNING_MAX_INTERFACES];
+};
+
+#define PINNING_STATE(pq, i) ((pq)->pinning_state.interface[(i)])
+
+extern struct pinning_interface pinning_interfaces[PINNING_MAX_INTERFACES];
+
+void register_pinning_interface(unsigned int type,
+				struct pinning_interface *interface);
+void deregister_pinning_interface(unsigned int type);
+
+void register_system_pinning_interface(void);
+void deregister_system_pinning_interface(void);
+
+int init_pinning_interfaces(struct hfi2_user_sdma_pkt_q *pq);
+void free_pinning_interfaces(struct hfi2_user_sdma_pkt_q *pq);
+
+static inline bool pinning_type_supported(unsigned int type)
+{
+	return (type < PINNING_MAX_INTERFACES &&
+		pinning_interfaces[type].add_to_sdma_packet);
+}
+
+static inline int add_to_sdma_packet(unsigned int type,
+				     struct user_sdma_request *req,
+				     struct user_sdma_txreq *tx,
+				     struct user_sdma_iovec *iovec,
+				     u32 *rem)
+{
+	return pinning_interfaces[type].add_to_sdma_packet(req, tx, iovec,
+							   rem);
+}
+
+#endif /* _HFI2_PINNING_H */
diff --git a/drivers/infiniband/hw/hfi2/pio.h b/drivers/infiniband/hw/hfi2/pio.h
new file mode 100644
index 000000000000..43636e02ffee
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pio.h
@@ -0,0 +1,305 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015-2017 Intel Corporation.
+ */
+
+#ifndef _PIO_H
+#define _PIO_H
+/* send context types */
+#define SC_KERNEL 0
+#define SC_VL15   1
+#define SC_ACK    2
+#define SC_USER   3	/* must be the last one: it may take all left */
+#define SC_MAX    4	/* count of send context types */
+
+/* invalid send context index */
+#define INVALID_SCI 0xff
+
+/* PIO buffer release callback function */
+typedef void (*pio_release_cb)(void *arg, int code);
+
+/* PIO release codes - in bits, as there could more than one that apply */
+#define PRC_OK		0	/* no known error */
+#define PRC_STATUS_ERR	0x01	/* credit return due to status error */
+#define PRC_PBC		0x02	/* credit return due to PBC */
+#define PRC_THRESHOLD	0x04	/* credit return due to threshold */
+#define PRC_FILL_ERR	0x08	/* credit return due fill error */
+#define PRC_FORCE	0x10	/* credit return due credit force */
+#define PRC_SC_DISABLE	0x20	/* clean-up after a context disable */
+
+/* byte helper */
+union mix {
+	u64 val64;
+	u32 val32[2];
+	u8  val8[8];
+};
+
+/* an allocated PIO buffer */
+struct pio_buf {
+	struct send_context *sc;/* back pointer to owning send context */
+	pio_release_cb cb;	/* called when the buffer is released */
+	void *arg;		/* argument for cb */
+	void __iomem *start;	/* buffer start address */
+	void __iomem *end;	/* context end address */
+	unsigned long sent_at;	/* buffer is sent when <= free */
+	union mix carry;	/* pending unwritten bytes */
+	u16 qw_written;		/* QW written so far */
+	u8 carry_bytes;	/* number of valid bytes in carry */
+};
+
+/* cache line aligned pio buffer array */
+union pio_shadow_ring {
+	struct pio_buf pbuf;
+} ____cacheline_aligned;
+
+/* per-NUMA send context */
+struct send_context {
+	/* read-only after init */
+	struct hfi2_devdata *dd;	/* device */
+	struct hfi2_pportdata *ppd;	/* port */
+	union pio_shadow_ring *sr;	/* shadow ring */
+	void __iomem *base_addr;	/* start of PIO memory */
+	u32 __percpu *buffers_allocated;/* count of buffers allocated */
+	u32 size;			/* context size, in bytes */
+
+	int node;			/* context home node */
+	u32 sr_size;			/* size of the shadow ring */
+	u16 flags;			/* flags */
+	u16 sw_index;			/* software index number */
+	u16 hw_context;			/* hardware context number */
+	u8  type;			/* context type */
+	u8  group;			/* credit return group */
+
+	/* allocator fields */
+	spinlock_t alloc_lock ____cacheline_aligned_in_smp;
+	u32 sr_head;			/* shadow ring head */
+	unsigned long fill;		/* official alloc count */
+	unsigned long alloc_free;	/* copy of free (less cache thrash) */
+	u32 fill_wrap;			/* tracks fill within ring */
+	u32 credits;			/* number of blocks in context */
+	/* adding a new field here would make it part of this cacheline */
+
+	/* releaser fields */
+	spinlock_t release_lock ____cacheline_aligned_in_smp;
+	u32 sr_tail;			/* shadow ring tail */
+	unsigned long free;		/* official free count */
+	volatile __le64 *hw_free;	/* HW free counter */
+	/* list for PIO waiters */
+	struct list_head piowait  ____cacheline_aligned_in_smp;
+	seqlock_t waitlock;
+
+	spinlock_t credit_ctrl_lock ____cacheline_aligned_in_smp;
+	u32 credit_intr_count;		/* count of credit intr users */
+	u64 credit_ctrl;		/* cache for credit control */
+	wait_queue_head_t halt_wait;    /* wait until kernel sees interrupt */
+	struct work_struct halt_work;	/* halted context work queue entry */
+};
+
+/* send context flags */
+#define SCF_ENABLED 0x01
+#define SCF_IN_FREE 0x02
+#define SCF_HALTED  0x04
+#define SCF_FROZEN  0x08
+#define SCF_LINK_DOWN 0x10
+
+struct send_context_info {
+	struct send_context *sc;	/* allocated working context */
+	u16 allocated;			/* has this been allocated? */
+	u16 type;			/* context type */
+	u16 base;			/* base in PIO array */
+	u16 credits;			/* size in PIO array */
+};
+
+/* DMA credit return, index is always (context & 0x7) */
+struct credit_return {
+	volatile __le64 cr[8];
+};
+
+/* NUMA indexed credit return array */
+struct credit_return_base {
+	struct credit_return *va;
+	dma_addr_t dma;
+};
+
+/* send context configuration sizes (one per type) */
+struct sc_config_sizes {
+	short int size;
+	short int count;
+};
+
+/*
+ * The diagram below details layout of pio_map, which is used to quickly select
+ * a kernel send context given a vl and a selector (fuzz).
+ *
+ * sc = pio_map->map[vl & map_mask]->ksc[selector & elem_mask]
+ *
+ * The map allows for non-uniform send contexts per vl.
+ *
+ * Where:
+ * nactual = num_kernel_send_contexts / num_vls
+ * vl_scontexts[vl] = nactual + extra
+ *
+ *	Extra is an evenly distributed modulo of remaining send contexts.
+ *
+ * svl[vl] = 1 + sum vl_scontexts[0..vl-1]
+ *
+ * n = roundup to next highest power of 2 of vl_scontexts[vl]
+ *
+ * When n > vl_scontexts[vl], the send contexts are assigned in a round robin
+ * fashion wrapping back to the first send context for a particular vl.
+ *
+ *              ppd->pio_map
+ *                    |                                  pio_map_elem[0]
+ *                    |                               +------------------------+
+ *                    v                               |       mask             |
+ *               pio_vl_map                           |------------------------|
+ *      +--------------------------+                  | ksc[0] -> svl[0]       |
+ *      |    list (RCU)            |                  |------------------------|
+ *      |--------------------------|                ->| ksc[1] -> svl[0]+1     |
+ *      |    mask                  |              -/  |------------------------|
+ *      |--------------------------|            -/    |        *               |
+ *      |    actual_vls (max 8)    |          -/      |------------------------|
+ *      |--------------------------|       --/        | ksc[n-1] -> svl[0]+n-1 |
+ *      |    vls (max 8)           |     -/           +------------------------+
+ *      |--------------------------|  --/
+ *      |    map[0]                |-/
+ *      |--------------------------|                  +------------------------+
+ *      |    map[1]                |---               |       mask             |
+ *      |--------------------------|   \----          |------------------------|
+ *      |           *              |        \--       | ksc[0] -> svl[1]       |
+ *      |           *              |           \---   |------------------------|
+ *      |           *              |               \->| ksc[1] -> svl[1]+1     |
+ *      |--------------------------|                  |------------------------|
+ *      |   map[vls - 1]           |-                 |         *              |
+ *      +--------------------------+ \-               |------------------------|
+ *                                     \-             | ksc[n-1] -> svl[1]+n-1 |
+ *                                       \            +------------------------+
+ *                                        \-
+ *                                          \
+ *                                           \-       +------------------------+
+ *                                             \-     |       mask             |
+ *                                               \    |------------------------|
+ *                                                \-  | ksc[x] -> svl[x]       |
+ *                                                  \ |------------------------|
+ *                                                   >| ksc[x] -> svl[x]+1     |
+ *                                                    |------------------------|
+ *                                                    |         *              |
+ *                                                    |------------------------|
+ *                                                    | ksc[n-1] -> svl[x]+n-1 |
+ *                                                    +------------------------+
+ *
+ */
+
+/* Initial number of send contexts per VL */
+#define INIT_SC_PER_VL 2
+
+/*
+ * struct pio_map_elem - mapping for a vl
+ * @mask - selector mask
+ * @ksc - array of kernel send contexts for this vl
+ *
+ * The mask is used to "mod" the selector to
+ * produce index into the trailing array of
+ * kscs
+ */
+struct pio_map_elem {
+	u32 mask;
+	struct send_context *ksc[];
+};
+
+/*
+ * struct pio_vl_map - mapping for a vl
+ * @list - rcu head for free callback
+ * @mask - vl mask to "mod" the vl to produce an index to map array
+ * @actual_vls - number of vls
+ * @vls - numbers of vls rounded to next power of 2
+ * @map - array of pio_map_elem entries
+ *
+ * This is the parent mapping structure. The trailing members of the
+ * struct point to pio_map_elem entries, which in turn point to an
+ * array of kscs for that vl.
+ */
+struct pio_vl_map {
+	struct rcu_head list;
+	u32 mask;
+	u8 actual_vls;
+	u8 vls;
+	struct pio_map_elem *map[];
+};
+
+int pio_map_init(struct hfi2_pportdata *ppd, u8 num_vls);
+void free_pio_map(struct hfi2_devdata *dd);
+struct send_context *pio_select_send_context_vl(struct hfi2_pportdata *ppd,
+						u32 selector, u8 vl);
+struct send_context *pio_select_send_context_sc(struct hfi2_pportdata *ppd,
+						u32 selector, u8 sc5);
+
+/* send context functions */
+int init_credit_return(struct hfi2_devdata *dd);
+void free_credit_return(struct hfi2_devdata *dd);
+int init_sc_pools_and_sizes(struct hfi2_devdata *dd);
+int init_send_contexts(struct hfi2_devdata *dd);
+int init_pervl_scs(struct hfi2_pportdata *ppd);
+struct send_context *sc_alloc(struct hfi2_pportdata *ppd, int type,
+			      uint hdrqentsize, int numa);
+void sc_free(struct send_context *sc);
+int sc_enable(struct send_context *sc);
+void sc_disable(struct send_context *sc);
+int sc_restart(struct send_context *sc);
+void sc_return_credits(struct send_context *sc);
+void sc_flush(struct send_context *sc);
+void sc_drop(struct send_context *sc);
+void sc_stop(struct send_context *sc, int bit);
+struct pio_buf *sc_buffer_alloc(struct send_context *sc, u32 dw_len,
+				pio_release_cb cb, void *arg);
+void sc_release_update(struct send_context *sc);
+void sc_group_release_update(struct hfi2_devdata *dd, u32 hw_context);
+void sc_add_credit_return_intr(struct send_context *sc);
+void sc_del_credit_return_intr(struct send_context *sc);
+void sc_set_cr_threshold(struct send_context *sc, u32 new_threshold);
+u32 sc_percent_to_threshold(struct send_context *sc, u32 percent);
+u32 sc_mtu_to_threshold(struct send_context *sc, u32 mtu, u32 hdrqentsize);
+void hfi2_sc_wantpiobuf_intr(struct send_context *sc, u32 needint);
+void sc_wait(struct hfi2_devdata *dd);
+
+/* commands for set_pio_integrity() */
+enum spi_cmds {
+	SPI_DEFAULT,
+	SPI_INIT,
+	SPI_SET_JKEY,
+	SPI_CLEAR_JKEY,
+	SPI_SET_PKEY,
+	SPI_CLEAR_PKEY,
+};
+void wfr_set_pio_integrity(struct send_context *sc, enum spi_cmds cmd);
+
+/* support functions */
+void pio_reset_all(struct hfi2_devdata *dd);
+void pio_freeze(struct hfi2_devdata *dd);
+void pio_kernel_unfreeze(struct hfi2_devdata *dd);
+void pio_kernel_linkup(struct hfi2_pportdata *ppd);
+
+/* global PIO send control operations */
+#define PSC_GLOBAL_ENABLE 0
+#define PSC_GLOBAL_DISABLE 1
+#define PSC_GLOBAL_VLARB_ENABLE 2
+#define PSC_GLOBAL_VLARB_DISABLE 3
+#define PSC_CM_RESET 4
+#define PSC_DATA_VL_ENABLE 5
+#define PSC_DATA_VL_DISABLE 6
+
+void __cm_reset(struct hfi2_pportdata *ppd, u64 sendctrl);
+void pio_send_control(struct hfi2_pportdata *ppd, int op);
+
+/* PIO copy routines */
+void pio_copy(struct hfi2_devdata *dd, struct pio_buf *pbuf, u64 pbc,
+	      const void *from, size_t count);
+void seg_pio_copy_start(struct pio_buf *pbuf, u64 pbc,
+			const void *from, size_t nbytes);
+void seg_pio_copy_mid(struct pio_buf *pbuf, const void *from, size_t nbytes);
+void seg_pio_copy_end(struct pio_buf *pbuf);
+
+void seqfile_dump_sci(struct seq_file *s, u32 i,
+		      struct send_context_info *sci);
+
+#endif /* _PIO_H */
diff --git a/drivers/infiniband/hw/hfi2/qp.h b/drivers/infiniband/hw/hfi2/qp.h
new file mode 100644
index 000000000000..5e5b275e4e64
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/qp.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#ifndef _QP_H
+#define _QP_H
+#include <linux/hash.h>
+#include <rdma/rdmavt_qp.h>
+#include "verbs.h"
+#include "sdma.h"
+#include "verbs_txreq.h"
+
+extern unsigned int hfi2_qp_table_size;
+
+extern const struct rvt_operation_params hfi2_post_parms[];
+
+/*
+ * Driver specific s_flags starting at bit 31 down to HFI2_S_MIN_BIT_MASK
+ *
+ * HFI2_S_AHG_VALID - ahg header valid on chip
+ * HFI2_S_AHG_CLEAR - have send engine clear ahg state
+ * HFI2_S_WAIT_PIO_DRAIN - qp waiting for PIOs to drain
+ * HFI2_S_WAIT_TID_SPACE - a QP is waiting for TID resource
+ * HFI2_S_WAIT_TID_RESP - waiting for a TID RDMA WRITE response
+ * HFI2_S_WAIT_HALT - halt the first leg send engine
+ * HFI2_S_MIN_BIT_MASK - the lowest bit that can be used by hfi2
+ */
+#define HFI2_S_AHG_VALID         0x80000000
+#define HFI2_S_AHG_CLEAR         0x40000000
+#define HFI2_S_WAIT_PIO_DRAIN    0x20000000
+#define HFI2_S_WAIT_TID_SPACE    0x10000000
+#define HFI2_S_WAIT_TID_RESP     0x08000000
+#define HFI2_S_WAIT_HALT         0x04000000
+#define HFI2_S_MIN_BIT_MASK      0x01000000
+
+/*
+ * overload wait defines
+ */
+
+#define HFI2_S_ANY_WAIT_IO (RVT_S_ANY_WAIT_IO | HFI2_S_WAIT_PIO_DRAIN)
+#define HFI2_S_ANY_WAIT (HFI2_S_ANY_WAIT_IO | RVT_S_ANY_WAIT_SEND)
+#define HFI2_S_ANY_TID_WAIT_SEND (RVT_S_WAIT_SSN_CREDIT | RVT_S_WAIT_DMA)
+
+/*
+ * Send if not busy or waiting for I/O and either
+ * a RC response is pending or we can process send work requests.
+ */
+static inline int hfi2_send_ok(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	return !(qp->s_flags & (RVT_S_BUSY | HFI2_S_ANY_WAIT_IO)) &&
+		(verbs_txreq_queued(iowait_get_ib_work(&priv->s_iowait)) ||
+		(qp->s_flags & RVT_S_RESP_PENDING) ||
+		 !(qp->s_flags & RVT_S_ANY_WAIT_SEND));
+}
+
+/*
+ * free_ahg - clear ahg from QP
+ */
+static inline void clear_ahg(struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	priv->s_ahg->ahgcount = 0;
+	qp->s_flags &= ~(HFI2_S_AHG_VALID | HFI2_S_AHG_CLEAR);
+	if (priv->s_sde && qp->s_ahgidx >= 0)
+		sdma_ahg_free(priv->s_sde, qp->s_ahgidx);
+	qp->s_ahgidx = -1;
+}
+
+/**
+ * hfi2_qp_wakeup - wake up on the indicated event
+ * @qp: the QP
+ * @flag: flag the qp on which the qp is stalled
+ */
+void hfi2_qp_wakeup(struct rvt_qp *qp, u32 flag);
+
+struct sdma_engine *qp_to_sdma_engine(struct rvt_qp *qp, u8 sc5);
+struct send_context *qp_to_send_context(struct rvt_qp *qp, u8 sc5);
+
+void qp_iter_print(struct seq_file *s, struct rvt_qp_iter *iter);
+
+bool _hfi2_schedule_send(struct rvt_qp *qp);
+bool hfi2_schedule_send(struct rvt_qp *qp);
+
+void hfi2_migrate_qp(struct rvt_qp *qp);
+
+/*
+ * Functions provided by hfi2 driver for rdmavt to use
+ */
+void *qp_priv_alloc(struct rvt_dev_info *rdi, struct rvt_qp *qp);
+void qp_priv_free(struct rvt_dev_info *rdi, struct rvt_qp *qp);
+unsigned free_all_qps(struct rvt_dev_info *rdi);
+void notify_qp_reset(struct rvt_qp *qp);
+int get_pmtu_from_attr(struct rvt_dev_info *rdi, struct rvt_qp *qp,
+		       struct ib_qp_attr *attr);
+void flush_qp_waiters(struct rvt_qp *qp);
+void notify_error_qp(struct rvt_qp *qp);
+void stop_send_queue(struct rvt_qp *qp);
+void quiesce_qp(struct rvt_qp *qp);
+u32 mtu_from_qp(struct rvt_dev_info *rdi, struct rvt_qp *qp, u32 pmtu);
+int mtu_to_path_mtu(u32 mtu);
+void hfi2_error_port_qps(struct hfi2_ibport *ibp, u8 sl);
+void hfi2_qp_unbusy(struct rvt_qp *qp, struct iowait_work *wait);
+#endif /* _QP_H */
diff --git a/drivers/infiniband/hw/hfi2/rc.h b/drivers/infiniband/hw/hfi2/rc.h
new file mode 100644
index 000000000000..0291e36e5f57
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/rc.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ *
+ */
+
+#ifndef HFI2_RC_H
+#define HFI2_RC_H
+
+/* cut down ridiculously long IB macro names */
+#define OP(x) IB_OPCODE_RC_##x
+
+static inline void update_ack_queue(struct rvt_qp *qp, unsigned int n)
+{
+	unsigned int next;
+
+	next = n + 1;
+	if (next > rvt_size_atomic(ib_to_rvt(qp->ibqp.device)))
+		next = 0;
+	qp->s_tail_ack_queue = next;
+	qp->s_acked_ack_queue = next;
+	qp->s_ack_state = OP(ACKNOWLEDGE);
+}
+
+static inline void rc_defered_ack(struct hfi2_ctxtdata *rcd,
+				  struct rvt_qp *qp)
+{
+	if (list_empty(&qp->rspwait)) {
+		qp->r_flags |= RVT_R_RSP_NAK;
+		rvt_get_qp(qp);
+		list_add_tail(&qp->rspwait, &rcd->qp_wait_list);
+	}
+}
+
+static inline u32 restart_sge(struct rvt_sge_state *ss, struct rvt_swqe *wqe,
+			      u32 psn, u32 pmtu)
+{
+	u32 len;
+
+	len = delta_psn(psn, wqe->psn) * pmtu;
+	return rvt_restart_sge(ss, wqe, len);
+}
+
+static inline void release_rdma_sge_mr(struct rvt_ack_entry *e)
+{
+	if (e->rdma_sge.mr) {
+		rvt_put_mr(e->rdma_sge.mr);
+		e->rdma_sge.mr = NULL;
+	}
+}
+
+struct rvt_ack_entry *find_prev_entry(struct rvt_qp *qp, u32 psn, u8 *prev,
+				      u8 *prev_ack, bool *scheduled);
+int do_rc_ack(struct rvt_qp *qp, u32 aeth, u32 psn, int opcode, u64 val,
+	      struct hfi2_ctxtdata *rcd);
+struct rvt_swqe *do_rc_completion(struct rvt_qp *qp, struct rvt_swqe *wqe,
+				  struct hfi2_ibport *ibp);
+
+#endif /* HFI2_RC_H */
diff --git a/drivers/infiniband/hw/hfi2/sdma.h b/drivers/infiniband/hw/hfi2/sdma.h
new file mode 100644
index 000000000000..77d285283cb9
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/sdma.h
@@ -0,0 +1,1212 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#ifndef _HFI2_SDMA_H
+#define _HFI2_SDMA_H
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include <asm/byteorder.h>
+#include <linux/workqueue.h>
+#include <linux/rculist.h>
+
+#include "sdma_defs.h"
+#include "hfi2.h"
+#include "verbs.h"
+#include "sdma_txreq.h"
+
+static inline bool wfr_sdma_qw_get_first_desc(u64 *qw)
+{
+	return !!(qw[0] & WFR_SDMA_DESC0_FIRST_DESC_FLAG);
+}
+
+static inline void wfr_sdma_qw_set_first_desc(u64 *qw)
+{
+	qw[0] |= WFR_SDMA_DESC0_FIRST_DESC_FLAG;
+}
+
+static inline bool wfr_sdma_qw_get_last_desc(u64 *qw)
+{
+	return !!(qw[0] & WFR_SDMA_DESC0_LAST_DESC_FLAG);
+}
+
+static inline void wfr_sdma_qw_set_last_desc(u64 *qw)
+{
+	qw[0] |= WFR_SDMA_DESC0_LAST_DESC_FLAG;
+}
+
+static inline u32 wfr_sdma_qw_get_byte_count(u64 *qw)
+{
+	return (qw[0] >> WFR_SDMA_DESC0_BYTE_COUNT_SHIFT) &
+		WFR_SDMA_DESC0_BYTE_COUNT_MASK;
+}
+
+/* assumes starting field is zero */
+static inline void wfr_sdma_qw_set_byte_count(u64 *qw, u32 bytes)
+{
+	qw[0] |= ((u64)bytes & WFR_SDMA_DESC0_BYTE_COUNT_MASK) <<
+			WFR_SDMA_DESC0_BYTE_COUNT_SHIFT;
+}
+
+static inline u64 wfr_sdma_qw_get_phy_addr(u64 *qw)
+{
+	return (qw[0] >> WFR_SDMA_DESC0_PHY_ADDR_SHIFT) &
+		WFR_SDMA_DESC0_PHY_ADDR_MASK;
+}
+
+/* assumes starting field is zero */
+static inline void wfr_sdma_qw_set_phy_addr(u64 *qw, u64 phy_addr)
+{
+	qw[0] |= (phy_addr & WFR_SDMA_DESC0_PHY_ADDR_MASK) <<
+			WFR_SDMA_DESC0_PHY_ADDR_SHIFT;
+}
+
+static inline bool jkr_sdma_qw_get_first_desc(u64 *qw)
+{
+	return !!(qw[1] & JKR_SDMA_DESC1_FIRST_DESC_FLAG);
+}
+
+static inline void jkr_sdma_qw_set_first_desc(u64 *qw)
+{
+	qw[1] |= JKR_SDMA_DESC1_FIRST_DESC_FLAG;
+}
+
+static inline bool jkr_sdma_qw_get_last_desc(u64 *qw)
+{
+	return !!(qw[1] & JKR_SDMA_DESC1_LAST_DESC_FLAG);
+}
+
+static inline void jkr_sdma_qw_set_last_desc(u64 *qw)
+{
+	qw[1] |= JKR_SDMA_DESC1_LAST_DESC_FLAG;
+}
+
+static inline u32 jkr_sdma_qw_get_byte_count(u64 *qw)
+{
+	return (qw[1] >> JKR_SDMA_DESC1_BYTE_COUNT_SHIFT) &
+		JKR_SDMA_DESC1_BYTE_COUNT_MASK;
+}
+
+/* assumes starting field is zero */
+static inline void jkr_sdma_qw_set_byte_count(u64 *qw, u32 bytes)
+{
+	qw[1] |= ((u64)bytes & JKR_SDMA_DESC1_BYTE_COUNT_MASK) <<
+			JKR_SDMA_DESC1_BYTE_COUNT_SHIFT;
+}
+
+static inline u64 jkr_sdma_qw_get_phy_addr(u64 *qw)
+{
+	return (qw[0] >> JKR_SDMA_DESC0_PHY_ADDR_SHIFT) &
+		JKR_SDMA_DESC0_PHY_ADDR_MASK;
+}
+
+/* assumes starting field is zero */
+static inline void jkr_sdma_qw_set_phy_addr(u64 *qw, u64 phy_addr)
+{
+	qw[0] |= (phy_addr & JKR_SDMA_DESC0_PHY_ADDR_MASK) <<
+			JKR_SDMA_DESC0_PHY_ADDR_SHIFT;
+}
+
+/* Per-chip setter inlining wrapper */
+#define sdma_qw_set(dd, field, ...) do { \
+	if ((dd)->params->chip_type == CHIP_WFR) \
+		wfr_sdma_qw_set_##field(__VA_ARGS__); \
+	else if ((dd)->params->chip_type == CHIP_JKR) \
+		jkr_sdma_qw_set_##field(__VA_ARGS__); \
+	else \
+		WARN_ONCE(1, "Unsupported chip type %u", \
+			  (dd)->params->chip_type); \
+} while (0)
+
+/* Per-chip getter inlining wrapper */
+#define sdma_qw_get(dd, fn, p) \
+	((dd)->params->chip_type == CHIP_WFR ?  wfr_sdma_qw_get_##fn((p)) : \
+	 ((dd)->params->chip_type == CHIP_JKR ? jkr_sdma_qw_get_##fn((p)) : 0))
+
+enum sdma_states {
+	sdma_state_s00_hw_down,
+	sdma_state_s10_hw_start_up_halt_wait,
+	sdma_state_s15_hw_start_up_clean_wait,
+	sdma_state_s20_idle,
+	sdma_state_s30_sw_clean_up_wait,
+	sdma_state_s40_hw_clean_up_wait,
+	sdma_state_s50_hw_halt_wait,
+	sdma_state_s60_idle_halt_wait,
+	sdma_state_s80_hw_freeze,
+	sdma_state_s82_freeze_sw_clean,
+	sdma_state_s99_running,
+};
+
+enum sdma_events {
+	sdma_event_e00_go_hw_down,
+	sdma_event_e10_go_hw_start,
+	sdma_event_e15_hw_halt_done,
+	sdma_event_e25_hw_clean_up_done,
+	sdma_event_e30_go_running,
+	sdma_event_e40_sw_cleaned,
+	sdma_event_e50_hw_cleaned,
+	sdma_event_e60_hw_halted,
+	sdma_event_e70_go_idle,
+	sdma_event_e80_hw_freeze,
+	sdma_event_e81_hw_frozen,
+	sdma_event_e82_hw_unfreeze,
+	sdma_event_e85_link_down,
+	sdma_event_e90_sw_halted,
+};
+
+struct sdma_set_state_action {
+	unsigned op_enable:1;
+	unsigned op_intenable:1;
+	unsigned op_halt:1;
+	unsigned op_cleanup:1;
+	unsigned go_s99_running_tofalse:1;
+	unsigned go_s99_running_totrue:1;
+};
+
+struct sdma_state {
+	struct kref          kref;
+	struct completion    comp;
+	enum sdma_states current_state;
+	unsigned             current_op;
+	unsigned             go_s99_running;
+	/* debugging/development */
+	enum sdma_states previous_state;
+	unsigned             previous_op;
+	enum sdma_events last_event;
+};
+
+/**
+ * DOC: sdma exported routines
+ *
+ * These sdma routines fit into three categories:
+ * - The SDMA API for building and submitting packets
+ *   to the ring
+ *
+ * - Initialization and tear down routines to buildup
+ *   and tear down SDMA
+ *
+ * - ISR entrances to handle interrupts, state changes
+ *   and errors
+ */
+
+/**
+ * DOC: sdma PSM/verbs API
+ *
+ * The sdma API is designed to be used by both PSM
+ * and verbs to supply packets to the SDMA ring.
+ *
+ * The usage of the API is as follows:
+ *
+ * Embed a struct iowait in the QP or
+ * PQ.  The iowait should be initialized with a
+ * call to iowait_init().
+ *
+ * The user of the API should create an allocation method
+ * for their version of the txreq. slabs, pre-allocated lists,
+ * and dma pools can be used.  Once the user's overload of
+ * the sdma_txreq has been allocated, the sdma_txreq member
+ * must be initialized with sdma_txinit() or sdma_txinit_ahg().
+ *
+ * The txreq must be declared with the sdma_txreq first.
+ *
+ * The tx request, once initialized,  is manipulated with calls to
+ * sdma_txadd_daddr(), sdma_txadd_page(), or sdma_txadd_kvaddr()
+ * for each disjoint memory location.  It is the user's responsibility
+ * to understand the packet boundaries and page boundaries to do the
+ * appropriate number of sdma_txadd_* calls..  The user
+ * must be prepared to deal with failures from these routines due to
+ * either memory allocation or dma_mapping failures.
+ *
+ * The mapping specifics for each memory location are recorded
+ * in the tx. Memory locations added with sdma_txadd_page()
+ * and sdma_txadd_kvaddr() are automatically mapped when added
+ * to the tx and nmapped as part of the progress processing in the
+ * SDMA interrupt handling.
+ *
+ * sdma_txadd_daddr() is used to add an dma_addr_t memory to the
+ * tx.   An example of a use case would be a pre-allocated
+ * set of headers allocated via dma_pool_alloc() or
+ * dma_alloc_coherent().  For these memory locations, it
+ * is the responsibility of the user to handle that unmapping.
+ * (This would usually be at an unload or job termination.)
+ *
+ * The routine sdma_send_txreq() is used to submit
+ * a tx to the ring after the appropriate number of
+ * sdma_txadd_* have been done.
+ *
+ * If it is desired to send a burst of sdma_txreqs, sdma_send_txlist()
+ * can be used to submit a list of packets.
+ *
+ * The user is free to use the link overhead in the struct sdma_txreq as
+ * long as the tx isn't in flight.
+ *
+ * The extreme degenerate case of the number of descriptors
+ * exceeding the ring size is automatically handled as
+ * memory locations are added.  An overflow of the descriptor
+ * array that is part of the sdma_txreq is also automatically
+ * handled.
+ *
+ */
+
+/**
+ * DOC: Infrastructure calls
+ *
+ * sdma_init() is used to initialize data structures and
+ * CSRs for the desired number of SDMA engines.
+ *
+ * sdma_start() is used to kick the SDMA engines initialized
+ * with sdma_init().   Interrupts must be enabled at this
+ * point since aspects of the state machine are interrupt
+ * driven.
+ *
+ * sdma_engine_error() and sdma_engine_interrupt() are
+ * entrances for interrupts.
+ *
+ * sdma_map_init() is for the management of the mapping
+ * table when the number of vls is changed.
+ *
+ */
+
+/*
+ * struct hw_sdma_desc - raw 128 bit SDMA descriptor
+ *
+ * This is the raw descriptor in the SDMA ring
+ */
+struct hw_sdma_desc {
+	/* private:  don't use directly */
+	__le64 qw[2];
+};
+
+/**
+ * struct sdma_engine - Data pertaining to each SDMA engine.
+ * @dd: a back-pointer to the device data
+ * @ppd: per port back-pointer
+ * @imask: mask for irq manipulation
+ * @idle_mask: mask for determining if an interrupt is due to sdma_idle
+ *
+ * This structure has the state for each sdma_engine.
+ *
+ * Accessing to non public fields are not supported
+ * since the private members are subject to change.
+ */
+struct sdma_engine {
+	/* read mostly */
+	struct hfi2_devdata *dd;
+	/* private: */
+	void __iomem *tail_csr;
+	u64 imask;			/* clear interrupt mask */
+	u64 idle_mask;
+	u64 progress_mask;
+	u64 int_mask;
+	/* private: */
+	volatile __le64      *head_dma; /* DMA'ed by chip */
+	/* private: */
+	dma_addr_t            head_phys;
+	/* private: */
+	struct hw_sdma_desc *descq;
+	/* private: */
+	unsigned descq_full_count;
+	struct sdma_txreq **tx_ring;
+	/* private: */
+	dma_addr_t            descq_phys;
+	/* private */
+	u32 sdma_mask;
+	/* private */
+	struct sdma_state state;
+	/* private */
+	int cpu;
+	/* private: */
+	u8 sdma_shift;
+	/* private: */
+	u8 this_idx; /* zero relative engine */
+	/* protect changes to senddmactrl shadow */
+	spinlock_t senddmactrl_lock;
+	/* private: */
+	u64 p_senddmactrl;		/* shadow per-engine SendDmaCtrl */
+
+	/* read/write using tail_lock */
+	spinlock_t            tail_lock ____cacheline_aligned_in_smp;
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+	/* private: */
+	u64                   tail_sn;
+#endif
+	/* private: */
+	u32                   descq_tail;
+	/* private: */
+	unsigned long         ahg_bits;
+	/* private: */
+	u16                   desc_avail;
+	/* private: */
+	u16                   tx_tail;
+	/* private: */
+	u16 descq_cnt;
+
+	/* read/write using head_lock */
+	/* private: */
+	seqlock_t            head_lock ____cacheline_aligned_in_smp;
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+	/* private: */
+	u64                   head_sn;
+#endif
+	/* private: */
+	u32                   descq_head;
+	/* private: */
+	u16                   tx_head;
+	/* private: */
+	u64                   last_status;
+	/* private */
+	u64                     err_cnt;
+	/* private */
+	u64                     sdma_int_cnt;
+	u64                     idle_int_cnt;
+	u64                     progress_int_cnt;
+
+	/* private: */
+	seqlock_t            waitlock;
+	struct list_head      dmawait;
+
+	/* CONFIG SDMA for now, just blindly duplicate */
+	/* private: */
+	struct work_struct sdma_hw_clean_up_work;
+	struct work_struct sdma_sw_clean_up_work;
+
+	/* private: */
+	struct work_struct err_halt_worker;
+	/* private */
+	struct timer_list     err_progress_check_timer;
+	u32                   progress_check_head;
+	/* private: */
+	struct work_struct flush_worker;
+	/* protect flush list */
+	spinlock_t flushlist_lock;
+	/* private: */
+	struct list_head flushlist;
+	struct cpumask cpu_mask;
+	struct kobject kobj;
+	u32 msix_intr;
+};
+
+int sdma_init(struct hfi2_devdata *dd);
+void sdma_start(struct hfi2_devdata *dd);
+void sdma_exit(struct hfi2_devdata *dd);
+void sdma_clean(struct hfi2_devdata *dd, size_t num_engines);
+void sdma_all_running(struct hfi2_devdata *dd);
+void sdma_all_idle(struct hfi2_devdata *dd);
+void sdma_freeze_notify(struct hfi2_devdata *dd, int go_idle);
+void sdma_freeze(struct hfi2_devdata *dd);
+void sdma_unfreeze(struct hfi2_devdata *dd);
+void sdma_wait(struct hfi2_devdata *dd);
+
+/**
+ * sdma_empty() - idle engine test
+ * @engine: sdma engine
+ *
+ * Currently used by verbs as a latency optimization.
+ *
+ * Return:
+ * 1 - empty, 0 - non-empty
+ */
+static inline int sdma_empty(struct sdma_engine *sde)
+{
+	return sde->descq_tail == sde->descq_head;
+}
+
+/*
+ * Return the number of descriptors in use.  Expects descq_cnt is a
+ * power-of-two.  See sdma_get_descq_cnt().
+ */
+static inline u16 sdma_descq_inprocess(struct sdma_engine *sde)
+{
+	return (sde->descq_cnt + sde->descq_tail - READ_ONCE(sde->descq_head))
+		& (sde->descq_cnt - 1);
+}
+
+/* return the number of descriptors available */
+static inline u16 sdma_descq_freecnt(struct sdma_engine *sde)
+{
+	return sde->descq_cnt - 1 - sdma_descq_inprocess(sde);
+}
+
+/*
+ * Either head_lock or tail lock required to see
+ * a steady state.
+ */
+static inline int __sdma_running(struct sdma_engine *engine)
+{
+	return engine->state.current_state == sdma_state_s99_running;
+}
+
+/**
+ * sdma_running() - state suitability test
+ * @engine: sdma engine
+ *
+ * sdma_running probes the internal state to determine if it is suitable
+ * for submitting packets.
+ *
+ * Return:
+ * 1 - ok to submit, 0 - not ok to submit
+ *
+ */
+static inline int sdma_running(struct sdma_engine *engine)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&engine->tail_lock, flags);
+	ret = __sdma_running(engine);
+	spin_unlock_irqrestore(&engine->tail_lock, flags);
+	return ret;
+}
+
+void _sdma_txreq_ahgadd(
+	struct sdma_txreq *tx,
+	u8 num_ahg,
+	u8 ahg_entry,
+	u32 *ahg,
+	u8 ahg_hlen);
+
+/*
+ * Padding is needed if the data is not a multiple of 4 bytes.  This will
+ * only possibly be true for 9B packets.  The packet_len for 16B packets will
+ * already be padded to a multiple of 8 bytes.
+ */
+static inline int needs_pad(u16 packet_len)
+{
+	return (packet_len & 0x3) != 0;
+}
+
+/* return the number of bytes needed to pad to a multiple of 4 */
+static inline int pad_length(struct sdma_txreq *tx)
+{
+	return (4 - (tx->packet_len & 0x3)) & 0x3;
+}
+
+#define ALIGN_NONE          0
+#define ALIGN_256_ALL       1
+#define ALIGN_256_HEAD_TAIL 2
+#define ALIGN_256_TAIL      3
+
+/* return the max number of descriptors a segment might need */
+static inline int calc_num_desc(struct hfi2_devdata *dd, u16 packet_len)
+{
+	if (dd->sdma_align == ALIGN_256_HEAD_TAIL)
+		return 3; /* head, mid, tail */
+	if (dd->sdma_align == ALIGN_NONE)
+		return 1; /* all */
+	if (dd->sdma_align == ALIGN_256_TAIL)
+		return 2; /* head+mid, tail */
+	/*
+	 * Conservative ALIGN_ALL case - split on every 256 byte fetch
+	 * boundary.  The returned number must be the same for the whole
+	 * packet - not just the current segment.
+	 *
+	 * A 10240 sized packet could have at most 41 descriptors.
+	 */
+	return (round_up(packet_len, 256) >> 8) + 1;
+}
+
+/**
+ * sdma_txinit_ahg() - initialize an sdma_txreq struct with AHG
+ * @dd: device data
+ * @tx: tx request to initialize
+ * @flags: flags to key last descriptor additions
+ * @tlen: total packet length (pbc + headers + data)
+ * @ahg_entry: ahg entry to use  (0 - 31)
+ * @num_ahg: ahg descriptor for first descriptor (0 - 9)
+ * @ahg: array of AHG descriptors (up to 9 entries)
+ * @ahg_hlen: number of bytes from ASIC entry to use
+ * @cb: callback
+ *
+ * The allocation of the sdma_txreq and it enclosing structure is user
+ * dependent.  This routine must be called to initialize the user independent
+ * fields.
+ *
+ * The currently supported flags are SDMA_TXREQ_F_URGENT,
+ * SDMA_TXREQ_F_AHG_COPY, and SDMA_TXREQ_F_USE_AHG.
+ *
+ * SDMA_TXREQ_F_URGENT is used for latency sensitive situations where the
+ * completion is desired as soon as possible.
+ *
+ * SDMA_TXREQ_F_AHG_COPY causes the header in the first descriptor to be
+ * copied to chip entry. SDMA_TXREQ_F_USE_AHG causes the code to add in
+ * the AHG descriptors into the first 1 to 3 descriptors.
+ *
+ * Completions of submitted requests can be gotten on selected
+ * txreqs by giving a completion routine callback to sdma_txinit() or
+ * sdma_txinit_ahg().  The environment in which the callback runs
+ * can be from an ISR, a tasklet, or a thread, so no sleeping
+ * kernel routines can be used.   Aspects of the sdma ring may
+ * be locked so care should be taken with locking.
+ *
+ * The callback pointer can be NULL to avoid any callback for the packet
+ * being submitted. The callback will be provided this tx, a status, and a flag.
+ *
+ * The status will be one of SDMA_TXREQ_S_OK, SDMA_TXREQ_S_SENDERROR,
+ * SDMA_TXREQ_S_ABORTED, or SDMA_TXREQ_S_SHUTDOWN.
+ *
+ * The flag, if the is the iowait had been used, indicates the iowait
+ * sdma_busy count has reached zero.
+ *
+ * user data portion of tlen should be precise.   The sdma_txadd_* entrances
+ * will pad with a descriptor references 1 - 3 bytes when the number of bytes
+ * specified in tlen have been supplied to the sdma_txreq.
+ *
+ * ahg_hlen is used to determine the number of on-chip entry bytes to
+ * use as the header.   This is for cases where the stored header is
+ * larger than the header to be used in a packet.  This is typical
+ * for verbs where an RDMA_WRITE_FIRST is larger than the packet in
+ * and RDMA_WRITE_MIDDLE.
+ *
+ */
+static inline int sdma_txinit_ahg(struct hfi2_devdata *dd,
+				  struct sdma_txreq *tx,
+				  u16 flags,
+				  u16 tlen,
+				  u8 ahg_entry,
+				  u8 num_ahg,
+				  u32 *ahg,
+				  u8 ahg_hlen,
+				  void (*cb)(struct sdma_txreq *, int))
+{
+	if (tlen == 0)
+		return -ENODATA;
+	if (tlen > MAX_SDMA_PKT_SIZE)
+		return -EMSGSIZE;
+	tx->desc_limit = ARRAY_SIZE(tx->descs);
+	tx->descp = &tx->descs[0];
+	INIT_LIST_HEAD(&tx->list);
+	tx->num_desc = 0;
+	tx->flags = flags;
+	tx->complete = cb;
+	tx->coalesce_buf = NULL;
+	tx->wait = NULL;
+	tx->packet_len = tlen;
+	tx->tlen = tx->packet_len;
+	tx->desc_margin = calc_num_desc(dd, tx->packet_len) + needs_pad(tx->packet_len);
+	tx->descs[0].qw[0] = 0;
+	tx->descs[0].qw[1] = 0;
+	/*
+	 * Do not bother with initializing .map_type; sdma_set_map_type()
+	 * should overwrite per-desc bits. sdma_get_map_type() should not be
+	 * called for per-desc bits that haven't been set with
+	 * sdma_set_map_type().
+	 */
+	sdma_qw_set(dd, first_desc, tx->descs[0].qw);
+	if (flags & SDMA_TXREQ_F_AHG_COPY)
+		tx->descs[0].qw[1] |=
+			(((u64)ahg_entry & SDMA_DESC1_HEADER_INDEX_MASK)
+				<< SDMA_DESC1_HEADER_INDEX_SHIFT) |
+			(((u64)SDMA_AHG_COPY & SDMA_DESC1_HEADER_MODE_MASK)
+				<< SDMA_DESC1_HEADER_MODE_SHIFT);
+	else if (flags & SDMA_TXREQ_F_USE_AHG && num_ahg)
+		_sdma_txreq_ahgadd(tx, num_ahg, ahg_entry, ahg, ahg_hlen);
+	return 0;
+}
+
+/**
+ * sdma_txinit() - initialize an sdma_txreq struct (no AHG)
+ * @dd: device data
+ * @tx: tx request to initialize
+ * @flags: flags to key last descriptor additions
+ * @tlen: total packet length (pbc + headers + data)
+ * @cb: callback pointer
+ *
+ * The allocation of the sdma_txreq and it enclosing structure is user
+ * dependent.  This routine must be called to initialize the user
+ * independent fields.
+ *
+ * The currently supported flags is SDMA_TXREQ_F_URGENT.
+ *
+ * SDMA_TXREQ_F_URGENT is used for latency sensitive situations where the
+ * completion is desired as soon as possible.
+ *
+ * Completions of submitted requests can be gotten on selected
+ * txreqs by giving a completion routine callback to sdma_txinit() or
+ * sdma_txinit_ahg().  The environment in which the callback runs
+ * can be from an ISR, a tasklet, or a thread, so no sleeping
+ * kernel routines can be used.   The head size of the sdma ring may
+ * be locked so care should be taken with locking.
+ *
+ * The callback pointer can be NULL to avoid any callback for the packet
+ * being submitted.
+ *
+ * The callback, if non-NULL,  will be provided this tx and a status.  The
+ * status will be one of SDMA_TXREQ_S_OK, SDMA_TXREQ_S_SENDERROR,
+ * SDMA_TXREQ_S_ABORTED, or SDMA_TXREQ_S_SHUTDOWN.
+ *
+ */
+static inline int sdma_txinit(struct hfi2_devdata *dd,
+			      struct sdma_txreq *tx,
+			      u16 flags,
+			      u16 tlen,
+			      void (*cb)(struct sdma_txreq *, int))
+{
+	return sdma_txinit_ahg(dd, tx, flags, tlen, 0, 0, NULL, 0, cb);
+}
+
+static inline size_t sdma_mapping_len(struct hfi2_devdata *dd,
+				      struct sdma_desc *d)
+{
+	return sdma_qw_get(dd, byte_count, d->qw);
+}
+
+static inline dma_addr_t sdma_mapping_addr(struct hfi2_devdata *dd,
+					   struct sdma_desc *d)
+{
+	return sdma_qw_get(dd, phy_addr, d->qw);
+}
+
+static inline void sdma_set_map_type(struct sdma_txreq *tx,
+				     u8 i, u8 type)
+{
+	int w = BIT_WORD(i * SDMA_MAP_BITS);
+	int offset = (i * SDMA_MAP_BITS) % BITS_PER_LONG;
+	unsigned long shftmask = SDMA_MAP_MASK << offset;
+	unsigned long *mw = &tx->map_type[w];
+	unsigned long new = type << offset;
+
+	/* Per-desc SDMA_MAP_BITS-sized field must never cross word boundary */
+	static_assert(BITS_PER_LONG % SDMA_MAP_BITS == 0);
+	bitmap_replace(mw, mw, &new, &shftmask, SDMA_MAP_BITS);
+}
+
+static inline u8 sdma_get_map_type(struct sdma_txreq *tx, u8 i)
+{
+	int idx = i * SDMA_MAP_BITS;
+
+	/* Per-desc field must always fit in u8 */
+	static_assert(SDMA_MAP_BITS <= 8);
+	return bitmap_get_value8(tx->map_type, idx) & SDMA_MAP_MASK;
+}
+
+/* do the work, caller is responsible for all checking */
+static inline void _make_tx_sdma_desc(struct hfi2_devdata *dd,
+				      struct sdma_txreq *tx,
+				      int type,
+				      dma_addr_t addr,
+				      size_t len)
+{
+	struct sdma_desc *desc = &tx->descp[tx->num_desc];
+
+	sdma_set_map_type(tx, tx->num_desc, type);
+	if (!tx->num_desc) {
+		/* qw[0] zero; qw[1] first, ahg mode already in from init */
+	} else {
+		desc->qw[0] = 0;
+		desc->qw[1] = 0;
+	}
+
+	sdma_qw_set(dd, phy_addr, desc->qw, addr);
+	sdma_qw_set(dd, byte_count, desc->qw, len);
+	tx->num_desc++;
+}
+
+
+/*
+ * Create one or more descriptors to fetch len bytes.  Enough descriptor room
+ * is guaranteed by the time this function is called.
+ */
+static inline void make_tx_sdma_desc(struct hfi2_devdata *dd,
+				     struct sdma_txreq *tx,
+				     int type,
+				     dma_addr_t addr,
+				     size_t len)
+{
+#define ALIGN_SIZE 256
+#define ALIGN_MASK (ALIGN_SIZE - 1)
+	switch (dd->sdma_align) {
+	case ALIGN_256_ALL:
+		/* align head */
+		if (addr & ALIGN_MASK) {
+			size_t clen = ALIGN_SIZE - (addr & ALIGN_MASK);
+
+			if (clen > len)
+				clen = len;
+			_make_tx_sdma_desc(dd, tx, type, addr, clen);
+			len -= clen;
+			addr += clen;
+		}
+		/* now aligned, split into full sized chunks */
+		while (len >= ALIGN_SIZE) {
+			_make_tx_sdma_desc(dd, tx, type, addr, ALIGN_SIZE);
+			len -= ALIGN_SIZE;
+			addr += ALIGN_SIZE;
+		}
+		/* tail overhang */
+		if (len) {
+			_make_tx_sdma_desc(dd, tx, type, addr, len);
+		}
+		break;
+
+	case ALIGN_256_HEAD_TAIL: {
+		size_t clen;
+
+		/* align head */
+		if (addr & ALIGN_MASK) {
+			clen = ALIGN_SIZE - (addr & ALIGN_MASK);
+			if (clen > len)
+				clen = len;
+			_make_tx_sdma_desc(dd, tx, type, addr, clen);
+			len -= clen;
+			addr += clen;
+		}
+		/* aligned start to aligned tail */
+		clen = len & ~ALIGN_MASK;
+		if (clen) {
+			_make_tx_sdma_desc(dd, tx, type, addr, clen);
+			len -= clen;
+			addr += clen;
+		}
+		/* tail overhang */
+		if (len) {
+			_make_tx_sdma_desc(dd, tx, type, addr, len);
+		}
+		break;
+	}
+
+	case ALIGN_256_TAIL: {
+		dma_addr_t end = addr + len;
+		bool same = (addr & ~ALIGN_MASK) == (end & ~ALIGN_MASK);
+		size_t tail_len = end & ALIGN_MASK;
+		size_t clen = len - tail_len;
+
+		/* start to aligned tail */
+		if (clen && !same) {
+			_make_tx_sdma_desc(dd, tx, type, addr, clen);
+			len -= clen;
+			addr += clen;
+		}
+		/* tail overhang */
+		if (len) {
+			_make_tx_sdma_desc(dd, tx, type, addr, len);
+		}
+		break;
+	}
+
+	default:
+		_make_tx_sdma_desc(dd, tx, type, addr, len);
+		break;
+	}
+#undef ALIGN_SIZE
+#undef ALIGN_MASK
+}
+
+void __sdma_txclean(struct hfi2_devdata *, struct sdma_txreq *);
+
+static inline void sdma_txclean(struct hfi2_devdata *dd, struct sdma_txreq *tx)
+{
+	if (tx->num_desc)
+		__sdma_txclean(dd, tx);
+}
+
+/* calculate the number of no-op descriptors to add */
+static inline int sdma_desc_pad_count(struct hfi2_devdata *dd,
+				      struct sdma_txreq *tx)
+{
+	if (dd->pad_sdma_desc)
+		return round_up(tx->num_desc, dd->pad_sdma_desc) - tx->num_desc;
+	return 0;
+}
+
+/* helpers used by public routines */
+static inline void _sdma_close_tx(struct hfi2_devdata *dd,
+				  struct sdma_txreq *tx)
+{
+	u16 last_desc = tx->num_desc - 1;
+
+	sdma_qw_set(dd, last_desc, tx->descp[last_desc].qw);
+	tx->descp[last_desc].qw[1] |= dd->default_desc1;
+	if (tx->flags & SDMA_TXREQ_F_URGENT)
+		tx->descp[last_desc].qw[1] |= (SDMA_DESC1_HEAD_TO_HOST_FLAG |
+					       SDMA_DESC1_INT_REQ_FLAG);
+	tx->num_pad = sdma_desc_pad_count(dd, tx);
+}
+
+/* return true if the current buffer must coalesce */
+static inline bool must_coalesce(struct sdma_txreq *tx)
+{
+	return tx->num_desc + tx->desc_margin >= MAX_DESC;
+}
+
+/* return true if the current buffer forces an extension */
+static inline bool need_desc_extension(struct sdma_txreq *tx)
+{
+	return (tx->desc_limit == ARRAY_SIZE(tx->descs)) &&
+	       (tx->num_desc + tx->desc_margin >= ARRAY_SIZE(tx->descs));
+}
+int _extend_sdma_tx_descs(struct hfi2_devdata *dd, struct sdma_txreq *tx);
+
+static inline int _sdma_txadd_daddr(struct hfi2_devdata *dd,
+				    int type,
+				    struct sdma_txreq *tx,
+				    dma_addr_t addr,
+				    u16 len)
+{
+	int rval;
+
+	WARN_ON(len > tx->tlen);
+	if (need_desc_extension(tx)) {
+		rval = _extend_sdma_tx_descs(dd, tx);
+		if (rval)
+			return rval;
+	}
+
+	make_tx_sdma_desc(dd, tx, type, addr, len);
+	tx->tlen -= len;
+
+	/* special case for last */
+	if (!tx->tlen) {
+		int pad_len = pad_length(tx);
+
+		if (pad_len) {
+			make_tx_sdma_desc(dd, tx, SDMA_MAP_NONE,
+					  dd->sdma_pad_phys, pad_len);
+		}
+		_sdma_close_tx(dd, tx);
+	}
+	return 0;
+}
+
+int do_coalesce(struct hfi2_devdata *dd, struct sdma_txreq *tx,
+		int type, void *kvaddr, struct page *page,
+		unsigned long offset, u16 len);
+
+/**
+ * sdma_txadd_page() - add a page to the sdma_txreq
+ * @dd: the device to use for mapping
+ * @tx: tx request to which the page is added
+ * @page: page to map
+ * @offset: offset within the page
+ * @len: length in bytes
+ *
+ * This is used to add a page/offset/length descriptor.
+ *
+ * The mapping/unmapping of the page/offset/len is automatically handled.
+ *
+ * Return:
+ * 0 - success, -ENOSPC - mapping fail, -ENOMEM - couldn't
+ * extend/coalesce descriptor array
+ */
+static inline int sdma_txadd_page(
+	struct hfi2_devdata *dd,
+	struct sdma_txreq *tx,
+	struct page *page,
+	unsigned long offset,
+	u16 len)
+{
+	dma_addr_t addr;
+
+	if (unlikely(must_coalesce(tx)))
+		return do_coalesce(dd, tx, SDMA_MAP_PAGE,
+				   NULL, page, offset, len);
+
+	addr = dma_map_page(
+		       &dd->pcidev->dev,
+		       page,
+		       offset,
+		       len,
+		       DMA_TO_DEVICE);
+
+	if (unlikely(dma_mapping_error(&dd->pcidev->dev, addr))) {
+		__sdma_txclean(dd, tx);
+		return -ENOSPC;
+	}
+
+	return _sdma_txadd_daddr(dd, SDMA_MAP_PAGE, tx, addr, len);
+}
+
+/**
+ * sdma_txadd_daddr() - add a dma address to the sdma_txreq
+ * @dd: the device to use for mapping
+ * @tx: sdma_txreq to which the page is added
+ * @addr: dma address mapped by caller
+ * @len: length in bytes
+ *
+ * This is used to add a descriptor for memory that is already dma mapped.
+ *
+ * In this case, there is no unmapping as part of the progress processing for
+ * this memory location.
+ *
+ * Return:
+ * 0 - success, -ENOMEM - couldn't extend descriptor array
+ */
+
+static inline int sdma_txadd_daddr(
+	struct hfi2_devdata *dd,
+	struct sdma_txreq *tx,
+	dma_addr_t addr,
+	u16 len)
+{
+	if (unlikely(must_coalesce(tx)))
+		return do_coalesce(dd, tx, SDMA_MAP_NONE,
+				   NULL, NULL, 0, 0);
+
+	return _sdma_txadd_daddr(dd, SDMA_MAP_NONE, tx, addr, len);
+}
+
+/**
+ * sdma_txadd_kvaddr() - add a kernel virtual address to sdma_txreq
+ * @dd: the device to use for mapping
+ * @tx: sdma_txreq to which the page is added
+ * @kvaddr: the kernel virtual address
+ * @len: length in bytes
+ *
+ * This is used to add a descriptor referenced by the indicated kvaddr and
+ * len.
+ *
+ * The mapping/unmapping of the kvaddr and len is automatically handled.
+ *
+ * Return:
+ * 0 - success, -ENOSPC - mapping fail, -ENOMEM - couldn't extend/coalesce
+ * descriptor array
+ */
+static inline int sdma_txadd_kvaddr(
+	struct hfi2_devdata *dd,
+	struct sdma_txreq *tx,
+	void *kvaddr,
+	u16 len)
+{
+	dma_addr_t addr;
+
+	if (unlikely(must_coalesce(tx)))
+		return do_coalesce(dd, tx, SDMA_MAP_SINGLE,
+				   kvaddr, NULL, 0, len);
+
+	addr = dma_map_single(
+		       &dd->pcidev->dev,
+		       kvaddr,
+		       len,
+		       DMA_TO_DEVICE);
+
+	if (unlikely(dma_mapping_error(&dd->pcidev->dev, addr))) {
+		__sdma_txclean(dd, tx);
+		return -ENOSPC;
+	}
+
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx, addr, len);
+}
+
+struct iowait_work;
+
+int sdma_send_txreq(struct sdma_engine *sde,
+		    struct iowait_work *wait,
+		    struct sdma_txreq *tx,
+		    bool pkts_sent);
+int sdma_send_txlist(struct sdma_engine *sde,
+		     struct iowait_work *wait,
+		     struct list_head *tx_list,
+		     u16 *count_out);
+
+int sdma_ahg_alloc(struct sdma_engine *sde);
+void sdma_ahg_free(struct sdma_engine *sde, int ahg_index);
+
+/**
+ * sdma_build_ahg - build ahg descriptor
+ * @data
+ * @dwindex
+ * @startbit
+ * @bits
+ *
+ * Build and return a 32 bit descriptor.
+ */
+static inline u32 sdma_build_ahg_descriptor(
+	u16 data,
+	u8 dwindex,
+	u8 startbit,
+	u8 bits)
+{
+	return (u32)(1UL << SDMA_AHG_UPDATE_ENABLE_SHIFT |
+		((startbit & SDMA_AHG_FIELD_START_MASK) <<
+		SDMA_AHG_FIELD_START_SHIFT) |
+		((bits & SDMA_AHG_FIELD_LEN_MASK) <<
+		SDMA_AHG_FIELD_LEN_SHIFT) |
+		((dwindex & SDMA_AHG_INDEX_MASK) <<
+		SDMA_AHG_INDEX_SHIFT) |
+		((data & SDMA_AHG_VALUE_MASK) <<
+		SDMA_AHG_VALUE_SHIFT));
+}
+
+/**
+ * sdma_progress - use seq number of detect head progress
+ * @sde: sdma_engine to check
+ * @seq: base seq count
+ * @tx: txreq for which we need to check descriptor availability
+ *
+ * This is used in the appropriate spot in the sleep routine
+ * to check for potential ring progress.  This routine gets the
+ * seqcount before queuing the iowait structure for progress.
+ *
+ * If the seqcount indicates that progress needs to be checked,
+ * re-submission is detected by checking whether the descriptor
+ * queue has enough descriptor for the txreq.
+ */
+static inline unsigned sdma_progress(struct sdma_engine *sde, unsigned seq,
+				     struct sdma_txreq *tx)
+{
+	if (read_seqretry(&sde->head_lock, seq)) {
+		sde->desc_avail = sdma_descq_freecnt(sde);
+		if (tx->num_desc + tx->num_pad > sde->desc_avail)
+			return 0;
+		return 1;
+	}
+	return 0;
+}
+
+/* for use by interrupt handling */
+void sdma_engine_error(struct sdma_engine *sde, u64 status);
+void sdma_engine_interrupt(struct sdma_engine *sde, u64 status);
+bool sdma_work_pending(struct sdma_engine *sde);
+
+/*
+ *
+ * The diagram below details the relationship of the mapping structures
+ *
+ * Since the mapping now allows for non-uniform engines per vl, the
+ * number of engines for a vl is either the vl_engines[vl] or
+ * a computation based on num_sdma/num_vls:
+ *
+ * For example:
+ * nactual = vl_engines ? vl_engines[vl] : num_sdma/num_vls
+ *
+ * n = roundup to next highest power of 2 using nactual
+ *
+ * In the case where there are num_sdma/num_vls doesn't divide
+ * evenly, the extras are added from the last vl downward.
+ *
+ * For the case where n > nactual, the engines are assigned
+ * in a round robin fashion wrapping back to the first engine
+ * for a particular vl.
+ *
+ *               dd->sdma_map
+ *                    |                                   sdma_map_elem[0]
+ *                    |                                +--------------------+
+ *                    v                                |       mask         |
+ *               sdma_vl_map                           |--------------------|
+ *      +--------------------------+                   | sde[0] -> eng 1    |
+ *      |    list (RCU)            |                   |--------------------|
+ *      |--------------------------|                 ->| sde[1] -> eng 2    |
+ *      |    mask                  |              --/  |--------------------|
+ *      |--------------------------|            -/     |        *           |
+ *      |    actual_vls (max 8)    |          -/       |--------------------|
+ *      |--------------------------|       --/         | sde[n-1] -> eng n  |
+ *      |    vls (max 8)           |     -/            +--------------------+
+ *      |--------------------------|  --/
+ *      |    map[0]                |-/
+ *      |--------------------------|                   +---------------------+
+ *      |    map[1]                |---                |       mask          |
+ *      |--------------------------|   \----           |---------------------|
+ *      |           *              |        \--        | sde[0] -> eng 1+n   |
+ *      |           *              |           \----   |---------------------|
+ *      |           *              |                \->| sde[1] -> eng 2+n   |
+ *      |--------------------------|                   |---------------------|
+ *      |   map[vls - 1]           |-                  |         *           |
+ *      +--------------------------+ \-                |---------------------|
+ *                                     \-              | sde[m-1] -> eng m+n |
+ *                                       \             +---------------------+
+ *                                        \-
+ *                                          \
+ *                                           \-        +----------------------+
+ *                                             \-      |       mask           |
+ *                                               \     |----------------------|
+ *                                                \-   | sde[0] -> eng 1+m+n  |
+ *                                                  \- |----------------------|
+ *                                                    >| sde[1] -> eng 2+m+n  |
+ *                                                     |----------------------|
+ *                                                     |         *            |
+ *                                                     |----------------------|
+ *                                                     | sde[o-1] -> eng o+m+n|
+ *                                                     +----------------------+
+ *
+ */
+
+/**
+ * struct sdma_map_elem - mapping for a vl
+ * @mask - selector mask
+ * @sde - array of engines for this vl
+ *
+ * The mask is used to "mod" the selector
+ * to produce index into the trailing
+ * array of sdes.
+ */
+struct sdma_map_elem {
+	u32 mask;
+	struct sdma_engine *sde[];
+};
+
+/**
+ * struct sdma_map_el - mapping for a vl
+ * @engine_to_vl - map of an engine to a vl
+ * @list - rcu head for free callback
+ * @mask - vl mask to "mod" the vl to produce an index to map array
+ * @actual_vls - number of vls
+ * @vls - number of vls rounded to next power of 2
+ * @map - array of sdma_map_elem entries
+ *
+ * This is the parent mapping structure.  The trailing
+ * members of the struct point to sdma_map_elem entries, which
+ * in turn point to an array of sde's for that vl.
+ */
+struct sdma_vl_map {
+	s8 engine_to_vl[TXE_NUM_SDMA_ENGINES];
+	struct rcu_head list;
+	u32 mask;
+	u8 actual_vls;
+	u8 vls;
+	struct sdma_map_elem *map[];
+};
+
+int sdma_map_init(struct hfi2_pportdata *ppd, u8 num_vls, u8 *vl_engines);
+
+/* slow path */
+void _sdma_engine_progress_schedule(struct sdma_engine *sde);
+
+/**
+ * sdma_engine_progress_schedule() - schedule progress on engine
+ * @sde: sdma_engine to schedule progress
+ *
+ * This is the fast path.
+ *
+ */
+static inline void sdma_engine_progress_schedule(
+	struct sdma_engine *sde)
+{
+	if (!sde || sdma_descq_inprocess(sde) < (sde->descq_cnt / 8))
+		return;
+	_sdma_engine_progress_schedule(sde);
+}
+
+struct sdma_engine *sdma_select_engine_sc(struct hfi2_pportdata *ppd,
+					  u32 selector, u8 sc5);
+struct sdma_engine *sdma_select_engine_vl(struct hfi2_pportdata *ppd,
+					  u32 selector, u8 vl);
+struct sdma_engine *sdma_select_user_engine(struct hfi2_pportdata *ppd,
+					    u32 selector, u8 vl);
+ssize_t sdma_get_cpu_to_sde_map(struct sdma_engine *sde, char *buf);
+ssize_t sdma_set_cpu_to_sde_map(struct sdma_engine *sde, const char *buf,
+				size_t count);
+int sdma_engine_get_vl(struct hfi2_pportdata *ppd, struct sdma_engine *sde);
+void sdma_seqfile_dump_sde(struct seq_file *s, struct sdma_engine *);
+void sdma_seqfile_dump_cpu_list(struct seq_file *s, struct hfi2_devdata *dd,
+				unsigned long cpuid);
+
+#ifdef CONFIG_SDMA_VERBOSITY
+void sdma_dumpstate(struct sdma_engine *);
+#endif
+static inline char *slashstrip(char *s)
+{
+	char *r = s;
+
+	while (*s)
+		if (*s++ == '/')
+			r = s;
+	return r;
+}
+
+u16 sdma_get_descq_cnt(void);
+
+extern uint mod_num_sdma;
+
+void sdma_update_lmc(struct hfi2_devdata *dd, u64 mask, u32 lid);
+#endif
diff --git a/drivers/infiniband/hw/hfi2/sdma_defs.h b/drivers/infiniband/hw/hfi2/sdma_defs.h
new file mode 100644
index 000000000000..4e1c7d23851a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/sdma_defs.h
@@ -0,0 +1,116 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2025 Cornelis Networks, Inc.
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#ifndef _HFI2_SDMA_DEFS_H
+#define _HFI2_SMDA_DEFS_H
+
+/* Hardware limit */
+#define MAX_DESC 64
+/* Hardware limit for SDMA packet size */
+#define MAX_SDMA_PKT_SIZE ((16 * 1024) - 1)
+
+#define SDMA_MAP_NONE          0
+#define SDMA_MAP_SINGLE        1
+#define SDMA_MAP_PAGE          2
+
+#define SDMA_MAP_BITS          2
+#define SDMA_MAP_MASK          ((1ull << SDMA_MAP_BITS) - 1)
+
+#define SDMA_AHG_VALUE_MASK          0xffff
+#define SDMA_AHG_VALUE_SHIFT         0
+#define SDMA_AHG_INDEX_MASK          0xf
+#define SDMA_AHG_INDEX_SHIFT         16
+#define SDMA_AHG_FIELD_LEN_MASK      0xf
+#define SDMA_AHG_FIELD_LEN_SHIFT     20
+#define SDMA_AHG_FIELD_START_MASK    0x1f
+#define SDMA_AHG_FIELD_START_SHIFT   24
+#define SDMA_AHG_UPDATE_ENABLE_MASK  0x1
+#define SDMA_AHG_UPDATE_ENABLE_SHIFT 31
+
+/* AHG modes */
+
+/*
+ * Be aware the ordering and values
+ * for SDMA_AHG_APPLY_UPDATE[123]
+ * are assumed in generating a skip
+ * count in submit_tx() in sdma.c
+ */
+#define SDMA_AHG_NO_AHG              0
+#define SDMA_AHG_COPY                1
+#define SDMA_AHG_APPLY_UPDATE1       2
+#define SDMA_AHG_APPLY_UPDATE2       3
+#define SDMA_AHG_APPLY_UPDATE3       4
+
+/*
+ * Bits defined in the send DMA descriptor.
+ */
+/* WFR SDMA header fields */
+#define WFR_SDMA_DESC0_FIRST_DESC_FLAG      BIT_ULL(63)
+#define WFR_SDMA_DESC0_LAST_DESC_FLAG       BIT_ULL(62)
+#define WFR_SDMA_DESC0_BYTE_COUNT_SHIFT     48
+#define WFR_SDMA_DESC0_BYTE_COUNT_WIDTH     14
+#define WFR_SDMA_DESC0_BYTE_COUNT_MASK \
+	((1ULL << WFR_SDMA_DESC0_BYTE_COUNT_WIDTH) - 1)
+#define WFR_SDMA_DESC0_BYTE_COUNT_SMASK \
+	(WFR_SDMA_DESC0_BYTE_COUNT_MASK << WFR_SDMA_DESC0_BYTE_COUNT_SHIFT)
+#define WFR_SDMA_DESC0_PHY_ADDR_SHIFT       0
+#define WFR_SDMA_DESC0_PHY_ADDR_WIDTH       48
+#define WFR_SDMA_DESC0_PHY_ADDR_MASK \
+	((1ULL << WFR_SDMA_DESC0_PHY_ADDR_WIDTH) - 1)
+#define WFR_SDMA_DESC0_PHY_ADDR_SMASK \
+	(WFR_SDMA_DESC0_PHY_ADDR_MASK << WFR_SDMA_DESC0_PHY_ADDR_SHIFT)
+
+/* JKR SDMA header fields */
+#define JKR_SDMA_DESC0_PHY_ADDR_SHIFT       0
+#define JKR_SDMA_DESC0_PHY_ADDR_WIDTH       58
+#define JKR_SDMA_DESC0_PHY_ADDR_MASK \
+	((1ULL << JKR_SDMA_DESC0_PHY_ADDR_WIDTH) - 1)
+#define JKR_SDMA_DESC0_PHY_ADDR_SMASK \
+	(JKR_SDMA_DESC0_PHY_ADDR_MASK << JKR_SDMA_DESC0_PHY_ADDR_SHIFT)
+
+#define JKR_SDMA_DESC1_FIRST_DESC_FLAG      BIT_ULL(31)
+#define JKR_SDMA_DESC1_LAST_DESC_FLAG       BIT_ULL(30)
+#define JKR_SDMA_DESC1_BYTE_COUNT_SHIFT     16
+#define JKR_SDMA_DESC1_BYTE_COUNT_WIDTH     14
+#define JKR_SDMA_DESC1_BYTE_COUNT_MASK \
+	((1ULL << JKR_SDMA_DESC1_BYTE_COUNT_WIDTH) - 1)
+#define JKR_SDMA_DESC1_BYTE_COUNT_SMASK \
+	(JKR_SDMA_DESC1_BYTE_COUNT_MASK << JKR_SDMA_DESC1_BYTE_COUNT_SHIFT)
+
+/* common SDMA header fields */
+#define SDMA_DESC1_HEADER_UPDATE1_SHIFT 32
+#define SDMA_DESC1_HEADER_UPDATE1_WIDTH 32
+#define SDMA_DESC1_HEADER_UPDATE1_MASK \
+	((1ULL << SDMA_DESC1_HEADER_UPDATE1_WIDTH) - 1)
+#define SDMA_DESC1_HEADER_UPDATE1_SMASK \
+	(SDMA_DESC1_HEADER_UPDATE1_MASK << SDMA_DESC1_HEADER_UPDATE1_SHIFT)
+#define SDMA_DESC1_HEADER_MODE_SHIFT    13
+#define SDMA_DESC1_HEADER_MODE_WIDTH    3
+#define SDMA_DESC1_HEADER_MODE_MASK \
+	((1ULL << SDMA_DESC1_HEADER_MODE_WIDTH) - 1)
+#define SDMA_DESC1_HEADER_MODE_SMASK \
+	(SDMA_DESC1_HEADER_MODE_MASK << SDMA_DESC1_HEADER_MODE_SHIFT)
+#define SDMA_DESC1_HEADER_INDEX_SHIFT   8
+#define SDMA_DESC1_HEADER_INDEX_WIDTH   5
+#define SDMA_DESC1_HEADER_INDEX_MASK \
+	((1ULL << SDMA_DESC1_HEADER_INDEX_WIDTH) - 1)
+#define SDMA_DESC1_HEADER_INDEX_SMASK \
+	(SDMA_DESC1_HEADER_INDEX_MASK << SDMA_DESC1_HEADER_INDEX_SHIFT)
+#define SDMA_DESC1_HEADER_DWS_SHIFT     4
+#define SDMA_DESC1_HEADER_DWS_WIDTH     4
+#define SDMA_DESC1_HEADER_DWS_MASK \
+	((1ULL << SDMA_DESC1_HEADER_DWS_WIDTH) - 1)
+#define SDMA_DESC1_HEADER_DWS_SMASK \
+	(SDMA_DESC1_HEADER_DWS_MASK << SDMA_DESC1_HEADER_DWS_SHIFT)
+#define SDMA_DESC1_GENERATION_SHIFT     2
+#define SDMA_DESC1_GENERATION_WIDTH     2
+#define SDMA_DESC1_GENERATION_MASK \
+	((1ULL << SDMA_DESC1_GENERATION_WIDTH) - 1)
+#define SDMA_DESC1_GENERATION_SMASK \
+	(SDMA_DESC1_GENERATION_MASK << SDMA_DESC1_GENERATION_SHIFT)
+#define SDMA_DESC1_INT_REQ_FLAG         BIT_ULL(1)
+#define SDMA_DESC1_HEAD_TO_HOST_FLAG    BIT_ULL(0)
+#endif /* _HFI2_SDMA_H */
diff --git a/drivers/infiniband/hw/hfi2/sdma_txreq.h b/drivers/infiniband/hw/hfi2/sdma_txreq.h
new file mode 100644
index 000000000000..8e56d94eead5
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/sdma_txreq.h
@@ -0,0 +1,104 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2016 Intel Corporation.
+ */
+
+#ifndef HFI2_SDMA_TXREQ_H
+#define HFI2_SDMA_TXREQ_H
+
+#include "sdma_defs.h"
+
+/* nominal descriptor count with expected padding */
+#define NUM_DESC 6
+
+/*
+ * struct sdma_desc - canonical fragment descriptor
+ *
+ * This is the descriptor carried in the tx request
+ * corresponding to each fragment.
+ *
+ */
+struct sdma_desc {
+	/* private:  don't use directly */
+	u64 qw[2];
+};
+
+/**
+ * struct sdma_txreq - the sdma_txreq structure (one per packet)
+ * @list: for use by user and by queuing for wait
+ *
+ * This is the representation of a packet which consists of some
+ * number of fragments.   Storage is provided to within the structure.
+ * for all fragments.
+ *
+ * The storage for the descriptors are automatically extended as needed
+ * when the currently allocation is exceeded.
+ *
+ * The user (Verbs or PSM) may overload this structure with fields
+ * specific to their use by putting this struct first in their struct.
+ * The method of allocation of the overloaded structure is user dependent
+ *
+ * The list is the only public field in the structure.
+ *
+ */
+
+#define SDMA_TXREQ_S_OK        0
+#define SDMA_TXREQ_S_SENDERROR 1
+#define SDMA_TXREQ_S_ABORTED   2
+#define SDMA_TXREQ_S_SHUTDOWN  3
+
+/* flags bits */
+#define SDMA_TXREQ_F_URGENT       0x0001
+#define SDMA_TXREQ_F_AHG_COPY     0x0002
+#define SDMA_TXREQ_F_USE_AHG      0x0004
+#define SDMA_TXREQ_F_VIP          0x0010
+
+struct sdma_txreq;
+typedef void (*callback_t)(struct sdma_txreq *, int);
+
+struct iowait;
+struct sdma_txreq {
+	struct list_head list;
+	/* private: */
+	struct sdma_desc *descp;
+	/* private: */
+	void *coalesce_buf;
+	/* private: */
+	struct iowait *wait;
+	/* private: */
+	callback_t                  complete;
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+	u64 sn;
+#endif
+	/* private: - used in coalesce/pad processing */
+	u16                         packet_len;
+	/* private: - down-counted to trigger last */
+	u16                         tlen;
+	/* private: */
+	u16                         num_desc;
+	/* private: */
+	u16                         desc_limit;
+	/* private: */
+	u16                         next_descq_idx;
+	/* private: */
+	u16 coalesce_idx;
+	/* private: flags */
+	u16                         flags;
+	/* number of no-op descriptors to add */
+	u8 num_pad;
+	/* number avail descriptors needed before coalesce or expansion */
+	u8 desc_margin;
+	/* packed bitfield with enough space for SDMA_MAP_* values
+	 * for up to 64 descriptors at 2 bits per descriptor
+	 */
+	DECLARE_BITMAP(map_type, SDMA_MAP_BITS * MAX_DESC);
+	/* private: */
+	struct sdma_desc descs[NUM_DESC];
+};
+
+static inline int sdma_txreq_built(struct sdma_txreq *tx)
+{
+	return tx->num_desc;
+}
+
+#endif                          /* HFI2_SDMA_TXREQ_H */
diff --git a/drivers/infiniband/hw/hfi2/tid_rdma.h b/drivers/infiniband/hw/hfi2/tid_rdma.h
new file mode 100644
index 000000000000..f3d55faa0277
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/tid_rdma.h
@@ -0,0 +1,320 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ *
+ */
+#ifndef HFI2_TID_RDMA_H
+#define HFI2_TID_RDMA_H
+
+#include <linux/circ_buf.h>
+#include "common.h"
+
+/* Add a convenience helper */
+#define CIRC_ADD(val, add, size) (((val) + (add)) & ((size) - 1))
+#define CIRC_NEXT(val, size) CIRC_ADD(val, 1, size)
+#define CIRC_PREV(val, size) CIRC_ADD(val, -1, size)
+
+#define TID_RDMA_MIN_SEGMENT_SIZE       BIT(18)   /* 256 KiB (for now) */
+#define TID_RDMA_MAX_SEGMENT_SIZE       BIT(18)   /* 256 KiB (for now) */
+#define TID_RDMA_MAX_PAGES              (BIT(18) >> PAGE_SHIFT)
+#define TID_RDMA_SEGMENT_SHIFT		18
+
+/*
+ * Bit definitions for priv->s_flags.
+ * These bit flags overload the bit flags defined for the QP's s_flags.
+ * Due to the fact that these bit fields are used only for the QP priv
+ * s_flags, there are no collisions.
+ *
+ * HFI2_S_TID_WAIT_INTERLCK - QP is waiting for requester interlock
+ * HFI2_R_TID_WAIT_INTERLCK - QP is waiting for responder interlock
+ */
+#define HFI2_S_TID_BUSY_SET       BIT(0)
+/* BIT(1) reserved for RVT_S_BUSY. */
+#define HFI2_R_TID_RSC_TIMER      BIT(2)
+/* BIT(3) reserved for RVT_S_RESP_PENDING. */
+/* BIT(4) reserved for RVT_S_ACK_PENDING. */
+#define HFI2_S_TID_WAIT_INTERLCK  BIT(5)
+#define HFI2_R_TID_WAIT_INTERLCK  BIT(6)
+/* BIT(7) - BIT(15) reserved for RVT_S_WAIT_*. */
+/* BIT(16) reserved for RVT_S_SEND_ONE */
+#define HFI2_S_TID_RETRY_TIMER    BIT(17)
+/* BIT(18) reserved for RVT_S_ECN. */
+#define HFI2_R_TID_SW_PSN         BIT(19)
+/* BIT(26) reserved for HFI2_S_WAIT_HALT */
+/* BIT(27) reserved for HFI2_S_WAIT_TID_RESP */
+/* BIT(28) reserved for HFI2_S_WAIT_TID_SPACE */
+
+/*
+ * Unlike regular IB RDMA VERBS, which do not require an entry
+ * in the s_ack_queue, TID RDMA WRITE requests do because they
+ * generate responses.
+ * Therefore, the s_ack_queue needs to be extended by a certain
+ * amount. The key point is that the queue needs to be extended
+ * without letting the "user" know so they user doesn't end up
+ * using these extra entries.
+ */
+#define HFI2_TID_RDMA_WRITE_CNT 8
+
+struct tid_rdma_params {
+	struct rcu_head rcu_head;
+	u32 qp;
+	u32 max_len;
+	u16 jkey;
+	u8 max_read;
+	u8 max_write;
+	u8 timeout;
+	u8 urg;
+	u8 version;
+};
+
+struct tid_rdma_qp_params {
+	struct work_struct trigger_work;
+	struct tid_rdma_params local;
+	struct tid_rdma_params __rcu *remote;
+};
+
+/* Track state for each hardware flow */
+struct tid_flow_state {
+	u32 generation;
+	u32 psn;
+	u8 index;
+	u8 last_index;
+};
+
+enum tid_rdma_req_state {
+	TID_REQUEST_INACTIVE = 0,
+	TID_REQUEST_INIT,
+	TID_REQUEST_INIT_RESEND,
+	TID_REQUEST_ACTIVE,
+	TID_REQUEST_RESEND,
+	TID_REQUEST_RESEND_ACTIVE,
+	TID_REQUEST_QUEUED,
+	TID_REQUEST_SYNC,
+	TID_REQUEST_RNR_NAK,
+	TID_REQUEST_COMPLETE,
+};
+
+struct tid_rdma_request {
+	struct rvt_qp *qp;
+	struct hfi2_ctxtdata *rcd;
+	union {
+		struct rvt_swqe *swqe;
+		struct rvt_ack_entry *ack;
+	} e;
+
+	struct tid_rdma_flow *flows;	/* array of tid flows */
+	struct rvt_sge_state ss; /* SGE state for TID RDMA requests */
+	u16 n_flows;		/* size of the flow buffer window */
+	u16 setup_head;		/* flow index we are setting up */
+	u16 clear_tail;		/* flow index we are clearing */
+	u16 flow_idx;		/* flow index most recently set up */
+	u16 acked_tail;
+
+	u32 seg_len;
+	u32 total_len;
+	u32 r_ack_psn;          /* next expected ack PSN */
+	u32 r_flow_psn;         /* IB PSN of next segment start */
+	u32 r_last_acked;       /* IB PSN of last ACK'ed packet */
+	u32 s_next_psn;		/* IB PSN of next segment start for read */
+
+	u32 total_segs;		/* segments required to complete a request */
+	u32 cur_seg;		/* index of current segment */
+	u32 comp_seg;           /* index of last completed segment */
+	u32 ack_seg;            /* index of last ack'ed segment */
+	u32 alloc_seg;          /* index of next segment to be allocated */
+	u32 isge;		/* index of "current" sge */
+	u32 ack_pending;        /* num acks pending for this request */
+
+	enum tid_rdma_req_state state;
+};
+
+/*
+ * When header suppression is used, PSNs associated with a "flow" are
+ * relevant (and not the PSNs maintained by verbs). Track per-flow
+ * PSNs here for a TID RDMA segment.
+ *
+ */
+struct flow_state {
+	u32 flags;
+	u32 resp_ib_psn;     /* The IB PSN of the response for this flow */
+	u32 generation;      /* generation of flow */
+	u32 spsn;            /* starting PSN in TID space */
+	u32 lpsn;            /* last PSN in TID space */
+	u32 r_next_psn;      /* next PSN to be received (in TID space) */
+
+	/* For tid rdma read */
+	u32 ib_spsn;         /* starting PSN in Verbs space */
+	u32 ib_lpsn;         /* last PSn in Verbs space */
+};
+
+struct tid_rdma_pageset {
+	dma_addr_t addr : 48; /* Only needed for the first page */
+	u8 idx: 8;
+	u8 count : 7;
+	u8 mapped: 1;
+};
+
+/**
+ * kern_tid_node - used for managing TID's in TID groups
+ *
+ * @grp_idx: rcd relative index to tid_group
+ * @map: grp->map captured prior to programming this TID group in HW
+ * @cnt: Only @cnt of available group entries are actually programmed
+ */
+struct kern_tid_node {
+	struct tid_group *grp;
+	u8 map;
+	u8 cnt;
+};
+
+/* Overall info for a TID RDMA segment */
+struct tid_rdma_flow {
+	/*
+	 * While a TID RDMA segment is being transferred, it uses a QP number
+	 * from the "KDETH section of QP numbers" (which is different from the
+	 * QP number that originated the request). Bits 11-15 of these QP
+	 * numbers identify the "TID flow" for the segment.
+	 */
+	struct flow_state flow_state;
+	struct tid_rdma_request *req;
+	u32 tid_qpn;
+	u32 tid_offset;
+	u32 length;
+	u32 sent;
+	u8 tnode_cnt;
+	u8 tidcnt;
+	u8 tid_idx;
+	u8 idx;
+	u8 npagesets;
+	u8 npkts;
+	u8 pkt;
+	u8 resync_npkts;
+	struct kern_tid_node tnode[TID_RDMA_MAX_PAGES];
+	struct tid_rdma_pageset pagesets[TID_RDMA_MAX_PAGES];
+	u32 tid_entry[TID_RDMA_MAX_PAGES];
+};
+
+enum tid_rnr_nak_state {
+	TID_RNR_NAK_INIT = 0,
+	TID_RNR_NAK_SEND,
+	TID_RNR_NAK_SENT,
+};
+
+bool tid_rdma_conn_req(struct rvt_qp *qp, u64 *data);
+bool tid_rdma_conn_reply(struct rvt_qp *qp, u64 data);
+bool tid_rdma_conn_resp(struct rvt_qp *qp, u64 *data);
+void tid_rdma_conn_error(struct rvt_qp *qp);
+void tid_rdma_opfn_init(struct rvt_qp *qp, struct tid_rdma_params *p);
+
+int hfi2_kern_exp_rcv_init(struct hfi2_ctxtdata *rcd, int reinit);
+int hfi2_kern_exp_rcv_setup(struct tid_rdma_request *req,
+			    struct rvt_sge_state *ss, bool *last);
+int hfi2_kern_exp_rcv_clear(struct tid_rdma_request *req);
+void hfi2_kern_exp_rcv_clear_all(struct tid_rdma_request *req);
+void __trdma_clean_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe);
+
+/**
+ * trdma_clean_swqe - clean flows for swqe if large send queue
+ * @qp: the qp
+ * @wqe: the send wqe
+ */
+static inline void trdma_clean_swqe(struct rvt_qp *qp, struct rvt_swqe *wqe)
+{
+	if (!wqe->priv)
+		return;
+	__trdma_clean_swqe(qp, wqe);
+}
+
+void hfi2_kern_read_tid_flow_free(struct rvt_qp *qp);
+
+struct hfi2_ctxtdata *qp_to_rcd(struct rvt_qp *qp);
+int hfi2_qp_priv_init(struct rvt_dev_info *rdi, struct rvt_qp *qp,
+		      struct ib_qp_init_attr *init_attr);
+void hfi2_qp_priv_tid_free(struct rvt_dev_info *rdi, struct rvt_qp *qp);
+
+void hfi2_tid_rdma_flush_wait(struct rvt_qp *qp);
+
+int hfi2_kern_setup_hw_flow(struct hfi2_ctxtdata *rcd, struct rvt_qp *qp);
+void hfi2_kern_clear_hw_flow(struct hfi2_ctxtdata *rcd, struct rvt_qp *qp);
+void hfi2_kern_init_ctxt_generations(struct hfi2_ctxtdata *rcd);
+
+struct cntr_entry;
+u64 hfi2_access_sw_tid_wait(const struct cntr_entry *entry,
+			    void *context, int vl, int mode, u64 data);
+
+u32 hfi2_build_tid_rdma_read_packet(struct rvt_swqe *wqe,
+				    struct ib_other_headers *ohdr,
+				    u32 *bth1, u32 *bth2, u32 *len);
+u32 hfi2_build_tid_rdma_read_req(struct rvt_qp *qp, struct rvt_swqe *wqe,
+				 struct ib_other_headers *ohdr, u32 *bth1,
+				 u32 *bth2, u32 *len);
+void hfi2_rc_rcv_tid_rdma_read_req(struct hfi2_packet *packet);
+u32 hfi2_build_tid_rdma_read_resp(struct rvt_qp *qp, struct rvt_ack_entry *e,
+				  struct ib_other_headers *ohdr, u32 *bth0,
+				  u32 *bth1, u32 *bth2, u32 *len, bool *last);
+void hfi2_rc_rcv_tid_rdma_read_resp(struct hfi2_packet *packet);
+bool hfi2_handle_kdeth_eflags(struct hfi2_ctxtdata *rcd,
+			      struct hfi2_pportdata *ppd,
+			      struct hfi2_packet *packet);
+void hfi2_tid_rdma_restart_req(struct rvt_qp *qp, struct rvt_swqe *wqe,
+			       u32 *bth2);
+void hfi2_qp_kern_exp_rcv_clear_all(struct rvt_qp *qp);
+bool hfi2_tid_rdma_wqe_interlock(struct rvt_qp *qp, struct rvt_swqe *wqe);
+
+void setup_tid_rdma_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe);
+static inline void hfi2_setup_tid_rdma_wqe(struct rvt_qp *qp,
+					   struct rvt_swqe *wqe)
+{
+	if (wqe->priv &&
+	    (wqe->wr.opcode == IB_WR_RDMA_READ ||
+	     wqe->wr.opcode == IB_WR_RDMA_WRITE) &&
+	    wqe->length >= TID_RDMA_MIN_SEGMENT_SIZE)
+		setup_tid_rdma_wqe(qp, wqe);
+}
+
+u32 hfi2_build_tid_rdma_write_req(struct rvt_qp *qp, struct rvt_swqe *wqe,
+				  struct ib_other_headers *ohdr,
+				  u32 *bth1, u32 *bth2, u32 *len);
+
+void hfi2_rc_rcv_tid_rdma_write_req(struct hfi2_packet *packet);
+
+u32 hfi2_build_tid_rdma_write_resp(struct rvt_qp *qp, struct rvt_ack_entry *e,
+				   struct ib_other_headers *ohdr, u32 *bth1,
+				   u32 bth2, u32 *len,
+				   struct rvt_sge_state **ss);
+
+void hfi2_del_tid_reap_timer(struct rvt_qp *qp);
+
+void hfi2_rc_rcv_tid_rdma_write_resp(struct hfi2_packet *packet);
+
+bool hfi2_build_tid_rdma_packet(struct rvt_swqe *wqe,
+				struct ib_other_headers *ohdr,
+				u32 *bth1, u32 *bth2, u32 *len);
+
+void hfi2_rc_rcv_tid_rdma_write_data(struct hfi2_packet *packet);
+
+u32 hfi2_build_tid_rdma_write_ack(struct rvt_qp *qp, struct rvt_ack_entry *e,
+				  struct ib_other_headers *ohdr, u16 iflow,
+				  u32 *bth1, u32 *bth2);
+
+void hfi2_rc_rcv_tid_rdma_ack(struct hfi2_packet *packet);
+
+void hfi2_add_tid_retry_timer(struct rvt_qp *qp);
+void hfi2_del_tid_retry_timer(struct rvt_qp *qp);
+
+u32 hfi2_build_tid_rdma_resync(struct rvt_qp *qp, struct rvt_swqe *wqe,
+			       struct ib_other_headers *ohdr, u32 *bth1,
+			       u32 *bth2, u16 fidx);
+
+void hfi2_rc_rcv_tid_rdma_resync(struct hfi2_packet *packet);
+
+struct hfi2_pkt_state;
+int hfi2_make_tid_rdma_pkt(struct rvt_qp *qp, struct hfi2_pkt_state *ps);
+
+void _hfi2_do_tid_send(struct work_struct *work);
+
+bool hfi2_schedule_tid_send(struct rvt_qp *qp);
+
+bool hfi2_tid_rdma_ack_interlock(struct rvt_qp *qp, struct rvt_ack_entry *e);
+
+#endif /* HFI2_TID_RDMA_H */
diff --git a/drivers/infiniband/hw/hfi2/user_exp_rcv.h b/drivers/infiniband/hw/hfi2/user_exp_rcv.h
new file mode 100644
index 000000000000..c4f0dab6e7b6
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_exp_rcv.h
@@ -0,0 +1,404 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2020-2024 Cornelis Networks, Inc.
+ * Copyright(c) 2015 - 2017 Intel Corporation.
+ */
+
+#ifndef _HFI2_USER_EXP_RCV_H
+#define _HFI2_USER_EXP_RCV_H
+
+#include "hfi2.h"
+#include "exp_rcv.h"
+
+struct hfi2_page_iter_ops;
+
+/**
+ * Base type for iterating over sets of pinned-page ranges (pagesets).
+ *
+ * Depending on implementation, pages may also already be DMA-mapped.
+ */
+struct hfi2_page_iter {
+	struct hfi2_page_iter_ops *ops;
+};
+
+struct hfi2_page_iter_ops {
+	/**
+	 * Advance iterator to next pageset.
+	 *
+	 * Implementation must construct TID-compatible pagesets. TID-compatible means:
+	 * - starting address is 4KiB-aligned.
+	 * - size in range of [4KiB,2MiB].
+	 * - size is a power-of-two.
+	 *
+	 * @return > 0 on successful advancement, 0 when iterator is at last
+	 * element, < 0 on error. It is an error to call .next() after it
+	 * returns 0.
+	 */
+	int (*next)(struct hfi2_page_iter *iter);
+
+	void (*free)(struct hfi2_page_iter *iter);
+};
+
+struct tid_user_buf;
+
+/*
+ * hfi2_page_iter implementation for tid_system.
+ *
+ * Built around struct tid_user_buf->{psets,n_psets}.
+ */
+struct page_array_iter {
+	struct hfi2_page_iter common;
+	struct tid_user_buf *tbuf;
+	unsigned int setidx;
+};
+
+/*
+ * structs tid_pageset, tid_user_buf, tid_rb_node, tid_user_buf_ops,
+ * tid_node_ops - Generic memory-pinning and DMA-mapping datastructures and
+ * interfaces for user expected receive.
+ *
+ * Here's a high-level flow of how generic device user expected receive works:
+ * 1. Available memory implementations are registered at driver load.
+ * 2. When TID_UPDATE with memory type information is received,
+ *    struct tid_user_buf_ops* for memory type is looked up.
+ * 3. struct tid_user_buf 'tbuf' is created using tid_user_buf_ops.init(),
+ *    passing in the virtual address range from userspace.
+ * 4. Pages are pinned using tid_user_buf_ops.pin_pages(tbuf).
+ * 5. tid_user_buf_ops.find_phys_blocks() produces an array of sets
+ *    (struct tid_pageset[]) of physically contiguous pages.
+ * 6. struct tid_node_ops* for memory type is looked up.
+ * 7. For each set of physically contiguous pinned pages:
+ *    7.1 A struct tid_rb_node is created using tid_node_ops.init(). It stores
+ *        its memory type for later lookup.
+ *    7.2 tid_node_ops.init() DMA-maps the physically-contiguous page range.
+ *    7.3 An expected RcvArray entry (TID) is programmed with the DMA address.
+ *    7.4 The tid_rb_node* is stored in struct hfi2_filedata.entry_to_rb[].
+ * 8. The tid_user_buf is no longer needed and is destroyed.
+ * 9. When a TID is to be unmapped or the receive memory the TID is programmed
+ *    for is invalidated, the struct tid_rb_node* for the TID or receive memory
+ *    is found, the struct tid_node_ops looked up, and
+ *    tid_node_ops.dma_unmap(node) and tid_node_ops.free(node) called.
+ *
+ * This is an overview. See struct tid_user_buf_ops and struct tid_node_ops for
+ * the methods and their semantics that an implementation must provide.
+ */
+
+struct tid_pageset {
+	u16 idx;
+	u16 count;
+};
+
+struct tid_node_ops;
+struct tid_user_buf_ops;
+
+struct tid_user_buf {
+	unsigned long vaddr;
+	unsigned long length;
+	struct tid_pageset *psets;
+	struct tid_user_buf_ops *ops;
+	unsigned int n_psets;
+	bool use_mn;
+	u16 type; /* Implementation must set to HFI2_MEMINFO_TYPE* in tid_user_buf_ops.init() */
+};
+
+int tid_user_buf_init(u16 pset_size, unsigned long vaddr, unsigned long length, bool notify,
+		      struct tid_user_buf_ops *ops, u16 type, struct tid_user_buf *tbuf);
+void tid_user_buf_free(struct tid_user_buf *tbuf);
+
+struct tid_rb_node {
+	struct hfi2_filedata *fdata;
+	struct mutex invalidate_mutex; /* covers hw removal */
+	/* Only used for debug and tracing */
+	unsigned long phys;
+	struct tid_group *grp;
+	struct tid_node_ops *ops;
+	dma_addr_t dma_addr;
+	/* Starting virtual address for this node's page range */
+	unsigned long vaddr;
+	/* Number of pages, implementation-sized */
+	unsigned int npages;
+	/* Implementation page-size shift */
+	unsigned int page_shift;
+	u32 rcventry;
+	bool use_mn;
+	bool freed;
+	/* Implementation must set to HFI2_MEMINFO_TYPE* in tid_node_ops.init() */
+	u16 type;
+};
+
+/**
+ * User expected receive requires @vaddr from userspace be aligned on a page
+ * boundary.
+ *
+ * User expected receive requires this because it cannot communicate the offset
+ * between @vaddr and the page start.
+ *
+ * TID memory implementation must check that @vaddr is aligned on a page
+ * boundary but may delay this check until as late as .pin_pages().
+ *
+ * This allows for implementations where the page size is not known until the
+ * pages are pinned.
+ */
+struct tid_user_buf_ops {
+	/**
+	 * Allocate and initialize @*tbuf.
+	 *
+	 * Implementation must initialize:
+	 *   - vaddr
+	 *   - length
+	 *   - psets
+	 *   - ops
+	 *   - type
+	 *
+	 * @expected_count
+	 * @notify when false, implementation may use invalidation callback
+	 *   underneath.
+	 *
+	 *   When true, implementation must use invalidation callback
+	 *   underneath.
+	 *
+	 *   If true and implementation does not have an invalidation callback,
+	 *   must return an error.
+	 * @vaddr
+	 * @length
+	 * @allow_unaligned when true, implementation may, but is not required
+	 *   to, handle unaligned @vaddr. When false, implementation must return
+	 *   -EINVAL for unaligned @vaddr.
+	 * @tbuf [out] allocated tid_user_buf
+	 *
+	 * @return 0 on success, non-zero on error.
+	 *
+	 * Errors including but not limited to:
+	 * - Number of pages based on @length too long for @expected_count
+	 * - @vaddr is not suitably aligned
+	 * - @length invalid for implementation
+	 * - @notify is true but implementation does not support
+	 *   memory-invalidation notification
+	 */
+	int (*init)(u16 expected_count,
+		    bool notify,
+		    unsigned long vaddr,
+		    unsigned long length,
+		    bool allow_unaligned,
+		    struct tid_user_buf **tbuf);
+
+	/**
+	 * Free @tbuf.
+	 */
+	void (*free)(struct tid_user_buf *tbuf);
+
+	/**
+	 * Pin pages for @tbuf based on (@vaddr,@length) passed into
+	 * @tid_user_buf_ops.init().
+	 *
+	 * Implementation may also DMA-map pages at this time.
+	 *
+	 * Implementation may store @fd at this time.
+	 *
+	 * @fd
+	 * @tbuf
+	 *
+	 * @return > 0 number of pages pinned on success, < 0 error value on
+	 *   failure. 0 is treated as a failure but not an error value.
+	 */
+	int (*pin_pages)(struct hfi2_filedata *fd, struct tid_user_buf *tbuf);
+
+	/**
+	 * Get page size of @tbuf's pinned pages.
+	 *
+	 * Caller should not assume that page size is known until after
+	 * pin_pages(fd, @tbuf).
+	 *
+	 * @tbuf
+	 *
+	 * @return page size. No way to tell if error.
+	 */
+	unsigned int (*page_size)(struct tid_user_buf *tbuf);
+
+	/**
+	 * Unpin only @npages starting at @idx.
+	 *
+	 * Implementation may implement partial unpinning.
+	 *
+	 * If not, implementation must ensure that pages are unmapped and
+	 * unpinned when last reference to them is released.
+	 *
+	 * @fd Same fd as given in tid_user_buf_ops.pin_pages() call
+	 * @tbuf
+	 * @idx
+	 * @npages
+	 */
+	void (*unpin_pages)(struct hfi2_filedata *fd,
+			    struct tid_user_buf *tbuf,
+			    unsigned int idx,
+			    unsigned int npages);
+
+	/**
+	 * Optional; implementation must either implement find_phys_blocks() or
+	 * ensure that iter_begin() will return a valid iterator after
+	 * .pin_pages().
+	 *
+	 * Implementation must program @tbuf->psets elements such that:
+	 * 1. All pages in a pageset are physically contiguous
+	 * 2. All pages in all pagesets have the same page size
+	 * 3. The total size of a pageset is a power-of-two in the range
+	 *    [4KiB, 2MiB]
+	 *
+	 * Implementation must set @tbuf->n_psets to number of page sets
+	 * programmed.
+	 *
+	 * @tbuf TID user buf to set (@tbuf->psets,@tbuf->n_psets) on.
+	 * @npages limit on number of pages to process into page sets before
+	 *         stopping.
+	 *
+	 * @return 0 on success, non-zero on error
+	 */
+	int (*find_phys_blocks)(struct tid_user_buf *tbuf,
+				unsigned int npages);
+
+	/**
+	 * @return true when:
+	 * - @tbuf's virtual->physical mapping has been invalidated
+	 * - @tbuf's physical pages have been released
+	 */
+	bool (*invalidated)(struct tid_user_buf *tbuf);
+
+	/**
+	 * Unregister memory-invalidation callback registered in struct
+	 * tid_user_buf_ops.init() implementation.
+	 */
+	void (*unnotify)(struct tid_user_buf *tbuf);
+
+	/**
+	 * Optional. Get pageset iterator. Pages in pageset must be pinned and
+	 * physically-contiguous. Whether pages are also DMA-mapped at the time
+	 * this method is called is implementation-dependent.
+	 *
+	 * Implementation must return iterator only if there is at least one
+	 * pageset to iterate over. I.e. it is an error if implementation
+	 * cannot return an iterator over at least one pageset.
+	 *
+	 * Returned iterator must be freed with @hfi2_page_iter->ops->free().
+	 *
+	 * @return pointer on success, ERR_PTR() on error.
+	 */
+	struct hfi2_page_iter *(*iter_begin)(struct tid_user_buf *tbuf);
+};
+
+struct tid_node_ops {
+	/**
+	 * Create tid_rb_node for pageset given by @iter.
+	 *
+	 * .init() implementation must initialize the following
+	 *   - fdata
+	 *   - invalidate_mutex
+	 *   - phys
+	 *   - grp
+	 *   - ops
+	 *   - dma_addr
+	 *   - vaddr
+	 *   - npages
+	 *   - page_shift: may not be less than EXP_TID_ADDR_SHIFT
+	 *   - rcventry
+	 *   - use_mn
+	 *   - freed
+	 *   - type: one of the HFI2_MEMINFO_TYPE* defines
+	 *
+	 * Pages in pageset given by @iter must be TID-ready: pinned, physically contiguous,
+	 * 4KiB <= size <= 2MiB, starting address is power-of-two.
+	 *
+	 * Implementation must DMA-map the pages given by @iter if they are not DMA-mapped
+	 * already.
+	 *
+	 * If @fd->use_mn is true and memory implementation does not support
+	 * invalidation callbacks, .init() must return an error.
+	 *
+	 * @fd
+	 * @tbuf Contains larger memory pinning to create TID entry from
+	 * @rcventry
+	 * @grp
+	 * @iter
+	 *
+	 * @return allocated node on success, ERR_PTR() on error.
+	 */
+	struct tid_rb_node *(*init)(struct hfi2_filedata *fd,
+				    struct tid_user_buf *tbuf,
+				    u32 rcventry,
+				    struct tid_group *grp,
+				    struct hfi2_page_iter *iter);
+
+	/**
+	 * Free @node.
+	 */
+	void (*free)(struct tid_rb_node *node);
+
+	/**
+	 * Register for memory invalidation callback. Implementation should
+	 * only register for notification on @node's page-range.
+	 *
+	 * When @node->fdata->use_mn is true, invalidation callback must call
+	 * hfi2_user_exp_rcv_invalidate(@node).
+	 *
+	 * When @node->fdata->use_mn is false, invalidation callback may call
+	 * hfi2_user_exp_rcv_invalidate(@node).
+	 *
+	 * Should be no-op when implementation does not support partial
+	 * unpinning.
+	 *
+	 * @return 0 on success, non-zero on failure.
+	 */
+	int (*register_notify)(struct tid_rb_node *node);
+
+	/**
+	 * Unregister from memory-invalidation callback in anticipation of
+	 * unprogramming TID.
+	 *
+	 * Should be no-op when implementation does not support partial
+	 * unpinning.
+	 *
+	 * Not safe to call more than once per register_notify() call.
+	 */
+	void (*unregister_notify)(struct tid_rb_node *node);
+
+	/**
+	 * DMA-unmap mapped memory for @node.
+	 *
+	 * Should be no-op when implementation does not support partial
+	 * unmapping.
+	 */
+	void (*dma_unmap)(struct tid_rb_node *node);
+
+	/**
+	 * Unpin pages covered by @node.
+	 *
+	 * user_exp_rcv will call this function under node->invalidate_mutex.
+	 * user_exp_rcv will only call this function once per node.
+	 *
+	 * Should be no-op when implementation does not support partial
+	 * unpinning.
+	 */
+	void (*unpin_pages)(struct hfi2_filedata *fd, struct tid_rb_node *node);
+};
+
+int register_tid_ops(u16 type, struct tid_user_buf_ops *op, struct tid_node_ops *nops);
+void deregister_tid_ops(u16 type);
+
+int register_system_tid_ops(void);
+void deregister_system_tid_ops(void);
+
+void hfi2_user_exp_rcv_invalidate(struct tid_rb_node *node);
+
+int hfi2_user_exp_rcv_init(struct hfi2_filedata *fd,
+			   struct hfi2_ctxtdata *uctxt);
+void hfi2_user_exp_rcv_free(struct hfi2_filedata *fd);
+int hfi2_user_exp_rcv_setup(struct hfi2_filedata *fd,
+			    struct hfi2_tid_info *tinfo,
+			    bool allow_unaligned,
+			    bool do_tidcnt_check);
+int hfi2_user_exp_rcv_clear(struct hfi2_filedata *fd,
+			    struct hfi1_tid_info *tinfo);
+int hfi2_user_exp_rcv_invalid(struct hfi2_filedata *fd,
+			      struct hfi1_tid_info *tinfo,
+			      bool do_tidcnt_check);
+
+#endif /* _HFI2_USER_EXP_RCV_H */
diff --git a/drivers/infiniband/hw/hfi2/user_sdma.h b/drivers/infiniband/hw/hfi2/user_sdma.h
new file mode 100644
index 000000000000..971b574a0b47
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_sdma.h
@@ -0,0 +1,262 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2023 - Cornelis Networks, Inc.
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+#ifndef _HFI2_USER_SDMA_H
+#define _HFI2_USER_SDMA_H
+
+#include <linux/device.h>
+#include <linux/wait.h>
+
+#include "common.h"
+#include "iowait.h"
+#include "user_exp_rcv.h"
+#include "mmu_rb.h"
+#include "pinning.h"
+#include "sdma.h"
+
+/* The maximum number of Data io vectors per message/request */
+#define MAX_VECTORS_PER_REQ 8
+static_assert(MAX_VECTORS_PER_REQ <= HFI2_MAX_MEMINFO_ENTRIES);
+
+/*
+ * Maximum number of packet to send from each message/request
+ * before moving to the next one.
+ */
+#define MAX_PKTS_PER_QUEUE 16
+
+#define num_pages(x) (1 + ((((x) - 1) & PAGE_MASK) >> PAGE_SHIFT))
+
+#define req_opcode(x) \
+	(((x) >> HFI2_SDMA_REQ_OPCODE_SHIFT) & HFI2_SDMA_REQ_OPCODE_MASK)
+#define req_version(x) \
+	(((x) >> HFI2_SDMA_REQ_VERSION_SHIFT) & HFI2_SDMA_REQ_OPCODE_MASK)
+#define req_iovcnt(x) \
+	(((x) >> HFI2_SDMA_REQ_IOVCNT_SHIFT) & HFI2_SDMA_REQ_IOVCNT_MASK)
+#define req_has_meminfo(x) \
+	(((x) >> HFI2_SDMA_REQ_MEMINFO_SHIFT) & HFI2_SDMA_REQ_MEMINFO_MASK)
+
+/* Number of BTH.PSN bits used for sequence number in expected rcvs */
+#define BTH_SEQ_MASK 0x7ffull
+
+#define AHG_KDETH_INTR_SHIFT 12
+#define AHG_KDETH_SH_SHIFT   13
+#define AHG_KDETH_ARRAY_SIZE  9
+
+/**
+ * Build an SDMA AHG header update descriptor and save it to an array.
+ * @arr        - Array to save the descriptor to.
+ * @idx        - Index of the array at which the descriptor will be saved.
+ * @array_size - Size of the array arr.
+ * @dw         - Update index into the header in DWs.
+ * @bit        - Start bit.
+ * @width      - Field width.
+ * @value      - 16 bits of immediate data to write into the field.
+ * Returns -ERANGE if idx is invalid. If successful, returns the next index
+ * (idx + 1) of the array to be used for the next descriptor.
+ */
+static inline int ahg_header_set(u32 *arr, int idx, size_t array_size,
+				 u8 dw, u8 bit, u8 width, u16 value)
+{
+	if ((size_t)idx >= array_size)
+		return -ERANGE;
+	arr[idx++] = sdma_build_ahg_descriptor(value, dw, bit, width);
+	return idx;
+}
+
+/* Tx request flag bits */
+#define TXREQ_FLAGS_REQ_ACK   BIT(0)      /* Set the ACK bit in the header */
+#define TXREQ_FLAGS_REQ_DISABLE_SH BIT(1) /* Disable header suppression */
+
+enum pkt_q_sdma_state {
+	SDMA_PKT_Q_ACTIVE,
+	SDMA_PKT_Q_DEFERRED,
+};
+
+#define SDMA_IOWAIT_TIMEOUT 1000 /* in milliseconds */
+
+#define SDMA_DBG(req, fmt, ...)				     \
+	hfi2_cdbg(SDMA, "[%u:%u:%u:%u] " fmt, (req)->pq->dd->unit, \
+		 (req)->pq->ctxt, (req)->pq->subctxt, (req)->info.comp_idx, \
+		 ##__VA_ARGS__)
+
+struct hfi2_user_sdma_pkt_q {
+	u16 ctxt;
+	u16 subctxt;
+	u16 n_max_reqs;
+	atomic_t n_reqs;
+	struct hfi2_devdata *dd;
+	struct kmem_cache *txreq_cache;
+	struct user_sdma_request *reqs;
+	unsigned long *req_in_use;
+	struct iowait busy;
+	enum pkt_q_sdma_state state;
+	wait_queue_head_t wait;
+	unsigned long unpinned;
+	struct pinning_state pinning_state;
+	atomic_t n_locked;
+};
+
+struct hfi2_user_sdma_comp_q {
+	u16 nentries;
+	struct hfi2_sdma_comp_entry *comps;
+};
+
+struct user_sdma_iovec {
+	struct iovec iov;
+	/* memory type for this vector */
+	unsigned int type;
+	/* memory type context for this vector */
+	u64 context;
+	/*
+	 * offset into the virtual address space of the vector at
+	 * which we last left off.
+	 */
+	u64 offset;
+};
+
+/* evict operation argument */
+struct evict_data {
+	u32 cleared;	/* count evicted so far */
+	u32 target;	/* target count to evict */
+};
+
+/*
+ * User 16B header.  Differences between this and struct hfi2_pkt_hdr:
+ * o LRH size: 16 bytes vs 8 bytes
+ * o LRH byte ordering: LE vs BE
+ * o LRH units: 32 bits vs 16 bits
+ */
+struct hfi2_pkt_header16b {
+	__le16 pbc[4];
+	__le32 lrh[4];
+	__be32 bth[3];
+	struct hfi2_kdeth_header kdeth;
+} __packed;
+
+union user_pkt_header {
+	__le16 pbc[4];
+	struct hfi2_pkt_header hdr9b;
+	struct hfi2_pkt_header16b hdr16b;
+};
+
+/* Pinning-cache entry reference type */
+struct user_sdma_pinref {
+	void *ptr;
+	u16 memtype;
+	/** Used for determining eviction eligibility; set from &user_sdma_request.seqnum */
+	u16 req_seqnum;
+	/** Used for determining most-recently used; set from &user_sdma_request.pinrefs_seqnum */
+	u16 pinref_seqnum;
+};
+
+#define PINREF_ENTRIES 7
+
+struct user_sdma_request {
+	/* This is the original header from user space */
+	union user_pkt_header h;
+	unsigned long hsize;
+	u32 lrh_len_bytes;
+	u32 pad_mask;
+
+	/* Memory type information for each data iovec entry. */
+	struct sdma_req_meminfo meminfo;
+
+	/* Read mostly fields */
+	struct hfi2_user_sdma_pkt_q *pq ____cacheline_aligned_in_smp;
+	struct hfi2_user_sdma_comp_q *cq;
+	/*
+	 * Pointer to the SDMA engine for this request.
+	 * Since different request could be on different VLs,
+	 * each request will need it's own engine pointer.
+	 */
+	struct sdma_engine *sde;
+	struct sdma_req_info info;
+	/* TID array values copied from the tid_iov vector */
+	u32 *tids;
+	/* total length of the data in the request */
+	u32 data_len;
+	/* number of elements copied to the tids array */
+	u16 n_tids;
+	/*
+	 * We copy the iovs for this request (based on
+	 * info.iovcnt). These are only the data vectors
+	 */
+	u8 data_iovs;
+	s8 ahg_idx;
+
+	/* Writeable fields shared with interrupt */
+	u16 seqcomp ____cacheline_aligned_in_smp;
+	u16 seqsubmitted;
+
+	/* Send side fields */
+	struct list_head txps ____cacheline_aligned_in_smp;
+	u16 seqnum;
+	/*
+	 * KDETH.OFFSET (TID) field
+	 * The offset can cover multiple packets, depending on the
+	 * size of the TID entry.
+	 */
+	u32 tidoffset;
+	/*
+	 * KDETH.Offset (Eager) field
+	 * We need to remember the initial value so the headers
+	 * can be updated properly.
+	 */
+	u32 koffset;
+	u32 sent;
+	/* TID index copied from the tid_iov vector */
+	u16 tididx;
+	/* progress index moving along the iovs array */
+	u8 iov_idx;
+	u8 has_error;
+	/* possible appended bytes (16B ICRC QW) */
+	u8 tailsize;
+	/* true if this is a 16B request */
+	bool is16b;
+
+	u16 n_pinrefs;
+	/*
+	 * Since regular .seqnum is only incremented per-txreq, need separate
+	 * .pinref_seqnum to distinguish age of pinrefs within a txreq.
+	 */
+	u32 pinref_seqnum;
+	/* Shared space for storing pin_* cacherefs */
+	struct user_sdma_pinref pinrefs[PINREF_ENTRIES];
+
+	struct user_sdma_iovec iovs[MAX_VECTORS_PER_REQ];
+} ____cacheline_aligned_in_smp;
+
+/*
+ * A single txreq could span up to 3 physical pages when the MTU
+ * is sufficiently large (> 4K). Each of the IOV pointers also
+ * needs it's own set of flags so the vector has been handled
+ * independently of each other.
+ */
+struct user_sdma_txreq {
+	/* Packet header for the txreq */
+	union user_pkt_header h;
+	struct sdma_txreq txreq;
+	struct user_sdma_request *req;
+	struct user_sdma_pinref *pinrefs;
+	u16 n_pinrefs;
+	u16 flags;
+	u16 seqnum;
+};
+
+int hfi2_user_sdma_add_ref(struct user_sdma_txreq *tx, void *ptr,
+			   u16 memtype);
+struct user_sdma_pinref *hfi2_user_sdma_mru_ref(struct user_sdma_txreq *tx,
+						u16 memtype);
+void hfi2_user_sdma_touch_ref(struct user_sdma_txreq *tx,
+			      struct user_sdma_pinref *d);
+
+int hfi2_user_sdma_alloc_queues(struct hfi2_ctxtdata *uctxt,
+				struct hfi2_filedata *fd);
+int hfi2_user_sdma_free_queues(struct hfi2_filedata *fd,
+			       struct hfi2_ctxtdata *uctxt);
+int hfi2_user_sdma_process_request(struct hfi2_filedata *fd,
+				   struct iovec *iovec, unsigned long dim,
+				   unsigned long *count);
+#endif /* _HFI2_USER_SDMA_H */
diff --git a/drivers/infiniband/hw/hfi2/uverbs.h b/drivers/infiniband/hw/hfi2/uverbs.h
new file mode 100644
index 000000000000..684a0b311420
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/uverbs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2024 Cornelis Networks, Inc.
+ */
+
+#ifndef HFI2_UVERBS_H
+#define HFI2_UVERBS_H
+
+#include <rdma/uverbs_ioctl.h>
+
+int hfi2_alloc_ucontext(struct ib_ucontext *ucontext, struct ib_udata *udata);
+void hfi2_dealloc_ucontext(struct ib_ucontext *ucontext);
+int hfi2_rdma_mmap(struct ib_ucontext *ucontext, struct vm_area_struct *vma);
+ssize_t hfi2_uverbs_write_iter(struct ib_ucontext *ucontext,
+			       struct iov_iter *from);
+
+extern const struct uapi_definition hfi2_ib_defs[];
+
+#endif /* HFI2_UVERBS_H */
diff --git a/drivers/infiniband/hw/hfi2/verbs.h b/drivers/infiniband/hw/hfi2/verbs.h
new file mode 100644
index 000000000000..b94d8c70377d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/verbs.h
@@ -0,0 +1,488 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#ifndef HFI2_VERBS_H
+#define HFI2_VERBS_H
+
+#include <linux/types.h>
+#include <linux/seqlock.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/kref.h>
+#include <linux/workqueue.h>
+#include <linux/kthread.h>
+#include <linux/completion.h>
+#include <linux/slab.h>
+#include <rdma/ib_pack.h>
+#include <rdma/ib_user_verbs.h>
+#include <rdma/ib_mad.h>
+#include <rdma/ib_hdrs.h>
+#include <rdma/rdma_vt.h>
+#include <rdma/rdmavt_qp.h>
+#include <rdma/rdmavt_cq.h>
+
+struct hfi2_ctxtdata;
+struct hfi2_pportdata;
+struct hfi2_devdata;
+struct hfi2_packet;
+
+#include "iowait.h"
+#include "tid_rdma.h"
+#include "opfn.h"
+
+#define HFI2_MAX_RDMA_ATOMIC     16
+
+/*
+ * Increment this value if any changes that break userspace ABI
+ * compatibility are made.
+ */
+#define HFI2_UVERBS_ABI_VERSION       2
+
+/* IB Performance Manager status values */
+#define IB_PMA_SAMPLE_STATUS_DONE       0x00
+#define IB_PMA_SAMPLE_STATUS_STARTED    0x01
+#define IB_PMA_SAMPLE_STATUS_RUNNING    0x02
+
+/* Mandatory IB performance counter select values. */
+#define IB_PMA_PORT_XMIT_DATA   cpu_to_be16(0x0001)
+#define IB_PMA_PORT_RCV_DATA    cpu_to_be16(0x0002)
+#define IB_PMA_PORT_XMIT_PKTS   cpu_to_be16(0x0003)
+#define IB_PMA_PORT_RCV_PKTS    cpu_to_be16(0x0004)
+#define IB_PMA_PORT_XMIT_WAIT   cpu_to_be16(0x0005)
+
+#define HFI2_VENDOR_IPG		cpu_to_be16(0xFFA0)
+
+#define IB_DEFAULT_GID_PREFIX	cpu_to_be64(0xfe80000000000000ULL)
+#define OPA_BTH_MIG_REQ		BIT(31)
+
+#define RC_OP(x) IB_OPCODE_RC_##x
+#define UC_OP(x) IB_OPCODE_UC_##x
+
+/* flags passed by hfi2_ib_rcv() */
+enum {
+	HFI2_HAS_GRH = (1 << 0),
+};
+
+#define LRH_16B_BYTES (sizeof_field(struct hfi2_16b_header, lrh))
+#define LRH_16B_DWORDS (LRH_16B_BYTES / sizeof(u32))
+#define LRH_9B_BYTES (sizeof_field(struct ib_header, lrh))
+#define LRH_9B_DWORDS (LRH_9B_BYTES / sizeof(u32))
+
+/* 24Bits for qpn, upper 8Bits reserved */
+struct opa_16b_mgmt {
+	__be32 dest_qpn;
+	__be32 src_qpn;
+};
+
+struct hfi2_16b_header {
+	u32 lrh[4];
+	union {
+		struct {
+			struct ib_grh grh;
+			struct ib_other_headers oth;
+		} l;
+		struct ib_other_headers oth;
+		struct opa_16b_mgmt mgmt;
+	} u;
+} __packed;
+
+struct hfi2_opa_header {
+	union {
+		struct ib_header ibh; /* 9B header */
+		struct hfi2_16b_header opah; /* 16B header */
+	};
+	u8 hdr_type; /* 9B or 16B */
+} __packed;
+
+struct hfi2_ahg_info {
+	u32 ahgdesc[2];
+	u16 tx_flags;
+	u8 ahgcount;
+	u8 ahgidx;
+};
+
+struct hfi2_sdma_header {
+	__le64 pbc;
+	struct hfi2_opa_header hdr;
+} __packed;
+
+/*
+ * hfi2 specific data structures that will be hidden from rvt after the queue
+ * pair is made common
+ */
+struct hfi2_qp_priv {
+	struct hfi2_ahg_info *s_ahg;              /* ahg info for next header */
+	struct sdma_engine *s_sde;                /* current sde */
+	struct send_context *s_sendcontext;       /* current sendcontext */
+	struct hfi2_ctxtdata *rcd;                /* QP's receive context */
+	struct page **pages;                      /* for TID page scan */
+	u32 tid_enqueue;                          /* saved when tid waited */
+	u8 s_sc;		                  /* SC[0..4] for next packet */
+	struct iowait s_iowait;
+	struct timer_list s_tid_timer;            /* for timing tid wait */
+	struct timer_list s_tid_retry_timer;      /* for timing tid ack */
+	struct list_head tid_wait;                /* for queueing tid space */
+	struct hfi2_opfn_data opfn;
+	struct tid_flow_state flow_state;
+	struct tid_rdma_qp_params tid_rdma;
+	struct rvt_qp *owner;
+	u16 s_running_pkt_size;
+	u8 hdr_type; /* 9B or 16B */
+	struct rvt_sge_state tid_ss;       /* SGE state pointer for 2nd leg */
+	atomic_t n_requests;               /* # of TID RDMA requests in the */
+					   /* queue */
+	atomic_t n_tid_requests;            /* # of sent TID RDMA requests */
+	unsigned long tid_timer_timeout_jiffies;
+	unsigned long tid_retry_timeout_jiffies;
+
+	/* variables for the TID RDMA SE state machine */
+	u8 s_state;
+	u8 s_retry;
+	u8 rnr_nak_state;       /* RNR NAK state */
+	u8 s_nak_state;
+	u32 s_nak_psn;
+	u32 s_flags;
+	u32 s_tid_cur;
+	u32 s_tid_head;
+	u32 s_tid_tail;
+	u32 r_tid_head;     /* Most recently added TID RDMA request */
+	u32 r_tid_tail;     /* the last completed TID RDMA request */
+	u32 r_tid_ack;      /* the TID RDMA request to be ACK'ed */
+	u32 r_tid_alloc;    /* Request for which we are allocating resources */
+	u32 pending_tid_w_segs; /* Num of pending tid write segments */
+	u32 pending_tid_w_resp; /* Num of pending tid write responses */
+	u32 alloc_w_segs;       /* Number of segments for which write */
+			       /* resources have been allocated for this QP */
+
+	/* For TID RDMA READ */
+	u32 tid_r_reqs;         /* Num of tid reads requested */
+	u32 tid_r_comp;         /* Num of tid reads completed */
+	u32 pending_tid_r_segs; /* Num of pending tid read segments */
+	u16 pkts_ps;            /* packets per segment */
+	u8 timeout_shift;       /* account for number of packets per segment */
+
+	u32 r_next_psn_kdeth;
+	u32 r_next_psn_kdeth_save;
+	u32 s_resync_psn;
+	u8 sync_pt;           /* Set when QP reaches sync point */
+	u8 resync;
+};
+
+#define HFI2_QP_WQE_INVALID   ((u32)-1)
+
+struct hfi2_swqe_priv {
+	struct tid_rdma_request tid_req;
+	struct rvt_sge_state ss;  /* Used for TID RDMA READ Request */
+};
+
+struct hfi2_ack_priv {
+	struct rvt_sge_state ss;               /* used for TID WRITE RESP */
+	struct tid_rdma_request tid_req;
+};
+
+/*
+ * This structure is used to hold commonly lookedup and computed values during
+ * the send engine progress.
+ */
+struct iowait_work;
+struct hfi2_pkt_state {
+	struct hfi2_ibdev *dev;
+	struct hfi2_ibport *ibp;
+	struct hfi2_pportdata *ppd;
+	struct verbs_txreq *s_txreq;
+	struct iowait_work *wait;
+	unsigned long flags;
+	unsigned long timeout;
+	unsigned long timeout_int;
+	int cpu;
+	u8 opcode;
+	bool in_thread;
+	bool pkts_sent;
+};
+
+#define HFI2_PSN_CREDIT  16
+
+struct hfi2_opcode_stats {
+	u64 n_packets;          /* number of packets */
+	u64 n_bytes;            /* total number of bytes */
+};
+
+struct hfi2_opcode_stats_perctx {
+	struct hfi2_opcode_stats stats[256];
+};
+
+static inline void inc_opstats(
+	u32 tlen,
+	struct hfi2_opcode_stats *stats)
+{
+#ifdef CONFIG_DEBUG_FS
+	stats->n_bytes += tlen;
+	stats->n_packets++;
+#endif
+}
+
+struct hfi2_ibport {
+	struct rvt_qp __rcu *qp[2];
+	struct rvt_ibport rvp;
+
+	/* the first 16 entries are sl_to_vl for !OPA */
+	u8 sl_to_sc[32];
+	u8 sc_to_sl[32];
+};
+
+struct hfi2_ibdev {
+	struct rvt_dev_info rdi; /* Must be first */
+
+	/* QP numbers are shared by all IB ports */
+	/* protect txwait list */
+	seqlock_t txwait_lock ____cacheline_aligned_in_smp;
+	struct list_head txwait;        /* list for wait verbs_txreq */
+	struct list_head memwait;       /* list for wait kernel memory */
+	struct kmem_cache *verbs_txreq_cache;
+	u64 n_txwait;
+	u64 n_kmem_wait;
+	u64 n_tidwait;
+
+	/* protect iowait lists */
+	seqlock_t iowait_lock ____cacheline_aligned_in_smp;
+	u64 n_piowait;
+	u64 n_piodrain;
+	struct timer_list mem_timer;
+
+#ifdef CONFIG_DEBUG_FS
+	/* per HFI debugfs */
+	struct dentry *hfi2_ibdev_dbg;
+	/* per HFI symlinks to above */
+	struct dentry *hfi2_ibdev_link;
+#ifdef CONFIG_FAULT_INJECTION
+	struct fault *fault;
+#endif
+#endif
+};
+
+static inline struct hfi2_ibdev *to_idev(struct ib_device *ibdev)
+{
+	struct rvt_dev_info *rdi;
+
+	rdi = container_of(ibdev, struct rvt_dev_info, ibdev);
+	return container_of(rdi, struct hfi2_ibdev, rdi);
+}
+
+static inline struct rvt_qp *iowait_to_qp(struct iowait *s_iowait)
+{
+	struct hfi2_qp_priv *priv;
+
+	priv = container_of(s_iowait, struct hfi2_qp_priv, s_iowait);
+	return priv->owner;
+}
+
+/*
+ * This must be called with s_lock held.
+ */
+void hfi2_bad_pkey(struct hfi2_ibport *ibp, u32 key, u32 sl,
+		   u32 qp1, u32 qp2, u32 lid1, u32 lid2);
+void hfi2_cap_mask_chg(struct rvt_dev_info *rdi, u32 port_num);
+void hfi2_sys_guid_chg(struct hfi2_ibport *ibp);
+void hfi2_node_desc_chg(struct hfi2_ibport *ibp);
+int hfi2_process_mad(struct ib_device *ibdev, int mad_flags, u32 port,
+		     const struct ib_wc *in_wc, const struct ib_grh *in_grh,
+		     const struct ib_mad *in_mad, struct ib_mad *out_mad,
+		     size_t *out_mad_size, u16 *out_mad_pkey_index);
+int cport_process_mad(struct ib_device *ibdev, int mad_flags, u32 port,
+		      const struct ib_wc *in_wc, const struct ib_grh *in_grh,
+		      const struct ib_mad *in_mad, struct ib_mad *out_mad,
+		      size_t *out_mad_size, u16 *out_mad_pkey_index);
+
+/*
+ * The PSN_MASK and PSN_SHIFT allow for
+ * 1) comparing two PSNs
+ * 2) returning the PSN with any upper bits masked
+ * 3) returning the difference between to PSNs
+ *
+ * The number of significant bits in the PSN must
+ * necessarily be at least one bit less than
+ * the container holding the PSN.
+ */
+#define PSN_MASK 0x7FFFFFFF
+#define PSN_SHIFT 1
+#define PSN_MODIFY_MASK 0xFFFFFF
+
+/*
+ * Compare two PSNs
+ * Returns an integer <, ==, or > than zero.
+ */
+static inline int cmp_psn(u32 a, u32 b)
+{
+	return (((int)a) - ((int)b)) << PSN_SHIFT;
+}
+
+/*
+ * Return masked PSN
+ */
+static inline u32 mask_psn(u32 a)
+{
+	return a & PSN_MASK;
+}
+
+/*
+ * Return delta between two PSNs
+ */
+static inline u32 delta_psn(u32 a, u32 b)
+{
+	return (((int)a - (int)b) << PSN_SHIFT) >> PSN_SHIFT;
+}
+
+static inline struct tid_rdma_request *wqe_to_tid_req(struct rvt_swqe *wqe)
+{
+	return &((struct hfi2_swqe_priv *)wqe->priv)->tid_req;
+}
+
+static inline struct tid_rdma_request *ack_to_tid_req(struct rvt_ack_entry *e)
+{
+	return &((struct hfi2_ack_priv *)e->priv)->tid_req;
+}
+
+/*
+ * Look through all the active flows for a TID RDMA request and find
+ * the one (if it exists) that contains the specified PSN.
+ */
+static inline u32 __full_flow_psn(struct flow_state *state, u32 psn)
+{
+	return mask_psn((state->generation << HFI2_KDETH_BTH_SEQ_SHIFT) |
+			(psn & HFI2_KDETH_BTH_SEQ_MASK));
+}
+
+static inline u32 full_flow_psn(struct tid_rdma_flow *flow, u32 psn)
+{
+	return __full_flow_psn(&flow->flow_state, psn);
+}
+
+int hfi2_verbs_send(struct rvt_qp *qp, struct hfi2_pkt_state *ps);
+
+void hfi2_cnp_rcv(struct hfi2_packet *packet);
+
+void hfi2_uc_rcv(struct hfi2_packet *packet);
+
+void hfi2_rc_rcv(struct hfi2_packet *packet);
+
+void hfi2_rc_hdrerr(
+	struct hfi2_ctxtdata *rcd,
+	struct hfi2_packet *packet,
+	struct rvt_qp *qp);
+
+u8 ah_to_sc(struct ib_device *ibdev, struct rdma_ah_attr *ah_attr);
+
+void hfi2_rc_verbs_aborted(struct rvt_qp *qp, struct hfi2_opa_header *opah);
+void hfi2_rc_send_complete(struct rvt_qp *qp, struct hfi2_opa_header *opah);
+
+void hfi2_ud_rcv(struct hfi2_packet *packet);
+
+int hfi2_lookup_pkey_idx(struct hfi2_ibport *ibp, u16 pkey);
+
+void hfi2_migrate_qp(struct rvt_qp *qp);
+
+int hfi2_check_modify_qp(struct rvt_qp *qp, struct ib_qp_attr *attr,
+			 int attr_mask, struct ib_udata *udata);
+
+void hfi2_modify_qp(struct rvt_qp *qp, struct ib_qp_attr *attr,
+		    int attr_mask, struct ib_udata *udata);
+void hfi2_restart_rc(struct rvt_qp *qp, u32 psn, int wait);
+int hfi2_setup_wqe(struct rvt_qp *qp, struct rvt_swqe *wqe,
+		   bool *call_send);
+
+int hfi2_ruc_check_hdr(struct hfi2_ibport *ibp, struct hfi2_packet *packet);
+
+u32 hfi2_make_grh(struct hfi2_ibport *ibp, struct ib_grh *hdr,
+		  const struct ib_global_route *grh, u32 hwords, u32 nwords);
+
+void hfi2_make_ruc_header(struct rvt_qp *qp, struct ib_other_headers *ohdr,
+			  u32 bth0, u32 bth1, u32 bth2, int middle,
+			  struct hfi2_pkt_state *ps);
+
+bool hfi2_schedule_send_yield(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			      bool tid);
+
+void _hfi2_do_send(struct work_struct *work);
+
+void hfi2_do_send_from_rvt(struct rvt_qp *qp);
+
+void hfi2_do_send(struct rvt_qp *qp, bool in_thread);
+
+void hfi2_send_rc_ack(struct hfi2_packet *packet, bool is_fecn);
+
+int hfi2_make_rc_req(struct rvt_qp *qp, struct hfi2_pkt_state *ps);
+
+int hfi2_make_uc_req(struct rvt_qp *qp, struct hfi2_pkt_state *ps);
+
+int hfi2_make_ud_req(struct rvt_qp *qp, struct hfi2_pkt_state *ps);
+
+int hfi2_register_ib_device(struct hfi2_devdata *);
+
+void hfi2_unregister_ib_device(struct hfi2_devdata *);
+
+void hfi2_kdeth_eager_rcv(struct hfi2_packet *packet);
+
+void hfi2_kdeth_expected_rcv(struct hfi2_packet *packet);
+
+void hfi2_ib_rcv(struct hfi2_packet *packet);
+
+void hfi2_16B_rcv(struct hfi2_packet *packet);
+
+unsigned int hfi2_get_npkeys(struct hfi2_devdata *);
+
+int hfi2_verbs_send_dma(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			u64 pbc);
+
+int hfi2_verbs_send_pio(struct rvt_qp *qp, struct hfi2_pkt_state *ps,
+			u64 pbc);
+
+static inline bool opa_bth_is_migration(struct ib_other_headers *ohdr)
+{
+	return ohdr->bth[1] & cpu_to_be32(OPA_BTH_MIG_REQ);
+}
+
+void hfi2_wait_kmem(struct rvt_qp *qp);
+
+static inline void hfi2_trdma_send_complete(struct rvt_qp *qp,
+					    struct rvt_swqe *wqe,
+					    enum ib_wc_status status)
+{
+	trdma_clean_swqe(qp, wqe);
+	rvt_send_complete(qp, wqe, status);
+}
+
+extern const enum ib_wc_opcode ib_hfi2_wc_opcode[];
+
+extern const u8 hdr_len_by_opcode[];
+
+extern const int ib_rvt_state_ops[];
+
+extern __be64 ib_hfi2_sys_image_guid;    /* in network order */
+
+extern unsigned int hfi2_max_cqes;
+
+extern unsigned int hfi2_max_cqs;
+
+extern unsigned int hfi2_max_qp_wrs;
+
+extern unsigned int hfi2_max_qps;
+
+extern unsigned int hfi2_max_sges;
+
+extern unsigned int hfi2_max_mcast_grps;
+
+extern unsigned int hfi2_max_mcast_qp_attached;
+
+extern unsigned int hfi2_max_srqs;
+
+extern unsigned int hfi2_max_srq_sges;
+
+extern unsigned int hfi2_max_srq_wrs;
+
+extern unsigned short piothreshold;
+
+extern const u32 ib_hfi2_rnr_table[];
+
+#endif                          /* HFI2_VERBS_H */
diff --git a/drivers/infiniband/hw/hfi2/verbs_txreq.h b/drivers/infiniband/hw/hfi2/verbs_txreq.h
new file mode 100644
index 000000000000..b267771b643a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/verbs_txreq.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2016 - 2018 Intel Corporation.
+ */
+
+#ifndef HFI2_VERBS_TXREQ_H
+#define HFI2_VERBS_TXREQ_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+
+#include "verbs.h"
+#include "sdma_txreq.h"
+#include "iowait.h"
+
+struct verbs_txreq {
+	struct hfi2_sdma_header	phdr;
+	struct sdma_txreq       txreq;
+	struct rvt_qp           *qp;
+	struct rvt_swqe         *wqe;
+	struct rvt_mregion	*mr;
+	struct rvt_sge_state    *ss;
+	struct sdma_engine     *sde;
+	struct send_context     *psc;
+	struct kref		ref;
+	u16                     hdr_dwords;
+	u16			s_cur_size;
+};
+
+struct hfi2_ibdev;
+struct verbs_txreq *__get_txreq(struct hfi2_ibdev *dev,
+				struct rvt_qp *qp);
+
+#define VERBS_TXREQ_GFP (GFP_ATOMIC | __GFP_NOWARN)
+static inline struct verbs_txreq *alloc_txreq(struct hfi2_ibdev *dev,
+					      struct rvt_qp *qp)
+	__must_hold(&qp->slock)
+{
+	struct verbs_txreq *tx;
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	tx = kmem_cache_alloc(dev->verbs_txreq_cache, VERBS_TXREQ_GFP);
+	if (unlikely(!tx)) {
+		/* call slow path to get the lock */
+		tx = __get_txreq(dev, qp);
+		if (!tx)
+			return tx;
+	}
+	tx->qp = qp;
+	tx->mr = NULL;
+	tx->sde = priv->s_sde;
+	tx->psc = priv->s_sendcontext;
+	/* so that we can test if the sdma descriptors are there */
+	tx->txreq.num_desc = 0;
+	/* Set the header type */
+	tx->phdr.hdr.hdr_type = priv->hdr_type;
+	tx->txreq.flags = 0;
+	kref_init(&tx->ref);
+	return tx;
+}
+
+static inline struct verbs_txreq *get_waiting_verbs_txreq(struct iowait_work *w)
+{
+	struct sdma_txreq *stx;
+
+	stx = iowait_get_txhead(w);
+	if (stx)
+		return container_of(stx, struct verbs_txreq, txreq);
+	return NULL;
+}
+
+static inline bool verbs_txreq_queued(struct iowait_work *w)
+{
+	return iowait_packet_queued(w);
+}
+
+void dealloc_txreq(struct kref *ref);
+
+/*
+ * There are no locks to enforce ordering between hfi2_get_txreq() and
+ * hfi2_put_txreq().  The caller of hfi2_get_txreq() must be currently
+ * holding a reference to avoid any race with hfi2_put_txreq().
+ */
+static inline void hfi2_get_txreq(struct verbs_txreq *tx)
+{
+	kref_get(&tx->ref);
+}
+
+static inline void hfi2_put_txreq(struct verbs_txreq *tx)
+{
+	kref_put(&tx->ref, dealloc_txreq);
+}
+
+int verbs_txreq_init(struct hfi2_ibdev *dev);
+void verbs_txreq_exit(struct hfi2_ibdev *dev);
+
+#endif                         /* HFI2_VERBS_TXREQ_H */



