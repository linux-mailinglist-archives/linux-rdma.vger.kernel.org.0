Return-Path: <linux-rdma+bounces-10271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4021AB2A86
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DDEB7A3F58
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476025E45B;
	Sun, 11 May 2025 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b8mqKEfv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CEA1A08A6;
	Sun, 11 May 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992355; cv=fail; b=MPQ+CAjz8fk6J3D3Iwemukdzh4I2M3WXoHlLMR6Z3dqu2gdF67qMRuVSiNgLGZo+mFfkq2K72dr4zV5Zo8sX+U24dwJDSHmqBwEumhgkqA4iIMPB/tIELBJSD5K1Hf8DBGzW6dr7CCeBvfnzri2J+i0vl3rfGnIpDVVQIVjDsp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992355; c=relaxed/simple;
	bh=lcNU+aOHgnhj6DUKf4iES/r/xIc7Uu1FrVCn3VCKjis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cbXrrrcXamiJobBRIW6rVdqzWFVGXnKQOg6cBZlSz2wrVrLkDtoLdC4mRlLOrmnIjB+2I6zqjUVnn3nRbQ5s0poEiPM3YcL6S4KEvZjDVTiRz8Lj7Pt+JozP7nOgMVlMzd2jty6X/7wYkNlEfzpMxUPgn1d45h2d6jPIBPcuOaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b8mqKEfv; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhpaaG9UcDPYVl6IhuAwpTLZS1FszzMmY9tkzVqMC/ZM5361L5yZmW4pSoR/wxBTd0qeV6OKyWyhjGBwg3MgP1QpmCQUPVeQCeD10HV110zPd92upoGcxS3/aGusbVlNDLpCUZqbnWRupPfB2s0e5jJpC1qNKsDCofun1MVKqGzzlhKLmB3Xfb221t5mKRAq/ahZqHiLlTraTlKShicIOnR99MVs7HIitzDInGgxLHIIfH1sv+oHAgMPQEwjL089tGVLvIZ1w0eAstqqk4NnlUlUIuTrPHh0I3qTZs4ak5xMCf4snHxyXPzzAwKVe+Y96B1bdxqePjd6/lRJ/mZU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/nmM71hE3C0bJbUmB4anvOmxSFT1CYDqUXXFzh6grU=;
 b=CnSGLs3zCWGVzLWQPsqR3O2crZjrR3oIviMiJAUm4gxc68XtAzWZ2yrNt5RJ7ZWA/Povcwn5Qg4lZVvI7F6B+44mFkKhUOxk4C68DG/3ibyOmLumsupv+ENONGfx56yr3sobj8bSxckz3QtoZtRT+guBeldZCE8MFNxefwZVlBIkRU4vSXPc2qyOU4Gl4Y/Om2x4Nkb+5BlXbi085ippEFNvTZbOL13SK4k1ueNLng9sM6JR3cYaeZLCzHHkuRTnt6aW91V2QsQfuu/MW/o7JuK6sqWAPRoLfub78lrMBTPTEI9B4P0QrKh6EswuhCGKXsbylg6ZPhSeWV4G8/Onuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/nmM71hE3C0bJbUmB4anvOmxSFT1CYDqUXXFzh6grU=;
 b=b8mqKEfvUpwEwyeDMmRvuiNw23fHFQkawKrzWvHvgXgXO67X+DszcNAQMlCm8KA2bnG7LjeggCbxg6qexegoeeqcLO7D0s3E2H2tlX7vllMbZcy+NJsMMg6Y8uIHvRkEF8bTrKW01C2l8+EtLPAOAUF79joQao7EYAWCC3Zm9gUH+tZIEz3XsD2/vPxMqSnTJ8nYqmZ1jxNUXoLbGlC0XZQoW6e+ZHjh37UGh1kUdYDrwQpWDXodl16nlbE7bWk/2P5SdWGDeS6SF1xzTLSZI8lnXZgFfAQvLLN3uTLWOy9zuXjENRMd9O+iV7hhUwyOOKjP/iEg3vfw7rCO8fIGZQ==
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Sun, 11 May
 2025 19:39:09 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::eb) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Sun,
 11 May 2025 19:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:08 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:38:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next 00/10] net/mlx5: HWS, Complex Matchers and rehash mechanism fixes
Date: Sun, 11 May 2025 22:38:00 +0300
Message-ID: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: e3b1f1cb-6682-451c-c074-08dd90c37f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2xIbFY1cWIzdGVQSVV3ZmdRZUM4cFBFTm96UHdBQ2NwS0Q1VTB1YjI5Z0R4?=
 =?utf-8?B?RkFDZkQ4YmpsdlgwNXE1cXNNRzB2VERpQmY4a2dMYlIyWVJlYzRBRC92aHFk?=
 =?utf-8?B?VVdrbEUvWE9hZGJaRUY0N29YSTVIQ3ViRndyQU0xQis3R2dJWTBZRDFpS090?=
 =?utf-8?B?NU9YMElhYU1FOHZpcm1aRWNXc1BON3RBaFczcWU4ZUFZWFlPMVhueE04VXAx?=
 =?utf-8?B?QmVmTXozK3lOSE1GckZxdVNiQnNGRmIwSHpnS2QyN0hsdUxZS3hxZ0lZYUQv?=
 =?utf-8?B?LzZrVENIaGMzanJtN0s2VlhYRERQOWxna3gzNGRlMVZ5eFNjNEE2Y2FnNklS?=
 =?utf-8?B?d0QyM0ZoNCtGV3A0K1E4ejNKSW9USm1WNHF1ZnNHVGE1WnBWc0pKSWN5eW5D?=
 =?utf-8?B?Q3VkMHZXa0pWcUpWSEY4dEdtTGpQbVcrUTRXaWFPaEl6Y1ZNN2ttdjhWYVU2?=
 =?utf-8?B?dkNtTkVVcElrMWlHN1dNNGpkakh3ZWlyZHJ6eFJSRjF6bTBqaDQ2RUV6MEpp?=
 =?utf-8?B?c2hwQi9zMlB5dldabTRXM2ZSQ1ZOUTloa283bThUWlo4V1FTcjRKSWFvb3Ux?=
 =?utf-8?B?RmhOLzM5Nm40STNBdVFkRUNqSW5KY1RVNDZRZXFYNmhBYUwvQkVPbllnQ2wy?=
 =?utf-8?B?UllhZVFoRGk5VTZkZjIyM2h5TXUyemtvQnl1dUlsTnhLNnVSMys3ZThUZVNn?=
 =?utf-8?B?dFd0M1VydjRUdnpuSXdNc2ZsUTJQKzVKeTRrN1BSMUZFaEtQaXErMkprKzJj?=
 =?utf-8?B?Z3Z1TWphMDhjVUxDUGE2aFVBQTl1NVNubnVtekdWNTJ4ME10QUhDUE56MHQw?=
 =?utf-8?B?a3p3a0dEQWI2K0ZLS0RsRlZIcndvRXhDN2FtaHAwMlMvZnVYdTdWbUlVSks0?=
 =?utf-8?B?bzN1S25VZlpUK1hsaU5iRHljQ3h2SUkzM3BWOTVvVkZGVlMvbkpJdWpad3RL?=
 =?utf-8?B?ZnJic2lmeitRajcxTUZOYmJDam1QQzRmd0JXVXM0aVhxYmJEWjFmcFZiUTND?=
 =?utf-8?B?NFNKN0lQeHlDWlJ4bnBSUU5GeHljWDBBb0I4SHVFd1cydzhIa0hPRmN1cTl4?=
 =?utf-8?B?aUlGQmxKTjVnUW9rdG1ST0VuZEZubWFyQ3pZZGRKczBVbGNGS0tIWmM3REV6?=
 =?utf-8?B?U1lma09QcExUczRJYUQ4bVNFbUJUSGhYWkhMRjhsTFI0cnNCN1N1VXlPa2Vw?=
 =?utf-8?B?V2hiSXJNNFpObjNjSnNZdkgyOUlrV0taS0hmOXZmcXc0N3o4ZHNTVldieExV?=
 =?utf-8?B?NGljZ2h1OVhvRDc1eXJQdmJEY1ZmelpwMXBpVm92VkxrSTB5NUx0L3IzWlpx?=
 =?utf-8?B?VkZ1VTRwR1VSTmc5T21pcEFHbTdRVHNCSGUyLzlPUjVxUUsyUGlpU0tnUWoy?=
 =?utf-8?B?Z090a0VTYm5ocEJ4Mzl5SExPSmgySWFCdGUwS1hoUFRSVFpVMjBKL1BDV1Rm?=
 =?utf-8?B?a2YxL0hJWWNHL2JVdDVPVElyNXJOeUJBY1ZQcFA3VkVtbjFOTDh0alVqSytJ?=
 =?utf-8?B?R2ZNOGFsWDF5WjFrcDZndzBLN0xvRVlaeWlWUUIwRGszWkh5anMwTjNsRVB5?=
 =?utf-8?B?ZHVmQW0rVUE2MmxiOUwwU1pkdUMrTllVVnZ6eGVIVWdTY0pPT0lQcHlhZWFK?=
 =?utf-8?B?R2tlZElzVzF6Q1pKdWxJWWpuWlRKU2JGcTFFSERpS3Q3RCtPbklUR2M5YlRB?=
 =?utf-8?B?SGtDYXpsWk51U3d2WWh1R0hVSEJ4cDVXRXRSbkJVWU9VQW92QmF6SDFydDA2?=
 =?utf-8?B?bFR6dGFKb0N1cURrRlJpcitTaDdoTlFoTFd3NlZtVkRyN0JvUDJuS1dLSHQ5?=
 =?utf-8?B?NEgxNDNHbnJzWVFZdjdvbFhjV1RtZVkrMjE4bTY1elBQRlQvUFNrN2J4YzZQ?=
 =?utf-8?B?SFRsRmUycHdqYTA4RlRWb3NlTlZQeHNuUmNDY2UyK21OSXpESG1zd0JUQnlo?=
 =?utf-8?B?SlBTTGh5WllKK1NUelJ4VEVEMWtGbU0rSko5OE5jWUk4Z3F0YTlJaEFNaXJ2?=
 =?utf-8?B?UUZqZFllSW1ZZm9FRXYySnhJaFV4eHkrZUROakxRaUcxa3dvR2l2a1BPaGNh?=
 =?utf-8?Q?Cuy/CA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:08.3447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3b1f1cb-6682-451c-c074-08dd90c37f4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636

Hi,

This series by Yevgeny adds Hardware Steering support for Complex
Matchers/Rules (patches 1-5), and rehash mechanism fixes (patches 6-10).

See detailed descriptions by Yevgeny below [1][2].

Regards,
Tariq


[1]

Motivation:
----------

A matcher can match a certain set of match parameters. However,
the number and size of match params for a single matcher are
limited — all the parameters must fit within a single definer.

A common example of this limitation is IPv6 address matching, where
matching both source and destination IPs requires more bits than a
single definer can support.

SW Steering addresses this limitation by chaining multiple Steering
Table Entries (STEs) within the same matcher, where each STE matches
on a subset of the parameters.

In HW Steering, such chaining is not possible — the matcher's STEs
are managed in a hash table, and a single definer is used to calculate
the hash index for STEs.

Overview:
--------

To address this limitation in HW Steering, we introduce
*Complex Matchers*, which consist of two chained matchers. This allows
matching on twice as many parameters. Complex Matchers are filled with
*Complex Rules* — rules that are split into two parts and inserted into
their respective matchers.

The first half of the Complex Matcher is a regular matcher and points
to the second half, which is an *Isolated Matcher*. An Isolated Matcher
has its own isolated table and is accessible only by traffic coming
from the first half of the Complex Matcher.

This splitting of matchers/rules into multiple parts is transparent to
users. It is hidden behind the BWC HWS API. It becomes visible only
when dumping steering debug information, where the Complex Matcher
appears as two separate matchers: one in the user-created table and
another in its isolated table.

Implementation Details:
----------------------

All user actions are performed on the second part of the rules only.
The first part handles matching and applies two actions: modify header
(set metadata, see details below) and go-to-table (directing traffic
to the isolated table containing the isolated matcher).

Rule updates (updating rule actions) are applied to the second part
of the rule since user-provided actions are not executed in the first
matcher.

We use REG_C_6 metadata register to set and match on unique per-rule
tag (see details below).

Splitting rules into two parts introduces new challenges:

1. Invalid Combinations

   Consider two rules with different matching values:
   - Rule 1: A+B
   - Rule 2: C+D

   Let's split the rules into two parts as follows:

   |-----Complex Matcher-------|
   |                           |
   | 1st matcher   2nd matcher |
   |    |---|        |---|     |
   |    | A |        | B |     |
   |    |---| -----> |---|     |
   |    | C |        | D |     |
   |    |---|        |---|     |
   |                           |
   |---------------------------|

   Splitting these rules results in invalid combinations: A+D and C+B:
   any packet that matched on A will be forwarded to the 2nd matcher,
   where it will try to match on B (which is legal, and it is what the
   user asked for), but it will also try to match on D (which is not
   what the user asked for). To resolve this, we assign unique tags
   to each rule on the first matcher and match on these tags on the
   second matcher:

   |----------|     |---------|
   |     A    |     | B, TagA |
   | action:  |     |         |
   | set TagA |     |         |
   |----------| --> |---------|
   |     C    |     | D, TagB |
   | action:  |     |         |
   | set TagB |     |         |
   |----------|     |---------|

2. Duplicated Entries:

   Consider two rules with overlapping values:
   - Rule 1: A+B
   - Rule 2: A+D

   Let's split the rules into two parts as follows:

    |---|     |---|
    | A |     | B |
    |---| --> |---|
    |   |     | D |
    |---|     |---|

   This leads to the duplicated entries on the first matcher, which HWS
   doesn't allow: subsequent delete of either of the rules will delete
   the only entry in the first matcher, leaving the remaining rule
   broken. To address this, we use a reference count for entries in the
   first matcher and delete STEs only when their refcount reaches zero.

Both challenges are resolved by having a per-matcher data structure
(implemented with rhashtable) that manages refcounts for the first part
of the rules and holds unique tags (managed via IDA) for these rules to
set and to match on the second matcher.

Limitations:
-----------

We utilize metadata register REG_C_6 in this implementation, so its
usage anywhere along the flow that might include the need for Complex
Matcher is prohibited.

The number and size of match parameters remain limited — now
constrained by what can be represented by two definers instead of one.
This architectural limitation arises from the structure of Complex
Matchers. If future requirements demand more parameters, Complex
Matchers can be extended beyond two matchers.

Additionally, there is an implementation limit of 32 match parameters
per matcher (disregarding parameter size). This limit can be lifted
if needed.

Patches:
-------

 - Patches 1-3: small additions/refactoring in preparation for
   Complex Matcher: exposed mlx5hws_table_ft_set_next_ft() in header,
   added definer function to convert field name enum to string,
   expose the polling function mlx5hws_bwc_queue_poll() in a header.
 - Patch 4: in preparation for Complex Matcher, this patch adds
   support for Isolated Matcher.
 - Patch 5: the main patch - Complex Matchers implementation.


[2]

Patch 6: fixing the usecase where rule insertion was failing,
but rehash couldn't be initiated if the number of rules in
the table is below the rehash threshold.

Patch 7: fixing the usecase where many rules in parallel
would require rehash, due to the way the counting of rules
was done.

Patch 8: fixing the case where rules were requiring action
template extension in parallel, leading to unneeded extensions
with the same templates.

Patch 9: refactor and simplify the rehash loop.

Patch 10: dump error completion details, which helps a lot
in trying to understand what went wrong, especially during
rehash.


Yevgeny Kliteynik (10):
  net/mlx5: HWS, expose function mlx5hws_table_ft_set_next_ft in header
  net/mlx5: HWS, add definer function to get field name str
  net/mlx5: HWS, expose polling function in header file
  net/mlx5: HWS, introduce isolated matchers
  net/mlx5: HWS, support complex matchers
  net/mlx5: HWS, force rehash when rule insertion failed
  net/mlx5: HWS, fix counting of rules in the matcher
  net/mlx5: HWS, fix redundant extension of action templates
  net/mlx5: HWS, rework rehash loop
  net/mlx5: HWS, dump bad completion details

 .../mellanox/mlx5/core/steering/hws/bwc.c     |  330 ++--
 .../mellanox/mlx5/core/steering/hws/bwc.h     |   11 +
 .../mlx5/core/steering/hws/bwc_complex.c      | 1348 ++++++++++++++++-
 .../mlx5/core/steering/hws/bwc_complex.h      |   21 +
 .../mellanox/mlx5/core/steering/hws/definer.c |  212 +++
 .../mellanox/mlx5/core/steering/hws/definer.h |    2 +
 .../mellanox/mlx5/core/steering/hws/matcher.c |  278 +++-
 .../mellanox/mlx5/core/steering/hws/matcher.h |    9 +
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |    2 +
 .../mellanox/mlx5/core/steering/hws/send.c    |  122 +-
 .../mellanox/mlx5/core/steering/hws/send.h    |    1 +
 .../mellanox/mlx5/core/steering/hws/table.c   |   16 +-
 .../mellanox/mlx5/core/steering/hws/table.h   |    5 +
 13 files changed, 2178 insertions(+), 179 deletions(-)


base-commit: 0b28182c73a3d013bcabbb890dc1070a8388f55a
-- 
2.31.1


