Return-Path: <linux-rdma+bounces-22001-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yetBNFioJ2oV0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-22001-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:44:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F8165C883
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 07:44:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="pVN6WPG/";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22001-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22001-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 943CD3055E9F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 05:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD04E3C76A3;
	Tue,  9 Jun 2026 05:41:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524342E739C;
	Tue,  9 Jun 2026 05:41:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983674; cv=fail; b=Tue3/ryu8zdw+lgc4dFvlYHhvcRpVVjgYUi5i3rDqs7Z/KUvKwtc3c40/lVMF/j9sHtb+7XUus5A7yqJDaFoCaFgH5GFvtU+aH9XnS+7sCeociH3Aw9dfwkf/JiJMpDf0S92Jv7vMd8+ULfPGKArh/k/O+5QSUx0wHnPD+E4M94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983674; c=relaxed/simple;
	bh=5sFb+NogwD5NUn8VCKWkzFqIsdeXvef0C8Aa8uhDItE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgpT374y3YSQTfBrrRixFEqAs+SQZnMKF5yyXHUjVMq2HNSFb8rFk6C+Fxs+pF3i5F3HM30RM25C4BaIhepB2dxs9An6kP/vqZAaT5EhG1hAYpXI9YVMLFXqmEQbZam2/WoalVMSRM35J8eToYahfSXQQvtkbxBbdVzWjnyQyYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pVN6WPG/; arc=fail smtp.client-ip=52.101.48.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjcoh6KnxXz9i1EtgsRiz+AV52JffB9ao+9RjYMetmhXDSxSTOSxPUSIrzK3l+lQbKI17dbFyTUDBs0TKfhQ5q9Qg0vSQoXKNbO1/8UXm5nju+qsC1h7VMZBz9UHg0V4VZc5ooWRDvfG6whtgYitCy9/kYuSOOFnlj/VzZQoDMig7Z4XundEbZXS8ybfjB8xkLtdvjtnHq8LfRt9rLyiZ/1SVK2boxGI/GnTtTG5sf+Ckgw7rDwlsONUvNGDsa7NslyKm1uuMuQz2MzPp325tWggoRMB2XeTepQjUdd4uWXaOo5jZXy+yktpVJPsLdkMGxOVBvdFV1eP6UhJARa2WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe++pcGT5rme0Fn0PJ2don/rBYF1VvcD9YyeXF8pLN8=;
 b=Do7AeHjANZ8pT1iRbMW9Dy7h00eYYW0wry0/1XJ4IbdnbHfi2Z7vhMOkyXOrCjxu61ga6jz8t8zDwmUqDLLMNHBzbu0N0/5DbgZ+aXgRgIoigbMYw7i8O3s8axUlco6QLJZWqH0an5bVrzdHBAtz1yTI2L22NuhWzWf8St8z19dQc2TGsLkqn+WFvdnBSSloEGkGRSp0uviRaMm/gKdePt1bCY0plyIjqUyunEeFrCc8KnYDxR+rBIpnChMqsjXoL70hyr9fJYYSuljOJsShQP3pzTrzs6CeGcL4cfL4Sa0O3PSR6Bv3q8jBm0Hh7RhXVn75qB6p5Ft1M4h+M2Xqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe++pcGT5rme0Fn0PJ2don/rBYF1VvcD9YyeXF8pLN8=;
 b=pVN6WPG/zz8dUnczaJ1FZjIlrd/uXgOIeT8A5fK7cGZDQPQiBV7Fdo2wnOGjqrpqhtxQbmhvpJ5kgB2e/bSo7PGdMyoD83sH9tyW8A/w8F/nLJTvbZuC0Fe8S3v4j4MEezlWwpgEwWRIF/q+Q2xVA4lvqfQnUPjingOQZybR2kCokLndrVmQvKbVwTrwt7ZbUdwso4/Mq+/xpvngqpgDDbI/nu7BhtKHjQ0H5CCzy3vVATrWTeFtjHDj7CQwyuHqgpqxGvXTpqJCGJkCu7EUd9rlBVW8TSSv8uALJ+ss95KaBAl9f4IAxOzfg2yiWHhyf3f8AGkiJBFbo5yt5kjvNg==
Received: from PH8PR05CA0012.namprd05.prod.outlook.com (2603:10b6:510:2cc::11)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 05:41:07 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::89) by PH8PR05CA0012.outlook.office365.com
 (2603:10b6:510:2cc::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 05:41:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 05:41:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 22:40:51 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 8 Jun 2026 22:40:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Jun 2026 22:40:42 -0700
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
Subject: [PATCH iproute2-next 2/7] devlink: Move dpipe tables query to resources show callback
Date: Tue, 9 Jun 2026 08:39:48 +0300
Message-ID: <20260609053953.487152-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f30abc1-80ee-4805-ea20-08dec5e9b3c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|5023799004|11063799006|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9Lak/3zNlMcJQ98bnDqOw6Y/OvAJrG58nahkcgXAhzy2EZQyFWDBUu+Ga31aFKGOW54K/IEkhUFuO8plvbSm+X01t6nmVjuSrQfdWsDeztUw4+ZeGEqnFFZBBSTD1aZDvFKN//t/vPzL0jzO7g0sFAXh+l1Y8+y+H8ainUvF0lgxa3VKGVAjkIjAmKT2TqjSZSdWXddZOYt4d/NzPa0s8Q9TVNY7/EF4prmNrnFRS01yq2phdkbN1moqs/VZ2HAezC4zpGKfwW4o02hqASmot4plvPpHf9XU4tb4j1KcgwQgoLrubcmRFkuYxG01mqw72a6P+Wim9b1UPuN1gMs6Zjo6/BOhqWQQdwU9UJKWUjP7dMDKhunX//Td4+O9jVMkndIWHvknna6TyGjo0kfgcoNSGVdDnyfWLaSEnDQZnzHtdSAlsuCaIhsB7NY1WHVkXJfCQFCYcpwX6AR7wNW/kWfgLYQqQFdcvJNCAr9PcR9u3YX+oR0CI5jXVQSHYWb95Xf6ErL7KRwMS/dS+CF2WRNxu0LMvCziqlJI3wM33oS4RESH5FasROVDk4fVI6bW7uabUri0vbmwiutcbY+JNQmDOGBWYva0ej8m5GhiBypuA1tqK3NQPGzjqhJTMSFf2AyeLUulp9iNUA5oxD7JglJQ9HTRGi8t1KST1woE6RfmfCQyX5e+lHaaxIifg+HFueyCfQxFkoKgEJZ1IMc8auBq//AFEI4SM+BZzBeDXdU=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(5023799004)(11063799006)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aC1Mtgs65w0guEYo1/T+wjRmqUJDGid7XBZ9K+Hs+C0iP5qiw27s5A4aiiL/OoNxtZ+0KLeDcffrjQAefyGNCUqvWgjiY8mmotjDg2d+PHHv3Vf9lA5yXKRSXc/o2ChGzpFCE3DrHT0Z6f6J5bKB4SRZJJ9RNqaKA0rk6u3XltC2FLL+o9ssHvEoOHU0FwMBCRC/Ew/Y7fFmpukBk3zPOjKaslFxW/9nteJZFk4MIN0x4s0okHbK6SZIUmJZI8+RAK8XNtNyrdPddAWpJewv7WDASBcIBBr2TQ+KLyI3G4mot2vPHgOCxTOEXO80WQpRblnlWwm4Gm+UMeAea+DRwdc7mk719++8Bmo+nKXgtlyk3Unn6/OKV/H1pq7pvAvH8PchHdzxEMh22OCd4ILLtsxj/NiaPrJ3AtK/f1l23k7S4TD7rQQ9aqt2RL5IOmaj
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 05:41:06.5921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f30abc1-80ee-4805-ea20-08dec5e9b3c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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
	TAGGED_FROM(0.00)[bounces-22001-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32F8165C883

From: Ido Schimmel <idosch@nvidia.com>

As previously explained, as part of showing device resources, devlink
queries the device's dpipe tables so that it will be able to show the
association between resources and dpipe tables.

Currently, the dpipe tables are queried before the device resources.
This will become a problem when devlink is extended to support dumping
the resources of all available devices.

Therefore, in preparation for resource dump support, move the querying
of the device's dpipe tables to the resources show callback which is
invoked per-device.

There is no difference in the output of the resource show command, but
one functional difference is that errors in dpipe tables query are not
considered fatal. This seems reasonable given that errors are unlikely
and that displaying the dpipe tables is secondary to showing the device
resources.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 devlink/devlink.c | 82 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 62 insertions(+), 20 deletions(-)

diff --git a/devlink/devlink.c b/devlink/devlink.c
index d998520cfd88..7a8be3ad9b6a 100644
--- a/devlink/devlink.c
+++ b/devlink/devlink.c
@@ -8818,6 +8818,9 @@ static void resource_dpipe_tables_show(const struct resource *resource,
 	struct dl *dl = ctx->dl;
 	bool array = false;
 
+	if (!ctx->tables)
+		return;
+
 	list_for_each_entry(table, &ctx->tables->table_list, list)
 		if (table->resource_id == resource->id &&
 		    table->resource_valid)
@@ -8888,17 +8891,75 @@ static void resource_show(struct resource *resource,
 	pr_out_array_end(dl);
 }
 
+static void resources_dpipe_tables_init(struct dpipe_ctx *dpipe_ctx,
+					struct resource_ctx *resource_ctx,
+					struct nlattr **tb)
+{
+	const char *bus_name = mnl_attr_get_str(tb[DEVLINK_ATTR_BUS_NAME]);
+	const char *dev_name = mnl_attr_get_str(tb[DEVLINK_ATTR_DEV_NAME]);
+	struct mnlu_gen_socket nlg_dpipe;
+	struct dl *dl = resource_ctx->dl;
+	struct nlmsghdr *nlh;
+	int err;
+
+	err = dpipe_ctx_init(dpipe_ctx, dl);
+	if (err)
+		return;
+
+	err = mnlu_gen_socket_open(&nlg_dpipe, DEVLINK_GENL_NAME,
+				   DEVLINK_GENL_VERSION);
+	if (err)
+		goto ctx_fini;
+
+	nlh = mnlu_gen_socket_cmd_prepare(&nlg_dpipe,
+					  DEVLINK_CMD_DPIPE_TABLE_GET,
+					  NLM_F_REQUEST);
+
+	mnl_attr_put_strz(nlh, DEVLINK_ATTR_BUS_NAME, bus_name);
+	mnl_attr_put_strz(nlh, DEVLINK_ATTR_DEV_NAME, dev_name);
+
+	err = mnlu_gen_socket_sndrcv(&nlg_dpipe, nlh, cmd_dpipe_table_show_cb,
+				     dpipe_ctx);
+	if (err)
+		goto socket_close;
+
+	resource_ctx->tables = dpipe_ctx->tables;
+	mnlu_gen_socket_close(&nlg_dpipe);
+
+	return;
+
+socket_close:
+	mnlu_gen_socket_close(&nlg_dpipe);
+ctx_fini:
+	dpipe_ctx_fini(dpipe_ctx);
+}
+
+static void resources_dpipe_tables_fini(struct dpipe_ctx *dpipe_ctx,
+					struct resource_ctx *resource_ctx)
+{
+	if (!resource_ctx->tables)
+		return;
+
+	resource_ctx->tables = NULL;
+	dpipe_ctx_fini(dpipe_ctx);
+}
+
 static void
 resources_show(struct resource_ctx *ctx, struct nlattr **tb)
 {
 	struct resources *resources = ctx->resources;
+	struct dpipe_ctx dpipe_ctx = {};
 	struct resource *resource;
 
+	resources_dpipe_tables_init(&dpipe_ctx, ctx, tb);
+
 	list_for_each_entry(resource, &resources->resource_list, list) {
 		pr_out_handle_start_arr(ctx->dl, tb);
 		resource_show(resource, ctx);
 		pr_out_handle_end(ctx->dl);
 	}
+
+	resources_dpipe_tables_fini(&dpipe_ctx, ctx);
 }
 
 static int resources_get(struct resource_ctx *ctx, struct nlattr **tb)
@@ -8933,7 +8994,6 @@ static int cmd_resource_dump_cb(const struct nlmsghdr *nlh, void *data)
 static int cmd_resource_show(struct dl *dl)
 {
 	struct nlmsghdr *nlh;
-	struct dpipe_ctx dpipe_ctx = {};
 	struct resource_ctx resource_ctx = {};
 	int err;
 
@@ -8941,27 +9001,11 @@ static int cmd_resource_show(struct dl *dl)
 	if (err)
 		return err;
 
-	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_DPIPE_TABLE_GET,
-			       NLM_F_REQUEST);
-	dl_opts_put(nlh, dl);
-
-	err = dpipe_ctx_init(&dpipe_ctx, dl);
-	if (err)
-		return err;
-
-	err = mnlu_gen_socket_sndrcv(&dl->nlg, nlh, cmd_dpipe_table_show_cb,
-				  &dpipe_ctx);
-	if (err) {
-		pr_err("error get tables %s\n", strerror(dpipe_ctx.err));
-		goto out;
-	}
-
 	err = resource_ctx_init(&resource_ctx, dl);
 	if (err)
-		goto out;
+		return err;
 
 	resource_ctx.print_resources = true;
-	resource_ctx.tables = dpipe_ctx.tables;
 	nlh = mnlu_gen_socket_cmd_prepare(&dl->nlg, DEVLINK_CMD_RESOURCE_DUMP,
 			       NLM_F_REQUEST | NLM_F_ACK);
 	dl_opts_put(nlh, dl);
@@ -8970,8 +9014,6 @@ static int cmd_resource_show(struct dl *dl)
 				  &resource_ctx);
 	pr_out_section_end(dl);
 	resource_ctx_fini(&resource_ctx);
-out:
-	dpipe_ctx_fini(&dpipe_ctx);
 	return err;
 }
 
-- 
2.44.0


