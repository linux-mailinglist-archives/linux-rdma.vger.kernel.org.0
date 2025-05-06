Return-Path: <linux-rdma+bounces-10072-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A33AAC289
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9242B1C28015
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 11:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FF827A471;
	Tue,  6 May 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Es+siBr3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DC220F56;
	Tue,  6 May 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530853; cv=fail; b=fe2zXNil02tz0wqfukI9mIlRB3BD77WksdCWAZP8khTIXE5QCA8ZwKr3QfoMmjnni45sqono6l7PCQS37TKyILM4XPn0LbF567kXtj7+bAIF8ANi5Tlfv3TGnAFM85vqENT7YAgAM/h2pjSmIa8CYwm1Xq/o0/8fcC52ml0Z690=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530853; c=relaxed/simple;
	bh=/NgFLTfsCkLkeuFDRUdW2w6qIDHdzsiPUp9napo0ozY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tiz33Syh3CpZDjL4UzzhhPhrcbdrjX++NYfIoj+0mK8Fq3SRLzmP6iXwpR/KE1+TfbCRftVPi9DtJrbnhljdNoz+/zpwXCsTDB1GpWHrlwwJsyD7mE5HrWJhcVRLnJsYl06n31EHWrEz4wGktQzg4jyXz7fBk7oNAqDu5TMsr5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Es+siBr3; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkhg0M471dZE6PJhWw0o3WSiNHbkCJ9MLOve1D/4KPDj7vXb+G+wNxd+VV6ZqXxD4zZaVDUIueAzHDamtVzSlrXd+KfEX2DfQVSl8qKb8EY357xskTmcFs98ayAfJs+xg62FIyR7U+NX+Xn7vJ4Td4Ff9Rfm6PsXkbIubeUhOoCzuyiFnPPnnyta7wkkkoprx4K/BScID2J+97B2Qzc6WwwXGTKSWgz0zJtiiJnC1o2jv9milk1pzC39FGFTT8bPR8rWuL634/5ICypL9MEmVzpwk/TAfjj9lWUSErgJLYmRxX4WJEg9rr9KJYvxrf+vzsYYgrELv9tKnP2Qs18a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lRTcniRxYxYRNdf6QHvAMnQPmoqc903mY0H4Jjaky0=;
 b=wL+sx7JeNlfYiyu/WrDFYyhYtw2hpcfVDQ9G7VWPDz+IycEEM1Bs6e0KWyGEWJLx5IeXO2Tby/WgrjadFMW3IyYZZah9SlNExxxC1oUop3zCbropvemEfrILyPsikDQ9Qpp6ErM9Dso/KgFzw6UaqaMjUolE2kT2lW14HzA3rIFfRnkPTcnLjBoDz+4Dzblk8sfU9slj1nRqgiWzLrVIbJDNfO8dWeepnacfcABIcajiXhGeuf6nPOMb7WdS5suow+ICAiCIz8Lj4zEXX91p3hNutAKUVhoqgY/wr3GsH8SlqZrqJFYPtIZQCSr/ioMRwuXN69kK8S+ac3Edad0kJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lRTcniRxYxYRNdf6QHvAMnQPmoqc903mY0H4Jjaky0=;
 b=Es+siBr3n1lmHqiJv880Q1fr6UUKf0tnIQvBQLz77RXbOtMyENIPbxN+ySDarnfzbg1tDrQzufZYoDxy5Jmd134BlTslO6/md997lKIINvbKTPKzyqBFxos5M5QIdj7VKn3yBn5ckXnV4g305uiAG972u/QB4h2Q3pPaRLGBcKycxEja4xCUAqhKx2EscprNHk0fGmBBFtlXYu0LAweVVeFzFyJN+Vre6LI09wQ8CaTgNIiy1/ua6yxbJ627nw4toy4mZA82IijF6WSCsKDeYSRmIzMRr8eI/Fhzx/0Y0V523LBLBe36X9Q7vCb6gGu732cAIwDPV8FE19iJFmhzow==
Received: from DM6PR02CA0126.namprd02.prod.outlook.com (2603:10b6:5:1b4::28)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 11:27:23 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:5:1b4:cafe::9b) by DM6PR02CA0126.outlook.office365.com
 (2603:10b6:5:1b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Tue,
 6 May 2025 11:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 11:27:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 04:27:09 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 04:27:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 04:27:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	"Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next V8 0/5] Support rate management on traffic classes in devlink and mlx5
Date: Tue, 6 May 2025 14:26:38 +0300
Message-ID: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a33cce1-9208-4120-dabe-08dd8c90f898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3JYbDQ5dm4xV2ZrZ3piWDl4NytvZFF6NCtyd3BtVVpjQVNaOVpaUVYwRGt1?=
 =?utf-8?B?Nk83M0RDOS9mZzkyZjhVTVFTQ1BKM2pmUjdoaFpTQ3BkdkpibkRqOTJaUmhV?=
 =?utf-8?B?ZTRIL3dUWFQ0NUErVElXRGh2a0cyaEFKRllVWjFTK1Uyb3JvdUFrU1RPd1o1?=
 =?utf-8?B?bnlFOElRK3Z2dHgrRE5FVW9tdnNOVnhvLzA0Nll4M1ZlZ3pndSt6aEdCU2Zo?=
 =?utf-8?B?eGZLUVo1QVRFSVltUXA5bjlaVnA3dXIvbVhuVWVJZFdNVmlUZDVOenNNbHZM?=
 =?utf-8?B?QlNrV01yZGtCTWFaa3gwM3pXcWwwZEk4WGlYRWx5dWFwWWgzdWc3cEtYc2gz?=
 =?utf-8?B?YlV6bU5OYXZZNzVjQ3h2K284NW5tMnROZ053QUlIVy9aa1FmV1hJZndwcmtE?=
 =?utf-8?B?eDNmNkhRZkQrOGVxZVMxSkMzZGRYbm5MQ05VTThYU2FtZ3dkYkdZb0JGUGJy?=
 =?utf-8?B?SXViVnpvY25NU2ttUzkrTk1LazUzRFN5Qzc2YVRPYXZ0alNHNEpMcmNrT0VQ?=
 =?utf-8?B?WS9vYUU2OE5pWmJMclVVZEhjQ2pUc1NQMk10cG01OHBONElReWdxTStZUUtr?=
 =?utf-8?B?WnUvMFB2YVJLS0tFWmw3eldXZERIZXV4WDh3TldhWXY4RWZxTW5PeWF3c1dM?=
 =?utf-8?B?dHNDU3pacFNoYnlucUhWZnZTeUNBU0dmcmpuaHdhL2ErL0xDVlVzT3dyZ25Z?=
 =?utf-8?B?cFFpSWU0Smc1bFhwT1RuZEt2ZzZqSW5XWDBWaDZwcDVqL1RycURUNFE1YUpM?=
 =?utf-8?B?Wm1IREkrdzJSazYzNzZKMHNleFdYTzVNa3lEWCtTNTM4bC9mWllJVlZZOUV6?=
 =?utf-8?B?ZGx2dXFsUUxZaGo2dkh5UW04KytTMVFMSGlaWTRzb0xHR3hsdXA4TkxydS93?=
 =?utf-8?B?a2Mwd0J5dko2dmtMTUVjMGpCVndSZzYwbmV5SThYNFBRc0VmdllDREJRMm9v?=
 =?utf-8?B?V3pQZ2hKQ0FHaytkVnFoWndsWWhueGdxaXU2aFlIcnRjZlZwT0ZyRTlUdUFr?=
 =?utf-8?B?Qk1BNHRlWEMxbGUyY2hjcE9ZUDRqMnVLa0w5OWxaZktCTHNUdHJoZElSUFJh?=
 =?utf-8?B?SDBBNXhRSWM2ZGcveHUra0ZlY3BrTFl2NVd2TGdVemxCbHk0VFZzOFJoMGVQ?=
 =?utf-8?B?L0pmaENDRTRjanFnYjgyUVNQamtVWmk3OFNCMFMzenRISzVsb3p2UHFtY08y?=
 =?utf-8?B?bkYwMWIxUXRsWVlxNk9qM3Mxc01RYko3OFh4MlpIZDM0SU9NYkFpTEttUzlN?=
 =?utf-8?B?UGhGQ1BOaDk4eVZSdkxWaGl1dnZOQmNyQkZaNFJwaXg4UDhNWHQ1SkRCSmNG?=
 =?utf-8?B?RnY0NmxXSUlBZUUzVlcvOXZ6MmhBUkU2a29WeVZNekF5WmRXUzdPSXA3clNu?=
 =?utf-8?B?ZWpvY2tENjZDNUp4MjZtQW1aSlh4L3N0djNYMHA4SVRuQlRZQTJScnoyOUJD?=
 =?utf-8?B?aDRNMk53VFM2VGdvSmhZa0JCRi9UOG5UN0J0dVNyWVdzc092WmY3VFRwOGc0?=
 =?utf-8?B?MURXSnN6em5tekdDbW9ZOWdCeW5oQlNJaU90bEw1S2M4RFY4bXpRQXBVck9i?=
 =?utf-8?B?TXZ1TmRqN2JnVXk1bkl1R2EyM1IvdEtqSE1BV0g3Z1djQkdhbGsyRkt3bnpz?=
 =?utf-8?B?Q2lvUXJrTXNZOXVVeHhGeVdPQkEzNlAyYkxMMFpreFlDVXkyQ1dweXRZZG9n?=
 =?utf-8?B?YkI5dFh2TVRPWnVyQXhDenU1RVQwUlBrSmY5TE9EQW9uNU1XTkxVU1hIOUF0?=
 =?utf-8?B?cDlDVWpvZFR4WjVtSXVJZFJ1VVhZcW4yMHBrR2IzTXhvb0MwZ2M4NzVqR09C?=
 =?utf-8?B?TjBFVVRFR3hDbUlwNks3Z1RXd2xZcHp6bW9SVWx2TERXdjJ4L2kyMzZKOXNu?=
 =?utf-8?B?UU9uQU5TN1l4TG1kKzJ1RUtMSzFVemNNL1lIY3NrOFJBRlhOZWc0eC9Meitv?=
 =?utf-8?B?QUMwV3o4RldMUjRMODQreitZZDlwTk9UR1pKZnZpWTAxc256b3I4MUUzRlh6?=
 =?utf-8?B?OEhuRTFkWEFqVkh2UE5WelRYV25WTkt4Y2pDTC94ZzEzMm1jRkFtUDRuUWZa?=
 =?utf-8?B?SDFiZWFNUk12U1FKSTk1VVlZRzYvWVMzOWhHUT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:27:22.9789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a33cce1-9208-4120-dabe-08dd8c90f898
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

Hi,

This patch series by Carolina is V8 of the feature that adds rate
management support on traffic classes in devlink and mlx5, see full
description by Carolina below [0].

V8:
- Extend the cover letter.
- Limit line width to 80 characters in mlx5 changes instead of 100.
- Increase the scheduling node levels to support TC arbitration.
- Ensure parent nodes are set correctly in all code paths that extend
  the hierarchy depth for TC arbitration.
- Extended the cover letter with the ongoing discussion on devlink-rate
  and net-shapers.
- Extended the cover letter with the Netdev talk link on this series.

Regards,
Tariq


[0]
This patch series extends the devlink-rate API to support traffic class
(TC) bandwidth management, enabling more granular control over traffic
shaping and rate limiting across multiple TCs. The API now allows users
to specify bandwidth proportions for different traffic classes in a
single command. This is particularly useful for managing Enhanced
Transmission Selection (ETS) for groups of Virtual Functions (VFs),
allowing precise bandwidth allocation across traffic classes.

Additionally the series refines the QoS handling in net/mlx5 to support
TC arbitration and bandwidth management on vports and rate nodes.

Discussions on traffic class shaping in net-shapers began in V5 [1],
where we discussed with maintainers whether net-shapers should support
traffic classes and how this could be implemented.

Later, after further conversations with Paolo Abeni and Simon Horman,
Cosmin provided an update [2], confirming that net-shapers' tree-based
hierarchy aligns well with traffic classes when treated as distinct
subsets of netdev queues. Since mlx5 enforces a 1:1 mapping between TX
queues and traffic classes, this approach seems feasible, though some
open questions remain regarding queue reconfiguration and certain mlx5
scheduling behaviors.

Building on that discussion, Cosmin has now shared a concrete
implementation plan on the netdev mailing list [3]. The plan, developed
in collaboration with Paolo and Simon, outlines how net-shapers can be
extended to support the same use cases currently covered by
devlink-rate, with the eventual goal of aligning both and simplifying
the shaping infrastructure in the kernel.

This work was presented at Netdev 0x19 in Zagreb [4].
There we presented how TC scheduling is enforced in mlx5 hardware,
which led to discussions on the mailing list.

A summary of how things work:

Classification means labeling a packet with a traffic class based on the
packet's DSCP or VLAN PCP field, then treating packets with different
traffic classes differently during transmit processing.

In a virtualized setup, VFs are untrusted and do not control
classification or shaping.  Classification is done by the hardware using
a prio-to-TC mapping set by the hypervisor. VFs only select which send
queue to use and are expected to respect the classification logic by
sending each traffic class on its dedicated queue. As stated in the
net-shapers plan [3], each transmit queue should carry only a single
traffic class. Mixing classes in a single queue can lead to HOL
blocking.

In the mlx5 implementation, if the queue used does not match the
classified traffic class, the hardware moves the queue to the correct TC
scheduler. This movement is not a reclassification; it’s a necessary
enforcement step to ensure traffic class isolation is maintained.

Extend devlink-rate API to support rate management on TCs:
- devlink: Extend the devlink rate API to support traffic class
  bandwidth management

Introduce a no-op implementation:
- net/mlx5: Add no-op implementation for setting tc-bw on rate objects

Add support for enabling and disabling TC QoS on vports and nodes:
- net/mlx5: Add support for setting tc-bw on nodes
- net/mlx5: Add traffic class scheduling support for vport QoS

Support for setting tc-bw on rate objects:
- net/mlx5: Manage TC arbiter nodes and implement full support for
  tc-bw

[1]
https://lore.kernel.org/netdev/20241204220931.254964-1-tariqt@nvidia.com/
[2]
https://lore.kernel.org/netdev/67df1a562614b553dcab043f347a0d7c5393ff83.camel@nvidia.com/
[3]
https://lore.kernel.org/netdev/d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com/T/
[4]
https://netdevconf.info/0x19/sessions/talk/optimizing-bandwidth-allocation-with-ets-and-traffic-classes.html

Carolina Jubran (5):
  devlink: Extend devlink rate API with traffic classes bandwidth
    management
  net/mlx5: Add no-op implementation for setting tc-bw on rate objects
  net/mlx5: Add support for setting tc-bw on nodes
  net/mlx5: Add traffic class scheduling support for vport QoS
  net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw

 Documentation/netlink/specs/devlink.yaml      |   36 +-
 .../networking/devlink/devlink-port.rst       |    7 +
 .../net/ethernet/mellanox/mlx5/core/devlink.c |    2 +
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 1007 ++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |    8 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   14 +-
 include/net/devlink.h                         |    9 +
 include/uapi/linux/devlink.h                  |    4 +
 net/devlink/netlink_gen.c                     |   16 +-
 net/devlink/netlink_gen.h                     |    2 +
 net/devlink/rate.c                            |  127 +++
 11 files changed, 1195 insertions(+), 37 deletions(-)


base-commit: 836b313a14a316290886dcc2ce7e78bf5ecc8658
-- 
2.31.1


