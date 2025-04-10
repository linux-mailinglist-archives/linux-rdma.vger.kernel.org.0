Return-Path: <linux-rdma+bounces-9340-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E924CA84AAD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05FC87AECA1
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 17:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D891EFF92;
	Thu, 10 Apr 2025 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDf0L8bj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5ED1EF09C;
	Thu, 10 Apr 2025 17:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304822; cv=fail; b=P+IkSRqqXHknOggUipP+C/SZKig1Nbh9y/FDlZemupiD+4ErYT34PCurzqbtQSLxDdohrJyk4xYaKfyCFIShV9+f8z8C9G2EAAlJ727dIZDfgPfKzzQjiZ/y1Ua8sTfL8b32KpAw6SjQcw6L4HrokwqJ2J61LQ0qkgqSxhtrr8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304822; c=relaxed/simple;
	bh=PamH40c+jj2lCpp2GujWMAwPF/OATAkckktBPDr1tKs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cKLwtPkr7T3HwdilXY5B/MMjiz+cwvvdsVdP5ZPkFBcHgnZg0h7QeRQEAeDj9+LtWjhb+O5NKytYkHjxloOKKr89cgAcAftnFVx7yO5CWwFCfWV+Y1UJDXT4BKZlDWuD9fFuj6EopwGv1YHuh1O1pALJFgP4vIB5D70npR5UGGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDf0L8bj; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744304820; x=1775840820;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PamH40c+jj2lCpp2GujWMAwPF/OATAkckktBPDr1tKs=;
  b=GDf0L8bjLn55i8XQhtTjGOXpAtXJIFbd3+SjgvI0t2Br7b4fQ6N+PZ1n
   dM5myoYHcpN4mVoydRwJrDFYdmUPhzuydzFYNdm7L/rg6DCiDTXr9bcwx
   hrjix4HdWhyXCQI17kro4GA4yfy7h3YCUhQqPpPBR06zkx/Vc5iJ0clZm
   pfGQmj5dos6Pgw9+WtMEWdKP4iOqNkJsy3vhvR7RkGUEKW+HIefTTcoJB
   RTJCbV7WNTgl2a8df3zuAm96Ch/bYdwXe0FijRqm6X4+bihYwku+JMcfT
   kZPjefYbxJVlItXp7o2yfMCoNOzGwBTlo5KLSyBE21eosaGCJKu2GP4fa
   w==;
X-CSE-ConnectionGUID: HmxjsHw9QIO07OE1eHh1Qw==
X-CSE-MsgGUID: qJZGFykcTV6Wux6jHswG0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="46007076"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="46007076"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:06:59 -0700
X-CSE-ConnectionGUID: LGU43OLZRS2s+Tb21j3ATg==
X-CSE-MsgGUID: 8qseD1QaSmGkq9g85CfD0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="134077693"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:06:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 10:06:58 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 10:06:58 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 10:06:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrqw4/2o2Ts1YEdJwhMZ6t7FuMcO/q+yHZOjrA6awzPjnICjicvlcg5+BK3GyM6CP7n507mpcLRezcpoVpkK/v4/WOOh500D8Os88r6H6bjUAgLIlg3B4ExmecGV5gMwZ6Pj7p4fXJDx2ti5r6j58bRjBVoKCC1YlWq4M2FdA/HzFm0tfz8U3wVG4/gzgh065T0qEJlDa9q2ElTuFytNWNnIfm1YgZwRgKb5DfruJIWQZP3vIvu86+eTsO1iVXYhTkbIUoUUw7vD9lozV38Hclci7Kv6j44tEXfDADYFZ/nRRwenCQQ1Q9yy3h0meuQDWyRfEhm6xxBro7E05UGrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hLItiD6lIeMX+tw1wtV7li/sz4XZCsezcG1HIP7c+o=;
 b=inBG9pBxCGKkn9nyBCvJX6HwKfD4jhQnbbqB8x3I0VaEz7M/q5pFWFDaMK9lb5sNlzv2H1AhZJ1GpC1fh0zKQ4NbaHM5+ppJoOiJSLLpiPZrm2e0n+VynCSreZBjP0zsy5jTUPlfN9tYQ3uvWZoVKAhCunFDkgmT5UdnpP58GeamCX/7qd8v+b3fKX2LU+i4pTpiIp/IenCQ/82ZdjekHzXwScm9UbCY7K5J2zH/bHCduHpVEY8LwHKgsUMmuryj8/VvrX2WgycE8U3uy937E4sg/3qaHvSgLN9uFlJRc63VRkYa8GtsDldSphIrR2tbaYl62esM8JyktUParSyPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 PH7PR11MB6329.namprd11.prod.outlook.com (2603:10b6:510:1ff::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 17:06:51 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 17:06:51 +0000
Date: Thu, 10 Apr 2025 19:06:44 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>
Subject: Re: [PATCH net-next 12/12] net/mlx5: HWS, Export action STE tables
 to debugfs
Message-ID: <Z/f6pIJF0qSjJLqq@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-13-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-13-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DUZPR01CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::9) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|PH7PR11MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: d6676ef1-ad3a-45ab-8e9a-08dd785215fd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SMs1lP3yXKIFxhhy1ReGJNJlwDeuFUEurdtuNcJk7b6rKK/p7pBT6Zy2lQiu?=
 =?us-ascii?Q?YwPaTWwVgK7g7Yhun2eSlUbUWjln5+Dzuum6QxAfyNNoEj75hpPdEp6vSvG1?=
 =?us-ascii?Q?9EPMi9s1KCXJiAbcpyQguqdiXpGppi8aLe2hpMPHA1Krn25DEq09+b/O+iRY?=
 =?us-ascii?Q?aAtiM4wYtYkXypVWg0kF3qx1yZNU//E8STlyuAr58rMbNXnV81S2rF6rvzSK?=
 =?us-ascii?Q?dONDlDoENoTBI9eP3JAQj5bgZxsCw1xz5C1i/zssFxfgyxwIGgG/kFaR73Ud?=
 =?us-ascii?Q?DY1t15IixmdrdsXqJmlwe/WXw77hN8cuJ3wlW9nFzfScy8vxl05rZzZjthwI?=
 =?us-ascii?Q?xy+hDYum9Vk9GZBqxIsqhMgg8HscR8niFbFivlr2kh6hxBcoWkZL3bLBBh8X?=
 =?us-ascii?Q?7tZv6OP7jJxqux/HXv6wQwMm6LjW7v1ndHD8PcWnE85lPEW3XX1qm6l3g/vC?=
 =?us-ascii?Q?3m0dBpWD9+tBf0LDI0LTb2ol6JQbMvH017XKXWsAGL9B+8qIe3n3qPnXWXyo?=
 =?us-ascii?Q?toUA+lozGtE80n8gEEzywv+7JIipSw7jV221purw8b5q5uqpuYkg0Hev3mlJ?=
 =?us-ascii?Q?i4nVOMUF8kPBzJaCAq+7Kq5YmNrFtBvc3DOyZSPZdljIRBnmR5Z6uepvm8W7?=
 =?us-ascii?Q?84klRGsqunAIlvZcpvayrtYnIq57jDeG7mp8H1AiCwO0S5aqXHVraTGy00ge?=
 =?us-ascii?Q?7bWjs6f6y9Q/FTgEGjOzsldm5nrquzZqvgv5I5n341BTigd0TH7h++klWPas?=
 =?us-ascii?Q?SIr3C+UMyN5dgcyLhqdHU4NQ5yUBqAUjoLbSAdKgx2P+Nrh9E7CCVqOWTs8b?=
 =?us-ascii?Q?1Vo8voP9tfJgavoQwxP2296G8ok+bvJ66deXu00OQkWeP+RF8IH40wx+d4Dp?=
 =?us-ascii?Q?ITyY3SXyJ7zbCzAIUBSHd7yLgVOpAfEUu+mu6GDa8/8BJyD+t1mNduxEwV6A?=
 =?us-ascii?Q?746jtIU83JaKkAccXxCVj7xKakAxvpdvUmQ57pc2/jlsQOYPs/OwjkyG0cfK?=
 =?us-ascii?Q?fLASggOljHPaMRHUZkB+ZXpLlMzYPoEEhoN159jP4OhJeHMpOXE4WC36r1eG?=
 =?us-ascii?Q?hY+xcYRxrE+LhqOtWrcEC66deHDecZHCZn+zblp4xRkA8vT4LaeZKpOFCsbq?=
 =?us-ascii?Q?U+DO2gkefivgFGReXTsm+Je4pZtPfwu51YpJ5A0gGej94YnZVvZpvn5h8iS3?=
 =?us-ascii?Q?Vz8PUc8OhA9T3nFcsJ2Xu+bCWtoQ8arLIzX/KaF9YtoIIkqcZxTNoA7+0RGV?=
 =?us-ascii?Q?L/uMUpxt0sS4dCgTKhlVuvPFIWOqNJym6l8fDYQAfbpwWYMhq55VCfBRtW6d?=
 =?us-ascii?Q?ynlxwB37ENLlFp0o66shjDDGV7Jkzz2dxp8AJDGFkK/ovUMskkJqebTo2V5v?=
 =?us-ascii?Q?i/oSwobSNPIPrf3qYAfqhjGWn7Qz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kz/9+qdStrdYM/02L0kwc376VVRAkBWF9IWtWNCZJ6mrmARdXRH2xWybxGi?=
 =?us-ascii?Q?mW5T0iYVKYYRFCfddNVcAfmUWmNSARms0hm9Ee2lwj22aCgOwMkYoDtRoIOc?=
 =?us-ascii?Q?+aU0CPwMwYUoStazTfRApjeicAandPpCTVjBQSC2vq/3AWEyGP6JWa3PT1I+?=
 =?us-ascii?Q?IAo+o7s72DjPgvle5/3OXvRtkmUy6DOX+Gs7/7sJJyUNyboJFQcxWwuDCAky?=
 =?us-ascii?Q?m/YN86v15YdN8dr6fq1zTSI+/Tt0VSH0Umks3a9iXVHNzGbVDhmfjffpnTDH?=
 =?us-ascii?Q?RcE2EmOzXq0SsamhZ0XXusBwHvKd56SyVeUIQLmixtcQxOSYNwjqTmqB/i9O?=
 =?us-ascii?Q?C0TSuOVL0d6YmFnvhEQQLQ2+7gFCSQM36LpWBrAs+22HP6dGnRVVynLmlghH?=
 =?us-ascii?Q?A4w03g4LIdRApWiNZxigWU7LEI9oLNtgrcuPkW02KpL3cVxANbWvrJtlk47h?=
 =?us-ascii?Q?bFtCF1GKsXqrjR/jKSRe/N2gb0CQc0u03TyUFyEM7NyMGGETfHl5bxm+dk82?=
 =?us-ascii?Q?gmeCfGrurEuaRqEoEVRm14EkTEpBwDgI5k4AhbGh03H5uLkV4ZViXHx41sFN?=
 =?us-ascii?Q?1uiOApq4xWwOc92RVMWM7725luoXbyuDRR5yB7Il/ZyAQpnSQ/paDCBxRcoJ?=
 =?us-ascii?Q?3jIV7uOrMcEVV7gzjmwhQooVa8pEp9rHzD7UWJ1cD0ktugxyTgZJ8ullPUMR?=
 =?us-ascii?Q?EF1mX5qk1gBGiQRH7V3NoqVJiM0ZPMzGS4O7UZJ4WViv8cuYUHxOrsABxXzN?=
 =?us-ascii?Q?CezgwrNFY/KeLQ2mJjJa0Q78+VVvcMCSsAB2U3DI7iho70WgmqROhHcsNZ3x?=
 =?us-ascii?Q?+iGZfyEa0US8t2jp638KpPsqi+lgzAQ4q2OYfE33gLDm65+dQycqZDP/JsRa?=
 =?us-ascii?Q?OAZoHoD1vOv3Zte8ByllvQbo+bDNfSeVzsiGSODy9NWRqHATdqgTQoue6j1B?=
 =?us-ascii?Q?xXG+dHbNFVNqBz3nEEWbXN/MetoU5qDK9IjwzhPA/LhpeZrez1iLm3pLpwSc?=
 =?us-ascii?Q?cc9RcE/wfJbg90FWL3vaUOs8pkJYrfQd3LtZd0gey/OnxP+pafR2TOTAqlWx?=
 =?us-ascii?Q?YCWaMKDYyysvDa+dZtdrhKeGMaHZbsC/r4X/MR2wrLdmYfbs7cezjAZuqJWS?=
 =?us-ascii?Q?fj8Q9ZbyFud2RUtmsoIRhaj6FWUQPqn0+X3HUDqUKSRNOpK0MLYjVNq4Ufpi?=
 =?us-ascii?Q?fOZg5HByOF+KSumj9XVFqrvyIiuHmEoIuVtqN7GuhjwjtgU59boXOxwwhn4P?=
 =?us-ascii?Q?3CkfozMl7olqy/JyAttCyUyBU6Lgg1xV4WFHklSba7UIgpw9FljlgMz2Ul1A?=
 =?us-ascii?Q?q5G9bfr63lmUY7OCcFfui16bl0i4RRUsGqMia2D2CCJg52LMwR8Ojz+CUojR?=
 =?us-ascii?Q?x9kkWv+5Z5YuqO8mjYods2IhPysjfwFEzevOGaE8Pjd3FY4T62g4GyYAoibQ?=
 =?us-ascii?Q?BaxT4BAA0dyVBwD6QBmfvc3M3rgFUQx2XklNvZe6UdKxyb4BcDW7sXyrWGy+?=
 =?us-ascii?Q?y1KKZskezIOSqAlaQxMkZXdXn0RM9Ij/guL+0C/SfEtHBjaVq4VnE/9PYl+A?=
 =?us-ascii?Q?VikDMQHJVka+yBNGhg/k3TTHql2vxGkory4CVrwr/eqxcD4NnVtJNYxozVwI?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6676ef1-ad3a-45ab-8e9a-08dd785215fd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:06:50.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7JuYbnnaCxy7d365AYCavv0ZK65eUs+cpKKM2unltncSc6Zf6B4HjHSa8fKJarp/7Tgs8GoXHSoU1Vhp4VqLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6329
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:56PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Introduce a new type of dump object and dump all action STE tables,
> along with information on their RTCs and STEs.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Hamdan Agbariya <hamdani@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


