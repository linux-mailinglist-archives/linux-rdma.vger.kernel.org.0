Return-Path: <linux-rdma+bounces-16053-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +M90MUp9eGkFqQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16053-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:54:34 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C8591533
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 09:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADEEA304BC1C
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD786328611;
	Tue, 27 Jan 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFsGS/h2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A62FD691;
	Tue, 27 Jan 2026 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504045; cv=fail; b=CgQS3f0nwlSTYv0AFvInsHNzhjamYk7u5IHoyU0Mbhfxl1WIfnTpdKuNoHYICpAftq5V1ehKHcYQXigCDRM6IR22GeqaYOlZqGyNAMbEf3gDF2ENeVcZC2Yx40Oz9BbHsVRqH2NSXB5g81v2i5FRGe4YPdX2DRZzdBLa3chCyVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504045; c=relaxed/simple;
	bh=s5pCExdze6GQSlBOf4Dvw9JS2H06tfajyQdxQmn7jRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZQD8vSfFqvnzSJTLnn2y0QCl6zFyzDvO694BjZ2skHrCeivSQ+B1qLDR/y0PA04ytzJNq1joyF2FOHqrXhv+SLQLLJvIu0Mp2xBIsQWDawijiLRoxFB9SZoEUbvWdrOJ+qrObiqiCPSRKwNuiPiDsg7pbUNy3/fDmaxBe2vr7as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFsGS/h2; arc=fail smtp.client-ip=52.101.62.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz/LYqytYYlWCSOqB2M3I0/6LSpvWZVu8RK6ja8Rq5Yr7/mt6SqJ1lkfrAeNpJi/8+hK6bPBrZp29mKfsxaiPRopDGdubdds1H6pPRxVai+XnQQRLjBSnV5rfKyJJDdOL9aklWuA+3kTeE+9Fq/cZHGdm2V3lltxdiVC/RiTIJkEcav1m5S6iJTG9xlMHNCKafl73H1kQlqnB3Pk/DwhOwfYr+TdjQv7VhuoIvFH9IdWDHXWfGEJorOouXG3mwJgxvkzDYVzCR8W5LXhlohJzSaR34EYneN2wnFqHY4Lkk1szGwS7HwaHHsVBk1yIwW73WAbR7ny7AP4P2q5onsd5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lnce6PEkkoRV/Z6rz8FsVnKjH9FnzRxO+ka0pP3oYhk=;
 b=hmoDc5M+XkVEIGBdIqCa1tIKSLCOZfAjjTxJmQaQWqOMl/kaZQhw6NWLfnhfA3bJqCRoeGwQZ7bmQf4NAcVDfMXv5MIpVvmP/yTF3CvyJqQIjbDkfioCBVdODLOddK1ZHs6lcVi0cZ9+Vvm8oVCSCfgTyF6DJ+aaK7ABwDxdOaMyedADXYPUmdL+g0juWQ9kngy846GOYbLJ7BNs8DRsPA5mBtVKNpQubyNwqFyozKy5pe4k6Y4k2FyaReQJbbq0/+8dioPZaoYV6RaUp7oQCl1rUajWg2jVwSee2tOoBW5jvahEpql44T/gTs/+Qc7EcsCubt7jt6EoGefJW6MvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lnce6PEkkoRV/Z6rz8FsVnKjH9FnzRxO+ka0pP3oYhk=;
 b=cFsGS/h2heTUN0BCYZEVfrD09cnfbsA4G7mdP3sWI83ASaLsddLtCMqh5G9psGM7RyIepvnb2rfHLYXU/4WQB3IjaWy68Vd5AjNUPymqQVSskEW/VzbXIhPiB3vvrWChW61fGwJtMc/+qSebcNpTbj3HjLnl7Dx0ET4TVlu3ou4SV9guFjgpYht2J3PAknQy/WZ1/ax+E7rreUJfNBWqckD5JNpNUqAwD8m7eRA9xIkOV4c7sF5p/dhE+Pn9VjMWcu/OhNL1mWvFug3vtKywZoRrJRnKbJ9ANlT9AksiZOP5FJ07e3rCsIuPOQEvGEbwqKvsB0EiQs7a5hUmdEKGwA==
Received: from CH3P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::9)
 by LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 08:53:59 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::44) by CH3P221CA0007.outlook.office365.com
 (2603:10b6:610:1e7::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 08:54:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 08:53:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:45 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 00:53:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 27
 Jan 2026 00:53:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Simon Horman <horms@kernel.org>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net V2 4/4] net/mlx5e: Skip ESN replay window setup for IPsec crypto offload
Date: Tue, 27 Jan 2026 10:52:41 +0200
Message-ID: <1769503961-124173-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
References: <1769503961-124173-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|LV8PR12MB9620:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acc08d0-b5df-420d-2d41-08de5d819cc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pUh07Q/g0jgKmh4HGsvspisni+FnXGkpJDB7faJ+zNjOPWI3d2pzZrfdYNAA?=
 =?us-ascii?Q?fViTL0VmfQ2FfPiOpAojjU5zctYNEdxf83zurtG82ep6r7LzxOicBkukZc5W?=
 =?us-ascii?Q?DMtuwsJ3BJgxToLPRtUQ8+hGsA5C87A0H2l46+1rZPRMu7o47p1X0Xd5xy6B?=
 =?us-ascii?Q?hc8DB1TjsOVpS+C7w2MLKLLffJonGLcgQ7r6XlCMsSgMB1uT7QC/3E2dxTjn?=
 =?us-ascii?Q?9tTHWUa5S7s3JlYsCfPyRZA1jVFSc0EYP874KTYgTITsW3QzcwH43MEMb8AP?=
 =?us-ascii?Q?8GrwgCdzSlzj7AU+peDJ8LRfL50VoDwWWUe6H7LVASsv3tsBNQGD9rQIaEGO?=
 =?us-ascii?Q?3SrUohcgP+3MHV38tgUsr9WzcMjIQA7A7ec8ii3kJ2+aURUnIP+btb2aRMFE?=
 =?us-ascii?Q?hyjzDNhuSeDQ7NUI3jrDnHRlVYtwERkRfjVe6I/H+a8ANBgkirFD+uAJTT1b?=
 =?us-ascii?Q?/UXLEhrc/gfSDVo7WO2AJIK4RIvd5u9Ipi+BzbNvWMWmHCaYwHHnBQ4LYefE?=
 =?us-ascii?Q?8cysojkeH5TVmUM18TD5JenGz5vak0lrSo2fWAyJZ4B1r3zhrEPpaRxddmpT?=
 =?us-ascii?Q?L1bQIzvKhQePJVKsKydiVStdR8q9/lbBEea3ibYQKGYECTpeKLgwz+BvkDXm?=
 =?us-ascii?Q?DLUrlyTh6m2Ov8nZi2ARir/w/O0npHXz4AabttORxvDue47UsOzRoYL1dIP5?=
 =?us-ascii?Q?1hLnOxRqV1mZ7W/wuoowj9DScRMowMyLClunnV/g7imG8SnwyVn5OXRREsGU?=
 =?us-ascii?Q?cy4Yo9goAom4hGvuBtxZoxc58sQhacuiIvOm3tpv52A04XSAZiR1VIz8GZM5?=
 =?us-ascii?Q?NOvfhs4nIID5QTK1+cNErwHFgnsf0LZRqJEh+asjIUtb0w+U5upsMEbSM4i4?=
 =?us-ascii?Q?n2x04K2VT1K9CV2Cy1NvegBNiltFy7n9zL4iQgTrgB+DIwUjFNOIV7RpnP5D?=
 =?us-ascii?Q?Ox4Mo++5LwfkufYRUhFBcxT0eKit3Fub1NzgkCY3o4LqfkWm/yog6jQd2hwl?=
 =?us-ascii?Q?npT2fVyTt6UF/kyD25IlHeSW4jfovRQjp6aautabgmH7j7LjCHqUdGTocba9?=
 =?us-ascii?Q?PZecFHOpOG3XReaEJ+L810psswZFzKMParL5FcyA06tSq1llM8AODCRB6ks8?=
 =?us-ascii?Q?9TzTIvskVYr4xi2jxP6CwLAbOONGZdvJfvFDFTeNurOgm1KAqm+TCqdUWIVb?=
 =?us-ascii?Q?B4rUND29XGqAnSnqlQq9gic3J30BoZZAyPW0Rqoo1bK0UFyRRi2GPZRr/fvc?=
 =?us-ascii?Q?rtqQOCxb1WWWd+lLQtEV4jf4J47E14UvkrF0IkPHk8xuxCeNNoXkqIq47KAf?=
 =?us-ascii?Q?vuMbjgbvqO6QKJSHKNeGx6Lyxi7eOeQ5gr9siYAWP4UN5O5PiMp+J9wyKpmu?=
 =?us-ascii?Q?qXVadO+djmBzBHYWrLTaGV988kt00f2r14LqOFj39XnAuGE5kOQUAu+JP6Ad?=
 =?us-ascii?Q?qVLuubMoee/wvVuQp5C8BF6yiw0q+9N2un/f2UHo7Z4DK7TaFWVnCcSIUwO9?=
 =?us-ascii?Q?X1+H0Yh1Y8kOlKTGlOP++bxuqLBP7rdTBviCXErM3+BocntLDxARxXmOp6oi?=
 =?us-ascii?Q?de+C+bWvAzvpu9+xvA0JyDFmKi3fgbjnDtQoRlrps5kYc8dgle9dQ2OpEMYP?=
 =?us-ascii?Q?8ohu3LEf0vvIRgURbY2I6cQU3o9lb541jg3AZTGLQridBDVal6+tCYUMRJUX?=
 =?us-ascii?Q?+uavpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 08:53:59.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acc08d0-b5df-420d-2d41-08de5d819cc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9620
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16053-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 43C8591533
X-Rspamd-Action: no action

From: Jianbo Liu <jianbol@nvidia.com>

Commit a5e400a985df ("net/mlx5e: Honor user choice of IPsec replay
window size") introduced logic to setup the ESN replay window size.
This logic is only valid for packet offload.

However, the check to skip this block only covered outbound offloads.
It was not skipped for crypto offload, causing it to fall through to
the new switch statement and trigger its WARN_ON default case (for
instance, if a window larger than 256 bits was configured).

Fix this by amending the condition to also skip the replay window
setup if the offload type is not XFRM_DEV_OFFLOAD_PACKET.

Fixes: a5e400a985df ("net/mlx5e: Honor user choice of IPsec replay window size")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
index a8fb4bec369c..9c7064187ed0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
@@ -430,7 +430,8 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 		attrs->replay_esn.esn = sa_entry->esn_state.esn;
 		attrs->replay_esn.esn_msb = sa_entry->esn_state.esn_msb;
 		attrs->replay_esn.overlap = sa_entry->esn_state.overlap;
-		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT)
+		if (attrs->dir == XFRM_DEV_OFFLOAD_OUT ||
+		    x->xso.type != XFRM_DEV_OFFLOAD_PACKET)
 			goto skip_replay_window;
 
 		switch (x->replay_esn->replay_window) {
-- 
2.40.1


