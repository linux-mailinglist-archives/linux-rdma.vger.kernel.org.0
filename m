Return-Path: <linux-rdma+bounces-22285-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yptSL1SNMWrZmQUAu9opvQ
	(envelope-from <linux-rdma+bounces-22285-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:52:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6B5693912
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 19:52:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=lhe2U06P;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22285-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22285-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7434F31C7C67
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 17:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42133D34AD;
	Tue, 16 Jun 2026 17:48:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012016.outbound.protection.outlook.com [52.101.53.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428613C3C1E;
	Tue, 16 Jun 2026 17:48:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632103; cv=fail; b=Me3EpCaTvDV5fQmR5d24yqcZq5IUVYj/TxwEwbcvVRosJ4GZBJ/x6fJGBJqWU8VUnbT44jJgsCVHpvZuOq1SSzz9Jhmcfdn8hd1QivdlSMvp3hnxVIpMVCu+oRMtQwMvzTMFubasiZIq1XNAbB8eliMKckslSh/5RPJ5w5kvLI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632103; c=relaxed/simple;
	bh=hd4c2MydhrIFD9m66mzU997OjJP2P9L0LGirH0WLs7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uLWbF3OWD1GciAJU5IqU0mLYkKI+zjR5GKw5iNlqhK+ZNunvqQk1DckqZ0N4s9nU584Xhd4yEooPR+njzR2MqL5qSaU37efp2cY1AchB+yUPqSlnbrwv0SlO25kuwX5dt3Wgb81Fxs1XsIMKXI8TX6YAGn6ifMtyBBxQFw4tbVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lhe2U06P; arc=fail smtp.client-ip=52.101.53.16
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zO7kYuXYUylNP3c9Ir4p5WOCRATyONXp+MkKOWDh8KprUBN7AYSdnTrOoHmUtVcKmD7QSiDVAi+xmYlZzR9TZDjr7L9K7d2qbSnyNf0+2i0WvyplRgXlGBv2pE2jzz2Q4lPN4elfQ/Gej2M+da2wpOTpxmR19JNK0jQUgnGwXddfw3axu9D6UdvvaijcGSACDOBfsSypCPT9ptqhITnMluBrpWv8FjfogKiCGS2uCs87ik5my4Utm7N0AvuPXeql5rxX34w+LaUXjrXDnEAWtz+qoPMTwDNnTNwmGQDEXop9PyulASZCXR6CpY3CZc0Gf5V0wza83BqPZouujQL+3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5Jc4GSyfl5NkoJvfrgMBCM06g5n+LifUIS5JSYRx3A=;
 b=P0gt3zpnBc63Y0yxwDRgprgU8oqwaNXJQCyHpW6eI8yCD7CvkiCe1uEfo6xHIAaA+mdn1qQYcrPqLgxZJYx86GGoq03GX/6AsQFzDIpkOnpeU8c5P/EzT0s4dV/Dhpjf4QKqAhw1CQK9BGjG0mlTGP9XCIso+1Dmq7/xEqeRTDiZEJB//ifIiNQXJ3eqRxmvTdY0MQD2xOJ+w/+Z9mpkibk8BWuypEuuXqRcA+TarHfbaH5dkKtMxzmP0DnN0y/ZHvHx6Rj6Ygb9dSFzSKC6dK1SEQO6DUN91+xYkpcxTUnAPMUN2xYTdrWP4B6G7pxRDToiCJvu0PSPns99iZYE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5Jc4GSyfl5NkoJvfrgMBCM06g5n+LifUIS5JSYRx3A=;
 b=lhe2U06PPFuWFG7ILrbFZGBQfkSneQGeZBRljD5H85ZY5y58HXcrLa0dzEzf5WMshd3Z6J7UWKPp2iJKm1wK2jn25DaAIP2QMKF8WAhN89G8vajUVNykA0LbuJF0Sd+rtrF+EJBo2nFOKyfNTKX09b38YtifedwG+o+zU426MT0RrzSl4r2fhMZijzAyvXZ3pqP8WK9+B+kRNjCqh865h0pj6MmGI3Ce0Vq6gpBAPlFYwhXC5aTPn+O0ViqNO3cJ/olvRrBbuC1gYojZnwuIQ32CzHpKq8Ze3lE6V25wqrgQnjxVPRMcqvV8Va2lPXEx3+mo4hWTFjf0H8/QGrzFKA==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4329.namprd12.prod.outlook.com (2603:10b6:5:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 17:48:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 17:48:17 +0000
Date: Tue, 16 Jun 2026 14:48:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Dongliang Mu <dzm91@hust.edu.cn>, linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>
Subject: Re: [PATCH] docs: infiniband: correct name of option to enable the
 ib_uverbs module
Message-ID: <20260616174815.GA3956156@nvidia.com>
References: <20260616002027.67925-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616002027.67925-1-enelsonmoore@gmail.com>
X-ClientProxiedBy: YT4PR01CA0216.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4329:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a6f1df-9093-44d8-9931-08decbcf7245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	RPssZxWdDjEq2MYU6QBFS1d+o17BlbJBF3Edwh03iMsxhYkRFglCoAj43DOh4xS66z1WBqvSh23ctvu+Rufj2v3YctUY+7+pIFEDJAu8g/vPnRf7fMX1AR3P2eJ+OKB+u7DSZQJNs81si/48DmyqK1OW43/0TMVj5LfcDtTmtQiZx74KlT5+TEHfhCsvW3uIYiB18hZ9+0LhHYJzZi/RfT2wIukkcxVdUf+vqQIGtlfLTXUNSXqR2YN1/JHDJKpRQW+XoP/MdWljZfw/nT0H++CbhjQ7lOY0Lr0d0vQpUBicEnjCG7qhlq8uTM2DZwz9pb06q5Fqu1DP4lJg3wnKpR1NCyIRu2Xinp18Ws0K7l+m9HcI2VdbNZLEwrouNGx84QUlONozYoJuX9V7GxhoYWgFIRnP6RHvdZO+q0fXeFsiVaX7L+ulJOrRLSD/yOXqbFIYt93eEvo9D06Sg0mdrhmCjLlbOuIV+Ic24REjNEHvAWI7vmzD5XCsJzMqgkOtmxrv/T8IxoXpBjMHlbMaeO1tt0HXKYNUUB5c+VC0lO7O1X8Yb4GVZqlAh9DF6+FA97Saqpxjn5lXYlaFIn4MjODYGjCyrvuScZH/JWdLwMdsFcxv3IdOWXjVX0S14aVD1O9jNHmGxHjDkRh1w/8SAWhl6yFPzm8QIp5KTlFMCAQUY3xAftkTuoZguTuRZ9HX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?83QTgPCsnAavTI/59lU9w5+tPiqU0E94q0wcvFwfQDFZI40jXcsJiHy3kKEQ?=
 =?us-ascii?Q?RmB6WQCQS1RmYeiG3c9muYbJvG4jyg5efqOx4qV2wryEpG2kujjXAfx5X/bV?=
 =?us-ascii?Q?7z9rtHdJXReg1DHnCD388L1B/5BLTsTrcJ1V8xLHWqTimahM1CzD6avC6rn6?=
 =?us-ascii?Q?prpwH1mElVR5wRL38/iqVcyS4hfH6t6nepQEJxx7QGpwurxXgj30LR95X/W7?=
 =?us-ascii?Q?dhgj3NOGg698hA9qhIrcTM7rqGYMLhAexBxxIfCcfE+A3/Bytvqd17B7O1E3?=
 =?us-ascii?Q?xR1n+n/qrcbgSfBCYkbTWAPW2pgs7n+/ob8hI4iFfy9hu10gJgO7sCNQ2X/Q?=
 =?us-ascii?Q?0Oj7CBuJaYcWahTFw28g7GrNXfIfcOYXV8GfssX54INOlFCPw6K/WUPFvozD?=
 =?us-ascii?Q?tXL55FyrXaeAJ/KI7z6xQkGxxek5m4hTqdAfTw+EFGe+vi8hGGiqewUg93qq?=
 =?us-ascii?Q?ZXfl1akvO+OWdfL+DIteiBObnXZy0KBoGXucw+PXvDli9YF9Kt/+7ivKTrwa?=
 =?us-ascii?Q?Na/7e2V7XUClLrzxA1FnVcaeN2+yLZ5GGPCJzDRAv0SsqcjY6eqKyvS3KNZC?=
 =?us-ascii?Q?WeP+khHMvZKEhs1lXfBUW1ltUIv2AiKvw+gz7Ia6r3IZwOpnvSVZ4KYGMk5o?=
 =?us-ascii?Q?FJRZciTECPQBaucYHoCZRkZQy/CN1vVAqoHHqMhHdSiXaUSScSD1n//WCLku?=
 =?us-ascii?Q?nKEiALd1aikUF3eXVI/7lASNzcNLDsu57q7u9K9ZHXeBEDWocE1+5KD2S4Bc?=
 =?us-ascii?Q?7GyiXoJd/vnT+u/9l982dDBCk0QGbyfbL0iNcW4Sbz4GlXUB38BqMXmaNgTI?=
 =?us-ascii?Q?Usbw2DQKoBcOa+50JJm84h7or0W9Wyz3VZZw3l/9yaRSoTA+U5++knQmd9fh?=
 =?us-ascii?Q?bxVJ4KXUJHrCgryjA/uHrE7sSka4Y39TTmdvPSNvK8HPqx+oyUaYE87CBfmx?=
 =?us-ascii?Q?rCde2lkl7lvGGdLuNJmEHaJtsLffu2bCkk2s8wgUfDCe0gGfdJIYW8XXXHot?=
 =?us-ascii?Q?IruxFN9IjHDz1jersRUxwOrobJ5XApW8AkcJA3KP62AayGCEFuyTT/0PYD2P?=
 =?us-ascii?Q?2l9wczmLQdLJhFG6W54mphYWTb6iq9qmNxtXOJyXy+cVNUQJQGp/d80TVg8+?=
 =?us-ascii?Q?cBOp5dIjUIHy1+RG1/gEIS/kpvrHxUEwD9UC+X+5ONYjcYYGco3f1k1Z+zjk?=
 =?us-ascii?Q?D9t+a3mmOaUxCcljK2oTzKr/huVZOCZjgnxDBlcW1T4lRu67aBysmSKH2Yl1?=
 =?us-ascii?Q?egmHtbBpTwP7hhrGkoX9eXh16mOxUIrKESSOEWEk/FP8KXOvYVV4mykcAY4g?=
 =?us-ascii?Q?34h89BFfG9PNeupiIYXcsbcZmhYUaxQmn8GS6RvWyELMq0P9UELLumtO4vJs?=
 =?us-ascii?Q?EEGvGbDo6Z5b2FC93Nfq+Sqim0iFvTq4MvitHATOTNLED1dVtYYz/pGZtihr?=
 =?us-ascii?Q?2xpICwJLNi2g5z+SbNF2L2JHPlYU4HelZrKZe4uRM7ZWjIUoGIqW1ssD18I0?=
 =?us-ascii?Q?FF0tlRW3jdInhPH4vvYhaoqQStmWjw6lf9TRHR5K2LMVwKhcjQbhfrX4E1Kl?=
 =?us-ascii?Q?fslAAz8em9yrPENio4LlkeoFeolyR2K8NNldbqpamJDzDGeBPjMJOiGljnsx?=
 =?us-ascii?Q?1by4GgpcZxhB4I48F0wfbizTiUiNRjueaV10SiJ3lmGy3LUHLolE81fE4vG8?=
 =?us-ascii?Q?72rIfbeBK3bSsg2nCHoXZMcDFWZRqvXtFmEpdB97EiXb/eTR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a6f1df-9093-44d8-9931-08decbcf7245
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 17:48:17.0488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S0Wb1OC726gwaswg2dmBtuwp1NLzqvPNtx5IlZqEVcyfE0UwoVGAIecV6WlVrFMK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4329
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22285-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:dzm91@hust.edu.cn,m:linux-rdma@vger.kernel.org,m:linux-doc@vger.kernel.org,m:leon@kernel.org,m:corbet@lwn.net,m:alexs@kernel.org,m:si.yanteng@linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,hust.edu.cn:email,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B6B5693912

On Mon, Jun 15, 2026 at 05:20:23PM -0700, Ethan Nelson-Moore wrote:
> The Infiniband documentation states that CONFIG_INFINIBAND_USER_VERBS
> should be used to enable the ib_uverbs module. However, this option was
> renamed to CONFIG_INFINIBAND_USER_ACCESS in commit 17781cd6186c
> ("[PATCH] IB: clean up user access config options"). Update the
> documentation to reflect this.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/infiniband/user_verbs.rst                    | 2 +-
>  Documentation/translations/zh_CN/infiniband/user_verbs.rst | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

It seems simple enough I picked it up

Thanks,
Jason

