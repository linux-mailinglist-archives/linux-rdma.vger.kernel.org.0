Return-Path: <linux-rdma+bounces-18001-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EkAKrmssWmzEQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18001-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E2926853A
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B557306CC36
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 17:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3783E63A2;
	Wed, 11 Mar 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b="NX6ORVrm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020124.outbound.protection.outlook.com [52.101.61.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA343AE6EE
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251730; cv=fail; b=nl8mFRfEcC3wSvJQyPQM98gaapQa+JvupsBS2sAOzcooP2TlN3YcX3dDp1x1yyfpnRg2gLqbRYwIXcB5rWvLWXXrJHKVm5DXwyUNskwcCU4vxG7+z1y/5cHsCvDsGjd1CdQDPUjRTKT6q+l5QHWaEIuVSkeMYinaYhfvrxzMwwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251730; c=relaxed/simple;
	bh=/czsdy9aD0jb7nnwzfDyRg3Y4SkonrXnWMZSgbNbbag=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THW02kvGWd/G8Sa7oHf1QBuTjlKadrHB1ee2YXGcMMU+ybjGcgIZw2Oo2ofufEWa22Vf839UTHDfaY9ululOl7Rhh88EJ7XyMPJOs6rz6q4X+97qEG1EJE8dAbLrjvzoIpW/xYmT6hZuNMI84FtM8btkwL1WRyf2u0D1WhihfCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com; spf=pass smtp.mailfrom=cornelisnetworks.com; dkim=pass (2048-bit key) header.d=cornelisnetworks.com header.i=@cornelisnetworks.com header.b=NX6ORVrm; arc=fail smtp.client-ip=52.101.61.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cornelisnetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cornelisnetworks.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWxS5BWuZocqKx87HIOOVjMNVoFjwsK/Xye+Jy9QHjrUM6GnQuNepvSqVbblTDNnVdRhHcDU5KzbVX1vmt0PY0oeoZKJfVT55FwHd5KxV0QzYjkbyAzkKBhAuFilamla3DshM4I/RTRWFBps5AQcbF5rTc3J9U3lyMf6xg9K1TLyUl43ETbpDgPOYJ/Xv3BvRkrnYlzyvoTI/T1WyNbTs74XtxU5Fn5k8Vt8TnUXu2D0DFqPcrga8SYVRjJzskyWc/tsN5pD3Sv+63+uR4zag0jejyWXP0oSU6ciNOdYpgkioaQYoUG0M/30xUpFPKTSn/wtlrDhYL4jxbQGGO4qmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19chMB8d+FTN82NiiAauEb1AAUXZ8Mr23LgNSX/9pm0=;
 b=enQPgskQU19ymiBd7Yfoz6CV/e3CS5+i/9PrOXiIP325FNUH5KbA/pbVZCirjlOwt+ElmhgVTWn55PsvYfa4Cu6K+mBCtpD6LFMXh9tdG5yIHnCdx9gkTrKA9SkB8fIUyc8s/Y20Zi0Wyxf6jh++FXNa2VKPDkrNETUq195oAhLv88oxWeXz+Cd2LT1QmhA7hXc2jGlzQbXLMLdrZPCB7ckyd7amM9S6Vk3jWQLpBLFGPDNoXUV3CZg236Ae/Gnx0bRXln55smRj0ml3niqSUfuSsHDUAOe0mpFXx8VpeoNvxNNPQHiRVNfBMI9PnkPpUwgsZW0sgaXIyi10BVSW/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 208.255.156.42) smtp.rcpttodomain=cornelisnetworks.com
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass (p=none sp=none pct=100)
 action=none header.from=cornelisnetworks.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19chMB8d+FTN82NiiAauEb1AAUXZ8Mr23LgNSX/9pm0=;
 b=NX6ORVrmg9jB4vufgLx7/1QEx6XtHfljxmHsdSIlf8Qdtys1cf8Q4o+AOZeOlk96qMb+6UvUu7kFnS3wSShP38HnAIN9LLlZKM5tnck7q/2Zm6XtqDfM0Guyn0nQN/S1r7Tqvkbj0K0ViluLMGIbwkOhCjx/i20yObFcqyl2b9/6D/GL0JFeyqJXsYkHKHsLnhvtSkiIPYsbZ8mUTWRAblvdTxp7jHn59UVX1mLC35IjKJgUYumCOu80QbwANnUCZBacsV2wMDrnXLzGQVf5agXUBbz6NiasVP007K90I0nnV9i5OXaTRJ5/aGQnaMXsqMLQKIlLIk4Y+qMbLAbCtA==
Received: from PH7P220CA0164.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::7)
 by SJ2PR01MB7981.prod.exchangelabs.com (2603:10b6:a03:4c3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.13; Wed, 11 Mar 2026 17:55:11 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::7d) by PH7P220CA0164.outlook.office365.com
 (2603:10b6:510:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.26 via Frontend Transport; Wed,
 11 Mar 2026 17:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 208.255.156.42)
 smtp.mailfrom=cornelisnetworks.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=cornelisnetworks.com;
Received-SPF: Pass (protection.outlook.com: domain of cornelisnetworks.com
 designates 208.255.156.42 as permitted sender)
 receiver=protection.outlook.com; client-ip=208.255.156.42;
 helo=cn-mailer-00.localdomain; pr=C
Received: from cn-mailer-00.localdomain (208.255.156.42) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18
 via Frontend Transport; Wed, 11 Mar 2026 17:55:11 +0000
Received: from awdrv-04.localdomain (awdrv-04.cornelisnetworks.com [10.228.212.218])
	by cn-mailer-00.localdomain (Postfix) with ESMTPS id 428E014D817;
	Wed, 11 Mar 2026 13:55:11 -0400 (EDT)
Received: from awdrv-04.cornelisnetworks.com (localhost [IPv6:::1])
	by awdrv-04.localdomain (Postfix) with ESMTP id 3D7131810D6C5;
	Wed, 11 Mar 2026 13:55:11 -0400 (EDT)
Subject: [PATCH for-next resend 17/24] RDMA/hfi2: Add verbs core
From: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
To: jgg@ziepe.ca, leon@kernel.org
Cc: Dean Luick <dean.luick@cornelisnetworks.com>,
 Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>,
 Douglas Miller <doug.miller@cornelisnetworks.com>, linux-rdma@vger.kernel.org
Date: Wed, 11 Mar 2026 13:55:11 -0400
Message-ID:
 <177325171121.57064.17156467298936818564.stgit@awdrv-04.cornelisnetworks.com>
In-Reply-To:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
References:
 <177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ2PR01MB7981:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d5346f-5ee5-4452-05f9-08de7f97579d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|34020700016|36860700016|376014|55112099003|7142099003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+ABJRd3pvo0kgYWsh6+P8C00wuXrXPIInsABwCifJ0A7L4LoFhd8BShHghXLuIzfU3Wg15cmH0CLuGIFyw4uKkPKMKUQirfPrxpM0kHONedhuuMAGy7EczMwfF5FKPmt2VMLx2y3gBsFwpRjTez36rXzClYakwMWgagMWb44U6f34LQiP3ZwjEZR/SHpeNHQw3sCjhPcQn5UQd+qz4Jr8BIKDUwZS2pd9hXCgt5blB3726wH6mOgeLOfHzQJCjLC/eHd1A127AvSvlBKqNKU5GHjFaJBSs7c0UauHH4AWogH2L/0CeinX8ptCB75JVXD23ndAphgrecBtf6Xlwxcw5NbjVkWFub3ABQ7wfD/g5JnHmabagc+3o6aN4TZbqDKAI0YMM3OH5glCI/IWu4oRQgRRMO+1X5FuQ+T2JXj9BraSlP8fC7mmExUg80Uc8/h3vNoMhWjJZD+6EcBzUSuu1BMhWqVqmqyDfPUPcIZalHQUJhRW/UlvfLMVz9xjC5R0dVTgK6xRHvERhSV/pRQRSeObhIKklJnbQY8ggB2y9OORdR4xZm4kAiBDZb8LUbNbkEJh4f5clpLISeopBvnpRXpvYNaDJG8aZmBpWIGAnWV+3T7pVkPZ6bT0f5tC3Bh+z0k9sLPrCz+NUe92M0D93zkHjQxl2MnxwrEggKwBt8pcWJcIUXgq3M20oVpGF6Xv6Wb6kG86CkgrCjHxeKi0pS3XDVW1be0fqo63BMpr4iWqYZYe8YPKieWUaMMEWa2d28nw75Pp6FnV46IADRJjg==
X-Forefront-Antispam-Report:
	CIP:208.255.156.42;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:cn-mailer-00.localdomain;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(34020700016)(36860700016)(376014)(55112099003)(7142099003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZxWSs4d6ThGLvtpargmj5L2OPXT6tODHcZIDlCoThJTLn6IsYg04LBIpPQIG/sXlk7IBGLMl0eFyc2wAnmGqfGAqqXTvH/pGXcCNDxOYMLwpsAbaUXoLDbisN5EA/RFYg286sekeOXzJNRgUCERXxrILef2hGCKDu73JQbyaEfh4M86V5KtUufnb3EXtvV3EUQoB/t7ZYUzHNZMKrc9mHoNwvT6F1L20G2MY+ar8wcNp5+fClhH0fPWF5SThCn+16GQkxtvQqajywATrGEEAXBMJrf98fSTTih1wXngDm7sQPPkxAusimf2h7q1lfGgOCd2vfSxbvg6wdFiTz8sMbWPceSqbnScZ2kDAIfX5DgrKnhEy0ZP09ynVCdtZKq9+V5xnmpUGVQlafbXE7fyT/lYly5GqpUJsRoNpkY3hyOM+dx/YfpI/OSgjhgJNAigD
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:55:11.8163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d5346f-5ee5-4452-05f9-08de7f97579d
X-MS-Exchange-CrossTenant-Id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a;Ip=[208.255.156.42];Helo=[cn-mailer-00.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB7981
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cornelisnetworks.com,none];
	R_DKIM_ALLOW(-0.20)[cornelisnetworks.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18001-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cornelisnetworks.com:dkim,cornelisnetworks.com:email,awdrv-04.cornelisnetworks.com:mid,ps.dev:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[cornelisnetworks.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[dennis.dalessandro@cornelisnetworks.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 81E2926853A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the core verbs implementation including queue pair management,
reliable/unreliable connected and datagram send paths, and the
OPFN protocol extension.

Co-developed-by: Dean Luick <dean.luick@cornelisnetworks.com>
Signed-off-by: Dean Luick <dean.luick@cornelisnetworks.com>
Co-developed-by: Bendan Cunningham <brendan.cunningham@cornelisnetworks.com>
Signed-off-by: Breandan Cunningham <brendan.cunningham@cornelisnetworks.com>
Co-developed-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Douglas Miller <doug.miller@cornelisnetworks.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
---
 drivers/infiniband/hw/hfi2/opfn.c        |  324 +++++
 drivers/infiniband/hw/hfi2/qp.c          | 1105 ++++++++++++++++
 drivers/infiniband/hw/hfi2/ruc.c         |  622 +++++++++
 drivers/infiniband/hw/hfi2/uc.c          |  543 ++++++++
 drivers/infiniband/hw/hfi2/ud.c          | 1037 +++++++++++++++
 drivers/infiniband/hw/hfi2/verbs.c       | 2106 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/hfi2/verbs_txreq.c |  101 +
 7 files changed, 5838 insertions(+)
 create mode 100644 drivers/infiniband/hw/hfi2/opfn.c
 create mode 100644 drivers/infiniband/hw/hfi2/qp.c
 create mode 100644 drivers/infiniband/hw/hfi2/ruc.c
 create mode 100644 drivers/infiniband/hw/hfi2/uc.c
 create mode 100644 drivers/infiniband/hw/hfi2/ud.c
 create mode 100644 drivers/infiniband/hw/hfi2/verbs.c
 create mode 100644 drivers/infiniband/hw/hfi2/verbs_txreq.c

diff --git a/drivers/infiniband/hw/hfi2/opfn.c b/drivers/infiniband/hw/hfi2/opfn.c
new file mode 100644
index 000000000000..068bb2209e66
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/opfn.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright(c) 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+	opfn_wq = alloc_workqueue("hfi_opfn",
+				  WQ_SYSFS | WQ_HIGHPRI | WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM |
+				  WQ_PERCPU,
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
index 000000000000..550c1a1dd770
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/qp.c
@@ -0,0 +1,1105 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+module_param_named(qp_table_size, hfi2_qp_table_size, uint, 0444);
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
+		if (!hfi2_qp_to_sdma_engine(qp, sc) &&
+		    dd->flags & HFI2_HAS_SEND_DMA)
+			return -EINVAL;
+
+		if (!hfi2_qp_to_send_context(qp, sc))
+			return -EINVAL;
+	}
+
+	if (attr_mask & IB_QP_ALT_PATH) {
+		sc = ah_to_sc(ibqp->device, &attr->alt_ah_attr);
+		if (sc == 0xf)
+			return -EINVAL;
+
+		if (!hfi2_qp_to_sdma_engine(qp, sc) &&
+		    dd->flags & HFI2_HAS_SEND_DMA)
+			return -EINVAL;
+
+		if (!hfi2_qp_to_send_context(qp, sc))
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
+		priv->s_sde = hfi2_qp_to_sdma_engine(qp, priv->s_sc);
+		priv->s_sendcontext = hfi2_qp_to_send_context(qp, priv->s_sc);
+		qp_set_16b(qp);
+	}
+
+	if (attr_mask & IB_QP_PATH_MIG_STATE &&
+	    attr->path_mig_state == IB_MIG_MIGRATED &&
+	    qp->s_mig_state == IB_MIG_ARMED) {
+		qp->s_flags |= HFI2_S_AHG_CLEAR;
+		priv->s_sc = ah_to_sc(ibqp->device, &qp->remote_ah_attr);
+		priv->s_sde = hfi2_qp_to_sdma_engine(qp, priv->s_sc);
+		priv->s_sendcontext = hfi2_qp_to_send_context(qp, priv->s_sc);
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
+		 * Return a unique error so the caller can identify the
+		 * unqueued case.
+		 */
+		ret = -EIO;
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
+ * hfi2_qp_to_sdma_engine - map a qp to a send engine
+ * @qp: the QP
+ * @sc5: the 5 bit sc
+ *
+ * Return:
+ * A send engine for the qp or NULL for SMI type qp.
+ */
+struct sdma_engine *hfi2_qp_to_sdma_engine(struct rvt_qp *qp, u8 sc5)
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
+ * hfi2_qp_to_send_context - map a qp to a send context
+ * @qp: the QP
+ * @sc5: the 5 bit sc
+ *
+ * Return:
+ * A send context for the qp
+ */
+struct send_context *hfi2_qp_to_send_context(struct rvt_qp *qp, u8 sc5)
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
+ * hfi2_qp_iter_print - print the qp information to seq_file
+ * @s: the seq_file to emit the qp information on
+ * @iter: the iterator for the qp hash list
+ */
+void hfi2_qp_iter_print(struct seq_file *s, struct rvt_qp_iter *iter)
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
+	sde = hfi2_qp_to_sdma_engine(qp, priv->s_sc);
+	wqe = rvt_get_swqe_ptr(qp, qp->s_last);
+	send_context = hfi2_qp_to_send_context(qp, priv->s_sc);
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
+void *hfi2_qp_priv_alloc(struct rvt_dev_info *rdi, struct rvt_qp *qp)
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
+void hfi2_qp_priv_free(struct rvt_dev_info *rdi, struct rvt_qp *qp)
+{
+	struct hfi2_qp_priv *priv = qp->priv;
+
+	hfi2_qp_priv_tid_free(rdi, qp);
+	kfree(priv->s_ahg);
+	kfree(priv);
+}
+
+unsigned int free_all_qps(struct rvt_dev_info *rdi)
+{
+	struct hfi2_ibdev *verbs_dev = container_of(rdi,
+						    struct hfi2_ibdev,
+						    rdi);
+	struct hfi2_devdata *dd = container_of(verbs_dev,
+					       struct hfi2_devdata,
+					       verbs_dev);
+	int n;
+	unsigned int qp_inuse = 0;
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
+/* this is a duplicate of sw/rdmavt/qp.c */
+static void get_map_page(struct rvt_qpn_table *qpt,
+			 struct rvt_qpn_map *map)
+{
+	unsigned long page = get_zeroed_page(GFP_KERNEL);
+
+	/* Free the page if someone raced with us installing it. */
+
+	spin_lock(&qpt->lock);
+	if (map->page)
+		free_page(page);
+	else
+		map->page = (void *)page;
+	spin_unlock(&qpt->lock);
+}
+
+/*
+ * Ensure the context number part of QPN remains within bounds of
+ * recv contexts assigned to this unit. This context number has no
+ * relationship to how the QPN is used, it is only to differentiate
+ * "ours" vs. "theirs" for QPNs associated with the same physical
+ * adapter port (SLID == DLID).
+ */
+static u32 fixup_qpn(u32 qpn, struct rvt_qpn_table *qpt, struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u32 qpm = dd->rctxt_mask << 1;
+	u32 qpi = dd->rctxt_mask + 1; /* incrementer for context part */
+
+	if (((qpn & qpm) >> 1) >= dr->c.last_rcv_context) {
+		qpn = (qpn & ~qpm) + ((qpi | dr->c.first_rcv_context) << 1);
+		/* wrap at end of current maps or end of number space */
+		if (qpn / RVT_BITS_PER_PAGE >= qpt->nmaps || qpn >= RVT_QPN_MAX)
+			qpn = (dr->c.first_rcv_context << 1) | ((qpn & 1) ^ 1);
+	}
+	if (qpn == qpt->last) {
+		/* one full pass completed */
+		qpn = RVT_QPN_MAX;
+	}
+	return qpn;
+}
+
+static u32 next_qpn(u32 qpn, struct rvt_qpn_table *qpt, struct hfi2_devdata *dd)
+{
+	return fixup_qpn(qpn + qpt->incr, qpt, dd);
+}
+
+static u32 first_qpn(struct rvt_qpn_table *qpt, struct hfi2_devdata *dd)
+{
+	return next_qpn(qpt->last, qpt, dd);
+}
+
+static u32 new_map_qpn(struct rvt_qpn_table *qpt, struct hfi2_devdata *dd)
+{
+	struct hfi2_devrsrcs *dr = &dd->rsrcs;
+	u32 qpn;
+
+	if (qpt->nmaps == RVT_QPNMAP_ENTRIES)
+		return RVT_QPN_MAX;
+	qpn = qpt->nmaps++ * RVT_BITS_PER_PAGE +
+		(dr->c.first_rcv_context << 1) +
+		(qpt->last & 1);
+	return qpn;
+}
+
+/*
+ * use only qpn[8:1] that fall inside our context number range,
+ * to avoid conflicts with other VFs or PF0.
+ *
+ * cloned from sw/rdmavt/qp.c
+ */
+int sriov_alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
+		    enum ib_qp_type type, u32 port_num)
+{
+	struct hfi2_ibdev *ibdev = dev_from_rdi(rdi);
+	struct hfi2_devdata *dd = dd_from_dev(ibdev);
+	u32 offset, qpn;
+	struct rvt_qpn_map *map;
+	u32 ret;
+
+	/* Must not be using QoS... ? also qpt->incr == 2? */
+	if (rdi->dparms.qos_shift != 1) {
+		ret = -EINVAL;
+		goto bail;
+	}
+
+	/* These are the same no matter what */
+	if (type == IB_QPT_SMI || type == IB_QPT_GSI) {
+		unsigned int n;
+
+		ret = type == IB_QPT_GSI;
+		n = 1 << (ret + 2 * (port_num - 1));
+		spin_lock(&qpt->lock);
+		if (qpt->flags & n)
+			ret = -EINVAL;
+		else
+			qpt->flags |= n;
+		spin_unlock(&qpt->lock);
+		goto bail;
+	}
+
+	/*
+	 * qpn[8:1] will always match a valid ctxt number for the SI.
+	 * This does not mean bits [8:1] indicate the receiving ctxt,
+	 * it only avoids conflicts with other SIs and allows
+	 * easier setup of RcvQPMapTable CSRs.
+	 */
+	qpn = first_qpn(qpt, dd);
+	/*
+	 * First, scan existing maps once (qpt->last..(qpt->nmaps)..qpt->last).
+	 * If none found, allocate a new map - which is guaranteed
+	 * to have freespace. If RVT_QPNMAP_ENTRIES is reached then fail.
+	 */
+	for (;;) {
+		if (unlikely(qpn >= RVT_QPN_MAX)) {
+			qpn = new_map_qpn(qpt, dd);
+			if (unlikely(qpn >= RVT_QPN_MAX))
+				goto nomem;
+		}
+		offset = qpn & RVT_BITS_PER_PAGE_MASK;
+		map = &qpt->map[qpn / RVT_BITS_PER_PAGE];
+		if (unlikely(!map->page)) {
+			get_map_page(qpt, map);
+			if (unlikely(!map->page))
+				goto nomem;
+		}
+		if (!test_and_set_bit(offset, map->page)) {
+			qpt->last = qpn;
+			ret = qpn;
+			goto bail;
+		}
+		qpn = next_qpn(qpn, qpt, dd);
+	}
+nomem:
+	ret = -ENOMEM;
+bail:
+	return ret;
+}
+
+
+/*
+ * This determines QPN validity for use with 'ppd' based on sriov_alloc_qpn(),
+ * specifically the algorithm of fixup_qpn().
+ */
+int hfi2_valid_qp(struct hfi2_pportdata *ppd, u32 qpn)
+{
+	struct hfi2_devrsrcs *dr = &ppd->dd->rsrcs;
+	u32 qpm = ppd->dd->rctxt_mask << 1;
+	u16 ctxt;
+
+	if (!ppd->dd->is_sriov)
+		return 1;
+	ctxt = (qpn & qpm) >> 1;
+	return (ctxt >= dr->c.first_rcv_context && ctxt < dr->c.last_rcv_context);
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
+	priv->s_sde = hfi2_qp_to_sdma_engine(qp, priv->s_sc);
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
diff --git a/drivers/infiniband/hw/hfi2/ruc.c b/drivers/infiniband/hw/hfi2/ruc.c
new file mode 100644
index 000000000000..78fd4b83b7a1
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ruc.c
@@ -0,0 +1,622 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
+ */
+
+#include <linux/spinlock.h>
+
+#include "hfi2.h"
+#include "mad.h"
+#include "qp.h"
+#include "verbs_txreq.h"
+#include "chip_gen.h"
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
+	ps.loopback = false;
+
+	trace_hfi2_rc_do_send(qp, in_thread);
+
+	switch (qp->ibqp.qp_type) {
+	case IB_QPT_RC:
+		if (!loopback && ((rdma_ah_get_dlid(&qp->remote_ah_attr) &
+				   ~((1 << ps.ppd->lmc) - 1)) ==
+				  ps.ppd->lid)) {
+			if (hfi2_valid_qp(ps.ppd, qp->remote_qpn)) {
+				rvt_ruc_loopback(qp);
+				return;
+			}
+			if (ps.ppd->dd->params->chip_type == CHIP_JKR) {
+				/*
+				 * recv context to receive from more than one port.
+				 */
+				ppd_dev_warn_ratelimited(ps.ppd, "VF-VF RC send not supported on same port\n");
+				rvt_send_complete(qp, rvt_get_swqe_ptr(qp, qp->s_last),
+						  IB_WC_RETRY_EXC_ERR);
+				return;
+			}
+			ps.loopback = true;
+		}
+		make_req = hfi2_make_rc_req;
+		ps.timeout_int = qp->timeout_jiffies;
+		break;
+	case IB_QPT_UC:
+		if (!loopback && ((rdma_ah_get_dlid(&qp->remote_ah_attr) &
+				   ~((1 << ps.ppd->lmc) - 1)) ==
+				  ps.ppd->lid)) {
+			if (hfi2_valid_qp(ps.ppd, qp->remote_qpn)) {
+				rvt_ruc_loopback(qp);
+				return;
+			}
+			if (ps.ppd->dd->params->chip_type == CHIP_JKR) {
+				/*
+				 * recv context to receive from more than one port.
+				 */
+				ppd_dev_warn_ratelimited(ps.ppd, "VF-VF UC send not supported on same port\n");
+				rvt_send_complete(qp, rvt_get_swqe_ptr(qp, qp->s_last),
+						  IB_WC_RETRY_EXC_ERR);
+				return;
+			}
+			ps.loopback = true;
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
diff --git a/drivers/infiniband/hw/hfi2/uc.c b/drivers/infiniband/hw/hfi2/uc.c
new file mode 100644
index 000000000000..c781adb6b9d4
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/uc.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
index 000000000000..fda0ec317e42
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/ud.c
@@ -0,0 +1,1037 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2019 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+	priv->s_sde = hfi2_qp_to_sdma_engine(qp, priv->s_sc);
+	ps->s_txreq->sde = priv->s_sde;
+	priv->s_sendcontext = hfi2_qp_to_send_context(qp, priv->s_sc);
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
+	unsigned int i;
+
+	if (pkey == FULL_MGMT_P_KEY || pkey == LIM_MGMT_P_KEY) {
+		unsigned int lim_idx = -1;
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
+	struct send_context *ctxt = hfi2_qp_to_send_context(qp, sc5);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+	u32 nwords;
+
+	/* should only be called for WFR, creat_pbc ignores loopback param */
+	WARN_ON(dd->params->chip_type != CHIP_WFR);
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
+		pbc = dd->params->create_pbc(ppd, false, 0, qp->srate_mbps, vl, plen,
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
+	struct send_context *ctxt = hfi2_qp_to_send_context(qp, sc5);
+	struct hfi2_pportdata *ppd = ppd_from_ibp(ibp);
+	struct hfi2_devdata *dd = ppd->dd;
+
+	/* should only be called for WFR, creat_pbc ignores loopback param */
+	WARN_ON(dd->params->chip_type != CHIP_WFR);
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
+		pbc = dd->params->create_pbc(ppd, false, pbc_flags, qp->srate_mbps, vl,
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
+		wc.pkey_index = (unsigned int)mgmt_pkey_idx;
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
diff --git a/drivers/infiniband/hw/hfi2/verbs.c b/drivers/infiniband/hw/hfi2/verbs.c
new file mode 100644
index 000000000000..01f6658d140f
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/verbs.c
@@ -0,0 +1,2106 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2015 - 2020 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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
+#include "trace.h"
+#include "qp.h"
+#include "verbs_txreq.h"
+#include "debugfs.h"
+#include "fault.h"
+#include "affinity.h"
+#include "ipoib.h"
+#include "uverbs.h"
+#include "sriov.h"
+#include "chip_gen.h"
+
+extern int sriov_alloc_qpn(struct rvt_dev_info *rdi, struct rvt_qpn_table *qpt,
+			   enum ib_qp_type type, u32 port_num);
+
+static unsigned int hfi2_lkey_table_size = 16;
+module_param_named(lkey_table_size, hfi2_lkey_table_size, uint,
+		   S_IRUGO);
+MODULE_PARM_DESC(lkey_table_size,
+		 "LKEY table size in bits (2^n, 1 <= n <= 23)");
+
+static unsigned int hfi2_max_pds = 0xFFFF;
+module_param_named(max_pds, hfi2_max_pds, uint, 0444);
+MODULE_PARM_DESC(max_pds,
+		 "Maximum number of protection domains to support");
+
+static unsigned int hfi2_max_ahs = 0xFFFF;
+module_param_named(max_ahs, hfi2_max_ahs, uint, 0444);
+MODULE_PARM_DESC(max_ahs, "Maximum number of address handles to support");
+
+unsigned int hfi2_max_cqes = 0x2FFFFF;
+module_param_named(max_cqes, hfi2_max_cqes, uint, 0444);
+MODULE_PARM_DESC(max_cqes,
+		 "Maximum number of completion queue entries to support");
+
+unsigned int hfi2_max_cqs = 0x1FFFF;
+module_param_named(max_cqs, hfi2_max_cqs, uint, 0444);
+MODULE_PARM_DESC(max_cqs, "Maximum number of completion queues to support");
+
+unsigned int hfi2_max_qp_wrs = 0x3FFF;
+module_param_named(max_qp_wrs, hfi2_max_qp_wrs, uint, 0444);
+MODULE_PARM_DESC(max_qp_wrs, "Maximum number of QP WRs to support");
+
+unsigned int hfi2_max_qps = 32768;
+module_param_named(max_qps, hfi2_max_qps, uint, 0444);
+MODULE_PARM_DESC(max_qps, "Maximum number of QPs to support");
+
+unsigned int hfi2_max_sges = 0x60;
+module_param_named(max_sges, hfi2_max_sges, uint, 0444);
+MODULE_PARM_DESC(max_sges, "Maximum number of SGEs to support");
+
+unsigned int hfi2_max_mcast_grps = 16384;
+module_param_named(max_mcast_grps, hfi2_max_mcast_grps, uint, 0444);
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
+module_param_named(max_srqs, hfi2_max_srqs, uint, 0444);
+MODULE_PARM_DESC(max_srqs, "Maximum number of SRQs to support");
+
+unsigned int hfi2_max_srq_sges = 128;
+module_param_named(max_srq_sges, hfi2_max_srq_sges, uint, 0444);
+MODULE_PARM_DESC(max_srq_sges, "Maximum number of SRQ SGEs to support");
+
+unsigned int hfi2_max_srq_wrs = 0x1FFFF;
+module_param_named(max_srq_wrs, hfi2_max_srq_wrs, uint, 0444);
+MODULE_PARM_DESC(max_srq_wrs, "Maximum number of SRQ WRs support");
+
+unsigned short piothreshold = 256;
+module_param(piothreshold, ushort, 0444);
+MODULE_PARM_DESC(piothreshold, "size used to determine sdma vs. pio");
+
+static unsigned int sge_copy_mode;
+module_param(sge_copy_mode, uint, 0444);
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
+module_param(wss_threshold, uint, 0444);
+MODULE_PARM_DESC(wss_threshold, "Percentage (1-100) of LLC to use as a threshold for a cacheless copy");
+static uint wss_clean_period = 256;
+module_param(wss_clean_period, uint, 0444);
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
+	struct hfi2_ibdev *dev = timer_container_of(dev, t, mem_timer);
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
+	enum ib_wc_status ib_status = status == SDMA_TXREQ_S_OK ?
+					IB_WC_SUCCESS : IB_WC_GENERAL_ERR;
+
+	spin_lock(&qp->s_lock);
+	if (tx->wqe) {
+		rvt_send_complete(qp, tx->wqe, ib_status);
+	} else if (qp->ibqp.qp_type == IB_QPT_RC) {
+		struct hfi2_opa_header *hdr;
+
+		hdr = &tx->phdr.hdr;
+		if (unlikely(status != SDMA_TXREQ_S_OK))
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
+			pbc = dd->params->create_pbc(ppd, ps->loopback, pbc, qp->srate_mbps,
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
+		if (unlikely(ret)) {
+			/*
+			 * Drop this transmit with an error.  Expect that
+			 * whatever caused the build error will occur again,
+			 * so do not attempt to retry.  If a retry is attempted,
+			 * then tx would need to be cleaned first - tx may not
+			 * be fully constructed.  tx will be cleaned when
+			 * deallocated.
+			 */
+			verbs_sdma_complete(&tx->txreq, SDMA_TXREQ_S_SENDERROR);
+			/* return 0 so the next transmit is attempted */
+			ret = 0;
+			goto bail_build;
+		}
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
+		 * An unexpected error has occurred.  Complete the tx with an
+		 * error.  The complete will remove the reference.  A call to
+		 * sdma_txclean() will occur when the structure is deallocated.
+		 *
+		 * Return 0 so the next transmit is attempted.
+		 */
+		tx->txreq.complete(&tx->txreq, SDMA_TXREQ_S_SENDERROR);
+		ret = 0;
+	}
+bail_build:
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
+static void hfi2_verbs_complete_tx(struct rvt_qp *qp,
+				   struct hfi2_pkt_state *ps,
+				   int wc_status)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&qp->s_lock, flags);
+	if (qp->s_wqe) {
+		rvt_send_complete(qp, qp->s_wqe, wc_status);
+	} else if (qp->ibqp.qp_type == IB_QPT_RC) {
+		if (unlikely(wc_status != IB_WC_SUCCESS))
+			hfi2_rc_verbs_aborted(qp, &ps->s_txreq->phdr.hdr);
+		hfi2_rc_send_complete(qp, &ps->s_txreq->phdr.hdr);
+	}
+	spin_unlock_irqrestore(&qp->s_lock, flags);
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
+		pbc = dd->params->create_pbc(ppd, ps->loopback, pbc, qp->srate_mbps,
+					     vl, plen, l2, dlid,
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
+			hfi2_cdbg(PIO, "alloc failed with error, completing");
+			wc_status = IB_WC_GENERAL_ERR;
+			goto pio_bail;
+		}
+
+		/*
+		 * This is a normal occurrence. The PIO buffers are all busy.
+		 * Queue the tx request.
+		 */
+		ret = pio_wait(qp, sc, ps, RVT_S_WAIT_PIO);
+		if (ret == 0) {
+			/* not able to queue - complete tx with an error */
+			wc_status = IB_WC_GENERAL_ERR;
+			hfi2_cdbg(PIO, "alloc failed, unable to queue, completing");
+			goto pio_bail;
+		}
+		/* tx is queued - return an error to stop processing */
+		hfi2_cdbg(PIO, "alloc failed, queued");
+		goto bail;
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
+	hfi2_verbs_complete_tx(qp, ps, wc_status);
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
+		if (ret == 0) {
+			/* not able to queue - complete tx with an error */
+			hfi2_verbs_complete_tx(qp, ps, IB_WC_GENERAL_ERR);
+		}
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
+	if (!dd->cport) {
+		rdi->dparms.props.fw_ver = ((u64)(dc8051_ver_maj(ver)) << 32) |
+			((u64)(dc8051_ver_min(ver)) << 16) |
+			(u64)dc8051_ver_patch(ver);
+	} else {
+		rdi->dparms.props.fw_ver = dd->cport_ver;
+	}
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
+	unsigned int i;
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
+/* ib_device_ops->get_dev_fw_str for wfr */
+static void dc8051_get_dev_fw_str(struct ib_device *ibdev, char *str)
+{
+	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
+	struct hfi2_ibdev *dev = dev_from_rdi(rdi);
+	u32 ver = dd_from_dev(dev)->dc8051_ver;
+
+	snprintf(str, IB_FW_VERSION_NAME_MAX, "%u.%u.%u", dc8051_ver_maj(ver),
+		 dc8051_ver_min(ver), dc8051_ver_patch(ver));
+}
+
+/*
+ * CPORT FW has defined the following mapping for WHO->VERSION_PATCH[4:7]
+ * aka quality field
+ */
+static const char * const cport_ver_qlt_to_str_map[] = {
+	"P0", "P1", "P2",			/* 0-2: PowerOn[0-2] */
+	"A0", "A1", "A2",			/* 3-5: Alpha[0-2]   */
+	"B0", "B1", "B2",			/* 6-8: Beta[0-2]    */
+	"RC0", "RC1", "RC2", "RC3", "RC4"	/* 9-13: RC[0-4]     */
+	/* 14: use patch field */
+	/* 15: Reserved */
+};
+
+/* ib_device_ops->get_dev_fw_str for jkr and beyond */
+void cport_get_dev_fw_str(struct ib_device *ibdev, char *str)
+{
+	struct rvt_dev_info *rdi = ib_to_rvt(ibdev);
+	struct hfi2_ibdev *dev = dev_from_rdi(rdi);
+	union cport_fw_ver ver;
+
+	ver.vers = dd_from_dev(dev)->cport_ver;
+	/* Does quality map to a special substring or do we just use patch */
+	if (ver.qlt < ARRAY_SIZE(cport_ver_qlt_to_str_map) && ver.vers != 0)
+		snprintf(str, IB_FW_VERSION_NAME_MAX, "%u.%u.%u.%s.%u",
+			 ver.maj, ver.min, ver.mnt,
+			 cport_ver_qlt_to_str_map[ver.qlt],
+			 ver.bld);
+	else
+		snprintf(str, IB_FW_VERSION_NAME_MAX, "%u.%u.%u.%u.%u",
+			 ver.maj, ver.min, ver.mnt, ver.pat, ver.bld);
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
+int num_driver_cntrs = ARRAY_SIZE(driver_cntr_names);
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
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+
+	return rdma_alloc_hw_stats_struct(dd->dev_cntr_descs,
+					  dd->num_dev_cntrs + num_driver_cntrs,
+					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
+}
+
+static struct rdma_hw_stats *hfi_alloc_hw_port_stats(struct ib_device *ibdev,
+						     u32 port_num)
+{
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+
+	return rdma_alloc_hw_stats_struct(dd->port_cntr_descs, dd->num_port_cntrs,
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
+	struct hfi2_devdata *dd = dd_from_ibdev(ibdev);
+	u64 *values;
+	int count;
+
+	if (!port) {
+		u64 *stats = (u64 *)&hfi2_stats;
+		int i;
+
+		hfi2_read_cntrs(dd, NULL, &values);
+		values[dd->num_dev_cntrs] = hfi2_sps_ints();
+		for (i = 1; i < num_driver_cntrs; i++)
+			values[dd->num_dev_cntrs + i] = stats[i];
+		count = dd->num_dev_cntrs + num_driver_cntrs;
+	} else {
+		struct hfi2_ibport *ibp = to_iport(ibdev, port);
+
+		hfi2_read_portcntrs(ppd_from_ibp(ibp), NULL, &values);
+		count = dd->num_port_cntrs;
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
+	.alloc_hw_port_stats = hfi_alloc_hw_port_stats,
+	.device_group = &ib_hfi2_attr_group,
+	.get_dev_fw_str = dc8051_get_dev_fw_str,
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
+	.alloc_hw_device_stats = hfi2_alloc_hw_device_stats,
+	.alloc_hw_port_stats = hfi_alloc_hw_port_stats,
+	.device_group = &ib_hfi2_attr_group,
+	.get_dev_fw_str = cport_get_dev_fw_str,
+	.get_hw_stats = get_hw_stats,
+	.modify_device = modify_device,
+	.port_groups = cport_attr_port_groups,
+	/* keep process mad in the driver */
+	.process_mad = cport_process_mad,
+	.rdma_netdev_get_params = hfi2_ipoib_rn_get_params,
+	.write_iter = hfi2_uverbs_write_iter,
+};
+
+static const struct ib_device_ops vf_dev_ops = {
+	.owner = THIS_MODULE,
+	.driver_id = RDMA_DRIVER_HFI2,
+
+	.alloc_hw_device_stats = hfi2_alloc_hw_device_stats,
+	.alloc_hw_port_stats = hfi_alloc_hw_port_stats,
+	.device_group = &ib_hfi2_attr_group,
+	.get_dev_fw_str = cport_get_dev_fw_str,
+	.get_hw_stats = get_hw_stats,
+	.modify_device = modify_device,
+	.port_groups = cport_attr_port_groups,
+	/* keep process mad in the driver */
+	.process_mad = vf_process_mad,
+	.rdma_netdev_get_params = hfi2_ipoib_rn_get_params,
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
+	ret = init_cntr_names(dd->cntrnames, dd->cntrnameslen,
+			      num_driver_cntrs,
+			      &dd->num_dev_cntrs, &dd->dev_cntr_descs);
+	if (ret)
+		goto err_cntr_descs;
+	for (i = 0; i < num_driver_cntrs; i++)
+		dd->dev_cntr_descs[dd->num_dev_cntrs + i].name = driver_cntr_names[i];
+	ret = init_cntr_names(dd->portcntrnames, dd->portcntrnameslen, 0,
+			      &dd->num_port_cntrs, &dd->port_cntr_descs);
+	if (ret)
+		goto err_cntr_descs;
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
+	else if (dd->is_vf)
+		ib_set_device_ops(ibdev, &vf_dev_ops);
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
+	if (dd->is_sriov) {
+		dd->verbs_dev.rdi.driver_f.alloc_qpn = sriov_alloc_qpn;
+		dd->verbs_dev.rdi.dparms.qpn_start = (dd->rsrcs.c.first_rcv_context << 1) -
+			(1 << max_qos_shift);
+	}
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
+err_cntr_descs:
+	kfree(dd->port_cntr_descs);
+	kfree(dd->dev_cntr_descs);
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
+	kfree(dd->dev_cntr_descs);
+	kfree(dd->port_cntr_descs);
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
index 000000000000..372c86d48b04
--- /dev/null
+++ b/drivers/infiniband/hw/hfi2/verbs_txreq.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright(c) 2016 - 2018 Intel Corporation.
+ * Copyright(c) 2025-2026 Cornelis Networks, Inc.
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



