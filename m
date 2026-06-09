Return-Path: <linux-rdma+bounces-22002-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /TQfCdWnJ2r60AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22002-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:42:45 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B07165C828
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:42:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MiLi5Ge2;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22002-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22002-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38850309E371
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087F23C8184;
	Tue,  9 Jun 2026 05:41:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012012.outbound.protection.outlook.com [40.107.200.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9E3BFAED;
	Tue,  9 Jun 2026 05:41:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983682; cv=fail; b=bjdxTdAkwfQCWFw7CIEU0Acy0gvFPO4hkkelLuG8v1TPpM/G1EbBtqo8yyo9bV77YQdCp2Vj4dRqG+as/y5i79bx0HfEZeKOsxMUwFFriw/LUnZDVx5f5wgAQgczbl/F00/Ahskn/BirmX5L1VBRCHFWeQrwf6BsrayffAs9PeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983682; c=relaxed/simple;
	bh=Bml8HJD8Wt7L1EDokMwsDE0OtmkW3G0blAiq/Nacp2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGziFkOhYDp3Kc6q57vJr2KQSwoKz404dytGFQQX5audv1/GyDM80luj95iahbBZXvg1PGdDOiowjItBEBA78XoQRfdoQsKmpwRNgMKGM62zGueplGJNTmSSfsX/7HWUMxVqGLaAPVO8RafkibjaGlLuo66CuoGXia09vBynbSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MiLi5Ge2; arc=fail smtp.client-ip=40.107.200.12
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lOw/m1uIL2KsJJ3RBwTdq2prems7G8vjUuMrzN3BuwfsWjhE80qJ6tYsNmOV/9LZISPDZoE9Q0njczLgrqS+s6preJnEgBd5cZ6ZOD6PAx5Wb6ahtb899LyhlUUtrms8My01l4OeS8v6El18efjuaI506DvmNV7BfCjEPSFIcw8khSdM+XhQqMJ+lUP/ijw6y/3jOTFWqWcfj2U+FWdQKX5dpuuIustCuaufIAYQ1e2ApvR63Ra/mOP+yPxKGfG6fD6S8xi944a0pBGLxIbmjMeDjRQ8LAWXrayW179Qk54zxnZM7N7vL+j36VBllFnikBnMfOOjP9eLpGhEKP+95Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np96tf0581hyWFOrxd1bRmwj+KrB8sOyNLSTEKH4i6A=;
 b=XFmKppZGHxskMyxMKI7TNWKxIm9i9ZU7Igy9Mpp2gO4g851L0pgWyeLlvIuAIAv3R8E9/KwnuClynAR7SaLJey6OSnOiylrJcHa/TJ80jj5LRK2Z5/Cfiv8lGqt93H9V9MsMoYKOYRNOa+Hf0HvNMi9yPsPUHHVfbbSXl6DsDamC15ZQcRkDVE2iUryjx36YOYoP4OOQ1HSKT0J7pdCihp+vpZho+9HVZweP3I8K6XSjNVEXIOAvgAlR6pTbmo6ggsHpU3qBf9FB2mrhJEal1dxdbxraIuNTb5yqwOfqYtx9o0Z0NAumgluEwkSqbLJ6+C/c7dr9oVml9JnGlCzMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=np96tf0581hyWFOrxd1bRmwj+KrB8sOyNLSTEKH4i6A=;
 b=MiLi5Ge2jtcUrdY0V/FoKzU1w4LPSk/0p0UMm/cRwNOyKO6dJaBk0s4WZOcGPSLhzsg75AMCGsOgm+eYcoxGisA3X6pzwtzWDV11VNYtsje8zooQHpWansGKaBE4yb5EK9TeAtNTOIo8UY4M3Jb/C6XOR93qbUMOp2uF+Bn8RCG2ahK5DrKiq9zojJHY4W5uleBBtISV94kDDrIc6MJeSRCGMNaKnHJWM/vUJ4Rhb/AKPAlB0awpd4WJSaF4/f1RJXWEBIg6NupYFGxHyjKAyqFpVAEmlAX7wrZ8n9jG3JAh66tryl8s3tegrlQuOTUuOdoFJ+Xt7Sy+Z7g+wlaVyQ==
Received: from SN6PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:805:106::24) by MW4PR12MB7468.namprd12.prod.outlook.com
 (2603:10b6:303:212::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Tue, 9 Jun 2026
 05:41:16 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::2e) by SN6PR2101CA0014.outlook.office365.com
 (2603:10b6:805:106::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 05:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:41:16 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:41:01 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:41:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:40:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, "Chuck
 Lever" <chuck.lever@oracle.com>, Or Har-Toov <ohartoov@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka
	<daniel.zahka@gmail.com>, Shahar Shitrit <shshitrit@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Kees Cook <kees@kernel.org>, Adithya Jayachandran
	<ajayachandra@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Petr Machata
	<petrm@nvidia.com>
Subject: [PATCH iproute2-next 3/7] devlink: fix memory leak in resource_ctx_fini
Date: Tue, 9 Jun 2026 08:39:49 +0300
Message-ID: <20260609053953.487152-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260609053953.487152-1-tariqt@nvidia.com>
References: <20260609053953.487152-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c9e678-8135-4140-5e30-08dec5e9b980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	22JyeTBlpKiQxnbQjnK1Wsrqc/k+Lj2dp0sM4ErHEo8NoQvLUUQL131rT/kZIw8ALeUKHPKQKVf52wwiyWcLLlZnvAg7wHvSoS9YmRR7aeAcBmuM3D+ilnfKhH92HWs3Vno5B4MBGUnuivVWUguI7BXgrUZuGu0//+wjMpb7CgkhXiHv7a0MbsqcvhJxbOM4nbuvfOaTTlUEpxFQ6Ev8uyfbGVNeQpi04ZtkTMcoR1ifGpSYM9awUHPD6x8s9O9ZKJ6XmOrMWC13m/3QkAtscPboUBHFtUWtjYvA91QVtt81FQ0CBPxy556rKyCsS494LzL4XQJUvO90rQqYF1pnuKbZKi4diOhranK/vc8St4pOzdTQd7NqWZUbe/z+IQbQHXr6tfOO51mSM7Cvurun5dVgGxgdUUAv1TWfAEQ/ggBS3HoaniBz81ZeFi7ZwKgDEuXgrEaUuotZYJGJug0adOSv0sF+MilFPPdVAekgYGb5yjrolqqQYQRxLDptdEkG4cSWf4KDck86iHHPk2AGbm0O/Q28gJHEITgFwglvjnkTpZPeWDt8JeeBAki+a5m5anC6jhPicAa7g6cxZ2ksVzoIeNbSjI6gyYc7ZntqH0IFrU01ukGEm0swOAA2IOOEHOohyxM5A3bIijX9oSD6Be2pTLgoeK+ljEXkZ4IpVukSKZJWpv+YCpBQJOhR5/hQ/7iSImCjlq9K6SpTsM/1sVfkQ3maTnKgJ078tCfa9vo=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ll/XggNTAI1E9mfgEHVkGc2omyD+vXrqQBuhkS7IM1iqYQjWBDkAXRv/peKQspFcFIOlo0dh9izhSJsLGJEwDGYlRG12yfySsV2UfCyemDyhosxjHV/P3cJdzkc2i7OZzUdR4NFN6xLg6qUMIU+y3bFd+GO+8uKzr/5AjI1rC3S98Y35USBoxl3ZvbRnLrdbrray4dKjVGAXHpHq1XgR7/2hLATqInKt2PcL/injrNg26r3+7PPzMICMHI3F/BqUkI3VlxqT8igIojnQBcj+U5dOcPVfPHWqJ/LrTVMjhNvHVj4V23KqTClkoblFPvYEFj9RM2UNxL0Vy5wmQHhhsEDaxnH7qFk1/ONSfbTFZdQIz+sMQkRKDqllBc36zLjggQ9LFkZQVfGCLFL6vYr76iZe0QaZHpxTuk0R7iCEzbB429UfUPJjvAv6bhnocJmM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:41:16.2033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c9e678-8135-4140-5e30-08dec5e9b980
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:ohartoov@nvidia.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.
 com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22002-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B07165C828

From: Or Har-Toov <ohartoov@nvidia.com>

resource_ctx_init() allocates ctx->resources via resources_alloc()
which calls calloc(). resource_ctx_fini() calls resources_free() to
free the list items inside the struct, but never frees the struct
itself.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index 7a8be3ad9b6a..ba14c0056b1c 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -7441,6 +7441,7 @@ static int resource_ctx_init(struct resource_ctx *ctx, struct dl *dl)
 static void resource_ctx_fini(struct resource_ctx *ctx)
 {
 	resources_free(ctx->resources);
+	free(ctx->resources);
 }
 
 struct dpipe_ctx {
-- 
2.44.0


