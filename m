Return-Path: <linux-rdma+bounces-9373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07811A85B91
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 13:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1471F1677EF
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Apr 2025 11:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F2B29614B;
	Fri, 11 Apr 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JZ9n+MAm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30265238C23;
	Fri, 11 Apr 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744370615; cv=fail; b=Pp4Imc/HcTI2SM80suQMHImv5lFt9vLDtANSpGE4Jb/nZZrovl94z9aZmAmXMlaElJrH/9xqCknkDoe2Ud04sPCCCX/wkvEiOOi8SPzACjWwotdHLo05tvkxfOoc0RJo/4+egZa4YHPOwv7WRrerWZJrDID8FCL/NLeuAXF0ggk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744370615; c=relaxed/simple;
	bh=vA+qlWaFs7b2gW7NF/n6Jwa0FrJ1VTS1J4xRpMqvgrk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nYhib4EtLDB0cYNnFmUZOfz/Ii1ZNUHGscFls/1294PjvLDB5HlIOnZ18gXUwpiW14nF28Vvc36Atnb1o1atnyc+FnSP4e3/F+WAIcH5rSQmqSRTK2n4CaQ9bc1nP0a17qBHPIk071Pvo7ZKHkt24y9O1/14cE5IkX2Z306MEes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JZ9n+MAm; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744370613; x=1775906613;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vA+qlWaFs7b2gW7NF/n6Jwa0FrJ1VTS1J4xRpMqvgrk=;
  b=JZ9n+MAma0Hwxwst8gCSrR85PtbIzir59/29+Qago3iearVyO6NMe5vn
   FVEa9ucVDDHowFNiELr4joO6aERTx9q5TKCAhbOUWDRi1RElxQqnJY0ik
   DNLFXKOBHxL0le1UA6Jgc/B/DjdzQMVp/JQsOrYlqUG5AT/azcNOcd5i0
   D5Bn8WVHy6uFxqmKnWthX5AmGw0xLAz3PR9EEHA4VfH9T2hjUX0DTOwoP
   785uKED2V68zYLQutYFB0+Dp5O7Ui8N8KqmasbhXGxuWjCU2JdibM712b
   T4BvWTDbeBgRkrXt9bMY27qUQ3DedL0a79AsA/1nxR72fJqIhxWTt48LR
   A==;
X-CSE-ConnectionGUID: BzITPhPaRB6EQSvU5UZ/Hw==
X-CSE-MsgGUID: F3kWV/qeQMGGSTNo3B/Csg==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="48628633"
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="48628633"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 04:23:32 -0700
X-CSE-ConnectionGUID: QzEq88GmQaWvkB7UxxCreg==
X-CSE-MsgGUID: mBcAi2WsQ2WfTQoDePhwew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,205,1739865600"; 
   d="scan'208";a="133283693"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 04:23:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Apr 2025 04:23:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 11 Apr 2025 04:23:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 11 Apr 2025 04:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWtAPgJi+91+RGKuf8uYGLmuVrdNuYaDq42Ju5Lxf7Frh8L4JS/h1BRRLKQ8oNLA0t35njfZdT96nlaOKUQ4VqJ7OIRHeXZG2DfxQX/IB6DIUjPtG/4vTxGGbmjXe56ioI93jCbvKRKAebilJ6BY6GDzIYhH4nfQ/eCZxGlLy+bPGQg7QbBzP3Wpz5o1/qIKK30sghha5AyTF0JKWvga7g+mLnmPLRwK++DPYjOxPH2Dd1Oze+E02zdg3D+x3AbHgQWc4Wu4RjMYcxK3Fuf6WgmE8jRI8S/KYnmSW3lNPlBIVynRp4JkgSFNhW0mWaNBaSBG+jc3cVShQ6H+U5aISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LeyUKiEmAysRmndL9CkB89WDMOw22PiJCP7+s9LKIqo=;
 b=clQmJtk3PQDPT2mqeLaLVAyxBC1YfWs+oQSm8+B5Gy6E6/Csjw3evAp+rQgSOor57hVnAZN/T7HjMZj0iTnwRdkdx3vWpr/ubFUgYpcxjGm071UMI1aiwm3Iup/k/XvonXlpXtnEYyxL1wxjWIzZPLb/7ULrkBTbf0hKQ6xTqiqYt+gZXs1tgolqsZZVdGZRRwzMhj3xaiDyIZ3N6881nd2gZejNwgswRbexdKo2+7Re7dDo/Iizi2FgXDKZA+LO3HnXafxUbN0nIBHmrKsX16gLHp57L3mOwX3ih8WUkFLy+f7LO1Bi71gexSM/Zh5SlwvCLJ1+FSqHJNfi/lISAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA0PR11MB4543.namprd11.prod.outlook.com (2603:10b6:806:99::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.27; Fri, 11 Apr 2025 11:22:53 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.025; Fri, 11 Apr 2025
 11:22:53 +0000
Date: Fri, 11 Apr 2025 13:22:46 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Vlad Dogaru <vdogaru@nvidia.com>
CC: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Gal
 Pressman" <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 11/12] net/mlx5: HWS, Free unused action STE
 tables
Message-ID: <Z/j7hl8JHZj0Q4Bu@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-12-git-send-email-tariqt@nvidia.com>
 <Z/f/ss3KqE+D0G9l@localhost.localdomain>
 <Z_gL6fvuYUmD4oPS@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z_gL6fvuYUmD4oPS@nvidia.com>
X-ClientProxiedBy: DUZPR01CA0128.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::21) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA0PR11MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a28db6-22de-482f-c3bc-08dd78eb3350
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ow9oNPUJOwFpThT2QtuLKKt+ELv0aVxlfQJ4yAO7ubvRHOc+xihYHhi82/Ro?=
 =?us-ascii?Q?zcN2zEU8yfQM+QpbIleeq1esXYGIDniQf8g1cUZM98YQY1z15Kocw84Dave4?=
 =?us-ascii?Q?Xb6k6xb6xcXWVm1wu/tnh0I+3xCYnDxVMnVWkMO/I7VRK4o7F4U3JEYXyEq2?=
 =?us-ascii?Q?uPqB/+UdwCmrftks/n29f8sN2wGKI9oG8YfdYkNAkXlxiDBNOKAGQLqVE8eT?=
 =?us-ascii?Q?XlkabLECMkIKk5YDZ59Qujpd5NX5Y7QjBMIBk4xctb1YqvOjE9ZNt00QS1E/?=
 =?us-ascii?Q?43lbIqs6KAl4VXBPcNEPrAPkyT6rYSqWVYsaNzJmArzV/C0EfN5H8j6OP7Ej?=
 =?us-ascii?Q?Kki6bUDRKQDxBUSNbUpjzLZFW0JK2Vy5KuuyoQpzKQAzL2mM7IGTl6NOZEuS?=
 =?us-ascii?Q?jlor6ET17EqZdb7kXQGjlHzOJvUpzrpNxWHEOogpENVXE9DC6RZ64EoGzmLj?=
 =?us-ascii?Q?9Y0XkZJ55AP3J7n1z7qvvqE8bai1lN0kmf8hoXWX7YnwliZ3nPycwPjahP92?=
 =?us-ascii?Q?fAK+FolDX2IeUNtXmjdHQtat+6geZjltQSS0x88Min7toWLp0mx+OKrcvaBh?=
 =?us-ascii?Q?lQ42pvJTbY6536yy6OSOTTodPi533S3xAM5DjaEkWa7PKlj0eG6oqnAu/qaA?=
 =?us-ascii?Q?N+ZcGd50/S7wkULAUhikDw2oJaSiCUDowmxquhnAItpr5ECKkyRo2mVPYVR4?=
 =?us-ascii?Q?1+tx2WVG0Qz1r15QRz9hAqvidS4O8mXukSKEHVlC72DnOboZBrSpkfxyWn7Y?=
 =?us-ascii?Q?2bviwVsEy4aiBJVA09QU0neyCid06OSVwpeILUc5hLT82mgwB0vY+xy1eXKJ?=
 =?us-ascii?Q?3haELvZAWJuajpM6ViiRV55F4i5NmQQ08nL03Iuy2SfqXQ+DOLC9jSBpbxFe?=
 =?us-ascii?Q?+47zdYHNtsKoecIENTPT5qZe3KDPpWcR4WFKVAuV4tn7nDXuJG7FSAC3GKAW?=
 =?us-ascii?Q?SEvbiAPpLw6rpC8liGlK4k9kiLcIaaNM5i9ZbQV3nXq4E78krgX/tcVYzmPf?=
 =?us-ascii?Q?XWkBlDyDcMQFTJPZnOIrr9F0SmYrY+NuJyhL0W/+Zhr/eCdVUwIIgMZB47E0?=
 =?us-ascii?Q?+N/Tw2vNOFU9S4Gs36dwgzvJdZLUHfk0DKzZmlXVpXgJtWYVNOUxPcxyCqMk?=
 =?us-ascii?Q?/nFac5GpEsYDOZDxF2idYywUrZusSTsFaqfcid1xVG1WxszU8/Yh6fL4Pd1n?=
 =?us-ascii?Q?TYHiCBfwzHT+CvPgFd3h1R2/pcEVboHHYT6rXeJAywRaeihlNN79OXCAuvgu?=
 =?us-ascii?Q?ujva9qp+67tYevMLBO5KZUzdwRF+1hvb6+s9W3H2xXRzEUADsSy35hj+NtxZ?=
 =?us-ascii?Q?tyRJmYBwwzAP0ZF4QOeuQ06N2XTs0I+kwHXPu7iKL6B0bNeH3XsuBwxrVTyJ?=
 =?us-ascii?Q?Hq/6Z9iR8IP7vUQXjxV5NydJxW88/xGynVkoqRrCvY6IwLs4ypi62geP5f6w?=
 =?us-ascii?Q?2xc+oVfp9+E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hjpxg3aPBxdF80ZnKhsNHQWM9jeaFRFfRrr7/f4jYBPpbdSwFKjk1AFiIkaY?=
 =?us-ascii?Q?ve7yb9XlwfBoyHx0rA77p/Wi3ReOwlzbuZFNBv+Zn5UqhLRx/0diVnu1zfIp?=
 =?us-ascii?Q?O7iy2DL9PLWktAXRgIwp1+0PXKM6M3TcBaORARia8NHfdx3Tj6nXFdQjWdjb?=
 =?us-ascii?Q?QXuGab0RUxNE6kVdqQNAkfGEThiNW3ONk0nvjf/i4tFV5NY/45PxJEZkzNrl?=
 =?us-ascii?Q?OOhHDxqjp6xEGDPnvijdwHrECaE/hVDdEhuavcyTuB6EMevHvQLrZiuMkZwc?=
 =?us-ascii?Q?pVdUy8MTKM/W2fJ8jSHSo+FjeRPFl+6DVM7h6e5OkvvVp2C9anCv10CVLhJn?=
 =?us-ascii?Q?mo5K3w4nLlYoxKbCvgWSomOsuwB2l316LUaTFe3pc07LM8SrWasXN0ohpW1l?=
 =?us-ascii?Q?dSzdZZRuIhgTo5f7ZKp15OKXkr4Jp/7OPVbieiF4f7W+Pj+6MTZNwtqtAIuB?=
 =?us-ascii?Q?zmWZZHwf+MvoTDGidtPF0Cfq9yaC9S3IslG48g4642muWeDp/7Vb8Bu80sgY?=
 =?us-ascii?Q?a7N7zeZhTzW7jNqDk4JXE19pk7dM0FH4xydSy6eL+Es4a8os93k2y337ukhz?=
 =?us-ascii?Q?KRsLMWqcmNuTUKPESqKwz8TEK+ff05VjXZSDTxVjqhHES8qg/OOPouQEJMUF?=
 =?us-ascii?Q?v5w1oponrJL14bPVaazKW/pHwETMdkOqLr9Jw+/RJ7ev0uA4Fqd2KAq/i9+7?=
 =?us-ascii?Q?RAG7I8tHbmA/3DLqrtF0qJNKpyRxcrpeR8yGR0SOdlr5jJh9WKYnDVAJ56Ze?=
 =?us-ascii?Q?iQBTbzEuPONOGiPmsf6gXw46nifeyrfpv18lhkgmcWJtwK1r/LdnkeAhTMCy?=
 =?us-ascii?Q?PmU72ED8UlypcwXIAMubAcET3P6yrNWyCY92YZY4DrvJfAj121DC9hEuzol4?=
 =?us-ascii?Q?1h3sD3u+QzdfbGGEW50dYMuhIBcjXHoFwqLKoMmmLgSOqXBlvOvNExd9b0CK?=
 =?us-ascii?Q?d/p5Ob8Zp53XovDQ6EyqULbHDPf2l4E7c7pB1YSZWxzToyIh9lnZcyep4DrN?=
 =?us-ascii?Q?jUqj/FEsNyEW92AAz5AbLyJSRf31Eq0z9Wh87ak3j+H3bKvR2juf2pZeq+1K?=
 =?us-ascii?Q?CmlhrihsMMrsX5BM6ihGm5PDNZ7rxXbN2Ub2dmW+kjgltIMZNA4f1+9Cbt6X?=
 =?us-ascii?Q?9NVX211uywqv9csw6ioCGf+6KMdyTiDHPc5SoUTS3zkMFihPbSmbnIsoZenF?=
 =?us-ascii?Q?c9AcqtVLDZwlvUWs9DHbZahdFHiGIuebu+bRuEW1XHGtt8Ata9A2gQhuzI/A?=
 =?us-ascii?Q?nfvdzFjT7BkKWv0Qhag9kDWoWZoVGEFzw6PZDAjwDodk1a5h8Q2UZiUY7+vv?=
 =?us-ascii?Q?Vp0LWgXs1BOEiK16dIKekT/tEZcvmTA1HQ1wN5EtzfRp+H6lhI+lVI3W6o13?=
 =?us-ascii?Q?9KM+cJKd4K+XZN1boN9YM+9dDYW5a4dg+5vL4ynmY3fkrxw0Jyw/fkmzYFha?=
 =?us-ascii?Q?wBFQsF6iJ96geNWvZcqEozdK3Y5Rpd5eXZLx/tDMqCE0SRZMKrL19FdiksJ6?=
 =?us-ascii?Q?qi2QrHyzCGnOAT1tD0JTksS3BayCrP4JB0E5Dz3jjyDzorwCWFDEVgfzgTk7?=
 =?us-ascii?Q?2n69BaW1u1F9tDdFL4iqTMeKlQ2crTarTDTA0uJeMEoKsu08daMA6zQ69Djs?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a28db6-22de-482f-c3bc-08dd78eb3350
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 11:22:53.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbGjp5799ECskRkcWmbo3lExkRnLi22mCbiieY+/ZvPGEuBuaBqP4HcMzO6t93kv6/1LrF387P09s3tcHrCxAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4543
X-OriginatorOrg: intel.com

On Thu, Apr 10, 2025 at 08:20:25PM +0200, Vlad Dogaru wrote:
> On Thu, Apr 10, 2025 at 07:28:18PM +0200, Michal Kubiak wrote:
> > On Tue, Apr 08, 2025 at 05:00:55PM +0300, Tariq Toukan wrote:
> > > From: Vlad Dogaru <vdogaru@nvidia.com>
> > > 
> > > Periodically check for unused action STE tables and free their
> > > associated resources. In order to do this safely, add a per-queue lock
> > > to synchronize the garbage collect work with regular operations on
> > > steering rules.
> > > 
> > > Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> > > Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> > > Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> > > Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> > > ---
> > >  .../mlx5/core/steering/hws/action_ste_pool.c  | 88 ++++++++++++++++++-
> > >  .../mlx5/core/steering/hws/action_ste_pool.h  | 11 +++
> > >  .../mellanox/mlx5/core/steering/hws/context.h |  1 +
> > >  3 files changed, 96 insertions(+), 4 deletions(-)
> > 
> > [...]
> > 
> > > +
> > > +static void hws_action_ste_pool_cleanup(struct work_struct *work)
> > > +{
> > > +	enum mlx5hws_pool_optimize opt;
> > > +	struct mlx5hws_context *ctx;
> > > +	LIST_HEAD(cleanup);
> > > +	int i;
> > > +
> > > +	ctx = container_of(work, struct mlx5hws_context,
> > > +			   action_ste_cleanup.work);
> > > +
> > > +	for (i = 0; i < ctx->queues; i++) {
> > > +		struct mlx5hws_action_ste_pool *p = &ctx->action_ste_pool[i];
> > > +
> > > +		mutex_lock(&p->lock);
> > > +		for (opt = MLX5HWS_POOL_OPTIMIZE_NONE;
> > > +		     opt < MLX5HWS_POOL_OPTIMIZE_MAX; opt++)
> > > +			hws_action_ste_pool_element_collect_stale(
> > > +				&p->elems[opt], &cleanup);
> > > +		mutex_unlock(&p->lock);
> > > +	}
> > 
> > As I understand, in the loop above all unused items are being collected
> > to remove them at the end of the function, using `hws_action_ste_table_cleanup_list()`.
> > 
> > I noticed that only the collecting of elements is protected with the mutex.
> > So I have a question: is it possible that in a very short period of time
> > (between `mutex_unlock()` and `hws_action_ste_table_cleanup_list()` calls),
> > the cleanup list can somehow be invalidated (by changing the STE state
> > in another thread)?
> 
> An action_ste_table is either:
> (a) in an action_ste_pool (indirectly, via a pool element); or
> (b) in a cleanup list.
> 
> In situation (a), both the table's last_used timestamp and its offsets
> are protected by the parent pool's mutex. The table can only be accessed
> through its parent pool.
> 
> In situation (b), the table can only be accessed by its parent list, and
> the only thing we do with it is free it.
> 
> There is only one transition, from state (a) to state (b), never the
> other way around. This transition is done under the parent pool's mutex.
> 
> We only move tables to the cleanup list when all of their elements are
> available, so there is no risk of a `chunk_free` call accessing a table
> that's on a cleanup list: there are no chunks left to free.
> 
> I think this is airtight, but I'm happy to explore possible scenarios if
> you have any in mind.
> 
> Thank you for the detailed review,
> Vlad


Hi Vlad,

Thanks for your detailed explanation!
I was under the mistaken assumption that the `cleanup` list only had
some sort of reference to actual data. Now I see that the function
`hws_action_ste_pool_element_collect_stale` moves the real STE data
from one list to another, so only that function call should be protected
by the mutex.
Perhaps, I should have inspected the implementation of
`hws_action_ste_pool_element_collect_stale()` more closely. :-)

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

PS. I saw your V2 - will take a look.






