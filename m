Return-Path: <linux-rdma+bounces-21206-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOaWDC4cE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21206-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:41:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D45C2F1E
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 445A4300FB39
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6783A8727;
	Sun, 24 May 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ruaQqikj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D413A7F4E;
	Sun, 24 May 2026 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637149; cv=fail; b=sFzKq1Q1hTTTylKasiA5XHn45SbPHeVcRZ1HQNHWkPCgvcqnZACozmSMstfvgZxxm95gM1T7srvuhOU+YHMwbSXLxcPe9xqA3on0EV4Zk5DqLcqxAQCauy7vbxABAwyFQfYuKDO5ETmoDT4z6CxJM/X25ZW8/QF24pIhJF5neyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637149; c=relaxed/simple;
	bh=IO9UVGCzaYMLI3y0XZqR3W+GMMcLZMYIHIB0CqftFEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SXuk36LTreWPnotye+WPL3cO1z/KCvsogCn2Ltja/MjRRQnlkkRerUEpiw4rHXk66RrkaOslEol0Z1KwXOXmezEKw5jLwU+9rkspkzd0XnvPI+FhRKXnkB1ssgFoqqjGBUKIbaVF71PT7jiA84lCaUf68ok80rEoD57nO2yzeJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ruaQqikj; arc=fail smtp.client-ip=52.101.46.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lD0a+MmuBoSIDMWTfgaJdCX+nQzJmaTMgL3GRUwxT627bYF37MSi4qstjnleXiZiMHJfR33PNBy+Tat8qMAnMfzb8pjeihf41FRqS4p4kHncp3bEK6WDs2va2GREhZqS+0DXOiIcNB+qAf0shKWIYwX+mOC5RyAdgj/WplnR9WircTMoJ47xOSenw/L3Zqh7SP0mGY4E+nZ2CoBPG0xm+D2AaxgIuPsBzaMKy67g+f9WyPwKOWkfnHg1pzGJBDFMH5wtPz5BV1ycuMAvtu3JJ9t7NlMi6nfKnLxo0+5QiozMjI7ywp+r5O9Xpb2pt6/2d0VXqupMBKygjbPwYh3ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ0NDdjzCcUE5famyGxNqZiEdty600qdtaIK/WLg3L4=;
 b=PZ4HYJOfTvgMI1ee0DCFCaZ06Zxp5QMTwjXpizNxTzpCjm4EN96ULhqn69ejovmEP9LLjMTLJj5+WXACXEbkxjF/aXcIb3ED7bR23FwljDJIgHgsGAdEx4cWj39l5FJvbiXRE1zIenxBXOkpbO6hJtT4xXOG0/q7syPC4XJrZSX1CFx6R34nD3QEb/r/XlzCoP6/h/ERHYT+8s7ou5T68s1WoK3YDts3JNnOzSlDzcy2uognJ9iiH95mXhdzTv3QPSrb6pKe+uqVsRAi5kWjfPaZPuu1zdZy7vPKnEIlHA3hzMy4JNotDulL+KVt1vbW+E5K+tiM3VMKorFhZgvLPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZ0NDdjzCcUE5famyGxNqZiEdty600qdtaIK/WLg3L4=;
 b=ruaQqikjqKE1TKEPgD9LGNVej+HLntpkKUht50uwZSQ4+m/H+tctahTrnzmhjzatMskqrOb8nFzF9puxmzW6cMFH1jAvz/kdQ0bCxA+Lzp67E8F2f8D99OZS52AgU72b8Izvc9eDY3lUByKyeIHpA/W5vsGwAH4chxQ+9vWmQhg++5+tMYkjfozd6zO2xnkCilsMLeU6wX/+w/hyimLAJmdM37gi/8Y6iGVpA6Um3ZfRM0UD5eqj1CMABxPjuPn26QYRXBBpiamXcvu9poNXyE4hrsxPBBXewM6DX56qXYpA+jDQjZAnj74DVIYZS1p1m7T2RMCc1LfB0D4ty6a9Jw==
Received: from PH7P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::14)
 by CYXPR12MB9278.namprd12.prod.outlook.com (2603:10b6:930:e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:39:03 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::e) by PH7P221CA0044.outlook.office365.com
 (2603:10b6:510:33c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:39:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:38:52 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:38:52 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:38:48 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:05 +0300
Subject: [PATCH rdma-next 4/8] RDMA/mlx5: Support deferred rate limit
 configuration
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-4-3d79439f8d08@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=2893;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=08RdpkAd8x4ORVw/pTBMEhLI+WWenUoFVQjGVkVNC+I=;
 b=SDOTkpe0qCBwNu9tvGYtza71LiY3sRtpQciDAY8CrUyBgZLX4X9z2kSNNZa6vMbD3JCPB+zy+
 ioGkQvilrG1Cwg6zwmbD1YgeZtz0mK+dMo7H5H37NEeS31c4oBGvp4B
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|CYXPR12MB9278:EE_
X-MS-Office365-Filtering-Correlation-Id: c89feacb-0104-43bf-244a-08deb9aa9502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	uvdWX/xdxOkbRDVbYsIQzfHjZaLRwCc+zngVO7G1pTXdMZrS0NayYNpKwN4p4Y9K4XtpNsrlat6oBGLXzmBaSsFhKHUrAE8krvUQ/ns5j8xL6fWLQJ4goMMBsmkZeZ8DrRGQaWID1CDNf1ByxylNf17iRuiYkQq1wlnedklFRS9EfyczjuYftCXUWVP1sSlTzsRrfSlH9T0cV/nd/IwD1kwx5AtbdiZFsryvvCZ98aGclJn5Kke4Wp/EhYgPNbKSFYMqbbbvxqgPY8vVwaaBHPPIhG9RCMEGpbj5fPgluwIHLXKqd86hyDETBQKHmzc5D23oR3oybJCTH9e3aHho0XQinwZxZmMC/GFlhFsYGLihcfBx0Q3X+ZvTPkL+EdQTTKsbMebKEX2qhJUQvjIvkdtqUCV2g+N6M5KG1ktimCV+4benG6bBRLVidQAdKjVW9MZzRmlcJHOMbLbi8NDpnCgNOT3Q1aFEy3DBewMLFTpHeD8B27fofCZR6VngrUT+AwhynvjP3qeMUILeE4hheMHb7aiz7B7BXFkzCR+6YEr6/9i1MQJNyktj524eeAeivxwirtnbyY5RKU4DuiXaBbNHEJvmHOH+dvGPiS83IFfpoj6KG+1aAoPQIN3uqzccIammRZh5Vbb4mbqe8od3QnC7ZC+UBYRThaQpy7MZvjdpik7NYc+qvV5jSOC6tnE6/fawNAb/gvZfXtKMR64tWH03UZjj40+qYzPmZuvR99c=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(56012099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0BBQzb7KFZEPdRoZMZiN7SbdbJuWIOkToRFjyPsvoLN2GixkpD1vcLRnDaKKQlx0jYOw+TzyP40D3fqJ6RAO6Pf1h1tq+iq3DNn38997Vc09atoICKxS29XaO/ZgZ462wdPjXgzk87B+eh/bAnpaO6GBCJVgxZuu8aohT9s4w9zKUolZb5mcUXPupRiyMqOdlVMDMhrcpHlLMuz8Npkz6ROMtwpPTSFf8LxWwYFsukNzUXPKgQhfs0RYRpxfe+DEfQuv6ibYEFa8wP8AgQArxLBaKeH3+TTci8whTIDQxehBjk0jMAegYHy7+qFJq8m9ip5/mmQmxlu2ds9huwer0PHNgOT/GcizOiHKrtocQxr6aq3g0wWAMb++rKVqvY+gx0x+6TzTQQU6FKKT5rKqNZmIA7B+1KjeGLpj6DgeJhvIdiFVnylm6gxaSgHbjBnq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:39:02.7417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89feacb-0104-43bf-244a-08deb9aa9502
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9278
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21206-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 320D45C2F1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maher Sanalla <msanalla@nvidia.com>

Allow passing a rate limit attribute in modify QP flows even when the
QP is in a state that does not support packet pacing programming in
the lower layers.

When the user sets a rate limit during a QP transition that is not to
RTS, store the value in the mlx5 QP struct and program it to FW when
the QP later transitions to RTS, which is the state that allows
configuring the rate limit index in the QP context.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/qp.c      | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e156dc4d752996cc4ae465bb567b0c1305d07fed..c74a53da99393cf4d4c0823cd12f9eccaa28f212 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -536,6 +536,7 @@ struct mlx5_ib_qp {
 	struct list_head	cq_recv_list;
 	struct list_head	cq_send_list;
 	struct mlx5_rate_limit	rl;
+	struct mlx5_rate_limit	rl_desired;
 	u32                     underlay_qpn;
 	u32			flags_en;
 	/*
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index e96d26253e3b1fabee23947b1a61ab26e7c7067f..66ab16b017c8311d44b521c023cfaf23ac42190a 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -3946,7 +3946,11 @@ static void qp_rl_commit(struct mlx5_core_dev *dev,
 		if (qp->rl.rate)
 			mlx5_rl_remove_rate(dev, &qp->rl);
 		memset(&qp->rl, 0, sizeof(qp->rl));
+		memset(&qp->rl_desired, 0, sizeof(qp->rl_desired));
+		return;
 	}
+
+	qp->rl_desired = ctx->rl_desired;
 }
 
 static int modify_raw_packet_qp_sq(
@@ -3990,6 +3994,7 @@ static int modify_raw_packet_qp_sq(
 	if (new_state != MLX5_SQC_STATE_RDY) {
 		mlx5_rl_remove_rate(dev, &ibqp->rl);
 		memset(&ibqp->rl, 0, sizeof(ibqp->rl));
+		memset(&ibqp->rl_desired, 0, sizeof(ibqp->rl_desired));
 	}
 
 	sq->state = new_state;
@@ -4449,7 +4454,7 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 		if (err)
 			goto out;
 	} else {
-		rl_ctx.rl_desired = qp->rl;
+		rl_ctx.rl_desired = qp->rl_desired;
 	}
 
 	op = optab[mlx5_cur][mlx5_new];
@@ -4833,6 +4838,13 @@ int mlx5_ib_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 				    attr_mask);
 			goto out;
 		}
+	} else if (attr_mask == IB_QP_RATE_LIMIT && cur_state != IB_QPS_RTS) {
+		struct mlx5_rate_limit rl_desired = {};
+
+		err = qp_rl_parse(dev, qp, attr, &ucmd, &rl_desired);
+		if (!err)
+			qp->rl_desired = rl_desired;
+		goto out;
 	} else if (qp_type != MLX5_IB_QPT_REG_UMR &&
 		   qp_type != MLX5_IB_QPT_DCI &&
 		   !ib_modify_qp_is_ok(cur_state, new_state, qp_type,

-- 
2.49.0


