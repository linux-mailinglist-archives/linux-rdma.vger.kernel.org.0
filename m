Return-Path: <linux-rdma+bounces-16985-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0I1gD8ZqlWkzQwIAu9opvQ
	(envelope-from <linux-rdma+bounces-16985-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:31:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9348A153B13
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 08:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553233053767
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 07:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DB9311967;
	Wed, 18 Feb 2026 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1I2jHxS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010040.outbound.protection.outlook.com [52.101.61.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD9530E0E9;
	Wed, 18 Feb 2026 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771399790; cv=fail; b=uLyGpioxsjT4UE+2GyCHPmnpFyBnCPnftO6orv9sv5ejEEzQvhonrlWwYrWhvy3PYZ2IOG2pKTmMYavL/8Q7N9QWaMDMC4EsI9ybD5ADmWugCaCb3CbkEYrI1TNf5YdrBEoMGgUEf0XrVYJ7FpEXR4zsWtOw35lPwNRz5Xx2h68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771399790; c=relaxed/simple;
	bh=cWJXKGz3Kzx7vqL+Ngz6qvM8NNJE5CC7tARk1fQvBA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mM+EBLhhX5wyuu3os6Z5gkSOMNTuc3ErgwciKbmsB7/EIRVcHxhWnJP3oyXxbvzonRoVHW0x20pebMZ60eBWU+4GDjPZCMMnTEx+stdZO2j1XSzAS+9fY2sobbMe2dVHt3lQg8ulQD4/FvH8RA8gdxhTkN3peOey5EwBU8YmAaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1I2jHxS; arc=fail smtp.client-ip=52.101.61.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZ1JDNMBNgvjjs0AVcLm7v+6RjRS0E+bnJsf/6S8dYPAk1904K4XhqT/ICYjTxoXh8Y25FelONFkXFc6qzT4FNOZvWLDX5HFotCoHTN1tAOpVx/agfzBmOFUt+Yped5oGI8SjNTcwubSRKBRUPDRhqidBIjrTWLwIuZWxYcI9oPKMC6LbBb/a6LV584hVYlCkuv8QtyUM+s95X2Ei/JC1gEkQpVoLiueuM7vlAv0oa5tsf5grHA6FMJT8FjiDGt62NPMnrer/Nto768kOGadok52k0cy42Tg/wW/NImxDda8C7vlaslxtcV1OyAKaYO04fAizwIcDqt9snq2DaJLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQ/tWNRUFx6m/f7DqAEhz1siECGfTfXEYQtWK6WL1lk=;
 b=ptglQQUQB8l0eMUmDNI+X1QGkuS7XXdsJY6EVyUUbX0cO/9gKIuBy52ceFmkNj37OIa8PWaMJPGjrrN7FWhXgZTWCKyC6tDJ9zlD4JL4g83oRjoX4g7s9Bbx1r2fOrbZz4KCg6BdX25Ee9v+0l4JFV6f9NwwoL4r7k2HP5zxRO/wCUR+AMqNo2EaDehVlMsHsbTWflAgxNJWK9/a97n8hI65oTGf6rfo1I8PpwdCLc/c2G8w2e9qcBxoLdtQskfnS2fbQVxR/bi7m2KKo7GnuNalmONk9Nrk6zC0XUcAnuDmZyVh837zIaK6avNWP5SkJuyK4ONwcDZ4gkag0HeY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQ/tWNRUFx6m/f7DqAEhz1siECGfTfXEYQtWK6WL1lk=;
 b=m1I2jHxSv2vUzJKnsYAsaJwyQoR6jvhzKnLErQlju/TaicNTE/GzE7BHodWNaDh+AdTmRn3IfnlNCrmno6jWa/WuwkV2GlD1IZxK+OA8Yx3fM4szVC4UG5xcggAEe/1Ybdt6NMCYuo3ByJLBgEQ9w8Ddz9KkhvM5xtojVNyzUS8KTaEUWlBHFgdtsnvzYXq37e1pjtrY8Pm40WPnA69LvVv6k6pQsFDJ8gbtuE3HwuMNg8n06+WIY96tpe5259+2BSl/sNx+/7nEoq20Ka0TBbhbMj1PC2PTu02BdcgGSqpLhE4jN1bjPcHxKtyS8kz0J7tA4T9PWhOEIWAo2SJMoQ==
Received: from CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::27)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 07:29:44 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::99) by CH5P222CA0006.outlook.office365.com
 (2603:10b6:610:1ee::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.15 via Frontend Transport; Wed,
 18 Feb 2026 07:29:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 07:29:43 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:29 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 23:29:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 17
 Feb 2026 23:29:25 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net V2 2/6] net/mlx5e: Fix misidentification of ASO CQE during poll loop
Date: Wed, 18 Feb 2026 09:29:00 +0200
Message-ID: <20260218072904.1764634-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260218072904.1764634-1-tariqt@nvidia.com>
References: <20260218072904.1764634-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d19c434-0ca6-48ce-ce52-08de6ebf7c43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjjuOp/5l5Heli2WjhZU8yi6DmuaGqRT9Fn7WSV60HsqHoZHDWvv0faVS2JK?=
 =?us-ascii?Q?5cyvYUHvgvcON2h6Jxpj7BlsZFc9anusp8NpbXTB3eiUV1FY9nfEhQ5Txh/P?=
 =?us-ascii?Q?00Cd3WL6kY2SAXrEtTIj15tcySdtQV8hC/Kuntx3R7BQL365qK7Lz1su4JFQ?=
 =?us-ascii?Q?eYL0pgUST37c5TBoLPPoaavrdHdNpIpYzW00W7wEXAEAsQmgcFDHCIvqZQ36?=
 =?us-ascii?Q?FPA34+e4549+DUV0ge2nNVddrcvWPt/v0K9ZLhJipwiz6YrKIUiCueoRDfhe?=
 =?us-ascii?Q?dwAqOHRtHTMuh7DnDt2c/ozi+Cnh4rHwGcj33utt0vv7k365DrLmwL8xjwSY?=
 =?us-ascii?Q?3eF2AQOs8tp7tqUbZZRISIleKN2HUqZBiduuG1B/ytl2/4MVPU7XcnQ47/rE?=
 =?us-ascii?Q?dsi8t1/TiX5zmivky/XQkoZWOTmYJ/E4EQohV5vqi/DKD0dR6aAp8vbtUTR6?=
 =?us-ascii?Q?/bV46DhzHiYgVuRaQXgmnFbsWV77kmrFX0Imwr0vb28YUIvm2C403N+6OVnb?=
 =?us-ascii?Q?97+sTU1+KK88B6UVh+5kAYBRSkMyxuhWCgkfFR3SnKZ0nNFh2tsioz8f82EL?=
 =?us-ascii?Q?IBg0CY9S37BDGX3URBuu8y0OkcgIcT0Ts/D3gfnXHMKAmocBK4yizOdCzCSW?=
 =?us-ascii?Q?tl3vtCWjrTDWxpiFGHBWKNt5XZGUmxW6j1QtoSWN9RYrXKLFeuC7k7hH8Mfw?=
 =?us-ascii?Q?2PzbKQ7H7jpBcnkeDvW7yFwSFnPhJ5oNa9tA2FvnwhMXr+bKnY1DrTpXyV/f?=
 =?us-ascii?Q?Glv5222TZxnxBAGphmfJomHpbzn5S7igztTJffk5NNU0ejWyAD9Ceuy/y/Lg?=
 =?us-ascii?Q?af8VLpUabIFr9ZXbmZgKrg7e/1qUvgIcc/4hliPZBfedm7pdo+JujagGevsF?=
 =?us-ascii?Q?lBOQpz2zRxhbyrOAd3pslX2c23Nh0g2SP0/PPXfBH8v7+s921d5Xmc1WwQz2?=
 =?us-ascii?Q?0a/AJKoV/Drab7jKclFDzu5DK/hPBnlIV4REfTgOEkt0VnI+SF3qfKqi3uck?=
 =?us-ascii?Q?6oFr0fq+vNzpT57bNp3AsITQWWP+n8yZIdvCrDBA3nJYlsUodrOuW6GObjLb?=
 =?us-ascii?Q?ex5+CDjL4wU3qWq1Y6+I6W3U5rvV1d0C+ThB18ah3P9fhbmotvjVyUfK0kmk?=
 =?us-ascii?Q?TV6BxfhXWWntBV1/pFgelYU37btHiDd71uXb2ShDr1lNQP1hGnTbWxyWx90/?=
 =?us-ascii?Q?Nl6vvqtlsByQSH9lcgKNqrZecLeScXGFbpGDhIrJwyFDDRLD7syhhur7/Amu?=
 =?us-ascii?Q?ZhQixSuR8bPM2JXO7QByJcTLhsJNre1xhpl8l7vuf4/Q2MUcpErz/HxqMoUa?=
 =?us-ascii?Q?gielc9T116vm3zx9V6k37ATedSMe7n/VFSoPH9ZL9MLoZ2tNk3f8s5LEbio2?=
 =?us-ascii?Q?GwJimYbgvM65MWdtAG0k8Y3jK1cdITuWbW2vQayF0nhR9uoPaiZDm9vWgOMP?=
 =?us-ascii?Q?8hQ6a4Iv23PZtkJuk2smsUBkus0VqsZxstJuKALbdXdwrbhSkA/MHzmuhNr8?=
 =?us-ascii?Q?lP8V0wc3i47fHk7y4snnwHccWQlfjgKFo5unCLd9AyqzoLZn9PaNFm0h6cOd?=
 =?us-ascii?Q?CyjcX06RFqKqJ/GmzAeWvKraTwpt3tj/ajqWryD/gDRxSd7f1HWTvPb3VJhm?=
 =?us-ascii?Q?+EoU+xnoolv1iL2X6JzAHT6XIs8zVhQSsI3pLFvGESRjAQ42cHz1/hVAZcCp?=
 =?us-ascii?Q?AJPhqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yoLaDaVL8mBs4arBrV7fewv9gLxSI8IJte/HQDuCWkG8eT0tSVL9/zpWEKGjmbCEsS0pxQxoV/8w+NDyVdTORPh6H262rlQQZPATY39YpCh/eJc5SJBY84Ty8PMd1EKuGkSfDf4uxhGOzSEWFxyH73GwiwKEm8Bsw/C31RqnkPOSpyuEIHR0CXcT/HDr7rkkZeooDd/lVu5s1rzD37riWEcOFWu4Gwgge/Xj77vJgzhR/vOm9j95yXzXCCxzsaUO6lGalTHT7HYRUa6H0brC+i9h+78c3yoEbucZ//1OwueU0TY4AI4ygGx0rqQu2lk6CZugNitYjlYnQHKiUS7CpoIFr9XdlKxYyNPI73Cypxqh//b1dhf+t3vWWRFb1qXSrzN2LvUyirWCZmJ6ZXEFcT5At+DlWe2JEu9ECnFpN7R43nB4h/09SjSvloohAUTJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 07:29:43.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d19c434-0ca6-48ce-ce52-08de6ebf7c43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16985-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 9348A153B13
X-Rspamd-Action: no action

From: Gal Pressman <gal@nvidia.com>

The ASO completion poll loop uses usleep_range() which can sleep much
longer than requested due to scheduler latency. Under load, we witnessed
a 20ms+ delay until the process was rescheduled, causing the jiffies
based timeout to expire while the thread is sleeping.

The original do-while loop structure (poll, sleep, check timeout) would
exit without a final poll when waking after timeout, missing a CQE that
arrived during sleep.

Instead of the open-coded while loop, use the kernel's
read_poll_timeout() which always performs an additional check after the
sleep expiration, and is less error-prone.

Note: read_poll_timeout() doesn't accept a sleep range, by passing 10
sleep_us the sleep range effectively changes from 2-10 to 3-10 usecs.

Fixes: 739cfa34518e ("net/mlx5: Make ASO poll CQ usable in atomic context")
Fixes: 7e3fce82d945 ("net/mlx5e: Overcome slow response for first macsec ASO WQE")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c  | 10 +++-------
 .../net/ethernet/mellanox/mlx5/core/en_accel/macsec.c  | 10 +++-------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
index 7819fb297280..d5d9146efca6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 // Copyright (c) 2021, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
+#include <linux/iopoll.h>
 #include <linux/math64.h>
 #include "lib/aso.h"
 #include "en/tc/post_act.h"
@@ -115,7 +116,6 @@ mlx5e_tc_meter_modify(struct mlx5_core_dev *mdev,
 	struct mlx5e_flow_meters *flow_meters;
 	u8 cir_man, cir_exp, cbs_man, cbs_exp;
 	struct mlx5_aso_wqe *aso_wqe;
-	unsigned long expires;
 	struct mlx5_aso *aso;
 	u64 rate, burst;
 	u8 ds_cnt;
@@ -187,12 +187,8 @@ mlx5e_tc_meter_modify(struct mlx5_core_dev *mdev,
 	mlx5_aso_post_wqe(aso, true, &aso_wqe->ctrl);
 
 	/* With newer FW, the wait for the first ASO WQE is more than 2us, put the wait 10ms. */
-	expires = jiffies + msecs_to_jiffies(10);
-	do {
-		err = mlx5_aso_poll_cq(aso, true);
-		if (err)
-			usleep_range(2, 10);
-	} while (err && time_is_after_jiffies(expires));
+	read_poll_timeout(mlx5_aso_poll_cq, err, !err, 10, 10 * USEC_PER_MSEC,
+			  false, aso, true);
 	mutex_unlock(&flow_meters->aso_lock);
 
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
index 528b04d4de41..641cd3a2cdfa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec.c
@@ -5,6 +5,7 @@
 #include <linux/mlx5/mlx5_ifc.h>
 #include <linux/xarray.h>
 #include <linux/if_vlan.h>
+#include <linux/iopoll.h>
 
 #include "en.h"
 #include "lib/aso.h"
@@ -1397,7 +1398,6 @@ static int macsec_aso_query(struct mlx5_core_dev *mdev, struct mlx5e_macsec *mac
 	struct mlx5e_macsec_aso *aso;
 	struct mlx5_aso_wqe *aso_wqe;
 	struct mlx5_aso *maso;
-	unsigned long expires;
 	int err;
 
 	aso = &macsec->aso;
@@ -1411,12 +1411,8 @@ static int macsec_aso_query(struct mlx5_core_dev *mdev, struct mlx5e_macsec *mac
 	macsec_aso_build_wqe_ctrl_seg(aso, &aso_wqe->aso_ctrl, NULL);
 
 	mlx5_aso_post_wqe(maso, false, &aso_wqe->ctrl);
-	expires = jiffies + msecs_to_jiffies(10);
-	do {
-		err = mlx5_aso_poll_cq(maso, false);
-		if (err)
-			usleep_range(2, 10);
-	} while (err && time_is_after_jiffies(expires));
+	read_poll_timeout(mlx5_aso_poll_cq, err, !err, 10, 10 * USEC_PER_MSEC,
+			  false, maso, false);
 
 	if (err)
 		goto err_out;
-- 
2.44.0


