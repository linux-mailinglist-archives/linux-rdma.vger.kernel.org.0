Return-Path: <linux-rdma+bounces-22897-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dWAVHs9PTmpWKgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22897-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:25:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C161726C86
	for <lists+linux-rdma@lfdr.de>; Wed, 08 Jul 2026 15:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="YSAaNh9/";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22897-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22897-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E334303BDD8
	for <lists+linux-rdma@lfdr.de>; Wed,  8 Jul 2026 13:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0B62F8EAD;
	Wed,  8 Jul 2026 13:17:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013008.outbound.protection.outlook.com [40.93.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF47D2F6591
	for <linux-rdma@vger.kernel.org>; Wed,  8 Jul 2026 13:17:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516655; cv=fail; b=OBkNTKFXF+Ey3bal8rMkY+jJFl+ZjrTliVdU2YhVlj6Nq2XGUuRFnCG+UI9xsXz0aqZwYdFD0ARUssoCMieaBkGgD41ooZUwMEczc18ORmgDyRvTapLZIfslmvZnTdE6o2+HpZucxBUqFpavoyN98YMVJhwx5eZG0GTmYeGi6Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516655; c=relaxed/simple;
	bh=AAOcqjUrk3d7qC/VUiXk2GCqLRESEQ7ZcHx/0pCcik0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eK51FYiPmLKKPAloz43ld4mt7DBm8krJ/bGXi9zxBlnEaI5Wz9yMYQeTvH2/AOM19uPnznxwOsu9iKFmz2qqHVGateYEKMXZn9uZclasgpuV6aaLCa9O+kVucM129bTL1D6XVywrFh8EaRlgi/cd4vOoggN84bNuU4J0kf9Xn+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YSAaNh9/; arc=fail smtp.client-ip=40.93.201.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpSMViZWZvUZxMiECFR1bdw4A2iT58SebeTEfNQKCadb93Rgb4gDrj2guGaFojm4oXAvTeKSsX/e9bAOOldfxVi/6ycTLi8FITnuUGvdc3v5DuaireZzyK2q0QjNoMt2zSHCb7n10HFcQ+vqCYr0sStyT4PESLDLCYJ2qRdlD3KxjRnr8gD/ZMameBVC4NO87ZHRFD9k9T6COYNPQ0buYGVEVgf20VRczXKz4lKw5wAw5q1CquqSf/yWtNacC6e0yKiF4z9rZ1DMdbtjkY9EHmh4qGgXOLd7N3QIwmcal4ZhjL5FrKHfkHlgdtvPDnTj4NPyMDNCmGqO0WGC2tjkHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTESh2kRK5j5aZHZOO7mKDh0IYqdsWzXoajJgIBBJko=;
 b=orhya0cNuft/DBERAusueWpRCdTT2yFU/w4LEkluuOcircxJOGFNieICj+wIDxpP+NBKKmoWNkdkHXagmK/35nQxUgVdw1HqIy6YzCA7i7MmIm/zy0ICHRrKEfepk6cVXCF9NxAXiBjJVZaS2pj/r5x49JTnWwVN4E97vRqL9DgcSh/0PZMK4JWP2qF7Pi/iZ7x3mfquKfXZv7RdxIoWRrIqjmes2tzr/GdapuBqDMj8jFKfX8yrxgaaHXZOhcOMURFZMuHFeOyl7T3O4jk9wM3abS3Lt1H1dkVo2zk3jemDWmHM6NRU4pwJFiTSSKz8fLYfUkWpWeM08NUBMIgzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTESh2kRK5j5aZHZOO7mKDh0IYqdsWzXoajJgIBBJko=;
 b=YSAaNh9/4BJyck32CIVhR9hSTlvIcbiIn5D0LeR+w9PmuFUFEnchRMK0fzwV6r220gUz2UmN0b7ZQmSdQokSGoRE4r0kvBPM3kmUJR/MtE4AZALRPH3Dy/CLh2k0NqihVVDdr9dXV+Qu8D5I+bkxmjgIAb11ggsbWRqQeivbMxdMNCIP7hMYNTKq7hSZNJE6dPHQeMQoc6oojsMyYQtDBDpJQHFZTs1SaBfv384sfvzuXPzglqS7I59LjuP5nis5IkhJtOTE8nGPvwlDSRne+jZFxbWS7ulNrZDQNiqNdj+TCWC6stBHpMFmHVpkSyZ8n8E8eU4x/F+pIPAkFZ0Wog==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB7682.namprd12.prod.outlook.com (2603:10b6:930:85::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 13:17:30 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Wed, 8 Jul 2026
 13:17:28 +0000
Date: Wed, 8 Jul 2026 10:17:27 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [Q] RCU usage in infiniband
Message-ID: <20260708131727.GB674038@nvidia.com>
References: <20260708092316.Qb39F_B0@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708092316.Qb39F_B0@linutronix.de>
X-ClientProxiedBy: YT4PR01CA0252.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::24) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: a56b9de1-1b4e-411e-2de1-08dedcf3427e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|18002099003|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1aTVYsG+saXv6G8Y5bPN+jB2eAQZlj+mzbyFvg1ianUYIMdFtsWASwKdmLpX/9j3FIfxX+zftINC+//eMlUGMKwkekUqD9+ujmDnJCbsjjv8lTkDeke7ktvIDyM9fwBm1xyD1LQ2xDiSTBlAVDnW9ZUolfvjPRfA6MexyOC8tf+5Sxv20P6z0NSqf5Dac9Yl7ZX1cqYhlebwKZ7yWPlH44xpiqjSxBJfxxAfPe/aNO2tvxtt1YW4TXbLnG/Q9vhUKoOhAwWieulJhCTtPl8l3rYHoXIp7ToszsCvtuzrq7puhGRYEtmjkJOzRJjbMMNTudfpqk4PCNyFUiF7zymUwPLfypRX2kIdUI8J1IAecQcmpiG2kI6t5HXI4uAcnMDn6yrnAW8uEpa1BHrizS2ekEe9AhfbUTu2e/TgwAqcWsqm4gg+854Y7GClngO4K61Fz/mkimqyvBA/EZjW/sjIkGm9+uJ6j8XL322R/Zrk3MqXz4T58TskyCMd3bPPblzbRqEYwsRhyB/fN+4I9TULcG7jb/h++6qfc6xV0FheLqOGtNlz9ZL7KoehUH23+d9W+mHpG5cz/wjAbukguWTnjqDABE66EbVw4FJi+Fg2MU9U8J7h6GWwzDbTR4oyYsAsZLIBy91neoewP9Pql1jL/X4FsM6SExRsx2wZAK7peg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(18002099003)(56012099006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/tbwvkM6u/j3Rdi3NuuhgVmvOKE79Q55RFJznaCTF0LW8xPc5Nnt0NxBrw7?=
 =?us-ascii?Q?weAoqZGSlnEEi0qXgw5ECOdAy2Ji5vc/AbqPTTQzEgFEJBZewWvhHV99NMXu?=
 =?us-ascii?Q?jQwrGBQPFmLUIKspGJIc9tHpJKKbLadkP61vmdGjZcVr+n8KEkr7KeXKyeSU?=
 =?us-ascii?Q?YFGibuspFj1xBUN39TIIgyCb9VE667W2RilmQX0gyOyHaD+x0Q1HOhiSs2St?=
 =?us-ascii?Q?I0jJf0VsptUMKiS8AaOb+vfK8WWDc2YsGW9N0Y571qoMCWgF7WxkbVKX+wFc?=
 =?us-ascii?Q?b9puCiQEWRuBbUl52cewMnlVqB3vD9FujqjhvTTjOAzP3uA50nL8pYG9k81B?=
 =?us-ascii?Q?INLrGmHQ3UrujdCwXtacTGsPnRpWroI0KeYW4wAPKjPfawLfGwK7ASz/EbT9?=
 =?us-ascii?Q?p23GprkxVGYqG1N8tNDZWLiVm8P12UrlsG28bzw2g1hHlWHqbk8lhQVbGwof?=
 =?us-ascii?Q?NuGVcrZmwyFPaZXl1FxVB+ZT/F9EHKI3b3ShGri7wQDjytF7vi44tlWOMakp?=
 =?us-ascii?Q?ZKpFR1Lbi8cA8hVpR7iYEa1gqJRIvnbrExoI87KLyisjsyOiXPFU8xqlVOpt?=
 =?us-ascii?Q?x+W3BvNIdIk8BbZGmCJpl+bI69RPpx+Er2U56cRzuUrPI2gVE+qq7Dh1gMJ0?=
 =?us-ascii?Q?Sdpf24aoJ9zwDEbPkCzU0dRQwqXLdzp8dUL9FJDeuLRiJ3XrBbvwlzcknqSf?=
 =?us-ascii?Q?DGYKA+/CUgjhenJNR5E/DY5aFeda8wCU4aul0Njo8ttH0p7R+iOHMLBLe6fo?=
 =?us-ascii?Q?Ru8j6F+3XzDGaUIYfDQHSZbpIbSselyM2UfVyKbg3hyxsUGkazcW6Eam/GtB?=
 =?us-ascii?Q?Zo54dtvtQy/YDBcJ81s6OMXgpySOeUsWcsskPcc9ETKhkuzOzMRCRZ+xqVIG?=
 =?us-ascii?Q?Gl1REuqh+965P6WwQVDD3AiD69SRT9Fek+cgcC4hYfrFvNByYF6bM5fjqVf2?=
 =?us-ascii?Q?sncTsZ0CJBclgLDs8M7w1b+qddEGeGHr1dmzkN1/WtZiy1y2sKTZWw4oXt/I?=
 =?us-ascii?Q?ndz5Yey0VqNNQdT2gbkVhUQTrPC/ldtNqIpzk5K5xH9sE+5e7IXaDgqOPsFW?=
 =?us-ascii?Q?RRGKsFZp9124CjnRWuGGKMF0CCB+sp+r8EpHNy10dwHuHLJwyekPfjeClArj?=
 =?us-ascii?Q?NoPy8bDu+xaDuIVJ0zlBDbIoQ57b8fgrUNqv6HnmCwl++ByWWVY26MJkm5cG?=
 =?us-ascii?Q?YHfhr+WuiaJ0Xu5fChzd3jfIPZSqA24wt2MgBLT5kd9trTHD/UmHT3LkXliB?=
 =?us-ascii?Q?YsMTspAXzPYxlO09VwakldQivjjbdnPuHaJlyIVdvD9O40W4EKgkk2ssQnNu?=
 =?us-ascii?Q?AbZ0Ol88Jio6dBRDKxeyWSUJ9pfRF8aDPIFWbPiNJtrviiXNjS16iTWiXj1y?=
 =?us-ascii?Q?U+FCec0M0ouTWRjt6FAjgD5f99xyCoRMXCILnNqRDvnADml0ykxvul5EIFzU?=
 =?us-ascii?Q?OxOUcsfbS7Hf0AZaK6sqrVgPoY0CzPxr8Dq4dg28MUTN0+gdc+WxGWYgsKF1?=
 =?us-ascii?Q?CUYbwb+WCp2jv/DFuJ3m/+H1laVQchQcF+x4wC7iIuzPyiSudxjtHnWg5b9H?=
 =?us-ascii?Q?ENp7KNgIOu7MPm3M7NNZJ+QR0MS8+cZx4VYuwZuucflcpwOi5vc+rKW4XCLh?=
 =?us-ascii?Q?Ip2uYiOkt1UqkvZhxB+rWI1Kesyj9UUHTUYu0zJknWdB3oN9UZrH2AX6zZFp?=
 =?us-ascii?Q?F6OIFiz/G2lpTZuLzdzgEUSLA/SuNnrOnQWL70wPF6WuDMh4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56b9de1-1b4e-411e-2de1-08dedcf3427e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 13:17:28.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J1TpkFIb0X/AYsCuEREvOQjgf1hPl75CtvW+7OpJv0FY0njW41wrQTXiXgkRQapk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7682
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22897-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:linux-rdma@vger.kernel.org,m:leonro@nvidia.com,m:petr.pavlu@suse.com,m:paulmck@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C161726C86

On Wed, Jul 08, 2026 at 11:23:16AM +0200, Sebastian Andrzej Siewior wrote:
> Hi,
> 
> I've been randomly starting at infiniband code and noticed it uses
> call_rcu() with a callback from its module. 
> 
> | drivers/infiniband/hw/mlx5/devx.c:         call_rcu(&event_sub->rcu, devx_free_subscription);
> | drivers/infiniband/ulp/ipoib/ipoib_main.c: call_rcu(&neigh->rcu, ipoib_neigh_reclaim);
> 
> I don't see synchronize_rcu() and rcu_barrier() there so I've been
> asking myself what ensures that the callback completes before module is
> gone (via rmmod)? I would expect a rcu_barrier() in
> ipoib_cleanup_module() for instance.
> 
> Is the unload path so "late" that the callbacks run before the module is
> unmapped or is there something between the APIs that ensures this?

It wouldn't hurt to have a more explicit unload synchronize call, but
there are already some existing ones on the path to unload a module
that would cover anyhow

Jason

