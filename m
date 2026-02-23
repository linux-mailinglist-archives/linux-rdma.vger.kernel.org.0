Return-Path: <linux-rdma+bounces-17069-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKEAGni8nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17069-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:45:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2BF17D1B2
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0FC230670B6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF5424C692;
	Mon, 23 Feb 2026 20:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LIAEPylD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013017.outbound.protection.outlook.com [40.93.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2E379990;
	Mon, 23 Feb 2026 20:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879410; cv=fail; b=GFOZgxg9xhaPWO27aJ2D4gCEi6NNQm8uiQT0uEGaaFGwa6D890yNIscp5DR7tRQnpVS6bcEkP28VT9eDx0u7sw0n9CuEh2Q+KAIVopdyULP4y1U9qucMjospt3OmpNkQMUccXtN78eaDzb4UXVLJqr97itRnfpRCPW6cAEVJUG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879410; c=relaxed/simple;
	bh=hlc9yrXo3brqq6uMSZqwmo/XKtX+y5bpcuzrtHEJPQs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSqhWPVcx/aHkM1jHPsCb6Hprvf18FQYqZKHlcwiV8ntHFlmbWniHuejzaLbVbkyX1I6d4viUOG4KK1A48pgpXsUVYVbcSj4iPgUgEJCVG/BHR9X0TVlsJH3j+l6vd80SI+LK56O/LZ62A2u5AHaIqZGqAcYyUSzWmBSc3Sh9UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LIAEPylD; arc=fail smtp.client-ip=40.93.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVH6pmrXxqbXE81cQ76HFYf+98u6MU56AE8Zi+jqQjmzIHJpIiaLRtq2+Mp5Qo9jN2XII2nyPqp5a/CYdQ4mBmARRwxKZtCj8PHgEv+ACEOj0lcOEtt4Bll6WAK09E57RhqwWkemrMOW/Q9syQZZgv+cD/qbWiouFFTS/+Kv2Uq8BA1vus/3UrRSK9VSMwjcHgAXr0dU2RRJfCVDs6guEIeUeNcHN8hHKEki4k/PkTMEUzXMnSI0nxwjBMvv1L2QBg0ustc+Xj2cUm2aJFYdG0hVckrPoGy9fUEEdBjLpolWaLPK6ic+7o3U0F5Zmxp3aYGjuFEF0hcdlKUgy2Ywug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X46nhMs8bH435VRAIzOX1GX6/cLe4oN4kcjNTvjAkko=;
 b=k7QSIne/JHDj+Utv4kMZhdF4bwdZdmOZCY0S5wa6wcQGeNlgveKMSSFGkzqRW3pVJovlw3PIncy/CscoVp4smPE33zzswx4txsRmLesYj8+hLyqKclenwsoDsxoL5+LZTNvILOWy9j8UMx6NBSd1NMZKaulUFMjyCaN2ccpQpRWhafQ6GYJXdcPVZJPXeq8PH2aE9UrGDIymVvVr0VOon985yiwFoLxf+RwMKdFLmuz89KzTxLJWnwIfNdaLF89OWE1BsSoad8GBUTyOzrOf2kUFrMQMvYbLXTjnwBvhYUHyfXT8CuzTQ0yxi09KcQrflvo16h0GPG8ZjRzNgGTXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X46nhMs8bH435VRAIzOX1GX6/cLe4oN4kcjNTvjAkko=;
 b=LIAEPylDarmaayWCFTWwuyI7iX6/vpBQKIDPrxMi7aeaOv7Ot5kAK3Jwnb2xAIyq4zXFoZYhTm/FlUl+p8uqu/Ty0fh1EeL2Bj5bl+2y62Npo1Y7AEeeudKy6GQ95WH8zFmJbXKbCAYqykFB9FSoqtLjoQKabAM14ZNw83kJzXqpAKoUHXloFLGM7OGa9770JSeP9/3Kdx8Rb+oxf0bxOOazzxkpK18QlUmUZHx02N8RS246TLBYY+KMGwdLS/K7sMxmSPVBgHLIroG/FUZoE84gH4f69Ijp50ug5upQw1dMACQaYQCiHw7h9rDfvWLQ4IgYviXzbICFLFFdzRIFaA==
Received: from SA9PR03CA0005.namprd03.prod.outlook.com (2603:10b6:806:20::10)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:21 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:20:cafe::81) by SA9PR03CA0005.outlook.office365.com
 (2603:10b6:806:20::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:21 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:04 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:42:58 -0800
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
Subject: [PATCH net-next 04/15] net/mlx5e: Expose and rename xsk channel parameter function
Date: Mon, 23 Feb 2026 22:41:44 +0200
Message-ID: <20260223204155.1783580-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e5a312-7409-4012-0d33-08de731c2ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cmus7hIuNv0VY5Vw+AMZ7OH05Gy2ogP14ymsokI5W5dELLE0A3bkbTDNOC7C?=
 =?us-ascii?Q?nipQ6myiat5GMhim2E8a8HZJy6sCM3cjsI8SZD1WCSc+txcjIOBRnD0ggILf?=
 =?us-ascii?Q?toHmCQ9MR/XKoJ+SbR6vfOX+ykJLwKSraFV2064EqJVV2VIReehQuhix2m5Y?=
 =?us-ascii?Q?hToh+yY5ZuJFumri2mf4np4zmnPCQ1rBSV1eR6xqQF4ncDC8cZf0A/BLHWky?=
 =?us-ascii?Q?DwiDoU/A35eHKsG/T6KYcDS5SZkkWX3Hi93YZ/Rcbt2OddPUqR9dsC/G5ZNa?=
 =?us-ascii?Q?8bwH4wL5sAM/fRwdzFflAgvh7DaSJHdvKPSBGsZkHsyxvgvC8Ohi1Ah7nFfd?=
 =?us-ascii?Q?iA4uVH8dUfecvKAqnIAMLRw6p+3zZVhekMQKHD53DIfCv0ekq6yPmyjAYV7N?=
 =?us-ascii?Q?O0jhQeq+HkRYU+qjyPQk+mQWm3/h3jeFWfS8A/chXhFnnBdzzzorasMZhcjF?=
 =?us-ascii?Q?p1CZpd2XdgWb3TvnqObxLNPglQ2kedDjbmY6SPvHgipYwZYQ4a0Q+MkXGs6P?=
 =?us-ascii?Q?TrYsFQqK1pUOOXt7/wraUo0WfcJLwgjFRZtrTjOzYBGgqPr+qmvp6Z+jJbhp?=
 =?us-ascii?Q?5dkvy5uf2WdKvz27df/f8/q4dON20z+pDL2wKsLtcj0mis5hDXLAD0nJGSqf?=
 =?us-ascii?Q?KXkZIxs0juUSv3s1DGOQWTCrmP3p3wwNlpj9k7jbEi0lBAZgU0ozyxTGHxs6?=
 =?us-ascii?Q?clBq1+m4LeGI8v5+oxohdyFbZygVSR8NdEZMb38bIHjeDR2aZFGutDae1HIG?=
 =?us-ascii?Q?Kze9lpUl4stPnCBOGFYgbXwB4y4sHjroiFkgNNHTqCrjgUaAtQHUGrCT8KRe?=
 =?us-ascii?Q?jwbxMRrzGMzi2vd9lNReU/b2RS8Fkk6K0UYfLWz1f7gWJEQSJ2mDwTMtar0L?=
 =?us-ascii?Q?jsqLi3x2psib2KiSgK/aKdr/5KLcE33TeOHG7BNLITWBjmlp0nA44uFSgCCH?=
 =?us-ascii?Q?cxYRsLGbe4joVc7iIulNXoNUcdBkJfxlElE0ESTXVemD5O0BVuoibcWmFiKA?=
 =?us-ascii?Q?+hUZwI1tK+DCbOKrwxRGSqMHnJ3Od2/bhhn9v29gO3U26rrlRRGLFQHvxL4z?=
 =?us-ascii?Q?EqytjNViCPxw/TtaBf/B8XLEXSZJDF41LeisLNcIY3ujSm1TkVaTgh59jj0/?=
 =?us-ascii?Q?+6WcUQrzt79YGZ2bt8JH7LBp6toB15eCJSPAxwSj5KQfjV/dk37LmD2KDJA0?=
 =?us-ascii?Q?LEVag1TB0HArgUn+v/x/6EppvFuhdwzqMflYwjipS6EqUi+1MJTSTjt8qPJr?=
 =?us-ascii?Q?LIAr7QAdCKbGm1Gko1nurF9rBM+GEiPulN6SuC4srKLZoPGgLjuQL5Eolln+?=
 =?us-ascii?Q?mN0y09t1WbvHsQuVAuPZpGYy6ty8JaJCLVj/PfBAP8UQRm0kCOXQpEenfOTR?=
 =?us-ascii?Q?BgPIgCUeg3PjE2czeXFfDHnJtb9OQlxSQgjVsDpQdsFOTuTLjP3yzIbs360H?=
 =?us-ascii?Q?rcFXtQjW1n1JRdj/hYM1p71vK4ua4lFGtnKAqzQSooX6uvFlq3DBosQMG38Y?=
 =?us-ascii?Q?P4R55TctkPG1mbBK6IYbg04xCUKdc0HbjMxx+P4+I+tZS+PsLnXZarqmqdDn?=
 =?us-ascii?Q?AIWGdy38ATETQD/TM/a0tkPpreVkzBJ9JN74eMfbV725DMXiqcghDHrRDVZM?=
 =?us-ascii?Q?MngqNZ19Cp2xVSt4h9NfRbMWKPx48m7FYgTfHYhe1yPSJwGmEadd9anOrbc8?=
 =?us-ascii?Q?rmhACg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Cxd8Eyt0pVEB5eu6qSBGqoWwZLjZI7i/tGZq4xR+ituPTFzpYmQk7rY/4IybQCYzE9WQIV8tMr1TIopyFh66/Ich6XlSmDgHrgjetTaIxBETJn2sS+hnGm48JuVt807xXAO6fkkrvz1B2IYy7RZ6dLBs8BBkvA34hxPioYrX7dJoEYVL5SLfwgxeD01WNuIFvTk8FYZxMds+oRzLpdyF5MY/sH4HhLYsS2SKw63Ww+IQDC1eyNREyn+ZLdj+8XAYHIgt1fgtbdCsMvpMdDY00XhoqbNUJcJksLLdnHbzm6r7mkB/3YccyGj+MuQD3tdbrG6G5MtktkpQ6cUeOK1JucG9/uEvNX9sl0tU+ZfErbiLa75X5uaptqM50hVlxKQuHFH1JSK1VnQTX6UmPbPI5YgxOPqUcEGO+r3TGBDu6vhgUM5rxks819goHeNkIJfe
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:21.2256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e5a312-7409-4012-0d33-08de731c2ebd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17069-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 0F2BF17D1B2
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

mlx5e_build_xsk_cparam() is meant to be the alternative
to mlx5e_build_channel_param(). It calculates only the parameters
that it requires using the previously configured mlx5e_xsk_param.

Move this function to params.c to be alongside
mlx5e_build_channel_param() and give it a similar name.

Expose the function as it will be needed by upcoming changes.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c   |  9 +++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en/params.h   |  5 +++++
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c    | 11 +----------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index be1aa37531de..4d51fad7d9eb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1272,3 +1272,12 @@ int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 
 	return 0;
 }
+
+void mlx5e_build_xsk_channel_param(struct mlx5_core_dev *mdev,
+				   struct mlx5e_params *params,
+				   struct mlx5e_xsk_param *xsk,
+				   struct mlx5e_channel_param *cparam)
+{
+	mlx5e_build_rq_param(mdev, params, xsk, &cparam->rq);
+	mlx5e_build_xdpsq_param(mdev, params, &cparam->xdp_sq);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 00617c65fe3c..26680985ee39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -138,6 +138,11 @@ int mlx5e_build_channel_param(struct mlx5_core_dev *mdev,
 			      struct mlx5e_params *params,
 			      struct mlx5e_channel_param *cparam);
 
+void mlx5e_build_xsk_channel_param(struct mlx5_core_dev *mdev,
+				   struct mlx5e_params *params,
+				   struct mlx5e_xsk_param *xsk,
+				   struct mlx5e_channel_param *cparam);
+
 u16 mlx5e_calc_sq_stop_room(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 int mlx5e_validate_params(struct mlx5_core_dev *mdev, struct mlx5e_params *params);
 bool mlx5e_verify_params_rx_mpwqe_strides(struct mlx5_core_dev *mdev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 50c14ad29ed6..e3b7e79863ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -48,15 +48,6 @@ bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 	}
 }
 
-static void mlx5e_build_xsk_cparam(struct mlx5_core_dev *mdev,
-				   struct mlx5e_params *params,
-				   struct mlx5e_xsk_param *xsk,
-				   struct mlx5e_channel_param *cparam)
-{
-	mlx5e_build_rq_param(mdev, params, xsk, &cparam->rq);
-	mlx5e_build_xdpsq_param(mdev, params, &cparam->xdp_sq);
-}
-
 static int mlx5e_init_xsk_rq(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
 			     struct xsk_buff_pool *pool,
@@ -130,7 +121,7 @@ int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	if (!cparam)
 		return -ENOMEM;
 
-	mlx5e_build_xsk_cparam(priv->mdev, params, xsk, cparam);
+	mlx5e_build_xsk_channel_param(priv->mdev, params, xsk, cparam);
 
 	err = mlx5e_open_cq(c->mdev, params->rx_cq_moderation, &cparam->rq.cqp, &ccp,
 			    &c->xskrq.cq);
-- 
2.44.0


