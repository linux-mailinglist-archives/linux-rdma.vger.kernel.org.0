Return-Path: <linux-rdma+bounces-18179-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBbLHtQIuGkWYQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18179-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:42:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810AE29AA36
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 14:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A7BB301FDAD
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E666639B48E;
	Mon, 16 Mar 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q1bZeliJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D6339A7FE;
	Mon, 16 Mar 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668214; cv=fail; b=alA1JEEFcdtAm4O9fuewRho7NY9zJQC3VZhSfzorMYNeJJf3390zOmTZt+LS6gE6yqCuf6pdzxdydvg+PuVj9xIu0qcWXT/Z/B6m5XEOlphXusT7MrtxFIeMcOplm4cuTjW/Jhr5z0wJO1LDYxhOkHEp3AL0ayGNSFvbfbrFyvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668214; c=relaxed/simple;
	bh=qHRQ3351krmgalhW83rixPEQqbo5BHrRBId0NCie3Qo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nX5H2pnXuvRsoAli71IYkHWWzLFFtejtk7C5y6VJwVgZw20p4fu/ua5YluCRE0ISlgRYqj3FF9za3qcKdJz5z1j2hBhA3ht2UV/oVQu2YfJDJ0LfUG2t+Frhsibki8K5jXh/1Gnklu2vIbrt3fmBqRFgyCe+yfBk4py3BQRfMMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q1bZeliJ; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xNQKPDzV5iko6HtzgpnyRC6/Sgr4ydHhM4d6Jpn1cYiIBnJt+4sgCg7NvJ3VICvzk9X8RSFovfe0T2lNF8CKp1l9s8F3hIfNGoEcNQB/B6z7lUGuZdT8dd2rHtcVh7gpYW5qEWOfgFPViTK/2cK4DQxgG+7TZmRU3eFY7uWsIZehP4RWfacoXg4evEcm7rawxzN0ZfqTZTTu2NbeFigXGljOdzh3WGGjc/z4V7tDs3boGIrfxwlTFGV9oQeh5A63GrYDQAwf20yPMnS6WgnXeHQ3lRTyTUnYAIe+U69YA5EiQmIhZ6bTYgjMP09vx7e3OKVB5/7319OyP3tQXG++LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWCeSzsHlJZ39yqhT60ffGHHVRXfop9mo1PHQdIXEq0=;
 b=B/Ks/s8jnzHl6gwxSQqpFaWdrDPaa4hDZFQEZXxER0MCetjY37dHJV1EgGNPZeDLcmZEgY1RsbdzN7FeO+UYck3ZhcqqQTWoNrVJKbj6nJ8/yW1qhVczPTNLkS33EFg6xPKRFxMnqpSQo/63pXWkrYpJXjlkdsMyAdhwO3nMeQbe3EftL34Cc9cii2NsoxZTiNU5BmxYqxTEMm98n/vNnDjsEeCIvF4dX9bmvCkfbJP61YDsTZc2hOiwaFs3Nnv2R1XC462E5Q6rFg3YvHzmDKy3rGczDSIzyIYQrpYF7bl2+9PH4Ah5uZLEQ6oYcYJdlXMRD/uslQSaTW7GP9Q7Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWCeSzsHlJZ39yqhT60ffGHHVRXfop9mo1PHQdIXEq0=;
 b=Q1bZeliJpekiiYyo5ivnI+qzP9BTFzFSa6f30wJbLy7EFCNPokh32OxntBEsPQ1phyM/hwC+2Bn3zeuDFsk/MJcyVQBKKqYBHSp4gk7TTfSxq7xF90VnKv8Qum/sbRvBjUHKki77Ar/mO2/LcqskK5jGOt+ACxUvOTuTt4Mv1torREQ1clMwFVpBua/TwwPXQQPEo70tSBrdrWDPwZqqgx+sRdZ8mULckMFUMPH1g/YZLgwx3qYLkXkKABdzYvrzGcE5d3M7CaWBdnnCebV1/pp7em0OoY9E0OKeKX/L/vanW3c9lSsosy70a3i1Fb5nXFlZSgISUPBPCC87Dq9KkQ==
Received: from SA9PR13CA0018.namprd13.prod.outlook.com (2603:10b6:806:21::23)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 13:36:48 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::fa) by SA9PR13CA0018.outlook.office365.com
 (2603:10b6:806:21::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 13:36:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 13:36:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 06:36:35 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 16 Mar 2026 06:36:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Mar 2026 06:36:30 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>
Subject: [PATCH net-next 1/2] net/mlx5: Move crosststamp setup into helper function
Date: Mon, 16 Mar 2026 15:36:06 +0200
Message-ID: <20260316133607.8738-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260316133607.8738-1-tariqt@nvidia.com>
References: <20260316133607.8738-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 672213ea-1580-4c30-3645-08de836112bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	dje6D+XAXnL8CbHGVpkr5CwsZTfpGNIDtP/XIPxPKB+MzSd1pnvAU3R3CIQXTSOnD11A2rKSIU7XfVKtuvsPHhtV4LqMhGZEbcGy1GAXhCb1kmKGINfvOQK3q43E8dPlqmFg4UDaxGGEM5836VJ7AUVbjoVjxgiwgQFwZ+gsl21k6cvD9xQquJylz4eRtIDQ7pNiJrPC3CQRMI1aJfJgLMqvqz61pbtT75Q/cNtcdnm0ZBQJbaC7UznZOIkH1CtUOwNspg3WXnG7YERCFOSWMNBEOrD4Owuout8WC4GGcZ/fMAlAMgWMKXYIhfyVZs+90mvfN82iidnWsE2guWElc3AJA6V3b2My7fBl0hUKRxYHIA0Pu4h748pL4c4fUEWkXhURPTVb6lDBTM1ocOtf/NFZdvL6j3PMlM/p/4ppB75MsaTjXXK7reG7/l6VU0eaVmWhf6i5fktRjVly3psxqA52OdBHs9GA0ztVXQgcHwYJgNCEUhPSJZrKxLx2Ua212XvuNv7QPsC5fv9TZ/59s1wafKyC2Qa34ZBtCS5LZsyIAuOBix2B4MP5CQwuIqeWijyLGQ+QY3/OgZRrhSKJnCt8HL9DWhrqKquxq/UlH5zbG4BVSq/vGFO9VvNs4et+FnXuWyyZ+LPnbSTjUnj72N9M85XSntAEhnMxqAeijmoXGGJ/Svh9AlS8Gwitp6ONa0v2A3Y0duJ0B+omWv93M3/iUnE/PM+4qpEXUKK94U0FhpAWGzrxhONUAYJprMAWbqxM9D8p85fuXyv5Z2NYOA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NJKmUfLrwlH+a3efyi1h5CUE1LFJUf3ZVvt2irBzpFtJQs5ng7U2e7TsD2uIUj6H1l120A38MjzpqBk/C7dYbKv2P/e2aUwv4NA9H4jlko6+iMwDrZXRQnFrfvi5RIlaycl0H8ZlGD5jgAty1EJYeYN3SR1pbbzi1lg+sRab6mQagHzDKI256U8ywl4d2q+2/+2qd7Cm1E0fIwv6f7G4BCd+Y3iiaAck6zKVgzLHvXVGq3Cn/dk6CqWKAW1jrzht4sxXeN6AjdFWDuw+DKTR/AH+UhJNZIxJT3137TJvctg/F0siIQFgoemtwBoW0/0Dzq6H9aoutYXbBVR0fgOmKWDrJH4OBd/KYP2h6eqpv/tUdZ8kk2yUMTH3EE6IWJT6yJvMXZWvpze1A/sLJONakSVvdeIGQT1O9WasHuilPwkgkrVowO1WUhvIkGT4juzh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 13:36:48.1265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 672213ea-1580-4c30-3645-08de836112bc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18179-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 810AE29AA36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carolina Jubran <cjubran@nvidia.com>

Move the crosststamp registration logic into a dedicated helper,
mlx5_init_crosststamp().

This prepares the code for a follow-up patch around PTM handling.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 28 +++++++++++++------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..3322814819ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1301,6 +1301,24 @@ static void mlx5_init_timer_max_freq_adjustment(struct mlx5_core_dev *mdev)
 			min(S32_MAX, 1 << log_max_freq_adjustment);
 }
 
+static void mlx5_init_crosststamp(struct mlx5_core_dev *mdev,
+				  bool expose_cycles, struct mlx5_clock *clock)
+{
+#if defined(CONFIG_X86)
+	if (!boot_cpu_has(X86_FEATURE_ART))
+		return;
+
+	if (!MLX5_CAP_MCAM_REG3(mdev, mtptm) ||
+	    !MLX5_CAP_MCAM_REG3(mdev, mtctr))
+		return;
+
+	clock->ptp_info.getcrosststamp = mlx5_ptp_getcrosststamp;
+	if (expose_cycles)
+		clock->ptp_info.getcrosscycles = mlx5_ptp_getcrosscycles;
+
+#endif /* CONFIG_X86 */
+}
+
 static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = mdev->clock;
@@ -1315,15 +1333,7 @@ static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 	expose_cycles = !MLX5_CAP_GEN(mdev, disciplined_fr_counter) ||
 			!mlx5_real_time_mode(mdev);
 
-#ifdef CONFIG_X86
-	if (MLX5_CAP_MCAM_REG3(mdev, mtptm) &&
-	    MLX5_CAP_MCAM_REG3(mdev, mtctr) && boot_cpu_has(X86_FEATURE_ART)) {
-		clock->ptp_info.getcrosststamp = mlx5_ptp_getcrosststamp;
-		if (expose_cycles)
-			clock->ptp_info.getcrosscycles =
-				mlx5_ptp_getcrosscycles;
-	}
-#endif /* CONFIG_X86 */
+	mlx5_init_crosststamp(mdev, expose_cycles, clock);
 
 	if (expose_cycles)
 		clock->ptp_info.getcyclesx64 = mlx5_ptp_getcyclesx;
-- 
2.44.0


