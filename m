Return-Path: <linux-rdma+bounces-10179-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23802AB09E9
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 07:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B16477BE08C
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 05:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9714826988A;
	Fri,  9 May 2025 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pFlzMyqe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83069139D1B;
	Fri,  9 May 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769781; cv=fail; b=ruYy6jf8q1SQ/qZGywd/riSfwwzyiFsWaOBbdsmUAGmn0zNKjwUOecucoHr7FdowXAeMGP/beDJ38TYfAaWpk6lh0Dd3HisTW8PHwg/+FX67RYbvM6dsHYcPUpqDqnvMC39VgvvRGnUMrV5h+O2pvs5FGKpQJ9PWa5kX6hRSbcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769781; c=relaxed/simple;
	bh=6h8cdneUySBWHEKpxrLsV7QfdImOLaouBiT7KsKkt8Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CujgtlH8W9UcwzyEZbhSk2IqT/mVV9YOs1aiN4TLLGgo7fEp9ozI7ViNrjBhq6V3/7nzq5nDDESxgC2aO6x5uonxmendT4q8s2WXUh4R8ejiM/QKvujYOf4upbck/DUDhrZpiHxU4VoAL6MoxA/mnLNI0lwQ1ikWK74E0THTr7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pFlzMyqe; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MH/G+9gB5zJYzrB2gafOhFioodv8/c4IqzV6nD8QhDGc+mqWntGaHoi7X+bYvjAmLWAdeTh7uvPyNno+Nxa3bCtf68ZdmzLpts64DvXcCLxGWMT9DFunV8NWB5GllFbvxaVwSHgYLp4/4EXj7Ejubxvye3OkTVcou1veOpDQfLW41Eg3Ga4/R0eT7w/AzR82M6qY+WBPQ3S3icmhx4zZWZSPx8tZexYGNqijFN3j3O5rs3D1EfzRMpA/+0fQVc1NDSfS/xpUscMD0XRHROgbtAxiAJtz7SZE3PLKgMldmSrJAn+LoTjdvQe0/FX4SBoYcIuNXXw8BKtba5Lr0tVsBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k99nWHIMtwGug7DDzTcVlgBCkDp5PbIiDpPzu2N2k/o=;
 b=FniN5jCcZPl+CWEV1gYca4zJ0QdEMkurj8cVqavw6/8nHM7hLNYOVqoZZmVXwQ9r3739tgY3vzTsXhdEjOURVWC1ohB+Ps+G9tl6PNWZAmIirPjScFxiRkYPobeuY+xXN6j2AuTGdy5dhrA6akhp9Hvo0OYNWpRBJRruMMF1IP0P4vfCo1GlpXeWwrAFY7OkVzWEbPelHYAcMS2iVcKj+8ITDGfLz8zg9q4MOzCAW0glLfySaLS4QGxnEE4nUtoAcAeLC0l7zrbIfiuW4FFj9V4P+nQV6DJ+QEi5zFJdRf+G8ZQfkPaHUnOzNqd7gnt+9djYW6zQMXAm7bqbV3yb1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k99nWHIMtwGug7DDzTcVlgBCkDp5PbIiDpPzu2N2k/o=;
 b=pFlzMyqeGR5WPDHuR3uXWY9Oe1Nn5K97+ilHQPbuXN6M7EVkkaPtDW9jd7Fk947EqecOwVpHQ1VUzTkZSuWkmZOdoQi2A3jVfx0ke+DZbdlEEtqkfzE36mIToqjACq4buLNpgUvvATKT6BrlJhNs9VIzVF3bJItfMklPhkAZfIMz02AL88v8GXzi1r7+cZr2pzN1+Tza5XEx1D2QPSNl/Cz/VGOJvyZn18+ioRDPsY8T/CHr2nwfKMu4Cit1Ry7/InO7CM1H79YCmQq9vqzyIF+8e1wurPpOnGZuMbnchiu97ANkN4eLE/I+pKmkqhrfH5Xq8+ugDZoFwQ6CuisqDQ==
Received: from CH2PR04CA0008.namprd04.prod.outlook.com (2603:10b6:610:52::18)
 by CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 05:49:28 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::d8) by CH2PR04CA0008.outlook.office365.com
 (2603:10b6:610:52::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 9 May 2025 05:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 05:49:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 22:49:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 22:49:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 8 May
 2025 22:49:11 -0700
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
Subject: [PATCH net-next V9 0/5] Support rate management on traffic classes in devlink and mlx5
Date: Fri, 9 May 2025 08:43:04 +0300
Message-ID: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH2PR12MB4262:EE_
X-MS-Office365-Filtering-Correlation-Id: beef638c-5d1f-4d13-d8d5-08dd8ebd430d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDVjaG52RVd3UDFocW92c0tpOXFyL0dKcVd2cTBmcWhCbXRja0YreVRFeXE1?=
 =?utf-8?B?bHU5bFhSQ252N2FZRGFQKzRDY1pqNXBkcFBWbXIrUXNvVlgrVG90emhBQ2dn?=
 =?utf-8?B?TnhZOXpnaSsvUXVXY1VkekJha0FReXZ5N1RDd2lZNjQzUmF3eDdzQmNucHBr?=
 =?utf-8?B?U2F5S1c2SEtWUSs0ZTNoV3p3YTUrVE5qZzNtdTdoWjBieGZ0QzF4U2xWcWNl?=
 =?utf-8?B?SW9LbkFOSmlaWGc2Y3hCaTBQQTVJNEU4eTh6d3l4THBWcmVsY0dKM0I4blJu?=
 =?utf-8?B?RUF1aDZsN1F6ZXJZMjlPemExcnY5YVRmdFBVZUMwTDNNRjlvMExHd2t4d01N?=
 =?utf-8?B?OVVXVGNPTkY2ZHIvdEtCamdvakpXN0FJNGlrZEFXa3JDVUlOY2RlMkZUb1FH?=
 =?utf-8?B?RlM0Y0NEbmxTZlFiaCt6NGN1VUI3bExmWWVjV0R2TW83Vnh0dlJYakh5UmVi?=
 =?utf-8?B?VjByOG9YVHNlaUV3bWI5UEFUSzhLeCt3bHBVb2NVeUFOV3Fzai9aRXJ1WTB1?=
 =?utf-8?B?T2FtdG5UMk5adFlpVVRCajlLalZWQkdTQ0QvTVdrdm1OUmREZ2ZjVGtmdFNw?=
 =?utf-8?B?YUJaYjJJS3p6Zm5Oam1FVEdManFuRitHZG1QNG4yWjJ4c2oyYjh3K0E5UjRX?=
 =?utf-8?B?c2dMYTduYkU5dHpGS2tlMnJkUzl3M0hCSlVVZXRUbTRPb1g1TXZjbjc2elMy?=
 =?utf-8?B?UDFIUHE1OEdsT1dTRmR6NTdDVXZ3NVNUSUw3ampWQXp6bTJ4Y2pUVlFQZFRJ?=
 =?utf-8?B?emdTUmFrb1NmdzZNMTR6TC9MU2tiK1lkcXBhOWlScEViV0pVdzNlSGtSK0w0?=
 =?utf-8?B?bGpFMDlsZDdwRzRSTGVGMUd6K3BGYkVuM2ZTVEpIeVVjdGVpVUphNnpHcTV1?=
 =?utf-8?B?TnVWcUVNM2IxYnM2OE5kQVFxelgrYW5zLzMxa1c1T0ZiQkpxU0tEZGRHWG1v?=
 =?utf-8?B?a0FKUnJoNlpyNG9Qa0t4MktudHppb0swTElOcXhiRzZhSW0vZUtHRkI1RGJM?=
 =?utf-8?B?SXJyL1dLem91YVBUc2Zpdmxvb25PbXZFR0N0RVZzN01WMXlJeXFZVE5nWDFm?=
 =?utf-8?B?S25hUWk0U2U5K2hleVRjUzdZWmNtZENqUVVZUmNFQzNYR01MN3hSLzk2bDBh?=
 =?utf-8?B?QkhudEF6UkhWWU5jTGZvcmFrQTlPUkNZdWx4NXVVRUNjemR1SitPSGNoK3pi?=
 =?utf-8?B?bDNCUExVb21Na08vRFk5OWxwNWNDNndGQVk3Y3B1cEVLQ1ZmSTdZeUJ2LzZi?=
 =?utf-8?B?YTRsY2ZNcnZCV1JZeGJWZUREVUlhaU1ydnJhcmxBdVU5cWNuWnh5Y0hNR2Zn?=
 =?utf-8?B?ZnBTLys1Tk04KzJ4dzdQWHV6ZEF0WGw0SnV5cmF6cU85bmlPeEsxdFA5SWt4?=
 =?utf-8?B?TXRFS2VYMy90cHZNSEZ6N2V5ZFI4aWhoYTlZdm5SRGQ3b2FuQ2ljRDBMbTdF?=
 =?utf-8?B?YytmMWU4K3lmcWU3c3FTbUozT1N1dGtPV1hjaERSTDFnY2dzaWdERVBjMCtr?=
 =?utf-8?B?UHFUL29SdGJGSzRIUVl1eDNseE02WmhRRWV6dEpYOHRvaDZPSGpxYnpsZGs3?=
 =?utf-8?B?NmZaOHVrYXdsNHhqc2NpYXl2YUw2TGRXU3FJWXpSdnRwRURMK25WN3JkNElw?=
 =?utf-8?B?N29oRktHZGZmSFFnaDRlZmZ6dzFsOFQ5cFdNRlJzVTR3RVJocXhDcDJpem5Z?=
 =?utf-8?B?ai9ReGpDakEzaXROVnVkdkcxcWY1SzVUQ1BuTXZJNk9LdHltbWMyamN3M2ho?=
 =?utf-8?B?Rk92d0VpVUYvYkZvN2VERGRxcit4Z1NGREU3S2JhMGlDWVN6UVAzQmhIWlBr?=
 =?utf-8?B?Um1Ueis4NTZxblVnZkszMjJ2ZE9yc3BWYVBBQUE1cVcrYysrOW9saTRUNnRj?=
 =?utf-8?B?azFwUkszbGFTZnlPbDFid3BWY3E5a2UyMmxKMkRBYVVCNVlPcWpIL3NKYzd3?=
 =?utf-8?B?RVkxQitNMTdGSElGMzBSTVpTRE9SV3BsemFSdDhrbHprbkZsR3V0WS9CVVVz?=
 =?utf-8?B?RWppcTk4dkNwZFdlT2NXSEVwSTlwVkxLMVlXZVdoMjZod280VFFXZHhReWNl?=
 =?utf-8?B?ekFKVDRRREJyUWlPZGdkVUx1eXozYml5VXZ4QT09?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 05:49:27.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beef638c-5d1f-4d13-d8d5-08dd8ebd430d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4262

Hi,

This patch series by Carolina is V9 of the feature that adds rate
management support on traffic classes in devlink and mlx5, see full
description by Carolina below [0].

V9:
- Define DEVLINK_RATE_TCS_MAX as 8 in uapi/linux/devlink.h.
- Replace IEEE_8021QAZ_MAX_TCS with DEVLINK_RATE_TCS_MAX throughout
  the code.
- Update devlink-rate-tc-index-max spec to reference the correct UAPI
  header.

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
 include/net/devlink.h                         |    6 +
 include/uapi/linux/devlink.h                  |    7 +
 net/devlink/netlink_gen.c                     |   15 +-
 net/devlink/netlink_gen.h                     |    1 +
 net/devlink/rate.c                            |  127 +++
 11 files changed, 1193 insertions(+), 37 deletions(-)


base-commit: a9ce2ce1800e04267e6d99016ed0fe132d6049a9
-- 
2.31.1


