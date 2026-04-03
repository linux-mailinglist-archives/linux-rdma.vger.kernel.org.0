Return-Path: <linux-rdma+bounces-18971-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJjMNr+Ez2mwwwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18971-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:13:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5474D392A6C
	for <lists+linux-rdma@lfdr.de>; Fri, 03 Apr 2026 11:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C56C230B84A3
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Apr 2026 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0950364E86;
	Fri,  3 Apr 2026 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kJhiD9qQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011010.outbound.protection.outlook.com [52.101.62.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BAF38657D;
	Fri,  3 Apr 2026 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775207442; cv=fail; b=bOb8AwIVxWcs8lbfKJswauxohXDS2U3tdKUpN1uToJojhbDMIUg3vDJQSchuOvEQ6jZzcSGCeFT85XiCvCljjDoKtDFfdR8q5ti/Z7q9KcKHajpwAp0DFOMaZjCKuY+mDgYjbgoUAZxE6CJNix1foGY7F7HjkS+vLCk8Cz14rqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775207442; c=relaxed/simple;
	bh=o7S4FjoW9++IHTN+OUgnurVA3vxY+VWt44lJU75bSwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHeScGRFZjJh4UdzOpQ6hJsgKa3eoqDhKsE5NTmuVbhpT6oOGfBQlOwCGyurbtOkacT2WEXPN+4WCATHobqScQC3tQw3HyU8e42qKwa1jOS7wVXDZoWuWbwliuEbzKpEzUgLNE8a6YOl8zcpFkTIqmKmB0CAbtplPtIw8AhD0lE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kJhiD9qQ; arc=fail smtp.client-ip=52.101.62.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IILpORMPTO8OMTdLl2f6PHB9qDfBNsEAJ2ha9nhjrp9cl7XWajDuAnU47usgTdpKWgHBke5HqavNl+2ba7o7AshICDmNIXT2+OjzGfTFFMv2v7OitSLvlmaWX1sOBtxpbxNDJKW+HjuFKHSXQaddE9dV/SZqc+ZdVYYT6ZVhN+OWDMhJzEtZXKqnYlQyczsFiZisbByZOJNNbS15Dy5Lsr2LGJk/8W73/H6/An/CdWeB4Bfy2D42Ti1ZHUwxZH5BztgfDq8c+UAL/XQESmvlB0fSLD6KZj1YKl6K0noypxynofxtZ2Uxv6yKVS8tg2xH/2a44RgVU6pcRsLwGSp4nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JufVAOsz+AOuUnCEMShvoDXt1sEjrdHJCvtNJyFWj1M=;
 b=KdGBkwEEf1TKpBSIg3T8BHvJS9uRYtAVzHr5JPbm4JPPvlLPmp0yEr30fOQcgOM1+H1McSuxrXnRSfGvLiD7HPOtL7d8ep7jWz+/hTF5s5Wlyu/rw0C/0SQvjj7z3S8ebXmVVxR/dn/J2qX8EU5gyb7nkvfoilEoxz/8ymlAb7ZmQoBhak2TH9rrov5+zLeQobs12MfOJq7ItFg8hrFs4GBexgZA0plJPFNCteTfnNrMnau7UWhqd0+OHtBw2JPEgziTqmyq3jX1fE+YgrJjtDgfpZ3Wtppo0HyoX4z1k7loohwmJgIMMFrKnFzzA7e6pYZLqo4Q3RVAHh7JxQgyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JufVAOsz+AOuUnCEMShvoDXt1sEjrdHJCvtNJyFWj1M=;
 b=kJhiD9qQRRPOZIO97jGbwDComieS7WrsovloY7/lwHyMNdpFDEvWaAmY50sMh+2gCFPmCRG6erd5L4qxBTHY12H+6WDu4pBKzH7zH8m/yGki7t1LNn5B+h4/EmTVsDIKIWtmKolfItJsqfSSgcaLOKBRb4G6YE4I45ALgc2Y+UfoTrNQ4JKWfM2NLc9pNtPlK/jn+LvNzZSJ++tDgICy86vtDXTFHedY4sQUBiPh6hgePwY58eno8hywaBL8D/NZ//oK22x626Zz+8xyWdvVjV8tzKo1wop2A8ePxQVFrdOup9haydfHqHig4FNzCEkiOb1bmqeFk8HL4meU7poCrg==
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by CY8PR12MB7289.namprd12.prod.outlook.com (2603:10b6:930:56::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Fri, 3 Apr
 2026 09:10:32 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::38) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.21 via Frontend Transport; Fri,
 3 Apr 2026 09:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 09:10:31 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:11 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Apr
 2026 02:10:10 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Fri, 3 Apr
 2026 02:10:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Dragos
 Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Simon Horman
	<horms@kernel.org>, "Jacob Keller" <jacob.e.keller@intel.com>, Lama Kayal
	<lkayal@nvidia.com>, "Michal Swiatkowski"
	<michal.swiatkowski@linux.intel.com>, Carolina Jubran <cjubran@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, "Raed Salem" <raeds@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V2 1/5] net/mlx5e: XSK, Increase size for chunk_size param
Date: Fri, 3 Apr 2026 12:09:23 +0300
Message-ID: <20260403090927.139042-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260403090927.139042-1-tariqt@nvidia.com>
References: <20260403090927.139042-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|CY8PR12MB7289:EE_
X-MS-Office365-Filtering-Correlation-Id: 64182260-9c0b-4c74-21ec-08de9160db75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Y4nIDdKr3/nWt5mHih48DNnR3bag66lq/F+lozt4MTtPkCTS7hM3c+EutAfzkCLtuOy14Pt73dXMzgiIcGJB7MLxoEEziB1HEQ3R4shgMzKAg+YMMN7TJsm4WCPQ5WFF9e3L4fw1Ch4K3kO4bOUYvO+7cWubQXLWmPDkxp+3XySbxC1h2lr8QuSlrAtfyphHUdx+2xaK06KtyPuMOOQ8BdtYpcabWTNRuoBZLQtBb635jK3+6wH1PcvGz0YjovOg3PiNf4+gu9XuGruBw5uwNMEpX4b+HzXWw1CLIh6JySnhbI9EY//89OFCbbzDVw0GfmiAXW0jTwqanqpcoM4ToEKzSwTw/wGoNeKSyTVg0MKNEF7uzMFlYMgBxx514FIcPOBQI9C3vRBfeqbWjvmjx13fbKAlpF8YwImnRjA2dkLN5Xh55TdcFxSF3S75akL7TJlDWhWXY/3jYJsxA0syTrzmvMlfvfQZ5VEdbJ3ggygqN7BfBAubjDTSU0cHDDw9Le/KGE8CJG/4wpx0AsT37CWn5Oa0uPAj4MZ9Dv9edf8B19IOeOUDbtLL0qvopccQMIMMj9EqwGQgdZD9eUSeyZBRAIHjzIdxGtO8Ld3Kyv2G+RVQYlGIDmSNoQyc9R73mtL56kNQj0ludDYVnHDub48D+y7xaDc0sbaQdWi1NHa98sFCnGrpdFlucwS/RlNrmxWajPlMyMPKEKwmThpCc6/zBqdlbV/KXarurvJVkZwKtgeS3zmO0Txk9Byp1GXjG5chrTAaCTNespyru3XDDQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	miOaw0hsV1kWHcjxzz6MRjRfuA8n0e6+SKaQ1Ib0cDQ80s6TXXGIZCcD5jgis8kc4X3jvgvk/p/qALVQsjGfcSYCzXXeP20zgA88u488dmvUK0yD+ThWQXO2JOVTO4Ww8gT1fdP+7x2EqWmAvg3giloKzOfHTJI+DtkdJG8g6eFoopzFuzMo3DcBVVnGZjT635dhrmSnS/gL6rmlBLVVcJ/ldRX5VmGDP4HQGvmp4FIncR4/9BIKDU8PxKhef95pCpolSxghjluBvzpcVn/GJdy3N86YLvtki+6hdBuCHPBf0hfOpItwnoqSuvnIvDqNCTlxAOyjcdVs7FNAMa08HUKO41f8TwuQ3munLo3hp6I7MUvrRj37qgVXTdhdbdjnxFgA7tPdRQfqsSniVeWhi+VY5dNOPPX98ABBFfhDRP3E19zevQTbw3kQKfGYfwTG
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 09:10:31.6432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64182260-9c0b-4c74-21ec-08de9160db75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7289
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,iogearbox.net,gmail.com,fomichev.me,intel.com,linux.intel.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18971-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5474D392A6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Dragos Tatulea <dtatulea@nvidia.com>

When 64K pages are used, chunk_size can take the 64K value
which doesn't fit in u16. This results in overflows that
are detected in mlx5e_mpwrq_log_wqe_sz().

Increase the type to u32 to fix this.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/params.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 9b1a2aed17c3..275f9be53a34 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -8,7 +8,7 @@
 
 struct mlx5e_xsk_param {
 	u16 headroom;
-	u16 chunk_size;
+	u32 chunk_size;
 	bool unaligned;
 };
 
-- 
2.44.0


