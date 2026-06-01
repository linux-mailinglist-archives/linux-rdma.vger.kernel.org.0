Return-Path: <linux-rdma+bounces-21563-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOslIAQkHWq6VwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21563-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 08:17:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517B61A0A0
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 08:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EB9A300E2A9
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 06:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1FF3446A6;
	Mon,  1 Jun 2026 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EPrITSBa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013042.outbound.protection.outlook.com [40.93.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1FC329C6B;
	Mon,  1 Jun 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294557; cv=fail; b=SI/MZzmVfupr5GXicUmTFKtMGkZ6Hoq54CnT/iJQfqNTXCBJXDZnaArw1iYtUupc+8gqZuT+ojfxMmR4T2IpOowQHHwCStk7N+oyA6EJpwIbdqhMJejcG8cLfvb04djzuLFbcY85RV2h23lPxRb7c4lmdFI8jpB/JtHLi7Vp8bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294557; c=relaxed/simple;
	bh=DoFivJBa3UoEr0wkr6RgFQn45Kq6VLsGXqT6tN1Jqfk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F9e/auTfQjBXwFW1ZHFqnlXFiXRhkrRtKGgOgM8rqEqsqM+xp3CIpw8PbxqotYI/nI5zSivG2tV2KD6Au9EjO9mX9yKOBFYExNOnCMcbI40iPafTHBygtexieGrO2hXF3pkHoa8sxZlcWa2u8VMy7TJXPmzmXx5Y9KlFT/lLWnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EPrITSBa; arc=fail smtp.client-ip=40.93.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuaNqtbxuzAEUqEDrxhUyF9mxeV7SOCl7FbVq8/QYFSHI6Wm6sOis6WuNdFgI66LBRB0W0LxG8s4il5FTXo2pgWik3AQZ3gHa39oaLEKanDyI+MCdU3xU0LAyvdAlD7DhmYOjDJnOlsiFIEGkoLkgGmpCq0Hwcsf1o2u1T3nRQCk8kR7ubYS3GAYD/V1ZGxVrE9tMcdF6olZelB0siXYa6r+NjFEictYbUcAkQo5ghansWR56CfOIvbzHghOfGkWdYCnrtJREkoPxns8/yleQsqJ2jFcdvHluHOeT7rWYWUMPui7f9e82iIDM4dW8+EnqmGL6LwujA0AkcQyJVlGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BInJxuNr7CKwLntQ9tov1fz4essX6YEOBZRc8/XzDg=;
 b=CN7FPlor6lSEy5sx6LarW4K+PuepHhKLv34qmEhsEnFo3IE+F7PcL9Xg5mPreny18Bx+UGCU3BcahvR5laGHViZ3dcJFAtBhlc5oNv6zGDMkaHng/wc/tityKcFHrcKHdknRKcd9pcdQQTp2TJP9Pbmcv0S1f/zLRxLWo0WumYNnV/B1KAHNw5Wm9BJRFPXYYAWyupPjhv7kzDhL75nDs6b3Mo4HMG/YvFAktotaZXADEJ8pUtCXtw3AtNULfg4VECZflDuJcDldhGii+zUhQPxqpCrT0Zn9SZsQWz8ehTafBYEjwLau/LCvs2L9LWL8F2qSGSgyZHgWNI+UbJscvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BInJxuNr7CKwLntQ9tov1fz4essX6YEOBZRc8/XzDg=;
 b=EPrITSBa0C73PjEx0p1yZGy1fe0bvcnfkQQO0Wt+NOUkxe3ar/Pt+DsEaYp7hGF2+KbasA1mJ1QU2iGa7BFauylgcVyT/PeGYoIxEBF0BvnVeXUXav05j4aW20bwV6M3K3ai5Uy4V5EEwFF7UFl5oiJUeMgklW5VXWgk4l4+R0z00m00DSG1TyXOEz8nffuaFuvn1O5Cy78RFVeUCNwaQJpH+K9IOgSuCE0I/YpoWmbgHC4lMyhx/24ON6hVtCvE989yMDi+koTQgst48cU/dmuRzX2jxrNKQzHyyDIZv2sdfJGUkf8d/onOzbTCAFc1gRu50xyBXnpsxsY3eGR4mw==
Received: from CH2PR08CA0010.namprd08.prod.outlook.com (2603:10b6:610:5a::20)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 06:15:48 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::20) by CH2PR08CA0010.outlook.office365.com
 (2603:10b6:610:5a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.15 via Frontend Transport; Mon, 1
 Jun 2026 06:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 06:15:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 31 May
 2026 23:15:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 31 May 2026 23:15:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 31 May 2026 23:15:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Amery Hung
	<ameryhung@gmail.com>, David Laight <david.laight.linux@gmail.com>,
	"Christoph Paasch" <cpaasch@openai.com>
Subject: [PATCH net-next V7 0/2] net/mlx5: Avoid payload in skb's linear part for better GRO-processing
Date: Mon, 1 Jun 2026 09:15:20 +0300
Message-ID: <20260601061522.398044-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 16b326e5-c954-457a-e296-08debfa5396f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|82310400026|3023799007|56012099006|18002099003|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	fPcI/+ZOj5YFwe7+K0WJuv1L4H+2TEHIUz98odR/LFwvgJweDumtlc8LyeIVzye/qZoCGsWIB1uB3kmP9ni/8DW3WGIY/SFiFqJGtFOSLufFb1OTN7akyCkzSS3L8BKKNOpl8b/KaDnAmZuxN76J+BHQBQEc5F/uKoUx0Rvq5y9elIFzzBqbrHjZy1jG+eJyIszAhlFdP8xlhJqQNOrq3ONHU5c39bA+lDNehotG5M7ezeKwxW6MP1zPowXu6lbldjAX19vn8k2Jl2A3mKWB909YhWQHJS4OxfvDjZH2f5DZ1oXr8bcytqO+bZWZ2WLkqNMZAc9Wb4kiyk/Zgh/8uBbLrArUsNCPt7d6PiGu+SDJhGJZdzNQBPXBOBSz0fqwbO9Y0C3RRYQxB+r7+xCxFdi18DX3ZKaQLCbDP1sGlqjePr+eRc2aohyA/R3/E+36TCAcuk7UY11gegv3vqAkUK4wvChMMjIJEGdYexPsmzNjZYpKNjrvCQhiW2fjgbmYyavxoxJNNv8b90S+IXkE8scbVMdYSwtQZt8Zkp+fjCnrrS6hbhhMF8Xajzh6TkqIKguOnvJQipkrYtPFB+Nd64u9NZN7WOSLy8NU/2eBWwBRw//gtM4gmJHYXNUBjQdehDm6poiCuMtgLbDaR1gdSEhL4E2c1hCVl7JIMysNphPIPeNAcqm9a/NDK8FYIiG4VZyLaBnXF2SjlZf6uFXSjskeJBEpPQWOodqo/zLYtGA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(82310400026)(3023799007)(56012099006)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I1dmJbAuWdot1uPEJB9lomhR2uHPSPCQWRmhwSVLrTk6TnNkqQ31RPd6GNfRyi6HZK3eezLe+seNwlQhttoUqp6L4KTgc1Ki8thXqWz3Q5AQ8/OmqAhhuqbl+KFCYuUAAfAKtPL0cVs79peNjQUg5p8Ab5p6mHAH5yABCK6A/l9muYtTCAbsz3rcgAVK5pAeCsRCF3Mwv8/sqjUpywxD0BgdECkoGr8JjUIM6rJEfqYxttyltdVTerL2KytL1vXEQFjKQIHslfQw7KLuYMHjN1ZGUFd4eIhsfcC0VOlEVKEhHAMbahxZ0IHyi163IT8+wbMvnS9FENa3vi5QizfxP+OjSnjpBmHjiWwfGTKDEt6EFixb7p6hwym2Q3ijDTwfwUD++v1AuGtPHl6psJVsfMa66LdhBzkwVvXDutELJvfTWsS4VRE8oQ7GQZJhtt9s
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:15:48.5756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b326e5-c954-457a-e296-08debfa5396f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com,openai.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21563-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.980];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1517B61A0A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This is V7 of a series originally submitted by Christoph.

When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
copies parts of the payload to the linear part of the skb.

This triggers suboptimal processing in GRO, causing slow throughput.

This patch series addresses this by using eth_get_headlen to compute the
size of the protocol headers and only copy those bits. This results in a
significant throughput improvement (detailed results in the specific
patch).

Regards,
Tariq

---

V7:
- Drop cache aligned memcpy patch as it no longer shows benefits on
  further testing on other hosts.
- For XDP, pull at most ETH_HLEN bytes into linear part.
- Fix skb pull length calculation for XDP (Amery Hung).
- Switched from min_t() to min() to avoid skb->data_len 16 bit
  truncation (David Laigh).
- Improved commit message for last patch to make it clear
  that the benchmark is not on native XDP (Sashiko).

V6:
https://lore.kernel.org/all/20260507095330.318892-1-tariqt@nvidia.com/

Christoph Paasch (2):
  net/mlx5e: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
  net/mlx5e: Avoid copying payload to the skb's linear part

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 33 ++++++++++++-------
 1 file changed, 22 insertions(+), 11 deletions(-)


base-commit: 8415598365503ced2e3d019491b0a2756c85c494
-- 
2.44.0


