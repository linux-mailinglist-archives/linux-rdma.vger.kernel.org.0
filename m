Return-Path: <linux-rdma+bounces-20605-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IQ8G1bMBGpJPQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20605-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:09:10 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD0A5399CC
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 21:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0029130463AF
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3233AC0D7;
	Wed, 13 May 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NR1yEMSV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE13A963E;
	Wed, 13 May 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699034; cv=fail; b=l+meht8szYt6MHvtdm0CZjmaEKDsHW65P/FwPkhV0P4plxrcPzfSekHkUHjZyTmUy/R5O0YK9f3RCrwmayVYJ4zLWlyi43EAInhBM+Jmf7gOaRaECtZik+8I0WdIqpPlIaYZ8jcI75SqEA2lckLwcRHtzbhCOerb2xVBYDmLxbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699034; c=relaxed/simple;
	bh=D3oMZlK1N40EqRUmZUS1cneBmVtK4Tnj3063iJzBwwo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n+hIf551l8g9D4aqp7AQNy3UUtuzQbWrDWLkk73z/syHToLfCgnQ/MtN2blOXsaKvnmC79R3UbvaUZbIj/3Vs7xXvlNBslJzrJaYD3hOi3crEgCvtJwg2v+OVrGWLbkvG66G7dDg8xP0Il4mEEh9gWwu6dzqHbp4j176SU4Cam0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NR1yEMSV; arc=fail smtp.client-ip=52.101.56.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxD5CfffRP6nbBCSMmckUbVTaiDYMZ5prc7KbJU3v51SYgeP1sUl2OhHON9KBE3mWibpZeW4yzhs6h+/jC/hZi7lmb4voPcrHXT0J4CFftY6GyulE/NO/QWwvtmofJ1a+NhKbfeuTRejpLoev7Ujcj0SoWAoAngoWaYZVILXakTx7ROmaaOdaGS7bbV/+lSpvJGQMan56bmkos7Xmu8A+O3LGEyU7oBpH4rnz32VJLXCLDo3CP5hKAAgh1Qs24Nq5wJyhZ5f6ScUFsEAY+967M2mPmLXUGhvh1PmhA/HHie8H4aGOqGsSBhS68nC61nktkJJs/m81d51dBXY2TNqZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xS5enrqUYh0H6cthdMCNa0NgtYSuRAU4Q9Wyfyvfp7s=;
 b=Nx5wY9iudKPqeisqWmP2PwhyeAuZ8bqLDCxy0boOcNoYbbv5Mkz8cVM2mE9NBEb8FrkrQ9Tt3ypkeSW4GwApZ4Y+xKM3YU/42TuYtv9PatkbvXVrOCpVYYmlfZbIDDhgw0iCYvC1IeoBxh+IzUZDm7u8cQBYBEJp3v1X55H4sZ832apkivkd0HdbuzL6Bl+ungdIXkgYkR0y1nZZ7qqx5CwdLG/Iu/H9c0RK9Ypwiv5DTKAP5TAs/PAFN8CNHdtkk0f2CTLWiXUAahrp4Vh1+W5P10+mgtrS21UjQFlNK5KurTeSZtWalAN1sjgJ1onAlqzl0pZgaywXbo0koOFnhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xS5enrqUYh0H6cthdMCNa0NgtYSuRAU4Q9Wyfyvfp7s=;
 b=NR1yEMSViXKrN3y4KFU5rrz8ToR2SbY1gi99z32uONdwtftoe9fVDCM1QUbjApz3Cob6O8cWoyqlcUwQfGmBURsRUt1tB7POvIE9NCfKlX57qUo0OSpk5wO2sbbL/F75mXh3EdvFSwcET4PVMmVpo0Lmea8PSbegtAB+t4EjlHKZpHjsc0i/w+ugbhwdSdM7qkNWsfEcVPg05W7ee9vcFmRJaQeFoY1TDI6fVK4DC4uiZIPe71KH3Ourh8223Moe/MBcCkP/R96caqUZxPdpPSZsLuKLFxp8afvARSggQ6jA6rs15sH7c3v3bJEOdS5HRv6CurBAH0Z/uBVdlE52PQ==
Received: from MN2PR08CA0001.namprd08.prod.outlook.com (2603:10b6:208:239::6)
 by CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 19:03:42 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::d) by MN2PR08CA0001.outlook.office365.com
 (2603:10b6:208:239::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 19:03:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 19:03:42 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 13 May
 2026 12:03:21 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 13 May 2026 12:03:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 13 May 2026 12:03:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Simon Horman <horms@kernel.org>, Alexandre Cassen
	<acassen@corp.free.fr>, Kees Cook <kees@kernel.org>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Fernando Fernandez Mancera <fmancera@suse.de>, Antonio Quartulli
	<antonio@openvpn.net>, Cosmin Ratiu <cratiu@nvidia.com>, Edward Cree
	<ecree.xilinx@gmail.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>
Subject: [PATCH net] net/mlx5e: Skip IPsec flow modify when MAC address is unchanged
Date: Wed, 13 May 2026 22:02:26 +0300
Message-ID: <20260513190226.335562-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|CH3PR12MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e3ea21-cfc2-4885-1c0f-08deb12259c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|56012099003|18002099003|11063799003|41080700001;
X-Microsoft-Antispam-Message-Info:
	avusWw97z4jOf5Er177NzvrgNqCF9vDx6F+JC36/veVhmKqvNsfx7FGmQ9TtZvfLFb9spXCb4lBEh/cdOiaWB268flwEzPY9fWCSpg1htv9O7LuvWjVxURbzMK/st+vF0NELnVU4wV8AuXgFo8DXpr1lzK7f9cYuew+zOxuwdO6/8JDE8WmeEGug8FkDAnb9PThtQ75HhNgn8b1bfrzrO4AL+AHvf0K/thbFuBMk7PG32fZiofHR1zQJorFocNaWEBQHA+g63PYX7ju0qaiIwJ+CHb2QCqhoWFJQcx3DMD0zl6qpTJmFVQjoS8wVanpd3vfA5U7yH2DF3EqwEZ9HEGGJbNx4o3DuWkNXBtjta8UErk1gzysV1vgNDvzW5+0CWeQvTA/cSyX3c58cvrpLwa8S9ggqVlxNFf31nRmlCEy/FNCCP5mIKKiNtmr/pNm8lb/QzzAM88lFCUlV0hOjKZzy859YFkhuThP1Rvwc00d0Pbmaa5tDsto8w2uG9h8STt9CX//BmVoxYI870MukfKX/9isTpQTN+fcOhdPWAbw2mB79arkVoacH+z8HncXWaLRiqCbqKtBoBFqPpN8OQiNnUywHvOeTeQNOsC0iZj2vTp02S57egnotiW0Ba5pE8wTswqiAVaVK8/eNlmyrHp4QWyoEYWgbrEyKJzrrhX3BTLmzQOXiOVEJcOA2NbH4Am6hejW7xgfm0LELiuefSZu/dt7fa1zcR9WezyJqGZuIbm0Uqi+Vnbov/Gqduot1CdcvBKVPGUQda2KluopUCIcKyYOb2oWq8S9E3pAO2uk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(56012099003)(18002099003)(11063799003)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	snqgTH0lugwZ8Ys142x2T4PvD63NO3FxGuAQHAVrm+LMgjk6jtdDMkbZi7lzTDe1VoeHBCLaJ6KcqB6y5/dxAUdPWtnF8gzrL9Tt49H/zx6Aw1cOeUqMRN9gD+qW+Jr63sHK6ckPfmTkI0FwHBDJj2hZhzXB3T8yLIFo5Wj5V6BiQRvqXqKZxc92gwzsn1tpUcOFhW4JEVJKeq5A6A4+FPyIUsv9kgxXdjQywz6pWusAnP4TRtS0VFJqT7nES+fFx1PrG7HBmsMBDlZ30KLSHJJnYyxk9svAgBYiQEU+zN5uvZ7LDkdVrubGUqjniFkHkw5Gcev573KcWRz0RGlUqC3eb+rAtWGDh9tZRHLiXo8SyjioTIQi9cij6sZlFRlWC9Bno9mPymd9TNyHZ9SepuJf7wS3I2C1zn0ouqTe9+QtIswjhDMrjRh9MGiT25bR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 19:03:42.4153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e3ea21-cfc2-4885-1c0f-08deb12259c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8659
X-Rspamd-Queue-Id: EFD0A5399CC
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
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,corp.free.fr,zx2c4.com,linux.intel.com,suse.de,openvpn.net,gmail.com,intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20605-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Jianbo Liu <jianbol@nvidia.com>

When a netdev event fires for an IPsec SA, skip calling
mlx5e_accel_ipsec_fs_modify() if the MAC address has not changed and
the rule is not in drop mode. This avoids a redundant hardware update
when nothing has changed, while still allowing the rule to be restored
when the neighbor becomes reachable again after a drop.

Fixes: 4c24272b4e2b ("net/mlx5e: Listen to ARP events to update IPsec L2 headers in tunnel mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c  | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index a52e12c3c95a..f567cd801adb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -674,19 +674,26 @@ static void mlx5e_ipsec_handle_netdev_event(struct work_struct *_work)
 	struct mlx5e_ipsec_sa_entry *sa_entry = work->sa_entry;
 	struct mlx5e_ipsec_netevent_data *data = work->data;
 	struct mlx5_accel_esp_xfrm_attrs *attrs;
+	u8 *mac;
 
 	attrs = &sa_entry->attrs;
 
 	switch (attrs->dir) {
 	case XFRM_DEV_OFFLOAD_IN:
-		ether_addr_copy(attrs->smac, data->addr);
+		mac = attrs->smac;
 		break;
 	case XFRM_DEV_OFFLOAD_OUT:
-		ether_addr_copy(attrs->dmac, data->addr);
+		mac = attrs->dmac;
 		break;
 	default:
 		WARN_ON_ONCE(true);
+		return;
 	}
+
+	if (ether_addr_equal(mac, data->addr) && !attrs->drop)
+		return;
+
+	ether_addr_copy(mac, data->addr);
 	attrs->drop = false;
 	mlx5e_accel_ipsec_fs_modify(sa_entry);
 }

base-commit: f5b2772d14884f4be9e718644f1203d4d0e6f0d6
-- 
2.44.0


