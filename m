Return-Path: <linux-rdma+bounces-19190-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHzhA3AM2Gm5WggAu9opvQ
	(envelope-from <linux-rdma+bounces-19190-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:30:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 678663CF836
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 22:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BEC5302796C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 20:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E0433E377;
	Thu,  9 Apr 2026 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xc9YD94k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3305828313D;
	Thu,  9 Apr 2026 20:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766577; cv=fail; b=HarRrJZid0LK5gd1I/OPpXj24O255h8hg9ulhyrhqqXCe6k0Ti8yFV924oqWucgSj5TZQxhfZgkWbDy3Ke1lzomsxn74IZLBROXJbxwFCOi0+xxOv5Ac7Icajl4Fh+J2nKHPvSRtzfNEYDdYnB43BYd+3s+xQej6CHC6eR/mvvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766577; c=relaxed/simple;
	bh=gxn9QOCOEkf6WGEYcY/CEqRhhN4TO4vFcKuupLEbsqs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjaVp+wGIT/Yh9lC0CaMb/sz9lLH8ryqwq6FGvXOFC2eqri3KPQUy2GVsWYfwyvKi2GUiQ6o8FIXIeKfnvTfSMYVj2NF7gsPMHNRjFSEYihl6la2oaLh/pVxl6YhMa8UAi4c612v+se4Ejiwg2+X3xD2S/n0DqY6OashWnGqAM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xc9YD94k; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpqVBGm9QpddRafiYntvFTs7Mmwrpfe3X2UFAmSzjOa9KTjKI+zZQpbBSXIc6um6OBHWiygwUcfFEXsmpUjkl/eFxjr8kLcL0paxP4W8H2CY4h3FHcXUmrrtNincBGkMOA5JVERhmYKSMf9I2UoJeHKTliXjEYQJLy5znhpXwsbnaIL/5IUvChkqsdf/EBxtVrrAotFthA4FTqVrnooh6To4UyNXaBRzihCD36Brdcf6hBySgSp+aQCtBz6Sx0+xEJXFiONhQwl3jsB9iyPl50Ci6y9boxB38JDftq2dIsd5Uud6CvY3GMdWp5u0SgDedfNsyUb1imrP7bQyWttgZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f2rY0o76Gvi5nNuGT+3JAUQvKFZIQgomxSk4fUDTW4=;
 b=NPfsKdsKNEoGNBrsgAyyGtXzqY6G9QySG/Pk1uXnzBvOIxRjTCNkx3GG3UvRrbjRIOVSCcp7JaI4yalU8xigzQF5DKawgJCtFR3G2Si6Hk5iTnlcEsSP//lMZbHmkkGWjQX57HGoak7DGTSGImzcu62RFjWnyW7IQQIUYRNSszDyWmzsTDmJFwMvXnIHOr2sfoYpSxp4c9Udnsk62eybMTrcxCzrV0HJGpgNYCZydsxxa9FUBsG0c4LXY7icxqYCT4/MB7bMq66BAxYqPT+Rm9CBAgLfWuHDTX9i543xpnUovuBdl4ZC5KF/vVFeK3q7md7lGqLWkSjQbi8uM17veA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3f2rY0o76Gvi5nNuGT+3JAUQvKFZIQgomxSk4fUDTW4=;
 b=Xc9YD94kMP9l1rKE5TpniKPErmNG6OfPqpi8hDOVYbhkG1G++rKwJt556W6QMdgAhufkRG4gnkYxm31JZtr3FQxCJVcqKN8nGRA1DabE3ZiAOgQP+sCi8b9nYtoWRLhJofEjNj5OVLIzGE1TiD2N6hHt+8YhqvBYAL1bAeiSi1jLjsLuvw9XFsXEREuVtbyyKQDieAt7zDWkPH0jxeHe1XFI4bhDk7HcZOn42hv8/iaIJnoEtfY71R8bwdcUSbBcAF9iuGG2fIbCzWK0qhjMMelMH2OQzZPf3zjQ91+1O9dYMBTkZt/QFRRbDoF5TB1qVseV1kA2aJZipDhnfNvEqg==
Received: from CH0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:610:119::16)
 by DM6PR12MB4169.namprd12.prod.outlook.com (2603:10b6:5:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 20:29:31 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::32) by CH0PR03CA0381.outlook.office365.com
 (2603:10b6:610:119::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 20:29:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 20:29:30 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 13:29:09 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 13:29:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 9 Apr
 2026 13:29:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Kees Cook
	<kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Gal Pressman <gal@nvidia.com>, "Roy
 Novich" <royno@nvidia.com>, Roi Dayan <roid@nvidia.com>, Raed Salem
	<raeds@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net 0/2] mlx5 misc fixes 2026-04-09
Date: Thu, 9 Apr 2026 23:28:50 +0300
Message-ID: <20260409202852.158059-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DM6PR12MB4169:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cede42-27ad-4c05-bf3f-08de9676b445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ykm1TOtwqH/JzoompSfxKLgYBI6CGoRKFepR3bwOV63qLsglDUF4+SvSDOyC26lYSlDK3uTx79mRvshYhpxqr7jCl9EnUW9UCb7miwBL2XdtYiogL4TkORzjLRpjJHlaea32I9C2SueJyd4G/e7tN/9qi0XR9rvu93hYiSOrFDTaLFxSZu31aB9Ekrvcof0NG5u1RGv4sJlAPGX9rhcCdQY3oEgRBSS6b2S7ycyyDtiwN8vQ/33LnpMJM9XVKy77s5ROLxpwNht4bt3bFkpQhs9va9w0HfN33CD8fIkF2NuTTfUPD5EcjbUbQC75H/uaXyeHzyhtUlDBd8Hr7pbv4Ys1S+tDT8tLqYRKVOAktSzmgyGGpUPFJrDqHZObZC5Q6aMpGiRo5wuz88MEb0ElYCBLyu8dP1BBIQVhYqtj/b5fWjTZk3M0d/FKIIlghzBRgSyhUwjQqhEqYycSjtCFIf4AT+2MSe7zGWuw50Tl3kpgWJQRwy6+7txwtPnkE7dc93K5ny+0ULcYLJgL3J+l0SsFrwbD0sEdDTIBSITX8T5fyCwntFpfkx3ENcgo8YFMi3v0WiovUpwYVJ8RGDrRwW8Ze4/D0Sstg4DnxTohqsy5F3YZGhVoO3DgAiOKC8QpmRzxIp27S3Evi1LgAKQwsqbMnu1t5WsG8drq8GVqCAlRmcuV7tHUk53Z2gsvyENYYzh0wQ4oQtZP29kHWb85aNNSaOEYRZUpBDSxd7j6fO1r4qDqIGs1yzsQrcI29QwICtQmUBDuv2Qo7rMc0Go9WA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IRLCzo1EOPaUDrbHttIhALRDfB2Fx2YuVNQZPce/aHoSa7BVus0vSDeXnQJpMTB5ef9EzLdaKRdO1oCy4BFphx4G5JeTRD+RkaOl3t9FABXiom2zrONNgUEpIvzNhr0n3CNq3agwkP6oLArL45gbdf4z7pP+GAZsaJjFerXDaQa8BFKR+tJDezOa5yuwZ8Sxm6USV2OYx1GZoK2JMZX+R4R2LlUkQig4WnZXqEofBsnIlhzt/O8l0vzthx0raUoD4uQqD+osMUh5PT6UVS3P97l641SxriLFfIgksbRNiPRLUgQ20HldFAUk4A6nlLFWLO2nEKvTBdLvzkcoPpYn2xNBt8UsuQ719BXyYr27wOACFM0cJFR+PkXJ72u0a2Nb7xbitjCjQdBPJl9yQE/Qwyy6K6+HmqG1ratDAFbFnOg8tWoxctyEwq2N9RLYLLy9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 20:29:30.6298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cede42-27ad-4c05-bf3f-08de9676b445
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4169
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
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19190-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 678663CF836
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This small patchset provides misc bug fixes from Gal to the mlx5 Eth
driver.

Thanks,
Tariq.

Gal Pressman (2):
  net/mlx5e: Fix features not applied during netdev registration
  net/mlx5e: IPsec, fix ASO poll timeout with read_poll_timeout_atomic()

 .../mellanox/mlx5/core/en_accel/ipsec_offload.c      | 12 ++++--------
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c    |  8 ++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)


base-commit: ebe560ea5f54134279356703e73b7f867c89db13
-- 
2.44.0


