Return-Path: <linux-rdma+bounces-20023-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAi+DsoS+mkWJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20023-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:54:50 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A92634D0AE2
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 17:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF721308D999
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0948AE0B;
	Tue,  5 May 2026 15:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MRzPlZsu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010048.outbound.protection.outlook.com [52.101.56.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAE17A31E;
	Tue,  5 May 2026 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996365; cv=fail; b=XABVAV3Posl/w1A1rLrNDmwrqU7BvtkUEjF/dFFccpB5ivg+nP+aOrHRlAUapX2sqrYXUh2JHXro/4xbAmxldcX9WYm15dUQEwJxYHtvkz3spTi+xf1YnjTwKzY0pRPxGnhe5bRTBu0g7zRWUNwrA5+IfOfen4E+pV8SexiQBW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996365; c=relaxed/simple;
	bh=PBuOguxfHtSXjrBEo/tNr33nn6XKzVw/D04e114kdNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jOt2HnDYZXODF3eOyOpH8yNPHrjShOW2URFhsx76S/cjPRJY0eoUstEDCqBnOZAt4cdtn0tW40XlPlafmU6YvaCWLmsVU0nnJ9BFZkZ0cVL4t3afy81B4LyT1QKBCsJlT5amL+KIE0DtZaS1ueC8Hbk1/kvYlln/5egswyy+LkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MRzPlZsu; arc=fail smtp.client-ip=52.101.56.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ/ZUX46Zh5ES1uFgucAO8xJvzrxL5o/DpPvOIHATKxu4JR/Wp3jz1OfA8RlZcgJ9nXaYpUNAcbo4eT4JMQNFrsvL2PMBG32XtCZ/BoZ4xcrRJ/uh1YImMi825BpJrTCCgYSSEDoV1VYf61votKoAJ2v3i6/n6F4LJUeuDLSF7Mw6nN9qdXK8hQHpUJGohwQMoBpP24j21M/zidAM9uD+5FoJjhCIOye2foVCVZy2gnm0/PJGG6dGqFvY+QUwXmW3zkC+xkdCVaIdZWfk0CfIC4vw9Y2i8TbgvICvpZyvvo/grLjhbz4B/Qa4CxsywMNXopXtldq4na2qOo22Q6RtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cO3B6yCIsoHX8fOzcSTi2ntpUrUp101J4a3ZTLtGloY=;
 b=eTHPkB7j5SbbI2WZK00JPy+zBG46s44JKtULiLEKcnyOrJXvRU1l+uFq7D6+dUm43XaMNoUFS13+q5SUTcbxZR3xHxUji3CGm7Sf9/m9wtzxCiS11MD0Ronc0kTVmUBCNmhKbNxTBkM/xQPYakAsflzJPu8KY7ASYKsdlieGPc6uSRQ36WrdZzpNNrrPZOElkU4jOp/uGi8yVnnjd08b98Y8jAIFx5R1s/auT1X8z1PAEZ2VMA1lP7XKJ3/h+M1Ehd8chBUT8H0O82Knbx+HCWzd4MJ+yfDszuVxKIVfYwu/zh0MGnk8eHrWKjT9pwbUYTpT9c144jty1yEWmVUT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cO3B6yCIsoHX8fOzcSTi2ntpUrUp101J4a3ZTLtGloY=;
 b=MRzPlZsuQiiTrRg+JnP91+cpvgZqf8AO03s5Epnll95jGfzZuzB6Y687ypfRWpEo/a+GmmSac7NMJrizu6w9Qs44bdksoK1zaVaFigUQ1RiZKxsbVGdYjmLNo8inmfIEm8NdLdUBsfTpuXDXkFwngTIgZz7jUjwSs5pv4KJMb6B2jwVgqonlNoVaophupys8CqhCf9/SW/Q0Q2FSQ2R7fAAhcCATQ2XsdKKap56ACiD76tX07uaEjIMMjTPPyUOUpcgMO7hDeVcJEpLp8DIB+nePZzyiTnAj/28mX3c7haxCOWkvCV+y1kJCmwRjjg7sCZPHouOWVeUADZEsomlFbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7567.namprd12.prod.outlook.com (2603:10b6:208:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 15:52:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 15:52:36 +0000
Date: Tue, 5 May 2026 12:52:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 07/11] vfio: selftests: Allow drivers to specify required
 region size
Message-ID: <afoSQWreOWDIfVxZ@nvidia.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkH3pMJKkIbElhI@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkH3pMJKkIbElhI@google.com>
X-ClientProxiedBy: VIZP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::13) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c792e80-f08a-4141-5811-08deaabe5407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xDLDYY2js9t5lERzJU+jUXhMZDQ71i9u0g1JFwIZbjcFTEdodXsL7IkM7Q/Q+NdXqOx9zWs1pg8w4rKInANNdvXvYxl8SzcGOYf49fYPwE3HI+FF7GNBVhaIaQktMynypIy0tPDPc/wETviRcNlrK5GunKEd972Y5OQx7vKFFdKoASnOK7ecMVVMhuAPSUMhsk0xhoMvtDBYnJ0rFWayb888/9MXoo7qsCNMmXxJo0fnYq0Cg3GnbxVY79k/OdBPSlWmDtPtq7JeIZ0h+nLUfJ7xevAgOGPhgjEqrulqMhX2SZ7ZPozMx+KlG4iQ2lnc/N1QDI/czVWuySLJ+XdJaRz5FOZf1pIYPUcdg2uap5EM94jPfe30mmw3lYSEwRj9hs1BHbkquLQTy3AGW7NRVXqi8ReFtguv/S/o8v4aXSytwoh6XlEyv4/aAiQZVsf/5JCLJ2Spv6cBRU4oolH54OZaqOJqF8pWgYng46/FnasHDfGkdMd6QunnWoSWpEUbu0jiwnkPDoi1A7VN2EmLTjlvDO4CqfoLi3vgUMvzfjlXKaHAQ4aA5sGuVg9wahF46v9zzOzMb+PW51AvSdec+NIHBmzCT5EfAoNKtcqlJQyv8xHeXBq5lhenoWve9Gi2HRnTbg/bKPEzPf/D9w8ak4IzM9hBlirXVmmHb2AW9xM6+hAsLWC/5vcJTwdcCrT4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fYk/qDISDvwJ/RuP1rTIoPZjGx+tid7XZmWUrJX1BVxCXNeaMn81yOk71GKA?=
 =?us-ascii?Q?6uSCctO9YjnXISnKC1VVMrVoWR0pZ/pVrTs91waQ3Bj0AAPg+4IDiV9zOqb6?=
 =?us-ascii?Q?K6VMhVNm6QUD55IIZ31d+Uq9qI8QdRMdWH2ci2b+oNPLv/J07kOF3fIXg1Mx?=
 =?us-ascii?Q?n3SQ8fyTh09ydKsNV9L3E7DwIIYG6DkPinETl1/ds2DVCKvpLT7QckW0Ybnb?=
 =?us-ascii?Q?6D5CcPXXlvl6Yt82LQZgLPISZiH6Qh5e7mXVcE1vyBiYGGFU/wqdmjoomA3w?=
 =?us-ascii?Q?Y/rkZ5XRaeUXEM6Ukm8WyOp3brdNP31sZQ8jPTExFKZCWy83bU1HESaw59cp?=
 =?us-ascii?Q?UqxoW8/968nodYfhujOAU1kNkJl40TYkAI6Q6m4Gk8HLyGyyyOUEVbtwmfXJ?=
 =?us-ascii?Q?TCG2QuAHll/y3qQo214BAdpBjK7F529AgunLqNiiXjtitzO+IMohTHxx8/Jx?=
 =?us-ascii?Q?aw7KkX26Az91pVFU7TIbe2A1SlDrCjt2ayrkZDhAuUH4Lo+gLWFVRuNzD/Dn?=
 =?us-ascii?Q?SSsuyxqbKzNT5BNOC6jQ3JtafHwqmp0ZgWarXeGxpLRWKmy10yX86R6l8ROY?=
 =?us-ascii?Q?1cpGQbT0dSeIJ0NKeCA7SsHJDj1Rip/U4/J8sfHWUdhLVBroNzEDUS8MqeP8?=
 =?us-ascii?Q?oyonOtLC6lhNP4uwJENF+joXvcnZ80kKgweCCXI8WFE1n/P6No4zJUyxY3bZ?=
 =?us-ascii?Q?BKEFY/fR8IMv5r+d21nFfDExOH9QDDazZz3Q9cM+YdJs2dP84Ig0bcooSP2u?=
 =?us-ascii?Q?1OAAAWZ9bezWdcstjd/ffmZMad/vcy/5dNL2rtT4f+xRU7OmE6vAzNvhxw3j?=
 =?us-ascii?Q?GqL4He/1wSJxt9v9+z9sF0FggZfAv/dYEx43euvoaa2rZGl+NuPvxZPH/SeQ?=
 =?us-ascii?Q?qmP7016vEVOt6ZHjk9sbAW7qyrh3F+RQWA4Act7nqXMILLqScUtlfkWI/Mlr?=
 =?us-ascii?Q?/BpcjvtWt/Do0EXTlb2NCBNz9mVkG5nLxXyt4v/CLKevjAkR5nv6Q7yny0b1?=
 =?us-ascii?Q?uxmHGDzcx0RkUJ98F7fmIdQaotcodIjlQWgCijW/aD0v2INdJWZyPmDA/hBz?=
 =?us-ascii?Q?v1TlKXkbV8sBKY4rNtd2ykC7bClKFnuCNTYtq1VJAVbPfX0V4fCuU8L+YELC?=
 =?us-ascii?Q?Q3A/cEa0ztqByT4kY5OSlJx9pAkXt/NlsNlyBfBtK4CduZvzAoHI7DDSQTEQ?=
 =?us-ascii?Q?q+k1TwGPN/EmEYPm0oiGVa9e5FFK87108rUkdUDYd6XYVTEH/SDuqFIesueT?=
 =?us-ascii?Q?qHoyteyknNfbZw+PMSBIIUMcZ4xiKVELchNpoM9SAlugaVquQXPZE/O6W25j?=
 =?us-ascii?Q?T2rbbID7zMg/jtIiTW587qQY5ROG+Si9mWl5QSDsMNjCsoswQ9PzK70Fzxe2?=
 =?us-ascii?Q?6Rq3Dt/p3lrvF3+zGw+YU8ADTgcLPuxHtaiAZ2X1EAQCYJIcWEXaX7gkKqoJ?=
 =?us-ascii?Q?uEjmFS8VXyW93c73xsoF6jnzXu1uvSnWe5+hg2j2gE5tlgKWrsqMNaZDZo8R?=
 =?us-ascii?Q?bNqbI7OjWkeRTmeuMl8KfnLA819SkAWV/IpO4HupE/jJqxhaDuBPzzhz6aCr?=
 =?us-ascii?Q?Zb5VemyWcqvDTre2fVa05KZZelIpQcuYpn7mhjEJqetlyv/L156aGh6cR7Yp?=
 =?us-ascii?Q?M/3+HRBT5SnZYie+KluL7vXvcTmCOCS4fW+jy3ESvbZFIOyA3AyNO1YZrR6d?=
 =?us-ascii?Q?QptOzslt0Ofr2OJtq03sJnN2tFxTv+fWB5yn3aLeZ+3QYfbV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c792e80-f08a-4141-5811-08deaabe5407
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 15:52:36.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97u3rvblagu7znx+KnpXfikST/ORyehHy9GbHKdYg5bX/Gqo1EwyO8KjQmKP1FaL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7567
X-Rspamd-Queue-Id: A92634D0AE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20023-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]

On Mon, May 04, 2026 at 08:55:58PM +0000, David Matlack wrote:
> On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> > Add a region_size field to struct vfio_pci_driver_ops so drivers can
> > declare how much DMA-mapped region they need. The mlx5 driver will
> > need ~18MB for firmware pages. Existing drivers leave region_size as
> > 0 and get the current default of SZ_2M.
> 
> I would like to get rid of the magic SZ_2M to make it easier for other
> tests to use the driver framework. Can you make this commit update all
> the drivers to set region_size? They can all use the same approach:
> 
>   struct vfio_pci_driver_ops foo_driver = {
>           ...
>           .region_size = roundup_pow_of_two(sizeof(struct foo)),
>           ...
>   };

Sure, lets put the roundup in the core code?

Jason

