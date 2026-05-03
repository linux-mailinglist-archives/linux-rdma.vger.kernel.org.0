Return-Path: <linux-rdma+bounces-19888-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNl1EbOw92k1lAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19888-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:31:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F324B7506
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFB3E303717A
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C2239A058;
	Sun,  3 May 2026 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f0LxP0GY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D053A1CFE;
	Sun,  3 May 2026 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840115; cv=fail; b=J+KUJsk/82MPOrO4/ShMK52CtcjvyC5V1q/ajhSe67wBlmmKVe/A1bDlvOsooecjhjifliDhHjro4+jtphN6sZ7gVQkLHoLIqrkyV1Wpjd2n9M1QP8REa93XZqR9OsFu+3vuTDhEf5aSds0XJS5qKPKlhwydccfuNJ89w9OC/I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840115; c=relaxed/simple;
	bh=d5RlLNCxdWDx/5UJHgie5euSofkZz+qfH48ZYTM/hA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sCZMHyz4X3mjwtic+k3RXVMR8bB3nF73QEogy/9saAX5kippG7HNDA9W8Dski/TrxCheNt6nP8hvt8WsgIrfzo5GBXTO9woZpEk2hGzU09dGY+UolBC321Kuh2xvblAJHRVYSdfF2PNhdFWEvDnMPa+v0wkT4V0FBbJt8sKd9KI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f0LxP0GY; arc=fail smtp.client-ip=52.101.52.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG46I4eaabdciuSzbUXpsNjvHnr4i+5rMBVzfA4jQqyPr7f+B4MdEWHw2gMhlG4uvM90B4Bl/vRxH6R4hJdEFL/ZltPKo4BjsDVbbRMrj9QmHB6B3fnk6kG2hDDoshodbAv3m65yxVlUPeOjCAf+buwsqGLYPs+WHywlLImMwNyApuYXv7Wgry32TMBIk58svsISClUSAto+1g6/wOngiOUezY4tF4H2ujedi7AyWwDSIjCvib5lN8+jZuPpCPAHReWPQp9SHw1bWpzh2CRwwxh3G4hssr0vjP1VqxbRgQ7mgSDN0G3Znm2CyWMFjhk+Bkk0TimNAmp5Xw2UmjwV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NH/jQGtMiNI6N1j6i17l9hZtS54Is3lMYxYmfEzGiXo=;
 b=AJTnUhHOL8ja9fX59ZBcESvdfgt788Foi2vCbSYuiVEVkK8gXlOUPWKkMLNKJi/DtfRnyc7J2sLBfe1OMoUfJsNKzNYGKDwk2zgbSz1YZBgqaw3743vqlVQvSDdNO8mbZATNLde/x2OIKRxq5lpZBGuTk/bGWRIobAymEEi5s4sRMOr20vniR7A3JFSrsbFpkJkBMQe04EC+zd45Q4gEeeJYmctDL5KZmnHorkrpO1ItsFsbajIHIpZ4fcHkNmAP4kSc/P5qXA3mF+OJC3pDxuUSU8iOmV+xeqXkncIcG0UOH7cmC1WVQGPcWrgJzuE1NZwInbLsbZIWUs/Co1vXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NH/jQGtMiNI6N1j6i17l9hZtS54Is3lMYxYmfEzGiXo=;
 b=f0LxP0GY0lcS/5QA2WLRMnjGzt5K+ZswTc9M3aH3BkFUQtO/AMZWfp2l4cj8Ya6Bpll6EW3iUK7QU6KQ+86v9jKnYU3wkKj29Tc1y+GU9YeUT5Rm5phUiwPbAhG3rdPIzhZcJVFy8kh2X3g9calY2HbSAbmkP/Efk7hMb2RAHes8Fs4MxXhvjg37k1Y9th0FIGE0t7Pzv3f/AND/svNCCIWYt0RBiM4dErhjXzLeTVXh7SL19TwucjzjnpTqTehq0PkHf2M1W4wmTRL5A90qbbY+37UpvZKwY1evt53sctyzLK58p2YVnd5wv3k4govFfICUn7J6d1BywUE1NqxSDg==
Received: from BYAPR06CA0070.namprd06.prod.outlook.com (2603:10b6:a03:14b::47)
 by DSWPR12MB999128.namprd12.prod.outlook.com (2603:10b6:8:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Sun, 3 May
 2026 20:28:25 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:14b:cafe::22) by BYAPR06CA0070.outlook.office365.com
 (2603:10b6:a03:14b::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Sun,
 3 May 2026 20:28:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 20:28:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 13:28:22 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 13:28:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 13:28:15 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shay Drory <shayd@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>, Edward Srouji <edwards@nvidia.com>, Simon Horman
	<horms@kernel.org>, Maher Sanalla <msanalla@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, Kees Cook
	<kees@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next V3 5/7] net/mlx5: E-Switch, serialize representor lifecycle
Date: Sun, 3 May 2026 23:27:24 +0300
Message-ID: <20260503202726.266415-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260503202726.266415-1-tariqt@nvidia.com>
References: <20260503202726.266415-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|DSWPR12MB999128:EE_
X-MS-Office365-Filtering-Correlation-Id: 913a3b04-99d1-4883-1c4a-08dea95286ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2ecJ42ruu1+OGeQv2FFG6ugVKwaw2Ppzqx7L83tuVDIqByUOu7XdmsX4UQExmcwRIzr2iKkv/plz6ikDLqGNQlJxd18mzB3gL1xFVGzY6CeVMS0ezUQfOYuzzqysPAFf+Wul8qZctrIrVcfY6glbhoHgBfIqRIrkwdtp9o2v/7YXv3I589KLOL/Wa5TbK5MliiWg53NhvgBa76EWraAblyOKzW95KoplDB3Nd4iZ6NstgRZ+aX9O9hBqQfTXaPre6d9/Qn0mGie9L9Q3BmoQumD2CSogtq7xKUjKdFIN59pJmgWN0g8sAYAoEs55FUv0iZBNj1cZhQI3yaGEO4Oxu1kyVIOV/XEmhy04AJEd5XFfLujQJeCD49dpogFClEO1ATFqP9yMHqeIkJSthym2GxRmycOLsRAkNVsKP9IVRk6XiOA7MtE7C49UBALVUz5HT+Ry+YDOD9rJm293297KldBQvtFv3GyUZZCPmYVRkTgNPgcT1eZ17Xy1DBPTFxESP3JscLXjZTZ3gBkhCw10ogOtsDEThtf2BaeFgrWn697UFT5Pwe6Ej277nWIc62SdoFjQoIW6d93VYikLjAQsd9OuVCQ5mlREBNzofctCrWDaG8uKzRRr7kGjhjbRZD+p7spHoIEKZsrmk8TwP4mZv5tZE3EXWJ+rD0d8Pnrx42W9Pr/bb2MHD9U+oTisa11F2rGIKOoJmE4zVTtHwYfVcK4TV59gFzeyXCD142dv9tc=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e8v3KhiIYnc8266gPAINJqFPtZ5/Y5JErfzYBXjTBb3dzGFXxdiYIj+ASSszrsA+ZJugzNNzB23CRKWhu75tamsoaITPkixhc/EMMV9qrEI2vxfUlu9Bxx5gINq4Lm8c1Aipmk4ZXH9l64c8hUaRNACfJmFCsXA+3lNFp6jXrpJ87Nf3k32Kh3fdYOJ2sBpg/c80n2H1ISS8L9roXdyJnxuSV7FlIuA4DETnlJRHlskhKnD6O8xagV+5QGF2+/hwRByglK6LUhrObFSasETVcrE4O/owDc+/bHbv8TOEthzqE2DbDFy+msZtWIL2uBDtkmWV0kFiYrjCF9rwX4YOUzdbL23Q6CKKCNViFz5t/NMEoQQbcTXW4rgcYkuB+tYNkOAonjOZmpLoT36Pxw+hNGbyKYWzoojWPkZbdhcXS35jlEDAAz0aIp05iUY0iAoV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:28:24.6488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913a3b04-99d1-4883-1c4a-08dea95286ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128
X-Rspamd-Queue-Id: D2F324B7506
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19888-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Mark Bloch <mbloch@nvidia.com>

Representor callbacks can be registered and unregistered while the
E-Switch is already in switchdev mode, and the same E-Switch may also be
reconfigured by devlink, VF changes and SF changes. Serialize these paths
with the per-E-Switch representor mutex instead of relying on ad-hoc bit
state and wait queues.

Take the representor lock around the mode transition, VF/SF representor
changes and representor ops registration. Keep mode_lock and the
representor lock unnested by using the operation flag while the mode lock
is dropped. During mode changes, drop the representor lock around the
auxiliary bus rescan because driver bind/unbind may register or unregister
representor ops.

Split representor ops registration into locked public wrappers and blocked
internal helpers, clear the ops pointer on unregister, and add nested
wrappers for the shared-FDB master IB path that registers peer
representor ops while another E-Switch representor lock is already held.

On unregister, always call __unload_reps_all_vport() before marking reps
unregistered and clearing rep_ops. The per-representor state check makes
this a no-op for types that were not loaded, so unregister no longer has
to infer load state from esw->mode.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c           |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  10 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 105 ++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |   5 +
 include/linux/mlx5/eswitch.h                  |   6 +
 5 files changed, 120 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 1709b628702e..65d8767d1830 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -262,9 +262,10 @@ mlx5_ib_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 			struct mlx5_core_dev *peer_mdev;
 			struct mlx5_eswitch *esw;
 
+			/* Called while the master E-Switch reps_lock is held. */
 			mlx5_lag_for_each_peer_mdev(mdev, peer_mdev, i) {
 				esw = peer_mdev->priv.eswitch;
-				mlx5_eswitch_unregister_vport_reps(esw, REP_IB);
+				mlx5_eswitch_unregister_vport_reps_nested(esw, REP_IB);
 			}
 			mlx5_ib_release_transport(mdev);
 		}
@@ -284,9 +285,10 @@ static void mlx5_ib_register_peer_vport_reps(struct mlx5_core_dev *mdev)
 	struct mlx5_eswitch *esw;
 	int i;
 
+	/* Called while the master E-Switch reps_lock is held. */
 	mlx5_lag_for_each_peer_mdev(mdev, peer_mdev, i) {
 		esw = peer_mdev->priv.eswitch;
-		mlx5_eswitch_register_vport_reps(esw, &rep_ops, REP_IB);
+		mlx5_eswitch_register_vport_reps_nested(esw, &rep_ops, REP_IB);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 66a773a99876..f70737437954 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1712,6 +1712,7 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 		mlx5_lag_disable_change(esw->dev);
 
 	mlx5_eswitch_invalidate_wq(esw);
+	mlx5_esw_reps_block(esw);
 
 	if (!mlx5_esw_is_fdb_created(esw)) {
 		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
@@ -1735,6 +1736,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 		}
 	}
 
+	mlx5_esw_reps_unblock(esw);
+
 	if (toggle_lag)
 		mlx5_lag_enable_change(esw->dev);
 
@@ -1759,6 +1762,7 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 		 esw->esw_funcs.num_vfs, esw->esw_funcs.num_ec_vfs, esw->enabled_vports);
 
 	mlx5_eswitch_invalidate_wq(esw);
+	mlx5_esw_reps_block(esw);
 
 	if (!mlx5_core_is_ecpf(esw->dev)) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -1770,6 +1774,8 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 			mlx5_eswitch_clear_ec_vf_vports_info(esw);
 	}
 
+	mlx5_esw_reps_unblock(esw);
+
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS) {
 		struct devlink *devlink = priv_to_devlink(esw->dev);
 
@@ -1825,7 +1831,11 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 
 	devl_assert_locked(priv_to_devlink(esw->dev));
 	mlx5_lag_disable_change(esw->dev);
+
+	mlx5_esw_reps_block(esw);
 	mlx5_eswitch_disable_locked(esw);
+	mlx5_esw_reps_unblock(esw);
+
 	esw->mode = MLX5_ESWITCH_LEGACY;
 	mlx5_lag_enable_change(esw->dev);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index af7d0d58c048..a393efaa2fd7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -36,6 +36,7 @@
 #include <linux/mlx5/mlx5_ifc.h>
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/fs.h>
+#include <linux/lockdep.h>
 #include "mlx5_core.h"
 #include "eswitch.h"
 #include "esw/indir_table.h"
@@ -2413,11 +2414,21 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
 	return err;
 }
 
+static void mlx5_esw_assert_reps_locked(struct mlx5_eswitch *esw)
+{
+	lockdep_assert_held(&esw->offloads.reps_lock);
+}
+
 void mlx5_esw_reps_block(struct mlx5_eswitch *esw)
 {
 	mutex_lock(&esw->offloads.reps_lock);
 }
 
+static void mlx5_esw_reps_block_nested(struct mlx5_eswitch *esw)
+{
+	mutex_lock_nested(&esw->offloads.reps_lock, SINGLE_DEPTH_NESTING);
+}
+
 void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
 {
 	mutex_unlock(&esw->offloads.reps_lock);
@@ -2425,21 +2436,22 @@ void mlx5_esw_reps_unblock(struct mlx5_eswitch *esw)
 
 static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
 {
+	mlx5_esw_reps_unblock(esw);
 	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
 	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV ||
 	    mlx5_core_mp_enabled(esw->dev)) {
 		esw->mode = mode;
-		mlx5_rescan_drivers_locked(esw->dev);
-		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
-		return;
+		goto out;
 	}
 
 	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(esw->dev);
 	esw->mode = mode;
 	esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+out:
 	mlx5_rescan_drivers_locked(esw->dev);
 	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
+	mlx5_esw_reps_block(esw);
 }
 
 static void mlx5_esw_fdb_drop_destroy(struct mlx5_eswitch *esw)
@@ -2776,6 +2788,8 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
 static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
 				   struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
+	mlx5_esw_assert_reps_locked(esw);
+
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
 			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
 		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
@@ -2786,6 +2800,8 @@ static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
 static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
+	mlx5_esw_assert_reps_locked(esw);
+
 	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
 			   REP_LOADED, REP_REGISTERED) == REP_LOADED) {
 		if (rep_type == REP_ETH)
@@ -3691,6 +3707,7 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 	if (new_num_vfs == esw->esw_funcs.num_vfs || host_pf_disabled)
 		goto free;
 
+	mlx5_esw_reps_block(esw);
 	/* Number of VFs can only change from "0 to x" or "x to 0". */
 	if (esw->esw_funcs.num_vfs > 0) {
 		mlx5_eswitch_unload_vf_vports(esw, esw->esw_funcs.num_vfs);
@@ -3700,9 +3717,11 @@ static void esw_vfs_changed_event_handler(struct mlx5_eswitch *esw)
 		err = mlx5_eswitch_load_vf_vports(esw, new_num_vfs,
 						  MLX5_VPORT_UC_ADDR_CHANGE);
 		if (err)
-			goto free;
+			goto unblock;
 	}
 	esw->esw_funcs.num_vfs = new_num_vfs;
+unblock:
+	mlx5_esw_reps_unblock(esw);
 free:
 	kvfree(out);
 }
@@ -4190,9 +4209,14 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		goto unlock;
 	}
 
+	/* Keep mode_lock and reps_lock unnested. The operation flag excludes
+	 * mode users while mode_lock is dropped before taking reps_lock.
+	 */
 	esw->eswitch_operation_in_progress = true;
 	up_write(&esw->mode_lock);
 
+	mlx5_esw_reps_block(esw);
+
 	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS &&
 	    !mlx5_devlink_netdev_netns_immutable_set(devlink, true)) {
 		NL_SET_ERR_MSG_MOD(extack,
@@ -4225,6 +4249,10 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 skip:
 	if (mlx5_mode == MLX5_ESWITCH_OFFLOADS && err)
 		mlx5_devlink_netdev_netns_immutable_set(devlink, false);
+	/* Reconfiguration is done; drop reps_lock before taking mode_lock again
+	 * to clear the operation flag.
+	 */
+	mlx5_esw_reps_unblock(esw);
 	down_write(&esw->mode_lock);
 	esw->eswitch_operation_in_progress = false;
 unlock:
@@ -4498,9 +4526,10 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
 	return true;
 }
 
-void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
-				      const struct mlx5_eswitch_rep_ops *ops,
-				      u8 rep_type)
+static void
+mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
+					 const struct mlx5_eswitch_rep_ops *ops,
+					 u8 rep_type)
 {
 	struct mlx5_eswitch_rep_data *rep_data;
 	struct mlx5_eswitch_rep *rep;
@@ -4515,21 +4544,77 @@ void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
 		}
 	}
 }
+
+static void
+mlx5_eswitch_register_vport_reps_locked(struct mlx5_eswitch *esw,
+					const struct mlx5_eswitch_rep_ops *ops,
+					u8 rep_type, bool nested)
+{
+	if (nested)
+		mlx5_esw_reps_block_nested(esw);
+	else
+		mlx5_esw_reps_block(esw);
+	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
+	mlx5_esw_reps_unblock(esw);
+}
+
+void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
+				      const struct mlx5_eswitch_rep_ops *ops,
+				      u8 rep_type)
+{
+	mlx5_eswitch_register_vport_reps_locked(esw, ops, rep_type, false);
+}
 EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps);
 
-void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
+void
+mlx5_eswitch_register_vport_reps_nested(struct mlx5_eswitch *esw,
+					const struct mlx5_eswitch_rep_ops *ops,
+					u8 rep_type)
+{
+	mlx5_eswitch_register_vport_reps_locked(esw, ops, rep_type, true);
+}
+EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps_nested);
+
+static void
+mlx5_eswitch_unregister_vport_reps_blocked(struct mlx5_eswitch *esw,
+					   u8 rep_type)
 {
 	struct mlx5_eswitch_rep *rep;
 	unsigned long i;
 
-	if (esw->mode == MLX5_ESWITCH_OFFLOADS)
-		__unload_reps_all_vport(esw, rep_type);
+	__unload_reps_all_vport(esw, rep_type);
 
 	mlx5_esw_for_each_rep(esw, i, rep)
 		atomic_set(&rep->rep_data[rep_type].state, REP_UNREGISTERED);
+
+	esw->offloads.rep_ops[rep_type] = NULL;
+}
+
+static void
+mlx5_eswitch_unregister_vport_reps_locked(struct mlx5_eswitch *esw,
+					  u8 rep_type, bool nested)
+{
+	if (nested)
+		mlx5_esw_reps_block_nested(esw);
+	else
+		mlx5_esw_reps_block(esw);
+	mlx5_eswitch_unregister_vport_reps_blocked(esw, rep_type);
+	mlx5_esw_reps_unblock(esw);
+}
+
+void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type)
+{
+	mlx5_eswitch_unregister_vport_reps_locked(esw, rep_type, false);
 }
 EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps);
 
+void mlx5_eswitch_unregister_vport_reps_nested(struct mlx5_eswitch *esw,
+					       u8 rep_type)
+{
+	mlx5_eswitch_unregister_vport_reps_locked(esw, rep_type, true);
+}
+EXPORT_SYMBOL(mlx5_eswitch_unregister_vport_reps_nested);
+
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type)
 {
 	struct mlx5_eswitch_rep *rep;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index 8503e532f423..2fc69897e35b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -245,8 +245,10 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 	if (IS_ERR(sf))
 		return PTR_ERR(sf);
 
+	mlx5_esw_reps_block(esw);
 	err = mlx5_eswitch_load_sf_vport(esw, sf->hw_fn_id, MLX5_VPORT_UC_ADDR_CHANGE,
 					 &sf->dl_port, new_attr->controller, new_attr->sfnum);
+	mlx5_esw_reps_unblock(esw);
 	if (err)
 		goto esw_err;
 	*dl_port = &sf->dl_port.dl_port;
@@ -367,7 +369,10 @@ int mlx5_devlink_sf_port_del(struct devlink *devlink,
 	struct mlx5_sf_table *table = dev->priv.sf_table;
 	struct mlx5_sf *sf = mlx5_sf_by_dl_port(dl_port);
 
+	mlx5_esw_reps_block(dev->priv.eswitch);
 	mlx5_sf_del(table, sf);
+	mlx5_esw_reps_unblock(dev->priv.eswitch);
+
 	return 0;
 }
 
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index 3b29a3c6794d..a0dd162baa78 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -63,7 +63,13 @@ struct mlx5_eswitch_rep {
 void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
 				      const struct mlx5_eswitch_rep_ops *ops,
 				      u8 rep_type);
+void
+mlx5_eswitch_register_vport_reps_nested(struct mlx5_eswitch *esw,
+					const struct mlx5_eswitch_rep_ops *ops,
+					u8 rep_type);
 void mlx5_eswitch_unregister_vport_reps(struct mlx5_eswitch *esw, u8 rep_type);
+void mlx5_eswitch_unregister_vport_reps_nested(struct mlx5_eswitch *esw,
+					       u8 rep_type);
 void *mlx5_eswitch_get_proto_dev(struct mlx5_eswitch *esw,
 				 u16 vport_num,
 				 u8 rep_type);
-- 
2.44.0


