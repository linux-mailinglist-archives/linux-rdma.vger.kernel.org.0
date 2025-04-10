Return-Path: <linux-rdma+bounces-9339-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDA2A84A9E
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FFDE1BA00CD
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D61EDA02;
	Thu, 10 Apr 2025 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGe6nuqY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBB1C8FB5;
	Thu, 10 Apr 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744304548; cv=fail; b=FZjvBmnpM1xIHj5TJs90SomCKUOdvCE0ENHKY+aqRMkjLQDTHGp+QfBaDMbZRtaF7W3aXoFxWaFd0ySQ/M04zhwoz6wKLtJ34WHPALcJeP/lueRxslaleFf8QpOfaItGNxyJUh2b3HgweVPZNv8lRIACGpKxH7Jfodx6jfPyUz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744304548; c=relaxed/simple;
	bh=8cfgW+jRJfDWJOXYIe3HjJhBrABmdJjAMvbJcAMLDvI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=unZ1/6eRla8PiOPB4wSaBNJUkrjwNV7EW2JKwrxydSDvEiojf3FAlymVhT8bMaNke6yDdEPVUGO17ttTvoll2MyLmbIjfiV7ZBmxyZzzqnphmUBzXSTVgxq1n3pYSMYGaI5y1YUBM08OJ/RFVFngvZJpaXRCEbWbcWuJlAdmIJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGe6nuqY; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744304546; x=1775840546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8cfgW+jRJfDWJOXYIe3HjJhBrABmdJjAMvbJcAMLDvI=;
  b=FGe6nuqYDt06GcqQERdPwqnn2vIvT4dKCEoInImV/0CNvWRKIJtEgFmO
   bD9SXPRowapplqWsSYAYur+Uh6KcWGEJGOvXNcuuA3Km0Eh5dE0mO/LdU
   JrFf8FmcXvm5D5vM+4NChANSRTtIv2ZtI3RUCDTnXdJS0jPVeGbhiNLh1
   a/tZ7mtZExo+v2382ax0Kgp08V8LlwgXrCMzoCdp6woUhynpEEsc2/5j6
   jNfTXG+0p2pTCO+Ndo37VoHg8g4ESyjiqWtxdOnniwUFyltTr3bPiG/LF
   qOzqKLvfSNndlVR0/GRmF0/4CdTg37E/ScOg8TVnvg3j+1mQLsvXOJs5u
   g==;
X-CSE-ConnectionGUID: idnC0k8jT3mDujqpDgvaLw==
X-CSE-MsgGUID: jYA6crpoRAGRdwjlAUNQIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="56508093"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56508093"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:02:22 -0700
X-CSE-ConnectionGUID: lXOD1x/2RjywKUO/8OQaBA==
X-CSE-MsgGUID: txlUGZ+mRfO5kgRbLMnx2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="129302672"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 10:02:20 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 10:02:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 10:02:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 10:02:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUKusBVSRqUn4gCJ8/eR370vywLCynPflW8NXGqiqq93s0dMUpp+sJ/dZwRzDi8KfEGImQ5LNjKIaMtgqGCca4maETWUDNd0k+eZ1i5oSBJOrA4fdylnxqHVCN+tkCsjDdEfuHgPKPXG5GM5OxRHdRyJL05/BVjMoh0rtlkLALg5XLEO2DbDUODVvLSig0EsLhkptWnPDpr+lq9dK1BP6s1kjNP4CD1fRAViQdOsHnvops5WQyGGO71W38t3y+if6hkWaZEeFqXo2eu2OnbbAIwueKaZZHBUuLcAFkunc7/e2nIcy3gvI3SGmnj70RlbdXZ8pbfXYcqO2BWuDlaiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5GhFHYzvIiAogoiLQcscePueYJ9/giwYvCiDFHkScw=;
 b=XU36ZJDo4DyHQ3XB94MPFraZ0ablSOZ8q7ihLSHH32w8Xg32LtRmkPmMCWkMhYlbT4nDN9e9nlTWHkx12NKTZlMKCYRyFweGUj5CXze6gT9C7bWphzBSiiX0rjfl1opAwsOgdVMQWiOrkR8u2AtouEZ9eDo5/u21wr+IQKxXGE4+UTvh7mnX00BgbihG6Q7HOwb0avOFlrVWjxb9tFXYMDKDCF98WVfZTVDxuv/wEqH8+P0iux+T8nriFPkWVgCElwy61bLh14DPPXlNcxFndvb/OUMePmdSz06XDohD0h3Aixg71D67/0ZK6s4GNBFS5/B7egIVpVJNqXQqi+LWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 SA1PR11MB6685.namprd11.prod.outlook.com (2603:10b6:806:258::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 17:02:10 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 17:02:10 +0000
Date: Thu, 10 Apr 2025 19:01:58 +0200
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
Subject: Re: [PATCH net-next 10/12] net/mlx5: HWS, Cleanup matcher action STE
 table
Message-ID: <Z/f5hqMDh9eGd0Xc@localhost.localdomain>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
 <1744120856-341328-11-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1744120856-341328-11-git-send-email-tariqt@nvidia.com>
X-ClientProxiedBy: DUZPR01CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::15) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|SA1PR11MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: ece2b91e-f96f-43af-2180-08dd78516ecf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FISxMGkqvycfOYsBZRSx0PaMwxgSPFQ90moHik/P2KfZUurD/KtTWWne3XEl?=
 =?us-ascii?Q?e/GFrJ7wcua476VUxlMusel5aVgmpg2fFZbfWiayO0iDOqb3N4VIiwYar5KB?=
 =?us-ascii?Q?dVEffmEKXE24WdV90y0zS1csRAkEhZAfi4ofJNCcHwiaMVjxa9H/29WL341P?=
 =?us-ascii?Q?N99xbrNGtNwV5usDASsbfCioMJpTY+jdNtH/j6dTIa855D4Fx36YmpdkYEhR?=
 =?us-ascii?Q?wez87WIl7UfDV37Z3/s/ayNkqMNjA60RqPZ8PC2NDQC3mclarOZce0mMntET?=
 =?us-ascii?Q?hR9aCzwVvPHxLY5RUa/rPCId7goRrzDqFP1zQMC6fVSjkUqePMtiGpwOFiVa?=
 =?us-ascii?Q?YmKjPKJYvbElEXnhczC2Lv//1OQ+njUJNg0PL3fiek20CjCEu8+Dyo+D0H29?=
 =?us-ascii?Q?uHku1vLdtQEkzd1Gn6tYAFWgRchLGq1UqgjHU+kpOGpT2kc36U/cIxG6AUmt?=
 =?us-ascii?Q?yEFztotHSy1OAhbxS/kbVKLIdL4eaWv0uOFlmyv1eog5LsVoCQCKvBqdn0Af?=
 =?us-ascii?Q?nH8QSTydcZbysZYuBzczmOQHGKigYwCoBy6/o/ld3m9ES94FbHJqSougwO9Y?=
 =?us-ascii?Q?5z963T5hJboa4AIwknyPZimNREgrWEiGKyrlp7aKYRoINRKMTp7Z8fKs9NbM?=
 =?us-ascii?Q?KyzXwM4pbgD6X30aW2fUmYocKFz8bnKvGnBVYXkuLR6idYLxVbEjLLjdulm5?=
 =?us-ascii?Q?Ru7DH9bV1BUsqc7nPA4jPgmPnmMBAwtmlv6l50XMImu09qLChvyMNHqMAHKp?=
 =?us-ascii?Q?PNw/7a1XOnmq08q94PZuZTZtwnuQ0uqR/BYoHVuWTzfPZQSrInvY2b2U2OHq?=
 =?us-ascii?Q?wCXcwV01/zKdR2R/2FSFcPdMjCopwQoib1bqx91vsHOd/opqt05oTeXYwL4Z?=
 =?us-ascii?Q?m+Ay9zFvukq917dV67h/005DXT8Wvq9ILrWHhGlzP36Kf0NZcBxct8ex8CZL?=
 =?us-ascii?Q?mCO5Q9W2hevy5q0rRk3+G/p+6r3Ft2Gr3g9qEwbUPJc+xSbC92TJVRYI4Cd+?=
 =?us-ascii?Q?AVu7IaPsgfdBnMuOzw9BLRXllWHTUET8Sk3BBQzMcrWU6DTzB8YPxet2Di8D?=
 =?us-ascii?Q?BlxHtndkNM/Z7L/TX3cIsKjZ45Gh6lT1LCJAcmvf54gRU7auCOEy2Eq2XYLW?=
 =?us-ascii?Q?/tWMg0z2Eyl2yid9kwQLgzjCF5n4bWvmQA7VfaRTRHZLlWxjEhoGp9pSDaf/?=
 =?us-ascii?Q?BBLG0RIuzkUtmcUG5s6n5bazH+710lLp36XF3Ud55JEfs4sxm2n1RZ01XyxN?=
 =?us-ascii?Q?ST5ErREpZoZNkx/6cibMiR0bSVPXGz0HoVnFAdHfC3PMFSIKtURRo1HHq7/y?=
 =?us-ascii?Q?3FVtl3Ww/NZhlrtMcA3x1yCYdK5Pyerx7I08dpJdazfwYBvBEpNJPLLNAnT1?=
 =?us-ascii?Q?ecEgDkBBWI6nzC7yqcynEL18q4/L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hjpl+AarwyGahZ8FT8r/17qdVunu+XgxkJheQFi3lh329YLhtjZgzWXeItpd?=
 =?us-ascii?Q?RlITruV2ubFOuRzCvxeNc2DSgvez96lA+BTSQXqzp5daJGGNLk398CquaZrq?=
 =?us-ascii?Q?But5XSV2UQgK3ggY6/HB2etKqHsUu+5A1pS+1vWNb80Jr1V5kgrMIuwAQ/mz?=
 =?us-ascii?Q?7qEU6/WxPrYQj01sNnpm29dHXB1yBZAkO5cRUdpAwkoABwKmWdemrKUcSN2D?=
 =?us-ascii?Q?Z18oaKLu2kBl4lJGYBYBrd0IwzQvWpGyQGTeuUH6Tsh5HdTA8N3BF5DU0gPu?=
 =?us-ascii?Q?udPPZTEaKeLy9YOXEJcfmCLBsKjyqLvvOZPHPqON7RCPpXZQl7twihkz3pyW?=
 =?us-ascii?Q?pJ773zPd0fBUtjch/WcZlR9qoJxNX8o/9EE42Vx3iQo7fgtCAVc//UDzYFAW?=
 =?us-ascii?Q?ovKUNhJ6Thd++g0BEIFKpyUnZzpyNU5ZKp/yJ0uXLmYoFsS1rBTrGF/kuqqz?=
 =?us-ascii?Q?HRAxUkP3AR7o/7jhrkiKr64YIcVLxSeNJ9qe3dG8oKUce54jXZ8wA5+MJV/s?=
 =?us-ascii?Q?C+JSYY28I7s/dud4U1gMrzi7esCe591ivIjGBGGNNOmmboLT4rQazBeBUPQr?=
 =?us-ascii?Q?HNr9g73PyG8MK0Nx9e3GBnjcF5ZEuAj6dfxODhu0mb/ntdt7mphrCSsQqifT?=
 =?us-ascii?Q?Wv8kAH4pkFMCovzNuAOMS3wNhWFwUnXvdwrieWPI8iyJsHXdspGJ0HjCMMPn?=
 =?us-ascii?Q?zdCmsRL+Sf7Zo+hwIv05L2LDgK9hwHlQM0trYTeHPgZ3RyqkYzrWTxGCHh5L?=
 =?us-ascii?Q?r7jjm7+Iu+R7D9F+hmlMfVwXv/jL59W/nWxRxWAyy0NHD/afftKL43gYgzMv?=
 =?us-ascii?Q?9hOVgz1l/hRf8QWCsTOrcUzmTJkDOTmy5uVItlweWCsWZcg5UOuU/dCKJLH5?=
 =?us-ascii?Q?Vzu2Ap6WbcBp9mQ3/uJqRUCAGU/TV2Ad2tMZebFRJVmJHzUHYanRqwUMapPI?=
 =?us-ascii?Q?pTlEogMOEObc6oZ6rx9cF0zpMvyKCP5qTaQYqWlm58Tsy5bMjbn1xG+ENot7?=
 =?us-ascii?Q?L0nbrcO4t63NWsqghuEJBO5x/AXc5Ob5rkdtZPuch5XaUyUboSsgObABThOQ?=
 =?us-ascii?Q?JO/+ZeE60Cu+7hRmPaIC0dP5ap6Q/5kv0+I9pqtNw48GNTIPmfmG4naqogQ5?=
 =?us-ascii?Q?mic0FG0UahRY55ZZVUCRXMHlfAauG+8yEO8LazP3zIzQCguqDEg1/R3lfedI?=
 =?us-ascii?Q?omrrbi5syUDP4vY0ViWg5wFQDJqT4M2WnFXPHhhxJGCsi5rzMahBO3KoJtlt?=
 =?us-ascii?Q?zs1sTTZ+dQ4XH/gMPrt097cIp5QbG4A1PJxd9pOfQlp+z3wZ9Wt3Op2wVLBG?=
 =?us-ascii?Q?/6TNC6nKBnAw9dT6+JgIytzqzlpWBsQNGmgd4cQf5QDs8Aq+CCFnBHgInbOC?=
 =?us-ascii?Q?UOVRlQGif2n6hivA5uwz0vFdJDQBKbCW7y2yW77ukwkW/Y5ErjFOI41W/A24?=
 =?us-ascii?Q?95iUxSL+AOzhxTlESXsTsxo170Ox7QcP+ww8bRwIJNZ4dsoedMmXBLiEikms?=
 =?us-ascii?Q?CLI6AFaFtzgnRLeDynn9x9rE+YuOHxZL+M2jpztbncyM6iuLK/Yaxvno0/Ol?=
 =?us-ascii?Q?7drZwZhLXWcsyjq9qUmCNowMfZMf3Tx8ud34dtwaPAUJMIT9jdL0MYtKaKp8?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ece2b91e-f96f-43af-2180-08dd78516ecf
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 17:02:10.4940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf2wEpnu6IHaW+TTt8ZXeGCjgS4kWvxa1mgnSexZloOufMVJUbDvV3g43cwgEtl8SU4lqG8PToVmjzSIWiKmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6685
X-OriginatorOrg: intel.com

On Tue, Apr 08, 2025 at 05:00:54PM +0300, Tariq Toukan wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Remove the matcher action STE implementation now that the code uses
> per-queue action STE pools. This also allows simplifying matcher code
> because it is now only handling a single type of RTC/STE.
> 
> The matcher resize data is also going away. Matchers were saving old
> action STE data because the rules still used it, but now that data lives
> in the action STE pool and is no longer coupled to a matcher.
> 
> Furthermore, matchers no longer need to rehash a due to action template
> addition.  If a new action template needs more action STEs, we simply
> update the matcher's num_of_action_stes and future rules will allocate
> the correct number. Existing rules are unaffected by such an operation
> and can continue to use their existing action STEs.
> 
> The range action was using the matcher action STE implementation, but
> there was no reason to do this other than the container fitting the
> purpose. Extract that information to a separate structure.
> 
> Finally, stop dumping per-matcher information about action RTCs,
> because they no longer exist. A later patch in this series will add
> support for dumping action STE pools.
> 
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/steering/hws/action.c  |  23 +-
>  .../mellanox/mlx5/core/steering/hws/action.h  |   8 +-
>  .../mellanox/mlx5/core/steering/hws/bwc.c     |  77 +---
>  .../mellanox/mlx5/core/steering/hws/debug.c   |  17 +-
>  .../mellanox/mlx5/core/steering/hws/matcher.c | 336 ++++--------------
>  .../mellanox/mlx5/core/steering/hws/matcher.h |  20 +-
>  .../mellanox/mlx5/core/steering/hws/mlx5hws.h |   5 +-
>  .../mellanox/mlx5/core/steering/hws/rule.c    |   2 +-
>  8 files changed, 87 insertions(+), 401 deletions(-)
> 


[...]

> @@ -803,7 +778,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  	struct mlx5hws_rule_attr rule_attr;
>  	struct mutex *queue_lock; /* Protect the queue */
>  	u32 num_of_rules;
> -	bool need_rehash;

This flag (and the function parameter below) were added in the Patch #1 as part
of the fix for unnecessary rehashing. Now it is removed again.
Is this fix really necessary for this series to somehow make it consistent?
Maybe Patch #1 should go separately as an independent fix in the "net"
tree? What do you think?

>  	int ret = 0;
>  	int at_idx;
>  
> @@ -830,30 +804,11 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
>  		at_idx = bwc_matcher->num_of_at - 1;
>  
>  		ret = mlx5hws_matcher_attach_at(bwc_matcher->matcher,
> -						bwc_matcher->at[at_idx],
> -						&need_rehash);
> +						bwc_matcher->at[at_idx]);
>  		if (unlikely(ret)) {
>  			hws_bwc_unlock_all_queues(ctx);
>  			return ret;
>  		}
> -		if (unlikely(need_rehash)) {
> -			/* The new action template requires more action STEs.
> -			 * Need to attempt creating new matcher with all
> -			 * the action templates, including the new one.
> -			 */

[...]

Thanks,
Michal


