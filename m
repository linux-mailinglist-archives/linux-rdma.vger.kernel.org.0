Return-Path: <linux-rdma+bounces-19156-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKsWFNaV12mGPwgAu9opvQ
	(envelope-from <linux-rdma+bounces-19156-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:04:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B96B83CA0D1
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Apr 2026 14:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDDB8306BA71
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Apr 2026 11:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCE3C454E;
	Thu,  9 Apr 2026 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tHzZu8Uj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013067.outbound.protection.outlook.com [40.93.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E003C4554;
	Thu,  9 Apr 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775735850; cv=fail; b=ZjxY/IkgLahWlS9zBNHWqKiEptc0fH1DFJbRYJcjTx3wIvFOHdta0tI+gO9uW9+WYqe9dYktk/6kytGljH4+cF5EwjnaD6aH15Zsag2L7CBfT6qIaQZQLUxkGjkZxUPIGVnkLi0zOtiWsnsY+f0ayl/Ec+f8SULSq0rE27+13w4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775735850; c=relaxed/simple;
	bh=yaQp6g7Shh/JLqU14xotXRrAGQjdLV/0EPFsLaIq2yM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=STXtI3rEzBuWrbn9MdFVkuNmVzT45oYdr96kxLtBf0TNX/elOO8MW2MQgXRdh4Azj+VynWjCFVaHz/qe2XkzeTCHgxvE58cHS1Fw5g1VUW96YRJY/Nd5quxNzrr7FtwErPRMO8s4JFi/dsfgK09m238UvZpWH2rufnBPjvbYORc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tHzZu8Uj; arc=fail smtp.client-ip=40.93.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfR6IJ+W9nxZwnF+LSGXSF9Wog0MjC+ovZ2ZOPZIyICG1jvzAMOUbvvEGqIVcJvDJP8TjmafRN6P00458k+Uoyx/2wSckG/66oQgAR55g0pQuBNPj6wsfTfaY4mUd3cDeGFUtIQUN5L85fKSl/7t1RaJZKMrOTmX516OgKNtt8Qugnc3YYp5qD1UW1NF+S939ZbEbeuG+E8ZxdxmWZvzXt1rTO2KwHbmCHlWSD9ooFBbzW3E7W5BzjV4fLPim1uXzBMTEwi2NghHbhqDAxwNh53RLxBLFr0l1Aj1lmCZf6KlSeCO64ia7feKLkMyPOMfSs5doBE76fzLzY+VoGyqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQ1n/r6MHMSNsWrbdVlqyYjoFoo0PS3BO8JFq+I6F6o=;
 b=QK56NGOOmUYhswc7owjhPP8hrP3ashnZ3yMcTFsARK7nbjbBff9iWDkTMjjaRkK3uNrl4HhCw3kMWeZlrzMm9UorzylRhgpodlmlyz9E1k3RKi0p/2X634xVBL9g4ui3PVUQB3mNTsuGrQVQtEWyJIwGUXFvDjtMjtoJ+jCi8jMEv2Ip/iuz05NeuIOiZffCnEVXby3cj8ELxudumNhxrAeZHFtWJ5pfiUKwChyskUO3aZJdgqrJoL+NIVCp3ybdL6AzInH/I8EHXVxd5PGG8+1Gh7oKeeTRTYr6YkPWLW1vD7sOK5TtufiBdr/Nfm45wRvH1yX4Eq8YnDtxXgJtGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQ1n/r6MHMSNsWrbdVlqyYjoFoo0PS3BO8JFq+I6F6o=;
 b=tHzZu8UjIxzXguN5JE/VvB72vP49/Dogpr95C0fpvPS13demY/d94I2GPsk+rRuofRj8KMcVKRp94cdC6zulDoYYOUzS4r9tDsWqWx3sO1yY/Xzf3ESHY9Thx7tI8MSUTy/7lGy0uK6oJZMknI+weBnKSauEVZQ3qW6TZGllRMC53tzKLch9Bc+5AiuutrWba8SRmXvdR9lYAqhD0FCagXY3WBNI4MuI1t0UfcOfSqxaCnFvQKlWNxV0ksVQzowrdRLBbmCmZy/t2gMP55rreNzw1dqA/CP8wagqs8BNSrHl7foKVqQkbFti4bUD+LMlSJKU2ZQWwwzN7nFDM/KU+A==
Received: from CH5P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::21)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 9 Apr
 2026 11:57:24 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::db) by CH5P223CA0016.outlook.office365.com
 (2603:10b6:610:1f3::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.40 via Frontend Transport; Thu,
 9 Apr 2026 11:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 9 Apr 2026 11:57:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:57:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 9 Apr 2026 04:57:06 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:57:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Edward Srouji
	<edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Simon Horman
	<horms@kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Kees Cook
	<kees@kernel.org>, Patrisious Haddad <phaddad@nvidia.com>, Gerd Bayer
	<gbayer@linux.ibm.com>, Parav Pandit <parav@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 6/7] net/mlx5: E-switch, load reps via work queue after registration
Date: Thu, 9 Apr 2026 14:55:49 +0300
Message-ID: <20260409115550.156419-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260409115550.156419-1-tariqt@nvidia.com>
References: <20260409115550.156419-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 4290c490-ced7-46cb-f777-08de962f29d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MOAB0KhHweDzXf634Cfn96U3UmvpAG4bfRt6xHAr8CV6ubQeiZ2B+7TB6V9OgdqAOJXvojgfHjnGa08bygKjKwjpDJtIncfEddnD8NSsTgajzMLwiokNhFyOUahUVeV4c8ugGiVkOa+jFN/GunR7MZigMO7/escZPOm6seSIB01llZY3gJ9FOAntK+5bhXDdkV+ZuZx+fe51qDagHsFzHaoHMjMPbe+OVmrMjUA7UmnuWPZfyrZFL16Ve6OXoppcgrdtqhWmhlEfR/JIsA+LWknPp/Yl79oCJmf8INtR9B0Axj/mmQSCZZ8XTsFGqMeQ7zw4m6MwFYJQEXXc6TN85bwE6pz4DQJM4YxnBoAFJq5MGy7siJp47EF0y6Qn0sslFo0itnMZrebKTczIoy4Tgz+AR9ifHwesi7KxDf7OBUkjQrGyVUhlhmexwXM4m2dpi2heiRTZKpIBJFVrbM9dAR84yyST9LUKfzg28+Zhy0/lckytGSrxK5wZx+vyy7mq9VFyMZL9yK+5UTH4Pe9ogZQLaqON/kopzFbec/sZTvoBLm7QmUDwQDLWhBj8wKgy8iTSa6ACORbgJhFKqOsRKERl/Ustgw2xdC7jz4+EHEC8hdVUgu1RxJGWg0DpXj24yyjmwfzl0/Vu1wwOlab4iiExRAUjy3fITqphUadx6elVEoVb1JNDU3W2PeBExEB9IGXPP9X6x+V37zqruUc70k9UxLheophyVGbXF+JxzEK2yWuodHLgu7sPhPJs+ieT6Joe4xAHYmxB4vO4hoNP6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TKws6GUr6NXodz7HWeaYiRkPdQfESnEn+AZsFpiUk+sA4JOGCYvxn8B59GpNm2fGA8rcQ4LQPMEldBkSSPH+1ydjCJZKvnYmzdX9P+GbMfW99mtJ/9WA4nUPVKRSrylJy5r89w9L8rSbx5Xghny3rd72qVg/wvaqbp0P3cV08reL/l7mWpK0Fuwm1x65elAYgQepef3zn7tLqMurfGpB9ckvXJlbDBKC1i27ohvG++iegYO90bLIalQJ8qTIpXNhEDxhHxviZEhQeIkGLl/v1dShG5cAt3vk3gGvrZWU199CrT2Bm3SBbMg/sgLkp7EOVirB3yPi5YkfPKBtyYajU7wwdcES0bMUI119xYQD9//D796r5XQdxoOcqhrutz0l8UTNuoYovT4aUtyYLNT17MDHmcfFCWpjGfTUqNAM/6VFLLU+xv1l3yuh/trUHphX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 11:57:24.0847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4290c490-ced7-46cb-f777-08de962f29d0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	TAGGED_FROM(0.00)[bounces-19156-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B96B83CA0D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Mark Bloch <mbloch@nvidia.com>

mlx5_eswitch_register_vport_reps() merely sets the callbacks. The actual
representor load/unload requires devlink locking and shouldn’t run from
the registration context. Queue a work that acquires the devlink lock,
loads all relevant reps. This lets load happen where the needed locks
can be taken.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 4b626ffcfa8e..279490c0074c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4535,6 +4535,38 @@ mlx5_eswitch_register_vport_reps_blocked(struct mlx5_eswitch *esw,
 	}
 }
 
+static void mlx5_eswitch_reload_reps_blocked(struct mlx5_eswitch *esw)
+{
+	struct mlx5_vport *vport;
+	unsigned long i;
+
+	if (esw->mode != MLX5_ESWITCH_OFFLOADS)
+		return;
+
+	if (mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK))
+		return;
+
+	mlx5_esw_for_each_vport(esw, i, vport) {
+		if (!vport)
+			continue;
+		if (!vport->enabled)
+			continue;
+		if (vport->vport == MLX5_VPORT_UPLINK)
+			continue;
+		if (!mlx5_eswitch_vport_has_rep(esw, vport->vport))
+			continue;
+
+		mlx5_esw_offloads_rep_load(esw, vport->vport);
+	}
+}
+
+static void mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+{
+	mlx5_esw_reps_block(esw);
+	mlx5_eswitch_reload_reps_blocked(esw);
+	mlx5_esw_reps_unblock(esw);
+}
+
 void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
 				      const struct mlx5_eswitch_rep_ops *ops,
 				      u8 rep_type)
@@ -4542,6 +4574,8 @@ void mlx5_eswitch_register_vport_reps(struct mlx5_eswitch *esw,
 	mlx5_esw_reps_block(esw);
 	mlx5_eswitch_register_vport_reps_blocked(esw, ops, rep_type);
 	mlx5_esw_reps_unblock(esw);
+
+	mlx5_esw_add_work(esw, mlx5_eswitch_reload_reps);
 }
 EXPORT_SYMBOL(mlx5_eswitch_register_vport_reps);
 
-- 
2.44.0


