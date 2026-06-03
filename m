Return-Path: <linux-rdma+bounces-21710-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iGssGT+DIGos4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21710-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:40:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D995D63AECC
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=tKNsNaI5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21710-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21710-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7395330558A5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 19:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C3C48C40A;
	Wed,  3 Jun 2026 19:34:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013040.outbound.protection.outlook.com [40.107.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A95F48C3E7;
	Wed,  3 Jun 2026 19:34:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515251; cv=fail; b=tZQOpLpxCBTDJEi1CkYkRsEbjCRYWVww6gdw3LEOkuxUhhxdoxkura6+JLWRJ203uqpNowz8nbKhZsDdoLbbZAYavkMkN7xX4aZOZImbS/m6GBVp1QSQcS9ivOhKQ2Da1TNHuyeXz/5YQCyempc1TIr/x3Il6xTiVzqQPbbWFws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515251; c=relaxed/simple;
	bh=3L4qTVaXVsHhZGtPKr5grk91uzRlksA5PWNKFDY+HD0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uy4g8OEp3afiUDCHlbSHK7q2eznIJKWJV9EMC2wNSYkIGF57yNLRAyasI1J3/G70xr7fDi0gxHAcn3CyI9y5Wd+OfT05KZ5SxlTXFTO91IXU9WHa01HvyNsR8zqjV+oNjqLlmwctcNT1J7ixGU9BAs70/zaHJcxTEHUfAgxhIgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tKNsNaI5; arc=fail smtp.client-ip=40.107.201.40
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6E+eCLOxQj7kHgXpOvZPfZ93fMh6cwqFSM9kKdl9sbQgDEywKHowSyN+jxpLyg+jcF9Pb8TtrqVQMfkg+a/D7xYYDga04QUMJwktYWvy4rsqkFOdJXU2g++QIWbaxG2LrkwFOfLtwg+I0EFcW9e0XsW9xiK20njRMncoxXSTVLMXPT/L6Wrxcq2khQfoCVo4/sxiQM4jXvJGP0R2fWKsbo2iFWvIvLrpkZuA+ZCYBE52u/0e0g66MwruTvk90SqQaahEPmWymTWEwKx91DzUL0RTk8nRfOn/lpWWscXGshtznrCbTAxT6kKQcxJd0B7I8ZDOO9DcBhWBIZVw6T8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwMMEhxYUtogO9ja4xvnvWwjCYS+isEdhmWIzJuXmR4=;
 b=nZzE6NGGJEOwCZTQ43JdZZWndBPZpNBkvzFIA4jFLwEBUDTq44y2p+aRgsZFXkZ0uPUK/aiiXqk9WDp8aWcEoLHburr4RKZ3XfpL1Rz4JaVgNy5VH16x5Rh91phjGd83Rq8klgMoxa+RDMWnduA5a4eiesenowDX1aO2PRtDQXwbThf0yyjSDcVDSh1vGA5K+CEdnb/04BeIlSewMYr/AV5pn8qaCBHHr3pBzZI8LESFcfh/v7EuH3mbbydWwSzwHvzueASlT+Xn+coapeiNi/EQdjtTq9vVRrRPrDWvNPm/mFTb6R568CyA9+00GgpS1d9CzubzevD/fTrHwak1lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwMMEhxYUtogO9ja4xvnvWwjCYS+isEdhmWIzJuXmR4=;
 b=tKNsNaI5a8MysdEYS79aYIJWmgsv822Dxb1NWsLFjrRGzicoYb4HaHR9JA8XGfBQfTMc8sZti7i2DpzMOVptAYLwyydWUAD75QLoWlbxLmtIYPI+QQmCgI6B/IcqeOxGYTTLuSoN5SLOaSNGnqe9FQ8o4rO+sSu7CUvZNKRWBo2rGCbTsgKVD4NAsBdeQs10ioUR8M+s7z40eAH1iVuEvzDUAL/f3cgufL6DDlYpG23yl2/1TIbsOwHEf716Cf5BCLEI695rrGFNyxnEvJCViXOWFesa0ctO5HP6LDKD6BVtwONW3ypTeIE1D+sjgnl9kwl64G9oEWUrGeTbQ0bv6Q==
Received: from BN1PR14CA0022.namprd14.prod.outlook.com (2603:10b6:408:e3::27)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:34:00 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::6f) by BN1PR14CA0022.outlook.office365.com
 (2603:10b6:408:e3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:33:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:33:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:33:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 3 Jun 2026 12:33:28 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 12:33:20 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Petr Mladek <pmladek@suse.com>, Tejun Heo
	<tj@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>, Dapeng Mi
	<dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver
	<elver@google.com>, Eric Biggers <ebiggers@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Ethan
 Nelson-Moore" <enelsonmoore@gmail.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Subject: [PATCH net-next V2 2/7] netdevsim: Register devlink after device init
Date: Wed, 3 Jun 2026 22:32:54 +0300
Message-ID: <20260603193259.3412464-3-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260603193259.3412464-1-mbloch@nvidia.com>
References: <20260603193259.3412464-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: dcaa9c4d-6e6c-4fde-f4a9-08dec1a70f0f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	5H0uZVqEIt+9Bse6Wsksb5K/0ZrlDU0mPmMZtZjIOFf0Xb/FVf4qSVYSRg2RvRq2LQI/Vt6sULbr3GKCzvlDrFtpv0FVXZkMLYD9r5qaRXNFfX59UFEhb+mfl9kF3cEBPJOb4cPfdGg8VzZMYY3ucB3qdnveD1lWAllHcdk6XcwDiai3zFfy9YJTBJR7rdEEE6yX1S5RXqfdo9CfeJ9jR91gyOZ7UgpP0CU9NiJZFu+aCwiwd7+F4tgKFZFNqaDNq+yqlmK0ElSTauuhKuUuP4zEMEFvRq0eN9xa9DehznRUusb2DJeASmmaSIM8emtYkKzw9wyat9O6GhzgwU+4repQLE3ypgcxtOqlxULEWDYAiASG8Sk5QQB84I8+2RIAu7FKtcs6vG21USSSA379ApVkm3gmRrsmaD1kcpV3NrDGlavvplB3humH8+USSdcdv/QpGCpF6utJxovmplJ0wr/8jDj94Qzj1YCaAGmlpOLbCu80p0jxu/a/vvq/wpy0/QClqF79pnPKQBguqmXOKsSQLtUM9LNjhJPVScmhNWZ9umZKW+ET4lkBvHwd6Mz3ang1Wd8abUxQGW/OgyhDc7lAwTvnP1nIEQ82i3UqfSB1wf7hRwX/lKxZrL1Ab0j4Pi3LMH9DXGEia1LI7SQpwuuznkRyqmh6NvFoIvBksZTQ/aOIX5OoYXh4MiYvbeGLzF0+2PnjIHgk58ZQ13Kb/7gS6WBaIPP84hbFcrANysw=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RDxfJqBaH7skHRL6JAxD+04o22Ut5LrlB9IQrySHL8EocyvATZgqf5tL2EGtN+Hd3UsM3MUiBiPw4L77dAsrZHj30vk5e4sDOE7MRKQsqmMgEeyhPlTwATp+iFdk/SDxg+2doHm3DP9p/L3mlO7levI5biOt9X5VoDX+3XjnVn6z/JDmbCTUvUdnZWnMMGhBQWB4tJAAYzGmptjGKXBg+4zSWNkRbWJqpRjw1E6HDOhiPTVnmvo1U6TNcS+HxrkSmUBLOFbBWtBqLEshklfFGm319fN20vBpj9MizpcBT/pU2TGky5VCcOehTMlQ3eo6bYQaItqcW9B275gED9y9jc0IdRwgnTlG60TTdRVU/5USNLRDxS3tUcgn6RmisRpE0vO7qng1mXCCUIQGlFflSlzmFnWRabzwoitWcXiDRquyuMtdvKswBzEd9CkygPpy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:33:58.7951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcaa9c4d-6e6c-4fde-f4a9-08dec1a70f0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21710-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.alibaba.com,linux.intel.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D995D63AECC

devl_register() makes the devlink instance visible to userspace. A later
patch also makes registration the point where devlink core may call
eswitch_mode_set() to apply a boot-time default eswitch mode.

Move netdevsim registration after all objects (resources, params, regions,
traps, debugfs etc) are initialized, and after the initial eswitch mode is
set to legacy.

Move devl_unregister() to the beginning of nsim_drv_remove(), before those
devlink objects are torn down. This keeps devlink register/unregister as
the notification barrier and makes the later object teardown paths run
after devlink is no longer registered, so they do not emit their own
netlink DEL notifications.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/netdevsim/dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index aed9ad5f1b43..7cf4102b049e 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -1680,13 +1680,9 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 		goto err_devlink_unlock;
 	}
 
-	err = devl_register(devlink);
-	if (err)
-		goto err_vfc_free;
-
 	err = nsim_dev_resources_register(devlink);
 	if (err)
-		goto err_dl_unregister;
+		goto err_vfc_free;
 
 	err = devl_params_register(devlink, nsim_devlink_params,
 				   ARRAY_SIZE(nsim_devlink_params));
@@ -1733,9 +1729,14 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 		goto err_hwstats_exit;
 
 	nsim_dev->esw_mode = DEVLINK_ESWITCH_MODE_LEGACY;
+	err = devl_register(devlink);
+	if (err)
+		goto err_port_del_all;
 	devl_unlock(devlink);
 	return 0;
 
+err_port_del_all:
+	nsim_dev_port_del_all(nsim_dev);
 err_hwstats_exit:
 	nsim_dev_hwstats_exit(nsim_dev);
 err_psample_exit:
@@ -1757,8 +1758,6 @@ int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev)
 			       ARRAY_SIZE(nsim_devlink_params));
 err_resource_unregister:
 	devl_resources_unregister(devlink);
-err_dl_unregister:
-	devl_unregister(devlink);
 err_vfc_free:
 	kfree(nsim_dev->vfconfigs);
 err_devlink_unlock:
@@ -1797,6 +1796,7 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	struct devlink *devlink = priv_to_devlink(nsim_dev);
 
 	devl_lock(devlink);
+	devl_unregister(devlink);
 	nsim_dev_reload_destroy(nsim_dev);
 
 	nsim_bpf_dev_exit(nsim_dev);
@@ -1804,7 +1804,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	devl_params_unregister(devlink, nsim_devlink_params,
 			       ARRAY_SIZE(nsim_devlink_params));
 	devl_resources_unregister(devlink);
-	devl_unregister(devlink);
 	kfree(nsim_dev->vfconfigs);
 	kfree(nsim_dev->fa_cookie);
 	mutex_destroy(&nsim_dev->progs_list_lock);
-- 
2.34.1


