Return-Path: <linux-rdma+bounces-21864-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1c70CxcTI2rKhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21864-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:19:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7433064A830
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:19:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RGgdsz5H;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21864-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21864-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04BE93090274
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029F7390987;
	Fri,  5 Jun 2026 18:11:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CAD352C5C;
	Fri,  5 Jun 2026 18:11:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683070; cv=fail; b=R7XZimyWvX9kfB2vejloQTNSYMhjWEleowBCkNdQkbzFo/JmCD1rpKOtF5Js6sP8B6YR+TcdA8MqBcs8kddUmT8Sf0zMMXFdp0GY9Gg7bzG0URZ0mwosLugQa7FHvTE0OBjsDXHG2ZrbpEbGNojrfWyqGOfu1MFAFragEzwZqaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683070; c=relaxed/simple;
	bh=WWj+SibAQaur8eEyW7G/ZcregjHhv8eLRYL+lE/yZnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aWXCnyj41p6dm/8rIsJ/FQOCh1apCMTVJvKrZUHD2YanYyALHHEceLm6+aQelmBJPVuWPIBpVRdUkj1t2M1Jxh4LgKN8EoZsW+1q1JBMOnYU5gE0qvYoMMGpRTlOMTNVBTH167FiGdon8Br2zAXhAG/+BOW4BbnlilVVo36os7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGgdsz5H; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8IgIShwwx9i5md+S3Uwn842rUjUPmOr+Yfzn2u5DReLAaGm8XZdS3NfqTN+DKVRUr2dwk5Q0VZUD6D+WISLG0JuaziKFySpEGruMjqi220mf/DoEzcsehQiKWO5SgWrygWYrQXrQVdmBeYt1eHdfGWjGIyDXxvL5e86S0qp5d8iclIvfrGO2AYWbAkEp/1whcZN5a/bbZgzMvGVMhyRgX0zYYMnj6okDoPpCExRrC0Wg6IbXjS7e5gdZiHHiKFQhpDQzrBGd5TCZTOJ71oBQlVUyAjB6HoeQalbtVsST0u0xm9JzOeb8qWb8PLshoCg45PFgIWx+hAu4Bk6X34X6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOzXg4ELiIwpdVe8654QZ59eyu84oQASRviVXdJpObY=;
 b=NtiOB0Kp2l1yuYXSNSvkO3Mbvw3rjXBMRipBBlMSaKUwYr5fM2jB9Cjr/vqlMj7jIVV9B1z4qS1JublJARWSbsyYvSjlwFn63pQNPMkcKHtVQmMmrji1mssjgd36P2J77j/6cYlSpH1Wjw03u7T81TMFHVkdENYQ0X9LJV/BeWeNnK3eQrGPlxOZrVlDoblP8Z2tphKR+1hEo6G3Nokq51Fhvx5HK7I9rruzTcWgJmnMJ9E/EPufAQhmbskccoT86c+LPem/3DwCL4xMcjUNEBQA7d7YO/ks5ZSZ/wVTayl2djzAMffdaSrXLesr6bPnWAtrD+n6JmxIcOAcKrSwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOzXg4ELiIwpdVe8654QZ59eyu84oQASRviVXdJpObY=;
 b=RGgdsz5H01RfX7qmc0yrz4hTdxSSCBJJpQlQ18u9BaIMcru1n/fwL0nbvpmWodFCsWtWrChXQ+a5ZgwCoLcS+HgSolv7J+dTutCIbHPc1UYW6RzMc7veo59e52AUuSc6xT7Umlh5ofgv1B0J3EtPGPsvmEQkco+ZEhtlv7aOYKP+vf5dj1WOk7qQigKLGlTmHcEPGnR9Nw9DPTmN+MnsuL8Z1vxEvOO4phgpoOfI/1+54Oe3h88xSLNlIOAoAZKeP41x8aSZiSo3QEe7ve3Ob1eG7z2sTDNkFJIN8BR7cXTitEQfFmhfDg4dWvr5HzUCjwEBg5vOpsTfnXxc6P+jPg==
Received: from PH7PR17CA0017.namprd17.prod.outlook.com (2603:10b6:510:324::13)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:11:01 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:324:cafe::53) by PH7PR17CA0017.outlook.office365.com
 (2603:10b6:510:324::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.2 via Frontend Transport; Fri, 5 Jun 2026 18:11:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:10:41 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:10:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:10:31 -0700
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
	<rdunlap@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Petr Mladek
	<pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Vlastimil Babka <vbabka@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, Feng Tang
	<feng.tang@linux.alibaba.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Kees
 Cook" <kees@kernel.org>, Marco Elver <elver@google.com>, Eric Biggers
	<ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, "Paul E. McKenney"
	<paulmck@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>
Subject: [PATCH net-next V3 0/7] devlink: Add boot-time eswitch mode defaults
Date: Fri, 5 Jun 2026 21:10:23 +0300
Message-ID: <20260605181030.3486619-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 79297108-1477-4d21-b2ea-08dec32dccbb
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	b8QAAm5aV7gTf9pohVoKHL+C16a6rLnhFgFnocmgYDzz9LFu/mNy+41L3fvoHX/pqrAlbKejoO8Sa6jg0b1Sw5NzY63iqBJIa73hZh/MMIyUh4U8bxg3CrfQgTSNnxvd6qD+jxmH1JonlVRtz3bJsYvackDEMEObwzuTL0KEXPbyRuQG05cFQ0TmKsOnU7DriKi4wZi1iqqG5ci6Bk5R5Ydd/U+EJAM7opyP5a0vZIFoWYBrpyl34q2cgWpSUqTRANuYUMwOp0XOSiYzqIkqm+a30ozYyF4km+ggwfXSlz/jbUlKSKC5iCr+aIY755eV5gjYxMho9r1gX7PcphZIvJooL2dEOwry8qoIMWwr1WPTsfXKxmXYx7xbcbd4D8EfvXNytqfO80c+uvkjiOFJ0t2DXws3LnNdq7dvgFLm+uMjTJLdZso+oNXAD+olpmyFs2xTCeeRThqBGZ3Go7lfY1CSrKTwbkexAsTc3dD2tj599VFkJHrfTQ4QPfsbtmSoaATj6IHqinUdPoG4co/qFhx5uNRFplPjm9FnhnsqfiDqMiqxSOwGd/gnCITUKAiDghhR0P9E2AA8ClVfCecrX0FSS30qfOhZgEWqf51U49MfcOiXf1dptWFT/XPkbYTST6CFifMu83uo1rEwBnTb73xaiOCJ6vnvYAFefdGmpnVP0OhSjxrejjTZv/Hlxegs2Yn5o9zlNITQyTc88HycBak2Xm6p/4x5wRJjHhnozCA=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	g8rIsIYbY+N46HsgPOiWdh2gswfzWcVy4Gio3nE3yPTT32etkQJrzM1TuTCzF8x3CpEnNaU4KwXyw1Mp/ITd6qi19shvHep5KsqpG38cd7GSIAzCTw5Z1hLx6FOeZ8IT605x8tNmxBe/efeai+aQn/aZqNdknABOaYKbo1tDtT1yW2N7CFngb4yW+4wWsSyndB5NuC+7O5MCt1AWAJVcY8H5sEkfijFunEVPPPBVBKmYtDsHRbM5WRSKs7c+xAAnzO6c/R3K6uTpAMWOKwv0TaOlDM3QKf7hHHv1l4MozuXfmLc1v0ybOz2FRqrdG9A4mzK9NSqFofReqenjoUEr7BqrmR+mK4VB5jJub45wc4xkWH3xIyAlXW5T3vmhof3yRT8PXdKVhoXujS0zEjknj1blMjKiHzpazcndA0Yd5z+D0PVTntmsSxuL1zeKYjVg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:11:00.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79297108-1477-4d21-b2ea-08dec32dccbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[41];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21864-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[lwn.net,linuxfoundation.org,resnulli.us,kernel.org,marvell.com,nvidia.com,alien8.de,linux-foundation.org,infradead.org,suse.com,linux.intel.com,linux.alibaba.com,google.com,baidu.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mbloch@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7433064A830

This series adds a devlink_eswitch_mode= kernel command line parameter for
applying a default devlink eswitch mode during device initialization.

Following the discussion with Jakub[1] and the feedback on the RFC
postings, this version keeps the scope limited to a boot-time devlink
eswitch mode default only.

The option selects either all devlink handles or an explicit comma
separated handle list:

devlink_eswitch_mode=*=switchdev
devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive

The supported modes are legacy, switchdev and switchdev_inactive. The
selected mode is applied through the existing eswitch_mode_set() devlink
operation, the same operation used by the devlink eswitch mode command.

The preparatory patches move registration points that expose the devlink
instance before the driver is ready for a registration-time eswitch mode
change. Where registration is moved later, the matching unregister path is
moved earlier so unregister notifications are sent from devl_unregister()
before object teardown. The final patch adds the parser and applies the
default from devlink core when a matching instance is registered and after
a successful devlink reload that performed DRIVER_REINIT.

Patch 1 skips devlink health recovery notifications while a devlink
instance is not registered. Health state and counters are still updated,
but there is no registered instance for userspace to observe or receive
notifications from yet. This lets drivers move registration later without
hitting health notification registration assertions during early
initialization.

Patch 2 moves netdevsim devlink registration after device initialization,
so registration-time defaults can call eswitch_mode_set() after simulator
state is ready. It also unregisters devlink before netdevsim tears down
the objects that were registered before devlink became visible.

Patch 3 clears the mlx5 FW reset-in-progress bit before reloading after a
firmware reset.

Patch 4 moves mlx5 devlink registration after device initialization,
including the lightweight init path, and moves unregister before the
matching teardown.

Patch 5 moves octeontx2 AF devlink registration after SR-IOV setup and
switch lock initialization.

Patch 6 moves octeontx2 PF devlink registration after PF SR-IOV state
setup.

Patch 7 adds the devlink_eswitch_mode= parser, documentation,
registration-time default application and successful reload default
application.

Changelog:

v2 -> v3:

- Change the devlink_eswitch_mode= API syntax to use <selector>=<mode>
  instead of [<selector>]:<mode>, following a comment from Randy Dunlap.

v1 -> v2:

- Move default eswitch mode application into devlink core. The default is
  now applied during devlink registration and after a successful devlink
  reload that performed DRIVER_REINIT.

- Remove the exported devl_apply_default_esw_mode() driver API and the mlx5
  driver-side call to it.

- Skip devlink health recovery notifications while the devlink instance is
  not registered, so drivers can move registration later without early
  health work hitting registration assertions.

- Move mlx5 devlink registration after device initialization, including the
  lightweight init path, so the core can apply the default through the
  normal registration flow.

- Move the matching netdevsim and mlx5 unregister paths before object
  teardown, so unregister notifications come from devl_unregister() and the
  later object teardown paths run while the devlink instance is no longer
  registered.

- Add registration-ordering preparation patches for netdevsim and octeontx2
  AF/PF, so their eswitch state is ready before registration-time defaults
  may call eswitch_mode_set().

[1] https://lore.kernel.org/all/20260502184153.4fd8d06f@kernel.org/
RFC V1 : https://lore.kernel.org/all/20260506123739.1959770-1-mbloch@nvidia.com/
RFC V2 : https://lore.kernel.org/all/20260510185424.2041415-1-mbloch@nvidia.com/
v1     : https://lore.kernel.org/all/20260521072434.362624-1-tariqt@nvidia.com/
v2     : https://lore.kernel.org/all/20260603193259.3412464-1-mbloch@nvidia.com/

Signed-off-by: Mark Bloch <mbloch@nvidia.com>

Mark Bloch (7):
  devlink: Skip health recover notifications before register
  netdevsim: Register devlink after device init
  net/mlx5: Clear FW reset-in-progress bit before reload
  net/mlx5: Register devlink after device init
  octeontx2-af: Register devlink after SR-IOV init
  octeontx2-pf: Register devlink after SR-IOV state init
  devlink: Add eswitch mode boot defaults

 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  78 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  24 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  17 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |  28 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  34 ++-
 drivers/net/netdevsim/dev.c                   |  15 +-
 net/devlink/core.c                            | 271 ++++++++++++++++++
 net/devlink/dev.c                             |   3 +
 net/devlink/devl_internal.h                   |   1 +
 net/devlink/health.c                          |   3 +-
 12 files changed, 451 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst


base-commit: bfa3d89cc15c09f7d1581c834a5ed725189ec19f
-- 
2.34.1


