Return-Path: <linux-rdma+bounces-20291-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCvwD8oZAGo3DAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20291-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:38:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B55BC502AFE
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 07:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30F14303FFCF
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 05:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9367F35AC17;
	Sun, 10 May 2026 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NWya7THn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED335504D;
	Sun, 10 May 2026 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778391353; cv=fail; b=M3m40SGZBNprtvVcIf9l4BxcJoUEwIMe1g9PJwzPJzQi4cjX72ekxv998tS9BCDmBzu+bry/vHiYjSJy2BTHhLhv9BuYpMm1Teh/DHNhaRPBvG5d/YSM5sPVkQkFI4G0YwyEjSscL3P2tu+6bDe1M8fF1RqjaWO00lTvNKbP8v4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778391353; c=relaxed/simple;
	bh=KsIjP4CqM/+gQ6LfrqdvKL7QuauvxqQSXB37hJqm0d0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QTBPHJ4ZgrbW3WfN3o9GNFEI0tGszCzrFrMKZe5Lzbs2f25IuPAsfUvQSv353j0BxQCVVoYXlsVRcNpl1sNOWkoTkfabL2ehdov2Re8lghNWe5HtT16dL3P9XhUzH7cr1k+21UnC/78XHRfKQPRBc/6SZCnfRrg1Q+uym5A7CGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NWya7THn; arc=fail smtp.client-ip=40.107.201.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BO0S3X0Yt0O/fxGXq49eLXiva+pPKrGG33kpP8aN+f4j3clRLYS/qHLhH1IzpJf0sUsVY4mAyoBl6ulOwOi5pmW0vP/XXogVL5AeyQbwXvEO+V6PTNMmDk5DxYHlwqLlByyFQa5bePc7Gub3sSwWbXsxxvdo3cz5b55b3PP4SXXn6T+jHTDpOgh4WmeUNkNdb4mT9dqy9GbZXuk+nN6BwLGtF0twqImAiKE5SckT7E3KRZ13RBjhVsDBunIN/JIRTIwuCZdANbyf0U4r8AtHBgDCuT/+Mnv2AZi3U0JgEJxSFIrVnTHKjFpoakk6JHc/B0Z+VgmvJbiBrnxzlyOwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nxl7uYW8EnJ02wSrfhdGlj6juwCERjMWyIAXJP34RDU=;
 b=ubzPRh6MRrwy3x+n3kJPdBvl+pdQmjiTdlqIf65bEWvjjJqfKJvtuP7YO2QXxZ89FHxulIxlfmWME4WX5mFzX+Rvqyd35Hj5FBUq01GRfCQE3RN7K4o3hUHRA/xtlcN1L5INTCfrqQzybIiNpauk7c0Xv4pb8NINDiVEMZHejl+012AprbQNxyG3kIOXaKw6brxkxp0i6takiK+mmc2r9j0tJg7zYNB++fB0EN6YZBjyA12nvLJF2ypcwfwdfWel0Y2gQaH0IYfayp8lyrmol7cmOcRdQxep39hyFKhPQGZRl8wvFdDHpO/+9aQwQohJ1oPsQDumef/Xx/zTvfAEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nxl7uYW8EnJ02wSrfhdGlj6juwCERjMWyIAXJP34RDU=;
 b=NWya7THnzC317T3enhukMOc3GTiAtIqSVHR04J2H4L75S8FfqXY9NHpe69P4ienhqhjWBVo+ABJJ+zb7IP4KQh8aZOjSTGyB3Un7973yGI2oF0AcIfh0YHaahq+jiHh3PhJNHwINMhyM3hKptNQjlWilyoDQOE/HkgVmWCqFpKeuzNLl+CRhyIUqmEPd8pQMs7x+qOdKR0uqZ3jiLX2dPNPQy3xQ3ZGVnRNRvzmjs0aKLHP6JrJTL4Owb4iTUNAokrDUyKKXOB2IvfFJ1Uwk/gsqkfkB21KqyoF2e/U3u+uuvy45Eli5BiinXwtnQPHXL1DDdoYkTwdFAdX/M/H7hg==
Received: from CY5PR19CA0047.namprd19.prod.outlook.com (2603:10b6:930:1a::6)
 by CHXPR12MB999222.namprd12.prod.outlook.com (2603:10b6:610:2f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Sun, 10 May
 2026 05:35:47 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:930:1a:cafe::b8) by CY5PR19CA0047.outlook.office365.com
 (2603:10b6:930:1a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.21 via Frontend Transport; Sun,
 10 May 2026 05:35:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Sun, 10 May 2026 05:35:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:34 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 9 May
 2026 22:35:33 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 9 May
 2026 22:35:29 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Akiva Goldberger <agoldberger@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 4/8] net/mlx5: Switch vport HCA cap helpers to kvzalloc
Date: Sun, 10 May 2026 08:34:44 +0300
Message-ID: <20260510053448.326823-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260510053448.326823-1-tariqt@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CHXPR12MB999222:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ca4433-0f31-4090-a845-08deae55fcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tb2lH8wV3vUeg2Ms3xIcO1g5o4B0VzkONhfwdehfaHDC2KTDHuOenwjDAohwB296xjZHp4+Ni09hDY95tr2b59p6PLpPIdYLq2WGeeywYIEHe4jGnOwKLn+CAtVrXDXS7whOfVUQp/qR9GfRDpjy5ZIEJRHntaTufdSkpOlgcy49Cyki17zrR8K3VIoU0DxgFwVGcn+fjxDQRYQqB/I0hKteQ90MMSKQfSvxFXdcoVLAWtUqmnoguTSEW26Ux+26tXJ3LYCJldqh7T4R1icIjbnJIxS1+HP5SMS7aJdKCStGAMjJFj6ZzcKV64v/tN2zgrhRUAaLEaGCsXozQhhYG0AR/+MnPNcXJm9BKxQERgqtvZ0MA4Iukjh1dTMAM3wldembHolpI5sN+9uhSrXKQjDmTpQhPNcNQwUzNhVjA6R8PE264uPRmXBuNNW/4yyK1CxUzpDCcIK2z4qj2t1+5VFrs5N+f4OgSMsV59K6n1uftk6gL9+lhqwelIlIoXLDSTiCVr2S/X6zgnrh54iqkBMjO5c/fzmYQ74qIELKgBoqiBXYOnzuhjwnIGMobjdWgO+UitFaWE6RCbQiju40k9/9WsD5DElEruiNFEYqeXzQL9pDyzXjsWQCbGQ7+2GKzofkPc04Sq0mEvwdxKVRfdJLU6iGotBeyJJOdlaA4kRal/lIVQRC93eEkBSrc7QpP5NGqlY3cfn5JY99OK/4QXK18ntsb471B6ajuYWuV+g=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JXYLqI61ahXm+lJ2Hl0cHFgmhKRHzS78Gk/WeHrKhXW12DOCNfcwYI2vSw8raCgzQrHM8EuoTJx7gm4a32Ob8ZPNFIq9Z8B/MgyAEHJc/0QFdKIppcSf0h9vcdKFWqb3/PhJJWgySaTQH9NBjYpAHJH+mmoLXebA0YXVSbsc3xkLP0een6yPY6ny7QjdwfuZcPcY0Zos63DfHSnCnMsCNwafUTHkh9zvnHbsN5efB86i6Ce+PTgw74cJYlsZPulERZ4zMYHiBxdfrb+BSLNUKiy865AjIYiZFXa5PcfGfxw4jyc3bnbpakVMWI7fKg3hjoqHJSkuRpAYfZvLNCuX+Yzxw1F63DYnDZMYuOd5AgOnu2ePLosYdeIuAp4QZiWgIqUDYmEOinuCo6uZFOFEdXRb2JGL0r7Q8P6NvxL6aP9K0BENn7uGB157YGkpUuJR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 05:35:47.1044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ca4433-0f31-4090-a845-08deae55fcf5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999222
X-Rspamd-Queue-Id: B55BC502AFE
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20291-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Moshe Shemesh <moshe@nvidia.com>

mlx5_vport_set_other_func_cap() and mlx5_vport_get_vhca_id() allocate
command buffers that embed the HCA capability union, exceeding 4KiB.
Use kvzalloc/kvfree so the allocation can fall back to vmalloc when
contiguous memory is scarce.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/vport.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 4effe37fd455..f8e6b1ab7c5c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1336,7 +1336,7 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
 	if (mlx5_esw_vport_vhca_id(dev->priv.eswitch, vport, vhca_id))
 		return 0;
 
-	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	query_ctx = kvzalloc(query_out_sz, GFP_KERNEL);
 	if (!query_ctx)
 		return -ENOMEM;
 
@@ -1348,7 +1348,7 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
 	*vhca_id = MLX5_GET(cmd_hca_cap, hca_caps, vhca_id);
 
 out_free:
-	kfree(query_ctx);
+	kvfree(query_ctx);
 	return err;
 }
 EXPORT_SYMBOL_GPL(mlx5_vport_get_vhca_id);
@@ -1363,7 +1363,7 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 	void *set_ctx;
 	int ret;
 
-	set_ctx = kzalloc(set_sz, GFP_KERNEL);
+	set_ctx = kvzalloc(set_sz, GFP_KERNEL);
 	if (!set_ctx)
 		return -ENOMEM;
 
@@ -1392,6 +1392,6 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 	MLX5_SET(set_hca_cap_in, set_ctx, function_id, function_id);
 	ret = mlx5_cmd_exec_in(dev, set_hca_cap, set_ctx);
 
-	kfree(set_ctx);
+	kvfree(set_ctx);
 	return ret;
 }
-- 
2.44.0


