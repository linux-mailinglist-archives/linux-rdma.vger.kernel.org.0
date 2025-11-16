Return-Path: <linux-rdma+bounces-14498-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D2C61B43
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 20:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0BB9035D961
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Nov 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956FA23ABB0;
	Sun, 16 Nov 2025 19:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+GgbD5Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012049.outbound.protection.outlook.com [40.93.195.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FB1C862E;
	Sun, 16 Nov 2025 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763320319; cv=fail; b=NQ+dNQQlp3hs0nB7T9p9zZA4/Qhs91QSfzxpcD9U3c3+Fmg2n4uPkY/866DAafutEkGEx1wcAdz2nYLDmQ2RfXDYybAaNyRSecg/9eQntQA5ZNGLFDk6bIuUKOlahKRbv2ZH+t2wRsMJihmBaVnjAsJFo5n7M+6eBMZHE9S1V5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763320319; c=relaxed/simple;
	bh=LHDxHyZAtAycHq37BELJ+4bdWyfh0xhf6+go+14dLGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OeDv+6cVO95dVd+Yn1C56kr3AWsVpTxlzp45Mrepthl8TmTNUa0HOPdAAgi+F/eV6lfv2jnBfKY3omp1vvmnwZdyInRueVvEOITguYkv6gDfRcm684xOA45TJCTiZ7ZN2BfMdTubIJdxBveQUvFqlrNWMjZwcBUbePJlBX9qnug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b+GgbD5Q; arc=fail smtp.client-ip=40.93.195.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUu/nEh3MPs14E/OtuGSwdaUKEIFdW72L20WxB34kCey2hGdq4jVWry3QozeduzMBeNO0YQ+RW7isKAAprbp2K349BkCprHhz+yJxXxh0k4dyQrgXXeF1qVtgthd5w85kZ7zWxneiRVQSvkiqzrQPh94z3QuqRBDa11nC51/df9jCBxemE8wcnJn5GxUyoap7+8bsMtzZkjag+IOqS3BUeoDECKZ0hiUBh/ngH12ATkNRDXdTGA+7hxsN4/wtYSy93kWlEqf62BavAiltBu3vAqQmfNTk3d4FsnNFYI2ZvzBweKWZE26FKq54G8kIivzBoON/0dwZrjdAh9MF768hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ok+B+nObHkQRc3hezNiybiKfnjVO7cyW6hq8QXeR6g=;
 b=iLBl/ApOQLUBRWTXEECRGbsRTLceliUc1GFtv2WgGbhVDRq2+/lcQs6V95NtVlHL9QJsHpglnOR+Y7+hAQFy9VJ9weKp6rf8VreWzgS4HtiqbLHst8sw+CwjZ+Wr9Y0f/zv3r/lFLl2M4TTX67Zof5juZMpA4IEeuB7V0lutMSVsXSfgFXIhw/50eVK9SucGNbg4pMJVT9dwVPOcIPRouHmxIkTGfscsMw+DHDnT3qjLuYERMa3bo/0qcni1KvkljlGyF7ytx11ghr7NEzQlXZthntBLZyo0KY3IZ6u0kXF8S1yBCPkP1s/DEmrXfj3Zqc9IQJfkGi7Xaf/HEiFWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ok+B+nObHkQRc3hezNiybiKfnjVO7cyW6hq8QXeR6g=;
 b=b+GgbD5Q4Q1FszfeCOH2G+vzP9iP5+x0sYbnB8IbdLCHoXeOSAbqebCUJgPue4J9/6QEra7SSEAmswBrlPJJQA5DLyGgIZRdd9SKm2Uo/svE+BzhqjAmuHWr8R4xS5VBcH4qUKVvVHo+15CJEOp6E97oZNcz7EQ7F/VvuM57W+DKBs7ZvrlGFpTmNSV9wK138hhCbpB+BaiBB+ty4WPUYVONWNjG/tCCEX24wPHRvER+tgs1ofSrVjDEFD1ofLG/zFPjAH1LS+dvSgHTVe6CuZQMDwl8+yBI9htInLTmxJ4g1IqQnbcC9HOTpITo/NKh+a573RhO9ShfABTCSXQmQg==
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by BY5PR12MB4290.namprd12.prod.outlook.com (2603:10b6:a03:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Sun, 16 Nov
 2025 19:11:49 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:e6:cafe::78) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.20 via Frontend Transport; Sun,
 16 Nov 2025 19:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Sun, 16 Nov 2025 19:11:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 16 Nov
 2025 11:11:41 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 16 Nov 2025 11:11:41 -0800
Received: from c-237-169-180-182.mtl.labs.mlnx (10.127.8.13) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Sun, 16 Nov 2025 11:11:36 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 16 Nov 2025 21:10:22 +0200
Subject: [PATCH rdma-next 1/9] IB/core: Introduce FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251116-frmr_pools-v1-1-5eb3c8f5c9c4@nvidia.com>
References: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
In-Reply-To: <20251116-frmr_pools-v1-0-5eb3c8f5c9c4@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763320291; l=15418;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=ZalCWuNwIiSFKRjjJwQckGiUkX5blL63kb3PFdjXVTA=;
 b=YV7M0BT0CsgM6jxioI6PECArhN8hpAtNBAmZEHX3CU9SIGIKFDOpkgAEo7cbueC+JiIip5NMr
 Yma/tiF7BLPDyu7Ei2VWsj4vFZOm74szsCtDZG0kUDX1cBoTbCi9qw2
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|BY5PR12MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c22f7c3-869f-4e29-c93f-08de2543fe02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVpJL0pqMXJQTjVvVlZ5UFllRGN4ZlpITlhaQXYyWlJrblo0cVRHNVJpaFNj?=
 =?utf-8?B?UElYMTF5VWJjeXV3THEvckhCbEN2Kzdpd25iQ1NqRjZ3WjAyQjhWYnpobFBv?=
 =?utf-8?B?Qm5nT1A4WUFvOWRVT2hZWSttRW1BUVhkMFVXZVRIL1JlV0tINjBBY21kQTVR?=
 =?utf-8?B?VzJOWGJaM25XdEZsVTJoYjQrUXhmZE16eXk4ZE5MdStFMGc3YVI3b0VlYTlN?=
 =?utf-8?B?eHVJUXlMUjEvQzJlOWVQZngwaklFWm83bmZocmRyQUYyaTJ2YnExaDZPRFBh?=
 =?utf-8?B?NmhRVDBzWDd2WHE2RlJ1d0plT3ltL2UvOXVZamhzSlZKa3IyYWg0QjNiQW9Y?=
 =?utf-8?B?T0d5czc4U3RsUTBPajlXRWI3b29ERkQ3TG5JMkRPb0d2aS9Td0RlVUtzWHda?=
 =?utf-8?B?QldyN0NDQTVzTEgrbWFsbzZBMzVHa0lldHJSRmgydWxwTldZVkUySHZkMzh3?=
 =?utf-8?B?SkF6RkI3bERCMEs2Rzl6bjRXOGU4dUhRV0I5cktRQTBOM3RzS3RCWTEwbWpt?=
 =?utf-8?B?M0Nxc2U3S1ZZRTFnUmUveXU0UmVpc3p3Mm52NnFPU3ljMHZxdDZUamFHb09l?=
 =?utf-8?B?VVNMSUlnTzRDbXI2bkEzWGZXTDY1RE9oUWdRMGx4MCtnczFYVURlSWxwRksy?=
 =?utf-8?B?Nm1qSDZ1YWVySjdJT3p4TXdoSGRxMWxHZlVLamN2TnBmOHJnRlBEQjh4azBv?=
 =?utf-8?B?QXBST1dzeUtGZW1HWUovaHZGdFFIamN1aVROYUdNM2hudTZjbXduMUMxbWhl?=
 =?utf-8?B?dkwvcXZMeXc0akh2eXJIMEd0dUxqS3pVSC90VmtjNnJFZTJkS1dWbzJqNTda?=
 =?utf-8?B?U0gvbXE1RjZTTGtBSFNSa3djZ2ptQVZQOHJEMytOcnBEaVpkTmNsK2M5RmJm?=
 =?utf-8?B?QkR0dmZ2cXpiVWwzRmYzY0plTjI3V3laZ3NHV0lUZzZaeGNPYk5jWnU0dmVv?=
 =?utf-8?B?amg3OEJRR0IyK2E4UjZjWVh3NkFsbjZnMHRQMWZrckVBRUJBWGFnSmowRFJJ?=
 =?utf-8?B?STV1ZzgwVjl6TnZiVHIwcERMMTd1bzc3citSNjhBVTdsOEhVZllRU3JldlZ6?=
 =?utf-8?B?YnkwcUN1dllGY3ppM3ljY2N0VzFrVTc4aGJ1VkxYMFR2NjJMQjluTWx6ZFB5?=
 =?utf-8?B?RDVMSWNpTmMwV0txbWRNeFAzcElvcHhVUC8xS3pnRVdnZzdWcUlXMk96b3NS?=
 =?utf-8?B?eWo5a0pOUW1lWnlZWFFadm5ra0NyeE5UN0NrcXc0UDRJWG1mM0VUWlJHNFBW?=
 =?utf-8?B?Y0h2bUpOR0lYMEp1S1A2VG83ak00ODhHblNzTXNFUjJKWHlaY1NrRkttSzVw?=
 =?utf-8?B?Vm50eWhta25VVU5ja2NrVUlKMGwwUDRzWjJiaDZJMlZMRjRCRTVaRHlQY2RT?=
 =?utf-8?B?bkIyZG5MQk5COFdkWndMV29WTWRXTEdadVNLN2poTFZvSjRCell4SG1RbklN?=
 =?utf-8?B?b1pRYkV1SWVCR3RUdDNybHJ6YjZYemxsRzc5VGpFMVRNa3RIdjAzazVHYWla?=
 =?utf-8?B?cUk3WVhOM1JDMFdic01lY0F3Zk1EMDNvSVBhMCs0RklNdTRhcmozYzg5MlRm?=
 =?utf-8?B?cHU0b2ZQcUU4Sk1WN1paUm4yMjVRTFJOYXpGY0hwNmRrRGRXdFZPK2M0TmMw?=
 =?utf-8?B?dUdwOE8zdEFvZHdxS1pPNGRLbGNUSnFwbkVtandldlZSSUh0L0R5cHE0S3ov?=
 =?utf-8?B?TGFHc0VMK0l2VFo1QTViYTduRkY4UmdlaXhickluZmNjTENMT2FOdVU5ZTBK?=
 =?utf-8?B?TU1yQ3NrMlFNemFzTU15UExkajNWUFRKSDVJQlZ0NkhpZ1lwWDRFaXVuSm54?=
 =?utf-8?B?SG1XUU5VUmlWOEY5ZUk5NS9rVkdjYTNDQjJyRnYvZWFxNnBybmY0MHdRcTFm?=
 =?utf-8?B?M2llT3NCSHZiM3hwSlJpeTRBcUUySEErcEFSV3daRkhUUVpqQXYrTE10b1du?=
 =?utf-8?B?QzZIcEp4bFZGVXNjT29yZHdhSXowRlF3UG1nQnpOUkNUNHBGeXJISFRRYlN0?=
 =?utf-8?B?cEh0YzVmemVsUTQ4SlZzM0NDWFJBTHdFL2FQK1YwWGxuaENlZ3N4OXZ5cDZu?=
 =?utf-8?B?bFRqOXE2OFJ4Y2NJZXEvWXBRRzRIUnV2QXNSUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2025 19:11:48.6048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c22f7c3-869f-4e29-c93f-08de2543fe02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4290

From: Michael Guralnik <michaelgur@nvidia.com>

Add a generic Fast Registration Memory Region pools mechanism to allow
drivers to optimize memory registration performance.
Drivers that have the ability to reuse MRs or their underlying HW
objects can take advantage of the mechanism to keep a 'handle' for those
objects and use them upon user request.
We assume that to achieve this goal a driver and its HW should implement
a modify operation for the MRs that is able to at least clear and set the
MRs and in more advanced implementations also support changing a subset
of the MRs properties.

The mechanism is built using an RB-tree consisting of pools, each pool
represents a set of MR properties that are shared by all of the MRs
residing in the pool and are unmodifiable by the vendor driver or HW.

The exposed API from ib_core to the driver has 4 operations:
Init and cleanup - handles data structs and locks for the pools.
Push and pop - store and retrieve 'handle' for a memory registration
or deregistrations request.

The FRMR pools mechanism implements the logic to search the RB-tree for
a pool with matching properties and create a new one when needed and
requires the driver to implement creation and destruction of a 'handle'
when pool is empty or a handle is requested or is being destroyed.

Later patch will introduce Netlink API to interact with the FRMR pools
mechanism to allow users to both configure and track its usage.
A vendor wishing to configure FRMR pool without exposing it or without
exposing internal MR properties to users, should use the
kernel_vendor_key field in the pools key. This can be useful in a few
cases, e.g, when the FRMR handle has a vendor-specific un-modifiable
property that the user registering the memory might not be aware of.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/core/Makefile     |   2 +-
 drivers/infiniband/core/frmr_pools.c | 328 +++++++++++++++++++++++++++++++++++
 drivers/infiniband/core/frmr_pools.h |  48 +++++
 include/rdma/frmr_pools.h            |  37 ++++
 include/rdma/ib_verbs.h              |   8 +
 5 files changed, 422 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index f483e0c124445c1e9796dc7d766517b12f6dfc2f..7089a982b876f1f5088e922f296725954697a1a4 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -12,7 +12,7 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
 				nldev.o restrack.o counters.o ib_core_uverbs.o \
-				trace.o lag.o
+				trace.o lag.o frmr_pools.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
new file mode 100644
index 0000000000000000000000000000000000000000..073b2fcfb2cc7d466fedfba14ad04f1e2d7edf65
--- /dev/null
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/slab.h>
+#include <linux/rbtree.h>
+#include <linux/spinlock.h>
+#include <rdma/ib_verbs.h>
+
+#include "frmr_pools.h"
+
+static int push_handle_to_queue_locked(struct frmr_queue *queue, u32 handle)
+{
+	u32 tmp = queue->ci % NUM_HANDLES_PER_PAGE;
+	struct frmr_handles_page *page;
+
+	if (queue->ci >= queue->num_pages * NUM_HANDLES_PER_PAGE) {
+		page = kzalloc(sizeof(*page), GFP_ATOMIC);
+		if (!page)
+			return -ENOMEM;
+		queue->num_pages++;
+		list_add_tail(&page->list, &queue->pages_list);
+	} else {
+		page = list_last_entry(&queue->pages_list,
+				       struct frmr_handles_page, list);
+	}
+
+	page->handles[tmp] = handle;
+	queue->ci++;
+	return 0;
+}
+
+static u32 pop_handle_from_queue_locked(struct frmr_queue *queue)
+{
+	u32 tmp = (queue->ci - 1) % NUM_HANDLES_PER_PAGE;
+	struct frmr_handles_page *page;
+	u32 handle;
+
+	page = list_last_entry(&queue->pages_list, struct frmr_handles_page,
+			       list);
+	handle = page->handles[tmp];
+	queue->ci--;
+
+	if (!tmp) {
+		list_del(&page->list);
+		queue->num_pages--;
+		kfree(page);
+	}
+
+	return handle;
+}
+
+static bool pop_frmr_handles_page(struct ib_frmr_pool *pool,
+				  struct frmr_queue *queue,
+				  struct frmr_handles_page **page, u32 *count)
+{
+	spin_lock(&pool->lock);
+	if (list_empty(&queue->pages_list)) {
+		spin_unlock(&pool->lock);
+		return false;
+	}
+
+	*page = list_first_entry(&queue->pages_list, struct frmr_handles_page,
+				 list);
+	list_del(&(*page)->list);
+	queue->num_pages--;
+
+	/* If this is the last page, count may be less than
+	 * NUM_HANDLES_PER_PAGE.
+	 */
+	if (queue->ci >= NUM_HANDLES_PER_PAGE)
+		*count = NUM_HANDLES_PER_PAGE;
+	else
+		*count = queue->ci;
+
+	queue->ci -= *count;
+	spin_unlock(&pool->lock);
+	return true;
+}
+
+static void destroy_frmr_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct frmr_handles_page *page;
+	u32 count;
+
+	while (pop_frmr_handles_page(pool, &pool->queue, &page, &count)) {
+		pools->pool_ops->destroy_frmrs(device, page->handles, count);
+		kfree(page);
+	}
+
+	rb_erase(&pool->node, &pools->rb_root);
+	kfree(pool);
+}
+
+/*
+ * Initialize the FRMR pools for a device.
+ *
+ * @device: The device to initialize the FRMR pools for.
+ * @pool_ops: The pool operations to use.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pools_init(struct ib_device *device,
+		       const struct ib_frmr_pool_ops *pool_ops)
+{
+	struct ib_frmr_pools *pools;
+
+	pools = kzalloc(sizeof(*pools), GFP_KERNEL);
+	if (!pools)
+		return -ENOMEM;
+
+	pools->rb_root = RB_ROOT;
+	rwlock_init(&pools->rb_lock);
+	pools->pool_ops = pool_ops;
+
+	device->frmr_pools = pools;
+	return 0;
+}
+EXPORT_SYMBOL(ib_frmr_pools_init);
+
+/*
+ * Clean up the FRMR pools for a device.
+ *
+ * @device: The device to clean up the FRMR pools for.
+ *
+ * Call cleanup only after all FRMR handles have been pushed back to the pool
+ * and no other FRMR operations are allowed to run in parallel.
+ * Ensuring this allows us to save synchronization overhead in pop and push
+ * operations.
+ */
+void ib_frmr_pools_cleanup(struct ib_device *device)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct rb_node *node = rb_first(&pools->rb_root);
+	struct ib_frmr_pool *pool;
+
+	while (node) {
+		struct rb_node *next = rb_next(node);
+
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		destroy_frmr_pool(device, pool);
+		node = next;
+	}
+
+	kfree(pools);
+	device->frmr_pools = NULL;
+}
+EXPORT_SYMBOL(ib_frmr_pools_cleanup);
+
+static int compare_keys(struct ib_frmr_key *key1, struct ib_frmr_key *key2)
+{
+	int res;
+
+	res = key1->ats - key2->ats;
+	if (res)
+		return res;
+
+	res = key1->access_flags - key2->access_flags;
+	if (res)
+		return res;
+
+	res = key1->vendor_key - key2->vendor_key;
+	if (res)
+		return res;
+
+	res = key1->kernel_vendor_key - key2->kernel_vendor_key;
+	if (res)
+		return res;
+
+	/*
+	 * allow using handles that support more DMA blocks, up to twice the
+	 * requested number
+	 */
+	res = key1->num_dma_blocks - key2->num_dma_blocks;
+	if (res > 0 && res < key2->num_dma_blocks)
+		return 0;
+
+	return res;
+}
+
+static struct ib_frmr_pool *ib_frmr_pool_find(struct ib_frmr_pools *pools,
+					      struct ib_frmr_key *key)
+{
+	struct rb_node *node = pools->rb_root.rb_node;
+	struct ib_frmr_pool *pool;
+	int cmp;
+
+	/* find operation is done under read lock for performance reasons.
+	 * The case of threads failing to find the same pool and creating it
+	 * is handled by the create_frmr_pool function.
+	 */
+	read_lock(&pools->rb_lock);
+	while (node) {
+		pool = rb_entry(node, struct ib_frmr_pool, node);
+		cmp = compare_keys(&pool->key, key);
+		if (cmp < 0) {
+			node = node->rb_right;
+		} else if (cmp > 0) {
+			node = node->rb_left;
+		} else {
+			read_unlock(&pools->rb_lock);
+			return pool;
+		}
+	}
+
+	read_unlock(&pools->rb_lock);
+
+	return NULL;
+}
+
+static struct ib_frmr_pool *create_frmr_pool(struct ib_device *device,
+					     struct ib_frmr_key *key)
+{
+	struct rb_node **new = &device->frmr_pools->rb_root.rb_node,
+		       *parent = NULL;
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+	int cmp;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(&pool->key, key, sizeof(*key));
+	INIT_LIST_HEAD(&pool->queue.pages_list);
+	spin_lock_init(&pool->lock);
+
+	write_lock(&pools->rb_lock);
+	while (*new) {
+		parent = *new;
+		cmp = compare_keys(
+			&rb_entry(parent, struct ib_frmr_pool, node)->key, key);
+		if (cmp < 0)
+			new = &((*new)->rb_left);
+		else
+			new = &((*new)->rb_right);
+		/* If a different thread has already created the pool, return
+		 * it. The insert operation is done under the write lock so we
+		 * are sure that the pool is not inserted twice.
+		 */
+		if (cmp == 0) {
+			write_unlock(&pools->rb_lock);
+			kfree(pool);
+			return rb_entry(parent, struct ib_frmr_pool, node);
+		}
+	}
+
+	rb_link_node(&pool->node, parent, new);
+	rb_insert_color(&pool->node, &pools->rb_root);
+
+	write_unlock(&pools->rb_lock);
+
+	return pool;
+}
+
+static int get_frmr_from_pool(struct ib_device *device,
+			      struct ib_frmr_pool *pool, struct ib_mr *mr)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	u32 handle;
+	int err;
+
+	spin_lock(&pool->lock);
+	if (pool->queue.ci == 0) {
+		spin_unlock(&pool->lock);
+		err = pools->pool_ops->create_frmrs(device, &pool->key, &handle,
+						    1);
+		if (err)
+			return err;
+	} else {
+		handle = pop_handle_from_queue_locked(&pool->queue);
+		spin_unlock(&pool->lock);
+	}
+
+	mr->frmr.pool = pool;
+	mr->frmr.handle = handle;
+
+	return 0;
+}
+
+/*
+ * Pop an FRMR handle from the pool.
+ *
+ * @device: The device to pop the FRMR handle from.
+ * @mr: The MR to pop the FRMR handle from.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
+{
+	struct ib_frmr_pools *pools = device->frmr_pools;
+	struct ib_frmr_pool *pool;
+
+	WARN_ON_ONCE(!device->frmr_pools);
+	pool = ib_frmr_pool_find(pools, &mr->frmr.key);
+	if (!pool) {
+		pool = create_frmr_pool(device, &mr->frmr.key);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+	}
+
+	return get_frmr_from_pool(device, pool, mr);
+}
+EXPORT_SYMBOL(ib_frmr_pool_pop);
+
+/*
+ * Push an FRMR handle back to the pool.
+ *
+ * @device: The device to push the FRMR handle to.
+ * @mr: The MR containing the FRMR handle to push back to the pool.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr)
+{
+	struct ib_frmr_pool *pool = mr->frmr.pool;
+	int ret;
+
+	spin_lock(&pool->lock);
+	ret = push_handle_to_queue_locked(&pool->queue, mr->frmr.handle);
+	spin_unlock(&pool->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_frmr_pool_push);
diff --git a/drivers/infiniband/core/frmr_pools.h b/drivers/infiniband/core/frmr_pools.h
new file mode 100644
index 0000000000000000000000000000000000000000..5a4d03b3d86f431c3f2091dd5ab27292547c2030
--- /dev/null
+++ b/drivers/infiniband/core/frmr_pools.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef RDMA_CORE_FRMR_POOLS_H
+#define RDMA_CORE_FRMR_POOLS_H
+
+#include <rdma/frmr_pools.h>
+#include <linux/rbtree_types.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+#include <asm/page.h>
+
+#define NUM_HANDLES_PER_PAGE \
+	((PAGE_SIZE - sizeof(struct list_head)) / sizeof(u32))
+
+struct frmr_handles_page {
+	struct list_head list;
+	u32 handles[NUM_HANDLES_PER_PAGE];
+};
+
+/* FRMR queue holds a list of frmr_handles_page.
+ * num_pages: number of pages in the queue.
+ * ci: current index in the handles array across all pages.
+ */
+struct frmr_queue {
+	struct list_head pages_list;
+	u32 num_pages;
+	unsigned long ci;
+};
+
+struct ib_frmr_pool {
+	struct rb_node node;
+	struct ib_frmr_key key; /* Pool key */
+
+	/* Protect access to the queue */
+	spinlock_t lock;
+	struct frmr_queue queue;
+};
+
+struct ib_frmr_pools {
+	struct rb_root rb_root;
+	rwlock_t rb_lock;
+	const struct ib_frmr_pool_ops *pool_ops;
+};
+
+#endif /* RDMA_CORE_FRMR_POOLS_H */
diff --git a/include/rdma/frmr_pools.h b/include/rdma/frmr_pools.h
new file mode 100644
index 0000000000000000000000000000000000000000..da92ef4d7310c0fe0cebf937a0049f81580ad386
--- /dev/null
+++ b/include/rdma/frmr_pools.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (c) 2025, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef FRMR_POOLS_H
+#define FRMR_POOLS_H
+
+#include <linux/types.h>
+#include <asm/page.h>
+
+struct ib_device;
+struct ib_mr;
+
+struct ib_frmr_key {
+	u64 vendor_key;
+	/* A pool with non-zero kernel_vendor_key is a kernel-only pool. */
+	u64 kernel_vendor_key;
+	size_t num_dma_blocks;
+	int access_flags;
+	u8 ats:1;
+};
+
+struct ib_frmr_pool_ops {
+	int (*create_frmrs)(struct ib_device *device, struct ib_frmr_key *key,
+			    u32 *handles, u32 count);
+	void (*destroy_frmrs)(struct ib_device *device, u32 *handles,
+			      u32 count);
+};
+
+int ib_frmr_pools_init(struct ib_device *device,
+		       const struct ib_frmr_pool_ops *pool_ops);
+void ib_frmr_pools_cleanup(struct ib_device *device);
+int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr);
+int ib_frmr_pool_push(struct ib_device *device, struct ib_mr *mr);
+
+#endif /* FRMR_POOLS_H */
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 0a85af610b6b72db33ddd90b30163e18f7038e7d..6cc557424e2323161a3d50181190ad36d9d0a149 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -43,6 +43,7 @@
 #include <uapi/rdma/rdma_user_ioctl.h>
 #include <uapi/rdma/ib_user_ioctl_verbs.h>
 #include <linux/pci-tph.h>
+#include <rdma/frmr_pools.h>
 
 #define IB_FW_VERSION_NAME_MAX	ETHTOOL_FWVERS_LEN
 
@@ -1886,6 +1887,11 @@ struct ib_mr {
 	struct ib_dm      *dm;
 	struct ib_sig_attrs *sig_attrs; /* only for IB_MR_TYPE_INTEGRITY MRs */
 	struct ib_dmah *dmah;
+	struct {
+		struct ib_frmr_pool *pool;
+		struct ib_frmr_key key;
+		u32 handle;
+	} frmr;
 	/*
 	 * Implementation details of the RDMA core, don't use in drivers:
 	 */
@@ -2879,6 +2885,8 @@ struct ib_device {
 	struct list_head subdev_list;
 
 	enum rdma_nl_name_assign_type name_assign_type;
+
+	struct ib_frmr_pools *frmr_pools;
 };
 
 static inline void *rdma_zalloc_obj(struct ib_device *dev, size_t size,

-- 
2.47.1


