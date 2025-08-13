Return-Path: <linux-rdma+bounces-12723-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C019B25390
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71ABB1C29E2F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761D83093AD;
	Wed, 13 Aug 2025 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FkTT7DVG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67E307496;
	Wed, 13 Aug 2025 18:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111445; cv=fail; b=QII/dCF+zmHEAFkxthSiznOEDe8zVr2HyCzPDarKmDSFd5iaQdybAdjC675qMgVbZYme3461jYdYc2KQ57gqCvqmSAEg0zPQEFiQKsiwEQrWvz2x55r3mtkasqJzltMfxPDymBoWqytrNdN85QnrltmROsWz8+O/AltI94QJIj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111445; c=relaxed/simple;
	bh=lqjosAPgrgm7IEkC8V4YHnDVbRtV+5NoXTliONViuRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IgaGUlfFzR0OPjPrxZgaRs3oUZ+ThaMXblcuP937d4hUZJyxHIfbmMBf6SBQRLfo8mjmloKkDET61ou80vyWsms1wEJJ7fcqUv0B60KqF7CVJOyaZKK30dElqfxrFgZVrMCW3EIoAKQtrwvSRHCL7uZbyYXyWMILfRuhYk8xi2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FkTT7DVG; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txqfqE66W1A4432qzMVC+P/8nqB3Tf+nbeSJ2Z9Nt68vFoYpw3/DzpbyNtEvSAVDh77BEIi5KYeLKaYTICPuLAT1/AjNKucYeGZF+oZWkr5dGovSon6HSnw+q8s+4ln/q7Vv9C+BL2cXAlhrhfC6Z1MSTcsNBh8IKeaauVbiCRI3LBiwezdcwKxe6HaLy+plT9ESNOHX+b+aUQV8fbegNAxe7zrul8kZjJKCV5KOXwx7lQ6rd2nx5nSve6Bj3RDAry0RfpYRTeogFtICK8oMwzGkfm5ZE08pEjPmxiJ1bnSRf/DMp0a2mtn2W5CQ/iM8Rq8hNkHzie6yiOvRf9mr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bx0nltJAqPDiw32nYF7myL0CiKz0propbjqOIW/bYQ=;
 b=HOzkmNnzoGY/NEBn+GyM306xMT4fbMaJO4oVm6sPd+RLQk+/NSi+k1Rm1XXfq1Kmb516EfmfIAaAGZdctJbx07WuqEw/rgNo0exl9luyGHjykbpcbzYu6tmFbR068PBVHPlUZXdHUJIz5eB3qziLRJzQPwygfHAWfrvuQmdaogD9BobLco0d8G09R37295lIW7ZL8QuwQam8rybYhsIr29bizbKMTMbJgOa1K6miS03oqm4PNVyjcM3kN38ddtI5a3a7YUzegHxTq362jAY12tC1bfEBuQIYmnEimTX3+526T1PIdW9+wo863qLau+wuVmVDkK1n07ruyCavCpJg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5bx0nltJAqPDiw32nYF7myL0CiKz0propbjqOIW/bYQ=;
 b=FkTT7DVG8FHvneTX1yOd78oUI/27skV/nA+nm/G+7EpnKWQzWrhfGIeK2LFhOOEfvUA4dzXJRMwBC13O+Br91MTf6GMozK8pj08YWSgV9Td0zbvLKg0ViesvnaK864nAPlinA+76ozEWrtXUj28p7kVLyJSDAHe4fT86aPxreWNCc50/AszaVMDWZ/OSk1/gTJTEzGd8aASy/W1jqnzbbaUZ8EO6tL4H2dBsBdsZGyHULHD1ZylTX8Ow8cXaldBDn7UrjjH/bSRST/RGU7HguzN4W8IJausSV57dxzuEcquHOY9AJZylIcSEWpBoGyrygnaEx2WiwMhOburFfeRYoQ==
Received: from SJ0PR03CA0089.namprd03.prod.outlook.com (2603:10b6:a03:331::34)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 18:57:20 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::1f) by SJ0PR03CA0089.outlook.office365.com
 (2603:10b6:a03:331::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 18:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:57:20 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:57:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:57:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 11:56:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <brett.creeley@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Shahar
 Shitrit" <shshitrit@nvidia.com>
Subject: [PATCH net-next V3 4/5] devlink: Make health reporter error burst period configurable
Date: Wed, 13 Aug 2025 21:55:48 +0300
Message-ID: <1755111349-416632-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: c34441a1-e032-4200-d292-08ddda9b3b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHNISTl4V090bmFGcWpkTEk2cTUwUmR0SFFKblBlaUNwTGxvWTEzL3NhSENa?=
 =?utf-8?B?QUxQNEZEdDZxeWhFTmt0YlQySEJzYlFUelRGbkV1VUVMQW1TY1hhUHE2NmU5?=
 =?utf-8?B?WElxemNXTUc4bzVpMm9BZWxRM1B0M1JPbWpPaG5wSHp4aEd3UHM3R1FKNEta?=
 =?utf-8?B?N2NJdmxaaVJCZHBWSzdvM3k1OTdIcDZ0a29rc1ljenpGN2xpbkdzU3d1b0sy?=
 =?utf-8?B?Wld5Y0dsZVllSWVZUndtenl0Z3VReUdFOHZlS3JiUmdlajU2cm1BZnNrNzZH?=
 =?utf-8?B?eFRTNy90Ym5SbzZpYjlyVTJBWmR0cGNSVlQ5R1FHWUtkdURPK2ZQY011VWtq?=
 =?utf-8?B?TUtVcU5YdG4wSjlHL2lmUmNEYVVoMW9qNGkyUjlVZVhxTUFnMk41S0h6MEZs?=
 =?utf-8?B?S0ZvbTVxVHZGbW01c0t4b2NkdDNWU0NNLzRVR3BJL2RXZmJIbG8xdDNvZWpj?=
 =?utf-8?B?dzMxWXAvTC9vTEZHYzhJVG5NcDJXKzF0Rk9UOXN4TFJITG9rUy9PNjVna3FZ?=
 =?utf-8?B?NmZxNEFvZHE5SlZzbkxWNzFVSlpVd0o2MDRVY0hzUmprR3RJRWt1NnArY01O?=
 =?utf-8?B?MGZOYUgrUXUvdjh6ZHk0ZUhPaUg1RWNodjdWS09kNTJmdVA5ZXR5WHRtNnpL?=
 =?utf-8?B?bWsxVFZRTUptSG5ULzc4ZmN1Q21TcVJNUlk3cnkxY0E5R3RwL0txQWNCWTlK?=
 =?utf-8?B?c0NZYUw0cE4vZ1IwQWpTNHhuWWVjOFFCS3AxblUvZ0NKcDZWQ2dxazFZRHZS?=
 =?utf-8?B?TkJFeEFsYXNzOVdud3pQSWhZS2x6ZzFubG9sYzdVcTJLYzIweW00aUYzcmVk?=
 =?utf-8?B?RjhtTjFyQUdNRHhuZ2dsWXhxNWhZRk5VRWJvQ3RNNVVHMXlHQTVlSWdPbVlt?=
 =?utf-8?B?KzFxaHRENkVEdGxud1Y3Nk5YZStPQlh4YnY0d0RYdHBVSEpuNDdQdzllMGw1?=
 =?utf-8?B?NnVrWVNvWEtueC8ybWQ1OEQxNzRoZTVDVDFEeXNaM3RaZkZpOW9tam9qc2N2?=
 =?utf-8?B?VEt1S0NwZlkzUzcrbnZIY2pobDBaYzFBNG9kWmN4dlk1T3Q2N3ZSaW5xRTIw?=
 =?utf-8?B?WTlQcFZ2TkM5MG9pbWVDNmd1YmtXbWlCdlBiOE1EL1M1MHhZbGJER3hQcVBa?=
 =?utf-8?B?Z2c5OWE1M1ZlY3N4dkxjU1l3cmJ0UDVWcE0xc1hyaUpsS3NzZHVXSWkySDQ3?=
 =?utf-8?B?dEtpcHdjTTRNQ0lCQTRRM2c5WTJKeTl2cXQrWkxyMTRPdTY3WS9aUnhQTmJL?=
 =?utf-8?B?U05LUWtBcHcvMzJSNjJNRkd5aDh3Ynd3aFZsQmRyY0h3ZkY0bWxtQXlvODIr?=
 =?utf-8?B?cU8yZWMyRkFreFFzTzJsQWx3WmczYm8rZkN5alZqb2tTL2dES21GZDVwakJF?=
 =?utf-8?B?SHdUaXNvb1laM0RkbU81N2FVNUxXZHpPQllWb2pHeGQ1WlJVaEN0NFF1c0Ey?=
 =?utf-8?B?MjZsekFmQ05saU9GMmZvR2NXYmwybjVRbWI3a3RRWVNndmhwSHIwV1NWOUU2?=
 =?utf-8?B?MFlHaVFzdTJweWdZWTZ3cG9uSkhFVkVIeWV6NHZhcytVd3h4cVJPdzVUcVU3?=
 =?utf-8?B?Zy9XYUtNWEUzSWo3dGx3OXFDWjRJdWdyQWhwSkw0U1hGRVJ3S25VY2ZUU084?=
 =?utf-8?B?eVpCaHQwb2FYOHA4RmZHMTQrMWMxSDJXR2k2YTZWaWdzY0NIOG1UZWx0TWxS?=
 =?utf-8?B?NmhoNkp2Q3E0S0JxaW11TCszSEpMVEIwRGpBaFVTOW1VV1dFclVnQ3FqK3FX?=
 =?utf-8?B?TGJNSHZTMEJQdmkyRTBRMjhLcUtrSnJCaWxtb0MvNjBMR0xHbG54ZXZtUjcy?=
 =?utf-8?B?VFp0ZWpSaHdmUzVNaFp6UTcvMnpKOVdmWVV1Y0hGS0FJbjU5akVOVFF1MXor?=
 =?utf-8?B?RHo1UWtkRjNNOVQzQ0M3QnM2N0tPNUtGSGtSaHlLWk03RGptUUVSVTBOd1A4?=
 =?utf-8?B?MzN2K0JtQ2lTOFFRa3FIM3JGUnJYNmJoR0RRQlZmY2ptTGlibEV2M0ZHMkNZ?=
 =?utf-8?B?aGlPNW13a0FZTVJYNlZMMlprT0FtMFZDSkhRSFV1RkYvMi8zL3V5T3dHUHIv?=
 =?utf-8?Q?41W7AA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:57:20.6146
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34441a1-e032-4200-d292-08ddda9b3b54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152

From: Shahar Shitrit <shshitrit@nvidia.com>

Enable configuration of the error burst period — a time window
starting from the first error recovery, during which the reporter
allows recovery attempts for each reported error.

This feature is helpful when a single underlying issue causes
multiple errors, as it delays the start of the grace period
to allow sufficient time for recovering all related errors.
For example, if multiple TX queues time out simultaneously,
a sufficient error burst period could allow all affected TX
queues to be recovered within that window. Without this period,
only the first TX queue that reports a timeout will undergo
recovery, while the remaining TX queues will be blocked once
the grace period begins.

Configuration example:
$ devlink health set pci/0000:00:09.0 reporter tx error_burst_period 500

Configuration example with ynl:
./tools/net/ynl/pyynl/cli.py \
 --spec Documentation/netlink/specs/devlink.yaml \
 --do health-reporter-set --json '{
  "bus-name": "auxiliary",
  "dev-name": "mlx5_core.eth.0",
  "port-index": 65535,
  "health-reporter-name": "tx",
  "health-reporter-error-burst-period": 500
}'

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml      |  6 ++++
 .../networking/devlink/devlink-health.rst     |  2 +-
 include/uapi/linux/devlink.h                  |  2 ++
 net/devlink/health.c                          | 30 +++++++++++++++++--
 net/devlink/netlink_gen.c                     |  5 ++--
 5 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bb87111d5e16..0e81640dd3b2 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -853,6 +853,9 @@ attribute-sets:
         type: nest
         multi-attr: true
         nested-attributes: dl-rate-tc-bws
+      -
+        name: health-reporter-error-burst-period
+        type: u64
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1216,6 +1219,8 @@ attribute-sets:
         name: health-reporter-dump-ts-ns
       -
         name: health-reporter-auto-dump
+      -
+        name: health-reporter-error-burst-period
 
   -
     name: dl-attr-stats
@@ -1961,6 +1966,7 @@ operations:
             - health-reporter-graceful-period
             - health-reporter-auto-recover
             - health-reporter-auto-dump
+            - health-reporter-error-burst-period
 
     -
       name: health-reporter-recover
diff --git a/Documentation/networking/devlink/devlink-health.rst b/Documentation/networking/devlink/devlink-health.rst
index e0b8cfed610a..2279a4370003 100644
--- a/Documentation/networking/devlink/devlink-health.rst
+++ b/Documentation/networking/devlink/devlink-health.rst
@@ -50,7 +50,7 @@ Once an error is reported, devlink health will perform the following actions:
   * Auto recovery attempt is being done. Depends on:
 
     - Auto-recovery configuration
-    - Grace period vs. time passed since last recover
+    - Grace period (and error burst period)  vs. time passed since last recover
 
 Devlink formatted message
 =========================
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9fcb25a0f447..458915c22990 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -636,6 +636,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_RATE_TC_BWS,		/* nested */
 
+	DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD,	/* u64 */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/health.c b/net/devlink/health.c
index c4a028e37277..d01eb4eaf89c 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -113,7 +113,9 @@ __devlink_health_reporter_create(struct devlink *devlink,
 {
 	struct devlink_health_reporter *reporter;
 
-	if (WARN_ON(ops->default_graceful_period && !ops->recover))
+	if (WARN_ON(ops->default_error_burst_period &&
+		    !ops->default_graceful_period) ||
+	    WARN_ON(ops->default_graceful_period && !ops->recover))
 		return ERR_PTR(-EINVAL);
 
 	reporter = kzalloc(sizeof(*reporter), GFP_KERNEL);
@@ -293,6 +295,11 @@ devlink_nl_health_reporter_fill(struct sk_buff *msg,
 	    devlink_nl_put_u64(msg, DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD,
 			       reporter->graceful_period))
 		goto reporter_nest_cancel;
+	if (reporter->ops->recover &&
+	    devlink_nl_put_u64(msg,
+			       DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD,
+			       reporter->error_burst_period))
+		goto reporter_nest_cancel;
 	if (reporter->ops->recover &&
 	    nla_put_u8(msg, DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER,
 		       reporter->auto_recover))
@@ -458,16 +465,33 @@ int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
 
 	if (!reporter->ops->recover &&
 	    (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] ||
-	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER]))
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] ||
+	     info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD]))
 		return -EOPNOTSUPP;
 
 	if (!reporter->ops->dump &&
 	    info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP])
 		return -EOPNOTSUPP;
 
-	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD])
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]) {
 		reporter->graceful_period =
 			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD]);
+		if (!reporter->graceful_period)
+			reporter->error_burst_period = 0;
+	}
+
+	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD]) {
+		u64 burst_period =
+			nla_get_u64(info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD]);
+
+		if (!reporter->graceful_period && burst_period) {
+			NL_SET_ERR_MSG_MOD(info->extack,
+					   "Cannot set error burst period without a grace period.");
+			return -EINVAL;
+		}
+
+		reporter->error_burst_period = burst_period;
+	}
 
 	if (info->attrs[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER])
 		reporter->auto_recover =
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index d97c326a9045..a02da5a0002f 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -389,7 +389,7 @@ static const struct nla_policy devlink_health_reporter_get_dump_nl_policy[DEVLIN
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_SET - do */
-static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP + 1] = {
+static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
@@ -397,6 +397,7 @@ static const struct nla_policy devlink_health_reporter_set_nl_policy[DEVLINK_ATT
 	[DEVLINK_ATTR_HEALTH_REPORTER_GRACEFUL_PERIOD] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_RECOVER] = { .type = NLA_U8, },
 	[DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD] = { .type = NLA_U64, },
 };
 
 /* DEVLINK_CMD_HEALTH_REPORTER_RECOVER - do */
@@ -1032,7 +1033,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_health_reporter_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_health_reporter_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_AUTO_DUMP,
+		.maxattr	= DEVLINK_ATTR_HEALTH_REPORTER_ERR_BURST_PERIOD,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.31.1


