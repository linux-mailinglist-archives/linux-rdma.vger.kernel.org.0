Return-Path: <linux-rdma+bounces-20551-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /0ixN3MbBGrTEAIAu9opvQ
	(envelope-from <linux-rdma+bounces-20551-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:34:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AF252E1F1
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 08:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 776CD305245F
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2026 06:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD53D4126;
	Wed, 13 May 2026 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sGmc2v2e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4C2BEC55;
	Wed, 13 May 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654059; cv=fail; b=mYLX0psBOK3y+FppdtLAfwZGzpcDw+zi6sDHgvd0XzxvdSNMFHtKiuy38rjNh6tv8BrOzdX4RWHy0Z9Y82AS/P/6rCfvEH8krapnm0DRrvW+If3jhNbX18o5bRasfbUZoZr1lyYhljUi/j6mYDmCa7R0Cd2Do+K6K/8EuJ7bWVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654059; c=relaxed/simple;
	bh=pjEQ+HW/kbGueo7bhxa8v0mB3J87Cs1t4nznD8Ts5yc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sJbQMBntRoYoY49dzO86B4io4ormkzK9DBfcL9B4tFxcBKRvMVxjeIGYf4njbnnXFTltmh0V7ssITADAANCIeJITs7+31ImYX+7iXxzawDnqhe1b/dqzuf/9uW83RrBgjNQeOI7C6Jknme+Tu3dFmnz3V1DVuLaxdRFx3Y1yC0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sGmc2v2e; arc=fail smtp.client-ip=40.93.195.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC/W+GV9IhCgAsz5kHhs1MLrKZwqUeAqDejKHVP2r+zMKCakiL2BCQpiUQDMXiSHy/qoeIj7E6uStGqCtsywBPkWzoTeLJZsCSMcqTO24R7odMNtAmFU28tirSlfkgj9pXf0WIqEoqXG+DTuP0Kl9a8sx1lX9KbbC8xctOWI/4KdFd6JJp8Ow+5sVDAX4v0dv9ZRATUKgHlyzhN7zN/y+esTXzpCLV/fQ9bakCM0vNVrsSucBA93f8MUS59lklkxMRNmI34knHuCbpPqvBbRdBpXPxBlL6Cu2+vSKmz3kGN6bar05qH9r+AgXnVRMYtmtOXS7t7DJRuacpq7TtmF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2PZZiJup34SdW9YdSIPoDNDoilFtCeSdz4PNWvQrP8=;
 b=V71QgZbx239LjUYAdmfSjxdr2m4mzteWnMiwTJsFpezngeAk4Oqm4jAHSnrg+RHsm/9/5kMTJ5FTTjIFiYoc8KUQ9zUjliWmGQHH1yWwgd8Q1P3w3WN5HCuVFLMOzFCUwGlRU3uhLlB2hQi/c9CKTDZ5QP7EIPbsiA61u4IwyNHdX3XyTcbibe+z/L0YV6svKkgDgkn3T6J9BjU0A7TRWD1+rx+ThOyLG+ic9G5wKkpa9/o9MuX1eg69Zl66hJL3fGHEmCc77gFofmitaMLd3uhAXXtOKII3L9VLLDp6N1LPKimo19ztzdRd2966lj2O9TrWCZztM3tTMd2l6yL0wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2PZZiJup34SdW9YdSIPoDNDoilFtCeSdz4PNWvQrP8=;
 b=sGmc2v2eJJUOp/BVB3Ue1/8c0VD7NWJ6qXKYDIJbyeawokdTLEBvkFMltdf0pX5Tk6kUzTYG0kUlIMvnZPTLDdQjCWsZFl5EHAascNBPuFtuYOhedf6Ov7Wz/XYsoZ+zCu/LpSg7IUF9+TQbt+7zdWUnLK7BmS0w/1gDkLS7ZcR2UFHHYDhTU4o5MPqCOBLjYekkkj5Gn44ed+rbCcfVGL0go8MCjgASY0zledTqL+KHjQOzTlzuNHnFXQTX/8RjLHBxE4LKqOJKFdlizi6NVIn0vVtdAOXOFLV5ReGi88NtD3bzWrK9o5OoSw+668VWnI8gSGTaUAoS5RhwbtJCWA==
Received: from SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 06:34:12 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:a7:cafe::35) by SA9PR10CA0017.outlook.office365.com
 (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Wed,
 13 May 2026 06:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 06:34:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 23:33:54 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 12 May
 2026 23:33:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 12
 May 2026 23:33:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Jeroen Massar <jmassar@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net] net/mlx5: Do not restore destination-less TC rules
Date: Wed, 13 May 2026 09:33:02 +0300
Message-ID: <20260513063302.333761-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 781982a8-e8ca-41c3-8c67-08deb0b9a484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	AlgCuIb2nZ812rgrjHuMa0J2cdDDCe0KX4HWm3ipUo70tBefPXhm04GB+XVYiRaS+n/4MIyeA3XwptDxe2mC7lvYH93kYi0Oq7KxDLd5QRJyakDnWnhsS2Dyed/RK8a8ENinGRf4tTkOXIfkrJC3PkEcqZ3TjB2q9eIZG22jrvua2CSZap2VM7Ei1mQVqoxmB0j9Cu6BEXZ4dc4Rel3Gun3y777UUn2oUqZs3yIJ+TTnaQUwmIfUr/IZHDDjsStcBEx31ntw+trMpTw25qMGm2QVRMGcmrXyQoE8tZQAZCobsIPf+7ZXp8Ye6m+CXpc9j1PkB6MO/IKHwgMv8mRTdSZwAVES1ZNJ7nrhD+4sR9Sj8YI/LLM7mBZ0sM7yTq1siJcM0wfdQG3MDVOIuQqTHAURAyK0df3ki9An2nvZuQfOfpTcXMsiDTrer8WfqiOJ19WrB+SJPJIzTNfQIJqs+/Ei/wFVj3qr5Tbk9B065b/5y8h7oMyt9V+lejS87mv5uZemaQQBuR+sIoUfCO1QjFvytblug5hEsrBTATIep0zx0B3T3bf8LvM0+VanrW1bZMi4Pu9L874e7pgin6uW6O8gLNgTj0B/aJVhFwYin+ip+KcO7qzcvKDB5vb5tU4sgzBYJAjWAw/oPb+cz528piXqHvGWjCJY+/1pEjEZ3gsYVh/EWVjnWdFXMbsOVo1/2V8YCWo9xSHKwJovyQ0UJ4s9UUxI03x2OlkTsmZW4Ik=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uSrjAvAyDipg6sIzqGAYlL3RfyNZfStw/8cQrd7SqZWnqbW+hmKLiaaDCS8xQaSxMNFD2rKfVsbFV7bvEfO+XJWCa7oCSYPtxbAJPkFupb5jKFk5U33YVqU47caaW2yeD4vs/neVoED3oerW20rmIk/cYc0ZwlpHPuNJDQ4IPE4uZFNs7Lc2TASMhpMeATOANRaH2x5wPaKm9Ex4BzGeXtnETdtOjl8PFJqTzJUD15ndwokQNCzma8ytVwh2HwJlxs+5wogWqJHTxICABZaOryhJ/EgBZtfZ3LmMJaC8agDUE11Ao31Wg9mPVUOCCyoxuXYhCTe2a7FCTh7fO8aTRWMsIlZfnuxcAB1RYbkX3C+oj/0D7+TTS7d1yBD2jk6RCHX8W9nBt3ycT7l3MK9XQIioVBsKIBNh04ctqnRVQecpcx0YUeR9BgOMpKgxU/Am
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:34:10.7251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781982a8-e8ca-41c3-8c67-08deb0b9a484
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
X-Rspamd-Queue-Id: 75AF252E1F1
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
	TAGGED_FROM(0.00)[bounces-20551-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Jeroen Massar <jmassar@nvidia.com>

After IPsec policy/state TX rules are added, any TC flow rule, which
forwards packets to uplink, is modified to forward to IPsec TX tables.
As these tables are destroyed dynamically, whenever there is no
reference to them, the destinations of this kind of rules must be
restored to uplink, unless there is no destination for that rule.

The flow rules FLOW_ACTION_ACCEPT, DROP, TRAP, GOTO and SAMPLE do not
have a destination port, and thus out_count = 0.

At cleanup time of the rules in mlx5_esw_ipsec_modify_flow_dests
we call mlx5_eswitch_restore_ipsec_rule but as the above types
do not have a destination we get an underflow of out_count, as
the port is passed, which is esw_attr->out_count - 1.

This change avoids calling mlx5_eswitch_restore_ipsec_rule when
there are no output destinations and thus avoids the underflow.

Fixes: d1569537a837 ("net/mlx5e: Modify and restore TC rules for IPSec TX rules")
Signed-off-by: Jeroen Massar <jmassar@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 3cfe743610d3..ab50d2c734ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -142,7 +142,8 @@ static int mlx5_esw_ipsec_modify_flow_dests(struct mlx5_eswitch *esw,
 
 	attr = flow->attr;
 	esw_attr = attr->esw_attr;
-	if (esw_attr->out_count - esw_attr->split_count > 1)
+	if (!esw_attr->out_count ||
+	    esw_attr->out_count - esw_attr->split_count > 1)
 		return 0;
 
 	err = mlx5_eswitch_restore_ipsec_rule(esw, flow->rule[0], esw_attr,

base-commit: f5b2772d14884f4be9e718644f1203d4d0e6f0d6
-- 
2.44.0


