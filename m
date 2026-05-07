Return-Path: <linux-rdma+bounces-20179-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFPpHxDO/GlhTwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20179-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:38:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFC84ECF47
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10E6730872B4
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C0413242;
	Thu,  7 May 2026 17:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OVhgwID5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC640DFC9;
	Thu,  7 May 2026 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175348; cv=fail; b=VMJCYSoDugMogOY6um5jBu252E61qtd5bi1M35XtUIlZoN9+psFLVE50UZVSONszkoghi1u6176LdtebipFyZWRBBxT7QJTbFxZzwi03RbqcVm7c88cGIe4Tc1XDfj4KizQJ23czy6u2ijirLg+it7aWf3VncpZ94IaMHWo54Jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175348; c=relaxed/simple;
	bh=+6ejlQ1ab0uII5kXnHXBv213QziDOvgb+p23frVF1q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISv5HN9ICIn8ZOlDha3kSm31WZHUVp5JxqeZSwhrcdp/P9bgIPdcSllRZjPpd+6vHxGR1gdhSBENqi5XjsfsfZuuf406Uwj1CZhYwzQdHE0xQs/vX9cPhJmA/L/ClubQxP4E+boPn2Q3Wa3y9bPFUfGsyhE5i35NdVUc8cm+6lo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OVhgwID5; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KauRUg4Qgsa5q4gKuJRcjepNiU4kqggRrR1E3YglB8kb5ganBWm3inFsvq5td0fsPwA1gTwpQytp9aqpz1GShrbhylgjGayq26GZ5j+E17iPeM9Q86ClxxlqayVEvL5wqNhsGB0pop7V6vX2XQOCvaMfLZiqdtzKbMH+dTo4ZJLOw2STU1TgWPqYlG02FM4yKsMkQjtB2JOjDTkqWZFp57jHrc2c0b9BH2GMbSizwlcw5CUCYpg8R9eA28AlVWnMh54CoXf4uvGHjwdLPbL9rADLrtN1UpxGzsDQj6MyGrja4iITNoIUjSEjzYxKsbJPqHx4SWMKqskb5HtYP7mqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6INeLLaDOHCGOlvHI2Kkk9yWIzP4jnF9D5PJXR1ZQNI=;
 b=OEvX+AcuMocbQ0VuQflKKbw2U5Da7dMK9vDalNxaUcdcFqa5E4dEoCIUGBYV/+CkewQLRbBYdORTY48iBvMyV+G92T/NvZedCpliIHifZGwnPijHfEzChtvu1w/IDZBGa5YWJ3LFJh8AiwfIHIWsHqroCVwgyqHLauMN0Cmj0K8fyw6lXNzrUkJKCgV42kl3TC02ddyNqgUypBzl0tACZf+wBzLda3livSb7PbXKpSZ1yME30zRLNi+LU9USWGU/eszGR+bbVJNMAljq81Pj32td6rEbw1W9JjclNqFFeOQ53qw0RnHwXDfJxbB2ylck4AbSEbtsvHme2zknSBptKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6INeLLaDOHCGOlvHI2Kkk9yWIzP4jnF9D5PJXR1ZQNI=;
 b=OVhgwID5XqGfhMM4lBzczo7nxsN/9Gugwxjr5L91BKrQi28i38M5L4s0CbxBFZTFEnv69IWsls3sPMLICSc4I/O1Zl5CjB55XbyR0Lw/bzgdFpQ5NrpiRjCTVxXJgyHVh0T9wM1f6hBb6wYwkzs+Nr806LeIVrV9UiDIUABIzXZqMSPtPPQwlMkWcHjl/dOvaQ2T0MlgBS4Oet8zNE6g/qiYRMbLpEWvmeg+13nGdyisxCGHVRoyLBdgB6hTWUIQXiJ/4hvFIbG8h8c4zd8btyQE6nFFQX3DD350r+EtKyzVfOGQ00ITgofx4MHarIh7Q6iIsrLJqjs/Rp0amrdxxQ==
Received: from MN2PR05CA0059.namprd05.prod.outlook.com (2603:10b6:208:236::28)
 by DS3PR12MB999239.namprd12.prod.outlook.com (2603:10b6:8:38c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Thu, 7 May
 2026 17:35:42 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:236:cafe::f8) by MN2PR05CA0059.outlook.office365.com
 (2603:10b6:208:236::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.7 via Frontend Transport; Thu, 7
 May 2026 17:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 17:35:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:19 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 10:35:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 7 May
 2026 10:35:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, "Simon
 Horman" <horms@kernel.org>, Kees Cook <kees@kernel.org>, Alex Vesker
	<valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: [PATCH net-next 2/3] net/mlx5: HWS, Handle destroying table that has a miss table
Date: Thu, 7 May 2026 20:34:42 +0300
Message-ID: <20260507173443.320465-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260507173443.320465-1-tariqt@nvidia.com>
References: <20260507173443.320465-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DS3PR12MB999239:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f1522ee-d4a7-4500-ce9d-08deac5f0ffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|7416014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2ESMp1NBwOfzQAeY7JQmY21/TrLKOH2Zmgcj2X9YLjWhDsY1j2U3IvIa0E5MYpAkVtsh4a0PQhkfSpa/HKvArK30PbrZ6rBdZT+NHRSKASXnFmFq60BD3M82CMypRTeGK72iaCc+wtZWkYBOLiWQ3+KcKEj1fQrhI4cxjqNwXp6eipZyJjvldUOiu6CNJ4UNfDEmOM9/ao2bUntqw0yo9bCUPqP/C8KGzF1Q76gajgxGkzReepJ9AMRaaVwdUJXJXTFv+ldmZ8KPGrLSSFmt9qvGfYuzeESNaw5fPG4zdNX70tNbdIGHITXcjfv29rq/Mg6ys7yz+wzRGhlNsi4iSyZSFal+J8nnRobAvonSol64sykKPTklVellui2jq+0tKDk/fE8zBqX34ksc6YSjWwoVttDTnvYNgU22ioXvL9iSUnINk41D0rMqyOAnEV1vgdold7M0lzffZr/rIqLNW2WsxPnSO9febSplfc3NMFqnz5tqFXSSsoUs6Mh2b409YkPUTV8kLxdkERgmmrkexoQWzMQXHfhLypu8mKDLVn2JmEPLCze6VyeUX4Tcjp3PtbHDdjG40TFAWyBntvVOhJ/KFhBhTlRGWqjyTDRMjEjSEJ8hLRGYwJ6zg0I08R0glY6/F1WLhbbLD53f2AJJOxzMS7XtVvoG16L+GiMlbGox7AO9ECyDZgx6oTvXKFg/qvgRqL2D7KY7z+ta3FBxLS7iWHSTl7ax9MO2PnI4jQs=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CZ0sXAjOGMs2C5KfhoWJZgR95TkpDnSwq3086oXwnA47xv4dgkxZBWrKmItwkVjPy2oif4ZX/4Et+Nq0vMXW8VIXS6ZB6i0Kx7v1luIbLZe8TdGJzo2TfsAnHwQB7WMGn1aZ2VcgO71of4KWJSQ6wtL6eVQ5//NpQrZG3ea7Xo1U0hkRdfEYR0q+Sk/pjBuRZ9tCE++6NAN340qnHyAxlJRTF9e0txLcD+WqgkehbP5kCVFzXne/aut6orf5PAXl7Zl9w5xdHAr+29VtX9ql43o4PmGUv8+F7XLL95JuImZIeZwATtnRAY+ELx6iulyRPHQvRxXzsAtaDM+P51nL3HAi2ae9P4HhO2hSGt5gXwbEcdeXZGerBq+LORBAV3MxdI9OX1P7YJlVsM/nOnYTxpeHlnd9WUCNGsp+71ajaZu4YDPYA3DzO+hWWP+qvZQh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 17:35:42.1372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1522ee-d4a7-4500-ce9d-08deac5f0ffe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999239
X-Rspamd-Queue-Id: CEFC84ECF47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20179-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

If a table has a miss table that was created by
'mlx5hws_table_set_default_miss' API function, its miss_tbl
keeps the table that points to it in a list.
If such table is deleted, we need to also remove it from the
miss_tbl list, otherwise the node in miss_tbl list will contain
garbage.

Signed-off-by: Erez Shitrit <erezsh@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
index bd292485a25b..dd7927983ab2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/table.c
@@ -282,6 +282,9 @@ int mlx5hws_table_destroy(struct mlx5hws_table *tbl)
 		goto unlock_err;
 	}
 
+	if (tbl->default_miss.miss_tbl)
+		list_del_init(&tbl->default_miss.next);
+
 	list_del_init(&tbl->tbl_list_node);
 	mutex_unlock(&ctx->ctrl_lock);
 
-- 
2.44.0


