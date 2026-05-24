Return-Path: <linux-rdma+bounces-21208-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPtNAqUcE2oE7wYAu9opvQ
	(envelope-from <linux-rdma+bounces-21208-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:43:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B00305C2F86
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 17:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 239DC304497F
	for <lists+linux-rdma@lfdr.de>; Sun, 24 May 2026 15:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FDA3A987B;
	Sun, 24 May 2026 15:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EN23de/q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C25C39B482;
	Sun, 24 May 2026 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779637156; cv=fail; b=KmWyvV/YPS90eQh4BjC0oiHfDrAvMt202eUClNYOw3e8fi4dVrCReQ/BlmlJ9DTt4eK1y3CaBSwz5zwe4bYDbn52RcduhhAE1+Cd1BrgvyWxF/lLxOxrIFBhHGDRceIErlF+B+kqyFyh6L6o9VfgRo63XDDTLHi+5N8L5zUiiGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779637156; c=relaxed/simple;
	bh=RViA69aMpLppw6QwYbHf5IuubmCBtHFZ3cbV738wYbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KgbZhn1WIkaiMcOgIofWHu/Db6pm2g2ux2Csab34S9GtsZrMjT/lHy3PkoI2EuFTuCV/oJ0fCyaFJK8OvfV4eGd2H+s/lhniX71SST3fzRpANhc8capMLxotRu2nEY19DA5w/jZj58dVZq+VbRiweTYsSu3ngNp6D6igNHPtm6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EN23de/q; arc=fail smtp.client-ip=52.101.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUcykpR6vA5s7HTXqHcSb2rcqj4tbEPANL357BVa63pdFxTaQC9DVty2rp8oAFtVmw8/shT4bWs6skOr3fAAVNdowrwPon3KSuX+tAaO0/VOwG1xLjLASoFcDnsaiW3SXkopacE+s+h5lLtOzWqA16dW/EaVuoKFh7SDGptpgmnBlngPeQAi2xgv9HJyhkWYr4RNEOn0zCx2xFOM68ILASbaqR5BaSu7RsJGZKn396sSWAEnV6S9KlFmX8ymdfWW5XOt7ZqjXMdmz/mce2BsG1p1C4FLHY8K2JoxNbO+oYwXr2wJWSuzBvq0RtpnojwUC6P247Xf5p/pJIshDIbnLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Khmdlkp5wUiYQiogkVLuIhBJswT+VzkWKjA4tGynG0I=;
 b=X7o9LxwdqXS6/LVs97203OIzmDJUHHD4S6Zp0DTXf2b7Be2dYR/DvdTyXyB4CBw5kpoPZle9sYj3/dGT8aWW/J0ILCg+k8/H1uGfd/BXaou7cF4M5VBRfZuWsnKuW+TvxrZz2DrNV5R/Nb/L13q3U74cN6hilVj1PoMYZ11S42h7H6/o/faJ2/U0LZkq0YPMs+rDZQP3IKCXCEk/K/g4p0Insf3jZtZrGLWPNs1KyKU9UyjIY80joPie3cSDJwLTWAUF+JbdZZaMD2Z0y3vTo1368HjHIrwPv8GU8PMTr/iFYy4iXhwOmeFrkT0xJZVFSc5FcPbdM24HS0p503w55A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Khmdlkp5wUiYQiogkVLuIhBJswT+VzkWKjA4tGynG0I=;
 b=EN23de/q5MQjRj41GtWPo4nSr/10koR86xwK+g0XnaI01KWeKim7HKz7oLQOYigT7qfXG21cXYD0Wwg4wGCPgXHihMH6mHtu0JzF4Twrn8YBczHLItFsHno2gQsD2dGrGUwkb4ap3/8O5m6eSkd09TVluFMagSa0hYowK+qySdjMU1JbUVvF5312Son4pgQg5Fcm8VT9z10Agujr3h/bIjRhwWL19fkYrdToYWWAv7tlGppqdxyJb2H28hwqG79NmNOwRxuFnz7BlJqClmsGi4EidRPJnWlKmo876VY2/wXtXys4L915D0HsMFYalWVrfJY6MGUTRyU699kMiRiigw==
Received: from PH7P221CA0045.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::17)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Sun, 24 May
 2026 15:39:10 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::76) by PH7P221CA0045.outlook.office365.com
 (2603:10b6:510:33c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.19 via Frontend Transport; Sun, 24
 May 2026 15:39:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Sun, 24 May 2026 15:39:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 24 May
 2026 08:39:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 24 May 2026 08:39:00 -0700
Received: from [10.135.59.1] (10.127.8.10) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 24
 May 2026 08:38:57 -0700
From: Edward Srouji <edwards@nvidia.com>
Date: Sun, 24 May 2026 18:38:07 +0300
Subject: [PATCH rdma-next 6/8] RDMA/bnxt_re: Validate rate limit attribute
 in modify QP
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260524-packet-pacing-v1-6-3d79439f8d08@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779637112; l=2424;
 i=edwards@nvidia.com; s=20251029; h=from:subject:message-id;
 bh=fq7MowR9CX9tImXf6Si2fqSZrv2vAQr07noXS/Nj7Nk=;
 b=kLjYTQNhH7Miy8rYzHt7WbZH/g6e4F8c876GSk24yF5Lvy1YtY+QxM1lhnF3CO9UD4X4MDIv9
 mmd6FhwDrYlCpuG7t3F4H6eHIDTbpiga4XgjhJkrfmjevbJHOvyI3WU
X-Developer-Key: i=edwards@nvidia.com; a=ed25519;
 pk=VME+d2WbMZT5AY+AolKh2XIdrnXWUwwzz/XLQ3jXgDM=
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: db50caa8-47af-486f-ccf2-08deb9aa9904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|18002099003|56012099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	D0MGD3G4rclLBkBspCwHM7bH1ldSdfaC9PbTNhgWp4ndx0EtAOJ1CHkDiuV3AJ2nfanjRfldisX7ZsDna/eDlZHZuisQOhAarA/dfFBneMsPmJK4HZ1eL6nZqkg0jSNmjIVJzcykB05BgpDTlV3BX/Cl48Cz/qgn2kSD1vL7hGMjo+Fl1uTOBy1bUufLcypw6pw7VS89MTg9wydqbocO0dVcOXHqCcwfnHrxo4NYGNU8mRRXiajPZ6boagIOCOFGTUcA2pswYrknvIB8GP5bXmQqfBTdSF2k2bmKfQxewzjsQSmqRM7dcshbzvClcaEWNDfXsV5dHyykegpKgekAzPRCUTsG2HukWykrmYGClWBgXWC/xBQE/tSeCWDx7yBPGVXCqZQluFUAyslvwha67nKUabiLthUXnkTs0JIWucyoO0ju8hM2FrKPXZ2xdQkEJ0ZBdqCDkLP6FkzZVFLp96M5qe0kGgv3dl55gZEdsrD66NFDoIca/aiuDwxS93JGZKoVgUo62s0v3W5VCNctK3yU2MowCH40+rfAQ4/hFDwYVVSy2gbQwaTB2f7Q4MeiaUbVxh2JXVrZkOhpQqvt7A3Je0qnjBmnxfkjyML3ekmamFMXfqyIP15nvr1G99oG8gDDN2EAmuLuY/33qZPpQH4vaFf2/5DNZPqdruj9oAhy0uhPLGdbUnQTAHvzqpS3Rt2+8dEj/jp3e10ysvgeBy0CClB83bjLs69F+zXBqag=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	knYRznc4CPaxhDMkc3v1Y12eif1TbKE2UPkxYMqIP61xlrggAcU6JvZ5wdLJmAENVaaSsbrk5Or6tuZw3eeM58jwR+sjnS8Bbf+a6P6Pyvo6HYEbVHrhsOQ6xK91vCZScAyYLDSNhYwR6JI10BaG+UEBWPZCqB9jhYohG8UiojxclXCAA01RuqBXapvf2+uL+LgqyJSmX9ZLRCrRNES+TwerApXKXnpwu4eNYloP4z7NmVsVszUq+PKDI3K8IEWdca7n4SETpjj8UY70KAs0jss2TZrlH5p8ZyJMZF8Aq447Fb1AKX6UOef441T15nYPWDwrZkfWz2vH9IJ/e0rW5Mh+1WONucjh4eHyoG7xBHftex/cmwnRNvAwucc20VmArPb4QgOCAFJ6WqdeFlGzJvEWMpcYSQ4SqpnBElOqw0iTjOlBcANccIh+M8BbF/3w
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 15:39:09.4883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db50caa8-47af-486f-ccf2-08deb9aa9904
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21208-lists,linux-rdma=lfdr.de];
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
X-Rspamd-Queue-Id: B00305C2F86
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
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index ccb362d6d2e669160174cc562d4e3d8d22b110db..14d2533d7439f2c160ceeea3d0c1e2fe9abcd9f5 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -2286,6 +2286,23 @@ static int bnxt_re_modify_shadow_qp(struct bnxt_re_dev *rdev,
 	return rc;
 }
 
+static bool bnxt_re_is_modify_ok(enum ib_qp_attr_mask ext_mask,
+				 enum ib_qp_type type, enum ib_qp_state cur,
+				 enum ib_qp_state next)
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
 int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		      int qp_attr_mask, struct ib_udata *udata)
 {
@@ -2310,7 +2327,10 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,
 		curr_qp_state = __to_ib_qp_state(qp->qplib_qp.cur_qp_state);
 		new_qp_state = qp_attr->qp_state;
 		if (!ib_modify_qp_is_ok(curr_qp_state, new_qp_state,
-					ib_qp->qp_type, qp_attr_mask)) {
+					ib_qp->qp_type, qp_attr_mask) ||
+		    !bnxt_re_is_modify_ok(qp_attr_mask & ~IB_QP_ATTR_STANDARD_BITS,
+					  ib_qp->qp_type, curr_qp_state,
+					  new_qp_state)) {
 			ibdev_err(&rdev->ibdev,
 				  "Invalid attribute mask: %#x specified ",
 				  qp_attr_mask);

-- 
2.49.0


