Return-Path: <linux-rdma+bounces-21711-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xIhFEE6DIGow4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21711-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:41:02 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E93CF63AECF
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:41:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mJvCVsZV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21711-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21711-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C6CC305FBAB
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79A73F4134;
	Wed,  3 Jun 2026 19:34:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232BF48C3EE;
	Wed,  3 Jun 2026 19:34:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515264; cv=fail; b=WZ8zFI32Qm4YIIEZIZ5IQB2XvImfxoQgZOrEpfyc5flLKFlS41MhJuODGXG46u3/1aGWDpcao10X4sWlqXuTNg2SlVb3zkPFvWmG/THz5vESIqXiH/oa0Ucy3Foocz2i01RHXeTYp6tv4/+6kn8ShK2x2c3Suq7PmEen0CvEcAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515264; c=relaxed/simple;
	bh=RN65OY02mpeMdw2wxqvPBOlusAFxX1I22MIU9jK28Bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDwnPDvnXlBLqsj/NFJRdieFBvoScsFy9vYVPgaS8Dz5JGuSRNRBlH4J5zwdEZdH37lOUBEHA4NQ77pKbz+uZHlHpl75uiLcTH2Uq+kehmfnzP8Od5suYujNKfh9Gs+V2RfB9mdV00bygKEPH44Cm0rEbxBxlbuRFp0b4HL4nvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mJvCVsZV; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKbM/FOkWdcDEQsY7lPSa7buNUbm0vouDFUxDurivqRZMwfAJLQRThpBTiKbOPAb0i3lE8wKwRSWMgq6dx/g5yo+tNf9LaIiOpVhxmhn1oG6eb1aMQ8ThynRRZLMKLRysvzLZ2pzfuvBpQEmZ0uRSdKHoG6fzxh5J7qFSKlDOlR1AZNt8ZciNXaNNGlw5fiuFYpEegk9rfT+Fqtsd5tjaYjFuSaA4EcJQqqZ/GXdCamMmsoGTT80pJmg9iH9hj+jwz55YyUSm9LNtRYsx4YI24V8aoVrQP/kAd+MJ0BnrKlf4OD0g2hBEkPceStfe+eKcIQhPLziK+1C/qXfEVf1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EcDVjXvMslhxg5WvUNRPiUdDDUNtWachhUPQFetDR0=;
 b=iivY0hIFiiOxHHeu1sCZmFW8G5MJgJD8WxopmbVHbwcJzAYmM8ZGKYo8fAEnlyvsrW4jbgmx+CpwhGP+r4yPseC77JP4OM+oJCwFXMgBCGK3/xcQdxcLyEVmjAPGGuT2mxNoG9QrFOcZomHiGbCwHUfOB3ovlb8utkw2yQrOzPENDdVzev2kWsJcRSrQNcosey7NV3RK3nWkqKMciXDvQ2KmoNgtpGvQNe6l2u4+x8cZsosRdhMjrJMmmiRqG02UON17rSCPAvO+9SswSNTMrrKSbz6bG2n75JQ3y6PU6bWF0VPtbLThF73V+e6On8YpV7WEUPtEcOTTkG3pLT3juQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EcDVjXvMslhxg5WvUNRPiUdDDUNtWachhUPQFetDR0=;
 b=mJvCVsZVNoXrzUexi5E3Zq7/yCjrtEq8uH078uxRJk1P/WVw6I7ozm9oi7dA/wFEWlspsLYeWqPfM7XrojT0CceC9RR52HSxLd5ZcWV57za0kkvJYNLHEKq9//K9V9LU2U4ziEVZILw5WHKL6shodG+OUywMRz5166sOtWZlzDTGA2+IOFyZIhaa54cbz+BDTGA2ZeDHSvD1ivskt51/3bB2GrkeU44BgDWhWM/Ow63irE0YUsZjkRVOZ51KU2Wx3ig1FflYtAdsyv/GuoRJlhwDnU1XN9K1i1732L2Iet7D0MoXin6o5meFWc8EPmOys5UAosawiqk9C/wHxXAXlQ==
Received: from SJ0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:33a::24)
 by BN7PPFABD533732.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6df) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:34:09 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::16) by SJ0PR03CA0019.outlook.office365.com
 (2603:10b6:a03:33a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:34:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:34:08 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:33:48 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 3 Jun 2026 12:33:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 12:33:39 -0700
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
	<linux-rdma@vger.kernel.org>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next V2 4/7] net/mlx5: Register devlink after device init
Date: Wed, 3 Jun 2026 22:32:56 +0300
Message-ID: <20260603193259.3412464-5-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|BN7PPFABD533732:EE_
X-MS-Office365-Filtering-Correlation-Id: 07584d26-6f0d-47c4-e333-08dec1a714d2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|82310400026|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	ep+rkXXe/y7ee7/4zYh+NELIWmlz3ffjY6t6bzk8B59VxFu7uUmSA78tEJ7gurB3FxRRcTVYMfL/aBO14km+7IQJSnv22vcEyghxYrdDE2YHfiABSSJea98nfXdh/Uq+lzSQeyYFTcZtDO3y5EtvkEJn5Jq0wDkVF/m5sOA2JjG/YCH6NtCKAEYdJ0WW1/vmFDX9FGZ8DiDUdKok8MJgmXfxqqd4fBo6rzG+ctFiojVJh+eWlqD0ZYppIVIFT8+VRKp0NN9J/7zOkC/vLzPyoyI1iIZNtoGFQ4hEuxVB92gEugfQLL1Jx+EiOyBstIBjki4CuOiQlqWzqturgi1tRb4w6A7NchkR5P8+A7+UJLHttkvN+mPufMob7UekL5H3njqVEoG5/oPUa5cpKQkFTJ5YTAr+8M+AxDvgD6kyamOf+uBVr1Z/NUE/10b2P/YXt29Lo2+JKrGaRIichhCNu7FIrFYyLmWMO1JWQzJtxuIpgua5/qhKqV2hgeeQdPk2Tv9VmON211Bmd40j9CcAprAbti4CvyzUJihLJrk2uxanwMaxFlLFDmtr0uF1IlJELAHeP6HFxfMAVO1ZS0MFK2Bu/AIApaD19vZ7RZVpdKOnWet23MkoUH3EQgCGg4IOo4TqjHGKul5zPxrxZ3DIc5B2FpsjHsuIJN/X2YLcQPkU/0NV3VPd5wWXcPqknxqhRCu4rQfEB09AMnhsfCK14D+Hw/Lc3DMkKiZxyHerr1k=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(82310400026)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BVxlnWBqlXQzMXuOS1BGEWRIMqLK9yOWFICN/HSG929bQ0fnYh+TkpQUhpXr3M3Aan+/wU6XXTtY1XVXxcyd8x7dokTDR8FFsAwmok9ZsnT7+Rh4OCM490TuqzOhZDsjWo8JP8XgWIf7vEcvJEN3uTZQQgo03OGjK9ek10rlkjNfYzREjGFU1vy393mTXitzuNDDKTpxwOTpYw0yaEgsQ6YHft6Kz6cBUadyJ3p5KOa5qN+S/L8uvwaZ9V5wAW0lZ/t36kLLusfH8vZXwHBa3xaCfTyAttzI3zGBcQRV551/8eZwDygIbCTGjKtTYzkjd+XQrLKR4MMYftq1kIypffyw5fxkkmmWiflhglv6m/6YPMT52VKGhhMx8HquQ0uxbxfhtDqNOJlVg7lDEf5VVM9QmsY/4Fd180IROH7seygjdmRB7vfw7nF43UsWN5rd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:34:08.5582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07584d26-6f0d-47c4-e333-08dec1a714d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFABD533732
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
	RCPT_COUNT_TWELVE(0.00)[42];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shayd@nvidia.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21711-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E93CF63AECF

devl_register() makes the devlink instance visible to userspace. A later
patch also makes registration the point where devlink core may call
eswitch_mode_set() to apply a boot-time default eswitch mode.

Move mlx5 devlink registration after mlx5 device initialization completes,
including the lightweight init path, so registration-time devlink
operations see initialized driver state.

Move devl_unregister() before the matching teardown paths, so unregister
notifications are emitted from devl_unregister() before mlx5 removes the
devlink objects.

Add a devl-locked uninit helper so failed nested devlink setup can unwind
the initialized device before the instance is registered.

Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0c6e4efe38c8..ab3d3ff10f1a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1455,31 +1455,40 @@ int mlx5_init_one_devl_locked(struct mlx5_core_dev *dev)
 	return err;
 }
 
+static void mlx5_uninit_one_devl_locked(struct mlx5_core_dev *dev);
+
 int mlx5_init_one(struct mlx5_core_dev *dev)
 {
 	struct devlink *devlink = priv_to_devlink(dev);
 	int err;
 
 	devl_lock(devlink);
+	err = mlx5_init_one_devl_locked(dev);
+	if (err)
+		goto unlock;
+
 	if (dev->shd) {
 		err = devl_nested_devlink_set(dev->shd, devlink);
 		if (err)
-			goto unlock;
+			goto err_uninit;
 	}
+
 	devl_register(devlink);
-	err = mlx5_init_one_devl_locked(dev);
-	if (err)
-		devl_unregister(devlink);
+	devl_unlock(devlink);
+	return 0;
+
+err_uninit:
+	mlx5_uninit_one_devl_locked(dev);
 unlock:
 	devl_unlock(devlink);
 	return err;
 }
 
-void mlx5_uninit_one(struct mlx5_core_dev *dev)
+static void mlx5_uninit_one_devl_locked(struct mlx5_core_dev *dev)
 {
 	struct devlink *devlink = priv_to_devlink(dev);
 
-	devl_lock(devlink);
+	devl_assert_locked(devlink);
 	mutex_lock(&dev->intf_state_mutex);
 
 	mlx5_hwmon_dev_unregister(dev);
@@ -1501,7 +1510,15 @@ void mlx5_uninit_one(struct mlx5_core_dev *dev)
 	mlx5_function_teardown(dev, true);
 out:
 	mutex_unlock(&dev->intf_state_mutex);
+}
+
+void mlx5_uninit_one(struct mlx5_core_dev *dev)
+{
+	struct devlink *devlink = priv_to_devlink(dev);
+
+	devl_lock(devlink);
 	devl_unregister(devlink);
+	mlx5_uninit_one_devl_locked(dev);
 	devl_unlock(devlink);
 }
 
@@ -1635,7 +1652,6 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	int err;
 
 	devl_lock(devlink);
-	devl_register(devlink);
 	dev->state = MLX5_DEVICE_STATE_UP;
 	err = mlx5_function_enable(dev, true, mlx5_tout_ms(dev, FW_PRE_INIT_TIMEOUT));
 	if (err) {
@@ -1655,6 +1671,7 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 		goto query_hca_caps_err;
 	}
 
+	devl_register(devlink);
 	devl_unlock(devlink);
 	return 0;
 
@@ -1662,7 +1679,6 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	mlx5_function_disable(dev, true);
 out:
 	dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
-	devl_unregister(devlink);
 	devl_unlock(devlink);
 	return err;
 }
@@ -1672,8 +1688,8 @@ void mlx5_uninit_one_light(struct mlx5_core_dev *dev)
 	struct devlink *devlink = priv_to_devlink(dev);
 
 	devl_lock(devlink);
-	mlx5_devlink_params_unregister(priv_to_devlink(dev));
 	devl_unregister(devlink);
+	mlx5_devlink_params_unregister(priv_to_devlink(dev));
 	devl_unlock(devlink);
 	if (dev->state != MLX5_DEVICE_STATE_UP)
 		return;
-- 
2.34.1


