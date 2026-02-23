Return-Path: <linux-rdma+bounces-17074-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGI8NmW+nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17074-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:53:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5989317D3DF
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D24230A60FB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782733783DE;
	Mon, 23 Feb 2026 20:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PYn2Ac2n"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9637C0F6;
	Mon, 23 Feb 2026 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879442; cv=fail; b=HmDzDg+m1yIhwFJo9p1pcgRYq1bEy+gqW2+QCHlBL0YcKVCINiSj0DJ0aACryb0OLPyfCajpuqi2Y6jpv1RJm0ID4gdNWa1enM7GayVvPmYTdNCz2aT57N+pvJVvvKEYKxI56/vA/cE83Zt4zXjHCKz4Rez49tqDirv8KtyXfoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879442; c=relaxed/simple;
	bh=af5JxZvXg3F03nAXDw/VQlrBA8GrYdJaTJs8KTq2PIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKT6ULlpiRU7yPhYxVqKQ+oK1Z9GzNJn4j10fLRCUC2ysOizaXBtK2XtFSWDMOByldaK1HS33Z4mxQuyYcGzbDACuN5Tmt+Jc2Qbz5UvtqE8Y9BpDYDwQBmabjNNiNsf+aFFDz2bmtusOAXII6Fcoxn+e5IQ8yPvaiM0bCs1BDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PYn2Ac2n; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NljeH7k6kN6PgRHn/uiPgogiU2nTnys0S8zgxB4g4j0oSSqcPCtAOR/4Q6GEqWE/8KGXOkcf2kS/k9q2/ABla3RWl2p5yTBqMRUc4N/k77m/uTxcZr09m7gbOxYXpvPnIBvBJfJJ4l8bMY7q3k+3Ixgc3d/3ZBhWD2VR2Q/xo7zGLRartK+qV0c58Au/3CBBYMu+lWG8NsDvl25hLqUv4osP+ww/SaOk7R5dUfCQY4N/CbtWFcJ5xZGEh2ZmauaZiJGRG+5MXoOt6mdktEmHyKpUcaNHKWk1WWY235fGn1VuaOcdOn91eroM8aFFdOv9L06p2OfN/axs10h0m1cLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0CIg2sMzLEMisetxGipQHhdRvR6T3QMc7zYIVeen5M=;
 b=wr+mfeGHUowNIEtUNm6nHhvn0i1t8/Jd7ijXPkevDNw8LtxIuS/yQ5v4lgYnrhUBJZ5ooskOdvh2UtUOHmjPc/KGJCJe8Igl0me6X2X+KQwdc7OmDEGLtWCo3+8c2i3BGHLraTF9elw8EO8rK0awRMm5VQx0bK8FmGkk5rEoqcSagBK/ZliuHjRqNMGmFFJ3lWXxzNsGgT7vQPoUyS1i6p0NaeETUErK63UQVKSV5gFclJ2cbg2l3oyG5uyfWNjy+mq5Slpr9TdcTFr9dg1BOLYoSZeMI6uUFN1RrOuIhn6ojparvTbmEbXuHYo2o3deyuhFuh8vNuEF0gl9HF+LtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0CIg2sMzLEMisetxGipQHhdRvR6T3QMc7zYIVeen5M=;
 b=PYn2Ac2nHr+msyveSA1/+bWpA+EGaZgmwZkxmILvc8BoKT+pPEq5uxyGRwKUYoOEkFhjjqAb7wHtgnTtk/9+0rTAQb98LvLP28jiMjeQZQbohxW0LCSWsKzo83GL/pzpYiRbo4UCcpITAAnRzDrtvHq8zpNw6GVyq0mPf9dVRimbCLVKB+NPj8h2WpZ00xI4cqvc2pLM2oNUiSG6xjbR7lz69j+v4XhEL1o+xJLVZ0MD09Wvkl1dKQZcAyRdJ/RhYDgdjzjHJvWGhBzNr1I0fxJ3yC0svE7fRMrG5ZWcq+LNnMat81OQ9+29BB7qG9G9Ub4CypZU60vQ8DncfYfXBQ==
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:49 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::c4) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:36 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:35 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:30 -0800
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
Subject: [PATCH net-next 09/15] net/mlx5e: Set page_pool order based on calculated page_shift
Date: Mon, 23 Feb 2026 22:41:49 +0200
Message-ID: <20260223204155.1783580-10-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: bcfafbd2-f57f-4489-f925-08de731c3fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VEwqqjk7fsNOCclVDjsfvfk+sKwMgAbiOfGDzBDamLscCaGE4a6oU4oExEdz?=
 =?us-ascii?Q?siPzC7GpfEgie+LKpJFsQvZwaw8bucMbobQVDN1r85HZrHsdPq3DPxHa2lpI?=
 =?us-ascii?Q?GAIpa6WZ1B99FxlboGNIUBjzfMkJoTvewvrtWCrtPtkVqvpvg1iJlNsBG8Jq?=
 =?us-ascii?Q?waBe3Eyu/wr0+AMNOQpxAgyf3c9hA9kE2MJ6AMwKDUw/m87GgKnMeclBxtbg?=
 =?us-ascii?Q?BhhhHllrzo+lvnNRORHb+ndWsoA4HnpiWH+7jgVzrh4itDaLemnxnhUAzyvY?=
 =?us-ascii?Q?+FOAVdiWV0Ypuq09SJVS1xg0vnrzCacp5oktofglQVefErTdU6S8ztWfdL0x?=
 =?us-ascii?Q?jx09gPgA2RTK4IO2yVue59z/6RwGn7xAA1Wmir+ifmGBevGlmaSuIbH5oYO/?=
 =?us-ascii?Q?63oq4Sb9L4tYWla3K+G6LsVaE6nbPQX7a62iklRlrhLrkucgZXmSh696j1sL?=
 =?us-ascii?Q?KLwuUZGZ74hbztgAdkpEgYqjrJbadddW+UNiE98jc3bTF3i3p60bveQ483xa?=
 =?us-ascii?Q?NwQH+iocWWWNn/plMsmVNNPhw8tpjCXRb6x5PRoYU3hfIuQK0aI2HJg0uUjr?=
 =?us-ascii?Q?mznlhTW+1lyuDSa8z4nQTbuCoJh8M+Svhg7OGjLA5Kudx5DRBluMRMMAULMR?=
 =?us-ascii?Q?qfK3jtak6NnMVr4NW1aML+9BgQCMk0PCaArHVfRz+pK32tYbds3wMDoEPyyO?=
 =?us-ascii?Q?wICcsG1DlcvCJjHqcf7pyy1aWC+tsMVZOLCCr4rMxq8eBnHbIVyYcCeECJ0a?=
 =?us-ascii?Q?tE6IiXhhEpBJWNrhFkXpQGxWmWx0k5ik2KJxXVsZcMR1lIpRuUxW217Ws/ml?=
 =?us-ascii?Q?28CThJCTyEnGfue6rEq8uqb80nLkftJJH9bUSwZ3C6yZQ4YAIcpZnBEjCBI+?=
 =?us-ascii?Q?2Y1v2SP37R60i2WL1V9B1b3cB8Pf9tWCKlBGbh3XDF3vOOIZafmcL4iAUji+?=
 =?us-ascii?Q?sZV38/aIW5AlYoMHR3A7S8uM7nzoTzZWM59EGP+lEgVVWMRS1E5Gl1d7yb45?=
 =?us-ascii?Q?YVJofvgJ2+ESK5GqgPaJQOjWcrNk03itjkCiQsvno65e0I9UnjldlQM+OEnA?=
 =?us-ascii?Q?tdu8uRItaSMh5HtlWEqkwrJE8GgLMarW2jq3s06Rg/HOGsRqGY00kCWngQYE?=
 =?us-ascii?Q?2eXbYsZYO2vUq+hZ34R3yAE/13yw1/s9GWqb8wuu4o1M6VAP+SGq9vFWs2wo?=
 =?us-ascii?Q?yz6te5ZP0ijW9idg93W7Jj0+xLUzyIXjDZYL/lIKaZxlZ3ooXBy6XWSW/khx?=
 =?us-ascii?Q?Oa46ao6ho/yP5kkRuUNVxDilh5gyQKnOkNSFbO8Yab0aB3jdiYb+Zpzk2uMp?=
 =?us-ascii?Q?IXGONm5g9G+imFDEnSMzzm6bZybPM53c4WUrgT6vJBVU+e1YJAEUhJExKEW8?=
 =?us-ascii?Q?Bm/9oPn3hmbOPcj3ctez5jHxDzR8/nGtniZ1hVees+GL3jjF1hzYWVqxCh8+?=
 =?us-ascii?Q?kY3wqiihCpDPPoO0CcKGk0B9pUaohtAQFJ7ruCAV4oUJZe2nPVE+x/meEQL0?=
 =?us-ascii?Q?XN7anr3VQYvZ+tjoSWDeLvZ1PpzO9C0/NQSLZPzoLnJJ094JFWQxWYmpD94c?=
 =?us-ascii?Q?MRL0/ERHyyW8eAlmt2lMzaTBPDwJ5XTp0uI007aYbbIimhqqI9OCB+cozMUt?=
 =?us-ascii?Q?HGrzJLoy/0BpGDInVfgIIo+H0Ldf5mn6iE2OFRFfxNo+H53GzjnUBgYZ9MdP?=
 =?us-ascii?Q?mtBuZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jyY2a/iwL4kNq1g0i2fC/AyJuDJG48g2rK0U/ywV/WXPIpr/q5+gvI9J3oZ5YEv5Cpm1BNfiSB0FO4F+bDXDpiCe94fWVLlgMyox86te25Azlsrwl9b0IO/gRt/4g185Jae+Ep3VeQY/BIZnCinJA1iG9oh2lCZfNdSH3IMmr31koyjPKL4H4hHUri60OM/CwTBHi8N+q1sW/VePXhaVVclclOM2QoC8jv4yKQp1s+2ZFHrYfbNH5nQ0DzX4XRlvEwSIlH9SSKVVtpxFGPKtwFczsBTH5WSb/QgshjQv7oBvsGWFVJghAclU/Uk+1cYa4CtZ2WamuExnLt/B3YHhWc0nRCRaPRfdPHUOnL40V+fVo3H0W5e6aJLXcJoy6BuqUjAoIFzbsvOT9fOFCSKLE1k42rIdi+0bgOF1nXeNLjT+vWa34NGm/1WbV+pzpghw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:49.7429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfafbd2-f57f-4489-f925-08de731c3fab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
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
	TAGGED_FROM(0.00)[bounces-17074-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: 5989317D3DF
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Instead of unconditionally setting the page_pool to 0, calculate it from
page_shift for MPWQE case.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index aca88fed2ac7..6344dbb6335e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -857,6 +857,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 {
 	void *rqc_wq = MLX5_ADDR_OF(rqc, rq_param->rqc, wq);
 	struct mlx5_core_dev *mdev = rq->mdev;
+	u32 pool_order = 0;
 	u32 pool_size;
 	int wq_sz;
 	int err;
@@ -905,6 +906,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 
 		pool_size = rq->mpwqe.pages_per_wqe <<
 			mlx5e_mpwqe_get_log_rq_size(mdev, params, rqo);
+		pool_order = rq->mpwqe.page_shift - PAGE_SHIFT;
 
 		if (!mlx5e_rx_mpwqe_is_linear_skb(mdev, params, rqo) &&
 		    params->xdp_prog)
@@ -960,7 +962,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		/* Create a page_pool and register it with rxq */
 		struct page_pool_params pp_params = { 0 };
 
-		pp_params.order     = 0;
+		pp_params.order     = pool_order;
 		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
 		pp_params.pool_size = pool_size;
 		pp_params.nid       = node;
@@ -968,7 +970,7 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.napi      = rq->cq.napi;
 		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
-		pp_params.max_len   = PAGE_SIZE;
+		pp_params.max_len   = BIT(PAGE_SHIFT + pool_order);
 		pp_params.queue_idx = rq->ix;
 
 		/* Shampo header data split allow for unreadable netmem */
-- 
2.44.0


