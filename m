Return-Path: <linux-rdma+bounces-8132-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D067CA45DBE
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4784F18989D2
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789F221DB4;
	Wed, 26 Feb 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p10NHl2G"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEABF221D82;
	Wed, 26 Feb 2025 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570546; cv=fail; b=MACG0wvp5VDK/JFCjxeOwvIU3H6WCsBu8hWFkOowY4DZZCK1tYusn0W/k0GtzzqjRZp3B5I01OUlFqZWGo52bFIdZvOes3VTZ9JCe/CRckeQYBTk0D3+LPjNE2Yovw/gr4U9X0L0/v57khWCW8huR3qpDiJaJiR2Jlif9UKOFt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570546; c=relaxed/simple;
	bh=wrSL3af+kyeDS+4rEfj1q94iieSt8e05h+hcuR5o5nE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQHVznP1/dRYl/phkPUKJxfRzyPjG/2NUcEW8HbeLhyv9lSjBH7IPEOgi9reDJZLLxrHEsZrgGIgm9WdJ2hNBLyp60lRw7ruJt4+te+sZn2dWK9FoSXV3ATT4N9WUxVf5vGncqys/EZ8BfnqULlJo6MhL3Rf/EUJFkH65dKnJyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p10NHl2G; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xBZYj6vlQlFS+GdvLWpOms7+kTuaz/+yFCNdjZ3qQN4EJehG68IRGr76iC7hI/WKnovdqhc8MXm7jWe4Qjg9AXZDPi679LEW5tVNlOYRWD0gkDz7aW2zZ6U50riCfxhvOhrltUwSim92YuUboJ5MGSAkzyZQpftmg4fbVH5PLgJ3HnrTnmB3Kcnj/CKFsypO/rtxbARjc9xKSi5FE2cMqFsKbigVzbxfLuk5jQcvRInnKJ52FPXgxB0E8lDbTGTHVzOvdGb/UaSvzvdL2ag0gsM/gmQX4cNZRo3vn81r9PiGIdZGvfeYnKHSNUvnn8T3hvwi2dLwmcRr4jfQYjuKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S53bL5ML6qRz0Y34Nf+iSWI81Pm0W1jebIINGSql/vA=;
 b=vtQtXzCFQGdhQyAE3TduTMIjOMStr5zUx/IF3HeUbAENRkj+MailMZPrN3VMYUGkiepstVK0vLsvnuF1QpBycOmWbNuN1TRYvTuzAEz1RTDZSLhIf2+yIcgos+81/tNYGaFEtHunH5/G1sMd1g+DBxr8QFVfq/mDnY3hUfVHcowIj+otk8GSHW5vfgXuRjTyHozxqQkAvBLqv+QU5PTFDLmxh0ykRxPAaBrFdUeGbhRgqTNFRkVt4aN/6DYEPh63oR7qPgBJtbjryvkfaqrZL4WUVM6jAFd+DhlZBapo85cOXe9/wnzFFHAtP1HrUwtGlr5v4DJ5J4FGE2tlmuGZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S53bL5ML6qRz0Y34Nf+iSWI81Pm0W1jebIINGSql/vA=;
 b=p10NHl2GOwHOie+eLWhyQdjo55biFeDe5tOvoFsb5wRhYxtV42rmfCbhjcz+rJmMNAHDkIYPDa2ZUbZStqC+jrbtACMWXVGuV0xvMyFMcfHILNBZoh4wIKrbcY0Cr+Xza09UaRMxbYR2axRPBK7SFieYHbYnj+0GBnZ71xbBt45f8Reg5Nk2iLyf7FKz5lcJXpMwaqwcJTa6fQR5dnEzGkIADs8fZ3f9MiDy5t2pLPYKh5sjYr3njKpdRRCp0TDvMQ6OfGPgxZcf/VACWIgmFT4HtPwDljY72JjjES8rZV+pZ1Jr2UPenciBG1Ho2Yr9K5xb0nGsn9tGeBizofOBgQ==
Received: from SN7PR04CA0199.namprd04.prod.outlook.com (2603:10b6:806:126::24)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 11:48:58 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::2c) by SN7PR04CA0199.outlook.office365.com
 (2603:10b6:806:126::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 11:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 11:48:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 03:48:41 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 03:48:41 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 03:48:37 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 5/6] net/mlx5e: Separate address related variables to be in struct
Date: Wed, 26 Feb 2025 13:47:51 +0200
Message-ID: <20250226114752.104838-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226114752.104838-1-tariqt@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 79047777-dc6a-4368-ab6c-08dd565b8e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FbXsfolkc1pOEdX1Su+FPGiJUTRBv91iwGj1WJEeF+xmnrwHtlsOAm1Hw9GR?=
 =?us-ascii?Q?Drf2Vk6ywFiWHmVWUgxbvyHfIBEEmrQsSA7ZurPIlPFRiFZeCqz1TxpnI1oC?=
 =?us-ascii?Q?uU8UmzbdUoPSq90D16DWHf6ZfDbLoXutbwEOVHQaiDMd0tetEEVaQQsfqZ6B?=
 =?us-ascii?Q?euCUT9pEnZkPxEyhbPt10Dr/Hxtvzm8QTbco0eWLj4IddJIRiR3wpOn0KK+x?=
 =?us-ascii?Q?i9EYRcYDXOQT2jhpVtrZ6pMAVaPuKaOK/v83V/T8PK6CSqCViH8UeNQCj1fz?=
 =?us-ascii?Q?5hxW6EqQn2bi8TN5p5jcteG6jzF4FBMZBtJ++T1JvCMf/BSLd8lQlenKlrne?=
 =?us-ascii?Q?ZUc9/lV6azlPOtDxmFRhbJhbbenq4fqO7vK4bj5lADJxShP59LdDJLVue33e?=
 =?us-ascii?Q?AF5SiDNdwLv/kJ++JLSpzL2oL3I4RtkVF55Dno5x3c3IlGePqkhojGgljVx+?=
 =?us-ascii?Q?QDqmmdFGcm8AyZOIq4ViQFvK8VNXNUjaddTV8OWtLZarCrmsryHlfQYbSdDY?=
 =?us-ascii?Q?vDrI0zylF4/xAuY/sQQSBv6WQMTFJSFJpkxKiXilniwPMnFQvlfRvAwM9x5L?=
 =?us-ascii?Q?17geBsywLb25iC31yWBCSGwqKv0vYlpiSXBuqv8bcVD5Wm0ahf4Oi2AWt6MQ?=
 =?us-ascii?Q?1UBCtsHgDDyQ/zL2VrwfQI6eFpHXke5mdfH46MZ5js4oezbtjSmugcb6v/nQ?=
 =?us-ascii?Q?t9cmuRmaQlYF/y+LebqtNB06tcgo+RSH/kCV/E6KdzEZhyho2ojpqvs6Pe+O?=
 =?us-ascii?Q?YuPMiwQJlgNq/cAjQtFa+3vXBecZMOcUMhSPbXsB8uZDsBjvxaLUdePwhF0c?=
 =?us-ascii?Q?VG9H01s0+tZR4POIQatvETClOWBie3kXeTDIBzc8oND/C+q963qoYKzVkY0W?=
 =?us-ascii?Q?AJ1Cl2+CNLon40b4E7zEYQX1kphFc0X1KB+IprTiWxUKuBVZAZ5g5ymSTbEi?=
 =?us-ascii?Q?I9ZGl702DYSVEciR17Da36dEFbUSAfhnns6tUMFiBfSdf38Ufi7RZejex2yx?=
 =?us-ascii?Q?XI6zM+lw6RcDdZWXeC9p/VOMJG43FkTLiBt/7CU1l245xcUWni0aLg4+8iR3?=
 =?us-ascii?Q?sY1dmoynwSP3RZQkNEt0+rkJm7BLcZzld/lU3FW0buw3LJr+snp8vxbf8D15?=
 =?us-ascii?Q?uJbdtk6ymVXdURYe3UzCMtQmrEtFRVoGt+6ZrnGOkjAEh7Z0LX8QUHlrBAv6?=
 =?us-ascii?Q?S8OYHZcaXbBmHnLwF4znQb9tNYo2j9b4JG3t0nNGiaTPj/F99lw4gUjJeLAi?=
 =?us-ascii?Q?6lmwBozuGzdfcMRhHpMKtvA+IvGTNgkLHI7tDOu+0xZTpRmbHYpb4n8cHNvi?=
 =?us-ascii?Q?FcZ/9xYGeb3fa72mBht2Y7syLPSUYmNwlTvNPsQR7rM4uVBadf6x1x6pDf5t?=
 =?us-ascii?Q?+BiMlQe7HACvqZA5KWmv2wNXuGikjOWQreMMvdzOS1h4pMOMMaESlWig4Ub8?=
 =?us-ascii?Q?a+9DZb8FzJcofdbCPUJzB9pquXPJRYkMcorl9zVJfaLd0eM3wFqNkdEgig1D?=
 =?us-ascii?Q?NcdiEZsY8TymwIg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:48:58.1772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79047777-dc6a-4368-ab6c-08dd565b8e1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

From: Leon Romanovsky <leonro@nvidia.com>

Prepare the code to addition of prefix handling logic which is needed
to support matching logic based on source and/or destination network
prefixes.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 32 ++++----
 .../mellanox/mlx5/core/en_accel/ipsec.h       | 26 +++----
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 75 +++++++++++--------
 3 files changed, 68 insertions(+), 65 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index 501709ac310f..beb7275d721a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -277,12 +277,12 @@ static void mlx5e_ipsec_init_macs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	case XFRM_DEV_OFFLOAD_IN:
 		src = attrs->dmac;
 		dst = attrs->smac;
-		pkey = &attrs->saddr.a4;
+		pkey = &attrs->addrs.saddr.a4;
 		break;
 	case XFRM_DEV_OFFLOAD_OUT:
 		src = attrs->smac;
 		dst = attrs->dmac;
-		pkey = &attrs->daddr.a4;
+		pkey = &attrs->addrs.daddr.a4;
 		break;
 	default:
 		return;
@@ -374,9 +374,10 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 	attrs->spi = be32_to_cpu(x->id.spi);
 
 	/* source , destination ips */
-	memcpy(&attrs->saddr, x->props.saddr.a6, sizeof(attrs->saddr));
-	memcpy(&attrs->daddr, x->id.daddr.a6, sizeof(attrs->daddr));
-	attrs->family = x->props.family;
+	memcpy(&attrs->addrs.saddr, x->props.saddr.a6,
+	       sizeof(attrs->addrs.saddr));
+	memcpy(&attrs->addrs.daddr, x->id.daddr.a6, sizeof(attrs->addrs.daddr));
+	attrs->addrs.family = x->props.family;
 	attrs->type = x->xso.type;
 	attrs->reqid = x->props.reqid;
 	attrs->upspec.dport = ntohs(x->sel.dport);
@@ -428,7 +429,8 @@ static int mlx5e_xfrm_validate_state(struct mlx5_core_dev *mdev,
 	}
 	if (x->encap) {
 		if (!(mlx5_ipsec_device_caps(mdev) & MLX5_IPSEC_CAP_ESPINUDP)) {
-			NL_SET_ERR_MSG_MOD(extack, "Encapsulation is not supported");
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Encapsulation is not supported");
 			return -EINVAL;
 		}
 
@@ -853,13 +855,13 @@ static int mlx5e_ipsec_netevent_event(struct notifier_block *nb,
 	xa_for_each_marked(&ipsec->sadb, idx, sa_entry, MLX5E_IPSEC_TUNNEL_SA) {
 		attrs = &sa_entry->attrs;
 
-		if (attrs->family == AF_INET) {
-			if (!neigh_key_eq32(n, &attrs->saddr.a4) &&
-			    !neigh_key_eq32(n, &attrs->daddr.a4))
+		if (attrs->addrs.family == AF_INET) {
+			if (!neigh_key_eq32(n, &attrs->addrs.saddr.a4) &&
+			    !neigh_key_eq32(n, &attrs->addrs.daddr.a4))
 				continue;
 		} else {
-			if (!neigh_key_eq128(n, &attrs->saddr.a4) &&
-			    !neigh_key_eq128(n, &attrs->daddr.a4))
+			if (!neigh_key_eq128(n, &attrs->addrs.saddr.a4) &&
+			    !neigh_key_eq128(n, &attrs->addrs.daddr.a4))
 				continue;
 		}
 
@@ -1035,7 +1037,7 @@ static void mlx5e_xfrm_update_stats(struct xfrm_state *x)
 	 * by removing always available headers.
 	 */
 	headers = sizeof(struct ethhdr);
-	if (sa_entry->attrs.family == AF_INET)
+	if (sa_entry->attrs.addrs.family == AF_INET)
 		headers += sizeof(struct iphdr);
 	else
 		headers += sizeof(struct ipv6hdr);
@@ -1116,9 +1118,9 @@ mlx5e_ipsec_build_accel_pol_attrs(struct mlx5e_ipsec_pol_entry *pol_entry,
 	sel = &x->selector;
 	memset(attrs, 0, sizeof(*attrs));
 
-	memcpy(&attrs->saddr, sel->saddr.a6, sizeof(attrs->saddr));
-	memcpy(&attrs->daddr, sel->daddr.a6, sizeof(attrs->daddr));
-	attrs->family = sel->family;
+	memcpy(&attrs->addrs.saddr, sel->saddr.a6, sizeof(attrs->addrs.saddr));
+	memcpy(&attrs->addrs.daddr, sel->daddr.a6, sizeof(attrs->addrs.daddr));
+	attrs->addrs.family = sel->family;
 	attrs->dir = x->xdo.dir;
 	attrs->action = x->action;
 	attrs->type = XFRM_DEV_OFFLOAD_PACKET;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index ad8db9e1fd1d..37ef1e331135 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -76,11 +76,7 @@ struct mlx5_replay_esn {
 	u8 trigger : 1;
 };
 
-struct mlx5_accel_esp_xfrm_attrs {
-	u32   spi;
-	u32   mode;
-	struct aes_gcm_keymat aes_gcm;
-
+struct mlx5e_ipsec_addr {
 	union {
 		__be32 a4;
 		__be32 a6[4];
@@ -90,13 +86,19 @@ struct mlx5_accel_esp_xfrm_attrs {
 		__be32 a4;
 		__be32 a6[4];
 	} daddr;
+	u8 family;
+};
 
+struct mlx5_accel_esp_xfrm_attrs {
+	u32   spi;
+	u32   mode;
+	struct aes_gcm_keymat aes_gcm;
+	struct mlx5e_ipsec_addr addrs;
 	struct upspec upspec;
 	u8 dir : 2;
 	u8 type : 2;
 	u8 drop : 1;
 	u8 encap : 1;
-	u8 family;
 	struct mlx5_replay_esn replay_esn;
 	u32 authsize;
 	u32 reqid;
@@ -279,18 +281,8 @@ struct mlx5e_ipsec_sa_entry {
 };
 
 struct mlx5_accel_pol_xfrm_attrs {
-	union {
-		__be32 a4;
-		__be32 a6[4];
-	} saddr;
-
-	union {
-		__be32 a4;
-		__be32 a6[4];
-	} daddr;
-
+	struct mlx5e_ipsec_addr addrs;
 	struct upspec upspec;
-	u8 family;
 	u8 action;
 	u8 type : 2;
 	u8 dir : 2;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index d51ace739637..23b63dea2f7f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1484,9 +1484,12 @@ static void tx_ft_put_policy(struct mlx5e_ipsec *ipsec, u32 prio, int type)
 	mutex_unlock(&tx->ft.mutex);
 }
 
-static void setup_fte_addr4(struct mlx5_flow_spec *spec, __be32 *saddr,
-			    __be32 *daddr)
+static void setup_fte_addr4(struct mlx5_flow_spec *spec,
+			    struct mlx5e_ipsec_addr *addrs)
 {
+	__be32 *saddr = &addrs->saddr.a4;
+	__be32 *daddr = &addrs->daddr.a4;
+
 	if (!*saddr && !*daddr)
 		return;
 
@@ -1510,9 +1513,12 @@ static void setup_fte_addr4(struct mlx5_flow_spec *spec, __be32 *saddr,
 	}
 }
 
-static void setup_fte_addr6(struct mlx5_flow_spec *spec, __be32 *saddr,
-			    __be32 *daddr)
+static void setup_fte_addr6(struct mlx5_flow_spec *spec,
+			    struct mlx5e_ipsec_addr *addrs)
 {
+	__be32 *saddr = addrs->saddr.a6;
+	__be32 *daddr = addrs->daddr.a6;
+
 	if (addr6_all_zero(saddr) && addr6_all_zero(daddr))
 		return;
 
@@ -1722,7 +1728,7 @@ setup_pkt_tunnel_reformat(struct mlx5_core_dev *mdev,
 	if (attrs->dir == XFRM_DEV_OFFLOAD_OUT) {
 		bfflen += sizeof(*esp_hdr) + 8;
 
-		switch (attrs->family) {
+		switch (attrs->addrs.family) {
 		case AF_INET:
 			bfflen += sizeof(*iphdr);
 			break;
@@ -1739,7 +1745,7 @@ setup_pkt_tunnel_reformat(struct mlx5_core_dev *mdev,
 		return -ENOMEM;
 
 	eth_hdr = (struct ethhdr *)reformatbf;
-	switch (attrs->family) {
+	switch (attrs->addrs.family) {
 	case AF_INET:
 		eth_hdr->h_proto = htons(ETH_P_IP);
 		break;
@@ -1762,11 +1768,11 @@ setup_pkt_tunnel_reformat(struct mlx5_core_dev *mdev,
 		reformat_params->param_0 = attrs->authsize;
 
 		hdr = reformatbf + sizeof(*eth_hdr);
-		switch (attrs->family) {
+		switch (attrs->addrs.family) {
 		case AF_INET:
 			iphdr = (struct iphdr *)hdr;
-			memcpy(&iphdr->saddr, &attrs->saddr.a4, 4);
-			memcpy(&iphdr->daddr, &attrs->daddr.a4, 4);
+			memcpy(&iphdr->saddr, &attrs->addrs.saddr.a4, 4);
+			memcpy(&iphdr->daddr, &attrs->addrs.daddr.a4, 4);
 			iphdr->version = 4;
 			iphdr->ihl = 5;
 			iphdr->ttl = IPSEC_TUNNEL_DEFAULT_TTL;
@@ -1775,8 +1781,8 @@ setup_pkt_tunnel_reformat(struct mlx5_core_dev *mdev,
 			break;
 		case AF_INET6:
 			ipv6hdr = (struct ipv6hdr *)hdr;
-			memcpy(&ipv6hdr->saddr, &attrs->saddr.a6, 16);
-			memcpy(&ipv6hdr->daddr, &attrs->daddr.a6, 16);
+			memcpy(&ipv6hdr->saddr, &attrs->addrs.saddr.a6, 16);
+			memcpy(&ipv6hdr->daddr, &attrs->addrs.daddr.a6, 16);
 			ipv6hdr->nexthdr = IPPROTO_ESP;
 			ipv6hdr->version = 6;
 			ipv6hdr->hop_limit = IPSEC_TUNNEL_DEFAULT_TTL;
@@ -1810,7 +1816,7 @@ static int get_reformat_type(struct mlx5_accel_esp_xfrm_attrs *attrs)
 			return MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT_OVER_UDP;
 		return MLX5_REFORMAT_TYPE_DEL_ESP_TRANSPORT;
 	case XFRM_DEV_OFFLOAD_OUT:
-		if (attrs->family == AF_INET) {
+		if (attrs->addrs.family == AF_INET) {
 			if (attrs->encap)
 				return MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_UDPV4;
 			return MLX5_REFORMAT_TYPE_ADD_ESP_TRANSPORT_OVER_IPV4;
@@ -2003,7 +2009,7 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 	struct mlx5_fc *counter;
 	int err = 0;
 
-	rx = rx_ft_get(mdev, ipsec, attrs->family, attrs->type);
+	rx = rx_ft_get(mdev, ipsec, attrs->addrs.family, attrs->type);
 	if (IS_ERR(rx))
 		return PTR_ERR(rx);
 
@@ -2013,10 +2019,10 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		goto err_alloc;
 	}
 
-	if (attrs->family == AF_INET)
-		setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
+	if (attrs->addrs.family == AF_INET)
+		setup_fte_addr4(spec, &attrs->addrs);
 	else
-		setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
+		setup_fte_addr6(spec, &attrs->addrs);
 
 	setup_fte_spi(spec, attrs->spi, attrs->encap);
 	if (!attrs->encap)
@@ -2116,7 +2122,7 @@ static int rx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 err_mod_header:
 	kvfree(spec);
 err_alloc:
-	rx_ft_put(ipsec, attrs->family, attrs->type);
+	rx_ft_put(ipsec, attrs->addrs.family, attrs->type);
 	return err;
 }
 
@@ -2148,10 +2154,10 @@ static int tx_add_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 
 	switch (attrs->type) {
 	case XFRM_DEV_OFFLOAD_CRYPTO:
-		if (attrs->family == AF_INET)
-			setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
+		if (attrs->addrs.family == AF_INET)
+			setup_fte_addr4(spec, &attrs->addrs);
 		else
-			setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
+			setup_fte_addr6(spec, &attrs->addrs);
 		setup_fte_spi(spec, attrs->spi, false);
 		setup_fte_esp(spec);
 		setup_fte_reg_a(spec);
@@ -2235,10 +2241,10 @@ static int tx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	}
 
 	tx = ipsec_tx(ipsec, attrs->type);
-	if (attrs->family == AF_INET)
-		setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
+	if (attrs->addrs.family == AF_INET)
+		setup_fte_addr4(spec, &attrs->addrs);
 	else
-		setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
+		setup_fte_addr6(spec, &attrs->addrs);
 
 	setup_fte_no_frags(spec);
 	setup_fte_upper_proto_match(spec, &attrs->upspec);
@@ -2308,12 +2314,12 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 	struct mlx5e_ipsec_rx *rx;
 	int err, dstn = 0;
 
-	ft = rx_ft_get_policy(mdev, pol_entry->ipsec, attrs->family, attrs->prio,
-			      attrs->type);
+	ft = rx_ft_get_policy(mdev, pol_entry->ipsec, attrs->addrs.family,
+			      attrs->prio, attrs->type);
 	if (IS_ERR(ft))
 		return PTR_ERR(ft);
 
-	rx = ipsec_rx(pol_entry->ipsec, attrs->family, attrs->type);
+	rx = ipsec_rx(pol_entry->ipsec, attrs->addrs.family, attrs->type);
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec) {
@@ -2321,10 +2327,10 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 		goto err_alloc;
 	}
 
-	if (attrs->family == AF_INET)
-		setup_fte_addr4(spec, &attrs->saddr.a4, &attrs->daddr.a4);
+	if (attrs->addrs.family == AF_INET)
+		setup_fte_addr4(spec, &attrs->addrs);
 	else
-		setup_fte_addr6(spec, attrs->saddr.a6, attrs->daddr.a6);
+		setup_fte_addr6(spec, &attrs->addrs);
 
 	setup_fte_no_frags(spec);
 	setup_fte_upper_proto_match(spec, &attrs->upspec);
@@ -2364,7 +2370,8 @@ static int rx_add_policy(struct mlx5e_ipsec_pol_entry *pol_entry)
 err_action:
 	kvfree(spec);
 err_alloc:
-	rx_ft_put_policy(pol_entry->ipsec, attrs->family, attrs->prio, attrs->type);
+	rx_ft_put_policy(pol_entry->ipsec, attrs->addrs.family, attrs->prio,
+			 attrs->type);
 	return err;
 }
 
@@ -2638,7 +2645,8 @@ void mlx5e_accel_ipsec_fs_del_rule(struct mlx5e_ipsec_sa_entry *sa_entry)
 		mlx5_fc_destroy(mdev, ipsec_rule->replay.fc);
 	}
 	mlx5_esw_ipsec_rx_id_mapping_remove(sa_entry);
-	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.family, sa_entry->attrs.type);
+	rx_ft_put(sa_entry->ipsec, sa_entry->attrs.addrs.family,
+		  sa_entry->attrs.type);
 }
 
 int mlx5e_accel_ipsec_fs_add_pol(struct mlx5e_ipsec_pol_entry *pol_entry)
@@ -2674,7 +2682,8 @@ void mlx5e_accel_ipsec_fs_del_pol(struct mlx5e_ipsec_pol_entry *pol_entry)
 	mlx5e_ipsec_unblock_tc_offload(pol_entry->ipsec->mdev);
 
 	if (pol_entry->attrs.dir == XFRM_DEV_OFFLOAD_IN) {
-		rx_ft_put_policy(pol_entry->ipsec, pol_entry->attrs.family,
+		rx_ft_put_policy(pol_entry->ipsec,
+				 pol_entry->attrs.addrs.family,
 				 pol_entry->attrs.prio, pol_entry->attrs.type);
 		return;
 	}
@@ -2814,7 +2823,7 @@ bool mlx5e_ipsec_fs_tunnel_enabled(struct mlx5e_ipsec_sa_entry *sa_entry)
 	struct mlx5e_ipsec_rx *rx;
 	struct mlx5e_ipsec_tx *tx;
 
-	rx = ipsec_rx(sa_entry->ipsec, attrs->family, attrs->type);
+	rx = ipsec_rx(sa_entry->ipsec, attrs->addrs.family, attrs->type);
 	tx = ipsec_tx(sa_entry->ipsec, attrs->type);
 	if (sa_entry->attrs.dir == XFRM_DEV_OFFLOAD_OUT)
 		return tx->allow_tunnel_mode;
-- 
2.45.0


