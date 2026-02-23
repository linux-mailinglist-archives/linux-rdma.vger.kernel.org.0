Return-Path: <linux-rdma+bounces-17070-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GRIDHS9nGlSKAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17070-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:49:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7952217D2E6
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 21:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD2703016B24
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Feb 2026 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7123A378D8F;
	Mon, 23 Feb 2026 20:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JzX9c9ec"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83C378D79;
	Mon, 23 Feb 2026 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771879419; cv=fail; b=I6WwE1FgEEGsdglVCukZGelOx2LG6AakdwtqwRoWQnR2kMyW0+AKin4mPlsW7dCHHA954t37aaLb4xaccLuZvOw6FuCXoKRCfHh3x/xDFNHQTmjuBRGy35YAw1R39N/P37uDTVB+3LvTTCdiK2218yw3u2qs0BttDct0nKi5/mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771879419; c=relaxed/simple;
	bh=59+ObMDxC3ZBCAazltJbe4/dnJkqoyEyBJM8aygB8E0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CF3tgFvcQglQoZl0EX+0sz6hi09CBcekkDyf/TDWPj2nKezJjhCC+dmPY5HUBwoxFyUS+XSbV7FfczaJ870y6eEKSzfwo1T13vLr4U8XYmUMdLuPT0eFybR/avTLJW6AUzcUMkumNaiF6ovgJ01P+CDn4LwKMnJ8XXlfpiRQGEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JzX9c9ec; arc=fail smtp.client-ip=40.93.198.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rjes3V7n55taPQKbZhRQco3lfcYhMJ/k8sh1cyLa4gFmLfbYzJS6iHYvNOfIQyHnP6wHa1YgOQIm/WNpTjaKnBBqXkB26kuLudwWuF96eldx6ssrY6Fim1LqI35iLCVOTyPHn7m+ZhqUJVQ3MjIK0CGb+O3W9pzl7jJM/Rp1AJgCaUOaYQ3Qcxdz/SPaw6NCQDDKD9AuLgWJ6kknCcqOURoQ6FPcXaie4Xsf10ICYABZzbKE1qZSEsYO8fG/ur/lmkW1mQ3iwV4PL0cvgW4A4lXWdxOcpQ9VlPGruY6dLlw6TYi8wUfT7NS3WH7n9Rm0Qhwne8XeyQU2+pNjTHBP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7O5ZUR03dbmi8HuflzaXvbW5qb+bJoMr8AiKIGMswo=;
 b=N0vnUC7KclY8UDNmWUVAWA2dE/OSn012Au2koGhPshRVTkFMHg9DLiB1TmJ8ePxDwiXx4YnwzniQr8a48/dsKgIhnDxZj4t1r0idOpSCbQjaI4K/WmGQ8noEmmUhogsSLol2AsG/5wID3oe32yw4DrdL1Ae1VyTL3OpuwkQA8mlw4XNMYHh2OjI+NsxFe9OnzWPSMYrd93oJqgccn25FOZwvo96qvL1P4rqCwU61uE+D1FJqiJomHAIKpCgzY3LGrH8u02U8cbdCZJdAWgkmshWvuJDgiN16VazKv8ut5QpNz8+bOQZOJfCuT/nEmXvHtMl4mE9lgRHBA+8xwnlK9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7O5ZUR03dbmi8HuflzaXvbW5qb+bJoMr8AiKIGMswo=;
 b=JzX9c9ecZO29VltD59OQ6WPr8G7tnHsvfLEWyapuJONY5Qvbco+yuFXs0p1a7tpoEB9Mmzw9M9mk5py0ltnI2K/aeEt4cOINiUNpmr6p/Bl4l7Kb6aJGoTHq8sqLMBMCSPwDx8/lEFp0u7CtyzEe+KWEgTWLkgpJDqLocPJij35EWYHX4jYtUupJ2reXa7MqXEzYxR2jGYOEOzIMITQAKuU0IWMkcfSnglYKBXyUxwumMrgv0FzSetXfwOKppCanJkTjkZcx4qKHRmzOCkgtkcskLzJIPA9+ykAr7Bqk+nYag9xw+A4YLt11EXZxPGTunzE19dKJ/69NQdRKgGxLbw==
Received: from SN7P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::19)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 20:43:29 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:124:cafe::ca) by SN7P222CA0006.outlook.office365.com
 (2603:10b6:806:124::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Mon,
 23 Feb 2026 20:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 23 Feb 2026 20:43:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:10 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 12:43:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 23
 Feb 2026 12:43:04 -0800
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
Subject: [PATCH net-next 05/15] net/mlx5e: Alloc xsk channel param out of mlx5e_open_xsk()
Date: Mon, 23 Feb 2026 22:41:45 +0200
Message-ID: <20260223204155.1783580-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: b8107a6d-02aa-4285-86e9-08de731c333a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bHH+6207j8Xo8MAJ0wK8hTmaYk+fTrlQ+8kTqcCW36wuGyJzGFCe8T2HJP02?=
 =?us-ascii?Q?eulgYBLxfSyfBW4TO+Xfwto4pqTpHL4U5BE8wpcKWQQwtkBcVVk9CQ4RA+W4?=
 =?us-ascii?Q?GCAzPl60jdMdmPGzLj+USlwnbK+G34p07XCcI2mtZTippQO/wc4X3vM+k1/J?=
 =?us-ascii?Q?3I7qL42WZRh94HVMfFM7exd5rHCQi8E85Cgz8jaBytsdVms5OD+sIZ2l831N?=
 =?us-ascii?Q?Mwp8Z3GBn+tv51FrYyoH6sHn8hs0xYCF3SVG/pf+m+2kEkW5Us5XshYmS+MM?=
 =?us-ascii?Q?/NtpwTQx/8DzVK4weQmoXVa+wYqcGWyMHv3OVEc4eEfZF9DqdOA5JOozwVw3?=
 =?us-ascii?Q?x6riNmm58PAsMOhWTvGJGBbrr7JTBxq/ly1LtghpFFfyI170doLvs0UrHGuW?=
 =?us-ascii?Q?F/JHQn7HA2ovR4xPcmqXVORZd/+SdJqHH8JbQbF7IYAFTHk/6R0JuU7Rd6cE?=
 =?us-ascii?Q?yq9oEAeLgvoeanaaz9o3cgrUCraWGm3bK1SskIpBAashUtUUqcGtVetMnfdk?=
 =?us-ascii?Q?k6WgfKoPUSJ3OrWriblvVR5efIXX6xMvtm1J2tSpUl7Uz/iKZYcC9s8vn/Fo?=
 =?us-ascii?Q?EUzrvuJygEhHQ7XPedbN+7V1gb/Dvtb9mTm0wElpgT097PUHbLKGNL9QiOM9?=
 =?us-ascii?Q?iJ88M9plF7Mcjv5ZzdLDLqoNLFsu6tc8Q3PJ7QIkP9LGAlA+swdLlRPkyD6n?=
 =?us-ascii?Q?LN+0f8bcvkd5c1IPIYn2zAMYivEK7pG/N1O8Y1iUDDBDXEFpXuA8ly9R7j+0?=
 =?us-ascii?Q?JQ3+NdD2+jYPvJuXwSXofIHdW0yZHln9uKLkNZqu680SMe81zICmgw1WCVtT?=
 =?us-ascii?Q?xLNa+OyIT1y6O1aBfl+Pc86HuaACW0hHoxYkC3FZbI4PB/NtFRWGirWuSOZ2?=
 =?us-ascii?Q?gspwZnRWrLyaWgsR9WCaUwaqj912hAqvlmDdGvZRiHNBsK/piv0vXnAuKiam?=
 =?us-ascii?Q?7/CbvGt5HZ+lPfKyrNkbcxKoD8Lb5ha0CF42HueK/ZbkKBmGBlNH0xPuuazB?=
 =?us-ascii?Q?MgtvZ6ntd7pxIvQMVYirm/Ix+M8aegam3i4BMjHirntZlESKRqF4xOIHtl7F?=
 =?us-ascii?Q?0k5/Ijd9FmUh0HJyeHjDdYFui/M5NSMeg2YZySq/7KjO2loT6S2TJ+l8w4QO?=
 =?us-ascii?Q?+KZKG0+6NQSSDegrZbkc8zqTeWmxKqhJ8yLbpaycIUzlJymXkNGVpcakt+Qu?=
 =?us-ascii?Q?fa/mvs3cnjuyByEwf4e6qsz77IzwaGLT4wvb1KtKDjlONVJdZsp8SFj9lOot?=
 =?us-ascii?Q?ImNUdtPQu6iVeVuTDCE8K1wo6lR2cJMEZIp6CIJeGVirWipVNFpqiQJgh3Vp?=
 =?us-ascii?Q?JR4mNiY84WG5yq+eDtrvaW0FUUO6ezBPCFJKS8mgabLnTqQ7U+4l+4laQgn3?=
 =?us-ascii?Q?eTZPfk2YcE54Q9FS6zNt5MgZChuUmnJJPXVNvQpwfHKGSggFPy9bjQteUKje?=
 =?us-ascii?Q?oodL7ySs0CioBCBodrBWOHDJCOBs07hlPCe2NJodz2NEicXpHKozoB/ulo/L?=
 =?us-ascii?Q?eEmk1M6lsLguIIoIi4kT3fnrq7fmgnm34Bw15RfZ749jjMu4MDPdX5lGKpiK?=
 =?us-ascii?Q?uHb50ecCpTlQaJ2nvtAaipozwBQuqL8NoFo+YLbNRluqleF6TznGR+ifbOuM?=
 =?us-ascii?Q?rgayJvbPsem1epqtAh0ObTbMuwn5qGHsJOJvE0a07a9aFyADoyxhtg5YfdNe?=
 =?us-ascii?Q?EdVbxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AvwvlpNvdWizVqZRLn4CnRvB4nvTkT21jtjQDuhlIW3eK9oHI9YGo0s100QeYBkTCTkOV5KDf6DevPDFPT+hg9XHxr/Nr4JfzGgRYs9Doy9LmrHQtLGeduQ/5/73tjyoMeGq1uEqYUqLk1MlPLItYM31Hdr8SAYTlNWeEj7pC64MSXNI+n6+hI2sv+c0Mm4haCEwj1b1qf6virh50PrAe6YjNAUCn/FFjI26jXnrSCDVjEcPdB10OpbdFpbG3wlQsOqsH9r/hWwrCK9h/ubbdO0nA8FiQnWmWZXjeP5oSbAJ9vXIMQMAV6nKjyC7lk3yBcIHgdeHNXe8/eo8cJExtUMxSR0Buqc92S/jQCvXQL2XeqVzu9iLzq5XdavQDLaSuWWnAAQYF7dbc2i+ForV08T0stj/OkXw9faK7EM/X2mVM81LC6A8DczQBxYw3JKi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 20:43:28.7511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8107a6d-02aa-4285-86e9-08de731c333a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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
	TAGGED_FROM(0.00)[bounces-17070-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 7952217D2E6
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

Currently the allocation and filling of the xsk channel
parameters was done in mlx5e_open_xsk().

Move this responsibility out of mlx5e_open_xsk() and have
the function take an already filled mlx5e_channel_param.

mlx5e_open_channel() already allocates channel parameters.
The only precaution that is needed is to call
mlx5e_build_xsk_channel_param() before mlx5e_open_xsk().

mlx5e_xsk_enable_locked() now allocates and fills the xsk parameters.

For simplicity, link the xsk parameters in struct mlx5e_channel_params
so that channel params can be passed around.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/params.c    |  1 +
 .../ethernet/mellanox/mlx5/core/en/params.h    |  1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/pool.c  | 17 +++++++++++++++--
 .../ethernet/mellanox/mlx5/core/en/xsk/setup.c | 18 ++++--------------
 .../ethernet/mellanox/mlx5/core/en/xsk/setup.h |  4 +++-
 .../net/ethernet/mellanox/mlx5/core/en_main.c  |  3 ++-
 6 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 4d51fad7d9eb..ef88097c1d4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -1278,6 +1278,7 @@ void mlx5e_build_xsk_channel_param(struct mlx5_core_dev *mdev,
 				   struct mlx5e_xsk_param *xsk,
 				   struct mlx5e_channel_param *cparam)
 {
+	cparam->xsk = xsk;
 	mlx5e_build_rq_param(mdev, params, xsk, &cparam->rq);
 	mlx5e_build_xdpsq_param(mdev, params, &cparam->xdp_sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 26680985ee39..c132649dd9f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -42,6 +42,7 @@ struct mlx5e_channel_param {
 	struct mlx5e_sq_param      xdp_sq;
 	struct mlx5e_sq_param      icosq;
 	struct mlx5e_sq_param      async_icosq;
+	struct mlx5e_xsk_param     *xsk;
 };
 
 struct mlx5e_create_sq_param {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
index 5c5360a25c64..92bcf16a2019 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/pool.c
@@ -79,6 +79,7 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 				   struct xsk_buff_pool *pool, u16 ix)
 {
 	struct mlx5e_params *params = &priv->channels.params;
+	struct mlx5e_channel_param *cparam;
 	struct mlx5e_xsk_param xsk;
 	struct mlx5e_channel *c;
 	int err;
@@ -89,15 +90,20 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 	if (unlikely(!mlx5e_xsk_is_pool_sane(pool)))
 		return -EINVAL;
 
+	cparam = kvzalloc_obj(*cparam, GFP_KERNEL);
+	if (!cparam)
+		return -ENOMEM;
+
 	err = mlx5e_xsk_map_pool(mlx5_sd_ch_ix_get_dev(priv->mdev, ix), pool);
 	if (unlikely(err))
-		return err;
+		goto err_free_cparam;
 
 	err = mlx5e_xsk_add_pool(&priv->xsk, pool, ix);
 	if (unlikely(err))
 		goto err_unmap_pool;
 
 	mlx5e_build_xsk_param(pool, &xsk);
+	mlx5e_build_xsk_channel_param(priv->mdev, params, &xsk, cparam);
 
 	if (priv->channels.params.rq_wq_type == MLX5_WQ_TYPE_LINKED_LIST_STRIDING_RQ &&
 	    mlx5e_mpwrq_umr_mode(priv->mdev, &xsk) == MLX5E_MPWRQ_UMR_MODE_OVERSIZED) {
@@ -122,7 +128,7 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 
 	c = priv->channels.c[ix];
 
-	err = mlx5e_open_xsk(priv, params, &xsk, pool, c);
+	err = mlx5e_open_xsk(priv, params, cparam, pool, c);
 	if (unlikely(err))
 		goto err_remove_pool;
 
@@ -138,6 +144,8 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 	mlx5e_deactivate_rq(&c->rq);
 	mlx5e_flush_rq(&c->rq, MLX5_RQC_STATE_RDY);
 
+	kvfree(cparam);
+
 	return 0;
 
 err_remove_pool:
@@ -146,6 +154,9 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 err_unmap_pool:
 	mlx5e_xsk_unmap_pool(priv, pool);
 
+err_free_cparam:
+	kvfree(cparam);
+
 	return err;
 
 validate_closed:
@@ -157,6 +168,8 @@ static int mlx5e_xsk_enable_locked(struct mlx5e_priv *priv,
 		goto err_remove_pool;
 	}
 
+	kvfree(cparam);
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index e3b7e79863ae..03f1be361701 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -105,10 +105,11 @@ static int mlx5e_open_xsk_rq(struct mlx5e_channel *c,
 }
 
 int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
-		   struct mlx5e_xsk_param *xsk, struct xsk_buff_pool *pool,
+		   struct mlx5e_channel_param *cparam,
+		   struct xsk_buff_pool *pool,
 		   struct mlx5e_channel *c)
 {
-	struct mlx5e_channel_param *cparam;
+	struct mlx5e_xsk_param *xsk = cparam->xsk;
 	struct mlx5e_create_cq_param ccp;
 	int err;
 
@@ -117,16 +118,10 @@ int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	if (!mlx5e_validate_xsk_param(params, xsk, priv->mdev))
 		return -EINVAL;
 
-	cparam = kvzalloc(sizeof(*cparam), GFP_KERNEL);
-	if (!cparam)
-		return -ENOMEM;
-
-	mlx5e_build_xsk_channel_param(priv->mdev, params, xsk, cparam);
-
 	err = mlx5e_open_cq(c->mdev, params->rx_cq_moderation, &cparam->rq.cqp, &ccp,
 			    &c->xskrq.cq);
 	if (unlikely(err))
-		goto err_free_cparam;
+		return err;
 
 	err = mlx5e_open_xsk_rq(c, params, &cparam->rq, pool, xsk);
 	if (unlikely(err))
@@ -147,8 +142,6 @@ int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
 	if (unlikely(err))
 		goto err_close_tx_cq;
 
-	kvfree(cparam);
-
 	set_bit(MLX5E_CHANNEL_STATE_XSK, c->state);
 
 	return 0;
@@ -162,9 +155,6 @@ int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
 err_close_rx_cq:
 	mlx5e_close_cq(&c->xskrq.cq);
 
-err_free_cparam:
-	kvfree(cparam);
-
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h
index 50e111b85efd..fc86d19ea2b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.h
@@ -11,8 +11,10 @@ struct mlx5e_xsk_param;
 bool mlx5e_validate_xsk_param(struct mlx5e_params *params,
 			      struct mlx5e_xsk_param *xsk,
 			      struct mlx5_core_dev *mdev);
+struct mlx5e_channel_param;
 int mlx5e_open_xsk(struct mlx5e_priv *priv, struct mlx5e_params *params,
-		   struct mlx5e_xsk_param *xsk, struct xsk_buff_pool *pool,
+		   struct mlx5e_channel_param *cparam,
+		   struct xsk_buff_pool *pool,
 		   struct mlx5e_channel *c);
 void mlx5e_close_xsk(struct mlx5e_channel *c);
 void mlx5e_activate_xsk(struct mlx5e_channel *c);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f2ce24cf56ce..35b767105492 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2829,7 +2829,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 
 	if (xsk_pool) {
 		mlx5e_build_xsk_param(xsk_pool, &xsk);
-		err = mlx5e_open_xsk(priv, params, &xsk, xsk_pool, c);
+		mlx5e_build_xsk_channel_param(priv->mdev, params, &xsk, cparam);
+		err = mlx5e_open_xsk(priv, params, cparam, xsk_pool, c);
 		if (unlikely(err))
 			goto err_close_queues;
 	}
-- 
2.44.0


