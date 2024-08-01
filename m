Return-Path: <linux-rdma+bounces-4165-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9374944D1F
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 15:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D3AB2291E
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ACE1A257B;
	Thu,  1 Aug 2024 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ji7t+CFn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACD016DC02;
	Thu,  1 Aug 2024 13:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518729; cv=fail; b=MDzdW3ZB+bBvQe4S1RLQhfdTeVNuBEHDh2WwGOeybOBkpo0acCUCqouoseBTtE7bXtTKVmfogT/IKwxtHS5FBdLP98yVA8RoDQBNrgLjvGdA1UAT+xgZzIqocq0K3OcLF9cAAzt3RvvCAbzYRfTYDAWKM+IZ3izDWjTEqugJL4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518729; c=relaxed/simple;
	bh=AvjvrzX9r9BJaBVt4Mgzax7hwEEsOVQOhM/2E0P5TEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YT9je/zhqUZ1OGtIhJ0kIK9lt1+1iQKvAqyhqC54h/UAUkaYsLSSF1QbjfXtueLy+TwISuk/DpB+C7k0asmv9NJwYSIrWECZuziaVWSH91+xERAEiUDVHffUHPHXAeUm0DCYyDZTCCDFSpqSY+/pnYQHDmKEo0LshuMTv4/goD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ji7t+CFn; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKwJxMZT2iPv8YWwtigtHQefMQRO1ee9oOco/KyPZfvcu8Jx53WUprM0E+lXgXqNHNstVXk+cAKserJf7+7L3+iFqb8y2+N86nmoII8y4lZP+UHI7NWzBSXRjWvb5tyFp89QxVwBl1OuE3bIKd/O/4Q5c5+gGZxF5tW4gbnBCs2YlbBZAFxn4xYbBmaImfCTSNN7LG9lTHLOq4fPPWjk3AN6+J6NfmMBlVJBTICYSIvR+Y3/g4SkUuK5RYQ60XBjBnmiXKw+WO+mvG0Emb/qpu+aJSTBJ6jfIClf5AWcoCivfI2jNXei4U0rlSyA08/mtXyYz2CWSysBaALfcCcxkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBJoIHAL3TbE+rj4Z0Lg+y+zTJjFA3viH4F/X4Zl9nk=;
 b=GeXCqPzLEGIMQoS2KH9iWi3oZpDY08QXZ58Y+fjEOoPkRBM6/JcjAWjI2YHWc5sYcRtp2f1Y2OMDl38WdeCwfws+Kc2WGZ37q8LK8VrdjZQTZiuo0yzztwtXhVqVSo3hVyS0p4bLACxE1kkav2hBr8IZljRs4v4jeJJQPoUmYfJ0tYD40ELwmlofrEG0K3kpQf/AyDcqcSqIiRzts4nnSf3GyT+Z1eFGxykqPh/ULLGGMkIg7IQfQDB5QQA0WhVtA62y8Pn89ybJa4+QJM/W+NN+oxTq8+XM2cnrYbXRR+YHb2TzC7IDobEvShNgIP5cVu9j+hAu0+jGlCoa5nH0bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBJoIHAL3TbE+rj4Z0Lg+y+zTJjFA3viH4F/X4Zl9nk=;
 b=ji7t+CFnuWVZ5Aa9wyEReg/O4ZIx52Ugtn4u9Bj8n2hQyAhKqSUgjyDQZkFPvgRPBg4vgJIXG8ZNASHNs02CN3SS3Mo7/srEXEtkMmm0f/x1fL/d2txHk+ACYZUibAdSHaFGmV/31ufraP8EX159OscieFSHRRKzpy/E3IIsdkcb/uGqb6QsiosfOX3lotOLxTZinR7o1A8y4IKpccO6kTTQ5gYghJC5x6LRFdWoofhU13TiTnYv3N/R9jgE0+VYT16B2m4lYG3ufoD7DSj10coxQQHQZUrPcZTUm9kAzVTzBxS8G7TV2ut7ArSYPQMPw2nRDJAzG0t4FoWl/z1khA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 13:25:20 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%4]) with mapi id 15.20.7828.016; Thu, 1 Aug 2024
 13:25:20 +0000
Date: Thu, 1 Aug 2024 10:25:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 7/8] fwctl/mlx5: Support for communicating with mlx5 fw
Message-ID: <20240801132519.GD2809814@nvidia.com>
References: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <7-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
 <20240726171013.00006e67@Huawei.com>
 <20240729162217.GB3625856@nvidia.com>
 <20240731125232.00005aad@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731125232.00005aad@Huawei.com>
X-ClientProxiedBy: MN2PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::42) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a4c8ae-eb13-4ce1-83c1-08dcb22d63fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alDpo5+OkO1qXeA0yLIacYuuu1isfcjpLTXqFICEBDbYB42FJUPKhAGRAd28?=
 =?us-ascii?Q?P6LdIoTW2Nl95sWchFrqAp/x0bg3n/zCvLaasnD+B/gf5A+a1G9jKmHyMh1L?=
 =?us-ascii?Q?xPKbhesLwTSDLxnuQTTdd5oSdg3gooO+Cu4Gh3PQT6LI2s2lyPz9m3nhj/Yc?=
 =?us-ascii?Q?VpQezq7DMDgc1LSRt0gGsVQJwpQu9ZTkrGwTIgp88SGbejGhdZOa99p45VD1?=
 =?us-ascii?Q?9+alg1SRGY6OP10RudLP4+ZeqGpnzqx6QQ77fPptjT5SIvoO1UcDoKJUUcPn?=
 =?us-ascii?Q?R7cS3lskmG7O7KlR3PCcUO10mgyDzTFHyf+NAlrn3SXclP9gaXAvy8WCjMUJ?=
 =?us-ascii?Q?XoodvCPvRooqpbdCNA4Tu5SFufem+dSIoC3GEQVoRRN6YTbN1+ph5Y5sKkoY?=
 =?us-ascii?Q?qpw3a7NNuRiRTCh9WnOgFnAkm8PStyNUU0KNyHTeiw3X3vxApln4Dr5IhnBg?=
 =?us-ascii?Q?0GZ9tMUkiXM0cBUeBIAr4ccueGsZ2MG5c7HY7gFxD38bHnjuOBenQOycNV+3?=
 =?us-ascii?Q?CM5NCJDQ7gwKaxakQoPMOQnhskMXSJwdeDYNwE4jntiPsyNmPz/4aVwgqTj3?=
 =?us-ascii?Q?HWOFkSUWs7QQqrbD0Yds0z4yK4iQJfySMbHhVc7DIzUlePdrrU2rINa+pV7P?=
 =?us-ascii?Q?sMo57WHjBRVcaa/+Ul0UGwzQNemKbxAZmohoMlF3dIJjI4ihxVMItEtLOoeL?=
 =?us-ascii?Q?BQetXBai9PTjQN5/pX3lnlEhul3yRM645h5FNQ2ksXGdf5aegCqwhhgqZAfd?=
 =?us-ascii?Q?txkAit4QtDIb2VEo3wmVZQ7dCz7AGB/0gt54qK6dFX5Y01JirOcjCXbZDRSN?=
 =?us-ascii?Q?rTk0n3fJVm4bPhr6/5/pM+nqeFEa6hh2oIwAOmq4IhVH6UhibiVjo0CmQhNd?=
 =?us-ascii?Q?7D8UqkMRPH40eiJN011LPX3n4wgo7EKE4V8lLCIYI78SzlrF+2OS+ZxIVkgb?=
 =?us-ascii?Q?yogBg1lQr58JR1Z3N0theWLOcLZ40ZHCvEN7nxZ+wA0GMtd3Es5Qs05AnSC1?=
 =?us-ascii?Q?lOXpzUbD6cuV/LncjpLjahBn9hpahNJZSR1WeKZn+s0ECns7OfQbcuc3ZwuE?=
 =?us-ascii?Q?tMzzFxMBXyfMQtt6r2KySPswVYxtaq3j27j9/JmgU4dwSUi4oau87qoDKehZ?=
 =?us-ascii?Q?uYH8Xp1WOhJoVJXPsKGAkbf6AOPFErd0/BLv7jbKcjWcZbMxsw2G9LzqXayr?=
 =?us-ascii?Q?Zg2t59x4ngWO4oZTxW1UmHhBm4QHdzAhTtNts3xbc/Eqb+7jbqhTMRJrGLLq?=
 =?us-ascii?Q?qqKBKFFUZoLdfL/iAaErheLP4gxCDOirDf+zfzPIMe5+QwS1DOTQnkh5++Bk?=
 =?us-ascii?Q?mvkAdk9v58pFhm3IfAjdHV+3xhOxHIm/z0cM+M66HFvo2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZQ2DVGJChbTcC1LgwEeOrcW1LZk3X3QDT7jmisjp5wT14ZhH9zHBgWVvS2Oh?=
 =?us-ascii?Q?ddOxZKTetm3Ysk+Pg3rTqiRhzUvrUBx3kGSwmWKJwF9tdcHd82JNaJEkMEsd?=
 =?us-ascii?Q?3nPsptslKDdVNmzQOwDHMANBbnvd5/4F2lXdc9wuviqsHhuZ0CyqugMZRSxg?=
 =?us-ascii?Q?Wc2bmdKRh+Ab1ETD7Q3c6mgtxa6aZ572EIHglj8gQtJWnyelJ4ZoS7se64Fx?=
 =?us-ascii?Q?4uo5mfTfS/WE5HPozjDKN08HgBdRAkYeuFs2B8OQEGXKvCXaCCUk1DDv4YQJ?=
 =?us-ascii?Q?r25y40hsfTVVj/HN5Zxw314lK7FEqPGQ95xU56xrlnfdAZeenYK+XBKSWhMt?=
 =?us-ascii?Q?CnqAwoP1zw4vVs2ulIAMGEh7hv9JLaK16K0ugPEctno/aw6tVC+6uYHYJ35o?=
 =?us-ascii?Q?RIT673yI7yc9gLjhp6oiNHBQCpTYIDG8ook6XOZLazEYVaG9KXfI3OiLOrIV?=
 =?us-ascii?Q?aAVGkee1uVV52ObhvB/tr7sfdVfNdHtbNbYJdiMf7NdB0LoKx5xVWLuIwiZH?=
 =?us-ascii?Q?u0y6l+pfO+tla5W3GjAnVjRa1c9j53EUFuvJE4sBNxJOIMcW+dQeYOsDTJmg?=
 =?us-ascii?Q?SQan9VP3OFXaTMWIEFOFZteFHUACk4bkCC1P+AwzlTyIF6EbttFse1lyqPaC?=
 =?us-ascii?Q?84gb4CxQY76OQShgxc2Kem4MqZ0qZnSoUymfiE2Jtatr77LUHKwClNAnDM6K?=
 =?us-ascii?Q?zX1CeZ6m64zQZaSi/iqWRvRh8g4Ngx/EpQH9P4a1IUyM7bDHTQ2SHLDx2eW9?=
 =?us-ascii?Q?JxHOLxLwVb3kw+GOA1XuKXHFvPU2/coWLwsUlCyXBibUPaKZ9jh1uiwEs158?=
 =?us-ascii?Q?gCiu8SxKJ0ZY/38+9MvIObjDG0u2i++of+P7TXQG+cYPKx0j2vy5arTivWmk?=
 =?us-ascii?Q?C0hoaOemFfFQv0o/ZFPlRHXtm7O/YRVmSoCjWylYFX5ybev8HGeS7Uv71soQ?=
 =?us-ascii?Q?VaWJ1eo2H7UVwu1gFyVuvoHTnGOq4Q1GiI6zCip1V0CiF5wdzirEieGh41kK?=
 =?us-ascii?Q?7XSKTvrWX2vYH4LxTQ8/kfuEr/eNF+GQdT9kalAk7Yqdmuyn7IsAxrDE1X0t?=
 =?us-ascii?Q?5Lhi+V50bAyFeAXU3jJUqELPqycf/pB14WgWzOqckRPzNcBqRj+npHUmHQDn?=
 =?us-ascii?Q?V73VoCR/wValu0z6xWOs2UjzMOVfsT08EK11vl9W1Jit/KErc7xkuyxGKSfd?=
 =?us-ascii?Q?/DfsmO/gab81N8d1Lxlef8dmSVdKPa7gD/LgM1+2P0ZCpU9+xaYXmeMYl4ZK?=
 =?us-ascii?Q?VDZFIhf0um/13indE9lhfQPgCMchINbNwEaOSddmb9bjOR31r8B9EvM0s0Wn?=
 =?us-ascii?Q?vOjLz45my2ZraciaKS9DKhxk7lwDYOtlW1BEL59Uayd25V6x5DwOhU3s+tC2?=
 =?us-ascii?Q?P0QQnfY9NNKEcCyidwOnbCXi+m4gXy010tohiR+Sth9J11J2TajWu+IOexpW?=
 =?us-ascii?Q?lm1oWJOVSqZvlKDc+miDCJHWhNTupdy07N6VV6IjxB1t/LIUsfJZta4reWfn?=
 =?us-ascii?Q?1N8zyUamqNbuSq8G1TqqSEtosNEGBGsSDRhowtTlaMOYLqU0v+slzhAjNCxF?=
 =?us-ascii?Q?yaK8rg2qFC2OXvTavoFsZMCxc7khYYFDnjWW+bNg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a4c8ae-eb13-4ce1-83c1-08dcb22d63fd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 13:25:20.1861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aiTOElp8mc08GwyFDYU1/cPcO4mI1RVoz3lXuNctxJ7NasECFn1iuu57j5WT286
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786

On Wed, Jul 31, 2024 at 12:52:32PM +0100, Jonathan Cameron wrote:

> Thanks for the explanation.  I clearly needed more coffee that day :)
> Personally I find this to be a confusing use of scoped cleanup
> as we aren't associating a constructor / destructor with scope, but
> rather sort of 'adopting ownership / destructor'.

It is a pretty typical "move" concept for reference counting, as you
might see in other languages.

> Assuming my caffeine level is better today, maybe device managed is
> more appropriate?

Oh, perhaps controversial, but I dislike devm, so I'd rather not :) It
makes exciting bugs, IMHO. Someone (Laurent?) gave a nice presentation
on some of its nasty edge cases at LPC a few years ago.

> devm_add_action_or_reset to associate the destructor by placing
> it immediately after the setup path for both the allocate and unregister.
> Should run in very nearly same order for teardown as what you have here.

Yes, in this case it would work technically.

I think devm would be more code lines, more memory usage, and more
failure cases though.

So, I'm interested that cleanup could be a better option. I view it as
positive that the success path remove() flow is actually documented
what order it is doing things. Order is very important there and I've
seen enough places get things wrong here over the years..

One of the nasty traps of devm is you have to know to have your
creation order match your required destruction order, and *everything*
has to use devm or it can't be ordered.

Mind you cleanup has the same order trap, but you don't have to use
cleanup during remove(), and maybe it was overzealous to do so here.

Thanks,
Jason

