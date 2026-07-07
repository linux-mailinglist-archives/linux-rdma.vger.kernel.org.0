Return-Path: <linux-rdma+bounces-22827-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JdxUNPL7TGoFtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22827-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:15:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD2B71BC2B
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:15:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=EQwV+MmR;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22827-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22827-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD8EF302A646
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A272C414DCD;
	Tue,  7 Jul 2026 13:11:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012055.outbound.protection.outlook.com [52.101.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A2414A3B;
	Tue,  7 Jul 2026 13:11:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429898; cv=fail; b=Pfki2SXie3U1FcBm3yuuyQSBMvP6lddVgXoi7ZnqPFazm1QEMTaksixQHishdmWvOY+wjEOyKxYbBi7awu5c3v3Eje76ERoAxhiUoPnoqAYDmRbyNyT1+4dCzeb2rGxIe2XACzCTrJVmPDyUfR9/JBSRSmL38uM/q4lkP6AQPys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429898; c=relaxed/simple;
	bh=jc4/qS++3XoTSbzN+JyUwdM2Om0F4ZyE3gtLJubsLtY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QB3/YHMz2VaQgDLSa6/XUR7/DoDBux2RpQIto7UC8Dg3mwXRXrqyPBv1nl9+CBD+vfcY3C2EXW3FqmCQjQ0+/Pzsm3nzEMPbnz49YWhl0xXxOfvGCJe2ozAjnw+SpEwfCehNMFwCWmO7expLjbf4fZ3KdlsBp9U2PSfnsI5JaME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQwV+MmR; arc=fail smtp.client-ip=52.101.48.55
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cPkcNnuVq/o7E9mwToQlGeik+J5YSM5wBWTgT7OsOYx8fO6/xnNCDV55IdnBQ05GnHlES3NL7MRnfcNRkcHMO/H7Kg33VkUaEP7a/o4jN/FLCSexaRzxbFwwGNr0Di9R6uDNdlAea+xbNZ/edHMseimvpZCYcHVxxUSqbXZRzdmYB/iKVq28jdW5STE4FYRmrlluJahJytw3q+OQ7if1al+sNlgrvroM3YMVOzvPg3swzffDmIsra29XRBWEoxYkbuuLkOvMUeNtdANsAuWLMKIwTPTVw6jD5Wpv26HFPoe6MXOkV5I1SENUT+FtZWOfx+uXkdEwXnhIsfTPOvTeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9MuGrAxhKFBPhOKSEQ/XXVx75/r+Wyh3qr96w15ag4=;
 b=S9orgRRJoTi993nIPeDJ11rZUUw/pQzf7nQDUJlU1mkzlzQuVpZAFq9adtBIV+67Q2Bdaalr+RMRXc93epkNdH7XNuuy8YelyCVa57YK10PbmSeroPCRAktk/t58olJsLXFB0KMHBRBSDNFf6j4mYLxSix9Tdr29K5s6QDxDAqKoF0Poci2Ay2WEvD1ZtCoV9Dm4rWUwMKrJ9DtPRveOEBNHTdPGvZflUR1ZwccJNpSYeKS4Eeahy7qpWD6vjCSt9BuR7L0U/1SkqbH/XDS805/HFW3w8kqsbAlfvQOd75Fi/PQKmq9PE8Vwux2wzDWql8cadfgKNUQd/wfyJiMgmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9MuGrAxhKFBPhOKSEQ/XXVx75/r+Wyh3qr96w15ag4=;
 b=EQwV+MmRaelWzFCRZlxNQYealeyyCgziveVB8Do3+/hEsEiLDGzBf8Rv2/1hHRJdRthRWtTqpP35jXI1WOK+xy+X+kv6O4fGcWoc27tMbRV0bauVrlJLdOn9Qw3pbXmQH/9VZM+SdObny8NPrs21b5cjD9OgFtJr702RoJEqmxHFilvAD4qBhfHyKQRcX1kXUJO/2Oweh0j03yO++GAhEIri776HrHtpVCzk6sPi/PFxOvtluMXP/qDUcX7GenUNIxhmIGrcXmMQN9hHRxIrdK6Mw+7EA0JrmjOtuzl0ReAJw8gEZM7WBTQKjUqV9dZPLRU6U7HB564qcvitklwrqw==
Received: from PH8PR05CA0011.namprd05.prod.outlook.com (2603:10b6:510:2cc::28)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 13:11:21 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::7a) by PH8PR05CA0011.outlook.office365.com
 (2603:10b6:510:2cc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 13:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Tue, 7 Jul 2026 13:11:20 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:02 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:10:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Boris Pismenny
	<borisp@nvidia.com>, Chris Mi <cmi@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Mark Bloch
	<mbloch@nvidia.com>, Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, Stanislav Fomichev <sdf.kernel@gmail.com>,
	"Tariq Toukan" <tariqt@nvidia.com>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>
Subject: [PATCH net-next 08/15] net/mlx5e: psp: Rename and consolidate steering functions
Date: Tue, 7 Jul 2026 16:08:51 +0300
Message-ID: <20260707130858.969928-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260707130858.969928-1-tariqt@nvidia.com>
References: <20260707130858.969928-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|CH3PR12MB9252:EE_
X-MS-Office365-Filtering-Correlation-Id: adca6bd4-35e4-4374-c150-08dedc293cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|82310400026|36860700016|18002099003|22082099003|11063799006|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	kuF3FxclYzs+XHq7soJysQWojhNgKuDT6ZT6tP1NDyDsXMl3v9U5PXLSFtLAG4aRwPDerDrwkJpui8aE2b9yzlawoogzCZEB6d23OZjiKs6wfDprBTxzEq+9fHoVzlOlas2zCvjfFMG7Yo8ynh9/T7w7MLS2VDMoR3Zh/L1yJA/opeEBWf21HTLyjZ/kWuRVZxLd3RzUjV1m0R2oji+bRQnyT8rxqqaYRDVDowFMZtzRLi3FdEfe8uoZGB+U0hoWwytgkOoNzWoB4E4LQLX6RdpMyGBqLdva8Wiexy1vRGR5ROi0AobExWdOsLaInYTnMLM5Jz/zqtVoxq1Fae4m9UAPRblEPGSdHUHMwbqwaxUtp+Da+jjnM6quvW2FUqYkzhQQlaXkJGyCm8fkNRiNqS6sH/CHKkiXnlTgCe0wEaf6uAvuXUJLU9qdeIcIMXYu2sTwxExKOGPyOLtqlDMXKMZvbp3QFGBKgEUWeGyC+Ow+Q9zmng4HSA7hQNBoY0hHCHOoRXcZl89yy8HcpDL4fT5KVC9/NE5h1r2Lrasml1GE8IQgZFU1Hqj+V96YkwAO3ilDPhIh14r/5+3ULZ4B2LhedtYOUwv0gzEcsYdvFTHSlNm89YiIkyrfkKFnHEyvkVRp6GGZl2+7+1htTgC5jgo9ctIndYNtIYzFuvgspRBodeHjDhpa9JPyRgXwNRHfJjE6vddUOTLrQeUVfcWPuQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gprBvr5rVeTjQKdDjQe60hyUPWfCQ+Og1KBkekK20ngAFg7td3SwYkJTWpDG8husimn/Nyfn5pDFT3WPBiRFnQHWfCiTWassXOXU20YNmIAif/+p7I79pFYbYa+HzxLwz5gquslAag05M4m0n5SuM15NutkAtkWTQc1+H7CL/bTzrONtPq8ownV54hktfa/9xvBDwMvk0mjoVfD//FG6T3RoBdwWXxMVDbRdAsfN/Tr+zNXHVq+H0Hk7I2aXEQY62gGOqwhLMOPbFm9qKRbgRrEJuZYccoDCpzKSt87CvxIwLvZsLGLEZMVHbIRaQeO2j899n/UtnVGjfzEtoYPo+zYpKcZEYRRJiozivGsc62bvG5qXuwoKwGveWdSEu2SmgaYlBOebVlsoWZG7e/Hn4jjy6nCH3IDDRVJi2rCZheu2am0685FHczhF2zAZVRF+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:11:20.5584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adca6bd4-35e4-4374-c150-08dedc293cdb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22827-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,nvidia.com,gmail.com,kernel.org,vger.kernel.org,fomichev.me];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCD2B71BC2B

From: Cosmin Ratiu <cratiu@nvidia.com>

There are multiple naming inconsistencies and the code is fragmented and
hard to follow.
For example, the PSP TX steering structure is named 'mlx5e_psp_tx', but
its RX counterpart is 'mlx5e_accel_fs_psp' and its protocol
instantiation 'mlx5e_accel_fs_psp_prot', neither of which make it clear
they relate to RX.

This commit renames things to be more consistent, realigns declarations
to abide by the xmas tree rule, and merges some functions to reduce
fragmentation. Renamed:
mlx5e_accel_fs_psp -> mlx5e_psp_rx
mlx5e_accel_fs_psp_prot -> mlx5e_psp_rx_decrypt_table
fs_prot -> decrypt
accel_psp -> rx_fs
mlx5e_psp_rx_err -> mlx5e_psp_rx_check_table
mlx5e_psp_tx -> mlx5e_psp_tx_table
def_rule -> rule

Also renamed many functions with names of the form
accel_psp_fs_A_B_C_..._verb, with A->B->C->... following a
general->specific hierarchy. Full list:
accel_psp_fs_rx_err_destroy_ft -> accel_psp_fs_rx_check_ft_destroy
accel_psp_fs_rx_err_create_ft -> accel_psp_fs_rx_check_ft_create
accel_psp_fs_rx_fs_destroy -> accel_psp_fs_rx_decrypt_ft_destroy
accel_psp_fs_rx_create_ft -> accel_psp_fs_rx_decrypt_ft_create
accel_psp_fs_tx_create_ft_table -> accel_psp_fs_tx_ft_create
accel_psp_fs_tx_destroy -> accel_psp_fs_tx_ft_destroy
accel_psp_fs_{init,cleanup}_{rx,tx} ->
accel_psp_fs_{rx,tx}_{init,cleanup}

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 252 +++++++++---------
 1 file changed, 131 insertions(+), 121 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 534dba678761..c83d62724ff7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -21,7 +21,7 @@ enum accel_psp_syndrome {
 	PSP_BAD_TRAILER,
 };
 
-struct mlx5e_psp_tx {
+struct mlx5e_psp_tx_table {
 	struct mlx5_flow_namespace *ns;
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *fg;
@@ -29,7 +29,7 @@ struct mlx5e_psp_tx {
 	struct mlx5_fc *tx_counter;
 };
 
-struct mlx5e_psp_rx_err {
+struct mlx5e_psp_rx_check_table {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_handle *auth_fail_rule;
@@ -37,18 +37,18 @@ struct mlx5e_psp_rx_err {
 	struct mlx5_flow_handle *bad_rule;
 };
 
-struct mlx5e_accel_fs_psp_prot {
+struct mlx5e_psp_rx_decrypt_table {
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *miss_group;
 	struct mlx5_flow_handle *miss_rule;
 	struct mlx5_modify_hdr *rx_modify_hdr;
 	struct mlx5_flow_destination default_dest;
-	struct mlx5e_psp_rx_err rx_err;
-	struct mlx5_flow_handle *def_rule;
+	struct mlx5e_psp_rx_check_table check;
+	struct mlx5_flow_handle *rule;
 };
 
-struct mlx5e_accel_fs_psp {
-	struct mlx5e_accel_fs_psp_prot fs_prot[ACCEL_FS_PSP_NUM_TYPES];
+struct mlx5e_psp_rx {
+	struct mlx5e_psp_rx_decrypt_table decrypt[ACCEL_FS_PSP_NUM_TYPES];
 	struct mlx5_fc *rx_counter;
 	struct mlx5_fc *rx_auth_fail_counter;
 	struct mlx5_fc *rx_err_counter;
@@ -57,10 +57,10 @@ struct mlx5e_accel_fs_psp {
 
 struct mlx5e_psp_fs {
 	struct mlx5_core_dev *mdev;
-	struct mlx5e_psp_tx *tx_fs;
+	struct mlx5e_psp_tx_table *tx_fs;
 	/* Rx manage */
 	struct mlx5e_flow_steering *fs;
-	struct mlx5e_accel_fs_psp *rx_fs;
+	struct mlx5e_psp_rx *rx_fs;
 };
 
 /* PSP RX flow steering */
@@ -157,14 +157,15 @@ static void accel_psp_fs_destroy_counter(struct mlx5_core_dev *dev,
 	}
 }
 
-static void accel_psp_fs_rx_err_destroy_ft(struct mlx5e_psp_fs *fs,
-					   struct mlx5e_psp_rx_err *rx_err)
+static
+void accel_psp_fs_rx_check_ft_destroy(struct mlx5e_psp_fs *fs,
+				      struct mlx5e_psp_rx_check_table *check)
 {
-	accel_psp_fs_del_flow_rule(&rx_err->bad_rule);
-	accel_psp_fs_del_flow_rule(&rx_err->err_rule);
-	accel_psp_fs_del_flow_rule(&rx_err->auth_fail_rule);
-	accel_psp_fs_del_flow_rule(&rx_err->rule);
-	accel_psp_fs_destroy_ft(&rx_err->ft);
+	accel_psp_fs_del_flow_rule(&check->bad_rule);
+	accel_psp_fs_del_flow_rule(&check->err_rule);
+	accel_psp_fs_del_flow_rule(&check->auth_fail_rule);
+	accel_psp_fs_del_flow_rule(&check->rule);
+	accel_psp_fs_destroy_ft(&check->ft);
 }
 
 static void accel_psp_setup_syndrome_match(struct mlx5_flow_spec *spec,
@@ -201,9 +202,9 @@ static int accel_psp_add_drop_rule(struct mlx5_flow_table *ft,
 }
 
 static
-int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
-				  struct mlx5e_accel_fs_psp_prot *fs_prot,
-				  struct mlx5e_psp_rx_err *rx_err)
+int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
+				    struct mlx5e_psp_rx_decrypt_table *decrypt,
+				    struct mlx5e_psp_rx_check_table *check)
 {
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
@@ -221,10 +222,10 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	ft_attr.autogroup.max_num_groups = 2;
 	ft_attr.level = MLX5E_ACCEL_FS_ESP_FT_ERR_LEVEL;
 	ft_attr.prio = MLX5E_NIC_PRIO;
-	err = accel_psp_fs_create_ft(fs, &ft_attr, &rx_err->ft);
+	err = accel_psp_fs_create_ft(fs, &ft_attr, &check->ft);
 	if (err) {
 		mlx5_core_err(fs->mdev,
-			      "fail to create psp rx inline ft err=%d\n", err);
+			      "fail to create psp rx check ft err=%d\n", err);
 		goto out_err;
 	}
 
@@ -232,27 +233,28 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	/* create fte */
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest[0].type = fs_prot->default_dest.type;
-	dest[0].ft = fs_prot->default_dest.ft;
+	dest[0].type = decrypt->default_dest.type;
+	dest[0].ft = decrypt->default_dest.ft;
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 	dest[1].counter = fs->rx_fs->rx_counter;
-	fte = mlx5_add_flow_rules(rx_err->ft, spec, &flow_act, dest, 2);
+	fte = mlx5_add_flow_rules(check->ft, spec, &flow_act, dest, 2);
 	if (IS_ERR(fte)) {
 		err = PTR_ERR(fte);
-		mlx5_core_err(mdev, "fail to add psp rx err rule err=%d\n",
+		mlx5_core_err(mdev, "fail to add psp rx check ok rule err=%d\n",
 			      err);
 		goto out_err;
 	}
-	rx_err->rule = fte;
+	check->rule = fte;
 
 	/* add auth fail drop rule */
 	memset(spec, 0, sizeof(*spec));
 	accel_psp_setup_syndrome_match(spec, PSP_ICV_FAIL);
-	err = accel_psp_add_drop_rule(rx_err->ft, spec,
+	err = accel_psp_add_drop_rule(check->ft, spec,
 				      fs->rx_fs->rx_auth_fail_counter,
-				      &rx_err->auth_fail_rule);
+				      &check->auth_fail_rule);
 	if (err) {
-		mlx5_core_err(mdev, "fail to add psp rx auth fail drop rule err=%d\n",
+		mlx5_core_err(mdev,
+			      "fail to add psp rx check auth fail drop rule err=%d\n",
 			      err);
 		goto out_err;
 	}
@@ -260,22 +262,24 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	/* add framing drop rule */
 	memset(spec, 0, sizeof(*spec));
 	accel_psp_setup_syndrome_match(spec, PSP_BAD_TRAILER);
-	err = accel_psp_add_drop_rule(rx_err->ft, spec,
+	err = accel_psp_add_drop_rule(check->ft, spec,
 				      fs->rx_fs->rx_err_counter,
-				      &rx_err->err_rule);
+				      &check->err_rule);
 	if (err) {
-		mlx5_core_err(mdev, "fail to add psp rx framing drop rule err=%d\n",
+		mlx5_core_err(mdev,
+			      "fail to add psp rx check framing drop rule err=%d\n",
 			      err);
 		goto out_err;
 	}
 
 	/* add misc. errors drop rule */
 	memset(spec, 0, sizeof(*spec));
-	err = accel_psp_add_drop_rule(rx_err->ft, spec,
+	err = accel_psp_add_drop_rule(check->ft, spec,
 				      fs->rx_fs->rx_bad_counter,
-				      &rx_err->bad_rule);
+				      &check->bad_rule);
 	if (err) {
-		mlx5_core_err(mdev, "fail to add psp rx misc. err drop rule err=%d\n",
+		mlx5_core_err(mdev,
+			      "fail to add psp rx check misc. err drop rule err=%d\n",
 			      err);
 		goto out_err;
 	}
@@ -283,24 +287,25 @@ int accel_psp_fs_rx_err_create_ft(struct mlx5e_psp_fs *fs,
 	goto out_spec;
 
 out_err:
-	accel_psp_fs_rx_err_destroy_ft(fs, rx_err);
+	accel_psp_fs_rx_check_ft_destroy(fs, check);
 out_spec:
 	kfree(spec);
 	return err;
 }
 
 
-static void accel_psp_fs_rx_fs_destroy(struct mlx5e_psp_fs *fs,
-				       struct mlx5e_accel_fs_psp_prot *fs_prot)
+static void
+accel_psp_fs_rx_decrypt_ft_destroy(struct mlx5e_psp_fs *fs,
+				   struct mlx5e_psp_rx_decrypt_table *decrypt)
 {
-	accel_psp_fs_del_flow_rule(&fs_prot->def_rule);
-	if (fs_prot->rx_modify_hdr) {
-		mlx5_modify_header_dealloc(fs->mdev, fs_prot->rx_modify_hdr);
-		fs_prot->rx_modify_hdr = NULL;
+	accel_psp_fs_del_flow_rule(&decrypt->rule);
+	if (decrypt->rx_modify_hdr) {
+		mlx5_modify_header_dealloc(fs->mdev, decrypt->rx_modify_hdr);
+		decrypt->rx_modify_hdr = NULL;
 	}
-	accel_psp_fs_del_flow_rule(&fs_prot->miss_rule);
-	accel_psp_fs_destroy_flow_group(&fs_prot->miss_group);
-	accel_psp_fs_destroy_ft(&fs_prot->ft);
+	accel_psp_fs_del_flow_rule(&decrypt->miss_rule);
+	accel_psp_fs_destroy_flow_group(&decrypt->miss_group);
+	accel_psp_fs_destroy_ft(&decrypt->ft);
 }
 
 static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
@@ -312,8 +317,9 @@ static void setup_fte_udp_psp(struct mlx5_flow_spec *spec, u16 udp_port)
 	MLX5_SET(fte_match_set_lyr_2_4, spec->match_value, ip_protocol, IPPROTO_UDP);
 }
 
-static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
-				     struct mlx5e_accel_fs_psp_prot *fs_prot)
+static int
+accel_psp_fs_rx_decrypt_ft_create(struct mlx5e_psp_fs *fs,
+				  struct mlx5e_psp_rx_decrypt_table *decrypt)
 {
 	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
 	struct mlx5_modify_hdr *modify_hdr = NULL;
@@ -335,30 +341,36 @@ static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
 	ft_attr.autogroup.num_reserved_entries = 1;
 	ft_attr.autogroup.max_num_groups = 1;
 	ft_attr.prio = MLX5E_NIC_PRIO;
-	err = accel_psp_fs_create_ft(fs, &ft_attr, &fs_prot->ft);
+	err = accel_psp_fs_create_ft(fs, &ft_attr, &decrypt->ft);
 	if (err) {
-		mlx5_core_err(mdev, "fail to create psp rx ft err=%d\n", err);
+		mlx5_core_err(mdev, "fail to create psp rx decrypt ft err=%d\n",
+			      err);
 		goto out_err;
 	}
 
 	/* Create miss_group */
-	err = accel_psp_fs_create_miss_group(fs_prot->ft, &fs_prot->miss_group);
+	err = accel_psp_fs_create_miss_group(decrypt->ft, &decrypt->miss_group);
 	if (err) {
-		mlx5_core_err(mdev, "fail to create psp rx miss_group err=%d\n", err);
+		mlx5_core_err(mdev,
+			      "fail to create psp rx decrypt miss_group err=%d\n",
+			      err);
 		goto out_err;
 	}
 
 	/* Create miss rule */
-	rule = mlx5_add_flow_rules(fs_prot->ft, spec, &flow_act,
-				   &fs_prot->default_dest, 1);
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	rule = mlx5_add_flow_rules(decrypt->ft, spec, &flow_act,
+				   &decrypt->default_dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		mlx5_core_err(mdev, "fail to create psp rx miss_rule err=%d\n", err);
+		mlx5_core_err(mdev,
+			      "fail to create psp rx decrypt miss_rule err=%d\n",
+			      err);
 		goto out_err;
 	}
-	fs_prot->miss_rule = rule;
+	decrypt->miss_rule = rule;
 
-	/* Add default Rx psp rule */
+	/* Add PSP RX decrypt rule */
 	setup_fte_udp_psp(spec, PSP_DEFAULT_UDP_PORT);
 	flow_act.crypto.type = MLX5_FLOW_CONTEXT_ENCRYPT_DECRYPT_TYPE_PSP;
 	/* Set bit[31, 30] PSP marker */
@@ -376,46 +388,44 @@ static int accel_psp_fs_rx_create_ft(struct mlx5e_psp_fs *fs,
 		modify_hdr = NULL;
 		goto out_err;
 	}
-	fs_prot->rx_modify_hdr = modify_hdr;
+	decrypt->rx_modify_hdr = modify_hdr;
 
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_CRYPTO_DECRYPT |
 			  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
 	flow_act.modify_hdr = modify_hdr;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest.ft = fs_prot->rx_err.ft;
-	rule = mlx5_add_flow_rules(fs_prot->ft, spec, &flow_act, &dest, 1);
+	dest.ft = decrypt->check.ft;
+	rule = mlx5_add_flow_rules(decrypt->ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
-		mlx5_core_err(mdev,
-			      "fail to add psp rule Rx decryption, err=%d, flow_act.action = %#04X\n",
-			      err, flow_act.action);
+		mlx5_core_err(mdev, "fail to add psp rx decrypt rule, err=%d\n",
+			      err);
 		goto out_err;
 	}
 
-	fs_prot->def_rule = rule;
+	decrypt->rule = rule;
 	goto out_spec;
 
 out_err:
-	accel_psp_fs_rx_fs_destroy(fs, fs_prot);
+	accel_psp_fs_rx_decrypt_ft_destroy(fs, decrypt);
 out_spec:
 	kvfree(spec);
 	return err;
 }
 
-static int accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
+static int accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs,
+				   enum accel_fs_psp_type type)
 {
-	struct mlx5e_accel_fs_psp_prot *fs_prot;
-	struct mlx5e_accel_fs_psp *accel_psp;
-
-	accel_psp = fs->rx_fs;
+	struct mlx5e_psp_rx_decrypt_table *decrypt;
+	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
 
 	/* The netdev unreg already happened, so all offloaded rule are already removed */
-	fs_prot = &accel_psp->fs_prot[type];
+	decrypt = &rx_fs->decrypt[type];
 
-	accel_psp_fs_rx_fs_destroy(fs, fs_prot);
+	accel_psp_fs_rx_decrypt_ft_destroy(fs, decrypt);
 
-	accel_psp_fs_rx_err_destroy_ft(fs, &fs_prot->rx_err);
+	accel_psp_fs_rx_check_ft_destroy(fs, &decrypt->check);
 
 	return 0;
 }
@@ -423,43 +433,45 @@ static int accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs, enum accel_fs_psp_ty
 static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs, enum accel_fs_psp_type type)
 {
 	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(fs->fs, false);
-	struct mlx5e_accel_fs_psp_prot *fs_prot;
-	struct mlx5e_accel_fs_psp *accel_psp;
+	struct mlx5e_psp_rx_decrypt_table *decrypt;
+	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
 	int err;
 
-	accel_psp = fs->rx_fs;
-	fs_prot = &accel_psp->fs_prot[type];
+	decrypt = &rx_fs->decrypt[type];
+	decrypt->default_dest = mlx5_ttc_get_default_dest(ttc,
+							  fs_psp2tt(type));
 
-	fs_prot->default_dest = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(type));
-
-	err = accel_psp_fs_rx_err_create_ft(fs, fs_prot, &fs_prot->rx_err);
+	err = accel_psp_fs_rx_check_ft_create(fs, decrypt, &decrypt->check);
 	if (err)
 		return err;
 
-	err = accel_psp_fs_rx_create_ft(fs, fs_prot);
+	err = accel_psp_fs_rx_decrypt_ft_create(fs, decrypt);
 	if (err)
-		accel_psp_fs_rx_err_destroy_ft(fs, &fs_prot->rx_err);
+		goto out_err_ft;
+
+	return 0;
 
+out_err_ft:
+	accel_psp_fs_rx_check_ft_destroy(fs, &decrypt->check);
 	return err;
 }
 
-static void accel_psp_fs_cleanup_rx(struct mlx5e_psp_fs *fs)
+static void accel_psp_fs_rx_cleanup(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_accel_fs_psp *accel_psp = fs->rx_fs;
+	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
 
-	if (!accel_psp)
+	if (!rx_fs)
 		return;
 
-	accel_psp_fs_destroy_counter(fs->mdev, &accel_psp->rx_bad_counter);
-	accel_psp_fs_destroy_counter(fs->mdev, &accel_psp->rx_err_counter);
-	accel_psp_fs_destroy_counter(fs->mdev,
-				     &accel_psp->rx_auth_fail_counter);
-	accel_psp_fs_destroy_counter(fs->mdev, &accel_psp->rx_counter);
-	kfree(accel_psp);
+	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_bad_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_err_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_auth_fail_counter);
+	accel_psp_fs_destroy_counter(fs->mdev, &rx_fs->rx_counter);
+	kfree(rx_fs);
 	fs->rx_fs = NULL;
 }
 
-static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
+static int accel_psp_fs_rx_init(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5_core_dev *mdev = fs->mdev;
 	int err;
@@ -504,7 +516,7 @@ static int accel_psp_fs_init_rx(struct mlx5e_psp_fs *fs)
 	return 0;
 
 out_err:
-	accel_psp_fs_cleanup_rx(fs);
+	accel_psp_fs_rx_cleanup(fs);
 	return err;
 }
 
@@ -541,7 +553,7 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 	ttc = mlx5e_fs_get_ttc(fs->fs, false);
 
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
-		struct mlx5e_accel_fs_psp_prot *fs_prot;
+		struct mlx5e_psp_rx_decrypt_table *decrypt;
 		struct mlx5_flow_destination dest = {};
 
 		/* create FT */
@@ -551,8 +563,8 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 
 		/* connect */
 		dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-		fs_prot = &fs->rx_fs->fs_prot[i];
-		dest.ft = fs_prot->ft;
+		decrypt = &fs->rx_fs->decrypt[i];
+		dest.ft = decrypt->ft;
 		mlx5_ttc_fwd_dest(ttc, fs_psp2tt(i), &dest);
 	}
 
@@ -567,17 +579,17 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 	return err;
 }
 
-static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
+static int accel_psp_fs_tx_ft_create(struct mlx5e_psp_fs *fs)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
 	struct mlx5_flow_table_attr ft_attr = {};
 	struct mlx5_flow_destination dest = {};
 	struct mlx5_core_dev *mdev = fs->mdev;
 	struct mlx5_flow_act flow_act = {};
+	struct mlx5e_psp_tx_table *tx_fs;
 	u32 *in, *mc, *outer_headers_c;
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
-	struct mlx5e_psp_tx *tx_fs;
 	struct mlx5_flow_table *ft;
 	struct mlx5_flow_group *fg;
 	int err = 0;
@@ -646,16 +658,16 @@ static int accel_psp_fs_tx_create_ft_table(struct mlx5e_psp_fs *fs)
 	return err;
 }
 
-static void accel_psp_fs_tx_destroy(struct mlx5e_psp_tx *tx_fs)
+static void accel_psp_fs_tx_ft_destroy(struct mlx5e_psp_tx_table *tx_fs)
 {
 	accel_psp_fs_del_flow_rule(&tx_fs->rule);
 	accel_psp_fs_destroy_flow_group(&tx_fs->fg);
 	accel_psp_fs_destroy_ft(&tx_fs->ft);
 }
 
-static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
+static void accel_psp_fs_tx_cleanup(struct mlx5e_psp_fs *fs)
 {
-	struct mlx5e_psp_tx *tx_fs = fs->tx_fs;
+	struct mlx5e_psp_tx_table *tx_fs = fs->tx_fs;
 
 	if (!tx_fs)
 		return;
@@ -665,11 +677,11 @@ static void accel_psp_fs_cleanup_tx(struct mlx5e_psp_fs *fs)
 	fs->tx_fs = NULL;
 }
 
-static int accel_psp_fs_init_tx(struct mlx5e_psp_fs *fs)
+static int accel_psp_fs_tx_init(struct mlx5e_psp_fs *fs)
 {
 	struct mlx5_core_dev *mdev = fs->mdev;
+	struct mlx5e_psp_tx_table *tx_fs;
 	struct mlx5_flow_namespace *ns;
-	struct mlx5e_psp_tx *tx_fs;
 	int err;
 
 	ns = mlx5_get_flow_namespace(mdev, MLX5_FLOW_NAMESPACE_EGRESS_IPSEC);
@@ -697,32 +709,30 @@ static void
 mlx5e_accel_psp_fs_get_stats_fill(struct mlx5e_priv *priv,
 				  struct mlx5e_psp_stats *stats)
 {
-	struct mlx5e_psp_tx *tx_fs = priv->psp->fs->tx_fs;
+	struct mlx5e_psp_tx_table *tx_fs = priv->psp->fs->tx_fs;
+	struct mlx5e_psp_rx *rx_fs = priv->psp->fs->rx_fs;
 	struct mlx5_core_dev *mdev = priv->mdev;
-	struct mlx5e_accel_fs_psp *accel_psp;
-
-	accel_psp = (struct mlx5e_accel_fs_psp *)priv->psp->fs->rx_fs;
 
 	if (tx_fs->tx_counter)
 		mlx5_fc_query(mdev, tx_fs->tx_counter, &stats->psp_tx_pkts,
 			      &stats->psp_tx_bytes);
 
-	if (accel_psp->rx_counter)
-		mlx5_fc_query(mdev, accel_psp->rx_counter, &stats->psp_rx_pkts,
+	if (rx_fs->rx_counter)
+		mlx5_fc_query(mdev, rx_fs->rx_counter, &stats->psp_rx_pkts,
 			      &stats->psp_rx_bytes);
 
-	if (accel_psp->rx_auth_fail_counter)
-		mlx5_fc_query(mdev, accel_psp->rx_auth_fail_counter,
+	if (rx_fs->rx_auth_fail_counter)
+		mlx5_fc_query(mdev, rx_fs->rx_auth_fail_counter,
 			      &stats->psp_rx_pkts_auth_fail,
 			      &stats->psp_rx_bytes_auth_fail);
 
-	if (accel_psp->rx_err_counter)
-		mlx5_fc_query(mdev, accel_psp->rx_err_counter,
+	if (rx_fs->rx_err_counter)
+		mlx5_fc_query(mdev, rx_fs->rx_err_counter,
 			      &stats->psp_rx_pkts_frame_err,
 			      &stats->psp_rx_bytes_frame_err);
 
-	if (accel_psp->rx_bad_counter)
-		mlx5_fc_query(mdev, accel_psp->rx_bad_counter,
+	if (rx_fs->rx_bad_counter)
+		mlx5_fc_query(mdev, rx_fs->rx_bad_counter,
 			      &stats->psp_rx_pkts_drop,
 			      &stats->psp_rx_bytes_drop);
 }
@@ -732,7 +742,7 @@ void mlx5_accel_psp_fs_cleanup_tx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return;
 
-	accel_psp_fs_tx_destroy(priv->psp->fs->tx_fs);
+	accel_psp_fs_tx_ft_destroy(priv->psp->fs->tx_fs);
 }
 
 int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
@@ -740,13 +750,13 @@ int mlx5_accel_psp_fs_init_tx_tables(struct mlx5e_priv *priv)
 	if (!priv->psp)
 		return 0;
 
-	return accel_psp_fs_tx_create_ft_table(priv->psp->fs);
+	return accel_psp_fs_tx_ft_create(priv->psp->fs);
 }
 
 static void mlx5e_accel_psp_fs_cleanup(struct mlx5e_psp_fs *fs)
 {
-	accel_psp_fs_cleanup_rx(fs);
-	accel_psp_fs_cleanup_tx(fs);
+	accel_psp_fs_rx_cleanup(fs);
+	accel_psp_fs_tx_cleanup(fs);
 	kfree(fs);
 }
 
@@ -760,19 +770,19 @@ static struct mlx5e_psp_fs *mlx5e_accel_psp_fs_init(struct mlx5e_priv *priv)
 		return ERR_PTR(-ENOMEM);
 
 	fs->mdev = priv->mdev;
-	err = accel_psp_fs_init_tx(fs);
+	err = accel_psp_fs_tx_init(fs);
 	if (err)
 		goto err_tx;
 
 	fs->fs = priv->fs;
-	err = accel_psp_fs_init_rx(fs);
+	err = accel_psp_fs_rx_init(fs);
 	if (err)
 		goto err_rx;
 
 	return fs;
 
 err_rx:
-	accel_psp_fs_cleanup_tx(fs);
+	accel_psp_fs_tx_cleanup(fs);
 err_tx:
 	kfree(fs);
 	return ERR_PTR(err);
-- 
2.44.0


