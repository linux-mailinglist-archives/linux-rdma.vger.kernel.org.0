Return-Path: <linux-rdma+bounces-15084-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2675CCCA10
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 17:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13E2A305130E
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517B936922A;
	Thu, 18 Dec 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bVc13rmD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC8136921D;
	Thu, 18 Dec 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073558; cv=fail; b=DZv8TuRxBvZVg4nWMjkb8AxMO0AyfjIx9s+2CMUEtxJSp4UJWotgeLVrqdmJn8w21vCPpTFRZ+vQZAyDuTywsX548DfZtyL45DADPzspeMAFht+56Gr0ygTkYLVqVETio5/wXiunROa6iTLvGzPM6n1fZwFtXP6wYuheitrz1GI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073558; c=relaxed/simple;
	bh=/Mq1NTJL/qSCLptkr3kqsqlceEcLslP0ndcGYGGSGh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bz+o0bAy+vOncKOi09BH6IW/zteZhn2aHbMsdOa5ZjeQqiG++5Rig2g7SNWo7niXOFZ1EbfPXaQorczEAoRTVMPbXe3wKkeuAkxb8dLemrV3bRQ/scgpiVnHoxZ635FvxQObvHSgzLQYpZgsbfla7BQSP1kL1zcFfOpRMUlSHcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bVc13rmD; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiTzh3c7AJovDaHkRVaA0WHRbyr8s+i3TL17CGUopiqpTwfZb5UiO1YFF+R8YNbII7VAJqUlebeSe2mjegXQBMWB2tVZX4ic9oANGJyAY5qIwSm/KzZcuxqEd0TUpgO7tDxC3kGAf2u82CctT0Va9T9lMmVcq6nRl6wXo72X7RUCYoJ3esPhBAUjTNDHG/M3+AJ/tOQkW+NqydRRCjVVYXaM16JBeLAv/Hd1+h4lcOkovbH/JxXjuJMDo14cbi+MoUYcSLW3z0v5ubIN16W97UJWDv+U51WBYYyq/5QFiHw6T0g1zCL0fSDVvvVxzDfr+kvEQipdKGwj38kxUvOSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPemRxiV5cOwGBbF36MDJzWqhmT9x9dLk9g1Uk5NUmk=;
 b=FnYOOVWBdTwF00eMe7S9izIBstsJZ6IhZTXkWIA1Ex1CBQ1Z9fhKlFmFee/lSszv3mSPM86dEZFJsEIQeROFp+BntyH3DLLz1LF/WO+70qi7C/VvR73VkHAZSftH/CQFALq2cY7hFawJ12YXyCACaVeeboPW6tdPpyPN8KDfT6FvU0pRPlkM35fyGK8/cmZKHEW4ikzAzviYYAuz6Q52hOMTy/EmkIYi8AX87i7+4DReRheWNdH5VuT5WaTm7ShD4yNEVVo/NMnxnqrLVd9Ko6Qob6hkuytLQ9cctHgsFtBdVzuOSoV77A4Xy/to5wt9Gh1vdnNT4pcbYcpJ4QX1bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPemRxiV5cOwGBbF36MDJzWqhmT9x9dLk9g1Uk5NUmk=;
 b=bVc13rmDQluLUi+6nMgu2HnIqTib3jGGjL767dNTdoM8NEYO4iIAB8v/OLkQaiqXxI2FdhFaAOHryFaPhX7F5tVl0ZsTauJMpTKRnJzVjMLEMQdNgxDAWz3Cp7cyvYeYiO0K2zdCnNMmMjqox7sOwy/NgK39ehsQMTkyKD6TkctVly4vbUYfcl9EMY0oCZULezmT+iu54DobxQa5EnWCVTC94CdxmuUxE3QdZV6cH2V/m//d6EAygZa7aOO1l2Slg7XggXFLfFUVqQbY1OdIPEu1eGjikV6c2y2jQ8CptzFvLNZ5MBjRSqrw0hs2rWmeMjBKga1KFtYRy2W90qRjwQ==
Received: from CH0PR03CA0434.namprd03.prod.outlook.com (2603:10b6:610:10e::16)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:59:12 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::81) by CH0PR03CA0434.outlook.office365.com
 (2603:10b6:610:10e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 15:58:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:59:12 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 18
 Dec 2025 07:58:47 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 08/10] IB/core: Add query_port_speed verb
Date: Thu, 18 Dec 2025 17:58:46 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-8-7d8ed4368bea@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
References: <20251218-vf-bw-lag-mode-v1-0-7d8ed4368bea@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=4955; i=edwards@nvidia.com; s=20251029; h=from:subject:message-id; bh=Kt/KrEayBQDIibnIQzfDvSmj/uPFgDGcYeFaXYm4DcY=; b=k5SswPW8VG3L88Q1SGQiD2TdsAWhpyscwEW0TuEN5nuolrw6sq6Np8NVa1B9Hic82SmerSnuH +v10OUZhjpTC54lKTF/vVA9ESwd4oDZt0F3+kVdwEIM4iNRjAWg6VOq
X-Developer-Key: i=edwards@nvidia.com; a=ed25519; pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 1760ba4f-a343-48c4-1276-08de3e4e6333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OUlIS3hOTEtPa0Y0R3lCS0dhNHdyMlFmR1YxZTMxblYxL01Za1VzTjYvdlpB?=
 =?utf-8?B?b3ZKbkxLM0wveS9TZy9XRWtjK1EvWWtwekJhN3UxN0ltMEYwOElvQ2VHZi9U?=
 =?utf-8?B?SVN6UjUramtWZ0JoRnoxeWlCanpvajU1S2VodURqa3MwWWpzVlFwYkhraFRx?=
 =?utf-8?B?R2FhYVhvOTRrNHRYVHd5U1BBdU8vVnB1MVNGUXB0WVpYeStxWk11cEluaDZu?=
 =?utf-8?B?d1Z6MlQ4UXV0T2oxaktQUG5LdVJoRGpZNXpYMVY1dnMxNTRhNnpISEZvZzhS?=
 =?utf-8?B?bXd1NDlkU3ZvVmxxZ3hHUW5WQzVGb2huZXJYTW5sOFU5TGd3SHNuakhsQ29z?=
 =?utf-8?B?RldtTStLR0ZCaXFMZGxlQjVqMWN0MDdSYk5XemNxSkowUDJXaHFhMmZVcTdK?=
 =?utf-8?B?bW9ERWw2MTgzNW10aEtZOXpRT2RJU0dLbDRVMXBKT2p2VE80VE8wTmNsNUY1?=
 =?utf-8?B?bUxxc3BWQVBmVUhLdk1nQ2REQ0MxTWI4dElxcUlIczdON2ppdTNTVGxEYWxW?=
 =?utf-8?B?d3ZrSlNEbzdzZmo2ZnVyTERzMnlRZjZaNnY0QUhJcUJGQVVQbnlmUjR2TXlF?=
 =?utf-8?B?ME1LUTNaZC93b25iTTJvLytXSmdsb0xLQ2dFYVpuS1NvWkFFTExsaUpmenp6?=
 =?utf-8?B?VTJxMEU2eHpCdEhiajMxYTVEOUdSbU1NSTFkYWxjcDdJcHNZanNMWHJ0Uk9s?=
 =?utf-8?B?cGNQOWtGcytzSWZ0NnBXN21leXBlbVZmRmRha1BzOUVLQVJieHlES0VVUk1r?=
 =?utf-8?B?NG03K0JOT2VjUGpBOW9kelNZaVFHVzVpaVhNN1ZicHk2S3lGazBNN0hYTXpQ?=
 =?utf-8?B?RlE2ckI5QkJEV3FuM0xVdFlPRnlIelpxRkowaUVFcHdoQWtURmVaSzg0S1NY?=
 =?utf-8?B?eHZzdlMzUEllOFhrT3RuWDBRV0dOaFNjeXpYZjZiTFdZRDBjNUdJbVpVY3Nq?=
 =?utf-8?B?VnBYUytybUNLY2R6MiszTHlTNThSRmRjdlp0bE4wVkg5djBaaTAyR3VzRmpl?=
 =?utf-8?B?bVk5ZzhXbGlaZS80ZWN1Y29iVGtMNnUyd0cvUUpLdmxackxoeklCd0RlaXRH?=
 =?utf-8?B?YU96dzNkOFMwd0JUUW1YaGJVYXQ2QitLOGVnWTFzd0lnL0dKNWhlcFZCUEZK?=
 =?utf-8?B?d3Z0Z0dPQWxRd2lZV3hPTGpuanJiZm5WU3YxM2NRWUo4M2QzRHU2MFIrT1Fv?=
 =?utf-8?B?TVRsVHpkOTlnNUZvaUUxWldNSTJEbngxSVZpdloxNW9lM1ZPZkhCSi9IUyt1?=
 =?utf-8?B?ckhPY0dQb2VHR09sWEdMM05CcE5hVVB4Q0ZOQjRKNDhWMjZxM2UyYjlwMC9H?=
 =?utf-8?B?R1VyTFNTNDVsNlFKdXo1YU5FRjc2bUludnRTSUU2TU1NWjUyak53RFo1SVBR?=
 =?utf-8?B?ZlJPTGZRQmZzaXZuTldJMUVPY0ZhWkxKMW5FSkx5U04yVEJWYi9TNTRnT3k1?=
 =?utf-8?B?M0hIK0JWazlXa0w3RTgwc1dZck4rMkExWGt5K1VmY1FpSjBSTnhrN1RrT2JG?=
 =?utf-8?B?anZyOHZpeGpsRWFQVi9MZk9QcE5xTUxnckhjQUlRTlE0aGY1bnN4WXJWTmhY?=
 =?utf-8?B?TnZUaFVjQ0d0UlE2cllXVmlwek4vWXNWME5sTHdqdExZcklpTjl0OTVVOVlJ?=
 =?utf-8?B?c0RmcUphQ1djbDBzTnFtSXBqVzg0M2ZsVjVXbUNWbzJsNnpXeDVyWXJqT2Rx?=
 =?utf-8?B?N0NielV5QWpBbFduTEZtS01ybEZIanM2V0FmaHBMMVFCOUdkdDhrcDN1U1Jx?=
 =?utf-8?B?WjdiVG5RTG9uSmVya3pFekhVbm1sRUJuWnZqR3NlWDB6aDgwM2FJSEgxY25m?=
 =?utf-8?B?RXIydU9uaEh0K0IvRUV6VnQxbnI4NTAxeGpTczQzeGFxWW9LR003anF5SG5R?=
 =?utf-8?B?V01PZU94OUNnT3FHclIrMXl6R3hJL3hHV2tzeGdqZWpsdGFaZG11Q0RXY1cw?=
 =?utf-8?B?TWcza012cHhVZXlBVWVMa0swQmRsbndKdTVkdzNpNEJ4di9kL01BWDE0WFZw?=
 =?utf-8?B?UXZTZzRHS0QwNFFJc0VqSkw1djdiL2xIWE5ONGhYUnk2Z0d0RHVBb2lvRGVZ?=
 =?utf-8?B?M094Q0pZQUxEQXZuTWp4WWV5RGl5VUlSSlY5ajkxZ3g3UitrNE5UMTZNdzha?=
 =?utf-8?Q?3/h3In3+Wt4oDo0FqEr9jYT3O?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:59:12.4392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1760ba4f-a343-48c4-1276-08de3e4e6333
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

From: Or Har-Toov <ohartoov@nvidia.com>

Add new ibv_query_port_speed() verb to enable applications to query
the effective bandwidth of a port.

This verb is particularly useful when the speed is not a multiplication
of IB speed and width where width is 2^n.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/device.c                  |  1 +
 drivers/infiniband/core/uverbs_std_types_device.c | 42 +++++++++++++++++++++++
 include/rdma/ib_verbs.h                           |  2 ++
 include/uapi/rdma/ib_user_ioctl_cmds.h            |  6 ++++
 4 files changed, 51 insertions(+)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 13e8a1714bbd..04edc57592aa 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2816,6 +2816,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
 	SET_DEVICE_OP(dev_ops, query_gid);
 	SET_DEVICE_OP(dev_ops, query_pkey);
 	SET_DEVICE_OP(dev_ops, query_port);
+	SET_DEVICE_OP(dev_ops, query_port_speed);
 	SET_DEVICE_OP(dev_ops, query_qp);
 	SET_DEVICE_OP(dev_ops, query_srq);
 	SET_DEVICE_OP(dev_ops, query_ucontext);
diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
index c0fd283d9d6c..a28f9f21bed8 100644
--- a/drivers/infiniband/core/uverbs_std_types_device.c
+++ b/drivers/infiniband/core/uverbs_std_types_device.c
@@ -209,6 +209,39 @@ static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_PORT)(
 					     &resp, sizeof(resp));
 }
 
+static int UVERBS_HANDLER(UVERBS_METHOD_QUERY_PORT_SPEED)(
+	struct uverbs_attr_bundle *attrs)
+{
+	struct ib_ucontext *ucontext;
+	struct ib_device *ib_dev;
+	u32 port_num;
+	u64 speed;
+	int ret;
+
+	ucontext = ib_uverbs_get_ucontext(attrs);
+	if (IS_ERR(ucontext))
+		return PTR_ERR(ucontext);
+	ib_dev = ucontext->device;
+
+	if (!ib_dev->ops.query_port_speed)
+		return -EOPNOTSUPP;
+
+	ret = uverbs_get_const(&port_num, attrs,
+			       UVERBS_ATTR_QUERY_PORT_SPEED_PORT_NUM);
+	if (ret)
+		return ret;
+
+	if (!rdma_is_port_valid(ib_dev, port_num))
+		return -EINVAL;
+
+	ret = ib_dev->ops.query_port_speed(ib_dev, port_num, &speed);
+	if (ret)
+		return ret;
+
+	return uverbs_copy_to(attrs, UVERBS_ATTR_QUERY_PORT_SPEED_RESP,
+			      &speed, sizeof(speed));
+}
+
 static int UVERBS_HANDLER(UVERBS_METHOD_GET_CONTEXT)(
 	struct uverbs_attr_bundle *attrs)
 {
@@ -469,6 +502,14 @@ DECLARE_UVERBS_NAMED_METHOD(
 				   active_speed_ex),
 		UA_MANDATORY));
 
+DECLARE_UVERBS_NAMED_METHOD(
+	UVERBS_METHOD_QUERY_PORT_SPEED,
+	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_QUERY_PORT_SPEED_PORT_NUM, u32,
+			     UA_MANDATORY),
+	UVERBS_ATTR_PTR_OUT(UVERBS_ATTR_QUERY_PORT_SPEED_RESP,
+			    UVERBS_ATTR_TYPE(u64),
+			    UA_MANDATORY));
+
 DECLARE_UVERBS_NAMED_METHOD(
 	UVERBS_METHOD_QUERY_GID_TABLE,
 	UVERBS_ATTR_CONST_IN(UVERBS_ATTR_QUERY_GID_TABLE_ENTRY_SIZE, u64,
@@ -498,6 +539,7 @@ DECLARE_UVERBS_GLOBAL_METHODS(UVERBS_OBJECT_DEVICE,
 			      &UVERBS_METHOD(UVERBS_METHOD_INVOKE_WRITE),
 			      &UVERBS_METHOD(UVERBS_METHOD_INFO_HANDLES),
 			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_PORT),
+			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_PORT_SPEED),
 			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_CONTEXT),
 			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_GID_TABLE),
 			      &UVERBS_METHOD(UVERBS_METHOD_QUERY_GID_ENTRY));
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index b984f9581a73..a4786395328a 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2418,6 +2418,8 @@ struct ib_device_ops {
 						     int comp_vector);
 	int (*query_port)(struct ib_device *device, u32 port_num,
 			  struct ib_port_attr *port_attr);
+	int (*query_port_speed)(struct ib_device *device, u32 port_num,
+				u64 *speed);
 	int (*modify_port)(struct ib_device *device, u32 port_num,
 			   int port_modify_mask,
 			   struct ib_port_modify *port_modify);
diff --git a/include/uapi/rdma/ib_user_ioctl_cmds.h b/include/uapi/rdma/ib_user_ioctl_cmds.h
index de6f5a94f1e3..35da4026f452 100644
--- a/include/uapi/rdma/ib_user_ioctl_cmds.h
+++ b/include/uapi/rdma/ib_user_ioctl_cmds.h
@@ -73,6 +73,7 @@ enum uverbs_methods_device {
 	UVERBS_METHOD_QUERY_CONTEXT,
 	UVERBS_METHOD_QUERY_GID_TABLE,
 	UVERBS_METHOD_QUERY_GID_ENTRY,
+	UVERBS_METHOD_QUERY_PORT_SPEED,
 };
 
 enum uverbs_attrs_invoke_write_cmd_attr_ids {
@@ -86,6 +87,11 @@ enum uverbs_attrs_query_port_cmd_attr_ids {
 	UVERBS_ATTR_QUERY_PORT_RESP,
 };
 
+enum uverbs_attrs_query_port_speed_cmd_attr_ids {
+	UVERBS_ATTR_QUERY_PORT_SPEED_PORT_NUM,
+	UVERBS_ATTR_QUERY_PORT_SPEED_RESP,
+};
+
 enum uverbs_attrs_get_context_attr_ids {
 	UVERBS_ATTR_GET_CONTEXT_NUM_COMP_VECTORS,
 	UVERBS_ATTR_GET_CONTEXT_CORE_SUPPORT,

-- 
2.47.1


