Return-Path: <linux-rdma+bounces-21860-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IZ+6KfYKI2oHhAEAu9opvQ
	(envelope-from <linux-rdma+bounces-21860-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:44:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A75C64A48C
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 19:44:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=MZDSVCe4;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21860-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21860-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EFA4306DAAE
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 17:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B9A38F928;
	Fri,  5 Jun 2026 17:35:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298DC368D69;
	Fri,  5 Jun 2026 17:35:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680939; cv=fail; b=CkQK0EvI+s3Dra/XqckCjzR/X3lJdc7gFwumL1iJpO6d7bLnnkCLBMl6A92nhS49ADyyhZsplutA2XKl3lfEAkZOiFDoyRZoIkmSuZRAsoyiAkAIRxHgO2Csn3VN83UdwTPfm918oFtCTThmjwXv+c4JsZYxQvM+9Eut2WKz9oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680939; c=relaxed/simple;
	bh=Xm7BfVqJAhcXTU2DNm71KlNsr0ZEBsgdHJvY9WzZ/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s8sfWjGHIpX5dzmTlU2ev/biqP2Vpb0wBgcpt1buRUlXSMMfUywRBIB93KzsCuvTqW8NhKl0xhl50sZZSYltHAVlUhDtPmoXiqufLKlPfvdIScjqj/1pFmYk+E75/OzpAHplWlV42fjvhHiNMm+2cKnPa9k/sds0M7Cs+oxUrGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MZDSVCe4; arc=fail smtp.client-ip=52.101.201.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ke13K/bmhv6YseVsQhnWhjJkvOJy345bFZWj213VNojSk/lajkQvEcwjrBmY5M6xBAN/9ejgUwGLCfK91eVWtJUAEkNuQ+usSOtsk8aZyCB7BPD5gofNXf/pBwHIHAROalGOQg9DH3ZJH1jeeln5H4ddOvih9QoEWK9sHBh4tiBZGT9jiRjpkp495IDjBebemd05awW4Qm/ILbKId04XM7w2bMfjCOYt/9ZHimz02Q1fmvUD2RPNUxCjycQVHamMH2xPgOu2Nf0LHTNCKb0cyWpJQ0Lw1mNfgjSsC7s9wM01+mS850nsyCWXxmIaqLlU38kUjOO9EbtTmt6TXctaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xm7BfVqJAhcXTU2DNm71KlNsr0ZEBsgdHJvY9WzZ/QA=;
 b=wqHe71d8tEJwO7p1MKiRlnVXIfMIuGvkx6sr8puAUnwSF0EcDCh3LpYz6HlddiUZyDRTw4dhGaBz8JvxOVXeR6CUaKXfLyD4FIb3nscfcoWqTIw1SWTl9Wg0CGaeFkFy2sDHRz1NwfWZSL54LXlB6NnHK8wnoXcIg3z5B16W/p3aeuTPGSu9/yamSaXG37D9sV7xzIb6pJvqewq2Da4+hvaYMiVagdBjfqk/jrE8gR31qd0ZMszfH7ge7ttl0zIVTrZ9jrOgL4z9mCGtcypKsFavTQBGuwu1Lpn6r3A+8AN27EUbemDPk6BIpQAlG5vBKNmDgTrBt6EUw9l5r81EKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xm7BfVqJAhcXTU2DNm71KlNsr0ZEBsgdHJvY9WzZ/QA=;
 b=MZDSVCe4/Z+ZBBvxbgydsAn23LFH9tbNQ54f2HGzB0qmqkZ+rdgfcY8zyRlFeeLgyUX4Kvkqsl4YxgSX89Q8sKQhNcMWHyaeyLw+Rmkj/7UASjxUPubNTdiVapeN6rvbQW1cWIo0Y49okDMKGrtWcGe9+gBSDVLu6ROaifQna21fQmWrMwVIXzM26ovQkhipOOOtO14utIxh2xG+JVkDfKi1/Vi24BFRokXWYldjbIGBBoemGTUQwXbg+6ak+ls/FuZxCAu2EjZIJx45ORCVXt1ROWtRt2hfu/qVQHFVj8Q4djPZqRk8hW/YYwrtzwU7jj/lSii0ZLYonnTBExrkzA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8540.namprd12.prod.outlook.com (2603:10b6:208:454::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 17:35:28 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 17:35:28 +0000
Date: Fri, 5 Jun 2026 14:35:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Doug Ledford <dledford@redhat.com>,
	Haggai Eran <haggaie@nvidia.com>, Majd Dibbiny <majd@nvidia.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 2/2] IB/mlx5: Fix loopback threshold/accounting in
 regular path
Message-ID: <20260605173527.GA2786594@nvidia.com>
References: <20260510222258.6654-1-prathameshdeshpande7@gmail.com>
 <20260510222258.6654-3-prathameshdeshpande7@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510222258.6654-3-prathameshdeshpande7@gmail.com>
X-ClientProxiedBy: MN2PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:208:23d::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8540:EE_
X-MS-Office365-Filtering-Correlation-Id: a80f0e13-7a00-49d5-2c73-08dec328d563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cZj6Mu+Ame3YILELDBi4CFoRnkLCx6KHl4ZVFYvotdiqf8yDrI03e99zkAfdqeeBRf+ubVdBcT2TB1zRLZtSKiZDuPKArYf79sYtenuMNnc5AbbFZUYMMT+MVD+0aMS7aME5u0m64Op8IhIxfUtFVZAKOSj8UbaKMIHw3qMqdkZZntaHhztmr6E1XLJRBYu4eyQgMDEcpa0Ig6bto/OCIJWEpn7jJdxQty8MfCNJRT6xGMwOTGJTKqLB3m5FrHLSJHZdk1gS1aIkp+tGAINS3ZdUlNTUxwqH0ieod8wRJ33qpK37cRWrfGHwypWc3+VFH2WZfJqiToAilLs0zh3YubECrsWZyMsIv1r7tgVjvjT4yr4iJg3bS6ostHak9lFgt3uZC6tWHfjC4r1cQuoKcih83TvuTWfzbtMmzqndVd07GQg0AQb0EMFyXaUWuogvr5J1NZDy4yifMJ7dnvIPjf78ReA5mdBRNjcJFvtWLJrCqkjb91myXKNYA86OFPHT/FWLudu7d9zvbQyZ4ANGYeiTgg9WOV3jF+PJJ9NOjrylIXczpihbnBi9E2eaNZLHt5LZLNpd8N1jxLdeac7XPDWdapifhVtpT8pzp+lMk7bdiMXPsJLYQumOsWAdAHomuggrsD1qeLpZizeYaWMJYenvz6nlc2u9lCw9MgAEsNrJKs2YQkQc0YfnwjfDLQ1h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFdxAWY5QZJN7bisspyymGnKSai5O7DWV5L2foii4IQdf39NyQCYziFrWVG8?=
 =?us-ascii?Q?VltEdayMTm7JIg2aoFZRgGINj1+M9DoF075eSr9Lanu8WwZrTCOJ0ltF23bd?=
 =?us-ascii?Q?caH9BkC8eego64p9nWZV3yrveMU0i3VecdNL4SAHt/omun0dcSwOiDRlb9ek?=
 =?us-ascii?Q?5xX820kAt5B7i/Nx3C+Wl+ZYyM5cEcQJY7RY08cD0tUzZ4iMqTuUoL3yzmRq?=
 =?us-ascii?Q?Xl5jksn2W3bP2IqoykpbLZnrkYpa3/JHZcaAObXmHm1prZjth2cx49CUW7P2?=
 =?us-ascii?Q?2nUARTzir9B1Ohrlh6BSVLp9LponUID65eWNDcB1EXia0SYOZ7YTkF1IlP7L?=
 =?us-ascii?Q?bkUU++14yzU7R/nf/fPgYC1QIhpgw4oOvhW/ThOEr6rmbIavME5IMKYwvJ3G?=
 =?us-ascii?Q?f/8f3+RI38PCAxwgZ5N/dSerlPzbHSRrqvwAusWjr7qmDGSRbyqEuXGNVKcP?=
 =?us-ascii?Q?sC56si9z/D9ziURDz6jiCUVCVOl+L0zgS3bfkYBLKDA8IphKX3OdiIUN2jQ2?=
 =?us-ascii?Q?bT5Jtiecc7f8Sp8nWnkn/xfhNZDd7kZsmG6BZ5zTAqodkxWO7gxUw6opU2/F?=
 =?us-ascii?Q?GZ7mi58imTlHpKrzNSlXXd0deK8lICsGicS8WJA6aVlV80pPOpH3MdUx1Tlh?=
 =?us-ascii?Q?ziFPZnsNWYpYUQ0DNGzlAZ0AdT00nGApZn0yqXFZ52K4vZ6e4SHJ81iQxOTx?=
 =?us-ascii?Q?P4+n4u4ZhMVVuVHOrI6d0ajd9kJUNh0e+POafiRor27DowNYx4tV1+XXv7QE?=
 =?us-ascii?Q?rrApAt86DVc4Ly1W5ZxLaUkPI4Dg3lQk/0Ox9NUrXAmO9d9+6lyi5j1HxkMD?=
 =?us-ascii?Q?QjCC3rRcOg9uGjM4sY25SK2RmDhTexiy+VY+mC/XKfH8NdlZJIW1jGE8fe+9?=
 =?us-ascii?Q?vsKGGbJFlttzEtAptNnztfTrO3WJU/rDlU+HLGSo7c76TxNMcyD9enZqgfBB?=
 =?us-ascii?Q?ypbMdee39HdAID9T6LT0RwpQ1bM5aPDWg7UrclMifX75GSqjT+8J3NMu08kd?=
 =?us-ascii?Q?SxADp/ZYyj5zIwlODQlxZBw9mexwbkP6sc+TL1sHMMgp85Jh7ejy/bCBEShD?=
 =?us-ascii?Q?nCUn8a28wCdhrKMI37ptYkllSjMLuwV8vOptaN5N5qJuo9pl9rYY/C0x7Xmm?=
 =?us-ascii?Q?jOK9Q+3PwYZL9K0YzVHqMPXe2FWx4hOkJMVxbV6tYfCT1RoZAG4YivR8mS/9?=
 =?us-ascii?Q?MC8OGp8dhPpv3Fjf23w4GC2pzbLRADOBzZSndjxfx/wWo/LRfivUS4Ws7xeZ?=
 =?us-ascii?Q?TBJoxPeUVFekAJXyuly4qezTG41EZmni0aDalQAucYkp8L9qovEObD33DUnW?=
 =?us-ascii?Q?F+vEPqHdIIZBjmO93nrcl9fJsi2VmcWY3QHKAe+lAseLrA84Jyt0qAaeHWb1?=
 =?us-ascii?Q?BXmVo/03xUeIjnfrLAbqCey+lCmGN6rMUy9AfY1ytG/sybHxm7COeeWXJJO6?=
 =?us-ascii?Q?6hBtNHNerSX+K0xI8fxyixLsxxiXNILdCGDAds6ZEUX3dsLYRtPEapu69DSY?=
 =?us-ascii?Q?sg+rfMnLDEgjpsXrN+uB+of57NP6bnsSgznQShPbPN7kCiPrATqinDUSNZK/?=
 =?us-ascii?Q?stWuOJpXbq3jOtlE1+HhY4nRuIMwUbOA5i+mTHBSNy9LeR3NmbjDZhnb19jW?=
 =?us-ascii?Q?mhZ09DDXrL2BcK0QMVqC8zDgTGw6sYPylRUYj1l7G8+YhGY8/N4Zyv2uE+I9?=
 =?us-ascii?Q?TfyzmKFnn2PsnO72VIPFhKUtEKHq930PQnpZBy6HnCWYalPW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80f0e13-7a00-49d5-2c73-08dec328d563
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 17:35:28.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcW73Bg4mGfd7KdnZWs7ddGntZ1ItEpuz4tgnMYxnRvkwu3UsK97PYH8bkF0laP0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8540
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21860-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:prathameshdeshpande7@gmail.com,m:leon@kernel.org,m:phaddad@nvidia.com,m:mbloch@nvidia.com,m:dledford@redhat.com,m:haggaie@nvidia.com,m:majd@nvidia.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A75C64A48C

On Sun, May 10, 2026 at 11:22:54PM +0100, Prathamesh Deshpande wrote:
> In regular (non-MP) loopback enable/disable paths, threshold logic uses a
> hardcoded user_td baseline and does not rollback counters when HW enable
> fails.

This is two things again. I took the cleaner version of the rollback
fix from someone else.

I have no idea what this is supposed to mean:

> Use a TD-capability-aware baseline for user_td transitions, and rollback
> user_td/qps accounting if mlx5_nic_vport_update_local_lb() fails.

Jason

