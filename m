Return-Path: <linux-rdma+bounces-9248-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42160A80D4E
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 708E43ADB84
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A81CB501;
	Tue,  8 Apr 2025 14:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8A3LJJ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B511C84CF;
	Tue,  8 Apr 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744120943; cv=fail; b=XzpNXmQshqNvtwk4G9i9v+MgPIl+a6OlmaAaLGBZmlwXiM0ZCl53SCZoXwIc2eW9QflC14jAbr9jQNq3ikdAlZF3R4od2fYtAe4dn/pXFLZB4H7xp/MTBjvF4A/DdL5NYbCeqksxHdxR8b2077Tndgs1vdrV+EkfnS/RUS1a4Eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744120943; c=relaxed/simple;
	bh=Obe38g4CtTKizd8H/YuFeJZxX9Ptx1UqpUkj37F7H78=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KurJ7tRokPoLoNzVlQHbmm9Zq3FXIDCI9lfkdQQhJir3Wy6ZPrtPTtdZl7Eju49H1gw+Mh5Q4NyWzOpW/vvi5r34eN5MjV5OaItdZX/45segDNVpLrdxp/dvB9r6FZWViqk+JBTpZy4s9Z8JvKL4txj8oGThA6layxplL1Sd66I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8A3LJJ1; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy8Uh/N5LJmdRuOzn7oNK4XTmvigGbzYtUtiXLvF/laERenWKdCrPtArnYhX3/2IX2fcM+FFv4pdJ46xpqKYPQHR967k9nn3xwZGYEMpXhVHAwv7w7jwwApTg0clLY7q25rBXhOixg5/UOAS4/AhzN3YX6iej5fWB3H0XAkFhS698eeOwNdvijI5zOiLhaSvxfd4VoRdWicJcTYwhYgMOSzJcwjtXVMlM7H63IlBP3JqQFi9YaMKuU7g3z9nhAPe8tQuMSVWl/2yPrEZUtjiTXLPtPMKbVyaCD6mbd9LcthHhJirotOt4XZC3PaKqUfvLbo2CJzypULv33FPC6Yagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7VRgc81jfiWYdDBrWJVokliq1EfIeSdbb7VDe5jaG0=;
 b=jFMpx5sJ+hCHPR6Ls/cqaQuAYoK1gz/d7xq41Y6XQiigrGGhKf6yrSkDnWIoYMSyKEZQtP0TWQSIJnOKNeA13g/w3bSgW2c5jmpAE3Fmc1R4U9j63hGFyVVjX5GpWqrUNVsiReiIqnn2GqhIXQDG5X0WOb8XxCE78I8Zj2nTZ6acAWc2Xe26lOWriEF6947jZxT/J4d+CCUBmHOcGxIMbzzDUrYwcfcWGtMm5py/Y7tXFOWQ3dKxd7OobWGs4AZa2lBrn8p9flsT3345g1r/Dq6aptZurapq2EAXbsR1MNnfPQ1+7F2++UGiBQ7NStPu2ushfgPr38JpUih7j8qnSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7VRgc81jfiWYdDBrWJVokliq1EfIeSdbb7VDe5jaG0=;
 b=e8A3LJJ1hkxDaRBL2TB+ZQK+CY3TOkVeNdjDnhXZQKfDc4KnA4YBmNsvB/bp32s9j23q7yOQWJpNo12qdTBpUGsootVxEN2imsQ84pSYbgrszbFcLxB0ucPg7hGtRPpfjpGVv6elH03N9BD6hGdq/O6sV5j37TXtQPQ0pKHHFJzeg9fiVjPMBCfqZF0n5HkyzQQW4RqoUVluzCoysSfZlE8BRV8M5gGnJVKnGLaPwr5xEvNefG3HNO5N28ZZRJ+aiBpXpYJnKZVcMO7uuGqX0nbhiktVGz+xpCemA6P2pIrSKCyhDHVpUCNChzsOnol7Bno3eQ4J5pbk+slNzi2QQg==
Received: from BN9PR03CA0895.namprd03.prod.outlook.com (2603:10b6:408:13c::30)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Tue, 8 Apr
 2025 14:02:18 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::52) by BN9PR03CA0895.outlook.office365.com
 (2603:10b6:408:13c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.35 via Frontend Transport; Tue,
 8 Apr 2025 14:02:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:02:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:01:59 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:01:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:01:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 00/12] net/mlx5: HWS, Refactor action STE handling
Date: Tue, 8 Apr 2025 17:00:44 +0300
Message-ID: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5b031f-996a-41fe-3fde-08dd76a5f938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2IrPoLpHKA1/2XmwVw5CoW9SWBxWwDaT8DL/ApelHFL0Uh6MJGynZVtdZCYH?=
 =?us-ascii?Q?VNC5ABjDp7M00NlFDdLvaKDg+LxIbwCfF3BvktBoRgxw2fKdVm1x3lx30tXQ?=
 =?us-ascii?Q?n21l4aTu89kSlftnmfuSxvyIbqR8IMmiR2Vn9w6ESOBGV1qqrkfLxlwTks9o?=
 =?us-ascii?Q?/DN8hD3WtgcQuBqVA+4RnuWqa0Yae2waToiXoQyER4EyaxckNCjx3WqSImZu?=
 =?us-ascii?Q?z7xiUWN12OUB5xV6tPPqBlOqXKnDtwcG0ITLV8HkXNhphrdafyx4JhfSqfhe?=
 =?us-ascii?Q?HSPTmuWg+Y6II2ZCKztLryhUsJmNeBLO26oOGkIk8/zQwvsyLeG5/b0ovA71?=
 =?us-ascii?Q?3QEPZKXJ7ZgNAlAVf7S+ZQM7aaAGewr9yFb940IJbjOWbRzQveD7zLd+4TfG?=
 =?us-ascii?Q?evgrbrvfGuIa4rXzcKBEihZoTzZ9fYZuHHQjcwlP12j7Vg+zYECM1xQpuZq+?=
 =?us-ascii?Q?/u1F63OcGxZb5+PyH+mmss7ZusgVXwQCt/UNza5WEqgp7kBl4x07rpYtRpgp?=
 =?us-ascii?Q?rod69zVS7M88B6SBBdZuFTABlYTdd5/uXLn8CzliOG3aznaGloPGNbTbCHpL?=
 =?us-ascii?Q?/+xHmBFesSBYqh8Esr49UWgRY71XUOyoSwxaMwLimtYUFfQwBlsqFLp+2PG+?=
 =?us-ascii?Q?T1p6lRS2G7MrcpGHqt0yr3LRTft+YnwWHqa4kp/mnSXFJ+OAG7CoWNdz+pui?=
 =?us-ascii?Q?pc9jSgC77BH3zvHjM3jC4LaTnTdwDfZNDuzZRFtZWE21b4xvMIIClQja/LMU?=
 =?us-ascii?Q?vkOukWk/AaDoxtwRKZ5vavX63UggzLKpBTkn+XVUg2/gTLLmFg8Ud1DZhzZI?=
 =?us-ascii?Q?wJTYNQnqR1uugirPQcU3wHO/iZkPsNEuWRYMygWUksaEfmbbEKW//9NDsTPz?=
 =?us-ascii?Q?LWzZOA6uZRQtHMzID8UkCBkVI0XhdBZeFQAj+ArNeeDhNhsH6xOOs//3fbRi?=
 =?us-ascii?Q?/6/6gfYJyn2+IdOkRxZSmyJijl4s/HmCwGNIxgDS9OTtPUS+1THPAljyhp+Y?=
 =?us-ascii?Q?zcVE6GY+a4QadCZ69KkBZGMfeR+Q79rou85iv9mGRWf42nUfpgj/CzazU1Mb?=
 =?us-ascii?Q?or1nkAopxy6DSdyAjxLDsbyDzi/OT20CP+mA9VnyiLPMLIsKM9OzyVjNWe7d?=
 =?us-ascii?Q?lZTzATJP0BqwACcgclNR6VQfk9P8mCrNPdCcHhAwKEJjBe5k/iZFyann7vAb?=
 =?us-ascii?Q?J6Y4JmUz4UOG9XGCbBNSl0KIX7P5vELSk82vpjrqbIXmntWXGnILqPw7QsBu?=
 =?us-ascii?Q?XsFNzl48vdMGp9i+9cnHwK/CwAD1RLGX1k+iHcZHEqeo75M3CqNyf49WKQy+?=
 =?us-ascii?Q?7rk4JI5BP5koVlBO6oQKBmDObYLxxHKZAjxQ1nfEmOQcxfPLSnRVxVlYbSzh?=
 =?us-ascii?Q?AO8LwK1YMVjUxeLpc/EQ40firUOIEtdJTmmBLDhCZLmz9WvGKMGz7s1qUVYu?=
 =?us-ascii?Q?qygl/9c+H9Jwbysil7wuhV8NALSNHu753Nzd1MevrixqhvC0BTW/82wiL2yw?=
 =?us-ascii?Q?JoLJ6CAwAtIfWNXJkaRN+fs4309+rKDDf1vh?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:02:17.7654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5b031f-996a-41fe-3fde-08dd76a5f938
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

This patch series by Vlad refactors how action STEs are handled for
hardware steering.

See detailed description by Vlad below.

Regards,
Tariq

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
 .../mellanox/mlx5/core/steering/hws/action.c  |  57 +-
 .../mellanox/mlx5/core/steering/hws/action.h  |   8 +-
 .../mlx5/core/steering/hws/action_ste_pool.c  | 468 ++++++++++++++++
 .../mlx5/core/steering/hws/action_ste_pool.h  |  69 +++
 .../mellanox/mlx5/core/steering/hws/bwc.c     |  98 ++--
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   9 +-
 .../mellanox/mlx5/core/steering/hws/context.c |   8 +-
 .../mellanox/mlx5/core/steering/hws/context.h |   2 +
 .../mellanox/mlx5/core/steering/hws/debug.c   |  71 ++-
 .../mellanox/mlx5/core/steering/hws/debug.h   |   2 +
 .../mlx5/core/steering/hws/internal.h         |   1 +
 .../mellanox/mlx5/core/steering/hws/matcher.c | 421 ++++----------
 .../mellanox/mlx5/core/steering/hws/matcher.h |  26 +-
 .../mellanox/mlx5/core/steering/hws/pool.c    | 515 +++++-------------
 .../mellanox/mlx5/core/steering/hws/pool.h    | 103 ++--
 .../mellanox/mlx5/core/steering/hws/rule.c    |  69 +--
 .../mellanox/mlx5/core/steering/hws/rule.h    |  12 +-
 18 files changed, 975 insertions(+), 967 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h


base-commit: 61f96e684edd28ca40555ec49ea1555df31ba619
-- 
2.31.1


