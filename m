Return-Path: <linux-rdma+bounces-10278-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF95AB2A9B
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 21:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366BD3AAC82
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36071265CBF;
	Sun, 11 May 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tVTsU6T+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EEF2609F6;
	Sun, 11 May 2025 19:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746992389; cv=fail; b=TQgbNC4u7kgMMlLYJ6dPv8ufadvrZritaJGLooLFUZGrcoUjljec87DwIX4F6InLXF2RJDoeC1w6/BXobqYaYT4V0ANgQdPOO4YPjJTne210yrw75+TkxDRBNOqCO7F97qbV+HPhmSeHd6xNkSo3Xpg3bhrSyH+XzQWUdbCFDTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746992389; c=relaxed/simple;
	bh=7J4oRvKcnefCfDkor1ilGwIVHS7/IV9nKxx1R/lFjgk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fEC258+8oIe1j7fL2QEsQW++hBTLg7ZWU9YPCQTlzhK7OgFTucB3QJ1hz35R8oxk3Tn1Cy8oF7STyr5uwYmjI3PBj9c7/m/6HGZR/UMpWCjfToY1OcqSVo8VHiZnni+MchM4AR00MfK/FW/6q/crmcNP7Gw2gV0MLKBGU+sJZQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tVTsU6T+; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE1IBD8pINj0jo1uu3U+V2lzQwvxT0nxwp9FSAXpKrcnv6xXVrEOBE0z7fsOLtRWpL4ze2T7pA+hmFuUfCQ26VOBBbrRr6TpLsBfoKx/0Jhfq850EXLyyNGc94RvfB4PcZ9KuYHoI5cHUpGZyhdu2b2PvUYFMnmD6vks0ifqZqBWYcfN8FRbd837Z3bfjv8xQw+7wyPhWadWyt6v/v2sVP2AwFt7jgs85fjQKvyZQKMq415Lv7o9RGH+DI8NKPvhawLqWAieHRiyaI5cWGf4nrer/PsMCEFQtDo3JYTmHYvegkn1c10GInUqnbTynOhsKdo0hbOB7N2yFvIpIWU+mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2M1OgzgY/Oji4Q0VAerXLcFs9cBD8/biF6Q7j6R3hfE=;
 b=fDxmzKPy2rc3BtR49B4zSGLJwy2q1KEHnz3HiA7Iu+JhDC7M0uzDWGwPbhvrjXnZI3vviIHfkmeksgDGYgW/YbklcB1MpA7LqUDCkI8cJZAf1C0fMYWZTgcZBQavy+SCQ4s5H0Kgh6bmw3WmHSO2rwi2yQsy83ivSmpk7wFT+ysxNUbkbFpj/V5skok9r11+nJyJUs5C2m4Qb9jOwsb4Zf3Z8ciew6y1EySWNMa1112AIzJsBzCmfe/R1qbivZcBRTOibwsMigYtf1meaM7r4KBuV247rivu3ce3p7CexwJ0DQgjV7sDebqrFLQDURtpxzFZD4+6jNS3pvGvTfh2wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2M1OgzgY/Oji4Q0VAerXLcFs9cBD8/biF6Q7j6R3hfE=;
 b=tVTsU6T+UGU8PQ/4qLX197gWSfda5eq8HQl4wEHN2RUkIfxz2SrQKx+78fmH/CWHxPDfhRardF6bWgpjssFuMm/+Y9zG7aqi0zep5RDcjsOr6E8OEAHnAanwxgeQMRKf8peQDuX9qMqjTVL4LINgpy8eZvzW6zNSJg3gAy5GU/FHakX2WLw454/FWeGGGPBtTbH3fkWo0/TtN3v/BPCPRghWdhb+eKU7KE+B1Xp+PNoFL9tYD3/mE/bRvANHpsi3aLcOB71nph8mG0Nosu3AttFjZ2eycKYkWz2dgHVdMWzGATm+jp4XAQw3P7UlMpF5EUcAgB6F1upOtisdmbjYLA==
Received: from BY5PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:1d0::25)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Sun, 11 May
 2025 19:39:32 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3c) by BY5PR04CA0015.outlook.office365.com
 (2603:10b6:a03:1d0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.29 via Frontend Transport; Sun,
 11 May 2025 19:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 19:39:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 12:39:23 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 12:39:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 12:39:18 -0700
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
Subject: [PATCH net-next 05/10] net/mlx5: HWS, support complex matchers
Date: Sun, 11 May 2025 22:38:05 +0300
Message-ID: <1746992290-568936-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
References: <1746992290-568936-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: e75e46e7-a6bf-44bd-a0c3-08dd90c38cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkhCUWRrRWJIQUt6MFVsZ0JQWGJRMzhyMGloQll4S29ZekdXZFNROHlkMm05?=
 =?utf-8?B?ZEV2d3hrWHB0c1U5RTRXTXErM1Y5NmVybGVQbmVPSndkdUhOWkM2Q1I0K3h1?=
 =?utf-8?B?blVPRXI2TWlwVU9ZUlFob1ZqYVNpaVhsbHlKYldYZ1FOVnduNytJcWZ5RzFV?=
 =?utf-8?B?RHpFWnZHaEVRdzFSNGhrcGJ6aXUwVGVTT05wYzNQV2d6Ym5wcmp6SWhuY1ZK?=
 =?utf-8?B?enJWd20rVVA4REtCdmdsNkQrVWRtM2xtZ2ErQU51U3BHME5yQVBNMWV1YVlW?=
 =?utf-8?B?WUdBY3lpZS9hZWpJZTVHNW84V2ZaWWFRQVFYWit3VTRPNFpOSXJQU2F2TGlJ?=
 =?utf-8?B?QXFVTW8zQ0dZcGFhbTlrWmY0ai9JK0NveW9aZXZaZ0JENGFYS1lTeHc2VkNU?=
 =?utf-8?B?MHRZdjIyM1IxTGdkL2hNU1IxYTFXdmRaQWY2SldDcEJpT3A2Y3k2UTU5WFpK?=
 =?utf-8?B?QnljRHp4c1F3MTllVERud2ZBa29LamtMMGUycSthaUZ0SFFOZ1l4RUIrUzhO?=
 =?utf-8?B?ZmZtckN2Wm9BNDlyNnZxMDdYRVkzSHRuWjdheHVKWVVMbXJGMXZRbFJrSm12?=
 =?utf-8?B?Y2xuZHlSL0lkV2p0YVk0NU1IMjZ6NWZ2N3F5M3ZsZGdpVm1Iclo5c0V6Y2dN?=
 =?utf-8?B?MnBMVWptSGdVVmhSUk82TDdPaldDeEtaV2lrRkFYdTlDSTdFQTBacWJ6WUhU?=
 =?utf-8?B?Y0FqdUQyQUdlekoyZ3BzSmthYUUrQ0NHTHV1Rm5Oc2dnZ1NhSURqNFUvYmVL?=
 =?utf-8?B?UFpoaXlVSFFKZk1KT3pNY0MvT0E1b2JEZTVsckdMSnZ5NjJWRUNPOElOQzhi?=
 =?utf-8?B?Y2d1Z2lVTUJ4V0hQRm5sYWxITnJMMVl0MHU2SE13NGlKUWxiMWc5bWxwSXNv?=
 =?utf-8?B?MTlQMjQrVWk3QVliL0dYKzFuNlN2cklMZ2pMMkFFc3JJSHdrSnQrb2lTL29r?=
 =?utf-8?B?amhqcjlRRGhTSkZjSW9tL1ZTTXNhb2RLanc4b0dtbFAzd1ZVUUFDL2lJSkVY?=
 =?utf-8?B?MWZ1Z0xiRk84NXMyaE8zK3o0T2hFR1dFU1hJZ1I4Z1lOTVpLdGhzSFBYbkJM?=
 =?utf-8?B?UXVmcFpqdFJKL2EyNnFlUDFudUpPOHh5eFVTMDhrejdqK2k4dW05UjFmRHo0?=
 =?utf-8?B?SHQyYlhSVTZ6N01tMXVUWmFtditjNXRjT3RPVDZ1RHJCM3FyK082WWJBVDlX?=
 =?utf-8?B?dEVKeWRReFlUL2drVWpzckRIZmROd2xPSUJpK2plQ0ZRRlVaUVQ0TlUwV1po?=
 =?utf-8?B?ekJrQjNrMGRlcVJXaFU4ZGVqbm1nS1BocHJNVVVHTnUreUNiTEY3SXE2bDJJ?=
 =?utf-8?B?MjU4YUhUbzEvekZjZHBUU0wrUnJXR2V0Y21xNGF1clJCQ0NuYTF0VjBHblho?=
 =?utf-8?B?eW9Ga2RiWURnc2tqT3hNeHNlNk9INjVhYXczMjEzNUcxS2tRUjN4Tk4wV3RR?=
 =?utf-8?B?N3ZzVkNRQ3I5bHNzT2VOS01BaDlMNjNuV25mOEVRR0lqeDJrb1d6UTR1TEk0?=
 =?utf-8?B?ZjlzZ2NnWWEya25aTVlsbG1Iekc1WTZ3RjcwQXI5RUNCY1FnbGY4UFFISmUw?=
 =?utf-8?B?QkFXSTl2aWFCMWMxZWhUNitmbmRWejBKWFR5N1p0bGJ5LzZVZjBCL2x3RUtt?=
 =?utf-8?B?NVNIL0pkTkMycnViOUZneVV5UDk4UmdSUDlaN3l0bmtWRllXVXlNTEF2d1lw?=
 =?utf-8?B?R3c0dGNuOUlGb2tsRnkyMit2TEV4eEhUNW54RTY3OUkzR2QwVStLbkZaYkgw?=
 =?utf-8?B?aFQ3MlBVZURKbnkwT3VseDVNaWN1TnlPQjNuRkVCbVI0TnAwSnN5bE5Ba3c5?=
 =?utf-8?B?YmNTMi8wUUlxU2FWeUtLVjNjWGMrWjlna1lVcW9yY2lEd1RTRVNVNlpRaW5l?=
 =?utf-8?B?YWpURkl2dGZscXFPK0t0N1d3Ni9CSEs4dU9pMkVRM25ZRm5iZ2dBMFRLZzF1?=
 =?utf-8?B?dkhvSlAzM2pXVDd2SjZFa2N3SnV4dk9HUXk4QnFvRmpsQmYxWmtWTjE3cjFX?=
 =?utf-8?B?eThlR2RkbVpYTHZubE8yQlVJeU1vV0JkZEJkb3dwTTVKbERjaVYrTTRrM0xU?=
 =?utf-8?Q?ru+Arv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 19:39:31.1799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75e46e7-a6bf-44bd-a0c3-08dd90c38cd8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

This patch adds support for Complex Matchers/Rules

Overview:
--------

A matcher can match on a certain set of match parameters. However, the
number and size of match params for a single matcher are limited: all
the parameters must fit within a single definer.

A common example of this limitation is IPv6 address matching, where
matching both source and destination IPs requires more bits than a
single definer can support.

SW Steering addresses this limitation by chaining multiple Steering
Table Entries (STEs) within the same matcher, where each STE matches
on a subset of the parameters.

In HW Steering, such chaining is not possible — the matcher's STEs
are managed in a hash table, and a single definer is used to calculate
the hash index for STEs.

To address this limitation in HW Steering, we introduce Complex
Matchers, which consist of two chained matchers. This allows matching
on twice as many parameters. Complex Matchers are filled with Complex
Rules — rules that are split into two parts and inserted into their
respective matchers.

The first half of the Complex Matcher is a regular matcher and points
to the second half, which is an Isolated Matcher. An Isolated Matcher
has its own isolated table and is accessible only by traffic coming
from the first half of the Complex Matcher.

This splitting of matchers/rules into multiple parts is transparent to
users. It is hidden under the BWC HWS API. It becomes visible only when
dumping steering debug information, where the Complex Matcher appears
as two separate matchers: one in the user-created table and another
in its isolated table.

Some implementation details:
---------------------------

All user actions are performed on the second part of the rules only.
The first part handles matching and applies two actions: modify header
(set metadata, see details below) and go-to-table (directing traffic to
the isolated table containing the isolated matcher).

Rule updates (updating rule actions) are applied to the second part of
the rule since user-provided actions are not executed in the first
matcher.

We use REG_C_6 metadata register to set and match on unique per-rule
tag (see details below).

Splitting rules into two parts introduces new challenges:

1. Invalid Combinations

   Consider two rules with different matching values:
   - Rule 1: A+B
   - Rule 2: C+D

   Let's split the rules into two parts as follows:

   |---|     |---|
   | A |     | B |
   |---| --> |---|
   | C |     | D |
   |---|     |---|

   Splitting these rules results in invalid combinations like A+D
   and C+B.

   To resolve this, we assign unique tags to each rule on the first
   matcher and match these tags on the second matcher (the tag is
   implemented through modify_hdr action that sets value to metadata
   register REG_C_6):

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
   broken.

   To address this, we use a reference count for entries in the first
   matcher and delete STEs only when their refcount reaches zero.

Both challenges are resolved by having a per-matcher data structure
(implemented with rhashtable) that manages refcounts for the first part
of the rules and holds unique tags (managed via IDA) for these rules to
set and to match on the second matcher.

Limitations:
-----------

We utilize metadata register REG_C_6 in this implementation, so its
usage anywhere along the steering of the flow that might include the
need for Complex Matcher is prohibited.

The number and size of match parameters remain limited — now it is
constrained by what can be represented by two definers instead of one.
This architectural limitation arises from the structure of Complex
Matchers. If future requirements demand more parameters,
Complex Matchers can be extended beyond two matchers.

Additionally, there is an implementation limit of 32 match parameters
per rule (disregarding parameter size). This limit can be lifted if
needed.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     |   63 +-
 .../mellanox/mlx5/core/steering/hws/bwc.h     |    5 +
 .../mlx5/core/steering/hws/bwc_complex.c      | 1348 ++++++++++++++++-
 .../mlx5/core/steering/hws/bwc_complex.h      |   21 +
 4 files changed, 1410 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 27b6420678d8..d70db6948dbb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -46,10 +46,14 @@ static void hws_bwc_unlock_all_queues(struct mlx5hws_context *ctx)
 	}
 }
 
-static void hws_bwc_matcher_init_attr(struct mlx5hws_matcher_attr *attr,
+static void hws_bwc_matcher_init_attr(struct mlx5hws_bwc_matcher *bwc_matcher,
 				      u32 priority,
-				      u8 size_log)
+				      u8 size_log,
+				      struct mlx5hws_matcher_attr *attr)
 {
+	struct mlx5hws_bwc_matcher *first_matcher =
+		bwc_matcher->complex_first_bwc_matcher;
+
 	memset(attr, 0, sizeof(*attr));
 
 	attr->priority = priority;
@@ -61,6 +65,9 @@ static void hws_bwc_matcher_init_attr(struct mlx5hws_matcher_attr *attr,
 	attr->rule.num_log = size_log;
 	attr->resizable = true;
 	attr->max_num_of_at_attach = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
+
+	attr->isolated_matcher_end_ft_id =
+		first_matcher ? first_matcher->matcher->end_ft_id : 0;
 }
 
 int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
@@ -83,9 +90,10 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	for (i = 0; i < bwc_queues; i++)
 		INIT_LIST_HEAD(&bwc_matcher->rules[i]);
 
-	hws_bwc_matcher_init_attr(&attr,
+	hws_bwc_matcher_init_attr(bwc_matcher,
 				  priority,
-				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG);
+				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
+				  &attr);
 
 	bwc_matcher->priority = priority;
 	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
@@ -217,7 +225,10 @@ int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 			    "BWC matcher destroy: matcher still has %d rules\n",
 			    num_of_rules);
 
-	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
+	if (bwc_matcher->complex)
+		mlx5hws_bwc_matcher_destroy_complex(bwc_matcher);
+	else
+		mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
 
 	kfree(bwc_matcher);
 	return 0;
@@ -401,9 +412,13 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 
 int mlx5hws_bwc_rule_destroy(struct mlx5hws_bwc_rule *bwc_rule)
 {
-	int ret;
+	bool is_complex = !!bwc_rule->bwc_matcher->complex;
+	int ret = 0;
 
-	ret = mlx5hws_bwc_rule_destroy_simple(bwc_rule);
+	if (is_complex)
+		ret = mlx5hws_bwc_rule_destroy_complex(bwc_rule);
+	else
+		ret = mlx5hws_bwc_rule_destroy_simple(bwc_rule);
 
 	mlx5hws_bwc_rule_free(bwc_rule);
 	return ret;
@@ -692,7 +707,10 @@ static int hws_bwc_matcher_move_all_simple(struct mlx5hws_bwc_matcher *bwc_match
 
 static int hws_bwc_matcher_move_all(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	return hws_bwc_matcher_move_all_simple(bwc_matcher);
+	if (!bwc_matcher->complex)
+		return hws_bwc_matcher_move_all_simple(bwc_matcher);
+
+	return mlx5hws_bwc_matcher_move_all_complex(bwc_matcher);
 }
 
 static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
@@ -703,9 +721,10 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 	struct mlx5hws_matcher *new_matcher;
 	int ret;
 
-	hws_bwc_matcher_init_attr(&matcher_attr,
+	hws_bwc_matcher_init_attr(bwc_matcher,
 				  bwc_matcher->priority,
-				  bwc_matcher->size_log);
+				  bwc_matcher->size_log,
+				  &matcher_attr);
 
 	old_matcher = bwc_matcher->matcher;
 	new_matcher = mlx5hws_matcher_create(old_matcher->tbl,
@@ -910,11 +929,18 @@ mlx5hws_bwc_rule_create(struct mlx5hws_bwc_matcher *bwc_matcher,
 
 	bwc_queue_idx = hws_bwc_gen_queue_idx(ctx);
 
-	ret = mlx5hws_bwc_rule_create_simple(bwc_rule,
-					     params->match_buf,
-					     rule_actions,
-					     flow_source,
-					     bwc_queue_idx);
+	if (bwc_matcher->complex)
+		ret = mlx5hws_bwc_rule_create_complex(bwc_rule,
+						      params,
+						      flow_source,
+						      rule_actions,
+						      bwc_queue_idx);
+	else
+		ret = mlx5hws_bwc_rule_create_simple(bwc_rule,
+						     params->match_buf,
+						     rule_actions,
+						     flow_source,
+						     bwc_queue_idx);
 	if (unlikely(ret)) {
 		mlx5hws_bwc_rule_free(bwc_rule);
 		return NULL;
@@ -996,5 +1022,10 @@ int mlx5hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 		return -EINVAL;
 	}
 
-	return hws_bwc_rule_action_update(bwc_rule, rule_actions);
+	/* For complex rule, the update should happen on the second matcher */
+	if (bwc_rule->isolated_bwc_rule)
+		return hws_bwc_rule_action_update(bwc_rule->isolated_bwc_rule,
+						  rule_actions);
+	else
+		return hws_bwc_rule_action_update(bwc_rule, rule_actions);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index a2aa2d5da694..cf2b65146317 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -18,10 +18,13 @@
 
 #define MLX5HWS_BWC_POLLING_TIMEOUT 60
 
+struct mlx5hws_bwc_matcher_complex_data;
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
 	struct mlx5hws_action_template **at;
+	struct mlx5hws_bwc_matcher_complex_data *complex;
+	struct mlx5hws_bwc_matcher *complex_first_bwc_matcher;
 	u8 num_of_at;
 	u8 size_of_at_array;
 	u8 size_log;
@@ -33,6 +36,8 @@ struct mlx5hws_bwc_matcher {
 struct mlx5hws_bwc_rule {
 	struct mlx5hws_bwc_matcher *bwc_matcher;
 	struct mlx5hws_rule *rule;
+	struct mlx5hws_bwc_rule *isolated_bwc_rule;
+	struct mlx5hws_bwc_complex_rule_hash_node *complex_hash_node;
 	u16 bwc_queue_idx;
 	struct list_head list_node;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
index 9fb059a6511f..5d30c5b094fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.c
@@ -3,6 +3,22 @@
 
 #include "internal.h"
 
+#define HWS_CLEAR_MATCH_PARAM(mask, field) \
+	MLX5_SET(fte_match_param, (mask)->match_buf, field, 0)
+
+#define HWS_SZ_MATCH_PARAM (MLX5_ST_SZ_DW_MATCH_PARAM * 4)
+
+static const struct rhashtable_params hws_refcount_hash = {
+	.key_len = sizeof_field(struct mlx5hws_bwc_complex_rule_hash_node,
+				match_buf),
+	.key_offset = offsetof(struct mlx5hws_bwc_complex_rule_hash_node,
+			       match_buf),
+	.head_offset = offsetof(struct mlx5hws_bwc_complex_rule_hash_node,
+				hash_node),
+	.automatic_shrinking = true,
+	.min_size = 1,
+};
+
 bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 					 u8 match_criteria_enable,
 					 struct mlx5hws_match_parameters *mask)
@@ -48,20 +64,1078 @@ bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 	return is_complex;
 }
 
+static void
+hws_bwc_matcher_complex_params_clear_fld(struct mlx5hws_context *ctx,
+					 enum mlx5hws_definer_fname fname,
+					 struct mlx5hws_match_parameters *mask)
+{
+	struct mlx5hws_cmd_query_caps *caps = ctx->caps;
+
+	switch (fname) {
+	case MLX5HWS_DEFINER_FNAME_ETH_TYPE_O:
+	case MLX5HWS_DEFINER_FNAME_ETH_TYPE_I:
+	case MLX5HWS_DEFINER_FNAME_ETH_L3_TYPE_O:
+	case MLX5HWS_DEFINER_FNAME_ETH_L3_TYPE_I:
+	case MLX5HWS_DEFINER_FNAME_IP_VERSION_O:
+	case MLX5HWS_DEFINER_FNAME_IP_VERSION_I:
+		/* Because of the strict requirements for IP address matching
+		 * that require ethtype/ip_version matching as well, don't clear
+		 * these fields - have them in both parts of the complex matcher
+		 */
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.smac_47_16);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.smac_47_16);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.smac_15_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.smac_15_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.dmac_47_16);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.dmac_47_16);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.dmac_15_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.dmac_15_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_TYPE_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.cvlan_tag);
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.svlan_tag);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_TYPE_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.cvlan_tag);
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.svlan_tag);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_FIRST_PRIO_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.first_prio);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_FIRST_PRIO_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.first_prio);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_CFI_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.first_cfi);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_CFI_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.first_cfi);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_ID_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.first_vid);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_ID_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.first_vid);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_TYPE_O:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.outer_second_cvlan_tag);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.outer_second_svlan_tag);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_TYPE_I:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.inner_second_cvlan_tag);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.inner_second_svlan_tag);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_PRIO_O:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.outer_second_prio);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_PRIO_I:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.inner_second_prio);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_CFI_O:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.outer_second_cfi);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_CFI_I:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.inner_second_cfi);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_ID_O:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.outer_second_vid);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VLAN_SECOND_ID_I:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.inner_second_vid);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV4_IHL_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ipv4_ihl);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV4_IHL_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ipv4_ihl);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_DSCP_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ip_dscp);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_DSCP_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ip_dscp);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_ECN_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ip_ecn);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_ECN_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ip_ecn);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_TTL_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ttl_hoplimit);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_TTL_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ttl_hoplimit);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV4_DST_O:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV4_SRC_O:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV4_DST_I:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV4_SRC_I:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_FRAG_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.frag);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_FRAG_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.frag);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV6_FLOW_LABEL_O:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.outer_ipv6_flow_label);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV6_FLOW_LABEL_I:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.inner_ipv6_flow_label);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_O:
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_O:
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_O:
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_O:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_95_64);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_63_32);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_O:
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_O:
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_O:
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_O:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_95_64);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_63_32);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      outer_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_I:
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_I:
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_I:
+	case MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_I:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_127_96);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_95_64);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_63_32);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.dst_ipv4_dst_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_I:
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_I:
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_I:
+	case MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_I:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_127_96);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_95_64);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_63_32);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      inner_headers.src_ipv4_src_ipv6.ipv6_simple_layout.ipv6_31_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_PROTOCOL_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.ip_protocol);
+		break;
+	case MLX5HWS_DEFINER_FNAME_IP_PROTOCOL_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.ip_protocol);
+		break;
+	case MLX5HWS_DEFINER_FNAME_L4_SPORT_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.tcp_sport);
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.udp_sport);
+		break;
+	case MLX5HWS_DEFINER_FNAME_L4_SPORT_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.tcp_dport);
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.udp_dport);
+		break;
+	case MLX5HWS_DEFINER_FNAME_L4_DPORT_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.tcp_dport);
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.udp_dport);
+		break;
+	case MLX5HWS_DEFINER_FNAME_L4_DPORT_I:
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.tcp_dport);
+		HWS_CLEAR_MATCH_PARAM(mask, inner_headers.udp_dport);
+		break;
+	case MLX5HWS_DEFINER_FNAME_TCP_FLAGS_O:
+		HWS_CLEAR_MATCH_PARAM(mask, outer_headers.tcp_flags);
+		break;
+	case MLX5HWS_DEFINER_FNAME_TCP_ACK_NUM:
+	case MLX5HWS_DEFINER_FNAME_TCP_SEQ_NUM:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.outer_tcp_seq_num);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.outer_tcp_ack_num);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.inner_tcp_seq_num);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.inner_tcp_ack_num);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GTP_TEID:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_teid);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GTP_MSG_TYPE:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_msg_type);
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_msg_flags);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GTPU_FIRST_EXT_DW0:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.gtpu_first_ext_dw_0);
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_dw_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GTPU_DW2:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.gtpu_dw_2);
+		break;
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_0:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_1:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_2:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_3:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_4:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_5:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_6:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER_7:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_2.outer_first_mpls_over_gre);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_2.outer_first_mpls_over_udp);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.geneve_tlv_option_0_data);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_4.prog_sample_field_id_0);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_4.prog_sample_field_value_0);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_4.prog_sample_field_value_1);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_4.prog_sample_field_id_2);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_4.prog_sample_field_value_2);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_4.prog_sample_field_id_3);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_4.prog_sample_field_value_3);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VXLAN_VNI:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.vxlan_vni);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_FLAGS:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.outer_vxlan_gpe_flags);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_RSVD0:
+		break;
+	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_PROTO:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.outer_vxlan_gpe_next_protocol);
+		break;
+	case MLX5HWS_DEFINER_FNAME_VXLAN_GPE_VNI:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.outer_vxlan_gpe_vni);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GENEVE_OPT_LEN:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.geneve_opt_len);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GENEVE_OAM:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.geneve_oam);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GENEVE_PROTO:
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.geneve_protocol_type);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GENEVE_VNI:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.geneve_vni);
+		break;
+	case MLX5HWS_DEFINER_FNAME_SOURCE_QP:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.source_sqn);
+		break;
+	case MLX5HWS_DEFINER_FNAME_SOURCE_GVMI:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.source_port);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.source_eswitch_owner_vhca_id);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_0:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_1:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_1);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_2:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_2);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_3:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_3);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_4:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_4);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_5:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_5);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_7:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_c_7);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_A:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.metadata_reg_a);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GRE_C:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_c_present);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GRE_K:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_k_present);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GRE_S:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_s_present);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GRE_PROTOCOL:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_protocol);
+		break;
+	case MLX5HWS_DEFINER_FNAME_GRE_OPT_KEY:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters.gre_key.key);
+		break;
+	case MLX5HWS_DEFINER_FNAME_ICMP_DW1:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmp_header_data);
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmp_type);
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmp_code);
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters_3.icmpv6_header_data);
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmpv6_type);
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_3.icmpv6_code);
+		break;
+	case MLX5HWS_DEFINER_FNAME_MPLS0_O:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.outer_first_mpls);
+		break;
+	case MLX5HWS_DEFINER_FNAME_MPLS0_I:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_2.inner_first_mpls);
+		break;
+	case MLX5HWS_DEFINER_FNAME_TNL_HDR_0:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_0);
+		break;
+	case MLX5HWS_DEFINER_FNAME_TNL_HDR_1:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_1);
+		break;
+	case MLX5HWS_DEFINER_FNAME_TNL_HDR_2:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_2);
+		break;
+	case MLX5HWS_DEFINER_FNAME_TNL_HDR_3:
+		HWS_CLEAR_MATCH_PARAM(mask, misc_parameters_5.tunnel_header_3);
+		break;
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER0_OK:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER1_OK:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER2_OK:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER3_OK:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER4_OK:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER5_OK:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER6_OK:
+	case MLX5HWS_DEFINER_FNAME_FLEX_PARSER7_OK:
+		/* assuming this is flex parser for geneve option */
+		if ((fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER0_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 0) ||
+		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER1_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 1) ||
+		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER2_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 2) ||
+		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER3_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 3) ||
+		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER4_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 4) ||
+		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER5_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 5) ||
+		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER6_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 6) ||
+		    (fname == MLX5HWS_DEFINER_FNAME_FLEX_PARSER7_OK &&
+		     ctx->caps->flex_parser_id_geneve_tlv_option_0 != 7)) {
+			mlx5hws_err(ctx,
+				    "Complex params: unsupported field %s (%d), flex parser ID for geneve is %d\n",
+				    mlx5hws_definer_fname_to_str(fname), fname,
+				    caps->flex_parser_id_geneve_tlv_option_0);
+			break;
+		}
+		HWS_CLEAR_MATCH_PARAM(mask,
+				      misc_parameters.geneve_tlv_option_0_exist);
+		break;
+	case MLX5HWS_DEFINER_FNAME_REG_6:
+	default:
+		mlx5hws_err(ctx, "Complex params: unsupported field %s (%d)\n",
+			    mlx5hws_definer_fname_to_str(fname), fname);
+		break;
+	}
+}
+
+static bool
+hws_bwc_matcher_complex_params_comb_is_valid(struct mlx5hws_definer_fc *fc,
+					     int fc_sz,
+					     u32 combination_num)
+{
+	bool m1[MLX5HWS_DEFINER_FNAME_MAX] = {0};
+	bool m2[MLX5HWS_DEFINER_FNAME_MAX] = {0};
+	bool is_first_matcher;
+	int i;
+
+	for (i = 0; i < fc_sz; i++) {
+		is_first_matcher = !(combination_num & BIT(i));
+		if (is_first_matcher)
+			m1[fc[i].fname] = true;
+		else
+			m2[fc[i].fname] = true;
+	}
+
+	/* Not all the fields can be split into separate matchers.
+	 * Some should be together on the same matcher.
+	 * For example, IPv6 parts - the whole IPv6 address should be on the
+	 * same matcher in order for us to deduce if it's IPv6 or IPv4 address.
+	 */
+	if (m1[MLX5HWS_DEFINER_FNAME_IP_FRAG_O] &&
+	    (m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_O]))
+		return false;
+
+	if (m2[MLX5HWS_DEFINER_FNAME_IP_FRAG_O] &&
+	    (m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_O]))
+		return false;
+
+	if (m1[MLX5HWS_DEFINER_FNAME_IP_FRAG_I] &&
+	    (m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_I]))
+		return false;
+
+	if (m2[MLX5HWS_DEFINER_FNAME_IP_FRAG_I] &&
+	    (m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_47_16_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_ETH_SMAC_15_0_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_47_16_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_ETH_DMAC_15_0_I]))
+		return false;
+
+	/* Don't split outer IPv6 dest address. */
+	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_O]) &&
+	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_O]))
+		return false;
+
+	/* Don't split outer IPv6 source address. */
+	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_O] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_O]) &&
+	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_O] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_O]))
+		return false;
+
+	/* Don't split inner IPv6 dest address. */
+	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_I]) &&
+	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_127_96_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_95_64_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_63_32_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_DST_31_0_I]))
+		return false;
+
+	/* Don't split inner IPv6 source address. */
+	if ((m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_I] ||
+	     m1[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_I]) &&
+	    (m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_127_96_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_95_64_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_63_32_I] ||
+	     m2[MLX5HWS_DEFINER_FNAME_IPV6_SRC_31_0_I]))
+		return false;
+
+	/* Don't split GRE parameters. */
+	if ((m1[MLX5HWS_DEFINER_FNAME_GRE_C] ||
+	     m1[MLX5HWS_DEFINER_FNAME_GRE_K] ||
+	     m1[MLX5HWS_DEFINER_FNAME_GRE_S] ||
+	     m1[MLX5HWS_DEFINER_FNAME_GRE_PROTOCOL]) &&
+	    (m2[MLX5HWS_DEFINER_FNAME_GRE_C] ||
+	     m2[MLX5HWS_DEFINER_FNAME_GRE_K] ||
+	     m2[MLX5HWS_DEFINER_FNAME_GRE_S] ||
+	     m2[MLX5HWS_DEFINER_FNAME_GRE_PROTOCOL]))
+		return false;
+
+	/* Don't split TCP ack/seq numbers. */
+	if ((m1[MLX5HWS_DEFINER_FNAME_TCP_ACK_NUM] ||
+	     m1[MLX5HWS_DEFINER_FNAME_TCP_SEQ_NUM]) &&
+	    (m2[MLX5HWS_DEFINER_FNAME_TCP_ACK_NUM] ||
+	     m2[MLX5HWS_DEFINER_FNAME_TCP_SEQ_NUM]))
+		return false;
+
+	/* Don't split flex parser. */
+	if ((m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_0] ||
+	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_1] ||
+	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_2] ||
+	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_3] ||
+	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_4] ||
+	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_5] ||
+	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_6] ||
+	     m1[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_7]) &&
+	    (m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_0] ||
+	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_1] ||
+	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_2] ||
+	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_3] ||
+	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_4] ||
+	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_5] ||
+	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_6] ||
+	     m2[MLX5HWS_DEFINER_FNAME_FLEX_PARSER_7]))
+		return false;
+
+	return true;
+}
+
+static void
+hws_bwc_matcher_complex_params_comb_create(struct mlx5hws_context *ctx,
+					   struct mlx5hws_match_parameters *m,
+					   struct mlx5hws_match_parameters *m1,
+					   struct mlx5hws_match_parameters *m2,
+					   struct mlx5hws_definer_fc *fc,
+					   int fc_sz,
+					   u32 combination_num)
+{
+	bool is_first_matcher;
+	int i;
+
+	memcpy(m1->match_buf, m->match_buf, m->match_sz);
+	memcpy(m2->match_buf, m->match_buf, m->match_sz);
+
+	for (i = 0; i < fc_sz; i++) {
+		is_first_matcher = !(combination_num & BIT(i));
+		hws_bwc_matcher_complex_params_clear_fld(ctx,
+							 fc[i].fname,
+							 is_first_matcher ?
+							 m2 : m1);
+	}
+
+	MLX5_SET(fte_match_param, m2->match_buf,
+		 misc_parameters_2.metadata_reg_c_6, -1);
+}
+
+static void
+hws_bwc_matcher_complex_params_destroy(struct mlx5hws_match_parameters *mask_1,
+				       struct mlx5hws_match_parameters *mask_2)
+{
+	kfree(mask_1->match_buf);
+	kfree(mask_2->match_buf);
+}
+
+static int
+hws_bwc_matcher_complex_params_create(struct mlx5hws_context *ctx,
+				      u8 match_criteria,
+				      struct mlx5hws_match_parameters *mask,
+				      struct mlx5hws_match_parameters *mask_1,
+				      struct mlx5hws_match_parameters *mask_2)
+{
+	struct mlx5hws_definer_fc *fc;
+	u32 num_of_combinations;
+	int fc_sz = 0;
+	int res = 0;
+	u32 i;
+
+	if (MLX5_GET(fte_match_param, mask->match_buf,
+		     misc_parameters_2.metadata_reg_c_6)) {
+		mlx5hws_err(ctx, "Complex matcher: REG_C_6 matching is reserved\n");
+		res = -EINVAL;
+		goto out;
+	}
+
+	mask_1->match_buf = kzalloc(MLX5_ST_SZ_BYTES(fte_match_param),
+				    GFP_KERNEL);
+	mask_2->match_buf = kzalloc(MLX5_ST_SZ_BYTES(fte_match_param),
+				    GFP_KERNEL);
+	if (!mask_1->match_buf || !mask_2->match_buf) {
+		mlx5hws_err(ctx, "Complex matcher: failed to allocate match_param\n");
+		res = -ENOMEM;
+		goto free_params;
+	}
+
+	mask_1->match_sz = mask->match_sz;
+	mask_2->match_sz = mask->match_sz;
+
+	fc = mlx5hws_definer_conv_match_params_to_compressed_fc(ctx,
+								match_criteria,
+								mask->match_buf,
+								&fc_sz);
+	if (!fc) {
+		res = -ENOMEM;
+		goto free_params;
+	}
+
+	if (fc_sz >= sizeof(num_of_combinations) * BITS_PER_BYTE) {
+		mlx5hws_err(ctx,
+			    "Complex matcher: too many match parameters (%d)\n",
+			    fc_sz);
+		res = -EINVAL;
+		goto free_fc;
+	}
+
+	/* We have list of all the match fields from the match parameter.
+	 * Now try all the possibilities of splitting them into two match
+	 * buffers and look for the supported combination.
+	 */
+	num_of_combinations = 1 << fc_sz;
+
+	/* Start from combination at index 1 - we know that 0 is unsupported */
+	for (i = 1; i < num_of_combinations; i++) {
+		if (!hws_bwc_matcher_complex_params_comb_is_valid(fc, fc_sz, i))
+			continue;
+
+		hws_bwc_matcher_complex_params_comb_create(ctx,
+							   mask, mask_1, mask_2,
+							   fc, fc_sz, i);
+		/* We now have two separate sets of match params.
+		 * Check if each of them can be used in its own matcher.
+		 */
+		if (!mlx5hws_bwc_match_params_is_complex(ctx,
+							 match_criteria,
+							 mask_1) &&
+		    !mlx5hws_bwc_match_params_is_complex(ctx,
+							 match_criteria,
+							 mask_2))
+			break;
+	}
+
+	if (i == num_of_combinations) {
+		/* We've scanned all the combinations, but to no avail */
+		mlx5hws_err(ctx, "Complex matcher: couldn't find match params combination\n");
+		res = -EINVAL;
+		goto free_fc;
+	}
+
+	kfree(fc);
+	return 0;
+
+free_fc:
+	kfree(fc);
+free_params:
+	hws_bwc_matcher_complex_params_destroy(mask_1, mask_2);
+out:
+	return res;
+}
+
+static int
+hws_bwc_isolated_table_create(struct mlx5hws_bwc_matcher *bwc_matcher,
+			      struct mlx5hws_table *table)
+{
+	struct mlx5hws_cmd_ft_modify_attr ft_attr = {0};
+	struct mlx5hws_context *ctx = table->ctx;
+	struct mlx5hws_table_attr tbl_attr = {0};
+	struct mlx5hws_table *isolated_tbl;
+	int ret = 0;
+
+	tbl_attr.type = table->type;
+	tbl_attr.level = table->level;
+
+	bwc_matcher->complex->isolated_tbl =
+		mlx5hws_table_create(ctx, &tbl_attr);
+	isolated_tbl = bwc_matcher->complex->isolated_tbl;
+	if (!isolated_tbl)
+		return -EINVAL;
+
+	/* Set the default miss of the isolated table to
+	 * point to the end anchor of the original matcher.
+	 */
+	mlx5hws_cmd_set_attr_connect_miss_tbl(ctx,
+					      isolated_tbl->fw_ft_type,
+					      isolated_tbl->type,
+					      &ft_attr);
+	ft_attr.table_miss_id = bwc_matcher->matcher->end_ft_id;
+
+	ret = mlx5hws_cmd_flow_table_modify(ctx->mdev,
+					    &ft_attr,
+					    isolated_tbl->ft_id);
+	if (ret) {
+		mlx5hws_err(ctx, "Failed setting isolated tbl default miss\n");
+		goto destroy_tbl;
+	}
+
+	return 0;
+
+destroy_tbl:
+	mlx5hws_table_destroy(isolated_tbl);
+	return ret;
+}
+
+static void hws_bwc_isolated_table_destroy(struct mlx5hws_table *isolated_tbl)
+{
+	/* This table is isolated - no table is pointing to it, no need to
+	 * disconnect it from anywhere, it won't affect any other table's miss.
+	 */
+	mlx5hws_table_destroy(isolated_tbl);
+}
+
+static int
+hws_bwc_isolated_matcher_create(struct mlx5hws_bwc_matcher *bwc_matcher,
+				struct mlx5hws_table *table,
+				u8 match_criteria_enable,
+				struct mlx5hws_match_parameters *mask)
+{
+	struct mlx5hws_table *isolated_tbl = bwc_matcher->complex->isolated_tbl;
+	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
+	struct mlx5hws_context *ctx = table->ctx;
+	int ret;
+
+	isolated_bwc_matcher = kzalloc(sizeof(*bwc_matcher), GFP_KERNEL);
+	if (!isolated_bwc_matcher)
+		return -ENOMEM;
+
+	bwc_matcher->complex->isolated_bwc_matcher = isolated_bwc_matcher;
+
+	/* Isolated BWC matcher needs access to the first BWC matcher */
+	isolated_bwc_matcher->complex_first_bwc_matcher = bwc_matcher;
+
+	/* Isolated matcher needs to match on REG_C_6,
+	 * so make sure its criteria bit is on.
+	 */
+	match_criteria_enable |= MLX5HWS_DEFINER_MATCH_CRITERIA_MISC2;
+
+	ret = mlx5hws_bwc_matcher_create_simple(isolated_bwc_matcher,
+						isolated_tbl,
+						0,
+						match_criteria_enable,
+						mask,
+						NULL);
+	if (ret) {
+		mlx5hws_err(ctx, "Complex matcher: failed creating isolated BWC matcher\n");
+		goto free_matcher;
+	}
+
+	return 0;
+
+free_matcher:
+	kfree(bwc_matcher->complex->isolated_bwc_matcher);
+	return ret;
+}
+
+static void
+hws_bwc_isolated_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
+	kfree(bwc_matcher);
+}
+
+static int
+hws_bwc_isolated_actions_create(struct mlx5hws_bwc_matcher *bwc_matcher,
+				struct mlx5hws_table *table)
+{
+	struct mlx5hws_table *isolated_tbl = bwc_matcher->complex->isolated_tbl;
+	u8 modify_hdr_action[MLX5_ST_SZ_BYTES(set_action_in)] = {0};
+	struct mlx5hws_context *ctx = table->ctx;
+	struct mlx5hws_action_mh_pattern ptrn;
+	int ret = 0;
+
+	/* Create action to jump to isolated table */
+
+	bwc_matcher->complex->action_go_to_tbl =
+		mlx5hws_action_create_dest_table(ctx,
+						 isolated_tbl,
+						 MLX5HWS_ACTION_FLAG_HWS_FDB);
+	if (!bwc_matcher->complex->action_go_to_tbl) {
+		mlx5hws_err(ctx, "Complex matcher: failed to create go-to-tbl action\n");
+		return -EINVAL;
+	}
+
+	/* Create modify header action to set REG_C_6 */
+
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 action_type, MLX5_MODIFICATION_TYPE_SET);
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 field, MLX5_MODI_META_REG_C_6);
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 length, 0); /* zero means length of 32 */
+	MLX5_SET(set_action_in, modify_hdr_action, offset, 0);
+	MLX5_SET(set_action_in, modify_hdr_action, data, 0);
+
+	ptrn.data = (void *)modify_hdr_action;
+	ptrn.sz = MLX5HWS_ACTION_DOUBLE_SIZE;
+
+	bwc_matcher->complex->action_metadata =
+		mlx5hws_action_create_modify_header(ctx, 1, &ptrn, 0,
+						    MLX5HWS_ACTION_FLAG_HWS_FDB);
+	if (!bwc_matcher->complex->action_metadata) {
+		ret = -EINVAL;
+		goto destroy_action_go_to_tbl;
+	}
+
+	/* Create last action */
+
+	bwc_matcher->complex->action_last =
+		mlx5hws_action_create_last(ctx, MLX5HWS_ACTION_FLAG_HWS_FDB);
+	if (!bwc_matcher->complex->action_last) {
+		mlx5hws_err(ctx, "Complex matcher: failed to create last action\n");
+		ret = -EINVAL;
+		goto destroy_action_metadata;
+	}
+
+	return 0;
+
+destroy_action_metadata:
+	mlx5hws_action_destroy(bwc_matcher->complex->action_metadata);
+destroy_action_go_to_tbl:
+	mlx5hws_action_destroy(bwc_matcher->complex->action_go_to_tbl);
+	return ret;
+}
+
+static void
+hws_bwc_isolated_actions_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	mlx5hws_action_destroy(bwc_matcher->complex->action_last);
+	mlx5hws_action_destroy(bwc_matcher->complex->action_metadata);
+	mlx5hws_action_destroy(bwc_matcher->complex->action_go_to_tbl);
+}
+
 int mlx5hws_bwc_matcher_create_complex(struct mlx5hws_bwc_matcher *bwc_matcher,
 				       struct mlx5hws_table *table,
 				       u32 priority,
 				       u8 match_criteria_enable,
 				       struct mlx5hws_match_parameters *mask)
 {
-	mlx5hws_err(table->ctx, "Complex matcher is not supported yet\n");
-	return -EOPNOTSUPP;
+	enum mlx5hws_action_type complex_init_action_types[3];
+	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
+	struct mlx5hws_match_parameters mask_1 = {0};
+	struct mlx5hws_match_parameters mask_2 = {0};
+	struct mlx5hws_context *ctx = table->ctx;
+	int ret;
+
+	ret = hws_bwc_matcher_complex_params_create(table->ctx,
+						    match_criteria_enable,
+						    mask, &mask_1, &mask_2);
+	if (ret)
+		goto err;
+
+	bwc_matcher->complex =
+		kzalloc(sizeof(*bwc_matcher->complex), GFP_KERNEL);
+	if (!bwc_matcher->complex) {
+		ret = -ENOMEM;
+		goto free_masks;
+	}
+
+	ret = rhashtable_init(&bwc_matcher->complex->refcount_hash,
+			      &hws_refcount_hash);
+	if (ret) {
+		mlx5hws_err(ctx, "Complex matcher: failed to initialize rhashtable\n");
+		goto free_complex;
+	}
+
+	mutex_init(&bwc_matcher->complex->hash_lock);
+	ida_init(&bwc_matcher->complex->metadata_ida);
+
+	/* Create initial action template for the first matcher.
+	 * Usually the initial AT is just dummy, but in case of complex
+	 * matcher we know exactly which actions should it have.
+	 */
+
+	complex_init_action_types[0] = MLX5HWS_ACTION_TYP_MODIFY_HDR;
+	complex_init_action_types[1] = MLX5HWS_ACTION_TYP_TBL;
+	complex_init_action_types[2] = MLX5HWS_ACTION_TYP_LAST;
+
+	/* Create the first matcher */
+
+	ret = mlx5hws_bwc_matcher_create_simple(bwc_matcher,
+						table,
+						priority,
+						match_criteria_enable,
+						&mask_1,
+						complex_init_action_types);
+	if (ret)
+		goto destroy_ida;
+
+	/* Create isolated table to hold the second isolated matcher */
+
+	ret = hws_bwc_isolated_table_create(bwc_matcher, table);
+	if (ret) {
+		mlx5hws_err(ctx, "Complex matcher: failed creating isolated table\n");
+		goto destroy_first_matcher;
+	}
+
+	/* Now create the second BWC matcher - the isolated one */
+
+	ret = hws_bwc_isolated_matcher_create(bwc_matcher, table,
+					      match_criteria_enable, &mask_2);
+	if (ret) {
+		mlx5hws_err(ctx, "Complex matcher: failed creating isolated matcher\n");
+		goto destroy_isolated_tbl;
+	}
+
+	/* Create action for isolated matcher's rules */
+
+	ret = hws_bwc_isolated_actions_create(bwc_matcher, table);
+	if (ret) {
+		mlx5hws_err(ctx, "Complex matcher: failed creating isolated actions\n");
+		goto destroy_isolated_matcher;
+	}
+
+	hws_bwc_matcher_complex_params_destroy(&mask_1, &mask_2);
+	return 0;
+
+destroy_isolated_matcher:
+	isolated_bwc_matcher = bwc_matcher->complex->isolated_bwc_matcher;
+	hws_bwc_isolated_matcher_destroy(isolated_bwc_matcher);
+destroy_isolated_tbl:
+	hws_bwc_isolated_table_destroy(bwc_matcher->complex->isolated_tbl);
+destroy_first_matcher:
+	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
+destroy_ida:
+	ida_destroy(&bwc_matcher->complex->metadata_ida);
+	mutex_destroy(&bwc_matcher->complex->hash_lock);
+	rhashtable_destroy(&bwc_matcher->complex->refcount_hash);
+free_complex:
+	kfree(bwc_matcher->complex);
+	bwc_matcher->complex = NULL;
+free_masks:
+	hws_bwc_matcher_complex_params_destroy(&mask_1, &mask_2);
+err:
+	return ret;
 }
 
 void
 mlx5hws_bwc_matcher_destroy_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	/* nothing to do here */
+	struct mlx5hws_bwc_matcher *isolated_bwc_matcher =
+		bwc_matcher->complex->isolated_bwc_matcher;
+
+	hws_bwc_isolated_actions_destroy(bwc_matcher);
+	hws_bwc_isolated_matcher_destroy(isolated_bwc_matcher);
+	hws_bwc_isolated_table_destroy(bwc_matcher->complex->isolated_tbl);
+	mlx5hws_bwc_matcher_destroy_simple(bwc_matcher);
+	ida_destroy(&bwc_matcher->complex->metadata_ida);
+	mutex_destroy(&bwc_matcher->complex->hash_lock);
+	rhashtable_destroy(&bwc_matcher->complex->refcount_hash);
+	kfree(bwc_matcher->complex);
+	bwc_matcher->complex = NULL;
+}
+
+static void
+hws_bwc_matcher_complex_hash_lock(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	mutex_lock(&bwc_matcher->complex->hash_lock);
+}
+
+static void
+hws_bwc_matcher_complex_hash_unlock(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	mutex_unlock(&bwc_matcher->complex->hash_lock);
+}
+
+static int
+hws_bwc_rule_complex_hash_node_get(struct mlx5hws_bwc_rule *bwc_rule,
+				   struct mlx5hws_match_parameters *params)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_bwc_complex_rule_hash_node *node, *old_node;
+	struct rhashtable *refcount_hash;
+	int i;
+
+	bwc_rule->complex_hash_node = NULL;
+
+	node = kzalloc(sizeof(*node), GFP_KERNEL);
+	if (unlikely(!node))
+		return -ENOMEM;
+
+	node->tag = ida_alloc(&bwc_matcher->complex->metadata_ida, GFP_KERNEL);
+	refcount_set(&node->refcount, 1);
+
+	/* Clear match buffer - turn off all the unrelated fields
+	 * in accordance with the match params mask for the first
+	 * matcher out of the two parts of the complex matcher.
+	 * The resulting mask is the key for the hash.
+	 */
+	for (i = 0; i < MLX5_ST_SZ_DW_MATCH_PARAM; i++)
+		node->match_buf[i] = params->match_buf[i] &
+				     bwc_matcher->mt->match_param[i];
+
+	refcount_hash = &bwc_matcher->complex->refcount_hash;
+	old_node = rhashtable_lookup_get_insert_fast(refcount_hash,
+						     &node->hash_node,
+						     hws_refcount_hash);
+	if (old_node) {
+		/* Rule with the same tag already exists - update refcount */
+		refcount_inc(&old_node->refcount);
+		/* Let the new rule use the same tag as the existing rule.
+		 * Note that we don't have any indication for the rule creation
+		 * process that a rule with similar matching params already
+		 * exists - no harm done when this rule is be overwritten by
+		 * the same STE.
+		 * There's some performance advantage in skipping such cases,
+		 * so this is left for future optimizations.
+		 */
+		ida_free(&bwc_matcher->complex->metadata_ida, node->tag);
+		kfree(node);
+		node = old_node;
+	}
+
+	bwc_rule->complex_hash_node = node;
+	return 0;
+}
+
+static void
+hws_bwc_rule_complex_hash_node_put(struct mlx5hws_bwc_rule *bwc_rule,
+				   bool *is_last_rule)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_bwc_complex_rule_hash_node *node;
+
+	if (is_last_rule)
+		*is_last_rule = false;
+
+	node = bwc_rule->complex_hash_node;
+	if (refcount_dec_and_test(&node->refcount)) {
+		rhashtable_remove_fast(&bwc_matcher->complex->refcount_hash,
+				       &node->hash_node,
+				       hws_refcount_hash);
+		ida_free(&bwc_matcher->complex->metadata_ida, node->tag);
+		kfree(node);
+		if (is_last_rule)
+			*is_last_rule = true;
+	}
+
+	bwc_rule->complex_hash_node = NULL;
 }
 
 int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
@@ -70,19 +1144,271 @@ int mlx5hws_bwc_rule_create_complex(struct mlx5hws_bwc_rule *bwc_rule,
 				    struct mlx5hws_rule_action rule_actions[],
 				    u16 bwc_queue_idx)
 {
-	mlx5hws_err(bwc_rule->bwc_matcher->matcher->tbl->ctx,
-		    "Complex rule is not supported yet\n");
-	return -EOPNOTSUPP;
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	u8 modify_hdr_action[MLX5_ST_SZ_BYTES(set_action_in)] = {0};
+	struct mlx5hws_rule_action rule_actions_1[3] = {0};
+	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
+	u32 *match_buf_2;
+	u32 metadata_val;
+	int ret = 0;
+
+	isolated_bwc_matcher = bwc_matcher->complex->isolated_bwc_matcher;
+	bwc_rule->isolated_bwc_rule =
+		mlx5hws_bwc_rule_alloc(isolated_bwc_matcher);
+	if (unlikely(!bwc_rule->isolated_bwc_rule))
+		return -ENOMEM;
+
+	hws_bwc_matcher_complex_hash_lock(bwc_matcher);
+
+	/* Get a new hash node for this complex rule.
+	 * If this is a unique set of match params for the first matcher,
+	 * we will get a new hash node with newly allocated IDA.
+	 * Otherwise we will get an existing node with IDA and updated refcount.
+	 */
+	ret = hws_bwc_rule_complex_hash_node_get(bwc_rule, params);
+	if (unlikely(ret)) {
+		mlx5hws_err(ctx, "Complex rule: failed getting RHT node for this rule\n");
+		goto free_isolated_rule;
+	}
+
+	/* No need to clear match buffer's fields in accordance to what
+	 * will actually be matched on first and second matchers.
+	 * Both matchers were created with the appropriate masks
+	 * and each of them holds the appropriate field copy array,
+	 * so rule creation will use only the fields that will be copied
+	 * in accordance with setters in field copy array.
+	 * We do, however, need to temporary allocate match buffer
+	 * for the second (isolated) rule in order to not modify
+	 * user's match params buffer.
+	 */
+
+	match_buf_2 = kmemdup(params->match_buf,
+			      MLX5_ST_SZ_BYTES(fte_match_param),
+			      GFP_KERNEL);
+	if (unlikely(!match_buf_2)) {
+		mlx5hws_err(ctx, "Complex rule: failed allocating match_buf\n");
+		ret = ENOMEM;
+		goto hash_node_put;
+	}
+
+	/* On 2nd matcher, use unique 32-bit ID as a matching tag */
+	metadata_val = bwc_rule->complex_hash_node->tag;
+	MLX5_SET(fte_match_param, match_buf_2,
+		 misc_parameters_2.metadata_reg_c_6, metadata_val);
+
+	/* Isolated rule's rule_actions contain all the original actions */
+	ret = mlx5hws_bwc_rule_create_simple(bwc_rule->isolated_bwc_rule,
+					     match_buf_2,
+					     rule_actions,
+					     flow_source,
+					     bwc_queue_idx);
+	kfree(match_buf_2);
+	if (unlikely(ret)) {
+		mlx5hws_err(ctx,
+			    "Complex rule: failed creating isolated BWC rule (%d)\n",
+			    ret);
+		goto hash_node_put;
+	}
+
+	/* First rule's rule_actions contain setting metadata and
+	 * jump to isolated table that contains the second matcher.
+	 * Set metadata value to a unique value for this rule.
+	 */
+
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 action_type, MLX5_MODIFICATION_TYPE_SET);
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 field, MLX5_MODI_META_REG_C_6);
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 length, 0); /* zero means length of 32 */
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 offset, 0);
+	MLX5_SET(set_action_in, modify_hdr_action,
+		 data, metadata_val);
+
+	rule_actions_1[0].action = bwc_matcher->complex->action_metadata;
+	rule_actions_1[0].modify_header.offset = 0;
+	rule_actions_1[0].modify_header.data = modify_hdr_action;
+
+	rule_actions_1[1].action = bwc_matcher->complex->action_go_to_tbl;
+	rule_actions_1[2].action = bwc_matcher->complex->action_last;
+
+	ret = mlx5hws_bwc_rule_create_simple(bwc_rule,
+					     params->match_buf,
+					     rule_actions_1,
+					     flow_source,
+					     bwc_queue_idx);
+
+	if (unlikely(ret)) {
+		mlx5hws_err(ctx,
+			    "Complex rule: failed creating first BWC rule (%d)\n",
+			    ret);
+		goto destroy_isolated_rule;
+	}
+
+	hws_bwc_matcher_complex_hash_unlock(bwc_matcher);
+
+	return 0;
+
+destroy_isolated_rule:
+	mlx5hws_bwc_rule_destroy_simple(bwc_rule->isolated_bwc_rule);
+hash_node_put:
+	hws_bwc_rule_complex_hash_node_put(bwc_rule, NULL);
+free_isolated_rule:
+	hws_bwc_matcher_complex_hash_unlock(bwc_matcher);
+	mlx5hws_bwc_rule_free(bwc_rule->isolated_bwc_rule);
+	return ret;
 }
 
 int mlx5hws_bwc_rule_destroy_complex(struct mlx5hws_bwc_rule *bwc_rule)
 {
-	return 0;
+	struct mlx5hws_context *ctx = bwc_rule->bwc_matcher->matcher->tbl->ctx;
+	struct mlx5hws_bwc_rule *isolated_bwc_rule;
+	int ret_isolated, ret;
+	bool is_last_rule;
+
+	hws_bwc_matcher_complex_hash_lock(bwc_rule->bwc_matcher);
+
+	hws_bwc_rule_complex_hash_node_put(bwc_rule, &is_last_rule);
+	bwc_rule->rule->skip_delete = !is_last_rule;
+
+	ret = mlx5hws_bwc_rule_destroy_simple(bwc_rule);
+	if (unlikely(ret))
+		mlx5hws_err(ctx, "BWC complex rule: failed destroying first rule\n");
+
+	isolated_bwc_rule = bwc_rule->isolated_bwc_rule;
+	ret_isolated = mlx5hws_bwc_rule_destroy_simple(isolated_bwc_rule);
+	if (unlikely(ret_isolated))
+		mlx5hws_err(ctx, "BWC complex rule: failed destroying second (isolated) rule\n");
+
+	hws_bwc_matcher_complex_hash_unlock(bwc_rule->bwc_matcher);
+
+	mlx5hws_bwc_rule_free(isolated_bwc_rule);
+
+	return ret || ret_isolated;
+}
+
+static void
+hws_bwc_matcher_clear_hash_rtcs(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	struct mlx5hws_bwc_complex_rule_hash_node *node;
+	struct rhashtable_iter iter;
+
+	rhashtable_walk_enter(&bwc_matcher->complex->refcount_hash, &iter);
+	rhashtable_walk_start(&iter);
+
+	while ((node = rhashtable_walk_next(&iter)) != NULL) {
+		if (IS_ERR(node))
+			continue;
+		node->rtc_valid = false;
+	}
+
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
 }
 
-int mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
+int
+mlx5hws_bwc_matcher_move_all_complex(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	mlx5hws_err(bwc_matcher->matcher->tbl->ctx,
-		    "Moving complex rule is not supported yet\n");
-	return -EOPNOTSUPP;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mlx5hws_matcher *matcher = bwc_matcher->matcher;
+	bool move_error = false, poll_error = false;
+	u16 bwc_queues = mlx5hws_bwc_queues(ctx);
+	struct mlx5hws_bwc_rule *tmp_bwc_rule;
+	struct mlx5hws_rule_attr rule_attr;
+	struct mlx5hws_table *isolated_tbl;
+	struct mlx5hws_rule *tmp_rule;
+	struct list_head *rules_list;
+	u32 expected_completions = 1;
+	u32 end_ft_id;
+	int i, ret;
+
+	/* We are rehashing the matcher that is the first part of the complex
+	 * matcher. Need to update the isolated matcher to point to the end_ft
+	 * of this new matcher. This needs to be done before moving any rules
+	 * to prevent possible steering loops.
+	 */
+	isolated_tbl = bwc_matcher->complex->isolated_tbl;
+	end_ft_id = bwc_matcher->matcher->resize_dst->end_ft_id;
+	ret = mlx5hws_matcher_update_end_ft_isolated(isolated_tbl, end_ft_id);
+	if (ret) {
+		mlx5hws_err(ctx,
+			    "Failed updating end_ft of isolated matcher (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	hws_bwc_matcher_clear_hash_rtcs(bwc_matcher);
+
+	mlx5hws_bwc_rule_fill_attr(bwc_matcher, 0, 0, &rule_attr);
+
+	for (i = 0; i < bwc_queues; i++) {
+		rules_list = &bwc_matcher->rules[i];
+		if (list_empty(rules_list))
+			continue;
+
+		rule_attr.queue_id = mlx5hws_bwc_get_queue_id(ctx, i);
+
+		list_for_each_entry(tmp_bwc_rule, rules_list, list_node) {
+			/* Check if a rule with similar tag has already
+			 * been moved.
+			 */
+			if (tmp_bwc_rule->complex_hash_node->rtc_valid) {
+				/* This rule is a duplicate of rule with similar
+				 * tag that has already been moved earlier.
+				 * Just update this rule's RTCs.
+				 */
+				tmp_bwc_rule->rule->rtc_0 =
+					tmp_bwc_rule->complex_hash_node->rtc_0;
+				tmp_bwc_rule->rule->rtc_1 =
+					tmp_bwc_rule->complex_hash_node->rtc_1;
+				tmp_bwc_rule->rule->matcher =
+					tmp_bwc_rule->rule->matcher->resize_dst;
+				continue;
+			}
+
+			/* First time we're moving rule with this tag.
+			 * Move it for real.
+			 */
+			tmp_rule = tmp_bwc_rule->rule;
+			tmp_rule->skip_delete = false;
+			ret = mlx5hws_matcher_resize_rule_move(matcher,
+							       tmp_rule,
+							       &rule_attr);
+			if (unlikely(ret && !move_error)) {
+				mlx5hws_err(ctx,
+					    "Moving complex BWC rule failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				move_error = true;
+			}
+
+			expected_completions = 1;
+			ret = mlx5hws_bwc_queue_poll(ctx,
+						     rule_attr.queue_id,
+						     &expected_completions,
+						     true);
+			if (unlikely(ret && !poll_error)) {
+				mlx5hws_err(ctx,
+					    "Moving complex BWC rule: poll failed (%d), attempting to move rest of the rules\n",
+					    ret);
+				poll_error = true;
+			}
+
+			/* Done moving the rule to the new matcher,
+			 * now update RTCs for all the duplicated rules.
+			 */
+			tmp_bwc_rule->complex_hash_node->rtc_0 =
+				tmp_bwc_rule->rule->rtc_0;
+			tmp_bwc_rule->complex_hash_node->rtc_1 =
+				tmp_bwc_rule->rule->rtc_1;
+
+			tmp_bwc_rule->complex_hash_node->rtc_valid = true;
+		}
+	}
+
+	if (move_error || poll_error)
+		ret = -EINVAL;
+
+	return ret;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
index 340f0688e394..a6887c7e39d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc_complex.h
@@ -4,6 +4,27 @@
 #ifndef HWS_BWC_COMPLEX_H_
 #define HWS_BWC_COMPLEX_H_
 
+struct mlx5hws_bwc_complex_rule_hash_node {
+	u32 match_buf[MLX5_ST_SZ_DW_MATCH_PARAM];
+	u32 tag;
+	refcount_t refcount;
+	bool rtc_valid;
+	u32 rtc_0;
+	u32 rtc_1;
+	struct rhash_head hash_node;
+};
+
+struct mlx5hws_bwc_matcher_complex_data {
+	struct mlx5hws_table *isolated_tbl;
+	struct mlx5hws_bwc_matcher *isolated_bwc_matcher;
+	struct mlx5hws_action *action_metadata;
+	struct mlx5hws_action *action_go_to_tbl;
+	struct mlx5hws_action *action_last;
+	struct rhashtable refcount_hash;
+	struct mutex hash_lock; /* Protect the refcount rhashtable */
+	struct ida metadata_ida;
+};
+
 bool mlx5hws_bwc_match_params_is_complex(struct mlx5hws_context *ctx,
 					 u8 match_criteria_enable,
 					 struct mlx5hws_match_parameters *mask);
-- 
2.31.1


