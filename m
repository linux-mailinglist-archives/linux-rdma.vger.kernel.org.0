Return-Path: <linux-rdma+bounces-8978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5437EA71A22
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 16:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4863BEC20
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Mar 2025 15:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A4155322;
	Wed, 26 Mar 2025 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KeFSNSsG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED4B1487FE;
	Wed, 26 Mar 2025 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743002226; cv=fail; b=MaQTxN/lOPARUSCvUbyCiTfJkvyoXnDjWdvuNo02AzKdgICSprcO/HfCRtAhCC7xCKMYO/+5u/d9nePa900+zlX3oLS98ZxOqPUtzvKJIefbHXJUnt2C8OsksCDDFDUa4OEHldjhxcVXIeI0gT9LgPhrk2PgRdupRQvUZN1iZxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743002226; c=relaxed/simple;
	bh=Hcw5P6Tu6kBvl6IRDavAAyciaR/coLlw6OLq/EAhby0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a/B7CDHa57pY5LumfF4JWPboKmWvSvnJ86NdxP3SmvqLZpWjywMM2a4oDqUmXGfiE6iHSy1fz6Hx/SZ9jPoHNGxJQcHKi4Fkq1rfFEaC81ZZFrrUEvzpXM5p/MsJvv+P5V5zsinM2R7AXkaHQWorbnoNlB5wHkLPHZ6LnSxf+vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KeFSNSsG; arc=fail smtp.client-ip=40.107.220.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEc1QjdUnQJOc9l8E5UgkNQBT25WdlH6USmxDBZXvO7rZeqIRjqjPQ37KkwpG65JQE5s4lkBPgGePCpKEKmlTFxNXEJC7Lw+3C6jTjfU6yYvkQk8PH4OBgEzBT4rqQzjoEsZFQMgcvMcPtdJGR9c2VYq6Ixg3AQYFnfhLSzD4uV/6lObl/BLt3BBKj/8SdTlRgR0U6tufctvfXzMCzslrZaHbFGvOVx8wnw4sXdtNtDv+1w4Q3G7w4+imABMSFwgF2RiUpvMoFn3gyXOT7ryIOAXE/etjArfjlHQ+sQcVIOTPJQ1nnvKr8SwV6qg4XwkmdKFFU4Mw0yvosHPXdQnLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQuQZdF9VXB5x8927WzGMaqq3XP4regDor8X2dK5IxI=;
 b=UxaCLuMYiYRtaeDiTIa3V2v/b9Jw59N3Aok6Ge9DG1cTEb6DPT1/jweolZQ8kDKnKHU1VSGtzucCoDwrvd73QGioaiQMbqzA+mrvKbnS3whhTlSgMWvaJWoj6FoIL9mlQldHySuDk2fEiUNbrsH69b1iKP4EB2mU8wqwZI5HFDc6EitNt82dvmEDXef4g3BnjvZfTtSY/vwoC4jNkPScptjrTByxDB/aHr1rfZ352JqPkXE9WV+XGOmqsJLNwX4UYxR7raq3nctJBDXVxCFwmW2z9I0YfF2QwRRB34x3gBO6c+lWPj0AoZW79IWztpJgBBGy25g5NEN9+QORvbGBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQuQZdF9VXB5x8927WzGMaqq3XP4regDor8X2dK5IxI=;
 b=KeFSNSsGoYGpXHTSTHju3/hEgAYhFacg9RXxOl/JyYBqANyCp0bHoDfxByB47jrF0cF/OCvziAeo6kNz2l2GGowOEfSljAmZIHTBuCJs4XWs4PvAh6vaA1j9adK0eTCgojpA6JZbLf6OFNY0WXxaiR0slFil+RhVOdi+5i0E5QXBJE/KwnqfByVKNaiqkYxCYrp2mHKkScA+diK3E9fPC9w5mOC8YKxXtiEMEUtDKZH8QNIrgge7jR59WqUIEV3xExuIY218QgmGSO2mYWbldomBZ4TiSXqnxDZrHcedxr8VSNESBQ4SeDe9yPoIiSdXwH6BU/949RZ2YQh0vFwlMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Wed, 26 Mar 2025 15:17:00 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 15:17:00 +0000
Date: Wed, 26 Mar 2025 12:16:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Roland Dreier <roland@enfabrica.net>
Cc: Nikolay Aleksandrov <nikolay@enfabrica.net>, netdev@vger.kernel.org,
	shrijeet@enfabrica.net, alex.badea@keysight.com,
	eric.davis@broadcom.com, rip.sohan@amd.com, dsahern@kernel.org,
	bmt@zurich.ibm.com, winston.liu@keysight.com,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [RFC PATCH 00/13] Ultra Ethernet driver introduction
Message-ID: <Z+QaarAjCb8pCYpU@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250319164802.GA116657@nvidia.com>
 <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgUMKhB7nZkU0RtJJRtcHFm2YVmahUPCQv2XpTwZw=PaaiNHg@mail.gmail.com>
X-ClientProxiedBy: YQBPR01CA0105.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::41) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 812d6ebc-a11a-48d4-2a88-08dd6c794138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ZstiCU88vP/ccPFOurCdkbDHRYhunf+j9UB29gsp/wC9GTkrfmBkbFldR4g?=
 =?us-ascii?Q?8cQEcUGSlQYOhyfTm9JV+srmFql5pCZkyzryHCxkR75kNnBx/nMcLqlJsd3W?=
 =?us-ascii?Q?muoRglapXcPdwOmBHBU5RbcJ6kN8OZSTkUQCXQRYbjsrJwZQnNFimkiacjBL?=
 =?us-ascii?Q?cN3uRuUsUrFrUKQwV1kI+cMAbuYILbXx7sZYVoxA7W07A8Tqzu4Yu2xJAXSK?=
 =?us-ascii?Q?6+F75Es1KXW8KF1007wpv0Y+e1t7u32izqQNpM7AMHrIVP4fnHlSqkJYodoK?=
 =?us-ascii?Q?1e4j3t4gKyCvbZXv/2G0AD22ihLAAZT+aqzCkAzBn0q0DhYPiMR2Vc9OVLLg?=
 =?us-ascii?Q?zkUC7YNraNPM66JcQX/3Zbew16VDBgVbBVtrz4p+j2tSJNe4yHKkoq0im6m8?=
 =?us-ascii?Q?5sDq+FP5LwlcRdDavbyeLV+9a/J7lUwPa+LQqbOcF2z7mBHc0nWGoecE7AT2?=
 =?us-ascii?Q?MmtRkpp/YBujqg1gI+q1N5zdRomUllRdgzQXRG8OqQ4qwDKuaTbTrmeFmV6F?=
 =?us-ascii?Q?Zqq9VqLUXZY9G/BS9mNlYkE2BfdQITTMkxMYrQwTpnFRbi/Aj/qpP2mPN8l/?=
 =?us-ascii?Q?rQyhh3xxaa9QNB1Jdh8Q8/MiPc2qCwouQWVwlGxefrC3uYoDfCPSnzDwSo83?=
 =?us-ascii?Q?K7SF/IONjZX9lxnxwqTjr5fJY4caCFszwev8Xgb70m+RYbu1EE6fg/ZV9IdA?=
 =?us-ascii?Q?LgLDzskax1B/5Nfl7IZL1aV6eT7ro/9LoaQmilUVV4KgRcBAHPxzs65nxU6R?=
 =?us-ascii?Q?dBfEyFvKmx7Z+sZP4QwVovj4m9or4PvMhbl3wYi9XaJ9+wLh6T+EqFuws4/V?=
 =?us-ascii?Q?N2uiBsXA1HzfGPNUbJxizUgw3XPuYYm6+GBGUmc8u/hZek5hH673+n/2yWOU?=
 =?us-ascii?Q?4iSqpw4ns4W3gXm6aVRfehWMakuwkfmb5BknDuzHhRMAeGPfGl3zmFf3ZwQa?=
 =?us-ascii?Q?/H+/v3xjxpybBCW81ytnUg8NBbPcPV+NG7bj7jYyrwrMQfw304Qjb9c5iI68?=
 =?us-ascii?Q?ZN9MC0rAK2gCI3jGNFNL+8ZzVXPHIGKpLuAKrM8Lfr0VqTBk81E09JBVK70p?=
 =?us-ascii?Q?pV+TKGq+C9Y2AY3kuOL3ngit6ir360/MRlY2cnMvj6mUjvj2tOjbS/pD6GCV?=
 =?us-ascii?Q?5pGMG3f9HXyUDGcyjhgvbXMBcFQNq01x7NU2nRSydDzE/R4CEMAXXOEyf2D/?=
 =?us-ascii?Q?YaqVXFCiTguDcilFpRDvMbQqAV7HJvTjz9lHLyLY1J9ZF1DYQJPwlSlcDpEL?=
 =?us-ascii?Q?uvJ0JuqSXCV1i6ea+X4eP822Qn7NVtH4gP7ojbNY8wXwk46fCjM0dmW4W8WS?=
 =?us-ascii?Q?BnecXNJ3yEKo98bJ/JZ/nktwUPxO+2higzZLHU2i34rDg3awLPqk7XMaQAsq?=
 =?us-ascii?Q?lCAWGL1UqRUSCnSK98sRfIYaF02E?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YTr4/kN7+B+QpmNOL/eKcxfYulZRLOvHmUWp33edKv2apAxI/znPnVJBgJuv?=
 =?us-ascii?Q?ykgjlK992RqUh7+GkvMfVnUyZb5zpw4NQ/cJehLJTivLCCTa11Zq8zG+IaCx?=
 =?us-ascii?Q?HU+Kvc3hhn+1TgXPvTODL4ODyFTPUCjjjPX1z75d5iuN2alJMp+aef1nz8DM?=
 =?us-ascii?Q?2iaDJC1JuEtKsiEZ0T3FgapxHB6vd5R1BZC2BdWqPdx+UemQbKiva+TD9mmG?=
 =?us-ascii?Q?hw8JmDwE3ScZ51JLVwRsvDBdLy+7XS7MtSgp+WcBvwc45b8LTJhRC6dSR1kW?=
 =?us-ascii?Q?3qcENNCCWcabe2diHxcn4hsAMdhx5lRvoelw0lfHwijU/henURzO+GEgrMMI?=
 =?us-ascii?Q?pJLK3UQSW/2a0Wvtyrpo6b+zPDkipdvAFNmqeFJtkj6rgbWTSiunvXqooQfW?=
 =?us-ascii?Q?Wl2U97YA+8e5MdxN2fkQkSrZQHrQ89oLNPsZ2soh0GQzWC58BTTbUJKd7VJU?=
 =?us-ascii?Q?GW8aVMlOchEazpHNBXrcEEWjSDpkaWI9CVPBpIbbqZdFl13GlUHVYUFUOTPS?=
 =?us-ascii?Q?FJq6JYRBoeHt2lqlE07l1w4zrwXGttbtXfv99ZgBUTMHiqfuV0mk5aw3uJZh?=
 =?us-ascii?Q?BKq/LhtRRtp6F7D4lu703hLA8MRwDpUm1cP7A3FW/p+5x36lIxM4wZBsEIJL?=
 =?us-ascii?Q?HMF/ml2LkB98IDDPoHkBhc/8/1+GZInVNQGVORykjzqFg9qLLNl3YMW369ka?=
 =?us-ascii?Q?uuX3CiEolom9tBC4m65gLYqtl2zveX0MV4mJ/6VYAgkAHRTM15YGs6J+9aXr?=
 =?us-ascii?Q?xVqtfFK8P0DwBQvGDNgS2y4FvYP03ASigNXF5HaHOZdVr9m45wtMq2rvi74B?=
 =?us-ascii?Q?N7lmdHKchBEp/w5k16KlWKVmoURwvbZeAp5gs3APhQiYMRPY2s6kT+ptYK6M?=
 =?us-ascii?Q?w/BsicoC4JxiB1YKLXTWvgdjX/GKJ6EVt5/ljQi6tXhaAX0Gx9q1RN/thtaj?=
 =?us-ascii?Q?vznWsA0Lzo3RTWhH7wEPu3QfGG3WJZxCuj4+fcHgk8K+IGIYzU/1PE9PKdbC?=
 =?us-ascii?Q?Kc67pHd9CsS5FHu2prcC36oPFXJ8wDSq7ThZLq/ufhB7DY4mEonI4N/e9GKM?=
 =?us-ascii?Q?i9mQYlWvHFquzvxl7PBwM8/gQlldhB8/JoigwdZGefdFcX2pGiYP/jpogYhI?=
 =?us-ascii?Q?Df+A/Y3SKscF8Zr2AwAiDFXGMhemGhmnMhBfs1MQEbAecvRONKGAAAqqLB62?=
 =?us-ascii?Q?siEeVCppLHB5e4WGjcjhxzPnx7tX4UbkqdkBCAcMKZl/sJjlo+R4kG4GVVWy?=
 =?us-ascii?Q?cylnOa05NXwRVlNqvlWSi06LDZnp8YX9BUYcMkqTUePBODVFre6NsIELEKEG?=
 =?us-ascii?Q?WG0aqIP661YqDyR6KKhT1oWs1pAf9huQ85xxWYFFqJHgoXh1e7e1r62obj96?=
 =?us-ascii?Q?wPjulOhC1qksyaTne2ltviyGrFzdHqAdV9VbxMhLM2N+cVuE8SHMcjs5j6SB?=
 =?us-ascii?Q?Rb8n9rdyPh6cKzDYhluNuRjrJDsJ6KtAvYX6ls/LmjgoXQvB19P5orJQ3jpj?=
 =?us-ascii?Q?DjSz+5qmu+s2KSJXWsnOkvJ+wEvtngkmQhq46EGHuIP8JSe3nljPn6rVevFX?=
 =?us-ascii?Q?VRWrbqALYyf6u8E3vbI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 812d6ebc-a11a-48d4-2a88-08dd6c794138
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 15:16:59.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBaPwhpH+cnQHuygvWaAMsTOMxinnXs/5vCJlr078jMgSaepl/QReTu+BjI6ceOE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

On Mon, Mar 24, 2025 at 01:22:13PM -0700, Roland Dreier wrote:
> Hi Jason,
> 
> I think we were not clear on the overall discussion and so we are much
> closer to agreement than you might think, see below.

Certainly this was my impression after we talked, so is hard to
understand what this series is supposed to be. It doesn't seem to
advance things towards using the RDMA subsystem.
 
> First, want to clarify that this patchset is collaborative development
> within the overall Ultra Ethernet Consortium. 

Consortiums don't get to vote their way into Linux patch acceptance.

> UEC is definitely not trying to create anything new beyond adding
> support for Ultra Ethernet. By far the bulk of this patchset is adding
> a software model of the specific Ultra Ethernet transport's protocol /
> packet handling, and that code is currently in drivers/ultraeth. I
> don't feel that pathnames are particularly important, and we could
> move the code to something like drivers/infiniband/ultraeth, but that
> seems a bit silly. But certainly we are open to suggestions.

It is not the directory name that is at issue, it is completely
ignoring all the existing infrastructure and doing something entirely
new and entirely isolated.

I expect you will have uec named files under drivers/infiniband, and
they should be integrated within existing architecture, including
extensions.

It is a shame we won't rename the directory name, or rename alot of
other stuff, but I gather that is the community preference.

> To be clear - we are not trying to reinvent or bypass uverbs, and
> there is complete agreement within UEC that we should reuse the uverbs
> infrastructure so that we get the advantages of solid, mature
> mechanisms for memory pinning, resource tracking / cleanup ordering,
> etc.

My expectation is that the software interface path for a RDMA
transport exist mainly for testing and development purposes. It should
be deliberately designed to mimic a HW driver and exercise the same
interfaces. Even if that is more work or inconvenient.

> With that said, Ultra Ethernet devices likely will not have interfaces
> that map well onto QPs, MRs, etc. so we will be sending patches to
> drivers/infiniband/uverbs* that generalize things to allow "struct
> ib_device" objects that do not implement "required verbs."

That's fine, we can look at all those things as you go along.

Just be mindful that given UEC's lack of a HW standard it will be hard
to judge if things are HW specific or UEC general. Explain in the
patches why you think many HW devices will be using new general common
objects.

Job ID is a good example that is obviously required by spec to be
common.

My advice, and the same advice I gave to Habana, is to ignore the
spelling of things like PD, QP and MR and focus on the fundamental
purpose they represent. UEC has a "QP" in that all HW devices will
have some kind of queue structure to userspace. UEC has "PD" in that
it must have some kind of HW security boundary to keep one uverbs
context from touching another's resources (it may be that job is how
UEC spells PD), and so on.

Use driver specific calls when appropriate.

kernel-uet will be a different conversation, and I suspect kernel uet
will be very feature limited to focus just on something like storage.

> I think the netlink API and job handling overall is the area where the
> most discussion is probably required. UE is somewhat novel in

Yes, that is new, but also an idea that is being copied.

> elevating the concept of a "job" to a standard object with specific
> properties that determine the values in packet headers. But I'm open
> to making "job" a top-level RDMA object...

I think this is right

> I guess the idea would be
> to define an interface for creating a new type of "job FD" with a
> standard ABI for setting properties?

I suspect so? /dev/infiniband/job perhaps where opening the FD creates
a job container then some ioctls to realize it into a per-protocol job
description with per-protocol additional properties?

Present a job FD to a uverbs FD to join the job's security context

Another variation might be an entire jobfs but I would probably start
with job FD first and only do a jobfs later if people demand it..

I think CAP_SYS_NET_ADMIN is a bad security model for jobs.

Regards,
Jason

