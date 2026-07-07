Return-Path: <linux-rdma+bounces-22845-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 62NsAS08TWrTxAEAu9opvQ
	(envelope-from <linux-rdma+bounces-22845-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:49:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ECE71E699
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Jul 2026 19:49:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="Sbjrct4/";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22845-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22845-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E6DF307811F
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2026 17:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF7143C7C6;
	Tue,  7 Jul 2026 17:46:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013024.outbound.protection.outlook.com [40.93.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B28543B6D6;
	Tue,  7 Jul 2026 17:46:19 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446381; cv=fail; b=UsMlq8mqySh0eaqVBKndfFmOTjkEz+Z/LtbEnCRQqFK0IhCkSR0ZoeMkou0PSklTva9QrbndFFRXgPT8aaBx3omt8JGCEQSbUtdSdcihyRWgJ2d3L5R9jbhOT4y1wbB2Kb9G9sGXuj5jwfLVg70dxpnYiAEqRT7qLlhHoZ97IyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446381; c=relaxed/simple;
	bh=lm7mw6VUdHIhpsx+RF+eTvhGqByInEuGsRj18XgrTjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMPcpYL8g/6xdalc0YyUZ5FVGvKWLoPH3cIs+ZiMZH66vOmjFC1SIaZZlC33PjlGG6fXwjhwEHyAB1XxWS2Pm6gL+Me0GaGaygOfqEmP2FXX/7Xhtqy/EpVeO6+tGDkvNRToh917hSIsDViO75LKJ+D7uJ6OwFSxp5SIX2gfG6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sbjrct4/; arc=fail smtp.client-ip=40.93.201.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIvFEls+rIJZzoMdtU0vNajJSqj5fwA8DgMe6MD/LMGdtKg1/Ez7NCLqAGsK2vgnoIezF+koQrIpiXnSe+wdy2i7Y/7oe3HoB9MLmaSH/YyUt2lSUVHkUt138eR2DrdwPJaQMRRi+92fOcBOPFa2gs5sabEjVhPFUIeh7HO8She8p5ldPwPnd3KwgAcU/Y6ojGo6Lx9hHMWCVEEXXHtEMPM9Vpk1Ytim2Zwv6X29SiIVdptDYsjiedeD8j+0hqjf8LNJFEI/WASHKwFCBCRkGprJymqqiQQosOAXb8x3/3cvs9XpEe/TuitZT1Qq90mbUmpcbvQxnt1uaLkeKtg97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDL5h/lEtoJZ8UDBIEbM+jhmOCzuMpZQ8e3jNGxPXUg=;
 b=ZbKPow41MPQ2iMqr4tXdX+ec8BHkG1GG2v4zV3RsEt6gacAsI3zPWEvhDVXEMZGUIQZppMulcGtNO3brug6R4fv1h/IItHvBqK8O199e3pUr1w7pqXzSmcAUl9uvj+CrH9CwHgdLIkPtxyZKQMVEYd4Q+ldH9I8b8d/RDnrPdtqnVFHoV9rV7YWYxeNHfnyS1U/HDfK/qrOwYcWhi/Np4muqJpWf8mmZUhmk7wxjtmlH3WYv++gJxRbGuF0zBaHI0SKOHQu006tc6XQtyPjcZIaVm+D0fQku1CkySHopuMBIqavLg7WGT1BNbsqenkr/U3ewlzbgvTIIhvKswyK78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=resnulli.us smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDL5h/lEtoJZ8UDBIEbM+jhmOCzuMpZQ8e3jNGxPXUg=;
 b=Sbjrct4/Z0WeBHjNTfg9awErE1tv/+O/eRNuLwNTI3mvSjzXhS+QVBBx7MGdM/HjC1s2CH4AzyM1J4aCtAB90UmTI79BYoXknBY4Y3DmC4xFoeRlBPMV12IKk2Pub+bmLG2U5/DNSg1h+sSMtZOZtcK1ksBebHdvnJxnZT5oOgC1WlFGYryISlRotjtQpxfjCzo+8yfKiCQYQ8s5cxEF0ogab3EKb8VZwvJRm9z0rJeXbFelTLQMYTB8dxBAdiQi9ncP9hjRJqZ0D7yaszZ/T3AQCxx/VYMLyrtanmnopeyeaZ40bXohmC4TUr7m2L7uxUkCKxKT3ZbZugeIXpy9YA==
Received: from CH2PR20CA0030.namprd20.prod.outlook.com (2603:10b6:610:58::40)
 by DS7PR12MB6045.namprd12.prod.outlook.com (2603:10b6:8:86::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 17:46:13 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::1d) by CH2PR20CA0030.outlook.office365.com
 (2603:10b6:610:58::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 17:46:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 17:46:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Jul
 2026 10:45:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 7 Jul 2026 10:45:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 7 Jul 2026 10:45:52 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Jiri Pirko <jiri@resnulli.us>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V5 5/6] devlink: Add API to apply eswitch mode boot default
Date: Tue, 7 Jul 2026 20:45:26 +0300
Message-ID: <20260707174527.425134-6-mbloch@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707174527.425134-1-mbloch@nvidia.com>
References: <20260707174527.425134-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|DS7PR12MB6045:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3f59a5-c02e-41e7-8180-08dedc4fa2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Pkb5krUEoqHVP/Fw18x4VknYmFGvT7jov86sBpplOVHaWKxSOkCpAhYFJWEyLNKT1miWps2pbe6/uqBBgOqXtPxThU273bRCbv1EgfZ6mdznnjs8agjP+ZwH/Hk6iZ5i9Gc3qqz0UefN9dgwuiy3GA7HjUg/EhlrumgHQk2gPZM40EEQ7Xo3Jbu7PnOPcV08hfCcT/MgDxymX+Xu5ZxkmLJ0MONz6spqQWyoykk2TIqtLfW+7wLGyai67OkUjjk3sQB8bWhNhGhOKUaYRz9tyyXBzLDf8apUKnn1ff0lwsFN+QTlG43F1hRrgjQAXtGczKkXL1Ngcbz52a0QJMefTOGtTYlvg3qD3uo1mZC8RtdC2ZdLu5BAkld6Wg1wpuZg76oT/W/IzbFqfMWjw/84qfbkkJGudND3Xso6Vww4PAMJNIes5cveJMr8tBsRJi0++W65BOnEV+Jb75pWrRta06ReBpEYf6rLRr2ha4QG4OYO1A3H+Z19dJq7UL0GgC2j83hEzV2RFwsbYuRfeEi8CtOXkP9T1fBIokujzy335BemOQA1l20dQo9uSlB5MPHKhwQxJreeduNQrbSr2ZC1kiPCCFsIDmWoOq0YV0EOikqwD1T1ohyCt8Y75JLjAkQwhukQvj86Q+UhwDObZieiiJNQEKXYH0BDL6D0WHV5mMZgzc6sOab2Rij6K3C5wG/NiAlFziTNElKIw/wBAGZgwA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YcHC17WRyv6bDvzlbQOPVWV1GVqS95lcekjxTGwGeCXQhbcM33hqq87WAw1HQR17UnKVbJtBbr96YnAVqWvchUp5CyPxceTaYfehUvLHYtSPSeIMqhG/NaIC+oUigdsR/40XQXmYyFcMFFK9LCK80EhjWN27oYUdIfRhVroL9I0IIeNL16RtC15T24gLhJKP2QeguKu1POeVvslQ6KIAinfSigSTMSERecdb+0V759MMjry4WcRdqFG4O4LX2ZqqX97sCSecuNVv8zASuAoROyA4ZJpoh82cCnwPvOKG+EixR0h2HUWfYTCeYHwoPdxBkFvndWvmPAWWfsGS8za540BUu7TyoahgJVNFTMTiF6IjlKzbyBffldZxTZk+2fzoZHI0VeqlZ4WYKVfYWLK76SPIrDgaEfG1nCvTNhrBUgpDwqsS2M/xxmWqiOELDkoE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 17:46:12.1153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3f59a5-c02e-41e7-8180-08dedc4fa2a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22845-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:mbloch@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1ECE71E699

Add devl_apply_default_esw_mode() for drivers that can apply the
devlink_eswitch_mode= boot default once their device is ready instead of
waiting for the asynchronous registration work.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 include/net/devlink.h |  1 +
 net/devlink/default.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index ffe1ad5fb70b..90da03c0112c 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1661,6 +1661,7 @@ static inline struct devlink *devlink_alloc(const struct devlink_ops *ops,
 
 int devl_register(struct devlink *devlink);
 void devl_unregister(struct devlink *devlink);
+void devl_apply_default_esw_mode(struct devlink *devlink);
 void devlink_register(struct devlink *devlink);
 void devlink_unregister(struct devlink *devlink);
 void devlink_free(struct devlink *devlink);
diff --git a/net/devlink/default.c b/net/devlink/default.c
index 896146d1b8e7..5a37d76731e1 100644
--- a/net/devlink/default.c
+++ b/net/devlink/default.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include <linux/init.h>
+#include <linux/export.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -279,6 +280,24 @@ void devlink_default_esw_mode_apply_pending_clear(struct devlink *devlink)
 	devlink->default_esw_mode_apply_pending = false;
 }
 
+/**
+ * devl_apply_default_esw_mode - Apply devlink eswitch mode boot default
+ * @devlink: devlink
+ *
+ * Apply the devlink eswitch mode selected by the devlink_eswitch_mode=
+ * kernel command line parameter, if any matches @devlink.
+ *
+ * The caller must hold the devlink instance lock.
+ */
+void devl_apply_default_esw_mode(struct devlink *devlink)
+{
+	devl_assert_locked(devlink);
+
+	devlink->default_esw_mode_apply_pending = false;
+	devlink_default_esw_mode_apply_locked(devlink);
+}
+EXPORT_SYMBOL_GPL(devl_apply_default_esw_mode);
+
 void devlink_default_esw_mode_instance_cleanup(struct devlink *devlink)
 {
 	if (cancel_work_sync(&devlink->default_esw_mode_apply_work))
-- 
2.43.0


