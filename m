Return-Path: <linux-rdma+bounces-22111-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 967eCa6vKmreuwMAu9opvQ
	(envelope-from <linux-rdma+bounces-22111-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:53:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E96720D3
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 14:53:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="t/EPuebV";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22111-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22111-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6460E308392F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 12:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE6D63FAE08;
	Thu, 11 Jun 2026 12:51:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195E3F926B;
	Thu, 11 Jun 2026 12:51:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182288; cv=fail; b=HL2T/Iz9rq6RQB/QN7WMySXlQlTQd4DoYQvNg512MIhrFHBWgjnA7/6c1RrfChB/gxlw5GNFyedxG1JN4oIqaBLgD3AMN7Ioc3tYC9l79aVQNsDO5Ds4G1iBepKHS3Ymz7hToLUfABguTfXQTqRhSwe8GX7ZAzEbsnErdLlMCvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182288; c=relaxed/simple;
	bh=uZqL2Y6HnL46L3sx8FsGBNPGmt3dFY3v1Dd0tE0TqCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qGIg7gq8kvV3zMXRy8q4ARLbjSmVPCQUG4ATeJXKh/l6GuX4JCFJE8Z1/OqomD9SGiC7FjIB0GU5zSws3dOBh/LzcXmvrtbNgdujv7Rfk1ukaog1uyVcVNp1/Q3hAWFQQo6K/ZuF1sdNT0KBrubUTkW+HGEDCSCFBGTauz2RHJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t/EPuebV; arc=fail smtp.client-ip=52.101.57.17
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJl/Lf3BaypzvtgMobwCYGGCEqk/2U84NpOlX/s0jV0tkqr+KD+ryKIrpctBPcJP0sVRipYnJB8kcH6KZvwl6eUvPwYeauj4nK0N08fpH9+BiJgvHP59OAKJAJOBLg8U0hgN0+amGfReZrpK0cfGvpSHIBRLrziTxaD35nO65m0Sc/1F7FYBV+gPZfUwnSlOe8Skf78+Ldz1fijBM6+IWODEoF1JGpkG70fcoeB/7DB2YoU6yuK+7jCeO7mhx+oOp6/sR+5+v1vzdhV+zU4rRXuqdEIDJ/HLcMwgKqWMJx1fLqvnZbBiLMecEW9DHD9KZpetQKFtm4rxpjvqH/ucqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8JvSBvlPI98IZGNNJB64SSwirKvL0DowjmvrBXIllc=;
 b=LNl6J6qKrodz3nQ/iFLK/dz+BnqgTYeAoTY0dTz/S2GHhY/Mur5qQo+60IyMGPERv4cqwz/DDLiuRf5nWTm/spE5qk9QlFoP2gTx0nqKu2sRJNcV9YVVfjy9u/DrIIGywREFnbuGy46M7ow+lXu+8QelxMhc9vGJ/A5F7R5yuBs0n20IYVuK6Ovbcvogo/F5C+SOS1ppC5AFR7lgze6sUgivEr2lqYRKLrzwS+OwfVmtkr0i1w8kTKpDboXPhdgYd69CCeGxS9xLCLlPiZyY3K8XZpa742+Fp41AEzBlI3xNARn07klmQ6Ca9IGGUXnwUcQh/g94Lkvrd309TC/gFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8JvSBvlPI98IZGNNJB64SSwirKvL0DowjmvrBXIllc=;
 b=t/EPuebVYziTkyY7gAF6TMs8hI0Pgw+yxZW1NI7qVrD9GV4RV/mFB6E84p5qMMdOImFe3XuXy+pttOK3zYDIvDEu7Yz4LRkvEy6maU4yjw0alQEPCv28dgXG5EsmC57uewYY5LCe3Tkld+C2otAgLJYfAZFK/Zqq4WRAP/nZUi8U8X6UtKwFe4Q7kpGd4ksdUnN33mVrtiZ/kXs+/P/W8TanYdc0wnggNN0+q4+nSCb/wQPWGIREdpBiw45ptpaKSrp8CMXM8qFaFNh/oSLqa5bbg5ZAqG/GtJmTezpfrj5ufLkUXmruTbnghSSEvWvzQXZWRETafCHO7bUCRcdU3g==
Received: from MN0P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::17)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.13; Thu, 11 Jun 2026 12:51:19 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::5a) by MN0P220CA0020.outlook.office365.com
 (2603:10b6:208:52e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 12:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 12:51:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 05:51:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 11 Jun
 2026 05:51:01 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 11
 Jun 2026 05:50:59 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Thu, 11 Jun 2026 15:50:43 +0300
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Fix integer overflow of user QP
 buffer size
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260611-maher-sec-fixes-v1-2-cd8eb2542869@nvidia.com>
References: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
In-Reply-To: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Or
 Gerlitz" <ogerlitz@mellanox.com>, Jack Morgenstein
	<jackm@dev.mellanox.co.il>, Roland Dreier <roland@purestorage.com>, Eli Cohen
	<eli@mellanox.com>
CC: <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Edward
 Srouji" <edwards@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781182252; l=3702;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=z1qhu04JTjgMSPOfS7ob+vopP64tFDU4ArG9kd+GARA=;
 b=gznQUSuNBjxr7W5tpkkhxcOcjdLVV8T5dZsvQdZlRedLU1tSZ4OYYngKopcm3YI/tYNGAh4Fw
 tvXq3WB8bYwCF+FB61zUdGVBOZSZokD/etRga9r541qmvVnSgBv5scC
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbc217a-feb6-4bda-2e04-08dec7b821e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mXLvZ+ZZCO0z7d+JwqguF/jDPSkMRVpderpQQs6bjt5/uWOKwdU1Yz/CvACp0Fx4tSzF7am/3E4j9MYf2zkBJqs7v7gtTVafELcKMzIjs8+DWf42oSnsQmhv70/0PHRPld2H4rpcpjP/pPhyRZwOLR9HIc99JzrCeXu7g7u5oY8AR7RUx3AfEtfkF3HeipTp7RqlZAa9gu34P7M7KrpFu7X5hVwVFXcJp5Kcn+wklJW8H0jjsngZS1NGv3tFnIeNJzhnK8Gwbf44GeWaR4OkyID2zwQKX5IFwGPQ6OugzaHrEzudGUxD1yRE1WBINbxVL6lNql6inw8iXSf9Mx/pMoRaHWKj7BNTPZCaZRbpwC+PZRHltWGNPv3MEL7aWld5lMB3LWxPyHIxKWfYhVbJCB3epy3dpZTyN9+GI2NZnosBsSc0fbFLeEVPgsb1jd8s7Ri+HjUz2A4/p+LPJwKAbD7mcN3VgVFULBX1aNc2iX9W5l/oN6SxtEqamlpdoVL4ckqGZ8ripSSuCJxe6diCMrmQYW8Yg4NGTk61vqd+nARFM9lpU5fUo897dNx8vtXaZ6NiqUTFDqavL3rR1iKrOpaE7ayy47eYM4chwYAdt2EZvMMcN6skltjk5GZhA7tguGaHbJ+IoEy3dDtQNbF+lo6xscgAtGWZj7d+rgy9tbh/5/JOjlfO9fFYZJ8YTXBbt5Trn+JcxNDcrI+kCmbflYonBSrArAjeGpyDPmgIy+c=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+oaphGZ816A6yF+sYEPSS+yH69e1LiHmojrjlg9GPwSBTpfh+jJeoqANhsLrR38YzPiU0bEkvICsr6WxzWXSgTLUc8/byajVgCNdZrlOKmztMbkE5W0+WvmYfpnc64ZzNgcz8f9l8QnZe4ESKzsGxWKoS6te/c3on/pVSfMwmcHiAbkrUVbPFI6xuCRXGq0YQXq0AfO+6cH4Ha5jKahHLeMwJ7SgzSx/mykEu/oYjFIuUKOeLk/tZrOMmppMZeEWNh/YTgQwbBvPlCQ6Re1ZgkDTZDHTrULy2BmWIXpVKyJiQTJsWRMhm39KruOldPurm4WgINGdkMKVg4/GA4r8hPzKTHTD1iaUvEtD2m/1E+4w388RIzkHI0b2TlAfXmXW9vBgIF9Q7a1K99/HpvOwSvxiSanvXCL2wFarlg6bDt+CUTUe4W4/6YoWwWxpmfAM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 12:51:18.7754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbc217a-feb6-4bda-2e04-08dec7b821e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22111-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:ogerlitz@mellanox.com,m:jackm@dev.mellanox.co.il,m:roland@purestorage.com,m:eli@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:edwards@nvidia.com,m:msanalla@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 998E96720D3

From: Maher Sanalla <msanalla@nvidia.com>

set_user_buf_size() calculates the QP buffer size by left‑shifting the
user‑provided rq.wqe_cnt and rq.wqe_shift as signed integers. A large
rq.wqe_cnt can trigger a signed integer overflow, which is undefined
behavior and may yield a small or even negative buf_size. This can lead
ib_umem_get() to map a buffer smaller than what the hardware will write.

Replace the existing shifts and additions with check_shl_overflow() and
check_add_overflow(), and reject invalid user inputs.

Apply the same checks to the calculation used for qp->sq.offset in
_create_user_qp(). Even though set_user_buf_size() validates this again,
the guard protects us against future changes in the internal
implementation.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/mlx5/qp.c | 43 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 7674290d0afaf466a6b98cbed86d247ee550bd8d..6ecdbda2b471f6c102bceba5d02eb12af8d8e1b1 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -640,6 +640,8 @@ static int set_user_buf_size(struct mlx5_ib_dev *dev,
 			    struct ib_qp_init_attr *attr)
 {
 	int desc_sz = 1 << qp->sq.wqe_shift;
+	int rq_buf_size;
+	int sq_buf_size;
 
 	if (desc_sz > MLX5_CAP_GEN(dev->mdev, max_wqe_sz_sq)) {
 		mlx5_ib_warn(dev, "desc_sz %d, max_sq_desc_sz %d\n",
@@ -664,11 +666,36 @@ static int set_user_buf_size(struct mlx5_ib_dev *dev,
 
 	if (attr->qp_type == IB_QPT_RAW_PACKET ||
 	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
-		base->ubuffer.buf_size = qp->rq.wqe_cnt << qp->rq.wqe_shift;
-		qp->raw_packet_qp.sq.ubuffer.buf_size = qp->sq.wqe_cnt << 6;
+		if (check_shl_overflow(qp->rq.wqe_cnt, qp->rq.wqe_shift,
+				       &base->ubuffer.buf_size)) {
+			mlx5_ib_warn(dev, "rq buf size overflow: wqe_cnt %d wqe_shift %d\n",
+				     qp->rq.wqe_cnt, qp->rq.wqe_shift);
+			return -EINVAL;
+		}
+		if (check_shl_overflow(qp->sq.wqe_cnt, 6,
+				       &qp->raw_packet_qp.sq.ubuffer.buf_size)) {
+			mlx5_ib_warn(dev, "sq buf size overflow: wqe_cnt %d\n",
+				     qp->sq.wqe_cnt);
+			return -EINVAL;
+		}
 	} else {
-		base->ubuffer.buf_size = (qp->rq.wqe_cnt << qp->rq.wqe_shift) +
-					 (qp->sq.wqe_cnt << 6);
+		if (check_shl_overflow(qp->rq.wqe_cnt, qp->rq.wqe_shift,
+				       &rq_buf_size)) {
+			mlx5_ib_warn(dev, "rq buf size overflow: wqe_cnt %d wqe_shift %d\n",
+				     qp->rq.wqe_cnt, qp->rq.wqe_shift);
+			return -EINVAL;
+		}
+		if (check_shl_overflow(qp->sq.wqe_cnt, 6, &sq_buf_size)) {
+			mlx5_ib_warn(dev, "sq buf size overflow: wqe_cnt %d\n",
+				     qp->sq.wqe_cnt);
+			return -EINVAL;
+		}
+		if (check_add_overflow(rq_buf_size, sq_buf_size,
+				       &base->ubuffer.buf_size)) {
+			mlx5_ib_warn(dev, "qp buf size overflow: rq %d sq %d\n",
+				     rq_buf_size, sq_buf_size);
+			return -EINVAL;
+		}
 	}
 
 	return 0;
@@ -997,7 +1024,13 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 
 	qp->rq.offset = 0;
 	qp->sq.wqe_shift = ilog2(MLX5_SEND_WQE_BB);
-	qp->sq.offset = qp->rq.wqe_cnt << qp->rq.wqe_shift;
+	if (check_shl_overflow(qp->rq.wqe_cnt, qp->rq.wqe_shift,
+			       &qp->sq.offset)) {
+		mlx5_ib_warn(dev, "sq offset overflow: wqe_cnt %d wqe_shift %d\n",
+			     qp->rq.wqe_cnt, qp->rq.wqe_shift);
+		err = -EINVAL;
+		goto err_bfreg;
+	}
 
 	err = set_user_buf_size(dev, qp, ucmd, base, attr);
 	if (err)

-- 
2.49.0


