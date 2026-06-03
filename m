Return-Path: <linux-rdma+bounces-21714-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lGw7BsiDIGpP4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21714-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:43:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEC663AF35
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:43:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=dIFShVEC;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21714-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21714-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BD4D30C885B
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F138848C40F;
	Wed,  3 Jun 2026 19:34:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3948C3F6;
	Wed,  3 Jun 2026 19:34:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515287; cv=fail; b=W72x/fc3OboxIMqeg22k3L1rAn4NOZkoo3cO32nfTS/6BfTDuKwhaw+umsNA+GrasBl62Lsrs0SUKMqrNsfUpcZnQfRhceYS+PHxMn0xyPmSG8WYUXyHftwxelQbjZgRa2gKU2JGoyIJFrpfsdbiDIEr5wMmG1Evjtp/p0WlP68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515287; c=relaxed/simple;
	bh=l6Tzcf4oguMZQOQmjpFTjHZgXDoR9U4Bro4lWTlRNMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9u00vhs+7c3RlJEMDcJoM5uxb+uYPLvW0TigL71+66NFaizglxIsZpR2oWzo4CFkLBvRwk96GHEhSloL6RsWXzEg7cOdXqoK4wvTMQaAyzMieFUG66gpPD7oLmMbn21qbazEF5HlFpz75PHf0UTCodsD7YMUe0EzDJoLWfapt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dIFShVEC; arc=fail smtp.client-ip=52.101.61.2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+SsQlyxYw1rvn7TusavqCkCssOPy9pwkEkmYxVK1ubKsd/mxUrXtF3eLq+n8DhfzyfJ47Y1s83Hx7fVl9RC0ERHXWV3hdJVUQ7mJ/XFCt36sLLWuHCx3p/jpFulQZGVAnxJ8h/P6EO9zWoymCvur5mN1TIn3rdhd88wlWjUa3WD0o7kpOX9iLiYI0Kiaa8K0XiDW6zVWae1HPXjddDPHGjfGlGLnc8PCytERB8SBQxSyuBl7xPILerwtiL/iqENG6Emx4PYBLUs/jwLmv3nu4f8UKuPwrzQ+vT1mdo4w+tVpJ1ZkbL2lx7G+FzLWXlyUDnVQdF9umoksaRPYvr0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlZztyhe+geSeU07NP7nWjsOXebqDB+4JrLJLJMN9JY=;
 b=f12rCbqVp9p6+ULs/Njlg2WmlQArQhjEoZFbL21TsnwmtUq9yFF9cCjXgsRVDeYdLGBlOFxN5+rquikAcrq417fXMRsW2e3AF7VTEQzUXWuBujXp0vT20kU+JCVKFRPp7YalZEUCwFbAKyq2ySYr0FAJTRq+woETT6D6FhChDl8vIJzkdfQIi04+oP6DpDpGNzDdjjpCf5jzRtdmflAAWq+7kKO1TrKpaFgzTw3tJRBXHUttm1a1CWF/ePB3ZBoH+oBUnzorKe/AWKmUQZliFbJMeuJihrgVA0xVfxrY0pni0O1DSgbsGvO7nZS/zTGZAzc31ixDs3YmQFZeMiRUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlZztyhe+geSeU07NP7nWjsOXebqDB+4JrLJLJMN9JY=;
 b=dIFShVECCqebMzvDCb3WDJGTv1NqAlC2tkoQ3Lrb/mmNy+hGo1Gg6O7gnkj3z3hxLfro0c7uwJuOoAieHMqPQLWIK3bSmYguQACqMmfl+NiC8k5I7VsDbfcUnTGtufb4KfVDJEp++1DYcuSs0ik45KN/brmQReUN/EXkCgvLlG/iNy0Kud4DGCQw9pCH6MSVMS1IpzWGf7kmbZOM6OsleojqeR0Yxr7VQzL98cdoMnbp4CAf3bU9yG7eoZCLcSBTueMxRbCgRB13WOnQC2lCaMNZHOKuhREbZHUQqdJIgLfUzjQQtok/5lKrZE/17wNJHz9prfdCtV2y80x8WllHSg==
Received: from BN9PR03CA0921.namprd03.prod.outlook.com (2603:10b6:408:107::26)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 19:34:38 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::6e) by BN9PR03CA0921.outlook.office365.com
 (2603:10b6:408:107::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:34:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:34:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 3 Jun 2026 12:34:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 12:34:07 -0700
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
Subject: [PATCH net-next V2 7/7] devlink: Add eswitch mode boot defaults
Date: Wed, 3 Jun 2026 22:32:59 +0300
Message-ID: <20260603193259.3412464-8-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea46941-ed40-4e3d-5f9a-08dec1a726a8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|3023799007|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	cC6U8Qc6H9/HVk6jzHGLXgfIgR3RHIapeYTtQNOjHxvTfGLIEGzK5+dE0RCkqMNkW36WPZMU1nK6tN1Uvqnyqze2nPHnXuGxrY/+ukh8dqid48A5VRZSxlCT6/cFhgAOnHgTwYkiYLZwpQiTPELCMmkp6ij1wuWE+sD9T9QNUSiXdJT83noDVWuDmtZhyMCuWtYTOmDTJeY2jsNjgXw4lKaKsdeayZB8OYjmxLePqwAAPxRIi5DJamrBzj6R302goqzHVyvTQCquYt1lSJmBuB/uDTvCySmmfQtXgDaYLQIvFNtduogxlkw1zg05XD3JD81MsMCuC/yNpcjnDX/wBfGirEepSFVirCFqdblrzCZtNpA6UM4itXLOwpzKfwwvE4mwZBUjKn3UzykNrC/jTLzXqbeUhK3g1MHwMHPGX0gcw4Ic5TSk7ML3V/y/W7UENxjM3CuNyfK5YjnBT0K7+5eB92IJqOG+TRH5Mu25Rk6VVUDklFH/FmJ4O7J/9WCLwOvXBBmxKIGzaK/mrLLbYvlYDtq7QrkTqT4SxZjTk9aHWKCxjMUMokNZ/P1L32jm8W1xLjQHebeZmwZ/lLiHNQwO+/lhMuv2yVggVeQBv6GLNruArrBl1j3xpAWmDWgNKdaGgj/By7OwcsI+dgsLg8H1jYrvNeESNKegM3onk/0W0GwRyMTPWM4XfopUAXvfyif05eSehPwkghOyjWOKVzApQgP2ca4pYQ0Lu1CP15g=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(3023799007)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5Qu0sK7DOVcwvjouLV+pGiYX7keeNaBp64fGxCzKTiF741ZB5CQ/lCyDDDjDqgnYggHdtQ0WCpkzUXJ9ylgPIzFL4RGlvt8VE0u80A8WMEnXjbWHopj8aZM09gJEfvFYLCsOz7WnvGe/r0VjlR6myfYNmrHV+bTFonRd8DEtmGYBW2cKEfUcOVs01d/X7Oc1W+yhuXbk8HruDfyHRcmI1+b40k0Zg37G9pUrTtlPYuMIs2G3MIF0fW4W2MGFGtSS5k/Ecr770ATJl9V1ILWQ3Ku3GFnKsWZKavgrrpr1lomqCcIWGqsMOB1z84sxgsoHyJct83l/8OCrpAPPqMsbZQ3FFunl6WDhgrJByFoY4nF3TEzyxHq91zemf9mydn6O++4IKMM8kgKn/weMCThJ3UddjHEmuzVG13ALd8yVtyuGlMVQy5AWtaIJr5dLwcK+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:34:38.3797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea46941-ed40-4e3d-5f9a-08dec1a726a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058
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
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21714-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,vger.kernel.org:from_smtp,mellanox.com:email,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7DEC663AF35

Add devlink_eswitch_mode= command line support for setting a default
eswitch mode during device initialization.

The supported syntax selects either all devlink handles or one explicit
comma-separated handle list:

  devlink_eswitch_mode=[*]:<mode>
  devlink_eswitch_mode=[<handle>[,<handle>...]]:<mode>

where <mode> is one of legacy, switchdev or switchdev_inactive. All
selected handles receive the same mode. Assigning different modes to
different handle lists in the same parameter value is not supported.

The default is applied through the existing eswitch_mode_set() devlink
operation, matching the userspace devlink eswitch mode command. devlink
core applies it when a matching devlink instance is registered and after a
successful devlink reload that performed DRIVER_REINIT, so rebuilt device
state returns to the requested boot default.

Document the devlink_eswitch_mode= syntax and duplicate handle handling.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../admin-guide/kernel-parameters.txt         |  25 ++
 .../networking/devlink/devlink-defaults.rst   |  80 ++++++
 Documentation/networking/devlink/index.rst    |   1 +
 net/devlink/core.c                            | 261 ++++++++++++++++++
 net/devlink/dev.c                             |   3 +
 net/devlink/devl_internal.h                   |   1 +
 6 files changed, 371 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 063c11ca33e5..7af9f2898d92 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1264,6 +1264,31 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	devlink_eswitch_mode=
+			[NET]
+			Format:
+			[<selector>]:<mode>
+
+			<selector>:
+			* | <handle>[,<handle>...]
+
+			<handle>:
+			<bus-name>/<dev-name>
+
+			Configure default devlink eswitch mode for matching
+			devlink instances during device initialization.
+
+			<mode>:
+			legacy | switchdev | switchdev_inactive
+
+			Examples:
+			devlink_eswitch_mode=[*]:switchdev
+			devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
+			devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
+
+			See Documentation/networking/devlink/devlink-defaults.rst
+			for the full syntax.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
new file mode 100644
index 000000000000..b554e75eeeea
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-defaults.rst
@@ -0,0 +1,80 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Devlink Eswitch Mode Defaults
+==============================
+
+Devlink eswitch mode defaults allow the eswitch mode to be provided on the
+kernel command line and applied to matching devlink instances during device
+initialization.
+
+The devlink device is selected by its devlink handle. For PCI devices this is
+the same handle shown by ``devlink dev show``, for example
+``pci/0000:08:00.0``.
+
+Kernel command line syntax
+==========================
+
+Defaults are specified with the ``devlink_eswitch_mode=`` kernel command line
+parameter.
+
+The general syntax is::
+
+  devlink_eswitch_mode=[<selector>]:<mode>
+
+``<selector>`` is either ``*`` or one or more devlink handles::
+
+  * | <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
+
+``*`` applies the mode to every devlink instance. All handles in the same
+``[]`` list receive the same eswitch mode.
+
+``<mode>`` is one of ``legacy``, ``switchdev`` or ``switchdev_inactive``.
+
+Syntax rules
+------------
+
+The following syntax rules apply:
+
+* Specify the default in one ``devlink_eswitch_mode=`` parameter. Repeated
+  ``devlink_eswitch_mode=`` parameters are not accumulated.
+* The ``devlink_eswitch_mode=`` value is limited by the kernel command line
+  size.
+* Whitespace is not allowed within the parameter value.
+* ``<selector>`` must be either ``*`` or a handle list. ``*`` cannot be
+  combined with explicit handles.
+* ``<bus-name>`` and ``<dev-name>`` must not be empty.
+* ``<bus-name>`` must not contain ``:``.
+* ``<dev-name>`` may contain ``:``. This allows PCI names such as
+  ``0000:08:00.0``.
+* Handles must not contain whitespace, ``[``, ``]``, ``*`` or more than one
+  ``/``.
+* A comma inside ``[]`` separates handles.
+* Comma-separated default groups are not supported.
+* Duplicate handles are rejected and the devlink eswitch mode default is
+  ignored.
+
+The eswitch mode default corresponds to the userspace command::
+
+  devlink dev eswitch set <handle> mode <value>
+
+
+Examples
+========
+
+Set all devlink instances to switchdev mode::
+
+  devlink_eswitch_mode=[*]:switchdev
+
+Set one PCI devlink instance to switchdev mode::
+
+  devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev
+
+Set two PCI devlink instances to legacy mode::
+
+  devlink_eswitch_mode=[pci/0000:08:00.0,pci/0000:09:00.1]:legacy
+
+The following is invalid because comma-separated default groups are not
+supported::
+
+  devlink_eswitch_mode=[pci/0000:08:00.0]:switchdev,[pci/0000:09:00.0]:switchdev_inactive
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index f7ba7dcf477d..0d27a7008b14 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -56,6 +56,7 @@ general.
    :maxdepth: 1
 
    devlink-dpipe
+   devlink-defaults
    devlink-eswitch-attr
    devlink-flash
    devlink-health
diff --git a/net/devlink/core.c b/net/devlink/core.c
index eeb6a71f5f56..3e1b26459894 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -4,6 +4,10 @@
  * Copyright (c) 2016 Jiri Pirko <jiri@mellanox.com>
  */
 
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
 #include <net/genetlink.h>
 #define CREATE_TRACE_POINTS
 #include <trace/events/devlink.h>
@@ -16,6 +20,234 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
 DEFINE_XARRAY_FLAGS(devlinks, XA_FLAGS_ALLOC);
 
+static char *devlink_default_esw_mode_param;
+static bool devlink_default_esw_mode_match_all;
+static enum devlink_eswitch_mode devlink_default_esw_mode;
+static LIST_HEAD(devlink_default_esw_mode_nodes);
+
+struct devlink_default_esw_mode_node {
+	struct list_head list;
+	char *bus_name;
+	char *dev_name;
+};
+
+static int __init
+devlink_default_esw_mode_to_value(const char *str,
+				  enum devlink_eswitch_mode *mode)
+{
+	if (!strcmp(str, "legacy")) {
+		*mode = DEVLINK_ESWITCH_MODE_LEGACY;
+		return 0;
+	}
+	if (!strcmp(str, "switchdev")) {
+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV;
+		return 0;
+	}
+	if (!strcmp(str, "switchdev_inactive")) {
+		*mode = DEVLINK_ESWITCH_MODE_SWITCHDEV_INACTIVE;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int __init
+devlink_default_esw_mode_handle_parse(char *handle, char **bus_name,
+				      char **dev_name)
+{
+	char *slash;
+	char *p;
+
+	if (!handle || !*handle)
+		return -EINVAL;
+
+	for (p = handle; *p; p++) {
+		if (*p == '[' || *p == ']' || *p == '*')
+			return -EINVAL;
+	}
+
+	slash = strchr(handle, '/');
+	if (!slash || slash == handle || !slash[1])
+		return -EINVAL;
+	if (strchr(slash + 1, '/'))
+		return -EINVAL;
+
+	*slash = '\0';
+	if (strchr(handle, ':'))
+		return -EINVAL;
+
+	*bus_name = handle;
+	*dev_name = slash + 1;
+	return 0;
+}
+
+static struct devlink_default_esw_mode_node *
+devlink_default_esw_mode_node_find(const char *bus_name, const char *dev_name)
+{
+	struct devlink_default_esw_mode_node *node;
+
+	list_for_each_entry(node, &devlink_default_esw_mode_nodes, list) {
+		if (!strcmp(node->bus_name, bus_name) &&
+		    !strcmp(node->dev_name, dev_name))
+			return node;
+	}
+
+	return NULL;
+}
+
+static int __init
+devlink_default_esw_mode_node_add(const char *bus_name, const char *dev_name)
+{
+	struct devlink_default_esw_mode_node *node;
+
+	if (devlink_default_esw_mode_node_find(bus_name, dev_name))
+		return -EEXIST;
+
+	node = kzalloc_obj(*node);
+	if (!node)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&node->list);
+	node->bus_name = kstrdup(bus_name, GFP_KERNEL);
+	node->dev_name = kstrdup(dev_name, GFP_KERNEL);
+	if (!node->bus_name || !node->dev_name) {
+		kfree(node->bus_name);
+		kfree(node->dev_name);
+		kfree(node);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&node->list, &devlink_default_esw_mode_nodes);
+	return 0;
+}
+
+static int __init devlink_default_esw_mode_handles_parse(char *handles)
+{
+	char *handle;
+	int err;
+
+	if (!strcmp(handles, "*")) {
+		devlink_default_esw_mode_match_all = true;
+		return 0;
+	}
+
+	while ((handle = strsep(&handles, ",")) != NULL) {
+		char *bus_name;
+		char *dev_name;
+
+		err = devlink_default_esw_mode_handle_parse(handle, &bus_name,
+							    &dev_name);
+		if (err)
+			return err;
+
+		err = devlink_default_esw_mode_node_add(bus_name, dev_name);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void __init
+devlink_default_esw_mode_node_free(struct devlink_default_esw_mode_node *node)
+{
+	kfree(node->bus_name);
+	kfree(node->dev_name);
+	kfree(node);
+}
+
+static void __init devlink_default_esw_mode_nodes_clear(void)
+{
+	struct devlink_default_esw_mode_node *node;
+	struct devlink_default_esw_mode_node *node_tmp;
+
+	list_for_each_entry_safe(node, node_tmp,
+				 &devlink_default_esw_mode_nodes, list) {
+		list_del(&node->list);
+		devlink_default_esw_mode_node_free(node);
+	}
+
+	devlink_default_esw_mode_match_all = false;
+}
+
+static int __init devlink_default_esw_mode_parse(char *str)
+{
+	char *handles_end;
+	char *handles;
+	char *mode;
+	enum devlink_eswitch_mode esw_mode;
+	int err;
+
+	if (!str || *str != '[')
+		return -EINVAL;
+
+	handles = str + 1;
+	handles_end = strchr(handles, ']');
+	if (!handles_end || handles_end[1] != ':' || !handles_end[2])
+		return -EINVAL;
+
+	*handles_end = '\0';
+	mode = handles_end + 2;
+	if (!*handles)
+		return -EINVAL;
+
+	err = devlink_default_esw_mode_to_value(mode, &esw_mode);
+	if (err)
+		return err;
+
+	err = devlink_default_esw_mode_handles_parse(handles);
+	if (err)
+		devlink_default_esw_mode_nodes_clear();
+	else
+		devlink_default_esw_mode = esw_mode;
+
+	return err;
+}
+
+static bool devlink_default_esw_mode_match(struct devlink *devlink)
+{
+	const char *bus_name = devlink_bus_name(devlink);
+	const char *dev_name = devlink_dev_name(devlink);
+	struct devlink_default_esw_mode_node *node;
+
+	if (devlink_default_esw_mode_match_all)
+		return true;
+
+	node = devlink_default_esw_mode_node_find(bus_name, dev_name);
+	return !!node;
+}
+
+void devlink_apply_default_esw_mode(struct devlink *devlink)
+{
+	const struct devlink_ops *ops = devlink->ops;
+	int err;
+
+	devl_assert_locked(devlink);
+
+	if (!devlink_default_esw_mode_match(devlink))
+		return;
+
+	if (!ops->eswitch_mode_set) {
+		if (!devlink_default_esw_mode_match_all)
+			devl_warn(devlink,
+				  "devlink_eswitch_mode= selected this device but eswitch mode setting is not supported\n");
+		return;
+	}
+
+	err = ops->eswitch_mode_set(devlink, devlink_default_esw_mode, NULL);
+	if (err)
+		devl_warn(devlink,
+			  "Couldn't apply default eswitch mode, err %d\n",
+			  err);
+}
+
+static int __init devlink_default_esw_mode_setup(char *str)
+{
+	devlink_default_esw_mode_param = str;
+	return 1;
+}
+__setup("devlink_eswitch_mode=", devlink_default_esw_mode_setup);
+
 static struct devlink *devlinks_xa_get(unsigned long index)
 {
 	struct devlink *devlink;
@@ -391,6 +623,7 @@ int devl_register(struct devlink *devlink)
 	xa_set_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 	devlink_notify_register(devlink);
 	devlink_rel_nested_in_notify(devlink);
+	devlink_apply_default_esw_mode(devlink);
 
 	return 0;
 }
@@ -578,6 +811,31 @@ static int __init devlink_init(void)
 {
 	int err;
 
+	if (devlink_default_esw_mode_param) {
+		char *def;
+
+		def = kstrdup(devlink_default_esw_mode_param, GFP_KERNEL);
+		if (!def) {
+			devlink_default_esw_mode_param = NULL;
+			pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
+		} else {
+			err = devlink_default_esw_mode_parse(def);
+			kfree(def);
+			if (err == -EEXIST) {
+				devlink_default_esw_mode_param = NULL;
+				pr_warn("devlink: duplicate eswitch mode handles ignored\n");
+			} else if (err == -EINVAL) {
+				devlink_default_esw_mode_param = NULL;
+				pr_warn("devlink: invalid devlink_eswitch_mode parameter ignored\n");
+			} else if (err == -ENOMEM) {
+				devlink_default_esw_mode_param = NULL;
+				pr_warn("devlink: devlink_eswitch_mode parameter ignored, failed to allocate memory\n");
+			} else if (err) {
+				goto out;
+			}
+		}
+	}
+
 	err = register_pernet_subsys(&devlink_pernet_ops);
 	if (err)
 		goto out;
@@ -593,7 +851,10 @@ static int __init devlink_init(void)
 out_unreg_pernet_subsys:
 	unregister_pernet_subsys(&devlink_pernet_ops);
 out:
+	if (err)
+		devlink_default_esw_mode_nodes_clear();
 	WARN_ON(err);
+
 	return err;
 }
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 57b2b8f03543..0b4a831465e8 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -478,6 +478,9 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
 		return err;
 
 	WARN_ON(!(*actions_performed & BIT(action)));
+	if (*actions_performed & BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT))
+		devlink_apply_default_esw_mode(devlink);
+
 	/* Catch driver on updating the remote action within devlink reload */
 	WARN_ON(memcmp(remote_reload_stats, devlink->stats.remote_reload_stats,
 		       sizeof(remote_reload_stats)));
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index e4e48ee2da5a..12557b65248d 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -71,6 +71,7 @@ extern struct genl_family devlink_nl_family;
 struct devlink *__devlink_alloc(const struct devlink_ops *ops, size_t priv_size,
 				struct net *net, struct device *dev,
 				const struct device_driver *dev_driver);
+void devlink_apply_default_esw_mode(struct devlink *devlink);
 
 #define devl_warn(devlink, format, args...)				\
 	do {								\
-- 
2.34.1


