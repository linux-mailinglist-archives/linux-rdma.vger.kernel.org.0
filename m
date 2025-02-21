Return-Path: <linux-rdma+bounces-7977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E30DA3FCE2
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 18:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53190708017
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Feb 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B923A564;
	Fri, 21 Feb 2025 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DL2boA0A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8C23A58E
	for <linux-rdma@vger.kernel.org>; Fri, 21 Feb 2025 17:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157257; cv=fail; b=aOoD/gL7zmPLHDLk3YMBSTUWaroQbebym3pjXDedhamUYt6137Sfnh0HagJ4u2InQNbh0GluILRQCOtit2VGH+0ELN+yG+rqzv7/9ZXZo5Skof5mPcMCS1OEsNcLo6wmwrMqKcGebDgkD2vP9xSJM4YSQILXnfYt6vrW9LYhCWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157257; c=relaxed/simple;
	bh=jWkJAyDx2uF733ltvFPw+4GV08uKLmSaTxGhK50TWFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ryjjcGwzyvCynjXYjkdljN1in9Qq772ANVSYmgSmpPCter0hMlFy1kWVmERqfhhjsYGBtXUpX2YucwJOppcngrzGGcz8aIXIDzTzqVwQsbJv6LAzbaKKlhnV3esKJZhJgRNCKkHGHglemUTwACwykEBSLOKWyKuTwwN8Lx+W8zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DL2boA0A; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SzDopyPmiRd/xms/VkW8HP0pa8KCI3uUmrs0tavcah5TATsPOQ0hd7hZ4PYjMdduU0Orr/QOake8syyhDeslfIlLun1zu/PfmcH9/qfKIfk2FPJyZcqqRt73WRbNurbbWctdRk5mYoxJSR3f65X3mr580+oS9Ze3hlIUmUWC3ZPOqBoxfFSHrYmNW4LHGjp8Vvz9dAdb/h2VKeBlohjaHYXHSg69JvFc3dNF6ScjIRslfBlFil3MF5C5MmkWkOQIKlJko+fyWqV1BntciM/GLD7xnfODnO2y8dOn6Exa7NctRHG9Rt2Ox9I/77XPA8iI2HjIPnP9fQosGAOiQhrsMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SSfqJK6aDiuij4VuCfZuqXYrwtGEIF4I6bBhxnLijE=;
 b=ngzZcSeXbg80j1avTdHpo+BGzi+hw1Cgr/fJjiUPyJGRQ2qB+J/BORBkiCE4ETPrT2DRnkhSVZijOgNeJ/DUUFCmwXOnrgTwRs9q61eyEay550XopQhIzf0dAurNGAErrPbAwiEu5OooUrb0rDYWpMFO4vbYGVxdy+Rpntg9RG0isbXZwUUnOja8fsOnJpWQsn3XV3oYPpPU78UjlSLm6FRXa6N2UZQaPDd7rfigHNEAwXI0h3jDNAYJr9niPAqr8uomudJukIWaGXYYDbAcu/F0IGFPEyf6YkDMr4dkQHvkjf2/4Z0C8aQ/1U192M6CGfo89QP7WEI8JHfaoYKPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SSfqJK6aDiuij4VuCfZuqXYrwtGEIF4I6bBhxnLijE=;
 b=DL2boA0AjA9RbH2b31zsKZWCsD4dwgGDaZC7IiXbUJ+/FVvkWQKsAkHdziiKVvqJ957Mem1SfBhwc+XqwneBBrpTVcW5rxkM65jugMFshReZC6+qn9UvuY9nfNOpNw//3j89QHk6cv6TTYtZsfhd9UVb+ZTSswGvsE5ZUGMfD8XYmBvaB/qsEr8b8nBQvL7yc21ueRe5AAtSo2JlMIlcpnKgEyfzeXryAMyV/QkhxVxVETpqhO6AQaX7tEqKVxyaQuoDK/GrHi5k3ZwEZPFVH5Bm/iJ2dCw3CBnGP0KBRaPC70Tk9PQB0Pf4AzKf6Yle5J0fPknPGTU7KAszZsne6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 17:00:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 17:00:52 +0000
Date: Fri, 21 Feb 2025 13:00:51 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jacob Moroni <jmoroni@google.com>
Cc: leon@kernel.org, markzhang@nvidia.com, linux-rdma@vger.kernel.org,
	edumazet@google.com
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
Message-ID: <20250221170051.GA311389@nvidia.com>
References: <20250220175612.2763122-1-jmoroni@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220175612.2763122-1-jmoroni@google.com>
X-ClientProxiedBy: MN2PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:208:238::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4079:EE_
X-MS-Office365-Filtering-Correlation-Id: 6caaf2f4-03a4-42d8-ceca-08dd52994c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sRpzgF1ACruwPhlU/SxoAskRNKV6yDSREZ9FfMn7PN5ZOG9iXEgo2vmZs84C?=
 =?us-ascii?Q?yUC0w3YYe4WdpojxUFWhL+JXihkN5u59iCu1r8+vcU1y+6t8FLf4inHPh8QM?=
 =?us-ascii?Q?E7aVkvOUx7DSD7lA3vBa4pYaVXqNa70Iyo6mLdZanPtt0M1VjwENYztr8Ke8?=
 =?us-ascii?Q?GODYmZgaYR93AMpVusp5exh//si4vJ3YPcWQ6Its1QUYfSW+XvhT8vUfdbCs?=
 =?us-ascii?Q?Z2p3EirQ1wFjbxNv6prPxOFZo6rGI7hGh6mHoXsGIEmD3BmIwPII0ROraMSd?=
 =?us-ascii?Q?jh9anxRrU9KDf3PbobXq8Di5q0X5NSR7Q/w7rv67TuxQsWad8DPZeWBRpM1J?=
 =?us-ascii?Q?7/Owzb/Gs3u83/yE4HN1uCI+ZipbXxEVQbko5F6l/dqDjtL9LcCmUl+gg2bk?=
 =?us-ascii?Q?IyKRvP2eMcYrPH1n02DqFwfGrE19ihVnlHQdUhliZpV8ExKcu0J35dRKXI51?=
 =?us-ascii?Q?QKIeSoYHh1CFy0geqR7nB4sIyq9e3oPP3HjorSt2zrxBzPVxGaOkPXd/LUEO?=
 =?us-ascii?Q?VpCQuADOpXHKUJ0hBp8wejjfIak2qVsdqsj00RXVklHMLNza+2pC5d9pXcUp?=
 =?us-ascii?Q?YuWNVpKsZVbWHAdQ7aPFdzh/oSFM+ULDiCtlrZXAYiAhTjBYv3ocfaCK6ZWe?=
 =?us-ascii?Q?gmcmx4K3LC5Q2oO+zAN87+hfAjcFS84IRLEkDf8qDagl+Djn81+/qYG1ZoJL?=
 =?us-ascii?Q?cQRr5kuK3F0Y4CFYif1dAYVovk+wQrdmkFnlSi3QPYPdYD7JFYXJjc7TChAD?=
 =?us-ascii?Q?jTxlDBsPEKnQ9SvZ15YlOIhOOPanfuwkZ2hCLnQTPW/kc+b456CdpQne0qnE?=
 =?us-ascii?Q?V/ARprp8KL3Y5lGyorR+R6o+xJY7mobYy6nbcSLYbZDpwaHtl1UwNz0yXP8e?=
 =?us-ascii?Q?sF55MZpXF0qqJXofkd7t6pGHYaXqhlz1K8+mJLiCZOzHtnYYharpnpSxP/oW?=
 =?us-ascii?Q?uQD74b5v1a3l3tCG6kB3SBdQH265H7BEYWjn9+BjyJUDoP8GT6B0LuN6Dq4F?=
 =?us-ascii?Q?6eCZeHo3e/91UMHKe9rU86ih6orBLobaxmSgXjeuabIhgXW6nUerP3N8v102?=
 =?us-ascii?Q?NPt8ioWYV6Ct05VqD2xkXAmRHxKqdO8uq6r42vszqReYZ339d80h9TsvEpx4?=
 =?us-ascii?Q?Qznt+M56DmA9jpd6oHdJvxXAbqp4H1d1lvszXs0qdspdDnwMPR080kqxnkCy?=
 =?us-ascii?Q?zJDbRbeDD2UXtiLgy5T2SjO9eLBcowvBEzIddoFY6+AHOSLQdkjSADTTiXL8?=
 =?us-ascii?Q?28LRH7UiG+x4hpsnMaJJJ/Iy8dthhZTiZ4+dMP11yLJjfeH0XM5GV4MM7GLI?=
 =?us-ascii?Q?XdU8oo7LIMyJfouFrZJokCpNmCE5SQSVLVgGzPD3CwNGh4oUwPIx4yYPrltM?=
 =?us-ascii?Q?nvBPM8wkqUkKnJIRjvpmJawGbzds?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?stAlM59fsY9Vegx4IkKzRDyI7sp4jLkZJRWvPlr/xhrnD+Cecv/UQeQ5+Y16?=
 =?us-ascii?Q?Siwgi+kMk3UOYie2WRLt2qeSFFSPN3xnPJICbmVynJcmUw5GoKyUOqGwU5FQ?=
 =?us-ascii?Q?kU7MFLmdlfsgrqKBgotEQH0n3sZvpg4zgMEqgjreh7UxglLXER/RQljtvxD5?=
 =?us-ascii?Q?uaVkEtezK1pVSNdqFhF8n4bpGMRgJ9772yiaqTXC/LLEipeqju6kbaHPoNYY?=
 =?us-ascii?Q?COfxy9PP1rbRaTp/C8OYjggH3MS3TnZFvyQKuUahSueq+FJWxCgP29rj49os?=
 =?us-ascii?Q?kaAfnfcc4RqQHEf1uIGpAkc2/ErDcR3JFvhi9Dz2r0IBzzUUK6506BGx1tZr?=
 =?us-ascii?Q?oPZrdrQT1TMh9qCsu4XtLHVxvc0StIQifSvOwwqK3nH6zDyiapsFXRPGQ+HB?=
 =?us-ascii?Q?jnCSa9BGXBdimaHdr2RawILLMYHHCemKslBZyMTyaTM5TIyl6jlAis2NOyjD?=
 =?us-ascii?Q?/syK7MII/ZQGmNHPB6+KQqjXTi3hPbGK+JkOze82Aw6QWbsMDTFYHTdglANO?=
 =?us-ascii?Q?SuRpk+9CAyhseParNZWkFv39ENn3bdGsd9attpDuskxTvtvw/QBzhNMy4+Lj?=
 =?us-ascii?Q?0JuadCFUgp8eJ8+jPePf/Y2m4YLT0TGS0fk77MwB7d/XhmKCDkM5/Jzn/tnZ?=
 =?us-ascii?Q?YRAeR//wM+ez6v6AXEyofjYKdqAX5M9TbCY2tRzsi+rHwPAvVJJLru9dBzYl?=
 =?us-ascii?Q?aqW3GAXSooMw7znvQPlA1qBiqP8mgbQZ2Fdm9UIxigS19bSNwlHCupL6GSTT?=
 =?us-ascii?Q?UfD+8vUXNb0CRgrP8lJk7JQu6CDLBpru/4Cq65VH6pI7+n5VB+6k7vuSPgf8?=
 =?us-ascii?Q?dPGwT9mhOFRrzZDEmUuoQC7VDLqFaKaHoc5pU/YXylKMOY32g4Vqw9UuL2+x?=
 =?us-ascii?Q?jR+Ehgwn5q2T8Ojw20XwpiyRTHYVcWGIchYYvzC4HRyIS7yrBGko/UKKunp7?=
 =?us-ascii?Q?765RfeugAegyRcwTaNaH0k1xelQFEMXuze9xAx8pW+0NFxmAmBUXzc4u0vWG?=
 =?us-ascii?Q?AMX8wwRV3sR287Y62Hv1np5OB+OZxLN7P4Oi+/tWrT3W43wR3/LrOb9qFhEN?=
 =?us-ascii?Q?ss05+QDHbXMGkvlJ/kD6upZWb0/rdR+09mDSjZJ4SlCBsczRPbp8pqSWgeP5?=
 =?us-ascii?Q?3y7R1i6y2pDM532cRl6MKnJ8YfhjP7/ztqdpg3LBo6pHYogDkP7W1ARvW2+E?=
 =?us-ascii?Q?uf+C84SwdadZjYz/LqkdDA5fJPd2tDtO4ugkDIy6gVw1xCBZecM+Lp5gkV5r?=
 =?us-ascii?Q?TbDBmFxs6GzqALvtdb/DX50gzV34KsJbwcSGyoRT5XfnesctKfFDHDHb8NhG?=
 =?us-ascii?Q?kfOycAiWivEJVPKu4Qcwopn7z3f001b7Tzrmv5RVgiCXmgoB4gX9JYiNPZXB?=
 =?us-ascii?Q?NPKJYJcl7wvNC/XcTrkz24uMmXw3LoNtO/fKy97eMsq9SucfvAeUwvZ9XkIj?=
 =?us-ascii?Q?1063UEWf9LW86vo+vX1Q5rCcLGurrCqpuMQ38iKdFhYZl2dTndMVOmLbHbxm?=
 =?us-ascii?Q?805XEpo42LavLhsNJPphfIVr9FGw2wLy/zSrP/Rxnm0GPm9yna9zni33ks2q?=
 =?us-ascii?Q?4mNJ+rKZtIRhDmmR49E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caaf2f4-03a4-42d8-ceca-08dd52994c9b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:00:52.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEgIEhL8dHVRKL3EoR0MINRATT4kAyIzEsjaLXlVt4pa8CISnB2PZL2fIOrs0s+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079

On Thu, Feb 20, 2025 at 05:56:12PM +0000, Jacob Moroni wrote:
> In workloads where there are many processes establishing
> connections using RDMA CM in parallel (large scale MPI),
> there can be heavy contention for mad_agent_lock in
> cm_alloc_msg.
> 
> This contention can occur while inside of a spin_lock_irq
> region, leading to interrupts being disabled for extended
> durations on many cores. Furthermore, it leads to the
> serialization of rdma_create_ah calls, which has negative
> performance impacts for NICs which are capable of processing
> multiple address handle creations in parallel.
> 
> The end result is the machine becoming unresponsive, hung
> task warnings, netdev TX timeouts, etc.

While the patch and fix seems reasonable, I'm somewhat surprised to
see it.

If you are running at such a high workload then I'm shocked you don't
hit all the other nasty problems with RDMA CM scalability?

Is the issue that the AH creation is very slow for some reason? It has
been a longstanding peeve of mine that this is done under a spinlock
context, I've long felt that should be reworked and some of those
spinlocks converted to mutex's.

Jason

