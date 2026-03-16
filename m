Return-Path: <linux-rdma+bounces-18175-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LLrD7LTt2n0VgEAu9opvQ
	(envelope-from <linux-rdma+bounces-18175-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:56:02 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDE22977EF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 10:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7171A3097BEF
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 09:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A12395DB9;
	Mon, 16 Mar 2026 09:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hwYRUb3D"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5453947BE;
	Mon, 16 Mar 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654421; cv=fail; b=CEAChjdVuxr4kU9781g6J1Kg/YSAnMyUh7mfkNq4QQlQ+WvA3uimb5WFYGbdjG183l0yBCc92BiVIacN8rZBoAvTqQUlcPYxsAqSQPay2TwpmDr8feUCjkwO71LeESOl0t0bfCv3w9E3LIgKW2BK3zSKl+/J1MY8WmSx6sccb9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654421; c=relaxed/simple;
	bh=iAx1aOvkIJceTBF/WeAUm25n22QAUmp/hVOceaXrt0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgKkHDd1oLZya2GNojmjG4GieXUlIVLG/rvrCrikae/opNenvS6XeL48VzHnKUx3Me964Buezpb3b3fC/u5zTsNfz8P92TTKR4Nw6GlmvppKif4OKu3l29ehx6eHqcVvgnMAvFVEY7+Q/hYBA7/M7J/dNICzayVQ6AfXwSN6KIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hwYRUb3D; arc=fail smtp.client-ip=52.101.85.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c743Hf98VjKKSuSag2p8kzwNVK5cwW5Ez+nrXiKDKmLai/1PkVphQJFUWqAKRympx5P/dtMnI2dIjL/dzVb762hn5C3SJdRzbRtAvg48d7sVDt2ti2pVzmD5dOMhK+QYhPxDSHPez6p34hgH20lOCDRcBRPXZRQZBLk1HX7C0r5MK9IxBoLPHU1UByiSWXRTRMuHgU0/c+hTc4Hsx/i4a29BpizwWj0h/sxOm8PrhcwXsSt8ZcCKl1DWYiW4S3eZx0WU8lNLmX3E+qgSNaqqO9TLjVRNFyf5GbncTXoeSE8qlyZHsiRzYLJrGy7eJTrWd+Z/RBzVI6qPTsno44nbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ibHVXtz9sS7JVE6h9XgAgLc6u/WvsDTgkSXhxeH5aY=;
 b=fr01OneumAeXENkyGiqCBrPjpe0xmP2reuamyUy60pJUboWA1jlzTUBFWtoJQhStIKVRIO0E2azZjNzphEwftyjlLYlFDmO/gyWrmaVLgURPWCtBwrw2hYRI908wG8WSre2OW07H2L7vAZdTzi6xjdncIyM6Rd+qbWyIiCN8KsetyzaWEI9itJunejgXy1KmwmTLBG0mt5ci97Ok/mxjSNQPAwXQESeDjhoMZSJFDRiLnnMUEW78TZqTp11Mj9zxYaNtxnJDihrRFlzZUSVceRQI//l41J8wxf4mAfwi/6ieY9ywLNgVZ1a9I3fAGle/5AtdmjhnNkocfTLqUDEa2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ibHVXtz9sS7JVE6h9XgAgLc6u/WvsDTgkSXhxeH5aY=;
 b=hwYRUb3DHlqpY4T1v72qeYoUJH8RGppYFe/i+G4i8KfcMZWVG+yZp4cgxLVl2f75vmy0LM6jACGTxM0usDyXaIHVVR7eIZs9qcjhXR7g9tN88fPMJy2DqY6c20E4CTmf+8ZQMInicHAxG+RVETZnf4cfqY/hhot2KTkV5TzCc7kwyk9MF83sc2DU8LSWahkct+PZK7lELsuhjNZTJVYLxkOuDFFP4EIGwg++qNixqV8Qo6FEQlIDwRBHvjxvg/LkC9jMWYLmoA4jXBafRArE80uOdSZMhChAgr1kEkblrQQ0LJNam5+Ezo5CqQpA+ppPacWCuvYwpDA1/fEvd4QiWg==
Received: from CH2PR14CA0034.namprd14.prod.outlook.com (2603:10b6:610:56::14)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 09:46:54 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::88) by CH2PR14CA0034.outlook.office365.com
 (2603:10b6:610:56::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend
 Transport; Mon, 16 Mar 2026 09:46:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 09:46:53 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 02:46:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 02:46:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 02:46:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net 3/3] net/mlx5e: Fix race condition during IPSec ESN update
Date: Mon, 16 Mar 2026 11:46:03 +0200
Message-ID: <20260316094603.6999-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260316094603.6999-1-tariqt@nvidia.com>
References: <20260316094603.6999-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f189443-d8e6-4e4e-887f-08de8340f4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bJv+PZio7SrsXExXn7CfVLK2HFJu0dITvBStS3trMeWYGjEcddajgItGLj4sGSybV3oZziYGujEBXW6BTM3/hqDV2XsIR2lryosZCvd3081Ca8qXVEm2k6DZ5L5Eby4bc+l6IPcF31lFtPHaocmMoKKfS3NJNAv7bqA+F/4QZBOfNN8otm9mPOtuMD6iXt+PyglWys05xJuLfmJCbyNK4F+ME+wmXBhu22iL/qO1prlzA3U0/1bD13KWtILiFbiejauNa/bSD2ArLrp22XM+tsUyMQKMLwWUyhaF17wKuwYOdORlkXDsyRheKf9Iw9IExAqtwUOPT/wDopDDiDqcLzwl0piOQ/7x5R9iYTQEpeq3ITlN1CSLPvWw/vV5gZ/oEL/CMgx70Qz4q9+HFDGUeElxK9AgyZrfn2ltq/xvaKASwfNdqCP275eLaQa4ShkXnJJIvykNsEUytGZa8FXnyF895JFOHmvZrUFQdJh/0CtXhly9JFqci3RmlD9133mLYuiDRzIt4ZCtnUJCg/ozLtzNB3536dApLvTu7Ntu/cCYahYVZbcKu93GJ2UdnjReo41QRGAr8b3DQrIy9++XfS5qbfcpkkIbDUQMUxyicPw75vkj84QCOT04f2kaTq6Ec2ssTTENT2DinRF2lof5d4HYOs1L/6qstq4flB8FT87Nlzq12jFlEiwgJK4uEuR49hjV1bxj50fB+C98+uCxa5dGxBZSPeoH3ZP+GgRGElAjyOvH45j2EWwvfieOXwhVlXSC6u6NXkec31mqtlpeCQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mgo3750cIQCNwkdahuzCIr8LEg+8VTHABB2VDfTljqkQiqxhlMOLzk0cGgTGstfrwouCk5MsW8+T/ZS915rueeaxgUK3vCi7GE+cuvrCbvlO7OkhG9PCl4qc3yAnntB0Dxv3EOk5a1cq4DnUusyU8DkKajY3ijKJL36zjQVCRnm7OzzYE/FMQJ9yXes9d1GwuR00UZg7ld+o2GWvdNPsRjuElRfZGmmE8f6qBU9DrjNdYt47cfEZQ+1tGZsxa79sAP0O9Lw06qgCe9HDOl+rFiHKoKF4KgHgamn2oahuO+DI7cSflwl2MCpMCj56pJtQlnJeoaRYv6veaDY1RLjL77LxHzyhG6+/Vb6v8JGel1EqGS7O0oF3UAs/pNHZcaoIrMeI9D06XD1BB5xAJ0dHpVNLALEcC08ENegPYZhDH5iNbtwvOcHIv7BwLWlR8ZB4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 09:46:53.8825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f189443-d8e6-4e4e-887f-08de8340f4bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18175-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CDDE22977EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jianbo Liu <jianbol@nvidia.com>

In IPSec full offload mode, the device reports an ESN (Extended
Sequence Number) wrap event to the driver. The driver validates this
event by querying the IPSec ASO and checking that the esn_event_arm
field is 0x0, which indicates an event has occurred. After handling
the event, the driver must re-arm the context by setting esn_event_arm
back to 0x1.

A race condition exists in this handling path. After validating the
event, the driver calls mlx5_accel_esp_modify_xfrm() to update the
kernel's xfrm state. This function temporarily releases and
re-acquires the xfrm state lock.

So, need to acknowledge the event first by setting esn_event_arm to
0x1. This prevents the driver from reprocessing the same ESN update if
the hardware sends events for other reason. Since the next ESN update
only occurs after nearly 2^31 packets are received, there's no risk of
missing an update, as it will happen long after this handling has
finished.

Processing the event twice causes the ESN high-order bits (esn_msb) to
be incremented incorrectly. The driver then programs the hardware with
this invalid ESN state, which leads to anti-replay failures and a
complete halt of IPSec traffic.

Fix this by re-arming the ESN event immediately after it is validated,
before calling mlx5_accel_esp_modify_xfrm(). This ensures that any
spurious, duplicate events are correctly ignored, closing the race
window.

Fixes: fef06678931f ("net/mlx5e: Fix ESN update kernel panic")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/en_accel/ipsec_offload.c        | 33 ++++++++-----------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 71222f7247f1..05faad5083d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -310,10 +310,11 @@ static void mlx5e_ipsec_aso_update(struct mlx5e_ipsec_sa_entry *sa_entry,
 	mlx5e_ipsec_aso_query(sa_entry, data);
 }
 
-static void mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry,
-					 u32 mode_param)
+static void
+mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry,
+			     u32 mode_param,
+			     struct mlx5_accel_esp_xfrm_attrs *attrs)
 {
-	struct mlx5_accel_esp_xfrm_attrs attrs = {};
 	struct mlx5_wqe_aso_ctrl_seg data = {};
 
 	if (mode_param < MLX5E_IPSEC_ESN_SCOPE_MID) {
@@ -323,18 +324,7 @@ static void mlx5e_ipsec_update_esn_state(struct mlx5e_ipsec_sa_entry *sa_entry,
 		sa_entry->esn_state.overlap = 1;
 	}
 
-	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, &attrs);
-
-	/* It is safe to execute the modify below unlocked since the only flows
-	 * that could affect this HW object, are create, destroy and this work.
-	 *
-	 * Creation flow can't co-exist with this modify work, the destruction
-	 * flow would cancel this work, and this work is a single entity that
-	 * can't conflict with it self.
-	 */
-	spin_unlock_bh(&sa_entry->x->lock);
-	mlx5_accel_esp_modify_xfrm(sa_entry, &attrs);
-	spin_lock_bh(&sa_entry->x->lock);
+	mlx5e_ipsec_build_accel_xfrm_attrs(sa_entry, attrs);
 
 	data.data_offset_condition_operand =
 		MLX5_IPSEC_ASO_REMOVE_FLOW_PKT_CNT_OFFSET;
@@ -451,7 +441,9 @@ static void mlx5e_ipsec_handle_event(struct work_struct *_work)
 	struct mlx5e_ipsec_work *work =
 		container_of(_work, struct mlx5e_ipsec_work, work);
 	struct mlx5e_ipsec_sa_entry *sa_entry = work->data;
+	struct mlx5_accel_esp_xfrm_attrs tmp = {};
 	struct mlx5_accel_esp_xfrm_attrs *attrs;
+	bool need_modify = false;
 	int ret;
 
 	attrs = &sa_entry->attrs;
@@ -461,19 +453,22 @@ static void mlx5e_ipsec_handle_event(struct work_struct *_work)
 	if (ret)
 		goto unlock;
 
+	if (attrs->lft.soft_packet_limit != XFRM_INF)
+		mlx5e_ipsec_handle_limits(sa_entry);
+
 	if (attrs->replay_esn.trigger &&
 	    !MLX5_GET(ipsec_aso, sa_entry->ctx, esn_event_arm)) {
 		u32 mode_param = MLX5_GET(ipsec_aso, sa_entry->ctx,
 					  mode_parameter);
 
-		mlx5e_ipsec_update_esn_state(sa_entry, mode_param);
+		mlx5e_ipsec_update_esn_state(sa_entry, mode_param, &tmp);
+		need_modify = true;
 	}
 
-	if (attrs->lft.soft_packet_limit != XFRM_INF)
-		mlx5e_ipsec_handle_limits(sa_entry);
-
 unlock:
 	spin_unlock_bh(&sa_entry->x->lock);
+	if (need_modify)
+		mlx5_accel_esp_modify_xfrm(sa_entry, &tmp);
 	kfree(work);
 }
 
-- 
2.44.0


