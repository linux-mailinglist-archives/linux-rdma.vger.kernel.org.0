Return-Path: <linux-rdma+bounces-9344-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF0AA84CBB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823A21883602
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF828EA7C;
	Thu, 10 Apr 2025 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OnR5TBU+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB66EB79;
	Thu, 10 Apr 2025 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312716; cv=fail; b=SPo5OW4qqODL+Zu6uf5b50MymLW2gAD3Pic+bzXzhi5iFx5sjSeaIK3QaYYi038i0oYul1vAeMYb69GLH+Y3Pq8QALSHtKW29TcXN33e158tQcE7ppMUTrB0xPB4iPLCzK8o02kPw5WkrBGFGJnr9BDGaLmsYmOXGz5GStxGtbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312716; c=relaxed/simple;
	bh=LAmnmsIA1hai4M05VLbUDxWybVmp9+iNV5U4Y+OTqqE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XhtKRCYVMYyCKBBs851aW3h/f9KOU6QKKQPO8nPK4GTsNNaF5eUo74WzUQf1L47pjyCb6oIs0nzsQ6SmdWqEQCLCb8QNH4X3s/OW/C7TOwF1Mgn8KsK++WuVhwvGyV9/cGEcfZQQ4AjvyKHtYyE9Tm3ynUGcAAdQTPHubeTlawI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OnR5TBU+; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rksLe83Yx8f3nG6z/LEKuM7FWixm6NxaoAurgv+iMloW9aZ6B7RMqz8h24sOkCKUiUG0HJiKt54RzvNh8yR0uxNkxYUA1qHgqBZCRabZ6yXVVtpQRj9gPx3qGIj7KOtd08g9dVeMhrwwTd38ySEa8nijbRsoniHZkgFO0u25SixTGNi+OLWmtaqL6TziWLa0ZQQLmZLXWpSikcwdEuGMk8pNE3iD+5TYzFLg3BpDbUFYaenvbkIjG8sJXUXZTSaL6WGb2b4oGvBhwPhQEAbgGcQ9p+Ww+XdQoGiJHGp2cWpLEw12Y1belPtEY3HzC6ZvT5nPKhfZitqYc2iyjBlmrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q6rJeeRcrOWLB6NFDlRtkm6UKNRagRe2WgDO4odvPg=;
 b=KxVT9VmyWwCrCWYOYaATHbSJCaxrxhc+8GDSUUznzgEG9sfjJXDQ0iwyYL1hn9sh8mAZCGXKNDkC/NjMOfUxYiHDPTxC6TkpyrkztmCB0HaERoAsTLL52Y2C8U/M5hL+QxgmDFXuwWoZ1SFIZgURlzbc0/BbgQPKnU0986V3/Hc79rUb+vuw4L4d09Wim9XbH55VLvuPh3NclW3KBqezThyVuU7pr7Hx04O5Zib5Rfpk2AAIHJBdxy0foWIu5r2UpC5+XxFecSxPHKsFYZwVetDd9qSS9miW+ggqhTlIPdmarTKaAW4pgJ833dUa/Ty/8CmXXpJXF27dLr6/sL7W0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q6rJeeRcrOWLB6NFDlRtkm6UKNRagRe2WgDO4odvPg=;
 b=OnR5TBU+ZhulBx88ju8s6Q7c/48lq0zf2fkVpu0xaHAt9c/rV3TDe7l/jW3yYKsUZVFH5F4to8HCA8LDK5ASZZTsy9ITvy7fG9BdJJolbYLXPfZOycCK0/JaKARuAz8yDhV9ymGqSiaXgkt55q3ea+6o9qkEeYPTAQy7AC2lwPGXv6J5kl1Q4yaAGvYEn5SOO7mKzJfcc0VbTHKHUA0dxNZc+5t7T5RjKrru7QFmLhq9BM2XDqfxkZzXWGOb91HebS1xLAQDxhfq2IVrNWvY55+nAtI9L1sitJUcrHOv9tchw9BczomcGAs42gNbJv5QYMwd/W+Qgltz746lMFtKIA==
Received: from SJ0PR03CA0273.namprd03.prod.outlook.com (2603:10b6:a03:39e::8)
 by MW6PR12MB9019.namprd12.prod.outlook.com (2603:10b6:303:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Thu, 10 Apr
 2025 19:18:26 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::cd) by SJ0PR03CA0273.outlook.office365.com
 (2603:10b6:a03:39e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.25 via Frontend Transport; Thu,
 10 Apr 2025 19:18:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:24 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 00/12] net/mlx5: HWS, Refactor action STE handling
Date: Thu, 10 Apr 2025 22:17:30 +0300
Message-ID: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|MW6PR12MB9019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4a184f-324d-4a14-8b61-08dd78647739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O3HuH2Fd9fD2crs8cx8Tn/PoO+V8J391tP1Vnb2WAc1dsjggiVQVHlVbw/Xe?=
 =?us-ascii?Q?PSvDs6bk3XYVGVgc6GiFqZDuBknlS4/dQDDui+Z3jh/owIFPalPvGk7H/u5z?=
 =?us-ascii?Q?2gHGRm0RV6NL7m5BrZDlj9oYywzBzjTtt8e/uwVGFisnzaQUqRJE4/8HUiha?=
 =?us-ascii?Q?kY69yufMbMJwXVStB2Aq4l8kxHu6ZuFizVD1Tl8/dYNILkstPU6sY5dLFFU6?=
 =?us-ascii?Q?mMdr83VibcY5lk10OfGvpQJ2lXe0FSDkp8icHSYfx5RXixhQWTEYLNZzHlnw?=
 =?us-ascii?Q?cAHx4tH3k6vcaqp6x2HPVcUkxIRsVc6QdyZillSC/hNEsXPzdrjmwMCShOXH?=
 =?us-ascii?Q?CdDkUxoYgmYMmxvR+8qE2YkN3Bpztx9wHSCeUnH4lkRk9vbirJwORpU/PltZ?=
 =?us-ascii?Q?kBd4/1nBjtFzWWXk/0XPO6R9bW/YBJBOVn+VrqkLtEr6tzKAek4JS1RbEAoX?=
 =?us-ascii?Q?i96ScTENsg/i+BZUbpepYumwYbNktmVaTxlP9w/sypOv1uP0T6OG8QZtTyHl?=
 =?us-ascii?Q?65bhhBjSeLRHzvgI+408QoCyGQxa71aEbBq3dxrsh3Bos6WLKc9j6Mjq2Hz2?=
 =?us-ascii?Q?H/It+9mhFQOiFsoUT3+EuOyBaehl09xRljoH7KJ3J3EL4Yr6zkigjYRYD/uD?=
 =?us-ascii?Q?K2WFGWLs18miP/t3fKmvgFH4A43rRrqhx34ckW7AH+C9T2bqTIi2V5bmPDc6?=
 =?us-ascii?Q?qSKeUbIB5HfbNrC1SEtN8/W+bGjUqfWpLa0xuRQAhZKLfUE5Xse46+Tvphe6?=
 =?us-ascii?Q?unr5I8wLJeeHfBJVH7aSnkjyyam1ruvGmTnzCXDvn/x4DfLg8n4pOVl/tZIN?=
 =?us-ascii?Q?exyU/o2H3JaN4gfE1T/VCHc++92DO2NFO3oZ/IeWZp63K8dcwdJd8cd12dT2?=
 =?us-ascii?Q?6tbq4Y73kMaqrgMlwaQLuHPVQuKO46UTAJ8+/FfELjDoF+6pRrJPyyIuRmXV?=
 =?us-ascii?Q?V+6dMTKZ4XF57F2OeOkwp81k6gnQiGm4a553C1QqxRCBGXhwOWXvECoid3lY?=
 =?us-ascii?Q?8M3zEzuAZi6diH2Q5QbiosiTkq1wkaOXBAWU3Od9lIkgzxCIQ5ry/kUZlWBz?=
 =?us-ascii?Q?vusS9CcDGUbhrbBTHiWrhpeVl2ueZrSLCjzOD+475WJcoEs0Suwhq+Vyw0ch?=
 =?us-ascii?Q?G34zwNEMpnhvvAS4MPpsbj93dCEuHOpjGsrqW7Cc4Ud8d7f35LTJVP7cOSyR?=
 =?us-ascii?Q?D+zp2KXWBUz3VmZZfcpdy3iuzMm1JuabDwX7RNCX0q6T63aeVoPbGJV0tPUP?=
 =?us-ascii?Q?Vob3K44Qiu1jNgrWZFYjzTNqhiUCqg+Liv2+Ax+kFsNTU6eoXXE/xOB6CvSL?=
 =?us-ascii?Q?qaax4NABPJzDc7xtOicGqm+K5QhxDc7GlPCQ6OrRFw6su/LokDCpu9EDeh7a?=
 =?us-ascii?Q?9ZTnbXU4TlvisB6p056Y2KBfNIcrwezMDowAzDpA2etcuL9aD9ui4eF1VBvM?=
 =?us-ascii?Q?/zuIkutxvpOyuVCFErrmmXIsU2xnFBQlrM3HdDvl4sDV7BtrfO+6L8BlrP/X?=
 =?us-ascii?Q?fL7dirLsImq+f3w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:24.7551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4a184f-324d-4a14-8b61-08dd78647739
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9019

This patch series by Vlad refactors how action STEs are handled for
hardware steering.

See detailed description by Vlad below.

Regards,
Tariq

V2:
- Remove always-zero ste_offset field (Michal Kubiak).
- Add review tags of Michal Kubiak.

Definitions
----------

* STE (Steering Table Entry): a building block for steering rules.
  Simple rules consist of a single STE that specifies both the match
  value and what actions to do. For more complex rules we have one or
  more match STEs that point to one or more action STEs. It is these
  action STEs which this patch series is primarily concerned with.

* RTC (Rule Table Context): a table that contains STEs. A matcher
  currently consists of a match RTC and, if necessary, an action RTC.
  This patch series decouples action RTCs from matchers and moves action
  RTCs to a central pool.

* Matcher: a logical container for steering rules. While the items above
  describe hardware concepts, a matcher is purely a software construct.

Current situation
-----------------

As mentioned above, a matcher currently consists of a match RTC (or
more, in case of complex matchers) and zero or one action STCs. An
action STC is only allocated if the matcher contains sufficiently
complicated action templates, or many actions.

When adding a rule, we decide based on its action template whether it
requires action STEs. If yes, we allocate the required number of action
STEs from the matcher's action STE.

When updating a rule, we need to prevent the rule ever being in an
invalid state. So we need to allocate and write new action STEs first,
then update the match STE to point to them, and finally release the old
action STEs. So there is a state when a rule needs double the action
STEs it normally uses.

Thus, for a given matcher of log_sz=N, log_action_ste_sz=A, the action
STC log_size is (N + A + 1). We need enough space to hold all the rules'
action STEs, and effectively double that space to account for the not
very common case of rules being updated. We could manage with much fewer
extra action STEs, but RTCs are allocated in powers of two. This results
in effective utilization of action RTCs of 50%, outside rule update
cases.

This is further complicated when resizing matchers. To avoid updating
all the rules to point to new match STEs, we keep existing action RTCs
around as resize_data, and only free them when the matcher is freed.

Action STE pool
---------------

This patch series decouples action RTCs from matchers by creating a
per-queue pool. When a rule needs to allocate action STEs it does so
from the pool, creating a new RTC if needed. During update two sets of
action STEs are in use, possibly from different RTCs.

The pool is sharded per-queue to avoid lock contention. Each per-queue
pool consists of 3 elements, corresponding to rx-only, tx-only and
rx-and-tx use cases. The series takes this approach because rules that
are bidirectional require that their action STEs have the same index in
the rx- and tx-RTCs, and using a single RTC would result in
unidirectional rules wasting the STEs for the unused direction.

Pool elements, in turn, consist of a list of RTCs. The driver
progressively allocates larger RTCs as they are needed to amortize the
cost of allocation.

Allocation of elements (STEs) inside RTCs is modelled by an existing
mechanism, somewhat confusingly also known as a pool. The first few
patches in the series refactor this abstraction to simplify it and adapt
it to the new schema.

Finally, this series implements periodic cleanup of unused action RTCs
as a new feature. Previously, once a matcher allocated an action RTC, it
would only be freed when the matcher is freed. This resulted in a lot of
wasted memory for matchers that had previously grown, but were now
mostly unused.

Conversely, action STE pools have a timestamp of when they were last
used. A cleanup routine periodically checks all pools. If a pool's last
usage was too far in the past, it is destroyed.

Benchmarks
----------

The test module creates a batch of (1 << 18) rules per queue and then
deletes them, in a loop. The rules are complex enough to require two
action STEs per rule.

Each queue is manipulated from a separate kernel workqueue, so there is
a 1:1 correspondence between threads and queues.

There are sleep statements between insert and delete batches so that
memory usage can be evaluated using `free -m`. The numbers below are the
diff between base memory usage (without the mlx5 module inserted) and
peak usage while running a test. The values are rounded to the nearest
hundred megabytes. The `queues` column lists how many queues the test
used.

queues          mem_before      mem_after
1               1300M            800M
4               4000M           2300M
8               7300M           3300M

Across all of the tests, insertion and deletion rates are the same
before and after these patches.

Summary of the patches
----------------------

* Patch 1: Fix matcher action template attach to avoid overrunning the
  buffer and correctly report errors.
* Patches 2-7: Cleanup the existing pool abstraction. Clarify semantics,
  and use cases, simplify API and callers.
* Patch 8: Implement the new action STE pool structure.
* Patch 9: Use the action STE pool when manipulating rules.
* Patch 10: Remove action RTC from matcher.
* Patch 11: Add logic to periodically check and free unused action RTCs.
* Patch 12: Export action STE tables in debugfs for our dump tool.

[PATCH 00/12] HWS: Refactor action STE handling
[PATCH 01/12] net/mlx5: HWS, Fix matcher action template attach
[PATCH 02/12] net/mlx5: HWS, Remove unused element array
[PATCH 03/12] net/mlx5: HWS, Make pool single resource
[PATCH 04/12] net/mlx5: HWS, Refactor pool implementation
[PATCH 05/12] net/mlx5: HWS, Cleanup after pool refactoring
[PATCH 06/12] net/mlx5: HWS, Add fullness tracking to pool
[PATCH 07/12] net/mlx5: HWS, Fix pool size optimization
[PATCH 08/12] net/mlx5: HWS, Implement action STE pool
[PATCH 09/12] net/mlx5: HWS, Use the new action STE pool
[PATCH 10/12] net/mlx5: HWS, Cleanup matcher action STE table
[PATCH 11/12] net/mlx5: HWS, Free unused action STE tables
[PATCH 12/12] net/mlx5: HWS, Export action STE tables to debugfs

Vlad Dogaru (12):
  net/mlx5: HWS, Fix matcher action template attach
  net/mlx5: HWS, Remove unused element array
  net/mlx5: HWS, Make pool single resource
  net/mlx5: HWS, Refactor pool implementation
  net/mlx5: HWS, Cleanup after pool refactoring
  net/mlx5: HWS, Add fullness tracking to pool
  net/mlx5: HWS, Fix pool size optimization
  net/mlx5: HWS, Implement action STE pool
  net/mlx5: HWS, Use the new action STE pool
  net/mlx5: HWS, Cleanup matcher action STE table
  net/mlx5: HWS, Free unused action STE tables
  net/mlx5: HWS, Export action STE tables to debugfs

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   3 +-
 .../mellanox/mlx5/core/steering/hws/action.c  |  56 +-
 .../mellanox/mlx5/core/steering/hws/action.h  |   8 +-
 .../mlx5/core/steering/hws/action_ste_pool.c  | 467 ++++++++++++++++
 .../mlx5/core/steering/hws/action_ste_pool.h  |  69 +++
 .../mellanox/mlx5/core/steering/hws/bwc.c     |  98 ++--
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   9 +-
 .../mellanox/mlx5/core/steering/hws/cmd.c     |   1 -
 .../mellanox/mlx5/core/steering/hws/cmd.h     |   1 -
 .../mellanox/mlx5/core/steering/hws/context.c |   8 +-
 .../mellanox/mlx5/core/steering/hws/context.h |   2 +
 .../mellanox/mlx5/core/steering/hws/debug.c   |  71 ++-
 .../mellanox/mlx5/core/steering/hws/debug.h   |   2 +
 .../mlx5/core/steering/hws/internal.h         |   1 +
 .../mellanox/mlx5/core/steering/hws/matcher.c | 420 ++++----------
 .../mellanox/mlx5/core/steering/hws/matcher.h |  26 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    | 515 +++++-------------
 .../mellanox/mlx5/core/steering/hws/pool.h    | 103 ++--
 .../mellanox/mlx5/core/steering/hws/rule.c    |  69 +--
 .../mellanox/mlx5/core/steering/hws/rule.h    |  12 +-
 20 files changed, 972 insertions(+), 969 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h


base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
-- 
2.31.1


