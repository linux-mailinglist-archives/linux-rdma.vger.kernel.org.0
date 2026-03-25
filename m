Return-Path: <linux-rdma+bounces-18647-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOaEInAxxGkAxQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18647-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:03:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F5D32AF56
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 20:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 49AD3302BC16
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 19:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFFC35AC32;
	Wed, 25 Mar 2026 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J36MnBmZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E13559E6;
	Wed, 25 Mar 2026 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465263; cv=fail; b=ttZFo+wQgFUkdvxBiQOKUlOxi+G+eZ4e5EVyNThPR9zG9sl/zse8/BNK4jF/bnZVygk1E3T2hqRuV8C40PQSC73s7xSgmijd4BX3MOpgyMCZLYWinpAhI3B8J76gFzlbIzCZZG9ZTnUAerdRgkbje4ECM/8f0yUdBGbnPpitOK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465263; c=relaxed/simple;
	bh=6H/CzLHFboiN5aRfvcuHGsDkPb+QLlbXjGJuB4jtRUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xui2juB+I9DtQM9ndERT0vre1KKx3grn06ji7YOC5lpkUeUsSPiUY2Cgxa3iGeGH6pcm/J2ObIFOuapRzIIQdcU7zarblXKIFYqe38ZuX8cXeaYIzinbUDCoBKeWXr/9XQ4F05j3gYJpXn+afQVcP6gJ2TcxJyH5TqpEZlHZuo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J36MnBmZ; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbybrb573GJ8Iwrii7e5nlIAqdgUaBJsezyEOQJg1zn2lu+is/N0hLY8e7V4uTcLoHpwcCS3i/4YyHMkmZt0piy4SzDYpEb0yMh3dU5PUBjDZIQGdLruBe5ru4q1Kw13JKyzS5w6592mi8WBFqzDt7ClI8gdAvQyWQIldoJzhFjiwUk/r70uTvIudxGSE8jQ5XNkyqbSOkBel27iHANW9EiinEJfICD4w5diRoTjHufVFvZjxHcKuQ4Pa45qJBKlDhWj9GIT+mcEHUueMSPwxrfGt5V6NcovV3LLT+BbE3pmm3+kXNn04jc1ZS8qNASUN2m+6wwCQQjiD1w4KaqcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwplSS1KMnMSzQ4V5xp4TgLA63kFrlOfesFAYVtgRoc=;
 b=diyTf/HXakd7qavvQooyHIrsc0M8ip9jnJDAEZC+1NI6i8rKqK9OEZ5+lVEgQaTg9tTf2lTDRkyVFrNOOB5emGdrxYUfO1717fwbnfGzv5gbYksUnqr3p+cTZUcJzi5guoFQuAvHjsXb5MVeWYMA7YkiW7iswS8AYVUYvXqh6YemI+N177IKJa2CNVN6ZmNwtoDOECtcm04E7NxJ447krnogm6PiwzlXBSIch550DpLUr1EkSB39tolC1l93Ra5+Wq/Ph+zM5WtIzOGUv1mM73nSJIv38bDZ3VOE/TcR0ihIIdK/y9Y0w9GjMT9mLA+JY1div6Sa6fvhUcaOPsj4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwplSS1KMnMSzQ4V5xp4TgLA63kFrlOfesFAYVtgRoc=;
 b=J36MnBmZIJo3upCa/PUkc5pRwM3oGWDNQnlJxrS7quxz/mnWdd1XqA4Jta3+XSxQXDEQbdzGi+vZbE6rC69PYqxxA3Ggzpj8w0WClt2GNttrL0fzSRj3kar9y5ztGll/n9coVC8flblXD2/oHku6dcGHcWEWE+bSe1GXq3GSIk2l3KdVVygDzYVt0t47H/z/DFBivsg4euVCw7lVFuQZiOU4kkU4u94pBaTs4eLFHR3N65Tp3wg9jAQ0udb5XPPawm2gTaeuu0kKSyLdJDSHIYFi17uvmX6nweUlb3Ag54EgmsJDBsFwhRH0nhKZxFdnkaFPdN4n5G6ERtQCJQufRA==
Received: from PH8P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::25)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 19:00:52 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::3c) by PH8P220CA0005.outlook.office365.com
 (2603:10b6:510:345::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 19:00:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 19:00:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:21 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 12:00:21 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 25
 Mar 2026 12:00:17 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Wed, 25 Mar 2026 21:00:01 +0200
Subject: [PATCH rdma-next 01/10] RDMA/mlx5: Remove DCT restrack tracking
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260325-security-bug-fixes-v1-1-c8332981ad26@nvidia.com>
References: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
In-Reply-To: <20260325-security-bug-fixes-v1-0-c8332981ad26@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774465211; l=1983;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=JdRkUYRq0pIWwuMSpYFF7BClsUMppMUSBJcSiThyysk=;
 b=NdGEFbNpBp7EczzI5ylS8l7mQE+yRWOSQTXBq04xv6Y7yMltwZRRxMk1dZgkbloiMKPD/aLVN
 /Riu8+mW6rTBAH89xxTYdWmXGnreNg5un9t0gfrN/bEAjx9Jxe/zwHt
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a23212-81d2-4891-2c6f-08de8aa0d58b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1OWf0VlSJlgjrF7+KRlIbKiv06rG7/a0cQsOhqMUR7NNv09ofNd308v/gHVZvRZX1TsPLH/Wx7xckTobMPsvP6JwF0R6MWq6xKgOJI3aM/G+JCqTSfZxCZGUE8/+R1HufgBKK+c7B1J1LdcJjCtH5Sbq+N5QSFoxr0+CjOSOxAszbCMcDyNYk+TJb74Bnc0B4uyDSiIhtH5fMdDQXj+FhAFuVb266DWBA8y2JyQuylSv/Yx2zgw3ff4fnMK0/p9r/88TXmLo5dBmvFEfhBJ6u+1ttWiw1AiE8EUyLgzW/KHqQlbYsrfP7i0yfLyl7Ga6EgcaPTCeKOW6JsZknCsUD4DOycqE7cuHtpDhYHBA9IUoTwBkyaqvU1LyfEcFEw+lxreYBluzLEYpykqd/oZdwhiY7Eqfre1aU1JW9RafI/Boj6+w++Q6ipafzM5mKaonNRJ5otch0KxH7/jSgdNq5Dcb77KXB5HpcIJpPpnRz/Bs2kaqdJxq2qGnxFttAzgibkt0vyfIpzO/5Jkr80JrCD78wJEeHrX2MKfcf/sO20rSiNF+/gRokxhxOgI9NLbf4/HwSqIhMv05PrLh80Ytei5Z/ejeeeQIsbIkJUAVRk4yc/iUHIkaFPcKKdvsCqaDKI36Ey6hV402eagROhQlzSwZl4ohoO8PnxSbcdiGKvM5c2KVMB3S2mJfFu8kjIe9saIG51ZqznJEYfW/JZVEONHOhwXrWWUFxtDzUdb+uIGjp5zvT8WGb+JvivpfSLuuPZAc2YB3SzCImNdyZpqUBLI/f+3DNyBTtEQaKTwxiHUTg8r80biAPrHes0ve50FV
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(921020)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8WmAABdYjN1HNCwAHFtDUBHz7/CAlVgheQRyTu2K3eQiXSjIissi3ZFhNMDbg2VMMDazSEy3WwImeGdGx1Gb6gm4r7Ye7IPBBvlpVkZ72CQofpjw4PzFoUEpVMQh0HGNghKbGVBOPcgnanUhtq5Z7ILLXVNe0QGecBGl0MdWUT2QYVBbV6kVzddcRtTZUNcNZ8hz3a5a8KhScNtZJ7J52WWxzRmRPuaImcGOvwW+78ZaWLidpCL3EeALbtzDkpv3W3nHxF0zRflHybzVmAOoCtXQdfu7F6KzqpVnQornfCsKimC3rjmKz6feEvDDvfY5Bj3rCn803y+eA6/gfXpzpjhcnmybSKzm00cqF/Grwt+ngEoEfhczLzJZDA7TDVRsZQPEe6J/GIw5ADE+YsfdcYWmhNDYlBv+zV1p4vczvgcNwHlY54uWpdBN/wmK1ZR+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 19:00:51.4096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a23212-81d2-4891-2c6f-08de8aa0d58b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18647-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 95F5D32AF56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Patrisious Haddad <phaddad@nvidia.com>

DCT restrack tracking wasn't working to begin with as it was only
tracking the first DCT which was added, since at creation the DCT number
isn't yet initialized because the DCT FW object is only created during
modify. The following DCT additions were failing silently.
Remove DCT tracking so a later patch which WARNS about restrack addition
failures doesn't WARN about it.

Fixes: fd3af5e21866 ("RDMA/mlx5: Track DCT, DCI and REG_UMR QPs as diver_detail resources.")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c       | 1 +
 drivers/infiniband/hw/mlx5/restrack.c | 3 ---
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 59f9ddb35d4620737980b2bc2179e0a11e6be29f..c54e7655763844b10943e12a70431da291c58b8a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3110,6 +3110,7 @@ static int create_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	switch (qp->type) {
 	case MLX5_IB_QPT_DCT:
+		rdma_restrack_no_track(&qp->ibqp.res);
 		err = create_dct(dev, pd, qp, params);
 		break;
 	case MLX5_IB_QPT_DCI:
diff --git a/drivers/infiniband/hw/mlx5/restrack.c b/drivers/infiniband/hw/mlx5/restrack.c
index 67841922c7b8770c86fb5a47588e09560d0004f5..00a9bcb2603f0b094bcef8a4ffe6564699a85769 100644
--- a/drivers/infiniband/hw/mlx5/restrack.c
+++ b/drivers/infiniband/hw/mlx5/restrack.c
@@ -178,9 +178,6 @@ static int fill_res_qp_entry(struct sk_buff *msg, struct ib_qp *ibqp)
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE,
 				     "REG_UMR");
 		break;
-	case MLX5_IB_QPT_DCT:
-		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE, "DCT");
-		break;
 	case MLX5_IB_QPT_DCI:
 		ret = nla_put_string(msg, RDMA_NLDEV_ATTR_RES_SUBTYPE, "DCI");
 		break;

-- 
2.49.0


