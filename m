Return-Path: <linux-rdma+bounces-22830-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qf2gAsH8TGpPtAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22830-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:18:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0445871BD0A
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 15:18:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=d+zs3K0Z;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22830-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22830-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 374FD305F535
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 13:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D883DD867;
	Tue,  7 Jul 2026 13:11:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A3941611D;
	Tue,  7 Jul 2026 13:11:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429912; cv=fail; b=FqQbr/kz8yPrr6mv/Tv/N15SF2Q0uOQ6ZV07EPUXeIPg27h9h5/4rvoZFQT97fToHmCLbgLwPoSXf0M1Cv6Ua7vw0ohVjsgb0WgpZEbcYmEUId5PVm/ZuiBSdZ66Zvdu5R8r/40Y2feDnUIqfSmfNd2xmPbwLNIIS/FIeIc8hKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429912; c=relaxed/simple;
	bh=zlrMstoW5U2EMMrWexkeksj+8h0BzR5KfQN4UjTJMX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A1x7bwTdQQDE1G2RVkWPb0NpCjKUl+AR9FMcwR0vyU+ccmDuSHxDoA1o3hixZlYV1khH3qwC9GGB6WuuVgw2LIv/2uvfkvbpjO6mtGh5Lt0h4GdGGm9RIijIaP0Gav6ZIz/62VIN9/TIcYblkrBaMi4Inu6Yg6pyOFpPSFDkQY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d+zs3K0Z; arc=fail smtp.client-ip=52.101.48.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghJIPdzi1GHjIzEHZGLmXbPR+Pc6anyqq1xNcRuXLT9a8HDzf6IpNCqoacOgWTmCZe8ykU7Di9hn1x/IOIl1Yot/gfwHleHswlodFPkGATM4sOXT88Tdd7b6MqtYiXKFPM33kOXFRpNe+uvVsi+VmzYpD+mDxr1V7YeH833LdZwAhU/1slGV/ETcGBkgQ4gpIYbULHMH9Y4KXz1w8kdZ8oDOwZBfcqQYSLvIOfWQbPZM2XLEpFcg4EKhUTJwB276oyLuRhItHGdd+Y3splSN+b+/F8XnhrcGMeh7MueqpmDu4l0RuNvpc3rrnf2GkMH4UqoCKPGupOwlor+EswG8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rn1leg2UaWejrzR+WSQKFjfYj9W4hmlt4QpT/v0wbYk=;
 b=rmhVwz6ZkD+RkbuuRppix9LDqteAgM1FVjUcg1NdOdXdkkQzmfAI64b85jVu9Zp1C372JPK1B3Sowf6DGAxh3zspYvy6fMqtYMwxDl1hDkKH/SmN61DknNGVHuQPuF7Ztf4srlbwEttTXv6Pv+wm16UuahoHBDthDNK8npwrqLRnpdZl7c8zjw9MEuDWIuH9apzwrZsOjqEvzEIQHr4YBHgp9YKyWWns2HC4Jh/exZ0HlraiLXkkxbHJ4ZFFk5oAkqTPwUshbj0E8jAC22hVGVT5hCtpEyIy4uAwhDk6HybszSYXT+m3mrHmFHe8mBqBoaPl/YLJupHy+jEU6AGJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn1leg2UaWejrzR+WSQKFjfYj9W4hmlt4QpT/v0wbYk=;
 b=d+zs3K0Z7zXgXQ8Ldiek4wPgXx5c7kEPDtkcPD3QX3ttxe05rmhmnGmgNHxHtD/7gLD1AOYFf/LiiWYaFKwLHJ2rmr2rhVwa8g8n01RbvYLRGVz8IDzktkMZUMkW/FGp1aqWef+R0bFUc9/BZzbh3Io0ZZ4BOeLSpVVoJBsRl86QEPcUBoUN5VQ6pGkExedjkTt9DouJZXxIZR3ki71unfl8dJHwB5s13S/GBDvgLsXKPE8BK9G9plhbhiitKlLpn1YpV/QtzmaoRx19Ua1rzLOXcvVbcWHidX9XpCXmYvc0/TecM75VEi17FidDtCC0tinif1RTpriFh4BckqTtHQ==
Received: from MN0PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:530::13)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Tue, 7 Jul
 2026 13:11:48 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::a0) by MN0PR02CA0018.outlook.office365.com
 (2603:10b6:208:530::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 13:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 13:11:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 06:11:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 7 Jul
 2026 06:11:17 -0700
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
Subject: [PATCH net-next 11/15] net/mlx5e: psp: Use a single rx_check table
Date: Tue, 7 Jul 2026 16:08:54 +0300
Message-ID: <20260707130858.969928-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1e602f-493b-46a0-8ff1-08dedc294ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	J7v9Mr0LYS+cCrqd+LnjNoRYxGw96tB/NCO7OANUsqyJYVwfc0apuzBO6dxLOkeHzg6/J+2xL2n618Bh4PhuxZD3xRwGbNI/LYWDzzGJBn/LjBeuc4XmSoBYGSAE1UpaIUNuQSkS9l1xOUVtfd0EGGZKOcr4Xm5VB1iSeGoUewTPlGgujPUvLKLehx9HoEGc9D0WDcDULZqYxa+kcBs8YuvgyELG8e3EAN0cn8tzzC/HYJ0T74adLOCNc7ecvKojFkcri7bhHcmpzJlVPnFcHBnMshWWvhL0xwBaGmzXhOc5ve65/t4iSLsAsd9GH12ItHa1mr54KilAluK0C4YmkiI+HY65gp9CRyi0SccB+NilfAJGTSNsV6JF1thcv4PGyABXtJZpU0Vn7kq6LEpDopwnhXuuzzxz5XkL1vNQ3Fzcng7nJuEJIHQikObl+2lBwBFm4EvddliwrIA8FW1EZB/TVf8DpXkaioiZ3nx84d1ojeo2HgsvKyPHWz1iy4DpNnE/jzaxAv3iznIRFqfh2IsW/Mr3a8o55fQoGbCz+2IXjG8Rujv6S41D0CkRTAk2cb+XCBwtzeYaft/Ta17AhUzADx4uhx/5NKAH6cwsIoMEzW4n7oMceNGpPqmTMeYlQ34w2Fdc7wvfofklFsZApGXgNymTcxq+pD9GepmA1iRPjq18RBRaRwqgI0a+/ojDi6S1IB3qZUndhGY/IxgZRA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TqBCh5qT3fgCt5KNKMqFlYeJ216nJO276CElOiAbgNio1QcXyhF6XNtcV5hrLTdTDIPop21TBTgXTT7j2kbV7pWQTF3lqju+a8/M3sNS3Lyg0F0RYAKjAoOVP7bAfF3VnudeU9Ayrgv2h6WmEyl2Qao2OE364M08KX6wOeJb9qv1wC4OnvB0gnq1SN9wvKNtQYFbyFmPBpwlci2Qmd5m/Ed53BMd8F5EQqeJIGgDienFkEBZfcvV47TMv14fGgLuYU3/hXXB7+S4xxl3vlBiDKrvmSe44zDqEky+Qkoq3DS7ZkFCY1/Y24dSCDVcnRg1PUO0uQojiAg3uyWB++KzI1ldx4S/irHxy0WAVes2Ym4IBbFlATx2d8jE6aYQNQNEW1CnIOt4UFPVFs+z8i5BKIu39W05akhrXu0g/Jete5uQMh2KC5JW4j5dnmRVwNu0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 13:11:47.3223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1e602f-493b-46a0-8ff1-08dedc294ce5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:aleksandr.loktionov@intel.com,m:borisp@nvidia.com,m:cmi@nvidia.com,m:cratiu@nvidia.com,m:daniel.zahka@gmail.com,m:dtatulea@nvidia.com,m:gal@nvidia.com,m:jacob.e.keller@intel.com,m:jianbol@nvidia.com,m:lkayal@nvidia.com,m:leon@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:raeds@nvidia.com,m:rrameshbabu@nvidia.com,m:saeedm@nvidia.com,m:sdf@fomichev.me,m:sdf.kernel@gmail.com,m:tariqt@nvidia.com,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22830-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0445871BD0A

From: Cosmin Ratiu <cratiu@nvidia.com>

PSP uses a check steering table per IP version, but the PSP rules are
IP-version agnostic, so there's no point duplicating these in HW.

This commit makes the rx check steering table independent of the IP
version, with the final table added in the previous patch responsible
for directing packets to the corresponding UDP TIRs (or the TTC table
itself for non-UDP traffic).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/psp.c         | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index c45241025b16..48bc59045dfe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -43,7 +43,6 @@ struct mlx5e_psp_rx_decrypt_table {
 	struct mlx5_flow_group *miss_group;
 	struct mlx5_flow_handle *miss_rule;
 	struct mlx5_modify_hdr *rx_modify_hdr;
-	struct mlx5e_psp_rx_check_table check;
 	struct mlx5_flow_handle *rule;
 };
 
@@ -69,6 +68,7 @@ struct mlx5e_psp_fs {
 	struct mlx5e_flow_steering *fs;
 	struct mlx5e_psp_rx *rx_fs;
 
+	struct mlx5e_psp_rx_check_table check;
 	struct mlx5e_psp_rx_table rx;
 };
 
@@ -267,8 +267,7 @@ static int accel_psp_fs_rx_ft_create(struct mlx5e_psp_fs *fs,
 }
 
 static
-void accel_psp_fs_rx_check_ft_destroy(struct mlx5e_psp_fs *fs,
-				      struct mlx5e_psp_rx_check_table *check)
+void accel_psp_fs_rx_check_ft_destroy(struct mlx5e_psp_rx_check_table *check)
 {
 	accel_psp_fs_del_flow_rule(&check->bad_rule);
 	accel_psp_fs_del_flow_rule(&check->err_rule);
@@ -402,13 +401,12 @@ int accel_psp_fs_rx_check_ft_create(struct mlx5e_psp_fs *fs,
 	goto out_spec;
 
 out_err:
-	accel_psp_fs_rx_check_ft_destroy(fs, check);
+	accel_psp_fs_rx_check_ft_destroy(check);
 out_spec:
 	kfree(spec);
 	return err;
 }
 
-
 static void
 accel_psp_fs_rx_decrypt_ft_destroy(struct mlx5e_psp_fs *fs,
 				   struct mlx5e_psp_rx_decrypt_table *decrypt)
@@ -511,7 +509,7 @@ accel_psp_fs_rx_decrypt_ft_create(struct mlx5e_psp_fs *fs,
 			  MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
 	flow_act.modify_hdr = modify_hdr;
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	dest.ft = decrypt->check.ft;
+	dest.ft = fs->check.ft;
 	rule = mlx5_add_flow_rules(decrypt->ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -541,8 +539,6 @@ static int accel_psp_fs_rx_destroy(struct mlx5e_psp_fs *fs,
 
 	accel_psp_fs_rx_decrypt_ft_destroy(fs, decrypt);
 
-	accel_psp_fs_rx_check_ft_destroy(fs, &decrypt->check);
-
 	return 0;
 }
 
@@ -552,24 +548,11 @@ static int accel_psp_fs_rx_create(struct mlx5e_psp_fs *fs, enum accel_fs_psp_typ
 	struct mlx5e_psp_rx_decrypt_table *decrypt;
 	struct mlx5e_psp_rx *rx_fs = fs->rx_fs;
 	struct mlx5_flow_destination dest = {};
-	int err;
 
 	decrypt = &rx_fs->decrypt[type];
 
-	err = accel_psp_fs_rx_check_ft_create(fs, &decrypt->check);
-	if (err)
-		return err;
-
 	dest = mlx5_ttc_get_default_dest(ttc, fs_psp2tt(type));
-	err = accel_psp_fs_rx_decrypt_ft_create(fs, decrypt, &dest);
-	if (err)
-		goto out_err_ft;
-
-	return 0;
-
-out_err_ft:
-	accel_psp_fs_rx_check_ft_destroy(fs, &decrypt->check);
-	return err;
+	return accel_psp_fs_rx_decrypt_ft_create(fs, decrypt, &dest);
 }
 
 static void accel_psp_fs_rx_cleanup(struct mlx5e_psp_fs *fs)
@@ -654,6 +637,7 @@ void mlx5_accel_psp_fs_cleanup_rx_tables(struct mlx5e_priv *priv)
 		/* remove FT */
 		accel_psp_fs_rx_destroy(fs, i);
 	}
+	accel_psp_fs_rx_check_ft_destroy(&fs->check);
 	accel_psp_fs_rx_ft_destroy(&priv->psp->fs->rx);
 }
 
@@ -673,6 +657,10 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 	if (err)
 		return err;
 
+	err = accel_psp_fs_rx_check_ft_create(fs, &fs->check);
+	if (err)
+		goto err_ft;
+
 	for (i = 0; i < ACCEL_FS_PSP_NUM_TYPES; i++) {
 		struct mlx5e_psp_rx_decrypt_table *decrypt;
 		struct mlx5_flow_destination dest = {};
@@ -696,6 +684,8 @@ int mlx5_accel_psp_fs_init_rx_tables(struct mlx5e_priv *priv)
 		mlx5_ttc_fwd_default_dest(ttc, fs_psp2tt(i));
 		accel_psp_fs_rx_destroy(fs, i);
 	}
+	accel_psp_fs_rx_check_ft_destroy(&fs->check);
+err_ft:
 	accel_psp_fs_rx_ft_destroy(&fs->rx);
 
 	return err;
-- 
2.44.0


