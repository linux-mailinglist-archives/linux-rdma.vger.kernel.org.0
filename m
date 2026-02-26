Return-Path: <linux-rdma+bounces-17224-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDdkCkpUoGlLiQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17224-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:10:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFC31A7400
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 15:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 631B1308A035
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241E03B95EC;
	Thu, 26 Feb 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tT07/Qdh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA93A7F75;
	Thu, 26 Feb 2026 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113993; cv=fail; b=GwztPGXmJQAy923TDNltC0qeuy4IPWhyioCHJ/crKwnvvcQHolmGKWqzifLcR/9eUpjamRWm9sRdqibFKg0Jb6S3mZ0pNjxTuum55iAeuyn5KXRxzU0QIyzHejj4j8c6QQ3cT+/OiFbpFzp+YayKUOapFfV7pnkQxhGl5xzp0kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113993; c=relaxed/simple;
	bh=D5Xn9+i372/6A+IykAo1M4nzP2UFkXBO0BtvTe8WA1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K2bH/WabYgdEy4Jg5OIznUGU6SC6FY08Je4+4LOW1WlX7bVqO166eYmqjLEPYC+J0iFQbTKGjaxd68K8KEByA9mLt1U7v6goMgidM1i53fKwibEfWkwGCWwBr777tiTLdq3fCIxELp9PNVM4gV0ms2s8OuDLfZ+C9DrN1Ier4XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tT07/Qdh; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPmii3ukb/Lr/s2zy8PmVgaAY4/Ca9lW0SYG8qt6lLZsq3rGsLl8YzoPZn4bbwgLQ40SJhOZojO5cXOFv50THeOH2gyZ/lIFB3JCZplIIQHDxPY9okBG2FK3XZk2/1gVlCGh92jk+/ve3zOw7F1tulS5ZKD57ldHJ89pUt6Faz3DFXuYXcKeg1MZMQsel7TzmgZYQw1ep8mjD6YYgmDWvCmboIeM5YWJl35ccRaKkuXvBeLm7uFYXyE1RdmOIX1LGlrHYpKazn8g+/LTAlsrAuZJecaZYkqhBpt/BfIuycl7cTtmLsq9KLPrjw2tmf78mPl0Kd/R92VlQFQUTA9XVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckmV20mnEUeEuQP9633SIK7FE5xaAhAs/dk1ddfOmzE=;
 b=k6gSW1CIz2hoyTfHJuW6yKaEuXfTcQbpLS6IEGlz0G2dXJ+ckOuNrYfcEA+f/HXGcoO/+i6iS04mDW0Y0Q4H4WfX1+DomkjW5/fOfUseyazpvLOPgVHlK0+uzxTO4EsgVIlgzd80a2l6AOiIRIGVEoggkNFLGsjPAjQ3Y/pxBdh/gzh5+Aqgga6CyqjhG+9Y63iiAku1epRy4pbEmHEbIYObqsm+aL6oDEcHzZiXxFi9G05wZqmZ6TM241rcwaGTO5pa31O1kvXBsvFv9IH3yY8uqWWXtUdVdMP62pEhmKSTZd6GHYtM2fndynV1X6lvCFTI7TueO5jVYs87joJv0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckmV20mnEUeEuQP9633SIK7FE5xaAhAs/dk1ddfOmzE=;
 b=tT07/Qdh0BEy+T4KXHabUQRw2oxVxVDDMSpRR74jG2+zZ+XADfXJgk7icQ8QCEUr+TH0GYH+X97r9eYShYnjV8ASDYDh6uHbdHVTiF4KvtxYDnB5+CPHXX38I+XvDLxnMznNF1PUD5xm7S/kc9KVkE8QSrGWeMT0jxengy4U3AXt7hUfSfoCIUFPHYR2s80pWdziUzbC0KJchRUDQ6LLb3ZSVQlryKzMFhIrUfXMd2cV1L/jYUcEqZGU6pjaxG6VTMDszWRj8koNvRgdP6q0/zIRAtvgauKRXNJcTZVy5tvXvMpUvZ27vLK4/VqgFttv/vOZgwxWzHBplHcOAZLCWA==
Received: from DS7PR05CA0067.namprd05.prod.outlook.com (2603:10b6:8:57::12) by
 DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.14; Thu, 26 Feb 2026 13:53:04 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::4a) by DS7PR05CA0067.outlook.office365.com
 (2603:10b6:8:57::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.14 via Frontend Transport; Thu,
 26 Feb 2026 13:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:53:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 05:52:51 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 26 Feb 2026 05:52:51 -0800
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 26
 Feb 2026 05:52:47 -0800
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 26 Feb 2026 15:52:12 +0200
Subject: [PATCH rdma-next v4 07/11] net/mlx5: Drop MR cache related code
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260226-frmr_pools-v4-7-95360b54f15e@nvidia.com>
References: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
In-Reply-To: <20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Michael Guralnik <michaelgur@nvidia.com>, "Edward
 Srouji" <edwards@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772113939; l=2798;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=FXlMlYelH+P6S0/YhC9lZpJj12B1l763A27MmGHddTo=;
 b=UxjNNzAN45rabj8Ncv61zudug8mh4DNmzIDJgu57zyRhzRcERa20vhG2iHMf9sR3gCG7DQEA/
 Xe14rUHVlMxBzV90ZSPUqK/m6NEAe9icwiWyBVOtpV6uqgAdjOPdndw
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|DS7PR12MB9473:EE_
X-MS-Office365-Filtering-Correlation-Id: 605c65f7-65c9-4a9f-afe9-08de753e5ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	uBH7/5lKhLEiC6fDRJN8dLhEufEj9tce6lOjIFy1eo75T1B25UxTWzFKeai3xLyrC6oi4doPmSYxEyFa9owW3bFGKlMsHdYUfnGK5Vi/JN0+upD1R0eOJYqQgdCK/7wlV1NfpkPufPkcq6kQMD2aOwS7/ECwFUKrJ6LCWDJt5oE40ofiD4BXzLA+oPr7F665MM7LI9GNmNcROoLvEpRuXK46fBtG9KhxVwIzHdrn6XAsiRzj9FAS1YwZ1pjr5R6ReNNRlFuuGF6ugOn0+jvIlPopNcx0J7f4sJtikxjqelwOXMX6I8Jjqx42usOwlS1WhxvoXe21xxurlXc3v1nCoWQdqtaI5HHP/reZU/Ap4lAxtY1Q5BwPcQMyGEaeFp/cLTSuhXc0PVVws45D8mKeP+pLbIlpEwKW7yplzutIt9c20eMzv0pxivXzz4zoWGu45l5/pjvcN2MNooWS2rcV6j24/d3gFWrOddxJv4+ogB95fcuvQBYUz873VR1OFuNAw0v4rOUOCjlmaMo81xlPXsRj6Oes8YNi1eMiCItt4z8d3Dn7XIa8x6fGTlYcETofzp/oyzxh2zn5kgoH/lTL1349cBXYH1ofdZxglQZTtKqJ14zq3W+/CoWY/xB1lvx5rLoO5KJ6iKXE8zoAVuiPxMiVZw3KWCeZ8a1z2KZTpQYNa+9s1ABNdgbV/HZKisJPr22CfmeJAijJJqWBmz66rGFvJduM0d+2KkpBclAdoouZqH7kvS8eNvzpnITfpRzmQgUFHmowFCJth8zDUPVYG99dr8fqMszdmquG/xAf9I6uW795KIqinW2SUquR2xVQC5GTE4+ZTGCpO5fB3/oO3NnJll4BMn9poEpyD9vZoiw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6aEUxrBtPe21xlTXbqD9mSOUq0Pk2Nhl6eYEckQB6/G8umNoKXhYaJ2+NcyAZhrqvVYpb1FiGeDqngL02Z8lmkC+JDfysEeu/05uXbPj8CmvlTjIGDGzo2fiFMZAuBRx3vPTFppnDiVkiwoLBwJD45MXn4YWUYQzLSzG3zelC+FWzF2ojuG16OblkxcA+uvEDRVHPYRnNH7kKoy4qM1C04TiknwJ2NAkjzgNMFi1P3uVc52nSCZ2VaON32upJbW2yBBw0M1RoxGTXZptPhjuwRQ2yjpATRfR6EViUIE1bi4tGagxeu+551cuLPHJGx59HUPfHz6IMgQlh3nKBgGiNizidcNKghv2EqGfU3o8QIEwUdsVQ8guNjGIwVi/DnVqs6cI/46obbUMq2EyjaDcVHMGSS1pNluDlZVdu3u5MKS5SGfScRZalB9LtSkg/Ms7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:53:03.9298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605c65f7-65c9-4a9f-afe9-08de753e5ce6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17224-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sto.lore.kernel.org:server fail,nvidia.com:server fail,Nvidia.com:server fail];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BEFC31A7400
X-Rspamd-Action: no action

From: Michael Guralnik <michaelgur@nvidia.com>

Following mlx5_ib move to using FRMR pools, drop all unused code of MR
cache.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 67 +-------------------------
 include/linux/mlx5/driver.h                    | 11 -----
 2 files changed, 1 insertion(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index fdc3ba20912e4fbc53c65825c62e868996eff56d..4b59f3f7c6f0be72fe83f4ce39f98f97840dc963 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -110,74 +110,9 @@ static struct mlx5_profile profile[] = {
 
 	},
 	[2] = {
-		.mask		= MLX5_PROF_MASK_QP_SIZE |
-				  MLX5_PROF_MASK_MR_CACHE,
+		.mask		= MLX5_PROF_MASK_QP_SIZE,
 		.log_max_qp	= LOG_MAX_SUPPORTED_QPS,
 		.num_cmd_caches = MLX5_NUM_COMMAND_CACHES,
-		.mr_cache[0]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[1]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[2]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[3]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[4]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[5]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[6]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[7]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[8]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[9]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[10]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[11]	= {
-			.size	= 500,
-			.limit	= 250
-		},
-		.mr_cache[12]	= {
-			.size	= 64,
-			.limit	= 32
-		},
-		.mr_cache[13]	= {
-			.size	= 32,
-			.limit	= 16
-		},
-		.mr_cache[14]	= {
-			.size	= 16,
-			.limit	= 8
-		},
-		.mr_cache[15]	= {
-			.size	= 8,
-			.limit	= 4
-		},
 	},
 	[3] = {
 		.mask		= MLX5_PROF_MASK_QP_SIZE,
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 04dcd09f7517b226f9a98afd2ed340395093114c..27d64f09683fb7c191c674fca55475d81354f056 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -705,23 +705,12 @@ struct mlx5_st;
 
 enum {
 	MLX5_PROF_MASK_QP_SIZE		= (u64)1 << 0,
-	MLX5_PROF_MASK_MR_CACHE		= (u64)1 << 1,
-};
-
-enum {
-	MKEY_CACHE_LAST_STD_ENTRY = 20,
-	MLX5_IMR_KSM_CACHE_ENTRY,
-	MAX_MKEY_CACHE_ENTRIES
 };
 
 struct mlx5_profile {
 	u64	mask;
 	u8	log_max_qp;
 	u8	num_cmd_caches;
-	struct {
-		int	size;
-		int	limit;
-	} mr_cache[MAX_MKEY_CACHE_ENTRIES];
 };
 
 struct mlx5_hca_cap {

-- 
2.49.0


