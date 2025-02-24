Return-Path: <linux-rdma+bounces-8050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F0DA430E5
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2025 00:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73A3178C67
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D71C860F;
	Mon, 24 Feb 2025 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fzFlhx6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E19D2AF11;
	Mon, 24 Feb 2025 23:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439878; cv=fail; b=J37n00yI+4jU8m+bh8tRMI22FNqpEn2tukXQ+8tnQ0+eLLZRaZQTAyet/3kTRRAkqbn/CxayVZEtQtO6yMLQ8Mp47yMuRQzYlBNmzrFqfgbroTl2ACtS06ycgkw8dZsItC2DGYWuK19p5RZ1uZIDq9GJIHh6UZAuSVF1T3Ep24s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439878; c=relaxed/simple;
	bh=VWXFk4bf6AV1CiAu7RZ4tC67o6oaRnuAii72QjlZjyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sO9FzlPdMWDV4VJSk8HQA7fW7gtYmsYf9/04bfWG/BgJHr6i5TrImW7xtTJemPwg9194KjM8Eh1mX+444AeNre62AjeJ9HeXG1WwPlz4TFGhLRYrzFIlv/wr2hlllKvNF8PQsd7zhUn55oEwnkmg9W8413+fqLn+5bZfIDhP1g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fzFlhx6g; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENec14gcEiHV4SLZZ9JckEUumRVPqevvUDDibsHRr2pkv5k6CJfJZCG4TSXPdlfNpNrDrsb8UmE/bzu8gnjGBAxZ6AcJPFZ3YA3Lt+XcIShr2YbdxTRnTLsmBcx9vyRyiacRFJ4xGBwxtDEKzumvEebFgb6B9H8rzff2ThWMTbAmTBFRkq2eHZM6AMEGu6eLhedb2rZofGYBK47lK7BdnCndfsLW1MEqyZpoEPNcGaW05Vf/Ntq2ptKecUe4Fq9wU9+5tZlFghIbhDw2gXnbI7R5wvME9xvkPv2feM6v9APufkgKwsOH5ZzjGRCXzwybe9VoHiEpgfbza46Gy8v8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hioX4JRtubnKbxCRtdChvVOqcbScvw+K8R72lRAJkRM=;
 b=YyY2VAAjH5SBqX5m+Pi7Y4fKyxIbHC53iFWKPtdTGSjcFv/fMfHwhgG5lthewlGqIZADvmToUUpH9UiHMlA9d2UL9FIaLVZjMWbvAFxC7E2i8yokdNxoFYE81Q0l7A/URzwSbIEL8me2oNjmBMadTJawxuwSU1Wf1dMLi2st8OrKJ+bB1Bfe7Nf+K8gw8rmHLf+rZ3tJm0/mApKfaMpaovAxdX6UTHOwUYvNhmGcJUMxn/7M16Ig491RKIkrq/WCp03BbUumW92NQ1BqxNaa+RL/tx/ExoKKeLUJvBMKxi3Xn7fkg5hNmKqQnRpoSbN/hsTOezsQvtwoPQnjMCvnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hioX4JRtubnKbxCRtdChvVOqcbScvw+K8R72lRAJkRM=;
 b=fzFlhx6gHqkAFmzpOfGu9EuvJvmV9FSGNxW/yOlZOhqYSniwPkEXs1df6SJama0dKhKvb6OMyIXrGqvlT4yoIQvxUgwr2yt0efOT7V/pGDDk7abD22rZcOyNMxapAniQiEge7lcm7E+I2bVfpcba9/fzK1axZg/gzzLOGQSo44ayquqG3JiRg6f+s6RSYKODB3shI1fjEV0OHv09WlqSWPTlR35pu3vJMAK1sIdJmLxB/mMZY/j7QgKd7e800XXqQees942sSm3tMqpvtQCIlZpvIqBuMl99XfjboXXDn7De7BAHNRRIzv+yvFZXb/Auy4mybWBwCbob7DJlSw1QmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 23:31:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 23:31:10 +0000
Date: Mon, 24 Feb 2025 19:31:09 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Parav Pandit <parav@mellanox.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Maher Sanalla <msanalla@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/core: fix a NULL-pointer dereference in
 hw_stat_device_show()
Message-ID: <20250224233109.GE520155@nvidia.com>
References: <20250221020555.4090014-1-roman.gushchin@linux.dev>
 <CY8PR12MB71958C150D7604EAD4463F4ADCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <Z7gARTF0mpbOj7gN@google.com>
 <CY8PR12MB7195F3ACB8CFA05C4B8D26D3DCC72@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250221174347.GA314593@nvidia.com>
 <CY8PR12MB7195A82F6CE17D9BDC674D72DCC62@CY8PR12MB7195.namprd12.prod.outlook.com>
 <20250224151127.GT50639@nvidia.com>
 <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB7195E91917FD5329932FA3FCDCC02@CY8PR12MB7195.namprd12.prod.outlook.com>
X-ClientProxiedBy: YQBPR0101CA0185.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::28) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c61cc0-aa9a-46e3-677f-08dd552b520c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bThxtYLE0XvDFj6C1FYF2m6GQfOPWXgdcoT03CWdHpvLlCpgBTK5U+q0W+o0?=
 =?us-ascii?Q?oU3IFYt5yBGNs6ptZK1jibcjxz4J0Otks4M/KoHpnHLWRAyK30WAn5AVA/b1?=
 =?us-ascii?Q?0R4QK9zFFHxt+gDNrSQYaFo8fvKmt4J8kjjYasUb6q9cOMlDop6usvMyD6dB?=
 =?us-ascii?Q?WCCudazh7Hd0A93CMwIZlbUCFyfYbHE5wYhEa8fwOTthkQ+V1KPVZZAl8fkh?=
 =?us-ascii?Q?gL9UdK+u/Hk7Lgl7WWPSKyswv91liB94YqmI6lg+occfEHYN2C8sIpeEGike?=
 =?us-ascii?Q?uybx912KHktTQvKtigs4Dehc5pdNdEte7cBighxFbvbl8K7HP3PseVeiXI7f?=
 =?us-ascii?Q?6HMCz3AT5gx9tXtAndEVesS1oamkbLwqADtWW1xTn424KMzEIIYQWXy9sYYK?=
 =?us-ascii?Q?v/Li+8UyByx1IGAoUIK7nrumJ1a2irlpsNe4cbcbXe+04IqOkmeKfDdc4WUU?=
 =?us-ascii?Q?JRtkImrS81+dufdBULWSQijlhPmF+XVFq0ac6G07sw84w+NXOaSI4/5tI4vF?=
 =?us-ascii?Q?BW7E1jcSctPRD/uWwpoc/huQs+2XS0OpyguSJck/TFvLXtg+nHajiPaFMbxK?=
 =?us-ascii?Q?rjQ1cpVDBq71Qj6eMcUE81GXDsOtCLCl7B7bZuiabA0wXYaXBck1dG1n2sYM?=
 =?us-ascii?Q?38zoEFBmJz3m3ubtRJnHG80LV3XkUmBW2wy6FCpN8Si2BBkL35jqzFZT4Cd8?=
 =?us-ascii?Q?kPmbPdjYVav5FEE4j5tTtGoeYN5Jyi3q+BbSzhA7C7miSZd/VPWGFCzboiAP?=
 =?us-ascii?Q?poLDreTfdTHaYftgCT33qBquxtuWy/5W2InN8BfTpnPH3lMOl5kpDTw6Gqjc?=
 =?us-ascii?Q?bmb1dEPCXj2CIyJLcecRJEYynNT/IhY9vXWLIcls7HcdANXCitoaWk4EYY3J?=
 =?us-ascii?Q?xpAmeDC0V9U4iKiLd6TVeDf2zloH5nNQFHXegXWQqd9/ytqN/rLB+iPHfKFw?=
 =?us-ascii?Q?xhyF49pnpJy3L5kSDA69+2ZbiTYyjs1DVmGwvhBMIaEhXflZrij8aL63dxBy?=
 =?us-ascii?Q?KqwxV0DAVoCaw5kaMHmTrZAlabriBn7T1fKPyNrv86qbtmJTxLrAbHJkk21V?=
 =?us-ascii?Q?Cl017MwCJeeaD80mbNX3Xz1m44LnaLa1CCs4Xrq9xo6FpOye0GyzbdjCdn2A?=
 =?us-ascii?Q?mD0TAHpO0sofxYii26g7lr0SZsoh97gYATchtFx7IxrND/UMQ0Kc3sbmDwyt?=
 =?us-ascii?Q?auwAcwLCByAGjybCQ0z/LN/fb4zpFV+JCD2sJQkOH6iThZNbJIhGwFoyOGEf?=
 =?us-ascii?Q?hiuWmtamGKOaQrJgsOvBZ181pY7fgpgMT/P+JN1ENC0Z+VNpDzI87iWf8CEk?=
 =?us-ascii?Q?K+xnhaSVpSHDacP1HUhxS73Xe8p60NdgPa+EDch+iJK5yWEkBk8mIXGaGZSV?=
 =?us-ascii?Q?7FVWaEMAbZEbhtmsQCQcwh+Crrsj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dDPxWzXLulBLwHdu5kL41rWa0oUHw51BDkORExAyGJB4iOdvpaFxvTsxZ71N?=
 =?us-ascii?Q?7UDq8RUen9w0z3lVUcRARq7bhNPo1QZytW3sOwvfcw/fBEy8/MK0w80uDCJb?=
 =?us-ascii?Q?XU+4SR2AaK6mm4pWVZtgv8qRCOxkHQFynhnDaxDkKfBF6XKWaDhv3MHCAQMu?=
 =?us-ascii?Q?h8bX4cOAOzwdt0PO56q5lZb4e9LFfi79AoHoRR7aIxvwmFnsPiT/V0UQtdTI?=
 =?us-ascii?Q?0WkVeprWNrZ8JpfOqrrg7RNixlpvgwDVgFkSsDbWEdFJ7352Jsh4wuhcr5N2?=
 =?us-ascii?Q?+MLkZaerNczkEKQXxVpj2p0NyeKZjDmPt3HWxzUGlTPksMo8QGbd0xgBvcp4?=
 =?us-ascii?Q?va2jCqbDxolngNq4EZQBHNVVXnyBZZQc1Z1G5qUl3o8WNRrEeT7sRqRabPzp?=
 =?us-ascii?Q?nH4KswEBoMmKZnK8bfmA06vP3+peleSSpf14M284OyxEsKqLAwMnXhndH4iP?=
 =?us-ascii?Q?14khdgIOxlhCi4UpIJqCeDSdaMgIhB20296cRJwpxV1I+9J2tvHC2xhNdZdg?=
 =?us-ascii?Q?mYxhMypArAagnro1OA1vZM+EZcn10HfKdLLZdiiddxGterfJkaHSVNjWDUWR?=
 =?us-ascii?Q?Ffp0F44pier0RJgl3yY7RBBf9Ox2tCc3fw6BJ3kM6JMNLWW4wvN8oZnTFUQw?=
 =?us-ascii?Q?Eg+LT/XcvwM7EuDBTNaW5flJsEbqRAzjK/R2x2RHdgQzbQQyir70VtwRA0Ry?=
 =?us-ascii?Q?8yyy307IBJNQ6LjO71a/oi74NNhmN/F3sGOvqNF/6CGRuSkgHzsoabH9PhFc?=
 =?us-ascii?Q?bErS6xWHPQGfoPNFoKzK3TBwuLqXgkWT1o3Flm4CUyXv6FOlZuHEZmhgTJoX?=
 =?us-ascii?Q?KoD6Q4ofoFUckij5iK4ifTVSzMDSSPI8SCYC5T1GOPxHitpbcchMu1WCh/Xa?=
 =?us-ascii?Q?nNMJCKYFKVRt6hE87T9Kw4p9EC6dX1xlt5SLeij/ShrApblCh0QdjcIBRQgv?=
 =?us-ascii?Q?dYyUSM9TreFM5s76/G+hxc/fwowrHn13phJjHfVexU2xNU4DYYIMWrWAzXgT?=
 =?us-ascii?Q?pg2L6P07vpTcEqqRtqVDuZdbFTSsS9xDX8XY1D9rJ7sgmUd8myvdEuaENxTA?=
 =?us-ascii?Q?tpazZcb86p50N3Judpyh5XcHVQ6rnQGWujQY0iOkhgrPxt2aT1ZEtu7LSlB4?=
 =?us-ascii?Q?3EBORPM+874Si6wSzyJ84XrdqLcp3Cb5ztfTPgDHGgZavucdtG15XZZJFpFv?=
 =?us-ascii?Q?QIEpdUkCD2CEaQI3eDhAYpACFaqqKIyDSYi6SdeSM8yJrgHKgAuRbVg5VUv8?=
 =?us-ascii?Q?1Zd+qcMKCF81hbpBYXQ8cIJQw7GEZ9REzkWlXR6ImnZZiD1kk64/EmYkyd7/?=
 =?us-ascii?Q?BveFlhg/sNKT7ICOg9WQHzKDw779YpT9NWRU1Y6v+Oh+U55DL9dexLUb8vVF?=
 =?us-ascii?Q?RcsB4m/5RIX0ICrjWRb734MrNGVpT+TA9IRa0bITn/aMiYh7Pi9+nLRc5ahb?=
 =?us-ascii?Q?XJe6nydGdW3sNFJ8lRFeUynqEbDf2Bt9s8DfFKGa2fANeZvLD3K3ECbLueq5?=
 =?us-ascii?Q?4l+Fe5eJAfVrSg6zx7gz1FXew1gVcilExVI5UTxhkfzVvUrCsxO/JLkUVqag?=
 =?us-ascii?Q?Eznu6mHnD0GapjpHV/tky/k8Wtj6woUNkiyEFXBz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c61cc0-aa9a-46e3-677f-08dd552b520c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 23:31:10.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VclcpJXC1y21vQmnUbVocaEpOa3cJn0R2cqDAMnaaRSq3XTZ4yvrZfGy1rm6in0h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011

On Mon, Feb 24, 2025 at 03:16:46PM +0000, Parav Pandit wrote:
> 
> 
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Monday, February 24, 2025 8:41 PM
> > 
> > On Sat, Feb 22, 2025 at 06:34:21PM +0000, Parav Pandit wrote:
> > > ib_setup_device_attrs() should be merged to ib_setup_port_attrs() by
> > > renaming ib_setup_port_attrs() to be generic.  To utilize the group
> > > initialization ib_setup_port_attrs() needs to move up before
> > > device_add().
> > 
> > It needs more than that, somehow you have to maintain two groups list or
> > somehow remove the coredev->dev.groups assignment..
> > 
> I was thinking that if both device and port attr setup is done in
> same function, there is knowledge of is_full_dev that can be used
> for device level hw_stats setup. (similar to how its done at port
> level).

Again the issue is the group list, so long as we are setting up
attributes through the copied group list the whole thing doesn't work.

The group list is used to avoid startup races with udev, so this is a
bit complex

Jason

