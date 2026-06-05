Return-Path: <linux-rdma+bounces-21871-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WdPIOYgTI2r5hgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21871-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:20:56 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ACE64A89C
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:20:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=HkkOLpZg;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21871-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21871-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A808330B8ABC
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21CF3AB5DE;
	Fri,  5 Jun 2026 18:12:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011046.outbound.protection.outlook.com [40.107.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4035C395AC3;
	Fri,  5 Jun 2026 18:12:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683134; cv=fail; b=DONzIEsLfpuUmJoAeDm+r98O1x+kE5+tQ163mHAlx+XvKOBDQksa53dJTHUP+4rL9h+Fsay5bKrEcbi37qHiB4VOCWgoL6DnLIT3zShZqM39tP01uuurh4Fmgxe4jyzD4rXwg0QRQfXaFq2B6YH+7Ow76T+sPapljQngNCm0Sw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683134; c=relaxed/simple;
	bh=xfmACm1RZsUSCZFNS8mEME9DwwzvpwbEPSrIxchAZ8g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRoKab3bwxSsKK9Q9irlEzZzxAzb5txYIc/3rPpk7qD3XOpSpCkHkhuqmkeuou7b6abP1T8UCD7/56PsvQLMEqp9ZMgLY9rRVJKKajd0UedFBDpdG2BFbWXFxNwVLRr5vSdK/+1DuxROfwbPULs2BZNQgwZd8CjenCTzljamvRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HkkOLpZg; arc=fail smtp.client-ip=40.107.208.46
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuKMUSWynStrZqORPBwivId5ERKwleaQranzkIYaAgFgf3TNa1yMPyH4dOn+KHqjrZvzZ5nbwFr37nsaej0MZeyqm8Csnr8h814Rxh24TnbVk4j8YN9zJr8N1OkWM6fAt+gEyVzdq2ZuQOHKyy23mzfr9wspSr+d2YhuDVYpm0+Uu8JjpCeAmaY03s8jatRpI4cnooOOHqps1HVrqgLBNAubPPlQwdpyOqkVAGmfFllIQjmm6sw7OTNmS/diduWzJe5l2/K8LBINWQLOl/mTBP8ZMH/arSLRrsoZlKqAvFe9b7KgFXXHB9TI3ZMO9WNrUE/mnkIDJZdCXa5vVVJq3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6uANJwq7UzYn46uElqY16M7kKYTuhGkMi/D7p/Bw/c=;
 b=tpnfcf4wefzmyLqhhrVfqS8E0a3RUVj8kVl8iM343+Bb8I7/Muwe6V9Zz8edjfRNa6IWeGPqIBJo1Alass+SocI5urXzC+Wkymx/K9c7sMilrjOjiXnj+xilpS21PKmcRKAccchtAjGaE7Tvv6EYCdxLuCCZQKhXiN69lZjmHu2TmeppASCLjFK/C8WC5fnrxhRSjm3AMu/6ACrqSlfO8HXsIm9nQX8AWW6aG14LFWmSXS1NoKdo4xpiUEO0OUVB/euXLAOad2l6EG9gcFgSA233eqoFWx7E/uv731A1wOk7e/uQO42a2kqu2XPsod04BgVTpAZeQpoaxzhiM1wAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6uANJwq7UzYn46uElqY16M7kKYTuhGkMi/D7p/Bw/c=;
 b=HkkOLpZg+LRq43Sgylv+qsxrxPFPu+8i845IF99rQmcA54z2PtZCgTLrqX0d6Mbim3xYvx8XdjHKlbX+pkB7Le7pbCFdvv9ffot/f5b7P72OQiYH+jnaPsUiMjqfJ5oqXI2mcw82kvUQNOA/abT7eNkWWbW6S97PvxB1HCXFnWGPgXheEenGCB9HIb7HRqC/bVqibLrqw4yn09HzVNQWJzbC619Qz+n3LahxEUR7+ehfQvjIi7n+2ZxgTYLbyy0No2qkh3+slAqU9fYg42EozuYVJeV1F9t+ZMLcld5uXKC0VHHD0RjuhPoXtRpI3gN2f7CMPkTwUX8901iNwuQy/w==
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:12:02 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::f) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:12:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:11:46 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:11:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:11:37 -0700
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
Subject: [PATCH net-next V3 7/7] devlink: Add eswitch mode boot defaults
Date: Fri, 5 Jun 2026 21:10:30 +0300
Message-ID: <20260605181030.3486619-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605181030.3486619-1-mbloch@nvidia.com>
References: <20260605181030.3486619-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 60d1fc0b-5b6a-45e4-b6c2-08dec32df089
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|7416014|1800799024|22082099003|18002099003|6133799003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	H9PVqLzEVRJaWI0ulDtiJwKyseXFbheuY/WmXqkrmyfoQh17uZ0W/zDqNYbudknYpVsDZxEvuM3dUpDf4Pvez5SSg4eq/adhM1ZvrQhRSGg34Xir6n756Oc+zX4Jsp3JF283Zl5zJL2evg6vztEE5U8KGS16h7pDjVfUtUEhKiUc64odVjaAd/GzRQruV0nURFCod/GwsMDQUTfxQxwgzmhGQD3F+ruUQDjQcYmemz9k3gZZrvcf/az6qFmQgaGTffuYsm1pZUNvWSPW9w5gNTOXvkJ958dFH8q8s6HRZ/BGEO5mc/1xwROZ7+0Abu5bD1ovUO6pRL38O4/UhLvZGTqBga4EExPlCo3S2pGlHDsoYR4Zdva+182TZOTzSfButqo0taF8x053tXNlpBnHoG6VP/phr6E4kKcL4A2OgyUVGBIsCD4M/qtyv2dIMmvROVbSSUAmep1tWWRbbs0Ok5eDt+FD+9ieaXlnHiugMSe5/3fhmRr0julubyLtstSvwdC5vgkQmuDmUE2a3Klq5hnIHyTzQFjl97fougR46rK9UUGK2XZv+Z+PFuWdMdXSkR928SS9dLdbvER69xl2Zr0cAmxOGfz8OyMR9wvkc0UM0d8KeIvcCTw9QlUhbyPiMVQSX3nNOWpsG1CzVwTeyQFax6En/t0K96DYJ/PcY88HheRrxrwycFWtqN5LynBxl09dFSFO+DEWROvEZyf4WcaGNOQszfY3n0C0W/P1Ny0=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B11b0Ef/bg6YSj0iB23a08JnHI2oqnuvgjkRMmGFlyKh8AbbB0SGthW9l93cODe2Y3eSdsztHhga1doS9FT+Xv16h10t0yeMwG/jDQXb49zUfQ3xf4JkYaFK1zfBwwhk+lkQtiEy1Z1mMzeA6WlRuVHzheMiYhnQlpO5hZ28n8N29hdZHk9Bq8+fH+DHXJ5hcdrbHqgljV/dBm15lK3+ITfjKjoGUM7ad0i13kDq+aU66uL5HCYlusgxYQ02HLe1QN/8ggXNL+LWaPDN/fAibWujKCzBQM3zGkw9jVtuV36rUOc8rJWIlqNm2XjCiimKcn1HdXWxSM3TpXC94Ls4uzycijv+JIOtZQSbMOJ6xwIdMGWBLuFsk6xevXN2l9YFXsLNxLDSsMpXmV6cwQFP8Q93MjO9IRXfS5Ya8TArGzrOqQVYKeFDDhSgXOORHBpF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:12:00.8603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d1fc0b-5b6a-45e4-b6c2-08dec32df089
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21871-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,Nvidia.com:dkim,mellanox.com:email];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 46ACE64A89C

Add devlink_eswitch_mode= command line support for setting a default
eswitch mode during device initialization.

The supported syntax selects either all devlink handles or one
explicit comma-separated handle list:

  devlink_eswitch_mode=*=<mode>
  devlink_eswitch_mode=<handle>[,<handle>...]=<mode>

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
 .../networking/devlink/devlink-defaults.rst   |  78 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 net/devlink/core.c                            | 271 ++++++++++++++++++
 net/devlink/dev.c                             |   3 +
 net/devlink/devl_internal.h                   |   1 +
 6 files changed, 379 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-defaults.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b3fdbbe3b3cc..b4fcc7f81166 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1246,6 +1246,31 @@ Kernel parameters
 	dell_smm_hwmon.fan_max=
 			[HW] Maximum configurable fan speed.
 
+	devlink_eswitch_mode=
+			[NET]
+			Format:
+			<selector>=<mode>
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
+			devlink_eswitch_mode=*=switchdev
+			devlink_eswitch_mode=pci/0000:08:00.0=switchdev
+			devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
+
+			See Documentation/networking/devlink/devlink-defaults.rst
+			for the full syntax.
+
 	dfltcc=		[HW,S390]
 			Format: { on | off | def_only | inf_only | always }
 			on:       s390 zlib hardware support for compression on
diff --git a/Documentation/networking/devlink/devlink-defaults.rst b/Documentation/networking/devlink/devlink-defaults.rst
new file mode 100644
index 000000000000..380c9e99210e
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-defaults.rst
@@ -0,0 +1,78 @@
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
+  devlink_eswitch_mode=<selector>=<mode>
+
+``<selector>`` is either ``*`` or one or more devlink handles::
+
+  * | <bus-name>/<dev-name>[,<bus-name>/<dev-name>...]
+
+``*`` applies the mode to every devlink instance. All handles in the same
+selector receive the same eswitch mode.
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
+* ``<dev-name>`` may contain ``:``. This allows PCI names such as
+  ``0000:08:00.0``.
+* Handles must not contain whitespace, ``*``, ``=`` or more than one ``/``.
+* A comma separates handles.
+* Comma-separated default assignments are not supported.
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
+  devlink_eswitch_mode=*=switchdev
+
+Set one PCI devlink instance to switchdev mode::
+
+  devlink_eswitch_mode=pci/0000:08:00.0=switchdev
+
+Set two PCI devlink instances to switchdev inactive mode::
+
+  devlink_eswitch_mode=pci/0000:08:00.0,pci/0000:09:00.1=switchdev_inactive
+
+The following is invalid because comma-separated default assignments are not
+supported::
+
+  devlink_eswitch_mode=pci/0000:08:00.0=switchdev,pci/0000:09:00.0=switchdev_inactive
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
index fe9f6a0a67d5..2111bffb628f 100644
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
@@ -16,6 +20,230 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(devlink_trap_report);
 
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
+	if (!*handle)
+		return -EINVAL;
+
+	for (p = handle; *p; p++) {
+		if (*p == '*' || *p == '=')
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
+	char *handles;
+	char *separator;
+	char *mode;
+	enum devlink_eswitch_mode esw_mode;
+	int err;
+
+	if (!*str)
+		return -EINVAL;
+
+	separator = strrchr(str, '=');
+	if (!separator || separator == str || !separator[1])
+		return -EINVAL;
+
+	*separator = '\0';
+	handles = str;
+	mode = separator + 1;
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
@@ -382,6 +610,20 @@ struct devlink *devlinks_xa_lookup_get(struct net *net, unsigned long index)
 /**
  * devl_register - Register devlink instance
  * @devlink: devlink
+ *
+ * Make @devlink visible to userspace. Drivers must call this only after the
+ * instance is fully initialized and its devlink operations can be called.
+ *
+ * If a matching devlink_eswitch_mode= default was provided on the kernel
+ * command line, devlink core applies it before devl_register() returns.
+ * Drivers implementing eswitch_mode_set() must therefore be ready to perform
+ * the same work as a userspace eswitch mode set request from this point,
+ * including creation of representors and other eswitch state.
+ *
+ * Context: Caller must hold the devlink instance lock. Use devlink_register()
+ * when the lock is not already held.
+ *
+ * Return: 0 on success.
  */
 int devl_register(struct devlink *devlink)
 {
@@ -391,6 +633,7 @@ int devl_register(struct devlink *devlink)
 	xa_set_mark(&devlinks, devlink->index, DEVLINK_REGISTERED);
 	devlink_notify_register(devlink);
 	devlink_rel_nested_in_notify(devlink);
+	devlink_apply_default_esw_mode(devlink);
 
 	return 0;
 }
@@ -580,6 +823,31 @@ static int __init devlink_init(void)
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
@@ -595,7 +863,10 @@ static int __init devlink_init(void)
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


