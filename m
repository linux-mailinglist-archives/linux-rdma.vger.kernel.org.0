Return-Path: <linux-rdma+bounces-22166-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FOfcJmrxK2rYIAQAu9opvQ
	(envelope-from <linux-rdma+bounces-22166-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:45:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C496790FD
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 13:45:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=VYuSyRcF;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22166-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22166-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0764534E26D1
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2026 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518AF3C3C01;
	Fri, 12 Jun 2026 11:40:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E5374A1A;
	Fri, 12 Jun 2026 11:40:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264445; cv=fail; b=k+AzbrswaJNNepzgcuiPpr7Qxn1XGOgoTeQRvohMnBy003klcluxVXoQV1n/he8oAz4kdGRVBbCDYhY86pM7GxUAso+9J4AHmV2wW8TGOkDsCwssQAcB6VMow+1jTacc7I3A2L5U4TM7LJ24alSN/akuciYCRvjrl9o6rvPTxcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264445; c=relaxed/simple;
	bh=VgXq6M8XVl205C6as7WC8UDl21sko+5McOSyc8usBpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIZBpUPsM6wljg6zmUL5Arns11DnhFqhNwNTx+vL6LqfLMVaU+vFLumSVIw2ajrDD5WI02PYrg6hUpdwXb5Vsr8Zz0ZCgMiHRnPAFxW8erTptv1S59qSQ+1v2n7FvV2Jzt5fNQ14t2SXhyp8kDMzV5Pct6ftWiXK/cJuFNthI8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VYuSyRcF; arc=fail smtp.client-ip=40.93.196.67
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5j1HSFCB9yRZpEgOZQ1JUZL2IwTrT5qMIfl0ebWpsYP0ua3O4XfHuLg9/P4qXPGpv906ImomuHDIcgFz9z2zJgoyn+FnBSP53JakTr7Hi5qtmvbwT2vwhMzXVRbJdGI26CAkL1aPEL3vDDtn/bkypVLneeijmncNfBdtiCcubCF0me+wGk6VNnB7E/6oi9p33GiXw191iB66A6v9PCPhjWsyxacpZkelchMz0995P86Tu12JuxrziJPTjyK9g6LyO0qlj/kEjz9SxMqTgZ/TaYHOJHWUAQT3RI1bVxxkUxjZ5odXNDAuqMpXelAfrlAqPbW7u1pRHGS6WJFxnVrPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGLMv4Kby72lGJCau0SwTIznPOYS/SnrAgM7iJx1Dac=;
 b=mbloqxuY77v1Rb5oHqTM2mfTuP8XKHYH9quBDuGLAbP8V7UzDVEWTLv9x7APnrAAeW/nL2SvF9hfpShEys9Rs0dfHhFByjs1Uz/NrX3TehldsOCY2wmHdegdmVrRZY6jDwDJYwP+jbar5tPku39gMc9bYEfO81Rc5ijxRyseacShX07HS74JcbiuXGW6Z4/KnCrTYX/WIT6Vnt8GjmaX4+x2MfSjPtuG5ZKyRed2usX8leZudIiBuchYRxhbaj7KPtPUKpHMkNbHKXB7YCcyj+usYtp8TZDM/ia0QVwPVZ/mCGyrcVoLmpy9+sJL4JdFxBsjHoQXlnhPdYdti/FmMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGLMv4Kby72lGJCau0SwTIznPOYS/SnrAgM7iJx1Dac=;
 b=VYuSyRcFPpDvpcshlYKaVUU26Rl1jFZhZ/VDQDyn2kbFb/CeTxyB1Z708s5Zvi1k1iUJ5b22TlN8yeys6FFfrwUpIAXKG5VnT1rHLIorL7tqalqKYiF++vgUr+vqpHRn4q/ebbAdK/doHFkEpE6BKVotpPbwARz3yUtAeC97vDvlBOEZqR8wBSEKpODLEjW24UfZiQwwBRobX5xdPvxrztJBlsffKyvypvOq3z+7xnFoPkTYw7Wc9oJx92bDeAtLRM3ZgfE2JCb1ZquadydY8BQznVNJFJpgIaXTjVkZPfv/SAMBTIUqulrr9dZ3k2Qp3oyWcHUL854K+x3IcU6CwA==
Received: from PH1PEPF000132FA.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2b)
 by DS0PR12MB8043.namprd12.prod.outlook.com (2603:10b6:8:14d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 11:40:37 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2a01:111:f403:c902::13) by PH1PEPF000132FA.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Fri,
 12 Jun 2026 11:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Fri, 12 Jun 2026 11:40:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Jun
 2026 04:40:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 12
 Jun 2026 04:40:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Kees Cook
	<kees@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net-next V3 08/15] net/mlx5: E-Switch, notify SD on eswitch disable
Date: Fri, 12 Jun 2026 14:38:57 +0300
Message-ID: <20260612113904.537595-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260612113904.537595-1-tariqt@nvidia.com>
References: <20260612113904.537595-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|DS0PR12MB8043:EE_
X-MS-Office365-Filtering-Correlation-Id: c35610e1-b669-44ef-fbc7-08dec8776b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|82310400026|36860700016|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gEkTO4tEIpOZkNqpx5NZmA+7FXET1zk7eaXneOIszn/L89aXbO5Of3sewF3qtjBzNq7qeTOOr9CUjK8JrNbq4VtleGlETto2vPYAmgarF93jiYQEkJFMr8dJJ2OwJm6StAXZVriLGNJ8Ryk8BJSTjGJ8JrnOsPHMv1VyLbViyo7Z4ThFYfD9DLzQqX2O3gKTQ4To+5UTbPQ2tmK95ncw1d9ajAIgqlTN3YjUypi8wgelwvZWwWgiFdz/95l5bqL0Ak/LHecZSO5cKHv3qfABGapGzdAFCDyPPEUNRXGujc7sdyQOvEn1j7Lz2Jw3HgAO4LG+Cvdc9mhe7yUbI4kBZ7IBNUZY4ymKL2HgI/6O4XTmMY5BuUucONmqc4obiS1Mmtd+++JZMXm4CWqpaZXqfkAjTvHUwwU8Bgl3a5CyXJ2IQ0rM4szyaunbju5HYmRTNt+KpAPa55Z9SAWQx2od9UfKqe4rIKR/2tOb4iRQI0SHFQxWsjTD6fXEAUtne3Zbi3kafqMsiyfQ1JW8DxRRfkxx0i88s4gJsypMsFvccBsGv9IoGsjow3+0o0kJB3OHMjm040iM0z/PdMfoE53ZM17kR8dWTYLPGCrbOXHmB1OE48XSn4zxwV4lwTnhhJ2W2qTOFdnv3tkc9rzaMC1m2wskGiIB+VdyNlekYcDD/N0tv3VJ3SqrZ/kN53KLsGBPV5H6AdS2tmRt1+vQIY/iWsTFhJ9qeBn9kJwKUQ9HtAg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hz6eHXHeVlQVyilzdIuxAs1bTFYXv/fO21h+8X47P/02F2IsSoLUuvX1Xz2WVoJ6tP4EieaolUqGNZzZrHPg/QSoQb7uIxuvaF0ii/ECzGZV3FO9Ujdi59zv8l/AIPGrlXOP2O4tmon3GBbZgZ4vL+Tj0CCcEA1TwYIsAYQal3YSjdnutrM9nugbfI/b4LX+wVEuTdP0AeGuVKuMT9GT4x50qpx6QfNYRLAmJoRpCr7qfnpm+k6wmwDRcG6iFPqUpmSqPNokwfvNe7LZMejM8e+Sm7t24QQSKHdnMEeqQ47HtXL6LiVEWPaCOR3GLl0EPSgOR8/vl7dn2cD5SRMk6gtSIdUDOHbIeoEaeuJDamTClkccRRlbbq1TSBPeyqbWKBdofIEPIfrF7XQCnid/fydDpmLdWEpIkoqGCE6mab/BBxvh1MELGFcGnbhiPoBm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:40:36.4468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c35610e1-b669-44ef-fbc7-08dec8776b99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8043
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22166-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shayd@nvidia.com,m:ohartoov@nvidia.com,m:edwards@nvidia.com,m:msanalla@nvidia.com,m:horms@kernel.org,m:gbayer@linux.ibm.com,m:kees@kernel.org,m:moshe@nvidia.com,m:parav@nvidia.com,m:phaddad@nvidia.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01C496790FD

From: Shay Drory <shayd@nvidia.com>

When eswitch is disabled, notify the SD layer so it can clean up
SD-specific resources such as the TX flow table root configuration
on secondary devices.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index f8cfbf76dd6a..93d51f09b17f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -2072,6 +2072,7 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 	mlx5_esw_reps_unblock(esw);
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
+	mlx5_sd_eswitch_mode_set(esw->dev, MLX5_ESWITCH_LEGACY);
 	mlx5_lag_enable_change(esw->dev);
 }
 
-- 
2.44.0


