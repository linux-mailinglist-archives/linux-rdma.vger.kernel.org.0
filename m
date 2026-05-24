Return-Path: <linux-rdma+bounces-21204-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHmED80bE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21204-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:39:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3B85C2EE3
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CB4C301A7D3
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059983A1684;
	Sun, 24 May 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HYzphiyR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142E639C00E;
	Sun, 24 May 2026 15:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637139; cv=fail; b=uAOy/X1b9qcuTgMM/FDa1iDZ88BNhw07YaMJFsGhDNkpBG8GM8ccWDHStG4o19xN46G6DyNg1atFwRVIJbmGqbEy4AKtOs3jZFUwZ+4hlN9Qn0BsZK/SQU+Ofu2ZQJjYGSYgcYOcZ+4qBgQvqutaeLtkUT6WiqSXyywF1CzH3xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637139; c=relaxed/simple;
	bh=0J+mQf9JHq9rd7TwS/Xv7bpX0wdS7jiMuQSS07ugqEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=L7/Yi3+AVZBkDE/vODIpwGFmyVz/nwM7uJWypCrUTgsBlQMQgHSYpvrx5guHCbcY9BRBIMHXIeCpl11Goh1jOcVFS0cRbr6Yr+bD8BapMYewxnjHa3gK4N7uDpKQn+PR38bXsXbCN5g6FCVQtJ7i/IK9dSjMSEX2QQGPZslujuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HYzphiyR; arc=fail smtp.client-ip=52.101.46.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HijKBKv+Ag5E1Moc2FUNCartIvdAsdy6ZAscPiHLr0vvR1XL/Cn8u3SwbLFCd+i2RST8b1b+vv2ZezzV/UyXkLGV0yoktAiETVIl/EQMJFCiTGwuMpi7RsiUHxAa/UrfcIDTeRmJqmLPNaJcgJ6Vj9fqyksuvbFplNDA42peiWsOc0iNosJwrjS8gNW62rikDyrpH/cIELi+zBenMvTcE2dEdh/89tGJ+XKs5JLrUUw7xR3j9S+khAnHPmoavW1nUj3FHvVpkcrWLr1TT+BYN2YMdvxTPB2O+d8uJFI3Z8IWY6w1NdDTPSwIfRKaJ7j7wvZw/2BQcoEfUFvYc39zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvPqimVQ4vdoK5SWoQ+54eqbccfFQJDrkkEIAU0pjZY=;
 b=H9eCDROKQVmxrJTpi+GeIwRC3jXmkRxi9HSdf+TpN/4KKcIcSap8Zb0n6lf9gDg1687gQhsP9tfqV2pyPeaKutsjlbbw6G7IvWp+6zUWaQCTgTFcxpft0cPPJKGsAoEYaQ0ucXwK+WP/mn+fECQbyZFu/J0M5XqAk4N6WwjQIr7ur9/7gg+Cz8WOShNE0xYRrQkR2ub2qzFRib1QsWwcceu8oHFoSjpQTWoPo7tQdgW5olDWqUt+16xG3ZN0wmC+GsBmScLx9U1/CMvAXXmAbq+FqgiTMqT/tKet9FIwUe/R6b/BHsnV/demhacJgWk3dxpZt1g/9lEv39lLFqFE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvPqimVQ4vdoK5SWoQ+54eqbccfFQJDrkkEIAU0pjZY=;
 b=HYzphiyRqWiS2PColj0jfVXcEKX+Lkl8RWxhFPgLf9frpFcUHClX02I8vATrd5+SciebAgNZm5tQsjoeiijsEc0rvI9slioX/6CjkXA0p9DTKM7fymmF/uSLowCrr/LYUhV4kTJGyezn+mEBFgrfRcEdMgiY11uWSd5T0IaMw+rwwimflRdKXzMb0tbu7KBzSRCCv3uELJP9lRs2cKyVgtMGGwdf8HTFgX+T9qT5md5ewjjYaKMBvKxUCAEbEkhs7e4TDk67/EOhzZaDvNw5gpVTWIZ+pfnZt0h78p60AV8GkWPuiDWHbhm2QrSxTJDPbz/Yqa046zsrMbDRKrL/6w==
Received: from CH2PR14CA0033.namprd14.prod.outlook.com (2603:10b6:610:56::13)
 by IA1PR12MB8191.namprd12.prod.outlook.com (2603:10b6:208:3f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:38:49 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::3) by CH2PR14CA0033.outlook.office365.com
 (2603:10b6:610:56::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:38:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:38:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:38:44 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:38:41 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:03 +0300
Subject: [PATCH rdma-next 2/8] RDMA/mlx5: Refactor raw packet QP rate limit
 handling
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-2-3d79439f8d08@nvidia.com>
References: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
In-Reply-To: <20260524-packet-pacing-v1-0-3d79439f8d08@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Selvin Xavier <selvin.xavier@broadcom.com>,
	"Kalesh AP" <kalesh-anakkur.purayil@broadcom.com>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>
CC: <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Edward Srouji <edwards@nvidia.com>, "Maher
 Sanalla" <msanalla@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=7364;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=aMdzEQA2h9Tbl/OwxGv4RhGEW1T9ZhYtVG93Cu5pOmQ=;
 b=E+V3FECwioAEmjTevNqO+RkWDNgD/qjzaZqAx0Fqy3vB5zCzyWvzTmARDQUkDbu1LrJkyyHkI
 FuCfoWePhWvAYMswl/xSG1ezVC6UjPNkXHBfwHQSpj11gbVmmlaXZzV
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|IA1PR12MB8191:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1f46ff-d2a7-40d3-ab65-08deb9aa8d1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	33JDfCjjGwM66CT2sVh9BwUOyJ0finhJU0wS5JQW7iNDGxDt8M/rWPTfcbt8zrAcP3RoeXor7gCv4ab0YmmFcn38V1ESrpDmJpgOdnbs/J91ASSRTU8xL2rMwEhKxCRL32S3UJRV720Ic3kTwmREesCZrBk2/IMI+UW5lM5XAcAC0+0uJP3JhQE77zDKcmYYOi+aTQ2p5WubpyG8k1ra67xiMtcCIsHr0+anXkosUQWJWnu69Mxu2FFMQ910ks/pubCYypjn9FxluwBGJcif/0uhSiaDv+ZK4v+sbbV3oGNJwL/HSZMyqm/aCJPCmAdmTdBOUIbq/Kk5kXjTorwFnJIlcKP4t0Y+rIlneohOfl74gOQGr4r6I6RMrc1QQmzno1hPdfjTn6JC0V/3pFAw6ELvyw08k6tHbrp0Rb+37Ohfq6t9aQvTdPDflB//vVmJEzuPwftXrTbX2A6SlSpdtU1KtLiyXN22IzmapeFT7vhb2XVkkM4rI8sdqZMmFiH/Zusveryx4+Q3eeT3N4rXyM76ejCmQLOXj1UVE6JSmfE9DBYUUekfLjEUD6jk7ABA8TqFl8PLq9JrC+g2Iur33xy7L5Ke0E0BjqOJSFdVk5P8/V2BHHXEasO+CnG81yYjDbYTAwCMa0ple3cU6mfMzH2i8iqewc+6VH4odg1xYzN7CbTPnoQ3VbN4OpvdWIh39rLuI94UYTEjdgqio9TkOU4cc3jrV+XAu9+g4bmHX54=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c/rcHh4tpUWTDsRUthcF+WWqjUAb7Fv+5C7yPRTFvQ7JQhHBm6Rru+9k+0+CS12+JwCpe0Atxw35ti6Mluf+blRlyKGFPDhgqzCudfCmxKYINsYl/8jSsgU8KoZzKXwTkOlhkEf/JV8hn83tgOZjUo0Sic+cQy7J6+l2JemDEjoUtfrXOd1omni0jx5o4snWsW7CovfftgCOlJ6bJkGVgGfPLGKDEEYhdHPtcCPSsclDFeSKO+G36CM+pLgB+IiP1K8yiLGeypQRd3mX7fJPg7OeWIKhxNUyz0JnwDGo3JPjF0HMc7JGRgfxeXc6Yx9Zz/OjZp7eVFSZAlLVQobgIZi7IWDAN+Fc0UwW4fiYbO5ENKeOHbnfN9q56NFQPm4+ZwmLShDmEm11Krfa61alUDO4wCJXtUi1Pf9zDZU/DVNOpvnUm3N5hDtm9u4UNgM1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:38:49.4875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1f46ff-d2a7-40d3-ab65-08deb9aa8d1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8191
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21204-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: BB3B85C2EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maher Sanalla <msanalla@nvidia.com>

Refactor the raw packet QP modify path to extract rate limit
configuration into a qp_rl_parse() helper that parses user attributes,
and a qp_rl_prepare() helper that handles FW rate limit table
adjustments before the SQ modify itself.

Use qp_rl_commit() to commit changes to QP once FW call
succeeds, and qp_rl_rollback() to rollback changes done to
the FW rate limit table in the prepare stage, in case the
modify operation fails.

These helpers will be reused for extending rate limit support to
additional QP types in the following patch.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 168 ++++++++++++++++++++++++++--------------
 1 file changed, 110 insertions(+), 58 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 6f88f9c52ad09860474824c88fdc73858045bbd0..fde319a021908317d96f3cdd212ea5ebf691f13a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -64,12 +64,19 @@ enum {
 	MLX5_QP_RM_GO_BACK_N			= 0x1,
 };
 
+struct mlx5_rate_limit_ctx {
+	struct mlx5_rate_limit rl_old;
+	struct mlx5_rate_limit rl_desired;
+	u16 rl_desired_index;
+	bool rl_changed;
+};
+
 struct mlx5_modify_raw_qp_param {
 	u16 operation;
 
 	u32 set_mask; /* raw_qp_set_mask_map */
 
-	struct mlx5_rate_limit rl;
+	struct mlx5_rate_limit_ctx rl_ctx;
 
 	u8 rq_q_ctr_id;
 	u32 port;
@@ -3833,15 +3840,88 @@ static int modify_raw_packet_qp_rq(
 	return err;
 }
 
+static int qp_rl_parse(struct mlx5_ib_dev *dev,
+		       const struct ib_qp_attr *attr,
+		       const struct mlx5_ib_modify_qp *ucmd,
+		       struct mlx5_rate_limit *rl_desired)
+{
+	rl_desired->rate = attr->rate_limit;
+
+	if (ucmd->burst_info.max_burst_sz) {
+		if (!attr->rate_limit ||
+		    !MLX5_CAP_QOS(dev->mdev, packet_pacing_burst_bound))
+			return -EINVAL;
+		rl_desired->max_burst_sz = ucmd->burst_info.max_burst_sz;
+	}
+
+	if (ucmd->burst_info.typical_pkt_sz) {
+		if (!attr->rate_limit ||
+		    !MLX5_CAP_QOS(dev->mdev, packet_pacing_typical_size))
+			return -EINVAL;
+		rl_desired->typical_pkt_sz = ucmd->burst_info.typical_pkt_sz;
+	}
+
+	return 0;
+}
+
+static int qp_rl_prepare(struct mlx5_ib_dev *dev,
+			 struct mlx5_ib_qp *qp, u16 op,
+			 struct mlx5_rate_limit_ctx *ctx)
+{
+	int err;
+
+	ctx->rl_old = qp->rl;
+
+	if (!qp->sq.wqe_cnt)
+		return 0;
+
+	if (op != MLX5_CMD_OP_RTR2RTS_QP &&
+	    op != MLX5_CMD_OP_RTS2RTS_QP)
+		return 0;
+
+	ctx->rl_changed = true;
+
+	if (ctx->rl_desired.rate) {
+		err = mlx5_rl_add_rate(dev->mdev, &ctx->rl_desired_index,
+				       &ctx->rl_desired);
+		if (err) {
+			pr_err("Failed configuring rate limit(err %d): rate %u, max_burst_sz %u, typical_pkt_sz %u\n",
+			       err, ctx->rl_desired.rate,
+			       ctx->rl_desired.max_burst_sz,
+			       ctx->rl_desired.typical_pkt_sz);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static void qp_rl_rollback(struct mlx5_core_dev *dev,
+			   struct mlx5_rate_limit_ctx *ctx)
+{
+	if (ctx->rl_desired_index)
+		mlx5_rl_remove_rate(dev, &ctx->rl_desired);
+}
+
+static void qp_rl_commit(struct mlx5_core_dev *dev,
+			 struct mlx5_ib_qp *qp,
+			 struct mlx5_rate_limit_ctx *ctx)
+{
+	if (!ctx->rl_changed)
+		return;
+
+	if (ctx->rl_old.rate)
+		mlx5_rl_remove_rate(dev, &ctx->rl_old);
+
+	qp->rl = ctx->rl_desired;
+}
+
 static int modify_raw_packet_qp_sq(
 	struct mlx5_core_dev *dev, struct mlx5_ib_sq *sq, int new_state,
 	const struct mlx5_modify_raw_qp_param *raw_qp_param, struct ib_pd *pd)
 {
+	const struct mlx5_rate_limit_ctx *rl_ctx = &raw_qp_param->rl_ctx;
 	struct mlx5_ib_qp *ibqp = sq->base.container_mibqp;
-	struct mlx5_rate_limit old_rl = ibqp->rl;
-	struct mlx5_rate_limit new_rl = old_rl;
-	bool new_rate_added = false;
-	u16 rl_index = 0;
 	void *in;
 	void *sqc;
 	int inlen;
@@ -3859,49 +3939,26 @@ static int modify_raw_packet_qp_sq(
 	MLX5_SET(sqc, sqc, state, new_state);
 
 	if (raw_qp_param->set_mask & MLX5_RAW_QP_RATE_LIMIT) {
-		if (new_state != MLX5_SQC_STATE_RDY)
+		if (new_state != MLX5_SQC_STATE_RDY) {
 			pr_warn("%s: Rate limit can only be changed when SQ is moving to RDY\n",
 				__func__);
-		else
-			new_rl = raw_qp_param->rl;
-	}
-
-	if (!mlx5_rl_are_equal(&old_rl, &new_rl)) {
-		if (new_rl.rate) {
-			err = mlx5_rl_add_rate(dev, &rl_index, &new_rl);
-			if (err) {
-				pr_err("Failed configuring rate limit(err %d): \
-				       rate %u, max_burst_sz %u, typical_pkt_sz %u\n",
-				       err, new_rl.rate, new_rl.max_burst_sz,
-				       new_rl.typical_pkt_sz);
-
-				goto out;
-			}
-			new_rate_added = true;
+		} else if (rl_ctx->rl_changed) {
+			MLX5_SET64(modify_sq_in, in, modify_bitmask, 1);
+			/* index 0 means no limit */
+			MLX5_SET(sqc, sqc, packet_pacing_rate_limit_index,
+				 rl_ctx->rl_desired_index);
 		}
-
-		MLX5_SET64(modify_sq_in, in, modify_bitmask, 1);
-		/* index 0 means no limit */
-		MLX5_SET(sqc, sqc, packet_pacing_rate_limit_index, rl_index);
 	}
 
 	err = mlx5_core_modify_sq(dev, sq->base.mqp.qpn, in);
-	if (err) {
-		/* Remove new rate from table if failed */
-		if (new_rate_added)
-			mlx5_rl_remove_rate(dev, &new_rl);
+	if (err)
 		goto out;
-	}
 
-	/* Only remove the old rate after new rate was set */
-	if ((old_rl.rate && !mlx5_rl_are_equal(&old_rl, &new_rl)) ||
-	    (new_state != MLX5_SQC_STATE_RDY)) {
-		mlx5_rl_remove_rate(dev, &old_rl);
-		if (new_state != MLX5_SQC_STATE_RDY)
-			memset(&new_rl, 0, sizeof(new_rl));
+	if (new_state != MLX5_SQC_STATE_RDY) {
+		mlx5_rl_remove_rate(dev, &ibqp->rl);
+		memset(&ibqp->rl, 0, sizeof(ibqp->rl));
 	}
 
-	ibqp->rl = new_rl;
 	sq->state = new_state;
 
 out:
@@ -4376,34 +4433,29 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 			raw_qp_param.port = attr->port_num;
 
 		if (attr_mask & IB_QP_RATE_LIMIT) {
-			raw_qp_param.rl.rate = attr->rate_limit;
-
-			if (ucmd->burst_info.max_burst_sz) {
-				if (attr->rate_limit &&
-				    MLX5_CAP_QOS(dev->mdev, packet_pacing_burst_bound)) {
-					raw_qp_param.rl.max_burst_sz =
-						ucmd->burst_info.max_burst_sz;
-				} else {
-					err = -EINVAL;
-					goto out;
-				}
-			}
+			err = qp_rl_parse(dev, qp, attr, ucmd,
+					  &raw_qp_param.rl_ctx.rl_desired);
+			if (err)
+				goto out;
 
-			if (ucmd->burst_info.typical_pkt_sz) {
-				if (attr->rate_limit &&
-				    MLX5_CAP_QOS(dev->mdev, packet_pacing_typical_size)) {
-					raw_qp_param.rl.typical_pkt_sz =
-						ucmd->burst_info.typical_pkt_sz;
-				} else {
-					err = -EINVAL;
+			if (!mlx5_rl_are_equal(&raw_qp_param.rl_ctx.rl_desired,
+					       &qp->rl)) {
+				err = qp_rl_prepare(dev, qp, op,
+						    &raw_qp_param.rl_ctx);
+				if (err)
 					goto out;
-				}
 			}
 
 			raw_qp_param.set_mask |= MLX5_RAW_QP_RATE_LIMIT;
 		}
 
 		err = modify_raw_packet_qp(dev, qp, &raw_qp_param, tx_affinity);
+		if (err) {
+			qp_rl_rollback(dev->mdev, &raw_qp_param.rl_ctx);
+			goto out;
+		}
+
+		qp_rl_commit(dev->mdev, qp, &raw_qp_param.rl_ctx);
 	} else {
 		if (udata) {
 			/* For the kernel flows, the resp will stay zero */

-- 
2.49.0


