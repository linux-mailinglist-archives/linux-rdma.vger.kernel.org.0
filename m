Return-Path: <linux-rdma+bounces-19885-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKUVEDKw92k1lAIAu9opvQ
	(envelope-from <linux-rdma+bounces-19885-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:29:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D073B4B74B9
	for <lists+linux-rdma@lfdr.de>; Sun, 03 May 2026 22:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E6F73024C89
	for <lists+linux-rdma@lfdr.de>; Sun,  3 May 2026 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450B137A4B8;
	Sun,  3 May 2026 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0nhtgEu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6C6377EAB;
	Sun,  3 May 2026 20:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777840088; cv=fail; b=I2LkE7r03tLoRitDa1pdQBn/DVr3E+Lkz5Si7ffnSZRbwTeybkcJv9l2azB42M4GzH9Vv++lKZ+5KGxnSKRnkmzpO1LFyD+ml+eYmr1pJTIkGYfKr26JUMQaJ81HlWn2RmCbyT6vG/Hl83VOjVo0n/xFuVhPUNu6o+dmUDaB0yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777840088; c=relaxed/simple;
	bh=Z3lhkqhRxoSeiTvzfK9o0jC64cbGIgWbG3Cx9FtypEI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxfd051WLn6p+MzyvcHhq1/7g3602WdHX/sw6mUQBF1oq+5qpUjtC/oQR7CNdsYG5NEfTqEEsw1keLfHZgzHhx42dsTxJTNnaEyXfxLWHmPvDhoQFTzU3kHqn4Qk0h+/CXyIbFUaW2CsAi/75q7rsiNyhLdklY65MbZKgcd0mgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M0nhtgEu; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teuM6+KDbL8OHTATHjeKwzvAp8PowrHnADnjtBua9G2dn6v+tq4/v2kSdwh1edBwx4en2vnaZfXZtr+kwX7IMUZdC3hAw/RrpGATNTZnT1wFcgPERXLsjTn3kJDFLyrf+WVGo3kOkpbkYTRC2WEuJebgd7nZygteNB4nvzxl/20CuPmeqz7iX1rjvoH90HRuRnvwPh8/PdZBTU5Shvo8sz26Cv2OfMWmzbtMSmwnLkDOPNQaOdBQjRSDnmAfQZTuXwZe5YbvNKS6gnFH8OWQVCVg2P4+K8jdKNxVzGnx45LKT+BCAuyNqbtPdgLZVTJhvXWcjnldCn6BH7GyjsF7ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIXjnmdsghQ5BlUHvzIQvBG3CC6KnnO86BZpufsOW+o=;
 b=A1ORGU56ux65ApDqKuAqW1e0+oDlWgXMqKOH3r4eCn51MGb0RAB990pXVmI+/xq8XNWasO4E9e4pnBOKSaCHrYTYeqkxMHsrfvW+Yd6E48svLi8mzYC3C197Ir6eQ0jeuBX6MqJSEqGVsmOAmOabpGvZdsum/9c2TyjZJqqJpIHL2oNvg76pmJk6nvq6im0gNNcDN6AMAODdwKAC03Fo692MZgTO8bil4gWZK2+B9+pImb8ZWaowacnQozUzK2svwwNPMKXbiQ4WxPbRTe1y63kAJKAVUjs/+k4niDywCCfdB8aUYA6ifR08y954Tea016dqNO1m7eaJwQTsC+AmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIXjnmdsghQ5BlUHvzIQvBG3CC6KnnO86BZpufsOW+o=;
 b=M0nhtgEuZug9oseFw9ihSf8+4GSLYR8VD7cVepa7hNkqkwDEVLO6TBQHyom7KNxyPhsd3EyMX4bjv9TpPsInkqjgDety959JNJamEhxmCz7QZWvFK2Kizp7+h8nhpYsbEwK5k0gmvUdrsOXUFI0LVXZNn/kpw197UnvZ0b8e7iHQaHgnNxWNI+nBORbytVfWM2gBOlyr/Kv3AS5AIciB0Sy5uCwUXKhfFVXviuQ7bcT9sLMZMOUF7lm4K1f4ijBoEz81TQST4maTuTPu+5A4X82NsdLkQMOu38DIZ1zIh+RWwZMxYmXkVZZFWCL7ZpXVcLTqc3ODeY44T9gfqF339w==
Received: from BL1PR13CA0346.namprd13.prod.outlook.com (2603:10b6:208:2c6::21)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 20:28:02 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:208:2c6:cafe::e7) by BL1PR13CA0346.outlook.office365.com
 (2603:10b6:208:2c6::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.13 via Frontend Transport; Sun,
 3 May 2026 20:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Sun, 3 May 2026 20:28:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 3 May
 2026 13:28:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 3 May 2026 13:28:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 3 May 2026 13:27:54 -0700
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
Subject: [PATCH net-next V3 2/7] net/mlx5: E-Switch, let esw work callers choose GFP flags
Date: Sun, 3 May 2026 23:27:21 +0300
Message-ID: <20260503202726.266415-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: d40511c2-dcbe-4120-e060-08dea9527938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	7oVjMYdjvnDeThwOxkwC//xEbX59MpBZ/J9P1566/wvimfkppqappsPvy/dfEK6ttU2s2I/1hf31HR3rboVnbvzfoiKgWO8RbZCzA756D8M5IL5Knm5I46uueObnfQAykRY/sM4A3ekHNxf2ZGEiyjzEsrVOs7dHBG6X/RukLLEPG6kgyziKLbR/LAC1HcnApKLS5wtVm9YUDCeB94Z42b1bNH0wA7hIUW8QwmJI2Ys0g7+5ndHxa55VHKQEaNMALJwHEVaJrui3Ceola5zLOsmxBd4TuscvpVvDoByszL1Cn8ql7se+2uzGsSpNRo2Es5urhkxJuWw+64HCCxb60zRNn+hDbHwo9K2K082bM5QOBRTQeOjaJOhYS/MRk/qY78bZQV75q8/kn4pXcMOKqXqgnPp2AZyGkjjuY084ZDGvI2X/QKZ5/PY0bfPUxUzweM7s2wYoPpeWHBjtq4f8UubSsiEaGqhmS/IgcnEi4SCYsQ5/qUC7yOJfevcLmOeQepdU8JRXJGYR6HBjDvei30PVgrA6n4LSSeEx+hqWiO1w9p5ljJmEZWslit97bXOWN/sAZyZKTIoKsoRkYn6iwinhQjd8GuUOgWGzz3zYonSNc9tDUvFZ1kK9loxxo0+rikIigtFE6779N0mf1BDXVxHsof9Ee79dqYp6z7kFkAyYcuIfjvGkD6528ToF145UpePfJxdzB6y7ly2c0lsP4qjDS2dAl64E4irc/gmaeeY=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JPjvWHLeN06C7v0TWlw8U7uwpjd+uApxKXnTaw8Gap2JQnhvlq54UPdFirKF+VxzoLFYaT4jc8vAxe3N2bgj7QTnVKL8kJvcvIgxSprtbYMsiaQm8ehzZIw/cgcGdE1Rf0QN5KewJgRHGnR1YIEyOy4lK5ZHi8i5wJoU5uyVbfobMwCMfW4Ad1OBZT+VV1/fMGpFDByilGcITLSfEmXDlbEOf2j5vSdtrzd7SNVRtz2i2AXgXj5dhJCTsH6CLXTAFW5KxTj6v66DvJmZ7o8Yr7H2nlavfaK/rsmfbA1hnXSj9drek8mQdnQXyjuI9B3buk8tH5jQntJ1J9NVmcWoeUAmmeTc/zVOAq5bKLdh+bx21vlK5r7BEpbPlPVDeNVGxSkQbX1OekeEQ1+sQLGfm3inRIFRkWqx/9QcymVWUSdnr91U0W9aaetUcnuNH6qJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:28:01.7441
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40511c2-dcbe-4120-e060-08dea9527938
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
X-Rspamd-Queue-Id: D073B4B74B9
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
	TAGGED_FROM(0.00)[bounces-19885-lists,linux-rdma=lfdr.de];
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

mlx5_esw_add_work() always allocates the queued work item with
GFP_ATOMIC. That is required for the E-Switch functions-change notifier,
but not every caller of this helper will run from atomic context.

Pass an allocation flag to mlx5_esw_add_work() and keep the notifier
caller using GFP_ATOMIC. This allows sleepable callers to use GFP_KERNEL
instead of unnecessarily relying on atomic reserves.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c    | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 69ddf56e2fc9..69134ce2a908 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3736,11 +3736,12 @@ static void esw_wq_handler(struct work_struct *work)
 }
 
 static int mlx5_esw_add_work(struct mlx5_eswitch *esw,
-			     void (*func)(struct mlx5_eswitch *esw))
+			     void (*func)(struct mlx5_eswitch *esw),
+			     gfp_t gfp)
 {
 	struct mlx5_host_work *host_work;
 
-	host_work = kzalloc_obj(*host_work, GFP_ATOMIC);
+	host_work = kzalloc_obj(*host_work, gfp);
 	if (!host_work)
 		return -ENOMEM;
 
@@ -3764,7 +3765,8 @@ int mlx5_esw_funcs_changed_handler(struct notifier_block *nb,
 	esw_funcs = mlx5_nb_cof(nb, struct mlx5_esw_functions, nb);
 	esw = container_of(esw_funcs, struct mlx5_eswitch, esw_funcs);
 
-	ret = mlx5_esw_add_work(esw, esw_vfs_changed_event_handler);
+	ret = mlx5_esw_add_work(esw, esw_vfs_changed_event_handler,
+				GFP_ATOMIC);
 	if (ret)
 		return NOTIFY_DONE;
 
-- 
2.44.0


