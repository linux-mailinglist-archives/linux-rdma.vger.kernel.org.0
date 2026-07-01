Return-Path: <linux-rdma+bounces-22617-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lqBOEavDRGoN0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22617-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:37:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9536EAB6A
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:37:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IIVr6+Ty;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22617-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22617-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABC91303F712
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA43BBFDA;
	Wed,  1 Jul 2026 07:35:04 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010059.outbound.protection.outlook.com [52.101.85.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9511C3BB675;
	Wed,  1 Jul 2026 07:35:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891303; cv=fail; b=M3wjqsdlE9kQZVN4zsuae9MSwiZu5qoJvSkmBDvWTQeHFYKrkXQxPZwc431/s4w+uZJCSleaP0DI9A1+wFdiwVAeLG6GcoIEjzvKuoq9t0uV817wK+deSIMd5jQqyLJbS6MaYreAMF8+VZd5O9YkSgUZM1TKiUfHCSLrZoL0F0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891303; c=relaxed/simple;
	bh=hQ+zd6I8PbvCPq1jXhXreajPAvph/zRYHmsjdRBaqCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8hIsbQ6XGotvBzoHHyK6/ar/ThqZwEjEW/TPIE3akLbaFFgz6wibVL5wx1eW0lcytFGowvtvUVWRig5cfoghpk8/HFm0a3GzH5KMSxNY8t4zMexnK0keIRlULidFsxEBBgDY1wFWQDd8WPYyaDWW5QBPEIhSZfqy8Ezj9gJMTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIVr6+Ty; arc=fail smtp.client-ip=52.101.85.59
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtfUpVyJiiRyzRW1Kh85Xc/JRJ6+3YZHsGxev3MsBYIPC2y9zMVrJi3/vigtMLujIeTqNAKdtRX3PeibsS164ou5eyCaZmYegIfCAY3j4F0pL/a0vGxgerKkSivugAzaeHCtK5LZoVU9t22YVSbWMmFHI2w7Mtgi28xewFzWTqaGoOhZ3HX2mj4KG4pVEyXC+Ng7bPduYDdYmBTtkppYpELjWQtwrEq+r9KO0Q23CmntcpL0We2LtKGLqNGkjnXG+hsklF255iVh4tw3N94aXVYjG3R41A22nDDszYkF0t4rL2NYbcEz2CO8b3rAxq85707OYQWIMoT8/A/nra1IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YI2yBdlztjycd8tCoUPAqyJH6Xzb0es18HHF9vl7NqQ=;
 b=J3rgS1tvSx5+cfRq0WvvMJ+zgkT2wGh8SjY7XLYwVtpuVtdtXHFXb5wJzL00usMMGHHRe5x8v/uBGRbQkrtNAq9V6VWG+/mkvT/TeXhdLsr/wy8vvud9aC1KDlwyUTgeQVtBVhxF9FAUUVQ2gLYIo6ZTb2wlP0GByM061veuYS5W1o8A9ezSGHlURmuQhgN51TTyLM+sFje/QlpBA3ALNwdrKtvG4ooXKks+5dcIf+JYs5357BSuh3ssemLnA4sIXoteE6Bv1HAPrMxSne75Rq3donzzcvX/1uRa//kXObtlLA7rIaLeQgob8ARtoqBgBY0+llzt+5UcBaSEDQ+tgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YI2yBdlztjycd8tCoUPAqyJH6Xzb0es18HHF9vl7NqQ=;
 b=IIVr6+TyuhWYlZxmsUQXtwK1GrhW0uztZ35EdoqGW/LHtUMnV54vkhOuQ8wl5D/5kPtIKjr9vo8LfRAFzHSGw7Tdt2WSTUr8gX1f3G6AwNG03SHbQpD8yPRMKVWfgtA+rKPj215KZItCqRDsQEOXQAhCNEKh9MXPURlhujaF07/NOmEeHrg93UD6xXUkeRGiK+P0eeMvnmvjNhLoQhDtCROLrluTKNA4YHch3lATEntVg5c76pZm74GPGdHRLl/cG2cu6Ap4FC4HOPnLrkeRmJ3wBfVOEZ1oXR0SxSQA1WRY/qjday198u69/0lfoYfxAJgFJeVdm5SVINtQvOSVxQ==
Received: from BY5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:a03:1e0::32)
 by DS5PPFDBFC954F7.namprd12.prod.outlook.com (2603:10b6:f:fc00::664) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 07:34:45 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::89) by BY5PR03CA0022.outlook.office365.com
 (2603:10b6:a03:1e0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.18 via Frontend Transport; Wed, 1
 Jul 2026 07:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Wed, 1 Jul 2026 07:34:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:33:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:33:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:33:43 -0700
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
Subject: [PATCH net-next V10 03/14] devlink: Migrate from info->user_ptr to info->ctx
Date: Wed, 1 Jul 2026 10:32:43 +0300
Message-ID: <20260701073254.754518-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS5PPFDBFC954F7:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b27254e-1d4a-45d9-d54d-08ded7433884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|7416014|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iJl+XoJF4f9qsJHZN8CYsE1evotHP6XbF/X4kOYZNyoijDmt+f92XLt4Y1X9+NtQ42+1kFkzmzjuHywdsQP5rB5jnlLEw2JfHDqPSIN0vz/DFQsuUQVWzZ2ZdgWhuAFu1VwiDGjemg3STPCOmQ2VJjVCxxX4EuZF9vAxxNPM302kGSBd/gXhl84caOwbkbIMo18PXB+belzZF5NnUE8A2FY8vgtDFB6E5UIHB88gpW0lQmEpU4hAN/YJPy40bMR7HRHd2As1VYVQT7tUs5NmM8eq5IHdbdeD5KgmQi94I5ah4zF85bh6UnxnPiWrfzuXmx8niQztF1jqVVlzwWFONV0ol1z3JtL7Cj2weYbmwAA11u6ID3HWpLXm7cLnebLYE9TEzulGbVnmqa2JETtWl2W3pQDUHR8HfWMOKkNF0zpLRyYAH7o9EArkNdpPtMyQUPxkpBUsy/Q3701Q7t9pQjNuhwM4Hz6DnFlWKSDYOjGxhR9wBG9EedJJydjSN1d+zIZKLcyRKqBP7LIrU3qLCq05jcCY6EMgfU3TqKySaaghZ5GaLmamNsBZST42pXSFmBq2HUHCXLxzoCmvjf4h1LDN+nzS6ntDLdfDCfIZF8xq7lbKrfWAuGMJ9fjxD1Gjltd6WeaUTZ6ynfhm1+L7/dvm/mEqn1fSQ0VJxADRill9Mv0D/1Q2rBsRpP7lKtR4VvndWuwbRDqxBkvZxEQtNw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(7416014)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TL1hr/UiHhv/6fACimeS7saBdzrTphkx2FraH3WkL6HDjPuF02WpkN42HolVxyFd216vnbKejo6tKpCG5AWuw7h2udV3noywrpgNI2liHnjDiXzHYOuJ8cBw/oUaCMcqjKv3yzl4ZTCkGNHZnzQeZ6y5bd6j1LncuaTYaO+hOzihrxxMMo/p4JgFYihgbQQ40xnuy1ifujMfSIkAXgsoXMcbqOXkDECqlQdxCBJuft+YHtz0ftEz0tSCD8fpmWe/74NR1YHKTmh6wlfuDz2iwVJ7gbK/XhhDzvgv/39z4UtfVQhJ/FimCINFDXA4RApuqyY/s5FK36NwWjdvp/CT7KjxTGIRsLD6cygdmWXiX6Jpd7bp0ZN8gof5oF8IcBvwyQO6QEbmyf4wWFUllOdYFg0dynu9kGPD23UgFQ0nMiqPR4PH08YYF8Nzty+OrRRq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:34:43.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b27254e-1d4a-45d9-d54d-08ded7433884
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDBFC954F7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22617-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF9536EAB6A

From: Cosmin Ratiu <cratiu@nvidia.com>

Replace deprecated info->user_ptr[0]/[1] with a typed
devlink_nl_ctx struct stored in info->ctx. The struct aliases
the same union memory, so the migration is safe.

There are no functionality changes here.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/dev.c           | 16 ++++++++--------
 net/devlink/devl_internal.h | 13 +++++++++++++
 net/devlink/dpipe.c         | 14 +++++++-------
 net/devlink/health.c        | 12 ++++++------
 net/devlink/linecard.c      |  4 ++--
 net/devlink/netlink.c       |  8 ++++----
 net/devlink/param.c         |  4 ++--
 net/devlink/port.c          | 18 +++++++++---------
 net/devlink/rate.c          |  8 ++++----
 net/devlink/region.c        |  6 +++---
 net/devlink/resource.c      | 14 +++++++++-----
 net/devlink/sb.c            | 22 +++++++++++-----------
 net/devlink/trap.c          | 12 ++++++------
 13 files changed, 84 insertions(+), 67 deletions(-)

diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 57b2b8f03543..bcf001554e84 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -222,7 +222,7 @@ static void devlink_notify(struct devlink *devlink, enum devlink_command cmd)
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -519,7 +519,7 @@ devlink_nl_reload_actions_performed_snd(struct devlink *devlink, u32 actions_per
 
 int devlink_nl_reload_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	enum devlink_reload_action action;
 	enum devlink_reload_limit limit;
 	struct net *dest_net = NULL;
@@ -683,7 +683,7 @@ static int devlink_nl_eswitch_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -704,7 +704,7 @@ int devlink_nl_eswitch_get_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const struct devlink_ops *ops = devlink->ops;
 	enum devlink_eswitch_encap_mode encap_mode;
 	u8 inline_mode;
@@ -906,7 +906,7 @@ devlink_nl_info_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_info_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -1134,7 +1134,7 @@ int devlink_nl_flash_update_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *nla_overwrite_mask, *nla_file_name;
 	struct devlink_flash_update_params params = {};
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const char *file_name;
 	u32 supported_params;
 	int ret;
@@ -1302,7 +1302,7 @@ devlink_nl_selftests_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_selftests_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -1372,7 +1372,7 @@ static const struct nla_policy devlink_selftest_nl_policy[DEVLINK_ATTR_SELFTEST_
 int devlink_nl_selftests_run_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr *tb[DEVLINK_ATTR_SELFTEST_ID_MAX + 1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct nlattr *attrs, *selftests;
 	struct sk_buff *msg;
 	void *hdr;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 36dff282f9b0..52c8bf359dd4 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -151,6 +151,19 @@ int devlink_rel_devlink_handle_put(struct sk_buff *msg, struct devlink *devlink,
 				   bool *msg_updated);
 
 /* Netlink */
+struct devlink_nl_ctx {
+	struct devlink *devlink;
+	struct devlink_port *devlink_port;
+};
+
+static inline struct devlink_nl_ctx *
+devlink_nl_ctx(struct genl_info *info)
+{
+	BUILD_BUG_ON(sizeof(struct devlink_nl_ctx) >
+		     sizeof_field(struct genl_info, ctx));
+	return (struct devlink_nl_ctx *)info->ctx;
+}
+
 enum devlink_multicast_groups {
 	DEVLINK_MCGRP_CONFIG,
 };
diff --git a/net/devlink/dpipe.c b/net/devlink/dpipe.c
index c8d4a4374ae1..08c7b66fc3e8 100644
--- a/net/devlink/dpipe.c
+++ b/net/devlink/dpipe.c
@@ -213,7 +213,7 @@ static int devlink_dpipe_tables_fill(struct genl_info *info,
 				     struct list_head *dpipe_tables,
 				     const char *table_name)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_dpipe_table *table;
 	struct nlattr *tables_attr;
 	struct sk_buff *skb = NULL;
@@ -290,7 +290,7 @@ static int devlink_dpipe_tables_fill(struct genl_info *info,
 
 int devlink_nl_dpipe_table_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const char *table_name =  NULL;
 
 	if (info->attrs[DEVLINK_ATTR_DPIPE_TABLE_NAME])
@@ -478,7 +478,7 @@ int devlink_dpipe_entry_ctx_prepare(struct devlink_dpipe_dump_ctx *dump_ctx)
 	if (!dump_ctx->hdr)
 		goto nla_put_failure;
 
-	devlink = dump_ctx->info->user_ptr[0];
+	devlink = devlink_nl_ctx(dump_ctx->info)->devlink;
 	if (devlink_nl_put_handle(dump_ctx->skb, devlink))
 		goto nla_put_failure;
 	dump_ctx->nest = nla_nest_start_noflag(dump_ctx->skb,
@@ -563,7 +563,7 @@ static int devlink_dpipe_entries_fill(struct genl_info *info,
 int devlink_nl_dpipe_entries_get_doit(struct sk_buff *skb,
 				      struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_dpipe_table *table;
 	const char *table_name;
 
@@ -650,7 +650,7 @@ static int devlink_dpipe_headers_fill(struct genl_info *info,
 				      struct devlink_dpipe_headers *
 				      dpipe_headers)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct nlattr *headers_attr;
 	struct sk_buff *skb = NULL;
 	struct nlmsghdr *nlh;
@@ -713,7 +713,7 @@ static int devlink_dpipe_headers_fill(struct genl_info *info,
 int devlink_nl_dpipe_headers_get_doit(struct sk_buff *skb,
 				      struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (!devlink->dpipe_headers)
 		return -EOPNOTSUPP;
@@ -747,7 +747,7 @@ static int devlink_dpipe_table_counters_set(struct devlink *devlink,
 int devlink_nl_dpipe_table_counters_set_doit(struct sk_buff *skb,
 					     struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const char *table_name;
 	bool counters_enable;
 
diff --git a/net/devlink/health.c b/net/devlink/health.c
index ea7a334e939b..8ce6cd399cb7 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -358,7 +358,7 @@ devlink_health_reporter_get_from_info(struct devlink *devlink,
 int devlink_nl_health_reporter_get_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 	struct sk_buff *msg;
 	int err;
@@ -456,7 +456,7 @@ int devlink_nl_health_reporter_get_dumpit(struct sk_buff *skb,
 int devlink_nl_health_reporter_set_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
@@ -715,7 +715,7 @@ EXPORT_SYMBOL_GPL(devlink_health_reporter_state_update);
 int devlink_nl_health_reporter_recover_doit(struct sk_buff *skb,
 					    struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
@@ -1157,7 +1157,7 @@ static int devlink_fmsg_dumpit(struct devlink_fmsg *fmsg, struct sk_buff *skb,
 int devlink_nl_health_reporter_diagnose_doit(struct sk_buff *skb,
 					     struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 	struct devlink_fmsg *fmsg;
 	int err;
@@ -1252,7 +1252,7 @@ int devlink_nl_health_reporter_dump_get_dumpit(struct sk_buff *skb,
 int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
 					       struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
@@ -1269,7 +1269,7 @@ int devlink_nl_health_reporter_dump_clear_doit(struct sk_buff *skb,
 int devlink_nl_health_reporter_test_doit(struct sk_buff *skb,
 					 struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_health_reporter *reporter;
 
 	reporter = devlink_health_reporter_get_from_info(devlink, info);
diff --git a/net/devlink/linecard.c b/net/devlink/linecard.c
index 8315d35cb91d..fd18f2759770 100644
--- a/net/devlink/linecard.c
+++ b/net/devlink/linecard.c
@@ -171,7 +171,7 @@ void devlink_linecards_notify_unregister(struct devlink *devlink)
 
 int devlink_nl_linecard_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_linecard *linecard;
 	struct sk_buff *msg;
 	int err;
@@ -371,7 +371,7 @@ static int devlink_linecard_type_unset(struct devlink_linecard *linecard,
 int devlink_nl_linecard_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_linecard *linecard;
 	int err;
 
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index ae4afc739678..f0a857e286bc 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -252,18 +252,18 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 	if (IS_ERR(devlink))
 		return PTR_ERR(devlink);
 
-	info->user_ptr[0] = devlink;
+	devlink_nl_ctx(info)->devlink = devlink;
 	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
 		if (IS_ERR(devlink_port)) {
 			err = PTR_ERR(devlink_port);
 			goto unlock;
 		}
-		info->user_ptr[1] = devlink_port;
+		devlink_nl_ctx(info)->devlink_port = devlink_port;
 	} else if (flags & DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
 		if (!IS_ERR(devlink_port))
-			info->user_ptr[1] = devlink_port;
+			devlink_nl_ctx(info)->devlink_port = devlink_port;
 	}
 	return 0;
 
@@ -304,7 +304,7 @@ static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
 	struct devlink *devlink;
 
-	devlink = info->user_ptr[0];
+	devlink = devlink_nl_ctx(info)->devlink;
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
 }
diff --git a/net/devlink/param.c b/net/devlink/param.c
index 3e9d2e5750c2..1cc562a6ebfd 100644
--- a/net/devlink/param.c
+++ b/net/devlink/param.c
@@ -627,7 +627,7 @@ devlink_param_get_from_info(struct xarray *params, struct genl_info *info)
 int devlink_nl_param_get_doit(struct sk_buff *skb,
 			      struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_param_item *param_item;
 	struct sk_buff *msg;
 	int err;
@@ -728,7 +728,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
 
 int devlink_nl_param_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	return __devlink_nl_cmd_param_set_doit(devlink, 0, &devlink->params,
 					       info, DEVLINK_CMD_PARAM_NEW);
diff --git a/net/devlink/port.c b/net/devlink/port.c
index 485029d43428..c268afefaed7 100644
--- a/net/devlink/port.c
+++ b/net/devlink/port.c
@@ -594,7 +594,7 @@ void devlink_ports_notify_unregister(struct devlink *devlink)
 
 int devlink_nl_port_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct sk_buff *msg;
 	int err;
 
@@ -830,7 +830,7 @@ static int devlink_port_function_set(struct devlink_port *port,
 
 int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	int err;
 
 	if (info->attrs[DEVLINK_ATTR_PORT_TYPE]) {
@@ -856,8 +856,8 @@ int devlink_nl_port_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	u32 count;
 
 	if (GENL_REQ_ATTR_CHECK(info, DEVLINK_ATTR_PORT_SPLIT_COUNT))
@@ -887,8 +887,8 @@ int devlink_nl_port_split_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_port_unsplit_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (!devlink_port->ops->port_unsplit)
 		return -EOPNOTSUPP;
@@ -899,7 +899,7 @@ int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct devlink_port_new_attrs new_attrs = {};
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_port *devlink_port;
 	struct sk_buff *msg;
 	int err;
@@ -961,9 +961,9 @@ int devlink_nl_port_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_port_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (!devlink_port->ops->port_del)
 		return -EOPNOTSUPP;
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 533d21b028a7..630441e429b3 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -239,7 +239,7 @@ int devlink_nl_rate_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *devlink_rate;
 	struct sk_buff *msg;
 	int err;
@@ -588,7 +588,7 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 
 int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *devlink_rate;
 	const struct devlink_ops *ops;
 	int err;
@@ -610,7 +610,7 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *rate_node;
 	const struct devlink_ops *ops;
 	int err;
@@ -666,7 +666,7 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_rate *rate_node;
 	int err;
 
diff --git a/net/devlink/region.c b/net/devlink/region.c
index 5588e3d560b9..537779bbff07 100644
--- a/net/devlink/region.c
+++ b/net/devlink/region.c
@@ -469,7 +469,7 @@ static void devlink_region_snapshot_del(struct devlink_region *region,
 
 int devlink_nl_region_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_port *port = NULL;
 	struct devlink_region *region;
 	const char *region_name;
@@ -588,7 +588,7 @@ int devlink_nl_region_get_dumpit(struct sk_buff *skb,
 
 int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_snapshot *snapshot;
 	struct devlink_port *port = NULL;
 	struct devlink_region *region;
@@ -633,7 +633,7 @@ int devlink_nl_region_del_doit(struct sk_buff *skb, struct genl_info *info)
 
 int devlink_nl_region_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_snapshot *snapshot;
 	struct devlink_port *port = NULL;
 	struct nlattr *snapshot_id_attr;
diff --git a/net/devlink/resource.c b/net/devlink/resource.c
index 574108ccfe5d..c3cfda7ea070 100644
--- a/net/devlink/resource.c
+++ b/net/devlink/resource.c
@@ -117,7 +117,7 @@ devlink_resource_validate_size(struct devlink_resource *resource, u64 size,
 
 int devlink_nl_resource_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_resource *resource;
 	u64 resource_id;
 	u64 size;
@@ -251,8 +251,9 @@ static int devlink_resource_list_fill(struct sk_buff *skb,
 static int devlink_resource_fill(struct genl_info *info,
 				 enum devlink_command cmd, int flags)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
+	struct devlink *devlink = ctx->devlink;
+	struct devlink_port *devlink_port;
 	struct devlink_resource *resource;
 	struct list_head *resource_list;
 	struct nlattr *resources_attr;
@@ -263,6 +264,7 @@ static int devlink_resource_fill(struct genl_info *info,
 	int i;
 	int err;
 
+	devlink_port = ctx->devlink_port;
 	resource_list = devlink_port ?
 		&devlink_port->resource_list : &devlink->resource_list;
 	resource = list_first_entry(resource_list,
@@ -326,10 +328,12 @@ static int devlink_resource_fill(struct genl_info *info,
 
 int devlink_nl_resource_dump_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_nl_ctx *ctx = devlink_nl_ctx(info);
+	struct devlink *devlink = ctx->devlink;
+	struct devlink_port *devlink_port;
 	struct list_head *resource_list;
 
+	devlink_port = ctx->devlink_port;
 	if (info->attrs[DEVLINK_ATTR_PORT_INDEX] && !devlink_port)
 		return -ENODEV;
 
diff --git a/net/devlink/sb.c b/net/devlink/sb.c
index 49fcbfe08f15..129bd016e302 100644
--- a/net/devlink/sb.c
+++ b/net/devlink/sb.c
@@ -204,7 +204,7 @@ static int devlink_nl_sb_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_sb_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
 	int err;
@@ -306,7 +306,7 @@ static int devlink_nl_sb_pool_fill(struct sk_buff *msg, struct devlink *devlink,
 
 int devlink_nl_sb_pool_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
 	u16 pool_index;
@@ -415,7 +415,7 @@ static int devlink_sb_pool_set(struct devlink *devlink, unsigned int sb_index,
 
 int devlink_nl_sb_pool_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	enum devlink_sb_threshold_type threshold_type;
 	struct devlink_sb *devlink_sb;
 	u16 pool_index;
@@ -506,7 +506,7 @@ static int devlink_nl_sb_port_pool_fill(struct sk_buff *msg,
 int devlink_nl_sb_port_pool_get_doit(struct sk_buff *skb,
 				     struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct devlink *devlink = devlink_port->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
@@ -624,8 +624,8 @@ static int devlink_sb_port_pool_set(struct devlink_port *devlink_port,
 int devlink_nl_sb_port_pool_set_doit(struct sk_buff *skb,
 				     struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_sb *devlink_sb;
 	u16 pool_index;
 	u32 threshold;
@@ -716,7 +716,7 @@ devlink_nl_sb_tc_pool_bind_fill(struct sk_buff *msg, struct devlink *devlink,
 int devlink_nl_sb_tc_pool_bind_get_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
 	struct devlink *devlink = devlink_port->devlink;
 	struct devlink_sb *devlink_sb;
 	struct sk_buff *msg;
@@ -864,8 +864,8 @@ static int devlink_sb_tc_pool_bind_set(struct devlink_port *devlink_port,
 int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
 					struct genl_info *info)
 {
-	struct devlink_port *devlink_port = info->user_ptr[1];
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink_port *devlink_port = devlink_nl_ctx(info)->devlink_port;
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	enum devlink_sb_pool_type pool_type;
 	struct devlink_sb *devlink_sb;
 	u16 tc_index;
@@ -902,7 +902,7 @@ int devlink_nl_sb_tc_pool_bind_set_doit(struct sk_buff *skb,
 
 int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const struct devlink_ops *ops = devlink->ops;
 	struct devlink_sb *devlink_sb;
 
@@ -918,7 +918,7 @@ int devlink_nl_sb_occ_snapshot_doit(struct sk_buff *skb, struct genl_info *info)
 int devlink_nl_sb_occ_max_clear_doit(struct sk_buff *skb,
 				     struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	const struct devlink_ops *ops = devlink->ops;
 	struct devlink_sb *devlink_sb;
 
diff --git a/net/devlink/trap.c b/net/devlink/trap.c
index 8edb31654a68..793ffc66dc11 100644
--- a/net/devlink/trap.c
+++ b/net/devlink/trap.c
@@ -302,7 +302,7 @@ static int devlink_nl_trap_fill(struct sk_buff *msg, struct devlink *devlink,
 int devlink_nl_trap_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_item *trap_item;
 	struct sk_buff *msg;
 	int err;
@@ -412,7 +412,7 @@ static int devlink_trap_action_set(struct devlink *devlink,
 int devlink_nl_trap_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_item *trap_item;
 
 	if (list_empty(&devlink->trap_list))
@@ -511,7 +511,7 @@ devlink_nl_trap_group_fill(struct sk_buff *msg, struct devlink *devlink,
 int devlink_nl_trap_group_get_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_group_item *group_item;
 	struct sk_buff *msg;
 	int err;
@@ -682,7 +682,7 @@ static int devlink_trap_group_set(struct devlink *devlink,
 int devlink_nl_trap_group_set_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct devlink_trap_group_item *group_item;
 	bool modified = false;
 	int err;
@@ -804,7 +804,7 @@ int devlink_nl_trap_policer_get_doit(struct sk_buff *skb,
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 	struct sk_buff *msg;
 	int err;
 
@@ -924,7 +924,7 @@ int devlink_nl_trap_policer_set_doit(struct sk_buff *skb,
 {
 	struct devlink_trap_policer_item *policer_item;
 	struct netlink_ext_ack *extack = info->extack;
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *devlink = devlink_nl_ctx(info)->devlink;
 
 	if (list_empty(&devlink->trap_policer_list))
 		return -EOPNOTSUPP;
-- 
2.44.0


