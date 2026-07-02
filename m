Return-Path: <linux-rdma+bounces-22726-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RjT/OI+tRmrYbQsAu9opvQ
	(envelope-from <linux-rdma+bounces-22726-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:27:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC426FC070
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 20:27:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=PKGCd19v;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22726-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22726-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E65CC31E6603
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691903612F1;
	Thu,  2 Jul 2026 17:40:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A77318EC1
	for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2026 17:40:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783014032; cv=fail; b=SmGVx4axAfDMoU4Cclr1hvUQtU3hZvnnNTYlwKN33h2gQ65QYy8dce0m8zzHmz+3C/hwYNlnhbQVh248ZmQ/czC7pe6emw2HlFDR8l5K3g3nyIGPsD7E3hxQvikjatoK0j7kBcypPx4Blrt4eG+Fvvydfx4Rh3eXgMGSjLX3zI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783014032; c=relaxed/simple;
	bh=0bxEheux2U+YmjHMmNDgTzPSGIBzNJqSn3mRdFoVrbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dvO3zTGtF9Sx3p4fx8aVqkJTZm6MSr3P+vUv6Qbs4Jc0jEgrtHqAf8mCYaQIcKnJ8jWw250LUafhpCjQst2+5Dbd2mKRwU84DE7sdpyXmz7JHWoL4BmtCKhQAKcewQsYYx5oCgoXNXfLzNTTD2xTDVZvKr2XE3+39byC2c+52Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PKGCd19v; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9TWhUCHnBd0wlyxgimUC0pGi5bUbZWCMrMkcZN2CSB3nFzXYN5lmsulQY1pNmQLjsuB3lthMKmmxHV8MVqNKH/Z06nHzpZ2L7Ob/prtAsiJOOJ8DF5MkRqdyBoN4wlpVMoHK7puWBxce2dRkC7TEML70NZFSZp6UhO9PA7eRsyzPf5dKnzMSPIejtE1Wy0PQ6V/MmppbH7HYlOzO3VBQ9I59KcOYoNSiaSPCbmzWUgfDaXmk35uXDMmZZOLF7874XY/YzreibA/FlVqy1lkQFU1p8HHoYVlWDT1GHYxHrgnp4Ye/hOgpaZQORtGnycO54SnDyeXQjz1BXyafKXmhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bxEheux2U+YmjHMmNDgTzPSGIBzNJqSn3mRdFoVrbQ=;
 b=kTWXTvoKXsbHjayatxiMPrLEC0UkYJIhpVKlHWCXm4+JrKKxklqXvSSL6W2cmMxVLXBHUhqGi0r7PUTp/nkJxP3GL50C1MncdQQ9pY5+iNMUzIkQQ0bR4N3FMs7m9ACzpM8odxdCKVXY2SENAU3RiE2w9YbbsTALzQ9BTBD4v8w+tMfq+wTNDM7PMpnKU57ohCGv/HMGdkcSIWNYbMdtYwxCxi811X/sgoikYlny5o0Ew4eSqiZ+QvoP+giR1WFHQsNoQXqQa+n8Kg5YtNqPwQQ9dkcVmyH0SpM6GpcB5mTKN3uhEUjGNJqj+4y3V+5MokVp2CZ2i/c3m+LUQ9f/qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bxEheux2U+YmjHMmNDgTzPSGIBzNJqSn3mRdFoVrbQ=;
 b=PKGCd19vHXNiD5SPM3tvqEQ5fSl/E2SdBezSoPuYo4AkxGOtdMfrfGTqYW/3YxEs1uy4aPlQl6rVpH8dGzvBl1XVaSyQfU/65l9xmGN4WOj2uHGpNWJ/XDaOo9EMRLgrGAE+ZVYeNIPIy1MrcgaTrpVSl6R+tirJzIMs7nL0AC7ozb/lxw8eI4bUkAy7lGAb2YJsGD6Jt3+u474m+updeSLVenjitlh7HB0DmMhup/UVr43QldJDq5u3d1En2bdhXui29Mk2PxS5RqSI9pk7EKRwxLPQLSuUE5RJKk0lV6ubCJ5ZZXFbctJH4Rz7vJRKwJt/fQFVH7hhebSV0MZKpQ==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9760.namprd12.prod.outlook.com (2603:10b6:408:2f0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 17:40:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 17:40:28 +0000
Date: Thu, 2 Jul 2026 14:40:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: leon@kernel.org, edwards@nvidia.com, michaelgur@nvidia.com,
	vdumitrescu@nvidia.com, jiri@resnulli.us,
	linux-rdma@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: Re: [PATCH] RDMA/core: quiesce CQ polling before device shutdown on
 reboot
Message-ID: <20260702174027.GA1518125@nvidia.com>
References: <20260702073422.279820-1-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702073422.279820-1-chenguang.zhao@linux.dev>
X-ClientProxiedBy: MN0PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:208:52d::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9760:EE_
X-MS-Office365-Filtering-Correlation-Id: 977c8fc8-4244-4e9e-aa55-08ded86101c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|11063799006|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	2+PtzVFMprheZTqKQ67h8HrNCCfL+z1rsLxG1BJJl9CL1YPyjwbS1WopFvtt98vp3mummkhrFVQz8sUx1Zou6/z8bI2YDs+bHfyM5npaUGp//pUFsy91vFwSstLbIaPYHVL0kBDN3CsHoovSvc70zanBFiacqhdZeMPSiUN/3kVXq+yPUmleYihHWWd2RR8AeNY6bdb7fqr7YeVZu7cLX4OQiGDjMEPEB2vs/p3wzAwequLP7zp/sZyt9sZezf1Y9yC4keycfiC/K2rv/oSeBZrIWTYgSMohtApaZ+Xf7pV4k1yOBZUFJZitgTS6kVhRqOdTtgivmgGkLu+o0cmbEtGmtyNlwLXbu46GLWTCgJNFcXVsszKFwS1EZP4oyoH7SLL0QgHluewcxPORdGSpXDAMn2BeWu8Pj2yeGHn+nALZUWpjjV8J/fJhmKJjnHg1UHz7h/K57fX+l+9R7mm8il1pcy0e3c6bBLRitivfuPJnjkMcYHW5SeRVEhZXlFjR7urndINhx0I4uBzasCrUgqF89DlXkglXtSNdU8GBlvJQJZLR8lSc2J3ZBQcEO5whZ6zkkPY62zt9RmNy0QORWm9RD5zfjJw9GgaLlKhO+APmGV/U6dDAMRW48TfCeSk3NmHNFpzPTfMT5rKoD44Grw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(11063799006)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGm4i42c4HcPtIJO+GjktR8WsviFYj4CHTaSp4imMHTaxekr26d1t/5EB3/w?=
 =?us-ascii?Q?nA6/0o06t2vpsA11dQJxZeoieOTxOpyJBadwREil6abZsG3zDy2VcwCDf2pq?=
 =?us-ascii?Q?yP56ekAeQEPiFDAt+24T2vh4QDfQgTfxfbsgj82WHPg+zu26Q3LwTUAlP2cB?=
 =?us-ascii?Q?c7yg9yIU8lVThiHSg3NxVkLT/FhF8vqbdaM54MvJ5H6B6mmt44xomNsbMgUr?=
 =?us-ascii?Q?tZpG4a5wDwROoDDZbLH+6QYDO9MoUolSPtNHjXufZNyxCmjz4k6cPwliCxtg?=
 =?us-ascii?Q?zJ5KRi1JqLIpDWGPgMB5X905Kl/6pC9XXZJzKVr0tuXH04lT+WlA3E20Zktw?=
 =?us-ascii?Q?Ym9d5E301T8uSAhYeuBvibKCsuRHvHCeIwDRe7PIrB/JaFVrokFAYPJY3wpq?=
 =?us-ascii?Q?ZAxHMzmJeTdGwAhJx/SZ6v9nR8HzKS2Q9oo7JGFYUo/V+YAXfOeuK6oM5X4M?=
 =?us-ascii?Q?41Z9y32vo9tC9ovfOrOhQBKKOC9jko3rEK3E4JfJFq04SB8PycsdICSvy5Ex?=
 =?us-ascii?Q?wBfTAwybZNleiaNwHsipzHFJExIhbnKByH1oaVcQplb6muiJT9rPybMIh9Qy?=
 =?us-ascii?Q?s9hSPjHvGcQjMk5Ne/6Ef+v3vWFDUY0v+Bs9LsUtFp1HesR/fCP6w7bFCxXQ?=
 =?us-ascii?Q?01i44XsFnRHuHAqeI9tsuDQzwvxUlwEHtv566pfL45urcTmgTBA1csPtyJKv?=
 =?us-ascii?Q?L139g0EG9zuqY3zanCvlo2iH/56MNZsl0xaSIMlFkgZain26+D5WW8qDIu+v?=
 =?us-ascii?Q?dGfa3kWJbOaMXx+Wg8LCFqj9tQ2b+/fzfPBCdYYIothUGUj8Bc0AiUv7b6AE?=
 =?us-ascii?Q?kEl4LNLgrEBxBPQj4VLwfH7LopemrT8gRRjbv+fzlcwt+s8TtlQnIz40NZQf?=
 =?us-ascii?Q?D7RXc/ltmAi+FUeOEVPPTkXzSNfHQFYWZSZQ0Eoq3pKw0VMKEr56ZxDNNBGV?=
 =?us-ascii?Q?S7EN7h/4mnkn4buBkcxUffrYI8eajVFfH/67kEAPMinzpDnFqrpht4/8amtP?=
 =?us-ascii?Q?jTrbckmgV36eARQtxU1Fa/uX6kViiPV/3shpTmbYc1ei70mXuOJqAyX06g8A?=
 =?us-ascii?Q?sSaPKY6AmFigFUudb7xrjv1ux35TYPV/rDzr+ees6+Az2nFjdqqOzLdOYuUB?=
 =?us-ascii?Q?8CjITDgQbKr6pk5y/WYVxMLb7kDDNbsj5BcNP8TK7jYPbjAC3pDPZd4WobU8?=
 =?us-ascii?Q?yZfvYv969qn2+OmXPMziwZp4TglVgemBMEe6enfgydGRLT4uNpQ4NMKOSi+z?=
 =?us-ascii?Q?vE4QPs5QelgZR+E2cuCbWZ0hKLc1eBX82ngub/M2qhfZ89yf92SHmXwP8efO?=
 =?us-ascii?Q?QG+ZEZOOBMNFuj0RFYeduQ0/dZ4TU6Xagx9nN5SJOk0vrUV2o+ZCRte2rIgz?=
 =?us-ascii?Q?E17bhfhX6ykH34llHwFgxAlK+4519bhcw9rL+6NiomCTIzzIED9Rr2ZRzRxX?=
 =?us-ascii?Q?pD1mql9HZCt1LZkR2lxkfNnEwcnWsRqwncW2x8vTkzfWBPWgdNw8f9J9xZVO?=
 =?us-ascii?Q?kkjpnNcwT+58eK6tRjxYJETrZYjMoAxsAMNS4GoKVtR3Spk6pVhZZhMhzh8D?=
 =?us-ascii?Q?dgeClSog5qheoCIQJyePpdPykM3gJufRYgpKb9uka7nwpcLdBFW/YPj4R8a0?=
 =?us-ascii?Q?4tlFuFmgmgD68MlxNBhMYDyt84h5Uh8zEJ8F1grrqQ8Oz1RM9rmzNK5Xyan0?=
 =?us-ascii?Q?KUsu4goVrWpMaqbNs64dN6EOcLuKXKGK4v/I0WA0CqCMw4FE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977c8fc8-4244-4e9e-aa55-08ded86101c5
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 17:40:28.8888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEKoIrB78a2K2TO5UdRpo3nbW6FnVRXeLqauqPOyWNDOfbs7YCtZJZV3eLMd7czc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9760
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22726-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chenguang.zhao@linux.dev,m:leon@kernel.org,m:edwards@nvidia.com,m:michaelgur@nvidia.com,m:vdumitrescu@nvidia.com,m:jiri@resnulli.us,m:linux-rdma@vger.kernel.org,m:zhaochenguang@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime,vger.kernel.org:from_smtp,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AC426FC070

On Thu, Jul 02, 2026 at 03:34:22PM +0800, Chenguang Zhao wrote:

> On forced reboot (reboot -f), mlx5 may enter shutdown while ib-comp-wq
> still polls live CQs, causing use-after-free in wr_cqe->done(). Drain
> completion workqueues from the kernel reboot path before device_shutdown()
> via a function pointer hook, and guard CQ processing during shutdown.

I think this is a bug in mlx5, it should not be destroying things
other parts of the kernel depend on during its shutdown. The real purpose
of shutdown is to DMA quite the device so the kdump kernel can recover
it and use it as the kdump NIC.

Jason

