Return-Path: <linux-rdma+bounces-11785-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D00AEE64E
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100EF1883559
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F0C2E6130;
	Mon, 30 Jun 2025 17:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="IA6JkJCC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2117.outbound.protection.outlook.com [40.107.92.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8E42E7180
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306313; cv=fail; b=deTa0/ZTv+Qz9Bs4bOIvKhW5Ul1Mo8iStJFJ5z55LO30mJXuY0KIpFT+CgywwDnsvpmfcjFhH5ZY4ASprgEPA70eIopS5aC2cVDTjxRi1fWLa8tHgnUSCftOWEfzyGTT44X/VvisFMoc0DppqkcoCDnLly41CVbUffjCK+FIhbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306313; c=relaxed/simple;
	bh=dtHxBbXLD8HqZdgqLHIutKbf281tSegN+69ejb9jJTg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJVCiXSn3pVeiuPRuL8HwLMq4BhftzYy4802YTyrQ+9H8fK+yRmQ/L9HYhG8LUqJzEUo5Mm/Tss4C1cm67OF0EbuBECrojj50I9WLS8LgUqELP6oM3+UtuBJ/xelEtdQZmx0etygnjGn67FXAWFQehV1Y9M1umtfcPystdJOFbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=IA6JkJCC; arc=fail smtp.client-ip=40.107.92.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xI3D0tHm7Mpah0IEJPDE95+4QrHkKFyHclgO7XilldEn+0Bv/03datson3mRa7GUqp+MT6vjcUF5YVMjCq4y8hJ/v0nvGn0iIfVVpXsQMrXTEGF/8LEeaYL/gFQwVpV6fMyg4+VA4pwX8uznFBpXkswMVo5UxoTEez/oBHvSmsSzMpPi6JF+Bk0Tbmg3+hiNEEMBVy467BiaW9L4eAL51AygLfR7D5kHV/irhMemCdRghi2zpuTMjMldfmJeLLCTSQbclREYrue8+xwrGCasqRBiNYSVcBw32cCpzsQVU4xx//ve0sq3J3KEPCpH4LY8sVTZYfTj0AYIPipKYFlEwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDNO/5Zfy/kChxCNf41FPZ6F8pTPzQ4fuqfGLQjQ79k=;
 b=KPfnhZ7zioMXyQrscQWEYCM4qHBuL4jetbmzYFzxPSQhjcupTPjcllk5UWbT4rC4aBMLJbTkxXMpC8VcpuZJTtCZSdLmmIJZ65JQADtyRrwSzD/8a91EOG6huxzab+lLtX9oAp+c9xbJwSt2KOZS3ZZk07B4W1YhdEhvtKHVps6WJ1W1HYV/f+JIIG8gGBqeTUthRM1r7UrFbjfmiK7q+isYBS3niWx/+0ELQVD86uAYRxBVmy5vKDktSKPvFPCOlDoAt+MrgjiznH1hqCzbw+KvmqCoEgnB6g6i2/P1IDai7F9JOcGCbmXbxpSodVT0IwzSxt/b9+f/bgHSXPfKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDNO/5Zfy/kChxCNf41FPZ6F8pTPzQ4fuqfGLQjQ79k=;
 b=IA6JkJCCS7YKo0aU/ZHmHwdfgARES3IaH93Q1fMQtz675woiGmraOFEcvWitvSeOxue+olglV8ZcfWrgG4JU0WTt9zt4Ky/xu72vTWRsSzDGiC4g4wNp5Hf4YNc2xibRVY5NGwtNh9gNXI7g18fP0bN0OyJt1WFnk78dpN8Oe0PhXwM+MGr9XsgWhL2LbD3ilJfIFSTjA9ODD0SaBa6UMaeRlMKjCVL62XbxrJ69Umeuml/DPC8uQRwYye0o8yT/nOcW0Gd1U7fNDUhSnWPqPBFWNnIaTCAkA3XiTfk1yp2INRcADgofgqk6IwhsT5Qs6UIe8RCjWkPsdbsDBuuPOA==
Received: from BL0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:91::26)
 by CH1PR01MB9215.prod.exchangelabs.com (2603:10b6:610:2ad::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.31; Mon, 30 Jun 2025 17:58:09 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::7a) by BL0PR05CA0016.outlook.office365.com
 (2603:10b6:208:91::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.18 via Frontend Transport; Mon,
 30 Jun 2025 17:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:08 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id C15AC14D721;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id C07ED1848B5DC;
	Mon, 30 Jun 2025 11:31:18 -0400 (EDT)
Subject: [PATCH for-next 18/23] RDMA/hfi2: Implement data moving
 infrastructure
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:31:18 -0400
Message-ID:
 <175129747871.1859400.7313739451186894016.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH1PR01MB9215:EE_
X-MS-Office365-Filtering-Correlation-Id: a84ee931-10fa-457a-a13e-08ddb7ffabb7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3FZZHIvSTQ5SkxSU1J5eWljRU04OHFiNXZQTFB6L2JHaWxqc21CSEVsbzFz?=
 =?utf-8?B?R2dDMHEvVGtHTDhHNlR3cmRRc2d4Qk9oWDB3dWRlQTZlZEExUlNhWWFBaDZW?=
 =?utf-8?B?WU5Fc1crWXdNQWhLNkNPNFREUDlWL0NSZGpCMi9tWnFVRDE1SDk5K0k3cGJ2?=
 =?utf-8?B?Nzhpa0N0MjBCNHFzUzhjQlFKbHg3bERpcFJqdUpqWlVPR0czb1RnMDl1Rllq?=
 =?utf-8?B?TkZIRjdTY0w1TWl6UUV3ZnQxdVF4YlAwV0g3UjZ1alJPVGNGd3ZUZjgyVVBH?=
 =?utf-8?B?VGNsd3NSays4cEFsYUdueG4zWVdXTWlrNFdXb21DMDY3TitTbVUyNkNsT2lr?=
 =?utf-8?B?eUtkZ1NmMEJSaGpXVUVRWlF5QjBwUVVNSHVHRkRjL04zbmRtTGdIWGFENlRG?=
 =?utf-8?B?ZjVXbnpacVhYQzF6NDQxdlZNZjlXNFZsNG1KUENtbEs3SUhTSnA2aVlpSFUr?=
 =?utf-8?B?QmNlUVhzWitlTTNYNm1rVzZ3dmxkLy9IYWU5Skc5NjZKR2ZZbGVzZ0NSZERm?=
 =?utf-8?B?R2dJdGRSRmNxLzBUSm1vUEZDdHNZM1Z1ZmpjeUZRNUNUVHl3ZmFyU3hzaHBl?=
 =?utf-8?B?NjR0N3MxcjRXN3JWcW5GTzlKQWcvZUdUZTkrbnNjcTJ0Vm1pMEtPTTVYVCtJ?=
 =?utf-8?B?a3V1bXlqZjZaOFlCZE80NndYeEdnSDRWc25pUVF1L2lhYXJVZDNFZnVWRnRG?=
 =?utf-8?B?d2ZIeW5Jc2hGNmtSNEZnck1MVSs4Wm9YUG1JZFJpU1NIdHJTQ21LdEtkbkxx?=
 =?utf-8?B?UURuRFAxMUZNbEVOQk05eGgwVXVSdzBuM2EzT2hLWTZaWjJhVTgzcC9keis4?=
 =?utf-8?B?Q2QzWXpWaktZT1BISm80amdia05lWnhmS0k1NkNRWWtMeFZ2dW1LVWNLS3U5?=
 =?utf-8?B?akt1QzNCbEpXRlZxUi9NaTNqM2twUnFOMkZ1cC9aT3pMdkVHTVpqTTFsMjlR?=
 =?utf-8?B?NjJsbjhCRDlEMDBTd0dxZGJ4MnVMMFJXZ213clhHSWdmMUJjc1VmLzU3T1di?=
 =?utf-8?B?SE5JbFFuRHZEQTlONDg0YmZ0WndvYVFQOUpwMGV6NjJyMXJ4KzVZNzlKUzJ4?=
 =?utf-8?B?ZVVtazdmWmdCT3JGeDVLYjZKQ3RnMWtFNElGTWlCcEpsbElwZE9hSU1yQm11?=
 =?utf-8?B?Z3hZMm01UGlGcjNlQ0pRdWlLM0JCL3JSNWFVN3A0M3pTOGkrYUZCQ0dyQ3gr?=
 =?utf-8?B?eVBwL1M5TXVjcUhZUVZJVnJ6RktkN2sweWt2RDlTRXp5Yko0T1lrYlRBUThn?=
 =?utf-8?B?QTNtT1VJV2xRNnY2cUs3cjhKdjBhR0FrQkpjbC9tM2tUZ29QQTdnMEJJSzN2?=
 =?utf-8?B?aGpCMFlkbkdZanhqVWo1ekZjOXcvajVsbGUxelc2TytxYmpPcUUyZ3crc2E0?=
 =?utf-8?B?ZjVsQVJ0ek1IUEExYU9DYjhIeloybTRCWldTb0lJNVhlb0pRRTlDR2x2V0tO?=
 =?utf-8?B?WDFvZUxGSWF6bXk3Uk4yQklvaDdmZWY5SEVmZkJ3NVlmaEpFbFVsTVZDZEtR?=
 =?utf-8?B?TTJpeldGUE9qa2RYSG0yblFzdGUwYXlwMTVybDhYei9Jb1p1Nmt3MXE3eTY2?=
 =?utf-8?B?MndhNEJkc1NteE1DT0svUFVRY2pDNWRnNFBnSWhOMlNMdEJCYW5DMkkvbEFq?=
 =?utf-8?B?Q29RSnlCSHlhS2J5VzJvU3kwQ2RJRzNEaVFUZWtjeUtIVUkvQVl2aXB5SUV6?=
 =?utf-8?B?WXJlUUgxNDFMQ1I4TnI3djlBbXEvYUF3bjNOeC9mNCtscTVyaHlWQmhHb29F?=
 =?utf-8?B?TzU5Y2czQndLZmI5NW5hQnRmbldIOE1XK3BRQnZNVGtpNXQrc28yMkdVdHgy?=
 =?utf-8?B?Z3Mxd2IyV0Q5cU5PMDJxaDZFS1g4YmRRTXZKWkkzMmtZVy9iZ3ovUmhscFRV?=
 =?utf-8?B?YWNqanNQV0NTcGNOQ0JuQVR3MkE0KzZqWjdYaVdPTm1zaXVCdEwxaDh1QXNr?=
 =?utf-8?B?SFhrSEFkK1p6NS9iMGVic080cjlLVUc3SFJoUUQ0WmVoa1FrLzdTMnF6bllQ?=
 =?utf-8?B?Y3hNMFlOeW9LTUlUdEtVMERTVkE5THp1VzhWaEY4Vno3ekk3S3VFNk16M3kr?=
 =?utf-8?Q?uYT0Xu?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:08.1178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84ee931-10fa-457a-a13e-08ddb7ffabb7
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR01MB9215

The new chip uses the same PIO and SDMA mechanisms for sending data as the
previous chip. It also has the same receve mechanisms. The differences are
multiple ports and speeds/feeds of the underlying hardware.

Start to add the underlying code that enables verbs and ipoib which
follows.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/exp_rcv.c      |   78 +
 drivers/infiniband/hw/hfi2/file_ops.c     | 1272 +++++++++
 drivers/infiniband/hw/hfi2/iowait.c       |  128 +
 drivers/infiniband/hw/hfi2/mmu_rb.c       |  334 ++
 drivers/infiniband/hw/hfi2/pin_system.c   |  550 ++++
 drivers/infiniband/hw/hfi2/pinning.c      |   66 
 drivers/infiniband/hw/hfi2/pio.c          | 2277 +++++++++++++++++
 drivers/infiniband/hw/hfi2/pio_copy.c     |  715 +++++
 drivers/infiniband/hw/hfi2/sdma.c         | 3971 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/tid_system.c   |  476 +++
 drivers/infiniband/hw/hfi2/user_exp_rcv.c | 1012 +++++++
 drivers/infiniband/hw/hfi2/user_pages.c   |  106 +
 drivers/infiniband/hw/hfi2/user_sdma.c    | 1671 ++++++++++++
 13 files changed, 12656 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/exp_rcv.c
 create mode 100644 drivers/infiniband/hw/hfi2/file_ops.c
 create mode 100644 drivers/infiniband/hw/hfi2/iowait.c
 create mode 100644 drivers/infiniband/hw/hfi2/mmu_rb.c
 create mode 100644 drivers/infiniband/hw/hfi2/pin_system.c
 create mode 100644 drivers/infiniband/hw/hfi2/pinning.c
 create mode 100644 drivers/infiniband/hw/hfi2/pio.c
 create mode 100644 drivers/infiniband/hw/hfi2/pio_copy.c
 create mode 100644 drivers/infiniband/hw/hfi2/sdma.c
 create mode 100644 drivers/infiniband/hw/hfi2/tid_system.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_exp_rcv.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_pages.c
 create mode 100644 drivers/infiniband/hw/hfi2/user_sdma.c

diff --git a/drivers/infiniband/hw/hfi2/exp_rcv.c b/drivers/infiniband/hw/hfi2/exp_rcv.c
new file mode 100644
index 000000000000..f724ecd63ad7
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/exp_rcv.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2017 Intel Corporation.
+ */
+
+#include "exp_rcv.h"
+#include "trace.h"
+
+/**
+ * hfi2_exp_tid_set_init - initialize exp_tid_set
+ * @set: the set
+ */
+static void hfi2_exp_tid_set_init(struct exp_tid_set *set)
+{
+	INIT_LIST_HEAD(&set->list);
+	set->count = 0;
+}
+
+/**
+ * hfi2_exp_tid_group_init - initialize rcd expected receive
+ * @rcd: the rcd
+ */
+void hfi2_exp_tid_group_init(struct hfi2_ctxtdata *rcd)
+{
+	hfi2_exp_tid_set_init(&rcd->tid_group_list);
+	hfi2_exp_tid_set_init(&rcd->tid_used_list);
+	hfi2_exp_tid_set_init(&rcd->tid_full_list);
+}
+
+/**
+ * hfi2_alloc_ctxt_rcv_groups - initialize expected receive groups
+ * @rcd: the context to add the groupings to
+ */
+int hfi2_alloc_ctxt_rcv_groups(struct hfi2_ctxtdata *rcd)
+{
+	struct hfi2_devdata *dd = rcd->dd;
+	u32 tidbase;
+	struct tid_group *grp;
+	int i;
+	u32 ngroups;
+
+	ngroups = rcd->expected_count / dd->rcv_entries.group_size;
+	rcd->groups =
+		kcalloc_node(ngroups, sizeof(*rcd->groups),
+			     GFP_KERNEL, rcd->numa_id);
+	if (!rcd->groups)
+		return -ENOMEM;
+	tidbase = 0;
+	for (i = 0; i < ngroups; i++) {
+		grp = &rcd->groups[i];
+		grp->size = dd->rcv_entries.group_size;
+		grp->base = tidbase;
+		tid_group_add_tail(grp, &rcd->tid_group_list);
+		tidbase += dd->rcv_entries.group_size;
+	}
+
+	return 0;
+}
+
+/**
+ * hfi2_free_ctxt_rcv_groups - free  expected receive groups
+ * @rcd: the context to free
+ *
+ * The routine dismantles the expect receive linked
+ * list and clears any tids associated with the receive
+ * context.
+ *
+ * This should only be called for kernel contexts and the
+ * a base user context.
+ */
+void hfi2_free_ctxt_rcv_groups(struct hfi2_ctxtdata *rcd)
+{
+	kfree(rcd->groups);
+	rcd->groups = NULL;
+	hfi2_exp_tid_group_init(rcd);
+
+	hfi2_clear_tids(rcd);
+}
diff --git a/drivers/infiniband/hw/hfi2/file_ops.c b/drivers/infiniband/hw/hfi2/file_ops.c
new file mode 100644
index 000000000000..6525deaeebe0
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/file_ops.c
@@ -0,0 +1,1272 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2020-2024 Cornelis Networks, Inc.
+ * Copyright(c) 2015-2020 Intel Corporation.
+ */
+
+#include <linux/poll.h>
+#include <linux/cdev.h>
+#include <linux/vmalloc.h>
+#include <linux/io.h>
+#include <linux/sched/mm.h>
+#include <linux/bitmap.h>
+
+#include <rdma/ib.h>
+
+#include "hfi2.h"
+#include "pio.h"
+#include "device.h"
+#include "common.h"
+#include "trace.h"
+#include "mmu_rb.h"
+#include "user_sdma.h"
+#include "user_exp_rcv.h"
+#include "aspm.h"
+#include "pinning.h"
+#include "file_ops.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) DRIVER_NAME ": " fmt
+
+#define SEND_CTXT_HALT_TIMEOUT 1000 /* msecs */
+
+/*
+ * File operation functions
+ */
+static u64 kvirt_to_phys(void *addr);
+static void init_subctxts(struct hfi2_ctxtdata *uctxt,
+			  const struct hfi2_assign_ctxt_cmd *uinfo);
+static int init_user_ctxt(struct hfi2_filedata *fd,
+			  struct hfi2_ctxtdata *uctxt);
+static void user_init(struct hfi2_ctxtdata *uctxt);
+static int setup_base_ctxt(struct hfi2_filedata *fd,
+			   struct hfi2_ctxtdata *uctxt);
+static int setup_subctxt(struct hfi2_ctxtdata *uctxt);
+
+static int find_sub_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo);
+static int allocate_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo,
+			 struct hfi2_ctxtdata **cd);
+static void deallocate_ctxt(struct hfi2_ctxtdata *uctxt);
+static vm_fault_t vma_fault(struct vm_fault *vmf);
+
+static const struct vm_operations_struct vm_ops = {
+	.fault = vma_fault,
+};
+
+/*
+ * Masks and offsets defining the mmap tokens
+ */
+#define HFI2_MMAP_OFFSET_MASK   0xfffULL
+#define HFI2_MMAP_OFFSET_SHIFT  0
+#define HFI2_MMAP_SUBCTXT_MASK  0xfULL
+#define HFI2_MMAP_SUBCTXT_SHIFT 12
+#define HFI2_MMAP_CTXT_MASK     0xffULL
+#define HFI2_MMAP_CTXT_SHIFT    16
+#define HFI2_MMAP_TYPE_MASK     0xfULL
+#define HFI2_MMAP_TYPE_SHIFT    24
+#define HFI2_MMAP_MAGIC_MASK    0xffffffffULL
+#define HFI2_MMAP_MAGIC_SHIFT   32
+
+#define HFI2_MMAP_MAGIC         0xdabbad00
+
+#define HFI2_MMAP_TOKEN_SET(field, val)	\
+	(((val) & HFI2_MMAP_##field##_MASK) << HFI2_MMAP_##field##_SHIFT)
+#define HFI2_MMAP_TOKEN_GET(field, token) \
+	(((token) >> HFI2_MMAP_##field##_SHIFT) & HFI2_MMAP_##field##_MASK)
+#define HFI2_MMAP_TOKEN(type, ctxt, subctxt, addr)   \
+	(HFI2_MMAP_TOKEN_SET(MAGIC, HFI2_MMAP_MAGIC) | \
+	HFI2_MMAP_TOKEN_SET(TYPE, type) | \
+	HFI2_MMAP_TOKEN_SET(CTXT, ctxt) | \
+	HFI2_MMAP_TOKEN_SET(SUBCTXT, subctxt) | \
+	HFI2_MMAP_TOKEN_SET(OFFSET, (offset_in_page(addr))))
+
+#define dbg(fmt, ...)				\
+	pr_info(fmt, ##__VA_ARGS__)
+
+static inline int is_valid_mmap(u64 token)
+{
+	return (HFI2_MMAP_TOKEN_GET(MAGIC, token) == HFI2_MMAP_MAGIC);
+}
+
+struct hfi2_filedata *hfi2_alloc_filedata(struct hfi2_devdata *dd)
+{
+	struct hfi2_filedata *fd;
+
+	/* The real work is performed later in assign_ctxt() */
+
+	fd = kzalloc(sizeof(*fd), GFP_KERNEL);
+
+	if (!fd || init_srcu_struct(&fd->pq_srcu))
+		goto nomem;
+	spin_lock_init(&fd->pq_rcu_lock);
+	spin_lock_init(&fd->tid_lock);
+	spin_lock_init(&fd->invalid_lock);
+	fd->rec_cpu_num = -1; /* no cpu affinity by default */
+	fd->dd = dd;
+	/* no port yet */
+	fd->ppd = NULL;
+	return fd;
+nomem:
+	kfree(fd);
+	return NULL;
+}
+
+ssize_t hfi2_do_write_iter(struct hfi2_filedata *fd, struct iov_iter *from)
+{
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct hfi2_user_sdma_comp_q *cq = fd->cq;
+	int done = 0, reqs = 0;
+	unsigned long dim = from->nr_segs;
+	int idx;
+
+	if (!HFI2_CAP_IS_KSET(SDMA))
+		return -EINVAL;
+	if (!user_backed_iter(from))
+		return -EINVAL;
+	idx = srcu_read_lock(&fd->pq_srcu);
+	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
+	if (!cq || !pq) {
+		srcu_read_unlock(&fd->pq_srcu, idx);
+		return -EIO;
+	}
+
+	trace_hfi2_sdma_request(fd->dd, fd->uctxt->ctxt, fd->subctxt, dim);
+
+	if (atomic_read(&pq->n_reqs) == pq->n_max_reqs) {
+		srcu_read_unlock(&fd->pq_srcu, idx);
+		return -ENOSPC;
+	}
+
+	while (dim) {
+		const struct iovec *iov = iter_iov(from);
+		int ret;
+		unsigned long count = 0;
+
+		ret = hfi2_user_sdma_process_request(
+			fd, (struct iovec *)(iov + done),
+			dim, &count);
+		if (ret) {
+			reqs = ret;
+			break;
+		}
+		dim -= count;
+		done += count;
+		reqs++;
+	}
+
+	srcu_read_unlock(&fd->pq_srcu, idx);
+	return reqs;
+}
+
+static inline void mmap_cdbg(u16 ctxt, u16 subctxt, u8 type, u8 mapio, u8 vmf,
+			     u64 memaddr, void *memvirt, dma_addr_t memdma,
+			     ssize_t memlen, struct vm_area_struct *vma)
+{
+	hfi2_cdbg(PROC,
+		  "%u:%u type:%u io/vf/dma:%d/%d/%d, addr:0x%llx, len:%lu(%lu), flags:0x%lx",
+		  ctxt, subctxt, type, mapio, vmf, !!memdma,
+		  memaddr ?: (u64)memvirt, memlen,
+		  vma->vm_end - vma->vm_start, vma->vm_flags);
+}
+
+int hfi2_do_mmap(struct hfi2_filedata *fd, u8 type, struct vm_area_struct *vma)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd;
+	unsigned long flags;
+	u64 memaddr = 0;
+	void *memvirt = NULL;
+	dma_addr_t memdma = 0;
+	u8 mapio = 0, vmf = 0;
+	ssize_t memlen = 0;
+	int ret = 0;
+	u16 ctxt;
+	u16 subctxt;
+
+	if (!uctxt || !(vma->vm_flags & VM_SHARED)) {
+		ret = -EINVAL;
+		goto done;
+	}
+	dd = uctxt->dd;
+	ctxt = uctxt->ctxt;
+	subctxt = fd->subctxt;
+
+	/*
+	 * vm_pgoff is used as a buffer selector cookie.  Always mmap from
+	 * the beginning.
+	 */ 
+	vma->vm_pgoff = 0;
+	flags = vma->vm_flags;
+
+	switch (type) {
+	case PIO_BUFS:
+	case PIO_BUFS_SOP:
+		memaddr = ((dd->physaddr + TXE_PIO_SEND) +
+				/* chip pio base */
+			   (uctxt->sc->hw_context * BIT(16))) +
+				/* 64K PIO space / ctxt */
+			(type == PIO_BUFS_SOP ?
+				(TXE_PIO_SIZE / 2) : 0); /* sop? */
+		/*
+		 * Map only the amount allocated to the context, not the
+		 * entire available context's PIO space.
+		 */
+		memlen = PAGE_ALIGN(uctxt->sc->credits * PIO_BLOCK_SIZE);
+		flags &= ~VM_MAYREAD;
+		flags |= VM_DONTCOPY | VM_DONTEXPAND;
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+		mapio = 1;
+		break;
+	case PIO_CRED: {
+		u64 cr_page_offset;
+		if (flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		/*
+		 * The credit return location for this context could be on the
+		 * second or third page allocated for credit returns (if number
+		 * of enabled contexts > 64 and 128 respectively).
+		 */
+		cr_page_offset = ((u64)uctxt->sc->hw_free -
+			  	     (u64)dd->cr_base[uctxt->numa_id].va) &
+				   PAGE_MASK;
+		memvirt = (void *)dd->cr_base[uctxt->numa_id].va + cr_page_offset;
+		memdma = dd->cr_base[uctxt->numa_id].dma + cr_page_offset;
+		memlen = PAGE_SIZE;
+		flags &= ~VM_MAYWRITE;
+		flags |= VM_DONTCOPY | VM_DONTEXPAND;
+		/*
+		 * The driver has already allocated memory for credit
+		 * returns and programmed it into the chip. Has that
+		 * memory been flagged as non-cached?
+		 */
+		/* vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot); */
+		break;
+	}
+	case RCV_RHEQ:
+		memlen = rheq_size(uctxt);
+		memvirt = uctxt->rheq;
+		memdma = uctxt->rheq_dma;
+		if (!memvirt) {
+			ret = -EINVAL;
+			goto done;
+		}
+		if (vma->vm_flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		break;
+	case RCV_HDRQ:
+		memlen = rcvhdrq_size(uctxt);
+		memvirt = uctxt->rcvhdrq;
+		memdma = uctxt->rcvhdrq_dma;
+		break;
+	case RCV_EGRBUF: {
+		unsigned long vm_start_save;
+		unsigned long vm_end_save;
+		int i;
+		/*
+		 * The RcvEgr buffer need to be handled differently
+		 * as multiple non-contiguous pages need to be mapped
+		 * into the user process.
+		 */
+		memlen = uctxt->egrbufs.size;
+		if ((vma->vm_end - vma->vm_start) != memlen) {
+			dd_dev_err(dd, "Eager buffer map size invalid (%lu != %lu)\n",
+				   (vma->vm_end - vma->vm_start), memlen);
+			ret = -EINVAL;
+			goto done;
+		}
+		if (vma->vm_flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		vm_flags_clear(vma, VM_MAYWRITE);
+		/*
+		 * Mmap multiple separate allocations into a single vma.  From
+		 * here, dma_mmap_coherent() calls dma_direct_mmap(), which
+		 * requires the mmap to exactly fill the vma starting at
+		 * vma_start.  Adjust the vma start and end for each eager
+		 * buffer segment mapped.  Restore the originals when done.
+		 */
+		vm_start_save = vma->vm_start;
+		vm_end_save = vma->vm_end;
+		vma->vm_end = vma->vm_start;
+		for (i = 0 ; i < uctxt->egrbufs.numbufs; i++) {
+			memlen = uctxt->egrbufs.buffers[i].len;
+			memvirt = uctxt->egrbufs.buffers[i].addr;
+			memdma = uctxt->egrbufs.buffers[i].dma;
+			vma->vm_end += memlen;
+			mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr,
+				  memvirt, memdma, memlen, vma);
+			ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+						memvirt, memdma, memlen);
+			if (ret < 0) {
+				vma->vm_start = vm_start_save;
+				vma->vm_end = vm_end_save;
+				goto done;
+			}
+			vma->vm_start += memlen;
+		}
+		vma->vm_start = vm_start_save;
+		vma->vm_end = vm_end_save;
+		ret = 0;
+		goto done;
+	}
+	case UREGS:
+		/*
+		 * Map the part of BAR0 that contains this context's user
+		 * registers.  RcvHdrTail is the first register in the hardware
+		 * UCTXT block.  The TidFlow table is contained within this
+		 * memory range.
+		 */
+		memaddr = (unsigned long)dd->physaddr +
+				dd->params->rcv_hdr_tail_reg +
+				(uctxt->ctxt * dd->params->rxe_uctxt_stride);
+		memlen = dd->params->rxe_uctxt_stride;
+		// hack: accept a 4K mmap for uregs
+		{
+		ssize_t sz = vma->vm_end - vma->vm_start;
+		if (sz != memlen && sz == PAGE_SIZE) {
+			printk("%s: UREGS override memlen to 4K\n", __func__);
+			memlen = PAGE_SIZE;
+		}
+		}
+		flags |= VM_DONTCOPY | VM_DONTEXPAND;
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		mapio = 1;
+		break;
+	case EVENTS:
+		/*
+		 * Use the page where this context's flags are. User level
+		 * knows where it's own bitmap is within the page.
+		 */
+		memaddr = (unsigned long)
+			(dd->events + uctxt_offset(uctxt)) & PAGE_MASK;
+		memlen = PAGE_SIZE;
+		/*
+		 * v3.7 removes VM_RESERVED but the effect is kept by
+		 * using VM_IO.
+		 */
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	case STATUS:
+		if (flags & VM_WRITE) {
+			ret = -EPERM;
+			goto done;
+		}
+		memaddr = kvirt_to_phys((void *)dd->status);
+		memlen = PAGE_SIZE;
+		flags |= VM_IO | VM_DONTEXPAND;
+		break;
+	case RTAIL:
+		if (!HFI2_CAP_IS_USET(DMA_RTAIL)) {
+			/*
+			 * If the memory allocation failed, the context alloc
+			 * also would have failed, so we would never get here
+			 */
+			ret = -EINVAL;
+			goto done;
+		}
+		if ((flags & VM_WRITE) || !hfi2_rcvhdrtail_kvaddr(uctxt)) {
+			ret = -EPERM;
+			goto done;
+		}
+		memlen = PAGE_SIZE;
+		memvirt = (void *)hfi2_rcvhdrtail_kvaddr(uctxt);
+		memdma = uctxt->rcvhdrqtailaddr_dma;
+		flags &= ~VM_MAYWRITE;
+		break;
+	case SUBCTXT_UREGS:
+		memaddr = (u64)uctxt->subctxt_uregbase;
+		memlen = PAGE_SIZE;
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	case SUBCTXT_RCV_HDRQ:
+		memaddr = (u64)uctxt->subctxt_rcvhdr_base;
+		memlen = rcvhdrq_size(uctxt) * uctxt->subctxt_cnt;
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	case SUBCTXT_EGRBUF:
+		memaddr = (u64)uctxt->subctxt_rcvegrbuf;
+		memlen = uctxt->egrbufs.size * uctxt->subctxt_cnt;
+		flags |= VM_IO | VM_DONTEXPAND;
+		flags &= ~VM_MAYWRITE;
+		vmf = 1;
+		break;
+	case SDMA_COMP: {
+		struct hfi2_user_sdma_comp_q *cq = fd->cq;
+
+		if (!cq) {
+			ret = -EFAULT;
+			goto done;
+		}
+		memaddr = (u64)cq->comps;
+		memlen = PAGE_ALIGN(sizeof(*cq->comps) * cq->nentries);
+		flags |= VM_IO | VM_DONTEXPAND;
+		vmf = 1;
+		break;
+	}
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if ((vma->vm_end - vma->vm_start) != memlen) {
+		hfi2_cdbg(PROC, "%u:%u Memory size mismatch %lu:%lu",
+			  uctxt->ctxt, fd->subctxt,
+			  (vma->vm_end - vma->vm_start), memlen);
+		ret = -EINVAL;
+		goto done;
+	}
+
+	vm_flags_reset(vma, flags);
+	mmap_cdbg(ctxt, subctxt, type, mapio, vmf, memaddr, memvirt, memdma, 
+		  memlen, vma);
+	if (vmf) {
+		vma->vm_pgoff = PFN_DOWN(memaddr);
+		vma->vm_ops = &vm_ops;
+		ret = 0;
+	} else if (memdma) {
+		ret = dma_mmap_coherent(&dd->pcidev->dev, vma,
+					memvirt, memdma, memlen);
+	} else if (mapio) {
+		ret = io_remap_pfn_range(vma, vma->vm_start,
+					 PFN_DOWN(memaddr),
+					 memlen,
+					 vma->vm_page_prot);
+	} else if (memvirt) {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      PFN_DOWN(__pa(memvirt)),
+				      memlen,
+				      vma->vm_page_prot);
+	} else {
+		ret = remap_pfn_range(vma, vma->vm_start,
+				      PFN_DOWN(memaddr),
+				      memlen,
+				      vma->vm_page_prot);
+	}
+done:
+	return ret;
+}
+
+/*
+ * Local (non-chip) user memory is not mapped right away but as it is
+ * accessed by the user-level code.
+ */
+static vm_fault_t vma_fault(struct vm_fault *vmf)
+{
+	struct page *page;
+
+	page = vmalloc_to_page((void *)(vmf->pgoff << PAGE_SHIFT));
+	if (!page)
+		return VM_FAULT_SIGBUS;
+
+	get_page(page);
+	vmf->page = page;
+
+	return 0;
+}
+
+void hfi2_dealloc_filedata(struct hfi2_filedata *fdata)
+{
+	struct hfi2_ctxtdata *uctxt = fdata->uctxt;
+	struct hfi2_devdata *dd = fdata->dd;
+	unsigned long flags, *ev;
+
+	if (!uctxt)
+		goto done;
+
+	hfi2_cdbg(PROC, "closing ctxt %u:%u", uctxt->ctxt, fdata->subctxt);
+
+	flush_wc();
+	/* drain user sdma queue */
+	hfi2_user_sdma_free_queues(fdata, uctxt);
+
+	/* release the cpu */
+	hfi2_put_proc_affinity(fdata->rec_cpu_num);
+
+	/* clean up rcv side */
+	hfi2_user_exp_rcv_free(fdata);
+
+	/*
+	 * fdata->uctxt is used in the above cleanup.  It is not ready to be
+	 * removed until here.
+	 */
+	fdata->uctxt = NULL;
+	hfi2_rcd_put(uctxt);
+
+	/*
+	 * Clear any left over, unhandled events so the next process that
+	 * gets this context doesn't get confused.
+	 */
+	ev = dd->events + uctxt_offset(uctxt) + fdata->subctxt;
+	*ev = 0;
+
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	__clear_bit(fdata->subctxt, uctxt->in_use_ctxts);
+	if (!bitmap_empty(uctxt->in_use_ctxts, HFI2_MAX_SHARED_CTXTS)) {
+		spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+		goto done;
+	}
+	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+
+	/*
+	 * Disable receive context and interrupt available, reset all
+	 * RcvCtxtCtrl bits to default values.
+	 */
+	hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_DIS |
+		     HFI2_RCVCTRL_TIDFLOW_DIS |
+		     HFI2_RCVCTRL_INTRAVAIL_DIS |
+		     HFI2_RCVCTRL_TAILUPD_DIS |
+		     HFI2_RCVCTRL_ONE_PKT_EGR_DIS |
+		     HFI2_RCVCTRL_NO_RHQ_DROP_DIS |
+		     HFI2_RCVCTRL_NO_EGR_DROP_DIS |
+		     HFI2_RCVCTRL_URGENT_DIS, uctxt);
+	/* Clear the context's J_KEY */
+	hfi2_clear_ctxt_jkey(dd, uctxt);
+	/*
+	 * If a send context is allocated, reset context integrity
+	 * checks to default and disable the send context.
+	 */
+	if (uctxt->sc) {
+		sc_disable(uctxt->sc);
+		dd->params->set_pio_integrity(uctxt->sc, SPI_DEFAULT);
+	}
+
+	hfi2_free_ctxt_rcv_groups(uctxt);
+	hfi2_clear_ctxt_pkey(dd, uctxt);
+
+	uctxt->event_flags = 0;
+
+	deallocate_ctxt(uctxt);
+done:
+	cleanup_srcu_struct(&fdata->pq_srcu);
+	kfree(fdata);
+}
+
+/*
+ * Convert kernel *virtual* addresses to physical addresses.
+ * This is used to vmalloc'ed addresses.
+ */
+static u64 kvirt_to_phys(void *addr)
+{
+	struct page *page;
+	u64 paddr = 0;
+
+	page = vmalloc_to_page(addr);
+	if (page)
+		paddr = page_to_pfn(page) << PAGE_SHIFT;
+
+	return paddr;
+}
+
+/**
+ * complete_subctxt - complete sub-context info
+ * @fd: valid filedata pointer
+ *
+ * Sub-context info can only be set up after the base context
+ * has been completed.  This is indicated by the clearing of the
+ * HFI2_CTXT_BASE_UINIT bit.
+ *
+ * Wait for the bit to be cleared, and then complete the subcontext
+ * initialization.
+ *
+ */
+static int complete_subctxt(struct hfi2_filedata *fd)
+{
+	int ret;
+	unsigned long flags;
+
+	/*
+	 * sub-context info can only be set up after the base context
+	 * has been completed.
+	 */
+	ret = wait_event_interruptible(
+		fd->uctxt->wait,
+		!test_bit(HFI2_CTXT_BASE_UNINIT, &fd->uctxt->event_flags));
+
+	if (test_bit(HFI2_CTXT_BASE_FAILED, &fd->uctxt->event_flags))
+		ret = -ENOMEM;
+
+	/* Finish the sub-context init */
+	if (!ret) {
+		fd->rec_cpu_num = hfi2_get_proc_affinity(fd->uctxt->numa_id);
+		ret = init_user_ctxt(fd, fd->uctxt);
+	}
+
+	if (ret) {
+		spin_lock_irqsave(&fd->dd->uctxt_lock, flags);
+		__clear_bit(fd->subctxt, fd->uctxt->in_use_ctxts);
+		spin_unlock_irqrestore(&fd->dd->uctxt_lock, flags);
+		hfi2_rcd_put(fd->uctxt);
+		fd->uctxt = NULL;
+	}
+
+	return ret;
+}
+
+int hfi2_do_assign_ctxt(struct hfi2_filedata *fd,
+			const struct hfi2_assign_ctxt_cmd *uinfo)
+{
+	struct hfi2_ctxtdata *uctxt = NULL;
+	int ret;
+	u8 pidx = uinfo->port - 1;
+	u8 kdeth_rcv_hdr = uinfo->kdeth_rcvhdrsz;
+
+	if (fd->uctxt)
+		return -EINVAL;
+
+	if (uinfo->subctxt_cnt > HFI2_MAX_SHARED_CTXTS)
+		return -EINVAL;
+
+	/* check, then assign port ASAP */
+	if (pidx >= fd->dd->num_pports)
+		return -EINVAL;
+	fd->ppd = fd->dd->pport + pidx;
+
+	/* verify kdeth receive header size */
+	if (kdeth_rcv_hdr == 0) /* change to default size */
+		kdeth_rcv_hdr = DEFAULT_RCVHDRSIZE;
+	if (kdeth_rcv_hdr < 2 || kdeth_rcv_hdr > 31) /* valid HW range */
+		return -EINVAL;
+
+	/*
+	 * Acquire the mutex to protect against multiple creations of what
+	 * could be a shared base context.
+	 */
+	mutex_lock(&hfi2_mutex);
+	/*
+	 * Get a sub context if available  (fd->uctxt will be set).
+	 * ret < 0 error, 0 no context, 1 sub-context found
+	 */
+	ret = find_sub_ctxt(fd, uinfo);
+
+	/*
+	 * Allocate a base context if context sharing is not required or a
+	 * sub context wasn't found.
+	 */
+	if (!ret) {
+		ret = allocate_ctxt(fd, uinfo, &uctxt);
+		if (ret == 0) {
+			/* override - must be done before setup_base_ctxt() */
+			uctxt->kdeth_rcv_hdr = kdeth_rcv_hdr;
+		}
+	}
+
+	mutex_unlock(&hfi2_mutex);
+
+	/* Depending on the context type, finish the appropriate init */
+	switch (ret) {
+	case 0:
+		ret = setup_base_ctxt(fd, uctxt);
+		if (ret)
+			deallocate_ctxt(uctxt);
+		break;
+	case 1:
+		ret = complete_subctxt(fd);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+/**
+ * match_ctxt - match context
+ * @fd: valid filedata pointer
+ * @uinfo: user info to compare base context with
+ * @uctxt: context to compare uinfo to.
+ *
+ * Compare the given context with the given information to see if it
+ * can be used for a sub context.
+ */
+static int match_ctxt(struct hfi2_filedata *fd,
+		      const struct hfi2_assign_ctxt_cmd *uinfo,
+		      struct hfi2_ctxtdata *uctxt)
+{
+	struct hfi2_devdata *dd = fd->dd;
+	unsigned long flags;
+	u16 subctxt;
+
+	/* Skip dynamically allocated kernel contexts */
+	if (uctxt->sc && (uctxt->sc->type == SC_KERNEL))
+		return 0;
+
+	/* Skip ctxt if it doesn't match the requested one */
+	if (memcmp(uctxt->uuid, uinfo->uuid, sizeof(uctxt->uuid)) ||
+	    uctxt->jkey != generate_jkey(current_uid()) ||
+	    uctxt->subctxt_id != uinfo->subctxt_id ||
+	    uctxt->subctxt_cnt != uinfo->subctxt_cnt)
+		return 0;
+
+	/* Verify the sharing process matches the base */
+	if (uctxt->userversion != uinfo->userversion)
+		return -EINVAL;
+
+	/* Find an unused sub context */
+	spin_lock_irqsave(&dd->uctxt_lock, flags);
+	if (bitmap_empty(uctxt->in_use_ctxts, HFI2_MAX_SHARED_CTXTS)) {
+		/* context is being closed, do not use */
+		spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+		return 0;
+	}
+
+	subctxt = find_first_zero_bit(uctxt->in_use_ctxts,
+				      HFI2_MAX_SHARED_CTXTS);
+	if (subctxt >= uctxt->subctxt_cnt) {
+		spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+		return -EBUSY;
+	}
+
+	fd->subctxt = subctxt;
+	__set_bit(fd->subctxt, uctxt->in_use_ctxts);
+	spin_unlock_irqrestore(&dd->uctxt_lock, flags);
+
+	fd->uctxt = uctxt;
+	hfi2_rcd_get(uctxt);
+
+	return 1;
+}
+
+/**
+ * find_sub_ctxt - fund sub-context
+ * @fd: valid filedata pointer
+ * @uinfo: matching info to use to find a possible context to share.
+ *
+ * The hfi2_mutex must be held when this function is called.  It is
+ * necessary to ensure serialized creation of shared contexts.
+ *
+ * Return:
+ *    0      No sub-context found
+ *    1      Subcontext found and allocated
+ *    errno  EINVAL (incorrect parameters)
+ *           EBUSY (all sub contexts in use)
+ */
+static int find_sub_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo)
+{
+	struct hfi2_ctxtdata *uctxt;
+	struct hfi2_devdata *dd = fd->dd;
+	struct hfi2_pportdata *ppd = fd->ppd;
+	u16 i;
+	int ret;
+
+	if (!uinfo->subctxt_cnt)
+		return 0;
+
+	for (i = ppd->first_dyn_alloc_ctxt;
+	     i < ppd->rcv_context_base + ppd->num_rcv_contexts;
+	     i++) {
+		uctxt = hfi2_rcd_get_by_index(dd, i);
+		if (uctxt) {
+			ret = match_ctxt(fd, uinfo, uctxt);
+			hfi2_rcd_put(uctxt);
+			/* value of != 0 will return */
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* return true if there are any user allocated contexts across all ports */
+static bool any_user_allocated_contexts(struct hfi2_devdata *dd)
+{
+	int i;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		if (dd->pport[i].freectxts != dd->pport[i].num_user_contexts)
+			return true;
+	}
+	return false;
+}
+
+static int allocate_ctxt(struct hfi2_filedata *fd,
+			 const struct hfi2_assign_ctxt_cmd *uinfo,
+			 struct hfi2_ctxtdata **rcd)
+{
+	struct hfi2_devdata *dd = fd->dd;
+	struct hfi2_pportdata *ppd = fd->ppd;
+	struct hfi2_ctxtdata *uctxt;
+	int ret, numa;
+
+	if (dd->flags & HFI2_FROZEN) {
+		/*
+		 * Pick an error that is unique from all other errors
+		 * that are returned so the user process knows that
+		 * it tried to allocate while the SPC was frozen.  It
+		 * it should be able to retry with success in a short
+		 * while.
+		 */
+		return -EIO;
+	}
+
+	if (!ppd->freectxts)
+		return -EBUSY;
+
+	/*
+	 * If we don't have a NUMA node requested, preference is towards
+	 * device NUMA node.
+	 */
+	fd->rec_cpu_num = hfi2_get_proc_affinity(dd->node);
+	if (fd->rec_cpu_num != -1)
+		numa = cpu_to_node(fd->rec_cpu_num);
+	else
+		numa = numa_node_id();
+	ret = hfi2_create_ctxtdata(ppd, numa, DYNAMIC_CONTEXT, &uctxt);
+	if (ret < 0) {
+		dd_dev_err(dd, "user ctxtdata allocation failed\n");
+		return ret;
+	}
+	hfi2_cdbg(PROC, "[%u:%u] pid %u assigned to CPU %d (NUMA %u)",
+		  uctxt->ctxt, fd->subctxt, current->pid, fd->rec_cpu_num,
+		  uctxt->numa_id);
+
+	/*
+	 * Allocate and enable a PIO send context.
+	 */
+	uctxt->sc = sc_alloc(ppd, SC_USER, uctxt->rcvhdrqentsize, numa);
+	if (!uctxt->sc) {
+		ret = -ENOMEM;
+		goto ctxdata_free;
+	}
+	hfi2_cdbg(PROC, "allocated send context %u(%u)", uctxt->sc->sw_index,
+		  uctxt->sc->hw_context);
+	ret = sc_enable(uctxt->sc);
+	if (ret)
+		goto ctxdata_free;
+
+	/*
+	 * Setup sub context information if the user-level has requested
+	 * sub contexts.
+	 * This has to be done here so the rest of the sub-contexts find the
+	 * proper base context.
+	 * NOTE: _set_bit() can be used here because the context creation is
+	 * protected by the mutex (rather than the spin_lock), and will be the
+	 * very first instance of this context.
+	 */
+	__set_bit(0, uctxt->in_use_ctxts);
+	if (uinfo->subctxt_cnt)
+		init_subctxts(uctxt, uinfo);
+	uctxt->userversion = uinfo->userversion;
+	uctxt->flags = hfi2_cap_mask; /* save current flag state */
+	init_waitqueue_head(&uctxt->wait);
+	strscpy(uctxt->comm, current->comm, sizeof(uctxt->comm));
+	memcpy(uctxt->uuid, uinfo->uuid, sizeof(uctxt->uuid));
+	uctxt->jkey = generate_jkey(current_uid());
+	hfi2_stats.sps_ctxts++;
+	/*
+	 * Disable ASPM when there are open user/PSM contexts to avoid
+	 * issues with ASPM L1 exit latency
+	 */
+	if (!any_user_allocated_contexts(dd))
+		aspm_disable_all(dd);
+	ppd->freectxts--;
+
+	*rcd = uctxt;
+
+	return 0;
+
+ctxdata_free:
+	hfi2_free_ctxt(uctxt);
+	return ret;
+}
+
+static void deallocate_ctxt(struct hfi2_ctxtdata *uctxt)
+{
+	mutex_lock(&hfi2_mutex);
+	hfi2_stats.sps_ctxts--;
+	uctxt->ppd->freectxts++;
+	/* enable ASPM if there are no user contexts */
+	if (!any_user_allocated_contexts(uctxt->dd))
+		aspm_enable_all(uctxt->dd);
+	mutex_unlock(&hfi2_mutex);
+
+	hfi2_free_ctxt(uctxt);
+}
+
+static void init_subctxts(struct hfi2_ctxtdata *uctxt,
+			  const struct hfi2_assign_ctxt_cmd *uinfo)
+{
+	uctxt->subctxt_cnt = uinfo->subctxt_cnt;
+	uctxt->subctxt_id = uinfo->subctxt_id;
+	set_bit(HFI2_CTXT_BASE_UNINIT, &uctxt->event_flags);
+}
+
+static int setup_subctxt(struct hfi2_ctxtdata *uctxt)
+{
+	int ret = 0;
+	u16 num_subctxts = uctxt->subctxt_cnt;
+
+	uctxt->subctxt_uregbase = vmalloc_user(PAGE_SIZE);
+	if (!uctxt->subctxt_uregbase)
+		return -ENOMEM;
+
+	/* We can take the size of the RcvHdr Queue from the master */
+	uctxt->subctxt_rcvhdr_base = vmalloc_user(rcvhdrq_size(uctxt) *
+						  num_subctxts);
+	if (!uctxt->subctxt_rcvhdr_base) {
+		ret = -ENOMEM;
+		goto bail_ureg;
+	}
+
+	uctxt->subctxt_rcvegrbuf = vmalloc_user(uctxt->egrbufs.size *
+						num_subctxts);
+	if (!uctxt->subctxt_rcvegrbuf) {
+		ret = -ENOMEM;
+		goto bail_rhdr;
+	}
+
+	return 0;
+
+bail_rhdr:
+	vfree(uctxt->subctxt_rcvhdr_base);
+	uctxt->subctxt_rcvhdr_base = NULL;
+bail_ureg:
+	vfree(uctxt->subctxt_uregbase);
+	uctxt->subctxt_uregbase = NULL;
+
+	return ret;
+}
+
+static void user_init(struct hfi2_ctxtdata *uctxt)
+{
+	unsigned int rcvctrl_ops = 0;
+
+	/* initialize poll variables... */
+	uctxt->urgent = 0;
+	uctxt->urgent_poll = 0;
+
+	/*
+	 * Now enable the ctxt for receive.
+	 * For chips that are set to DMA the tail register to memory
+	 * when they change (and when the update bit transitions from
+	 * 0 to 1.  So for those chips, we turn it off and then back on.
+	 * This will (very briefly) affect any other open ctxts, but the
+	 * duration is very short, and therefore isn't an issue.  We
+	 * explicitly set the in-memory tail copy to 0 beforehand, so we
+	 * don't have to wait to be sure the DMA update has happened
+	 * (chip resets head/tail to 0 on transition to enable).
+	 */
+	if (hfi2_rcvhdrtail_kvaddr(uctxt))
+		clear_rcvhdrtail(uctxt);
+
+	/* Setup J_KEY before enabling the context */
+	hfi2_set_ctxt_jkey(uctxt->dd, uctxt, uctxt->jkey);
+
+	rcvctrl_ops = HFI2_RCVCTRL_CTXT_ENB;
+	rcvctrl_ops |= HFI2_RCVCTRL_URGENT_ENB;
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, HDRSUPP))
+		rcvctrl_ops |= HFI2_RCVCTRL_TIDFLOW_ENB;
+	/*
+	 * Ignore the bit in the flags for now until proper
+	 * support for multiple packet per rcv array entry is
+	 * added.
+	 */
+	if (!HFI2_CAP_UGET_MASK(uctxt->flags, MULTI_PKT_EGR))
+		rcvctrl_ops |= HFI2_RCVCTRL_ONE_PKT_EGR_ENB;
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, NODROP_EGR_FULL))
+		rcvctrl_ops |= HFI2_RCVCTRL_NO_EGR_DROP_ENB;
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, NODROP_RHQ_FULL))
+		rcvctrl_ops |= HFI2_RCVCTRL_NO_RHQ_DROP_ENB;
+	/*
+	 * The RcvCtxtCtrl.TailUpd bit has to be explicitly written.
+	 * We can't rely on the correct value to be set from prior
+	 * uses of the chip or ctxt. Therefore, add the rcvctrl op
+	 * for both cases.
+	 */
+	if (HFI2_CAP_UGET_MASK(uctxt->flags, DMA_RTAIL))
+		rcvctrl_ops |= HFI2_RCVCTRL_TAILUPD_ENB;
+	else
+		rcvctrl_ops |= HFI2_RCVCTRL_TAILUPD_DIS;
+	hfi2_rcvctrl(uctxt->dd, rcvctrl_ops, uctxt);
+}
+
+static int init_user_ctxt(struct hfi2_filedata *fd,
+			  struct hfi2_ctxtdata *uctxt)
+{
+	int ret;
+
+	ret = hfi2_user_sdma_alloc_queues(uctxt, fd);
+	if (ret)
+		return ret;
+
+	ret = hfi2_user_exp_rcv_init(fd, uctxt);
+	if (ret)
+		hfi2_user_sdma_free_queues(fd, uctxt);
+
+	return ret;
+}
+
+static int setup_base_ctxt(struct hfi2_filedata *fd,
+			   struct hfi2_ctxtdata *uctxt)
+{
+	struct hfi2_devdata *dd = uctxt->dd;
+	int ret = 0;
+
+	hfi2_init_ctxt(uctxt->sc);
+
+	/* Now allocate the RcvHdr queue and eager buffers. */
+	ret = hfi2_create_rcvhdrq(dd, uctxt);
+	if (ret)
+		goto done;
+
+	ret = hfi2_setup_eagerbufs(uctxt);
+	if (ret)
+		goto done;
+
+	/* If sub-contexts are enabled, do the appropriate setup */
+	if (uctxt->subctxt_cnt)
+		ret = setup_subctxt(uctxt);
+	if (ret)
+		goto done;
+
+	ret = hfi2_alloc_ctxt_rcv_groups(uctxt);
+	if (ret)
+		goto done;
+
+	ret = init_user_ctxt(fd, uctxt);
+	if (ret) {
+		hfi2_free_ctxt_rcv_groups(uctxt);
+		goto done;
+	}
+
+	user_init(uctxt);
+
+	/* Now that the context is set up, the fd can get a reference. */
+	fd->uctxt = uctxt;
+	hfi2_rcd_get(uctxt);
+
+done:
+	if (uctxt->subctxt_cnt) {
+		/*
+		 * On error, set the failed bit so sub-contexts will clean up
+		 * correctly.
+		 */
+		if (ret)
+			set_bit(HFI2_CTXT_BASE_FAILED, &uctxt->event_flags);
+
+		/*
+		 * Base context is done (successfully or not), notify anybody
+		 * using a sub-context that is waiting for this completion.
+		 */
+		clear_bit(HFI2_CTXT_BASE_UNINIT, &uctxt->event_flags);
+		wake_up(&uctxt->wait);
+	}
+
+	return ret;
+}
+
+/*
+ * Find all user contexts in use, and set the specified bit in their
+ * event mask.
+ * See also find_ctxt() for a similar use, that is specific to send buffers.
+ */
+int hfi2_set_uevent_bits(struct hfi2_pportdata *ppd, const int evtbit)
+{
+	struct hfi2_ctxtdata *uctxt;
+	struct hfi2_devdata *dd = ppd->dd;
+	u16 ctxt;
+
+	if (!dd->events)
+		return -EINVAL;
+
+	for (ctxt = ppd->first_dyn_alloc_ctxt;
+	     ctxt < ppd->rcv_context_base + ppd->num_rcv_contexts;
+	     ctxt++) {
+		uctxt = hfi2_rcd_get_by_index(dd, ctxt);
+		if (uctxt) {
+			unsigned long *evs;
+			int i;
+			/*
+			 * subctxt_cnt is 0 if not shared, so do base
+			 * separately, first, then remaining subctxt, if any
+			 */
+			evs = dd->events + uctxt_offset(uctxt);
+			set_bit(evtbit, evs);
+			for (i = 1; i < uctxt->subctxt_cnt; i++)
+				set_bit(evtbit, evs + i);
+			hfi2_rcd_put(uctxt);
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * manage_rcvq - manage a context's receive queue
+ * @uctxt: the context
+ * @subctxt: the sub-context
+ * @start_stop: action to carry out
+ *
+ * start_stop == 0 disables receive on the context, for use in queue
+ * overflow conditions.  start_stop==1 re-enables, to be used to
+ * re-init the software copy of the head register
+ */
+int manage_rcvq(struct hfi2_ctxtdata *uctxt, u16 subctxt, int start_stop)
+{
+	struct hfi2_devdata *dd = uctxt->dd;
+	unsigned int rcvctrl_op;
+
+	if (subctxt)
+		return 0;
+
+	/* atomically clear receive enable ctxt. */
+	if (start_stop) {
+		/*
+		 * On enable, force in-memory copy of the tail register to
+		 * 0, so that protocol code doesn't have to worry about
+		 * whether or not the chip has yet updated the in-memory
+		 * copy or not on return from the system call. The chip
+		 * always resets it's tail register back to 0 on a
+		 * transition from disabled to enabled.
+		 */
+		if (hfi2_rcvhdrtail_kvaddr(uctxt))
+			clear_rcvhdrtail(uctxt);
+		rcvctrl_op = HFI2_RCVCTRL_CTXT_ENB;
+	} else {
+		rcvctrl_op = HFI2_RCVCTRL_CTXT_DIS;
+	}
+	hfi2_rcvctrl(dd, rcvctrl_op, uctxt);
+	/* always; new head should be equal to new tail; see above */
+
+	return 0;
+}
+
+/*
+ * clear the event notifier events for this context.
+ * User process then performs actions appropriate to bit having been
+ * set, if desired, and checks again in future.
+ */
+int user_event_ack(struct hfi2_ctxtdata *uctxt, u16 subctxt,
+		   unsigned long events)
+{
+	int i;
+	struct hfi2_devdata *dd = uctxt->dd;
+	unsigned long *evs;
+
+	if (!dd->events)
+		return 0;
+
+	evs = dd->events + uctxt_offset(uctxt) + subctxt;
+
+	for (i = 0; i <= _HFI2_MAX_EVENT_BIT; i++) {
+		if (!test_bit(i, &events))
+			continue;
+		clear_bit(i, evs);
+	}
+	return 0;
+}
+
+int set_ctxt_pkey(struct hfi2_ctxtdata *uctxt, u16 pkey)
+{
+	int i;
+	struct hfi2_pportdata *ppd = uctxt->ppd;
+	struct hfi2_devdata *dd = uctxt->dd;
+
+	if (!HFI2_CAP_IS_USET(PKEY_CHECK))
+		return -EPERM;
+
+	if (pkey == LIM_MGMT_P_KEY || pkey == FULL_MGMT_P_KEY)
+		return -EINVAL;
+
+	for (i = 0; i < dd->params->pkey_table_size; i++)
+		if (pkey == ppd->pkeys[i])
+			return hfi2_set_ctxt_pkey(dd, uctxt, pkey);
+
+	return -ENOENT;
+}
+
+/**
+ * ctxt_reset - Reset the user context
+ * @uctxt: valid user context
+ */
+int ctxt_reset(struct hfi2_ctxtdata *uctxt)
+{
+	struct send_context *sc;
+	struct hfi2_devdata *dd;
+	int ret = 0;
+
+	if (!uctxt || !uctxt->dd || !uctxt->sc)
+		return -EINVAL;
+
+	/*
+	 * There is no protection here. User level has to guarantee that
+	 * no one will be writing to the send context while it is being
+	 * re-initialized.  If user level breaks that guarantee, it will
+	 * break it's own context and no one else's.
+	 */
+	dd = uctxt->dd;
+	sc = uctxt->sc;
+
+	/*
+	 * Wait until the interrupt handler has marked the context as
+	 * halted or frozen. Report error if we time out.
+	 */
+	wait_event_interruptible_timeout(
+		sc->halt_wait, (sc->flags & (SCF_HALTED | SCF_LINK_DOWN)),
+		msecs_to_jiffies(SEND_CTXT_HALT_TIMEOUT));
+	if (!(sc->flags & (SCF_HALTED | SCF_LINK_DOWN)))
+		return -ENOLCK;
+
+	/*
+	 * If the send context was halted due to a Freeze, wait until the
+	 * device has been "unfrozen" before resetting the context.
+	 */
+	if (sc->flags & SCF_FROZEN) {
+		wait_event_interruptible_timeout(
+			dd->event_queue,
+			!(READ_ONCE(dd->flags) & HFI2_FROZEN),
+			msecs_to_jiffies(SEND_CTXT_HALT_TIMEOUT));
+		if (dd->flags & HFI2_FROZEN)
+			return -ENOLCK;
+
+		if (dd->flags & HFI2_FORCED_FREEZE)
+			/*
+			 * Don't allow context reset if we are into
+			 * forced freeze
+			 */
+			return -ENODEV;
+
+		sc_disable(sc);
+		ret = sc_enable(sc);
+		hfi2_rcvctrl(dd, HFI2_RCVCTRL_CTXT_ENB, uctxt);
+	} else {
+		ret = sc_restart(sc);
+	}
+	if (!ret)
+		sc_return_credits(sc);
+
+	return ret;
+}
+
+/* expects stats is already zeroed with memtype and index filled in */
+int hfi2_get_pinning_stats(struct hfi2_filedata *fd,
+			   struct hfi2_pin_stats *stats)
+{
+	struct hfi2_user_sdma_pkt_q *pq;
+	int lockidx;
+	int ret;
+
+	if (!pinning_type_supported(stats->memtype))
+		return -EINVAL;
+
+	lockidx = srcu_read_lock(&fd->pq_srcu);
+	pq = srcu_dereference(fd->pq, &fd->pq_srcu);
+	if (pq)
+		ret = pinning_interfaces[stats->memtype].get_stats(pq, stats->index, stats);
+	else
+		ret = -EIO;
+	srcu_read_unlock(&fd->pq_srcu, lockidx);
+
+	return ret;
+}
diff --git a/drivers/infiniband/hw/hfi2/iowait.c b/drivers/infiniband/hw/hfi2/iowait.c
new file mode 100644
index 000000000000..f97b2bfc5910
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/iowait.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ *
+ */
+#include "iowait.h"
+#include "trace_iowait.h"
+
+/* 1 priority == 16 starve_cnt */
+#define IOWAIT_PRIORITY_STARVE_SHIFT 4
+
+void iowait_set_flag(struct iowait *wait, u32 flag)
+{
+	trace_hfi2_iowait_set(wait, flag);
+	set_bit(flag, &wait->flags);
+}
+
+bool iowait_flag_set(struct iowait *wait, u32 flag)
+{
+	return test_bit(flag, &wait->flags);
+}
+
+inline void iowait_clear_flag(struct iowait *wait, u32 flag)
+{
+	trace_hfi2_iowait_clear(wait, flag);
+	clear_bit(flag, &wait->flags);
+}
+
+/*
+ * iowait_init() - initialize wait structure
+ * @wait: wait struct to initialize
+ * @tx_limit: limit for overflow queuing
+ * @func: restart function for workqueue
+ * @sleep: sleep function for no space
+ * @resume: wakeup function for no space
+ *
+ * This function initializes the iowait
+ * structure embedded in the QP or PQ.
+ *
+ */
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
+		 void (*init_priority)(struct iowait *wait))
+{
+	int i;
+
+	wait->count = 0;
+	INIT_LIST_HEAD(&wait->list);
+	init_waitqueue_head(&wait->wait_dma);
+	init_waitqueue_head(&wait->wait_pio);
+	atomic_set(&wait->sdma_busy, 0);
+	atomic_set(&wait->pio_busy, 0);
+	wait->tx_limit = tx_limit;
+	wait->sleep = sleep;
+	wait->wakeup = wakeup;
+	wait->sdma_drained = sdma_drained;
+	wait->init_priority = init_priority;
+	wait->flags = 0;
+	for (i = 0; i < IOWAIT_SES; i++) {
+		wait->wait[i].iow = wait;
+		INIT_LIST_HEAD(&wait->wait[i].tx_head);
+		if (i == IOWAIT_IB_SE)
+			INIT_WORK(&wait->wait[i].iowork, func);
+		else
+			INIT_WORK(&wait->wait[i].iowork, tidfunc);
+	}
+}
+
+/**
+ * iowait_cancel_work - cancel all work in iowait
+ * @w: the iowait struct
+ */
+void iowait_cancel_work(struct iowait *w)
+{
+	cancel_work_sync(&iowait_get_ib_work(w)->iowork);
+	/* Make sure that the iowork for TID RDMA is used */
+	if (iowait_get_tid_work(w)->iowork.func)
+		cancel_work_sync(&iowait_get_tid_work(w)->iowork);
+}
+
+/**
+ * iowait_set_work_flag - set work flag based on leg
+ * @w: the iowait work struct
+ */
+int iowait_set_work_flag(struct iowait_work *w)
+{
+	if (w == &w->iow->wait[IOWAIT_IB_SE]) {
+		iowait_set_flag(w->iow, IOWAIT_PENDING_IB);
+		return IOWAIT_IB_SE;
+	}
+	iowait_set_flag(w->iow, IOWAIT_PENDING_TID);
+	return IOWAIT_TID_SE;
+}
+
+/**
+ * iowait_priority_update_top - update the top priority entry
+ * @w: the iowait struct
+ * @top: a pointer to the top priority entry
+ * @idx: the index of the current iowait in an array
+ * @top_idx: the array index for the iowait entry that has the top priority
+ *
+ * This function is called to compare the priority of a given
+ * iowait with the given top priority entry. The top index will
+ * be returned.
+ */
+uint iowait_priority_update_top(struct iowait *w,
+				struct iowait *top,
+				uint idx, uint top_idx)
+{
+	u8 cnt, tcnt;
+
+	/* Convert priority into starve_cnt and compare the total.*/
+	cnt = (w->priority << IOWAIT_PRIORITY_STARVE_SHIFT) + w->starved_cnt;
+	tcnt = (top->priority << IOWAIT_PRIORITY_STARVE_SHIFT) +
+		top->starved_cnt;
+	if (cnt > tcnt)
+		return idx;
+	else
+		return top_idx;
+}
diff --git a/drivers/infiniband/hw/hfi2/mmu_rb.c b/drivers/infiniband/hw/hfi2/mmu_rb.c
new file mode 100644
index 000000000000..ab368833bc44
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/mmu_rb.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2020 Cornelis Networks, Inc.
+ * Copyright(c) 2016 - 2017 Intel Corporation.
+ */
+
+#include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/mmu_notifier.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/sched/mm.h>
+
+#include "mmu_rb.h"
+#include "trace.h"
+
+static unsigned long mmu_node_start(struct mmu_rb_node *);
+static unsigned long mmu_node_last(struct mmu_rb_node *);
+static int mmu_notifier_range_start(struct mmu_notifier *,
+		const struct mmu_notifier_range *);
+static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *,
+					   unsigned long, unsigned long);
+static void release_immediate(struct kref *refcount);
+static void handle_remove(struct work_struct *work);
+
+static const struct mmu_notifier_ops mn_opts = {
+	.invalidate_range_start = mmu_notifier_range_start,
+};
+
+INTERVAL_TREE_DEFINE(struct mmu_rb_node, node, unsigned long, __last,
+		     mmu_node_start, mmu_node_last, static, __mmu_int_rb);
+
+static unsigned long mmu_node_start(struct mmu_rb_node *node)
+{
+	return node->addr & PAGE_MASK;
+}
+
+static unsigned long mmu_node_last(struct mmu_rb_node *node)
+{
+	return PAGE_ALIGN(node->addr + node->len) - 1;
+}
+
+int hfi2_mmu_rb_register(void *ops_arg,
+			 const struct mmu_rb_ops *ops,
+			 struct workqueue_struct *wq,
+			 struct mmu_rb_handler **handler)
+{
+	struct mmu_rb_handler *h;
+	void *free_ptr;
+	int ret;
+
+	free_ptr = kzalloc(sizeof(*h) + cache_line_size() - 1, GFP_KERNEL);
+	if (!free_ptr)
+		return -ENOMEM;
+
+	h = PTR_ALIGN(free_ptr, cache_line_size());
+	h->root = RB_ROOT_CACHED;
+	h->ops = ops;
+	h->ops_arg = ops_arg;
+	INIT_HLIST_NODE(&h->mn.hlist);
+	spin_lock_init(&h->lock);
+	h->mn.ops = &mn_opts;
+	INIT_WORK(&h->del_work, handle_remove);
+	INIT_LIST_HEAD(&h->del_list);
+	INIT_LIST_HEAD(&h->lru_list);
+	h->wq = wq;
+	h->free_ptr = free_ptr;
+
+	ret = mmu_notifier_register(&h->mn, current->mm);
+	if (ret) {
+		kfree(free_ptr);
+		return ret;
+	}
+
+	*handler = h;
+	return 0;
+}
+
+void hfi2_mmu_rb_unregister(struct mmu_rb_handler *handler)
+{
+	struct mmu_rb_node *rbnode;
+	struct rb_node *node;
+	unsigned long flags;
+	struct list_head del_list;
+
+	/* Prevent freeing of mm until we are completely finished. */
+	mmgrab(handler->mn.mm);
+
+	/* Unregister first so we don't get any more notifications. */
+	mmu_notifier_unregister(&handler->mn, handler->mn.mm);
+
+	/*
+	 * Make sure the wq delete handler is finished running.  It will not
+	 * be triggered once the mmu notifiers are unregistered above.
+	 */
+	flush_work(&handler->del_work);
+
+	INIT_LIST_HEAD(&del_list);
+
+	spin_lock_irqsave(&handler->lock, flags);
+	while ((node = rb_first_cached(&handler->root))) {
+		rbnode = rb_entry(node, struct mmu_rb_node, node);
+		rb_erase_cached(node, &handler->root);
+		/* move from LRU list to delete list */
+		list_move(&rbnode->list, &del_list);
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	while (!list_empty(&del_list)) {
+		rbnode = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&rbnode->list);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
+
+	/* Now the mm may be freed. */
+	mmdrop(handler->mn.mm);
+
+	kfree(handler->free_ptr);
+}
+
+int hfi2_mmu_rb_insert(struct mmu_rb_handler *handler,
+		       struct mmu_rb_node *mnode)
+{
+	struct mmu_rb_node *node;
+	unsigned long flags;
+	int ret = 0;
+
+	trace_hfi2_mmu_rb_insert(mnode);
+
+	if (current->mm != handler->mn.mm)
+		return -EPERM;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	node = __mmu_rb_search(handler, mnode->addr, mnode->len);
+	if (node) {
+		ret = -EEXIST;
+		goto unlock;
+	}
+	__mmu_int_rb_insert(mnode, &handler->root);
+	list_add_tail(&mnode->list, &handler->lru_list);
+	mnode->handler = handler;
+unlock:
+	spin_unlock_irqrestore(&handler->lock, flags);
+	return ret;
+}
+
+/* Caller must hold handler lock */
+struct mmu_rb_node *hfi2_mmu_rb_get_first(struct mmu_rb_handler *handler,
+					  unsigned long addr, unsigned long len)
+{
+	struct mmu_rb_node *node;
+
+	trace_hfi2_mmu_rb_search(addr, len);
+	node = __mmu_int_rb_iter_first(&handler->root, addr, (addr + len) - 1);
+	if (node)
+		list_move_tail(&node->list, &handler->lru_list);
+	return node;
+}
+
+/* Caller must hold handler lock */
+static struct mmu_rb_node *__mmu_rb_search(struct mmu_rb_handler *handler,
+					   unsigned long addr,
+					   unsigned long len)
+{
+	struct mmu_rb_node *node = NULL;
+
+	trace_hfi2_mmu_rb_search(addr, len);
+	if (!handler->ops->filter) {
+		node = __mmu_int_rb_iter_first(&handler->root, addr,
+					       (addr + len) - 1);
+	} else {
+		for (node = __mmu_int_rb_iter_first(&handler->root, addr,
+						    (addr + len) - 1);
+		     node;
+		     node = __mmu_int_rb_iter_next(node, addr,
+						   (addr + len) - 1)) {
+			if (handler->ops->filter(node, addr, len))
+				return node;
+		}
+	}
+	return node;
+}
+
+/*
+ * Must NOT call while holding mnode->handler->lock.
+ * mnode->handler->ops->remove() may sleep and mnode->handler->lock is a
+ * spinlock.
+ */
+static void release_immediate(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	trace_hfi2_mmu_release_node(mnode);
+	mnode->handler->ops->remove(mnode->handler->ops_arg, mnode);
+}
+
+/* Caller must hold mnode->handler->lock */
+static void release_nolock(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	queue_work(mnode->handler->wq, &mnode->handler->del_work);
+}
+
+/*
+ * struct mmu_rb_node->refcount kref_put() callback.
+ * Adds mmu_rb_node to mmu_rb_node->handler->del_list and queues
+ * handler->del_work on handler->wq.
+ * Does not remove mmu_rb_node from handler->lru_list or handler->rb_root.
+ * Acquires mmu_rb_node->handler->lock; do not call while already holding
+ * handler->lock.
+ */
+void hfi2_mmu_rb_release(struct kref *refcount)
+{
+	struct mmu_rb_node *mnode =
+		container_of(refcount, struct mmu_rb_node, refcount);
+	struct mmu_rb_handler *handler = mnode->handler;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_move(&mnode->list, &mnode->handler->del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+	queue_work(handler->wq, &handler->del_work);
+}
+
+void hfi2_mmu_rb_evict(struct mmu_rb_handler *handler, void *evict_arg)
+{
+	struct mmu_rb_node *rbnode, *ptr;
+	struct list_head del_list;
+	unsigned long flags;
+	bool stop = false;
+
+	if (current->mm != handler->mn.mm)
+		return;
+
+	INIT_LIST_HEAD(&del_list);
+
+	spin_lock_irqsave(&handler->lock, flags);
+	list_for_each_entry_safe(rbnode, ptr, &handler->lru_list, list) {
+		/* refcount == 1 implies mmu_rb_handler has only rbnode ref */
+		if (kref_read(&rbnode->refcount) > 1)
+			continue;
+
+		if (handler->ops->evict(handler->ops_arg, rbnode, evict_arg,
+					&stop)) {
+			__mmu_int_rb_remove(rbnode, &handler->root);
+			/* move from LRU list to delete list */
+			list_move(&rbnode->list, &del_list);
+			++handler->internal_evictions;
+		}
+		if (stop)
+			break;
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	list_for_each_entry_safe(rbnode, ptr, &del_list, list) {
+		trace_hfi2_mmu_rb_evict(rbnode);
+		kref_put(&rbnode->refcount, release_immediate);
+	}
+}
+
+unsigned long hfi2_mmu_rb_for_n(struct mmu_rb_handler *handler,
+				unsigned long start, int count,
+				void (*fn)(const struct mmu_rb_node *rb_node, void *),
+				void *arg)
+{
+	struct mmu_rb_node *node = NULL, *next;
+	int i;
+
+	next = __mmu_int_rb_iter_first(&handler->root, start, ~0ULL - start);
+	for (i = 0; i < count; i++) {
+		node = next;
+		if (!node)
+			return ~0UL;
+
+		next = __mmu_int_rb_iter_next(node, start + node->len, ~0ULL);
+		fn(node, arg);
+	}
+	return node->addr;
+}
+
+static int mmu_notifier_range_start(struct mmu_notifier *mn,
+		const struct mmu_notifier_range *range)
+{
+	struct mmu_rb_handler *handler =
+		container_of(mn, struct mmu_rb_handler, mn);
+	struct rb_root_cached *root = &handler->root;
+	struct mmu_rb_node *node, *ptr = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	for (node = __mmu_int_rb_iter_first(root, range->start, range->end-1);
+	     node; node = ptr) {
+		/* Guard against node removal. */
+		ptr = __mmu_int_rb_iter_next(node, range->start,
+					     range->end - 1);
+		trace_hfi2_mmu_mem_invalidate(node);
+		/* Remove from rb tree and lru_list. */
+		__mmu_int_rb_remove(node, root);
+		list_del_init(&node->list);
+		kref_put(&node->refcount, release_nolock);
+		handler->external_evictions++;
+	}
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return 0;
+}
+
+/*
+ * Work queue function to remove all nodes that have been queued up to
+ * be removed.  The key feature is that mm->mmap_lock is not being held
+ * and the remove callback can sleep while taking it, if needed.
+ */
+static void handle_remove(struct work_struct *work)
+{
+	struct mmu_rb_handler *handler = container_of(work,
+						struct mmu_rb_handler,
+						del_work);
+	struct list_head del_list;
+	unsigned long flags;
+	struct mmu_rb_node *node;
+
+	/* remove anything that is queued to get removed */
+	spin_lock_irqsave(&handler->lock, flags);
+	list_replace_init(&handler->del_list, &del_list);
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	while (!list_empty(&del_list)) {
+		node = list_first_entry(&del_list, struct mmu_rb_node, list);
+		list_del(&node->list);
+		trace_hfi2_mmu_release_node(node);
+		handler->ops->remove(handler->ops_arg, node);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/pin_system.c b/drivers/infiniband/hw/hfi2/pin_system.c
new file mode 100644
index 000000000000..e08a1be15a4a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pin_system.c
@@ -0,0 +1,550 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2023 - Cornelis Networks, Inc.
+ */
+
+#include <linux/types.h>
+
+#include "hfi2.h"
+#include "common.h"
+#include "device.h"
+#include "pinning.h"
+#include "mmu_rb.h"
+#include "user_sdma.h"
+#include "trace.h"
+
+struct sdma_mmu_node {
+	struct mmu_rb_node rb;
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct page **pages;
+	unsigned int npages;
+};
+
+static bool sdma_rb_filter(struct mmu_rb_node *node, unsigned long addr,
+			   unsigned long len);
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode, void *arg2,
+			 bool *stop);
+static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode);
+
+static const struct mmu_rb_ops sdma_rb_ops = {
+	.filter = sdma_rb_filter,
+	.evict = sdma_rb_evict,
+	.remove = sdma_rb_remove,
+};
+
+static int init_system_pinning(struct hfi2_user_sdma_pkt_q *pq)
+{
+	struct hfi2_devdata *dd = pq->dd;
+	struct mmu_rb_handler **handler = (struct mmu_rb_handler **)
+		&PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+	int ret;
+
+	ret = hfi2_mmu_rb_register(pq, &sdma_rb_ops, dd->hfi2_wq,
+				   handler);
+	if (ret)
+		dd_dev_err(dd,
+			   "[%u:%u] Failed to register system memory DMA support with MMU: %d\n",
+			   pq->ctxt, pq->subctxt, ret);
+	return ret;
+}
+
+static void free_system_pinning(struct hfi2_user_sdma_pkt_q *pq)
+{
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+
+	if (handler)
+		hfi2_mmu_rb_unregister(handler);
+}
+
+static u32 sdma_cache_evict(struct hfi2_user_sdma_pkt_q *pq, u32 npages)
+{
+	struct evict_data evict_data;
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+
+	evict_data.cleared = 0;
+	evict_data.target = npages;
+	hfi2_mmu_rb_evict(handler, &evict_data);
+	return evict_data.cleared;
+}
+
+static void unpin_vector_pages(struct mm_struct *mm, struct page **pages,
+			       unsigned int start, unsigned int npages)
+{
+	hfi2_release_user_pages(mm, pages + start, npages, false);
+	kfree(pages);
+}
+
+static inline struct mm_struct *mm_from_sdma_node(struct sdma_mmu_node *e)
+{
+	return e->rb.handler->mn.mm;
+}
+
+static void free_system_node(struct sdma_mmu_node *e)
+{
+	if (e->npages) {
+		trace_unpin_sdma_mem(mm_from_sdma_node(e), HFI2_MEMINFO_TYPE_SYSTEM, 0,
+				     e, e->rb.addr, e->rb.len,
+				     0, (e->npages * PAGE_SIZE));
+		unpin_vector_pages(mm_from_sdma_node(e), e->pages, 0,
+				   e->npages);
+		atomic_sub(e->npages, &e->pq->n_locked);
+	}
+	kfree(e);
+}
+
+/*
+ * It is not enough for @n to overlap [start,end), it must be the least node
+ * that overlaps [start,end). I.e. if rb_prev(@n) also overlaps [start,end)
+ * then @n is not the least node.
+ */
+static bool covered_by(struct mmu_rb_node *n, unsigned long start,
+		       unsigned long end)
+{
+	if (n->addr < end && start < (n->addr + n->len)) {
+		struct mmu_rb_node *p = NULL;
+
+		if (rb_prev(&n->node))
+			p = container_of(rb_prev(&n->node), struct mmu_rb_node, node);
+		if (!p || (p->addr + p->len) <= start)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * kref from kref_get() in here will be transferred to the struct
+ * user_sdma_txreq to which the retval struct sdma_mmu_node* is being used for.
+ */
+static struct sdma_mmu_node *find_system_node(struct mmu_rb_handler *handler,
+					      unsigned long start,
+					      unsigned long end)
+{
+	struct mmu_rb_node *rb_node;
+	unsigned long flags;
+
+	spin_lock_irqsave(&handler->lock, flags);
+	rb_node = hfi2_mmu_rb_get_first(handler, start, (end - start));
+	if (!rb_node) {
+		handler->misses++;
+		spin_unlock_irqrestore(&handler->lock, flags);
+		return NULL;
+	}
+
+	/* This kref will become the user_sdma_request's kref */
+	kref_get(&rb_node->refcount);
+	handler->hits++;
+	spin_unlock_irqrestore(&handler->lock, flags);
+
+	return container_of(rb_node, struct sdma_mmu_node, rb);
+}
+
+/*
+ * @start on page boundary.
+ */
+static int pin_system_pages(struct user_sdma_request *req, struct sdma_mmu_node *e,
+			    uintptr_t start, int npages)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	int pinned, cleared;
+	struct page **pages;
+
+	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+retry:
+	if (!hfi2_can_pin_pages(pq->dd, current->mm, atomic_read(&pq->n_locked),
+				npages)) {
+		SDMA_DBG(req, "Evicting: nlocked %u npages %u",
+			 atomic_read(&pq->n_locked), npages);
+		cleared = sdma_cache_evict(pq, npages);
+		if (cleared >= npages)
+			goto retry;
+	}
+
+	pinned = hfi2_acquire_user_pages(current->mm, start, npages, 0, pages);
+	trace_pin_sdma_mem(current->mm, HFI2_MEMINFO_TYPE_SYSTEM, start,
+			   npages * PAGE_SIZE, pinned, false, e,
+			   0, max(pinned, 0) * PAGE_SIZE);
+	if (pinned < 0) {
+		kfree(pages);
+		return pinned;
+	}
+	if (pinned != npages) {
+		unpin_vector_pages(current->mm, pages, 0, pinned);
+		return -EFAULT;
+	}
+	e->rb.addr = start;
+	e->rb.len = (npages * PAGE_SIZE);
+	e->pages = pages;
+	e->npages = npages;
+	atomic_add(pinned, &pq->n_locked);
+	return 0;
+}
+
+/*
+ * kref refcount on returned node will be 2 on successful addition: one kref
+ * from kref_init() for mmu_rb_handler and one kref to prevent the returned
+ * node from being released until after the returned node is assigned to an
+ * SDMA descriptor (struct sdma_desc) under add_from_iovec(), even if the
+ * virtual address range for the returned node is invalidated between now and
+ * then.
+ *
+ * @return ERR_PTR() or struct sdma_mmu_node *
+ */
+static struct sdma_mmu_node *
+add_system_pinning(struct user_sdma_request *req, unsigned long start,
+		   unsigned long len)
+
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	struct sdma_mmu_node *e;
+	int ret;
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e)
+		return ERR_PTR(-ENOMEM);
+
+	/* First kref becomes the mmu_rb_handler's kref */
+	kref_init(&e->rb.refcount);
+
+	/* This kref will become the user_sdma_request's kref */
+	kref_get(&e->rb.refcount);
+
+	e->pq = pq;
+	ret = pin_system_pages(req, e, start, PFN_DOWN(len));
+	if (!ret) {
+		ret = hfi2_mmu_rb_insert(PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM), &e->rb);
+		if (ret) {
+			free_system_node(e);
+			return ERR_PTR(ret);
+		}
+		return e;
+	}
+	kfree(e);
+	return ERR_PTR(ret);
+}
+
+/*
+ * @return ERR_PTR() or struct sdma_mmu_node *
+ */
+static struct sdma_mmu_node *
+get_system_cache_entry(struct user_sdma_request *req, size_t req_start,
+		       size_t req_len)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	u64 start = ALIGN_DOWN(req_start, PAGE_SIZE);
+	u64 end = PFN_ALIGN(req_start + req_len);
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+
+	if ((end - start) == 0) {
+		SDMA_DBG(req,
+			 "Request for empty cache entry req_start %lx req_len %lx start %llx end %llx",
+			 req_start, req_len, start, end);
+		return ERR_PTR(-EINVAL);
+	}
+
+	SDMA_DBG(req, "req_start %lx req_len %lu", req_start, req_len);
+
+	while (1) {
+		struct sdma_mmu_node *e =
+			find_system_node(handler, start, end);
+		u64 prepend_len = 0;
+
+		SDMA_DBG(req, "e %p start %llx end %llx", e, start, end);
+		if (!e) {
+			e = add_system_pinning(req, start, end - start);
+			if (IS_ERR(e) && PTR_ERR(e) == -EEXIST) {
+				/*
+				 * Another execution context has inserted a
+				 * conficting entry first.
+				 */
+				continue;
+			}
+			return e;
+		}
+
+		if (e->rb.addr <= start) {
+			/*
+			 * This entry covers at least part of the region. If it doesn't extend
+			 * to the end, then this will be called again for the next segment.
+			 */
+			return e;
+		}
+
+		SDMA_DBG(req, "prepend: e->rb.addr %lx, e->rb.refcount %d",
+			 e->rb.addr, kref_read(&e->rb.refcount));
+		prepend_len = e->rb.addr - start;
+
+		/*
+		 * e will not be returned, instead a new node will be. So
+		 * release the reference.
+		 */
+		kref_put(&e->rb.refcount, hfi2_mmu_rb_release);
+
+		/* Prepend a node to cover the beginning of the allocation */
+		e = add_system_pinning(req, start, prepend_len);
+		if (IS_ERR(e) && PTR_ERR(e) == -EEXIST) {
+			/* Another execution context has inserted a conficting entry first. */
+			continue;
+		}
+		return e;
+	}
+}
+
+static void sdma_mmu_node_put(void *ctx)
+{
+	struct sdma_mmu_node *n = ctx;
+
+	kref_put(&n->rb.refcount, hfi2_mmu_rb_release);
+}
+
+static int add_from_entry(struct user_sdma_request *req,
+			  struct user_sdma_txreq *tx,
+			  struct sdma_mmu_node *e,
+			  size_t start,
+			  size_t from_entry)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	unsigned int page_offset;
+	unsigned int from_page;
+	size_t page_index;
+
+	/*
+	 * Because the cache may be more fragmented than the memory that is being accessed,
+	 * it's not strictly necessary to have a descriptor per cache entry.
+	 */
+	while (from_entry) {
+		int ret;
+
+		page_index = PFN_DOWN(start - e->rb.addr);
+		if (page_index >= e->npages) {
+			SDMA_DBG(req,
+				 "Request for page_index %zu >= e->npages %u",
+				 page_index, e->npages);
+			return -EINVAL;
+		}
+
+		page_offset = start - ALIGN_DOWN(start, PAGE_SIZE);
+		from_page = PAGE_SIZE - page_offset;
+		if (from_page >= from_entry)
+			from_page = from_entry;
+
+		ret = sdma_txadd_page(pq->dd, &tx->txreq,
+				      e->pages[page_index],
+				      page_offset, from_page);
+		if (ret) {
+			/*
+			 * When there's a failure, the entire request is freed by
+			 * user_sdma_send_pkts().
+			 */
+			SDMA_DBG(req,
+				 "sdma_txadd_page failed %d page_index %lu page_offset %u from_page %u",
+				 ret, page_index, page_offset, from_page);
+			return ret;
+		}
+		start += from_page;
+		from_entry -= from_page;
+	}
+	return 0;
+}
+
+/*
+ * On success, prior to returning, adjusts @remaining, @req->iov_idx,
+ * and @req->iov[req->iov_idx].offset to reflect the data that has
+ * been consumed.
+ *
+ * @remaining: as input, maximum amount of data to add from iovecs at
+ *   @iov and after. As output, the amount of data remaining after
+ *   data was added to packet.
+ */
+static int add_to_txreq(struct user_sdma_request *req,
+			struct user_sdma_txreq *tx,
+			struct user_sdma_iovec *iov,
+			u32 *remaining)
+{
+	struct mmu_rb_handler *cache =
+		PINNING_STATE(req->pq, HFI2_MEMINFO_TYPE_SYSTEM);
+	struct user_sdma_pinref *ht =
+		hfi2_user_sdma_mru_ref(tx, HFI2_MEMINFO_TYPE_SYSTEM);
+	struct sdma_mmu_node *e = (ht ? ht->ptr : NULL);
+	u32 rem = *remaining;
+	int ret = 0;
+
+	while (rem && iov->type == HFI2_MEMINFO_TYPE_SYSTEM) {
+		u64 start = (uintptr_t)iov->iov.iov_base + iov->offset;
+		u64 end = (uintptr_t)iov->iov.iov_base + iov->iov.iov_len;
+		u64 from_this;
+
+		/* Keep using e as long as it covers [start,end) */
+		if (!e || !covered_by(&e->rb, start, end)) {
+			if (ht)
+				cache->hint_misses++;
+			e = get_system_cache_entry(req, start, end - start);
+			if (IS_ERR(e))
+				return PTR_ERR(e);
+			/* transfer e's kref to tx */
+			ret = hfi2_user_sdma_add_ref(tx, e, iov->type);
+			if (ret) {
+				sdma_mmu_node_put(e);
+				return ret;
+			}
+		} else if (ht) {
+			hfi2_user_sdma_touch_ref(tx, ht);
+			cache->hint_hits++;
+		}
+		ht = NULL;
+
+		/* Limit by remaining data in e or iovec, then by caller remaining */
+		from_this = min((e->rb.addr + e->rb.len) - start, end - start);
+		from_this = min_t(u64, from_this, rem);
+		ret = add_from_entry(req, tx, e, start, from_this);
+		SDMA_DBG(req, "iov %p iov_range [%llx,%llx) e %p e_range [%lx,%lx) from_this %llu ret %d",
+			 iov, start, end, e, e->rb.addr, e->rb.addr + e->rb.len,
+			 from_this, ret);
+		if (ret) {
+			/* tx destructor will kref_put() e */
+			return ret;
+		}
+
+		rem -= from_this;
+		iov->offset += from_this;
+		if ((u64)iov->offset >= iov->iov.iov_len) {
+			req->iov_idx++;
+			iov++;
+		}
+	}
+	*remaining = rem;
+	return 0;
+}
+
+static void add_system_stats(const struct mmu_rb_node *e, void *arg)
+{
+	struct hfi2_pin_stats *stats = arg;
+
+	stats->cache_entries++;
+	/*
+	 * '- 1' to account for kref held by mmu_rb_handler.
+	 *
+	 * We're assured that mmu_rb_handler has kref for e because:
+	 * - This function is called in a for-each loop over mmu_rb_handler's rb_nodes
+	 * - That loop is called inside of an mmu_rb_handler->lock critical section
+	 * - Once added to an mmu_rb_handler's cache, mmu_rb_nodes can only be
+	 *    destroyed or queued for destruction inside an mmu_rb_handler->lock
+	 *    critical section
+	 *
+	 * So the fact that e was passed in here means it is still in an mmu_rb_handler's cache.
+	 *
+	 * That said, kref_read() here can overcount the number of actual
+	 * sdma_descs holding references to e. That is because user_sdma
+	 * and mmu_rb_handler code take additional krefs to prevent
+	 * mmu_rb_nodes from being destroyed after the user SDMA request is
+	 * submitted and gets as far as pinning pages, even if the userspace
+	 * virtual address range is invalidated in the meantime. I.e. once the
+	 * user SDMA request gets as far as pinning pages, those pages will
+	 * remain resident up until the SDMA engine completes the request.
+	 */
+	stats->total_refcounts += kref_read(&e->refcount) - 1;
+	stats->total_bytes += e->len;
+}
+
+static int get_system_stats(struct hfi2_user_sdma_pkt_q *pq, int index,
+			    struct hfi2_pin_stats *stats)
+{
+	struct mmu_rb_handler *handler =
+		PINNING_STATE(pq, HFI2_MEMINFO_TYPE_SYSTEM);
+	unsigned long next = 0;
+
+	if (index == -1) {
+		stats->index = 1;
+		return 0;
+	}
+
+	if (index != 0)
+		return -EINVAL;
+
+	stats->memtype = HFI2_MEMINFO_TYPE_SYSTEM;
+	stats->id = 0;
+	while (next != ~0UL) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&handler->lock, flags);
+		/* Take stats on 100 nodes at a time.
+		 * This is a balance between time/cost of the operation and
+		 * the latency of other operations waiting for the lock.
+		 */
+		next = hfi2_mmu_rb_for_n(handler, next, 100, add_system_stats,
+					 stats);
+		spin_unlock_irqrestore(&handler->lock, flags);
+		/* This is to allow the lock to be acquired from other places. */
+		ndelay(100);
+	}
+
+	stats->hits = handler->hits;
+	stats->misses = handler->misses;
+	stats->hint_hits = handler->hint_hits;
+	stats->hint_misses = handler->hint_misses;
+	stats->internal_evictions = handler->internal_evictions;
+	stats->external_evictions = handler->external_evictions;
+
+	return 0;
+};
+
+static struct pinning_interface system_pinning_interface = {
+	.init = init_system_pinning,
+	.free = free_system_pinning,
+	.add_to_sdma_packet = add_to_txreq,
+	.put = sdma_mmu_node_put,
+	.get_stats = get_system_stats,
+};
+
+void register_system_pinning_interface(void)
+{
+	register_pinning_interface(HFI2_MEMINFO_TYPE_SYSTEM,
+				   &system_pinning_interface);
+	pr_info("%s System memory DMA support enabled\n", "hfi2");
+}
+
+void deregister_system_pinning_interface(void)
+{
+	deregister_pinning_interface(HFI2_MEMINFO_TYPE_SYSTEM);
+}
+
+static bool sdma_rb_filter(struct mmu_rb_node *e, unsigned long addr,
+			   unsigned long len)
+{
+	return (bool)(e->addr == addr);
+}
+
+/*
+ * Return 1 to remove the node from the rb tree and call the remove op.
+ *
+ * Called with the rb tree lock held.
+ */
+static int sdma_rb_evict(void *arg, struct mmu_rb_node *mnode,
+			 void *evict_arg, bool *stop)
+{
+	struct sdma_mmu_node *e =
+		container_of(mnode, struct sdma_mmu_node, rb);
+	struct evict_data *evict_data = evict_arg;
+
+	/* e will be evicted, add its pages to our count */
+	evict_data->cleared += e->npages;
+
+	/* have enough pages been cleared? */
+	if (evict_data->cleared >= evict_data->target)
+		*stop = true;
+
+	return 1; /* remove this node */
+}
+
+static void sdma_rb_remove(void *arg, struct mmu_rb_node *mnode)
+{
+	struct sdma_mmu_node *e =
+		container_of(mnode, struct sdma_mmu_node, rb);
+
+	free_system_node(e);
+}
diff --git a/drivers/infiniband/hw/hfi2/pinning.c b/drivers/infiniband/hw/hfi2/pinning.c
new file mode 100644
index 000000000000..a968e48d84f4
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pinning.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2022 - Cornelis Networks, Inc.
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+
+#include "pinning.h"
+#include "trace.h"
+
+struct pinning_interface pinning_interfaces[PINNING_MAX_INTERFACES];
+
+void register_pinning_interface(unsigned int type,
+				struct pinning_interface *interface)
+{
+	pinning_interfaces[type] = *interface;
+}
+
+void deregister_pinning_interface(unsigned int type)
+{
+	memset(&pinning_interfaces[type], 0, sizeof(pinning_interfaces[type]));
+}
+
+int init_pinning_interfaces(struct hfi2_user_sdma_pkt_q *pq)
+{
+	int i;
+	int ret;
+
+	for (i = 0; i < PINNING_MAX_INTERFACES; i++) {
+		if (pinning_interfaces[i].init) {
+			ret = pinning_interfaces[i].init(pq);
+			if (ret)
+				goto fail;
+		}
+	}
+
+	return 0;
+
+fail:
+	while (--i >= 0) {
+		if (pinning_interfaces[i].free)
+			pinning_interfaces[i].free(pq);
+	}
+	return ret;
+}
+
+void free_pinning_interfaces(struct hfi2_user_sdma_pkt_q *pq)
+{
+	unsigned int i;
+
+	for (i = 0; i < PINNING_MAX_INTERFACES; i++) {
+		if (trace_pin_stats_enabled() &&
+		    pinning_interfaces[i].get_stats) {
+			struct hfi2_pin_stats s = {0};
+			int ret;
+
+			ret = pinning_interfaces[i].get_stats(pq, 0, &s);
+			if (!WARN_ON_ONCE(ret))
+				trace_pin_stats(pq, &s);
+		}
+
+		if (pinning_interfaces[i].free)
+			pinning_interfaces[i].free(pq);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/pio.c b/drivers/infiniband/hw/hfi2/pio.c
new file mode 100644
index 000000000000..1d6f5d9a3997
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pio.c
@@ -0,0 +1,2277 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015-2018 Intel Corporation.
+ */
+
+#include <linux/delay.h>
+#include "hfi2.h"
+#include "qp.h"
+#include "trace.h"
+
+#define SC(name) SEND_CTXT_##name
+/*
+ * Send Context functions
+ */
+static void sc_wait_for_packet_egress(struct send_context *sc, int pause);
+
+/*
+ * Set the CM reset bit and wait for it to clear.  Use the provided
+ * sendctrl register.  This routine has no locking.
+ */
+void __cm_reset(struct hfi2_pportdata *ppd, u64 sendctrl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int pidx = ppd->hw_pidx;
+
+	write_eport_csr(dd, pidx, dd->params->send_ctrl_reg, sendctrl | SEND_CTRL_CM_RESET_SMASK);
+	while (1) {
+		udelay(1);
+		sendctrl = read_eport_csr(dd, pidx, dd->params->send_ctrl_reg);
+		if ((sendctrl & SEND_CTRL_CM_RESET_SMASK) == 0)
+			break;
+	}
+}
+
+/* global control of PIO send */
+void pio_send_control(struct hfi2_pportdata *ppd, int op)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	u64 reg, mask;
+	unsigned long flags;
+	int write = 1;	/* write sendctrl back */
+	int flush = 0;	/* re-read sendctrl to make sure it is flushed */
+	int i;
+
+	/* only WFR needs to write SendCtrl */
+	if (dd->params->chip_type != CHIP_WFR)
+		return;
+
+	spin_lock_irqsave(&dd->sendctrl_lock, flags);
+
+	reg = read_eport_csr(dd, ppd->hw_pidx, dd->params->send_ctrl_reg);
+	switch (op) {
+	case PSC_GLOBAL_ENABLE:
+		reg |= SEND_CTRL_SEND_ENABLE_SMASK |
+		       dd->params->send_ctrl_flush;
+		fallthrough;
+	case PSC_DATA_VL_ENABLE:
+		mask = 0;
+		for (i = 0; i < ARRAY_SIZE(ppd->vld); i++)
+			if (!ppd->vld[i].mtu)
+				mask |= BIT_ULL(i);
+		/* Disallow sending on VLs not enabled */
+		mask = (mask & SEND_CTRL_UNSUPPORTED_VL_MASK) <<
+			SEND_CTRL_UNSUPPORTED_VL_SHIFT;
+		reg = (reg & ~SEND_CTRL_UNSUPPORTED_VL_SMASK) | mask;
+		break;
+	case PSC_GLOBAL_DISABLE:
+		reg &= ~SEND_CTRL_SEND_ENABLE_SMASK;
+		break;
+	case PSC_GLOBAL_VLARB_ENABLE:
+		reg |= SEND_CTRL_VL_ARBITER_ENABLE_SMASK;
+		break;
+	case PSC_GLOBAL_VLARB_DISABLE:
+		reg &= ~SEND_CTRL_VL_ARBITER_ENABLE_SMASK;
+		break;
+	case PSC_CM_RESET:
+		__cm_reset(ppd, reg);
+		write = 0; /* CSR already written (and flushed) */
+		break;
+	case PSC_DATA_VL_DISABLE:
+		reg |= SEND_CTRL_UNSUPPORTED_VL_SMASK;
+		flush = 1;
+		break;
+	default:
+		dd_dev_err(dd, "%s: invalid control %d\n", __func__, op);
+		break;
+	}
+
+	if (write) {
+		write_eport_csr(dd, ppd->hw_pidx, dd->params->send_ctrl_reg, reg);
+		if (flush) {
+			/* flush write */
+			(void)read_eport_csr(dd, ppd->hw_pidx,
+					     dd->params->send_ctrl_reg);
+		}
+	}
+
+	spin_unlock_irqrestore(&dd->sendctrl_lock, flags);
+}
+
+/* number of send context memory pools */
+#define NUM_SC_POOLS 2
+
+/* Send Context Size (SCS) wildcards */
+#define SCS_POOL_0 -1
+#define SCS_POOL_1 -2
+
+/* Send Context Count (SCC) wildcards */
+#define SCC_PER_VL -1
+#define SCC_PER_CPU  -2
+#define SCC_PER_KRCVQ  -3
+
+/* Send Context Size (SCS) constants */
+#define SCS_ACK_CREDITS  32
+#define SCS_VL15_CREDITS 102	/* 3 pkts of 2048B data + 128B header */
+
+#define PIO_THRESHOLD_CEILING 4096
+
+#define PIO_WAIT_BATCH_SIZE 5
+
+/* default send context sizes */
+static struct sc_config_sizes sc_config_sizes[SC_MAX] = {
+	[SC_KERNEL] = { .size  = SCS_POOL_0,	/* even divide, pool 0 */
+			.count = SCC_PER_VL },	/* one per NUMA */
+	[SC_ACK]    = { .size  = SCS_ACK_CREDITS,
+			.count = SCC_PER_KRCVQ },
+	[SC_USER]   = { .size  = SCS_POOL_0,	/* even divide, pool 0 */
+			.count = SCC_PER_CPU },	/* one per CPU */
+	[SC_VL15]   = { .size  = SCS_VL15_CREDITS,
+			.count = 1 },
+
+};
+
+/* send context memory pool configuration */
+struct mem_pool_config {
+	int centipercent;	/* % of memory, in 100ths of 1% */
+	int absolute_blocks;	/* absolute block count */
+};
+
+/* default memory pool configuration: 100% in pool 0 */
+static struct mem_pool_config sc_mem_pool_config[NUM_SC_POOLS] = {
+	/* centi%, abs blocks */
+	{  10000,     -1 },		/* pool 0 */
+	{      0,     -1 },		/* pool 1 */
+};
+
+/* memory pool information, used when calculating final sizes */
+struct mem_pool_info {
+	int centipercent;	/*
+				 * 100th of 1% of memory to use, -1 if blocks
+				 * already set
+				 */
+	int count;		/* count of contexts in the pool */
+	int blocks;		/* block size of the pool */
+	int size;		/* context size, in blocks */
+};
+
+/*
+ * Convert a pool wildcard to a valid pool index.  The wildcards
+ * start at -1 and increase negatively.  Map them as:
+ *	-1 => 0
+ *	-2 => 1
+ *	etc.
+ *
+ * Return -1 on non-wildcard input, otherwise convert to a pool number.
+ */
+static int wildcard_to_pool(int wc)
+{
+	if (wc >= 0)
+		return -1;	/* non-wildcard */
+	return -wc - 1;
+}
+
+static const char *sc_type_names[SC_MAX] = {
+	"kernel",
+	"vl15",
+	"ack",
+	"user",
+};
+
+static const char *sc_type_name(int index)
+{
+	if (index < 0 || index >= SC_MAX)
+		return "unknown";
+	return sc_type_names[index];
+}
+
+/*
+ * Read the send context memory pool configuration and send context
+ * size configuration.  Replace any wildcards and come up with final
+ * counts and sizes for the send context types.
+ */
+int init_sc_pools_and_sizes(struct hfi2_devdata *dd)
+{
+	struct mem_pool_info mem_pool_info[NUM_SC_POOLS] = { { 0 } };
+	/* do not use first N blocks */
+	int total_blocks = (chip_pio_mem_size(dd) / PIO_BLOCK_SIZE) -
+				dd->first_pio_block;
+	u32 usable_sc = chip_send_contexts(dd) - dd->first_send_context;
+	int total_contexts = 0;
+	int fixed_blocks;
+	int pool_blocks;
+	int used_blocks;
+	int cp_total;		/* centipercent total */
+	int ab_total;		/* absolute block total */
+	int extra;
+	int pidx;
+	int i;
+
+	/*
+	 * When SDMA is enabled, kernel context pio packet size is capped by
+	 * "piothreshold". Reduce pio buffer allocation for kernel context by
+	 * setting it to a fixed size. The allocation allows 3-deep buffering
+	 * of the largest pio packets plus up to 128 bytes header, sufficient
+	 * to maintain verbs performance.
+	 *
+	 * When SDMA is disabled, keep the default pooling allocation.
+	 */
+	if (HFI2_CAP_IS_KSET(SDMA)) {
+		u16 max_pkt_size = (piothreshold < PIO_THRESHOLD_CEILING) ?
+					 piothreshold : PIO_THRESHOLD_CEILING;
+		sc_config_sizes[SC_KERNEL].size =
+			3 * (max_pkt_size + 128) / PIO_BLOCK_SIZE;
+	}
+
+	/*
+	 * Step 0:
+	 *	- copy the centipercents/absolute sizes from the pool config
+	 *	- sanity check these values
+	 *	- add up centipercents, then later check for full value
+	 *	- add up absolute blocks, then later check for over-commit
+	 */
+	cp_total = 0;
+	ab_total = 0;
+	for (i = 0; i < NUM_SC_POOLS; i++) {
+		int cp = sc_mem_pool_config[i].centipercent;
+		int ab = sc_mem_pool_config[i].absolute_blocks;
+
+		/*
+		 * A negative value is "unused" or "invalid".  Both *can*
+		 * be valid, but centipercent wins, so check that first
+		 */
+		if (cp >= 0) {			/* centipercent valid */
+			cp_total += cp;
+		} else if (ab >= 0) {		/* absolute blocks valid */
+			ab_total += ab;
+		} else {			/* neither valid */
+			dd_dev_err(
+				dd,
+				"Send context memory pool %d: both the block count and centipercent are invalid\n",
+				i);
+			return -EINVAL;
+		}
+
+		mem_pool_info[i].centipercent = cp;
+		mem_pool_info[i].blocks = ab;
+	}
+
+	/* do not use both % and absolute blocks for different pools */
+	if (cp_total != 0 && ab_total != 0) {
+		dd_dev_err(
+			dd,
+			"All send context memory pools must be described as either centipercent or blocks, no mixing between pools\n");
+		return -EINVAL;
+	}
+
+	/* if any percentages are present, they must add up to 100% x 100 */
+	if (cp_total != 0 && cp_total != 10000) {
+		dd_dev_err(
+			dd,
+			"Send context memory pool centipercent is %d, expecting 10000\n",
+			cp_total);
+		return -EINVAL;
+	}
+
+	/* the absolute pool total cannot be more than the mem total */
+	if (ab_total > total_blocks) {
+		dd_dev_err(
+			dd,
+			"Send context memory pool absolute block count %d is larger than the memory size %d\n",
+			ab_total, total_blocks);
+		return -EINVAL;
+	}
+
+	/*
+	 * Step 2:
+	 *	- copy from the context size config
+	 *	- replace context type wildcard counts with real values
+	 *	- add up non-memory pool block sizes
+	 *	- add up memory pool user counts
+	 */
+	fixed_blocks = 0;
+	for (i = 0; i < SC_MAX; i++) {
+		int count = sc_config_sizes[i].count;
+		int size = sc_config_sizes[i].size;
+		int pool;
+
+		/*
+		 * Sanity check count: Either a positive value or
+		 * one of the expected wildcards is valid.  The positive
+		 * value is checked later when we compare against total
+		 * memory available.
+		 */
+		if (count == SCC_PER_KRCVQ) {
+			count = 0;
+			for (pidx = 0; pidx < dd->num_pports; pidx++)
+				count += dd->pport[pidx].n_krcv_queues;
+		} else if (count == SCC_PER_VL) {
+			count = 0;
+			for (pidx = 0; pidx < dd->num_pports; pidx++) {
+				count += port_available_pidx(dd, pidx) ?
+						INIT_SC_PER_VL * num_vls : 0;
+			}
+		} else if (count == SCC_PER_CPU) {
+			/* "user" is the user + netdev contexts */
+			count = 0;
+			for (pidx = 0; pidx < dd->num_pports; pidx++)
+				count += dd->pport[pidx].num_rcv_contexts - dd->pport[pidx].n_krcv_queues;
+		} else if (count < 0) {
+			dd_dev_err(dd,
+				   "%s send context invalid count wildcard %d\n",
+				   sc_type_name(i), count);
+			return -EINVAL;
+		} else {
+			/* config table is per-port - add active ports */
+			int port_count = count;
+
+			count = 0;
+			for (pidx = 0; pidx < dd->num_pports; pidx++)
+				count += port_available_pidx(dd, pidx) ?
+						port_count : 0;
+		}
+
+		/* only expect SC_USER to possibly overflow */
+		if (total_contexts + count > usable_sc) {
+			if (i != SC_USER) {
+				dd_dev_err(dd,
+					   "%s send context overflow\n",
+					   sc_type_name(i));
+				return -EINVAL;
+			}
+			dd_dev_warn(dd,
+				   "%s send context count reduced by %d, %d -> %d\n",
+				    sc_type_name(i),
+				    count - (usable_sc - total_contexts),
+				    count,
+				    usable_sc - total_contexts);
+			count = usable_sc - total_contexts;
+		}
+
+		total_contexts += count;
+
+		/*
+		 * Sanity check pool: The conversion will return a pool
+		 * number or -1 if a fixed (non-negative) value.  The fixed
+		 * value is checked later when we compare against
+		 * total memory available.
+		 */
+		pool = wildcard_to_pool(size);
+		if (pool == -1) {			/* non-wildcard */
+			fixed_blocks += size * count;
+		} else if (pool < NUM_SC_POOLS) {	/* valid wildcard */
+			mem_pool_info[pool].count += count;
+		} else {				/* invalid wildcard */
+			dd_dev_err(
+				dd,
+				"%s send context invalid pool wildcard %d\n",
+				sc_type_name(i), size);
+			return -EINVAL;
+		}
+
+		dd->sc_sizes[i].count = count;
+		dd->sc_sizes[i].size = size;
+	}
+	if (fixed_blocks > total_blocks) {
+		dd_dev_err(
+			dd,
+			"Send context fixed block count, %u, larger than total block count %u\n",
+			fixed_blocks, total_blocks);
+		return -EINVAL;
+	}
+
+	/* step 3: calculate the blocks in the pools, and pool context sizes */
+	pool_blocks = total_blocks - fixed_blocks;
+	if (ab_total > pool_blocks) {
+		dd_dev_err(
+			dd,
+			"Send context fixed pool sizes, %u, larger than pool block count %u\n",
+			ab_total, pool_blocks);
+		return -EINVAL;
+	}
+	/* subtract off the fixed pool blocks */
+	pool_blocks -= ab_total;
+
+	for (i = 0; i < NUM_SC_POOLS; i++) {
+		struct mem_pool_info *pi = &mem_pool_info[i];
+
+		/* % beats absolute blocks */
+		if (pi->centipercent >= 0)
+			pi->blocks = (pool_blocks * pi->centipercent) / 10000;
+
+		if (pi->blocks == 0 && pi->count != 0) {
+			dd_dev_err(
+				dd,
+				"Send context memory pool %d has %u contexts, but no blocks\n",
+				i, pi->count);
+			return -EINVAL;
+		}
+		if (pi->count == 0) {
+			/* warn about wasted blocks */
+			if (pi->blocks != 0)
+				dd_dev_err(
+					dd,
+					"Send context memory pool %d has %u blocks, but zero contexts\n",
+					i, pi->blocks);
+			pi->size = 0;
+		} else {
+			pi->size = pi->blocks / pi->count;
+		}
+	}
+
+	/* step 4: fill in the context type sizes from the pool sizes */
+	used_blocks = 0;
+	for (i = 0; i < SC_MAX; i++) {
+		if (dd->sc_sizes[i].size < 0) {
+			unsigned pool = wildcard_to_pool(dd->sc_sizes[i].size);
+
+			WARN_ON_ONCE(pool >= NUM_SC_POOLS);
+			dd->sc_sizes[i].size = mem_pool_info[pool].size;
+		}
+		/* make sure we are not larger than what is allowed by the HW */
+#define PIO_MAX_BLOCKS 1024
+		if (dd->sc_sizes[i].size > PIO_MAX_BLOCKS)
+			dd->sc_sizes[i].size = PIO_MAX_BLOCKS;
+
+		/* calculate our total usage */
+		used_blocks += dd->sc_sizes[i].size * dd->sc_sizes[i].count;
+	}
+	extra = total_blocks - used_blocks;
+	if (extra != 0)
+		dd_dev_info(dd, "unused send context blocks: %d\n", extra);
+
+	return total_contexts;
+}
+
+int init_send_contexts(struct hfi2_devdata *dd)
+{
+	u32 num_sc = chip_send_contexts(dd);
+	u16 base;
+	int ret, i, j, context;
+
+	ret = init_credit_return(dd);
+	if (ret)
+		return ret;
+
+	dd->hw_to_sw = kmalloc_array(num_sc, sizeof(u16), GFP_KERNEL);
+	dd->send_contexts = kcalloc(dd->num_send_contexts,
+				    sizeof(struct send_context_info),
+				    GFP_KERNEL);
+	if (!dd->send_contexts || !dd->hw_to_sw) {
+		kfree(dd->hw_to_sw);
+		kfree(dd->send_contexts);
+		free_credit_return(dd);
+		return -ENOMEM;
+	}
+
+	/* hardware context map starts with invalid send context indices */
+	for (i = 0; i < num_sc; i++)
+		dd->hw_to_sw[i] = INVALID_SCI;
+
+	/*
+	 * All send contexts have their credit sizes.  Allocate credits
+	 * for each context one after another from the global space.
+	 */
+	context = 0;
+	base = dd->first_pio_block; /* do not use first N blocks */
+	for (i = 0; i < SC_MAX; i++) {
+		struct sc_config_sizes *scs = &dd->sc_sizes[i];
+
+		for (j = 0; j < scs->count; j++) {
+			struct send_context_info *sci =
+						&dd->send_contexts[context];
+			sci->type = i;
+			sci->base = base;
+			sci->credits = scs->size;
+
+			context++;
+			base += scs->size;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Allocate a software index and hardware context of the given type.
+ *
+ * Must be called with dd->sc_lock held.
+ */
+static int sc_hw_alloc(struct hfi2_devdata *dd, int type, u32 *sw_index,
+		       u32 *hw_context)
+{
+	struct send_context_info *sci;
+	int num_send = chip_send_contexts(dd);
+	u32 index;
+	u32 context;
+
+	for (index = 0, sci = &dd->send_contexts[0];
+			index < dd->num_send_contexts; index++, sci++) {
+		if (sci->type == type && sci->allocated == 0) {
+			sci->allocated = 1;
+			/*
+			 * Use a 1:1 mapping, but use back-to-front.  This
+			 * avoids the reserved range 0..dd->first_send_context.
+			 */
+			context = num_send - index - 1;
+			dd->hw_to_sw[context] = index;
+			*sw_index = index;
+			*hw_context = context;
+			return 0; /* success */
+		}
+	}
+	dd_dev_err(dd, "Unable to locate a free type %d send context\n", type);
+	return -ENOSPC;
+}
+
+/*
+ * Free the send context given by its software index.
+ *
+ * Must be called with dd->sc_lock held.
+ */
+static void sc_hw_free(struct hfi2_devdata *dd, u32 sw_index, u32 hw_context)
+{
+	struct send_context_info *sci;
+
+	sci = &dd->send_contexts[sw_index];
+	if (!sci->allocated) {
+		dd_dev_err(dd, "%s: sw_index %u not allocated? hw_context %u\n",
+			   __func__, sw_index, hw_context);
+	}
+	sci->allocated = 0;
+	dd->hw_to_sw[hw_context] = INVALID_SCI;
+}
+
+/* return the base context of a context in a group */
+static inline u32 group_context(u32 context, u32 group)
+{
+	return (context >> group) << group;
+}
+
+/* return the size of a group */
+static inline u32 group_size(u32 group)
+{
+	return 1 << group;
+}
+
+/*
+ * Obtain the credit return addresses, kernel virtual and bus, for the
+ * given sc.
+ *
+ * To understand this routine:
+ * o va and dma are arrays of struct credit_return.  One for each physical
+ *   send context, per NUMA.
+ * o Each send context always looks in its relative location in a struct
+ *   credit_return for its credit return.
+ * o Each send context in a group must have its return address CSR programmed
+ *   with the same value.  Use the address of the first send context in the
+ *   group.
+ */
+static void cr_group_addresses(struct send_context *sc, dma_addr_t *dma)
+{
+	u32 gc = group_context(sc->hw_context, sc->group);
+	u32 index = sc->hw_context & 0x7;
+
+	sc->hw_free = &sc->dd->cr_base[sc->node].va[gc].cr[index];
+	*dma = (unsigned long)
+	       &((struct credit_return *)sc->dd->cr_base[sc->node].dma)[gc];
+}
+
+/*
+ * Work queue function triggered in error interrupt routine for
+ * kernel contexts.
+ */
+static void sc_halted(struct work_struct *work)
+{
+	struct send_context *sc;
+
+	sc = container_of(work, struct send_context, halt_work);
+	sc_restart(sc);
+}
+
+/*
+ * Calculate PIO block threshold for this send context using the given MTU.
+ * Trigger a return when one MTU plus optional header of credits remain.
+ *
+ * Parameter mtu is in bytes.
+ * Parameter hdrqentsize is in DWORDs.
+ *
+ * Return value is what to write into the CSR: trigger return when
+ * unreturned credits pass this count.
+ */
+u32 sc_mtu_to_threshold(struct send_context *sc, u32 mtu, u32 hdrqentsize)
+{
+	u32 release_credits;
+	u32 threshold;
+
+	/* add in the header size, then divide by the PIO block size */
+	mtu += hdrqentsize << 2;
+	release_credits = DIV_ROUND_UP(mtu, PIO_BLOCK_SIZE);
+
+	/* check against this context's credits */
+	if (sc->credits <= release_credits)
+		threshold = 1;
+	else
+		threshold = sc->credits - release_credits;
+
+	return threshold;
+}
+
+/*
+ * Calculate credit threshold in terms of percent of the allocated credits.
+ * Trigger when unreturned credits equal or exceed the percentage of the whole.
+ *
+ * Return value is what to write into the CSR: trigger return when
+ * unreturned credits pass this count.
+ */
+u32 sc_percent_to_threshold(struct send_context *sc, u32 percent)
+{
+	return (sc->credits * percent) / 100;
+}
+
+/*
+ * Set the credit return threshold.
+ */
+void sc_set_cr_threshold(struct send_context *sc, u32 new_threshold)
+{
+	unsigned long flags;
+	u32 old_threshold;
+	int force_return = 0;
+
+	spin_lock_irqsave(&sc->credit_ctrl_lock, flags);
+
+	old_threshold = (sc->credit_ctrl >>
+				SC(CREDIT_CTRL_THRESHOLD_SHIFT))
+			 & SC(CREDIT_CTRL_THRESHOLD_MASK);
+
+	if (new_threshold != old_threshold) {
+		sc->credit_ctrl =
+			(sc->credit_ctrl
+				& ~SC(CREDIT_CTRL_THRESHOLD_SMASK))
+			| ((new_threshold
+				& SC(CREDIT_CTRL_THRESHOLD_MASK))
+			   << SC(CREDIT_CTRL_THRESHOLD_SHIFT));
+		write_sctxt_csr(sc->dd, sc->hw_context,
+				sc->dd->params->send_ctxt_credit_ctrl_reg,
+				sc->credit_ctrl);
+
+		/* force a credit return on change to avoid a possible stall */
+		force_return = 1;
+	}
+
+	spin_unlock_irqrestore(&sc->credit_ctrl_lock, flags);
+
+	if (force_return)
+		sc_return_credits(sc);
+}
+
+#define CLEAR_STATIC_RATE_CONTROL_SMASK(r) \
+((r) &= ~SEND_CTXT_CHECK_ENABLE_DISALLOW_PBC_STATIC_RATE_CONTROL_SMASK)
+
+#define SET_STATIC_RATE_CONTROL_SMASK(r) \
+((r) |= SEND_CTXT_CHECK_ENABLE_DISALLOW_PBC_STATIC_RATE_CONTROL_SMASK)
+
+/*
+ * set_pio_integrity
+ *
+ * Set the CHECK_ENABLE register for the send context 'sc'.
+ */
+void wfr_set_pio_integrity(struct send_context *sc, enum spi_cmds cmd)
+{
+	struct hfi2_devdata *dd = sc->dd;
+	u32 hw_context = sc->hw_context;
+	u32 pidx = sc->ppd->hw_pidx;
+	int type = sc->type;
+	u64 val;
+	int set;
+
+	/* DEFAULT does not do a read-modify-write */
+	if (cmd == SPI_DEFAULT) {
+		val = 0;
+	} else {
+		val = read_epsc_csr(dd, pidx, hw_context,
+				    dd->params->send_ctxt_check_enable_reg);
+	}
+
+	switch (cmd) {
+	case SPI_DEFAULT:
+		val = hfi2_pkt_default_send_ctxt_mask(dd, type);
+		break;
+	case SPI_INIT:
+		set = type == SC_USER ?
+			HFI2_CAP_IS_USET(STATIC_RATE_CTRL) :
+			HFI2_CAP_IS_KSET(STATIC_RATE_CTRL);
+		if (set)
+			CLEAR_STATIC_RATE_CONTROL_SMASK(val);
+		else
+			SET_STATIC_RATE_CONTROL_SMASK(val);
+		break;
+	case SPI_SET_JKEY:
+		val |= SEND_CTXT_CHECK_ENABLE_CHECK_JOB_KEY_SMASK;
+		break;
+	case SPI_CLEAR_JKEY:
+		val &= ~SEND_CTXT_CHECK_ENABLE_CHECK_JOB_KEY_SMASK;
+		break;
+	case SPI_SET_PKEY:
+		val |= SEND_CTXT_CHECK_ENABLE_CHECK_PARTITION_KEY_SMASK;
+		val &= ~SEND_CTXT_CHECK_ENABLE_DISALLOW_KDETH_PACKETS_SMASK;
+		break;
+	case SPI_CLEAR_PKEY:
+		val &= ~SEND_CTXT_CHECK_ENABLE_CHECK_PARTITION_KEY_SMASK;
+		break;
+	}
+	write_epsc_csr(dd, pidx, hw_context,
+		       dd->params->send_ctxt_check_enable_reg, val);
+
+}
+
+static u32 get_buffers_allocated(struct send_context *sc)
+{
+	int cpu;
+	u32 ret = 0;
+
+	for_each_possible_cpu(cpu)
+		ret += *per_cpu_ptr(sc->buffers_allocated, cpu);
+	return ret;
+}
+
+static void reset_buffers_allocated(struct send_context *sc)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		(*per_cpu_ptr(sc->buffers_allocated, cpu)) = 0;
+}
+
+/*
+ * Allocate a NUMA relative send context structure of the given type along
+ * with a HW context.
+ */
+struct send_context *sc_alloc(struct hfi2_pportdata *ppd, int type,
+			      uint hdrqentsize, int numa)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct send_context_info *sci;
+	struct send_context *sc = NULL;
+	dma_addr_t dma;
+	unsigned long flags;
+	u64 reg;
+	u32 thresh;
+	u32 sw_index;
+	u32 hw_context;
+	int ret;
+	u8 opval, opmask;
+
+	/* do not allocate while frozen */
+	if (dd->flags & HFI2_FROZEN)
+		return NULL;
+
+	sc = kzalloc_node(sizeof(*sc), GFP_KERNEL, numa);
+	if (!sc)
+		return NULL;
+
+	sc->buffers_allocated = alloc_percpu(u32);
+	if (!sc->buffers_allocated) {
+		kfree(sc);
+		dd_dev_err(dd,
+			   "Cannot allocate buffers_allocated per cpu counters\n"
+			  );
+		return NULL;
+	}
+
+	spin_lock_irqsave(&dd->sc_lock, flags);
+	ret = sc_hw_alloc(dd, type, &sw_index, &hw_context);
+	if (ret) {
+		spin_unlock_irqrestore(&dd->sc_lock, flags);
+		free_percpu(sc->buffers_allocated);
+		kfree(sc);
+		return NULL;
+	}
+
+	sci = &dd->send_contexts[sw_index];
+	sci->sc = sc;
+
+	sc->dd = dd;
+	sc->ppd = ppd;
+	sc->node = numa;
+	sc->type = type;
+	spin_lock_init(&sc->alloc_lock);
+	spin_lock_init(&sc->release_lock);
+	spin_lock_init(&sc->credit_ctrl_lock);
+	seqlock_init(&sc->waitlock);
+	INIT_LIST_HEAD(&sc->piowait);
+	INIT_WORK(&sc->halt_work, sc_halted);
+	init_waitqueue_head(&sc->halt_wait);
+
+	/* grouping is always single context for now */
+	sc->group = 0;
+
+	sc->sw_index = sw_index;
+	sc->hw_context = hw_context;
+	cr_group_addresses(sc, &dma);
+	sc->credits = sci->credits;
+	sc->size = sc->credits * PIO_BLOCK_SIZE;
+
+/* PIO Send Memory Address details */
+#define PIO_ADDR_CONTEXT_MASK 0xfful
+#define PIO_ADDR_CONTEXT_SHIFT 16
+	sc->base_addr = dd->piobase + ((hw_context & PIO_ADDR_CONTEXT_MASK)
+					<< PIO_ADDR_CONTEXT_SHIFT);
+
+	/* set base and credits */
+	reg = ((sci->credits & SC(CTRL_CTXT_DEPTH_MASK))
+					<< SC(CTRL_CTXT_DEPTH_SHIFT))
+		| ((sci->base & MASK_ULL(dd->params->pio_base_bits))
+					<< SC(CTRL_CTXT_BASE_SHIFT));
+	write_tctxt_csr(dd, hw_context, dd->params->send_ctxt_ctrl_reg, reg);
+
+	dd->params->set_pio_integrity(sc, SPI_DEFAULT);
+
+	/* unmask all errors */
+	write_sctxt_csr(dd, hw_context, dd->params->send_ctxt_err_mask_reg, (u64)-1);
+
+	/* set the default partition key */
+	write_epsc_csr(dd, ppd->hw_pidx, hw_context, dd->params->send_ctxt_check_partition_key_reg,
+		       (SC(CHECK_PARTITION_KEY_VALUE_MASK) &
+		       DEFAULT_PKEY) <<
+		       SC(CHECK_PARTITION_KEY_VALUE_SHIFT));
+
+	/* per context type checks */
+	if (type == SC_USER) {
+		opval = USER_OPCODE_CHECK_VAL;
+		opmask = USER_OPCODE_CHECK_MASK;
+	} else {
+		opval = OPCODE_CHECK_VAL_DISABLED;
+		opmask = OPCODE_CHECK_MASK_DISABLED;
+	}
+
+	/* set the send context check opcode mask and value */
+	write_epsc_csr(dd, ppd->hw_pidx, hw_context, dd->params->send_ctxt_check_opcode_reg,
+		       ((u64)opmask << SC(CHECK_OPCODE_MASK_SHIFT)) |
+		       ((u64)opval << SC(CHECK_OPCODE_VALUE_SHIFT)));
+
+	/* set up credit return */
+	reg = dma & SC(CREDIT_RETURN_ADDR_ADDRESS_SMASK);
+	write_sctxt_csr(dd, hw_context, dd->params->send_ctxt_credit_return_addr_reg, reg);
+
+	/*
+	 * Calculate the initial credit return threshold.
+	 *
+	 * For Ack contexts, set a threshold for half the credits.
+	 * For User contexts use the given percentage.  This has been
+	 * sanitized on driver start-up.
+	 * For Kernel contexts, use the default MTU plus a header
+	 * or half the credits, whichever is smaller. This should
+	 * work for both the 3-deep buffering allocation and the
+	 * pooling allocation.
+	 */
+	if (type == SC_ACK) {
+		thresh = sc_percent_to_threshold(sc, 50);
+	} else if (type == SC_USER) {
+		thresh = sc_percent_to_threshold(sc,
+						 user_credit_return_threshold);
+	} else { /* kernel */
+		thresh = min(sc_percent_to_threshold(sc, 50),
+			     sc_mtu_to_threshold(sc, hfi2_max_mtu,
+						 hdrqentsize));
+	}
+	reg = thresh << SC(CREDIT_CTRL_THRESHOLD_SHIFT);
+
+	/*
+	 * JKR does not support early credit return logic, so early credit return
+	 * capability will not be enabled.
+	 */
+	if (dd->params->chip_type != CHIP_JKR) {
+		/* add in early return */
+		if (type == SC_USER && HFI2_CAP_IS_USET(EARLY_CREDIT_RETURN))
+			reg |= SC(CREDIT_CTRL_EARLY_RETURN_SMASK);
+		else if (HFI2_CAP_IS_KSET(EARLY_CREDIT_RETURN)) /* kernel, ack */
+			reg |= SC(CREDIT_CTRL_EARLY_RETURN_SMASK);
+	}
+
+	/* set up write-through credit_ctrl */
+	sc->credit_ctrl = reg;
+	write_sctxt_csr(dd, hw_context, dd->params->send_ctxt_credit_ctrl_reg,
+			reg);
+
+	/* User send contexts should not allow sending on VL15 */
+	if (type == SC_USER) {
+		reg = 1ULL << 15;
+		write_epsc_csr(dd, ppd->hw_pidx, hw_context,
+			       dd->params->send_ctxt_check_vl_reg, reg);
+	}
+
+	spin_unlock_irqrestore(&dd->sc_lock, flags);
+
+	/*
+	 * Allocate shadow ring to track outstanding PIO buffers _after_
+	 * unlocking.  We don't know the size until the lock is held and
+	 * we can't allocate while the lock is held.  No one is using
+	 * the context yet, so allocate it now.
+	 *
+	 * User contexts do not get a shadow ring.
+	 */
+	if (type != SC_USER) {
+		/*
+		 * Size the shadow ring 1 larger than the number of credits
+		 * so head == tail can mean empty.
+		 */
+		sc->sr_size = sci->credits + 1;
+		sc->sr = kcalloc_node(sc->sr_size,
+				      sizeof(union pio_shadow_ring),
+				      GFP_KERNEL, numa);
+		if (!sc->sr) {
+			sc_free(sc);
+			return NULL;
+		}
+	}
+
+	hfi2_cdbg(PIO,
+		  "Send context %u(%u) %s group %u credits %u credit_ctrl 0x%llx threshold %u",
+		  sw_index,
+		  hw_context,
+		  sc_type_name(type),
+		  sc->group,
+		  sc->credits,
+		  sc->credit_ctrl,
+		  thresh);
+
+	return sc;
+}
+
+/* free a per-NUMA send context structure */
+void sc_free(struct send_context *sc)
+{
+	struct hfi2_devdata *dd;
+	unsigned long flags;
+	u32 sw_index;
+	u32 hw_context;
+	int pidx;
+
+	if (!sc)
+		return;
+
+	sc->flags |= SCF_IN_FREE;	/* ensure no restarts */
+	dd = sc->dd;
+	if (!list_empty(&sc->piowait))
+		dd_dev_err(dd, "piowait list not empty!\n");
+	pidx = sc->ppd->hw_pidx;
+	sw_index = sc->sw_index;
+	hw_context = sc->hw_context;
+	sc_disable(sc);	/* make sure the HW is disabled */
+	flush_work(&sc->halt_work);
+
+	spin_lock_irqsave(&dd->sc_lock, flags);
+	dd->send_contexts[sw_index].sc = NULL;
+
+	/* clear/disable all registers set in sc_alloc */
+	write_tctxt_csr(dd, hw_context, dd->params->send_ctxt_ctrl_reg, 0);
+	write_epsc_csr(dd, pidx, hw_context, dd->params->send_ctxt_check_enable_reg, 0);
+	write_sctxt_csr(dd, hw_context, dd->params->send_ctxt_err_mask_reg, 0);
+	write_epsc_csr(dd, pidx, hw_context, dd->params->send_ctxt_check_partition_key_reg, 0);
+	write_epsc_csr(dd, pidx, hw_context, dd->params->send_ctxt_check_opcode_reg, 0);
+	write_sctxt_csr(dd, hw_context,
+			dd->params->send_ctxt_credit_return_addr_reg, 0);
+	write_sctxt_csr(dd, hw_context, dd->params->send_ctxt_credit_ctrl_reg,
+			0);
+
+	/* release the index and context for re-use */
+	sc_hw_free(dd, sw_index, hw_context);
+	spin_unlock_irqrestore(&dd->sc_lock, flags);
+
+	kfree(sc->sr);
+	free_percpu(sc->buffers_allocated);
+	kfree(sc);
+}
+
+/* disable the context */
+void sc_disable(struct send_context *sc)
+{
+	u64 reg;
+	struct pio_buf *pbuf;
+	LIST_HEAD(wake_list);
+
+	if (!sc)
+		return;
+
+	/* do all steps, even if already disabled */
+	spin_lock_irq(&sc->alloc_lock);
+	reg = read_tctxt_csr(sc->dd, sc->hw_context,
+			     sc->dd->params->send_ctxt_ctrl_reg);
+	reg &= ~SC(CTRL_CTXT_ENABLE_SMASK);
+	sc->flags &= ~SCF_ENABLED;
+	sc_wait_for_packet_egress(sc, 1);
+	write_tctxt_csr(sc->dd, sc->hw_context,
+			sc->dd->params->send_ctxt_ctrl_reg, reg);
+
+	/*
+	 * Flush any waiters.  Once the context is disabled,
+	 * credit return interrupts are stopped (although there
+	 * could be one in-process when the context is disabled).
+	 * Wait one microsecond for any lingering interrupts, then
+	 * proceed with the flush.
+	 */
+	udelay(1);
+	spin_lock(&sc->release_lock);
+	if (sc->sr) {	/* this context has a shadow ring */
+		while (sc->sr_tail != sc->sr_head) {
+			pbuf = &sc->sr[sc->sr_tail].pbuf;
+			if (pbuf->cb)
+				(*pbuf->cb)(pbuf->arg, PRC_SC_DISABLE);
+			sc->sr_tail++;
+			if (sc->sr_tail >= sc->sr_size)
+				sc->sr_tail = 0;
+		}
+	}
+	spin_unlock(&sc->release_lock);
+
+	write_seqlock(&sc->waitlock);
+	list_splice_init(&sc->piowait, &wake_list);
+	write_sequnlock(&sc->waitlock);
+	while (!list_empty(&wake_list)) {
+		struct iowait *wait;
+		struct rvt_qp *qp;
+		struct hfi2_qp_priv *priv;
+
+		wait = list_first_entry(&wake_list, struct iowait, list);
+		qp = iowait_to_qp(wait);
+		priv = qp->priv;
+		list_del_init(&priv->s_iowait.list);
+		priv->s_iowait.lock = NULL;
+		hfi2_qp_wakeup(qp, RVT_S_WAIT_PIO | HFI2_S_WAIT_PIO_DRAIN);
+	}
+
+	spin_unlock_irq(&sc->alloc_lock);
+}
+
+/* return SendEgressCtxtStatus.PacketOccupancy */
+static u64 packet_occupancy(u64 reg)
+{
+	return (reg &
+		SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SMASK)
+		>> SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_PACKET_OCCUPANCY_SHIFT;
+}
+
+/* is egress halted on the context? */
+static bool egress_halted(u64 reg)
+{
+	return !!(reg & SEND_EGRESS_CTXT_STATUS_CTXT_EGRESS_HALT_STATUS_SMASK);
+}
+
+/* is the send context halted? */
+static bool is_sc_halted(struct hfi2_devdata *dd, u32 hw_context)
+{
+	return !!(read_sctxt_csr(dd, hw_context, dd->params->send_ctxt_status_reg) &
+		  SC(STATUS_CTXT_HALTED_SMASK));
+}
+
+/**
+ * sc_wait_for_packet_egress - wait for packet
+ * @sc: valid send context
+ * @pause: wait for credit return
+ *
+ * Wait for packet egress, optionally pause for credit return
+ *
+ * Egress halt and Context halt are not necessarily the same thing, so
+ * check for both.
+ *
+ * NOTE: The context halt bit may not be set immediately.  Because of this,
+ * it is necessary to check the SW SFC_HALTED bit (set in the IRQ) and the HW
+ * context bit to determine if the context is halted.
+ */
+static void sc_wait_for_packet_egress(struct send_context *sc, int pause)
+{
+	struct hfi2_devdata *dd = sc->dd;
+	struct hfi2_pportdata *ppd = sc->ppd;
+	u64 reg = 0;
+	u64 reg_prev;
+	u32 loop = 0;
+
+	while (1) {
+		reg_prev = reg;
+		reg = read_eport_csr(dd, ppd->hw_pidx, sc->hw_context * 8 +
+				     dd->params->send_egress_ctxt_status_reg);
+		/* done if any halt bits, SW or HW are set */
+		if (sc->flags & SCF_HALTED ||
+		    is_sc_halted(dd, sc->hw_context) || egress_halted(reg))
+			break;
+		reg = packet_occupancy(reg);
+		if (reg == 0)
+			break;
+		/* counter is reset if occupancy count changes */
+		if (reg != reg_prev)
+			loop = 0;
+		if (loop > 50) {
+			/* timed out - bounce the link */
+			dd_dev_err(dd,
+				   "%s: context %u(%u) timeout waiting for packets to egress, remaining count %u, bouncing link\n",
+				   __func__, sc->sw_index,
+				   sc->hw_context, (u32)reg);
+			queue_work(ppd->link_wq, &ppd->link_bounce_work);
+			break;
+		}
+		loop++;
+		mdelay(1);
+	}
+
+	if (pause)
+		/* Add additional delay to ensure chip returns all credits */
+		pause_for_credit_return(dd);
+}
+
+void sc_wait(struct hfi2_devdata *dd)
+{
+	int i;
+
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		struct send_context *sc = dd->send_contexts[i].sc;
+
+		if (!sc)
+			continue;
+		sc_wait_for_packet_egress(sc, 0);
+	}
+}
+
+/*
+ * Restart a context after it has been halted due to error.
+ *
+ * If the first step fails - wait for the halt to be asserted, return early.
+ * Otherwise complain about timeouts but keep going.
+ *
+ * It is expected that allocations (enabled flag bit) have been shut off
+ * already (only applies to kernel contexts).
+ */
+int sc_restart(struct send_context *sc)
+{
+	struct hfi2_devdata *dd = sc->dd;
+	u64 reg;
+	u32 loop;
+	int count;
+
+	/* bounce off if not (halted or link down) or being free'd */
+	if (!(sc->flags & (SCF_HALTED | SCF_LINK_DOWN)) || (sc->flags & SCF_IN_FREE))
+		return -EINVAL;
+
+	dd_dev_info(dd, "restarting send context %u(%u)\n", sc->sw_index,
+		    sc->hw_context);
+
+	/*
+	 * Step 1: Wait for the context to actually halt.
+	 *
+	 * The error interrupt is asynchronous to actually setting halt
+	 * on the context.
+	 */
+	if (sc->flags & SCF_HALTED) {
+		loop = 0;
+		while (1) {
+			reg = read_sctxt_csr(dd, sc->hw_context,
+					     dd->params->send_ctxt_status_reg);
+			if (reg & SC(STATUS_CTXT_HALTED_SMASK))
+				break;
+			if (loop > 100) {
+				dd_dev_err(dd, "%s: context %u(%u) not halting, skipping\n",
+					   __func__, sc->sw_index, sc->hw_context);
+				return -ETIME;
+			}
+			loop++;
+			udelay(1);
+		}
+	}
+
+	/*
+	 * Step 2: Ensure no users are still trying to write to PIO.
+	 *
+	 * For kernel contexts, we have already turned off buffer allocation.
+	 * Now wait for the buffer count to go to zero.
+	 *
+	 * For user contexts, the user handling code has cut off write access
+	 * to the context's PIO pages before calling this routine and will
+	 * restore write access after this routine returns.
+	 */
+	if (sc->type != SC_USER) {
+		/* kernel context */
+		loop = 0;
+		while (1) {
+			count = get_buffers_allocated(sc);
+			if (count == 0)
+				break;
+			if (loop > 100) {
+				dd_dev_err(dd,
+					   "%s: context %u(%u) timeout waiting for PIO buffers to zero, remaining %d\n",
+					   __func__, sc->sw_index,
+					   sc->hw_context, count);
+			}
+			loop++;
+			udelay(1);
+		}
+	}
+
+	/*
+	 * Step 3: Wait for all packets to egress.
+	 * This is done while disabling the send context
+	 *
+	 * Step 4: Disable the context
+	 *
+	 * This is a superset of the halt.  After the disable, the
+	 * errors can be cleared.
+	 */
+	sc_disable(sc);
+
+	/*
+	 * Step 5: Enable the context
+	 *
+	 * This enable will clear the halted flag and per-send context
+	 * error flags.
+	 */
+	return sc_enable(sc);
+}
+
+/*
+ * PIO freeze processing.  To be called after the TXE block is fully frozen.
+ * Go through all frozen send contexts and disable them.  The contexts are
+ * already stopped by the freeze.
+ */
+void pio_freeze(struct hfi2_devdata *dd)
+{
+	struct send_context *sc;
+	int i;
+
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		/*
+		 * Don't disable unallocated, unfrozen, or user send contexts.
+		 * User send contexts will be disabled when the process
+		 * calls into the driver to reset its context.
+		 */
+		if (!sc || !(sc->flags & SCF_FROZEN) || sc->type == SC_USER)
+			continue;
+
+		/* only need to disable, the context is already stopped */
+		sc_disable(sc);
+	}
+}
+
+/*
+ * Unfreeze PIO for kernel send contexts.  The precondition for calling this
+ * is that all PIO send contexts have been disabled and the SPC freeze has
+ * been cleared.  Now perform the last step and re-enable each kernel context.
+ * User (PSM) processing will occur when PSM calls into the kernel to
+ * acknowledge the freeze.
+ */
+void pio_kernel_unfreeze(struct hfi2_devdata *dd)
+{
+	struct send_context *sc;
+	int i;
+
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (!sc || !(sc->flags & SCF_FROZEN) || sc->type == SC_USER)
+			continue;
+		if (sc->flags & SCF_LINK_DOWN)
+			continue;
+
+		sc_enable(sc);	/* will clear the sc frozen flag */
+	}
+}
+
+/**
+ * pio_kernel_linkup() - Re-enable send contexts after linkup event
+ * @ppd: port data
+ *
+ * When the link goes down, the freeze path is taken.  However, a link down
+ * event is different from a freeze because if the send context is re-enabled
+ * whowever is sending data will start sending data again, which will hang
+ * any QP that is sending data.
+ *
+ * The freeze path now looks at the type of event that occurs and takes this
+ * path for link down event.
+ */
+void pio_kernel_linkup(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct send_context *sc;
+	int i;
+
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		sc = dd->send_contexts[i].sc;
+		if (!sc || !(sc->flags & SCF_LINK_DOWN) || sc->type == SC_USER)
+			continue;
+		/* this port only */
+		if (sc->ppd != ppd)
+			continue;
+
+		sc_enable(sc);	/* will clear the sc link down flag */
+	}
+}
+
+/*
+ * Wait for the SendPioInitCtxt.PioInitInProgress bit to clear.
+ * Returns:
+ *	-ETIMEDOUT - if we wait too long
+ *	-EIO	   - if there was an error
+ */
+static int pio_init_wait_progress(struct hfi2_devdata *dd)
+{
+	u64 reg;
+	int max, count = 0;
+
+	/* max is the longest possible HW init time / delay */
+	max = 5;
+	while (1) {
+		reg = read_csr(dd, dd->params->send_pio_init_ctxt_reg);
+		if (!(reg & SEND_PIO_INIT_CTXT_PIO_INIT_IN_PROGRESS_SMASK))
+			break;
+		if (count >= max)
+			return -ETIMEDOUT;
+		udelay(5);
+		count++;
+	}
+
+	return reg & SEND_PIO_INIT_CTXT_PIO_INIT_ERR_SMASK ? -EIO : 0;
+}
+
+/*
+ * Reset all of the send contexts to their power-on state.  Used
+ * only during manual init - no lock against sc_enable needed.
+ */
+void pio_reset_all(struct hfi2_devdata *dd)
+{
+	int ret;
+
+	/* make sure the init engine is not busy */
+	ret = pio_init_wait_progress(dd);
+	/* ignore any timeout */
+	if (ret == -EIO) {
+		/* clear the error */
+		write_csr(dd, dd->params->send_pio_err_clear_reg,
+			  SEND_PIO_ERR_CLEAR_PIO_INIT_SM_IN_ERR_SMASK);
+	}
+
+	/* reset init all */
+	write_csr(dd, dd->params->send_pio_init_ctxt_reg,
+		  SEND_PIO_INIT_CTXT_PIO_ALL_CTXT_INIT_SMASK);
+	udelay(2);
+	ret = pio_init_wait_progress(dd);
+	if (ret < 0) {
+		dd_dev_err(dd,
+			   "PIO send context init %s while initializing all PIO blocks\n",
+			   ret == -ETIMEDOUT ? "is stuck" : "had an error");
+	}
+}
+
+/* enable the context */
+int sc_enable(struct send_context *sc)
+{
+	u64 sc_ctrl, reg, pio;
+	struct hfi2_devdata *dd;
+	unsigned long flags;
+	int ret = 0;
+
+	if (!sc)
+		return -EINVAL;
+	dd = sc->dd;
+
+	/*
+	 * Obtain the allocator lock to guard against any allocation
+	 * attempts (which should not happen prior to context being
+	 * enabled). On the release/disable side we don't need to
+	 * worry about locking since the releaser will not do anything
+	 * if the context accounting values have not changed.
+	 */
+	spin_lock_irqsave(&sc->alloc_lock, flags);
+	sc_ctrl = read_tctxt_csr(dd, sc->hw_context,
+				 dd->params->send_ctxt_ctrl_reg);
+	if ((sc_ctrl & SC(CTRL_CTXT_ENABLE_SMASK)))
+		goto unlock; /* already enabled */
+
+	/* IMPORTANT: only clear free and fill if transitioning 0 -> 1 */
+
+	*sc->hw_free = 0;
+	sc->free = 0;
+	sc->alloc_free = 0;
+	sc->fill = 0;
+	sc->fill_wrap = 0;
+	sc->sr_head = 0;
+	sc->sr_tail = 0;
+	sc->flags = 0;
+	/* the alloc lock insures no fast path allocation */
+	reset_buffers_allocated(sc);
+
+	/*
+	 * Clear all per-context errors.  Some of these will be set when
+	 * we are re-enabling after a context halt.  Now that the context
+	 * is disabled, the halt will not clear until after the PIO init
+	 * engine runs below.
+	 */
+	reg = read_sctxt_csr(dd, sc->hw_context, dd->params->send_ctxt_err_status_reg);
+	if (reg)
+		write_sctxt_csr(dd, sc->hw_context, dd->params->send_ctxt_err_clear_reg, reg);
+
+	/*
+	 * The HW PIO initialization engine can handle only one init
+	 * request at a time. Serialize access to each device's engine.
+	 */
+	spin_lock(&dd->sc_init_lock);
+	/*
+	 * Since access to this code block is serialized and
+	 * each access waits for the initialization to complete
+	 * before releasing the lock, the PIO initialization engine
+	 * should not be in use, so we don't have to wait for the
+	 * InProgress bit to go down.
+	 */
+	pio = ((sc->hw_context & SEND_PIO_INIT_CTXT_PIO_CTXT_NUM_MASK) <<
+	       SEND_PIO_INIT_CTXT_PIO_CTXT_NUM_SHIFT) |
+		SEND_PIO_INIT_CTXT_PIO_SINGLE_CTXT_INIT_SMASK;
+	write_csr(dd, dd->params->send_pio_init_ctxt_reg, pio);
+	/*
+	 * Wait until the engine is done.  Give the chip the required time
+	 * so, hopefully, we read the register just once.
+	 */
+	udelay(2);
+	ret = pio_init_wait_progress(dd);
+	spin_unlock(&dd->sc_init_lock);
+	if (ret) {
+		dd_dev_err(dd,
+			   "sctxt%u(%u): Context not enabled due to init failure %d\n",
+			   sc->sw_index, sc->hw_context, ret);
+		goto unlock;
+	}
+
+	/*
+	 * All is well. Enable the context.
+	 */
+	sc_ctrl |= SC(CTRL_CTXT_ENABLE_SMASK);
+	write_tctxt_csr(dd, sc->hw_context, dd->params->send_ctxt_ctrl_reg,
+			sc_ctrl);
+	/*
+	 * Read SendCtxtCtrl to force the write out and prevent a timing
+	 * hazard where a PIO write may reach the context before the enable.
+	 */
+	read_tctxt_csr(dd, sc->hw_context, dd->params->send_ctxt_ctrl_reg);
+	sc->flags |= SCF_ENABLED;
+
+unlock:
+	spin_unlock_irqrestore(&sc->alloc_lock, flags);
+
+	return ret;
+}
+
+/* force a credit return on the context */
+void sc_return_credits(struct send_context *sc)
+{
+	if (!sc)
+		return;
+
+	/* a 0->1 transition schedules a credit return */
+	write_sctxt_csr(sc->dd, sc->hw_context,
+			sc->dd->params->send_ctxt_credit_force_reg,
+			SC(CREDIT_FORCE_FORCE_RETURN_SMASK));
+	/*
+	 * Ensure that the write is flushed and the credit return is
+	 * scheduled. We care more about the 0 -> 1 transition.
+	 */
+	read_sctxt_csr(sc->dd, sc->hw_context,
+		       sc->dd->params->send_ctxt_credit_force_reg);
+	/* set back to 0 for next time */
+	write_sctxt_csr(sc->dd, sc->hw_context,
+			sc->dd->params->send_ctxt_credit_force_reg, 0);
+}
+
+/* allow all in-flight packets to drain on the context */
+void sc_flush(struct send_context *sc)
+{
+	if (!sc)
+		return;
+
+	sc_wait_for_packet_egress(sc, 1);
+}
+
+/* drop all packets on the context, no waiting until they are sent */
+void sc_drop(struct send_context *sc)
+{
+	if (!sc)
+		return;
+
+	dd_dev_info(sc->dd, "%s: context %u(%u) - not implemented\n",
+		    __func__, sc->sw_index, sc->hw_context);
+}
+
+/*
+ * Start the software reaction to a context halt or SPC freeze:
+ *	- mark the context as halted or frozen
+ *	- stop buffer allocations
+ *
+ * Called from the error interrupt.  Other work is deferred until
+ * out of the interrupt.
+ */
+void sc_stop(struct send_context *sc, int flag)
+{
+	unsigned long flags;
+
+	/* stop buffer allocations */
+	spin_lock_irqsave(&sc->alloc_lock, flags);
+	/* mark the context */
+	sc->flags |= flag;
+	sc->flags &= ~SCF_ENABLED;
+	spin_unlock_irqrestore(&sc->alloc_lock, flags);
+	wake_up(&sc->halt_wait);
+}
+
+#define BLOCK_DWORDS (PIO_BLOCK_SIZE / sizeof(u32))
+#define dwords_to_blocks(x) DIV_ROUND_UP(x, BLOCK_DWORDS)
+
+/*
+ * The send context buffer "allocator".
+ *
+ * @sc: the PIO send context we are allocating from
+ * @len: length of whole packet - including PBC - in dwords
+ * @cb: optional callback to call when the buffer is finished sending
+ * @arg: argument for cb
+ *
+ * Return a pointer to a PIO buffer, NULL if not enough room, -ECOMM
+ * when link is down.
+ */
+struct pio_buf *sc_buffer_alloc(struct send_context *sc, u32 dw_len,
+				pio_release_cb cb, void *arg)
+{
+	struct pio_buf *pbuf = NULL;
+	unsigned long flags;
+	unsigned long avail;
+	unsigned long blocks = dwords_to_blocks(dw_len);
+	u32 fill_wrap;
+	int trycount = 0;
+	u32 head, next;
+
+	spin_lock_irqsave(&sc->alloc_lock, flags);
+	if (!(sc->flags & SCF_ENABLED)) {
+		spin_unlock_irqrestore(&sc->alloc_lock, flags);
+		return ERR_PTR(-ECOMM);
+	}
+
+retry:
+	avail = (unsigned long)sc->credits - (sc->fill - sc->alloc_free);
+	if (blocks > avail) {
+		/* not enough room */
+		if (unlikely(trycount))	{ /* already tried to get more room */
+			spin_unlock_irqrestore(&sc->alloc_lock, flags);
+			goto done;
+		}
+		/* copy from receiver cache line and recalculate */
+		sc->alloc_free = READ_ONCE(sc->free);
+		avail =
+			(unsigned long)sc->credits -
+			(sc->fill - sc->alloc_free);
+		if (blocks > avail) {
+			/* still no room, actively update */
+			sc_release_update(sc);
+			sc->alloc_free = READ_ONCE(sc->free);
+			trycount++;
+			goto retry;
+		}
+	}
+
+	/* there is enough room */
+
+	preempt_disable();
+	this_cpu_inc(*sc->buffers_allocated);
+
+	/* read this once */
+	head = sc->sr_head;
+
+	/* "allocate" the buffer */
+	sc->fill += blocks;
+	fill_wrap = sc->fill_wrap;
+	sc->fill_wrap += blocks;
+	if (sc->fill_wrap >= sc->credits)
+		sc->fill_wrap = sc->fill_wrap - sc->credits;
+
+	/*
+	 * Fill the parts that the releaser looks at before moving the head.
+	 * The only necessary piece is the sent_at field.  The credits
+	 * we have just allocated cannot have been returned yet, so the
+	 * cb and arg will not be looked at for a "while".  Put them
+	 * on this side of the memory barrier anyway.
+	 */
+	pbuf = &sc->sr[head].pbuf;
+	pbuf->sent_at = sc->fill;
+	pbuf->cb = cb;
+	pbuf->arg = arg;
+	pbuf->sc = sc;	/* could be filled in at sc->sr init time */
+	/* make sure this is in memory before updating the head */
+
+	/* calculate next head index, do not store */
+	next = head + 1;
+	if (next >= sc->sr_size)
+		next = 0;
+	/*
+	 * update the head - must be last! - the releaser can look at fields
+	 * in pbuf once we move the head
+	 */
+	smp_wmb();
+	sc->sr_head = next;
+	spin_unlock_irqrestore(&sc->alloc_lock, flags);
+
+	/* finish filling in the buffer outside the lock */
+	pbuf->start = sc->base_addr + fill_wrap * PIO_BLOCK_SIZE;
+	pbuf->end = sc->base_addr + sc->size;
+	pbuf->qw_written = 0;
+	pbuf->carry_bytes = 0;
+	pbuf->carry.val64 = 0;
+done:
+	return pbuf;
+}
+
+/*
+ * There are at least two entities that can turn on credit return
+ * interrupts and they can overlap.  Avoid problems by implementing
+ * a count scheme that is enforced by a lock.  The lock is needed because
+ * the count and CSR write must be paired.
+ */
+
+/*
+ * Start credit return interrupts.  This is managed by a count.  If already
+ * on, just increment the count.
+ */
+void sc_add_credit_return_intr(struct send_context *sc)
+{
+	unsigned long flags;
+
+	/* lock must surround both the count change and the CSR update */
+	spin_lock_irqsave(&sc->credit_ctrl_lock, flags);
+	if (sc->credit_intr_count == 0) {
+		sc->credit_ctrl |= SC(CREDIT_CTRL_CREDIT_INTR_SMASK);
+		write_sctxt_csr(sc->dd, sc->hw_context,
+				sc->dd->params->send_ctxt_credit_ctrl_reg,
+				sc->credit_ctrl);
+	}
+	sc->credit_intr_count++;
+	spin_unlock_irqrestore(&sc->credit_ctrl_lock, flags);
+}
+
+/*
+ * Stop credit return interrupts.  This is managed by a count.  Decrement the
+ * count, if the last user, then turn the credit interrupts off.
+ */
+void sc_del_credit_return_intr(struct send_context *sc)
+{
+	unsigned long flags;
+
+	WARN_ON(sc->credit_intr_count == 0);
+
+	/* lock must surround both the count change and the CSR update */
+	spin_lock_irqsave(&sc->credit_ctrl_lock, flags);
+	sc->credit_intr_count--;
+	if (sc->credit_intr_count == 0) {
+		sc->credit_ctrl &= ~SC(CREDIT_CTRL_CREDIT_INTR_SMASK);
+		write_sctxt_csr(sc->dd, sc->hw_context,
+				sc->dd->params->send_ctxt_credit_ctrl_reg,
+				sc->credit_ctrl);
+	}
+	spin_unlock_irqrestore(&sc->credit_ctrl_lock, flags);
+}
+
+/*
+ * The caller must be careful when calling this.  All needint calls
+ * must be paired with !needint.
+ */
+void hfi2_sc_wantpiobuf_intr(struct send_context *sc, u32 needint)
+{
+	if (needint)
+		sc_add_credit_return_intr(sc);
+	else
+		sc_del_credit_return_intr(sc);
+	trace_hfi2_wantpiointr(sc, needint, sc->credit_ctrl);
+	if (needint)
+		sc_return_credits(sc);
+}
+
+/**
+ * sc_piobufavail - callback when a PIO buffer is available
+ * @sc: the send context
+ *
+ * This is called from the interrupt handler when a PIO buffer is
+ * available after hfi2_verbs_send() returned an error that no buffers were
+ * available. Disable the interrupt if there are no more QPs waiting.
+ */
+static void sc_piobufavail(struct send_context *sc)
+{
+	struct hfi2_devdata *dd = sc->dd;
+	struct list_head *list;
+	struct rvt_qp *qps[PIO_WAIT_BATCH_SIZE];
+	struct rvt_qp *qp;
+	struct hfi2_qp_priv *priv;
+	unsigned long flags;
+	uint i, n = 0, top_idx = 0;
+
+	if (dd->send_contexts[sc->sw_index].type != SC_KERNEL &&
+	    dd->send_contexts[sc->sw_index].type != SC_VL15)
+		return;
+	list = &sc->piowait;
+	/*
+	 * Note: checking that the piowait list is empty and clearing
+	 * the buffer available interrupt needs to be atomic or we
+	 * could end up with QPs on the wait list with the interrupt
+	 * disabled.
+	 */
+	write_seqlock_irqsave(&sc->waitlock, flags);
+	while (!list_empty(list)) {
+		struct iowait *wait;
+
+		if (n == ARRAY_SIZE(qps))
+			break;
+		wait = list_first_entry(list, struct iowait, list);
+		iowait_get_priority(wait);
+		qp = iowait_to_qp(wait);
+		priv = qp->priv;
+		list_del_init(&priv->s_iowait.list);
+		priv->s_iowait.lock = NULL;
+		if (n) {
+			priv = qps[top_idx]->priv;
+			top_idx = iowait_priority_update_top(wait,
+							     &priv->s_iowait,
+							     n, top_idx);
+		}
+
+		/* refcount held until actual wake up */
+		qps[n++] = qp;
+	}
+	/*
+	 * If there had been waiters and there are more
+	 * insure that we redo the force to avoid a potential hang.
+	 */
+	if (n) {
+		hfi2_sc_wantpiobuf_intr(sc, 0);
+		if (!list_empty(list))
+			hfi2_sc_wantpiobuf_intr(sc, 1);
+	}
+	write_sequnlock_irqrestore(&sc->waitlock, flags);
+
+	/* Wake up the top-priority one first */
+	if (n)
+		hfi2_qp_wakeup(qps[top_idx],
+			       RVT_S_WAIT_PIO | HFI2_S_WAIT_PIO_DRAIN);
+	for (i = 0; i < n; i++)
+		if (i != top_idx)
+			hfi2_qp_wakeup(qps[i],
+				       RVT_S_WAIT_PIO | HFI2_S_WAIT_PIO_DRAIN);
+}
+
+/* translate a send credit update to a bit code of reasons */
+static inline int fill_code(u64 hw_free)
+{
+	int code = 0;
+
+	if (hw_free & CR_STATUS_SMASK)
+		code |= PRC_STATUS_ERR;
+	if (hw_free & CR_CREDIT_RETURN_DUE_TO_PBC_SMASK)
+		code |= PRC_PBC;
+	if (hw_free & CR_CREDIT_RETURN_DUE_TO_THRESHOLD_SMASK)
+		code |= PRC_THRESHOLD;
+	if (hw_free & CR_CREDIT_RETURN_DUE_TO_ERR_SMASK)
+		code |= PRC_FILL_ERR;
+	if (hw_free & CR_CREDIT_RETURN_DUE_TO_FORCE_SMASK)
+		code |= PRC_SC_DISABLE;
+	return code;
+}
+
+/* use the jiffies compare to get the wrap right */
+#define sent_before(a, b) time_before(a, b)	/* a < b */
+
+/*
+ * The send context buffer "releaser".
+ */
+void sc_release_update(struct send_context *sc)
+{
+	struct pio_buf *pbuf;
+	u64 hw_free;
+	u32 head, tail;
+	unsigned long old_free;
+	unsigned long free;
+	unsigned long extra;
+	unsigned long flags;
+	int code;
+
+	if (!sc)
+		return;
+
+	spin_lock_irqsave(&sc->release_lock, flags);
+	/* update free */
+	hw_free = le64_to_cpu(*sc->hw_free);		/* volatile read */
+	old_free = sc->free;
+	extra = (((hw_free & CR_COUNTER_SMASK) >> CR_COUNTER_SHIFT)
+			- (old_free & CR_COUNTER_MASK))
+				& CR_COUNTER_MASK;
+	free = old_free + extra;
+	trace_hfi2_piofree(sc, extra);
+
+	/* call sent buffer callbacks */
+	code = -1;				/* code not yet set */
+	head = READ_ONCE(sc->sr_head);	/* snapshot the head */
+	tail = sc->sr_tail;
+	while (head != tail) {
+		pbuf = &sc->sr[tail].pbuf;
+
+		if (sent_before(free, pbuf->sent_at)) {
+			/* not sent yet */
+			break;
+		}
+		if (pbuf->cb) {
+			if (code < 0) /* fill in code on first user */
+				code = fill_code(hw_free);
+			(*pbuf->cb)(pbuf->arg, code);
+		}
+
+		tail++;
+		if (tail >= sc->sr_size)
+			tail = 0;
+	}
+	sc->sr_tail = tail;
+	/* make sure tail is updated before free */
+	smp_wmb();
+	sc->free = free;
+	spin_unlock_irqrestore(&sc->release_lock, flags);
+	sc_piobufavail(sc);
+}
+
+/*
+ * Send context group releaser.  Argument is the send context that caused
+ * the interrupt.  Called from the send context interrupt handler.
+ *
+ * Call release on all contexts in the group.
+ *
+ * This routine takes the sc_lock without an irqsave because it is only
+ * called from an interrupt handler.  Adjust if that changes.
+ */
+void sc_group_release_update(struct hfi2_devdata *dd, u32 hw_context)
+{
+	struct send_context *sc;
+	u32 sw_index;
+	u32 gc, gc_end;
+
+	spin_lock(&dd->sc_lock);
+	sw_index = dd->hw_to_sw[hw_context];
+	if (unlikely(sw_index >= dd->num_send_contexts)) {
+		dd_dev_err(dd, "%s: invalid hw (%u) to sw (%u) mapping\n",
+			   __func__, hw_context, sw_index);
+		goto done;
+	}
+	sc = dd->send_contexts[sw_index].sc;
+	if (unlikely(!sc))
+		goto done;
+
+	gc = group_context(hw_context, sc->group);
+	gc_end = gc + group_size(sc->group);
+	for (; gc < gc_end; gc++) {
+		sw_index = dd->hw_to_sw[gc];
+		if (unlikely(sw_index >= dd->num_send_contexts)) {
+			dd_dev_err(dd,
+				   "%s: invalid hw (%u) to sw (%u) mapping\n",
+				   __func__, hw_context, sw_index);
+			continue;
+		}
+		sc_release_update(dd->send_contexts[sw_index].sc);
+	}
+done:
+	spin_unlock(&dd->sc_lock);
+}
+
+/*
+ * pio_select_send_context_vl() - select send context
+ * @dd: devdata
+ * @selector: a spreading factor
+ * @vl: this vl
+ *
+ * This function returns a send context based on the selector and a vl.
+ * The mapping fields are protected by RCU
+ */
+struct send_context *pio_select_send_context_vl(struct hfi2_pportdata *ppd,
+						u32 selector, u8 vl)
+{
+	struct pio_vl_map *m;
+	struct pio_map_elem *e;
+	struct send_context *rval;
+
+	/*
+	 * NOTE This should only happen if SC->VL changed after the initial
+	 * checks on the QP/AH
+	 * Default will return VL0's send context below
+	 */
+	if (unlikely(vl >= num_vls)) {
+		rval = NULL;
+		goto done;
+	}
+
+	rcu_read_lock();
+	m = rcu_dereference(ppd->pio_map);
+	if (unlikely(!m)) {
+		rcu_read_unlock();
+		return ppd->vld[0].sc;
+	}
+	e = m->map[vl & m->mask];
+	rval = e->ksc[selector & e->mask];
+	rcu_read_unlock();
+
+done:
+	rval = !rval ? ppd->vld[0].sc : rval;
+	return rval;
+}
+
+/*
+ * pio_select_send_context_sc() - select send context
+ * @dd: devdata
+ * @selector: a spreading factor
+ * @sc5: the 5 bit sc
+ *
+ * This function returns an send context based on the selector and an sc
+ */
+struct send_context *pio_select_send_context_sc(struct hfi2_pportdata *ppd,
+						u32 selector, u8 sc5)
+{
+	u8 vl = sc_to_vlt(ppd, sc5);
+
+	return pio_select_send_context_vl(ppd, selector, vl);
+}
+
+/*
+ * Free the indicated map struct
+ */
+static void pio_map_free(struct pio_vl_map *m)
+{
+	int i;
+
+	for (i = 0; m && i < m->actual_vls; i++)
+		kfree(m->map[i]);
+	kfree(m);
+}
+
+/*
+ * Handle RCU callback
+ */
+static void pio_map_rcu_callback(struct rcu_head *list)
+{
+	struct pio_vl_map *m = container_of(list, struct pio_vl_map, list);
+
+	pio_map_free(m);
+}
+
+/*
+ * Set credit return threshold for the kernel send context
+ */
+static void set_threshold(struct hfi2_pportdata *ppd, int scontext, int i)
+{
+	struct send_context *sc = ppd->kernel_send_context[scontext];
+	u32 thres;
+
+	thres = min(sc_percent_to_threshold(sc, 50),
+		    sc_mtu_to_threshold(sc, sc->ppd->vld[i].mtu,
+					kctxt_hdrqentsize(sc->ppd)));
+	sc_set_cr_threshold(sc, thres);
+}
+
+/*
+ * pio_map_init - called when #vls change
+ * @dd: hfi2_devdata
+ * @num_vls: number of vls
+ *
+ * This routine changes the vl to send context mapping based on the number of
+ * vls and available send contexts.
+ *
+ * The auto algorithm computes the sc_per_vl and the number of extra send
+ * contexts. Any extra send contexts are added from the highest VL on down
+ *
+ * rcu locking is used to control access to the mapping fields.
+ *
+ * If either the num_vls or vl_scontexts[vl] are non-power of 2, the array
+ * sizes in the struct pio_vl_map and the struct pio_map_elem are rounded up
+ * to the next highest power of 2 and the first entry is reused in a round
+ * robin fashion.
+ *
+ * If an error occurs the mapping is not changed.
+ */
+int pio_map_init(struct hfi2_pportdata *ppd, u8 num_vls)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i, j;
+	int extra, sc_per_vl;
+	int scontext = 1; /* first non-vl15 kernel_send_context */
+	int num_kernel_send_contexts = 0;
+	int vl_scontexts[OPA_MAX_VLS];
+	struct pio_vl_map *oldmap, *newmap;
+
+	/* assign a count of send contexts to each VL */
+	/* count kernel send contexts for this port */
+	for (i = 0; i < dd->num_send_contexts; i++) {
+		if (dd->send_contexts[i].type != SC_KERNEL)
+			continue;
+		if (!dd->send_contexts[i].sc)
+			continue;
+		if (dd->send_contexts[i].sc->ppd != ppd)
+			continue;
+		num_kernel_send_contexts++;
+	}
+	/* truncate divide */
+	sc_per_vl = num_kernel_send_contexts / num_vls;
+	/* extras */
+	extra = num_kernel_send_contexts % num_vls;
+	/* add extras from last vl down */
+	for (i = num_vls - 1; i >= 0; i--, extra--)
+		vl_scontexts[i] = sc_per_vl + (extra > 0 ? 1 : 0);
+
+	/* build new map */
+	newmap = kzalloc(struct_size(newmap, map, roundup_pow_of_two(num_vls)),
+			 GFP_KERNEL);
+	if (!newmap)
+		goto bail;
+	newmap->actual_vls = num_vls;
+	newmap->vls = roundup_pow_of_two(num_vls);
+	newmap->mask = (1 << ilog2(newmap->vls)) - 1;
+	for (i = 0; i < newmap->vls; i++) {
+		/* save for wrap around */
+		int first_scontext = scontext;
+
+		if (i < newmap->actual_vls) {
+			int sz = roundup_pow_of_two(vl_scontexts[i]);
+
+			/* only allocate once */
+			newmap->map[i] = kzalloc(struct_size(newmap->map[i],
+							     ksc, sz),
+						 GFP_KERNEL);
+			if (!newmap->map[i])
+				goto bail;
+			newmap->map[i]->mask = (1 << ilog2(sz)) - 1;
+			/*
+			 * assign send contexts and
+			 * adjust credit return threshold
+			 */
+			for (j = 0; j < sz; j++) {
+				if (ppd->kernel_send_context[scontext]) {
+					newmap->map[i]->ksc[j] =
+					    ppd->kernel_send_context[scontext];
+					set_threshold(ppd, scontext, i);
+				}
+				if (++scontext >= first_scontext +
+						  vl_scontexts[i])
+					/* wrap back to first send context */
+					scontext = first_scontext;
+			}
+		} else {
+			/* just re-use entry without allocating */
+			newmap->map[i] = newmap->map[i % num_vls];
+		}
+		scontext = first_scontext + vl_scontexts[i];
+	}
+	/* newmap in hand, save old map */
+	spin_lock_irq(&dd->pio_map_lock);
+	oldmap = rcu_dereference_protected(ppd->pio_map,
+					   lockdep_is_held(&dd->pio_map_lock));
+
+	/* publish newmap */
+	rcu_assign_pointer(ppd->pio_map, newmap);
+
+	spin_unlock_irq(&dd->pio_map_lock);
+	/* success, free any old map after grace period */
+	if (oldmap)
+		call_rcu(&oldmap->list, pio_map_rcu_callback);
+	return 0;
+bail:
+	/* free any partial allocation */
+	pio_map_free(newmap);
+	return -ENOMEM;
+}
+
+void free_pio_map(struct hfi2_devdata *dd)
+{
+	struct hfi2_pportdata *ppd;
+	int i;
+
+	for (i = 0; i < dd->num_pports; i++) {
+		ppd = dd->pport + i;
+		/* Free PIO map if allocated */
+		if (rcu_access_pointer(ppd->pio_map)) {
+			spin_lock_irq(&dd->pio_map_lock);
+			pio_map_free(rcu_access_pointer(ppd->pio_map));
+			RCU_INIT_POINTER(ppd->pio_map, NULL);
+			spin_unlock_irq(&dd->pio_map_lock);
+			synchronize_rcu();
+		}
+		kfree(ppd->kernel_send_context);
+		ppd->kernel_send_context = NULL;
+	}
+}
+
+int init_pervl_scs(struct hfi2_pportdata *ppd)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct send_context *sc;
+	int i;
+	u64 mask;
+	const u64 all_vl_mask = (u64)0x80ff; /* VLs 0-7, 15 */
+	const u64 data_vls_mask = (u64)0x00ff; /* VLs 0-7 */
+	u32 ctxt;
+	u8 rcvhdrqentsize;
+
+	/* do nothing for an unavailable port */
+	if (!port_available_ppd(ppd))
+		return 0;
+
+	rcvhdrqentsize = kctxt_hdrqentsize(ppd);
+	ppd->vld[15].sc = sc_alloc(ppd, SC_VL15, rcvhdrqentsize, dd->node);
+	if (!ppd->vld[15].sc)
+		return -ENOMEM;
+
+	hfi2_init_ctxt(ppd->vld[15].sc);
+	ppd->vld[15].mtu = enum_to_mtu(OPA_MTU_2048);
+
+	ppd->kernel_send_context = kcalloc_node(dd->num_send_contexts,
+					        sizeof(struct send_context *),
+					        GFP_KERNEL, dd->node);
+	if (!ppd->kernel_send_context)
+		goto freesc15;
+
+	ppd->kernel_send_context[0] = ppd->vld[15].sc;
+
+	for (i = 0; i < num_vls; i++) {
+		sc = sc_alloc(ppd, SC_KERNEL, rcvhdrqentsize, dd->node);
+		if (!sc)
+			goto nomem;
+		hfi2_init_ctxt(sc);
+		ppd->kernel_send_context[i + 1] = sc;
+		ppd->vld[i].sc = sc;
+		/* non VL15 start with the max MTU */
+		ppd->vld[i].mtu = hfi2_max_mtu;
+	}
+	for (i = num_vls; i < INIT_SC_PER_VL * num_vls; i++) {
+		sc = sc_alloc(ppd, SC_KERNEL, rcvhdrqentsize, dd->node);
+		if (!sc)
+			goto nomem;
+		hfi2_init_ctxt(sc);
+		ppd->kernel_send_context[i + 1] = sc;
+	}
+
+	sc_enable(ppd->vld[15].sc);
+	ctxt = ppd->vld[15].sc->hw_context;
+	mask = all_vl_mask & ~(1LL << 15);
+	write_epsc_csr(dd, ppd->hw_pidx, ctxt, dd->params->send_ctxt_check_vl_reg, mask);
+	dd_dev_info(dd,
+		    "pidx %d: Using send context %u(%u) for VL15\n",
+		    ppd->hw_pidx, ppd->vld[15].sc->sw_index, ctxt);
+
+	for (i = 0; i < num_vls; i++) {
+		sc_enable(ppd->vld[i].sc);
+		ctxt = ppd->vld[i].sc->hw_context;
+		mask = all_vl_mask & ~(data_vls_mask);
+		write_epsc_csr(dd, ppd->hw_pidx, ctxt, dd->params->send_ctxt_check_vl_reg, mask);
+	}
+	for (i = num_vls; i < INIT_SC_PER_VL * num_vls; i++) {
+		sc_enable(ppd->kernel_send_context[i + 1]);
+		ctxt = ppd->kernel_send_context[i + 1]->hw_context;
+		mask = all_vl_mask & ~(data_vls_mask);
+		write_epsc_csr(dd, ppd->hw_pidx, ctxt, dd->params->send_ctxt_check_vl_reg, mask);
+	}
+
+	if (pio_map_init(ppd, num_vls))
+		goto nomem;
+	return 0;
+
+nomem:
+	for (i = 0; i < num_vls; i++) {
+		sc_free(ppd->vld[i].sc);
+		ppd->vld[i].sc = NULL;
+	}
+
+	for (i = num_vls; i < INIT_SC_PER_VL * num_vls; i++)
+		sc_free(ppd->kernel_send_context[i + 1]);
+
+	kfree(ppd->kernel_send_context);
+	ppd->kernel_send_context = NULL;
+
+freesc15:
+	sc_free(ppd->vld[15].sc);
+	ppd->vld[15].sc = NULL;
+	return -ENOMEM;
+}
+
+int init_credit_return(struct hfi2_devdata *dd)
+{
+	size_t bytes = chip_send_contexts(dd) * sizeof(struct credit_return);
+	int ret;
+	int i;
+
+	dd->cr_base = kcalloc(
+		node_affinity.num_possible_nodes,
+		sizeof(struct credit_return_base),
+		GFP_KERNEL);
+	if (!dd->cr_base) {
+		ret = -ENOMEM;
+		goto done;
+	}
+	for_each_node_with_cpus(i) {
+		set_dev_node(&dd->pcidev->dev, i);
+		dd->cr_base[i].va = dma_alloc_coherent(&dd->pcidev->dev,
+						       bytes,
+						       &dd->cr_base[i].dma,
+						       GFP_KERNEL);
+		if (!dd->cr_base[i].va) {
+			set_dev_node(&dd->pcidev->dev, dd->node);
+			dd_dev_err(dd,
+				   "Unable to allocate credit return DMA range for NUMA %d\n",
+				   i);
+			ret = -ENOMEM;
+			goto free_cr_base;
+		}
+	}
+	set_dev_node(&dd->pcidev->dev, dd->node);
+
+	ret = 0;
+done:
+	return ret;
+
+free_cr_base:
+	free_credit_return(dd);
+	goto done;
+}
+
+void free_credit_return(struct hfi2_devdata *dd)
+{
+	size_t bytes = chip_send_contexts(dd) * sizeof(struct credit_return);
+	int i;
+
+	if (!dd->cr_base)
+		return;
+	for (i = 0; i < node_affinity.num_possible_nodes; i++) {
+		if (dd->cr_base[i].va) {
+			dma_free_coherent(&dd->pcidev->dev,
+					  bytes,
+					  dd->cr_base[i].va,
+					  dd->cr_base[i].dma);
+		}
+	}
+	kfree(dd->cr_base);
+	dd->cr_base = NULL;
+}
+
+void seqfile_dump_sci(struct seq_file *s, u32 i,
+		      struct send_context_info *sci)
+{
+	struct send_context *sc = sci->sc;
+	u64 reg;
+
+	seq_printf(s, "SCI %u: type %u base %u credits %u\n",
+		   i, sci->type, sci->base, sci->credits);
+	seq_printf(s, "  flags 0x%x sw_inx %u hw_ctxt %u grp %u\n",
+		   sc->flags,  sc->sw_index, sc->hw_context, sc->group);
+	seq_printf(s, "  sr_size %u credits %u sr_head %u sr_tail %u\n",
+		   sc->sr_size, sc->credits, sc->sr_head, sc->sr_tail);
+	seq_printf(s, "  fill %lu free %lu fill_wrap %u alloc_free %lu\n",
+		   sc->fill, sc->free, sc->fill_wrap, sc->alloc_free);
+	seq_printf(s, "  credit_intr_count %u credit_ctrl 0x%llx\n",
+		   sc->credit_intr_count, sc->credit_ctrl);
+	reg = read_sctxt_csr(sc->dd, sc->hw_context,
+			     sc->dd->params->send_ctxt_credit_status_reg);
+	seq_printf(s, "  *hw_free %llu CurrentFree %llu LastReturned %llu\n",
+		   (le64_to_cpu(*sc->hw_free) & CR_COUNTER_SMASK) >>
+		    CR_COUNTER_SHIFT,
+		   (reg >> SC(CREDIT_STATUS_CURRENT_FREE_COUNTER_SHIFT)) &
+		    SC(CREDIT_STATUS_CURRENT_FREE_COUNTER_MASK),
+		   reg & SC(CREDIT_STATUS_LAST_RETURNED_COUNTER_SMASK));
+}
diff --git a/drivers/infiniband/hw/hfi2/pio_copy.c b/drivers/infiniband/hw/hfi2/pio_copy.c
new file mode 100644
index 000000000000..d9a7b3683274
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/pio_copy.c
@@ -0,0 +1,715 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015, 2016 Intel Corporation.
+ */
+
+#include "hfi2.h"
+
+/* additive distance between non-SOP and SOP space */
+#define SOP_DISTANCE (TXE_PIO_SIZE / 2)
+#define PIO_BLOCK_MASK (PIO_BLOCK_SIZE - 1)
+/* number of QUADWORDs in a block */
+#define PIO_BLOCK_QWS (PIO_BLOCK_SIZE / sizeof(u64))
+
+/**
+ * pio_copy - copy data block to MMIO space
+ * @dd: hfi2 dev data
+ * @pbuf: a number of blocks allocated within a PIO send context
+ * @pbc: PBC to send
+ * @from: source, must be 8 byte aligned
+ * @count: number of DWORD (32-bit) quantities to copy from source
+ *
+ * Copy data from source to PIO Send Buffer memory, 8 bytes at a time.
+ * Must always write full BLOCK_SIZE bytes blocks.  The first block must
+ * be written to the corresponding SOP=1 address.
+ *
+ * Known:
+ * o pbuf->start always starts on a block boundary
+ * o pbuf can wrap only at a block boundary
+ */
+void pio_copy(struct hfi2_devdata *dd, struct pio_buf *pbuf, u64 pbc,
+	      const void *from, size_t count)
+{
+	void __iomem *dest = pbuf->start + SOP_DISTANCE;
+	void __iomem *send = dest + PIO_BLOCK_SIZE;
+	void __iomem *dend;			/* 8-byte data end */
+
+	/* write the PBC */
+	writeq(pbc, dest);
+	dest += sizeof(u64);
+
+	/* calculate where the QWORD data ends - in SOP=1 space */
+	dend = dest + ((count >> 1) * sizeof(u64));
+
+	if (dend < send) {
+		/*
+		 * all QWORD data is within the SOP block, does *not*
+		 * reach the end of the SOP block
+		 */
+
+		while (dest < dend) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+		/*
+		 * No boundary checks are needed here:
+		 * 0. We're not on the SOP block boundary
+		 * 1. The possible DWORD dangle will still be within
+		 *    the SOP block
+		 * 2. We cannot wrap except on a block boundary.
+		 */
+	} else {
+		/* QWORD data extends _to_ or beyond the SOP block */
+
+		/* write 8-byte SOP chunk data */
+		while (dest < send) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+		/* drop out of the SOP range */
+		dest -= SOP_DISTANCE;
+		dend -= SOP_DISTANCE;
+
+		/*
+		 * If the wrap comes before or matches the data end,
+		 * copy until until the wrap, then wrap.
+		 *
+		 * If the data ends at the end of the SOP above and
+		 * the buffer wraps, then pbuf->end == dend == dest
+		 * and nothing will get written, but we will wrap in
+		 * case there is a dangling DWORD.
+		 */
+		if (pbuf->end <= dend) {
+			while (dest < pbuf->end) {
+				writeq(*(u64 *)from, dest);
+				from += sizeof(u64);
+				dest += sizeof(u64);
+			}
+
+			dest -= pbuf->sc->size;
+			dend -= pbuf->sc->size;
+		}
+
+		/* write 8-byte non-SOP, non-wrap chunk data */
+		while (dest < dend) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+	}
+	/* at this point we have wrapped if we are going to wrap */
+
+	/* write dangling u32, if any */
+	if (count & 1) {
+		union mix val;
+
+		val.val64 = 0;
+		val.val32[0] = *(u32 *)from;
+		writeq(val.val64, dest);
+		dest += sizeof(u64);
+	}
+	/*
+	 * fill in rest of block, no need to check pbuf->end
+	 * as we only wrap on a block boundary
+	 */
+	while (((unsigned long)dest & PIO_BLOCK_MASK) != 0) {
+		writeq(0, dest);
+		dest += sizeof(u64);
+	}
+
+	/* finished with this buffer */
+	this_cpu_dec(*pbuf->sc->buffers_allocated);
+	preempt_enable();
+}
+
+/*
+ * Handle carry bytes using shifts and masks.
+ *
+ * NOTE: the value the unused portion of carry is expected to always be zero.
+ */
+
+/*
+ * "zero" shift - bit shift used to zero out upper bytes.  Input is
+ * the count of LSB bytes to preserve.
+ */
+#define zshift(x) (8 * (8 - (x)))
+
+/*
+ * "merge" shift - bit shift used to merge with carry bytes.  Input is
+ * the LSB byte count to move beyond.
+ */
+#define mshift(x) (8 * (x))
+
+/*
+ * Jump copy - no-loop copy for < 8 bytes.
+ */
+static inline void jcopy(u8 *dest, const u8 *src, u32 n)
+{
+	switch (n) {
+	case 7:
+		*dest++ = *src++;
+		fallthrough;
+	case 6:
+		*dest++ = *src++;
+		fallthrough;
+	case 5:
+		*dest++ = *src++;
+		fallthrough;
+	case 4:
+		*dest++ = *src++;
+		fallthrough;
+	case 3:
+		*dest++ = *src++;
+		fallthrough;
+	case 2:
+		*dest++ = *src++;
+		fallthrough;
+	case 1:
+		*dest++ = *src++;
+	}
+}
+
+/*
+ * Read nbytes from "from" and place them in the low bytes
+ * of pbuf->carry.  Other bytes are left as-is.  Any previous
+ * value in pbuf->carry is lost.
+ *
+ * NOTES:
+ * o do not read from from if nbytes is zero
+ * o from may _not_ be u64 aligned.
+ */
+static inline void read_low_bytes(struct pio_buf *pbuf, const void *from,
+				  unsigned int nbytes)
+{
+	pbuf->carry.val64 = 0;
+	jcopy(&pbuf->carry.val8[0], from, nbytes);
+	pbuf->carry_bytes = nbytes;
+}
+
+/*
+ * Read nbytes bytes from "from" and put them at the end of pbuf->carry.
+ * It is expected that the extra read does not overfill carry.
+ *
+ * NOTES:
+ * o from may _not_ be u64 aligned
+ * o nbytes may span a QW boundary
+ */
+static inline void read_extra_bytes(struct pio_buf *pbuf,
+				    const void *from, unsigned int nbytes)
+{
+	jcopy(&pbuf->carry.val8[pbuf->carry_bytes], from, nbytes);
+	pbuf->carry_bytes += nbytes;
+}
+
+/*
+ * Write a quad word using parts of pbuf->carry and the next 8 bytes of src.
+ * Put the unused part of the next 8 bytes of src into the LSB bytes of
+ * pbuf->carry with the upper bytes zeroed..
+ *
+ * NOTES:
+ * o result must keep unused bytes zeroed
+ * o src must be u64 aligned
+ */
+static inline void merge_write8(
+	struct pio_buf *pbuf,
+	void __iomem *dest,
+	const void *src)
+{
+	u64 new, temp;
+
+	new = *(u64 *)src;
+	temp = pbuf->carry.val64 | (new << mshift(pbuf->carry_bytes));
+	writeq(temp, dest);
+	pbuf->carry.val64 = new >> zshift(pbuf->carry_bytes);
+}
+
+/*
+ * Write a quad word using all bytes of carry.
+ */
+static inline void carry8_write8(union mix carry, void __iomem *dest)
+{
+	writeq(carry.val64, dest);
+}
+
+/*
+ * Write a quad word using all the valid bytes of carry.  If carry
+ * has zero valid bytes, nothing is written.
+ * Returns 0 on nothing written, non-zero on quad word written.
+ */
+static inline int carry_write8(struct pio_buf *pbuf, void __iomem *dest)
+{
+	if (pbuf->carry_bytes) {
+		/* unused bytes are always kept zeroed, so just write */
+		writeq(pbuf->carry.val64, dest);
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Segmented PIO Copy - start
+ *
+ * Start a PIO copy.
+ *
+ * @pbuf: destination buffer
+ * @pbc: the PBC for the PIO buffer
+ * @from: data source, QWORD aligned
+ * @nbytes: bytes to copy
+ */
+void seg_pio_copy_start(struct pio_buf *pbuf, u64 pbc,
+			const void *from, size_t nbytes)
+{
+	void __iomem *dest = pbuf->start + SOP_DISTANCE;
+	void __iomem *send = dest + PIO_BLOCK_SIZE;
+	void __iomem *dend;			/* 8-byte data end */
+
+	writeq(pbc, dest);
+	dest += sizeof(u64);
+
+	/* calculate where the QWORD data ends - in SOP=1 space */
+	dend = dest + ((nbytes >> 3) * sizeof(u64));
+
+	if (dend < send) {
+		/*
+		 * all QWORD data is within the SOP block, does *not*
+		 * reach the end of the SOP block
+		 */
+
+		while (dest < dend) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+		/*
+		 * No boundary checks are needed here:
+		 * 0. We're not on the SOP block boundary
+		 * 1. The possible DWORD dangle will still be within
+		 *    the SOP block
+		 * 2. We cannot wrap except on a block boundary.
+		 */
+	} else {
+		/* QWORD data extends _to_ or beyond the SOP block */
+
+		/* write 8-byte SOP chunk data */
+		while (dest < send) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+		/* drop out of the SOP range */
+		dest -= SOP_DISTANCE;
+		dend -= SOP_DISTANCE;
+
+		/*
+		 * If the wrap comes before or matches the data end,
+		 * copy until until the wrap, then wrap.
+		 *
+		 * If the data ends at the end of the SOP above and
+		 * the buffer wraps, then pbuf->end == dend == dest
+		 * and nothing will get written, but we will wrap in
+		 * case there is a dangling DWORD.
+		 */
+		if (pbuf->end <= dend) {
+			while (dest < pbuf->end) {
+				writeq(*(u64 *)from, dest);
+				from += sizeof(u64);
+				dest += sizeof(u64);
+			}
+
+			dest -= pbuf->sc->size;
+			dend -= pbuf->sc->size;
+		}
+
+		/* write 8-byte non-SOP, non-wrap chunk data */
+		while (dest < dend) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+	}
+	/* at this point we have wrapped if we are going to wrap */
+
+	/* ...but it doesn't matter as we're done writing */
+
+	/* save dangling bytes, if any */
+	read_low_bytes(pbuf, from, nbytes & 0x7);
+
+	pbuf->qw_written = 1 /*PBC*/ + (nbytes >> 3);
+}
+
+/*
+ * Mid copy helper, "mixed case" - source is 64-bit aligned but carry
+ * bytes are non-zero.
+ *
+ * Whole u64s must be written to the chip, so bytes must be manually merged.
+ *
+ * @pbuf: destination buffer
+ * @from: data source, is QWORD aligned.
+ * @nbytes: bytes to copy
+ *
+ * Must handle nbytes < 8.
+ */
+static void mid_copy_mix(struct pio_buf *pbuf, const void *from, size_t nbytes)
+{
+	void __iomem *dest = pbuf->start + (pbuf->qw_written * sizeof(u64));
+	void __iomem *dend;			/* 8-byte data end */
+	unsigned long qw_to_write = nbytes >> 3;
+	unsigned long bytes_left = nbytes & 0x7;
+
+	/* calculate 8-byte data end */
+	dend = dest + (qw_to_write * sizeof(u64));
+
+	if (pbuf->qw_written < PIO_BLOCK_QWS) {
+		/*
+		 * Still within SOP block.  We don't need to check for
+		 * wrap because we are still in the first block and
+		 * can only wrap on block boundaries.
+		 */
+		void __iomem *send;		/* SOP end */
+		void __iomem *xend;
+
+		/*
+		 * calculate the end of data or end of block, whichever
+		 * comes first
+		 */
+		send = pbuf->start + PIO_BLOCK_SIZE;
+		xend = min(send, dend);
+
+		/* shift up to SOP=1 space */
+		dest += SOP_DISTANCE;
+		xend += SOP_DISTANCE;
+
+		/* write 8-byte chunk data */
+		while (dest < xend) {
+			merge_write8(pbuf, dest, from);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+
+		/* shift down to SOP=0 space */
+		dest -= SOP_DISTANCE;
+	}
+	/*
+	 * At this point dest could be (either, both, or neither):
+	 * - at dend
+	 * - at the wrap
+	 */
+
+	/*
+	 * If the wrap comes before or matches the data end,
+	 * copy until until the wrap, then wrap.
+	 *
+	 * If dest is at the wrap, we will fall into the if,
+	 * not do the loop, when wrap.
+	 *
+	 * If the data ends at the end of the SOP above and
+	 * the buffer wraps, then pbuf->end == dend == dest
+	 * and nothing will get written.
+	 */
+	if (pbuf->end <= dend) {
+		while (dest < pbuf->end) {
+			merge_write8(pbuf, dest, from);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+
+		dest -= pbuf->sc->size;
+		dend -= pbuf->sc->size;
+	}
+
+	/* write 8-byte non-SOP, non-wrap chunk data */
+	while (dest < dend) {
+		merge_write8(pbuf, dest, from);
+		from += sizeof(u64);
+		dest += sizeof(u64);
+	}
+
+	pbuf->qw_written += qw_to_write;
+
+	/* handle carry and left-over bytes */
+	if (pbuf->carry_bytes + bytes_left >= 8) {
+		unsigned long nread;
+
+		/* there is enough to fill another qw - fill carry */
+		nread = 8 - pbuf->carry_bytes;
+		read_extra_bytes(pbuf, from, nread);
+
+		/*
+		 * One more write - but need to make sure dest is correct.
+		 * Check for wrap and the possibility the write
+		 * should be in SOP space.
+		 *
+		 * The two checks immediately below cannot both be true, hence
+		 * the else. If we have wrapped, we cannot still be within the
+		 * first block. Conversely, if we are still in the first block,
+		 * we cannot have wrapped. We do the wrap check first as that
+		 * is more likely.
+		 */
+		/* adjust if we have wrapped */
+		if (dest >= pbuf->end)
+			dest -= pbuf->sc->size;
+		/* jump to the SOP range if within the first block */
+		else if (pbuf->qw_written < PIO_BLOCK_QWS)
+			dest += SOP_DISTANCE;
+
+		/* flush out full carry */
+		carry8_write8(pbuf->carry, dest);
+		pbuf->qw_written++;
+
+		/* now adjust and read the rest of the bytes into carry */
+		bytes_left -= nread;
+		from += nread; /* from is now not aligned */
+		read_low_bytes(pbuf, from, bytes_left);
+	} else {
+		/* not enough to fill another qw, append the rest to carry */
+		read_extra_bytes(pbuf, from, bytes_left);
+	}
+}
+
+/*
+ * Mid copy helper, "straight case" - source pointer is 64-bit aligned
+ * with no carry bytes.
+ *
+ * @pbuf: destination buffer
+ * @from: data source, is QWORD aligned
+ * @nbytes: bytes to copy
+ *
+ * Must handle nbytes < 8.
+ */
+static void mid_copy_straight(struct pio_buf *pbuf,
+			      const void *from, size_t nbytes)
+{
+	void __iomem *dest = pbuf->start + (pbuf->qw_written * sizeof(u64));
+	void __iomem *dend;			/* 8-byte data end */
+
+	/* calculate 8-byte data end */
+	dend = dest + ((nbytes >> 3) * sizeof(u64));
+
+	if (pbuf->qw_written < PIO_BLOCK_QWS) {
+		/*
+		 * Still within SOP block.  We don't need to check for
+		 * wrap because we are still in the first block and
+		 * can only wrap on block boundaries.
+		 */
+		void __iomem *send;		/* SOP end */
+		void __iomem *xend;
+
+		/*
+		 * calculate the end of data or end of block, whichever
+		 * comes first
+		 */
+		send = pbuf->start + PIO_BLOCK_SIZE;
+		xend = min(send, dend);
+
+		/* shift up to SOP=1 space */
+		dest += SOP_DISTANCE;
+		xend += SOP_DISTANCE;
+
+		/* write 8-byte chunk data */
+		while (dest < xend) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+
+		/* shift down to SOP=0 space */
+		dest -= SOP_DISTANCE;
+	}
+	/*
+	 * At this point dest could be (either, both, or neither):
+	 * - at dend
+	 * - at the wrap
+	 */
+
+	/*
+	 * If the wrap comes before or matches the data end,
+	 * copy until until the wrap, then wrap.
+	 *
+	 * If dest is at the wrap, we will fall into the if,
+	 * not do the loop, when wrap.
+	 *
+	 * If the data ends at the end of the SOP above and
+	 * the buffer wraps, then pbuf->end == dend == dest
+	 * and nothing will get written.
+	 */
+	if (pbuf->end <= dend) {
+		while (dest < pbuf->end) {
+			writeq(*(u64 *)from, dest);
+			from += sizeof(u64);
+			dest += sizeof(u64);
+		}
+
+		dest -= pbuf->sc->size;
+		dend -= pbuf->sc->size;
+	}
+
+	/* write 8-byte non-SOP, non-wrap chunk data */
+	while (dest < dend) {
+		writeq(*(u64 *)from, dest);
+		from += sizeof(u64);
+		dest += sizeof(u64);
+	}
+
+	/* we know carry_bytes was zero on entry to this routine */
+	read_low_bytes(pbuf, from, nbytes & 0x7);
+
+	pbuf->qw_written += nbytes >> 3;
+}
+
+/*
+ * Segmented PIO Copy - middle
+ *
+ * Must handle any aligned tail and any aligned source with any byte count.
+ *
+ * @pbuf: a number of blocks allocated within a PIO send context
+ * @from: data source
+ * @nbytes: number of bytes to copy
+ */
+void seg_pio_copy_mid(struct pio_buf *pbuf, const void *from, size_t nbytes)
+{
+	unsigned long from_align = (unsigned long)from & 0x7;
+
+	if (pbuf->carry_bytes + nbytes < 8) {
+		/* not enough bytes to fill a QW */
+		read_extra_bytes(pbuf, from, nbytes);
+		return;
+	}
+
+	if (from_align) {
+		/* misaligned source pointer - align it */
+		unsigned long to_align;
+
+		/* bytes to read to align "from" */
+		to_align = 8 - from_align;
+
+		/*
+		 * In the advance-to-alignment logic below, we do not need
+		 * to check if we are using more than nbytes.  This is because
+		 * if we are here, we already know that carry+nbytes will
+		 * fill at least one QW.
+		 */
+		if (pbuf->carry_bytes + to_align < 8) {
+			/* not enough align bytes to fill a QW */
+			read_extra_bytes(pbuf, from, to_align);
+			from += to_align;
+			nbytes -= to_align;
+		} else {
+			/* bytes to fill carry */
+			unsigned long to_fill = 8 - pbuf->carry_bytes;
+			/* bytes left over to be read */
+			unsigned long extra = to_align - to_fill;
+			void __iomem *dest;
+
+			/* fill carry... */
+			read_extra_bytes(pbuf, from, to_fill);
+			from += to_fill;
+			nbytes -= to_fill;
+			/* may not be enough valid bytes left to align */
+			if (extra > nbytes)
+				extra = nbytes;
+
+			/* ...now write carry */
+			dest = pbuf->start + (pbuf->qw_written * sizeof(u64));
+
+			/*
+			 * The two checks immediately below cannot both be
+			 * true, hence the else.  If we have wrapped, we
+			 * cannot still be within the first block.
+			 * Conversely, if we are still in the first block, we
+			 * cannot have wrapped.  We do the wrap check first
+			 * as that is more likely.
+			 */
+			/* adjust if we've wrapped */
+			if (dest >= pbuf->end)
+				dest -= pbuf->sc->size;
+			/* jump to SOP range if within the first block */
+			else if (pbuf->qw_written < PIO_BLOCK_QWS)
+				dest += SOP_DISTANCE;
+
+			carry8_write8(pbuf->carry, dest);
+			pbuf->qw_written++;
+
+			/* read any extra bytes to do final alignment */
+			/* this will overwrite anything in pbuf->carry */
+			read_low_bytes(pbuf, from, extra);
+			from += extra;
+			nbytes -= extra;
+			/*
+			 * If no bytes are left, return early - we are done.
+			 * NOTE: This short-circuit is *required* because
+			 * "extra" may have been reduced in size and "from"
+			 * is not aligned, as required when leaving this
+			 * if block.
+			 */
+			if (nbytes == 0)
+				return;
+		}
+
+		/* at this point, from is QW aligned */
+	}
+
+	if (pbuf->carry_bytes)
+		mid_copy_mix(pbuf, from, nbytes);
+	else
+		mid_copy_straight(pbuf, from, nbytes);
+}
+
+/*
+ * Segmented PIO Copy - end
+ *
+ * Write any remainder (in pbuf->carry) and finish writing the whole block.
+ *
+ * @pbuf: a number of blocks allocated within a PIO send context
+ */
+void seg_pio_copy_end(struct pio_buf *pbuf)
+{
+	void __iomem *dest = pbuf->start + (pbuf->qw_written * sizeof(u64));
+
+	/*
+	 * The two checks immediately below cannot both be true, hence the
+	 * else.  If we have wrapped, we cannot still be within the first
+	 * block.  Conversely, if we are still in the first block, we
+	 * cannot have wrapped.  We do the wrap check first as that is
+	 * more likely.
+	 */
+	/* adjust if we have wrapped */
+	if (dest >= pbuf->end)
+		dest -= pbuf->sc->size;
+	/* jump to the SOP range if within the first block */
+	else if (pbuf->qw_written < PIO_BLOCK_QWS)
+		dest += SOP_DISTANCE;
+
+	/* write final bytes, if any */
+	if (carry_write8(pbuf, dest)) {
+		dest += sizeof(u64);
+		/*
+		 * NOTE: We do not need to recalculate whether dest needs
+		 * SOP_DISTANCE or not.
+		 *
+		 * If we are in the first block and the dangle write
+		 * keeps us in the same block, dest will need
+		 * to retain SOP_DISTANCE in the loop below.
+		 *
+		 * If we are in the first block and the dangle write pushes
+		 * us to the next block, then loop below will not run
+		 * and dest is not used.  Hence we do not need to update
+		 * it.
+		 *
+		 * If we are past the first block, then SOP_DISTANCE
+		 * was never added, so there is nothing to do.
+		 */
+	}
+
+	/* fill in rest of block */
+	while (((unsigned long)dest & PIO_BLOCK_MASK) != 0) {
+		writeq(0, dest);
+		dest += sizeof(u64);
+	}
+
+	/* finished with this buffer */
+	this_cpu_dec(*pbuf->sc->buffers_allocated);
+	preempt_enable();
+}
diff --git a/drivers/infiniband/hw/hfi2/sdma.c b/drivers/infiniband/hw/hfi2/sdma.c
new file mode 100644
index 000000000000..07268c02de8b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/sdma.c
@@ -0,0 +1,3971 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#include <linux/spinlock.h>
+#include <linux/seqlock.h>
+#include <linux/netdevice.h>
+#include <linux/moduleparam.h>
+#include <linux/bitops.h>
+#include <linux/timer.h>
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
+
+#include "hfi2.h"
+#include "common.h"
+#include "qp.h"
+#include "sdma.h"
+#include "iowait.h"
+#include "trace.h"
+
+/* must be a power of 2 >= 64 <= 32768 */
+#define SDMA_DESCQ_CNT 2048
+#define SDMA_DESC_INTR 64
+#define INVALID_TAIL 0xffff
+#define SDMA_PAD max_t(size_t, MAX_16B_PADDING, sizeof(u32))
+
+static uint sdma_descq_cnt = SDMA_DESCQ_CNT;
+module_param(sdma_descq_cnt, uint, S_IRUGO);
+MODULE_PARM_DESC(sdma_descq_cnt, "Number of SDMA descq entries");
+
+static uint sdma_idle_cnt = 250;
+module_param(sdma_idle_cnt, uint, S_IRUGO);
+MODULE_PARM_DESC(sdma_idle_cnt, "sdma interrupt idle delay (ns,default 250)");
+
+uint mod_num_sdma;
+module_param_named(num_sdma, mod_num_sdma, uint, S_IRUGO);
+MODULE_PARM_DESC(num_sdma, "Set max number SDMA engines to use");
+
+static uint sdma_desct_intr = SDMA_DESC_INTR;
+module_param_named(desct_intr, sdma_desct_intr, uint, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(desct_intr, "Number of SDMA descriptor before interrupt");
+
+static uint enable_jkr_sdma_mem_init = 0;
+module_param(enable_jkr_sdma_mem_init, uint, S_IRUGO);
+MODULE_PARM_DESC(enable_jkr_sdma_mem_init, "Enable JKR SDMA memory write workaround (default 0)");
+
+static uint sdma_single_descriptor;
+module_param(sdma_single_descriptor, uint, S_IRUGO);
+MODULE_PARM_DESC(sdma_single_descriptor, "Enable SDMA single descriptor (default 0)");
+
+static int sdma_threshold = -1;
+module_param(sdma_threshold, int, S_IRUGO);
+MODULE_PARM_DESC(sdma_threshold, "Non-zero will enable SDMA threshold, using this value as the threshold");
+
+static int pad_sdma_desc = -1;
+module_param(pad_sdma_desc, int, S_IRUGO);
+MODULE_PARM_DESC(pad_sdma_desc, "Pad submitted SDMA descriptors to multiple of N, valid values are 0,4,8,16,32");
+
+static int sdma_align = -1;
+module_param(sdma_align, int, S_IRUGO);
+MODULE_PARM_DESC(sdma_align, "Align SDMA descriptor fetch addresses, valid values are 0=none, 1=256-all, 2=256-head-tail, 3=256-tail");
+
+#define JKR_DEFAULT_SDMA_CREDITS_LIMIT 1568
+/*
+ * -1 => module parameter not set during load, use
+ * JKR_DEFAULT_SDMA_CREDITS_LIMIT.
+ *
+ * Use this to distinguish between user intentionally setting
+ * jkr_sdma_credits_limit > 6272/num_sdma and the per-SDMA credit limit
+ * happening to be > 6272/num_sdma because of value of num_sdma.
+ */
+static int jkr_sdma_credits_limit = -1;
+module_param(jkr_sdma_credits_limit, int, S_IRUGO);
+MODULE_PARM_DESC(jkr_sdma_credits_limit, "Limit JKR per-SDMA engine buffer credits. Cannot be greater than 6272/num_sdma. Must be even. 0=no limit. Default 1568");
+
+#define SDMA_WAIT_BATCH_SIZE 20
+/* max wait time for a SDMA engine to indicate it has halted */
+#define SDMA_ERR_HALT_TIMEOUT 10 /* ms */
+/* all SDMA engine errors that cause a halt */
+
+#define SD(name) SEND_DMA_##name
+#define ALL_SDMA_ENG_HALT_ERRS \
+	(SD(ENG_ERR_STATUS_SDMA_WRONG_DW_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_GEN_MISMATCH_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_TOO_LONG_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_TAIL_OUT_OF_BOUNDS_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_FIRST_DESC_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_MEM_READ_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_HALT_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_LENGTH_MISMATCH_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_PACKET_DESC_OVERFLOW_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_HEADER_SELECT_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_HEADER_ADDRESS_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_HEADER_LENGTH_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_TIMEOUT_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_DESC_TABLE_UNC_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_ASSEMBLY_UNC_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_PACKET_TRACKING_UNC_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_HEADER_STORAGE_UNC_ERR_SMASK) \
+	| SD(ENG_ERR_STATUS_SDMA_HEADER_REQUEST_FIFO_UNC_ERR_SMASK))
+
+/* sdma_sendctrl operations */
+#define SDMA_SENDCTRL_OP_ENABLE    BIT(0)
+#define SDMA_SENDCTRL_OP_INTENABLE BIT(1)
+#define SDMA_SENDCTRL_OP_HALT      BIT(2)
+#define SDMA_SENDCTRL_OP_CLEANUP   BIT(3)
+
+/* handle long defines */
+#define SDMA_EGRESS_PACKET_OCCUPANCY_SMASK \
+SEND_EGRESS_SEND_DMA_STATUS_SDMA_EGRESS_PACKET_OCCUPANCY_SMASK
+#define SDMA_EGRESS_PACKET_OCCUPANCY_SHIFT \
+SEND_EGRESS_SEND_DMA_STATUS_SDMA_EGRESS_PACKET_OCCUPANCY_SHIFT
+
+static const char * const sdma_state_names[] = {
+	[sdma_state_s00_hw_down]                = "s00_HwDown",
+	[sdma_state_s10_hw_start_up_halt_wait]  = "s10_HwStartUpHaltWait",
+	[sdma_state_s15_hw_start_up_clean_wait] = "s15_HwStartUpCleanWait",
+	[sdma_state_s20_idle]                   = "s20_Idle",
+	[sdma_state_s30_sw_clean_up_wait]       = "s30_SwCleanUpWait",
+	[sdma_state_s40_hw_clean_up_wait]       = "s40_HwCleanUpWait",
+	[sdma_state_s50_hw_halt_wait]           = "s50_HwHaltWait",
+	[sdma_state_s60_idle_halt_wait]         = "s60_IdleHaltWait",
+	[sdma_state_s80_hw_freeze]		= "s80_HwFreeze",
+	[sdma_state_s82_freeze_sw_clean]	= "s82_FreezeSwClean",
+	[sdma_state_s99_running]                = "s99_Running",
+};
+
+#ifdef CONFIG_SDMA_VERBOSITY
+static const char * const sdma_event_names[] = {
+	[sdma_event_e00_go_hw_down]   = "e00_GoHwDown",
+	[sdma_event_e10_go_hw_start]  = "e10_GoHwStart",
+	[sdma_event_e15_hw_halt_done] = "e15_HwHaltDone",
+	[sdma_event_e25_hw_clean_up_done] = "e25_HwCleanUpDone",
+	[sdma_event_e30_go_running]   = "e30_GoRunning",
+	[sdma_event_e40_sw_cleaned]   = "e40_SwCleaned",
+	[sdma_event_e50_hw_cleaned]   = "e50_HwCleaned",
+	[sdma_event_e60_hw_halted]    = "e60_HwHalted",
+	[sdma_event_e70_go_idle]      = "e70_GoIdle",
+	[sdma_event_e80_hw_freeze]    = "e80_HwFreeze",
+	[sdma_event_e81_hw_frozen]    = "e81_HwFrozen",
+	[sdma_event_e82_hw_unfreeze]  = "e82_HwUnfreeze",
+	[sdma_event_e85_link_down]    = "e85_LinkDown",
+	[sdma_event_e90_sw_halted]    = "e90_SwHalted",
+};
+#endif
+
+static const struct sdma_set_state_action sdma_action_table[] = {
+	[sdma_state_s00_hw_down] = {
+		.go_s99_running_tofalse = 1,
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 0,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s10_hw_start_up_halt_wait] = {
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 1,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s15_hw_start_up_clean_wait] = {
+		.op_enable = 0,
+		.op_intenable = 1,
+		.op_halt = 0,
+		.op_cleanup = 1,
+	},
+	[sdma_state_s20_idle] = {
+		.op_enable = 0,
+		.op_intenable = 1,
+		.op_halt = 0,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s30_sw_clean_up_wait] = {
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 0,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s40_hw_clean_up_wait] = {
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 0,
+		.op_cleanup = 1,
+	},
+	[sdma_state_s50_hw_halt_wait] = {
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 0,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s60_idle_halt_wait] = {
+		.go_s99_running_tofalse = 1,
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 1,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s80_hw_freeze] = {
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 0,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s82_freeze_sw_clean] = {
+		.op_enable = 0,
+		.op_intenable = 0,
+		.op_halt = 0,
+		.op_cleanup = 0,
+	},
+	[sdma_state_s99_running] = {
+		.op_enable = 1,
+		.op_intenable = 1,
+		.op_halt = 0,
+		.op_cleanup = 0,
+		.go_s99_running_totrue = 1,
+	},
+};
+
+#define SDMA_TAIL_UPDATE_THRESH 0x1F
+
+/* declare all statics here rather than keep sorting */
+static void sdma_complete(struct kref *);
+static void sdma_finalput(struct sdma_state *);
+static void sdma_get(struct sdma_state *);
+static void sdma_hw_clean_up_worker(struct work_struct *);
+static void sdma_put(struct sdma_state *);
+static void sdma_set_state(struct sdma_engine *, enum sdma_states);
+static void sdma_start_hw_clean_up(struct sdma_engine *);
+static void sdma_sw_clean_up_worker(struct work_struct *);
+static void sdma_sendctrl(struct sdma_engine *, unsigned);
+static void init_sdma_regs(struct sdma_engine *, u32, uint);
+static void sdma_process_event(
+	struct sdma_engine *sde,
+	enum sdma_events event);
+static void __sdma_process_event(
+	struct sdma_engine *sde,
+	enum sdma_events event);
+static void dump_sdma_state(struct sdma_engine *sde);
+static void sdma_make_progress(struct sdma_engine *sde, u64 status);
+static void sdma_desc_avail(struct sdma_engine *sde, uint avail);
+static void sdma_flush_descq(struct sdma_engine *sde);
+static void sdma_rht_free(void *ptr, void *arg);
+static int prime_sdma_memories(struct hfi2_devdata *dd);
+
+/**
+ * sdma_state_name() - return state string from enum
+ * @state: state
+ */
+static const char *sdma_state_name(enum sdma_states state)
+{
+	return sdma_state_names[state];
+}
+
+static void sdma_get(struct sdma_state *ss)
+{
+	kref_get(&ss->kref);
+}
+
+static void sdma_complete(struct kref *kref)
+{
+	struct sdma_state *ss =
+		container_of(kref, struct sdma_state, kref);
+
+	complete(&ss->comp);
+}
+
+static void sdma_put(struct sdma_state *ss)
+{
+	kref_put(&ss->kref, sdma_complete);
+}
+
+static void sdma_finalput(struct sdma_state *ss)
+{
+	sdma_put(ss);
+	wait_for_completion(&ss->comp);
+}
+
+static inline void write_sde_csr(
+	struct sdma_engine *sde,
+	u32 offset0,
+	u64 value)
+{
+	write_sdma_csr(sde->dd, sde->this_idx, offset0, value);
+}
+
+static inline u64 read_sde_csr(
+	struct sdma_engine *sde,
+	u32 offset0)
+{
+	return read_sdma_csr(sde->dd, sde->this_idx, offset0);
+}
+
+static inline void write_sdecfg_csr(struct sdma_engine *sde, u32 offset,
+				    u64 value)
+{
+	write_sdmacfg_csr(sde->dd, sde->this_idx, offset, value);
+}
+
+static inline u64 read_sdecfg_csr(struct sdma_engine *sde, u32 offset)
+{
+	return read_sdmacfg_csr(sde->dd, sde->this_idx, offset);
+}
+
+static inline void __iomem *get_sdma_csr_addr(const struct hfi2_devdata *dd,
+					      int eng, u32 offset)
+{
+	return get_csr_addr(dd, offset + (dd->params->txe_sdma_stride * eng));
+}
+
+/*
+ * sdma_wait_for_packet_egress() - wait for the Launch FIFO occupancy for
+ * sdma engine 'sde' to drop to 0.
+ */
+static void sdma_wait_for_packet_egress(struct sdma_engine *sde, int pause)
+{
+	u64 off = 8 * sde->this_idx;
+	struct hfi2_devdata *dd = sde->dd;
+	struct hfi2_pportdata *ppd;
+	int lcnt;
+	int pidx;
+	u64 reg_prev;
+	u64 reg;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		ppd = dd->pport + pidx;
+		lcnt = 0;
+		reg = 0;
+
+		while (1) {
+			reg_prev = reg;
+			reg = read_eport_csr(dd, pidx, off +
+					     dd->params->send_egress_send_dma_status_reg);
+
+			reg &= SDMA_EGRESS_PACKET_OCCUPANCY_SMASK;
+			reg >>= SDMA_EGRESS_PACKET_OCCUPANCY_SHIFT;
+			if (reg == 0)
+				break;
+			/* counter is reset if accupancy count changes */
+			if (reg != reg_prev)
+				lcnt = 0;
+			if (lcnt++ > 500) {
+				/* timed out - bounce the link */
+				dd_dev_err(dd, "%s: engine %u timeout waiting for packets to egress, remaining count %u, bouncing link\n",
+					   __func__, sde->this_idx, (u32)reg);
+				queue_work(ppd->link_wq, &ppd->link_bounce_work);
+				break;
+			}
+			udelay(1);
+		}
+	}
+}
+
+/*
+ * sdma_wait() - wait for packet egress to complete for all SDMA engines,
+ * and pause for credit return.
+ */
+void sdma_wait(struct hfi2_devdata *dd)
+{
+	int i;
+
+	for (i = 0; i < dd->num_sdma; i++) {
+		struct sdma_engine *sde = &dd->per_sdma[i];
+
+		sdma_wait_for_packet_egress(sde, 0);
+	}
+}
+
+static inline void sdma_set_desc_cnt(struct sdma_engine *sde, unsigned cnt)
+{
+	u64 reg;
+
+	if (!(sde->dd->flags & HFI2_HAS_SDMA_TIMEOUT))
+		return;
+	reg = cnt;
+	reg &= SD(DESC_CNT_CNT_MASK);
+	reg <<= SD(DESC_CNT_CNT_SHIFT);
+	write_sde_csr(sde, sde->dd->params->send_dma_desc_cnt_reg, reg);
+}
+
+static inline void complete_tx(struct sdma_engine *sde,
+			       struct sdma_txreq *tx,
+			       int res)
+{
+	/* protect against complete modifying */
+	struct iowait *wait = tx->wait;
+	callback_t complete = tx->complete;
+
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+	trace_hfi2_sdma_out_sn(sde, tx->sn);
+	if (WARN_ON_ONCE(sde->head_sn != tx->sn))
+		dd_dev_err(sde->dd, "expected %llu got %llu\n",
+			   sde->head_sn, tx->sn);
+	sde->head_sn++;
+#endif
+	__sdma_txclean(sde->dd, tx);
+	if (complete)
+		(*complete)(tx, res);
+	if (iowait_sdma_dec(wait))
+		iowait_drain_wakeup(wait);
+}
+
+/*
+ * Complete all the sdma requests with a SDMA_TXREQ_S_ABORTED status
+ *
+ * Depending on timing there can be txreqs in two places:
+ * - in the descq ring
+ * - in the flush list
+ *
+ * To avoid ordering issues the descq ring needs to be flushed
+ * first followed by the flush list.
+ *
+ * This routine is called from two places
+ * - From a work queue item
+ * - Directly from the state machine just before setting the
+ *   state to running
+ *
+ * Must be called with head_lock held
+ *
+ */
+static void sdma_flush(struct sdma_engine *sde)
+{
+	struct sdma_txreq *txp, *txp_next;
+	LIST_HEAD(flushlist);
+	unsigned long flags;
+	uint seq;
+
+	/* flush from head to tail */
+	sdma_flush_descq(sde);
+	spin_lock_irqsave(&sde->flushlist_lock, flags);
+	/* copy flush list */
+	list_splice_init(&sde->flushlist, &flushlist);
+	spin_unlock_irqrestore(&sde->flushlist_lock, flags);
+	/* flush from flush list */
+	list_for_each_entry_safe(txp, txp_next, &flushlist, list)
+		complete_tx(sde, txp, SDMA_TXREQ_S_ABORTED);
+	/* wakeup QPs orphaned on the dmawait list */
+	do {
+		struct iowait *w, *nw;
+
+		seq = read_seqbegin(&sde->waitlock);
+		if (!list_empty(&sde->dmawait)) {
+			write_seqlock(&sde->waitlock);
+			list_for_each_entry_safe(w, nw, &sde->dmawait, list) {
+				if (w->wakeup) {
+					w->wakeup(w, SDMA_AVAIL_REASON);
+					list_del_init(&w->list);
+				}
+			}
+			write_sequnlock(&sde->waitlock);
+		}
+	} while (read_seqretry(&sde->waitlock, seq));
+}
+
+/*
+ * Fields a work request for flushing the descq ring
+ * and the flush list
+ *
+ * If the engine has been brought to running during
+ * the scheduling delay, the flush is ignored, assuming
+ * that the process of bringing the engine to running
+ * would have done this flush prior to going to running.
+ *
+ */
+static void sdma_field_flush(struct work_struct *work)
+{
+	unsigned long flags;
+	struct sdma_engine *sde =
+		container_of(work, struct sdma_engine, flush_worker);
+
+	write_seqlock_irqsave(&sde->head_lock, flags);
+	if (!__sdma_running(sde))
+		sdma_flush(sde);
+	write_sequnlock_irqrestore(&sde->head_lock, flags);
+}
+
+static void sdma_err_halt_wait(struct work_struct *work)
+{
+	struct sdma_engine *sde = container_of(work, struct sdma_engine,
+						err_halt_worker);
+	u64 statuscsr;
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(SDMA_ERR_HALT_TIMEOUT);
+	while (1) {
+		statuscsr = read_sde_csr(sde, sde->dd->params->send_dma_status_reg);
+		statuscsr &= SD(STATUS_ENG_HALTED_SMASK);
+		if (statuscsr)
+			break;
+		if (time_after(jiffies, timeout)) {
+			dd_dev_err(sde->dd,
+				   "SDMA engine %d - timeout waiting for engine to halt\n",
+				   sde->this_idx);
+			/*
+			 * Continue anyway.  This could happen if there was
+			 * an uncorrectable error in the wrong spot.
+			 */
+			break;
+		}
+		usleep_range(80, 120);
+	}
+
+	sdma_process_event(sde, sdma_event_e15_hw_halt_done);
+}
+
+static void sdma_err_progress_check_schedule(struct sdma_engine *sde)
+{
+	if (!is_bx(sde->dd) && HFI2_CAP_IS_KSET(SDMA_AHG)) {
+		unsigned index;
+		struct hfi2_devdata *dd = sde->dd;
+
+		for (index = 0; index < dd->num_sdma; index++) {
+			struct sdma_engine *curr_sdma = &dd->per_sdma[index];
+
+			if (curr_sdma != sde)
+				curr_sdma->progress_check_head =
+							curr_sdma->descq_head;
+		}
+		dd_dev_err(sde->dd,
+			   "SDMA engine %d - check scheduled\n",
+				sde->this_idx);
+		mod_timer(&sde->err_progress_check_timer, jiffies + 10);
+	}
+}
+
+static void sdma_err_progress_check(struct timer_list *t)
+{
+	unsigned index;
+	struct sdma_engine *sde = from_timer(sde, t, err_progress_check_timer);
+
+	dd_dev_err(sde->dd, "SDE progress check event\n");
+	for (index = 0; index < sde->dd->num_sdma; index++) {
+		struct sdma_engine *curr_sde = &sde->dd->per_sdma[index];
+		unsigned long flags;
+
+		/* check progress on each engine except the current one */
+		if (curr_sde == sde)
+			continue;
+		/*
+		 * We must lock interrupts when acquiring sde->lock,
+		 * to avoid a deadlock if interrupt triggers and spins on
+		 * the same lock on same CPU
+		 */
+		spin_lock_irqsave(&curr_sde->tail_lock, flags);
+		write_seqlock(&curr_sde->head_lock);
+
+		/* skip non-running queues */
+		if (curr_sde->state.current_state != sdma_state_s99_running) {
+			write_sequnlock(&curr_sde->head_lock);
+			spin_unlock_irqrestore(&curr_sde->tail_lock, flags);
+			continue;
+		}
+
+		if ((curr_sde->descq_head != curr_sde->descq_tail) &&
+		    (curr_sde->descq_head ==
+				curr_sde->progress_check_head))
+			__sdma_process_event(curr_sde,
+					     sdma_event_e90_sw_halted);
+		write_sequnlock(&curr_sde->head_lock);
+		spin_unlock_irqrestore(&curr_sde->tail_lock, flags);
+	}
+	schedule_work(&sde->err_halt_worker);
+}
+
+static void sdma_hw_clean_up_worker(struct work_struct *work)
+{
+	struct sdma_engine *sde = container_of(work, struct sdma_engine,
+					       sdma_hw_clean_up_work);
+	u64 statuscsr;
+	u32 count = 0;
+
+	while (1) {
+#ifdef CONFIG_SDMA_VERBOSITY
+		dd_dev_err(sde->dd, "CONFIG SDMA(%u) %s:%d %s()\n",
+			   sde->this_idx, slashstrip(__FILE__), __LINE__,
+			__func__);
+#endif
+		statuscsr = read_sde_csr(sde, sde->dd->params->send_dma_status_reg);
+		statuscsr &= SD(STATUS_ENG_CLEANED_UP_SMASK);
+		if (statuscsr)
+			break;
+		if (++count > 100) {
+			dd_dev_err(sde->dd,
+				   "SDMA engine %d - timeout waiting for engine to clean\n",
+				   sde->this_idx);
+			break;
+		}
+		udelay(10);
+	}
+
+	sdma_process_event(sde, sdma_event_e25_hw_clean_up_done);
+}
+
+static inline struct sdma_txreq *get_txhead(struct sdma_engine *sde)
+{
+	return sde->tx_ring[sde->tx_head & sde->sdma_mask];
+}
+
+/*
+ * flush ring for recovery
+ */
+static void sdma_flush_descq(struct sdma_engine *sde)
+{
+	u16 head, tail;
+	int progress = 0;
+	struct sdma_txreq *txp = get_txhead(sde);
+
+	/* The reason for some of the complexity of this code is that
+	 * not all descriptors have corresponding txps.  So, we have to
+	 * be able to skip over descs until we wander into the range of
+	 * the next txp on the list.
+	 */
+	head = sde->descq_head & sde->sdma_mask;
+	tail = sde->descq_tail & sde->sdma_mask;
+	while (head != tail) {
+		/* advance head, wrap if needed */
+		head = ++sde->descq_head & sde->sdma_mask;
+		/* if now past this txp's descs, do the callback */
+		if (txp && txp->next_descq_idx == head) {
+			/* remove from list */
+			sde->tx_ring[sde->tx_head++ & sde->sdma_mask] = NULL;
+			complete_tx(sde, txp, SDMA_TXREQ_S_ABORTED);
+			trace_hfi2_sdma_progress(sde, head, tail, txp);
+			txp = get_txhead(sde);
+		}
+		progress++;
+	}
+	if (progress)
+		sdma_desc_avail(sde, sdma_descq_freecnt(sde));
+}
+
+static void sdma_sw_clean_up_worker(struct work_struct *work)
+{
+	struct sdma_engine *sde = container_of(work, struct sdma_engine,
+					       sdma_sw_clean_up_work);
+	unsigned long flags;
+
+	spin_lock_irqsave(&sde->tail_lock, flags);
+	write_seqlock(&sde->head_lock);
+
+	/*
+	 * At this point, the following should always be true:
+	 * - We are halted, so no more descriptors are getting retired.
+	 * - We are not running, so no one is submitting new work.
+	 * - Only we can send the e40_sw_cleaned, so we can't start
+	 *   running again until we say so.  So, the active list and
+	 *   descq are ours to play with.
+	 */
+
+	/*
+	 * In the error clean up sequence, software clean must be called
+	 * before the hardware clean so we can use the hardware head in
+	 * the progress routine.  A hardware clean or SPC unfreeze will
+	 * reset the hardware head.
+	 *
+	 * Process all retired requests. The progress routine will use the
+	 * latest physical hardware head - we are not running so speed does
+	 * not matter.
+	 */
+	sdma_make_progress(sde, 0);
+
+	sdma_flush(sde);
+
+	/*
+	 * Reset our notion of head and tail.
+	 * Note that the HW registers have been reset via an earlier
+	 * clean up.
+	 */
+	sde->descq_tail = 0;
+	sde->descq_head = 0;
+	sde->desc_avail = sdma_descq_freecnt(sde);
+	*sde->head_dma = 0;
+
+	__sdma_process_event(sde, sdma_event_e40_sw_cleaned);
+
+	write_sequnlock(&sde->head_lock);
+	spin_unlock_irqrestore(&sde->tail_lock, flags);
+}
+
+static void sdma_sw_tear_down(struct sdma_engine *sde)
+{
+	struct sdma_state *ss = &sde->state;
+
+	/* Releasing this reference means the state machine has stopped. */
+	sdma_put(ss);
+
+	/* stop waiting for all unfreeze events to complete */
+	atomic_set(&sde->dd->sdma_unfreeze_count, -1);
+	wake_up_interruptible(&sde->dd->sdma_unfreeze_wq);
+}
+
+static void sdma_start_hw_clean_up(struct sdma_engine *sde)
+{
+	queue_work(sde->dd->hfi2_wq, &sde->sdma_hw_clean_up_work);
+}
+
+static void sdma_set_state(struct sdma_engine *sde,
+			   enum sdma_states next_state)
+{
+	struct sdma_state *ss = &sde->state;
+	const struct sdma_set_state_action *action = sdma_action_table;
+	unsigned op = 0;
+
+	trace_hfi2_sdma_state(
+		sde,
+		sdma_state_names[ss->current_state],
+		sdma_state_names[next_state]);
+
+	/* debugging bookkeeping */
+	ss->previous_state = ss->current_state;
+	ss->previous_op = ss->current_op;
+	ss->current_state = next_state;
+
+	if (ss->previous_state != sdma_state_s99_running &&
+	    next_state == sdma_state_s99_running)
+		sdma_flush(sde);
+
+	if (action[next_state].op_enable)
+		op |= SDMA_SENDCTRL_OP_ENABLE;
+
+	if (action[next_state].op_intenable)
+		op |= SDMA_SENDCTRL_OP_INTENABLE;
+
+	if (action[next_state].op_halt)
+		op |= SDMA_SENDCTRL_OP_HALT;
+
+	if (action[next_state].op_cleanup)
+		op |= SDMA_SENDCTRL_OP_CLEANUP;
+
+	if (action[next_state].go_s99_running_tofalse)
+		ss->go_s99_running = 0;
+
+	if (action[next_state].go_s99_running_totrue)
+		ss->go_s99_running = 1;
+
+	ss->current_op = op;
+	sdma_sendctrl(sde, ss->current_op);
+}
+
+/**
+ * sdma_get_descq_cnt() - called when device probed
+ *
+ * Return a validated descq count.
+ *
+ * This is currently only used in the verbs initialization to build the tx
+ * list.
+ *
+ * This will probably be deleted in favor of a more scalable approach to
+ * alloc tx's.
+ *
+ */
+u16 sdma_get_descq_cnt(void)
+{
+	u16 count = sdma_descq_cnt;
+
+	if (!count)
+		return SDMA_DESCQ_CNT;
+	/* count must be a power of 2 greater than 64 and less than
+	 * 32768.   Otherwise return default.
+	 */
+	if (!is_power_of_2(count))
+		return SDMA_DESCQ_CNT;
+	if (count < 64 || count > 32768)
+		return SDMA_DESCQ_CNT;
+	return count;
+}
+
+/**
+ * sdma_engine_get_vl() - return vl for a given sdma engine
+ * @ppd: port structure
+ * @sde: sdma engine
+ *
+ * This function returns the vl mapped to a given engine, or an error if
+ * the mapping can't be found. The mapping fields are protected by RCU.
+ */
+int sdma_engine_get_vl(struct hfi2_pportdata *ppd, struct sdma_engine *sde)
+{
+	struct sdma_vl_map *m;
+	u8 vl;
+
+	if (sde->this_idx >= TXE_NUM_SDMA_ENGINES)
+		return -EINVAL;
+
+	rcu_read_lock();
+	m = rcu_dereference(ppd->sdma_map);
+	if (unlikely(!m)) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	vl = m->engine_to_vl[sde->this_idx];
+	rcu_read_unlock();
+
+	return vl;
+}
+
+/**
+ * sdma_select_engine_vl() - select sdma engine
+ * @ppd: port structure
+ * @selector: a spreading factor
+ * @vl: this vl
+ *
+ * This function returns an engine based on the selector and a vl.  The
+ * mapping fields are protected by RCU.
+ */
+struct sdma_engine *sdma_select_engine_vl(struct hfi2_pportdata *ppd,
+					  u32 selector, u8 vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct sdma_vl_map *m;
+	struct sdma_map_elem *e;
+	struct sdma_engine *rval;
+
+	/* NOTE This should only happen if SC->VL changed after the initial
+	 *      checks on the QP/AH
+	 *      Default will return engine 0 below
+	 */
+	if (vl >= num_vls) {
+		rval = NULL;
+		goto done;
+	}
+
+	rcu_read_lock();
+	m = rcu_dereference(ppd->sdma_map);
+	if (unlikely(!m)) {
+		rcu_read_unlock();
+		return &dd->per_sdma[0];
+	}
+	e = m->map[vl & m->mask];
+	rval = e->sde[selector & e->mask];
+	rcu_read_unlock();
+
+done:
+	rval =  !rval ? &dd->per_sdma[0] : rval;
+	trace_hfi2_sdma_engine_select(dd, selector, vl, rval->this_idx);
+	return rval;
+}
+
+/**
+ * sdma_select_engine_sc() - select sdma engine
+ * @ppd: port structure
+ * @selector: a spreading factor
+ * @sc5: the 5 bit sc
+ *
+ * This function returns an engine based on the selector and an sc.
+ */
+struct sdma_engine *sdma_select_engine_sc(struct hfi2_pportdata *ppd,
+					  u32 selector, u8 sc5)
+{
+	u8 vl = sc_to_vlt(ppd, sc5);
+
+	return sdma_select_engine_vl(ppd, selector, vl);
+}
+
+struct sdma_rht_map_elem {
+	u32 mask;
+	u8 ctr;
+	struct sdma_engine *sde[TXE_NUM_SDMA_ENGINES];
+};
+
+struct sdma_rht_node {
+	unsigned long cpu_id;
+	struct sdma_rht_map_elem *port_map[LARGEST_NUM_PORTS][HFI2_MAX_VLS_SUPPORTED];
+	struct rhash_head node;
+};
+
+#define NR_CPUS_HINT 192
+
+static const struct rhashtable_params sdma_rht_params = {
+	.nelem_hint = NR_CPUS_HINT,
+	.head_offset = offsetof(struct sdma_rht_node, node),
+	.key_offset = offsetof(struct sdma_rht_node, cpu_id),
+	.key_len = sizeof_field(struct sdma_rht_node, cpu_id),
+	.max_size = NR_CPUS,
+	.min_size = 8,
+	.automatic_shrinking = true,
+};
+
+/*
+ * sdma_select_user_engine() - select sdma engine based on user setup
+ * @ppd: port structure
+ * @selector: a spreading factor
+ * @vl: this vl
+ *
+ * This function returns an sdma engine for a user sdma request.
+ * User defined sdma engine affinity setting is honored when applicable,
+ * otherwise system default sdma engine mapping is used. To ensure correct
+ * ordering, the mapping from <selector, vl> to sde must remain unchanged.
+ */
+struct sdma_engine *sdma_select_user_engine(struct hfi2_pportdata *ppd,
+					    u32 selector, u8 vl)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	struct sdma_rht_node *rht_node;
+	struct sdma_rht_map_elem *map;
+	struct sdma_engine *sde = NULL;
+	unsigned long cpu_id;
+
+	/*
+	 * To ensure that always the same sdma engine(s) will be
+	 * selected make sure the process is pinned to this CPU only.
+	 */
+	if (current->nr_cpus_allowed != 1)
+		goto out;
+
+	rcu_read_lock();
+	cpu_id = smp_processor_id();
+	rht_node = rhashtable_lookup(dd->sdma_rht, &cpu_id,
+				     sdma_rht_params);
+
+	if (!rht_node)
+		goto unlock;
+	map = rht_node->port_map[ppd->hw_pidx][vl];
+	if (!map)
+		goto unlock;
+	sde = map->sde[selector & map->mask];
+unlock:
+	rcu_read_unlock();
+
+	if (sde)
+		return sde;
+
+out:
+	return sdma_select_engine_vl(ppd, selector, vl);
+}
+
+static void sdma_populate_sde_map(struct sdma_rht_map_elem *map)
+{
+	int i;
+
+	for (i = 0; i < roundup_pow_of_two(map->ctr ? : 1) - map->ctr; i++)
+		map->sde[map->ctr + i] = map->sde[i];
+}
+
+static void sdma_cleanup_sde_map(struct sdma_rht_map_elem *map,
+				 struct sdma_engine *sde)
+{
+	unsigned int i, pow;
+
+	/* only need to check the first ctr entries for a match */
+	for (i = 0; i < map->ctr; i++) {
+		if (map->sde[i] == sde) {
+			memmove(&map->sde[i], &map->sde[i + 1],
+				(map->ctr - i - 1) * sizeof(map->sde[0]));
+			map->ctr--;
+			pow = roundup_pow_of_two(map->ctr ? : 1);
+			map->mask = pow - 1;
+			sdma_populate_sde_map(map);
+			break;
+		}
+	}
+}
+
+/*
+ * Prevents concurrent reads and writes of the sdma engine cpu_mask
+ */
+static DEFINE_MUTEX(process_to_sde_mutex);
+
+ssize_t sdma_set_cpu_to_sde_map(struct sdma_engine *sde, const char *buf,
+				size_t count)
+{
+	struct hfi2_devdata *dd = sde->dd;
+	cpumask_var_t mask, new_mask;
+	unsigned long cpu;
+	int ret, vl, sz;
+	int pidx;
+	struct sdma_rht_node *rht_node;
+
+	ret = zalloc_cpumask_var(&mask, GFP_KERNEL);
+	if (!ret)
+		return -ENOMEM;
+
+	ret = zalloc_cpumask_var(&new_mask, GFP_KERNEL);
+	if (!ret) {
+		free_cpumask_var(mask);
+		return -ENOMEM;
+	}
+	ret = cpulist_parse(buf, mask);
+	if (ret)
+		goto out_free;
+
+	if (!cpumask_subset(mask, cpu_online_mask)) {
+		dd_dev_warn(sde->dd, "Invalid CPU mask\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	sz = sizeof(struct sdma_rht_map_elem);
+
+	mutex_lock(&process_to_sde_mutex);
+
+	for_each_cpu(cpu, mask) {
+		struct sdma_rht_map_elem *elem;
+		bool do_insert;
+
+		/* Check if we have this already mapped */
+		if (cpumask_test_cpu(cpu, &sde->cpu_mask)) {
+			cpumask_set_cpu(cpu, new_mask);
+			continue;
+		}
+
+		rht_node = rhashtable_lookup_fast(dd->sdma_rht, &cpu,
+						  sdma_rht_params);
+
+		do_insert = false;
+		if (!rht_node) {
+			rht_node = kzalloc(sizeof(*rht_node), GFP_KERNEL);
+			if (!rht_node) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			rht_node->cpu_id = cpu;
+			/* insert later to allow free if there is an error */
+			do_insert = true;
+		}
+
+		for (pidx = 0; pidx < dd->num_pports; pidx++) {
+			vl = sdma_engine_get_vl(&dd->pport[pidx], sde);
+			if (unlikely(vl < 0 || vl >= HFI2_MAX_VLS_SUPPORTED)) {
+				ret = -EINVAL;
+				goto fail_new;
+			}
+
+			elem = rht_node->port_map[pidx][vl];
+			if (!elem) {
+				elem = kzalloc(sz, GFP_KERNEL);
+				if (!elem) {
+					ret = -ENOMEM;
+					goto fail_new;
+				}
+				rht_node->port_map[pidx][vl] = elem;
+			}
+
+			elem->sde[elem->ctr++] = sde;
+			elem->mask = roundup_pow_of_two(elem->ctr) - 1;
+
+			/* Populate the sde map table */
+			sdma_populate_sde_map(elem);
+		}
+
+		if (do_insert) {
+			ret = rhashtable_insert_fast(dd->sdma_rht,
+						     &rht_node->node,
+						     sdma_rht_params);
+		}
+		if (ret) {
+fail_new:
+			/* completely free node if not inserted yet */
+			if (do_insert)
+				sdma_rht_free(rht_node, dd);
+			dd_dev_err(sde->dd, "Failed to set process to sde affinity for cpu %lu\n",
+				   cpu);
+			goto out;
+		}
+
+		cpumask_set_cpu(cpu, new_mask);
+	}
+
+	/* Clean up old mappings */
+	for_each_cpu(cpu, cpu_online_mask) {
+		struct sdma_rht_node *rht_node;
+		bool empty = true;
+
+		/* Don't cleanup sdes that are set in the new mask */
+		if (cpumask_test_cpu(cpu, mask))
+			continue;
+
+		rht_node = rhashtable_lookup_fast(dd->sdma_rht, &cpu,
+						  sdma_rht_params);
+		if (!rht_node)
+			continue;
+
+		for (pidx = 0; pidx < dd->num_pports; pidx++) {
+			int i;
+
+			/* Remove mappings for old sde */
+			for (i = 0; i < HFI2_MAX_VLS_SUPPORTED; i++)
+				if (rht_node->port_map[pidx][i])
+					sdma_cleanup_sde_map(rht_node->port_map[pidx][i],
+							     sde);
+
+			/* check for populated entries */
+			for (i = 0; i < HFI2_MAX_VLS_SUPPORTED; i++) {
+				if (!rht_node->port_map[pidx][i])
+					continue;
+
+				if (rht_node->port_map[pidx][i]->ctr) {
+					empty = false;
+					break;
+				}
+			}
+		}
+
+		if (empty) {
+			ret = rhashtable_remove_fast(dd->sdma_rht,
+						     &rht_node->node,
+						     sdma_rht_params);
+			WARN_ON(ret);
+			if (!ret)
+				sdma_rht_free(rht_node, dd);
+		}
+	}
+
+	cpumask_copy(&sde->cpu_mask, new_mask);
+out:
+	mutex_unlock(&process_to_sde_mutex);
+out_free:
+	free_cpumask_var(mask);
+	free_cpumask_var(new_mask);
+	return ret ? : strnlen(buf, PAGE_SIZE);
+}
+
+ssize_t sdma_get_cpu_to_sde_map(struct sdma_engine *sde, char *buf)
+{
+	mutex_lock(&process_to_sde_mutex);
+	if (cpumask_empty(&sde->cpu_mask))
+		snprintf(buf, PAGE_SIZE, "%s\n", "empty");
+	else
+		cpumap_print_to_pagebuf(true, buf, &sde->cpu_mask);
+	mutex_unlock(&process_to_sde_mutex);
+	return strnlen(buf, PAGE_SIZE);
+}
+
+static void sdma_rht_free(void *ptr, void *arg)
+{
+	struct sdma_rht_node *rht_node = ptr;
+	struct hfi2_devdata *dd = arg;
+	int pidx;
+	int i;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		for (i = 0; i < HFI2_MAX_VLS_SUPPORTED; i++)
+			kfree(rht_node->port_map[pidx][i]);
+	}
+	kfree(rht_node);
+}
+
+/**
+ * sdma_seqfile_dump_cpu_list() - debugfs dump the cpu to sdma mappings
+ * @s: seq file
+ * @dd: hfi2_devdata
+ * @cpuid: cpu id
+ *
+ * This routine dumps the process to sde mappings per cpu
+ */
+void sdma_seqfile_dump_cpu_list(struct seq_file *s,
+				struct hfi2_devdata *dd,
+				unsigned long cpuid)
+{
+	struct sdma_rht_node *rht_node;
+	int i, j;
+	int pidx;
+
+	rht_node = rhashtable_lookup_fast(dd->sdma_rht, &cpuid,
+					  sdma_rht_params);
+	if (!rht_node)
+		return;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		if (pidx == 0)
+			seq_printf(s, "cpu%3lu: ", cpuid);
+		else
+			seq_puts(s, "        ");
+		seq_printf(s, "pidx %d: ", pidx);
+
+		for (i = 0; i < HFI2_MAX_VLS_SUPPORTED; i++) {
+			if (!rht_node->port_map[pidx][i] || !rht_node->port_map[pidx][i]->ctr)
+				continue;
+
+			seq_printf(s, " vl%d: [", i);
+
+			for (j = 0; j < rht_node->port_map[pidx][i]->ctr; j++) {
+				if (!rht_node->port_map[pidx][i]->sde[j])
+					continue;
+
+				if (j > 0)
+					seq_puts(s, ",");
+
+				seq_printf(s, " sdma%2d",
+					   rht_node->port_map[pidx][i]->sde[j]->this_idx);
+			}
+			seq_puts(s, " ]");
+		}
+
+		seq_puts(s, "\n");
+	}
+}
+
+/*
+ * Free the indicated map struct
+ */
+static void sdma_map_free(struct sdma_vl_map *m)
+{
+	int i;
+
+	for (i = 0; m && i < m->actual_vls; i++)
+		kfree(m->map[i]);
+	kfree(m);
+}
+
+/*
+ * Handle RCU callback
+ */
+static void sdma_map_rcu_callback(struct rcu_head *list)
+{
+	struct sdma_vl_map *m = container_of(list, struct sdma_vl_map, list);
+
+	sdma_map_free(m);
+}
+
+/**
+ * sdma_map_init - called when # vls change
+ * @ppd: port structure
+ * @num_vls: number of vls
+ * @vl_engines: per vl engine mapping (optional)
+ *
+ * This routine changes the mapping of VL to SDMA engine.
+ *
+ * vl_engines is used to specify a non-uniform vl/engine loading. NULL
+ * implies auto computing the loading and giving each VLs a uniform
+ * distribution of engines per VL.
+ *
+ * The auto algorithm computes the sde_per_vl and the number of extra
+ * engines.  Any extra engines are added from the last VL on down.
+ *
+ * rcu locking is used here to control access to the mapping fields.
+ *
+ * If either the num_vls or num_sdma are non-power of 2, the array sizes
+ * in the struct sdma_vl_map and the struct sdma_map_elem are rounded
+ * up to the next highest power of 2 and the first entry is reused
+ * in a round robin fashion.
+ *
+ * If an error occurs the map change is not done and the mapping is
+ * not changed.
+ */
+int sdma_map_init(struct hfi2_pportdata *ppd, u8 num_vls, u8 *vl_engines)
+{
+	struct hfi2_devdata *dd = ppd->dd;
+	int i, j;
+	int extra, sde_per_vl;
+	int engine = 0;
+	u8 lvl_engines[OPA_MAX_VLS];
+	struct sdma_vl_map *oldmap, *newmap;
+
+	if (!(dd->flags & HFI2_HAS_SEND_DMA))
+		return 0;
+
+	if (!vl_engines) {
+		/* truncate divide */
+		sde_per_vl = dd->num_sdma / num_vls;
+		/* extras */
+		extra = dd->num_sdma % num_vls;
+		vl_engines = lvl_engines;
+		/* add extras from last vl down */
+		for (i = num_vls - 1; i >= 0; i--, extra--)
+			vl_engines[i] = sde_per_vl + (extra > 0 ? 1 : 0);
+	}
+	/* build new map */
+	newmap = kzalloc(sizeof(struct sdma_vl_map) +
+				roundup_pow_of_two(num_vls) *
+				sizeof(struct sdma_map_elem *),
+			 GFP_KERNEL);
+	if (!newmap)
+		goto bail;
+	newmap->actual_vls = num_vls;
+	newmap->vls = roundup_pow_of_two(num_vls);
+	newmap->mask = (1 << ilog2(newmap->vls)) - 1;
+	/* initialize back-map */
+	for (i = 0; i < TXE_NUM_SDMA_ENGINES; i++)
+		newmap->engine_to_vl[i] = -1;
+	for (i = 0; i < newmap->vls; i++) {
+		/* save for wrap around */
+		int first_engine = engine;
+
+		if (i < newmap->actual_vls) {
+			int sz = roundup_pow_of_two(vl_engines[i]);
+
+			/* only allocate once */
+			newmap->map[i] = kzalloc(
+				sizeof(struct sdma_map_elem) +
+					sz * sizeof(struct sdma_engine *),
+				GFP_KERNEL);
+			if (!newmap->map[i])
+				goto bail;
+			newmap->map[i]->mask = (1 << ilog2(sz)) - 1;
+			/* assign engines */
+			for (j = 0; j < sz; j++) {
+				newmap->map[i]->sde[j] =
+					&dd->per_sdma[engine];
+				if (++engine >= first_engine + vl_engines[i])
+					/* wrap back to first engine */
+					engine = first_engine;
+			}
+			/* assign back-map */
+			for (j = 0; j < vl_engines[i]; j++)
+				newmap->engine_to_vl[first_engine + j] = i;
+		} else {
+			/* just re-use entry without allocating */
+			newmap->map[i] = newmap->map[i % num_vls];
+		}
+		engine = first_engine + vl_engines[i];
+	}
+	/* newmap in hand, save old map */
+	spin_lock_irq(&dd->sde_map_lock);
+	oldmap = rcu_dereference_protected(ppd->sdma_map,
+					   lockdep_is_held(&dd->sde_map_lock));
+
+	/* publish newmap */
+	rcu_assign_pointer(ppd->sdma_map, newmap);
+
+	spin_unlock_irq(&dd->sde_map_lock);
+	/* success, free any old map after grace period */
+	if (oldmap)
+		call_rcu(&oldmap->list, sdma_map_rcu_callback);
+	return 0;
+bail:
+	/* free any partial allocation */
+	sdma_map_free(newmap);
+	return -ENOMEM;
+}
+
+/**
+ * sdma_clean - Clean up allocated memory
+ * @dd:          struct hfi2_devdata
+ * @num_engines: num sdma engines
+ *
+ * This routine can be called regardless of the success of
+ * sdma_init()
+ */
+void sdma_clean(struct hfi2_devdata *dd, size_t num_engines)
+{
+	size_t i;
+	struct sdma_engine *sde;
+	int pidx;
+
+	if (dd->sdma_pad_dma) {
+		dma_free_coherent(&dd->pcidev->dev, SDMA_PAD,
+				  (void *)dd->sdma_pad_dma,
+				  dd->sdma_pad_phys);
+		dd->sdma_pad_dma = NULL;
+		dd->sdma_pad_phys = 0;
+	}
+	if (dd->sdma_heads_dma) {
+		dma_free_coherent(&dd->pcidev->dev, dd->sdma_heads_size,
+				  (void *)dd->sdma_heads_dma,
+				  dd->sdma_heads_phys);
+		dd->sdma_heads_dma = NULL;
+		dd->sdma_heads_phys = 0;
+	}
+	for (i = 0; dd->per_sdma && i < num_engines; ++i) {
+		sde = &dd->per_sdma[i];
+
+		sde->head_dma = NULL;
+		sde->head_phys = 0;
+
+		if (sde->descq) {
+			dma_free_coherent(
+				&dd->pcidev->dev,
+				sde->descq_cnt * sizeof(u64[2]),
+				sde->descq,
+				sde->descq_phys
+			);
+			sde->descq = NULL;
+			sde->descq_phys = 0;
+		}
+		kvfree(sde->tx_ring);
+		sde->tx_ring = NULL;
+	}
+	kfree(dd->per_sdma);
+	dd->per_sdma = NULL;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		struct hfi2_pportdata *ppd = dd->pport + pidx;
+
+		if (rcu_access_pointer(ppd->sdma_map)) {
+			spin_lock_irq(&dd->sde_map_lock);
+			sdma_map_free(rcu_access_pointer(ppd->sdma_map));
+			RCU_INIT_POINTER(ppd->sdma_map, NULL);
+			spin_unlock_irq(&dd->sde_map_lock);
+			synchronize_rcu();
+		}
+	}
+
+	if (dd->sdma_rht) {
+		rhashtable_free_and_destroy(dd->sdma_rht, sdma_rht_free, dd);
+		kfree(dd->sdma_rht);
+		dd->sdma_rht = NULL;
+	}
+}
+
+static u32 sdma_per_engine_credits(struct hfi2_devdata *dd,
+				   u32 num_engines)
+{
+	u32 per_sdma_credits =
+		chip_sdma_mem_size(dd) / (num_engines * SDMA_BLOCK_SIZE);
+	u32 limit = jkr_sdma_credits_limit < 0 ?
+		JKR_DEFAULT_SDMA_CREDITS_LIMIT :
+		jkr_sdma_credits_limit;
+
+	if (dd->params->chip_type != CHIP_JKR || !jkr_sdma_credits_limit)
+		goto rounddown;
+
+	if (limit > per_sdma_credits) {
+		/*
+		 * Only warn user if they actually set jkr_sdma_credits_limit,
+		 * not if jkr_sdma_credits_limit > per_sdma_credits because of
+		 * num_sdma.
+		 */
+		if (jkr_sdma_credits_limit > 0)
+			dd_dev_info(dd, "Ignoring jkr_sdma_credits_limit (%u) > per_sdma_credits (%u)\n",
+				    limit, per_sdma_credits);
+	} else if (limit < 2) {
+		/* Min 2 to make sure JKR doesn't round down to 0 */
+		dd_dev_info(dd, "Ignoring jkr_sdma_credits_limit %u < 2\n",
+			    limit);
+	} else {
+		u32 was = per_sdma_credits;
+
+		per_sdma_credits = limit & ~1;
+		dd_dev_info(dd, "Setting per_sdma_credits to %u (was %u) from jkr_sdma_credits_limit module param\n",
+			    per_sdma_credits, was);
+	}
+rounddown:
+	/* non-WFR hardware requires an even number of credits */
+	if (dd->params->chip_type != CHIP_WFR && (per_sdma_credits & 1))
+		per_sdma_credits &= ~1;
+
+	return per_sdma_credits;
+}
+
+/* no-op SDMA descriptor */
+static struct hw_sdma_desc sdma_pad;
+
+/**
+ * sdma_init() - called when device probed
+ * @dd: hfi2_devdata
+ *
+ * Initializes each sde and its csrs.
+ * Interrupts are not required to be enabled.
+ *
+ * Returns:
+ * 0 - success, -errno on failure
+ */
+int sdma_init(struct hfi2_devdata *dd)
+{
+	unsigned int this_idx;
+	unsigned int start_bit;
+	struct sdma_engine *sde;
+	struct rhashtable *tmp_sdma_rht;
+	u16 descq_cnt;
+	void *curr_head;
+	struct hfi2_pportdata *ppd;
+	u32 per_sdma_credits;
+	u32 chip_engines;
+	uint idle_cnt = sdma_idle_cnt;
+	size_t num_engines = dd->num_sdma;
+	int ret = -ENOMEM;
+	int pidx;
+
+	if (prime_sdma_memories(dd))
+		return -EIO;
+
+	if (num_engines == 0)
+		return 0;
+
+	dd_dev_info(dd, "SDMA mod_num_sdma: %u\n", mod_num_sdma);
+	dd_dev_info(dd, "SDMA chip_sdma_engines: %u\n", chip_sdma_engines(dd));
+	dd_dev_info(dd, "SDMA chip_sdma_mem_size: %u\n",
+		    chip_sdma_mem_size(dd));
+
+	dd->sdma_threshold = sdma_threshold;
+	dd->pad_sdma_desc = pad_sdma_desc;
+	dd->sdma_align = sdma_align;
+	/* fill in defaults if parameter not specified */
+	if (dd->params->chip_type == CHIP_JKR) {
+		bool amd = boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
+
+		if (amd) {
+			if (dd->sdma_threshold == -1)
+				dd->sdma_threshold = 32;
+			if (dd->pad_sdma_desc == -1)
+				dd->pad_sdma_desc = 32;
+			if (dd->sdma_align == -1)
+				dd->sdma_align = ALIGN_256_HEAD_TAIL;
+		} else {
+			if (dd->sdma_threshold == -1)
+				dd->sdma_threshold = 0;
+			if (dd->pad_sdma_desc == -1)
+				dd->pad_sdma_desc = 0;
+			if (dd->sdma_align == -1)
+				dd->sdma_align = ALIGN_NONE;
+		}
+	} else {
+		if (dd->sdma_threshold == -1)
+			dd->sdma_threshold = 0;
+		if (dd->pad_sdma_desc == -1)
+			dd->pad_sdma_desc = 0;
+		if (dd->sdma_align == -1)
+			dd->sdma_align = ALIGN_NONE;
+	}
+	/* sanity check parameters */
+	switch (dd->pad_sdma_desc) {
+	case 0: case 4: case 8: case 16: case 32:
+		break;
+	default:
+		dd_dev_err(dd, "Invalid pad_sdma_desc parameter %d, setting to zero\n",
+			   dd->pad_sdma_desc);
+		dd->pad_sdma_desc = 0;
+		break;
+	}
+	switch (dd->sdma_align) {
+	case ALIGN_NONE:
+	case ALIGN_256_ALL:
+	case ALIGN_256_HEAD_TAIL:
+	case ALIGN_256_TAIL:
+		break;
+	default:
+		dd_dev_err(dd, "Invalid sdma_align parameter %d, setting to %d\n",
+			   dd->sdma_align, ALIGN_256_HEAD_TAIL);
+		dd->sdma_align = ALIGN_256_HEAD_TAIL;
+		break;
+	}
+	dd_dev_info(dd, "SDMA threshold,pad,align: %d,%d,%d\n",
+		    dd->sdma_threshold, dd->pad_sdma_desc,
+		    dd->sdma_align);
+
+	per_sdma_credits = sdma_per_engine_credits(dd, num_engines);
+
+	/* set up freeze waitqueue */
+	init_waitqueue_head(&dd->sdma_unfreeze_wq);
+	atomic_set(&dd->sdma_unfreeze_count, 0);
+
+	atomic_set(&dd->sdma_print_tag, 0);
+	descq_cnt = sdma_get_descq_cnt();
+	dd_dev_info(dd, "SDMA engines %zu descq_cnt %u\n",
+		    num_engines, descq_cnt);
+
+	/* alloc memory for array of send engines */
+	dd->per_sdma = kcalloc_node(num_engines, sizeof(*dd->per_sdma),
+				    GFP_KERNEL, dd->node);
+	if (!dd->per_sdma)
+		return ret;
+
+	idle_cnt = ns_to_cclock(dd, idle_cnt);
+	if (idle_cnt)
+		dd->default_desc1 =
+			SDMA_DESC1_HEAD_TO_HOST_FLAG;
+	else
+		dd->default_desc1 =
+			SDMA_DESC1_INT_REQ_FLAG;
+
+	if (!sdma_desct_intr)
+		sdma_desct_intr = SDMA_DESC_INTR;
+
+	/*
+	 * The driver is coded to assume that all masks fit in a single
+	 * 64-bit interrupt source vector entry.  Enforce that here.
+	 */
+	start_bit = dd->params->is_sdma_start % 64;
+	if (start_bit + (3 * TXE_NUM_SDMA_ENGINES) > 64) {
+		dd_dev_err(dd, "invalid SDMA interrupt masks\n");
+		return -EINVAL;
+	}
+
+	/* Allocate memory for SendDMA descriptor FIFOs */
+	for (this_idx = 0; this_idx < num_engines; ++this_idx) {
+		sde = &dd->per_sdma[this_idx];
+		sde->dd = dd;
+		sde->this_idx = this_idx;
+		sde->descq_cnt = descq_cnt;
+		sde->desc_avail = sdma_descq_freecnt(sde);
+		sde->sdma_shift = ilog2(descq_cnt);
+		sde->sdma_mask = (1 << sde->sdma_shift) - 1;
+
+		/* Create a mask specifically for each interrupt source */
+		sde->int_mask = (u64)1 << (0 * TXE_NUM_SDMA_ENGINES +
+					   this_idx + start_bit);
+		sde->progress_mask = (u64)1 << (1 * TXE_NUM_SDMA_ENGINES +
+						this_idx + start_bit);
+		sde->idle_mask = (u64)1 << (2 * TXE_NUM_SDMA_ENGINES +
+					    this_idx + start_bit);
+		/* Create a combined mask to cover all 3 interrupt sources */
+		sde->imask = sde->int_mask | sde->progress_mask |
+			     sde->idle_mask;
+
+		spin_lock_init(&sde->tail_lock);
+		seqlock_init(&sde->head_lock);
+		spin_lock_init(&sde->senddmactrl_lock);
+		spin_lock_init(&sde->flushlist_lock);
+		seqlock_init(&sde->waitlock);
+		/* insure there is always a zero bit */
+		sde->ahg_bits = 0xfffffffe00000000ULL;
+
+		sdma_set_state(sde, sdma_state_s00_hw_down);
+
+		/* set up reference counting */
+		kref_init(&sde->state.kref);
+		init_completion(&sde->state.comp);
+
+		INIT_LIST_HEAD(&sde->flushlist);
+		INIT_LIST_HEAD(&sde->dmawait);
+
+		sde->tail_csr =
+			get_sdma_csr_addr(dd, this_idx, dd->params->send_dma_tail_reg);
+
+		INIT_WORK(&sde->sdma_hw_clean_up_work, sdma_hw_clean_up_worker);
+		INIT_WORK(&sde->sdma_sw_clean_up_work, sdma_sw_clean_up_worker);
+		INIT_WORK(&sde->err_halt_worker, sdma_err_halt_wait);
+		INIT_WORK(&sde->flush_worker, sdma_field_flush);
+
+		sde->progress_check_head = 0;
+
+		timer_setup(&sde->err_progress_check_timer,
+			    sdma_err_progress_check, 0);
+
+		sde->descq = dma_alloc_coherent(&dd->pcidev->dev,
+						descq_cnt * sizeof(u64[2]),
+						&sde->descq_phys, GFP_KERNEL);
+		if (!sde->descq)
+			goto bail;
+		sde->tx_ring =
+			kvzalloc_node(array_size(descq_cnt,
+						 sizeof(struct sdma_txreq *)),
+				      GFP_KERNEL, dd->node);
+		if (!sde->tx_ring)
+			goto bail;
+	}
+	/* Clear SendDmaCfgMemory on disabled engines */
+	chip_engines = chip_sdma_engines(dd);
+	for (this_idx = num_engines; this_idx < chip_engines; ++this_idx)
+		write_sdmacfg_csr(dd, this_idx, dd->params->send_dma_cfg_memory_reg, 0);
+
+
+	dd->sdma_heads_size = L1_CACHE_BYTES * num_engines;
+	/* Allocate memory for DMA of head registers to memory */
+	dd->sdma_heads_dma = dma_alloc_coherent(&dd->pcidev->dev,
+						dd->sdma_heads_size,
+						&dd->sdma_heads_phys,
+						GFP_KERNEL);
+	if (!dd->sdma_heads_dma) {
+		dd_dev_err(dd, "failed to allocate SendDMA head memory\n");
+		goto bail;
+	}
+
+	/* Allocate memory for pad */
+	dd->sdma_pad_dma = dma_alloc_coherent(&dd->pcidev->dev, SDMA_PAD,
+					      &dd->sdma_pad_phys, GFP_KERNEL);
+	if (!dd->sdma_pad_dma) {
+		dd_dev_err(dd, "failed to allocate SendDMA pad memory\n");
+		goto bail;
+	}
+
+	/* assign each engine to different cacheline and init registers */
+	curr_head = (void *)dd->sdma_heads_dma;
+	for (this_idx = 0; this_idx < num_engines; ++this_idx) {
+		unsigned long phys_offset;
+
+		sde = &dd->per_sdma[this_idx];
+
+		sde->head_dma = curr_head;
+		curr_head += L1_CACHE_BYTES;
+		phys_offset = (unsigned long)sde->head_dma -
+			      (unsigned long)dd->sdma_heads_dma;
+		sde->head_phys = dd->sdma_heads_phys + phys_offset;
+		init_sdma_regs(sde, per_sdma_credits, idle_cnt);
+	}
+	dd->flags |= HFI2_HAS_SEND_DMA;
+	dd->flags |= idle_cnt ? HFI2_HAS_SDMA_TIMEOUT : 0;
+
+	for (pidx = 0; pidx < dd->num_pports; pidx++) {
+		ppd = dd->pport + pidx;
+		ret = sdma_map_init(ppd, ppd->vls_operational, NULL);
+		if (ret < 0)
+			goto bail;
+	}
+
+	tmp_sdma_rht = kzalloc(sizeof(*tmp_sdma_rht), GFP_KERNEL);
+	if (!tmp_sdma_rht) {
+		ret = -ENOMEM;
+		goto bail;
+	}
+
+	ret = rhashtable_init(tmp_sdma_rht, &sdma_rht_params);
+	if (ret < 0) {
+		kfree(tmp_sdma_rht);
+		goto bail;
+	}
+
+	dd->sdma_rht = tmp_sdma_rht;
+
+	dd_dev_info(dd, "SDMA num_sdma: %u\n", dd->num_sdma);
+	return 0;
+
+bail:
+	sdma_clean(dd, num_engines);
+	return ret;
+}
+
+/**
+ * sdma_all_running() - called when the link goes up
+ * @dd: hfi2_devdata
+ *
+ * This routine moves all engines to the running state.
+ */
+void sdma_all_running(struct hfi2_devdata *dd)
+{
+	struct sdma_engine *sde;
+	unsigned int i;
+
+	/* move all engines to running */
+	for (i = 0; i < dd->num_sdma; ++i) {
+		sde = &dd->per_sdma[i];
+		sdma_process_event(sde, sdma_event_e30_go_running);
+	}
+}
+
+/**
+ * sdma_all_idle() - called when the link goes down
+ * @dd: hfi2_devdata
+ *
+ * This routine moves all engines to the idle state.
+ */
+void sdma_all_idle(struct hfi2_devdata *dd)
+{
+	struct sdma_engine *sde;
+	unsigned int i;
+
+	/* idle all engines */
+	for (i = 0; i < dd->num_sdma; ++i) {
+		sde = &dd->per_sdma[i];
+		sdma_process_event(sde, sdma_event_e70_go_idle);
+	}
+}
+
+/**
+ * sdma_start() - called to kick off state processing for all engines
+ * @dd: hfi2_devdata
+ *
+ * This routine is for kicking off the state processing for all required
+ * sdma engines.  Interrupts need to be working at this point.
+ *
+ */
+void sdma_start(struct hfi2_devdata *dd)
+{
+	unsigned i;
+	struct sdma_engine *sde;
+
+	/* kick off the engines state processing */
+	for (i = 0; i < dd->num_sdma; ++i) {
+		sde = &dd->per_sdma[i];
+		sdma_process_event(sde, sdma_event_e10_go_hw_start);
+	}
+
+	/* tell all engines to go running */
+	sdma_all_running(dd);
+}
+
+/**
+ * sdma_exit() - used when module is removed
+ * @dd: hfi2_devdata
+ */
+void sdma_exit(struct hfi2_devdata *dd)
+{
+	unsigned this_idx;
+	struct sdma_engine *sde;
+
+	for (this_idx = 0; dd->per_sdma && this_idx < dd->num_sdma;
+			++this_idx) {
+		sde = &dd->per_sdma[this_idx];
+		if (!list_empty(&sde->dmawait))
+			dd_dev_err(dd, "sde %u: dmawait list not empty!\n",
+				   sde->this_idx);
+		sdma_process_event(sde, sdma_event_e00_go_hw_down);
+
+		timer_delete_sync(&sde->err_progress_check_timer);
+
+		/*
+		 * This waits for the state machine to exit so it is not
+		 * necessary to kill the sdma_sw_clean_up_worker to make sure
+		 * it is not running.
+		 */
+		sdma_finalput(&sde->state);
+	}
+}
+
+/*
+ * unmap the indicated descriptor
+ */
+static inline void sdma_unmap_desc(
+	struct hfi2_devdata *dd,
+	struct sdma_desc *descp,
+	u8 map_type)
+{
+	switch (map_type) {
+	case SDMA_MAP_SINGLE:
+		dma_unmap_single(&dd->pcidev->dev, sdma_mapping_addr(dd, descp),
+				 sdma_mapping_len(dd, descp), DMA_TO_DEVICE);
+		break;
+	case SDMA_MAP_PAGE:
+		dma_unmap_page(&dd->pcidev->dev, sdma_mapping_addr(dd, descp),
+			       sdma_mapping_len(dd, descp), DMA_TO_DEVICE);
+		break;
+	}
+}
+
+/*
+ * return the mode as indicated by the first
+ * descriptor in the tx.
+ */
+static inline u8 ahg_mode(struct sdma_txreq *tx)
+{
+	return (tx->descp[0].qw[1] & SDMA_DESC1_HEADER_MODE_SMASK)
+		>> SDMA_DESC1_HEADER_MODE_SHIFT;
+}
+
+/**
+ * __sdma_txclean() - clean tx of mappings, descp *kmalloc's
+ * @dd: hfi2_devdata for unmapping
+ * @tx: tx request to clean
+ *
+ * This is used in the progress routine to clean the tx or
+ * by the ULP to toss an in-process tx build.
+ *
+ * The code can be called multiple times without issue.
+ *
+ */
+void __sdma_txclean(
+	struct hfi2_devdata *dd,
+	struct sdma_txreq *tx)
+{
+	u16 i;
+
+	if (tx->num_desc) {
+		u8 skip = 0, mode = ahg_mode(tx);
+
+		/* unmap first */
+		sdma_unmap_desc(dd, &tx->descp[0], sdma_get_map_type(tx, 0));
+		/* determine number of AHG descriptors to skip */
+		if (mode > SDMA_AHG_APPLY_UPDATE1)
+			skip = mode >> 1;
+		for (i = 1 + skip; i < tx->num_desc; i++)
+			sdma_unmap_desc(dd, &tx->descp[i],
+					sdma_get_map_type(tx, i));
+		tx->num_desc = 0;
+	}
+	kfree(tx->coalesce_buf);
+	tx->coalesce_buf = NULL;
+	/* kmalloc'ed descp */
+	if (unlikely(tx->descp != tx->descs)) {
+		kfree(tx->descp);
+		tx->descp = tx->descs;
+		tx->desc_limit = ARRAY_SIZE(tx->descs);
+	}
+}
+
+static inline u16 sdma_gethead(struct sdma_engine *sde)
+{
+	struct hfi2_devdata *dd = sde->dd;
+	int use_dmahead;
+	u16 hwhead;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) %s:%d %s()\n",
+		   sde->this_idx, slashstrip(__FILE__), __LINE__, __func__);
+#endif
+
+retry:
+	use_dmahead = HFI2_CAP_IS_KSET(USE_SDMA_HEAD) && __sdma_running(sde) &&
+					(dd->flags & HFI2_HAS_SDMA_TIMEOUT);
+	hwhead = use_dmahead ?
+		(u16)le64_to_cpu(*sde->head_dma) :
+		(u16)read_sde_csr(sde, dd->params->send_dma_head_reg);
+
+	if (unlikely(HFI2_CAP_IS_KSET(SDMA_HEAD_CHECK))) {
+		u16 cnt;
+		u16 swtail;
+		u16 swhead;
+		int sane;
+
+		swhead = sde->descq_head & sde->sdma_mask;
+		/* this code is really bad for cache line trading */
+		swtail = READ_ONCE(sde->descq_tail) & sde->sdma_mask;
+		cnt = sde->descq_cnt;
+
+		if (swhead < swtail)
+			/* not wrapped */
+			sane = (hwhead >= swhead) & (hwhead <= swtail);
+		else if (swhead > swtail)
+			/* wrapped around */
+			sane = ((hwhead >= swhead) && (hwhead < cnt)) ||
+				(hwhead <= swtail);
+		else
+			/* empty */
+			sane = (hwhead == swhead);
+
+		if (unlikely(!sane)) {
+			dd_dev_err(dd, "SDMA(%u) bad head (%s) hwhd=%u swhd=%u swtl=%u cnt=%u\n",
+				   sde->this_idx,
+				   use_dmahead ? "dma" : "kreg",
+				   hwhead, swhead, swtail, cnt);
+			if (use_dmahead) {
+				/* try one more time, using csr */
+				use_dmahead = 0;
+				goto retry;
+			}
+			/* proceed as if no progress */
+			hwhead = swhead;
+		}
+	}
+	return hwhead;
+}
+
+/*
+ * This is called when there are send DMA descriptors that might be
+ * available.
+ *
+ * This is called with head_lock held.
+ */
+static void sdma_desc_avail(struct sdma_engine *sde, uint avail)
+{
+	struct iowait *wait, *nw, *twait;
+	struct iowait *waits[SDMA_WAIT_BATCH_SIZE];
+	uint i, n = 0, seq, tidx = 0;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) %s:%d %s()\n", sde->this_idx,
+		   slashstrip(__FILE__), __LINE__, __func__);
+	dd_dev_err(sde->dd, "avail: %u\n", avail);
+#endif
+
+	do {
+		seq = read_seqbegin(&sde->waitlock);
+		if (!list_empty(&sde->dmawait)) {
+			/* at least one item */
+			write_seqlock(&sde->waitlock);
+			/* Harvest waiters wanting DMA descriptors */
+			list_for_each_entry_safe(
+					wait,
+					nw,
+					&sde->dmawait,
+					list) {
+				u32 num_desc;
+
+				if (!wait->wakeup)
+					continue;
+				if (n == ARRAY_SIZE(waits))
+					break;
+				iowait_init_priority(wait);
+				num_desc = iowait_get_all_desc(wait);
+				if (num_desc > avail)
+					break;
+				avail -= num_desc;
+				/* Find the top-priority wait memeber */
+				if (n) {
+					twait = waits[tidx];
+					tidx =
+					    iowait_priority_update_top(wait,
+								       twait,
+								       n,
+								       tidx);
+				}
+				list_del_init(&wait->list);
+				waits[n++] = wait;
+			}
+			write_sequnlock(&sde->waitlock);
+			break;
+		}
+	} while (read_seqretry(&sde->waitlock, seq));
+
+	/* Schedule the top-priority entry first */
+	if (n)
+		waits[tidx]->wakeup(waits[tidx], SDMA_AVAIL_REASON);
+
+	for (i = 0; i < n; i++)
+		if (i != tidx)
+			waits[i]->wakeup(waits[i], SDMA_AVAIL_REASON);
+}
+
+/* head_lock must be held */
+static void sdma_make_progress(struct sdma_engine *sde, u64 status)
+{
+	struct sdma_txreq *txp = NULL;
+	int progress = 0;
+	u16 hwhead, swhead;
+	int idle_check_done = 0;
+
+	hwhead = sdma_gethead(sde);
+
+	/* The reason for some of the complexity of this code is that
+	 * not all descriptors have corresponding txps.  So, we have to
+	 * be able to skip over descs until we wander into the range of
+	 * the next txp on the list.
+	 */
+
+retry:
+	txp = get_txhead(sde);
+	swhead = sde->descq_head & sde->sdma_mask;
+	trace_hfi2_sdma_progress(sde, hwhead, swhead, txp);
+	while (swhead != hwhead) {
+		/* advance head, wrap if needed */
+		swhead = ++sde->descq_head & sde->sdma_mask;
+
+		/* if now past this txp's descs, do the callback */
+		if (txp && txp->next_descq_idx == swhead) {
+			/* remove from list */
+			sde->tx_ring[sde->tx_head++ & sde->sdma_mask] = NULL;
+			complete_tx(sde, txp, SDMA_TXREQ_S_OK);
+			/* see if there is another txp */
+			txp = get_txhead(sde);
+		}
+		trace_hfi2_sdma_progress(sde, hwhead, swhead, txp);
+		progress++;
+	}
+
+	/*
+	 * The SDMA idle interrupt is not guaranteed to be ordered with respect
+	 * to updates to the dma_head location in host memory. The head
+	 * value read might not be fully up to date. If there are pending
+	 * descriptors and the SDMA idle interrupt fired then read from the
+	 * CSR SDMA head instead to get the latest value from the hardware.
+	 * The hardware SDMA head should be read at most once in this invocation
+	 * of sdma_make_progress(..) which is ensured by idle_check_done flag
+	 */
+	if ((status & sde->idle_mask) && !idle_check_done) {
+		u16 swtail;
+
+		swtail = READ_ONCE(sde->descq_tail) & sde->sdma_mask;
+		if (swtail != hwhead) {
+			hwhead = (u16)read_sde_csr(sde, sde->dd->params->send_dma_head_reg);
+			idle_check_done = 1;
+			goto retry;
+		}
+	}
+
+	sde->last_status = status;
+	if (progress)
+		sdma_desc_avail(sde, sdma_descq_freecnt(sde));
+}
+
+bool sdma_work_pending(struct sdma_engine *sde)
+{
+	u16 hwhead, swhead;
+
+	hwhead = sdma_gethead(sde);
+	swhead = sde->descq_head & sde->sdma_mask;
+	return (swhead != hwhead);
+}
+
+/*
+ * sdma_engine_interrupt() - interrupt handler for engine
+ * @sde: sdma engine
+ * @status: sdma interrupt reason
+ *
+ * Status is a mask of the 3 possible interrupts for this engine.  It will
+ * contain bits _only_ for this SDMA engine.  It will contain at least one
+ * bit, it may contain more.
+ */
+void sdma_engine_interrupt(struct sdma_engine *sde, u64 status)
+{
+	trace_hfi2_sdma_engine_interrupt(sde, status);
+	write_seqlock(&sde->head_lock);
+	sdma_set_desc_cnt(sde, sdma_desct_intr);
+	if (status & sde->idle_mask)
+		sde->idle_int_cnt++;
+	else if (status & sde->progress_mask)
+		sde->progress_int_cnt++;
+	else if (status & sde->int_mask)
+		sde->sdma_int_cnt++;
+	sdma_make_progress(sde, status);
+	write_sequnlock(&sde->head_lock);
+}
+
+/**
+ * sdma_engine_error() - error handler for engine
+ * @sde: sdma engine
+ * @status: sdma interrupt reason
+ */
+void sdma_engine_error(struct sdma_engine *sde, u64 status)
+{
+	unsigned long flags;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) error status 0x%llx state %s\n",
+		   sde->this_idx,
+		   (unsigned long long)status,
+		   sdma_state_names[sde->state.current_state]);
+#endif
+	spin_lock_irqsave(&sde->tail_lock, flags);
+	write_seqlock(&sde->head_lock);
+	if (status & ALL_SDMA_ENG_HALT_ERRS)
+		__sdma_process_event(sde, sdma_event_e60_hw_halted);
+	if (status & ~SD(ENG_ERR_STATUS_SDMA_HALT_ERR_SMASK)) {
+		dd_dev_err(sde->dd,
+			   "SDMA (%u) engine error: 0x%llx state %s\n",
+			   sde->this_idx,
+			   (unsigned long long)status,
+			   sdma_state_names[sde->state.current_state]);
+		dump_sdma_state(sde);
+	}
+	write_sequnlock(&sde->head_lock);
+	spin_unlock_irqrestore(&sde->tail_lock, flags);
+}
+
+static void sdma_sendctrl(struct sdma_engine *sde, unsigned op)
+{
+	struct hfi2_devdata *dd = sde->dd;
+	u64 set_senddmactrl = 0;
+	u64 clr_senddmactrl = 0;
+	unsigned long flags;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) senddmactrl E=%d I=%d H=%d C=%d\n",
+		   sde->this_idx,
+		   (op & SDMA_SENDCTRL_OP_ENABLE) ? 1 : 0,
+		   (op & SDMA_SENDCTRL_OP_INTENABLE) ? 1 : 0,
+		   (op & SDMA_SENDCTRL_OP_HALT) ? 1 : 0,
+		   (op & SDMA_SENDCTRL_OP_CLEANUP) ? 1 : 0);
+#endif
+
+	if (op & SDMA_SENDCTRL_OP_ENABLE)
+		set_senddmactrl |= SD(CTRL_SDMA_ENABLE_SMASK);
+	else
+		clr_senddmactrl |= SD(CTRL_SDMA_ENABLE_SMASK);
+
+	if (op & SDMA_SENDCTRL_OP_INTENABLE)
+		set_senddmactrl |= SD(CTRL_SDMA_INT_ENABLE_SMASK);
+	else
+		clr_senddmactrl |= SD(CTRL_SDMA_INT_ENABLE_SMASK);
+
+	if (op & SDMA_SENDCTRL_OP_HALT)
+		set_senddmactrl |= SD(CTRL_SDMA_HALT_SMASK);
+	else
+		clr_senddmactrl |= SD(CTRL_SDMA_HALT_SMASK);
+
+	spin_lock_irqsave(&sde->senddmactrl_lock, flags);
+
+	sde->p_senddmactrl |= set_senddmactrl;
+	sde->p_senddmactrl &= ~clr_senddmactrl;
+	// conditionally set SDmaSingleDescriptor
+	if (sdma_single_descriptor)
+		sde->p_senddmactrl |= (1uLL << 5);
+	// conditionally set SDmaThresholdEnable - JKR only
+	if (dd->sdma_threshold) {
+		sde->p_senddmactrl |= (1uLL << 4);
+		write_sde_csr(sde, dd->params->send_dma_priority_thld_reg, dd->sdma_threshold);
+	}
+
+	if (op & SDMA_SENDCTRL_OP_CLEANUP)
+		write_sde_csr(sde, dd->params->send_dma_ctrl_reg,
+			      sde->p_senddmactrl |
+			      SD(CTRL_SDMA_CLEANUP_SMASK));
+	else
+		write_sde_csr(sde, dd->params->send_dma_ctrl_reg, sde->p_senddmactrl);
+
+	spin_unlock_irqrestore(&sde->senddmactrl_lock, flags);
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	sdma_dumpstate(sde);
+#endif
+}
+
+static void sdma_setlengen(struct sdma_engine *sde)
+{
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) %s:%d %s()\n",
+		   sde->this_idx, slashstrip(__FILE__), __LINE__, __func__);
+#endif
+
+	/*
+	 * Set SendDmaLenGen and clear-then-set the MSB of the generation
+	 * count to enable generation checking and load the internal
+	 * generation counter.
+	 */
+	write_sde_csr(sde, sde->dd->params->send_dma_len_gen_reg,
+		      (sde->descq_cnt / 64) << SD(LEN_GEN_LENGTH_SHIFT));
+	write_sde_csr(sde, sde->dd->params->send_dma_len_gen_reg,
+		      ((sde->descq_cnt / 64) << SD(LEN_GEN_LENGTH_SHIFT)) |
+		      (4ULL << SD(LEN_GEN_GENERATION_SHIFT)));
+}
+
+static inline void sdma_update_tail(struct sdma_engine *sde, u16 tail)
+{
+	/* Commit writes to memory and advance the tail on the chip */
+	smp_wmb(); /* see get_txhead() */
+	writeq(tail, sde->tail_csr);
+}
+
+/*
+ * This is called when changing to state s10_hw_start_up_halt_wait as
+ * a result of send buffer errors or send DMA descriptor errors.
+ */
+static void sdma_hw_start_up(struct sdma_engine *sde)
+{
+	u64 reg;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) %s:%d %s()\n",
+		   sde->this_idx, slashstrip(__FILE__), __LINE__, __func__);
+#endif
+
+	sdma_setlengen(sde);
+	sdma_update_tail(sde, 0); /* Set SendDmaTail */
+	*sde->head_dma = 0;
+
+	reg = SD(ENG_ERR_CLEAR_SDMA_HEADER_REQUEST_FIFO_UNC_ERR_MASK) <<
+	      SD(ENG_ERR_CLEAR_SDMA_HEADER_REQUEST_FIFO_UNC_ERR_SHIFT);
+	write_sde_csr(sde, sde->dd->params->send_dma_eng_err_clear_reg, reg);
+}
+
+/*
+ * set_sdma_integrity
+ *
+ * Set the SEND_DMA_CHECK_ENABLE register for send DMA engine 'sde'.
+ */
+static void set_sdma_integrity(struct sdma_engine *sde)
+{
+	struct hfi2_devdata *dd = sde->dd;
+
+	write_sde_csr(sde, SD(CHECK_ENABLE),
+		      hfi2_pkt_base_sdma_integrity(dd));
+}
+
+static void init_sdma_regs(struct sdma_engine *sde, u32 credits, uint idle_cnt)
+{
+	u64 opval, opmask;
+	struct hfi2_devdata *dd = sde->dd;
+
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(dd, "CONFIG SDMA(%u) %s:%d %s()\n",
+		   sde->this_idx, slashstrip(__FILE__), __LINE__, __func__);
+#endif
+
+	write_sde_csr(sde, dd->params->send_dma_base_addr_reg, sde->descq_phys);
+	sdma_setlengen(sde);
+	sdma_update_tail(sde, 0); /* Set SendDmaTail */
+	write_sde_csr(sde, dd->params->send_dma_reload_cnt_reg, idle_cnt);
+	write_sde_csr(sde, dd->params->send_dma_desc_cnt_reg, 0);
+	write_sde_csr(sde, dd->params->send_dma_head_addr_reg, sde->head_phys);
+	write_sdecfg_csr(sde, dd->params->send_dma_cfg_memory_reg,
+			 ((u64)credits << SD(MEMORY_SDMA_MEMORY_CNT_SHIFT)) |
+			 ((u64)(credits * sde->this_idx) <<
+			  SD(MEMORY_SDMA_MEMORY_INDEX_SHIFT)));
+	write_sde_csr(sde, dd->params->send_dma_eng_err_mask_reg, ~0ull);
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* SEND_DMA_CHECK_* are WFR only */
+		set_sdma_integrity(sde);
+		opmask = OPCODE_CHECK_MASK_DISABLED;
+		opval = OPCODE_CHECK_VAL_DISABLED;
+		write_sde_csr(sde, SD(CHECK_OPCODE),
+			      (opmask << SEND_CTXT_CHECK_OPCODE_MASK_SHIFT) |
+			      (opval << SEND_CTXT_CHECK_OPCODE_VALUE_SHIFT));
+	}
+}
+
+#ifdef CONFIG_SDMA_VERBOSITY
+
+#define sdma_dumpstate_helper0(reg) do { \
+		csr = read_csr(sde->dd, reg); \
+		dd_dev_err(sde->dd, "%41s     0x%016llx\n", #reg, csr); \
+	} while (0)
+
+#define sdma_dumpstate_helper(reg) do { \
+		csr = read_sde_csr(sde, reg); \
+		dd_dev_err(sde->dd, "%41s[%02u] 0x%016llx\n", \
+			#reg, sde->this_idx, csr); \
+	} while (0)
+
+#define sdma_dumpstate_helper1(reg) do { \
+		csr = read_sdecfg_csr(sde, reg); \
+		dd_dev_err(sde->dd, "%41s[%02u] 0x%016llx\n", \
+			#reg, sde->this_idx, csr); \
+	} while (0)
+
+/* interrupt status */
+static void sdma_dumpstate_int(struct sdma_engine *sde, u32 is_base,
+			       const char *what)
+{
+	struct hfi2_devdata *dd = sde->dd;
+	u32 is_num = is_base + sde->this_idx;
+	u32 reg_off = 8 * (is_num / BITS_PER_REGISTER);
+	u64 reg_mask = BIT_ULL(is_num % BITS_PER_REGISTER);
+	int status;
+	int mask;
+	int blocked;
+
+	status = !!(read_csr(dd, CCE_INT_STATUS + reg_off) & reg_mask);
+	mask = !!(read_csr(dd, CCE_INT_MASK + reg_off) & reg_mask);
+	blocked = !!(read_csr(dd, CCE_INT_BLOCKED + reg_off) & reg_mask);
+
+	dd_dev_err(dd, "%41s[%02u] status:%d mask:%d blocked:%d\n",
+		   what, sde->this_idx, status, mask, blocked);
+}
+
+void sdma_dumpstate(struct sdma_engine *sde)
+{
+	struct hfi2_devdata *dd = sde->dd;
+	u64 csr;
+
+	sdma_dumpstate_helper(dd->params->send_dma_ctrl_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_status_reg);
+	sdma_dumpstate_helper0(dd->params->send_dma_err_status_reg);
+	sdma_dumpstate_helper0(dd->params->send_dma_err_mask_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_eng_err_status_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_eng_err_mask_reg);
+
+	sdma_dumpstate_int(sde, dd->params->is_sdma_start, "SdmaInt");
+	sdma_dumpstate_int(sde, dd->params->is_sdma_progress_start,
+			   "SdmaProgressInt");
+	sdma_dumpstate_int(sde, dd->params->is_sdma_idle_start, "SdmaIdleInt");
+
+	sdma_dumpstate_helper(dd->params->send_dma_tail_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_head_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_priority_thld_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_idle_cnt_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_reload_cnt_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_desc_cnt_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_desc_fetched_cnt_reg);
+	sdma_dumpstate_helper1(dd->params->send_dma_cfg_memory_reg);
+	sdma_dumpstate_helper0(dd->params->send_dma_engines_reg);
+	sdma_dumpstate_helper0(dd->params->send_dma_mem_size_reg);
+	/* sdma_dumpstate_helper(SEND_EGRESS_SEND_DMA_STATUS);  */
+	sdma_dumpstate_helper(dd->params->send_dma_base_addr_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_len_gen_reg);
+	sdma_dumpstate_helper(dd->params->send_dma_head_addr_reg);
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* SEND_DMA_CHECK_* are WFR only */
+		sdma_dumpstate_helper(SD(CHECK_ENABLE));
+		sdma_dumpstate_helper(SD(CHECK_VL));
+		sdma_dumpstate_helper(SD(CHECK_JOB_KEY));
+		sdma_dumpstate_helper(SD(CHECK_PARTITION_KEY));
+		sdma_dumpstate_helper(SD(CHECK_SLID));
+		sdma_dumpstate_helper(SD(CHECK_OPCODE));
+	}
+}
+#endif
+
+/*
+ * Translate the SDMA descriptor (qw) into human readable text.
+ *
+ * Output is one or two buffers.  Both buffers will always be initialized into
+ * valid strings.  The second buffer is empty if it is an empty string.  Both
+ * buffers are expected to be of length QW_BUF_SIZE.
+ */
+#define QW_BUF_SIZE 128
+static void sdma_qw_strings(struct hfi2_devdata *dd, u32 idx, u64 *qw,
+			    char *buf0, char *buf1)
+{
+	u64 addr;
+	u32 len;
+	u32 gen;
+	char flags[6];
+	bool first = sdma_qw_get(dd, first_desc, qw);
+
+	flags[0] = (qw[1] & SDMA_DESC1_INT_REQ_FLAG) ? 'I' : '-';
+	flags[1] = (qw[1] & SDMA_DESC1_HEAD_TO_HOST_FLAG) ?  'H' : '-';
+	flags[2] = first ? 'F' : '-';
+	flags[3] = sdma_qw_get(dd, last_desc, qw) ? 'L' : '-';
+	flags[4] = 0; /* terminate */
+	addr = sdma_qw_get(dd, phy_addr, qw);
+	gen = (qw[1] >> SDMA_DESC1_GENERATION_SHIFT)
+		& SDMA_DESC1_GENERATION_MASK;
+	len = sdma_qw_get(dd, byte_count, qw);
+	scnprintf(buf0, QW_BUF_SIZE,
+		  "desc[%u]: flags:%s addr:0x%016llx gen:%u len:%u d0:0x%016llx d1:0x%016llx",
+		  idx, flags, addr, gen, len, qw[0], qw[1]);
+	if (first) {
+		scnprintf(buf1, QW_BUF_SIZE, "aidx:%u amode:%u alen:%u",
+			  (u32)((qw[1] & SDMA_DESC1_HEADER_INDEX_SMASK) >>
+				SDMA_DESC1_HEADER_INDEX_SHIFT),
+			  (u32)((qw[1] & SDMA_DESC1_HEADER_MODE_SMASK) >>
+				SDMA_DESC1_HEADER_MODE_SHIFT),
+			  (u32)((qw[1] & SDMA_DESC1_HEADER_DWS_SMASK) >>
+				SDMA_DESC1_HEADER_DWS_SHIFT));
+	} else {
+		buf1[0] = 0;
+	}
+}
+
+/* interrupt deferred SDMA descriptor dump information */
+struct sdma_print_info {
+	struct work_struct sdma_dump_work;
+	struct sdma_engine *sde; /* only use for auxiliary info */
+	struct hw_sdma_desc *descs;
+	u32 tag;
+	u16 head;
+	u16 tail;
+};
+
+/* show descriptors using information from argument sdi, not sdi->sde */
+static void show_tagged_sdma_descriptors(const struct sdma_print_info *sdi)
+{
+	char buf0[QW_BUF_SIZE];
+	char buf1[QW_BUF_SIZE];
+	struct sdma_engine *sde = sdi->sde;
+	struct hfi2_devdata *dd = sde->dd;
+	struct hw_sdma_desc *descqp;
+	u64 desc[2];
+	u16 head = sdi->head;
+
+	/* print info for each entry in the descriptor queue */
+	while (head != sdi->tail) {
+		descqp = &sdi->descs[head];
+		desc[0] = le64_to_cpu(descqp->qw[0]);
+		desc[1] = le64_to_cpu(descqp->qw[1]);
+
+		sdma_qw_strings(dd, head, desc, buf0, buf1);
+		dd_dev_err(dd, "[desc %u] SDMA %s\n", sdi->tag, buf0);
+		if (buf1[0])
+			dd_dev_err(dd, "[desc %u]\t%s\n", sdi->tag, buf1);
+		head = (head + 1) & sde->sdma_mask;
+	}
+}
+
+static void sdma_dump_worker(struct work_struct *work)
+{
+	struct sdma_print_info *sdi = container_of(work, struct sdma_print_info,
+						  sdma_dump_work);
+
+	show_tagged_sdma_descriptors(sdi);
+	kfree(sdi->descs);
+	kfree(sdi);
+}
+
+static void dump_sdma_state(struct sdma_engine *sde)
+{
+	char tag_info[64];
+	struct hfi2_devdata *dd = sde->dd;
+	struct sdma_print_info local_sdi;
+	struct sdma_print_info *sdi;
+	struct hw_sdma_desc *descs;
+	int tag;
+	u16 head, tail, used, avail;
+
+	head = sde->descq_head & sde->sdma_mask;
+	tail = sde->descq_tail & sde->sdma_mask;
+	used = sdma_descq_inprocess(sde);
+	avail = sdma_descq_freecnt(sde);
+
+	if (used) {
+		tag = atomic_fetch_inc(&dd->sdma_print_tag);
+		snprintf(tag_info, sizeof(tag_info),
+			 ", descriptor print prefix \"[desc %d]\"", tag);
+	} else {
+		tag = 0;
+		tag_info[0] = 0;
+	}
+
+	dd_dev_err(dd, "SDMA (%u) descq_head %u, descq_tail %u, used %u, avail %u, FLE %d%s\n",
+		   sde->this_idx, head, tail, used, avail,
+		   !list_empty(&sde->flushlist), tag_info);
+	if (used == 0)
+		return;
+
+	/* print descriptors - either immediately or delayed */
+	if (in_interrupt()) {
+		size_t size = sizeof(struct hw_sdma_desc) * sde->descq_cnt;
+
+		sdi = kmalloc(sizeof(*sdi), GFP_ATOMIC);
+		descs = kmalloc(size, GFP_ATOMIC);
+		if (!sdi || !descs) {
+			kfree(sdi);
+			kfree(descs);
+			return;
+		}
+
+		INIT_WORK(&sdi->sdma_dump_work, sdma_dump_worker);
+		memcpy(descs, sde->descq, size);
+	} else {
+		sdi = &local_sdi;
+		descs = sde->descq;
+		memset(&sdi->sdma_dump_work, 0, sizeof(sdi->sdma_dump_work));
+	}
+
+	sdi->sde = sde;
+	sdi->descs = descs;
+	sdi->tag = tag;
+	sdi->head = head;
+	sdi->tail = tail;
+
+	if (in_interrupt())
+		queue_work(dd->hfi2_wq, &sdi->sdma_dump_work);
+	else
+		show_tagged_sdma_descriptors(sdi);
+}
+
+#define SDE_FMT \
+	"SDE %u CPU %d STE %s C 0x%llx S 0x%016llx E 0x%llx T(HW) 0x%llx T(SW) 0x%x H(HW) 0x%llx H(SW) 0x%x H(D) 0x%llx DM 0x%llx GL 0x%llx R 0x%llx LIS 0x%llx AHGI 0x%llx TXT %u TXH %u DT %u DH %u FLNE %d DQF %u SLC 0x%llx\n"
+/**
+ * sdma_seqfile_dump_sde() - debugfs dump of sde
+ * @s: seq file
+ * @sde: send dma engine to dump
+ *
+ * This routine dumps the sde to the indicated seq file.
+ */
+void sdma_seqfile_dump_sde(struct seq_file *s, struct sdma_engine *sde)
+{
+	char buf0[QW_BUF_SIZE];
+	char buf1[QW_BUF_SIZE];
+	struct hfi2_devdata *dd = sde->dd;
+	unsigned long long check_slid;
+	u16 head, tail;
+	struct hw_sdma_desc *descqp;
+	u64 desc[2];
+
+	head = sde->descq_head & sde->sdma_mask;
+	tail = READ_ONCE(sde->descq_tail) & sde->sdma_mask;
+	/* SEND_DMA_CHECK_SLID is only available on WFR */
+	check_slid = dd->params->chip_type == CHIP_WFR ?
+			read_sde_csr(sde, SEND_DMA_CHECK_SLID) : 0ULL;
+	seq_printf(s, SDE_FMT, sde->this_idx,
+		   sde->cpu,
+		   sdma_state_name(sde->state.current_state),
+		   (unsigned long long)read_sde_csr(sde, dd->params->send_dma_ctrl_reg),
+		   (unsigned long long)read_sde_csr(sde, dd->params->send_dma_status_reg),
+		   (unsigned long long)read_sde_csr(sde, dd->params->send_dma_eng_err_status_reg),
+		   (unsigned long long)read_sde_csr(sde, dd->params->send_dma_tail_reg), tail,
+		   (unsigned long long)read_sde_csr(sde, dd->params->send_dma_head_reg), head,
+		   (unsigned long long)le64_to_cpu(*sde->head_dma),
+		   (unsigned long long)read_sdecfg_csr(sde, dd->params->send_dma_cfg_memory_reg),
+		   (unsigned long long)read_sde_csr(sde, dd->params->send_dma_len_gen_reg),
+		   (unsigned long long)read_sde_csr(sde, dd->params->send_dma_reload_cnt_reg),
+		   (unsigned long long)sde->last_status,
+		   (unsigned long long)sde->ahg_bits,
+		   sde->tx_tail,
+		   sde->tx_head,
+		   sde->descq_tail,
+		   sde->descq_head,
+		   !list_empty(&sde->flushlist),
+		   sde->descq_full_count,
+		   check_slid);
+
+	/* print info for each entry in the descriptor queue */
+	while (head != tail) {
+		descqp = &sde->descq[head];
+		desc[0] = le64_to_cpu(descqp->qw[0]);
+		desc[1] = le64_to_cpu(descqp->qw[1]);
+
+		sdma_qw_strings(dd, head, desc, buf0, buf1);
+		seq_printf(s, "\t%s\n", buf0);
+		if (buf1[0])
+			seq_printf(s, "\t\t%s\n", buf1);
+
+		head = (head + 1) & sde->sdma_mask;
+	}
+}
+
+/*
+ * Add the generation number into qw1 and return the updated value.
+ * The incoming value of the field is expected to be zero.
+ */
+static inline u64 add_gen(struct sdma_engine *sde, u64 qw1)
+{
+	u64 generation = (sde->descq_tail >> sde->sdma_shift) &
+				SDMA_DESC1_GENERATION_MASK;
+
+	return qw1 | (generation << SDMA_DESC1_GENERATION_SHIFT);
+}
+
+/*
+ * This routine submits the indicated tx
+ *
+ * Space has already been guaranteed and
+ * tail side of ring is locked.
+ *
+ * The hardware tail update is done
+ * in the caller and that is facilitated
+ * by returning the new tail.
+ *
+ * There is special case logic for ahg
+ * to not add the generation number for
+ * up to 2 descriptors that follow the
+ * first descriptor.
+ *
+ */
+static inline u16 _submit_tx(struct sdma_engine *sde, struct sdma_txreq *tx, u8 pad)
+{
+	int i;
+	u16 tail;
+	struct sdma_desc *descp = tx->descp;
+	u8 skip = 0, mode = ahg_mode(tx);
+
+	tail = sde->descq_tail & sde->sdma_mask;
+	sde->descq[tail].qw[0] = cpu_to_le64(descp->qw[0]);
+	sde->descq[tail].qw[1] = cpu_to_le64(add_gen(sde, descp->qw[1]));
+	trace_hfi2_sdma_descriptor(sde, descp->qw,
+				   tail, &sde->descq[tail]);
+	tail = ++sde->descq_tail & sde->sdma_mask;
+	descp++;
+	if (mode > SDMA_AHG_APPLY_UPDATE1)
+		skip = mode >> 1;
+	for (i = 1; i < tx->num_desc; i++, descp++) {
+		u64 qw[2];
+
+		if (i == tx->num_desc - 1 && pad) {
+			u16 j;
+
+			qw[0] = sdma_pad.qw[0];
+			for (j = 0; j < pad; j++) {
+				qw[1] = add_gen(sde, sdma_pad.qw[1]);
+				sde->descq[tail].qw[0] = cpu_to_le64(qw[0]);
+				sde->descq[tail].qw[1] = cpu_to_le64(qw[1]);
+				trace_hfi2_sdma_descriptor(sde, qw,
+							   tail, &sde->descq[tail]);
+				tail = ++sde->descq_tail & sde->sdma_mask;
+			}
+		}
+
+		qw[0] = descp->qw[0];
+		if (skip) {
+			/* edits don't have generation */
+			qw[1] = descp->qw[1];
+			skip--;
+		} else {
+			/* replace generation with real one for non-edits */
+			qw[1] = add_gen(sde, descp->qw[1]);
+		}
+		sde->descq[tail].qw[0] = cpu_to_le64(qw[0]);
+		sde->descq[tail].qw[1] = cpu_to_le64(qw[1]);
+		trace_hfi2_sdma_descriptor(sde, qw,
+					   tail, &sde->descq[tail]);
+		tail = ++sde->descq_tail & sde->sdma_mask;
+	}
+	tx->next_descq_idx = tail;
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+	tx->sn = sde->tail_sn++;
+	trace_hfi2_sdma_in_sn(sde, tx->sn);
+	WARN_ON_ONCE(sde->tx_ring[sde->tx_tail & sde->sdma_mask]);
+#endif
+	sde->tx_ring[sde->tx_tail++ & sde->sdma_mask] = tx;
+	sde->desc_avail -= tx->num_desc + pad;
+	return tail;
+}
+
+static inline u16 submit_tx(struct sdma_engine *sde, struct sdma_txreq *tx)
+{
+	if (sde->dd->pad_sdma_desc)
+		trace_hfi2_sdma_pad(sde->this_idx, 1, sde->dd->pad_sdma_desc,
+				    tx->num_desc, tx->num_pad);
+	return _submit_tx(sde, tx, tx->num_pad);
+}
+
+/*
+ * Check for progress
+ */
+static int sdma_check_progress(
+	struct sdma_engine *sde,
+	struct iowait_work *wait,
+	struct sdma_txreq *tx,
+	bool pkts_sent)
+{
+	int ret;
+
+	sde->desc_avail = sdma_descq_freecnt(sde);
+	if (tx->num_desc + tx->num_pad <= sde->desc_avail)
+		return -EAGAIN;
+	/* pulse the head_lock */
+	if (wait && iowait_ioww_to_iow(wait)->sleep) {
+		unsigned seq;
+
+		seq = raw_seqcount_begin(
+			(const seqcount_t *)&sde->head_lock.seqcount);
+		ret = wait->iow->sleep(sde, wait, tx, seq, pkts_sent);
+		if (ret == -EAGAIN)
+			sde->desc_avail = sdma_descq_freecnt(sde);
+	} else {
+		ret = -EBUSY;
+	}
+	return ret;
+}
+
+/**
+ * sdma_send_txreq() - submit a tx req to ring
+ * @sde: sdma engine to use
+ * @wait: SE wait structure to use when full (may be NULL)
+ * @tx: sdma_txreq to submit
+ * @pkts_sent: has any packet been sent yet?
+ *
+ * The call submits the tx into the ring.  If a iowait structure is non-NULL
+ * the packet will be queued to the list in wait.
+ *
+ * Return:
+ * 0            - success (submittted to ring or silently dropped)
+ * -EINVAL      - sdma_txreq incomplete
+ * -EBUSY       - no space in ring (wait == NULL)
+ * -EIOCBQUEUED - tx queued to iowait
+ * -ECOMM       - bad sdma state, tx queued to flush list
+ */
+int sdma_send_txreq(struct sdma_engine *sde,
+		    struct iowait_work *wait,
+		    struct sdma_txreq *tx,
+		    bool pkts_sent)
+{
+	int ret = 0;
+	u16 tail;
+	unsigned long flags;
+
+	/* user should have supplied entire packet */
+	if (unlikely(tx->tlen))
+		return -EINVAL;
+	tx->wait = iowait_ioww_to_iow(wait);
+	spin_lock_irqsave(&sde->tail_lock, flags);
+retry:
+	if (unlikely(!__sdma_running(sde)))
+		goto unlock_noconn;
+	if (unlikely(tx->num_desc + tx->num_pad > sde->desc_avail))
+		goto nodesc;
+	tail = submit_tx(sde, tx);
+	if (wait)
+		iowait_sdma_inc(iowait_ioww_to_iow(wait));
+	sdma_update_tail(sde, tail);
+unlock:
+	spin_unlock_irqrestore(&sde->tail_lock, flags);
+	return ret;
+unlock_noconn:
+	if (wait)
+		iowait_sdma_inc(iowait_ioww_to_iow(wait));
+	tx->next_descq_idx = 0;
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+	tx->sn = sde->tail_sn++;
+	trace_hfi2_sdma_in_sn(sde, tx->sn);
+#endif
+	spin_lock(&sde->flushlist_lock);
+	list_add_tail(&tx->list, &sde->flushlist);
+	spin_unlock(&sde->flushlist_lock);
+	iowait_inc_wait_count(wait, tx->num_desc);
+	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
+	ret = -ECOMM;
+	goto unlock;
+nodesc:
+	ret = sdma_check_progress(sde, wait, tx, pkts_sent);
+	if (ret == -EAGAIN) {
+		ret = 0;
+		goto retry;
+	}
+	sde->descq_full_count++;
+	goto unlock;
+}
+
+/**
+ * sdma_send_txlist() - submit a list of tx req to ring
+ * @sde: sdma engine to use
+ * @wait: SE wait structure to use when full (may be NULL)
+ * @tx_list: list of sdma_txreqs to submit
+ * @count_out: pointer to a u16 which, after return will contain the total number of
+ *             sdma_txreqs removed from the tx_list. This will include sdma_txreqs
+ *             whose SDMA descriptors are submitted to the ring and the sdma_txreqs
+ *             which are added to SDMA engine flush list if the SDMA engine state is
+ *             not running.
+ *
+ * The call submits the list into the ring.
+ *
+ * If the iowait structure is non-NULL and not equal to the iowait list
+ * the unprocessed part of the list  will be appended to the list in wait.
+ *
+ * In all cases, the tx_list will be updated so the head of the tx_list is
+ * the list of descriptors that have yet to be transmitted.
+ *
+ * The intent of this call is to provide a more efficient
+ * way of submitting multiple packets to SDMA while holding the tail
+ * side locking.
+ *
+ * Return:
+ * 0 - Success,
+ * -EINVAL - sdma_txreq incomplete, -EBUSY - no space in ring (wait == NULL)
+ * -EIOCBQUEUED - tx queued to iowait, -ECOMM bad sdma state
+ */
+int sdma_send_txlist(struct sdma_engine *sde, struct iowait_work *wait,
+		     struct list_head *tx_list, u16 *count_out)
+{
+	struct hfi2_devdata *dd = sde->dd;
+	struct sdma_txreq *tx, *tx_next;
+	int ret = 0;
+	unsigned long flags;
+	u16 tail = INVALID_TAIL;
+	u16 desc_avail;
+	u16 cur_descs;
+	u8 pkts;
+	u32 submit_count = 0, flush_count = 0, total_count;
+
+	spin_lock_irqsave(&sde->tail_lock, flags);
+retry:
+	cur_descs = 0;
+	pkts = 0;
+	desc_avail = sde->desc_avail;
+	if (dd->pad_sdma_desc)
+		desc_avail = round_down(desc_avail, dd->pad_sdma_desc);
+
+	list_for_each_entry_safe(tx, tx_next, tx_list, list) {
+		u8 pad = 0;
+
+		tx->wait = iowait_ioww_to_iow(wait);
+		if (unlikely(!__sdma_running(sde)))
+			goto unlock_noconn;
+		if (unlikely(tx->num_desc > desc_avail))
+			goto nodesc;
+		if (unlikely(tx->tlen)) {
+			ret = -EINVAL;
+			goto update_tail;
+		}
+		list_del_init(&tx->list);
+		cur_descs += tx->num_desc;
+		desc_avail -= tx->num_desc;
+		pkts++;
+
+		/*
+		 * Only add padding descriptors to last packet before tail
+		 * update so that tail update is a dd->pad_sdma_desc multiple.
+		 *
+		 * Look ahead to see if the next packet will cause a tail
+		 * update. If so, this packet is the last packet, so pad out
+		 * its descriptors as necessary. The next packet will start its
+		 * own update block.
+		 */
+		if (dd->pad_sdma_desc) {
+			bool last = false;
+
+			/* No more packets */
+			if (list_empty(tx_list))
+				last = true;
+			/* Next packet will goto nodesc, then update_tail */
+			else if (tx_next->num_desc > desc_avail)
+				last = true;
+			/* Next packet will goto update_tail */
+			else if (unlikely(tx_next->tlen))
+				last = true;
+			else if (((submit_count + 1) & SDMA_TAIL_UPDATE_THRESH) == 0)
+				last = true;
+
+			if (last) {
+				pad = (u8)(round_up(cur_descs, dd->pad_sdma_desc) - cur_descs);
+				trace_hfi2_sdma_pad(sde->this_idx, pkts, dd->pad_sdma_desc,
+						    cur_descs, pad);
+				cur_descs += pad;
+				desc_avail -= pad;
+			}
+		}
+
+		tail = _submit_tx(sde, tx, pad);
+		submit_count++;
+		if (tail != INVALID_TAIL &&
+		    (submit_count & SDMA_TAIL_UPDATE_THRESH) == 0) {
+			sdma_update_tail(sde, tail);
+			tail = INVALID_TAIL;
+		}
+	}
+update_tail:
+	total_count = submit_count + flush_count;
+	if (wait) {
+		iowait_sdma_add(iowait_ioww_to_iow(wait), total_count);
+		iowait_starve_clear(submit_count > 0,
+				    iowait_ioww_to_iow(wait));
+	}
+	if (tail != INVALID_TAIL)
+		sdma_update_tail(sde, tail);
+	spin_unlock_irqrestore(&sde->tail_lock, flags);
+	*count_out = total_count;
+	return ret;
+unlock_noconn:
+	spin_lock(&sde->flushlist_lock);
+	list_for_each_entry_safe(tx, tx_next, tx_list, list) {
+		tx->wait = iowait_ioww_to_iow(wait);
+		list_del_init(&tx->list);
+		tx->next_descq_idx = 0;
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+		tx->sn = sde->tail_sn++;
+		trace_hfi2_sdma_in_sn(sde, tx->sn);
+#endif
+		list_add_tail(&tx->list, &sde->flushlist);
+		flush_count++;
+		iowait_inc_wait_count(wait, tx->num_desc);
+	}
+	spin_unlock(&sde->flushlist_lock);
+	queue_work_on(sde->cpu, system_highpri_wq, &sde->flush_worker);
+	ret = -ECOMM;
+	goto update_tail;
+nodesc:
+	ret = sdma_check_progress(sde, wait, tx, submit_count > 0);
+	if (ret == -EAGAIN) {
+		ret = 0;
+		goto retry;
+	}
+	sde->descq_full_count++;
+	goto update_tail;
+}
+
+static void sdma_process_event(struct sdma_engine *sde, enum sdma_events event)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sde->tail_lock, flags);
+	write_seqlock(&sde->head_lock);
+
+	__sdma_process_event(sde, event);
+
+	if (sde->state.current_state == sdma_state_s99_running)
+		sdma_desc_avail(sde, sdma_descq_freecnt(sde));
+
+	write_sequnlock(&sde->head_lock);
+	spin_unlock_irqrestore(&sde->tail_lock, flags);
+}
+
+static void __sdma_process_event(struct sdma_engine *sde,
+				 enum sdma_events event)
+{
+	struct sdma_state *ss = &sde->state;
+	int need_progress = 0;
+
+	/* CONFIG SDMA temporary */
+#ifdef CONFIG_SDMA_VERBOSITY
+	dd_dev_err(sde->dd, "CONFIG SDMA(%u) [%s] %s\n", sde->this_idx,
+		   sdma_state_names[ss->current_state],
+		   sdma_event_names[event]);
+#endif
+
+	switch (ss->current_state) {
+	case sdma_state_s00_hw_down:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			break;
+		case sdma_event_e30_go_running:
+			/*
+			 * If down, but running requested (usually result
+			 * of link up, then we need to start up.
+			 * This can happen when hw down is requested while
+			 * bringing the link up with traffic active on
+			 * 7220, e.g.
+			 */
+			ss->go_s99_running = 1;
+			fallthrough;	/* and start dma engine */
+		case sdma_event_e10_go_hw_start:
+			/* This reference means the state machine is started */
+			sdma_get(&sde->state);
+			sdma_set_state(sde,
+				       sdma_state_s10_hw_start_up_halt_wait);
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e40_sw_cleaned:
+			sdma_sw_tear_down(sde);
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			break;
+		case sdma_event_e70_go_idle:
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s10_hw_start_up_halt_wait:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			sdma_sw_tear_down(sde);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			sdma_set_state(sde,
+				       sdma_state_s15_hw_start_up_clean_wait);
+			sdma_start_hw_clean_up(sde);
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			schedule_work(&sde->err_halt_worker);
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s15_hw_start_up_clean_wait:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			sdma_sw_tear_down(sde);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			sdma_hw_start_up(sde);
+			sdma_set_state(sde, ss->go_s99_running ?
+				       sdma_state_s99_running :
+				       sdma_state_s20_idle);
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s20_idle:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			sdma_sw_tear_down(sde);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			sdma_set_state(sde, sdma_state_s99_running);
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			sdma_set_state(sde, sdma_state_s50_hw_halt_wait);
+			schedule_work(&sde->err_halt_worker);
+			break;
+		case sdma_event_e70_go_idle:
+			break;
+		case sdma_event_e85_link_down:
+		case sdma_event_e80_hw_freeze:
+			sdma_set_state(sde, sdma_state_s80_hw_freeze);
+			atomic_dec(&sde->dd->sdma_unfreeze_count);
+			wake_up_interruptible(&sde->dd->sdma_unfreeze_wq);
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s30_sw_clean_up_wait:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			sdma_set_state(sde, sdma_state_s40_hw_clean_up_wait);
+			sdma_start_hw_clean_up(sde);
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s40_hw_clean_up_wait:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			sdma_hw_start_up(sde);
+			sdma_set_state(sde, ss->go_s99_running ?
+				       sdma_state_s99_running :
+				       sdma_state_s20_idle);
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s50_hw_halt_wait:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			sdma_set_state(sde, sdma_state_s30_sw_clean_up_wait);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			schedule_work(&sde->err_halt_worker);
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s60_idle_halt_wait:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			sdma_set_state(sde, sdma_state_s30_sw_clean_up_wait);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			schedule_work(&sde->err_halt_worker);
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s80_hw_freeze:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			sdma_set_state(sde, sdma_state_s82_freeze_sw_clean);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		case sdma_event_e85_link_down:
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s82_freeze_sw_clean:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			ss->go_s99_running = 1;
+			break;
+		case sdma_event_e40_sw_cleaned:
+			/* notify caller this engine is done cleaning */
+			atomic_dec(&sde->dd->sdma_unfreeze_count);
+			wake_up_interruptible(&sde->dd->sdma_unfreeze_wq);
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			break;
+		case sdma_event_e70_go_idle:
+			ss->go_s99_running = 0;
+			break;
+		case sdma_event_e80_hw_freeze:
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			sdma_hw_start_up(sde);
+			sdma_set_state(sde, ss->go_s99_running ?
+				       sdma_state_s99_running :
+				       sdma_state_s20_idle);
+			break;
+		case sdma_event_e85_link_down:
+			break;
+		case sdma_event_e90_sw_halted:
+			break;
+		}
+		break;
+
+	case sdma_state_s99_running:
+		switch (event) {
+		case sdma_event_e00_go_hw_down:
+			sdma_set_state(sde, sdma_state_s00_hw_down);
+			queue_work(sde->dd->hfi2_wq,
+				   &sde->sdma_sw_clean_up_work);
+			break;
+		case sdma_event_e10_go_hw_start:
+			break;
+		case sdma_event_e15_hw_halt_done:
+			break;
+		case sdma_event_e25_hw_clean_up_done:
+			break;
+		case sdma_event_e30_go_running:
+			break;
+		case sdma_event_e40_sw_cleaned:
+			break;
+		case sdma_event_e50_hw_cleaned:
+			break;
+		case sdma_event_e60_hw_halted:
+			need_progress = 1;
+			sdma_err_progress_check_schedule(sde);
+			fallthrough;
+		case sdma_event_e90_sw_halted:
+			/*
+			* SW initiated halt does not perform engines
+			* progress check
+			*/
+			sdma_set_state(sde, sdma_state_s50_hw_halt_wait);
+			schedule_work(&sde->err_halt_worker);
+			break;
+		case sdma_event_e70_go_idle:
+			sdma_set_state(sde, sdma_state_s60_idle_halt_wait);
+			break;
+		case sdma_event_e85_link_down:
+			ss->go_s99_running = 0;
+			fallthrough;
+		case sdma_event_e80_hw_freeze:
+			sdma_set_state(sde, sdma_state_s80_hw_freeze);
+			atomic_dec(&sde->dd->sdma_unfreeze_count);
+			wake_up_interruptible(&sde->dd->sdma_unfreeze_wq);
+			break;
+		case sdma_event_e81_hw_frozen:
+			break;
+		case sdma_event_e82_hw_unfreeze:
+			break;
+		}
+		break;
+	}
+
+	ss->last_event = event;
+	if (need_progress)
+		sdma_make_progress(sde, 0);
+}
+
+/*
+ * _extend_sdma_tx_descs() - helper to extend txreq
+ *
+ * Called when the initial nominal allocation of descriptors in the sdma_txreq
+ * is exhausted.
+ *
+ * The code will bump the allocation up to the max of MAX_DESC (64) descriptors.
+ * There doesn't seem much point in an interim step.  The last descriptor or
+ * two is reserved for coalesce buffer and possible pad in order to support
+ * cases where input packet has >MAX_DESC iovecs.
+ */
+int _extend_sdma_tx_descs(struct hfi2_devdata *dd, struct sdma_txreq *tx)
+{
+	int i;
+	struct sdma_desc *descp;
+
+	descp = kmalloc_array(MAX_DESC, sizeof(struct sdma_desc), GFP_ATOMIC);
+	if (!descp) {
+		__sdma_txclean(dd, tx);
+		return -ENOMEM;
+	}
+	tx->descp = descp;
+	tx->desc_limit = MAX_DESC;
+
+	/* copy ones already built */
+	for (i = 0; i < tx->num_desc; i++)
+		tx->descp[i] = tx->descs[i];
+	return 0;
+}
+
+/*
+ * do_coalesce() - coalesce this tx buffer
+ *
+ * Called when the data in this buffer must be coalesced.
+ *
+ * If needed, create the coalesce buffer.  Copy the current data into the
+ * coalesce buffer.  If this is the last data, dmamap the buffer and add
+ * its descriptor.
+ *
+ * Return:
+ * <0 - error
+ *  0 - success
+ */
+int do_coalesce(struct hfi2_devdata *dd, struct sdma_txreq *tx,
+		int type, void *kvaddr, struct page *page,
+		unsigned long offset, u16 len)
+{
+	int pad_len, rval;
+	dma_addr_t addr;
+
+	if (!tx->coalesce_buf) {
+		/* allocate coalesce buffer with space for padding */
+		tx->coalesce_buf = kmalloc(tx->tlen + sizeof(u32), GFP_ATOMIC);
+		if (!tx->coalesce_buf) {
+			rval = -ENOMEM;
+			goto fail;
+		}
+		tx->coalesce_idx = 0;
+	}
+
+	if (type == SDMA_MAP_NONE) {
+		rval = -EINVAL;
+		goto fail;
+	}
+
+	if (type == SDMA_MAP_PAGE) {
+		kvaddr = kmap_local_page(page);
+		kvaddr += offset;
+	} else if (WARN_ON(!kvaddr)) {
+		rval = -EINVAL;
+		goto fail;
+	}
+
+	memcpy(tx->coalesce_buf + tx->coalesce_idx, kvaddr, len);
+	tx->coalesce_idx += len;
+	if (type == SDMA_MAP_PAGE)
+		kunmap_local(kvaddr);
+
+	/* if there is more data, return */
+	if (tx->tlen != tx->coalesce_idx)
+		return 0;
+
+	/* Whole packet is received; add any padding */
+	pad_len = pad_length(tx);
+	if (pad_len) {
+		memset(tx->coalesce_buf + tx->coalesce_idx, 0, pad_len);
+		/* padding is taken care of for coalescing case */
+		tx->packet_len += pad_len;
+		tx->tlen += pad_len;
+	}
+
+	/* dma map the coalesce buffer */
+	addr = dma_map_single(&dd->pcidev->dev,
+			      tx->coalesce_buf,
+			      tx->tlen,
+			      DMA_TO_DEVICE);
+
+	if (unlikely(dma_mapping_error(&dd->pcidev->dev, addr))) {
+		rval = -ENOSPC;
+		goto fail;
+	}
+
+	return _sdma_txadd_daddr(dd, SDMA_MAP_SINGLE, tx, addr, tx->tlen);
+
+fail:
+	__sdma_txclean(dd, tx);
+	return rval;
+}
+
+/* Update sdes when the lmc changes */
+void sdma_update_lmc(struct hfi2_devdata *dd, u64 mask, u32 lid)
+{
+	struct sdma_engine *sde;
+	int i;
+	u64 sreg;
+
+	/* only WFR has SDMA CHECK registers - skip for all others */
+	if (dd->params->chip_type != CHIP_WFR)
+		return;
+
+	sreg = ((mask & SD(CHECK_SLID_MASK_MASK)) <<
+		SD(CHECK_SLID_MASK_SHIFT)) |
+		(((lid & mask) & SD(CHECK_SLID_VALUE_MASK)) <<
+		SD(CHECK_SLID_VALUE_SHIFT));
+
+	for (i = 0; i < dd->num_sdma; i++) {
+		hfi2_cdbg(LINKVERB, "SendDmaEngine[%d].SLID_CHECK = 0x%x",
+			  i, (u32)sreg);
+		sde = &dd->per_sdma[i];
+		write_sde_csr(sde, SD(CHECK_SLID), sreg);
+	}
+}
+
+/*
+ * Add ahg to the sdma_txreq
+ *
+ * The logic will consume up to 3
+ * descriptors at the beginning of
+ * sdma_txreq.
+ */
+void _sdma_txreq_ahgadd(
+	struct sdma_txreq *tx,
+	u8 num_ahg,
+	u8 ahg_entry,
+	u32 *ahg,
+	u8 ahg_hlen)
+{
+	u32 i, shift = 0, desc = 0;
+	u8 mode;
+
+	WARN_ON_ONCE(num_ahg > 9 || (ahg_hlen & 3) || ahg_hlen == 4);
+	/* compute mode */
+	if (num_ahg == 1)
+		mode = SDMA_AHG_APPLY_UPDATE1;
+	else if (num_ahg <= 5)
+		mode = SDMA_AHG_APPLY_UPDATE2;
+	else
+		mode = SDMA_AHG_APPLY_UPDATE3;
+	tx->num_desc++;
+	/* initialize to consumed descriptors to zero */
+	switch (mode) {
+	case SDMA_AHG_APPLY_UPDATE3:
+		tx->num_desc++;
+		tx->descs[2].qw[0] = 0;
+		tx->descs[2].qw[1] = 0;
+		fallthrough;
+	case SDMA_AHG_APPLY_UPDATE2:
+		tx->num_desc++;
+		tx->descs[1].qw[0] = 0;
+		tx->descs[1].qw[1] = 0;
+		break;
+	}
+	ahg_hlen >>= 2;
+	tx->descs[0].qw[1] |=
+		(((u64)ahg_entry & SDMA_DESC1_HEADER_INDEX_MASK)
+			<< SDMA_DESC1_HEADER_INDEX_SHIFT) |
+		(((u64)ahg_hlen & SDMA_DESC1_HEADER_DWS_MASK)
+			<< SDMA_DESC1_HEADER_DWS_SHIFT) |
+		(((u64)mode & SDMA_DESC1_HEADER_MODE_MASK)
+			<< SDMA_DESC1_HEADER_MODE_SHIFT) |
+		(((u64)ahg[0] & SDMA_DESC1_HEADER_UPDATE1_MASK)
+			<< SDMA_DESC1_HEADER_UPDATE1_SHIFT);
+	for (i = 0; i < (num_ahg - 1); i++) {
+		if (!shift && !(i & 2))
+			desc++;
+		tx->descs[desc].qw[!!(i & 2)] |=
+			(((u64)ahg[i + 1])
+				<< shift);
+		shift = (shift + 32) & 63;
+	}
+}
+
+/**
+ * sdma_ahg_alloc - allocate an AHG entry
+ * @sde: engine to allocate from
+ *
+ * Return:
+ * 0-31 when successful, -EOPNOTSUPP if AHG is not enabled,
+ * -ENOSPC if an entry is not available
+ */
+int sdma_ahg_alloc(struct sdma_engine *sde)
+{
+	int nr;
+	int oldbit;
+
+	if (!sde) {
+		trace_hfi2_ahg_allocate(sde, -EINVAL);
+		return -EINVAL;
+	}
+	while (1) {
+		nr = ffz(READ_ONCE(sde->ahg_bits));
+		if (nr > 31) {
+			trace_hfi2_ahg_allocate(sde, -ENOSPC);
+			return -ENOSPC;
+		}
+		oldbit = test_and_set_bit(nr, &sde->ahg_bits);
+		if (!oldbit)
+			break;
+		cpu_relax();
+	}
+	trace_hfi2_ahg_allocate(sde, nr);
+	return nr;
+}
+
+/**
+ * sdma_ahg_free - free an AHG entry
+ * @sde: engine to return AHG entry
+ * @ahg_index: index to free
+ *
+ * This routine frees the indicate AHG entry.
+ */
+void sdma_ahg_free(struct sdma_engine *sde, int ahg_index)
+{
+	if (!sde)
+		return;
+	trace_hfi2_ahg_deallocate(sde, ahg_index);
+	if (ahg_index < 0 || ahg_index > 31)
+		return;
+	clear_bit(ahg_index, &sde->ahg_bits);
+}
+
+/*
+ * SPC freeze handling for SDMA engines.  Called when the driver knows
+ * the SPC is going into a freeze but before the freeze is fully
+ * settled.  Generally an error interrupt.
+ *
+ * This event will pull the engine out of running so no more entries can be
+ * added to the engine's queue.
+ */
+void sdma_freeze_notify(struct hfi2_devdata *dd, int link_down)
+{
+	int i;
+	enum sdma_events event = link_down ? sdma_event_e85_link_down :
+					     sdma_event_e80_hw_freeze;
+
+	/* set up the wait but do not wait here */
+	atomic_set(&dd->sdma_unfreeze_count, dd->num_sdma);
+
+	/* tell all engines to stop running and wait */
+	for (i = 0; i < dd->num_sdma; i++)
+		sdma_process_event(&dd->per_sdma[i], event);
+
+	/* sdma_freeze() will wait for all engines to have stopped */
+}
+
+/*
+ * SPC freeze handling for SDMA engines.  Called when the driver knows
+ * the SPC is fully frozen.
+ */
+void sdma_freeze(struct hfi2_devdata *dd)
+{
+	int i;
+	int ret;
+
+	/*
+	 * Make sure all engines have moved out of the running state before
+	 * continuing.
+	 */
+	ret = wait_event_interruptible(dd->sdma_unfreeze_wq,
+				       atomic_read(&dd->sdma_unfreeze_count) <=
+				       0);
+	/* interrupted or count is negative, then unloading - just exit */
+	if (ret || atomic_read(&dd->sdma_unfreeze_count) < 0)
+		return;
+
+	/* set up the count for the next wait */
+	atomic_set(&dd->sdma_unfreeze_count, dd->num_sdma);
+
+	/* tell all engines that the SPC is frozen, they can start cleaning */
+	for (i = 0; i < dd->num_sdma; i++)
+		sdma_process_event(&dd->per_sdma[i], sdma_event_e81_hw_frozen);
+
+	/*
+	 * Wait for everyone to finish software clean before exiting.  The
+	 * software clean will read engine CSRs, so must be completed before
+	 * the next step, which will clear the engine CSRs.
+	 */
+	(void)wait_event_interruptible(dd->sdma_unfreeze_wq,
+				atomic_read(&dd->sdma_unfreeze_count) <= 0);
+	/* no need to check results - done no matter what */
+}
+
+/*
+ * SPC freeze handling for the SDMA engines.  Called after the SPC is unfrozen.
+ *
+ * The SPC freeze acts like a SDMA halt and a hardware clean combined.  All
+ * that is left is a software clean.  We could do it after the SPC is fully
+ * frozen, but then we'd have to add another state to wait for the unfreeze.
+ * Instead, just defer the software clean until the unfreeze step.
+ */
+void sdma_unfreeze(struct hfi2_devdata *dd)
+{
+	int i;
+
+	/* tell all engines start freeze clean up */
+	for (i = 0; i < dd->num_sdma; i++)
+		sdma_process_event(&dd->per_sdma[i],
+				   sdma_event_e82_hw_unfreeze);
+}
+
+/**
+ * _sdma_engine_progress_schedule() - schedule progress on engine
+ * @sde: sdma_engine to schedule progress
+ */
+void _sdma_engine_progress_schedule(struct sdma_engine *sde)
+{
+	trace_hfi2_sdma_engine_progress(sde, sde->progress_mask);
+	/* assume we have selected a good cpu */
+	write_csr(sde->dd,
+		  CCE_INT_FORCE + (8 * (sde->dd->params->is_sdma_start / 64)),
+		  sde->progress_mask);
+}
+
+/*
+ * Wait for the given bit to be set in the SendDmaStatus register.
+ *
+ * Return:
+ *   0          success
+ *   -ETIMEDOUT fail
+ */
+static int wait_for_engine_bit(struct hfi2_devdata *dd, u32 engine, u64 bit,
+			       u32 mstimeout)
+{
+	unsigned long timeout;
+	u64 status;
+
+	timeout = jiffies + msecs_to_jiffies(mstimeout);
+	while (1) {
+		usleep_range(80, 120);
+		status = read_sdma_csr(dd, engine,
+				       dd->params->send_dma_status_reg);
+		if (status & bit)
+			return 0;
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
+	}
+}
+
+static void engine_disable(struct hfi2_devdata *dd, u32 engine)
+{
+	write_sdma_csr(dd, engine, dd->params->send_dma_ctrl_reg, 0);
+}
+
+/* expects engine is disabled */
+static void engine_halt(struct hfi2_devdata *dd, u32 engine)
+{
+	u64 status;
+	int ret;
+
+	/* halt only if needed */
+	status = read_sdma_csr(dd, engine, dd->params->send_dma_status_reg);
+	if (status & SD(STATUS_ENG_HALTED_SMASK))
+		return;
+
+	write_sdma_csr(dd, engine, dd->params->send_dma_ctrl_reg,
+		       SD(CTRL_SDMA_HALT_SMASK));
+	ret = wait_for_engine_bit(dd, engine, SD(STATUS_ENG_HALTED_SMASK), 100);
+	if (ret)
+		dd_dev_err(dd, "%s: engine %d did not halt\n", __func__, engine);
+}
+
+/* expects engine is disabled */
+static void engine_cleanup(struct hfi2_devdata *dd, u32 engine)
+{
+	u64 status;
+	int ret;
+
+	/* cleanup only if needed */
+	status = read_sdma_csr(dd, engine, dd->params->send_dma_status_reg);
+	if (status & SD(STATUS_ENG_CLEANED_UP_SMASK))
+		return;
+
+	write_sdma_csr(dd, engine, dd->params->send_dma_ctrl_reg,
+		       SD(CTRL_SDMA_CLEANUP_SMASK));
+	ret = wait_for_engine_bit(dd, engine, SD(STATUS_ENG_CLEANED_UP_SMASK), 100);
+	if (ret)
+		dd_dev_err(dd, "%s: engine %d did not clean up\n", __func__, engine);
+}
+
+static void engine_enable(struct hfi2_devdata *dd, u32 engine)
+{
+	write_sdma_csr(dd, engine, dd->params->send_dma_ctrl_reg,
+		       SD(CTRL_SDMA_ENABLE_SMASK));
+}
+
+/*
+ * Write to each JKR SDMA memory
+ *
+ * Expect:
+ *   o Interrupts are masked.
+ *   o SDMA engines are not set up for main driver use.
+ *
+ * Return:
+ *   o 0      success
+ *   o -errno failure
+ */
+static int prime_sdma_memories(struct hfi2_devdata *dd)
+{
+	const u32 engine = 0;
+	/* data */
+	const u32 num_desc = 64; /* in multiples of 64 */
+	const u32 data_size = 8; /* in bytes */
+	const u32 desc_size = sizeof(struct hw_sdma_desc) * num_desc;
+	const u32 buf_size = desc_size + data_size;
+	/* memories */
+	const u32 num_memories = 16;
+	const u32 num_banks = 4;
+	const u32 bank_size = 784 * 8;	/* bytes */
+	const u32 mem_size = num_banks * bank_size;
+	const u32 num_credits = bank_size / SDMA_BLOCK_SIZE;
+	/* variables */
+	unsigned long timeout;
+	dma_addr_t buf_phys;
+	dma_addr_t desc_phys;
+	dma_addr_t data_phys;
+	void *buf_addr;
+	struct hw_sdma_desc *desc_addr;
+	void *data_addr;
+	u64 status;
+	u64 value;
+	u64 qw0, qw1;
+	u32 mem;
+	u32 bank;
+	u32 start;
+
+	/* only for JKR */
+	if (dd->params->chip_type != CHIP_JKR)
+		return 0;
+	if (!enable_jkr_sdma_mem_init) {
+		dd_dev_info(dd, "SKIPPING Write JKR SDMA memories\n");
+		return 0;
+	}
+	dd_dev_info(dd, "Write JKR SDMA memories\n");
+
+	/*
+	 * Set up memory
+	 */
+	/* allocate dma memory */
+	buf_addr = dma_alloc_coherent(&dd->pcidev->dev, buf_size, &buf_phys,
+				      GFP_KERNEL);
+	if (!buf_addr)
+		return -EIO;
+	memset(buf_addr, 0, buf_size);
+
+	/* assign DMA buffer: desc, then data */
+	desc_addr = buf_addr;
+	desc_phys = buf_phys;
+	data_addr = buf_addr + desc_size;
+	data_phys = buf_phys + desc_size;
+
+	/* create bad packet: leave as zero, size is 8 */
+
+	/*
+	 * Set up engine
+	 */
+	/* mask all errors */
+	write_sdma_csr(dd, engine, dd->params->send_dma_eng_err_mask_reg, 0);
+
+	/* disable, halt, and clean in case anything is lingering */
+	engine_disable(dd, engine);
+	engine_halt(dd, engine);
+	engine_cleanup(dd, engine);
+
+	/* descriptor address */
+	write_sdma_csr(dd, engine, dd->params->send_dma_base_addr_reg, desc_phys);
+	/* no idle countdown */
+	write_sdma_csr(dd, engine, dd->params->send_dma_reload_cnt_reg, 0);
+	/* no progress countdown */
+	write_sdma_csr(dd, engine, dd->params->send_dma_desc_cnt_reg, 0);
+	/* no head dma address */
+	write_sdma_csr(dd, engine, dd->params->send_dma_head_addr_reg, 0);
+
+	/*
+	 * Loop over memories
+	 *
+	 * Expect engine is cleaned up at top of loop.
+	 */
+	for (mem = 0; mem < num_memories; mem++) {
+		for (bank = 0; bank < num_banks; bank++) {
+			/* set fetch destination */
+			start = ((mem * mem_size) + (bank * bank_size)) /
+				SDMA_BLOCK_SIZE;
+			value = ((u64)num_credits <<
+					SD(MEMORY_SDMA_MEMORY_CNT_SHIFT)) |
+				((u64)start <<
+					SD(MEMORY_SDMA_MEMORY_INDEX_SHIFT));
+			write_sdmacfg_csr(dd, engine,
+					  dd->params->send_dma_cfg_memory_reg,
+					  value);
+			/* set descriptor length, disable generation counter */
+			write_sdma_csr(dd, engine, dd->params->send_dma_len_gen_reg,
+				       (num_desc / 64) << SD(LEN_GEN_LENGTH_SHIFT));
+
+			/* zero descriptors */
+			memset(desc_addr, 0, desc_size);
+
+			/* enable engine */
+			engine_enable(dd, engine);
+
+			/*
+			 * Do send
+			 */
+			/*
+			 * step: create descriptor
+			 *   no ahg, no generation, no interrupt request,
+			 *   no host writes
+			 */
+			qw0 = data_phys;
+			qw1 =   JKR_SDMA_DESC1_FIRST_DESC_FLAG
+			      | JKR_SDMA_DESC1_LAST_DESC_FLAG
+			      | data_size << JKR_SDMA_DESC1_BYTE_COUNT_SHIFT;
+
+			/*
+			 * step: write descriptor
+			 *   expect index 0 from engine cleanup
+			 */
+			desc_addr->qw[0] = cpu_to_le64(qw0);
+			desc_addr->qw[1] = cpu_to_le64(qw1);
+
+			/*
+			 * step: start engine by updating tail to index 1
+			 */
+			smp_wmb(); /* commit previous writes to memory */
+			write_sdma_csr(dd, engine, dd->params->send_dma_tail_reg, 1);
+
+			/*
+			 * step: wait for error halt
+			 */
+			timeout = jiffies + msecs_to_jiffies(500);
+			while (1) {
+				usleep_range(80, 120);
+				status = read_sdma_csr(dd, engine, dd->params->send_dma_status_reg);
+				if (status & SD(STATUS_ENG_HALTED_SMASK))
+					break;
+
+				if (time_after(jiffies, timeout)) {
+					dd_dev_warn(dd, "%s: [%2d,%d] timeout waiting for halt\n",
+						    __func__, mem, bank);
+					break;
+				}
+			}
+
+			/* disable, halt, and clean up */
+			engine_disable(dd, engine);
+			engine_halt(dd, engine);
+			engine_cleanup(dd, engine);
+		}
+	}
+
+	/*
+	 * Clean up
+	 */
+	write_sdma_csr(dd, engine, dd->params->send_dma_base_addr_reg, 0);
+	write_sdmacfg_csr(dd, engine, dd->params->send_dma_cfg_memory_reg, 0);
+	write_sdma_csr(dd, engine, dd->params->send_dma_eng_err_clear_reg, ~0ull);
+
+	/* free dma memory */
+	dma_free_coherent(&dd->pcidev->dev, buf_size, buf_addr, buf_phys);
+	return 0;
+}
diff --git a/drivers/infiniband/hw/hfi2/tid_system.c b/drivers/infiniband/hw/hfi2/tid_system.c
new file mode 100644
index 000000000000..dd320a607a2d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/tid_system.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause
+/*
+ * Copyright(c) 2020-2024 Cornelis Networks, Inc.
+ * Copyright(c) 2015-2018 Intel Corporation.
+ */
+#include "user_exp_rcv.h"
+
+/*
+ * Host memory TID implementation.
+ */
+struct system_tid_user_buf {
+	struct tid_user_buf common;
+	struct mmu_interval_notifier notifier;
+	/*
+	 * cover_mutex serializes mmu_interval_read_retry() and
+	 * mmu_interval_set_seq() on notifier
+	 */
+	struct mutex cover_mutex;
+	unsigned int npages;
+	struct page **pages;
+	long mmu_seq;
+};
+
+struct system_tid_node {
+	struct tid_rb_node common;
+	struct mmu_interval_notifier notifier;
+	struct page *pages[];
+};
+
+static bool sys_tid_invalidate(struct mmu_interval_notifier *mni,
+			       const struct mmu_notifier_range *range,
+			       unsigned long cur_seq);
+
+static bool sys_cover_invalidate(struct mmu_interval_notifier *mni,
+				 const struct mmu_notifier_range *range,
+				 unsigned long cur_seq);
+
+/*
+ * Still takes a tid_user_buf, not system_tid_user_buf since
+ * this may be called through interface in addition to internally.
+ */
+static void sys_user_buf_free(struct tid_user_buf *tbuf);
+
+static const struct mmu_interval_notifier_ops tid_mn_ops = {
+	.invalidate = sys_tid_invalidate,
+};
+
+static const struct mmu_interval_notifier_ops tid_cover_ops = {
+	.invalidate = sys_cover_invalidate,
+};
+
+static inline int num_user_pages(unsigned long addr,
+				 unsigned long len)
+{
+	const unsigned long spage = addr & PAGE_MASK;
+	const unsigned long epage = (addr + len - 1) & PAGE_MASK;
+
+	return 1 + ((epage - spage) >> PAGE_SHIFT);
+}
+
+static inline struct mm_struct *mm_from_tid_node(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+
+	return snode->notifier.mm;
+}
+
+static bool sys_tid_invalidate(struct mmu_interval_notifier *mni,
+			       const struct mmu_notifier_range *range,
+			       unsigned long cur_seq)
+{
+	struct system_tid_node *node =
+		container_of(mni, struct system_tid_node, notifier);
+
+	if (node->common.freed)
+		return true;
+
+	/* take action only if unmapping */
+	if (range->event != MMU_NOTIFY_UNMAP)
+		return true;
+
+	hfi2_user_exp_rcv_invalidate(&node->common);
+
+	return true;
+}
+
+static int sys_node_register_notify(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+	const u32 length = node->npages * (1 << node->page_shift);
+
+	return mmu_interval_notifier_insert(&snode->notifier, current->mm,
+					    node->vaddr, length,
+					    &tid_mn_ops);
+}
+
+static void sys_node_unregister_notify(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+
+	if (snode->common.use_mn)
+		mmu_interval_notifier_remove(&snode->notifier);
+}
+
+static void sys_node_dma_unmap(struct tid_rb_node *node)
+{
+	struct hfi2_devdata *dd = node->fdata->uctxt->dd;
+
+	dma_unmap_single(&dd->pcidev->dev, node->dma_addr, node->npages * PAGE_SIZE,
+			 DMA_FROM_DEVICE);
+}
+
+/*
+ * Release pinned receive buffer pages.
+ */
+static void sys_node_unpin_pages(struct hfi2_filedata *fd,
+				 struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+	struct page **pages;
+	struct hfi2_devdata *dd = fd->uctxt->dd;
+	struct mm_struct *mm;
+
+	dma_unmap_single(&dd->pcidev->dev, node->dma_addr,
+			 node->npages * PAGE_SIZE, DMA_FROM_DEVICE);
+	pages = &snode->pages[0];
+	mm = mm_from_tid_node(node);
+	hfi2_release_user_pages(mm, pages, node->npages, true);
+	fd->tid_n_pinned -= node->npages;
+}
+
+static struct tid_node_ops sys_nodeops;
+
+static struct tid_rb_node *sys_node_init(struct hfi2_filedata *fd,
+					 struct tid_user_buf *tbuf,
+					 u32 rcventry,
+					 struct tid_group *grp,
+					 struct hfi2_page_iter *piter)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+	struct page_array_iter *iter =
+		container_of(piter, struct page_array_iter, common);
+	struct hfi2_devdata *dd = fd->uctxt->dd;
+	struct system_tid_node *snode;
+	unsigned int npages;
+	struct page **pages;
+	dma_addr_t phys;
+	u16 pageidx;
+
+	if (iter->setidx >= tbuf->n_psets)
+		return ERR_PTR(-EINVAL);
+
+	npages = tbuf->psets[iter->setidx].count;
+	pageidx = tbuf->psets[iter->setidx].idx;
+	pages = sbuf->pages + pageidx;
+
+	if (!npages)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Allocate snode first so we can handle a potential failure before
+	 * we've programmed anything.
+	 */
+	snode = kzalloc(struct_size(snode, pages, npages), GFP_KERNEL);
+	if (!snode)
+		return ERR_PTR(-ENOMEM);
+
+	phys = dma_map_single(&dd->pcidev->dev, __va(page_to_phys(pages[0])),
+			      npages * PAGE_SIZE, DMA_FROM_DEVICE);
+	if (dma_mapping_error(&dd->pcidev->dev, phys)) {
+		dd_dev_err(dd, "Failed to DMA map Exp Rcv pages 0x%llx\n",
+			   phys);
+		kfree(snode);
+		return ERR_PTR(-EFAULT);
+	}
+
+	snode->common.fdata = fd;
+	mutex_init(&snode->common.invalidate_mutex);
+	snode->common.phys = page_to_phys(pages[0]);
+	snode->common.npages = npages;
+	snode->common.page_shift = PAGE_SHIFT;
+	snode->common.rcventry = rcventry;
+	snode->common.dma_addr = phys;
+	snode->common.vaddr = tbuf->vaddr + (pageidx * PAGE_SIZE);
+	snode->common.grp = grp;
+	snode->common.freed = false;
+	snode->common.ops = &sys_nodeops;
+	snode->common.use_mn = fd->use_mn;
+	snode->common.type = HFI2_MEMINFO_TYPE_SYSTEM;
+	memcpy(snode->pages, pages, flex_array_size(snode, pages, npages));
+
+	return &snode->common;
+}
+
+static void sys_node_free(struct tid_rb_node *node)
+{
+	struct system_tid_node *snode =
+		container_of(node, struct system_tid_node, common);
+
+	kfree(snode);
+}
+
+static struct tid_node_ops sys_nodeops = {
+	.init = sys_node_init,
+	.free = sys_node_free,
+	.register_notify = sys_node_register_notify,
+	.unregister_notify = sys_node_unregister_notify,
+	.dma_unmap = sys_node_dma_unmap,
+	.unpin_pages = sys_node_unpin_pages,
+};
+
+static unsigned int sys_page_size(struct tid_user_buf *tbuf)
+{
+	return PAGE_SIZE;
+}
+
+/*
+ * Invalidation during insertion callback.
+ */
+static bool sys_cover_invalidate(struct mmu_interval_notifier *mni,
+				 const struct mmu_notifier_range *range,
+				 unsigned long cur_seq)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(mni, struct system_tid_user_buf, notifier);
+
+	/* take action only if unmapping */
+	if (range->event == MMU_NOTIFY_UNMAP) {
+		mutex_lock(&sbuf->cover_mutex);
+		mmu_interval_set_seq(mni, cur_seq);
+		mutex_unlock(&sbuf->cover_mutex);
+	}
+
+	return true;
+}
+
+static struct tid_user_buf_ops sys_bufops;
+
+/*
+ * System memory never honors @allow_unaligned.
+ */
+static int sys_user_buf_init(u16 expected_count, bool notify,
+			     unsigned long vaddr, unsigned long length,
+			     bool allow_unaligned,
+			     struct tid_user_buf **tbuf)
+{
+	struct system_tid_user_buf *sbuf;
+	int ret;
+
+	if (!IS_ALIGNED(vaddr, max(EXP_TID_ADDR_SIZE, PAGE_SIZE)))
+		return -EINVAL;
+
+	sbuf = kzalloc(sizeof(*sbuf), GFP_KERNEL);
+	if (!sbuf)
+		return -ENOMEM;
+	*tbuf = &sbuf->common;
+	mutex_init(&sbuf->cover_mutex);
+
+	ret = tid_user_buf_init(expected_count, vaddr, length, notify, &sys_bufops,
+				HFI2_MEMINFO_TYPE_SYSTEM, *tbuf);
+	if (ret)
+		goto fail_release_mem;
+
+	sbuf->npages = num_user_pages(vaddr, length);
+
+	return 0;
+fail_release_mem:
+	sys_user_buf_free(&sbuf->common);
+	return ret;
+}
+
+static void sys_user_buf_free(struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+
+	kfree(sbuf->pages);
+	tid_user_buf_free(tbuf);
+	kfree(sbuf);
+}
+
+/*
+ * Pin receive buffer pages.
+ */
+static int pin_rcv_pages(struct hfi2_filedata *fd, struct system_tid_user_buf *sbuf)
+{
+	int pinned;
+	unsigned int npages = sbuf->npages;
+	unsigned long vaddr = sbuf->common.vaddr;
+	struct page **pages = NULL;
+	struct hfi2_devdata *dd = fd->uctxt->dd;
+
+	if (npages > fd->uctxt->expected_count) {
+		dd_dev_err(dd, "Expected buffer too big\n");
+		return -EINVAL;
+	}
+
+	/* Allocate the array of struct page pointers needed for pinning */
+	pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	/*
+	 * Pin all the pages of the user buffer. If we can't pin all the
+	 * pages, accept the amount pinned so far and program only that.
+	 * User space knows how to deal with partially programmed buffers.
+	 */
+	if (!hfi2_can_pin_pages(dd, current->mm, fd->tid_n_pinned, npages)) {
+		kfree(pages);
+		return -ENOMEM;
+	}
+
+	pinned = hfi2_acquire_user_pages(current->mm, vaddr, npages, true, pages);
+	if (pinned <= 0) {
+		kfree(pages);
+		return pinned;
+	}
+	sbuf->pages = pages;
+	fd->tid_n_pinned += pinned;
+	return pinned;
+}
+
+static int sys_pin_pages(struct hfi2_filedata *fd, struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+
+	if (WARN_ON(fd->use_mn != tbuf->use_mn))
+		return -EINVAL;
+
+	if (tbuf->use_mn) {
+		int ret;
+
+		ret = mmu_interval_notifier_insert(&sbuf->notifier, current->mm, tbuf->vaddr,
+						   sbuf->npages * PAGE_SIZE, &tid_cover_ops);
+		if (ret)
+			return ret;
+		sbuf->mmu_seq = mmu_interval_read_begin(&sbuf->notifier);
+	}
+
+	return pin_rcv_pages(fd, sbuf);
+}
+
+static void sys_unpin_pages(struct hfi2_filedata *fd,
+			    struct tid_user_buf *tbuf,
+			    unsigned int idx,
+			    unsigned int npages)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+	struct page **pages;
+	struct mm_struct *mm;
+
+	pages = &sbuf->pages[idx];
+	mm = current->mm;
+	hfi2_release_user_pages(mm, pages, npages, false);
+	fd->tid_n_pinned -= npages;
+}
+
+static int sys_find_phys_blocks(struct tid_user_buf *tidbuf, unsigned int npages)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tidbuf, struct system_tid_user_buf, common);
+	unsigned int pagecount, pageidx, setcount = 0, i;
+	unsigned long pfn, this_pfn;
+	struct page **pages = sbuf->pages;
+	struct tid_pageset *list = tidbuf->psets;
+
+	if (!npages)
+		return -EINVAL;
+
+	/*
+	 * Look for sets of physically contiguous pages in the user buffer.
+	 * This will allow us to optimize Expected RcvArray entry usage by
+	 * using the bigger supported sizes.
+	 */
+	pfn = page_to_pfn(pages[0]);
+	for (pageidx = 0, pagecount = 1, i = 1; i <= npages; i++) {
+		this_pfn = i < npages ? page_to_pfn(pages[i]) : 0;
+
+		/*
+		 * If the pfn's are not sequential, pages are not physically
+		 * contiguous.
+		 */
+		if (this_pfn != ++pfn) {
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
+				pagecount -= maxpages;
+				pageidx += maxpages;
+				setcount++;
+			}
+			pageidx = i;
+			pagecount = 1;
+			pfn = this_pfn;
+		} else {
+			pagecount++;
+		}
+	}
+	tidbuf->n_psets = setcount;
+	return 0;
+}
+
+static bool sys_invalidated(struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+	bool ret = false;
+
+	if (!tbuf->use_mn)
+		return false;
+
+	mutex_lock(&sbuf->cover_mutex);
+	ret = mmu_interval_read_retry(&sbuf->notifier, sbuf->mmu_seq);
+	mutex_unlock(&sbuf->cover_mutex);
+	return ret;
+}
+
+static void sys_unnotify(struct tid_user_buf *tbuf)
+{
+	struct system_tid_user_buf *sbuf =
+		container_of(tbuf, struct system_tid_user_buf, common);
+
+	if (tbuf->use_mn)
+		mmu_interval_notifier_remove(&sbuf->notifier);
+}
+
+static struct tid_user_buf_ops sys_bufops = {
+	.init = sys_user_buf_init,
+	.free = sys_user_buf_free,
+	.pin_pages = sys_pin_pages,
+	.page_size = sys_page_size,
+	.unpin_pages = sys_unpin_pages,
+	.find_phys_blocks = sys_find_phys_blocks,
+	.invalidated = sys_invalidated,
+	.unnotify = sys_unnotify,
+};
+
+int register_system_tid_ops(void)
+{
+	return register_tid_ops(HFI2_MEMINFO_TYPE_SYSTEM, &sys_bufops, &sys_nodeops);
+}
+
+void deregister_system_tid_ops(void)
+{
+	deregister_tid_ops(HFI2_MEMINFO_TYPE_SYSTEM);
+}
diff --git a/drivers/infiniband/hw/hfi2/user_exp_rcv.c b/drivers/infiniband/hw/hfi2/user_exp_rcv.c
new file mode 100644
index 000000000000..d8b27977ed65
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_exp_rcv.c
@@ -0,0 +1,1012 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2020-2024 Cornelis Networks, Inc.
+ * Copyright(c) 2015-2018 Intel Corporation.
+ */
+#include <asm/page.h>
+#include <linux/string.h>
+
+#include "mmu_rb.h"
+#include "user_exp_rcv.h"
+#include "trace.h"
+
+static void unlock_exp_tids(struct hfi2_ctxtdata *uctxt,
+			    struct exp_tid_set *set,
+			    struct hfi2_filedata *fd);
+static void cacheless_tid_rb_remove(struct hfi2_filedata *fdata,
+				    struct tid_rb_node *tnode);
+static int program_rcvarray(struct hfi2_filedata *fd,
+			    struct tid_user_buf *tbuf,
+			    struct tid_group *grp, u16 count,
+			    u32 *tidlist, unsigned int *tididx,
+			    struct hfi2_page_iter *iter,
+			    unsigned int *pmapped);
+static int unprogram_rcvarray(struct hfi2_filedata *fd, u32 tidinfo);
+static void __clear_tid_node(struct hfi2_filedata *fd,
+			     struct tid_rb_node *node);
+static void clear_tid_node(struct hfi2_filedata *fd, struct tid_rb_node *node);
+
+/*
+ * Initialize context and file private data needed for Expected
+ * receive caching. This needs to be done after the context has
+ * been configured with the eager/expected RcvEntry counts.
+ */
+int hfi2_user_exp_rcv_init(struct hfi2_filedata *fd,
+			   struct hfi2_ctxtdata *uctxt)
+{
+	int ret = 0;
+
+	fd->entry_to_rb = kcalloc(uctxt->expected_count,
+				  sizeof(struct rb_node *),
+				  GFP_KERNEL);
+	if (!fd->entry_to_rb)
+		return -ENOMEM;
+
+	if (!HFI2_CAP_UGET_MASK(uctxt->flags, TID_UNMAP)) {
+		fd->invalid_tid_idx = 0;
+		fd->invalid_tids = kcalloc(uctxt->expected_count,
+					   sizeof(*fd->invalid_tids),
+					   GFP_KERNEL);
+		if (!fd->invalid_tids) {
+			kfree(fd->entry_to_rb);
+			fd->entry_to_rb = NULL;
+			return -ENOMEM;
+		}
+		fd->use_mn = true;
+	}
+
+	/*
+	 * PSM does not have a good way to separate, count, and
+	 * effectively enforce a limit on RcvArray entries used by
+	 * subctxts (when context sharing is used) when TID caching
+	 * is enabled. To help with that, we calculate a per-process
+	 * RcvArray entry share and enforce that.
+	 * If TID caching is not in use, PSM deals with usage on its
+	 * own. In that case, we allow any subctxt to take all of the
+	 * entries.
+	 *
+	 * Make sure that we set the tid counts only after successful
+	 * init.
+	 */
+	spin_lock(&fd->tid_lock);
+	if (uctxt->subctxt_cnt && fd->use_mn) {
+		u16 remainder;
+
+		fd->tid_limit = uctxt->expected_count / uctxt->subctxt_cnt;
+		remainder = uctxt->expected_count % uctxt->subctxt_cnt;
+		if (remainder && fd->subctxt < remainder)
+			fd->tid_limit++;
+	} else {
+		fd->tid_limit = uctxt->expected_count;
+	}
+	spin_unlock(&fd->tid_lock);
+
+	return ret;
+}
+
+void hfi2_user_exp_rcv_free(struct hfi2_filedata *fd)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	mutex_lock(&uctxt->exp_mutex);
+	if (!EXP_TID_SET_EMPTY(uctxt->tid_full_list))
+		unlock_exp_tids(uctxt, &uctxt->tid_full_list, fd);
+	if (!EXP_TID_SET_EMPTY(uctxt->tid_used_list))
+		unlock_exp_tids(uctxt, &uctxt->tid_used_list, fd);
+	mutex_unlock(&uctxt->exp_mutex);
+
+	kfree(fd->invalid_tids);
+	fd->invalid_tids = NULL;
+
+	kfree(fd->entry_to_rb);
+	fd->entry_to_rb = NULL;
+}
+
+static struct tid_user_buf_ops *bufops[HFI2_MAX_MEMINFO_ENTRIES];
+static struct tid_node_ops *nodeops[HFI2_MAX_MEMINFO_ENTRIES];
+
+/**
+ * Register TID memory-pinning implementation for @type memory.
+ *
+ * @type one of the HFI2_MEMINFO_TYPE* defines found in hfi2_ioctl.h
+ * @op Buffer ops to register
+ * @nops Node ops to register
+ *
+ * @return 0 on success, non-zero on error
+ */
+int register_tid_ops(u16 type, struct tid_user_buf_ops *op, struct tid_node_ops *nops)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return -EINVAL;
+	bufops[type] = op;
+	nodeops[type] = nops;
+	return 0;
+}
+
+void deregister_tid_ops(u16 type)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return;
+	bufops[type] = NULL;
+	nodeops[type] = NULL;
+}
+
+static struct tid_user_buf_ops *get_bufops(u16 type)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return NULL;
+	return bufops[type];
+}
+
+static struct tid_node_ops *get_nodeops(u16 type)
+{
+	if (type >= HFI2_MAX_MEMINFO_ENTRIES)
+		return NULL;
+	return nodeops[type];
+}
+
+int tid_user_buf_init(u16 pset_size, unsigned long vaddr, unsigned long length, bool notify,
+		      struct tid_user_buf_ops *ops, u16 type, struct tid_user_buf *tbuf)
+{
+	tbuf->vaddr = vaddr;
+	tbuf->length = length;
+	tbuf->use_mn = notify;
+	tbuf->psets = kcalloc(pset_size, sizeof(*tbuf->psets), GFP_KERNEL);
+	if (!tbuf->psets)
+		return -ENOMEM;
+	tbuf->ops = ops;
+	tbuf->type = type;
+	return 0;
+}
+
+void tid_user_buf_free(struct tid_user_buf *tbuf)
+{
+	kfree(tbuf->psets);
+	tbuf->psets = NULL;
+}
+
+/**
+ * Create user buf for @memtype, store at @*ubuf
+ *
+ * @return 0 on success, non-zero on failure.
+ */
+static int create_user_buf(struct hfi2_filedata *fd, u16 memtype, struct hfi2_tid_info *tinfo,
+			   bool allow_unaligned, struct tid_user_buf **ubuf)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct tid_user_buf_ops *ops;
+	int ret;
+
+	ops = get_bufops(memtype);
+	if (!ops)
+		return -EINVAL;
+
+	if (tinfo->length == 0)
+		return -EINVAL;
+
+	ret = ops->init(uctxt->expected_count, fd->use_mn, tinfo->vaddr,
+			tinfo->length, allow_unaligned, ubuf);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int page_array_iter_next(struct hfi2_page_iter *piter)
+{
+	struct page_array_iter *iter =
+		container_of(piter, struct page_array_iter, common);
+
+	if (!iter->tbuf->psets || !iter->tbuf->n_psets)
+		return -EINVAL;
+
+	iter->setidx++;
+
+	return (iter->setidx < iter->tbuf->n_psets);
+}
+
+static void page_array_iter_free(struct hfi2_page_iter *piter)
+{
+	struct page_array_iter *iter =
+		container_of(piter, struct page_array_iter, common);
+
+	kfree(iter);
+}
+
+static struct hfi2_page_iter_ops page_array_iter_ops = {
+	.next = page_array_iter_next,
+	.free = page_array_iter_free
+};
+
+static struct hfi2_page_iter *tid_user_buf_iter_begin(struct tid_user_buf *tbuf)
+{
+	struct page_array_iter *iter;
+
+	if (!tbuf->psets || !tbuf->n_psets)
+		return ERR_PTR(-EINVAL);
+
+	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
+	if (!iter)
+		return ERR_PTR(-ENOMEM);
+
+	iter->common.ops = &page_array_iter_ops;
+	iter->tbuf = tbuf;
+
+	return &iter->common;
+}
+
+static struct hfi2_page_iter *create_dma_iter(struct tid_user_buf *tbuf)
+{
+	if (tbuf->ops->iter_begin)
+		return tbuf->ops->iter_begin(tbuf);
+
+	return tid_user_buf_iter_begin(tbuf);
+}
+
+/*
+ * Get number of TID-ready pinned-pagesets for @tbuf using hfi2_page_iter.
+ *
+ * @return >= 0 for number of pagesets, < 0 on error.
+ */
+static int pagesets_iter(struct tid_user_buf *tbuf, int cap)
+{
+	struct hfi2_page_iter *iter;
+	int p = 0;
+	int ret;
+
+	iter = create_dma_iter(tbuf);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	while (true) {
+		if (p >= cap)
+			break;
+		p++;
+		ret = iter->ops->next(iter);
+		if (ret < 0)
+			goto bail;
+		else if (!ret)
+			break;
+	}
+	ret = p;
+bail:
+	iter->ops->free(iter);
+	return ret;
+}
+
+/*
+ * Get number of TID-ready pinned-pagesets for @tbuf.
+ *
+ * Each pageset is a physically contiguous range of pages and:
+ * - Starts on a 4KiB-aligned address.
+ * - Length is power-of-two in range [4KiB,2MiB].
+ *
+ * @cap hint on how many pagesets can be returned.
+ *
+ * @return >= 0 number of pagesets, < 0 on error.
+ */
+static int pagesets(struct tid_user_buf *tbuf, int cap)
+{
+	int ret;
+
+	if (tbuf->ops->find_phys_blocks) {
+		ret = tbuf->ops->find_phys_blocks(tbuf, cap);
+		if (ret)
+			return (ret < 0 ? ret : -EFAULT);
+
+		return tbuf->n_psets;
+	}
+
+	/* No find_phys_blocks(); count using iterator */
+	return pagesets_iter(tbuf, cap);
+}
+
+/*
+ * RcvArray entry allocation for Expected Receives is done by the
+ * following algorithm:
+ *
+ * The context keeps 3 lists of groups of RcvArray entries:
+ *   1. List of empty groups - tid_group_list
+ *      This list is created during user context creation and
+ *      contains elements which describe sets (of 8) of empty
+ *      RcvArray entries.
+ *   2. List of partially used groups - tid_used_list
+ *      This list contains sets of RcvArray entries which are
+ *      not completely used up. Another mapping request could
+ *      use some of all of the remaining entries.
+ *   3. List of full groups - tid_full_list
+ *      This is the list where sets that are completely used
+ *      up go.
+ *
+ * An attempt to optimize the usage of RcvArray entries is
+ * made by finding all sets of physically contiguous pages in a
+ * user's buffer.
+ * These physically contiguous sets are further split into
+ * sizes supported by the receive engine of the HFI. The
+ * resulting sets of pages are stored in struct tid_pageset,
+ * which describes the sets as:
+ *    * .count - number of pages in this set
+ *    * .idx - starting index into struct page ** array
+ *                    of this set
+ *
+ * From this point on, the algorithm deals with the page sets
+ * described above. The number of pagesets is divided by the
+ * RcvArray group size to produce the number of full groups
+ * needed.
+ *
+ * Groups from the 3 lists are manipulated using the following
+ * rules:
+ *   1. For each set of 8 pagesets, a complete group from
+ *      tid_group_list is taken, programmed, and moved to
+ *      the tid_full_list list.
+ *   2. For all remaining pagesets:
+ *      2.1 If the tid_used_list is empty and the tid_group_list
+ *          is empty, stop processing pageset and return only
+ *          what has been programmed up to this point.
+ *      2.2 If the tid_used_list is empty and the tid_group_list
+ *          is not empty, move a group from tid_group_list to
+ *          tid_used_list.
+ *      2.3 For each group is tid_used_group, program as much as
+ *          can fit into the group. If the group becomes fully
+ *          used, move it to tid_full_list.
+ */
+int hfi2_user_exp_rcv_setup(struct hfi2_filedata *fd,
+			    struct hfi2_tid_info *tinfo,
+			    bool allow_unaligned,
+			    bool do_tidcnt_check)
+{
+	int ret = 0, need_group = 0, pinned;
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd = uctxt->dd;
+	/*
+	 * mapped and mapped_pages are implementation-sized pages, not
+	 * EXP_TID_ADDR_SIZE-sized.
+	 */
+	unsigned int ngroups, pageset_count,
+		tididx = 0, mapped, mapped_pages = 0;
+
+	u16 memtype = (tinfo->flags & HFI2_TID_UPDATE_FLAGS_MEMINFO_MASK);
+	struct tid_user_buf *tidbuf;
+	struct hfi2_page_iter *iter;
+	u32 *tidlist = NULL;
+	unsigned int psets;
+
+	trace_hfi2_exp_tid_update(uctxt->ctxt, fd->subctxt, tinfo);
+	ret = create_user_buf(fd, memtype, tinfo, allow_unaligned, &tidbuf);
+	if (ret)
+		return ret;
+
+	pinned = tidbuf->ops->pin_pages(fd, tidbuf);
+	if (pinned <= 0) {
+		ret = (pinned < 0) ? pinned : -ENOSPC;
+		goto fail_unpin;
+	}
+
+	/* Cannot program TIDs for < EXP_TID_ADDR_SIZE pages */
+	if (tidbuf->ops->page_size(tidbuf) < EXP_TID_ADDR_SIZE) {
+		ret = -EOPNOTSUPP;
+		goto fail_unpin;
+	}
+
+	/* Find sets of physically contiguous pages */
+	ret = pagesets(tidbuf, pinned);
+	if (ret < 0)
+		goto fail_unpin;
+	psets = (unsigned int)ret;
+
+	/* Reserve the number of expected tids to be used. */
+	spin_lock(&fd->tid_lock);
+	if (fd->tid_used + psets > fd->tid_limit)
+		pageset_count = fd->tid_limit - fd->tid_used;
+	else
+		pageset_count = psets;
+	fd->tid_used += pageset_count;
+	spin_unlock(&fd->tid_lock);
+
+	if (!pageset_count) {
+		ret = -ENOSPC;
+		goto fail_unreserve;
+	}
+
+	ngroups = pageset_count / dd->rcv_entries.group_size;
+	tidlist = kcalloc(pageset_count, sizeof(*tidlist), GFP_KERNEL);
+	if (!tidlist) {
+		ret = -ENOMEM;
+		goto fail_unreserve;
+	}
+
+	tididx = 0;
+	iter = create_dma_iter(tidbuf);
+	if (IS_ERR(iter)) {
+		ret = PTR_ERR(iter);
+		goto fail_unreserve;
+	} else if (!iter) {
+		ret = -EFAULT;
+		goto fail_unreserve;
+	}
+
+	/*
+	 * From this point on, we are going to be using shared (between master
+	 * and subcontexts) context resources. We need to take the lock.
+	 */
+	mutex_lock(&uctxt->exp_mutex);
+	/*
+	 * The first step is to program the RcvArray entries which are complete
+	 * groups.
+	 */
+	while (ngroups && uctxt->tid_group_list.count) {
+		struct tid_group *grp =
+			tid_group_pop(&uctxt->tid_group_list);
+
+		ret = program_rcvarray(fd, tidbuf, grp,
+				       dd->rcv_entries.group_size,
+				       tidlist, &tididx, iter, &mapped);
+		/*
+		 * If there was a failure to program the RcvArray
+		 * entries for the entire group, reset the grp fields
+		 * and add the grp back to the free group list.
+		 */
+		if (ret <= 0) {
+			tid_group_add_tail(grp, &uctxt->tid_group_list);
+			hfi2_cdbg(TID,
+				  "Failed to program RcvArray group %d", ret);
+			goto unlock;
+		}
+
+		tid_group_add_tail(grp, &uctxt->tid_full_list);
+		ngroups--;
+		mapped_pages += mapped;
+	}
+
+	while (tididx < pageset_count) {
+		struct tid_group *grp, *ptr;
+		/*
+		 * If we don't have any partially used tid groups, check
+		 * if we have empty groups. If so, take one from there and
+		 * put in the partially used list.
+		 */
+		if (!uctxt->tid_used_list.count || need_group) {
+			if (!uctxt->tid_group_list.count)
+				goto unlock;
+
+			grp = tid_group_pop(&uctxt->tid_group_list);
+			tid_group_add_tail(grp, &uctxt->tid_used_list);
+			need_group = 0;
+		}
+		/*
+		 * There is an optimization opportunity here - instead of
+		 * fitting as many page sets as we can, check for a group
+		 * later on in the list that could fit all of them.
+		 */
+		list_for_each_entry_safe(grp, ptr, &uctxt->tid_used_list.list,
+					 list) {
+			unsigned use = min_t(unsigned, pageset_count - tididx,
+					     grp->size - grp->used);
+
+			ret = program_rcvarray(fd, tidbuf, grp,
+					       use, tidlist,
+					       &tididx, iter, &mapped);
+			if (ret < 0) {
+				hfi2_cdbg(TID,
+					  "Failed to program RcvArray entries %d",
+					  ret);
+				goto unlock;
+			} else if (ret > 0) {
+				if (grp->used == grp->size)
+					tid_group_move(grp,
+						       &uctxt->tid_used_list,
+						       &uctxt->tid_full_list);
+				mapped_pages += mapped;
+				need_group = 0;
+				/* Check if we are done so we break out early */
+				if (tididx >= pageset_count)
+					break;
+			} else if (WARN_ON(ret == 0)) {
+				/*
+				 * If ret is 0, we did not program any entries
+				 * into this group, which can only happen if
+				 * we've screwed up the accounting somewhere.
+				 * Warn and try to continue.
+				 */
+				need_group = 1;
+			}
+		}
+	}
+unlock:
+	mutex_unlock(&uctxt->exp_mutex);
+
+	iter->ops->free(iter);
+
+	/*
+	 * mapped_pages is based on implementation page size, not expected
+	 * receive addressing.
+	 *
+	 * E.g. if implementation uses 64KiB pages and expected receive
+	 * addressing is based on 4KiB, for 128KiB of mapped memory,
+	 * mapped_pages=2 not mapped_pages=32.
+	 */
+	hfi2_cdbg(TID, "total mapped: tidpairs:%u pages:%u (%d)", tididx,
+		  mapped_pages, ret);
+
+	/* fail if nothing was programmed, set error if none provided */
+	if (tididx == 0) {
+		if (ret >= 0)
+			ret = -ENOSPC;
+		goto fail_unreserve;
+	}
+
+	/* adjust reserved tid_used to actual count */
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= pageset_count - tididx;
+	spin_unlock(&fd->tid_lock);
+
+	/* unpin all pages not covered by a TID */
+	tidbuf->ops->unpin_pages(fd, tidbuf, mapped_pages, pinned - mapped_pages);
+
+	/* check for an invalidate during setup */
+	if (tidbuf->ops->invalidated(tidbuf)) {
+		ret = -EBUSY;
+		goto fail_unprogram;
+	}
+
+	/* verify claimed incoming TID buffer has enough entries for result */
+	if (do_tidcnt_check && tinfo->tidcnt < tididx) {
+		ret = -ENOSPC;
+		goto fail_unprogram;
+	}
+
+	tinfo->tidcnt = tididx;
+	/* Should never happen but detect if somehow implementation pinned too many pages */
+	if (check_mul_overflow(mapped_pages, tidbuf->ops->page_size(tidbuf), &tinfo->length)) {
+		ret = -EFAULT;
+		goto fail_unprogram;
+	}
+
+	if (copy_to_user(u64_to_user_ptr(tinfo->tidlist),
+			 tidlist, sizeof(tidlist[0]) * tididx)) {
+		ret = -EFAULT;
+		goto fail_unprogram;
+	}
+
+	tidbuf->ops->unnotify(tidbuf);
+	tidbuf->ops->free(tidbuf);
+	kfree(tidlist);
+	return 0;
+
+fail_unprogram:
+	/* unprogram, unmap, and unpin all allocated TIDs */
+	tinfo->tidlist = (unsigned long)tidlist;
+	hfi2_user_exp_rcv_clear(fd, (struct hfi1_tid_info *)tinfo);
+	tinfo->tidlist = 0;
+	pinned = 0;		/* nothing left to unpin */
+	pageset_count = 0;	/* nothing left reserved */
+fail_unreserve:
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= pageset_count;
+	spin_unlock(&fd->tid_lock);
+fail_unpin:
+	tidbuf->ops->unnotify(tidbuf);
+	if (pinned > 0)
+		tidbuf->ops->unpin_pages(fd, tidbuf, 0, pinned);
+	tidbuf->ops->free(tidbuf);
+	kfree(tidlist);
+	return ret;
+}
+
+int hfi2_user_exp_rcv_clear(struct hfi2_filedata *fd,
+			    struct hfi1_tid_info *tinfo)
+{
+	int ret = 0;
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	u32 *tidinfo;
+	unsigned tididx;
+
+	if (unlikely(tinfo->tidcnt > fd->tid_used))
+		return -EINVAL;
+
+	tidinfo = memdup_array_user(u64_to_user_ptr(tinfo->tidlist),
+				    tinfo->tidcnt, sizeof(tidinfo[0]));
+	if (IS_ERR(tidinfo))
+		return PTR_ERR(tidinfo);
+
+	mutex_lock(&uctxt->exp_mutex);
+	for (tididx = 0; tididx < tinfo->tidcnt; tididx++) {
+		ret = unprogram_rcvarray(fd, tidinfo[tididx]);
+		if (ret) {
+			hfi2_cdbg(TID, "Failed to unprogram rcv array %d",
+				  ret);
+			break;
+		}
+	}
+	spin_lock(&fd->tid_lock);
+	fd->tid_used -= tididx;
+	spin_unlock(&fd->tid_lock);
+	tinfo->tidcnt = tididx;
+	mutex_unlock(&uctxt->exp_mutex);
+
+	kfree(tidinfo);
+	return ret;
+}
+
+int hfi2_user_exp_rcv_invalid(struct hfi2_filedata *fd,
+			      struct hfi1_tid_info *tinfo,
+			      bool do_tidcnt_check)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	unsigned long *ev = uctxt->dd->events +
+		(uctxt_offset(uctxt) + fd->subctxt);
+	u32 *array;
+	int ret = 0;
+
+	if (!fd->invalid_tids)
+		return -EINVAL;
+
+	/*
+	 * copy_to_user() can sleep, which will leave the invalid_lock
+	 * locked and cause the MMU notifier to be blocked on the lock
+	 * for a long time.
+	 * Copy the data to a local buffer so we can release the lock.
+	 */
+	array = kcalloc(uctxt->expected_count, sizeof(*array), GFP_KERNEL);
+	if (!array)
+		return -EFAULT;
+
+	spin_lock(&fd->invalid_lock);
+	if (do_tidcnt_check && tinfo->tidcnt < fd->invalid_tid_idx) {
+		ret = -ENOSPC;
+	} else if (fd->invalid_tid_idx) {
+		memcpy(array, fd->invalid_tids, sizeof(*array) *
+		       fd->invalid_tid_idx);
+		memset(fd->invalid_tids, 0, sizeof(*fd->invalid_tids) *
+		       fd->invalid_tid_idx);
+		tinfo->tidcnt = fd->invalid_tid_idx;
+		fd->invalid_tid_idx = 0;
+		/*
+		 * Reset the user flag while still holding the lock.
+		 * Otherwise, PSM can miss events.
+		 */
+		clear_bit(_HFI2_EVENT_TID_MMU_NOTIFY_BIT, ev);
+	} else {
+		tinfo->tidcnt = 0;
+	}
+	spin_unlock(&fd->invalid_lock);
+
+	if (ret == 0 && tinfo->tidcnt) {
+		if (copy_to_user((void __user *)tinfo->tidlist,
+				 array, sizeof(*array) * tinfo->tidcnt))
+			ret = -EFAULT;
+	}
+	kfree(array);
+
+	return ret;
+}
+
+/*
+ * Convert @node's implementation-defined npages to number of
+ * EXP_TID_ADDR_SIZE pages.
+ *
+ * @return number of EXP_TID_ADDR_SIZE pages
+ */
+static unsigned int node_npages(const struct tid_rb_node *node)
+{
+	/* Underflow/overflow protection here depends on other places enforcing that:
+	 *   page_shift >= EXP_TID_ADDR_SHIFT
+	 *   node->npages * (1 << page_shift) <= MAX_EXPECTED_BUFFER
+	 */
+	return (node->npages << node->page_shift) >> EXP_TID_ADDR_SHIFT;
+}
+
+/*
+ * DMA-map and program single TID entry for physically contiguous pinned page
+ * range.
+ *
+ * @fd
+ * @tbuf
+ * @rcventry
+ * @grp
+ * @iter
+ * @onode out node. Undefined on error.
+ *
+ * @return 0 on success, non-zero on error.
+ */
+static int set_rcvarray_entry(struct hfi2_filedata *fd,
+			      struct tid_user_buf *tbuf,
+			      u32 rcventry, struct tid_group *grp,
+			      struct hfi2_page_iter *iter,
+			      struct tid_rb_node **onode)
+{
+	struct tid_node_ops *nodeops = get_nodeops(tbuf->type);
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd = uctxt->dd;
+	struct tid_rb_node *node;
+	int ret;
+
+	if (WARN_ON(!nodeops))
+		return -EINVAL;
+
+	node = nodeops->init(fd, tbuf, rcventry, grp, iter);
+	if (IS_ERR(node))
+		return PTR_ERR(node);
+
+	if (node->use_mn) {
+		ret = node->ops->register_notify(node);
+		if (ret)
+			goto out_unmap;
+	}
+	*onode = node;
+	fd->entry_to_rb[node->rcventry] = node;
+
+	/* RcvArray entry requires EXP_TID_ADDR_SIZE page-size npages */
+	dd->params->put_tid(uctxt, rcventry, PT_EXPECTED, node->dma_addr,
+			    ilog2(node_npages(node)) + 1, false);
+
+	trace_hfi2_exp_tid_reg(uctxt->ctxt, fd->subctxt, rcventry,
+			       node_npages(node),
+			       node->vaddr, node->phys,
+			       node->dma_addr, node->type);
+	return 0;
+out_unmap:
+	hfi2_cdbg(TID, "Failed to insert RB node %u 0x%lx, 0x%lx %d",
+		  node->rcventry, node->vaddr, node->phys, ret);
+
+	node->ops->dma_unmap(node);
+	node->ops->free(node);
+
+	return -EFAULT;
+}
+
+/**
+ * program_rcvarray() - program an RcvArray group with receive buffers
+ * @fd: filedata pointer
+ * @tbuf: pointer to struct tid_user_buf that has the user buffer starting
+ *	  virtual address, buffer length, page pointers, pagesets (array of
+ *	  struct tid_pageset holding information on physically contiguous
+ *	  chunks from the user buffer), and other fields.
+ * @grp: RcvArray group
+ * @count: number of struct tid_pageset's to program
+ * @tidlist: the array of u32 elements when the information about the
+ *           programmed RcvArray entries is to be encoded.
+ * @tididx: starting offset into tidlist
+ * @iter
+ * @pmapped: (output parameter) number of implementation pages programmed into the RcvArray
+ *           entries.
+ *
+ * This function will program up to 'count' number of RcvArray entries from the
+ * group 'grp'. To make best use of write-combining writes, the function will
+ * perform writes to the unused RcvArray entries which will be ignored by the
+ * HW. Each RcvArray entry will be programmed with a physically contiguous
+ * buffer chunk from the user's virtual buffer.
+ *
+ * Return:
+ * -EINVAL if the requested count is larger than the size of the group,
+ * -ENOMEM or -EFAULT on error from set_rcvarray_entry(), or
+ * number of RcvArray entries programmed.
+ */
+static int program_rcvarray(struct hfi2_filedata *fd,
+			    struct tid_user_buf *tbuf,
+			    struct tid_group *grp, u16 count,
+			    u32 *tidlist, unsigned int *tididx,
+			    struct hfi2_page_iter *iter,
+			    unsigned int *pmapped)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	u16 idx;
+	u32 tidinfo = 0, rcventry, useidx = 0;
+	int mapped = 0;
+	int ret;
+
+	/* Count should never be larger than the group size */
+	if (count > grp->size)
+		return -EINVAL;
+
+	/* Find the first unused entry in the group */
+	for (idx = 0; idx < grp->size; idx++) {
+		if (!(grp->map & (1 << idx))) {
+			useidx = idx;
+			break;
+		}
+		uctxt->dd->params->rcv_array_wc_fill(uctxt, grp->base + idx,
+						     PT_EXPECTED);
+	}
+
+	idx = 0;
+	while (idx < count) {
+		struct tid_rb_node *node;
+
+		/*
+		 * If this entry in the group is used, move to the next one.
+		 * If we go past the end of the group, exit the loop.
+		 */
+		if (useidx >= grp->size) {
+			break;
+		} else if (grp->map & (1 << useidx)) {
+			uctxt->dd->params->rcv_array_wc_fill(uctxt,
+							     grp->base + useidx,
+							     PT_EXPECTED);
+			useidx++;
+			continue;
+		}
+
+		rcventry = grp->base + useidx;
+		ret = set_rcvarray_entry(fd, tbuf, rcventry, grp, iter, &node);
+		if (ret)
+			return ret;
+		mapped += node->npages;
+
+		/* In-memory TIDs requires EXP_TID_ADDR_SIZE page-size npages */
+		tidinfo = create_tid(rcventry, node_npages(node));
+		tidlist[(*tididx)++] = tidinfo;
+		grp->used++;
+		grp->map |= 1 << useidx++;
+		idx++;
+		ret = iter->ops->next(iter);
+		if (ret < 0) {
+			/* Make sure ret won't be treated as a success value */
+			return ret;
+		} else if (!ret && idx < count) {
+			/* Exhausted all DMA-pagesets but not done programming */
+			return -EFAULT;
+		}
+	}
+
+	/* Fill the rest of the group with "blank" writes */
+	for (; useidx < grp->size; useidx++)
+		uctxt->dd->params->rcv_array_wc_fill(uctxt, grp->base + useidx,
+						     PT_EXPECTED);
+	*pmapped = mapped;
+	return idx;
+}
+
+static int unprogram_rcvarray(struct hfi2_filedata *fd, u32 tidinfo)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_devdata *dd = uctxt->dd;
+	struct tid_rb_node *node;
+	u32 tidctrl = EXP_TID_GET(tidinfo, CTRL);
+	u32 tididx = EXP_TID_GET(tidinfo, IDX) << 1, rcventry;
+
+	if (tidctrl == 0x3 || tidctrl == 0x0)
+		return -EINVAL;
+
+	rcventry = tididx + (tidctrl - 1);
+
+	if (rcventry >= uctxt->expected_count) {
+		dd_dev_err(dd, "Invalid RcvArray entry (%u) index for ctxt %u\n",
+			   rcventry, uctxt->ctxt);
+		return -EINVAL;
+	}
+
+	node = fd->entry_to_rb[rcventry];
+	if (!node || node->rcventry != rcventry)
+		return -EBADF;
+
+	node->ops->unregister_notify(node);
+	cacheless_tid_rb_remove(fd, node);
+
+	return 0;
+}
+
+static void __clear_tid_node(struct hfi2_filedata *fd, struct tid_rb_node *node)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	mutex_lock(&node->invalidate_mutex);
+	if (node->freed)
+		goto done;
+	node->freed = true;
+
+	trace_hfi2_exp_tid_unreg(uctxt->ctxt, fd->subctxt, node->rcventry,
+				 node_npages(node),
+				 node->vaddr, node->phys,
+				 node->dma_addr, node->type);
+
+	/* Make sure device has seen the write before pages are unpinned */
+	uctxt->dd->params->put_tid(uctxt, node->rcventry, PT_EXPECTED, 0, 0, true);
+
+	node->ops->unpin_pages(fd, node);
+done:
+	mutex_unlock(&node->invalidate_mutex);
+}
+
+static void clear_tid_node(struct hfi2_filedata *fd, struct tid_rb_node *node)
+{
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+
+	__clear_tid_node(fd, node);
+
+	node->grp->used--;
+	node->grp->map &= ~(1 << (node->rcventry - node->grp->base));
+
+	if (node->grp->used == node->grp->size - 1)
+		tid_group_move(node->grp, &uctxt->tid_full_list,
+			       &uctxt->tid_used_list);
+	else if (!node->grp->used)
+		tid_group_move(node->grp, &uctxt->tid_used_list,
+			       &uctxt->tid_group_list);
+	node->ops->free(node);
+}
+
+/*
+ * As a simple helper for hfi2_user_exp_rcv_free, this function deals with
+ * clearing nodes in the non-cached case.
+ */
+static void unlock_exp_tids(struct hfi2_ctxtdata *uctxt,
+			    struct exp_tid_set *set,
+			    struct hfi2_filedata *fd)
+{
+	struct tid_group *grp, *ptr;
+	int i;
+
+	list_for_each_entry_safe(grp, ptr, &set->list, list) {
+		list_del_init(&grp->list);
+
+		for (i = 0; i < grp->size; i++) {
+			if (grp->map & (1 << i)) {
+				u16 rcventry = grp->base + i;
+				struct tid_rb_node *node;
+
+				node = fd->entry_to_rb[rcventry];
+				if (!node || node->rcventry != rcventry)
+					continue;
+
+				node->ops->unregister_notify(node);
+				cacheless_tid_rb_remove(fd, node);
+			}
+		}
+	}
+}
+
+/**
+ * Unprogram TID for @node, updating user TID invalidation events when
+ * @node->fdata->use_mn is true.
+ */
+void hfi2_user_exp_rcv_invalidate(struct tid_rb_node *node)
+{
+	struct hfi2_filedata *fdata = node->fdata;
+	struct hfi2_ctxtdata *uctxt = fdata->uctxt;
+
+	trace_hfi2_exp_tid_inval(uctxt->ctxt, fdata->subctxt,
+				 node->vaddr,
+				 node->rcventry,
+				 node_npages(node),
+				 node->dma_addr, node->type);
+
+	/* clear the hardware rcvarray entry */
+	__clear_tid_node(fdata, node);
+
+	/* User TID invalidation events not in use, nothing else to do */
+	if (!node->use_mn)
+		return;
+
+	spin_lock(&fdata->invalid_lock);
+	if (fdata->invalid_tid_idx < uctxt->expected_count) {
+		/* In-memory TIDs requires EXP_TID_ADDR_SIZE page-size npages */
+		fdata->invalid_tids[fdata->invalid_tid_idx] =
+			create_tid(node->rcventry, node_npages(node));
+		if (!fdata->invalid_tid_idx) {
+			unsigned long *ev;
+
+			/*
+			 * hfi2_set_uevent_bits() sets a user event flag
+			 * for all processes. Because calling into the
+			 * driver to process TID cache invalidations is
+			 * expensive and TID cache invalidations are
+			 * handled on a per-process basis, we can
+			 * optimize this to set the flag only for the
+			 * process in question.
+			 */
+			ev = uctxt->dd->events +
+				(uctxt_offset(uctxt) + fdata->subctxt);
+			set_bit(_HFI2_EVENT_TID_MMU_NOTIFY_BIT, ev);
+		}
+		fdata->invalid_tid_idx++;
+	}
+	spin_unlock(&fdata->invalid_lock);
+}
+
+static void cacheless_tid_rb_remove(struct hfi2_filedata *fdata,
+				    struct tid_rb_node *tnode)
+{
+	fdata->entry_to_rb[tnode->rcventry] = NULL;
+	clear_tid_node(fdata, tnode);
+}
diff --git a/drivers/infiniband/hw/hfi2/user_pages.c b/drivers/infiniband/hw/hfi2/user_pages.c
new file mode 100644
index 000000000000..58998b80bbbf
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_pages.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015-2017 Intel Corporation.
+ */
+
+#include <linux/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/device.h>
+#include <linux/module.h>
+
+#include "hfi2.h"
+
+static unsigned long cache_size = 256;
+module_param(cache_size, ulong, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(cache_size, "Send and receive side cache size limit (in MB)");
+
+/*
+ * Determine whether the caller can pin pages.
+ *
+ * This function should be used in the implementation of buffer caches.
+ * The cache implementation should call this function prior to attempting
+ * to pin buffer pages in order to determine whether they should do so.
+ * The function computes cache limits based on the configured ulimit and
+ * cache size. Use of this function is especially important for caches
+ * which are not limited in any other way (e.g. by HW resources) and, thus,
+ * could keeping caching buffers.
+ *
+ */
+bool hfi2_can_pin_pages(struct hfi2_devdata *dd, struct mm_struct *mm,
+			u32 nlocked, u32 npages)
+{
+	unsigned long ulimit_pages;
+	unsigned long cache_limit_pages;
+	unsigned int usr_ctxts;
+	int pidx;
+
+	/*
+	 * Perform RLIMIT_MEMLOCK based checks unless CAP_IPC_LOCK is present.
+	 */
+	if (!capable(CAP_IPC_LOCK)) {
+		ulimit_pages =
+			DIV_ROUND_DOWN_ULL(rlimit(RLIMIT_MEMLOCK), PAGE_SIZE);
+
+		/*
+		 * Pinning these pages would exceed this process's locked memory
+		 * limit.
+		 */
+		if (atomic64_read(&mm->pinned_vm) + npages > ulimit_pages)
+			return false;
+
+		/*
+		 * Only allow 1/4 of the user's RLIMIT_MEMLOCK to be used for HFI
+		 * caches.  This fraction is then equally distributed among all
+		 * existing user contexts.  Note that if RLIMIT_MEMLOCK is
+		 * 'unlimited' (-1), the value of this limit will be > 2^42 pages
+		 * (2^64 / 2^12 / 2^8 / 2^2).
+		 *
+		 * The effectiveness of this check may be reduced if I/O occurs on
+		 * some user contexts before all user contexts are created.  This
+		 * check assumes that this process is the only one using this
+		 * context (e.g., the corresponding fd was not passed to another
+		 * process for concurrent access) as there is no per-context,
+		 * per-process tracking of pinned pages.  It also assumes that each
+		 * user context has only one cache to limit.
+		 */
+		usr_ctxts = 0;
+		for (pidx = 0; pidx < dd->num_pports; pidx++)
+			usr_ctxts += dd->pport[pidx].num_rcv_contexts - dd->pport[pidx].n_krcv_queues;
+		if (nlocked + npages > (ulimit_pages / usr_ctxts / 4))
+			return false;
+	}
+
+	/*
+	 * Pinning these pages would exceed the size limit for this cache.
+	 */
+	cache_limit_pages = cache_size * (1024 * 1024) / PAGE_SIZE;
+	if (nlocked + npages > cache_limit_pages)
+		return false;
+
+	return true;
+}
+
+int hfi2_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t npages,
+			    bool writable, struct page **pages)
+{
+	int ret;
+	unsigned int gup_flags = FOLL_LONGTERM | (writable ? FOLL_WRITE : 0);
+
+	ret = pin_user_pages_fast(vaddr, npages, gup_flags, pages);
+	if (ret < 0)
+		return ret;
+
+	atomic64_add(ret, &mm->pinned_vm);
+
+	return ret;
+}
+
+void hfi2_release_user_pages(struct mm_struct *mm, struct page **p,
+			     size_t npages, bool dirty)
+{
+	unpin_user_pages_dirty_lock(p, npages, dirty);
+
+	if (mm) { /* during close after signal, mm can be NULL */
+		atomic64_sub(npages, &mm->pinned_vm);
+	}
+}
diff --git a/drivers/infiniband/hw/hfi2/user_sdma.c b/drivers/infiniband/hw/hfi2/user_sdma.c
new file mode 100644
index 000000000000..ba752140dc1d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/user_sdma.c
@@ -0,0 +1,1671 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2020 - 2023 Cornelis Networks, Inc.
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#include <linux/mm.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/dmapool.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/uio.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/kthread.h>
+#include <linux/mmu_context.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/string.h>
+
+#include "hfi2.h"
+#include "sdma.h"
+#include "user_sdma.h"
+#include "verbs.h"  /* for the headers */
+#include "common.h" /* for struct hfi2_tid_info */
+#include "trace.h"
+
+static uint hfi2_sdma_comp_ring_size = 128;
+module_param_named(sdma_comp_size, hfi2_sdma_comp_ring_size, uint, S_IRUGO);
+MODULE_PARM_DESC(sdma_comp_size, "Size of User SDMA completion ring. Default: 128");
+
+static unsigned initial_pkt_count = 8;
+
+static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts);
+static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status);
+static inline void pq_update(struct hfi2_user_sdma_pkt_q *pq);
+static void user_sdma_free_request(struct user_sdma_request *req);
+static int check_header_template(struct user_sdma_request *req,
+				 struct user_sdma_txreq *tx, u32 lrhlen,
+				 u32 datalen);
+static int set_txreq_header(struct user_sdma_request *req,
+			    struct user_sdma_txreq *tx, u32 datalen);
+static int set_txreq_header_ahg(struct user_sdma_request *req,
+				struct user_sdma_txreq *tx, u32 len);
+static inline void set_comp_state(struct hfi2_user_sdma_pkt_q *pq,
+				  struct hfi2_user_sdma_comp_q *cq,
+				  u16 idx, enum hfi2_sdma_comp_state state,
+				  int ret);
+static inline u32 set_pkt_bth_psn(__be32 bthpsn, u8 expct, u32 frags);
+static inline u32 get_lrh_len(struct user_sdma_request *req, u32 len);
+
+static int defer_packet_queue(
+	struct sdma_engine *sde,
+	struct iowait_work *wait,
+	struct sdma_txreq *txreq,
+	uint seq,
+	bool pkts_sent);
+static void activate_packet_queue(struct iowait *wait, int reason);
+
+static int defer_packet_queue(
+	struct sdma_engine *sde,
+	struct iowait_work *wait,
+	struct sdma_txreq *txreq,
+	uint seq,
+	bool pkts_sent)
+{
+	struct hfi2_user_sdma_pkt_q *pq =
+		container_of(wait->iow, struct hfi2_user_sdma_pkt_q, busy);
+
+	write_seqlock(&sde->waitlock);
+	trace_hfi2_usdma_defer(pq, sde, &pq->busy);
+	if (sdma_progress(sde, seq, txreq))
+		goto eagain;
+	/*
+	 * We are assuming that if the list is enqueued somewhere, it
+	 * is to the dmawait list since that is the only place where
+	 * it is supposed to be enqueued.
+	 */
+	xchg(&pq->state, SDMA_PKT_Q_DEFERRED);
+	if (list_empty(&pq->busy.list)) {
+		pq->busy.lock = &sde->waitlock;
+		iowait_get_priority(&pq->busy);
+		iowait_queue(pkts_sent, &pq->busy, &sde->dmawait);
+	}
+	write_sequnlock(&sde->waitlock);
+	return -EBUSY;
+eagain:
+	write_sequnlock(&sde->waitlock);
+	return -EAGAIN;
+}
+
+static void activate_packet_queue(struct iowait *wait, int reason)
+{
+	struct hfi2_user_sdma_pkt_q *pq =
+		container_of(wait, struct hfi2_user_sdma_pkt_q, busy);
+
+	trace_hfi2_usdma_activate(pq, wait, reason);
+	xchg(&pq->state, SDMA_PKT_Q_ACTIVE);
+	wake_up(&wait->wait_dma);
+};
+
+#define HEADER_ALIGN 256 /* memory alignment for header descriptors */
+
+int hfi2_user_sdma_alloc_queues(struct hfi2_ctxtdata *uctxt,
+				struct hfi2_filedata *fd)
+{
+	int ret = -ENOMEM;
+	char buf[64];
+	struct hfi2_devdata *dd;
+	struct hfi2_user_sdma_comp_q *cq;
+	struct hfi2_user_sdma_pkt_q *pq;
+
+	if (!uctxt || !fd)
+		return -EBADF;
+
+	if (!hfi2_sdma_comp_ring_size)
+		return -EINVAL;
+
+	dd = uctxt->dd;
+
+	pq = kzalloc(sizeof(*pq), GFP_KERNEL);
+	if (!pq)
+		return -ENOMEM;
+	pq->dd = dd;
+	pq->ctxt = uctxt->ctxt;
+	pq->subctxt = fd->subctxt;
+	pq->n_max_reqs = hfi2_sdma_comp_ring_size;
+	atomic_set(&pq->n_reqs, 0);
+	init_waitqueue_head(&pq->wait);
+	atomic_set(&pq->n_locked, 0);
+
+	iowait_init(&pq->busy, 0, NULL, NULL, defer_packet_queue,
+		    activate_packet_queue, NULL, NULL);
+
+	pq->reqs = kcalloc(hfi2_sdma_comp_ring_size,
+			   sizeof(*pq->reqs),
+			   GFP_KERNEL);
+	if (!pq->reqs)
+		goto pq_reqs_nomem;
+
+	pq->req_in_use = bitmap_zalloc(hfi2_sdma_comp_ring_size, GFP_KERNEL);
+	if (!pq->req_in_use)
+		goto pq_reqs_no_in_use;
+
+	snprintf(buf, 64, "txreq-kmem-cache-%u-%u-%u", dd->unit, uctxt->ctxt,
+		 fd->subctxt);
+	pq->txreq_cache = kmem_cache_create(buf,
+					    sizeof(struct user_sdma_txreq),
+					    HEADER_ALIGN,
+					    SLAB_HWCACHE_ALIGN,
+					    NULL);
+	if (!pq->txreq_cache) {
+		dd_dev_err(dd, "[%u] Failed to allocate TxReq cache\n",
+			   uctxt->ctxt);
+		goto pq_txreq_nomem;
+	}
+
+	cq = kzalloc(sizeof(*cq), GFP_KERNEL);
+	if (!cq)
+		goto cq_nomem;
+
+	cq->comps = vmalloc_user(PAGE_ALIGN(sizeof(*cq->comps)
+				 * hfi2_sdma_comp_ring_size));
+	if (!cq->comps)
+		goto cq_comps_nomem;
+
+	cq->nentries = hfi2_sdma_comp_ring_size;
+
+	ret = init_pinning_interfaces(pq);
+	if (ret)
+		goto pq_mmu_fail;
+
+	rcu_assign_pointer(fd->pq, pq);
+	fd->cq = cq;
+
+	return 0;
+
+pq_mmu_fail:
+	vfree(cq->comps);
+cq_comps_nomem:
+	kfree(cq);
+cq_nomem:
+	kmem_cache_destroy(pq->txreq_cache);
+pq_txreq_nomem:
+	bitmap_free(pq->req_in_use);
+pq_reqs_no_in_use:
+	kfree(pq->reqs);
+pq_reqs_nomem:
+	kfree(pq);
+
+	return ret;
+}
+
+static void flush_pq_iowait(struct hfi2_user_sdma_pkt_q *pq)
+{
+	unsigned long flags;
+	seqlock_t *lock = pq->busy.lock;
+
+	if (!lock)
+		return;
+	write_seqlock_irqsave(lock, flags);
+	if (!list_empty(&pq->busy.list)) {
+		list_del_init(&pq->busy.list);
+		pq->busy.lock = NULL;
+	}
+	write_sequnlock_irqrestore(lock, flags);
+}
+
+int hfi2_user_sdma_free_queues(struct hfi2_filedata *fd,
+			       struct hfi2_ctxtdata *uctxt)
+{
+	struct hfi2_user_sdma_pkt_q *pq;
+
+	trace_hfi2_sdma_user_free_queues(uctxt->dd, uctxt->ctxt, fd->subctxt);
+
+	spin_lock(&fd->pq_rcu_lock);
+	pq = srcu_dereference_check(fd->pq, &fd->pq_srcu,
+				    lockdep_is_held(&fd->pq_rcu_lock));
+	if (pq) {
+		rcu_assign_pointer(fd->pq, NULL);
+		spin_unlock(&fd->pq_rcu_lock);
+		synchronize_srcu(&fd->pq_srcu);
+		/* at this point there can be no more new requests */
+		iowait_sdma_drain(&pq->busy);
+		/* Wait until all requests have been freed. */
+		wait_event_interruptible(
+			pq->wait,
+			!atomic_read(&pq->n_reqs));
+		kfree(pq->reqs);
+		free_pinning_interfaces(pq);
+		bitmap_free(pq->req_in_use);
+		kmem_cache_destroy(pq->txreq_cache);
+		flush_pq_iowait(pq);
+		kfree(pq);
+	} else {
+		spin_unlock(&fd->pq_rcu_lock);
+	}
+	if (fd->cq) {
+		vfree(fd->cq->comps);
+		kfree(fd->cq);
+		fd->cq = NULL;
+	}
+	return 0;
+}
+
+static u8 dlid_to_selector(u16 dlid)
+{
+	static u8 mapping[256];
+	static int initialized;
+	static u8 next;
+	int hash;
+
+	if (!initialized) {
+		memset(mapping, 0xFF, 256);
+		initialized = 1;
+	}
+
+	hash = ((dlid >> 8) ^ dlid) & 0xFF;
+	if (mapping[hash] == 0xFF) {
+		mapping[hash] = next;
+		next = (next + 1) & 0x7F;
+	}
+
+	return mapping[hash];
+}
+
+/* return the data length expressed in the template LRH */
+static inline u32 template_data_len(struct user_sdma_request *req)
+{
+	u32 len;
+
+	if (req->is16b) {
+		/*
+		 * The incoming LRH template length is:
+		 *   lrh_len = header_len + data_len + ICRC
+		 *   => data_len = lrh_len - header_len - ICRC
+		 *   header_len = req->hsize - sizeof(PBC)
+		 *   ICRC = 8 bytes (for 16B packets)
+		 */
+		len = req->lrh_len_bytes - (req->hsize - sizeof(req->h.pbc)) - 8;
+	} else {
+		/*
+		 * The minimum representable packet data length in a
+		 * header is 4 bytes, therefore, when the data length
+		 * request is less than 4 bytes, there's only one
+		 * packet, and the packet data length is equal to that
+		 * of the request data length.
+		 */
+		if (req->data_len < sizeof(u32))
+			len = req->data_len;
+		else
+			len = (req->lrh_len_bytes - (req->hsize - 4));
+	}
+
+	return len;
+}
+
+/*
+ * Decide if the PBC is for 9B or 16B packets.
+ * Expect the PBC to be endianized for the CPU.
+ *
+ * Return:
+ * 0       - PBC is 9B or 16B, set is_16b accordingly
+ * -EINVAL - PBC not 9B or 16B
+ *
+ */
+static int check_pbc_16b(struct hfi2_devdata *dd, u64 pbc, bool *is_16b)
+{
+	u32 l2type;
+
+	if (dd->params->chip_type == CHIP_WFR) {
+		/* WFR: if bypass is set, it is 16B, else 9B */
+		*is_16b = !!(pbc & PBC_PACKET_BYPASS);
+		return 0;
+	}
+
+	/* JKR and beyond */
+	l2type = (pbc >> PBC_L2_TYPE_SHIFT) & 0x3;
+	if (l2type == PBC_L2_16B) {
+		*is_16b = true;
+		return 0;
+	}
+	if (l2type == PBC_L2_9B) {
+		*is_16b = false;
+		return 0;
+	}
+	/* unexpected l2 type */
+
+	return -EINVAL;
+}
+
+/**
+ * hfi2_user_sdma_process_request() - Process and start a user sdma request
+ * @fd: valid file descriptor
+ * @iovec: array of io vectors to process
+ * @dim: overall iovec array size
+ * @count: number of io vector array entries processed
+ */
+int hfi2_user_sdma_process_request(struct hfi2_filedata *fd,
+				   struct iovec *iovec, unsigned long dim,
+				   unsigned long *count)
+{
+	int ret = 0, i;
+	struct hfi2_ctxtdata *uctxt = fd->uctxt;
+	struct hfi2_pportdata *ppd = uctxt->ppd;
+	struct hfi2_user_sdma_pkt_q *pq =
+		srcu_dereference(fd->pq, &fd->pq_srcu);
+	struct hfi2_user_sdma_comp_q *cq = fd->cq;
+	struct hfi2_devdata *dd = pq->dd;
+	unsigned long idx = 0;
+	u8 pcount = initial_pkt_count;
+	struct sdma_req_info info;
+	u64 cpu_pbc;
+	unsigned long rsize;
+	void *rhdr; /* header remainder */
+	__be32 *bth;
+	struct hfi2_kdeth_header *kdeth;
+	bool lrh_grh;
+
+	/*
+	 * For PSM2-CUDA backwards compatibility.
+	 * Start by assuming u16 .flags not present.
+	 * Add sizeof(u16) back once determined that .flags is present.
+	 */
+	int infosz = sizeof(struct sdma_req_info);
+	struct user_sdma_request *req;
+	size_t header_offset;
+	u8 opcode, sc, vl;
+	u16 pkey;
+	u32 slid;
+	u16 dlid;
+	u32 selector;
+
+	if (iovec[idx].iov_len < infosz) {
+		hfi2_cdbg(SDMA,
+			  "[%u:%u:%u] First vector not big enough for info %lu/%u",
+			  dd->unit, uctxt->ctxt, fd->subctxt,
+			  iovec[idx].iov_len, infosz);
+		return -EINVAL;
+	}
+	ret = copy_from_user(&info, iovec[idx].iov_base, sizeof(info));
+	if (ret) {
+		hfi2_cdbg(SDMA, "[%u:%u:%u] Failed to copy info QW (%d)",
+			  dd->unit, uctxt->ctxt, fd->subctxt, ret);
+		return -EFAULT;
+	}
+
+	trace_hfi2_sdma_user_reqinfo(dd, uctxt->ctxt, fd->subctxt,
+				     (u16 *)&info);
+	if (info.comp_idx >= hfi2_sdma_comp_ring_size) {
+		hfi2_cdbg(SDMA,
+			  "[%u:%u:%u:%u] Invalid comp index",
+			  dd->unit, uctxt->ctxt, fd->subctxt, info.comp_idx);
+		return -EINVAL;
+	}
+
+	/*
+	 * Sanity check the header io vector count.  Need at least 1 vector
+	 * (header) and cannot be larger than the actual io vector count.
+	 */
+	if (req_iovcnt(info.ctrl) < 1 || req_iovcnt(info.ctrl) > dim) {
+		hfi2_cdbg(SDMA,
+			  "[%u:%u:%u:%u] Invalid iov count %d, dim %ld",
+			  dd->unit, uctxt->ctxt, fd->subctxt, info.comp_idx,
+			  req_iovcnt(info.ctrl), dim);
+		return -EINVAL;
+	}
+
+	if (!info.fragsize) {
+		hfi2_cdbg(SDMA,
+			  "[%u:%u:%u:%u] Request does not specify fragsize",
+			  dd->unit, uctxt->ctxt, fd->subctxt, info.comp_idx);
+		return -EINVAL;
+	}
+
+	/* Try to claim the request. */
+	if (test_and_set_bit(info.comp_idx, pq->req_in_use)) {
+		hfi2_cdbg(SDMA, "[%u:%u:%u] Entry %u is in use",
+			  dd->unit, uctxt->ctxt, fd->subctxt,
+			  info.comp_idx);
+		return -EBADSLT;
+	}
+	/*
+	 * All safety checks have been done and this request has been claimed.
+	 */
+	trace_hfi2_sdma_user_process_request(dd, uctxt->ctxt, fd->subctxt,
+					     info.comp_idx);
+	req = pq->reqs + info.comp_idx;
+	req->data_iovs = req_iovcnt(info.ctrl) - 1; /* subtract header vector */
+	req->data_len  = 0;
+	req->pq = pq;
+	req->cq = cq;
+	req->ahg_idx = -1;
+	req->iov_idx = 0;
+	req->sent = 0;
+	req->seqnum = 0;
+	req->seqcomp = 0;
+	req->seqsubmitted = 0;
+	req->tids = NULL;
+	req->has_error = 0;
+	req->hsize = 0; /* set below */
+	req->lrh_len_bytes = 0; /* set below */
+	req->pad_mask = 0; /* set below */
+	req->tailsize = 0; /* set below */
+	req->is16b = false; /* set below */
+	INIT_LIST_HEAD(&req->txps);
+	req->n_pinrefs = 0;
+	req->pinref_seqnum = 0;
+
+	memcpy(&req->info, &info, sizeof(info));
+
+	/* The request is initialized, count it */
+	atomic_inc(&pq->n_reqs);
+
+	if (req_opcode(info.ctrl) == EXPECTED) {
+		/* expected must have a TID info and at least one data vector */
+		if (req->data_iovs < 2) {
+			SDMA_DBG(req, "Not enough vectors for expected request: 0x%x", info.ctrl);
+			ret = -EINVAL;
+			goto free_req;
+		}
+		req->data_iovs--;
+	}
+
+	if (!info.npkts || req->data_iovs > ARRAY_SIZE(req->iovs)) {
+		SDMA_DBG(req, "Too many vectors (%u/%u)", req->data_iovs,
+			 (u32)ARRAY_SIZE(req->iovs));
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	if (req_has_meminfo(info.ctrl)) {
+		/* Copy the meminfo from the user buffer */
+		if (iovec[idx].iov_len < infosz + sizeof(req->meminfo)) {
+			SDMA_DBG(req, "First vector not big enough for meminfo %lu/%lu",
+				 iovec[idx].iov_len,
+				 infosz + sizeof(req->meminfo));
+			ret = -EINVAL;
+			goto free_req;
+		}
+		ret = copy_from_user(&req->meminfo,
+				     iovec[idx].iov_base + sizeof(info),
+				     sizeof(req->meminfo));
+		if (ret) {
+			SDMA_DBG(req, "Failed to copy meminfo (%d)", ret);
+			ret = -EFAULT;
+			goto free_req;
+		}
+		header_offset = sizeof(info) + sizeof(req->meminfo);
+	} else {
+		req->meminfo.types = 0;
+		header_offset = sizeof(info);
+	}
+
+	/* copy in the PBC to find the packet type: 9B or 16B */
+	if (iovec[idx].iov_len < header_offset + sizeof(req->h.pbc)) {
+		SDMA_DBG(req, "First vector not big enough for pbc %lu/%lu",
+			 iovec[idx].iov_len,
+			 header_offset + sizeof(req->h.pbc));
+		ret = -EINVAL;
+		goto free_req;
+	}
+	ret = copy_from_user(&req->h.pbc, iovec[idx].iov_base + header_offset,
+			     sizeof(req->h.pbc));
+	if (ret) {
+		SDMA_DBG(req, "Failed to copy header template pbc (%d)", ret);
+		ret = -EFAULT;
+		goto free_req;
+	}
+	header_offset += sizeof(req->h.pbc);
+
+	cpu_pbc = le64_to_cpu(*(__le64 *)req->h.pbc);
+	vl = (cpu_pbc >> PBC_VL_SHIFT) & PBC_VL_MASK;
+
+	ret = check_pbc_16b(dd, cpu_pbc, &req->is16b);
+	if (ret) {
+		SDMA_DBG(req, "Bad header template PBC L2 type");
+		goto free_req;
+	}
+	if (req->is16b) {
+		/*
+		 * 16B not supported for WFR expected - all code here assumes
+		 * the ICRC QW does not land in memory.  Would require
+		 * coordination between library and driver.
+		 */
+		if (dd->params->chip_type == CHIP_WFR &&
+		    req_opcode(req->info.ctrl) == EXPECTED) {
+			SDMA_DBG(req, "WFR expected not supported");
+			ret = -EOPNOTSUPP;
+			goto free_req;
+		}
+
+		/* extra appended by the driver */
+		req->tailsize = 8; /* ICRC QW size */
+
+		req->hsize = sizeof(req->h.hdr16b);
+		rhdr = req->h.hdr16b.lrh; /* remainder of header */
+		bth = req->h.hdr16b.bth;
+		kdeth = &req->h.hdr16b.kdeth;
+	} else {
+		req->hsize = sizeof(req->h.hdr9b);
+		rhdr = req->h.hdr9b.lrh; /* remainder of header */
+		bth = req->h.hdr9b.bth;
+		kdeth = &req->h.hdr9b.kdeth;
+	}
+	rsize = req->hsize - sizeof(req->h.pbc); /* header remainder size */
+
+	/* copy in rest of header: LRH (9B or 16B), BTH, and KDETH */
+	if (iovec[idx].iov_len < header_offset + rsize) {
+		SDMA_DBG(req, "First vector not big enough for header %lu/%lu",
+			 iovec[idx].iov_len,
+			 header_offset + rsize);
+		ret = -EINVAL;
+		goto free_req;
+	}
+	ret = copy_from_user(rhdr, iovec[idx].iov_base + header_offset, rsize);
+	if (ret) {
+		SDMA_DBG(req, "Failed to copy header template (%d)", ret);
+		ret = -EFAULT;
+		goto free_req;
+	}
+
+	if (req->is16b) {
+		struct hfi2_16b_header *hdr = rhdr;
+
+		if (hfi2_16B_get_l2(hdr) != PBC_L2_16B) {
+			SDMA_DBG(req, "Non-matching L2 (%d)",
+				 hfi2_16B_get_l2(hdr));
+			ret = -EINVAL;
+			goto free_req;
+		}
+
+		sc = hfi2_16B_get_sc(hdr);
+		slid = hfi2_16B_get_slid(hdr);
+		dlid = hfi2_16B_get_dlid(hdr);
+		lrh_grh = hfi2_16B_get_l4(hdr) == OPA_16B_L4_IB_GLOBAL;
+		req->lrh_len_bytes = hfi2_16B_get_len(hdr) << 3;
+		req->pad_mask = 0x7; /* round up to 8 bytes */
+	} else {
+		struct ib_header *hdr = rhdr;
+		bool sc4 = (le16_to_cpu(req->h.hdr9b.pbc[1]) >> 14) & 0x1;
+
+		/* sanitize the pbc if no rate control */
+		if (!HFI2_CAP_IS_USET(STATIC_RATE_CTRL))
+			req->h.hdr9b.pbc[2] = 0;
+
+		sc = hfi2_9B_get_sc5(hdr, sc4);
+		slid = ib_get_slid(hdr);
+		dlid = ib_get_dlid(hdr);
+		lrh_grh = ib_get_lnh(hdr) == HFI2_LRH_GRH;
+		req->lrh_len_bytes = ib_get_len(hdr) << 2;
+		req->pad_mask = 0x3; /* round up to 4 bytes */
+	}
+
+	/* Validate the opcode. Do not trust packets from user space blindly. */
+	opcode = (be32_to_cpu(bth[0]) >> 24) & 0xff;
+	if ((opcode & USER_OPCODE_CHECK_MASK) !=
+	     USER_OPCODE_CHECK_VAL) {
+		SDMA_DBG(req, "Invalid opcode (%d)", opcode);
+		ret = -EINVAL;
+		goto free_req;
+	}
+	/*
+	 * Validate the vl. Do not trust packets from user space blindly.
+	 * VL comes from PBC, SC comes from LRH, and the VL needs to
+	 * match the SC look up.
+	 */
+	if (vl >= ppd->vls_operational || vl != sc_to_vlt(ppd, sc)) {
+		SDMA_DBG(req, "Invalid SC(%u)/VL(%u)", sc, vl);
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	/* Checking P_KEY for requests from user-space */
+	pkey = (u16)be32_to_cpu(bth[0]);
+	if (egress_pkey_check(ppd, slid, pkey, sc, PKEY_CHECK_INVALID)) {
+		ret = -EINVAL;
+		SDMA_DBG(req, "P_KEY check failed\n");
+		goto free_req;
+	}
+
+	/*
+	 * Also should check the BTH.lnh. If it says the next header is GRH then
+	 * the RXE parsing will be off and will land in the middle of the KDETH
+	 * or miss it entirely.
+	 */
+	if (lrh_grh) {
+		SDMA_DBG(req, "User tried to pass in a GRH");
+		ret = -EINVAL;
+		goto free_req;
+	}
+
+	req->koffset = le32_to_cpu(kdeth->swdata[6]);
+	/*
+	 * Calculate the initial TID offset based on the values of
+	 * KDETH.OFFSET and KDETH.OM that are passed in.
+	 */
+	req->tidoffset = KDETH_GET(kdeth->ver_tid_offset, OFFSET) *
+		(KDETH_GET(kdeth->ver_tid_offset, OM) ?
+		 KDETH_OM_LARGE : KDETH_OM_SMALL);
+	trace_hfi2_sdma_user_initial_tidoffset(dd, uctxt->ctxt, fd->subctxt,
+					       info.comp_idx, req->tidoffset);
+	idx++;
+
+	/* Save all the IO vector structures */
+	for (i = 0; i < req->data_iovs; i++) {
+		req->iovs[i].type =
+			HFI2_MEMINFO_TYPE_ENTRY_GET(req->meminfo.types, i);
+		if (!pinning_type_supported(req->iovs[i].type)) {
+			SDMA_DBG(req, "Pinning type not supported: %u\n",
+				 req->iovs[i].type);
+			req->data_iovs = i;
+			ret = -EINVAL;
+			goto free_req;
+		}
+		req->iovs[i].context = req->meminfo.context[i];
+		req->iovs[i].offset = 0;
+		memcpy(&req->iovs[i].iov,
+		       iovec + idx++,
+		       sizeof(req->iovs[i].iov));
+		if (req->iovs[i].iov.iov_len == 0) {
+			ret = -EINVAL;
+			goto free_req;
+		}
+		req->data_len += req->iovs[i].iov.iov_len;
+	}
+	trace_hfi2_sdma_user_data_length(dd, uctxt->ctxt, fd->subctxt,
+					 info.comp_idx, req->data_len);
+	/* reject if not enough data provided for the template */
+	if (req->data_len < template_data_len(req)) {
+		ret = -EINVAL;
+		goto free_req;
+	}
+	if (pcount > req->info.npkts)
+		pcount = req->info.npkts;
+	/*
+	 * Copy any TID info
+	 * User space will provide the TID info only when the
+	 * request type is EXPECTED. This is true even if there is
+	 * only one packet in the request and the header is already
+	 * setup. The reason for the singular TID case is that the
+	 * driver needs to perform safety checks.
+	 */
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		u16 ntids = iovec[idx].iov_len / sizeof(*req->tids);
+		u32 *tmp;
+
+		if (!ntids || ntids > MAX_TID_PAIR_ENTRIES) {
+			ret = -EINVAL;
+			goto free_req;
+		}
+
+		/*
+		 * We have to copy all of the tids because they may vary
+		 * in size and, therefore, the TID count might not be
+		 * equal to the pkt count. However, there is no way to
+		 * tell at this point.
+		 */
+		tmp = memdup_array_user(iovec[idx].iov_base,
+					ntids, sizeof(*req->tids));
+		if (IS_ERR(tmp)) {
+			ret = PTR_ERR(tmp);
+			SDMA_DBG(req, "Failed to copy %d TIDs (%d)",
+				 ntids, ret);
+			goto free_req;
+		}
+		req->tids = tmp;
+		req->n_tids = ntids;
+		req->tididx = 0;
+		idx++;
+	}
+
+	selector = dlid_to_selector(dlid);
+	selector += uctxt->ctxt + fd->subctxt;
+	req->sde = sdma_select_user_engine(ppd, selector, vl);
+
+	if (!req->sde || !sdma_running(req->sde)) {
+		ret = -ECOMM;
+		goto free_req;
+	}
+
+	/* We don't need an AHG entry if the request contains only one packet */
+	if (req->info.npkts > 1 && HFI2_CAP_IS_USET(SDMA_AHG))
+		req->ahg_idx = sdma_ahg_alloc(req->sde);
+
+	set_comp_state(pq, cq, info.comp_idx, QUEUED, 0);
+	pq->state = SDMA_PKT_Q_ACTIVE;
+
+	/*
+	 * This is a somewhat blocking send implementation.
+	 * The driver will block the caller until all packets of the
+	 * request have been submitted to the SDMA engine. However, it
+	 * will not wait for send completions.
+	 */
+	while (req->seqsubmitted != req->info.npkts) {
+		ret = user_sdma_send_pkts(req, pcount);
+		if (ret < 0) {
+			int we_ret;
+
+			if (ret != -EBUSY)
+				goto free_req;
+			we_ret = wait_event_interruptible_timeout(
+				pq->busy.wait_dma,
+				pq->state == SDMA_PKT_Q_ACTIVE,
+				msecs_to_jiffies(
+					SDMA_IOWAIT_TIMEOUT));
+			trace_hfi2_usdma_we(pq, we_ret);
+			if (we_ret <= 0)
+				flush_pq_iowait(pq);
+		}
+	}
+	*count += idx;
+	return 0;
+free_req:
+	/*
+	 * If the submitted seqsubmitted == npkts, the completion routine
+	 * controls the final state.  If sequbmitted < npkts, wait for any
+	 * outstanding packets to finish before cleaning up.
+	 */
+	if (req->seqsubmitted < req->info.npkts) {
+		if (req->seqsubmitted)
+			wait_event(pq->busy.wait_dma,
+				   (req->seqcomp == req->seqsubmitted - 1));
+		user_sdma_free_request(req);
+		pq_update(pq);
+		set_comp_state(pq, cq, info.comp_idx, ERROR, ret);
+	}
+	return ret;
+}
+
+/*
+ * Determine the proper size of the packet data.
+ *
+ * The size of the data of the first packet is in the header template.
+ *
+ * The size of the remaining packets is the minimum of the frag size (MTU)
+ * or remaining data in the request.
+ */
+static inline u32 compute_data_length(struct user_sdma_request *req)
+{
+	u32 len;
+
+	if (!req->seqnum) {
+		len = template_data_len(req);
+	} else if (req_opcode(req->info.ctrl) == EXPECTED) {
+		u32 tidlen = EXP_TID_GET(req->tids[req->tididx], LEN) *
+			EXP_TID_ADDR_SIZE;
+		/*
+		 * Get the data length based on the remaining space in the
+		 * TID pair.
+		 */
+		len = min(tidlen - req->tidoffset, (u32)req->info.fragsize);
+		/* If we've filled up the TID pair, move to the next one. */
+		if (unlikely(!len) && ++req->tididx < req->n_tids &&
+		    req->tids[req->tididx]) {
+			tidlen = EXP_TID_GET(req->tids[req->tididx],
+					     LEN) * EXP_TID_ADDR_SIZE;
+			req->tidoffset = 0;
+			len = min_t(u32, tidlen, req->info.fragsize);
+		}
+		/*
+		 * Since the TID pairs map entire pages, make sure that we
+		 * are not going to try to send more data that we have
+		 * remaining.
+		 */
+		len = min(len, req->data_len - req->sent);
+	} else {
+		len = min(req->data_len - req->sent, (u32)req->info.fragsize);
+	}
+	trace_hfi2_sdma_user_compute_length(req->pq->dd,
+					    req->pq->ctxt,
+					    req->pq->subctxt,
+					    req->info.comp_idx,
+					    len);
+	return len;
+}
+
+static inline u32 pad_len(struct user_sdma_request *req, u32 len)
+{
+	return (len + req->pad_mask) & ~req->pad_mask;
+}
+
+/*
+ * Return in bytes the size to be put into the LRH
+ */
+static inline u32 get_lrh_len(struct user_sdma_request *req, u32 len)
+{
+	if (req->is16b) {
+		/* header - PBC + data length + trailing ICRC QW */
+		return req->hsize - sizeof(u64) + len + 8;
+	}
+
+	/* (Size of complete header - size of PBC) + 4B ICRC + data length */
+	return req->hsize - sizeof(u64) + 4 + len;
+}
+
+/*
+ * Convert a PBC length (DW) to an LRH length (bytes).  Important: incoming
+ * PBC length is whole bottom of PBC, be sure to mask.
+ */
+static inline u16 pbc2lrh(struct user_sdma_request *req, u16 pbclen)
+{
+	if (req->is16b) {
+		/*
+		 * 16B: Both PBC and LRH include QW ICRC, just subtract off PBC.
+		 */
+		return ((pbclen & 0xfff) - 2) << 2;
+	}
+	/* 9B: len - PBC + ICRC */
+	return ((pbclen & 0xfff) - 2 + 1) << 2;
+}
+
+/* convert a LRH length (bytes) to a PBC length (DW) */
+static inline u16 lrh2pbc(struct user_sdma_request *req, u16 lrhlen)
+{
+	if (req->is16b) {
+		/* 16B: to DW, ICRC QW already included, add 2 for PBC */
+		return ((lrhlen >> 2) + 2) & 0xfff;
+	}
+	/*
+	 * 9B: to DW, len includes ICRC use that for half of PBC, add 1 for
+	 * second half of PBC
+	 */
+	return ((lrhlen >> 2) + 1) & 0xfff;
+}
+
+static int user_sdma_txadd_ahg(struct user_sdma_request *req,
+			       struct user_sdma_txreq *tx,
+			       u32 datalen)
+{
+	int ret;
+	u16 pbclen = le16_to_cpu(req->h.pbc[0]);
+	u32 lrhlen = get_lrh_len(req, pad_len(req, datalen));
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+
+	/*
+	 * Copy the request header into the tx header
+	 * because the HW needs a cacheline-aligned
+	 * address.
+	 * This copy can be optimized out if the hdr
+	 * member of user_sdma_request were also
+	 * cacheline aligned.
+	 */
+	memcpy(&tx->h, &req->h, req->hsize);
+	if (pbc2lrh(req, pbclen) != lrhlen) {
+		pbclen = (pbclen & 0xf000) | lrh2pbc(req, lrhlen);
+		tx->h.pbc[0] = cpu_to_le16(pbclen);
+	}
+	ret = check_header_template(req, tx, lrhlen, datalen);
+	if (ret)
+		return ret;
+	ret = sdma_txinit_ahg(pq->dd, &tx->txreq, SDMA_TXREQ_F_AHG_COPY,
+			      req->hsize + datalen, req->ahg_idx,
+			      0, NULL, 0, user_sdma_txreq_cb);
+	if (ret)
+		return ret;
+	ret = sdma_txadd_kvaddr(pq->dd, &tx->txreq, &tx->h, req->hsize);
+	if (ret)
+		sdma_txclean(pq->dd, &tx->txreq);
+	return ret;
+}
+
+static void free_pinref(struct user_sdma_pinref *d)
+{
+	pinning_interfaces[d->memtype].put(d->ptr);
+}
+
+static void free_pinrefs(struct user_sdma_pinref *pinrefs, u16 n_pinrefs)
+{
+	u16 i;
+
+	if (!pinrefs)
+		return;
+	for (i = 0; i < n_pinrefs; i++)
+		free_pinref(&pinrefs[i]);
+}
+
+/**
+ * Evict + free a pinref last-used by a now-completed packet (user_sdma_txreq).
+ */
+static inline int evict_complete_pinref(struct user_sdma_request *req)
+{
+	u16 i;
+
+	for (i = 0; i < req->n_pinrefs; i++) {
+		if (req->pinrefs[i].req_seqnum > req->seqcomp)
+			continue;
+		free_pinref(&req->pinrefs[i]);
+		req->pinrefs[i].ptr = NULL;
+		req->n_pinrefs--;
+		return i;
+	}
+
+	return -ENOMEM;
+}
+
+/*
+ * @return:
+ * * 0 on success
+ * * -EINVAL or -ENOMEM on error
+ */
+static int request_add_ref(struct user_sdma_request *req, void *ptr,
+			   u16 memtype)
+{
+	int ret;
+	u16 i;
+
+	if (req->n_pinrefs >= ARRAY_SIZE(req->pinrefs)) {
+		ret = evict_complete_pinref(req);
+		if (ret < 0)
+			return ret;
+		i = (u16)ret;
+	} else {
+		i = req->n_pinrefs;
+	}
+	req->n_pinrefs++;
+	req->pinrefs[i].ptr = ptr;
+	req->pinrefs[i].memtype = memtype;
+	req->pinrefs[i].req_seqnum = req->seqnum;
+	req->pinrefs[i].pinref_seqnum = req->pinref_seqnum++;
+	return 0;
+}
+
+/*
+ * Add pinref made from (@ptr,@put) to @tx->pinrefs.
+ */
+static int txreq_add_ref(struct user_sdma_txreq *tx, void *ptr,
+			 u16 memtype)
+{
+	u16 i;
+
+	/* Should not happen; internal error, check just in case */
+	if (WARN_ON_ONCE(tx->n_pinrefs >= MAX_DESC))
+		return -ENOMEM;
+	if (!tx->pinrefs) {
+		size_t bytes;
+
+		bytes = array_size(MAX_DESC, sizeof(tx->pinrefs[0]));
+		tx->pinrefs = kmalloc(bytes, GFP_KERNEL);
+		if (!tx->pinrefs)
+			return -ENOMEM;
+	}
+	i = tx->n_pinrefs++;
+	tx->pinrefs[i].ptr = ptr;
+	tx->pinrefs[i].memtype = memtype;
+	/* .req_seqnum and .pinref_seqnum are N/A for pinrefs in tx->pinrefs */
+	return 0;
+}
+
+/**
+ * Try adding @ptr to @tx->req->pinrefs first but add to @tx->pinrefs if
+ * there is no space in @tx->req->pinrefs.
+ */
+int hfi2_user_sdma_add_ref(struct user_sdma_txreq *tx, void *ptr,
+			   u16 memtype)
+{
+	int ret;
+
+	/* Should not happen; internal error, check just in case */
+	if (WARN_ON_ONCE(!ptr || !pinning_type_supported(memtype)))
+		return -EINVAL;
+	if (WARN_ON_ONCE(!pinning_interfaces[memtype].put))
+		return -EINVAL;
+	ret = request_add_ref(tx->req, ptr, memtype);
+	if (!ret)
+		return 0;
+	if (ret != -ENOMEM)
+		return ret;
+	/* No space in req->pinrefs and no entries could be evicted */
+	return txreq_add_ref(tx, ptr, memtype);
+}
+
+/**
+ * @return most-recently used pinref for @memtype from @tx->req. Most-recent
+ *         determined by &user_sdma_pinref->pinref_seqnum.
+ */
+struct user_sdma_pinref *
+hfi2_user_sdma_mru_ref(struct user_sdma_txreq *tx, u16 memtype)
+{
+	struct user_sdma_request *req = tx->req;
+	struct user_sdma_pinref *mru = NULL;
+	u16 i;
+
+	for (i = 0; i < req->n_pinrefs; i++) {
+		if (req->pinrefs[i].memtype != memtype)
+			continue;
+		if (!mru || req->pinrefs[i].pinref_seqnum > mru->pinref_seqnum)
+			mru = &req->pinrefs[i];
+	}
+
+	return mru;
+}
+
+/**
+ * Update @d->req_seqnum and @d->pinref_seqnum from @tx->req.
+ */
+void hfi2_user_sdma_touch_ref(struct user_sdma_txreq *tx,
+			      struct user_sdma_pinref *d)
+{
+	d->req_seqnum = tx->req->seqnum;
+	d->pinref_seqnum = tx->req->pinref_seqnum++;
+}
+
+static void user_sdma_free_txreq(struct user_sdma_txreq *tx)
+{
+	free_pinrefs(tx->pinrefs, tx->n_pinrefs);
+	kfree(tx->pinrefs);
+	kmem_cache_free(tx->req->pq->txreq_cache, tx);
+}
+
+static int user_sdma_send_pkts(struct user_sdma_request *req, u16 maxpkts)
+{
+	int ret = 0;
+	u16 count;
+	unsigned npkts = 0;
+	struct user_sdma_txreq *tx = NULL;
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct hfi2_devdata *dd;
+	struct user_sdma_iovec *iovec = NULL;
+
+	if (!req->pq)
+		return -EINVAL;
+
+	pq = req->pq;
+	dd = pq->dd;
+
+	/* If tx completion has reported an error, we are done. */
+	if (READ_ONCE(req->has_error))
+		return -EFAULT;
+
+	/*
+	 * Check if we might have sent the entire request already
+	 */
+	if (unlikely(req->seqnum == req->info.npkts)) {
+		if (!list_empty(&req->txps))
+			goto dosend;
+		return ret;
+	}
+
+	if (!maxpkts || maxpkts > req->info.npkts - req->seqnum)
+		maxpkts = req->info.npkts - req->seqnum;
+
+	while (npkts < maxpkts) {
+		u32 datalen = 0;
+
+		/*
+		 * Check whether any of the completions have come back
+		 * with errors. If so, we are not going to process any
+		 * more packets from this request.
+		 */
+		if (READ_ONCE(req->has_error))
+			return -EFAULT;
+
+		tx = kmem_cache_alloc(pq->txreq_cache, GFP_KERNEL);
+		if (!tx)
+			return -ENOMEM;
+		tx->pinrefs = NULL;
+		tx->n_pinrefs = 0;
+		tx->flags = 0;
+		tx->req = req;
+		/*
+		 * For the last packet set the ACK request
+		 * and disable header suppression.
+		 */
+		if (req->seqnum == req->info.npkts - 1)
+			tx->flags |= (TXREQ_FLAGS_REQ_ACK |
+				      TXREQ_FLAGS_REQ_DISABLE_SH);
+
+		/*
+		 * Calculate the payload size - this is min of the fragment
+		 * (MTU) size or the remaining bytes in the request but only
+		 * if we have payload data.
+		 */
+		if (req->data_len) {
+			iovec = &req->iovs[req->iov_idx];
+			if (READ_ONCE(iovec->offset) == iovec->iov.iov_len) {
+				if (++req->iov_idx == req->data_iovs) {
+					ret = -EFAULT;
+					goto free_tx;
+				}
+				iovec = &req->iovs[req->iov_idx];
+				WARN_ON(iovec->offset);
+			}
+
+			datalen = compute_data_length(req);
+
+			/*
+			 * Disable header suppression for the payload <= 8DWS.
+			 * If there is an uncorrectable error in the receive
+			 * data FIFO when the received payload size is less than
+			 * or equal to 8DWS then the RxDmaDataFifoRdUncErr is
+			 * not reported.There is set RHF.EccErr if the header
+			 * is not suppressed.
+			 */
+			if (!datalen) {
+				SDMA_DBG(req,
+					 "Request has data but pkt len is 0");
+				ret = -EFAULT;
+				goto free_tx;
+			} else if (datalen <= 32) {
+				tx->flags |= TXREQ_FLAGS_REQ_DISABLE_SH;
+			}
+		}
+
+		if (req->ahg_idx >= 0) {
+			if (!req->seqnum) {
+				ret = user_sdma_txadd_ahg(req, tx, datalen);
+				if (ret)
+					goto free_tx;
+			} else {
+				int changes;
+
+				changes = set_txreq_header_ahg(req, tx, datalen);
+				if (changes < 0) {
+					ret = changes;
+					goto free_tx;
+				}
+			}
+		} else {
+			ret = sdma_txinit(dd, &tx->txreq, 0,
+					  req->hsize + datalen + req->tailsize,
+					  user_sdma_txreq_cb);
+			if (ret)
+				goto free_tx;
+			/*
+			 * Modify the header for this packet. This only needs
+			 * to be done if we are not going to use AHG. Otherwise,
+			 * the HW will do it based on the changes we gave it
+			 * during sdma_txinit_ahg().
+			 */
+			ret = set_txreq_header(req, tx, datalen);
+			if (ret)
+				goto free_txreq;
+		}
+
+		req->koffset += datalen;
+		if (req_opcode(req->info.ctrl) == EXPECTED)
+			req->tidoffset += datalen;
+		req->sent += datalen;
+		while (datalen) {
+			ret = add_to_sdma_packet(iovec->type, req, tx, iovec,
+						 &datalen);
+			if (ret)
+				goto free_txreq;
+			iovec = &req->iovs[req->iov_idx];
+		}
+		/* 16B requests need to have the ICRC QW added */
+		if (req->is16b) {
+			ret = sdma_txadd_daddr(dd, &tx->txreq,
+					       dd->sdma_pad_phys, 8);
+			if (ret)
+				goto free_txreq;
+		}
+		list_add_tail(&tx->txreq.list, &req->txps);
+		/*
+		 * It is important to increment this here as it is used to
+		 * generate the BTH.PSN and, therefore, can't be bulk-updated
+		 * outside of the loop.
+		 */
+		tx->seqnum = req->seqnum++;
+		npkts++;
+	}
+dosend:
+	ret = sdma_send_txlist(req->sde,
+			       iowait_get_ib_work(&pq->busy),
+			       &req->txps, &count);
+	req->seqsubmitted += count;
+	if (req->seqsubmitted == req->info.npkts) {
+		/*
+		 * The txreq has already been submitted to the HW queue
+		 * so we can free the AHG entry now. Corruption will not
+		 * happen due to the sequential manner in which
+		 * descriptors are processed.
+		 */
+		if (req->ahg_idx >= 0)
+			sdma_ahg_free(req->sde, req->ahg_idx);
+	}
+	return ret;
+
+free_txreq:
+	sdma_txclean(dd, &tx->txreq);
+free_tx:
+	user_sdma_free_txreq(tx);
+	return ret;
+}
+
+static int check_header_template(struct user_sdma_request *req,
+				 struct user_sdma_txreq *tx, u32 lrhlen,
+				 u32 datalen)
+{
+	/*
+	 * Perform safety checks for any type of packet:
+	 *    - transfer size is multiple of 64bytes
+	 *    - packet length is multiple of pad_mask+1 (4 or 8) bytes
+	 *    - packet length is not larger than MTU size
+	 *
+	 * These checks are only done for the first packet of the
+	 * transfer since the header is "given" to us by user space.
+	 * For the remainder of the packets we compute the values.
+	 */
+	if (req->info.fragsize % PIO_BLOCK_SIZE || lrhlen & req->pad_mask ||
+	    lrhlen > get_lrh_len(req, req->info.fragsize))
+		return -EINVAL;
+
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		/*
+		 * The header is checked only on the first packet. Furthermore,
+		 * we ensure that at least one TID entry is copied when the
+		 * request is submitted. Therefore, we don't have to verify that
+		 * tididx points to something sane.
+		 */
+		u32 tidval = req->tids[req->tididx],
+			tidlen = EXP_TID_GET(tidval, LEN) * EXP_TID_ADDR_SIZE,
+			tididx = EXP_TID_GET(tidval, IDX),
+			tidctrl = EXP_TID_GET(tidval, CTRL),
+			tidoff;
+		__le32 kval;
+		struct hfi2_kdeth_header *kdeth;
+
+		if (req->is16b) {
+			kval = tx->h.hdr16b.kdeth.ver_tid_offset;
+			kdeth = &req->h.hdr16b.kdeth;
+		} else {
+			kval = tx->h.hdr9b.kdeth.ver_tid_offset;
+			kdeth = &req->h.hdr9b.kdeth;
+		}
+		tidoff = KDETH_GET(kval, OFFSET) *
+			  (KDETH_GET(kdeth->ver_tid_offset, OM) ?
+			   KDETH_OM_LARGE : KDETH_OM_SMALL);
+		/*
+		 * Expected receive packets have the following
+		 * additional checks:
+		 *     - offset is not larger than the TID size
+		 *     - TIDCtrl values match between header and TID array
+		 *     - TID indexes match between header and TID array
+		 */
+		if ((tidoff + datalen > tidlen) ||
+		    KDETH_GET(kval, TIDCTRL) != tidctrl ||
+		    KDETH_GET(kval, TID) != tididx)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+/*
+ * Correctly set the BTH.PSN field based on type of
+ * transfer - eager packets can just increment the PSN but
+ * expected packets encode generation and sequence in the
+ * BTH.PSN field so just incrementing will result in errors.
+ */
+static inline u32 set_pkt_bth_psn(__be32 bthpsn, u8 expct, u32 frags)
+{
+	u32 val = be32_to_cpu(bthpsn),
+		mask = (HFI2_CAP_IS_KSET(EXTENDED_PSN) ? 0x7fffffffull :
+			0xffffffull),
+		psn = val & mask;
+	if (expct)
+		psn = (psn & ~HFI2_KDETH_BTH_SEQ_MASK) |
+			((psn + frags) & HFI2_KDETH_BTH_SEQ_MASK);
+	else
+		psn = psn + frags;
+	return psn & mask;
+}
+
+/* set the length field of a 16B LRH header */
+static inline void hfi2_16B_set_len(__le32 *lrh, u32 len)
+{
+	u32 value;
+
+	value = le32_to_cpu(lrh[0]);
+	value &= ~OPA_16B_LEN_MASK;
+	value |= OPA_16B_LEN_MASK & (len << OPA_16B_LEN_SHIFT);
+	lrh[0] = cpu_to_le32(value);
+}
+
+static int set_txreq_header(struct user_sdma_request *req,
+			    struct user_sdma_txreq *tx, u32 datalen)
+{
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	struct hfi2_kdeth_header *kdeth;
+	__be32 *bth;
+	u8 omfactor; /* KDETH.OM */
+	u16 pbclen;
+	int ret;
+	u32 tidval = 0, lrhlen = get_lrh_len(req, pad_len(req, datalen));
+
+	/* Copy the header template to the request before modification */
+	memcpy(&tx->h, &req->h, req->hsize);
+
+	/*
+	 * Check if the PBC and LRH length are mismatched. If so
+	 * adjust both in the header.
+	 */
+	pbclen = le16_to_cpu(tx->h.pbc[0]);
+	if (pbc2lrh(req, pbclen) != lrhlen) {
+		pbclen = (pbclen & 0xf000) | lrh2pbc(req, lrhlen);
+		tx->h.pbc[0] = cpu_to_le16(pbclen);
+		if (req->is16b)
+			hfi2_16B_set_len(tx->h.hdr16b.lrh, lrhlen >> 3);
+		else
+			tx->h.hdr9b.lrh[2] = cpu_to_be16(lrhlen >> 2);
+		/*
+		 * Third packet
+		 * This is the first packet in the sequence that has
+		 * a "static" size that can be used for the rest of
+		 * the packets (besides the last one).
+		 */
+		if (unlikely(req->seqnum == 2)) {
+			/*
+			 * From this point on the lengths in both the
+			 * PBC and LRH are the same until the last
+			 * packet.
+			 * Adjust the template so we don't have to update
+			 * every packet
+			 */
+			req->h.pbc[0] = tx->h.pbc[0];
+			if (req->is16b)
+				hfi2_16B_set_len(req->h.hdr16b.lrh, lrhlen >> 3);
+			else
+				req->h.hdr9b.lrh[2] = tx->h.hdr9b.lrh[2];
+		}
+	}
+	/*
+	 * We only have to modify the header if this is not the
+	 * first packet in the request. Otherwise, we use the
+	 * header given to us.
+	 */
+	if (unlikely(!req->seqnum)) {
+		ret = check_header_template(req, tx, lrhlen, datalen);
+		if (ret)
+			return ret;
+		goto done;
+	}
+
+	if (req->is16b) {
+		bth = tx->h.hdr16b.bth;
+		kdeth = &tx->h.hdr16b.kdeth;
+	} else {
+		bth = tx->h.hdr9b.bth;
+		kdeth = &tx->h.hdr9b.kdeth;
+	}
+
+	bth[2] = cpu_to_be32(set_pkt_bth_psn(bth[2],
+			     (req_opcode(req->info.ctrl) == EXPECTED),
+			     req->seqnum));
+
+	/* Set ACK request on last packet */
+	if (unlikely(tx->flags & TXREQ_FLAGS_REQ_ACK))
+		bth[2] |= cpu_to_be32(1UL << 31);
+
+	/* Set the new offset */
+	kdeth->swdata[6] = cpu_to_le32(req->koffset);
+	/* Expected packets have to fill in the new TID information */
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		tidval = req->tids[req->tididx];
+		/*
+		 * If the offset puts us at the end of the current TID,
+		 * advance everything.
+		 */
+		if ((req->tidoffset) == (EXP_TID_GET(tidval, LEN) *
+					 EXP_TID_ADDR_SIZE)) {
+			req->tidoffset = 0;
+			/*
+			 * Since we don't copy all the TIDs, all at once,
+			 * we have to check again.
+			 */
+			if (++req->tididx > req->n_tids - 1 ||
+			    !req->tids[req->tididx]) {
+				return -EINVAL;
+			}
+			tidval = req->tids[req->tididx];
+		}
+		omfactor = EXP_TID_GET(tidval, LEN) * EXP_TID_ADDR_SIZE >=
+			KDETH_OM_MAX_SIZE ? KDETH_OM_LARGE_SHIFT :
+			KDETH_OM_SMALL_SHIFT;
+		/* Set KDETH.TIDCtrl based on value for this TID. */
+		KDETH_SET(kdeth->ver_tid_offset, TIDCTRL,
+			  EXP_TID_GET(tidval, CTRL));
+		/* Set KDETH.TID based on value for this TID */
+		KDETH_SET(kdeth->ver_tid_offset, TID,
+			  EXP_TID_GET(tidval, IDX));
+		/* Clear KDETH.SH when DISABLE_SH flag is set */
+		if (unlikely(tx->flags & TXREQ_FLAGS_REQ_DISABLE_SH))
+			KDETH_SET(kdeth->ver_tid_offset, SH, 0);
+		/*
+		 * Set the KDETH.OFFSET and KDETH.OM based on size of
+		 * transfer.
+		 */
+		trace_hfi2_sdma_user_tid_info(
+			pq->dd, pq->ctxt, pq->subctxt, req->info.comp_idx,
+			req->tidoffset, req->tidoffset >> omfactor,
+			omfactor != KDETH_OM_SMALL_SHIFT);
+		KDETH_SET(kdeth->ver_tid_offset, OFFSET,
+			  req->tidoffset >> omfactor);
+		KDETH_SET(kdeth->ver_tid_offset, OM,
+			  omfactor != KDETH_OM_SMALL_SHIFT);
+	}
+done:
+	if (req->is16b) {
+		trace_hfi2_sdma_user_header16b(pq->dd, pq->ctxt, pq->subctxt,
+					       req->info.comp_idx,
+					       &tx->h.hdr16b, tidval);
+	} else {
+		trace_hfi2_sdma_user_header(pq->dd, pq->ctxt, pq->subctxt,
+					    req->info.comp_idx,
+					    &tx->h.hdr9b, tidval);
+	}
+	return sdma_txadd_kvaddr(pq->dd, &tx->txreq, &tx->h, req->hsize);
+}
+
+static int set_txreq_header_ahg(struct user_sdma_request *req,
+				struct user_sdma_txreq *tx, u32 datalen)
+{
+	u32 ahg[AHG_KDETH_ARRAY_SIZE];
+	int idx = 0;
+	u8 omfactor; /* KDETH.OM */
+	u8 off;
+	struct hfi2_user_sdma_pkt_q *pq = req->pq;
+	__be32 *bth;
+	struct hfi2_kdeth_header *kdeth;
+	u16 pbclen = le16_to_cpu(req->h.pbc[0]);
+	u32 val32, tidval = 0, lrhlen = get_lrh_len(req, pad_len(req, datalen));
+	size_t array_size = ARRAY_SIZE(ahg);
+
+	if (pbc2lrh(req, pbclen) != lrhlen) {
+		/* PBC.PbcLengthDWs */
+		idx = ahg_header_set(ahg, idx, array_size, 0, 0, 12,
+				     (__force u16)cpu_to_le16(lrh2pbc(req, lrhlen)));
+		if (idx < 0)
+			return idx;
+		/* LRH.PktLen */
+		if (req->is16b) {
+			idx = ahg_header_set(ahg, idx, array_size, 3, 4, 11,
+					     (__force u16)cpu_to_le16(lrhlen >> 3));
+		} else {
+			/* 9B: need the full 16 bits due to byte swap */
+			idx = ahg_header_set(ahg, idx, array_size, 3, 0, 16,
+					     (__force u16)cpu_to_be16(lrhlen >> 2));
+		}
+		if (idx < 0)
+			return idx;
+	}
+
+	if (req->is16b) {
+		bth = tx->h.hdr16b.bth;
+		kdeth = &tx->h.hdr16b.kdeth;
+		off = 2; /* BTH and KDETH are 2 DW further in */
+	} else {
+		bth = tx->h.hdr9b.bth;
+		kdeth = &tx->h.hdr9b.kdeth;
+		off = 0; /* no extra DW offset */
+	}
+
+	/*
+	 * Do the common updates
+	 */
+	/* BTH.PSN and BTH.A */
+	val32 = (be32_to_cpu(bth[2]) + req->seqnum) &
+		(HFI2_CAP_IS_KSET(EXTENDED_PSN) ? 0x7fffffff : 0xffffff);
+	if (unlikely(tx->flags & TXREQ_FLAGS_REQ_ACK))
+		val32 |= 1UL << 31;
+	idx = ahg_header_set(ahg, idx, array_size, 6 + off, 0, 16,
+			     (__force u16)cpu_to_be16(val32 >> 16));
+	if (idx < 0)
+		return idx;
+	idx = ahg_header_set(ahg, idx, array_size, 6 + off, 16, 16,
+			     (__force u16)cpu_to_be16(val32 & 0xffff));
+	if (idx < 0)
+		return idx;
+	/* KDETH.Offset */
+	idx = ahg_header_set(ahg, idx, array_size, 15 + off, 0, 16,
+			     (__force u16)cpu_to_le16(req->koffset & 0xffff));
+	if (idx < 0)
+		return idx;
+	idx = ahg_header_set(ahg, idx, array_size, 15 + off, 16, 16,
+			     (__force u16)cpu_to_le16(req->koffset >> 16));
+	if (idx < 0)
+		return idx;
+	if (req_opcode(req->info.ctrl) == EXPECTED) {
+		__le16 val;
+		u16 tidoff;
+
+		tidval = req->tids[req->tididx];
+
+		/*
+		 * If the offset puts us at the end of the current TID,
+		 * advance everything.
+		 */
+		if ((req->tidoffset) == (EXP_TID_GET(tidval, LEN) *
+					 EXP_TID_ADDR_SIZE)) {
+			req->tidoffset = 0;
+			/*
+			 * Since we don't copy all the TIDs, all at once,
+			 * we have to check again.
+			 */
+			if (++req->tididx > req->n_tids - 1 ||
+			    !req->tids[req->tididx])
+				return -EINVAL;
+			tidval = req->tids[req->tididx];
+		}
+		omfactor = ((EXP_TID_GET(tidval, LEN) *
+				  EXP_TID_ADDR_SIZE) >=
+				 KDETH_OM_MAX_SIZE) ? KDETH_OM_LARGE_SHIFT :
+				 KDETH_OM_SMALL_SHIFT;
+		/* KDETH.OM and KDETH.OFFSET (TID) */
+		tidoff = ((!!(omfactor - KDETH_OM_SMALL_SHIFT)) << 15) |
+			 ((req->tidoffset >> omfactor) & 0x7fff);
+		idx = ahg_header_set(ahg, idx, array_size, 7 + off, 0, 16,
+				     tidoff);
+		if (idx < 0)
+			return idx;
+		/* KDETH.TIDCtrl, KDETH.TID, KDETH.Intr, KDETH.SH */
+		val = cpu_to_le16(((EXP_TID_GET(tidval, CTRL) & 0x3) << 10) |
+				   (EXP_TID_GET(tidval, IDX) & 0x3ff));
+
+		if (unlikely(tx->flags & TXREQ_FLAGS_REQ_DISABLE_SH)) {
+			val |= cpu_to_le16((KDETH_GET(kdeth->ver_tid_offset,
+						      INTR) <<
+					    AHG_KDETH_INTR_SHIFT));
+		} else {
+			val |= KDETH_GET(kdeth->ver_tid_offset, SH) ?
+			       cpu_to_le16(0x1 << AHG_KDETH_SH_SHIFT) :
+			       cpu_to_le16((KDETH_GET(kdeth->ver_tid_offset,
+						      INTR) <<
+					     AHG_KDETH_INTR_SHIFT));
+		}
+
+		idx = ahg_header_set(ahg, idx, array_size,
+				     7 + off, 16, 14, (__force u16)val);
+		if (idx < 0)
+			return idx;
+	}
+
+	trace_hfi2_sdma_user_header_ahg(pq->dd, pq->ctxt, pq->subctxt,
+					req->info.comp_idx, req->sde->this_idx,
+					req->ahg_idx, ahg, idx, tidval);
+	sdma_txinit_ahg(pq->dd, &tx->txreq,
+			SDMA_TXREQ_F_USE_AHG,
+			datalen, req->ahg_idx, idx,
+			ahg, req->hsize,
+			user_sdma_txreq_cb);
+
+	return idx;
+}
+
+/**
+ * user_sdma_txreq_cb() - SDMA tx request completion callback.
+ * @txreq: valid sdma tx request
+ * @status: success/failure of request
+ *
+ * Called when the SDMA progress state machine gets notification that
+ * the SDMA descriptors for this tx request have been processed by the
+ * DMA engine. Called in interrupt context.
+ * Only do work on completed sequences.
+ */
+static void user_sdma_txreq_cb(struct sdma_txreq *txreq, int status)
+{
+	struct user_sdma_txreq *tx =
+		container_of(txreq, struct user_sdma_txreq, txreq);
+	struct user_sdma_request *req;
+	struct hfi2_user_sdma_pkt_q *pq;
+	struct hfi2_user_sdma_comp_q *cq;
+	enum hfi2_sdma_comp_state state = COMPLETE;
+
+	if (!tx->req)
+		return;
+
+	req = tx->req;
+	pq = req->pq;
+	cq = req->cq;
+
+	if (status != SDMA_TXREQ_S_OK) {
+		SDMA_DBG(req, "SDMA completion with error %d",
+			 status);
+		WRITE_ONCE(req->has_error, 1);
+		state = ERROR;
+	}
+
+	req->seqcomp = tx->seqnum;
+	user_sdma_free_txreq(tx);
+
+	/* sequence isn't complete?  We are done */
+	if (req->seqcomp != req->info.npkts - 1)
+		return;
+
+	user_sdma_free_request(req);
+	set_comp_state(pq, cq, req->info.comp_idx, state, status);
+	pq_update(pq);
+}
+
+static inline void pq_update(struct hfi2_user_sdma_pkt_q *pq)
+{
+	if (atomic_dec_and_test(&pq->n_reqs))
+		wake_up(&pq->wait);
+}
+
+static void user_sdma_free_request(struct user_sdma_request *req)
+{
+	if (!list_empty(&req->txps)) {
+		struct sdma_txreq *t, *p;
+
+		list_for_each_entry_safe(t, p, &req->txps, list) {
+			struct user_sdma_txreq *tx =
+				container_of(t, struct user_sdma_txreq, txreq);
+			list_del_init(&t->list);
+			sdma_txclean(req->pq->dd, t);
+			user_sdma_free_txreq(tx);
+		}
+	}
+
+	free_pinrefs(req->pinrefs, req->n_pinrefs);
+	kfree(req->tids);
+	clear_bit(req->info.comp_idx, req->pq->req_in_use);
+}
+
+static inline void set_comp_state(struct hfi2_user_sdma_pkt_q *pq,
+				  struct hfi2_user_sdma_comp_q *cq,
+				  u16 idx, enum hfi2_sdma_comp_state state,
+				  int ret)
+{
+	if (state == ERROR)
+		cq->comps[idx].errcode = -ret;
+	smp_wmb(); /* make sure errcode is visible first */
+	cq->comps[idx].status = state;
+	trace_hfi2_sdma_user_completion(pq->dd, pq->ctxt, pq->subctxt,
+					idx, state, ret);
+}



