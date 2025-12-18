Return-Path: <linux-rdma+bounces-15083-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA94CCD5BC
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 20:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6195930AE819
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Dec 2025 19:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73A368268;
	Thu, 18 Dec 2025 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s2qVdXGx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013048.outbound.protection.outlook.com [40.93.196.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546F366DC9;
	Thu, 18 Dec 2025 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073551; cv=fail; b=RlPA0uz5KOuvNBCX4n1xkAhdYGsXlMd+JyPeQfMprQuVhTqYZ5fW7+fE5KWI1ShBFDnvewmXonxF3Q+g9fE9ppLLnHwxDzDkn6mZd9kzitykJmnjkjUEFn0Snt+3e81/mnUfiUBKnWDqCMcSdw1uTIFaDMvbEYa51kjEoImokkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073551; c=relaxed/simple;
	bh=MooRrCGBum3rdYEKgE7fBj8PnYOLuA48G2V/bBnNVyk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0gZgze4Vp3MFKf+lTK5nGvARFiROAY1Osy/lVJ1O3urW+EMQW6eKjito7X85yCqAjFmNH9B/Oomcqd0wF4yeFiSBKR25LbTi5gRgCMbUgf41NKL3/G6Pf6zk9oxNTizjsVN5QQuxFEkPzZl/6T+81wivyvN/7zCOWjmrZMkGD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s2qVdXGx; arc=fail smtp.client-ip=40.93.196.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxIQJFcU7rnHxXFkOrjGqN55bsUln8gk04pzsqH28fO+jHmDYUMQkHwPzqDiyoBUri9uxSlxJJ0ZkESvvjZvvLv1/DOPIDGrD+FSfv08GvyaikStfUiNXMJ7tlob06uNQf9vlGJfeyo7Mc7o1r7pov5qZ39hP63ur2n3YcpnO49aegHFQyk2M0ZmPA0MkvJloEWewsZh8Wa2CR4KXMZrmOIgF9uxQaT7+of1opdVdRrqMnKb4tjlffB8UNFm1/OJZ5ZG2LmE58gN2IZfc9z3gWyaIJXLys4ojMWomyHvGX9FZcZtSVak1hOLzudaSNyn01tfO2eLi+DTE2JOKDe70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duBAtK1C686SYXOWLeTUxJY/Ogrb2oDL46cXZtXqCo4=;
 b=rRYXxVzJbf4JbaahHzLU1peh2n5u+Q9DxJ0BfqP3vBKcfix1yCsaWcouU/BaVi0mnwHFnF7qLc34euTiHmU9XMElnpguMm/S8IMAJ0OtzcjtTrZia6GY2JrMtQSUnDUAK/QagWDBOrt643gqHibt82NCY0zvucoHcT2A6xgst/uOCuN1s7EQG9jp/6sTnftpoMA1/oy1c2Uhf+EFiOdn4oHVkTMDfByymR8w+5wBS+nAL0MdXT4QhJ0aLhyWynXfBn78cikpZ2IgnUigMYK0IbBFsbBvPtiCmFGu/OfD2STNZRWKdPqFHo0puegkP5p3DwsuRlXs+EEFepJJ18ZtSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duBAtK1C686SYXOWLeTUxJY/Ogrb2oDL46cXZtXqCo4=;
 b=s2qVdXGxIV5+KXk9aOsJNslGprx9R94A6AhdaJK4zNgLmmya4NcVI4+xVelvy8C5wn1rs5ptu0NizR/PyYZjKk7pIaQDEQk5IeWWjJ0zNtgFIfzivTo5VanmOw8L9yMFHHgPrGz+LZD/QR7bTreXSs+ugpEgIUy0Up9U+ee4dc9d+7BOkM1XqBdzVxE4D5zUfpraveFe4dnnVf7KLH3/yTH+xs7HrguYrxMxSx0oeGuXkb8CtNbbF5DiGAM+W2CB6Xap0FNoSRHz0ePqQ15sCBwnv+oZWoLrLWxxpRVdxMJcnvjVv6O25rtkJ7eMg1EAOCxOSaIkh2h6jW2wdcKSoA==
Received: from CH0PR04CA0111.namprd04.prod.outlook.com (2603:10b6:610:75::26)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 15:59:03 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::54) by CH0PR04CA0111.outlook.office365.com
 (2603:10b6:610:75::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Thu,
 18 Dec 2025 15:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Thu, 18 Dec 2025 15:59:01 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:38 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 18 Dec
 2025 07:58:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 18
 Dec 2025 07:58:33 -0800
From: Edward Srouji <edwards@nvidia.com>
To: <edwards@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [PATCH rdma-next 06/10] IB/core: Add helper to convert port attributes to data rate
Date: Thu, 18 Dec 2025 17:58:32 +0200
Message-ID: <20251218-vf-bw-lag-mode-v1-6-7d8ed4368bea@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766069544; l=3311; i=edwards@nvidia.com; s=20251029; h=from:subject:message-id; bh=1KbwFRkFYU9DgsLWpVgIh9uLuiiwUdy6L5df/5FOubw=; b=4CRs3w/IVJo48ZV4dhv3+tKwEZqg4sRwepa0iP9u4S/8EXoQ7NZI3kEGuzf1g8VZ5bacLgfyE i2Sku33BNovDSeXbdnGfGOie1G9V8VD6K3s9ZYgcHhV69NI7xM1hDb3
X-Developer-Key: i=edwards@nvidia.com; a=ed25519; pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 34948929-1e71-4cdb-2c42-08de3e4e5c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejd3dUZpQVB1aXFpSDhKK2hwU0JsT3l3SGV1UktFQ1NQSU9pSi9YTTkvcEIz?=
 =?utf-8?B?K3I5UnJSTmUvb01EcXBsZUR0Uk83a3YwYThuY0tpb3Z3MSsrcmZhVWc1TEFx?=
 =?utf-8?B?U01ZRFozc3BxdjVybzJVRkhQQTJleWcxNTdhcWN0RFVaYit0d3RibHl4RUk0?=
 =?utf-8?B?ZVBUcjBTNU9jMjM4R1R0a2QyTnEzVjdKVmhCd1VIc2hGbldlNGxkYVV6N284?=
 =?utf-8?B?S0tFbEhOVmFLWUJUQURmdy82TUZDQU5tYnhnMHJrYVlNMWFDOVNBeS9FYkZ5?=
 =?utf-8?B?RWNOZ09oNW5EMjJxZXNIbnNIWFFHRHZLY3J1bVAwQUE4aHFKV0RqZ0M2Nkg5?=
 =?utf-8?B?eFB6MGx0UWNCSzhkQUg4K2dKVzVhdHRKUjducUpjNCtTcTN6U3czZjRtRWR3?=
 =?utf-8?B?T3RnaW5lby9VRFZDQTlONHY1S2Fzc3RmOG5FbHlFRmtZUzB1NW50UFlEbjFm?=
 =?utf-8?B?UWFVdnVGdHM3YWpUSDFrSlhTLzdlcmdNSEtHNkZDSWExT1ZHVUxQU0R1S0tI?=
 =?utf-8?B?ZjNYdTNrL3dLUWVPVmJFZVlRZkFOMzl1WGdwZ2JKM2s1OWhiR3RKS2NqMnh5?=
 =?utf-8?B?S3lPZGN3Y2w3TXpGS2ROdTBIa04yazFEcmxnNmdZZ0VqK2Q2NC9YUmJSY3Uw?=
 =?utf-8?B?WmVmSlVhK09PN1RLZFVFUVEvZFlzTHFkSWNUbVNCVkFKMW1XTUVDMER6VExz?=
 =?utf-8?B?MS91QStYeFk5eDQxa3hyL1YwdkNSa0FIemFDNXZhVll6SmJMQ3I1eXAvUXg1?=
 =?utf-8?B?Vko5UEJkMUt3YnAvNGUzUURheEExTmJOb2tuaDlERmpjYnM5Z0I1Q0VkNlBZ?=
 =?utf-8?B?NG5BSnFIdHZvN0VSaEVEeXcwc1FHYzFDNnBYSm9hMDRzR2VMZlByM1MwVWpu?=
 =?utf-8?B?ZUdXYjRIS0JLMjFoUjhza2JrcWtEVDhmVHFzVk4wdXZVTDlFakJSSkNXbFp0?=
 =?utf-8?B?T1JLVHVvWS9zN0E5SWh5YWxtSFpRYm94bFFyRXdRejd6STgvQ3M0Z0x4V0hY?=
 =?utf-8?B?Zjdzc2tGaDd6OEJOZGFJeVM2eDRBc1d3ZkpTeldaQ0xUbExZZHg2ZURTMXZv?=
 =?utf-8?B?c09SVHlGUjgwVU10cEZLR0tkUXRDWlVUZjFCWkMrOUxKZ1pFU3VMTjdWbm5z?=
 =?utf-8?B?OU1qVVcyRXRWcDU0cFNhK1J6YjVwcEdqZXMwOWw4eVBNaG5FZTJaa0hIdWNC?=
 =?utf-8?B?dFowRlNUYkFpRVhCMjJXallJL3hzY0VlaTc0QWZKeXFwV0Nnc3V1Z0YvaUFj?=
 =?utf-8?B?RTdtR1FTQlR4VXZXcnNuY0hSd0NNWDA4T0NDYlA3L2V0NTV1TlFPMC9lTStW?=
 =?utf-8?B?MGpVWXdrbnZyZUN3cjU0aXdLOWt4SGV6bHRCbk82T3lEMiszTXoxZ3p6ZnV4?=
 =?utf-8?B?cVY0ZTNoZHRRbEJhRExhZnQzV3preUVFejdPVisxM1ByemQzejc5ZGZSQWhP?=
 =?utf-8?B?QTh1enBBSkN5S0FTZjdOb3FhdFB0WmZFTm51WXEwT1p0akxWeE1xcXRqTFpU?=
 =?utf-8?B?UVd4NHYwZTV3ekl2a1piOG1tak9RUHhLajdkU1hLNmVNdGpmb2NJL0JKZ01Q?=
 =?utf-8?B?ZEtGQmhRMDB2ek45T3JrWXFuTUc4M2VCOWJqd1FTcFhjaGpKeDhjN20zZFNU?=
 =?utf-8?B?aVV1QlROTStGMjBCUUVxY3NBS0N5KzNwcXQzb2Jqc3lSUzJRUEhvMC9SMTNh?=
 =?utf-8?B?RGRhSEhYTjk3UU5JVDd5Yi9DL01QbDI1ZTBCbWpDeFU0VmhpR3g5OHYyVFJi?=
 =?utf-8?B?RElxZFFHYVE1U0cwdzV6NFpRQVpEdVh6SW9nQjJiZFp5QXZvUHlmbzVwWGxi?=
 =?utf-8?B?VFRHTVRSQWxiSmNqenh0dHQzb3ErMzNWUVZ2UnVpODIxdi9rYm1uRlh1QlBy?=
 =?utf-8?B?QS9WcldkSWJGZHlPYllFOEZCdzNDTk9aYUhJSDhRL1FMRE9na2Q3dHdHbUNz?=
 =?utf-8?B?bkRFR0pTSDBMRGN0c0xVWDNJOTlvalJHVEhUVmcyYk81N1orZVhYd3FGTWk2?=
 =?utf-8?B?dk44K1NTUzlteUJNOFJOUjNCK05HUHBkZlRXR09WYTVwcitHbnN4UisyMU1n?=
 =?utf-8?B?MmFSVDU3YktrNG5lNzczMDJKc1ArTnFsUEtiQXN6WkJSMllneEkxa2JqaUcz?=
 =?utf-8?Q?iFh0gJfOsN1Kxsv/ia8j/wu8r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:59:01.1899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34948929-1e71-4cdb-2c42-08de3e4e5c7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968

From: Or Har-Toov <ohartoov@nvidia.com>

Introduce ib_port_attr_to_rate() to compute the data rate in 100 Mbps
units (deci-Gb/sec) from a port's active_speed and active_width
attributes. This generic helper removes duplicated speed-to-rate
calculations, which are used by sysfs and the upcoming new verb.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/verbs.c | 51 +++++++++++++++++++++++++++++++++++++++++
 include/rdma/ib_verbs.h         | 14 +++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index f495a2182c84..8b56b6b62352 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -217,6 +217,57 @@ __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate)
 }
 EXPORT_SYMBOL(ib_rate_to_mbps);
 
+struct ib_speed_attr {
+	const char *str;
+	int speed;
+};
+
+#define IB_SPEED_ATTR(speed_type, _str, _speed) \
+	[speed_type] = {.str = _str, .speed = _speed}
+
+static const struct ib_speed_attr ib_speed_attrs[] = {
+	IB_SPEED_ATTR(IB_SPEED_SDR, " SDR", 25),
+	IB_SPEED_ATTR(IB_SPEED_DDR, " DDR", 50),
+	IB_SPEED_ATTR(IB_SPEED_QDR, " QDR", 100),
+	IB_SPEED_ATTR(IB_SPEED_FDR10, " FDR10", 100),
+	IB_SPEED_ATTR(IB_SPEED_FDR, " FDR", 140),
+	IB_SPEED_ATTR(IB_SPEED_EDR, " EDR", 250),
+	IB_SPEED_ATTR(IB_SPEED_HDR, " HDR", 500),
+	IB_SPEED_ATTR(IB_SPEED_NDR, " NDR", 1000),
+	IB_SPEED_ATTR(IB_SPEED_XDR, " XDR", 2000),
+};
+
+int ib_port_attr_to_speed_info(struct ib_port_attr *attr,
+			       struct ib_port_speed_info *speed_info)
+{
+	int speed_idx = attr->active_speed;
+
+	switch (attr->active_speed) {
+	case IB_SPEED_DDR:
+	case IB_SPEED_QDR:
+	case IB_SPEED_FDR10:
+	case IB_SPEED_FDR:
+	case IB_SPEED_EDR:
+	case IB_SPEED_HDR:
+	case IB_SPEED_NDR:
+	case IB_SPEED_XDR:
+	case IB_SPEED_SDR:
+		break;
+	default:
+		speed_idx = IB_SPEED_SDR; /* Default to SDR for invalid rates */
+		break;
+	}
+
+	speed_info->str = ib_speed_attrs[speed_idx].str;
+	speed_info->rate = ib_speed_attrs[speed_idx].speed;
+	speed_info->rate *= ib_width_enum_to_int(attr->active_width);
+	if (speed_info->rate < 0)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_port_attr_to_speed_info);
+
 __attribute_const__ enum rdma_transport_type
 rdma_node_get_transport(unsigned int node_type)
 {
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 95f1e557cbb8..b984f9581a73 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -878,6 +878,20 @@ __attribute_const__ int ib_rate_to_mult(enum ib_rate rate);
  */
 __attribute_const__ int ib_rate_to_mbps(enum ib_rate rate);
 
+struct ib_port_speed_info {
+	const char *str;
+	int rate;	/* in deci-Gb/sec (100 MBps units) */
+};
+
+/**
+ * ib_port_attr_to_speed_info - Convert port attributes to speed information
+ * @attr: Port attributes containing active_speed and active_width
+ * @speed_info: Speed information to return
+ *
+ * Returns 0 on success, -EINVAL on error.
+ */
+int ib_port_attr_to_speed_info(struct ib_port_attr *attr,
+			       struct ib_port_speed_info *speed_info);
 
 /**
  * enum ib_mr_type - memory region type

-- 
2.47.1


