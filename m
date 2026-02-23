Return-Path: <linux-rdma+bounces-17068-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMdwF+a8nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17068-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:47:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D0517D1FE
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0367E30557EB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14EB37A4AE;
	Mon, 23 Feb 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qfLJ8nfY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BF3793DE;
	Mon, 23 Feb 2026 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879400; cv=fail; b=NMMwhyGa9aV8bhl2ltlr9XJnFlpNNsUCpImMOztV+9fApbdP8YeXlgS54GKQUHNhTow/IC1B13U6g9qMKw4m0Hdm654aUCUjgC8t0BcCMbw55LLSdnfG8ttUUykD2Fo2R13TjJLzHXyL0BRQA+5JtaC2PFrEWbf1TNB8GwFtBaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879400; c=relaxed/simple;
	bh=FpAUqvyXAu9nEfvDka9XAFS41/h6anyfYXAFv0zCGic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHonWXJyQNoPqaqGv4v4pnfO3nv9iou+/gB3VRC0K1cW0WA1KaqyqIUVcLSFFVtjLvKf97hMFWlCMfk8uPZWGTmZWQQmUXuwoeA3ZHDdWzCgsrRjfA8+wsZZi9HAjz1lzGk3ZQhwbMn73eQhpOZulzFQoNb/Jp7IerkDkkBCPlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qfLJ8nfY; arc=fail smtp.client-ip=52.101.56.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhFuL3NnC/7C3wuS7TUXpij4A+JCmwS/obQyRogNPTvMWETaJb+OD3c46+YAwvkLxjs/1fe1vB6qnGWFAFiEWIPEKwEED0dPpdo6FXymLpD1HxS17TEy+Sch7DMfdnk84sT44W4mFZQ8zjVQHBqVlI4hOcjPWKLdCJN0Qgdx04bOGP+ByeQxskscDQTT8jjQlkKcPljtHRjPkn6SQImvw2T8db5JSTlItqq0JLZbekN6SbfRx0dAVTynxRCpv0QPwXU7BietXgE16eJ8VHIkDvB0IVXv1Asy6WKhsvdkiv7MxeudQ5U0Rc2EGH9Ee3A9dO3gLLfK+LhzgGA4h7/2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeYK1nBv70IVwugaIbUdrBUPl7/+vD4ig7Z0BbG/VsI=;
 b=AfhJLCwZBxGldbJum1KyIsPRl7GKg8kjPzSF3SRfhGHYe9kzRJMZ8E9In4Sy+PdM42d7iWUQLeG8y1920NfInPYPuUNP66hzrbb7ox7pH9aAh+q281QXaHX+5WFmG2bFIT//mNbeBrQQKrc3+AzBwhCmNB9I+v9dVhUEC4vukM0WFFEGxrfL0MNUhz1neHh5qw7eFQW97rf7GPtHLj4vyPDgh72DIt1xwHKCXHpJgbeOOiI2XRLSKtrVqdfBB3IjHjc9IT8Pkjmg6GkU+1akGRoWdrmnIDrnoStTG/hFseXR44WNsinLfjEh7LCiQGXWJmdTZXFh2CSwv8HLVyNW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeYK1nBv70IVwugaIbUdrBUPl7/+vD4ig7Z0BbG/VsI=;
 b=qfLJ8nfY3a1zo3C83xan4/ag0qcHkzWbgO1c1o5pyCNLasMIJvL5tmK1R4QI3FbBrPclhIU3QE+cjxX5ddsyQo+wkCqTCzYAY6rEbElVRAlJsRGeuhzTghewMDlKUiStNGLyZyoOzLnUaDRfzF4FnORg66QtMClE5GXn2S6IiVsHWnb5c/xaIuA9Etnia1Eegbhx5zvb9OPr0yvXxIonlbko4sxco8NwkEQxVJ5/BIJifyAd6Nmc+iEB+G26RU1BPD1QeSuau2o6GG6GenkO+Baca8MBucrsiJcyqzDiMDpVNPdXWxd6eDvKhXQ+yIQ+lUteAT0rVBKqmqfIdvvn5w==
Received: from CH0PR08CA0021.namprd08.prod.outlook.com (2603:10b6:610:33::26)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:12 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::a0) by CH0PR08CA0021.outlook.office365.com
 (2603:10b6:610:33::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:58 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:42:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:42:51 -0800
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
Subject: [PATCH net-next 03/15] net/mlx5e: Extract max_xsk_wqebbs into its own function
Date: Mon, 23 Feb 2026 22:41:43 +0200
Message-ID: <20260223204155.1783580-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 29593076-ac45-40d3-e197-08de731c2977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yr1bM2JKXHYooYVIxqpBGg2DYbMrUFrMHmXmnzPajnDfTPufDhgrwiPBT2Ye?=
 =?us-ascii?Q?O48G65iJy4tYN8hXu7iPaj2WUDvepsbZYEP9xFO+uDxXxDPof/kw1Bs7gTVb?=
 =?us-ascii?Q?h6n8r5wF4FRenZc2SINkM6mcG2J9rlK8ex1gNj3j1VPl5WhGlrxIJgpPzfFa?=
 =?us-ascii?Q?0lmUgFy0hjL+nBgTCft6mYxkMwdBeRFp1kke1yNzN/04Nf14UA+Y1qmYiyhp?=
 =?us-ascii?Q?vs0QUJET4m3EIfdfKpuJN3E+aYKTvIBlFWl2zdcgCMR5wHyjfQZV6Shpw0RD?=
 =?us-ascii?Q?FLsg/e4r18XvHhMOJqZcSnJDvyfD5YeEvCn0ln/qYojuuaBvIxe0V2q4m2o5?=
 =?us-ascii?Q?D1In5FZobk05nBN1kWncfOnvPGLXyXo8+9Qlg3EGIdYNMMr1LxMJQnrvhhXe?=
 =?us-ascii?Q?NIJ1bZy0eXZXgMpM43RGDDYCf0rwqkzilsFP4CjLt3QGR07IKZ+vSF9fbOEN?=
 =?us-ascii?Q?tsMFCbyoKu/fyV0dJT3IPcbZhwelD/oEceHBSgJrhQTF5cjYG9ULxNh6zpTl?=
 =?us-ascii?Q?Kiz8L2jUBEhsFKm+lQuNqS1c1U1dSM5fRmFBE04gcQj2aJSfdP6wrvhBw5Qo?=
 =?us-ascii?Q?qVe+SOgoEZI1LWyQRqs30omJWPcjSRZWm9kET6uWQscpmF5qkJMqRxkz8Xl4?=
 =?us-ascii?Q?OJGiAhsOwhxPMh1d/kBzw/ug6N9wUj05IWRlesw8DI6WGdY6MPOh7y5bZh5Z?=
 =?us-ascii?Q?/ucJwfSz/STJsN7H6bVq5OldUBwEOVGC+SLYyNOQlQOUkG8GqK/MtCBL0nzt?=
 =?us-ascii?Q?DVhOB3r3LVTu51WROKQohPtAmzZD/wrby07j90/IEehlWAbDqR3DiK1SN8Hw?=
 =?us-ascii?Q?G0Oz4I33A6EZT0g3Get8YpZjBozjW3EigwWrEMzRXNcW+1yeglilRGxGwdAN?=
 =?us-ascii?Q?1asOqipnyMApVl+ZU/uyIaHmswKoeQLF1difL/dRboVTxQ4TYDr3cIRgFCwy?=
 =?us-ascii?Q?HALrlb6OR513wT2P0cG1LJc3TdaRgdQ4QssZETJawZACfKmLZ3engKoW2McA?=
 =?us-ascii?Q?AFpbIhnSQ+t04gP7ikQu2Uf72XenEAbAcIi69McYPjoZMcNIktRJ0Ry5VAdo?=
 =?us-ascii?Q?3hCWM1Lxu0qcVvYN6+IQArwMcunY9nEheyZ7lJoq8b7AgphMq6F96abdU2ot?=
 =?us-ascii?Q?7yeIoFYELX6loCuU76wnCBJJlBPGo/CMFbIHf3g8lvO9Xfoc1zr/4+dWc7OE?=
 =?us-ascii?Q?fii82sRsP7vtaAyrcaGy+zUWkkKTziApHB/0LKLPJDCbLTsrt198x4qMEy4k?=
 =?us-ascii?Q?KXCCMwTZVB8JmFBfYdK+wH/DbFrHvCtZLR1FGR1Ou4hHq9ui+1UEE11kgabM?=
 =?us-ascii?Q?vEU3PcDoMqUMMyzeVonk4X3u6J5NRDYPP1geO9tVXvBxg6+cEznRxA47l/fb?=
 =?us-ascii?Q?IQy4TIK4dxIZnjrj+P0QhyRVAfKlXFotUC2H0B8EzexvlyMFXrBTCzSBBtrd?=
 =?us-ascii?Q?rq3GP4FE+HtG9QtiytEuoWHAuU3DCGca6JCBVP7M/ioCcagBsI9nfixaYkFj?=
 =?us-ascii?Q?GHEHUdUlZIBYZzH0/sLdknH0/wqf0vsv9JoDsThrhTazZFVbRLn8LvBZK5BM?=
 =?us-ascii?Q?9UH/oZZ1Os8FIec/rP95t3RjqohqXlxq2wcHKxA1uTEO6Q6pt7i32DuiUMBp?=
 =?us-ascii?Q?6DKtj/uLl0UaAltlg5fHticIkTS5bVGZpMOjchUZHoc0BYgm/wF4LUG0c/iD?=
 =?us-ascii?Q?kM618w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CJlBvzHTuJi0UlHm0TWeRjyI8sB1jTDUJlFJQ9MehICrpi2GLqm/8+b2ZGFgbCiMpB5aBUY9wDRYFJv4PL8VhUYJDe0dRTxESMBouEDi4SzYU0zsolcMeioXDdlYKYOp/zidogWWSItFZEMTBwp62pBm2Pn/jM+dn9U4JrbjU5YqOc/XEZeswT/rmYPw9dHNJwZGX66HFbq5ylxwWEUqCCZRImiD+1nGzQRDvBLH3haOjZ5PbrKEErqeDqqOT9se2xK23v9PfY91ud/Pa2Yn3aOjd64SWMFGhrMtntYaD9/jGa5gV9IpN+ug56faO9uslZPYVJFY+PlS3Y3f5JFc7aeGAyTr3rTeVuj3oM4bosb7W4l1W0tAbi/hiIGw/Wm+Hlq63SAwL5YjTHa9j5FI2MJe/x+4FisInYfD/aWBaqNADiZrh7jqNvRQd0BXuN+e
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:12.3888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29593076-ac45-40d3-e197-08de731c2977
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17068-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 97D0517D1FE
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Calculating max_xsk_wqebbs seems large enough to deserve its own
function. It will make upcoming changes easier.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/params.c   | 94 ++++++++++---------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 07d75a85ee7f..be1aa37531de 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1116,18 +1116,15 @@ static u32 mlx5e_mpwrq_total_umr_wqebbs(struct mlx5_core_dev *mdev,
 	return umr_wqebbs * (1 << mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
 }
 
-static u8 mlx5e_build_icosq_log_wq_sz(struct mlx5_core_dev *mdev,
-				      struct mlx5e_params *params,
-				      struct mlx5e_rq_param *rq_param)
+static u32 mlx5e_max_xsk_wqebbs(struct mlx5_core_dev *mdev,
+				struct mlx5e_params *params)
 {
-	u32 wqebbs, total_pages, useful_space;
-
-	/* MLX5_WQ_TYPE_CYCLIC */
-	if (params->rq_wq_type != MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ)
-		return MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
+	struct mlx5e_xsk_param xsk = {0};
+	u32 max_xsk_wqebbs = 0;
+	u8 frame_shift;
 
-	/* UMR WQEs for the regular RQ. */
-	wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, NULL);
+	if (!params->xdp_prog)
+		return 0;
 
 	/* If XDP program is attached, XSK may be turned on at any time without
 	 * restarting the channel. ICOSQ must be big enough to fit UMR WQEs of
@@ -1139,41 +1136,54 @@ static u8 mlx5e_build_icosq_log_wq_sz(struct mlx5_core_dev *mdev,
 	 * from capabilities. Hence, we have to try all valid values of XSK
 	 * frame size (and page_shift) to find the maximum.
 	 */
-	if (params->xdp_prog) {
-		u32 max_xsk_wqebbs = 0;
-		u8 frame_shift;
-
-		for (frame_shift = XDP_UMEM_MIN_CHUNK_SHIFT;
-		     frame_shift <= PAGE_SHIFT; frame_shift++) {
-			/* The headroom doesn't affect the calculation. */
-			struct mlx5e_xsk_param xsk = {
-				.chunk_size = 1 << frame_shift,
-				.unaligned = false,
-			};
-
-			/* XSK aligned mode. */
-			max_xsk_wqebbs = max(max_xsk_wqebbs,
-				mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk));
-
-			/* XSK unaligned mode, frame size is a power of two. */
-			xsk.unaligned = true;
-			max_xsk_wqebbs = max(max_xsk_wqebbs,
-				mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk));
-
-			/* XSK unaligned mode, frame size is not equal to stride size. */
-			xsk.chunk_size -= 1;
-			max_xsk_wqebbs = max(max_xsk_wqebbs,
-				mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk));
-
-			/* XSK unaligned mode, frame size is a triple power of two. */
-			xsk.chunk_size = (1 << frame_shift) / 4 * 3;
-			max_xsk_wqebbs = max(max_xsk_wqebbs,
-				mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk));
-		}
+	for (frame_shift = XDP_UMEM_MIN_CHUNK_SHIFT;
+	     frame_shift <= PAGE_SHIFT; frame_shift++) {
+		u32 total_wqebbs;
 
-		wqebbs += max_xsk_wqebbs;
+		/* The headroom doesn't affect the calculations below. */
+
+		/* XSK aligned mode. */
+		xsk.chunk_size = 1 << frame_shift;
+		xsk.unaligned = false;
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
+
+		/* XSK unaligned mode, frame size is a power of two. */
+		xsk.unaligned = true;
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
+
+		/* XSK unaligned mode, frame size is not equal to stride
+		 * size.
+		 */
+		xsk.chunk_size -= 1;
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
+
+		/* XSK unaligned mode, frame size is a triple power of two. */
+		xsk.chunk_size = (1 << frame_shift) / 4 * 3;
+		total_wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, &xsk);
+		max_xsk_wqebbs = max(max_xsk_wqebbs, total_wqebbs);
 	}
 
+	return max_xsk_wqebbs;
+}
+
+static u8 mlx5e_build_icosq_log_wq_sz(struct mlx5_core_dev *mdev,
+				      struct mlx5e_params *params,
+				      struct mlx5e_rq_param *rq_param)
+{
+	u32 wqebbs, total_pages, useful_space;
+
+	/* MLX5_WQ_TYPE_CYCLIC */
+	if (params->rq_wq_type != MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ)
+		return MLX5E_PARAMS_MINIMUM_LOG_SQ_SIZE;
+
+	/* UMR WQEs for the regular RQ. */
+	wqebbs = mlx5e_mpwrq_total_umr_wqebbs(mdev, params, NULL);
+
+	wqebbs += mlx5e_max_xsk_wqebbs(mdev, params);
+
 	/* UMR WQEs don't cross the page boundary, they are padded with NOPs.
 	 * This padding is always smaller than the max WQE size. That gives us
 	 * at least (PAGE_SIZE - (max WQE size - MLX5_SEND_WQE_BB)) useful bytes
-- 
2.44.0


