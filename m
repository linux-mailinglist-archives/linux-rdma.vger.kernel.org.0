Return-Path: <linux-rdma+bounces-17073-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DnIFx++nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17073-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:52:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117517D3AB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0F6E308F837
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C982137BE91;
	Mon, 23 Feb 2026 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MWKihAsy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C517D37BE62;
	Mon, 23 Feb 2026 20:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879432; cv=fail; b=k9Lc8xm7g8xd2YFjC7O+O65e2JaZQLVIVV8c++VhQBp/Bx58UqPQyS7zXDSzyBZ5k5z7rvHxK19HQ8Xb+n3dxN1CYQGt+Mc5Z5IhvJ6Etv9fnIiQeYiDweLMBAhevrIQe/WLGE4Py3FyRoG+gkgo0VLlQw6fNZ+sCAvyqTbiTVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879432; c=relaxed/simple;
	bh=OiEjjZohXdKwv79Ik540/dRukQtuOU0ZNrmCtCXLceg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxRiNd6UjPO3rBVGjJfYiFAilGQSc35a6P8i6+UKmBnsA95yNmhP3FaOCNpwAnb6A7jsh7pgeigsYVfGMPfGY8azYLVErwYVLJwI7iipjU+RGo+NSGuLoKVm4cusvfx+Jy8/F/1dEeue5LhcFyxIyXMjZ4+xUHAsqqjrGyFBb1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MWKihAsy; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cx8BOwIOkgLXvv23eBkTYFGfQDhsk1ktDk2MUm3LJAGbFbiiJyl/S/CzYgXindqb06kYyeqTH614ShDN3ci+uLs/McoDzQAQRsxjr37P4AGC2v7zxKjbr4R3oI5zNc9v9S0ZGR8iFbNM8SxkexKD0qKaoGhankcL1aplHNojHx5ZDTXh9w49OOoxRKtbRTcS028UprR22SVauptytnAcu+PG3xm6maF97jGzfLcz+vLuXXbHAHsAgNq2415Cxxthm2GKsLO4F2ql2ZEjTpJiuEu10dp4DvCVT1fTcQ+7XP2gUsIJObKj0i4JHpWmDPbMAzgLT4RUL/wE4jWAMsrW7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NqdIGTZnC9lkYPa5QgwOVhE/jELvi9+tCq5J6c5RGE=;
 b=e+ZMOuUlKVWRlqW8iZ2G3n888eZAPI95kutA1zT1pvNhnsBTgNbCJ+jL1MmrToLUh+tzY1gRyKV8NLxTU+e/dKPOlaWBUtLPqfdlHsk2Sy9k6+wgA+51EJfklPy/OKSFA2JJq8c5c2qLWSv+IQIf825bIK5FPuWs2p5LDMzNfHvobnwi78Y4DVgYPgI1lmPA+Msmebb8rYh52WGjiSBYWbRRireiM7ceLaDWiFebhkP/cm55wZrummVvC8UIF6qoEiX4LmGtFHJYgBZK6Rh3MYEbUjSc82En/IvyaACCIGtPMHWOB9U0OGY8aviW/0qgfiqv4+rPlKQRuYuuBIYSlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NqdIGTZnC9lkYPa5QgwOVhE/jELvi9+tCq5J6c5RGE=;
 b=MWKihAsya2Of/GvGm/a2/uoAjV26OJ6DsgPAR9oRsJIPdVv73/WAHTJq2o90KJCsRueKhnreO0susblQy/fgy86JeQUIrX0Qgx4z6QsUBKt0TuRaPpzOIlJnq6JIwai6rMlfHrbrLUpyr2eEkannXmoZZJlIbaoaLASbXRqV+Zyl1Z+YTIgMZ/8gvwfHO0Sy880hPvSdx22BVTcj2g4IXCsS3AqxTkCsnceOEV+6cXU/dp+nI4zz1ytgKKfv0dJAt/M6jPh63t7pI/cylRCLWe2BGqUdQdxE9p0nMrXhSdp7Fu57cTPaedQq4S4K5J7ZNTA9Qcxrpdh2sRh1z88OFg==
Received: from BY3PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:39b::13)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:28 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::1f) by BY3PR05CA0038.outlook.office365.com
 (2603:10b6:a03:39b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:28 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Pavel Begunkov <asml.silence@gmail.com>, David Wei
	<dw@davidwei.uk>
Subject: [PATCH net-next 06/15] net/mlx5e: Move xsk param into new option container struct
Date: Mon, 23 Feb 2026 22:41:46 +0200
Message-ID: <20260223204155.1783580-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260223204155.1783580-1-tariqt@nvidia.com>
References: <20260223204155.1783580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 538353c6-e85a-4529-ff4d-08de731c32de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9iIpFlzEOSrCUUSegn/+f4rjct0pwSu/ORNSE407aC18c/ol3Z91ZvC/8NWm?=
 =?us-ascii?Q?7fUpGzz53YhLDyJtdTnnCCRbEF74e5GbtykRvgCiLnEPaJSYsLSSSLLpSvCw?=
 =?us-ascii?Q?nx2qJqrYPp55w7tWSxPO2ozbcTmCe73JTX/7pFAN69ka53yEZOPFKA1zo9VM?=
 =?us-ascii?Q?W5rrHYtHCVl5PuMCPqCGzIfNsJI060RzhqDeHTjHEO+vY88PXC0ZsRQvYtYx?=
 =?us-ascii?Q?BaxGc4W17ggwUj1dM/upEDB7yWg5GcG4bLdUGfhLVLhvHYzkBx32GuZJjwnw?=
 =?us-ascii?Q?Eexc4oQURUmYd7sMYg801NnWguTxqeq85Lm+d4zEX7bXsVoQYucMqbFxu5GQ?=
 =?us-ascii?Q?d6hVikwN9hYJ/I3QV95mp8kR6KKluHM7MwXy11g37qJe+G7YsWDWBOLD2coT?=
 =?us-ascii?Q?X+3xZYLClitJt59R9VDdNLRsBNDrgr/MZ4H42i2j+/Shtlgj6FF3/jSaxuLJ?=
 =?us-ascii?Q?oJNhLLkstwkPeucQZgDKBNPvHJcmbNrDyzykZd+17sNob2V31dIHXR0l2uJF?=
 =?us-ascii?Q?J/tEMDNSQp2OQEjhSxnuw14DWR338ZNs0/DhUsNCetJomyxMbjlBFM5SRl3s?=
 =?us-ascii?Q?NMYdTF/QQ59eQv2Mc3BjnJf9HaAYlD8HGCUWNaXmnQZ0L/FVPRluizNMsNiK?=
 =?us-ascii?Q?0a6k77nv0JmsI+Z2XuohjRacIX44uQdzJWIaRRKSofTq/w82WWsPPq1w6Ji+?=
 =?us-ascii?Q?GsC4D56CEWWgJBEwCie+wJzWIBehkJ2nL6L2ehlkWM+U3D/TUVjEpwlej05A?=
 =?us-ascii?Q?dt4fzvGV4Fe9W6ImlSHahOYYvWyYBejxeiRmZRrBydLU9jGCA9YiqSZFvNW9?=
 =?us-ascii?Q?cyI9XayVRU4Sgp/NqO2lbILmWhphwpn9R/22YqmUPRUxc7xawjF540VUoBG4?=
 =?us-ascii?Q?I0Z97ROsT4/yM+5OtsSEuMy6TelMGY9hIHegKDEeJcz9nZxDNHpSy7JIU7HA?=
 =?us-ascii?Q?AQKMr0uUHnAakm8SeCTzdHLmyN4RCqtY2nmo3xRFtiHMZPp+hBv4jQBA9hwI?=
 =?us-ascii?Q?JbaXBewFVlkTQw0e6mbzwzXxbPOJOoSdiNi1mPkMdpo8rF1a92Gy0duV/VrA?=
 =?us-ascii?Q?ouk4C4proEBCweoWv2pEdtZ9JgBIGITrgWyfIJlACe2JcxY35DUeC98bURkF?=
 =?us-ascii?Q?ipXdBnT8Ya7tCL/5QhlN7P+BqD+ufYgDC+jr01MOV0wH5WJUOMMsbMZE2v9e?=
 =?us-ascii?Q?vd30EqKMnyd/CKcEDFuOXQDRU5TCzYQ5YHEWf+BRyHH6ajM0hVRUdLd8u8nm?=
 =?us-ascii?Q?+BbM10j88TBnPPLkUTXlC1zlqwD86VTpHBK5iqZH6TPYld4RIP607jj6GFAR?=
 =?us-ascii?Q?K+Cy30yMt6AAdhk0XFD2iuZVjJB3rcymslssiK5LZLobXjGS14KsY3rC1c1B?=
 =?us-ascii?Q?YcWheoqYAfua5fZeCHC3MnX3qk2oQnwHOw8YB+uOzThLjGbaDhzQVVkmOGJP?=
 =?us-ascii?Q?V8Pw3y0x7LzII2AXU4QUlAmOhIROE3BuKgJ7MeSG0U4IJ4YQqmOn5lrogx+P?=
 =?us-ascii?Q?NX2bYcJCzwpkYvxVkr78jaZLDCh53MT0pk9PJA9dFSqqLIffCAB0WrNJyi6u?=
 =?us-ascii?Q?ejxsqe6dm3QzaFcEagRQEdibtMNmKVf0J3rFZZ5rNtdag68VAy2Tv8NeX7RE?=
 =?us-ascii?Q?x65s/1YuDxraRQl5f1oMTNY+aGIhXbYnMqB68Y1vgS5rXN+mNJr9shJoQDTd?=
 =?us-ascii?Q?ZzDfUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r/8+nUpkYHu3CGBiMgyqMrQfn+t41lvfIM3E7dMqTdZmtwPQJCxRoe6abc4ohCgkXoRmflOrsya+UqhNGnYrtzHTW8Vqmtlgi/wZfgJIVwyM5eA+Sr6qOEcA3SVDgRVazPnsyCIzAsdkB9FOStYc5wrXlJr7p7hHq8FiC4bL9UMHhWgRQP5n1NkiNLZlydkzwg6PUdiSvDAUrFIVw9KaXUdT0P2Epy9EXN0OudHSdPgUJ/POpRgs8qFvVGKx9HnwrkRipxu+1+fsa7hqp3QMMNbqgDmBzBPTKjqeCjhogRjH+ooLeozUsdg+FMATi3ge3W7b+osofGTesvgL0uLlOXqT2E8VHV+ZYfrmTcMqiM7+K5gVmaQGGO3C/qtrHMi8ApYNMYUKbiwciv1dAVnHXJdfBUJ+Cb78HvBXfapT6hcPjFFeHxWxH2Fd1FGutlPs
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:28.2569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 538353c6-e85a-4529-ff4d-08de731c32de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17073-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 4117517D3AB
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

The xsk parameter configuration (struct mlx5e_xsk_param) is passed
around many places during parameter calculation. It is used to contain
channel specific information (as opposed to the global info from
struct mlx5e_params).

Upcoming changes will need to push similar channel specific rq
configuration. Instead of adding one more parameter to all these
functions, create a new container structure that has optional rq
specific parameters. The xsk parameter will be the first of such kind.

The new container struct is itself optional. That means that before
checking its members, it has to be checked itself for validity.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/params.c   | 192 ++++++++++--------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  38 ++--
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/xsk/pool.c |   6 +-
 .../mellanox/mlx5/core/en/xsk/setup.c         |  31 +--
 .../mellanox/mlx5/core/en/xsk/setup.h         |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  33 +--
 9 files changed, 185 insertions(+), 128 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 550426979627..5181d6ab39ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1060,8 +1060,9 @@ void mlx5e_timestamp_init(struct mlx5e_priv *priv);
 struct mlx5e_xsk_param;
 
 struct mlx5e_rq_param;
+struct mlx5e_rq_opt_param;
 int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *rq_param,
-		  struct mlx5e_xsk_param *xsk, int node, u16 q_counter,
+		  struct mlx5e_rq_opt_param *rqo, int node, u16 q_counter,
 		  struct mlx5e_rq *rq);
 #define MLX5E_RQ_WQES_TIMEOUT 20000 /* msecs */
 int mlx5e_wait_for_min_rx_wqes(struct mlx5e_rq *rq, int wait_time);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index ef88097c1d4d..97f5d1c2adea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -21,10 +21,14 @@ static u8 mlx5e_mpwrq_min_page_shift(struct mlx5_core_dev *mdev)
 	return min_page_shift ? : 12;
 }
 
-u8 mlx5e_mpwrq_page_shift(struct mlx5_core_dev *mdev, struct mlx5e_xsk_param *xsk)
+u8 mlx5e_mpwrq_page_shift(struct mlx5_core_dev *mdev,
+			  struct mlx5e_rq_opt_param *rqo)
 {
-	u8 req_page_shift = xsk ? order_base_2(xsk->chunk_size) : PAGE_SHIFT;
+	struct mlx5e_xsk_param *xsk = mlx5e_rqo_xsk_param(rqo);
 	u8 min_page_shift = mlx5e_mpwrq_min_page_shift(mdev);
+	u8 req_page_shift;
+
+	req_page_shift = xsk ? order_base_2(xsk->chunk_size) : PAGE_SHIFT;
 
 	/* Regular RQ uses order-0 pages, the NIC must be able to map them. */
 	if (WARN_ON_ONCE(!xsk && req_page_shift < min_page_shift))
@@ -34,7 +38,8 @@ u8 mlx5e_mpwrq_page_shift(struct mlx5_core_dev *mdev, struct mlx5e_xsk_param *xs
 }
 
 enum mlx5e_mpwrq_umr_mode
-mlx5e_mpwrq_umr_mode(struct mlx5_core_dev *mdev, struct mlx5e_xsk_param *xsk)
+mlx5e_mpwrq_umr_mode(struct mlx5_core_dev *mdev,
+		     struct mlx5e_rq_opt_param *rqo)
 {
 	/* Different memory management schemes use different mechanisms to map
 	 * user-mode memory. The stricter guarantees we have, the faster
@@ -45,7 +50,8 @@ mlx5e_mpwrq_umr_mode(struct mlx5_core_dev *mdev, struct mlx5e_xsk_param *xsk)
 	 * 3. KLM - indirect mapping to another MKey to arbitrary addresses, and
 	 *    mappings can have different sizes.
 	 */
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	struct mlx5e_xsk_param *xsk = mlx5e_rqo_xsk_param(rqo);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 	bool unaligned = xsk ? xsk->unaligned : false;
 	bool oversized = false;
 
@@ -225,12 +231,12 @@ u8 mlx5e_mpwrq_max_log_rq_pkts(struct mlx5_core_dev *mdev, u8 page_shift,
 }
 
 u16 mlx5e_get_linear_rq_headroom(struct mlx5e_params *params,
-				 struct mlx5e_xsk_param *xsk)
+				 struct mlx5e_rq_opt_param *rqo)
 {
 	u16 headroom;
 
-	if (xsk)
-		return xsk->headroom;
+	if (mlx5e_rqo_xsk_param(rqo))
+		return rqo->xsk->headroom;
 
 	headroom = NET_IP_ALIGN;
 	if (params->xdp_prog)
@@ -263,19 +269,23 @@ static u32 mlx5e_rx_get_linear_sz_skb(struct mlx5e_params *params, bool no_head_
 
 static u32 mlx5e_rx_get_linear_stride_sz(struct mlx5_core_dev *mdev,
 					 struct mlx5e_params *params,
-					 struct mlx5e_xsk_param *xsk,
+					 struct mlx5e_rq_opt_param *rqo,
 					 bool mpwqe)
 {
+	struct mlx5e_xsk_param *xsk = mlx5e_rqo_xsk_param(rqo);
 	bool no_head_tail_room;
 	u32 sz;
 
 	/* XSK frames are mapped as individual pages, because frames may come in
 	 * an arbitrary order from random locations in the UMEM.
 	 */
-	if (xsk)
-		return mpwqe ? 1 << mlx5e_mpwrq_page_shift(mdev, xsk) : PAGE_SIZE;
+	if (xsk) {
+		return mpwqe ?
+			BIT(mlx5e_mpwrq_page_shift(mdev, rqo)) : PAGE_SIZE;
+	}
 
-	no_head_tail_room = params->xdp_prog && mpwqe && !mlx5e_rx_is_linear_skb(mdev, params, xsk);
+	no_head_tail_room = params->xdp_prog && mpwqe &&
+			    !mlx5e_rx_is_linear_skb(mdev, params, rqo);
 
 	/* When no_head_tail_room is set, headroom and tailroom are excluded from skb calculations.
 	 * no_head_tail_room should be set in the case of XDP with Striding RQ
@@ -291,11 +301,12 @@ static u32 mlx5e_rx_get_linear_stride_sz(struct mlx5_core_dev *mdev,
 
 static u8 mlx5e_mpwqe_log_pkts_per_wqe(struct mlx5_core_dev *mdev,
 				       struct mlx5e_params *params,
-				       struct mlx5e_xsk_param *xsk)
+				       struct mlx5e_rq_opt_param *rqo)
 {
-	u32 linear_stride_sz = mlx5e_rx_get_linear_stride_sz(mdev, params, xsk, true);
-	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
+	u32 linear_stride_sz =
+		mlx5e_rx_get_linear_stride_sz(mdev, params, rqo, true);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 
 	return mlx5e_mpwrq_log_wqe_sz(mdev, page_shift, umr_mode) -
 		order_base_2(linear_stride_sz);
@@ -303,8 +314,10 @@ static u8 mlx5e_mpwqe_log_pkts_per_wqe(struct mlx5_core_dev *mdev,
 
 bool mlx5e_rx_is_linear_skb(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
-			    struct mlx5e_xsk_param *xsk)
+			    struct mlx5e_rq_opt_param *rqo)
 {
+	struct mlx5e_xsk_param *xsk = mlx5e_rqo_xsk_param(rqo);
+
 	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE)
 		return false;
 
@@ -315,7 +328,7 @@ bool mlx5e_rx_is_linear_skb(struct mlx5_core_dev *mdev,
 	 * Both XSK and non-XSK cases allocate an SKB on XDP_PASS. Packet data
 	 * must fit into a CPU page.
 	 */
-	if (mlx5e_rx_get_linear_sz_skb(params, xsk) > PAGE_SIZE)
+	if (mlx5e_rx_get_linear_sz_skb(params, !!xsk) > PAGE_SIZE)
 		return false;
 
 	/* XSK frames must be big enough to hold the packet data. */
@@ -349,12 +362,14 @@ static bool mlx5e_verify_rx_mpwqe_strides(struct mlx5_core_dev *mdev,
 
 bool mlx5e_verify_params_rx_mpwqe_strides(struct mlx5_core_dev *mdev,
 					  struct mlx5e_params *params,
-					  struct mlx5e_xsk_param *xsk)
+					  struct mlx5e_rq_opt_param *rqo)
 {
-	u8 log_wqe_num_of_strides = mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk);
-	u8 log_wqe_stride_size = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
-	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
+	u8 log_wqe_num_of_strides =
+		mlx5e_mpwqe_get_log_num_strides(mdev, params, rqo);
+	u8 log_wqe_stride_size =
+		mlx5e_mpwqe_get_log_stride_size(mdev, params, rqo);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 
 	return mlx5e_verify_rx_mpwqe_strides(mdev, log_wqe_stride_size,
 					     log_wqe_num_of_strides,
@@ -363,18 +378,20 @@ bool mlx5e_verify_params_rx_mpwqe_strides(struct mlx5_core_dev *mdev,
 
 bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 				  struct mlx5e_params *params,
-				  struct mlx5e_xsk_param *xsk)
+				  struct mlx5e_rq_opt_param *rqo)
 {
-	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
+	u32 linear_stride_sz =
+		mlx5e_rx_get_linear_stride_sz(mdev, params, rqo, true);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 	u8 log_num_strides;
 	u8 log_stride_sz;
 	u8 log_wqe_sz;
 
-	if (!mlx5e_rx_is_linear_skb(mdev, params, xsk))
+	if (!mlx5e_rx_is_linear_skb(mdev, params, rqo))
 		return false;
 
-	log_stride_sz = order_base_2(mlx5e_rx_get_linear_stride_sz(mdev, params, xsk, true));
+	log_stride_sz = order_base_2(linear_stride_sz);
 	log_wqe_sz = mlx5e_mpwrq_log_wqe_sz(mdev, page_shift, umr_mode);
 
 	if (log_wqe_sz < log_stride_sz)
@@ -389,13 +406,13 @@ bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 
 u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 			       struct mlx5e_params *params,
-			       struct mlx5e_xsk_param *xsk)
+			       struct mlx5e_rq_opt_param *rqo)
 {
-	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
+	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
 	u8 log_pkts_per_wqe, page_shift, max_log_rq_size;
 
-	log_pkts_per_wqe = mlx5e_mpwqe_log_pkts_per_wqe(mdev, params, xsk);
-	page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	log_pkts_per_wqe = mlx5e_mpwqe_log_pkts_per_wqe(mdev, params, rqo);
+	page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 	max_log_rq_size = mlx5e_mpwrq_max_log_rq_size(mdev, page_shift, umr_mode);
 
 	/* Numbers are unsigned, don't subtract to avoid underflow. */
@@ -423,10 +440,11 @@ static u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5e_params *params)
 
 u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
 				   struct mlx5e_params *params,
-				   struct mlx5e_xsk_param *xsk)
+				   struct mlx5e_rq_opt_param *rqo)
 {
-	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, xsk))
-		return order_base_2(mlx5e_rx_get_linear_stride_sz(mdev, params, xsk, true));
+	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo))
+		return order_base_2(mlx5e_rx_get_linear_stride_sz(mdev, params,
+								  rqo, true));
 
 	/* XDP in mlx5e doesn't support multiple packets per page. */
 	if (params->xdp_prog)
@@ -437,17 +455,18 @@ u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
 
 u8 mlx5e_mpwqe_get_log_num_strides(struct mlx5_core_dev *mdev,
 				   struct mlx5e_params *params,
-				   struct mlx5e_xsk_param *xsk)
+				   struct mlx5e_rq_opt_param *rqo)
 {
-	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 	u8 log_wqe_size, log_stride_size;
 
 	log_wqe_size = mlx5e_mpwrq_log_wqe_sz(mdev, page_shift, umr_mode);
-	log_stride_size = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
+	log_stride_size = mlx5e_mpwqe_get_log_stride_size(mdev, params, rqo);
 	WARN(log_wqe_size < log_stride_size,
 	     "Log WQE size %u < log stride size %u (page shift %u, umr mode %d, xsk on? %d)\n",
-	     log_wqe_size, log_stride_size, page_shift, umr_mode, !!xsk);
+	     log_wqe_size, log_stride_size, page_shift, umr_mode,
+	     rqo && rqo->xsk);
 	return log_wqe_size - log_stride_size;
 }
 
@@ -459,14 +478,14 @@ u8 mlx5e_mpwqe_get_min_wqe_bulk(unsigned int wq_sz)
 
 u16 mlx5e_get_rq_headroom(struct mlx5_core_dev *mdev,
 			  struct mlx5e_params *params,
-			  struct mlx5e_xsk_param *xsk)
+			  struct mlx5e_rq_opt_param *rqo)
 {
-	u16 linear_headroom = mlx5e_get_linear_rq_headroom(params, xsk);
+	u16 linear_headroom = mlx5e_get_linear_rq_headroom(params, rqo);
 
 	if (params->rq_wq_type == MLX5_WQ_TYPE_CYCLIC)
 		return linear_headroom;
 
-	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, xsk))
+	if (mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo))
 		return linear_headroom;
 
 	if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
@@ -535,10 +554,11 @@ int mlx5e_mpwrq_validate_regular(struct mlx5_core_dev *mdev, struct mlx5e_params
 }
 
 int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *params,
-			     struct mlx5e_xsk_param *xsk)
+			     struct mlx5e_rq_opt_param *rqo)
 {
-	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
+	struct mlx5e_xsk_param *xsk = mlx5e_rqo_xsk_param(rqo);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 	u16 max_mtu_pkts;
 
 	if (!mlx5e_check_fragmented_striding_rq_cap(mdev, page_shift, umr_mode)) {
@@ -547,7 +567,7 @@ int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 		return -EOPNOTSUPP;
 	}
 
-	if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, xsk)) {
+	if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo)) {
 		mlx5_core_err(mdev, "Striding RQ linear mode for XSK can't be activated with current params\n");
 		return -EINVAL;
 	}
@@ -559,7 +579,8 @@ int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *pa
 			     mlx5e_mpwrq_max_log_rq_pkts(mdev, page_shift, xsk->unaligned));
 	if (params->log_rq_mtu_frames > max_mtu_pkts) {
 		mlx5_core_err(mdev, "Current RQ length %d is too big for XSK with given frame size %u\n",
-			      1 << params->log_rq_mtu_frames, xsk->chunk_size);
+			      1 << params->log_rq_mtu_frames,
+			      xsk->chunk_size);
 		return -EINVAL;
 	}
 
@@ -672,7 +693,7 @@ static void mlx5e_rx_compute_wqe_bulk_params(struct mlx5e_params *params,
 
 static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 				     struct mlx5e_params *params,
-				     struct mlx5e_xsk_param *xsk,
+				     struct mlx5e_rq_opt_param *rqo,
 				     struct mlx5e_rq_frags_info *info,
 				     u32 *xdp_frag_size)
 {
@@ -684,10 +705,11 @@ static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 	int max_mtu;
 	int i;
 
-	if (mlx5e_rx_is_linear_skb(mdev, params, xsk)) {
+	if (mlx5e_rx_is_linear_skb(mdev, params, rqo)) {
 		int frag_stride;
 
-		frag_stride = mlx5e_rx_get_linear_stride_sz(mdev, params, xsk, false);
+		frag_stride = mlx5e_rx_get_linear_stride_sz(mdev, params, rqo,
+							    false);
 
 		info->arr[0].frag_size = byte_count;
 		info->arr[0].frag_stride = frag_stride;
@@ -703,7 +725,7 @@ static int mlx5e_build_rq_frags_info(struct mlx5_core_dev *mdev,
 		goto out;
 	}
 
-	headroom = mlx5e_get_linear_rq_headroom(params, xsk);
+	headroom = mlx5e_get_linear_rq_headroom(params, rqo);
 	first_frag_size_max = SKB_WITH_OVERHEAD(frag_size_max - headroom);
 
 	max_mtu = mlx5e_max_nonlinear_mtu(first_frag_size_max, frag_size_max,
@@ -819,12 +841,13 @@ static void mlx5e_build_common_cq_param(struct mlx5_core_dev *mdev,
 
 static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
-					struct mlx5e_xsk_param *xsk)
+					struct mlx5e_rq_opt_param *rqo)
 {
-	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
-	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
+	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, rqo);
+	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params,
+							      rqo));
 	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
-	int wq_size = BIT(mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
+	int wq_size = BIT(mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo));
 	int wqe_size = BIT(log_stride_sz) * num_strides;
 	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;
 
@@ -836,7 +859,7 @@ static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
 
 static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 				    struct mlx5e_params *params,
-				    struct mlx5e_xsk_param *xsk,
+				    struct mlx5e_rq_opt_param *rqo,
 				    struct mlx5e_cq_param *param)
 {
 	bool hw_stridx = false;
@@ -847,10 +870,13 @@ static void mlx5e_build_rx_cq_param(struct mlx5_core_dev *mdev,
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
 		hw_stridx = MLX5_CAP_GEN(mdev, mini_cqe_resp_stride_index);
 		if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
-			log_cq_size = mlx5e_shampo_get_log_cq_size(mdev, params, xsk);
+			log_cq_size =
+				mlx5e_shampo_get_log_cq_size(mdev, params, rqo);
 		else
-			log_cq_size = mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk) +
-				mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk);
+			log_cq_size =
+				mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo) +
+				mlx5e_mpwqe_get_log_num_strides(mdev, params,
+								rqo);
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		log_cq_size = params->log_rq_mtu_frames;
@@ -882,22 +908,22 @@ static u8 rq_end_pad_mode(struct mlx5_core_dev *mdev, struct mlx5e_params *param
 
 static int mlx5e_mpwqe_build_rq_param(struct mlx5_core_dev *mdev,
 				      struct mlx5e_params *params,
-				      struct mlx5e_xsk_param *xsk,
+				      struct mlx5e_rq_opt_param *rqo,
 				      struct mlx5e_rq_param *rq_param)
 {
-	u8 log_rq_sz = mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk);
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	u8 log_rq_sz = mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 	u8 log_wqe_num_of_strides, log_wqe_stride_size;
 	enum mlx5e_mpwrq_umr_mode umr_mode;
 	void *rqc = rq_param->rqc;
 	u32 lro_timeout;
 	void *wq;
 
-	log_wqe_num_of_strides = mlx5e_mpwqe_get_log_num_strides(mdev, params,
-								 xsk);
-	log_wqe_stride_size = mlx5e_mpwqe_get_log_stride_size(mdev, params,
-							      xsk);
-	umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
+	log_wqe_num_of_strides =
+		mlx5e_mpwqe_get_log_num_strides(mdev, params, rqo);
+	log_wqe_stride_size =
+		mlx5e_mpwqe_get_log_stride_size(mdev, params, rqo);
+	umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
 
 	wq = MLX5_ADDR_OF(rqc, rqc, wq);
 	if (!mlx5e_verify_rx_mpwqe_strides(mdev, log_wqe_stride_size,
@@ -940,7 +966,7 @@ static int mlx5e_mpwqe_build_rq_param(struct mlx5_core_dev *mdev,
 
 int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			 struct mlx5e_params *params,
-			 struct mlx5e_xsk_param *xsk,
+			 struct mlx5e_rq_opt_param *rqo,
 			 struct mlx5e_rq_param *rq_param)
 {
 	void *rqc = rq_param->rqc;
@@ -952,13 +978,13 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 
 	switch (params->rq_wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
-		err = mlx5e_mpwqe_build_rq_param(mdev, params, xsk, rq_param);
+		err = mlx5e_mpwqe_build_rq_param(mdev, params, rqo, rq_param);
 		if (err)
 			return err;
 		break;
 	default: /* MLX5_WQ_TYPE_CYCLIC */
 		MLX5_SET(wq, wq, log_wq_sz, params->log_rq_mtu_frames);
-		err = mlx5e_build_rq_frags_info(mdev, params, xsk,
+		err = mlx5e_build_rq_frags_info(mdev, params, rqo,
 						&rq_param->frags_info,
 						&rq_param->xdp_frag_size);
 		if (err)
@@ -975,7 +1001,7 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 	MLX5_SET(rqc, rqc, scatter_fcs,    params->scatter_fcs_en);
 
 	rq_param->wq.buf_numa_node = dev_to_node(mlx5_core_dma_dev(mdev));
-	mlx5e_build_rx_cq_param(mdev, params, xsk, &rq_param->cqp);
+	mlx5e_build_rx_cq_param(mdev, params, rqo, &rq_param->cqp);
 
 	return 0;
 }
@@ -1105,20 +1131,22 @@ u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
 
 static u32 mlx5e_mpwrq_total_umr_wqebbs(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
-					struct mlx5e_xsk_param *xsk)
+					struct mlx5e_rq_opt_param *rqo)
 {
-	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
-	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
+	enum mlx5e_mpwrq_umr_mode umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
+	u8 page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
 	u8 umr_wqebbs;
 
 	umr_wqebbs = mlx5e_mpwrq_umr_wqebbs(mdev, page_shift, umr_mode);
 
-	return umr_wqebbs * (1 << mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
+	return umr_wqebbs *
+	       (1 << mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo));
 }
 
 static u32 mlx5e_max_xsk_wqebbs(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params)
 {
+	struct mlx5e_rq_opt_param rqo = {0};
 	struct mlx5e_xsk_param xsk = {0};
 	u32 max_xsk_wqebbs = 0;
 	u8 frame_shift;
@@ -1126,6 +1154,8 @@ static u32 mlx5e_max_xsk_wqebbs(struct mlx5_core_dev *mdev,
 	if (!params->xdp_prog)
 		return 0;
 
+	rqo.xsk = &xsk;
+
 	/* If XDP program is attached, XSK may be turned on at any time without
 	 * restarting the channel. ICOSQ must be big enough to fit UMR WQEs of
 	 * both regular RQ and XSK RQ.
@@ -1145,24 +1175,24 @@ static u32 mlx5e_max_xsk_wqebbs(struct mlx5_core_dev *mdev,
 		/* XSK aligned mode. */
 		xsk.chunk_size = 1 << frame_shift;
 		xsk.unaligned = false;
-		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &rqo);
 		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
 
 		/* XSK unaligned mode, frame size is a power of two. */
 		xsk.unaligned = true;
-		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &rqo);
 		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
 
 		/* XSK unaligned mode, frame size is not equal to stride
 		 * size.
 		 */
 		xsk.chunk_size -= 1;
-		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &rqo);
 		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
 
 		/* XSK unaligned mode, frame size is a triple power of two. */
 		xsk.chunk_size = (1 << frame_shift) / 4 * 3;
-		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &rqo);
 		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
 	}
 
@@ -1278,7 +1308,7 @@ void mlx5e_build_xsk_channel_param(struct mlx5_core_dev *mdev,
 				   struct mlx5e_xsk_param *xsk,
 				   struct mlx5e_channel_param *cparam)
 {
-	cparam->xsk = xsk;
-	mlx5e_build_rq_param(mdev, params, xsk, &cparam->rq);
+	cparam->rq_opt.xsk = xsk;
+	mlx5e_build_rq_param(mdev, params, &cparam->rq_opt, &cparam->rq);
 	mlx5e_build_xdpsq_param(mdev, params, &cparam->xdp_sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index c132649dd9f2..4bce769d48ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -12,6 +12,10 @@ struct mlx5e_xsk_param {
 	bool unaligned;
 };
 
+struct mlx5e_rq_opt_param {
+	struct mlx5e_xsk_param *xsk;
+};
+
 struct mlx5e_cq_param {
 	u32                        cqc[MLX5_ST_SZ_DW(cqc)];
 	struct mlx5_wq_param       wq;
@@ -38,11 +42,11 @@ struct mlx5e_sq_param {
 
 struct mlx5e_channel_param {
 	struct mlx5e_rq_param      rq;
+	struct mlx5e_rq_opt_param  rq_opt;
 	struct mlx5e_sq_param      txq_sq;
 	struct mlx5e_sq_param      xdp_sq;
 	struct mlx5e_sq_param      icosq;
 	struct mlx5e_sq_param      async_icosq;
-	struct mlx5e_xsk_param     *xsk;
 };
 
 struct mlx5e_create_sq_param {
@@ -57,9 +61,11 @@ struct mlx5e_create_sq_param {
 
 /* Striding RQ dynamic parameters */
 
-u8 mlx5e_mpwrq_page_shift(struct mlx5_core_dev *mdev, struct mlx5e_xsk_param *xsk);
+u8 mlx5e_mpwrq_page_shift(struct mlx5_core_dev *mdev,
+			  struct mlx5e_rq_opt_param *rqo);
 enum mlx5e_mpwrq_umr_mode
-mlx5e_mpwrq_umr_mode(struct mlx5_core_dev *mdev, struct mlx5e_xsk_param *xsk);
+mlx5e_mpwrq_umr_mode(struct mlx5_core_dev *mdev,
+		     struct mlx5e_rq_opt_param *rqo);
 u8 mlx5e_mpwrq_umr_entry_size(enum mlx5e_mpwrq_umr_mode mode);
 u8 mlx5e_mpwrq_log_wqe_sz(struct mlx5_core_dev *mdev, u8 page_shift,
 			  enum mlx5e_mpwrq_umr_mode umr_mode);
@@ -81,22 +87,22 @@ u8 mlx5e_mpwrq_max_log_rq_pkts(struct mlx5_core_dev *mdev, u8 page_shift,
 bool slow_pci_heuristic(struct mlx5_core_dev *mdev);
 int mlx5e_mpwrq_validate_regular(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 int mlx5e_mpwrq_validate_xsk(struct mlx5_core_dev *mdev, struct mlx5e_params *params,
-			     struct mlx5e_xsk_param *xsk);
+			     struct mlx5e_rq_opt_param *rqo);
 void mlx5e_build_rq_params(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 void mlx5e_set_rq_type(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 void mlx5e_init_rq_type_params(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 
 u16 mlx5e_get_linear_rq_headroom(struct mlx5e_params *params,
-				 struct mlx5e_xsk_param *xsk);
+				 struct mlx5e_rq_opt_param *rqo);
 bool mlx5e_rx_is_linear_skb(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
-			    struct mlx5e_xsk_param *xsk);
+			    struct mlx5e_rq_opt_param *rqo);
 bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 				  struct mlx5e_params *params,
-				  struct mlx5e_xsk_param *xsk);
+				  struct mlx5e_rq_opt_param *rqo);
 u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 			       struct mlx5e_params *params,
-			       struct mlx5e_xsk_param *xsk);
+			       struct mlx5e_rq_opt_param *rqo);
 u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param);
@@ -106,21 +112,21 @@ u32 mlx5e_shampo_hd_per_wq(struct mlx5_core_dev *mdev,
 u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout);
 u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
 				   struct mlx5e_params *params,
-				   struct mlx5e_xsk_param *xsk);
+				   struct mlx5e_rq_opt_param *rqo);
 u8 mlx5e_mpwqe_get_log_num_strides(struct mlx5_core_dev *mdev,
 				   struct mlx5e_params *params,
-				   struct mlx5e_xsk_param *xsk);
+				   struct mlx5e_rq_opt_param *rqo);
 u8 mlx5e_mpwqe_get_min_wqe_bulk(unsigned int wq_sz);
 u16 mlx5e_get_rq_headroom(struct mlx5_core_dev *mdev,
 			  struct mlx5e_params *params,
-			  struct mlx5e_xsk_param *xsk);
+			  struct mlx5e_rq_opt_param *rqo);
 
 /* Build queue parameters */
 
 void mlx5e_build_create_cq_param(struct mlx5e_create_cq_param *ccp, struct mlx5e_channel *c);
 int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			 struct mlx5e_params *params,
-			 struct mlx5e_xsk_param *xsk,
+			 struct mlx5e_rq_opt_param *rqo,
 			 struct mlx5e_rq_param *param);
 void mlx5e_build_drop_rq_param(struct mlx5_core_dev *mdev,
 			       struct mlx5e_rq_param *param);
@@ -148,7 +154,7 @@ u16 mlx5e_calc_sq_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *par
 int mlx5e_validate_params(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 bool mlx5e_verify_params_rx_mpwqe_strides(struct mlx5_core_dev *mdev,
 					  struct mlx5e_params *params,
-					  struct mlx5e_xsk_param *xsk);
+					  struct mlx5e_rq_opt_param *rqo);
 
 static inline void mlx5e_params_print_info(struct mlx5_core_dev *mdev,
 					   struct mlx5e_params *params)
@@ -164,4 +170,10 @@ static inline void mlx5e_params_print_info(struct mlx5_core_dev *mdev,
 				       "enhanced" : "basic");
 };
 
+static inline struct mlx5e_xsk_param *
+mlx5e_rqo_xsk_param(struct mlx5e_rq_opt_param *rqo)
+{
+	return rqo ? rqo->xsk : NULL;
+}
+
 #endif /* __MLX5_EN_PARAMS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 80f9fc10877a..04e1b5fa4825 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -37,9 +37,10 @@
 #include <linux/bitfield.h>
 #include <net/page_pool/helpers.h>
 
-int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param *xsk)
+int mlx5e_xdp_max_mtu(struct mlx5e_params *params,
+		      struct mlx5e_rq_opt_param *rqo)
 {
-	int hr = mlx5e_get_linear_rq_headroom(params, xsk);
+	int hr = mlx5e_get_linear_rq_headroom(params, rqo);
 
 	/* Let S := SKB_DATA_ALIGN(sizeof(struct skb_shared_info)).
 	 * The condition checked in mlx5e_rx_is_linear_skb is:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 46ab0a9e8cdd..3c54f8962664 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -96,7 +96,8 @@ union mlx5e_xdp_info {
 };
 
 struct mlx5e_xsk_param;
-int mlx5e_xdp_max_mtu(struct mlx5e_params *params, struct mlx5e_xsk_param *xsk);
+int mlx5e_xdp_max_mtu(struct mlx5e_params *params,
+		      struct mlx5e_rq_opt_param *rqo);
 bool mlx5e_xdp_handle(struct mlx5e_rq *rq,
 		      struct bpf_prog *prog, struct mlx5e_xdp_buff *mlctx);
 void mlx5e_xdp_mpwqe_complete(struct mlx5e_xdpsq *sq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
index 92bcf16a2019..565e5c4ddcce 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
@@ -80,6 +80,7 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 {
 	struct mlx5e_params *params = &priv->channels.params;
 	struct mlx5e_channel_param *cparam;
+	enum mlx5e_mpwrq_umr_mode umr_mode;
 	struct mlx5e_xsk_param xsk;
 	struct mlx5e_channel *c;
 	int err;
@@ -105,8 +106,9 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 	mlx5e_build_xsk_param(pool, &xsk);
 	mlx5e_build_xsk_channel_param(priv->mdev, params, &xsk, cparam);
 
+	umr_mode = mlx5e_mpwrq_umr_mode(priv->mdev, &cparam->rq_opt);
 	if (priv->channels.params.rq_wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ &&
-	    mlx5e_mpwrq_umr_mode(priv->mdev, &xsk) == MLX5E_MPWRQ_UMR_MODE_OVERSIZED) {
+	    umr_mode == MLX5E_MPWRQ_UMR_MODE_OVERSIZED) {
 		const char *recommendation = is_power_of_2(xsk.chunk_size) ?
 			"Upgrade firmware" : "Disable striding RQ";
 
@@ -163,7 +165,7 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 	/* Check the configuration in advance, rather than fail at a later stage
 	 * (in mlx5e_xdp_set or on open) and end up with no channels.
 	 */
-	if (!mlx5e_validate_xsk_param(params, &xsk, priv->mdev)) {
+	if (!mlx5e_validate_xsk_param(params, &cparam->rq_opt, priv->mdev)) {
 		err = -EINVAL;
 		goto err_remove_pool;
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 03f1be361701..11500fd213a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -9,9 +9,9 @@
 
 static int mlx5e_legacy_rq_validate_xsk(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
-					struct mlx5e_xsk_param *xsk)
+					struct mlx5e_rq_opt_param *rqo)
 {
-	if (!mlx5e_rx_is_linear_skb(mdev, params, xsk)) {
+	if (!mlx5e_rx_is_linear_skb(mdev, params, rqo)) {
 		mlx5_core_err(mdev, "Legacy RQ linear mode for XSK can't be activated with current params\n");
 		return -EINVAL;
 	}
@@ -25,9 +25,14 @@ static int mlx5e_legacy_rq_validate_xsk(struct mlx5_core_dev *mdev,
 #define MLX5E_MIN_XSK_CHUNK_SIZE max(2048, XDP_UMEM_MIN_CHUNK_SIZE)
 
 bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
-			      struct mlx5e_xsk_param *xsk,
+			      struct mlx5e_rq_opt_param *rqo,
 			      struct mlx5_core_dev *mdev)
 {
+	struct mlx5e_xsk_param *xsk = mlx5e_rqo_xsk_param(rqo);
+
+	if (WARN_ON(!xsk))
+		return false;
+
 	/* AF_XDP doesn't support frames larger than PAGE_SIZE,
 	 * and xsk->chunk_size is limited to 65535 bytes.
 	 */
@@ -42,9 +47,9 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 	 */
 	switch (params->rq_wq_type) {
 	case MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ:
-		return !mlx5e_mpwrq_validate_xsk(mdev, params, xsk);
+		return !mlx5e_mpwrq_validate_xsk(mdev, params, rqo);
 	default: /* MLX5_WQ_TYPE_CYCLIC */
-		return !mlx5e_legacy_rq_validate_xsk(mdev, params, xsk);
+		return !mlx5e_legacy_rq_validate_xsk(mdev, params, rqo);
 	}
 }
 
@@ -83,19 +88,20 @@ static int mlx5e_init_xsk_rq(struct mlx5e_channel *c,
 
 static int mlx5e_open_xsk_rq(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
-			     struct mlx5e_rq_param *rq_param,
-			     struct xsk_buff_pool *pool,
-			     struct mlx5e_xsk_param *xsk)
+			     struct mlx5e_channel_param *cparam,
+			     struct xsk_buff_pool *pool)
 {
+	struct mlx5e_rq_param *rq_param = &cparam->rq;
+	struct mlx5e_rq_opt_param *rqo = &cparam->rq_opt;
 	u16 q_counter = c->priv->q_counter[c->sd_ix];
 	struct mlx5e_rq *xskrq = &c->xskrq;
 	int err;
 
-	err = mlx5e_init_xsk_rq(c, params, pool, xsk, xskrq);
+	err = mlx5e_init_xsk_rq(c, params, pool, rqo->xsk, xskrq);
 	if (err)
 		return err;
 
-	err = mlx5e_open_rq(params, rq_param, xsk, cpu_to_node(c->cpu),
+	err = mlx5e_open_rq(params, rq_param, rqo, cpu_to_node(c->cpu),
 			    q_counter, xskrq);
 	if (err)
 		return err;
@@ -109,13 +115,12 @@ int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
 		   struct xsk_buff_pool *pool,
 		   struct mlx5e_channel *c)
 {
-	struct mlx5e_xsk_param *xsk = cparam->xsk;
 	struct mlx5e_create_cq_param ccp;
 	int err;
 
 	mlx5e_build_create_cq_param(&ccp, c);
 
-	if (!mlx5e_validate_xsk_param(params, xsk, priv->mdev))
+	if (!mlx5e_validate_xsk_param(params, &cparam->rq_opt, priv->mdev))
 		return -EINVAL;
 
 	err = mlx5e_open_cq(c->mdev, params->rx_cq_moderation, &cparam->rq.cqp, &ccp,
@@ -123,7 +128,7 @@ int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	if (unlikely(err))
 		return err;
 
-	err = mlx5e_open_xsk_rq(c, params, &cparam->rq, pool, xsk);
+	err = mlx5e_open_xsk_rq(c, params, cparam, pool);
 	if (unlikely(err))
 		goto err_close_rx_cq;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h
index fc86d19ea2b3..664ec78192c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h
@@ -9,7 +9,7 @@
 struct mlx5e_xsk_param;
 
 bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
-			      struct mlx5e_xsk_param *xsk,
+			      struct mlx5e_rq_opt_param *rqo,
 			      struct mlx5_core_dev *mdev);
 struct mlx5e_channel_param;
 int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 35b767105492..9e406275e243 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -851,8 +851,8 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 }
 
 static int mlx5e_alloc_rq(struct mlx5e_params *params,
-			  struct mlx5e_xsk_param *xsk,
 			  struct mlx5e_rq_param *rq_param,
+			  struct mlx5e_rq_opt_param *rqo,
 			  int node, struct mlx5e_rq *rq)
 {
 	void *rqc_wq = MLX5_ADDR_OF(rqc, rq_param->rqc, wq);
@@ -871,7 +871,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 	RCU_INIT_POINTER(rq->xdp_prog, params->xdp_prog);
 
 	rq->buff.map_dir = params->xdp_prog ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
-	rq->buff.headroom = mlx5e_get_rq_headroom(mdev, params, xsk);
+	rq->buff.headroom = mlx5e_get_rq_headroom(mdev, params, rqo);
 	pool_size = 1 << params->log_rq_mtu_frames;
 
 	rq->mkey_be = cpu_to_be32(mdev->mlx5e_res.hw_objs.mkey);
@@ -891,8 +891,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 		wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
 
-		rq->mpwqe.page_shift = mlx5e_mpwrq_page_shift(mdev, xsk);
-		rq->mpwqe.umr_mode = mlx5e_mpwrq_umr_mode(mdev, xsk);
+		rq->mpwqe.page_shift = mlx5e_mpwrq_page_shift(mdev, rqo);
+		rq->mpwqe.umr_mode = mlx5e_mpwrq_umr_mode(mdev, rqo);
 		rq->mpwqe.pages_per_wqe =
 			mlx5e_mpwrq_pages_per_wqe(mdev, rq->mpwqe.page_shift,
 						  rq->mpwqe.umr_mode);
@@ -904,14 +904,17 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 						 rq->mpwqe.umr_mode);
 
 		pool_size = rq->mpwqe.pages_per_wqe <<
-			mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk);
+			mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo);
 
-		if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, xsk) && params->xdp_prog)
+		if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) &&
+		    params->xdp_prog)
 			pool_size *= 2; /* additional page per packet for the linear part */
 
-		rq->mpwqe.log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
+		rq->mpwqe.log_stride_sz =
+				mlx5e_mpwqe_get_log_stride_size(mdev, params,
+								rqo);
 		rq->mpwqe.num_strides =
-			BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
+			BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, rqo));
 		rq->mpwqe.min_wqe_bulk = mlx5e_mpwqe_get_min_wqe_bulk(wq_sz);
 
 		rq->buff.frame0_sz = (1 << rq->mpwqe.log_stride_sz);
@@ -947,7 +950,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			goto err_rq_wq_destroy;
 	}
 
-	if (xsk) {
+	if (mlx5e_rqo_xsk_param(rqo)) {
 		err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
 						 MEM_TYPE_XSK_BUFF_POOL, NULL);
 		if (err)
@@ -1324,7 +1327,7 @@ void mlx5e_free_rx_descs(struct mlx5e_rq *rq)
 }
 
 int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *rq_param,
-		  struct mlx5e_xsk_param *xsk, int node, u16 q_counter,
+		  struct mlx5e_rq_opt_param *rqo, int node, u16 q_counter,
 		  struct mlx5e_rq *rq)
 {
 	struct mlx5_core_dev *mdev = rq->mdev;
@@ -1333,7 +1336,7 @@ int mlx5e_open_rq(struct mlx5e_params *params, struct mlx5e_rq_param *rq_param,
 	if (params->packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
 		__set_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state);
 
-	err = mlx5e_alloc_rq(params, xsk, rq_param, node, rq);
+	err = mlx5e_alloc_rq(params, rq_param, rqo, node, rq);
 	if (err)
 		return err;
 
@@ -4587,6 +4590,7 @@ static bool mlx5e_xsk_validate_mtu(struct net_device *netdev,
 	for (ix = 0; ix < chs->params.num_channels; ix++) {
 		struct xsk_buff_pool *xsk_pool =
 			mlx5e_xsk_get_pool(&chs->params, chs->params.xsk, ix);
+		struct mlx5e_rq_opt_param rqo = {0};
 		struct mlx5e_xsk_param xsk;
 		int max_xdp_mtu;
 
@@ -4594,12 +4598,13 @@ static bool mlx5e_xsk_validate_mtu(struct net_device *netdev,
 			continue;
 
 		mlx5e_build_xsk_param(xsk_pool, &xsk);
-		max_xdp_mtu = mlx5e_xdp_max_mtu(new_params, &xsk);
+		rqo.xsk = &xsk;
+		max_xdp_mtu = mlx5e_xdp_max_mtu(new_params, &rqo);
 
 		/* Validate XSK params and XDP MTU in advance */
-		if (!mlx5e_validate_xsk_param(new_params, &xsk, mdev) ||
+		if (!mlx5e_validate_xsk_param(new_params, &rqo, mdev) ||
 		    new_params->sw_mtu > max_xdp_mtu) {
-			u32 hr = mlx5e_get_linear_rq_headroom(new_params, &xsk);
+			u32 hr = mlx5e_get_linear_rq_headroom(new_params, &rqo);
 			int max_mtu_frame, max_mtu_page, max_mtu;
 
 			/* Two criteria must be met:
-- 
2.44.0


