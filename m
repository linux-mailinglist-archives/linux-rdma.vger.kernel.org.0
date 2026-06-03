Return-Path: <linux-rdma+bounces-21708-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id snjABsiCIGoW4gAAu9opvQ
	(envelope-from <linux-rdma+bounces-21708-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:38:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F0D63AE94
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 21:38:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=KlZiu2vJ;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21708-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21708-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942763053DD0
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 19:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE28348C3EE;
	Wed,  3 Jun 2026 19:33:51 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013011.outbound.protection.outlook.com [40.93.196.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEB648BD55;
	Wed,  3 Jun 2026 19:33:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515231; cv=fail; b=U1Bo26rRZ637pIfateP46Rb2fWXQY8QvmGV+3A82O02bvKoNEJ5KxyU3Ic8YNSc/WbHvnVViUG1KU8IXhDxM56aqOatHWp/6feFa0sTQHT/SZ0nZdR0LR/PzHnb5XXV+bBO8iwfM+EHMX7akzFFOfn1IVU9g1FAmKGa7SVzqQao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515231; c=relaxed/simple;
	bh=MM1MmyW0dYPnybWKo7radMlVV6O+t6JBI7aY2SuJPjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yre2UzDnur04ni0Em5Q+SN230I/mz6G9vJAppNvnP8MuAUyHknuOjZd11B2pgshrv51ZIRTbV3rKDULOUXz3ENcrp95RhyhX+bXZZFX6pPFU/oNx9CYE12T0HP+BdKNi2fk5W7ymhVnFxJEUI+6gUsDdccnSWd3kAILqLzKY6Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KlZiu2vJ; arc=fail smtp.client-ip=40.93.196.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbZjrVYQ1dE4bnNpeZvE8ivW9pBgmbmg36t2XALXvXk1PM/aV9J5Jp+TbCdewbGmOepEz9BCSWbDOvg9ZiKyuyHAO9Jk6U7IoBXri/gHPN3npS145ruyxrrvFHsIRLTrdFgwFNyg6hIhdg+S6aTcJp39kjaZKpkhHvXCt+d4wznIx/3gtk+gzLu/DFjGhWefYgoiMvKN1qTMnAHuQTIav716lSBIRVOMPZOuqMptTyqoZEpQFm2j+21b+77ly4/fMBEs0V0O6plMkY+8WieOSd4dkBrSjwx8G9vlLRpa3sPwDVB4undSBlmw+9HRXbRxazA5l38STwAwq38GPtdjig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yomO51Io6x9hIuebKmWNm/orJxluJvySdJo2MQRa4N0=;
 b=ViXuKSTlVRBhz38cLQVbBtbZw7MjfWHxVRTQKef0imvRpFTeRf/ZTPsyyN7OA0Vat10Ypz5ZDYzD1iemRc2dS6HTGoRAA5E30PJ/BdiI4QRATVJRLOIkcxd9gNmo0f6jPo0d12wb7NLVVK5xbctyx78kJj13ueZRnJMtM/onbNr4hGwkCwDCxzFkuLFEt8WAu85aJSeuW2oLU0OkioATWZoVJ1yhK7pLgApGwi/KtAiuso29OcOj1Q/DiU5T/u2njEI6ge3LyR92bBVi4LTVpIfKUrGVZhI+JhP7IEkf/JK3jvx1J6qIUH0goRasnF4XvOOPmk/WjczHJLoY4EfUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yomO51Io6x9hIuebKmWNm/orJxluJvySdJo2MQRa4N0=;
 b=KlZiu2vJW3OCKHlSD6E0H/lHnM32NAKhsbvL0nGlNUAbtyiH83pCn2QnltRASSngHBFB4NLeEb2xoyWNqy7iS48BtOaeGpW9UaLOCYyOUjnXw3KpVTCOWEfhaAoBuSaDCPDAjD/dw6VZUSnzRX0Ex10DgE5xJya98pnNq0pej9ZLnIAXdaCDFJIJW7CCwwG7uU7Rd+aPsU/QI5K0RvxS4WR/ndxq1Rx+hmEmUs8tYrroFxuLYL3hCsQisapQQe5V7rNaaSt+sRKmDlhHrtAeDLLMlLe2WriNb69NE58CPdGQH50DSfScxOr6gzVy8nmxshriZ9LZZUee7JO+owIUOw==
Received: from BN9PR03CA0914.namprd03.prod.outlook.com (2603:10b6:408:107::19)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 19:33:34 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:107:cafe::24) by BN9PR03CA0914.outlook.office365.com
 (2603:10b6:408:107::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 19:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 19:33:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 3 Jun
 2026 12:33:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 3 Jun 2026 12:33:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 3 Jun 2026 12:33:10 -0700
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
Subject: [PATCH net-next V2 1/7] devlink: Skip health recover notifications before register
Date: Wed, 3 Jun 2026 22:32:53 +0300
Message-ID: <20260603193259.3412464-2-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: bae679e8-c2c3-45a8-c8dc-08dec1a7005f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ddFwEiVnwTRM5I++4ui5Buaau1e6yDCbSd2wMhaep/3EtFdBvnnA2Bf0uzTabIIfH6n7US0pzhXOt3vkACh8sqrCO7NnJzlauAF94+CHncKuGeFdN9g92AH3mlR0Ocs90lrREl5Ywdiy2d5YaU2XUn9k5y6KFiglnHxAfJj+jz+SderCBh96RUHf5eV4Zx48+VbMwxXmj+xvRMcSSPBfGn8yXzJaCPEk3FeeAmGOTC/Cj8kJ6ypLLuFO/4D5yZUj2auSfmzw2BaJAqwpeSnp867tJevu2deCT1ZvxSz5bDY/P5LzxX4Z0ekbNtgxfMlkvqdZHdxB8YF7ttn33PsK6uqSfmQOTlgDMZer9YePxtxCzNtW0TqhsYuBw8hArp0gTyyzBooxnQByzWVw7X47APMt9ZiVrQsyXRiKH5haZj7iwiNILRCuCv6ld+PxozcYH80j/CDnlhUW5SXCQZ0OSJZf2DuofPwWp4LwaAarmUFJYk8c9p7UgIvKAALYZGPqGIg4+yb4BLnbGEzYQtHsuAHiKMVMshK1TZJBEO4MHlTijPm1wdkL1LfUniWMVgVtN7losFbm0XXakp0oS9FgjOYMm6ooJdLUzCSvzbgOUq3PyzdpeuUUux4D1gf4KRQ1WNLg/JnCEa1ltzyvJYP7yyqo4epKJ0aoY2luxGIrvFvxNG3VXZK6x50xWYEXDqzbczWtLrkIsp/0FHA5jfzNGSwFYzKAAnHvwWG+IYSePto=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1k/LWt0AS8exfnB6xXTV+/jV/R7am02j7NS4A5CwYd7GUM6HKeVKe2pBSxoprTXtPjyvXdyyZbrzAPg5eEVADzkBws13EUAzd5lPDtWg6YyIXNo7duIw8Ml2Hd9CFArdC+TFqXIepF9POTHhHt8NTO+GlBBU61YMkzBP9iQERs40IzeqVhcFijgnZTNJWHiVgmL3A0UC6W/y6zVEYzsAydBgj1epZ4BVoFfTRMuUuAn3yt3CAD9jQ84MTs9jiLzK5WvRe9KbVaDVUVHXZq3fmhkbKiUwll5BULjXKvhpZR1DDI0BeznZqTzrJAkR9OU8fpkeRMuXpt2MK8cOWKouLn65hsz6Ou4EZY+vBcNIkafSZXoII6K9fxQ6/SL5MbfMi5hijF/EwAKEim3sADZRQ/76tQfKZ5HJlvJTbNpVuabO2rtOxtD4o91S+6DdDm65
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:33:34.1650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae679e8-c2c3-45a8-c8dc-08dec1a7005f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912
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
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:peterz@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:tj@kernel.org,m:vbabka@kernel.org,m:feng.tang@linux.alibaba.com,m:dave.hansen@linux.intel.com,m:brauner@kernel.org,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21708-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75F0D63AE94

devlink health reports can be generated before the devlink instance is
registered. This can happen during driver initialization when a driver
creates health reporters early and its health polling detects an error
before devlink_register() is reached.

devlink health still records the report state and counters in that case,
but userspace cannot observe the devlink instance yet and there is no
registered handle to notify through. Skip the netlink notification while
the devlink instance is not registered instead of asserting registration.

This keeps later userspace queries useful after registration while avoiding
a warning from early health reports.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/devlink/health.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index ea7a334e939b..376e79497771 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -513,9 +513,8 @@ static void devlink_recover_notify(struct devlink_health_reporter *reporter,
 	int err;
 
 	WARN_ON(cmd != DEVLINK_CMD_HEALTH_REPORTER_RECOVER);
-	ASSERT_DEVLINK_REGISTERED(devlink);
 
-	if (!devlink_nl_notify_need(devlink))
+	if (!__devl_is_registered(devlink) || !devlink_nl_notify_need(devlink))
 		return;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-- 
2.34.1


