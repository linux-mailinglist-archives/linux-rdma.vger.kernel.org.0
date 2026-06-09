Return-Path: <linux-rdma+bounces-22000-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A9nLON6nJ2r/0AIAu9opvQ
	(envelope-from <linux-rdma+bounces-22000-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:42:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9A965C83C
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="f/5BZ2mu";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22000-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22000-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7330303F7D5
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D872D3C4B82;
	Tue,  9 Jun 2026 05:41:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F832E739C;
	Tue,  9 Jun 2026 05:41:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983666; cv=fail; b=K1dt+lVuwl0TSsszBYj5mzAVjTQvT2lIVT2bLMxE++mwIV6z9yP4kLzBIY45dLizZD7mKPPcea47nisGRuYeGPbR2VH86XwLa28sVG5vCnPJCmiL3UOWNDA0dqw9YSVj3TcCKGmRblf7oZyKxLkfpwWwg8R7m62uDQTFAeUrgOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983666; c=relaxed/simple;
	bh=m5C4uX33K67sb2lOdgxnT+AIa5prbEnYWIWlYVCK3/0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kB+Rv1mHUQBCOgXOxDr2Rdpe2FW7zxDXEKyjfNax3nPKqPTw2XykzugcV7+sEkKPkzAwxENWLaGY3lDf4y+WX/OPLcaLPwuoaGiUurruP51hArIBLPf1xz2zfXZoAeXHOVXvFidA7LLSU4B5qfXq+QzncYTjNd5MW0OZMTuiUFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f/5BZ2mu; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBOBdjpcbYylRHLZl8EOnVlrJJ34DHOcLNwKTode5KZcp5ytfz2nW1l9TXq76gonXoISjDZu8dGDR/4UAZc5Oc1PnjfcBZm8A9TaZva3G+vl4pp8e1CuufrD3Cb2zPCryosSLwWeXL9J6+K06+G10LEwhTAfPY43ldeCvDBJD4TfzxqMJHPSquggsrMNa89eTl0BpM559ppQiuX7FV1jhQgjkjg2/bznYFQgaifroLCzgYp0u0c5tdEUYKZaRPNm2huBDaB5Fw136URQIqE18PgZ/z+KcK0zKvWaKFsvvVrselrwz7ApWpt+Feb0v+7h53lKVPrfliB5CM8/C7MntA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUXAe5DvsoQRmttYf4DlrmWYUVLJjMXsRtB0ErCBLgY=;
 b=b15DhqgEv/4G4/btkHF7LdWRVT9tovR4R38Jx7z1PC/ESDfyNVc4qkKDijYJoQ5HHqGv2FGfrJvu/X6U7RZXpWdfbrU1GnS4e3UehhjRwQXTgmfDkzMsiARpSAcQMk7ULREIJ+jjcSalclm1NzxYOlpHdSSvaVtsxL1euyQG1rH683EgBg7UgydBaY7S+Oi03a2sBGQra+yIaX/9ktX+B6W+FXxzNbs5E4SapCOckO+ShEb+f1ndo2hWNZYqbMaFwyj5dAKTO8BJm8qha8/t3JA5H7TRUeymsz4wbXR2gcoNwCdN+h/tjRwR4LC2PKlt2xquky2Wned22tPGA6yzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUXAe5DvsoQRmttYf4DlrmWYUVLJjMXsRtB0ErCBLgY=;
 b=f/5BZ2muE+XOD1FN7kBGEoGp8/rC+As3kkHXNjVGM2B3elrI1iayXmmmAh7+LW+oZnxcL+BWeb9BXjMK93oM0ZyYr5ZscJ7ixpyagtKp7rJPiU/NpsBA3PyVtD7SbF3+lVVJprA2n27nC5jsbWYcWJJrRyuy10CllRrisk6tCOVwiVikKCVRLEyknkwtxUwwhdDKMjKdZUDEy2qyXsV3Aku7GzGr8tnxcJhENvptmr63zBjoQ5yF5UagRUUoZ2j0FcPqNJpT6b+6hFKnNVSmtG7BakKzKtL67ns91EnC0Es2POZTGc1LJjenxg7mof2BTG7rfA2jJH0qnuHIranNBg==
Received: from PH0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::11)
 by SJ2PR12MB9240.namprd12.prod.outlook.com (2603:10b6:a03:563::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:40:58 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:510:d3:cafe::a1) by PH0P220CA0013.outlook.office365.com
 (2603:10b6:510:d3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.11 via Frontend Transport; Tue, 9
 Jun 2026 05:40:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:40:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:40:42 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:40:42 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:40:33 -0700
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
Subject: [PATCH iproute2-next 1/7] devlink: Split dpipe tables output to a separate function
Date: Tue, 9 Jun 2026 08:39:47 +0300
Message-ID: <20260609053953.487152-2-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SJ2PR12MB9240:EE_
X-MS-Office365-Filtering-Correlation-Id: 450c716b-1ec1-4f05-2409-08dec5e9ae70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Vn87A0Nhao0352J28fgySVbv4E3IHIQ/cOZK6AcolD9KmCssxOE/va9Zw75PtAlGNV+2pkt9XGthtE2skwoSaGb63Vx/tAui+KGc3lPDC0vNXaYvN9SvhJ9PzxXhM/QbjyzWmepQH8LIDlFkTZQEj1ki+ifqimc7WIzrblkaKi9sFvWzUD3dSpR5LThcZnnjQf3/goOnd2XqZgJBvZ0HkAQcpGbDur8GGha7oRmYppd7u/SrdK7E8vnRMG7dXD4bTiHnPh2qy1O3H1NKl01uhINkjSygTRn4ZiPro00uAPxOAk75eHLgfOEX3IwmMFveRaPjuUVXLDVfrl2faYVsefZWSfCuR4XSFGwfb3mZuX2oLjnki6kWyhrDgxFE2RZaHVvo55oS8OLMBX7UB9qC/mIPDLfvfGUp/+oDFaAsC3knzIaVCyIRNE5291qerM4rHIqSrPPv0165+3O2pTuZo6DLMiGbnvWiy9EhLKWthRGEn+UAxzHkgZpdBSBLeXCh7GumkEUHaVgfc9xBukNY5b//iw7z0M0qeqghquKdtn/yhJlYRnQTu+QFhT5ZaeTzGtsGqWMBZ37GarmNkV5N91ZpPs8KGizH9q9c06XxSPwIlOTv/2KqpxzBCz3VMGX0nhkjpA6JjXrQw5+jg5DYZ5S3nihwuoaAe/MQZdqlFck6Q9sDNt59vnBiYO0EsvV2Q5nCmX2PUlwo0bCllBsKRlLFMfhTozX93aY5lmRk/nA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jS+il0hwlNru/QbjOtJkA32gz9J21bj1MYzFK0zT4gtXxmkgvEPuBDQXGUQKM6ZvBEOSd662RNp2T1JggbuT8szCGARn3ba4vfDuVNEx0gp0YlB6e0ma+mCnwydCOk0KxH5ax/I/AZU1J+gyl9tCtOk8qwoi4REhuyQCM2++alZE+w4GOhdGdL0QFWgwwl4IankZiERY2nbLxY2lYhMxzGMzMY1SPThszXiB2gtz/mCXUR5VU9BjH6gLEJIxH9n8GIGKaLaVmdVAY1UTzuJc06xXeQVfBHRaXd6ampyBkdbgmJFds5ZfyJQHbk32IHpHF9pXorH0qdheCQmriDVpwTG9peho2ARqKIe92Jg9gDUfFLf3+nk7pv/u9FbvC54O3FvRR5zgCI8pImqp8/WsY1QqmEeFzgRKQthuEfLdcq/6rMXu4WESswqiTVSCR7cU
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:40:57.6468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450c716b-1ec1-4f05-2409-08dec5e9ae70
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9240
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:ohartoov@nvidia.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.
 com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22000-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B9A965C83C

From: Ido Schimmel <idosch@nvidia.com>

As part of showing device resources, devlink also iterates over
available dpipe tables and shows the associated tables, if any.

A subsequent patch will show the device resources even if we failed to
retrieve the dpipe tables. In preparation for this change, split the
functionality of showing the associated dpipe tables into a separate
function.

No functional changes intended.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c | 54 +++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index b4deba30c538..d998520cfd88 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -8811,34 +8811,13 @@ static const char *resource_unit_str_get(enum devlink_resource_unit unit)
 	}
 }
 
-static void resource_show(struct resource *resource,
-			  struct resource_ctx *ctx)
+static void resource_dpipe_tables_show(const struct resource *resource,
+				       const struct resource_ctx *ctx)
 {
-	struct resource *child_resource;
 	struct dpipe_table *table;
 	struct dl *dl = ctx->dl;
 	bool array = false;
 
-	check_indent_newline(dl);
-	print_string(PRINT_ANY, "name", "name %s", resource->name);
-	if (dl->verbose)
-		resource_path_print(dl, ctx->resources, resource->id);
-	pr_out_u64(dl, "size", resource->size);
-	if (resource->size != resource->size_new)
-		pr_out_u64(dl, "size_new", resource->size_new);
-	if (resource->occ_valid)
-		print_uint(PRINT_ANY, "occ", " occ %u",  resource->size_occ);
-	print_string(PRINT_ANY, "unit", " unit %s",
-		     resource_unit_str_get(resource->unit));
-
-	if (resource->size_min != resource->size_max) {
-		print_uint(PRINT_ANY, "size_min", " size_min %u",
-			   resource->size_min);
-		pr_out_u64(dl, "size_max", resource->size_max);
-		print_uint(PRINT_ANY, "size_gran", " size_gran %u",
-			   resource->size_gran);
-	}
-
 	list_for_each_entry(table, &ctx->tables->table_list, list)
 		if (table->resource_id == resource->id &&
 		    table->resource_valid)
@@ -8862,6 +8841,35 @@ static void resource_show(struct resource *resource,
 	}
 	if (array)
 		pr_out_array_end(dl);
+}
+
+static void resource_show(struct resource *resource,
+			  struct resource_ctx *ctx)
+{
+	struct resource *child_resource;
+	struct dl *dl = ctx->dl;
+
+	check_indent_newline(dl);
+	print_string(PRINT_ANY, "name", "name %s", resource->name);
+	if (dl->verbose)
+		resource_path_print(dl, ctx->resources, resource->id);
+	pr_out_u64(dl, "size", resource->size);
+	if (resource->size != resource->size_new)
+		pr_out_u64(dl, "size_new", resource->size_new);
+	if (resource->occ_valid)
+		print_uint(PRINT_ANY, "occ", " occ %u",  resource->size_occ);
+	print_string(PRINT_ANY, "unit", " unit %s",
+		     resource_unit_str_get(resource->unit));
+
+	if (resource->size_min != resource->size_max) {
+		print_uint(PRINT_ANY, "size_min", " size_min %u",
+			   resource->size_min);
+		pr_out_u64(dl, "size_max", resource->size_max);
+		print_uint(PRINT_ANY, "size_gran", " size_gran %u",
+			   resource->size_gran);
+	}
+
+	resource_dpipe_tables_show(resource, ctx);
 
 	if (list_empty(&resource->resource_list))
 		return;
-- 
2.44.0


