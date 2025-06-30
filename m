Return-Path: <linux-rdma+bounces-11777-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7143AEE63A
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8F23A5E21
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Jun 2025 17:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99892E7199;
	Mon, 30 Jun 2025 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="iD+gLTqC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2100.outbound.protection.outlook.com [40.107.212.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130A2E5419
	for <linux-rdma@vger.kernel.org>; Mon, 30 Jun 2025 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751306301; cv=fail; b=OaGmIeqm1j9NUYsg9Yufy/Nr7dyku4yxZ8qL/PXk5q3q0t6Kmus/Dy2CEnLA9WA4pmFvTA3OFNq1/f7KLykakhwKgUFyw67wX3GmOsZyFFmKsbRXyvl7oEgFWG+lHnFvADD8CufJFM20fJYxUyqgSq8e5VaMpdkkLGKU++oMapw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751306301; c=relaxed/simple;
	bh=nCt7Dz0/3UCSFHspcAIyxtrCSbbbQe00jCU9F4YHDSE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=li38Tu3TQFeGOcStOKl+yNKJ62xcj1o2ib0h7lJf73OhPmZqMGuOt3ukDfNDTol2NoHozORUowSRgD04WEfs8IuEU/p7CUumlMLVbM5uS8B2D5roYuljEFiXJGDH12/B3RsrrtZNFzYsOxqPjUJMiy0/kyECyzGEnv/jtX9EEAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=iD+gLTqC; arc=fail smtp.client-ip=40.107.212.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEdYMAX22inBxcnwSGxYLIIi5HS6zRQ2mp7bC3nZTVsTwO+fufo5Ze1fDIGeNs6WW/T45UObkQ+ajNwToXE7rS4Q1cRT2qwRh5tUQvps4PUOstuWB0aUdVNuJr5mQNxfs1uiXkuqunpwtMUQWIAObpXaysc+jU2BTqGGZTeS8uM2LKxPHQ0k+p38FvgkF+XO6Yx62e1rqKGdpBSORRXdCZ6nXaTwdKGtB9RKy0kSRHtA3axySzrdVB8QRM2ki0BYtR4SiY+ao4nAstTCO3IZU1FDF/W8m7pCXUQceSv8m2krrq9zMPWL2FawWfTRYwccoeOzWNxho+WkiFqY9sHg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vL6tgqjn7Y2UEXp3ejpjZYn/1DiANDCH3Zq80ivK7U=;
 b=ymvqOlMX5Aww9A7wuClLeI/5jxu7qgpVXt8tuZcUFXyZbmi+5WRoPSeG69ew0FCS3TR1xNLr40V4jkMtjdZnqLLzFzXE3+wmYxPb9DthIp2frgOutq3VqnGyr+9hK7k39hEd7VAV+2/GrQHYMCbz1UO9wVuLoNPFR4JwYOG+qantex6tQApavWulndQ2+grOshPouUZR4s7t+Hehwm22oUDdozcI0ESdFh2chPzOp2Do1gAMq3rHqwAySJt3/smCz6CGO/ITRKBqCsOYMbmJQveFPkdsER04ASim190K/1Poap82Wr+ZYXYcs7yYD8M9Wmf4+uo/6Guon4aFqC+Emw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vL6tgqjn7Y2UEXp3ejpjZYn/1DiANDCH3Zq80ivK7U=;
 b=iD+gLTqChhIvOrS1AZZFqpcfrglX4dFluVaWf/gax32dLSmtCPtRvbm+XpR62T68uEUBl2c/PSiHx8n3WyvBQRBULbZmxhkQ7q9TlegMXZ2TxHnL6zckobIfOpH67gej1qWHAae0iBuXtQKsVWVSxsLmS5Ckv4vWRiIBWHEA3XQbCscC6Iw/KHQWRQKp73mLDc9br30qik+azFOupT2VoFaPkCvAaoNaAobHx4QWFWJTqdNgFYxOFIH0FDH8J0/W/aJkk8agSQuShZnWmdqg+R6dzfCKI4Fbs+3NXkUbXB95qYH3RsZgyWdYGVqzC33ffxNQzmaWllaWYIcFEwY43A==
Received: from SA0PR12CA0010.namprd12.prod.outlook.com (2603:10b6:806:6f::15)
 by SA6PR01MB8902.prod.exchangelabs.com (2603:10b6:806:431::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.17; Mon, 30 Jun 2025 17:58:11 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::d1) by SA0PR12CA0010.outlook.office365.com
 (2603:10b6:806:6f::15) with Microsoft SMTP Server (version=TLS1_3,
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
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Mon, 30 Jun 2025 17:58:10 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id E17A214D730;
	Mon, 30 Jun 2025 13:58:06 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 4D2131848B5D0;
	Mon, 30 Jun 2025 11:30:43 -0400 (EDT)
Subject: [PATCH for-next 11/23] RDMA/hfi2: Add in trace header files
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Mon, 30 Jun 2025 11:30:43 -0400
Message-ID:
 <175129744326.1859400.17677623074656415268.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA6PR01MB8902:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e468130-ae88-4a95-4032-08ddb7ffad6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmFMYWJyZU9uOG9wWEYxREk5QmZEcDJETk91ZnRQRHU4OVdqRHJRSG1mQ1g3?=
 =?utf-8?B?azhQM0FuZGJCSDFWdzdLQ2NIU004WnhMVkJtZDFVZVRxTHphRTNubjYxaDVs?=
 =?utf-8?B?U1NTUkxWODNTTUN3V2lic0NodXM4dGh2M3hMb2YwTU9OZEdnckNVQklTT3NI?=
 =?utf-8?B?cmNZV1JVeXRjSDlnc3NReUwwNkhieUw1elpCdlZHNFAyTmJwbjVBNThIRWg4?=
 =?utf-8?B?Y2lHS000R281Q3hoWTNrdXlhdURLdG1QM0Rmdnh3QXJXR3cwNlMzeFBDRFJ0?=
 =?utf-8?B?NnV1dnVra0laQXk3RTk3VlNGaCs4NlVVSDRCSXZkc1RyZVQ1eitDZHVIYkNF?=
 =?utf-8?B?anU2djVVQXJSYVFKMEcxOFJTYXVPdEZyYnV4WElNWHU4cHBHOWltVGRFd2Jy?=
 =?utf-8?B?RzVCcW51Q2ZUZzloczc1MWQwQ3VhdTI4V09GTkNQZ3VYVWtZQVA1MSttZGVZ?=
 =?utf-8?B?MlVzMHJFNjRqU3dDMzI5R05rRDhBazVkS0xTUEcvb3BFcFNaaGZuZTR5NnhS?=
 =?utf-8?B?ZFMvQTFMckk4SW0vZDZIRm5pN1BMK25qYWhodUcyaS9CZnN2RU9QVXFQL2tB?=
 =?utf-8?B?cC9obTdEWXhWclJtTnpRRVU1UkJScVRtRUZxWFo1YitsbjROZ2MvaU1lOUtE?=
 =?utf-8?B?dXRsK2pqYWZ4UTNwTEtjZmV4andScGExQ3RFcjdOb2kyK3FFak1mQ3Y4NVpw?=
 =?utf-8?B?M0V0SHpRakd2ZkFxcVA2cUJnSXNTb2pzM1RTWGdUT0VKbHRwUnVoUG9adjJ4?=
 =?utf-8?B?bXFWUjg3ZWxhUzcyTVRSdExzUDI2NVdUTDcveFIvNDZLZTR6UkdNY0ZySU5p?=
 =?utf-8?B?TzZJNnZTcG9XK0ZaaGtYMjIxL21ZNmN4Nkh1WU1lUEdDYldZZ2lNQWNLUk1t?=
 =?utf-8?B?cU9SS24weVRQUDZPdEMrenBrcFFPRldZbVE5eStjU0VoUkd1dzRrZEJTbm9O?=
 =?utf-8?B?bWxVRzBiSDZJaWVOdnJFVEQ5YWVlN3dkaFQ4cjRKZXJZMG9YOXFPVzNBYlNR?=
 =?utf-8?B?cWl4ak9sbWo3TFp5SWkzRG5SUXhrOTl1QmdYMEoxdWU4WlBXck9yOG9pNTdW?=
 =?utf-8?B?aHBBcnh1ek9jbVdrQTByRkNrTmdTMXFFOWY1VlJxTWkyVjc4WUFZYWhCdVNu?=
 =?utf-8?B?R0FTRlBrRkNWYTFKMFlhVG9tNGZ0Mzh4Q3FvV3VyWkRReEVkU1BpZ2g5dGVE?=
 =?utf-8?B?MUN0eHZnRTl1U1NqaVFVcHEveXlUMkExY1lCSWhIY0Z2SUovaEpTaFF2UUVJ?=
 =?utf-8?B?bkxIV0JqUEoxQ2lmWVZ4TSsyWThiK2hFaWVqZUc4cjdPQXlJOVQxT215QU1P?=
 =?utf-8?B?OUFSMit1VTlYRHkzb3l1RW1mNzVYS1NObUJCYkpoOE9KSFBzUVpLOFovaWVq?=
 =?utf-8?B?djFoMHh2V3pkc2RSTzJzQTdJN3JHa0V4blVleVhYcEhwU25KOC9JbnJqczBo?=
 =?utf-8?B?SnhRYlFWUldkMnZ5dzhMaWpQaGE3WXM0SlBLQ21kQTNnVUIvTHJTWVJLMlVl?=
 =?utf-8?B?eTJDa0tNNGtnVVRjU25jNmNpdmtPemNzUEpnc3Zid2Q0Uk96dUxObU9QbjFE?=
 =?utf-8?B?bW9XLzNoUC9DeExSK09tbEd5OGdldVMxNjFWbnJtZHF6NzVydGZ5dUtMMjg5?=
 =?utf-8?B?WEtLWm9INzIyeS9DRDhkbmNRcXdoMWpVczZOVndiOUpka2pGbE5DMnFJVVYx?=
 =?utf-8?B?cUpDTVVUSjh2bmc2UzN1YjNlVitlY05NK2dFRTgraEo5SU0xTzZvYnY5ejZB?=
 =?utf-8?B?UGZkUG1kZzdTcFFqYklxY1RXR2J0cWdEL0tJMEpmbUs5dDZWb2xpemNNRk05?=
 =?utf-8?B?Q0dEUmZzZXBFUkFzSFVSS0YrM0YwK1ZjYkE4R211WjhKM2FLQUQ4c05WL2pa?=
 =?utf-8?B?RUZpNjZKYmZmVVUwUGFkdHBTOWZvTzk3UGlwQmlJdHdzSlpYcVUrQWtjRXJm?=
 =?utf-8?B?a3pzWjRFcURab0tVdmVjUTRjVExmL1huSzI0VDhpT05ZZ3ZURHA4cDlUaHRB?=
 =?utf-8?B?akR4MnRNWWN1Y1k5U1Q4M2xpQS9xRFRSbmdKbElJNFZZdkwxM0drUGsxVC91?=
 =?utf-8?Q?j8fYAi?=
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 17:58:10.9156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e468130-ae88-4a95-4032-08ddb7ffad6a
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8902

The hfi1 driver extensively uses kernel tracing for diagnostic purposes.
This will be carried forward with the new and subsequent chips. Pull this
content in as well.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/trace.h        |   25 
 drivers/infiniband/hw/hfi2/trace_ctxts.h  |  115 ++
 drivers/infiniband/hw/hfi2/trace_dbg.h    |  118 ++
 drivers/infiniband/hw/hfi2/trace_ibhdrs.h |  458 ++++++++
 drivers/infiniband/hw/hfi2/trace_iowait.h |   54 +
 drivers/infiniband/hw/hfi2/trace_misc.h   |  108 ++
 drivers/infiniband/hw/hfi2/trace_mmu.h    |   72 +
 drivers/infiniband/hw/hfi2/trace_pin.h    |  201 +++
 drivers/infiniband/hw/hfi2/trace_rc.h     |  125 ++
 drivers/infiniband/hw/hfi2/trace_rx.h     |  171 +++
 drivers/infiniband/hw/hfi2/trace_tid.h    | 1687 +++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/trace_tx.h     | 1186 ++++++++++++++++++++
 12 files changed, 4320 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/trace.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_ctxts.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_dbg.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_ibhdrs.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_iowait.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_misc.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_mmu.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_pin.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_rc.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_rx.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_tid.h
 create mode 100644 drivers/infiniband/hw/hfi2/trace_tx.h

diff --git a/drivers/infiniband/hw/hfi2/trace.h b/drivers/infiniband/hw/hfi2/trace.h
new file mode 100644
index 000000000000..8ce38e379f18
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#define packettype_name(etype) { RHF_RCV_TYPE_##etype, #etype }
+#define show_packettype(etype)                  \
+__print_symbolic(etype,                         \
+	packettype_name(EXPECTED),              \
+	packettype_name(EAGER),                 \
+	packettype_name(IB),                    \
+	packettype_name(ERROR),                 \
+	packettype_name(BYPASS))
+
+#include "trace_dbg.h"
+#include "trace_misc.h"
+#include "trace_ctxts.h"
+#include "trace_ibhdrs.h"
+#include "trace_rc.h"
+#include "trace_rx.h"
+#include "trace_tx.h"
+#include "trace_mmu.h"
+#include "trace_iowait.h"
+#include "trace_tid.h"
+#include "trace_pin.h"
diff --git a/drivers/infiniband/hw/hfi2/trace_ctxts.h b/drivers/infiniband/hw/hfi2/trace_ctxts.h
new file mode 100644
index 000000000000..024aad651427
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_ctxts.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+* Copyright(c) 2015 - 2020 Intel Corporation.
+*/
+
+#if !defined(__HFI2_TRACE_CTXTS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_CTXTS_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_ctxts
+
+#define UCTXT_FMT \
+	"cred:%u, credaddr:0x%llx, piobase:0x%p, rcvhdr_cnt:%u, "	\
+	"rcvbase:0x%llx, rcvegrc:%u, rcvegrb:0x%llx, subctxt_cnt:%u"
+TRACE_EVENT(hfi2_uctxtdata,
+	    TP_PROTO(struct hfi2_devdata *dd, struct hfi2_ctxtdata *uctxt,
+		     unsigned int subctxt),
+	    TP_ARGS(dd, uctxt, subctxt),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __field(unsigned int, ctxt)
+			     __field(unsigned int, subctxt)
+			     __field(u32, credits)
+			     __field(u64, hw_free)
+			     __field(void __iomem *, piobase)
+			     __field(u16, rcvhdrq_cnt)
+			     __field(u64, rcvhdrq_dma)
+			     __field(u32, eager_cnt)
+			     __field(u64, rcvegr_dma)
+			     __field(unsigned int, subctxt_cnt)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			   __entry->ctxt = uctxt->ctxt;
+			   __entry->subctxt = subctxt;
+			   __entry->credits = uctxt->sc->credits;
+			   __entry->hw_free = le64_to_cpu(*uctxt->sc->hw_free);
+			   __entry->piobase = uctxt->sc->base_addr;
+			   __entry->rcvhdrq_cnt = get_hdrq_cnt(uctxt);
+			   __entry->rcvhdrq_dma = uctxt->rcvhdrq_dma;
+			   __entry->eager_cnt = uctxt->egrbufs.alloced;
+			   __entry->rcvegr_dma = uctxt->egrbufs.rcvtids[0].dma;
+			   __entry->subctxt_cnt = uctxt->subctxt_cnt;
+			   ),
+	    TP_printk("[%s] ctxt %u:%u " UCTXT_FMT,
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->credits,
+		      __entry->hw_free,
+		      __entry->piobase,
+		      __entry->rcvhdrq_cnt,
+		      __entry->rcvhdrq_dma,
+		      __entry->eager_cnt,
+		      __entry->rcvegr_dma,
+		      __entry->subctxt_cnt
+		      )
+);
+
+#define CINFO_FMT \
+	"egrtids:%u, egr_size:%u, hdrq_cnt:%u, hdrq_size:%u, sdma_ring_size:%u"
+TRACE_EVENT(hfi2_ctxt_info,
+	    TP_PROTO(struct hfi2_devdata *dd, unsigned int ctxt,
+		     unsigned int subctxt,
+		     struct hfi2_ctxt_info *cinfo),
+	    TP_ARGS(dd, ctxt, subctxt, cinfo),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __field(unsigned int, ctxt)
+			     __field(unsigned int, subctxt)
+			     __field(u16, egrtids)
+			     __field(u16, rcvhdrq_cnt)
+			     __field(u16, rcvhdrq_size)
+			     __field(u16, sdma_ring_size)
+			     __field(u32, rcvegr_size)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			    __entry->ctxt = ctxt;
+			    __entry->subctxt = subctxt;
+			    __entry->egrtids = cinfo->egrtids;
+			    __entry->rcvhdrq_cnt = cinfo->rcvhdrq_cnt;
+			    __entry->rcvhdrq_size = cinfo->rcvhdrq_entsize;
+			    __entry->sdma_ring_size = cinfo->sdma_ring_size;
+			    __entry->rcvegr_size = cinfo->rcvegr_size;
+			    ),
+	    TP_printk("[%s] ctxt %u:%u " CINFO_FMT,
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->egrtids,
+		      __entry->rcvegr_size,
+		      __entry->rcvhdrq_cnt,
+		      __entry->rcvhdrq_size,
+		      __entry->sdma_ring_size
+		      )
+);
+
+const char *hfi2_trace_print_rsm_hist(struct trace_seq *p, unsigned int ctxt);
+TRACE_EVENT(ctxt_rsm_hist,
+	    TP_PROTO(unsigned int ctxt),
+	    TP_ARGS(ctxt),
+	    TP_STRUCT__entry(__field(unsigned int, ctxt)),
+	    TP_fast_assign(__entry->ctxt = ctxt;),
+	    TP_printk("%s", hfi2_trace_print_rsm_hist(p, __entry->ctxt))
+);
+
+#endif /* __HFI2_TRACE_CTXTS_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_ctxts
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_dbg.h b/drivers/infiniband/hw/hfi2/trace_dbg.h
new file mode 100644
index 000000000000..62148240ee1d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_dbg.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+* Copyright(c) 2015 - 2018 Intel Corporation.
+*/
+
+#if !defined(__HFI2_TRACE_EXTRA_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_EXTRA_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+/*
+ * Note:
+ * This produces a REALLY ugly trace in the console output when the string is
+ * too long.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_dbg
+
+#define MAX_MSG_LEN 512
+
+#pragma GCC diagnostic push
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wsuggest-attribute=format"
+#endif
+
+DECLARE_EVENT_CLASS(hfi2_trace_template,
+		    TP_PROTO(const char *function, struct va_format *vaf),
+		    TP_ARGS(function, vaf),
+		    TP_STRUCT__entry(__string(function, function)
+				     __vstring(msg, vaf->fmt, vaf->va)
+				     ),
+		    TP_fast_assign(__assign_str(function);
+				   __assign_vstr(msg, vaf->fmt, vaf->va);
+				   ),
+		    TP_printk("(%s) %s",
+			      __get_str(function),
+			      __get_str(msg))
+);
+
+#pragma GCC diagnostic pop
+
+/*
+ * It may be nice to macroize the __hfi2_trace but the va_* stuff requires an
+ * actual function to work and can not be in a macro.
+ */
+#define __hfi2_trace_def(lvl) \
+void __printf(2, 3) __hfi2_trace_##lvl(const char *funct, char *fmt, ...); \
+									\
+DEFINE_EVENT(hfi2_trace_template, hfi2_ ##lvl,				\
+	TP_PROTO(const char *function, struct va_format *vaf),		\
+	TP_ARGS(function, vaf))
+
+#define __hfi2_trace_fn(lvl) \
+void __printf(2, 3) __hfi2_trace_##lvl(const char *func, char *fmt, ...)\
+{									\
+	struct va_format vaf = {					\
+		.fmt = fmt,						\
+	};								\
+	va_list args;							\
+									\
+	va_start(args, fmt);						\
+	vaf.va = &args;							\
+	trace_hfi2_ ##lvl(func, &vaf);					\
+	va_end(args);							\
+	return;								\
+}
+
+/*
+ * To create a new trace level simply define it below and as a __hfi2_trace_fn
+ * in trace.c. This will create all the hooks for calling
+ * hfi2_cdbg(LVL, fmt, ...); as well as take care of all
+ * the debugfs stuff.
+ */
+__hfi2_trace_def(AFFINITY);
+__hfi2_trace_def(PKT);
+__hfi2_trace_def(PROC);
+__hfi2_trace_def(SDMA);
+__hfi2_trace_def(LINKVERB);
+__hfi2_trace_def(DEBUG);
+__hfi2_trace_def(SNOOP);
+__hfi2_trace_def(CNTR);
+__hfi2_trace_def(PIO);
+__hfi2_trace_def(DC8051);
+__hfi2_trace_def(FIRMWARE);
+__hfi2_trace_def(RCVCTRL);
+__hfi2_trace_def(TID);
+__hfi2_trace_def(MMU);
+__hfi2_trace_def(IOCTL);
+
+#define hfi2_cdbg(which, fmt, ...) \
+	__hfi2_trace_##which(__func__, fmt, ##__VA_ARGS__)
+
+#define hfi2_dbg(fmt, ...) \
+	hfi2_cdbg(DEBUG, fmt, ##__VA_ARGS__)
+
+/*
+ * Define HFI2_EARLY_DBG at compile time or here to enable early trace
+ * messages. Do not check in an enablement for this.
+ */
+
+#ifdef HFI2_EARLY_DBG
+#define hfi2_dbg_early(fmt, ...) \
+	trace_printk(fmt, ##__VA_ARGS__)
+#else
+#define hfi2_dbg_early(fmt, ...)
+#endif
+
+#endif /* __HFI2_TRACE_EXTRA_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_dbg
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_ibhdrs.h b/drivers/infiniband/hw/hfi2/trace_ibhdrs.h
new file mode 100644
index 000000000000..0bf5be800237
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_ibhdrs.h
@@ -0,0 +1,458 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2017 Intel Corporation.
+ */
+
+#if !defined(__HFI2_TRACE_IBHDRS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_IBHDRS_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_ibhdrs
+
+#define ib_opcode_name(opcode) { IB_OPCODE_##opcode, #opcode  }
+#define show_ib_opcode(opcode)                             \
+__print_symbolic(opcode,                                   \
+	ib_opcode_name(RC_SEND_FIRST),                     \
+	ib_opcode_name(RC_SEND_MIDDLE),                    \
+	ib_opcode_name(RC_SEND_LAST),                      \
+	ib_opcode_name(RC_SEND_LAST_WITH_IMMEDIATE),       \
+	ib_opcode_name(RC_SEND_ONLY),                      \
+	ib_opcode_name(RC_SEND_ONLY_WITH_IMMEDIATE),       \
+	ib_opcode_name(RC_RDMA_WRITE_FIRST),               \
+	ib_opcode_name(RC_RDMA_WRITE_MIDDLE),              \
+	ib_opcode_name(RC_RDMA_WRITE_LAST),                \
+	ib_opcode_name(RC_RDMA_WRITE_LAST_WITH_IMMEDIATE), \
+	ib_opcode_name(RC_RDMA_WRITE_ONLY),                \
+	ib_opcode_name(RC_RDMA_WRITE_ONLY_WITH_IMMEDIATE), \
+	ib_opcode_name(RC_RDMA_READ_REQUEST),              \
+	ib_opcode_name(RC_RDMA_READ_RESPONSE_FIRST),       \
+	ib_opcode_name(RC_RDMA_READ_RESPONSE_MIDDLE),      \
+	ib_opcode_name(RC_RDMA_READ_RESPONSE_LAST),        \
+	ib_opcode_name(RC_RDMA_READ_RESPONSE_ONLY),        \
+	ib_opcode_name(RC_ACKNOWLEDGE),                    \
+	ib_opcode_name(RC_ATOMIC_ACKNOWLEDGE),             \
+	ib_opcode_name(RC_COMPARE_SWAP),                   \
+	ib_opcode_name(RC_FETCH_ADD),                      \
+	ib_opcode_name(RC_SEND_LAST_WITH_INVALIDATE),      \
+	ib_opcode_name(RC_SEND_ONLY_WITH_INVALIDATE),      \
+	ib_opcode_name(TID_RDMA_WRITE_REQ),	           \
+	ib_opcode_name(TID_RDMA_WRITE_RESP),	           \
+	ib_opcode_name(TID_RDMA_WRITE_DATA),	           \
+	ib_opcode_name(TID_RDMA_WRITE_DATA_LAST),          \
+	ib_opcode_name(TID_RDMA_READ_REQ),	           \
+	ib_opcode_name(TID_RDMA_READ_RESP),	           \
+	ib_opcode_name(TID_RDMA_RESYNC),	           \
+	ib_opcode_name(TID_RDMA_ACK),                      \
+	ib_opcode_name(UC_SEND_FIRST),                     \
+	ib_opcode_name(UC_SEND_MIDDLE),                    \
+	ib_opcode_name(UC_SEND_LAST),                      \
+	ib_opcode_name(UC_SEND_LAST_WITH_IMMEDIATE),       \
+	ib_opcode_name(UC_SEND_ONLY),                      \
+	ib_opcode_name(UC_SEND_ONLY_WITH_IMMEDIATE),       \
+	ib_opcode_name(UC_RDMA_WRITE_FIRST),               \
+	ib_opcode_name(UC_RDMA_WRITE_MIDDLE),              \
+	ib_opcode_name(UC_RDMA_WRITE_LAST),                \
+	ib_opcode_name(UC_RDMA_WRITE_LAST_WITH_IMMEDIATE), \
+	ib_opcode_name(UC_RDMA_WRITE_ONLY),                \
+	ib_opcode_name(UC_RDMA_WRITE_ONLY_WITH_IMMEDIATE), \
+	ib_opcode_name(UD_SEND_ONLY),                      \
+	ib_opcode_name(UD_SEND_ONLY_WITH_IMMEDIATE),       \
+	ib_opcode_name(CNP))
+
+u8 ibhdr_exhdr_len(struct ib_header *hdr);
+const char *parse_everbs_hdrs(struct trace_seq *p, u8 opcode,
+			      u8 l4, u32 dest_qpn, u32 src_qpn,
+			      void *ehdrs);
+u8 hfi2_trace_opa_hdr_len(struct hfi2_opa_header *opah);
+u8 hfi2_trace_packet_hdr_len(struct hfi2_packet *packet);
+const char *hfi2_trace_get_packet_l4_str(u8 l4);
+void hfi2_trace_parse_9b_bth(struct ib_other_headers *ohdr,
+			     u8 *ack, bool *becn, bool *fecn, u8 *mig,
+			     u8 *se, u8 *pad, u8 *opcode, u8 *tver,
+			     u16 *pkey, u32 *psn, u32 *qpn);
+void hfi2_trace_parse_9b_hdr(struct ib_header *hdr, bool sc5,
+			     u8 *lnh, u8 *lver, u8 *sl, u8 *sc,
+			     u16 *len, u32 *dlid, u32 *slid);
+void hfi2_trace_parse_16b_bth(struct ib_other_headers *ohdr,
+			      u8 *ack, u8 *mig, u8 *opcode,
+			      u8 *pad, u8 *se, u8 *tver,
+			      u32 *psn, u32 *qpn);
+void hfi2_trace_parse_16b_hdr(struct hfi2_16b_header *hdr,
+			      u8 *age, bool *becn, bool *fecn,
+			      u8 *l4, u8 *rc, u8 *sc,
+			      u16 *entropy, u16 *len, u16 *pkey,
+			      u32 *dlid, u32 *slid);
+
+const char *hfi2_trace_fmt_lrh(struct trace_seq *p, bool bypass,
+			       u8 age, bool becn, bool fecn, u8 l4,
+			       u8 lnh, const char *lnh_name, u8 lver,
+			       u8 rc, u8 sc, u8 sl, u16 entropy,
+			       u16 len, u16 pkey, u32 dlid, u32 slid);
+
+const char *hfi2_trace_fmt_rest(struct trace_seq *p, bool bypass, u8 l4,
+				u8 ack, bool becn, bool fecn, u8 mig,
+				u8 se, u8 pad, u8 opcode, const char *opname,
+				u8 tver, u16 pkey, u32 psn, u32 qpn,
+				u32 dest_qpn, u32 src_qpn);
+
+const char *hfi2_trace_get_packet_l2_str(u8 l2);
+
+#define __parse_ib_ehdrs(op, l4, dest_qpn, src_qpn, ehdrs) \
+			 parse_everbs_hdrs(p, op, l4, dest_qpn, src_qpn, ehdrs)
+
+#define lrh_name(lrh) { HFI2_##lrh, #lrh }
+#define show_lnh(lrh)                    \
+__print_symbolic(lrh,                    \
+	lrh_name(LRH_BTH),               \
+	lrh_name(LRH_GRH))
+
+DECLARE_EVENT_CLASS(hfi2_input_ibhdr_template,
+		    TP_PROTO(struct hfi2_devdata *dd,
+			     struct hfi2_packet *packet,
+			     bool sc5),
+		    TP_ARGS(dd, packet, sc5),
+		    TP_STRUCT__entry(
+			DD_DEV_ENTRY(dd)
+			__field(u8, etype)
+			__field(u8, ack)
+			__field(u8, age)
+			__field(bool, becn)
+			__field(bool, fecn)
+			__field(u8, l2)
+			__field(u8, l4)
+			__field(u8, lnh)
+			__field(u8, lver)
+			__field(u8, mig)
+			__field(u8, opcode)
+			__field(u8, pad)
+			__field(u8, rc)
+			__field(u8, sc)
+			__field(u8, se)
+			__field(u8, sl)
+			__field(u8, tver)
+			__field(u16, entropy)
+			__field(u16, len)
+			__field(u16, pkey)
+			__field(u32, dlid)
+			__field(u32, psn)
+			__field(u32, qpn)
+			__field(u32, slid)
+			__field(u32, dest_qpn)
+			__field(u32, src_qpn)
+			/* extended headers */
+			__dynamic_array(u8, ehdrs,
+					hfi2_trace_packet_hdr_len(packet))
+			),
+		    TP_fast_assign(
+			DD_DEV_ASSIGN(dd);
+
+			__entry->etype = packet->etype;
+			__entry->l2 = hfi2_16B_get_l2(packet->hdr);
+			__entry->dest_qpn = 0;
+			__entry->src_qpn = 0;
+			if (__entry->etype == RHF_RCV_TYPE_BYPASS) {
+				hfi2_trace_parse_16b_hdr(packet->hdr,
+							 &__entry->age,
+							 &__entry->becn,
+							 &__entry->fecn,
+							 &__entry->l4,
+							 &__entry->rc,
+							 &__entry->sc,
+							 &__entry->entropy,
+							 &__entry->len,
+							 &__entry->pkey,
+							 &__entry->dlid,
+							 &__entry->slid);
+
+				if (__entry->l4 == OPA_16B_L4_FM) {
+					__entry->opcode = IB_OPCODE_UD_SEND_ONLY;
+					__entry->dest_qpn = hfi2_16B_get_dest_qpn(packet->mgmt);
+					__entry->src_qpn = hfi2_16B_get_src_qpn(packet->mgmt);
+				}  else {
+					hfi2_trace_parse_16b_bth(packet->ohdr,
+								 &__entry->ack,
+								 &__entry->mig,
+								 &__entry->opcode,
+								 &__entry->pad,
+								 &__entry->se,
+								 &__entry->tver,
+								 &__entry->psn,
+								 &__entry->qpn);
+				}
+			} else {
+				__entry->l4 = OPA_16B_L4_9B;
+				hfi2_trace_parse_9b_hdr(packet->hdr, sc5,
+							&__entry->lnh,
+							&__entry->lver,
+							&__entry->sl,
+							&__entry->sc,
+							&__entry->len,
+							&__entry->dlid,
+							&__entry->slid);
+
+				  hfi2_trace_parse_9b_bth(packet->ohdr,
+							  &__entry->ack,
+							  &__entry->becn,
+							  &__entry->fecn,
+							  &__entry->mig,
+							  &__entry->se,
+							  &__entry->pad,
+							  &__entry->opcode,
+							  &__entry->tver,
+							  &__entry->pkey,
+							  &__entry->psn,
+							  &__entry->qpn);
+			}
+			/* extended headers */
+			if (__entry->l4 != OPA_16B_L4_FM)
+				memcpy(__get_dynamic_array(ehdrs),
+				       &packet->ohdr->u,
+				       __get_dynamic_array_len(ehdrs));
+			 ),
+		    TP_printk("[%s] (%s) %s %s hlen:%d %s",
+			      __get_str(dev),
+			      __entry->etype != RHF_RCV_TYPE_BYPASS ?
+					show_packettype(__entry->etype) :
+					hfi2_trace_get_packet_l2_str(
+						__entry->l2),
+			      hfi2_trace_fmt_lrh(p,
+						 __entry->etype ==
+							RHF_RCV_TYPE_BYPASS,
+						 __entry->age,
+						 __entry->becn,
+						 __entry->fecn,
+						 __entry->l4,
+						 __entry->lnh,
+						 show_lnh(__entry->lnh),
+						 __entry->lver,
+						 __entry->rc,
+						 __entry->sc,
+						 __entry->sl,
+						 __entry->entropy,
+						 __entry->len,
+						 __entry->pkey,
+						 __entry->dlid,
+						 __entry->slid),
+			      hfi2_trace_fmt_rest(p,
+						  __entry->etype ==
+							RHF_RCV_TYPE_BYPASS,
+						  __entry->l4,
+						  __entry->ack,
+						  __entry->becn,
+						  __entry->fecn,
+						  __entry->mig,
+						  __entry->se,
+						  __entry->pad,
+						  __entry->opcode,
+						  show_ib_opcode(__entry->opcode),
+						  __entry->tver,
+						  __entry->pkey,
+						  __entry->psn,
+						  __entry->qpn,
+						  __entry->dest_qpn,
+						  __entry->src_qpn),
+			      /* extended headers */
+			      __get_dynamic_array_len(ehdrs),
+			      __parse_ib_ehdrs(
+					__entry->opcode,
+					__entry->l4,
+					__entry->dest_qpn,
+					__entry->src_qpn,
+					(void *)__get_dynamic_array(ehdrs))
+			     )
+);
+
+DEFINE_EVENT(hfi2_input_ibhdr_template, input_ibhdr,
+	     TP_PROTO(struct hfi2_devdata *dd,
+		      struct hfi2_packet *packet, bool sc5),
+	     TP_ARGS(dd, packet, sc5));
+
+DECLARE_EVENT_CLASS(hfi2_output_ibhdr_template,
+		    TP_PROTO(struct hfi2_devdata *dd,
+			     struct hfi2_opa_header *opah, bool sc5, int err),
+		    TP_ARGS(dd, opah, sc5, err),
+		    TP_STRUCT__entry(
+			DD_DEV_ENTRY(dd)
+			__field(u8, hdr_type)
+			__field(u8, ack)
+			__field(u8, age)
+			__field(bool, becn)
+			__field(bool, fecn)
+			__field(u8, l4)
+			__field(u8, lnh)
+			__field(u8, lver)
+			__field(u8, mig)
+			__field(u8, opcode)
+			__field(u8, pad)
+			__field(u8, rc)
+			__field(u8, sc)
+			__field(u8, se)
+			__field(u8, sl)
+			__field(u8, tver)
+			__field(u16, entropy)
+			__field(u16, len)
+			__field(u16, pkey)
+			__field(u32, dlid)
+			__field(u32, psn)
+			__field(u32, qpn)
+			__field(u32, slid)
+			__field(u32, dest_qpn)
+			__field(u32, src_qpn)
+			__field(int, err)
+			/* extended headers */
+			__dynamic_array(u8, ehdrs,
+					hfi2_trace_opa_hdr_len(opah))
+			),
+		    TP_fast_assign(
+			struct ib_other_headers *ohdr;
+
+			DD_DEV_ASSIGN(dd);
+
+			__entry->hdr_type = opah->hdr_type;
+			__entry->dest_qpn = 0;
+			__entry->src_qpn = 0;
+			__entry->err = err;
+			if (__entry->hdr_type)  {
+				hfi2_trace_parse_16b_hdr(&opah->opah,
+							 &__entry->age,
+							 &__entry->becn,
+							 &__entry->fecn,
+							 &__entry->l4,
+							 &__entry->rc,
+							 &__entry->sc,
+							 &__entry->entropy,
+							 &__entry->len,
+							 &__entry->pkey,
+							 &__entry->dlid,
+							 &__entry->slid);
+
+				if (__entry->l4 == OPA_16B_L4_FM) {
+					ohdr = NULL;
+					__entry->opcode = IB_OPCODE_UD_SEND_ONLY;
+					__entry->dest_qpn = hfi2_16B_get_dest_qpn(&opah->opah.u.mgmt);
+					__entry->src_qpn = hfi2_16B_get_src_qpn(&opah->opah.u.mgmt);
+				} else {
+					if (__entry->l4 == OPA_16B_L4_IB_LOCAL)
+						ohdr = &opah->opah.u.oth;
+					else
+						ohdr = &opah->opah.u.l.oth;
+					hfi2_trace_parse_16b_bth(ohdr,
+								 &__entry->ack,
+								 &__entry->mig,
+								 &__entry->opcode,
+								 &__entry->pad,
+								 &__entry->se,
+								 &__entry->tver,
+								 &__entry->psn,
+								 &__entry->qpn);
+				}
+			} else {
+				__entry->l4 = OPA_16B_L4_9B;
+				hfi2_trace_parse_9b_hdr(&opah->ibh, sc5,
+							&__entry->lnh,
+							&__entry->lver,
+							&__entry->sl,
+							&__entry->sc,
+							&__entry->len,
+							&__entry->dlid,
+							&__entry->slid);
+				if (__entry->lnh == HFI2_LRH_BTH)
+					ohdr = &opah->ibh.u.oth;
+				else
+					ohdr = &opah->ibh.u.l.oth;
+				hfi2_trace_parse_9b_bth(ohdr,
+							&__entry->ack,
+							&__entry->becn,
+							&__entry->fecn,
+							&__entry->mig,
+							&__entry->se,
+							&__entry->pad,
+							&__entry->opcode,
+							&__entry->tver,
+							&__entry->pkey,
+							&__entry->psn,
+							&__entry->qpn);
+			}
+
+			/* extended headers */
+			if (__entry->l4 != OPA_16B_L4_FM)
+				memcpy(__get_dynamic_array(ehdrs),
+				       &ohdr->u, __get_dynamic_array_len(ehdrs));
+		    ),
+		    TP_printk("[%s] (%s) %s %s hlen:%d %s err:%d",
+			      __get_str(dev),
+			      hfi2_trace_get_packet_l4_str(__entry->l4),
+			      hfi2_trace_fmt_lrh(p,
+						 !!__entry->hdr_type,
+						 __entry->age,
+						 __entry->becn,
+						 __entry->fecn,
+						 __entry->l4,
+						 __entry->lnh,
+						 show_lnh(__entry->lnh),
+						 __entry->lver,
+						 __entry->rc,
+						 __entry->sc,
+						 __entry->sl,
+						 __entry->entropy,
+						 __entry->len,
+						 __entry->pkey,
+						 __entry->dlid,
+						 __entry->slid),
+			      hfi2_trace_fmt_rest(p,
+						  !!__entry->hdr_type,
+						  __entry->l4,
+						  __entry->ack,
+						  __entry->becn,
+						  __entry->fecn,
+						  __entry->mig,
+						  __entry->se,
+						  __entry->pad,
+						  __entry->opcode,
+						  show_ib_opcode(__entry->opcode),
+						  __entry->tver,
+						  __entry->pkey,
+						  __entry->psn,
+						  __entry->qpn,
+						  __entry->dest_qpn,
+						  __entry->src_qpn),
+			      /* extended headers */
+			      __get_dynamic_array_len(ehdrs),
+			      __parse_ib_ehdrs(
+					__entry->opcode,
+					__entry->l4,
+					__entry->dest_qpn,
+					__entry->src_qpn,
+					(void *)__get_dynamic_array(ehdrs)),
+			      __entry->err
+			     )
+);
+
+DEFINE_EVENT(hfi2_output_ibhdr_template, pio_output_ibhdr,
+	     TP_PROTO(struct hfi2_devdata *dd,
+		      struct hfi2_opa_header *opah, bool sc5, int err),
+	     TP_ARGS(dd, opah, sc5, err));
+
+DEFINE_EVENT(hfi2_output_ibhdr_template, ack_output_ibhdr,
+	     TP_PROTO(struct hfi2_devdata *dd,
+		      struct hfi2_opa_header *opah, bool sc5, int err),
+	     TP_ARGS(dd, opah, sc5, err));
+
+DEFINE_EVENT(hfi2_output_ibhdr_template, sdma_output_ibhdr,
+	     TP_PROTO(struct hfi2_devdata *dd,
+		      struct hfi2_opa_header *opah, bool sc5, int err),
+	     TP_ARGS(dd, opah, sc5, err));
+
+
+#endif /* __HFI2_TRACE_IBHDRS_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_ibhdrs
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_iowait.h b/drivers/infiniband/hw/hfi2/trace_iowait.h
new file mode 100644
index 000000000000..ad9c207f499a
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_iowait.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ *
+ */
+#if !defined(__HFI2_TRACE_IOWAIT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_IOWAIT_H
+
+#include <linux/tracepoint.h>
+#include "iowait.h"
+#include "verbs.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_iowait
+
+DECLARE_EVENT_CLASS(hfi2_iowait_template,
+		    TP_PROTO(struct iowait *wait, u32 flag),
+		    TP_ARGS(wait, flag),
+		    TP_STRUCT__entry(/* entry */
+			    __field(unsigned long, addr)
+			    __field(unsigned long, flags)
+			    __field(u32, flag)
+			    __field(u32, qpn)
+			    ),
+		    TP_fast_assign(/* assign */
+			    __entry->addr = (unsigned long)wait;
+			    __entry->flags = wait->flags;
+			    __entry->flag = (1 << flag);
+			    __entry->qpn = iowait_to_qp(wait)->ibqp.qp_num;
+			    ),
+		    TP_printk(/* print */
+			    "iowait 0x%lx qp %u flags 0x%lx flag 0x%x",
+			    __entry->addr,
+			    __entry->qpn,
+			    __entry->flags,
+			    __entry->flag
+			    )
+	);
+
+DEFINE_EVENT(hfi2_iowait_template, hfi2_iowait_set,
+	     TP_PROTO(struct iowait *wait, u32 flag),
+	     TP_ARGS(wait, flag));
+
+DEFINE_EVENT(hfi2_iowait_template, hfi2_iowait_clear,
+	     TP_PROTO(struct iowait *wait, u32 flag),
+	     TP_ARGS(wait, flag));
+
+#endif /* __HFI2_TRACE_IOWAIT_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_iowait
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_misc.h b/drivers/infiniband/hw/hfi2/trace_misc.h
new file mode 100644
index 000000000000..0f8ad4133baf
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_misc.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+* Copyright(c) 2015, 2016 Intel Corporation.
+*/
+
+#if !defined(__HFI2_TRACE_MISC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_MISC_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_misc
+
+TRACE_EVENT(hfi2_interrupt,
+	    TP_PROTO(struct hfi2_devdata *dd, const struct is_table *is_entry,
+		     int src),
+	    TP_ARGS(dd, is_entry, src),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __array(char, buf, 64)
+			     __field(int, src)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			   is_entry->is_name(__entry->buf, 64,
+					     src - is_entry->start);
+			   __entry->src = src;
+			   ),
+	    TP_printk("[%s] source: %s [%d]", __get_str(dev), __entry->buf,
+		      __entry->src)
+);
+
+DECLARE_EVENT_CLASS(
+	hfi2_csr_template,
+	TP_PROTO(void __iomem *addr, u64 value),
+	TP_ARGS(addr, value),
+	TP_STRUCT__entry(
+		__field(void __iomem *, addr)
+		__field(u64, value)
+	),
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->value = value;
+	),
+	TP_printk("addr %p value %llx", __entry->addr, __entry->value)
+);
+
+DEFINE_EVENT(
+	hfi2_csr_template, hfi2_write_rcvarray,
+	TP_PROTO(void __iomem *addr, u64 value),
+	TP_ARGS(addr, value));
+
+#ifdef CONFIG_FAULT_INJECTION
+TRACE_EVENT(hfi2_fault_opcode,
+	    TP_PROTO(struct rvt_qp *qp, u8 opcode),
+	    TP_ARGS(qp, opcode),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+			     __field(u32, qpn)
+			     __field(u8, opcode)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+			   __entry->qpn = qp->ibqp.qp_num;
+			   __entry->opcode = opcode;
+			   ),
+	    TP_printk("[%s] qpn 0x%x opcode 0x%x",
+		      __get_str(dev), __entry->qpn, __entry->opcode)
+);
+
+TRACE_EVENT(hfi2_fault_packet,
+	    TP_PROTO(struct hfi2_packet *packet),
+	    TP_ARGS(packet),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(packet->rcd->ppd->dd)
+			     __field(u64, eflags)
+			     __field(u32, ctxt)
+			     __field(u32, hlen)
+			     __field(u32, tlen)
+			     __field(u32, updegr)
+			     __field(u32, etail)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(packet->rcd->ppd->dd);
+			    __entry->eflags = packet->err_flags;
+			    __entry->ctxt = packet->rcd->ctxt;
+			    __entry->hlen = packet->hlen;
+			    __entry->tlen = packet->tlen;
+			    __entry->updegr = packet->updegr;
+			    __entry->etail = packet->egr_index;
+			    ),
+	     TP_printk(
+		"[%s] ctxt %d eflags 0x%llx hlen %d tlen %d updegr %d etail %d",
+		__get_str(dev),
+		__entry->ctxt,
+		__entry->eflags,
+		__entry->hlen,
+		__entry->tlen,
+		__entry->updegr,
+		__entry->etail
+		)
+);
+#endif
+
+#endif /* __HFI2_TRACE_MISC_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_misc
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_mmu.h b/drivers/infiniband/hw/hfi2/trace_mmu.h
new file mode 100644
index 000000000000..a8fafdc1fe81
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_mmu.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2017 Intel Corporation.
+ */
+
+#if !defined(__HFI2_TRACE_MMU_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_MMU_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_mmu
+
+DECLARE_EVENT_CLASS(hfi2_mmu_rb_template,
+		    TP_PROTO(struct mmu_rb_node *node),
+		    TP_ARGS(node),
+		    TP_STRUCT__entry(__field(unsigned long, addr)
+				     __field(unsigned long, len)
+				     __field(unsigned int, refcount)
+			    ),
+		    TP_fast_assign(__entry->addr = node->addr;
+				   __entry->len = node->len;
+				   __entry->refcount = kref_read(&node->refcount);
+			    ),
+		    TP_printk("MMU node addr 0x%lx, len %lu, refcount %u",
+			      __entry->addr,
+			      __entry->len,
+			      __entry->refcount
+			    )
+);
+
+DEFINE_EVENT(hfi2_mmu_rb_template, hfi2_mmu_rb_insert,
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
+
+TRACE_EVENT(hfi2_mmu_rb_search,
+	    TP_PROTO(unsigned long addr, unsigned long len),
+	    TP_ARGS(addr, len),
+	    TP_STRUCT__entry(__field(unsigned long, addr)
+			     __field(unsigned long, len)
+		    ),
+	    TP_fast_assign(__entry->addr = addr;
+			   __entry->len = len;
+		    ),
+	    TP_printk("MMU node addr 0x%lx, len %lu",
+		      __entry->addr,
+		      __entry->len
+		    )
+);
+
+DEFINE_EVENT(hfi2_mmu_rb_template, hfi2_mmu_mem_invalidate,
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
+
+DEFINE_EVENT(hfi2_mmu_rb_template, hfi2_mmu_rb_evict,
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
+
+DEFINE_EVENT(hfi2_mmu_rb_template, hfi2_mmu_release_node,
+	     TP_PROTO(struct mmu_rb_node *node),
+	     TP_ARGS(node));
+
+#endif /* __HFI2_TRACE_RC_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_mmu
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_pin.h b/drivers/infiniband/hw/hfi2/trace_pin.h
new file mode 100644
index 000000000000..1df56900374d
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_pin.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * Copyright(c) 2023-2024 Cornelis Networks, Inc.
+ * Copyright(c) 2017 Intel Corporation.
+ *
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * BSD LICENSE
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *  - Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ *  - Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in
+ *    the documentation and/or other materials provided with the
+ *    distribution.
+ *  - Neither the name of Intel Corporation nor the names of its
+ *    contributors may be used to endorse or promote products derived
+ *    from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ */
+#if !defined(__HFI2_TRACE_PIN_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_PIN_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+const char *hfi2_memtype_str(unsigned int mt);
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_pin
+
+/*
+ * @ctxt: pq, cache ptr, something that distinguishes the trace. Not necessarily
+ *   an fd.
+ * @memtype: HFI2_MEMINFO_* value
+ * @va_addr: virtual address start
+ * @va_len: "..." length
+ * @ret signal: error with the pin operation
+ * @from_cache: 0 or 1
+ * @node: returned cache node; NULL if not found
+ * @dma_addr: returned pinning physical or DMA address, depending
+ *   on if kernel API has separate pin and DMA map operations for
+ *   the memory type. 0 if not found.
+ * @dma_len: 0 if not found.
+ */
+DECLARE_EVENT_CLASS(hfi2_pin_mem,
+		    /* There are only a handful of memtypes; use u16 to minimize struct size */
+		    TP_PROTO(void *ctxt, u16 memtype,
+			     unsigned long va_addr, unsigned long va_len,
+			     int ret, bool from_cache,
+			     void *node,
+			     dma_addr_t dma_addr, unsigned long dma_len),
+		    TP_ARGS(ctxt, memtype, va_addr, va_len, ret, from_cache, node, dma_addr,
+			    dma_len),
+		    TP_STRUCT__entry(__field(void *, ctxt)
+				     __field(u16, memtype)
+				     __field(u16, from_cache)
+				     __field(int, ret)
+				     __field(unsigned long, va_addr)
+				     __field(unsigned long, va_len)
+				     __field(void *, node)
+				     __field(dma_addr_t, dma_addr)
+				     __field(unsigned long, dma_len)
+			    ),
+		    TP_fast_assign(__entry->ctxt = ctxt;
+				   __entry->memtype = memtype;
+				   __entry->va_addr = va_addr;
+				   __entry->va_len = va_len;
+				   __entry->ret = ret;
+				   __entry->from_cache = from_cache;
+				   __entry->node = node;
+				   __entry->dma_addr = dma_addr;
+				   __entry->dma_len = dma_len;
+			    ),
+		    TP_printk("ctxt %p %s (%u) VA start %px length %lu ret %d from_cache %u node %p phys/DMA start %pad length %lu",
+			      __entry->ctxt,
+			      hfi2_memtype_str(__entry->memtype),
+			      __entry->memtype,
+			      (void *)__entry->va_addr,
+			      __entry->va_len,
+			      __entry->ret,
+			      __entry->from_cache,
+			      __entry->node,
+			      &__entry->dma_addr,
+			      __entry->dma_len
+			    )
+);
+
+DECLARE_EVENT_CLASS(hfi2_unpin_mem,
+		    TP_PROTO(void *ctxt, unsigned int memtype,
+			     int ret,
+			     void *node,
+			     unsigned long va_addr, unsigned long va_len,
+			     dma_addr_t dma_addr, unsigned long dma_len),
+		    TP_ARGS(ctxt, memtype, ret, node, va_addr, va_len, dma_addr, dma_len),
+		    TP_STRUCT__entry(__field(void *, ctxt)
+				    __field(unsigned int, memtype)
+				    __field(int, ret)
+				    __field(void *, node)
+				    __field(unsigned long, va_addr)
+				    __field(unsigned long, va_len)
+				    __field(dma_addr_t, dma_addr)
+				    __field(unsigned long, dma_len)
+			    ),
+		    TP_fast_assign(__entry->ctxt = ctxt;
+				   __entry->memtype = memtype;
+				   __entry->ret = ret;
+				   __entry->node = node;
+				   __entry->va_addr = va_addr;
+				   __entry->va_len = va_len;
+				   __entry->dma_addr = dma_addr;
+				   __entry->dma_len = dma_len;
+			    ),
+		    TP_printk("ctxt %p %s (%u) VA start %px length %lu ret %u node %p phys/DMA start %pad length %lu",
+			      __entry->ctxt,
+			      hfi2_memtype_str(__entry->memtype),
+			      __entry->memtype,
+			      (void *)__entry->va_addr,
+			      __entry->va_len,
+			      __entry->ret,
+			      __entry->node,
+			      &__entry->dma_addr,
+			      __entry->dma_len)
+);
+
+DEFINE_EVENT(hfi2_pin_mem, pin_sdma_mem,
+	     TP_PROTO(void *ctxt, u16 memtype,
+		      unsigned long va_start, unsigned long va_len,
+		      int ret, bool from_cache,
+		      void *node,
+		      dma_addr_t dma_addr, unsigned long dma_len),
+	     TP_ARGS(ctxt, memtype, va_start, va_len, ret, from_cache, node, dma_addr, dma_len));
+
+DEFINE_EVENT(hfi2_unpin_mem, unpin_sdma_mem,
+	     TP_PROTO(void *ctxt, unsigned int memtype,
+		      int ret,
+		      void *node,
+		      unsigned long va_addr, unsigned long va_len,
+		      dma_addr_t dma_addr, unsigned long dma_len),
+	     TP_ARGS(ctxt, memtype, ret, node, va_addr, va_len, dma_addr, dma_len));
+
+TRACE_EVENT(pin_stats,
+	    TP_PROTO(void *ctxt, struct hfi2_pin_stats *s),
+	    TP_ARGS(ctxt, s),
+	    TP_STRUCT__entry(__field(void *, ctxt)
+			     __field_struct(struct hfi2_pin_stats, s)),
+	    TP_fast_assign(__entry->ctxt = ctxt;
+			   __entry->s = *s;
+	    ),
+	    TP_printk("ctxt %p %s (%u) index %d id %llx cache_entries %llu total_refcounts %llu total_bytes %llu hits %llu misses %llu hint_hits %llu hint_misses %llu internal_evictions %llu external_evictions %llu",
+		      __entry->ctxt,
+		      hfi2_memtype_str(__entry->s.memtype),
+		      __entry->s.memtype,
+		      __entry->s.index,
+		      __entry->s.id,
+		      __entry->s.cache_entries,
+		      __entry->s.total_refcounts,
+		      __entry->s.total_bytes,
+		      __entry->s.hits,
+		      __entry->s.misses,
+		      __entry->s.hint_hits,
+		      __entry->s.hint_misses,
+		      __entry->s.internal_evictions,
+		      __entry->s.external_evictions)
+);
+
+#endif /* __HFI2_TRACE_PIN_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_pin
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_rc.h b/drivers/infiniband/hw/hfi2/trace_rc.h
new file mode 100644
index 000000000000..6b50479ab27b
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_rc.h
@@ -0,0 +1,125 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+* Copyright(c) 2015, 2016, 2017 Intel Corporation.
+*/
+
+#if !defined(__HFI2_TRACE_RC_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_RC_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_rc
+
+DECLARE_EVENT_CLASS(hfi2_rc_template,
+		    TP_PROTO(struct rvt_qp *qp, u32 psn),
+		    TP_ARGS(qp, psn),
+		    TP_STRUCT__entry(
+			DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+			__field(u32, qpn)
+			__field(u32, s_flags)
+			__field(u32, psn)
+			__field(u32, s_psn)
+			__field(u32, s_next_psn)
+			__field(u32, s_sending_psn)
+			__field(u32, s_sending_hpsn)
+			__field(u32, r_psn)
+			),
+		    TP_fast_assign(
+			DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+			__entry->qpn = qp->ibqp.qp_num;
+			__entry->s_flags = qp->s_flags;
+			__entry->psn = psn;
+			__entry->s_psn = qp->s_psn;
+			__entry->s_next_psn = qp->s_next_psn;
+			__entry->s_sending_psn = qp->s_sending_psn;
+			__entry->s_sending_hpsn = qp->s_sending_hpsn;
+			__entry->r_psn = qp->r_psn;
+			),
+		    TP_printk(
+			"[%s] qpn 0x%x s_flags 0x%x psn 0x%x s_psn 0x%x s_next_psn 0x%x s_sending_psn 0x%x sending_hpsn 0x%x r_psn 0x%x",
+			__get_str(dev),
+			__entry->qpn,
+			__entry->s_flags,
+			__entry->psn,
+			__entry->s_psn,
+			__entry->s_next_psn,
+			__entry->s_sending_psn,
+			__entry->s_sending_hpsn,
+			__entry->r_psn
+			)
+);
+
+DEFINE_EVENT(hfi2_rc_template, hfi2_sendcomplete,
+	     TP_PROTO(struct rvt_qp *qp, u32 psn),
+	     TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(hfi2_rc_template, hfi2_ack,
+	     TP_PROTO(struct rvt_qp *qp, u32 psn),
+	     TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(hfi2_rc_template, hfi2_rcv_error,
+	     TP_PROTO(struct rvt_qp *qp, u32 psn),
+	     TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_rc_template, hfi2_rc_completion,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DECLARE_EVENT_CLASS(/* rc_ack */
+	hfi2_rc_ack_template,
+	TP_PROTO(struct rvt_qp *qp, u32 aeth, u32 psn,
+		 struct rvt_swqe *wqe),
+	TP_ARGS(qp, aeth, psn, wqe),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u32, aeth)
+		__field(u32, psn)
+		__field(u8, opcode)
+		__field(u32, spsn)
+		__field(u32, lpsn)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->aeth = aeth;
+		__entry->psn = psn;
+		__entry->opcode = wqe->wr.opcode;
+		__entry->spsn = wqe->psn;
+		__entry->lpsn = wqe->lpsn;
+	),
+	TP_printk(/* print */
+		"[%s] qpn 0x%x aeth 0x%x psn 0x%x opcode 0x%x spsn 0x%x lpsn 0x%x",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->aeth,
+		__entry->psn,
+		__entry->opcode,
+		__entry->spsn,
+		__entry->lpsn
+	)
+);
+
+DEFINE_EVENT(/* do_rc_ack */
+	hfi2_rc_ack_template, hfi2_rc_ack_do,
+	TP_PROTO(struct rvt_qp *qp, u32 aeth, u32 psn,
+		 struct rvt_swqe *wqe),
+	TP_ARGS(qp, aeth, psn, wqe)
+);
+
+#endif /* __HFI2_TRACE_RC_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_rc
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_rx.h b/drivers/infiniband/hw/hfi2/trace_rx.h
new file mode 100644
index 000000000000..34399b6916ed
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_rx.h
@@ -0,0 +1,171 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ */
+
+#if !defined(__HFI2_TRACE_RX_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_RX_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+#define tidtype_name(type) { PT_##type, #type }
+#define show_tidtype(type)                   \
+__print_symbolic(type,                       \
+	tidtype_name(EXPECTED),              \
+	tidtype_name(EAGER))
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_rx
+
+TRACE_EVENT(hfi2_rcvhdr,
+	    TP_PROTO(struct hfi2_packet *packet),
+	    TP_ARGS(packet),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(packet->rcd->dd)
+			     __field(u64, eflags)
+			     __field(u32, ctxt)
+			     __field(u32, etype)
+			     __field(u32, hlen)
+			     __field(u32, tlen)
+			     __field(u32, updegr)
+			     __field(u32, etail)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(packet->rcd->dd);
+			    __entry->eflags = packet->err_flags;
+			    __entry->ctxt = packet->rcd->ctxt;
+			    __entry->etype = packet->etype;
+			    __entry->hlen = packet->hlen;
+			    __entry->tlen = packet->tlen;
+			    __entry->updegr = packet->updegr;
+			    __entry->etail = packet->egr_index;
+			    ),
+	     TP_printk(
+		"[%s] ctxt %d eflags 0x%llx etype %d,%s hlen %d tlen %d updegr %d etail %d",
+		__get_str(dev),
+		__entry->ctxt,
+		__entry->eflags,
+		__entry->etype, show_packettype(__entry->etype),
+		__entry->hlen,
+		__entry->tlen,
+		__entry->updegr,
+		__entry->etail
+		)
+);
+
+TRACE_EVENT(hfi2_receive_interrupt,
+	    TP_PROTO(struct hfi2_devdata *dd, struct hfi2_ctxtdata *rcd),
+	    TP_ARGS(dd, rcd),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __field(u32, ctxt)
+			     __field(u8, slow_path)
+			     __field(u8, dma_rtail)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			__entry->ctxt = rcd->ctxt;
+			__entry->slow_path = hfi2_is_slowpath(rcd);
+			__entry->dma_rtail = get_dma_rtail_setting(rcd);
+			),
+	    TP_printk("[%s] ctxt %d SlowPath: %d DmaRtail: %d",
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->slow_path,
+		      __entry->dma_rtail
+		      )
+);
+
+TRACE_EVENT(hfi2_mmu_invalidate,
+	    TP_PROTO(unsigned int ctxt, u16 subctxt, const char *type,
+		     unsigned long start, unsigned long end),
+	    TP_ARGS(ctxt, subctxt, type, start, end),
+	    TP_STRUCT__entry(
+			     __field(unsigned int, ctxt)
+			     __field(u16, subctxt)
+			     __string(type, type)
+			     __field(unsigned long, start)
+			     __field(unsigned long, end)
+			     ),
+	    TP_fast_assign(
+			__entry->ctxt = ctxt;
+			__entry->subctxt = subctxt;
+			__assign_str(type);
+			__entry->start = start;
+			__entry->end = end;
+	    ),
+	    TP_printk("[%3u:%02u] MMU Invalidate (%s) 0x%lx - 0x%lx",
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __get_str(type),
+		      __entry->start,
+		      __entry->end
+		      )
+	    );
+
+#define SNOOP_PRN \
+	"slid %.4x dlid %.4x qpn 0x%.6x opcode 0x%.2x,%s " \
+	"svc lvl %d pkey 0x%.4x [header = %d bytes] [data = %d bytes]"
+
+TRACE_EVENT(snoop_capture,
+	    TP_PROTO(struct hfi2_devdata *dd,
+		     int hdr_len,
+		     struct ib_header *hdr,
+		     int data_len,
+		     void *data),
+	    TP_ARGS(dd, hdr_len, hdr, data_len, data),
+	    TP_STRUCT__entry(
+			     DD_DEV_ENTRY(dd)
+			     __field(u16, slid)
+			     __field(u16, dlid)
+			     __field(u32, qpn)
+			     __field(u8, opcode)
+			     __field(u8, sl)
+			     __field(u16, pkey)
+			     __field(u32, hdr_len)
+			     __field(u32, data_len)
+			     __field(u8, lnh)
+			     __dynamic_array(u8, raw_hdr, hdr_len)
+			     __dynamic_array(u8, raw_pkt, data_len)
+			     ),
+	    TP_fast_assign(
+		struct ib_other_headers *ohdr;
+
+		__entry->lnh = (u8)(be16_to_cpu(hdr->lrh[0]) & 3);
+		if (__entry->lnh == HFI2_LRH_BTH)
+		ohdr = &hdr->u.oth;
+		else
+		ohdr = &hdr->u.l.oth;
+		DD_DEV_ASSIGN(dd);
+		__entry->slid = be16_to_cpu(hdr->lrh[3]);
+		__entry->dlid = be16_to_cpu(hdr->lrh[1]);
+		__entry->qpn = be32_to_cpu(ohdr->bth[1]) & RVT_QPN_MASK;
+		__entry->opcode = (be32_to_cpu(ohdr->bth[0]) >> 24) & 0xff;
+		__entry->sl = (u8)(be16_to_cpu(hdr->lrh[0]) >> 4) & 0xf;
+		__entry->pkey =	be32_to_cpu(ohdr->bth[0]) & 0xffff;
+		__entry->hdr_len = hdr_len;
+		__entry->data_len = data_len;
+		memcpy(__get_dynamic_array(raw_hdr), hdr, hdr_len);
+		memcpy(__get_dynamic_array(raw_pkt), data, data_len);
+		),
+	    TP_printk(
+		"[%s] " SNOOP_PRN,
+		__get_str(dev),
+		__entry->slid,
+		__entry->dlid,
+		__entry->qpn,
+		__entry->opcode,
+		show_ib_opcode(__entry->opcode),
+		__entry->sl,
+		__entry->pkey,
+		__entry->hdr_len,
+		__entry->data_len
+		)
+);
+
+#endif /* __HFI2_TRACE_RX_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_rx
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_tid.h b/drivers/infiniband/hw/hfi2/trace_tid.h
new file mode 100644
index 000000000000..54ccea7031d8
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_tid.h
@@ -0,0 +1,1687 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Copyright(c) 2024 Cornelis Networks, Inc.
+ * Copyright(c) 2018 Intel Corporation.
+ *
+ */
+#if !defined(__HFI2_TRACE_TID_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_TID_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+
+#define tidtype_name(type) { PT_##type, #type }
+#define show_tidtype(type)                   \
+__print_symbolic(type,                       \
+	tidtype_name(EXPECTED),              \
+	tidtype_name(EAGER))
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_tid
+
+u8 hfi2_trace_get_tid_ctrl(u32 ent);
+u16 hfi2_trace_get_tid_len(u32 ent);
+u16 hfi2_trace_get_tid_idx(u32 ent);
+
+#define OPFN_PARAM_PRN "[%s] qpn 0x%x %s OPFN: qp 0x%x, max read %u, " \
+		       "max write %u, max length %u, jkey 0x%x timeout %u " \
+		       "urg %u"
+
+#define TID_FLOW_PRN "[%s] qpn 0x%x flow %d: idx %d resp_ib_psn 0x%x " \
+		     "generation 0x%x fpsn 0x%x-%x r_next_psn 0x%x " \
+		     "ib_psn 0x%x-%x npagesets %u tnode_cnt %u " \
+		     "tidcnt %u tid_idx %u tid_offset %u length %u sent %u"
+
+#define TID_NODE_PRN "[%s] qpn 0x%x  %s idx %u grp base 0x%x map 0x%x " \
+		     "used %u cnt %u"
+
+#define RSP_INFO_PRN "[%s] qpn 0x%x state 0x%x s_state 0x%x psn 0x%x " \
+		     "r_psn 0x%x r_state 0x%x r_flags 0x%x " \
+		     "r_head_ack_queue %u s_tail_ack_queue %u " \
+		     "s_acked_ack_queue %u s_ack_state 0x%x " \
+		     "s_nak_state 0x%x s_flags 0x%x ps_flags 0x%x " \
+		     "iow_flags 0x%lx"
+
+#define SENDER_INFO_PRN "[%s] qpn 0x%x state 0x%x s_cur %u s_tail %u " \
+			"s_head %u s_acked %u s_last %u s_psn 0x%x " \
+			"s_last_psn 0x%x s_flags 0x%x ps_flags 0x%x " \
+			"iow_flags 0x%lx s_state 0x%x s_num_rd %u s_retry %u"
+
+#define TID_READ_SENDER_PRN "[%s] qpn 0x%x newreq %u tid_r_reqs %u " \
+			    "tid_r_comp %u pending_tid_r_segs %u " \
+			    "s_flags 0x%x ps_flags 0x%x iow_flags 0x%lx " \
+			    "s_state 0x%x hw_flow_index %u generation 0x%x " \
+			    "fpsn 0x%x"
+
+#define TID_REQ_PRN "[%s] qpn 0x%x newreq %u opcode 0x%x psn 0x%x lpsn 0x%x " \
+		    "cur_seg %u comp_seg %u ack_seg %u alloc_seg %u " \
+		    "total_segs %u setup_head %u clear_tail %u flow_idx %u " \
+		    "acked_tail %u state %u r_ack_psn 0x%x r_flow_psn 0x%x " \
+		    "r_last_ackd 0x%x s_next_psn 0x%x"
+
+#define RCV_ERR_PRN "[%s] qpn 0x%x s_flags 0x%x state 0x%x " \
+		    "s_acked_ack_queue %u s_tail_ack_queue %u " \
+		    "r_head_ack_queue %u opcode 0x%x psn 0x%x r_psn 0x%x " \
+		    " diff %d"
+
+#define TID_WRITE_RSPDR_PRN "[%s] qpn 0x%x r_tid_head %u r_tid_tail %u " \
+			    "r_tid_ack %u r_tid_alloc %u alloc_w_segs %u " \
+			    "pending_tid_w_segs %u sync_pt %s " \
+			    "ps_nak_psn 0x%x ps_nak_state 0x%x " \
+			    "prnr_nak_state 0x%x hw_flow_index %u generation "\
+			    "0x%x fpsn 0x%x resync %s" \
+			    "r_next_psn_kdeth 0x%x"
+
+#define TID_WRITE_SENDER_PRN "[%s] qpn 0x%x newreq %u s_tid_cur %u " \
+			     "s_tid_tail %u s_tid_head %u " \
+			     "pending_tid_w_resp %u n_requests %u " \
+			     "n_tid_requests %u s_flags 0x%x ps_flags 0x%x "\
+			     "iow_flags 0x%lx s_state 0x%x s_retry %u"
+
+#define KDETH_EFLAGS_ERR_PRN "[%s] qpn 0x%x  TID ERR: RcvType 0x%x " \
+			     "RcvTypeError 0x%x PSN 0x%x"
+
+DECLARE_EVENT_CLASS(/* class */
+	hfi2_exp_tid_reg_unreg,
+	TP_PROTO(unsigned int ctxt, u16 subctxt, u32 rarr, u32 npages,
+		 unsigned long va, unsigned long pa, dma_addr_t dma, u16 type),
+	TP_ARGS(ctxt, subctxt, rarr, npages, va, pa, dma, type),
+	TP_STRUCT__entry(/* entry */
+		__field(unsigned int, ctxt)
+		__field(u16, subctxt)
+		__field(u32, rarr)
+		__field(u32, npages)
+		__field(unsigned long, va)
+		__field(unsigned long, pa)
+		__field(dma_addr_t, dma)
+		__field(u16, type)
+	),
+	TP_fast_assign(/* assign */
+		__entry->ctxt = ctxt;
+		__entry->subctxt = subctxt;
+		__entry->rarr = rarr;
+		__entry->npages = npages;
+		__entry->va = va;
+		__entry->pa = pa;
+		__entry->dma = dma;
+		__entry->type = type;
+	),
+	TP_printk("[%u:%u] entry:%u, %u pages @ 0x%lx, va:0x%lx dma:0x%llx memtype:0x%x",
+		  __entry->ctxt,
+		  __entry->subctxt,
+		  __entry->rarr,
+		  __entry->npages,
+		  __entry->pa,
+		  __entry->va,
+		  __entry->dma,
+		  __entry->type
+	)
+);
+
+DEFINE_EVENT(/* exp_tid_unreg */
+	hfi2_exp_tid_reg_unreg, hfi2_exp_tid_unreg,
+	TP_PROTO(unsigned int ctxt, u16 subctxt, u32 rarr, u32 npages,
+		 unsigned long va, unsigned long pa, dma_addr_t dma, u16 type),
+	TP_ARGS(ctxt, subctxt, rarr, npages, va, pa, dma, type)
+);
+
+DEFINE_EVENT(/* exp_tid_reg */
+	hfi2_exp_tid_reg_unreg, hfi2_exp_tid_reg,
+	TP_PROTO(unsigned int ctxt, u16 subctxt, u32 rarr, u32 npages,
+		 unsigned long va, unsigned long pa, dma_addr_t dma, u16 type),
+	TP_ARGS(ctxt, subctxt, rarr, npages, va, pa, dma, type)
+);
+
+TRACE_EVENT(
+	hfi2_exp_tid_update,
+	TP_PROTO(unsigned int ctxt, u16 subctxt, struct hfi2_tid_info *tinfo),
+	TP_ARGS(ctxt, subctxt, tinfo),
+	TP_STRUCT__entry(
+		__field(u64, vaddr)
+		__field(u64, tidlist)
+		__field(u64, flags)
+		__field(u64, context)
+		__field(u32, tidcnt)
+		__field(u32, length)
+		__field(unsigned int, ctxt)
+		__field(u16, subctxt)
+		__field(u16, type)
+	),
+	TP_fast_assign(
+		__entry->ctxt = ctxt;
+		__entry->subctxt = subctxt;
+		__entry->vaddr = tinfo->vaddr;
+		__entry->tidlist = tinfo->tidlist;
+		__entry->tidcnt = tinfo->tidcnt;
+		__entry->length = tinfo->length;
+		__entry->flags = tinfo->flags;
+		__entry->context = tinfo->context;
+		__entry->type = (tinfo->flags & HFI2_MEMINFO_TYPE_ENTRY_MASK);
+	),
+	TP_printk("[%u:%u] vaddr 0x%llx tidlist 0x%llx tidcnt %u length %u flags.memtype 0x%x flags.reserved 0x%llx context 0x%llx",
+		  __entry->ctxt,
+		  __entry->subctxt,
+		  __entry->vaddr,
+		  __entry->tidlist,
+		  __entry->tidcnt,
+		  __entry->length,
+		  __entry->type,
+		  __entry->flags & (~(u64)HFI2_MEMINFO_TYPE_ENTRY_MASK),
+		  __entry->context
+	)
+);
+
+TRACE_EVENT(/* put_tid */
+	hfi2_put_tid,
+	TP_PROTO(struct hfi2_devdata *dd,
+		 u32 index, u32 type, unsigned long pa, u16 order),
+	TP_ARGS(dd, index, type, pa, order),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd)
+		__field(unsigned long, pa)
+		__field(u32, index)
+		__field(u32, type)
+		__field(u16, order)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd);
+		__entry->pa = pa;
+		__entry->index = index;
+		__entry->type = type;
+		__entry->order = order;
+	),
+	TP_printk("[%s] type %s pa %lx index %u order %u",
+		  __get_str(dev),
+		  show_tidtype(__entry->type),
+		  __entry->pa,
+		  __entry->index,
+		  __entry->order
+	)
+);
+
+TRACE_EVENT(/* exp_tid_inval */
+	hfi2_exp_tid_inval,
+	TP_PROTO(unsigned int ctxt, u16 subctxt, unsigned long va, u32 rarr,
+		 u32 npages, dma_addr_t dma, u16 type),
+	TP_ARGS(ctxt, subctxt, va, rarr, npages, dma, type),
+	TP_STRUCT__entry(/* entry */
+		__field(unsigned int, ctxt)
+		__field(u16, subctxt)
+		__field(unsigned long, va)
+		__field(u32, rarr)
+		__field(u32, npages)
+		__field(dma_addr_t, dma)
+		__field(u16, type)
+	),
+	TP_fast_assign(/* assign */
+		__entry->ctxt = ctxt;
+		__entry->subctxt = subctxt;
+		__entry->va = va;
+		__entry->rarr = rarr;
+		__entry->npages = npages;
+		__entry->dma = dma;
+		__entry->type = type;
+	),
+	TP_printk("[%u:%u] entry:%u, %u pages @ 0x%lx dma: 0x%llx memtype:0x%x",
+		  __entry->ctxt,
+		  __entry->subctxt,
+		  __entry->rarr,
+		  __entry->npages,
+		  __entry->va,
+		  __entry->dma,
+		  __entry->type
+	)
+);
+
+DECLARE_EVENT_CLASS(/* opfn_state */
+	hfi2_opfn_state_template,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u16, requested)
+		__field(u16, completed)
+		__field(u8, curr)
+	),
+	TP_fast_assign(/* assign */
+		struct hfi2_qp_priv *priv = qp->priv;
+
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->requested = priv->opfn.requested;
+		__entry->completed = priv->opfn.completed;
+		__entry->curr = priv->opfn.curr;
+	),
+	TP_printk(/* print */
+		"[%s] qpn 0x%x requested 0x%x completed 0x%x curr 0x%x",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->requested,
+		__entry->completed,
+		__entry->curr
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_state_template, hfi2_opfn_state_conn_request,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_state_template, hfi2_opfn_state_sched_conn_request,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_state_template, hfi2_opfn_state_conn_response,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_state_template, hfi2_opfn_state_conn_reply,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_state_template, hfi2_opfn_state_conn_error,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DECLARE_EVENT_CLASS(/* opfn_data */
+	hfi2_opfn_data_template,
+	TP_PROTO(struct rvt_qp *qp, u8 capcode, u64 data),
+	TP_ARGS(qp, capcode, data),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u32, state)
+		__field(u8, capcode)
+		__field(u64, data)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->state = qp->state;
+		__entry->capcode = capcode;
+		__entry->data = data;
+	),
+	TP_printk(/* printk */
+		"[%s] qpn 0x%x (state 0x%x) Capcode %u data 0x%llx",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->state,
+		__entry->capcode,
+		__entry->data
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_data_template, hfi2_opfn_data_conn_request,
+	TP_PROTO(struct rvt_qp *qp, u8 capcode, u64 data),
+	TP_ARGS(qp, capcode, data)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_data_template, hfi2_opfn_data_conn_response,
+	TP_PROTO(struct rvt_qp *qp, u8 capcode, u64 data),
+	TP_ARGS(qp, capcode, data)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_data_template, hfi2_opfn_data_conn_reply,
+	TP_PROTO(struct rvt_qp *qp, u8 capcode, u64 data),
+	TP_ARGS(qp, capcode, data)
+);
+
+DECLARE_EVENT_CLASS(/* opfn_param */
+	hfi2_opfn_param_template,
+	TP_PROTO(struct rvt_qp *qp, char remote,
+		 struct tid_rdma_params *param),
+	TP_ARGS(qp, remote, param),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(char, remote)
+		__field(u32, param_qp)
+		__field(u32, max_len)
+		__field(u16, jkey)
+		__field(u8, max_read)
+		__field(u8, max_write)
+		__field(u8, timeout)
+		__field(u8, urg)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->remote = remote;
+		__entry->param_qp = param->qp;
+		__entry->max_len = param->max_len;
+		__entry->jkey = param->jkey;
+		__entry->max_read = param->max_read;
+		__entry->max_write = param->max_write;
+		__entry->timeout = param->timeout;
+		__entry->urg = param->urg;
+	),
+	TP_printk(/* print */
+		OPFN_PARAM_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->remote ? "remote" : "local",
+		__entry->param_qp,
+		__entry->max_read,
+		__entry->max_write,
+		__entry->max_len,
+		__entry->jkey,
+		__entry->timeout,
+		__entry->urg
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_opfn_param_template, hfi2_opfn_param,
+	TP_PROTO(struct rvt_qp *qp, char remote,
+		 struct tid_rdma_params *param),
+	TP_ARGS(qp, remote, param)
+);
+
+DECLARE_EVENT_CLASS(/* msg */
+	hfi2_msg_template,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more),
+	TP_STRUCT__entry(/* entry */
+		__field(u32, qpn)
+		__string(msg, msg)
+		__field(u64, more)
+	),
+	TP_fast_assign(/* assign */
+		__entry->qpn = qp ? qp->ibqp.qp_num : 0;
+		__assign_str(msg);
+		__entry->more = more;
+	),
+	TP_printk(/* print */
+		"qpn 0x%x %s 0x%llx",
+		__entry->qpn,
+		__get_str(msg),
+		__entry->more
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_msg_template, hfi2_msg_opfn_conn_request,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_msg_template, hfi2_msg_opfn_conn_error,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_msg_template, hfi2_msg_alloc_tids,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_msg_template, hfi2_msg_tid_restart_req,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_msg_template, hfi2_msg_handle_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_msg_template, hfi2_msg_tid_timeout,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_msg_template, hfi2_msg_tid_retry_timeout,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u64 more),
+	TP_ARGS(qp, msg, more)
+);
+
+DECLARE_EVENT_CLASS(/* tid_flow_page */
+	hfi2_tid_flow_page_template,
+	TP_PROTO(struct rvt_qp *qp, struct tid_rdma_flow *flow, u32 index,
+		 char mtu8k, char v1, void *vaddr),
+	TP_ARGS(qp, flow, index, mtu8k, v1, vaddr),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(char, mtu8k)
+		__field(char, v1)
+		__field(u32, index)
+		__field(u64, page)
+		__field(u64, vaddr)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->mtu8k = mtu8k;
+		__entry->v1 = v1;
+		__entry->index = index;
+		__entry->page = vaddr ? (u64)virt_to_page(vaddr) : 0ULL;
+		__entry->vaddr = (u64)vaddr;
+	),
+	TP_printk(/* print */
+		"[%s] qpn 0x%x page[%u]: page 0x%llx %s 0x%llx",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->index,
+		__entry->page,
+		__entry->mtu8k ? (__entry->v1 ? "v1" : "v0") : "vaddr",
+		__entry->vaddr
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_page_template, hfi2_tid_flow_page,
+	TP_PROTO(struct rvt_qp *qp, struct tid_rdma_flow *flow, u32 index,
+		 char mtu8k, char v1, void *vaddr),
+	TP_ARGS(qp, flow, index, mtu8k, v1, vaddr)
+);
+
+DECLARE_EVENT_CLASS(/* tid_pageset */
+	hfi2_tid_pageset_template,
+	TP_PROTO(struct rvt_qp *qp, u32 index, u16 idx, u16 count),
+	TP_ARGS(qp, index, idx, count),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u32, index)
+		__field(u16, idx)
+		__field(u16, count)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->index = index;
+		__entry->idx = idx;
+		__entry->count = count;
+	),
+	TP_printk(/* print */
+		"[%s] qpn 0x%x list[%u]: idx %u count %u",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->index,
+		__entry->idx,
+		__entry->count
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_pageset_template, hfi2_tid_pageset,
+	TP_PROTO(struct rvt_qp *qp, u32 index, u16 idx, u16 count),
+	TP_ARGS(qp, index, idx, count)
+);
+
+DECLARE_EVENT_CLASS(/* tid_fow */
+	hfi2_tid_flow_template,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(int, index)
+		__field(int, idx)
+		__field(u32, resp_ib_psn)
+		__field(u32, generation)
+		__field(u32, fspsn)
+		__field(u32, flpsn)
+		__field(u32, r_next_psn)
+		__field(u32, ib_spsn)
+		__field(u32, ib_lpsn)
+		__field(u32, npagesets)
+		__field(u32, tnode_cnt)
+		__field(u32, tidcnt)
+		__field(u32, tid_idx)
+		__field(u32, tid_offset)
+		__field(u32, length)
+		__field(u32, sent)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->index = index;
+		__entry->idx = flow->idx;
+		__entry->resp_ib_psn = flow->flow_state.resp_ib_psn;
+		__entry->generation = flow->flow_state.generation;
+		__entry->fspsn = full_flow_psn(flow,
+					       flow->flow_state.spsn);
+		__entry->flpsn = full_flow_psn(flow,
+					       flow->flow_state.lpsn);
+		__entry->r_next_psn = flow->flow_state.r_next_psn;
+		__entry->ib_spsn = flow->flow_state.ib_spsn;
+		__entry->ib_lpsn = flow->flow_state.ib_lpsn;
+		__entry->npagesets = flow->npagesets;
+		__entry->tnode_cnt = flow->tnode_cnt;
+		__entry->tidcnt = flow->tidcnt;
+		__entry->tid_idx = flow->tid_idx;
+		__entry->tid_offset =  flow->tid_offset;
+		__entry->length = flow->length;
+		__entry->sent = flow->sent;
+	),
+	TP_printk(/* print */
+		TID_FLOW_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->index,
+		__entry->idx,
+		__entry->resp_ib_psn,
+		__entry->generation,
+		__entry->fspsn,
+		__entry->flpsn,
+		__entry->r_next_psn,
+		__entry->ib_spsn,
+		__entry->ib_lpsn,
+		__entry->npagesets,
+		__entry->tnode_cnt,
+		__entry->tidcnt,
+		__entry->tid_idx,
+		__entry->tid_offset,
+		__entry->length,
+		__entry->sent
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_alloc,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_build_read_pkt,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_build_read_resp,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_rcv_read_req,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_rcv_read_resp,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_restart_req,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_build_write_resp,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_rcv_write_resp,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_build_write_data,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_rcv_tid_ack,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_rcv_resync,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_handle_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_flow_template, hfi2_tid_flow_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, int index, struct tid_rdma_flow *flow),
+	TP_ARGS(qp, index, flow)
+);
+
+DECLARE_EVENT_CLASS(/* tid_node */
+	hfi2_tid_node_template,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u32 index, u32 base,
+		 u8 map, u8 used, u8 cnt),
+	TP_ARGS(qp, msg, index, base, map, used, cnt),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__string(msg, msg)
+		__field(u32, index)
+		__field(u32, base)
+		__field(u8, map)
+		__field(u8, used)
+		__field(u8, cnt)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__assign_str(msg);
+		__entry->index = index;
+		__entry->base = base;
+		__entry->map = map;
+		__entry->used = used;
+		__entry->cnt = cnt;
+	),
+	TP_printk(/* print */
+		TID_NODE_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__get_str(msg),
+		__entry->index,
+		__entry->base,
+		__entry->map,
+		__entry->used,
+		__entry->cnt
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_node_template, hfi2_tid_node_add,
+	TP_PROTO(struct rvt_qp *qp, const char *msg, u32 index, u32 base,
+		 u8 map, u8 used, u8 cnt),
+	TP_ARGS(qp, msg, index, base, map, used, cnt)
+);
+
+DECLARE_EVENT_CLASS(/* tid_entry */
+	hfi2_tid_entry_template,
+	TP_PROTO(struct rvt_qp *qp, int index, u32 ent),
+	TP_ARGS(qp, index, ent),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(int, index)
+		__field(u8, ctrl)
+		__field(u16, idx)
+		__field(u16, len)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->index = index;
+		__entry->ctrl = hfi2_trace_get_tid_ctrl(ent);
+		__entry->idx = hfi2_trace_get_tid_idx(ent);
+		__entry->len = hfi2_trace_get_tid_len(ent);
+	),
+	TP_printk(/* print */
+		"[%s] qpn 0x%x TID entry %d: idx %u len %u ctrl 0x%x",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->index,
+		__entry->idx,
+		__entry->len,
+		__entry->ctrl
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_entry_template, hfi2_tid_entry_alloc,
+	TP_PROTO(struct rvt_qp *qp, int index, u32 entry),
+	TP_ARGS(qp, index, entry)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_entry_template, hfi2_tid_entry_build_read_resp,
+	TP_PROTO(struct rvt_qp *qp, int index, u32 ent),
+	TP_ARGS(qp, index, ent)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_entry_template, hfi2_tid_entry_rcv_read_req,
+	TP_PROTO(struct rvt_qp *qp, int index, u32 ent),
+	TP_ARGS(qp, index, ent)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_entry_template, hfi2_tid_entry_rcv_write_resp,
+	TP_PROTO(struct rvt_qp *qp, int index, u32 entry),
+	TP_ARGS(qp, index, entry)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_entry_template, hfi2_tid_entry_build_write_data,
+	TP_PROTO(struct rvt_qp *qp, int index, u32 entry),
+	TP_ARGS(qp, index, entry)
+);
+
+DECLARE_EVENT_CLASS(/* rsp_info */
+	hfi2_responder_info_template,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u8, state)
+		__field(u8, s_state)
+		__field(u32, psn)
+		__field(u32, r_psn)
+		__field(u8, r_state)
+		__field(u8, r_flags)
+		__field(u8, r_head_ack_queue)
+		__field(u8, s_tail_ack_queue)
+		__field(u8, s_acked_ack_queue)
+		__field(u8, s_ack_state)
+		__field(u8, s_nak_state)
+		__field(u8, r_nak_state)
+		__field(u32, s_flags)
+		__field(u32, ps_flags)
+		__field(unsigned long, iow_flags)
+	),
+	TP_fast_assign(/* assign */
+		struct hfi2_qp_priv *priv = qp->priv;
+
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->state = qp->state;
+		__entry->s_state = qp->s_state;
+		__entry->psn = psn;
+		__entry->r_psn = qp->r_psn;
+		__entry->r_state = qp->r_state;
+		__entry->r_flags = qp->r_flags;
+		__entry->r_head_ack_queue = qp->r_head_ack_queue;
+		__entry->s_tail_ack_queue = qp->s_tail_ack_queue;
+		__entry->s_acked_ack_queue = qp->s_acked_ack_queue;
+		__entry->s_ack_state = qp->s_ack_state;
+		__entry->s_nak_state = qp->s_nak_state;
+		__entry->s_flags = qp->s_flags;
+		__entry->ps_flags = priv->s_flags;
+		__entry->iow_flags = priv->s_iowait.flags;
+	),
+	TP_printk(/* print */
+		RSP_INFO_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->state,
+		__entry->s_state,
+		__entry->psn,
+		__entry->r_psn,
+		__entry->r_state,
+		__entry->r_flags,
+		__entry->r_head_ack_queue,
+		__entry->s_tail_ack_queue,
+		__entry->s_acked_ack_queue,
+		__entry->s_ack_state,
+		__entry->s_nak_state,
+		__entry->s_flags,
+		__entry->ps_flags,
+		__entry->iow_flags
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_make_rc_ack,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_rcv_tid_read_req,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_tid_rcv_error,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_tid_write_alloc_res,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_rcv_tid_write_req,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_build_tid_write_resp,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_rcv_tid_write_data,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_make_tid_ack,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_handle_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_responder_info_template, hfi2_rsp_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, u32 psn),
+	TP_ARGS(qp, psn)
+);
+
+DECLARE_EVENT_CLASS(/* sender_info */
+	hfi2_sender_info_template,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u8, state)
+		__field(u32, s_cur)
+		__field(u32, s_tail)
+		__field(u32, s_head)
+		__field(u32, s_acked)
+		__field(u32, s_last)
+		__field(u32, s_psn)
+		__field(u32, s_last_psn)
+		__field(u32, s_flags)
+		__field(u32, ps_flags)
+		__field(unsigned long, iow_flags)
+		__field(u8, s_state)
+		__field(u8, s_num_rd)
+		__field(u8, s_retry)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->state = qp->state;
+		__entry->s_cur = qp->s_cur;
+		__entry->s_tail = qp->s_tail;
+		__entry->s_head = qp->s_head;
+		__entry->s_acked = qp->s_acked;
+		__entry->s_last = qp->s_last;
+		__entry->s_psn = qp->s_psn;
+		__entry->s_last_psn = qp->s_last_psn;
+		__entry->s_flags = qp->s_flags;
+		__entry->ps_flags = ((struct hfi2_qp_priv *)qp->priv)->s_flags;
+		__entry->iow_flags =
+			((struct hfi2_qp_priv *)qp->priv)->s_iowait.flags;
+		__entry->s_state = qp->s_state;
+		__entry->s_num_rd = qp->s_num_rd_atomic;
+		__entry->s_retry = qp->s_retry;
+	),
+	TP_printk(/* print */
+		SENDER_INFO_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->state,
+		__entry->s_cur,
+		__entry->s_tail,
+		__entry->s_head,
+		__entry->s_acked,
+		__entry->s_last,
+		__entry->s_psn,
+		__entry->s_last_psn,
+		__entry->s_flags,
+		__entry->ps_flags,
+		__entry->iow_flags,
+		__entry->s_state,
+		__entry->s_num_rd,
+		__entry->s_retry
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_make_rc_req,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_reset_psn,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_restart_rc,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_do_rc_ack,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_rcv_tid_read_resp,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_rcv_tid_ack,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_make_tid_pkt,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sender_info_template, hfi2_sender_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DECLARE_EVENT_CLASS(/* tid_read_sender */
+	hfi2_tid_read_sender_template,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(char, newreq)
+		__field(u32, tid_r_reqs)
+		__field(u32, tid_r_comp)
+		__field(u32, pending_tid_r_segs)
+		__field(u32, s_flags)
+		__field(u32, ps_flags)
+		__field(unsigned long, iow_flags)
+		__field(u8, s_state)
+		__field(u32, hw_flow_index)
+		__field(u32, generation)
+		__field(u32, fpsn)
+	),
+	TP_fast_assign(/* assign */
+		struct hfi2_qp_priv *priv = qp->priv;
+
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->newreq = newreq;
+		__entry->tid_r_reqs = priv->tid_r_reqs;
+		__entry->tid_r_comp = priv->tid_r_comp;
+		__entry->pending_tid_r_segs = priv->pending_tid_r_segs;
+		__entry->s_flags = qp->s_flags;
+		__entry->ps_flags = priv->s_flags;
+		__entry->iow_flags = priv->s_iowait.flags;
+		__entry->s_state = priv->s_state;
+		__entry->hw_flow_index = priv->flow_state.index;
+		__entry->generation = priv->flow_state.generation;
+		__entry->fpsn = priv->flow_state.psn;
+	),
+	TP_printk(/* print */
+		TID_READ_SENDER_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->newreq,
+		__entry->tid_r_reqs,
+		__entry->tid_r_comp,
+		__entry->pending_tid_r_segs,
+		__entry->s_flags,
+		__entry->ps_flags,
+		__entry->iow_flags,
+		__entry->s_state,
+		__entry->hw_flow_index,
+		__entry->generation,
+		__entry->fpsn
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_read_sender_template, hfi2_tid_read_sender_make_req,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_read_sender_template, hfi2_tid_read_sender_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DECLARE_EVENT_CLASS(/* tid_rdma_request */
+	hfi2_tid_rdma_request_template,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(char, newreq)
+		__field(u8, opcode)
+		__field(u32, psn)
+		__field(u32, lpsn)
+		__field(u32, cur_seg)
+		__field(u32, comp_seg)
+		__field(u32, ack_seg)
+		__field(u32, alloc_seg)
+		__field(u32, total_segs)
+		__field(u16, setup_head)
+		__field(u16, clear_tail)
+		__field(u16, flow_idx)
+		__field(u16, acked_tail)
+		__field(u32, state)
+		__field(u32, r_ack_psn)
+		__field(u32, r_flow_psn)
+		__field(u32, r_last_acked)
+		__field(u32, s_next_psn)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->newreq = newreq;
+		__entry->opcode = opcode;
+		__entry->psn = psn;
+		__entry->lpsn = lpsn;
+		__entry->cur_seg = req->cur_seg;
+		__entry->comp_seg = req->comp_seg;
+		__entry->ack_seg = req->ack_seg;
+		__entry->alloc_seg = req->alloc_seg;
+		__entry->total_segs = req->total_segs;
+		__entry->setup_head = req->setup_head;
+		__entry->clear_tail = req->clear_tail;
+		__entry->flow_idx = req->flow_idx;
+		__entry->acked_tail = req->acked_tail;
+		__entry->state = req->state;
+		__entry->r_ack_psn = req->r_ack_psn;
+		__entry->r_flow_psn = req->r_flow_psn;
+		__entry->r_last_acked = req->r_last_acked;
+		__entry->s_next_psn = req->s_next_psn;
+	),
+	TP_printk(/* print */
+		TID_REQ_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->newreq,
+		__entry->opcode,
+		__entry->psn,
+		__entry->lpsn,
+		__entry->cur_seg,
+		__entry->comp_seg,
+		__entry->ack_seg,
+		__entry->alloc_seg,
+		__entry->total_segs,
+		__entry->setup_head,
+		__entry->clear_tail,
+		__entry->flow_idx,
+		__entry->acked_tail,
+		__entry->state,
+		__entry->r_ack_psn,
+		__entry->r_flow_psn,
+		__entry->r_last_acked,
+		__entry->s_next_psn
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_make_req_read,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_build_read_req,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_read_req,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_read_resp,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_err,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_restart_req,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_setup_tid_wqe,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_write_alloc_res,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_write_req,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_build_write_resp,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_write_resp,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_write_data,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_tid_ack,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_tid_retry_timeout,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_rcv_resync,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_make_tid_pkt,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_make_tid_ack,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_handle_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_read_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_make_rc_ack_write,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_make_req_write,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_rdma_request_template, hfi2_tid_req_update_num_rd_atomic,
+	TP_PROTO(struct rvt_qp *qp, char newreq, u8 opcode, u32 psn, u32 lpsn,
+		 struct tid_rdma_request *req),
+	TP_ARGS(qp, newreq, opcode, psn, lpsn, req)
+);
+
+DECLARE_EVENT_CLASS(/* rc_rcv_err */
+	hfi2_rc_rcv_err_template,
+	TP_PROTO(struct rvt_qp *qp, u32 opcode, u32 psn, int diff),
+	TP_ARGS(qp, opcode, psn, diff),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u32, s_flags)
+		__field(u8, state)
+		__field(u8, s_acked_ack_queue)
+		__field(u8, s_tail_ack_queue)
+		__field(u8, r_head_ack_queue)
+		__field(u32, opcode)
+		__field(u32, psn)
+		__field(u32, r_psn)
+		__field(int, diff)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->s_flags = qp->s_flags;
+		__entry->state = qp->state;
+		__entry->s_acked_ack_queue = qp->s_acked_ack_queue;
+		__entry->s_tail_ack_queue = qp->s_tail_ack_queue;
+		__entry->r_head_ack_queue = qp->r_head_ack_queue;
+		__entry->opcode = opcode;
+		__entry->psn = psn;
+		__entry->r_psn = qp->r_psn;
+		__entry->diff = diff;
+	),
+	TP_printk(/* print */
+		RCV_ERR_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->s_flags,
+		__entry->state,
+		__entry->s_acked_ack_queue,
+		__entry->s_tail_ack_queue,
+		__entry->r_head_ack_queue,
+		__entry->opcode,
+		__entry->psn,
+		__entry->r_psn,
+		__entry->diff
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_rc_rcv_err_template, hfi2_tid_rdma_rcv_err,
+	TP_PROTO(struct rvt_qp *qp, u32 opcode, u32 psn, int diff),
+	TP_ARGS(qp, opcode, psn, diff)
+);
+
+DECLARE_EVENT_CLASS(/* sge  */
+	hfi2_sge_template,
+	TP_PROTO(struct rvt_qp *qp, int index, struct rvt_sge *sge),
+	TP_ARGS(qp, index, sge),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(int, index)
+		__field(u64, vaddr)
+		__field(u32, sge_length)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->index = index;
+		__entry->vaddr = (u64)sge->vaddr;
+		__entry->sge_length = sge->sge_length;
+	),
+	TP_printk(/* print */
+		"[%s] qpn 0x%x sge %d: vaddr 0x%llx sge_length %u",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->index,
+		__entry->vaddr,
+		__entry->sge_length
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_sge_template, hfi2_sge_check_align,
+	TP_PROTO(struct rvt_qp *qp, int index, struct rvt_sge *sge),
+	TP_ARGS(qp, index, sge)
+);
+
+DECLARE_EVENT_CLASS(/* tid_write_sp */
+	hfi2_tid_write_rsp_template,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u32, r_tid_head)
+		__field(u32, r_tid_tail)
+		__field(u32, r_tid_ack)
+		__field(u32, r_tid_alloc)
+		__field(u32, alloc_w_segs)
+		__field(u32, pending_tid_w_segs)
+		__field(bool, sync_pt)
+		__field(u32, ps_nak_psn)
+		__field(u8, ps_nak_state)
+		__field(u8, prnr_nak_state)
+		__field(u32, hw_flow_index)
+		__field(u32, generation)
+		__field(u32, fpsn)
+		__field(bool, resync)
+		__field(u32, r_next_psn_kdeth)
+	),
+	TP_fast_assign(/* assign */
+		struct hfi2_qp_priv *priv = qp->priv;
+
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->r_tid_head = priv->r_tid_head;
+		__entry->r_tid_tail = priv->r_tid_tail;
+		__entry->r_tid_ack = priv->r_tid_ack;
+		__entry->r_tid_alloc = priv->r_tid_alloc;
+		__entry->alloc_w_segs = priv->alloc_w_segs;
+		__entry->pending_tid_w_segs = priv->pending_tid_w_segs;
+		__entry->sync_pt = priv->sync_pt;
+		__entry->ps_nak_psn = priv->s_nak_psn;
+		__entry->ps_nak_state = priv->s_nak_state;
+		__entry->prnr_nak_state = priv->rnr_nak_state;
+		__entry->hw_flow_index = priv->flow_state.index;
+		__entry->generation = priv->flow_state.generation;
+		__entry->fpsn = priv->flow_state.psn;
+		__entry->resync = priv->resync;
+		__entry->r_next_psn_kdeth = priv->r_next_psn_kdeth;
+	),
+	TP_printk(/* print */
+		TID_WRITE_RSPDR_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->r_tid_head,
+		__entry->r_tid_tail,
+		__entry->r_tid_ack,
+		__entry->r_tid_alloc,
+		__entry->alloc_w_segs,
+		__entry->pending_tid_w_segs,
+		__entry->sync_pt ? "yes" : "no",
+		__entry->ps_nak_psn,
+		__entry->ps_nak_state,
+		__entry->prnr_nak_state,
+		__entry->hw_flow_index,
+		__entry->generation,
+		__entry->fpsn,
+		__entry->resync ? "yes" : "no",
+		__entry->r_next_psn_kdeth
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_alloc_res,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_rcv_req,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_build_resp,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_rcv_data,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_rcv_resync,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_make_tid_ack,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_handle_kdeth_eflags,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_rsp_template, hfi2_tid_write_rsp_make_rc_ack,
+	TP_PROTO(struct rvt_qp *qp),
+	TP_ARGS(qp)
+);
+
+DECLARE_EVENT_CLASS(/* tid_write_sender */
+	hfi2_tid_write_sender_template,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(char, newreq)
+		__field(u32, s_tid_cur)
+		__field(u32, s_tid_tail)
+		__field(u32, s_tid_head)
+		__field(u32, pending_tid_w_resp)
+		__field(u32, n_requests)
+		__field(u32, n_tid_requests)
+		__field(u32, s_flags)
+		__field(u32, ps_flags)
+		__field(unsigned long, iow_flags)
+		__field(u8, s_state)
+		__field(u8, s_retry)
+	),
+	TP_fast_assign(/* assign */
+		struct hfi2_qp_priv *priv = qp->priv;
+
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->newreq = newreq;
+		__entry->s_tid_cur = priv->s_tid_cur;
+		__entry->s_tid_tail = priv->s_tid_tail;
+		__entry->s_tid_head = priv->s_tid_head;
+		__entry->pending_tid_w_resp = priv->pending_tid_w_resp;
+		__entry->n_requests = atomic_read(&priv->n_requests);
+		__entry->n_tid_requests = atomic_read(&priv->n_tid_requests);
+		__entry->s_flags = qp->s_flags;
+		__entry->ps_flags = priv->s_flags;
+		__entry->iow_flags = priv->s_iowait.flags;
+		__entry->s_state = priv->s_state;
+		__entry->s_retry = priv->s_retry;
+	),
+	TP_printk(/* print */
+		TID_WRITE_SENDER_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->newreq,
+		__entry->s_tid_cur,
+		__entry->s_tid_tail,
+		__entry->s_tid_head,
+		__entry->pending_tid_w_resp,
+		__entry->n_requests,
+		__entry->n_tid_requests,
+		__entry->s_flags,
+		__entry->ps_flags,
+		__entry->iow_flags,
+		__entry->s_state,
+		__entry->s_retry
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_sender_template, hfi2_tid_write_sender_rcv_resp,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_sender_template, hfi2_tid_write_sender_rcv_tid_ack,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_sender_template, hfi2_tid_write_sender_retry_timeout,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_sender_template, hfi2_tid_write_sender_make_tid_pkt,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_sender_template, hfi2_tid_write_sender_make_req,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_tid_write_sender_template, hfi2_tid_write_sender_restart_rc,
+	TP_PROTO(struct rvt_qp *qp, char newreq),
+	TP_ARGS(qp, newreq)
+);
+
+DECLARE_EVENT_CLASS(/* tid_ack */
+	hfi2_tid_ack_template,
+	TP_PROTO(struct rvt_qp *qp, u32 aeth, u32 psn,
+		 u32 req_psn, u32 resync_psn),
+	TP_ARGS(qp, aeth, psn, req_psn, resync_psn),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u32, aeth)
+		__field(u32, psn)
+		__field(u32, req_psn)
+		__field(u32, resync_psn)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->aeth = aeth;
+		__entry->psn = psn;
+		__entry->req_psn = req_psn;
+		__entry->resync_psn = resync_psn;
+		),
+	TP_printk(/* print */
+		"[%s] qpn 0x%x aeth 0x%x psn 0x%x req_psn 0x%x resync_psn 0x%x",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->aeth,
+		__entry->psn,
+		__entry->req_psn,
+		__entry->resync_psn
+	)
+);
+
+DEFINE_EVENT(/* rcv_tid_ack */
+	hfi2_tid_ack_template, hfi2_rcv_tid_ack,
+	TP_PROTO(struct rvt_qp *qp, u32 aeth, u32 psn,
+		 u32 req_psn, u32 resync_psn),
+	TP_ARGS(qp, aeth, psn, req_psn, resync_psn)
+);
+
+DECLARE_EVENT_CLASS(/* kdeth_eflags_error */
+	hfi2_kdeth_eflags_error_template,
+	TP_PROTO(struct rvt_qp *qp, u8 rcv_type, u8 rte, u32 psn),
+	TP_ARGS(qp, rcv_type, rte, psn),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(u8, rcv_type)
+		__field(u8, rte)
+		__field(u32, psn)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->rcv_type = rcv_type;
+		__entry->rte = rte;
+		__entry->psn = psn;
+	),
+	TP_printk(/* print */
+		KDETH_EFLAGS_ERR_PRN,
+		__get_str(dev),
+		__entry->qpn,
+		__entry->rcv_type,
+		__entry->rte,
+		__entry->psn
+	)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_kdeth_eflags_error_template, hfi2_eflags_err_write,
+	TP_PROTO(struct rvt_qp *qp, u8 rcv_type, u8 rte, u32 psn),
+	TP_ARGS(qp, rcv_type, rte, psn)
+);
+
+#endif /* __HFI2_TRACE_TID_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_tid
+#include <trace/define_trace.h>
diff --git a/drivers/infiniband/hw/hfi2/trace_tx.h b/drivers/infiniband/hw/hfi2/trace_tx.h
new file mode 100644
index 000000000000..9a0edd08d7b7
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/trace_tx.h
@@ -0,0 +1,1186 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright(c) 2015 - 2017 Intel Corporation.
+ */
+#if !defined(__HFI2_TRACE_TX_H) || defined(TRACE_HEADER_MULTI_READ)
+#define __HFI2_TRACE_TX_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "hfi2.h"
+#include "mad.h"
+#include "sdma.h"
+#include "ipoib.h"
+#include "user_sdma.h"
+
+const char *parse_sdma_flags(struct trace_seq *p, u64 *qw, u8 first, u8 last);
+
+#define __parse_sdma_flags(qw, first, last) parse_sdma_flags(p, qw, first, last)
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM hfi2_tx
+
+TRACE_EVENT(hfi2_piofree,
+	    TP_PROTO(struct send_context *sc, int extra),
+	    TP_ARGS(sc, extra),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(sc->dd)
+	    __field(u32, sw_index)
+	    __field(u32, hw_context)
+	    __field(int, extra)
+	    ),
+	    TP_fast_assign(DD_DEV_ASSIGN(sc->dd);
+	    __entry->sw_index = sc->sw_index;
+	    __entry->hw_context = sc->hw_context;
+	    __entry->extra = extra;
+	    ),
+	    TP_printk("[%s] ctxt %u(%u) extra %d",
+		      __get_str(dev),
+		      __entry->sw_index,
+		      __entry->hw_context,
+		      __entry->extra
+	    )
+);
+
+TRACE_EVENT(hfi2_wantpiointr,
+	    TP_PROTO(struct send_context *sc, u32 needint, u64 credit_ctrl),
+	    TP_ARGS(sc, needint, credit_ctrl),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(sc->dd)
+			__field(u32, sw_index)
+			__field(u32, hw_context)
+			__field(u32, needint)
+			__field(u64, credit_ctrl)
+			),
+	    TP_fast_assign(DD_DEV_ASSIGN(sc->dd);
+			__entry->sw_index = sc->sw_index;
+			__entry->hw_context = sc->hw_context;
+			__entry->needint = needint;
+			__entry->credit_ctrl = credit_ctrl;
+			),
+	    TP_printk("[%s] ctxt %u(%u) on %d credit_ctrl 0x%llx",
+		      __get_str(dev),
+		      __entry->sw_index,
+		      __entry->hw_context,
+		      __entry->needint,
+		      (unsigned long long)__entry->credit_ctrl
+		      )
+);
+
+DECLARE_EVENT_CLASS(hfi2_qpsleepwakeup_template,
+		    TP_PROTO(struct rvt_qp *qp, u32 flags),
+		    TP_ARGS(qp, flags),
+		    TP_STRUCT__entry(
+		    DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		    __field(u32, qpn)
+		    __field(u32, flags)
+		    __field(u32, s_flags)
+		    __field(u32, ps_flags)
+		    __field(unsigned long, iow_flags)
+		    ),
+		    TP_fast_assign(
+		    DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		    __entry->flags = flags;
+		    __entry->qpn = qp->ibqp.qp_num;
+		    __entry->s_flags = qp->s_flags;
+		    __entry->ps_flags =
+			((struct hfi2_qp_priv *)qp->priv)->s_flags;
+		    __entry->iow_flags =
+			((struct hfi2_qp_priv *)qp->priv)->s_iowait.flags;
+		    ),
+		    TP_printk(
+		    "[%s] qpn 0x%x flags 0x%x s_flags 0x%x ps_flags 0x%x iow_flags 0x%lx",
+		    __get_str(dev),
+		    __entry->qpn,
+		    __entry->flags,
+		    __entry->s_flags,
+		    __entry->ps_flags,
+		    __entry->iow_flags
+		    )
+);
+
+DEFINE_EVENT(hfi2_qpsleepwakeup_template, hfi2_qpwakeup,
+	     TP_PROTO(struct rvt_qp *qp, u32 flags),
+	     TP_ARGS(qp, flags));
+
+DEFINE_EVENT(hfi2_qpsleepwakeup_template, hfi2_qpsleep,
+	     TP_PROTO(struct rvt_qp *qp, u32 flags),
+	     TP_ARGS(qp, flags));
+
+TRACE_EVENT(hfi2_sdma_descriptor,
+	    TP_PROTO(struct sdma_engine *sde,
+		     u64 *qw,
+		     u16 e,
+		     void *descp),
+	    TP_ARGS(sde, qw, e, descp),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(sde->dd)
+		     __field(void *, descp)
+		     __array(u64, qw, 2)
+		     __field(u64, phy_addr)
+		     __field(u32, len)
+		     __field(u16, e)
+		     __field(u8, idx)
+		     __field(u8, first)
+		     __field(u8, last)
+		     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
+		     __entry->qw[0] = qw[0];
+		     __entry->qw[1] = qw[1];
+		     __entry->phy_addr = sdma_qw_get(sde->dd, phy_addr, qw);
+		     __entry->len = sdma_qw_get(sde->dd, byte_count, qw);
+		     __entry->idx = sde->this_idx;
+		     __entry->first = sdma_qw_get(sde->dd, first_desc, qw);
+		     __entry->last = sdma_qw_get(sde->dd, last_desc, qw);
+		     __entry->descp = descp;
+		     __entry->e = e;
+		     ),
+	    TP_printk(
+	    "[%s] SDE(%u) flags:%s addr:0x%016llx gen:%u len:%u d0:%016llx d1:%016llx to %p,%u",
+	    __get_str(dev),
+	    __entry->idx,
+	    __parse_sdma_flags(__entry->qw, __entry->first, __entry->last),
+	    __entry->phy_addr,
+	    (u8)((__entry->qw[1] >> SDMA_DESC1_GENERATION_SHIFT) &
+	    SDMA_DESC1_GENERATION_MASK),
+	    __entry->len,
+	    __entry->qw[0],
+	    __entry->qw[1],
+	    __entry->descp,
+	    __entry->e
+	    )
+);
+
+TRACE_EVENT(hfi2_sdma_engine_select,
+	    TP_PROTO(struct hfi2_devdata *dd, u32 sel, u8 vl, u8 idx),
+	    TP_ARGS(dd, sel, vl, idx),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+	    __field(u32, sel)
+	    __field(u8, vl)
+	    __field(u8, idx)
+	    ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+	    __entry->sel = sel;
+	    __entry->vl = vl;
+	    __entry->idx = idx;
+	    ),
+	    TP_printk("[%s] selecting SDE %u sel 0x%x vl %u",
+		      __get_str(dev),
+		      __entry->idx,
+		      __entry->sel,
+		      __entry->vl
+		      )
+);
+
+TRACE_EVENT(hfi2_sdma_user_free_queues,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt),
+	    TP_ARGS(dd, ctxt, subctxt),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __field(u16, ctxt)
+			     __field(u16, subctxt)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			   __entry->ctxt = ctxt;
+			   __entry->subctxt = subctxt;
+			   ),
+	    TP_printk("[%s] SDMA [%u:%u] Freeing user SDMA queues",
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt
+		      )
+);
+
+TRACE_EVENT(hfi2_sdma_user_process_request,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt,
+		     u16 comp_idx),
+	    TP_ARGS(dd, ctxt, subctxt, comp_idx),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __field(u16, ctxt)
+			     __field(u16, subctxt)
+			     __field(u16, comp_idx)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			   __entry->ctxt = ctxt;
+			   __entry->subctxt = subctxt;
+			   __entry->comp_idx = comp_idx;
+			   ),
+	    TP_printk("[%s] SDMA [%u:%u] Using req/comp entry: %u",
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->comp_idx
+		      )
+);
+
+DECLARE_EVENT_CLASS(
+	hfi2_sdma_value_template,
+	TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt, u16 comp_idx,
+		 u32 value),
+	TP_ARGS(dd, ctxt, subctxt, comp_idx, value),
+	TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			 __field(u16, ctxt)
+			 __field(u16, subctxt)
+			 __field(u16, comp_idx)
+			 __field(u32, value)
+		),
+	TP_fast_assign(DD_DEV_ASSIGN(dd);
+		       __entry->ctxt = ctxt;
+		       __entry->subctxt = subctxt;
+		       __entry->comp_idx = comp_idx;
+		       __entry->value = value;
+		),
+	TP_printk("[%s] SDMA [%u:%u:%u] value: %u",
+		  __get_str(dev),
+		  __entry->ctxt,
+		  __entry->subctxt,
+		  __entry->comp_idx,
+		  __entry->value
+		)
+);
+
+DEFINE_EVENT(hfi2_sdma_value_template, hfi2_sdma_user_initial_tidoffset,
+	     TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt,
+		      u16 comp_idx, u32 tidoffset),
+	     TP_ARGS(dd, ctxt, subctxt, comp_idx, tidoffset));
+
+DEFINE_EVENT(hfi2_sdma_value_template, hfi2_sdma_user_data_length,
+	     TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt,
+		      u16 comp_idx, u32 data_len),
+	     TP_ARGS(dd, ctxt, subctxt, comp_idx, data_len));
+
+DEFINE_EVENT(hfi2_sdma_value_template, hfi2_sdma_user_compute_length,
+	     TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt,
+		      u16 comp_idx, u32 data_len),
+	     TP_ARGS(dd, ctxt, subctxt, comp_idx, data_len));
+
+TRACE_EVENT(hfi2_sdma_user_tid_info,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt,
+		     u16 comp_idx, u32 tidoffset, u32 units, u8 shift),
+	    TP_ARGS(dd, ctxt, subctxt, comp_idx, tidoffset, units, shift),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __field(u16, ctxt)
+			     __field(u16, subctxt)
+			     __field(u16, comp_idx)
+			     __field(u32, tidoffset)
+			     __field(u32, units)
+			     __field(u8, shift)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			   __entry->ctxt = ctxt;
+			   __entry->subctxt = subctxt;
+			   __entry->comp_idx = comp_idx;
+			   __entry->tidoffset = tidoffset;
+			   __entry->units = units;
+			   __entry->shift = shift;
+			   ),
+	    TP_printk("[%s] SDMA [%u:%u:%u] TID offset %ubytes %uunits om %u",
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->comp_idx,
+		      __entry->tidoffset,
+		      __entry->units,
+		      __entry->shift
+		      )
+);
+
+TRACE_EVENT(hfi2_sdma_request,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt,
+		     unsigned long dim),
+	    TP_ARGS(dd, ctxt, subctxt, dim),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+			     __field(u16, ctxt)
+			     __field(u16, subctxt)
+			     __field(unsigned long, dim)
+			     ),
+	    TP_fast_assign(DD_DEV_ASSIGN(dd);
+			   __entry->ctxt = ctxt;
+			   __entry->subctxt = subctxt;
+			   __entry->dim = dim;
+			   ),
+	    TP_printk("[%s] SDMA from %u:%u (%lu)",
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->dim
+		      )
+);
+
+DECLARE_EVENT_CLASS(hfi2_sdma_engine_class,
+		    TP_PROTO(struct sdma_engine *sde, u64 status),
+		    TP_ARGS(sde, status),
+		    TP_STRUCT__entry(DD_DEV_ENTRY(sde->dd)
+		    __field(u64, status)
+		    __field(u8, idx)
+		    ),
+		    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
+		    __entry->status = status;
+		    __entry->idx = sde->this_idx;
+		    ),
+		    TP_printk("[%s] SDE(%u) status %llx",
+			      __get_str(dev),
+			      __entry->idx,
+			      (unsigned long long)__entry->status
+			      )
+);
+
+DEFINE_EVENT(hfi2_sdma_engine_class, hfi2_sdma_engine_interrupt,
+	     TP_PROTO(struct sdma_engine *sde, u64 status),
+	     TP_ARGS(sde, status)
+);
+
+DEFINE_EVENT(hfi2_sdma_engine_class, hfi2_sdma_engine_progress,
+	     TP_PROTO(struct sdma_engine *sde, u64 status),
+	     TP_ARGS(sde, status)
+);
+
+DECLARE_EVENT_CLASS(hfi2_sdma_ahg_ad,
+		    TP_PROTO(struct sdma_engine *sde, int aidx),
+		    TP_ARGS(sde, aidx),
+		    TP_STRUCT__entry(DD_DEV_ENTRY(sde->dd)
+		    __field(int, aidx)
+		    __field(u8, idx)
+		    ),
+		    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
+		    __entry->idx = sde->this_idx;
+		    __entry->aidx = aidx;
+		    ),
+		    TP_printk("[%s] SDE(%u) aidx %d",
+			      __get_str(dev),
+			      __entry->idx,
+			      __entry->aidx
+			      )
+);
+
+DEFINE_EVENT(hfi2_sdma_ahg_ad, hfi2_ahg_allocate,
+	     TP_PROTO(struct sdma_engine *sde, int aidx),
+	     TP_ARGS(sde, aidx));
+
+DEFINE_EVENT(hfi2_sdma_ahg_ad, hfi2_ahg_deallocate,
+	     TP_PROTO(struct sdma_engine *sde, int aidx),
+	     TP_ARGS(sde, aidx));
+
+#ifdef CONFIG_HFI2_DEBUG_SDMA_ORDER
+TRACE_EVENT(hfi2_sdma_progress,
+	    TP_PROTO(struct sdma_engine *sde,
+		     u16 hwhead,
+		     u16 swhead,
+		     struct sdma_txreq *txp
+		     ),
+	    TP_ARGS(sde, hwhead, swhead, txp),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(sde->dd)
+	    __field(u64, sn)
+	    __field(u16, hwhead)
+	    __field(u16, swhead)
+	    __field(u16, txnext)
+	    __field(u16, tx_tail)
+	    __field(u16, tx_head)
+	    __field(u8, idx)
+	    ),
+	    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
+	    __entry->hwhead = hwhead;
+	    __entry->swhead = swhead;
+	    __entry->tx_tail = sde->tx_tail;
+	    __entry->tx_head = sde->tx_head;
+	    __entry->txnext = txp ? txp->next_descq_idx : ~0;
+	    __entry->idx = sde->this_idx;
+	    __entry->sn = txp ? txp->sn : ~0;
+	    ),
+	    TP_printk(
+	    "[%s] SDE(%u) sn %llu hwhead %u swhead %u next_descq_idx %u tx_head %u tx_tail %u",
+	    __get_str(dev),
+	    __entry->idx,
+	    __entry->sn,
+	    __entry->hwhead,
+	    __entry->swhead,
+	    __entry->txnext,
+	    __entry->tx_head,
+	    __entry->tx_tail
+	    )
+);
+#else
+TRACE_EVENT(hfi2_sdma_progress,
+	    TP_PROTO(struct sdma_engine *sde,
+		     u16 hwhead, u16 swhead,
+		     struct sdma_txreq *txp
+		     ),
+	    TP_ARGS(sde, hwhead, swhead, txp),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(sde->dd)
+		    __field(u16, hwhead)
+		    __field(u16, swhead)
+		    __field(u16, txnext)
+		    __field(u16, tx_tail)
+		    __field(u16, tx_head)
+		    __field(u8, idx)
+		    ),
+	    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
+		    __entry->hwhead = hwhead;
+		    __entry->swhead = swhead;
+		    __entry->tx_tail = sde->tx_tail;
+		    __entry->tx_head = sde->tx_head;
+		    __entry->txnext = txp ? txp->next_descq_idx : ~0;
+		    __entry->idx = sde->this_idx;
+		    ),
+	    TP_printk(
+		    "[%s] SDE(%u) hwhead %u swhead %u next_descq_idx %u tx_head %u tx_tail %u",
+		    __get_str(dev),
+		    __entry->idx,
+		    __entry->hwhead,
+		    __entry->swhead,
+		    __entry->txnext,
+		    __entry->tx_head,
+		    __entry->tx_tail
+	    )
+);
+#endif
+
+DECLARE_EVENT_CLASS(hfi2_sdma_sn,
+		    TP_PROTO(struct sdma_engine *sde, u64 sn),
+		    TP_ARGS(sde, sn),
+		    TP_STRUCT__entry(DD_DEV_ENTRY(sde->dd)
+		    __field(u64, sn)
+		    __field(u8, idx)
+		    ),
+		    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
+		    __entry->sn = sn;
+		    __entry->idx = sde->this_idx;
+		    ),
+		    TP_printk("[%s] SDE(%u) sn %llu",
+			      __get_str(dev),
+			      __entry->idx,
+			      __entry->sn
+			      )
+);
+
+DEFINE_EVENT(hfi2_sdma_sn, hfi2_sdma_out_sn,
+	     TP_PROTO(
+	     struct sdma_engine *sde,
+	     u64 sn
+	     ),
+	     TP_ARGS(sde, sn)
+);
+
+DEFINE_EVENT(hfi2_sdma_sn, hfi2_sdma_in_sn,
+	     TP_PROTO(struct sdma_engine *sde, u64 sn),
+	     TP_ARGS(sde, sn)
+);
+
+#define USDMA_HDR_FORMAT \
+	"[%s:%u:%u:%u] PBC=(0x%x 0x%x) LRH=(0x%x 0x%x) BTH=(0x%x 0x%x 0x%x) KDETH=(0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x) TIDVal=0x%x"
+
+TRACE_EVENT(hfi2_sdma_user_header,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt, u16 req,
+		     struct hfi2_pkt_header *hdr, u32 tidval),
+	    TP_ARGS(dd, ctxt, subctxt, req, hdr, tidval),
+	    TP_STRUCT__entry(
+		    DD_DEV_ENTRY(dd)
+		    __field(u16, ctxt)
+		    __field(u16, subctxt)
+		    __field(u16, req)
+		    __field(u32, pbc0)
+		    __field(u32, pbc1)
+		    __field(u32, lrh0)
+		    __field(u32, lrh1)
+		    __field(u32, bth0)
+		    __field(u32, bth1)
+		    __field(u32, bth2)
+		    __field(u32, kdeth0)
+		    __field(u32, kdeth1)
+		    __field(u32, kdeth2)
+		    __field(u32, kdeth3)
+		    __field(u32, kdeth4)
+		    __field(u32, kdeth5)
+		    __field(u32, kdeth6)
+		    __field(u32, kdeth7)
+		    __field(u32, kdeth8)
+		    __field(u32, tidval)
+		    ),
+		    TP_fast_assign(
+		    __le32 *pbc = (__le32 *)hdr->pbc;
+		    __be32 *lrh = (__be32 *)hdr->lrh;
+		    __be32 *bth = (__be32 *)hdr->bth;
+		    __le32 *kdeth = (__le32 *)&hdr->kdeth;
+
+		    DD_DEV_ASSIGN(dd);
+		    __entry->ctxt = ctxt;
+		    __entry->subctxt = subctxt;
+		    __entry->req = req;
+		    __entry->pbc0 = le32_to_cpu(pbc[0]);
+		    __entry->pbc1 = le32_to_cpu(pbc[1]);
+		    __entry->lrh0 = be32_to_cpu(lrh[0]);
+		    __entry->lrh1 = be32_to_cpu(lrh[1]);
+		    __entry->bth0 = be32_to_cpu(bth[0]);
+		    __entry->bth1 = be32_to_cpu(bth[1]);
+		    __entry->bth2 = be32_to_cpu(bth[2]);
+		    __entry->kdeth0 = le32_to_cpu(kdeth[0]);
+		    __entry->kdeth1 = le32_to_cpu(kdeth[1]);
+		    __entry->kdeth2 = le32_to_cpu(kdeth[2]);
+		    __entry->kdeth3 = le32_to_cpu(kdeth[3]);
+		    __entry->kdeth4 = le32_to_cpu(kdeth[4]);
+		    __entry->kdeth5 = le32_to_cpu(kdeth[5]);
+		    __entry->kdeth6 = le32_to_cpu(kdeth[6]);
+		    __entry->kdeth7 = le32_to_cpu(kdeth[7]);
+		    __entry->kdeth8 = le32_to_cpu(kdeth[8]);
+		    __entry->tidval = tidval;
+	    ),
+	    TP_printk(USDMA_HDR_FORMAT,
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->req,
+		      __entry->pbc1,
+		      __entry->pbc0,
+		      __entry->lrh0,
+		      __entry->lrh1,
+		      __entry->bth0,
+		      __entry->bth1,
+		      __entry->bth2,
+		      __entry->kdeth0,
+		      __entry->kdeth1,
+		      __entry->kdeth2,
+		      __entry->kdeth3,
+		      __entry->kdeth4,
+		      __entry->kdeth5,
+		      __entry->kdeth6,
+		      __entry->kdeth7,
+		      __entry->kdeth8,
+		      __entry->tidval
+	    )
+);
+
+#define USDMA_HDR16B_FORMAT \
+	"[%s:%u:%u:%u] PBC=(0x%x 0x%x) LRH=(0x%x 0x%x 0x%x 0x%x) BTH=(0x%x 0x%x 0x%x) KDETH=(0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x) TIDVal=0x%x"
+
+TRACE_EVENT(hfi2_sdma_user_header16b,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u8 subctxt, u16 req,
+		     struct hfi2_pkt_header16b *hdr, u32 tidval),
+	    TP_ARGS(dd, ctxt, subctxt, req, hdr, tidval),
+	    TP_STRUCT__entry(
+		    DD_DEV_ENTRY(dd)
+		    __field(u16, ctxt)
+		    __field(u8, subctxt)
+		    __field(u16, req)
+		    __field(u32, pbc0)
+		    __field(u32, pbc1)
+		    __field(u32, lrh0)
+		    __field(u32, lrh1)
+		    __field(u32, lrh2)
+		    __field(u32, lrh3)
+		    __field(u32, bth0)
+		    __field(u32, bth1)
+		    __field(u32, bth2)
+		    __field(u32, kdeth0)
+		    __field(u32, kdeth1)
+		    __field(u32, kdeth2)
+		    __field(u32, kdeth3)
+		    __field(u32, kdeth4)
+		    __field(u32, kdeth5)
+		    __field(u32, kdeth6)
+		    __field(u32, kdeth7)
+		    __field(u32, kdeth8)
+		    __field(u32, tidval)
+		    ),
+	    TP_fast_assign(
+		    __le32 *pbc = (__le32 *)hdr->pbc;
+		    __le32 *lrh = (__le32 *)hdr->lrh;
+		    __be32 *bth = (__be32 *)hdr->bth;
+		    __le32 *kdeth = (__le32 *)&hdr->kdeth;
+
+		    DD_DEV_ASSIGN(dd);
+		    __entry->ctxt = ctxt;
+		    __entry->subctxt = subctxt;
+		    __entry->req = req;
+		    __entry->pbc0 = le32_to_cpu(pbc[0]);
+		    __entry->pbc1 = le32_to_cpu(pbc[1]);
+		    __entry->lrh0 = le32_to_cpu(lrh[0]);
+		    __entry->lrh1 = le32_to_cpu(lrh[1]);
+		    __entry->lrh2 = le32_to_cpu(lrh[2]);
+		    __entry->lrh3 = le32_to_cpu(lrh[3]);
+		    __entry->bth0 = be32_to_cpu(bth[0]);
+		    __entry->bth1 = be32_to_cpu(bth[1]);
+		    __entry->bth2 = be32_to_cpu(bth[2]);
+		    __entry->kdeth0 = le32_to_cpu(kdeth[0]);
+		    __entry->kdeth1 = le32_to_cpu(kdeth[1]);
+		    __entry->kdeth2 = le32_to_cpu(kdeth[2]);
+		    __entry->kdeth3 = le32_to_cpu(kdeth[3]);
+		    __entry->kdeth4 = le32_to_cpu(kdeth[4]);
+		    __entry->kdeth5 = le32_to_cpu(kdeth[5]);
+		    __entry->kdeth6 = le32_to_cpu(kdeth[6]);
+		    __entry->kdeth7 = le32_to_cpu(kdeth[7]);
+		    __entry->kdeth8 = le32_to_cpu(kdeth[8]);
+		    __entry->tidval = tidval;
+		    ),
+	    TP_printk(USDMA_HDR16B_FORMAT,
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->req,
+		      __entry->pbc1,
+		      __entry->pbc0,
+		      __entry->lrh0,
+		      __entry->lrh1,
+		      __entry->lrh2,
+		      __entry->lrh3,
+		      __entry->bth0,
+		      __entry->bth1,
+		      __entry->bth2,
+		      __entry->kdeth0,
+		      __entry->kdeth1,
+		      __entry->kdeth2,
+		      __entry->kdeth3,
+		      __entry->kdeth4,
+		      __entry->kdeth5,
+		      __entry->kdeth6,
+		      __entry->kdeth7,
+		      __entry->kdeth8,
+		      __entry->tidval
+		      )
+);
+
+#define SDMA_UREQ_FMT \
+	"[%s:%u:%u] ver/op=0x%x, iovcnt=%u, meminfo=%u, npkts=%u, frag=%u, idx=%u"
+TRACE_EVENT(hfi2_sdma_user_reqinfo,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt, u16 *i),
+	    TP_ARGS(dd, ctxt, subctxt, i),
+	    TP_STRUCT__entry(
+		    DD_DEV_ENTRY(dd)
+		    __field(u16, ctxt)
+		    __field(u16, subctxt)
+		    __field(u8, ver_opcode)
+		    __field(u8, iovcnt)
+		    __field(u8, meminfo)
+		    __field(u16, npkts)
+		    __field(u16, fragsize)
+		    __field(u16, comp_idx)
+	    ),
+	    TP_fast_assign(
+		    DD_DEV_ASSIGN(dd);
+		    __entry->ctxt = ctxt;
+		    __entry->subctxt = subctxt;
+		    __entry->ver_opcode = i[0] & 0xff;
+		    __entry->iovcnt = (i[0] >> 8) & 0x7f;
+		    __entry->meminfo = (i[0] >> 15) & 0x1;
+		    __entry->npkts = i[1];
+		    __entry->fragsize = i[2];
+		    __entry->comp_idx = i[3];
+	    ),
+	    TP_printk(SDMA_UREQ_FMT,
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->ver_opcode,
+		      __entry->iovcnt,
+		      __entry->meminfo,
+		      __entry->npkts,
+		      __entry->fragsize,
+		      __entry->comp_idx
+		      )
+);
+
+#define usdma_complete_name(st) { st, #st }
+#define show_usdma_complete_state(st)			\
+	__print_symbolic(st,				\
+			usdma_complete_name(FREE),	\
+			usdma_complete_name(QUEUED),	\
+			usdma_complete_name(COMPLETE), \
+			usdma_complete_name(ERROR))
+
+TRACE_EVENT(hfi2_sdma_user_completion,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt, u16 idx,
+		     u8 state, int code),
+	    TP_ARGS(dd, ctxt, subctxt, idx, state, code),
+	    TP_STRUCT__entry(
+	    DD_DEV_ENTRY(dd)
+	    __field(u16, ctxt)
+	    __field(u16, subctxt)
+	    __field(u16, idx)
+	    __field(u8, state)
+	    __field(int, code)
+	    ),
+	    TP_fast_assign(
+	    DD_DEV_ASSIGN(dd);
+	    __entry->ctxt = ctxt;
+	    __entry->subctxt = subctxt;
+	    __entry->idx = idx;
+	    __entry->state = state;
+	    __entry->code = code;
+	    ),
+	    TP_printk("[%s:%u:%u:%u] SDMA completion state %s (%d)",
+		      __get_str(dev), __entry->ctxt, __entry->subctxt,
+		      __entry->idx, show_usdma_complete_state(__entry->state),
+		      __entry->code)
+);
+
+TRACE_EVENT(hfi2_usdma_defer,
+	    TP_PROTO(struct hfi2_user_sdma_pkt_q *pq,
+		     struct sdma_engine *sde,
+		     struct iowait *wait),
+	    TP_ARGS(pq, sde, wait),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi2_user_sdma_pkt_q *, pq)
+			     __field(struct sdma_engine *, sde)
+			     __field(struct iowait *, wait)
+			     __field(int, engine)
+			     __field(int, empty)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->sde = sde;
+			    __entry->wait = wait;
+			    __entry->engine = sde->this_idx;
+			    __entry->empty = list_empty(&__entry->wait->list);
+			    ),
+	     TP_printk("[%s] pq %llx sde %llx wait %llx engine %d empty %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       (unsigned long long)__entry->sde,
+		       (unsigned long long)__entry->wait,
+		       __entry->engine,
+		       __entry->empty
+		)
+);
+
+TRACE_EVENT(hfi2_usdma_activate,
+	    TP_PROTO(struct hfi2_user_sdma_pkt_q *pq,
+		     struct iowait *wait,
+		     int reason),
+	    TP_ARGS(pq, wait, reason),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi2_user_sdma_pkt_q *, pq)
+			     __field(struct iowait *, wait)
+			     __field(int, reason)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->wait = wait;
+			    __entry->reason = reason;
+			    ),
+	     TP_printk("[%s] pq %llx wait %llx reason %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       (unsigned long long)__entry->wait,
+		       __entry->reason
+		)
+);
+
+TRACE_EVENT(hfi2_usdma_we,
+	    TP_PROTO(struct hfi2_user_sdma_pkt_q *pq,
+		     int we_ret),
+	    TP_ARGS(pq, we_ret),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(pq->dd)
+			     __field(struct hfi2_user_sdma_pkt_q *, pq)
+			     __field(int, state)
+			     __field(int, we_ret)
+			     ),
+	     TP_fast_assign(DD_DEV_ASSIGN(pq->dd);
+			    __entry->pq = pq;
+			    __entry->state = pq->state;
+			    __entry->we_ret = we_ret;
+			    ),
+	     TP_printk("[%s] pq %llx state %d we_ret %d",
+		       __get_str(dev),
+		       (unsigned long long)__entry->pq,
+		       __entry->state,
+		       __entry->we_ret
+		)
+);
+
+const char *print_u32_array(struct trace_seq *, u32 *, int);
+#define __print_u32_hex(arr, len) print_u32_array(p, arr, len)
+
+TRACE_EVENT(hfi2_sdma_user_header_ahg,
+	    TP_PROTO(struct hfi2_devdata *dd, u16 ctxt, u16 subctxt, u16 req,
+		     u8 sde, u8 ahgidx, u32 *ahg, int len, u32 tidval),
+	    TP_ARGS(dd, ctxt, subctxt, req, sde, ahgidx, ahg, len, tidval),
+	    TP_STRUCT__entry(
+	    DD_DEV_ENTRY(dd)
+	    __field(u16, ctxt)
+	    __field(u16, subctxt)
+	    __field(u16, req)
+	    __field(u8, sde)
+	    __field(u8, idx)
+	    __field(int, len)
+	    __field(u32, tidval)
+	    __array(u32, ahg, 10)
+	    ),
+	    TP_fast_assign(
+	    DD_DEV_ASSIGN(dd);
+	    __entry->ctxt = ctxt;
+	    __entry->subctxt = subctxt;
+	    __entry->req = req;
+	    __entry->sde = sde;
+	    __entry->idx = ahgidx;
+	    __entry->len = len;
+	    __entry->tidval = tidval;
+	    memcpy(__entry->ahg, ahg, len * sizeof(u32));
+	    ),
+	    TP_printk("[%s:%u:%u:%u] (SDE%u/AHG%u) ahg[0-%d]=(%s) TIDVal=0x%x",
+		      __get_str(dev),
+		      __entry->ctxt,
+		      __entry->subctxt,
+		      __entry->req,
+		      __entry->sde,
+		      __entry->idx,
+		      __entry->len - 1,
+		      __print_u32_hex(__entry->ahg, __entry->len),
+		      __entry->tidval
+		      )
+);
+
+TRACE_EVENT(hfi2_sdma_state,
+	    TP_PROTO(struct sdma_engine *sde,
+		     const char *cstate,
+		     const char *nstate
+		     ),
+	    TP_ARGS(sde, cstate, nstate),
+	    TP_STRUCT__entry(DD_DEV_ENTRY(sde->dd)
+		__string(curstate, cstate)
+		__string(newstate, nstate)
+	        __field(u8, sde_idx)
+	    ),
+	    TP_fast_assign(DD_DEV_ASSIGN(sde->dd);
+		__assign_str(curstate);
+		__assign_str(newstate);
+		__entry->sde_idx = sde->this_idx;
+	    ),
+	    TP_printk("[%s] SDE%d state: %s -> %s",
+		      __get_str(dev),
+		      __entry->sde_idx,
+		      __get_str(curstate),
+		      __get_str(newstate)
+	    )
+);
+
+#define BCT_FORMAT \
+	"shared_limit %x vls 0-7 [%x,%x][%x,%x][%x,%x][%x,%x][%x,%x][%x,%x][%x,%x][%x,%x] 15 [%x,%x]"
+
+#define BCT(field) \
+	be16_to_cpu( \
+	((struct buffer_control *)__get_dynamic_array(bct))->field \
+	)
+
+DECLARE_EVENT_CLASS(hfi2_bct_template,
+		    TP_PROTO(struct hfi2_devdata *dd,
+			     struct buffer_control *bc),
+		    TP_ARGS(dd, bc),
+		    TP_STRUCT__entry(DD_DEV_ENTRY(dd)
+		    __dynamic_array(u8, bct, sizeof(*bc))
+		    ),
+		    TP_fast_assign(DD_DEV_ASSIGN(dd);
+				   memcpy(__get_dynamic_array(bct), bc,
+					  sizeof(*bc));
+		    ),
+		    TP_printk(BCT_FORMAT,
+			      BCT(overall_shared_limit),
+
+			      BCT(vl[0].dedicated),
+			      BCT(vl[0].shared),
+
+			      BCT(vl[1].dedicated),
+			      BCT(vl[1].shared),
+
+			      BCT(vl[2].dedicated),
+			      BCT(vl[2].shared),
+
+			      BCT(vl[3].dedicated),
+			      BCT(vl[3].shared),
+
+			      BCT(vl[4].dedicated),
+			      BCT(vl[4].shared),
+
+			      BCT(vl[5].dedicated),
+			      BCT(vl[5].shared),
+
+			      BCT(vl[6].dedicated),
+			      BCT(vl[6].shared),
+
+			      BCT(vl[7].dedicated),
+			      BCT(vl[7].shared),
+
+			      BCT(vl[15].dedicated),
+			      BCT(vl[15].shared)
+		    )
+);
+
+DEFINE_EVENT(hfi2_bct_template, bct_set,
+	     TP_PROTO(struct hfi2_devdata *dd, struct buffer_control *bc),
+	     TP_ARGS(dd, bc));
+
+DEFINE_EVENT(hfi2_bct_template, bct_get,
+	     TP_PROTO(struct hfi2_devdata *dd, struct buffer_control *bc),
+	     TP_ARGS(dd, bc));
+
+TRACE_EVENT(
+	hfi2_qp_send_completion,
+	TP_PROTO(struct rvt_qp *qp, struct rvt_swqe *wqe, u32 idx),
+	TP_ARGS(qp, wqe, idx),
+	TP_STRUCT__entry(
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(struct rvt_swqe *, wqe)
+		__field(u64, wr_id)
+		__field(u32, qpn)
+		__field(u32, qpt)
+		__field(u32, length)
+		__field(u32, idx)
+		__field(u32, ssn)
+		__field(enum ib_wr_opcode, opcode)
+		__field(int, send_flags)
+	),
+	TP_fast_assign(
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->wqe = wqe;
+		__entry->wr_id = wqe->wr.wr_id;
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->qpt = qp->ibqp.qp_type;
+		__entry->length = wqe->length;
+		__entry->idx = idx;
+		__entry->ssn = wqe->ssn;
+		__entry->opcode = wqe->wr.opcode;
+		__entry->send_flags = wqe->wr.send_flags;
+	),
+	TP_printk(
+		"[%s] qpn 0x%x qpt %u wqe %p idx %u wr_id %llx length %u ssn %u opcode %x send_flags %x",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->qpt,
+		__entry->wqe,
+		__entry->idx,
+		__entry->wr_id,
+		__entry->length,
+		__entry->ssn,
+		__entry->opcode,
+		__entry->send_flags
+	)
+);
+
+DECLARE_EVENT_CLASS(
+	hfi2_do_send_template,
+	TP_PROTO(struct rvt_qp *qp, bool flag),
+	TP_ARGS(qp, flag),
+	TP_STRUCT__entry(
+		DD_DEV_ENTRY(dd_from_ibdev(qp->ibqp.device))
+		__field(u32, qpn)
+		__field(bool, flag)
+	),
+	TP_fast_assign(
+		DD_DEV_ASSIGN(dd_from_ibdev(qp->ibqp.device));
+		__entry->qpn = qp->ibqp.qp_num;
+		__entry->flag = flag;
+	),
+	TP_printk(
+		"[%s] qpn %x flag %d",
+		__get_str(dev),
+		__entry->qpn,
+		__entry->flag
+	)
+);
+
+DEFINE_EVENT(
+	hfi2_do_send_template, hfi2_rc_do_send,
+	TP_PROTO(struct rvt_qp *qp, bool flag),
+	TP_ARGS(qp, flag)
+);
+
+DEFINE_EVENT(/* event */
+	hfi2_do_send_template, hfi2_rc_do_tid_send,
+	TP_PROTO(struct rvt_qp *qp, bool flag),
+	TP_ARGS(qp, flag)
+);
+
+DEFINE_EVENT(
+	hfi2_do_send_template, hfi2_rc_expired_time_slice,
+	TP_PROTO(struct rvt_qp *qp, bool flag),
+	TP_ARGS(qp, flag)
+);
+
+DECLARE_EVENT_CLASS(/* AIP  */
+	hfi2_ipoib_txq_template,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(txq->priv->dd)
+		__field(struct hfi2_ipoib_txq *, txq)
+		__field(struct sdma_engine *, sde)
+		__field(ulong, head)
+		__field(ulong, tail)
+		__field(uint, used)
+		__field(uint, flow)
+		__field(int, stops)
+		__field(int, no_desc)
+		__field(u8, idx)
+		__field(u8, stopped)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(txq->priv->dd);
+		__entry->txq = txq;
+		__entry->sde = txq->sde;
+		__entry->head = txq->tx_ring.head;
+		__entry->tail = txq->tx_ring.tail;
+		__entry->idx = txq->q_idx;
+		__entry->used =
+			txq->tx_ring.sent_txreqs -
+			txq->tx_ring.complete_txreqs;
+		__entry->flow = txq->flow.as_int;
+		__entry->stops = atomic_read(&txq->tx_ring.stops);
+		__entry->no_desc = atomic_read(&txq->tx_ring.no_desc);
+		__entry->stopped =
+		 __netif_subqueue_stopped(txq->priv->netdev, txq->q_idx);
+	),
+	TP_printk(/* print  */
+		"[%s] txq %llx idx %u sde %llx:%u cpu %d head %lx tail %lx flow %x used %u stops %d no_desc %d stopped %u",
+		__get_str(dev),
+		(unsigned long long)__entry->txq,
+		__entry->idx,
+		(unsigned long long)__entry->sde,
+		__entry->sde ? __entry->sde->this_idx : 0,
+		__entry->sde ? __entry->sde->cpu : 0,
+		__entry->head,
+		__entry->tail,
+		__entry->flow,
+		__entry->used,
+		__entry->stops,
+		__entry->no_desc,
+		__entry->stopped
+	)
+);
+
+DEFINE_EVENT(/* queue stop */
+	hfi2_ipoib_txq_template, hfi2_txq_stop,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* queue wake */
+	hfi2_ipoib_txq_template, hfi2_txq_wake,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* flow flush */
+	hfi2_ipoib_txq_template, hfi2_flow_flush,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* flow switch */
+	hfi2_ipoib_txq_template, hfi2_flow_switch,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* wakeup */
+	hfi2_ipoib_txq_template, hfi2_txq_wakeup,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* full */
+	hfi2_ipoib_txq_template, hfi2_txq_full,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* queued */
+	hfi2_ipoib_txq_template, hfi2_txq_queued,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* xmit_stopped */
+	hfi2_ipoib_txq_template, hfi2_txq_xmit_stopped,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* xmit_unstopped */
+	hfi2_ipoib_txq_template, hfi2_txq_xmit_unstopped,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DECLARE_EVENT_CLASS(/* AIP  */
+	hfi2_ipoib_tx_template,
+	TP_PROTO(struct ipoib_txreq *tx, u32 idx),
+	TP_ARGS(tx, idx),
+	TP_STRUCT__entry(/* entry */
+		DD_DEV_ENTRY(tx->txq->priv->dd)
+		__field(struct ipoib_txreq *, tx)
+		__field(struct hfi2_ipoib_txq *, txq)
+		__field(struct sk_buff *, skb)
+		__field(ulong, idx)
+	),
+	TP_fast_assign(/* assign */
+		DD_DEV_ASSIGN(tx->txq->priv->dd);
+		__entry->tx = tx;
+		__entry->skb = tx->skb;
+		__entry->txq = tx->txq;
+		__entry->idx = idx;
+	),
+	TP_printk(/* print  */
+		"[%s] tx %llx txq %llx,%u skb %llx idx %lu",
+		__get_str(dev),
+		(unsigned long long)__entry->tx,
+		(unsigned long long)__entry->txq,
+		__entry->txq ? __entry->txq->q_idx : 0,
+		(unsigned long long)__entry->skb,
+		__entry->idx
+	)
+);
+
+DEFINE_EVENT(/* produce */
+	hfi2_ipoib_tx_template, hfi2_tx_produce,
+	TP_PROTO(struct ipoib_txreq *tx, u32 idx),
+	TP_ARGS(tx, idx)
+);
+
+DEFINE_EVENT(/* consume */
+	hfi2_ipoib_tx_template, hfi2_tx_consume,
+	TP_PROTO(struct ipoib_txreq *tx, u32 idx),
+	TP_ARGS(tx, idx)
+);
+
+DEFINE_EVENT(/* alloc_tx */
+	hfi2_ipoib_txq_template, hfi2_txq_alloc_tx,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* poll */
+	hfi2_ipoib_txq_template, hfi2_txq_poll,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+DEFINE_EVENT(/* complete */
+	hfi2_ipoib_txq_template, hfi2_txq_complete,
+	TP_PROTO(struct hfi2_ipoib_txq *txq),
+	TP_ARGS(txq)
+);
+
+TRACE_EVENT(hfi2_sdma_pad,
+	TP_PROTO(u8 idx, u8 pkts, u16 pad, u16 pkt_descs, u16 pad_descs),
+	TP_ARGS(idx, pkts, pad, pkt_descs, pad_descs),
+	TP_STRUCT__entry(
+		__field(u8, idx)
+		__field(u8, pkts)
+		__field(u16, pad)
+		__field(u16, pkt_descs)
+		__field(u16, pad_descs)
+	),
+	TP_fast_assign(
+		__entry->idx = idx;
+		__entry->pkts = pkts;
+		__entry->pad = pad;
+		__entry->pkt_descs = pkt_descs;
+		__entry->pad_descs = pad_descs;
+	),
+	TP_printk("SDE (%u) pkts %u pad_sdma_desc %u packet descriptors %u padding descriptors %u\n",
+		  __entry->idx, __entry->pkts, __entry->pad, __entry->pkt_descs,
+		  __entry->pad_descs)
+);
+
+#endif /* __HFI2_TRACE_TX_H */
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace_tx
+#include <trace/define_trace.h>



