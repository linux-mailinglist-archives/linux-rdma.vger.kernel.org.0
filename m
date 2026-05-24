Return-Path: <linux-rdma+bounces-21209-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGxWODIcE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21209-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:41:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 902565C2F26
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 520C4300E146
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEE839C01A;
	Sun, 24 May 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sy2ZG330"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757438F957;
	Sun, 24 May 2026 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637163; cv=fail; b=g2kxtS4s0006LgJ/l1q+N1leEWvNeghCdUiJDtrIiwwM/rJv8vNw8yEI0RtF1N9KZIvZUOALlgHKxxjUfbYSRe4XSVguwdlQngrUbV7GyDEvpxdGk2eqRl8STmWFFEQPaal8Qiq4ivz7+JxKCVzirTAbMQk7MERAxJTSoZtLrSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637163; c=relaxed/simple;
	bh=VrfwuHP/1lUZnE0FCHESyFVthBsA5bGj0cNsuKRqBCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ad2PjHTseX+t6eA8Kr040TJEyTNfNezd8n9bWwx23GbjQtIW/gqyOThv1Nyh8PcAmabUPwQjqfjvpYZcTEJBvQ8nr8ZhwKqHpryW+eWm78VFBQHlzlLFfDo/7eqoYwwsu96iIxhEhhEh+DVyA2DXbWd6wIFcQb++pKwh78ECD4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sy2ZG330; arc=fail smtp.client-ip=52.101.61.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REiRFLgGisTvdav7mKQGHUWL58nnqouKwT4Mvr0cZFaZ/iBHYWYvov53ddfDCVj7IUodI3KIDAR7iud70BqEY4rLFIpPEy9FeAQVC0jFB8hPlv1X2/HX3RQdO8v7wJxUr8ZDm3jy/K/Wnr9rMxwsnkNnuxm5gvy2Z+xLEHDlTlF9olC/C6BEQ5jHPwTRPi5q/dNGYmto9jUOObs7bciLZOX+7ZbT0kqdl0ZBSA1ACY51WuJHhgXEzqVSf2p2GX1tF2qYw1PiUT+F9wO4PBgWIrCg4EnGZ4YBP9kYBZYzRrzIOBXKSVPN0D6ydCRqO4aGSmNB40XVuuUZbrfIvOY1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoO108gb8QKOzmAkS4bh00XDxo5YS/LTSF6hFvbsGGY=;
 b=WMNJ/Dlk91RomgPLzBa2VeFIolC1LYJf0QoiKp4Y0PUmZ4DuPS+1sAntuvRRlTEud8FoJ/U9xivKOlGlbMuVp5Pn2hFELF9ykoLYG9I/jNhfRLcwLNLGkjFOCJrURG/58yqii66lA1mGyPkSPUYuBt9rTSOD4OYjaWociwCEKcQ+LxwteXKpnkVDUhYGRN0d2hWUdhRYaSp2gyffH1fvh2fQda5bXB1NxbacxuhMEs94t5O/KaVrzyIg9nLwgjJk8ezm4P8Ws5P708QrSsfeDfR+kPpLDgxa6ImbLgwqFoAjhPCCN8E8fK4XzriQIrdurLrXRcKOExQwC7K7JOZ5Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoO108gb8QKOzmAkS4bh00XDxo5YS/LTSF6hFvbsGGY=;
 b=Sy2ZG330lBfb2JgOqFvZhyY4NQkLooD/6uIvKeqgYOYoGPlnsZel7Vq20bvGxs/+WxrXm4Xg3fwWnBIcX2T08OUDHdpdaOm6p63Pq1XQlOsgVE4QwOjPjwxm8+SSTIrmWJaUcqv6gCnV/gEynZdFZhjiN9SZc2nYJ41eck4znnieC4jMk+jUrooOH0hYeFokf0Dpo7Sq3KNtZ4+0T54/cZIrb7Pj5EeR3dA7BklpS4axsUv0ieag3rkLL+UrdZFS6CoRXYZhO2Vy251emwSK3DP33JaSkSGBD3RI3E00wDxUYqhlI/lTwU8r8HDlDOHrXcSRfWi584tDWCo4rJU6oQ==
Received: from CY5PR15CA0207.namprd15.prod.outlook.com (2603:10b6:930:82::26)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:39:18 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:930:82:cafe::24) by CY5PR15CA0207.outlook.office365.com
 (2603:10b6:930:82::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:39:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:39:04 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:39:04 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:39:00 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:08 +0300
Subject: [PATCH rdma-next 7/8] RDMA/ionic: Validate rate limit attribute in
 modify QP
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-7-3d79439f8d08@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=2395;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=dvJIgzdzy6JZcmgwATlZWqb3siPNnePA4XerF5CAJ0k=;
 b=gdWcAls43FKshyxhUJfQPEKodHLj/W6UBbq+fB5MdWLlDJbv5vhQtRVFwH4WpMavN4QfxiBhf
 MymgRyBeYKkCB9B49weeLNXc5ho7xsH+1Ryv5SVfbk2/OuHvDgWRplg
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0cb663-1576-430d-4503-08deb9aa9db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	xNdBCC/+9uAAqIeaEG10la5w94QfP6gQUSq37pfkW2C8UDZbyR4Ni09bWdYSrCErZQ8/lhqV+1BdZG/rRknZQHt9Mr2lQXk9LgAhKWikSfUYlE3C+oKGqC57JtkLH/OJNwp5zQEB5olXMLE6IKUsz80wh/zWNhY7d6X1RoQk9556yX7z20HG64+TLEsEWRSGqr0kVy2nOdVglJejdTfHFwCkaQGX4fBXIQ+exerneqj2PRIc+fZtVLiBsek5/qOZfk3RMwcNc+cHgf/aNQY4aCY87AyOzoQud42wYX0d3NKml6KOK9TyeFXSDGIhSlEg+XDMtgRE8eQzBAO0zsbgifidM19AkYGsfZR7b1Im9e6ieGu2uxS2rD7LOhq3A62C7kHt9/tODbqfnLwdmhy7T3cvckdk48X+P8B0nWHPyViWZMW8qflidAJqzlwNmPqZB7Uy52ZT3iOiAZjT58QNuZ9t1Xa+T9uvjUgFoScEzL+IkFVg6sv4h0BIW6g1mdr0Zf7ovdjPaS4mDCDsgSJ8f9JheDh2dslkNtswLvytnerri/zfHzhPrtqjs5kSoRHe/UtEPMutzpeb16nBe2nCDPyALv8ox/AA3lLiSn8+6naFq3l+HlJawB5h6JCvObqeluu/mwpjxmgqXcexjPdMxn5m40aepy7YMkvw1QXFO00ZjsJtluGpQ4KME9vhGJsstFAmNVDdx6ZSAjYeqMf0jKWDoDuHXXog1mHOxZmH1G0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	iezn/YCZ2peFE3KKih9yzJWqg/CJSi2LvYyfAUm5MUkC1LsoC1pu/62iccNF38kl6Vu+GCjAV2zIdvUrk2N3A+St9CIVnHD5cMqEvB0IO70IFjq5L9Quw/80gV4WFkWZz44cd6KKuQQDWu0mEhZ43B7DhbQxXrQKvF88CFvJBV/3PtN8GBIBGuRNfmNUOUTcbZkicPAoy27uyg1/qWTgHeOjVawogdz9zNivVvACL71ujARYaHI94YmAemCwz1nOT8tGpx4DNtRPNju0WP1o6Sa6F3NT541NuvV5+uiHqAN1IE7m+Wl87eJAHSsuvHzj+60+3rDa4UumK7qmNmzH6j35op+qBdv9u27i55Fifm5t+2Hc89yVsAfAz7zcW19Xt20wEtAJk5MOfACBb7b5vrXT16Eae/VPkI90V7u4KrPLNY0vP73l71qlpfxapj/k
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:39:17.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0cb663-1576-430d-4503-08deb9aa9db2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21209-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edwards@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 902565C2F26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Maher Sanalla <msanalla@nvidia.com>

Rate limit transition validation for RC QPs currently relies on
the IB core qp_state_table. Add a driver-level helper to validate
the rate limit attribute directly during QP modify, ensuring it
is only accepted for RC QPs in INIT->RTR, RTR->RTS and RTS->RTS
transitions.

This makes the driver responsible for rate limit validation
and prepares for a follow-up IB core change that delegates
IB_QP_RATE_LIMIT and all future non-standard modify attributes
handling to individual vendor drivers.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Edward Srouji <edwards@nvidia.com>
---
 drivers/infiniband/hw/ionic/ionic_controlpath.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/ionic/ionic_controlpath.c b/drivers/infiniband/hw/ionic/ionic_controlpath.c
index 2b01345848ddb7ee9b34e5c9bb074912734536e1..72e111027f1f5fede5aa21f0265219392f29a3ee 100644
--- a/drivers/infiniband/hw/ionic/ionic_controlpath.c
+++ b/drivers/infiniband/hw/ionic/ionic_controlpath.c
@@ -2535,6 +2535,23 @@ static bool ionic_qp_cur_state_is_ok(enum ib_qp_state q_state,
 	return false;
 }
 
+static bool ionic_is_modify_ok(enum ib_qp_attr_mask ext_mask,
+			       enum ib_qp_type type, enum ib_qp_state cur,
+			       enum ib_qp_state next)
+{
+	if (!ext_mask)
+		return true;
+
+	if (ext_mask & ~IB_QP_RATE_LIMIT)
+		return false;
+
+	/* Rate limit is only supported for RC QPs during specific transitions */
+	return type == IB_QPT_RC &&
+	       ((cur == IB_QPS_INIT && next == IB_QPS_RTR) ||
+		(cur == IB_QPS_RTR && next == IB_QPS_RTS) ||
+		(cur == IB_QPS_RTS && next == IB_QPS_RTS));
+}
+
 static int ionic_check_modify_qp(struct ionic_qp *qp, struct ib_qp_attr *attr,
 				 int mask)
 {
@@ -2547,7 +2564,9 @@ static int ionic_check_modify_qp(struct ionic_qp *qp, struct ib_qp_attr *attr,
 	    !ionic_qp_cur_state_is_ok(qp->state, attr->cur_qp_state))
 		return -EINVAL;
 
-	if (!ib_modify_qp_is_ok(cur_state, next_state, qp->ibqp.qp_type, mask))
+	if (!ib_modify_qp_is_ok(cur_state, next_state, qp->ibqp.qp_type, mask) ||
+	    !ionic_is_modify_ok(mask & ~IB_QP_ATTR_STANDARD_BITS,
+				qp->ibqp.qp_type, cur_state, next_state))
 		return -EINVAL;
 
 	/* unprivileged qp not allowed privileged qkey */

-- 
2.49.0


