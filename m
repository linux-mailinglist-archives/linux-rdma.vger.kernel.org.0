Return-Path: <linux-rdma+bounces-18397-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAA6IM/qu2kKqQIAu9opvQ
	(envelope-from <linux-rdma+bounces-18397-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 13:23:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B122CB1D8
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 75BA9302E771
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 12:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8733CF68D;
	Thu, 19 Mar 2026 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NIcw2bxr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012009.outbound.protection.outlook.com [52.101.43.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDB3CE490;
	Thu, 19 Mar 2026 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773922991; cv=fail; b=CekA2o/LtuQey0tVkMdkk2NOV4MRGPNAhxZLi/hrc3Qmkl13lleLHIYN4wzngpyqEFo8bP1fm1hTQ7fZPfe2IlmZ08Z3vJ5LmSR/OD/Kaz10m6FoTn+YJBrbGUOYWJKnU6RKNY5q/TkXp5/GyZy1iAdjNYxTsIBgZM20l9HTMHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773922991; c=relaxed/simple;
	bh=5Yswlnp1eliAfbx4nYrLFGY5/1mPEIrKkhEAg2axIe0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtYxYB3R4nHFxc7s/syRK2VYKUADuUtMdMFsfA8EKBhi3dbvexXYQRa5INNBNFQdj2dfiguQrbFFxxa12fs/mdSrWzGN5Ttd/4MXIYRNFBLg93NpBKifqT+pd9Kg8UtnmcJbRJT2DbjwK+ae+pBwIrjhyVrsnhlkbn24FyTomkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NIcw2bxr; arc=fail smtp.client-ip=52.101.43.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ijp0kkUO9bhn0hT7Q6XMBZOQ7+i6JXff/779C5TQbNhA1BrFyRg7QGJjDNa0feOxtKHusGdXlTMSTmWAs5wfHJw4JlDHya4Qz2BR39vPHvfq+sX4DQoVlSj+KqCpJGh3dsuz6fD9BT2fDT97mxsf/0Xl8tJGGjeqGWuHaGUJOAI17EM8P9irUqMqe2NVOX0BPkE0CxPDLG4LlfoSHQ08UzXREC+HRlXOly1AAom1sQOGVKxJPaInkcNYbD/UyMiPv/xOkP6I1Z9itotcn0S9U3qcc58e1cVRk4xs+Th7tSmF7el8jiucAx2zf4aHKsmlkig3t3xRGKB2w5LeYfLokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b31kQTQkEzS0pTFl5/yp5sBN0lHXrSXY3Bvaho40s4M=;
 b=VB+AUs+CQDRoj8frjO4UF4Qdt2hxR9qrMueuRcsdumliO2BbsdM1SWSUPKa+6PvDL22mNrqDkH9NaVqhQz3C/rvROM57Po36wNEBt0/rU9kHbcu8oK2dQN/+hLSXA/QcT3AH1qOzS/GqSnyXfNbIQoUAY8X+zf5sCOhZQvjFPXNhwYw322tteBQyyogIVtQH7gzuuD2XQHgxwFuwQIEZD0Xk/7P2J86M1IkCxZdCOMbRNl1qUK2rfEFu1Ctxg6BosC0M7Gczpuqo3oZ4KxIMy2TwmTIhvVY/3s2kbRYLYSDEOaf2aBTvD41zNsCW3uC4DYm9ptb2lSxysrtFEpGNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b31kQTQkEzS0pTFl5/yp5sBN0lHXrSXY3Bvaho40s4M=;
 b=NIcw2bxrBeyDZLg8yzjtPWFb+Sokb9yl9mSEETOMkgrv+zTtSRDq8VOw9z39IMDUOOa+McHU4CQpOgREjF0koVplbiDIQOdQjwIt7H72X5kzxTKgc8VKcJVFStLlYAhVGlqAVBHsUZf92BGqBPusUTReuciU1bXe9R9YwkzRkgyEc8yH/vDIfNvFv2x0hYwpCAaAH4F+Bk1fShK/HU+vxOrrNBUyIKaISxa8H2r9gGvzbwMRL1Ts/ozfHn2tuxXqg+UFp2PKqvyFSdx+bURWxiUfr2136HbaH5AI7ilejd5FxFHoMJCWqA87Efh442X3cM0yZhoZM7ZF3laW/w+qxQ==
Received: from CY5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:930:3::20)
 by SA1PR12MB9472.namprd12.prod.outlook.com (2603:10b6:806:45b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Thu, 19 Mar
 2026 12:23:03 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::8b) by CY5PR20CA0020.outlook.office365.com
 (2603:10b6:930:3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend Transport; Thu,
 19 Mar 2026 12:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Thu, 19 Mar 2026 12:23:03 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 19 Mar
 2026 05:22:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 19 Mar 2026 05:22:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 19 Mar 2026 05:22:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, Simon Horman <horms@kernel.org>, Shay Drori
	<shayd@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Alexei Lazar <alazar@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH mlx5-next 2/2] net/mlx5: Add vhca_id_type bit to alias context
Date: Thu, 19 Mar 2026 14:22:11 +0200
Message-ID: <20260319122211.27384-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260319122211.27384-1-tariqt@nvidia.com>
References: <20260319122211.27384-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA1PR12MB9472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c345233-6b80-4b0f-5b8f-08de85b244bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	BnKNG4TAaIFiGf9EpIKXm9vm5oTO7NtLCA0uP33aIHZkeW55knxs9DUht/NyADpFmy1Se/dK+0EbDBy45paTm4UlCxnCQ9OF6HppVp03lVFSs/nvptGn+EATsEZkFPKquAOXLuKOapwzAU4B7CTyqnQeiYXrZX3r9H4oXHm8xwJiA0/aZbzrjOPKh+Z2sRcxWiS3LcJKI33aieww47e1HkWx6nrEzEWzIiNNnZtGsN9zEEI1/ovVTF6FvLH58kiiUZV12mb9eU+PCHEb1oczLZxBZ8eagxNhJ4uHP9Yjxr2jBy+G9Qcl9LD8x/ovOsbUR343RKrHNYaJr2i6o0EdzbHi3HGXtOQKwl6t6P9tIeLrt+gV0VL/j2gM6GNWPktxWVdbhP86t8NTFj2I6uPRtNBM98XDDBzpnBcuvGj4ctKdesB1MyENYymnwF/zXbOBfFsw/237ZtjuaTsyKZM/vpID8HhOPbj81g2a+sedAGnsMdZ+Y9gt7u11hdgbC6qbwSubbJdvfFwIScPMHIHxGU6UqPCyle2c79QRWLF/WN7BhKjVxMSF51Xw6J6zvRL1qBkoj8otiw0oMQ37u9M8CknZE1npNwFfxO/X1WMbAaO+GEFGk6dWvlTil9Ww9OUgkir9mWEXrteQxYeuKyMSI5PAxlWYCV86TKGCRNlGsavQCjTeNCchf/7ErfKzFyHdZnxBt59tVhhXdYrDR0ioon99BEz3Wf5yKiJVbjefkLI+DEHnIHSTU/h12SuhWisGdYrsYbrzccIOpqC5OcRpdA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IJ9iTUZTWQr5Kuf6TieBrEsXcQTk8O3SfKeeUSPr2bmA7FKBCDhoczsUYcCBslAuPfqv4WGiqr2HO57fVBogZdHozBv4EQyQ6NVMEogbSxdTxM1tXroVXPBChfIkVzmN7Mt+qlSaAjjkLJLbxxj4e6OlTX6F5jc0JMEmenQV/icgVvg/xOFS3+86x86uF8b9fDOB1JRlUkWgmpY9YAFCkAj12CNhEe84XHO2+GU/1RuxWYn9sf9seBUrvGLHW5XXdU08mXBHvbMmNSMqQi2wBsFLqATO6iKi1O9yXcHVIjGNPcWC42PSkVS1bLOfTZDx5zeWmw5VNPRwK/roWfAHiQluaC0ZppPoXNLXCenazqkixLECWSziZL/8DBjI4GxjD3m2uWugEU/on7GGb7PhgukutRPvFcYPSfVpIviUjO1m0XUT16Yy6xLNzi1hHxBO
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 12:23:03.5864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c345233-6b80-4b0f-5b8f-08de85b244bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9472
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18397-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.968];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 51B122CB1D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

Add vhca_id_type bit to alias context which allows indicating the
vhca_id_type to be passed at vhca_id_to_be_accessed, which can be either
HW or SW, note that SW_VHCA_ID must be used to allow alias to work
properly after migration.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 8fa4fb3d36cf..2400b4c38c77 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1968,7 +1968,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8         reserved_at_360[0x3];
 	u8         log_max_rq[0x5];
-	u8         reserved_at_368[0x3];
+	u8         ft_alias_sw_vhca_id[0x1];
+	u8         reserved_at_369[0x2];
 	u8         log_max_sq[0x5];
 	u8         reserved_at_370[0x3];
 	u8         log_max_tir[0x5];
@@ -6957,7 +6958,9 @@ struct mlx5_ifc_create_match_definer_out_bits {
 
 struct mlx5_ifc_alias_context_bits {
 	u8 vhca_id_to_be_accessed[0x10];
-	u8 reserved_at_10[0xd];
+	u8 reserved_at_10[0xb];
+	u8 vhca_id_type[0x1];
+	u8 reserved_at_1c[0x1];
 	u8 status[0x3];
 	u8 object_id_to_be_accessed[0x20];
 	u8 reserved_at_40[0x40];
-- 
2.44.0


