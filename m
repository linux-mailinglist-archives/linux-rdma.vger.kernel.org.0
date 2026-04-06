Return-Path: <linux-rdma+bounces-19009-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPNZINh402nPiQcAu9opvQ
	(envelope-from <linux-rdma+bounces-19009-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:11:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC3D3A278F
	for <lists+linux-rdma@lfdr.de>; Mon, 06 Apr 2026 11:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 328D63004D3D
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Apr 2026 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152431B823;
	Mon,  6 Apr 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RwOENUnq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD62317165;
	Mon,  6 Apr 2026 09:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466704; cv=fail; b=V0G0zpt8npuDkX7SJQ+gg8MNe8sWgx1SgfJwhYo78WBLWiKnKxTVU6aLKWBHgkwjXym0Ui9e4G0ikWrkH1tSKqAYWI1xQ1F/5lMpALc5NaDKCjT6pncaYFshcMPpM7MtgBxhVwG01UzKiXchBunx4qnuOcI8BlvuBluy0MMNCKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466704; c=relaxed/simple;
	bh=6H/CzLHFboiN5aRfvcuHGsDkPb+QLlbXjGJuB4jtRUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UYBfBP0iA2/g9hmk3fHgrJstsBBpzYolFSwlNppR3d1UldtcyNrYTxl86zrQebRoe5Sbcn/bsClXg0vsK5tEkprk5oEyonpuN64VN8wPsjrI8feZ6Q/iRYZChdwict8Lqfwc+TKk1V2RZONQ2RkfZj2I45hVJF3qABhNtdjFGaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RwOENUnq; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIGLahBNFZ2SSTJbQePwIpmdaHpUUURrWVjq8OOvjdWBD0F7h7BLSUlDesMQu58orIe68V3jGw5UpQjjahr16Bj/ZH/3kdmYCerqfLVZMae3Y2TQcwRKUHBMH5nM3e9GXhEsU0pRoBD2lDuwPqhV8zl9W4rmndnM9IaFGVWelkGhxDhIqaHDn0fqCz+mNHWKRJwZzrKKM6z+g8Jum6ybjel1umoJQUxi+/eAIf39wDpRi+O6WfF05yupFvZC9yyaRBN/Bs4mzFLIZROe7wwcopQTz0Pk9lbtI00YcwKz3IiuP+YOT7bt882axjt/Mz2B0D2sZ7xvo9mV9ISFCPwCIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwplSS1KMnMSzQ4V5xp4TgLA63kFrlOfesFAYVtgRoc=;
 b=wCEgW08uYixldBAsibOUwIi/MJU0IGSyvSboLz+Qb3eel7CE3FL5TEVr/3Ule5fQZNbTCFRrfsilQ8QylU5JHiLyROQiMQlL784a8FSdVKkfMZhf1NMINAmJU6xc8uTagd9hjIHQ27AgHF25yW9vTXHxVzaOoo3+Jl6nIDqWYGsY0pWabhyQWNCkegR3fNGMlzjWgFedUojpAjSiGXOf9lH2bm/Hj9nraOMXDoHj7ODkNPGYMmimFL/nCBKXRxVMU6q06m645nElN1qzainVHbL2zU3YebW2IkzWPmqhJXEWyIHble264wO5RuNO49O9vYCuchyi1qWUAicrbzJh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwplSS1KMnMSzQ4V5xp4TgLA63kFrlOfesFAYVtgRoc=;
 b=RwOENUnqoZBvHerSOA1pS3rEViQblebFMkpQEGXmkqXhqDDVS+AtDmbmnRJSjNf8qAvuR5bAtVxmPmUzQYAkxz9ZLW0HSMV5uGEPbtrNlJIRm05bX6j8libCYsGL/NxvR86iZvwphfcu4zcfRCp35nldbDd5lzdtP1MVAJj3CNrDKjTpNjOQJ7xHQO8UYSU+CNDDH7ow7aFAzGjBhw9Cx882emDUs3GbyDe0GSRSqcw66cj9QEYXz5BFOYitOK/RjQztNBm1bPptck5Yk6HVV9uht2lDjbQPJ2uUdE2PFg5bk4qbpjPMK/F4mZrMAxmKOgSS2IQ2yBeBPT8Eqn2RMA==
Received: from BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) by SA1PR12MB999084.namprd12.prod.outlook.com
 (2603:10b6:806:4a1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 09:11:40 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:207:17:cafe::53) by BL0PR1501CA0024.outlook.office365.com
 (2603:10b6:207:17::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 09:11:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 09:11:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 02:11:27 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 6 Apr 2026 02:11:26 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 6 Apr
 2026 02:11:23 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Mon, 6 Apr 2026 12:11:12 +0300
Subject: [PATCH rdma-next v2 01/11] RDMA/mlx5: Remove DCT restrack tracking
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260406-security-bug-fixes-v2-1-ee8815fa81b7@nvidia.com>
References: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
In-Reply-To: <20260406-security-bug-fixes-v2-0-ee8815fa81b7@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Chiara
 Meiohas" <cmeiohas@nvidia.com>, Dennis Dalessandro
	<dennis.dalessandro@cornelisnetworks.com>, Gal Pressman
	<galpress@amazon.com>, Mark Bloch <markb@mellanox.com>, Steve Wise
	<larrystevenwise@gmail.com>, Mark Zhang <markzhang@nvidia.com>, "Neta
 Ostrovsky" <netao@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>, "Doug
 Ledford" <dledford@redhat.com>, Matan Barak <matanb@mellanox.com>,
	<majd@mellanox.com>, Maor Gottlieb <maorg@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775466677; l=1983;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=JdRkUYRq0pIWwuMSpYFF7BClsUMppMUSBJcSiThyysk=;
 b=0vieZ7tQ604hpsCy/8LbWyB+F7Ph9Gu/HynECWZ3O9c0tyrWejHuRPEZpIe7/2IhNjOxcC6/b
 1Wbj6uv8p6ID9bqgP/QhNa8R1fYpp6Tm37jf5uk6sqgnm/CR9NwQwPN
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|SA1PR12MB999084:EE_
X-MS-Office365-Filtering-Correlation-Id: af9a16c5-c0f2-4309-0861-08de93bc8364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qGmaZxDmKNZrQO+II5NgUP9MLBjfwuTT9quwTvGTnsWXzlrRhGbCqL4Uf6g8P/PQM9z/cT9ayGUHOiOX1eQBfvO4KfDFm28Lge/+WFN5vOnHgA9bXQ2Uy7YLk7JL0IWVNYVTMMTLLcyKcTnwIALEESn0WLD7KvMRUn+kMUjb/WkdeB4P4CmUcYURx+RpHTv0vTsbQMdpUZBAXSaRxjGlXTVEHkBuvc3TrhfdaNge+1l1oJ/GYpst/7Nke//paaefAznhU1IR9g4GZ98w8iwhfvX2JOO65eU/GYpCh4AHu8NooZ5/btCwLjrc0Q9+3GvNotxkCKzpm5FxispDQlinAbp2T7/QX3YAHc08G9FqrarB8/osqTcaW/Cb5OaEQGkQVykxr9oiVSL6f4yqXXnU7HEdQLi+4cT31y1wWSJu7pvBUSyNEKFlQs/WhirxkNMUGLjmkqPdqH0nBCUSpY/1Pr9isPU0RWXfmjivgtY9Xwd2YBdw6QiVpYKsgDi1qaoNvFPXvcWXnCfR6mCz7Zl3HDX40yG0JV6dNepJyDBj2Ufg3XqzBhLXJR+4GFwQNpmg7eTE588IHaz5+hiU7Z/zX7yYr0aC1JBn6T8NDndSy7bumAYepdVjz+vDSKJrd20Aal0ewCIcR3W2eUmHz4KQG/T/atFcgJMX0JLfU5R8CYmlMEpxgaVtavPYSuZVuWxcG8G/T34Gb1nweKhYCsF2Ue8i9k6hpulQ3y4OkXeoK1k/79goF/CIypC8H6T8ZJUG2yQxqTX7KdsGmHB1ydjX9kY8Bo+I41t74CcRr3N+qHl10P3tUcnU3kHFwWyXlcjX
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pgV4HnszFR2FERDEirFphGgN64TW5ybbol6PoYgyQ7fFLa8pj7VVQLuochTCLPN3lvKE9AmkbOYO7/100iVR9k1kf1fczS2+eJ4wx+/MBmmeBtkTNTe6c9oeYTbX/frLiU32qehxfIj0w1nJvL2nMCHXdtnuyhtxV9GX3sRNBAwyZfe3HzA/HfsZJ88VGg9MOco0A9noJ5OCvP0nrImwoOijqaURZFTtU3GJK4tMnpvN4InhlAv8HkEtPe2lTbef3Hxd4UDeRYEOtDVYo+u7aSpS9o2oUV95Gvey9/IAUhn07z//A+aOSqn+6BHy2rDdQq/8tNtgNi1jAJJZ07DMUG3KLPfssIXMm3S2VcBxDj1DkBKxehmQW+EccJTTXjDgPg3TNVOMhCak9LSaeCThilZF5E77YHkFf5VQrPaTh9ljQX5vM3a2z+DFbFL6/jjm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:11:39.8868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af9a16c5-c0f2-4309-0861-08de93bc8364
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999084
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-19009-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,ziepe.ca,nvidia.com,cornelisnetworks.com,amazon.com,mellanox.com,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5DC3D3A278F
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


