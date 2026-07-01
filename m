Return-Path: <linux-rdma+bounces-22625-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hMcxBAHFRGqD0goAu9opvQ
	(envelope-from <linux-rdma+bounces-22625-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:42:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 019206EAC9C
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Jul 2026 09:42:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=QfB4YtZV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22625-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22625-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24DEB301CF4B
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Jul 2026 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA71E3BFAEE;
	Wed,  1 Jul 2026 07:36:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15253B7772;
	Wed,  1 Jul 2026 07:36:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891394; cv=fail; b=Qgy7c4nOXqhTlVUUhBYncSyPoU5SetrlIKGHWLplCvfB0/BpA66QA6HzBQItQGL6REe3XpVV/cc0TL8nWiVBSGF6QEVRLY7cmzNR66paHfoxO7CiXO8OTcvGJmJnhNxHaNcUxCKwbGC0vM0UTPr986Q92YL3u/nh/RPa2TR+0j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891394; c=relaxed/simple;
	bh=PdvReyfBxXEkp+HbRgNu60XPJnkok/9A3wmaqGaJnAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ooFEGO3rMyk3JnzxIu0d53g5QeW7NWcBnl5Bhr8IHDg/b+SM9ZfJ+iCdnHteJpzgFr/X8gqoCWHIxYFUmw856y96AgdfKO5TcOOZhKXdhmbuy10QBbO9x6gFzh3ch0ahdB0mj9VCPaLMthRB5JxjuOXAlRpIOIltXZdjMa9TaZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QfB4YtZV; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEkH1ZiJSLHM8D8T9ugqEfOIqIdUXoMTk0who8Ge+6dCtw8qHdKrIElt/CdpJYOioRbFmGFDeEq5wYQmRQd/WtZ5pGYbD5P5wN4TqsJ/AHmh9mgBoWzmtKTB9RGlUlBfnzFd2wcKI8xFSJ4H/Pvm1sZlzSK627Dpb6QfJxglIQ1GKPrBlkBQUUhX4vfkaqRiwCeZ0gYF7tuhOYn/Iq8Ldf+I9TOfdJVdFIo/TKywkNSVCm/E9ZieOvxeUcXPaq283SzkljVQbbCPnGxoIEdgCSTcdpFMf9aNWk9H0jaWTW380Rg63eu6G43t2vCS1U/rLB6kQbiU2M5/3SFwqlx2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DDmGWO+a8EVoRHOw8wLNTLUstJu/8F/+1fAmxGmaxJ4=;
 b=tvEM53j4IsC8pWYRlM86zqkMpQOWEawUIA3drCUMdFdUYztK+8Eo07RboU7rG2B5KB6I9ehBOPgIEBYf3KV5sI4LiaTp8tB1TyJGF+5RDAOSmBokzjli0mIlppgZOUQ/YV2DoAV363wiGcB6t5EX58CZ9A9VCX4ceRpR9k1GnPaDOxuLnnxcQ/yulGQetDmX9gb42tBn5l22rtvIm8k5g0Wyty0DQ9mJAMXnS9ODC1orD/JSn7QkMHhMp7ABtI+i7YIG4/NHHfqMnBEpvVkS6H9qTaZc7268TOldZEcN+rLbVOm8Uem355iJkCBNFxP4t8x4O9NdAH6rx87rJA9eFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDmGWO+a8EVoRHOw8wLNTLUstJu/8F/+1fAmxGmaxJ4=;
 b=QfB4YtZV8YPEDlexplOwRpLQbRNl5DQIMl4Gd4v11hANs/57OTKrlehx2hQwXi5NBuSdde628zVK/WHsLa3Gk84RvbbpPrGUNT7T7DkXidJ2Nhd6AxHyl5ecqyu6uHODGKAA5XegCWVl1ytgXAmQFnnHOvDMrxL3l/3rIyI6r0Za3+E+MjMIapQUdK6Wv3hDIHg8oFqPT45EboczncwAmn7KnABJakjBsbiANDi/BE+P9+ToXvBjk4nGytosNlzuHlH79obz9KtCFhTOGzj6OjMTCNXFVTw0fZGi8zX9lWYJEKCKa26iLFxZ7sUcGKGh9fLEXK6c4gqHmmIk3lEK7g==
Received: from BN9PR03CA0031.namprd03.prod.outlook.com (2603:10b6:408:fb::6)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Wed, 1 Jul 2026 07:36:22 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::1c) by BN9PR03CA0031.outlook.office365.com
 (2603:10b6:408:fb::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 07:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 07:36:21 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:35:36 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 1 Jul
 2026 00:35:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 1 Jul
 2026 00:35:26 -0700
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
Subject: [PATCH net-next V10 13/14] selftests: drv-net: Add test for cross-esw rate scheduling
Date: Wed, 1 Jul 2026 10:32:53 +0300
Message-ID: <20260701073254.754518-14-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d41d69a-ffb5-4d5f-083d-08ded74372ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|11063799006|56012099006|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xAKUmkB8Btiuc6apOnCetveYYpmshhDQIDVxPBsUUtYKbNeFROSQ8KW8GeuxSt4L+6uzplNfhKKlvJi9obUXKqVUHhYpXP4VdKWaRO2xEFhxfzc6H7+Ay+/FhXQUyPDAMufU1bbn1HpOkSO0ChXMHSQ2P8SB0sE/7E12ZVwy1dxOYztHNZZ8P48ZivjBQH+k1TdmbUC4gS9lVBOH6EzX+lUcV+6GAQ3xR/8HyJ7u1EgL4Ro4YjSRT7K0TOr5ec6FYHuRsBtHmX3vXMaksFbdpDYHIGyU2StkY9Xp1mkVwaNgHPQo7kvuMy1458XkSXBHlqWMquseOeXmUWcQp1Gx2L9XU8De76Dbj6pY787ZYQo3yX5Q7EsIcRpeeC0DuqNcTnxjQy06cQeK8rsQ+BUg2tipghhZon0NN4tRK1ofqMRjiOgZzorI8rEHdzhNjrUhaGE296azJ5C7ekFjkQnTNMQysgRnUmindpRKAfnP6W0dLyT7O7GQWyuRS2GOqIachmBk+kHauI1wnLb89fTuj+CXZEylbCxR9qyyNQ+D4vVzNKWofcstIsTin6bHSs0sCEcQueFFoRqueb+9STtq6I09GxWwT97JhgbL/BN2Ij4VQdi9sJC7pdlXBjR10rTyDbffRKDMweMt8sUdeTfR6hjf+ImAEUgT9GpMsbV4XGhrRXsZKCxXl2yvl/T3r8h/tD5ZcPOp/jO+RjaaOS3nBg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(11063799006)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OkufxkfLogocSq8eSgu/BDFa9WfEPSDqgDqb4b2ktTs4ADA3f9X5BSaT1EE5fc81qphPPGujwpdpn0gOHRlEW0S1bye3qjtWTT+eEtoZ3bkp4WDQdKMIuFqiYy9HYw6e9n73LGAtfz5Q5T88WECfTrS+voJ69mZr08vw2Hh3n2atx2hiRQ+pvnYFdxMnqikvJo7/n0OEiZt3qLMXS7Wvw+fbjOGRYVwpvqqAw1oVrkz6lByobavmj52ZHVS4H+QWAciu/aPOFVh/YGRPFQYm8/lA/NY8eRNgjuVL5OUF+1bU4lCJgstIfntCgeg+iCEpJLBF93ttSZTK8KoKY430FpIbNWdRVCijD29iy519E7lC9xiXlKdA70MnphTNhAcWU5jDB1s8tbEFfoSVjXFH2oebDZw9QJzIbLovdAOBUuHNfhWcwjKC9QV/UfW8Xwmr
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 07:36:21.8819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d41d69a-ffb5-4d5f-083d-08ded74372ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:ajayachandra@nvidia.com,m:bobbyeshleman@meta.com,m:cjubran@nvidia.com,m:cratiu@nvidia.com,m:daniel@iogearbox.net,m:danielj@nvidia.com,m:daniel.zahka@gmail.com,m:dw@davidwei.uk,m:donald.hunter@gmail.com,m:dtatulea@nvidia.com,m:jiri@nvidia.com,m:jiri@resnulli.us,m:joe@dama.to,m:corbet@lwn.net,m:kees@kernel.org,m:leon@kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:mbloch@nvidia.com,m:moshe@nvidia.com,m:ohartoov@nvidia.com,m:parav@nvidia.com,m:petrm@nvidia.com,m:rkannoth@marvell.com,m:saeedm@nvidia.com,m:shshitrit@nvidia.com,m:shayd@nvidia.com,m:shuah@kernel.org,m:skhan@linuxfoundation.org,m:horms@kernel.org,m:sdf@fomichev.me,m:tariqt@nvidia.com,m:willemb@google.com,m:gal@nvidia.com,m:andrew@lunn.ch,m:danielzahka@gmail.com,m:donaldhunter@gmail.co
 m,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22625-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[devlink_rate_cross_esw.py:url,Nvidia.com:dkim,vger.kernel.org:from_smtp,lib.py:url,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 019206EAC9C

From: Cosmin Ratiu <cratiu@nvidia.com>

Adds a Python selftest using the YNL devlink API to verify the devlink
rate ops. The test requires a bond device given in the config as NETIF
containing two PFs. Test setup will then create 1 VF on each PF and
verify the various rate commands.

./devlink_rate_cross_esw.py
TAP version 13
1..3
ok 1 devlink_rate_cross_esw.test_same_esw_parent
ok 2 devlink_rate_cross_esw.test_cross_esw_parent
ok 3 devlink_rate_cross_esw.test_tx_rates_on_cross_esw

Tests will be skipped when the preconditions aren't met, when the
devlink API is too old or when the devices don't appear to support
cross-esw scheduling (detected via EOPNOTSUPP).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |   1 +
 .../drivers/net/hw/devlink_rate_cross_esw.py  | 296 ++++++++++++++++++
 2 files changed, 297 insertions(+)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index fd0535a96d84..234db5c2c90c 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -20,6 +20,7 @@ TEST_GEN_FILES := \
 TEST_PROGS = \
 	csum.py \
 	devlink_port_split.py \
+	devlink_rate_cross_esw.py \
 	devlink_rate_tc_bw.py \
 	devmem.py \
 	ethtool.sh \
diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py
new file mode 100755
index 000000000000..4416f024cb76
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_cross_esw.py
@@ -0,0 +1,296 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Devlink Rate Cross-eswitch Scheduling Test Suite
+==================================================
+
+Control-plane tests for cross-eswitch TX scheduling via devlink-rate.
+Validates that VFs from different PFs on the same chip can share
+rate groups using the cross-device parent-dev attribute.
+
+Preconditions:
+- NETIF points to a bond device with exactly two interfaces.
+- the interfaces must be two PFs from different devices sharing the same chip.
+- (for mlx5): the two interfaces are in switchdev mode and configured in a LAG:
+  - devlink dev eswitch set $DEV1 mode switchdev
+  - devlink dev eswitch set $DEV2 mode switchdev
+  - devlink dev param set $DEV1 name esw_multiport value 1 cmode runtime
+  - devlink dev param set $DEV2 name esw_multiport value 1 cmode runtime
+- test cases will be skipped if:
+  - the number of interfaces in the bond device is != 2.
+  - the kernel doesn't support devlink rates.
+  - the devlink API doesn't support cross-device parents (ENODEV).
+  - cross-esw rate scheduling returns EOPNOTSUPP.
+"""
+
+import errno
+import glob
+import os
+import time
+
+from lib.py import ksft_pr, ksft_eq, ksft_run, ksft_exit
+from lib.py import KsftSkipEx, KsftFailEx
+from lib.py import NetDrvEnv, DevlinkFamily
+from lib.py import NlError
+from lib.py import cmd, defer, ip, tool
+
+
+# --- Discovery and setup ---
+
+
+def get_bond_slaves(bond_ifname):
+    """Returns sorted list of slave netdev names for a bond."""
+    pattern = f"/sys/class/net/{bond_ifname}/lower_*"
+    lowers = glob.glob(pattern)
+    if not lowers:
+        raise KsftSkipEx(f"No bond slaves for {bond_ifname}")
+    slaves = []
+    for path in sorted(lowers):
+        name = os.path.basename(path)
+        if name.startswith("lower_"):
+            name = name[len("lower_"):]
+        slaves.append(name)
+    return slaves
+
+
+def discover_pfs(cfg):
+    """Discovers both PFs from bond slaves."""
+    slaves = get_bond_slaves(cfg.ifname)
+    if len(slaves) != 2:
+        raise KsftSkipEx(f"Need 2 bond slaves, found {len(slaves)}")
+
+    pf0, pf1 = slaves[0], slaves[1]
+    ksft_pr(f"PF0: {pf0} PF1: {pf1}")
+    return pf0, pf1
+
+
+def get_pci_addr(ifname):
+    """Resolves PCI address for a network interface."""
+    return os.path.basename(os.path.realpath(f"/sys/class/net/{ifname}/device"))
+
+
+def get_vf_port_index(pf_pci):
+    """Finds devlink port-index for vf0 under pf_pci."""
+    ports = tool("devlink", "port show", json=True)["port"]
+    for port_name, props in ports.items():
+        if port_name.startswith(f"pci/{pf_pci}/") and props.get("vfnum") == 0:
+            return int(port_name.split("/")[-1])
+    raise KsftSkipEx(f"VF port not found for {pf_pci}")
+
+
+def cleanup_esw(pf):
+    """Removes VFs if created by tests."""
+    cmd(f"echo 0 > /sys/class/net/{pf}/device/sriov_numvfs", shell=True, fail=False)
+
+
+def setup_esw(pf):
+    """Creates 1 VF on 'pf'."""
+    path = f"/sys/class/net/{pf}/device/sriov_numvfs"
+    cmd(f"echo 0 > {path}", shell=True)
+    cmd(f"echo 1 > {path}", shell=True)
+    defer(cleanup_esw, pf)
+    time.sleep(2)
+
+    vf_dir = f"/sys/class/net/{pf}/device/virtfn0/net"
+    entries = os.listdir(vf_dir) if os.path.isdir(vf_dir) else []
+    if not entries:
+        raise KsftSkipEx(f"VF not found for {pf}")
+    ip(f"link set dev {entries[0]} up")
+
+    pf_pci = get_pci_addr(pf)
+    vf_idx = get_vf_port_index(pf_pci)
+    ksft_pr(f"Created VF {vf_idx} on PF {pf} ({pf_pci})")
+    return pf_pci, vf_idx
+
+
+# --- Rate operation helpers ---
+
+
+def rate_new(devnl, dev_pci, node_name, **kwargs):
+    """Creates rate node."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    }
+    params.update(kwargs)
+    try:
+        devnl.rate_new(params)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("rate_new not supported") from e
+        raise KsftFailEx("rate_new failed") from e
+
+
+def rate_get(devnl, dev_pci, node_name):
+    """Gets rate node."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    }
+    return devnl.rate_get(params)
+
+
+def rate_get_leaf(devnl, dev_pci, port_index):
+    """Gets rate leaf (VF)."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "port-index": port_index,
+    }
+    return devnl.rate_get(params)
+
+
+def rate_del(devnl, dev_pci, node_name):
+    """Deletes rate node."""
+    devnl.rate_del({
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    })
+
+
+def rate_set_leaf(devnl, dev_pci, port_index, **kwargs):
+    """Sets rate attributes on a leaf (VF)."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "port-index": port_index,
+    }
+    params.update(kwargs)
+    try:
+        devnl.rate_set(params)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("rate_set not supported") from e
+        raise KsftFailEx("rate_set failed") from e
+
+
+def rate_set_leaf_parent(devnl, dev_pci, port_index,
+                         parent_name, parent_dev_pci=None):
+    """Sets a leaf's parent, optionally cross-esw."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "port-index": port_index,
+        "rate-parent-node-name": parent_name,
+    }
+    if parent_dev_pci:
+        params["parent-dev"] = {
+            "bus-name": "pci",
+            "dev-name": parent_dev_pci,
+        }
+    try:
+        devnl.rate_set(params)
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("rate_set not supported") from e
+        if parent_dev_pci and e.error == errno.ENODEV:
+            raise KsftSkipEx("Cross-esw scheduling not supported") from e
+        raise KsftFailEx("rate_set failed") from e
+
+
+def rate_clear_leaf_parent(devnl, dev_pci, port_index):
+    """Clears a leaf's parent."""
+    rate_set_leaf_parent(devnl, dev_pci, port_index, "")
+
+
+def rate_set_node(devnl, dev_pci, node_name, **kwargs):
+    """Sets rate attributes on a node."""
+    params = {
+        "bus-name": "pci",
+        "dev-name": dev_pci,
+        "rate-node-name": node_name,
+    }
+    params.update(kwargs)
+    devnl.rate_set(params)
+
+
+# --- Test cases ---
+
+
+def test_same_esw_parent(cfg):
+    """Assigns PF0's VF to PF0's group (same esw baseline)."""
+    pf0, _ = discover_pfs(cfg)
+    pf0_pci, vf0_idx = setup_esw(pf0)
+
+    rate_new(cfg.devnl, pf0_pci, "group0")
+    defer(rate_del, cfg.devnl, pf0_pci, "group0")
+    ksft_pr("rate-new succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf0_pci, vf0_idx, "group0")
+    defer(rate_clear_leaf_parent, cfg.devnl, pf0_pci, vf0_idx)
+
+    ksft_pr("Same-esw parent assignment succeeded")
+
+
+def test_cross_esw_parent(cfg):
+    """Sets cross-esw parent, then clear it."""
+    pf0, pf1 = discover_pfs(cfg)
+    pf0_pci, _ = setup_esw(pf0)
+    pf1_pci, vf1_idx = setup_esw(pf1)
+
+    rate_new(cfg.devnl, pf0_pci, "group1")
+    defer(rate_del, cfg.devnl, pf0_pci, "group1")
+    ksft_pr("rate-new succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf1_pci, vf1_idx,
+                         "group1", parent_dev_pci=pf0_pci)
+    defer(rate_clear_leaf_parent, cfg.devnl, pf1_pci, vf1_idx)
+
+    ksft_pr("Cross-esw parent set and clear succeeded")
+
+
+def test_tx_rates_on_cross_esw(cfg):
+    """Sets tx_max on group and tx_share on leaves in a cross-esw setup."""
+    pf0, pf1 = discover_pfs(cfg)
+    pf0_pci, vf0_idx = setup_esw(pf0)
+    pf1_pci, vf1_idx = setup_esw(pf1)
+
+    rate_new(cfg.devnl, pf0_pci, "group2", **{"rate-tx-max": 10000000})
+    defer(rate_del, cfg.devnl, pf0_pci, "group2")
+    ksft_pr("rate-new succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf1_pci, vf1_idx,
+                         "group2", parent_dev_pci=pf0_pci)
+    defer(rate_clear_leaf_parent, cfg.devnl, pf1_pci, vf1_idx)
+    ksft_pr("set parent cross-esw succeeded")
+
+    rate_set_leaf_parent(cfg.devnl, pf0_pci, vf0_idx, "group2")
+    defer(rate_clear_leaf_parent, cfg.devnl, pf0_pci, vf0_idx)
+    ksft_pr("set parent same esw succeeded")
+
+    rate_set_leaf(cfg.devnl, pf0_pci, vf0_idx, **{"rate-tx-share": 1000000})
+    rate = rate_get_leaf(cfg.devnl, pf0_pci, vf0_idx)
+    ksft_eq(rate["rate-tx-share"], 1000000)
+    rate_set_leaf(cfg.devnl, pf1_pci, vf1_idx, **{"rate-tx-share": 2000000})
+    rate = rate_get_leaf(cfg.devnl, pf1_pci, vf1_idx)
+    ksft_eq(rate["rate-tx-share"], 2000000)
+    rate_set_node(cfg.devnl, pf0_pci, "group2", **{"rate-tx-max": 250000000})
+    rate = rate_get(cfg.devnl, pf0_pci, "group2")
+    ksft_eq(rate["rate-tx-max"], 250000000)
+
+    ksft_pr("tx_max and tx_share set on cross-esw group")
+
+
+def main() -> None:
+    """Main function."""
+
+    with NetDrvEnv(__file__, nsim_test=False) as cfg:
+        cfg.devnl = DevlinkFamily()
+
+        ksft_run(
+            cases=[
+                test_same_esw_parent,
+                test_cross_esw_parent,
+                test_tx_rates_on_cross_esw,
+            ],
+            args=(cfg,),
+        )
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.44.0


