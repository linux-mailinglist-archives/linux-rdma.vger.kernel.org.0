Return-Path: <linux-rdma+bounces-22046-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SPDVOMKpKGqIHgMAu9opvQ
	(envelope-from <linux-rdma+bounces-22046-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAAC664E0E
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 02:03:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="H36/7OwY";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22046-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22046-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16C4C303B184
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Jun 2026 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB813B2A0;
	Wed, 10 Jun 2026 00:03:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39811427A
	for <linux-rdma@vger.kernel.org>; Wed, 10 Jun 2026 00:03:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049788; cv=fail; b=PIxPBPAQSxjJsvx+Zx5FGA/9U/l9h/63dmmnWvEZnI+Pq+Yv/mk9JKlSu1djSL2hlCoO7ihFImZJLyIYK45xAoxGYr6ptryT1zB3VUMt4zVVLrnTeHa1yIm2daXqE3rUmIkD3llRks0B7BXFY6XKYfJWeC9Y4JrVfIGW4MJhyQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049788; c=relaxed/simple;
	bh=CiT3Sju9n7tIMppyvO63I5NFEWdO+2CDLArIjYOc0D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g5vBJnEsBfMBJJN7mE8KQ3TjaeolRuzr4D1jvKeYSsrzsOBdHN/CbBgVeSnw4hJ6WuAb3RjMA08bHfqyuNuG8PJJV4UWAtSA74SF0rG2QyeddMo1dCYNdLxJ8ISKyHAcqC4satFrdSth+vLLafwrSfHT6CAUnZvEE63P+rqlZbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H36/7OwY; arc=fail smtp.client-ip=52.101.48.54
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOxjmeS9er9HUEIMjB+Lkmuons1b4BJiLNk1cD6PfYR4jBLN6s5VEvKTuv5GhUOemGvcvZ4kRHS5ugNcfRFO0JDoDMoSpy4Z+a8lKTdz4m3b3lYJ/R4YXWlcbAUD7oLsZTYqlu4ezRJt5wpTZlijk4qhl2zEPpkPXZE4SPTlhxUepMjVQQX/KqzCQ0A4HSx6TmFOm/DKjlDe+baJEPMXOy0z9PM7DMonaVvY3Y7cx1M+GAf1jNYpcI0wo50jRgVFdH9PCRZNHK+XHn8Qv8uubQoG+I0wU4yxbRq6+fBRAM8ZE8tTgEUR+j22+0UglGFwVk7hA06eLdqIYEYwoVhhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEdiqcKaVGvGUGLw2QHQ7nCWsta0d9KWGHx9VP4ASTE=;
 b=MAN6NnKq8L8t5jhvKt8AJF1xFaJE6zXU0FF9QkAlGTNgqDIeoyz0SnWbphsNb1oA4ToOyInDxV9jwsH7cIdE5sWW2IFrq2qiteyw3g8I4lXmwVx93LVItubZaQnohoV+Ua5NtALApE8M5MQN2GjvfsEvsWpQ/bsBG7MOlWUy8grfWqfq2M5tWHNmUnmAl7Vx+ibCfAJ8DNE3DayCmJ54HdyND4Q2OY4BbNIK3o6dM1wyc66ujv2WPGP0Mv5BrAix8gfCNs1ZPKQ2h8khVQ4SLc2hE4UVVVpkAUART6TIAixN3jWlvDLq8wLt2U65zJcLa4gInAVzA3fsQlydRRqXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEdiqcKaVGvGUGLw2QHQ7nCWsta0d9KWGHx9VP4ASTE=;
 b=H36/7OwYn8UyAfJ6wY8VPRs8XYLgsFXs07/NEVYpwoG5aNPVK8pJqxaD2qcanefNSzstTOLwqJmFsMynwSqyhMLlp/1wuWkWH5uFM3/v0pI/+X4yrF4lf8DiJHyLSxwHYwrXZ92x30Wz7TIycOdmcPeufxVnqpnTdznwTYYdvjNF0IWgxvslAniPnx/DQdIXBjZt9ynXSDZ2DzmM3sDSZO5HrINbXdO5jNxy0ASZCHNqhWZx+8kTNRNZaQYVwpCj2gXLOSzG3G0a5MI/eN8gWmpdm3/QNi/ProRxeV7T493zoqKpZnNv7sq8ImxXEOsIujOXsXnGBKGHsmuyal0NKg==
Received: from LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 00:03:03 +0000
Received: from LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142]) by LV8PR12MB9715.namprd12.prod.outlook.com
 ([fe80::e74f:2cf8:cf2c:142%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 00:03:03 +0000
From: Michael Gur <michaelgur@nvidia.com>
To: jgg@ziepe.ca,
	leon@kernel.org,
	linux-rdma@vger.kernel.org
Cc: Edward Srouji <edwards@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 6/9] RDMA/core: Avoid NULL dereference on FRMR bad usage
Date: Wed, 10 Jun 2026 03:01:42 +0300
Message-ID: <20260610000145.820592-7-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260610000145.820592-1-michaelgur@nvidia.com>
References: <20260610000145.820592-1-michaelgur@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To LV8PR12MB9715.namprd12.prod.outlook.com
 (2603:10b6:408:2a0::7)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9715:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: 111c4c11-acb0-41a9-65a1-08dec683a47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q9GxJssJHGbhi8R899aIeN3HLsqgbU3UrFF/jIaO0+P4UW4dBvNjSZvfO/zHw6l8KKXWXtpntOwAdAk0RJxV9hoQc4fmy2fLPRCZ2IpS2IYO4N0WSFkzlFQ6IJw0rqh0Gq6Ts4cAIGKsh/l+7hV9JTcOXoKpOSMPr9hKvE5bvQsSysbuhTkHWwTHUKVspxY0nwO8jD4Mt9oxjgBwVK7aMIrIxd5bCKwXe/WxhLhvPn13qvO/nsizAvifyJvB7WU1vmfIgJr8kgt1fPS7y/cjmWlSleezG1ZQ44UtbvXw8L5inO0Qp4JplbhxizGdywnVG1pWID8bbT4B0q06uyieIzj47VX3UEAaWYQFSbHA94SWb9ggjVaQbdOiSz+AvC8O34xDSWOPr0FM6/xrrxCU4NbHccPSroAy4pO4ab8Qluot6RTvpo0eZxlukq9IqF2ldhwpqIPTW1tm9FO3X/JfRStMJLmb8O/FqfAjmc0PxnMT+DzNgdVH4sZt7amms+oiC+a7nNjMvACVo141/xOK/U/St5FsPmKclqzaMxAptKQJqp5H8B3pczjzD0Oy/LfCKi+dLzHM/2LkIdRLMFipM84QPHV5IiV19/BBAeqLQvTZF6HnhGafEPArEjFX8mR7NAn+wl4h/pDWYu4pNzYOURUEBgyR+SaTgsHyzx+jZPvzYi8/s491j9yR6aHjT3TU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9715.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/6IkNYDbEwFlfiOUJFKMA7XagyPQnw3ZCErj5UG45GbbMJpJuuXsf5pQ5Wp?=
 =?us-ascii?Q?bDldq+9GoITVGtuCup1d3GSpmr2SxSEqSlTEjPhhaDVwZmcsR+42G50Nhz25?=
 =?us-ascii?Q?8x7IlQVDzRcRl7TGLk0CCT2zVMuW6AzZzkV1yMH/ejZddsH2wgrQtM8oBu3q?=
 =?us-ascii?Q?nvN4YqOLYGznK7R/g/ghP+zeuVVsCSWIR0IF+8XnR52pi/3tJSE4lpwDuXff?=
 =?us-ascii?Q?5fRFm2H3EBB+IGWLqVJ5ocoZCDavxbKaLXxzJe8rE7vGsHXbwJ6r4JU3+b2z?=
 =?us-ascii?Q?BKHVe6PKVOmcW4AK0EejbZA+Xig9Dd19MnTqHLT9KbhnmXwmkohYrJZ3Y1FE?=
 =?us-ascii?Q?ySkL0a9WPRtS4Z7eeiY8kQmMKV9JzzkL3Ql/dAltyFG5XuW+Qy5FG2Vp/p58?=
 =?us-ascii?Q?+U6NI5ZPA51qQA1GseJFMoykbgdNB0y4r6DNkFyJEg4CYK+K08zihf/QrTR3?=
 =?us-ascii?Q?+4CDpwEWeAfDWJ7WQ45jhdGYnY7955kERLlPpNSd3Ck6xCUpq6BLAObjKeZ9?=
 =?us-ascii?Q?BZluEemOjv5cjLshI0/6kTPIncpW9WttsxOUKEjf01wWJZ25oqHyxGQYuBy2?=
 =?us-ascii?Q?GGDMlVmzAuzgNcBuexO8lDjFjpRehn4fHzTNyFQBERAAALZgriH7T72z3rAE?=
 =?us-ascii?Q?yAp2DRx5ob0K4CFEji9dQ6U7mgAfr+wzDS81pnJC/kO7wxlvdTINLEZC5J69?=
 =?us-ascii?Q?xNkFgXJsHfY6ualvrM4+NRxw28dko9I5+23GHkWw9mWpGXDqeqfwb5sWWrGT?=
 =?us-ascii?Q?c1/ZY4sM6YMZN+oivJc3EyCOuPr0nMdnsZtTgu6JYXbLI0c6b5UCw6NgDHl1?=
 =?us-ascii?Q?IysW2EzrbGlgRE40kwDcl91oObHQkOA4p5pj/pzNzuWexffFDHhWAhPKZNaU?=
 =?us-ascii?Q?Y09x8rVRCN8bMhgCFTSnYdtM8F6cdLLZu4KiGu9N8OQO6Pkt3tZN4Im/UVCI?=
 =?us-ascii?Q?ZeJZ1TKFczaIDarP28DLe4oMEtQQHATst4tbgb/m8OxPzs5SlOkJQoqjDn6/?=
 =?us-ascii?Q?BY041rpKBW0IfA77QzL8J+6uo4dz4LSvtNElsDCo2CvttZ9z+gL2HskWleQG?=
 =?us-ascii?Q?Y1aXf7VyBT3DEx+D4U+3xZQv1jFH6ID/akduZSHg75r6xLwKpdRTcy3+MTKs?=
 =?us-ascii?Q?fbm3zIpjw8a7/EmpOoHHX1kUEhlcnXBdgT3nwGs5OFVeS6BdK7HXB/BP0Y7T?=
 =?us-ascii?Q?9AIxiThVe9myv+ToC7UFa2ZjG55k6jPLcE5nDtc5eWM9RebBD+TbuMu2QKkN?=
 =?us-ascii?Q?jXxisSBpIH5u3iLmMwI1HFncmg4sUa/8o/fPCYDCMT6nfog3/k6GAjeAus4b?=
 =?us-ascii?Q?zoTyj1EaDLshi8XhIE0QXuxViTjxuOiLKu/CxJ9dz7jpnimZFTlc4Sd3l97q?=
 =?us-ascii?Q?oWd5uR81/TrVJxci3Vbr5MA/eeZHhbDWfmwFuGiaJFVi11ox78/LZZOTW/2u?=
 =?us-ascii?Q?0yDXNuYH4Mk7PLkSMpLRvnHbGyp8GxYarSsrYLqZObSrAKbzmiug7tu9agB6?=
 =?us-ascii?Q?z8mkji8WeVN6fW9DPeDD+B4NL5BmBh4it8K2jiMwGAhY9QKsHIX8ZGtKeKGm?=
 =?us-ascii?Q?p+yk1OJgGiBjYGYngSxDAxyH8dXOgNHw3DlLgUuFTm2c5Kmm7LTVaV0bbsj2?=
 =?us-ascii?Q?j4Wls/BIi3bg+TxL/IN6337swQjUMNa/dPwC+U6o5ltainPvw5B80a1ZOx2e?=
 =?us-ascii?Q?Rs3FVHYS/U1124SYZEYW/lUVZEeY7/R/jFam0jPGY640pMNDnp6sHetkVcYN?=
 =?us-ascii?Q?0bWvBQzjhg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 111c4c11-acb0-41a9-65a1-08dec683a47b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9715.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 00:03:03.6362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgJ2OJczfa8xTVYBPQAvNeSj4K6ITiPyQKLd2oox3A1trJwPLfqwV0BDUkzP7tU9UDjBiNnip8kCBVmkPr+xsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22046-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:edwards@nvidia.com,m:yishaih@nvidia.com,m:phaddad@nvidia.com,m:michaelgur@nvidia.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelgur@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BAAC664E0E

From: Michael Guralnik <michaelgur@nvidia.com>

In case a driver calls FRMR pop operation without a successful init,
return after triggering a warning to avoid the NULL dereference.

Fixes: ce5df0b891ed ("IB/core: Introduce FRMR pools")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
---
 drivers/infiniband/core/frmr_pools.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 1cfdddc3fcda..892aedfe03be 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -529,7 +529,9 @@ int ib_frmr_pool_pop(struct ib_device *device, struct ib_mr *mr)
 	struct ib_frmr_pools *pools = device->frmr_pools;
 	struct ib_frmr_pool *pool;
 
-	WARN_ON_ONCE(!device->frmr_pools);
+	if (WARN_ON_ONCE(!pools))
+		return -EINVAL;
+
 	pool = ib_frmr_pool_find(pools, &mr->frmr.key);
 	if (!pool) {
 		pool = create_frmr_pool(device, &mr->frmr.key);
-- 
2.52.0


