Return-Path: <linux-rdma+bounces-13428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC87B59DB7
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 18:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC52D7B766D
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Sep 2025 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF342F2601;
	Tue, 16 Sep 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jQR8hf9W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8247D2F25FD;
	Tue, 16 Sep 2025 16:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758040326; cv=fail; b=FOEcpV792q6jAhmRietbMc/nqjaI4B5DUUDBA5dZmnr06EwTV2Xqhgf3ZBNdRXOPOq52QlmM51864Hls//wzrfjiyQQWpjhvlQpd3v7I/+0K0CKcozpiPF68m/gq196EzXOY8cuAHQWHa8G7mydDmNU9CS9DJNmvuxd/+gBfgLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758040326; c=relaxed/simple;
	bh=HCLHWco/dNYdNuISnQCcR9wetAD+TRcvRvbyIsG0sp4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b/4XoEhrAzfZC3E7tSU9QyuOw+L6GAcPNwIKnOV6gIvs8cIf7Q1FADGqkR5aVV1o4idS2lLPcwpzi25/ScGbSldBjogBOOoixNZMKgLtQ3RsxlB8z9HIAEtF+/+FG1LHRNiXuIWq1uLySmpf92AX2HDbSD3pgRp+optq5z49EC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jQR8hf9W; arc=fail smtp.client-ip=52.101.43.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA/xHojUnAUlv8YWWyJFazDuy13r0j/1lm4Dhh2+YePL8kMq/ZD6lkYwPWlG5GBJkJYMUIs1fZRliZq7dhnOHrWe16yByS3eChr1HppRPS8f84F8PGft1Q9Rj57NifWFmQU0+YfwNWgC8AszB4SHhkY+kYLPsyHL0dL8ZzqXfsrt1ybSD7cWHNY63wqfVVkgOnB6GrLF5AehKQHvknT7os5R7KuCYpe8ePHR+7GTajNbzbc0tnYFLBUGQflA4LlAFiFu19Li2m2rfsbWiAvhQnQSnYU0RLUp5r11uDxvQKM+5qpAz7Dt7l4JRimWO5lzGxc4dB9+rHKawSq4uzl1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cc+fg7j9jadB5ZIgy8OCLsN6prdLWiYUMX+ZD/c/Mrw=;
 b=TjEbAhDKtcxao8Mjq5wM18bp/KT6eX9rITgaGHkkGZyV88IeIrikPbkvLfx5z/UZOs6qp0iFfBW1KJVCnuhYwL47kYeIJvzJoiR7aQ27V01oJvaWzUiZmLsiDvsIhnXYnOY+AW0zdWgsfGGglad8lt0yXXY3iuc8AxVMdTwHbnww4ABl2pXV49BHNkCu506EDszJc2FY82TbRgAVwi2QATGXF1WyK4qogTMVovGDR94ztnLFg5WXl+r2v39NZGgeYqGhyJ4inZSV9nCG4dqWxzuXKGekqLidvf8K+kxUhwjfMYiTi8cQzq3XK+25lm1VvhQPr03o0tXjFhIcdO9Llw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=ziepe.ca smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cc+fg7j9jadB5ZIgy8OCLsN6prdLWiYUMX+ZD/c/Mrw=;
 b=jQR8hf9Wxj+SimfZASwfKHKUr0tgv1jdVwm39gpdliOmzxLs0vqm63B0gx+TF3c5Wxnkd3zbEDZxxLThP9TpM9ipgXkiqatzwqrUwFZcxMqushIb4jibs/3/US/liU0N8f1N+6DF+vFDZJLLNWC/tX4abOz1ClNC06/VqLqxed1MvRWT96yonBSuG7Ju70dL5+NMvJh3Asxq0thEZ54auvlUj+wU2D2/OTU06KhSpFsq4fPq8IxI6XTH3fKKCIoC74IkQ6MhjrSlgXdKZo4xPRWWfHGlRhT/NcFMQK1jPlousCVO7h9CfZB3Nm5zCSuMSmQQBn/QIPyWHpcX0W4rXw==
Received: from CH5PR05CA0014.namprd05.prod.outlook.com (2603:10b6:610:1f0::24)
 by CH8PR12MB9814.namprd12.prod.outlook.com (2603:10b6:610:26b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 16:32:00 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::97) by CH5PR05CA0014.outlook.office365.com
 (2603:10b6:610:1f0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Tue,
 16 Sep 2025 16:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 16:32:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 09:31:36 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 16 Sep
 2025 09:31:35 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 16
 Sep 2025 09:31:32 -0700
From: Edward Srouji <edwards@nvidia.com>
To: <jgg@ziepe.ca>, <leon@kernel.org>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vdumitrescu@nvidia.com>, <markzhang@nvidia.com>, <ohartoov@nvidia.com>,
	<edwards@nvidia.com>, <ira.weiny@intel.com>, <kaike.wan@intel.com>,
	<dledford@redhat.com>, <john.fleck@intel.com>
Subject: [PATCH 1/1] IB/sa: Fix sa_local_svc_timeout_ms read race
Date: Tue, 16 Sep 2025 19:31:12 +0300
Message-ID: <20250916163112.98414-1-edwards@nvidia.com>
X-Mailer: git-send-email 2.21.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|CH8PR12MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fb838b-4061-4da6-00b2-08ddf53e8fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OZIoz6fZ9R+opxFVktOPn46ZQ8TxojXhhrfGohB2XYa12+My2iqN6qykfvQw?=
 =?us-ascii?Q?llrnTUHU4//bA0di78TBqnKIKVEokELwCIbtRuDTiGhh9xGGGjg2XEiCPeGD?=
 =?us-ascii?Q?VvCtiSPRgc7qK+WyAVpvbQR+PERJMpIno5BGQZcreh/fBk+LRGbrzUcVuNUw?=
 =?us-ascii?Q?XLuFufxnRFGUaTnmtlrqNNmWrDKL3sZWV5pTgquzTQtdQ1YkA0IQEJ239Xcl?=
 =?us-ascii?Q?kpuJ2H8db9+KsGN0CdiF13v5tdX/e0RF6MWcqrtTObpBq1ofW48MMJ8DZ9CR?=
 =?us-ascii?Q?hoonI+SbUbOL9wIAlzX4FqWWUOUNr78ZkWVlOLYqVPYgTKh5ipJ1EI4T9d8P?=
 =?us-ascii?Q?vA4Nrk16N+U9/j9BL4pXfM5p2hr805vXub434HJis5huAxKdDoEcgXVo6lMX?=
 =?us-ascii?Q?0ZC9ONDWBT8S03pc+HpMQUHeewNw6u9deONyg6n46JbaLV5VQdpq0JbS4kG/?=
 =?us-ascii?Q?YPH6OCjkTTAas81SI35dj5IUAgKEEJC4LtSRtqSS0wFnrBQPfwjMmcmJcNaS?=
 =?us-ascii?Q?tIt3hdUliq1dOk3XDG5zr01KVH4tHw4VC+JjobBIYMpzqFnbc+CO4OY2WvZ5?=
 =?us-ascii?Q?QH0pmWYdrxkMEayjzntbvk1s5tns/aeHS12qBeQiPRdMMF9vqariJu0p/Z6u?=
 =?us-ascii?Q?JgwfBQ6X/xZcOcf1ilT7GC8+MajAoofikZpXer4N1gJ3dFCznwKHDW5/qEqQ?=
 =?us-ascii?Q?FgPF/MIEao059tsB6xXDfpatXAB4ScNUKbGFJaFzsNZvBOA/len91JUQPDz8?=
 =?us-ascii?Q?Hun4oDBZE53C7kuDTgngNxKemRl0TFeqOJ817n5KzJAT1/Olpaq4kvjZ/Du6?=
 =?us-ascii?Q?VoNlGkic2YGmOg7maL3caf+BxrFvndIiWTMmSyxThol/bj1z+/u9xRmQ+Eh/?=
 =?us-ascii?Q?XhWSUS4D3B7Yr54o5iA3TuAxCmkso5aoCtpEZOBPLwxwHRc+QJwg4KITDEEf?=
 =?us-ascii?Q?u3FjH9P1X7Q8XQZQjLy8Dyn6WSOwJsYmPQQB2UOsDf34kHzGqXq772k3YtUt?=
 =?us-ascii?Q?Q7Z0tD08qg7v8+t+bpHl7YQI4W6akKqJN3pjEF3CwDoVZUqxPp5esyilrufh?=
 =?us-ascii?Q?WtV3VNweNYlbD96MgHN5RLBw6ay1jCB+IDNnJFFlTGhs3AokverjjD/tmteP?=
 =?us-ascii?Q?Qm+HeDUu2LPAuU2mHjabJlp60pPihgEgJBEBUtx1hgG/+1n4SW0asEGACXQ3?=
 =?us-ascii?Q?oDe0Th3isyh4BPefPpgQSOyBZuA0us8sLXI+NDyjNA1u9LU39zIRHjrWxdEE?=
 =?us-ascii?Q?gtyTYIWyjR0GN5HTVZ14CdVIFa0DTndV9XNrKAZ/Eyd+LoYfVxsxnXcgFfgb?=
 =?us-ascii?Q?G3YbeVO4J9K/39x7+d9ldYe1FvG+4ujW5c6Lx6paB8VDlpJft63wczAQw0ss?=
 =?us-ascii?Q?6WMhTe0OmtVd0QSTvPfFkykwUwrSqPgjy96d0nLF9puMQi73V1TUSrn9Cd4R?=
 =?us-ascii?Q?sW0kIXU9lKEROqhuIsEIY5fdQHjN4NiY2Azoma5axsKZ1DrPydLJ4bk43iCZ?=
 =?us-ascii?Q?wJNHFfQUD/YaOwlWmOmzKNripsCGkT7EmJ9r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 16:32:00.1498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fb838b-4061-4da6-00b2-08ddf53e8fa3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9814

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

When computing the delta, the sa_local_svc_timeout_ms is read without
ib_nl_request_lock held. Though unlikely in practice, this can cause
a race condition if multiple local service threads are managing the
timeout.

Fixes: 2ca546b92a02 ("IB/sa: Route SA pathrecord query through netlink")
Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/sa_query.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index c0a7af1b4fe4..c23e9c847314 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1074,6 +1074,8 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 	if (timeout > IB_SA_LOCAL_SVC_TIMEOUT_MAX)
 		timeout = IB_SA_LOCAL_SVC_TIMEOUT_MAX;
 
+	spin_lock_irqsave(&ib_nl_request_lock, flags);
+
 	delta = timeout - sa_local_svc_timeout_ms;
 	if (delta < 0)
 		abs_delta = -delta;
@@ -1081,7 +1083,6 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 		abs_delta = delta;
 
 	if (delta != 0) {
-		spin_lock_irqsave(&ib_nl_request_lock, flags);
 		sa_local_svc_timeout_ms = timeout;
 		list_for_each_entry(query, &ib_nl_request_list, list) {
 			if (delta < 0 && abs_delta > query->timeout)
@@ -1099,9 +1100,10 @@ int ib_nl_handle_set_timeout(struct sk_buff *skb,
 		if (delay)
 			mod_delayed_work(ib_nl_wq, &ib_nl_timed_work,
 					 (unsigned long)delay);
-		spin_unlock_irqrestore(&ib_nl_request_lock, flags);
 	}
 
+	spin_unlock_irqrestore(&ib_nl_request_lock, flags);
+
 settimeout_out:
 	return 0;
 }
-- 
2.21.3


