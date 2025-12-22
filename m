Return-Path: <linux-rdma+bounces-15147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9DACD6040
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 13:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4137E300E47C
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Dec 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D12BE026;
	Mon, 22 Dec 2025 12:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qRrKAtDI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010036.outbound.protection.outlook.com [40.93.198.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675BD1EDA3C;
	Mon, 22 Dec 2025 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407281; cv=fail; b=jj1JY7LzyVYb8lLufqnjZzhNGq4i9l533/s6mjrdKTt8Gz3C7E/aCHJwF5RdTD2xahx0TH2hIzmiB/8qE/7gdIQhpeYdogI+gsqp9UCrbKja11XzF0LODolgHySsx7PbEG3VlYuIRGiMWnT2QF56rMZ8tIY6RwEu1N3r/eIBl4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407281; c=relaxed/simple;
	bh=LQzZ/O9cvW/JgK4VxD9AKxBKauhCjXEmZQf4Lt9sTyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZI4eMnVc3sXTW9hlg6c9NsyKGGInbfer0IFlIirYzbsO6UPkLfWySNmDbasByjyT0xnfwXRpU3yf4azIhFr39ckPMUPVIHV6Yf7eertUGGTeV2g/2aYF9QPJI3TuiVJ1N26sWinYyOh0pQqErT8Woh+ii/sTnOXm7qU4uKRS0X8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qRrKAtDI; arc=fail smtp.client-ip=40.93.198.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiADvdwI5kCQ8/1QXRfee8ssEkq3sp9LMy8bHqd9o9F+nkaBB5XpcoXBgV/1DmdCtVE0CSrk+oX4Oiw9O7p6qbKy5JCMa8Ra2Vt3wZ2w0dDSWPD5iGTUfkkdVO9bHtGyFoXlm71QPmKL9RX20vLhF5uBKiJm6fgiUlhk4xYQHw23s91q2dWr+xw1kDyGBLoeDOM/AnnSS3velAmZrGTbjLFM+JK99Vk/a6BQAALmbywUGzGyCkjlBs8JdS/SKN0x2YuiQhi91Fe4PESnMERKlkhwMu6K8q2c089dJHfLoMIfCF7BQwZulmxCrH0Gtmzr5lmZqs1NZShIERoDQbn3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyMFN4QL+naZrAiAvu6pYKL8ob5B+cBtioF/ZWWhFXI=;
 b=vGu5eaQbmYi6LMhjsp0jvpdZxSSJLRKs8CohQv6Ida2WSTSAIlDHbx70tEPOKyDKs3OemNeXgNzra2TVfDIGmCoeE31qZTAZMR0lnwWMGJk2gBhfrF3m0SEGCUEhjFG2RLSD23h3g3sQgSGoNA7YXhoRhFAHMrkYJLusVnx6l50kzweWNf9aXFWBAE35733v9dNpEKNYbkxy+cMiIMRXclmKA1ucSAS3WG8+leoTH5vrZcINLYANhvreUrVvmkviyFTSQTCMFPC9q67FDPjKESYXvWniTNU1feyhyCwlpRXxQEWlF91J1I96HDkbrIqWXLNmuUQk2T8zeunrG4g4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyMFN4QL+naZrAiAvu6pYKL8ob5B+cBtioF/ZWWhFXI=;
 b=qRrKAtDIyUKU+MO3CSbXjrVmi3Wsn558JCeDD3uYj7hiqfj30vcTJnOIp/qeVGeKPSzLbUJ6HNilqFE8qLEC2YDwQdEsfE0EF9HznVRZ9eikUi7vcRYhGje3AHIRtRuilRLDnS47S8n3UdTmvHVfD5iyJm/VACJL4J/8aTIbn81qITdCMoHrz6aSxudAHP1rGeQTXR6IVpmJVikewth5fvKlwTjBhOCjgUnbLlmKwDA6W2W2rhf69TkkyiCD866CFi72y5xJqgqsiHwHeCnoxb8rGHMq7kBDfHJ0F3MXc+P2N34dV8yZXv41EWSTJLL9lYCaZ+8+Xql5Zly7ewyH6g==
Received: from BYAPR08CA0062.namprd08.prod.outlook.com (2603:10b6:a03:117::39)
 by PH7PR12MB6785.namprd12.prod.outlook.com (2603:10b6:510:1ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Mon, 22 Dec
 2025 12:41:10 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:117:cafe::7d) by BYAPR08CA0062.outlook.office365.com
 (2603:10b6:a03:117::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.11 via Frontend Transport; Mon,
 22 Dec 2025 12:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Mon, 22 Dec 2025 12:41:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:40:59 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Dec
 2025 04:40:59 -0800
Received: from c-237-150-60-063.mtl.labs.mlnx (10.127.8.10) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Dec 2025 04:40:54 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 22 Dec 2025 14:40:37 +0200
Subject: [PATCH rdma-next v2 02/11] IB/core: Introduce FRMR pools
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251222-frmr_pools-v2-2-f06a99caa538@nvidia.com>
References: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
In-Reply-To: <20251222-frmr_pools-v2-0-f06a99caa538@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766407244; l=15138;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=gtWnkLW2DQc6D7lURlzZ91m53jvuisEuTnRYPn7YbK0=;
 b=OAtarTZ/sOobzUEc/QAwSxBWFawLeWtHyU+cz/BOuWm1Xb24R0Tmbzn0vuRzNrURCj1laNpv4
 yX3AAnBoJrTCTY5KmCdd8O+ToVDMUtK5hgP7+wU27D49fpFV429ZiBV
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|PH7PR12MB6785:EE_
X-MS-Office365-Filtering-Correlation-Id: c051541c-8310-447a-97af-08de41576279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzlZRHBVTkdlcXdaN29NMlVCNE51NDFaWHFFbVN3UTBmL2xBZTFIaFBDQU9u?=
 =?utf-8?B?bTVnRU9JdjlzS25CMGlyL1p5aWU0ZkJiMVhBSVlwQmNPdkErdkpuU2NRdzhU?=
 =?utf-8?B?UzZiYUpGV0JCdGtpQkhkaUxwVTFxbEdxTEFiTXFjMExzNmRseGFwN2RSMzVt?=
 =?utf-8?B?QWxZdzVVWWZYek9vUnp2c3ZNMGtHOUNiNExkd1NPRUxFZDdXTzE4c2J3emt5?=
 =?utf-8?B?RmNHN1J3Rm1hcmRpZkF4L0dyYURoeEU2YksyK3dKek1kSzJ6bGFtWUZYWG14?=
 =?utf-8?B?TGx3SlZwSit3WDJucUphVlhtR1ZxTGhaN2RtZFROdWRTY2FaTThNZTY5cWlL?=
 =?utf-8?B?dGhXYlZqMU5mNEpoTS9iVjhlNGFZRm5WaUpFZ2gzQkpBNmlSSXp1UE13dEdo?=
 =?utf-8?B?SWtTNE5GaUQ0cXVlMzN0RjNhbUY1TlhvSzd2WXFmS1hVTnRPdVdJT1ovTHUz?=
 =?utf-8?B?YkQrMzlld3ZzQVZlbkZBR090eU9qbkRPOG1vaGFCTUo0YTFCVUNWbWMvYzIv?=
 =?utf-8?B?bGFZazVya2lVY0dOK1FNY1hudklDc214ZDNZTTV2Nm8zYllvVThrZExkcFhz?=
 =?utf-8?B?QytOR0dIdzc3L1pJOUxyazFlZUZ2RGM1VzdkbWhiZVhYQ2tIRmNlNjM1cTVi?=
 =?utf-8?B?SmFFditXdGdCalhWZzZKK210RlhKdENYT29leFEzMGFsUTJ0MUNZRzd3NkVk?=
 =?utf-8?B?SmFieXhmOTF6R0IvdnVFcTc4dnd3bmYyamZaYU5XNi9EdHJQSzBqZDl6dGhJ?=
 =?utf-8?B?YmZKeFJMek9qcVJGbmZyblVuYVN1WDBKYXd4U2I5RU8vR0RKTkRmVnMzMVJJ?=
 =?utf-8?B?SklZYXFTZi9PUE9kenBldnFhbGsvKzU5VTdMNkkyQ2pBblliVUQvK2traEZ2?=
 =?utf-8?B?ZzdpU3IxcEhyT25EVDdLZ3RHUFkzSG5UdS9iM3NqUzhYSFZHVkppWFBqR2V2?=
 =?utf-8?B?VktwdlNYcVFSN1FaOGlHYW4zbTFrcVg2emhWUnFERFZ3ZHVUVEZEKzBnQ1FP?=
 =?utf-8?B?T1djbjV5TnJxLzl6YUVOTGEvazBkSWE0N3VPZjJVTVh0V2g4YXpSMS90REly?=
 =?utf-8?B?M1g3d2hKTGt2c2xOTU5uc0pWSW9KY3k4YmcyNHZRUWNzeHdpL24vUUFUd3Ni?=
 =?utf-8?B?NjBiOWFoUGZZMWhmYm5Ud3FXc3RWQklqTm9Id0E3NWFGQWRYN0t2SGtZLzNE?=
 =?utf-8?B?b0xFRmJmN054QlB3T2RLM0RubklKMFBwSjZNSVdobnpkbitjWFNVSWpjSDJN?=
 =?utf-8?B?Yml6MFBBalRScVp4RGxNaHlGQ1F3WVViWUtVVEJFRTdBaitKQ1NuamJPRnc0?=
 =?utf-8?B?ZGFFRmw0c3BJU2crZGQrN0JSK05OTTlFNGREVHE0OVJUdlc4VnBranE2Zk9X?=
 =?utf-8?B?SkJVZ2F1bk5hV0svUjY4VUNUZGhmWFpIOTN1bHVLOVdBUzd3VDhGdFRWbnov?=
 =?utf-8?B?VGYwOUxrVnFuRldXYmNKb2Nta2MxN04wcTAwWm5scHYwckxpaUpHOWxwdmcw?=
 =?utf-8?B?azlkZ1QzVXlHTFpyU29TRVB5RTF6OVhuYk0vamlTeU1WTEpGVkU2NGJkVEFI?=
 =?utf-8?B?a3dmYmZJZ25VMCs1Mk5pRk5mZVlyRnE2cVhDVEZZeVdFOWJ5SnZpYXdHRFZL?=
 =?utf-8?B?cTMvWmZKdmlyUS9WUk1rdHRkK1gyZWtXczJtNUhxRVAvdUJwMzZuZU1peTZU?=
 =?utf-8?B?dnRQY2ppb1N5QTN0VXN6c1hGT2xyTkpCRmwxZmFqTUw2YjRkM0pIT0srbm10?=
 =?utf-8?B?YTg4RVZMRFF5UHc5TzR5c1ZsMHd4STJIa1haZW5mdkxOMTBoUkQwRUFTTVJo?=
 =?utf-8?B?R1BNWXpuaXZmTjVNZkQwcjRQZzAzTUVVTFZVOHNta0JteXdiMEZ1RE5hckpm?=
 =?utf-8?B?N0E2SG5WcVZZQndidDdmeUN0Sm1xOWxYU1R5VGNya3FCZXlaenZWb3FvQmdH?=
 =?utf-8?B?SDhaM2RkdmpzQkZiRU42MGZOd1NzazZ4RlRYeTh3SkZ5bFJaclVkOWZ6b29P?=
 =?utf-8?B?ZXNlazdLK292RFYrOUszOS9CYk1nNkdHQjJLOXZkNUl3VWpxYS8rMTRQQmov?=
 =?utf-8?B?SXZVbC9RYlFwOUdFRmxkREhDaWFHWFVTQUVaQTIyUnk0ZHBpb3dKZGUxR0RJ?=
 =?utf-8?Q?rnZTOwKbY4K6N8PgeXA0XJqIW?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 12:41:10.2978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c051541c-8310-447a-97af-08de41576279
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6785

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
index f483e0c12444..7089a982b876 100644
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
index 000000000000..073b2fcfb2cc
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
index 000000000000..5a4d03b3d86f
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
index 000000000000..da92ef4d7310
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
index 0a85af610b6b..6cc557424e23 100644
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
2.49.0


