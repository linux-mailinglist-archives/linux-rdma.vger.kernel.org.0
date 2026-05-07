Return-Path: <linux-rdma+bounces-20180-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP9mHIvN/GlhTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20180-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:36:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E786C4ECEE2
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F9A83029C10
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06DF3AD513;
	Thu,  7 May 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tu405pip"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795216132A;
	Thu,  7 May 2026 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175356; cv=fail; b=JDOR+WWcq/83PAB9ihHceQ12mfoZgpULgDva1qLU1MMeM/epdGkPTp6PMnHQGajAa+hOfQc4nSjy/sgn2n/qRkJuRWG+Oukarv9+T+SFP+a4XyJqdix5x81J0mSP11ID6dgWymuJFk8YI86HWwcj5XWG6bq+P58j8MBFXOnPs5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175356; c=relaxed/simple;
	bh=wjGUR5E1y4db7rXUwSEFQi8prnIUrIYLC5hk39lvBt4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU017xJ44RiSNeLKxUt6d8DXcvqnoAgOxivhsq2kbLi8yOh7AuOhb0I12bX1yqRsfOdiGwwlKcVXydcCjBX1sZZzgkHeAW3QhZlVLobFEhaJVpvvDZ0JhDRN5kn2ZBMbapfjPUHo4rB5fRcr1gYL+5IT6IZ2cyFiUMzCUwUeeuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tu405pip; arc=fail smtp.client-ip=40.93.198.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TKExFKEv4scN4ZWxEcpmS4H1h4Gze8UuEzhCFTiqQObqmFA6G7scXhz9wdZhPdcbl9blUEuzIYZcTOZhPdCzfU59EhQCJij2N78XgytOIRarZGXrC0YMmXC2bRjYgs6G0LnpRFNLrk1nAbJm0+jpwvRXYrv0lWZ2PjqDJgfHmZ7IVbxKwG6YYXu07rNbWSnyMSes+KI2qnjHIvnZwKvKvRRSL0i0ayfmnWoxMdLOkqkcULmLs+2M7jqviUZHRUcpSJTB38CCsEvF0UUsbRWz+UqSWtfJP+rqO5HCcozkVTkM1aezjykSpntjbJHDbm5D5bDPcg/HcorFB2gOq7R6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVUsKMUHbv1Davz+jRBb0nRgUQAFeEU0t3zim4BBSxw=;
 b=dZsLhhsW1xlyM48yOzhJ9TSnLCfwXbsYGjSYfbP8TkFgrZFqx+mOcrDEpiTZ+uz1kCRNvMHtvOZFqdBHBfWK36MKztyWkdKNz6NW2kJTtpbMlb7dU7me/bCgpAjJ3l/4Ow0OdxIONKwaaBDLf7ZYDVPhX6QdcRb8Z5oVW4gQKv7OofS5DAkV/HXWgMiqVJ63zN1d6FNZ6W1IIzYRbPc3ZcvP7JBqTLfYGhv6+mKNMPtiDSqnMO7uKIINAQC9aYVHJyghhbRzTkcSFZ6ng74q9++k6BsqEkd+20wy1ON+4bXYN8i+aJ3jWUgrtBv1JMRDcsU2PkP4XWo7YvifZHzAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVUsKMUHbv1Davz+jRBb0nRgUQAFeEU0t3zim4BBSxw=;
 b=Tu405piprSQyWLA3+GbqsnxnD0B7eON21jbhVaEoj7dg8JS1SxyEpuxjbvByb6Mc4GGzGAoBqX5m3Ppmt0nFTb9pjZXBNhCTJnGrF60IkUEglEx4No5NOZO4sjl51DDZ16zMI8WGj801v32UygzrWaoEgSSQgz+kdlJrVy5ZcM+2iE2KCrw+as6wIfX3FTY4z689WdMev5r2PFMjkbnzOxi2+JYI5uDK17dYheXdKaDUDGa7QDloW7zqSTq0klBMtf2HrEDy6Z1ihF2E46idy3apeNywUmPNfbZYvET2HJWdskIfKH6fzXaykDC0U3N6Km7Y9Cobz3zx1YghlObP2w==
Received: from SA1PR04CA0021.namprd04.prod.outlook.com (2603:10b6:806:2ce::24)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 17:35:46 +0000
Received: from SN1PEPF000397AE.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::95) by SA1PR04CA0021.outlook.office365.com
 (2603:10b6:806:2ce::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.18 via Frontend Transport; Thu,
 7 May 2026 17:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AE.mail.protection.outlook.com (10.167.248.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 17:35:46 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:25 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 7 May
 2026 10:35:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Kees Cook <kees@kernel.org>, Alex Vesker
	<valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: DR, Remove unused field of struct mlx5dr_matcher_rx_tx
Date: Thu, 7 May 2026 20:34:43 +0300
Message-ID: <20260507173443.320465-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260507173443.320465-1-tariqt@nvidia.com>
References: <20260507173443.320465-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AE:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: a5e5da3c-5414-494a-ff30-08deac5f1275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HvDbXLGcTDXn0pVqBW1/91XSbaWTny4yj2iMGNDPTaFqVj4psftjPNVerhEdg9UG26c8ddK+uz84cylq/vQSwSX/fheZWxokEg+RK7I+ZA9tzjgOtb2Ci7Hs09movU7F4AsirRHljuQFJwGuBvzXYDKPnGmgZkRHC9gJwmaDOvDIe6/UmPhEqcyrvrxu0R5G6sCgI8rcD5qrhHbrOLE3KHf7tMFzO2W8eF4TBxpuzvtLilHgJ+QlC1kGphTnFxdEX3hapddSfORyy1KNz+3deYpHHSkphis1gs3HS057NUpETpHK+fzFEHh0IU/uzuVeuV5haHetyFjAd87eaLd7vMzHTBlq+LTOWdcTTYllT7RwkMiiQH55u0Hu3FQpW27F1Z7qUfTQxEZUHlhLEkeFQG769LXn3PqY0Hq8RWw+zM82ZYWZmd5IQrigz3e5wsmwYid3l2GYP/Jp2CePDvgsSNHRmjA+79nhzP4Zorow5rl01pziLsCJvDsBw5a1G8FnSG8YTSrhetJjTHE796w7CM+Ts16XxuEiwBpu3ySQz2bVeGmslE1sKkBHOf4PG15AX+LBtusX7bhERnayPi1q2n26FDGax5qnEgxiDzCgTsDjcaffH3CHaJIKTUfF4XU1ub86ruF0hcDEhcAR5uK922WkEUEIOGV+dgywSYvY5cRoQmno+LgJamAzoVTORSHNv+W6sYdaCbtPxXW6N6jX5ETnveuX4/6wa5mRWm0yZe8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ec+LHSFcFoJZCE8ZF9fo7RNldNkGmROSwQsw0ZoXxHMCI7hMBg0cmJ083USHUT/C/eX0Sa/RgeD91B+xZHSl/1cxJJAGX1nodj+vNavip7YkyRDTQAIB2phPhSn38NK0X2zwzNMRj+EeUXTTketLI64G0hLGHF0BoCBlwhuvYPdD63k+3J9O4Vi8FEuTI2/5Bl2ucVFsD3b11is8+H8eoWilYeoHEzNdcFu4Cjeka3tuP++TnmgMZt+ovKEImPCz7yuDWaGC8A/wvqaZMvlm6HEQOiwJUhtKVDnbT8C46aobwf4zQ+7CCDkFeHI85R1HjRehXN84niNFKNLklKKc5cdVlxqg6UpvoenmN5injgQ+vs3SZgIMJLKuMdTa+9sigsq79nA9SO6H+Ns7uhAb2PFwQ7zd656LXxNMItgasEPewP1pR9tTWzbuKlKoRduv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 17:35:46.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e5da3c-5414-494a-ff30-08deac5f1275
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
X-Rspamd-Queue-Id: E786C4ECEE2
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
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20180-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Remove a field that was never used.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
index cc328292bf84..e0344707f522 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_types.h
@@ -986,7 +986,6 @@ struct mlx5dr_matcher_rx_tx {
 					       [DR_RULE_MAX_STES];
 	u8 num_of_builders;
 	u8 num_of_builders_arr[DR_RULE_IPV_MAX][DR_RULE_IPV_MAX];
-	u64 default_icm_addr;
 	struct mlx5dr_table_rx_tx *nic_tbl;
 	u32 prio;
 	struct list_head list_node;
-- 
2.44.0


