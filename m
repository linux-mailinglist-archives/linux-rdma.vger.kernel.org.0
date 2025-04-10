Return-Path: <linux-rdma+bounces-9336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B76CA8475D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DCA4C54B2
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D638F1DED52;
	Thu, 10 Apr 2025 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f2nKZ5XE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9C5CDF1;
	Thu, 10 Apr 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297792; cv=fail; b=CAPk0cJLzn8KS+9m0ZjfmqQ7T2mGw+0IjDGfsY1+IX6dcy6NzpDJwGyKqcp8GmlR8wLTY+qNrfrBSsRRKqEK4bzXpx/wO/nQeAs3YXNvU7gnKQf7Qpyxjsww2YGwLFknl/W6XccBCwSbPGvLOyI3CTl1Oj3KcirXj7NSFKfKmhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297792; c=relaxed/simple;
	bh=jsfTzLVKbcOw06oh4g50jJMZHgjSb+V6FYUvsydbHMA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WC/EPtM4NCJXF7OHI46mwv6q4asEV0Qh4KsOpoQroIWIQD3V3mwzWcJFZSC0D2NZlQ+r9YxVBhl24CAupktgcSOxQxHQfPDnIVmKNIxc7oNL1sBF5VUXSwQ11gixpQr5IbbZNParU7gRJm97jDrmYvBRT/ufu8mJXJDJRaUjkEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f2nKZ5XE; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744297791; x=1775833791;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jsfTzLVKbcOw06oh4g50jJMZHgjSb+V6FYUvsydbHMA=;
  b=f2nKZ5XEGSLP77JpeQU6uB7i2TrC0z4YPNgDPqZj8gkOpTigRGoz1D6j
   hk+s6H+G5/18f8F8te4iOx9yDe+oUiCGkHsi/PiEwUM84bH9UEDWdOBDK
   h6Q8/WfNFWNgio5lOcmdk8JrYq+0mtXpjLLg0Zx43AxCwyN5HQdHcpBdx
   WRR8ZcQk5NiLoARDkaKaZajBmIJMlk+aIREaTUgWgGGkOI9pzN56YVkXu
   RmF+tupnasegdKTLp1cUzsgldoFJ237pQqsTOkR0yv0PM8OW34/QUJ50A
   PNHA6UI6SCKNA9rfJWJgqfGKV8kF+Si0iztiMu5LRApla1wznsjbp2U51
   Q==;
X-CSE-ConnectionGUID: iEj+FMPfSkSwqGoHtBnhxg==
X-CSE-MsgGUID: jItAL0VqTHKx66Ow9vKD2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="71212025"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="71212025"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:09:46 -0700
X-CSE-ConnectionGUID: 6prN6gQhQPe12LLgdrWlIA==
X-CSE-MsgGUID: JQoMq/ESTRqV8Dcp0ZoBdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129882004"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 08:09:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 08:09:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 08:09:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 08:09:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWW619zbBufhht5VsBqEkt+vZFpIwJ876WHdxENSJPCvFkcdEDt9aI1veubWMA2tFr3+3aFMj4o7UxJ23ESoVj/Lp5TCqzA2fxvgat6nMegjQpivnf5Ii2BWVX8YpTBSwxOGm4suRTJAGv/YFcS6T4jHtkObKmc7na/tMZsqU+WcXW6ujc2hDfjcInWWaffcCC9LtFmnLo5uHeRb0c8BoimzGbGw6qSqBxZCBhSEvaASKCHGMmYuU698MNykRSDatC/Oq5rTTs3ecVeNqgugINFjASqqVILLkZhJP/jFj4Bp254xa0wACy064VVLBOjp1Zbi90d97DhCg28mo2EUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBCW5cPsaEstCQGORfreewANFLcJZV/N0Da0qBb3WRw=;
 b=Jn4kllrNKyzEYltcz3vBqBYhKIf4mNVIQli83hsQ/Iq608L2UFazckxSdbyEldngtZonxI8Q2RpQmW99G4ma1m6ijm1tIYWex6m0PtU0Z+OZe7fzYyM+wch56KUf+utxb+2I6AOx83dYqkjFN2rMc+jsl/80zHTVf0W8Ip/Xhi9b0ssPRrFlthu6FWMIC+2/k3dcZzRLhdwBxbS7nztpfEzhzaWKfWTafj+28wM0NjOeHMkKNtpkrFETppffYvmMv3Fz9smfSJ3epTMov8m+5FFV0wexdwLiJc0fmAiaQ/e4Vg8iqdeKAqEHuepwxglJnabTmBktX3kzPVPWXUvPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 IA1PR11MB6347.namprd11.prod.outlook.com (2603:10b6:208:388::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.35; Thu, 10 Apr 2025 15:09:36 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:09:36 +0000
Date: Thu, 10 Apr 2025 17:09:25 +0200
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
Subject: Re: [PATCH net-next 08/12] net/mlx5: HWS, Implement action STE pool
Message-ID: <Z/ffJUkWbS15sPAs@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-9-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-9-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DB7PR02CA0026.eurprd02.prod.outlook.com
 (2603:10a6:10:52::39) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|IA1PR11MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be66cea-ec7e-4bf4-eb4d-08dd7841b534
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vM1kqofnPOMiMWaszJ5t2cNIeg1nmgyODcnyc3WunLrtx2mpYuTPPeeAJuBN?=
 =?us-ascii?Q?9PBlj+KKJlkl8No7+GX2hC62r79UHsh3DYaWBR2hnbOyUluwXjfMifM6Ljti?=
 =?us-ascii?Q?0sOYUkSm0OYiOyzJI5G57CvNDpWfeJ4F/dfGHN9K1DxQreNktE33iIcDVgty?=
 =?us-ascii?Q?30krgl6oukFFWSdVjQqA34Q19V1UTa2Sp/VapZoEvKl3izSwQQ8COnfMBmiG?=
 =?us-ascii?Q?+6u358IkEYvbCyFu2jHmG/S4LBwgKlOHnDmYippmg8ITWZDT1Te2WyPWyoO4?=
 =?us-ascii?Q?SvnPvlwdFasH+FZIhFChWp57WgAsCCY8OlKTkO4NTmSvtDuIx56lva3Z5lES?=
 =?us-ascii?Q?FxO1J53A9/AUZYhzXjLBKAdDGVnxWe1ZFT1J9vkCp5ZMwKC9SW99JTfU6EFE?=
 =?us-ascii?Q?BFv0tk6G1KymfUrxSC5uDjgjLSC3GjywWJooxdPUVKIE/T3c7+fu50zzZ+Iu?=
 =?us-ascii?Q?raFVR1Q8kZ4RBxg54HlfsSVLRU8E63yaWKVRaCl1mkc8IpHngoTS3xgtZPgt?=
 =?us-ascii?Q?5YMiBOiq077lA7q/tuqs2fLMLlrEEB259y9neeO2zUleQqBZ+yr/+7Uh4BRE?=
 =?us-ascii?Q?qXuNyFIQegPoLhanXPWDxf1yMp8gS+/96sVkBewmwEGiwAeg/b9ujB1fqufd?=
 =?us-ascii?Q?rdP5NS0eVN2BB86DCIAqrgtEuMp7wdJAA4wIVX4CHVuwKEt8S/R0E46CruOY?=
 =?us-ascii?Q?i3sIKM2zZWlu3yWIoecAscjwjxVIgNB8o4ROuujMag3b65kJ7bUZ4YbNl4kg?=
 =?us-ascii?Q?h33zxhfrwqy7t5tTf47ep38YKNckMQLPfAXQsJBagizyVN8WJrTOJM5nsv23?=
 =?us-ascii?Q?8THY3Pbwpm1LeRe1m3i+KKVGcTU1ATIYlYRsk0brPsa6/Mdqe56lFgUNabAJ?=
 =?us-ascii?Q?y6RAtR2VgdHrrpoZBXihlmbq7uQtRZ0WnzZGRq6td1MfjMzOhcgLwLX2mGzI?=
 =?us-ascii?Q?Bg6H6csfaR8i0fTwv/43E5OmpnSd+C5fuTyoqQ4JTge7RiM+jh3wJkCo7SM8?=
 =?us-ascii?Q?C61OuAHFgfs1ll+6eZvMeyAdGXc5ZdfHs8d3kwEjJvwNEtooBCVNWIxSCu3Z?=
 =?us-ascii?Q?sdn8OXRgG/pDSeZG9KtHqwUkBtWiGYYMTIRbxpLp2iluM64I6rJNAUpEjQKX?=
 =?us-ascii?Q?dYXAsWjb9lk3+5D0DulPUgitoEQbS3IZx/hWSHH4ss2wKZR5Vym9nvWxXnqM?=
 =?us-ascii?Q?PMnrqe89lvr4o0G7S3gywJh2MpO5um9f/qaayS/oQq1I/flvDSswoqF9Kyel?=
 =?us-ascii?Q?5xIz2h8I05wDlmBolFOb9uw9glq0IfRe7xKkDJpxj7DKcWhmza6yixbuUGdT?=
 =?us-ascii?Q?rzkVDln5qhSIfBgeMLHIkklUIEDeTaDEu4smuBrriZiH/1xZUdD5RzrH7fFg?=
 =?us-ascii?Q?vLP3pmew9ZwXZ4yyO9QgvPKgTQBO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iB4wfSi8GPo34i31q9JHB1jftlAW8vtqGYW/NsmIv074++71pAcLB750HYR2?=
 =?us-ascii?Q?fz+Ih+C8yyJkjz1uVrVrqqFph8X9tUKkyH6Z1iU+u4DiyYaZMDKnWNzgHCF7?=
 =?us-ascii?Q?mqaezCLbynbL0QjpK5jWxYa9VcRANaLk1M/SwIhuyZK5AfJSjg7QEIZBy30N?=
 =?us-ascii?Q?gmmd0LBvIhWs3lTLrhvKfn5zMCjk6TooMVMn+Rwz/dZihvz2mmkLcon4QCpb?=
 =?us-ascii?Q?vAAhXv5bdfmdobfePzxakge0wMaESc7euHjCr9PBjpaqHy93uoLimQcRJlTg?=
 =?us-ascii?Q?ivwBEt8+UdFBed64x0PsWt/g811Wa8P65EcdFi0Lx6DzopwuN7lsBIQsXZSB?=
 =?us-ascii?Q?lOUKotd18UaiP3fUj2HVVyUBBTkbn0ELqV8tiIATqiUtkR/JD64NJ5xwDpDC?=
 =?us-ascii?Q?Cqw1RZfI47TVNrF2d+qu8DHWCgBY9T0g9n2JrygVMl8s1R7UPCxnjkujuElk?=
 =?us-ascii?Q?lJ2/E7vYk10kUoexfmNUCZ2QAYwC5mMNaNBNaLHSe2OfXxOjbKziVEgxe0WU?=
 =?us-ascii?Q?9KEjy+dhZWi66CGQCtTWIFvmCYM3ADTVF/x9rCFpQ6iAAIBQO60L4jtjcNdV?=
 =?us-ascii?Q?mM89f/TyDLyaexGZVBbJgwW1yuTfo+a9Gi2feAqrYOStdIajSdVcgHpWbggI?=
 =?us-ascii?Q?E8AZwR0biP7LeKhB0fUwlp0UkXbErSkYbmthR1Hmed3rL9iVaUgZtPlrfj3o?=
 =?us-ascii?Q?OwqJ3kBOcHZ4tW5Kc6xknipW31VDYNyIxRnjKXmJKyIgJP2hDblPofsRWsHp?=
 =?us-ascii?Q?34RjDO2HVLt18gBffaV1xIjiIlrp6u3+EYeAT7LStfN7y4GmSMMe5Il+fBjJ?=
 =?us-ascii?Q?CRnzCBxLpryUwtgc95HGQRJZyLwyZcpQ/DQ2xfrWLOupYoKenc/GjcVi16Dw?=
 =?us-ascii?Q?gvoD+Xas+0ipCsSaRDCRLSl9TBAyp7Udf+c1HR2smjvVtMhPOX7xtQja1HKD?=
 =?us-ascii?Q?iDqh9bJJIDtSYSTOp/+qQch2je5pGcDqm0bX/0y07GMgKB949g6xJ/x9ZVz9?=
 =?us-ascii?Q?of+NZ+dPb1hz57xEKqOJwXZR+sgwfovttOwwIuH3f29utPxPfuAciIm5VHfq?=
 =?us-ascii?Q?PCuK+I8A5TX0CST+AFJTOmmxbxe8b8aGh3+C4nGBc61vHegpYIvE83P+bZJQ?=
 =?us-ascii?Q?knkijEGnju+lpNVmYkIyVxr2DmmWOpwJcmog01w+zh1R//4AOiteFSn0Wa7k?=
 =?us-ascii?Q?bt1TpRbQ3upiIDvskPUUG7YIhEdM1ThVqgR3nqVs0gM+TCOR3/8dDkbaAvzt?=
 =?us-ascii?Q?7q/HjFOpsKrN/Y+2Un/Pd//GQoQZ7v+unymcjD2fi+1hoynYerQHXyBZ2EIM?=
 =?us-ascii?Q?u7FJRqvV1pTAIlO5WTyEDZ5HznBo4k5ALu4fF42Jg4PLRQCI7bJGv9aUE5MQ?=
 =?us-ascii?Q?DyOus6mRJ4MM2aTbwXhGdOZ3E99y+fka0iL1qKGOIDL5YxyzIAQ/KxZeMjme?=
 =?us-ascii?Q?oOjZJ1SBES1/LtEZSg/FlFXuaLPYf1SZGAGcw0R4rEBS5ijPJcIgiXRYSdjr?=
 =?us-ascii?Q?38JYYC3vzt4iVbCOKFX9WAK+fU3XEVYGyiR0yfx9Ahww8CmLNw6tyqeW/Hb2?=
 =?us-ascii?Q?M74QZ+LywRZsCX7aM0d9QQ5xL6eHSPTlBDUYQwXQfWUXBzVBdVQ2l2BWV/AU?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be66cea-ec7e-4bf4-eb4d-08dd7841b534
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 15:09:36.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k178v98aGGySDYu3Y8bV7w1MKMkjVs0vhrIGR5hOpKmgMnD8c9T9gc+Eo7zvW0fjOjdoEzQb0sgqENKcLU8yvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6347
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:52PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Implement a per-queue pool of action STEs that match STEs can link to,
> regardless of matcher.
> 
> The code relies on hints to optimize whether a given rule is added to
> rx-only, tx-only or both. Correspondingly, action STEs need to be added
> to different RTC for ingress or egress paths. For rx-and-tx rules, the
> current rule implementation dictates that the offsets for a given rule
> must be the same in both RTCs.
> 
> To avoid wasting STEs, each action STE pool element holds 3 pools:
> rx-only, tx-only, and rx-and-tx, corresponding to the possible values of
> the pool optimization enum. The implementation then chooses at rule
> creation / update which of these elements to allocate from.
> 
> Each element holds multiple action STE tables, which wrap an RTC, an STE
> range, the logic to buddy-allocate offsets from the range, and an STC
> that allows match STEs to point to this table. When allocating offsets
> from an element, we iterate through available action STE tables and, if
> needed, create a new table.
> 
> Similar to the previous implementation, this iteration does not free any
> resources. This is implemented in a subsequent patch.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

The patch looks OK to me. It corresponds with the idea described in the
cover letter and commit message.
No new issues found.

> +static int hws_action_ste_table_create_single_rtc(
> +	struct mlx5hws_context *ctx,
> +	struct mlx5hws_action_ste_table *action_tbl,
> +	enum mlx5hws_pool_optimize opt, size_t log_sz, bool tx)
> +{
> +	struct mlx5hws_cmd_rtc_create_attr rtc_attr = { 0 };
> +	u32 *rtc_id;
> +
> +	rtc_attr.log_depth = 0;
> +	rtc_attr.update_index_mode = MLX5_IFC_RTC_STE_UPDATE_MODE_BY_OFFSET;
> +	/* Action STEs use the default always hit definer. */
> +	rtc_attr.match_definer_0 = ctx->caps->trivial_match_definer;
> +	rtc_attr.is_frst_jumbo = false;
> +	rtc_attr.miss_ft_id = 0;
> +	rtc_attr.pd = ctx->pd_num;
> +	rtc_attr.ste_offset = 0;

As I mentioned in my review for patch #5, it's always zero.
Anyway, you've already said you're going to remove it in v2.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


