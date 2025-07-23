Return-Path: <linux-rdma+bounces-12434-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C8FB0F925
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 19:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2566717DCB5
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD0233714;
	Wed, 23 Jul 2025 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="is9dHh14"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C58E2222AB;
	Wed, 23 Jul 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291953; cv=fail; b=Gz7SpEYxBbOQnVT4OLtF8WCjEcxDwhrxxR8KVHBINuhOdOmLClKteTevMdl0gEJW/RjiYe5xBuJm4D/jKsH1iDB+GUgxOdGHrmFNDvMWCseZV2fRHdswBlSZlVuctHZT+yO3W1N3nwj4smxCNE60Pe+xrKYz66Te1AqXeDVVFd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291953; c=relaxed/simple;
	bh=ovIz5ZJWELMPuRotgiHEq2cTsMFaEZPfb1dNsC7ONN0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeDPjEurso/uUV4tsYkA3SnRlEcyNvXBnm7KrRmdLy+XhRBPKJ2JQuJx9TIEv+65TBsU6uYkqy1w2rgQH+8SxrHyuEeXlnS24/qOy4s5F0MHqEc+kzt2FQnryCX0jzd9jY6UZBR/lyy47ftv3QSTIrdz4VPy9T6fx7vx+KETg60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=is9dHh14; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WwfYHGzZQW6cNZ2uwOVJ6ZRJsJM7TrxCs4M3aqKNiFN9zhWuEE7KwT9D+q2cxutz+ZwQD+3Is12Q6gkwS6jo5G+u7erBI+J50WmfgRknHKY+zL/aJPHcMCEDpeyuEKdoQSY4wlQzVR4pnqyKDXdGqx1yf6IkNML2YKQeZwB9sOQAohlBOiADRqGW99YbvbNnxPCbueastj08BkMJVT2IrjLnb/dW6vjXGvr9VoUoNY86SqnLIcbV18iD6qB6o6IYVDhfk2j1ilQ7swvxlrlZYeDY1G6CUYXTfrUdu3vSeq8wHRQZfk8AEFKMo1mTfl89R9TdmcSgvMoFby0qTXIauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HZyEFckxjOPPXEcvEo1wm2yiVAqhy7ar9AmpBjAbc=;
 b=XeehRw+3YuTO+Q3cjpcQL6Cki+eLLHtPHx5gQB2aBFH2JbzklxPIZL6f/aT83VTe7mKvnQYwptts4fOzoFMLfUtTMvDL3fsqvTyujx7IJBojV3QQ1IJbtb/7bWWCKkTqtnF41q7nx8wVIzojvAauhtidGhEP5SoBsmUz9v6ztNi99ZwLnn+7vXGyx10NaO+oFRdX+Ytr6aYdm2t3VQq0DRXvvjejVHFBPmnXMYS1snLeohTAvF1ku4Pqu+hNMEodKK/hqnkcQXS2e8DSxzsFLK7Yt4OVA4pJAYdKeSU781ri+24klgusE6oEoH1aLN2ddsXwL2p0cP0xU5LRDGKwXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HZyEFckxjOPPXEcvEo1wm2yiVAqhy7ar9AmpBjAbc=;
 b=is9dHh14wRN70ObW3lE66B7uAzXQS7BgRzsdJlzyzJ1QF6plvHk+YQZCtXxdnuBnWQwT14rJp9ryGHH9uMMUHmSnUYTtNtpzS2F2h1f6nkaOZmpvT6USKOXOY17b1q8VAel64Sh0SUcRsze8TkGSpHRyXSACr7LltVXTCXNH52o=
Received: from CH2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:610:51::20)
 by BL3PR12MB9049.namprd12.prod.outlook.com (2603:10b6:208:3b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 17:32:25 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::23) by CH2PR15CA0010.outlook.office365.com
 (2603:10b6:610:51::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Wed,
 23 Jul 2025 17:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 17:32:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:17 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Jul
 2025 12:32:17 -0500
Received: from xhdabhijitg41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 23 Jul 2025 12:32:12 -0500
From: Abhijit Gangurde <abhijit.gangurde@amd.com>
To: <shannon.nelson@amd.com>, <brett.creeley@amd.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<corbet@lwn.net>, <jgg@ziepe.ca>, <leon@kernel.org>, <andrew+netdev@lunn.ch>
CC: <allen.hubbe@amd.com>, <nikhil.agarwal@amd.com>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>
Subject: [PATCH v4 04/14] net: ionic: Provide RDMA reset support for the RDMA driver
Date: Wed, 23 Jul 2025 23:01:39 +0530
Message-ID: <20250723173149.2568776-5-abhijit.gangurde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
References: <20250723173149.2568776-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: abhijit.gangurde@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|BL3PR12MB9049:EE_
X-MS-Office365-Filtering-Correlation-Id: e9333e61-d419-441a-53fe-08ddca0ee347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5U7gKdWomKL66MUegvVgYyhWiF0mroyEMblGTjMLwFtz1aaOw4LHJZ+1uvkY?=
 =?us-ascii?Q?l3Hgrc9xxMYXNYttaBSMB/63Q3EblBJWVA1P/vOBZ+WlKMavQWjXmZ7eEx7p?=
 =?us-ascii?Q?yoOuRkGOZj9eyv3oTc3ZBz1SPwsoKU6rdJYrI8C9bI3B8aMi3kjd5mnBTpGQ?=
 =?us-ascii?Q?+c2/rYm5sKujtMUwZj9Gr/mG87EW7JygCIsBAnyigDX8STeW+ni1eFxiU7Fl?=
 =?us-ascii?Q?ssGzseUI7mx8FOrGAY08DZs1C5tI+h0mFZQHey80AzvB3mT5a4MQUwatHnmq?=
 =?us-ascii?Q?IgJtiWsL4hfaBHRzbsLUPC1PxyRBPueR8F8atcffxpb2busSrMkV3lR4BcrU?=
 =?us-ascii?Q?SZsp8cPB6ZDeER9MV4mX+4+rMJxUx8Q04VZYFGNpWEIifKjN6y99KYrduAoS?=
 =?us-ascii?Q?pDHSLaQBkgmJcTBr17UKFB7LLsjmQvc4ArZWFKfDV9Ucqdi0AESwbj9MEPC7?=
 =?us-ascii?Q?buIjB+aTu6T2Whi587OCNijFlXo5bLM4DbMyjvngh/VPigyHdc+Vxb8cWENI?=
 =?us-ascii?Q?/pziltwpVoUJJ/V9IQULM6Z1qsFefWF7MOHx0N6HZKNZ/toXNTQge5h0M/5C?=
 =?us-ascii?Q?CSJLdSSOdLapNt/x8gctQ6FPWy4Mjdc/Hy+bvfKT0RgGp77eeV1vptj7mYP7?=
 =?us-ascii?Q?wdbWU59P30Xh/CHad15Kr2Oi9U28YGbh1BrVGiNilPmx0jyMGYiDf6JTwCxb?=
 =?us-ascii?Q?b340WzT108YwQsZt/NIZPXE7nz+1ECxCie/JSgpaGggNcAvzMQ/VS4dt4Lhh?=
 =?us-ascii?Q?E6700ZJAlw0o41rpTwWhPvGgWP6OX9Gzeesobcqstmqetsmw3hwr1Ga8B40L?=
 =?us-ascii?Q?9KOCO8Pm7+05Bt+fCTZotlSsfENvbe1NoiVXjF14SWK4mYj5W7MXtpItApJ5?=
 =?us-ascii?Q?xeJW6gWA9YF4Ky3bD1dt2I3dPil9QPTEmnv614iTMaVHcg+b3ohGL0HLgfz/?=
 =?us-ascii?Q?1GFbC7n6nhrBKEhMCkpllH51V01Zs67aMnFN+jGuM50Yrp+oDVX7Y+ln6tqu?=
 =?us-ascii?Q?yV+tYys7bQv4qrTyqKqOWw1Doy4Z1atAGXqiDq/xoyj641kPwlz24M1B2GEo?=
 =?us-ascii?Q?PVRbYcQsLkz41hOb6t6hi8ssY9X3ADWadC93auEF+Zq/gRUjaCGuJd3QirLL?=
 =?us-ascii?Q?Qa4P+e27QMa1AQkAZl4GeZZNxmbONKOXK1AHRQVQzpOWaPTYr/o5vg/KJcT9?=
 =?us-ascii?Q?B6AK4XWQfDFLWsYXEpXtkmE7k1oEsqTgjeziBVqGaCFsz3WZTy7dislE3RJ0?=
 =?us-ascii?Q?VsR2Xq9qS21Ywb5FZFDI3yDCbaEIK0AYHNblAj1de9pL4q+HLHJo52i9qtv3?=
 =?us-ascii?Q?vG0pBA7gfjuTdfWZXfaOeK9sDC5xBknG7adtnYNYD5bb52R1NhnDWca1LzZ6?=
 =?us-ascii?Q?7vYORkpEOlBeiu9IZdzwNt3xKIwuL4b30sLQlO6CEOZQQXn7YBbFa933RWHm?=
 =?us-ascii?Q?OA6jDBZ7u3b4ellzFVoe01Vk5Jp0M0kDQGjAMFaaQIoujUas9IwcjMdwMOkU?=
 =?us-ascii?Q?nMfO9KEn5tesNsO5V6fkHcmDilPgcfUl8qUArGe8/NM8/ViYXfbNrMlJtA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 17:32:24.7298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9333e61-d419-441a-53fe-08ddca0ee347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9049

The Ethernet driver holds the privilege to execute the device commands.
Export the function to execute RDMA reset command for use by RDMA driver.

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_api.h   |  9 ++++++++
 .../net/ethernet/pensando/ionic/ionic_aux.c   | 22 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_api.h b/drivers/net/ethernet/pensando/ionic/ionic_api.h
index d75902ca34af..e0b766d1769f 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_api.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_api.h
@@ -54,4 +54,13 @@ int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
  */
 int ionic_error_to_errno(enum ionic_status_code code);
 
+/**
+ * ionic_request_rdma_reset - request reset or disable the device or lif
+ * @lif:        Logical interface
+ *
+ * The reset is triggered asynchronously. It will wait until reset request
+ * completes or times out.
+ */
+void ionic_request_rdma_reset(struct ionic_lif *lif);
+
 #endif /* _IONIC_API_H_ */
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_aux.c b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
index 781218c3feba..6cd4c718836c 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_aux.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_aux.c
@@ -93,3 +93,25 @@ void ionic_auxbus_unregister(struct ionic_lif *lif)
 out:
 	mutex_unlock(&lif->adev_lock);
 }
+
+void ionic_request_rdma_reset(struct ionic_lif *lif)
+{
+	struct ionic *ionic = lif->ionic;
+	int err;
+
+	union ionic_dev_cmd cmd = {
+		.cmd.opcode = IONIC_CMD_RDMA_RESET_LIF,
+		.cmd.lif_index = cpu_to_le16(lif->index),
+	};
+
+	mutex_lock(&ionic->dev_cmd_lock);
+
+	ionic_dev_cmd_go(&ionic->idev, &cmd);
+	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
+
+	mutex_unlock(&ionic->dev_cmd_lock);
+
+	if (err)
+		pr_warn("%s request_reset: error %d\n", __func__, err);
+}
+EXPORT_SYMBOL_NS(ionic_request_rdma_reset, "NET_IONIC");
-- 
2.43.0


