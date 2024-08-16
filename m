Return-Path: <linux-rdma+bounces-4386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E2954480
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B02228272C
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B2913D880;
	Fri, 16 Aug 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HFbg6Fgo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B78135A79;
	Fri, 16 Aug 2024 08:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797258; cv=fail; b=mEJU7/WKxA3eAnNT0ajuFK/jVIBOo7UvbvGfwbA84I+v4O3l7i9rNsU2jP37uC60013TJg88WnkPac1yf6RAaLx20bZblvT9aB6IFHawTeOT8hjpRW7dthwXVS7NCWQNX/xIspPYpgx+kCof0SZM2eRb5HiL+co72iPeHvBnmMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797258; c=relaxed/simple;
	bh=jT0kcHU7KX1olB091V4NyMe7O2ENoaT5lMwz6SYIDB0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UTTHXKYflOYCOLHgafDIH9PCRamWZ6pgQ+4mzssVXw+BWaNK4vNmR9QD0krszT271isy7w+HTeennog1Amn8NM33iLAH51pWan0dHpJiHS6ZtNwlDusOdLuCFtkI+jCeV+WQwjwcHmPqbcBFTOWGKtk7EFM3ifHLfvAE8DBPbb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HFbg6Fgo; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723797253; x=1755333253;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=jT0kcHU7KX1olB091V4NyMe7O2ENoaT5lMwz6SYIDB0=;
  b=HFbg6Fgo90IirxIfmVoziGw4dqZNi2XRApkcjz5WmChREMGXgAe5PoKL
   bSkazDV6Hpn3mp2VblLNOiKs0Qx/+u8LH0zpPDbPGbjg/kLuJNBBm6Ixc
   xWEs1sPaQUmGOFc5T19U+RneANS6NhA6pXuYo9l2HVvg54kP1v1BAkoOK
   z8Xvw42jV7P3YtqyDT+yKBzRQsKslnVUb5tEsU9spxWMZZjBnSv9NQlOT
   ccjO2D8UL6Gh2tLgtwIvLUG8bOQHu/xW+F8SOyJILVO5KelKMMFEq3TSb
   XBFPxjdKJCmTCJnIvHo76BQFdxBsWcrMJrxnY+MrRd/domyc6uDXyy0/A
   w==;
X-CSE-ConnectionGUID: v05pWpOjTXWXc2I9UpMkbw==
X-CSE-MsgGUID: 5E+4fJFuR86eEYvwMyE//w==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="39539152"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="39539152"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 01:34:12 -0700
X-CSE-ConnectionGUID: xuCNOWUZSJuyq+Xjo3R1DA==
X-CSE-MsgGUID: AHSBRDCkRV6OoupiIxx5yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59291592"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 01:34:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 01:34:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 01:34:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 01:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9XdszUGxvknN6u0uAOo5nXoe6aep1W+Kke2rll9qYoNNnN6AQD83fawy8eR1rFdwOb5yKEZxJamXCpfYCDqHXghD4Icr7LAbgXKWwSxzqjAAReWCo08EgdGX/bx9xc49IDyA/xqXOiob8pI282GGi/2+0OrtBpvMYdAYRK/3nY3/Xf7xO7eVha/8wRfPR2UQyg97epdyPdaa2Ly6ioollV5I7M6llwG9Yhz9qcu/ZEotfEZAFrZZQoMaUCXFeqOxtpfQCM5b2QZpIDkFBSIfxbCUAiChi/tY/MSnDDxa7lvi9xgW2WJRf6+XoVuRaFObUXo/Fdgy0+zrBaYkKA0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkzTIEkf90fke057AiNbz4N62MeNsP0yRtYLRrX4Ks0=;
 b=n0YQ1JHNOlfCgpWK9HbnRZd2EFPgpvo2IwVbtERIGJKxK82gWZTzi7Pp29KHdm0nhWhwDG6waa+0FEOAi6jOPp8rM1l4F5hXcUssPzKgukkdlh1oiO/SjQ6c9fi9InV2d3/GibYim0fZGAe3TAaVGKu/iT1fYk07OyDqWTzKRruMdb2rRn9dEH3MiyuqgJNljp0Wo6Ion7G4dVBg2ab8X919ORlu+Ifyn+zlAcpw4nhKDTj7qXEAp2z9MI3ZLqUd/gm/5aLxI9w3sEwQdLlxEO7vsISNDPpohj3SEWdtAErHVB7Jl2uvgHQB2ZRKTBgL/iTkwBJKZHagYEs0zj0dhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7368.namprd11.prod.outlook.com (2603:10b6:208:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 08:34:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.019; Fri, 16 Aug 2024
 08:34:02 +0000
Date: Fri, 16 Aug 2024 16:33:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Pirko
	<jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	<f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH net-next 4/5] devlink: embed driver's priv data callback
 param into devlink_resource
Message-ID: <202408161558.b256545a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240806143307.14839-5-przemyslaw.kitszel@intel.com>
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 82cb35fb-5604-4e31-83dc-08dcbdce2e37
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b40kFqM2Y9FA762l8Lrf9gIeccb3912imnEFYepx/J8oks8cwzPoqUTc7I5e?=
 =?us-ascii?Q?ZFebkizSZNvy+RO5D+2zI3cJ3K66hBR2FB3S5K+D8sMrwGWTZ2r2qzQaGeED?=
 =?us-ascii?Q?A264sOR5Ar5TZsWVJNt+g+hB1i4917U2KQ8lt7BNV1ZYL9Eu63ccveNWYjpU?=
 =?us-ascii?Q?RN4TGKSixdk/G/MfyzP+bZ7XGqUavC2KZE7Lp+bFbbA69tC79L6D3AA3gae9?=
 =?us-ascii?Q?Ub7zEzJ5Lvu2SsUkvB1K1Gpsc9JGrji/NVdUblYiearJo+uzRR/enfxRp3k/?=
 =?us-ascii?Q?1KFrGCkMC5tUTC0tnocflvzkeqfqgiC6htpHjccE+Ym7t/g7nbY1NFIsZJKk?=
 =?us-ascii?Q?7tFT/at+90ANojteM/8f1MC7nE0z8SJje7BOlemFTsJXvAj6TLU3uilbGuQj?=
 =?us-ascii?Q?oTjoOpogPA8Y8WLEUiDw7cpp6oh+iducTKubxUvu3sPC9ZjS5cupQNVIS2Ls?=
 =?us-ascii?Q?qbD7Nf/GhCpE3hYQNoVszTL6HnQ6JIHwl6rQZ5lT+Br36FLj1ZR5DDLY+9uG?=
 =?us-ascii?Q?4MLpNGPTKgJFN+xGUWO/ux3eIm6qddsBrmhSBiNE76Jw7Iaqfve6M+Zkk0Z3?=
 =?us-ascii?Q?UR5tzHSZ3m1IdSZbdPB0w0rdHp1E0TEil+4uLQMUBLJ0M1jGdTHc4jXRH2sS?=
 =?us-ascii?Q?0Qp2+pO1lYTRVF20zbtuZWDzA8DP+pFfSntLUNbceRx3fL73jfgLIaER57Na?=
 =?us-ascii?Q?onaYKm+o5w253KhxBJR4ak1GYy9otHhWphOMLLsOi6ucqXBIKOwgYWKxq8h7?=
 =?us-ascii?Q?PKrqI4cKK2Y5QUJLkYxcLyEWqGp0LnoBhbjlXRZ06aWrntefCDP015YL+oQc?=
 =?us-ascii?Q?LMKi/mnIe/6FFmBXReDXLfz+p4N7rFPCJiOP86IPPsEsL8sznwiVp4YkbXNc?=
 =?us-ascii?Q?pMHuXC7oZ9cP7bquCEArrxGfW7+XLDgwK2t/E7he7VwyqNKhMUmiEy/AZHol?=
 =?us-ascii?Q?eCUvLTVsoGPjmKMmqPAq3DMV1jONvp2ErqwgfrKwf76uOPrR7/1A41rx/4mb?=
 =?us-ascii?Q?rkknXnRkmA00XYcfgQ2gn6qfAqPKhXuyoAZ3aUNIsgc1KgGn78LJuasrC599?=
 =?us-ascii?Q?Hz8A5Fhu78iyRlbg8w1ZvQkq/Hs37rEZutqI/48WNuEIkjE0DUL0YXrBYCnw?=
 =?us-ascii?Q?lJ7iZrZVCWmKD14l4xCfIMkekGp8oIghwpCM4bww2NCaL55WCN6I343JEIwN?=
 =?us-ascii?Q?/hdmUuUDTyTENU/E3Gcv1gpVCobzpkvzkJgAj03kxbCvl3ccRaNnNXRouMhW?=
 =?us-ascii?Q?mqck6Wm8EPq4EwrhwX0IxUnOFeImbNpwbdrPsbT4GdH2OjHZqmeiUuszkF+b?=
 =?us-ascii?Q?ngE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ecj9yCxmZT1SZPkQKdaW+d7PJ5gLBkHPwjBoFXqmNQ1gmiNlNXKfUnAjlQ4S?=
 =?us-ascii?Q?W0DbogPxpgYnLJZlirGWNJDyUNkElpxGCSYvsQECZZ8w1SYBCNS1WmfP+9zA?=
 =?us-ascii?Q?BdWZMLACxRx6xB7KgRa8Lvm8ZideJDzP9Pt19gAaBOPHtqLK53x/MojgK/VS?=
 =?us-ascii?Q?Sfh9EI+Ddx5BEmdCxiHpQZ8K7q9O/unZMXB4ZY8jUdp3l9rqX3RN09LKdvaL?=
 =?us-ascii?Q?RfN8zh57shBHG/CALxeeTfXiyAJd5GcEBtZ16pzUOuVqyiHvtdQciCzLg8u1?=
 =?us-ascii?Q?xICXAfxxZ2mL932DKx9wW7hUdRgzzmf9L6JciSNSmiwA8ccbTvLRp++NJUpE?=
 =?us-ascii?Q?jP7fq5dDmfu6sxWM61QLannLFVC6qWKbv6q4uQr0xOY6LIfGcEYCMujHBi+p?=
 =?us-ascii?Q?5mKN5wAlbA2FA+9VUqKkT/T2u6WCo1Uc76tryUAEJccU2dADFC/7tFWz247y?=
 =?us-ascii?Q?uqz3NDpZ4MWL3qa78dSJqqA8IcHqj/2fVGFvATiH5NhjBlSn3qayr+wlFu4o?=
 =?us-ascii?Q?hogilFyxbIEsJ8v+LiUOCia+coHuKSvyyhOxpfc2gaRPr9i9kygkSECvlzDh?=
 =?us-ascii?Q?ZrgT5XMeKtDsNxuF5RSn3dlh3Ow1+Vtv+zyf85uMO0bKo2id7KJg71jqcBLB?=
 =?us-ascii?Q?HnZggx+bEcLGt4UKIO0UvLZnYz7v4HkY7TB1NLlr+m8cGyKQA1v0GK3AAxNZ?=
 =?us-ascii?Q?+MDI2Wrn6ywVOhgmjT7wp7wKruGOWH1Xs+5oITSQHE/j6fhWscolpmA3Rqfv?=
 =?us-ascii?Q?GTUtMLOAJsTBHNb2NrRHMbET5nGTR9uFx7W6iq7NGxQyVH/s9YPoYqHaxKdj?=
 =?us-ascii?Q?xFZ/+m8z7RioaPUzrXemL+3gLJ7D9k8VL/xxvkEniw2i/99osv8M6oJ9nk+v?=
 =?us-ascii?Q?yFAId1np/BteMqwg49M/SYh1OjvDNlvK7FLCpOVwQfTTbpC3ufiNzqzGvJOZ?=
 =?us-ascii?Q?yvR2Pav4CmS8XfRvfhu5B8AzjvlMbTZ8uA8XfKPa76Unq5V7Kh6jFBKd8Glw?=
 =?us-ascii?Q?a7Z3YIJanFr4/16NJiXqIyl6Ju11ZqEcgeQWUi75ofzSGGm26wIHkLz1qSlb?=
 =?us-ascii?Q?KGqyhtPjVujjUd8XmCLt58BzAWr1XCVrKIpfmEEjT6LBn4t4dR+mpCpmfiTm?=
 =?us-ascii?Q?9wgOkmpf5ZVuDFfziVGcwgadv5uRfISHhfAWQHEsw4QSrala0AlVOsko1+8y?=
 =?us-ascii?Q?8nY+36Cuarn9ezOfycO6XX6my67S4AjcOYIu52gh8kh1bUxQF4wm9yILvN3L?=
 =?us-ascii?Q?FlnVrJ++7Q4rMrLV9a4YyQgq4ejyyHAM48AJZudy2E6smNWmGk1cNQ84rx5r?=
 =?us-ascii?Q?110ud/IVWBmDhfdKNSagRg8kFa4Ni+B/mqXZPjhBVCIxWuvpb+ouNgNd48L6?=
 =?us-ascii?Q?oco2mnxuR9OEabLuU6h7gI7P/ILll3NdpDFucQKVyB0YsvH/MV5+Ebp3Zia3?=
 =?us-ascii?Q?Nf7RuHziKrunW8tDmezvJNCLrRbsk+Ayla2oJHYipot/ZMue1H0Wu+217nmO?=
 =?us-ascii?Q?yZLjYlSVpgXtaJdBeWNGl0T0suTywnqUopZ1tng/5n1nEFCUsNkUXRzC3VUs?=
 =?us-ascii?Q?eHPyxC9cAOknAkuyZ/5Ww1tBAq2y/3LIH/T94mCsJULLuGIXjZPcu3WN8B4W?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82cb35fb-5604-4e31-83dc-08dcbdce2e37
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 08:34:01.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AxgLacfmSY0QoZesmLhjLh0xwt62I5uwb+7rJRKT3Iv4qrikFS1nLdwixr1YCjx7FNTbcJHpBKdUMNVx1t2pcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7368
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_net/devlink/resource.c:#devl_resource_occ_get_register" on:

commit: ee141889828a13aa804849ebda6af39d6a8ebf87 ("[PATCH net-next 4/5] devlink: embed driver's priv data callback param into devlink_resource")
url: https://github.com/intel-lab-lkp/linux/commits/Przemek-Kitszel/net-dsa-replace-devlink-resource-registration-calls-by-devl_-variants/20240806-224519
patch link: https://lore.kernel.org/all/20240806143307.14839-5-przemyslaw.kitszel@intel.com/
patch subject: [PATCH net-next 4/5] devlink: embed driver's priv data callback param into devlink_resource

in testcase: kernel-selftests-bpf
version: 
with following parameters:

	group: net



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408161558.b256545a-lkp@intel.com


kern  :warn  : [   81.007570] ------------[ cut here ]------------
kern :warn : [   81.008076] WARNING: CPU: 18 PID: 7588 at net/devlink/resource.c:484 devl_resource_occ_get_register (net/devlink/resource.c:484) 
kern  :warn  : [   81.009035] Modules linked in: netdevsim macsec vxlan 8021q garp mrp bridge stp llc ip6_gre ip_gre gre cls_u32 sch_htb macvtap macvlan tap dummy tun nf_conntrack_broadcast fou ip_tunnel ip6_udp_tunnel udp_tunnel rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver netconsole openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 psample ipmi_devintf ipmi_msghandler binfmt_misc intel_rapl_msr intel_rapl_common btrfs skx_edac_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp blake2b_generic coretemp xor zstd_compress kvm_intel kvm raid6_pq crct10dif_pclmul crc32_pclmul libcrc32c crc32c_intel ghash_clmulni_intel sha512_ssse3 rapl intel_cstate ahci libahci wmi_bmof intel_wmi_thunderbolt nvme mxm_wmi mei_me libata intel_uncore nvme_core mei ioatdma wdat_wdt dca wmi drm dm_mod fuse ip_tables x_tables sch_fq_codel [last unloaded: test_bpf]
kern  :warn  : [   81.015492] CPU: 18 UID: 0 PID: 7588 Comm: rtnetlink.sh Tainted: G S                 6.11.0-rc1-00254-gee141889828a #1
kern  :warn  : [   81.016497] Tainted: [S]=CPU_OUT_OF_SPEC
kern  :warn  : [   81.016936] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern :warn : [   81.017853] RIP: 0010:devl_resource_occ_get_register (net/devlink/resource.c:484) 
kern :warn : [ 81.018451] Code: b0 4d 89 c5 49 3b 5e 08 74 35 48 89 da 4c 89 f6 48 89 ef e8 34 fa ff ff 48 85 c0 75 59 49 8b 46 50 4c 8d 70 b0 49 39 c4 75 da <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 4d
All code
========
   0:	b0 4d                	mov    $0x4d,%al
   2:	89 c5                	mov    %eax,%ebp
   4:	49 3b 5e 08          	cmp    0x8(%r14),%rbx
   8:	74 35                	je     0x3f
   a:	48 89 da             	mov    %rbx,%rdx
   d:	4c 89 f6             	mov    %r14,%rsi
  10:	48 89 ef             	mov    %rbp,%rdi
  13:	e8 34 fa ff ff       	call   0xfffffffffffffa4c
  18:	48 85 c0             	test   %rax,%rax
  1b:	75 59                	jne    0x76
  1d:	49 8b 46 50          	mov    0x50(%r14),%rax
  21:	4c 8d 70 b0          	lea    -0x50(%rax),%r14
  25:	49 39 c4             	cmp    %rax,%r12
  28:	75 da                	jne    0x4
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 83 c4 08          	add    $0x8,%rsp
  30:	5b                   	pop    %rbx
  31:	5d                   	pop    %rbp
  32:	41 5c                	pop    %r12
  34:	41 5d                	pop    %r13
  36:	41 5e                	pop    %r14
  38:	41 5f                	pop    %r15
  3a:	c3                   	ret
  3b:	cc                   	int3
  3c:	cc                   	int3
  3d:	cc                   	int3
  3e:	cc                   	int3
  3f:	4d                   	rex.WRB

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 83 c4 08          	add    $0x8,%rsp
   6:	5b                   	pop    %rbx
   7:	5d                   	pop    %rbp
   8:	41 5c                	pop    %r12
   a:	41 5d                	pop    %r13
   c:	41 5e                	pop    %r14
   e:	41 5f                	pop    %r15
  10:	c3                   	ret
  11:	cc                   	int3
  12:	cc                   	int3
  13:	cc                   	int3
  14:	cc                   	int3
  15:	4d                   	rex.WRB
kern  :warn  : [   81.020118] RSP: 0018:ffffc90001a53b70 EFLAGS: 00010293
kern  :warn  : [   81.020662] RAX: ffff8888753fd400 RBX: 0000000000000002 RCX: ffff888894939048
kern  :warn  : [   81.021374] RDX: ffff8888753fd060 RSI: ffff8888753fd000 RDI: ffff888894939048
kern  :warn  : [   81.022085] RBP: ffff888894939000 R08: 0000000000000008 R09: 0000000000000000
kern  :warn  : [   81.022795] R10: ffff8888753fd400 R11: 000000008b95c1e3 R12: ffff888894939048
kern  :warn  : [   81.023510] R13: 0000000000000008 R14: ffff8888753fd400 R15: ffffffffc0e37800
kern  :warn  : [   81.024222] FS:  00007f0d9d0e9c40(0000) GS:ffff88889f500000(0000) knlGS:0000000000000000
kern  :warn  : [   81.025012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [   81.025599] CR2: 00005612292a7cd0 CR3: 0000000870ece002 CR4: 00000000003706f0
kern  :warn  : [   81.026311] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [   81.027022] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kern  :warn  : [   81.027731] Call Trace:
kern  :warn  : [   81.028052]  <TASK>
kern :warn : [   81.028344] ? __warn (kernel/panic.c:735) 
kern :warn : [   81.028728] ? devl_resource_occ_get_register (net/devlink/resource.c:484) 
kern :warn : [   81.029275] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [   81.029694] ? handle_bug (arch/x86/kernel/traps.c:239) 
kern :warn : [   81.030102] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
kern :warn : [   81.030534] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
kern :warn : [   81.031000] ? __pfx_nsim_fib_ipv4_resource_occ_get (drivers/net/netdevsim/fib.c:1422) netdevsim
kern :warn : [   81.031689] ? devl_resource_occ_get_register (net/devlink/resource.c:484) 
kern :warn : [   81.032238] nsim_fib_create (drivers/net/netdevsim/fib.c:1606) netdevsim
kern :warn : [   81.032765] nsim_drv_probe (drivers/net/netdevsim/dev.c:1583) netdevsim
kern :warn : [   81.033287] really_probe (drivers/base/dd.c:578 drivers/base/dd.c:657) 
kern :warn : [   81.033698] ? __pfx___device_attach_driver (drivers/base/dd.c:921) 
kern :warn : [   81.034232] __driver_probe_device (drivers/base/dd.c:799) 
kern :warn : [   81.034707] driver_probe_device (drivers/base/dd.c:830) 
kern :warn : [   81.035164] __device_attach_driver (drivers/base/dd.c:958) 
kern :warn : [   81.035646] bus_for_each_drv (drivers/base/bus.c:457) 
kern :warn : [   81.036083] __device_attach (drivers/base/dd.c:1031) 
kern :warn : [   81.036514] bus_probe_device (drivers/base/bus.c:532) 
kern :warn : [   81.036946] device_add (drivers/base/core.c:3686) 
kern :warn : [   81.037353] new_device_store (drivers/net/netdevsim/bus.c:443 drivers/net/netdevsim/bus.c:173) netdevsim
kern :warn : [   81.037886] kernfs_fop_write_iter (fs/kernfs/file.c:334) 
kern :warn : [   81.038373] vfs_write (fs/read_write.c:497 fs/read_write.c:590) 
kern :warn : [   81.038772] ksys_write (fs/read_write.c:644) 
kern :warn : [   81.039164] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83) 
kern :warn : [   81.039582] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
kern  :warn  : [   81.040116] RIP: 0033:0x7f0d9d1e3240
kern :warn : [ 81.040525] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
All code
========
   0:	40 00 48 8b          	rex add %cl,-0x75(%rax)
   4:	15 c1 9b 0d 00       	adc    $0xd9bc1,%eax
   9:	f7 d8                	neg    %eax
   b:	64 89 02             	mov    %eax,%fs:(%rdx)
   e:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  15:	eb b7                	jmp    0xffffffffffffffce
  17:	0f 1f 00             	nopl   (%rax)
  1a:	80 3d a1 23 0e 00 00 	cmpb   $0x0,0xe23a1(%rip)        # 0xe23c2
  21:	74 17                	je     0x3a
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	ret
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	ret
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240816/202408161558.b256545a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


