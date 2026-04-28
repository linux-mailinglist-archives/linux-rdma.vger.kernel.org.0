Return-Path: <linux-rdma+bounces-19631-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGWHCHJI8GmIRAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19631-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:41:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC92F47DBB1
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 484243020A80
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75240334695;
	Tue, 28 Apr 2026 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7iiDaoy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3CD31F982;
	Tue, 28 Apr 2026 05:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354815; cv=fail; b=S8WehDt3tB+B9Qiwc7auJpyBdinQINtpkRMj6OkRNf+fd0B2HVtnNcYK2AfUCqW5Wj3fd8BYTSwP/ajOBzUbsCBHWVqlNchnXxU7tQBo75VoY4QGpBW12IItihvzXVwAneBlOKTkxJtIY1SM67O1cZkzGvjSYZUP832dXqAbgf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354815; c=relaxed/simple;
	bh=X1s/xlSMbeDc+z63dd9c7usVGdxIkdGNKZli2rBAX6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENCxBOK1KgCK2fTLcJByqEejFLJBguGcKSjBIC3LdIazrf305yfnoD0LuEY99l73kB/nXO6aieNJLL9VitzWhy/iHCK9uUKyPfeYfHBOp058SrQkNzFjbpS8Wa1UGZ7hRgAhmyKXvi15QrkCRXUrCRTNAZ6rhTeiAV2+5jV8m8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7iiDaoy; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yN2IX5blK2EaCe65ce5AYNpJLQ0gmo5wcCLgCDgYwkN2xzgig6qQU8DG0pi99G5Gqq5E/INQD7Aw0iDIhJhVbH5mMjNWbHLhy+cNUaDiiP6S9oGeq55wLGdqc1R3B/ABmD1AssnkCkFyvAylKz/KPyoz6zVctDevXywu/jy0L63Q6prcV9WsAgNsSaYXN18c6DiMXIO5oNj6MRbgzrpCV04Lk6fC/NVX8biWTTAk8f19JSw5KPu8uE9ojI0PqNKVY4bEnkMlBqBpmTbakSt4qyt5VbJAkDKvufWuq6+/UbZOcTVdL6C2HkszrS5PApmpqn3k/Sr3Hg3G/rRPlgytlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkCM7DuhMTDV1ZKqtj+f/z05z6Erwd6+aPPX7UgKua8=;
 b=pM+f8/C0rmKSV/oIxk5e825fCsHFDEz78A10kry+/td3rqHCp4wFnYPwmld/3SOKm2Eg74MqxclwA3yVPgC8QZa1NBygqHTvJU/Lwk+Kgbc99ASUQW1dEKi192c6JfxUtCxWBUtwlWHTts4wZgvlGSw9cLXL/A/r81lp+z64e3kvey0AIF9BwzreIqBO58dPS0lkrhucRURv6qAz0ep/eFfyyNN+BftFmr5QtKUQ6w5hy5vSMncOXOH907Er2WwNoIUjzSaHg3Kdnr8zQPej+5O/jeCAVHzxkh52UoUfSvMRY2SwvQYw/u8afAVjuaWLIpQbpplQxPGR76OYZlFYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkCM7DuhMTDV1ZKqtj+f/z05z6Erwd6+aPPX7UgKua8=;
 b=G7iiDaoyXuJduZAcLYUmx6afSQe0PWyRuQ2yc7Vgs6Eri+k9/S2IqudX2GxZ/qdo8oo1oPx21ukU2e7bTEDN8JCGaEEqzuXwYpCopH+b3oUBNlsA2rsfYiOCBcI6A+S+91xbl1xwDkWgBzAePTrLzRwMXYyiQLxbT/m4RWYPa4+ZkW4R9HBR/+hymLd9cr844bz3B53yMCecJs+uKrSLuwwxMJvBfkqwp5wb9R73ll/shLzNreoxMzhCjb109zpVbOUUqqmglRsXtpWaKMemo+L1kJRRqx7c1mDIicLScF+keysKprKTrib0gAinY0ktdJgDMqPJkOnNQaaEMRXXIQ==
Received: from CH0P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::35)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Tue, 28 Apr
 2026 05:40:08 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::31) by CH0P223CA0009.outlook.office365.com
 (2603:10b6:610:116::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Tue,
 28 Apr 2026 05:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:40:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:52 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:39:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:39:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Kees Cook <kees@kernel.org>, Daniel Jurgens
	<danielj@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Simon Horman
	<horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH mlx5-next 2/4] net/mlx5: Add function_id_type for enable/disable_hca cmds
Date: Tue, 28 Apr 2026 08:38:49 +0300
Message-ID: <20260428053851.220089-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428053851.220089-1-tariqt@nvidia.com>
References: <20260428053851.220089-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 81821bae-0bb8-4ff6-69ae-08dea4e89b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LZ2jhTi8ZHcLwfT4Fp0z9X8kcpHrvKbjZZGVecpjKQeGGdFJmMmxwnbepkDwyBWqDUOOPpBKUf5Mf4fumoWC4apv58R+H45haFJjLMWglxRcaSx2q5BvEshKGLrLt9wKuqrwwYxQdg52Daz49Yipq2rNbvpGbSprbwE5W0waA0bmKnbQpEUHiI38TlEn8JtqMdDX2/aLMdadI7WedZfCqbfeJvFXLkbRfSElNc1awYbka2AD77WqklMZqenLe/rgpsqWhr3Fn3xvMXQSAaetd85gv8lVDqHlnwevDrixx/va4CcrHDxnHYUC03HGHW3iOGV9MvtejVRFS4X7rzH8fRNtf+hmgcCaFCqHu7q0PEMYo72l8QCZ8fc7WXMq+VdZZeinKFaPcu0ekde1ADL8oDqNX+jzUv1YQ4YtFCmqHn+/F9wZWazyL04XZ+qAMuL51QwbJna8Hfl/x4yVILxQldELyne7S6OOm44Q3tEuYs+hnff4Qb7YpXbUIZWeSp22f6Rkl1QFy2rf3PDMtYC+vqN6S+1YANihMG/NK2ANBC5SE5zm1iS8C+seuZZra9T1YVw92hnNzS7Dmm8rQrICnP6YInKKshsFJeKfLDEtFc7G4xU14uYqa2EexznmpDDdn3XU63505M88Niv72HFb53iuQRpa1kuaG6LF2lxpJW4gQkvlG/kzFAyP0VE5tcPEsN3qY8Y6loTJ+U6fnZlZ+CuPnwwdWo71XQus7W/BHhvdGkxnOO1vepNRp9GRnZTrlhk7Lf3eT3xSy05uD70cyQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CCBq/jbPgcDOtgllb5Yj5oytwNmQfX9DCLiCbtaQR4j7x9+WZ0TCdwb9zrLmwf6aqT7siev/ewl5LWakpUjBkaNkae8axEmW6p2hJq9oxuwsJcStaJtfaJ2lY4x2FZQUCTWvParMBh+exYqXy0WOX+t79dYaL7xIxLTTB99RFNSfUCT9k+MhW7Sc09FESggZ/zz4thYukNngjdjtvPtfa/nnMUjGutSOToFkjBSbyyC8g+Tg3ikhM3EV3P5gTKOkXVx2gZrukW3wLgiHETyldgnlwPicma+zGONm8CWc8zAzCNkw+eXf1VFTqKCer67qfguWzlWoqxqRxbPOM/CcOlJzxFaNn6RiFHcYFU3+y8qiy4GsJ+2BKSUFnRzQk5qJrgWsx1EUaR2w2ItLkn4P2StDJLyAzRSMwprqtIHDyao+j+w4147Clv7XYNnXanhS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:40:07.7259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81821bae-0bb8-4ff6-69ae-08dea4e89b55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
X-Rspamd-Queue-Id: BC92F47DBB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19631-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Moshe Shemesh <moshe@nvidia.com>

Add a function_id_type field to the enable_hca and disable_hca command
input layouts in mlx5_ifc.h to allow using vhca_id as the function index
instead of function_id. The new field support by firmware is indicated
by the function_id_type_vhca_id capability bit, which is already exposed
in hca caps.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 49f3ad4b1a7c..06ec1f5d2c6c 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -8452,7 +8452,9 @@ struct mlx5_ifc_enable_hca_in_bits {
 	u8         op_mod[0x10];
 
 	u8         embedded_cpu_function[0x1];
-	u8         reserved_at_41[0xf];
+	u8         reserved_at_41[0x2];
+	u8         function_id_type[0x1];
+	u8         reserved_at_44[0xc];
 	u8         function_id[0x10];
 
 	u8         reserved_at_60[0x20];
@@ -8497,7 +8499,9 @@ struct mlx5_ifc_disable_hca_in_bits {
 	u8         op_mod[0x10];
 
 	u8         embedded_cpu_function[0x1];
-	u8         reserved_at_41[0xf];
+	u8         reserved_at_41[0x2];
+	u8         function_id_type[0x1];
+	u8         reserved_at_44[0xc];
 	u8         function_id[0x10];
 
 	u8         reserved_at_60[0x20];
-- 
2.44.0


