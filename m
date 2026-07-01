Return-Path: <linux-rdma+bounces-22619-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xeCZIYbERGpa0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22619-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:40:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2006EAC37
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:40:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lxs9vzN0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22619-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22619-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2C0C312CB80
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1233BBFD0;
	Wed,  1 Jul 2026 07:35:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010039.outbound.protection.outlook.com [40.93.198.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3C3AE701;
	Wed,  1 Jul 2026 07:35:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891329; cv=fail; b=QMhTQOt+9BBn1kI2z7auPGJFVc1UHqMUqyFYybzT8+IGLYMBV5yzSLj6N5/4RIVccr6IXrp1kCifOi+487gJ/1/Dd/z9Iwiw500MplosOatv5DmZuasgPTIi+crL2gDWKEVdfWpEFY1ZSHlej5v2RNPGD1d+jU/s7iuOnUF4CH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891329; c=relaxed/simple;
	bh=dD/H6SaiAKtuCCrLqCIU3gdH8S/TlkokSPN6w/6hJ+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQWUtAn3XlR7f9Fkcxb8NBajQARmQ5yx+XRJtS9Vrv6kHdnlPc2DQ7Npea2KBPemUl51O4+VKFmz5NE/m8eyLEF0CbiTb5ay2rULYCJ+8U03+WFUWAZAptLW56bws4zOOpFRZE3F7AB2rlyzUM5vqMrSovs0zUXvZo4JbXqVLxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lxs9vzN0; arc=fail smtp.client-ip=40.93.198.39
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De0aexhDGnYK5AiwC1TmmlG+sXSK9/DzLRQR1MWmhel9WCms8BoxMl7USujvuF4pqXBxE+3WKFA9J5l0cqTUFmf/3DSat0taA0fBLRjwbTTjycHQyBUjS8G5eeE10y5eX7/dz3J2jI5sK4csWJNC+7PJw+0EtWghuUTD22DzLyqPWluJE1HDY5UzAqxQayd0tgB6VPcgzt1tPVdlALY0hopn2ST+OA0T7PlZVrjiPSQHQB8dhsZd/FZHxPLe5E4ldcz8hLC7SLKb3zrghBz7ZKvd1yYYLvEMr50q1ocGM58M+wzTxZfy6p2LYdoOWpKHPkj0dN0PbPAW0YqWhKWviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A81cpU63WD/ncPW3tdY4/+F8Sb32G/Ul2zH6i8azMqM=;
 b=S+wLx9+C7II4XdQYzivjY+PbzU2BZYTR3JN/PjZAE8XrNT6p2VGjc0adh769BU4FVQaxRoviPCKfjdOlVA8MXy8hzM16eFtcDqFvOaVLYdtQLj4OY6/rWu5AVNNJEZZaTrdp7efIwCJLxhGI10R7URcOa0ik7bYyCfM2pL+Y0fFeQiRQL7RpVk09r8dkq9SLdn3T72wcxpLxWGZs5Jhe1y3EeNhYUaGSvb9Yxmkb1QT22knxjLyeG0EmnhUSRqRNwu0b8ikFk49hQR0QrJ7muquv8qhgsCv4mBQUBGE60ueTEXRVr3X9HNBI9feJJHgkJHLCU15BPhUT3JCoiAW3Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A81cpU63WD/ncPW3tdY4/+F8Sb32G/Ul2zH6i8azMqM=;
 b=lxs9vzN0o2kgZHKtqFU4rDQhCZAIs7iqDlQgCU9hzIBicjg6GKHnVPJNT5tMapbfLlQtVgjKoY2OIcDPhVmjgNVVEMoPYYLSyxccD3/UfQE7tMAXuun29HKdjUdlaTA2knL/qKzxPIDf7OFlONPNs/CVylKDyVyaYXYcRcTHHhvdExQFwJPe+rt5kmrVaoLkvKEZM/h6MDLByVjnAmRT5hqupcAzr7suRVGa2xS7Kh9AzyfzbmmToI/gAnyveNncR/hTvjFE7HWODtGxEKtwQLRytlYNRnfxQW2lNVm2kIyVYMnTqNivPlskvYnN/6PyL8rNo9Tc+K15c/sQQJyVaw==
Received: from SJ0PR03CA0173.namprd03.prod.outlook.com (2603:10b6:a03:338::28)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 07:35:20 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a03:338:cafe::99) by SJ0PR03CA0173.outlook.office365.com
 (2603:10b6:a03:338::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 07:35:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:34:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:34:25 -0700
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
Subject: [PATCH net-next V10 07/14] devlink: Allow rate node parents from other devlinks
Date: Wed, 1 Jul 2026 10:32:47 +0300
Message-ID: <20260701073254.754518-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SJ1PR12MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: cfcede0e-31e9-43f3-aeaf-08ded7434de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|1800799024|36860700016|18002099003|22082099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	toPG/egf12x+vZa6Dh3OGvM4tUJ4Ip6hh7zCYxYLLwKc1H+IbpHabIzUBz4IOFwpSooUjwQUTfAJFDebn9Enh3tm1X2SE7rR8+8mOTSf2HvXC8pMJ9NfD5+XDjQAncNp90pmbRexEWDCYmqnFR6KY4FN3I16Kc/AO6cicnbW/Xm5E5LtVMysjS6rNYcTYzGzjoXio3lc59QJGxDjkS1Iu2G0StHxllWdTaRMnc/y1+n8pSmTJdHY4HruzIJlvgARMIOWu1Eg+JibHK/wqjTofEXfDxw7Ma+Upd1v5sfyk44g+XTJ848BeHBh7/h6hMyivq1l3GMI8TGmrs+/jOKnuVfGxTndMvs+G6vpFa44Hi/eG7GFO3rHHiGINgdNsl2OeRo9ojxFnjXhvmVB1KJ2L6vS2esOIyVuThJuXt6OOtzDtpxmHl2cQUcdFSujrUSi2HWsKbsg2q+G+daMDuctMAbtLunBIzCi5DTN+TGRtqmhdJiVE5QazYlnPT5PA94Bpces2JakQOXfOAYhD/TRd1vDFHSoBhLJ7nY0nsW8uX6xsYh5kFq+SH/urdxHkQfPsv4O01oisO2ceqBD1Bj+DQ9XDQ25oWNwzVYuR9L+G5ee/r/9U4Ykdc4El4vijADUWyJRah6KjMAjBpylrakVCLFLyZaopyyqF+n3HEtsCaDS7F7ILdaPydu789mejFFd6GzDby8bq1oFxcN7R1WavA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4FZB6LCIL59F5uJrT/cTU+vfBtZyTaglvIOj9HFSnYbg0SKc7ulQipPX6iy5WQJAN7ymKFnudp2ahVwUl2ZP1pOcI7CThtb7hHZBsPaUr3FykkuSktu5IMVUbjtCxA8ryOoJSI0w73WLRcJ7xN7N658+5n9oRe5Y5EEVb41DvOzHbqhrabtpwAVMvZCv0eP7e0s1NNcI9tkHdCcT9Jl8/vz5LC66xkqMTGyyspy3sLiwWEGfQVYu6xjXIpOe1IGMCCEMV8rL7am8HWuPOHv82YYCmaFdlODE9pV4V6lLuZD8rdriJBtx/seyR9s0otx8bf1iAge06UdjWRMSheNGCYntCFP8K1I5SBIiK9DZoq9ga2N+eGfVDa4TMMVSaoVWY5t2ULz12jUlX0WOyBjFRZYzas0bKUbR8Vj8LvIexQ9I1leIBH7C3KLKCqiaVR5R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:35:17.1383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfcede0e-31e9-43f3-aeaf-08ded7434de4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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
	TAGGED_FROM(0.00)[bounces-22619-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB2006EAC37

From: Cosmin Ratiu <cratiu@nvidia.com>

This commit makes use of the building blocks previously added to
implement cross-device rate nodes.

A new 'supported_cross_device_rate_nodes' bool is added to devlink_ops
which lets drivers advertise support for cross-device rate objects.
If enabled and if there is a common shared devlink instance, then:
- all rate objects will be stored in the top-most common nested instance
  and
- rate objects can have parents from other devices sharing the same
  common instance.

Storing rates in the common shared ancestor is safe, because it is
reference counted by its nested devlink instances, so it's guaranteed to
outlive them. Furthermore, the shared devlink infra guarantees a given
nested devlink hierarchy is managed by the same driver.

The parent devlink from info->ctx is not locked, so none of its mutable
fields can be used. But parent setting only requires comparing devlink
pointer comparisons. Additionally, since the shared devlink is locked,
other rate operations cannot concurrently happen.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       |  2 +
 include/net/devlink.h                         |  9 ++
 net/devlink/core.c                            |  4 +-
 net/devlink/rate.c                            | 86 +++++++++++++++++--
 4 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9374ebe70f48..18aca77006d5 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -420,6 +420,8 @@ API allows to configure following rate object's parameters:
   Parent node name. Parent node rate limits are considered as additional limits
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
+  If the device supports cross-function scheduling, the parent can be from a
+  different function of the same underlying device.
 
 ``tc_bw``
   Allow users to set the bandwidth allocation per traffic class on rate
diff --git a/include/net/devlink.h b/include/net/devlink.h
index dd546dbd57cf..ffe1ad5fb70b 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1594,6 +1594,15 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+	/* Indicates if cross-device rate nodes are supported.
+	 * This also requires a shared common ancestor object all devices that
+	 * could share rate nodes are nested in.
+	 * If enabled, rate operations may be called on an instance with only
+	 * the common ancestor lock held and *without that instance lock held*.
+	 * It is the driver's responsibility to ensure proper serialization
+	 * with other operations.
+	 */
+	bool supported_cross_device_rate_nodes;
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
diff --git a/net/devlink/core.c b/net/devlink/core.c
index ee26c50b4118..c53a42e17a58 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -534,6 +534,9 @@ void devlink_free(struct devlink *devlink)
 {
 	ASSERT_DEVLINK_NOT_REGISTERED(devlink);
 
+	devl_lock(devlink);
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
+	devl_unlock(devlink);
 	devlink_rel_put(devlink);
 
 	WARN_ON(!list_empty(&devlink->trap_policer_list));
@@ -544,7 +547,6 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 78a59d79c2ea..e727c8b8b33e 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,14 +30,42 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+/* Repeatedly walks the nested devlink chain while cross device rate nodes are
+ * supported and finds the topmost instance where rates should be stored.
+ * That instance is locked, referenced and returned.
+ * When cross device rate nodes aren't supported the original devlink instance
+ * is returned.
+ */
 static struct devlink *devl_rate_lock(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink, *parent;
+
+	devl_assert_locked(devlink);
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		parent = devlink_nested_in_get_lock(rate_devlink);
+		if (!parent)
+			break;
+		if (rate_devlink != devlink) {
+			/* Unlock intermediate instances. */
+			devl_unlock(rate_devlink);
+			devlink_put(rate_devlink);
+		}
+		rate_devlink = parent;
+	}
+	return rate_devlink;
 }
 
+/* Unlocks and puts 'rate devlink' if different than 'devlink'. */
 static void devl_rate_unlock(struct devlink *devlink,
 			     struct devlink *rate_devlink)
 {
+	if (devlink == rate_devlink)
+		return;
+
+	devl_unlock(rate_devlink);
+	devlink_put(rate_devlink);
 }
 
 static struct devlink_rate *
@@ -121,6 +149,25 @@ static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
 	return -EMSGSIZE;
 }
 
+static int devlink_nl_rate_parent_fill(struct sk_buff *msg,
+				       struct devlink_rate *devlink_rate)
+{
+	struct devlink_rate *parent = devlink_rate->parent;
+	struct devlink *devlink = parent->devlink;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
+			   parent->name))
+		return -EMSGSIZE;
+
+	if (devlink != devlink_rate->devlink &&
+	    devlink_nl_put_nested_handle(msg,
+					 devlink_net(devlink_rate->devlink),
+					 devlink, DEVLINK_ATTR_PARENT_DEV))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -165,10 +212,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
-			goto nla_put_failure;
+	if (devlink_rate->parent &&
+	    devlink_nl_rate_parent_fill(msg, devlink_rate))
+		goto nla_put_failure;
 
 	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
 		goto nla_put_failure;
@@ -322,13 +368,14 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 				struct genl_info *info,
 				struct nlattr *nla_parent)
 {
-	struct devlink *devlink = devlink_rate->devlink;
+	struct devlink *devlink = devlink_rate->devlink, *parent_devlink;
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = devlink_nl_ctx(info)->parent_devlink ? : devlink;
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -346,7 +393,13 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(rate_devlink, devlink,
+		/* parent_devlink (when different than devlink) isn't locked,
+		 * but the rate node devlink instance is, so nobody from the
+		 * same group of devices sharing rates could change the used
+		 * fields or unregister the parent.
+		 */
+		parent = devlink_rate_node_get_by_name(rate_devlink,
+						       parent_devlink,
 						       parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
@@ -633,9 +686,11 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 
 int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *rate_devlink, *devlink = devlink_nl_ctx(info)->devlink;
+	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
+	struct devlink *devlink = ctx->devlink;
 	struct devlink_rate *devlink_rate;
 	const struct devlink_ops *ops;
+	struct devlink *rate_devlink;
 	int err;
 
 	rate_devlink = devl_rate_lock(devlink);
@@ -652,6 +707,14 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (ctx->parent_devlink && ctx->parent_devlink != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	err = devlink_nl_rate_set(devlink_rate, rate_devlink, ops, info);
 
 	if (!err)
@@ -679,6 +742,13 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	if (ctx->parent_devlink && ctx->parent_devlink != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		return -EOPNOTSUPP;
+	}
+
 	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(rate_devlink, devlink,
 						     info->attrs);
-- 
2.44.0


