Return-Path: <linux-rdma+bounces-22614-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sblKKJrDRGoK0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22614-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:36:58 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9E56EAB5B
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:36:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=p98OX5Sr;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22614-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22614-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12098301F4AE
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0523BADBD;
	Wed,  1 Jul 2026 07:34:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE603009F6;
	Wed,  1 Jul 2026 07:34:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891278; cv=fail; b=qztrvVGvVs5TJIjfBLTe+g/SZ/X3SaaKRWLIDIZ2oQ5QAyYSIXgjhbUeaqrkQnlgm1bGiS4VvkBxrIPDYUzJ3XdtN24r4CZY5HZ3/pHtXanVHwc1glXK7VdH2VcrHnpwPjWxuxdO1KrbHVJzANZ1M8glKKpJ32l/rOQAnd05lsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891278; c=relaxed/simple;
	bh=q1CSRouOkWQSNtwQ3rR7yGRZbyqNEZd1RAOFMKbBj2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuxYVQ22skQZAJBHS14tvlwFpvyuLeUqwjQiIZ9mp9z14CTAkSoiU0jTeK//Tkrd3b2xJcoG6bPSxW8vG9NuJVDl6ZaSiBDAImHl5IhMV5Y1bqppWpZi8i5rhqSEvpEMVQjIEhU8BU3fLLTCKcKp3rA1bHN6bxzYudxyQyAPgdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p98OX5Sr; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RzTwtwmbj7td2SQTWtxKB/4ezH5t70j++wQwbrYrneOnls2BgVU+7nd1d67rjsj5hFhZ1qLNWi3kBkwU8q414yneVw8bxi+El4e3s0kiqg9FwFznJ6Ld2zwxhJSFM06MxGGqTiQQycRGwLypqDRkO6zEwTlxM3cyMP9WIDku279qBcU76ZYY9fXoPUhvdSl3XFc7X0b4x6zYwU2NrN46+QEM2ZT5DcwC1S5de9stKpzHXIBOFNwlZIuwwSllDbPsb/d+J/fSoh1LFtlXKe8pFHxaS+W6ripb8RNaR/I8WdXtK+Y5aNWK30CXheDIOFzkc1El6xjgsU5KVQTndPJdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBJg/t/e0LmhRYT9rEMQJRNYOY4cbc6uoobEJS3OgHs=;
 b=n01YRFU2ije0GD8fvSRqZpEuXXSAiGcuA7tptYQUEtnmHYrDC8CPCWM6EZjBWZ3r01DVITLXAlRgc10fgy4lxC80p0+9J3N1kxy16cCgYoAw4diQgdJgMm8MdvRcTKbm5uSOM7rM6Cj3JeLbuk2gSuMcWuUsGDSRPCw5zrb7dAaOiS/5OVyq+8QDYpbYhSLzkIZqtkcfbzD0Rts9dwzy+AczpRsOpI6N0eb3oJb0qo4b685Sdl8pEmwFF/L+wcjomOU+CyVGQ6CRt8KCbLkLeP6tW+TEohdcMZNrwSRQcf7cjask837Mc5eOEIgaWxmQC1z8hFMvqkdgMOSNVlmmxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBJg/t/e0LmhRYT9rEMQJRNYOY4cbc6uoobEJS3OgHs=;
 b=p98OX5SrDfu8/oerfBDAGST1hzXmqF9R3J4Z3NxdWjKRZUAKVSxxOci7uer3uKc3wsYYt2J6EqO3fIADrBn6IHRgWqMV2xyKvtKpDiZPyhBQhUSjTwEAAAFi8NZ43HqG/Y/NuzclIfSfUB03D6XCy78n1Qm/akRUROAO+T1INWqRjtp5qSnAg6ro4ax/ajbJg0RWkAXDvDisX/vGrfoz48YnTpAlSux9/l10nbKVwWWEmPz2TYJS1Y3jUmNHwKgn2Y5He1budNze/gai7AO7nkxkMbgJYsnDJaQMRjq2wpEf9Ld0Z8Ubai8YYPZ3tEv97YM6Qq7nFieP9qeen5+TWA==
Received: from DM6PR01CA0009.prod.exchangelabs.com (2603:10b6:5:296::14) by
 LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:34:28 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::46) by DM6PR01CA0009.outlook.office365.com
 (2603:10b6:5:296::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:34:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:33:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Adithya Jayachandran <ajayachandra@nvidia.com>, Bobby Eshleman
	<bobbyeshleman@meta.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, Daniel Jurgens
	<danielj@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>, David Wei
	<dw@davidwei.uk>, Donald Hunter <donald.hunter@gmail.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Joe Damato <joe@dama.to>, Jonathan Corbet
	<corbet@lwn.net>, Kees Cook <kees@kernel.org>, Leon Romanovsky
	<leon@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ratheesh Kannoth
	<rkannoth@marvell.com>, Saeed Mahameed <saeedm@nvidia.com>, Shahar Shitrit
	<shshitrit@nvidia.com>, Shay Drori <shayd@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Simon Horman
	<horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Tariq Toukan
	<tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>, Gal Pressman
	<gal@nvidia.com>
Subject: [PATCH net-next V10 04/14] devlink: Decouple rate storage from associated devlink object
Date: Wed, 1 Jul 2026 10:32:44 +0300
Message-ID: <20260701073254.754518-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260701073254.754518-1-tariqt@nvidia.com>
References: <20260701073254.754518-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: 557df372-7f14-4f89-9063-08ded7432edb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|56012099006|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	XS2rHsPYBZIxEqCdcR4Osoks7sgw6tMkk3xbIDYX/aCDVI/IxRagLFqjpScRP0eJD9IOWeJPPe+kCojNY9yLA7mybNXW/LJpCpGSvFvIVU5lDl0/aUBiilmaprNvo0NXjOz74BCMg3werr7+rcSL6qTJw4gO3bHXR39eCJEmdX45zGze3PnBUbP4/EUKuotVhcThCXlkGrB0wwIwIp1zlAPfMToy4g+fZK6W+D/r30zI0hFIfbTrmHjp8NZK6sPOXUObQX7gDYYApxyOIPhZR5xV97wfr3eL+4l7gwbzGXBFMDuwLV1wLPTJGAX3z9m0gP5BEjX1SVcjQQ8yWu5XRezLu8Zp8MSNGma+QqrD+ShCmu2p8tbfuJ5puSd0DEIvYtHpjPbCD9ciVOYyEoo6nfkE5pBglhdQLFkGlt3ssPxXHvp7jnV2aF+4Crut3VQgVnSSLzF/w5dYPuyfJbDWXTHw/PF/B3NF8bMPTR8t+2Ssr7FOErUIxvGckUSSNSAMRBb4+zzngpfTfrXcXpeQE3KldmeowVqFAMzm0S/KD4pVZHCJYdLfeGtoedpPCSJ/iEK+aKf6HWyfT1msWsFbJyEbPXb+/fAjIzL///Yx5lQ9Y694IWGZmTjrYX61N835b+hrmmJpX7LME7Gy4imctZxPWJPjhL1axCzqi5QVQoOwwfQKrwe8/OCvM+162M+LmEVgJ82MMFnFlyxxSWbRbg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kQ8ghgSeecxa7I/QGHneZr5BrNy/uFqP8hCeQAE+C7u8F0qgWYG7PZtl/tz5URzSy2LeHAkUd5x8Kq70Cw3h5RUxDyDo05DXKAvEPt4AmlqjD2s72BOTDOO32eyUC9Md2oll0tsYGSzrPuLxuAxqOXSBGNZANXktfIbbgxLY66C4ML3KuW8ULR3bf1g833xiAkMvBaJdYyi+hiwm6XbUDi+xnqv/OsA10kezQZ75Y6MtJJOJL6KBEnp8sa0TIfJUPUvDfgNxrp4qxD300u+KXAp55SQsr3i/+CokT3pevgq05pe7VKdjDBY+aizwO/s96UJ6Q7RyYZBxJhb1DeNl275g0WlDHGcc7pnLZIXOmOg2J/HRHsSWaVb3Ns0bUaLX+56zmCdb1LifyilnJKZljYA8xXZZZeW+3H91G10hVu7vq0OB3Kr7SD3hIDfhYpUI
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:34:27.9345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 557df372-7f14-4f89-9063-08ded7432edb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22614-lists,linux-rdma=lfdr.de];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,meta.com,iogearbox.net,gmail.com,davidwei.uk,resnulli.us,dama.to,lwn.net,kernel.org,vger.kernel.org,marvell.com,linuxfoundation.org,fomichev.me,google.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D9E56EAB5B

From: Cosmin Ratiu <cratiu@nvidia.com>

Devlink rate leafs and nodes were stored in their respective devlink
objects pointed to by devlink_rate->devlink.

This patch removes that association by introducing the concept of
'rate node devlink', which is where all rates that could link to each
other are stored. For now this is the same as devlink_rate->devlink.

After this patch, the devlink rates stored in this devlink instance
could potentially be from multiple other devlink instances. So all rate
node manipulation code was updated to:
- correctly compare the actual devlink object during iteration.
- maybe acquire additional locks (noop for now).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/rate.c | 249 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 177 insertions(+), 72 deletions(-)

diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 630441e429b3..295f4185fdfd 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,13 +30,25 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+static struct devlink *devl_rate_lock(struct devlink *devlink)
+{
+	return devlink;
+}
+
+static void devl_rate_unlock(struct devlink *devlink,
+			     struct devlink *rate_devlink)
+{
+}
+
 static struct devlink_rate *
-devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
+devlink_rate_node_get_by_name(struct devlink *rate_devlink,
+			      struct devlink *devlink, const char *node_name)
 {
 	struct devlink_rate *devlink_rate;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate) &&
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate) &&
 		    !strcmp(node_name, devlink_rate->name))
 			return devlink_rate;
 	}
@@ -44,7 +56,8 @@ devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
 }
 
 static struct devlink_rate *
-devlink_rate_node_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
+devlink_rate_node_get_from_attrs(struct devlink *rate_devlink,
+				 struct devlink *devlink, struct nlattr **attrs)
 {
 	const char *rate_node_name;
 	size_t len;
@@ -57,24 +70,30 @@ devlink_rate_node_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
 	if (!len || strspn(rate_node_name, "0123456789") == len)
 		return ERR_PTR(-EINVAL);
 
-	return devlink_rate_node_get_by_name(devlink, rate_node_name);
+	return devlink_rate_node_get_by_name(rate_devlink, devlink,
+					     rate_node_name);
 }
 
 static struct devlink_rate *
-devlink_rate_node_get_from_info(struct devlink *devlink, struct genl_info *info)
+devlink_rate_node_get_from_info(struct devlink *rate_devlink,
+				struct devlink *devlink,
+				struct genl_info *info)
 {
-	return devlink_rate_node_get_from_attrs(devlink, info->attrs);
+	return devlink_rate_node_get_from_attrs(rate_devlink, devlink,
+						info->attrs);
 }
 
 static struct devlink_rate *
-devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
+devlink_rate_get_from_info(struct devlink *rate_devlink,
+			   struct devlink *devlink, struct genl_info *info)
 {
 	struct nlattr **attrs = info->attrs;
 
 	if (attrs[DEVLINK_ATTR_PORT_INDEX])
 		return devlink_rate_leaf_get_from_info(devlink, info);
 	else if (attrs[DEVLINK_ATTR_RATE_NODE_NAME])
-		return devlink_rate_node_get_from_info(devlink, info);
+		return devlink_rate_node_get_from_info(rate_devlink, devlink,
+						       info);
 	else
 		return ERR_PTR(-EINVAL);
 }
@@ -190,17 +209,25 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 void devlink_rates_notify_register(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(rate_node, &rate_devlink->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink, rate_devlink);
 }
 
 void devlink_rates_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry_reverse(rate_node, &rate_devlink->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	devl_rate_unlock(devlink, rate_devlink);
 }
 
 static int
@@ -209,17 +236,20 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
 	int idx = 0;
 	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
 		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
 		u32 id = NETLINK_CB(cb->skb).portid;
 
-		if (idx < state->idx) {
+		if (idx < state->idx || devlink_rate->devlink != devlink) {
 			idx++;
 			continue;
 		}
+
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
 					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
@@ -228,6 +258,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		}
 		idx++;
 	}
+	devl_rate_unlock(devlink, rate_devlink);
 
 	return err;
 }
@@ -239,28 +270,38 @@ int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *devlink_rate;
 	struct sk_buff *msg;
 	int err;
 
-	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	rate_devlink = devl_rate_lock(devlink);
+	devlink_rate = devlink_rate_get_from_info(rate_devlink, devlink, info);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_fill(msg, devlink_rate, DEVLINK_CMD_RATE_NEW,
 				   info->snd_portid, info->snd_seq, 0,
 				   info->extack);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_fill;
 
+	devl_rate_unlock(devlink, rate_devlink);
 	return genlmsg_reply(msg, info);
+
+err_fill:
+	nlmsg_free(msg);
+unlock:
+	devl_rate_unlock(devlink, rate_devlink);
+	return err;
 }
 
 static bool
@@ -277,6 +318,7 @@ devlink_rate_is_parent_node(struct devlink_rate *devlink_rate,
 
 static int
 devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
+				struct devlink *rate_devlink,
 				struct genl_info *info,
 				struct nlattr *nla_parent)
 {
@@ -304,7 +346,8 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		parent = devlink_rate_node_get_by_name(rate_devlink, devlink,
+						       parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -423,6 +466,7 @@ static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
 }
 
 static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
+			       struct devlink *rate_devlink,
 			       const struct devlink_ops *ops,
 			       struct genl_info *info)
 {
@@ -497,7 +541,8 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 	 */
 	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
 	if (nla_parent) {
-		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
+		err = devlink_nl_rate_parent_node_set(devlink_rate,
+						      rate_devlink, info,
 						      nla_parent);
 		if (err)
 			return err;
@@ -588,29 +633,37 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 
 int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *devlink_rate;
 	const struct devlink_ops *ops;
 	int err;
 
-	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	rate_devlink = devl_rate_lock(devlink);
+	devlink_rate = devlink_rate_get_from_info(rate_devlink, devlink, info);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	ops = devlink->ops;
-	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type))
-		return -EOPNOTSUPP;
+	if (!ops ||
+	    !devlink_rate_set_ops_supported(ops, info, devlink_rate->type)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
-	err = devlink_nl_rate_set(devlink_rate, ops, info);
+	err = devlink_nl_rate_set(devlink_rate, rate_devlink, ops, info);
 
 	if (!err)
 		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_unlock(devlink, rate_devlink);
 	return err;
 }
 
 int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *rate_node;
 	const struct devlink_ops *ops;
 	int err;
@@ -624,15 +677,22 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
-	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
-	if (!IS_ERR(rate_node))
-		return -EEXIST;
-	else if (rate_node == ERR_PTR(-EINVAL))
-		return -EINVAL;
+	rate_devlink = devl_rate_lock(devlink);
+	rate_node = devlink_rate_node_get_from_attrs(rate_devlink, devlink,
+						     info->attrs);
+	if (!IS_ERR(rate_node)) {
+		err = -EEXIST;
+		goto unlock;
+	} else if (rate_node == ERR_PTR(-EINVAL)) {
+		err = -EINVAL;
+		goto unlock;
+	}
 
 	rate_node = kzalloc_obj(*rate_node);
-	if (!rate_node)
-		return -ENOMEM;
+	if (!rate_node) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	rate_node->devlink = devlink;
 	rate_node->type = DEVLINK_RATE_TYPE_NODE;
@@ -646,13 +706,14 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_node_new;
 
-	err = devlink_nl_rate_set(rate_node, ops, info);
+	err = devlink_nl_rate_set(rate_node, rate_devlink, ops, info);
 	if (err)
 		goto err_rate_set;
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &rate_devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink, rate_devlink);
 	return 0;
 
 err_rate_set:
@@ -661,22 +722,29 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(rate_node->name);
 err_strdup:
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink, rate_devlink);
 	return err;
 }
 
 int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *rate_node;
 	int err;
 
-	rate_node = devlink_rate_node_get_from_info(devlink, info);
-	if (IS_ERR(rate_node))
-		return PTR_ERR(rate_node);
+	rate_devlink = devl_rate_lock(devlink);
+	rate_node = devlink_rate_node_get_from_info(rate_devlink, devlink,
+						    info);
+	if (IS_ERR(rate_node)) {
+		err = PTR_ERR(rate_node);
+		goto unlock;
+	}
 
 	if (refcount_read(&rate_node->refcnt) > 1) {
 		NL_SET_ERR_MSG(info->extack, "Node has children. Cannot delete node.");
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
@@ -687,6 +755,8 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del(&rate_node->list);
 	kfree(rate_node->name);
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink, rate_devlink);
 	return err;
 }
 
@@ -695,14 +765,20 @@ int devlink_rates_check(struct devlink *devlink,
 			struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
+	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (!rate_filter || rate_filter(devlink_rate)) {
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list)
+		if (devlink_rate->devlink == devlink &&
+		    (!rate_filter || rate_filter(devlink_rate))) {
 			if (extack)
 				NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
-			return -EBUSY;
+			err = -EBUSY;
+			break;
 		}
-	return 0;
+	devl_rate_unlock(devlink, rate_devlink);
+	return err;
 }
 
 /**
@@ -719,14 +795,21 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent)
 {
 	struct devlink_rate *rate_node;
-
-	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
-	if (!IS_ERR(rate_node))
-		return ERR_PTR(-EEXIST);
+	struct devlink *rate_devlink;
+
+	rate_devlink = devl_rate_lock(devlink);
+	rate_node = devlink_rate_node_get_by_name(rate_devlink, devlink,
+						  node_name);
+	if (!IS_ERR(rate_node)) {
+		rate_node = ERR_PTR(-EEXIST);
+		goto unlock;
+	}
 
 	rate_node = kzalloc_obj(*rate_node);
-	if (!rate_node)
-		return ERR_PTR(-ENOMEM);
+	if (!rate_node) {
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
 
 	rate_node->type = DEVLINK_RATE_TYPE_NODE;
 	rate_node->devlink = devlink;
@@ -735,7 +818,8 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	rate_node->name = kstrdup(node_name, GFP_KERNEL);
 	if (!rate_node->name) {
 		kfree(rate_node);
-		return ERR_PTR(-ENOMEM);
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
 	}
 
 	if (parent) {
@@ -744,8 +828,10 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	}
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &rate_devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_unlock(devlink, rate_devlink);
 	return rate_node;
 }
 EXPORT_SYMBOL_GPL(devl_rate_node_create);
@@ -761,10 +847,10 @@ EXPORT_SYMBOL_GPL(devl_rate_node_create);
 int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 			  struct devlink_rate *parent)
 {
-	struct devlink *devlink = devlink_port->devlink;
+	struct devlink *rate_devlink, *devlink = devlink_port->devlink;
 	struct devlink_rate *devlink_rate;
 
-	devl_assert_locked(devlink_port->devlink);
+	devl_assert_locked(devlink);
 
 	if (WARN_ON(devlink_port->devlink_rate))
 		return -EBUSY;
@@ -773,6 +859,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	if (!devlink_rate)
 		return -ENOMEM;
 
+	rate_devlink = devl_rate_lock(devlink);
 	if (parent) {
 		devlink_rate->parent = parent;
 		refcount_inc(&devlink_rate->parent->refcnt);
@@ -782,9 +869,10 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	devlink_rate->devlink = devlink;
 	devlink_rate->devlink_port = devlink_port;
 	devlink_rate->priv = priv;
-	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	list_add_tail(&devlink_rate->list, &rate_devlink->rate_list);
 	devlink_port->devlink_rate = devlink_rate;
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink, rate_devlink);
 
 	return 0;
 }
@@ -800,16 +888,19 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
 void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
 {
 	struct devlink_rate *devlink_rate = devlink_port->devlink_rate;
+	struct devlink *rate_devlink, *devlink = devlink_port->devlink;
 
-	devl_assert_locked(devlink_port->devlink);
+	devl_assert_locked(devlink);
 	if (!devlink_rate)
 		return;
 
+	rate_devlink = devl_rate_lock(devlink);
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
 	if (devlink_rate->parent)
 		refcount_dec(&devlink_rate->parent->refcnt);
 	list_del(&devlink_rate->list);
 	devlink_port->devlink_rate = NULL;
+	devl_rate_unlock(devlink, rate_devlink);
 	kfree(devlink_rate);
 }
 EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
@@ -818,20 +909,30 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
  * @devlink: devlink instance
  *
- * Unset parent for all rate objects and destroy all rate nodes
- * on specified device.
+ * Unset parent for all rate objects involving this device and destroy all rate
+ * nodes on it.
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
-	const struct devlink_ops *ops = devlink->ops;
 	struct devlink_rate *devlink_rate, *tmp;
+	const struct devlink_ops *ops;
+	struct devlink *rate_devlink;
 
 	devl_assert_locked(devlink);
+	rate_devlink = devl_rate_lock(devlink);
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (!devlink_rate->parent)
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
+		if (!devlink_rate->parent ||
+		    (devlink_rate->devlink != devlink &&
+		     devlink_rate->parent->devlink != devlink))
 			continue;
 
+		/* This could destroy rate objects on other devlinks in the
+		 * same hierarchy under 'rate_devlink'. This is safe because
+		 * the shared common ancestor is locked so there can be no
+		 * other concurrent rate operations on devlink_rate->devlink.
+		 */
+		ops = devlink_rate->devlink->ops;
 		if (devlink_rate_is_leaf(devlink_rate))
 			ops->rate_leaf_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
@@ -842,13 +943,17 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		refcount_dec(&devlink_rate->parent->refcnt);
 		devlink_rate->parent = NULL;
 	}
-	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate)) {
+	ops = devlink->ops;
+	list_for_each_entry_safe(devlink_rate, tmp, &rate_devlink->rate_list,
+				 list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate)) {
 			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
 			list_del(&devlink_rate->list);
 			kfree(devlink_rate->name);
 			kfree(devlink_rate);
 		}
 	}
+	devl_rate_unlock(devlink, rate_devlink);
 }
 EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-- 
2.44.0


