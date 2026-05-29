Return-Path: <linux-rdma+bounces-21479-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF7bJ18jGWqVqwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21479-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:25:51 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C85FD55B
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 07:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F20E30BD8BB
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 05:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900213A1691;
	Fri, 29 May 2026 05:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MQ6eKCJH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFDF32AAAB;
	Fri, 29 May 2026 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032306; cv=fail; b=BqoFoUjuNAudvbhN7+SfE072uOPAKwUKWqVUvSnEGwfSwG0MNZ4ka1sGME2W8KcxRjeK+xPGr3V8YIdMCn0xNL29taRtNyzQTcNrIUeQptbEqd6yt27mOW0iNYC9au2gyTF9/2da35ttSAifMC3QjIrloEvn4diBDLQl3FUYc/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032306; c=relaxed/simple;
	bh=9MpMVQwBPA2ZOuYV1VW/gWqcmqeDSYm7HuXNPXveFdk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mz5zIZpWxJwkFRHM1MFwjjHULC0zs676rdmPB3fBFB11yQg/Qk+qXIl07CIhXAPLKEtvK5GuNf3TvcQ2rLlxoXd/7fWw3TOMCb3JNItyrN6cg+IMAFzOI0sQv0tKlCC8DVTxGJQYfanymdX9Y4+Ll+3BY8m3CK8SRZkUVqE70PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MQ6eKCJH; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw/aXSwcxaFVtNU0X7TbzZx46p7ZLZvOzG7yUsjOoQJfKrULpo0GF+Zxdj+vWQtSKQNdvKAnGhLBuap6brU5A+iDIYn9f7KkZVoY/iLmODOcCKhTNSsBDT45TVrHmFdV+HXyGq3CqAh1GniS3qDDCTLXFjZMwclebIH2/rz1w/1QRh6zWf0O6z+0z05tljJ2PTlqr598nzc4YJR6avtJfgWZ3u9CLR0mytYFWxaZ+FXc3UOCa7lh4aRJ4k+XSYDSeGezEcUF7Jqfsc0uFo5yfdEVraU+fMxzyeqnmeHNpgAGGgc3HVdkT39Opscl56BZIDaWlwJLaX5GLXPEJb5B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgUkqSlK/5VpOgkDcXb/AW9fx0i9glpOtksaQoHJkbc=;
 b=xcsI2cczpRKrbkRqQL+mac8eKU74aHoPKhyq9nuKSN3Bdg4ROFl74lLGKaOxRQDJIhap41f2av03xub4aJqmYkNhEeBs8KygiW504D4EDgyEcb0bxzSX/Aqy+S4nnnJ83FUnAqFhZXu3SAbesGIsNmcx9P2/FD2pMOdFToh2q7xrcZYOt74/aXhYt+JGD+/F/nZcx4qYAXvwmyoWDU8yAUZsf3zDG/qTV5BpkxHmC1nDkIF2Er+3Ef/9POT+C4Bdw4dvsSFsp3YT9X6w5fm2MjQMxLLTVx068AzJqL9HDzZfgy0WZqfgzNdiv9Tc5hbHSCdwbp8qL8rTOzz2cXWmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgUkqSlK/5VpOgkDcXb/AW9fx0i9glpOtksaQoHJkbc=;
 b=MQ6eKCJHUVw2SDn+ytWYO35OmWAmiiOzixoO36AqU1D1L128SePynGhdsISE8Lm6FBTpKEmfjtIdpYNYNk7wLyxkTSa01BLVMTybb5FOTUJOCsC+wMKUAA3GUT+v9NkNsMSopgFZ4QSuyN4CAe+NONT5ruAxPX3FIW3UinSC28cfVTpTSAvIeRCwPanPZJOVhczonC2lTPppB0Kiz2rkur1uudbxBdi4lIwFksUXNh/hysMk4fR8ZkL+Gvrx/VLrZ1ajuxQO0XmycxoH5qsGV4F+A5YE1rluyjLxaz+ITNLKd0X2A3Kf/xRk9HLcNrkynloI2XlYa49S7MQBFVPtpg==
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 05:24:59 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::4b) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 05:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 05:24:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 22:24:42 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 28 May
 2026 22:24:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 28
 May 2026 22:24:38 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
Subject: [PATCH mlx5-next 2/2] net/mlx5: Add sd_group_size bits for SD management
Date: Fri, 29 May 2026 08:23:59 +0300
Message-ID: <20260529052359.389413-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260529052359.389413-1-tariqt@nvidia.com>
References: <20260529052359.389413-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e3b338-b076-4fc3-6308-08debd42a087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|7416014|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	B3h1By27QkCoGJmxIqaFl2HY4zLtXuNLdQukEVmWafXDUWRofWgHYvIfdT8jjrce9IbzA64g2tqra4NVFtKHsLeSyx7ixsVQLsCrChR/O5GUXUdzCQ2RiPDOUlg35zpI+BLgpNDlU0dfp1dLl0hdkl699MoBfa7RedKyHPWxHXlpBQCsR8zi0Bl8n9JTzsDVl1VN6sF0QipWGnZLklq0E57lisiEJ4wh9lS6hR8TSDGei7iTLz0KhaauhnWvkMv7cFfayxsIzfnchCjfUsaQAaKk1uZOdpAI5rmdocQICnYkod8PxuTIdIegpI8LKZ88szJ+N4P472l1ZLAr3LmFgtIlcBOCIqIwfnx1t8nmuHuOChRCZWccNuKKJEsIE6QVWSgBhfo2AJYmI+KRcP8y+XfpZeKrYnMSE+KQRXDMsGyG5GydZtKrIgVWvETM19KwGyGx3xtsZ42GtMDF6HlzIJgHwtL5zeuedG7kcrJ5OflJtZSwvdLMWiCN8Vfd8oZjlvsTFdgkuXyKzcDard8vQrgSiCN3NWZcueIyy8TgFHTLKm7Lr4qQfkfooykQska66qdWC42BGHSBARRTFrCv9QmdK/He8ujFZkkQ3Ly7b/2I1dgMYaf6U3RtMs20/SjSdt11gG1WHr1YJIS1RKCEDnIShoAy7OjuWw/HFUtKfqds6W/+B9Q2fF3Wyw5g6GgSo6lc0gG4lW0wT7e3Gef/GG6NkxVLspNsdpbNvS+vm6s=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7416014)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7nPmhr3yJBZDoHFLEGUFrMt1diRTD2L8//8G5J4BtvhFRhAKnGnB2/+1EMTZCqDdnZY9FSpx0xyMm+LWQ46k7+DelVAvA6sJyEG+RtoX8hoKK2qbYUESK67QxW0cDFFxkzXsxvny7mJFESNWTT72KKJFEmZQ1HFs5V9AicPBjk1wkAnog5JkUDuecM8J9EJVo1DvpKzmcbZEyLr+OorAOA4iRViTNzQbXp8Es+RKjKqijymw00ZD5zJ91798yLEcffcBU0T3aZk6tEYVuQyLJvnUaT7SAyrA+7Eh8BAKC1CVmdWSAzGiXoFyfcJXFGV9WKei9n0qKI9+NZrzC/2hkLll2AQCKDSLLL4PoGEbR2FiMpcgEK1+wzUBPSlibIvG8VVUj0KQU3pjCpLdlBX1c+/7Gxh4+w5wsmlq/oRuQr8yzL5HG8HbFnfu1VjI+IOF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 05:24:59.0567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e3b338-b076-4fc3-6308-08debd42a087
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21479-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: F33C85FD55B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Shay Drory <shayd@nvidia.com>

Currently, mlx5 is querying the MPIR register to get the number of PFs
that should comprise the SD group.
However, this register does not reflect the correct number in complex
deployments. Hence, add an sd_group_size field to nic_vport_context to
determine the correct number of PFs, and add an sd_group_size capability
bit to indicate whether FW supports it.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index d23332cdd9b3..4f59b7e8a3d5 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1986,7 +1986,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         basic_cyclic_rcv_wqe[0x1];
 	u8         reserved_at_381[0x2];
 	u8         log_max_rmp[0x5];
-	u8         reserved_at_388[0x3];
+	u8         sd_group_size[0x1];
+	u8         reserved_at_389[0x2];
 	u8         log_max_rqt[0x5];
 	u8         reserved_at_390[0x3];
 	u8         log_max_rqt_size[0x5];
@@ -4469,7 +4470,9 @@ struct mlx5_ifc_nic_vport_context_bits {
 
 	u8	   reserved_at_100[0x1];
 	u8         sd_group[0x3];
-	u8	   reserved_at_104[0x1c];
+	u8	   reserved_at_104[0x4];
+	u8	   sd_group_size[0x8];
+	u8	   reserved_at_110[0x10];
 
 	u8	   reserved_at_120[0x10];
 	u8         mtu[0x10];
-- 
2.44.0


