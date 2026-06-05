Return-Path: <linux-rdma+bounces-21865-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id R/4MNWIRI2pGhgEAu9opvQ
	(envelope-from <linux-rdma+bounces-21865-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:11:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587864A742
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 20:11:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RlSPx3J0;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21865-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21865-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 251F13029888
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 18:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A71392812;
	Fri,  5 Jun 2026 18:11:18 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011013.outbound.protection.outlook.com [52.101.52.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C510F383C94;
	Fri,  5 Jun 2026 18:11:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683078; cv=fail; b=b8upfyATwsVI0TAepKWMy6YusvmWWyAAVc6SL4Ae62NhTXzH9RZjIs+wbdzmofIsaQhLmAmV56gxnA3Z/ctFbuj6XcSHn6c5krc13wpLhctlR37ACx9zyMUr2/GHqXkv3c3cdQuBzY2aVCM2kmt6cCEREGkFAhQq2T2znsTNIto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683078; c=relaxed/simple;
	bh=MM1MmyW0dYPnybWKo7radMlVV6O+t6JBI7aY2SuJPjA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVUPrjuz8zRelgwS4PIP4vD5yunIOM36q20UPnzH785+6BZOLwvYfN5BV0Pt+bxk1GihWKrWfC3gPjAHhuXgfycWQCwFfhSbMvL3UKQq6s/TcUJYUwtpMwlKMwkjNdIAquqnv4r22FCSVf1+RfoNtUsr267GUawvBbXfmRBCnMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RlSPx3J0; arc=fail smtp.client-ip=52.101.52.13
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COBKBHpX+D3nccmdtBRXUl06T+268Pe7pOlL1/PprbVN9nHkFAGmtcVdh6XnWbo/23UCKxjWInpks1XACLv9Npimo1pfOdmLUY7lBIqm3xLqmSK9xUzT7IBpG2mFl6MgMZKt8+oB7Yi26tZQTAJTR+vCqY2+tbjfabc62FJ9TOZStWVQ/0JVysP8Wh/YINkAWsSFywQJAee6ydjW3OghULc1+dgPm7VCeEwm+6q50iIgbWInBiPikVL46P8KAiMGh/IEKrDsBLCAESIJ31lJ0AbhohhqxMi7QlBWSLGcfb1OR5O9wwBkOH4FtR5yOJIT4Oj9HInzx3uFuXAd64n3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yomO51Io6x9hIuebKmWNm/orJxluJvySdJo2MQRa4N0=;
 b=jmwDkvPzGS2iJ4K8Hi065F7ee0eFFjSMPCa+wjpPWGmstK87aJyPxhRUrSXH0zzFFIzMaEghEJMtp22DCqmAZX4sKLN6Goxj0Ezb1ytzk/jHvqW+RB6S2sbN68zDQKlTqa33mbLIwDi7RCwJKTbTYSVh2Qa6pcz9A6b+BzbyGkPGeKoGsT2f34SJKwDUIl+giZ4Ss4+RgFEX40duCykhoGYav+x3l6quDubdtyxjvdziesWHDKzquCuOz9VB5EatO3QZcZrEcRyfRK9N9OAcD4coObalLQKOEmeHQpmARAzvfzkQetm6pvfvAewv/3X3kYuNLOYpsVq6lSiouYN5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yomO51Io6x9hIuebKmWNm/orJxluJvySdJo2MQRa4N0=;
 b=RlSPx3J0GJi4u/L+P7znt2BpH2gcF2YWioOWOyvUlzaZcaOlMfPhCwHCiSKxk6H5wWfJJuUHjcE4g/mVyFHc6sKEs38mI0ZPFfIOuQvfn7si8i6evKVihUN2mTsJyOwPael6YzfyTUMQdAIRaBuc6zXD6+drINLxLXfQxFn2kYdzPZrc6hbjOj9cL0T/rhHH2owpTINnjEBESNdtQTRLCT44KSun1cFomipBmXB5qTVEMh2qGU5CTGQDgwgIvLnz9sie2MJS0db7j7HXLrGAsSA5GYTA+jjcXU1vTT/iDVwfN2xF8NeQCkC4B8ujgYkdLvpj8mkyWu1H4KJhWIjFCQ==
Received: from CY5PR10CA0004.namprd10.prod.outlook.com (2603:10b6:930:1c::19)
 by SA3PR12MB9130.namprd12.prod.outlook.com (2603:10b6:806:37f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Fri, 5 Jun 2026
 18:11:10 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:930:1c:cafe::67) by CY5PR10CA0004.outlook.office365.com
 (2603:10b6:930:1c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.9 via Frontend Transport; Fri, 5
 Jun 2026 18:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 5 Jun 2026 18:11:10 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 5 Jun
 2026 11:10:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 5 Jun 2026 11:10:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 5 Jun 2026 11:10:41 -0700
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
Subject: [PATCH net-next V3 1/7] devlink: Skip health recover notifications before register
Date: Fri, 5 Jun 2026 21:10:24 +0300
Message-ID: <20260605181030.3486619-2-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SA3PR12MB9130:EE_
X-MS-Office365-Filtering-Correlation-Id: b475daea-a6d5-454f-d303-08dec32dd25b
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	11NQFb3+/EFTLwKgPv5NfPFb8jR9YVuyokSUsyjxjrDy8pZRH/3GIKtI7HTybJF5JJu6vKNi+6i/BojUKJebs/QyeXZCV6es9HlYM5gE9Dtvxvebi4xhw51bjre0LE9kFgnCl46WauetnQGXvqOGpeI7vNYJqV9K97RU7yMCXxxvivjp+yQfW6aDpH6C4obDKXLA0er3kiQnawQwoUMs65PGaF2V3UKLGk+n0aCrx5bkFO//ESOYZAuDIQ+64MJgbbdNVsABF0fJXrUNimHdLLMTUtfvsX5V4wk2Lr4Ry5/U68VHA1orHKnL9KhliIUcfB0pv+MC7QGU1Yr9F7ykk7kvgerN7dFLN8SUEQ+iFhwLo3p6FIFbC8TJ3wnSdNachEWraPO+IbnHuSSeJBvNPJzyanEF8r5v4VJ0JyRBaU/EHoKohyRIFS5fSgQU5usjQl8n0sjQVSRwaYU0THXLUETZqoh8cDo14rTRrYce3APScW4acx354BJiD8yJXxBBP30FhgRBFoRqZZ5JGsMPjs4cOgUBt5lzOv/5xVP2r5xhcFsljNZoJ12tuXsZBpfKcE9yU0wEYwnIT2igDvV/SfXVEdT20vVoXUK28AlDZLPI4Iqvz9hiYRHq6f7RlDAmIw7Nf8mCiKBprQaRgdfbtPZ/i6efzMi4DvIt0T3Va4wbKcypr7ALqj/l0PLwnl8gGor9r8bjz7P3qFdpRvqCcdw0MqaUtDEOjnu2R/WXEhs=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xxyDHrly4Y+6GGE9/TMXhBezBAO5tWzuXlrryP3iLbT7bi7BsdumPY5QM0objl1A6l77y04A+ZFeVk554Q7/BzgPi4bUyg3TEdVrnMislNbsde6PE8S933HThyY/qiKpmI6GizdzdYDOasjkD/+irMevV9DZVSaRBgnYIcffCSnVy2gu12CaC/OY+6YNks9KUuaf3WHLY18ArUflklfWn+nv/mEOaP+/JBIiNm8SAEGRv6W5CCXUqaokz/7StFRbchB/qGnWlAsZaVOxD11nalvfU96+JVFuHaOryx8JBftYjfFXZpnQqfvm7BUS4u/fU6XU4zxO5Al+n+uUXMUnVDrGcw9fN5krKk2tXTDYIxuMvo0YIJEkLJfxYQ+CB8a4Pogciji1V/JMgEROKJtTbYURN43JmQntgm6lmnUxMRzLoqWXWpWbataC6HbToiPh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:11:10.1192
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b475daea-a6d5-454f-d303-08dec32dd25b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9130
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
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jiri@resnulli.us,m:horms@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:bbhushan2@marvell.com,m:saeedm@nvidia.com,m:leon@kernel.org,m:tariqt@nvidia.com,m:mbloch@nvidia.com,m:bp@alien8.de,m:akpm@linux-foundation.org,m:rdunlap@infradead.org,m:tglx@kernel.org,m:pmladek@suse.com,m:peterz@infradead.org,m:dave.hansen@linux.intel.com,m:vbabka@kernel.org,m:brauner@kernel.org,m:tj@kernel.org,m:feng.tang@linux.alibaba.com,m:dapeng1.mi@linux.intel.com,m:kees@kernel.org,m:elver@google.com,m:ebiggers@kernel.org,m:lirongqing@baidu.com,m:paulmck@kernel.org,m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-21865-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,Nvidia.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7587864A742

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


