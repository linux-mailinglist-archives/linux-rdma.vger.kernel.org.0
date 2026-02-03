Return-Path: <linux-rdma+bounces-16415-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPA3AF2igWmJIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16415-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:23:09 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027FD5ACB
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 08:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5C5E3078B1F
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 07:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D873921F7;
	Tue,  3 Feb 2026 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CEfCe9dF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012037.outbound.protection.outlook.com [40.107.209.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C067392800;
	Tue,  3 Feb 2026 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770103332; cv=fail; b=SOR1U6c41kSfhzS/f6I/RiOI7xJXx8pz2J74m0ZfkpcQyfFHBUDU/ZGoG9sruDj7ZZd/s9CRH6fP7rJnbbnUY4cA8dyNzOyIO+NspRxeG32L5jETymSoDm+PON3H1X1/xnHc6xAibr7REjFAxg4FOpyFhSWUcE2sEvD5fvMgQ8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770103332; c=relaxed/simple;
	bh=ZZt7rBJNnQ3xbPFiTk/DehgdfawbBgeVVLx4bIAQGWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyyB71hbiepM/WD7d3PThIg2B4PlSbDn17x/orWeNy2bUgwGxFKYFMmt+mnNk4RZEEBNmo2SqTPniLUVRzBqb0BdzuTZsaWEyYNTdP2OhEvnHakKx/41swJA4xt1p7OGAp1WTrFcg8ECJpdwijo4AEtpS8JlRvnVz4MANFopVm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CEfCe9dF; arc=fail smtp.client-ip=40.107.209.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkc2B7vCXg8LCmBikh+EQnvdQgRvOVxbcjU9rDWi23OQ8nAShritOy8KvcTgK0AMbIS+XUsTZkAOfvLa26kSuTHuGGHaP7iwmlfLxq50uilQ8ooUeXhbfK8UxEN0dEbMd5mA9ttNulpJvTIkStxtIOwMjw1tGImEkwEqLpEc0Sx5JbOUaz/pWC71KtazlUJcJP7UaStzF2pJE7+7fvedL2Er2PI6SQpkuCYjvgkNjJqCOgfqXHZWsb9AaCLFtDt8+sxI6o6AKPl2u4+CEYiIj+nOjc99lQeDcwyibcPRtAaNEJs+ks41yi7RyB2b6m8ycyVgfUXXANE4PYw2XRUNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6UAzRg5UK90YAjBbY5Rs62ZcifbNlJz3k9hEzI8Sag=;
 b=jUDlcuP99IrGJNtvpFekyOM2bjBiAUcO4qHyExmw8u6Ds51h1DpYt04LHl2vKVgWJ5KGmMQaCIqbeYHxVaD/sZUWJItHHR+Hexq7pbHBVBAQfXDY2nn6pCorMp4U0Anh4yWj0FES40XMH1KbeR9RypwDeldwEJVXSWzcXQznN82A2AKIN0ghaNxofw7NZcpLogTP4/FV1pMoW2vMRF/bUg83viTo0Yv018ZxtKtGGtwaM9dqHDCchWSekPOx3k37aRR5rKEEyXg42TCSVc7qfnHwmbfX1zZoxf+HpD0OY5/Nb7VV6NGEqWbo2QAggDvHbEtM3oB9wbbX+3cTzlpQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6UAzRg5UK90YAjBbY5Rs62ZcifbNlJz3k9hEzI8Sag=;
 b=CEfCe9dFdKnjxYn89GKAArYXTG6sWl9/2R/YAQKnXbO5ClAx+/R9xECk1yAzP/vxAVDQFuhUD9QvmV8c4KodOkFJyDwsQGwNYizF8/jl/JN+UHriZpRNzSLDSGdlje1/sAzYB6W+RbeUaoYiAGA64FzA9FhXexIocmX8JhkqKSZPks2uI+7XqFRokw1x9i8FZXumbmu5n+6Ovrz5VlULC0Kdj5U8p7T3VCbbK44tttXaUOzVVFX3aJjonPljmSUu/2zQ97kjbsaKVpJgYBiepgw2cK8xcxVzzctcYyEHtz0oh6JR4fhGBwoDQCnKZiGcat5OGMjdqIS8ZZjFkuAUYA==
Received: from BYAPR05CA0063.namprd05.prod.outlook.com (2603:10b6:a03:74::40)
 by MN2PR12MB4357.namprd12.prod.outlook.com (2603:10b6:208:262::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:22:05 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:74:cafe::88) by BYAPR05CA0063.outlook.office365.com
 (2603:10b6:a03:74::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 07:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:22:04 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 2 Feb
 2026 23:21:58 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 2 Feb 2026 23:21:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 2 Feb 2026 23:21:54 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>
Subject: [PATCH net-next V2 1/2] net/mlx5e: RX, Drop oversized packets in non-linear mode
Date: Tue, 3 Feb 2026 09:21:29 +0200
Message-ID: <20260203072130.1710255-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260203072130.1710255-1-tariqt@nvidia.com>
References: <20260203072130.1710255-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|MN2PR12MB4357:EE_
X-MS-Office365-Filtering-Correlation-Id: 20841f1d-ec3c-4ed7-afda-08de62f4eea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odosvRlICWJWgm35MPnXmxewI05V6P+fPIbdBOLKXiO55pdfHOXlX8G133Dr?=
 =?us-ascii?Q?fFQJtjoKs9MusXvvs1ky5PDQZjuVEOP4b3d+7PF/M4E/zLtXpCl+lMN2+zFR?=
 =?us-ascii?Q?UNpKhgnP/asB5A+BnSm7pELS0JKbfM5s0Dg7QW2Ui0pUB+jOTYC2AtHWWTVh?=
 =?us-ascii?Q?lA2GAdFaEdB/7MdSeHne82xJY1Oh4TubOlYt2pl8mvrJxkCGZF9i/sElxBB5?=
 =?us-ascii?Q?baqH8mV6OU4e+9o6NszLbs6wjzZkTtLgPnrTqKGVHRSiNLAzx3dE5mWaScPO?=
 =?us-ascii?Q?VSkIwJLfYlot+91oif+0zvw5KijxPWtkgjwhyvt9+Cgb14lVPEhqs/S30pb6?=
 =?us-ascii?Q?a+8t81enqhqI9U0tF7xNOGgAnSHt5+afZi188ZD+JvzDKdf8vFN2FPNxzijr?=
 =?us-ascii?Q?VGKNzj+iL/F+qAIuHYJechqa1O9eKyy/UiiFKvFv3Yr1ORSHkSvxrAo3kz9m?=
 =?us-ascii?Q?Fw3Ent6jxiEEgwCJpZKOJ4ouZftv5j753s9SWZDGMdhbdcVgWVTdru123nMt?=
 =?us-ascii?Q?25Y9YecLLoPrWJtKZzELH5pIINQ85tDXJjgif6uADlX6k8G2/I4fXqWlXyN8?=
 =?us-ascii?Q?+aDBtqgqt8yqghKT4is+vjXTrzmlMzPI5HyR90nqCUqJFOC4DXlt7UxGcceK?=
 =?us-ascii?Q?40zOz4Syo3qeJuIqCGfwfeaV+4jfvr/Q6ERbJqiHV7WswLl9Gu0+00egGVPv?=
 =?us-ascii?Q?ey3CoufJrgjE014gymSkiTptP7fjf9Dz2oyxQL46esyUwyJ5czOgV4Dy5U9C?=
 =?us-ascii?Q?UJrKvsbOjwYposg2RI46vNHURgjaClhXBNb6mbxu3zzzGXVQ9/PCXfiNO1N8?=
 =?us-ascii?Q?u43VPCVbX0Vy+u0IaKytC7Uf84cxXButS9mF+SHr7fmQ15huZRrdKFndiHkq?=
 =?us-ascii?Q?4j+2f6aRdfTFG2HhBWaSV/4cY4ri9DfBGNVXwlrhwmyUBhvoVw4Ve1JoL5lD?=
 =?us-ascii?Q?Dw8uyDE7HQA1rX4L2c1x1DRrRhUtMoQkh8+W+m3EFVTUHv+2J7tTZC63X2pb?=
 =?us-ascii?Q?fN/0/D9ib1c+dXqlhKYS8cJXVUb59fq4IRfxezZbnCau5T3rJ1grZmZIL7MO?=
 =?us-ascii?Q?tzB4TcVy8INh83M97STjY15VaSWD9EkZOu/jAV7SMKYrwFsaZ9FEyz+kiZA/?=
 =?us-ascii?Q?C6cOmz1zYioSivADpu1uw6b+nEoTAEeuM8ekS9sCfArZcZ6dOm9tYekDtj0q?=
 =?us-ascii?Q?Mym3hA1JA4uRPc4WyAz5Vro65dhTuw0A+kLLq8PGknUWTzobbGpktqOo4fJj?=
 =?us-ascii?Q?wW1WZM9aTgO7zjfkWvh7FT51zBBFv0B0EOhvDo/b8OQmuGxwdIIuDRMHHYLA?=
 =?us-ascii?Q?78TgMMMjbtplYHXbh/yK69qc2Kd+/M2qnR1pkOHpeM6e5d/dtlmgGM39iLhG?=
 =?us-ascii?Q?DEkMei83uxZw1IuJbaWczqCMRRsHa6A7B3flyaRs5gGl/0cshJn6VwXd8s5b?=
 =?us-ascii?Q?9VJbkTo2yQpzSsfsW8piazdrgx3TUgkH2GEOhfHXpaOGo0KKagX2gUvLyOoE?=
 =?us-ascii?Q?qhAOhcmckzB205t7HaYel9hZms/sZHGtxlCgaeve1SOjP7NV5jPWCeZkoLpF?=
 =?us-ascii?Q?6Zg8fZ95ADPjrk5yAdbMYKPou50PLqrfhgAcrUn85+SswX9AWVsuZfSuZGOU?=
 =?us-ascii?Q?mwkjDmPN3WA2xPxjEe5BPr3AtvCxCm5IZ1FLJkFrGuQ2ZOtV6CJ7EN5GMKt1?=
 =?us-ascii?Q?nbo4GA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W9v2Sy9f2z/JnYxThIK53WrMzwK+u743Fa10rfLRSXDUOM5xeTBCvyauuocv+FIHcPFNg5JsXwchMy8UNghF1CgpFE6o2xVx3/e8NGhdWR1Qa3jisZ4p4pokczQH5c9xhePlOgTO6sndDSeGwlOmzVUNuEskqJzV9r/83jCfLqK1AjaqMwaHH3LgyT2Tv2SghSAqQc8X1/2oJkJ1MSP8O4sXthQiDbErvv6KJV5AoL04Kr566VfKrwbG7aO+BBJ2j0uiPg4boBi59Ti+MwjSbhQSbkTSy7m87G8FS69DjPJQ4PegHmfTwlQMx8GHKwOhQeFtZrwBC3OXfbqmLRl7kndIkrWL5wq0JRtfreABLJ80pEa1CG8EiopeRGPSgwSUpvHeY34rAS/CFAG8PH3BxmizFoYDjIj4O33dNq/RJGczy3o2UZ3tKJDyPIcN+P2u
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:22:04.8291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20841f1d-ec3c-4ed7-afda-08de62f4eea5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4357
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16415-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 6027FD5ACB
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently the driver has an inconsistent behaviour between modes when it
comes to oversized packets that are not dropped through the physical MTU
check in HW. This can happen for Multi Host configurations where each
port has a different MTU.

Current behavior:

1) Striding RQ in linear mode drops the packet in SW and counts it
   with oversize_pkts_sw_drop.

2) Striding RQ in non-linear mode allows it like a normal packet.

3) Legacy RQ can't receive oversized packets by design:
   the RX WQE uses MTU sized packet buffers.

This inconsistency is not a violation of the netdev policy [1]
but it is better to be consistent across modes.

This patch aligns (2) with (1) and (3). One exception is added for
LRO: don't drop the oversized packet if it is an LRO packet.

As now rq->hw_mtu always needs to be updated during the MTU change flow,
drop the reset avoidance optimization from mlx5e_change_mtu().

Extract the CQE LRO segments reading into a helper function as it
is used twice now.

[1] Documentation/networking/netdevices.rst#L205

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 25 ++-----------------
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 11 +++++++-
 include/linux/mlx5/device.h                   |  5 ++++
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 96dc6a6dc737..71e663c3b421 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4716,7 +4716,6 @@ int mlx5e_change_mtu(struct net_device *netdev, int new_mtu,
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_params new_params;
 	struct mlx5e_params *params;
-	bool reset = true;
 	int err = 0;
 
 	mutex_lock(&priv->state_lock);
@@ -4742,28 +4741,8 @@ int mlx5e_change_mtu(struct net_device *netdev, int new_mtu,
 		goto out;
 	}
 
-	if (params->packet_merge.type == MLX5E_PACKET_MERGE_LRO)
-		reset = false;
-
-	if (params->rq_wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ &&
-	    params->packet_merge.type != MLX5E_PACKET_MERGE_SHAMPO) {
-		bool is_linear_old = mlx5e_rx_mpwqe_is_linear_skb(priv->mdev, params, NULL);
-		bool is_linear_new = mlx5e_rx_mpwqe_is_linear_skb(priv->mdev,
-								  &new_params, NULL);
-		u8 sz_old = mlx5e_mpwqe_get_log_rq_size(priv->mdev, params, NULL);
-		u8 sz_new = mlx5e_mpwqe_get_log_rq_size(priv->mdev, &new_params, NULL);
-
-		/* Always reset in linear mode - hw_mtu is used in data path.
-		 * Check that the mode was non-linear and didn't change.
-		 * If XSK is active, XSK RQs are linear.
-		 * Reset if the RQ size changed, even if it's non-linear.
-		 */
-		if (!is_linear_old && !is_linear_new && !priv->xsk.refcnt &&
-		    sz_old == sz_new)
-			reset = false;
-	}
-
-	err = mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL, reset);
+	err = mlx5e_safe_switch_params(priv, &new_params, preactivate, NULL,
+				       true);
 
 out:
 	WRITE_ONCE(netdev->mtu, params->sw_mtu);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1fc3720d2201..05b682327305 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1574,7 +1574,7 @@ static inline bool mlx5e_build_rx_skb(struct mlx5_cqe64 *cqe,
 				      struct mlx5e_rq *rq,
 				      struct sk_buff *skb)
 {
-	u8 lro_num_seg = be32_to_cpu(cqe->srqn) >> 24;
+	u8 lro_num_seg = get_cqe_lro_num_seg(cqe);
 	struct mlx5e_rq_stats *stats = rq->stats;
 	struct net_device *netdev = rq->netdev;
 
@@ -2058,6 +2058,15 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	u16 linear_hr;
 	void *va;
 
+	if (unlikely(cqe_bcnt > rq->hw_mtu)) {
+		u8 lro_num_seg = get_cqe_lro_num_seg(cqe);
+
+		if (lro_num_seg <= 1) {
+			rq->stats->oversize_pkts_sw_drop++;
+			return NULL;
+		}
+	}
+
 	prog = rcu_dereference(rq->xdp_prog);
 
 	if (prog) {
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index d7f46a8fbfa1..b37fe39cef27 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -962,6 +962,11 @@ static inline u16 get_cqe_flow_tag(struct mlx5_cqe64 *cqe)
 	return be32_to_cpu(cqe->sop_drop_qpn) & 0xFFF;
 }
 
+static inline u8 get_cqe_lro_num_seg(struct mlx5_cqe64 *cqe)
+{
+	return be32_to_cpu(cqe->srqn) >> 24;
+}
+
 #define MLX5_MPWQE_LOG_NUM_STRIDES_EXT_BASE	3
 #define MLX5_MPWQE_LOG_NUM_STRIDES_BASE		9
 #define MLX5_MPWQE_LOG_NUM_STRIDES_MAX		16
-- 
2.44.0


