Return-Path: <linux-rdma+bounces-17692-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAC4ObgdrWnoyQEAu9opvQ
	(envelope-from <linux-rdma+bounces-17692-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:56:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ABE22ECE0
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Mar 2026 07:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A63E3010DAE
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Mar 2026 06:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD6D314A7A;
	Sun,  8 Mar 2026 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nR1tP1MD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930892D7DF8;
	Sun,  8 Mar 2026 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772953005; cv=fail; b=ApeHK3Q4/gCweEJiH5Cj8uyKmb5cJ7HTM/TRhEhpHkosXYMhauMpUcN2kC81VpbpVS4ngin4Ol8hTMbNbrHzcpugK9+ymDcsJchzfRttFGMjoi+cwSYmYFQt/Wh/nr8bvSi3PuY4mtK7e/8uuXPHGP4x8kyx5s1wqb8FPg0qmO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772953005; c=relaxed/simple;
	bh=/3dyUuyqDv6dAvmGWBcbRmZwCHN0oaBpDh1u35hLukA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jQ7X+Fr4IrF/Hmkl7DGs9MFp8xUYbwa8oqN/Qd2Oeo3GrvaFZKCQFO9wQI+5z33ViPrrHYx2GOgEH5n2eooCK6EzqlYBLFzfjzuqtNk93D4Iquy4TOjK0EiStodTc50DWictbQkwYhWoT9HRk1z4XyDur2cVQs9d3KUvxGsUFOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nR1tP1MD; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3n1zAwJ7MImwhMX2r0iQNEHgPipMFPXyjyLbmeW2XjuSQbn0XrfUBp5fODmOIxeCspF0WJ4hYLiNUbxvCvy8ZBT3glaSEAXJibijz8T1s8NEVdeFa0YF2YBSzZ9fH9ieF7tB1YD3bNXdWxxw1KVFgc7Yf/s9x59cJSRvfWilx1973lzliXdNj8nu0fMHGNwCug3+yUDWD1uhDpu9JNeLAdKVJ3zCERCvCYROXOdpmT9ShZ44n5yCnn/eZ3WY89Bf0oBdUTyzvz5aA8BDMyVrLt37MK+ATij0EPjjop9cCDU+KraKm1B6yGMV3sEvy3eCz0LUROq6VEtKP8kNaOX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvC8Sk2+/TkVmEPWoQMinDPf13Fe4/0/pydQr191+EY=;
 b=s1yiQOMQ+8wuahZGy9Gx2CI0ohHEe117Zi3UKya/XQvZNjvmXY2MGBNGLuQ6DF4ML1pm8wQCxd+8GVpMxZXazffydL9BDZ8UkWP0A6qY2GfLvGnGCbmEgccWySq26ei89I/MIgab9ZRaprVjN1DPVb6EvyEfZAEazg7WllbVPFZ/2lsgw6CRJQi9i2Mg44ZKVlqQRbk/aX1SFxnNtEkO2vfs4nejM9fPOOOVTj9Tx30Le1g+O69PXpnv2VkMSoooERIQ0lypxmi3DGDIAOKKfrDYpFuB2XoBe6qnAPzkem+De7zdYjUMo18ojymWo8MS16+q7kqkq2aOq/FS184YvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvC8Sk2+/TkVmEPWoQMinDPf13Fe4/0/pydQr191+EY=;
 b=nR1tP1MD1WOJ8uJb9QMPf/NcWulEf2qyCLGFvlzVqf7Wn8rl90ArLWN4lL29VDSANnpSIbmMYKsVUXH8BwpxAb4rkx7jEpyvS2dFhAJL8PXKUg9N/fbIJ2AOlY8OBA9J62JZ7GKl+rDTbZ5b3V3KDhd73CiO/e5Pf4ZhRQiaYAxmvHp6N3VSSzIEQPoQms+RiOHTX8+V7jN1hf5I3RHAkvJkGkZ2oAfkOcAFasMsROOF8ob/35UTQoWEeLfBxti0YErcso81K4MCvjVVW/5fn+pMs35EruEFX7K8ohndNJkPo9HFqfEzlL3ISzFm6n00BvWpCJ8dALbir6H3KNA7Og==
Received: from BY5PR20CA0023.namprd20.prod.outlook.com (2603:10b6:a03:1f4::36)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.9; Sun, 8 Mar
 2026 06:56:39 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::1e) by BY5PR20CA0023.outlook.office365.com
 (2603:10b6:a03:1f4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Sun,
 8 Mar 2026 06:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sun, 8 Mar 2026 06:56:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 7 Mar
 2026 22:56:26 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sat, 7 Mar 2026 22:56:25 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sat, 7 Mar 2026 22:56:22 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Alexei Lazar <alazar@nvidia.com>
Subject: [PATCH mlx5-next 0/8] mlx5-next updates 2026-03-08
Date: Sun, 8 Mar 2026 08:55:51 +0200
Message-ID: <20260308065559.1837449-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 13155311-db56-4ea0-45c9-08de7cdfd8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	X0lRjM+CfMDj78HvtPrCaYT8bTs9G9FX24BPtHXX7ZAAAPzVQcGIszgkWGbFRqctYcGn/25dXsL3oVFsqYNv3dSBauWUkb4oWDXWNWSQEQdWk+2CvAHglkyqA17KXyv7yhW3a5bDnHuzp58hEd+jJSKt/LuV6qIG9omUQ60ly/myL8pu/IIXU/YWFkFJSWDfiubeqog6TuY5dfFhFGeA6o1pMsApFr6mq8NVKSZOOXw1G7qZvgWIeg0p1S0E2mlTLl6GOgVVGh+JsholhxAYCol0GOJfYQMgJLeZcK8q83l3JELiup/TtDoZyPYNTW2KaY1hK+f1TLycTv00EgnuinGp6zyW7MyARCGv2P3Gt1zpyJProP6N3zfnl07HE0yN7V7E2WBxyQ9p/Zvhl5fL/x71zPRgxgB5ezyxmYd6Zx1+Tfm4SyUffZLV3mfuURhms7oScH4KXv92axzxw4N+RLJl61ihfK0VU2rJ3q4TnemKfckSytmjXlH6jG1yM3fQYLYN4PsBR5oDA2z1WhQsbTU5jbHRlSvSRsOqQIiz4PpFhAyHQs2szjquj7zZe+64JWZKmMJp2umm0GkK09wqiY2lRpaasnZB/67sw2UROSb/QWjz8HXsWhrHj1wZQLe2g1n35UmNqcw2hcHKfsnf1dYH5jGxXUVoqpbuDueBMZmvmNzi3Y6adqEjZdZLrx8NTDdD+NVprZUXXKSGUyon/ZnXVIlbCDGNzmqpSBT3W1nErud0ZBLZtW7T94hwrNCs0euaXpkYviqeN7RIGNRA4A==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m2xqJmhWv0v3R+dMzEF2uvKbyuqfPm0J5Sx4ULy6KjfRw7kFTycqLnklgxcm5ZH1HPdbaBrwauM65J9luGJwIWmJrUICZuJv5AOVlVMrAUtXKi5RQ/+l+rjiN8CVYyEaSbHBA8fFkxqBLwJoB0ndNhSoiXfXEyPj5wZN2pUlSgpS2L/iVU0DzdP/PIB1nv90uAFt5D9C2F5/MlGvkHJvCw0vFTM5z113/GQVc8+zYzxMpydi/TIhColy4sfixYqQe2N1E1dSCuU5bZaxJRUgwiZeQQY7SA1d+7RuekC4Qyv0Q6YJdrikRNn3kUJH5UdyQf5LpkGmE+qrZAyA+uY82vVbTfujRK4/ZH5JdE5Xx8Z87jd2AkVRkthKyt0wk2QWl3PiU3yVblS7l5PoLoNs7avT+qujPO++dnaF/W4eyQB6s3ix8TNaf1ICiQXJJVDi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 06:56:38.7375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13155311-db56-4ea0-45c9-08de7cdfd8a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-Rspamd-Queue-Id: 89ABE22ECE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17692-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi,

This series contains mlx5 shared updates as preparation for upcoming
features.

First patch by Alex contains IFC changes as preparation for an upcoming
feature.

Patches 2 and up by Shay introduce mlx5 infrastructure for SD switchdev
and LAG support.
Detailed description by Shay below.

Regards,
Tariq

This series adds shared infrastructure to enable Socket Direct (SD)
single-netdev switchdev transition and LAG support in subsequent patches.

Currently, LAG is not supported in Socket Direct configurations, and
BlueField-3/4 utilizing SD for North-South traffic operates with two
distinct eSwitches per physical port. This forces the use of separate
IPs and MAC addresses for each NUMA node, complicating network
configuration and requiring firmware to handle MPFS with different
inner and outer packets for communication.

The goal is to expose a single external IP address (single MAC address)
per physical port while maintaining SD's bandwidth and latency benefits.
This means having a single eswitch per physical port managing all
physical ports via merged eswitch with multiple vports. This enables
single FDB creation which will result in a single RDMA device to be used by
DOCA/HWS/OVS.

To achieve this, the LAG infrastructure needs changes since the current
implementation assumes a fixed mapping between device indices and LAG
ports, which breaks with SD's multi-device-per-port model.

This series prepares the groundwork by:

1. Adding IFC bits for silent mode query and VHCA RX destination type,
   needed for SD device coordination and cross-VHCA traffic steering.

2. Converting the LAG pf array to xarray and using xa_alloc for dynamic
   index management. This decouples LAG indexing from physical device
   indices, allowing flexible device membership.

3. Convert peer_miss_rule array to xarray, key with vhca_id.

4. Introducing LAG variant of device index helpers that produce unique
   identifiers even when multiple devices share the same physical port.

5. Adding VHCA RX flow destination support for steering traffic to a
   specific VHCA's receive path.

6. Moving LAG demux table ownership to the LAG layer with APIs for
   SW-only LAG modes where firmware cannot create the demux table.

A follow-up series will build on this infrastructure to implement:
- SD single-netdev switchdev mode transition with shared FDB
  corresponded to the SD group.
- LAG support enabling bonding of SD groups

Since the follow-up series is large (~20 patches), the shared code
between RDMA and net is sent in advance to avoid overloading the
shared branch tree.

Alexei Lazar (1):
  net/mlx5: Add IFC bits for shared headroom pool PBMC support

Shay Drory (6):
  net/mlx5: Add silent mode set/query and VHCA RX IFC bits
  net/mlx5: LAG, replace pf array with xarray
  net/mlx5: E-switch, modify peer miss rule index to vhca_id
  net/mlx5: LAG, replace mlx5_get_dev_index with LAG sequence number
  net/mlx5: Add VHCA RX flow destination support for FW steering
  {net/RDMA}/mlx5: Add LAG demux table API and vport demux rules

Tariq Toukan (1):
  net/mlx5: LAG, use xa_alloc to manage LAG device indices

 drivers/infiniband/hw/mlx5/ib_rep.c           |  24 +-
 drivers/infiniband/hw/mlx5/main.c             |  21 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h          |   1 -
 .../mellanox/mlx5/core/diag/fs_tracepoint.c   |   3 +
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  14 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 103 ++-
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  17 +-
 .../ethernet/mellanox/mlx5/core/lag/debugfs.c |   3 +-
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 684 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/lag/lag.h |  49 +-
 .../net/ethernet/mellanox/mlx5/core/lag/mp.c  |  20 +-
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  15 +-
 .../mellanox/mlx5/core/lag/port_sel.c         |  28 +-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |   2 +-
 include/linux/mlx5/fs.h                       |  10 +-
 include/linux/mlx5/lag.h                      |  21 +
 include/linux/mlx5/mlx5_ifc.h                 |  26 +-
 19 files changed, 849 insertions(+), 207 deletions(-)
 create mode 100644 include/linux/mlx5/lag.h


base-commit: 385a06f74ff7a03e3fb0b15fb87cfeb052d75073
-- 
2.44.0


